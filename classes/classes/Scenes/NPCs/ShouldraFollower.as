package classes.Scenes.NPCs{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;

	public class ShouldraFollower extends NPCAwareContent {

	public function ShouldraFollower()
	{
	}

	/*Follower Shouldra tracks hours since her last fuck, similar to Exgartuan. Each sex scene involving her resets this counter and also puts her to "sleep" (length of sleep at least 16 hours). Shouldra will gradually fuck with the PC the longer they go without involving her in sex (length of time below)*/

//const GENDERLESS_MASTURBATION_WITH_GHOST_COUNT:int = 511;
//const SHOULDRA_TONGUE_LICKS_TIMES:int = 512;
//const SHOULDRA_FOLLOWER_STATE:int = 513;
//const SHOULDRA_PLOT_LEVEL:int = 514;
//const SHOULDRA_TALK_NEEDED:int = 515;
//const SHOULDRA_PLOT_COUNTDOWN:int = 516;
//const SHOULDRA_SLEEP_TIMER:int = 517;
//const SHOULDRA_MAGIC_COOLDOWN:int = 518;
//const SHOULDRA_TIMES_NIGHT_RAPED_PC:int = 519;
//const SHOULDRA_EXGARTUDRAMA:int = 520;
//const SHOULDRA_BAKERY_TIMES:int = 521;
//const SHOULDRA_MET_VALA:int = 766;

override public function followerShouldra():Boolean {
	return flags[kFLAGS.SHOULDRA_FOLLOWER_STATE] == 1;
}
private function shouldraSleeping(changes:int = 0, reset:Boolean = false):Boolean {
	//Adjust sleep timer
	if (reset) {
		flags[kFLAGS.SHOULDRA_SLEEP_TIMER] = changes;
	}
	else flags[kFLAGS.SHOULDRA_SLEEP_TIMER] += changes;
	if (flags[kFLAGS.SHOULDRA_SLEEP_TIMER] < 0) flags[kFLAGS.SHOULDRA_SLEEP_TIMER] = 0;
	if (flags[kFLAGS.SHOULDRA_SLEEP_TIMER] > 48) flags[kFLAGS.SHOULDRA_SLEEP_TIMER] = 48;
	//Is she sleeping?
	if (flags[kFLAGS.SHOULDRA_SLEEP_TIMER] > 0) return true;
	return false;	
}


//Initial Question
internal function initialShouldersRecruitment():void {
	clearOutput();
	spriteSelect(67);
	outputText("The ghost girl shows up far earlier than normal, this time around; you usually have to wait for her to make an appearance, but this time, it's as if she's seeking you.  You wait for her to say something, cast a spell, punch you in the face, anything.  She just keeps hesitating and glancing at you.  \"<i>Say,</i>\" she begins nervously, \"<i>...what would you say to us... hanging out some more?  Like, I mean... you know, me going with you.  Doing stuff and things.  That might be... nice...</i>\"");
	outputText("\n\nIt seems like she isn't looking forward to at least one of the possible answers.  Is she asking to come along with you?  She seems to want a response.  <b>Do you want to let her tag along?</b>");
	doYesNo(recruitShouldraForCampSexyTimes,noFollowerShoulders);
}
//NO OF COURSE NOT THAT SHIT'S 2SCARY4ME
private function noFollowerShoulders():void {
	clearOutput();
	spriteSelect(67);
	outputText("Somewhat bluntly, you inform her of your lack of interest regarding having a ghostly tagalong.  Though she looks a bit disappointed, she nods, scuffing her shoes against the ground and huffing a little sigh.  \"<i>At least I'll see you later, hey?</i>\"");
	outputText("\n\nAt your confirmation, she flashes you a goofy and only slightly forced smile and starts back to her home.  Despite her joviality, you feel like you'll have to get into her good graces before she decides to pop the question again.");
	//Back to camp, encounter is reset to friendly status
	doNext(camp.returnToCampUseOneHour);
}

//YEAH BRO I AM ALL INTO THAT
private function recruitShouldraForCampSexyTimes():void {
	clearOutput();
	spriteSelect(67);
	outputText("After what you've been through, you'd be glad to let her come adventuring with you.  You let her know your thoughts, and her face brightens instantly.  \"<i>Awesome!</i>\" she exclaims, clapping her hands happily... then launching herself forward.  You brace for impact, but you needn't worry; she simply phases into you, quickly settling into the now-familiar frame.  For a moment, your eyes flash ghostly yellow, but the glow recedes to your natural eye color as she allows you full control.  \"<i>All set!</i>\" she says happily[if (hasCock = true) , already vying to stroke your wang through your [armor] despite her relinquished hold on your body].");
	outputText("\n\nYour new ghostly companion's spirits seem in top shape on your trek back to camp.  \"<i>Well, before anything else, we should get better acquainted,</i>\" the ghost girl suddenly and telepathically begins.  \"<i>For future reference, the name's Shouldra the Soul Taker. You can just call me Shouldra. Or Soul.</i>\" You begin to introduce yourself, but she muddles your thoughts for a moment, an effective interruption.  \"<i>I don't care. I'm gonna call you Champ.</i>\"");
	outputText("\n\nDoesn't seem you have much choice in the matter.  With a shrug, you keep strolling until you reach camp, and Shouldra promptly exits your body.  As she solidifies, however, you notice her hair, previously dark as jet, now shines with the achromatic luster of her ghostly form, complete with yellow eyes and too-pale lips.  You ask her about the change, but she just shrugs and chuckles.  \"<i>I don't have to care about looking normal anymore,</i>\" she says softly.  \"<i>I'm with you now.</i>\"");
	outputText("\n\nYou exchange quick smiles, but Shouldra's expression darkens.  \"<i>Ah, damn it, I forgot something,</i>\" she groans, making a fist and bopping herself on the temple.  \"<i>Stay cool while I get that, alright, Champ?  I'll be back by tomorrow morning.</i>\"  With that, she walks past you, striding with purpose back toward the lake and the town ruins.  You can't help but wonder what she must have forgotten that would be so important...");
	//{NOTHING REALLY HAS CHANGED UNTIL NEXT MORNING HERE WE GO}
	flags[kFLAGS.SHOULDRA_FOLLOWER_STATE] = .5;
	doNext(camp.returnToCampUseOneHour);
}

public function morningShouldraAlert():void {
	spriteSelect(67);
	outputText("\n\"<i>Yo, Champ!</i>\" a voice calls, stirring you from your sleep.  You grumble and sit up, rubbing the sleep from your eyes.  Shouldra's standing a few feet away from you, hands on hips and staring at you expectantly.  As soon as you slink out of bed, she slides up and wraps you in a big hug, gradually allowing herself to grow transparent and slide into you.  A few moments of adjustments later, you stretch, feeling the otherworldly presence gliding around your body.  \"<i>Alright, Champ,</i>\" Shouldra exclaims, \"<i>Let's paint this land white.</i>\"");
	outputText("\n\nTime to set out, you figure.");
	outputText("\n\n(<b>Gained Shouldra as a follower!</b>)");
	flags[kFLAGS.SHOULDRA_FOLLOWER_STATE] = 1;
	flags[kFLAGS.SHOULDRA_PLOT_COUNTDOWN] = 7;
	doNext(playerMenu);
}

//PC x Shouldra x Vala Threesome: Female Scene
//Add-on to the normal scene; Shouldra learns Vala's breastmilk makes things bigger, decides to return the favor. Obviously too drunk to know when to stop, Vala gets room-sized.
//Non-Corrupt Vala:
private function shouldraAndValaGetBigger():void {
	clearOutput();
	spriteSelect(67);
	if (flags[kFLAGS.SHOULDRA_MET_VALA] < 1) flags[kFLAGS.SHOULDRA_MET_VALA] = 1;
	outputText("You decide to make your way down to the Wet Bitch to introduce Vala to her.  A few minutes into your stay, you see the fairy serving a few tables while holding a tray filled with drinks and empty glasses.  Pointing her out, Shouldra gives a delighted squeal.");
	outputText("\n\n\"<i>She's adorable!  I think I have just the idea for that cute little thing...</i>\"");
	outputText("\n\nNot waiting for your go ahead, Shouldra takes control, quickly making a beeline for her.  Vala's eyes light up at your appearance, and she motions to an empty seat so that she can finish taking care of a few customers.  Shouldra refuses to wait, and grabs the fairy by the wrist, quickly dragging her out the back door.  The drinks Vala was carrying atop her tray crash to the floor as she's pulled out of the building. Once outside, the ghost begins pawing at the busty fairy, fondling any part of her she can get a hold of.  A slightly confused Vala starts to put up a fight, trying to push you away.");
	outputText("\n\n\"<i>H-hey now!  If you wanna have fun, let me clear it with the boss first!</i>\"");
	outputText("\n\nShouldra grows annoyed by her resistance, and places your hands at the sides of the fairy's face.");
	outputText("\n\n\"<i>I think you can stop talking for a little while...</i>\"");
	outputText("\n\nAs Vala opens her mouth to protest, Shouldra pulls her forward for a kiss.  The fairy struggles a bit as you invade her mouth, but she soon gives in, returning the kiss and intertwining her tongue with yours.  Caught up in the sudden embrace, you barely notice something extra sliding out of your mouth.  The fairy doesn't seem to notice it either at first, at least until Shouldra begins the possession.  The tiny girl begins shaking as Shouldra takes control, her eyes rolling back in her head while her tongue is still lodged firmly in your mouth.  Her body continues convulsing for a short while, the two women fighting for dominance of her body, until the shaking stops.  Vala's body goes limp, though oddly enough, her tongue still manages to move around languidly.");
	outputText("\n\nBefore you can try to pull away to make sure she's okay, her thin arms wrap back around you, resuming the necking with a renewed vigor.  After a few moments the possessed girl pulls away, leaving a thin strand of saliva connecting your lips.");
	outputText("\n\nWiping it away, Shouldra starts to smile.  She examines her new body, mashing her oversized breasts together, and pinching her sizable ass.  Satisfied with her new assets, she becomes slightly disappointed with the proportions of the rest of her body.");
	outputText("\n\n\"<i>Hmmm.  It's a bit harder to stay upright than I thought it would be.  Maybe a little spell can help...</i>\" She utters an incantation, sparks flying off her body as it begins to change shape.  She grows in size, getting larger and larger until her head is well above the roof of the building.  Examining her now cramped surroundings, the giant girl seems a little surprised at what happened.");
	outputText("\n\n\"<i>Oh, dear.  I think I messed that up a bit...</i>\"");
	outputText("\n\nLooking down at you, a devilish grin spreads across her face. You shrink away slightly at the sight, but before you can try to make a break for it, she reaches down and gently picks you up, placing you in her palm.");
	outputText("\n\n\"<i>Now then, where were we?</i>\"");
	outputText("\n\nShe nudges you with her forefinger, picking at your clothes with her nail in a vain attempt to undo the straps to your armor.");
	outputText("\n\n\"<i>Hey, undress real quick.  I just got another idea.</i>\"");
	outputText("\n\nBefore you can object, you realize that the size difference between you would make it pretty hard to resist her demand.  Deciding that it's safer to play along, you undress in short order, tossing your [armor] to the ground below.  After the last scrap of clothing is gone, she gives you a light tap that causes you to fall back on her hand.");
	menu();
	addButton(0,"Next",pureMacroValaCont);
	addButton(1,"Be A Toy",pureValaAndShouldraMacroMax);
}

private function pureMacroValaCont():void {
	clearOutput();
	spriteSelect(67);
	//Male:
	if (player.hasCock()) {
		outputText("Bringing you up near her face, she examines your body and begins pushing her scaled-up forefinger against your prick, pressing it back onto your stomach.  The sensation of the giant fairy's caress causes you to gasp, and you try to move the finger around in a vain attempt to relieve some of the pressure. Shouldra coos at your pathetic efforts and begins to softly rub up and down your dick with the pad of her finger.  The smoothness of her skin allows the ridges of her fingerprint to glide over with little friction, sending sharp spikes of pleasure each time one rubs over the crown of your cock.  Your hips begin to feebly shake beneath her digit, pre leaking out of you and covering the tip of her finger.  Waves of pleasure wash over you, and you begin to relax against her hand.  Her soft palm provides a wonderfully warm place to rest as her finger massages your cock, the sticky feeling of your pre-cum intensifying the sensations tenfold.  Your entire body begins to move with her finger, your back gliding around her palm from your body's sweat.  It becomes difficult to think, your feeble attempts at escape turning into feeble attempts at holding onto her fingertip.  As the ridges continue to goad you towards orgasm, you quicken your pace.  The specter, amused, merely holds her finger in place, allowing you to slide up and down, desperately rubbing against her in an effort to nut.  Before the moment of release can come, she peels you off with her thumb, pushing you back into the softness of her hand and leaving you shaking from the denial.");
		outputText("\n\n\"<i>Heh.  Look what you did!  Now my finger's all dirty...</i>\"");
		outputText("\n\nShouldra gives her finger a gentle lick, getting a good taste of the mess.  After smacking her tongue a bit, a small blush runs across her face, obviously turned on by the perverted taste.  She begins to suck on her finger like a lollipop, letting out wet, seductive sounds with every motion.  Her tongue dances around the tip, lapping up every bit of the sticky pre-cum you left behind.  The sight becomes too much to bear and you begin masturbating in an effort to relieve your frustration yourself.  The possessed fae peeks down at you with a half-lidded eye and takes the finger out with a wet *pop*, bringing you closer to her face.");
		outputText("\n\n\"<i>Well, I suppose I can't just ignore you when you get like that, can I?</i>\"  she says with a wide grin.");
		outputText("\n\nYou shake your head as hard as you can, desperate for a chance to relieve the pressure.  She brings you up to her lips and curls her tongue up towards your feet, guiding you into her mouth.  Each breath she takes engulfs your body in a warm, wet draft, wrapping around you like a hot blanket.  The comfortable sensation sends a chill up your spine, and your thoughts become momentarily blurred.  Slightly disorientated, you relax in the embrace of the surrounding heat, giving a long sigh as your legs begin to slip past the soft cushioning of her lips.  As more of you sinks into her mouth, you start shaking, the sensations spreading throughout your body far too much to handle.  Your dick slips past the soft barrier, eagerly greeted by the tip of her tongue, the rough, wet caress causing you to gasp as you are drawn further into her mouth.  Before you're past your neck she stops pulling you in, and begins using small sucking motions to adjust your position, making small, sucking motions that slide you around her mouth.");
		outputText("\n\nShouldra begins moving her tongue, sliding it along your entire front, the movement tossing your body around.  The rough sensation of her taste buds sliding across your body causes you to buck, but the soft seal of her lips prevents you from moving in or out any further.  Your moaning seems to encourage her. Looking to the side, you see the corners of her mouth drift up slightly to form a coy smile.  The unique texture of her mouth feels incredible against your body, and the odd feeling causes more pre to leak out from you.  Tasting your need, her tongue redoubles its efforts, moving in waves inside her hot, moist orifice, grinding against your lower body.  Trapped between her lips, you can only gasp and moan as she treats you like a hard candy.  The only semblance of thought you have is to enjoy these feelings as long as possible, and you try your hardest to keep from coming.  Becoming impatient, Shouldra forces your body against the roof of her mouth, grinding her tongue against your groin, curving it to better accommodate your dick.  Your mind goes blank from the intense, focused sensations, and feel your abs begin to clench from the coming orgasm.  You start to cry out from the stimulation, trapped in the soft, wet prison holding you.  Each push from her tongue brings you closer and closer to the edge, until finally it becomes too much.  Cum bubbles up in your shaft before violently gushing out against her waiting tongue.");
		outputText("\n\nShouldra moves Vala's tongue in a milking motion, rubbing its entirety against your length in an effort to squeeze it all out of you, every motion pushing you against the roof of her mouth as the spongy surface of her tongue wraps around your member.  Each undulation causes you to break even further, your already distant thoughts becoming hazier with each movement.  Eventually, the unseen torture stops and she draws you from her mouth.  Completely numb, you can only hang from her grasp, gasping as the cold air burns your lungs and makes your eyes water as you recover from the mind-shattering orgasm.  Through your confusion, you notice her bringing you close to her again.  She gently places you between her giant breasts, the soft skin sliding around your slick body lubricated by her saliva.  You sink into the depths of her cleavage, your dick gliding against her the entire way.  As you become completely encased in the soft prison, the stimulation proves too much, and you give a final, weak orgasm, still exhausted from the last release.  You sink into the warmth of her breasts as her heartbeat pounds a silent rhythm against your body and the remnants of your orgasm fade.  The last thing you notice is the swaying of her chest as she begins to go on the move.");
		outputText("\n\nYou wake up outside your camp...");
	}
	//Female:
	else {
		outputText("Her finger starts pressing firmly against your chest.  You try to push it away, but the size difference makes the effort futile.  The ghost girl starts grinding against your chest with her fingertip, the friction against your breasts causing a small gasp to escape your lips, and your nips to become slightly firmer.  She runs her pinky up your leg, stopping at your vagina, and you reflexively clench your legs together. Unfazed, Shouldra forces them back open with her fingers, exposing you to the open air.  A small breeze blows through, tickling your cunt and causing you to bite your lip.");
		outputText("\n\nThe specter looks you over, and lowers her finger towards your pussy.  She starts rubbing it gently, causing you to try to tense your legs up again, only for them to be pushed back to the sides.  Her finger begins to increase in pressure against your slit, sending a shock of pleasure.  You give a sharp cry at the sudden stimulation, much to the delight of your captor.  Your sex begins to moisten from her touch, allowing the finger to glide over you with little friction.  Your hips begin to rock back and forth in time with her motions, until soon you're practically dry humping the digit.  Shouldra gives a smile at the display as you start to wrap your legs around her finger, pushing it as hard as you can into your cunny.  The ridges on her fingerprint cause you to pant as they run across your lower lips, spiking the pleasure with each bump.  Soon, her finger is almost completely covered with your lube, glistening in the sunlight.  As you near a final release, the digit is suddenly pulled away from you.  You cry out for its return, but are only met with an amused gaze.  You start shaking from the urge to cum, but before you can take care of the problem yourself, the finger that was grinding against you is suddenly laid out on your chest, preventing you from moving your arms.");
		outputText("\n\n\"<i>You want to get off, right?</i>\"  You nod as hard as you can.  \"<i>Well first you have to clean up this mess you've made.  Getting my finger all dirty like that...</i>\" she says, her harsh words conflicting with the smile she gives you.");
		outputText("\n\nReacting almost on instinct, you wrap your arms around her digit and begin using your tongue to clean up. It glides all over the pad of her finger, tasting every inch that had been grinding against your cunt mere moments ago, and any thoughts of resistance are pushed away by the burning aching in your pussy.  After lapping up the final bits of feminine lube, you beg her to let you finish.  Shouldra smiles and wordlessly pinches you between her thumb and forefinger.  She brings you up to her mouth, sticking her tongue out, and guiding it to your slit.");
		outputText("\n\nThe tip of her tongue gives a quick lick across the lips, the feeling causing you to let out a sharp gasp... In a last ditch effort to resist, you bite your lower lip, but to no avail.  As soon as you do, she begins to move you up, sliding you along her tongue, your cunt rubbing against it every inch on the way.  The extended spike of pleasure almost instantly breaks you down, and the thought of losing yourself to the sensations becomes very appealing.  The moist heat from her breath causes you to involuntarily relax your waist, and a numbing spreads throughout your lower body, save for your now over-sensitive crotch.  As you try to moan, you find it catch in your throat.  As the tongue slides itself back and forth along your underside, you begin bucking, riding it like a wild mustang.  The orgasm you've been waiting for begins to rise, and looking down, you're surprised to see your legs shaking, completely unaware of any feeling coming from them.  As the tongue thrusts forward one last time, you go over the edge, letting out a muffled squeal of delight in place of moan.");
		outputText("\n\nThe tongue doesn't stop moving, causing your orgasm to ride itself out for over a full minute, each passing second amplifying the pleasure even further.  Even after it's over, the tongue doesn't stop.  Letting you ride it like an organic sybian, the bumps from the giantess's taste buds giving you chills.  Your eyes begin to roll back as you soon feel yourself begin to cum again.  For a second time, the relentless motions of the tongue extend the release out far longer than is normally possible.  Your head starts swimming in endorphins, and the only thing penetrating the dense fog of pleasure are the sensations around your cunt. You continue riding, cumming over and over again.");
		outputText("\n\nFive, six, seven times, you start to lose count.");
		outputText("\n\nAt one point you begin to black out from the sensations, but are quickly snapped out of it by the tip of her tongue poking at your entrance, playing with your rock hard clit.  It proves too much, and you come a final time before being pulled off and placed back on the giant fairy's palm.  You tremble from the experience, your mind in shambles.  Shouldra begins talking, but her voice is very distant, and shortly after being granted a reprieve from the pseudo-sexual torture, you pass out.");
		outputText("\n\nYou awaken for a second, still tired and numb, in a very dark, warm place.  A sweet musk of sweat enters your nose, and you feel soft walls gently pushing against you.  Before you can figure out what happened, you're lulled back into sleep by a gently pulsing thump near your ear.");
		outputText("\n\nYou wake up back at your camp...");
	}
	shouldraSleeping(10+rand(15),true);
	player.orgasm();
	doNext(camp.returnToCampUseOneHour);
}


//New option "Be A Toy" at end of "Non-Corrupt Vala" scene.
//Pass out and wake up back at camp for maximum awesome.
//Obviously the PC is carried in Vala's new pocket.
private function pureValaAndShouldraMacroMax():void {
	spriteSelect(67);
	clearOutput();
	player.slimeFeed();
	outputText("Before she can do anything, you shout out a rather unusual suggestion, though to you it sounds quite exciting.  Vala or Shouldra, whoever she is, smiles wickedly and nods, lifting you up towards the glittering gash between her legs.");
	outputText("\n\n\"<i>I didn't expect you to come up with such a great idea, Champ, but then again, great minds think alike!</i>\" you hear Shouldra comment through the faerie's soothing voice.");
	outputText("\n\nUp higher, you can see her puffy labia on display, glistening with moisture that's already beginning to bead on the quickly-flushing skin.  Indeed, her rosy pussy stands in stark contrast to the creamy white skin around it, visibly pulsing and engorging as you close in on it.  A moment later, your nude body makes contact with Vala's honey-pot, pressing against her lips, into her slit and all over her mons.  A sweet, slightly musky smell smears across you as you bump into the gigantic snatch, growing dizzy as the aroma overpowers your senses.  Almost immediately, you give yourself over to that steamy muff, happily stuffing your arms through her curtain-like lips and pulling them wide.  The dripping moisture oozing from the pink chasm seems to fog the very air, and before you can do anything else, a fair hand is clamping around your [legs] and tilting you forward, up and in...");
	outputText("\n\nYour vision goes pink as the channel devours you, sliming your hair with clear, female lubricants.  You can feel your shoulders sliding in after you, and in your excitement, you pull your arms in after, pushing and stroking the silky smooth walls as you explore the inner workings of the Vala's vagina.  You can see the flesh pulsate as you touch it, and after a few particularly successful gropes, the entire channel snaps closed around you, smothering you with pussy as it involuntarily clenches around you.  The entire thing vibrates with the faerie's moan, and she pushes the rest of you in faster, her giant clit bouncing over your [nipples] as she rams you in.");
	outputText("\n\nSoon, your body is engulfed up to your lower [legs], mired in pussy and lubricant.  It's like taking a bath in slime, only the bathtub is giving you a whole-body embrace, slipping, sliding, and taking pleasure from every motion you make.");
	if (player.gender > 0) {
		outputText("  Inspired by this, your own body has long since responded");
		if (player.hasCock()) outputText(", becoming firmly erect.  You happily piston your hips to grind your " + player.multiCockDescriptLight() + " along the pink-glossed walls, oozing your fluids in delight.");
		else outputText(", growing wet, though in this slick fluid, your contribution is a mere drop in the ocean.");
	}
	outputText("  The warm fleshy dream is abruptly ended as Shouldra yanks you out by your [feet].  \"<i>I'm gonna put you the whole way in.  Do me a solid and get me off a few times, will ya?</i>\"");
	
	outputText("\n\nDripping with her lusty leavings, you vigorously nod and crane your head back up to the randy passage.  Your plus-sized poltergeist wastes no time in returning you to her box's moist embrace, stuffing you most of the way in with a simple motion.  A finger as big as your [legs] pushes your [feet] the rest of the way inside, stuffing you so high up you bump your head on the narrow entrance of her womb.  It's dark inside her, but you quickly get to work, sliding and squirming around, humping your ");
	if (player.hasCock()) outputText(player.multiCockDescriptLight());
	else if (player.hasVagina()) outputText(player.vaginaDescript());
	else outputText("[butt]");
	outputText(" against the slick walls.  You push your way towards the pinkish slit in the distance begin to slide your [legs] over the inner edges of her lips, pressing your arms up above you for stability.");
	outputText("\n\nYou must have hit her g-spot, because as soon as you do, a rush of lady-spunk envelops you.  The walls squeeze around you, this time rippling in waves up and down your body, squeezing you affectionately as your temporary shelter vents thick flows of girl-goo all around you.  You hold onto the pulsing walls for dear life, moaning into the steamy cunt while it gives you a full-body massage.");
	if (player.hasCock()) {  
		outputText("  [EachCock] is quickly brought to orgasm by the exotic situation, and you fire off your own load into the deluge of sex-juice.");
		if (player.cumQ() >= 1000) outputText("  Somehow, you pour out almost as much spunk as Vala's orgasm, turning the inside of her honeypot into an off-white mess.");
	}
	else if (player.hasVagina()) {
		outputText("  Your [vagina] can scarcely resist the allure of the sweet, female flesh pressing against it, and with an explosion of hot bliss, you climax");
		if (player.wetness() >= 4) outputText(", squirting with joy");
		outputText(".");
	}
	outputText("\n\nSlowly, the tumultuous orgasm concludes, but no sooner than it finishes, your pink prison begins to sway back and forth.  The possessed faerie is walking somewhere!  Shouldra's face peeps out of the tunnel's soaked edge, illuminated by its own inner radiance.  She says, \"<i>Don't stop now, Champ!  You were doing so well!</i>\"  Her hand appears to flick one of your [nipples], and suddenly, your lust washes through you.  You try to grab hold of your ghost by the head to fuck her");
	if (player.gender == 0) outputText(" somehow");
	outputText(", but she vanishes with a high-pitched giggle.");
	
	outputText("\n\nDriven nearly mad by lust, you swing your [legs] out of the tunnel and wrap them around the faerie's embiggened clit, grinding yourself against the top of the twat with the added leverage.  Your hands grab hold of your [nipples] and tug, tweaking and twisting as you writhe in Vala's pretty, pink pussy.  Her sodden snatch has become your entire world, and you give your body and its lusts over to it, doing everything in your power to please and be pleased by the cavernous obsession.");
	outputText("\n\nThe swaying gait flexes your body to and fro as she moves, the bouncing, wiggling motion only adding to your irregular stimulation of her slit.  At least three times she stops and that tunnel goes tight around you, enveloping you in female flesh.  You lose yourself to it all, closing your eyes and subsuming yourself in pulsing... pink... pussy pleasure...  Though you manage to orgasm a few times as well, pleasing this gigantic cunt is infinitely more rewarding, and you get Vala's body off time after time, barely caring when you begin to lose consciousness from fatigue.  Even in slumber, you toss and turn, your body little more than an organic vibrator...");
	outputText("\n\nYou wake in your camp, still smelling faintly of Vala's vagina but fully dressed.  You flush a little from the smell, but otherwise feel rather well rested.");
	player.orgasm();
	dynStats("lib", .5);
	doNext(camp.returnToCampUseOneHour);
}




//corrupt vala
public function shouldraMeetsCorruptVala():void {
	spriteSelect(67);
	clearOutput();
	outputText("An idea strikes you as you gaze down at the chained-up fae creature.  You call to Shouldra, pointing her toward her newest toy.  You hear a delighted coo in your mind, and you feel the ghost inside of you take control.  The specter saunters up to Vala's helpless form, appraising the prisoner like a show dog. The bound creature gives little reaction as Shouldra fondles her unusually large breasts, and only gives a slight moan when the ghost parts her legs.  \"<i>Such an interesting little oddity!  Say what you want about those imps, but they sure can get awful creative when it comes to fucking.</i>\"");
	outputText("\n\nShe unchains the fairy, which seems to bring her back to the real world.  She looks up at you, and begins pawing at your armor, trying her best to take it off in her addled state.  \"<i>Bitch is happy Master came by!  Bitch will be a good girl for Master, so that Master can get off!</i>\"");
	outputText("\n\nShouldra tries and fails to hold back a chuckle at the pathetic display.  Using your hand, she pats the broken creature's head, before clasping at the sides of her face, bringing Vala's eyes up to hers.  \"<i>You poor thing... how about we give you a chance to have your own kind of fun for once?</i>\"");
	outputText("\n\nVala seems confused at her words, but as she opens her mouth to ask for clarification, Shouldra pulls her forward, locking your lips with the bewildered fairy's.  Though surprised, Vala quickly adapts and returns the kiss.  As you feel your tongue intertwine with Vala's, you notice a dull numbing sensation coming from your lips.  As Shouldra opens one of your eyes, you notice small blue sparks dancing around the spot where you're connected.  Regaining some control, you pull back, leaving Vala to continue darting her tongue in the air.  The blue sparks continue to appear on her mouth, spreading outward until her entire body is going off like a sparkler.  You hear devilish laughter echo throughout your head, soon followed by the ghost girl re-assuming control.");

	outputText("\n\nShouldra begins peeling off your [armor], keeping her gaze locked onto Vala as you helplessly watch the fae become engulfed in a dazzling blue light.  The silhouette formed from the glare begins growing, every part doubling, tripling, quadrupling in size before you, until eventually the light subsides, leaving only the new form of Vala as proof of its existence.  She looks much the same as before, albeit far, far larger.  Her seated form now takes up most of the room, even having to bend her head slightly from the ceiling.  Her exposed cunt could now take in an entire table, and her tits could now easily encompass your entire body, if she was inclined.");

	outputText("\n\nThe transformation seems to have had an effect on the fairy, as you see a steady stream of her honey beginning to pour out on the floor, forming a large puddle underneath her vag.  Vala quickly begins masturbating in an effort to satisfy the incredible jump in lust, and reaches for the numerous toys that were once used to achieve that end.  Her mouth gapes slightly in shock when she finds how tiny they now are in comparison, and her face turns red with a combination of anger and arousal.  \"<i>B-but Bitch is horny!  Why Bitch's toys so small?</i>\"");

	outputText("\n\nShouldra sashays up to the desperate creature, now completely naked, and begins rubbing the fairy's lower lips while mocking her.  \"<i>Awwwww, are you getting too big for your playthings now?</i>\"");
	
	outputText("\n\nAny protests the giant fairy makes are cut off by moans as the skilled strokes of your hands builds up her frustration even further.  Vala tries to form a coherent sentence between her animalistic noise.  \"<i>M-M-Master did this to Bitch... N-Now Bitch can't get off...</i>\"");

	outputText("\n\nShouldra stops massaging the fairy's cunt, simply standing there as the poor girl's juices flow around your feet.  You're too shocked to try to regain control, awestruck by the arousing and somewhat frightening change of the fairy before you.  Before you can snap out of it, Vala reaches down and grabs you in an enormous hand, lifting you up to her face.  \"<i>Somebody... somebody has to take care of Bitch's pussy!  Bitch needs to get off now!</i>\"");

	outputText("\n\nA squeal of delight echoes in your head as Vala begins lowering you down to her dripping cunt.  The heat washes over your body, tickling the surface of your skin in gentle waves.  Your feet begin sinking into the cushy, moist flesh of her cunny, sending out another stream of juice in response. A deep moan resounds throughout the cave as your legs become engulfed in her pussy.  You're able to slip in fairly easily, but once inside, her walls begin a gentle, tantalizing squeeze that seems to pulse with her every heartbeat.");
	if (player.hasCock()) outputText("  Your cock slips past the folds, pressed up against your stomach as the underside is massaged with the gentle tightness within.");
	outputText("  Once you're up to your chest, Vala stops, instead grasping your shoulders between her thumb and forefingers as she begins to gently slide you in and out of her.");

	outputText("\n\nEach motion sends a chill up your spine as the fairy uses you as a dildo.  Every time you're pushed back in, a torrent of fluids gushes out, washing you in her scent.  The smell makes you dizzy, and soon you find yourself moaning in time with her, with the ghost girl following soon after.  In your daze you notice your hands reaching out to grasp at the giant fairy's oversized clit. With Shouldra busy soaking in the sensations, you realize this must be your own doing, and the revelation ends what little resistance you were putting up before.  The sounds of your lower half being thrust in and out become the only thing you can focus on, each plunge bringing you closer and closer to your limit; you feel her walls around you become tighter and tighter as the fairy begins to near hers as well.  Soon, her pussy begins to spasm, the sharp motions sending you flying over the edge, releasing your seed into her oversized cunt.  The fairy gives a loud moan of satisfaction, and the geyser of resulting fluids sends you flying out of your soft prison, and into the now ankle pool below.  With the last bits of your strength, you manage to crawl out of the puddle, and bask in the satisfying feeling of release ebbing throughout your body.  As you lay on your side, you see feel Shouldra oozing out of your mouth, regaining her form beside you.");
	
	outputText("\n\nYou stare at each other for a little while, still half-drunk from the fragrant secretions that have filled up the room.  Looking over to the fae, you see Vala returned to her normal size as she weakly tries to redo the chains that held her.  Shouldra giggles again at the poor fairy, and tries her best to stand. Pulling you up, she helps you gather your things.");
	player.orgasm();
	shouldraSleeping(10+rand(15),true);
	doNext(playerMenu);
}

//PC x Shouldra x Sand Witch
//Male Scene
//Shouldra assumes direct control of sand witch.  Jokes about witches, ghosts, and needing a skeleton to complete the image are made.  Breast-related foreplay? Commence quad-terror titty fuck, complete with swelling PC dick.  Eventually envelopes player completely in the expected out of control moment.  Potential use for lust stones or save them for female scene.  Undecided.
public function sandWitchGetsGhostly():void {
	spriteSelect(67);
	clearOutput();
	if (player.hasCock() && (!player.hasVagina() || rand(2) == 0)) {
		outputText("As you admire your latest victory, a familiar specter pokes her head out from your torso.  The sand witch shuffles backward on the ground, her face an amalgamation of dread, confusion, and curiosity.  \"<i>What say we have a little fun with this one, eh, Champ?</i>\" Shouldra suggests, licking her lips in anticipation.  You wave an arm outwards, giving the antsy apparition the go ahead to pursue her prey.  The desert denizen unearths a second breath, climbing to her feet in an attempt to escape.  She doesn't make it too far before the ghost girl dives into her back, hurling the witch to the dunes.");
		outputText("\n\n\"<i>Get out of my head!</i>\" the sorceress screams, thrashing around in the sand clinging to her cranium.  She eventually calms down and faces you, her brown eyes now the customary glowing shade of yellow you've come to welcome.  \"<i>Now all we need is a skeleton, a wolf man, and some bats.  Then we'll have ourselves a holiday!</i>\" Shouldra jokes while climbing to her new feet, her voice replacing that of her quarry.  The ghost girl begins exploring the sand witch's body; it doesn't take long for her to fixate on the witch's quartet of lactating lovelies.  Reassured that the ghost girl is in control, you strip free of your [armor] and approach the bewitched witch.");
		outputText("\n\n\"<i>I haven't done anything yet and these factories are already working at over-capacity,</i>\" the spirit points out.  She takes a moment to jab a finger into one of the milky teats and samples her host's product.  Her reaction is like that of a gourmet chef enjoying a fine delicacy.  \"<i>Mmmm... invigorating.  But I think we can do something about the modest proportions of the source,</i>\" Shouldra teases, circling the witches' hands around the churning cantaloupes.  The ghost girl wastes no time in getting right to her own variety of spell casting, doing her best to keep from wavering as she continues to grope the sorceress' silos.");
		outputText("\n\nYou smile and shrug as you witness all four tits quickly climb up the brassiere measuring scale, easily gaining an extra couple of cup sizes.  Their perky stature defies all logic, as well; the size-obsessed ghost has never been one for realistic interpretations.  Tangentially, the length of the ghost girl's spell has you make a mental note.  It went on quite a bit long to be just for some ample augmentation.  \"<i>Now the question is what to do with these slobbering puppies,</i>\" Shouldra teases, reeling you in with a seducible gaze.  The two of you shuffle through the desert sands towards one another, the haunted witch throwing her arms over your shoulders.  Her churning funbags press tightly against your [fullChest], soaking you in her milk.");
		outputText("\n\nLips locked, the witch pushes you back into the sands, her modest frame jiggling around atop you.  The possessed witch's glare turns mischievous as you watch her breasts spread apart of their own accord.  The fleshy mountains then quickly scoop up your [cock], ");
		if (player.longestCockLength() < 18) outputText("completely smothering all around it in breastflesh.  The immense pressure sends tense shivers up your spine; your rod feels wonderful.  Things only escalate as the enchantress begins slowly thrusting back and forth, her massive mammaries working every inch of your shaft.  The heavenly stroking works so well, in fact, that you barely notice the head of your cock poke out from your partner's cleavage.  Your length and girth have increased substantially, enough for full-on quad-boob action.");
		else outputText("smothering all around it in breastflesh.  The immense pressure sends tense shivers up your spine; your rod feels wonderful.  Things only escalate as the enchantress begins slowly thrusting back and forth, her massive mammaries working your shaft.  The heavenly stroking works so well, in fact, that you barely notice your cock broadening within the embrace.  Your girth has increased substantially, still enough for full-on quad-boob action.");
		outputText("\n\n\"<i>Looks like the modified milk formula is doing the trick,</i>\" Shouldra says in between pants.  \"<i>Fine fun bags like these deserve a fine dick.  Now help me out here.  I only have one set of hands.</i>\" The sand witch mashes into her lower set of tits, motioning for you to grab the reigns of the upper pair hovering in front of your face.  Though you're certain she could easily handle the task on her own somehow, the thought of manhandling those muffins is too majestic to pass up.  Little time is wasted in your fervent grappling, your firm hold squeezing a moan out from the poltergeist.");
		outputText("\n\nFour hands, four boobs, more than enough to pleasure a man.  Not that that stops Shouldra from ramping things up even further, submerging your [cockHead] deep within the witch's gullet.  Your fingers dig into supple sandbags as your whole body tenses up, the salacious working of your giant prick dragging you closer to your climax.  Sensing your event horizon approaching, the ghost girl redoubles her efforts: her tongue explores every inch of your crow's nest while her fearsome foursome speed up their thrusting all along your mast, drenching your body in ever-increasing torrents of milky mayhem.");
		
		outputText("\n\nThe spirit's efforts don't stop there, however, as both her quad-knockers and your own fuck stick have started swelling again! Unable to take much more, you finally crack.  [if (cumNormal = true) \"Your modest load puffs the witch's cheeks a little, though it isn't anything the ghost can't make her handle\"][if (cumMedium = true) \"Your load smacks the hungry ghost fairly hard, enough to distend her cheeks as far as they'll go.\"][if (cumHigh = true) \"Your massive load just about knocks your cock free of the witch's mouth-hold, its strength distending her cheeks and neck as she works to contain it.\"][if (cumVeryHigh = true) \"  Your torrent of jism pushes the ghost girl to her limits.  It takes everything in her to keep from losing her mouth-hold on your cock as your blast distends her every feature.\"][if (cumExtreme = true)   Your supernatural cum summoning is too much, blasting the willing ghost clear from your cock.  Both of your faces are soaked by the oncoming torrent, mixing in with the already heaping helping of breastmilk surrounding the dunes.][if (cumExtreme = false)   Satisfied with your offering, the enchanted sand sorceress frees your [cockHead] from her maw.]");
		outputText("\n\nToo spent to keep up the continued pistoning of your partner, your hands slowly work their share of tata tissue.  As the conglomeration of flesh continues to swell, you feel as though your massaging is ill-equipped for such a task.  You peer over your burgeoning pole at the spooky seductress...  only to find her pallor has returned to the brown-eyed visage of the sand witch! And she's having the time of her life, it seems.  It only takes a few moments before your plumping pecker blocks your view of her, followed by your entire body drowning in massive milky pillows.");
		outputText("\n\nWorried for your safety, you reach deep down for a second wind - anything - to try and escape from the throbbing, soaking mess quad-terror.  Your prayers are answered as you feel the slick mass pushing you free, back into the open desert air.  Free from the hefty heifers, you dig into the muddy sand and pull free from the bulbous witch's grasp.  The most you manage to do is catch your breath and wipe your face clean best you can, watching Shouldra slowly emerge from the sand witch's back.");
		outputText("\n\n\"<i>Sorry, Champ.  Didn't mean to beach a whale on you,</i>\" she jeers, climbing down from the sand witch, still vigorously massaging her titanic titties.  You ask the ghost girl about her former host, \"<i>She was a good sport, so I figured I'd let her enjoy herself for a little longer,</i>\" she explains, resting her arms on your shoulder.  \"<i>It'll wear off on its own eventually.  I'm in no mood for free handouts today.</i>\" The specter smiles coyly, smacking around your still-vexed slab of meat between your legs.  \"<i>Speaking of wearing off, I'd like to enjoy this thing personally before it shrinks...</i>\" With a foreboding cackle, Shouldra hugs you and your cock, passing back into your body.  You're able to stall her long enough to retrieve your [armor], but the ghost girl quickly assumes control of your arms, manhandling your magnified monument.");
		outputText("Before returning to camp, you peer over your shoulder back at the sand witch.  Most likely overwhelmed with delight, the sandy blonde broad actually managed to pass out atop her four mammoth mammaries.  The sight rattles a chuckle free from you...  followed by a moan as your passenger works the tip of your enchanted dick.  The awkward trip back to base is sure to be a long one.");
	}
	else {
		//Female Scene
		//Shouldra harbinger's the sand witch.  Mild boob expansion.  Main attraction will be the sand witch's new foursome of nipplecunts, assaulted by a platoon of eager young lust stones (controlled by an insane poltergeist, thus shenanigans).  Meanwhile, facesitting on the PC as she goes to work on the dual vaginas, potentially with their own augments to mix things up.  Wholesome family fun.
		outputText("Shouldra pokes her head out from your torso, rubbing her hands together menacingly.  \"<i>So, we're going to have some fun with this little gal, aren't we, Champ?</i>\"  The sand witch is paralyzed with fright, able only to gaze at the bizarre spectacle before her.  Looking down at the shade sticking out of you, you see her hands now poised against your chest.  The ghost girl is ready to fly out at a moment's notice.  You decide not to keep her waiting and give her the go ahead; the force of her excited exit about throws you to the sandy ground.  The eager spirit quickly hammers into the witch, digging her sitting body into the sand.  There's a little struggling, but it isn't long until the ghost subdues her prey.");
		outputText("\n\n\"<i><b>I</b> always get what I want, dear.</i>\" mocks the ghost girl.  You resist the urge to roll your eyes as the sand witch turns to face you, her eyes that familiar glowing yellow hue.  You slip out of your [armor] as Shouldra rises the witch to her feet.  Rising her host's fist to her lips, it appears as if she's on the cusp of discovering something.  With a snap of her fingers, she mouths a familiar spell while drawing a circle in the air with an outstretched finger.  Just as it dawns on you what she's doing, a smooth and circular object flies up from the ground, along your [leg], and slips itself into your [vagina].  Without the adrenaline from combat to fuel you, the besiegement of your beaver melts you [if (isBiped = true) to your knees][if (isBiped = false) to the ground], helplessly grasping for the stone orb as it vibrates, pulsates, and even changes size within you.");
		outputText("\"<i>So, looks like this busty blonde is also some sort of summoner!</i>\" Shouldra remarks, happily watching as you squirm around on the sandy ground.  \"<i>Now, how best can I abuse this gal's power with my own?</i>\" she ponders aloud while groping the witch's four frantic milk factories.  As usual, she comes to a decision in short order, marking the occasion with a snap of her fingers.  The haunted sorceress' gaze hones in on your writhing body.  She pushes you over onto the warm desert sand with a light touch - in your state, you can't really offer much of a fight - and climbs up on top of you, gracing you with front row access to the witch's dual vaginas while dousing you in her never-ending flow of breast milk.  Unable to reach around to the aid of your own [vagina] while it endures its assault, you resist the mounting lust to best of your ability through controlled breathing.  In the meantime, all you can do is stare up at the possessed desert dweller as she hatches the next step in her inane scheme.");
		outputText("\n\nShouldra recites some manner of spell; by the inflection, you figure this is something from her wheelhouse rather than something mined from her host.  The incantation sends ripples through both sets of milk jugs.  You think they look a cup size larger, but the more obvious influence is on their nipples.  All four of the witch's teats puff up substantially, easily becoming just a little larger than your balled up fists.  The ghost girl continues her lengthy spell casting as she guides her host's hands into the upper pair of swelling, spewing teats.  It looks as though she's molding the pliable skin into something.");
		outputText("\n\n\"<i>Leave me alone!</i>\" the sand witch shouts, stealing control of her face back from her antagonizer.  Her head snaps to the side as the ghost regains control, resuming her spell.  It slowly becomes clear just what in the world she's doing: she's given the sand witch a healthy pair of thick, milk-dribbling nipplecunts.  It doesn't take her much time to get her lower pair up to speed, either.  The spirit performs some quality assurance, maneuvering haunted fingers along the moist walls of her chest-mounted hotbox.  The shivers up the witch's spine must mean that they've passed inspection.");
		outputText("\n\nNoticing that you're still in mid-peril - you've dug your fingers into the witch's thighs trying to resist the orb lodged in your [vagina] - Shouldra takes a break from her selfish desires to... well, to continue her selfish desires, honestly.  \"<i>Alright, Champ,</i>\" the possessed witch blusters, \"<i>I've got a little job for you.</i>\" She scooches further up your twitching body, resting on your [chest] and coating your upper body with her increased lactation.  With a quick spell, the sand witch's dual vaginas swell up ever so slightly, pressing against one another.  \"<i>You get to take care of this 'bi-snatch' of mine.  Don't let me down.</i>\"");
		outputText("\n\nHopeful that preoccupying yourself will better help you cope with what ails you, your hands quickly dart for the two love canals resting in front of your face.  The heat and fragrance emanating from them alone is already messing with your libido, however.  The witch moans with pleasure before resuming yet another lascivious spell.  You catch her making circles in the air; your legs instinctively clench shut even tighter than they already were.  However, it appears that the ghost girl has put her own twist to the sand witch's staple.  No less than eight stone orbs burst up from the surrounding sands, hovering in the air as they await instruction.  The conjurer's hands are hung in the air as if she were conducting an orchestra, and with an inward swing she directs her new friends directly into her welcoming nipplecunts.");
		outputText("\n\nShouldra would just melt right there on you if she could (you suspect that she really could, actually).  All four of the sand witch's howitzers bounce around and vibrate with glee as the spheres go to work.  The jostling is intense enough that you can feel the vibrations radiate down into your [chest], teasing you.  Looking up into her eyes, you can see the yellow effulgence dimming, revealing the caged witch inside fighting between feelings of appetence and apprehension.  Meanwhile, the greedy ghoul goes for seconds, casting the spell a second time; it takes her a few tries as the simple act of tracing a circle in the air in her state is made maybe five times more difficult.");
		outputText("\n\nAnother collection of spheres rise from the dirt, directed by the paranormal conductor.  With the vocal recital complete, Shouldra's concentration releases the witch's face, leaving her to grimace and moan helplessly as the rest of her body continues the performance.  The spirit sweeps her arms backwards, the orbs mimicking the action completely, congregating behind her.  Looks like she's satisfied with the frontal assault, you figure; she must be dying for some action on the other end.  She throws her arms forward in an arc and the orbs follow her order with haste.");
		outputText("\n\nHoly fucking...the cadre of sexual enablers instead charge deep into your [vagina] and [butt], taking you completely by surprise.  Your grasp on the poor sorceress' vaginas about smashes them together.  Instinctually, your [legs] clench tight, your [if (isBiped = true) knees][if (isBiped = false) form] rising up against the witch's back.  The possessed sand witch leans back, her hands sliding down your [legs] pinning [if (isBiped = true) them][if (isBiped = false) it] down, much to your chagrin.  The witch cries out as the stretch causes her nipples to only open wider, triggering her own circular antagonists to shuffle around inside them.  Pinned underneath your assailant, you can do little more than writhe around as the orbs assault your nether regions.  There's no end to their radiating warmth, merciless vibrations, or shifting mass.");
		outputText("\n\nHowever, you're determined not to go down without a proper fight.  You throw down the gauntlet by leaning up and eating the sand witch's pussy a new one.  With maddening concentration, your tongue teases her vulva, dashing all around as you attempt to cope with your own mounting passion.  Whichever of the witch's cunts isn't getting the oral treatment continues to receive your fingering speciality.  Soaked in the never ending geysers of breastmilk, your hands can easily keep up with your own lapping deliverance.  The sand sorceress' moaning picks up in pace as her breathing reaches its crescendo, her voice mixing with that of her paranormal invader.");
		outputText("\n\nYour extraordinary determination wins out as Shouldra's host concedes, a cocktail of breastmilk and femspunk blasting all over your bound body.  You fall in short order after her, your [vagina] letting loose its own juice[if (hasCock = true) , right alongside your spraying [cock]].  It's a wonder you haven't started seeing stars through all your convulsing.  Dragged through unnatural ecstasy and back, Shouldra and her host flop down [if (isBiped = true) between your [legs]][if (isBiped = false) on top of you], their dual voices still mixing together as the duo try and climb down from their sexual high.  After a few moments, you slide out from underneath the witch and rise to your [feet] - an action made most difficult by the continued orb penetration.");
		outputText("\n\nHelping the possessed desert seductress to her feet, you query as to how to get the damnable things to stop.  \"<i>Oh... oh... t-that's easy,</i>\" Shouldra replies, her voice cracking under the persisting frontal duress.  She leans heavily on your shoulder and with a merely a snap of her fingers, the orbs finally go silent, lifelessly rolling out from their targeted orifices.  Your relief is only shadowed by the incredibly odd tingling sensation left in the orbs' wake.  Peering back up at the sand witch, you find her eyes finally returned back to her normal shade of brown.  Her breathless gaze meets yours, the two of you staring at one another for a moment.");
		player.cuntChange(20,true,true,false);
		player.buttChange(20,true,true,false);
		outputText("\n\nThe witch suddenly blushes beet red.  \"<i>What the fuck is wrong with you?</i>\" she shouts, slapping you across the face and back down to the desert ground.  The sand witch storms off into the horizon, muttering to herself as she glares down at her mutated tits.  Boisterous laughing off to your side catches your attention; Shouldra is entirely too pleased with herself it seems.  It appears that the deceased comedian snuck out of her host without catching your attention.");
		outputText("\n\n\"<i>The look on your face was priceless!</i>\" she says, doing her best to mimic you.  You give her a slightly perturbed stare as she stumbles back into your body, still laughing to herself.  ");
		if (!player.hasFuckableNipples()) outputText("\"<i>You know, maybe I should give you a couple of those chest-mounted treats.  They're pretty fun,</i>\" Shouldra teases, tweaking your [nipples].  ");
		outputText("With a very telling exasperated sigh, you snatch up your [armor] and march back to camp.");
	}
	shouldraSleeping(10,true);
	player.orgasm();
	combat.cleanupAfterCombat();
}

//Follower Shouldra - Masturbation Scenes
//Shouldra Masturbation Menu Text
//slap at the end of current menu text
//Genderless Masturbation
private function shouldraFappinTimes():void {
	spriteSelect(67);
	if (player.hasCock() && player.findStatusEffect(StatusEffects.Infested) >= 0) {
		shouldraAndWormsYoureGonnaHaveABadTime();
	}
	else if (player.gender == 0) genderlessShouldraMasturbation();
	else if (player.hasCock() && (!player.hasVagina() || rand(2) == 0)) maleMasturbationProper();
	else {
		if (rand(2) == 0) girlyMasturbationWithGhosts();
		else shouldraTongueLicksPCs();
	}
}


//Notes:
//Includes callback to original genderless scene ( SHOULDRA_GENDERLESS_FUCK_COUNT )
//Includes callback to meeting Zetsuko ( ZETSUKO_MET )
//Includes event counter
//Assumes follower Shouldra resides inside player during preceding choice
//Uses [foot] fully aware that it will be awkward with hooves.  FUCK THOSE MONSTERS.
//Rework into anal option for all players?

private function genderlessShouldraMasturbation():void {
	clearOutput();
	spriteSelect(67);
	outputText("Shouldra runs your fingers along your ");
	//[if (femininity < 50) 
	if (player.femininity < 50) outputText("masculine ");
	else if (player.femininity > 50) outputText("feminine ");
	outputText("form while processing your request, your eyes glowing yellow as she mulls over her choices.");
	//(same paragraph follows)
	//{if SHOULDRA_GENDERLESS_FUCK_COUNT = 0 & event occurrence = 0}
	if (flags[kFLAGS.SHOULDRA_GENDERLESS_FUCK_COUNT] == 0 && flags[kFLAGS.GENDERLESS_MASTURBATION_WITH_GHOST_COUNT] == 0) {
		outputText("\n\nFully aware that your salacious options are sorely lacking downstairs, it would seem as though you've stumped your roommate not soon after handing her the keys.  However, your confidence is incredibly short lived as a scheming grin spreads unbidden across your face.  \"<i>Unluckily for you, I've come prepared for these sorts of situations,</i>\" your ghostly half explains, knocking your knuckles against the vast expanse that is your crotch.  She's leaving no clue as to what she could be referring to, leaving you to only imagine what fate lies in store.");
	}
	//if SHOULDRA_GENDERLESS_FUCK_COUNT > 0 & event occurrence = 0
	else if (flags[kFLAGS.SHOULDRA_GENDERLESS_FUCK_COUNT] > 0 && flags[kFLAGS.GENDERLESS_MASTURBATION_WITH_GHOST_COUNT] == 0) {
		outputText("\n\n\"<i>So, Champ, you've left me this blank canvas to draw upon again.</i>\"  Elbow propped in your hand, a contemplative finger rests against your lips.  The land's greatest psychic would lack the foresight to predict what your ethereal roommate is concocting.  After the last time she employed - \"<i>Any means necessary,</i>\" your mouth interrupts, concluding your train of thought.  You're left with only a volatile cocktail of equal parts dread and curiosity as your hands rub together menacingly.");
	}
	//if event occurrence > 0
	else {
		outputText("\n\n\"<i>Up for another round then, Champ?</i>\" she asks, rubbing your hands down your [butt].  ");
		//[if (corruption < 50) 
		if (player.cor < 50) outputText("There isn't an answer or outcome to that question that you're in favor of, honestly.");
		else outputText("You sure as hell wouldn't have bothered asking if you weren't.");
	}
	outputText("  The ghost girl promptly discards your [armor] before hurrying your naked body along into the wilderness away from camp.");
	outputText("\n\nShe leads you to a small clearing in the woods, highlighted by an opening in the slightly dense canopy and a babbling brook a few feet further in.  To your right is a short, grassy embankment with a pile of large rocks and boulders embedded into the natural wall.  As the specter leads you towards them, a disconcerting realization sinks in: you have no memory of traveling here.  The last thing you can picture is sprinting away from the camp naked.  Either you really need to work on your mental issues or, more likely, Shouldra would rather you not come here on your own.");
	outputText("\n\nSpeaking of the phantom, your bout of amnesia is the least of her concerns as she has you set aside one rock after another, revealing a tiny cavity in the wall.  ");
	if (flags[kFLAGS.SHOULDRA_GENDERLESS_FUCK_COUNT] == 0 && flags[kFLAGS.GENDERLESS_MASTURBATION_WITH_GHOST_COUNT] == 0) outputText("Within lies a rather rustic yet well-built chest.");
	else if (flags[kFLAGS.SHOULDRA_GENDERLESS_FUCK_COUNT] > 0 && flags[kFLAGS.GENDERLESS_MASTURBATION_WITH_GHOST_COUNT] == 0) outputText("The moment the light reveals what lies within, your [butthole] instinctively clenches shut.  \"<i>You didn't think I'd leave my most treasured possessions behind for some goblin to run into, did you?</i>\" It's the ghost girl's chest of dildos, as well-kept as the last time you laid worried eyes on it.");
	else outputText("Inside rests the ghost's familiar treasure trove of dildos and other toys you have yet to discover.");
	outputText("  She has you pull the container out from its hiding place, removing the clear tarp she used to protect it from the elements.  Despite the fact that you have yet to control your body once through this entire ordeal, an intrinsic urge to open the container has you bending over to pry into the contents within.");
	outputText("\n\nHowever, an unusual stirring deep within your midsection grinds your pursuit to a halt; the familiar visage of your companion has formed atop your feature-less groin.  \"<i>Let me take care of this, Champ,</i>\" she exclaims before thrusting forward and - after carefully wiping it clean - using your [foot] to open and sift through the chest's contents.  While doing so, she begins to recite some manner of spell in a singsong voice; whatever her target is, she certainly seems to be enjoying herself.  You feel as though you could lose your balance at any time... if you actually had any command over it.  No, the poltergeist is in full control from your waist and downward, defying gravity as she continues chanting and searching through her collection.  Thanks to the incredibly awkward forward thrust you're locked in, you can't really make out the contents of her chest.  At least not visually, but as the specter guides your [foot] around you can plainly tell that it's full of all sorts of dildos... among other things.");
	if (flags[kFLAGS.SHOULDRA_GENDERLESS_FUCK_COUNT] > 0) outputText("  Just what else did she pack in there since last you peered at its contents back at the ruins?");
	outputText("\n\n\"<i>Okay, here we go,</i>\" she declares, quickly ending whatever spell she was working on.  Shouldra pulls your [foot] back out of the chest, a ");
	if (flags[kFLAGS.SHOULDRA_GENDERLESS_FUCK_COUNT] > 0 || flags[kFLAGS.GENDERLESS_MASTURBATION_WITH_GHOST_COUNT] > 0) outputText("familiar, ");
	outputText("bumpy, eight-inch demon vibrator firmly in her \"grasp.\"  A tingling sensation coursing through your hind end draws your attention away from the ghost as she inspects her quarry.  You honestly aren't too surprised to peer around and discover your [butt] plumping up, each burst of expansion quaking your flesh.");
	outputText("\n\n\"<i>Now, this will take me a minute to get used to...</i>\"");
	outputText("\n\n...Yup, now she's speaking through your [butthole].  Some day you'll cease underestimating the lengths this eerie eidolon's creativity will reach in order to have a good time.  You glance forward to confirm that the woman's face has disappeared from your bare groin; this circus attraction has moved on to the main event.  ");
	if (player.ass.analLooseness < 3) {
		outputText("Your nerves screech out in pain as your rear revenant stretches out her puckered little \"jaw\" to something more fitting for what she has in store.  A few seconds later and the sensations begin to only register as pleasure.");
		//[if (corruption < 50)
		if (player.cor < 50) outputText("..  This only worries you further.");
		outputText("  It doesn't take her long to <b>prepare your anus for any insidious ploy she's thought up.</b>");
	}
	//if analLooseness >= 3
	else {
		outputText("\"<i>Looks as though you already get plenty of action back here, chief,</i>\" she jests.  Nevertheless, the rear revenant massages her \"jaw\" even more lax than you already are.  Even stranger, each gyration provides more and more pleasurable feedback");
		if (player.cor < 50) outputText(", which only serves to confuse you");
		outputText(".");
	}
	outputText("\n\n\"<i>And now for the pièce de résistance.</i>\"");
	outputText("\n\nWhat more could she possibly have to do? Just how much sorcery has she - some sort of slimy protrusion is sprouting out of your asshole.  ");
	if (flags[kFLAGS.ZETSUKO_MET] > 0) outputText("\"<i>Your run-in with a particular kitsune inspired me,</i>\" Shouldra teases");
	else outputText("Shouldra is too caught up in her machination to give you any hint as to what is going on, leaving you confused");
	outputText(" as the foreign object circles your sphincter.  Though difficult to get a clear visual - the amative apparition still maintains authority over your lower half - you can make out what appears to be a long, emerald, translucent tongue.  The ectoplasmic slobber running down your [if (isBiped = true) leg] [if (isBiped = false) form] essentially confirms your presumptions.  The phantom tongue strokes along your skin, making clear the fact that you can experience its sense of touch just as well as you can with your own.  You count your blessings that the imparted feelings end there; a dual sense of taste would probably end poorly in this circumstance.");
	outputText("\n\nWith preparation complete, the eager spirit gets right to action.  Your [foot] [if (isBiped = true) \"- still clutching the dildo while in the midst of making any yoga instructor jealous as it continues to hang in midair - \"]anxiously delivers its cargo to your possessed posterior.  The ghost girl uses her augmented cheeks to grab hold of the fun stick, allowing you to regain a normal posture as your [foot] returns to the ground.  The anxiety of the impending onslaught causes you to tense up; confoundment replaces anxiety when you go a few seconds without any forceful entry into your backstage.  Prying back over your shoulder, you find the ghoul merely rolling the dildo back and forth in front of her \"mouth\" tantalizingly.");
	outputText("\n\n\"<i>If there were ever a more... appropriate time to say something profound... to say something poetic...</i>\"");
	outputText("\n\nYou can't help but be perplexed by the sudden somber shift.  Though, honestly, it was just a ruse to disarm you; the ghost girl ardently crams the sucker down her gullet, sending shivers racing up your spine.  Nearly all eight inches of coarse demon pecker burrow deep within your haunted hole; the ghoul shifts the dildo around within you, thoroughly brushing your insides with its every nodule.  Dying to continue escalating things, the phantom swings her tongue up to the base and switches on the vibrator, triggering moans from both mouths.  Your bewitched butt grasps the rod once more, thrusting it in and out of you; the combined sensations of  the pseudo oral and anal assault is as only half as confusing as it is pleasurable.");
	outputText("\n\nBut Shouldra is far from satisfied; without letting up on your current predicament, she directs your [foot] back inside her chest.  It begins indiscriminately shoving dildos of every variety up your besieged bum with undue haste.  Ectoplasmic slobber pours down your [legs] as each fun stick is switched on and added to the collection.  You think she makes it to five before her hold over your [legs] dissolves; lacking the ghost girl's willpower and gumption for ignoring simple laws of nature, you tumble to the ground, a small blessing in disguise as now you at least have things to grapple onto now.  Holding on with all your might is exactly what you do; the rear onslaught is rocking your entire body as every moist rod vibrates and rolls around in the confines of the ghost's gluttonous gullet.  Your inflated mutinous cheeks do their best to contain the invasion through each escalating thrust.");
	outputText("\n\nThe moist quivering shafts - the bizarre conglomeration of shapes - the unnatural sounds and breathing emanating from your bottom - the unending geyser of diluted ectoplasmic drool soaking your body - the unorthodox tongue rooted in your asshole lashing about - your vexed cheeks simultaneously tightening around their cargo while their abnormal mass violently jiggles about - It's all too much!");
	outputText("\n\nShouldra doubles down on her payload, yanking it free from your bruised bottom.  But this is no act of mercy.  You're left breathless as the fiend hammers her freight as far down your cargo hold as she can muster.  Now would be a horrible time for her to choke.  Having come as close to cumming as your featureless form can manage, your entire body goes limp.  Your humongous ass lightly quakes as the vibrating dildos continue their melodious humming, going lax in your gaping bum with the ghost girl's grip relaxing.  The torment - however alarmingly pleasurable it turned out to be - is over.");
	outputText("\n\n\"<i>I'm not... through... yet,</i>\" the spirit spits out between deep breathes.  Too far gone to continue the yoga act, she begins dragging you back towards her treasury with your arms.  Your eyes go wide as she reaches inside and grabs onto something... massive.  Your grip cannot even fully encompass its girth.  ");
	//if SHOULDRA_GENDERLESS_FUCK_COUNT > 0 OR event occurrence > 0
	if (flags[kFLAGS.SHOULDRA_GENDERLESS_FUCK_COUNT] > 0 || flags[kFLAGS.GENDERLESS_MASTURBATION_WITH_GHOST_COUNT] > 0) outputText("You recognize it instantly as she pulls it free from her chest: the nearly foot-long floppy horse cock she impaled you on before.");
	//{if SHOULDRA_GENDERLESS_FUCK_COUNT = 0}
	else if (flags[kFLAGS.SHOULDRA_GENDERLESS_FUCK_COUNT] == 0) outputText("She holds her catch up clear for you to see; to your horror, you have clutched onto an enormous horse cock replica.  All 13 inches flop restlessly in your grip, seemingly taunting you with the foreboding future that lays before you.");
	outputText("  Shouldra smacks the dildo of doom onto a nearby boulder as she wearily rises you to your [feet].  The inferior, forgotten playthings slide out uselessly from the ghoul's gasping craw as she slowly clambers over top the wiggling horsey wang.");
	outputText("\n\nToo tired to object or plead, you meekly brace for impact as the wraith lines up its target.  Your immense cheeks part way.  Your rectum gapes wide.  Your anal tongue presses firmly against your taint.  \"<i>Down the hatch!</i>\"");
	outputText("\n\nThe forest shudders with your scream.  The phantom easily downs six inches on the first go.  She wraps her tongue around the shaft, forcing more and more into you.  You swear your pelvis is bulging.  Muffled moans blended with laughter emit from your belabored behind.  You dare not guess how deep Shoudra drills the cock into you before she climaxes - hard.  Your voluptuous ass quavers with ferocity alongside her gagged yelping, throwing you from your perch atop the rock back down to the earth.  Her fun over, you begin to feel the magic subsiding.  Having no desire to learn of the consequences of leaving a massive wang lodged in your shrinking anus, you muster what little strength you can to plumb it free.  With the experience settling down, you can't help but laugh - closer to a timid chuckle, as its the best your exhausted body can offer.  You think you hear Shouldra saying something to you, but you're too worn out to listen to her boasting.");
	outputText("\n\nYou wake some time later, having passed out on top of your clothes.  You're right back at camp.  The ghost girl managed to drag you back somehow - no doubt interested in keeping the location of her secret goodies safe.  For now, at least.  Your attempt to rise back to your [feet] is halted; your ass is still sore... and about as wide as before.  There's also a bottle at your side, full of <b>ectoplasm</b> - you hope this didn't come from where you think it came from.  You can only snicker to yourself, reflecting on the absurdity of it all.  When it comes right down to it, your spooky friend will really go to any means necessary.  It would pay to remember that for a change.");
	//{analLooseness is now 5} {player receives ectoplasm}
	player.ass.analLooseness = 5;
	outputText("\n\n", false);
	player.orgasm();
	dynStats("sen", -2);
	shouldraSleeping((10 + rand(26)), true);
	flags[kFLAGS.GENDERLESS_MASTURBATION_WITH_GHOST_COUNT]++;
	inventory.takeItem(consumables.ECTOPLS, camp.returnToCampUseOneHour);
}

//Anal Masturbation - Variant on Genderless Masturbation
//Notes:
//Includes callback to original genderless scene ( SHOULDRA_GENDERLESS_FUCK_COUNT )
//Includes callback to meeting Zetsuko ( ZETSUKO_MET )
//Includes event counter
//Assumes follower Shouldra resides inside player during preceding choice
//Uses [foot] fully aware that it will be awkward with hooves.  FUCK THOSE MONSTERS.
//Variant not available to genderless PC
private function nongenderlessAnalShouldraMasturbation():void {
	clearOutput();
	spriteSelect(67);
	outputText("Shouldra runs your fingers along your ");
	//[if (femininity < 50) 
	if (player.femininity < 50) outputText("masculine ");
	else if (player.femininity > 50) outputText("feminine ");
	outputText("form while processing your request, your eyes glowing yellow as she mulls over your request.  \"<i>So, let me get this straight.  Despite[if (hasCock = true)  this dandy dick] [if (isHerm = true)  and][if (hasVagina = true)  this serviceable snatch] you want me to work with this?</i>\" the spirit asks, smacking your hand against your [butt].  A smug nod reaffirms your desire.  ");
	//(same paragraph follows)
	//if event occurrence = 0
	if (flags[kFLAGS.GENDERLESS_MASTURBATION_WITH_GHOST_COUNT] == 0) {
		outputText("Your spectral visitor cracks your knuckles in a blustering show of confidence.  \"<i>You think you've thrown down the gauntlet with your challenge, eh, Champ?  You think rules, regulations, sanctions, trade embargos... these things can keep me down?</i>\"  What is she blathering on about?  You suspect she's just stalling; call it your own sixth sense, but as she waves your hands around as she boasts, it feels like it's taking some willpower to not just listlessly stroke your goods.  At least, it seems that way until some errant thought interrupts her tirade, a knowing grin blossoming along your mug.  \"<i>No blockade can stop me.</i>\"");
	}
	else {
		outputText("\"<i>Up for another round then, Champ?</i>\" she asks, your body striking a familiar boxing stance from bouts long since fought.  \"<i>If you think I'll be pulling any punches then you don't have a ghost of a chance.</i>\"  Only if you had control of your body could you respond with even half the appropriate groan.");
	}
	outputText("  The ghost girl promptly discards your [armor] before hurrying your naked body along into the wilderness away from camp.");
	outputText("\n\nShe leads you to a small clearing in the wood, highlighted by an opening in the slightly dense canopy and a babbling brook a few feet further in.  To your right is a short, grassy embankment with a pile of large rocks and boulders embedded into the natural wall.  As the specter leads you towards them, a disconcerting realization sinks in: you have no memory of traveling here.  The last thing you can picture is sprinting away from the camp naked.  Either you really need to work on your mental issues or, more likely, Shouldra would rather you not come here on your own.");
	outputText("\n\nSpeaking of the phantom, your bout of amnesia is the least of her concerns as she has you set aside one rock after another, revealing a tiny cavity in the wall.  ");
	//if SHOULDRA_GENDERLESS_FUCK_COUNT = 0 & event occurrence = 0
	if (flags[kFLAGS.SHOULDRA_GENDERLESS_FUCK_COUNT] == 0 && flags[kFLAGS.GENDERLESS_MASTURBATION_WITH_GHOST_COUNT] == 0) outputText("Within lies a rather rustic yet well-built chest.");
	else if (flags[kFLAGS.SHOULDRA_GENDERLESS_FUCK_COUNT] > 0 && flags[kFLAGS.GENDERLESS_MASTURBATION_WITH_GHOST_COUNT] == 0) outputText("The moment the light reveals what lies within, your [butthole] instinctively clenches shut.  \"<i>You didn't think I'd leave my most treasured possessions behind for some goblin to run into, did you?</i>\" It's the ghost girl's chest of dildos, as well-kept as the last time you laid worried eyes on it.");
	else outputText("Inside rests the ghost's familiar treasure trove of dildos and other toys you have yet to discover.");
	outputText("  She has you pull the container out from its hiding place, removing the clear tarp she used to protect it from the elements.  Despite the fact that you have yet to control your body once through this entire ordeal, an intrinsic urge to open the container has you bending over to pry into the contents within.");
	outputText("\n\nHowever, an unusual stirring deep within your midsection grinds your pursuit to a halt; the familiar visage of your companion has pushed its way out of your groin.  You can't decide whether to laugh or cry at the sight as she[if (hasCock = true)  substitutes your [cock] in place of her nose] [if (isHerm = true)  and she][if (hasVagina = true)  shuffles your [vagina] for a moment, using it as her mouth].  \"<i>I had to get dressed up for the occasion,</i>\" she jests before thrusting forward and - after carefully wiping it clean - using your [foot] to open and sift through the chest's contents.  While doing so, she begins to recite some manner of spell in a singsong voice; whatever her target is, she certainly seems to be enjoying herself.  You feel as though you could lose your balance at any time... if you actually had any command over it.  No, the poltergeist is in full control from your waist and downward, defying gravity as she continues chanting and searching through her collection.  Thanks to the incredibly awkward forward thrust you're locked in, you can't really make out the contents of her chest.  At least not visually, but as the specter guides your [foot] around you can plainly tell that it's full of all sorts of dildos... among other things.");
	//if SHOULDRA_GENDERLESS_FUCK_COUNT > 0
	if (flags[kFLAGS.SHOULDRA_GENDERLESS_FUCK_COUNT] > 0) outputText("  Just what else did she pack in there since last you peered at its contents back at the ruins?");
	outputText("\n\n\"<i>Okay, here we go,</i>\" she declares, quickly ending whatever spell she was working on.  Shouldra pulls your [foot] back out of the chest, a ");
	//if SHOULDRA_GENDERLESS_FUCK_COUNT > 0 OR event occurrence > 0
	if (flags[kFLAGS.SHOULDRA_GENDERLESS_FUCK_COUNT] > 0 || flags[kFLAGS.GENDERLESS_MASTURBATION_WITH_GHOST_COUNT] > 0) outputText("familiar, ");
	outputText("bumpy, eight-inch demon vibrator firmly in her \"grasp.\" A tingling sensation coursing through your hind end draws your attention away from the ghost as she inspects her quarry.  You honestly aren't too surprised to peer around and discover your [butt] plumping up, each burst of expansion quaking your flesh.");
	outputText("\n\n\"<i>Now, this will take me a minute to get used to...</i>\"");
	outputText("\n\n...Yup, now she's speaking through your [butthole].  Some day you'll cease underestimating the lengths this eerie eidolon's creativity will reach in order to have a good time.  You glance forward to confirm that the woman's face has disappeared from your groin; this circus attraction has moved on to the main event.  ");
	//{if analLooseness < 3}
	if (player.ass.analLooseness < 3) {
		outputText("Your nerves screech out in pain as your rear revenant stretches out her puckered little \"jaw\" to something more fitting for what she has in store.  A few seconds later and the sensations begin to only register as pleasure.");
		if (player.cor < 50) outputText("  This only worries you further.");
		outputText("  It doesn't take her long to <b>prepare your anus for any insidious ploy she's thought up.</b>");
	}
	else {
		outputText("\"<i>Looks as though you already get plenty of action back here, chief,</i>\" she jests.  Nevertheless, the rear revenant massages her \"jaw\" even more lax than you already are.  Even stranger, each gyration provides more and more pleasurable feedback");
		if (player.cor < 50) outputText(", which only serves to confuse you");
		outputText(".");
	}
	outputText("\n\n\"<i>And now for the pièce de résistance.</i>\"");
	outputText("\n\nWhat more could she possibly have to do? Just how much sorcery has she - some sort of slimy protrusion is sprouting out of your asshole.  ");
	if (flags[kFLAGS.ZETSUKO_MET] > 0) outputText("\"<i>Your run-in with a particular kitsune inspired me,</i>\" Shouldra teases");
	else outputText("Shouldra is too caught up in her machination to give you any hint as to what is going on, leaving you confused");
	outputText(" as the foreign object circles your sphincter.  Though difficult to get a clear visual - the amative apparition still maintains authority over your lower half - you can make out what appears to be a long, emerald, translucent tongue.  The ectoplasmic slobber running down your [if (isBiped = true) leg] [if (isBiped = false) form] essentially confirms your presumptions.  The phantom tongue strokes along your skin, making clear the fact that you can experience its sense of touch just as well as you can with your own.  You count your blessings that the imparted feelings end there; a dual sense of taste would probably end poorly in this circumstance.");
	outputText("\n\nWith preparation complete, the eager spirit gets right to action.  Your [foot] [if (isBiped = true) \"- still clutching the dildo while in the midst of making any yoga instructor jealous as it continues to hang in midair - \"]anxiously delivers its cargo to your possessed posterior.  The ghost girl uses her augmented cheeks to grab hold of the fun stick, allowing you to regain a normal posture as your [foot] returns to the ground.  The anxiety of the impending onslaught causes you to tense up; confoundment replaces anxiety when you go a few seconds without any forceful entry into your backstage.  Prying back over your shoulder, you find the ghoul merely rolling the dildo back and forth in front of her \"mouth\" tantalizingly.");
	outputText("\n\n\"<i>If there were ever a more... appropriate time to say something profound... to say something poetic...</i>\"");
	outputText("\n\nYou can't help but be perplexed by the sudden somber shift.  Though, honestly, it was just a ruse to disarm you; the ghost girl ardently crams the sucker down her gullet, sending shivers racing up your spine.  Nearly all eight inches of coarse demon pecker burrow deep within your haunted hole; the ghoul shifts the dildo around within you, thoroughly brushing your insides with its every nodule.  Dying to continue escalating things, the phantom swings her tongue up to the base and switches on the vibrator, triggering moans from both mouths.  Your bewitched butt grasps the rod once more, thrusting it in and out of you; the combined sensations of  the pseudo oral and anal assault is as only half as confusing as it is pleasurable.");
	outputText("\n\nBut Shouldra is far from satisfied; without letting up on your current predicament, she directs your [foot] back inside her chest.  It begins indiscriminately shoving dildos of every variety up your besieged bum with undue haste.  Ectoplasmic slobber pours down your [if (isBiped = true) legs] [if (isBiped = false) form] as each fun stick is switched on and added to the collection.  You think she makes it to five before her hold over your [legs] dissolves; lacking the ghost girl's willpower and gumption for ignoring simple laws of nature, you tumble to the ground, a small blessing in disguise as now you at least have things to grapple onto now.  Holding on with all your might is exactly what you do; the rear onslaught is rocking your entire body as every moist rod vibrates and rolls around in the confines of the ghost's gluttonous gullet.  Your inflated mutinous cheeks do their best to contain the invasion through each escalating thrust.");
	outputText("\n\nThe moist quivering shafts - the bizarre conglomeration of shapes - the unnatural sounds and breathing emanating from your bottom - the unending geyser of diluted ectoplasmic drool soaking your body - the unorthodox tongue rooted in your asshole lashing about - your vexed cheeks simultaneously tightening around their cargo while their abnormal mass violently jiggles about - It's all too much!");
	outputText("\n\nShouldra doubles down on her payload, yanking it free from your bruised bottom.  But this is no act of mercy.  You're left breathless as the fiend hammers her freight as far down your cargo hold as she can muster.  Now would be a horrible time for her to choke.  The final delivery throws you over the deep-end, [if (hasCock = true) your [cock] spraying cum everywhere] [if (isHerm = true)  while ][if (hasVagina = true) your [vagina] sprays femspunk, mixing in with the otherworldly drool already coating your [legs]].  Your humongous ass lightly quakes as the vibrating dildos continue their melodious humming, going lax in your gaping bum with the ghost girl's grip relaxing.  The torment - however alarmingly pleasurable it turned out to be - is over.");
	outputText("\n\n\"<i>I'm not... through... yet,</i>\" the spirit spits out between deep breathes.  Too far gone to pick up the yoga act again, she begins dragging you back towards her treasury with your arms.  Your eyes go wide as she reaches inside and grabs onto something... massive.  Your grip cannot even fully encompass its girth.  ");
	//if SHOULDRA_GENDERLESS_FUCK_COUNT > 0 OR event occurrence > 0
	if (flags[kFLAGS.SHOULDRA_GENDERLESS_FUCK_COUNT] > 0 || flags[kFLAGS.GENDERLESS_MASTURBATION_WITH_GHOST_COUNT] > 0) outputText("You recognize it instantly as she pulls it free from her chest: the nearly 2-foot floppy horse cock she impaled you on before.");
	//if SHOULDRA_GENDERLESS_FUCK_COUNT = 0
	else outputText("She holds her catch up clear for you to see; to your horror, you have clutched onto an enormous horse cock replica.  All 13 inches flop restlessly in your grip, seemingly taunting you with the foreboding future that lays before you.");
	outputText("  Shouldra smacks the dildo of doom onto a nearby boulder as she wearily rises you to your [feet].  The inferior, forgotten playthings slide out uselessly from the ghoul's gasping craw as she slowly clambers over top the wiggling horsey wang.");
	outputText("\n\nToo tired to object or plead, you meekly brace for impact as the wraith lines up its target.  Your immense cheeks part way.  Your rectum gapes wide.  Your anal tongue presses firmly against your taint.  \"<i>Down the hatch!</i>\"");
	outputText("\n\nThe forest shudders with your scream.  The phantom easily downs six inches on the first go.  She wraps her tongue around the shaft, forcing more and more into you.  You swear your pelvis is bulging.  Muffled moans blended with laughter emit from your belabored behind.  You dare not guess how deep Shoudra drills the cock into you before she climaxes - hard.  Your voluptuous ass quavers with ferocity alongside her gagged yelping, throwing you from your perch atop the rock back down to the earth.  Her fun over, you begin to feel the magic subsiding.  Having no desire to learn of the consequences of leaving a massive wang lodged in your shrinking anus, you muster what little strength you can to plumb it free.  With the experience settling down, you can't help but laugh - closer to a timid chuckle, as its the best your exhausted body can offer.  You think you hear Shouldra saying something to you, but you're too worn out to listen to her boasting.");
	outputText("\n\nYou wake some time later, having passed out on top of your clothes.  You're right back at camp.  The ghost girl managed to drag you back somehow - no doubt interested in keeping the location of her secret goodies safe.  For now, at least.  Your attempt to rise back to your [feet] is halted; your ass is still sore... and about as wide as before.  There's also a bottle at your side, full of <b>ectoplasm</b> - you hope this didn't come from where you think it came from.  You can only snicker to yourself, reflecting on the absurdity of it all.  When it comes right down to it, your spooky friend will really meet any challenge you confront her with.  It would pay to remember that for a change.");
	//analLooseness is now 5
	player.orgasm();
	dynStats("sen", -2);
	player.ass.analLooseness = 5;
	shouldraSleeping((10 + rand(26)), true);
	outputText("\n\n", false);
	flags[kFLAGS.GENDERLESS_MASTURBATION_WITH_GHOST_COUNT]++;
	inventory.takeItem(consumables.ECTOPLS, camp.returnToCampUseOneHour);
}

//Male Masturbation
//Shouldra leads PC out of camp, finds few flowers, magicks them into huge dick-suckin' not!Corrupt Glade flowers. Also, massive cum production, because.
private function maleMasturbationProper():void {
	clearOutput();
	spriteSelect(67);
	outputText("You are nearly overwhelmed by Shouldra's delight when you allow her to focus on your [cock].  She instantly takes the lead, steering you behind a good-sized boulder and flinging your [armor] piece-by-piece as you go.");
	outputText("\n\nShouldra practically drools at the mere sight of your meat.  The only thing stopping her from pouncing onto it right then and there is a small bunch of roses growing near the base of the rock.  She stares at the three small buds, and you feel your lips curling with the ghost girl's customary evil sneer.  \"<i>Say, Champ, hows about we look into botany for a bit?</i>\" Shouldra quips, pointing a hand at the flora and, with an unnaturally husky tone, begins her spell.");
	outputText("\n\nHer smile only widens as one of flowers engorge in the magic, quickly sprouting into a terrifically monstrous abomination of nature.  Thick tendrils sprout from its base, wriggling excitedly and dripping with... something.  \"<i>Oh, good boy!</i>\" Shouldra coos, reaching out to the gargantuan plant in the strangest display of filial affection.  The tentacled beast eagerly sweeps you up, dangling you several feet in the air with one large, excited tentacle wrapped around your chest and one [leg].");
	outputText("\n\nLike a fast-motion sunflower reaching toward sunlight, the gigantic blossom tilts towards you and your rigid [cock].  You notice the more-than-passing resemblance in the folds to a certain aspect of the female anatomy enshrouded by the soft folds of an actual rose.  Where Shouldra comes up with these spells, you could only guess.");
	//[if cockSize < 200
	if (player.cockArea(0) < 200) outputText("  Shouldra laughs happily as she considers the size difference; your dick simply does not pack enough of a punch for the assuredly hungry flower.  Always eager to help, Shouldra, not the least bit discomforted by her near-helpless situation, happily sings out the necessary enchantment.  You can't help but think she's having a bit too much fun with this for her own good.");
	outputText("\n\nShouldra's high-pitched and nearly crazed laughter peals from your mouth as the tentacles lower you towards the vegetative vagina.  Shouldra's ecstatic reaction to this whole overgrown situation rubs off on you slightly; each time you blink, the glistening pedals just look more and more inviting.  Curse Shouldra and her ability to impart lust, but damn it all, you want to fuck the chlorophyll out of that plant!");
	outputText("\n\nThe ghost girl relinquishes part of her hold on you, most likely knowing full well your new fascination with her construct.  Sure enough, as soon as you take up the reins, your efforts to reach the rose doubles.  Luckily for you, the tentacles, slimy as a swimming goo girl's tentacles, are no match for your lust-driven struggle.  You slip out of their grasp, free-falling for several feet to land, with a big and airy poof, right into the cushiony bloom.  The pleasant and heady aroma of the enlarged rose nearly drives you wild.  You just can't get enough.");
	outputText("\n\nYou crawl on your belly across to the flower's entrance, shuddering with delight as your [cock] slides, catches, and flops against each and every pedal on the way.  With an effort spurred by your ever-increasing desire to bone a thing, you lunge forward, a hand reaching forward... to smack into the edge of the flowery fuckbox.  You freeze momentarily as your body registers the sheer lubrication of the lips; whereas the pedals glistened with dew, the unnatural opening virtually leaks in an obviously spiritually-imparted sense of anticipation.");
	outputText("\n\nFor a little while you gently poke and pinch at her soaking folds before you can confirm their validity.  Shouldra does good work; the vegetable organ even radiates a gentle heat.  There's nothing for it, then.  You drag yourself to your feet, line yourself up as best you can, then, with an excited cry, leap high into the air.  With a loud and delicious-sounding squelch, you drive your way into the rose.  Your momentum aids in the penetration, sinking further and further still until, with a dull smack, you hilt; an impressively deep insertion, you observe happily.");
	outputText("\n\nThe plant immediately goes to work, the stuffed recesses expertly rippling and squeezing your [cock].  A shuddering sigh ripples from your very being at the milking.  \"<i>She seems to like you,</i>\" Shouldra whispers in your ear.  If you were in a more stable state of mind, you'd probably roll your eyes.  As it were, you simply hum your agreement, losing yourself in the heat of the moment.  She just chuckles and casts a small spell before falling silent once more.");
	//if buals: 
	if (player.balls > 0) outputText("\n\nYour sack");
	else outputText("\n\nYour prostate");
	outputText(" shudders and churns, and you know enough about Shouldra to know exactly what's to come.  Another wave of lust hits you like a freight train, and the thirsty rose feasts on a multi-liter burst of pre.  Though you can't see the stalk around the span of the bloom, you can readily hear and imagine your initial offering sloshing down towards its roots.  The squishing and squeezing intensifies, the rose obviously spurred on by its appetizer.");
	outputText("\n\nWith a final toe-curling compression of your shaft, the rose achieves the release it instinctively craves.  You can almost swear you can hear its triumphant cry as your cum-tunnel bulges with an unnaturally large load, and it's all you can do to even stay conscious with the barrage of pleasure bouncing around your thoughts.  The first gout of seed spills into the plant's greedy gullet, followed quickly by a fourth, and fifth, and sixth, and seventh...");
	outputText("\n\nThe monstrous flower, seemingly overwhelmed by your overloading orgasm, tips to one side, releasing its grip on you and allowing you to tumble to the ground.  Thankfully, you land rather softly on your back; you glance back at Shouldra's creation and are shocked by the results.  The poor thing can hardly even stand up straight!  Your semen has bulged the rose's shaft in numerous places.  Judging by the steady drizzle of cum still pouring from your engorged member, Shouldra certainly overcharged her virility spell, this time around.");
	outputText("\n\nAs the thought crosses your mind, a familiar-looking ghost sits up in your torso, clamoring out and leaning over you with a huge smile on her face.  \"<i>Have fun?</i>\" she asks innocently.  \"<i>I thought you might like that little trick.  Picked it up a few decades back from a dryad; nice bunch, as long as they warm up to you.</i>\"");
	outputText("\n\nYou don't bother responding.  She reaches to you, and you take her hand, letting her guide you to your feet.");
	//if cocksize <200: 
	if (player.cockArea(0) < 200) outputText("  You stagger a bit at the unaccustomed heft of your junk altering your center of gravity, but you know that will wear off soon enough.");
	outputText("  She reaches into her tunic and tosses you a full bottle of ectoplasm, giving you a wink before incorporealizing once more and floating into you.  All's well that ends well.");
	player.orgasm();
	dynStats("sen", -2);
	outputText("\n\n", false);
	shouldraSleeping((10 + rand(26)), true);
	inventory.takeItem(consumables.ECTOPLS, camp.returnToCampUseOneHour);
}

//Female Masturbation
private function girlyMasturbationWithGhosts():void {
	clearOutput();
	spriteSelect(67);
	//vibrating fingers near-mindbreak (by smidgeums)
	outputText("At your signal, Shouldra takes control and leads you out to a secluded looking spot near the woods.  Your armor is stripped from your body along the way, each piece leaving a breadcrumb trail back to camp until you arrive in a clearing.  The ghost uses your body to fall back on the ground, stretching your limbs out as your body is laid out along the forest floor.  With one hand teasing your breasts, she guides the other to your cunt and begins a slow, deliberate massage.");

	outputText("\n\nA gentle warmth spreads out from your slit with each stroke, and you feel small drops of your own fem-cum trickle down, spreading over your thighs.  The ghost girl, feeling the confirmation of her skills, begins to increase her speed, and starts to maneuver your fingers around your clit, deliberately avoiding full contact to keep you delicately riding on the edge.  Seemingly out of curiosity, she relinquishes control of your legs, which you immediately use to tense them up, digging your toes in the soft ground further and further in time with her strokes.  You hear her give a half-chuckle at your reaction, and she begins to slow down her pace.  As the strokes become excruciatingly slow, she gently begins teasing the very tip of your nub, rocking it back and forth with a gentle, but firm, touch.  You sway your hips up and down in an effort to coax more stimulation out of your possessed hand, only to find her compensating each caress to account for your movement, denying you the relief you desperately crave.");
	outputText("\n\nEach passing second of the pseudo-torture becomes more and more agonizing, and your swaying has soon become a sort of writhing as the denial becomes too much to bear.  You start pleading for Shouldra to give you a release, only to be met with a playful refusal.  As your begging becomes more and more pitiful, you notice that you've been speaking out loud, calling out into the empty glade for permission to orgasm.  The realization sends blood rushing to your face in embarrassment, which is quickly overcome by the still gnawing desire to cum.  You hear Shouldra's voice echo in your head:");
	outputText("\"<i>Tsk!  Saying those kinds of things aloud!  Still... if you want to let it out so badly, I might let you if you beg a little more...</i>\"");
	outputText("\n\nThe last word is punctuated by a change in your finger.  A small, but noticeable, vibration begins teasing your clit, spreading to the rest of your hand.  The feeling elicits a sharp gasp as it begins alternating its intensity.  You try to resist, squirming around in an effort to knock it off its position, but it's no use.  Your desires quickly win out over your shame, and you soon accept defeat.  You spread your legs, and begin begging, practically crying out into the sky for more of Shouldra's special technique.  You hear another giggle echo from within, and your hand begins to encircle your box, now completely soaked in anticipation for what's to come.");
	outputText("\n\nCurving over your entrance, the vibrating palm presses against you, each pulse reverberating through the whole of your body as it times itself with your heartbeat.  The sensation is more than enough to send you over the edge after all the teasing, your moans catching in your throat as you forget to breathe.  But much like the cum that had been building up inside you, the animalistic noises explode out of you, the sounds startling a few surrounding birds out of their trees.  Satisfied, the ghost-girl allows you control of your arms, but continues whatever spell that generates the vibrations, much to your delight.  You indulge yourself a little more, basking in the intensity only her magic could provide.  Satisfied, you try to withdraw your hand, but to you dismay you find it adhering to the surface.  Panicking slightly, you twist and jerk, but nothing seems to break the bond between your still-pulsing hand and now overly-sensitive cunny.  In fact, each attempt seems to cause it to increase in potency, until eventually the titillating shocks of pleasure-pain become far too powerful to focus on anything else.");
	outputText("\n\nYou clutch your thighs together in a final act of defiance to the situation, but to no avail.  As your lower mouth begins drooling onto the ground below, the numbness of your legs spreads upward.  As it hits your head, thinking becomes a nigh-impossible task.  Your body twitches on the ground, and the thought of just surrendering and riding it out becomes increasingly appealing.  The edges of your vision turn pink and your tongue rolls out of your mouth as you lose yourself in the intense, otherworldly sensations.  You feel your honey pouring out on the ground below you, mixing in with the soil.  Before your mind and vision go completely dark, however, the pulsing stops, cutting off flow of pleasure that had just moments ago threatened to steal your sanity.");
	outputText("\n\nA chill signifies Shouldra's exit of your body, and through the haze you make out her peeking her head over your form.  The odd quiver in your legs and the now sex-scented mud coating your ass are the only proof of what you had just experienced, and the fatigue quickly sets in as the last remnants of pleasure fade from your body.  As you lose consciousness, you feel yourself being picked up, and carried back to your camp.");
	player.orgasm();
	dynStats("sen", -2);
	shouldraSleeping((10 + rand(26)), true);
	doNext(camp.returnToCampUseOneHour);
}

//tongue-lickin' (by abraxas)
private function shouldraTongueLicksPCs():void {
	clearOutput();
	spriteSelect(67);
	outputText("The ghost girl promptly discards your [armor] before hurrying your naked body along into the wilderness away from camp.");
	outputText("\n\nShe leads you to a small clearing in the wood, highlighted by an opening in the slightly dense canopy and a babbling brook a few feet further in.  To your right is a short, grassy embankment with a pile of large rocks and boulders embedded into the natural wall.  As the specter leads you towards them, a disconcerting realization sinks in: you have no memory of traveling here.  The last thing you can picture is sprinting away from the camp naked.");
	//if SHOULDRA_GENDERLESS_FUCK_COUNT > 0 || event occurrence > 0
	if (flags[kFLAGS.SHOULDRA_GENDERLESS_FUCK_COUNT] > 0 || flags[kFLAGS.SHOULDRA_TONGUE_LICKS_TIMES] == 0) outputText("  The consistency of your forgetfulness while traveling this path leads you to believe that your ethereal inhabitant would rather you not come back here on your own.");
	outputText("\n\nYour bout of amnesia is the least of Shouldra's concerns as she has you set aside one rock after another, revealing a tiny cavity in the wall.");
	//Variables probably need to be given another look to make sure a PC that went through a genderless scene and then acquired a vagina will get the right text
	if (flags[kFLAGS.SHOULDRA_GENDERLESS_FUCK_COUNT] == 0 && flags[kFLAGS.SHOULDRA_TONGUE_LICKS_TIMES] == 0) outputText("  Within lies a rather rustic yet well-built chest.");
	else if (flags[kFLAGS.SHOULDRA_GENDERLESS_FUCK_COUNT] > 0 && flags[kFLAGS.SHOULDRA_TONGUE_LICKS_TIMES] == 0) outputText("  \"<i>You didn't think I'd leave my most treasured possessions behind for some goblin to run into, did you?</i>\"  It's the ghost girl's chest of dildos, as well-kept as the last time you laid worried eyes on it.");
	else outputText("  Inside rests the ghost's familiar treasure trove of dildos and other toys you have yet to discover.");
	outputText("  She has you pull the container out from its hiding place, removing the clear tarp she used to protect it from the elements.  Despite the fact that you have yet to control your body once through this entire ordeal, an intrinsic urge to open the container has you bending over to pry into the contents within.");
	outputText("\n\n\"<i>Ahh, so many choices,</i>\" Shouldra muses as you study the contents of her hidden cache.  Before you sits a collection of various sex toys so diverse and numerous that it would be impossible to take stock of everything inside the chest at once.  Clearly in no rush to reveal everything she's got in store for you just yet, your incorporeal companion wastes no time in plunging your hands into the lewd assortment.  She rummages about for a moment, snatches a couple of toys that she judges to be \"<i>just about right</i>\" from the mess, and stands you back up, giving the chest just enough of a kick to close it on the way.  \"<i>Don't want to ruin any surprises,</i>\" she explains.  Your pondering of just what else she has in that thing is interrupted by the voice of a rather bored ghost.");
	//if event occurrence == 0
	if (flags[kFLAGS.SHOULDRA_TONGUE_LICKS_TIMES] == 0) {
		outputText("\n\n\"<i>Aah, but it's all the same anyways</i>,\" Shouldra sighs, rolling the long phallic objects over each other in your palm.  \"<i>Where's the excitement in going back to the same old thing?</i>\" she laments, suddenly quite sad about the whole situation despite her earlier eagerness.  Sensing your displeasure, she snaps back, \"<i>Hey, I told you my deal already.  How am I supposed to feel when I've seen it all before?</i>\"  Trying to hurry her along, you ask if there's <b>anything </b> new that she might try.  \"<i>Well what else am I gonna play with on you?</i>\" She breaks out into your own voice.  \"<i>You've got tits, an ass and a cunt, just like the rest of 'em! What am I mi-...</i>\"  She cuts herself off.  Shouldra closes one of your eyes and sticks ");
		if (player.tongueType > TONGUE_HUMAN) outputText("some of ");
		outputText("your tongue out, examining it.  Already, you think you've got a pretty good idea of where she's going to take this.");
		outputText("\n\n\"<i>I suppose none of my hosts have actually quite been able to reach themselves with a tongue yet... can you, Champ?</i>\"");
	}
	else {
		outputText("\n\nShouldra smiles and wonders aloud, \"<i>Think I could get your tongue in your cooch again?</i>\"");
	}
	//if PC is catgirl (has "flexibility" perk)
	if (player.findPerk(PerkLib.Flexibility) >= 0) {
		//if event occurrence = 0
		if (flags[kFLAGS.SHOULDRA_TONGUE_LICKS_TIMES] == 0) {
			outputText("\n\nYou sheepishly pulse confirmation back to her that you can.  You're not really used to talking about that sort of thing, but you <b>are</b> sharing a body.  \"<i>Oh, now that's just adorable!</i>\" Shouldra exclaims, having already searched you for mental images of your own flexibility.  You blush at the tease, but you can feel her lust spike at the thoughts, telling you that it's more than just a fun thought for your ethereal partner.");
			outputText("\n\nShe sits you down and lets her dildos fall to the ground, forgotten for the moment.  \"<i>How's this one go?</i>\" she asks, leaning down in an awkward attempt to get your face in your " + player.vaginaDescript(0) + ".  You start to explain the proper 'technique' to what she's trying to do, but before you can even finish your thought she's stuck a leg up in the air and has your mouth to your own snatch.  You doubt you'll ever get used to having her inside your thoughts.");
		}
		//else if event occurrence > 0
		else {
		outputText("\n\n\"<i>Well then, let's get back to it!</i>\" Shouldra enthusiastically suggests.  She sits down and sets her dildos aside, preferring to get you warmed up first as usual.  She's gotten even better at mimicking the pose required to get your face close in to your sex, and has your body contorted that way in no time.");
		}
		outputText("\n\nIt feels absolutely <b>fantastic</b> as she begins to take a few testing licks at your pussy.  \"<i>Oooh, Champ, I could get used to this...</i>\" Shouldra moans from somewhere within you.  Truth be told, it does pretty nice to have someone else doing the work for you.  Her vast pool of libido laps at you, arousing you and making every one of her flicks across your engorged " + player.clitDescript() + " feel better than they have any right to.  She caresses your slickening lips with your small, tender tongue, granting you all the pleasure of her expert form.  Thoughts fog and blow away as you ride the waves of pleasure inside your mind, body a <b>very</b> willing slave to the ghostly girl's desires.");
		outputText("\n\n\"<i>Need... more...</i>\"  Without bothering to get your opinion on the matter, Shouldra starts to mutter a soft incantation into your steamy sex.  Much to your dismay, she momentarily lifts your head from your crotch.  With the hand that she isn't propping you up on, she takes your tongue between your thumb and a couple fingers and begins to gently tug and stroke on it.  Though imperceptible at first, a few strokes later the change becomes obvious: inches of muscle spill forth from your mouth.");
		if (flags[kFLAGS.SHOULDRA_TONGUE_LICKS_TIMES] == 0) {
			outputText("  Almost shocked enough to wrest control away from your companion, you begin to babble dissent and try to reel your lengthening tongue back in to no avail.  Shouldra stops for a moment, quite frustrated by the interruption.  Sitting straight up, she consoles you, \"<i>Relax, Champ, it'll stop feeling weird in a minute and you know it's all temporary.</i>\"");
	
			outputText("\n\nGranted a moment to adjust, you let yourself settle down and hand her the reins once more.  She happily goes back to");
		}
		//else if event occurrence > 0
		else outputText("\n\n She happily continues");
		outputText(" sliding fingers along the wet appendage, humming a little tune over your tongue until more than a foot of it droops from your mouth.  \"<i>Now we're getting somewhere,</i>\" you hear her thinking as she works her magic.  There doesn't seem to be a limit to how much she can pull out of your mouth, and soon she has more than three feet of pure tongue coiled in your lap.  Furrowing your brow in concentration, she tries to move your tongue about, but can't manage to wiggle more than the tip.  \"<i>Too thin,</i>\" she mutters, \"<i>much too weak. Doesn't feel right...</i>\"");
	
		outputText("\n\nTaking the midsection of your tongue in your hand, she slowly starts to rub her hand along some of its length.  It feels... odd, somehow, but not entirely unpleasant.  Though you shudder at the first rub, they start to feel more natural as she pushes you on.  Actually, it feels sort of good.  Her strokes remain constant, though some part of you wishes she'd go faster.  It doesn't even register as odd in your addled mind that your tongue is swelling in your hand with every stroke.  Shouldra starts to make wider movements along your smooth stretch of muscle.  Its girth plumps up to fill your palm nicely wherever she brings your hand, and the strange sensations of your flesh on its nerves wrack your body with shudders of pleasure even through Shouldra's grip.");
		outputText("\n\nThough it's not just you feeling this anyhow.  For her part, your pale possessor seems to be enjoying this odd process even more than you are.  She pants in time with each and every stroke, occasionally rolling your neck and letting out a soft moan as your spine arches.  You surmise that she's somehow bumped up the sensitivity of the nerves on your tongue to rival that of those around your true sex, and rewired you to experience each touch in the same way.  By the time Shouldra reaches the end, your tongue is long, thick, and nicely tapered at the end, and she's having a hard time keeping your weight up as the pulses of pleasure rush through your body.");
		outputText("\n\n\"<i>That's... yeah, that's good,</i>\" she breathily determines.  With just a bit of its weight supported by your hand and a lot of concentration on her part, Shouldra manages to snake your tongue down to your cunt, still dripping need from the earlier licking.  With a little shake the first foot or so of your lengthy stretch goes rigid.  After a few probing pokes against your labia, she unceremoniously penetrates the appendage deep into your waiting honeypot.  The dual pleasures of your tongue and your cunt set your senses aflame, and your inner lust roils as the sensitive skin of your tongue caresses every nook and crevice of your sex.  Shouldra lets out a little squeaking noise, obviously even catching herself off-guard with the potent mixture of feeling.  She abandons trying to keep your body upright and topples onto your side.  She rolls you onto your back and arches your hips, moaning like a whore as your tongue shlicks in and out of you, slapping lewdly against you with each thrust.  Shouldra claws at the grass and dirt with your free hand, desperate to hold on to something as the whirlwind of pleasure tries to whisk her away.");
		outputText("\n\nStuck in your mind as a helpless onlooker, you're forced to just ride out the storm.  You feel <b>everything</b> so clearly; every blade of grass tickling your shoulders, every drop of saliva smeared across your swollen [clit], every hard press of your possessed tongue against your craving walls. it all feels like so much, like the pleasure is burning you so hot that it's going to tear you apart from the inside and drive you insane.  Your follower, apparently in possession of quite a will of her own, manages to overcome the feelings just long enough to roll herself onto her side and grab for the dildos.  She manages to drag them back, and all you can do is pray that they'll make this release come faster, as the buildup is especially torturous under the circumstances.  Now more confident in her ability to keep your tongue moving, she releases it, and reaches for the pair of phallic toys.");
		outputText("\n\nOne in each of your shaking hands, she flops onto your back once more.  You hear a strained voice from within telling you to \"<i>get ready</i>,\" just before Shouldra jams one dildo in your cunt and crams the other in your mouth.  Their bumpy surfaces tickle the nerves of your tongue so perfectly and they make you feel so wonderfully full that thoughts of the agonizing wait you had to endure is dissolved almost immediately by orgasm.  Shouldra screams out around the one in your mouth, muffled wails of pleasure echoing among the rocks.  A tasty gush of your juices splash out over your tightly-packed tongue and onto your thighs and the ground.  Your vision begins to fade even before the  feelings of release leave you.  By the time it has and your tongue starts to return to its usual size, you're gone, floating unaware on a cloud of post-orgasmic bliss.");
		//end catgirl scene, back to camp
	}
	// actually, draconic one is long enough as is even without her upgrades
	else if (player.hasLongTongue()) {
		outputText("\n\nYou tell your experimentative friend to see for herself.  She opens your jaw wide, letting inch after inch of your inhuman tongue spill out.  A happy squeak, made rather awkward by the floppy appendage, comes from you as Shouldra checks out what you've been packing in your mouth.  \"<i>Tho yuv ha tis-</i>\" she giggles at the sound of talking with it hanging out, but continues talking in your mind.  \"<i>So you've had this thing all this time and I haven't gotten to play with it?  Well that just won't do.</i>\"");
		outputText("\n\nShe sits you down and lets her dildos fall to the ground, forgotten for the moment.  It feels absolutely <b>fantastic</b> as she begins to take a few testing licks at your pussy.  \"<i>Oooh, Champ, I could get used to this...</i>\"  Shouldra moans from somewhere within you.  Truth be told, it does pretty nice to have someone else doing the work for you.  Her vast pool of libido laps at you, arousing you and making every one of her flicks across your engorged " + player.clitDescript() + " feel better than they have any right to.  She caresses your slickening lips with your lengthy prehensile tongue, granting you all the pleasure of her expert technique.  Thoughts fog and blow away as you ride the waves of pleasure inside your mind, body a <b>very</b> willing slave to the ghostly girl's desires.");
		outputText("\n\n\"<i>Need... more...</i>\" Without bothering to get your opinion on the matter, Shouldra starts to mutter a soft incantation into your steamy sex.  Much to your dismay, she momentarily snakes your tongue out from your crotch.  With the hand that she isn't propping you up on, she takes your demonic tongue between your thumb and a couple fingers and begins to gently tug and stroke on it.  Though imperceptible at first, a few strokes later the change becomes obvious: even more inches of muscle spill forth from your mouth.");
		if (flags[kFLAGS.SHOULDRA_TONGUE_LICKS_TIMES] == 0) outputText("  Almost shocked enough to wrest control away from your companion, you begin to babble dissent and try to reel your lengthening tongue back in to no avail.  Shouldra stops for a moment, quite frustrated by the interruption.  Sitting straight up, she consoles you, \"<i>Relax, Champ, it'll stop feeling weird in a minute and you know it's all temporary.</i>\"\n\nGranted a moment to adjust, you let yourself settle down and hand her the reins once more.  She happily goes back to ");
		else outputText("\n\n She happily continues ");
		outputText("sliding fingers along the wet appendage, humming a little tune over your tongue until more than an additional foot of it droops from your mouth.  \"<i>Now we're getting somewhere,</i>\" you hear her thinking as she works her magic.  There doesn't seem to be a limit to how much she can pull out of your mouth, and soon she has more than three feet of pure tongue coiled in your lap.  Furrowing your brow in concentration, she tries to move your tongue about, but can't manage to wiggle more than the tip.  \"<i>Too thin,</i>\" she mutters, \"<i>much too weak. Doesn't feel right...</i>\"");
		outputText("\n\nTaking the midsection of your tongue in your hand, she slowly starts to rub her hand along some of its length.  It feels... odd, somehow, but not entirely unpleasant.  Though you shudder at the first rub, they start to feel more natural as she pushes you on.  Actually, it feels sort of good.  Her strokes remain constant, though some part of you wishes she'd go faster.  It doesn't even register as odd in your addled mind that your tongue is swelling in your hand with every stroke.  Shouldra starts to make wider movements along your smooth stretch of muscle.  Its girth plumps up to fill your palm nicely wherever she brings your hand, and the strange sensations of your flesh on its nerves wrack your body with shudders of pleasure even through Shouldra's grip.");
		outputText("\n\nThough it's not just you feeling this anyhow.  For her part, your pale possessor seems to be enjoying this odd process even more than you are.  She pants in time with each and every stroke, occasionally rolling your neck and letting out a soft moan as your spine arches.  You surmise that she's somehow bumped up the sensitivity of the nerves on your tongue to rival that of those around your true sex, and rewired you to experience each touch in the same way.  By the time Shouldra reaches the end, your demonic tongue is long, thick, and nicely tapered at the end, and she's having a hard time keeping your weight up as the pulses of pleasure rush through your body.");
		outputText("\n\n\"<i>That's... yeah, that's good,</i>\" she breathily determines.  With just a bit of its weight supported by your hand and a lot of concentration on her part, Shouldra manages to snake your tongue down to your cunt, still dripping need from the earlier licking.  With a little shake the first foot or so of your lengthy stretch goes rigid.  After a few probing pokes against your labia, she unceremoniously penetrates the appendage deep into your waiting honeypot.  The dual pleasures of your tongue and your cunt set your senses aflame, and your inner lust roils as the sensitive skin of your tongue caresses every nook and crevice of your sex.  Shouldra lets out a little squeaking noise, obviously even catching herself off-guard with the potent mixture of feeling.  She abandons trying to keep your body upright and topples onto your side.  She rolls you onto your back and arches your hips, moaning like a whore as your tongue shlicks in and out of you, slapping lewdly against you with each thrust.  Shouldra claws at the grass and dirt with your free hand, desperate to hold on to something as the whirlwind of pleasure tries to whisk her away.");
		outputText("\n\nStuck in your mind as a helpless onlooker, you're forced to just ride out the storm.  You feel <b>everything</b> so clearly; every blade of grass tickling your shoulders, every drop of saliva smeared across your swollen [clit], every hard press of your possessed tongue against your craving walls.  It all feels like so much, like the pleasure is burning you so hot that it's going to tear you apart from the inside and drive you insane.  Your follower, apparently in possession of quite a will of her own, manages to overcome the feelings just long enough to roll herself onto her side and grab for the dildos.  She manages to drag them back, and all you can do is pray that they'll make this release come faster, as the buildup is especially torturous under the circumstances.  Now more confident in her ability to keep your tongue moving, she releases it, and reaches for the pair of phallic toys.");
		outputText("\n\nOne in each of your shaking hands, she flops onto your back once more.  You hear a strained voice from within telling you to \"<i>get ready</i>,\" just before Shouldra jams one dildo in your cunt and crams the other in your mouth.  Their bumpy surfaces tickle the nerves of your tongue so perfectly and they make you feel so wonderfully full that thoughts of the agonizing wait you had to endure is dissolved almost immediately by orgasm.  Shouldra screams out around the one in your mouth, muffled wails of pleasure echoing among the rocks.  A tasty gush of your juices splash out over your tightly-packed tongue and onto your thighs and the ground.  Your vision begins to fade even before the  feelings of release leave you.  By the time it has and your tongue starts to shrink back to its usual size, you're gone, floating unaware on a cloud of post-orgasmic bliss.");
	}
	//else
	else {
		outputText("\n\nYou tell Shouldra that you unfortunately cannot, expecting her to be disappointed.  \"<i>Ah well, that's fine,</i>\" she replies without sounding put off one bit, \"<i>you will soon.</i>\"");
		outputText("\n\nShe sits you down and lets her dildos fall to the ground, forgotten for the moment. Just to check that you truly can't get down there on yourself, she sticks your tongue as far out as your mouth can manage and tries all sorts of twists and contortions to get your face between your legs, but to no avail.  \"<i>Bah, on with it, then,</i>\" Shouldra says, finally conceding defeat to your body's rigidity.  \"<i>Rather not get the bones mixed up right now</i>.\"  You're thankful for that, knowing full well that your ghostly friend just might be able to do something like that.");
		outputText("\n\nShouldra sticks your small tongue out once again.  \"<i>Need... more...</i>\"  Without bothering to get your opinion on the matter, Shouldra starts to mutter a soft incantation into.  With the hand that she isn't propping you up on, she takes your tongue between your thumb and a couple fingers and begins to gently tug and stroke on it.  Though imperceptible at first, a few strokes later the change becomes obvious: extra inches of muscle spill forth from your mouth.  ");
		if (flags[kFLAGS.SHOULDRA_TONGUE_LICKS_TIMES] == 0) outputText("\n\nAlmost shocked enough to wrest control away from your companion, you begin to babble dissent and try to reel your lengthening tongue back in to no avail. Shouldra stops for a moment, quite frustrated by the interruption. Sitting straight up, she consoles you, \"<i>Relax, Champ, it'll stop feeling weird in a minute and you know it's all temporary.</i>\"\n\nGranted a moment to adjust, you let yourself settle down and hand her the reins once more.  She happily goes back to ");
		else outputText("\n\n  She happily continues ");
		outputText("sliding fingers along the wet appendage, humming a little tune over your tongue until more than a foot of it droops from your mouth.  \"<i>Now we're getting somewhere,</i>\" you hear her thinking as she works her magic.  There doesn't seem to be a limit to how much she can pull out of your mouth, and soon she has more than three feet of pure tongue coiled in your lap.  Furrowing your brow in concentration, she tries to move your tongue about, but can't manage to wiggle more than the tip. \"<i>Too thin,</i>\" she mutters, \"<i>much too weak. Doesn't feel right...</i>\"");
		
		outputText("\n\nTaking the midsection of your tongue in your hand, she slowly starts to rub her hand along some of its length.  It feels... odd, somehow, but not entirely unpleasant.  Though you shudder at the first rub, they start to feel more natural as she pushes you on.  Actually, it feels sort of good.  Her strokes remain constant, though some part of you wishes she'd go faster.  It doesn't even register as odd in your addled mind that your tongue is swelling in your hand with every stroke.  Shouldra starts to make wider movements along your smooth stretch of muscle.  Its girth plumps up to fill your palm nicely wherever she brings your hand, and the strange sensations of your flesh on its nerves wrack your body with shudders of pleasure even through Shouldra's grip.");
		outputText("\n\nThough it's not just you feeling this anyhow.  For her part, your pale possessor seems to be enjoying this odd process even more than you are.  She pants in time with each and every stroke, occasionally rolling your neck and letting out a soft moan as your spine arches.  You surmise that she's somehow bumped up the sensitivity of the nerves on your tongue to rival that of those around your true sex, and rewired you to experience each touch in the same way.  By the time Shouldra reaches the end, your tongue is long, thick, and nicely tapered at the end, and she's having a hard time keeping your weight up as the pulses of pleasure rush through your body.");
		outputText("\n\n\"<i>That's... yeah, that's good,</i>\" she breathily determines.  With just a bit of its weight supported by your hand and a lot of concentration on her part, Shouldra manages to snake your tongue down to your cunt, still dripping need from the earlier licking.  With a little shake the first foot or so of your lengthy stretch goes rigid. After a few probing pokes against your labia, she unceremoniously penetrates the appendage deep into your waiting honeypot.  The dual pleasures of your tongue and your cunt set your senses aflame, and your inner lust roils as the sensitive skin of your tongue caresses every nook and crevice of your sex.  Shouldra lets out a little squeaking noise, obviously even catching herself off-guard with the potent mixture of feeling.  She abandons trying to keep your body upright and topples onto your side.  She rolls you onto your back and arches your hips, moaning like a whore as your tongue shlicks in and out of you, slapping lewdly against your skin with each thrust.  Shouldra claws at the grass and dirt with your free hand, desperate to hold on to something as the whirlwind of pleasure tries to whisk her away.");
		outputText("\n\nStuck in your mind as a helpless onlooker, you're forced to just ride out the storm.  You feel <b>everything</b> so clearly; every blade of grass tickling your shoulders, every drop of saliva smeared across your swollen [clit], every hard press of your possessed tongue against your craving walls.  It all feels like so much, like the pleasure is burning you so hot that it's going to tear you apart from the inside and drive you insane.  Your follower, apparently in possession of quite a will of her own, manages to overcome the feelings just long enough to roll herself onto her side and grab for the dildos.  She manages to drag them back, and all you can do is pray that they'll make this release come faster, as the buildup is especially torturous under the circumstances.  Now more confident in her ability to keep your tongue moving, she releases it, and reaches for the pair of phallic toys.");
		outputText("\n\nOne in each of your shaking hands, she flops onto your back once more.  You hear a strained voice from within telling you to \"<i>get ready</i>,\" just before Shouldra jams one dildo in your cunt and crams the other in your mouth.  Their bumpy surfaces tickle the nerves of your tongue so perfectly and they make you feel so wonderfully full that thoughts of the agonizing wait you had to endure is dissolved almost immediately by orgasm.  Shouldra screams out around the one in your mouth, muffled wails of pleasure echoing among the rocks.  A tasty gush of your juices splash out over your tightly-packed tongue and onto your thighs and the ground.  Your vision begins to fade even before the  feelings of release leave you.  By the time it has and your tongue starts to shrink back to its usual size, you're gone, floating unaware on a cloud of post-orgasmic bliss.");
	}
	player.orgasm();
	dynStats("lib", .25, "sen", -2);
	outputText("\n\nYou wake some time later, lying naked beside a pile of your [armor].  You're right back at camp.  The ghost girl managed to drag you back somehow - no doubt interested in keeping the location of her secret goodies safe.");
	shouldraSleeping((10 + rand(26)), true);
	flags[kFLAGS.SHOULDRA_TONGUE_LICKS_TIMES]++;
	doNext(camp.returnToCampUseOneHour);
}


//SHOULDRA DREAM/TALK SHIT
//General structure: dreams trigger roughly a week after one another, each unlocking a corresponding talk scene until eventually leading to the 'climax'. Each dream is the PC reliving a memory of Shouldra's from her pov.
//Dream 1 - First Possession
public function shouldraDream1():void {
	outputText("\n");
	spriteSelect(67);
	//triggers one week after obtaining follower Shouldra
	//Shouldra's first experience with actual possession.  Targets a human (or furry?) Her introduction to how she can't fulfill any of her basic cravings - particularly sexual ones - without a host
	if (flags[kFLAGS.SHOULDRA_PLOT_LEVEL] == 0) {
		outputText("How many days has it been? Maybe it's been weeks now.  The only thing you've been focusing on is running, running as far away as you can.  You're surprised at your newfound endurance.  Seems like you've been able to do anything you've put your mind to, free from any sort of mortal constraints or limits.  But your frustration has made plain to you new hurdles.  As time slips by and old wounds begin to mend, these hurdles grow closer... grow larger, more imposing.  You can't ignore them any longer.  You involuntarily obsess over them.");
		outputText("\n\nYou can no longer partake in simple pleasures once taken for granted.  Touch, taste, feel... they seem so natural, which makes their absence so maddening.  You no longer starve, yet you feel hungry.  You no longer grow exhausted, yet you yearn for sleep.  You no longer feel pain, yet you crave any sort of sensation.");
		outputText("\n\nWithout thinking, your smooth hand reaches between your legs...  Same disappointing result.  You know something is there.  You can see it.  You <b>think</b> you can feel it; you aren't numb or tingling.  But the sensation is gone.  It's a pussy without a pulse, a moist, empty cavity.");
		outputText("\n\nEach hollow sordid act only drives your resolve, however.  You refuse to just wallow in self-pity.  You got yourself into this situation... In for a penny, in for a pound as they say.");
		outputText("\n\nSomething catches your attention.  A figure is coming into view, forming from your murky surroundings.  It's a tall woman.  She's alone, sitting underneath a tree in who-knows-where, enjoying a book she brought along with her.  It's been so long since you last saw someone - not an animal, but a being capable of thought.  Maybe you should approach her and...");
		outputText("\n\nNo, wait.  You have a better idea; it's just a theory, but it's a sound one.  You look yourself over, double checking your body for any irregularities.  A satisfied smirk admits to your pride; looks like you can maintain your form without too much concentration now - quite the achievement.  But this is only relevant if you get caught, of which you won't.  Slowly, you approach the woman, careful not to make even the slightest sound.  It's as if your feet aren't even touching the ground.");
		outputText("\n\nYou're hanging over her shoulder now.  She still has no clue you're there, preoccupied by her entertainment.  You were afraid some sense of foreboding would at least trigger her to lurch around or something.  Hesitation is starting to creep up your spine.  Are you certain you can pull this off? What if something were to go wrong? What would the consequences be?");
		outputText("\n\nDamn the consequences.  This is worth the risk, you reassure yourself.  Your mind is focused on your objective, certain of how you can do this.  You will do this.  The woman screams as you reach for her, your hand diving deep into her bare shoulder.  Instinct takes over as you continue to push yourself inside the damsel, ignoring her pleas and passing through her struggled swings.");
		outputText("\n\nIt's dark.  Completely black.  But you can see.  You can see everything.  Looks like step one went according to plan.  However, your foresight didn't include this overwhelming deluge of thoughts, emotions, memories, and instincts.  A lesser being could lose themselves like this, subsumed by the sheer might that is the entirety of a being.  But fuck that.  You're better than even above-above average beings!  Fueled by determination, a singular vision comes into focus.");
		outputText("\n\nYou're back by the tree, surrounded by haze with a discarded book by your feet.  You stare down at your hands... your imperfect hands.  Slowly they touch one another... you can feel their warmth.  They dart for your face.  It feels so alien to you, yet so natural.  It feels as natural as your own body feels... once felt, not at all while wearing a suit as you had imagined.  You've successfully possessed the woman.");
		outputText("\n\n\"<i>Yes!</i>\" you shout, your host's voice echoing through the unseen wilderness.  Raising a fist to your lip, you concentrate for a moment.  \"<i>Yes,</i>\" you utter, this time in your own tone.");
		outputText("\n\n\"<i>What do you want from me?</i>\"");
		outputText("\n\nThe pleading voice of the woman is present, seeming as if to reside beside your own.  You ignore it; there's enough on your plate as it is, and you aren't in the mood to chat.  But you'll show her what it is you want from her.  Absent of any and all subtlety, you tear the woman's garments to shreds, eager to get to her pussy.  This is the moment you've been pining for, desperate to know if you'll ever re-experience this feeling.  The woman's consciousness screams and begs; parts of her body tremble as she regains some sort of control.  In your unwavering persistence, you lose track... lose feeling of unimportant aspects of your host.  Your perception never wavers, however, even when you relinquish control of it to the woman... Maggey, as it turns out.  She's a...");
		outputText("\n\nNo, you don't care about her.  It's the only way you won't lose yourself in this woman.  Never get too attached.  You're here only for yourself.  You reassure yourself repeatedly... until your hand finally reaches its prize.  Her pussy feels wonderful... your pussy.  Just as well as you can feel with her hands, her cunt floods you with pleasure.  It's as if you've been crawling through a desert for months to only finally realize the taste and moisture of water on your lips, a sensation you had once thought lost.  You begin to lose yourself as your borrowed hands explore the vaginal walls, your moaning intertwining with that of your host's.  It feels so heavenly.");
		outputText("\n\nBetter than anything you could possibly recall.");
	}
	else if (flags[kFLAGS.SHOULDRA_PLOT_LEVEL] == 1) {
		//Dream 2 - First Transformation
		//triggers one week after Dream/Talk 1
		//Shouldra's first attempt with unfamiliar magic. Tired of the same old boring masturbation, she attempts just simple body inflation. (Target TBD) Has poor results, but exciting for her nonetheless
		outputText("With a mighty crack of your fist straight to her midsection, the young woman goes crashing down to the cobblestone path.  You mark your victory with an arrogant thumb flicking your nose, relaxing from your boxing stance.  \"<i>Taking my targets head on is definitely easier than sneaking up on them,</i>\" you think to yourself while admiring your catch.  It's a lucky one at that; you managed to snag a human woman, probably in her mid-to-late 20s.  A sexy little thing that - as it turns out - can't fight for shit.  Your hunch about these farmhands was as spot-on as all your hunches turn out to be.  You may as well call them fact right from conception!");
		outputText("\n\n\"<i>What the fuck do you want!</i>\" the blue-collar bitch shouts, trying her best not to let you catch on to how she has yet to recover her breath.  You strip free of your light tunic and stride up to the sore loser, planting your foot in her gut.  Leaning down over your knee, you share with her the smuggest of grimaces, \"<i>I want what any man would want out of you, lady.</i>\" Your plain figure suddenly glows with a blazing ethereal light, filling the poor hired hand with fear.  Your body glares brighter and brighter until you suddenly force it directly into the wench.");
		outputText("\n\nYou're shrouded by familiar darkness again, surrounded by the wholeness of one's being.  It's hardly much of a distraction to you at this point, however.  In just a few short moments, you gather your bearings and find yourself fully in control of the helpless farmhand.  You guide her hands along her slender figure, collecting a brief summary of the goods on display.  Perky b-cups, your normal pussy, a tight ass, all things you've come to expect from the females you find.  With the inventory done, you proceed to remove all articles of clothing from your new body.  No ripping or shredding, of course; you may be eager, but you're no savage!");
		outputText("\n\n\"<i>Looks like you've done pretty well for yourself,</i>\" you announce to seemingly nothing.  But you're fully aware she's listening in.  You're surprised by her silence; most of your clientele like to try and fight.  \"<i>Awful shame that that doesn't amount to much these days.  Men trip over assets like these out in the streets everyday.</i>\" Still no response.  Clammed up either from fear, curiosity, or anger perhaps...you honestly don't care enough to find out.  You lock her fingers, turning them and stretching outwards to prepare the digits for the tasks you plan to put them through.");
		outputText("\n\nHer fingers go straight for her clit, your skilled expertise guiding them with pinpoint accuracy.  It feels wonderful, just as it always does.  You could certainly get off with this...  at least you think you could.  Exploring everyone's nether regions has never stopped filling you with the sensations you crave, but the satisfaction is starting to wane.  It's been almost eight straight years of fingering, insertions, groping.  What else could you do to change things up?");
		outputText("\n\nYou let off the woman's snatch, instead lifting her pussy-smelling hand under her nose as you begin to think.  You're a creative ghost.  There has to be something you can - wait, of course.  Your arcane arts! The magic you spent your... life... obsessing over! Surely you can bend it enough to indulge your lascivious libido.  You dig through the woman's knowledge of the surrounding area, discovering a small nearby shed that would be perfect as the birthplace of the rest of your afterlife.  As you turn and begin in it's direction, the caged soul finally decides to speak up, \"<i>W-where are you taking me? I-is my body not good enough for you or something?</i>\"");
		outputText("\n\n\"<i>No, but it will be.</i>\"");
		outputText("\n\nIgnoring the pleading of the now-spooked farmhand, you saunter into the dusty shed, a cool breeze teasing at your naked behind.  It's a small little workhouse, not much more than a counter, some stools, a stack of farm tools, and various other knickknacks these yokels depend on.  Moving some of the useless equipment out of the way, you pull out a large mirror, its location given away involuntarily by your gracious host.  Removing its protective covering, you're greeted by the rather austere figure of the farmhand and her lovely yellow glowing eyes.  You lean the glass up against a wall and drag one of the stools in front of it.");
		outputText("\n\nYour mind races through your almost encyclopedic knowledge of the occult, trying its best to discover how to bend it to your lecherous whims.  As you mull over the possibilities, you again guide the woman's hands around her body, then begin massaging her breasts.  You know what you want to try first.  Holding the modest melons up, you decide to adlib a spell.  You pronounce each ancient syllable with exact certainty, applying just enough emphasis or stretching any key pronunciation where needed.  Your efforts are rewarded when you detect a warm tingling sensation racing through the woman's chest.  A proud smile wiggles its way onto her mouth as you enjoy the fruits of your labor, her swelling tit.");
		outputText("\n\nThat's right.  Tit.  One.  A precious, luscious, miraculous D cup hanging out next to an unaltered B cup.  The destruction of symmetry staring back at you in the mirror is taunting you with how ugly it appears.  Ignoring the sobbing in the back of your head, you grasp the odd duckling with both hands as you consider what went wrong.  Planting both mounds firmly in palms, you repeat the spell, paying close attention to your enunciation while making corrections.  Both chest bumps grow out another couple of cup sizes, but remain lopsided.  You stare in the mirror for a bit, ogling the asymmetrical fun bags.  Despite their mismatching, they still feel fantastic, you find.  You even managed to work in some lactation!");
		outputText("\n\nYou manage to pull yourself away from fondling your knockers long enough to spread your legs, eyeing the farmhand's succulent snatch in her reflection.  You mull over the appropriate spell for a moment, not wanting a repeat performance.  Confident you've sussed out the details, you give it a shot.  Right on the cusp of the final utterance, the woman's pussy swells in size, pressing up against her legs and making her crotch incredibly warm.  The sensation of the spell alone is making you incredibly horny, as it turns out.  Your hands anxiously dive in, exploring your success.");
		outputText("\n\nA pleasant, yet surprising side effect of your prowess is that the enhancement doesn't just increase mass, but seems to really jack up sensitivity, too.  Your simple poking, prodding, and rubbing has made its way through to your cellmate, causing the otherwise frightened female to essentially melt in your hands, overwhelmed by your sexual provocations.  Reinvigorated by your happy hostess, you set to work, exploring your fine craftsmanship.  It's only going to get better from here...");
	}
	else if (flags[kFLAGS.SHOULDRA_PLOT_LEVEL] == 2) {
		//Dream 3 - "Recent" Goblin Possession
		//triggers one week after Dream/Talk 2
		outputText("Few things more relaxing than heading home after a day of work.  But as you approach the dilapidated hut, some strange noises from within catch you off guard.  If it's that fucking mouse again...");
		outputText("\n\nYou peek around the door frame, catching a smug goblin rummaging around your shit!  The bitch is trying to get into your chest!  You start grinding your teeth and rubbing your knuckles when the monster gives up.  Maybe you don't need to - wait, the goblin is peering around.  Is she looking for something or... now she's pissing on your FUCKING FLOOR.  Who fucking does that!  Sure your digs are only half-standing, but they're YOURS.  As the little piece of shit stretches her shoulders and walks away from the scene of the crime, you decide a pummeling isn't nearly enough punishment.  You have something much more up your own alley of justice.");
		outputText("\n\nYou stalk the goblin for a few minutes, watching her confident stride while rolling a bottle around in her palm.  Certain your path is clear, you let go of your form and slip inside her as an unassuming wisp.  A cold shiver works up her spine and her eyes bother her a little as they change color, but otherwise she's none the wiser.  Where you would typically ignore personal details, you instead read the literal homewrecker like an open book.  You quickly absorb her fears, her problems, her hangups, her history, anything you can employ in your quest for vengeance.  It quickly dawns on you: you've hit the jackpot of bad baggage.  Anyone else that would have laid eyes on what you have would probably empathize with the little beast, but your aim is swift and true, and it will not be dissuaded.");
		outputText("\n\nUnbeknown to the fate in store for her, the goblin continues along on her merry way. You slip into your planned incantation, taking great care to not clue your ride in on a single peep.  It works, and the goblin's breasts tingle with your insidious spell.  The sensation grinds her to a halt, and she's taken aback as her breasts swell up.  It's only a little more volume until they stop; what's really changing are her nipples, each continuing to grow nice and plump.  The goblin isn't the least bit afraid, however; instead she seems to be quite curious and hopeful, even as her nipples seem to bend inwards.  Finally the metamorphosis bears itself: firmly ensconced on both quivering mounds is a pair of perky... lips.");
		outputText("\n\nInterested in trying out her fabulous new accessories (Is she really not concerned at all about this?), the goblin slowly moves a hand up towards her right teat's new pucker.  She's surprised when it starts to move on its own, swishing something around inside its mouth.  It spits out her previously attached nipple piercing.  The goblin motions as if she's about to bend down and retrieve the metal until something attracts her attention.");
		outputText("\n\n\"<i>Why the fuckin' hell would you gouge a perfectly good nipple through a spike?  Are you fucking daffy?</i>\"");
		outputText("\n\n\"<i>Y-you can talk?</i>\" the goblin asks, completely mesmerized.");
		outputText("\n\n\"<i>What are you, retarded?  What do you THINK we're doing? Whistling?</i>\" the other breast responds, her voice a slight octave higher.");
		outputText("\n\nThe weight of the situation finally sinks in for the little halfwit, dashing her excitement and leaving her with only confusion.  \"<i>I've gotta be dreaming,</i>\" she says, looking over her various flasks, bottles and vials to make sure she didn't take a sip of something she wasn't supposed to.");
		outputText("\n\n\"<i>Your shit's all there, idiot.  Pinch me if you think you're fucking dreaming!</i>\"  the right breast shouts. The bewildered little gremlin does just that, causing the tit to thrash around and shout.");
		outputText("\n\n\"<i>What the fuck is wrong with you!</i>\" the left breast shouts.  The goblin becomes worried, \"<i>She said to-</i>\"");
		outputText("\n\n\"<i>It's a goddamn saying, you looney bin.  I didn't think you were daft enough to do it!</i>\" the right breast interrupts, still wiggling around trying to shrug off the wound. \"<i>It's no wonder we're so tiny if this is the captain of the ship.</i>\"");
		outputText("\n\n\"<i>Now hold on just a-</i>\"");
		outputText("\n\n\"<i>If this moronic bitch still can't get fucking pregnant, then we'll never get to grow up nice and huge.</i>\"");
		outputText("\n\n\"<i>I'm trying to-</i>\"");
		outputText("\n\n\"<i>Look, just give me your hand.</i>\"  The goblin looks around desperately, her right breast's request making her incredibly nervous. \"<i>I don't have any teeth!  I can't bite you!  Now come on!</i>\"  She carefully raises her trembling right hand in front of the lecherous lips.  They quickly surge forward, consuming her entire hand!  A bewildering blend of pleasure and fear overtakes the goblin as she tries to extricate her hand to no avail.  Her tit begins licking it excessively, coating it in some sort of liquid.");
		outputText("\n\n\"<i>Do you know what that is?</i>\" the left breast asks.");
		outputText("\n\n\"<i>A-a tongue?</i>\" the goblin replies meekly.");
		outputText("\n\n\"<i>Of course it's a fucking tongue!  I'm not talking about the goddamn tongue!  What I'm talking about is the fucking breastmilk!  The stuff you make when you fucking get PREGNANT.  I know this is a foreign fucking concept to you and all, but I'm not about to host a lecture long enough to get it through your fucking skull.</i>\"");
		outputText("\n\nBefore the perturbed goblin can even attempt to respond, she's taken aback when her snatch suddenly swells up considerably.  The puffy pussy slams shut and begins to quake, almost dragging the poor gal to her knees with the intense vibrations.  Her nether-maw finally reopens, torrents of vaginal drool pouring down her legs.");
		outputText("\n\n\"<i>You think you have it bad?</i>\" the twat suddenly asks... in a rather masculine tone, \"<i>Ask sleeping beauty here the last time I got to suck a phallus that wasn't made of plastic.  Let me just cut to the chase: it's never happened!  Not once!</i>\"");
		outputText("\n\nHer fear turning to anger, the goblin clenches her legs shut in an attempt to silence her animated alleyway.  \"<i>Yeah! Close him up like you always do!</i>\" her left breast chides.");
		outputText("\n\n\"<i>Just shut up!  All of you!  I'm TRYING.  It's HARD.</i>\"  The goblin's resolve quickly weakens when her cunt vibrates again.  That and the ongoing bizarre show with her right hand trapped in her slobbering tit loosens her legs' hold.");
		outputText("\n\n\"<i>Malarkey.  Who's ever heard of a virgin goblin?  What, do you expect me to just hunt down a penis for you?  It ISN'T hard; half of everything that breathes around here has a cock!  A life of celibacy isn't high on my list of desirables, kid.</i>\"");
		outputText("\n\nThe goblin is getting flustered as her sexual troubles cascade into the open from her sexual tools.  \"<i>You know, what's the fucking hurry with you guys?  I'm young!  There's time!  I'll figure it out!</i>\"  She's resisting.  You decide to twist the knife.");
		outputText("\n\n\"<i>What would your mom say!</i>\" the belligerent box yells, vaginal spittle going everywhere.");
		outputText("\n\n\"<i>Don't talk about my mother!</i>\" the goblin shouts back.  It's clear to you by now that she's somehow accepted her unnatural predicament.  This was even easier than you expected it to be.");
		outputText("\n\n\"<i>She had the right fucking idea when she left you behind to chase after some other fucking dick!</i>\"  the left breast chides as she drools a little milk, spurred on by her enthusiastic \"sister.\"");
		outputText("\n\nThe ruffled goblin tries to pull her hand free again, but the determined right teat just tugs back, refusing to stop smothering and engulfing the trapped hand despite having long since lost the point of the action.  Giving up with a frustrated sigh, the goblin resumes the shouting match, \"<i>Why did she leave dad?  It doesn't make any sense!  He gave her everything she wa-</i>\"");
		outputText("\n\n\"<i>Maybe if you had been a better fucking daughter and not a fucking timid cunt none of this would have happened,</i>\" her left breast plainly states.");
		outputText("\n\n\"<i>You know, maybe you could go chase down his dick...</i>\" her eager box suggests, his slobber only increasing at just the mere thought.");
		outputText("\n\n\"<i>I-I'm not into incest!  Dad took care of me wh-</i>\"");
		outputText("\n\n\"<i>You fucking... you go on about how hard a fucking dick is to catch when there's one fucking right in front of your fucking face!  Are you fucking kidding me!</i>\" her annoyed flesh shouts, knocking into the right one.  It gives off an annoyed muffled moan, only increasing its work on the captured hand.");
		outputText("\n\n\"<i>Maybe that's why your mother ran out on you,</i>\" the rather blunt vagina ponders out loud.");
		outputText("\n\nAlmost got her.  The goblin is speechless now, anxiously trying to find how best to come to her defense.  Her angry drooling tits, unique hand \"massage\" and wet, quivering pussy with a strangely arousing male voice are starting to take their toll, though; the overstimulation is sending mixed messages that clash with a gal trying to win a war of words.");
		outputText("\n\n\"<i>All that matters to me is that you at least go out there and get me a nice, juicy dick to suck on, kid.  Fill me up!  I know you want it,</i>\" the vagina calmly states, further disarming your quarry with the sudden sympathetic tone.");
		outputText("\n\n\"<i>I know.  I've been try-</i>\"");
		outputText("\n\n\"<i>Fuck your 'trying' shit.  You're not going to get fucking pregnant and I'm not going to get fucking big if you're just tiptoeing around with this 'trying' crap.  Just fucking get it done!</i>\" her breast interrupts.  She's starting to tear up now, dribbling out excuses or confessing to how hard it is.  You've worked her down with broad strokes followed by precise strikes...");
		outputText("\n\n\"<i>And when am I going to get to see some action?</i>\" whines her asshole in a low, gravelly voice.");
		outputText("\n\n...No better time than now to hit her with the left cross.  The goblin's eyes go wide as she peers back over her shoulder, doubting her ears and the additional confusing sensations originating from her rear end.");
		outputText("\n\n\"<i>You've never even bothered with me!  Not even experimented!  Think of all the ass-loving men out there that I could reel in.</i>\"");
		outputText("\n\n\"<i>Shut the fuck up!  Who fucking cares about anal?  How is that fucking going to help us out any?</i>\" the increasingly agitated breast asks, wiggling underneath the goblin's armpit to try and make clear who she's speaking to.");
		outputText("\n\n\"<i>You guys moan about your lack of action!  Try seeing nothing at all.  I'd GLADLY suck down one of those dildos!</i>\" her asshole whines, gaping wide to further illustrate its point.");
		outputText("\n\n\"<i>You aren't missing much,</i>\" the vagina responds with a loud slurp.");
		outputText("\n\nThe life is starting to disappear from the goblin's eyes.");
		outputText("\n\n\"<i>Don't fucking tell me what I'm missing out on!  You suck on her fingers every night!</i>\"");
		outputText("\n\n\"<i>You're a fucking asshole!  Literally and figuratively!  Why don't you shut the fuck up and- </i>\"");
		outputText("\n\n\"<i>How about fuck you!  I'm ALWAYS forgotten and-</i>\"");
		outputText("\n\n\"<i>You BOTH need to quiet down!</i>\"");
		outputText("\n\n\"<i>Oh, so you're fucking with-</i>\"");
		outputText("\n\nEverything's arguing all at once now.  Her canal is moving a mile a minute, absolutely drenching her legs.  Her right breast is still sucking, slobbering, and salivating away.  Her left breast is trembling, shouting louder and louder as it flails about.  Her entire ass in getting into the altercation, its cheeks flapping about in an attempt to make itself more pronounced.  It's fucking hysterical.  Not much longer until...");
		outputText("\n\n...She snaps.  The goblin tries to pull her hands to her head, but only manages the one.  Her screaming overpowers every other voice.  It's music to your ears, wherever they are.  As the destroyed little monster falls to her knees, her every orifice begins to laugh.  Slowly they all join in unison, their voices altering into one single tone.  When screams turn to tears, you take your cue and swiftly depart your defeated opponent.");
		outputText("\n\nHer wide, quivering eyes slowly work their way up from the ground to witness you as you reassemble your typical form.  The goblin's mouth droops open and her hand finally falls free from its tit cell, a small geyser of milk coming out alongside it.");
		outputText("\n\n\"<i>And that's why you don't fuck with my stuff!</i>\" you shout, turning back to a wisp and leaving the miserable creature to her miserable existence.");
	}
	if (flags[kFLAGS.SHOULDRA_PLOT_LEVEL] == 3) {
		//Dream 4 - Backstory
		//triggers one week after Dream/Talk 3
		//Basically, her village was raided by orcs (which I'm pretty sure existed hundreds of years ago as well, since they're not demons), and the females were taken alive for the obvious reasons. Orcs would act like a far more primitive version of the factory; just pumping semen into the girls until they're constantly cock-hungry. Shouldra manages to retain enough of herself due to some knowledge of the arcane, separates her soul from her now-disgusting (to her) body, and flees.
		outputText("Your eyes snap open with the first horror-filled scream.  You tumble off your bed, running to the door and throwing it open.  You run out into a milling group of townsmen, gaze directed by the frantic gesticulations of the town sentry.  There, merely hundreds of yards off, approach a horde of figures illuminated by dozens of torches.  A shudder runs through most of you at the sight of the oncoming mob, but none of you attempt to flee.  The militia move back into their homes to fetch their weapons, and you, for better or worse, are, the head sorceress of the village.");
		outputText("\n\nYou've appealed to the elders about building a damned wall several times, but they remained resolute in their senile justifications; no raiding party would bother to hit this out-of-the-way town, populated by merely several hundred citizens.  Morons.");
		outputText("\n\nWell, there's nothing for it, you figure.  You stand off to the side as the defenders, as armed and armored as they could manage, walk past you, forming a rough approximation of a phalanx as they prepare for the shockingly close... dark orcs, you recognize them as.  You've never liked orcs.  Hopefully you'll be able to take a few out before they overwhelm you all.");
		outputText("\n\nNervous militia shift around as the orcs draw ever closer, and as you take your position on a sizeable boulder some distance to the left.  You prepare as many destructive spells as you can manage, picking out individual targets based simply on ugliness.  The orcs break into a charge; you begin casting your first spell, a large and assuredly deadly fireball to cast into the middle of the horde.  Fifty paces off.  You roll the fiery pea around your fingertips, hoping a show of magic might demoralize the assholes a bit.  You even manage to entertain a fantasy of the orcs breaking against the defenders' might.");
		outputText("\n\nNone of you stood a chance.  The front line of berserking beastmen break your defensive line like water rushing through reeds.  Not even your magic managed to dent their ranks adequately.  Too stubborn to flee, you continue blasting the barbarian assholes with your arsenal of magic until the last possible moment.  With a resigned sigh, you launch into the invocation to teleport to the other side of the village and make your escape.");
		outputText("\n\nYou nearly make it, too.");
		outputText("\n\nA hurled club smacks into your temple, shattering your earthskin enchantment... and quite possibly your skull.  You tumble off your perch and slam heavily into the ground, struggling to get off the ground, to escape.  A green calloused hand reaches into your fading peripheral vision, snatching a handful of your hair and dragging you to his shoulder.  A dripping trail of blood.  Flames.  A snarling, victorious, monstrous face, shoved up close to yours.  A ringing in your ears.  Darkness.  Silence...");
		outputText("\n\nYour eyes flutter open, vision still fuzzy from the blow to your head.  You slowly realize a chafing in your wrists; you try to move them, but to no avail, other than the creaking of leather.  From what you can gather from your immediate surroundings, you're... in the town hall.  It seems the raiders only burnt some of your town.  Casting a quick glance around, you notice other young women strewn about everywhere; some strapped to walls like you, some bound and tossed to the ground, and some dragged to vacant spots to entertain the invading party for a while before being shed aside once more.  The ringing in your ears subsides just enough to force you to listen to the myriad grunts, yelps and moans.  You groan softly, a dull throbbing keeping you from falling back into merciful darkness.");
		outputText("\n\nAn orc, noticing your rousing, approaches, grabbing your chin and lifting it towards him.  \"<i>Yer a pretty one,</i>\" he growls, sneering lustfully at your pitiful condition.  You spit a dislodged molar and a spray of blood into his eyes, and he falls back with an angry cry.  \"<i>The damn bitch blinded me!</i>\" he screams, alerting two other green-skinned bastards.  You tense up for a cuff from one of the orcs, but both merely chortle at your spirit.  \"<i>This one will be fun,</i>\" one said, drawing an ominous-sounding chuckle from the other.");
		outputText("\n\nYou fix them with your most hateful snarl, already plotting your escape and subsequent revenge, when the first orc storms up, unceremoniously grabbing your jaw and wrenching it open.  He motions to one of his companions, who hands him a large hose.  Even as your mind registers the purpose of the brutish instrument, the tube is shoved down your throat, nearly suffocating you.");
		outputText("\n\nHorrified, you cast a glance to your left, where the other end of the hose ends in a large funnel.  As you watch, half a dozen orcs gather around, shifting their loincloths aside and... oh, dear gods, you realize, eyes widening so wide they nearly roll from your sockets.  You put up a mighty struggle, rubbing your wrists raw as you tear against your bindings... to no avail.  The first salty taste sends a mighty shudder through your slim frame.  You try your hardest to dislodge the offensive hose, but it's simply too far in; you don't have any room to maneuver it out.");
		outputText("\n\nThe alabaster flow begins in kind, choking you with its viscous and creamy abundance and forcing you to swallow just to draw breath.  The flow doesn't stop for a long, long while.");
		outputText("\n\nThe next day, they push you even longer.");
		outputText("\n\nAnd the next.  And the next.");
		outputText("\n\nTwo weeks have passed, and the orcs still seem content to entertain themselves with you and the other women in the remains of your former village.  Your body has become a curvy abomination; blimp-like tits and ass, a permanently cum-stuffed belly... and... you like it.");
		outputText("\n\nAn orc passes by, and you can't help but call him over.  He chuckles, marvelling at how effectively your mind has snapped under the crude tactics of the sex-craven race.  Even as he approaches and shifts his loincloth off his already-stiffening rod, you open wide and moan happily, jealous of some of your neighbors' truly prodigious measurements.  You're nearly lost in the wonderful sensations of your masters' dicks, the jiggling mass that has become your body.");
		outputText("\n\nAlmost.");
		outputText("\n\nWith the concentration and willpower characteristic to practitioners of magic, you manage to retain moments of precious clarity.  In the days that follow, you slowly, so slowly devise a plan of escape.  You almost manage to not dwell on the pitiful odds of the plan working.");
		outputText("\n\nAs soon as your next flash of cognizance strikes, you launch into frenzied spellcasting.  You're nearing the end of the spell when the density of your lust-crazed self begins rearing up to you.  Fighting back the cock-cravings, you bark out the last few syllables before sinking against your bindings.  The orcs, alerted, rush over, and your spirit rises from your broken and disgusting body, eyes burning with the fury of the damned.");
		outputText("\n\nNone survived your wrath.");
		//next page
		outputText("\n\n<b><u>You wake abruptly, heart thrumming wildly in your chest.  Shouldra... You two have to talk.</u></b>");
	}
	flags[kFLAGS.SHOULDRA_PLOT_LEVEL]++;
	flags[kFLAGS.SHOULDRA_TALK_NEEDED] = 1;
	doNext(playerMenu);
}
	
//Talk 1 - First Possession Discussion
private function shouldraYappin():void {
	clearOutput();
	//Plot dreams!
	if (flags[kFLAGS.SHOULDRA_TALK_NEEDED] == 1) {
		//unlocked with Dream 1
		if (flags[kFLAGS.SHOULDRA_PLOT_LEVEL] == 1) {
			//Clear out that talk happened and start a countdown till next dream sequence.
			flags[kFLAGS.SHOULDRA_TALK_NEEDED] = 0;
			spriteSelect(67);
			if (flags[kFLAGS.SHOULDRA_PLOT_LEVEL] < 4) flags[kFLAGS.SHOULDRA_PLOT_COUNTDOWN] = 7;
			//Explanation of why the PC can experience her dreams.  Cagey about past, dodging how she became a ghost.  More focused on why that specific dream is important to her.
			outputText("You decide not to beat around the bush and ask about the strange dream you had the other night.  The spirit puts on a surprised reaction, your shoulder returning to normal as she casually walks outside of your body.");
			outputText("\n\n\"<i>Wait... you saw my dream?</i>\" Shouldra's wispy hand lifts to her lip.  \"<i>I had no idea any fiber of <b>my</b> being would ever rub off on you.  Interesting...</i>\"");
			outputText("\n\nYou express your surprise of a ghost being able to dream in the first place.  \"<i>Who says I can't dream? What else do you expect me to do when you're sawing logs all night?</i>\" Honestly, you're surprised she isn't mucking around with your body at night.  \"<i>Just like when we share a fuck, I can share your sleep.  It isn't like ghosts are known for being very rested, right?</i>\" The ghost girl continues her contemplative stance, trying to make sense of what happened, \"<i>Best I can hypothesize, both of us sleeping is probably as 'in sync' as we ever get.  I can read your thoughts like an open book anytime, but when I'm off my guard and you're WITHOUT a guard... I suppose our thoughts can mingle.</i>\"");
			outputText("\n\nTrying to conceptualize this into something you can wrap your mind around isn't really gaining any traction with you.  Besides, you're more interested in just what the dream was about, and you explain as much to the speculative spirit.  \"<i>Oh, um... well, I believe that was my first flirtation with 'going ghost.'</i>\" Not even her air quotes make that alright, you think to yourself.  Desperate to claw the ghost girl away from her gnawing trademarks, you redirect her focus by asking what she was running from in the beginning.");
			outputText("\n\n\"<i>Myself, honestly,</i>\" she admits coyly.  You're not that naive, though; her horrible answer makes clear to you her question dodging.  It's obviously a sore subject she isn't fond of sharing, so you decide to leave it alone and let her explain herself.  \"<i>I've already made it abundantly clear how much I rely on having a host to experience just about any sort of sensation.  But back then... it hadn't really sunk in.</i>\" Shouldra pauses for a moment, choosing her words carefully.  \"<i>I hadn't been... 'dead' for very long.  Not being able to satisfy basic needs - sexual or otherwise - was still a pretty foreign concept to me.</i>\"");
			outputText("\n\nYou watch the spirit's face closely.  She doesn't seem too upset; aware of how long she's been a ghost, you assume this is something she had long since gotten over and forgotten.  \"<i>I hadn't even considered being able to possess someone before I came across that woman in the forest.  The only thing on my mind before I saw her was living out my life - well, afterlife - in this state of flux, unable to <b>feel</b> joy.</i>\" Shouldra shrugs off her introspective state, \"<i>But then I ran into that woman, things clicked into place, and I had a bitchin' few hundreds of years up until today.</i>\"");
			outputText("\n\nCluing in on her reluctance to divulge any more on the pre-bitchin' years, you instead decide to ask about the woman.  This is probably one of the best leads on humans in Mareth you've ever had.  Unfortunately, Shouldra does not share your interest.  \"<i>Eh, yea humans were a thing a long time ago, I guess.  I was a little more interested in Numero Uno from that point on, though,</i>\" she admits, thumbing herself in the chest.  \"<i>I won't get you very far in any history classes I'm afraid.</i>\" You don't dare ask her straight up - honestly, you doubt you'd receive little more than a sarcastic empty remark - but you can't help but wonder if the otherwise egocentric eidolon hasn't changed her tune even a little since setting up shack with you.  Has she even hung out with any other person for longer than a one night stand?");
			outputText("\n\nThe tangent disappears from your head as Shouldra stares at you, probably curious as to what you're obsessing over.  You redirect her back to the dream, specifically about the actual first possession.  \"<i>Well, I already had a pretty good grasp on the act.  Without divulging much information, let's just say for now that I've always had a unique fascination with magic.</i>\" Tired of pacing around - and potentially trying to keep you from digging too deep again - Shouldra directs you nearby to a little clearing where the two of you sit down, side by side.  \"<i>But all the books in the world don't really prepare you for what's it like.  Like most anything, really.</i>\"");
			if ( player.findPerk(PerkLib.Incorporeality) >= 0) outputText("  Shouldra bumps you to the side a little as she makes her next point, \"<i>Even with your hoaky quasi-possession power, you don't really know what it's like to actually possess someone.</i>\" You look at her funny, unaware that you weren't really getting the full effect.  Not that you care!");
			outputText("\n\nShouldra scootches over against you until almost half of her body is inside of yours.  She moves your arm and [leg] around as she illustrates her next point, \"<i>The expectation is that you're just 'putting on' the host.  Like a glove or a suit.  But the instant you dive inside someone");
			if ( player.findPerk(PerkLib.Incorporeality) >= 0) outputText(" - and I mean <b>really</b> possess someone -");
			outputText(" you find out just how much more there is to it.</i>\" Shouldra directs your hand up, staring at it intently as she sprawls out your fingers, \"<i>You aren't crawling inside a husk.  There's a lot to a living being.  You felt it in my dream.  I know how to deal with it now but back then? It took real determination to not lose yourself in a person.  Even the most boring scumbag has a life's worth of history and an endless program of emotion and thought.</i>\"");
			outputText("\n\nShouldra puts on a mischievous smile, turning to face you, \"<i>That's not to say I never pry, mind you.  Given all the time I've spent with you, I've been able to learn plenty.  Like about your hometown of Ingnam, Champ.</i>\" Shouldra laughs as you shuffle around uncomfortably, the notion of the ghost girl ransacking your mind of its every fiber not sitting well with you.  \"<i>Don't worry your pretty little head over it, though.</i>\"  Your hand reaches down unbidden, grasping at your [if (hasCock = true) [cock]] [if (isHerm = true)  and ][if (hasVagina = true) [vagina]]");
			if (player.gender == 0) outputText("[asshole]");
			outputText(".  \"<i>No matter what treasure trove of knowledge I dig up from you, there's always something I'm more interested in.</i>\"  Your hand lifts back up, and you watch as Shouldra's hand splits off from your own, meeting below the wrist.  She holds your hand with her own ghostly appendage, resting her head on your shoulder.  The ghost girl sits there for a moment, silent, leaving you to wonder if maybe, just maybe, you're starting to mean a little more to her than just a sex toy.");
			outputText("\n\nObviously aware of your inner monologue, Shouldra slips back inside you and digs both your hands into your [armor].  You may not have a clear answer, but you figure you have enough information to come to your own hypothesis.");
		}
		//Talk 2 - First Transformation Discussion
		else if (flags[kFLAGS.SHOULDRA_PLOT_LEVEL] == 2) {
			//Clear out that talk happened and start a countdown till next dream sequence.
			flags[kFLAGS.SHOULDRA_TALK_NEEDED] = 0;
			spriteSelect(67);
			if (flags[kFLAGS.SHOULDRA_PLOT_LEVEL] < 4) flags[kFLAGS.SHOULDRA_PLOT_COUNTDOWN] = 7;
			//unlocked with Dream 2
			//unlocks grow/shrinking of body parts (See next section)
			// Discusses dream with PC, further explaining her draw to magic-infused sex to them. "Imagine decades of the same old masturbation techniques." Eventually transitions to her offering to try and give the PC more permanent changes thanks to "some studying up and familiarity with the PC's body." Large cooldown between offers of at least 3 days
			outputText("Shouldra quickly interrupts you before you can even think to open your mouth, \"<i>So you pried into another dream of mine, huh?</i>\"  You swear it wasn't on purpose, mustering a giggle from the sarcastic spirit as her head recedes back inside you.  The next moment she's walking right out of you, chin resting in her head.  \"<i>I'm positive that I dream about more than shit that happened centuries ago.  Sometimes I dream up things that never happened at all!  I bet you're just cherry picking things you want to bother me about.</i>\"  You shrug, admitting to not really having any control over any of this. Shouldra laughs again, \"<i>Yea, yea, I know.  Still can't help but wonder.</i>\"");
			outputText("\n\nYou decide to veer the ghost away from further speculation, pressing her about the farmhand.  \"<i>If you're asking about humans again, you won't get anything more specific out of me.  This happened centuries ago.  I don't even remember where this was.</i>\"  You figured as much.  \"<i>I do remember hanging around that farmland for a while.  There was a bunch of brats hanging around there making for easy pickings.  That's when I decided to start getting a little more hands-on with my selection instead of having to stalk everything.  I think I wound up scaring the whole lot of them away and moving on from there.  It was a while before I decided to settle down anywhere.</i>\"");
			outputText("\n\nYou wonder just what made her decide to start using magic in the first place.  The typically enthusiastic spirit always seem to enjoy herself enough today, but back then it seemed to you like she just came up with it out of the blue.  Shouldra shrugs and puts her hands to her hips, \"<i>I don't know how plain it was to you, but imagine 8 years of nothing but fucking.</i>\"  Well, that certainly sounds like a splendid way to pass the time to you!  The ghost girl waves you off as you actually accept her daunting task.  \"<i>Believe me, it isn't all you'd think it be.  At least not in my case.  Most of what I ran into that first decade were just humans - Women, mostly. The men were the diamonds in the rough - but it honestly didn't make that much of a difference when I ran into any other race.  Keep in mind that the vast, vast majority of the time for me was spent doing 'solo' actions.</i>\"  You probably know better than anyone just how \"solo\" those actions really were.");
			outputText("\n\n\"<i>Anyway, imagine eight years of just fingering, groping, the occasional dildo-shaped object down your snatch.  Eight years where you never got tired or hungry or chaffed or sore, either.  Sure the subjects come in different varieties - her clit's a little big, this one's got piercings, this bitch got me a dick to play with - but its honestly all cast from a similar mold.  My point is it gets <b>dull</b> after a while. It never stopped feeling good, mind you, but it just stopped getting nearly as satisfying.</i>\"  Sex getting boring sounds like a pretty sad afterlife to you.  Though you would hope that if it were come to that, you wouldn't be nearly as obsessed with it as the fanatical phantom before you.");
			outputText("\n\n\"<i>And you saw my epiphany.  I was already a self-made expert on magic.  Just took some creative know-how to bend that around into something I could use.  It's been smooth sailing from that point on.</i>\"  There she goes again talking about her extensive knowledge of some arcane art form that involves some of the kinkiest sex you've ever witnessed.  You try and ask about it again, but Shouldra shoots you down, still uninterested in divulging something she evidently considers to be very personal.  You accept defeat, instead deciding to question how she didn't come to be just as bored of her enhanced sex as she did the normal variety.  \"<i>Other than the fact that it never stops feeling fucking great?</i>\"  Shouldra pauses for a moment, seriously considering her reasoning.");
			outputText("\n\n\"<i>I've always had a fairly simple rule I try to follow.</i>\"  The ghost girl casually walks up to you and places her hand inside your chest.  Both your hands raise up in front of you, as if you had never seen them before.  It's a little creepy how easily she can manipulate you at this point.  \"<i>Everyone has two of these,</i>\" Shouldra explains.  \"<i>Sometimes three or four or - heaven forbid - one or none... but the bulk of the world has two.</i>\"  Suddenly your right hand magnetizes to your crotch, cupping it fervently.  \"<i>Most people have a one-hand job.  They can handle it themselves, even while doing something else.  I'm not interested in just living out someone else's life.</i>\"");
			if (player.gender > 0) {
				outputText("  Your [if (hasCock = true) [cock]][if (isHerm = true)  and ][if (hasVagina = true) [vagina]] start to swell up; looking up at the ghost, you realize that she hasn't uttered a single word!");
			}
			else outputText("  A fleshy, penis-shaped bulge begins to swell out of your loins; looking up at the ghost, you realized she hasn't uttered a single word!");
			outputText("\n\n\"<i>When I get involved, I turn things into a two-handed job.</i>\"  Your hands move up and slip inside your [armor], sensually massaging your puffing package.  \"<i>Things that are unique to <b>me.</b>  That only I can deliver.  That's my rule.  As long as I'm turning something otherwise ordinary into something extraordinary, I'm never bored.</i>\"  Shouldra casts you a lewd smile, resting her free hand over your over-active bulge.  Your [armor] is only feeling more and more constrictive as your [if (hasCock = true) dick][if (isHerm = true)  and ][if (hasVagina = true) cootch]");
			if (player.gender == 0) outputText("dick");
			outputText(" [if (isHerm = false) continues its][if (isHerm = true) continue their] march of magnification while your fingers vigorously explore their new frontiers.");
			outputText("\n\n\"<i>No potions, no tonics, no needles, no booze, no eggs, nothing.</i>\"   Your genitals pulse adding emphasis to the ghost's boast, quickly plumping up an extra step as your digits dig into your flesh.  \"<i>Nothing but me.  That's what makes me unique.</i>\"  Shouldra undoes your outfit with her free hand, releasing you from your constraints.  Without it in the way, the phantom directs your hands all along your [if (hasCock = true) burgeoning dickflesh][if (isHerm = true)  and ][if (hasVagina = true) widening feminine walls]");
			if (player.gender == 0) outputText("burgeoning dickflesh");
			outputText(".  It takes some gumption for you to work through the arousal and contribute to the conversation, but you manage to point out how you're pretty sure there are other people in Mareth with the same sort of power, to some degree at least.");
			outputText("\n\n\"<i>Maybe demons, I suppose.  I haven't fucked around with them much.  But anyone else is either pumping you full of something or pulling a trick on you.  I'm sure of it.</i>\"  You also point out how her acts lack any sort of permanence.  \"<i>So?  I'm not interested in playing the dick fairy, giving all the good little men and women tree trunks to bring home.  Its always been for my amusement!</i>\"  Shouldra stares at your fattening flesh for a moment, your fingers pinching at your skin as they welcome each new centimeter.  Looks like the jade spirit is actually mulling over your question.");
			outputText("\n\n\"<i>I've never really tried any spells that stick; magic isn't always known for its durability, you know?  Thinking about it now, the biggest problem is just how different everyone is.  Even twins may as well be a world apart when you get right down to it.  I spent so much time with goblins - centuries easily - learning about how their breasts practically change just by looking at them funny.  I never actually realized the breakthrough I made when I got a slight few of their massive mammaries to stick around after I left.</i>\"");
			outputText("\n\nYou're about knocked off your [feet] as your hands go into double time, covering every new square inch of flesh on your midsection.  ");
			if (player.gender == 0) outputText("Your now erect dick is leaking out pre at an alarming rate, which your possessed hands greedly lap up and distribute all along your length.  ");
			outputText("[if (hasCock = true) Your now erect dick is leaking out pre at an alarming rate, which your possessed hands greedly lap up and distribute all along your length.  ][if (hasVagina = true) Your cunt has ballooned up enough to press hard against your [legs], its increased wetness allowing for your hands to effortlessly glide along its canyon walls and north watchtower.  ]\"<i>You know, I've grown so accustomed to your body... I easily understand it as well as my own.</i>\"  You aren't quite sure how reassuring that is, considering her lack of a body, but the point is made just the same.");
			outputText("\n\n\"<i>I'm willing to try and see if I can't get my magic to make for more permanent changes.  And if you change your mind, I'm sure I can shrink it back down, too.</i>\"  Your hands slow back down, back to a more erotic pace, as the ghost girl considers her own ability.  \"<i>I wouldn't want to do it too much or too often; I haven't exactly made it into a science... yet.  But I'm always up for a challenge.</i>\"  Shouldra pays you a warm smile, placing her free hand down on your billowing sex[if (isHerm = true)es].  \"<i>Just let me know if you're ever interested.  I'm sure nothing will go wrong.</i>\"");
			outputText("\n\nOn that unsettling remark, the ghost girl climbs back inside of your body.  Your automated hands finally go limp and the expanding finally ceases, leaving you with[if (isHerm = false)  an extra large sexual toolset waiting for release.][if (isHerm = true)  a couple of extra large pride and joys waiting for the big finale.]  You embrace the ghost's gift[if (isHerm = true)s], wondering if it's worth taking her up on the offer.  Doing your best to ignore her last statement, you continue mulling it over while enjoying your current predicament before it vanishes and returns you to normalcy.  As normal as you ever are, anyway.");
			//Unlocks Grow/Shrink options
		}
		//Talk 3 - "Recent" Goblin Possession Discussion
		else if (flags[kFLAGS.SHOULDRA_PLOT_LEVEL] == 3) {
			//Clear out that talk happened and start a countdown till next dream sequence.
			flags[kFLAGS.SHOULDRA_TALK_NEEDED] = 0;
			spriteSelect(67);
			if (flags[kFLAGS.SHOULDRA_PLOT_LEVEL] < 4) flags[kFLAGS.SHOULDRA_PLOT_COUNTDOWN] = 7;
			//unlocked with Dream 3
			outputText("You stare at Shouldra.  \"<i>Oh, <b>what</b>?</i>\"  You stare at Shouldra.  \"<i>She fucking pissed on my floor!</i>\"  You stare at Shouldra.  The ghost shakes her head, sinking it back inside your skin. The ghost girl quickly flies out of your chest.  \"<i>You don't fuck with my stuff!</i>\"");
			outputText("\n\nYou shake your head and at least confess to how fucked up you found her solution to be.  \"<i>Uh, this just in: I'm a ghost!</i>\" Shouldra says sarcastically.  You surrender to her unique charms, admitting to being <b>completely</b> surprised by her antics.  Knowing that you're at least close to being on the same page as her, the vengeful spirit finally cracks a smile, \"<i>I know that you have yet to bear witness to it, but I do have other hobbies - or did at least.  And when I wasn't fucking <b>with</b> goblins, I was <b>fucking with goblins</b>.</i>\"");
			outputText("\n\nYou grin at her rather candid explanation and take a seat.  Shouldra sits down beside you, eager to continue explaining herself, \"<i>Knocking my rocks off was always high on my list of shit to do.  But I also love just messing with people.  You may know it as 'haunting.'  And you know me; why would I bother with small time stuff like blowing a curtain or pretending to be a dead relative?</i>\"  This doesn't sound quite as innocent as she's making it out to be.  The sight of the crying, soaked goblin alone in the woods certainly didn't paint a pretty picture.");
			outputText("\n\nDetecting your mounting concern, Shouldra decides to pipe up, \"<i>Now, come on.  I'm not 'Shouldra the Friendly Ghost.'  I'm the sweet little gal you met that tried to punch your teeth in so I could have my way with you.  Keep things in perspective here!</i>\"  Well, that makes for a clear enough point.  \"<i>Anyway, when I finally settled down - oh, ten or thirty years ago - I came to discover the local area's just littered with goblins.  You couldn't walk a mile without tripping over one!  Most of them are fairly simple creatures; they just want to fuck and breed and fuck and throw a bottle of something at you and fuck.  Sometimes you could find one with a little more ambition or sense.  Those were my favorites.</i>\"");
			outputText("\n\nShouldra leans back as she reminisces, \"<i>But those ruins were crawling with the little beasts.  I'm sure you won't believe me, but I'm not ALWAYS horny.  Usually, but not always.  And when I wasn't horny, I still loved messing with all those delicate little flowers as they fought over what precious few dicks come out there.</i>\"  Precious few?  You're pretty sure you've been finding things with cocks without too much trouble, telling the ghost as much.  \"<i>Eh, not really the case back where you found me, where I was staying.  And, honestly, looking at my catches over the last, say, hundred years?  If I had to wager to guess... maybe less than ten percent had a fun stick for me to play with.");
			if (player.hasCock()) outputText("</i>\"  Shouldra eyes your [cock] gingerly, acting as if she can stare right through your outfit at it.  \"<i>");
			else outputText("  ");
			outputText("The half-millenium or so of scarcity has really shaped my interests.  I'm at the point now where I just lose it whenever I get these ghostly mitts on a slab of meat.  And the big ones?  ");
			if (player.biggestCockArea() >= 200) outputText("Ones like yours?  ");
			outputText("Then I'm just in heaven.</i>\"  Hold on.  She can turn any dick into a towering monument.  What's so special about ones that come pre-packaged, you ask?  \"<i>I kinda break the one rule I had at that point, but when I find someone with a big boner, it just... feels so good to me.  There's just something about an all-natural magnum opus that just lights my fire.</i>\"");
			outputText("\n\nYou can't help but snicker as Shouldra comes clean with her fetishes.  She smiles and shrugs, \"<i>I am how I am.  That's about the only worthwhile explanation I can come up with.</i>\"  The ghost girl waves her hand around a bit as she tries to divert the discussion, \"<i>Anyway, I'm way off topic.  What I'm getting at is that there were a lot of fucking goblins, and messing with them never got old.</i>\"  The contemplative phantom laughs to herself, no doubt remembering some of her more fond spooks.  You decide to interrupt her aimless gazing, interested in hearing some of her tales of \"horror.\"  You may come to regret it, but you've since learned to try and ignore that sense of foreboding whenever you bump shoulders with Shouldra.");
			outputText("\n\n\"<i>Okay, this one time?  Ran into a couple of goblins.  Best of friends.  Had the whole 'strength in numbers' and 'share the wealth' thing going on.  Things couldn't have been better.  In fact, they got worse when one of them was 'persuaded' into ramming the other one night.  With her unusually large fist.  Into a rather unsuspecting rear entryway.</i>\"  The wraith laughs slyly, unsurprisingly content with her story.  \"<i>You should have heard the scream that bitch made.  It took everything in me to not just burst out laughing.  But here's the 'clench-er'...</i>\"  You imagine the ghost girl will one day regale someone far in the future on how she killed someone with awful puns.");
			outputText("\n\n\"<i>Her hand got stuck!  I didn't even do it on purpose!  I had definitely made my goblin's fist large, but I don't think I did anything to the others' ass.  She must have just clamped down on the intruder naturally.  The sight humored me so much I decided to help things along and really tighten that asshole.</i>\"  Shouldra is interrupted by her own indulgent giggle, her hands pantomiming the goblins' predicament.  \"<i>I wish you could have seen it: two goblins yelling and screaming, running around stuck to one another.  I jumped out as soon as I made the seal, leaving the mystified bitch to try and explain why her hand was lodged up her friend's ass.  Moaning, shouting, apologizing, blaming... man, it was fantastic.</i>\"  You at least admit to how amusing the absurd scenario sounds.  The paranormal storyteller makes no mention of the fate of the two intertwined unfortunates, but you're sure things eventually worked themselves out.  One way or another.");
			outputText("\n\nShouldra laughs again, running a hand through her transparent hair.  \"<i>The vast majority of them are so clueless, so blinded by their huge libidos that they'll just accept whatever crazy shit happens.  I came across one that had JUST managed to catch herself a mighty-fine prize: a lost tiger shark!  Don't ask me how she pulled it off; the shark wasn't a kid or anything, and the goblin didn't seem too particularly skilled.  Not one fucking clue, but I'm sure one of them hoped no one would ever discover what happened that day while the other most likely wanted the whole world to know.</i>\"");
			outputText("\n\n\"<i>Anyway, I was determined to take her beautiful trophy for my own, but I at least had to put on a show first.  I dash unseen into the drugged tiger shark laying flat on her back.  I don't take full control of her; she wasn't in a position to really be doing much anyway, and I get off on the reactions anyway.  The goblin was still prancing around in front of her quarry, too excited to know what to do with herself or something else just as stupid probably.  So the shark's enormous wang 'mysteriously' jumps to full attention, knocking off her skirt and worrying her greatly.  Hell, I think it somehow added on a few extra inches, like maybe another eight or so.  No clue.  But it was rock solid, and she was staring at it like it was the worst fucking thing in the world.</i>\"");
			outputText("\n\n\"<i>Not the goblin, though.  The sight of that majestic meat - an inviting stream of pre running down its length - snaps her out of one trance and puts her in another.  She didn't waste time with any foreplay or potions, just went straight for the impaling,</i>\"  Shouldra's face goes coy, \"<i>But she misses.  The tiger shark's dick flops backward, giving her a cunt full of churning quad-ballsac.  Every time she gets up and tries to land on it, it flings in some other direction.  Whenever she reaches down to try and grab it, the dick furiously slaps her away.  Weird, right?</i>\"  You try to hide a snicker as Shouldra stops to catch a breath, having way too much fun just describing the story to you.  The enthusiastic girl's acting while she recounts her narrative is pretty entertaining.");
			outputText("\n\n\"<i>The tiger shark is just in shock - speechless.  I wasn't really paying attention, but I think I caught her wondering if some sort of divine intervention was saving her life.  How dumb is that?  Meanwhile, the goblin is getting super pissed, surprised at how stinging the mighty phallus' offensive was turning out to be.  She tried just jumping on it finally, smothering it with her flustered goblin bod, but the thing had tremendous strength, catapulting her off!  At that point the tiger shark's dick was super horny, and that fucking goblin was just a nuisance.  The shark starts floating in the air, suspended by her dick!  The goblin's really mad now, afraid of her triumphant story turning into how the big one got away.  She takes a step forward and BAM!  Shot of jizz right in her eyes.</i>\"");
			outputText("\n\nYou palm your face and shake your head.  Shouldra's enthusiastic hijinks are about as paranormal as she is.  \"<i>The goblin starts thrashing around, blinded and fuming.  'I don't have the patience for your lackluster fuckings,' her dick proclaims, dragging the incredibly flustered tiger shark limply behind it as it floats through the air, away from her furious, shouting oppressor.</i>\"  Shouldra stops again, letting off a deep sigh through her ear-to-ear grin.");
			outputText("\n\n\"<i>The rest of that day was pretty great.  I was so full of myself; inhabiting a big dick like that and ticking off that goblin went to my 'head,' so to speak.  At that point, I was just this big, thick rod mindlessly floating through the forest with this poor tiger shark dangling below me inches off  the ground, still paralyzed with shock.  Out of nowhere, she finally starts talking to her dick, thanking it profusely and asking all sorts of questions.  Must have been the blood rushing to her head or something.  It snapped me back to reality, but I kept up the charade, demanding that she satisfy me as payment for my actions.</i>\"  Shouldra shivers a little, the thought of what came next most likely having left a pleasant impact on her.");
			outputText("\n\n\"<i>She was a really good sport, definitely one of my more recent favorites.  I think getting your ass kicked by a goblin, no matter how it comes about, really humbles you.  We spent the whole rest of the day together, me coming up with all these crazy ideas for her to do while I used all sorts of different magic.  She even had some good suggestions on how to have a good time.  I'd really love to tell you about what we did that day sometime; just let me know.  By the time the sun went down, I decided to come clean and introduced the slap happy spirit that had possessed her penis that day.  Again, she was a great sport about the whole thing, only asking I don't go sharing her unfortunate battle outcome.</i>\"");
			outputText("\n\nThe ghost girl takes a deep breath, staring off into the sky.  \"<i>Sorry, Champ, didn't mean to drone on like that.  I could easily spend the rest of your life just recounting all the crazy shit I've done.  I've never really sat down and shared my stories with anyone before.  They just get indexed and filed away.</i>\"  You shrug and wave your hand, letting the spirit know that you actually enjoyed the chance to get to better know who's been haunting you all this time.  The ghost girl smiles and shakes her head, shoving your shoulder a little, \"<i>Let's do it again sometime, then.[if (hasCock = true)   Maybe I could commandeer that [cock] of yours to show you what I did with that frisky shark.  Just say the word]</i>\"");
			outputText("\n\nShouldra leans against you, slowly sliding back into your body.  You count your blessings to not have been born a goblin as you get back off the ground.");
		}
		else {
			//Clear out that talk happened and start a countdown till next dream sequence.
			flags[kFLAGS.SHOULDRA_TALK_NEEDED] = 0;
			spriteSelect(67);
			//Talk 4 - Backstory Discussion
			//unlocked with Dream 4
			//info and possible unlocks TBD
			outputText("\"<i>Oh,</i>\" she says, stepping out of you and sitting herself across from you.  \"<i>You saw that.</i>\"");
			outputText("\n\nYou sit in silence for a long while as she composes her thoughts, the silence only broken by Shouldra's shuddering breathing.  \"<i>Sorry,</i>\" she says somewhat lamely, not knowing how to proceed at all, \"<i>you're actually the first host who managed to catch a glimpse of my... life.  Most were lucky enough to not even see my dreams.  We just fucked the world until I moved on, but you...</i>\"");
			outputText("\n\nShe stops again, drawing her knees to her chest and burying her face into the space between. \"<i>I tried to let the women go, you know,</i>\" she eventually continues, her voice muffled. \"<i>Of the ones that were still sane enough to understand me, they didn't see a point in leaving.  They just wanted to wait until the green men got up and made them feel good again.  And I was so close to being like that, too.  If it wasn't for that lucky-ass spell, I would've died as a bimbo-brained, cum-stuffed slave.</i>\"");
			outputText("\n\nYou can't help asking: if she finds the idea of her own body getting bigger so repulsive, why does she take such pleasure into doing the same to others?  She gives you a wan smile and a little shrug.  \"<i>I didn't say I was completely unaffected by their churlish form of corruption.  I mentioned how much I love dicks, and huge assets are basically a must-have.  Just... my body is mine.  Mine to change, not some slobbering green-skinned lummox.  And such an unrefined technique... The assholes could have at least <b>cleaned</b> the hose!</i>\"");
			outputText("\n\nShe starts rambling and venting, and you let her go off, realizing how long she has been keeping these feelings in. \"<i>If those stupid, grey-haired, liver-spotted, lice-ridden, senile, old fools had <b>listened</b> to me about building some actual <b>fucking</b> defenses, like a fucking <b>wall</b>, maybe we would have stood a ghost of a fucking <b>CHANCE</b>! What the fuck happened to those militia, anyway!?  They were fighting for their families and friends, and they let themselves get slaughtered! If I had the time to prepare some actual spells, things would have been different.</i>");
			outputText("\n\n\"<i>I didn't even have an apprentice!  I knew moving to that rickety old place would be the death of me.... I went to school with this one girl.  Swear to Mareth, her buttcheeks were bigger than her entire body... each!  I got a few girls out, you know.  Managed to usher them to the closest city and let them free.  I hope they made it alright.  I liked them well enough.... I keep on wondering what I could have done better.  If I knew the orcs would be stupid enough to stick around for so long, I could have escaped earlier and at least saved the women....</i>\"");
			outputText("\n\nThis keeps up for at least a couple hours.  Eventually, even though she knows you're listening attentively, she trails off, fixing you with one of the sweetest looks you've ever seen grace her porcelain-looking features.  \"<i>You really care about all this,</i>\" she says softly, startling you a bit.  Of course you care; you agreed to stick around with her, and you don't consider something as easy as listening to her talk her problems out any trouble at all.");
			outputText("\n\nShouldra's eyes waver a bit as she stares at you.  Before you can react, she bolts up to her feet, taking a running step and diving towards you.  Her arms wrap around your neck as she tackles you to the ground, and you happily reach around her to wrap her in a big hug.  You lie there for a couple minutes as she softly sobs the remnants of her sorrows into your shoulder, but she herself eventually breaks the hug.  Sitting back, she lets you free, and you both rise.  \"<i>Thanks, Champ,</i>\" she sighs, wiping her eyes of any moisture.  \"<i>I needed that... for centuries, I needed that.  But we have work to do.</i>\"");
			outputText("\n\nSo saying, she steps forward, shifts into her more wispy self, and re-enters your body.  You're pretty happy with your progress, and a little titter from the recesses of your mind confirms Shouldra's feelings on the matter.");
		}
	}
	//Generic Oni Discussion!
	else {
		spriteSelect(67);
		//Shouldra Talks About an Oni - FC
		outputText("On a whim, you decide to have a chat with your spectral companion, who obligingly pops free of your torso to spare you the awkward sensation of conversing with one of your own body parts.");
		outputText("\n\n\"<i>So you want to hear more about little ol' me, huh, Champ?  How flattering.</i>\"  Shouldra taps one finger against a spectral lip thoughtfully for a second, then nods.  \"<i>Okay.  Okay yeah, I've got one for you.  Hey, listen, you'll like this one.  Promise!  It's really funny, I swear.</i>\"  You raise an eyebrow, but motion for her to continue.");
		outputText("\n\n\"<i>All right, well,</i>\"  she says, already smiling to herself, setting your early warning system a clamour, \"<i>this was a while ago now, back in the village.  Pretty close to where we first met, actually.  So, I'm just wandering along minding my own business-</i>\" She catches your eye and hastily adds, \"<i>Maybe looking for a goblin or two to spook the living daylights out of, when all of a sudden I start to hear singing.  And when I say singing, I don't mean 'Oh, what is that wonderful sound, is that a mermaid,' you follow?  I mean, this was pretty much just verbal abuse that could carry a tune,</i>\" your spectral spirit-guide explains.  \"<i>So, naturally, I'm intrigued.  Anybody brave or dumb enough to start singing at that volume in the middle of potentially demon-infested ruins?  Might be fun to check them out.  As it turns out, there were actually two of 'em, sitting there in the middle of the road, bold as brass and drunk off their asses.  Two girls: some little punk and this huge slab whose dad must have been part brick.  And here's the weird part: both with these freaky horns coming out of their head.</i>\"  She reaches up and extends her index fingers on either side of her head, illustrating the idea of horns.  You assure her that yes, you are capable of comprehending the concept of horns.  Shouldra continues.");
		outputText("\n\n\"<i>Never seen people with horns that big before.  I kind of figured, 'Hey, maybe they have other, equally big appendages,' you know?  Maybe it's their equivalent of shoe size, or whatever.</i>\"  Shouldra pauses for a minute, gazing off into some private inner vision.  You roll your eyes, but decide not to interrupt.  \"<i>So anyway, they're singing, they're laughing, the big one's pointing at the little one, the little one's punching the big one in the face, seems like a fun crowd.  The moment I pop out into the open to make my introductions, though?  Dead silence.  They're staring at me, I'm staring at them, they're staring at each other...  Then they both start grinning.  I mean <b>seriously</b> grinning.  Now, this might seem silly, but I could tell just from the way they were smirking... those two were after my chastity!</i>\" Shouldra announces.  You give Shouldra a Look.  She returns it.  \"<i>Hey, they weren't to know.  Anyway, they both get up and start walking towards me, and I say, 'I didn't like the looks of it one bit.'  So, I decide to make my excuses and leave, and that's when the big one throws the little one at me.</i>\"");
		outputText("\n\nYou can't believe it, and you tell her so.  Shouldra nods, earnestly.");
		outputText("\n\n\"<i>Seriously! The big one just snatches up the little one, screams something like uh..  'Inazuma Fastball Special!' I think it was, then just lobs her right at my face.  Now I ask you, what's the polite way to respond to THAT situation?</i>\"  You shrug.  \"<i>Well, in any case, she missed.  Bowled that little gremlin straight through a wall, wood and shrapnel flying everywhere, the whole building collapses.  I'm pretty shocked, as you can imagine, but not nearly as much as when Tiny <b>gets back up</b> afterwards.  So now I'm surrounded, trapped between two indestructible pointy-headed weirdoes, both of them shouting about 'INVINCIBLE OWN-Y TECHNIQUES' or something.  Needless to say, it wasn't looking good, so I decided to, uh... huh,</i>\" Shouldra trails off, frowning.  \"<i>Hey, you see that, right?</i>\"  She says, pointing.  Following her outstretched finger, you find yourself looking at a small spiderweb stretched between a couple of rocks.  It's a little lopsided, the strands a little more angular and crazed than usual, but that's about it.  You shrug, turning back to Shouldra expecting her to finish her story, but she continues to stare, her frown slowly transforming into a lopsided smile.");
		outputText("\n\n\"<i>Hey, uh... get back to me on this, will you? I just had a GREAT idea.</i>\"  Shouldra says suddenly, swooping back into your body, leaving you standing there bemused.  Your efforts to coax Shouldra into revealing exactly what her idea entails are stonewalled, every question being met with answers like \"<i>Trust me, you'll love this!  It's got everything!  I just need a minute to get it all planned out, then you'll see...</i>\" Feeling at something of a loose end, you wait around for a few minutes, but your ghostly pal fails to rematerialize.  After a while, you shrug and decide to forget about it for now.  Whatever inspirational idea Shouldra's working on, you're sure you'll find out sooner or later.  Part of you can't help but wonder if she'll ever actually remember to finish her story, though.  You'll have to remember to remind her about it some time...");
	}
	doNext(camp.returnToCampUseOneHour);
}

//Follower Shouldra - Interact / Talk Menu
//Follower Screen Quick Text
public function shouldraFollowerScreen():void {
	spriteSelect(67);
	clearOutput();
	if (!shouldraSleeping()) outputText("You pulse a desire for interaction with Shouldra, summoning her head to form from your shoulder. \"<i>What's on your mind, Champ? I could've found out on my own, but I was... preoccupied.</i>\"");
	//Follower Screen Quick Text - Shouldra asleep
	else {
		outputText("You try and contact Shouldra, but the ghost is still sound asleep within you.  Or whatever ghosts consider sleep after an arousing round of debauchery. Either way, you garner no response.  Best to try again later.");
		doNext(playerMenu);
		return;
	}
	var sex:Function = null;
	if (player.lust >= 33) sex = shouldraSexMenu;
	simpleChoices("Talk", shouldraTalkMenu, "Sex", sex, "", null, "Go Away", kickFollowerShouldraOut, "Back", camp.campFollowers);
}

private function shouldraSexMenu():void {
	clearOutput();
	spriteSelect(67);
	outputText("Shouldra stirs from somewhere deep inside you, excitement evident in the swiftness of her reaction.  \"<i>Is it time for some fun, Champ?</i>\" she asks happily, her increased lust affecting you just a bit.  Do you oblige her?");
	var vala:Function = null;
	if (flags[kFLAGS.FREED_VALA] != 0 && (model.time.hours >= 12 && model.time.hours <= 21)) {
		outputText("\n\nVala might interest Shouldra.  You could go introduce them...");
		vala = shouldraAndValaGetBigger;
	}
	var anal:Function = null;
	if (player.gender > 0 && player.lust >= 33) {
		anal = nongenderlessAnalShouldraMasturbation;
		outputText("\n\nShouldra could also let you have a little anal fun, if you'd like.");
	}
	simpleChoices("GhostMasturbate", shouldraFappinTimes, "Anal Masturb", anal, "Visit Vala", vala, "", null, "Back", shouldraFollowerScreen);
}

//Talk Options
private function shouldraTalkMenu():void {
	spriteSelect(67);
	//Go directly to appropriate talk if necessary
	if (flags[kFLAGS.SHOULDRA_TALK_NEEDED] == 1) {
		shouldraYappin();
		return;
	}
	//Allow for the expansion of bodyparts via spooky magic
	var blowShitUp:Function = null;
	var shrinkShit:Function = null;
	if (flags[kFLAGS.SHOULDRA_PLOT_LEVEL] >= 2 && flags[kFLAGS.SHOULDRA_MAGIC_COOLDOWN] <= 0) {
		blowShitUp = shouldraGroPlus;
		shrinkShit = shouldraReductoMenu;
		outputText("\n\nShouldra could permanently expand or reduce part of your body.");
	}
	else if (flags[kFLAGS.SHOULDRA_PLOT_LEVEL] >= 2) outputText("\n\nShouldra needs some time before she can grow or shrink one of your body parts permanently.");
	simpleChoices("Normal Talk", shouldraYappin, "Grow Something", blowShitUp, "Shrink Something", shrinkShit, "", null, "Back", shouldraFollowerScreen);
}

//Grow Bodypart
//unlocks after Talk 2
//works same as Gro+ with additional Butt option
//3 day / 72 hour cooldown between uses. Does not appear while on cooldown. 
//Selecting Grow Bodypart
private function shouldraGroPlus():void {
	clearOutput();
	spriteSelect(67);
	outputText("You decide to take up Shouldra's offer on natural body enhancement.  Before you tell her as much, the eager spectre quickly assumes control of your body.  \"<i>Alright, Champ, now we're in business.  So, what did you have in mind?</i>\"");
	//Balls     Breast     Clit     Cock     Nipples     Butt     Nevermind
	var balls:Function = null;
	var breast:Function = shouldraGrowsYoTits;
	var clit:Function = null;
	var cock:Function = null;
	var butt:Function = shouldrasButtBigginator;
	var nipples:Function = shouldraGivesYaSomeFukkinTeats;
	if (player.balls > 0) balls = groBallsBiggaGHOSTYSTYLE;
	if (player.hasCock()) cock = shouldraCockBloating101;
	if (player.hasVagina()) clit = shouldraGrowsYoClit;
	choices("Balls", balls, "Breasts", breast, "Clit", clit, "Cock", cock, "Nipples", nipples, "Butt", butt, "", null, "", null, "", null, "Back", shouldraTalkMenu);
}
		
//Balls
private function groBallsBiggaGHOSTYSTYLE():void {
	flags[kFLAGS.SHOULDRA_MAGIC_COOLDOWN] = 72;
	clearOutput();
	spriteSelect(67);
	outputText("\"<i>Interested in a bigger ballsack, huh?  Not only will it help pronounce your package, but a big ol' swinging sack of nuts feels great when you're really pounding.</i>\" Shouldra grasps your [balls] with both your hands and begins reciting the appropriate spell.");
	//ballsize + 2 + rand(4) 20% chance
	if (rand(5) == 0) {
		player.ballSize += 2 + rand(4);
		outputText("\n\nYour testicles rumble greatly, inch after inch of " + player.skinTone + " flesh enveloping their impressive new bulk.  Shouldra gives your enlarged [balls] a little squeeze and leaves you to reacquaint yourself with a new center of balance.");
	}
	//ballsize + 1 + rand(2) Else
	else {
		player.ballSize += 1 + rand(2);
		outputText("\n\nA tingling sensation courses through your scrotum, your " + player.skinTone + " going taut as it gains additional mass.  Shouldra rewards your new [balls] with a light massage.");
	}
	//if ballsize > 10
	if (player.ballSize > 10) outputText("  You second guess your decision when your swinging cum barrels seem to impede walking.  Shouldra reassures you that the enhanced libido and baby batter supply is worth the wider gait.");
	dynStats("lus", 10);
	doNext(camp.returnToCampUseOneHour);
}

//Breast
private function shouldraGrowsYoTits():void {
	flags[kFLAGS.SHOULDRA_MAGIC_COOLDOWN] = 72;
	clearOutput();
	spriteSelect(67);
	outputText("\"<i>I'll give you a rack that could hypnotize anyone into a faithful tit slave,</i>\" Shouldra boasts, stretching your shoulders in preparation.  Your hands grope your [fullChest] as the spirit slips into the arcane language you've come to grow so familiar with.\n\n");
	//same growtits() as Gro+
	if (player.breastRows.length == 1) player.growTits((1+rand(5)),1,true,1);
	else player.growTits(1+rand(2),player.breastRows.length,true,1);
	dynStats("lus", 10);
	doNext(camp.returnToCampUseOneHour);
}
//Clit
private function shouldraGrowsYoClit():void {
	flags[kFLAGS.SHOULDRA_MAGIC_COOLDOWN] = 72;
	clearOutput();
	spriteSelect(67);
	outputText("\"<i>Looking to give your joy buzzer a little jumpstart?</i>\" Shouldra teases, your hands sliding down to your inviting [cunt].  Your fingers tease your [clit] while the ghost girl spouts her arcane tongue from your mouth.  ");
	//clitLength + 1
	player.clitLength += 1;
	outputText("She welcomes the new inch with a quick flick.  The sensitive [clit] twitches happily in response, confirming the success of the spell.");
	dynStats("sen", 5, "lus", 15);
	doNext(camp.returnToCampUseOneHour);
}
//Cock
private function shouldraCockBloating101():void {
	flags[kFLAGS.SHOULDRA_MAGIC_COOLDOWN] = 72;
	clearOutput();
	spriteSelect(67);
	outputText("A satisfied grin develops on your face.  \"<i>I was hoping you'd spring for the male enhancement,</i>\" Shouldra teases, your hands darting into your armor and stroking your dick fervently.  You realize that the mere request to give your member a long-lasting lengthening has excited your paranormal partner enough that [eachCock] gets rock hard, gushing pre in anticipation.  You reign in the spirit, asking she not do anything too crazy.  Your head nods in response, and the eager wraith gets to work on her spell.\n\n");
	//same growth as Gro+, depending on cock number
	if (player.cocks.length == 1) {
		outputText("Several more inches push their way from your ");
		if (!player.hasSheath()) outputText("crotch");
		else outputText("sheath");
		outputText(" in short order.  Shouldra happily grasps your fuller dick, stroking it vigorously.  Knowing your inaction will strand you for the rest of the day, you're able to pry your haunted hands away from your crotch.", false);
		player.increaseCock(0, 4);
		player.cocks[0].cockLength += 1;
		player.cocks[0].cockThickness += .25;
	}
	//MULTI
	else {
		outputText("Your bouquet of cocks twitches and thickens, each gaining more than an inch of new vibrance.  Shouldra wastes no time in grouping them together, your hands stroking them vigorously.  Knowing your inaction will strand you for the rest of the day, you're able to pry your haunted hands away from your crotch.");
		for(var i:Number =0;i<player.cocks.length;i++) {
			player.increaseCock(i, 2);
			player.cocks[i].cockLength += 1;
			player.cocks[i].cockThickness += .25;
		}
	}
	dynStats("sen", 2, "lus", 20);
	doNext(camp.returnToCampUseOneHour);
}

//Nipples
private function shouldraGivesYaSomeFukkinTeats():void {
	flags[kFLAGS.SHOULDRA_MAGIC_COOLDOWN] = 72;
	clearOutput();
	spriteSelect(67);
	outputText("Shouldra rubs your hands together in anticipation, \"<i>A beautiful blossoming pair of nipples is what you need to really compliment a nice set of tits.</i>\"  Your hands gleefully tweak your [nipples] as the spirit's incantation gets underway.");
	outputText("\n\nYour nipples press hard against your [armor], easily gaining at least a quarter of an inch in size.  Shouldra gives each [nipple] a hasty inspection, ensuring her work.");
	//same increase and potential for fuckable nipples as Gro+
	player.nippleLength += (rand(2) + 3)/10;
	dynStats("lus", 15);
	var temp2:Number = 0;
	//NIPPLECUNTZZZ
	if (!player.hasFuckableNipples() && rand(4) == 0) {
		temp = player.breastRows.length;
		//Set nipplecunts on every row.
		while(temp > 0) {
			temp--;
			if (!player.breastRows[temp].fuckable && player.nippleLength >= 2) {
				player.breastRows[temp].fuckable = true;
				//Keep track of changes.
				temp2++;
			}
		}
		//Talk about if anything was changed.
		if (temp2 > 0) outputText("  While doing so, she manages to slip a few of your fingers within the engorged teats, ecstatcy flowing through you as your digits explore their inner workings.  \"<i>I may not be a doctor, Champ, but it looks to me like <b>you've managed to gain yourself a pair of fuckable nips.</b></i>\"  The ghost girl spends a few minutes running your fingers around your [nipples], inside and out, just to confirm her diagnosis.");
	}
	doNext(camp.returnToCampUseOneHour);
}

//Butt
private function shouldrasButtBigginator():void {
	flags[kFLAGS.SHOULDRA_MAGIC_COOLDOWN] = 72;
	clearOutput();
	spriteSelect(67);
	outputText("Shouldra's haunting laugh works its way out from your mouth.  \"<i>Looking for a little more jiggle in your step, Champ?  I can get BEHIND that.</i>\"  This damnable ghost won't let you roll your eyes!  Is there no end to her torment?  After a quick crack of your knuckles, Shouldra directs your hands back onto your derriere as she transitions into spellcasting.");
	//this.player.buttRating = this.player.buttRating + 1 + rand(3)); or so
	player.buttRating += 1 + rand(3);
	outputText("\n\nYour cheeks quake as the magic takes hold, warm ripples greeting the inches of new retail estate on your hind quarters.  Shouldra can't resist herself, giving your [butt] a vigorous slap.");
	doNext(camp.returnToCampUseOneHour);
}

//Shrink Bodypart
//unlocks after Talk 2
//works same as Reducto
//3 day / 72 hour cooldown between uses. Does not appear while on cooldown.
//Selecting Shrink Bodypart
private function shouldraReductoMenu():void {
	clearOutput();
	spriteSelect(67);
	outputText("Shouldra's offer to shrink aspects of your body sounds right up your alley, and you pulse as much to your ghostly compatriot.  There's no response.  You remind her that it was HER suggestion in the first place.  \"<i>Come ooooon, Champ.  It was just a slip of the ol' spiritual tongue.</i>\"  You cross your arms and look up and off to the side, the best way you can figure to glare at something that isn't there. \"<i>Ugh, fine.  Let's just get this over with,</i>\" Shouldra concedes, removing your [armor].");
	//Balls     Breast     Clit     Cock     Nipples     Butt     Nevermind
	var balls:Function = null;
	var breasts:Function = null;
	var clit:Function = null;
	var cock:Function = null;
	var butt:Function = null;
	var nipples:Function = null;
	if (player.nippleLength > .25) nipples = shrinkDemNipplzForYoGhost;
	if (player.biggestTitSize() >= 1) breasts = shouldraReductosYourTits;
	if (player.buttRating >= 2) butt = shrinkDatBootyForYoGhost;
	if (player.balls > 0 && player.ballSize > 1) balls = shouldraReductosYourBallsUpInsideYa;
	if (player.hasCock() && player.longestCockLength() > 4) cock = shouldraMakesCocksDisappear;
	if (player.hasVagina() && player.clitLength > .25) clit = clittyVanishingActShouldra;
	choices("Balls", balls, "Breasts", breasts, "Clit", clit, "Cock", cock, "Nipples", nipples, "Butt", butt, "", null, "", null, "", null, "Back", shouldraTalkMenu);
}
//Balls
public function shouldraReductosYourBallsUpInsideYa(rescue:Boolean = false):void {
	flags[kFLAGS.SHOULDRA_MAGIC_COOLDOWN] = 72;
	clearOutput();
	spriteSelect(67);
	if (rescue) {
		outputText("\"<i>Gone a bit too far and got those delicious cumquats too big?</i>\"  Shouldra's arsenal of puns and teases don't affect your request in the slightest.  The ghost girl moves into a quick spell, savoring your testicles before finishing.");
		if (player.ballSize > 18 + (player.str / 2) + (player.tallness / 4)) player.ballSize = 16 + (player.str / 2) + (player.tallness / 4);
	}
	else
		outputText("\"<i>Why would you want to shrivel these delicious cumquats?</i>\"  Shouldra's arsenal of puns doesn't affect your request in the slightest.  The ghost girl moves into a quick spell, savoring your testicles before finishing.");
	//this.player.ballSize = this.player.ballSize - (2 + this.rand(4));
	player.ballSize -= (2 + rand(4));
	if (player.ballSize < 1) player.ballSize = 1;
	outputText("\n\nYour scrotum shifts and squirms, clinging to your testicles as your package recedes into your body by a few inches.  The pouting ghost is quick to give you back your body, disappointed in your new [balls].");
	doNext(camp.returnToCampUseOneHour);
}

//Breast
private function shouldraReductosYourTits():void {
	flags[kFLAGS.SHOULDRA_MAGIC_COOLDOWN] = 72;
	clearOutput();
	spriteSelect(67);
	outputText("Your arms clasp themselves around your [fullChest].  \"<i>Not the gals!  What monster would want to deflate their knockers?</i>\"  This monster, evidently.  Shouldra sighs, holding your hands in a weak casting stance as she gets the heinous act over with.");
	player.shrinkTits();
	outputText("\n\nYou explore your [fullChest] carefully, confirming their new size.  As you brush over your right [nipple], a tiny burst of milk soaks your hand.  You suppose your mutinous friend isn't too thrilled with your new brassiere size.");
	doNext(camp.returnToCampUseOneHour);
}
//Clit
private function clittyVanishingActShouldra():void {
	flags[kFLAGS.SHOULDRA_MAGIC_COOLDOWN] = 72;
	clearOutput();
	spriteSelect(67);
	outputText("\"<i>Aw, really, Champ?  The best part of your snatch?</i>\"  A nod of your head reasserts your desire.  The depressed phantom hastily works through the spell, the notion of shrinking your [clit] not sitting well with her.");
	player.clitLength /= 1.7;
	//Set clitlength down to 2 digits in length
	player.clitLength = int(player.clitLength * 100)/100;
	outputText("\n\nA soft moan is all you can manage as your button tingles and shrinks to almost half its original size.  You think you can hear Shouldra sighing in the back of your head.  She'll get over it.");
	dynStats("sen", 2, "lus", 10);
	doNext(camp.returnToCampUseOneHour);
}
//Cock
private function shouldraMakesCocksDisappear():void {
	flags[kFLAGS.SHOULDRA_MAGIC_COOLDOWN] = 72;
	clearOutput();
	spriteSelect(67);
	outputText("Your hands dart for your " + player.multiCockDescriptLight() + " as if to protect your poor masculinity.  \"<i>You're kidding, right?  You can't mean to rob me of my pride and joy!</i>\"  You remind Shouldra just whose dick she's talking about; the eidolon is getting a little too accustomed to your [if (cocks = 1) dick][if (cocks > 1) dicks].  \"<i>Please, Champ.  Not the dick...</i>\"  You slowly remove your hands from your crotch, asking the ghost to proceed.  She complies with a frustrated sigh and a rather perturbed incantation.");
	if (player.cocks.length == 1) {
		outputText("\n\nYour penis vibrates slightly as the magic starts to take effect.  Your eyes just about bulge out of your skull when your rod starts to smoke and twitch violently.  The panic immediately subsides when it starts yelling.  \"<i>You ");
		var choice:Number = rand(10);
		if (choice == 0) outputText("murderer");
		else if (choice == 1) outputText("bastard");
		else if (choice == 2) outputText("jerk");
		else if (choice == 3) outputText("monster");
		else if (choice == 4) outputText("cretin");
		else if (choice == 5) outputText("fiend");
		else if (choice == 6) outputText("asshole");
		else if (choice == 7) outputText("villain");
		else outputText("dick");
		outputText("!</i>\" it shouts.  The tiny voice fades away as your [cock] goes still, resting at two thirds of its original size.  A single tear rolls down your cheek; you suspect the melodramatic spirit is at fault here.");
		player.cocks[0].cockLength *= 2/3;
		player.cocks[0].cockThickness *= 2/3;
	}
	//MULTI
	else {
		outputText("\n\nYour dicks vibrate slightly as the magic begins to sink in.  You about jump out of your skin when they [if (cocks < 2) both][if (cocks >= 2) all] suddenly start smoking and flailing about.  Your fear is short lived, however, when they begin to wail and cry.");
		outputText("\n\n\"<i>I'm sorry, [Master]!  Please have mercy on me!</i>\" your [cock biggest] pleads.");
		outputText("\n\n\"<i>[Master], have mercy!  I'll make it up to you!  Please!</i>\" the [cock smallest] begs.");
		if (player.cockTotal() > 2) outputText("\n\n\"<i>I'll fuck extra hard, [Master]!  Just give me a chaaaance!</i>\" another yells.");
		if (player.cockTotal() > 3) outputText("\n\n\"<i>What did we do wrong?  At least tell us that much!</i>\" one of your cocks begs.");
		if (player.cockTotal() > 4) outputText("\n\n\"<i>I'll never fucking forgive you for this!</i>\" another of your dicks shouts furiously.");
		if (player.cockTotal() > 5) outputText("\n\n\"<i>Are we a nuisance?  Please, [Master], there must be another way!</i>\" yet another one of your many cocks pleads.");
		if (player.cockTotal() > 6) outputText("\n\nThe remainder of your plentiful penises are a sad mixture of crying and begging.");
		outputText("\n\nThe cacophony of voices finally subside, your crotch finally settling down with each of your cocks at roughly two/thirds their original size.  A single tear rolls down your cheek; you suspect the melodramatic spirit is at fault here.");
		for(var ii:Number =0;ii<player.cocks.length;ii++) {
			player.cocks[ii].cockLength  *= 2/3;
			player.cocks[ii].cockThickness  *= 2/3;
		}
	}
	dynStats("sen", -2, "lus", -10);
	doNext(camp.returnToCampUseOneHour);
}
//Nipples
private function shrinkDemNipplzForYoGhost():void {
	flags[kFLAGS.SHOULDRA_MAGIC_COOLDOWN] = 72;
	clearOutput();
	spriteSelect(67);
	outputText("\"<i>Are you kidding me, Champ?  Nipples are the most important-</i>\"  You cut the ghost girl's argument there, not wanting to leave your decision up for debate.  She instead leaves you with a deep sigh of disapproval before quickly casting the appropriate spell.");
	//Shrink
	if (player.nippleLength/2 < .25) {
		outputText("\n\nYou run a couple fingers around your [nipples], finding them shrunk to a quarter-inch long.  A quick squirt of liquid from each surprises you, causing you to jerk back a little.  Shouldra is evidently not too thrilled over your alterations.");
		player.nippleLength = .25;
	}
	else {
		outputText("\n\nYou run a couple fingers around your [nipples], finding them at nearly half their original size.  A quick squirt of liquid from each surprises you, causing you to jerk back a little.  Shouldra is evidently not too thrilled over your alterations.");
		player.nippleLength /= 2;
	}
	dynStats("sen", -3, "lus", -5);
	doNext(camp.returnToCampUseOneHour);
}

//Butt
private function shrinkDatBootyForYoGhost():void {
	flags[kFLAGS.SHOULDRA_MAGIC_COOLDOWN] = 72;
	clearOutput();
	spriteSelect(67);
	outputText("Your hands quickly grasp at your bare [butt].  \"<i>You... you're desecrating a national treasure here!</i>\"  The rather odd declaration gets a chuckle from you, but you remain firm in your request to dull your derriere.  The ghost girl furthers her attempts to change your mind, but without literally changing your mind, you remain steadfast.  Defeated, your hands take one last trip around your posterior before the poltergeist recites her incantation.");
	if (player.buttRating >= 15) {
		player.buttRating -= 3 + int(player.buttRating/3);
		outputText("\n\nWithin seconds, your cheeks feel noticeably lighter.  You confirm with a glance that your [butt] is much smaller than before.  Shouldra confirms with a pouting sigh that she is much sadder than before.");
	}
	else if (player.buttRating >= 10) {
		player.buttRating -= 3;
		outputText("\n\nYour ass jiggles as it recedes into your body.  A few moments later and your [butt] settles into its new, compact form.  The ghost girl recedes deep back into your body with a depressing sigh.");
	}
	else {
		player.buttRating -= 1 + rand(3);
		if (player.buttRating < 1) player.buttRating = 1;
		outputText("\n\nIn a few brief seconds, your [butt] relaxes into its new, slightly tinier form.  Shouldra huffs and puffs inside you, not wanting to discuss your bottom any further.");
	}
	dynStats("lib", -2, "lus", -10);
	doNext(camp.returnToCampUseOneHour);
}


//Want You (That Being Shouldra) Gone
private function kickFollowerShouldraOut():void {
	clearOutput();
	spriteSelect(67);
	//PC says Shouldra's being a drag and they don't want to deal with her. She takes it well, as wanton spirits are want to do, unless you've already passed the fourth dream/talk with her. Then she's gonna FREAK. THE FUCK. OUT.
	//She's Cool - She has not bared all to PC
	if (flags[kFLAGS.SHOULDRA_PLOT_LEVEL] < 4 || flags[kFLAGS.SHOULDRA_TALK_NEEDED] > 0) {
		outputText("\"<i>Ah, you're booting me out, hey?</i>\"  Shouldra asks innocently, tumbling out of your body and corporealizing. \"<i>Wouldn't be the first, and won't be the last.  I do realize I have certain 'needs' that got cloying to many of my former hosts.</i>\"");
		outputText("\n\nShouldra's hair darkens to the familiar brunette coiffure even as her yellow eyes flee before their brown replicas.  \"<i>Just promise you'll pay me a visit from time to time, alright, Champ?  And if you want me back... you'll have to work for it.</i>\"");
		outputText("\n\nWith that, she turns on her heel and wanders out of camp.  You watch her go for a while, then turn your focus back to other things.");
		//shouldra back to town ruins, reset to 'friendly' status
		flags[kFLAGS.SHOULDRA_FOLLOWER_STATE] = 0;
		doNext(camp.returnToCampUseOneHour);
	}
	//She Fucking Explodes
	else {
		outputText("Are you sure you want to ask her to leave after she opened herself up to you?  It's just a hunch, but she might not take this very well.");
		doYesNo(definitelyKickOutCrazyGhosts,shouldraTalkMenu);
	}
}

//if yes
private function definitelyKickOutCrazyGhosts():void {
	clearOutput();
	spriteSelect(67);
	outputText("\"<i>What.</i>\"");
	outputText("\n\nAfter a few moments, you repeat your command; you would like Shouldra to leave.  The ghost girl promptly exits your body to stand before you, hands on hips and eyebrows furrowed.  She sniffles a bit. \"<i>I can't say I didn't see this coming,</i>\" she says quietly.  \"<i>but after opening myself up like I did... I gotta say, I'm pretty disappointed.</i>\"");
	outputText("\n\nShouldra shakes her head, disappointment evident in her expression.  She turns and stomps away.  \"<i>Don't bother calling after me, asshole,</i>\" she yells over her shoulder.");
	outputText("\n\nYou only stand passively as she begins cursing and screaming her anger, listening to her fuming growing ever more distant until fading away completely.  It seems Shouldra has passed on.");
	flags[kFLAGS.SHOULDRA_FOLLOWER_STATE] = -1;
	doNext(camp.returnToCampUseOneHour);
}

//Follower Shouldra - Ignoring Her
public function shouldersWarnings():Boolean {
	//Requires hour counter to count time since last Shouldra scenes
	//Warnings appear during scene transitions.
	//Warning One
	//4 days (96 hours) since last Shouldra scene
	if (flags[kFLAGS.SHOULDRA_SLEEP_TIMER] == -96) {
		spriteSelect(67);
		if (rand(3) == 0) outputText("\n\"<i>Hey, Champ, I appreciate the time together, but it's been a while since I got to let off some steam,</i>\" Shouldra says, her built up lust growing more evident.  \"<i>Next time you've got a moment, maybe give me a buzz and we'll have some fun.</i>\"\n");
		else if (rand(2) == 0) outputText("\nYour hands start rubbing each other impatiently, no doubt spurred on by your antsy, deceased traveling companion.  \"<i>Champ, you think we can improve some monster's day soon?  I've also got some new spells to play with if you prefer it be just the two of us.  It's been a while since I had some action.</i>\"\n");
		else outputText("\nA shiver works through your spine.  Seems as though the mounting lust of your incorporeal partner is making itself plain to you.  Shouldra can keep to herself for a while, but you should probably tend to her needs before she decides to do it herself.\n");
		return true;
	}
	//Warning Two
	//7 days (168 hours) since last Shouldra scene
	else if (flags[kFLAGS.SHOULDRA_SLEEP_TIMER] == -168) {
		spriteSelect(67);
		trace("LEVEL 2 LUST INCREASE HAPPEN");
		//increased minimum lust +20 until Shouldra is satisfied
		if (rand(3) == 0) {
			outputText("\nYour [if (hasCock = true) dick is begining to get hard][if (isHerm = true)  while your ][if (hasVagina = true) cunt is getting moist with need]");
			if (player.gender == 0) outputText("libido seems to be going haywire");
			outputText(".  Shouldra's unfulfilled sexual needs are starting to blend into your own.  Nothing you do will satisfy your urging until she's seen to her own.\n\n<b>Minimum lust raised by 20.</b>\n");
		}
		else if (rand(2) == 0) {
			outputText("\nShouldra keeps rubbing your hands all over your body, trying her best to get your attention.  The ghost girl is getting a little unhinged, enough so that her mounting lust is impeding into your own sexual cravings.  Looks as though you'll always be a little horny so long as she's in this state.\n\n<b>Minimum lust raised by 20.</b>\n");
		}
		else {
			outputText("\nYour [leg] dances around fervently every so often.  At first you figure that its your nerves or something, but it soon dawns on you that your forgotten spectral partner is only getting hornier the longer she waits for you.  You appreciate not being nagged to death about it, but you'll have to deal with her lust encroaching on your own until she's satisfied.\n\n<b>Minimum lust raised by 20.</b>\n");
		}
		dynStats("lus", .1);
		return true;
	}
	//Warning Three
	//9 days (216 hours) since last Shouldra scene
	if (flags[kFLAGS.SHOULDRA_SLEEP_TIMER] == -216) {
		spriteSelect(67);
		//increased minimum lust bonus to +50 (20 + 30) until Shouldra is satisfied
		if (rand(3) == 0) outputText("\n\"<i>Look, Champ.  I've enjoyed the time together, but it's been too long since I got a turn on this ride.  I've been nice, but I'm on the brink here.  <b>If you think you can keep on ignoring me, you'll be sadly mistaken.</b></i>\"  You nod, unsure how exactly to take Shouldra's possible threat to your inaction.  The horny ghost certainly is already having her effect on your own libido.\n\n<b>Minimum lust raised by 30.</b>\n");
		else if (rand(2) == 0) outputText("\n\nYour hands are beginning to cling desperately to any of your sexual organs.  You managed to win back control of them, but Shouldra doesn't seem too pleased.  \"<i>I'm trying to be nice here, Champ.  Really.  But when I signed on for this, I was under the impression both of us would get to have fun.</i>\"  Your horny passenger's desire only continues to press further into your own.  <b>Shouldra's about to reach her breaking point, and you aren't quite sure you want to find out what happens.</b>\n\n<b>Minimum lust raised by 30.</b>\n");
		else outputText("\n\"<i>Champ, I like to think I'm a reasonable spirit.  I've respected your boundaries, haven't forced you into anything too wild for too long.  But if you think that I'm going to keep sitting in the corner like a quiet little girl, <b>you will be sorely mistaken.</b></i>\"  You know, call it a hunch, but you think Shouldra is getting really anxious for some sex.  Your ever-increasing libido only furthers your assumption.\n\n<b>Minimum lust raised by 30.</b>\n");
		dynStats("lus", .1);
		return true;
	}
	return false;
}

//Ignored Shouldra goes to town on the PC
public function nightTimeShouldraRapesThePC():void {
	//does not trigger for genderless PCs, leaving them at +50 minimum lust until performing a scene with Shouldra (e.g. anal masturbation) or gaining a dick/pussy
	//when PC goes to sleep after warning three without satisfying Shouldra
	//resets Shouldra's sex hour counter, erases minimum lust bonuses
	//Scene increases libido, sensitivity, gives bottle of ectoplasm
	flags[kFLAGS.SHOULDRA_SLEEP_TIMER] = 0;
	spriteSelect(67);
	player.orgasm();
	dynStats("lib", 1, "sen", 4);
	outputText("\nA chilling gust rouses you from your slumber.  Wind this fierce would probably tear apart your camp or at least make a serious mess.  Eyelids as heavy as boulders prove difficult to open.  You seem especially groggy, odd tingling and numb sensations radiating from all your body.  Your right hand feels especially odd.  Grasping onto your senses as well you can, you're at least able to make out a few pale objects in the dead dark of night.  Sounds of water crashing into rock in the distance are also becoming more clear.  Finally your vision comes into focus, greeting you with the faint emerald glow of your ghostly partner against a cold, dark blue horizon.  She appears to be standing at the precipice of some drop-off, transfixed on the blood red moon hanging in the sky.");
	//event occurance = 0
	if (flags[kFLAGS.SHOULDRA_TIMES_NIGHT_RAPED_PC] == 0) {
		outputText("\n\n\"<i>I've always loved coming out to this spot at night,</i>\" Shouldra says, her soft tone surprising you.  \"<i>Mareth can be so dull at night, shrouded in a thick, deep darkness.  But way up here, looking out into that forgotten sea, you can see as clear as day.</i>\"  What was that about the sea?  Way up here?  Where the fuck has she dragged you to?");
		outputText("\n\n\"<i>I haven't brought too many people out this way.  Not that anyone could really get out here on their own - you're a pain in the ass to drag around when you're asleep, by the way.</i>\"");
	}
	else {
		outputText("\n\nShouldra spares you her rhetoric.  The specter's deadly silent gaze at the moon just fills you with impending doom.");
	}
	outputText("\n\nShouldra breaks her skyward glare to face you, her expression chillingly calm.  A quick utterance accompanied by a small gesture summons an orb of dim white light, enough to see everything clearly.  The wispy illumination floats breezily above the ghost girl as she saunters on towards you, still stuck in your hazy state of unease.  She sits on her knees beside you, her face unnervingly close to your own.");
	outputText("\n\n\"<i>I'm not that big a fan of dry spells, you know.  They tend to make me a little... vindictive.</i>\"  Now you realize what this is all about.  \"<i>Typically these sobering times were due to either a spot of laziness or bad luck.  Not being able to relieve oneself is one thing.  It's quite another when you are teased with salvation for well over a week, exercising every thread of your self-control to stop yourself from just reaching out and taking it; all because you feel some sort of obligation to a so-called partner.</i>\"  Shouldra puts her translucent arms around your head, putting her lips to your ear, \"<i>Consider yourself obliged.</i>\"");
	outputText("\n\nYou want to at least stand up, get a clearer picture of just what's going on - or about to.  Your body just won't cooperate, though, no matter how hard you try and shake it.  \"<i>If magic were a drug, you'd have OD'd something fierce by now,</i>\" Shouldra interjects as she rises back to her feet.  The spirit's been much busier than you thought.");
	//if PC has cock
	if (player.hasCock()) {
		outputText("\n\nThe calculated shade works her way over to your [cock], a vacant expression dominating her face.  You're unsure just what that means, but it becomes the least of your concerns when she jabs her thumb into your [cockHead]!  You instinctively wince in pain, but the sensation never comes.  Not much of anything registers, really.  This soon becomes a blessing as you witness the eidolon stretch your cock away from you, insert BOTH her hands into it, and stretch your slit high into the air.  She then casually slips inside it as if it were a sleeping bag, disappearing into its distended depths.  It all happened so fast, nothing really had time to register.  You try and touch your magnified member, only to discover that it's now rock solid.  No, not erect, but literally made of stone!");
	}
	//if PC has no cock, but has vagina
	else if (player.hasVagina()) {
		outputText("\n\nThe calculated shade bends her way down to your [cunt], a vacant expression dominating her face.  You're unsure just what that means, but your concern is quickly forgotten as the spirit grasps your vaginal walls with both hands!  Oddly enough, you feel nothing.  No pain, but no pleasure either.  This soon becomes a blessing when the eidolon works her way around your canal, shaping it into a gaping wide hole!  Once its large enough, she casually slips inside and disappears into your depths.  It all happened so fast, nothing really had time to register.  You try and touch your stretched cunt, only to discover that it's sealed shut and rock solid.  Like, literally made of stone!");
	}
	outputText("\n\nYour groggy daze isn't helping matters much as you panic, hands exploring your solidified genitalia.  It doesn't feel any more dense or heavier than before, but there's a disconcerting texture alongside impossible rigidity.  \"<i>Tonight we're focusing on something of my own design,</i>\" Shouldra says, her voice reverberating in your head.  Her tone mirrors the stony-eyed demeanor you witnessed earlier.  Whatever she has in store probably won't be too kosher.");
	outputText("\n\nEyes now alit with a bright yellow tinge, Shouldra reigns over your body's will.  She holds your right hand in front of your face while directing the floating illumination to move in closer.  \"<i>I did some prep work while you were napping.</i>\"  No wonder your hand felt weird; your fingers are all swollen, each slender digit resembling stout little sausages rubbing against one another, your joints hardly visible.  \"<i>I decided to save the rest of the spell for when you were awake, though.</i>\"  You try to wiggle the puffy pointers, but your body refuses to obey you.  Rather, it transitions into Shouldra's arcane magic, your mouth reciting the final phrases to finish her spell.");
	outputText("\n\nThe skin of your flabby fingers waves and undulates, increasing in rhythm.  Your left hand grasps onto your right wrist in an attempt to steady the shaking.  Folds of flesh roll up your outstretched digits, accumulating at their tips.  Your hand is getting increasingly warm.  Incredibly odd sensations of some sort of transformation wrack your brain, unable to comprehend what is going on; they certainly aren't painful, probably due to the magic sedatives you feel you've been laced with.  The insides of your fingers distend a little, feeling as if...");
	outputText("\n\nIt hits you like a harpy's ass.  She really did it.  The bunched up skin slowly unfurls, confirming your suspicion.  Shouldra's changed your fingers into five stout, little dicks, beads of pre forming at each of their tips.  The otherwise impassive facade of your tormentor finally gives in, your face slowly becoming giddier as she marvels at her creation.  \"<i>You have no idea how glad I am this worked,</i>\" she says outwardly.  \"<i>Granted, I had a lot of time lately to perfect it.</i>\"  She wiggles your new fingers around, displaying the same range of movement they've always had.  Balling them into a fist, however, makes for an unusually rousing experience, your dick-fingers only increasing the flow from their- \"<i>You don't want to know what I had to do to get these little guys to squirt, Champ.</i>\"  That doesn't sound good.");
	outputText("\n\nYour left hand further examines your new wrist-mounted bouquet.  They're incredibly sensitive; you can feel things just as you would normally, but any manipulation of them registers just the sort of reactions you would expect from a dick - or five in this case.  She rubs the shafts soothingly, your left thumb exploring under each glan, over each slit, and into each fold.  The attention sinks in swiftly, each of your phallic fingers getting rigid and a little harder to bend.  The handjob results in a five-pronged stiffy, each dick taut, drooling, and ready for insertion.");
	outputText("\n\nYou noticed that the pace of your breathing has picked up; the horny ghost is really getting into this madness.  The foreplay - or is it five-play in this case? - isn't going to end so soon, however.  After a few more loving strokes from one hand to the other, Shouldra begins teasing your naked body with the squadron of cocks.  She runs their dribbling tips up along your [hips].  She glides their velvet shafts down your [legs].  She pinches your [nipple] with their bulbous heads");
	if (player.biggestTitSize() >= 1) outputText(", circling their entire lengths around your [fullChest]");
	outputText(".  It's quite amazing how ecstatic the tour feels, each pre-smeared exploration smothering you in sensual vibes.  Just moving the stiff little devils - particularly at your joints - sends shivers up your arm.");
	outputText("\n\nShouldra finally parts your fingers wide and covers your face in warm, moist, excited dickflesh.  You can count the few seconds it takes for her to spend time rubbing your head before she eventually shoves your hand into your mouth.  You figure she's made your jaw just as flexible as the rest of your body, judging by how easily she was able to down the five treats.  Your hand slowly thrusts in and out of your maw, your tongue working overtime to accommodate the large arrival.  Even with otherworldly enhancements, though, the five-fingered blowjob proves to be quite the challenge, so the ghost girl opts to sucking on one or two at a time.");
	outputText("\n\nMerry with her erotic fantasy, Shouldra swaps between dicks like someone sucking each finger free of errant flavors.  You at least agree that the rather bizarre act has actually felt quite wonderful.  The spirit quickens the pace, grasping your jaw with your new pinkie and thumb and the remaining three dick digits stuffing your face.  Pre trickles down your neck from the opposable penis and its cohort as they dig hard into your chin.  Meanwhile, the other trio of cocks continue their assault, escalating to a frenzied pitch.  Just as the spirit peaks, she locks your lower jaw into a deathgrip, each stiff appendage clamping on for all they're worth.");
	outputText("\n\nShouldra moans in ecstasy, each finger shooting out one payload after another.  Your entire arm is spasming, forcing the ghost to grab onto it with your left hand.  Seemingly endless streams of cum spray against your head and down your throat.  You can hardly describe what you're feeling.  The poltergeist seems incredibly content with herself.  Your body is flush with sexual release.  But you find that, mentally, you're unfulfilled.  ...Shit, you hope Shouldra doesn't pick up on that as she enjoys your hand cannons.");
	outputText("\n\nThankfully, the ghost seems to be in her own personal heaven, still filling your gullet full of cream, lightening her grasp in-between each pulse.  Finally, she finishes and lazily drags your soaked hand from your mouth, dangling the twitching members wearily in the air.");
	outputText("\n\n\"<i>That felt even better than I imagined it would,</i>\" the satisfied spirit finally proclaims, leaning back on your left hand.  She lifts your flaccid fingers over your own petrified sex, dripping cum all over it.  It doesn't really surprise you as the jism soaks into your ");
	if (player.hasCock()) outputText("[cock]");
	else outputText("[cunt]");
	outputText(", softening the ");
	if (player.hasCock()) outputText("magically enlarged member");
	else outputText("magically gaped snatch");
	outputText(" back to a much less craggy complexion.  Shouldra slowly drags you back to your [feet] after a minute or two of blissful respite and walks you closer to the cliffside to stare off into the moonlit horizon.  It never really dawned on you just how fucking high you are; just where the fuck did she take you?");
	outputText("\n\n\"<i>Well, that was a lot of fun, Champ.  I hope that I made my point abundantly clear,</i>\" she says while vacantly rubbing your dick fingers.  She turns away from the ledge as if to leave, but stops after a few brief steps.  \"<i>Actually, I think I'll make sure you remember this occasion.</i>\"  She what- The fucking crazy bitch is running you off the cliff!  Things go from kooky fun to morbid chaos as you take a mighty leap hundreds of feet over seemingly uninviting waters, the little orb of light trailing closely behind you.  Suddenly you feel yourself in control of your body again.  \"<i>I had my fun.  Now it's your turn,</i>\" Shouldra blasts into your head, pointing your eyes to your ");
	if (player.hasCock()) outputText("flailing cock");
	else outputText("moist vagina");
	outputText(".");
	//if cock
	if (player.hasCock()) {
		outputText("\n\nYou aren't sure why you kowtow to her little game.  Maybe it's the surge of adrenaline, the rapidly approaching water below or you're just horny after the less-than-fulfilling sex act before.  Either way, you grasp onto your rod with your left hand, pumping for all you're worth as you plummet helplessly.  But as your [cock] surges to life, you soon find that its enchanted size has easily made it more than a one-handed job!  Without any further hesitation, both of your hands- in your tense excitement, you forgot about your five-cocked feature.  The dicks-on-big-dick action is... it feels way too fucking good right now.");
		outputText("\n\nWith all participants at full salute, your manic stroking commences.  The wind races past you while your beating heart pounds into your ears.  You hold your wang firmly against your [chest] in an attempt to keep it from flailing about, putting it square into your face.  Easily halfway down the descent, your pick up the pace of your caress, circling your massive [cockHead] with your mutated hand.  It doesn't take you long to reach your own precipice, phallic fingers pressing hard into your mast.  Just as you're about to climax, your body slams hard into the ocean.");
	}
	//if vagina, no cock
	else {
		outputText("\n\nYou aren't sure why you kowtow to her little game.  Maybe it's the surge of adrenaline, the rapidly approaching water below or you're just horny after the less-than-fulfilling sex act before.  Either way, your left hand surges for your [vagina], left unnaturally open from ghostly antics earlier in the night.  You tease at your labia, play at your [clit].  It's working, but not fast enough!  With the wind smacking you hard, and your predicament making you at least a little nervous, you desperately try to think of something to-");
		outputText("\n\nYour right hand is still five dicks strong.  With no further debate, you dive the transmogrified hand to your cooch, pinching your [clit] between your thumb and forefinger while digging the remaining three into your gaping hole.  You press the two cockheads hard against your buzzer, stiffening all your phallic fingers.  Meanwhile, your remaining three fingers plumb your depths, alternating between thrusting and rubbing.  The bizarre one-armed sex feat is blowing your mind, drawing you ever so close to climax.  Just as you're about to make liftoff, your body slams hard into the ocean.");
	}
	doNext(edwardShouldraDickHandsPartII);
}

private function edwardShouldraDickHandsPartII():void {
	clearOutput();
	spriteSelect(67);
	outputText("You gasp awake, drenched in a cold sweat.  It... it is sweat, you confirm.  Shouldra rushes into your " + camp.homeDesc() + " looking concerned, \"<i>What's wrong!</i>\"  Not bothering to question why the spirit was out milling about on her own, you hold up your right hand.  It's just a normal hand.  The concerned spirit kneels down and holds your hand, \"<i>Something wrong with your hand?</i>\"  You decide to keep your dream to yourself, not wanting to give Shouldra any-");
	outputText("\n\n\"<i>Don't go about ignoring me ever again.</i>\"  Okay, never mind.  The now stone-faced ghoul sits on top of you and gives your thumb a little squeeze... pushing some sort of liquid up and out of the top much to your horror.  \"<i>You missed a great fucking orgasm, let me tell you,</i>\" she says, being unusually bubbly - which is probably more terrifying than any other of her moods.  The ghost girl runs her roulette wheel of emotion again, giving you a cocky smirk as she phases into your body.");
	outputText("\n\nThe dream was all too real, it turns out.\n\n(<b>Minimum Lust reduced!</b>)");
	//Libido and Sensitivity slight increase
	flags[kFLAGS.SHOULDRA_TIMES_NIGHT_RAPED_PC]++;
	doNext(playerMenu);
}

//Shouldra Waking Up/PC Exploring
//occurs at scene transitions similar to Exgartuan
//message chosen at random out of suitable selections
//one happens when Shouldra wakes and becomes available again (set at 16 hours currently)
//1-2 days before the next message


public function shouldraWakesUpOrPokesPCsForShitsAndGigglesIdunnoHowLongCanIMakeThisFunctionNameQuestionMark():void {
	outputText("\n");
	spriteSelect(67);
	var choices:Array = [];
	var select:int;
	
	//1 PC with cock - 1
	if (player.hasCock() && player.biggestCockArea() < 200) {
		choices[choices.length] = 1;
		choices[choices.length] = 1;
		choices[choices.length] = 1;
		choices[choices.length] = 1;
	}
	//2 PC with BIG COCK - if (this.player.biggestCockArea() >= 200)
	else if (player.hasCock()) {
		choices[choices.length] = 2;
		choices[choices.length] = 2;
		choices[choices.length] = 2;
		choices[choices.length] = 2;
	}
	//3 PC with balls
	if (player.balls > 0) {
		choices[choices.length] = 3;
		choices[choices.length] = 3;
		choices[choices.length] = 3;
		choices[choices.length] = 3;
	}
	//4 PC with boobs
	if (player.biggestTitSize() >= 2) {
		choices[choices.length] = 4;
		choices[choices.length] = 4;
		choices[choices.length] = 4;
		choices[choices.length] = 4;
	}
	//5 PC with vagina
	if (player.hasVagina()) {
		choices[choices.length] = 5;
		choices[choices.length] = 5;
		choices[choices.length] = 5;
		choices[choices.length] = 5;
	}
	//6 PC with Exgartuan and Shouldra //unlocked after deciding to keep Shouldra and Exgartuan together, for better or for worse (see below for scene)
	if (player.statusEffectv1(StatusEffects.Exgartuan) == 1 && 9999 == 9999) {
		choices[choices.length] = 6;
		choices[choices.length] = 6;
		choices[choices.length] = 6;
		choices[choices.length] = 6;
	}
	//7 General flavor text
	choices[choices.length] = 7;
	choices[choices.length] = 7;
	choices[choices.length] = 7;
	choices[choices.length] = 7;
	//8 (Tel'Adre unlocked)
	if (player.statusEffectv1(StatusEffects.TelAdre) >= 1) choices[choices.length] = 8;
	//9 (is preggers)
	if (player.pregnancyIncubation > 0) choices[choices.length] = 9;
	//10 (is preggers2)
	if (player.pregnancyIncubation > 0) choices[choices.length] = 10;
	//11 (is butt pregnant)
	if (player.buttPregnancyIncubation > 0) choices[choices.length] = 11;
	//12 (can fly)
	if (player.canFly()) choices[choices.length] = 12;
	//13 (is Naga)
	if (player.isNaga()) choices[choices.length] = 13;
	//14 (Amily is a follower)
	if (kGAMECLASS.amilyScene.amilyFollower()) choices[choices.length] = 14;
	//15 (Pure Jojo is a follower)
	if (player.findStatusEffect(StatusEffects.PureCampJojo) >= 0) choices[choices.length] = 15;
	//16 (has any of Marae's gift perks)
	if (player.findPerk(PerkLib.MaraesGiftStud) >= 0 || player.findPerk(PerkLib.MaraesGiftFertility) >= 0 || player.findPerk(PerkLib.MaraesGiftProfractory) >= 0 || player.findPerk(PerkLib.MaraesGiftButtslut) >= 0) choices[choices.length] = 16;
	//17 (has had children with Izma)
	if (flags[kFLAGS.IZMA_CHILDREN_SHARKGIRLS] + flags[kFLAGS.IZMA_CHILDREN_TIGERSHARKS] > 0) choices[choices.length] = 17;
	//18 (has Incorporeality perk)
	if (player.findPerk(PerkLib.Incorporeality) >= 0) choices[choices.length] = 18;
	//19 (possessed by Boobgartuan)
	if (player.statusEffectv1(StatusEffects.Exgartuan) == 2) choices[choices.length] = 19;
	//20 (PC knows any spells)
	if (player.hasSpells()) choices[choices.length] = 20;
	//21 (PC has anemone dick)
	if (player.countCocksOfType(CockTypesEnum.ANEMONE) > 0) choices[choices.length] = 21;
	//22 (Computer date is within a week before or after Halloween/or on Halloween whichever's easier)
	if (isHalloween()) choices[choices.length] = 22;
	
	select = choices[rand(choices.length)];
	var subSelect:int = 0;
	
	switch(select) {
		//PC with cock
		case 1:
			subSelect = rand(5);
			if (subSelect == 0) outputText("Your [cock] tingles, and your [armor] suddenly feels much tighter.  A little giggle from Shouldra reveals her intention.  Though adamant about making you as big and virile as possible, Shouldra does realize it <b>is</b> your body, and your meat shrinks at least three inches to its former glory.");
			else if (subSelect == 1) outputText("An uncomfortable stirring in your nether regions has you stop to undo your [armor] and figure out what's the matter.  Your [cock] is wagging enthusiastically.  Shouldra's face quickly sprouts from your shoulder, \"<i>Oh look, he's happy to see you!</i>\" You pay her an irritated glance which she returns with a content snicker.  With your cock under control, you redo your [armor] and continue on your way.");
			else if (subSelect == 2) outputText("You're distracted as you notice your [cock] snaking its way down your [leg], quickly growing larger.  You make your displeasure obvious, causing it to recoil back to its original size.  Seems as though your ghostly friend is getting restless.");
			else if (subSelect == 3) outputText("You come to a halt as you suddenly lose control of your arms, forcing you to watch your hands dart down your [armor] to fiercely grab at your [cock].  Though you let out a growl for her to stop, it takes Shouldra a minute to return your arms to you.  She must be getting restless.");
			else if (subSelect == 4 && player.countCocksOfType(CockTypesEnum.HORSE) == 0) outputText("There's a sudden twisting pain in your [cock], forcing you to undo your [armor] and see what's wrong.  To your dismay, a large equine dong is staring back at you, leaking profusely.  \"<i>Just testing out some new transformations, Champ,</i>\" Shouldra snickers.  You yell out again as your dick quickly turns back to normal.");
			else outputText("One of your hands begins playing with your [cock], no doubt spurred on by your paranormal passenger.  \"<i>You know, Champ, I could make you some easy gems.  Just find some know-nothing and introduce them to The Amazing Penis, capable of astounding feats like responding to any vocal coital commands!</i>\"  Playing the part of a sideshow attraction is quite the tangent to your typical daily activities.  Probably best not to think about it.");
			break;
		case 2:
			//PC with BIG COCK 
			subSelect = rand(5);
			if (subSelect == 0) outputText("Your [cock] begins to feel incredibly warm and dense. You place your hands along your enormous rod, causing it to illicit a low hum.  That \"<i>mmmm</i>\" sounded vaguely like Shouldra.  Best you can figure, the ghost girl is having the time of her life concentrating her being throughout your totem pole.  Shaking your head, you decide it best to carry on, doing your darndest to ignore her.");
			else if (subSelect == 1) outputText("A wet feeling within your [armor] warrants checking, forcing you to stop and examine what's wrong.  Upon undoing your outfit, you discover an alarming stream of pre flowing from your... moaning urethra.  You scold the awestruck ghost girl, knocking her out of her trance.  \"<i>S-sorry, Champ!</i>\" your [cock] apologizes, slurping her \"drool\" back into her... its slit. After a listless stare, you sigh and continue on.");
			else if (subSelect == 2) outputText("Out of nowhere, your hands dive into your [armor], furiously rubbing at your [cock].  You regain control, lurching your mitts back into the open.  \"<i>Come ooooon, Champ! Can't you just take a break? Maybe take care of some stress?</i>\"  You shoo away the nagging voice in your head, anxious to move on.  \"<i>How can you ignore a package this wonderful?</i>\" Shouldra whines.");
			else if (subSelect == 3) outputText("Your breath is about knocked out of you as an onslaught of desire rushes through you.  Your [cock] bursts from your [armor], triumphantly pointing skyward.  \"<i>You can't cage this mighty beast!</i>\" it shouts with a mighty growl.  It takes you a moment to regain your composure, and you ask the hyper ghost to settle down.  There's no way your outfit can cover such a huge erection.  Your massive wang roars once more before slowly deflating.");
			else {
				outputText("Lightheadedness is setting in.  You're unsure as to the reason until you notice your [cock]; it's engorged with blood!  The warm, throbbing, erect fullness is nuzzling peacefully against your [leg] in agony for release.  Shouldra's enjoying your powerful penis so much that she's starting to influence your own libido!");
				dynStats("lib", 1, "lus", 10);
			}
			break;
		//PC with balls
		case 3:
			subSelect = rand(5);
			if (subSelect == 0) outputText("Your [balls] are getting warm.  They're getting... really hot.  \"<i>Don't mind me, Champ. Just... checking something out.</i>\"  You decide the best course of action would probably be not to pry any further into whatever machination the ghost girl is working on.");
			else if (subSelect == 1) outputText("A tightness in your [armor] reveals to you your swelling [balls].  Shouldra continues to try and convince you of the importance of a virile package, but you remind her as to who's in control of this ship.  Regretfully conceding, the ghost girl returns your sac to its original proportions.");
			else if (subSelect == 2) outputText("You suddenly fall [if (isBiped = true) to your knees][if (isBiped = false) to the ground] as your [balls] begin to thrash and vibrate wildly!  \"<i>Interesting. That was way more effective than I would have guessed.  I'll have to make a note of that,</i>\" your paranormal passenger says, ending the spell.  With a mild case of confusion, you're left to your thoughts as you go about your business.");
			else if (subSelect == 3 && player.hasCock()) outputText("You feel your [balls] quickly swell then tighten out of nowhere, forcing some of their payload out your [cock].  Suddenly your hand darts down your [armor] and delivers the errant cum directly to your mouth!  \"<i>Had some time on my hands, so I decided to try out some new recipes.  What do you think?</i>\" Shouldra asks.  Tastes... citrus-y?  That your loins are being used as an experimental factory is... disconcerting.");
			else outputText("\"<i>Champ... you weren't thinking of impregnating anyone too soon, were you?</i>\"  You ask Shouldra what's wrong, afraid of the answer you'll hear.  The odd sensations you've felt in your [balls] are probably related.  \"<i>Well, let's just say that your sperm may be little wild cards at the moment.  I'll... get that sorted out shortly.</i>\"  On that note, a rough churning starts up down below.  Your baby batter isn't safe with this ghost around, it seems.");
			break;
		//PC with boobs
		case 4:
			subSelect = rand(5);
			if (subSelect == 0) outputText("Your [armor] feels... tight.  Way too tight.  Around your chest.  You start to glance down before realizing you needn't bother; your bustline is so expansive (yet so constrictive!) it inches into your peripheral vision.  Sighing softly, you pulse your displeasure to Shouldra.  \"<i>Champ, seriously, you'll never get ahead in life without taking advantage of your assets!</i>\"  You remain firm in your objections, however, and she eventually deflates your boobs to their original size. \"<i>Spoilsport,</i>\" she mutters.");
			else if (subSelect == 1) outputText("A stretching sensation on your [chest] directs your attention.  Shouldra is puffing up your nipples. \"<i>If you just had some big, succulent teats, I'm sure that...</i>\"  You interrupt the phantom before she can finish, insisting that she leave well enough alone.  Your [nipples] shrink down to their normal size, but not without a little disapproving huff from your ghostly roommate.");
			else if (subSelect == 2) outputText("Your [nipples] have started to lactate profusely... way more than you've ever seen.  Shouldra tries to explain to you how much of a turn-on it could prove to be, but you cite your soaked [armor] as point to the contrary. With a sigh, the spirit returns your [chest] milk output back to how it was.");
			else if (subSelect == 3) outputText("The life is about spooked out of you when your hands suddenly force open your [armor] and your [fullChest] burst outward, ballooning to thrice their normal size!  \"<i>Next time you flash some fucker, you should totally let me in on it.  Who would be able to resist this?</i>\"  Probably anyone that doesn't burst out in laughter, you figure.  Shouldra forces a shrug out of you and returns your cans to normal.");
			else outputText("\"<i>You know, I've noticed how rarely you wear a bra, Champ,</i>\" a particularly mischievous voice whispers into your ear.  Your [fullChest] begin wiggling seductively all on their own.  \"<i>You should pick up a bunch of 'em sometime.  Then I can break them off with a nice surge of breast flesh.  Who could resist such an act?</i>\"  Shouldra is entirely too obsessed with hypnotizing onlookers with your tantalizing tits.");
			break;
		//PC with vagina
		case 5:
			subSelect = rand(5);
			if (subSelect == 0) outputText("You're nearly brought [if (isBiped = true) to your knees][if (isBiped = false) to the ground] by some rustling deep down in your flower box.  Your [clit] is vibrating like crazy, no doubt due to some paranormal activity.  You think you hear her laughter, but you can't place the source.  After a moment, your [vagina] calms down and you go about your business.  ...You have a sneaking suspicion that she knows you enjoyed it.");
			else if (subSelect == 1) outputText("Your [vagina] puffs up slightly and begins nipping at your [armor].  \"<i>What's wrong? Are you getting hungry?</i>\" you ask emphatically... involuntarily.  The enthusiastic box yips in response.  \"<i>Don't worry, momma will get you something to eat real soon!</i>\"  You're left frozen in place to enjoy awkward silence as your [vagina] returns to its normal size.");
			else if (subSelect == 2) outputText("You almost don't realize your hand creeping its way into your [armor], trying to sneak a quick fingering. Looks like Shouldra is getting antsy.");
			else if (subSelect == 3) outputText("What the... ?  Your [vagina] has started gushing fluids everywhere, absolutely soaking your [legs]!  \"<i>Don't mind me, Champ.  I'm just testing to see how far I can push this. Part of something I have in mind for later...</i>\"  No good can come of this...");
			else outputText("You can sense Shouldra laughing to herself over something.  Though its usually a poor idea, you decide to ask and see what's on her mind.  \"<i>I was just scheming.  Would you get too upset if I spooked your next fuck?</i>\"  As she asks, you feel your [vagina] clenching hard, giving you a clear idea of what the trickster has in mind.  There's no way that-  On second thought, maybe it could be kind of fun?");
			break;
		//PC with Exgartuan and Shouldra
		//unlocked after deciding to keep Shouldra and Exgartuan together, for better or for worse (see below for scene)
		case 6:
			subSelect = rand(6);
			if (subSelect == 0) outputText("While minding your business, you realize faint whispering is coming from your [cock].  Shouldra and Exgartuan are scheming something, probably something you wouldn't be a fan of.  Every so often your wang lets out a chuckle.  Maybe getting these two together wasn't in your best interest.");
			else if (subSelect == 1) outputText("Your [cock] is wiggling around inside your [armor], making you incredibly uncomfortable.  You go to undo your outfit when the demonic dong plows its way out anyway, scaring you half to death.  Shouldra and Exgartuan just laugh, too content with one another to pay you much mind.  You never expected them to get along THIS well.");
			else if (subSelect == 2) outputText("\"<i>So what other sorts of things can you concoct?</i>\" Exgartuan asks, shuffling around in your armor.  You're incredibly confused by the sudden question.\n\n\"<i>Honestly, that put me in the mood to make all of mother nature our bitch,</i>\" you respond... Shouldra responds.  The spirit is gabbing through your mouth to your possessed pecker.  The two prattle on like this for some time.");
			else if (subSelect == 3) outputText("Your hands slip inside your [armor], exploring your [cock].  Your fingers caress each little nub and nodule they come across.  \"<i>That's the ticket,</i>\" Exgartuan gleefully responds, getting rigid in the tight confines of your outfit.  Looks like your ghostly partner is out to make everyone happy.");
			else if (subSelect == 4) outputText("\"<i>Why don't you help out during battles, babe?</i>\" Exgartuan asks rather bluntly.\n\n\"<i>Hey, I've offered to help out with Champ's more seductive poses like you do...</i>\"\n\nIt isn't like you have much choice in the matter as far as Exgartuan is concerned!  The two continue their discussion, belittling your apparently meager combat performance.  Maybe your possessors could actually help deal some real damage for a change!");
			else outputText("Your [armor] has vanished!  You're butt naked!  It's pretty obvious who's at fau-\n\n\"<i>Really, [name], you don't even need it,</i>\" Exgartuan says, surprising you.\n\nShouldra laughs, \"<i>Right, Champ?  Two sexually-charged tyrants dwelling within you and you insist on sneaking around like common rabble?  Why not let it all hang out?</i>\"\n\nYour hands caress your [cock], exciting the demonic member into attention.  You remind the couple that your outfit isn't <b>just</b> for protection, citing many other-  Oh, your [armor] is back.  Guess they don't want to hear you prattle.");
			break;
		//General flavor text
		case 7:
			subSelect = rand(6);
			if (subSelect == 0) outputText("\"<i>Yoooo, Champ, are we gonna fuck something, or am I just gonna stagnate here?</i>\" Shouldra moans, managing to steal control of an arm long enough to give your [butt] a honk.  You sigh.");
			else if (subSelect == 1) outputText("Out of nowhere, a colossal yawn bursts forth from your craw.  \"<i>Come on, Champ. I'm dying to try out some new stuff I've cooked up.</i>\" What is this sense of dread consuming your being?");
			else if (subSelect == 2) outputText("It's been pretty quiet recently.  No doubt Shouldra is up to something -- she always is.  Honestly, you've forgotten what it's like to not having your body passing for a bloated something or other.");
			else if (subSelect == 3) outputText("As you are going about your business, you swear you make out muttering emanating from somewhere on your person. It sounds like the ghost girl is reciting some magic, but you don't feel any different. This only worries you even more.");
			else if (subSelect == 4) outputText("\"<i>Do foot fetishes still apply if it's your own foot?</i>\" Shouldra asks.  For a moment you wonder how such a feat would even be possible.  But only for a brief, forgetful moment...");
			else if (subSelect == 5) outputText("A familiar voice works its way from the back of your mind, \"<i>Hey, Champ.  You think there's any way to make armpits sexy?  What about knees or noses?</i>\"  This line of questioning could lead to some very troubling consequences...");
			else outputText("\"<i>I like what you did with those racks,</i>\" Shouldra says unexpectedly, her voice losing its mischievous edge for a moment.  \"<i>I'm glad you kept them.</i>\"  You both sit in silence for several moments as you consider her mood shift to tenderness, but the moment passes.  Shouldra chuckles softly.  \"<i>Just thought I'd mention.</i>\"");
			break;
		//Special Flavor Texts (misc. prereqs)
		//(Tel'Adre unlocked)
		case 8:
			outputText("Somehow, someway, you can feel Shouldra sifting through your memories.  \"<i>I'd love to visit the bakery in that desert town.  It's been at least a century since I tasted a decent sweet of some sort.</i>\"");
			break;
		//Preggo
		case 9:
			outputText("Your hands circle your bulging belly unbidden.  Shouldra seems to be enjoying your pregnancy.  \"<i>A good deal of the goblins I got a hold of were pregnant, but they don't really treat the event with anything other than their usual 'decorum.'</i>\"  The ghost girl lets out a deep sigh.  \"<i>There isn't anything wrong with enjoying it while you can, is there?</i>\"  Do the dead normally have this much interest in the birth of the living?");
			break;
		//(is preggers2)
		case 10:
			outputText("\"<i>Looks like the thing you're pregnant with is doing all right there, Champ,</i>\" Shouldra comments, your belly wiggling around a bit.  You ask that the ghost not go messing around with pregnancy, fearful of the consequences.  \"<i>Oh, please.  I wouldn't do anything crazy like that...</i>\" You can't see her, but you can picture the expression the ghost made as she trailed off.  And it worries you.");
			break;
		//(is butt pregnant)
		case 11:
			outputText("\"<i>I must admit, Champ, haven't run into too many instances of rear-ended pregnancies!</i>\"  Shouldra laughs, smacking your hand on your [butt].  \"<i>Just make sure that doesn't have to contend with all the other things that go in and out of your ass!</i>\"  You try not to dignify the crass remark with any sort of response.");
			break;
		//(can fly)
		case 12:
			outputText("You're taken by surprise when your wings act all on their own, lifting you off the ground with strong flaps.  \"<i>I'm trying to think of ways to use your own flight in some kinky shit, Champ,</i>\" Shouldra comments, \"<i>Nothing's coming to mind that's any better than me just floating your carcass instead.</i>\"  Well, we aren't all \"blessed\" enough to be deceased spirits!");
			break;
		//(is Naga)
		case 13:
			outputText("Your tail wiggles around on its own suddenly.  Catching on to how it appears to be sneaking to play around with something on your body, you calmly ask its spiritual captor to knock it off.  An otherworldly snicker emanates from it before it goes limp.");
			break;
		//(Amily is a follower)
		case 14:
			outputText("Your fingers move around a little, signaling Shouldra's stirring.  \"<i>It would seem that that mouse follows me everywhere I go,</i>\" she complains.  You figure she's talking about Amily.  You ask what her beef is.  \"<i>Too much baggage.  Don't want to deal with it.  I scared her a few times back at the town, but it wasn't all that satisfying.</i>\"  Looks as though Shouldra wasn't always the warmest of neighbors.");
			break;
		//(Pure Jojo is a follower)
		case 15:
			outputText("The silence bothers you a bit, so you decide to see if Shouldra is awake and ask her what she thinks about Jojo.  \"<i>You're talking about that holy mouse morph back at camp, right?  Not a fan,</i>\" she replies, shrugging your shoulders.  \"<i>Other than just not really being into people that remind me of rodents, I don't think he'd get along well with 'a spirit that has yet to abandon these mortal bonds.'</i>\"  she mocks.");
			break;
		//(has any of Marae's gift perks)
		case 16:
			outputText("\"<i>Man, Marae really did a number on you, Champ,</i>\" Shouldra comments, referring to your corrupted blessings.  \"<i>I'll have to hand it to you; you really get around.  Much more than I would have been willing to give you credit for.  Not everyone gets to fuck around with a goddess.</i>\"  You aren't sure if this is a compliment.");
			break;
		//(has had children with Izma)
		case 17:
			outputText("\"<i>");
			if (flags[kFLAGS.IZMA_CHILDREN_SHARKGIRLS] + flags[kFLAGS.IZMA_CHILDREN_TIGERSHARKS] == 1) outputText("That shark daughter of yours is");
			else outputText("Those shark daughters of yours are");
			outputText(" pretty cute you know,</i>\"  Shouldra blurts seemingly from nowhere.  Looks as though she's helping herself to your head.  \"<i>I'd love to get to meet them sometime, Champ.  Put some otherworldly fright in 'em so they grow up right!</i>\"  You doubt Izma would be too onboard with this visit.");
			break;
		//(has Incorporeality perk)
		case 18:
			outputText("\"<i>Looks like you really enjoyed that ectoplasm I gave ya, Champ,</i>\" Shouldra laughs, obviously in reference to the ghostly pallor of your skin.  \"<i>I never actually looked too much into what that stuff does.  I just don't have much else to hand out to people.  Anyway, if you want some ghostin' lessons, just let me know!</i>\"  You begin to wonder how a possession works when the possessed is possessed by a possessor that is already possessed by another possessor.\n\nBest to stop wondering.");
			break;
		//---(possessed by Boobgartuan)
		case 19:
			outputText("Your [fullChest] fidget ominously, a muffled female voice piping up, \"<i>No cloth, metal, latex, or gel can protect you from me, champion. Give in and caress these cans!</i>\"\n\n\"<i>Okay!</i>\" you say against your will.  Shouldra directs your hands to your titanic tits and massages them with gusto.  Looks like she's actually getting along with your demonically possessed rack.");
			break;
		//(PC knows any spells)
		case 20:
			outputText("\"<i>I see you've been dabbling in a little magic of your own, Champ,</i>\" Shouldra chimes in from out of nowhere.  \"<i>You know if you ask nicely, maybe I'll take you on as my apprentice.</i>\"  If you ever decide to put your intelligence to work making cocks ten feet tall, you'll have to take her up on that offer.\n\n\"<i>I can do things besides sex, you know, ass.</i>\"\n\nMind reading would be nice to have, too.");
			break;
		//(PC has anemone dick)
		case 21:
			outputText("Your armor undoes itself suddenly, revealing your perky anemone dick to the outside air.  You work to cover it back up when Shouldra's voice picks up inside your head, \"<i>Man, I don't think I've seen too many of these little guys.  Fascinating buggers.  Just don't let them lodged up your cootch, though.  Pain in the ass to deal with then.</i>\"  You didn't realize the quirky ghost was a biologist, too.");
			break;
		//(Computer date is within a week before or after Halloween/or on Halloween whichever's easier)
		default:
			outputText("Shouldra takes control of your body, the sudden shift scaring you slightly.  She doesn't do anything crazy, though; the ghost girl just stops and stretches, apparently just enjoying being a ghost!  \"<i>I love this time of year, Champ.  Don't ask me why, but I just feel more <b>alive</b>.</i>\"  Ghosts feeling alive?  This is too spooky for you.");
			break;
	}
	outputText("\n");
}



//Shouldra on-board with the PC will keep the worms encounter from occurring.
//Intro
//includes reference to SHOULDRA_WORM_SCENE_COUNTER
//SHOULDRA_WORM_SCENE_COUNTER increases after scene in case of repeat
//PC chooses between keeping worms or Shouldra
//trigger works same as Exgartuan's worm cure
//resets Shouldra hour timer if player keeps her
private function shouldraAndWormsYoureGonnaHaveABadTime():void {
	clearOutput();
	spriteSelect(67);
	outputText("Your eyes glow yellow, signaling Shouldra's desire to stretch around a little.  You grant her mastery over your hands as you continue about your business.  The eager phantom decides to push things a little, however, systematically removing your [armor].  A break isn't that big a deal you figure, and you relinquish full control to the giddy ghost.  She directs you out of plain view");
	if (player.cocks[0].cockLength < 48) outputText(" and cuts right to the chase, ballooning your [cock] into a rigid, wide, four-foot tall slab of meat");
	outputText(".  Unable to contain her delight, she hastily hugs your enormous dick firmly against your body and squeezes vigorously, rubbing your face against your [cockHead].  A warm stream of pre oozes out and onto your possessed face.");
	outputText("\n\nA strange sensation in the pleasant liquid slowly lures the phantom from her shaft-obsessed trance, your eyes slowly opening to discover what's at fault.  One of your worms managed to fall free of your loins and right onto the tip of your nose... much to Shouldra's chagrin.  The spirit slowly identifies the parasite, your body shuddering as she smacks it clear off your face.  She peers up at your large cockslit to find two more of the suckers lounging about in their makeshift hot tub, enjoying the brisk ");
	if (model.time.hours <= 12) outputText("morning ");
	else if (model.time.hours <= 5) outputText("afternoon ");
	else outputText("evening ");
	outputText("air.  Your hands clue the eidolon in to further activity, introducing her to your urethra all the way down to your [balls], every square wriggling inch chock-full of the little buggers, exploring their extended living quarters.");
	outputText("\n\nWhat follows is an unearthly scream that may have killed any small nearby woodland creatures with its intensity.  It certainly does a number on your hearing, anyway.  Shouldra jumps to your [feet], wagging your monstrous meat every which way as your hands furiously pat away at your head.  A few worms slide free from your flailing penis, but not many.  Your body tenses up, trembling profusely as your pelvis is pushed as far ahead of you as possible.  The typically confident spectre now has you frozen in place, your entire body poised and jittering in fear as you're forced to watch for any more unwelcomed guests.");
	if (flags[kFLAGS.SHOULDRA_WORM_SCENE_COUNTER] > 0) outputText("\n\n\"<i>H-h-how did I forget about these damn things!</i>\"  the spooked spirit utters through your mouth.  A worm pokes its head up out of your fat cock head, causing Shouldra to scream and violently pivot your hips again, desperately trying to shake more of the vermin loose.  \"<i>I... I can feel all of them... crawling around in-  How do you live like this!</i>\"  Again, you try and calm the panicked spirit, attempting to convince her to at least try and accept your infestation.  More wormy escape attempts cause your pelvis to thrash about; Shouldra not only refuses to touch your blighted phallus, but is actively working to avoid its every swing.  \"<i>NOPE.  NEVER.  These fuckers have GOT to GO!  There's no way in HELL I'm riding shotgun with-</i>\" The ghost has you shout yet again, quickly jumping away from a thick strand of your jism flying back towards you.  Looks like the decision lies with you.");
	else outputText("\n\n\"<i>Your dick's INFESTED!</i>\"  your mouth utters, lower jaw quivering in fear.  A worm pokes its head up out of your fat cock head, causing Shouldra to scream and violently pivot your hips again, desperately trying to shake more of the vermin loose.  \"<i>I... I can feel all of them... crawling around in-  How do you live like this!</i>\"  You explain to the panicked spirit to the best of your ability the allure of your dickworms - maybe you should have figured out a better name - how they aid in battle, how they help <i>after</i> battle, and many other fascinating facts one may not realize about your chummy little pals.");
	outputText("\n\nThe two of you sit in silence for a moment, your body breathing heavily.  \"<i>What the fuck is wrong with you?</i>\"  your mouth says plainly.  More wormy escape attempts cause your pelvis to thrash about; Shouldra not only refuses to touch your blighted phallus, but is actively working to avoid its every swing. \"<i>NOPE.  NEVER.  These fuckers have GOT to GO!  There's no way in HELL I'm riding shotgun with-</i>\"  The ghost has you shout yet again, quickly jumping away from a thick strand of your jism flying back towards you.  Looks like the decision lies with you.");
	//[Keep Worms]	[Keep Shouldra]
	simpleChoices("Keep Shouldra", kickOutWormiesForYourGhostPalPAL, "Keep Worms", kickOutShouldra4YoWormyBuddies, "", null, "", null, "", null);
}
//Keep Worms
private function kickOutShouldra4YoWormyBuddies():void {
	clearOutput();
	spriteSelect(67);
	outputText("Shouldra is clear that there is no ally to be had in your crotch-dwelling creepies, shutting down any further attempts for negotiations.  Be it that you have taken a shining to the little invertebrates or that you've had enough of your judgemental companion, you decide that the worms will be staying, with or without Shouldra.");
	outputText("\n\n\"<i>Are you fucking kidding me?  You're keeping these... <b>things</b>?</i>\"  Sensing your firmness in this regard, Shouldra quickly phases out of your back, pushing you flat onto your besieged dick.  The angry spirit pauses to get in a final word, but you rise off the ground and face her, absentmindedly giving her front row access to the main event.  A trio of worms hanging out in your slit is enough to send the ghost heading into the horizon.");
	if (player.cocks[0].cockLength < 48) outputText("  With that little ordeal dealt with, you now are left to decide how best to manage the time until your cock returns to its normal size.");
	outputText("  Oddly enough, you hope the little buggers appreciate you sticking up for them.");
	//Follower Shouldra leaves
	flags[kFLAGS.SHOULDRA_FOLLOWER_STATE] = 0;
	doNext(camp.returnToCampUseOneHour);
}
//Keep Shouldra
private function kickOutWormiesForYourGhostPalPAL():void {
	clearOutput();
	spriteSelect(67);
	outputText("You concede to the paranormal plaintiff and agree to part with your parasitic companions, but under one condition: that she be the one to rid you of them.  Shouldra's happy to have won you over, but the prospect of having to deal with this issue doesn't sit well with her.  Your body trembles again as she focuses her attention back on your besieged dick.  A duo of worms are poking out from - they're quickly expelled with another violent shake.");
	outputText("\n\n\"<i>Okay... I think I got this,</i>\" the spirit proclaims by way of your mouth.  Your body takes a shuddering deep breath as the ghost girl tries her best to focus on casting a spell.  A searing heat suddenly overtakes your [balls] causing the beasts to stir wildly within your crotch.  The bizarre sensation ruins Shouldra's concentration, causing your hands to grasp onto your head as she shouts and flails your wang about in the air.");
	outputText("\n\n\"<i>I can't do this!</i>\"  the panicked spirit shouts from your maw.  You try and calm her down, cluing the spooked spook in on how the first half of her anguish is over now that the worms' home is no longer hospitable for them.  The second half of the problem is that, in their terrified state, they can't make the journey up your tower of terror.  Unable to focus long enough to work through an incantation, you spell out the only real solution for your troubled companion: that she needs to get hands-on.");
	outputText("\n\n\"<i>You're a real fucking asshole, you know that?</i>\"  Shouldra says out loud.  Digging deep down for any shred of her trademark confidence, your trembling hands slowly work their way towards your infested manhood.  The confined worms are stirring around with ferocity in their attempt to flee, distending your urethra as they clump together at its base.  Shouldra freezes up, your trembling hands mere centimeters from your wriggling meat.  You give her a mental shout, forcing the spirit into action.  She screams incessantly as your hands move up and down your length, taking special care to avoid the undulating passageway in the front.  Your eyes slam shut as your head turns to face away from the spectacle.");
	outputText("\n\nFueled by the sizzling churning in your [balls], the spirit works you towards a mighty geyser.  She cringes further, trying her best to direct the parasite-riddled spray away from you.  However, the head worm gets lodged in your canal, knocking some of Shouldra's worst nightmare onto your head.  She prances around in place, your hands knocking any offenders clear from your body.  The flailing about manages to loosen the obese leader from your shaft, aided by a final spurt of cum.  Shouldra balls up all her rage and unleashes it onto the poor little critter, setting it aflame.");
	outputText("\n\nTaking great caution, the spirit falls you back onto your rump, still trembling from the horrifying ordeal.  With weary eyes, she stares at what was once her glorious salvation that had now become a drooping dick.");
	outputText("\n\n\"<i>We are taking a bath first thing when we get to your camp, Champ,</i>\" Shouldra says by way of your mouth, your body still shuddering.");
	player.removeStatusEffect(StatusEffects.Infested);
	doNext(camp.returnToCampUseOneHour);
}


//Shouldra and Exgartuan Don't Get Along
//For Cock Exgartuan
//Scenes unlock in succession, only occurs once
//Keeping both spirit and demon unlock flavor text above.
//Argue 1 - When going to bed
public function shouldraAndExgartumonFightGottaCatchEmAll():void {
	//40% chance to occur when player has both Shouldra and Cock Exgartuan and is going to sleep
	//Unlocks Argue 2
	spriteSelect(67);
	outputText("your " + camp.bedDesc() + " looks mighty comfortable after a hard day's ");
	if (player.cor < 50) outputText("work");
	else outputText("fucking");
	outputText(".  Just when you're [armor] and about to tuck in for the night, however, your [cock] goes fully erect!  The throbbing demonic mass is flailing about, knocking into your shit and making a mess.  You clutch onto the bucking bronco in an attempt to prevent any further damage when Exgartuan begins to shout, \"<i>Don't FUCKING touch me, you goddamn cunt!</i>\"");
	outputText("\n\nWell, what the fuck has gotten into him?  And since when does he not like being-");
	outputText("\n\n\"<i>What part of 'HAUNTING THIS SHIT' do you not understand?</i>\" you reply in a new voice, now under the sudden direct influence of your local poltergeist.");
	outputText("\n\n\"<i>The 'shit' you're haunting only deals with this sack of meat behind me, sister,</i>\" Exgartuan bellows, breaking free of your grasp.");
	outputText("\n\n\"<i>This is a whole package deal, asshole.  You can't just block me out from big dick sensations,</i>\" Shouldra shouts back rather upset.");
	outputText("\n\n\"<i>What I fuck and feel is for me and the champ here, got it?  You should feel fucking praised that you even get to control hands that brush up against a god such as myself.</i>\"");
	outputText("\n\nBefore Shouldra's rebuttal, you at least get to make it clear for her to relinquish control over your body back to you.  She does as much while maintaining the spirited debate over semantics and property rights with the protective demon, her upper torso -- slightly scaled down -- molding up and out of your flesh.  You're honestly too tired to pay the two much mind, so you resume working your way back down to your " + camp.bedDesc() + ".  Though with your dick still arguing with your ghost, you doubt getting under your covers would be wise.");
	outputText("\n\n[if (isBiped = true) You instead tuck your [cock] down between your [legs] and lay on your stomach, distancing yourself from their bickering.  Neither party pays you much mind as they continue arguing, your third leg still fidgeting despite the awkward placement while Shouldra has moved residency to your back.  You cover your head with a pillow and soon thereafter head off to slumber.][if (isBiped = false) The best you can hope to manage is to lay on your side and use your covers as a makeshift fortification between you and your arguing [cock].  Shouldra and Exgartuan pay you no mind despite the odd construction, leaving you to bury your head in your pillows and, eventually, head off to sleep.]");
	flags[kFLAGS.SHOULDRA_EXGARTUDRAMA] = 1;
	doNext(playerMenu);
}

//Argue 2 - When out exploring
public function exgartumonAndShouldraFightPartII():void {
	//unlocks after Argue 1
	spriteSelect(67);
	//40% chance to occur during scene transition
	outputText("\nA sudden immense buildup in your [cock] takes you by surprise, easily bursting out of your [armor]!  Your urethra is horribly distended, your entire demonic length rumbling in preparation for something tremendous!  The unexpected pressure forces you to your knees.  Your head closer to your evil dong, you realize that you can make out muffled shouting inside.  This is hardly anything you-");
	outputText("\n\nA mind-bending ejaculation dislodges whatever was in there in the first place.  Never has anything felt more excruciating and yet satisfying in all your days.  You peer at the massive gob of your cum, surprised when it gets up and has a face... a rather angry one at that.  Actually, it resembles Shouldra!");
	outputText("\n\nExgartuan is laughing his head off at this point.  Not particularly thrilled with the experience, the cum spirit marches back towards you.  Too confused to react, you find yourself absolutely drenched in your own jism as Shouldra stomps back into your body.  The ghost and demon begin arguing, leaving you back to your moistened ventures.\n");
	flags[kFLAGS.SHOULDRA_EXGARTUDRAMA] = 2;
}
//Argue 3 - When out exploring again
public function exgartumonAndShouldraFightPartIII():void {
	//unlocks after Argue 2
	spriteSelect(67);
	//50% chance to occur during scene transition
	outputText("\n\"<i>Hey, Champ, check this out,</i>\" Shouldra has you blurt clear out of the blue.  The poltergeist assumes control over your body, quickly shedding your [armor] and transitioning into some manner of casting.  She's typically been pretty good about not just doing whatever the fuck she feels like with you without at least asking first.");
	outputText("\n\nYou instinctively try and clench your fists when tight, stinging sensations start coursing through your midsection.  Exgartuan's attention is perked as well, \"<i>What is that fu-AAAAARRRARA!!</i>\"  Your [cock] is thrashing and twitching as the ghost's magic sinks in.  Your various nodules and magenta coloring fade into your member, slowly aiding in the transformation of your <b>enormous new horse cock!</b>");
	outputText("\n\n\"<i>You don't like it when people fuck with <b>you</b>, huh?</i>\" Shouldra has you shout at the equestrian package.  Exgartuan grunts and strains, your urethral opening twitching with the demon's every exertion.  With a mighty growl, your horsey wang <b>returns to its demonic complexion.</b>");
	outputText("\n\n\"<i>Stop screwing with me, babe, or I'll show you what it's like to die TWICE.</i>\"");
	outputText("\n\nYou have no desire to see this escalate further and tell the two as much.  The planets must be aligned in your favor, as the two actually calm down.  But only to a level where they're at least still grumbling and mumbling to one another.\n");
	flags[kFLAGS.SHOULDRA_EXGARTUDRAMA] = 3;

}

//Argue 4 - At bed, morning, time to decide
public function exgartuMonAndShouldraShowdown():void {
	//unlocks after Argue 3
	//75% chance to occur during sleep
	//Time is 5:00
	spriteSelect(67);
	outputText("\nAn unusually early awakening for you is brought upon by your massive morning wood.  You appreciate the warm greeting by your [cock], but the sun is barely even out yet and-");
	outputText("\n\nOh... no... wait.  This is no humble daybreak greeting between a happy cock and its [master]; Shouldra and Exgartuan are fucking arguing again, causing your member to twitch and thrash as their discordant voices pour out from within it.");
	outputText("\n\n\"<i>What part of 'STAY OUT' do you not understand, bitch!</i>\"");
	outputText("\n\n\"<i>The part where you think I fucking care!  Stop fucking hogging all the cock!</i>\"");
	outputText("\n\n\"<i>I'M running this show and I don't like stage jumpers! Now get OUT!</i>\"");
	outputText("\n\nYour [cock] thrusts to one side, forcing Shouldra right out of your contested cock, taking your sheets along with her as she pushes into the side of your " + camp.homeDesc() + ".  This bickering is getting stupid now.  These two could probably go on like this forever.  Neither of them seem to have given you even the slightest bit of attention on the matter.  You know, the " + player.mf("guy","gal") + " ATTACHED to the world's most popular shaft?");
	outputText("\n\nShouldra untangles herself out of your sheets, tossing them back to the ground in a huff.  You groggily raise to your [feet], spurred on by your raging demonic erection and its vendetta against your cock-hungry, post-mortem playmate.");
	outputText("\n\n\"<i>Just WHAT is your problem?  I'm sick of repeating myself!  Whether you like it or not, I'm part of the group, and the group SHARES,</i>\" Shouldra shouts, thrusting her arms to her sides.");
	outputText("\n\n\"<i>You still think this is a group, babe?  You still think you and me are on the same page?  You still think that just because you can set up shack inside any sack of flesh you come across that that gives you the right to brush up against ME?</i>\"  Exgartuan about conks you in the face as he rises skyward, proudly trying to make himself as mesmerizing and alluring as he thinks he is.  \"<i>I'M the fucking BUSINESS, sugar.  You need to get in line with all the rest of the bitches that are slobbering over this magnificent dick.</i>\"");
	outputText("\n\n\"<i>I never thought ANYTHING could make me hate a huge hunk of dick, but you're really proving me wrong.</i>\"");
	outputText("\n\nShouldra is getting steamed, visibly grinding her teeth.  But you're the one that should really be pissed off.  No matter what anyone thinks, this mammoth cock belongs to YOU.");
	if (silly()) outputText("  It's a man's right to choose what's done with his body.  Not anyone else's!");
	outputText("  You shout loud enough to get the two to at least shut up and notice you're there.  It's time to end this little battle once and for all, starting with your first - and hopefully last - involvement.");
	//[Keep Exgartuan]	[Keep Shouldra]	[Keep Both!]
	simpleChoices("Keep Exgartuan", keepExgartuanInsteadOfShouldra, "Keep Shouldra", keepShouldraAndKickOutExgartuan, "Keep Both", keepAllTheGhosts, "", null, "", null);
}
//Keep Exgartuan
private function keepExgartuanInsteadOfShouldra():void {
	clearOutput();
	spriteSelect(67);
	outputText("In no uncertain terms, you announce to your former paranormal partner that you're siding with the demon on this one.  [if (corruption > 75) \"He's just a better teammate to have when it comes to hot dickings.  \"]You place your hand around your [cock] as Exgartuan as he rubs up against you, approving of your decision.  Shouldra looks on in just complete disgust and confusion.");
	outputText("\n\n\"<i>Are you kidding me, Champ?  This tainted blight of a dick is what you want over me?  ...You're kicking me out of the band over this <b>thing</b>?</i>\"");
	outputText("\n\n\"<i>No one likes a clingy girlfriend, ghost gal,</i>\" Exgartuan chides.");
	outputText("\n\n\"<i>Girlfriend! I-</i>\" Shouldra stops, not wanting to give off the wrong impression.  She's obviously through with you anyway.  \"<i>Champ, this fucker is corrupting your mind.  You see that, right?</i>\"");
	if (player.cor < 10) outputText("\n\nYou nod, trying to excuse your decision by at least explaining how well you've been purifying yourself afterward.  \"<i>Stop kidding yourself, champion.  We all know you're just as crazy about me as she is.</i>\"");
	else if (player.cor < 60) outputText("\n\nYou nod, but quickly brush away the Shouldra's claim as anything worth worrying about.  You're as sound of mind as you always have been.  Exgartuan only laughs as your hand strokes vacantly up and down his mighty length.");
	else outputText("\n\nYou don't know what she's going on about, but you attest to just how fucking awesome Exgartuan is at... well, fucking.  Shouldra just stares at you, acting is if she's in on something you're not.");
	outputText("\n\n\"<i>I didn't think you'd side with this actual prick, Champ.  When you-</i>\"");
	outputText("\n\n\"<i>Blah, blah, blah,</i>\" Exgartuan interrupts, \"<i>Just get lost already.  The sun's almost up and we've cunts to fill.</i>\"");
	outputText("\n\nShouldra gives you one last stink eye before doing a 180 and storming out of the " + camp.homeDesc() + ".  Exgartuan starts blathering on about something or other as you reflect on your decision.  No use dwelling on it too much, though; you figure you'll never be seeing the shade again.");
	flags[kFLAGS.SHOULDRA_EXGARTUDRAMA] = -1;
	//Shouldra gone for good
	flags[kFLAGS.SHOULDRA_FOLLOWER_STATE] = -1;
	doNext(playerMenu);
}
//Keep Shouldra
private function keepShouldraAndKickOutExgartuan():void {
	clearOutput();
	spriteSelect(67);
	outputText("You decide to jump to Shouldra's side on this one, explaining to your demonic cock your desire to go your separate ways.  Exgartuan heartily laughs at you, your [cock] wiggling in the air with each mighty heave.");
	outputText("\n\n\"<i>You think you can just get rid of me?  That's RICH.  Do you think you can find a blade sharp enough to pierce this raw power?  Can you even stand to lose the only thing attached to your body worth living for?</i>\"  the cocky cock thumps against your [fullChest], taunting you further.  You figure there's no need to fucking mutilate yourself.  This is Mareth: a land ripe with things that shrink, enlarge or even double dicks. It'll take you a while, but with Shouldra's help you can probably get the necessary items to get rid of your demonic dong.  Though losing your cock isn't really a prospect you're that fond of, demon or not.");
	outputText("\n\nShouldra laughs and shrugs, drawing the demon's ire.  \"<i>Have you gone crazy, wench?  I understand if the mere thought of losing this burly hulk of sexual fantasy pushes you over the edge and all,</i>\" Exgartuan says, still full of himself even with the topic of his departure hanging in the air.");
	outputText("\n\n\"<i>All this time you've spent cockblocking me, and you think that all I did in return was hold a grudge?</i>\" the spirit says, rage subsiding for confidence in each word.  \"<i>You can try and scare Champ here with final solutions like cutting off dicks all you want, but I know what the score really is here.</i>\"");
	outputText("\n\n\"<i>What madness is dribbling out of your cock-starved cunt?  I AM THIS COCK.</i>\"");
	outputText("\n\nShouldra shrugs, her confidence ballooning into arrogance as her face gets only more smug, \"<i>You think I'm new to this game, chief?  I make a fucking living jumping in living bodies.  You're no full-on cock; you're just a demon curse on this otherwise splendid piece of meat.</i>\"");
	outputText("\n\nShouldra's pushing Exgartuan's buttons something fierce.  Unluckily for you, the supposed demon curse is still fully ensconced on your mid-section.  Your [cock] feels like its sucking the life out of you in its rage, engorging itself with blood and pushing you to the most powerful erection you've ever laid eyes on... or had the misfortune to have.  It's actually really taxing on you as the demon wang puffs up in protest, throbbing with each heartbeat of yours.  Not only can you visibly make out veins, but you're afraid the various bumps on your member might be going haywire, too.");
	outputText("\n\n\"<i>ARE YOU FUCKING KIDDING ME, BITCH?  YOU'RE ACTUALLY QUESTIONING MY GREATNESS?</i>\" Exgartuan shouts, your entire length rigidly pointing at her.");
	outputText("\n\nShouldra is all too happy with herself and looks the demon right in the, uh, gaping angry piss-slit.  \"<i>Don't need to question what I fully understand.  You talk all this big game, how you've traveled the world from dick to dick, satisfying orifices near and far. But you're nothing more than some annoying little curse from some forgotten fountain in the middle of the fucking desert.  Any idiot that aimlessly wanders over and sucks some of that shit down can get a nice big demonic set of something that talks shit.</i>\"");
	outputText("\n\nHey.");
	outputText("\n\n\"<i>You're nothing special, pal.  You're just a mess in this prick that I intend to clean up.</i>\"");
	outputText("\n\n\"<i>I AM THE GODDAMN DEVIL OF DICKINGS!  I'LL FUCKING RAVAGE YOU!</i>\" Exgartuan shouts, surging forward at the bent over ghost.  In his rage, he managed to somehow forget just what a ghost can do, passing right through the happy phantom.  Before he can correct himself and throw you around the room any further, Shouldra's form turns to a fog and permeates your [cock].  You fall to your back as the war rages on in your titanic dong, violently thrashing around every which direction as two struggling voices emanate from within.  Your cock crashes into things all over your " + camp.homeDesc() + ", knocking one thing over before bashing into the next.  You're afraid to even lay your hands on it!");
	outputText("\n\nIf all that weren't enough, a sudden stinging pain radiates through your manic member.  You arch your back in response, falling in short order to the rough sensations.  In your anguish, you manage to catch a glimpse of just what's going on.  Your [cock] is locked in the middle of some transformation struggle, going back and forth between its demonic appearance and that of a pristine - yet still enormous and a tad pale - human cock.  Your various nubs, nodules and bumps press in and out of your shaft, Exgartuan gravely trying to maintain his hold on your sex.  The undulating flesh on your significantly engorged battlefield is driving you insane!");
	outputText("\n\nFinally your penis holds with its more human complexion.  The blood-filled monument stretches as far as it can as your urethra gapes wide.  Exgartuan is yelling out in agony.");
	outputText("\n\n\"<i>Almost done, Champ!  Just help me out with the last push!</i>\" Shouldra shouts from somewhere.  You realize that your dick's carnal canal is still your previous magenta hue from before this altercation.  Shouldra must have prepped the demon for ejection.  You summon whatever strength you have left in you in order to rub your sore shaft.  Shouldra must have been up to something else, as it only takes you a few strokes along the incredibly sensitive monster until you orgasm.  Thick globules of inky-black cum shoot out of your purified penis, making a mess on your " + camp.homeDesc() + "'s inner wall.  The load is true to your legacy, the gargantuan tidal wave after wave of black ooze seemingly never ending.");
	outputText("\n\nFinally, your penis goes the slightest bit limp, giving you relief from the boner to end all boners.  You stare at the rather disgusting pile of goop you managed to dislodge from your johnson.");
	outputText("\n\n\"<i>Concentrated demonic possession,</i>\" Shouldra proclaims, her upper torso sticking out of your tower, \"<i>THAT Exgartuan won't get to enjoy any more 'hot dickings,'</i>\" she teases.  \"<i>Don't worry about that mess.  I think it'll eventually just evaporate without any vengeful demonic cock spirits haunting your " + camp.homeDesc() + " or something.</i>\"  The last thing you need after a trip like this is ANOTHER poltergeist.");
	outputText("\n\n\"<i>You know, nothing in that pile effected your actual load,</i>\" Shouldra smiles, reaching over from her perch to rub your [balls].  \"<i>How's about we greet the morning sunrise with my brand new cock.  I never liked that grody demonic dong you had earlier.  I mean, just look at this thing.  I made the head nice and...</i>\"");
	outputText("\n\nShouldra goes on and on about her new toy.  She's certainly a spry little thing.  After paying one more glance to the mess in the side of your " + camp.homeDesc() + ", you finally get to move on with your day.  You really hope Shouldra was right about that sight evaporating on its own.");
	//PC has human dick
	player.cocks[0].cockType = CockTypesEnum.HUMAN;
	//Exgartuan departs
	player.removeStatusEffect(StatusEffects.Exgartuan);
	//unlocks one more scene for later that night
	flags[kFLAGS.SHOULDRA_EXGARTUDRAMA] = -0.5;
	doNext(playerMenu);
}
//Keeping Shouldra 2 - Exgartuan's back from the dead!
public function keepShouldraPartIIExgartumonsUndeatH():void {
	clearOutput();
	spriteSelect(67);
	//unlocks after previous scene.
	//occurs next time PC goes to sleep
	//only happens if PC still has cock, otherwise goes away never to be heard from again
	outputText("While slipping into your " + camp.bedDesc() + " to enjoy a peaceful night's sleep, a chill runs down your spine.  You look around to-");
	outputText("\n\n\"<i>YOU THINK YOU CAN FUCKING GET RID OF ME THAT EASILY, CHAMPION!</i>\"");
	outputText("\n\nHoly shit! your " + camp.bedDesc() + " just fucking spoke!  With Exgartuan's annoying voice!  You try and extricate yourself, but you're sucked in under the covers!  Your entire sleeping setup is compressing around you, the dead demon's laugh booming in from every angle.  In nothing but your birthday suit, you uselessly claw at your sheets to try and escape, but it's no use!");
	outputText("\n\nYou fear for the worst as your bed and sheets close in on you.");
	flags[kFLAGS.SHOULDRA_EXGARTUDRAMA] = 0;
	//[next page]
	doNext(keepShouldraPartIIIExgartumonsUndeatH);
}
private function keepShouldraPartIIIExgartumonsUndeatH():void {
	clearOutput();
	spriteSelect(67);
	outputText("\"<i>Boo!</i>\"");
	outputText("\n\nShouldra's head materializes out of your covers directly in front of yours, smiling smugly.");
	outputText("\n\n\"<i>The look on your face,</i>\" the fabric phantom laughs.  You sigh and at least manage to poke your head out from under your haunted sheets.  Shouldra's head quickly follows you, forming on the outside to greet you.  The frisky ghost tucks you in nice and tight before she begins massaging your [cock] from every angle with her cot haunt arrangement.");
	outputText("\n\nYou enjoy a peaceful night's sleep for a change.");
	doNext(playerMenu);
}
//Keep Both!"
//earth elemental
private function keepAllTheGhosts():void {
	clearOutput();
	spriteSelect(67);
	outputText("It blows your mind that these two can't get along.  You have no qualms with sharing your [cock] with all involved parties if they would just get along.  With everyone's attention finally in your possession, you explain to Exgartuan how useful Shouldra's magic could be to him.  Hopefully the demon will listen to reason so your loins will no longer be a contested battleground.");
	outputText("\n\n\"<i>Are you fucking kidding me, champion?</i>\"");
	outputText("\n\nOr not.  Looks like your silver tongue's failed you for a change.");
	outputText("\n\n\"<i>What use would I have for this bitch?  I can adjust any hole to accommodate my godlike girth,</i>\" your [cock] bellows.  \"<i>The mere notion that-</i>\"");
	outputText("\n\n\"<i>Wait, you think all I can fucking do is make holes bigger?</i>\" Shouldra shouts, staring daggers at your demonic dong.");
	outputText("\n\n\"<i>Oh, I know you can make things larger and few other parlor tricks.  But they really don't concern me or my greatness.</i>\"");
	outputText("\n\n\"<i>You want to see fucking greatness?  Come on.</i>\"");
	outputText("\n\nShouldra grabs you by the arm, dragging you to a nearby clearing just outside camp.  Exgartuan seems less than anxious to see what she's planning.  \"<i>What are you wasting my time with now?  Are you going to pull a dick out of a hat or something?</i>\"");
	outputText("\n\nShouldra just clenches her fists and turns away from you, stomping her foot into the ground as she firms her poise.  She spreads her hands forward and begins some manner of spell.  It's a long one, too.  Several seconds pass by with no visible effect to be seen.  Exgartuan motions as if he's about to start heckling the caster, but you manage to hush him up with a few vacant strokes.  You're really interested to see just what sort of spell would take almost a solid minute of incantations to complete.");
	outputText("\n\nWithout missing a beat, the ghost girl begins to glow brightly.  Exgartuan sighs, growing impatient.  You're worried your efforts to soothe the beast long enough to prevent him from interrupting the spell will be for naught when something catches your attention.  The ground is shaking!  Shouldra's glow only grows brighter while her hair starts to float around strangely.  The spirit witch is the least of your concerns when an enormous hand bursts forth from the ground!  A small patch of grass with a cute little flower rises skyward, forming the head of a massive nine foot tall earth elemental!  The towering monstrosity sports an exaggerated hourglass figure; the being rises over you with a couple of massive breasts - easily at least HHH cups exhibiting thick, juicy nipples - with a sickeningly wide pair of hips below it.  As its dirt form compresses and tightens, a couple of faint green glows appear on its head where its eyes would be.  The rather muscular titan of the earth finally comes to a rest, standing at attention before its summoner.  You can't help but giggle at little at the patch of grass atop its head, the flower still happily swaying in the breeze.");
	outputText("\n\n\"<i>THIS is what I can do!</i>\" Shouldra proudly proclaims, raising her arm to showcase her creation as she turns to face you and your doubting dick.  \"<i>I've been working at the arcane arts for close to a millennium!  There's NOTHING I can't do!</i>\"  You wonder why she doesn't help more in battle then.  Or why she can't find a way to get herself off on her own.  Her claims of unlimited power seem dubious at best.");
	outputText("\n\nExgartuan seems to be content with the accomplishment, though; your [cock] is at full mast.  Your wang drags you forward, anxious to drill into the earth to mine for treasure.  But with a glint in Shouldra's eye, the elemental quickly weaves around the penetration attempt, grabs your massive cock with one hand and easily lifts it and you off the ground.");
	outputText("\n\n\"<i>This is fine!</i>\" Exgartuan shouts, \"<i>I like to play rough!</i>\" The dirt goliath gives her catch a quick squeeze, pushing a labored groan from you and the demon.");
	outputText("\n\n\"<i>If you want to fuck this and any other magnificent creation of mine, you need to stop being a dick and let me in on that dick for a change,</i>\" Shouldra shouts as she leans against her machination.  \"<i>She may not be one for conversation - or free will, really - but she'll work in a pinch no matter what you throw at her!</i>\" the ghost girl boasts, patting the giant's equally large ass.  Again, you wonder why she can't be bothered to lift a finger for you elsewhere.");
	outputText("\n\n\"<i>I guess I can let you in on the fun after all then,</i>\" Exgartuan concedes, torrents of anticipatory pre gushing from his maw and soaking into the creature's hand.  \"<i>I suppose it's only natural for a girl to go to any lengths for a piece of this action.</i>\"");
	outputText("\n\nShouldra doesn't even bother with the demon's snarky remark trying to maintain at least the illusion of his clout.  She orders her friend to return you to the ground.  \"<i>I knew you'd eventually see things my way,</i>\" the ghost says seductively as her form incorporealizes.  As seems to have been the case through this whole ordeal, you doubt that she was talking to you.  The spiritual mist envelops and seeps into your [cock], only making it warmer, harder, and fuller.");
	outputText("\n\nA dead silence hits the early morning air now.  The vacant earth elemental doesn't seem to be much for speaking.  She casually strolls up to you and begins smearing your demonic lube all along your length.  Her giant, coarse hands feel surprisingly great on your sexual flesh; you just wish that there was life behind those vacant glowing eye holes.  The whole no-face thing isn't doing much for you.");
	outputText("\n\nThe golem finishes its task in no time, your beating rod glistening in the dull orange light of the approaching sunrise.  You wonder just what exactly your dual-possessed cock is going to penetrate on the featureless machination; Shouldra spared no mental expense making the breasts as feature rich as she could, but the blank canvas of a pelvis isn't particularly inviting.  This issue is apparently only in your head, however, when the prepped penis drills right into the elemental, causing her to stumble forward and grasp onto your arms with her mighty grip.");
	outputText("\n\nYour vision is obscured by creature's tits, your head sinking into the tightly-packed dirt globes.  You only go in further as the fervent couple in your manhood thrust in and out of their makeshift cunt.  The unrelenting pace, free of any preparatory foreplay, is murder on your pelvis[if (hasBalls = true) \"; the mighty swings of your [balls] between you and your partner aren't helping matters much either\"].  But you're forced to soldier on, unable to either resist the mighty force of your haunted demonic dong or the mammoth grip of the earth elemental.");
	outputText("\n\nYour head completely swallowed by earthen mounds, you fail to notice the earth elemental slowly falling apart under the sheer force of your fucking.  Though anything important to your rod's endeavour remains flexible, firm, and unyielding, the elemental's exaggerated hourglass form takes its toll on her lower legs.  They soon break apart to return to the ground, sending the giantess to her knees and taking you down along with her.  This of course bears no consequence on your [cock], its mission remains unwavering.");
	outputText("\n\nYour hands hold steadfast on the creature's expansive hips.  It feels as though you should be contributing more to this morning feast; the ramming is being done without you, and you presume that anything you would try to do with your fictile friend would ultimately be for naught.  It makes sense, though, considering how these two never really acknowledged your existence right from the start of their angry misadventure.  You may as well enjoy their hot makeup sex.");
	outputText("\n\nAnd enjoy it you do, soft moans easing you through the intense vibrations as your cock explores inner caverns of its own design.  The ramming turns violent with hard, forced thrusts spurred on by your nether regions.  The two minds throw your pelvis one direction and the next, digging your [cock] further and further.  Your entire body plows repeatedly into the elemental, smothering you in mud and dirt with each smack.  [if (hasBalls = true) Ready to unleash their churning payload, your [balls] tighten up something fierce, rumbling in anticipation.  ][if (cumNormal = true) \"The modest load hardly makes a dent in the golem's cavity.\"][if (cumMedium = true) \"The above-average load floods the golem's cavity, gushing back around your cock\"][if (cumHigh = true) The intense load streams even farther within the dirt innards of the earth elemental, expanding her slightly.][if (cumVeryHigh = true) The extreme load fills the titan vigorously, your pearly seed threatening her composition as it permeates her body.][if (cumExtreme = true) \"There are no words to properly explain the magnificence of your ejaculation.  Only through Shouldra's magic does the beast maintain the furious blasts from your loins, soiling even every insignificant pocket of air with your seed.\"]");
	outputText("\n\nYour eyes go wide with your release, but your [cock] only works harder, working in tandem with your climax to ravage the poor incantation.  It's starting to hurt with how hard you're being slammed into the creature, but it's nothing compared to the torment the earth elemental is going for.  Maybe it's for the best that the thing only has the simplest of sentience.  You reassure yourself of your assumption when the jugs engrossing the upper half of your body lose their form, tumbling to the ground and allowing for a clear view of the elemental's downfall.  Her glowing eyes are starting to fade out of existence");
	if (player.cumQ() >= 1000) outputText(", trails of your cum pouring out from them");
	outputText(".");
	outputText("\n\nThe powerful grip surrounding you quavers and falls as she loses her arms.  And with one last, mighty thrust, your [cock] finally pierces through to the other side of the elemental, snuffing its life and sending a wall of earth crashing down on top of you.  A pile of dirt with an enormous dick sticking out of it would certainly be a sight for some random passerby to come across.  A few minutes worth of digging frees you from the cum-soaked digsite.  That was certainly an experience you have mixed feelings about.");
	outputText("\n\nExgartuan and Shouldra seem content with one another now, though.  The powerful climax managed to knock both of them out.  Seems that fucking an elemental literally back to the earth it was spawned from really did it for them.  Their friendship will hopefully bring you some much wanted peace, but you worry about what strange things will come of their alliance.  It feels as though your [cock] can only endure so much, but those limits will surely be stretched.");
	outputText("\n\nYou'll spend the rest of the early morning greeting the sunrise and cleaning off.");
	//puts Shouldra and Exgartuan to sleep/resets their timers
	shouldraSleeping(15,true);
	player.changeStatusValue(StatusEffects.Exgartuan,2,(12+rand(7)));
	//unlocks follower dialog
	flags[kFLAGS.SHOULDRA_EXGARTUDRAMA] = 4;
	doNext(playerMenu);
}

//Intro
public function shouldraBakeryIntro():void {
	clearOutput();
	spriteSelect(67);
	outputText("You set off towards the bakery, and it's not long before the smell of freshly-baked pastries and sugary candies wafts through the air.  Something stirs in your mind as a familiar ghostly presence makes herself known; seems you're not the only one who noticed the scent of cinnamon.");
	outputText("\n\n\"<i>Oh hey, a bakery!</i>\" She exclaims, \"<i>Are we gonna grab something?  All those years of being a ghost did a real number on my appetite.</i>\"  ");
	//first time: 
	if (flags[kFLAGS.SHOULDRA_BAKERY_TIMES] == 0) outputText("You smirk, wondering how exactly a ghost manages to work up a hunger.  Your skepticism is met by an intense stabbing pain in your stomach, forcing you to buckle slightly from the cramping.  It lasts only a moment before it vanishes, however.  \"<i>You feel that, smartass?</i>\" The ghost girl sneers, \"<i>That's what decades of fasting will do to you.");
	else outputText("You point out that she's already had something at the bakery.  \"<i>Yeah, I did.  And now I'm hungry again.  Deal with it.");
	outputText("  Now, how about a snack?  Or two?</i>\" Her enthusiasm is clear...  and slightly worrying.");
	simpleChoices("Continue", feedShouldraACake, "Bail Out", bailOut, "", null, "", null, "", null);
}

//Bail out (you pussy)
private function bailOut():void {
	clearOutput();
	spriteSelect(67);
	outputText("You quickly turn around and head back the way you came.  There's a moan of disappointment from Shouldra, before she settles down and goes back to doing whatever she usually does.  You try not to think about it as you leave the city and return to camp.");
	doNext(camp.returnToCampUseOneHour);
}

//nter
private function feedShouldraACake():void {
	clearOutput();
	spriteSelect(67);
	outputText("You decide that there's no use getting cold feet now; you wanted to go the bakery anyway, no harm in letting Shouldra have some fun while you're there.  ");
	//after first time: 
	if (flags[kFLAGS.SHOULDRA_BAKERY_TIMES] > 0) outputText("Well, nothing <i>permanent</i>, anyway.  ");
	outputText("You press on, soon arriving at the ramp leading down into the bakery's interior.  It's as busy as ever, with patrons milling about, chatting between bites of pastry.");
	outputText("\n\nYou spy the pastry-woman Maddie working at the counter; seems she had to be pulled off baking duty for some reason.  As she glances around the room, your eyes meet, and she quickly looks away.  Is she...  blushing?  You didn't know she could do that.");
	outputText("\n\nShouldra is definitely getting antsy now, and you can feel her dragging your eyes towards the menu.  A sliver of drool slides down your chin.  You sigh and let the ghost girl head towards the service counter; hopefully both your wallet and your figure will remain reasonably intact.");
	//Maddie
	simpleChoices("Maddie", shouldraAndMaddieSittingInATree, "", null, "", null, "", null, "", null);
}

private function shouldraAndMaddieSittingInATree():void {
	clearOutput();
	spriteSelect(67);
	outputText("You soon reach the front of the queue and scour the menu.  Maddie is doing her best not to notice you, and is staring very intently at the ground.  You cough, causing her to jump.  \"<i>O-oh!  [name]!</i>\" She squeals, that weird cherry-red blush returning to her doughy face, \"<i>I, like, wasn't expecting you to come back after...  I mean, er...</i>\" The eclair girl stammers, pauses, then relaxes, her blush fading.  \"<i>Er, welcome to the Tel'Adre bakery, can I take your order?</i>\" Seems she's still embarrassed about last time.  You order something light to snack on, but the words have barely left your lips when a violent surge of spectral energy hits your mind.  Your face smirks in triumph as Shouldra takes control of your body, leaving you to watch helplessly.");
	outputText("\n\n\"<i>Actually, scratch that.  I'm starving all of a sudden.  Lemme see, how about...</i>\" The sneaky spook rattles off a huge list of foods, covering damn near the entire menu.  With each item ordered, your heart sinks a little lower, Maddie's eyes grow a little wider, and your gem pouch feels a little lighter.  Eventually Shouldra stops and grins expectantly, leaving an awkward silence hanging in the air.");
	outputText("\n\n\"<i>...Uh, right, 'kay.</i>\" Maddie quickly begins scribbling down the huge order.  \"<i>That'll be, um, hang on...</i>\" She furrows her spongy brow.  \"<i>Um, a lot of gems.  Sorry, I can't count higher than three digits.</i>\"  Ouch.  Shouldra doesn't seem too worried though.  \"<i>Oh, that's cool.  Just put it on my tab.</i>\" Before the jiggly girl can complain, your lips move in a silent chant, and a second later Maddie's face breaks out in a dumb grin.  \"<i>Oh yeah, your tab!  Sure, totally.  I'll be right back with your order, sugar!</i>\" She winks and disappears into the back room, only to return a few moments later.  \"<i>Um, actually this order might take a while.  Make yourself comfy and I'll be with you soon.</i>\"");
	outputText("\n\nYou...  well, <i>Shouldra</i> takes a seat in a booth near the back, and begins drumming her fingers impatiently on the wooden table.  A murmur from the patrons heralds the arrival of your order, and no wonder: despite her size, Maddie is visibly weighed down by the vast plates of donuts, cakes, and other sweet treats.  After a few close calls, she manages to reach your booth and lay them down, covering the entire table in a chocolatey smorgasbord.  As your eyes roam over the fattening feast, you can't help but cringe.  Or try to, anyway.  Shouldra instead licks her lips and thanks Maddie, who scoots back to her counter, before your hand reaches for a decadent slice of caramel torte.  This might not bode well for your ");
	if (player.tone >= 60) outputText("well-toned");
	else if (player.thickness < 50) outputText("trim");
	else outputText("curvaceous");
	outputText(" figure...");
	//[Go along with it] [Resist]
	simpleChoices("Go Along", goAlongWIthShouldrasEatingSpree, "Resist", resistBeingAFatass, "", null, "", null, "", null);
}
//Go along with it
private function goAlongWIthShouldrasEatingSpree():void {
	clearOutput();
	spriteSelect(67);
	//if repeat scene: 
	if (flags[kFLAGS.SHOULDRA_BAKERY_TIMES] > 0) outputText("\"Man, you're not sure you want that kind of impact on your figure again...  \"");
	outputText("Ah, what the hell.  You were hungry anyway.  You let Shouldra guide the cake into your mouth.  Mmm, not bad; rich, sweet and delicate.  Shouldra chuckles in your mind as she releases her control slightly, letting you lick your fingers clean of any stray crumbs.  \"<i>Well, guess you're pretty hungry yourself!  Alright, Champ, I'll give you some freedom, but just remember you're not the only one with an appetite.</i>\" You wince as your hunger intensifies to the verge of pain; looks like you're eating for two.  Your eyes lock on to the feast before you and something snaps in your mind.  You need this food, all of this food, inside you.  <i>Now</i>.");
	outputText("\n\nYou finish the torte, pausing only to scrape the platter clean and devour the crumbs before starting on some brownies.  As snack upon snack disappears down your maw, your stomach grows warm and full, feeling mildly bloated as the last brownie passes your lips.  \"<i>Ooh, is your poor lil' tummy feeling a bit full?</i>\" Shouldra snickers.  \"<i>Let's get it out of this cumbersome outfit.</i>\" An incantation echoes in your mind before your [armor] shimmers and vanishes.  Well, that was unexpected");
	if (flags[kFLAGS.PC_FETISH] > 0) outputText(", though not completely unwelcome");
	outputText(".  You blush furiously and back into the corner of the (now rather cold) booth");
	if (flags[kFLAGS.PC_FETISH] > 0) {
		outputText(" as your heart races and blood rushes down towards your ");
		if (player.hasCock()) {
			outputText("drowsy member");
			if (player.hasVagina()) outputText(" and ");
		}
		if (player.hasVagina()) outputText("trembling nether-lips");
		if (player.gender == 0) outputText("groin");
	}
	outputText(", before you realize that nobody seems to notice your predicament.  Shouldra reads your thoughts and responds, \"<i>Thought you might appreciate some privacy");
	if (flags[kFLAGS.PC_FETISH] > 0) outputText(", even with that kink of yours");
	outputText(", Champ.  Here's something extra anyway, just in case.</i>\" One ghostly incantation later, and ");
	if (player.femininity <= 50) outputText("a buttoned shirt and pair of belted jeans");
	else outputText("a tight-fitting tank top and skirt");
	outputText(" adorn your person.");
	
	if (player.hasCock()) {
		outputText("\n\nYou run a hand down your chest, examining the new material.  Silky smooth...  As your hand slides across your stomach, you press in slightly.  You've only made a small dent in the food before you, but there's already a noticeable bulge beneath your belt, and a few slivers of " + player.skinFurScales() + " are visible between the buttons.  You rub the modest mound, resulting in a subdued gurgling and a content burp; you've gotten full pretty quickly.  Maybe you should just leave the rest of the food and- \"<i>Not so fast, bucko!</i>\" Shouldra fumes, causing you to jump in your seat.  \"<i>You might be full, but <b>I've</b> barely started!</i>\" Your gut churns violently as the ghost girl's inhuman appetite infects your own.  Oh dear...");
		outputText("You quickly grab something, an eclair, from the table in an effort to ease the pain in your stomach.  The taste is incredible; you don't know if it's the hunger or Shouldra's magic, but this is easily the best eclair you've ever eaten.  You moan low in your throat as you savor the eclair, thick sweet cream exploding in your mouth, chilled chocolatey pastry caressing your tongue like a skilled lover.  Sugar and pastry mix and twirl around your mouth, and you can't help but close your eyes and relax, mind and body comforted by a glucose euphoria.");
		if (silly()) outputText("  This is a <i>fucking good eclair</i>.");
		outputText("\n\nCream-thick treats continue to be stuffed into your gullet, each equally as rich and blissful as the last.  The pastry payload is now making a sizeable bulge beneath your burgeoning belt, and the buttons around your navel are stretching by the second.  Tighter and tighter the hapless fastenings grow, until a large lump of cake sends one pinging haphazardly across the table.  An ethereal giggle burst out as Shouldra prods your exposed midriff.  \"<i>Whoops, guess I let you get a bit carried away there!</i>\" Her hand massages the bloated sphere, coaxing a few embarrassing burps from you.  \"<i>Still, if you're this far along, might as well go the whole hog.  Figuratively speaking.</i>\" Your stomach grumbles in agreement and you resume your pig-out with gusto.");
		outputText("\n\nAs bite after delectable bite passes your lips, you can't help losing yourself in a gluttonous haze.  So many flavors, so many textures, creamy, smooth, crumbly, doughy, mmm...");
		outputText("\n\nA slight bump against the bottom of your growing gut distracts you.  You reach around the strained dome to find your member is hard and rock-solid in your hand; seems the constant onslaught of food is getting to you.  \"<i>Oh dear,</i>\" Shouldra remarks as she stuffs another portion of fattening candy into your mouth, \"<i>Can't have you getting distracted, not when there's still so much food to go into your belly.  Hang on, I'll see what I can do about that.</i>\" A snap of your fingers later and Maddie is by your table with a bimbo grin.  \"<i>Hi!  Enjoying your meal?</i>\" She giggles and pats your taut stomach.  \"<i>Now, um, was there something you wanted, or...</i>\" There's a short pause before the cupcake girl's eyes glow that all-too-familiar yellow.  \"<i>Ooh, roomy!</i>\"  Shouldra runs her doughy hands over her new form, paying careful attention to Maddie's hefty breasts and plump well-rounded ass.");

		outputText("\n\n\"<i>Now, how about that delicious cock of yours?</i>\"  The possessed pastry licks her full lips and crouches down, barely fitting under the table.  ");
		if (player.cocks[0].cockLength < 8 || player.cocks[0].cockLength > 25) outputText("\"<i>First though, let's change it to something more manageable.</i>\" Arcane sounds float up towards you, causing your shaft to shift and morph until your throbbing rod is around 2 feet long and dripping pre.  \"<i>Mmm, much better!</i>\"  ");
		outputText("Her eyes close as those sumptuous icing-white lips wrap around the [cockHead] of your aching dick, the cherry tongue canvassing your cockflesh like an artist, until she slowly, oh-so-slowly gulps down inch after gradual inch of your girth.  Her enormous chocolate rump is visible on the other side of the booth, lulling back and forth in contented bliss.");
		outputText("\n\nYou struggle forward in your seat and resume grazing on a stack of donuts, though you are hindered somewhat by both the ghost girl's cock worship and your cramped stomach.");
		outputText("\n\nThe bloated orb has by now left your shirt in tatters and your jeans in disrepair; it rests between your thighs, your legs having been forced to part under its growing weight.  An ominous gurgle erupts from your overtaxed gut; perhaps you've overestimated yourself?  You massage the complaining flesh with one hand to ease the pressure while continuing to sate your insatiable appetite with the other, heavenly gouts of angel cake dropping into your abyss of a stomach.  Shouldra smiles around your cock as the churning and gurgling continues; her fucksucking lips slip off the tip of your rigid dick and ascend, trailing supersized kisses across your crotch and up to your navel.  She nuzzles your bloated belly like a pillow, her hands digging gently into the flesh and kneading with equal parts care and roughness.  Your free hand stops massaging and cradles her head, and in a moment of impishness you shove a slice of something gooey and triple-layered into her unsuspecting candied maw.  She swallows, surprise turning quickly to a grin of friendly vengeance.  \"<i>So that's how we're playing it, big guy?</i>\"  Shouldra snickers, before giving your sensitive stomach a hearty slap.");
		outputText("\n\nYou wince slightly before returning a sloppy food-filled grin... Wait.  You're not feeding yourself.  What the fuck?  The ghost girl answers your confusion with a profiterole that soars into your slack mouth.  Damned ghoul, that's just playing dirty!  You both devolve into a fierce stuffing contest; your desperate hands snag anything they can from the spread and cram them into the ghost's gullet, while waves of pastries ram themselves into your own defenseless mouth.  The combination of the adrenaline-fueled force-feeding frenzy and the increasing pressure of your swelling gut on your eager cock forms a familiar sensation; prickling loins, skipped heartbeats, an intense heat in your flushed cheeks.  As you feel the giddy euphoria of an oncoming food coma, Shouldra seizes the moment and dives onto your half-buried shaft, sliding and slipping down along every inch she can, teasing and tickling with her jellied tongue.");
		outputText("\n\nA guttural moan escapes your icing-caked lips as you sink into a creamy smooth orgasm, like sliding into a hot bath.  ");
		if (player.cumQ() < 200) outputText("Modest spurts of semen shoot out into Shouldra's awaiting mouth.  She withdraws, swirls it around her tongue, then swallows your load in one gulp.  \"<i>Hmm...  needs cinnamon,</i>\" she jokes, licking her lips.");
		//if (cumMedium = true)
		else if (player.cumQ() <= 400) outputText("Several thick spurts of semen shoot out into Shouldra's awaiting mouth.  She withdraws, swilling the sizeable load around her mouth before swallowing it in a few gulps.  \"<i>Not bad...  could use a dash of ginger though,</i>\" she jokes, licking her lips.");
		//if (cumHigh = true) 
		else if (player.cumQ() <= 1000) outputText("Your groin roils as a thick jet of pearly cum floods Shouldra's mouth, followed by another, then another.  The ghost girl barely has time to swallow each load before the next comes, but she manages not to spill a drop of your virility.  \"<i>Mmm, pretty tasty!</i>\"  She says after wiping her mouth in satisfaction.  \"<i>Hints of pineapple, coconut...  delicious.</i>\"");
		//if (cumVeryHigh = true)
		else if (player.cumQ() <= 5000) outputText("Your loins tremble and quiver as an immense load of cloying cum bulges along your shaft and explodes in Shouldra's mouth.  A further wave of bulges assault the ghost girl's throat, forcing her to swallow all of your thick virile spunk.  Eventually the wave subsides, leaving a satisfied and somewhat bloated spook in its wake.  \"<i>Soo gooood...</i>\" she drawls, her goofy grin smattered with white.");
		else outputText("A cock-distending wad of potent jizm works its way through your throbbing shaft, erupting from your urethra down the hapless ghost's gullet.  As bulge after obscene bulge forces itself inside Shouldra's stomach, her spongy abdomen balloons outwards, soon reaching the size of an adult human.  Streams of excess cum flow down her straining cheeks, and by the time you've stopped cumming the ghostly glutton is lying in a large sticky puddle of your spunk.  She tries to speak, but all that emerge are a sloppy belch and a few flecks of cum, and she resorts instead to hysterical giggling, lost in a cum-addled haze.");
		outputText("  After a moment of rest, Shouldra squeezes out from under the table[if (cumQuantity > 1000) , her soft belly sloshing audibly,] and helps you to your feet; a task made seriously annoying by your titanic tummy digging in to the edge of the counter.  The other patrons remain blissfully unaware of the whole act, including your current nudity.  Speaking of which...");
		outputText("\n\n\"<i>Oh, don't worry, Champ,</i>\" Shouldra says, having returned to your head, \"<i>No permanent damage intended. Here ya go!</i>\"  You feel slightly woozy as your abdomen collapses inwards, soon returning to its original, non-bloated state.  A moment later and you are once again clad in your [armor].  \"<i>Well, enough shenanigans for now, right?  Though you do look pretty cute with a pot belly... Heh, just teasing,</i>\" laughs the ghost, \"<i>Now c'mon, let's blow this joint!</i>\"");
		outputText("\n\nYou leave the bakery and head back to camp, leaving behind a very confused Maddie.");
		player.orgasm();
		doNext(camp.returnToCampUseOneHour);
	}
	//[(if hasCock = false) 
	else {
		outputText("\n\nYou run a hand down your chest, examining the new material.  Silky smooth...  As your hand slides across your stomach, you press in slightly.  You've only made a small dent in the food before you, but there's already a noticeable bulge beneath the hem of your skirt, and a few inches of soft " + player.skinTone + " skin are visible beneath the top.  You rub the modest mound, resulting in a subdued gurgling and a content burp; you've gotten full pretty quickly.  Maybe you should just leave the rest of the food and- \"<i>Not so fast, bucko!</i>\"  Shouldra fumes, causing you to jump in your seat.  \"<i>You might be full, but </i>I've<i> barely started!</i>\"  Your gut churns violently as the ghost girl's inhuman appetite infects your own.  Oh dear...");
		outputText("\n\nYou quickly grab something, an eclair, from the table in an effort to ease the pain in your stomach.  The taste is incredible; you don't know if it's the hunger or Shouldra's magic, but this is easily the best eclair you've ever eaten.  You moan low in your throat as you savor the eclair, thick sweet cream exploding in your mouth, chilled chocolatey pastry caressing your tongue like a skilled lover.  Sugar and pastry mix and twirl around your mouth, and you can't help but close your eyes and relax, mind and body comforted by a glucose euphoria.");
		if (silly()) outputText("  This is a <i>fucking good eclair</i>.");
		outputText("\n\nCream-thick treats continue to be stuffed into your gullet, each equally as rich and blissful as the last.  The pastry payload is now making a sizeable bulge beneath your burgeoning top, and the hem of your skirt is stretching by the second.  Tighter and tighter the garment grows, until a large lump of cake rips the stitching along your thigh.  An ethereal giggle burst out as Shouldra prods your exposed midriff.  \"<i>Whoops, guess I let you get a bit carried away there!</i>\"  Her hand massages the bloated sphere, coaxing a few embarrassing burps from you.  \"<i>Still, if you're this far along, might as well go the whole hog.  Figuratively speaking.</i>\"  Your stomach grumbles in agreement and you resume your pig-out with gusto.");
		outputText("\n\nAs bite after delectable bite passes your lips, you can't help losing yourself in a gluttonous haze.  So many flavors, so many textures, creamy, smooth, crumbly, doughy, mmm...");
		outputText("\n\nA slight moistness beneath the bottom of your growing gut distracts you.  You reach around the strained dome to find your pussy is soaking against your hand; seems the constant onslaught of food is getting to you.  \"<i>Oh dear,</i>\" Shouldra remarks as she stuffs another portion of fattening candy into your mouth, \"<i>Can't have you getting distracted, not when there's still so much food to go into your belly.  Hang on, I'll see what I can do about that.</i>\"  A snap of your fingers later and Maddie is by your table with a bimbo grin.  \"<i>Hi!  Enjoying your meal?</i>\"  She giggles and pats your taut stomach.  \"<i>Now, um, was there something you wanted, or...</i>\" There's a short pause before the cupcake girl's eyes glow that all-too-familiar yellow.  \"<i>Ooh, roomy!</i>\" Shouldra runs her doughy hands over her new form, paying careful attention to Maddie's hefty breasts and plump well-rounded ass.");
		outputText("\n\n\"<i>Now, how about that delicious cunt of yours?</i>\"  The possessed pastry licks her full lips and crouches down, barely fitting under the table.  Your panties are pulled aside by her teeth as her warm breath teases your trembling slit.  Her glowing eyes close as those sumptuous icing-white lips kiss the soft folds of your nether-lips, the cherry tongue dancing and twirling around your [clit] like an artist, until she slowly, oh-so-slowly slips inch after inch of slick tonguemeat inside you.  Her enormous chocolate rump is visible on the other side of the booth, lulling back and forth in contented bliss.");
		outputText("\n\nYou struggle forward in your seat and resume grazing on a stack of donuts, though you are hindered somewhat by both the ghost girl's pussy worship and your cramped stomach.  The bloated orb has by now pushed your shirt up around your [fullChest] and left your skirt in tatters; it rests between your thighs, your legs having been forced to part under its growing weight.  An ominous gurgle erupts from your overtaxed gut; perhaps you've overestimated yourself?  You massage the complaining flesh with one hand to ease the pressure while continuing to sate your insatiable appetite with the other, heavenly gouts of angel cake dropping into your abyss of a stomach.  Shouldra smiles as the churning and gurgling continues; her fucksucking lips slip off your drooling pussy-flesh and ascend, trailing supersized kisses across your crotch and up to your navel.  She nuzzles your bloated belly like a pillow, her hands digging gently into the flesh and kneading with equal parts care and roughness.  Your free hand stops massaging and cradles her head, and in a moment of impishness you shove a slice of something gooey and triple-layered into her unsuspecting candied maw.  She swallows, surprise turning quickly to a grin of friendly vengeance.  \"<i>So that's how we're playing it, big girl?</i>\"  Shouldra snickers, before giving your sensitive stomach a hearty slap.");
		outputText("\n\nYou wince slightly before returning a sloppy food-filled grin...  Wait.  You're not feeding yourself.  What the fuck?  The ghost girl answers your confusion with a profiterole that soars into your slack mouth.  Damned ghoul, that's just playing dirty!  You both devolve into a fierce stuffing contest; your desperate hands snag anything they can from the spread and cram them into the ghost's gullet, while waves of pastries ram themselves into your own defenseless mouth.  The combination of the adrenaline-fueled force-feeding frenzy and the increasing pressure of your swelling gut on your button forms a familiar sensation; prickling loins, skipped heartbeats, an intense heat in your flushed cheeks.  As you feel the giddy euphoria of an oncoming food coma, Shouldra seizes the moment and dives down into your crotch, lapping and licking every oh-so-sensitive inch she can, teasing and tickling, probing your wet cunt with her jellied tongue.");
		outputText("\n\nA guttural moan escapes your icing-caked lips as you sink into a creamy smooth orgasm, like sliding into a hot bath.  [if (isSquiter = true) \"Hot streams of liquid lust spurt across Maddie's face, drizzling her with your copious fem-spunk.  \"][if (isLactating = true) \"Droplets of milk form on your [nipples], soon forming rivers of cream that cascade down your fiery-hot flesh.  \"]After a moment of rest, Shouldra squeezes out from under the table, licking your girl-cum from her lips with a satisfied slurp, and helps you to your feet; a task made seriously annoying by your titanic tummy digging in to the edge of the counter.  The other patrons remain blissfully unaware of the whole act, including your current nudity. Speaking of which...");
		outputText("\n\n\"<i>Oh, don't worry, Champ,</i>\" Shouldra says, having returned to your head, \"<i>No permanent damage intended.  Here ya go!</i>\"  You feel slightly woozy as your abdomen collapses inwards, soon returning to its original, non-bloated state.  A moment later and you are once again clad in your [armor].  \"<i>Well, enough shenanigans for now, right?  Though you do look pretty cute with a pot belly...  Heh, just teasing,</i>\" laughs the ghost, \"<i>Now c'mon, let's blow this joint!");
		outputText("\n\nYou leave the bakery and head back to camp, leaving behind a very confused Maddie.");
		player.orgasm();
		doNext(camp.returnToCampUseOneHour);
	}
	flags[kFLAGS.SHOULDRA_BAKERY_TIMES]++;
	player.slimeFeed();
}


//Resist
private function resistBeingAFatass():void {
	clearOutput();
	spriteSelect(67);
	outputText("You quickly warn Shouldra that if you so much as feel a pound heavier, there'll be hell to pay.  The hand stops, then falls to the table in defeat.  \"<i>Okay, okay,</i>\" the spook mutters.  \"<i>But you know, there's still all of this food here...  Say,</i>\" she says, an impish grin spreading across your features, \"<i>You wanna keep your figure?  That's fine.</i>\" Your eyes scour the crowded tables, settling on a lonely girl in the corner, who is busy staring at her cookie and looking mournful.  \"<i>So let's let someone else suffer the consequences!</i>\" She cackles mentally as your mouth moves with ritual intonations.");
	outputText("\n\nSomething shifts in your stomach.  You feel empty; not hungrier, just...  vacant inside.  Your eyes are glued to the platter before you as Shouldra lifts a brownie to your lips and chews.  The flavor is exquisite, rich and delicate, warm and inviting.  You finish chewing and swallow.  Strange...  you don't feel any fuller.  As Shouldra finishes off the rest of the brownie and starts on another, you notice that the food doesn't seem to end up in your stomach; it just vanishes somewhere in your gullet.  The ghost girl finishes the brownie platter, and your eyes drift back to the cookie girl while she wipes your lips.  She's still eyeing the biscuit idly, but one hand has drifted down beneath the table and is resting on her stomach.  Ah.");
	outputText("\n\nShouldra catches on to your realization and smirks, before shoveling a donut into your mouth.  As another plate of desserts disappears down your throat, the girl's expression turns from bored to puzzled as her tummy puffs out ever so slightly.  Your possessed body grabs a tray of cream-filled eclairs and chows down relentlessly, filling the hapless girl with even more fattening food.  She doesn't seem to know what to do as her belly plumps and expands under her hand.  \"<i>Hmm, that won't do,</i>\" murmurs Shouldra after finishing the last eclair, and she chants another spell.  \"<i>There we go; a brand new fetish, courtesy of yours truly!  Now, where was I?</i>\"");
	outputText("\n\nSure enough, the girl's reactions are changing; rather than disgust and alarm, she's now investigating her newly-gained girth with timid curiosity.  A furious blush permeates her face as she quickly looks around before slipping a tentative hand underneath her waistband.  She visibly gasps as her hands busy themselves with her body, one massaging her abdomen, the other gently working on her crotch.  Noticing the cookie is still on her plate, she snatches it up and devours it in one bite.  She traces a finger from her lips, down along her throat as she swallows, and between her sweater-clad breasts, finally resting on her tummy.  Her other hand speeds up, spurring a whimper from her lips as she jills herself off, any hesitance or shame vanished.");
	outputText("\n\nMaddie seems to have noticed the commotion and is pacing towards the girl's table, her assets jiggling with each step.  \"<i>Oh fuck,</i>\" cries Shouldra, \"<i>that bubbleheaded bitch is gonna ruin... actually,</i>\" ponders the ghost, \"<i>this could be fun.  Okay, change of plans, Champ!  You just lie back and enjoy the show, 'kay?  Shouldra's gonna get her ghost on!</i>\"  With that, a burst of blue sparks signals her departure, whizzing towards the unsuspecting pastry golem.  The sparks sink into her doughy flesh, and a familiar yellow glow flickers in her eyes.  Shouldra advances towards the girl, grinning widely as she quickly examines her new hyper-voluptuous form.  Reaching the table, she gives a polite cough, jolting her prey out of her self-loving reverie with a sharp squeak.  Shouldra smiles innocently as the girl tries (and fails) to compose herself, pulling her jumper down over her spherical gut.");
	outputText("\n\n\"<i>Hello, miss!</i>\"  Shouldra says while the girl continues to fidget, \"<i>Would you be interested in sampling our new All-You-Can-Eat course?</i>\"  The girl looks up sharply; seems the ghost knows just which buttons to push.");
	outputText("\n\n\"<i>A... All-You-Can-Eat?</i>\"");
	outputText("\n\n\"<i>Oh yes, miss!  It's exactly what it sounds like.  We haven't released it officially, but we're offering a free trial run to some of our more... dedicated customers.</i>\"  The girl blushes extra-hard.");
	if (silly()) outputText("  \"<i>D... dedicated customers?</i>\"\n\nShouldra sighs, \"<i>Knock that shit off kid, it ain't cute.  You want the course or not?</i>\"");
	outputText("\n\n\"<i>Oh, well, er, okay,</i>\" she stammers.  The possessed pastry beams and leads her towards your table.  The mousy girl's eyes are drawn to the feast laid out upon the counter; she bites her lower lip in anticipation.  As Shouldra seats her down opposite you, however, she can't help but stare at you timidly.  \"<i>Just our chef, dear,</i>\" the ghost girl assures her, \"<i>" + player.mf("he","she") + " just wants to make sure you enjoy " + player.mf("his","her") + " food.  Now, dig in!</i>\"");
	outputText("\n\nThe shy girl fidgets for a bit, glancing between you and the 'All-You-Can-Eat course', before picking up a sugar-laden donut and taking a few tentative nibbles.  The nibbles turn into full-blown bites as she becomes focused on sating her food-lust, swallowing larger and larger chunks of baked goods down into her eager stomach.");
	outputText("\n\nShouldra sits down next to the gluttonous girl, her super-stacked body barely fitting behind the table, and begins chanting something arcane and foreign.  A crimson aura shimmers around the facestuffing girl, eliciting a muffled moan and a brief tension.  Imbued with the ghost mage's lust magic, she doesn't notice a pair of spongy hands sliding under her jumper.  Even as the cake woman slowly undresses her, leaving her with nought but a bra and panties, the girl is focused entirely on chewing and swallowing mouthful after mouthful of fattening food.  Shouldra burrows an arced hand down under the hem of her underwear, while using the other to grope and massage her exposed belly.  It's quite a sight; the girl alternating between eating, burping, and moaning lewdly, while the buxom bombshell next to her plants kisses and lovebites on her nape, her hands tending lovingly to both her tummy and her sex.  A schlicking sound intersperses the girl's other noises, as a pool of fem-spunk appears between her creamy thighs.");
	outputText("\n\n\"<i>Oh... oh gods...</i>\" gasps the girl as she's overwhelmed by the heady hedonism of her gluttonous lust, so sweet, so sinful.  Shouldra responds by taking a bite of eclair and kissing her deeply, swapping the cream between their tongues.  The bra gets lost in a flurry of touching, and the oversexed specter toys with a budding nipple between thumb and forefinger as the kissing continues relentlessly.  The table shrinks slightly, giving the ghost more room to perform.  Eventually Shouldra pulls away, placing a hand on the lust-addled girl's gurgling abdomen.  \"<i>Mmm, so full, so fat...</i>\" Suddenly she grabs the rest of the eclair and stuffs it into her partner's accepting mouth.  \"<i>I want you bigger, want you </i>fatter<i>.  Can you do that for me, babe?  Can you get big and fat for me?</i>\"  The girl nods dazedly.  Your ghostly companion has picked up a few odd kinks over the years, it seems.");
	outputText("\n\nShouldra feeds treat after fattening treat to the naked girl, praising her vast tummy with tender caresses whilst grinding her own titanic tits against her partner.  As she finishes off a slice of lemon meringue pie, the girl moans loudly; a chorus of groans emanate from her roiling gut, followed by an almighty belch.  She winces and gingerly rubs the churning orb, which by now is roughly the size of a basketball.  \"<i>I think - urp - I think I'm full now,</i>\" she whimpers, a burp escaping her lips as her overworked stomach tries to relieve some pressure.");
	outputText("\n\n\"<i>Full?  Don't be silly, you've got plenty of room still in there!</i>\"  Shouldra grabs the fleshy dome and jiggles it.  \"<i>It wouldn't be an 'All-You-Can-Eat' course if you didn't eat as much as you possibly could, now, would it?</i>\"  Before the beleaguered girl can complain, her mouth is filled with a fat nozzle-like teat.  Shouldra's eyes flicker dangerously as she presses the girl into her tit; you could swear that the chocolatey knockers are growing before your eyes, soon threatening to drown the overstuffed girl in breastflesh.  \"<i>Listen, bitch.  You promised to make yourself as big and fat for me as possible, so now you're gonna fulfill it.  Now drink up.</i>\"");
	outputText("\n\nYou hear a squirting sound as Shouldra milks her massive udder into the hapless girl's gullet, forcing her cheeks to bulge and her throat to swallow huge mouthfuls of liquidy icing.  The feedee's throat bulges with each load of thick frosting, and her already strained stomach bloats out further to accommodate the calorie-laden onslaught.  Her feeder coos approvingly.  \"<i>Mmm, I just love filling skinny little girls like you.  Fattening you up until you can't take any more is such a turn-on.  Don't you worry now, soon this tiny body of yours will be so much sexier,</i>\" the ghost giggles.  \"<i>In fact...</i>\" Shouldra rattles off a quick spell.  Instantly, the girl's belly growls noisily, trembling and sloshing, before it starts slowly shrinking.  Wait, not just shrinking; the skin becomes less taut and a small roll develops as the food is converted with unnatural speed into belly pudge.  Her breasts grow slightly, though they remain perky and small by Marethian standards; her butt, however, thickens and rounds out into a gropable bubble-butt, while her panty strings are swallowed up by her newly fattened thighs.  The lusty ghost examines her prey's new pear shape mercilessly, grabbing rolls and pinching inches.  \"<i>Hmm, not bad!  Cute lil' tits, thick thighs, a big ol' badonkadonk and an adorable pot belly.</i>\"  She gives the gut a hearty jiggle, sending small ripples across the plump girls' naked flesh.");
	outputText("\n\n\"<i>Okay, tell ya what,</i>\" says Shouldra, \"<i>I'm feeling generous, so I'll let you go if you can answer one simple question.</i>\"  She leans down, cupping the girl's chin and turning her head to face her own.  \"<i>Do you love it?</i>\"  Her voice lowers to a throaty whisper.  \"<i>Do you love being a plump slut?  Does your pussy ache for attention just as much as your greedy stomach aches for food?  Would you suck off every guy in the bakery just for one... more... bite?</i>\"  Wow, she's really getting into this.");
	outputText("\n\nThe bedraggled girl mouths something inaudible.  \"<i>What was that?  You gonna speak up, or am I gonna have to shut you up with this?</i>\"  Shouldra asks, brandishing a bloated tit menacingly.");
	outputText("\n\n\"<i>YES!</i>\"  yells the helpless feedee, \"<i>Y-yes, I love it.  I love being a fat slut for you, I want to eat and eat and make you happy.</i>\"  The ghost girl stares into her eyes for a moment, before grinning and planting a wet kiss on her lips.");
	outputText("\n\n\"<i>Good answer babe.  Now get dressed and hurry home before I change my mind.</i>\"  The girl hastily grabs her clothes and dresses herself.  It's quite a challenge, but after some frantic struggling she's reasonably covered up; her jeans are unbuttoned and visibly straining at the seams, while her once-baggy sweater now hugs tightly against her marshmallowy tummy.  The girl then hurries away, glancing back with an odd expression - relief? - before slipping out onto the streets of Tel'Adre.");
	outputText("\n\nYou suddenly realize that throughout the debauched encounter, none of the other patrons so much as glanced your way.  Must be magic, you think to yourself.  \"<i>Yup, wonderful, wonderful magic,</i>\" says Shouldra; seems she's returned to your head.  \"<i>Well, I've had my fun, Champ.  Let's blow this popsicle stand!</i>\"  You head out of the bakery and return to camp, leaving behind a very confused Maddie.");
	dynStats("lus", 30);
	doNext(camp.returnToCampUseOneHour);
}
}
}
