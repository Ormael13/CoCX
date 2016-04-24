/**
 * Created by aimozg on 03.01.14.
 */
package classes.Scenes.Areas.HighMountains
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;

	public class BasiliskScene extends BaseContent
	{
		public function BasiliskScene()
		{
		}
		
		//Vars
		//276 - Times Encountered
		
		//Battle Consequences
		//*basilisk drops: Reptilum or a randomly colored small egg 
		//*Player rapes the basilisk: -1 Libido
		//*Player assrapes the basilisk: +1 Corruption
		//*basilisk beats the player: -3 Speed
		//*basilisk rapes the player: +1 Sensitivity
		//*followup creatures taking advantage have their usual effects
		
		//Intros and Fight Texts. 
		public function basiliskGreeting():void {
			spriteSelect(75);
			clearOutput();
			//First encounter: 
			if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00276] == 0) {
				outputText("You are carefully trailblazing up a steep pass in the jagged mountain peaks when a furious screech from high above you makes you start.\n\n", false);
		
				outputText("\"<i>Thiieeeeeeeeef, filthy thieeeeeeeeef!</i>\" A harpy flaps into view over the ridge, her face a picture of rage. You hastily assume a fighting stance- but the harpy completely ignores you, her gaze sliding over you and onto the rock wall behind you. \"<i>You can hide but you can't run, sneak thiieeeeeeeef! When I find you, I'm going to tear your naaaaaaaaasty little eyes out!</i>\" She flies on, screaming with anger, her head moving back and forth in jerky movements, scrying the landscape. You stare blankly in bafflement at this display, but are glad that a harpy's attention is on someone else for a change. Marveling at your fortune, you decide to press on.\n\n", false);
		
				outputText("At the top of the pass you take a moment to catch your breath, and notice something white lying on the ground, sheltered by a rock formation. Is that a harpy egg? What is it doing away from a nest? Something on the rocks catches your eye: a tiny pool of grey, split by a vertical black slit. You look closer at it to try to make sense of it. It's part of something bigger... but that's not important. What is important is that you keep staring into that depthless pool of grey. If you keep looking into it, you are quite sure you will be able to see forever; like two mirrors held up against each other, it's just a case of looking hard enough. Is there even anything outside of the grey pool? You don't think there is, and why would you even want to find out? Everything to be seen and known is there, in those bottomless depths...\n\n", false);
		
				outputText("Using every vestige of your willpower, you tear your gaze away from the terrible, paralyzing sight. Panting and feeling groggy, you desperately hold the rock formation in the corner of your eye. A tall, thin bipedal shape disengages from the stone against which it had been camouflaging itself, and stalks predatorily towards you. With small, quick glances you glean fleeting impressions of grey-green scales, a tightly muscled yellow underbelly, cruelly curved index claws, a whip like tail. The creature moves its snub head towards yours suddenly, trying to catch your gaze with its deadly grey eyes again. You recoil and ready yourself to fight it as best you can.\n\n", false);
				var basilisk:Basilisk = new Basilisk();
				//(spd loss)
				Basilisk.basiliskSpeed(player,5);
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00276]++;
				startCombat(basilisk);
			}
			//Standard encounter:
			else {
				outputText("You notice a large boulder ahead. There is something curiously shaped about it. A small, wet grey shape on it catches your eye...\n\n", false);
		
				outputText("You look away in the nick of time, and ready yourself to fight as the basilisk slides from his hiding place and advances upon you, his deadly eyes and sharp claws glinting coldly in the sunlight.\n\n", false);
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00276]++;
				startCombat(new Basilisk());
			}
			flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00276]++;
			spriteSelect(75);
		}
		

		
		//wins
		public function defeatBasilisk():void {
			spriteSelect(75);
			clearOutput();
			var evil:Function =null;
			var eggs:Function =null;
			if (player.canOvipositSpider()) eggs = driderPCEggLaysBasilisk;
			if (player.canOvipositBee() && player.gender > 0) eggs = layBeeEggsInABasilisk;
			if (player.cockThatFits(monster.analCapacity()) >= 0 && (player.cor >= 66 - player.corruptionTolerance())) evil = defeatBasiliskAndAnal;
			//Player HP victory: 
			if (monster.HP < 1) outputText("Unable to stand anymore, the basilisk shakily sinks down on one knee, drops his head and looks at the ground, evidently demonstrating submission.", false);
			//Player Lust victory: 
			else outputText("No longer able to control his raging erection, the basilisk closes his eyes and sinks to one knee. He would probably be attempting to signal his submission to you if he weren't furiously masturbating his long, purple cock, which has emerged straining from the creature's genital slit.", false);
		
			//If victory and Player Lust above 30: 
			if (player.lust >= 33 && player.gender > 0 && flags[kFLAGS.SFW_MODE] <= 0) {
				outputText(" Certain that the creature won't dare try and turn his eyes on you again, you take your time to look the tall reptile over directly for the first time. Perhaps you could use him to satisfy your baser urges. If so, what part of him do you choose?", false);
				//[Tongue][Ass]
				menu();
				addButton(0, "Tongue", tongueBasiliskSmex, null, null, null, "Put that creature's tongue to a good use.");
				if (player.cockThatFits(monster.analCapacity()) >= 0) {
					addButton(1, "Ass (Gentle)", defeatBasiliskAndAnal, false, null, null, "Fuck the basilisk's ass gently!");
					if (player.cor >= 66 - player.corruptionTolerance()) addButton(2, "Ass (Cruel)", defeatBasiliskAndAnal, true, null, null, "Dominate and fuck the basilisk in the ass! He wouldn't like it though.");
				}
				addButton(3, "Lay Eggs", eggs, null, null, null, "Lay your eggs in the basilisk.");
				addButton(4, "Leave", combat.cleanupAfterCombat);
			}
			else combat.cleanupAfterCombat();
		}
		
		//Player Victory sex:
		// "<i>Tongue"<i>
		private function tongueBasiliskSmex():void {
			spriteSelect(75);
			clearOutput();
			outputText("You tap your jaw as you stare down at the defeated reptile, smiling at his oddly formal gesture of surrender. You'd very much like to take some satisfaction from the basilisk, extract a bit of pleasurable payment for what he tried to do to you: but the more you get to look at him properly, the more difficult doing that seems. The tall, thin creature is all angles, tough scales and pointed edges. You don't like the thought of putting your genitals anywhere near his sickle claws or curved fangs.\n\n", false);
		
			outputText("It is as you are taking in this latter article that the basilisk swallows nervously, and you get a glimpse inside his mouth at a long, sticky, pale purple tongue, another gift of his reptilian ancestors. It's the only part you've seen of him so far which looks... soft. Pliable. Your smile widens and you step forward, slowly loosening your " + player.armorName + ".\n\n", false);
		
			outputText("<i>First things first</i>, you think. <i>Better put some protection on.</i> You take a long rag out of your pocket and, after considering the oblong shape of the basilisk's head, tie it vertically around his eyes, tying the blindfold under his chin like a headscarf. \"<i>I'm not saying I don't trust you,</i>\" you tell him as you work, \"<i>but... I don't trust you.</i>\" The creature accepts this treatment quite meekly. All of his fight and cunning seem to have completely run out of him now that you've established your superiority, and the feeling of power this gives you sends blood rushing eagerly towards your crotch. \"<i>Now...put your claws behind your back and open your mouth,</i>\" you breathe. \"<i>I want to see that nice soft tongue of yours, worm.</i>\" You can't understand him, but apparently he can understand you, and he slowly complies. He kneels in front of you, blindfolded with his long, wet tongue lolling out" + player.clothedOrNakedLower(", as you tear away your undergarments") + ".\n\n", false);
		
			//Male/Herm: 
			if (player.hasCock()) {
				outputText("\"<i>Wrap it around me,</i>\" you demand gruffly, poking your " + player.cockDescript(0) + " lightly against the end of his tongue. Slowly, the basilisk does as you ask. He is clumsy at first, taking time to get a sense of your girth and hardness as he tastes and licks blindly, but he quickly grows into the task. Starting from just above your head, he curls his tongue right around your prick and then inches his way upwards, spiraling his long, incredibly flexible organ around you. The more you feel this thing's tongue, the more you know you made the right choice here; the shifting, wet sensation as he snakes his way upwards towards your base is incredible, and gets better the more of your " + player.cockDescript(0) + " is swathed in mouth muscle. It is unlike any tongue you've felt before... there is some kind of adhesive property in the basilisk's saliva which makes his soft flesh stick like a leech once it is on you.\n\n", false); 
		
				//Single cock: 
				if (player.cockTotal() == 1) {
					outputText("Once he has wrapped around as much of your cock as he can, you take a moment to control yourself in this dizzying, soft yet tight vice grip your serpent sub now has you in. \"<i>Squeeze. Work it, nice and slow,</i>\" you say huskily. The basilisk's tongue slides up and down your length, its saliva slathering every inch, the sticky, sucking sensation encompassing your cock on all sides. It squeezes you softly and then relaxes... squeezes you, then relaxes, as he continues to spiral around and around. It is everything you can do not to go over the edge straight away; you hold back desperately, staring upwards. To blow your load before properly enjoying what is turning out to be a truly unbelievable suck would be a terrible crime. You look downwards and manage to pull yourself back a bit by laughing hugely at the sight. With the basilisk's tongue spiralled around you, your " + player.cockDescript(0) + " looks like nothing so much as an obscene candy cane. The basilisk seems to take your hysterical laughter for anger or contempt, because he hastily increases his pace, forcing his sticky muscle up and down as fast as he can. You lean back and lose yourself in the blissful, sucking, enveloping sensation.\n\n", false);
		
					outputText("You last for as long as you can before, with a euphoric sigh, you reach your peak. Your " + player.cockDescript(0) + " bulges and then rockets out stream after stream of jizz. Directly in the line of fire, the blind basilisk takes his minute-long facial with as much dignity as he can muster- which is to say, none at all.\n\n", false);
				}
				//Multicock: 
				else {
					outputText("The basilisk wraps himself around part of your " + player.cockDescript(0) + "... and then stops. Confused and frustrated, you look down. The tip of his tongue has touched your " + player.cockDescript(1) + ", and cautiously, it begins to inch his way downwards and around, working towards your second tip. \"<i>Oh, aren't you a clever girl,</i>\" you sigh, revelling in the sensation of both of your cocks trapped in the dizzying, soft yet tight vice grip your serpent sub now has you in. The basilisk grunts at the humiliating commentary. \"<i>Squeeze. Work them, nice and slow,</i>\" you say huskily. The basilisk's tongue slides up and down your length, its saliva slathering every inch, the sticky, sucking sensation encompassing your cocks on all sides. It squeezes you softly and then relaxes... squeezes you, then relaxes, as it continues to spiral around and around. He bends forward, investing more of his tongue around you, inching his way further up your " + player.cockDescript(1) + ". His tip comes off you with a sucking sound, and he begins to tease the head of your second prick, circling it and lavishing it with attention as he continues to work your two lengths. \"<i>How... where did you learn to do that?!</i>\" you gasp, and are immediately grateful the basilisk can't respond to your query. It is everything you can do not to go over the edge straight away; you hold back desperately, staring upwards. To blow your load before properly enjoying what is turning out to be a truly unbelievable suck would be a terrible crime. You look downwards and manage to pull yourself back a bit by laughing hugely at the sight. With the basilisk's tongue spiralled around you, your " + player.cockDescript(0) + " looks like nothing so much as an obscene candy cane. The basilisk seems to take your hysterical laughter for anger or contempt, because he hastily increases his pace, forcing his sticky muscle up and down as fast as he can. You lean back and lose yourself in the blissful, sucking, enveloping, teasing sensation.\n\n", false);
					outputText("You last for as long as you can before, with a euphoric sigh, you reach your peak. Your " + player.cockDescript(0) + " and " + player.cockDescript(1) + " both bulge and then rocket out streams of jizz in concert. Directly in the line of fire, the blind basilisk takes his minute-long double facial with as much dignity as it can muster- which is to say, none at all.\n\n", false);
				}
				//Both go to: 
				outputText("You look beatifically down at him when you are finished and notice that despite himself the basilisk has got more than a bit turned on by your fairly callous treatment of it; the creature is finding it difficult to kneel properly with his long, purple erection poking against the ground. You smile with satisfaction at how successfully you've managed to paint his face white with your seed. \"<i>That's a good look for you. We really must do this again,</i>\" you say as you loosen his blindfold just a little before taking your leave. You chance a look back. The creature is staggering in the opposite direction, wiping his face with a claw and trying not to bump his cock into anything, looking very dazed indeed. You grin and make your way back to camp.", false);
			}
			//Female: 
			else if (player.hasVagina()) {
				outputText("\"<i>Lick me,</i>\" you tell the basilisk brusquely, as you push your hips out and present your " + player.vaginaDescript(0) + " to his tongue. You decide you'll take your reward standing up; the sight of the beast on his knees in front of you is quite pleasing.\n\n", false);
		
				outputText("The basilisk slowly does as you ask, leaning forward and pushing his long, slick tongue against your lips. It is clumsy at first; unable to see, it has to feel with his slick mouth muscle, licking around the limits of your " + player.vaginaDescript(0) + " before pushing inside. The creature inadvertently frustrates you, and so when it finally finds your hole it is welcoming and wet.\n\n", false);
		
				outputText("The basilisk finds your " + player.clitDescript() + " and, after circling it slowly and thoughtfully for a while, pushes his tongue into your wet vagina. You gasp as he inches himself further up you, bending his face in. The creature's tongue isn't like any you ever felt before; longer than a human cock and infinitely more flexible, it is able to caress you at a depth you didn't think possible. He pulls himself out a little and you discover another positive to it: there seems to be an adhesive quality to his saliva which causes it to stick to flesh it is attached to. As he withdraws slightly, your tender inner walls go with it before parting from his tongue slowly and luxuriantly. The sensation makes you gasp as you spasm and orgasm on the spot. The basilisk is treated to a gush of a girlcum straight down his nostrils and he coughs dryly, withdrawing itself intuitively. Immediately you grind your " + player.vaginaDescript(0) + " right into his face, bending over him and gripping his head spines, denying it air. \"<i>You stop when I say you can, not before,</i>\" you growl at him. Quickly, submissively, the lizard applies himself to you again. You smile with great pleasure. There is no way you're letting a tongue as fantastic as this go easily.\n\n", false);
		
				outputText("You make the basilisk pleasure you for what seems like hours. He lavishes attention on your deepest, most sensitive spots with his incredibly long and flexible tongue, his sticky saliva pushing and pulling you to astonishing, mind blowing heights. The creature is able to hunch his tongue up against your " + player.clitDescript() + " whilst still inside you, brushing over and around him, giving it just enough attention to tease you to madness; it drives you to orgasm after orgasm. \"<i>You've done this before, haven't you?</i>\" you pant as you begin to flagrantly grind yourself against the basilisk's scaly snout. \"<i>You must have. How can a fucking lizard be an expert at cunn- ahhhhh!</i>\" You spasm wildly, once again drowning the blindfolded reptile with your juices. With a hugely satisfied sigh, you finally step away from the creature.\n\n", false);
		
				outputText("You look beatifically down at him and notice that despite himself the basilisk has got more than a bit turned on by your fairly callous treatment of it; the creature is finding it difficult to kneel properly with his long, purple erection poking against the ground. His tongue flops weakly out of his girl-cum-spattered mouth, evidently too weak to even curl back up, and you grin as you imagine how much it must ache from the workout you gave him. \"<i>That's a good look for you. We really must do this again,</i>\" you say breezily as you loosen his blindfold just a little before taking your leave, shaking the weariness out of your knees as you go. You chance a look back; the creature is staggering in the opposite direction, wiping his face with a claw and trying not to bump his cock into anything, looking very dazed indeed. You grin and make your way back to camp.", false);
			}
			player.orgasm();
			dynStats("lib-", 1);
			combat.cleanupAfterCombat();
		}
		
		//basilisk Defeat: Anal 
		private function defeatBasiliskAndAnal(corrupt:Boolean):void {
			spriteSelect(75);
			clearOutput();
			var x:Number = player.cockThatFits(monster.analCapacity());
			//Requires: Corruption 70 or more, cock (for now) 
			//Prelude: 
			outputText("You stand over the kneeling basilisk, your mind boiling with lust and anger. You want to " + (corrupt ? "really" : "") + " punish this loathsome lizard for daring to mess with you, for daring to try to force his unsettling, paralyzing magic on you. As you weigh up your options, the tall reptile slides an eye open and chances a look upwards. ");
			if (corrupt) {
				outputText("Whatever he sees in your face causes him to flinch and immediately close it again, but even this tiny show of defiance enrages you. \"<i>Open them again and I will close them. Permanently,</i>\" you snarl. The creature has given you a stroke of inspiration, though. If only there was something... you look around you, and a gleam of light catches your eye; a somewhat clear, still pool of water lies about two dozen yards away. A cruel grin splits your face: <i>providence</i>.\n\n");
				outputText("You slap a hand on the scruff of the basilisk's neck, gripping as much of his leathery hide as you can. \"<i>Crawl,</i>\" you snap, tugging him in the direction you want him to go. The basilisk meekly does as he is told at first, feeling out in front of him with his claws blindly and following your lead. It must take another peep at where he is being taken about two thirds of the way there however, because judging by the way he starts thrashing his limbs and tail around in protest, he guesses what you have in mind. You have already broken his physical resistance though and you are able to ignore his pathetic pawing at your " + player.armorName + ", dragging the defeated reptile by the back of his neck the rest of the way. You push your " + player.leg() + " savagely into his back and grip his spines as you position his head over the smooth, liquid mirror of the pool. \"<i>Open your eyes,</i>\" you command. The basilisk clenches them tighter. You sigh and shove his head under the cold water, holding it there until his struggles grow weak and spasmodic before finally releasing. You hum and examine your nails as the reptile heaves for air and coughs miserably, waiting patiently for the ripples on the pool's surface to subside. \"<i>Open your eyes,</i>\" you say again, in exactly the same tone. This time, the basilisk does as you say. A smile curves your lips as you feel the creature tense and then freeze under you. Staring at his reflection, he falls helplessly under his own spell.\n\n", false);
			}
			else {
				outputText("Whatever he sees in your face causes him to flinch and immediately close it again, whimpering in fear. \"<i>If you submit, I'll go easy on you,</i>\" you assure. But safety first, of course. If only there was something... you look around you, and a gleam of light catches your eye; a somewhat clear, still pool of water lies about two dozen yards away. A merry grin splits your face: <i>providence</i>.\n\n");
				outputText("You gently guide the basilisk on the direction you want to go. \"<i>Crawl,</i>\" you instruct, tugging him in the direction you want him to go. The basilisk meekly does as he is told at first, feeling out in front of him with his claws blindly and following your lead. It must take another peep at where he is being taken about two thirds of the way there however, because judging by the way he keeps his claws dug deep into the earth in protest, he guesses what you have in mind and lets out a faint whimper. You whisper into his ear and tell him, \"<i>It's for a good reason. I'll promise to take good care of you.</i>\" Your words sink deep within the basilisk's mind and he starts to comply you again but he keeps his eyes closed. You gently position the basilisk's head over the liquid mirror of the pool. \"<i>Open your eyes for two seconds,</i>\" you command. The basilisk hesitates but obeys you anyway and opens his eyes for two seconds then closes his eyelids immediately. You can feel his reptilian scales stiffening as he is effectively frozen by his own spell.\n\n");
			}
			//High Corruption: 
			if (corrupt) {
				outputText("You get off the basilisk and walk around him, giving him a cautious tap in the flank. No response; the creature is well and truly paralyzed. Knowing your prey is going nowhere, you undress at leisure, allowing your " + player.cockDescript(x) + " to slide out and feel the fresh air. You kneel over the creature's hindquarters and rub yourself back and forth along his scales, hardening as you enjoy the warm, leathery sensation. As the need to fuck takes hold of you, you try to get at the basilisk's tight, muscled ass, but his long tail, frozen in place, is in the way. You pull at him, but the paralyzed flesh is impossible to move. \"<i>Lift your tail!</i>\" you snap in frustration. Immediately the tail lifts, raising up and back over the basilisk until his behind is unprotected, before freezing into place again. Your eyes widen ever so slightly as you realize how much power you have given yourself over the reptile; caught in a feedback loop of his own hypnosis, mind emptied, he is helplessly deferential to whatever anyone says to him. A mad yet oddly tempting image of a dancing basilisk flits through your head... but no, your straining cock reminds you that there are more important matters at hand. Without preamble, you grasp the creature's hindquarters and push your " + player.cockDescript(x) + " against his tight anus.\n\n", false);
				outputText("The going is tough at first, even if your fuck toy is incapable of tensing itself. You push past his sphincter slowly, working his passage, feeding more of yourself in bit by bit. Without lubrication the sensation is incredibly tight for you and undoubtedly not very pleasurable for your partner... not that you care. It emits a dry moan through his still mouth as you slowly begin to buck against it more roughly. \"<i>Relax,</i>\" you hiss; it is not a suggestion. The creature's back passage eases, allowing you to slip further in suddenly. This delightful sensation makes you drool pre-cum, lubricating the basilisk's hole and breaking the friction, allowing you to begin to thrust against the creature.\n\n", false);
				outputText("The basilisk is clearly something of a novice when it comes to anal rape; his passage is incredibly tight and grips you like a fist, forcing more pre-cum out of you, making your efforts easier and more pleasurable as you begin to roughly fuck your paralyzed victim harder and harder, losing yourself in that clenchingly tight ass. ", false);
				//[(13 inches or less:)
				if (player.cocks[x].cockLength <= 13) {
					outputText("Soon your " + player.hipDescript() + " are clapping a staccato rhythm against his warm, muscly butt,", false);
					if (player.balls > 0) outputText(" your " + player.ballsDescriptLight() + " slapping against him,", false);
					outputText(" the creature taking every inch of your length before you pull out and thrust all the way in again, forcing ragged gasps from the reptile's still throat.\n\n", false);
				}
				//(More than 13 inches:)
				else {
					outputText("You force as much of your huge member as you can into the creature's anus, clutching onto the creature's warm, muscly butt as you pull out and thrust yourself in again, brutally driving a bit more of yourself in each time, forcing ragged gasps from the reptile's still throat. ", false);
					//[(if balls)
					if (player.balls > 0) outputText("Your " + player.ballsDescriptLight() + " swing heavily underneath your shaft, swelling as your rhythm picks up. ", false);
					outputText("At the end of your reach you push against something spongy and yielding. The basilisk emits a dry moan and underneath him you see that you have forced his long, thin, shining cock from his genital slit. With a cruel smile you thrust into him again and again, holding onto your depth at the height of your thrust just a little each time to put pressure on the helpless basilisk's prostate, forcing the creature into an involuntary, straining erection. You slip one hand under his frozen legs and begin to pump the creature in time with your rhythm, leaning over it as you do, whispering every dark thought that bubbles up through your corrupt mind into his ear; telling him what a pathetic slutty little fuck toy he is, how turned on he is by your assault on it, how grateful he should be that you have deigned to give him your cock, knowing your words are sinking into his hypnotically stilled and pliable mind as easily as your " + player.cockDescript(x) + " is into his cum-oiled hole.\n\n", false);
				}
				
				outputText("He has to accept your every word as he has to accept your dick, and it isn't long before with a ragged moan he cums, not a muscle moving except his desperately spasming cock, his jizz spattering into the pool and onto his arms as you slam into him with everything you've got. You last a little longer, continuing to mercilessly milk the basilisk until you see his purple cock is straining without producing anything before ", false);
				//<(13 inches or less:) 
				if (player.cocks[x].cockLength <= 13) outputText("gripping his hips and pushing every inch of yourself in and reaching a glorious, skin tingling peak.", false);
				//(More than 13 inches:)
				else outputText("gripping his hips and pushing as much of your huge, bulging cock into him as you can, his stomach bulging as you reach a glorious, skin tingling peak.", false);
				outputText(" You continue to fuck the creature as you ejaculate, forcing your tainted jizz deep inside him, glorying in how the spurting lubricant allows you to fuck his hole even better. Eventually, after a series of orgasms which feel like the sky is falling, you finally pull out of the basilisk's ravaged anus with a deeply satisfied sigh. Your cum dribbles out of the creature's gaping butt; the only regret you feel in your deep haze is that there is nothing at hand to plug it in with. You sit back and allow yourself to bask in the afterglow, safe in the knowledge that there will be no retaliation forthcoming from your partner.\n\n", false);
				outputText("You are shaken out of him by an urgent, rasping moan from the basilisk. You sense movement overhead and look up. The lizard has seen in the water's reflection what you can take in with your own eyes; several harpies circling overhead like vultures, waiting patiently for you to leave. The smiles which plaster their faces are possibly the least kindly you have ever seen. The basilisk whines again, this time with a desperate pleading edge. You kneel down and comfortingly stroke your victim's scaled head, glorying in the moment of false hope you give him. \"<i>Get hard,</i>\" you whisper. The creature clenches as his no doubt aching cock strains to attention again. \"<i>Don't worry,</i>\" you murmur into his ear. \"<i>I'm sure the nice birdies will shake you out of it. Eventually.</i>\" You get up, dress yourself, and leave. A pitiless grin slowly spreads across your face as behind you, the opening strains of what promises to be a very long, violent, and feathery rape reach your ears...", false);
			}
			//Low Corruption:
			else {
				outputText("You get off the basilisk and walk around him, giving him a cautious tap in the flank. Delayed response; the creature is somewhat paralyzed. " + player.clothedOrNakedLower("Knowing your opponent is going nowhere, you undress at leisure, allowing your " + player.cockDescript(x) + " to slide out and feel the fresh air. ") + "You kneel over the creature's hindquarters and rub yourself back and forth along his scales, hardening as you enjoy the warm, leathery sensation. As the need to fuck takes hold of you, you try to get at the basilisk's tight, muscled ass, but his long tail, nearly frozen in place, is in the way. You pull at him and it takes " + (player.str < 60 ? "a lot of effort to move" : "some effort to move") + ". A mad yet oddly tempting image of a dancing basilisk flits through your head... but no, your straining cock reminds you that there are more important matters at hand. You spit all over your hands and apply the makeshift lube all over your " + player.cockDescript(x) + " Without preamble, you grasp the creature's hindquarters and slowly push your " + player.cockDescript(x) + " against his tight anus.\n\n", false);
				outputText("The going is tough at first, even if your fuck toy is incapable of tensing itself. You push past his sphincter slowly, working his passage, feeding more of yourself in bit by bit. With lubrication the sensation is incredibly tight for you and quite pleasurable for your partner. He emits a moan through his still mouth as you slowly begin to buck against it more roughly. \"<i>Relax,</i>\" you suggest. The creature's back passage eases, allowing you to slip further in suddenly. This delightful sensation makes you drool pre-cum, lubricating the basilisk's hole and breaking the friction, allowing you to begin to thrust against the creature.\n\n", false);
				outputText("The basilisk is clearly something of a novice when it comes to anal sex; his passage is incredibly tight and grips you like a fist, forcing more pre-cum out of you, making your efforts easier and more pleasurable as you begin to gently fuck your paralyzed opponent harder and harder, losing yourself in that clenchingly tight ass. ", false);
				//[(13 inches or less:)
				if (player.cocks[x].cockLength <= 13) {
					outputText("Soon your " + player.hipDescript() + " are clapping a staccato rhythm against his warm, muscly butt,", false);
					if (player.balls > 0) outputText(" your " + player.ballsDescriptLight() + " slapping against him,", false);
					outputText(" the creature taking every inch of your length before you pull out and thrust all the way in again, forcing ragged gasps from the reptile's still throat.\n\n", false);
				}
				//(More than 13 inches:)
				else {
					outputText("You force as much of your huge member as you can into the creature's anus, clutching onto the creature's warm, muscly butt as you pull out and thrust yourself in again, comfortably driving a bit more of yourself in each time, forcing ragged gasps from the reptile's still throat. ", false);
					//[(if balls)
					if (player.balls > 0) outputText("Your " + player.ballsDescriptLight() + " swing heavily underneath your shaft, swelling as your rhythm picks up. ", false);
					outputText("At the end of your reach you push against something spongy and yielding. The basilisk emits a dry moan and underneath him you see that you have forced his long, thin, shining cock from his genital slit. With a cruel smile you thrust into him again and again, holding onto your depth at the height of your thrust just a little each time to put pressure on the helpless basilisk's prostate, forcing the creature into an involuntary, straining erection. You slip one hand under his frozen legs and begin to pump the creature in time with your rhythm, leaning over it as you do, whispering every thought that bubbles up through your mind into his ear; telling him what a pathetic opponent he is, how turned on he is by your assault on it, how grateful he should be that you have deigned to give him your cock, knowing your words are sinking into his hypnotically stilled and pliable mind as easily as your " + player.cockDescript(x) + " is into his cum-oiled hole.\n\n", false);
				}
				
				outputText("He has to accept your every word as he has to accept your dick, and it isn't long before with a ragged moan he cums, not a muscle moving except his desperately spasming cock, his jizz spattering into the pool and onto his arms as you slam into him with everything you've got. You last a little longer, continuing to mercifully milk the basilisk until you see his purple cock is straining without producing anything before ", false);
				//<(13 inches or less:) 
				if (player.cocks[x].cockLength <= 13) outputText("gripping his hips and pushing every inch of yourself in and reaching a glorious, skin tingling peak.", false);
				//(More than 13 inches:)
				else outputText("gripping his hips and pushing as much of your huge, bulging cock into him as you can, his stomach bulging as you reach a glorious, skin tingling peak.", false);
				outputText(" You continue to fuck the creature as you ejaculate, forcing your jizz deep inside him, glorying in how the spurting lubricant allows you to fuck his hole even better. Eventually, after a series of orgasms which feel like the sky is falling, you finally pull out of the basilisk's used anus with a deeply satisfied sigh. Your cum dribbles out of the creature's gaping butt; the only regret you feel is starting the whole thing in the first place. At least he did learn a lesson not to mess with you.\n\n", false);
				outputText("You are shaken out of him by an urgent, rasping moan from the basilisk. You sense movement overhead and look up. The lizard has seen in the water's reflection what you can take in with your own eyes; several harpies circling overhead like vultures, waiting patiently for you to leave. The smiles which plaster their faces are possibly the least kindly you have ever seen. From your hunch, you suspect he'll get back up in a minute and scare off the harpies. You get up" + player.clothedOrNakedLower(", dress yourself,") + " and leave. A pitiful frown slowly spreads across your face as behind you, you already feel the footsteps of the basilisk slowly retreating.", false);
			}
			player.orgasm();
			if (corrupt) dynStats("cor", 1);
			combat.cleanupAfterCombat();
		}
		
		//Player Defeated:
		public function loseToBasilisk():void {
			spriteSelect(75);
			clearOutput();
			//Speed 0 loss: 
			if (player.spe <= 1) {
				outputText("Moving has become intensely difficult. You cannot explain why something that came naturally to you ten minutes ago is now like wading neck deep through quicksand, but that is what moving your limbs now feels like. With a huge, straining amount of effort, you desperately raise your arms and crane your neck away from the basilisk as he approaches you, but with a pathetic amount of ease the creature slides through your guard, grabs you by the chin and looks directly into your eyes. Your reactions are so slow your mind's screaming order for your eyelids to close takes several seconds for your nerves to compute, by which time it is far too late.\n\n", false);
			}
			//HP loss: 
			else if (player.HP < 1) outputText("You fall to your hands and knees, battered and broken. You can't summon the strength or willpower to struggle as the basilisk strides towards you, roughly pulls you to your feet, grabs your chin and forces you to look directly into his face. With one last show of defiance you close your eyes, to which the basilisk responds by backhanding you with increasing force. It is a lost battle and, afraid that it will start using his claws instead, you meekly open your eyes to stare into depthless, watery grey.\n\n", false);
			//Lust loss: 
			else outputText("You can't help yourself. Something about the powerlessness the basilisk instills in you turns you on beyond belief. You don't struggle as the basilisk strides towards you, roughly pulls you to your feet, grabs your chin and forces you to look directly into his face. You want to thank the creature for the privilege of staring into the spellbinding infinity of his grey eyes again. The words freeze on your lips.\n\n", false);
		
			outputText("You stare deep into the creature's eyes. There really is an infinity in there, a grey fractal abyss which spirals upwards and downwards forever. You want nothing more than to spend the rest of your life following him... when the basilisk's pupils dilate, and you feel his hypnotic compulsion press upon your mind, it is as if the universe itself is speaking to you, and you can no sooner resist it than a tadpole can an endless, grey waterfall.\n\n", false);
		
			outputText("It takes several moments for you to realize it when the basilisk steps away from you. You are free of his spell! Except... you can't move. You are standing there, gazing into nothing, and you can't move. You can feel your arms and legs and the breeze on your skin, but the ability to do anything with them is simply not there; it's as if the nerve connections have been severed, leaving you utterly paralyzed. The most you can manage is a raspy half-moan through your still throat. You can't even follow the basilisk with your eyes; although you can feel it; it gives you cause to moan again.\n\n", false);
			//Undo slow to determine if bad end time
			if (player.findStatusEffect(StatusEffects.BasiliskSlow) >= 0) {
				player.spe += player.statusEffectv1(StatusEffects.BasiliskSlow);
				mainView.statsView.showStatUp( 'spe' );
				// speUp.visible = true;
				// speDown.visible = false;
				player.removeStatusEffect(StatusEffects.BasiliskSlow);
			}
			dynStats("spe", player.findPerk(PerkLib.BasiliskResistance) < 0 ? 3 : 1, "lus", 399);
			//Bad end
			if (player.spe < 5 && player.findPerk(PerkLib.BasiliskResistance) < 0) {
				basiliskBadEnd();
				return;
			}
			//choose between loss rapes
			if (player.hasVagina() && (player.inHeat || player.findPerk(PerkLib.Oviposition) >= 0 || player.findPerk(PerkLib.BasiliskWomb) >= 0 || player.pregnancyType == PregnancyStore.PREGNANCY_OVIELIXIR_EGGS))
				basiliskHasVagEggStuff();
			else defaultBasiliskRape();
		}
		//Loss, vag rape conditions not met:
		private function defaultBasiliskRape():void {
			outputText("Working briskly, the basilisk tears off your " + player.armorName + " until you are entirely naked. He then rummages through your pockets; it carelessly discards everything it finds without apparent interest. He grabs a handful of gems from your purse and then prowls back to you.\n\n", false);
		
			//Male/Herm: 
			if (player.hasCock()) {
				outputText("With surprising gentleness and deftness, the basilisk rubs your " + player.cockDescript(0) + " with one palm", false);
				if (player.hasVagina()) outputText(" and sticks some of the smaller fingers of his other hand in your " + player.vaginaDescript(0), false);
				outputText(", thankfully angling his sickle claw away. You can't do anything against it, and some of his mental compulsion remains; a backwash of erotic images from your past fill your head, and you can't even grit your teeth as the gentle, insistent pressure brushing your prick makes you rock hard. He stops when you are erect and then, with the very faintest of smiles playing over his cruel mouth, leaves. You're naked, your " + player.cockDescript(0) + " is begging for release; you're utterly helpless... you can only hope that the spell will wear off, and before anything else in the mountain finds you.\n\n", false);
			}
			//Female: 
			else if (player.hasVagina()) {
				outputText("With surprising gentleness and deftness, the basilisk slips the smaller fingers of one hand into your " + player.vaginaDescript(0) + ", and carefully flicks at your " + player.clitDescript() + " with the other, thankfully holding his sickle claws away from you. You can't do anything against it, and some of his mental compulsion remains; a backwash of erotic images from your past fill your head, and you can't even grit your teeth as the gentle, insistent caresses make you wet. He stops when you are beading moisture involuntarily onto his hand and then, with the very faintest of smiles playing over his cruel mouth, leaves. You're naked, your " + player.vaginaDescript(0) + " begs to be filled; you're utterly helpless. You can only hope that his spell will wear off, and before anything else in the mountain finds you...\n\n", false);
			}
			//Genderless: 
			else outputText("Staring into your eyes, the basilisk moves his smaller fingers onto your groin... and then stops. He looks downwards, and then back into your face. You aren't very good at reading lizard facial expressions, but the creature looks distinctly baffled. Finally with a slight shake of his head, it slowly turns and leaves. He has left you paralyzed and naked to the open air, your skin prickling from the exposure. You can only hope that his spell will wear off, and before anything else in the mountain finds you...\n\n", false);
		
			//More to go here?
			var scene:Number = rand(5);
			if (scene == 0) basiliskAdvantageNobody();
			else if (scene == 1) basiliskAdvantageHarpy();
			else if (scene == 2) basiliskAdvantageImp();
			else if (scene == 3) basiliskAdvantageGoblin();
			else basiliskAdvantageMinotaur();
			//INSERT OPTIONAL OTHER MONSTER FINDINGS!
			player.orgasm();
			dynStats("sen", 1);
			combat.cleanupAfterCombat();
		}
		//basilisk vag rape
		//Requires: Player has vag and is in heat, currently has egg pregnancy, or has oviposition perk
		private function basiliskHasVagEggStuff():void {
			spriteSelect(75);
			player.slimeFeed();
			outputText("The basilisk is breathing heavily as he tears your " + player.armorName + " from your body, his warm exhalations rolling over your naked flesh. He seems to be having difficulty controlling himself; from your frozen gaze you can see it constantly shifting his dreadful slit eyes back to your frame as he searches through your pockets with claws that tremble. Eventually it throws down your attire and stares back into your eyes. There is something else in there now; a pulsing lust, hints of red at the edges of that great, grey sea, a rapacious tide gathering. You wish you could look away but there is more chance of you moving mountains.", false);
			//(Heat: 
			if (player.inHeat) outputText(" You are more aware than ever of an invisible scent simmering off you, of your wet vagina clenching and wetting itself in anticipation, your body begging this male creature to fulfil his genetic objective upon you. Your eyes have betrayed you, your body is betraying you, and whatever else you are is a tiny, ignored voice screaming in between.", false);
			outputText(" The basilisk suddenly breaks away and kneels down in front of you. Out of sight of your petrified eyes you cannot see what it is doing; however a moment later, you can feel, as a warm, sticky sensation slavers over your abdomen.", false);
			//(egg preg:
			if (player.pregnancyIncubation > 1 && player.pregnancyType == PregnancyStore.PREGNANCY_OVIELIXIR_EGGS) outputText(" The basilisk licks your bulging belly hungrily, pushing against and testing for the eggs you are carrying. Your sensitive cargo shifts around under his hungry attention; you'd squirm, but that is, of course, impossible.", false);
			//(heat or perk:
			if (player.inHeat || player.findPerk(PerkLib.Oviposition) >= 0 || player.findPerk(PerkLib.BasiliskWomb) >= 0) outputText(" The basilisk licks your belly hungrily, his sticky tongue crawling like a warm tentacle across your sensitive underside. You'd squirm, but that is impossible. The creature is making you feel everything it is forcing upon you.", false);
			outputText("\n\n", false);
			
			outputText("The basilisk gets up and again stares back into your eyes and you feel his will press indomitably against your pliable mind. At the very edge of your vision, underneath the creature you can see a hint of shiny purple; the creature's cock has slid out of his genital slit. How long it is and what it looks like you cannot see, but as with another raspy moan you finally accept what is about to happen, there is no doubt you are going to get to know about it very personally.\n\n", false);
			
			outputText("The creature suddenly raps something out in his strange, dry tongue, and you feel something - something deep and red - flinch in your mind. Suddenly, you are wet, wetter than you've ever been, your pussy slavering so badly you can hear the pitter-patter of your juices hitting the ground beneath you. The basilisk says something else, more softly this time as he slides in close, his long claws reaching around to clutch your " + player.buttDescript() + ". With a kind of horror you feel your limbs move involuntarily, your arms reaching around the thing's thin, muscled back, your bottom half slackening until you are supported entirely by the wiry strength of the lizard. You expose your crotch in complete submission as the basilisk walks forward, and you feel the head of his cock teasingly touch your dripping, treasonous cunt. As soon as your limbs are where it wants them to be, they lock in position again; you heave at them desperately, but once again your ability to do anything with your own body is simply not there. You are less of a statue and more of a fuck toy, an extension of the basilisk's lust-maddened will. Your jailer keeps walking until you feel the rough surface of a boulder against your back, and using this support the basilisk pushes itself straight into your " + player.vaginaDescript(0) + ".", false);
			player.cuntChange(monster.cockArea(0),true,true,false);
			outputText("\n\n", false);
			
			outputText("Once it has you pinioned, the uncontrollable rut your body has instilled in the basilisk really takes hold and it begins thrusting against you with abandon, his long, thin reptilian cock sliding in and out of your eager, slavering cunt, his hot breath pushing against your face and shoulders. ", false);
			//<(Tight: 
			if (player.looseness() < 4) outputText("Though it is not girthy, it is a perfect fit for your tight hole, and his long length coupled with your drawn up position has you panting as he touches your deepest, most sensitive depths.", false);
			//(Loose: 
			else outputText("At first the sensation is not great, his thin penis quickly lost in your vast, accommodating twat, but then, in between breaths, the basilisk barks out more harsh words. Once again you feel that helpless, red flex in your mind, and suddenly your vagina tightens around it, beginning to eagerly milk the reptile. You desperately wish it didn't and at the same time are hopelessly glad it did; the sensation of your walls pushing and pulling the long, smooth prick in loving synchronisation is unbearably pleasurable.", false);
			outputText(" The rock wall the basilisk is fucking you against grates your back and ass and, lost in his daze the creature's claws dig into your flesh, but these discomforts only serve to heighten the pleasure the creature is forcing you to feel. Its hard stomach beats a steady rhythm against your own as you slather his thighs and crotch with girl cum with the first of many involuntary orgasms, your " + player.clitDescript() + " twitching eagerly for more.\n\n", false);
		
			outputText("The basilisk's rut means it cannot last as long as your hormones crave; although it must have been having his way with you for at least half an hour, it seems all too soon to your supine body when the creature tenses against you, throws his snub head back and with a harsh, dry call begins to fuck you for all it is worth, slamming your paralyzed frame again and again into the rock wall until you feel bruised and dizzy, before it tenses and pours itself into you. You feel warmth spread through you as basilisk jizz floods through your cervix and womb, and you reaching a final bone-tingling plateau of pleasure, made all the more intense by the fact you cannot writhe or cry out; everything is locked up inside of you.\n\n", false); 
		
			outputText("The basilisk collects itself against you while his penis drools its last, sliding his abdomen up and down your body, apparently enjoying the feeling of your soft skin against his own leathery hide- or maybe just enjoying the fact you can't do anything about it. Eventually however he withdraws from your womanhood, trailing your mingled fluids as he goes. He steps languidly back, looks into your eyes with dopey, post-coital satisfaction, and then licks your face with long, tender strokes with his sticky tongue. Again, whether it does this through affection or simply because it can, you can't fathom; you suppose, as you mutely accept the wet, ticklish saliva being lavished all over your face, it doesn't make much difference from where you're standing.\n\n", false); 
		
			outputText("Finally, it whispers something dryly. You were very much hoping that it would let you go once it had taken his pleasure, but that is evidently not the case. It makes you stand still, as you were before; you feel his seed trickle down your leg as your body is guided to attention. He hisses one final afterthought to you, and then leaves, a certain swagger in his stalking gait. Once again, you are petrified, naked, utterly helpless. A backwash of erotic images from your past involuntarily rise up and assault your senses...\n\n", false);
		
			outputText("After about an hour of being forced to stand still and savor your own shameful memories, you find with great relief you can begin to move your toe again. Hard part's over, now. Eventually with some effort you manage to work power into each corner of your body and finally shake free of the basilisk's curse; quickly, you rub the remnants of sticky saliva off your face and redress before anything else finds you, before groggily picking your way back to camp. The cum still oozing from your quim and the occasional twinging memory mean that you aren't going to be able to shake free of the experience as easily as you'd like.", false);
			//(preg check, or change preg to basilisk if egg)
			player.knockUp(PregnancyStore.PREGNANCY_BASILISK, PregnancyStore.INCUBATION_BASILISK);
			//Egg change - 100% chance
			if (player.pregnancyType == PregnancyStore.PREGNANCY_OVIELIXIR_EGGS) {
				outputText("\n\nYour womb gurgles and you instinctively put a hand on your belly. It seems larger than it usually is, and you feel oddly more tender and motherly than normal. You shake your head at the thought. Damn hormones.", false);
				player.knockUpForce(PregnancyStore.PREGNANCY_BASILISK, PregnancyStore.INCUBATION_BASILISK - 150); //Convert Ovi Elixir eggs to Basilisk eggs
			}
			//Eggs fertilised (Ovi Potion/Oviposition only. Eggs take a few days 
			//longer to be laid than usual): 
			player.orgasm();
			dynStats("sen", 1);
			combat.cleanupAfterCombat();
		}
		
		public function basiliskBirth():void {
			spriteSelect(75);
			outputText("\n");
			if (player.vaginas.length == 0) {
				outputText("You feel a terrible pressure in your groin... then an incredible pain accompanied by the rending of flesh. <b>You look down and behold a new vagina</b>.\n\n", false);
				player.createVagina();
				player.genderCheck();
			}
			if (player.findPerk(PerkLib.BasiliskWomb) >= 0) {
				outputText("\nA sudden pressure in your belly wakes you, making you moan softly in pain as you feel your womb rippling and squeezing, the walls contracting around the ripe eggs inside you. You drag yourself from your bedding, divesting yourself of your lower clothes and staggering out into the middle of the camp. Squatting upright, you inhale deeply and start to concentrate.");
				outputText("\n\nA thick, green slime begins to flow from your stretched netherlips, splatting wetly onto the ground below you and quickly soaking into the dry earth. You settle easily into the rhythm of oushing with your contractions and breathing deeply when they ebb. The eggs inside you move quickly, lubricated by the strange slime that cushioned them in your womb, sized and shaped just right the pressure of their passage stretches you in the most delightful way, your [clit] growing erect");
				if (player.hasCock()) outputText(" and [eachCock] starting to leak pre-cum");
				outputText(" as you find yourself being moved to climax by the birthing. You see no point in resisting and reach down to begin fiddling with yourself, moaning in pain-spiked pleasure as the stimulus overwhelms you. With an orgasmic cry, you release your eggs into the world amidst a gush of femcum");
				if (player.hasCock()) outputText(" and a downpour of hermcum");
				outputText(".");
				
				outputText("\n\nWhen you find yourself able to stand, you examine what it is you have birthed; ");
				//(eggNumber) 
				outputText(num2Text(Math.floor(player.totalFertility() / 10)));
				outputText(" large, jade-colored eggs, the unmistakable shape of reptile eggs. You pick up one and hold it gently against your ear; inside, you can hear a little heart, beating strong and quick. You put it down carefully with his fellows and stare at your clutch, a queasy tangle of emotions tugging at you.");
		
				//First time:
				if (flags[kFLAGS.BENOIT_EGGS] + flags[kFLAGS.BENOIT_GENERIC_EGGS] == 0) {
					//[Have not laid generic basilisk eggs before, have not laid Benoit's eggs: 
					outputText("\n\nThe seconds drag by and the eggs remain still- the vague hope you harbor that they will immediately hatch, mature and get out of your life slowly vanishes. What are you going to do with them? The only thing you can think of is to take them to Benoit. Although you feel a slight tingle of shame for approaching him like this, you can't think of anyone else who would know what to do with these odd, unborn children of yours.");
				}
				//[Have laid Benoit's eggs: 
				else {
					outputText("The seconds drag by and the eggs remain still. Although you don't like to admit it, you had entertained the soft illusion that the eggs you sired with Benoit were special somehow; the cold fact of the ones in front of you tell you that that is not the case, that the ones forced upon your transformed womb by the mountain basilisks are functionally the same as the ones you have with him. The thought sends a tight shiver up your spine, and you deliberately turn away from it to think of Benoit. You suppose you'll have to take these to him, too. Although you feel a slight tingle of shame for approaching him like this, you can't think of anyone else who would know what to do with these odd, unborn children of yours.");
					outputText("\n\nYou place the egg back down and gather them all up, moving them closer to the campfire to stay warm while you recover from your exertions.");
				}
				
				outputText("\n\nThere is nothing else to be done: you will have to take this batch to Benoit");
				if (flags[kFLAGS.BENOIT_EGGS] > 0) outputText(" as well");
				outputText(". You place the egg back down and gather them all up, moving them closer to the campfire to stay warm while you recover from your exertions.");
				outputText("\n\nWhen the light of day breaks, you gather your newly laid clutch and set off for Benoit's shop. The blind basilisk is asleep when you arrive, forcing you to bang loudly on his door to wake him up.");
				outputText("\n\n\"<i>What is it?!</i>\" He snarls, displaying his fangs when he pops his head irritably out of the door. He stops and inhales through his nose, blushing faintly when he recognizes your scent. \"<i>Oops! [name], I am zo sorry, I did not think it would be you. But why are you here at such an early hour?</i>\"");
				//First Time:  
				if (flags[kFLAGS.BENOIT_GENERIC_EGGS] == 0) {
					outputText("\n\nApprehensively, you explain the situation - you were caught unawares by a basilisk in the mountains, and then... you put an egg into his hand to feel. Benoit is silent for a time, his claws rubbing pensively over the smooth surface.");
					outputText("\n\n“I see,” he says heavily. \"<i>No, you were right to bring zem ere. Zey will be safe with me and 'ell knows I will need all ze eggs I can get if I am to make zis work.</i>\" You breathe an inward sigh of relief and follow him into his shop.");
					if (flags[kFLAGS.BENOIT_EGGS] + flags[kFLAGS.BENOIT_GENERIC_EGGS] == 0) {
						outputText("\n\nHe feels around the clutter of his store room until he finds what he's looking for: A battered old basket stuffed with a soft pillow. You raise an eyebrow at the liberal amounts of dog hair the pillow is covered with and Benoit coughs apologetically.");
						outputText("\n\n“E isn't 'appy about me taking is bed, but to 'ell wizzim; e always gets is 'air on everysing anyway.” You spend some time arranging the eggs where they will be safe and warm. Although you know they can't be, Benoit's blind eyes seem to be fixed upon the brood when you have finished.");
						outputText("\n\n“And zese eggs are different?” he says hesitantly. “Zere will be...little girls?” You shrug and say even if they aren't female, at least he'll have some sons he can keep away from the mountain. He sets his jaw and nods.");
					}
					//[Not first time: 
					else {
						outputText("\n\nBenoit places the eggs into a blanket-swaddled basket with the same painstaking care he did with the others, before turning back to you.");
						outputText("\n\nThe blind basilisk reaches out, finds your hand, and then squeezes it. \"<i>[name], you must be more careful in ze future,</i>\" he says. \"<i>Please understand I am not saying zis because I am jealous or angry or anysing so zilly. You 'ave done a great sing to change your body to 'elp my people, but if you keep getting attacked by my bruzzers and zey find out... if zey work out what you are... I do not like to sink about it.</i>\" You tell him you'll be more on guard in the future and he seems to accept this. He gestures to the corner where he has put together a serviceable stove from scrap.");
						outputText("\n\n“<i>'Ungry?</i>”");
						outputText("\n\nYou linger long enough to share breakfast with him, and then return to camp.");
					}
				}
				//Subsequent: Sheepishly, you give him an egg to feel.  Benoit shakes his head in exasperation, but lets you in.
				else outputText("\n\nHe puts your latest batch with the others and then shares breakfast with you. You leave with his final words lingering in your ears: “More eggs is always good [name], but for ze Gods sake: Be. More. Careful.”");
				outputText("\n");
				flags[kFLAGS.BENOIT_GENERIC_EGGS] += Math.floor(player.totalFertility() / 10);
			}
			else {
				outputText("A sudden shift in the weight of your pregnant belly staggers you, dropping you to your knees. You realize something is about to be birthed, and you shed your " + player.armorName + " before it can be ruined by what's coming. A contraction pushes violently through your midsection, stretching your " + player.vaginaDescript() + " painfully, the lips opening wide as something begins sliding down your passage. A burst of green slime soaks the ground below as the birthing begins in earnest, and the rounded surface of a strangely colored egg peaks between your lips. You push hard and the large egg pops free at last, making you sigh with relief as it drops into the pool of slime.", false);
				player.cuntChange(20,true,true,false);
				outputText(" The experience definitely turns you on, and you feel your clit growing free of its hood as another big egg starts working its way down your birth canal, rubbing your sensitive vaginal walls pleasurably. You pant and moan as the contractions stretch you tightly around the next, slowly forcing it out between your nether-lips. The sound of a gasp startles you as it pops free, until you realize it was your own voice responding to the sudden pressure and pleasure. Aroused beyond reasonable measure, you begin to masturbate your clit, stroking it up and down between your slime-lubed thumb and fore-finger. It twitches and pulses with your heartbeats, the incredible sensitivity of it overloading your fragile mind with waves of pleasure. You cum hard, the big eggs each making your cunt gape wide just before popping free. You slump down, nervous and barely conscious from the force of the orgasm.\n\n", false);
				player.orgasm();
				dynStats("sen", 2);
			
				outputText("You slowly drag yourself into a sitting position, mind still simmering with bliss, and take in the clutch that you have laid. They seem taller and more oblong than other eggs you've seen and they are a strange color: a mottled grey-green. Where have you seen that shade of green before...? A memory rises unbidden to you and you put your hand to your mouth. At the same moment as realization takes hold, a thin papercut line appears in the largest of your eggs. You hunch yourself up and watch in wonder as the cracks spread until, with a final, insistent push, a tiny reptilian face pops out of the shell. It blinks albumen from its rheumy eyes and then, with an infant's awkward industriousness, begins to peel and push its way out of its shell. It trails slime as it crawls forward like a salamander, blinking its big, wide eyes uncertainly, attempting to take in the very large world it has found itself in. Behind it a small cacophony of cracking and wet splintering fills the air as your other children begin to tentatively push their way into existence.\n\n", false);
			
				outputText("In front of you finally are a dozen newly hatched basilisks, crawling around on all fours, the wetness of their eggs slowly drying on their scales, licking each other, flicking their long tails around and blinking at their surroundings with eyes huge in their tiny heads as interest in the wider world takes hold. You can't say whether you find the sight insanely cute or utterly disgusting, and you don't know whether the reason you can't look away is because you are fascinated by the creatures you have brought into this world, or because of the effect of twenty four baby basilisk eyes on you. You suspect in either case the answer is a bit of both.\n\n", false);
			
				outputText("They seem to quickly adapt to where they have found themselves, running around each other with increasing confidence, and you can see even in the short time you have been watching they have grown, their tender scales hardening as the sun and air beats down on them. One of them suddenly scuttles like the lizard it is for cover, and you lose it from view underneath a rock. They are quickly all at it, one after the other dashing and slipping from view. The last to go is the largest, the first to hatch: it fixes you with its stare before slowly turning and following suit. You could swear it gives you the smallest of smiles, a child's eager grin, before it goes. The only evidence you have left of what just happened is a slimy pile of discarded egg shells.\n\n", false);
			
				if (player.cor < 33) outputText("You find yourself shaken by the experience, and deeply disquieted by the thought of the clutch of monsters you have unleashed on this world. You pick yourself up, rub yourself down and leave, promising yourself fervently you'll be more careful around basilisks in the future.\n\n", false);
				else if (player.cor < 66) outputText("You pick yourself up, rub yourself down and leave. You feel conflicted about what just happened; on the one hand you feel disquieted about the dozen monsters you just unleashed on this world, on the other you cannot help feel oddly proud of them and yourself.\n\n", false);
				else outputText("With a soft smile, you get up and leave, enjoying the sensation of green slime trickling down your legs. You cannot wait to get pregnant again, for your stomach to bulge with eggs, to release more delightful creatures into this world which can grow up to fuck you and everyone else in turn, so everyone can enjoy life as much as you do.", false);
			}
			outputText("\n", false);
		}
		
		//basilisk Bad End
		//Requires: Lose to basilisk when Speed is less than 5 (changed from 15 to prevent level 1 gameover -Z)
		private function basiliskBadEnd():void {
			spriteSelect(75);
			clearOutput();
			outputText("Moving has become intensely difficult. You cannot explain why something that came naturally to you ten minutes ago is now like wading neck deep through quicksand, but that is what moving your limbs now feels like. With a huge, straining amount of effort, you desperately raise your arms and crane your neck away from the basilisk as he now approaches you, but with a pathetic amount of ease the creature slides through your guard, grabs you by the chin and looks directly into your eyes. Your reactions are so slow your mind's screaming order for your eyelids to close takes several seconds for your nerves to compute, by which time it is far too late.\n\n", false);
		
			outputText("You stare deep into the creature's eyes. There really is an infinity in there, a grey fractal abyss which spirals upwards and downwards forever. You want nothing more than to spend the rest of your life following it... you fall into that endless abyss for what seems like years, decades, uncharted aeons. You lose all sense of yourself, your situation, your purpose; you do not feel the tips of your fingers slowly turning cold and grey, rivulets of the texture advancing slowly up your hand, any more than you notice the turn of a planet a thousand light years away. There is only the wet grey, and you, an infinitesimally tiny speck lost in a universe, a universe that knows, sees, and controls. When the basilisk's pupils dilate, and you feel its hypnotic compulsion press upon your mind, you can no sooner resist him than a tadpole can an endless, grey waterfall. When he demands that you be horny, you cannot disobey him any more than you can disobey gravity. You are submerged in a sea of sex.", false);
			if (player.gender == 3) outputText(" You moan through your still throat as you feel blood rushing to your groin, your " + player.multiCockDescriptLight() + " stiffening and your " + player.vaginaDescript(0) + " beginning to drip.", false);
			if (player.gender == 1) outputText(" You moan through your still throat as you feel blood rushing to your groin, your " + player.multiCockDescriptLight() + " stiffening.", false);
			if (player.gender == 2) outputText(" You moan through your still throat as you feel blood rushing to your groin, your " + player.vaginaDescript(0) + " beginning to drip.", false);
			outputText(" Every erotic thing that has ever happened to you crowds your head, a dozen sexual sensations are forced upon your senses, and you feel yourself helplessly pushed, fucked, inundated towards an incredible, glorious orgasm...\n\n", false);
		
			outputText("It suddenly stops. The basilisk steps away from you, and you can think again. Except... oh Gods... you still feel incredibly, unbearably horny. You must come! You try to manually push yourself over the edge... you can't. You can't move, you are perched on the brink of a world-shaking orgasm, and... you stare out at the world in mute horror as realization sinks in. In front of you, the basilisk moves its head this way and that, taking you in, admiring its handiwork with an artist's eye before stroking a claw down your arm. You can't feel it, because it, along with the rest of your body, has turned to stone. The creature has petrified you. You can still see, hear, and think- but the only thing you can feel is what is inside you, and what is inside is your body hovering over the very point of sexual release. You can't stand it. You can't stand it for a second longer, and surely the basilisk won't... a smirk appears on his cold, regal face and it bows mockingly, before departing with a flick of his tail. You watch it go with stone eyes, frozen in incredible torment. You really, really wish you could scream.\n\n", false);
		
			outputText("Hours go by. Night begins to fall. You get very used to what you can see in your direct line of vision. You wish you could say you get just as used to the sensation of being trapped on the edge of orgasm, but you don't. Every particle of your body screams for release, the overwhelming sensation drowns any thought you have, and you realize if this lasts much longer you will go insane. By the time the stars start to come out you are bargaining with every deity who might be listening- <i>get me out of this fix, and I will do anything, anything, for whoever saves me. I will be a demon's slave, I will stop drinking so much, I will actually concentrate on saving the world... anything.</i> It is as you are beseeching the heavens in this way for the tenth time that you hear footsteps behind you. Somebody has come for you! It has to be someone who can help you, somebody who cares about you, it HAS to be.\n\n", false);
		
			outputText("A pale blue finger traces the line of your frozen chin before a leering, female face swallows up your line of vision. \"<i>Well, well, well. Look at what we have here,</i>\" purrs the succubus into your cold, marble ear. Other shapes prowl into view, stalking reptile shapes, as the demon runs her hands sensually over your form, testing every smooth surface, protuberance and cranny that she can reach. You cannot feel a thing, except an overwhelming sense of dread. \"<i>Played with the lizards a bit too much did we, friend? I hope you learnt your lesson. It's a real shame, when you think about it.</i>\" The succubus actually sounds almost upset as she looks you over. \"<i>You would have made a fine slave. The things we would have done to you... ah well. Que sera sera. Remove this!</i>\" she straightens up smartly and claps her hands. \"<i>Take this statue to Lethice's castle. I am sure it will look excellent in her front hall, and I know she will appreciate the present.</i>\" The basilisks snake up to you and then heave you into their arms. As they haul you into the night, the succubus's voice reaches you. \"<i>Did you know that marble is a metamorphic rock, statue? It takes tens of thousands of years to wear down. Meta-MORPH-ic, get it? Hahahahahaha!</i>\"\n\n", false);
		
			outputText("You have no voice, and you must scream.", false);
			getGame().gameOver();
		}
		//Defeated, Taken Advantage of: nobody
		private function basiliskAdvantageNobody():void {
			spriteSelect(75);
			outputText("Time stretches by at an agonizingly slow pace as you stand there, a bizarre, motionless flesh statue. You have no way of measuring how much time is passing; the sun is not in your direct line of vision.  You try to move any and every part of yourself in turn, but it is hopeless. Your body is a cage, and you begin to hate the basilisk less because it paralyzed you and more because it left your mind entirely aware of it. Every so often another unbidden backwash of erotic memories overwhelms your senses, keeping you helplessly aroused and reminded of who did this to you. Coupled with the unscratchable itches and the aching in your limbs the experience is one of sensational hell.\n\n", false);
		
			outputText("Eventually, and with gushing, overwhelming joy, you find you can with effort move one of your little fingers again. Concentrating hard, you move backwards from there until you can move your hand, your other fingers, your arm, and then, with a creaking finality, you break entirely free of the paralyzing spell. You spend the next few minutes scratching and touching yourself all over with cries of deepest relief, before putting your garments back on and staggering slowly towards camp. You suppose you should count yourself lucky that nothing found you whilst you were in your incredibly vulnerable state, but you struggle to think of yourself as lucky as you reflect soberly on the last couple of hours.", false);
		}
		//Defeated, Taken Advantage of: Imp
		private function basiliskAdvantageImp():void {
			outputText("Time stretches by at an agonizingly slow pace as you stand there, a bizarre, motionless flesh statue. You have no way of measuring how much time is passing; the sun is not in your direct line of vision.  You try to move any and every part of yourself in turn, but it is hopeless. Your body is a cage, and you begin to hate the basilisk less because it paralyzed you and more because it left your mind entirely aware of it. Every so often another unbidden backwash of erotic memories overwhelms your senses, keeping you helplessly aroused and reminded of who did this to you.\n\n", false);
			
			outputText("You hear a whirring of small wings behind you and something lands on your shoulder. You feel a weary despondency as you guess what it is, right before a reedy, sneering voice speaks into your ear. \"<i>Well, well, well... ain't I the luckiest imp in Mareth?</i>\"\n\n", false);
		
			outputText("The evil little creature wastes no time. Crawling around your motionless face until he is braced against your shoulders and clutching tightly onto your " + player.hairDescript() + ", the imp begins to rub his cock against your cheeks and lips, smearing you with his pre-cum and filling your nose with the smell of it. You will every piece of your strength into moving your arm and batting the creature away, but your body refuses to comply; frozen as you are, you are merely a sex doll to the imp's twisted desires. His cock swiftly grows as he rubs it against your flesh, until it is almost as big as the imp himself, and then with a grunt he pushes against your slightly open mouth.\n\n", false);
		
			outputText("As you suffer this indignity you cling to the hope that your paralysis will prevent the imp from pushing into your mouth, but it quickly becomes apparent that won't be the case. Upon being touched by another creature's forceful desire, of its own will your mouth opens and engulfs the imp's hot, pulsing length. The demon slowly feeds himself in until he is touching the back of your throat, and then begins to thrust himself against you lustily, pulling painfully against your " + player.hairDescript() + " as he does so. You wish you weren't getting turned on about this situation, but you are. You feel another unbidden mental bubble rise up through your mind, old sin and flesh flooding your memory, which coupled with the imp's scent sends blood rushing towards your ignored, stricken groin.\n\n", false);
		
			outputText("You can't pleasure the imp in any way but he doesn't seem to mind; he rubs against your still tongue and cheeks as he pushes into your throat, picking up the pace, his balls slapping against your chin. Eventually with a satisfied, guttural sound he reaches his peak. The giant cock filling your mouth swells and explodes, pushing jet after jet of demonic seed down your gullet. When the imp finally pulls himself out, rivulets of cum dribbles out of your mouth; you feel the tainted substance slowly dripping down your face and onto your front, incapable of doing anything about it. The imp takes the time to fly out in front of you to admire his handiwork, then with an evil grin departs, looking very pleased with himself. You are left to helplessly savor the flavor he has left in your mouth.\n\n", false);
		
			outputText("After what seems like many hours later, you find with a sense of overwhelming relief you can move one of your little fingers again. Concentrating hard, you move backwards from there until you can move your hand, your other fingers, your arm, and then, with a creaking finality, you break entirely free of the paralyzing spell. The first thing you do is wipe the cum off your face and body and urgently wash your mouth out with a nearby spring; but you can feel the creature's warm jizz sloshing deep within you and you know the damage is done. You woozily put your clothes back on and stagger back towards camp.", false);
			//(standard imp cum corruption gain, set lust to 100)
			dynStats("cor", 1);
			player.slimeFeed();
		}
		//Defeated, Taken Advantage of: harpy
		private function basiliskAdvantageHarpy():void {
			spriteSelect(75);
			outputText("Time stretches by at an agonizingly slow pace as you stand there, a bizarre, motionless flesh statue. You have no way of measuring how much time is passing; the sun is not in your direct line of vision.  You try to move any and every part of yourself in turn, but it is hopeless. Your body is a cage, and you begin to hate the basilisk less because it paralyzed you and more because it left your mind entirely aware of it. Every so often another unbidden backwash of erotic memories overwhelms your senses, keeping you helplessly aroused and reminded of who did this to you. Coupled with the unscratchable itches and the aching in your limbs the experience is one of sensational hell.\n\n", false);
			outputText("You hear a shrill cry from above you, half eagle scream and half mocking, female laughter. With a fluttering flap of feathers, a harpy lands at your side before proceeding to stalk around you, taking in your helpless, frozen form with stiff, jerky movements. You reflect bitterly that if the big bottomed bird woman had turned up fifteen minutes ago she would probably have scared the basilisk off. As it is, you are going to have to take whatever she can throw at you... with a stiff upper lip, as it were.\n\n", false);
				
			//Male/Herm: 
			if (player.hasCock()) {
				outputText("The harpy's eyes zero in on your erect cock greedily. Stepping back from you she raises her head and lets out a screech which echoes around the mountains; as answering calls roll back to her she closes in, threads her arms around your neck and scalp and kisses you roughly. She pushes her golden lips against yours and squeezes her rough bird tongue into your mouth. You feel your lips tingle and you raggedly moan against the savage frenching, her hot breath pushing down your throat as she circles your still tongue with her own, before exploring further down towards your tonsils. By the time she has finished with you your whole body feels like it is glowing red from the effect of her lipstick, " + player.sMultiCockDesc() + " straining.\n\n", false);
		
				outputText("You wonder vaguely how she and her no-doubt-soon-to-arrive sisters are going to take advantage of you as you are; you find out a moment later when with no preamble whatsoever the harpy shoves you roughly in the chest. ", false);
				if (player.isBiped()) outputText("You teeter horribly on your frozen heels for a moment and then fall onto your back like a collapsing statue. ", false);
				else outputText("You feel yourself slowly and horribly lose your balance before flopping onto your side like a collapsing statue. ", false);
				outputText("Unable to brace yourself, you bang your head painfully; as you are lying there dazed, you feel something build at the back of your mind. Involuntary sensations prickle your skin and groin as, once again, the intermittent mental backwash that the basilisk's hypnosis has forced upon your mind hits you. Memory after memory of sexually-charged encounters, daydreams or fantasies crowd your consciousness. It is made worse, much worse by the pheromones the harpy has pushed into your mouth; your body rides the chemical glow at the same time as imaginings of soft skin, tight muscle and musk overload your senses. You groan raggedly as " + player.sMultiCockDesc() + " bulges and leaks pre-cum, almost screaming for attention. When you finally, woozily come to your senses, you find that all vision has been blotted out by a big, wobbly harpy bum, her moistening lips rubbing impatiently against your mouth.\n\n", false);
		
				outputText("The bang on the head you took, the harpy lipsticks trilling in your bloodstream and the involuntary tide of erotic memories which ebbs and flows over you mean the next couple of hours goes by for you in a haze of forceful sex. You can't control your cock", false);
				if (player.cockTotal() > 1) outputText("s", false);
				outputText(", your sex drive or what you are thinking about; you are a prisoner of lust and you quickly subside under the sexual concussion, hoping eventually the harpies and your own body will stop fucking you. It does sink in around your second involuntary orgasm, your aching " + player.cockDescript(0) + " spurting ribbon after ribbon of jizz into a harpy's clenching warmth, that the two arriving harpies are not happy with the first one; with your mouth and hands frozen you can't pleasure them with anything but your manhood, which leaves two of them fighting each other for time with your groin whilst a third grinds frustratedly at your face, mainly using your nose to rub at her inner walls and clit, forcing her juices down your nostrils and making you cough raggedly, struggling to breathe.\n\n", false);
		
				//Single cock: 
				if (player.cockTotal() == 1) outputText("Their inability to properly satisfy themselves on your frame raises their tempers and frustration to the point where the three of them are physically fighting each other, treading all over you as they scream, bite and tear, their feathers flying all over the place. Eventually the biggest of the trio drives the other two off, flapping and screeching into the mountains, before throwing herself onto her scratched and battered prize, her eyes lit up and wild. She fucks you with a gusto born of bloodlust, her petit breasts bouncing up and down as she slams her powerful thighs into your " + player.hipDescript() + ", picking up the pace. She quickly forces you to another achingly pleasurable peak, your " + player.cockDescript(0) + " spurting more of your seed deep into her, and then just keeps on working you. Your cock seems incapable of going soft. You feel the involuntary erotic backwash build in your skull again...\n\n", false);
				//Multicock: 
				else {
					outputText("The three of them do eventually work out a compromise however, once they discover you have more than one manpole to your name. One pulls your " + player.cockDescript(0) + " forwards painfully until it is almost pointing towards your face before squatting over it, whilst another clutches at your " + player.cockDescript(1) + " as she spreads her legs and works her way inwards until she is spearing herself on you. You can't see them - you can't see anything except pink wobbly flesh and lavender feathers - but you can hear them shift impatiently around each other as they find a position which is comfortable to them both, their inner walls rubbing you from every direction as they move. The third continues to thrust her needy sex into your face as best she can", false);
					if (player.cockTotal() >= 3) outputText(", crowded out by the bodies of the others despite her transparent desire for the unoccupied man meat flopping against them,", false);
					outputText(" as the other two begin to push and pull your cocks into them, their overcharged libidos taking hold. Your first cock feels like it is being pulled off your body at the same time as its end is being pumped; the sensation of being doubly and brutally fucked like this is unbearably pleasurable and with a series of ragged gasps you tumble helplessly over a sweat-beading peak, your two cocks spurting jizz deep into the two harpies. The third harpy coos as she feels your hot breath on her gaping vagina, and she begins to buck her frustrated sex against your face faster. Trapped in the harpies' clenching holes and incapable of going soft, your cocks continue to get worked as if nothing happened. You feel the involuntary erotic backwash build in your skull again and with a lost moan you fall comatose, incapable of even computing how fucked you are anymore.\n\n", false);
				}
		
				outputText("Eventually you notice that your dick is no longer trapped in sucking wet, and coming out of your daze you find yourself without harpy companions, leaving your petrified form in a mingled pool of harpy juices and your own jizz. After another ten or twenty minutes of being forced to lie there and marinate in your own shameful memories, you find with great relief you can begin to move your fingers again. Eventually with some effort you manage to work power into each corner of your body and finally shake free of the basilisk's curse; quickly, you pick yourself up and redress before anything else finds you and woozily begin to make your way back down the mountain. The whole experience feels like it may have been a lucid sex nightmare to your sluggish mind and you could almost believe it- if you didn't reek of sticky harpy sex and your own musk.", false);
				
				//(add harpy lipstick effect, add 20 fatigue and lose 100 lust if M/H, or add 100 lust if F/U)
				player.changeFatigue(20);
				kGAMECLASS.sophieScene.luststickApplication(20);
				player.orgasm();
			}
			//Female: 
			else if (player.hasVagina()) {
				spriteSelect(75);
				outputText("The harpy comes to a halt behind you and begins to eagerly run her cold but soft hands over your bottom half, stroking your thighs and squeezing your " + player.buttDescript() + " as if appraising a piece of meat. Whilst caressing your neck she runs her hands between your legs and grabs around your moistened delta impatiently, searching for something that isn't there. She lets loose a squawk of pure frustration and wheels around you to glare in your eyes angrily. The sex-crazed harridan is clearly deeply pissed off with you for lacking a cock she can abuse. She shifts her eyes to your mouth, but quickly arrives at the same conclusion you've already come to: unable to move your mouth, you can't even be forced to give oral pleasure. You feel a bizarre sense of triumph over the creature; you stare into space smugly as the harpy paces in front of you, glaring, thwarted but unwilling to give up her prize. Perhaps eventually she will leave you alone...?\n\n", false);
		
				outputText("The harpy suddenly closes in, threads her arms around your neck and scalp and kisses you roughly. She pushes her golden lips against yours and squeezes her rough bird tongue into your mouth. You feel your lips tingle and you raggedly moan against the savage frenching, her hot breath pushing down your throat as she circles your still tongue with her own, before exploring further down towards your tonsils. By the time she has finished with you your whole body feels like it is glowing red from the effect of her lipstick, and your " + player.vaginaDescript(0) + " is leaking moisture down your thigh. Maddeningly, the harpy ignores your needy sex and continues to stalk around you, a vengeful smirk changing to a thoughtful frown on her ferociously beautiful face. You wish you could thrust your vagina towards her, make her heed the plight of your lust-racked body; hell, you are even beginning to wish you could give her head so she would at least consider rewarding you...\n\n", false);
				
				outputText("You feel something build at the back of your mind. Involuntary sensations prickle your skin and inner walls as, once again, the intermittent mental backwash that the basilisk's hypnosis has forced upon your mind hits you. Memory after memory of sexually-charged encounters, daydreams or fantasies crowd your consciousness. It is made worse, much worse by the pheromones the harpy has pushed into your mouth; your body rides the chemical glow at the same time as imaginings of soft skin, tight muscle and musk overload your senses. Your " + player.vaginaDescript(0) + " flexes and drools fluid as your " + player.clitDescript() + " bulges with need, almost screaming for attention that it isn't going to get. The denial the petrification has forced upon you is unbearable.\n\n", false);
		
				outputText("It takes a long time for your mind and body to calm down enough for you to take in what's happening outside of your frozen form. There is an odd, wet, rubbery sensation on your hand, still raised in its futile attempt to ward the basilisk, and you feel pressure upon your shoulder. A harpy foot pushes into your face and you hear grunts of frustration mixed with the odd croon of satisfaction from somewhere slightly above you. You can't see exactly what she's doing but it doesn't take a genius to make an educated guess: braced against your upper body and using her wings to keep herself aloft, the harpy is using the only part of your body she can to take some measure of satisfaction from you. You feel your petrified fingers sliding up, down and around her large, egg-laying snatch as she manipulates her body as best she can, feet pushing into you impatiently. One finger hooks into her hole at the same time as another digit rubs against a soft nodule which can only be her clit; she coos at this sudden success and you feel her juices drip down your arm. She begins to pick up the pace, flapping her well padded behind against your hand eagerly, taking in more of your crooked fingers into her warm, accommodating cunt. Your own juices begin to build afresh as, with a sensation of deep apprehension, you feel the erotic backwash build again...\n\n", false);
		
				outputText("The harpy manages to cum twice on your hand, gobbling with excitement as she spatters your arm with her juices. During this time you are forced to ride the potent cocktail of hypnotic sexual compulsion and the pheromone lipstick again and again, until you feel you would have collapsed in a pool of steaming sex long ago if your knees allowed it. Once she is finished with you the harpy clambers down, taking care to wipe her leaking twat on your naked front as she does so, before flapping off with a winsome smirk, entirely ignoring your own achingly deprived sex.\n\n", false); 
		
				outputText("After another ten or twenty minutes of being forced to stand still and savor your own shameful memories, you find with great relief you can begin to move your fingers again. Eventually with some effort you manage to work power into each corner of your body and finally shake free of the basilisk's curse; quickly, you redress before anything else finds you and, still reeking of harpy sex, you begin to make your way back down the mountain. You think woozily that maybe you should consider yourself lucky that nothing actually fucked you whilst you were in your helpless state, but your body thinks the exact opposite, and you really, really need to get back to camp and sort yourself out.", false);
				dynStats("lus=", player.maxLust());
			}
			//Genderless: 
			else {
				outputText("The harpy comes to a halt behind you and begins to eagerly run her cold but soft hands over your bottom half, stroking your thighs and squeezing your " + player.buttDescript() + ", as if appraising a piece of meat. Whilst caressing your neck she runs her hands between your legs and grabs around your groin, searching for something that isn't there. She lets loose a squawk of pure frustration and wheels around you to glare in your eyes angrily. The sex-crazed harridan is clearly deeply irritated about finding such a helpless victim only to further discover they lack a cock which she can abuse. She shifts her eyes to your mouth, but quickly arrives at the same conclusion you've already come to: unable to move your mouth, you can't even be forced to give oral pleasure. You feel a bizarre sense of triumph over the creature; you stare into space smugly as the harpy paces in front of you, glaring, thwarted but unwilling to give up her prize. Perhaps eventually she will leave you alone...?\n\n", false);
		
				outputText("The harpy suddenly closes in, threads her arms around your neck and scalp and kisses you roughly. She pushes her golden lips against yours and squeezes her rough bird tongue into your mouth. You feel your lips tingle and you raggedly moan against the savage frenching, her hot breath pushing down your throat as she circles your still tongue with her own, before exploring further down towards your tonsils. By the time she has finished with you your whole body feels like it is glowing red from the effect of her lipstick. The harpy goes back to stalking around you, a vengeful smirk changing to a thoughtful frown on her ferociously beautiful face. Your body feels like it is pushing for a way to release the lust building up in you and finding no way out- you almost wish you did have a cock so the harpy would at least consider rewarding you...\n\n", false);
		
				outputText("You feel something build at the back of your mind. Involuntary sensations prickle your skin as, once again, the intermittent mental backwash that the basilisk's hypnosis has forced upon your mind hits you. Memory after memory of sexually-charged encounters, daydreams or fantasies crowd your consciousness. It is made worse, much worse by the pheromones the harpy has pushed into your mouth; your body rides the chemical glow at the same time as imaginings of soft skin, tight muscle and musk overload your senses. The denial the petrification has forced upon you is becoming unbearable.\n\n", false);
		
				outputText("It takes a long time for your mind and body to calm down enough for you to take in what's happening outside of your frozen form. There is an odd, wet, rubbery sensation on your hand, still raised in its futile attempt to ward the basilisk, and you feel pressure upon your shoulder. A harpy foot pushes into your face and you hear grunts of frustration mixed with the odd croon of satisfaction from somewhere slightly above you. You can't see exactly what she's doing but it doesn't take a genius to make an educated guess; braced against your upper body and using her wings to keep herself aloft, the harpy is using the only part of your body she can to take some measure of satisfaction from you. You feel your petrified fingers sliding up, down and around her large, egg-laying snatch as she manipulates her body as best she can, feet pushing into you impatiently. One finger hooks into her hole at the same time as another digit rubs against a soft nodule which can only be her clit; she screeches at this sudden success and you feel her juices drip down your arm. She begins to pick up the pace, flapping her well padded behind against your hand eagerly, taking in more of your crooked fingers into her warm, accommodating cunt. You groan as you feel the erotic backwash build again...\n\n", false);
		
				outputText("The harpy manages to cum twice on your hand, gobbling with excitement as she spatters your arm with her juices. During this time you are forced to ride the potent cocktail of hypnotic sexual compulsion and the harpy's golden lipstick again and again, until you feel you would have collapsed in a pool of steaming sex long ago if your knees would only allow it. Once she is finished with you the harpy clambers down, taking care to wipe her leaking twat on your naked front as she does so, before flapping off with a winsome smirk, entirely ignoring your own plight.\n\n", false);
		
				outputText("After another ten or twenty minutes of being forced to stand still and savor your own shameful memories, you find with great relief you can begin to move your fingers again. Eventually with some effort you manage to work power into each corner of your body and finally shake free of the basilisk's curse; quickly, you redress before anything else finds you and, still reeking of harpy sex, you begin to make your way back down the mountain. You think woozily that maybe you should consider yourself lucky that nothing actually fucked you whilst you were in your helpless state, but your body thinks the exact opposite, and you really, really need to get back to camp and sort yourself out.", false);
				dynStats("lus=", player.maxLust());
			}
		}
		//Defeated, Taken Advantage of: goblin
		private function basiliskAdvantageGoblin():void {
			spriteSelect(75);
			outputText("Time stretches by at an agonizingly slow pace as you stand there, a bizarre, motionless flesh statue. You have no way of measuring how much time is passing; the sun is not in your direct line of vision.  You try to move any and every part of yourself in turn, but it is hopeless. Your body is a cage, and you begin to hate the basilisk less because it paralyzed you and more because it left your mind entirely aware of it. Every so often another unbidden backwash of erotic memories overwhelms your senses, keeping you helplessly aroused and reminded of who did this to you.\n\n", false);
		
			//Male/Herm: 
			if (player.hasCock()) {
				outputText("At the corner of your vision, you see a small, familiar green shape hover into view. The goblin is so busy sorting through her inventory of drugs that you actually manage to see her before she sees you. When she does lift her head up and notices the petrified, naked individual in front of her, she is so surprised she drops her satchel.\n\n", false);
		
				outputText("\"<i>A " + player.race() + "!</i>\" she yelps. Then, after shifting her startled attention downwards, \"<i>A cock!</i>\" Hesitantly at first, then with increasing confidence as how vulnerable you are sinks in, she does a round circuit of you, taking in every angle of your frozen, helpless flesh.\n\n", false); 
				
				outputText("\"<i>Get caught with our pants down by a basilisk, did we, stud?</i>\" she purrs. \"<i>Well, not to worry. I'll take good care of you.</i>\" You somehow doubt her good intentions, and your suspicions are confirmed when, after completing her sauntering circumference of you, she shoves your bottom half as hard as she can. You fall slowly like a wooden board; being unable to brace yourself, the sensation of dropping is horrible, and, once your skull connects with the ground, painful. Before you can clear your swimming vision you feel the goblin's soft, dense weight on your chest, and then her eager lips upon yours, sucking and lavishing every inch of your frozen mouth that her tongue can reach. A tingling sensation spreads from your mouth downwards as her drug-laced lipstick takes effect. By the time she has finished with your mouth and worked her way downwards, your " + player.cockDescript(0) + " is bulging with need and springs readily into her warm hands like a loyal pet.\n\n", false);
		
				outputText("The goblin is in no hurry- it's not as if you can stop her- and spends time teasing your cock, working her fingers up and down your length and trailing her tongue around your head, slowly lapping up the pre-cum you inevitably ooze. You don't want to give the miniature rapist the slightest bit of satisfaction but her drugged lips have made your cock incredibly sensitive and needy, and soon you are gasping and panting through your still mouth with each soft, masterful touch. You try and peak as quickly as you can but the goblin knows exactly what she's doing- any time you get close she squeezes near the bottom of your shaft, agonizingly prolonging your arousal. You try and channel your lust into moving your limbs or even just into your abdomen to shake her off, but the basilisk's spell holds; you are a fallen flesh statue, or as far as the goblin is concerned, a giant dildo with some fun extras attached. You force air through your throat to groan wordlessly, trying to plead the goblin to stop, in reply to which she giggles maliciously. \"<i>You like that do you, " + player.mf("stud","bitch") + "? I guess you're ready.</i>\"\n\n", false);
		
				outputText("You feel her pick herself up and then begin to work her sopping vagina down onto your head. ", false);
				var x:Number = player.cockThatFits(60);
				if (x < 0) x = 0;
				//(more than goblin vag capacity: 
				if (player.cockArea(x) >= 60) outputText("\"<i>Ooh, you tease,</i>\" she coos as her wet warmth nuzzles the tip of your member. \"<i>Not just a stud ready and waiting for me to ride, but one with a cock so big I can't even use it! I'm half tempted to leave and come back with something to shrink this down!</i>\" Even a goblin's elastic twat can't take this much of you, and she rocks atop your straining, sensitized dick. She begins to slide herself around the crown, moaning shamelessly as she reaches her limit each time.", false);
				//less than goblin vag capacity: 
				else outputText("Her wet warmth swallows more and more of your member until, with a satisfied sigh, her plump thighs bump into your crotch. With your sensitised cock you can feel every inch of her, and when she starts to slide up and down the sucking, kneading sensation is unbearable.", false);
				outputText(" You cannot last long in the rut the goblin has chemically induced in you and against her thrusting and milking twat you quickly ejaculate, endless hot fluid spurting out of your cock into her welcoming sex. Unable to move a muscle except for your eager, flexing penis, you feel like your body is being pressed to the ground by an invisible wall, with your cock trapped by a mercilessly loving, milking hole, a prisoner of sex. The goblin continues to thrust away even as your seed dribbles out of her snatch and onto your body, and you groan as it sinks in that your hypersensitive throbbing cock is still rock hard.\n\n", false);
		
				outputText("\"<i>That was good for a first effort, stud,</i>\" the goblin's giggling voice reaches your ears. \"<i>But you've got lots more man sauce locked up inside of you, don't you? Yes you do. And you're going to give me it all.</i>\" As the insatiable little green monster picks up the pace, her juices mingling with yours as they trickle onto the ground beneath you, you feel the erotic mental backwash build again, and you go comatose under the overwhelming, uncontrolled rush of sexual sensation...\n\n", false);
		
				outputText("Eventually, after what seems like hours of forcible ejaculation, you notice that your dick is no longer trapped in sucking wet. You come out of your daze you find that the goblin has left, leaving your petrified form in a mingled pool of her juices and your own jizz. After another ten or twenty minutes of being forced to lie there and marinate in your own shameful memories, you find with great relief you can begin to move your fingers again. Eventually with some effort you manage to work power into each corner of your body and finally shake free of the basilisk's curse; quickly, you pick yourself up and redress before anything else finds you and woozily begin to make your way back down the mountain. The smell of horny goblin on you is a lingering reminder of what just happened to you.", false);
				player.orgasm();
			}
			//Unsexed: 
			else if (!player.hasVagina()) {
				outputText("At the corner of your vision, you see a small, familiar green shape hover into view. The goblin is so busy sorting through her inventory of drugs that you actually manage to see her before she sees you. When she does lift her head up and notices the petrified, naked individual in front of her, she is so surprised she drops her satchel.\n\n", false);
		
				outputText("\"<i>A " + player.race() + "!</i>\" she yelps. Hesitantly at first, then with increasing confidence as how vulnerable you are sinks in, she does a round circuit of you, taking in every angle of your frozen, helpless flesh.\n\n", false);
		
				outputText("\"<i>Get caught with our pants down by a basilisk, did we?</i>\" the goblin purrs. \"<i>Well, not to worry. I'll take good c- hey, what gives?!</i>\" From behind you, you feel her hands thread their way around your " + player.legs() + " before feeling and slapping all around your featureless groin. \"<i>This is fucking bullshit!</i>\" she howls. \"<i>I get a toy that can't stop me all to my lonesome, and it's some colossal jerkoff who thinks it's funny to have no sex!</i>\" She stomps around to your front and glares at you, simmering with rage. \"<i>I bet you think you're a real smartass, you bastard... you bitch... you... whatever! Ooh, I'll fix you!</i>\" With a look of complete disgust she storms off. Having faced down this bizarre rant, you allow yourself to feel a tiny bit of relief. You were worried for a moment there she'd go for your ass... a short distance away, you hear the goblin calling to someone.\n\n", false);
		
				outputText("\"<i>Hey you! Yeah you, shit-for-brains! Wanna free assfuck? Come and get it then, you ugly, dumb muscle-bound moron!</i>\" A moment later you feel a slap on your calf as the goblin runs past you, giggling. \"<i>Have fun, smartass!</i>\" A huge, angry bellow vibrates the air around you and the earth shakes as something big approaches you from behind. You strain with every sinew of your being to escape, but you are, as ever, glued in place. You manage a raspy moan as the enraged minotaur grasps you roughly by both arms, his animal musk filling your nostrils. <i>Fucking goblins.</i>\n\n", false);
		
				outputText("The huge bull-man is not one to look a gift fuck in the mouth. Without bothering to take you in, bar a long wet sniff of your " + player.hairDescript() + ", he sticks his cock between your ass cheeks. He grunts as he forces his head past your sphincter, squirting pre-cum into your passage as he does so. Your body is incapable of clenching instinctively against the invasion, but there is no escaping how huge the dong feels as he impatiently forces your ass open.", false);
				player.buttChange(60,true,true,false);
				if (player.analCapacity() < 60) outputText(" The giant cock stretches you out painfully, and everything else blots out as your body attempts to accommodate the beast. As he begins to thrust more of his length up you, he grunts and beads more of his drugged pre-cum, lubricating your anus. This thankfully makes his cock easier to take, but also increases the pace of his thrusting as your hole becomes more receptive to it.", false);
				//V loose/Buttslut: 
				else outputText(" Your well-worn ass is a perfect fit for the giant cock and accepts it eagerly, every bit as welcoming as a moist vagina. As the minotaur rubs against your tender inner walls he grunts and beads more of his drugged pre-cum, turning your hole into a helplessly wet, clenching ass cunt.", false);
				outputText(" You begin to pant from exertion and the overpowering sensation of the fuck as you feel first one ring and then a second push past your sphincter, then out again, then in and out as the minotaur picks up the pace. As rut takes hold of him, he picks you up by your arms and uses his strength to force you up and down his dick, using you as a cocksleeve to sate his animalistic desires. Your ass is slick with his pre-cum by now however, and the drugged slime has bumped you upwards into a hazy high; only the height of his downward thrust when his dick is almost completely buried in your bowels brings you out of it, the painful intensity of it dragging you down of your cloud with a gasp.\n\n", false);
		
				outputText("Eventually the minotaur's balls swell against your " + player.buttDescript() + " and with a long, satisfied moo, he reaches his peak, holding you down so his cum jets forth deep inside you. The sensual high it has already instilled in you amplifies by tenfold as the warm, oozing fluid finds its mark and you moan as you spontaneously orgasm, your anus helplessly milking the creature for all it can get.\n\n", false);
		
				outputText("The minotaur holds onto you until he has finished spurting his last into you, before abruptly setting you back down on your frozen feet, pulling his slimy, receding member out of your abused anus and with a satisfied snort, takes his leave. You feel his cum drooling out of you and down your " + player.hipDescript() + ", but in your hazy, druggy state the feeling is almost sensual.", false);
				//(Addict: 
				if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] > 0 || player.findPerk(PerkLib.MinotaurCumAddict) >= 0) outputText(" You're incredibly frustrated that you can't clench yourself and hold the magical substance deep inside you, so you can savor the wonderful, soft elation it blossoms inside of you for as long as you can.", false);
				outputText("\n\n", false);
				
				outputText("Eventually, after another thirty or so minutes of being forced to stand there and savor the cum trickling down your legs, you find with great relief you can begin to move your fingers again. With some effort you manage to work power into each corner of your body and finally shake free of the basilisk's curse; quickly, you shake the aching out of your " + player.legs() + " and re-dress before anything else finds you and woozily begin to make your way back down the mountain, trying to ignore the feeling of ooze dripping out of you.", false);
				player.orgasm();
				player.slimeFeed();
			}
			//Female: 
			else {
				outputText("At the corner of your vision, you see a small, familiar green shape hover into view. The goblin is so busy sorting through her inventory of drugs that you actually manage to see her before she sees you. When she does lift her head up and notices the petrified, naked individual in front of her, she is so surprised she drops her satchel.\n\n", false);
		
				outputText("\"<i>A " + player.race() + "!</i>\" she yelps. Hesitantly at first, then with increasing confidence as how vulnerable you are sinks in, she does a round circuit of you, taking in every angle of your frozen, helpless flesh.\n\n", false);
		
				outputText("\"<i>Get caught with our pants down by a basilisk, did we slut?</i>\" she purrs. \"<i>Well, not to worry. I'll take good care of you.</i>\" You somehow doubt her good intentions, and your suspicions are confirmed when, after completing her sauntering circumference of you, she shoves your bottom half as hard as she can. You fall slowly like a wooden board; being unable to brace yourself, the sensation of dropping is horrible, and, once your skull connects with the ground, painful. Before you can clear your swimming vision you feel the goblin's soft, dense weight on your chest, and then her eager lips upon yours, sucking and tonguing every inch of your frozen mouth that she can reach. A tingling sensation spreads from your mouth downwards as her pheromone-laced lipstick takes effect. By the time she has finished with your mouth and worked her way downwards, your paralyzed body feels warm and receptive, and your " + player.vaginaDescript(0) + " is wet with need. You feel small fingers caressing your mons before slipping their way inside, circling your " + player.clitDescript() + " before testing your depths. You wish you could cringe away or even thrust yourself forward to try and make the goblin better address your growing need, but that is impossible; you stare in front of you, petrified, as the fingers continue their lazy tour of your sex until your juices are running like a river in spring.\n\n", false); 
		
				outputText("\"<i>You are well up for this, aren't you hun?</i>\" coos the goblin as she begins to flick your sopping clit, sounding delighted with the involuntary heat she has stoked within you. \"<i>It's such a shame that I don't have the big cock you obviously want and need. Don't worry though; I've got the next best thing!</i>\" You hear her rummage around in her satchel, which is followed by the sounds of her wetly sucking on something with obvious enthusiasm. You shrink inwardly as you make a strong guess as to what she's holding and what she intends to do with it. Sure enough, a moment later you feel a dildo pushing unceremoniously into your " + player.vaginaDescript(0) + ".", false);
				player.cuntChange(30,true,true,false);
				//[(tight)
				if (player.vaginalCapacity() < 30) outputText(" You didn't get the wet end, and you groan as you feel the thing begin to puff up as it reacts with your eager juices until it is pushing almost painfully against your inner walls.", false);
				else outputText(" You didn't get the wet end, and you groan as you feel the thing begin to puff up as it reacts with your eager juices until it fills your well-used passage almost perfectly.", false);
				outputText(" You feel the goblin crawl on top of you, pulling the dildo upwards so it rubs against your " + player.clitDescript() + " and then with a squealing giggle impales herself on the other end. Her lustful movements translate through the artificial cock buried in your dripping sex, sending tremors and waves of pleasure to your very core. A gush of female fluid splatters over your own sex as the goblin works herself right down the shaft connecting you until she is squelching against you wetly. The goblin twists, grinding and scissoring her thighs, the hard bud of her clit rubbing back and forth over your own. By now your passage feels as stuffed as it ever has been, crammed totally full of the squishy expanded double-dong. Every motion the tiny slut makes is amplified directly into the fuck-stick plugging your " + player.vaginaDescript(0) + ". Judging by how wonderful it feels rubbing and twisting against your sensitive walls, the aphrodisiac it is leaking into you is definitely having an effect. You whine at the goblin twists herself and her dildo around, rubbing and riding you so effectively, the involuntary tide of erotic memories building again...\n\n", false);
		
				outputText("After cumming over and over again in tandem with the dominant little slut she eventually takes mercy upon you, leaving you lying in a pool of mingled girl cum, dazed by the hypnotic backwash and the drugs which have left you so hazy and sensitive. After another ten or twenty minutes of being forced to lie there and marinate in your own shameful memories, you find with great relief you can begin to move your fingers again. Eventually with some effort you manage to work power into each corner of your body and finally shake free of the basilisk's curse; quickly, you pick yourself up and redress before anything else finds you and woozily begin to make your way back down the mountain. The smell of horny goblin on you is a lingering reminder of what just happened to you.\n\n", false);
		
				//(lose 100 lust, stretch vagina according to d.dildo rules if F, stretch anus according to minotaur and increment addiction if U)
				player.orgasm();
			}
		}
		//Defeated, Taken Advantage of: minotaur
		private function basiliskAdvantageMinotaur():void {
			spriteSelect(75);
			outputText("Time stretches by at an agonizingly slow pace as you stand there, a bizarre, motionless flesh statue. You have no way of measuring how much time is passing; the sun is not in your direct line of vision.  You try to move any and every part of yourself in turn, but it is hopeless. Your body is a cage, and you begin to hate the basilisk less because it paralyzed you and more because it left your mind entirely aware of it. Every so often another unbidden backwash of erotic memories overwhelms your senses, keeping you helplessly aroused and reminded of who did this to you.\n\n", false);
		
			outputText("You hear a deep, rumbling, snuffling sound from behind you, and the earth shakes as something big approaches you from behind. <i>Please not a minotaur,</i> you think. <i>Anything but a minotaur. Please not a minotaur...</i> Hands roughly grab your sides and a brutally powerful musk fills your nostrils as you groan in despair.\n\n", false);
		
			outputText("The huge bull-man is not one to look a gift fuck in the mouth. Without bothering to take you in, bar a long wet sniff of your " + player.hairDescript() + ", he sticks his cock between your ass cheeks. He grunts as he forces his head past your sphincter, squirting pre-cum into your passage as he does so. Your body is incapable of clenching instinctively against the invasion, but there is no escaping how huge the dong feels as he impatiently forces your ass open.", false);
			player.buttChange(60,true,true,false);
			//(Tight: 
			if (player.analCapacity() < 60) outputText(" The giant cock stretches you out painfully, and everything else blots out as your body attempts to accommodate the beast. As he begins to thrust more of his length up you, he grunts and beads more of his drugged pre-cum, lubricating your anus. This thankfully makes his cock easier to take, but also increases the pace of his thrusting as your hole becomes more receptive to it.", false);
			//V loose/Buttslut: 
			else outputText(" Your well-worn ass is a perfect fit for the giant cock and accepts it eagerly, every bit as welcoming as a moist vagina. As the minotaur rubs against your tender inner walls he grunts and beads more of his drugged pre-cum, turning your hole into a helplessly wet, clenching ass cunt.", false);
			outputText(" You begin to pant from exertion and the overpowering sensation of the fuck as you feel first one ring and then a second push past your sphincter, then out again, then in and out as the minotaur picks up the pace. As rut takes hold of him, he picks you up by your arms and uses his strength to force you up and down his dick, using you as a cocksleeve to sate his animalistic desires. Your ass is slick with his pre-cum by now however, and the drugged slime has bumped you upwards into a hazy high; only the height of his downward thrust when his dick is almost completely buried in your bowels brings you out of it, the painful intensity of it dragging you down of your cloud with a gasp.\n\n", false);
		
			outputText("Eventually the minotaur's balls swell against your " + player.buttDescript() + " and with a long, satisfied moo, it reaches its peak, holding you down so its cum jets forth deep inside you. ", false);
			if (player.gender == 1) outputText("The sensual high it has already instilled in you amplifies by tenfold; the warm, oozing fluid finds its mark and you moan as you spontaneously ejaculate, ropes of your own cum spattering on the ground and your own nerveless " + player.feet() + ".", false);
			else if (player.gender == 2) outputText("The sensual high it has already instilled in you amplifies by tenfold; the warm, oozing fluid finds its mark and you moan as you spontaneously orgasm, your juices spattering your thighs and calves.", false);
			else if (player.gender == 3) outputText("The sensual high it has already instilled in you amplifies by tenfold; the warm, oozing fluid finds its mark and you moan as you spontaneously orgasm, ropes of your own jizz spattering on the ground and girl cum dripping down your thighs.", false);
			else outputText("The sensual high it has already instilled in you amplifies by tenfold as the warm, oozing fluid finds its mark and you moan as you spontaneously orgasm, your anus helplessly milking the creature for all it can get.", false);
			outputText("\n\n", false);	
		
			outputText("The minotaur holds onto you until he has finished spurting his last into you, before abruptly setting you back down on your frozen feet, pulling his slimy, receding member out of your abused anus and with a satisfied snort, takes his leave. You feel his cum drooling out of you and down your " + player.hipDescript() + ", but in your hazy, druggy state the feeling is almost sensual.", false);
			//(Addict: 
			if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] > 0 || player.findPerk(PerkLib.MinotaurCumAddict) >= 0) outputText(" You're incredibly frustrated that you can't clench yourself and hold the magical substance deep inside you, so you can savor the wonderful, soft elation it blossoms inside of you for as long as you can.", false);
			outputText("\n\n", false);
		
			outputText("Eventually, after another thirty or so minutes of being forced to stand there and savor the cum trickling down your legs, you find with great relief you can begin to move your fingers again. With some effort you manage to work power into each corner of your body and finally shake free of the basilisk's curse; quickly, you shake the aching out of your knees and redress before anything else finds you and woozily begin to make your way back down the mountain, trying to ignore the feeling of ooze dripping out of you.", false);
			//(lose 100 lust, stretch anus according to minotaur, increment mino addiction)*/
			player.orgasm();
			player.minoCumAddiction(10);
			player.slimeFeed();
		}
		
		private function driderPCEggLaysBasilisk():void {
			spriteSelect(75);
			clearOutput();
			outputText("Leaning back on your carapace-clad abdomen, you try and look over your defeated opponent. Even slumped over in ");
			if (monster.HP < 1) outputText("exhaustion");
			else outputText("arousal");
			outputText(", the basilisk is still striving to meet your eyes with its own. Clenching your teeth, you avert your eyes and stomp forward blindly, colliding roughly with the spined lizard, knocking him flat on his back on the rocky ground.");
			
			outputText("\n\nReaching behind you, you gather a handful of webbing before glaring down at the stunned basilisk. He's looking around, dazedly, when you reach down and grab his shoulder, dragging him roughly along as you head towards a convenient nearby boulder. ");
			if (silly()) outputText("Pinning him between a rock and a hardening place, ");
			outputText("Shoving him up against the cool stone, ");
			outputText("you plaster the web across his face, neatly blindfolding the irritating lizard. The creature lets out a frightened hiss, which you completely ignore as you bodily toss him atop the rock before clambering after him, your spider limbs allowing you to easily traverse the stone. A bit of artful rearrangement and a lot of webbing sees the creature spread-eagled across the boulder, limbs pulled taut by the thick, sticky strings.");
			
			outputText("\n\nYou feel your breath quicken and your cheeks flush as your ovipositor slides free, dripping lube, leaving trails across the stone as you ready yourself to give the egg-thief what he wanted. Maybe not <i>exactly</i>, but you have no intention of allowing him to complain, in any case. Spreading your eight legs wide, you lower yourself down until your ");
			if (player.hasVagina()) outputText("already-dripping pussy");
			if (player.gender == 3) outputText(" and ");
			if (player.hasCock()) outputText("[eachCock]");
			outputText(" hangs");
			//if (player.gender != 3) outputText("s");
			outputText(" just over his mouth.");
			//[(if PC has eggs in vag or Oviposition)
			if (player.findPerk(PerkLib.BasiliskWomb) >= 0 || player.findPerk(PerkLib.Oviposition) >= 0 || player.pregnancyType == PregnancyStore.PREGNANCY_OVIELIXIR_EGGS) outputText(" You watch with idle amusement as the scent of your excitement perks up the basilisk's reptilian member, rising until it reaches its impressive full length. <i>Maybe some other time</i>, you think to yourself, as you set about the business of unloading your overfull abdomen.");
			outputText("You can feel the eggs sliding into position, weighing down your extended ovipositor as you slide it up the bound basilisk's thigh, prodding at his taut backdoor. The sensation of the heavy organ forcing open his tight hole sends a shiver through his body, and it isn't long before the lube-drooling appendage forces its way in; you sink down further, practically resting your body atop him as you release a happy sigh.");
			
			outputText("\n\nThe segmented shaft works forward, driving in up to its second ring, wiggling and thrusting in an attempt to slide even deeper into your bound slut. The anal stimulation proves to be too much for the tied lizard, and with another hiss he blows his load beneath you, spraying his seed across your chitin undercarriage. It's utterly unacceptable that he's enjoying this more than you, and you glare down at him before shoving your ");
			if (player.hasCock()) outputText("cock");
			else outputText("cunt");
			outputText(" up against his half-open mouth, smearing your free-running juices across his scaled face. You wait a few seconds, just enjoying the feeling of his hot breath against your oversensitive sex, before you state your intentions in an imperious tone. \"<i>Lick.</i>\"");
			outputText("\n\nThe creature hesitates below you, and you take the opportunity to inch your ovipositor even further, burying nearly the entire organ into the basilisk's warm clenching hole. Another spurt of your thick lube proves to be all the encouragement he needs, and his lengthy tongue extends to ");
			if (player.hasCock()) outputText("wrap tightly around your waiting prick");
			else outputText("burrow deep into your needy slit");
			outputText(". You coo in delight at the sensation, and begin to grind yourself against his face as you wait for your egg-laying to begin.");
			outputText("\n\nThe monster's stomach bloats as a final rush of goo fills his bowels in preparation for your ");
			if (player.fertilizedEggs() == 0) outputText("un");
			outputText("fertilized orbs, providing you with a moment's warning before the ecstasy-inducing ripple of an egg sliding deep into him rolls your eyes backwards in pleasure. You twitch and squirm atop the bound basilisk, mashing your ");
			if (player.hasCock()) outputText("dick");
			else outputText("cunt");
			outputText(" against his face while your egg-laden tube pumps away, each pulse forcing another egg through his squeezing ring and sending trills of intoxicating euphoria up your spine. You lose yourself in the act, your heartbeat racing in time with contractions of your ovipositor, spraying ");
			if (player.hasCock()) outputText("semen");
			else outputText("femcum");
			outputText(" across your partner's face and neck.");
			outputText("\n\nYou feel his stomach beneath you, bloated so far as to scrape at your chitinous underside, and you nearly collapse on top of him as your thick spider-tube frees itself with an audible pop. Green slime leaks down the side of the boulder from his gaping ass, and his tongue hangs idle at the corner of his mouth, both of you panting heavily as you attempt to regain your breath. You catch yours first, and skitter off the boulder to the ground below, pausing to glance back at the tied beast");
			//(if corruption >= 50 
			if (player.cor >= 50) outputText(" before heading off towards your camp. The harpies will probably free him from your webs... eventually.");
			else outputText(". You reach up and slice him free from the webbing, carefully placing him on the ground below. The blindfold stays, though. You're kind, not stupid. With your good deed for the day complete, you gather yourself up and head back to camp.");
			player.dumpEggs();
			player.orgasm();
			combat.cleanupAfterCombat();
		}
		
		private function layBeeEggsInABasilisk():void {
			spriteSelect(75);
			clearOutput();
			outputText("Completely destroyed, the basilisk lays face down on the ground, struggling pathetically to get up. You giggle at the attempt as you ");
			if (player.wingType == WING_TYPE_BEE_LIKE_SMALL || player.wingType == WING_TYPE_BEE_LIKE_LARGE ) outputText("buzz lightly over to the basilisk's writhing body");
			else outputText("saunter arrogantly over to the basilisk's crumpled up figure");
			outputText(" and lightly nudge him in his ribs with your [foot]. His eyes are closed from to the ");
			if (monster.HP < 1) outputText("pain");
			else outputText("arousal");
			outputText(" he's currently suffering through, but you know they won't stay that way for long. You zealously search through your bags for some extra undergarments and wrap them around the lizard beast's scaly visage; with a quick afterthought, you reach for his talons and tie them to his face, atop his eyes in mock mourning for what is about to happen. You let out another perverse giggle and wonder vaguely if there is anything more you can do to make this situation more humiliating for the beast.");
			
			//[(if pc is horse or unsexed)
			if (player.isTaur() || player.gender == 0) outputText("\n\nYou drool messily on your hand and cup it to the basilisk's hole; he hisses in displeasure - though he must have had an inkling of what was coming, the visceral sensation of having his asshole lubed for entry is probably sending his imagination careening off in reckless, tormenting anticipation.");
			
			else if (player.hasCock()) {
				outputText("\n\nYou remove just enough of your [armor] to expose yourself and grab hold of your increasing length");
				if (player.totalCocks()) outputText("s");
				outputText("; rubbing enthusiastically, you start at the base but end in a gentle stroke at the sensitive tip. With you doing your best to milk as much pre as you can, the viscous ooze that dribbles out of your dong");
				if (player.totalCocks()) outputText("s");
				outputText(" lands with soft pitters on the overgrown lizard's back, the intense mountain sun baking the gunk onto the scales. You sigh in languor, but remember you're doing this for a reason.");
			}
			//(else if pc has vag:
			else outputText("\n\nYou tap a finger against your cheek, then have an idea. Making quick work of your [armor] you dip your fingers into your personal honey jar, flicking the contents enticingly but quickly, to get some lube to dribble out onto your hands. Once a decent amount has been deposited into your waiting palm, you slap the viscous concoction under the basilisk's nostrils and smear it lasciviously all around. The basilisk coughs as his way of breathing is momentarily interrupted, but you ignore it in favor of reaching for more honey to rub.");
			
			outputText("\n\nYour victim squirms at the sensations forced upon him, but as weak as he is, another firm [foot] to his ribs makes him rethink his resistance. Your overburdened abdomen throbs, reminding you of your purpose, and you tilt the basilisk's hips up toward the sky for a better angle to insert yourself; a sigh of relief escapes your lips as you release your ovipositor from your bee abdomen. You take your time arranging yourself ");
			if (player.isTaur()) outputText("above");
			else outputText("behind");
			outputText(" the desperately-squirming lizard, delighting in the fear-scented air around the beast as your ovipositor slaps his cheeks in search of his tight little black hole. Aside from the difference in feel, you know once you hit the sweet spot by the rigid jolt from the basilisk as his worst fear is confirmed. You openly laugh this time, and enjoy the feel of the lizard squirming under you as your bulbous appendage painstakingly, slowly works its way inside his anus. Dry and tight, you really have to force your way, but the feeling is amazing, and it just keeps getting better. It probably doesn't feel too great for the basilisk, but that's not exactly your problem. The slit at the end of your ovipositor widens, leaking golden liquid, and the squirming basilisk halts its struggles and relaxes as the narcotics in the slime work their way into the bloodstream. You begin humming in a fashion similar to the giant bees you now resemble as you enjoy the blissful sensation of the eggs progressing through the long tubular organ, stretching the reptile's pucker to accommodate your ");
			if (player.fertilizedEggs()) outputText("fertilized offspring");
			else outputText("burdensome load");
			outputText(".");
			
			outputText("\n\nThe basilisk twitches each time an egg runs over his prostate, and his purple prick jolts in time. The mind-numbing ooze paired with the sensation of the eggs is clearly no longer seen as unpleasant by the beast; his tongue has even begun to dangle and drool. The seemingly endless mixture of eggs and slime continues to work its way into the basilisk's intestines; you yourself have been enjoying the sensation too.");
			
			//[(female or small-dicked horse, or unsexed)
			if (player.isTaur() || player.gender == 0) {
				outputText("\n\nThere's nothing to distract you from the pleasure; ");
				//[(U)
				if (player.gender == 0) outputText("no needy cock or cunt demanding a caress - except the basilisk's, and you care not a bit about that one.");
				else if (player.isTaur()) outputText("even if you wanted to reach your genitals, your arms resolutely refuse to bend that way, so you focus on the slippery, silky feelings travelling along your ovipositor.");
			}
			if (player.hasCock()) {
				outputText("\n\nYour seeping member");
				if (player.cockTotal() > 1) outputText("s");
				outputText(" demand");
				if (player.cockTotal() == 1) outputText("s");
				outputText(" attention, and you don't deny them, as you resume the pleasurable stroking you started earlier. More white cream leaks out, landing on the earth and the basilisk's back. The combined titillation of your ovipositor massaging the overgrown lizard's anus from the inside out and the stroking of " + player.sMultiCockDesc() + " is more than your overly-sensitised body can handle for long. Soon, the tell-tale feeling at the base of your spine ");
				if (player.balls > 0) outputText("and inside your balls ");
				outputText("is more than you can take, and ropes of thick semen coat the basilisk from the cheeks of its ass to the back of its head. You give a guttural groan as your orgasm hurries the last of your eggs up the long black organ that is your ovipositor to be deposited into the tightly packed cavern that you've made the basilisk's intestines into.");
			}
			//(no-horse vag: 
			else if (player.hasVagina()) {
				outputText("\n\nYour body demanding more feeling to push it over the edge, you begin simultaneously massaging your [nipple] and frigging your [clit] joy buzzer. More of your juices drip out and leak down your thighs; the basilisk shudders again and you imagine how bizarre it must feel for the beast to be invaded in such a way. You lick your lower lip before biting into it gently, then pinch and tug at your hardened nipples, moaning as you climb higher and higher towards your peak. Your lower lips try to clench around empty air, wanting fulfillment. Today's orgasm is meant for something else though, and you let out a cry as you forcefully jam shut the basilisk's back door and leak girl cum all over the floor.");
			}
			outputText("\n\nAs you remove your depleted appendage from the violated basilisk's ass, he falls to the side, no longer able to keep himself upright. Laying like this, you can see the beast's horribly-distended stomach, almost able to make out the outline of each individual egg but for the scales in the way. You nod approvingly and bend down to give to the lizard a quick kiss on the cheek for being such a good sport about the whole thing - though, not being an idiot, you don't untie him. After that, you buzz away contentedly, idly thinking about returning the next time you'll need a receptacle for your eggs.");
			player.dumpEggs();
			player.orgasm();
			combat.cleanupAfterCombat();
		}
	}
}
