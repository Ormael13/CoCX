package classes.Scenes.Places.Bazaar{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;

	public class FapArena extends BazaarAbstractContent{

	public function FapArena()
	{
	}

	public function fapAppearance(display:Boolean = true):void {
	if (display) {
		//[Paragraph: Bazaar description, 1st time]
		if (flags[kFLAGS.FAP_ARENA_RULES_EXPLAINED] == 0) outputText("\n\nThere is a gigantic tent standing in the clearing, with a large crowd gathering around it.   Perhaps you could investigate and see what is going on inside.", false);
		//Option labeled "Tent» is available.
		//[Paragraph: Bazaar description: after 1st time]
		else outputText("\n\nA large crowd is gathering around the large tent, probably going for another 'session'.   Perhaps you could join them?", false);
	}
}
//Option labeled "Arena» is available.
public function fapArenaGOOOO():void {
	clearOutput();
	//(set X = longest cock)
	var x:Number = player.longestCock();
	//[1st time]
	if (flags[kFLAGS.FAP_ARENA_RULES_EXPLAINED] == 0) outputText("As you approach the tent, you notice these people are actually waiting in line, pleasantly chatting with each other.  All varieties of species are there, from cute little goblins and mouse-faced people with rodent-like teeth, to towering centaurs and minotaurs, the latter easily noticed with their strong scent.   You spot the occasional sharp-toothed dog-morph or shark breeder, some traditional incubi and a few tentacled mutants, victims of consuming corrupted vegetation.  There are even a few humans, nonchalantly standing in the waiting line and making conversation, as if some of the others weren't monstrosities.  What strikes you is everyone's perfect civility.  Obviously everyone is used to the place.\n\n", false);

	outputText("The waiting line advances and you finally end up in front of the tent's entrance guarded by a surprisingly tall goblin.  She looks at you with assessing eyes, suddenly grabs your crotch with her left hand, rubs it for a second, and says, ", false);
	//[if dick size < 8 inches] 
	if (player.longestCockLength() < 8) {
		outputText("\"<i>I'm afraid you aren't well-endowed enough to take part in our sessions.  Please come back when ", false);
		if (!player.hasCock()) outputText("you have a cock.", false);
		else outputText("your cock is sufficiently long.", false);
		outputText("</i>\"", false);
		//THE FOLLOWING IS CUT - I AINT SELLING GRO+ HERE! NOAP
		//, or consider buying products in our local shop.</i>\"\n\n", false);
		//outputText("She redirects you to a small stall near the entrance with various potions stored on shelves.  A poster placed on it reads: "Your dick must qualify to the house's standards.  80 gems for a vial of Gro+, 80 for the session of your life!"
		//Do you buy products? (Yes/No) //Yes gives you a vial of Gro+, No does nothing. In both cases, the PC is redirected to the Bazaar.
		doNext(bazaar.enterTheBazaar);
		return;
	}
	//[if dick size >= 8 inches: 1st time] 
	else if (flags[kFLAGS.FAP_ARENA_RULES_EXPLAINED] == 0) {
		flags[kFLAGS.FAP_ARENA_RULES_EXPLAINED]++;
		outputText("\"<i>You must be new here.  Go to the backroom on the left, undress yourself and wait with the others in the main room; the session will start soon.</i>\"\n\n", false);
		outputText("Meekly following the others into the backroom, you start removing your " + player.armorName + ".  You watch other people, fully clothed when they step in, completely naked when they go out.  The sensation of something out of place continues to bother you with all these people casually speaking and laughing with their raging erections showing, and then you finally get it: everyone in here has a dick. Even the feminine-looking ones with ample breasts and a generous ass are actually herms, as their huge boners attest.\n\n", false);
		
		outputText("A bit puzzled, you decide to follow everyone else.  They are all gathering in the main circular room, forming a very large ring.  Approximately 30 people and their peckers are standing here naked, and you place yourself to fit in the circle.  Once everyone is aligned, the conversations gradually stop and a red-skinned succubus with pornstar-like tits steps in.  She is completely nude and, if the sight of thirty naked people with horse-length boners wasn't arousing enough, her dripping cunt seems to be attracting your " + player.cockDescript(x) + " like a magnet.  Wait... she doesn't have a dick?\n\n", false);
		
		outputText("Awkwardly, you gently tap your right neighbor's shoulder, trying not to focus on his towering shaft too much, and whisper your question, \"<i>Why do we all have cocks but not her?</i>\"\n\n", false);
		
		outputText("The creature replies, in the same tone, \"<i>She's the referee.  She will explain the rules to new people, don't worry.</i>\"\n\n", false);
		
		outputText("The alluring demoness places herself at the center of the circle and starts speaking in a loud, clear voice, \"<i>Welcome to this new masturbating session!  Because I see some unfamiliar faces, some people here may be new; I will restate the rules.  Please do comply with them or we will have to disqualify you.</i>\"\n\n", false);

		outputText("\"<i>When I say READY, everyone will grab hold of the dick on your right.  You must grab one and only one dick.  If your right neighbor happens to own multiple cocks, you must grab the longest one.  Players with more than one dick in their right hand will be disqualified.</i>\"\n\n", false);
		
		outputText("\"<i>When I say GO, everyone will start stroking the cock they have in hand until it cums.  Do NOT abandon this cock.  You may stroke it in any way you like, but you must only ever use your right hand.  The usage of other hands, tentacles, mouths, nipples, or genitalia to perform any kind of auxiliary stimulation is strictly forbidden.  Players stimulating cocks in illegal ways will be disqualified.</i>\"  You hear some muffled chuckles.  Apparently some players aren't averse to further 'stimulation', even at the cost of cheating.\n\n", false);

		outputText("The succubus carries on, \"<i>You must stand your ground.  Use your left hand to hold your left partner if you feel your dick is being pulled a little too far.  Otherwise, you are not allowed to disrupt your left neighbor's cock-stroking.  People preventing their cock from being caressed will be disqualified.</i>\"\n\n", false);
		
		outputText("\"<i>A cock is considered to be cumming when the first drop of semen comes out.  Pre-cum doesn't count.  You will all be assigned a number.  Whenever a dick cums, you must shout your number followed by SCORING if the cumming dick is your right neighbor's or CUMMING if it's your own.  The winner is the player cumming last, and the loser is the player cumming first.  The orgasm order will be recorded for the second part of the session.  Player announcing a false positive will be disqualified.</i>\"\n\n", false);
	
		outputText("\"<i>Once everyone has come, the loser will place himself at the center of the circle, bending over, buttocks exposed.  The player who came second will place himself right behind him in fucking position, the player who came third will place himself behind him, and so on.  The winner will place himself behind everyone else.  He will give the first thrust and everyone will follow.  The winner dictates the thrusting pace.  I strongly advise you to respect the fucking rhythm.  Do you studs understand?</i>\"\n\n", false);

		outputText("Everyone nods in agreement, hands and genitalia quivering in excitement.  ", false);
		//[if Corr >40]
		if (player.cor > 66) outputText("Sounds fun!", false);
		//[else]
		else outputText("By gods, what are you doing here?", false);
		//end of condition about PC's corr
		outputText("\n\nDo you stay?", false);
		doYesNo(fapArenaPageII, bazaar.enterTheBazaar);
	}
	//[if dick size > 8 inches: after first time] 
	else {
		outputText("\"<i>Welcome back.  Please undress yourself in the backroom and wait with the others in the main room.</i>\"\n\n", false);
		outputText("You do as you are told, quickly removing your " + player.armorName + " and placing your naked self in the main room, waiting in circle with the others.  You have a pleasant and casual chat with other people, trying to recognize some faces.  You try your best to place yourself between people you don't know yet, in order to feel varied pleasures from one time to the next.  After a few minutes during which " + player.sMultiCockDesc() + " stands fully erect at the sight of so many naked people, the sexy referee walks in, naked as usual.\n\n", false);
		
		outputText("\"<i>Alright.  Welcome everyone; I see no new faces here, so I'll assume everyone knows the rules and we'll directly proceed to the masturbatory game, which I am sure you are all eager to play.  Remember: using alternative methods of stimulation is NOT allowed.  Do you studs understand?</i>\"\n\n", false);
		
		outputText("Everyone nods in agreement, hands and genitalia quivering in excitement.", false);
		//[if Corr >40]
		if (player.cor > 66) outputText("  You look forward to this new masturbating session.", false);
		doNext(fapArenaPageII);
	}
	//end of condition about PC's first time, display the following
}
	
private function fapArenaPageII():void {
	//Increment 'times fap-arena'ed
	flags[kFLAGS.FAP_ARENA_SESSIONS]++;
	clearOutput();
	var x:Number = player.longestCock();
	
	outputText("\"<i>READY!</i>\"\n\n", false);
	if (player.cor > 66) outputText("You eagerly seize the rod on your right side; squeezing it a bit in impatience.  A  little tingle alerts you to your left neighbor grabbing " + player.oMultiCockDesc() + " with an expert hand.  Everyone around you quickly grabs hold of the nearest cock on their right side.  Some of them are trembling because of the induced stress and arousal.\n\n", false);
	else if (player.cor > 33) outputText("You nervously grab hold of the rod on your right side.  In your stress, you can't help but give it a little squeeze.  You tremble as your left neighbor grabs " + player.oMultiCockDesc() + " with an expert hand.  Most people are as nervous as you, their whole naked body trembling in stress.\n\n", false);
	else {
		outputText("You hesitantly pick the rod on your right side with an awkward hand.  You nearly let it go because you're so nervous, and its owner smiles: you're obviously not very experienced with dicks.  ", false);
		outputText("You can't help but start as your left neighbor grabs " + player.oMultiCockDesc() + " with an unsettling expertise.  Other players are also nervous, but none as much as you.  The sight of all these trembling dicks makes you shiver.\n\n", false);
	}
	//end of global condition about PC's corr, display the following
	outputText("You firmly settle your " +  player.legs()  + " on the ground, bracing yourself to the imminent handjob you're going to receive, and the one you're going to give.  Your old warrior reflexes start kicking in and you ease your grasp on the cock in your right hand and start calming yourself.  You feel ready when - ", false);
	outputText("\"<i>GO!</i>\"\n\n", false);

	outputText("You instantly wince a little as the hand holding your " + player.cockDescript(x) + " starts rocking up and down energetically.  By the gods, he's good at this, whatever he is.  You suddenly remember your own hand has a job to do and you proceed to rub the shaft on your right, slowly at first and gaining more and more pace as you get more confident.  Soon you're furiously stroking it, trying to match your left partner's rhythm in intensity.  Since there wasn't any handjob stamina contest organized in Ingam, you're fairly inexperienced at this and try to imitate your left partner as best as you can, using the pleasure he's inflicting on you as a suggestion for how to treat your own victim.  You rub the sensitive points, you tickle the urethra and give gentle squeezes with your palm as your hand slowly works its way up and down the massive cock it's stroking.  Your best effort, however, goes into ignoring the hand expertly working your own " +  player.cockDescript(x)  + ", massaging it viciously in order to pump the semen up in your urethra.  Your erection gets bigger, if that is even possible; but you manage to hold off the incoming orgasm.\n\n", false);
	
	outputText("You continue stroking the pecker vigorously while trying to ignore the handjob your own " + player.cockDescript(x) + " is getting, and your efforts are rewarded: soon pre-cum starts dribbling from the tip of the tool you're jerking off, and your hand proceeds to smear that cock in its own juice; you notice it grows slightly bigger.  There is a profound silence in the tent; you only hear a few soft thuds resulting from dick skin being stretched: FAP FAP FAP FAP FAP FAP FAP FAP...  Occasionally a player will break the silence as their lips let a loud, pleasure-filled moan.\n\n", false);
	
	outputText("The pace accelerates more and more; in fear of losing, everyone's handjobs become rougher and rougher, each player hoping that they will make their right partner climax before thy themselves succumb.  Everyone looks deeply concentrated, trying to betray as little as possible of their current tension, raging inside when a muffled moan finds its way through their lips.  How long have you been here, handling a stranger's cock?  You don't know, but the session seems to be coming to an end: almost everyone's dong is now flowing with pre-cum, and the faint jerking sounds are gradually replaced with squelching and slicking noises.  There are ", false);
	if (player.hasVagina()) outputText("other ", false);
	outputText("dick-girls in that room: cute face, jiggling breasts, curvy body, squeezable hips; they would almost look like normal females if it weren't for that huge pre-cum-spilling, protruding cock.  They seem as deep in concentration as the others, the only difference being their feminine fluids spilling freely from their wet cunts and the occasional girlish moans that escape their lips.  The warm, musky smell of male genitalia starts impregnating the whole room as the temperature rises higher and higher and you find yourself all the more aroused.  You close your eyes in order to stop torturing yourself with the sight of hot, horny, naked bodies. You don't know if you will be able to hold on much longer.\n\n", false);
	
	var winner:Boolean = true;
	if (rand(100) <= 4) winner = false;
	//[how the game rolls:
	//5% chance of losing no matter what.
	//If that check fails,
	//Let S be the PC's sensitivity
	var s:Number = player.sens;
	//D the number of hours since he last came 
	var d:Number = player.hoursSinceCum;
	var c:Number = 0;
	if (player.cocks[x].cockType == CockTypesEnum.DEMON) c = 10;
	else if (player.cocks[x].cockType == CockTypesEnum.TENTACLE) c = 5;
	else if (player.cocks[x].cockType == CockTypesEnum.LIZARD) c = 3;
	else if (player.cocks[x].cockType == CockTypesEnum.HORSE) c = 2;
	//R the player's lust resistance (0<R<1)
	var r:Number = player.lustPercent() / 100;
	//The game does a roll between 0 and 100, call it N.
	var n:Number = rand(100);
	//We define the PC's stamina as ST = (N-S*R-4*D)/(D+1) + C
	var st:Number = c + (n-s*r-4*d)/(1.2+(d/10));
	//outputText("<B>CHEAT: " + st + "</b> N: " + n + " c: " + c + " s: " + s + " r: " + r + " D: " + d + "\n", false);
	//If ST is 0 or less, the PC loses.
	//If ST > 30, the PC wins.
	//Otherwise the PC's rating is ST, rounded up.]
	//[if the player loses]
	if (st <= 0) doNext(createCallBackFunction(fapResults,3));
	//[else if the player doesn't lose, but doesn't win either - he cums neither first nor last]
	else if (st < 29.5) doNext(createCallBackFunction(fapResults,2));
	//[else, the player wins]
	else doNext(createCallBackFunction(fapResults,1));
}

private function fapResults(place:Number = 3):void {
	clearOutput();
	var x:Number = player.longestCock();
	var num:Number = rand(50) + 5;
	var tent:Boolean = false;
	//Loses
	if (place == 3) {
		outputText("You try to focus as much as possible on your right arm and the cum-tube it's holding, but the raw sensations are starting to prove too much for your needy " + player.cockDescript(x) + ", and your arm is starting to tire.  You helplessly feel your " + player.cockDescript(x) + " twitching on its own as pressure builds down your urethra.  You try to count to ten in order to clarify your mind but the hand holding your " + player.cockDescript(x) + " doesn't allow you such leisure.  Every time you try to hold a coherent thought, the hand twists your " + player.cockDescript(x) + " in a rough way, sending jolts of pleasure and pain across your whole body.  Gods, it's too much.  Your rod is... you won't be able to... that's it, you can feel it.  It's too late. The flow of semen is gathering in your balls, slowly at first, but you know you don't have time.  In a desperate attempt not to lose, you ferociously rub the shaft in your own hand, faster and faster as you feel your seed starting its way up your urethra. No! This can't be! You rub the pecker wolfishly, paying special attention to the tip and pumping as much pre-cum outside as physically possible.  For a moment, you think you're going to win, for the dick's owner lets out a very loud moan and starts shuddering, victim of your eager ministrations.  You almost feel the liquid seed flowing through the cock veins; then, in a supreme effort of constriction, your right partner manages to hold off that flow.  He won't orgasm this time.  You have lost.\n\n", false);
		
		outputText("But it doesn't matter now.  None of it matters, as your own " + player.cockDescript(x) + " is about to release a flood of its own.  After a whole orgasm self-denying session, you feel like your bones are melting and your body is ascending to heaven as you reach your peak and your " + player.cockDescript(x) + " starts shooting an ", false);
		if (player.cumQ() > 1000) outputText("unholy", false);
		else if (player.cumQ() >= 500) outputText("enormous", false);
		else outputText("appreciable", false);
		//(depending on cum production) 
		outputText(" rope of the creamiest, whitest liquid you've ever produced.", false);
		if (player.cockTotal() > 1) outputText("  Several more gouts follow suit from the unstimulated dickflesh dangling from your groin.", false);
		outputText("  Your whole body shivers, clenches and relaxes several times as you completely lose control of your muscles, your mind only focusing on the cum cannon located between your legs.\n\n", false);
		
		outputText("Your left partner is very professional.  At the very moment your " + player.cockDescript(x) + " starts shooting its goo, your cock-milker yells in a thundering voice: \"<i>NUMBER " + (num-1) + " SCORING!</i>\"  For a moment, lost in your pleasure, you pay little attention to the world outside of your " + player.cockDescript(x) + ".  Then you remember the game and shout in a whorish, pleasure-filled voice: \"<i>NUMBER " + num + " CUMMING!</i>\"", false);
		if (player.hasVagina()) {
		outputText("  Your thighs tense a few seconds before your " + player.vaginaDescript(0) + " squirts too, forming a ", false);
			if (player.wetness() >= 4) outputText("large puddle", false);
			else if (player.wetness() >= 2) outputText("puddle", false);
			else outputText("smear", false);
			outputText(" of girl-jizz on the floor.", false);
		}
		//[if player lactates]
		if (player.biggestLactation() > 1.5) outputText("  Your " + player.allBreastsDescript() + " also release a milky flood of their own, the soft feeling of cream teasing your nipple only prolonging your orgasm.", false);
		outputText("\n\n", false);
		
		outputText("The cute referee nods in acknowledgement.  Her eyes seem to be filled with longing for your cum-spilling " + player.multiCockDescriptLight() + ", and you know she'd eagerly finish you off if it weren't for her professionalism.\n\n", false);
		
		//[1/2 chance of this paragraph appearing]
		if (rand(2) == 0) outputText("As soon as your semen starts flying up in the air, you feel pressure being released in your hand.  Exhausted by your ministrations and now that he doesn't have to fear losing anymore, your right neighbor also starts cumming, blowing his load toward the referee.  She fails to dodge the shot but nods when you angrily yell: \"<i>NUMBER " + (num) + " SCORING!</i>\", almost immediately followed by \"<i>NUMBER " + (num+1) + " CUMMING!</i>\" from your neighbor.  Annoyed that he profited from your lack of stamina and came just after you, you give his member a raging twist for good measure. It makes him scream in pain and pleasure and spills cum all the more abundantly.\n\n", false);
		//[else]
		else outputText("You remember you still have to make your right partner cum.  Now that you've lost, you don't care about being disqualified and you twist your partner's cock ragingly, fondling, cupping his balls, occasionally giving them a nice squeeze for good measure.  Your partner's cock starts twitching in indignation but it soon releases a milky torrent of semen.  Angry at your own lack of stamina, you yell, \"<i>NUMBER " + num + " SCORING!</i>\", almost immediately followed by \"<i>NUMBER " + (num+1) + " CUMMING!</i>\"  You keep twisting that pecker until you're absolutely positive that you've milked every drop of seed out of it.  Your hand is drenched in sexual juices, but you don't care.\n\n", false);
		//end of else
		
		outputText("Quite satisfied, your left partner decides to stop torturing himself; he must have had a rough handjob too.  You watch in amazement as his enormous shaft starts shooting globs of sticky goo, aiming at the referee with an expert's precision.  He grins lewdly and yells: \"<i>NUMBER " + (num-1) + " CUMMING!</i>\"\n\n", false);
		
		outputText("Soon everyone else starts blowing their own loads, shouting their number.  You hear the pleasure-filled moans of a dozen of people giving in to their bodies, only arousing you more and increasing your cum-flow.  The referee records the results and writes them down on a little notepad but she has a hard time keeping it free of white stains because all players seem to be aiming their cumshots at her.  Players are moaning whorishly and louder than ever.  The whole room seems to be detonating as dozens of horny bodies release their powerful orgasms in an apotheosis of lust.  In a few minutes the entire room is filled with trails of cum, everyone being too eager to shoot their load after this fever of orgasm denial.\n\n", false);
	}
	//[else if the player doesn't lose, but doesn't win either - he cums neither first nor last]
	else if (place == 2) {
		outputText("For what seems like hours you try to hold on, resisting wave after wave of unbearable pleasure in your crotch.  Nevertheless, you feel your stamina gradually depleting; each orgasm is harder to deny.  You know you won't be able to hold on much longer, but you muster up your courage and count to ten in your head.  Surely someone will cum before you... they better do it now because your mind is about to collapse and you will no longer be able to control your body.  Gods, it feels too good.  That stroking, teasing hand is torturing you in a delicious way, but you keep denying the pleasure.  You have to.  It's so rough, so...\n\n", false);
		
		outputText("Your thoughts are suddenly interrupted.\n\n", false);
		
		outputText("Someone in the circle yells, \"<i>NUMBER " + num + " CUMMING!</i>\", immediately followed by another voice yelling even louder, \"<i>NUMBER " + (num-1) + " SCORING!</i>\"\n\n", false);
		
		outputText("Indeed, a player's cock has given up the stamina contest and sprays spunk all around in a hot creamy torrent.  That's one mighty cum-shot, you think in admiration.  Almost immediately after that, several players give up too and start shouting while shooting their own goo.\n\n", false);
		
		outputText("Your right partner suddenly shouts in a high-pitched voice, \"<i>NUMBER " + (num+5) + " CUMMING!</i>\"; you immediately understand and shout \"<i>NUMBER " + (num+4) + " SCORING!</i>\" in response.  You can feel the pressure releasing in the cock your hand is holding, the fluid being sprayed all around by the perverted pump.\n\n", false);
		
		outputText("A vicious yank on your own " + player.cockDescript(x) + " reminds you that you also need to comply to your own genitals' needs.  Unhindered by the fear of losing, you completely give up to your orgasm and sigh in utter satisfaction and relief as you release one of the most abundant cumshots you've ever had.  Lost in your orgasm, you carelessly ", false);
		if (player.cumQ() >= 1000) outputText("soak", false);
		else if (player.cumQ() >= 500) outputText("pollute", false);
		else outputText("wet", false);
		outputText(" the floor with your sexual juices and yell in a whorish voice, \"<i>NUMBER " + (num+4) + " CUMMING!</i>\"; you're almost immediately followed by the scoring announcement from your left neighbor.  With a half-closed eye you notice the referee nodding in acknowledgement and you point your " + player.cockDescript(x) + " at her, trying to soak her too.  She hardly dodges it and some lands on her arms, but she doesn't seem to notice.", false);
		if (player.hasVagina()) {
			outputText("  Your thighs tense a few seconds before your " + player.vaginaDescript(0) + " squirts too, forming a ", false);
			if (player.wetness() >= 4) outputText("large puddle", false);
			else if (player.wetness() >= 2) outputText("puddle", false);
			else outputText("smear", false);
			outputText(" of girl-jizz on the floor.", false);
		}
		if (player.biggestLactation() > 1.5) outputText("  Your " + player.allBreastsDescript() + " also release a milky flood of their own, the soft feeling of cream teasing your nipple only prolonging your orgasm.", false);
		outputText("\n\n", false);
		
		outputText("Quite satisfied, your left partner decides to stop torturing himself; he must have had a rough handjob too.  You watch in amazement as his cum-tube starts shooting globs of sticky goo, aiming at the referee with an expert's precision. He grins lewdly and yells: \"<i>NUMBER " + (num+3) + " CUMMING!</i>\"\n\n", false);
			
		outputText("Soon everyone else starts blowing their own loads, shouting their number.  You hear the pleasure-filled moans of a dozen of people giving in to their bodies, only arousing you more and increasing your cum-flow.  The referee records the results and writes them down on a little notepad but she has a hard time keeping it free of white stains because all players seem to be aiming their cumshots at her.  Players are moaning whorishly and louder than ever.  The whole room seems to be detonating as dozens of horny bodies release their powerful orgasms in an apotheosis of lust.  In a few minutes the entire room is filled with trails of spooge, everyone being too eager to shoot their load after this fever of orgasm denial.\n\n", false);
	}
	//[else, the player wins]
	else {
		outputText("For what seems hours you try to hold on, resisting wave after wave of unbearable pleasure in your crotch.  Nevertheless, you feel your stamina gradually depleting; each orgasm is harder to deny.  You know you won't be able to hold on much longer, but you muster up your courage and count to ten in your head.  You must win.  All these efforts can't have been in vain.  Surely someone will cum before you... and someone else, and someone else.  They better do it soon though.  You don't know how long you will be able to control your body.  Gods, it feels too good.  That stroking, teasing hand is torturing you in a delicious way, but you keep denying the pleasure.  You have to.  It's so rough, so...\n\n", false);
		
		outputText("Your thoughts are suddenly interrupted.\n\n", false);
		
		outputText("Your right partner shouts in a high-pitched voice: \"<i>NUMBER "+ (num+1) + " CUMMING!</i>\"  You immediately understand and shout \"<i>NUMBER " + num + " SCORING!</i>\" in response.\n\n", false);
		
		outputText("Indeed, you can feel the pressure releasing in the cock your hand is holding, the fluid being sprayed all around in a hot creamy torrent.  That's one mighty cumshot, you think in admiration.  Almost immediately after that, several players give up too and start shouting while shooting their own goo.\n\n", false);
		
		outputText("Someone in the circle yells \"<i>NUMBER " + (num+7) + " CUMMING!</i>\" immediately followed by another voice yelling even louder \"<i>NUMBER " + (num+6) + " SCORING!</i>\"\n\n", false);
		
		outputText("A vicious yank on your own " + player.cockDescript(x) + " reminds you that you also need to comply to your genitals' need. In a supreme effort of strength of will, you resist.  You can't allow yourself to give up now that you've an opportunity to win.  You clench your teeth and keep ignoring the treatment your " + player.cockDescript(x) + " is undergoing.\n\n", false);
		
		outputText("Tortured, your left partner decides to stop teasing himself; he must have had a rough handjob too.  You watch in amazement as his cum-tube starts shooting globs of sticky goo, aiming at the referee with an expert's precision.  He grins lewdly and yells: \"<i>NUMBER " + (num-1) + " CUMMING!</i>\"\n\n", false);
		
		outputText("Soon everyone else starts blowing their own loads, shouting their number.  You hear the pleasure-filled moans of a dozen of people giving in to their bodies, only arousing you more and increasing your cum-flow.  The referee records the results and writes them down on a little notepad but she has a hard time keeping it free of white stains because all players seem to be aiming their cumshots at her.  Players are moaning whorishly and louder than ever.  The whole room seems to be detonating as dozens of horny bodies release their powerful orgasms in an apotheosis of lust.  In a few minutes the entire room is filled with trails of spooge, everyone being too eager to shoot their cum-load after this fever of orgasm denial.\n\n", false);

		outputText("You mentally keep track of all the people still in play.  They are fewer and fewer.  You just have to hold on a little longer.  Four... three... two... that's it.  You made it.  Phew, you have won just in time, your " + player.cockDescript(x) + " was starting to twitch on its own.  Unhindered by the fear of losing, you completely give up to your orgasm and sigh in utter satisfaction and relief as you release one of the most abundant cumshots you've ever had.  Lost in climax, you carelessly ", false);
		if (player.cumQ() >= 1000) outputText("soak", false);
		else if (player.cumQ() >= 500) outputText("pollute", false);
		else outputText("wet", false);
		outputText(" the floor with your sexual juices and yell in a whorish voice: \"<i>NUMBER " + num+ " CUMMING!</i>\"  With a half-closed eye you notice the referee nodding in acknowledgement and you point your " + player.cockDescript(x) + " at her, trying to soak her too.  She hardly dodges it and some lands on her arms, but she doesn't seem to notice.", false);
				if (player.hasVagina()) {
			outputText("  Your thighs tense a few seconds before your " + player.vaginaDescript(0) + " squirts too, forming a ", false);
			if (player.wetness() >= 4) outputText("large puddle", false);
			else if (player.wetness() >= 2) outputText("puddle", false);
			else outputText("smear", false);
			outputText(" of girl-jizz on the floor.", false);
		}
		if (player.biggestLactation() > 1.5) outputText("  Your " + player.allBreastsDescript() + " also release a milky flood of their own, the soft feeling of cream teasing your nipple only prolonging your orgasm.\n\n", false);
	}
	//Post fap
	outputText("You pant and relax, exhausted.  Your right arm is cramped and your " + player.cockDescript(x) + " is sore.  People around you look similarly tired and are slowly recovering from this rough collective dick-stroking session.  Someone gently taps your shoulder.  It is your left neighbor: \"<i>Well played. I didn't expect you would be so... resistant.  Few players last that long with me, because their rods generally don't endure my handjobs.</i>\"  He proceeds to shake hands; both you are smeared with pre-cum and various cock juices, but you don't care.  You smile and thank him for the good game and the orgasm.  It comes as something of a relief that everyone seems to show good sportsmanship.  Everyone is congratulating each other; various comments reach your ears about the game they just had and how well their opponents did.  Your right partner stands before you.  \"<i>Whoa, you sure know how to give a handjob!  That was amazing, and you know what?  I don't care if I haven't won!</i>\"  You tell him that you're glad that he enjoyed your efforts.  Everyone is now laughing and chatting casually, as if their still erect cocks weren't dripping semen and they weren't busy giving furious handjobs a few minutes ago.  ", false);
		
	//[if first time]
	if (flags[kFLAGS.FAP_ARENA_RULES_EXPLAINED] == 1) outputText("You stand here, a little lost, wondering what will happen next.", false);
	else outputText("You join them, congratulating some on the strength of their stroke, and commenting on the various aspects of the fapping game you've just had.\n\n", false);
		
	outputText("The referee, who had been busy cleaning herself up from all the spunk in a backroom, suddenly storms out and plants herself at the center of the circle, her nude red body trembling and shivering in arousal.  \"<i>Alright, everybody in a single line!  It's time for your butt-fuck reward.</i>\"\n\n", false);
	
	outputText("You jolt in surprise as everyone stops talking altogether and yells in a single, thundering, thrumming voice, \"<i>BUTT-FUCK!  BUTT-FUCK!  BUTT-FUCK!  BUTT-FUCK!</i>\"  It never seems to end.\n\n", false);
	
	//[if corr < 50]
	if (player.cor < 50) outputText("You find yourself yelling with them, astounded by everyone's enthusiasm and eagerness to be fucked in the ass, even after this rough masturbating session.  You wish you weren't so blindly following others, but they are so hypnotizing, their hard glistening cocks pointing at the air as they keep shouting over and over again, \"<i>BUTT-FUCK!  BUTT-FUCK!  BUTT-FUCK!  BUTT-FUCK!  BUTT-FUCK!</i>\"  ", false);
	//[else, corr >50]
	else outputText("Your body tenses and " + player.sMultiCockDesc() + " hardens at the perspective of a collective anal orgy.  You yell in lust like a minotaur in rut, \"<i>BUTT-FUCK!  BUTT-FUCK!  BUTT-FUCK!  BUTT-FUCK!  BUTT-FUCK!</i>\" along with the others.  ", false);
	//end of global condition about PC's corr, display the following
	outputText("As they shout rhythmically, they start forming a straight line, their position in the line reflecting their rating.\n\n", false);
	
	//[if you won]
	if (place <= 1) outputText("Since you're the winner, you walk to the tail of the butt-fuck train, enjoying your prize.  ", false);
	//[if you didn't win, didn't lose]
	else if (place <= 2) outputText("You place yourself between two horny bodies.  The lust and confusion have obscured your senses and all you see is a rock-hard dick and a gaping anus, both waiting for you to play with.  ", false);
	//[if you lost]
	else {
		outputText("You meekly place yourself at the end of the butt-fuck wagon, knowing you'll have to endure the thrusts of everyone else.  In your shame and lust, all you can see is a member of enormous size, trembling in arousal, waiting to lodge between your ass-cheeks.  With ", false);
		//([if corr < 50]
		if (player.cor < 50) outputText("a whorish smile", false);
		else outputText("apprehension", false);
		outputText(", you place yourself in front of the creature with the large cock.  It grinds against your back in impatience.  ", false);
	}
	outputText("You ready yourself up as everyone puts themselves into a proper butt-fucking position, cocks pointing to anuses.\n\n", false);
	
	outputText("The referee shouts, \"<i>LET THE BUTT-FUCK TRAIN BEGIN!</i>\"\n\n", false);
	
	//[if you won]
	if (place <= 1) {
		outputText("You can't believe you will get to fuck a whole train's worth of anuses and cocks.  This seems so unreal...  nevertheless, the tension and the scent of cum prove too much for you, and you give in to your lust.  ", false);
		//[1/2 chance of this]
		if (rand(2) == 0) {
			temp = 3;
			outputText("You eagerly grab the luxurious, gelatinous butt cheeks in front of you.  You notice a pussy underneath that fine ass, freely spilling sexual juices.  If the compelling order wasn't resonating deep in your mind, you would easily lose yourself in the herm's glorious depths. Nevertheless, your " + player.cockDescript(x) + " remembers its job and starts pushing its way between these tender orbs, then into the herm's tight anus.\n\n", false);
		}
		else {
			outputText("You eagerly grab the firm, muscular ass cheeks in front of you, probably belonging to some vigorous male.  You grind your " + player.cockDescript(x) + " against his back and it automatically starts spilling pre-cum; as soon as the seminal liquid trickles down his shapely butt, you can feel his body tensing, as if his lust reached a new level.  Nevertheless, your " + player.cockDescript(x) + " remembers its job and starts pushing its way between these gorgeous buttocks, then into the man's tight anus.\n\n", false);
			temp = 1;
		}
		outputText("It lodges here comfortably for a few seconds, and then you remember you're the one initiating the butt-fucking train; so you quickly get down to business and give your dong an almighty thrust.  As soon as you start pushing, your sodomite partner grips ", false);
		if (temp == 1) outputText("his", false);
		else outputText("her", false);
		outputText(" own partner's butt and thrusts too under the pressure, who does the same to the one following, etc..  The last one is actually pushed face down onto the floor, but her butt bumps against the cum-tube fucking her, making the cock's owner bump in response, and it all propagates back to your own dick; you gasp in pleasure as the ass holding your " + player.cockDescript(x) + " clenches all the more as it bumps against your thighs, and decide to give another thrust, and another, and another.  It is hard, laborious, and slow, but your " + player.cockDescript(x) + " is rewarded beyond imagination: it feels like a gentle tingle every time a butt bumps into someone's ass.  It is like a giant anal wave coming and going through people's cocks, and you're the one riding the wave.  Soon people in the fuck train let out whorish moans, often interrupted when the wave hits them, before moaning all the more loudly afterwards.  Although you are not getting your " + player.assholeDescript() + " pounded like everyone else, you know you won't be able to keep up with such a crazy butt-fucking pace for long.  The ass you're fucking is almost moving on its own, jerking back and forth at each thrust, nearly beyond your control.  You know you're supposed to lead the whole fuck train, but the raw feelings are too much.  Every time you try to ease yourself into fucking that ass in a more comfortable way, it grinds against your thighs, driving your " + player.cockDescript(x) + " crazy and crushing any attempt at coherent thought.  You decide to give up and let your " + player.cockDescript(x) + " do the job itself.  Pleasure rises as you pound this ass relentlessly, making its owner join the chorus of moaning sounds.\n\n", false);
		tentacleFapSpecial(place);
		outputText("You eventually reach your final peak and start unloading a glorious load, flooding your partner's colon.  As baby-batter freely flows out of your urethra, you let an orgasming scream of your own, ferociously gripping the bountiful ass-cheeks within your grasp, digging your fingers in the soft skin.  You cum, cum and cum, your shaft vibrating on its own in your partner's anus; at the same time, other people in the butt-fuck train start coming too, and everyone's body tenses and clenches as if they wanted to milk every ounce of seed available into their butts.", false);
		tent = tentacleFapCum();
		//[if player has multicocks] 
		if ((player.cockTotal() > 2) || (!tent && player.cockTotal() > 1)) {
			if (player.cockTotal() > 3 || (!tent && player.cockTotal() > 2)) outputText("  Your other cocks also spill ", false);
			if ((tent && player.cockTotal() == 3) || (player.cockTotal() == 2 && !tent)) outputText("  Your other cock also spills ", false);
			outputText("a ", false);
			if (player.cumQ() > 1000) outputText("mighty", false);
			else if (player.cumQ() > 500) outputText("large", false);
			else outputText("good", false);
			outputText(" spray of ", false);
			if (player.cockTotal() > 3 || (!tent && player.cockTotal() > 2)) outputText("their ", false);
			else outputText("its ", false);
			outputText("own, unhindered by the tight colon holding your first " + player.cockDescript(x) + ".", false);
		}
		//[if player has vagina]
		if (player.hasVagina()) {
			outputText("  Your feminine part squirts a ", false);
			if (player.wetness() >= 5) outputText("titanic", false);
			else if (player.wetness() >= 3) outputText("massive", false);
			else outputText("nice", false);
			outputText(" load of girl-cum too, as if to compete with its male counterpart.", false);
		}
		//end of conditions
		
		outputText("\n\nWincing in pain and pleasure mixed, your " + player.cockDescript(x) + " lets out one ultimate spurt of goo before resting, deeply buried into your partner's ass.  You fall over, making the whole chain fall to rest by domino effect.  After this torrid anal session, the butt-fuck train has exhausted its fuel.\n\n", false);
	}
	//[else if you didn't win]
	else if (place == 2) {
		outputText("You almost instantly feel firm arms groping your " + player.buttDescript() + " and the tip of an erect dick knocking at the door of your colon.  It slowly massages your rectum, and you can't help but giggle a bit as you feel a tingle of pleasure passing through your body.\n\n", false);
		
		//[1/2 chance of this]
		if (rand(2) == 0) outputText("You eagerly grab the luxurious, gelatinous butt cheeks in front of you.  You notice a pussy underneath that fine ass, freely spilling sexual juices.  If the compelling order weren't resonating deep in your mind, you would easily lose yourself in the herm's glorious depths.  Nevertheless, your " + player.cockDescript(x) + " remembers its job and starts pushing its way between these tender orbs, then into the herm's tight anus.\n\n", false);
		else outputText("You eagerly grab the firm, muscular ass cheeks in front of you, probably belonging to some vigorous male.  You grind your " + player.cockDescript(x) + " against his back and it automatically starts spilling pre-cum; as soon as the seminal liquid trickles down his shapely butt, you can feel his body tensing, as if his lust reached a new level.  Nevertheless, your " + player.cockDescript(x) + " remembers its job and starts pushing its way between these gorgeous buttocks, then into the man's tight anus.\n\n", false);

		outputText("You suddenly hear a muffled moan from behind.  Someone is probably being fucked at the back of the train.  You brace yourself for the imminent anal penetration... and here it comes.  The dong is projected at full force into your " + player.buttDescript() + " then all the way inside your colon; you're protected only by the copious glaze of pre-cum its bearer had been applying.", false);
		player.buttChange(5+rand(15),true,true,false);
		outputText("  Instinctively, you reach for the butt awaiting your " + player.cockDescript(x) + " and push as if your life depended on it.  You notice how your sodomite partner does the same to the ass in front of him, and so on.  Eventually the last one is pushed face down onto the floor, but her butt bumps against the dong fucking her, making the cock's owner bump in response, and it all propagates back to your own pecker; you wince in pleasure as your asshole impales itself further on the turgescent member behind you.  You are pushed and pulled rhythmically, your throbbing member and the one fucking you serving both as vectors in this slow wave of anal pleasure.  Unable to keep control of your thrusts, you let go of your body, enjoying the feeling of being shoved in both directions, each motion bringing either a jolt of pleasure in your crotch or your " + player.buttDescript() + ".  You are being slowly overwhelmed by the delicious tightness of the butt you're fucking as well as the fat piece of meat pounding your own.  The raw feelings eventually prove too much for your horny body, and you jerk your head back and moan like a whore, waiting for the incoming orgasm.\n\n", false);
		tentacleFapSpecial(place);
		outputText("A pressure builds at your crotch as a milky torrent of seed finds its way into your urethra, down your sodomite partner's colon.  Almost simultaneously, you feel an equally thick spray of spooge being released inside your own " + player.buttDescript() + ". At the peak of your orgasm, you are unable to think of anything but the steady flow of jism coming in and out of you.", false);
		tent = tentacleFapCum();
		//[if player has multicocks] 
		if ((player.cockTotal() > 2) || (!tent && player.cockTotal() > 1)) {
			if (player.cockTotal() > 3 || (!tent && player.cockTotal() > 2)) outputText("  Your other cocks also spill ", false);
			if ((tent && player.cockTotal() == 3) || (player.cockTotal() == 2 && !tent)) outputText("  Your other cock also spills ", false);
			outputText("a ", false);
			if (player.cumQ() > 1000) outputText("mighty", false);
			else if (player.cumQ() > 500) outputText("large", false);
			else outputText("good", false);
			outputText(" spray of ", false);
			if (player.cockTotal() > 3 || (!tent && player.cockTotal() > 2)) outputText("their ", false);
			else outputText("its ", false);
			outputText("own, unhindered by the tight colon holding your first " + player.cockDescript(x) + ".", false);
		}
		//[if player has vagina]
		if (player.hasVagina()) {
			outputText("  Your feminine part squirts a ", false);
			if (player.wetness() >= 5) outputText("titanic", false);
			else if (player.wetness() >= 3) outputText("massive", false);
			else outputText("nice", false);
			outputText(" load of girl-cum too, as if to compete with its male counterpart.", false);
		}
		//end of conditions 
		outputText("\n\nFinally the strength of all the ejaculations is starting to ebb, as well as your fading orgasm.  Wincing in pain and pleasure mixed, your " + player.cockDescript(x) + " lets out an ultimate spurt of goo before resting, deeply buried into your partner's ass.  You fall over, making everyone after fall too by domino effect.  As you slowly doze off, you have a special thought about the still semi-erect cock being lodged in your " + player.buttDescript() + ".  That wagon of butts and dicks... it felt so right, so powerful, so... connected.\n\n",false);
	}
	//[else, if you lost]
	else {
		outputText("You almost instantly feel firm arms groping your " + player.buttDescript() + " and the tip of an erect dick knocking at the door of your colon.  It slowly massages your rectum, and you can't help but giggle a bit as you feel a tingle of pleasure passing through your body.  You prepare yourself for the crazy butt-fuck train, with you being at the end of it.\n\n", false);
		
		outputText("You suddenly hear a muffled moan from behind. Someone is probably being penetrated at the back of the train.  You brace yourself for the imminent anal-fucking... and here it comes.  The dong is projected at full force into your " + player.buttDescript() + " then all the way inside your colon; you're protected only by the copious glaze of pre-cum its bearer had been applying.", false);
		player.buttChange(5+rand(10),true,true,false);
		outputText("  You are pushed face down to the floor, bumping your ass against your anal partner's crotch, impaling it further on that fat erect meat.  Hands roughly dig their fingers into the soft flesh of your cheeks as their owner gives you another mad, uncontrolled thrust, an avatar of the train of lust behind him.  Probably the force of thirty people butt-fucking into him was too much for him to bear, so he passes it on to you.  But unlike him, you don't have an asshole to reach and bury your " + player.cockDescript(x) + " into, so you are smashed on the floor again, and again, and again.  It hurts, yet it feels so... powerful, so strong.  There is only one dong pounding your " + player.assDescript() + ", yet it feels like you're being ass-fucked by thirty people at once.  Propelled by the might of thirty thrusts, the huge shaft is tearing its way inside your poor " + player.assholeDescript() + " and, needless to say, being the end of this line is probably the hardest butt-fuck you'll ever have.\n\n", false);
		tentacleFapSpecial(place);		
		outputText("You feel that towering rod grinding against the rough insides of your colon, the friction providing a shamefully amazing sensation of violation.  The large hands are gripping, pinching and groping your " + player.buttDescript() + " with ease and feverish lust, and your abused flesh feels every tingle, every prickle of it, bringing you to the edge every time.  You know you are being ferociously dominated by that cock, but the pleasure is too good for you to care.  The raw feelings eventually prove too much for your horny body, and you simply lay there in the dust, waiting for the incoming orgasm.  Eventually you feel an enormous spray of spooge being released in your insides.  Almost instantly, you start unloading thick ropes of jism at a steady rate.  Wallowing in a pool of dirt muddied with sexual juices like a worthless slut, you grind your " + player.buttDescript() + " against the cock harder, in order to milk every drop of semen coming out of it.  But your colon soon reaches its limits and spooge starts dribbling out in small spurts.", false);
		tentacleFapCum();
		//[if player has vagina]
		if (player.hasVagina()) {
			outputText("  Your feminine part squirts a ", false);
			if (player.wetness() >= 5) outputText("titanic", false);
			else if (player.wetness() >= 3) outputText("massive", false);
			else outputText("nice", false);
			outputText(" load of girl-cum too, as if to compete with its male counterpart.", false);
		}
		outputText("\n\nYou fall over, still feeling the cum-tube buried inside you.", false);
		if (player.lib > 50) outputText("  Maybe losing wasn't that bad? You feel like you could lose a few more times...", false);
		outputText("\n\n", false);
	}
	//end of global condition about the PC's position in the buttfuck train, display the following
	//[if you won]
	if (place <= 1) {
		outputText("You quickly stand back up and start dressing yourself.  Before you go, the cute little referee hands you a small box, her coy smile and nude body somehow awakening " + player.sMultiCockDesc() + " again. Ye Gods, it never ends.  \"<i>Here's a little something for being the winner of this session.  Hope you enjoy your prize.  Come and play again!</i>\"", false);
		//You find [random item from the list: gro+, succubi's dream, large blue egg].
		
		var itype:ItemType= consumables.GROPLUS;
		switch(rand(3)) {
			case 0:
				itype = consumables.GROPLUS;
				break;
			case 1:
				itype = consumables.S_DREAM;
				break;
			case 2:
				itype = consumables.L_BLUEG;
				break;
		}
		flags[kFLAGS.FAP_ARENA_VICTORIES]++;
		player.orgasm();
		inventory.takeItem(itype, camp.returnToCampUseOneHour);
	}
	//[if you didn't win]
	else if (place == 2) {
		outputText("You awkwardly remove the dick from your ass and start dressing yourself.  Before you go, the cute little referee waves at you, her coy smile and nude body somehow awakening " + player.sMultiCockDesc() + " again.  Ye Gods, it never ends.  \"<i>I hope you enjoyed this session. Better luck next time...</i>\"", false);
		player.orgasm();
		doNext(camp.returnToCampUseOneHour);
	}
	//[if you lost]
	else {
		outputText("You awkwardly remove the dick from your ass, start cleaning yourself from all the dirt and cum before leaving the tent.  Before you go, the nude referee approaches you and gently squeezes your " + player.cockDescript(x) + "; you still wince from the pounding it took earlier.  \"<i>Awww, looks like you had a rough time, didn't you?  Well, it happens sometimes.  Hopefully you will get better at this.  See you next game!</i>\"", false);
		player.orgasm();
		doNext(camp.returnToCampUseOneHour);
	}
	
}

//[SPECIAL: if player has an extra tentacle dick more than 40 inches long OR if the player has lost and has a unique tentacle dick, add this paragraph before the PC cums]
private function tentacleFapSpecial(place:Number):void {
	temp = player.cocks.length;
	var x:Number = player.longestCock();
	while(temp > 0) {
		temp--;
		if (player.cocks[x].cockLength >= 40 && player.cocks[x].cockType == CockTypesEnum.TENTACLE)
			break;
	}
	if (player.cocks[x].cockLength >= 40 && player.cocks[x].cockType == CockTypesEnum.TENTACLE) {
		outputText("You suddenly remember your " + Appearance.cockNoun(CockTypesEnum.TENTACLE) + " isn't getting love. The poor squirming thing is trembling in arousal and you decide it should also take part in the collective butt-fuck; you don't care whether it's cheating or not; after all, the butt-fuck has already begun.  Besides, the referee is too busy touching herself to notice anything.  Fortunately your tentacle dick is long and flexible enough to be guided toward some hole to fuck; you proceed to snake your tentacle dong around, looking for some vagina.  After a few seconds of unsuccessful searching, groping muscled butts with your nodules but finding no hole that's already filled by some ramming cock, your ropy member finally locates a gaping, fluid-dripping vagina.  You've found a herm!  Her slick fuck-hole is oozing due to the unholy embrace of flesh her pucker and her shaft are already getting, and you have no trouble sliding a few inches inside with expert guidance.  The brutal and unexpected secondary intrusion makes her moan instantly.  You welcome this new burst of pleasure and start jamming your tentacle pecker back and forth in the herm's vagina, all the while ", false);
		if (place <= 2) outputText("fucking your partner's anus", false);
		if (place == 2) outputText(" and", false);
		if (place >= 2) outputText(" being fucked from behind", false);
		outputText(".\n\n", false);
		//[if you didn't lose or if you won]
		if (place <= 2) {
			outputText("Needless to say, this interference creates a general disruption in the whole butt-fuck wave.  The whole train of peckers and puckers starts moving irregularly, grinding against your " + player.cockDescript(x) + " at the most unexpected moments, and the pleasure you're getting from your extra tentacle cock doesn't help.  Everyone's butt and dick is affected to some extent; everyone's pleasure is increased because of your audacious initiative, and loud, reluctant moans are heard.", false);
			if (place == 1) outputText("  Such raw power, fucking two people at the same time, and one from so far away...  You're basically fucking a wagon of people twice.  The enormity of the act makes you laugh, adding to your pleasure-induced confusion.", false);
			else outputText("  Your resistance is quickly fading because of the triple fuck and the mix of feelings combining to provide the richest, dirtiest orgasm; but you feel consoled in knowing the herm girl you're fucking is completely lost.", false);
			outputText("Receiving cock and pleasure from both holes, the dick-girl's body is wildly thrashing from one side to another, grinding against your tentacled shaft and screaming in ecstasy as she abandons herself to the rough sensations assaulting her mind.  The mental image of her plump rump jiggling so obscenely from behind as well as the slimy sensation of feminine fluids freely spilling from her abused baby-maker make you thrust faster and deeper into her, as if to punish her - or reward her? - for arousing you so much.  She will probably cum soon, and so will you.\n\n", false);
		}
		//[if you lost]
		else {
			outputText("This is such an awkward position, moving your " + Appearance.cockNoun(CockTypesEnum.TENTACLE) + " backwards and blindly penetrating some herm girl you don't see.  But at least it's fair game; why should you be the only one on the receiving end?  You firmly lodge your sleek intruder inside the girl's love tunnel and start pushing, thrusting harder and deeper every time the butt-fuck wagon hits your " + player.assDescript() + ", as if you wanted to punish her for being part of your own rough penetration, and transmit some of the pure anal-induced energy from thirty people's cock-thrusts to her... you aren't disappointed.  As soon as your " + Appearance.cockNoun(CockTypesEnum.TENTACLE) + " starts rocking in and out of the herm's moist pussy, she lets out a huge, obscenely whorish scream of pleasure.  She waggles from one side to another and accelerates her butt-fucking and hole-filling pace, unable to control her sensations.  This disrupts the whole butt-fucking train, and everyone's ass and cock is affected to some extent; everyone's pleasure is increased because of your audacious looping retro-fuck initiative, and other loud, reluctant moans are heard.  You can't help but join them in this unholy orgy of hole-penetration.  The herm's repeated, irregular screams are covering everyone else's though, and the abundant flow of girl-squirt and pre-cum leaking out of your connected genitals tells you much about both your states of arousal.  It won't be long before you both come.\n\n", false);
		}
	}
}
//[in both cases, special paragraph for cumming with tentacle dick]
private function tentacleFapCum():Boolean {
	temp = player.cocks.length;
	var x:Number = player.longestCock();
	while(temp > 0) {
		temp--;
		if (player.cocks[x].cockLength >= 40 && player.cocks[x].cockType == CockTypesEnum.TENTACLE)
			break;
	}
	if (player.cocks[x].cockLength >= 40 && player.cocks[x].cockType == CockTypesEnum.TENTACLE) {
		outputText("  Your tentacle pecker starts vibrating on its own, and soon it also releases a voluminous amount of jizz inside the herm's vagina.  She is also reaching her climax; her pussy is drenching the end of your tentacled shaft with girl-juices.", false);
		return true;
	}
	return false;
}
}
}
