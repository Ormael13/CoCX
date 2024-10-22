/**
 * ...
 * @author Liadri and other ppl who scenes gets here
 */
package classes.Scenes.Camp 
{
	import classes.*;
	import classes.BodyParts.Skin;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Consumable;
import classes.display.SpriteDb;
	
	public class UniqueCampScenes extends BaseContent
	{
		
		public function UniqueCampScenes() 
		{	//flags[kFLAGS.ALRAUNE_GROWING] == 15 - 2 weeks old children
		}	//flags[kFLAGS.ALRAUNE_GROWING] == 22 - 3 weeks old children

public function manageyourgarden():void
{
	clearOutput();
	outputText("Your daughters are busy bickering. Who is the most beautiful flower of them all? You don't think they'll ever agree.\n\n");
	menu();
	if (flags[kFLAGS.ALRAUNE_GROWING] > 14) addButton(0, "Play", playwithyourplantdaughters);
	if (flags[kFLAGS.ALRAUNE_DAILY_WATERING] < 1) addButton(9, "Water", wateryourgarden);
	addButton(14, "Back", inventory.stash);
}

public function wateryourgarden():void
{
	clearOutput();
	outputText("You water your sprouts and then spend some time tending to the garden. Weeding, pruning, and fertilizing, you do it all. Nothing will harm your private garden.\n\n");
	flags[kFLAGS.ALRAUNE_DAILY_WATERING] = 1;
	if (flags[kFLAGS.ALRAUNE_GROWING] < 22) flags[kFLAGS.ALRAUNE_GROWING]++;
	doNext(camp.returnToCampUseOneHour);
}

public function playwithyourplantdaughters():void
{
	clearOutput();
	outputText("You decide to set some time aside to play with your sprouts. You tell them as much, and with a flourish, you pull water toys you bought in Tel'Adre out of your pack. The happiness on their little faces warms your heart.\n\n");
	outputText("\"<i>Wow, really mom? You're the best!</i>\"\n\n");
	outputText("Your daughters all cheer up as they pick up the toys and rush to the rivers to fill them up. Soon you’re all splashing each other. The experience is refreshing and soothing. You never thought you would appreciate having children this much. Perhaps parenting comes included in the whole \"being a child of a fertility goddess\" deal, you ponder, before being splashed in the face by one of your daughters, breaking you out of your reverie, and dragging you back into the game.\n\n");
	doNext(camp.returnToCampUseOneHour);
}

public function playsRathazulAndSoulgemScene():void
{
	clearOutput();
	spriteSelect(SpriteDb.s_rathazul);
	outputText("As you pass by, Rathazul considers you and then asks \"<i>May I ask what you’re planning to do with that soul gem of yours?</i>\" as you look at the elder in surprise, he shakes his head at you.  <i> \" Yes, [name], I know what that dangerous crystal is</i>\"\n\n");
	outputText("When you mention you want to create a golem, Rathazul seems to lose himself in thought, as if trying to remember something.\n\n");
	outputText("\"<i>Years ago, when I was younger, I knew a woman who specialized in such constructs. She was obsessed with creating the perfect servant. However, when the demons came, hungry for power, she embraced them instead of fleeing and became one of those aberrations. Her laboratory is likely still located in the same area as before - hidden somewhere in the place now called the blighted ridges. If you go there, be careful. ");
	outputText("Losing her humanity likely didn't do any good to her already fragile sanity. None can say what you will find.</i>\"\n\n");
	outputText("You thank Rathazul for telling you this as this might just be the information you need.");
	flags[kFLAGS.DEN_OF_DESIRE_QUEST] = 1;
	doNext(camp.returnToCampUseOneHour);
}

public function droppingToZeroSatietyAsGargoyle():void
{
	clearOutput();
	if (player.hasPerk(PerkLib.GargoylePure)) {
		outputText("Unable to sustain your movement any longer, you slow to a stop. Despite your best efforts, you shut down. You open your eyes, looking up at the sky to judge the time. You've been asleep for eight hours. At least now, you've absorbed enough energy to regain movement.\n\n");
		doNext(camp.returnToCampUseEightHours);
	}
	else {
		outputText("Your reserves are running low, and your body begins to shake. You are unable to control yourself; you need sex, NOW!\n\n");
		if (player.hasVagina()) {
			outputText("You rush into the mountain starved for energy and seduce the first minotaur you can find putting your drooling pussy on display. The minotaur, used to having to fight for a hole to fuck, does not complain and lies down for you to take him in.  Your eyes zero in as a dollop of pre escapes his ribbed horse-like member, locating the source of the scent.\n\n");
			//Too small
			if(player.vaginalCapacity() < monster.cockArea(0)) {
				outputText("Restraint evaporates as you lower yourself, your aching " + vaginaDescript(0) + " desperate for contact.  Your thighs quiver as you touch his wobbling column of maleness, the slick pre-cum soaking into your engorged clitty, filling it with tingling warmth.  Oblivious to the apparent size difference, your body pushes downwards, your knees giving out, forcing his flared head against your " + vaginaDescript(0) + " roughly.  The need to be speared on the beast's meat is overwhelming, urged on by the constantly leaking pre-cum currently pumping into your love-canal.  With strength born of unnatural lust, you grip his flanks and drive yourself downwards, feeling yourself stretch painfully as you take in his length.  ");
			}
			//Good match
			if(player.vaginalCapacity() >= monster.cockArea(0) && player.vaginalCapacity() < monster.cockArea(0) * 1.5) {
				outputText("Restraint evaporates as you lower yourself, your aching " + vaginaDescript(0) + " desperate for contact.  Your thighs quiver as you touch his wobbling column of maleness, the slick pre-cum soaking into your engorged clitty, filling it with tingling warmth.  You push downwards eagerly, happily noting that you should be able to accommodate his length and girth.  The overly wide head slips inside, easily lubricated with his copious fluids, musky pre-spunk lubricating your passage with its intoxicating sensation.  With deliberate slowness, you sink down along his shaft, shuddering once, twice, then three times as you pass each of the thick fleshy rings along his length.  Eventually, you bottom on him.  ");
			}
			//Bigger than he is
			if(player.vaginalCapacity() >= monster.cockArea(0) *1.5) {
				outputText("Restraint evaporates as you lower yourself, your aching " + vaginaDescript(0) + " desperate for contact.  Your thighs quiver as you touch his wobbling column of maleness, the slick pre-cum soaking into your engorged clitty, filling it with tingling warmth.  With a lusty giggle you slip his head inside your " + vaginaDescript(0) + ", allowing him to drool his musky pre-seed deep inside your wide love-canal.  Sinking down slowly, you easily encompass all of his equine-like member, enjoying the feeling of his three thick cock-ridges as they slip through your lips.  Eventually you take all of him, wishing he was just a little bit bigger...");
			}
			//Resume sexings, p2
			outputText("\n\nAt last you feel the minotaur's meaty hands grab you by the " + hipDescript() + ", forcefully grinding up and down his length like a cheap sex-toy.  ");
			//Size variants
			//Too small
			if(player.vaginalCapacity() < monster.cockArea(0)) outputText("Every ridge of his [monster cockshort] presses tightly against your walls, smearing more of his wondrous pre-seed into your body with every stroke.  ");
			//Just right
			if(player.vaginalCapacity() >= monster.cockArea(0) && player.vaginalCapacity() * 1.5 < monster.cockArea(0)) outputText("Every stroke of his [monster cockshort] deposits a bit more of his wondrous preseed into your body, spreading a relaxing warmth throughout your groin.  ");
			//Too big
			if(player.vaginalCapacity() *1.5 >= monster.cockArea(0)) outputText("Every stroke of his [monster cockshort] slides easily into your " + vaginaDescript(0) + ", allowing him to slowly build up a puddle of his wondrous druggy pre-seed into your aching womb.  ");
			//Resume!
			outputText("The minotaur picks up the pace, heartbeat thudding through his rigid meat, making it convulse and vibrate as he slams you down on it over and over again.  You feel his balls twitching against your ass as his cock visibly thickens, bulging out at the base and slowly fattening inside you until it feels fit to burst.  With a throaty roar he cums at last, fountaining seed directly into your womb.  Your eyes roll back as it fills you, swooning as you feel the liquid pleasure seeping into you.  Your " + vaginaDescript(0) + " clamps down, trapping his seed inside, his orgasm dragging on as his balls begin to shrink.  The copious fluid fills your womb, distending your belly painfully.  The minotaur gives one last powerful spurt, the force pushing you off his [monster cockshort], just as you both reach total sexual satisfaction.\n\n");
			//ITS OVER
			outputText("He passes out with a contented sigh, balls shrunk down to the size of baseballs and his cock still dribbling cum.  You pull yourself to your feet unsteadily, drunk with pleasure as you stagger away, clamping your " + vaginaDescript(0) + " down unconsciously to hold in his wonderful seed.");
			if(player.vaginalCapacity() < monster.cockArea(0)) outputText("\n\nMixed with the sheer sexual pleasure, you feel a diffuse pain and numbness coming from your much-abused " + vaginaDescript(0) + ", but decide with a smile that it was well worth it as his cum numbs away the last of the pain.");
			player.orgasm();
			dynStats("spe", -.5, "int", -.5, "sen", 1.5, "cor", 1);
		}
		else {
			outputText("You rush into the forest, starved for energy and forcefully grab the first goblin you can find. You pin her down, wiping your rock hard cock against her face. The goblin, getting the idea that you're pretty much ready to kill to get laid, decides against resisting.\n\n");
			var x:Number = player.cockThatFits(monster.vaginalCapacity());
			outputText(images.showImage("goblin-win-male-goblinboners"));
			outputText("You begin to fondle your cock as you walk towards the unsuspecting goblin girl, taking in the sight of her perfectly round cheeks as they jiggle against her hurried movements, her soft thighs clenched against the eager hand between them.  Bending down, you quickly grab the goblin's ample hips, causing the girl to squeak in surprise as she turns around to catch the sight of your erect length.\n\n");
			outputText("\"<i>W-woah!  Hey stud, whaddya think you're doing back there?</i>\" she yelps, more surprised than scared at your sudden appearance.  Instead of answering, you decide to grab your cock and slap it against the bare flesh of her ass, whilst your victim anxiously awaits your next move.  You take your time massaging the goblin's slutty ass with your bare hands before sliding your " + cockDescript(x) + " in between her soft cheeks.  ");
			outputText("Your horny victim appears impatient, attempting to grind against you as she spreads her moist lips open, enthusiastic that she's found someone willing to mate with her.  You slap her ass firmly as you quicken your thrusting - seconds before finally plunging your dick inside of the panting whore, pushing her forwards violently as you enter her tight snatch.\n\n");
			outputText("You roughly pound against the goblin girl, maintaining a firm grip on her hips while she squeals with delight.  The sound of your groin slapping against her echoes throughout the area, followed by your grunting and the goblin's moans of ecstasy.  Your victim struggles to lift herself up by her arms, only to collapse back down from the feeling of you invading her insides.\n\n");
			outputText("Eventually you begin to feel yourself coming to a climax, your movements getting faster and faster as you build up to your release.  The goblin below you has already lost herself to the pleasure of your " + cockDescript(x) + ", her eyes rolled upwards and her tongue drooling out of her mouth while her slutty face rubs against the ground you're currently pounding her on.  With a final thrust, your hips lurch forward as you paint her insides with your thick spunk, ");
			outputText("relishing in the feeling of your ejaculate filling her up to the brim and plugging her entrance.  You slowly release yourself from her tight body, finishing off by covering her curved back and pert rump with the rest of your seed.\n\n");
			outputText("You pick yourself back up, jerking yourself slowly as cum dribbles from your " + cockDescript(x) + " onto the collapsed body of the goblin.  It'll be awhile before she comes back to consciousness, but you're certain she'll have a better appreciation for sex when she does.");
		}
		player.refillGargoyleHunger(30);
		doNext(camp.returnToCampUseOneHour);
	}
}

public function badendManticoreOuroboros():void {
	clearOutput();
	outputText("You eye your penis, then your tail pussy, then back at your penis. The smell of precum dripping from your maleness...You shouldn't...Should you?");
	outputText("\n\n Without thinking any further you curl your tail between your legs and plug it to your own twitching cock. The pleasure is instantaneous as you instinctively sting yourself, [cock] twitching as you unleash a deluge of cum into your tail. Your [legs] spasm, making you fall to the ground hard. You try to pull yourself off, but your arms aren't responding, your eyes rolling back as the pleasure overwhelms your mind. Your thoughts fade away, replaced by the need. The endless thirst and satiation, cumming and feeding. You let out a worldess moan, your own fluids fueling you with the endless supply of stamina needed to never stop cumming.");
	outputText("\n\n Even if you tried to stop now, you wouldn't be able to. Your will is nonexistent, your own body betraying you. Your tail instinctively tries to milk your dick to a last drop that will never come. Unable to form coherent thoughts anymore, you become a creature of pure basest instinct. Months and years will pass before ultimately you die of old age... Not that you know, or care, having long lost the ability to process rational thought.");
	EventParser.gameOver();
}

public function hellhoundCapture():void {
	clearOutput();
	outputText("You wake up, your [hands] and [feet] bound by metal chains. You glance around warily as you shake yourself from the unconscious stupor; it seems like you're trapped in a holding pen. You notice a succubus several feet away from you, blocked off by a large glass observation window. She's jotting down notes on a piece of parchment before slowly approaching you like you're stirred awake.[pg]");
	outputText("She stands right next to the window, glowering at you intently, \"<i>So, you're the so-called 'champion' who ruined our factory?</i>\" She scoffs, \"<i>You don't look like much of a threat. I suppose those workers were simply slacking off.</i>\" She shakes her head softly, \"<i>You may call me Minuvi</i>\"[pg]");
	outputText("She gives a small laugh, pressing her fingertips to her full lips before speaking, \"<i>Since you've caused so much trouble, I think perhaps we should have you... let's say pay for it in a very special way.</i>\"[pg]");
	outputText("You glare at her questioningly as she chuckles once more, \"<i>Don't be silly, fucking the experiments is so beneath me. Not to mention dirty... I suppose some of my less-than-stellar colleagues aren't against such a concept.</i>\"[pg]");
	outputText("She sashays to your right as you keep your eyes on her. She stops at a cell containing a pair of hellhounds. They sit up eagerly, their red eyes bulging in excitement.[pg]");
	outputText("\"<i>See those two in the cell next to you? They should have been on duty, right beside the front desk. Had they not been slacking, they would've been at your throat the moment you walked in. You are a threat and could've taken down many workers here.</i>\"\n[pg]");
	outputText("She shifts her scornful gaze back to the hounds as she snaps at them, \"<i>Good guard dogs are meant to guard, not to fuck during their shifts.</i>\"[pg]");
	outputText("The hellhounds whine at her anger, and she puts a serene smile on her face...but the anger in her eyes remains, pointed squarely at you.[pg]");
	outputText("Minuvi's tone causes the hellhounds to whimper and shake in fear. She masks her face behind a serene smile. You are nearly attacked from the unfiltered scorn in her eyes as she fixates her glower upon you.[pg]");
	outputText("\"<i>Thankfully, you lack a proper sense of subtlety. I mean, the portal you came through is the first place we'd look. Staying there after all this time? Is that bravery to you? Determination? Oh, little dog... That's just idiocy.</i>”[pg]");
	outputText("Your captor rests upon her chair, her demonic tail slowly whipping around as she picks up her note-filled parchments. \"<i>With a little planning, capturing you was only a matter of time... Even the most vigilant of guard dogs must rest, after all.</i>\" She gives another chuckle as she lifts a finger to her lips, you can tell she's enjoying herself. \"<i>I know that you were a human once, quite rare to see those around here, though. Yet, of all the wonders in this land, you've decided to become a dog.</i>\"[pg]");
	outputText("She stands again, striding back to the cell holding the hellhounds. The eager hounds nearly leap up in excitement to meet her. They're just as happy to see her as if she had never scolded them. She gives them a small smile as she pets the tip of their noses.[pg]");
	outputText("She turns her gaze back to you, \"<i>How fortunate for me, right? My pets here could use a fresh bitch.</i>\"[pg]");
	outputText("The two hellhounds follow her gaze toward you. One barks ravenously as the other slams his paws against the fence keeping you separated. The demoness presses a button, causing your chains to loosen slightly. You remain tense as a gnawing dread grows within your stomach.[pg]");
	outputText("You notice the hellhounds are already fully erect, knots throbbing in anticipation.[pg]");
	outputText("You instinctively try to pull away, but the chains keep you tightly bound to the area. Your legs are shaking as you keep trying to pull away. Your tail stands up on end. You know exactly what will happen if you fail to escape.[pg]");
	outputText("“<i>Come on, little bitch! Wag your tail some more! You should be happy to be part of this historical moment!</i>\"[pg]");
	outputText("The succubus leans back, shifting her bikini bottom enough to reveal her moist cunt. \"<i>Your new mates are raring to go. They've been so long without a playtoy, can't you see how eager they are? I mean, all the better for my little... experiment, right?</i>\"[pg]");
	outputText("She begins to finger herself, pressing a button on her desk. The bars slowly begin to part, the grinding of metal exciting the hellhounds even more. They jump at the bars, cocks almost touching the ground as they land. Eyes wide, you look back at the Succubus as she watches her pets try to slip under the bars. You only have a few more seconds before they pounce on you![pg]");
	outputText("\"<i>I’ve made some adjustments to these two. You know, just some lust enhancements, and some... well, you don’t need to know everything they're capable of.</i>” The Succubus giggles again, lifting her finger to her full lips while the smaller of the two hellhounds slip under the fence. You turn, facing it, baring your teeth, but you know you can't fend them off for long. [if (player.vaginas.length > 0) “<i>Oh, bear their litters well, bitch. I’ll need them healthy!</i>”|][pg]");
	outputText("The first hound ignores any signs of your approval as he pushes you to your stomach, mounting you from behind as he forces its twin cocks into your ass. The telltale burning sensation of its precum covers your anal walls as it pistons in and out. It merely takes seconds for the other to join in, grabbing your face as he forces his twin lengths straight into your throat.[pg]");
	outputText("You struggle, getting one hellhound in the muzzle with a paw, but he forces your limbs back, slamming you hard into the other. Your struggles only last for a few seconds, however. The burning sensation spreads through your body, and you cough, trying to clear the burning pre from your throat. As the precum spreads, your muscles seize up, not following your commands. The cock in your throat slams to the base, the musk of the hellhound heady in your nose. You choke, head swimming with the scent of the flaming pre, and you feel the one in your ass expand, locking the hellhound in place as it rapes you. " +
			"Despite your initial unwillingness, you instinctively begin rocking about, deepthroating the hound in front of you as you repeatedly jam your ass back into the other. You feel the second cock behind you run along the crack of your ass, looking for another hole. [if (player.vaginas.length >0) It’s only a matter of time before it finds your [vagina]!|][pg]");
	outputText("The Succubus would have long since left your mind, but she’s watching with wide eyes, making lewd remarks as you pleasure your attackers. She’s touching herself openly, moaning softly, almost taunting you with the single finger pressed against her lips in the background.[pg]");
	outputText("You lose track of time as you get mindlessly fucked by your abusers, your mind racing as you try to find a way to escape this awful situation. Amidst the mess of the ravenous orgy, a pink glint catches your eye. Marae’s Lethicite just fell from your bag and is warmly resting right next to you. You reach out, barely keeping your balance, leaning against the one in front as it fills your throat with cum. You cough it out, the second cock spurting streams of white onto your face. Blind, you reach for the Lethicite.[pg]");
	outputText("Your knuckles hit it, and you grab onto the Remains of Marae’s soul. A weird clarity fills your mind. Lethicite is power, after all. With this back in your grasp, you reel as the hellhound behind you grabs your ass, leaving claw marks down your cheeks as it humps you with even more ferocity. Your mind grows weary, your body battered, you know this Lethicite is your only way out. You don't have long before you succumb to the idea of being their bitch... What thoughts fill your mind?[pg]");

	menu();
	addButton(0, "Get Me Out", hellhoundCaptureGetOut);
	addButton(1, "Fuck Everyone", hellhoundCaptureFuckEveryone);
}
private function hellhoundCaptureGetOut():void {
	clearOutput();
	outputText("As if heeding your silent call for help, the lethicite begins to shine brilliantly. You close your eyes as the blinding shimmer coats the room in light.[pg]");
	outputText("When you open your eyes, you're shocked to find yourself back in your camp, still sitting on your bed. You might've been able to dismiss the ordeal as a nightmare if it weren't for Marae's lethicite sitting right in front of you, slightly, yet noticeably smaller than before as its light slowly fades away. You don't think you're going to sleep peacefully for a few days...[pg]");

	doNext(camp.returnToCampUseOneHour);
}
private function hellhoundCaptureFuckEveryone():void {
	clearOutput();
	outputText("Perhaps out of anger or delirious with pleasurable corruption, your mind comes to the one forgone conclusion: You want to make all those assholes your bitches. Starting with that jerk pumping your ass full of burning spunk.[pg]");
	outputText("He hardly has what it takes to be on top. YOU should be on top! The same goes for that little shit using your throat as a cocksleeve. As for that succubus back there, she should be worshiping that pair of dicks you're sporting, considering the slut she is. Your spunk should be in her throat! Weak-ass bitches like her aren't worthy of bearing your offspring. Your twin dicks suddenly harden at the prospect of putting her back into her place. You feel angry, powerful, only serving to heighten your lust.[pg]");
	outputText("With a primal roar, you spontaneously cum as Marae’s Lethicite begins shining, its power filling your body with strength and heat far surpassing the paltry flames of the hellhound’s fluids. The two hounds that were fucking you up until now suddenly are drawn to you. The one in your ass pulls, sending silver shocks of pain as it tries to rip itself out of your asshole. You grab the one in your throat, biting down on him as his body begins to melt.[pg]");
	outputText("Your former tormentors yip in terror as their bodies are distorted and warped, their forms melting into yours. This hurts, your body now writhing uncontrollably as your fur bristles, the hellhound’s flesh spreading your pores as it covers you. You howl as a hot, sharp pain fills your mind. Your frame widens, your muscles bulge up with added mass. Your bones crunch as the hellhound’s pale skeleton turns to powder, drawn in as well.[pg]");


	outputText("When you open your eyes again, you realize that you’ve gained several new inches in size, your body now towering above the terrified succubus behind the observation window, but also in cock length, the masses of your combined pricks fusing into one. A few seconds later, the only thing remaining of the two little shits rests squarely on your shoulders… or so you thought. As you feel a slightly painful ripping near your throbbing cocks, you look down to see an additional set of balls is added to your own. You howl as, as if unable to sustain the newly accumulated semen from your three separated orgasms, your dicks explode into a torrent of burning cum, covering the observation glass with still-steaming, white hellhound seed.[pg]");
	outputText("Regaining your countenance, you stare at the pair of confused hellhound heads now attached to your shoulders. A quick check reveals the three of you are not only capable of independent thoughts but capable of controlling the main body, at least to an extent.[pg]");
	outputText("It seems the left head can only control the left side while the right controls the right side. You, on the other hand, got control of everything. Your left head moves your arm, and you jerk it back, startled. You take control back, the left head whining its submission. Your right leg moves, and you turn to your right head, snapping at it with your teeth. The right head subsides, giving you proper control again. The pleasure of leading gives you a new high. You lean back, howling in pleasure as your twin cocks are brought to another orgasm. You leave a trail of smoking precum on the ground as you stride forward, getting the hang of your new body.[pg]");
	outputText("These assholes thought to tame you? Dominate you? What a joke! You are the only one worthy of being dominant, your own and only master, and NO ONE gets to order you around. Coming back from the overwhelming distraction of your newfound power, you look for Marae’s Lethicite and find it on the ground where you left it. The lethicite is tiny, compared to what it used to be, a fact that gives you pause. Making this wish took much of its former power.[pg]");
	outputText("Your three heads all wince as a massive noise fills your six ears. Harsh and loud, accompanied by flashing red lights. The noise is disorienting to your newly combined senses. The familiar sound of footsteps brings you out of your disorientation, and you hear various voices crying out in confusion. It looks like your sudden outburst caused a panic in the facility. As if it was the only natural course of action, you make a groundbreaking step toward the locked door of your cell and punch it. To your surprise, the blow is more than enough to shatter the hinges and send it flying across the corridor. You slowly and decisively walk out of the building.[pg]");
	outputText("Demons in lab coats barge in as they confront you, leading groups of armor-clad warriors in an attempt to stop you. The demons are but rabble, poorly prepared for the new you.[pg]");
	outputText("You easily send them flying, like small rocks across the corridor. A small group of guards stands before you, but you let out a laugh before filling the corridor with fire, forcing those weak fools back. As you force your way through the demon’s ranks, you grab a violet-skinned succubus. She wails, struggling to get free, but you roughly pin her between your body and the wall, your two other heads biting her shoulders, drawing blood. You rip her scant clothing off, spread her legs by force and impale her, pussy and ass, on your dicks.[pg]");
	outputText("Pain and pleasure mix on the whore’s face, and she stops struggling, eyes rolling back into her head. Your heads keep their jaws clamped down on the luckless whore as you keep walking, carrying her around like a portable onahole and jerking yourself off before tossing the used demon toy to the side. Finding another bitch among the demons, you slam the so-called warriors among them aside with brute force, taking yourself another victim as you trek through the building.[pg]");
	outputText("Each room you find is torn to shreds by your claws, ripped apart by your teeth, or burned to ashes by your corrupting hellfire. Demons flee before you. Demons that are foolish enough to fight are torn to shreds or used to briefly sate your ravenous lust.[pg]");
	outputText("Only when you’ve destroyed every room twice, torn every Incubus you can find to shreds, and sent over two dozen Succubi to the ground in a gaping, pleasure-soaked heap is your rage satiated. You gather the bitches into one pile, covering them in a veritable shell of white spooge before finally looking for an exit.[pg]");
	outputText("The final obstacle is a steel door with a large exit sign written in red on a panel. A gentle push from you slams the door open as you head back to your camp.[pg]");

	CoC.instance.mutations.forceCerberus();
	player.sexReward("vaginalFluids", "Dick");
	player.sexReward("vaginalFluids", "Dick");
	player.sexReward("vaginalFluids", "Dick");
	doNext(camp.returnToCampUseFourHours);
}

public function impTomeScene():void {
	clearOutput();
	outputText("You moan as you spontaneously cum. Your impish body has absorbed so much energy from the many victims you violated that it’s ready to be expunged. [pg]");
	outputText("Thanks to the tome your tiny body feels almost bathed in unholy power but as a result of it your arousal has reached inhuman levels. An idea comes to you out of nowhere. Fuck… the book? You should just fuck the book! It would be so simple to give in to your deviant urges but who's to tell what might happen if you use the cursed tome to pleasure yourself?![pg]");
	menu();
	addButton(0, "Give In", impTomeGiveIn);
	addButton(1, "Resist", impTomeResist);
}
private function impTomeResist():void {
	outputText("You resist the strange urge, and wonder how such a strange though came to be, how would you even fuck a book?")
	doNext(playerMenu);
}
private function impTomeGiveIn():void {
	clearOutput();
	outputText("You give in to your urges, letting the unholy power of the book wash over you for better or worse. The black inked text suddenly animates, turning into black tentacles that wrap around your limbs, pulling you toward the pages. Before you can issue a word of protest a single tendril");
	if (player.hasCock()) outputText(" wraps around your [cocks] jerking you off vigorously");
	outputText((player.hasCock() && player.hasVagina()?" while another":""));
	if (player.hasVagina())outputText(" inserts itself into your welcoming pussy, rushing past your cervix as it causes your stomach to bulge with the shape of the foreign flesh ravaging your insides");
	outputText(".[pg]You feel your orgasm coming through like a tidal wave breaching through the barriers of rational thought you erected in your mind and turning everything to mush as you cum out your essence in the form of purple fluids unto the pages the letter of your name now forming as the newly versed ink dries up. As if on cue, your body is suddenly pulled in further, you're being dragged right into the pages! First your feet, then your legs and before you know it you're in up to your torso. The tome is eating you up! You try a final time to pull yourself out of the book as a third orgasm rocks you by causing you to release your hold and being dragged right into the tome![pg]");
	outputText("Surrounded by darkness, you have no idea where you are. You try moving, but you are firmly stuck in a caged prison, of which the only exit seems to be currently closed. You don't even have enough space to masturbate, talk about inconvenience! Just as you're about to go back to sleep you're suddenly pulled down by the hair into a very tight fleshy passage.[pg]");
	outputText("Seeing your way to freedom, you go onward wiggling your way toward the light and fresh air. As your head finally forces its way out you see a scene you weren't expecting. A luxurious room filled with blankets and cushions awaits you. It looks like a comfortable, well-lit living space save for the fact it lacks any windows. You look around noticing several additional features including magical research tools and a lectern with an open book. Last but not least above your head on the ceiling floats a swirling vortex of purple magic at the center of which floats the shape of a disjoined pussy, gaping wide and still drooling from your recent passage. Did you just fall through a cunt portal?[pg]");
	outputText("With not much else to do, you walk over to the lectern and check on the book. As you approach, ink forms onto the paper and takes on the shape of distincts letters.[pg]");
	outputText("\"<i>Dear [name], congratulations! I am the librarian demon Nalcanthet[if (silly)Herma Moira] and the creator of the Tome of Imps. By signing your name into my book and trading off your soul you have formally entered a contract with me. As the contractor you are now the official owner of this book I created (Take care of it, your life depends on that!).[pg]");
	outputText("With the deal sealed and through the unholy power of my womb you were reborn as an Arch Imp (Yes I have a fetish for shortstacks). I created this item as a device so that I could enjoy the pleasure of my body being used for eternity, call it a weird kink of mine. As a reward you may now use this extradimensional space and its 'gate' for the storage and displacement of imps. Please use this book to your hearts content. Absorbing new souls and imps into these pages may grow the power of the contract.</i>\"[pg]");
	outputText("Looks like you got cursed, although come to think of it, is that really a curse? You're now possibly the most powerful imp in the world and you still own the tome. The depraved image of legions of lesser imps");
	if (player.hasCock()) outputText(" servicing your cock as you order them to bring the next bitch to break");
	outputText((player.hasCock() && player.hasVagina()?", while a tied up manslut serves as your personnal throne":""));
	if (player.hasVagina())outputText(" fucking your fertile imp cunt to birth the new legion of servants obediant to your royal will");
	outputText(" comes to your mind and makes you smirk wickedly.[pg]");
	outputText("Yea the idea of taking over the world by storm as the strongest imp gives you chills of pleasure,");
	outputText("[if (hasock) your cock hardening][if (hascock && hasvagina) and][if (hasvagina) your snatch drooling] at the prospect, the thought nearly bringing you to a spontaneous orgasm.[pg]");
	outputText("Done examining your new personal abode, you exit by the way you came parting the vaginal gate and leaving the book more or less the same way you got in.[pg]");
	outputText("Back in your camp you prepare your battle plans for world domination. First, you will need more imps.[pg]");
	CoC.instance.mutations.archImpTFforce(player);
	doNext(camp.returnToCampUseFourHours);
}
	}

}
