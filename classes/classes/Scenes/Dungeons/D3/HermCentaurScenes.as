package classes.Scenes.Dungeons.D3 
{
	import classes.BaseContent;
	import classes.GlobalFlags.kFLAGS;
	import classes.Appearance;
	import classes.PregnancyStore;
	
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
			
			startCombat(new HermCentaur());
		}
		
		private const CENTAUR_KILLED:int = 1;
		private const CENTAUR_RELEASED:int = 2;
		private const CENTAUR_FUCKED:int = 3;

		public function beatThePony(hpVictory:Boolean):void
		{
			clearOutput();
			outputText("With a heavy 'thud', the demonic red-head slumps onto her side in the grass.  Her tail flails fitfully")
			if (hpVictory) outputText(" as she tries to rise");
			else outputText(" as she tries to stretch for her pulsating, cum-dripping member");
			outputText(", but it's a futile gesture.  She doesn't have the power to face you on her own terms anymore, and she watches you with a");
			if (hpVictory) outputText(" resigned glare");
			else outputText(" lustful glare");
			outputText(" once she realizes she's utterly spent.");

			if (player.lust >= 33) outputText("\n\nAfter her cock-teasing, she's sitting right there with two very large, alluring sexes presented to you.  Do you sate yourself on them?");

			outputText("\n\nOf course, she is a demon; perhaps you should simply end the threat she represents to the people of Mareth.  Do you finish her?");

			menu();

			if (player.hasCock()) addButton(0, "Fuck Her", maleFuckHer);
			if (player.hasVagina()) addButton(1, "Get Fucked", femFuckHer);
			addButton(5, "Release", letHerGo);
			addButton(6, "Kill", killHer);
		}

		private function killHer():void
		{
			clearOutput();
			outputText("Sighing, you advance on the downed demon, trying to ignore the horrified look in her eyes as you end her.");
			flags[kFLAGS.D3_CENTAUR_DEFEATED] = CENTAUR_KILLED;

			menu();
			combat.cleanupAfterCombat(getGame().d3.resumeFromFight);
		}

		private function letHerGo():void
		{
			clearOutput();
			outputText("You dust off your [armor] and wave nonchalantly at the equine demoness.  She slowly staggers up, watching you warily.  Dismissively, you tell her to leave before she earns your ire - her queen will be dealt with soon enough.  She clops off in a huff towards the exit.");
			flags[kFLAGS.D3_CENTAUR_DEFEATED] = CENTAUR_RELEASED;

			menu();
			combat.cleanupAfterCombat(getGame().d3.resumeFromFight);
		}

		private function maleFuckHer():void
		{
			flags[kFLAGS.D3_CENTAUR_DEFEATED] = CENTAUR_FUCKED;

			var y:int = player.cockThatFits(monster.vaginalCapacity());

			if (y < 0) y = player.smallestCockIndex();

			clearOutput();
			outputText("You shrug out of your [armor] as you close with the defeated beast-woman.  Looking at her like this, she almost seems more animal than woman.  Her hundreds of pounds of muscular equine flesh twist and contort as you approach, shifting her bulk to allow you unimpeded access to either of her trembling, moist genitals.  Glancing up to her pale, freckled face, you trap her green eyes with your own and say, \"<i>" + ((player.cor > 50) ? "I'm gonna wreck it!" : "We do this my way.") + "</i>\"");

			outputText("\n\nReduced a whimpering mare, the demon-taur can do naught but eagerly nod and lift her tail at the sight of your encroaching erection");
			if (player.cocks.length > 1) outputText("s");
			outputText(".  [EachCock] is a hard, throbbing mess by the time you're aligned behind her, so close to her drooling gash that the waves hot, slippery heat rolling off it make [eachCock] glisten, shining dully in the light.  It feels so good that it makes your head swim, and you haven't even pushed inside that black-lipped vice yet!  Almost of their own volition, your [hips] surge forward to bury your " + player.cockDescript(y) + " into the demon's channel, a gush of fresh fluids splattering out to soak your loins as the unholy warmth shrouds your member in bliss.");

			outputText("\n\nYour unholy companion's human-half sighs into a relaxed stupor, moaning happily at the forceful plowing of her folds.");
			if (player.balls > 0) outputText(" Slapping wetly against hers, your [balls] ring in an increasing torrent of fleshy slaps.");
			outputText(" She props herself up on the crook of her arm and lifts a breast to her mouth, hungry for her own aphrodisiac milk.  You can't help but smile at the surge of tension and heat it brings to her steamy sex.  Even more amusing, her enormous cock starts bouncing up against her belly, flinging long ropes of liquid pre everywhere in the demon's throes of passion.  Still, she hasn't come, not yet.");

			outputText("\n\nSlapping at her quivering hindquarters, you begin to truly ride your captive mare, mounting her over and over, your cock slipping and squishing through the plush, juice-drooling gash.  The black lips of her pouty pussy are drenched in a veritable ocean of estrus, soaked in liquid arousal that's already forming into a slick puddle beneath her bulk.  Her snatch moulds perfectly to your [hips] with every mighty thrust and warms your loins with own bestial fervor.  Your head in swimming from the sensations and scents, and you know you can't hold back in such circumstances for long.");

			outputText("\n\nAs your inhibitions slowly come unglued and moans begin to slide from your mouth with the same ease your dick finds below, a wicked idea comes to your mind.  This demon seems to have incredibly potent female pheromones - they've already gotten you jumping to empty your [balls] inside her.  However, she also has a very prominent and very erect maleness of her own, one that matches her female half perfectly.");

			outputText("\n\nYou reluctantly withdraw yourself from the hot horse-hole, thick drizzles of lube hanging in wet webs that cling to your flesh as they snap, one by one.  Perfect - you smell like a mare in heat from the navel down.  Ignoring the plaintive, needy moans, you stalk around her clydesdale-sized bulk to view her human half.  As soon as she sees you, her green eyes widen and she gasps loudly, nipple popping free of her mouth as she inhales deeply in surprise.  Her pupils dilate in seconds, and her nose begins twitching, the button bouncing as her nostrils widen to inhale more of her own fuck-scent.");

			outputText("\n\nGlancing back, you can see a puddle of white forming beneath her flaring cock-tip.  Her pre is coming out so thick that it's become indistinguishable from cum at this point.  As encouragement, you slap [eachCock] into her cheek, slowly dragging it across her face.  Of course, you slow down when you slide over her lips and across her nose, giving her a few more nice long drags of her own fertile pheromones.  Her hind legs begin to twitch and buck, clawing at the air in a frenzy but only managing to drag her spunk-splorting prick back and forth through her own puddled spunk.  The demoness moans, \"Fffffuuuck yooooouuuu,</i>\" in a voice that's more lusty than furious.");

			outputText("\n\n\"<i>No,</i>\" you answer, \"<i>I'm fucking you.</i>\"  You push your " + player.cockDescript(y) + " at her parted mouth, and they yield immediately, pleasantly opening to gratefully accept the taste of the mixed juices that soak it.  Her fair, freckled cheeks go so red that her freckles are actually lighter than the skin around them as she begins to suck, slurping lewdly at you with the skills of a professional cock-sucker.  You compliment her for being such a good mare and make sure to remind her that she's no stud.  Her dick flexes tightly at your words, flooding with so much blood that its skin shines from being stretched taut.  The masochistic cunt is getting off on sniffing her own fem-spunk and being humiliated!");

			outputText("\n\nYou take her onyx horn in your hands and adjust the angle of her head before pumping forward again, stuffing your " + player.cockDescript(y) + " into her gullet with a forceful thrust.  She gurgles messily, still trying to breathe through her nose while her tongue lashes madly across the sensitive underside of your dick.  This suits your purpose perfectly, as it keeps her so high on her own fuck-odor that she can't think straight, let alone slow the fevered pumping of her bloated sausage.  While fucking her throat raw, you feel the familiar tingling of your budding orgasm, and this time, you don't try to step it.  In fact, you pick up the pace, reaching down to tweak at the cherry-sized nipples below.");

			outputText("\n\nThe centaur's eyes roll back as she squirts pink milk from her abused teat.  It's all you can do to hold her still with the horn in your other hand while she begins to cum, thrashing and kicking, the sheer size of her warhorse-like body threatening to take you along with it.  Somehow, you hold on, and ride out her frenzied shakes.  Her tongue, wild and unrestrained, assaults your cock in a flurry of convulsive lucks.  It's just what you need to get off with her, finally letting her spurting tit free to grab hold of her red hair as your cum begins to well up from your [balls].");

			outputText("\n\nWith a mighty shove, you deeply penetrate her throat and begin to cum.  Your dick-slit opens as the first wave of pearlescent goo surges forth, and it flows unimpeded into the centaur's accepting belly.  At the same time, her cockhead has flared to twice the thickness of its shaft, and her balls are literally bouncing up and down in her taut sack.  Thick waves of horse-cum are pouring out of her distended cum-slit with alarming frequency, and for a few feet behind her, the grasses are soaked in a clear, feminine shine.");
			if (player.cumQ() >= 1000) outputText(" You quake at the sensation of dumping so much of your creamy batter into her stomach, nearly closing your eyes in bliss.  Luckily, you hold onto your wits.");
			if (player.cumQ() >= 5000) outputText(" It doesn't make much difference to the demon beneath you, as her belly slowly rounds from the obscene deposit you're plugging her with.");
			if (player.cumQ() >= 15000) outputText(" Bigger and bigger, she bloats until she looks fat or pregnant, jiggling with your thick spooge.");

			outputText("\n\nTrickles of cum leak from the corners of her mouth when you finally finish and withdraw.  Your conquest is gasping for air, but the corners of her mouth are upturned in a dopey, air-headed smile.  Getting dressed proves a bit difficult with all the juices soaking you, but you manage.  Unfortunately, by the time you're finishing, you hear hooves on pavement.  You spin to see her galloping away to the south");
			if (player.cumQ() >= 15000) outputText(", practically dragging her gut on the stones as she runs");
			outputText(".  Well, she might have gotten away, but she won't be able to stop you from getting to Lethice.  Indeed, it seems she was running for the exit.");

			player.orgasm();
			dynStats("cor+", 5);

			combat.cleanupAfterCombat(getGame().d3.resumeFromFight)
		}

		private const HORZGOG:int = 0;
		private const DOGGECOCK:int = 1;
		private const TENTACOCK:int = 2;

		private function femFuckHer():void
		{
			flags[kFLAGS.D3_CENTAUR_DEFEATED] = CENTAUR_FUCKED;

			clearOutput();
			outputText("Tossing aside your [armor], you close in on the defeated equine with a lusty gaze on your [face].  The defeated demon looks up at you with the reluctant anticipation of one who's getting what they want in EXACTLY the wrong way.  You swat the rebellious mare's flank, disdainfully sliding your [foot] across her gushing gash to watch her twitch and moan like the beast she is.  Of course the demontaur would enjoy such debasement.  You prace forward, being sure to jostle her gurgling balls, and enjoy the spurts of lurid white liquid that escape her tremendous, pulsating member.");

			outputText("\n\nHungry green eyes look up questioningly.  \"<i>Are you going to do this?  Are you going to fuck me... breed me?  I can change my cock... I can make it any size or shape you want!  Just, please don't crush my balls!</i>\"");

			outputText("\n\nFinally, a demon with some common sense!  You idly trace your [foot] along the underside of her leaky horse-cock while pondering this newest development.  She'll need to match her size to your [vagina] for sure, but what kind of cock do you want her to have?");

			menu();
			if (silly()) addButton(0, "HORZ GOG", femFuckHerII, HORZGOG);
			else addButton(0, "Horsecock", femFuckHerII, HORZGOG);
			addButton(1, "Dog Dick", femFuckHerII, DOGGECOCK);
			addButton(2, "Tentacles", femFuckHerII, TENTACOCK);
		}

		private function femFuckHerII(cockType:int):void
		{
			clearOutput();
			//[Tentacle]
			if (cockType == TENTACOCK)
			{
				outputText("You give her throbbing maleness an affection pat and proclaim, \"<i>Make it a tentacle, one that will fit me properly.  Then we can fuck.</i>\"");

				outputText("\n\nThe light in the room seems to dim, drawn into the demon's onyx-black horn, accompanied by the sound of flesh slithering through wetness.  A warm, slick presence brushes through your [legs], slowly coiling up and around as it lengthens.  Abruptly, the light returns, and you see that your foe has remained true to her words.  In place of the mammoth horse-cock, there's now a lengthy, undulating vine-cock.  The black equine skin of her balls fades into a dusky green tone across her sheath, and from that same sheath, a tentacle-penis is steadily extending, letting loose more and more inches of cock with every passing second.");

				outputText("\n\nA purple, roughly human-looking crown caps off this inhuman invader, though it is largely shrouded in verdant foreskin.  The tip of it rises up in front of you, waving back and forth like a snake-charmer's cobra, just inches away.  Hesitantly, you stroke the undulating shaft, pulling back the vine-skin to expose the vibrant cock-tip.  A clear bubble of precum slides from the narrow cum-slit in response, and in a moment of weakness, you give the planty prick a quick kiss.  It throbs and tries to push forward into your mouth with all the finesse of an idiot animal.  You choke off its feeble attempt with a firm grip and yank it down to your [hips], where it belongs.");

				outputText("\n\nThe demon-vine immediately thrusts forward, but in its eagerness, it misses your [vagina] entirely, instead grinding along your inner thighs.  You get a steady buzz of pleasure from the contact that makes your twat wet and your body shiver.  Involuntarily, you start to rock back and forth on it, working your soaked lips over the snake-like shaft until your [clit] is hard and poking free.  A plaintive voice whines, \"<i>I can't... -AH! ...can't control it!  Lethice's tits this is good... I might have to grow some more...</i>\"");
				if (player.clitLength >= 6) outputText(" A coil of cock loops around your gigantic buzzer, effectively frotting it like another cock and chance at protest from your lips.");
				else outputText(" A bend in the cock grinds against your buzzer with particular intensity, effectively robbing any chance at protest from your lips.");

				outputText("\n\nIn an instant, two more vegatative pricks are unspooled from the centaur's crowded crotch to prod at your openings.  The first one unceremoniously slips past its brother's confused wriggling to pierce your [asshole].  You gasp at the suddenness of the unexpected penetration, which is all the third dick needs to find its home in your mouth.  The smooth length easily rams a solid nine or ten inches into your throat, and before you can gag, your throat tingles.  The uncomfortable reflex dies away as fast as it began, and with a happy wiggle, the two new cocks start to fuck your [face] and [butt]. Sliding deeper and deeper, the twin members pass to the point where can hear them wriggling through your guts more than feel them.");
					player.buttChange(player.analCapacity(), true, true, false);

				outputText("\n\nYou would probably be screaming at this, if you weren't effectively plugged with cock.  The first dick, the one that was grinding in such a confused manner, it pulls down, then rears up and tries again.  This time, its aim is true.  The hot, shape-shifted tool plows through your achingly hungry gates with a complete lack of skill and finesse.  Its passage does a fine job of battering the lips to either side.  The writhing tentacle seems utterly aimless its predations, slamming about your box and writhing madly");
				if (player.clitLength >= 6) outputText(" - you swear it spends as much time caressing your [clit] as squeezing it off");
				outputText(".  You buck your hips, dragging the butt-piercing wang along for the ride as you start to fuck in earnest.");

				player.cuntChange(player.vaginalCapacity(), true, true, false);

				outputText("\n\nThe trio of tentacle dongs burrow deeper inside you with each passing moment.  Sure, they'll pull an inch or two out at a time, in some semblance of a good fucking rhythm, but they always thrust deeper and faster.  The one in your [vagina] seems intent on cramming its whole length into your womb, but your cervix steadfastly resists the intrusion.  The hard fucking soon lifts your body clear of the ground, suspending you in a web of verdant, iron-hard spears that never stop their violation of your form.");

				outputText("\n\nThe pleasure and pain thrusting through your body nearly overwhelms your other needs.  Almost...  Blackness starts to swim at the edges of your vision as the need to breathe reasserts itself.  With your heart hammering in a panic, you try thrash like a woman possessed, but it's a futile gesture.  The plant-cocks are so deep inside you they may as well be a part of you.");

				outputText("\n\nJust when you resign yourself to blacking out from what started as a simple fuck, a thick bulge works down the vine, nearly dislocating your jaw, then stretching your abused throat.  Matching distentions slide up your [vagina] and [asshole], stretching both wider to handle their steadily-progressing liquid loads. The three cocks go wild at this, moving wildly within you, the parts outside waving about in crazy motions as dozens of similar bulges round out their shapes.  You cum to the feeling of cum-load after cum-load being passed into all three of your holes, and then you lose consciousness.");

				outputText("\n\nYou wake to the feel of your body landing hard in the grass, coughing up huge gobs of thick sperm as you cradle your distended belly reflexively.  Blinking the cum from your eyes, you watch the three green shafts twining together into one, slowly darkening to a black, equine tool.  The centauress gets up while you catch your breath and takes off running, calling over her shoulder, \"<i>You won the battle but lost the war!  Thanks for the fuck, but if you don't mind, I'll come back once Lethice has you bent over her knee.</i>\"");

				outputText("\n\nIt takes a few minutes for enough cum to drain from your sore orifices to let you stand, and when you do, your belly gurgles uncomfortably.  It was undignified, but gods are you satisfied!");
			}
			else if (cockType == DOGGECOCK)
			{
				outputText("You give her throbbing maleness an affection pat and proclaim, \"<i>Make it a dog-cock, one that fit to knot properly.  Then we can fuck.</i>\"");

				outputText("\n\nThe light in the room seems to dim, drawn into the demon's onyx-black horn, accompanied by the sound of flesh shifting, creaking and thrumming as it takes on new shape.  You feel something pointy and hot brush your [foot], and as the light returns, you're treated to the sight of a swollen dog-cock leaking its thick pre-creme onto you.  Where once an equine cock jutted from a horse-like sheath, now there is the rounded bulb of a distinctly canine cock.  Above the deliciously thick knot, the rest of the shaft is blessedly thick, tapering only near the very tip.  Best of all, it looks able to be faced in any direction, so taking it should be no problem.");

				outputText("\n\nYou lay down under the centaur, your torso nestled firmly between her forelegs.  Her animalistic body's muscles and heavy heartbeats are surprisingly soothing to you as you position yourself, aligning the doggie dick to take you from behind.  Breathy heavy with anticipation and lust, you fairly ooze with lady-lube, your [vagina] drizzling the bitch-cock with your lusty lubricants.  You rub that hot member around your outer lips to tease yourself, only growing wetter with each passing press, prod, and near-penetration.");

				outputText("\n\nThe demoness cries out, \"<i>Quit playing with it and fuck it already!</i>\"");

				outputText("\n\nWell, that simply won't do.  You break from your fevered self-pleasure to punish the ungrateful bitch a few minutes.  First, you gather up a palmful of her salty puppy-cum and slather it over her shaft.  Then, you jack her off quickly, making sure to squeeze over the knot with gentle pressure each time.  However, as soon as you feel even the faintest twitch from the canine orb, you release it and wait for the swelling to go down.  The haughty centauress is soon readied into malleable fuckmeat by your skilled teases, a literal herm-bitch in heat.  ");

				outputText("\n\n\"<i>P-please... just... fuck it!  Fuck me!  Anything!  Just stop teasing me, damn it!</i>\"");

				outputText("\n\nSmirking, you reply, \"<i>That's more like it,</i>\" even as you shift down, letting the pointed crown of her cock finally taste the juicy vulva of your pussy.  From then on, you let your box do the talking, slowly sliding down and squeezing each freshly devoured inch with deliberate cuntractions.  The knot stops you when it presses on your labia, your unready pussy not quite ready to take it.  Small dollops of warm dick-juice slowly roll out inside you, mixing with your own copious lube as it soaks into the centaur's underfur.");

				player.cuntChange(player.vaginalCapacity(), true, true, false);

				outputText("\n\nRocking your [hips] slowly, you begin to properly ride your mount.  The demoness's cock slips almost the whole way out with ease, lubricated as it is, and it goes back in with a delicious squish of slippery pleasure.  You bounce upon your mastiff-endowed sex-toy with glee, listening with rapt attention to the hammering equine heart just above your head.  Reaching down, your hands find their way down to the swollen ballsack, and you roll the hefty orbs across your fingers as you ride their twitching spout.");

				outputText("\n\nAt last, your frantic fucking hits the doggie-dick hard enough to pop the slowly-swelling knot inside your snatch.");
				player.cuntChange(player.vaginalCapacity() * 1.2, true, true, false);
				outputText("  The pleasure of being so fully stretched is enough to overwhelm any pain at such an act, and you switch over to smaller, faster strokes the leave most of the animal-cock inside you.  Bouncing atop the centaur's balls with a dopey grin on your [face], you sigh and moan.  This is how you're going to take down these demons, one fuck at a time!  The thought gives your " + player.skin() + " a fresh flush, and you pinch your nipple while imaging mounting a demon queen atop an orgy of her defeated lieutenants.");

				outputText("\n\nInside you, the knot stretches, interrupting your daydreams with its orgasm.  By the time you react, it's already dilated your cunt obscenely, rounding it into more of a sphere than a passage.  A second after, you feel the first splashes of dog-jizz spurting into your tunnel.  The first gushes of sperm effectively flood the love-canal, and those that follow just force the sealed juices deeper inside you, into your womb.  The heavy balls in your hand expand mid-orgasm, nearly doubling in size.  The taut scrotum skin is forced to stretch drum-tight while the prodigious orbs swell, the whole time somehow still pumping cum inside you.");

				outputText("\n\nYou cannot endure such a powerful insemination, and with a cunt-clenching crescendo, you cum around the orgasmically-thick doggie dong.  It twitches powerfully as it unloads thicker and thicker blasts of tainted animal-cum into your uterus, flooding your abdomen with unholy spunk.  Your belly slowly rounds from the spooge-injections, every fresh wave forcing it to balloon bigger.  The pressure grows and grows.  Your belly button even becomes an outie as the pressurized semen does its work, held deep in your fecund femininity by the tight cock-seal at your entrance.  Rolling back in your head, your eyes flutter into uselessness, the exposed whites testament to how much you're enjoying being so thoroughly bred.");

				outputText("\n\nEventually, the semen stops squirting into your willing depths, but the knot holds you firm, forcing you to adapt to being cum-pregnant for what seems like hours.  You lounge with the demon still inside you, half-conscious and cumming with every sudden shift while you wait on the expanded knot to contract.  The tainted centaur tires of this in time and tries to rise, lifting you into the air by your [butt] for a few seconds until she pops free.");

				outputText("\n\nYou drop into the dirt, cum spewing from your poor, abused pussy and drizzling from the thick dong above.  The rush of slick fluids is surprisingly pleasurable, and it leaves you writhing in bliss while your body drains.  You barely notice the centauress clopping away, or her taunts at your state.");

				outputText("\n\nOnce you recover, you compose yourself and get dressed, feeling equal parts humiliation and satisfaction.  At least your itch got scratched.");
			}
			else
			{
				outputText("You give her throbbing maleness an affection pat and proclaim, \"<i>Keep it equine, the flare looks delicious.  Just make sure that it will fit, and then we can fuck.</i>\"");

				outputText("\n\nThe light in the room seems to dim, drawn into the demon's onyx-black horn, accompanied by the sound of flesh slithering and shaping.  A warm, slick presence brushes you, spongy cock-flesh brushing against you as it dribbles a rope of pre-cum onto your [leg].  As the light returns, you get to see the changes, noting that now the demon's member is perfectly sized for your penetration, though the head looks like it could be a bit challenging to take.");

				outputText("\n\nYou lower yourself down beneath the centaur's horse-half to get a better look at the beast you intend to fuck.  The cock seems big for your hands, a swollen meat-tube that flexes in response to your touches and flares slightly with each smooth caress.  It dribbles off-white pre-spunk over your hand almost immediately.  Giggling, you smear it back over the shaft and admire the thick cock as you lubricate it.");

				outputText("\n\nA remarkably masculine scent emanates the cock or its copious pre-cum, filling your nostrils with the musky, groin-lubricating scent.  Your [vagina] drenches itself in anticipation as you give the horse-cock a slow hand-job, painting it with its own juices.  Without meaning to, you lean in closer for another sniff and wind up giving the fat flare a slow lick, swallowing the bubble of jizz it deposits on your tongue unthinkingly.  The cock pulsates happily in your grip as if thanking you for the kiss, and you decide to play with it for just a little longer.");

				outputText("\n\nLooking at the fold of skin that is the beast's sheath, you curiously begin to probe at it, sliding your fingers under the warm cock-blanket to feel the whole of the centaur's member.  The action intensifies the crotch-dampening scent that's working to soak your [legs], and with a dopey grin in your face, you shift one hand back to your [vagina], making sure to diddle your soaking clit on the way.");
				if (player.clitLength >= 6) outputText(" The hard, feminine pole twitches nicely at your touch, a far more sensitive rod than any cock.");
				outputText(" Your fingers sink into your gash with ease and set to work with ease.  Of course, they're soaked in a second.");

				outputText("\n\nWith your other hand, you jack off the horse-cock from inside its sheath, reveling in the delicious pheromones as you fellate the flaring cock-head.  They make you feel a little dizzy, but then you open your mouth wider and slide the wide, outstretching crown through your lips, fanning your tongue along the underside at your maximum speed.  The balls beneath the turgid shaft bob ominously, and you figure as big as they are, you can let the pony blow off a little 'steam' before you take it for a ride.  You delicately caress the sensitive, sheath-bound underside of the cock while assaulting the crown with suckling licks, working the beast into a pleasured frenzy.");

				outputText("\n\nThe expanding head opens your jaw to your limits just in time to blast a hot wad of cum onto your tongue and throat with tremendous force.  You happily swallow, it, savoring the slightly salty taste of the demon's horse-jism as it paints your mouth white.  Pumping her on her shaft and your cooch, you milk her slick dick expertly even while your fingers are working your sopping box into a climax of its own.  You gurgle out a moan from the pleasure, but somehow manage to stifle it and go back to swallowing down the alabaster juices, lest you drown.  Eventually the explosion of spooge over-pressurizes your maw, back-blasting the outstretched horse-dong free from its oral imprisonment to erupt unrestrained, gushing whiteness into your [hair] and face.");

				outputText("\n\nWiping the showing spunk from your eyes, you give the throbbing member an affectionate pat, which only succeeds in coating your hand with a fresh layer of gooey glaze.  The centauress breathily exhales a satisfied sigh, at least, until you give her scrotum another encouraging squeeze.  Her flagging erection surges back to rock-hard life, and you quickly pivot, aligning the swollen tip with your ever-hungry muff.  Pressing back at it, you try to impale yourself upon the bestial girth but find it still thicker than you can easily handle.");

				outputText("\n\nYou're not going to give up that easy!  The dick presses harder against your [vagina] as you shift your body weight into it, the rubbery flesh of the flare flexing as it starts to part your lips at last.  Grunting, you try to relax, hoping it will ease the penetration, and to your delight, it does.  The veiny shaft pops into your waiting folds with surprising easy once the crown is inside you, sinking deeply into the well of feminine fluids.  You give up an unlady-like scream of pleasure at the feel of being filled so fully, that wonderful thick tip massaging every nerve ending along your walls as it plows deeper.");
				player.cuntChange(player.vaginalCapacity(), true, true, false);

				outputText("\n\nAfter taking all that, you begin to bounce up and down atop it, even though your [legs] are shaking and your [vagina] is");
				if (player.wetness() < 4) outputText(" practically");
				else outputText(" liberally");
				outputText(" squirting fluids. The mare... or is that stallion?  Whatever, her legs are kicking feebly, twitching from the abuse her still-sensitive organ is forced to endure in your tight twat's tremendous grip.  You work your muscles to squeeze that thick equine rod, milking it with your pussy's slick walls until it yields up another fresh bounty of cum to fill your womb.  Squealing in absolute rapture, you quake about your lover's perfectly-sized cock, blissed from the fireworks each of your nerves is setting off.");

				outputText("\n\nYou nervelessly slide off the pole into the ground, earning a fresh bukkake of creamy cum to plaster your " + player.skinFurScales() + ".  While you recover, your demonic lover's bulk shifts away, and you soon here the telltale clopping of her moving away.  It sounds like she's heading towards the south - the exit.  You missed your chance to do anything about that demon...");
			}

			player.orgasm();
			dynStats("cor+", 5);
			player.knockUp(PregnancyStore.PREGNANCY_IMP, PregnancyStore.INCUBATION_IMP);
			menu();
			combat.cleanupAfterCombat(getGame().d3.resumeFromFight);
		}
		
		public function inSovietCoCPonyRidesYou(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (player.hasCock() && player.hasVagina())
			{
				if (rand(2) == 0) maleLoss(hpVictory);
				else femLoss(hpVictory);
			}

			if (player.hasCock() && !player.hasVagina()) maleLoss(hpVictory);
			else if (player.hasVagina() && !player.hasCock()) femLoss(hpVictory);
			else if (!player.hasVagina() && !player.hasCock()) femLoss(hpVictory);
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
					else outputText(" " + player.multiCockDescriptLight());
				}
				outputText(" to the pervy, sexy equine.");
			}
			outputText(" She smirks as she trots up, commenting, \"<i>That's more like it, slut.  I don't know how you got this far, but your quest ends here.</i>\"  She casually reaches down and grabs you by the scruff of the neck, hauling you bodily up until your head nestles between her tits");
			if (player.tallness >= 7 * 12) outputText(", even though your [feet] still touch the ground");
			outputText(".  Brushing through your hair, a hand gently caresses your back as its owner coos, \"<i>You'll make a fine mare for my stable, but lets get you in the right mindset first...</i>\"");
			
			outputText("\n\nYou're shifted to the side, your face dragged along the side of a pale, freckled breast as you're moved into position.  A thick nipple, almost as wide as your finger, pushes at your lips, smelling faintly of sugary sweetness and sex all blended together.  When you don't gratefully accept it, your jaw is forced open and the nearly inch-long teat is firmly inserted.  As soon as it's seated in your maw, the hard milk-nozzle immediately begins to leak its tasty treat - a sweet fluid that seems to fizz on your tongue and light your mouth up with pleasure.  You savor the taste as long as you can, but pleasure-inducing juice soon has your cheeks bulging.  You gulp it down reluctantly, if only to make room for more.");
			
			outputText("\n\nYour eyes open wide when the delicious demon-milk hits your stomach.  It fills your core with such warmth that you think you might melt, at least until the heat begins to diffuse outward, bringing with it a tingling sensitivity that makes the tit in your mouth taste that much better.  You draw deeply on the rosy, pink nipple, sucking down even more 'milk' with every passing second, if only to kindle even more of that pleasant sensation.  The hands release you, but you stay firmly attached to your teat.  You need more.");
			
			outputText("\n\nThat burgeoning heat that's soothing away your worries builds hotter and higher with every swallow, but it isn't until the lactation slows to a trickle that you notice something else - it's gathering in your groin.");
			
			if (!player.hasVagina())
			{
				outputText(" The pleasant warmth builds with alarming speed, the diffused sensation pooling toward a focused point in your crotch. The heat seems to tunnel deeper into your core before returning to the surface, and with each iteration, the pulsating, almost liquid sensation feels hotter. The warmth quickly makes way to raw, unadulterated heat, which in turn rapidly transforms into a deeply rooted, scalding fire- but it takes on a subtly different tone; a different kind of heat. It’s only when the first traces of wetness begins to roll down the inside of your thigh that you put all the pieces together. <b>The centaur's milk has rooted a cunt into your previously genitalia-void crotch.</b>");
				player.createVagina();
				outputText("\n\n");
			}
			else outputText(" ");
			
			outputText("Your [vagina] is so puffy and inflamed with passion that it feels ready to burst out of your [armor], even as the drooling fem-cum makes it squish wetly with your every motion.");
			if (player.hasCock()) outputText(" [EachCock] fares little better, a turgid mess of pre-cum leaking lust that seems to grow harder and more sensitive by the moment.");
			outputText(" That wonderful warmth excites you sexually, a deepening puddle of lust in your loins that makes you so hot and wet that you swear it must be what's dripping out onto the cobble below.");
			
			outputText("\n\nYou're moved to the other side, with a fresh, juicy nipple for you to nuzzle.  You do so without thought, effortlessly clasping your lips in a tight seal around the heavenly nub and suckling, even as you rest your cheek against the pale, freckled skin of the melon-sized tit.  The fluid begins to flow almost effortlessly, flooding out in response to the slightest hint of suction from your hungry mouth.  Bubbling, almost boiling over, your lust mounts to higher and higher levels, your loins seeming to simmer with molten desire to be bred.  In response, you begin peeling away your [armor].  You know this delicious milk will be gone soon, and when you finish, you want to be mounted, hard.");
			
			outputText("\n\nWith your [vagina]");
			if (player.hasCock()) outputText(" and " + player.multiCockDescriptLight());
			outputText(" freed, your hands unabashedly dive into your folds, spreading them as wide as possible, heedless to the discomfort.  You drink and stretch, swallow and tug.  Over and over, you give into the artificial, hedonistic desires your dual - endowed mistress's milk instills in you.  There's no fighting it, only giving in utterly as you prepare yourself to be filled, speared upon your mistress's mighty member and filled with her hot cum until your body turns into a quivering, orgasmic wreck.");
			
			outputText("\n\nThe tainted centaur pulls you back even as your lips stretch forward in desperation, but at last, you pop off the nipple, disappointed.  She tilts your head to look up at her green eyes and glittering, black horn.  She's a terrible demon, a beautiful maiden, and a monstrously large, giant-like centaur, all at once.  You pant, whining with your exhalations until she gently releases you.  Flopping down nervelessly, you catch yourself before you smack off the hard stone.  You rise up again, ready to fuck, only to come up into a face full of slime-lubed horse-cunt.");

			outputText("\n\nThe warm, rubbery lips squish down wetly as your nose slips between them, nestled deeply into that moist, bestial crevasse.  Runnels of slick fluid soak the whole of your " + player.face() + " and drip from your chin in thick ribbons.  At first, this shocks you, but as soon as you realize what's going on, you do as expected an open up to taste her wetness.  She's hot, practically steaming, and her hard nub is a deliciously wet, throbbing target for your questing tongue to squeeze up to.  You lash your mouth-muscle across the sensitive buzzer, orally spanking it while you wiggle your face and lips to caress the sensitive entrance.  Just as you finally start to get into it, the giant, hot hole pulls away, joined to you only by glimmering bands of lady-spunk that soon snap.");

			outputText("\n\nTurning around, the demoness gives you a knowing smile even as she deigns to caress your woman-soaked visage with surprisingly gentle fingers.  She commands, \"<i>Present yourself, my sweet little filly.</i>\"  You do so without question, shaking like a leaf in the wind with anticipation.  By now, your copious drippings have turned your quivering [legs] in a glossy mess, soaked in liquid, feminine arousal that only entices your mistress to clop closer as you lift your [butt] high and make your [vagina] ready to be taken.  You grab hold of nearby stones with trembling fingers and fearfully look back over your shoulder as the nine-foot equine monstrosity's shadow looms closer.");

			if (player.isPregnant()) outputText("\n\nA tingle runs through your belly as something changes, and a powerful voice smirks, \"<i>One of my other mares will finish bearing that runt for you.  Now, that fertile womb belongs to ME.</i>\"  You... you're no longer pregnant!");

			outputText("\n\nShaggy, fur-shrouded hooves stamp down to either side of your hands.  You can see the powerful muscles that drive her massive body above you, shifting beautifully under her fur-clad skin while she positions herself properly.  Her scent, still clinging to your nose and mouth and characteristic stubbornness, only grows stronger in her direct presence, mixed with a salty, masculine musk that radiates from the throbbing shaft above and behind.  Drops of her liquid desire spatter off your [butt], fairly sizzling with the heat of her need, and you feed the flared head tip lower to smear the white goop across your crack and down your lips.  You shake and nearly fall from the avalanche of pleasure, but somehow, you hold your pussy up, craving the cream filling it's so eager for.");

			outputText("\n\n\"<i>Hold... still,</i>\" the demon grumbles as she fidgets, steel-shod feet cracking noisily against the pave-stones.  Her flat tip batters up against a different part of your anatomy with near bruising force every time she tries to hit your target, but she's as awkward as the beasts her lower body resembles.  You nearly scream in surprise when she smashes it into your [asshole], but thankfully, the heavy head is withdrawn, searching for more fertile pastures.  Again, she tries to spear your pussy, but misses, sliding beneath and glossing your [clit] with a heavy coating of horse-slime.");

			outputText("\n\nA hand reaches down to grab your " + player.hairDescript() + " and pull back sharply.  \"<i>Stay... put...</i>\" its owner pants.  You have been staying put!  At least, when you haven't been shaking with barely-contained need.  The angle is somewhat painful, flexing your spine into a dangerous arch even as the force of her tug shoots needles of discomfort into your abused crown.  Then, the horse-like lower body steps forward, and you're seeing stars and smiling dopily. The flared head smashed into your semi-stretched pussy for only the briefest moment before its body's momentum carried it through your entrance and deep into your canal.  Even now, you can feel the medial ring thrumming with each beat of the centaur's heart, just inside your entrance while the fat tip butts up against your cervix.");
			player.cuntChange(monster.biggestCockArea(), true, true, false);

			outputText("\n\nYou sag into the welcoming penetration, pushing back against the intruding maleness in a drug-fueled stupor.  Only after a few moments of fervent grinding do you realize that you truly want to push that beast the whole way into your womb - to feel it sliding wholly and completely inside you.  \"<i>Greedy little mare, aren't you</i>\" the confident centaur herm asks as she begins to rock with you, the soft flare stretching wider to scrape along every sensitive nerve of your interior with surprising tenderness.  She lets go of your hair, and you meekly look up and nod, pushing your body back hard with each thrust.");

			outputText("\n\nThe demon's horn casts a black shadow on the cobbles before you.  You curiously watch it bob with every slow drag out and inhumanly powerful thrust back in.  Each hip-jarring penetration bears pleasant fruits, in the form of heavy globs of precum that squish through your cervix and into your womb.  Small spurts of it splatter out of your well-stretched cunt as the thick cock fills every available crevice of your canal, mixed in with the clear dribbles of your own need.  By now you've begun to moan like a whore in heat, rutting with this demonic beast as hard as your body will allow, yet it still will not gratefully accept the beast's crown - you're just too small!");

			outputText("\n\nSmirking, the demoness asks, \"<i>Not happy only getting half of my cock in there, are you, slut?  Lets make that troublesome cervix a bit more accepting, shall we?</i>\"  She pushes in until her tip is smashed flat on your womb's entrance once again, but this time, she holds still.  Soft murmurs echo down from above, incoherent to your unpracticed ears but undeniably magic.  The constant trickles of demon-spooge of thicken, flowing hot and hard enough to baste your innards with, and as soon as she finishes her chanting, you 'bloom' internally, for lack of a better word.  It's almost as if your entire reproductive system is relaxing, opening gratefully to allow your mistress to more properly ravish you.  Of course, she does.");

			outputText("\n\nThat hot horsecock is rammed into you, until you feel the folded skin of her sheath on your lips and the heavy weight of her squirming testes bouncing off your [butt].  The proud shape of her flare is clearly visible on your stretched-out tummy, but it doesn't hurt.  All you feel is glorious fullness and the ache of so much pleasure that you fear you'll cum and pass out, all at the same time.  The delicious thickness inside you bubbles and grows, thickening with each beat of the demon's heart, and you realize she's as close as you, perhaps closer.  Timidly, you caress her thick flare through your taut skin, garnering a spurt of hot pre and a matched moan of contentment from your gargantuan lover.");

			outputText("\n\n\"<i>I think I might have a new favorite mare</i>,\" the demoness pants while gleefully pounding your over-stuffed snatch, \"<i>We just met and you've already accepted your role.  I hope you don't mind birthing dozens of imps for my personal army and helping us research more proper reproduction.</i>\"  She's going to fuck you more?  You gleefully moan out an affirmative, and she rewards you by pounding your box harder, stuffing it full of her thick, hot member, all the way to the top of your hungry, pre-stuffed womb.");

			outputText("\n\nYou wriggle and wail, feeling the mounting pleasure growing into an unstoppable wave of bliss, bolstered by the fevered thrusts of your horny mistress.  She moans with you and bottoms out, her pussy spraying behind her while her soaked balls slap into you with brutal force, quivering once and then suddenly shrinking.  Her flare distends your poor body further, and then a thick wave of jizm is pouring out into your uterus, filling every empty cavity with demonic virility.  Your body seizes, then goes limp, all except for you the ripples of contractions churning through your [vagina] as it milks every drop from your demonic lover.  The next jizz-bomb bloats your abdomen to purely pregnant proportions and as you scream in absolute rapture, the pressure slowly forces you off, leaving you to lie in a pile of sperm while it fountains from your abused twat.");

			outputText("\n\nDarkness takes you while you shiver in knocked-up bliss.");
			dynStats("lib", 50, "cor", 50);
			menu();
			addButton(0, "Next", femLossII);
		}

		private function femLossII():void
		{
			clearOutput();
			outputText("Later, you wake when something hard digs into your back, and as you crack your eyes open, the first thing you see is a set of equine hindquarters and prodigiously large testes.  Your next realization is that you're moving... not just moving, being dragged!  You glance downward and see that you're joined with the centauress once again, only this time, you can't see any distortion in your middle.  Your belly is stuffed so full of cum that you can't see the fleshy spear, but you can certainly feel it.  It's different now... narrower at the tip, but obscenely bloated at the base.  Even now, you can feel it stretching you to your limits to make a tight seal and slowly leaking a fresh river of jism to assault your ovaries.");

			outputText("\n\nThe demon has you knotted on a giant dog-cock!  When did she get one of those!?  You gasp in surprise, pain, and pleasure in equal measure.  She hears you and looks over her shoulder, still slowly walking, and she smiles as she says, \"<i>Welcome back.  I'm just taking you to your stall and making sure my devilish little children get a proper foothold in your womb.  Relax and enjoy - we'll get you fixed up once you're secured in your stall.</i>\"");

			outputText("\n\nYou slump down as you're dragged through dirt, over carpets, and through halls.  Various demons leer at you as you pass, snickering at the fallen champion, now little more than a willing mare.  The humiliation makes your cheeks go red but your [vagina] drool. Some part of you is clearly enjoying it, though you aren't sure if it's a natural enjoyment or something this creature has done to you.  You sigh and shrug, raising your hands to fondle your breasts as you're dragged to your new home.  You may as well enjoy yourself.");

			menu();
			addButton(0, "Next", femLossIII);
		}

		private function femLossIII():void
		{
			clearOutput();
			outputText("<b>Months later...</b>");

			outputText("\n\nYou sigh as your latest litter of imps clamor around your nipples, hungry for their mother's milk.  They're such greedy, ceaselessly ravenous creatures.  Having their clutching mouths on your nipples all the time makes it so hard to sleep, and it doesn't help that the 'father' insists on rutting with you and knotting you for hours until she's 'sure' your pregnant.");

			outputText("\n\nThe rest of your days are lived out like that, interrupted only for fresh injections of demonic chemicals and thick centaur-cum.  Amazingly, the demon's experiments bear fruit, and you have the honor of birthing the first true demon offspring - the first of many.  Though you're eventually traded to a new owner once you're well used and other sluts have been similar prepared, you keep a sense of a perverse pride through it all.  You were the first demon mother.  You helped the new species propagate and assure their dominance over lesser forms of life, like yourself.");

			dynStats("lus=", player.maxLust(), "lib", 50, "cor", 50);
			getGame().gameOver();
		}
		
		private function maleLoss(hpVictory:Boolean):void
		{
			clearOutput();

			var y:int = player.cockThatFits(monster.vaginalCapacity());

			if (y < 0) y = player.smallestCockIndex();

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

			outputText("\n\nYou're shifted to the side, your face dragged along the side of a pale, freckled breast as you're moved into position.  A thick nipple, almost as wide as your finger, pushes at your lips, smelling faintly of sugary sweetness and sex all blended together.  When you don't gratefully accept it, your jaw is forced open and the nearly inch-long teat is firmly inserted.  As soon as it's seated in your maw, the hard milk-nozzle immediately begins to leak its tasty treat - a sweet fluid that seems to fizz on your tongue and light your mouth up with pleasure.  You savor the taste as long as you can, but pleasure-inducing juice soon has your cheeks bulging.  You gulp it down reluctantly, if only to make room for more.");

			outputText("\n\nYour eyes open wide when the delicious demon-milk hits your stomach.  It fills your core with such warmth that you think you might melt, at least until the heat begins to diffuse outward, bringing with it a tingling sensitivity that makes the tit in your mouth taste that much better.  You draw deeply on the rosy, pink nipple, sucking down even more 'milk' with every passing second, if only to kindle even more of that pleasant sensation.  The hands release you, but you stay firmly attached to your teat.  You need more.");

			outputText("\n\n\"<i>Ahh, you can be taught,</i>\" your captor sighs.");

			outputText("\n\nThat burgeoning heat that's soothing away your worries builds hotter and higher with every swallow, but it isn't until the lactation slows to a trickle that you notice something else - the warmth is gathering in your groin.  [EachCock] is so hard, so throbbingly turgid, that it presses painfully at your [armor], dribbling so much pre-cum that feel it'll start to run down your [legs] any second now.");
			if (player.hasVagina()) outputText(" Your [vagina] fares no better, puffing up and drooling like its big brother while your [clit] grows taut and sensitive.");
			outputText(" That wonderful warmth excites you sexually, moulding your loins into a simmering blaze of desire just looking for a something to cool its ache.");

			outputText("\n\nYou're moved to the other side, with a fresh, juicy nipple for you to nuzzle.  You do so without thought, effortlessly clasping your lips in a tight seal around the heavenly nub and suckling, even as you rest your cheek against the pale, freckled skin of the melon-sized tit.  The fluid begins to flow almost effortlessly, flooding out in response to the slightest hint of suction from your hungry mouth.  Bubbling, almost boiling over, your lust mounts to higher and higher levels, your loins seeming to simmer with molten desire to breed.  In response, you begin peeling away your [armor].  You know this delicious milk will be gone soon, and when you finish, you'll need to mount something... hard.");

			outputText("\n\nWith your hands and body freed, you unabashedly dive down in an instant to get at your needy hardness.  You drink and squeeze, swallow and stroke.  Over and over, you give in to the artificial, hedonistic desires your dual-endowed mistress's milk instills in you.  There's no fighting it, only giving in utterly as you prepare yourself to be used as a sperm-pump, ridden mercilessly until you spew your molten lust into her fertile nethers, a helpless stud only alive to knock her up over and over again.");

			outputText("\n\nThe tainted centaur pulls you back even as your lips stretch forward in desperation, but at last, you pop off the nipple, disappointed.  She tilts your head to look up at her green eyes and glittering, black horn.  She's a terrible demon, a beautiful maiden, and a monstrously large, giant-like centaur, all at once.  You pant, whining with your exhalations until she gently releases you.  Dropping nervelessly in the grass, you twist and writhe, trying to rise and jerk off all at once.  Of course it fails, and by the time you get your hands down to push up, a shadow falls across your view.");

			outputText("\n\nThe equine half of your oppressor is directly above you, dripping strands of thick, female cum onto your face while her hard cock rains its pre-jizz over [eachCock] in a show of supreme dominance.  Still, you try to rise - perhaps due to foolish pride, desire, or just sheer instinct.  The centaur drops down before you get a few inches up, smashing her cunny into your face and bearing you to the ground.  Her weight is immense, and though some is kept on her forelegs and little spread to the haunches on either side of your face, you still get buried nose-deep in sloppy, black-lipped snatch.");

			outputText("\n\nThick balls settle over your neck, and you can feel the shaft of her gigantic horse-dong stretching across your [chest] towards your waist, pulsing fitfully.  With her heavy, furred body in the way, you can't get to your own loins.  Hell, you can barely breathe, and what little breath you do suck in is so filled with pheromones that your");
			if (player.balls > 0) outputText(" [balls] feel fit to burst!");
			else outputText(" manhood feels swollen to bursting!");
			outputText("  Realizing the only way out will be with your tongue, you open wide");
			if (player.tongueType != 0) outputText(" and uncoil your inhuman length to spear");
			else outputText(" and begin to lap");
			outputText(" at her inhuman entrance.  She whinnies in delight, grinding her clydesdale-sized bulk back and forth on your face as you start to get into her eating her out.");

			outputText("\n\nMoisture drizzles down your cheeks as her already-swollen vulva gets fatter with need.  Her fluids seem to be coming faster and faster, and you have to swallow some of them just to keep from drowning.  Surprisingly, it has a remarkably mild, palatable flavor.  If anything, she tastes slightly sweet, which isn't quite what you would have expected from her potent scent alone.  As turned on as you are, it doesn't take long for you to forget your dire straight and focus on tending to the inhuman woman's needs, licking, slurping, and sucking at her clit with gusto.  She's soon trembling and gushing across your " + player.face() + ", matting your hair with a final, explosive burst of fem-spunk.");

			outputText("\n\nAt last, your moist, feminine prison is removed.  Rather than lifted, it's simply dragged south.  [OneCock] nearly catches on her fleshy sack, but it bounces up and over, stroking you with the smooth, sweaty skin as it asses south.  The motion is made all the more awkward by the sight of the centaur's hind legs trying to assist her locomotion, but soon enough she's just on your [legs], the heat of her gash steaming [eachCock] with drizzles of fem-lube. The demoness looks over her shoulder, pale cheeks stained pink with her body's lust as she asks, \"Are you " + player.mf("man","herm") + " enough to mount me?  Or do I need to peg you for encouragement?</i>\" ");

			outputText("\n\nThat gets you to sit up quick.  You aren't sure anyone could take something like that without rupturing something.  Besides, you'd be jumping that twat in a heartbeat as worked up as you are, thread or no.  You stretch forward and aim your [cock " + y + "] into her slobbering twat.  Her fur twists between your fingers as you drag yourself up and in, pulling your torso up onto her back and with such desperation that you nestle deeper inside her, your [legs] partially escaping their weighty imprisonment.  It's an agonizing position to be in, but you will NOT be denied access to the slick caresses of her gushing slit.");

			outputText("\n\nThe pressure on your lower body vanishes, your [feet] raking through the grass before clearing it entirely.  The demon-taur stood up, taking you with her!  You stretch your hands forward for a better grip, securing yourself just in time for her to give a little buck, bouncing you out and in with inertia alone.  Shuddering, you nearly lose your grip as pleasure wracks your body.  Your [cock " + y + "] is getting exactly what it wants, but you're having to work damned hard to maintain your position.");

			outputText("\n\nThe buxom redhead snickers, \"<i>If you can't even stay in my pussy, you're worthless as a mate.  I guess I could use you as a cock-sleeve, but after a few fucks I'd  probably just toss you out.  I don't like my toys once they start to gape, and they start to gape fast.</i>\"  Her balls jiggle against your [legs] as if to emphasize her point.  You whine but wordlessly cling tight.  Her pussy is divine, and your drooling, dribbling dick won't give it up without a fight!  You throb inside her passage, the muscular tunnel rippling and squeezing with every movement she makes.");

			outputText("\n\nLooking back, the demon gives you a knowing smile, while her horn seems to drink the very light around her.  Abruptly, she begins to trot down the path towards an archway.  You hang on, fucking her to the rhythm of her movements.  It isn't even through your own volition that you get to pound at her pussy - her movements utterly control the tempo of the fuck.  Your only choices are whether to hold on and fuck her or let go and be her anal cocksleeve.  With all the aphrodisiacs she fed you, your dick isn't even giving you that choice.");

			outputText("\n\nIn light of your hapless situation, you cling tight and watch as you're given a rampant, dick-squeezingly tight tour of the demons' headquarters. You're taken past masturbating succubi, fapping incubi, and even snickering imps.  All manner of demons sneer at you, the once champion, now a slave to a centaur's sodden snatch.  The sheer, debauched exhibition of it sends a spike of pleasure to your [balls], the upwelling of desire burning with wet heat that seems to dwarf the roaring furnace that is the demon's thighs.  Your burgeoning orgasmic sensation is brought to a screeching halt along with your mistress when she comes to an abrupt stop.");

			outputText("\n\nThen, someone else joins you on the centaur's back - it's an omnibus");
			if (flags[kFLAGS.D1_OMNIBUS_KILLED] != 1) outputText(", and a familiar one at that");
			outputText(".  She wears a black reflective bra, though you swear you can see pink protrusions under the shiny fabric, wriggling around constantly.  As expected with such dress, her nipples are hard as bullets.  A bulbous, ten-inch penis bobs between her thighs, thickening nicely as it fills to its full size, kissing your lips with a moist bead of pre as it fully erects.  The omnibus");
			if (flags[kFLAGS.D1_OMNIBUS_KILLED] != 1) outputText(" overseer asks, \"<i>Remember me?  I thought it only proper that I thank you for letting me live.  Now, be a good boy and suck my dick - show all everyone just what a horny, helplessly fuckable toy you are.</i>\"");
			else outputText(" asks, \"<i>I hope you don't mind slurping down a little cock, because you're going to anyway.</i>\"");
			
			outputText("\n\nThe second herm grabs you by the");
			if (player.hornType != 0) outputText(" horns");
			else outputText(" head");
			outputText(" and sidles forward, ramming her glans into your mouth and down the back of your throat.  You can feel her glans pulsing deep inside you, and as soon as the herm starts moaning, the centaur starts trotting forward again.  Amazingly, having her holding you up makes it easy to maintain your position and keep your dick bouncing in that hot twat. Fuck it! You're too horny to care anymore.");

			outputText("\n\nSlurping hard, you lick and suck the dick in your throat, so busy tending to the omnibus that you barely the notice the throbbing ache in your loins.  You cast lusty, inviting eyes around at every feminine form you see during journey to the stables, located in some backwater, seemingly forgotten part of the fortress.  You quiver with need and explode in passion, moaning into the Omnibus's cock as your " + player.cockDescript(y) + " spends its lust into the oozing horse-pussy, wasting your champion-seed to father nothing more than a batch of shiftless imps.");

			outputText("\n\nThe vibrations of your moans of pleasure set the omnibus alight with delight, and her dick surges deeper down your throat, releasing a thick batch of creamy seed to fill your belly.  Shuddering in bliss, you swallow and cum over and over, spunking up the equine cunt happily while swallowing an equal measure orally.  Locked in cunt and on cock and finally allowed orgasm after an endlessly long tease, you feel as if you're atop an orgasmic wave, riding the spooge all the way into shore.  The hot vice around your dick quivers and squirts thanks to your donation.");

			outputText("\n\nAs your climax-contractions slow, you the omnibi withdraws with a smirk.  \"<i>Thanks, maybe I'll come back to try some of that champion-spunk once my big friend is tired of you.  Then again, maybe I'll just ride your face like the fuckable cunt-hole it is while the centaurs take turns getting knocked up on your worthless fuck-tool.</i>\"");

			outputText("\n\nThe centauress backs you into a wall, clamps snapping shut over your [legs] to hold you in place.  In a panic, you try to wriggle free, but the omnibus easily wrangles your arms into a matching set of restraints.  Once suitably immobilized, she kisses you hard, her ruby lips burning hot against yours for the briefest moment.  It's at this moment that you realize your dick is still rock-solid and ready to go again.  Then, the kiss breaks, and the omnibus wings away.");

			outputText("\n\nAt the same time, your centaur mate steps away, still joined to you by webs of sexual fluid that gradually snap.  As she departs, you realize you're bound up in a stall, tied to a wall, and you swear you can see lines of hooves waiting their turn from under the wood frame.  An albino woman with ivory horns clops in next.  She pivots, and you're given your first glimpse of your second 'wife'.  You've got a lot of demons to inseminate.");

			menu();
			addButton(0, "Next", maleLossII);
		}

		private function maleLossII():void
		{
			clearOutput();
			outputText("As the years roll by, you see lots of pussy, and lots of injections.  They test all kinds of cocktails on you.  Ones that makes your balls swell, or your seed runny, or thick, or even black.  Eventually, one of your children comes out as something other than an imp.  The first proper demon infant.  Too fucked up to feel anything but pride, you can only marvel at your amazing virility as you seed the birth of a new species, knocking up every demon with a cunt in a month-long orgy.  Your jism fuels the ascendency of an entire race, dooming Mareth.");
			getGame().gameOver();
		}
		
	}

}
