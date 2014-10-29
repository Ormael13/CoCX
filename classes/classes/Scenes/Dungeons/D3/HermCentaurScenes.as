package classes.Scenes.Dungeons.D3 
{
	import classes.BaseContent;
	/**
	 * ...
	 * @author Gedan
	 */
	public class HermCentaurScenes extends BaseContent
	{
		
		public function HermCentaurScenes() 
		{
			
		}
		
		public function encounterThePony():void
		{
			outputText("\n\nA gigantic, demonic centaur is here!  She grins down at your sudden arrival and gestures at the mammoth dong between her thighs as she taunts, \"<i>You are not prepared.</i>\"");
			
			if (player.vaginalCapacity() < 100 || player.analCapacity() < 100) outputText("\n\nNot prepared to take that beast perhaps, but certainly prepared to take this over-grown abomination down!");
			else outputText("\n\nNope!  You could probably handle her elephantine she-cock, but you've no plans on losing this fight!");
			
			menu();
			addButton(0, "Fight", startCombat, new HermCentaur());
		}
		
		public function beatThePony(hpVictory:Boolean):void
		{
			
		}
		
		public function inSovietCoCPonyRidesYou(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (player.hasCock())
			{
				maleLoss();
			}
			else
			{
				femLoss();
			}
		}
		
		private function femLoss(hpVictory:Boolean):void
		{
			clearOutput();
			outputText("Dropping down, you");
			if (hpVictory) outputText(" try to pull yourself up with on your palms, utterly defeated in spite of the centaur's complete lack of physical attacks.");
			else 
			{
				outputText("put your rump up in the air, fully exposing your");
				if (player.hasVagina()) outputText(" [vagina]");
				else outputText("self");
				if (player.hasCock()) 
				{
					outputText(" and");
					if (player.balls > 0) outputText(" [sack]");
					else outputText(" " + multiCockDescriptLight());
				}
				outputText(" to the pervy, sexy equine.");
			}
			outputText(" She smirks as she trots up, commenting, \"<i>That's more like it, slut.  I don't know how you got this far, but your quest ends here.</i>\"  She casually reaches down and grabs you by the scruff of the neck, hauling you bodily up until your head nestles between her tits");
			if (player.tallness >= 7 * 12) outputText(", even though your [feet] still touch the ground");
			outputText(".  Brushing through your hair, a hand gently caresses your back as its owner coos, \"<i>You'll make a fine mare for my stable, but lets get you in the right mindset first...</i>\"");
			
			outputText("\n\nYou're shifted to the side, your face dragged along the side of a pale, freckled breast as you're moved into position.  A thick nipple, almost as wide as your finger, pushes at your lips, smelling faintly of sugary sweetness and sex all blended together.  When you don't gratefully accept it, your jaw is forced open and the nearly inch-long is firmly inserted.  As soon as it's seated in your maw, the hard milk-nozzle immediately begins to leak it's tasty treat - a sweet fluid that seems to fizz on your tongue and light your mouth up with pleasure.  You savor the taste as long as you can, but pleasure-inducing juice soon has your cheeks bulging.  You gulp it down reluctantly, if only to make room for more.");
			
			outputText("\n\nYour eyes open wide when the delicious demon-milk hits your stomach.  It fills your core with such warmth that you think you might melt, at least until the heat begins to diffuse outward, bringing with it a tingling sensitivity that makes the tit in your mouth taste that much better.  You draw deeply on the rosy, pink nipple, sucking down even more 'milk' with every passing second, if only to kindle even more of that pleasant sensation.  The hands release you, but you stay firmly attached to your teat.  You need more.");
			
			outputText("\n\nThat burgeoning heat that's soothing away your worries builds hotter and higher with every swallow, but it isn't until the lactation slows to a trickle that you notice something else - it's gathering in your groin.");
			
			if (!player.hasVagina())
			{
				outputText(" The pleasant warmth builds with alarming speed, the diffused sensation pooling toward a focused point in your crotch. The heat seems to tunnel deeper into your core before returning to the surface, and with each iteration, the pulsating, almost liquid sensation feels hotter. The warmth quickly makes way to raw, unadulterated heat, which in turn rapidly transforms into a deeply rooted, scalding fire- but it takes on a subtly different tone; a different kind of heat. It’s only when the first traces of wetness begins to roll down the inside of your thigh that you put all the pieces together. <b>The centaurs milk has rooted a cunt into your previously genitalia-void crotch.</b>");
				player.createVagina();
				outputText("\n\n");
			}
			else outputText(" ");
			
			outputText("Your [vagina] is so puffy and inflamed with passion that it feels ready to burst out of your [armor], even as the drooling fem-cum makes it squish wetly with your every motion.");
			if (player.hasCock()) outputText(" [EachCock] fares little better, a turgid mess of pre-cum leaking lust that seems to grow harder and more sensitive by the moment.");
			outputText(" That wonderful warmth excites you sexually, a deepening puddle of lust in your loins that makes you so hot and wet that you swear it must be what's dripping out onto the cobble below.");
			
			outputText("\n\nYou're moved to the other side, with a fresh, juicy nipple for you to nuzzle.  You do so without thought, effortlessly clasping your lips in a tight seal around the heavenly nub and suckling, even as you rest your cheek against the pale, freckled skin of the melon-sized tit.  The fluid begins to flow almost effortlessly, flooding out in response to the barest hint of suction from your hungry mouth.  Bubbling, almost boiling over, your lust mounts to higher and higher levels, your loins seeming to simmer with molten desire to be bred.  In response, you begin peeling away your [armor].  You know this delicious milk will be gone soon, and when you finish, you want to be mounted, hard.");
			
			outputText("\n\nWith your [vagina]");
			if (player.hasCock()) outputText(" and " + multiCockDescriptLight());
			outputText(" freed, your hands unabashedly dive into your folds, spreading them as wide as possible, heedless to the discomfort.  You drink and stretch, swallow and tug.  Over and over, you give into the artificial, hedonistic desires your dual - endowed mistress's milk instills in you.  There's no fighting it, only giving in utterly as you prepare yourself to be filled, speared upon your mistress's mighty member and filled with her hot cum until your body turns into a quivering, orgasmic wreck.");
			
			outputText("\n\nThe tainted centaur pulls you back even as your lips stretch forward in desperation, but at last, you pop off the nipple, disappointed.  She tilts your head to look up at her green eyes and glittering, black horn.  She's a terrible demon, a beautiful maiden, and a monstrously large, giant-like centaur, all at once.  You pant, whining with your exhalations until she gently releases you.  Flopping down nervelessly, you catch yourself before you smack off the hard stone.  You rise up again, ready to fuck, only to come up into a face full of slime-lubed horse-cunt.");

			outputText("\n\nThe warm, rubbery lips squish down wetly as your nose slips between them, nestled deeply into that moist, bestial crevasse.  Runnels of slick fluid soak the whole of your " + player.face() + " and drip from your chin in thick ribbons.  At first, this shocks you, but as soon as you realize what's going on, you do as expected an open up to taste her wetness.  She's hot, practically steaming, and her hard nub is a deliciously wet, throbbing target for your questing tongue to squeeze up to.  You lash your mouth-muscle across the sensitive buzzer, orally spanking it while you wiggle your face and lips to caress the sensitive entrance.  Just as you finally start to get into the, the giant, hot hole pulls away, joined to you only by glimmering bands of lady-spunk that soon snap.");

			outputText("\n\nTurning around, the demoness gives you a knowing smile even as she deigns to caress your woman-soaked visage with surprisingly gentle fingers.  She commands, \"<i>Present yourself, my sweet little filly.</i>\"  You do so without question, shaking like a leaf in the wind with anticipation.  By now, your copious drippings have turned your quivering [legs] in a glossy mess, soaked in liquid, feminine arousal that only entices your mistress to clop closer as you lift your [butt] high and make your [vagina] ready to be taken.  You grab hold of nearby stones with trembling fingers and fearfully look back over your shoulder as the nine-foot equine monstrosity's shadow looms closer.");

			if (player.isPregnant) outputText("\n\nA tingle runs through your belly as something changes, and a powerful voice smirks, \"<i>One of my other mares will finish bearing that runt for you.  Now, that fertile womb belongs to ME.</i>\"  You... you're no longer pregnant!");

			outputText("\n\nShaggy, fur-shrouded hooves stamp down to either side of your hands.  You can see the powerful muscles that drive her massive body above you, shifting beautifully under her fur-clad skin while she positions herself properly.  Her scent, still clinging to your nose and mouth and characteristic stubbornness, only grows stronger in her direct presence, mixed with a salty, masculine musk that radiates from the throbbing shaft above and behind.  Drops of her liquid desire spatter off your [butt], fairly sizzling with the heat of her need, and you feed the flared head tip lower to smear the white goop across your crack and down your lips.  You shake and nearly fall from the avalanche of pleasure, but somehow, you hold your pussy up, craving the cream filling it's so eager for.");

			outputText("\n\n\"<i>Hold... still,</i>\" the demon grumbles as she fidgets, steel-shod feet cracking noisily against the pave-stones.  Her flat tip batters up against a different part of your anatomy with near bruising force every time she tries to hit your target, but she's as awkward as the beasts her lower body resembles.  You nearly scream in surprise when she smashes it into your [asshole], but thankfully, the heavy head is withdrawn, searching for more fertile pastures.  Again, she tries to spear your pussy, but misses, sliding beneath and glossing your [clit] with a heavy coating of horse-slime.");

			outputText("\n\nA hand reaches down to grab your " + hairDescript() + " and pull back sharply.  \"<i>Stay... put...</i>\" its owner pants.  You have been staying put!  At least, when you haven't been shaking with barely-contained need.  The angle is somewhat painful, flexing your spine into a dangerous arch even as the force of her tug shoots needles of discomfort into your abused crown.  Then, the horse-like lower body steps forward, and you're seeing stars and smiling dopily. The flared head smashed into your semi-stretched pussy for only the briefest moment before its body's momentum carried it through your entrance and deep into your canal.  Even now, you can feel the medial ring thrumming with each beat of the centaur's heart, just inside your entrance while the fat tip butts up against your cervix.");
			player.cuntChange(monster.biggestCockArea(), true, true, false);

			outputText("\n\nYou sag into the welcoming penetration, pushing back against the intruding maleness in a drug-fueled stupor.  Only after a few moments of fervent grinding do you realize that you truly want to push that beast the whole way into your womb - to feel it sliding wholly and completely inside you.  \"<i>Greedy little mare, aren't you</i>\" the confident centaur herm asks as she begins to rock with you, the soft flare stretching wider to scrape along every sensitive nerve of your interior with surprising tenderness.  She lets go of your hair, and you meekly look up and nod, pushing your body back hard with each thrust.");

			outputText("\n\nThe demon's horn casts a black shadow on the cobbles before you.  You curiously watch it bob with every slow drag out and inhumanly powerful thrust back in.  Each hip-jarring penetration bears pleasant fruits, in the form of heavy globs of precum that squish through your cervix and into your womb.  Small spurts of it splatter out of your well-stretched cunt as the thick cock fills every available crevice of your canal, mixed in with the clear dribbles of your own need.  By now you've begun to moan like a whore in heat, rutting with this demonic beast as hard as your body will allow, yet it still will not gratefully accept the beast's crown - you're just to small!");

			outputText("\n\nSmirking, the demoness asks, \"<i>Not happy only getting half of my cock in there, are you, slut?  Lets make that troublesome cervix a bit more accepting, shall we?</i>\"  She pushes in until her tip is smashed flat on your womb's entrance once again, but this time, she holds still.  Soft murmurs echo down from above, incoherent to your unpracticed ears but undeniably magic.  The constant trickles of demon-spooge of thicken, flowing hot and hard enough to baste your innards with, and as soon as she finishes her chanting, you 'bloom' internally, for lack of a better word.  It's almost as if your entire reproductive system is relaxing, opening gratefully to allow your mistress to more properly ravish you.  Of course, she does.");

			outputText("\n\nThat hot horsecock is rammed into you, until you feel the folded skin of her sheath on your lips and the heavy weight of her squirming tests bouncing off your [butt].   The proud shape of her flare is clearly visible on your stretched-out tummy, but it doesn't hurt.  All you feel is glorious fullness and the ache of so much pleasure that you fear you'll cum and pass out, all at the same time.  The delicious thickness inside you bubbles and grows, thickening with each beat of the demon's heart, and you realize she's as close as you, perhaps closer.  Timidly, you caress her thick flare through your taut skin, garnering a spurt of hot pre and a matched moan of contentment from your gargantuan lover.");

			outputText("\n\n\"<i>I think I might have a new favorite mare</i>,\" the demoness pants while gleefully pounding your over-stuffed snatch, \"<i>We just met and you've already accepted your role.  I hope you don't mind birthing dozens of imps for my personal army and helping us research more proper reproduction.</i>\"  She's going to fuck you more?  You gleefully moan out an affirmative, and she rewards you by pounding your box harder, stuffing it full of her thick, hot member, all the way to the top of your hungry, pre-stuffed womb.");

			outputText("\n\nYou wriggle and wail, feeling the mounting pleasure growing into an unstoppable wave of bliss, bolstered by the fevered thrusts of your horny mistress.  She moans with you and bottoms out, her pussy spraying behind her while her soaked balls slap into you with brutal force, quivering once and then suddenly shrinking.  Her flare distends your poor body further, and then a thick wave of jizm is pouring out into your uterus, filling every empty cavity with demonic virility.  Your body seizes, then goes limp, all except for you the ripples of contractions churning through your [vagina] as it milks every drop from your demonic lover.  The next jizz-bomb bloats your abdomen to purely pregnant proportions and as you scream in absolute rapture, the pressure slowly forces you off, leaving you to lie in a pile of sperm while it fountains from your abused twat.");

			outputText("\n\nDarkness takes you while you shiver in knocked-up bliss.");

			menu();
			goNext(femLossII);
		}

		private function femLossII():void
		{
			clearOutput();
			outputText("Later, you wake when something hard digs into your back, and as you crack your eyes open, the first thing you see is a set of equine hindquarters and prodigiously large testes.  Your next realization is that you're moving... not just moving, being dragged!  You glance downward and see that you're joined with the centauress once again, only this time, you can't see any distortion in your middle.  Your belly is stuffed so full of cum that you can't see the fleshy spear, but you can certainly feel it.  It's different now... narrower at the tip, but obscenely bloated at the base.  Even now, you can feel it stretching you to your limits to make a tight seal and slowly leaking a fresh river of jism to assault your ovaries.");

			outputText("\n\nThe demon has you knotted on a giant dog-cock!  When did she get one of those!?  You gasp in surprise, pain, and pleasure in equal measure.  She hears you and looks over her shoulder, still slowly walking, and she smiles as she says, \"<i>Welcome back.  I'm just taking you to your stall and making sure my devilish little children get a proper foothold in your womb.  Relax and enjoy - we'll get you fixed up once you're secured in your stall.</i>\"");

			outputText("\n\nYou slump down as you're dragged through dirt, over carpets, and through halls.  Various demons leer at you as you pass, snickering at the fallen champion, now little more than a willing mare.  The humiliation makes your cheeks go red but your [vagina] drool. Some part of you is clearly enjoying it, though you aren't sure if it's a natural enjoyment or something this creature has done to you.  You sigh and shrug, raising your hands to fondle your breasts as you're dragged to your new home.  You may as well enjoy yourself.");

			menu();
			goNext(femLossIII);
		}

		private function femLossIII():void
		{
			clearOutput();
			outputText("<b>Months later...</b>");

			outputText("\n\nYou sigh as your latest litter of imps clamor around your nipples, hungry for their mother's milk.  They're such greedy, ceaselessly ravenous creatures.  Having their clutching mouths on your nipples all the time makes it so hard to sleep, and it doesn't help that the 'father' insists on rutting with you and knotting you for hours until she's 'sure' your pregnant.");

			outputText("\n\nThe rest of your days are lived out like that, interrupted only for fresh injections of demonic chemicals and thick centaur-cum.  Amazingly, the demon's experiments bear fruit, and you have the honor of birthing the first true demon offspring - the first of many.  Though you're eventually traded to a new owner once you're well used and other sluts have been similar prepared, you keep a sense of a perverse pride through it all.  You were the first demon mother.  You helped the new species propagate and assure their dominance over lesser forms of life, like yourself.");

			outputText("\n\n<b>GAME OVER</b>");

			menu();
			goNext(9999);
		}
		
		private function maleLoss(hpVictory:Boolean):void
		{
			clearOutput();

			var y:int = player.cockThatFits(monster.vaginalCapacity());

			if (y <= 0) player.smallestCockIndex();

			outputText("Dropping down, you");
			if (hpVictory)
			{
				outputText(" try to pull yourself up with on your palms, utterly defeated in spite of the centaur's complete lack of physical attacks.");
			}
			else
			{
				outputText(" try to pull [oneCock] out of your [armor] in an attempt to masturbate.  You're beaten, you just want to fuck or be fucked until you're both covered in a sheen of lady-spunk or your own thick cum.");
			}
			outputText(" She smirks as she trots up, commenting, \"<i>That's more like it, slut.  I don't know how you got so far thinking you were some kind of " + player.mf("stud","queen bitch") + ".</i>\"  She casually reaches down and grabs you by the scruff of the neck, hauling you bodily up until your head nestles between her tits");
			if (player.tallness >= 7 * 12) outputText(", even though your [feet] still touch the ground");
			outputText(".  Brushing through your hair, a hand gently caresses your back as its owner coos, \"<i>I'm not sure you have what it takes to be one of my stallions...</i>\"");

			outputText("\n\nYou're shifted to the side, your face dragged along the side of a pale, freckled breast as you're moved into position.  A thick nipple, almost as wide as your finger, pushes at your lips, smelling faintly of sugary sweetness and sex all blended together.  When you don't gratefully accept it, your jaw is forced open and the nearly inch-long teat is firmly inserted.  As soon as it's seated in your maw, the hard milk-nozzle immediately begins to leak it's tasty treat - a sweet fluid that seems to fizz on your tongue and light your mouth up with pleasure.  You savor the taste as long as you can, but pleasure-inducing juice soon has your cheeks bulging.  You gulp it down reluctantly, if only to make room for more.");

			outputText("\n\nYour eyes open wide when the delicious demon-milk hits your stomach.  It fills your core with such warmth that you think you might melt, at least until the heat begins to diffuse outward, bringing with it a tingling sensitivity that makes the tit in your mouth taste that much better.  You draw deeply on the rosy, pink nipple, sucking down even more 'milk' with every passing second, if only to kindle even more of that pleasant sensation.  The hands release you, but you stay firmly attached to your teat.  You need more.");

			outputText("\n\n\"<i>Ahh, you can be taught,</i>\" your captor sighs.");

			outputText("\n\nThat burgeoning heat that's soothing away your worries builds hotter and higher with every swallow, but it isn't until the lactation slows to a trickle that you notice something else - the warmth is gathering in your groin.  [EachCock] is so hard, so throbbingly turgid, that it presses painfully at your [armor], dribbling so much pre-cum that feel it'll start to run down your [legs] any second now.");
			if (player.hasVagina()) outputText(" Your [vagina] fares no better, puffing up and drooling like its big brother while your [clit] grows taut and sensitive.");
			outputText(" That wonderful warmth excites you sexually, moulding your loins into a simmering blaze of desire just looking for a something to cool its ache.");

			outputText("\n\nYou're moved to the other side, with a fresh, juicy nipple for you to nuzzle.  You do so without thought, effortlessly clasping your lips in a tight seal around the heavenly nub and suckling, even as you rest your cheek against the pale, freckled skin of the melon-sized tit.  The fluid begins to flow almost effortlessly, flooding out in response to the barest hint of suction from your hungry mouth.  Bubbling, almost boiling over, your lust mounts to higher and higher levels, your loins seeming to simmer with molten desire to breed.  In response, you begin peeling away your [armor].  You know this delicious milk will be gone soon, and when you finish, you'll need to mount something... hard.");

			outputText("\n\nWith your hands and body freed, you unabashedly dive down in an instant to get at your needy hardness.  You drink and squeeze, swallow and stroke.  Over and over, you give in to the artificial, hedonistic desires your dual-endowed mistress's milk instills in you.  There's no fighting it, only giving in utterly as you prepare yourself to be used as a sperm-pump, ridden mercilessly until you spew your molten lust into her fertile nethers, a helpless stud only alive to knock her up over and over again.");

			outputText("\n\nThe tainted centaur pulls you back even as your lips stretch forward in desperation, but at last, you pop off the nipple, disappointed.  She tilts your head to look up at her green eyes and glittering, black horn.  She's a terrible demon, a beautiful maiden, and a monstrously large, giant-like centaur, all at once.  You pant, whining with your exhalations until she gently releases you.  Dropping nervelessly in the grass, you twist and writhe, trying to rise and jerk off all at once.  Of course it fails, and by the time you get your hands down to push up, a shadow falls across your view.");

			outputText("\n\nThe equine half of your oppressor is directly above you, dripping strands of thick, female cum onto your face while her hard cock rains its pre-jizz over [eachCock] in a show of supreme dominance.  Still, you try to rise - perhaps due to foolish pride, desire, or just sheer instinct.  The centaur drops down before you get a few inches up, smashing her cunny into your face and bearing you to the ground.  Her weight is immense, and though some is kept on her forelegs and little spread to the haunches on either side of your face, you still get buried nose-deep in sloppy, black-lipped snatch.");

			outputText("\n\nThick balls settle over your neck, and you can feel the shaft of her gigantic horse-dong stretching across your [chest] towards your waist, pulsing fitfully.  With her heavy, furred body in the way, you can't get to your own loins.  Hell, you can barely breathe, and what little breath you do suck in is so filled with pheromones that your");
			if (player.balls > 0) outputText(" [balls] feel fit to burst!");
			else outputText(" manhood feels swollen to bursting!");
			outputText("  Realizing the only way out will be with your tongue, you open wide");
			if (player.tongueType != TONGUE_TYPE_HUMAN) outputText(" and uncoil your inhuman length to spear");
			else outputText(" and begin to lap");
			outputText(" at her inhuman entrance.  She whinnies in delight, grinding her clydesdale-sized bulk back and forth on your face as you start to get into her eating her out.");

			outputText("\n\nMoisture drizzles down your cheeks as her already-swollen vulva gets fatter with need.  Her fluids seem to be coming faster and faster, and you have to swallow some of them just to keep from drowning.  Surprisingly, it has a remarkably mild, palatable flavor.  If anything, she tastes slightly sweet, which isn't quite what you would have expected from her potent scent alone.  As turned on as you are, it doesn't take long for you to forget your dire straight and focus on tending to the inhuman woman's needs, licking, slurping, and sucking at her clit with gusto.  She's soon trembling and gushing across your " + player.face() + ", matting your hair with a final, explosive burst of fem-spunk.");

			outputText("\n\nAt last, your moist, feminine prison is removed.  Rather than lifted, it's simply dragged south.  [OneCock] nearly catches on her fleshy sack, but it bounces up and over, stroking you with the smooth, sweaty skin as it asses south.  The motion is made all the more awkward by the sight of the centaur's hind legs trying to assist her locomotion, but soon enough she's just on your [legs], the heat of her gash steaming [eachCock] with drizzles of fem-lube. The demoness looks over her shoulder, pale cheeks stained pink with her body's lust as she asks, \"Are you " + player.mf("man","herm") + " enough to mount me?  Or do I need to peg you for encouragement?</i>\" ");

			outputText("\n\nThat gets you to sit up quick.  You aren't sure anyone could take something like that without rupturing something.  Besides, you'd be jumping that twat in a heartbeat as worked up as you are, thread or no.  You stretch forward and aim your [cock " + y + "] into her slobbering twat.  Her fur twists between your fingers as you drag yourself up and in, pulling your torso up onto her back and with such desperation that you nestle deeper inside her, your [legs] partially escaping their weighty imprisonment.  It's an agonizing position to be in, but you will NOT be denied access to the slick caresses of her gushing slit.");

			outputText("\n\nThe pressure on your lower body vanishes, your [feet] raking through the grass before clearing it entirely.  The demon-taur stood up, taking you with her!  You stretch your hands forward for a better grip, securing yourself just in time for her to give a little buck, bouncing you out and in with inertia alone.  Shuddering, you nearly lose your grip as pleasure wracks your body.  Your [cock " + y + "] is getting exactly what it wants, but you're having to work damned hard to maintain your position.");

			outputText("\n\nThe buxom redhead snickers, \"<i>If you can't even stay in my pussy, you're worthless as a mate.  I guess I could use you as a cock-sleeve, but after a few fucks I'd  probably just toss you out.  I don't like my toys once they start to gape, and they start to gape fast.</i>\"  Her balls jiggle against your [legs] as if to emphasize her point.  You whine but wordlessly cling tight.  Her pussy is divine, and your drooling, dribbling dick won't give it up without a fight!  You throb inside her passage, the muscular tunnel rippling and squeezing with every movement she makes.");

			outputText("\n\nLooking back, the demon gives you a knowing smile, while her horn seems to drink the very light around her.  Abruptly, she begins to trot down the path towards an archway.  You hang on, fucking her to the rhythm of her movements.  It isn't even through your own volition that you get to pound at her pussy - her movements utterly control the tempo of the fuck.  Your only choices are whether to hold on and fuck her or let go and be her anal cocksleeve.  With all the aphrodisiacs she fed you, your dick isn't even giving you that choice.");

			outputText("\n\nIn light of your hapless situation, you cling tight and watch as you're given a rampant, dick-squeezingly tight tour of the demons' headquarters. You're taken past masturbating succubi, fapping incubi, and even snickering imps.  All manner of demons sneer at you, the once champion, now a slave to a centaurs sodden snatch.  The sheer, debauched exhibition of it sends a spike of pleasure to your [balls], the upwelling of desire burning with wet heat that seems to dwarf the roaring furnace that is the demon's thighs.  Your burgeoning orgasmic sensation is brought to a screeching halt along with your mistress when she comes to an abrupt stop.");

			outputText("\n\nThen, someone else joins you on the centaur's back - it's an omnibus{, and a familiar one at that}.  She wears a black reflective bra, though you swear you can see pink protrusions under the shiny fabric, wriggling around constantly.  As expected with such dress, her nipples are hard as bullets.  A bulbous, ten-inch penis bobs between her thighs, thickening nicely as it fills to its full size, kissing your lips with a moist bead of pre as it fully erects.  The omnibus {overseer asks, \"<i>Remember me?  I thought it only proper that I thank you for letting me live.  Now, be a good boy and suck my dick - show all everyone just what a horny, helplessly fuckable toy you are.</i>\"/ asks, \"<i>I hope you don't mind slurping down a little cock, because you're going to anyway.</i>\"");
			
The second herm grabs you by the {horns/head} and sidles forward, ramming her glans into your mouth and down the back of your throat.  You can feel her glans pulsing deep inside you, and as soon as the herm starts moaning, the centaur starts trotting forward again.  Amazingly, having her holding you up makes it easy to maintain your position and keep your dick bouncing in that hot twat. Fuck it! You're too horny to care anymore.
Slurping hard, you lick and suck the dick in your throat, so busy tending to the omnibus that you barely the notice the throbbing ache in your loins.  You cast lusty, inviting eyes around at every feminine form you see during journey to the stables, located in some backwater, seemingly forgotten part of the fortress.  You quiver with need and explode in passion, moaning into the Omnibus's cock as your " + cockDescript(x) + " spends it's lust into the oozing horse-pussy, wasting your champion-seed to father nothing more than a batch of shiftless imps.
The vibrations of your moans of pleasure set the omnibus alight with delight, and her dick surges deeper down your throat, releasing a thick batch of creamy seed to fill your belly.  Shuddering in bliss, you swallow and cum over and over, spunking up the equine cunt happily while swallowing an equal measure orally.  Locked in cunt and on cock and finally allowed orgasm after an endlessly long tease, you feel as if you're atop an orgasmic wave, riding the spooge all the way into shore.  The hot vice around your dick quivers and squirts thanks to your donation.
As your climax-contractions slow, you the omnibi withdraws with a smirk.  \"<i>Thanks, maybe I'll come back to try some of that champion-spunk once my big friend is tired of you.  Then again, maybe I'll just ride your face like the fuckable cunt-hole it is while the centaurs take turns getting knocked up on your worthless fuck-tool.</i>\"
The centauress backs you into a wall, clamps snapping shut over your [legs] to hold you in place.  In a panic, you try to wriggle free, but the omnibus easily wrangles your arms into a matching set of restraints.  Once suitably immobilized, she kisses you hard, her ruby lips burning hot against yours for the briefest moment.  It's at this moment that you realize your dick is still rock-solid and ready to go again.  Then, the kiss breaks, and the omnibus wings away. 
At the same time, your centaur mate steps away, still joined to you by webs of sexual fluid that gradually snap.  As she departs, you realize you're bound up in a stall, tied to a wall, and you swear you can see lines of hooves waiting their turn from under the wood frame.  An albino woman with ivory horns clops in next.  She pivots, and you're given your first glimpse of your second "wife".  You've got a lot of demons to inseminate.
[Next]
As the years roll by, you see lots of pussy, and lots of injections.  They test all kinds of cocktails on you.  Ones that makes your balls swell, or your seed runny, or thick, or even black.  Eventually, one of your children comes out as something other than an imp.  The first proper demon infant.  Too fucked up to feel anything but pride, you marvel can only marvel at your amazing virility as you seed the birth of a new species, knocking up every demon with a cunt in a month-long orgy.  Your jism fuels the ascendency of an entire race, dooming Mareth.
		}
		
	}

}