/**
 * Created by aimozg on 03.01.14.
 */
package classes.Scenes.Areas.Forest
{
	import classes.Appearance;
	import classes.BaseContent;
	import classes.CockTypesEnum;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.GlobalFlags.kGAMECLASS;

	public class BeeGirlScene extends BaseContent
	{
		public function BeeGirlScene()
		{
		}

		//The Queen Bee
		//location: Forest
		//add to exploreForest
		public function beeEncounter():void
		{
			spriteSelect(6);
			//Intro text...
			outputText("As you approach the edge of the forest, a sweet scent wafts into your nose. Tantalizing, teasing, alluring. As you sniff the air, you find yourself following it, as if an invisible hand is pulling you toward its origin.  Little do you know, that is essentially what's happening. The further and further you go, the more heavy the scent grows, as well as a sound. A sound of a buzz, but not in a maddening tone, as if someone is humming. It's a lovely tune, one that would stick in the back of the mind, but not in a bad way.\n\n", true);
			//Chance to avoid the bee or not if smart enough...
			if (player.hasKeyItem("Traveler's Guide") >= 0 && player.inte / 2 > rand(40)) {
				outputText("You suddenly remember a passage from the Traveler's Guide about monstrous bees that lay eggs in unmentionable places.  Of course, a brave champion would face any danger.\n\n<b>Do you proceed?</b>", false);
				//Yes goes to beeEncounterLevel2(), no goes to camp
				simpleChoices("Yes", beeEncounterLevel2, "No", 0, "", 0, "", 0, "Back", 13);
			}
			//If not smart enough, proceed.
			else beeEncounterLevel2(false);
		}

		private function beeEncounterLevel2(clearScreen:Boolean=true):void
		{
			if (clearScreen) outputText("", true);
			spriteSelect(6);
			//Bee appears!
			outputText("That's when she comes into view. A great woman, yellow and black, a Bee-like handmaiden would be the best comparison. She sits atop a great flower while humming her tune, happily picking the petals off of another flower.  Her body is thin, save her abdomen. Her head is more humanoid than bee, with black eyes, antennae, and luscious black lips that glimmer wetly, bending into a smile as she sees you approach. Standing, she welcomes you in, her wings giving a small buzz as her arms spread open for a welcoming embrace.\n\n", false);
			//Exgartuan messes with things!
			if (player.statusAffectv1("Exgartuan") == 1 && player.cockArea(0) > 100 && player.statusAffectv2("Exgartuan") == 0) {
				if (rand(2) == 0) {
					outputText("Your " + cockDescript(0) + " wriggles free of your " + player.armorName + ", as you keep walking forward.  A bodiless voice yells, \"<i>Honeypot, honeypot, ME LOOOOVE HONEYPOOOOOT!</i>\"\n\n", false);
					outputText("The bee-girl's eyes widen at the sight, shocked by your over-endowed form being dragged towards her as if there were a magnet in your " + cockDescript(0) + ".  She presses herself against the flower's petals, terrified and afraid to put up any meaningful resistance.  The nagging voice pipes up, \"<i>So are we gonna rape her or what, " + player.short + "?  I need some honeyyy!</i>\"\n\n", false);
					outputText("She seems too surprised to resist.  Will you go along with Exgartuan and rape her?", false);
					doYesNo(kGAMECLASS.exgartuan.exgartuanBeeRape, 13);
					return;
				}
				else {
					outputText("The bee-girl's eyes widen at the sight,  shocked by your over-endowed form being dragged towards her as if there were a magnet in your " + cockDescript(0) + ".   She flutters into the air and aims her stinger towards you, ready to fight!", false);
					//start combat
					startCombat(new BeeGirl());
					return;
				}
			}
			//Chance to avoid raaaaeeeeep
			if ((player.lib + player.cor < 140) || rand(2) == 0) {
				outputText("You barely stop yourself from gleefully throwing yourself into her arms.  You realize the harmonic buzzing of her wings and the unearthly scent of her honey briefly robbed you of your reason.  Feeling momentarily more clear-headed, what do you do?", false);
				//Choices - fight, talk, seduce, submit, run
				simpleChoices("Fight", 2060, "Talk", beeTalk, "Seduce", 0, "", 0, "Leave", 13);
			}
			else beeEncounterLevel3(false);
		}

		private function beeEncounterLevel3(clearScreen:Boolean=true):void
		{
			if (clearScreen) clearOutput();
			spriteSelect(6);
			//Give into the beeee
			//TAUR SPECIAL!
			if (player.isTaur()) {
				outputText("As if you have lost control of your body, you trot up beside her, utterly entranced by the sweet smell pervading the area. She assesses your strange body, walking in circles around you while stroking you with her chitin covered hands. When she reaches your flank she lifts your tail and traces around your " + assholeDescript() + ", smearing a bit of honey inside and causing you to shiver. The sensation is mind numbing and you find yourself hugging a tree to support yourself. Evidently satisfied with what she's seen, the bee-girl walks in front of you and smears more honey all over the tree you're holding. You lick it without a second thought, the smell quickly overpowering whatever sense you had left. Seeing this, the bee-girl giggles and pats you, moving back toward your flank.\n\n", false);
				outputText("She beats her wings with a visible effort and drags herself onto your back, taking a moment to rest. The soft humming she emits seems to make her whole body vibrate and you delight in the oddness of the sensation. A stinger slowly emerges from her abdomen, as well as a thick knot-like organ, both covered in a sweet smelling lubricant. You don't protest as her stinger injects what feels like liquid lust into you, causing a rush of blood to your hindquarters and your anus to relax completely.\n\n", false);
				outputText("With no warning, she inserts the thick, lengthy appendage and knot inside of you. Her 'cock' slips in slowly, your relaxed sphincter easily taking the entirety while you continue to lap at the copious amounts of honey she so graciously smeared on the tree for you.\n\n", false);
				outputText("Her ovipositor begins to pump even more of the aphrodisiac-like fluid into your rectum as it works its way further and further inside you. She hums louder and the vibrations on your back grow stronger as large spherical objects begin injecting themselves into you.\n\n", false);
				//Route 2 
				if (player.longestCockLength() >= 100 || player.gender == 0) {
					//[Male (bypasses the bucking scene):
					if (player.gender == 1) {
						outputText("You grasp ", false);
						if (player.cockTotal() > 1) outputText("one of ", false);
						outputText("your engorged " + multiCockDescriptLight() + " and jerk it off violently, cumming again and again as the bee-girl violates your " + assholeDescript() + ".  ", false);
						//[Without testicles:
						if (player.balls == 0) outputText("With your cock quivering and spasming you continue to lap at the honey covered tree until the vibrating bee-girl finishes.  ", false);
						//[With testicles:
						else outputText("With your cock quivering and spasming semen erupts from the tip.  ", false);
						//[Little-normal cum amount:
						if (player.cumQ() < 100) outputText("You spurt out more cum than you thought your " + ballsDescriptLight() + " could hold. White speckles the base of the tree and tiny puddles form underneath you as you groan in satisfaction.\n\n", false);
						//[Huge cum amount:
						else outputText("Your " + ballsDescriptLight() + " goes off like a firehouse, coating the base of the tree along with a number of the ones behind it. Soon you're standing in a massive puddle of your own splooge, the scent threatening to overpower that of the honey. The bee-girl compensates by splashing more onto your back, causing you to release yet another burst of thick white cum.\n\n", false);
					}
					//[Herm (bypasses the bucking scene):
					else if (player.gender == 3) {
						outputText("You grasp your engorged " + multiCockDescriptLight() + " and jerk it off violently, cumming again and again as the bee-girl violates your " + assholeDescript() + " and your " + vaginaDescript(0) + " pumps out enough femcum to drench your hind legs.  ", false);
						//[Without testicles:
						if (player.balls == 0) outputText("With your cock quivering and spasming and your untended to " + vaginaDescript(0) + " squirting repeatedly, you continue to lap at the honey covered tree until the vibrating bee-girl finishes.  ", false);
						//[With testicles:
						else outputText("With your cock quivering and spasming semen erupts from the tip.  ", false);
						//[Little-normal cum amount:
						if (player.cumQ() < 100) outputText("You spurt out more cum than you thought your " + ballsDescriptLight() + " could hold. White speckles the base of the tree and tiny puddles form underneath you as you groan in satisfaction.\n\n", false);
						//[Huge cum amount:
						else outputText(SMultiCockDesc() + " goes off like a firehouse, coating the base of the tree along with a number of the ones behind it. Soon you're standing in a massive puddle of your own splooge, the scent threatening to overpower that of the honey. The bee-girl compensates by splashing more onto your back, causing you to release yet another burst of thick white cum.\n\n", false);
					}
					//[Genderless (if gender() = 0?):
					else {
						outputText("The pleasure from your ass is so great your legs buckle and you pass out. The bee maiden continues to pump her fluids inside you as the world goes black.\n\n", false);
					}
					outputText("After hours of her forcefully filling your hole, her stinger pumping what feels like gallons of her bee-seed into your bowels, she finally pulls out. She smiles and lies down on your back and your legs finally give out from exhaustion.\n\n", false);
					outputText("When you awaken, your hind end is covered in honey and what you can only assume is the lubrication from her ovipositor. You stand with a bit of a struggle and notice a thin trail of honey leading away into the undergrowth.", false);
				}
				//Route 1 
				else {
					//[Male:
					if (player.gender == 1) outputText("Your inability to reach your engorged " + multiCockDescriptLight() + " quickly becomes a problem as the pleasure from the bee-maiden's scent courses through you. You ache to be tended to, gushing out pre.", false);
					//[Female:
					else if (player.gender == 2) outputText("Your inability to reach your " + vaginaDescript(0) + " quickly becomes a problem as the pleasure from the bee maiden's scent courses through you, it starts reflexively rippling, trying to milk the cock it so desperately wants while your " + clitDescript() + " quivers.", false);
					//[Herm:
					else if (player.gender == 3) outputText("Your inability to reach your engorged " + multiCockDescriptLight() + " quickly becomes a problem as the pleasure from the bee maiden's scent courses through you. It aches to be tended to, gushing out pre. Your " + clitDescript() + " quivers, desperate for contact as your vagina starts reflexively rippling, trying to milk the cock it isn't going to get.", false);
					//[With breasts: 
					if (player.biggestTitSize() > 1) {
						outputText("  You begin pounding away at your " + kGAMECLASS.player.allBreastsDescript() + " in an attempt to alleviate the pressure in your inaccessible groin.", false);
						//[Fuckable breasts:
						if (player.hasFuckableNipples()) outputText("  Your fingers slip in and out of them, sending femcum flying everywhere. But the effects of the bee's honey appear to prevent you from getting off.", false);
						//[Other:
						else outputText("  No amount of stimulation seems to get you off though.", false);
					}
					outputText("\n\n", false);

					outputText("The stimulation grows too painful and you begin to buck wildly. The bee-girl holds on desperately, her stinger still lodged in your " + assholeDescript() + " and pumping fluids. She seems to realize the problem though and attempts to solve it.  ", false);
					//[Male:
					if (player.gender == 1) {
						outputText("Her legs wrap around your body and her 'feet' clasp onto your " + multiCockDescriptLight() + ". The strangeness of the sensation doesn't register though as just the contact is enough to send you over the edge.  ", false);
						//[Without testicles:
						if (player.balls == 0) outputText("You cum violently, your " + multiCockDescriptLight() + " quivering and spasming.  ", false);
						//[With testicles:
						else outputText("You cum violently, your " + multiCockDescriptLight() + " quivering and spasming while semen erupts from the tip.  ", false);
						//[Little-normal cum amount:
						if (player.cumQ() < 100) outputText("You spurt out more cum than you thought your " + ballsDescriptLight() + " could hold. White speckles your underside and tiny puddles form underneath you as you groan in satisfaction.\n\n", false);
						//[Huge cum amount:
						else outputText("Your " + ballsDescriptLight() + " goes off like a firehouse, coating your underside with white and dripping down your front legs. Soon you're standing in a massive puddle of your own splooge, the scent threatening to overpower that of the honey. The bee-girl compensates by splashing more onto your back, causing you to release yet another burst of thick white cum.\n\n", false);
					}
					//[Female:
					else if (player.gender == 2) {
						outputText("Her legs curl around your hind legs and her 'feet' begin rubbing your " + vaginaDescript(0) + ". The strangeness of the sensation doesn't register though as just the contact is enough to send you over the edge.  ", false);
						//[Tiny-normal clit:
						if (player.clitLength < 3) outputText("Her awkward ministrations to your " + clitDescript() + " cause a gush of fluids from your " + vaginaDescript(0) + " and you let out a lewd moan of satisfaction.  ", false);
						//[Cock-like clit:
						else outputText("She quickly finds your " + clitDescript() + " and begins to jerk it off like a cock.  The sensation is incredible and you moan lewdly as your " + vaginaDescript(0) + " gushes fluid.  ", false);
						outputText("Your hind legs are soon coated in the slick girlcum pouring out of you.\n\n", false);
					}
					//[Herm:
					else if (player.gender == 3) {
						//[Same as male followed by:]
						if (rand(2) == 0) {
							outputText("Her legs wrap around your body and her 'feet' clasp onto your " + multiCockDescriptLight() + ". The strangeness of the sensation doesn't register though as just the contact is enough to send you over the edge.  ", false);
							//[Without testicles:
							if (player.balls == 0) outputText("You cum violently, your " + multiCockDescriptLight() + " quivering and spasming.  ", false);
							//[With testicles:
							else outputText("You cum violently, your " + multiCockDescriptLight() + " quivering and spasming while semen erupts from the tip.  ", false);
							//[Little-normal cum amount:
							if (player.cumQ() < 100) outputText("You spurt out more cum than you thought your " + ballsDescriptLight() + " could hold. White speckles your underside and tiny puddles form underneath you as you groan in satisfaction.\n\n", false);
							//[Huge cum amount:
							else outputText("Your " + ballsDescriptLight() + " goes off like a firehouse, coating your underside with white and dripping down your front legs. Soon you're standing in a massive puddle of your own splooge, the scent threatening to overpower that of the honey. The bee-girl compensates by splashing more onto your back, causing you to release yet another burst of thick white cum.\n\n", false);

							outputText("Thinking you still not satisfied, she pulls her 'feet' up slightly and she begins to rub your " + vaginaDescript(0) + ".  ", false);
							// [Same as female without intro]
							//[Tiny-normal clit:
							if (player.clitLength < 3) outputText("Her awkward ministrations to your " + clitDescript() + " cause a gush of fluids from your " + vaginaDescript(0) + " and you let out a lewd moan of satisfaction.  ", false);
							//[Cock-like clit:
							else outputText("She quickly finds your " + clitDescript() + " and begins to jerk it off like a cock.  The sensation is incredible and you moan lewdly as your " + vaginaDescript(0) + " gushes fluid.  ", false);
							outputText("Your hind legs are soon coated in the slick girlcum pouring out of you.", false);
						}
						//- OR -
						//[Same as female followed by:]
						else {
							outputText("Her legs curl around your hind legs and her 'feet' begin rubbing your " + vaginaDescript(0) + ". The strangeness of the sensation doesn't register though as just the contact is enough to send you over the edge.  ", false);
							//[Tiny-normal clit:
							if (player.clitLength < 3) outputText("Her awkward ministrations to your " + clitDescript() + " cause a gush of fluids from your " + vaginaDescript(0) + " and you let out a lewd moan of satisfaction.  ", false);
							//[Cock-like clit:
							else outputText("She quickly finds your " + clitDescript() + " and begins to jerk it off like a cock.  The sensation is incredible and you moan lewdly as your " + vaginaDescript(0) + " gushes fluid.  ", false);
							outputText("Your hind legs are soon coated in the slick girlcum pouring out of you.\n\n", false);

							outputText("Thinking you're still not satisfied, she lowers her 'feet' slightly and she begins to rub your " + multiCockDescriptLight() + ".  ", false);
							//[Same as male without intro]
							//[Without testicles:
							if (player.balls == 0) outputText("You cum violently, your " + multiCockDescriptLight() + " quivering and spasming.  ", false);
							//[With testicles:
							else outputText("You cum violently, your " + multiCockDescriptLight() + " quivering and spasming while semen erupts from the tip.  ", false);
							//[Little-normal cum amount:
							if (player.cumQ() < 100) outputText("You spurt out more cum than you thought your " + ballsDescriptLight() + " could hold. White speckles your underside and tiny puddles form underneath you as you groan in satisfaction.\n\n", false);
							//[Huge cum amount:
							else outputText("Your " + ballsDescriptLight() + " goes off like a firehouse, coating your underside with white and dripping down your front legs. Soon you're standing in a massive puddle of your own splooge, the scent threatening to overpower that of the honey. The bee-girl compensates by splashing more onto your back, causing you to release yet another burst of thick white cum.\n\n", false);
						}
					}
					outputText("After hours of her forcefully filling your hole, her stinger pumping what feels like gallons of her bee-seed into your bowels while awkwardly dealing with your needs; she finally pulls out. She smiles and lies down on your back and your legs finally give out from exhaustion.\n\n", false);
					outputText("When you awaken, you're covered in honey and what you can only assume is the lubrication from her ovipositor. You stand with a bit of a struggle and notice that in your wild state you seem to have devastated the little clearing, as it's covered with broken trees and trampled plants. A thin trail of honey leads away from the devastation into the undergrowth.", false);
				}
				dynStats("int", -.5, "lus=", 0);
				player.slimeFeed();
				//Anal bee pregnancy!
				if (rand(3) == 0 && player.buttPregnancyType == 0) {
					player.buttPregnancyIncubation = 48;
					player.buttPregnancyType = 2;
				}
				player.buttChange(25, true);
			}
			//NON TAURS
			//Dicked version...
			else if (player.cocks.length > 0) {
				outputText("As if you have lost control of your body, you fall into her arms, happy. As she holds you close, a stinger slowly emerges from her abdomen, as well as a thick knot-like organ, both covered in a sweet smelling lubricant. As your mind synaesthetically sees a myriad of colors and scents, you don't resist as she gently pushes you down to your ", false);
				if (player.isTaur()) outputText(" hocks and knees", false);
				else outputText("stomach", false);
				outputText(". Nor do you protest as she leans over you, her stinger, thank goodness it isn't poison - looming close to your anus.  With no more words she shoves the thick, lengthy stinger and knot inside of you. Her 'cock' slips in slowly, the lubricant keeping you from shaking out of your scent-induced pleasure coma. Your hand even ventures to your own engorged ", false);
				if (player.cockTotal() == 1) outputText("member", false);
				if (player.cockTotal() > 1) outputText("members", false);
				outputText(" as she rather forcefully rapes your once-tight hole, humming her tune all the while.\n\n", false);
				//blow load.
				outputText("After hours of her forcefully filling your hole, her stinger pumping what feels like gallons of her bee-seed into your very bowels, and of you stroking yourself to ejaculation; she finally pulls out. With her stinger still dripping seed onto your back, she smiles while watching you blow your last load into a pool of semen underneath you, before you collapse - exhausted.\n\n", false);
				player.slimeFeed();
				//epilogue
				outputText("You awaken, your nose full of a honey like scent, some strange fluid on your back, and the feeling of something leaking from you.", false);
				player.buttChange(25, true);
				dynStats("int", -.5, "lus=", 0);
				//Anal bee pregnancy!
				if (rand(3) == 0 && player.buttPregnancyType == 0) {
					player.buttPregnancyIncubation = 48;
					player.buttPregnancyType = 2;
				}
			}
			//non-dicked version
			else {
				outputText("Blissfully, you throw yourself into the bee-maiden's arms, entranced by her humming and the sinfully sweet smell of honey that saturates the air around her.  She embraces you softly, humming softly but intently into your ear, vibrating your thoughts into a disjointed mess as you slump nervelessly in her arms.  You are aware of being moved, laying you out on a giant flower as she moves behind you, registering the feel of the smooth chitin that covers her arms as she tenderly rubs you down.   She turns you over, buzzing more of her thought-obliterating tune into your ear as she does.\n\n", false);
				outputText("You lay there, giddy smile on your face, letting the bee-girl straddle and sink something sharp into your thigh.  Lust boils through your veins, ", false);
				//No cooch, talk about being horny, nipples if you got em!
				if (player.vaginas.length == 0) {
					outputText("and you writhe and moan with no source of relief", false);
					if (player.totalNipples() > 1) outputText(", your nipples swollen and red with desire.  ", false);
					else outputText(".", false);
				}
				//Coochie talk!
				else {
					if (player.vaginas[0].vaginalWetness < VAGINA_WETNESS_WET)outputText("centering around your now puffy vulva.  ", false);
					if (player.vaginas[0].vaginalWetness >= VAGINA_WETNESS_WET && player.vaginas[0].vaginalWetness < VAGINA_WETNESS_DROOLING)outputText("growing more potent around your " + vaginaDescript(0) + " as it begins to leak with the honey of your desire.  ", false);
					if (player.vaginas[0].vaginalWetness >= VAGINA_WETNESS_DROOLING) outputText("inflaming your " + vaginaDescript(0) + " with need, and allowing a river of your wetness to gush from between your puffy vulva.  ", false);
				}
				//Boobies!
				if (player.biggestTitSize() > 1) {
					outputText("The cool hardness of her hands startles you as she reaches around to massage your ample bosom, tweaking your hard nipples between her fingers", false);
					//if lactating
					if (player.biggestLactation() > 1) outputText(", humming in surprise as a squirt of milk splatters across the flower's petals.  ", false);
					else outputText(".  ", false);
				}
				//Multiboobs!
				if (player.breastRows.length > 1) {
					outputText("The cool hardness of her hands startles you as she begins running her hands over your many breasts, tweaking each hard nipple between her fingers, leaning around to lick them with her curving sinuous tongue, and humming softly", false);
					//Milk bit
					if (player.biggestLactation() > 1) outputText(" in surprise as a squirt of milk splashes across the flower's petals.  ", false);
					else outputText(".  ", false);
				}
				//Continue as normal!
				outputText("Instinctively, your butt clenches as a wet presence presses tightly against it.  You try to gather your thoughts, but a particularly forceful hum drives them away and totally relaxes you, allowing the bulbous thickness of her ovipositor to slip inside you.   Slowly at first, then with increasing urgency, the bee-girl rocks it further and further inside of you, humming happily and placing a handful of honey before you.   Your tongue darts forwards of its own accord, lapping at the honey", false);
				if (player.vaginas.length > 0) outputText(" as your hand is guided to your " + vaginaDescript(0), false);
				outputText(".\n\n", false);
				//Cum text
				if (player.vaginas.length > 0) outputText("Your fingers dance over your clit as you lap up her honey", false);
				else outputText("Your fingers explore every inch of both your bodies as you lap up her honey", false);
				outputText(", your hips writhing and squirming underneath your insectile lover.  A pressure builds in your ass as fluids begin flowing into your rectum, triggering a body-shaking orgasm that rolls your eyes back into your head.  You come down, but the lust in your veins hasn't dissipated – in fact between being pumped full of honey-spooge", false);
				if (player.vaginas.length > 0) outputText(", the constant aphrodisiac honey you're mindlessly devouring, and your fingers' instinctual ravaging of your " + vaginaDescript(0) + ", ", false);
				else outputText(" and the constant aphrodisiac honey you're mindlessly devouring, ", false);
				outputText("you drive yourself to orgasm after orgasm.  For hours you lie there, licking, masturbating, and allowing your backside to be slowly filled with sweet fluid and the occasional bump of what you can only assume is an egg.\n\n", false);
				//Recovery
				outputText("Eventually you realize she is no longer feeding you honey, and the bee-girl pulls her shriveled organ from your rectum.  She pats you on the head and begins to stagger away, honey dripping from between her thighs and her once bloated rear-abdomen now looking more appropriate for her thin frame.", false);
				dynStats("int", -.5, "lus=", 0);
				player.slimeFeed();
				//Anal bee pregnancy!
				if (rand(3) == 0 && player.buttPregnancyType == 0) {
					player.buttPregnancyIncubation = 48;
					player.buttPregnancyType = 2;
				}
				player.buttChange(25, true);
			}
			doNext(15);
		}

		//Talk to the bee-girl
		private function beeTalk():void
		{
			spriteSelect(6);
			//The first time you only get the option to have eggs laid in your bum ;)
			if (kGAMECLASS.beeProgress == 0) {
				outputText("She stops buzzing, taken aback by your resistance to her wiles.  \"<i>Y-you zzzure you don't want to cuddle with me?</i>\" she stammers, thrusting her exotic black and yellow breasts forwards enticingly.  With some difficulty you manage to pry your eyes back up to her face and ask her why she is trying to tempt you to embrace her.\n\nShe buzzes out a giggle, \"<i>Well where elzzz would I lay eggzzz?  The coloniezzz alwayzzz need more workerzzz, and as one of the Queen'zzz handmaidenzzz I get zzzooooo full of eggzzz...  I promizzze to make it feel gooood if you come to me.</i>\"\n\n", true);
				if (player.cor < 33) outputText("You are sure no good can come of this, but your body is ready to say yes.", false);
				if (player.cor >= 33 && player.cor <= 66) outputText("Her offer intrigues you, and the arousing sweetness of her scent makes it difficult to resist.", false);
				if (player.cor > 66) outputText("Looking at her through lust-tinted eyes, you're sure she can deliver on her offer.  Getting closer to her scent alone would be worth bearing a few eggs...", false);
				outputText("\n\nDo you accept her offer?", false);
				kGAMECLASS.beeProgress++;
				doYesNo(beeEncounterLevel3, 13);
			}
			else {
				//If you get lucky, chance for free honey and -corruption in exchange for lust.
				if (rand(2) == 0) {
					outputText("\"<i>Awww, it zzzeemz you've caught me with my 'pants' down,</i>\" she giggles, \"<i>I'm all out of eggzzz.</i>\"  She pats her smaller-sized abdomen for a moment, thinking.\n\nHer eyes light up with inspiration, \"<i>Zzzince I'm ztill zzzo horny, would you like pure undiluted honey? Itzzz very good,</i>\" she says, spreading her legs and exposing the source of the scent – her puffy black vulva dripping with sticky amber fluid.\n\nDo you collect her honey?", true);
					doYesNo(freeHoneyEvent, 13);
				}
				//If you get unlucky you just get the choice of getting egg-laid.
				else {
					outputText("She cocks her head and asks, \"<i>You again?  Zzzzurely you've come for more of my honey and eggzzz, no?</i>\"  Lightly caressing her swollen abdomen, you see the dripping knotted appendage begin to drop out next to her stinger.\n\n", true);
					if (player.cor < 33) outputText("You are sure no good can come of this, but your body is urging you to agree.", false);
					if (player.cor >= 33 && player.cor <= 66) outputText("Her offer intrigues you, and the arousing sweetness of her scent makes it difficult to resist.", false);
					if (player.cor > 66) outputText("Looking at her through lust-tinted eyes, you're sure she can deliver on her offer.  Getting closer to her scent alone would be worth bearing a few eggs...", false);
					outputText("\n\nDo you accept her offer?", false);
					doYesNo(beeEncounterLevel3, 13);
				}
			}
		}

		private function declineBeeTalk():void
		{
			spriteSelect(6);
			outputText("She pouts and returns to her sing-song buzzing.  Her fingers trace circles between her thighs and the sweet scent intensifies.  You beat a hasty retreat before her efforts overcome your reason.", true);
			dynStats("lus", (20 + player.lib / 15));
			doNext(13);
		}

		private function freeHoneyEvent():void
		{
			spriteSelect(6);
			player.slimeFeed();
			outputText("You mull her offer over for a moment before deciding to pursue the sweet nectar dripping from her exposed sex.  She leans back in her flower, spreading her legs obscenely and pulling an empty vial out from a tiny pack that sits on the ground.\n\n", true);
			outputText("\"<i>Here, take thizzz,</i>\" she says, handing you the crystal vial, \"<i>When I cum you will want to zzzave the excess honey... once it has cooled, it will be able to do amazzzing thingzzz to... for you.</i>\"\n\n", false);
			outputText("You take the vial absently as you kneel between her legs and take in deep breaths of the scent.  It fills your head and groin with its warmth and sticky sweetness.  You part your lips, leaning ever closer to her delicate flower, tensing with anticipation.  When your tongue finally meets the slickened surface of her vulva you swoon.  The taste is better than anything you've ever experienced - sweet, pure, and yet totally sexual.  You dart over her clit, and are rewarded with a burst of heavenly sweetness.  The maddening taste of her ambrosia gets in your veins – you NEED more and you attack her honeypot mercilessly, until at last she squeals in orgasm, clamping her fuzz-covered thighs around your head.\n\n", false);
			outputText("The force of her orgasm splatters you with the honey, far more than you could possibly try to lap up. You dimly remember the vial she gave to you, and steady it under the dripping fluid.  You catch as much of her sweetness as you can while still mashing your face against her quivering cunt.  You are in heaven, but after a time she pushes you back, smiling contentedly.  Her free hand offers you a small cork.   You reluctantly accept it and cap off the pure honey to save for later.\n\n", false);
			outputText("She waves and stretches, picking up her pack and buzzing her wings as she takes off.  She blows a kiss over her shoulder and flies away, leaving you to return to your camp...", false);
			menuLoc = 2;
			inventory.takeItem(consumables.PURHONY);
		}

		private function seduceBeeGirl():void
		{
			spriteSelect(6);
			//UNFINISHED - low priority male/female variants
			if (player.gender == 3) {
				outputText("Panting, your arousal evident, you stand defiant before the bee-girl. She looks at you quizzically, shifting her head ot the side. You feel the pheromones thicken in the air, the desire to surrender yourself to her rising. You bite it back and steel yourself, your willpower coming through.  Surprisingly, the bee-girl smiles.  Her stance becomes relaxed, and she begins to walk towards you.  You shift your guard slightly, on edge, yet losing a bit of tension.  ", false);
				outputText("As she draws near you see her smile at you and you feel the genuine warmth in it. She brings her hand to your cheek, gently caressing it before leaning in to kiss you. You relax fully, your hands resting on her hips as you return the kiss. She breaks it, still smiling. Her hand trails down your chest, cupping your breast briefly before ", false);
				if (player.isTaur()) outputText(" leaning between your knees to reach your bulging member.\n\nShe drops to her own knees, gazing at your " + cockDescript(0) + " before", false);
				else outputText(" continuing , sliding to the front of your pants to feel your bulging member.\n\nShe falls to her knees, sliding your cock free before", false);
				outputText(" running her tongue over the length. She slips her lips over the tip, gently sucking before sliding it entirely into her mouth. You can do little but moan, your hands gripping her head as she sucks and licks. Her hands squeeze the base of your shaft, stroking it", false);
				if (player.balls > 0) outputText(", sliding down and over your balls,", false);
				outputText(" until her fingers begin to play with the lips of your pussy. A groan escapes your open mouth as she slides a finger inside, your pussy clenching tightly and dribbling juices onto her hands.\n\n", false);
				outputText("Pulling back, she releases your " + cockDescript(0) + ", now slick with her saliva. She lies on her back, her legs spread wide with he abdomen laying flat against the ground. Her hands urge you forward, and you follow immediately. Her body is soft and accepting, and you quickly slide the head of your " + cockDescript(0) + " into her pussy lips, a mutual moan escaping from both of your lips. Pushing further in, the bee-girl wraps her arms around you, holding you against her as you begin to thrust. Each push makes her wetter, the slickness making your cock slide faster and faster. She arches her back and you feel the tip of her stinger against your " + vaginaDescript(0) + ". Before you can protest, it pushes in, gently but quickly, until it pierces your cervix.\n\n", false);
				outputText("You cry out as she releases her aphrodisiac venom directly into your deepest recess, flooding you with warmth. You kiss her, your tongues playing against each other as you increase the pace of your thrusts, pushing deeper and deeper inside of her. The bee-girl starts to grunt and groan, her body tensing as effort plays over her face.  ", false);
				//UNUSED OPTION VAG PREGGERS
				//outputText("You can feel pressure building against your pussy lips, her stinger bulging as something slips inside of you. Gasping, you feel it push deeper and deeper inside, until it finaly deposits itself into your womb, the heavy feeling oddly comforting.  ", false);
				//outputText("Each of your thrusts is coupled with pushing your hips down as you draw back, your pussy eagerly accepting the eggs as the bee-girl forces them inside you.  Your womb bulges from your stomach with the sheer number.  ", false);
				outputText("You can feel a pressure rising from the base of your cock. Thrusting deeply, you let out a howl as you cum, your cock spilling forth its sticky load into her, filling her pussy to the brim with your fluid.  ", false);
				outputText("Panting, you collapse onto her, as your cock finally stops twitching. Kissing you again, the bee-girl slides from beneath you and stands. She holds her stomach while a large smile plays on her face. You smile back at her as a feeling of contentment washes over you. You have no regrets as you part.", false);
				player.slimeFeed();
				dynStats("lus=", 0);
			}
			doNext(13);
		}

		public function beeRapesYou():void
		{
			spriteSelect(6);
			outputText("", true);
			var sexed:Boolean = false;
			//Centaur lost to giant bee:
			if (player.isTaur()) {
				//Damage:
				if (player.HP < 1) {
					outputText("The bee-girl smirks at you and approaches. Her chitin covered hand slides along your flank and you shiver with anticipation. She slaps your haunch, hard, and you reflexively buck. Displeased, she gives you a shove and you run into a tree. A honey covered hand is rammed inside your " + assholeDescript() + " and you grab the tree for support.\n\n", false);

					outputText("She tests the insides of your ass for a bit before pulling her arm out. She knocks out your hind legs and you land hard, your front ones not capable of holding the weight and your grip on the tree is too weak to provide much help.\n\n", false);

					outputText("With you thoroughly incapacitated, she walks up to your front and smears your " + chestDesc() + " with honey. The scent wafts up to your nose and your mind begins to go blank. Your tongue tries to reach for the sweet substance, but can't. You whimper at her, desperate for the taste of the mind altering honey. She obliges you by splashing some onto your face and you quickly begin lapping at it with your tongue.\n\n", false);
					//Male with testicles:
					if (player.gender == 1 && player.balls > 0) {
						outputText("She returns to your rear end and assesses it some more. With an almost desperate scrabbling she climbs on top of you, jabbing you repeatedly with her outstretched stinger and causing " + sMultiCockDesc() + " to go rock hard.\n\n", false);
						outputText("She can't see that, of course, and busies herself with something on your back. A loud unpleasant buzzing fills the air and you manage to break free of the control of the honey long enough to twist around.\n\n", false);

						outputText("Your stomach churns as you see four more bee maidens appear out of the undergrowth, stingers exposed and glistening with a clear fluid. The bee on your back stabs with her own stinger and you turn away again, desperately licking at the honey in an attempt to deal with the awful heat in your lower body.\n\n", false);

						outputText("Chitin covered arms begin stroking and scraping at you as you close your eyes as hard as possible, having exhausted your face of the mind numbing honey. Your pain and lust filled mind comes up with an idea and you quickly act; rubbing your sticky " + chestDesc() + " against the tree before swinging your head down violently and gnawing at it.\n\n", false);

						outputText("The sensation proves too much for your massively engorged " + Appearance.cockNoun(player.cocks[0].cockType) + " to take and you begin to shake violently, incapable of touching it as it's trapped underneath you and the weight of the bee-girls preventing you from getting the leverage needed to hump the hard ground.\n\n", false);

						outputText("They seem to understand your problem though and, more out of a desire to not get tossed off than to help you with your needs, begin to kick at your " + ballsDescriptLight() + " with their feet.\n\n", false);

						outputText("You shudder and shake as the painful beating continues, your balls burning with pent up seed and your cock writhing under the combined weight atop it. You sigh with relief as you feel your testicles release their load, but it can't escape: <b>your urethra is constricted too much</b>!\n\n", false);

						outputText("The pain and combined venom utterly overwhelms you, and you black out while the bees atop and around you continue to buzz with seemingly malicious intent.\n\n", false);
						//[If huge cum amount:
						if (player.cumQ() > 1500) {
							outputText("You awake in a massive puddle of cum, the scent so strong that it almost causes you to pass out again. You manage to stay conscious long enough to stagger to your hooves and wobbly walk away, grasping trees to steady yourself.\n\n", false);
							outputText("Despite everything, you realize that you feel oddly good; a warm tingling sensation ripples through your whole body every time you move and the pain from the stingers appears to have disappeared entirely. With a smile you kind of hope the next time you meet a bee-girl you will be victorious, so you can show her how to please you properly.", false);
						}
						//[All other cum amounts:
						else {
							outputText("You awake in a puddle of cum, the scent wafting up to you and making your stomach churn. You manage to settle it and stagger to your hooves, wobbly walking away using trees to steady yourself.\n\n", false);
							outputText("Despite everything, you realize that you feel oddly good; a warm tingling sensation ripples through your whole body every time you move and the pain from the stingers appears to have disappeared entirely. With a smile you kind of hope the next time you meet a bee-girl you will be victorious, so you can show her how to please you properly.", false);
						}
						dynStats("int", -.5, "lus=", 0);
					}
					//[Male without testicles:
					else if (player.gender == 1 && player.balls == 0) {
						outputText("She returns to your rear end and assesses it some more. With an almost desperate scrabbling she climbs on top of you, jabbing you repeatedly with her outstretched stinger and causing " + sMultiCockDesc() + " to go rock hard.\n\n", false);

						outputText("She can't see that, of course, and busies herself with something on your back. A loud unpleasant buzzing fills the air and you manage to break free of the control of the honey long enough to twist around.\n\n", false);

						outputText("Your stomach churns as you see four more bee maidens appear out of the undergrowth, stingers exposed and glistening with a clear fluid. The bee on your back stabs with her own stinger and you turn away again, desperately licking at the honey in an attempt to deal with the awful heat in your lower body.\n\n", false);

						outputText("Chitin covered arms begin stroking and scraping at you as you close your eyes as hard as possible, having exhausted your face of the mind numbing honey. Your pain and lust filled mind comes up with an idea and you quickly act; rubbing your sticky " + chestDesc() + " against the tree before swinging your head down violently and gnawing at it.\n\n", false);

						outputText("The sensation proves too much for your massively engorged " + Appearance.cockNoun(player.cocks[0].cockType) + " to take and you begin to shake violently, incapable of touching it as it's trapped underneath you and the weight of the bee-girls preventing you from getting the leverage needed to hump the hard ground.\n\n", false);

						outputText("They seem to understand your problem though and, more out of a desire to not get tossed off than to help you with your needs, begin to kick at where your balls ought to be with their feet.\n\n", false);

						outputText("The combination of the lust filled poisons, pain and shame at your utter defeat and humiliation drive you to black out, welcoming the blissful darkness.\n\n", false);
						outputText("When you awake, despite everything, you realize that you feel oddly good; a warm tingling sensation ripples through your whole body every time you move and the pain from the stingers appears to have disappeared entirely. With a smile you kind of hope the next time you meet a bee-girl you will be victorious, so you can show her how to please you properly.", false);
						dynStats("int", -.5, "lus=", 100);
					}
					//[Female:
					else if (player.gender == 2) {
						outputText("She returns to your rear end and assesses it some more. With an almost desperate scrabbling she climbs on top of you, jabbing you repeatedly with her outstretched stinger and causing your " + vaginaDescript(0) + " to squirt fluid behind you.\n\n", false);

						outputText("She pays no attention to that though, and busies herself with something on your back. A loud unpleasant buzzing fills the air and you manage to break free of the control of the honey long enough to twist around.\n\n", false);

						outputText("Your stomach churns as you see four more bee maidens appear out of the undergrowth, stingers exposed and glistening with a clear fluid. The bee on your back stabs with her own stinger and you turn away again, desperately licking at the honey in an attempt to deal with the awful heat in your lower body.\n\n", false);

						outputText("Chitin covered arms begin stroking and scraping at you as you close your eyes as hard as possible, having exhausted your face of the mind numbing honey. Your pain and lust filled mind comes up with an idea and you quickly act; rubbing your sticky " + chestDesc() + " against the tree before swinging your head down violently and gnawing at it.\n\n", false);

						outputText("The sensation proves too much for your massively engorged " + clitDescript() + " to take and you begin to shake violently, incapable of touching it as it's trapped underneath you and the weight of the bee-girls preventing you from getting the leverage needed to hump the hard ground.\n\n", false);

						outputText("They seem to understand your problem though and, more out of a desire to not get tossed off than to help you with your needs, begin to kick at where your balls ought to be with their feet. A handful of blows land on your " + clitDescript() + " and you cum hard, squirting behind you with surprising force.\n\n", false);

						outputText("The malevolent bee-girls continue their ministrations though, delighting in the way your body is reacting. The combination of the lust filled poisons, pain and shame at your utter defeat and humiliation drive you to black out, welcoming the blissful darkness.\n\n", false);
						//[If huge cum amount:
						if (player.wetness() == 5) {
							outputText("You awake in a massive puddle of femcum, the scent so strong that it almost causes you to pass out again. You manage to stay conscious long enough to stagger to your hooves and wobbly walk away, grasping trees to steady yourself.\n\n", false);
							outputText("Despite everything, you realize that you feel oddly good; a warm tingling sensation ripples through your whole body every time you move and the pain from the stingers appears to have disappeared entirely. With a smile you kind of hope the next time you meet a bee-girl you will be victorious, so you can show her how to please you properly.", false);
						}
						//[All other cum amounts:
						else {
							outputText("You awake in a puddle of femcum, the scent wafting up to you and making your stomach churn. You manage to settle it and stagger to your hooves, wobbly walking away using trees to steady yourself.\n\n", false);
							outputText("Despite everything, you realize that you feel oddly good; a warm tingling sensation ripples through your whole body every time you move and the pain from the stingers appears to have disappeared entirely. With a smile you kind of hope the next time you meet a bee-girl you will be victorious, so you can show her how to please you properly.", false);
						}
						dynStats("int", -.5, "lus=", 100);
					}
					//[Herm:
					else if (player.gender == 3) {
						outputText("She returns to your rear end and assesses it some more. With an almost desperate scrabbling she climbs on top of you, jabbing you repeatedly with her outstretched stinger and causing " + sMultiCockDesc() + " to go rock hard and your " + vaginaDescript(0) + " to squirt fluid behind you.\n\n", false);

						outputText("She can't see your cock, of course, and pays no attention to your outbursts of fluid, instead busying herself with something on your back. A loud unpleasant buzzing fills the air and you manage to break free of the control of the honey long enough to twist around.\n\n", false);

						outputText("Your stomach churns as you see four more bee maidens appear out of the undergrowth, stingers exposed and glistening with a clear fluid. The bee on your back stabs with her own stinger and you turn away again, desperately licking at the honey in an attempt to deal with the awful heat in your lower body.\n\n", false);

						outputText("Chitin covered arms begin stroking and scraping at you as you close your eyes as hard as possible, having exhausted your face of the mind numbing honey. Your pain and lust filled mind comes up with an idea and you quickly act; rubbing your sticky " + chestDesc() + " against the tree before swinging your head down violently and gnawing at it.\n\n", false);

						outputText("The sensations prove too much for your massively engorged " + Appearance.cockNoun(player.cocks[0].cockType) + " and sopping " + vaginaDescript(0) + " to take and you begin to shake violently, incapable of touching it as one is trapped underneath you with the weight of the bee-girl preventing you from getting the leverage needed to hump the hard ground and the other is hopelessly out of reach.\n\n", false);

						outputText("They seem to understand your problem though and, more out of a desire to not get tossed off than to help you with your needs, begin to kick and punch at your " + vaginaDescript(0), false);
						if (player.balls > 0) outputText(" and " + ballsDescriptLight(), false);
						outputText(".\n\n", false);

						outputText("A handful of blows land on your " + clitDescript() + " and you cum hard, squirting behind you with surprising force and splattering your underside with jism. The malevolent bee-girls continue their ministrations though, delighting in the way your body is reacting. The combination of the lust filled poisons, pain and shame at your utter defeat and humiliation drive you to black out, welcoming the blissful darkness.\n\n", false);
						//[If huge cum amount:
						if (player.cumQ() > 1500 || player.wetness() >= 5) {
							outputText("You awake in a massive puddle of various sexual fluids, the scent so strong that it almost causes you to pass out again. You manage to stay conscious long enough to stagger to your hooves and wobbly walk away, grasping trees to steady yourself.\n\n", false);
							outputText("Despite everything, you realize that you feel oddly good; a warm tingling sensation ripples through your whole body every time you move and the pain from the stingers appears to have disappeared entirely. With a smile you kind of hope the next time you meet a bee-girl you will be victorious, so you can show her how to please you properly.", false);
						}
						//[All other cum amounts:
						else {
							outputText("You awake in a puddle of various sexual fluids, the scent wafting up to you and making your stomach churn. You manage to settle it and stagger to your hooves, wobbly walking away using trees to steady yourself.\n\n", false);
							outputText("Despite everything, you realize that you feel oddly good; a warm tingling sensation ripples through your whole body every time you move and the pain from the stingers appears to have disappeared entirely. With a smile you kind of hope the next time you meet a bee-girl you will be victorious, so you can show her how to please you properly.", false);
						}
						dynStats("int", -.5, "lus=", 100);
					}
					//[Genderless:
					else {
						outputText("She returns to your rear end and assesses it some more. With an almost desperate scrabbling she climbs on top of you, jabbing you repeatedly with her outstretched stinger and causing your " + assholeDescript() + " to wink.\n\n", false);
						outputText("She can't see your " + assholeDescript() + ", of course, and pays no attention to your outbursts, instead busying herself with something on your back. A loud unpleasant buzzing fills the air and you manage to break free of the control of the honey long enough to twist around.\n\n", false);
						outputText("Your stomach churns as you see four more bee maidens appear out of the undergrowth, stingers exposed and glistening with a clear fluid. The bee on your back stabs with her own stinger and you turn away again, desperately licking at the honey in an attempt to deal with the awful heat in your lower body.\n\n", false);

						outputText("Chitin covered arms begin stroking and scraping at you as you close your eyes as hard as possible, having exhausted your face of the mind numbing honey. Your pain and lust filled mind comes up with an idea and you quickly act; rubbing your sticky " + chestDesc() + " against the tree before swinging your head down violently and gnawing at it.\n\n", false);

						outputText("The sensations prove too much for you to take and you begin to shake violently, incapable of alleviating the awful pressure in your rear.\n\n", false);

						outputText("They seem to understand your problem though and, more out of a desire to not get tossed off than to help you with your needs, begin to kick and punch at your " + assDescript() + ". The volley of blows is enough to stop you from shaking, but the pressure doesn't go away.\n\n", false);

						outputText("The malevolent bee-girls continue their ministrations though, delighting in the way your body is reacting. The combination of the lust filled poisons, pain and shame at your utter defeat and humiliation drive you to black out, welcoming the blissful darkness.\n\n", false);
						outputText("You awake in a couple of hours and stagger to your hooves, wobbly walking away using trees to steady yourself.  Despite everything, you realize that you feel oddly good; a warm tingling sensation ripples through your whole body every time you move and the pain from the stingers appears to have disappeared entirely. With a smile you kind of hope the next time you meet a bee-girl you will be victorious, so you can show her how to please you properly.", false);
						dynStats("int", -.5, "lus=", 100);
					}
				}
				//Lust:
				else {
					outputText("The bee-girl smiles at you and sways her hips sensuously as she approaches. Her chitin covered hand slides along your flank and you shiver with anticipation. She slaps your haunch gently, and you feel your anticipation grow. Pleased, she guides you toward a tree before gently sliding a honey covered hand inside your " + assholeDescript() + ", causing you to grab the tree for support.\n\n", false);
					outputText("She tests the insides of your ass for a bit before pulling her arm out and your hind legs start to quake as your desires aren't satisfied. You feel her stroke your hindquarters, encouraging you to lie down. You happily do so, using the tree as support.  With you safely down, she walks up to your front and smears your " + chestDesc() + " with honey. The scent wafts up to your nose and your mind begins to go blank. Your tongue tries to reach for the sweet substance, but can't. You whimper at her, desperate for the taste of the mind altering honey. She obliges you by holding a handful of the thick elixir to your mouth and you lap at it eagerly. Once you've consumed a fair amount she spreads more onto your face and giggles cutely as you stretch your tongue to lick at it.\n\n", false);
					//[Male with testicles:
					if (player.gender == 1 && player.balls > 0) {
						outputText("She returns to your rear end and assesses it some more. With an almost desperate scrabbling she climbs on top of you, jabbing you repeatedly with her outstretched stinger and causing " + sMultiCockDesc() + " to go rock hard.\n\n", false);

						outputText("She can't see that, of course, and busies herself with inserting her ovipositor into your " + assholeDescript() + ". Its thick lubrication allows it quick entrance, and soon she's pumping her fluids into your bowels. The sensation proves too much for your massively engorged " + multiCockDescriptLight() + " to take and you begin to shake violently, incapable of touching ", false);
						if (player.cockTotal() == 1) outputText("it as it's ", false);
						else outputText("them as they're ", false);
						outputText("trapped underneath you, the weight of the bee-girl preventing you from getting the leverage needed to hump the hard ground.\n\n", false);

						outputText("She seems to understand your problem though and, wanting to help you with your needs, begins to massage your " + ballsDescriptLight() + " with her 'feet'. As she does this she starts to hum, a sound that obliterates what few thoughts you had left and which causes her entire body to vibrate.\n\n", false);

						outputText("The amazingly peculiar vibrations and surprisingly adept massage is more than enough to get you off and you cum hard, splattering your underside.\n\n", false);
						//[If huge cum amount:
						if (player.cumQ() >= 1500) outputText("Your massive cum amount soon causes you to be lying in a deep puddle of splooge, the scent so strong that it's almost enough to overwhelm that of the honey, despite it coating your face.\n\n", false);
						outputText("She continues pumping into you as you pass out, " + sMultiCockDesc() + " and " + ballsDescriptLight() + " aching.  The combined scent of cum and honey completely overwhelms you.", false);
					}
					//[Male without testicles:
					else if (player.gender == 1) {
						outputText("She returns to your rear end and assesses it some more. With an almost desperate scrabbling she climbs on top of you, jabbing you repeatedly with her outstretched stinger and causing " + sMultiCockDesc() + " to go rock hard.\n\n", false);
						outputText("She can't see that, of course, and busies herself with inserting her ovipositor into your " + assholeDescript() + ". Its thick lubrication allows it quick entrance, and soon she's pumping her fluids into your bowels. The sensation proves too much for your massively engorged " + Appearance.cockNoun(player.cocks[0].cockType) + " to take and you begin to shake violently, incapable of touching it as it's trapped underneath you, and the weight of the bee-girl prevents you from getting the leverage needed to hump the hard ground.\n\n", false);
						outputText("She seems to understand your problem though and, wanting to help you with your needs, begins to massage the area where your balls should be with her 'feet'. As she does this she starts to hum, a sound that obliterates what few thoughts you had left and which causes her entire body to vibrate, more than enough to get you to cum hard.\n\n", false);
						outputText("She continues pumping into you as you pass out, " + sMultiCockDesc() + " aching and the scent of honey overwhelming you.\n\n", false);
					}
					//[Female:
					else if (player.gender == 2) {
						outputText("She returns to your rear end and assesses it some more. With an almost desperate scrabbling she climbs on top of you, jabbing you repeatedly with her outstretched stinger and causing your " + vaginaDescript(0) + " to squirt fluid behind you.\n\n", false);
						outputText("She sees the spray and strokes your ass gently, but can do nothing to help as she busies herself with inserting her ovipositor into your " + assholeDescript() + ". Its thick lubrication allows it quick entrance, and soon she's pumping her fluids into your bowels. The sensation proves too much for your massively enflamed " + vaginaDescript(0) + " and you begin to shake violently, incapable of touching yourself and alleviating the dreadful pressure. Your " + clitDescript() + " begins to throb painfully as it swells larger than normal.\n\n", false);

						outputText("She seems to understand your problem though and, wanting to help you with your needs, begins to stroke your " + vaginaDescript(0) + " with her 'feet'. As she does this she starts to hum, a sound that obliterates what few thoughts you had left and which causes her entire body to vibrate. This combined with the handful of times her chitin covered appendages slide across your " + clitDescript() + " cause you to cum hard, squirting behind you with surprising force.\n\n", false);
						//[Huge cum amount:
						if (player.wetness() == 5) outputText("Your massive cum amount soon causes you to be lying in a deep puddle of femcum, the scent so strong that it's almost enough to overwhelm that of the honey, despite it coating your face.\n\n", false);
						outputText("She continues pumping into you as you pass out, your entire rear aching and the combined scent of cum and honey overwhelming you.", false);
					}
					//[Herm:
					else if (player.gender == 3) {
						outputText("She returns to your rear end and assesses it some more. With an almost desperate scrabbling she climbs on top of you, jabbing you repeatedly with her outstretched stinger and causing " + sMultiCockDesc() + " to go rock hard and your " + vaginaDescript() + " to squirt fluid behind you.\n\n", false);

						outputText("She can't see your cock, of course, and while she sees the spray and strokes your ass gently, can do nothing to help as she busies herself with inserting her ovipositor into your " + assholeDescript() + ". Its thick lubrication allows it quick entrance, and soon she's pumping her fluids into your bowels.\n\n", false);

						outputText("The sensation proves too much for your massively engorged " + Appearance.cockNoun(player.cocks[0].cockType) + " and " + vaginaDescript(0) + " to take and you begin to shake violently, incapable of touching it as one is trapped underneath you with the weight of the bee-girl preventing you from getting the leverage needed to hump the hard ground and the other is hopelessly out of reach.\n\n", false);
						outputText("She seems to understand your problem though and, wanting to help you with your needs, begins to massage your " + vaginaDescript() + " with her 'feet' while periodically stroking the back of your " + cockDescript(0) + ".\n\n", false);
						outputText("As she does this she starts to hum, a sound that obliterates what few thoughts you had left and which causes her entire body to vibrate. This combined with the handful of times her chitin covered appendages slide across your " + clitDescript() + " cause you to cum hard, squirting behind you with surprising force and splattering your underside with jism.\n\n", false);
						//[If huge cum amount:
						if (player.cumQ() >= 1500) outputText("Your massive cum amount soon causes you to be lying in a deep puddle of splooge and femcum, the scent so strong that it's almost enough to overwhelm that of the honey, despite it coating your face.\n\n", false);
						outputText("She continues pumping into you as you pass out, your entire rear aching and the combined scent of cum and honey overwhelming you.", false);
					}
					//[Genderless:
					else {
						outputText("She returns to your rear end and assesses it some more. With an almost desperate scrabbling she climbs on top of you, jabbing you repeatedly with her outstretched stinger and causing your " + assholeDescript() + " to wink.\n\n", false);
						outputText("She pays no attention to that though, and busies herself with inserting her ovipositor inside it. The thick lubrication allows it quick entrance, and soon she's pumping her fluids into your bowels. The sensation proves too much for you and you begin to shake violently, incapable of touching yourself and alleviating the dreadful pressure.\n\n", false);
						outputText("She seems to understand your problem though and, wanting to help you with your needs, begins to stroke where your genitals should be with her 'feet'. As she does this she starts to hum, a sound that obliterates what few thoughts you had left and which causes her entire body to vibrate. The mix of sensations is enough to stop you from shaking, but the pressure doesn't go away and you pass out as she continues her task.\n\n", false);
					}
					dynStats("int", -.5, "lus=", 100);
					//Anal bee pregnancy!
					if (player.totalFertility() > rand(100) && player.buttPregnancyType == 0) {
						player.buttPregnancyIncubation = 48;
						player.buttPregnancyType = 2;
					}
				}
				player.slimeFeed();
				cleanupAfterCombat();
			}
			else {
				//Male + venomz
				if ((player.hasStatusAffect("paralyze venom") >= 0 || player.hasStatusAffect("lust venom") >= 0) && !sexed && player.cockTotal() == 1) {
					outputText("The bee-girl stands directly over you, looking down at you with a triumphant cute smile across her face, her eyes surveying every millimeter of your body. All you can do is lay there looking up at her fine figure and a profile of her ample breasts with a knowing smile on your face. She crouches down on all fours, just out of your reach, and begins to rhythmically shake her extended abdomen like a child's toy.\n\n", false);

					outputText("Suddenly reality kicks in as you feel the venom coursing though your body, and your heart begins to race faster and faster by the minute. A dull pain swells deep inside your head as if it were about to explode; you try to lift your arms to cradle your head but can't, and slowly a new sensation takes over as your manhood begins to swell in size and length, trying to break through your clothes. A faint buzzing sound comes seemingly from nowhere, growing louder and getting closer every second. As the pain in your head decreases, you suddenly feel parched, your mouth as dry as the desert sands.  You try to let out a moan but all you can do is breathe rapidly, as if you are burning up inside.\n\n", false);

					outputText("Several more bee-girls appear and gracefully land all around you, apparently communicating with each other by vibrating their abdomens. She leans forward over you, brushing one of her breasts across the side of your face as she loosens your clothing to release your fully erect manhood. She forcefully grabs it with both hands and begins to squeeze it, as if trying to choke it. Your vision starts to blur; if she were to stroke your member right now, you could die happily knowing you had felt that kind of pleasure. The bee-girl continues to choke your member for several minutes, forcing the blood upwards.\n\n", false);

					outputText("Slowly she gets to her feet and stands directly over your manhood.  'At last,' you think to yourself, 'one final moment of pleasure.'  You close your eyes and allow yourself the fantasy of her lowering herself upon you. A few seconds pass before you open your eyes to see what she is doing. A sudden wave of panic comes over you as you watch her arch her abdomen down between her legs; a split second later you feel a sharp pain at the base of your member. Your eyes close as you try in vain to scream before you pass out.", false);
					cleanupAfterCombat();
					outputText("\n\nSeveral hours later you wake up free of pain - if anything you feel great, a warm tingling sensation rippling through your whole body every time you move as you sit upright. As you look down you see you are still naked and covered in your own seed. With a smile you kind of hope the next time you meet a bee-girl you will be victorious, so you can show her how to please you properly.", false);
					sexed = true;
					dynStats("lus=", 0);
					return;
				}
				//Generic male bee-rape
				if (player.gender == 1) {
					if (player.lust >= 100) outputText("Overcome by lust, you throw yourself into her waiting arms.  ", true);
					else outputText("Overcome by your wounds, you are unable to resist as she lifts you into her arms and embraces you.  ", true);
					outputText("At first she holds you close, but as she does, a stinger slowly emerges from her abdomen, as well as a thick knot like organ, both covered in a sweet-smelling lubricant. Your mind synaesthetically sees a myriad of colors and scents, and you don't resist as she gently pushes you down to your stomach. Nor do you protest as she leans over you, her stinger - thank goodness it isn't poison - looming close to your anus. With no more words she shoves the thick, lengthy stinger and knot inside of you. Her 'cock' slipping in slowly, the lube keeping you from shaking out of your scent-induced pleasure coma. Your hand even ventures to your own engorged ", false);
					if (player.cockTotal() == 1) outputText("member", false);
					if (player.cockTotal() > 1) outputText("members", false);
					outputText(" as she rather forcefully rapes your once-tight hole, humming her tune all the while.\n\n", false);
					//blow load.
					outputText("After hours of her forcefully filling your hole, her stinger pumping almost gallons of her bee-seed into your very bowels, hours of you stroking yourself to ejaculation, she finally pulls out. With her stinger still dripping seed onto your back, she smiles, watching you blow your last load into a pool of semen underneath you, and collapse exhausted.\n\n", false);
					//epilogue
					outputText("You awaken, your nose full of a honey like scent, some strange fluid on your back, and the feeling of something leaking from you.", false);
					player.slimeFeed();
					dynStats("int", -.5, "lus=", 0);
					//Anal bee pregnancy!
					if (rand(3) == 0 && player.buttPregnancyType == 0) {
						player.buttPregnancyIncubation = 48;
						player.buttPregnancyType = 2;
					}
					player.buttChange(25, true, true, false);

					cleanupAfterCombat();
					return;
				}
				//FEMALES
				//Fan-submitted - female funtimes with a bit o' end breathplay
				if (player.gender == 2) {
					if (player.lust < 100) outputText("Barely conscious, you look up as the bee approaches.  ", true);
					else outputText("Overcome with desire, you look up as the bee approaches.  ", true);
					outputText("You feel weary and weak as your body begins to betray you to the pheromones of your foe.  You try and struggle as she moves over you, holding your hands against the ground as her chest pushes into your face, blocking sunlight and air as you protest. Your " + player.armorName + " are pulled from your body as the bee-girl moves on top of you.\n\n", false);
					outputText("A sharp pain hits your stomach as the bee-girl's stinger penetrates your flesh. Before you can cry out, a sickening warmth floods from the wound, washing away the pain and oozing through your body. Your " + vaginaDescript(0) + " juices flow between your ", false);
					if (player.isTaur()) outputText("rear legs", false);
					else outputText("legs", false);
					outputText(", making your thighs slick as your clit throbs almost painfully in the cold air. You begin to pant, your heart racing as the bee-girl slides back down your body, moaning as her breasts snag your nipples, rubbing them in a pleasurable way. She stops at head level, looking into your eyes with her own black orbs. She smiles at you and you realize that she is no longer pinning you with anything more than her own relatively light weight. You crease your brow with worry as you realize that running is the last thing on your mind, before the warm haze slips inside your skull.  The sexy bee leans in and kisses you softly, robbing you of your last shreds of resistance.\n\n", false);

					if (player.lowerBody != LOWER_BODY_TYPE_CENTAUR) {
						outputText("She slips further down your chest, grabbing your " + player.allBreastsDescript() + " playfully. You feel her knee nudging against your " + vaginaDescript(0) + ", grinding roughly against it and sending shivers through your body. You yelp slightly as she bites one of your nipples, the sudden sensation giving way to moans of pleasure as she massages and pinches the other one. Her knee slides against your " + vaginaDescript(0) + ", flicking your " + clitDescript() + " and coating the bee-girl with your juices. You feel her straddle your legs, her feet deftly pulling your thigh into contact with her pussy, before she starts to rock against you.\n\n", false);
						outputText("Her juices mix with your own as you feel yourself working steadily to climax. Noticing your heavy breathing and sudden vigor, she pulls away.  ", false);
					}
					outputText("In one swift motion, she slides up your body until her pussy is jammed against your face. Her hands grip the back of your head, pulling you tightly into her snatch as she smears her honey over your face.  The smell is incredibly sweet, and you instinctively begin to pleasure her.  You slide your tongue inside her folds, drinking down the thick liquid that fills your mouth as you suckle. ", false);

					if (player.isTaur()) outputText("After a while, her hot and sweet pussy swiftly disappears from your sight, and you feel the bee-girl's weight on your butt, right before her stinger,", false);
					else outputText("You feel the bee-girl's stinger", false);
					outputText(" sliding against your nether-lips, pushing against them and parting the outer folds. Her abdomen shifts, shifting the stinger up and down, keeping your " + vaginaDescript(0) + " parted while rubbing your clit.\n\n", false);
					if (player.isTaur()) outputText("Suddenly, you feel a sharp pain right into your clit, followed by a sexual warmth so intense this time, that it engulfs you and turns you into a sex-craving slut.  Anticipating the effect, she repositions her honeyed pussy over your face.  You begin to lick, suck and kiss it frenetically, burying your tongue into her deepest recesses.  She giggles at first, but soon the only noises you hear from her are moans becoming more and more intense. As her arousal shoots through the roof, you feel her legs twitching, and she suddenly grabs your head and forces your face into her crotch. You continue eating her out voraciously, oblivious to secondary things like breathing.\n\n", false);
					else outputText("Your moans are muffled by the honeyed pussy on your face, and you hear her starting to squeal loudly. Her thighs clamp tightly around your ears, grinding harder into your face as her stinger picks up the pace.  ", false);
					outputText("It gets harder and harder to breathe, the thick flow of honey threatening to suffocate you as the bee-girl reaches her climax.  You feel your body finally succumbing to the pleasure and oxygen deprivation and cum HARD, the world going comfortably dark as you lose your grip on consciousness.", false);
					player.slimeFeed();
					dynStats("int", -.5, "lus=", 0);
					cleanupAfterCombat();
					return;
				}
				//Hermz/Genderless (Lazy way, unfinished?)
				if (player.gender == 3 || player.gender == 0) {
					outputText("Defeated, there is little you can do to stop the bee-girl as she approaches, buzzing and humming intently.  Cooing and humming into your ear, her pheromones filling the air, she rapidly overwhelms your mental resistance.\n\n", true);
					//Link to standard bee rape scene #3.
					doNext(beeEncounterLevel3);
				}
			}
		}

		public function rapeTheBeeGirl():void
		{
			spriteSelect(6);
			var sexed:Boolean = false;
			outputText("With your mind made up, you approach the ", true);
			if (monster.HP <= 0) outputText("helpless ", false);
			else outputText("horny ", false);
			outputText("bee-girl with a devilish smile painted across your face.\n\nHow will you take her?\n\n", false);

			//OPTIONS HERE!
			var naga:Function =null;
			var multiCock:Function =null;
			var cock:Function =null;
			var vagina:Function =null;
			var herm:Function =null;
			var gentleman:Function =null;
			var eggs:Function =null;
			if (player.canOvipositSpider() && (player.faceType == FACE_SNAKE_FANGS || player.faceType == FACE_SPIDER_FANGS)) {
				eggs = layEggsInABeeSpiderLike;
				outputText("(You could dose her with venom and lay YOUR eggs in her.)\n");
			}
			if (player.hasCock()) {
				outputText("(You could fuck her with " + oMultiCockDesc() + ".)\n", false);
				cock = rapeTheBeeGirlWithADick;
			}
			if (player.cockTotal() > 1) {
				outputText("(You could use more than one of your " + multiCockDescriptLight() + " on her.)\n", false);
				multiCock = rapeTheBeeMultiCockStuff;
			}
			if (player.hasVagina()) {
				outputText("(You could make her get off your " + vaginaDescript() + ".)\n", false);
				vagina = rapeABeeGirlWithYourVagina;
			}
			if (player.gender == 3) {
				outputText("(You could try to please both your 'male' and 'female' halves on the bee.)\n", false);
				herm = futaRapesBeeGirl;
			}
			if (player.isNaga() && player.faceType == FACE_SNAKE_FANGS) {
				outputText("(You could focus on your snakelike, 'naga' attributes.)\n", false);
				naga = corruptNagaBitchesRapeABee;
			}
			if (player.cor >= 75 && player.str >= 60 && (player.tongueType == TONUGE_SNAKE || player.hasCock() || player.hasVagina() || player.biggestTitSize() >= 4)) {
				outputText("(You could play with her a bit and try to make her lay eggs into herself.)\n", false);
				gentleman = beeGirlRapeForTheDistinguishedGentleman;
			}
			choices("Use Cock", cock, "Use Cocks", multiCock, "Use Vagina", vagina, "Herm Style", herm, "Naga", naga, "Self-Egg", gentleman, "", 0, "", 0, "LayYourEggs", eggs, "", 0);
		}


		private function rapeTheBeeMultiCockStuff():void
		{
			spriteSelect(6);
			outputText("", true);
			//Doubledick special
			//HermCock supreme by mallowman
			if (player.cockTotal() >= 5 && player.biggestTitSize() > 2
					&& player.vaginas.length > 0 && rand(2) == 0) {
				outputText("As you approach, she starts to edge away, her battered wings flapping in a futile attempt to escape.  Reaching her, you grip her wrists before she can fight back, squeezing tightly as her struggling increases. Forcing her onto her back, you hold her wrists tightly in one hand to allow you to pull off your " + player.armorName + ", freeing your " + multiCockDescript() + " and " + vaginaDescript(0) + ".  She gasps at the alien sight of your multiple 'stingers', while you take a moment to decide what's going to go where.\n\n", false);
				outputText("You shift a bit upward, your brace of " + multiCockDescriptLight() + " sliding above the bee-girl's slick honey pot.  For a moment she breathes a sigh of relief, then gasps as two of your manhoods press against her front and back doors at once.\n\n", false);
				outputText("You begin to push forward, sliding your dickmeat against the soft folds of her pussy and pressing the tip of your prick firmly against her quivering hole, her whimpers punctuated by rhythmic gasps.  Your grin widens as you penetrate her roughly in one strong stroke, the bee-girl's body tensing underneath you as a squeal leaves her lips.  Your other cocks slide between her plump breasts, the soft pillows enveloping your shafts.  Defiance escapes her, her abdomen locking in place as she becomes unable to concentrate on moving her stinger without being overwhelmed by the feeling of your meat stuffing her ass.\n\n", false);
				outputText("Unhindered, you start to fuck her.  Her pussy tightens and convulses around your " + cockDescript(0) + ", her ample honey dribbling down onto your lowermost shaft and adding a little more lube on every thrust into the tight heat of her ass.  Her whimpers turn to moans, her scent shifting from fear to lust as the bee-girl discovers the unexpected pleasure of being reamed in both holes at once.  You keep your breathing steady, listening to her moans grow more lustful with every thrust and more needy every time you pull back in preparation for another.  Soon you've fucked all thought of resistance out of her, in favor of squealing with glee every time your mighty cock forces a little deeper into her tight honey pot.\n\n", false);
				outputText("Letting go of her arms, you grip the base of her abdomen for leverage and let her arms and legs slide around you as your pace increases.  You show her how to press her breasts together against your " + cockDescript(0) + ", and she obliges, rubbing them back and forth as you fuck her.  With your jiggling breasts added to the mix, it becomes even more enjoyable, your " + breastDescript(0) + " mashing against hers.  The milk leaking out of your immense jugs runs down your bodies and adds further to the ocean of fluids forming between your hips.\n\n", false);
				outputText("The heads of your " + Appearance.cockNoun(CockTypesEnum.HUMAN) + " rub back and forth against the bee-girl's lips and face, and finally curiosity leads her to begin tasting, her surprisingly long tongue lassoing and swirling around every tip she can reach in turn, darting from one to another as if tasting flowers to provide an experience almost as unique as her pussy.\n\n", false);
				outputText("You feel her abdomen pressing against your rear as you drive into her, the pressure in your groin building as her pussy and ass tighten around you. With a groan you cum, your hot seed gushing in alternating spurts out of each of your shafts into her eager little holes while your tight cunt juices itself with your own brand of honey. She clenches you tightly, her belly distending slightly as you empty your load into her pussy and ass while she squeals again at getting her face covered in seed.  Exhausted from the battle and the fuck, she relaxes and collapses on the ground, panting heavily and half-conscious.", false);
				dynStats("lus=", 0);
				cleanupAfterCombat();
				return;
			}
			if (player.cockTotal() == 2 && rand(2) == 0) {
				outputText("The bee-girl turns around, scampering across the floor to try to escape. As you close in to your prey you can feel your " + multiCockDescriptLight() + " harden and rise up at the sight of her form and you swiftly grab on to her abdomen and hold fast. She screams in futility as you flip her over and greedily look across her body.\n\n", false);
				outputText("Forcing her onto her back, you hold her wrists tightly in one hand to allow you to pull off your " + player.armorName + ", freeing your " + multiCockDescriptLight() + ". The bee-girl opens her eyes for a scant moment and realizes what's about to happen. She tries one more time to plead for you to let her escape as your " + multiCockDescriptLight() + " slide up and down against her nectar-drenched pussy lips. Your grin widens as you penetrate her roughly in one savage stroke, taking her with one of them. Screaming and squirming, the bee-girl struggles.  Your right hand braces against her flapping arms to settle them to the ground as you push in once again. Letting her know just how little control she has against your will, you lean forward, planting her hands against the ground and licking her cheek as your " + multiCockDescriptLight() + " push up deep inside her. Looking into her eyes, you see a faint glimmer of defiance, and under your body you feel her shifting slightly, muscles growing firm and tense. The realization hits you, and you manage to shift before her stinger comes into contact with you. Moving your knee, you pin her thick ", false);
				outputText("abdomen down and remove the threat. You smack her across the face for her defiance to reaffirm your dominance and you push forward back into her. She whimpers slightly, but then her face snaps back to a fierce visage although cracks begin to form as you continue pushing into her. As much as she wants to resist, the pleasure is mounting and you have it in mind to completely solidify your dominance over her.\n\n", false);
				outputText("You decide that it's time to bring your other gift into play. Atop the bee-girl you fire in one more stroke of your " + cockDescript(0) + " and then you run your free hand from her black lips across her breast and across her abdomen before you rest it on her clit. You tweak her sensitive spot along with the strokes from your intruding member and then when the rush of nectar and cum juices from her pussy seem up to the task you grab hold of your other " + cockDescript(1) + " and forcefully ram it into her pussy right below your first entry.\n\n", false);
				outputText("At this the bee-girl shrieks in utter bliss as her eyes roll back and she can't fight back the tingles coursing through her as you stretch her pussy lips.  You let go of her hands and watch with a satisfied grin as she tosses, turns, and clings to the dirt with a rich mix of pain and pleasure from the rough double-penetration. Suddenly you're caught off guard slightly as she pushes forward, almost tackling you. For an instant you're prepared to finish off the bee-girl, but the lust in her eyes is easy enough to read and she looks down, begging to be fucked and filled.  Grabbing onto her arms to brace against and suckling at her ample breast, you force your twin rods into her again and again while a pool of her sexual juices and sweet nectar form at your crotch from each slip in to her moist wetness. The bee-slut moans as you push your rock-hard cocks into her slick pussy, and you can just see the detectable bump of your cock head edging along her stomach, but strong as you are the tightness is overwhelming as her pussy muscles clench about your cocks.\n\n", false);
				outputText("Letting go of your hands the bee-girl leans back and her mouth opens in a powerful scream of ecstasy that you're sure will scatter any wild-life or imps who hear the noise. As she flings herself back, your body clenches and a torrential storm of white, warm cum soars from the tip of your members into her innermost spaces. Unable to cope with the feelings coursing through her, the bee-girl nearly faints as she comes to a rest on your chest.  You catch your breath and the last couple of cum shots is milked by her still clenching pussy. Rolling over, you free both of your cocks from her fuck-hole and watch with more than a bit of satisfaction.  The dam breaks and a sea of white escapes her stretched, well-lubricated pussy. Pleased with your latest jaunt through the forest, you collect your gear and settle off, leaving the cum-drenched bee-girl covered in your seed.", false);
				dynStats("lus=", 0);
				cleanupAfterCombat();
				return;
			}
			else beeAlternate();
			return;
		}

//MALE sometimes herm
		private function rapeTheBeeGirlWithADick():void
		{
			spriteSelect(6);
			outputText("", true);
			var x:Number = player.cockThatFits(monster.vaginalCapacity());
			if (x < 0) x = 0;
			//TAURS GO!
			if (player.isTaur()) {
				if (monster.lust > 99) outputText("The bee-girl plops onto her flower with her legs splayed out, letting you get a clear look at her dripping honeypot. She watches you nervously as you approach, letting her stinger slide out in a pointless threat. She seems taken aback when you smile down at her, but returns the gesture with a nervous smile of her own.\n\n", false);
				else outputText("The bee-girl plops onto her flower, barely conscious from the beating she's taken.  Her legs are splayed drunkenly, letting you get a clear look at her dripping honeypot. She watches through heavily, lidded eyes as you approach, letting her stinger slide out in a weak threat.  She seems taken aback when you smile down at her, but returns the gesture with a nervous, scared smile of her own.\n\n", false);

				outputText("You reach down and stroke her hair. She flinches from your hand at first before realizing that you genuinely mean her no harm. Her own hand reaches to slide up your arm as you pull yourself down to kiss her. She happily kisses you back, her long, thin, dexterous tongue wrapping around your own.\n\n", false);

				outputText("Pulling back, you consider her for a moment. She watches as you slip out of your " + player.armorName + ", licking her lips at the site of your " + chestDesc() + ". Once your torso is free you reach down again and pick up the bee maiden. She's surprisingly light and you lift her with ease, feeling her legs wrap around you as you hug and kiss her.\n\n", false);

				outputText("It's not long before she's gently grinding her cunt against your body and you find your hand slide down her front to slip gently inside her sticky folds. She moans into your mouth and vibrates as a little gush of honey squirts out of her. You bring your hand back up and the pair of you clean it off with your tongues.\n\n", false);

				outputText("The sweet substance causes your hindquarters to heat up. You feel your " + assholeDescript() + " pucker and " + sMultiCockDesc() + " grow, dripping pre onto the ground. At the same time, your thoughts start to get fuzzy and you have to fight off the sensation to throw the bee down and fuck her wildly.\n\n", false);

				outputText("The honey is gone relatively quickly, much to your disappointment. You reach down to fetch some more, but her hand stops you. \"<i>You don't want that, you want thezze.</i>\" she says, lifting your hand back up and placing it on her breast.\n\n", false);

				outputText("As you squeeze and massage the soft mounds, the effects of the honey start to wear off, at least in your head. Your rear is aching with desire and your tail flings about to try to tempt the non-existent mares with your scent. The bee maiden gets a whiff of your strong musk and you feel a fresh gush of fluids run down your forelegs.\n\n", false);

				//Cock short enough to penetrate her:
				if (player.cockArea(x) <= monster.vaginalCapacity()) {
					outputText("She looks under your arm toward your manhood and seems delighted by the sight of your " + cockDescript(x) + ". Her body swings about your torso with the help of her wings and she crawls down your back toward your rear. You lift your tail and allow the bee maiden to examine your " + assholeDescript() + ", sliding her fingers around the edge and teasing at it.", false);
					//Has testicles:
					if (player.balls > 0) outputText("  Her other hand slides down and begins to massage your " + ballsDescriptLight() + ", squeezing and tugging gently at your scrotum. Her tongue joins them, sliding in and out of your ass before wrapping around your sack. You feel incredible and your " + cockDescript(x) + " drips pre, forming a puddle on the ground.", false);
					//No testicles:\
					else outputText("Her other hand starts pulling it open and soon her tongue joins them, sliding in and out of your ass delicately. Your " + cockDescript(x) + " quivers with anticipation and you swish your tail happily.", false);
					outputText("\n\n", false);

					outputText("All of a sudden her ministrations stop, causing you to look over your shoulder to find out what's going on. She turns around on your back and gives you a look of complete innocence. Powerless to resist such a cute look, you turn your head back around as her legs swing down onto your flanks.\n\n", false);

					outputText("You think at first she's going to ride you like a horse, but she doesn't. Instead, you feel her whole body slide sideways as she flips around to grab onto your belly. You're surprised at her strength, managing to hold herself up fairly effectively with just her arms and legs gripping your body. She doesn't intend to rely on that alone though, as her abdomen is gently held in place between your rear legs. You feel something latch onto your " + assholeDescript() + ", but are unable to do anything about it or even see what it is. The sudden changes are surprising and you can't help but wonder what she intends.\n\n", false);

					outputText("You get your answer as a hot, wet, vice wraps around your " + cockDescript(x) + " and whatever is inside your ass pushes slightly further in. It feels good, but you know that even with her surprising strength she wouldn't be able to hold on if you tried driving into her. Thinking this defeats the purpose somewhat you're about to propose that some other arrangement be considered when she starts to buzz.\n\n", false);

					outputText("It's gentle at first, not much more than a regular bee to your ear, but it slowly builds, and builds, and builds; until eventually it's so loud you find it hard to think of anything but the strange noise. The noise isn't the only thing though, as the sound grows so too do the vibrations in the bee-girl's body. By the time the buzzing has reached its crescendo your entire belly feels like it's being vibrated off.\n\n", false);

					outputText("The sensation is incredible; her muscles spasm and milk your " + cockDescript(x) + " while the object in your " + assholeDescript() + " (which you think is probably her ovipositor) begins pumping fluids into you, all while your genitals are vibrated unceasingly.", false);
					//Has testicles:
					if (player.balls > 0) outputText("  Your " + ballsDescriptLight() + " really feel spectacular, the vibrations causing the hot spunk inside to roil about.", false);
					outputText("  Her hot cunt constricts around you as she cums repeatedly, coating your hind legs in sweet honey.\n\n", false);

					outputText("You find it increasingly difficult to control yourself as your equine body demands to hump something. The unusual ministrations are spectacular, but your " + cockDescript(x) + " is demanding a mare. With a supreme effort you overcome your bestial desires, reveling in the pleasure without feeling the overwhelming desire to inseminate. Just as you're celebrating this personal victory you feel the familiar pressure of your orgasm build in your groin", false);
					//has testicles: 
					if (player.balls > 0) outputText(", and your " + ballsDescriptLight() + " constrict", false);
					outputText(".\n\n", false);

					outputText("Your seed is propelled through your pulsating " + Appearance.cockNoun(player.cocks[x].cockType) + " with surprising force.", false);
					//No testicles: 
					if (player.balls == 0) outputText("  It dribbles into the bee-girl as her honey squirts out of her once again. Her body trembles as the extreme exertions take their toll, and she slides off of your member with a damp plop, splashing into a puddle of her own fluids.", false);
					else {
						//Normal cum amount: 
						if (player.cumQ() < 500) outputText("  It sprays inside the bee-girl as her honey squirts out of her once again. Her body trembles as the extreme exertions take their toll, and she slides off of your member with a damp plop, splashing into a puddle of her own fluids as your spunk dribbles onto her.", false);
						//Huge cum amount:
						else outputText("  It sprays inside the bee-girl, quickly overfilling her and causing her belly to expand. Her sudden increased girth and the extreme exertion cause her to lose her grip on you, and she is propelled off of you into a puddle of spunk and honey. You can't control yourself as your " + ballsDescriptLight() + " continue to pump out more and more fluid, spraying down the exhausted bee and coating her flower with enough gunk to cause it to wilt slightly. Eventually it stops, with only periodic gushes spraying out.", false);
					}
					outputText("\n\n", false);

					outputText("Once you've come down from your incredible orgasm your attention shifts to the exhausted bee maiden beneath you. You take pity on her and pick up the giant bee as gently as possible. She hums gently in your arms as you carry her over to her flower, sliding her onto it", false);
					//Huge cum amount:
					if (player.cumQ() >= 500) outputText(" and watching as her lower body sinks into your spunk like a thick white bath", false);
					outputText(". Once she looks comfortable you make your way back to camp, thoroughly satisfied.", false);
				}
				//Cock too long to penetrate her:
				else {
					outputText("She looks under your arm toward your manhood but seems disappointed at your " + cockDescript(x) + "'s large size. . Her body swings about your torso with the help of her wings and she crawls down your back toward your rear. You lift your tail and allow the bee maiden to examine your " + assholeDescript() + ", sliding her fingers around the edge and teasing at it. Her tongue licks at you but you can tell her mind is elsewhere and you wonder what the problem is.\n\n", false);

					outputText("She giggles all of a sudden and retracts her tongue, turning around atop you. Her chitin covered legs swing down to rest on your flanks and you wonder if she intends to ride you like a horse.\n\n", false);

					outputText("She doesn't though, as with a buzz her body swings about beneath you. As she slides sideways, one arm is pulled off for a moment, long enough to catch your " + cockDescript(x) + " between her body and your own, before catching onto your other flank. Her abdomen slides up behind your rear legs and you feel something latch onto your " + assholeDescript() + ", but are unable to do anything about it or even see what it is.\n\n", false);

					outputText("Her grip is surprisingly strong for such a frail looking creature but you don't think she'll be able to handle much movement. Thinking this defeats the purpose somewhat you're about to propose that some other arrangement be considered when she starts to buzz.\n\n", false);

					outputText("It's gentle at first, not much more than a regular bee to your ear, but it slowly builds, and builds, and builds; until eventually it's so loud you find it hard to think of anything but the strange noise. The noise isn't the only thing though, as the sound grows so too do the vibrations in the bee-girl's body. By the time the buzzing has reached its crescendo your entire belly feels like it's being vibrated off.\n\n", false);

					outputText("Your " + cockDescript(x) + " feels wonderful though, pumping out fluid and swelling with more and more blood.", false);
					//Has testicles: 
					if (player.balls > 0) outputText("  The vibrations do a number on your " + ballsDescriptLight() + " too, as the semen stored within starts to shake and dance about inside.", false);
					outputText("  The thing in your " + assholeDescript() + " (which you believe is her ovipositor) is vibrating along with her as it pumps fluid inside, and you feel yourself puckering in pleasure.", false);
					//Cock long enough to masturbate: 
					if (player.tallness * (5 / 6) < player.cocks[player.longestCock()].cockLength) {
						outputText("  Her tongue wraps around your " + cockDescript(x) + " and starts jerking off the small section it can reach. The wet ring feels amazing and you decide to help her efforts by gripping the head of your member and playing with it yourself. Soon though, your cock trembles as the familiar sensation of orgasm begins creeping up on you.", false);
					}
					//Other cocks: 
					else outputText("  Her tongue wraps around your " + cockDescript(x) + " and slides up and down the small area it can reach before flicking about at the tip of your urethra. Her expert licking feels amazing and it's not long before your feel the familiar sensation of orgasm creeping up on you.", false);
					outputText("\n\n", false);

					outputText("With all the combined sensations your " + cockDescript(x) + " begins to unload. ", false);
					//With testicles, masturbatable cock:
					if (player.balls > 0 && player.tallness * (5 / 6) < player.cocks[player.longestCock()].cockLength) {
						outputText("Your " + ballsDescriptLight() + " contract and propel your seed down your member toward the fresh air. It fires out of you and hits the bee's flower, splattering it in white.", false);
						//Huge cum amount: 
						if (player.cumQ() >= 750) outputText("  You don't stop there though, as your firehose of a cock sprays it down until it's sagging with the weight of your seed.", false);
					}
					//With testicles, other cocks:
					else if (player.balls > 0) {
						outputText("Your " + ballsDescriptLight() + " contract and propel your seed down your member toward the waiting bee-girl. It fires out of you and hits her face, splattering it in white.", false);
						//Huge cum amount: 
						if (player.cumQ() >= 750) outputText("  You don't stop there though, as your firehose of a cock sprays wildly, coating her head and her flower, hosing it down until it's sagging with the weight of your seed.", false);
					}
					//Without testicles: 
					else outputText("Your " + assholeDescript() + " tightens uncontrollably around its intruder, making the vibrations feel even stronger there. Your member jerks as you orgasm and a few droplets of semen land on the bee maiden.", false);

					outputText("\n\nShe releases you from her grasp and lands with a wet thud on the ground. Looking down, you see that her vibrating against your " + cockDescript(x) + " was enough to get her off, a lot. She's lying in a puddle of mixed sexual fluids and honey, unconscious after what must have been an extreme effort on her part.", false);

					outputText("You take pity on her and pick up the giant bee as gently as possible. She hums gently in your arms as you carry her over to her flower, sliding her onto it", false);
					//Huge cum amount: 
					if (player.cumQ() >= 750) outputText(" and watching as her lower body sinks into your spunk like a thick white bath", false);
					outputText(". Once she looks comfortable you make your way back to camp, thoroughly satisfied.", false);
				}
				dynStats("lus=", 0);
				cleanupAfterCombat();
			}
			else if (rand(2) == 0) {
				outputText("Firmly grasping her thighs at the joining of her smooth carapace and soft skin, you force them open, revealing the source of her irresistible scent.   She buzzes pitifully in protest ", false);
				if (player.isTaur()) outputText("as your " + cockDescript(x) + " hardens under your belly.", false);
				else outputText("as you disrobe, revealing your " + cockDescript(x) + " to her.", false);
				outputText("  Wasting no time, you get down to the business of ", false);
				if (player.cockTotal() == 1) outputText("penetrating her slick snatch, forcing in inch after inch.  ", false);
				if (player.cockTotal() == 2) outputText("cramming your " + multiCockDescript() + " into her, double-stuffing the poor bee-slut with your double dongs.  ", false);
				if (player.cockTotal() >= 3) outputText("cramming two out of your " + num2Text(player.cockTotal()) + " " + cockDescript(99) + "s into her, double-stuffing the poor bee-slut with double the dicks.  ", false);
				outputText("She swoons, flopping back and opening her legs completely, an expression of shock crossing her features, as if she can't comprehend why her body isn't listening to her.\n\n", false);
				//sex
				outputText("You begin pounding away at her, splattering honey over her thighs with your enthusiastic fucking.  Her passage is unlike anything you've ever had before.  It's tight, but overly slick and textured with small nubs and bumps that tease and caress in wonderful ways.   Her muscles clamp and squeeze her vaginal entrance tightly, turning it into an organic cock-ring.  You hold still while her cunt begins twitching and slightly rotating back and forth around your " + cockDescript(x) + ".    Her head is thrown back in what you assume is an orgasm, her arms mashing her tits together for even more pleasure.  The vacuum seal around your " + cockDescript(x) + " only gets tighter as her rippling, squeezing, twisting cunt stimulates your over-engorged " + cockDescript(x) + ".\n\n", false);
				//cum
				outputText("Taken beyond your limit, you lose control, feeling the tightness and warmth of your orgasm build at the base of your cock.   It builds and builds, held back by the bee's vice-like cunt, almost becoming painful with its intensity.   Just when you think you can't take any more pressure, you cum, HARD.   Your body clenches hard, spurting out each wave of fuck-juice with more force than the last.    Honey squirts from the bee-slut's fuck-hole, drenching the fuzz on her thighs and your legs with slippery sweetness.   Her cunt doesn't show any signs of slowing down, and your body obliges it, providing more cum than you thought yourself capable of.", false);
				if (player.gender == 3 && player.lowerBody != LOWER_BODY_TYPE_CENTAUR) outputText("  You reach down and finger your " + vaginaDescript(0) + " roughly, lost in the throes of your orgasm.", false);
				outputText("\n\n", false);
				//wind down
				outputText("At last her quivering quim releases your sore member", false);
				if (player.cockTotal() > 1) outputText("s", false);
				outputText(".   Staggering away, you marvel at the scene before you.  The bee-girl is just lying there, her shiny black fingers circling her sopping pussy and pinching a nipple.  Eyes closed, exhausted from her ordeal, the bee-maiden probably won't be getting up anytime soon.\n\n", false);
				//high cum variances
				if (player.cumQ() >= 250 && player.cumQ() < 500) outputText("You smile proudly at the steady stream of your cum that pours from her abused cunt, pooling underneath her.   Her abdomen even looks bloated with your seed.", false);
				if (player.cumQ() >= 500 && player.cumQ() < 1000) outputText("You smile proudly at your handy-work, noting how bloated and distended the bee's abdomen is.  It bulges obscenely, nearly double its previous size.  A sizable river of your spunk drools from between your legs, but amazingly she seems able to keep most of your over-sized orgasm in.", false);
				if (player.cumQ() >= 1000) outputText("You giggle at your poor victim's state.  She really is a mess.  Her abdomen and belly are both swollen, making her look pregnant in both her bee AND human halves.   A practical river of spunk drools from her glossy pussy-lips, pooling below her.  Even her ovipositor dangles down, dripping with your seed, forced out from her abdomen by the sheer amount of spunk she's carrying.  It twitches, bulges moving along its length, eventually dropping egg after egg on the ground, unable to keep in its cargo.", false);
				dynStats("lus=", 0);
				cleanupAfterCombat();
			}
			//Male 2
			else {
				outputText("As you approach she starts to edge away, her battered wings flapping in a futile attempt to escape.  Reaching her, you grip her wrists before she can fight back, squeezing tightly as her struggling increases. Forcing her onto her back, you hold her wrists tightly in one hand to allow you to pull off your " + player.armorName + ", freeing your erect member.  ", false);
				outputText("You begin to push forward, sliding your " + cockDescript(x) + " against the soft folds of her pussy, her whimpers shifting gently into moans. Your grin widens as you penetrate her roughly in one strong stroke, the bee-girl's body tensing underneath you as a squeal leaves her lips. Looking into her eyes, you see a faint glimmer of defiance, and under your body you feel her shifting slightly, muscles growing firm and tense. The realisation hits you, and you manage to shift before her stinger comes into contact with you. Moving your knee, you pin her thick abdomen down and remove the threat.\n\n", false);
				outputText("Unhindered, you start to fuck her. Her pussy tightens and convulses around your cock, becoming slick with her juices and your pre-cum. You can smell the sickly combination of nectar, sweat and love juices hanging thickly in the air. Your breathing becomes heavy while her moans get deeper and lust-filled. Her reluctance evaporates, her struggling shifts into more receptive movements against your body, her hips rocking against yours with each thrust, forcing your " + cockDescript(x) + " deeper into her tight honeypot.\n\n", false);
				outputText("Letting go of her arms, you grip the base of her abdomen for leverage and let her arms and legs slide around you as your pace increases. You feel her abdomen pressing against your rear as you drive into her, the pressure in your " + ballsDescriptLight() + " building as her pussy tightens around you. With a groan you cum, your hot seed gushing inside of her. She clenches you tightly, her pussy milking your " + cockDescript(x) + " for every ounce, until the sticky white fluid is pouring from around your " + cockDescript(x) + ". Exhausted from the battle and the fuck, she relaxes and collapses on the ground, panting heavily and half-conscious.", false);
				dynStats("lus=", 0);
				cleanupAfterCombat();
			}
		}

//FEMALE sometimes herm
		private function rapeABeeGirlWithYourVagina():void
		{
			spriteSelect(6);
			outputText("", true);
			if (player.isTaur()) {
				outputText("The bee-girl plops onto her flower with her legs splayed out, letting you get a clear look at her dripping honeypot. She watches you nervously as you approach, letting her stinger slide out in a pointless threat. She seems taken aback when you smile down at her, but returns the gesture with a nervous smile of her own.\n\n", false);

				outputText("You make your intentions clear by sliding the " + player.armorName + " from your torso and stroking your " + chestDesc() + ". As you slide your hands around your chest and play with your " + nippleDescript(0) + "s, you begin to moan sensually. Your own ministrations cause your " + vaginaDescript(0) + " to heat up and you feel small dribbles of femcum slowly slide down your hind legs. Responding to your arousal, your tail starts to wave about on its own to spread your musky scent and your " + assholeDescript() + " begins to open and close.\n\n", false);

				outputText("The bee maiden is at first confused by the unexpected display, but the combination of sight, sound and smell soon overrides her inhibitions. She spreads her legs wider, letting you see more of her honey-dripping cunt as she begins to finger herself. Her own moans come thick and fast, accompanied by small gushes of sticky fluid and a strong, sweet smell. It mixes with your musk and seems to become trapped in the little clearing, building and building until the pair of you are incapable of thinking of anything but sex.\n\n", false);

				outputText("But while she can reach herself, you can't. The puddle of fluid around your rear hooves continues to grow as your " + vaginaDescript(0) + " becomes more desperate for relief and the muscles in your " + assholeDescript() + " start to ache from the strength of their clenching. You mash your " + chestDesc() + " hard, desperate for release, but it's not enough.", false);
				//[Fuckable nipples: 
				if (player.hasFuckableNipples()) outputText("  Not even repeated penetration of your " + nippleDescript(0) + "s seems to bring the relief you need.", false);
				outputText("\n\n", false);

				outputText("Despite her ability to reach, the bee-girl seems to be having a similar trouble getting herself off. Her hands seem to blur with the speed of her rubbing as her back arcs. She cries out in frustration and begins beating her wings violently, lifting off from the flower.\n\n", false);

				outputText("In a haze of sexual frustration, you leap forward and grab the bee by the hips, dragging her sopping cunt to your lips and eating her out. Her entire body vibrates in your arms but she makes no attempt to stop you, going so far as to push your head further into her crotch and wrapping her legs around you. Your fingers find another hole and penetrate it, thinking it to be her anus. Whether it is or not, you're rewarded with a massive gush of honey coating your face as she cries out and goes limp.\n\n", false);

				//[Breasts >D: 
				if (player.biggestTitSize() > 4) outputText("Her legs release your head and she falls back, knocking into your " + player.allBreastsDescript() + " and causing them to jiggle lewdly. You grab her before she hits the ground, surprised at how light she is.", false);
				//[Breasts <=C: 
				else outputText("Her legs release and she falls back, but you catch her before she hits the ground and are surprised by how light she is.", false);
				outputText("  Her body stiffens as she realizes her situation and with your aid manages to right herself. By now the pressure in your loins is unbearable and you're breathing hard. Your " + nippleDescript(0) + "s ache just as badly as your " + assholeDescript(), false);
				//[Fuckable nipples and/or lactating: 
				if (player.hasFuckableNipples() || player.lactationQ() >= 20) outputText(" and ooze fluids in a constant stream down your front", false);
				outputText(". The bee-girl obviously understands your situation and almost as soon as she's upright buzzes onto your back.", false);

				outputText("The peculiar sensation of her chitin covered appendages climbing along your back is lost on your lust addled mind, but the sudden penetration of your " + assholeDescript() + " is most definitely not. You cry out as the weak contact is more than enough to make you cum, spraying hot femcum beneath you.  Meanwhile, your tongue lolls out of your mouth and you shiver with barely restrained pleasure.\n\n", false);

				outputText("She's not done yet though, as her finger is quickly replaced with a long, wet tongue. It writhes about inside you while cum continues to spray out of your " + vaginaDescript(), false);
				if (player.hasLongTail() > 0) outputText(" and your flailing tail is held firmly in place by her hand", false);
				outputText(". Her other hand slides into your " + vaginaDescript() + " and scrapes around inside, causing an explosion of pleasure inside you. Your love canal grabs her and pulls her arm deeper inside you, your equine muscles making her powerless to resist.", false);
				//[Asses other than tight: 
				if (player.ass.analLooseness >= 2) outputText("  Not wanting this, she attempts to brace her other hand between your " + assDescript() + "'s cheeks, but your " + assholeDescript() + " opens and she slides inside. With an immense effort she pulls out of your ass, nearly pushing you over the edge in the process, but the arm stuck on your vagina is stuck tight.", false);
				outputText("  It's not long before her hand finds your uterus and begin probing it, pushing you beyond your limit.\n\n", false);

				//[Huge cum amount: 
				if (player.wetness() >= 5) outputText("Your vagina ripples and squeezes with enough force to hurt most normal cocks. Her exoskeleton protects her from the harmful effects though, and with a massive gush of fluids the bee-girl's arm is propelled out of you.", false);
				//[All other cum amounts: 
				else outputText("Your vagina ripples and squeezes with enough force to hurt most normal cocks. Her exoskeleton protects her from the harmful effects though, and she slides her arm out of you as you cum.", false);
				outputText("  In the afterglow you feel the wonderful sensation of something thick and sticky dripping off your back. Craning your neck to look, you see that as she was pleasuring you the bee maiden had also been grinding her box against you. Her own orgasms combined with the effort needed to both fight and pleasure you have clearly taken their toll on the frail looking creature, as she's passed out on top of you.\n\n", false);

				outputText("You trot up to the flower and slide the exhausted creature off of you, then rearrange her to be more comfortable. With a final pat on the head and after collecting your things, you head back to camp on slightly wobbly legs.", false);
			}
			else {
				outputText("Firmly grasping her thighs at the joining of her smooth carapace and soft skin, you force them open, revealing the source of her irresistible scent.   She buzzes pitifully in protest as you disrobe, revealing your " + vaginaDescript(0), false);
				if (player.breastRows.length > 1) outputText(" and " + player.allBreastsDescript(), false);
				outputText(".  You waste no time, pushing her down and draping yourself across her body.  You let your ready sex bump her chin as you push her thighs further apart and drink in the scent of her woman-hood.   Mashing your " + vaginaDescript(0) + " against her face, you make it very clear what she is to do, and thankfully, the bee-bitch gets the idea and starts licking.  You coo in pleasure, delighted at the length and texture of her tongue as she goes to work.  ", false);
				if (!player.isTaur()) {
					outputText("You return the favor and dive into her muff, planting kisses in licks down as a reward for your victim's rather skilled efforts.\n\n", false);
					//new PG
					outputText("The taste is sweet and sexy all at once, and you quickly lose track of your reward scheme, simply licking and slurping to get as much of her nectar as possible.  ", false);
				}
				//new PG
				else outputText("\n\n", false);
				if (player.vaginas[0].vaginalWetness < VAGINA_WETNESS_SLICK) outputText("Thankfully her tongue keeps up its assault, curling 'round your clit and probing your depths in equal measure, keeping you slick and writhing in pleasure.  ", false);
				if (player.vaginas[0].vaginalWetness >= VAGINA_WETNESS_SLICK && player.vaginas[0].vaginalWetness < VAGINA_WETNESS_SLAVERING) outputText("Your hips wiggle and writhe on the length of her tongue as it dives into your slippery depths and curls tightly around your clit, jacking it up and down like a cock.  Your girl-cum soaks her chin, drooling happily as she pleasures you.  ", false);
				if (player.vaginas[0].vaginalWetness >= VAGINA_WETNESS_SLAVERING) outputText("Your hips quiver and grind against her face as her unusually long tongue simultaneously probes your depths and works your clit, wrapping around it and jerking it like a cock.   You squirt and drool constantly from her skilled assault, soaking her face and hair with your girl-cum.  ", false);
				if (player.clitLength > 3 && player.clitLength < 5) outputText("Your hips piston your huge clit into her mouth with no warning, forcing her to give your clit a blowjob.  Her slick black lips wrap around it immediately, sucking and licking, filling your body with lust and pleasure.  ", false);
				if (player.clitLength >= 5) outputText("Your hips shove your massive clit into her mouth without warning, stretching her slicked lips wide around your very un-womanly appendage.   She reacts immediately, sucking it into her mouth and throat.  Her tongue curls around it and begins to caress it sensually as she lets you hammer it in and out of her open throat.  Instinctively you mash your face into her sweetened cunt, losing all control of your lower body as it face-fucks her with reckless abandon.  ", false);
				//New PG - orgasm
				if (player.isTaur()) outputText("You orgasm in no time, girl-cum-coating her face in the process.  You return the favor and dive into her muff, planting kisses in licks down as a reward for your victim's rather skilled efforts.  The taste is sweet and sexy all at once, and you quickly lose track of your reward scheme, simply licking and slurping to get as much of her nectar as possible until she is satisfied as well.", false);
				else outputText("In no time you both orgasm, sweet girl-cum coating both your faces as you work each other's cunt with desperation born of desire.  ", false);
			}
			dynStats("lus=", 0);
			cleanupAfterCombat();
		}

//FUTA Fallback
		private function futaRapesBeeGirl():void
		{
			spriteSelect(6);
			outputText("", true);
			outputText("Firmly grasping her thighs at the joining of her smooth carapace and soft skin, you force them open, revealing the source of her irresistible scent.   She buzzes pitifully in protest ", false);

			if (player.isTaur()) outputText("as you idly fondle your " + player.allBreastsDescript() + " as you feel your blood-gorged " + multiCockDescriptLight() + " swaying under your belly.  ", false);
			else outputText("as you disrobe, revealing your " + player.allBreastsDescript() + ", " + vaginaDescript(0) + ", and " + multiCockDescriptLight() + ".  ", false);
			outputText("You step forwards, straddling her and rubbing your outer lips in preparation.  ", false);
			if (player.vaginas[0].vaginalWetness <= VAGINA_WETNESS_NORMAL) outputText("Your " + vaginaDescript(0) + " becomes puffy and moist with excitement, ready for what you have planned.", false);
			if (player.vaginas[0].vaginalWetness > VAGINA_WETNESS_NORMAL && player.vaginas[0].vaginalWetness < VAGINA_WETNESS_DROOLING) outputText("Your " + vaginaDescript(0) + " squicks wetly from your gentle ministrations as your vulva become sensitive and engorged.", false);
			if (player.vaginas[0].vaginalWetness >= VAGINA_WETNESS_DROOLING) outputText("Your " + vaginaDescript(0) + " gushes in response, dripping steadily over your victim's face, covering it with a spattering of girl-cum.", false);
			//New PG
			outputText("\n\nWithout warning, you plant your crotch onto her face, gyrating over her mouth as the defeated bee-maiden struggles against you.  ", false);
			//BALLZ
			if (player.balls >= 2) {
				if (player.ballSize < 5) outputText("Your " + ballsDescriptLight() + " droop into her eyes, blinding and humiliating in equal measure.  ", false);
				else outputText("Your " + ballsDescriptLight() + " obscure most of her face, making it difficult to see her reactions, but her mouth gives you all the feedback you need.  It doesn't take more than a few moments for her struggles to cease, and soon, her long insectile tongue is worming its way into your " + vaginaDescript(0) + ".  ", false);
			}
			outputText("Happy with your victim's compliance, you grind harder into her face.  Allowing your hands a bit of freedom, you begin to stroke your already erect " + cockDescript(0), false);
			if (player.cumQ() < 75) outputText(", enjoying the chance to cut loose and explore your male half.  ", false);
			if (player.cumQ() >= 75 && player.cumQ() < 500) outputText(", smearing your hardness in copious pre-cum and reveling at the marvelous sensation it gives you.  ", false);
			if (player.cumQ() >= 500) outputText(".  A few drops of your pre manage to drip onto her face, mixing with the fluids from your cunt.  ", false);
			outputText("You nearly bounce off her in alarm as her tongue probes deep, pressing against and penetrating your cervix in one slippery stroke.  Being licked from the inside out makes you squeal with equal parts surprise and pleasure, and you mash your " + vaginaDescript(0) + " harder against her in response.  Your hands masturbate your " + multiCockDescriptLight() + " in time with her licks, the speed gradually increasing to keep pace with the fire of your ever-growing lust.  ", false);
			if (player.cumQ() >= 100) {
				outputText(" More and more pre begins to drip from your " + cockDescript(0) + ", soaking your ", false);
				if (player.balls >= 2) outputText(ballsDescriptLight() + " and ", false);
				outputText("the bee-bitch's face.  ", false);
			}
			if (player.breastRows.length > 0) {
				if (player.biggestTitSize() >= 2) outputText("You free a hand to tend to your " + player.allBreastsDescript() + " and aching nipples, alternating between squeezing your female flesh and tugging on your erect nipples.  ", false);
			}
			outputText("\n\n", false);
			//New PG
			outputText("You moan in ecstasy, your " + vaginaDescript(0) + " clamping against her tongue and lips like a vice.  She responds by pulling it from your uterus and swirling it around the inside of your " + vaginaDescript(0) + " to stimulate the walls of your trembling love-canal.  ", false);
			if (player.breastRows.length > 0) {
				if (player.biggestTitSize() >= 2) {
					outputText("You pinch a nipple hard", false);
					//Lactation junction!
					if (player.biggestLactation() > 1 && player.biggestLactation() <= 2) outputText(", squirting milk all over the bee-girl's midsection.  ", false);
					if (player.biggestLactation() > 2 && player.biggestLactation() <= 3) outputText(", spraying milk all over your bee-bitch, soaking her completely with your milky-white goodness.  ", false);
					if (player.biggestLactation() > 3) outputText(", hosing milk everywhere, soaking the bee-girl completely.  The force of your orgasm seems to echo through your breasts, making them produce far more milk than normal.  ", false);
					if (player.biggestLactation() <= 1) outputText(".  ", false);
				}
			}
			if (player.balls >= 2) outputText("The warmth and pleasurable pressure of your male orgasm builds in your " + ballsDescriptLight() + ", growing stronger as it migrates up your groin to the base of your pulsing member.  You squeeze your " + cockDescript(0) + " tightly, trying to hold on a bit longer, but the squirming tongue inside you is too much.  ", false);
			//Mmmmmmangasm!
			if (player.isTaur()) outputText("As you're going to explode, you smile evilly as an idea crosses your mind. You turn around swiftly, leaving her surprised and still in the position of licking your pussy, her slender and squirming tongue out, and her face covered in girl-cum.  ", false);
			if (player.cumQ() < 25) {
				outputText("You erupt, your " + cockDescript(0) + " pulsing and spraying ribbons of cum.  You milk your dick hard, pistoning your hand up and down mercilessly, trying to squeeze out every drop.  You watch each burst splatter into the bee-girl's hair and grin cruelly.  ", false);
				if (player.lowerBody != LOWER_BODY_TYPE_CENTAUR) outputText("Spent at last, you rise up off of her, shivering as her tongue retracts from your woman-hood.", false);
			}
			if (player.cumQ() >= 25 && player.cumQ() < 250) {
				outputText("You erupt, your " + cockDescript(0) + " pulsing in your hands and spraying out thick ribbons of cum.  You milk your dick hard, pistoning it relentlessly as it spurts more and more jism.  The orgasm drags on and on, your cum soaking your poor victim's hair and forehead with your sticky white juices.   Satisfied at last, ", false);
				if (player.balls >= 2) outputText("with empty balls, ", false);
				if (player.lowerBody != LOWER_BODY_TYPE_CENTAUR) outputText("you rise up off her, shivering as her slender and squirming tongue retracts from your " + vaginaDescript(0) + ".", false);
				else outputText("you walk away from her smiling, and sated.", false);
			}
			if (player.cumQ() >= 250 && player.cumQ() < 500) {
				outputText("Your " + cockDescript(0) + " erupts, writhing in your hands from the force of your orgasm as thick ropes of cum burst from you.   Each pulse of juice seems to drag on and on, each nearly as long as a normal man's orgasm.  Looking down, you see the bee's hair and face totally slimed with your cum, and a puddle forming below her.  ", false);
				if (player.lowerBody != LOWER_BODY_TYPE_CENTAUR) outputText("You rise up off of her in mid-orgasm, aiming lower and painting her with each blast of seed.  ", false);
				else outputText("You aim right at the oval of her face and paint her with each blast of seed.  ", false);
				outputText("Your " + cockDescript(0) + " flexes powerfully with each load, until your victim is soaked from the waist up, her breasts and face plastered with goo.  You sigh contentedly and step away, watching the bee scoop up your leavings in both hands, one going to her mouth, the other to her sweet wet snatch.  Giggling to yourself, you walk away, sated.", false);
			}
			if (player.cumQ() >= 500) {
				outputText("Your " + cockDescript(0) + " erupts like a volcano, shooting a constant thick stream of cum that pulses with each clench of your pelvic muscles.  The pressure only seems to increase as your urethra tries to deal with the huge load your body is producing.  ", false);
				if (player.lowerBody != LOWER_BODY_TYPE_CENTAUR) outputText("You stand up off your victim, letting her tongue slip free from your soaked folds, and", false);
				else outputText("You", false);
				outputText(" plunge your " + cockDescript(0) + " deep into the bee-girl's mouth and throat, pumping cum directly into her belly.  She writhes underneath you, her oxygen supply cut off as your spunk floods her belly.  The feeling of her inhuman lips wrapped tight around your base only makes it worse, intensifying the eruption of baby-batter that's pumping into her.  Her eyes roll back as cum begins leaking from her nose, her belly beginning to look distended and pregnant with the amount of jism you've pumped in.   Certain she's had enough, you pull free, marveling at how your last spurt made her look nearly nine-months pregnant.   You note she's passed out, but your orgasm is far from over, so you resume jacking off, hosing her down from head to toe in thick white goop.  ", false);
				if (player.balls >= 2) outputText("Your balls eventually empty", false);
				else outputText("Your body's cum supply eventually empties", false);
				outputText(", and you turn your back on your soaked, cum-bloated conquest and the puddle of spooge that's rapidly wicking into the ground.", false);
			}
			dynStats("lus=", 0);
			cleanupAfterCombat();
		}

//(can replace normal rape victory scenes if corruption>75, and strength>60, and while player has naga tongue, dick, vagina, or d-cup or larger breasts)
		private function beeGirlRapeForTheDistinguishedGentleman():void
		{
			spriteSelect(6);
			outputText("", true);
			//(if win via HP)
			if (monster.HP < 1) outputText("The bee-maiden staggers backward against her perch and wheezes.  Quickly, you launch yourself forward and pin her bodily against the giant flora, grabbing her feebly thrashing arms.  In a flash of inspiration, you pull a long supple leaf from the underside of the blossom, twisting it lengthwise and managing to bind her hands to the stem above her head with your makeshift cord before she can focus on what's happening.\n\n", false);
			//(if lust win)
			else outputText("The bee-girl's knees buckle together and she starts fingering her pussy desperately, too preoccupied to take any offensive posture.  You suavely stroll up to her with a toothy smile and, laying one arm around her waist, gently push her backwards against the giant flower she sat on before.  As she looks at you with interest and confusion displayed equally across her face, you pull a long supple leaf down from the underside of the flower and twist it lengthwise to make a sort of grass rope.  You guide her hands together above her head and tie them to the stem there, quite pleased with your own ingenuity.\n\n", false);
			//---------------------------------

			outputText("Momentarily lost in thought as to where you want to go from here, you don't notice the now-bound and irritated bee's last attempt to turn the tables as her stinger slowly slides free and her abdomen lifts into position to employ it.  ", false);
			//[(if spd<50)
			if (player.spe < 50) outputText("Bracing against the stem and lifting her legs, the bee snaps her stinger up and catches you in the arm, injecting a good amount of venom before you can twist your body away from her wickedly-tipped rear end.  With your other arm you grab hold of the thick fuzz on her bloated abdomen.  This bee bitch really doesn't know her place!  Staring down at the hateful stinger, your eyes drift upwards a bit to the soft area concealing her shriveled black ovipositor, and the anger and pain boiling in you mixes with your already-corrupt thoughts to give you an idea for revenge.", false);
			else outputText("Bracing against the stem and lifting her legs, the bee-maiden flips up her abdomen and the stinger darts towards your side.  Acting quickly, you roll away from it and down, bringing up your arm to hold the bee's abdomen in the air so she can't maneuver it into position for another stab.  What a poor loser this bee-girl is!  Your gaze tracks across the abdomen, taking in the angry little point and the soft spot next to it concealing the bee's ovipositor, and an idea starts to come together in your corrupted, novelty-crazed head.  Grinning even wider, you waggle one finger in reproof at the frightened bee.", false);
			outputText("\n\n", false);

			outputText("Gripping the abdomen firmly by the fuzz, your free hand parts the soft flesh and begins caressing the bee's diminutive black ovipositor, which responds eagerly by growing in size and peeking out.  Within moments your dexterous stimulation has rendered the organ into a knotted shaft and sent the bee herself into a happily-buzzing stupor.\n\n", false);

			//[random effects: roll for one
			var choices:Array = [];
			if (player.tongueType == TONUGE_SNAKE) choices[choices.length] = 0;
			if (player.hasCock()) choices[choices.length] = 1;
			if (player.hasVagina()) choices[choices.length] = 2;
			if (player.biggestTitSize() >= 4) choices[choices.length] = 3;
			var select:Number = choices[rand(choices.length)];

			//(if naga tongue)
			if (select == 0) {
				outputText("As you work your hand up and down the burgeoning black growth, the tip of it opens up roughly an inch and begins to secrete a honey-like fluid that smells of both sweetness and sex pheromones.  In fact, as your oversensitive elongated tongue flits between your lips tasting the air, you decide it's the most appealing smell you've noticed in years!  Almost unintentionally you follow the intoxicating, hypnotic aroma, moving your face closer and closer to the bee-girl's bumpy ovipositor until you're right on top of it.  Finally losing all restraint, you slip your snake-like tongue out of your mouth and down the hole, and you explode with a moan at the incredible taste as the bee-girl simultaneously squeals with rapture at the added stimulation.  Her cunt orgasms and squirts a gob of honeyed juice that hits you right in the side of the face, but you don't care as you're too busy licking up every drop you can find on the slick inner walls and around the mounting number of eggs themselves; bringing up mouthfuls of the amazing substance with your engorged tongue.  You lick for minutes that stretch on like hours and the pheromones in the stuff set off several orgasms of your own", false);
				//[(if penis then)
				if (player.hasCock()) outputText(", spraying the fuzzy side of the bee's abdomen with your sticky come,", false);
				outputText(" before you get enough.  Ahh, who knew that stuff would be this much better when it was still fresh in the bee?  You feel a strong urge to take the girl home with you and make her your 'pantry', but you groggily realize that she has to be fertilized with eggs by the queen bee before she produces your treat.  Shaking your head to clear the sugary haze, you take a firm grip on the bee's knob and decide to enact your original plan now; maybe you can capture the queen later.\n\n", false);
				//(gain 2 libido and 2 sensitivity)
				dynStats("lib", 2, "sen", 2, "lus=", 0);
			}
			//(if penis)
			else if (select == 1) {
				outputText("Seeing the girl's resistance end in an eye-rolling gasp, you decide to get in on the fun too.  With some difficulty you unfasten and shed the bottoms of your " + player.armorName + " with your one free hand and maneuver your " + cockDescript(0) + " to her now-gushing honeypot.  Considering there's enough foreplay going on with her ovipositor to wet her enough for a minotaur, you unceremoniously slam your " + cockDescript(0) + " into her.", false);
				//[(if dicksize>beevagdepth)
				if (player.cockArea(0) > monster.vaginalCapacity()) outputText("  The bee-girl barely winces as the head of your shaft bumps up painfully against her cervix, quickly returning to a rictus of ecstasy as you continue jerking her ovipositor off with your now-sticky hand.", false);
				outputText("  You work up a solid rhythm of fucking the poor girl's sopping snatch and tugging on the grotesque black shaft, never taking your eyes off the bulges forming at the base of her tumescent organ.  Soon you see the telltale bumps of eggs starting to slide into position for a deposit and you grip down harder while jerking the bee-girl off to build up an even bigger load.  Despite her whimpering, she convulses in orgasm from the dual stimulation and her body obliges you, sending up another batch of ready eggs.  The increased pressure forces a squirt of her nectar through despite your tight grip, shooting it nearly a foot in the air before it falls back down and wets the soft fuzz of her abdomen.\n\n", false);
			}
			//(if vagina)
			else if (select == 2) {
				outputText("As the bee-maiden's tongue lolls out of her mouth and she buzzes weakly in pleasure you relax your grip on the downy fuzz of her abdomen and concentrate on the knotty stalk that's steadily growing in your hand.  Thinking to yourself that you might as well have a little extra fun before you go ahead with your idea, you manage to unfasten the bottom part of your " + player.armorName + " one-handed.  After you step out of your clothing, you raise your leg up and straddle the bee's abdomen, then slide your " + vaginaDescript(0) + " down the ticklish fuzzy surface.  The uneven rubbing sensation elicits a gasp of surprise from you.  You feel your " + clitDescript() + " poke out as the fuzz slowly rubs your labia enroute to your anticipated destination. Reaching the end containing the sting and the now-throbbing ovipositor, you lift up your body and position your " + vaginaDescript(0) + " over the latter, then plunge down as honey splashes out of the bee's business end and into your slick folds.  Using one hand wrapped around the stinger to keep it pointed away and the other to grasp a patch of fuzz not yet slicked-up by your pussy juices, you start pumping the black bulging shaft in and out of you.  The honey that escaped into you starts squishing out mixed with your own natural juices, and the increased slickness just makes every thrust that much hotter.  After several minutes of wet penetration you feel the bee-girl's erstwhile invader develop a bumpier pattern and recognize that her eggs must be getting ready to erupt; a few get pushed out by the twitching knob into your pussy, giving you a little shiver of extra pleasure.  You quickly rise up off the bee-girl and grasp the ovipositor firmly while the prematurely-released eggs slip out of your drenched slit and fall onto the ground.\n\n", false);
			}
			//(if D+ breastsize)
			else if (select == 3) {
				outputText("Noticing the bee abating her thrashing resistance in favor of buzzing pleasantly and fixing you with beseeching gazes, and seeking some way to get yourself closer to orgasm so you can climax at the same time as you bring your plan off, you absently stroke the bee's knob as you clumsily unfasten and remove the top part of your " + player.armorName + " with one hand.  Casting it aside, you give an involuntary shudder as a gobbet of warm fluid spattering from the engorged black shaft flies up and lands on your now-exposed " + breastDescript(0) + ".  With your free hand you smear the sensual pheromone-enhanced fluid around your chest, making sure the area between your cleavage is slick, and sending further shivers from your sensitive breast-flesh down your body.  Bending over the increasingly-knotty appendage, you trap it between your " + breastDescript(0) + " and start pushing them up and down its length, all the while tweaking your " + nippleDescript(0) + "s viciously.  The bee-bitch's black pseudo-cock develops new bumps as eggs move up the tunnel in response to your ministrations, rather resembling a far-fetched sex toy.  You pinch your nipples together in one hand and give a little moan while the other hand slides to the tip of the ovipositor and grabs firmly to hold the eggs in until you're ready for her to release them; and then you start sliding your pair of pinched and sensitive nipples up and down the far side of the girl's bumpy rod.  As the eggs backlog in the tool you hold your " + nippleDescript(0) + "s in place around the wet expanding stalk, letting the arriving spheres give you an irregular massage that pushes you to the verge of climax.\n\n", false);
			}

			outputText("You pull your body apart from hers; the bee-maiden's euphoric buzzing takes on a note of panic as her body tenses to release another load of her eggs, only to be prevented yet again by your firm grip on her member.  You make eye contact and smile diabolically, asking if she's ready to release all her pent-up eggs.  She nods vigorously at you and starts pumping her abdomen up and down of her own volition, working her tool into your slick fist and humming with renewed enthusiasm.  You bend her abdomen lightly upward towards your " + buttDescript() + " and her thrusting takes on a quicker pace as she imagines finally getting her load into your " + assholeDescript() + ".  Suddenly you spin around, moving your free hand under the bee's lower abdomen, and push upward and in, HARD.  The poor bewildered bee-girl, already in the middle of an eager upward thrust and directed by your hands' guidance, spears her own pucker with the tip of her ovipositor while the stinger lands directly in her glistening cunt.  Her harmonic humming instantly changes to an ear-splitting vibrato scream as the forceful anal penetration and the venom surging through her sensitive box combine with the agony you've inflicted by twisting her abdomen so severely; but the pain isn't enough to keep her now-massive black ovipositor from forcing out every egg it can now that its end is once again open.  The release of the pent-up eggs triggers another orgasm in the abused bee's body, increasing the sensitivity and therefore the pain of her envenomated cunt and spurring another load of eggs down her damaged abdomen to launch into her own rectum.  Her pained wail reaches an incredible intensity as she orgasms over and over inside herself and you busy the hand you're not using to hold her abdomen in place to ", false);
			//[(if dick)
			if (player.hasCock()) outputText("stroke your " + Appearance.cockNoun(CockTypesEnum.HUMAN), false);
			else if (player.hasVagina()) outputText("rub your " + vaginaDescript(0), false);
			else outputText("tweak your " + nippleDescript(0) + "s", false);
			outputText(", laughing as you climax", false);
			//[(if dick, squirter vag, or lactating)
			if (player.hasCock() || player.lactationQ() >= 100 || player.wetness() >= 5) outputText(" and spray your sticky fluids all over her tortured groin", false);
			outputText(".\n\n", false);

			outputText("Damn, that probably did some ear damage but was it ever worth it!  The bee-girl, having finally redirected every egg she had into her own swollen butthole and ceased climaxing, passes out.  You gather your things and leave her contorted and soaked body behind you as you head back to camp.", false);
			//(gain 20 fatigue if spd<50)
			if (player.spe < 50) fatigue(20);
			dynStats("lus=", 0);
			cleanupAfterCombat();
		}


		private function beeAlternate():void
		{
			spriteSelect(6);
			var x:Number = player.biggestCockIndex();
			var y:Number = player.biggestCockIndex2();
			//MULTIPLE MULTIPLE SCENES!
			if (rand(2) == 0) {
				outputText("The dazed bee-woman stumbles, and you grab her abdomen just above the stinger.  Lifting it high, you force her onto her knees, and then to bend her over, lowering her antennae to the ground.  With a heroic effort, you force her stinger into her own shoulder.  The bee-girl thrashes wildly a moment, then moans as the venom you've forced her to inject into herself begins to take effect.  Her motions become less frantic and more wanton, and thick honey begins to drool from her exposed pussy, some of it dribbling down her inner thighs.", true);
				//New PG
				outputText("\n\n", false);
				if (player.cocks[x].cockType == CockTypesEnum.TENTACLE) outputText("You loosen your " + player.armorName + " and unleash your cocks.  The largest cock - a tentacle - strains towards the bee-girl's pussy, clearly eager to sink itself into her warm, sticky confines.  Taking it in hand, you guide the mushroom-like glans against her pouting netherlips.  The bee-girl gasps and squirms, her motions clearly more in eagerness and humiliation than any serious attempt to escape.  You drag the broad head of your tentacle-cock up and down, gathering a thick coating of honey on it before releasing it.  Your cock strains against her folds, then sinks in slowly as you push your hips forward, and you sigh happily as you feel her warmth surround you.  She moans and arches her back even more, her antennae drooping submissively as your agile phallus squirms about inside her, stretching her tight little passage and leaving no nook or cranny unexplored.  ", false);
				if (player.hasKnot(x)) outputText("You loosen your " + player.armorName + " and unleash your cocks.  Taking the largest in hand, you stroke its knobby shape until it's sufficiently stiff, then press the pointed end against her clit, teasing the little nub.  The bee-girl gasps and squirms, pushing her now pouting clit back against you.  You drag the tip up, gathering honey as you go until you reach her opening, then thrust with your hips.  Her pussylips part eagerly, and you find her tight but welcoming.  Still, as tempting as it is to rut the girl with abandon, you hold back, never letting your knot sink inside her.  ", false);
				if (player.cocks[x].cockType == CockTypesEnum.HORSE) outputText("You loosen your " + player.armorName + " and unleash your cocks.  The equine flare of the largest is already drooling pre as you enjoy the sight of the helpless, squirming bee-girl.  Swinging it like a flogger, you spank her ass, making the girl yelp and leaving trails of sticky pre across the globes of her ass.  Grinning, you drag your shaft back and forth across her pussy, slicking it in her honey.  Finally, you press the tip against her opening.  She's a tight fit for you, and she squeals more loudly as your shaft spreads her little cunny inexorably.  ", false);
				//Catchall scenario
				if (player.cocks[x].cockType == CockTypesEnum.DEMON || player.cocks[x].cockType.Index > 4) outputText("You loosen your " + player.armorName + " and unleash your cocks.  The glans of the largest is already drooling pre as you enjoy the sight of the helpless, squirming bee-girl.  Guiding it forwards, you spank her ass, making the girl yelp and leaving trails of sticky pre across the globes of her ass.  Grinning, you drag your shaft back and forth across her pussy, slicking it in her honey.  Finally, you press the tip against her opening.  She's a tight fit for you, and she squeals more loudly as your shaft spreads her little cunny inexorably.  ", false);
				//CONTINUE
				outputText("You enjoy loosening the girl up and exploring the depths of her cunt, taking your time.  Eventually, you draw yourself out of her, your " + cockDescript(x) + " escaping with a wet, slurping sound, dragging a thick drool of honey in its wake.  Taking a moment to inspect your handiwork, you see her pussy gapes wantonly, stretched out of shape by your shaft.", false);
				//New PG
				outputText("\n\n", false);
				//2nd cock love
				outputText("Taking your slightly smaller " + cockDescript(y) + " in hand, you slip it in as a replacement.  She's not as tight as she was, poor dear, but just as warm and twice as slick as she was for your first " + cockDescript(x) + ".  Your larger " + cockDescript(x) + " slides along the side of her ass, painting the black-and-yellow fur there with her honey and matting it down.  But that's less than satisfying, and glancing down, you notice she has a hole back here that's not getting used.  ", false);
				outputText("Withdrawing from her once more, you set the tip of your largest " + cockDescript(x) + " against the pucker of her ass.  She squeals and bucks as you press against her sphincter, but it's not long before the ring of muscle surrenders and your honey-soaked " + cockDescript(x) + " slides into her body.  She whimpers in humiliation, hands clawing at the grass as she shifts her hips to try to get more comfortable around your thickness.  You root around in the exquisite tightness of her ass, enjoying the way she shifts and wriggles under and around you.", false);
				//New PG
				outputText("\n\n", false);
				outputText("Drawing nearly, but not entirely, out of her, you take up your next largest cock and set it back at the entrance of her pussy again, and then thrust with your hips, sinking your largest deep into her ass while spearing her once more, burying your " + cockDescript(y) + " in her pussy.  She squeals loudly, wings flapping wildly a moment, then goes utterly limp with a whimper of surrender.  Grinning broadly, you begin to piston in and out of her, the sweet perfume of her lust wreathing your nostrils.  The plundering of her nether-regions fills the air with wet, slurping sounds, and soon she is moaning in time with every thrust, antennae quivering with need.  ", false);
				outputText("You feel the pleasant quickening in your shafts and you redouble your efforts, fucking her harder with every thrust until, with a gasp of release you arch your back and nearly push her across the grass.  Your quivering cocks tremble in her depths, flooding her body with your seed.  The bee-girl lets out a trilling, buzzing shriek, then goes limp around you, her quivering muscles milking you of your seed.  Panting, you slip from her now-gaping holes.  The poor dear appears to have passed out; she slumps onto her side, your seed drooling out of her twitching body.  After wiping yourself clean on her fuzzy thigh, you arrange your clothing and search about for any loot the bee-girl may have had.", false);
			}
			else {
				outputText("After falling to the ground, the bee-girl looks up in dazed fear as you expose your " + multiCockDescriptLight() + ", her eyes watching as you throb with lust at the scared and helpless look on her face.", false);
				//New PG
				outputText("\n\n", false);
				outputText("Once you're close enough, you grab her by the arms and force yourself down against her, shifting your knees to spread her legs.  Your " + multiCockDescriptLight() + " slap down against her slightly slick " + Appearance.vaginaDescript(monster,0) + ". Her face lights up with a look trapped somewhere between apprehension and interest at the unexpected touch, although the interest doesn't stop her from struggling valiantly to try and get away from you.  Finally, you force her arms against the ground and spread her wide enough to impale her " + Appearance.vaginaDescript(monster,0) + " on one of your " + multiCockDescriptLight() + " while watching her face contort with an alluring mixture of enjoyment and pain.  Her struggles weaken as you start to pound into her, tight abdominal muscles relaxing under you as she throws back her head, releasing a whimper at the rough penetration.  ", false);
				outputText("At first, taking her more than satisfies you, but an idea strikes as you watch her face become distracted with each body-shaking thrusts of your hips.  Grabbing your remaining " + cockDescript(1) + " you push it against the already-impaled member, and on the next thrust you drive them both in.", false);
				if (player.averageCockThickness() > 2) outputText("  She stretches against you amazingly, squeezing down on you like a vice.  You theorize it's only because of her strange body and the copious amounts of honey she's leaking against you that you aren't ripping her apart.", false);
				//New PG
				outputText("\n\nThe bee-girl shakes violently and screams in equal parts buzz and moan as a thick torrent of honey splashes against your dual members, making the pair of them slide in that much easier.  Her arms move up, the free one grabbing at your shoulder and clutching hard enough to leave bruises while the other squirms under your hand, her body tense under you. Stretched to the brink by the pair of " + cockDescript(99) + "s, her hole is like a vice against you and every thrust visibly stretches her. The more you thrust the wetter she gets and her eyes seem to be wildly fluttering underneath you as you take her, her struggles turning to her thrusting her lower body up against you appreciatively. Your " + cockDescript(99) + "s slap and pound into her abused " + Appearance.vaginaDescript(monster,0), false);
				if (player.balls > 0) outputText(" with your " + ballsDescriptLight() + " hitting her abdomen hard enough to make smacking sounds ring out in the forest around you.", false);
				else outputText(".", false);
				//New PG
				outputText("\n\n", false);
				//Extra multicock text
				if (player.cocks.length >= 3) {
					outputText("As you pound into her, you realize that large amounts of her juices are leaking from her " + Appearance.vaginaDescript(monster,0) + " over her abdomen, against the hole near the base of her stinger.  Reaching down with wicked intent, you grab one of your free " + cockDescript(99) + "s and force it against her tight asshole while you pull your hips back.  Her eyes widen as she looks up at you, renewing her struggles as she kicks her legs at you, her wings slapping the ground with fierce determination as she tries to wriggle away.  You hold her tightly, pushing your hips against her to bury your " + multiCockDescriptLight() + " inside her.  The flow of honey barely lessens the friction as your " + cockDescript(2) + " sinks into her ass inch by inch.  Her " + Appearance.vaginaDescript(monster,0) + " is stretched even wider and she screams out something that sounds like a humming moan as her asshole begins to gape a bit with each of your thrusts...It takes a minute or two, but finally you hit bottom with all three of your " + cockDescript(99) + "s.\n\n", false);
				}
				//Orgasm PG
				outputText("After a while of fucking her, her buzzing complaints and wild struggles begin to melt as she cums against you, shuddering and forcing her hips up towards you, plunging your " + cockDescript(99) + " into her even deeper.  She begins to climax, her muscles becoming more and more relaxed with each time her stretched holes squeeze down on you.  Surges of pleasure begin to overwhelm you and soon you begin fucking her as hard as you can, honey splattering wetly over her body as she finally seems to collapse under your body's assault. Her eyes dim visibly, the buzzing cries of pleasure echoing faintly from her lips while her body goes completely limp underneath you.  Not to be stopped, you continue to take her, eventually feeling seed swell up inside ", false);
				if (player.balls > 0) outputText("your " + ballsDescriptLight() + " ", false);
				else outputText("your prostate ", false);
				outputText("as you plunge into her. Your release is very large, splattering her slick walls with thick loads of cum as you plunge as deep as you can thrust inside her.", false);
				//Lots of cocks bonus cum texts
				if (player.cocks.length >= 3) {
					outputText("  Her battered " + Appearance.vaginaDescript(monster,0) + " grips down on your dual " + cockDescript(99) + "s tightly, draining you of every drop she can.  Rivers of white begin to leak from her abused holes and mingle with her own release as it trails down her abdomen and drips off it slowly onto the forest floor.", false);
					if (player.cocks.length == 4) outputText("  The " + cockDescript(99) + " not inside her shakes wildly as you cum, jets of your semen let loose over her abused frame, coating her in white.", false);
					if (player.cocks.length > 4) outputText("  The " + cockDescript(99) + "s not inside her shake wildly as you cum, jets of your semen let loose over her abused frame, coating her in white.", false);
				}
				//New PG
				outputText("\n\n", false);
				outputText("The both of you smell like sex as you pull free of her with a groan.  You move to kneel over her and use her unstained lips to dry your " + multiCockDescriptLight() + " one by one.  Her lips part slightly on instinct and you can feel her swallow the globs of jism that coat you.  Once she's done you stand up quickly, ", false);
				if (player.lowerBody != LOWER_BODY_TYPE_CENTAUR) outputText("stuffing your " + multiCockDescriptLight() + " inside your " + player.armorName, false);
				else outputText("your glorious but spent " + multiCockDescriptLight() + " dangling under your belly,", false);
				outputText(" and leave the completely exhausted and drenched woman on the forest floor, wings and legs still twitching slightly, sending a fine mist of cum across the ground around her.", false);
			}
			dynStats("lus=", 0);
			doNext(13);
			cleanupAfterCombat();
		}

//Naga on Bee Scene
		private function corruptNagaBitchesRapeABee():void
		{
			spriteSelect(6);
			outputText("", true);

			outputText("Now that the bee-girl is unable to flit her wings and create that buzzing drone that seems to rob you of your senses, you can see her for what she truly is: Prey.\n\n", false);

			outputText("She struggles against the coil of your tail, but her thin limbs are nothing compared to the rippling cord of muscles that makes up your lower half. You can feel her abdomen pulsing as if trying in vain to sting you, but you have her completely immobilized. \"<i>Pleazzze,</i>\" she begs, \"<i>Don't hurt me… I juzzzt wanted to zzzerve my queen.</i>\"\n\n", false);

			outputText("You stare into her eyes with your reptilian gaze and flit your tongue in response, as much to increase her anxiety as to taste her heat and her fear with the vomeronasal organ in the roof of your mouth. Even from here, you can taste the fragrant liquid dripping out of her honeypot and coating your scales. Though it is divine, you know you are in complete control.\n\n", false);

			outputText("She shuts her eyes out of fear at first.  \"<i>Pleazzze,</i>\" she continues to plead for her life, \"<i>Don't eat me! I have children! Thousandzzz of them!</i>\" You ignore her cries and gaze mercilessly at her – savoring her desperation. As time passes, she comes to realize that she hasn't been eaten yet. The bee-girl opens her eyes slowly, one after the other – and that's when you know you have her.\n\n", false);

			outputText("\"<i>What…</i>\" she asks hazily, \"<i>What are you zzztaring... at...</i>\" Her words begin to trail off as your gaze locks with hers, hypnotizing her. You watch as her lids begin to droop, and you can feel her muscles becoming slack within your coils. The emotionless expression you're wearing hides the sheer delight you feel.\n\n", false);

			outputText("It takes a few minutes, but you relish every second of the bee-girl's conscious mind slipping away. You unwind your tail from around her, never breaking your gaze for even a second. To your pleasure, your captive continues to stand still on her own volition.", false);
			doNext(nagaRapesPt2TheExtremeContinuationOfAwesome);
		}

		private function nagaRapesPt2TheExtremeContinuationOfAwesome():void
		{
			spriteSelect(6);
			outputText("", true);
			//[Player is male]
			if (player.gender == 1 || (player.gender == 3 && rand(3) == 0)) {
				outputText("By now ", false);
				if (player.cockTotal() > 1) outputText("each of ", false);
				outputText("your " + multiCockDescriptLight() + " is aching for release, and you tear off your " + player.armorName + " just in time as ", false);
				if (player.totalCocks() > 1) outputText("they free themselves from ", false);
				else outputText("it frees itself from ", false);
				outputText("the slit between your legs.  Without needing to say a word, the message is transferred across some unknown medium: Suck my cock", false);
				if (player.totalCocks() > 1) outputText("s", false);
				outputText(".\n\n", false);

				outputText("The bee-girl drops to her knees and stares up at you vacantly. Your eyes never break contact: not while she wraps her tongue around ", false);
				if (player.totalCocks() > 1) outputText("one of ", false);
				outputText("your " + multiCockDescriptLight() + ", slurping soundly and driving you wild; ", false);
				//[if player has testicles] 
				if (player.balls > 0) outputText("Not while her hands cup your " + sackDescript() + " and knead tenderly, infusing you with the craving for release; ", false);
				else outputText("not ", false);
				outputText("even when she takes your " + cockDescript(0) + " to the hilt, her eyes straining up in their sockets. You watch " + int(player.cocks[0].cockLength) + " inches of " + cockDescript(0) + " disappear inside her mouth, and the vibrations in her throat tell you that you'd hear her cooing if it wasn't packed tight.\n\n", false);

				outputText("Higher and higher you climb as your hypnotized handmaiden ceases stroking you with her lips and begins swallowing repeatedly, milking your hardness for all it's worth. Her chest begins to contract, and from the periphery of your vision you can tell that she's futilely trying to gulp in air. The contractions force her to milk you even more; ", false);
				//[if player has testicles]
				if (player.balls > 0) outputText("your " + sackDescript() + " clenches as ", false);
				outputText("you explode inside her chest, ", false);
				//[normal cum load]
				if (player.cumQ() < 50) outputText("a burst of cum settling itself in her belly.", false);
				//[medium cum load]
				else if (player.cumQ() < 1000) outputText("rope after rope of cum shooting into her belly.", false);
				//[large cum load]
				else if (player.cumQ() < 2500) outputText("waves of cum pumping into her belly and visibly bulging it out.", false);
				//[huge cum load] 
				else outputText("an unending stream of cum gushing into her belly and stretching it out significantly.", false);
				outputText("  Just as her eyes start to roll back into her head, you pull out to the sound of her desperate gasp for air.\n\n", false);

				outputText("You check her unconscious form – now lying on the ground – for signs of life. Relieved that she is breathing, you turn and leave her where she is.", false);
			}
			//[Player is female]
			else if (player.gender == 2 || (player.gender == 3 && rand(2) == 0)) {
				if (player.vaginas[0].vaginalWetness < VAGINA_WETNESS_WET) outputText("Damp", false);
				else if (player.vaginas[0].vaginalWetness < VAGINA_WETNESS_DROOLING) outputText("Wet", false);
				else if (player.vaginas[0].vaginalWetness < VAGINA_WETNESS_SLAVERING) outputText("Dripping", false);
				else outputText("Soaking", false);
				outputText(" with lubrication, you demand to be satisfied. With one hand you point to your " + vaginaDescript(0) + ", and you snap your fingers with the other. Your prey saunters up to you with a vacant, distant look in her eyes and begins to remove your " + player.armorName + " obediently. You tenderly caress her cheek as she finishes, and watch a rosy glow infuse her skin. Your captive handmaiden runs her hands tenderly up your body, smoothing the flesh of your " + biggestBreastSizeDescript() + " and making you pant. You allow yourself to enjoy the sensation for a brief while, and just before you can snap your fingers again, she goes down on her own.\n\n", false);

				outputText("Her eyelids flutter even as her gaze remains locked, and she deeply inhales your musky and arid scent. Deep inside, you feel a level of affection that isn't betrayed by your facial features. You gasp as the bee-girl's lengthy tongue shoots inside your snatch, and retracts as quickly as it came; once, twice, again and again, striking your cervix and twisting out again. Her hands grip your scaly " + hipDescript() + " as she thrusts her tongue in and out, threatening the fixation of your glare with pleasure. You are moaning and screaming in your mind, while your stony expression betrays nothing; nothing but the locking gaze that makes your will her own. The bee-maiden's mouth wraps around your " + clitDescript() + ", rubbing it through its hood with the inside of her upper lip until it protrudes its full length.", false);
				//[if clit size => 1"]: 
				if (player.clitLength > 1) outputText("  Emergent from its sheath, she uses the base of her tongue as a bottom lip and begins to suck you off like a cock, unceasing in her lingual assault on the inside of your canal.", false);
				outputText("\n\n", false);

				outputText("You cry out when her tongue finds your G-spot, barely maintaining focus. Sensing your approval, she begins probing the same area until she has you crying out again, and begins hammering at the spongy tissue.\n\n", false);

				outputText("A feeling like the urge to pee overwhelms you, and lost inside to your pleasure, you give in.  ", false);
				if (player.vaginas[0].vaginalWetness < VAGINA_WETNESS_SLICK) outputText("A few drops ", false);
				else if (player.vaginas[0].vaginalWetness < VAGINA_WETNESS_DROOLING) outputText("A gush ", false);
				else if (player.vaginas[0].vaginalWetness < VAGINA_WETNESS_SLAVERING) outputText("Wave after wave ", false);
				else outputText("Buckets ", false);
				outputText("of female ejaculate sluice down her cheeks and she coos happily. She retracts her tongue and presses her face into your tender flesh, pantomiming affection but still looking up at you blankly.\n\n", false);

				outputText("You let yourself blink and break the hypnotizing glare, watching as life returns to her features. You pet her head affectionately and thank her, leaving her to piece together what the hell just happened.", false);
			}
			//[Player is herm]
			else if (player.gender == 3) {
				outputText("Fantasies course through your mind as you remove your " + player.armorName + ", filling your thoughts with all the things you can do to your mind-slave using your particular... endowments. Licking your lips, you bring your hand to the bee-girl's chin, gently moving her pretty face from side to side and examining her in your peripheral vision. Her eyes stay glued to yours even as you move her around. You're going to enjoy this.\n\n", false);

				outputText("You place a hand on top of the bee-girl's head, and watch as she drops to her knees, craning her head to continue looking up at you. With a fistful of hair in one hand, you point to her wrist and crook your finger in a 'come hither' motion, and gesture towards your scaly snatch. Like clockwork, her arm reaches up and two fingers go inside you, seeking out and quickly finding that spot of spongy tissue up and behind your pubic bone. You begin to pant involuntarily as she starts to work it rhythmically. You let her settle into a steady pace before moving on to her next task.\n\n", false);

				outputText("Touching a single index finger to the underside of your captive's chin, you pull with the slightest of forces and watch as she is dutifully drawn to your " + multiCockDescriptLight() + ", running her lengthy prehensile tongue up and down ", false);
				if (player.cockTotal() > 1) outputText("each of your shafts", false);
				else outputText("your shaft", false);
				outputText(". As the pulsing movement inside your body draws you slowly closer to orgasm, the bee-bitch uses her other hand to draw your " + cockDescript(0) + " down to an angle so it slides neatly into her throat", false);
				//[if Player cock => 12\"]
				if (player.cocks[0].cockLength > 12) outputText(", surprising you with its elasticity", false);
				outputText(".", false);
				//[if Player has multiple cocks]
				if (player.totalCocks() > 1) {
					outputText("  Letting go once it is fitted neatly inside, she uses her free hand to stroke your other cock", false);
					//[three or more]
					if (player.cockTotal() > 2) outputText("s, giving each a few pumps before moving on to the next", false);
					outputText(", driving you closer and closer to the edge.", false);
				}
				outputText("\n\n", false);

				outputText("Gulping, slurping, ", false);
				//[if Player has multiple cocks]
				if (player.cockTotal() > 1) outputText("jacking, ", false);
				outputText("and finger-fucking in tandem, you can't help but admire the fragile creature giving you such unpronounceable pleasure. It isn't long before the tenacious beauty has you riding over the edge, and your transfixing gaze is almost broken as the orgasm explodes out of your orifices, drenching her and firing down her throat. As her chest starts to heave from lack of oxygen, you pull out, turn, and leave her there in a heap.\n\n", false);
			}
			//[Player is neutered]
			else {
				outputText("Trapped inside your gaze, you tower over your captive and figure out how to proceed. Your lack of genitals requires you to come up with some creative solutions, and you decide to put your right brain to the test. For a moment, the two of you remain motionless save for the occasional flick of your tail. That's when you get an idea.\n\n", false);

				outputText("You press the flat of your hand into her chest, indicating her to lie down. With some effort, she lowers herself awkwardly into a prone position, shimmying over her own abdomen and unable to look away. You position yourself between her legs and run your hands down the bulbous protrusion emanating from her tailbone; carefully, to avoid her stinger. Feeling your way around with your hands, you locate a fold of flesh just above the poisonous barb, and having finding what you were looking for, unflinchingly insert a finger. It comes back out coated in a slick yellow goo that delights your senses of taste and smell. You return your hand; first with two fingers, and then three. An appendage textured with bumps and knots with an orifice at its tip begins to emerge, and you know you have found your target.\n\n", false);

				outputText("The bee-girl's expression is blank and vacant, but you can tell by the heat coming off of her, the fresh smell of her pheromones and the flush of her skin that she is getting off on it. You bunch your fingers together to form a point, tucking your thumb as close into your palm as it will get, and slide your fist inside her ovipositor.\n\n", false);

				outputText("Despite her hypnotic state, the bee-girl's mouth opens and her breathing becomes heavy. Her eyes remain fixated on yours in spite of the violation, devoid of consciousness. Warm wetness surrounds first your fingers, and you can feel the elastic flesh straining against your knuckles before giving way with a satisfying slurp. Displaced honey oozes out around your wrist, then your forearm, and finally your elbow. Something brushes against your fingers – an egg! Not wanting to push any deeper for fear of damaging your delicate host, you pull back a few inches and ball your hand into a fist.\n\n", false);

				outputText("You pull your arm back out to the wrist, coated with a thick layer of the bee-bitch's internal fluids, before punching back inside carefully to avoid damaging any eggs. Thinking this an amusing time to let her come back to reality, you break the glare that has been keeping your plaything rapt and attentive, and start thrusting with vigor. There is a brief moment of confusion before the stimulation catches up to her, and quickly you have her screaming and thrashing so much that you have to hold her stinger down with your other hand. You bend your head down towards her clit, and with a single flicker of your forked tongue, send her into a mind-shattering orgasm that scares away the birds for miles.\n\n", false);

				outputText("You pull your hand out and futilely try to wipe away the gunk on a nearby bush. The handmaiden is collapsed in a heap, excreting eggs from her dilated organ, mumbling blissfully delirious nonsense.  Gathering your things, you slither away.", false);
			}
			if (player.gender > 0) dynStats("lus=", 0);
			doNext(13);
			cleanupAfterCombat();
		}

		public function milkAndHoneyAreKindaFunny():void
		{
			spriteSelect(6);
			outputText("", true);
			player.slimeFeed();
			outputText("You sit the bee-girl up; she's a bit dazed from the fight as her head moves in circles.  You kiss her honey-flavored lips, sticking your tongue into her mouth and causing her to snap out of her daze.  She's surprised at this unexpected show of affection, but understanding her situation, she begins kissing you back.  Both of your tongues rub and slide against one another as you occasionally plunge into each other's mouth.  Your hand rubs up her thigh onto her honeypot.  You drive two fingers into it, circling them around.  Making sure they are covered in her sweet love-honey, you pull the two fingers out and raise them up.  The bee-girl sees your honey-covered fingers and slowly pulls back from the kiss.  You suck the honey off the index then you point the middle at her mouth and push forward.  Her lips wrap around the finger and suck it into her mouth as her tongue laps around it, cleaning all the honey off it.  You take the finger out of her mouth and examine the work she did.\n\n", false);

			outputText("\"<i>Do you know what goes great with honey?</i>\" you ask.\n\n", false);

			outputText("The bee-girl ponders your question.  \"<i>Izzz it zex?</i>\"\n\n", false);

			outputText("You chuckle at her answer.  \"<i>Yes, but milk is also great with honey.</i>\"\n\n", false);

			outputText("\"<i>What izzz milk?</i>\" she asks.\n\n", false);

			outputText("Your chuckling becomes louder.  ", false);

			outputText("\"<i>Why don't you suck on one of my tits and find out?</i>\" you ask as you remove the top part of your " + player.armorName + ".  Curiosity gets the better of her as she picks a nipple and sucks on it.  Her curiosity is rewarded with a gush of milk down her throat.  Surprised that something is coming out, she recoils back.\n\n", false);

			outputText("The bee-girl questions, \"<i>What wazzz that?</i>\"\n\n", false);

			outputText("\"<i>That was milk, was it good?</i>\" you tease.\n\n", false);

			outputText("She pleads, \"<i>Yezzz it wazz, may I have more?</i>\"\n\n", false);

			outputText("\"<i>Sure, if I can have more honey.</i>\" you offer.\n\n", false);

			outputText("The bee-girls nods her head and goes back to sucking on the nipple as you reach your hand down to rub honey off her flower. There isn't a lot on your fingers when you raise them up to be cleaned; you guess you'll have to stimulate the flower's bud if you want more honey. You reach back down, caressing her little clit as she lets out a muffled moan that sends vibrations through your nipple and " + breastDescript(0) + ".  More honey glistens on her flower; you rub what honey you can get onto your fingers and suck them off while the bee-girl is enjoying her easy meal.  She's getting the better end of the agreement, barely having to put any effort into her nursing.  You continue scraping up as much honey as you can, and though more honey leaks out as you go on, it's not enough to satisfy your sweet tooth or hunger.  She sees her honeypot isn't giving as much as your milk jugs.  Once she has her fill, she hands you a jar and stands up.\n\n", false);

			outputText("\"<i>Hold thiz jar cloze to my puzzzy and catch the honey with it.</i>\"\n\n", false);

			outputText("Her shiny black vulva is sticky and puffed with arousal, and she is desperate to cum.  She finds her little pleasure bud and rapidly strokes the already swollen button. She throws her head back and pushes her pelvis forward against the jar as she sprays hot honey into the jar.  It quickly fills the jar and the excess spills over onto her pussy and the ground.  She pulls back from the jar with an indentation of the jar's circle on her soft vulva.  She hands you a lid, shakes your hand and thanks you for the exchange in sweet fluids.  \"<i>Maybe we do thiz zome other time.</i>\"", false);
			//[You have found 1xBee Honey]
			flags[kFLAGS.FORCE_BEE_TO_PRODUCE_HONEY] = 1;
			//set lust to 0, increase sensitivity slightly
			dynStats("lib", .2, "lus", -50);
			//You've now been milked, reset the timer for that
			player.addStatusValue("Feeder", 1, 1);
			player.changeStatusValue("Feeder", 2, 0);
			cleanupAfterCombat();
		}


//requires spiderbite or nagabite
//Play standard victory text
		private function layEggsInABeeSpiderLike():void
		{
			clearOutput();
			outputText("You stand over the defeated bee, sizing up your latest catch.  She watches you fearfully as your gaze slides down her prone form, taking in every inch of her body.  Your eyes stop over her abdomen as you notice the girl's dripping, barely concealed ovipositor.  A wide");
			if (player.faceType == FACE_SNAKE_FANGS || player.faceType == FACE_SPIDER_FANGS) outputText(", fanged");
			outputText("smile breaks across your face, and your captive quivers in response.  Her eyes flick from your mouth to your spider half, and she shivers again.");

			outputText("\n\nYou lower your torso toward her, leaning in close enough that she can feel each breath on her skin.  She's frozen in place now, every muscle clenched tight with terror, and you savor her fear as you run your tongue up her neck.  Picking the insect-girl up by her shoulders, you release a contented \"<i>Mmmm</i>\" into her ear before flipping her over and dropping her, leaving the  bee face down in the dirt.");

			outputText("\n\nYou reverse yourself above her, pinning her struggling hands down with your rearmost legs while your spinneret twitches once before expelling a thick glob of web, firmly anchoring her limbs to the ground.  Spinning back around, you cock your head to the side pensively, trying to decide the best 'pose' for the trembling bee-slut.  Deciding on one that would allow you the most access, you push and pull at her hips till she's raised her ass high into the air; another spurt of webbing ensures that she'll hold the pose until you get tired of it.  As you step back to admire your handiwork, she curls her striped abdomen between her legs, trying to conceal the source of the slick trail running down her thigh.");

			outputText("\n\nStepping closer once again, the frantic glances the trapped insect throws over her shoulder begin to stir something primal in you.  Gently prising her insectile half from around her bottom, you hold it overhead while you move in closer, holding yourself a few scant centimeters from her dripping sex.  A few more pointed comments about how delectable she looks has her struggling against her bonds as you lick and nip at her plush derriere.");

			outputText("\n\nYour eyes focus on her tight pucker, and idle wondering about how the bees deal with their eggs when no one else is available rapidly coalesces into a plan of action that brings an even greater smile to your face.  A few tentative prods with your finger reveals a crushing tightness; you are most certainly going to need some additional lubrication.  How lucky that you have a <i>willing</i> source...");

			outputText("\n\nSinking your fangs into the antennae-capped girl's cushiony cheek throws her into an immediate frenzy, her wings blurring frantically with a high-pitched buzz.  Her whole body shivers as your venom burns through her veins, setting her lust alight and turning the slow drip of her arousal into a steady stream of nectar.");

			outputText("\n\nLathering the bee's sweet-scented honey onto one hand, you work your fingers into her tight asshole one at a time, thoroughly lubing and leaving it gaping ever so slightly when you pull yourself free.  Pushing yourself back up, you maintain your hold on her chitinous posterior while you arrange your own, lining up your dripping egg-spike with her newly wet hole.  Catching sight of your growing ovipositor causes her to finally break her silence, but her pleas turn into a strangled moan as you force nearly a foot of yourself into her with your first push.  Her heavy panting accompanies the slapping noise of you thrusting your ovipositor in and out of her trembling hole, trying to fit as much of it into the bound bee-girl as you can.");

			outputText("\n\nWith a powerful wet-sounding slap, you bottom out inside her, and your moan of satisfaction mixes with her panicked gasp as your egg-tube flares deep inside her, filling her innards with its thick lube.");
			if (player.gender > 0) {
				outputText("  With another lewd groan,  you wrap your arms around her bee abdomen, grinding ");
				if (player.hasCock()) outputText("[eachCock]");
				else outputText("your [vagina]");
				outputText(" against her in bliss, leaving a sticky trail dripping down onto her gropable cheeks.");
			}
			outputText("  You shudder in ecstasy as you feel the first egg slide out of your abdomen, slowing to a halt just shy of her clenched ring.  More eggs file in behind it, piling up outside her rear entrance, and finally the muscular contractions of your shaft win over her exhausted sphincter, eggs rushing forward into her awaiting warmth.");

			outputText("\n\nThe bee's groans take on a decidedly orgasmic note as she shudders beneath you, arms and legs going slack against her bonds, while her stomach swells out with the burden of your ");
			if (player.fertilizedEggs() == 0) outputText("unfertilized");
			else outputText("fertilized");
			outputText(" eggs.  By the time the last one shifts through your swollen pole, her bloated gut is nearly scraping the ground, leaving her panting and twitching with the weight of your eggs.");

			outputText("\n\nYou pull yourself free on unsteady legs, her gaping hole gushing emerald lube while her chitinous abdomen flops listlessly over her egg-filled ass.  You cut her free from your sticky webbing and gather up your [armor], shuffling back to camp as she collapses exhausted on her side, both hands wrapped around her tremendously swollen midsection.");
			player.dumpEggs();
			dynStats("lus=", 0);
			cleanupAfterCombat();
		}
	}
}
