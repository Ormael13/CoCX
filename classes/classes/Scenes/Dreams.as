package classes.Scenes {
	
	import classes.*;
	import classes.GlobalFlags.*;

	public class Dreams extends BaseContent
	{
		public function Dreams() {}
		
		//Returns true if needs to END SHIT
		public function dreamSelect():Boolean {
			var inBimbo:Boolean = false;
			if (getGame().bimboProgress.ableToProgress()) inBimbo = true;
				
			var daydream:Number = 0;
			var choices:Array = new Array();
			//dream quantity
			var dreamtemp:Number = 0;
			dreamtemp = rand(player.lib / 10 + player.cor / 20) + player.cor / 20;
			
			//BUILD UP CHOICES ARRAY
			temp = player.humanScore();
			//Add human numbers to choices
			while(temp > 0) {
				choices[choices.length] = 0;
				temp--;
			}
			temp = player.dogScore();
			while(temp > 0) {
				choices[choices.length] = 2;
				temp--;
			}
			temp = player.horseScore();
			while(temp > 0) {
				choices[choices.length] = 1;
				temp--;
			}
			temp = player.cowScore();
			while(temp > 0) {
				choices[choices.length] = 3;
				temp--;
			}
			temp = player.catScore();
			while(temp > 0) {
				choices[choices.length] = 4;
				temp--;
			}
			temp = player.demonScore();
			while(temp > 0) {
				choices[choices.length] = 5;
				temp--;
			}
			//Two chances if addicted, three if with perk!
			if (player.minotaurAddicted()) {
				choices[choices.length] = 6;
				choices[choices.length] = 6;
				if (player.findPerk(PerkLib.MinotaurCumAddict) >= 0) choices[choices.length] = 6;
			}
			//Akbal
			if (flags[kFLAGS.AKBAL_SUBMISSION_COUNTER] > 4) {
				if (flags[kFLAGS.AKBAL_SUBMISSION_COUNTER] > 10) choices[choices.length] = 7;
				if (flags[kFLAGS.AKBAL_SUBMISSION_COUNTER] > 13) choices[choices.length] = 7;
				if (flags[kFLAGS.AKBAL_SUBMISSION_COUNTER] > 15) choices[choices.length] = 7;
				if (flags[kFLAGS.AKBAL_SUBMISSION_COUNTER] > 18) choices[choices.length] = 7;
				choices[choices.length] = 7;
				choices[choices.length] = 7;
			}
			//Exgartuboobs
			if (player.statusEffectv1(StatusEffects.Exgartuan) == 2) {
				choices[choices.length] = 8;
				choices[choices.length] = 8;
				choices[choices.length] = 8;
			}
			//Exgartucock
			if (player.statusEffectv1(StatusEffects.Exgartuan) == 1 && player.hasCock()) {
				choices[choices.length] = 9;
				choices[choices.length] = 9;
				choices[choices.length] = 9;
			}
			//Latexy Skinz
			if (player.skinAdj == "latex" || player.skinAdj == "rubber") {
				choices[choices.length] = 10;
				choices[choices.length] = 10;
				choices[choices.length] = 11;
				choices[choices.length] = 11;
			}
			//Dom + Scylla
			if (flags[kFLAGS.NUMBER_OF_TIMES_MET_SCYLLA] > 0 && flags[kFLAGS.DOMINIKA_STAGE] > 0) {
				choices[choices.length] = 12;
				choices[choices.length] = 12;
				choices[choices.length] = 12;
				if (player.hasCock() && player.cor > 50) {
					choices[choices.length] = 13;
					choices[choices.length] = 13;
					choices[choices.length] = 13;
				}
			}
			//Halloween
			if (isHalloween()) {
				choices[choices.length] = 14;
				choices[choices.length] = 14;
				choices[choices.length] = 14;
			}
			if (getGame().anemoneScene.kidAXP() >= 40 && player.lust >= 70 && player.gender > 0) {
				choices[choices.length] = 15;
				choices[choices.length] = 15;
				choices[choices.length] = 15;
			}
			//Sand trap
			if (player.sandTrapScore() >= 2) {
				choices[choices.length] = 16;
				choices[choices.length] = 16;
				choices[choices.length] = 16;
				choices[choices.length] = 16;
			}
			if (player.mouseScore() >= 3) {
				choices[choices.length] = 17;
				choices[choices.length] = 17;
				choices[choices.length] = 17;
				choices[choices.length] = 17;
			}
			if (player.bimboScore() > 0 && inBimbo) {
				temp = player.bimboScore();
				while (temp > 0) {
					choices[choices.length] = 18;
					temp--;
				}
			}
			
			//INTRODUCTIONS
			if (dreamtemp <= 5) outputText("\nYour rest is somewhat troubled with dirty dreams.\n", false);
			else if (dreamtemp < 15) outputText("\nYou have trouble relaxing as your mind wanders, dreaming of ", false);
			else outputText("\nYou barely rest, spending most of the time touching yourself and dreaming of ", false);
			
			//LUST CHANGES
			//Well adjusted cuts gain in half!
			var dreamLust:Number = dreamtemp;
			
			// Lusty increases by 1/3rd
			if (player.findPerk(PerkLib.Lusty) >= 0) dreamLust += (dreamtemp / 3);
			
			// Well Adjusted cuts by half
			if (player.findPerk(PerkLib.WellAdjusted) >= 0) dreamLust = (dreamLust / 2);

			if (dreamLust > 0) dynStats("lus", dreamLust);
			
			//ACTUAL DREAM TEXTS
			if (dreamtemp > 5) {
				//Roll for dream!
				daydream = choices[rand(choices.length)];
				//normal fantasies...
				if (daydream == 0) {
					if (player.cor <= 33) { 
						//randomly 1 of two simple fantasies.
						if (rand(2) == 0) outputText("tender sex with a sweetheart back home.  ", false);
						else {
							outputText("beautiful nude ", false);
							if (player.gender <= 1 || (player.gender == 3 && rand(2) == 0)) outputText("women ", false);
							else {
								outputText("men ", false);
								if (inBimbo) player.orgasm('Vaginal',false);
							}
							outputText("massaging you, slowly moving their hands over your most intimate places.  ", false);
						}
					}
					if (player.cor > 33 && player.cor <= 66) {
						outputText("being violently raped and used by demons.  ", false);
						if (inBimbo) bimboWetDreamOrgasm();
					}
					if (player.cor > 66) {
						dreamtemp = rand(5);
						if (dreamtemp <= 3) outputText("giving yourself to the demons fully, allowing yourself to be tied down and owned as your body is warped for their twisted pleasures.  ", false);
						else outputText("being captured and taken to a rusted building with dark smokestacks that belch sweet purplish smoke.  Inside are rows of multi-dicked, huge breasted humans, approximately thirty of them.  Each is shackled with their legs spread and torso bent over, and each has tight fitting suction tubes fitting over their tits and cocks.  Every set of tubes is pulsing with suction, drawing rivers of sticky white fluids from its slave's over-endowed breasts and balls.  You shudder in horror and arousal as you realize the victims seem to be arranged by age, ending with an empty machine next to the youngest slut-cow.  The inhuman strength of your captors easily overpowers your struggles as you are forced into your shackles, the metal locks clicking with finality.  A funnel is forced into your mouth, force-feeding you slick corrupted fluids that taste like sex and make your head swim.  Your vision fades as you feel heat in your chest and groin, making you swoon from the drugged cocktail and pleasure of your new best friends – the suction tubes. All you can hear is your own desperate moans... no, wait... that was a dream... but it was so twisted and hot that you're still panting with lust.  ", false);
						if (inBimbo) bimboWetDreamOrgasm();
					}
				}
				//canine
				else if (daydream == 2) {
					//Male-ish dreams
					if (player.gender <= 1 || (player.gender == 3 && rand(2) == 0)) {
						if (rand(2) == 0) outputText("locking a thick knotted cock inside a female, the pheromones of her heat making your maleness twitch and flex, the knot bulging obscenely as you begin to impregnate her.  ", false);
						else outputText("stroking a knotted doggie-prick, gently stroking and squeezing it, yipping in pleasure as your pointed dog-cock leaks steady streams of fluids.  ", false);
					}
					//female
					else {
						//heat dream!
						if (player.inHeat) {
							outputText("being pregnant, your belly bulging obscenely with the fruits of all your frequent copulations, and your breasts swollen with breast milk.  You imagine your condition enhancing your libido, driving you seek out sexual partners willing to pleasure your distorted form.  ", false);
						}
						//normal dream
						else
						{
							outputText("being in heat, your cunt sopping wet with moisture and desire, intense pheromones pouring off you to make all the males rigid and ready.  ", false);
						}
						if (inBimbo) player.orgasm('Vaginal',false);
					}
				}
				//horse
				else if (daydream == 1) {
					if (player.gender == 1 || (player.gender == 3 && rand(2)==0)) outputText(" running the plains with a harem of beautiful centaur fillies.  Your bloated equine endowments swelling with blood at the sight of their fertile backsides and potent pheromones.   You dream of staying up half the night to service your animalistic brides insatiable desires, plugging them over and over until your baby-batter is running in steady streams from their backsides.  ", false);
					else outputText("running your own farm, complete with a stable of docile, horse-morphed studs.   Of course each had to be captured as he came through the portal, until you had enough studs to keep your cunny happy and your womb filled with equine-spunk.  You saunter out to the barn and smile at the immediate reaction your presence has on your livestock, their leering eyes glued to every curve of your nude body.   Each of them lines up, guiding their rapidly hardening shafts through specially crafted holes in the stalls.  You giggle as your oldest acquisition struggles, trying to get the massive flare of his head through the hole before it gets any bigger.  You dream of walking down the aisle, granting each stud the release he so desires, taking the largest and most worthy to feed your tainted womb's thirst for hot spunk.  ", false);
				}
				//cow
				else if (daydream == 3) {
					if ((player.gender == 1 && player.biggestTitSize() >= 5) || (player.gender == 3 && rand(2) == 0)) {
						outputText("having full and lactating breasts, searching for the right person to give your milk to.  You come across a pretty human girl and invite her to your breast.  She eagerly jumps into your arms and starts to suckle from your ample bosom.  You then guide your erect " + player.cockDescript(0) + " into her waiting lower lips.  The two of you stand there in eternal bliss as she suckles on your chest and you thrust into her womanhood, until you wake from the dream.  ", false);
						if (inBimbo) player.orgasm('Tits',false);
					}
					else if (player.gender >= 2) {
						outputText("wandering through the forest, cradling your full and lactating breasts, searching for the right person to give your milk to.  You come across a cute human boy and invite him to your breast.  He eagerly jumps into your arms and starts to suckle from your ample bosom.  You then guide his erect cock into your " + player.vaginaDescript(0) + " and engulf him.  The two of you stand there in eternal bliss as he suckles on your chest and thrusts into your womanhood, until you wake from the dream.  ", false);
						if (inBimbo) player.orgasm('Tits',false);
					}
					else if (player.gender == 0) {
						outputText("wandering the forest, carrying full and lactating breasts.  You spot a creature of the forest looking down at you, but you feel no fear, only contentedness as you invite the creature to suckle from your breasts.  It eagerly jumps out of its hiding place to lick and suck at your full breast, before soon running back off into the woods.  You continue your wonderings, and meet many more creatures.  Each one you meet comes to you and begs you for its daily milk.  It fills you with great satisfaction to feed them all, and you feel that they would do anything for you if you asked them to.  It is a state of eternal bliss, until you wake from the dream.  ", false);
						if (inBimbo) player.orgasm('Tits',false);
					}
					else outputText("roaming the mountain-sides while you hunt for a mate, your turgid shaft and swelling balls aching with the need for release.  ", false);
				}
				//cat
				else if (daydream == 4) {
					//FEMALE
					if (player.hasVagina() && (!player.hasCock() || rand(2) == 0))
						outputText("being a full cat and getting pounded by another as you mewl with pleasure.  He comes and pulls out, the barbs on his cock rake your insides as you yowl from the sensation. You clean yourself before searching for another cat to pound you, then another, and another...  ", false);
					//MALE
					else
						outputText("prowling through the forest as a cat.  One dream in particular has you encountering a female cat in heat, and filling her womb to the brim with cum as you rake her insides with the barbs on your cat-cock. You dream that you impregnate every female you come across, making sure you fight off any competing males...  ", false);
				}
			
				//demon
				else if (daydream == 5) {
					outputText("being used and abused by demons of all varieties.  ", false);
				}
				//minotaur cum
				else if (daydream == 6) {
					outputText("the many encounters you've had with minotaurs.  You shake, cold sweat on your brow, a pit of emptiness in your stomach, and a seething fire in your loins.  You don't know how long you lie there, but gradually, somehow, dreams overtake you and the cramped isolation of your camp falls away to reveal a sweeping vista.  Halfway up the slope of a mountain, the way down the sheer cliff face is a dizzying descent of jagged rocks.  The plateau you find yourself on is fairly wide and is populated by a great many caves that wind down, deep into the mountain's core.  There is a strange sense of familiarity to this place, as if you... belong here.\n\n", false);
					outputText("Your presence does not go unnoticed.  The owners of the caves step out of the shadows and you find yourself surrounded on all sides by the hulking, vulgar forms of minotaurs, their titanic cocks stiffening while their overfull balls sway heavily between their legs.  You don't remember how you got up here, but there is no way out.  A thrill of panic shoots up your spine and you try to call for help, but your voice catches in your throat, barely more than an impassioned whisper.  Then, they are upon you.  Coarse hands grab your arms and hips, throwing you into the small circle at the center of the mob, the oafish beasts crowding against each other to surround you.  They loom impossibly tall over you, the corded muscles of their barbarous chests hiding their faces from you, but you can hear them snorting in perverse impatience as they scuff their hooves on the ground, the flesh of their profane shafts engorged and straining in the air around you.\n\n", false);
					outputText("The minotaurs grab their dicks and begin jerking themselves off, pumping their bitch-taming rods frantically, their unseen eyes boring holes of lustful desire through your body.  Alarmingly, you seem to have lost your " + player.armorName + " to the monstrous men, your nude body bare to their lascivious, rutting needs.  You huddle against the ground, fearful of the bulls' ejaculate, but something is wrong.  Despite their best efforts, none of the cocks swarming around you are releasing their seething seed.  You push yourself up to a sitting position and, hesitantly, reach a hand out to one of the shafts, its deeply-veined trunk bulbous and pulsing.  Placing the lightest touch of your fingers on the cylindrical tip, the minotaur immediately reacts, jerking his hands down to the base of his shaft, his cockhead flaring outward in a fleshy bulge that pushes the tip of his urethra out in a gaping, mouth-like pucker. You barely have time to blink before the minotaur's orgasm bursts forth, hot streams of creamy spunk lancing through the air to splat wetly on your face in sticky ropes.  You recoil as the monster's jizz pours from its arm-thick cum pump, the spurting cascade white-washing your " + player.chestDesc() + " with the pale, liquid alabaster of his desperate need.\n\n", false);
					
					outputText("The deluge from his straining flesh tube slows and you sputter, trying to wipe the tainted, milky pearls from your body when the smell of the semen wafts into your nostrils.  An all-too-familiar weakness creeps into your limbs, addictive pheromones burning a depraved path from your nose directly into your brain, conquering your feeble will.  Panting, sweat beading on your brow, you try to hold back, but the feral potency of the bull-men has subdued your fear and outrage, leaving only a domesticated need to serve.  No longer the master of your body, your arms reach out and stroke more of the surrounding cocks, coaxing each one to fountain you with polluted, ivory loads, the pallid ambrosia lacquering your " + player.skinFurScales() + ", coating you in the savage seed of your masters.  You gratefully turn up your head to catch the full brunt of the torrid geysers with your face, syrupy cream rolling down your nostrils and filling your mouth until it runs over.\n\n", false);
					outputText("You realize, at last, the bestial intelligence in the minotaurs.  They did not simply take you, though you were unarmed and outnumbered.  Instead, they let your own weakness doom you - a willing slave to the ecstasy of their loins.  As you grasp at the melon-sized balls churning all around you, begging for ever more of their nectar, a distant, fading voice begs you to hold out, to escape.  That final thought is driven away as the sublime arms of your masters lift their freshly broken cum-dump high into the air.  They crowd so tightly that they seem to be holding you over a sea of straining phalluses, spunk still bubbling from their engorged tips.  The palpable need to breed you ignites the bodies of your animalistic tyrants with smoldering heat.  Then, as time seems to slow down around you, they thrust your tamed body down, jamming endless inches of minotaur cock deep inside the latest of their submissive cock-sleeves...\n\n", false);
					outputText("You awaken from the vivid dream at the sensation of penetration, lurid images slowly fading in the morning light.  Yet, somehow, you can still just barely smell the blissful odor of minotaur spunk.", false);
					outputText("\n", false);
					if (inBimbo) bimboWetDreamOrgasm();
				}
				else if (daydream == 7) {
					outputText("grinding your rear into his thick cock, your hand reaching behind you to caress Akbal's cheek.  Having his prick between your ass is almost too distracting, but you know you have a duty to perform.  You raise your hands and address the acolytes before you, kneeling and observing.\n\n", false);

					outputText("\"<i>It is glorious to obey our lord,</i>\" you moan out, shivering as you rub against his muscled chest.  \"<i>Our god.</i>\"  Simply being in his presence makes you shiver.  His erect cock has not diminished in the slightest as you work it with your cheeks.  \"<i>Give exaltations unto him,</i>\" you gasp out, \"<i>give his desires unto him.  Fear his wrath!</i>\"  You moan, nearly cumming as you work yourself up.  Focusing carefully, you whisper the next words into the minds of the acolytes.  But love his gifts.\n\n", false);

					outputText("Akbal's strong hand rests on your shoulder.  You nearly leap in excitement, but allow yourself to be bent forward over the altar.  \"<i>You please me, Buttslut,</i>\" the Lord of Terrestrial Fire whispers in your mind.  It is both title and name, the most important office in the one true religion.  He honors you with his cock, spreading your asshole around him and entering you deep.\n\n", false);

					outputText("You cum.  You scream in glorious and divine pleasure, granted by your immaculate god.  The acolytes watching masturbate themselves, in awe of the raptured orgasm Akbal has granted you.  Your tongue lolls out as he pounds into you, the haze of delight briefly devouring your thoughts in all-consuming green fire.\n\n", false);

					outputText("\"<i>Glory unto Akbal,</i>\" Buttslut whispers.\n\n", false);

					outputText("You awake with a start, grumbling slightly before turning over and trying to get back to sleep.  Your asshole twitches.", false);
					if (inBimbo) player.orgasm('Anal',false);
				}
				//Exgartuboobs
				else if (daydream == 8) {
					outputText("drifting through darkness to arrive at your lover's bed.  She purrs and beckons you over, almost entirely hidden behind her massive chest.  You grunt slightly, and between your legs your cock rises, rises, rises - growing in measurements of feet rather than inches.  Excited and eager she moans as you enter her cleavage, thrusting into the ample soft flesh eagerly.\n\n", false);

					outputText("Her hands stroke her tits, encouraging you to push in deeper, harder.  She jiggles the overabundant flesh, sending comfortable ripples down all of her obscene cleavage.  \"<i>Harder,</i>\" she pants out eagerly, \"<i>harder!</i>\"  You grunt and pound, gripping onto her huge nipples to brace yourself.  Under her chin your cockhead bursts up, grinding into her neck and making her gasp excitedly.\n\n", false);

					outputText("Eventually you cum, splattering your spunk all across her features and the top of her tits.  It runs down the massive flesh in slow dribbles, dimples in the enormous bust causing the spooge to puddle slowly.  Licking her lips, she grinds the cum into her breasts before pausing.  Looking at you carefully, she speaks.  \"<i>So, is this your dream?</i>\" Exgartuan asks.  \"<i>Or mine?</i>\"\n\n", false);

					outputText("You awake with a start.  Your " + player.breastDescript(0) + " jiggles grumpily.", false);
				}
				//Exgartucock
				else if (daydream == 9) {
					outputText("drifting through darkness to you arrive at your lover's bed.  He smiles and strides forward confidently, gently pressing his massive cock into your stomach and easing you down.  A few spurts of pre-cum sink into your chest, causing it to swell and round.  \"<i>I thought you'd like to match,</i>\" he says charmingly, as his humongous cock is eclipsed by your ballooning tits.  You smirk coyly in return.\n\n", false);

					outputText("Hands roaming across your growing bust, you eagerly jiggle it against his prick.  The steaming meat resting in your cleavage feels less like an invader and more like a prisoner, trapped between your massive mounds.  He obviously appreciates your efforts, groaning and grunting as he thrusts into your overwhelming titflesh.  Thick as it is, you can easily feel every vein and bulge in his shaft as it pushes past your sensitive mammaries.\n\n", false);

					outputText("The titfuck feels fantastic, your over-inflated chest burning with sensation along every inch of their fullness.  Your lower body is completely hidden from view, and you couldn't reach out and grab your partner if you tried.  Only rarely in his eager thrusts does his cockhead emerge from between your cleavage, more usually plowing into your bosom and remaining hidden.  Eventually the pleasure from the act grows to be too much for him, and cum splatters all through your squeezed-together tits.  It erupts and flows out of your cleavage, running down your breast.\n\n", false);

					outputText("Your partner licks his lips and sighs in slow release, before pausing.  Looking at you carefully, he speaks.  \"<i>So, is this your dream?</i>\" Exgartuan asks.  \"<i>Or mine?</i>\"\n\n", false);

					outputText("You awake with a start.  Your cock flops over grumpily.", false);
				}
				//Rubber/Latex Skin
				else if (daydream == 10) {
					outputText("your lips swelling with a single breath.  No, more precisely, they inflate.  They grow, and they stretch, and your mouth opens into an O.  You fall, fall, fall backwards, landing on your resilient posterior and bouncing lightly.  As you stare at the ceiling, your arms curve up at the elbow, rigid and unmoving.  You do not blink.\n\n", false);

					outputText("Eventually, someone enters the room.  They pull you into a sitting position, and then shove their cock into your big, O-shaped lips.  Your body squeaks as they piston into your rubber hole, and eventually dump their load inside of you.  They let go, and you fall back.  Later they return, pick you up and put you on your chest.  The rubber of your asshole stretches around their dick, tight but yielding to a superior force.\n\n", false);

					outputText("Like before, you drop to the ground after, used.\n\n", false);

					outputText("So it goes, the cycle repeating.  Eternally making your plump O face, unmoving without prompting, and discarded.  The latex sex doll in an unknown harem.  Did they ever know you were once a mortal?\n\n", false);

					outputText("You awake from your dream panting slightly, but not sweating.  You don't do that anymore.\n\n", false);

					outputText("You're not certain how to feel about that.", false);
				}
				//[Player has latex skin] (Z)
				else if (daydream == 11) {
					outputText("dodging your foe's attack expertly, continuing a battle.  No faceless, featureless demon horde will get the best of you.  Deflecting assaults from all sides, you have never felt more powerful.  Yet an odd hiss distracts you.  Glancing behind, you see that a single lucky blade has rent a hole in your shoulder, through which air rapidly escapes.\n\n", false);

					outputText("You stumble, attempting to keep your footing.  Already your legs waver and threaten to fall in on themselves, unable to support your weight.  You try to raise your " + player.weaponName + ", but your fingers feel increasingly boneless and lethargic.  Your hands go limp as you fall to your knees.  Your voice doesn't come, rushing out the gash in your back with the rest of the air.  A uselessness consumes you, as though every single muscle has failed at once.\n\n", false);

					outputText("An opponent is behind you now, pressing down on your legs and forcing the air out.  The hiss gets louder as they gather around and encourage the process, until you lay almost entirely flattened against the ground.  Starting at your toes they roll you up, squeezing the final puffs out and leaving you even more helpless than before.  They drop you into a pack, and your compressed form bounces slightly as they travel.\n\n", false);

					outputText("You awake from your dream panting slightly, but not sweating.  You don't do that anymore.\n\n", false);

					outputText("You're not certain how to feel about that.", false);
				}
				//Scylla + Dom
				else if (daydream == 12) {
					outputText("strange things.  Not of faces, of people you know, of places you've been and words you have spoken.  You dream of mouths.  Lush lips gliding over your body, tongues pressing into intimate locations.  Your eyes closed, you bask in sensation, enjoying the oral administrations of more mouths than make sense.  They rub together, grinding closer as rows upon rows of full puckers kiss at you.  Each individual finger is sucked upon.  Every muscle is caressed.\n\n", false);

					outputText("Lips and mouths crowd around your crotch in particular.  They press in, grinding their fullness into every inch they can.  Wet suction consumes you, though the competing maws cannot pull you into a single hungry mouth.  So they continue to kiss, and lick.  Their tongues curl behind your ears, along your neck, against your asshole.  Affectionately, and adoringly, their attentions seem to have no end.  Even when you cum, splattering across unseen cocksuckers and cuntslurpers, they keep at it.\n\n", false);

					outputText("They don't stop until you finally awaken, roused by a quiet lust.  You did not once open your eyes during the dream, but you are left with the sense that despite all the mouths upon you, there were in fact only two.  One with lips of a midnight darkness, the other like shining rubies.", false);
				}
				//Scylla + dom + dong
				else if (daydream == 13) {
					outputText("reclining contently in your seat, rubbing your chin in thought.  Besides the wet sounds of lapping tongues and the desperate \"<i>Ahn... a-aah... ahhhn...</i>\" coming from between your [legs], the room is silent.  It causes the administrations of your ballpolishers to operate with greater clarity, the careful ruminations of their tongues intricately felt upon your skin.  You reach down to stroke a leather-bound head, eventually sliding your fingers into the finger straps along her scalp. From this firm grip she cannot stop you from lifting her.  Her red lips hang open and gasping as you look at her, the only body part not tightly restricted by the thick, cumstained leather.  It's amusing to see her so desperate and needy - even if this is how you always see her.");
					outputText("[pg]You push her back down, grinding her face and those lush cockpillows into your crotch.  It shoves her partner aside rudely, and you decide to manhandle her as well.  A single handle rises straight up from the back of her hood, blonde hair falling out of the top.  Your fingers fit comfortably around the ridges and further solidify your grip.  Her tongue still sits on her dark lips, and you can almost see your ballsweat glistening on it.  A shuddering, whimpering groan comes from the back of her throat.  She's hungry, of course.  They're both always hungry.  You saw to that and fucked every last little bit of their voice out of their throats.");
					outputText("[pg]Taking a head in either hand, you lift them and mash their lips around your head.  Red and black grind together sloppily, spilling saliva down your dick as they mush softly and fatly against each other.  Hungry gulping overtakes them, fighting and struggling to be the one to consume your shaft and devour your spunk, singlemindedly obsessed with the sole dick between them.  Your fingers grind into their leather hoods happily as they struggle, neither able to get any ground and continuing to massage your shaft with their overfull cocksuckers.");
					outputText("[pg]It's a fitting look for the two of them, and you're quite pleased with yourself for breaking them down.");
					outputText("[pg]You awaken then, erect and frustrated.  The wet smacking of hungry maws lingers in your mind.  Lights above, it would be good to just throatfuck the shit out of someone.");
				}
				else if (daydream == 14) {
					outputText("waking in the middle of the night, your camp flooded with the pale fragile moonlight.  Shadows hiding just beyond your eyesight as you try to adjust to the low light.  The blurred shapes of the shadows seem to crawl and move as if alive.  A faint yellow light flashes like a wisp in the distance.  You rub your eyes as if to cast off the haze of the night.  Started by another flash, you get up from your bed, looking for your equipment.  Rummaging through your belongings hurriedly, the wind blows through your [hair], carrying a noise to your ears.  You turn your head to see nothing. Did the wind make that noise or...?  A tingling on your leg makes your hand snap to it, making a wet noise as you feel something moist on your body.  You smear it over your fingers and bring it to your nose to smell.  It's blood, though you don't remember getting injured there... but it's possible you forgot.  Did you?");
					outputText("\n\nA snap of a twig nearby makes it clear you aren't alone.  Goosebumps crawl up your skin as you turn to the source, behind a large tree.  You wonder how long it's been there... there is something about it that seems off.  A shadow moves behind the tree; you're fairly sure it was something more than the moonlight confusing your vision.  Summoning your courage, you move towards the tree, fists at the ready since you're unarmed.  You touch your hands to the bark. It's warm... why?  Another snapping noise on the other side of the wide trunk distracts your attention. With a deep breath you move around the trunk to... nothing.");
					outputText("\n\nConfusion overtakes you - the sounds were coming from here!  Something cool touches your shoulder.  Shivering, you reach your hand to the spot to warm yourself.  Your hands meets another, and your head jerks to the side only to see a flaming face carved into a large pumpkin stares back at you, the fires rising out of a wicked smile littered with sharp teeth.");
					outputText("\n\n\"<i>Trick or treat?</i>\"  A hollow voice taunts loudly enough to echo in your ears.  You try not to scream as you remove yourself from its grasp.  Your foot rams painfully against a root, causing you to bleed from your toe.  You land in a pile of leaves on the ground with a curse on your lips and turn your body around in a panic.  The figure stands over you.  The finest of suits cover its body, leaving only the flaming pumpkin for its head.  \"<i>Trick... or treat?</i>\" it asks again as it moves for your laying form.");
					outputText("\n\nYou scream that you don't understand, saying you don't have anything on you.  The figure's hand lazily raises and points a finger skyward.  The moon shines overhead, casting its pale white light down over the branches. Dozens of creatures hang lifeless in its branches as a droplet of blood hits your cheek.  \"<i>Trick...</i>\" is all you can hear over your terrified screams as the figures falls down on you, its hands on your neck.");
					outputText("\n\nYou launch yourself up right, screaming out as sweat covers your body.  You are alone in the middle of your camp, right where you went to sleep. Slowly you realize you must have had a nightmare.  You recall how real it felt as you rub at your neck.  You get to your feet and wince as pain shoots up your leg. Looking down, you see your toe bleeding.");
				}
				else if (daydream == 15) {
					outputText("something unusual...\n");
					getGame().anemoneScene.kidADreams();
				}
				else if (daydream == 16) {
					if (player.gender <= 1) {
						if (rand(2) == 0) outputText("something truly unusual...\nIt is difficult to find deep sleep, your rest tormented by strange desires which pluck at your subconscious and tease at the extremities of your nubile, boy-whore body.  You dream of silk against your skin, of wearing gowns, petticoats and dresses which reveal your thin, smooth arms, of girl's underwear tight against your groin, of moving through parties and bars and blushing whenever a man, a real man, looks at you.  Do they know?  Do they guess?  The thoughts and images are powerfully, shamefully erotic and there is no escaping them; each time you flee or turn away from one you open a door into an even more sexually charged dream.");
						//Male Trap Dream #2: 
						else {
							outputText("something unreal...\nYour eyes slowly open as someone is shaking you, their high pitched voice rings in your ears.  \"<i>Wake up big sis!</i>\"  You turn your head to see a youthful looking little lady shaking you with her small hands.  \"<i>They are going to be upset!  You have to get out of bed!</i>\"  Her eyes seemed moist as if extremely distressed and desperate for you to get up.  With a strangely cute sigh escaping your lips you hop off of the bed. You glance down to realize you are fully dressed in a long frilly dress with cute little ribbons and lace. Your tiny shoes click on the finely polished floor.  Everything seems so much... bigger, or are you... small?");
							outputText("\n\n\"<i>Come on sis, hurry!</i>\"  The young girl pulls on you with surprising strength; you don't have any time to collect yourself as you are tugged along through some sort of mansion.  Various elaborately decorated hallways and rooms flash by you, and you are only able to catch glimpses of each room's contents.  You try not to stumble and trip over your lovely dress as you follow the strange girl.  \"<i>They set everything up nearly an hour ago, but they have been waiting for you, of course.  I reminded you to set the alarm.</i>\" You say something of an apology to the young girl, she seemed so distressed at everything.  You couldn't help but feel guilty.");
							outputText("\n\nThe pair of you enter a room with a spiralling staircase; you are tugged along a bit slower as you descend down with her.  Things grow darker and darker, but you can always see thanks to the light of the candles littering your path.  \"<i>Almost there, I hope they aren't too cross with you.</i>\" she comments as you reach the bottom of the stairs.  She opens the door to a simple stone hallway lit up by candle light.  The only thing in the long hallway is another door at its end.");
							outputText("\n\n\"<i>Hurry up now, they have been waiting.</i>\" she nudges you through the door before closing it behind you.  It's impolite to have people waiting on you, you think to yourself.  Your mind races trying to remember what it is you forgot.  It was important, the young lady was quite upset after all.  Your cute buckled shoes click over the stone as you walk down the hallway, your frilly dress fluttering just above the ground. Stopping just before the doorway your hand reaches out, pulling with a sharp yank of your arm.");
							outputText("\n\n\"<i>It's about time little miss.</i>\" a voice calls from inside as you walk in.  The room is well lit and plush, pillows and cushions scattered everywhere, all lit up by a large chandelier hanging overhead.  However, your attention is on everyone in the room. There are dozens of young ladies with long styled hair in various forms of underwear.  Some are wearing striped stockings up to their thighs, along with all kinds of panties from simple white to frilled with colors.  Some are wearing little bras, and others are wearing lace gloves that extend past their elbows.  There are all kinds of cute designs on their little outfits.  However, you slowly realize that they aren't girls at all... they are all grown men with bodies warped to look like young girls...  a bulge in every panty!");
							
							outputText("\n\n\"<i>You know the punishment for being late miss...</i>\"  They all get up from relaxing in the cushions and walk towards you; you gasp as you take a step back feeling cornered as one grabs you from behind.  \"<i>I told you to set the alarm...</i>\" a familiar voice comes from behind you, you turn your face to see the little lady that guided you down here.  She's just like them! His little erect cock peeks out from under his panties as he rubs it against you making your own little cock squirm with delight.");
							
							outputText("\n\nIt all sinks in now, you are just like them.  As they pull off your fancy, girly clothing your bulging panties come into view and they begin to play with your body in ways that feel so wonderful.  You begin to reach out and play with their little trap cocks as they begin to pound away at your tiny hole.  So many cute little erections around you as you suckle and lick at them all like candy.");
							outputText("\n\nYou awake with a moan, right where you went to sleep in the middle of your camp.  ");
							if (player.hasCock()) outputText("  [EachCock] is fully erect and throbbing.");
							else if (player.hasVagina()) outputText("  Your [vagina] dripping wet with need.");
							outputText("  You shudder as you recall the erotic dream you were just having, a hand caressing your aching loins.");
							if (inBimbo) bimboWetDreamOrgasm();
							//end dream
							//lust increase
						}
						dynStats("lus", 25);
					}
					else {
						//Female Trap Dream: 
						outputText("odd things...\nYou find it difficult to find deep sleep, your rest tormented by strange desires which pluck at your subconscious and tease at your supple tomboy body.   You dream of rough leather on your skin, tough cotton tight upon your [fullChest] and the smell of medicinal alcohol in your nose.  You dream of swaggering down the roads of your old home town, meeting the eyes of everyone you pass, daring them to ask; you dream of haunting bars and parties in a perpetual twilight, sweet talking every girl you see with casual, lust charged ease.  Women want you and men want to be you in the whirl of your sleeping mind.  There is a buzz running through these thoughts and images which energises and stupefies you; you find yourself charging through dream after tantalising dream, exhausting yet somehow never satisfying yourself.");
						dynStats("lus", 25);
					}
				}
				else if (daydream == 17) {
					//(By: The Dark Master)
					//Predator/prey dream is always chosen if the PC is genderless, if they are gendered, 50/50 shot of predator/prey dream or the brood dream.
					//Predator and prey
					//Dream about running from a sexy predator.  Emphasize that you're the prey, they are the predator.  You almost want to be caught, but you're also afraid of being caught.  When you finally are caught, you wake up.
					if (player.gender == 0 || rand(2) == 0) {
						outputText("running in the forest with something on your tail.  Fear courses through your veins as you hurry around the trees, desperately trying to lose your pursuer.  At the same time, a strange excitement fills you; you almost feel like you want to be caught.  That majestic predator wants you, it desires you, and a shiver passes through your body as the thought of what it might do to you if it manages to catch you crosses your mind.", false);
						outputText("You fight back the strange desire, and scramble into a thick grove of trees, hoping that you've managed to evade the strangely erotic creature.  You try to catch your breath while straining your large ears, trying to detect any possible sounds of danger.  The rapid beat of your little heart rings in your ears, and it seems impossible that you could hear anything.\n\n", false);
						outputText("You feel strange, and look down at your body.  Much to your surprise, you find yourself fully aroused right now, and ready for sex, your desire to be caught almost overpowering your fear now.  You look up, and see the eyes of your predator staring down at you, the prey that wants to be caught and used...\n", false);
						//dream ends here
					}
					//Brood Den
					//Dream about living in a borrow and having lots and lots of kids.  Many furred, big eared bodies are running around and you feel the pregnant belly of your mate, or feel your own pregnant belly.
					else {
						outputText("finding yourself in an underground burrow, with many small furred bodies with large ears scurrying around all over.  The place is warm and cozy, while also filled with the smell of mice and sex.  You love it down here, and you love seeing all your energetic children running around and having fun.\n\n", false);
						outputText("You have a great larder, able to feed everyone as much as they need.  It has never been a problem to keep it full.  It's a veritable paradise for a rodent such as yourself.  Then you find your way into the master bedroom and see its massive bed, the site where your great family was brought into existence.\n\n", false);
						
						if (player.gender == 1 || (player.gender ==3 && rand(2)==0)) {
							outputText("Things blur for a moment, and you find your head resting against a pregnant belly, covered in fine fur.  The results of your virility as a father, and soon to be added to the great brood that you helped bring into this world...\n\n", false);
						} else {
							outputText("Things blur for a moment, and you find yourself laying on the bed with your hands wrapped around your heavily pregnant belly.  The product of your fertility and the virility of your great mate, and soon to be added to the great brood you've already brought into the world...\n", false);
						}
					}
				}
				else if (daydream == 18) {
					bimboDream();
				}
				doNext(playerMenu);
				return true;
			}
			return false;
		}

		public function dayTenDreams():void {
			outputText("\n", false);
			if (player.hasCock()) {
				if (player.cor < 50) {
					outputText("Your task completed, you return through the portal to your home.  Exhausted but happy, the sight of your village fills you with a surge of emotions.  Most prominently, and perhaps most enjoyably: pride.  You did it.\n\n", false);

					outputText("You drink and celebrate with your people long into the night, feasting and receiving accolades and praise.  It is a party the likes of which you have never seen, and rightfully so.  Never again will your village be threatened by the demons.  Late in the evening, you arrive at the home of your childhood and greet your mother.\n\n", false);

					outputText("\"<i>Welcome back,</i>\" she smiles.\n\n", false);

					outputText("\"<i>Thank you, Mom,</i>\" you respond, wrapping your arms around her and kissing her deeply.  Your hands take hold of her rear, gripping-\n\n", false);

					outputText("Shocked awake, you blink as the light of your dying fire flickers dimly across the campsite.  That was...\n\n", false);

					outputText("This place is getting to you.", false);
				}
				else {
					outputText("Your task completed, you return through the portal to your home.  Exhausted but happy, the sight of your village fills you with a surge of emotions.  Most prominently, and perhaps most enjoyably: pride.  You did it.\n\n", false);

					outputText("You drink and celebrate with your people long into the night, feasting and receiving accolades and praise.  It is a party the likes of which you have never seen, and rightfully so.  Never again shall your village be threatened by the demons.  Late in the evening, you arrive at the place you grew up in, and greet your mother.\n\n", false);

					outputText("\"<i>Welcome back,</i>\" she smiles.\n\n", false);

					outputText("\"<i>Thank you, Mom,</i>\" you respond, wrapping your arms around her and kissing her deeply.  Your hands take hold of her rear, gripping it in great handfuls and squeezing her possessively.  Nearly throwing her in the bed, you delight in her playful squeals.  Mounting her, you tear away her dress and plunge into her cunt.\n\n", false);

					outputText("\"<i>Oooh, god!</i>\" she exclaims,  \"<i>Such a good boy!  Such a big boy!</i>\"\n\n", false);

					outputText("\"<i>That's right, Mom,</i>\" you grunt, taking hold of her breast and sucking harshly on it.  \"<i>All grown up.</i>\"  You continue to grope her roughly as you pound into her cunt, slapping your balls into her thighs.  Her pussy squeezes you with a mother's love, and you soon find yourself dumping heaping loads of your spunk within her.  You rise, and bring your dick to her mouth so that she can clean you.\n\n", false);

					outputText("As your mother laps at your shaft, coated in her juices, you look confidently down at her belly.  Though you love your mother, you're looking forward to having a daughter, and training her to love you just as much as a mother does. One day, perhaps even to replace her.\n\n", false);

					outputText("You awaken in a sweat.  Fuck.", false);
				}
			}
			else {
				if (player.cor < 50) {
					outputText("Your task completed, you return through the portal to your home.  Exhausted but happy, the sight of your village fills you with a surge of emotions.  Most prominently, and perhaps most enjoyably: pride.  You did it.\n\n", false);

					outputText("You drink and celebrate with your people long into the night, feasting and receiving accolades and praise.  It is a party the likes of which you have never seen, and rightfully so.  Never again will your village be threatened by the demons.  Late in the evening, you arrive at the home of your childhood and greet your father.\n\n", false);

					outputText("\"<i>Welcome back,</i>\" he smiles.\n\n", false);

					outputText("\"<i>Thank you, daddy,</i>\" you respond, wrapping your arms around him and kissing him deeply.  Your hands slip into his pants, lowering-\n\n", false);

					outputText("Shocked awake, you blink as the light of your dying fire flickers dimly across the campsite.  That was...\n\n", false);

					outputText("This place is getting to you.", false);
				}
				else {
					outputText("Your task completed, you return through the portal to your home.  Exhausted but happy, the sight of your village fills you with a surge of emotions.  Most prominently, and perhaps most enjoyably: pride.  You did it.\n\n", false);

					outputText("You drink and celebrate with your people long into the night, feasting and receiving accolades and praise.  It is a party the likes of which you have never seen, and rightfully so.  Never again will your village be threatened by the demons.  Late in the evening, you arrive at the home of your childhood and greet your father.\n\n", false);

					outputText("\"<i>Welcome back,</i>\" he smiles.\n\n", false);

					outputText("\"<i>Thank you, daddy,</i>\" you respond, wrapping your arms around him and kissing him deeply.  Your hands slip into his pants, lowering them and exposing his crotch.  Too excited to control yourself, you drag your lips down his chest before wrapping them around his cock and taking him into your mouth.  You pull him deep, teasing his balls with your lower lip.  Though it isn't necessary to gag - you could have swallowed him easily - you do anyway.  Daddy deserves a show.\n\n", false);

					outputText("His cum splatters into your throat.\n\n", false);

					outputText("You smile with glazed teeth as you straddle him in his bed and mount him.  Some disappointment lingers in you that you didn't just let daddy take your ass then and there, but the prospect of his cum flooding your womb and fertilizing you is too delightful to pass up.\n\n", false);

					outputText("\"<i>Do you like it?</i>\" you ask, before moaning his name.\n\n", false);

					outputText("\"<i>You're a good girl,</i>\" he answers.\n\n", false);

					outputText("His balls gurgle as they fill you.  You squeal in delight and lick his chest, demonstrating your affection.  Clenching him tightly, you make sure not to spill daddy's seed, and imagine giving birth to a sexy, busty daughter, teaching her to love him.  One day, teaching her to replace you.\n\n", false);

					outputText("You wake up in a sweat.  Fuck.", false);
				}
			}
			if (player.cor < 50) dynStats("lus", 10);
			else dynStats("lus", 25);
			doNext(playerMenu);
		}

		public function fuckedUpCockDreamChange():void {
			//Cock Transformation Dream!
			outputText("\n<b>Your dreams come fast and vivid that night...</b>\nYour body feels odd, misshapen... you find yourself walking on all fours.  No, wait, all <i>sixes</i> you correct yourself.  Six large, furry paws and limbs hold you up over a smooth, silvery metallic floor.  The floor is so shiny, in fact, you can make out your reflection.");
			outputText("\n\nYour body is not at all how you remember it... although those memories are fast fading.  Perhaps you were dreaming?  Of course this is your normal body.  You've always had six legs, a powerful furred body, long bushy tail, a wolf-like head... and of course you've always had the two tentacle-like appendages that sprout from your shoulders.  Though your body seems alien at first, you quickly find your mind adapting.  Taking the chance to explore, you pad around the room, your movements flowing naturally as if you'd been in this body your entire life.  Of course you have, you were born this way!");
			outputText("\n\nThe dreams shifts abruptly, and you find yourself in some kind of metallic cave.  Shiny iron and steel cover the walls, floor and ceiling.  You glance around, unsure of yourself for a moment, but this place seems so familiar.  You trot forward, warily.");
			outputText("\n\nA soft \"sssht\" noise comes from one side of the cave as you pass by, and when you go to look, you find a sudden gap in the wall.  You peer inside curiously.  The metal cave seems to continue in here, opening into a massive cavern, in the center if which is a tall, glittering gemstone column.  It pulses and throbs with light, its color shifting from red to blue and back again every few seconds.");
			
			outputText("\n\nAt the base of this column is a figure, clearly feminine, poking at some type of metal book.  Words shimmer across its surface, as if by magic, and disappear just as quickly when the female figure taps on them.  You pad forward, inspecting this new figure.  She stands on a pair of wolf-like paws much like you, but whereas you walk an all six of your limbs, she stands only on the two.  Her four furred arms, however, tap away at the panel quickly, while a small, almost dainty pair of tentacles sprout from the back  of her shoulders.");
			
			outputText("\n\nHer body is curvy and voluptuous although it's concealed beneath some kind of skin-tight suit.  As you approach, the woman turns, her human-like face momentarily startled by your presence.  \"<i>Oh!  Captain!</i>\" she starts, \"<i>I wasn't expecting you down here, Captain.</i>\"");
			
			outputText("\n\nCaptain?  Oh yes, how could you forget?  You're the captain of this... metal cave.  And as a captain, you can give orders...");
			
			//[Next]
			menu();
			addButton(0,"Next",displacerDreamII);
		}
		public function displacerDreamII():void {
			clearOutput();
			outputText("<b>The dream shifts once more.</b>  Gone are the alien woman's clothes.  She now lays naked on the cool metal floor.  A light covering of midnight blue fur runs down her back and sides, but her front is completely smooth tanned skin.  The wolf-like alien giggles softly, clearly trying to keep her voice down.  There must be others like her, or like you around.");
			outputText("\n\nYou urge her to remain quiet before clamping your lips around one of her perky nipples, lavishing it with your tongue.  The alien woman coo's, murmuring, \"<i>Oh, Captain</i>\" repeatedly.  You run your tongue down her body, stopping at her moist cunt... which looks somehow different than you expected.  Rather than pink folds, her slick pussy is colored a cobalt blue.  You blink your eyes a couple times, just to make sure you're not seeing double.  Two hard, dark blue clits peek out from two separate hoods... this woman has two clitorises!");

			outputText("\n\nYour shock is short-lived however.  Of course she has two clits, it would be weird if she didn't, you think to yourself.  You lean down and delve into her cunt, tongue first.  Your long muscle snakes into her body, tasting her insides before slurping back out to tease her outer lips.");
			
			outputText("\n\nThe dream shifts again, she's on all fours, her bushy, wolf-like tail lifted to show off that sweet ass and pussy.  You feel an incessant hardness beneath you and realize your cock is dangling out of its sheathe.  You blink your eyes again... is something wrong with your dick?  At first glance, it appears to be a normal canine dick... but the tip seems to have five grooves along the sides.  When you think about it, you find the tip opening up, splaying out into something resembling a five-armed starfish, with the tips ending in wiggling tendrils, the inner-flesh covered in bumpy nodules that stiffen in the cool air of the cave.  With another thought, the cock returns to its normal, almost-canine like appearance, though it's definitely thicker around the tip than an actual canine dick.  Again, the more you think about it, the more natural this is.  Of course you've always had this cock!");
			outputText("\n\nTurning your attention back to the strange creature in front of you, you step forward, putting your forepaws on her shoulders while you brace yourself with the other four.  She whispers words of encouragement, and you growl some dirty talk back at her.  You line up your shot, and thrust in suddenly, eliciting a muffled \"<i>aaaah</i>\" from your mate.  You pound away, each little thrust making her moan louder and louder until she sinks her front half to the floor, desperately clutching her mouth with two hands to avoid drawing attention.");
			
			outputText("\n\nIn a dreamy haze you continue to fuck this strange, alien woman senseless, delighting in your powerful, dominant body.  The way you tower over her, controlling her with but a command... The way she trembles beneath you, writhing in the pleasure that you bring her.  You're confident that, if you were to stop here, she would beg you to continue.  But it doesn't come to that.  No, you're so wound up, so caught in this feeling of utter dominance that you can't help but thrust away, the need to spill your seed so overwhelming it hinders your ability to think straight.");
			
			outputText("\n\nYou feel the tip of your cock blossom, the five tendrils squirming around inside her sodden box, searching around like blind snakes until they find their target.  The tendrils bear down upon a hard ring of flesh... the woman's cervix!  The tendrils twist around, clamping down on her cervix, eliciting a squeal of pleasure from the woman's throat while you growl your dominance over her.  With your tendrils clamping down like this, you can't thrust as much, but you continue as much as you can with shallow pumps.");
			outputText("\n\nWith a loud, primal growl you thrust in one final time, a bulge at the base of your cock suddenly swelling into a large knot, sealing yourself inside her.  Your tendrils clench even tighter as a blast of hot white cum erupts from the center of your starfish-like cock.  Even without seeing it, you know each and every jet of your jizz is injected directly into the woman's womb.  With both the direct injection and your knot in place, you know she's practically guaranteed to get pregnant, and this drives you even more crazy.  The thought of her belly large and round, full of your offspring floods your mind, which in turn creates another flood of cum to blast into her waiting womb.");
			
			outputText("\n\nThe dream shifts again.  The wolf-like woman pants on the ground below you, her stomach bulging slightly with your very fertile seed.  No doubt she'll be carrying a litter of your children very soon.  You remain firmly knotted inside her, and you're pleased to see that ");
			if (silly()) outputText("k");
			outputText("not a drop of jism has escaped.");
			
			outputText("\n\nA soft \"sssht\" noise comes from behind you, that hole in the metal cave opening up once more.  Curious, you twist around so that you and your alien lover are butt-to-butt, and trot towards the doorway, dragging her along with you, though she's too blissed out to care.");
			outputText("\n\nAs you pass through the doorway, your vision suddenly goes white... and you wake up with a start.");
			player.orgasm('Dick');
			dynStats("lib", 2, "sen", 2);
			menu();
			addButton(0,"Next",displacerDreamIII);
		}

		public function displacerDreamIII():void {
			clearOutput();
			outputText("The details of the dream immediately begin to slip away.  You strain your brain, trying to commit everything to memory, but it slips out of your mind like water through a sieve.");
			
			outputText("\n\nSoon, even the details of the wolf-girl are gone, and you curse silently to yourself.  All you can really remember right now is the metal cave... and the glittering gem-like pillar.  You wonder if such a thing exists in the real world, and then dismiss it.  Such a thing is totally beyond the scope of reality.");
			
			outputText("\n\nAs you settle back in to sleep, you feel a soft squirming beneath the covers.  Lifting the blanket, you can't stop your jaw from dropping.  There, between your legs is a cock just like the one in your dreams, fitting snugly into its purple cock-sock.  You give it a tentative poke, and the canine-like tip again unfurls into its starfish-like head tipped with wiggling tendrils.  How odd... was this the intended effect of the cock-sock?");
			
			outputText("\n\nYou give your <b>new coeurl cock</b> a few tentative strokes, to confirm its verisimilitude.  When you're satisfied it's not just another dream, you sigh and flop backwards onto your bed.  This world just gets stranger by the second... you idly wonder what it would be like on some other world...");
			var x:int = player.cockTotal();
			while (x > 0) {
				x--;
				if (player.cocks[x].sock == "amaranthine" && player.cocks[x].cockType != CockTypesEnum.DISPLACER) {
					if (player.cocks[x].cockType != CockTypesEnum.DOG) player.cocks[x].knotMultiplier = 1.5;
					player.cocks[x].cockType = CockTypesEnum.DISPLACER;
				}
			}
			doNext(playerMenu);
		}
		
		public function bimboDream() : void {
			
			getGame().dynStats("lus", rand(20) + rand(player.sens / 2));
			
			var dreamType:Number  = rand(5);
			var bimboScore:Number = player.bimboScore();
			var intensity:Number = 0;
			if 		(bimboScore >= 8) intensity = 2;
			else if (bimboScore >= 6 && rand(2) == 0) intensity = 2;
			else if (bimboScore >= 4  && rand(4) == 0) intensity = 2;
			else if (bimboScore >= 4) intensity = 1;
			else if (bimboScore >= 2  && rand(2) == 0) intensity = 1;
			else if (bimboScore >= 0  && rand(4) == 0) intensity = 1;
			
			// dreaming of "
			if (dreamType == 0) { // Lips
				
				if (intensity == 0) {
					outputText(" something very sexual. As you wake up, you still feel something tingly on your lips, as if your dream involved tasting something extremely delicious.\n\n");
				}
				else if (intensity == 1) {
					if (rand(2) == 0) {
						outputText("standing before the mirror. You look at your " +player.faceDesc() + ", your gaze is fixed at your lips. You take your lipstick and apply it very thoroughly. You make an O and it's perfect. Your lips are full and pink, glistening with moisture. You are so proud of yourself, ready for the main course.  You walk out and see four doors. You know that there is a treat behind each door, something very delicious, and you lick your lips in anticipation. You pause for a moment, indecisive, feeling how waves of pleasure run through you veins and make your face tingle. Finally you make up you mind and approach the third door. You know very well what you'll see there, and gulp nervously. You turn the handle, and suddenly wake up.  You close your eyes, imagining to be there again, to feel the moisture on your lips, to sense that delicious smell, to suck and gulp that creamy substance, but all in vain. ", false);
					}
					else {
						outputText("walking in the forest. You wander into a damp patch overgrown with beautiful flowers. Mesmerized by strange shapes, colors and smells, you take a deep breath, inhaling a lungful of sweet sent. You want to take the flower with you and grab it to tug away, but your hand feels a vine with a mushroom-like head. You touch a vine gently, musing at its slippery texture. The tip of the head is leaking something gooey and white. Strange thougths run through your head, as you wander what would that substance taste like. You lick your fingers, savoring wonderful musky and sweet taste. You bend on your knees and bring the vine to your lips in anticipation, but then you wake up in disappointment, your heart pounding.  ", false);
					}
				}
				else {
					outputText(" approaching a strange door. You feel familiar tingling all over your face, and you lick your lips as you turn the door knob. You enter a salloon and your eyes are immediately fixed on a huge minotaur cock. It's so gorgeous and tasty! Your feel strong pulsation in your groin as you approach it and instinctively kneel down. From your position on your knees, it looks very massive; it's over two feet long, and has three rings of prepuce spaced around its length. You can just barely span your entire hand around its thickness.\n\n", false);
					outputText("You open your mouth wide and lean forward, taking the thick, spongy head into your mouth. The taste was incredibly strong, and its musk was as thick as the minotaur's dick itself. You moan in pleasure, and start bobbing your head back and forth, taking more and more of the dick into your mouth. You stroke the rest of the cock in time with your sucking. As you work your mouth around the first ring, you opened up the top section of your " + player.armorName + ", freeing up your " + player.breastDescript(0) + ". With each pass, you were able to take more and more of the bull dick down your throat. You caress your " + player.breastDescript(0) + " while moaning around the dick. When you get your mouth around the second ring, the minotaur's cock throbbed sharply, and his cum exploded in your mouth. Your eyes bulged in shock, and you pulled off the cock as quickly as you could, swallowing the first several shots of thick, rich minotaur cum, while the rest shoots all over your face and " + player.breastDescript(0) + ". You wake up in a heat, still feeling strong taste on your mouth.\n\n", false);
				}
				player.orgasm('Lips',false);
			}
			if (dreamType == 1) { // Anal
				
				if 		(intensity == 0) {
					outputText(" something very sexual. As you wake up, you feel tingling sensation around your [asshole], and think of how strangely empty it feels.\n\n");
				}
				else if (intensity == 1) {
					outputText("finding yourself tied to a strange contraption. Your hands are behind your back, and your ass is totally exposed. You feel someone lifting up your skirt and slapping your [ass]. <i>Just look at that slut!</i> You feel how strong hand spreads cheeks of your ass and shudder at the sound of spit. Immediately you feel something cool and gooey on your asshole, you try to turn your head, but it is fixed, and your mouth is gagged. You feel another spit, and numbness start to spread around your [asshole], at the same time making your heart pound faster, as you contemplate what is going to happen. You feel fingers spread the lubricant around, and then sensation changes as something big and hot start pressing the entrance of your [asshole]. You try to scream, but only muffled sound escapes your mouth, and with that sound you wake up. You pant, fully awake, your [ass] clenches. That was only a dream.\n\n");
				}
				else {
					outputText("fighting with Minotaur in a mountain cave. You deflect one blow after the other but your strength fades, and finally you fall on the dirt, too exhausted to fight. On your knees, you mubmle <i>Please</i> in a barely audible gasp, as a monster is towering above you, its massive bull-cock hard. The beastmen hauls you by the neck, quickly strips you of your [armor], baring more and more of your naked flesh. You can hear the slurping of the Minotaur's tongue crossing his lips as he eyes up your [butt], and his free hand quickly reaches out to maul one of your fat, squishy cheeks.  His fingers sink in to the tender, jiggly buttcheek, drawing the surface of it inward as his hand makes a print, and you can physically feel his fingers digging around and playing with the sensitive, slutty flank.\n\n");
					outputText("You bite back a moan and find yourself pressing your hips against his grip, when the Minotaur haul you further up by the hips  bringing your [butt] to his face. The minotaur's broad tongue licks and laps at your [butthole] as you writhe and moan, each lick twice as pleasant as the last, and you feel your [vagorass] clenching and unclenching as your entire hips try to push against the Minotaur's searching tongue. Your body starts to shiver, your asshole quite slick with his saliva as he lets out a approving, rumbling moo - and then he stops, withdrawing his muzzle from your [butt] and its oversized cheeks - which slap wetly back together, your crack still wet with his spit.  A moment later you're hauled back down again, the minotaur's hand wrapping once more around your waist, and it isn't long before his flared head starts to push against the crack between your cheeks, the thick cock demanding entry.\n\n");
					outputText("You can feel his cock pressing deeper and deeper into you.  Any second now he'll hit your [asshole], and you'll be wrapping your insides around that monster cock of his, moaning like a whore for him.  You feel a gush of his pre splatter all over the flesh at the 'bottom' of your ass-crack, dripping onto your asshole, and you bite your lip in preparation. With one swift movement he impales you onto his shaft, forcing himself as far into you as he can manage.  You cry out, and you feel your stomach distending to accommodate his incredible size. Grabbing your ass, he begins to violently pound your backside with his massive member. You can feel he's ready to cum. His thrusts become shorter and faster, and just when you think you can't stand it anymore he starts shooting his sperm into you. Your stomach begins to round out from the sheer amount of bull seed being pumped into your belly. The bull-man relaxes for a moment, then shoves you off of him and to the cold ground. You wake up feeling a strange sense of euphoria washes over your [butt].\n\n");
				}
				player.orgasm('Anal',false);

			}
			if (dreamType == 2) { // Pussy
				
				if (player.hasVagina()) {
					if (intensity == 0) {
						outputText("something very sexual. As you wake up, you feel tingling sensation in your [vagina], and think of how empty it feels.\n\n");
					}
					else if (intensity == 1) {
						outputText("having sex with a beautiful young man back in Ingnam. You lay on your back, your legs spread wide, your [vagina] utterly exposed. As he approaches, you quiver, imagining the immense pleasure of being penetrated by his cock. You close your eyes, feeling how wetness escapes your [vagina]. You utter a stiffled cry as he touches the lips of your entrance. The movement of his fingers sends you in a whirlpool of immense pleasure, you are feeling pulsation in your belly, a desire to be filled. Your [hips] starts to shiver, as he starts to lick your pussy. Your thoughts in disarray, your attention is absorbed by waves of pure extasy, spreading through you body. You hear your own moans, as your [pussy] clenches and your [ass] trembles. You desperately want him inside, and almost cry, saying <i>Please, please, fuck me</i>, but at the same time your own voice makes you wake up. You realize that it was just a dream, somewhat disappointed.\n\n");
						
					}
					else {
						outputText(" being pregnant with a strange creature. You feel a sudden ache of need radiating from your massive stomach. Your belly is so heavy that you can't even get off the ground... you simply lie on your side, panting with desire, as the convulsions start. You don't feel much pain, just a steady, rhythmic compulsion that directs you to breathe steadily and spread your legs as wide as possible. You hardly have to push at all, as the child - no, your child, begins pressing against the walls of your womb, searching for escape. It finds it, and begins the arduous task of squeezing through your cervix, making you gasp with barely concealed pleasure.  It doesn't even hurt; there's only a dull little whisper of happiness followed by a tide of satisfaction.\n\n", false);
						outputText("The head comes first, and your first thought is relief as you see the face of a small, elfin child.  She's slick with afterbirth and pushing her way free. But the greater part is to come.  She pulls her body free, easily twice as large as her human torso. Soft downy fur with long, spindly legs and a bristly tail... she is a centaur! You help as best as you can, proud of your achievement,  exhausted by the ordeal. Knowing her needs, you reveal a breast to her, and she nickers affectionately before latching on, drinking hungrily from your heavily lactating teat. Time pass in quiet, motherly bliss as she drains your breastmilk first from one breast, then the other. Her little stomach bulges slightly, but she does not stop, and you do not want her to. Even with the strange, soothing effect of the pregnancy wearing off, you feel nothing but affection for this child. She plants a sweet kiss on your cheek and you wake up.\n\n", false);
						
					}

				}
				else {
					if 		(intensity == 0) {
					outputText(" something very sexual. As you wake up, you feel tingling sensation around your [hips], and think of how strangely empty it feels.\n\n");
						
					}
					else if (intensity == 1) {
						outputText("fucking a whore back in Ignam. She is laying naked on a bed, her legs spread wide, eyes half-open. She is waiting for you to enter, and you gaze on her wet and inviting pussy. Feeling the sudden urge to touch it, you kneel down and start stroking its lips. You feel how slut pants, her flesh shivers as you move your finger around the clit. Pussy lips gape slightly, the cunt is filled with slicky girl cum. You lower your head and start licking it. The taste of her juice is amazing. She gasps in pleasure as you lick and suck her clit, her pussy clenches. You can feel how her cunt controls her every movement, bringing so much pure joy that she totally lose herself, begging you to fuck her. Her life as cum-dump must be so much pleasurable than yours, so much enjoyable... You wake up, still feeling her sweet taste, and a strange a kind of envy.\n\n");
					}
					else {
						
						outputText("laying on a soft bed in Ingnam. You are naked, your skin very sensitive, and you feel that something is wrong. You reach down and realize that there is a pussy between your legs. You touch it gently, and immediately feel aroused. With other hand you start teasing your " + player.breastDescript(0) + ", feeling how you body start to tingle. You spread your legs involuntary, exposing your pussy even more. Suddenly your hear noises outside the room, the door opens, and young men enters. He is totally naked, and his big cock start reacting to your pussy. As he approaches, you quiver, imagining the immense pleasure of being penetrated. You know that if he knock you up, you'll never recover your manhood again but the thought of being filled with cum make you wet. Your [hips] starts to shiver, as he starts to lick your pussy. Your thoughts in disarray, your attention is absorbed by waves of pure extasy, spreading through you body. You hear your own moans, as your pussy clenches and your [ass] trembles. You desperately want him inside, and almost cry, saying <i>Please, please, fuck me</i>, and he replies <i>Ok, slut.</i>\n\n");
						outputText("With one strong move, he turns you over on your knees, hold you [hips] and start searching your cunt with his cock. Desire drives you mad, as you arch your back, craving for his dick inside. He pushes lips of you pussy apart, and shoves his dick inside, and you cry in mind-melting pleasure, squirting. He pulls out, teasing you, and then pushes in, even deeper than before, and then begin fucking your cunt energetically. You realize that very soon he may cum, and think in horror of the consequenses, but your whorish body betrays you, your [hips] are moving on their own. You moan <i>Please, don't cum...inside..</i>, but he starts holding you even tighter, fucking even harder and deeper. Your heart hammering in your chest, you are terrified about what is going to happen, as you hear how he breath in and with one final thrust push his member as deep inside you as he can. Your whole body shakes, as you feel the liquid warmth fill your womb, his cock pumped so much of it that some even escapes your pussy. With realization your mind halts, and you give in to your lust, screaming as mind-shattering orgasm drawn you in pleasure. He pulls out and goes away, leaving you in a mess on a bed. You lie there, with tears on your eyes, and cum dripping from your pussy, until you realize that it is just a dream. You wake up, and reach down - you don't have pussy. You exhale with relief. What a strange dream..\n\n");
					}
				}
				
			}
			if (dreamType == 3) { // Tits
				if 		(intensity == 0) {
					outputText(" something very sexual. As you wake up, you feel tingling sensation around your [nipples] and feel pressure in your sensitive " + player.breastDescript(0) + ".\n\n");
				}
				else if (intensity == 1) {
					if (player.hasVagina() ) {
						outputText("wandering through the forest, cradling your full and lactating breasts, searching for the right person to give your milk to.  You come across a cute human boy and invite him to your breast.  He eagerly jumps into your arms and starts to suckle from your ample bosom.  You then guide his erect cock into your " + player.vaginaDescript(0) + " and engulf him.  The two of you stand there in eternal bliss as he suckles on your chest and thrusts into your womanhood, until you wake from the dream.  ", false);
					}
					else {
						outputText("wandering the forest, carrying full and lactating breasts.  You spot a creature of the forest looking down at you, but you feel no fear, only contentedness as you invite the creature to suckle from your breasts.  It eagerly jumps out of its hiding place to lick and suck at your full breast, before soon running back off into the woods.  You continue your wonderings, and meet many more creatures.  Each one you meet comes to you and begs you for its daily milk.  It fills you with great satisfaction to feed them all, and you feel that they would do anything for you if you asked them to.  It is a state of eternal bliss, until you wake from the dream.  ", false);
					}
				}
				else {
					if (player.findStatusEffect(StatusEffects.BreastsMilked) < 0) {
						outputText("walking into a large barn, filled with the smells of earth, wood, and grease. A bank of machinery along the wall thrums and pulses as if it's a living creature. A harness hangs limply in the stall, there to hold the occupant in place while they are milked of every last drop.  You exhale slowly and force yourself to step into it.  As you puzzle out the straps, it gets easier and easier to get the rest of the harness into place.  As you snap the last one into position, machinery whirs and pulls it tight, lifting you off the ground and suspending you, facedown.  The breast milk pumps pulse and vibrate on a tray below you, twitching slightly as you hear the machinery activate.\n\n", false);
					}
					else {
						outputText("walking into Whitney's barn.  Your [nipples] are engorged and ready to be taken care of. You see a familiar machinery along the wall easily attach the harnesses and lift up into position, hearing the machinery activate automatically.\n\n", false);
					}
					outputText("In spite of the tightness of your harness, you collect the suction cups and bring them up to your [nipples], letting the machine pull them into the tight cups with agonizing slowness. The machine sucks you inside, the tightness serving only to arouse you further.  The suction pulls the walls of the nipple-tubes tight against your nipples, turning them purple as they swell up like dicks.  Your [nipples] twitch and pulse for but a moment, then unleash a torrent of milk, filling the tubes.  The machinery lurches, struggling to keep up as you flood the tubes.   An alarm starts blaring as milk begins leaking out around the edges.  You can hear footsteps in the barn, and a pair of soft hands hold the cups against your chest. The machinery is shut down, but another pair of hands begins massaging your whorish tits, pumping wave after wave of milk through the tubes, unaided by the machinery.  You practically cream yourself from the attentions of your mysterious helper as the milking continues, so hot and horny that you try and wriggle in your harness to press against them.   After an hour of non-stop squeezing and spurting, your milking is over, and the hands release you.  The cups fall to the ground, and the harness lowers you to the ground.  You wake up, yur [nipples] feel very sore.\n\n", false);
				}
				
			}
			if (dreamType == 4) { // BimboLiqueur
				

				
				if 	   (intensity == 0) {
					outputText("something very sexual. As you wake up, you feel waves of pleasure running through your body. You quite enjoy yourself.\n\n");
				}
				else if (intensity == 1) {
					
					outputText("getting lost in mountains. You climbing up and down, your muscles sore, your mouth dry. You desperately want to drink something, otherwise you'll die of thirst. As you make your way round a large rock, you see a little pond, filled by a stream from above. You run to it, kneel down and start drink water with greedy gulps. It has refreshing taste, and you feel how your strength returns, and with it your whole body starts to tingle from passion. You quickly remove your " + player.armorDescript() + " and bend lower, plunging your face into the liquid, and drinking. You arc your back as your ass is totally exposed, and you are feeling how it becomes bigger, wider. You are feeling the touch of the stone with your nipples, the added weight to your expanded breasts. Your thirst is quenched, and you start washing your body with the water from the pond, feeling how your skin becomes very sensitive. You enjoy your new bigger tits, you fuller ass and rounder hips, until finally you wake up.\n\n");
					
				}
				else {
					outputText(" celebrating your victory. You pour glittering liquid in your glass, and drink, enjoying a spiced scent that paints visions of a slutty slave-girl's slightly-spread folds. You take bottle from the table, open wide and guzzle it down, feeling the fire of alcohol burning a path to your belly.  The burning quickly fades to a pleasant warmth that makes you light-headed and giggly. Everyone stares at you, as you grab a lock of the silken strands and watch open-mouthed while streaks so blonde they're almost white flow down the " + player.hairColor + " hair. It goes faster and faster until your hair has changed into perfectly bimbo-blonde, flowing locks.\n\n");
					outputText("You raise, and begin to sway your hips from side to side, putting on a show for everyone here. You just feel so... sexy.  Too sexy to hide it. Your body aches to show itself and feel the gaze of strangers.  Mmmm, it makes you so wet!  Wait!?  Wet?  You touch yourself between the " + player.legs() + " and groan when your fingers sink into a sloppy, wet cunt. You sigh and run one hand over your " + player.nippleDescript(0) + "s, admiring how sensitive they're getting.  The big breasts start getting bigger and bigger, soft chest-flesh practically oozing out between your fingers as the squishy mammaries sprout like weeds, expanding well beyond any hand's ability to contain them.  The supple boobs still manage to sit high on your chest, almost gravity defying in their ability to generate cleavage.  You pinch a nipple with one hand while the other toys with the juicy entrance of your folds.  Mmmm, it, like, feels too good not to touch yourself, and after your worries, you just need to relax. Sex is so easy and natural!  You lean back and start grunting as you plunge four fingers inside yourself, plowing your wet vagina like no tomorrow. Your clit is throbbing, and you give it an experimental caress that makes your " + player.legs() + " give out as you cum, splattering female fluids as you convulse nervelessly on the ground. You wake up in sweat, you hand on your groins.");
				}
				getGame().dynStats("lus", rand(10) + rand(player.sens / 4));
			}
			
			bimboWetDreamOrgasm(dreamType);
			
		}

		private function bimboWetDreamOrgasm(dreamType: Number = 4):void {
			if (dreamType == 4) dreamType = rand(4);

			switch (dreamType) {
			case 0: 
				player.orgasm('Lips',false);
				break;
			case 1:
				player.orgasm('Anal',false);
				break;
			case 2:
				player.orgasm('Vaginal',false);
				break;
			case 3:
				player.orgasm('Tits',false);
				break;
			default:
				player.orgasm('VaginalAnal',false);
			}
			
		}
	}
}