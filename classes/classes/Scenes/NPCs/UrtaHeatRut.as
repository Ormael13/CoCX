package classes.Scenes.NPCs{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;

	public class UrtaHeatRut extends NPCAwareContent {

		public function UrtaHeatRut()
		{
		}
private function urtaQuestDone():Boolean {
	return (flags[kFLAGS.URTA_QUEST_STATUS] == 1);
}

//[Approach Sober Urta]
internal function approachSoberUrtaHeatRutProc():void {
	clearOutput();
	urta.urtaSprite();
	outputText("As you walk over to the table where your foxy herm-lover sits, you think you see eyes following you, your presence attracting an unusual amount of attention. ");
	if (player.inHeat && player.inRut && player.hasCock() && player.hasVagina()) outputText(" Males, females and herms alike stare at you with a mixture of puzzlement, longing and hostility, as if unsure whether they want to fight with you, fuck you senseless or be fucked senseless by you.");
	else if (player.inRut && player.hasCock()) outputText(" Males stare at you with a hint of challenge in their eyes, whilst females eye you attentively. Herms don't seem sure whether they want to fight you or fuck you.");
	//(Player in heat
	else if (player.inHeat && player.hasVagina()) outputText(" Males, and individuals who look like females at first, until you spot the telltale bulge of at least one cock in garments or hanging freely between their legs, stare at you with obvious desire as you go, more than a few erections starting to form in your wake.");
	outputText("  You ignore them all, concentrating on Urta.");

	outputText("\n\nAs you approach, ");
	
	if (urtaLove()) outputText(" she opens her arms to embrace you, and smiles.");
	else outputText(" she smiles when she sees you, but then gives the air a sniff and immediately seems to gain more color to the skin under her fur.  \"<i>Uh, I, I see.</i>\"  You sit down next to her, but even though she isn't even suggesting anything yet, you already find it hard to control yourself.");
	
	if (player.inRut && player.hasCock()) outputText("  Urta is right next to you, and she has already proven herself a good lay");
	else outputText("  You keep reminding yourself what Urta is packing between her legs and how much precious semen it can give, and can't help but want to try that now");
	
	outputText(".  Not to mention, with or without the monster between her legs, her body is sexy as hell.");

	outputText("\n\n\"<i>Well, you do help me with my own releases, so I suppose that's fair....");
	if (player.inHeat && player.hasVagina()) outputText("  You... smell good, so I at least hope you're not here to tease me.");
	outputText("</i>\"  She leans closer to you, and ");
	if (player.inRut && player.hasCock()) outputText("your eyes are quickly drawn to her full breasts as she whispers something to you. You're too hypnotized to care.");
	else outputText("you lose yourself in your imagination about having Urta take you raw and pump you full of sperm.  There's a faint voice you hear, and you realize it's Urta's as you snap back to reality.");
	outputText("  She coughs and repeats herself.  \"<i>Are you here because of your, um, condition? You'd prefer to blow off some steam with ");
	if (urtaLove()) outputText("your adorable, hot vixen");
	else outputText("someone you know and trust");
	outputText(", right?</i>\"");

	outputText("\n\nYou nod with a little too much enthusiasm.  She grabs you by the hand as she leaves a few gems on the table, careful not to touch any part of your that may be too sensitive at this point.");

	outputText("\n\nAs she leads you into the alleys and apparently, towards her home, your mind and eyes");
	if (player.inRut && player.hasCock()) outputText(" focus is on the hips of the fox-morph");
	else outputText(" focus on catching a glimpse of that amazing cock, and you keep imagining what she can do with it");
	outputText(".  Your aggressive hormonal state demands that you ");
	if (player.inRut && player.inHeat && player.hasCock() && player.hasVagina()) outputText(" put a baby in her, then let her put a baby in you");
	else if (player.inRut && player.hasCock()) outputText(" put a baby in her so she can push it out of those beautiful hips");
	else outputText(" put that beautiful big cock into your needy [vagina]");
	//[If Urta's fertility quest wasnât done]
	if (!urtaQuestDone()) outputText(", even if something keeps reminding you that's impossible.");
	else outputText(".");

	outputText("\n\n\"<i>You know, [name] I'm glad to see you as always.  ");
	if (urtaLove()) outputText("  I'm really thankful you managed to control yourself and see me with this.  You know that if you need me, I'm always ready to help, love.</i>\"");
	else outputText("  I'm really flattered you thought of me when in such a state!</i>\"");

	outputText("\n\nSuddenly, the instincts get a bit too strong and the moment you enter a somewhat long, dark, separate alley, You put your arms around Urta and push your ");
	if (player.inRut && player.inHeat && player.hasCock() && player.hasVagina()) outputText("mixed genitals");
	else if (player.inRut && player.hasCock()) outputText("[cock biggest]");
	else outputText("[vagina]");
	outputText(" against her backside.");

	outputText("\n\n\"<i>Um, you know, I'm horny, too, but at least wait 'til we get to my place...</i>\"");

	//Player in heat and rut:
	if (player.inRut && player.inHeat && player.hasCock() && player.hasVagina()) {
		outputText("\n\nYou turn Urta around and see in her eyes a desire nearly as big as in yours.  You practically throw yourself at her, pushing her against the wall, mauling her big breasts, assaulting her lips and rubbing your thighs against her big, erect horse-dong, not really sure yet how the hell you'll satisfy all your body's desires at once.  Urta growls with desire, ripping her dress open and the two of you quickly toss your [armor] all over the place.");
		outputText("\n\nUrta looks like she's about to say something, but then she stops, confusion pushing aside horniness, if only for the moment.  \"<i>I... What are you going to use?  Your cock?  Your pussy?</i>\" she asks, panting with eagerness to begin.");
		//[Cock] [Pussy])
		menu();
		if (player.cockThatFits(urta.urtaCapacity()) >= 0) addButton(0,"Cock",sateRutWithSoberUrta);
		else addButton(0,"Cock",sateRutWithSoberUrtaButHuegDicked);
		addButton(1,"Pussy",soberUrtaSatingPCHeat);
	}
	//Player in rut:
	else if (player.inRut && player.hasCock()) {
		outputText("\n\nYou roughly shove your fingers into her mouth as your hand moves lower, between her thighs. The naughty slut isn't even wearing proper underwear, and you quickly begin to molest her black pussy lips before slipping a finger inside.");
		if (player.hasVagina()) outputText("  Your " + player.multiCockDescriptLight() + " and [vagina] are filling your clothes with mixed juices");
		else outputText("  Your [cock biggest] begins to seep precum into your clothes");
		outputText(", so you decide to dispose of them as you force Urta against a wall.");

		outputText("\n\n\"<i>Okay, fine. I had it coming,</i>\" Urta says, though she doesn't sound very unenthusiastic about the prospect of having sex in the alley and, from the stiffness of her cock and wetness of her pussy, her body looks even less opposed to it.");

		outputText("\n\nYou shed your [armor] as you approach the willing fox-morph with your cock in hand");
		if (player.hasVagina()) outputText(" and your pussy dripping and eager");
		outputText(".");
		menu();
		if (player.cockThatFits(urta.urtaCapacity()) >= 0) addButton(0,"Next",sateRutWithSoberUrta);
		else addButton(0,"Next",sateRutWithSoberUrtaButHuegDicked);
	}
	//Player in heat:
	else {
		outputText("\n\nYou firmly grab Urta's breast and her cock through her clothes, pushing yourself against her and kissing the fox-morph hungrily.  You ask her to take you here and now, saying you can't wait anymore.");
		outputText("\n\n\"<i>All right... I know what it's like to have troubles controlling yourself. If you really want me to...</i>\"");
		outputText("\n\nYou dispose of your [armor], your [vagina] already wet and eager for her.  You pull the vixen into an embrace under the wall of the alley, and she starts to align her huge, pre-cum dripping cock with your opening.");
		menu();
		addButton(0,"Next",soberUrtaSatingPCHeat);
	}
}


//[Approach Drunken Urta]
internal function approachDrunkenUrta():void {
	clearOutput();
	urta.urtaSprite();
	outputText("As you walk over to the table where your foxy herm-lover sits, you think you see eyes following you, your presence attracting an unusual amount of attention.");
	//Player in heat and rut:
	if (player.inHeat && player.inRut && player.hasCock() && player.hasVagina()) outputText("  Males, females and herms alike stare at you with a mixture of puzzlement, longing and hostility, as if unsure whether they want to fight with you, fuck you senseless or be fucked senseless by you.");
	else if (player.inRut && player.hasCock()) outputText("  Males stare at you with a hint of challenge in their eyes, whilst females eye you attentively. Herms don't seem sure whether they want to fight you or fuck you.");
	//Player in heat:
	else outputText("  Males, and individuals who look like females at first, until you spot the telltale bulge of at least one cock in garments or hanging freely between their legs, stare at you with obvious desire as you go, more than a few erections starting to form in your wake.");
	 outputText("  You ignore them all, concentrating on Urta.");

	 outputText("\n\nIn fact, she has already seen you first, and stands up at your approach, also doing her own part to lessen the distance.  Surprisingly, you're stopped in your tracks as the fox-morph pushes you against the bar, with just a small loss of her own balance as she does so.");

	 outputText("\n\n\"<i>My, my. You do realize what you smell like, don't you?  Did you think I wouldn't notice?  Or are you here precisely because you wanted me to notice?</i>\"");

	 outputText("\n\nSomehow, the hermaphrodite seems a bit more clingy and flirty than usual, and less subtle about her relationship with you.  As you take in a deeper breath, you realize why - she does reek of one of her favorite drinks... Do you take interest, or decide it may be better to visit when she's her usual and a bit more sober self?");

	//[Interested] [Not interested]
	menu();
	addButton(1,"NotInterested",notInterestedInUburDrunkUrtaRuts);
	addButton(0,"Interested",interestedInUburDrunkurtaRuts);
}


//[=Not interested=]
private function notInterestedInUburDrunkUrtaRuts():void {
	clearOutput();
	urta.urtaSprite();
	outputText("You say it's her who seems to be different today, and gently push her away, before apologizing and making your leave.  ");
	if (player.faceType == 2) outputText("Your nose does seem to pick up that Urta was and still is getting unusually aroused behind you.  ");
	if (player.inRut && player.hasCock()) outputText("[EachCock] twitches in protest at you leaving a willing lay behind.  ");
	//[Medium lust increase] 

	//[If the PC has a snake tongue]
	if (player.tongueType == TONGUE_SNAKE) outputText("You instinctively taste the air, and Urta suddenly seems utterly delicious. ");
	//Rut: 
	if (player.inRut && player.hasCock()) outputText("Your " + player.multiCockDescriptLight() + " hardens in your pants as you still force yourself to leave.");
	//[Medium lust increase]
	else outputText("Your condition does seem kind of protesting against leaving such a willing lay behind, but it isn't time to be indulging it.");

	dynStats("lust+",5+player.lib/20,"resist",false);
	//to Tel'Adre bar menu
	menu();
	addButton(0,"Next",telAdre.barTelAdre);
}

//[=Interested=]
private function interestedInUburDrunkurtaRuts():void {
	clearOutput();
	urta.urtaSprite();
	outputText("You raise an eyebrow and ask Urta if she minds telling you the reason for such attention and what exactly it is that you smell like.");

	//Rut And Heat:
	if (player.inRut && player.inHeat && player.hasCock() && player.hasVagina()) outputText("\n\n\"<i>Gods, sexy!  You smell like you walked in here to make babies - like you want to grab the girls and the herms and plough them full of cum, even as you let the guys and the herms stuff your greedy cunt full of baby juice and make you just as pregnant.  It's the best smell ever...</i>\"");
	//Rut:
	else if (player.inRut && player.hasCock()) outputText("\n\n\"<i>Well, let me put it like this: you smell like you walked in here to grab every girl here by the hips and breed them all for hours on end, until the whole lot of them's knocked up.</i>\"");

	else if (player.inHeat && player.hasVagina()) outputText("\n\n\"<i>Well, let me put it like this: You smell like you walked in here to tease and flirt with every man and herm in the place... stride into the middle of the floor like a queen, then pull off your clothes and bend over to let yourself be fucked and bred for hours until you were well and truly knocked up.</i>\"");

	//If player is in both heat and rut: 
	if (player.inRut && player.inHeat && player.hasCock() && player.hasVagina()) {
		outputText(" Urta shudders with desire and, to your shock, she starts openly fondling her huge prick ");
		if (!urtaLove()) outputText("under her skirt");
		else outputText("through her quickly-soaked dress");
		outputText(".  \"<i>Fuuuck, but you smell so goood... Goddess, I don't know which part of you I want more!  Gimme some of that, sexy... please!</i>\" she begs you desperately.");
		outputText("\n\nDo you present her with your cock?  Your pussy?  Or do you just stand here and watch as she jacks herself off in the middle of the bar?");
		//[Cock] [Pussy] [Watch]
		menu();
		addButton(0,"Cock",drunkUrtaIntroPartDuex,1);
		addButton(1,"Vagina",drunkUrtaIntroPartDuex,2);
		addButton(2,"Watch",watchDrunkRuturtaJerkoff);
	}
	else if (player.inRut && player.hasCock()) {
		drunkUrtaIntroPartDuex(1,false);
	}
	else {
		drunkUrtaIntroPartDuex(2,false);
	}
}
//(If in heat OR rut, or did not pick Watch)
private function drunkUrtaIntroPartDuex(chosenSex:int = 1, newl:Boolean = true):void {
	if (newl) clearOutput();
	else outputText("\n\n");
	urta.urtaSprite();

	outputText("Suddenly, Urta's hand dashes to ");
	//[if players has balls]
	if (player.balls > 0 && chosenSex == 1) outputText("your [balls], rolling them in her hand and squeezing a bit too roughly.");
	else if (player.hasVagina()) {
		outputText("your [clit], rubbing it until it's ");
		if (chosenSex == 1) outputText("the very same state [eachCock] seems to be in so often recently, ");
		outputText("erect and throbbing.");
	}
	else outputText("your [hips], stroking along them towards [eachCock] in an agonizing display of teasing.");

	outputText("\n\nThe fox herself shuts you up immediately by smashing her lips against yours and forcing her tongue inside your mouth.  You can't help but be excited by her aggressiveness");
	if (chosenSex == 1) outputText(", and [eachCock] already gets hard in your [armor].");
	else outputText(", and you feel the inside of your [armor] rapidly slickened by your [vagina]'s excitement.");

	outputText("\n\nYou're a bit surprised by the reaction, and while you're still putty in her hands, Urta pushes you onto the bar table with strength nigh-impossible for her frame.  You feel wood under your back.  Her tail unfolds and presents her already erect equine penis to you, ");
	//Player in both : 
	if (player.inRut && player.inHeat && player.hasCock() && player.hasVagina()) outputText("and she proceeds to maul her breasts, pre-cum seeping copiously from her cock and her snatch drooling over her balls and onto the floor.");
	else if (chosenSex == 1) outputText("but she doesn't seem to mind it for the moment.  Rather, the fur between her thighs appears to be rapidly soaking.");
	else outputText("which she seems more than intent to push into you, although you do see a bit of female lubricant sliding down her balls.");

	outputText("\n\nShe starts to struggle to get you free of your [armor], continuing her assault verbally.  \"<i>Of course, if you actually planned to do this, you'd at least have the courtesy to wait 'til I'm out of here, so I'm sure you don't mind.</i>\"  She seems frustrated by the fact your clothes are less than willing to cooperate in this position.  She does admirably well for someone already intoxicated.  \"<i>Ugh, you better be ");
	if (chosenSex == 1) outputText("hard");
	else outputText("wet");
	outputText(" for me</i>\"  Moments later, as you feel your naked [butt] against the table, her eyes dart to your ");
	if (chosenSex == 1) outputText(player.multiCockDescriptLight());
	else outputText("[vagina]");
	outputText(".  Her smile opens wider as Urta presents you with a sexy face that seems a mix of positively delighted and predatory.");

	//[If player is in Rut, OR is in Heat AND Rut AND chose "Cock":
	if (chosenSex == 1) outputText("\n\n\"<i>Well, I'm sure you don't mind if I take all your spunk and those few hours of fucking all for myself, instead,</i>\" she says as she brings one leg onto the table and the side of you as she sheds her dress, lubricant now drooling from the fox's female half, falling onto your [hips].");

	//[If player is in Heat, OR is in Heat AND Rut AND chose "Pussy":]
	else outputText("\n\n\"<i>I think you'll find that I'm more than stud enough for your greedy little twat...</i>\" she growls with lust, one hand stroking your [vagina], before she awkwardly hops up onto the table between your legs.");

	menu();
	if (chosenSex == 1) {
		if (player.cockThatFits(urta.urtaCapacity()) >= 0) addButton(0,"Next",drunkUrtaRidesARutPCsCock);
		else addButton(0,"Next",sateRutWithDrunkUrtaWithHugeDick);
	}
	else addButton(0,"Next",drunkenUrtaFucksPCInHeat);
}

//[If player is in Heat AND Rut and chooses "Watch"]
//[Watch Drunken Urta Jerk Off]
private function watchDrunkRuturtaJerkoff():void {
	clearOutput();
	urta.urtaSprite();
	outputText("You decide that you want to see the proud captain of Tel'adre's Watch reduced to a horny mess in the middle of the public, and so just take a few steps back and watch.");

	outputText("\n\nUrta's massive, equine phallus is so blatantly obvious that at last she ");
	if (!urtaLove()) outputText("pulls off her skirt");
	else outputText("roughly tears away her dress from the waist down");
	outputText(", exposing her flowing member and dripping gash to an appreciative audience.  Her head is flaring wide even as you watch, your scent too much for the lusty fox-morph now that her will has been eroded by copious amounts of booze.  Her tongue lolls freely from her mouth and she whimpers softly as she starts to stroke it with the ease of long practice, using both her hands to circle its three-inch girth and pulling up and down with her need.  Her apple-sized nuts and her D-cup tits alike jiggle and sway as she rocks back and forth on her heels with the motions of her pistoning arms.");

	outputText("\n\nYou surpress a giggle of amusement at the sight and begin to flaunt yourself, seeking to tease the poor herm - you have no doubts that she's secretly loving this.  After all, even though the whole bar seems to be staring right at her now, she's not even blushing.  Indeed, her posture changes; she starts holding herself firmer upright, more pride evident in her bearings, and from the way her cock just keeps rising up and up, a great puddle of herm pre-cum forming on the floor underneath her, it seems their attention is actually getting her off even more.");

	outputText("\n\nAs you slowly, languidly start to posture yourself for Urta's private delight, holding your clothes so they outline the hidden delights of your [chest], " + player.multiCockDescriptLight() + " and [vagina], bending over to let her stare longingly at your [butt], the fox-herm whimpers and moans.  By this point, her cock is standing practically straight up, and she releases it with one hand.  This now-freed hand slips between her legs to tend to her neglected slit, the fingers dancing artfully with audible squelches as they probe and fiddle.  Her other hand maneuvers her cock so that it lies squarely between her ample, soft breasts, clumseily trying to alternate between stroking her cock, fiddling with her black nipples, and mashing her tits together to give herself a tit fuck.  She awkwardly thrusts and humps into her own cleavage, pre-cum pouring down her front, bending down to lap at the flared head of her mare-dick.");

	outputText("\n\nYou take a glance away from Urta and realize that the combination of your pheremones, her little show and your own efforts at teasing her have got the other customers very excited indeed.  Pairs and even trios are starting to make out all over, singletons are beginning to fiddle with themselves, and there's a couple of very interested-looking herms, all playing with their cocks, that are giving lustful looks your way and heading towards you with an inept attempt at stealth.  Things could get pretty wild if you keep teasing Urta; maybe you should knock it off?");
	//[Stop Teasing] [Keep Teasing]
	menu();
	addButton(1,"StopTeasing",stopTeasingDatHornyFox);
	addButton(0,"KeepTeasing",keepTeasingDatHornyFawkes);
	//PCs with corruption 50+ will automatically choose Keep Teasing
}

//[=Stop Teasing=]
private function stopTeasingDatHornyFox():void {
	clearOutput();
	urta.urtaSprite();
	outputText("You decide there's no point taking things too far - besides, Urta seems just about ready to pop now, especially with how she's frantically suckling at her own cockhead.");

	outputText("\n\nAnd pop she does; pulling her head free from her cock with an audible popping sound, she throws it back with a howl more befitting a wolf than a fox as her swollen prick finally unloads its cargo, a fountain of foxy spooge spewing thick and slimy into the air and raining down all over her, plastering her from head to toe in her own jism, even as her cunt spasms and gushes fluid under her.  She cums and cums, drenching herself in herm-spunk until her legs give out and she falls flat onto her shapely rear, her cock giving one last ejaculate before it and she both fall limp onto the floor in the pool of cum.");

	outputText("\n\nSeeing her lying there so still makes you concerned and you quickly approach; you didn't want to kill her!  Thankfully, she's still breathing; she just passed out from the overload and from drinking too much.  Looking around you, you can see that an orgy is starting to break out around you, and you quickly make a break for it.  As you go, you can't help but wonder what in the world you were thinking...");
	dynStats("lust+",20 + player.lib/5);
	doNext(camp.returnToCampUseOneHour);
}

//[=Keep Teasing=]
private function keepTeasingDatHornyFawkes():void {
	clearOutput();
	urta.urtaSprite();
	outputText("You smirk; things are just starting to get fun around here, why would you stop now?  You start to amp up your routine even more, flaunting your scents and your goods for all the bar's occupants, not just the drunken fox-herm feverishly jerking herself off in front of you.  You can't recall if you've ever danced before coming to Mareth, but you don't think you do too bad as you perform an amateur strip-dance for the audience around you, slowly peeling off your [armor] and sensuously discarding them, bending over to let Urta and any other cock-bearing character present in the bar get a good look at your [vagina], ");
	if (player.balls > 0) outputText("lewdly cupping and fondling your [balls], ");
	outputText("slowly beginning to stroke and caress your " + player.multiCockDescriptLight() + " for the benefit of those who bear vaginas.");

	outputText("\n\nAs you seductively twirl around to face Urta again, you notice with surprise that she has stopped playing with her parts; instead, both of her hands are fiercely gripping her cock, just above her sheathe.  Putting an exaggeratedly disappointed expression on your face, you saunter confidently over to Urta, teasing her about what the matter is; doesn't she want to cum?  Her balls - you pause to jiggle them playfully - are so full of cum; surely it's time to cut loose and let it all out?");

	outputText("\n\nAt that, her eyes suddenly open wide - a madwoman's light burning in their depths.  \"<i>Yes it is!</i>\" she barks, suddenly pulling her cock around so that its head faces directly at your startled visage and releasing her grip.  A virtual cascade of cum geysers forth, spraying all over you!  You gasp and splutter, great wads of salty goo jetting into your mouth, matting down your [hair], spraying jism all over your [chest], blinding you and leaving you to fall back, reeling from the sudden onslaught.  You fall to your hands and ");
	if (player.isGoo() || player.isNaga()) outputText("what passes for knees on your [legs]");
	else outputText("knees.");

	outputText("\n\nAs you splutter and choke, you hear footsteps approaching; finally managing to wipe your eyes clear, you look up to see that you are surrounded by an array of herms, a riotous orgy going on all around you.  You don't have the time to clearly recognize what they are, because your attention is immediately drawn to the myriad forms of cock, all pointing at you, all quivering with the urge to release the cum that the cleverly-teasing hands are coaxing forth...");

	outputText("\n\nAnd then you are blind again as cum sprays at you from all sides, a deluge of spooge that drenches your face, spurts onto your back, plasters your hair, gushes over your titsdescript, puddles on your ass.  You are being sprayed from all sides, laughs and triumphant cries and taunts ringing in your ears.  They don't let up until you are utterly plastered with cum; then and then alone does the torrent die down.  Coughing and hacking to get the salty fluid out of your mouth and nose, you slowly rise up, grab your [armor], and ");
	if (player.cor < 50) outputText("run");
	else outputText("walk triumphantly");
	outputText(" from the racous orgy that is the Wet Bitch; truly an auspicious name.");

	//PC loses 1 hour, returns to TelâAdre, gains 15 lust, heat/rut unaffected//
	dynStats("lust+",15 + player.lib/10);
	doNext(camp.returnToCampUseOneHour);
}


//Sober Urta Variants 
//Sober Urta has a 45% chance to end rut/heat, depending on which one she's sating, and a 5% chance to intensify it with no modifications to the PCs attributes.
private function soberUrtaSatingPCHeat():void {
	//If she's Lover Urta, her vaginal capacity increases to cock area 66 (or at least it's what we planned).
	//Quote:[Sate Heat with Sober Urta]
	clearOutput();
	urta.urtaSprite();

	outputText("As she presses your back against the wall, you spread your [legs] wide, allowing Urta easy access to your awaiting womanhood");
	//[If herm]:
	if (player.hasCock()) {
		outputText(" by shoving your " + player.multiCockDescriptLight());
		if (player.hasCock() && player.balls > 0) outputText(" and [balls]");
		outputText(" out of the way");
	}
	else if (player.balls > 0) outputText(" by shoving your [balls] out of the way");
	outputText(".  Slowly, you feel the wide flared head of her magnificent pillar of flesh press onto your opening, spreading your vaginal lips and making your [clit] harden in anticipation just as your [butt] shivers, awaiting the intrusion.  Slowly, Urta's giant member starts to enter you.");
	if (player.vaginalCapacity() >= 100) outputText("  Your hungry gash eagerly welcomes her, Urta easily sliding herself home.");
	else if (player.vaginalCapacity() > 60) outputText("  You feel it stretch you in the most pleasuring of ways, filling you with warm, throbbing flesh as she pushes it deeper and deeper.");
	else outputText("  You wince in pain at being stretched so much, but you grow wetter and wetter as Urta slowly pushes herself inside your depths, your [vagina] slowly getting wetter and warmer, accepting the intruder.  Pleasure starts to override pain and you let out a gasp.");
	player.cuntChange(60,true,true,false);
	//virginity loss message, if appropriate//)

	outputText("\n\nYou moan in pleasure as Urta gets a foot or so of her erection inside you, and then keeps pushing.  Your insides, along with all their sensitive spots, are stimulated at once by the throbbing pillar of flesh that stretches you, and Urta finally has no more to give.  ");
	//[If Very Loose] 
	if (player.vaginalCapacity() >= 60) outputText("Urta's erection seems completely at home in your depths, completely embraced by the wet walls of your throbbing [vagina].");
	else outputText("You moan again, feeling Urta's member stretch, harden and throb, blood running through it.  You feel complete, and your heat is ignited further by the sensation of something so wonderful and big filling you.");

	outputText("\n\nUrta leans closer into your body, pressing her big breasts against your [fullChest] as she reaches down to stimulate your ");
	if (player.hasCock()) outputText("[cock biggest]");
	else {
		outputText("clitoris, ");
		if (player.clitLength < 2.5) outputText("rubbing the hard, stimulated sensitive spot between her fingers");
		else outputText("running her fingers over your entire big clit before stroking it like she'd do with a cock");
	}
	outputText(", letting you have a few moments to get used to her mammoth member and accommodate it.");
	
	outputText("\n\n\"<i>Ready to get fucked, lover?</i>\"  She pushes your back against the wall before withdrawing her hips and her cock, and then pushes back in, making you yell from the stimulation.  She starts to pound you with long, deep strokes, her giant hermhood stretching you wide and making it hard to feel or think about anything else other than pleasure.  Urta licks your [nipples] as she continues to pound into you, and you feel a fast-approaching orgasm.  The sexy hermaphrodite vixen rams herself into you a few more times before you let yourself go and announce your ecstasy to the walls of the empty alley.");
	if (player.hasCock()) outputText(" Cum rushes out of [eachCock] and onto the soft fur of Urta's abdomen, then starts leaking out slowly in time with her thrusts.");
	outputText(" Your cunt clamps down tighter onto Urta as you orgasm,");
	if (player.wetness() >= 4) outputText(" pussy juice shooting out around her member, coating Urta's fur and soaking her balls and the base of her cock.");
	else outputText(" love juices flowing liberally out of you, giving the skin of Urta's cock a visible shine and spreading onto her balls.");

	outputText("\n\nSqueezed by your hungry cunt, the fox hermaphrodite finds it impossible to retain control and grabs your [hips], lifting you and pressing you more firmly against the wall as she starts to pound the living heavens out of you, increasing the pace and ferocity of her thrusts.  Your [vagina] happily responds to the overstimulation by jumping onto the way to another orgasm, but Urta seems more visibly concerned with her own pleasure right now.");

	outputText("\n\nYou reach out to play with your [chest] and [nipples] while your other hand moves lower, starting to pleasure your ");
	if (player.hasCock()) outputText("[cock biggest]");
	else outputText("[clit]");
	outputText(".  Urta alternates between sensual moans and aggressive groans, her own thighs slightly soaked by her own secretions, but continues to pound you with her cock.  The two of you kiss passionately as she presses her breasts against your [chest], and you take the chance to move your hand and squeeze her own chest before moving an arm around her neck and pressing her stronger into the kiss.");

	if (!urtaLove()) outputText("\n\n\"<i>That feels so good!  Gonna cum!</i>\"");
	//[Lover Urta]
	else outputText("\n\n\"<i>Your pussy is absolutely the best, love!  I'm so close! I'll fill you up to the brim!</i>\"");

	outputText("\n\nYou moan loudly and beg Urta to blow her huge load inside you, sure that it will at least calm the heat down while setting off your own orgasm.  The two of you climax almost simultaneously, her huge member suddenly pumping a huge wave of fluid inside your [vagina] just as it starts to squeeze and clench, love juices ");
	if (player.wetness() >= 4) outputText("shooting out all over the place");
	else outputText("running down her member and the crack of your [butt], coating the two of you in the proof of your passion");
	outputText(".");

	outputText("\n\nThe first two surges of Urta's seminal fluids stretch your insides with hot, sticky goo, your breeding state registering that it's getting what it needs and starting to work on squeezing out more.  The problem is, trying to get more out of Urta can be quite dangerous; wave after wave of semen flows out of her cock and into you, cum gushing out on the side of her cock as she thrusts, giving you a small paunch, then quite the belly as she continues to fill you up. The insemination triggers another orgasm in you, ");
	if (player.hasCock()) outputText("your own member responding alike to Urta's, shooting out semen, ");
	outputText("your [vagina] ");
	if (player.wetness() >= 4) outputText("once again setting off to coat Urta in your juices.");
	else outputText("squeezing on her, trying to milk her of her seed.");

	outputText("\n\n\"<i>By Marae, [name]!  Fuck, you're squeezing me dry!</i>\"");

	outputText("\n\nAfter a while, her shots get smaller, starting to become similar to what a normal male would ejaculate with until, finally, she is only dribbling her seed out into you.  Urta sets your feet back onto the ground and starts to pull out.  You feel the skin at the base of her cock leave you, followed by her shaft, but your pussy suddenly clenches, apparently wanting to keep the intruder inside.");

	outputText("\n\n\"<i>What?  ");
	if (!urtaLove()) outputText("You're still not satisfied?</i>\"");
	else outputText("You want to keep going, darling?  I want to make you satisfied, so I'll spare all the time I can!</i>\"");

	outputText("\n\nYou slowly nod and express the desire to continue.  Urta pulls the rest of her member out of you with a loud squelch, her warm seed running down your [hips], your belly slightly receding.  She motions for you to turn away from her and you get the message, sticking your [butt] out.  The vixen grabs you by your [hips] and brings her semi-erect, but slowly hardening member back to the entrance of your hole.  With a thrust, her tip is once again inside your [vagina], and you push your hips back against her, devouring inch after inch of her member with your greedy breeding hole.");

	outputText("\n\nUrta groans as she rams the rest of her cock into you, filling you with her extraordinary, equine breeder once again.  Then, she begins to hump you from behind, smacking her groin against your [butt] as her member stretches you.");

	outputText("\n\nYou reach down to play with yourself, your [clit] ");
	if (player.hasCock()) outputText("and " + player.multiCockDescriptLight() + " ");
	outputText("hardening again in response to the act.  Urta continues to slam into your backside, delivering a small smack to your [butt].");

	//Regular Urta]
	if (!urtaLove()) outputText("\n\n\"<i>Such a greedy slut!</i>\"");
	//[Lover Urta] 
	else outputText("\n\n\"<i>You want your sexy vixen to breed you that much?  You can't think about anything else but my cock plastering your ravenous cunt with my fun juice?  You'll get it, baby, rest assured!</i>\"");

	outputText("\n\nYou moan in ecstasy and anticipation as she picks up the pace, pumping in and out of your pussy.  You're pretty sure you've had another orgasm somewhere along the way, but your mind is absolutely focused on the crowning moment of the act.  It rapidly approaches.  Urta empties her balls into you, stretching you wide with hot, sticky white liquid.");

	outputText("\n\nThe vixen squeezes your [butt] as she drives herself fully home, and you feel her member paint the deepest of your insides with her precious seed as it pulses and twitches inside you, stretching you unimaginably wide and pleasuring the entirety of your womanhood at once while delivering its seed straight into your womb.  You yell in complete, all-encompassing rapture as ");
	//[Hermaphrodite]
	if (player.hasCock()) outputText("[eachCock] shoots its seed onto the floor of the alley, helplessly");
	else outputText("your [vagina] squeezes and tugs on her shooting member, leaking its own juices all over her member, the intensity of the orgasm shaking you right into your core");
	outputText(".");

	outputText("\n\nUrta lumps onto your back, completely spent, her member slowly softening as she pants against your neck. You never felt so full in your entire life, much of her previous load still trapped inside you, now in addition to her twenty inch member and another big delivery of warm herm-cum.  Slowly, she pulls out, and you feel the impossibly long way her semi-erect member has to undertake in order to leave your cum-coaxing channel.");

	outputText("\n\n\"<i>That felt amazing!  ");
	if (!urtaLove()) outputText("If only I had you by hand every time I need to blow a load.");
	else outputText("Your pussy is absolutely amazing, sweetheart: I hope I've helped you settle down?  Is your heat sated for the moment?");
	outputText("</i>\"");

	outputText("\n\nYou turn to Urta again as you slump against the wall, resting your [butt] on the floor.  You sigh contentedly and thank her for her help with your heat, as her cum flows copiously out of you.");

	outputText("\n\n\"<i>");
	//([Regular Urta]
	if (!urtaLove()) outputText("Sure thing, I'm here to help,</i>\" she responds with a wink.");
	else outputText("I'm here if you need me, love.  Whatever makes you happy.  You've helped me with my own problems so much already, so I owe you at least one.  Not to mention, making love to you feels absolutely amazing!</i>\"");

	//[If Urta is infertile]
	if (!urtaQuestDone()) {
		if (!urtaLove()) outputText("\n\n\"<i>We are safe.  No matter how much sticky goo I pump into you, you shouldn't get pregnant.</i>\"");
		else outputText("\n\n\She seems slightly sad, or at least not very pleased with herself as she explains her effective infertility once again.");
		outputText("  She grabs your hand and helps you stand up.");
	}
	//[If Urta's fertility quest is done]
	else {
		outputText("\n\n\"<i>Ahhh, [name], you might get pregnant!</i>\"  She kneels in front of you, kissing you on the forehead. \"<i>I don't think all the contraceptives in the world could stop that...</i>\"");
		if (flags[kFLAGS.URTA_FERTILE] == 1) {
			player.knockUp(PregnancyStore.PREGNANCY_URTA, PregnancyStore.INCUBATION_URTA, 25);
			player.knockUp(PregnancyStore.PREGNANCY_URTA, PregnancyStore.INCUBATION_URTA, 25);
			player.knockUp(PregnancyStore.PREGNANCY_URTA, PregnancyStore.INCUBATION_URTA, 25);
		}
	}

	//([Regular Urta]"You probably should learn to control yourself well enough so that next time, we can get clean at my home, not to mention fucking in the middle of the street is just:"/[Lover Urta]â Baby, next time, at least wait until we get back home, okay? Not to mention, when you provoke me, you're completely irresistible, so try to be considerate: It was amazing, though. I love you.â She says, as she kisses you gently on the lips.)
	flags[kFLAGS.URTA_COMFORTABLE_WITH_OWN_BODY]++
	urtaLove(1);
	outputText("\n\nSatisfied, the two of you part ways here, Urta apparently searching for something after waving at you when you leave. Your heat somewhat calmer now, you find yourself on your way back to camp, sticky jism running in a thin trail down your [legs] while your [vagina] desperately clenches to hold it all in.");
	//Usual one hour passes//
	player.orgasm();
	dynStats("lib",1,"sen-",2);
	dynStats("lust=",0);
	dynStats("lust=",0);
	dynStats("lust=",0);
	flags[kFLAGS.URTA_TIME_SINCE_LAST_CAME] += 6;

	doNext(camp.returnToCampUseOneHour);
}

//Quote:[=Sate Rut with Sober Urta: Cock Too Big=]
private function sateRutWithSoberUrtaButHuegDicked():void {
	clearOutput();
	urta.urtaSprite();
	var x:int = player.biggestCockIndex();
	outputText("Urta observes your approaching " + player.cockDescript(x) + " with a hungry, eager expression. Without taking her eyes off of it, she flips up her ");
	if (!urtaLove()) outputText("skirt");
	else outputText("dress");
	outputText(", her huge horse-cock whipping up to slap between her breasts, pre already dribbling down the tip.  However, as you get closer, her expression suddenly falls and her cock begins to sink.  \"<i>I'm sorry, but... that's just too big!</i>\" she protests.  \"<i>You smell absolutely gorgeous, and I'm willing to try with something a little bigger than usual, but that's... that's just frigging huge - there's no way I could fit that monster!</i>\" she declares. \"<i>Just because I have a stallion cock doesn't mean I have a mare's cunt!</i>\"");

	outputText("\n\nYou stare at your " + player.cockDescript(x) + " in an uncomprehending fashion.  How are you going to find relief now?  You look up as Urta saunters over towards you in a seductive manner, erect cock jutting before her and a mischievous grin on her face.  \"<i>While I'll have to go and attend to this myself later, I can still give you a hand...</i>\" she purrs throatily.  She kneels before you, and you have to watch yourself to avoid having her twenty inches of cock slap your [leg].  Confidently, she reaches out to take hold of your " + player.cockDescript(x) + ", first with one hand, and then the other.");

	outputText("\n\nHer touch is incredible; she applies just the right amount of pressure, her fingers moving to touch all of the spots that respond best to being touched as she moves her hands up and down.  She caresses and she tickles, she fondles and she strokes, all with an expertise that you can hardly believe.  Your breath catches in your throat and your heart hammers wildly in response to the intense pleasure she's bringing you.");

	outputText("\n\n\"<i>One advantage of having a chick with a dick of her own for a lover,</i>\" she comments, trying to sound nonchalant, but wearing the biggest, smuggest smirk you have ever seen on her face.  \"<i>She knows exactly what makes a handjob feel good...</i>\"");

	//Regular Urta path
	if (!urtaLove()) {
		outputText("\n\nUrta isn't idly boasting; you can't remember the last time a handjob felt so good, even when you were the one doing it.  It's not very long before you find yourself cumming explosively, ");
		if (player.cumQ() <= 50) outputText("spattering spooge onto Urta's face");
		else if (player.cumQ() <= 250) outputText("splashing her face and tits with your cum");
		else outputText("soaking the shocked fox-morph in your jism");
		outputText("; though you still feel the urge to breed fertile females, your lust is momentarily sated.  Urta wipes ");
		if (player.cumQ() >= 500) outputText("halfheartedly ");
		outputText("at the cum on her faces and gives you a friendly smile.  \"<i<There, that should feel better; I know what it's like to be all pent up with no release.</i>\"  She rises to her feet, still holding your cock, and gives it a squeeze.  \"<i>In the meantime, if you want to really cut loose, I suggest you go and find something to shrink this down.</i>\"");
		outputText("\n\nWith surprisingly vulpine shake of her body and a soft sigh, she turns and heads home at a swift pace, her erection bobbing up and down before her; evidently, she's intending to use some of her toys to find some release of her own. You re-dress and head back yourself, trying to make sense of your inhuman breeding rut.");
	}
	//Lover Urta Path/
	else {
		outputText("\n\n\"<i>Of course,</i>\" she adds. \"<i>There are far nicer things to play with than mere hands,</i>\" she teases, then she bows her head closer, jaws opening and long, drooling tongue descending to gently lick the head.  She carefully licks and suckles, getting the head nice and lubed, then bravely begins swallowing it, gulping it in as far as she can.  You can soon feel it jabbing against the back of her throat, and though she tries to go beyond, she can't; her gag reflex is too strong, making her choke and cough, drooling heavily down your shaft.");

		outputText("\n\nShe pulls her head free and gasps for breath, looking at you in admiration. \"<i>By Marae... how do you manage to do this for me, lover?</i>\" she asks, stunned.  But then, gamely, she returns her attention to your " + player.cockDescript(x) + ", licking, suckling and mouthing at the head.  As she does this, she continues her restless assault with her hands upon the rest of your lengthy shaft with her skilled hands.  She shuffles closer, allowing you to rest yourself between her DD-cups.  \"<i>Can you feel how fast my heart is beating through your cock?  You turn me on so very much,</i>\" she purrs.");

		outputText("\n\nIt's no surprise that eventually you can't hold back anymore and release yourself into Urta's ready mouth.  ");
		if (player.cumQ() <= 50) outputText("She swallows it all without complaint, licking her lips clean of any stray droplets once you remove it from her mouth.");
		else if (player.cumQ() <= 250) outputText("Her cheeks bulge at the amount you pump into her, but she's able to swallow with an admirable amount of control, gasping for breath.");
		else outputText("Rivulets of cum burst from between her lips, but she stubbornly sucks and swallows as much as she can, her stomach starting to bulge from the sudden influx of spooge.  When you stop, she is drooling cum and gasping for breath, but she meets your eyes with pride, even as she gives a wet belch.");

		outputText("\n\n\"<i>Mmm... you taste nice, lover.  Still, I'd much rather feed this into the hole where it belongs, so why don't you try and shrink this monster down, huh?</i>\" she suggests.  Rising to her feet, with a surprisingly vulpine shake of her body and a soft sigh, she turns and heads home, her erection bobbing up and down before her; evidently, she's intending to use some of her toys to find some release of her own. You re-dress and head back yourself, trying to make sense of your inhuman breeding rut.");
	}
	dynStats("lib+",1,"sen-",2,"lust=",0);
	flags[kFLAGS.URTA_TIME_SINCE_LAST_CAME] += 1;
	doNext(camp.returnToCampUseOneHour);
	///Player returns to Tel'Adre Menu, usual one hor passes//
}

//Quote:[=Sate Rut with Sober Urta=]
private function sateRutWithSoberUrta():void {
	var x:int = player.biggestCockIndex();
	clearOutput();
	urta.urtaSprite();
	outputText("Urta observes your approaching package with a hungry, eager expression. Without taking her eyes off of it, she flips up her skirt, her huge horse-cock whipping up to slap between her breasts, pre already dribbling down the tip.");

	outputText("\n\nThe sight makes you halt your advance.  Not out of disgust with Urta's body - how could you be, when you've had sex to her before now?  No, the problem is that you can't figure out how to approach her - those apple-sized balls of hers are in the way.");

	outputText("\n\nUrta looks at you, and then starts to push herself up off of the wall, obviously intending to turn herself around and present her rear to you for ease of access.  As the realization comes in, you suddenly move, pinning her back against the boards.  She looks at you, askance, and opens her mouth to speak, when you interrupt her by kissing her.  As your tongues tangle inside her mouth, you reach down and grab her balls.  They are too big to be palmed in one hand, and you jiggle them accidentally.  Urta moans and whimpers at the stimulation and for several long moments you stroke and caress her cum-swollen testicles, pre starting to pour from her flared cock-tip, smearing her beautiful big DD-cup breasts and your own [chest] alike.  You can feel her nipples rubbing against yours, sparks of electricity surging through you both at the contact.  Finally, though, you manage to awkwardly hoist up her balls, allowing your " + player.cockDescript(x) + " access to her drooling black netherlips.");

	//(Regular: 
	if (!urtaLove()) outputText("\n\n\"<i>Yes - give it to me!</i>\"");
	else outputText("\n\n\"<i>Oh, yes!  It feels good when you're the one desperately wanting to stick it inside me, for a change.  I love to feel desired by you, you know.  Now give it to me!</i>\"");
	outputText(" she mumbles around your tongue, so caught in lust she doesn't care where you are.  Indeed, it seems your little fox-herm has something of an exhibitionist streak...");

	outputText("\n\nWell, you don't intend to keep the lady waiting any longer then you have to, and you slide it home, allowing her testicles to drop once you are safely inside.  The globular organs bounce atop your " + player.cockDescript(x) + " and rock back and forth against your belly, jiggling with every movement the two of you make, Urta's cock sandwiched firmly between your bodies and held between her breasts.");

	outputText("\n\nUrta finally breaks the kiss and leers at you.  \"<i>Kinky " + player.mf("boy","girl") + "...</i>\" she teases you, \"<i>but I like that.</i>\"  She promptly starts to rock back and forth, seeking to simultaneously impale herself repeatedly upon your shaft and to grind her own huge cock between your bodies.");
	if (urtaLove()) outputText("  \"<i>You're the only one who has ever accepted every part of me,</i>\" she tells you, one hand brushing affectionately against your cheek.");

	outputText("\n\nYou simply moan back, your lust-addled mind only able to concentrate on the fact you are surrounded by her womanhood. You thrust back and forth, your " + player.cockDescript(x) + " surging deep inside her and then wetly pulling out, only to slide back home.  You nip and kiss her prominent nipples, making the vixen churr in delight, and she kisses you back.  Her front is plastered with pre now, her cockhead bubbling fluids like a fountain, and you can't resist bending down and playing with her cockhead.  She yips and growls with pleasure as you molest her hermhood, your tongue playing around the tip, lapping the sweet pre as it flows forth.  She surprises you by craning down her neck and starting to lap at it herself, her long, broad tongue curling expertly around its wide-flared tip.  The two of you make a game out of it, seeing who can better lick and lap, occasionally running your tongues over each other's whilst doing so.");

	outputText("\n\nAll the while, Urta's happy cunt milks and squeezes you rhythmatically, even as you thrust yourself eagerly into her depths.");

	outputText("\n\nIt's no surprise that, of the two of you, it's Urta who loses control first.  Throwing her head back in a vulpine howl, she cums - her cunt grips you like a vice, even as her feminine juices spurt forth to splatter against your crotch.  Pressed against her like you are, her balls bouncing on your " + player.cockDescript(x) + " and her cock sandwiched between your bodies, you can feel every inch as her swollen balls finally begin to contract, thick wads of herm-cream surging up her long, broad mare-prick, the bulges rippling past your bellies before, finally, they reach the tip and spray forth into the air.  The hot, salty spooge rains down in thick, gooey blobs all over both your faces.  Caught up in the moment, you lift your head back and try to catch some of it in your mouth, an action that Urta unthinkingly copies.");

	outputText("\n\nFinally, your own " + player.cockDescript(x) + " reaches all it can take and explodes inside of Urta");
	if (player.hasVagina()) outputText(", trigging a mutual explosion from your [vagina]");
	outputText(".  The two of you gasp for breath, both obviously drained... but your hormones are boiling, and your " + player.cockDescript(x) + " fails to soften fully inside her.  Within moments, you are hard again; as soon as you catch your breath, you are at it again.  You lose count of how many times you do it - maybe three or four? - but finally you are so spent that even your rut is sated that you've bred Urta well and good, for now, at least.");

	outputText("\n\nWhen at last you are finished, you and Urta are both a sight, drenched in sticky, slimy spunk.  Your clothes are okay, thankfully, but Urta's are a mess.  Neither one of you care, and you hold onto each other for a while still.  Finally, you pull yourself free of Urta's pussy with a wet slurping noise, allowing her now-flaccid cock to flop heavily through the air as it peels away from your bodies.  Urta looks you over and shakes her head in amused disbelief.");

	outputText("\n\n\"<i>What a mess... but, honestly, it was worth it.  Feeling better now?</i>\" she asks you.  When you nod your head slowly, she smiles and then starts to strip herself out of her cum-splattered clothes until she is casually naked before you.  She ");
	if (urtaLove()) outputText("blows you a kiss with a flirty wink of her eye and then ");
	outputText("scrubs off the worst of the cum plastered in her fur with the dry parts of her clothes.  She saunters playfully over to a garbage bin, throwing them inside.");
	if (urtaLove()) outputText("  Her hips deliberately sway in a mesmerizing fashion, tail flicking from side to side to give you a tantalizing grip of her still-dripping snatch and the now-flaccid prick underneath.");
	outputText("  You watch as she pries at a loose stone with her claws, removing it to reveal a small cubby, from which she withdraws a spare set of clothing.");

	//If fertility quest done:
	if (urtaQuestDone()) {
		outputText("\n\nYou ask Urta what she's going to do; you didn't have the chance to use a condom.");
		if (flags[kFLAGS.URTA_FERTILE] == 1) outputText("\n\n\"<i>We'll just have to hope then, won't we, [name]?</i>\"");
		else outputText("\n\n\"<i>I'm not likely to get pregnant with all the birth control I'm on right now, even with all that cum in me.</i>\"\n\nFeeling relieved, you turn and head out into the streets of the city.");
		urta.knockUpUrtaChance();
		urta.knockUpUrtaChance();
		urta.knockUpUrtaChance();
	}
	else {
		outputText("\n\nShe saunters over you and waves a finger under your nose in playful mockery.  ");
		if (!urtaLove()) outputText("\"<i>And you had better learn to control yourself, " + player.mf("mister","missy") + ".");
		else outputText("\"<i>But you should learn to control yourself lover-" + player.mf("boy","girl") + ".");
		outputText("  I'd rather do something like this in the privacy of my home than in the middle of the street.</i>\"");
		outputText("\n\nYou smirk and tell her you'll make no promises.  She gives your [butt] a smack that echoes off of the walls, then saunters away.  Feeling relieved, you turn and head out into the streets of the city.");
	}
	flags[kFLAGS.URTA_COMFORTABLE_WITH_OWN_BODY]++;
	urtaLove(1);
	//usual one hour passess, player is back in TelâAdre//
	//Knock up urta if appropriate.
	flags[kFLAGS.TIMES_RUT_FUCKED_URTAS_CUNT]++;
	dynStats("lib+",1,"sen-",2,"lust=",0);
	flags[kFLAGS.URTA_TIME_SINCE_LAST_CAME] += 6;
	doNext(camp.returnToCampUseOneHour);
}

//Drunken Urta Variants 
//Quote:Drunken Urta always affects heat/rut when penetration is involved (meaning she doesn't in her frottage scene and watch-her-masturbate scene), and has a 50% chance to either extinguish it or intensify it.
//When penetration is involved, sex with Drunken Urta while in Heat/Rut increases both Toughness and Libido by 2 points and lowers Sensitivity by 4 points. Player often loses more than 1 hour and has to return to camp, rather than stay in TelâAdre. When getting penetrated, Urta's vaginal capacity is bumped up to 72.

//Quote:[Drunken Urta Fucks Vagina]
//This scene only plays if the character is in heat, or is in both heat and rut and chose "Pussy"
private function drunkenUrtaFucksPCInHeat():void {
	clearOutput();
	urta.urtaSprite();
	outputText("You simply smile at her, inhaling deeply through your nose; you can swear you can smell her herm-musk, wafting off of her as strongly as your own pheromones must be wafting off of you.  That wonderful, earthy, primordial scent, the odor of a healthy breeder ready and willing to mate... there's nothing like it.");
	//(Fertility Quest not done:
	if (!urtaQuestDone()) outputText("  You know that she can't give you babies... but, honestly, at this moment, you couldn't care less. Her wonderful stallion cock is there and ready and it's all for you.");
	else outputText("  You dimly recall that Urta could be virile, but she's right there, her huge mare-cock just dripping to plunge into your ripe [vagina] and knock you up.  You don't care anymore; you want her babies!");

	outputText("\n\nUrta's eyes glitter with emotion and she bends down to give you another kiss before roughly grabbing her ");
	if (!urtaLove()) outputText("skirt");
	else outputText("dress");
	outputText(" and hiking it up to expose her pre-spewing cock.  A steady trickle of feminine lubricant dribbles out of her gash, oozing over her apple-sized balls and dripping noisily onto the floor, but Urta couldn't care less; she's too fixated on plunging her maleness into your ready pussy to notice her feminine urges.");

	outputText("\n\nAwkwardly, reluctantly, the fox-morph backs away, her soft fingers with their claw-like nails trailing erotically down your body, playing with your [nipples] in a way that sends sparks of pleasure surging through your brain, until finally she has reached your crotch.  Sparing you a soft smirk, she bends her head down until her face is hovering right about your [vagina], dramatically sniffing the scent rising from your fertile breeding-hole before she sticks her muzzle into it");
	if (player.hasCock()) 
	{
		outputText(", impatiently nudging aside your " + player.multiCockDescriptLight());
		if (player.balls > 0) outputText(" and your [balls]");
		outputText(" to get to the feminine orifice below");
	}
	outputText(". You cry out in joy as your [vagina] is filled, her soft fur brushing against your inner walls before she opens her mouth as wide as she can and sticks out her tongue. The long, broad, vulpine appendage slides out and up your depths, caressing the walls, lapping up your juices, ");
	if (player.clitLength < 2.5) outputText("playing with your [clit]");
	else outputText("lapping around your huge pleasure-button, slurping it into her mouth where she suckles from it");
	outputText(", and making you thrash and scream until you think you're going to cum from the pussy-eating alone.  ");
	if (player.wetness() >= 4) outputText("As if to emphasize this, your squelching, slurping pussy suddenly sprays fem-cum all over Urta's face, making her pull herself free with a shocked shake of her head.");
	else outputText("As if sensing your impending orgasm, Urta removes her head from your [vagina], giving you a cocky grin and shaking her head.");

	outputText("\n\nNow that you've been properly lubed up, Urta suddenly springs at you, literally vaulting atop you whilst at the same time thrusting her huge prick into your [vagina].");
	if (player.vaginalCapacity() < 60) outputText("  Urta's cock is long and thick enough to be something a stallion would be proud of, and far larger than should be comfortable. Its sheer girth and flared head snag against your opening, before the lust-crazed herm vixen roughly forces it through, impatiently feeding inch after inch of girthy herm-hood into your lower lips.  The sudden intrusion of something so long and broad stretches your poor pussy wide, but the shock and the pain merely turn into pleasure in your lust-enthralled mind.");
	else outputText("  Urta's mammoth cock fits you like a hand fits into a comfortable glove, and you howl in joy as it slides home, stretching you in all the right places, able to feel every bump and vein on its surface, the flared tip thrusting into the deepest part of you.");
	player.cuntChange(60,true,true,false);

	outputText("\n\nLike an animal, Urta begins to rock back and forth, thrusting her cock wildly into you with brutal eagerness, slamming you with such force that the table creaks and groans in a manner that would be most alarming if you weren't too caught up in your own pleasure to care.  You throw your head back in ecstasy, getting brief glimpses of the situation in the bar around you.  It looks like the others are enjoying the show quite a lot in their own right - you see more than a few couples or threesomes starting to kiss, fondle each other, even beginning to have sex on their own.");

	outputText("\n\nUrta's usual shyness seems forgotten - as do her usual manners, for she pays no attention to your [clit] ");
	if (player.hasCock()) outputText("nor even your " + player.multiCockDescriptLight());
	outputText(", despite usually trying to make it just as good for you.  She begins to thrust into you with even greater force than before.  You groan and whimper under her; partly from the pleasures of being taken so roughly, so triumphantly, and partly to goad her on, to make her feel even more aroused and alpha-male-like.");


	outputText("\n\nIt works.  Urta howls in triumph as her cock finally explodes insides you, flooding your interior with her hot, salty cum.  Your belly gurgles and bulges as she shoots spurt after spurt of spooge inside you, flooding your womb with her herm seed.  You cry out in ecastasy as your own juices pour forth, your [vagina] doing its best to milk as much cum from your vulpine lover as possible.  As your belly swells out into a small paunch, the last few jets of cum splashing into your womb, you wait for the exhausted Urta to pull out... and then you realize that Urta's cock isn't going soft.  You can feel it start to slacken, but it remains fundamentally erect, and after a few deep breathes, Urta begins to thrust into you once again, her erection rapidly stiffening and hardening within you until she is pounding at you again, just as fiercely before.  Again she spews her seed within you, but once more her erection fails to soften; though much of her cum is pinned up inside you by the sheer thickness of her cock and the widely flared head buried inside you, a copious amount still manages to leak and dribble out of you, dripping down between your [butt] and puddling onto the table.");

	outputText("\n\nAs you lay there on the table, bucking and thrashing with ecstasy as your lover fills you in the way only she can, the other bar-goers of the Wet Bitch breaking down into a chaotic orgy around you, all you can think of is to ask Urta for more.  And more is what she gives you; as you finally black out, your last sight is of your stomach, huge and swollen with Urta's cum, jiggling and sloshing above you.");

	player.cuntChange(60,true,true,false);

	outputText("\n\n<b><u>A bit later...</u></b>");
	outputText("\nWhen you wake, you find yourself in unfamiliar surroundings - you're in a bed, you realize. That it's Urta's bed quickly becomes apparent when you see the fox-herm in question sitting on a cushioned seat beside you, holding a wet towel gingerly over her crotch.  \"<i>Um... hi,</i>\" she says, shyly.  \"<i>That was... well, I won't say I didn't enjoy it, but I don't think I'm going to be able to get it up for a week,</i>\" she tells you.  \"<i>Also, can we try and keep that kind of thing in private, in the future?  It looks bad when the Captain of the Guard not only starts a public orgy, but needs to get hosed down for several minutes to make her stop fucking somebody.</i>\"");

	outputText("\n\nMoving gingerly, wincing at your own tenderness, you tell her you'll try and do that in the future.");

	//If fertility quest is done: 
	if (urtaQuestDone()) {
		outputText("\n\nYou hesitantly ask her what the two of you are going to do now; you were in heat, and you know for a fact she didn't have a condom on.");
		if (flags[kFLAGS.URTA_FERTILE] != 1) outputText("\n\nUrta smiles and informs you that she was taking things to prevent that, luckily.");
		else outputText("\n\nUrta smiles beatifically, \"<i>I know, isn't it wonderful?</i>\"");
	}

	outputText("\n\nUrta hands you your clothes and gives you a hand to dress yourself; there isn't anything erotic about it, as both of you are still too worn out to make sex feasible again just yet.  Once you are dressed, you start to show yourself out... before Urta suddenly grabs your shoulder and then kisses you.  \"<i>I never said I didn't like it,</i>\" she suddenly declares, to your bemusement, before gently pushing you out the door.");

	outputText("\n\nThe walk back to camp is quite painful, but you'll live.  That which doesn't kill you makes you stronger, and all that...");

	if (flags[kFLAGS.URTA_FERTILE] == 1) {
		player.knockUp(PregnancyStore.PREGNANCY_URTA, PregnancyStore.INCUBATION_URTA, 25);
		player.knockUp(PregnancyStore.PREGNANCY_URTA, PregnancyStore.INCUBATION_URTA, 25);
		player.knockUp(PregnancyStore.PREGNANCY_URTA, PregnancyStore.INCUBATION_URTA, 25);
	}
	//player returns to camp and loses 4 hours//
	dynStats("lib",2,"sen",-4,"lust=",0);
	dynStats("lust=",0);
	dynStats("lust=",0);
	dynStats("lust=",0);
	flags[kFLAGS.URTA_TIME_SINCE_LAST_CAME] += 24;
	flags[kFLAGS.URTA_COMFORTABLE_WITH_OWN_BODY]++
	urtaLove(1);
	doNext(camp.returnToCampUseFourHours);
}

//[Sate Rut with Drunken Urta â Cock too big]
private function sateRutWithDrunkUrtaWithHugeDick():void {
	clearOutput();
	urta.urtaSprite();
	outputText("Urta climbs on top of you, pressing her wet slit against the head of your cock.  She does attempt to get it inside, but the pain of being stretched quickly makes her realize that even if she managed to, the fuck would be less than enjoyable and more than a little painful.  She groans and growls in frustration, pulling herself off you and pressing her apple-sized balls ");
	if (player.balls > 0) outputText("against your own [balls]");
	else if (player.hasVagina()) outputText("against your [clit]");
	outputText("between your [hips]");
	outputText(".");

	outputText("\n\nSometimes, this thing can get so big it's essentially useless, you dumbass.  Hell, I'd know that, and I'm smaller than you are!");

	outputText("\n\nShe presses her still impressive hermhood against your own [cock biggest], using both of her hands to encircle your joined shafts and start jerking them off.");

	outputText("\n\n\"<i>I got all hot and bothered, too!  I was so ready to give you a good, long, awesome fuck, but you had to go and grow yourself a fucking monster!</i>\"");

	outputText("\n\nThe warmth of her cock and balls pressed against your own [cock biggest] as well as her skillful, if somewhat brutal handling of your members, pressed together, does give you quite the pleasure, but you realize it'd be infinitely better if Urta indeed put your throbbing penis in her wet, tightly squeezing pussy.");

	outputText("\n\n\"<i>Why the hell do you need such a big dick anyway?  Freakin' monsters need less than that to be satisfied!  You trying to ");
	if (player.biggestCockArea() < 150) outputText("compete with minotaurs or something?");
	else outputText("set a world record or something?");
	outputText("</i>\"\n\n");
	outputText("\n\nHer treatment of your [cock biggest], pressed against her own shaft, gets more rough, brutal and frantic, but you realize you're both on the edge of an orgasm and she's just trying to be done with it and blow off her own steam.  Your [cock biggest] starts leaking precum copiously as your shaft is covered in Urta's own secretions, and with a blush, you realize her wet pussy is leaking her juices over her balls and your body all the way down to your [asshole].");

	outputText("\n\nUrta starts whimpering and moaning softly as her shaft twitches with more and more intensity against your own, Urta's jerking hands moving faster and faster.  Unable to control yourself, you also grab your conjoined cocks, four hands now working on Urta's equine erection as well as your [cock biggest].");

	outputText("\n\n\"<i>F-fuck!  Gonna cum!</i>\"");

	outputText("\n\nYour orgasms are almost synchronized, the feeling of Urta's penis rapidly pulsing as it coats the tip of your own [cock biggest] with her semen enough to set off your own orgasm.  ");
	if (player.cumQ() <= 50) outputText("You cum all over your [chest] as Urta blows thick ropes of vixen-spunk all over your cock and upper body, a single shot landing on your lips.");
	else if (player.cumQ() <= 500) outputText("As Urta's shaft spasms and starts covering your [cock biggest] and [chest] in warm herm-jizz, you feel a surge of cum run through your cock, blowing strongly underneath Urta's aroused, warm body, with enough force to go up to your neck and even coat her large breasts in a few droplets of your semen.  Urta instinctively licks some of your spooge, but there's a lot of it and you feel yourself coated in your own cum as well as hers.");
	else outputText("The dam inside your [cock biggest] lets loose, shooting off spunk everywhere, even putting Urta's own impressive orgasm to shame.  You cum so much the fur of her lower body is covered with it, thick ropes of semen cover her breasts, your [chest] is practically drowned in thick white goo, and you give yourself quite the facial or two under her cock-milking hands.");

	outputText("\n\nUrta milks the last few drops from both of your cocks, looking half-satisfied, half-irritated on your cum-covered body.  She gets off you and you notice you attracted quite the audience.  Urta's hands reaches down to her dripping wet vagina, spreading it and pushing a finger inside.  You realize this must be the reason for her frustration; although she blew a load, this single time it was her female parts that were more turned on.");

	outputText("\n\n\"<i>Go and clean yourself.  And if you're gonna run around the place, smelling like you're so eager and ready to knock people up, at least make it so your stupid monster of a dick can fit inside someone!</i>\"");

	outputText("\n\nShe hops off the table with unusual grace and agility for someone after a few drinks and covered in cum, and walks to the table to pay her bill.  Contrary to her words, she appears to look somewhat sad and disappointed, both in you and herself.");

	outputText("\n\nRealizing there's no point in talking to her and just somewhat sated, you return to your camp.");
	//[+1 Libido, -1 Sensitivity; No effect on your rut]
	dynStats("lib",1,"sen",-1,"lust=",0);
	//player returns to TelâAdre and loses 1 hour
	flags[kFLAGS.URTA_TIME_SINCE_LAST_CAME] += 1;
	flags[kFLAGS.URTA_COMFORTABLE_WITH_OWN_BODY]++
	urtaLove(1);
	doNext(camp.returnToCampUseOneHour);
}

//Quote:[Drunken Urta Fucks Cock]
private function drunkUrtaRidesARutPCsCock():void {
	clearOutput();
	var x:int = player.biggestCockIndex();
	urta.urtaSprite();
	outputText("You decide not to fight the situation; truthfully, the promises given by the sight of the hot hermaphrodite vixen climbing on top of you ignite your lusts and sing to your rut in ways you don't think you'd be able to safely ignore.");

	outputText("\n\nUrta lifts her balls and presses your already hard cock against her black pussy lips, justifying your decision.  Slowly, you feel your tip sink into her, then the rest of your member, as she releases a soft moan.  She keeps pressing down, forcing your " + player.cockDescript(x) + " inside her wet gash until you feel her butt pressed against your ");
	if (player.balls > 0) outputText("[balls]");
	else outputText("[hips]");
	outputText(", and her own balls resting comfortably on your abdomen.  She grits her teeth as you feel her pussy slowly tighten around and massage your " + player.cockDescript(x) + ", and you groan in response.  Urta starts to bounce up and down on your member, smacking her thighs and ass into your body, not minding her own giant equine member flopping around and occasionally smacking you over your chest.  She lets her tongue flick out into the air for a moment and moans in delight, before picking up the pace and starting to pump your cock in and out of her hungry passage furiously.");

	outputText("\n\nIn your crazy breeding state, you're not able to contain yourself for long against the vixen's passionate lovemaking, and you ");
	if (player.balls > 0) outputText("feel your balls churning");
	else outputText("recognize the tingling sensation from your " + player.cockDescript(x) + " to your spine");
	outputText(", a telltale sign that your penis is ready to unload the potent spunk inside the herm-nympho bouncing on top of you.  You try to announce this, but she doesn't slow down.  Moments later, ");
	//[Normal cum production]
	if (player.cumQ() <= 50) outputText("you unload your thick spunk into her pussy");
	else if (player.cumQ() <= 250) outputText("you erupt inside her, filling her with wave after wave of warm, thick semen");
	else outputText("you blow massive surges of spunk inside her continuously.  The fox's stomach expands, rivulets of semen running down onto the table as she continues her ride on top of you");
	outputText(".  As you discharge, the fox's pussy starts squeezing and contracting, and you recognize the hermaphrodite's own orgasm.  Thicker white liquid suddenly drips from the tip of her cock quite copiously and occasionally shoots out into the air.");

	outputText("\n\n\"<i>Ahhhh, that was a good warmup.  Now, we just need to keep squeezing it out of you until you feel fine.  Maybe after that, I'll feel sated myself, for once...</i>\"");

	outputText("\n\nYour " + player.cockDescript(x) + " attempts to go soft inside of Urta, but the fox-woman's powerful inner muscles suddenly start rippling inside her, massaging your penis and forcing the rest of semen out of your urethra as she grinds her female parts against you.  Moments later, you're again fully erect, and Urta shakes her hips more and more energetically on top of you.  This time, she takes her own member in her hand and starts to rub it along the middle of its length, masturbating the male side of her hermhood while you're feeding yourself to her female parts.");

	outputText("\n\nUrta starts to slightly move her hips side to side, then up and down, alternating between movements and searching which ones seem to be more stimulating for which of you.  She continues to masturbate her now erect member, and allows you to run your hands over her body, squeezing her hips, ass, waist, and then breasts as she runs her other arm over your chest and nipples.");

	outputText("\n\n\"<i>Fuck, this feels so good.</i>\"");

	outputText("\n\nYou're inclined to agree, and the fox-box massaging the base and mid-length of your member assures that it will continue to feel that way.  ");
	if (player.hasKnot(x)) outputText("You slowly feel the blood flow to your erect penis, and the knot at the base of it seems to start to expand");
	else outputText("You don't mind staying like this for much, much longer, and the hermaphrodite on top of you seems to share that point of view");
	outputText(".  Summoning your slightly exhausted strength, you pull her hips down deeper into your own before starting to return the hermaphrodite's shakes and bounces with thrusts of your own.  It intensifies the sensations, making your lover yelp in surprise before smiling widely and releasing low, content moans and purrs from the depths of her throat.");

	outputText("\n\nShe continues to shake her hips and squeeze you without lifting her ass away from your body too much.  While you're able to last longer this time, it seems like fate that you will finally blow another load inside the vixen.  As she feels your ");
	if (player.hasKnot(x)) outputText("knot surge with more blood and your erection twitch, ensuring that you're completely trapped inside her until you're empty.");
	else outputText("tip expand as you're getting ready to blow another load.");
	outputText("  Urta moans on top of you, increasing the speed of her movements and running her hand up and down her own member faster and with more intense strokes.");

	//[Regular Urta]
	if (!urtaLove()) {
		outputText("\n\n<i>Now ain't I just the best fuck you ever had?</i>\"");
	}
	//[Lover Urta]
	else outputText("\n\n\"<i>Come on, lover, you know it'll feel better once you give me even more!</i>\"");
	outputText(" Urta masturbates furiously as your body and your " + player.cockDescript(x) + " finally gives in to your rut and the vixen's intense lust.  The two of you come in complete sync this time, her wet, black pussy milking you with vice-like tightness and intense, rhythmic squeezing as she fires a huge rope of jizz onto the floor next to your table before painting your chest and abdomen with lesser white strings.");

	//[If large cum production]
	if (player.cumQ() >= 500 && player.cumQ() <= 1500) outputText("\n\nUrta seems positively full and stretched now, and your rut almost subsides for a moment, her stretched tummy imitating a pregnancy quite well.");
	else if (player.cumQ() > 1500) {
		outputText("\n\nUrta is stretched and completely full, so, holding your " + player.cockDescript(x) + " in her hand for a moment, she lifts herself off your cock, presses on her abdomen and allows some of your spunk to drip out of her, coating the table, your thighs and your ");
		if (player.balls > 0) outputText("[balls]");
		else if (player.hasVagina() && player.clitLength >= 3.5) outputText("cock-like clit");
		else if (player.hasVagina()) outputText("pussy lips");
		else outputText("inside of your thighs");
		outputText(" with your own thick white semen.  Then, she slides your softening erection back into herself again.");
	}

	outputText("\n\n\"<i>Good... so good!  Just a few more rounds, and we'll be done - don't go fucking soft on me!</i>\"");

	outputText("\n\nYour " + player.cockDescript(x) + " feels sensitive and tender after the two past orgasms, but the horny nympho just forces it deep into her snatch, the sensitive head and shaft all the way down to your base again squeezed tighter as she starts to bounce up and down, trying to breathe life into your erection.  She kisses you furiously and passionately, exploring your mouth with her tongue as she keeps the stimulation on your groin, cooing, groaning and panting as if trying to breathe her own lust into you.");

	outputText("\n\n\"<i>Come on, come on, whatever it takes!  Squeeze those boobies, smack that ass, just get fucking hard!</i>\"");

	outputText("\n\nFollowing her plea, you give her breasts a rather rough squeeze, and you feel your " + player.cockDescript(x) + " miraculously harden inside her once again.");
	if (player.balls > 0) outputText("  Your [balls] don't seem to be completely empty yet");
	else outputText("  It doesn't appear to be the end of what your body can produce");
	outputText(", and your vulpine lover squeals with delight as she feels you harden inside her.  She smacks your [chest] with her huge, half-hard member.");

	outputText("\n\n\"<i>Care to give me a hand with that?  There's quite a lot of cream to squeeze out of this one, too.</i>\"");

	outputText("\n\nYour tired and lust-hazed mind sees no reason not to, and you grab her, so Urta's massive mare member starts to be pleasured by her own hand as well as yours.  Squealing in delight, the horny vixen returns to what seems to occupy her mind completely: bouncing fervently on top of you, with your " + player.cockDescript(x) + " trapped in her wet snatch.");

	outputText("\n\nThe stimulation is intense, your now far more sensitive member completely at the mercy of her inner muscles.  Urta doesn't seem tired at all, instead being even more ferocious and eager to share another set of mind-blowing orgasms with you, ramming her own hips against your [hips] while the back of her tail occasionally teases");
	if (!player.hasVagina() && player.balls == 0) outputText(" the inside of your thighs");
	else if (player.balls > 0) outputText(" your [balls]");
	else if (player.hasVagina()) outputText(" your [clit]");
	outputText(" when she's pressed entirely against you.  She smacks her own bottom and you run your other hand over her body as the two of you tug on and pull her massive erection towards your face and over your [chest], thick dollops of pre-cum and leftover semen dripping from her member over your body.  Urta licks her lips as she looks down on you with ");
	if (!urtaLove()) outputText("intense, unadultered lust");
	else outputText("possessiveness and a hungry, but somehow warm expression");
	outputText(".");

	outputText("\n\nI should make you do this every day!</i>\"");
	if (urtaLove()) outputText("  She suddenly seems a bit shy and surprised, before saying, \"<i>Make sure to remind me I said that later....</i>\"");
	
	outputText("\n\nWhile the increased lust and strong desire to breed you've received with your state make you able to keep going, you're way too drained and sensitive to actually keep responding to the vixen's wild movements with your own thrusts, although she seems intent to motivate you into doing so anyway.");

	outputText("\n\n\"<i>Come on, fuck me back!  ");
	if (!urtaLove()) outputText("Show me you're " + player.mf("the man","the breeder") + " here!");
	else outputText("You don't want to make me feel like I'm abusing you, do you?  I know you want this, so pound me!</i>\"");


	outputText("\n\nAfter a while, it becomes a torture to resist the stimulation and you try to bring your own orgasm faster by responding to Urta's movement, stretching your [hips] and pushing your " + player.cockDescript(x) + " deeper into her pussy.  Although the two of you have trouble catching a common rhythm, she appears way more vitalized and enthusiastic about this than you are.");

	outputText("\n\nAfter a long time of slightly too rough of a ride, your " + player.cockDescript(x) + " twitches inside the horny vixen again, and she almost howls in her own climax before yours is set off. Another shot of cum coats your [chest] as her hungry love-hole milks your member, forcing you to ejaculate for the third time, delivering even more semen into her insides.");
	if (player.cumQ() >= 500) outputText("  If the two of you were thinking rationally, you'd know quite well it could be quite dangerous to her innards to continue, but Urta seems intent on continuing this ordeal, or at least, that's how you feel when looking at her expression of bliss and ecstasy, eyes rolling to the back of her head and tongue dancing around in the air.");

	outputText("\n\nYou try to announce that you're done and that's about it, but the horny nymphomaniac that seems intent on keeping your rutting " + player.cockDescript(x) + " all to herself feels differently.  She allows your member to slide out of her for a moment, but only to let out some of the spunk that's filling her and to stimulate you in a different way.  Urta moves down your body, stroking your [chest] and your [nipples] before lowering her face and arms to your [hips].  She licks your sensitive head for a while before delivering a couple of noisy, strong sucks to your " + player.cockDescript(x) + ".  Afterwards, she licks your ");
	if (player.balls > 0) outputText("[balls]");
	else if (player.hasVagina()) outputText("[vagina] and [clit]");
	else outputText("taint");
	outputText(" before finally running her tongue over your [asshole], and all the way up again, swallowing your member once again as she squeezes your [butt].  You alternate before moaning, groaning, and whimpering as blood seems to leave your head and entire body, surging into your " + player.cockDescript(x) + " and making it hard to think or move, much less resist.");

	outputText("\n\n\"<i>We've already agreed that it's fine for me to take everything, so stop being so lazy!  I want to fuck more!  I'll keep fucking you until we break the table and dig a hole in the floor!");
	if (urtaLove()) outputText("  You can rest later!  I'll even give you a massage, so keep giving it to me!");
	outputText("</i>\"");

	outputText("\n\nOnce again, she moves her body on top of yours, dripping with her own semen and coating the place in your spunk in the process.");
	if (player.cumQ() <= 200) outputText("  The table already seems like it'll be stained white by Urta's efforts alone, and your own fluid doesn't help the situation.");
	else if (player.cumQ() < 1000) outputText("  The two of you are already fucking in a small pool of your mixed semen sauce, making naughty sounds heard all over the bar, and her vagina, dripping with your fluids, only makes the pool seem bigger.");
	else if (player.cumQ() >= 2000) outputText("  Your mixed sperm is covering the table and the floor, and woe to anyone who will have to clean this place up.  Despite the ridiculous amount of fluids around, she seems set on the idea that the two of you are barely mid-way through the act.");

	outputText("\n\nUrta slides your semi-erect phallus inside herself again as she steadies herself, her hand moving towards your [chest] for support.  \"<i>Come on, you can't knock up all the girls in the tavern with so little cum!");
	if (player.cumQ() >= 1000) outputText("  Well, maybe you can, but let's make some twins!");
	outputText("  Keep going!</i>\"");

	outputText("\n\nResponding to the idea of knocking people up as well as the sensation of Urta's warm, soft, very wet, dripping and very filled insides, your member struggles to get back to life, slowly hardening inside the hermaphrodite yet again.  You groan beneath her, the tiredness and tenderness of your body unwilling to put up with this, yet unable to summon the strength or even the desire to resist.  Urta just giggles in response, pleased at your body's reaction, before pulling the tip of her cock as close to your face as possible.");

	outputText("\n\n\"<i>Lick.  I've sucked yours, so it's only fair.  Let's keep spurting jizz all over the place, drown it in semen.  Wait... no, you should just pump it into me and keep as much inside as possible.</i>\"");

	//[If the PC is 4' 5'' feet tall or less] 
	if (player.tallness <= 53) outputText("\n\nYou don't even have to bend down to start licking and slurping at the tip of her dick.");
	else if (player.tallness <= 65) outputText("\n\nBy maneuvering your neck alone, you're easily able to press your lips against the tip of her erection.");
	//[If the PC is between 5' 6'' and 6' 5'' feet tall]
	else if (player.tallness <= 78) outputText("\n\nYou easily bend down to caress Urta's cock with your tongue, returning the pleasure.");
	//[If the PC is between 6' 6'' and 7' 9'' tall]
	else if (player.tallness <= 93) outputText("\n\nUrta has to bend backwards a bit and you have to stretch your back a bit painfully to access her erection, but you manage to start caressing her tip with your tongue.");
	else outputText("\n\nNo matter how hard you tried, you wouldn't be able to return the favor in this position.  Your body is just too tall.");

	outputText("\n\nUrta bounces wildly on top of you, her muscles squeezing and releasing, massaging your " + player.cockDescript(x) + ".  Even coated through and through with your cum and stretched from the fucking, the muscles of her vaginal passage provide a tight, warm, exquisite sensation, and the dirtiness of the deed only seems to further turn you on - as do the dirty, jealous looks of females and some herms that are surrounding you, apparently hoping for a round with either you or Urta.  No, it might've been true before.  They're fully aware that the two of your seem exclusively focused on each other and that your mating will continue for a while if the hermaphrodite fox-morph has her way.");

	outputText("\n\n\"<i>Keep away, dumb sluts!  This one's mine!</i>\"  She grabs your face in her hands, stroking your cheeks and pulling you lower towards her erection, ");
	if (player.tallness <= 93) outputText("making you lick, kiss and suck on her flared, wide tip");
	else outputText("staring deep into your eyes as her erection smacks you against your [chest]");
	outputText(".");
	if (!urtaLove()) outputText("  She grins at your lack of resistance.");
	else outputText("  \"<i>You're mine, right?  Right now, you're mine and mine alone.  My wonderful virile breeder, all " + player.mf("his","her") + " seed just for me.</i>\"");

	outputText("\n\nThe surrounding feminine figures groan in surrender and frustration, but some start masturbating, only serving to make your member harden and twitch inside Urta's welcoming passage.  She seems to think it was her efforts that lead to this, and moans in delight.");

	outputText("\n\n\"<i>Yes!  Fuck, Marae, this is just superb!  We'll keep fucking like this until we're totally empty!");
	if (urtaLove()) outputText("  Just a few more loads, okay?  You don't mind, lover?  I'm practically addicted, so let me just fucking overdose!");
	outputText("</i>\"");

	outputText("\n\nYou pant and moan as your " + player.cockDescript(x) + " moves through her passage and into her warm body, your tip aimed at her womb, now full of your sperm and fated to get more soon.  Your vulpine lover just keeps calling your name while bouncing on top of you, moaning, groaning, shouting in delight and howling in rapture, muting the sounds of sloshing and smacking from your joined genitals and the weaker moans from the surroundings.  Apparently the Wet Bitch has delved into a growing orgy of singles masturbating or searching for partners while couples or threesomes shred each other's clothes and start to fuck on the spot.");

	outputText("\n\nThe mare penis in front of your face suddenly twitches as it releases a thick rope of cum onto your tongue and lips, covering your face, shooting over your hair and your forehead and generally making you a mess.  Urta's cry of ecstasy seems stuck in her throat, but her twitching body, tightly hugging, pulsing insides, suddenly grip strongly on your shoulders and load after load of thick cream released in the general vicinity of your face seem like a good enough indication that she climaxed again.  You feel your own orgasm approaching and Urta seems completely intent on giving it to you, her tight breeding hole tugging on your rut-driven erection");
	if (player.balls > 0) outputText(", your [balls] frantically gathering any cum that is left in them to prepare for another surge of shots into the hermaphrodite's eager nethers");
	outputText(".  You seem to slowly lose the sensations in most of your body.  The awareness of your surroundings slips away, as all your thoughts and feelings focus in your groin, struggling to keep up with the mad pace of breeding that Urta has kept so far.  It's hard to keep conscious as you feel another surge of ecstasy pass all over your body and focus on your " + player.cockDescript(x) + ", shooting off yet again inside her coaxing hole.  You hear the sound of your name being called and the milking, squeezing sensations that you barely manage to associate with her ravenous, insatiable pussy.");

	outputText("\n\nThe sex-crazed fox keeps going, and your equally mad penis seems intent to keep erect inside her.");

	outputText("\n\nYour mind is incapable of tracking what happened later.  You were pretty tired and nearly empty, but you managed another orgasm or two with the hermaphrodite riding on your erection.  You can't really remember how many orgasms she had in the meantime, or what happened afterwards.  How did you leave the Wet Bitch and how did you end up with a somehow familiar roof over your head, with furs under your back and without the all-encompassing scents of sex and jizz in the air?");

	outputText("\n\n\"<i>[name], it appears we can't be trusted around each other if I've had a few drinks and you're in such a ready state.  It was enjoyable while it lasted, but... well, let's say the Wet Bitch may smell for a while, my reputation may be worse than it was in the past, and, ummm, I don't think my girly parts will be ready for more action in a while.  You feel fine, I hope?</i>\"");

	outputText("\n\nYou respond that you're a little sore and hurt, but at least now you've got a grip on your sex drive.  You explain, however, that you're not completely sure how your rut will ultimately react to this kind of sex marathon.");

	outputText("\n\n\"<i>I see.  I hope this brings you more than temporary relief.</i>\"");

	outputText("\n\nShe winces in pain, but seems in relatively high spirits.");

	outputText("\n\nI didn't know I could be so aggressive while using my female parts.  I guess I've made myself worthy of the name of my favorite tavern. I apologize for-</i>\"");

	outputText("\n\nYou stop Urta, saying you're just as much to blame as she is.  ");
	//If Corruption>35, or Exhibitionist
	if (player.cor > 35 || flags[kFLAGS.PC_FETISH] > 0) outputText("You tell her it was actually a great experience to have such passionate sex publicly.  She blushes at that suggestion.");

	//[If Urta is infertile]
	if (!urtaQuestDone()) 
	{
		outputText("\n\n\"<i>Well, I guess it was nice, if painful afterwards, to be of use to someone who was so ready and willing to breed.");
		if (urtaLove()) outputText("  If only I could... uh, I guess I should just enjoy what I can.");
		outputText("</i>\"");
	}
	//[If Urta is fertile]
	else {
		outputText("\n\nYou realize that Urta went ahead and forced many orgasms out of you and inside herself without as much as a hint of protection.  Worried that neither of you was in a clear state of mind at the time, you ask her about this.");
		if (flags[kFLAGS.URTA_FERTILE] != 1) outputText("\n\n\"<i>Don't worry love, I'm on enough contraceptives that we shouldn't have to worry,</i>\" Urta admits.");
		else outputText("\n\n\"<i>We did, didn't we?  It would be nice, wouldn't it?  If every time you got in a rutting mood you could just drill another baby into me...  I really wanted it, [name]!  I love you!</i>\"");
		outputText("\n\nYou nod and tell her you understand.");
		urta.knockUpUrtaChance();
		urta.knockUpUrtaChance();
		urta.knockUpUrtaChance();
	}
	outputText("\n\nShe ");
	if (!urtaLove()) outputText("winks at you as you get ready to leave.  I hope I'll get to play with you again soon.</i>\"");
	else {
		outputText("gives you a quick but loving kiss before getting up and starting to prepare to leave the house.  As you get ready to move, she mumbles something, and reaches, grabbing your arm, shyly.\n\n\"<i>[name], next time, umm: find me when I'm sober.  I'll get to see how it feels to be wanted by someone the way I usually crave you, okay?</i>\"");

		outputText("\n\nYou " + player.mf("chuckle","giggle") + " and she punches your shoulder playfully, but keeps her face from blushing more.  She seems pleased that she brought herself to that declaration.");
	}
	//[Both end here]
	outputText("\n\nSatisfied even if your body hurts all over and your " + player.cockDescript(x) + " seems empty, dry, burning, and almost ruptured.  You leave the house with a small smile on your face, and a strong stench of sexual fluids following you back to the camp.");

	//player returns to camp and loses 4 hours//
	dynStats("lib",2,"sen-",10,"lust=",0);
	player.orgasm();
	player.orgasm();
	player.orgasm();
	player.orgasm();
	player.orgasm();
	player.orgasm();
	flags[kFLAGS.URTA_COMFORTABLE_WITH_OWN_BODY]++
	urtaLove(1);
	flags[kFLAGS.TIMES_RUT_FUCKED_URTAS_CUNT]++;
	flags[kFLAGS.URTA_TIME_SINCE_LAST_CAME] += 24;
	doNext(camp.returnToCampUseFourHours);
}


/*
End/intensify heat/rut message:
Quote:Extinguish: As you walk away, you realize that your (heat/rut) has cooled; evidently, mating with Urta let you trick your body, so now it isn't crazed to breed. [Heat/Rut ends]

Intensify: As you walk away, you groan as you realize that you feel hornier than ever. It looks like trying to trick your body by mating with (a sterile herm/a herm who uses contraceptives afterwards) wasn't a good idea - it's only made things worse. [Heat/Rut intensifies]

*/

//Drunken Urta Variants 
//Quote:Drunken Urta always affects heat/rut when penetration is involved (meaning she doesn't in her frottage scene and watch-her-masturbate scene), and has a 50% chance to either extinguish it or intensify it.
//When penetration is involved, sex with Drunken Urta while in Heat/Rut increases both Toughness and Libido by 2 points and lowers Sensitivity by 4 points. Player often loses more than 1 hour and has to return to camp, rather than stay in TelâAdre. When getting penetrated, Urta's vaginal capacity is bumped up to 72.
}
}
