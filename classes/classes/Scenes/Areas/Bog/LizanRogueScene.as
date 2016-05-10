package classes.Scenes.Areas.Bog 
{
	import classes.*;
	import classes.GlobalFlags.*;
	
	public class LizanRogueScene extends BaseContent
	{
		
		public function LizanRogueScene() 
		{
			
		}
		
		public function lizanIntro():void {
			clearOutput();
			var lizan:LizanRogue = new LizanRogue();
			if (player.cor > 30) {
				outputText("As you walk through the bog you happen upon a lone lizan male covered in " + monster.skinTone + " scales. Upon hearing your approach he jumps back, your sudden appearance must have surprised him. After an initial moment of surprise the lizan tentatively sniffs the air between the two of you. Without warning he jumps back, flashing his claws and releasing a loud hiss. Apparently he smells something he doesn't like. You ready for an attack but he just sits there, making noise and puffing himself up. For all the ferocity he displays he doesn't attack and you realize he's waiting for you to back down. What will you do?");
				if (flags[kFLAGS.CODEX_ENTRY_LIZANS] <= 0) {
					flags[kFLAGS.CODEX_ENTRY_LIZANS] = 1;
					outputText("\n\n<b>New codex entry unlocked: Lizans!</b>")
				}
				menu();
				addButton(0, "Fight", fightLizan, false, null, null, "Fight the lizan!");
				addButton(1, "Leave", leaveLizan, false);
				return;
			}
			else {
				outputText("As you walk through the bog you happen upon a lone lizan male covered in " + monster.skinTone + " scales. Upon hearing your approach he jumps back, your sudden appearance must have surprised him. After an initial moment of surprise the lizan tentatively sniffs the air between the two of you. ");
				if (flags[kFLAGS.MET_LIZAN_FIRST_TIME] <= 0) {
					if (player.tallness > 64) outputText("He is shorter than you and wearing nothing but a loincloth with a pack belted onto it.");
					else if (player.tallness >= 60) outputText("He is about the same height as you and wearing nothing but a loincloth with a pack belted onto it."); 
					else outputText("He is taller than you and wearing nothing but a loincloth with a pack belted onto it.");
					outputText("\n\nThis shows off his toned but slim chest, arms and legs covered in " + monster.skinTone + " scales. ");
					flags[kFLAGS.MET_LIZAN_FIRST_TIME] = 1;
				}
				outputText("After a moment of silent consideration he speaks. \n\n\"<i>Hey there,</i>\" he says, his lizard lips pulling into a big grin, \"<i>... and who might you be?</i>\" You answer with the truth, your name. ");
				outputText("\n\n\"<i>Well the alliance is very welcoming to anyone who isn't corrupt,</i>\" he says before rubbing his now bulging loincloth, \"<i>But If you would like to play I'm game.</i>\" he widens his stance like he's preparing to fight but his face is still light and playful.");
				outputText("\n\nYou're not sure if the lizan wants to have sex with you or have a quick sparring match. You could just attack him and do whatever you want with him. What will you do?");
				if (flags[kFLAGS.CODEX_ENTRY_LIZANS] <= 0) {
					flags[kFLAGS.CODEX_ENTRY_LIZANS] = 1;
					outputText("\n\n<b>New codex entry unlocked: Lizans!</b>")
				}
				menu();
				addButton(0, "Spar", fightLizan, true, null, null, "Do a spar session with the lizan!");
				if (player.lust >= 33) addButton(1, "Sex", haveSexWithLizan, null, null, null, "Have some fun with the oh-so-sexy lizan.");
				addButton(2, "Decline", leaveLizan, true, null, null, "Excuse yourself and leave.");
				return;
			}

		}
		
		public function fightLizan(pure:Boolean = false):void {
			clearOutput();
			startCombat(new LizanRogue());
			if (!pure) outputText("You ready your [weapon], prepared to let the little punk know just who it is he is dealing with.");
			else {
				outputText("You tell the male lizan you're game as you ready your [weapon]. His grin spreads into the full toothy smile of a rival as he flashes his claws at you, a taunting gesture. You are now sparring with a lizan male.");
				monster.createStatusEffect(StatusEffects.Spar,0,0,0,0);
			}
			doNext(playerMenu);
		}
		
		public function leaveLizan(pure:Boolean = false):void {
			clearOutput();
			if (!pure) {
				outputText("You roll your eyes at the overt display. You raise your hands in a gesture of harmlessness and turn around to head home. When you look back over your shoulder the lizan is gone. Such a creature doesn't interest you right now anyway.");
				doNext(camp.returnToCampUseOneHour);
			}
			else {
				outputText("You tell the lizan you aren't up for any games. He shrugs, \"<i>Maybe next time then,</i>\" he says as he rummages around in his pack. When he finds what he's looking for he takes it out and tosses it towards you. You catch the small vial and read that it is labeled Reptilium. When you look up the scaly guy is nowhere to be seen. You head back to camp, smiling at the weird but friendly encounter.");
				inventory.takeItem(consumables.REPTLUM, camp.returnToCampUseOneHour);
			}
		}
		
		public function winAgainstLizan():void {
			clearOutput();
			outputText("The lizan raises his hands in defeat and you celebrate with a victory dance. ");
			menu();
			if (player.cor > 30) {
				if (player.lust >= 33 && player.gender > 0) {
					outputText("You wonder what you should do to the lizan.");
					if (player.hasCock()) addButton(0, "Use Dick", rapeLizanInTheAss, null, null, null, "Anally penetrate him with your [cocks].");
					if (player.hasVagina()) addButton(1, "Use Pussy", rapeLizanWithPussy, null, null, null, "Get on top of the lizan and stuff his cock into your [pussy].");
					addButton(4, "Leave", combat.cleanupAfterCombat);
					return;
				}
				else {
					outputText("You rummage through his bag for something valuable.");
					combat.cleanupAfterCombat();
					return;
				}
			}
			else {
				dynStats("str", 1, "tou", 1);
				if (player.lust >= 33 && flags[kFLAGS.SFW_MODE] <= 0) {
					outputText("<b>You could have sex with him if you like to.</b> ");
					addButton(0, "Sex", haveSexWithLizan, null, null, null, "Have some fun with the oh-so-sexy lizan.");
					addButton(4, "Leave", leaveLizanAfterCombat);
					return;
				}
				else leaveLizanAfterCombat();
			}
		}
		
		public function leaveLizanAfterCombat():void {
			outputText("After chatting for a bit the two of you part ways, having gotten a good workout in the process. ");
			combat.cleanupAfterCombat();
		}
		
		public function loseToLizan():void {
			clearOutput();
			if (player.cor > 30) {
				outputText("Unable to continue fighting, you collapse from " + (player.lust >= player.maxLust() ? "overwhelming desires": "your injuries") + ". The lizan steps over to you, intent on punishing you. ");
				combat.cleanupAfterCombat();
			}
			else {
				outputText("You are forced to raise your hand in defeat and the lizan celebrates with a few acrobatic flips and plenty of bragging. After a quick friendly chat the two of you part ways, having gotten a good workout in the process. ");
				dynStats("str", 1, "tou", 1);
				combat.cleanupAfterCombat();
			}			
		}
		
		public function haveSexWithLizan(continuation:Boolean = false):void {
			if (!continuation) {
				clearOutput();
				outputText("You tell the male lizan you're game as you " + player.clothedOrNaked("begin to pull off your [armor]", "show your naked form") + ". His bulge becomes more pronounced as your body comes into view. He quite obviously likes what he sees. Which one of your body parts do you plan to use on the horny male lizan?");
			}
			menu();
			if (player.hasCock()) addButton(0, "Use Dick", consensualButtfuck, null, null, null, "Anally penetrate him with your penis.");
			if (player.hasVagina()) addButton(1, "Use Vagina", consensualGetFucked, null, null, null, "Have him take you vaginally.");
			addButton(2, "Use Ass", consensualGetButtFucked, null, null, null, "Have him take you anally.");
			if (player.hasVagina()) addButton(3, "Dbl.Penetration", consensualDoublePenetration, null, null, null, "Have him stuff both your holes with his dual cocks.", "Double Penetration");
			if (flags[kFLAGS.WATERSPORTS_ENABLED] > 0 && flags[kFLAGS.LIZAN_ROGUE_SEX_COUNTER] >= 3 && !continuation) addButton(4, "Watersports", consensualWatersports, null, null, null, "Participate into urine activity with him. \n\nNOTE: Contains watersports!");
		}
		
		public function consensualButtfuck():void {
			clearOutput();
			outputText("The lizan watches you with obvious interest as he asks \"<i>How do you like to do this?</i>\"");
			outputText("\n\nYou tell him you want his ass, making sure to assert your dominance. He doesn't seem to mind as he turns away and peels off his loincloth, exposing his tight little toned ass with a lift of his glistening " + monster.skinTone + " tail. After he has discarded the meager clothing he turns back around to face you, displaying dual bumpy purple lizan dicks, neither of which are small.");
			outputText("\n\nTaking charge of the situation you take him by the shoulders and push him down to his knees. He doesn't seem to mind the gentle reminder of your dominance. From the way he begins flicking his tongue at [eachCock] you feel that he is actually quite turned on by the gesture.");
			if (player.cocks.length == 1) { //One cock
				if (player.cocks[0].cockLength < 10) {
					outputText("\n\nLike a snake his dripping tongue slithers from his lips and begins to coil around your engorged [cock]. The long muscle wraps you up like a present. You feel a tug and watch as your tongue wrapped [cock] is pulled into the obviously experienced lizan's hot mouth. Then he closes his lips around the base and begins to leisurely bob up and down the full length of your [cock]. Every time he sucks you in his tongue slithers back around your [cock] before he sucks off, unwrapping it in the process. The rapid coiling sensation combined with the awe inspiring suction has you trembling before long.");
					outputText("\n\nYou place your hand on his cool scaley head for balance, inadvertently causing him to increase tempo. It feels like you're fucking a living hole whose only purpose is to bring you unbearable amounts of pleasure. For a moment you revel in the sensation before reaching down and pulling him off your [cock] with an audible pop. He wipes his arm across his face and, still licking his lips, gives you a bright self satisfied smile.");
				}
				else {
					outputText("\n\nLike a snake his tongue slithers from his lips and begins to encircle your swollen [cock]. The long saliva dripping muscle covers your [cock] in dripping gobs of spit as it forms coils, slowly pulling your [cock] towards the lizan's obviously experienced mouth. He closes his lips around the first 10 inches of your [cock], unable to fit anymore into his mouth. He drags his lips across your impressive [cock] with obvious relish, maybe its not often he gets to service a cock as big as yours. The combination of the rapid cooling sensation combined with the awe inspiring suction has you trembling before long.");
					outputText("\n\nHe suddenly twists his head, a movement that almost brings you to your knees. He begins to bob up and down and you watch as your [cock] is partially engulfed again and again. His tongue coils with each fluid motion and unwraps everytime he pulls off. The intense sensation almost brings you to your peak but before you reach that glorious point of no return he pulls off your [cockHead] with an audible pop, licking his lips and giving you a self satisfied smile.");
				}
			}
			else { //Multi cocks
				outputText("\n\nLike a snake his tongue slithers from his lips and begins to encircle your [cock], then moves on until it has formed at least two coils around each of your cocks. The surprisingly firm snake like organ massages all of your dicks in firm rhythmic strokes. It feels like a family of hot, wet snakes are writhing around [eachCock], squeezing with practiced ease as saliva trickles down your shafts. ");
				if (player.balls > 0) outputText("You groan as you feel his spit drip down your [balls] and [legs].");
				if (player.isBiped()) outputText("\n\nPrompting you to spread your [legs] and lean back, letting the lizan know how much you're enjoying this odd tongue job.");
				outputText("\n\nThis lizan is obviously used to orally accommodating multiple cocks. His head begins to bob slightly, pulling [eachCock] wrapped in his gloriously talented tongue with it. The lizan rubs your [legs] with his cool scaly hands, causing you to thrust towards his face. After a few minutes of intense cock squeezing he begins to untangle his insanely long tongue from [eachCock]. The process gives your surging erections time to cool down before the main event. Once finished he licks his lips before giving you a self satisfied smile.");
			}
			outputText("\n\nAs you marvel at the lizan's oral talents he gets on his back and wraps his arms around his well defined calf muscles. You feel like the luckiest guy in the world as you watch the flexible lizan practically fold himself in half. The lean globes of his toned " + monster.skinTone + " ass points up at you, a natural part forming to make his naked hole visible. The way his hole winks at you causes [eachCock] to twitch in anticipation.");
			outputText("\n\nBefore you can get down there and take full advantage of his position his tongue makes an encore appearance. You watch as it slithers down his body, tickling his pert nippples before diving down to his sculpted abdominals. It moves like a snake, wrapping around his dual cocks before the tip dips into his spread hole. He begins to lube up his anal passage, even stretching his hole a little bit. The lizan roughly tongue fucks his own hole, making a show of it as he swishes his tail and pulls his legs closer to his chest. He begins to release soft little sexy gasps as he drills his tongue deeper and deeper into his well relaxed hole. [EachCock] twitches at the sight and soon he slurps his last and retracts his tongue. You can't help but smile as you push him forward and aim straight for his wet little rosebud.");
			if (player.smallestCockLength() < 7) { // actually, it's not the smallest cock used here, but first...
				outputText("\n\nYou push your [cock] into a slickened passage suffused with sweltering heat. The lizan sighs as you begin to rock back and forth inside of him, obviously enjoying the repeated incursions of your [cock] as it moves through him. He widens his legs and teasingly flicks that talented tongue at you. You accept his little challenge and promptly begin roughly pounding the lizan's upturned hole. Beneath you his two bouncing dicks are already leaking small droplets of pale fluid as each thrust causes them to bounce across his toned little stomach.");
			}
			else if (player.smallestCockLength() < 12) { 
				outputText("\n\nYou push your [cock] into the lizan, his hot wet innards fit your [cock] like a glove. He groans as you begin to move, rocking your [hips] to get a steady rhythm going. He widens his scaled legs, an invitation to drill his upturned ass harder and deeper. An invitation which you gladly accept. As you slowly increase tempo his eyes begin to roll into the back of his head as his little clawed toes curl at the edge of your vision. Every stroke sends a quiver through your [cock] and soon you're fucking the lizan with gusto, pounding his upturned hole at top speed and forcibly drawing grunts and groans from the lizan as he takes all you have to offer. You can tell he is loving it from the way his eyes roll into the back of his head as his bouncing lizan dicks spray you both with droplets of creamy fluid.");
			}
			else {
				outputText("\n\nYou push your [cock] into an incredibly tight and quivering anal passage as hot and wet as any cunt. He gasps and bears his teeth as you forcibly stretch his rectal passage. You patiently wait for the vacuum tight opening to begin cooperating. Once the lizan opens his eyes and gives you the go ahead you begin gently rocking back and forth, slowly working your [cock] into his tight little hole. He cringes every time you move, he widens his legs to make room and whimpers with longing as you slowly invade deeper and deeper into his little scaley ass.");
				outputText("\n\nSlightly frustrated you shove, causing a sharp yelp to come from your partner. He gives you a withering look before your apologetic smile causes him to smile back at you, excusing your impatience. As you begin again the lizan's hole is finally beginning to open up. You can tell from the slight edge in his voice that your [cock] is breaching unexplored territory. You rock yourself in deeper and deeper until you've completely shafted the guy. His chest heaves as you hold your entire length deep inside of his quivering anal sleeve. It takes him a few moments to get used to your [cock] and once he gives you the go ahead you begin to fuck him at a medium pace. He trembles and grunts, rolling his hips and convulsing as you big cock makes him practically delirious.");
				outputText("\n\nAfter a while you decide to pick up the pace. After a few moderate strokes into the tight wet sleeve you lean forward and press his knees into his chest. The lizan growls as you begin to fuck his little scaly ass as hard as you can. Beneath you his two bumpy purple lizan dicks are leaking a heavy river of sticky pale fluid as your madly pumping [cock] causes them to flap around on his toned and heaving stomach.");
			}
			outputText("\n\nYour thrusts are a echoing smack against his " + monster.skinTone + " ass as you begin fucking him with the entire length of your [cock]. Soon, your abuse of his prostate becomes too much. His rectal passage clenches tightly as his twin shafts burst, spraying dual torrents of pale cream across everywhere as you fuck him through his orgasm. His flexing tail hole and the sight of his exploding lizan dicks push you over the edge.");
			if (player.cumQ() < 350) outputText("Your [face] twists around a strained groan and you spray your own impressive load deep into the lizan's bowels.");
			else if (player.cumQ() < 1000) outputText("Your [face] twists around a deep growl as you pour your load deep into the lizan's bowels. As you fuck your seed deeper into his clenching bowls you can feel some of it gushing out and dripping down your [legs].");
			else if (player.cumQ() < 2500) outputText("Your [face] twists into a chilling howl as you explode deep within the lizan's bowels. As you fuck your seed deep into his bowels his stomach becomes a little less defined, a testament to how much seed you've poured into him. You can even feel it dripping down your [legs].");
			else outputText("Your [face] twists into a titanic roar as [eachCock] explodes with enough force to blast out of the lizan's rectal embrace. Torrents of creamy white fluid blast from [eachCock]. Soon the lizan's upturned ass and the base of his tail is covered but you're still going. By the time you're finished the lizan is grinning from ear to ear amidst a small lake of cum.");
			outputText("\n\nSpent and breathing hard you collapse. For a second you just lie there [fullChest] against his abs and his legs wrapped around your [hips] while lying in the hot glorious mess of his lizan spunk. Both of you are panting, both of you have been satisfied. Then you push yourself off of him and go to collect your [armor]. He takes it upon himself to clean your [fullChest] with his tongue and as soon as he is done, " + player.clothedOrNaked("you pull on your [armor]", "you recollect whatever you had") + ". Before you leave, you reward him with a deep kiss, snaking your [tongue] into his mouth before heading back to camp.");
			flags[kFLAGS.LIZAN_ROGUE_SEX_COUNTER]++;
			player.orgasm();
			doNext(camp.returnToCampUseOneHour);
			if (getGame().inCombat) combat.cleanupAfterCombat();
		}
		
		public function consensualGetFucked():void {
			clearOutput();
			outputText("The lizan watches you with unabashed interest and asks \"<i>How would you like to do this?</i>\" you tell him you are going to ride him, which causes a huge grin to spread across his face. He confidently peels off his loincloth, exposing two bumpy purple erect lizan dicks not lacking in length or girth. He is a stunning visage with his " + monster.skinTone + " scales, powerful tail and dual cocks all on display for you, his audience of one.");
			outputText("\n\nWhen the two of you come together he displays his patience by sliding his hands onto your waist and pulling you into a kiss. As your tongues wrestle he massages your lower back and you feel the tension draining from your body. ");
			if (player.isLactating()) outputText("\n\nThe lizan begins to paint kisses down your neck, leaving a trail of tender suck marks in his wake. When he reaches your [fullChest] he takes one look at your [nipples] and cocks his head to the side in confusion. His tongue slips out to taste a single bead of creamy white, a taste you see repeated on the next breast. He seems to really like your lactating nipples. He opens his mouth wide and latches on to one of your [nipples], his hand playing with another. The tingling sensation he causes is quite pleasant. He quite happily slurps milk from your [nipples] and massages the soft flesh in a way that is both firm and erotic.");
			else if (player.hasFuckableNipples()) outputText("\n\nWhen he reaches your [fullChest] he takes one look at your [nipples] and does a double take. For a moment he is at a loss for words but when you clear your throat he quickly collects his wits and sticks his tongue into your fuckable nipples. The sensation is similar to getting your pussy licked but much higher up. You groan as he suckles each nipple in turn while massaging your [chest]");
			else outputText("\n\nWhen he reaches your [fullChest he takes one look at your [nipples] and dives right in. He makes a show of pulling one into his mouth. All you can see his his " + monster.skinTone + " lips but inside you can feel his tongue swirling around your sensitive nipples. He sucks off with a pop that sends a tingle down to your groin before he latches on to the next one and repeats this torturous practice.");
			outputText("\n\nOnce he's done with your [fullChest] you place your hand on his chest and use it to direct him to the ground. Once the lizan is on his back you select the dick you like more and begin sliding your hand up and down its rigid length. The shaft is covered in smooth textured bumps that will make sliding it in your [vagina] very interesting. Your gentle caress causes pearly white fluid to leak from the slit, which you use your thumb to rub across the crown.");
			outputText("\n\nWhen you begin to squat onto his throbbing member he says something about putting his other dick in your [ass] as well. You let him know that is not going to happen and, despite looking a little disappointed, he doesn't push the issue. He watches you with a bitten lip as you sit upon the swollen head of his lizan dick at the entrance to your [vagina].");
			if (player.averageVaginalLooseness() <= 1) { //Virgin or tight
				outputText("\n\nWith a deep breath you begin to slide the bumpy purple lizan dick up into your [vagina]. The sensation of being stretched wide hits you like a hammer and you have to go slow to keep from calling out. The lizan dick is like a hot slab of meat slowly, gloriously making its way deeper and deeper into your body. The bumps on its purple surface only serve to heighten the sensation as the irregular pattern rubs against your vaginal walls. ");
				outputText("\n\nYou don't quite make it to the base. Once you are filled to capacity you begin to slide back up, watching the lizan's yellow eyes roll.");
				outputText("\n\n\"<i>By Marae you're tight.</i>\" He sighs. Smooth scaly hands slide onto your [hips] but don't force you down. You can feel his other rigid member sliding up and down the crevice of your [ass], but not attempting to enter you. After you've gotten a little used to the girthy lizan dick you begin to increase the pace, feeling an intense pleasure erupting inside your [vagina] and soon you are sliding up and down his entire length, trembling with ecstasy.");
				player.cuntChange(24, true, true, true);
			}
			else if (player.averageVaginalLooseness() <= 3) { //Loose or stretched
				outputText("\n\nWith a sigh you begin to slide the bumpy purple lizan dick up into your [vagina]. A dick this size would be a hot fuck by itself but the bumpy purple surface is making the experience delightfully erotic. His girthy dick his hot and glorious, you feel as though you could just slide down its bumpy purple surface all day.");
				outputText("\n\nYou move slowly, looking down into his yellow eyes as he bites his lip. His other lizan dick slides up and down the crevice of your [ass], not an attempt to enter but a result of the two being so close together. After a few minutes your slow ride becomes unbearable to the lizan. His hands take you by the [hips]. With a groan he begins to pull while thrusting upward into you. You release a hoarse groan as the sensations caused by his dick intensifies. Soon you are trembling and from the way he's fucking you it appears the lizan is enjoying every second of your ecstasy.");
				player.cuntChange(24, true, true, true);
			}
			else { //Gaping
				outputText("\n\nGrinning with confidence you slide down the entire length of the lizan's bumpy purple dick in one go. While he is reasonably well endowed you know from experience that you can fit more. His other bumpy purple member is sliding up the crevice of your [ass], when you grab it he gives you his biggest, sexiest grin obviously thinking you are going to take him up on his earlier offer to fuck both your [vagina] and [asshole] at the same time.");
				outputText("\n\nWith a grin you lift up and press the twin dicks together. The lizan's jaw drops as your [vagina] slowly engulfs both of his fuck poles inch by inch. The lizan groans as you begin to slide up and down, slowly allowing his trembling cocks get used to being pushed together and enveloped. Meanwhile the lizan himself is obviously at your mercy. His body cringes, his voice whines, his toes flex and his eyes roll as you slowly ride both of his peckers.");
				outputText("\n\nYou decide to speed up, increasing the glorious stretching sensation of his bliss inducing fuck poles. Soon the he completely loses control and begins thrusting into your [vagina] with rough thrusts that can only signal an impending orgasm. You meet his mad lust with your own, the two of your bodies creating a sound akin to applause.");
				player.cuntChange(48, true, true, true);
			}
			if (player.hasCock()) { //Herm check!
				outputText("\n\nAs he fucks your [vagina] with all that he's worth you take the liberty of grabbing your [cock] and stroking the already rock hard sex organ to further increase the intensity of your own sexual stimulation. He looks down at your [cock], his tongue sliding across his lips displaying his obvious interest. You are soon lost in the bliss of your impending orgasm as he continues to pound upward into your [vagina] with steadily mounting force.");
			}
			if (player.averageVaginalLooseness() <= 3) { //Not gaping
				outputText("\n\nHe looks up at you in desperation as you stare down at him. Suddenly his entire body slams upward as he grabs you by the waist and explodes deep within your [vagina].");
				if (player.tailType > 0) outputText("His other lizan cock explodes as well, painting your raised [tail] and [ass] with a generous coating of funky lizan spunk.");
				else outputText("His other lizan dick explodes as well, painting your [ass] and lower back with a generous coating of lizan baby batter.");
			}
			else { //Gaping
				outputText("\n\nWith a sigh you begin to slide the bumpy purple lizan dick up into your [vagina]. A dick this size would be a hot fuck by itself but the bumpy purple surface is making the experience delightfully erotic. His girthy dick his hot and glorious, you feel as though you could just slide down its bumpy purple surface all day.");
				outputText("\n\nYou move slowly, looking down into his yellow eyes as he bites his lip. His other lizan dick slides up and down the crevice of your [ass], not an attempt to enter but a result of the two being so close together. After a few minutes your slow ride becomes unbearable to the lizan. His hands take you by the [hips]. With a groan he begins to pull while thrusting upward into you. You release a hoarse groan as the sensations caused by his dick intensifies. Soon you are trembling and from the way he's fucking you it appears the lizan is enjoying every second of your ecstasy.");
			}
			if (player.hasCock()) {
				outputText("\n\nAs you reach the point of no return both your [vagina] and [cock] begin to tremble. With your eyes lifted to the sky, you scream a scream of pure unadulterated pleasure as your [vagina] floods while your [cock] explodes.");
				outputText("\n\nThe dual sensations are tidal waves of euphoria crashing through your body, increasing in intensity as you paint the lizan's chest, stomach and thighs and pelvis. When the sensations streaming from your sex organs reach their apex you feel as if you're about to explode. Just in time the sensation diminishes, leaving you tingly and overly sensitive in its wake.");
			}
			else {
				outputText("You begin to cum so hard your body trembles. Your [vagina] tingles and your entire being feels as if you're falling through an ocean of pure ecstasy. Your body quakes as your climax rages on, filling your entire being with so much pleasure you can't take it. Just before you feel as if you can't take it anymore the sensation begins to recede, leaving your body achingly sensitive in its wake.");
			}
			outputText("\n\nFor a second you lie there [fullChest] against his " + monster.skinTone + " abs. Around the two of you lies the hot glorious mess of your combined sexual fluids. Both of you are panting, both of you are satisfied. Then you push yourself off of him and collect your [armor]. He takes it upon himself to clean your [fullChest] and [vagina] with his long tongue and as soon as he is done, " + player.clothedOrNaked("you pull on your [armor]", "you recollect whatever you had") + ". Before you leave you reward him with a deep kiss, snaking your [tongue] into his mouth before heading back to camp.");
			player.knockUp(PregnancyStore.PREGNANCY_OVIELIXIR_EGGS, PregnancyStore.INCUBATION_OVIELIXIR_EGGS);
			player.createStatusEffect(StatusEffects.Eggs, rand(6), 0, rand(3) + 5, 0);
			flags[kFLAGS.LIZAN_ROGUE_SEX_COUNTER]++;
			player.orgasm();
			doNext(camp.returnToCampUseOneHour);
			if (getGame().inCombat) combat.cleanupAfterCombat();
		}
		
		public function consensualGetButtFucked():void {
			clearOutput();
			outputText("The lizan watches you with obvious interest and asks \"<i>How do you want to do this?</i>\" You tell him you want him to take your back door, which causes a surprised grin to stretch across his face. He confidently peels off his loincloth, exposing two bumpy purple lizan dicks not lacking in length or girth.");
			if (player.isBiped()) {
				outputText("\n\nTurning away from the lizan you peel off your [armor]. You bend at the waist " + (player.tailType > 0 ? "and lift your tail": "") + " to show the lizan your [ass]. He wolf whistles, obviously quite pleased. He takes the liberty of pushing you on to your hands and knees. While looking down at the grass you feel his cool scaly hands sliding up your [ass], getting a good long feel before his tongue is pushed into your [asshole].");
				outputText("\n\nYou spread your legs to give the talented lizan full access as his firm, wet tongue tunnels into you, making you squirm as waves of euphoric delight fills your body. Whenever you think his tongue will end it surprises you by tunneling deeper. Like a wet slimy endless snake it winds its way through your anal sleeve, filling your body with agonizing pleasure.");
			}
			if (player.isNaga()) {
				outputText("\n\nYou turn away from the lizan and arch your back, proudly putting your [ass] on display. He wolf whistles, obviously quite pleased with what he sees. He takes a moment to get a good grip of your [ass], playing with your rear and rubbing your [legs]. When he suddenly pulls your [ass] into his face its so unexpected you give a startled jolt. Then his tongue invades your [asshole].");
				outputText("\n\nYour bottom half coils around the lizan's lean midsection as his talented tongue squirms around your insides, pushing into you and making you groan in ecstasy. The odd and erotic sensation makes you long for something stiff to be shoved into your [asshole].Whenever you think his tongue will end it surprises you by tunneling deeper. Like a wet slimy endless snake it winds its way through your anal sleeve, filling your body with agonizing pleasure.");
			}
			if (player.isTaur()) {
				outputText("\n\nThe lizan aims a underhanded smack at your [ass], getting a good grope in the process. Before you can turn to protest he shoves his face into your [ass] and his long slippery tongue slides against your [asshole].");
				outputText("\n\nYou paw the ground as the lizan's tongue penetrates your back passage. He laps at your [asshole] with the skill of a seasoned pro before pushing his tongue into you. The oral penetration causes all kinds of strange sounds to come out of your throat. Whenever your think his tongue will end it surprises you by tunneling deeper. Like a wet slimy endless snake it winds its way through your anal sleeve, filling your body with agonizing pleasure.");
			}
			if (player.hasVagina()) {
				outputText("\n\nAs he tongue fucks your [asshole] he uses a single scaled digit to rub your [clit], causing a sudden shiver of longing to jump up your spine. He doesn't even try to penetrate your [vagina], he just teases the surface and makes you moan.");
			}
			if (player.hasCock()) {
				outputText("\n\nAs he continues to shove his tongue in and out of your now relaxed and receptive [asshole] his scaled hand slides down to your [cock]. He firmly tugs it down before sliding his soft thumb up the underbelly and playfully teases your dick-slit, smearing your [cockHead] with your own precum.");
			}
			outputText("\n\nAnother shiver rocks your body as he pulls his long tongue out of your [asshole]. He takes both of his lizan dicks and places them in the crevice of your [ass] and begins teasing your [asshole] with slow strokes as his free hand grip your [ass]. Both of his pumpy purple lizan dicks feel good as he continues to tease you until you can't stand it. " + (player.hasVagina() ? "He asks if he can put his other lizan dick in your [vagina] and you tell him, in no uncertain terms, that your front door is off limits. He takes it in stride, not pushing the matter.": "") + "Then he plants his feet and lines his lower dick up with your [asshole] and pushes it in.");
			player.buttChange(24, true, true, true);
			if (player.looseness(false) < 2) {
				outputText("\n\nThe large head stretches your tight little chute upon entry. Thanks to the lizan's oral preparations and slow incursion there's no pain but the sensation is uncomfortable at first. As he gently rocks his bumpy phallus into your [asshole] his scaled hands stay at your waist, firmly holding you in place as your body flinches of its own accord.");
				outputText("\n\nOnce you feel the lizan's trunk softly mash against your upturned [ass] you begin to feel a sense of accomplishment for having taken a cock as big as his. His second member lies against the crevice of your [ass], causing a tantalizing sensation above your stuffed bowels.");
				outputText("\n\nThe lizan begins to move slowly and an empty feeling follows his mushroom shaped head before you are slowly filled again. When a groan finds its way you of your lips he increases the pace. As you slowly get used to the sensation he slowly speeds up. You have to admit his patience is impressive. When his thrusts begin to make noise against your [ass] you can feel a sense of hunger, a desire to be fucked until you're clawing at the ground. All too soon your desire is met with a hard clapping sound as the lizan reaches top speed, fucking you with gusto as his free phallus slides up and down the crevice of your [ass].");
			}
			else if (player.looseness(false) < 4) {
				outputText("\n\nAs the large head penetrates your [asshole] you and the lizan release resonating twin groans. He underhooks his arms around your shoulder and licks you back, telling you your hole is perfect. He begins to rock back and forth, reveling in the tightness of your anal walls. His slowness is another tease, just like when he tongue fucked you it only serves to make you want him more. ");
				outputText("\n\nThen he shafts you, embedding his entire length into your [asshole] while pulling you back, his strong arms firmly holding his entire length inside of you as your body instinctively squirms. You can feel his free dick release a pearl of hot sticky pre onto your split [ass].[cock] At your instance he picks up the pace. Soon he is pounding your [asshole] with reckless abandon, even pulling you into his thrusts as you grab fistfulls of grass and hold on for dear life. You arch your back and he begins to drill even deeper, each slam into your [ass] causing your body to quiver in pure ecstasy.");
			}
			else {
				outputText("\n\nThe lizan pushes into your [asshole] with a swoon, bottoming out instantly. As he begins to move through your body you get a great idea. With a grin you glance over his shoulder and ask him if he wants to stuff both of his dicks into your [ass].");
				outputText("\n\n\"<i>Fuck yeah!</i>\" He says after his initial surprise is gone from his cute face. Then with a grin on his face like a kid in a candy store, he stuffs both of his lizan dicks into your [asshole]. The lizan groans as his shafts are pressed together inside of you. You begin to rock back onto an awestruck lizan, showing him that you can take it. With a roar of triumph he grabs your waist and begins roughly fucking both of his lizan dicks into your [asshole] with all the force he can muster. He leans into you, repositioning to fuck deeper into your [asshole], even pulling you back into his thrusts to increase the force of your wild fucking.");
			}
			if (player.gender == 1) outputText("\n\nThe lizan reaches around you, taking a hold of your [cock] while continuing to pound your [asshole] inward. The dual sensations are too much and you can feel yourself being pushed over the edge."); 
			if (player.gender == 2) outputText("\n\nThe lizan reaches around you, and begins to play with your [clit], before dipping his finger into your [vagina]. The dual sensations are too intense and you begin to feel yourself being pushed over the edge.");
			if (player.gender == 3) outputText("\n\nThe lizan reaches around you, taking a hold of your [cock] while he also begins to play with your [clit], before dipping his finger into your [vagina]. The dual sensations are too intense and you begin to feel yourself being pushed over the edge.");
			outputText("\n\nWith a hoarse groan you reach your climax.");
			if (player.hasCock()) outputText("\n\nThe lizan's grip on your [cock] tightens and with a sudden shiver you're gushing into his hand.");
			if (player.hasVagina()) outputText("\n\nYou shiver as the finger inside your [vagina] is painted with evidence of your orgasm.");
			outputText("\n\nYour orgasm seems to spur the lizan on. His thrusts become irregular before he tightens his grip on your waist. He shoves in to the hilt and, yelling like a madman, explodes. You feel his cum surging into your [asshole] as a hot warmth swells " + (player.hasVagina() ? "and dribbles out of your [vagina] and " : "") + "down your [legs] in a sticky stream of lizan dick juice.");
			outputText("\n\nYou spend some time cuddling, the lizan's still on your back with his warm cock in your [asshole]. Eventually, you get up and give him a deep kiss before you return to your camp.");
			flags[kFLAGS.LIZAN_ROGUE_SEX_COUNTER]++;
			player.orgasm();
			doNext(camp.returnToCampUseOneHour);
			if (getGame().inCombat) combat.cleanupAfterCombat();
		}
		
		public function consensualDoublePenetration():void {
			clearOutput();
			outputText("The lizan watches you with obvious interest and asks \"<i>How do you want to do this?</i>\" you tell him you're going to ride him until the wheels come off, which causes a surprised grin to stretch across his face. He confidently peels off his loin cloth, exposing two bumpy purple lizan dicks not lacking in length or girth.");
			outputText("\n\nHe steps into you, leaning in for a kiss. As you kiss him you wrap your arms around his shoulders and he reaches down to cup your [ass], massaging your rear end with deligted fingers. Then he breaks the kiss and begins painting kisses down your neck.");
			if (player.isLactating()) outputText("\n\nWhen he reaches your [fullChest] he takes one look at your [nipples] and cocks his head to the side. He takes a tentative slurp and looks up into your [face] as if to ask if milk coming out of your tits is normal. You just nod and he shrugs and begins playing with your [fullChest] like a happy kid at the park. At one point his tongue slithers across each nipple at once as if to see if the milk coming from each tastes the same. He quite happily slurps milk from your [nipples] and massages the soft flesh in a way that is both firm and erotic.");
			else if (player.hasFuckableNipples()) outputText("\n\nWhen he reaches your [fullChest] he takes one look at your [nipples] and does a double take. For a moment he is at a loss for words but when you clear your throat he quickly collects his wits and sticks his tongue into your fuckable nipples. The sensation is similar to getting your pussy licked but much higher up. You groan as he suckles each nipple in turn while massaging your [chest].");
			else outputText("\n\nWhen he reaches your [fullChest he takes one look at your [nipples] and dives right in. He makes a show of pulling one into his mouth. All you can see his his " + monster.skinTone + " lips but inside you can feel his tongue swirling around your sensitive nipples. He sucks off with a pop that sends a tingle down to your groin before he latches on to the next one and repeats this torturous practice.");
			outputText("\n\nOnce he's finished with your [nipples] his lips find yours again and you can taste yourself on his tongue as it dives right into your mouth.");
			if (player.wingType > 0) outputText("\n\nAs he kisses you his hands graze your [wings]. He lightly massages the base, causing an odd rolling sensation that is actually kind of pleasant. Despite this you get the feeling he's just curious to touch them. He's very tender with your [wings] as if he doesn't want to hurt you. Once his curiosity has been sated though he releases the base of your [wings] and pulls you into him, your lips still locked together.");
			outputText("\n\nHis hands slide down to your [ass]. He gets a good grope in, massaging your rear and using it as a lever to pull you against him. " + (player.tailType > 0 ? "He even wraps his scaled hand around the base of your [tail], softly massaging the point where it meets your [ass].": "") + "");
			if (player.hasCock()) outputText("\n\nYou gasps against his lips as he wraps a hand around your [cock]. He rubs its rigid surface, firmly tugging your [cock] as smacks your [ass]. As his hands massage and grips [eachCock] you can't help sliding your hands across his body, pulling him into you as your mouths remain locked together.");
			outputText("\n\nOnce the touchy feely face sucky grope fest is over he takes you by the hips, whirling you around. Something about you is driving the lizan mad. His dual peckers split across your body, one sliding against your [vagina] while the other slides up into the crevice of your [ass]. He says something about fucking both your holes and with a grin you tell him to go for it.");
			if (player.looseness(false) < 2) {
				outputText("\n\nThe lizan spreads your [ass], obviously set on entering from the rear first. When he gets a good look at your [asshole] you hear a low whistle. He spits onto his cock several times, making sure it is extra slick before he presses the swollen head against your [asshole].");
				outputText("\n\nA grunt forces its way out of you clenched teeth as the large cock forces your anal ring to widen around its mushroom shaped head. Thanks to his last minute preparations the lizan slides in without causing you too much pain. Even so he maintains a strong grip around your waist as he rocks in and out of your [asshole] until his scaled trunk presses into your [ass], his dick fully submerged in your anal depths. He grinds his hips into you, causing you to tremble as your voice strains into fluttering yelp.");
			}
			else if (player.looseness(false) < 4) {
				outputText("\n\nThe lizan spreads your [ass], obviously set on entering you from the rear first. You feel a glob of spit land on your upturned [asshole]. The sudden coolness of the saliva dripping down your hole is quickly followed by the large head of the lizan's cock.");
				outputText("\n\nYour voice vibrating your chest and stretching out into infinity is all the incentive the lizan needs. He slides his big bumpy dick into your [asshole], his hands pulling your [ass] back into him. Once he's burried the full length of his big purple dick in your backdoor he begins swirling his dick around in your guts, causing you to groan loudly as you push back against his large dick.");
			}
			else {
				outputText("\n\nThe lizan spreads your [ass], obviously set on entering you from the rear first. When he gets a good look at your [asshole] he shoves his fist into the air. He happily enters you after taking a moment to spit shine his bumpy purple dick. As his cock tunnels through you you make sure to squeeze it, massaging the lizan as he begins t swirl his cock around inside of you as if trying to stir your guts.");
			}
			player.buttChange(24, true, true, true);
			outputText("\n\nThe Lizan then slides himself out of your [asshole] until the mushroom shaped head of his cock is all that remains in your rear. He reaches around and pulls his other cock up, aiming for your [vagina] as he pushes forward.");
			if (player.looseness(true) < 2) {
				outputText("\n\nAs his giant cock penetrates your [vagina] you can't help but tremble. He takes it slow, allowing your mind to make sense of the dual sensations erupting within your body. The cocks slowly invade your two holes. The lizan is careful to gently rock himself into your [pussy] even though your [asshole] has already eagerly accepted his invasions. You calm yourself, attempting to relax until you feel his trunk mash against your [ass], both dicks buried within you.");
			}
			else if (player.looseness(true) < 4) {
				outputText("\n\nAs his large cock penetrates your [vagina] you find yourself squeezing his invading sex organ. He tells you how much he likes that by kissing your neck as he rubs your lower back just above your [ass]. He slowly begins to stir both of his dicks around inside you, holding you tightly as he shudders while being enveloped by your [asshole] and your [pussy].");
			}
			else {
				outputText("\n\nAs his impressive cock penetrates your [vagina] you find yourself pushing back into him with greedy need. He fills the hungry space inside your pussy with a single sharp thrust. Strong arms pull you back.");
			}
			player.cuntChange(24, true, true, true);
			outputText("\n\nThen the lizan begins to unceremoniously fuck your brains out. With his hands wrapped around your waist he pounds your [vagina] and you [asshole] inward with reckless thrusts that cause you to shudder and shout. He fucks you standing, his hips clapping against your upturned [ass] as he jerks you back into his rapid thrusts.");
			outputText("\n\nHis hurried fucking of both of your holes is causing your entire body to tingle as you are crushed under waves of pure delight. From the way he soundly fucks you into a frenzy you know he's enjoying every moment of your body just as you enjoy every moment of his.");
			if (player.hasCock()) {
				outputText("\n\nYou hear the lizan spit into his hand. He then reaches around and begins fisting your [cock] as he continues to fuck you senseless. With your [asshole], [vagina] and [cock] being manipulated by this eager young master it doesn't take long for you feel the familiar sensation. As if sensing this he grips your [cock] as tightly as its girth will allow around the base and uses it to hold you steady as pounds your [asshole] and [vagina] inward.");
				outputText("\n\nFinally you can take it no more and, throwing your head towards the sky, you cum.");
				if (player.averageVaginalWetness() >= 4) outputText("\n\nYour [cock] and [pussy] explode in dual torrents of creamy white ejaculants, both erupting like volcanoes as the lizan continues to work you over.");
				else outputText("Your [cock] erupts as your [pussy] floods around the lizan's still thrusting cock.");
				if (player.cumQ() >= 1000) outputText("The lizan squeezes your still spurting [cock] as beneath the two of you your pearly white dick snot forms a large puddle.");
			}
			else {
				outputText("\n\nThe lizan continues his aggressive assault of your dual holes. Finally you can take it no more and, throwing your head towards the sky, you cum.");
				if (player.averageVaginalWetness() >= 4) outputText("\n\nYour [pussy] erupts like a volcano around the lizan's cock as he continues to pound you with reckless need. The gushing fluid runs down both of your legs as he releases a surprised yet approving grunt.");
				else outputText("\n\nYour [pussy] floods with girlcum as the dicks pound you. Your voice stretches on for an eternal howl that displays how good it feels.");
			}
			outputText("\n\nThe lizan kisses your shoulder as you cum but he doesn't slow down. He keeps up this pace, showing off his control and endurance as he makes you cum again and again. The intensity of the sensations soon causes you to scream to the heavens with every orgasm. As if sensing that you've reached your limit the lizan doubles down, fucking your [asshole] and [pussy] with hard thrusts that echo through the bog until he floods both of your tired holes with copious amounts of lizan spooge, just in time to set off the last orgasm you can stand to have back to back.");
			outputText("\n\nDripping and sore you tolerate the hard slap to your [ass] the lizan gives you.");
			outputText("\n\n\"<i>By Marae that was… wow,</i>\" he says. You agree moments before his lips press into you and his tongue slithers into your throat to wrestle with yours. Then the two of you separate, your [legs] feeling wobbly as you stumble away. He hands you your [armor] and gives you a grateful smile before turning away, grabbing his loincloth, and walking away without putting the cloth or his pack on.");
			outputText("\n\nWhen you begin to head back to camp you can hear the lizan gleefully whistling behind you as he returns to his home");
			player.knockUp(PregnancyStore.PREGNANCY_OVIELIXIR_EGGS, PregnancyStore.INCUBATION_OVIELIXIR_EGGS);
			player.createStatusEffect(StatusEffects.Eggs, rand(6), 0, rand(3) + 5, 0);
			flags[kFLAGS.LIZAN_ROGUE_SEX_COUNTER]++;
			player.orgasm();
			doNext(camp.returnToCampUseOneHour);
			if (getGame().inCombat) combat.cleanupAfterCombat();
		}
		
		public function consensualWatersports():void { //Yay watersports!
			clearOutput();
			outputText("A kinky idea crosses your mind. You tell him that you'd like to take things a bit further. \"<i>I get it. Some urine activity,</i>\" he says. " + player.clothedOrNaked("You slowly disrobe and toss your [armor] into a neat pile on one of the nearby trees.", "You don't waste time showing your naked form to the lizan.") + " The lizan slowly strips his loincloth off, exposing his wonderful dual reptilian cocks.");
			outputText("\n\n\"<i>You can go first,</i>\" he says. You thank him for letting you go first. ");
			if (player.hasVagina() && !player.hasCock()) {
				outputText("You squat over the lizan and release your pressure, a stream of warm urine flows from your vagina");
			}
			else if (player.hasCock()) {
				if (player.cocks.length == 1) outputText("You stand in front of the lizan and aim your [cock] at him and release your pressure, a stream of warm urine flows from your penis");
				else outputText("You stand in front of the lizan and aim your [cock] at him and release your pressure, streams of warm urine flow from your multiple cocks");
			}
			else { //Just because you're a genderless doesn't mean you can't pee.
				outputText("You squat over the lizan and release your pressure, a stream of warm urine flows from your groin despite your genderlessness");
			}
			outputText(" and onto his belly. ");
			awardAchievement("Urine Trouble", kACHIEVEMENTS.GENERAL_URINE_TROUBLE, true, false);
			outputText("\n\nThe lizan rubs his belly, enjoying the warm urine you're giving him. By now, your bladder is empty and you make sure to get the last of your urine out. He scoops up the murky water, washes off the urine and gets up. \"<i>All right, now it's my turn. I need release too,</i>\" he says.");
			outputText("\n\nYou comply and lean back against the tree. He aims his twin cocks towards you and begins peeing all over you. It feels good with his warm urine on your body. He aims left and right, his urine streams go wide and splash into the murky waters. He aims back at you again, letting you revel in his warm urine.");
			outputText("\n\nHis urine flows eventually stop and you scoop up some murky water to wash off the urine.");
			dynStats("lus", 10);
			menu();
			addButton(0, "Continue", haveSexWithLizan, true, null, null, "Continue having sex.");
			addButton(1, "Done", finishWatersports);

		}
		
		private function finishWatersports():void {
			outputText(" You cuddle with the lizan for a moment before you have to part ways" + player.clothedOrNaked(" and redress yourself in your [armor]", "") + ".");
			outputText("\n\n\"<i>I hope you come back later,</i>\" the lizan says with a smile. You give him a kiss before you return to your camp.");
			doNext(camp.returnToCampUseOneHour);
			if (getGame().inCombat) combat.cleanupAfterCombat();
		}
		
		public function rapeLizanInTheAss():void {
			clearOutput();
			if (monster.lust >= monster.eMaxLust()) {
				outputText("The lizan does little to resist. He just continues his intense masturbation as you push him over to make his rectal passage more accessible. The horny guy even lifts his tail, eagerly giving you access to his back door. From the look of things he is neither a virgin nor a frequent taker. ");
				outputText("\n\nWith his chest on the ground he continues to pump his cocks, his hole winking in invitation. When you slide your hands across his self parting ass cheeks he arches his back and groans, begging for it. Not being one to disappoint you spit into your hand while marveling at how simple lust has turned this pure creature into your hot little boy slut. After spit shining your [cock] you aim it towards the horny guy's back door, and enter without one thought of knocking.");
				if (player.smallestCockLength() < 7) outputText("\n\nThe lizan groans as you sink into his heated tunnel. With your [cock] inside his anal ring flexes against you, tightening around your dick as he pushes back against you. You grab his hips and begin roughly pounding the lizan's hole. With every rough thrust the lizan spreads his legs and tail, attempting to allow you deeper access. As you wreck his ass with your [cock] he continues pumping his dual dicks, even as his chest and chin slide through the dirt. You toss your head back, lost in the sensation of his squeezing hole while he obviously loves the feeling of your [cock].");
				else if (player.smallestCockLength() < 11) outputText("\n\nThe lizan squirms as you sink into his hot, tight tunnel. You can feel his anal ring quivering around your [cock] as you forcibly hilt him. The lust crazed lizan begins to rise for some reason and you have to shove his chest back into the ground, keeping your weight on his back. When you begin pounding the shape out of the tight fitting rectal passage he spreads his legs and tail to give you deeper access. The lizan grunts with every brutal thrust as you violently take his ass in deep full length thrusts. His hot little tail hole is a perfect combination of heat and tightness and you and your [cock] relish beating the little puckering hole inward.");
				else {
					outputText("\n\nThe lizan yelps and squirms as your [cockHead] begins to stretch his anal ring wide. It is hard work to force the rest of your [cock] into the lizan's unaccommodating back door. He doesn't seem to be in pain though, quite the opposite, his hands feverishly pump his dual cocks with renewed vigor as he spreads his legs in an attempt to open up for you. Inch by inch you slide in, tugging the lust crazed lizan’s slender hips while thrusting forward.");
					outputText("\n\nOnce you've buried your entire bone in the lizard man’s backyard an intense spasm rocks his body. His tail curls around you, holding you close as his anal walls clench and you know he has just sprayed the bog floor with lizan spooge. Once his tail loosens its grip you grab his hips and begin pounding the lizan's tight little tail hole into a new shape. You have to maintain your hold to keep him in position. His ass is a hot tunnel that fights you of its own accord but with every thrust you feel yourself slowly winning this uphill battle. The problem is that you’re just too big but that doesn’t stop you from enjoying the lizan’s upturned hole as he squirms and groans, too lost in pleasure to do anything else.");
				}
				outputText("\n\nYour brutal thrusts coupled with his lust addled brain sends the lizan over the edge. As he reaches climax his hole begins to milk your deeply embedded [cock]. As his orgasm makes his body spasm you can feel your own orgasm building until you're exploding, still pounding the lizan into the bog floor as the two of you spill your seed together.");
				if (player.cumQ() >= 1000) outputText("\n\nYou continue to fuck him into the bog floor as your seed pours out of you. With every thrust his stomach swells until he looks pregnant.");
				else if (player.cumQ() >= 2500) outputText("\n\nYou continue to pound him as your seed pours out of you. Every thrust causes it to spurt out of his tail hole. Soon you’re fucking him into a lake of semen even as his lizan’s stomach swells till he looks pregnant.");
			}
			else {
				outputText("The lizan protests weakly as you grab his ankles, as if he could do anything to stop you from flipping him over after the beating you gave him. Once he is in position he stubbornly keeps his tail wrapped around his body. A body jarring slap to his exposed cheek is all it takes to get him to unwrap and lift his tail.");
				outputText("\n\nFrom the looks of things he's no virgin but neither does he look like a frequent taker. When you slide a curious finger across the surface of his little hole he tenses before arching his back and you can see his little rose bud relax. You spit into your hand and begin lubing up your [cock] and aim it towards the beaten lizan's back door.");
				if (player.smallestCockLength() < 7) outputText("\n\nThe lizan fails to suppress an unwilling groan as your [cockHead] sinks into his heated tunnel. Once your entire [cock] is fully submerged you can feel his anal ring flexing. You grab his hips and begin roughly pounding the lizan's hole inward. He holds his mouth shut, obviously trying to stifle the soft sounds of pleasure. You smile when he arches his back to give you deeper access and, after a few body jarring thrusts, spreads his legs and lifts his tail. Yet he is still unwilling to admit how much he loves your [cock] he continues to unsuccessfully suppress the ecstasy apparent in his deep voice.");
				else if (player.smallestCockLength() < 11) {
					outputText("\n\nThe lizan fails to suppress an obviously unwanted groan as your [cockHead] sinks into his heated tunnel. You can feel his anal ring quivering around your [cock], squeezing as you stretch him open. The beaten lizan yelps as you give him a sudden thrust. When you grab his hips and begin pounding the shape out of his tight fitting rectal passage he growls up at you, looking furious.");
					outputText("\n\nHe suddenly arches his back and lifts his tail, allowing you to drill deeper into his innards. Now you're fully hilting the lizan with your [cock] at top speed and it is glorious. His hot little tail hole is a perfect fit and you relish beating the little sucker into submission with your [cock]. Yet he is still unwilling to admit how much he loves your [cock] as he continues to unsuccessfully suppress the ecstasy apparent in his deep voice.");
				}
				else {
					outputText("\n\nThe lizan releases a loud yelp as your [cockHead] splits him open. Once you have breached his anal walls it is tough work to bury the rest of your [cock] into his tight little body. He flinches every time you rock your hips, forcing more of your [cock] into him. Thanks to the beating you gave him he can barely run from your forceful entry.");
					outputText("\n\nDespite this he arches his back perfectly in an attempt to give you deeper access. Once you've managed to force your entire length into his backdoor the lizan's body spasms and you can feel his rectal passage quiver against your embedded [cock]. With a grin you realize he is in the throes of an annaly induced orgasm.");
					outputText("\n\nYou grab him by his slender hips and begin pounding the lizan's tight little tail hole into a new shape. He allows your brutal thrusts to penetrate him without resisting, even squeezing as your truck slams into his upturned ass. The little self righteous butt slut seems to be enjoying himself. Yet he is still unwilling to admit this obvious fact as he continues to unsuccessfully suppress the ecstasy apparent in his deep voice even though he just came a few moments ago. So you fuck him into the bog floor. You listen to every quivering note he fails to suppress and really give it to him, reveling in your ability to make his entire body quake with desire.");
				}
				outputText("\n\nThe lizan's hole begins to quiver around your quickly thrusting [cock]. Your brutal thrusts into his sensitive tail hole are sending him over the edge. As he reaches his climax and begins spraying the bog floor with lizan seed his tight little tail hole begins to milk your embedded [cock].");
				outputText("\n\nYou fuck into the glorious feeling of his clenching hole until you reach your own climax. Your seed blasts into the lizan's little hole, fucking your seed deep into his little body as you spray his innards with your baby batter.");
				if (player.cumQ() >= 1000) outputText("\n\nYou listen to the lizan growl as your dick pumps him full and overflowing. Your creamy seed leaks down your [legs]. Soon his stomach is swollen slightly from the amount of cum sloshing around in his stomach.");
				else if (player.cumQ() >= 2500) outputText("\n\nYou listen to the lizan squeal as your spasming dick pumps him full and overflowing. By the time you’re done cumming he is not only lying in a small lake of hot cum but looking pregnant from the seed sloshing around in his stomach.");
			}
			outputText("\n\nYou leave the passed out lizan where he lies, his newly abused little hole dripping your cream. You raid his pack and leave.");
			player.orgasm();
			combat.cleanupAfterCombat();
		}
		
		public function rapeLizanWithPussy():void {
			outputText("With a grin you slip off your [armor], the lizan doesn’t fight it in the least. In fact as you shove him onto his back he breathes a sigh of relief. Despite your having beaten him he is obviously quite attracted to you. He groans when you grab his twin peckers and inspect them. Each irregularly patterned bump is mirrored on its counterpart, like two sexy phallic twins. They grow hard in your hand. With a grin you look up into his face and watch his sexual attraction war with his lofty morals.");
			outputText("\n\nWhen you straddle him with his lizan dicks pointed up at your [vagina] you look down into his eyes and watch as your body causes his lust to win the war.");
			if (player.looseness(true) < 2) {
				outputText("\n\nWith a deep breath you descend, engulfing only one of his purple dicks. The sensation of your [vagina] being spread open by his cock his like an electric wave of tingling ecstasy. Below you the lizan cringes, eyes wide as he feels how tight you are. You revel in the power you have over him. Soon his hands slide onto your hips and he begins thrusting up into your [pussy].");
				player.cuntChange(24, true, true, true);
				outputText("\n\nYou sit upon a living throne of hot flesh. Your lust crazed servant worships your body with his hands and mouth, grinding his cock around inside your [pussy]. You can barely stand the way the large organ swirls around inside you, so deep inside you as it stretches your vaginal walls wide open. Yet you endure the mind numbingly intense sensations because a true monarch would never abdicate [his] throne.");
			}
			else if (player.looseness(true) < 4) {
				outputText("\n\nWith a sigh, you descend, engulfing one of his bumpy purple dicks. The tingling feeling of fullness hits you as one cock slides up into your [vagina] while the other slides against your [asshole]. Below you the lizan cringes, eyes wide as he you slowly ride him. You watch a war of emotions stream across his face. Disbelief rages against desire, pride slowing loses to lust. Soon all the right emotions prove victorious as a decision is made. Two scaled hands slide onto your waist as he begins thrusting up into your [pussy].");
				player.cuntChange(24, true, true, true);
				outputText("\n\nYou smile upon your living throne of hot flesh. Your lust crazed servant worships your body with his hands and mouth as he grinds around inside your [pussy]. His lips suck your [chest] one nipple at a time as his hands rub and massage your body. Chest to chest he serves you like the monarch you are.");				
			}
			else {
				outputText("\n\nWith a grin you press both of his lizan cocks together and descend, engulfing them both. Inside you feel blissfully full, your very experienced [vagina] more than able to take the combined girths. Beneath you the lizan’s entire being cringes with disbelief. His breaths are ragged, his voice on edge as he says, “Gods give me strength.” Then the war of emotions begins. His face contorts as duty and pride struggle valiantly against desire. You squeeze his dicks together and the tide turns. His hands slide onto your hips and he thrusts upward, eyes flooded with desire.");
				player.cuntChange(48, true, true, true);
				outputText("\n\nYou grin in triumph as you sit upon your living throne of hot flesh. Your lust crazed servant worships your body with hand and mouth as he grinds his dual peckers around inside your [pussy]. Eager lips suck your [nipples] one at a time as his hands rub and massage your body. Chest to chest he gets lost in your regal splendor, serving you like the monarch you are.");
			}
			outputText("\n\nYou take control, your hips swirling as you bounce up and down. The mind numbing pleasure of your ride is just what you need. Beneath you the lizan gasps and trembles. He holds on for dear life as you ride him hard.");
			if (player.hasCock()) outputText("\n\nThen you feel an unexpected wetness. Looking down you watch your servant open his mouth and lick your [cock] again. The trembling lizan tastes you, kissing your [cockHead] and nibbling at its belly. Then he looks up and kisses you and you taste your [cock] on his lips.");
			outputText("\n\nHis voice comes out in a hoarse groan as he begins to tremble. You’re riding him as hard as you can now, making him babble like a mad man. His arms hold you tightly as he buries his face in your [fullChest]. You keep up the pressure and soon a strangled cry rises from your servant as heat blooms inside of you. The feeling pushes you over the edge and you erupt, flooding his ejaculating cocks with your vaginal fluids. " + (player.hasCock() ? "Meanwhile, your cock is spurting hot seed into your combined chests." : ""));
			outputText("\n\nYou leave the passed out lizan where he lies, covered in your combined sexual fluids. You raid his pack and leave.");
			player.knockUp(PregnancyStore.PREGNANCY_OVIELIXIR_EGGS, PregnancyStore.INCUBATION_OVIELIXIR_EGGS);
			player.createStatusEffect(StatusEffects.Eggs, rand(6), 0, rand(3) + 5, 0);
			player.orgasm();
			combat.cleanupAfterCombat();
		}
	}

}