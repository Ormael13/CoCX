//Encounter with the Plant Woman, still unused and unfinished. Help wanted.
package classes.Scenes.Areas.Forest 
{
	import classes.BaseContent;
	import classes.GlobalFlags.kFLAGS;
	import classes.StatusEffects;
	/**
	 * ...
	 * @author ...
	 */
	public class PlantGirlScene extends BaseContent
	{
		//Help Wanted
		
		
		// D: Defeat | V: Victory | Sd: Sex Dominant | Ss: Sex Submissive | TsI: Trapped submissive
		
		public function PlantGirlScene() {}
		
		//Encounter with the Plant Woman (Intro 1, requires having seen corrupted glade) 
		public function encounterPlantWoman():void {
			if (rand(2) == 0) {
				monster.createStatusEffect(StatusEffects.happy,0,0,0,0);
			}
			else if (rand(2) == 0) {
				monster.createStatusEffect(StatusEffects.horny,0,0,0,0);
			}
			else {
				monster.createStatusEffect(StatusEffects.grouchy,0,0,0,0);
			}
			clearOutput();
			if (flags[kFLAGS.TIMES_MET_PLANTGIRL] == 0) {
				outputText("While out exploring the deep woods you come across a thick bush full of vines and thorns that is obstructing your path.  Strange...that wasn't there a few days ago.  You remember the perverted, sexual vegetation, but not this.  You scan the brush for a way to get through to no avail.  As you begin to turn, you hear an eerie, ominous coo which causes you to freeze, listening for further movement or noise.  After a few moments, you sigh and begin to head back the way you came... only to hit another patch of dense foliage, blocking your advance once again.");
				outputText("\n\nNow this is really getting weird.  There certainly wasn't any bush here ten minutes ago.  Before you can consider you next move, you hear a familiar coo from the bush.  Something is definitely following you at this point.  Unnerved, you turn back the way you came when suddenly a mass of vines and thorns thrust along the ground and block that path as well!  You spin about, searching for your would-be captor.");
				outputText("\n\nWithout warning, something brushes past you, low on the ground!  \"<i>What the?</i>\" you exclaim.  At first you take it for a vine or branch, but the size of the object quickly dispels that notion: whatever it was, it was roughly the size of a human.  Trying to follow the mystery contact with your eyes, you find your movement restricted by unnoticed vines and branches that are wrapping themselves around your arms and [legs].  You scream silently in your head as they attempt to restrain you!");
				outputText("\n\nWill you struggle to break free, or will you see what happens?");
				//[See what happens (leads to intro 1.1]    [Struggle (leads to intro 1.2)]
				menu();
				addButton(0,"WaitAndSee",plantyLadySeeWhatHappens);
				addButton(1,"Struggle",plantWomanStruggle);
			}
			else {
				//Subsequent encounters (intro 2)
				outputText("As you search the deep woods for anything (or anyone) of interest, you find yourself near where you encountered the plant woman last.  Cautiously, you survey the immediate area for any signs of mutant growth... or any hostile plant creatures.  The snap of a twig to your left grabs your attention, and you spin around to see the plant woman from before emerging from the woods.");
				//(Plant woman is amused/happy to see you: 
				if (monster.hasStatusEffect(StatusEffects.happy) >= 0) outputText("\n\nApparently happy to see you, the feminine plant creature slowly walks toward you, assessing your demeanor and intentions.  Her candor as she approaches suggests that perhaps you two could partake in a little debauchery.  She stops a few feet away from you and awaits your response.");
				//(Plant woman is horny and more assert: 
				else outputText("\n\nInstead of being welcomed with a smile and a cheerful demeanor, the plant creature saunters assertively towards you, intent on getting some sexing from you one way or another. She might not listen to reason if you reject her...");
				//[Tied sex, leads to tied menu] 
				//[Submissive sex, leads to submissive sex menu]  
				//[Dominant sex, leads to submissive sex menu]    
				//[Fight, leads to Fight 1.0]    [Leave, can trigger a fight; will transition to see if Plant woman lets you go or tries to fight you for sex]
				//9999 What the fuck does this shit mean? -^
			}
		}

		//(Intro 1.1: See what happens)
		public function plantyLadySeeWhatHappens():void {
			clearOutput();
			outputText("You decide to not offer any resistance as the vines begin to tighten around your body.  When they have you nearly constricted, they stop suddenly.  Looking downward confirms the vines relaxing and slowly uncoiling from around your legs." + (player.cor >= 66 ? "  A sense of disappointment comes to you at the sight of the retreating vegetation, robbing you of potential fun." : "") + "  Standing there in utter confusion, you scratch the back of your head and survey the thick bush that now surrounds you, when a creature appears with a soft rustle to the left!");
			outputText("\n\nThe form you gaze upon is covered in plant matter; in fact, it looks just like the same matter that strung you up earlier.  Though, a surprisingly sleek and feminine body becomes visible as it slowly closes the distance.  The woman sports a pair of average breasts; your best guess would be B-cups.  Her eyes are jewel red and she looks your body up and down, she flushes a bit; clearly she likes what she sees.  Trying her best to seduce you through body language and the swaying of her curved hips, she seductively closes the distance and grins at you with a confident, flirty smile.  Feeling a sudden touch at your waistline, you look down to see that the creature is playfully tugging at your [armor], almost in a probing fashion as if to non-verbally ask if you are into this just as much as she is.");
			//[Let's fuck! (leads to choosing how to sex the plant woman)] [Decline] [Try to escape] 
			//(Decline and try to escape choices are dependent on initial mood, follows partial and completely successful struggle scenarios for subsequent scenes)
			//simpleChoices("Let's Fuck!",,"Decline",,"Escape",,"",0,"",0);
			menu();
			addButton(0,"Let's Fuck!",plantLadyLetsFuck,1.1);
			addButton(1,"Decline",declinePlantSmex);
			addButton(4,"Escape",plantWomanStruggle);
		}

		//[Let's fuck!]
		public function plantLadyLetsFuck(from:Number = 1.1):void {
			clearOutput();
			outputText("Throwing caution to the wind, you decide to engage in a little 'carnal' pleasure with this creature. How to do you want to sex the plant woman?");
			//(let's fuck scenes lead to victory/loss sex scenes (depending on dominant/submission choices, with variations)
			if (player.hasCock()) {
				
			}
			if (player.hasVagina()) {
				
			}
			
			/* Im not sure how the fuck any of this is supposed to work.
			Tied:
			Male:     Pussy [TsI 1.3]    Get BJ [TsI 1.4]   [Anal, TsI 1.1]     69 [TsI 1.6]     Suck dick [TsI 1.2]       
			Get anal [TsI 1.5]    Leave
			female:  Oral     [Anal, TsI 1.1]     69 [TsI 1.6]      Suck dick [TsI 1.2]     Get anal [TsI 1.5]     Dick in vag TsI 1.7    Leave
			herm:   Pussy [TsI 1.3]     Get BJ [TsI 1.4]     [Anal, TsI 1.1]      69 [TsI 1.6]      Suck dick [TsI 1.2]     Get anal [TsI 1.5]     Dick in vag [TsI 1.7]      Leave
			Genderless:    [69, scenes require writing]      Suck dick [TsI 1.2]      Get anal [TsI 1.5]     Leave
			
			Victory/Dominant:
			Male:     Pussy [V 1.1L, D 1.1]     Get BJ [V 1.2, D 1.2]     Anal     Cunnilingus    Suck dick [V 1.4, D 1.4]              Get anal [V 1.5 and D 1.5]
			female:   Anal [V 1.3, D 1.3]       Cunnilingus [V 1.7, D 1.7]    Suck dick V 1.4 and D 1.4    Get anal [V 1.5 and D 1.5]               Dick in vag [V 1.6, D 1.6]    Get Oral [V 1.8, D 1.9]               
			herm:    Pussy [V 1.1L, D 1.1]     Get BJ [V 1.2, D 1.2]     Anal [V 1.3, D 1.3]     Cunnilingus [V 1.7, D 1.7]   Suck dick   [V 1.4 and D 1.4]    Get anal [V 1.5, D 1.5]    Dick in vag [V 1.6, D 1.6]    Get Oral [V 1.7, D 1.7]
			Genderless:    Cunnilingus [V 1.7, D 1.7]      Suck dick [V 1.4 and D 1.4]    Get anal [V 1.5, D 1.5]      
			Leave
			
			Loss/Submissive
			Male:     Pussy [L and S 1.7]     Get BJ [L 1.2, S 1.2]    Anal  [L 1.5, S 1.5]    Cunnilingus [L 1.3, S 1.3]   Suck dick [L 1.1, S 1.1]  Get anal [S 1.6 and L 1.6]   Leave
			female: Oral L 1.4, S 1.4]      Anal [L 1.5, S 1.5]    Cunnilingus [L 1.3, S 1.3]    Suck dick [L 1.1, S 1.1]          Get anal [S 1.6 and L 1.6]          Dick in vag [L 1.8 and S 1.8]       Leave
			herm:  Pussy [L and S 1.7]     Get BJ     Anal (L 1.5, S 1.5]    Cunnilingus [L 1.3, S 1.3]   Suck dick [L 1.1, S 1.1]    Get anal [S 1.6 and L 1.6]     Dick in vag [L 1.8 and S 1.8]   Oral [L 1.4, S 1.4]      Leave
			Genderless:   Cunnilingus [L 1.3, S 1.3]   Suck dick [L 1.1, S 1.1]     Get anal [S 1.6 and L 1.6]     Leave
			*/
			
			//[If Intro 1.1 is chosen: Step two of Let's Fuck!]
			if (from == 1.1) {
				outputText("\n\nWill you be dominant or submissive?");
				//menu();
				//[Dominant (leads to Sd. 1]  [Submissive (leads to Ss.1]
				//addButton(0, "Dominant", 9999);
				//addButton(1, "Submissive", 9999);
			}
		}

		//(Intro 1.2: Struggle) (leads to Intro: 1.2.1, or  1.2.2 scenes, depending on PC stats)
		public function plantWomanStruggle():void {
			clearOutput();
			//(struggle success, or Intro 1.2.1)
			if (player.str >= 40) {
				outputText("Summoning forth some manner of brute strength, you thrash and twist your way out of the vines, frantically clamoring to get away. While the thorns are certainly sharp and painful to crawl through, you manage to escape from the plant enclosure and onto the path you were previously on. You hit the ground with a thud, gasping for air due to the exertion it took to free yourself. Getting out of that \"contraption\" certainly wore you out, but you figure that you won't be getting raped or killed... at least for now. You raise yourselves to your hands and knees and shake your head.");
				outputText("\n\nYou hear something moving in the bush you were just in and struggle to get from prone up to your [feet]. Another series of sounds gives you cause to roll away and enter a combat stance. Yet, nothing happens; no tentacle that rushes out to violate you materializes, and no claws or teeth charge forward... just silence. Quizzically, you rise to a standing position with your [weapon] readied just in case.");
				//Struggle success Meeting the Plant Woman(or 1.2.1m)
				outputText("\n\nThat is when you see her... or whatever 'she' is.  In the first few seconds you have to gaze on her, you see that she is not like everything else that has tried to have sex with you; no animal parts to speak of, no signs of demonic taint aside from the red, jewel like eyes that meet your own.  Her average body has B-cup breasts, well rounded thighs, a nice full rump and appears to be very plant-like in appearance. From what you can tell, her skin looks like a mix between tree bark, leaves and the stems of the plants surrounding your village back home.  She stares at you...");
				//[if amused] 
				if (monster.hasStatusEffect(StatusEffects.happy) >= 0) outputText(" with her hands on her hips, and sports a devilish smile on her face. By the way she is looking at you, she hasn't seen a potential mate in some time.  After the realization sets in that you have encountered a plant woman, you stare at the creature and await a response. The floral vixen responds by giggling and flinging her leaf like hair back, and turns her head in a way that shows only her left side.  She stares down at her body, and takes her time to raise her gaze from her torso to your eyes.  She seems to be trying to entice you to come and 'play.");
				//[If annoyed and horny]
				else outputText(" with the back of her wrists at her side. She clearly doesn't look too happy that you struggled out of her trap.  She rises out of the bush with a pouty look on her face and stares daggers at you.  You aren't certain why she's angry at first and chalk it up to being based in territorial instinct.  However, looking up at her sex, you can tell that her vagina is soaking in her juices, which glisten in the sun.");
				outputText("\n\nIt's quite obvious at this point that she was expecting to have a little intimacy with you.  Looking at her body, you can tell that her skin is very floral-like; while smooth, it resembles a mixture of tree bark, leaves and the stems of plants you've seen at home and around Mareth. Her leaf-like hair sways gently in the mild breeze that flows through this area of the deep woods. For something that looks as weak as a frail plant, she's pretty intimidating from this angle.");
				outputText("\n\nShe edges closer and stops only a few inches from your face, \"innocently\" glancing down at her sex, and then back up at you.  Being non-verbal doesn't hamper her means of subtlety giving you direction, bobbing her head several times towards her pelvis Shooting a sly look at you, she apparently is \"asking\" if you are going to co-operate or if she'll have to take what she wants from you.");
				//***Both amused and annoyed and Horny lead up to Decisions, Decisions; However, the plant woman will be more likely to attack you if you try to leave while she is annoyed and horny.
				//(I would like to have the percentage of her fighting the PC if rejected to be around 35%; 50% if she is moody) (mood is determined randomly, 60% for amused, 40% for annoyed).
				//(Decisions, Decisions) (only if you get success or partial success)
				//What do you do?
				//[Sex]      [decline]     [Try to escape]
				//simpleChoices("Sex",9999, "Decline", 9999,"",0,"",0, "Try to Run",9999);
				menu();
				//addButton(0,"Sex",9999);
				addButton(1, "Decline", declinePlantSmex);
				//addButton(4,"Try to Run",9999);
			}
			//(struggle: failure, or Intro 1.2.3) (< 40 STR)
			else {
				outputText("Despite your best efforts, you can't seem to break free from the vines as they tense around your limbs and then your waist.  You bite your lower lip and brace for whatever is coming to \"greet\" you.");
				//(leads to 1.2.3m)
				//(Struggle failure: meeting the Plant woman, or 1.2.3m)
				outputText("\n\nYou continue to struggle in a vain attempt to break free, but your efforts are quite for naught.  You try to twist around to see where your captor is, but all you can see is this damned bush.  You close your eyes and sigh, only to open them and see a big pair of red jewel eyes staring back at you. You shriek with a startled yelp, and the eyes suddenly go wide and dart backwards.  What comes into view resembles a plant woman with skin that looks like a cross between tree bark, leafs and the internodes found on plants.  She stands about 5'5, sporting a pair of B-cup breasts and appears to have an average body, save for the curve-ish thighs and the ample ass that she has.  The plant woman stares at you with her leaf-like hair drooping past one eye, sporting a look of uncertainty.  Seems you scared her more than she scared you.  Gritting your teeth, you ask her what she wants. The creature stares at you and tilts her head. Again, you inquire as to her intentions.  The creature still doesn't seem to understand.");
				outputText("\n\nShe raises a hand to your chest and slides it into your [armor], resting her hand on your " +  player.nippleDescript(0) + ".  She caresses you as her hand descends down to your abdomen, her sensual touch gracefully brushing down your sides.  The soft, pleasurable sliding of fingers along flesh flows through you as she does so,");
				//(if genitalia is present: 
				if (player.gender > 0) {
					outputText("sending blood rushing down to your ");
					if (player.hasCock()) outputText(multiCockDescriptLight());
					if (player.gender == 3) outputText(" and ");
					if (player.hasVagina()) outputText([vagina]);
					outputText(".  She lowers her other hand down towards your genitalia, and begins to massage ");
					if (player.gender == 3 || (player.vaginas.length + player.cockTotal() > 1)) outputText("them")
					else outputText("it");
					outputText(" through your pants.");
				}
				//(if genderless) 
				else outputText(" scanning your nether regions with her hand.  Her expression changes from one of control and lust to confusion, looking upon you with a dismayed expression.  You don't seem to be sporting any kind of genitalia. Pondering for a moment, the plant woman weighs her options as she stares at your body and attempts to solve what appears to her to be a rather perplexing problem.");
				//To [Sex: failure intro, or 1.2.3 sex intro]
				menu();
				addButton(0,"Next",sexFailureIntro);
			}
		}

		//[Sex: failure intro, or 1.2.3 sex intro]
		public function sexFailureIntro():void {
			clearOutput();
			outputText("With you tightly confined in your vine prison, the plant woman shifts forward through the bush and comes face to face with you.  She smirks playfully and begins to take your [armor] off.  Your musings about what this creature has in mind are interrupted when the plant woman starts caressing your face and necking you.  Starting at the lower base of your neck, she slowly licks upwards until she reaches your ear, intimately exploring the insides.   Her breathing heavy and sporadic as she caresses your earlobe, aroused to no end as she intimately explores your body. She then proceeds back down to your lower neck, suckling around the base, as she makes her way to your other ear. It's obvious she's getting off on this, the intimate act causing her to shudder repeatedly.");
			outputText("\n\nThis goes on for a few moments before she brings her face back to yours, and begins to tease you by going in for a kiss and pulling away. She looks into your eyes and is waiting for you to reciprocate.");
			//[Do it! (leads to Trapped sex intro]   [Decline (leads to Decline 1.0)]    [Seriously, get lost (leads to GL 1.0]
			//simpleChoices("Do It!",,"Decline",,"Get Lost",,"",0,"",0);
			menu();
			addButton(0,"Do It!",struggleFailDoItPlantSmex);
			addButton(1,"Decline",declinePlantSmex);
			addButton(2,"Get Lost",seriouslyGetLostPlantLady);
		}

		//[Decline, or Decline 1.0]
		public function declinePlantSmex():void {
			clearOutput();
			outputText("As she returns to teasing you again with a pseudo-kiss, you pull back and shake your head.  The rejection apparent in your facial features, the plant woman stops and stares at you with glassy eyes.  You signal (as best as you can while constricted) that you aren't into this and that you need to leave. Her eyes become watery as she turns away, quietly sobbing as her vines loosen up a bit.");
			//(depending on mood, scene will progress to Decline 1.1 or 1.2)
			//(Decline 1.1; considerate: 
			if (monster.hasStatusEffect(StatusEffects.happy) >= 0) {
				outputText("\n\nHer vines relax further and uncoil around you, slumping to the ground as she withdraws into the bush.  The display from the creature tugs at you a bit, but you shake it off and decide to return to camp before she changes her mind.");
				monster.removeStatusEffect(StatusEffects.happy);
				doNext(camp.returnToCampUseOneHour);
				return;
			}
			//(Decline 1.2; apathetic to your wishes: 
			outputText("\n\nRaising her head, she spins around and glares at you. Tears streaming down her now angered face as she starts toward you.  It's clear she's not taking no for an answer, and you twist and wiggle against her vines, using her momentary lapse in concentration to your advantage. Before she can direct her upset mind back to the vines, you manage to break free. Screaming in fury, she raises an arm back and winds up to deliver a lash of her \"whip\".  Rolling to the side, you dodge the attack and gain some distance between yourself and the plant creature.  Readying your [weapon], you assume a defensive stance and prepare for battle.");
			//(Leads to Fight 1.0)
			startCombat(monster);// TODO create PlantGirl
		}

		//[Seriously, get lost!, or GL 1.0]
		public function seriouslyGetLostPlantLady():void {
			clearOutput();
			outputText("Going in for a pseudo-kiss, the plant woman closes her eyes to relish the moment when her lips press against yours; a mistake that she will regret later as you buck your head back and smash into her leafy skull. Reeling from the sudden and painful blow, the plant woman groans and staggers dizzily to the ground. The vines that hold you lose their grip, and summoning your strength, you rip free of them at last. Cautiously, you back away from the creature and put some distance between you two. Aggression washes over her slumped form and she rises to her feet, sappy blood running down her face as she furiously glares at you. She takes a step towards you and arches her right arm  over her left shoulder, protruding a vine from her wrist and tensing it up into a whip. It's on!");
			//(proceeds to Fight 1.0, with the plant woman having 290-270 HP instead of 300, depending on the PC having horns and the like).
			startCombat(monster);// TODO create PlantGirl
			monster.HP -= 20;
			if (player.horns > 0 && player.hornType > HORNS_NONE) monster.HP -= 15;
			doNext(playerMenu);
		}

		//[Sex failure: Do it! (Trapped sex Intro (TsI))]
		public function struggleFailDoItPlantSmex():void {
			clearOutput();
			outputText("As she goes in for another pseudo kiss you lurch forward and connect with your lips, pressing them hard against her and fiercely returning her intimate gesture. She responds by snaking her tongue in your mouth, slapping hers against yours and twisting them around like a frustrated child with a knotted shoe lace.");
			//(If PC doesn't have long tongue, skip to Otherwise TsI
			//(If long tongued: 
			if (player.tongueType > TONGUE_HUMAN) outputText("\n\nYou respond in kind by twisting your lengthy tongue around her own, sliding and constricting around hers like a boa strangling a mouse. With her wet tongue in your grip, you twitch and work the tip of your tongue back to hers, slapping the two together as your tongue dominates the soft, sensual, and submissive part of her mouth.  Despite being bound in this freak of nature prison, you pull her tongue past her lips and into your own, clamping down on it with your pucker as you lather and caress her tongue.  Judging by the reaction on your partner's face, she seems to feel violated... yet strangely aroused.  She blushes and allows you to take the lead in this Florentine kiss.");
			//(leads to Otherwise TsI)
			//(Otherwise TsI):  
			outputText("\n\nYou taste something funny in her saliva but can't quite pin-point what exactly it is. Sensing your troubled thoughts, she places her hands on the sides of your forehead, embracing you in her passionate grip. Your body quivers at the intimate nature of this encounter, and the plant girl giggles. She wastes little time raising you a few inches off the ground and ripping your [armor] from your body... It's surprising that she does not damage your gear as she removes it piece by piece.  Completely naked, the plant woman looks intently at your body, lost in deliberation as she clearly tries to make up her mind.");
			//(Her choice in sexing will be randomly selected)
			var choices:Array = new Array();
			//IN ZE PC BUTT
			choices[choices.length] = plantRapingAssTrappedSexIntro;
			//GIVE HER A BJ
			choices[choices.length] = trappedFlowerSexBlowjob;
			//SHE RIDES UR DICK
			if (player.hasCock()) choices[choices.length] = trappedPlantSexPussy;
			//SHE BLOWS YA
			if (player.hasCock()) choices[choices.length] = trappedPlantSexWantsToBlowYa;
			//SHE WANTS UR DICK IN HER ASS
			if (player.hasCock()) choices[choices.length] = strugglePlantLadyFailAnal;
			//SHE WANTS 69 - ANY GENDER
			if (player.gender > 0) choices[choices.length] = failStruggle69;
			//SHE FUCKS YER CUNT, YA GIT
			if (player.hasVagina()) choices[choices.length] = struggleFailPlantFucksPussy;
			
			//Pick one at random and run dat shit!
			choices[rand(choices.length)]();
		}


		//Player escapes the plant woman's trap and refuses sex
		public function escapeFromPlantWomanAndDeclineSex():void {
			clearOutput();
			//(Success: decline, SD 1.1) 
			//(Chance that the plant woman will attack you if you try to leave.  (Reactions to the plant woman are based on corruption;  light side (pure) is listed first, the second is corrupted)
			outputText("You stare at the plant woman and shake your head.  Sorry, you're not interested.  The plant woman continues to stare at you, uncertain of what you are saying.  You gesture to the monster that ");
			if (player.cor < 50) outputText("you are taking your leave and don't wish for any trouble.");
			else outputText("following or attacking would be a bad idea.");
			//(Connects to failure to persuade)
			//(Success, SD 1.1s)
			if (9999 == 9999) {
				outputText("\n\nThe monster, from what you can tell, deliberates your gesture of ");
				if (player.cor < 50) outputText("walking away");
				else outputText("intimidation");
				outputText(" and shrugs.  She promptly flees back into the woods.  You are left wondering just how messed up the local fauna and wildlife in Mareth is before promptly returning to camp.");
				doNext(camp.returnToCampUseOneHour);
			}
			//Failure to persuade/intimidate (SD 1.1f)
			else {
				outputText("\n\nThe plant monster scowls at you when you attempt to leave.  You try to ");
				if (player.cor < 50) outputText("calm her down");
				else outputText("remind her that attacking you will earn her a world of pain");
				outputText(", but she isn't buying any of it.  You ");
				if (player.cor < 50) outputText("shrug and turn you back, beginning the long trek back towards camp");
				else outputText("take a step forward and ready your weapon");
				outputText("; she responds by attempting to whip you with one of her vine appendages, causing you to ");
				if (!player.isTaur()) outputText("leap");
				else outputText("gallop");
				outputText(" out of the way.  She's misses, but it's obvious she will not take no for an answer. Looks like you have a fight on your hands...");
				//(leads to Fight 1.0]
				startCombat(monster);// TODO create PlantGirl
				doNext(1);
			}
		}

		//[She wants your ass, or TsI: 1.1 intro]
		public function plantRapingAssTrappedSexIntro():void {
			clearOutput();
			outputText("The plant woman stops and looks around at the surrounding foliage, smiling.  You look at her with a hunger in your eyes and moan, snapping her attention back to you.  She uses the vines to flip you around and expose your [butt] to her.  With a snap of her fingers,  phallic stamen sprout out of her body, and she proceeds to walk behind you...  Wait... is she going for your ass?  The confusion on your face gives the creature pause as she awaits a response from you.");
			//[fuck my ass (leads to TsI: 1.1a]  [hey, exit only! (leads to TsI: 1.1r]
			//simpleChoices("Fuck My Ass",9999,"Exit Only",9999,"",0,"",0,"",0);
		}

		//[Failure anal: considerate of your needs, or TsI: 1.1r]
		public function plantRapingAssTrappedSexIntroExitOnly():void {
			clearOutput();
			outputText("The fact she's planning to plant her cock in your ass gives you cause to thrash in your vine prison.  Taken out of the moment, she stops and considers your wishes to not have some bulbous penis rammed up your [butt].  With a smile, she spins you around and kisses your cheek.  It looks like she got the message that you aren't into anal sex right now (if ever).");
			//(Taken back to tied sex menu)
			//9999
		}

		//[fuck my ass, or TsI: 1.1a]
		public function fuckMyAssPlantLadyWhileImTrapped():void {
			clearOutput();
			outputText("You look up into the plant girl's eyes and smile, signalling that you're ready for what she has in mind.  She returns your lustful leer and presses her lips against yours, tongues once again darting around in search of each other as the plant girl reaches down to both your chest and ");
			if (player.hasCock()) outputText(multiCockDescriptLight());
			if (player.gender == 3) outputText(" and ");
			if (player.hasVagina()) outputText(clitDescript());
			outputText(", and begins to caress and ");
			if (player.hasCock()) outputText("stroke");
			else outputText("finger");
			outputText(" you.");
			
			outputText("\n\nAs she takes ");
			if (player.hasCock()) outputText("[oneCock]");
			else if (player.hasVagina()) outputText("your " + player.clitDescript());
			outputText(" into her hand, you can feel her slip her plant-like penis into your [butt].  A loud series of deep moans escape from you both as your arm reach around and cradles her head in close, desiring the warmth of her body against yours as she presses on into your rump. With a moan, she pushes past your [asshole] and enters your rectum, causing a small cry of pain to stumble out of your mouth as she begins to push deeper and deeper into you; luckily she's considerate enough to not injure you");
			//PC asshole is virgin, tight, or loose: 
			if (player.analCapacity() < 25) outputText(", but the bulbous member sliding inside of you hurts nevertheless");
			outputText(".");

			outputText("\n\nYou grit your teeth as she bottoms out and then begins to withdraw. Just as it seems she's going to give you a moment of respite, she pushes her once again, sliding more of it into your ass.");
			player.buttChange(25,true,true,false);
			
			//PC asshole is virgin/tight: 
			if (player.analCapacity() < 20) outputText("  You moan again from the pain and clamp down, causing your captor to
		shudder from the sensation of your [asshole]'s tightness.  Once the floral creature regains her composure, she begins to pump in and out of your ass at a gradually faster pace.");
			//PC asshole is loose:  
			else if (player.analCapacity() < 60) outputText("  Her bulbous cock works its way into your [asshole] with some difficulty, but as it continues you feel the walls of your anus fit snugly around her, causing her to shudder from the sensation.  The vibrations from her tembling can be felt in your ass, traveling through your pelvis and into the rest of your body...  Once the plant woman regains her composure, she begins to pump in and out of your ass at a gradually faster pace.");
			//PC asshole is gaping: Her member slides in with no resistance whatsoever.  
			else outputText("  You can hear her hiss in frustration at how loose your anus is.  You can hear her breathing stop momentary, and before you can react, her plant-like cock proceeds to expand inside of you.  It gradually grows in size and girth until resting snugly inside of your anus... or so it would seem.  The now incredibly thick prick inside of you doesn't relent in its growth, continuing to expand as it starts to painfully stretch you even further than you already are.  Gritting your teeth, you whine loudly and demand that her efforts stop.  Your wishes are heeded, but it seems the plant woman wants to let you know that she isn't particularly pleased that you've been stretched out so loose.  With your \"punishment\" over, the plant creature starts her gyrations against you, her horse-cock length prick now tunneling its way into you.");
			
			outputText("\n\nYou groan out in a pleasurable pain as she adjusts to the sensation of your ass and picks up speed.  Her cock's warmth darts in and out of you as her thighs slap against your ass cheeks with a loud series of smacks.  The creature begins to whimper soft as she thrusts her prick, leading her to release a thin amount of pre into your humid anus, in turn lubing you up for her increasingly forceful gyrations.  Faster and faster the plant woman thrusts, your wails of lust becoming louder alongside her labor.  She begins to pant and moan as she works herself into a sexual flurry, slapping your ass cheeks as her carnal bliss intensifies.  You grip the branches in your hands as tightly as you can, looking to something to help brace you during your ravaging.");
			
			//PC has a dick(s) less than 48 inches long: 
			if (player.shortestCockLength() < 48) {
				outputText("\n\nYour ");
				if (player.balls > 0) outputText("[balls] and ");
				outputText(cockDescript(player.shortestCockIndex()) + " flap");
				if (player.balls > 0) outputText("s");
				outputText(" against your thighs as she fucks you harder and harder as her hand finds its way down to your prick");
				if (player.totalCock() > 1) outputText("s");
				outputText(".  The creature twists and jerks at the head of your cock and works diligently to stimulate your rock hard " + player.multiCockDescriptLight() + ", intent on making you moan out for her.");
			}
			//PC has a vagina: 
			else if (player.hasVagina()) outputText("\n\nYour [vagina] leaks girl cum profusely as your innards are brutally assaulted by the creature, aching for the sensual touch of you or your lover as the plant woman mashes against you.");
			else outputText("\n\nYou moan intensely as she fucks your ass, bucking and clenching as her bulbous members slides back and forth inside of you.");
			
			outputText("\n\nCeasing her vocal euphoria, the plant woman turns your head towards her face and presses her lips against yours.");
			//(if long tongued: 
			if (player.tongueType > TONGUE_HUMAN) outputText("  In a cute but spiteful way, your tongue is pulled forcefully out of your mouth and into her lips as she pulls her head back; the plant woman doesn't get too far from your face before you run out of tongue to give.  This suits her just fine as she takes to sucking on your incredibly long tongue in a manner similar to fellatio.  Pursed on the bottom of yours, she darts her head back and forth along the length of it, edging further into her mouth as she nears closer and closer to your own.  Her dominance without question, she reaches your lips and slips her tongue in, sealing it in with a firm kiss.");
			//Not long tongued: 
			else outputText("  Your tongue is viciously attacked by the sudden intrusion of her own.  However, you are more than happy to return the favor as you counter attack, swapping each other's saliva in the process.");
			
			outputText("The feminine creature's hand then finds its way ");
			if (player.balls == 0) outputText("up");
			else outputText("down");
			outputText(" to your ");
			if (player.balls == 0) outputText(nippleDescript(0));
			else outputText("[balls]");
			outputText(", massaging and caressing them gently as she moves to kissing at your neck.  Her thrusts become shorter in length as her breathing becomes frantic, signaling that her orgasmic peak is near. The plant woman ");
			//PC has hair: (grabs you by the hair)
			if (player.hairLength > 0) outputText("grabs you by the hair");
			//PC doesn't have hair: embraces you)
			else outputText("embraces you");
			outputText(" as she cries out in a fierce moan, her cock convulsing as she thrusts wildly against you and planting her hot seed deep into you.  The sensual act finally over, your head droops down as you pant heavily; the plant girl slumps her head down onto your shoulder and uses you to hold herself up.  She's breathing heavily in your ear while regaining some of her energy and composure.");
			
			outputText("\n\nAfter twenty minutes of groping your body and licking your ears, the feminine creature pulls her cock out of your [asshole] and leaves it dangling close to your [butt].  Her sappy spunk starts to leak out, and finally the vines around your legs release.  You're free to return to camp at this point, but the sperm leaking out of your butthole could make the journey back an uncomfortable one; cum stained clothing can get pretty annoying to walk in after all...");
			player.orgasm();
			doNext(camp.returnToCampUseOneHour);
		}

		//(Failure: Blowjob, or TsI: 1.2 intro) 
		public function trappedFlowerSexBlowjob():void {
			clearOutput();
			outputText("The plant woman smiles at you and places your hand on her breast, and in turn places her hand on your chest.  You feel uneasy as the plant-like vines in her arms start wriggling around, and begin to envelope you.");
			//(//You're not sure what this act is supposed to mean exactly, but you hope that it doesn't involve impaling your heart.)
			outputText("  The vines that entrap you suddenly lower you to the ground and force you to your knees.  Eager to see what the plant girl has in store for you, you lick your lips and smile.  The plant girl returns your smile and pets the back of your head. Suddenly something begins to shake in her pelvis, and within seconds a cock bursts forth.  She coos playfully and tilts your head back, opening her mouth in what seems to be ecstasy.  Your eyes go wide as her cock bobs up and down, drooling golden, sappy pre-cum.  The sly look on her face conveys to you her belief that you both might enjoy this... but this IS a plant monster with a cock.  Maybe you should exercise caution?");
			//[Open wide (leads to TsI: 1.2a)]      [Put that thing away! (leads to TsI 1.2b)]
			//simpleChoices("Open Wide",9999,"Put That Away",9999,"",0,"",0,"",0);
		}

		//(Failure blowjob: or TsI 1.2r)
		public function trappedFlowerSexBlowjobRejection():void {
			outputText("You push against the plant girl's thighs and shake your head, telling her that you are interested in THAT. You comment on how you wouldn't mind playing with something else though, as you begin to stroke your finger around the plant woman's labia.  She stops and ponders for a moment, and then giggles as her appendage disappears back into her body.");
			outputText("\n\nIt looks like it's up to you how you want to be sexed.");
			//(Taken back to tied sex menu)
			//doNext(9999);
		}

		//(Failure blowjob: I. Said. OPEN. WIDE!, or TsI: 1.2a)
		public function trappedFlowerSexBlowjobAhoy():void {
			clearOutput();
			outputText("\"<i>MHHMMpffffrmPH!</i>\ you mumble as her cock hits the back of your mouth, the plant creature clearly intent on jumping into the rougher sex sooner rather than later. The plant girl giggles as you struggle to breathe and not vomit from the violent intrusion. Placing both of her hands on the back of your head she begins to pump her hips, gliding her cock along your (tongue descript). You gasp for air as you try to push yourself off of the girl and get some room to breathe, but she has a pretty firm grip. She continues thrusting, but is increasingly annoyed that you aren't putting much effort into it right now.  A pair a vines ");
			//(If PC has balls: 
			if (player.balls > 0) outputText("wrap themselves around your ([balls] and begin to squeeze");
			//(If PC has a cock(s): 
			else if (player.hasCock()) outputText("wrap themselves around your " + player.multiCockDescriptLight() + " and begin to squeeze");
			//(If PC has a pussy: 
			else if (player.hasVagina()) outputText("take hold of you player.clitDescript() and tug hard");
			//(If PC is genderless: 
			else outputText("take hold of your [nipples], fiercely pulling on them to try and convince you to put some work into it");
			outputText(".");
			outputText("\n\nYou groan in pain as the pressure begins to increase. You break free of her grip and cough.  You need to breathe damn it!  Looking down at your coughing and weary form, the plant woman blushes from embarrassment. It seems she's been so far removed from other creatures that she has forgotten how other creatures breathe.");
			
			outputText("\n\nAs you regain your composure, the plant woman pets your head and stares at you with apologetic eyes. With a nod at her regret for treating you so roughly, you take the cock in your mouth and begin to lick it up and down, and swirl your tongue around the head of the plant woman's penis.  You hear her moan and begin to stroke your head and you work on her member.  You bob your head back and forth earnestly along her length, and you can feel her pre-cum mixing with your saliva.  The plant woman blushes as she gazes down on your lustful expression while you taste every contour of her prick and swallow her sweet secretions. Not wanting to be neglectful, you cease your oral efforts and slide your tongue down her shaft, towards her gouge and licking it sensually.  The creature's moment of respite is fleeting as you quickly dart back upwards and take her cock back down your craw.  She giggles as your enthusiastic efforts and gently begins to guide your head back and forth  along her shaft, soliciting a series of pleasured hums as you feel her glans brush past your tongue and swallow her pre-cum.");
			outputText("\n\nSoon, she begins to buck against your face and all you want to do is take her engorged member as far as you can down your throat.  As the act draws nears the end, she begins to pant heavily, and her thrusts become diminished.  Her cock begins to twitch, and you can tell what is coming.");
			outputText("\n\nShe moans wildly with every subsequent thrust, and then buries her cock deep in your mouth, arousal overtaking you as her sappy seed gushes down your throat.  With a few more hearty thrusts and moans of sexual relief, she sighs and pulls her cock out of your mouth, trailing semen along the side of your lips as she does so.  Smiling, she caresses your stomach as her lips seek yours for a salty kiss.  After a while, the vines restraining you release and drop you to the ground, and the plant woman wonders off into the Deep Woods.  You wonder what will happen to the seeds now in your stomach.  You head back to camp, thinking about your encounter with the plant woman as you walk.");
			dynStats("lus", 50, "resisted", false);
			doNext(camp.returnToCampUseOneHour);
		}

		//[Failure: She wants to fuck your cock with her pussy, or TsI: 1.3 Intro]
		public function trappedPlantSexPussy():void {
			clearOutput();
			outputText("Staring down at your " + player.multiCockDescriptLight() + ", the plant woman's eyes become fixated and betray a sense of longing, of curiosity, and eagerness.  Approaching your well restrained body, she takes [oneCock] into her soft hand and brushes it's sensitive head against her smooth pelvis, fairly close to the creature's moist and sweet smelling pussy.  Proceeding to wrap its arms around you, the plant woman takes [oneCock] in-between her legs and against her clit, signaling the creature's intent to plunge its hungry cunt down on your dick.");
			//(Leads to TsI: 1.3a or TsI: 1.3r)
			menu();
			addButton(0, "Allow Her", trappedPlantSexPussyGOOO);
			addButton(1, "Protest", protestTrappedPlantPussySex);	
		}

		//[Protest (TsI: 1.3r): 
		public function protestTrappedPlantPussySex():void {
			clearOutput();
			outputText("For whatever reason, you don't want this plant woman's cunt anywhere near your " + player.multiCockDescriptLight() + ".  Pulling your pelvis back, you try to show that you don't want to be mating in the traditional sense.  Stopping her efforts to mount you, she stares at your display and attempts to convince you, through more cock on clit teasing, that you'll enjoy this and to give it a chance.  Your mind is made up however, and you once again attempt to pull away.  Realizing that you are dead set against this the plant woman withdraws and crosses her arms.  The plant woman glares out of the corner of her eye as she rifles her fingers along her forearms... as if she is waiting for you to make up your mind.");
			//(Taken back to tied sex menu)
			doNext(9999);
		}

		//Failure: Straddle fuck 
		//(TsI: 1.3a) (less than 24 inches]
		public function trappedPlantSexPussyGOOO():void {
			clearOutput();
			outputText("The vines around you begin to shift, and you fear that she might have misinterpreted your preferences for sex, gritting your teeth as you await the inevitable violation of your body.  The continuing sound of cracking vines and growth intrigues you enough to open your eyes, witnessing both yourself and the plant woman being lifted off of the ground by her cabal of creepers.  Lifting you further and further into the air, the vegetation draw her close to your restrained, naked body.  The floral beauty's petal like vagina is soaked in anticipation and glistening in the warm glow of the sun.");
			var x:int = player.cockThatFits(9999); //Undefined capacity for now.
			if (x < 0) x = player.smallestCockIndex();
			//(If  cock(s) are 4 inches or less)  
			if (player.cocks[x].cockLength < 4) {
				outputText("\n\nThe plant woman goes to massage your " + player.cockDescript(x) + ", but stops when she sees how small you are.  Rather than dumping you on your ass, one of the vines that holds you wraps itself around [eachCock] and then proceeds to pierce the sensitive flesh of your glans with what you assume are barbs.  Unconsciously, you scream out in pain; it isn't the worst agony you have ever felt, but the sharp stinging that floods your sensitive member is enough to be a mood killer. In increasing agony, you gaze down at your " + player.multiCockDescriptLight() + " to witness your member");
				if (player.cockTotal() > 1) outputText("s");
				outputText(" swelling up. The head");
				if (player.cockTotal() > 1) outputText("s");
				outputText(" of your cock");
				if (player.cockTotal() > 1) outputText("s");
				outputText(" swell");
				if (player.cockTotal() == 1) outputText("s");
				outputText(" to what seems to be double ");
				if (player.cockTotal() > 1) outputText("their ");
				else outputText("its ");
				outputText("original size, and your unsubstantial shaft");
				if (player.cockTotal() > 1) outputText("s gain");
				else outputText(" gain");
				outputText(" some length in the process.  Is this some kind of allergic reaction?  A chemical?  Some kind of hormone? Regardless of how this is done, your once insignificant penis");
				if (player.cockTotal() > 1) outputText("es are now ");
				else outputText(" is now ");
				outputText("of sufficient length to penetrate this creature; though, you suspect the effects are temporary.");
				//(cock size temporarily increased to 7 inches)
				player.cocks[x].cockLength += 7;
			}
			//(if > 4 inches) 
			else outputText("\n\nShe presses her body against yours, causing your rock hard player.multiCockDescriptLight() to jut upward against her leafy stomach.");
			outputText("\n\nRaising herself ever so slightly, the plant woman wraps her legs around and straddles you as she lowers her pussy onto the tip of " + player.cockDescript(x) + ".  The female perversion of nature slowly takes the entirety of your cock in her, causing your prick to sensually ease through her tight cunt like a mole crawling through the fertile earth.  The sensation is too much, causing you to shudder and twitch uncontrollably.  Your dominant partner rests her ");
			//(If height is 36 inches to 72 inches: 
			if (player.tallness < 72) outputText("raises her face to yours ");
			//If height is greater than 72 inches, but less than 96 inches: 
			else if (player.tallness < 84) outputText("head against your [chest] ");
			//(If Height is less than 96 inches: 
			else if (player.tallness < 96) outputText("forehead against your chest, sniffing you intensely as she takes in your musk.  The creature of flora and warped flesh moans and shivers as she acquires your " + player.mf("manly","feminine") + " scent, and ");
			//(If height is greater than 96 inches: 
			else outputText("places her head against your stomach, eyes closing as the creature takes in the rising and descent of your stomach ");
			outputText(" as she slowly begins to work her hips, grinding the innards of her hot and moist sex against your " +  player.cockDescript(x) + ".");
			//(if one cock:
			if (player.cockTotal() == 1) outputText("  The plant creature begins to speed up her thrusting against your cock, eager to drive you over the edge with the tightness of her hole.");
			else {
				//(If multi-cocked: 
				outputText("\n\nAs she bobs her hips against you, the sensation in your nerve endings drives you to moan with every sensual gyration.  With a devilish smile, the plant woman pauses as she closes her eyes; your pleasure interrupted, you look upon the plant woman's face.  What she could be up to?  The rough grip that takes your other cocks by surprise answers your question.  Looking down, you see that the creature has taken your members into the grasp of her vines.  Frantic worry overtakes you; you aren't sure what those vines are made of, but given that part of this creature is tree bark, you're sure you don't want to find out.  Rather than chaffing and ripping the hell out of your cocks however, the vines form an orifice shaped bundle that begins to vibrate. Before your very eyes, a growth of flowers sprout from the vines, forming into a makeshift set of flowery vaginas. With a lustful hunger in her eyes, she slams her pelvis against yours, taking [eachCock] into her bizarre groups of florid vaginas, shifting them back and forth in perfect unison with her thrusts against you.");
			}
			//(If PC has a vagina: 
			if (player.hasVagina()) outputText("\n\nA noise from behind you partially snaps you out of your lustful throes; from the sound of things, the vines behind you are snaking their way through the bush.  Thrusting forward along the creepers that hold both of you up in the air, the lightning fast appendages wrap themselves around your legs.  One of these vines presses itself against your clit, teasing your labia with its head. The vegetation slows to a gradual stop, and the plant woman locks your face against hers in a passionate kiss; rose petal lips brushing against your own as you return her caress.  The plant-like intruder pushes forward into your [vagina] at last, forcing its way up into you as the plant woman begins to hump you again. Unconsciously, you find yourself turning your head and breaking the kiss as you let loose with a hearty moan; your partner \"hmph's\" in disapproval and turns your head back towards her, locking her lips with yours once again.  Your sensual moaning reverberates through her damp mouth as she edges her tongue to meet yours.");
			//Continued...
			outputText("\n\nYour arms are suddenly forced by the vines that bind you, causing them to wrap around the plant woman's waistline. Giggling, she begins to savagely abuse your loins, slamming her ample ass against your ");
			if (player.balls > 0) outputText("[balls]");
			else outputText("thighs");
			outputText(".  With rolled back eyes, your penis goes haywire with sexual pleasure, body flooded with the instinct to thrust against the plant woman as she slams into your lap.  Gritting your teeth, you feel release boiling up in your loins.  Abandoned to pure pleasure, you grunt fiercely as your " +  player.multiCockDescriptLight() + " tense up and prepare to inseminate this plant monster's cunt.");
			outputText("\n\nOrgasm comes fast and furiously as [eachCock] springs forth loads of semen into her tight body.  Both of you groan while enjoying the sensation of your fluids mixing with each other.  Squeezing you in close to her body with her arms, the creature takes to  mashing her ample ass cheeks against your pelvis to drive delicious cock against the opening of her cervix, causing your stream of semen to shoot deeper into her.");
			//(Multi-cocked: 
			if (player.cockTotal() > 1) outputText("  Buried deep in the makeshift vaginas, [eachCock] thrusts forward and eagerly deposits the nourishment the creature craves.");
			//Vagina: 
			if (player.hasVagina()) outputText("  Cumming hard, your " + player.clitDescript() + " releases a liberal stream of juices down the vine that fucks you, dissolving into the appendage as you moan in furious release.");
			
			outputText("\n\nHer eyes glaze over as your life juices push up into her baby maker.  With a heavy, satisfied sigh, you slump in your vine prison. Panting and moaning, the plant woman buries her face against the left side of your neck, beads of sweat drip down both your faces and neck, and she all too eagerly laps yours up with her tongue.  It all seems like it's all over and you can get on to gentle foreplay; however, she begins to gyrate against you once against, causing you to groan in annoyance.  Smirking, the plant woman rides you like a bull despite the fact that you already made your \"contribution\" to her.  Intent on reaching orgasm herself, she fucks you wildly for several more minutes until she creams your cock in vaginal fluids and your left over spunk.  The vines that bind you shake in unison along with the plant woman as she climaxes, causing you both to drop a few centimeters in the air.  You look around with worry as the plant woman closes her eyes, drifting off to a land of dreams and peaceful sleep.  Twitching once more, the vines continue to drop you several centimeters toward the ground until the creature completes her journey into slumber.");
			outputText("\n\nYour eyes go wide as the sensation of falling registers, and you twist your body as the vegetation suddenly drop you.  As you fall towards the earth on your side, the vines that held you tense around the tree trunks and thankfully slow your descent.  You hit the ground with a soft thud, grunting and groaning as the force of the impact takes your breath away.  The plant woman follows shortly thereafter, bouncing against the ground as she hits.  The fall wasn't that high up, so other than a few bruises you'll both be okay after your little impromptu drop. Pulling yourself free of the creepers, you climb to your feet and grab your gear, quickly donning it so you can get back to camp. As you walk, you feel your earthly lover's spunk drool down your leg, causing you to groan as it seeps into your [armor]. It's going to be an annoying walk back to camp.");
			player.orgasm();
			doNext(camp.returnToCampUseOneHour);
		}

		//[Failure: she wants to blow you, TsI: 1.4 intro]   
		public function trappedPlantSexWantsToBlowYa():void {
			clearOutput();
			outputText("The plant woman looks your body up and down, seemingly torn between what tickles her fancy and how she can take your body.  Her almost childlike darting of her eyes stops when she lays her sight on your player.multiCockDescriptLight(), sending an aroused shiver through her body as she appears to finalize her decision.  Like a child walking to the local stream for a swim, she proceeds towards you in an almost skipping like fashion.  Reaching your naked body, she promptly sinks to her knees and takes your " + player.multiCockDescriptLight() + " into her hand");
			//(if more than 4 cocks or PC cocks are more than 10 inches in diameter combined:
			if (player.cockTotal() >= 4 || player.totalCockThickness() >= 10) outputText("... or she tries to, as she fumbles with your freakish bundle of dicks.  Unable to fit them all into her hand she shrugs");
			outputText(", staring up at you with her leafy hair semi-obstructing her flirtatious and suggestive eyes.");
			//[Blow me! (leads to TsI: 1.4a)]        [Nope (leads to TsI: 1.4r)]
			menu();
			addButton(0, "Blow Me!", trappedPlantSexBlowMe);
			addButton(1, "Nope", trappedPlantSexDontBlowMe);
		}

		//[Nope, TsI: 1.4r]
		public function trappedPlantSexDontBlowMe():void {
			clearOutput();
			outputText("It may seem she wants to take your [oneCock] and suck on it like a sugar cane, but you aren't keen on her choice of how to pleasure you.  Remaining flaccid, you stare down at the plant woman and tell her you aren't interest in a little oral love for your " + player.multiCockDescriptLight() + ", aware of the fact that she can't understand you.  Despite your words likely sounding like jibberish, the plant woman understands your intent and motions for you to make up your mind; given the slightly annoyed expression on her face, you had better make it quick.");
			//(taken back to sex menu)
			doNext(9999);
		}

		//[Blow me!, TsI: 1.4a] 
		public function trappedPlantSexBlowMe():void {
			clearOutput();
			outputText("The thought of getting a blowjob from this rather attractive... um... plant lady excites you greatly, springing your flaccid maleness from it's slumber.  Before the plant woman's very eyes, [eachCock] expands like heated metal; only in a much more dramatic and erotic fashion.");
			//(if cock(s) are 3-24 inches:)
			if (player.longestCockLength() < 24) {
				outputText("  Now staring her straight in the eyes, your ");
				outputText(multiCockDescriptLight() + " stare");
				if (player.cockTotal() == 1) outputText("s");
				outputText(" defiantly at the plant woman; erect in a such a fashion that suggests insult at the attractive creature before ");
				if (player.cockTotal() == 1) outputText("it");
				else outputText("them");
				outputText(" that will be tending to them today.  Eager to rise to said challenge, the plant woman attempts to take your " + player.multiCockDescriptLight() + " into her mouth and ");
				
				//(if cock(s) do not exceed 6 inches in total diameter:)
				if (player.totalCockThickness() < 6) {
					outputText(" manages to fit ");
					if (player.cockTotal() == 1) outputText("it");
					else outputText("them");
					outputText(" into her mouth with little difficulty");
					if (player.cockTotal() > 1) outputText(".  What a champ");
				}
				//if total cocks exceed 6 inches total diameter, but up to two cocks fall under 6 inches: 
				else if (player.twoDickRadarSpecial(6)) {
					outputText(" manages to take two of your pricks into her mouth without dislocating a jaw or showing any obvious of discomfort");
				}
				else outputText(" manages to swallow your dick into her mouth");
				outputText(".");
				//(If cock count is more than two: 
				if (player.cockTotal() > 2) {
					outputText("  The rest of your left out cocks ache for her touch; as she takes the two cocks she has further into her mouth, she raises her arms and attempts to take hold of your members, stroking them as best as she can as she works you with her mouth");
					//(cock(s) are 3-12 inches: 
					if (player.cocks[player.thinnestCockIndex()].cockLength < 12) outputText(" against her face, while planting her hands against your thighs");
					//Cocks are 13-24 inches: 
					else outputText(" in-between her shoulder and neck, using them both to form a tight hole for your other cocks to fuck");
					outputText(".");
				}
				//		(jump to Continued... (“normal” dick sized oral) )
				//Continued... (“normal” dick sized sexing)
				outputText("With your member");
				if (player.cockTotal() > 1) outputText("s");
				outputText(" inside of her mouth, she begins the long awaited sucking and stimulation; starting out slowly at first, she slides the top of her tongue along the bottom of your prick");
				if (player.cockTotal() > 1) outputText("s");
				outputText(", going so gradual that you believe she is savoring the taste of you in her mouth.  To your surprise, she pulls back and lets your cock");
				if (player.cockTotal() > 1) outputText("s");
				outputText(" pop out of her maw, smacking and licking her lips as she grunts her approval like someone who has just enjoyed a fine meal.  Shaking her now intrusive hair out of the way of her eyes, she darts her head forward and takes your ");
				if (player.cockTotal() >= 2) outputText("two ");
				outputText("saliva covered member");
				if (player.cockTotal() > 1) outputText("s");
				outputText(" into her mouth; with little regard for her gag reflex, she raises her hands on your ");
				if (player.cockTotal() >= 4) outputText("upper shafts");
				else if (player.cockTotal() >= 3) outputText("upper shaft");
				else outputText("[hips]");
				outputText(" as she better positions herself for the entirety of your ");
				outputText("cock");
				if (player.cockTotal() > 1) outputText("s as they make");
				else outputText(" as it makes");
				outputText(" contact with the back of her throat.  You feel a bit of pre-cum leak out from the tip");
				if (player.cockTotal() > 1) outputText("s");
				outputText(" of your ");
				if (player.cockTotal() > 1) outputText("two ");
				outputText("dick");
				if (player.cockTotal() > 1) outputText("s");
				outputText(" and ooze against the back of her throat, causing her to moan in delight as your sticky fluids coat her throat.");
				
				//(If Naga: 
				if (player.isNaga()) outputText("\n\nYour snake tail finds its way to her body and begins to wrap itself around her torso, cusping her breasts tightly as you work your way up her body.  With her firmly in your grip, you edge the tip of your tail against the back of her head and 'encourage' her to mimic your motions, helping her time her movements with your pleasure.");
				//If Goo legs: 
				else if (player.isGoo()) {
					outputText("\n\nWorking your soft, goopy lower body around her, you envelop her stomach and torso. This is obvious a cause for concern from the plant woman as she stops and prepares for something bad to happen.  Reassuring her, you take her shoulders and the back of her head into your mass, thrusting her against your cock");
					if (player.cockTotal() > 1) outputText("s");
					outputText(" as you assert a degree of control and influence on your pleasuring.  The sticky mess that is your body solicits a series of lustfully moans from the woman who tends to your loins with her mouth.");
				}
				outputText("\n\nBobbing her head back and forth against you, she sucks and roughs up your cock");
				if (player.cockTotal() > 1) outputText("s");
				outputText(" with her energetic efforts");
				if (player.cockTotal() == 1) outputText(".");
				else {
					outputText(", while she cheek fucks the remainder of your " + player.multiCockDescriptLight() + ".");
				}
				
				outputText("\n\nHer rough treatment doesn't end there; taking a firm grip of your ");
				if (player.balls > 0) outputText("[balls]");	
				else {
					outputText("shaft");
					if (player.cockTotal() > 1) outputText("s");
				}
				//(If balls are present: 
				if (player.balls > 0) {
					outputText(" and the base of your shaft");
					if (player.cockTotal() > 1) outputText("s");
				}
				outputText(", she squeezes with considerable force, almost as if she is attempting to bottle up pressure in your ");
				if (player.balls > 0) outputText("[sack]");
				else outputText("loins");
				outputText(" so that your creamy contents will explode forth into her craw.  Like a knotted up hose line, your cock");
				if (player.cockTotal() > 1) outputText("s");
				outputText(" begin");
				if (player.cockTotal() == 1) outputText("s");
				outputText(" to ache due to the irritating discomfort in your shaft");
				if (player.cockTotal() > 1) outputText("s");
				outputText("; you're unsure if you will be able to achieve orgasm with such a tense grip on your spear");
				if (player.cockTotal() > 1) outputText("s");
				outputText("!  In a rhythmic fashion, the creature ascends your member");
				if (player.cockTotal() > 1) outputText("s");
				outputText(" and promptly descends back downward, flooding your nerves with pleasure and a growing need to cum as she darts back and forth like a grounded raven chasing after a worm.");
				
				outputText("\n\nYour body answers forcefully as the plant woman takes one last plunge down your cock(s), bellowing forth a river of cum as she bottoms out, causing you to writhe around your \"prison\" in orgasmic bliss. The moment your seed rushes out, the hand around your ");
				if (player.balls > 0) {
					outputText("balls and shaft");
					if (player.cockTotal() > 1) outputText("s");
				}
				else {
					outputText("shaft");
					if (player.cockTotal() > 1) outputText("s");
				}
				outputText(" tightens considerably;  with gusto, she starts stroking the base of your shaft like a squeeze tube, eager to aid your sperm in their journey to her stomach as they unknowingly rush to their certain doom.  Bleat red, her face compresses against your loins as she takes load after load into her throat, moaning like a wanton harlot and swallowing every once in a while to ensure that there will be room for more splooge in her mouth.  Just when you think she is going to injure you with her fierce grip, she lets you go; and not a moment too soon it seems, judging from the redness in your ");
				if (player.balls > 0) outputText("scrotum's");
				else {
					if (player.cockTotal() == 1) outputText("cock's");
					else outputText("cocks'");
				}
				outputText(" skin.  Content with your 'donation', the plant woman releases your cock");
				if (player.cockTotal() > 1) outputText("s");
				outputText(" from her mouth with a loud pop; leaving trails of drool and semen on her chin as she does so.  The vines holding you retract from around your limbs and allows you to suit up and leave, whilst she cradles her sated stomach and hums to herself.");
				player.orgasm();
			}
			else {
				//(If all cocks exceed 24 inches, and two to three cocks measure 6 inches in diameter or less total: 
				outputText("  Despite having to position herself a considerable distance away from your body, the plant woman manages to take [oneCock] and fits it into her mouth.  Due to the distance between you two, the plant woman has to ");
				if (player.cockTotal() == 1) outputText("prop some of your length up on her average body to prevent it from straining towards the ground.");
				else outputText("prop your other dicks up with her average body to prevent them from hitting the dirt covered ground.  Obviously she has plans for them, and doesn't want her prize catches getting dirty.");
				//(jump to Continued... (huge dick sized oral) 
				//	Continued... (huge dick sized oral)
				//(All cocks exceed 4  inches in diameter individually: 
				outputText("\n\nHaving to scoot back a fair bit to enjoy her catch, the plant woman kneels against the dirty ground and attempts to take your " + player.cockDescript(0) + " into her mouth.  You feel her attempt to fit your rod into her little mouth; teeth accidentally scraping along your head, the buckling of jaws, and soft lips that are rebutted are all the signs you need to understand that your " + player.multiCockDescriptLight());
				if (player.cockTotal() == 1) outputText("is");
				else outputText("are");
				outputText(" much too large to fit inside of her mouth.  Undeterred by your freakish large member");
				if (player.cockTotal() > 1) outputText("s");
				outputText(", the plant woman smothers her face against your " + player.cockDescript(0) + ", allowing your pre-cum to lather up her face well. Stopping to sheepishly grin up at you, you see that the plant woman has trails of pre-cum connecting between her face and the head of your dick.  Like a kitten with a ball of string, she chases after the strands of pre-cum and attempts to catch them in her mouth.  You grunt and cough at her childish display, to remind her of what she's SUPPOSED to be doing; odd, coming from someone who's trapped in a vine prison.  Embarrassed, the plant woman nods her head apologetically, and takes to your " + player.cockDescript(0) + " with ferocious effort, smearing her face along the head of your cock while dragging her tongue along it with wanton abandon.  You groan at the sensation, and tense up as your body is fluid with relaxing sexual chemicals, easing you up and getting you ready for the pleasure that follows.");
				
				outputText("\n\nThe plant woman continues with her ridiculous method of getting you off, treating the tip of your cock like a pair of billowy breasts as she quickly rubs her face across your head, soaking up more pre-cum as she goes.  A ticklish sensation flies through your cock like lightning in the night sky; grunting and groaning at the treatment, you look down the length of your dick and presumably see the plant woman flicking her tongue along your urethra opening, causing a mix of pleasure and a need to stop being tickled, which interferes with your ability to truly enjoy her efforts.  At her mercy... or lack thereof, she continues her ticklish assault on your dick as you twist and groan in your prison, your body begging simultaneously to cum and for the tickling to stop.  Eventually unable to contain your groans, you loudly yell out repeatedly in frustration as your body twitches uncontrollably;  “STOP! STOP! STOP!!!... FUCK KEEP GOING; AH, FUCK, STOP!”, ringing out in your head as you lose control, wanting desperately for this to end.  The worst part is that the tickle doesn't produce a laugh, only the futile need to break free, as well as to cum in order to end your “torment”.");
				
				outputText("\n\nWithout noticing, your orgasm arrives and launches forth from your " +  player.multiCockDescriptLight() + ", with enough force to startle the plant woman as it slaps her across the face.  A series of passionate moans rise up from under your dicks as the creature is liberally covered in your steamy jism.  Her tongue now free from your urethra, you breathe a sigh of relief as you finally get to relax; the sensation of tickling gone from your body.  Closing your eyes, you can't help but slump to the ground, mentally drained as the plant woman lunges after your torrent of cum like an orphan to food. With the last shot of cum, the plant woman rises to get feet, ");
				if (player.cumQ() < 500) outputText("covered");
				else outputText("drenched");
				outputText(" in your salty seed as she grins like a fool; obviously dumbfounded at her sheer dumb luck to find  a virile specimen such as yourself. The vines holding you retract, allowing your drained body to slowly fall to the ground. Panting heavily, you lie stomach first against the ground and collect your composure as the plant woman walks up to you and strokes your back and hair. She stays at your side until you muster the will and energy to pull yourself to your feet; at which point she helps you to your [armor] and helps you to put it back on. With a smile, she sees you off as you head back to camp.  “Strange that she didn't leave you and let something else have fun with me”, you wonder in your head as you leave the deep woods.");
				player.orgasm();
			}
			doNext(camp.returnToCampUseOneHour);
		}

		//[Failure: She wants you in her ass (TsI: 1.5) 
		//(requires a cock 24 by 4 inches or less, 2 cocks less than 4 inches in width total, or one-two Tentacle Dicks 4 inches in width or less]
		public function strugglePlantLadyFailAnal():void {
			clearOutput();
			outputText("The plant woman stares obsessively at your " + player.multiCockDescriptLight() + " like a fox eying a chicken, causing you some level of discomfort and uncertainty as her face betrays a unnerving sense of lust.  The creepiness is made worse when your vine prison is abruptly pulled towards the lady of nature.  Propping herself against a tree trunk, she bends over and exposes her ample bottom to you , waving it around in an attempt to entice you.  The vines slow in speed as you approach, gradually edging you closer to her rump... almost like the plant woman is teasing you with what could be an agonizingly slow penetration for a person or creature overcome with lust.  “A little presumptuous,” you think to yourself.  Does she really think you're into anal sex?");
			//[No thanks! (Leads to TsI: 1.5r]    [Fuck her ass (leads to TsI: 1.5a]
			menu();
			addButton(0, "No Thanks!", noThanksPlantAnalGiving);
			addButton(1, "Fuck Ass", plantAnalGivingTheDick);
		}
		//[No thanks, or TsI: 1.5r)
		public function noThanksPlantAnalGiving():void {
			clearOutput();
			outputText("Maybe you just don't want to take her back door, but the thought of fucking this creature anally isn't one that sits well with you.  Given that you don't know much about these creatures, any number of things could go wrong if you stuck your " + player.cockDescript(0) + " in her ass.  You attempt to stretch your legs out to catch the ground, but you hover just out of reach.  Your impromptu struggling causes the plant woman to turn around and see what the fuss is all about.  Seeing you trying to get AWAY from her ass confuses the woman of nature.  You make it clear through your limited body language that you are willing to fuck her... maybe... just, not in the ass.");
			outputText("\n\nCrossing her arms, she rolls her eyes and leaves it up to you on how she will fuck you.");
			//(leads to tied sex menu)
			doNext(9999);
		}

		//[Fuck her ass, or TsI: 1.5a)
		public function plantAnalGivingTheDick():void {
			clearOutput();
			outputText("The sight of this nice, ample ass and the thought of fucking a supple  little pucker piques your " + player.multiCockDescriptLight() + ", causing ");
			if (player.cockTotal() == 1) outputText("it");
			else outputText("them");
			outputText(" to become semi-erect.  As you reach her full ass, your prick");
			if (player.cockTotal() > 1) outputText("s poke");
			else outputText(" pokes");
			outputText(" at her soft behind, signaling to her that now is the time guide you into her tight pucker.  Slowly, she edges your cock against the tight opening of her asshole.  Realizing that the asshole ");
			if (player.cockTotal() == 1) outputText("it");
			else outputText("they");
			outputText(" will hopefully penetrate is a winner in the tightness department, your " + player.multiCockDescriptLight() + " surge");
			if (player.cockTotal() > 1) outputText("s");
			outputText(" with vigor and anticipation.   The plant woman can barely contain her surprise as your dick");
			if (player.cockTotal() > 1) outputText("s");
			outputText(" become");
			if (player.cockTotal() == 1) outputText("s");
			outputText(" rock hard and push");
			if (player.cockTotal() == 1) outputText("es");
			outputText(" against her butt hole, her hand shooting up her mouth to contain a giggle.  Looking back over her shoulder at you, she smirks as she pushes against your cock head");
			if (player.cockTotal() > 1) outputText("s");
			outputText(", easing ");
			if (player.cockTotal() == 1) outputText("it");
			else outputText("them");
			outputText(" into her tight pucker.  With a sudden and rough slide forward your cock");
			if (player.cockTotal() > 1) outputText("s");
			outputText(" satisfyingly penetrate");
			if (player.cockTotal() == 1) outputText("s");
			outputText(" her anus, leading to a slight gasp as the plant woman takes you inside of her.");
			
			outputText("\n\nKeeping her comfort in mind, the plant creature stares at the trunk in front of her and takes her time as she gradually eases more and more of you inside of her hot innards.  You grunt as the walls of her ass painfully yield to your spear(s) of lust;  The rough stretching of her contours along your glans continuing until she loosens up, to where both of you can be comfortable with the act.  Throwing caution to the wind, the plant woman “tests the waters” by bounces her ass off of your thighs, eventually increasing in tempo as she adapts to the " + player.cockDescript(0) + " inside of her.  The initial throes of anal sex that your captor inflicts on herself begins to overwhelm your cock");
			if (player.cockTotal() > 1) outputText("s");
			outputText(", causing you to shudder in delicious pleasure as you moan loudly.");
			
			outputText("\n\nHearing your cries of bliss, the creature staring back at you continues her gaze, soaking up the expression on your flushed face and grinning at the fact that you're enjoying to this as much as she is  Her body language betrays her own sexual passions as you return her gaze; every sign of pleasure or reaction to her bucking from you arouses her greatly, getting off to watching you wiggling around and grimacing.  In a deep sexual rut, she dives her hand down to her pussy and begins to stroke it, working her delicate fingers along her ever moist labia.  Her eyes widen and tighten with every wave of pleasure as she fucks her ass along your member and continues to masturbate, gradually picking up her efforts at self-stimulation.  Soon her curved rump is mashing against you, creating a flurry of  fleshly, slapping noises that are frequently drowned out by her constant pleasurable cries of ecstasy.");
			outputText("\n\nHer schlicking becomes short and fast, indicating with her feverish pace that her orgasm is fast approaching.  You feel your own coming on too but you aren't quite there yet, savoring the brush of tight ass along your shaft for as long as you can. That all changes when the plant woman screams out in orgasm, her whole body convulsing in built up euphoria.  The tight shape of her sphincter clamps down hard on your cock");
			if (player.cockTotal() > 1) outputText("s");
			outputText(" as she weakly bounces against you, squeezing down on you with just the right amount of force that it drives you past the point of no return, unleashing a ");
			//Cum output low: 
			if (player.cumQ() < 20) outputText("small amount of semen");
			else if (player.cumQ() < 250) outputText("generous amount of cum");
			else outputText("flood of sticky spunk");
			outputText(" from your cock");
			if (player.cockTotal() > 1) outputText("s");
			outputText(" and into her tight asshole.");
			
			//(If there are free cocks: 
			if (player.cockTotal() > 1) outputText("\n\nThe rest of your " + player.multiCockDescriptLight() + " erupt as well, coating her butt and thighs in sticky jizz.  Like a true slut, the plant woman grabs your ejaculating prick and crams it into her fuck-hole, her pussy milking you of all the cum you can muster up.");
			outputText("\n\nPanting heavily, the floral vixen  giggles and releases you from the vines.  Still wracked with fatigue and orgasm, you slump against her back as she leans against the tree, breathing in tandem with her as you both enjoy the high from a successful orgasm.");
			
			outputText("\n\nAfter a bit of time passes, you work up the strength to stand and pull your cock");
			if (player.cockTotal() > 1) outputText("s");
			outputText(" from her body.  Surprisingly, no cum (yours or otherwise) leaks out of her love button... weird.  With your lust quenched, you decide to head back to camp and get back to... whatever you were doing.  As you put your [armor] back on, the plant woman slips in quietly and kisses you tenderly on the neck.  Smiling, you wave to the delicate plant woman and make for camp.");
			player.orgasm();
			doNext(camp.returnToCampUseOneHour);
		}

		//[Failure: 69! (TsI: 1.6)] (cock(s)less than 24 inches in length, or 4 inches width total if PC has tentacle dicks.
		public function failStruggle69():void {
			clearOutput();
			//(Options are a combination of pussy eating and performing oral on the plant woman; Scenes in the TsI:1.6 section has support for PC's with a cock(s) only, and genderless characters.)
			outputText("With a loud sniff at the air around her, the plant woman closes her eyes and nods her head back and forth. It seems an aroma unknown to you enters her nostrils as she enjoys the flow of it through her being.  Looking around, you try to determine where this mystery smell is coming from; all your eyes see is the bush surrounding you, the vines that hold you, the sky, and the advancing plant woman.  With a disarming grin, the plant woman descends to her knees and inhales once more, shuddering as her forehead lazily comes to rest on your pelvis.  Your perplexing confusion is subdued as you discern that the enigmatic scent she smells is your own; specifically, your ");
			if (player.hasCock()) outputText(multiCockDescriptLight());
			else if (player.hasVagina()) outputText(vaginaDescript());
			else outputText(assholeDescript() + " as she dives nose first into the under crevice of your " + buttDescript() + ", rubbing the bridge of it between your cheeks as she giggles");
			outputText(".");
			
			outputText("\n\nYour nostrils fill with the sweet scent of something nectar like; the smell inciting your arousal and sexual desire.  Shaking your head, you fleetly look the creature up and down until your eyes sight the droplets of moisture on the ground; you're not sweating... and this creature doesn't look like it sweats either.  Standing to entice you, the plant woman darts her eyes down to her pussy and licks her lips.  That's when the mystery odor that floods your olfactory sense is revealed.  Like a shiny gem, her moist pussy catches your eye, eager to receive a lashing foom your tongue.");
			outputText("\n\nThe view of the world around you spins suddenly and abruptly as your vine-like prison takes your body in the air.  The vines twisting and spinning your form, the equilibrium in your head struggles to realign itself and adapt to the disorienting oscillation.  The twisting sensation stops, clearing the blur of colors your helpless eyes see as you realize you are now hanging upside down; the plant woman's wet clit stares back at you in anticipation... as does a large... plant-like cock.  Intending to have you join in on the fun, the plant creature uses her vines to separate your [legs], exposing your ");
			if (player.hasCock()) outputText(multiCockDescriptLight());
			else if (player.hasVagina()) outputText("[clit]");
			else outputText("[asshole]");
			outputText(" with her hands as she moves in for the 'kill'.");
			
			menu();
			//[No way!, leads to TsI: 1.6r]     [69!, eat her pussy, leads to TsI: 1.6a]    [69! give her oral, leads to TsI: 1.6a]
			addButton(0, "No Way!", nowayStruggle69Plant);
			addButton(2, "69 EatDick", struggle69Plant, 1);
			addButton(1, "69 EatPuss", struggle69Plant, 2);
			addButton(3, "69 EatAll", struggle69Plant, 3);
		}
		//[No way!, TsI. 1.6r]
		public function nowayStruggle69Plant():void {
			clearOutput();
			outputText("The dizzying sensation of being hung upside down like a hunter's catch in a tree is bad enough; the idea of this thing forcing her fuck hole against your face and licking your genitalia is more than enough for you to try and break free.  Thrashing around in the vine prison like a fly caught in a spider web, you try to show the plant woman that you are not okay with her choice in 'having fun' with you.  Your erratic and frenzied rejection dawns on the plant woman, and she pouts as she dejectedly flips you up right.  Her stare carries with it a plea for you to reconsider, but you ensure that you will not be swayed on this matter.  With a sad expression on her face, she stares down at the ground, lamenting your denial; raising an eyebrow, you call out the plant creature and assure her through your ");
			if (player.hasCock()) outputText(multiCockDescriptLight);
			if (player.hasVagina()) outputText("[clit]");
			outputText(" that you still want to fool around.  Conveying your preference, you gesture to her that she should... ");
			//(leads to trapped scene selection)
			doNext(9999);
		}

		//[69! pussy, service both, leads to TsI: 1.6a]
		public function struggle69Plant(pt:int = 1):void {
			clearOutput();
			//(Plant woman will randomly decide what to service on your body if herm; if male, she will suck your dick; if female, she will eat out your vag)
			var target:int = 0;
			if (player.gender == 1) target = 1;
			if (player.gender == 2) target = 2;
			if (player.gender == 3) target = 1 + rand(2);
			
			if (pt == 1) { //[69!, TsI: 1.6a, eat her pussy] 
				outputText("Abandoning yourself to the plant woman's desires, you proceed to stretch your tongue and take her sweet, drooling cock along it, allowing her pre to seep along your mouth muscle and ignite your taste buds with her excitement. All too happy that you've chosen the rock hard prick between her hips, the plant woman is eager to reciprocate");
				//PC pussy chosen: 
				if (target == 2) outputText(" as she allows her soft lips to surround your [clit], 'trapping' it for her much anticipated assault.");
				//PC cock chosen: 
				else outputText(" as she wastes no time with 'formalities,' stuffing your " + player.cockDescript(0) + " into her mouth, firmly sealing her lips around your shaft and suckling along the sensitive flesh of your glans.");
			}
			else if (pt == 2) { //[69!, TsI: 1.6a, give her oral] 
				outputText("Abandoning yourself to the plant woman's desires, you proceed to stretch your tongue and take her sweet cunt, allowing her soft sex to drag across it.  The soft tongue of your lover against your ");
				if (target == 2) outputText("[clit]");
				else outputText("[cock]");
				outputText(" flushes your body with arousal as she teases you");
				
				//PC pussy chosen:
				if (target == 2) outputText(", allowing her soft lips to surround your " + player.clitDescript() + ", 'trapping' it for her much anticipated assault.");
				//PC cock chosen: 
				else outputText(".  Wasting no time with 'formalities,' she stuffs your " + player.cockDescript(0) + " into her mouth, firmly sealing her lips around your shaft and suckling along the sensitive flesh of your glans.");
			}
			else { //[69!, TsI: 1.6a, service both]
				outputText("Abandoning yourself to the plant woman's desires, you proceed to stretch your tongue and take her sweet, drooling cock along it, allowing her pre to seep along your mouth muscle and ignite your taste buds with her excitement.  All too happy that you chosen the rock hard prick between her hips the plant woman is eager to reciprocate");
				//PC pussy chosen: 
				if (target == 2) outputText(" as she allows her soft lips to surround your [clit], “trapping” it for her much anticipated assault.");
				//PC cock chosen: 
				else outputText(" as she wastes no time with 'formalities,' stuffing your [cock] into her mouth, firmly sealing her lips around your shaft and suckling along the sensitive flesh of your glans.");
				outputText("  Not to be an inconsiderate 'guest,' you decide to give a little love to her clit as well, soliciting a girlish little squeal of surprise for your lover.  Seems she lucked out this time with such an open-minded partner.");
			}
			//Clit is chosen for plant woman to focus on
			if (target == 2) {
				//PC vagina (mainly, for herms; some recognition will be given to PC cocks): 
				outputText("\n\nThe soft texture of your labia now along her tongue, the plant woman spreads your clit with her hands and allows herself a greater angle to attack your eager sex.  With a nice view of your [vagina], the flora girl sinks her tongue into your fuck-hole like an arrow into bare flesh.  Rending her way through your love canal as her saliva mixes with your pussy fluids, the warmth of her wetness making itself known after every lick of your sex.  Pressing her thighs against your chest, her wet clit slides against your moaning face with prompting force, conveying her need for you to control yourself, center your focus, and lick that tender slit of love button like a good " + player.mf("boy","girl") + ".  Mustering your concentration, you press your face hard against her clit and dart your tongue inward, sliding it ever so gently along her tight contours.");
				
				outputText("\n\nThe tormentingly slow pace you caress her fuck hole at drives the plant woman to writhe against you. The creature's grip on your thighs tightens and loosens and conveys a sense of conflict through her touch, alternating between urging you onward and begging you to speed up to end the agonizingly sensual torment of her vagina.  Her face lurches against your [vagina], strained moans of bliss bellow into your hole as the plant woman tries to stifle her overt display of being overwhelmed.  She can't see it, but a sly smile stretches across your face as you continue your slow assault on her button.");
				
				outputText("\n\nHowever, you aren't the only one who knows how to torment a pussy.  The plant creature decides it's time for your punishment and takes to your [clit] with enough speed to put a hyperactive rabbit to shame.  Your own pace becomes erratic as you spasm and groan at her lightning fast treatment of your pussy, trying your best to keep your gradual snail's paced caressing of her vagina.  The battle with the plant creature to see who can make the other lose control and orgasm in defeat begins, and neither of you gives any ground as you both reach your peaks.");
				outputText("\n\nNeck in neck, you power on with your agonizing pace until she decides to play dirty.  Taking her index finger, she jams into your [vagina] and starts pumping you, causing you to moan angrily.");
				//(Herm support: 
				if (player.hasCock()) {
					outputText("\n\nIf that wasn't bad enough, the unsporting woman also takes to your " + player.multiCockDescriptLight() + " and strokes ");
					if (player.cockTotal() == 1) outputText("it");
					else outputText("them");
					outputText(" teasingly.  The pompous creature gives you a stare down at your form and grins at the “superior” position she thinks she has you in.");
				}
				
				outputText("\n\nNot to be outdone by a cheater, you stick your own finger in her twat and move it in a circular fashion along with your girl jizz-coated tongue.  Howling in uncontainable passion, she arcs her head back and whimpers furiously before diving back against your clit, rubbing her tongue and face with absolute abandon, driving to make you cum before her. Your orgasm is approaching! “No!”, your voice rings out in your head.");
				
				//(if long tongued: 
				if (player.tongueType > TONGUE_HUMAN) outputText("\n\nDeciding that you have had enough, you dart the entire length of your tongue into her, pressing hard against her cervix as you try to cram it all in.  Her moans change from dominant and content pleasure to ones of sheer surprise and violation, causing her to stop abruptly and cry out in denial at your show stopping play.  With a series of fierce groans, the plant woman screams in ecstasy, bringing forth a series of trembling in her vaginal muscles.  Her quivering bounces your tongue around in her nether regions like a leaf in the air.");
				
				//(otherwise: 
				else outputText("\n\nTaking your other hand, you desperately grab her clit lip and fumble it around between your fingers.  Both your bodies twitch violently and orgasm simultaneously, producing a chorus of thunderous moaning from both of you as you spray each other with your lady juices.");
				
				if (player.hasCock()) {
					outputText("  With your feminine release comes a slightly painful build up of pressure in your loins; then, the hot and heavy eruption of cum in the air as your prick");
					if (player.cockTotal() > 1) outputText("s explode");
					else outputText(" explodes");
					outputText(", coating the floral vixen in your seed.");
				}
				//(Transition to End to 69! scene)
				//End to 69! scene, pussy eating
				outputText("\n\nYour vision goes blurry as the sensation of plummeting hits your body.  With a loud thud your head crashes into the ground, your behind slamming down shortly thereafter.  Ringing floods your ears as you groan from the sudden impact to the cranium.  Disoriented, you try to pull yourself up from the ground but can't manage to get up due to your exhaustive orgasm and the pain.  Thoughts of her being a sore loser in your shared little game enter your head, filling you with anger as your senses return.  Turning to yell at the creature, you see that she has dropped to her knees and is crouched over you; expressions of regret and worry on her face.  A hand comes to rest on your cheek, and you see the creature scanning your face for any tell-tale signs of serious injury. You shoot an annoyed look back at the creature and grunt your disapproval; while your descent doesn't appear to have been on purpose, it did still shake you up a bit.  With an eagerness to make up for her mistake, she helps you to your feet and over to your [armor]. Hell, she even helps to put it on you, kissing your forehead apologetically as she does so.  With some annoyance, you shoo the creature away and convey to her that you are just fine... and to stop worrying.  Breathing a sigh of relief, she struts happily alongside you until you get to the path you encountered her on.  The plant woman sees you off as you head back to camp... Herbal tea doesn't sound too bad at this point, if it will kill the annoying headache you now have.");
			}
			//Cock(s): 
			else {
				outputText("\n\nPossessed by savage sexual instinct, the feminine flora hybrid takes to sucking your rod so fiercely that she roughs up the sensitive skin on your head with her bumpy tongue.  Each drag of flesh against cock is getting closer to being painful rather than pleasurable.  Thankfully she applies just the right amount of pressure and suction to avoid chaffing you horribly.   Twitching in your vine prison like an insect hung by a single limb, your body juts back and forth as it tries to withdraw your " + player.cockDescript(0) + " from her mouth.  The pleasure from the vigorous and brutal blowjob is certainly grand, but her harsh servicing of your cock is constantly triggering your flight instinct as she overwhelms your body.  Like a finger trap from back home, the plant creature seems firmly latched onto the head of your cock, sucking up the pre-cum on your shaft like an addict.  Cooing softly, she looks down at you through partially covered eyes, her leafy hair getting in the way of her slutty gaze as she watches you grit your teeth and grimace.");
				
				outputText("\n\nWith no doubt that she is in control, the plant woman squeezes your thigh muscles tightly and takes you against the back of her throat, coughing as the abused intruder in her mouth tickles her.");
				
				outputText("\n\nAs your [cock] is assaulted by her uvula, a barrage of gurgling and gargled sounds ring out from her mouth.  Easing back to see what she's doing, you can only make out her lower jaw and the matting of tender leaf hair as they strenuously dart back and forth on your prick.  Raising her knee to give you a quick but gentle knock to the jaw, your lover reminds you that you're in “this” position for a reason. Sheepishly, you attempt to make up for your lack of attention and begin your assault on her ");
				if (pt == 1) outputText("cock");
				else if (pt == 2) outputText("love button");
				else outputText("love button and cock");
				outputText(", trying your best to guide your tongue around her ");
				if (pt == 2) outputText("clit and vagina");
				else if (pt == 1) outputText("glans and shaft");
				else outputText("clit, vagina, glans, and shaft");
				outputText(" while you hang upside down.  No doubt loving every second of this, the plant woman starts gyrating and grinding her sex against your face, moaning and whimpering between mouthfuls of cock as you ");
				if (pt == 2) outputText("probe her depths");
				else outputText("do your best to service the stiff prick in your mouth");
				outputText(".");
				
				//(PC is herm: 
				if (player.gender == 3) outputText("  In reward for remembering your “duties,” a set of fingers find their way along your feminine sex and into your honey pot, her teasing of your [vagina] ensuring that no sexes on your body are needlessly left out.");
				
				//____________________________________________________________________________
				if (player.isNaga()) outputText("\n\nLike a worm trying to penetrate the soft earth, your snake tail wriggles in the air over you two, twitching in blissful euphoria with every stroke and caress of her tongue along your [cock].");
				//(If Goo:
				else if (player.isGoo()) outputText("\n\nThe viscosity of your gooey body gives way, drooling down your torso in a sloppy, goupy mess.  Thankfully, your slimy legs don't ooze past your stomach; however, the plant woman's bobbing slows down slightly as she is forced to fight the thickness and stickiness of your body.");
				//______________________________________________________________________________
				//Continued...
				outputText("\n\nYou cannot hold out any longer against the creature's efforts, and your ");
				if (player.balls > 0) outputText("testicles begin");
				else {
					outputText("cock");
					if (player.cockTotal() == 1) outputText(" begins");
					else outputText("s begin");
				}
				outputText(" to churn ");
				if (player.balls == 0 && player.cockTotal() == 1) outputText("its");
				else outputText("their");
				outputText(" payload in preparation for insemination.  Apathetic to the cruel fate in store for your cum, you attempt to thrust against her face, eager to churn forth your creamy payload into her awaiting stomach.  Breathing heavily as she works your now chaffed dick, the lady of the earth huffs erratically, struggling to coax your delectable seed from you.  Obliging her, [eachCock] convulses and squeezes with the throes of orgasm, unleashing your spunk into the plant woman's throat.  The slow tug of gravity trickles your donation into the core of this creature, turning her into the perfect, “natural” receptacle to house your syrupy load; something the floral vixen approves of,  moaning out in fierce contentment as the trunk of her body is nourished. As she lowers you to the ground, she slides your [cock] out of her mouth. Thick, salty seed droops on her tongue and lips as she rises to her feet, displaying her catch along her mouth.  Pursing her lips together, the creature gulps the remainder of your donation and smiles devilishly,  her face showing pleasure as her muscles work millions of your seedlings into her gut.");
				//(transitions to End to 69! scene, got a BJ)
				//(End to 69! scene, got a BJ)
				outputText("\n\nSatisfied with the amount of cream she's withdrawn from your testicles, the vine prison lowers you to the ground and retreats into the woods around you, allowing you to rise to the gaze of the plant woman, smirking and giving you a longing look... like she can't wait for next time. Content that the persistent aching need of release has been sated, you re-equip your [armor] and head back to camp, leaving the creature to laze about and feel the warmth of you in her stomach.");
			}
			player.orgasm();
			doNext(camp.returnToCampUseOneHour);
		}

		//TsI 1.7: She fucks you in the pussy (Oops Radar fucked up edition).
		public function struggleFailPlantFucksPussy():void {
			clearOutput();
			outputText("Giving the air a few quick sniffs, the plant woman draws a deep breath into her body, shaking ever so slightly as whatever she inhaled worms its way through her being.  Resolved to her decision, she enticingly saunters over to you. As you contemplate how she is going to sex you the leafy texture of her pelvis erupts forward, ushering forth what appears to be a large, bulbous penis.  You can't help but feel surprised at what has just unfolded between your eyes and quickly snap back to attention as you feel a pairs of hands tugging at your groin coverings.  Eagerly, the plant woman attempts to free your sex");
			if (player.gender > 0) outputText("es");
			outputText(" so that she may take impale you on her perverted cock.");
			
			//[No way!, TsI. 1.7r]     [Allow her, TsI. 1.7a]
			menu();
			addButton(0,"No Way",struggleFailPlantPussyFuckNoWay);
			addButton(1,"Allow Her",struggleFailPlantPussyFuckAllow);
			
		}

		//[No way!, TsI. 1.7r]
		public function struggleFailPlantPussyFuckNoWay():void {
			clearOutput();
			outputText("Whether it's because you ");
			//PC is virgin: 
			if (player.vaginas[0].virgin) outputText("want to protect your chastity, or you ");
			
			outputText("don't want to have sex with this bizarre creature, or simply that you aren't in the mood, you thrash wildly in your vine prison and attempt to knock her hands free.  The flabbergasted creature stumbles back in pain as one of her fingers gets caught in your [armor], hissing as she waves her hand around in the air. It seems certain that she's going to give you a solid punch to the face for your efforts... but it never happens.  Instead, the woman of nature look upon you with a quizzical, annoyed look; seemingly as if to ask you what you WOULD like to do.  She even withdraws her appendage back into her body, confused at how you want her to appear; whether sporting a prick is going to be a dealbreaker or not.");
			//(Player is taken to the TsI sex select screen)
			doNext(9999);
		}

		//[Allow her, TsI. 1.7a]
		public function struggleFailPlantPussyFuckAllow():void {
			clearOutput();
			outputText("The thought of having this hermaphrodite woman fuck your [vagina] and bounce you off her meat until you cream is one that is too enticing to pass up. As the last piece of your kit is removed, you attempt to spread your legs, hoping to show your soon to be intimate lover that you like how she thinks.  The vines do not yield to your efforts, but the force behind them certainly gets her attention as she spreads your legs apart. Leaving you hanging in the air, she closes in and plants a wet kiss on your lips, the soft texture dancing along and teases your own as you return her intimate gesture.  Ecstatic that you're on board with what she has in mind, she works a vine up against your [clit], gently caressing it as she begins to place kisses down your cheek and neck; clearly, she wants to work you into a mean flurry of sexual desire before she gives you what you want.");
			
			outputText("\n\nThe vine continues its torturous build up of your need for penetration until you're working your [hips] towards the semi-hard appendage, desperate for something, anything in your [vagina].  Deciding that she's warmed you up long enough, she pushes the glazed-over vine out of the way and slides herself between your legs, taking your [butt] in hand.  Your [clit] tingling with hunger for her member, you cease your horny efforts and wait for the inevitable yielding of your sex against hers.  The few moments you have to relish your anticipation are cut short by the head of her cock, as it eases against your pussy and builds up force.  The slow entry causes you no end of arousal and delight, all culminating in a loud moan of triumph as her cock breaches the interior of your cunt.  Your earthy lover dives in and steals a kiss from you as she starts working her hips, driving her prick in and out of you while you whimper your sensual lamentations; the plant woman encouraging you to vocalize it as she forces your mouth open with her own, darting her tongue inside to wiggle around in search of yours.");
			
			outputText("\n\nThe minutes pleasantly drag on and on while the creature pumps your cunt, the shape and feel of her internode like cock grinding and pummeling your insides driving you in a mating frenzy as you plead with her to fuck you harder.  The loud noise of your coitus rings through the deep woods like thunderous claps, with your moans of passion followed in-between.  Your lover eventually rips the remainder of your [armor] away and occasionally breaks the kiss you share to suckle from your [chest]");
			//(PC is lactating:
			if (player.isLactating()) outputText(", whetting her appetite for milk ");
			outputText(" as she draws closer and closer to the natural conclusion of your union.  Engrossed with sexual fury, you can barely make out the expression on your lover's face, but it becomes apparent that her flushed, overwhelmed features are foreshadowing her pending release.  With a groan of satisfaction, the creature burrows her spasming dick deep inside of you as your [vagina] ignites with the warmth of her seed along your interior.  Thick globs of cum can be felt impacting all around the inside of your nether parts, and you squeeze down hard on her, intent on keeping as much of her inside of you as possible.  The plant woman thrusts a few more times against your thighs with a few more labored moans, and drives her semen further into you before both of you utter an agreeable sigh of accomplishment.  You two hang there for a time before the vines retract and lower you to the ground, the plant woman pulling out and giving you that 'see you around' gesture as she takes off into the wood.  With smug satisfaction, you replace your discarded [armor] and head back to camp.");
			player.orgasm();
			doNext(camp.returnToCampUseOneHour);
		}

		//Victory and Dominant section
		//[Victory and Dominant Let's fuck!: Vaginal w/ cock (light sided)]
		public function victoryVsPlant():void
		{
			clearOutput();
			//(Victory, V 1.1L):
			outputText("The plant woman sinks to her knees, clutching her ");
			//PC HP victory: 
			if (monster.HP < 1) outputText("shoulder and sides.");
			else outputText("breasts and pussy, twisting at her teats and finger herself like a woman possessed.");
			
			outputText("\n\nYou stand over her, adrenaline flowing through your veins and a sense of stupendous triumph over defeating the plant creature.  She groans in obvious ");
			if (monster.HP < 1) outputText("pain");
			else outputText("arousal");
			outputText(" and glances up at you with uncertainty in her eyes.  You smile as you lower yourself to her level and stare her directly in the eyes.  As you begin to remove your [armor], her eyes go wide, and she smiles nervously in response.  You place a hand on her shoulder and lower back, and gently ease her to the cold hard ground.  Your unwavering gaze into her eyes continues, and your body language seems to accurately convey the correct intent to the plant woman: This is happening on MY terms.");
			//(Next scene is V & D 1.1).
			doNext(defeatOrDomPlantAndCuntFuck);
		}

		//(Dominant Let's Fuck, D 1.1:
		public function dominateVsPlant():void {
			clearOutput();
			outputText("With arousal overtaking your body, you walk towards the plant woman with a cool and confident strut.  Taking her curved hips in your hands, you bring your face to hers and grin lustfully, an expression that the plant woman reciprocates by raising her eye brows suggestively.  Her flirty demeanor fills your loins with a need for satisfaction, and you lower her to the ground.  As you lay on top of her you begin to remove your [armor], but it won't come off!  Struggling, you grind your teeth in frustration at the stubborn part of your gear.  Staring at your display with an amused grin, the plant woman lowers her hands to your belt and eases your hands out of the way.  Using only a little bit of force, she manages to undo your the bothersome part of your [armor] with no difficulty.  Your bemused stare at her upstaging and embarrassment of you only causes her to giggle loudly.  Rolling your eyes, you shake your head and lower your lips to hers, while you work your genitalia closer to her tight button.");
			//(Next scene is V & D 1.1).
			doNext(defeatOrDomPlantAndCuntFuck);
		}

		//(Victory and Dominant scenes converge here) (V & D 1.1):
		public function defeatOrDomPlantAndCuntFuck():void {
			clearOutput();
			outputText("Taking your " + player.cockDescript(x) + " in hand, you angle yourself appropriately and slip it against her labia, soliciting a light gasp from the plant woman as your cock slowly slides across her clitty, the sudden sensation igniting a flame of lust as she wraps her arms around your neck.  Your teasing of her button doesn't abate, continuing to rub your cock across the outside of her vulva before prodding her fuck-hole.  You don't penetrate her just yet; you want her to show you that she NEEDS it.  Sensing your 'cruel' intentions, she wraps her legs around you and pulls herself toward you, intent on impaling her sex on your shaft.  Amused, you place your elbows beside her head and lay your arms out straight, increasing the force ever so slightly behind your cock with the added leverage.  The sensation of pushing past her clit and into her increases and intensifies until you feel a yielding from her sex, signaling your successful penetration.  A pleasurable moan escapes her lips as her hands clench the dirt on the ground, and she closes her eyes to relish the warmth of your member inside of her.  You lower your face to hers and plant a kiss on the her lips, something she's happy to reciprocate as she darts her tongue in your mouth, holding your face close to hers and wanting to keep you right where you are for as long as she can.");
			//If PC has vagina: 
			if (player.hasVagina()) outputText("  Needing some self stimulation to bring your lust to a boil, you lower your hand to your [clit] and begin to stroke your love button, eager to get yourself off in more than one way");
			//(If wounded/ injured during the fight, (V & D 1.1inj): 
			if (combat.inCombat && player.HP < maxHP()) {
				outputText("\n\nYou pick up the tempo of your thrusts, and more moans emanate from your plant-like partner in-between the kissing and tongue action. Grunting as you plow deeper and deeper into her, the kiss you two share is broken in favor of caressing her delicate neck.  She giggles and increases her tight leg grip in which she holds you in.  You close your eyes and concentrate on the pleasurable feeling of fucking this earthly woman's hole, taking it all in like the very air you breathe.  Yet, the wounds on your body catch the creature's attention as she lowers her head down to your shoulder, and begins licking her lips before placing her mouth over your injuries and kissing.  In a strange display, she continues this rather... odd process.  A worrisome thought crosses your mind.  \"<i>Is she swallowing my blood?</i>\" you begin to wonder.");
				outputText("\n\nBefore you can give this any more thought, the plant woman writhes underneath you and clenches her fuck-hole against your cock, causing you to moan as pleasure flows through your being.  Peaking when it hits your arms, this pleasure gives them renewed vigor to finish up as you grab the plant woman's shoulders and thrust fiercely.  Instinct to inseminate her drives you forward as you mash against her with incredible speed.");
			}
			//(Conclusion, V & D 1.1con): 
			outputText("\n\nYou feel your orgasm approaching, and your body delivers the last bit of energy needed to finish the job.");
			
			//PC has more than one dick: 
			if (player.cockTotal() > 1) {
				outputText("  Your extra endowment");
				if (player.cockTotal() == 2) outputText(" flaps");
				else outputText("s flap");
				outputText(" wildly against her thighs and ass, quietly acknowledging the call to arms and prepare to do their part.");
			}
			
			outputText("\n\nShe begins to buck wildly and lets out a noise that resembles a tickled giggle and a cry of unworldly bliss.  Her pussy tightens against your cock, and you can feel a rush of her lady fluids against your ");
			if (player.balls > 0) outputText("[balls]");
			else outputText("loins");
			outputText(".  The sensation is too much, and you cry out as you flood her vagina with your hot semen.  The plant woman senses your orgasmic release and begins to squeeze your sides with her legs, as if pumping you for all of your seed.  Your ");
			if (player.balls == 0) outputText(multiCockDescriptLight());
			else outputText(ballsDescriptLight());
			outputText(" acknowledge");
			if (player.balls == 0 && player.cockTotal() == 1) outputText("s");
			outputText(" her desire and continue to shoot thick streams of your seed into her");
			if (player.cockTotal() > 1) outputText(" as well as on her stomach and the ground beneath you");
			if (player.hasVagina()) outputText("; your vaginaDescript(0) quivers with the need for release, letting loose with its own torrent of lady fluids as you moan in orgasm");
			outputText(".  After a few moments, you slump down on the plant woman's chest, completely spent. A few minutes rest does you good, and with time you rise back up and look down at your partner; a dazed, blissful expression has fallen on her features, the creature lost in pure nirvana as she cradles her stomach. Satisfied with how things turned out, you give her one last kiss and struggle to get back up.  Damn, your ");
			if (player.balls > 0) outputText("[balls] really hurt");
			else {
				outputText("dick really hurts");
				if (player.cockTotal() > 1) outputText("s really hurt");
			}
			outputText(", but looking back at the heap of a woman behind you, you concur that it was totally worth it.");
			//(scene ends if no injuries were sustained during the fight and HP remained maxed; otherwise, scene goes to V & D 1.1inj. end)
			//(V & D 1.1inj. end, If wounded/Injured during the fight): 
			if (player.HP < hpMax()) {
				outputText("Upon returning to camp, you notice that some of the wounds the plant creature kissed have actually healed.  You're not sure how exactly this worked, but at least you don't have to put up with too many cut and bruises now.");
				HPChange(50);
			}
			player.orgasm();
			dynStats("sen", -1);
			if (combat.inCombat)
				combat.cleanupAfterCombat();
			else doNext(camp.returnToCampUseOneHour);
		}

		//[Victory: Vaginal w/ cock (corrupted), Vc 1.1] 
		public function victoryOverPlantGalWithPCCockCorrupted():void {
			clearOutput();
			outputText("You gloat down at your defeated foe and laugh at her audacity to try and force you to fuck her.  With a devilish smile on your face, you remark to her that things didn't work out the way she planned.  The plant woman, on all fours, turns her head towards you and looks at you with a desperate, fearful expression on her face.  You continue as you tell her that it's time she learned a valuable lesson about trying to have her way with you.  The plant woman can't understand what you are saying, but the malice that radiates from you is clear enough.  You grab an assortment of vines from the bush behind you and begin to wrap them around the feminine creature.  She struggles, unsure if what you have planned for her will be pleasurable or painful.  A few twists of vines later, you successfully bind her arms behind her back and then knot her bindings up. You push her ample bottom up in the air and crack a smirk as you disrobe.  The plant woman stares intently at you, now understanding what you plan to do as she coyfully waves her rear in the air.  With little warning, you plunge your " + player.cockDescript(x) + " into her pussy.");
			outputText("\n\nThe plant woman howls at the sudden intrusion and squirms under you.  As you tower over her, you lower your mouth to her ear.  You maliciously exclaim that she likely had a similar idea and to get ready for the fun part to start.  The creature moans as you slide your " + player.cockDescript(x) + " in and out of her pussy, and you grab her hair and pin her head down against the cold dirt.  Each thrust in her fuck hole makes loud slapping noises as thighs smash off one another, the feeling of dominating this woman driving you forward as you savagely hone her vagina.  You can feel something brushing past your " + player.cockDescript(x) + " with every savage thrust;  Given the nature of this creature, you reckon that the walls of her pussy are similar to that of the barbed internode on a plant without any cutting or pain, pure pleasure instead in their place.  Taking the time to pull out on occasion, you smash her clit with your " + player.cockDescript(x) + " and pinching her nipples in the process.  She cries out in a mix of pain and ecstasy with every strike, and a little more pussy juice runs out of her each time.  You place a few fingers in her mouth, and she begins to suck them sensually in-between moans.  Deciding that slapping her clit has gone on long enough, you ram your " + player.cockDescript(x) + " back into her, soliciting yet another flurry of moans and thrashing.");
			//(If Naga: 
			if (player.isNaga()) outputText("\n\nThrusting forward with your snake tail, you slither under the plant creature's form and slap the tip against her chin. Gasping at the sudden smack on her jawline, the plant woman stares down at your tail in-between bucking as you raise the tip to her mouth. With feverish need, she takes your glans into her mouth, licking and smooching it as she sucks on your tail like a delectable cock.  Sensation flows through every plate and scale and into your being while you gloat.  Your domination of her complete, you resolve to fuck her unmercifully until you cream her insides.");
			//(If Goo body: 
			if (player.isGoo()) {
				outputText("\n\nA wicked thought crawls through your skull as you reign over her body... You could use the gooey part of your body to fuck her ass.  Will you do it?");
				//[Yes!]   [No] (if No, go to end scene for Vc 1.1)
				menu();
				addButton(0,"Yes",corruptDomWinFuckGooGal);
				addButton(1,"No",victoryOverPlantGalWithPCCockCorrupted,true);
			}
			else victoryOverPlantGalWithPCCockCorrupted(false);	
		}
		//[Yes] - goofuck
		public function corruptDomWinFuckGooGal():void {
			clearOutput();
			outputText("Taking the slimy mass that is your lower body, you push against her tight ass and let it ooze into her anus.  The wet and sloppy intrusion at her pucker causes a cry of fulfilled desire to escape from her mouth.  Her tongue - not content with being the odd one out - hangs past her open mouth as she giggles like a whore, the creature overwhelmed and utterly obedient to your desires as you fuck her roughly and cause her to leak her sexual fluids like a boat with a hole in it.");
			victoryOverPlantGalWithPCCockCorrupted(false);
		}
			
		//End scene for Vc 1.1
		public function victoryOverPlantGalWithPCCockCorrupted(newl:Boolean = false):void {
			if (newl) clearOutput();
			else outputText("\n\n");
			outputText("After an eternity of ravaging her pussy, you feel your load building up pressure and getting ready to explode.  You tighten your grip on the plant woman's hair and with one last thrust fill her womb with your corrupted semen.  You jerk her hair back, forcing her head back towards your mouth as you begin to neck her.  \"<i>AuuughhhAHHHHHHHHHHHHHHH!</i>\" she screams out as you pull on her hair, with her pussy clamping down on your " + player.cockDescript(x) + ".  Her fuck hole ever so eager to receive your seed, her body convulses violently as you continue to fire more semen into the floral vixen's cervix.  The excretion is too much, and with a groan, you pass out on top of her.");
			outputText("\n\nWhen you awaken, the plant woman is still in the same position as you left her.  She snores quietly, with some moans escaping her mouth and smiling on occasion.  You pull your flaccid dick out of her, and begin to put your [armor] back on.  You turn back to the woman and notice that there isn't any evidence of semen on the ground.  “Bitch must really like my cream.  Can't say I blame her...” you say to yourself.  You leave the plant woman tied up and bound; she'll find a way out of that knot... or maybe something else will stumble upon her... who knows?");
			player.orgasm();
			if (combat.inCombat)
				combat.cleanupAfterCombat();
			else doNext(camp.returnToCampUseOneHour);
		}
			
		//(Victory (light side) or Dominant Let's Fuck!: Get BJ) 
		public function victoryDefeatPlantGirlGetBJ():void {
			clearOutput();
			//(Victory, V 1.2: 
			outputText("As you approach the plant creature you feel a twitch in your pants; you can't help but blush at the fact that after all that fighting you're sporting a big tent.  With a smile on your face you walk over to the plant woman, who is knelt over and trying to catch her breath.  You place a hand on the creature's shoulder and whistle;  The plant woman quickly sits up right and turns, accidentally hitting her head on your " + player.multiCockDescriptLight() + ".  She pulls back, uncertain of the thing that just jabbed her in the side of the head.  You let out an amused laugh, and cross your arms as the creature stares at you for a few moments while trying to assess the situation.  It isn't until she looks down at your crotch does she realize just what she hit and why you are standing there with a perverted grin on your face.  Her mouth opens slightly, and an expression of curiosity appears on her face. She looks up at you with puppy dog eyes, and then grins herself.  You nod at her and beckon her to come to you.  The plant woman raises an eyebrow in interest and then darts over to you.");
			doNext(victoryDefeatPlantGirlGetBJMainSCREENON); //(Scene leads to V and D 1.2)
		}

		//(Dominant Let's Fuck!, D 1.2: 
		public function victoryDefeatPlantGirlGetBJDARKVADER():void {
			clearOutput();
			outputText("Your " + player.multiCockDescriptLight() + " become");
			if (player.cockTotal() == 1) outputText("s");
			outputText(" rock hard at the sight of the plant woman's B-cup breasts bouncing ever so slightly as she walks towards you.  Her feminine legs crossing over the other with every step as she attempts to arouse you.  With foreplay on the mind, she lowers her hands onto of your shoulders and begins to kiss your neck, ignorant to the fact that you are well and ready for some oral attention... Perhaps she just doesn't know it yet?  Deciding to “help” her understand, you take her wrists into your hands and lower them down towards your waistline.  Letting out an amused \"<i>mmhm</i>\" in-between smooching your neck, she traces her soft and delicate hands across your abdomen, sensation spreading through your stomach. “Close, but not quite there yet” you think to yourself.  Guiding her once again, you direct her sensual hands to your crotch (plate) and rub them along it.  A giggle rings out from your partner as she pulls her lips from your neck with a devilish grin on her face at her realization of what you want your partner to do.  You motion down to your crotch with your eyes, intent on conveying to her that it isn't going to suck itself.");
			doNext(victoryDefeatPlantGirlGetBJMainSCREENON); //(Scene leads to V and D 1.2)
		}

		//(Victory and Dominant scenes converge here, V and D 1.2: 
		public function victoryDefeatPlantGirlGetBJMainSCREENON():void 
		{
			clearOutput();
			outputText("She quickly grabs a hold of your [cock biggest] through your [armor] and begins stroking it lovingly.  The plant woman starts at the base of your shaft and strokes upwards towards the head, twisting her hand around it while using her palm to massage the underside of your glans.  She alternates this with jerking your cock for a few moments until you begin to disrobe, the plant creature licking her lips in anticipation as you slowly remove your [armor].");
			
			outputText("\n\nOnce [oneCock] is free in all its glory, the plant woman takes it and begins to lick the opening of your urethra.  It is here that you realize that her tongue has what feels like little dull barbs on it, like the internodes on some flowers.  She senses your surprise at this unexpected sensation and quickens her tongue flicking along your urethra.  You can't help but roll your head back and enjoy her enthusiastic efforts as the creature's tongue slides up and down it.  After she's content with teasing you for a bit, the plant woman");
			//PC has balls: (
			if (player.balls > 0) outputText(" cusps your [balls] in her hand, and suck on the sides of your [sack]. She licks upwards from your testicles and caresses them before");
			else outputText(" licks up from your gouch before"); 
			outputText(" slowly proceeding towards your glans and swirling her tongue around it like a tootsie roll.  It isn't long before the plant woman suddenly stops and looks up at you with mischievous eyes.  She raises her eyebrows twice, and then ");
			
			//[If cock(s) are tentacle dicks and greater than 24 inches in length, jump to (V and D 1.2tc)]
			if (player.countCocksOfType(CockTypesEnum.TENTACLE) > 0 && (player.countCocksOfType(CockTypesEnum.TENTACLE) == player.totalCocks() || rand(2) == 0)) {
				plantGirlPCWinGetTentacleBJ();
				return;
			}
			else {
				//[if cock size is 4-14 inches] 
				if (player.cocks[player.biggestCockIndex()].cockLength < 14) outputText("takes the entirety of your [cock biggest] in her mouth and down her throat.  You lurch forward as your cock hits the back of her throat, moaning intensely at the plant girl's ability to take your whole penis in her mouth.");
				
				//[If cock size is greater than 14 inches]
				else outputText("attempts to take as much of your member as she possibly can.  Your [cock biggest] slams against the back of her throat, and the plant woman tries to take a little more of you to no avail.  She looks up at you apologetically, but you pet her head and ensure that she knows you aren't upset with her.");
				
				outputText("  She stares up at you with a flirtatious look and pulls your cock out of her throat, seeking to get a little more intimate with the head of your dick.  You grip on her hair tightly with every pleasurable sensation as her head bobs back and forth between your thighs.");
				
				//[If Naga: 
				if (player.isNaga()) outputText("\n\nWhile the plant woman occupies herself with your player.multiCockDescriptLight(), you work your reptilian tail underneath your partner's kneeling body.  With a quick thrust upward, the tip impacts with her clit and brushes up her pelvis; the sudden touch causes the plant woman to moan out in pleasant surprise, allowing your [cock biggest] to perch itself on her tongue as she recoils.");
				
				//[If Goo: 
				if (player.isGoo()) {
					outputText("\n\nDeciding to take charge, you lower your slimy mass onto the plant creature's average body, swallowing up her upper body and arms.  With a little concentration and focus, you shift your gooey mess of a lower body to push her arms behind her back, and hold them there while you take her by the back of the head and face-fuck her hard.");
					//(Goo scene ignores the prostate massage, and goes to the End of V 1.2 & D 1.2)
				}
				else outputText("\n\nThe plant girl grabs you by your [butt] and begins to increase her tempo as she lowers a hand to your [asshole].  With little warning, she wiggles two of her fingers through your sphincter and edges her way to your prostate, massaging it once she reaches it.  This intensifies your pleasure, and soon you feel the need to cum.");
			}
			//End of V 1.2 & D 1.2:
			outputText("\n\nYou begin to moan loudly as your orgasm builds, and the plant girl responses by sucking harder, perverted but highly arousing slurping noises easing out of her craw as you roughly fuck her face.  The rush of sexual release runs through your body like electricity, and you cry out as you release your sploge in the creature's mouth");
			//(.  /  ,) (leads to End of V 1.2 & D 1.2: Orgasm)
			//[End of V 1.2 & D 1.2: Orgasm]
			//______________________________________________________________________________
			//(if Non-goo: 
			if (!player.isGoo()) outputText(".  She pulls your dick out of her mouth and closes her eyes as she gets ready to catch the rest of your load with her mouth.  Thick globs of semen erupt from your player.multiCockDescriptLight() and strike her in the face.  She herself orgasms as your torrent of semen washes over her head and chest, covering both liberally.");
			//(If goo: 
			else outputText(", bucking hard against her face as you grunt furiously through gritted teeth and a fierce expression of release.  The plant woman inhales deeply just as you cum into her hot, moist mouth, producing a satisfied series of muffled groans as you deposit your seed.");
			//_____________________________________________________________________________
			//Continued...
			outputText("\n\nWith your orgasm concluded, she takes your penis into her mouth and laps up the remaining cum off and out of your shaft.  You place your hands on her shoulders to hold yourself up as she milks you dry of semen, and after a few minutes of wet, loud slurping, the plant woman pops your cock out of her mouth and begins to kiss up your [legs].  She continues up your chest and then gives you a quick peck on the cheek before taking off.  After catching your breath, you put your [armor] back on and head back to camp.");
			player.orgasm();
			combat.cleanupAfterCombat();
		}

		//[Victory: oral (tentacle dick that is longer than 24 inches)] (V and D 1.2tc, respectively)
		//(Follows normal oral scenes (V 1.2 or D 1.2) until the plant woman tries to take your cock down her throat for the first time)
		public function plantGirlPCWinGetTentacleBJ():void {
			outputText("\n\nYour " + player.cockDescript(x) + " hits her tonsils like a boulder, and then contorts into an angle down her throat.  The plant girl giggles as your rod works its way down into her, which sends vibrations through your member.  Shuttering, you grab the creature's head and thrust your pelvis towards her, intending to ram your cock even further.  The plant creature shoots you with a condescending look, and you begin to pull out; you don't want to suffocate the poor thing after all.");
			//[If cock is shorter than 48 inches]
			if (player.cocks[x].cockLength < 48) {
				outputText("\n\n\"<i>Hmmrph</i>\", you hear the plant girl grunt.  You pause and wonder what creature is complaining about.  Her hand darts out, grasps your ");
				if (player.balls > 0) "[sack]");
				else outputText(nippleDescript(0));
				outputText(" and begins to squeeze tighter and tighter.  “Owww! Owww! Okay, Okay! I get it!” you cry out as you once again ram your " + player.cockDescript(x) + " down her throat.  The plant woman responds by massaging your ");
				if (player.balls > 0) outputText("balls");
				else outputText("nipples");
				outputText(", showing that this is what she wants.  You laugh out loud at the ridiculousness of the situation: you're using a plant creature's throat as a makeshift cunt, and she doesn't seem to be running out of air anytime soon.");
				
				outputText("\n\nYou thrust manically against the plant girl's face while she fingers herself; her eyes have rolled into the back of her head, and she sounds like she really getting off to this.  Your orgasm begins, and you grab the girl by the back of her head and thrust forward as you shoot spunk directly into her stomach.  The plant woman's belly grumbles in appreciation of your donation, and she lets out a muffled cry as her legs begin to spasm.  Warm, sappy juice begins to flow past your feet, and you grunt several times as you empty your load down her throat.");
				//(leads to (V and D 1.2tc) conclusion
			}
			//[If tentacle cock is longer than 48 inches]
			else {
				outputText("\n\nThe plant girl doesn't seem to mind that you're pulling out of her, and she crawls over to a set of trees that are just behind the you of two.  Uncertain of what you have in mind, she reluctantly lies down on her back and braces herself against the trees with her legs.  Her mouth opens wide, and she licks her lips. You connect the dots and grin sheepishly at her kinky idea. You lower yourself down on top of the creature, with her pussy close to your face as you shove your " + player.cockDescript(x) + " down her throat and into her stomach.  She moans intently as you buck against her face, and begins to finger herself");
				if (player.balls > 0 || player.hasVagina()) {
					outputText(" as your ");
					if (player.balls > 0) outputText("[balls] slap");
					else outputText(vaginaDescript(0) + " slithers");
					outputText(" against her forehead");
				}
				outputText(".  You thrust as hard as you can, and it feels like you are hitting the deepest depths of her sex through her stomach lining.  The plant woman's moans intensify greatly, and you lower your head to her sex.  Your hand grabs hers and you cusp your lips around her pussy.  With your tongue darting across her labia and her stomach being fucked fiercely, she begins to twitch uncontrollably, lost in a state of utter bliss.");
				
				outputText("\n\nYour loins begin to ache for release, and you feel the muscles in your " + player.cockDescript(x) + " tensing up,  cum bulging up your cock(s) as your load works its way down her throat and into her stomach.  The instant it hits, the plant woman bucks wildly, her sex spraying you in the face with her nectar-y pussy juice.  You bury your face against her vagina and lap up all of the juice you can as she orgasms.  As you both finish cumming, you and her collapse in a cum-stained heap, panting heavily as you both recover from the ordeal.");
			}
			//(V and D 1.2tc) conclusion
			//(V and D 1.2tc) conclusion: 
			outputText("After a few minutes, you gather enough strength to rise to your feet and pull your flaccid cock from her mouth.  Content, she gives it one last lick before passing out into a deep sleep.  You smile and put your [armor] back on, eager to get back to camp.");
			player.orgasm();
			combat.cleanupAfterCombat();
		}

		//[Victory (light side)  or Dominant Let's Fuck!: Anal 
		//(cock(s) less than 24 inches in length, and 4 inches in width. Ignore length check is PC has Ten. Dick(s))] (V 1.3 and   D 1.3, respectively)
		public function beatPlantGirlDomLetsFuckAnal():void {
			clearOutput();
			//Dominant is also included here, but I am having formatting issues with headers
			//(Victory, V 1.3)
			//(Victory, V 1.3: 
			if (combat.inCombat) {
				if (monster.HP < 1) outputText("The plant woman lies defeated before you, clutching the side of her head and shaking it; no doubt she is seeing stars after the smack down you laid on her.");
				else outputText("The plant woman lies defeated before you, clutching at her womanly folds ineffectually; no doubt she's sensitive beyond measure with all the lust coursing through her frame.");
				outputText("  As you gaze on the plant woman's fauna like body, a thought crosses your mind.  You weren't horny before, but seeing this misguided plant woman lying on the ground with her sex exposed seems to have aroused you, and you can't help but eye her luscious rump.  Taking a step forward towards the creature doesn't sit well with her though, her fear of you painfully blunt as she tries to crawl away.  “Hey! Look, I'm not going to hurt you! I won't hurt you!” you say to her.  The plant woman continues to move away, eyeing your [weapon].  You take a non-threatening stance and offer out a hand to the plant woman.  The creature stops her panicked scrambling and looks up at your face.  Hesitantly, she reaches her hand forward and gently grabs yours.  You smile and kneel down to the floral vixen's level, gently caressing her body as you press your lips against hers.  The creature of nature responds in kind and returns the kiss, her enthusiastic effort creating quite a noise as she breaks and locks lips again and again.  You pull away from her and smirk, your thoughts returning to her rear end again and how it would feel to wrap her ass around your " + player.multiCockDescriptLight() + ".  The plant woman stares curiously at you, attempting to determine what exactly is going through your head at that moment.");
				
				outputText("\n\nYou flip the woman over on her side and lift her right leg up in the air as you pull your " + player.multiCockDescriptLight() + " free from your [armor].  The creature blushes furiously, her pussy glistening in the amber daylight as the sun's rays catch her body.  You brush [oneCock] against her clit, and she moans in appreciation at the prospect of being mounted.  Instead of penetrating her vagina however, you place your " + player.cockDescript(x) + " against her cheeks.  You expect her to shake or buck at this point; even though it seems everything in Mareth wants to fuck or rape you, receiving anal hasn't been all that popular with the locals.  To your surprise, the plant woman does not buck; rather, she places a hand on your buttocks and pushes you inward.  The head of your penis breaks through her tight anus and pushes onward into her ass, and the plant woman responds by clenching up and gasping her restless glee at your entry.  You let out a quiet laugh and begin to grope her breasts with your left hand as you begin to fill more and more of her anus with your spear of pleasure.  Your fingers twirl around her right nipple, massaging and pinching them as you gradually bottom out inside the plant woman.  She begins to shiver as you begin to pull out of her bottom, and a wave of pleasure washes over you as your glans brush past the interior of her tight ass.  Her nipples fill with one last shot of arousal and turn rock hard, the feeling of your fingers against her causes an occasional bead of pussy juice to leak out of her.");
				
				//(If Naga:: 
				if (player.isNaga()) outputText("\n\nThe desire to feel this creature's body along yours consumes you and your lengthy tail slithers around her body.  Coiling around the plant woman's abdomen and working its way up to her average breasts, you  take them firmly in the snug grip in your tail.");
				
				//(If Goo: 
				if (player.isGoo()) outputText("\n\nThe idea of being one with your partner is usually a philosophical notion; however, you take it to a new level when you drag your slimy lower half along her curved and sturdy legs while easing yourself further into her anus.  The bizarre closeness of this act sends a set of pleased vibrations through the plant woman's attractive legs.  The physical euphoria of your partner's sexual gratification reverberates through your body, sending a jaw chattering wave of pleasure as you take in the intimacy of the moment.");
				
				outputText("\n\nGently you kiss her on the neck and begin to pick up the pace of fucking her ass, causing her cheeks to jiggle with every thrust.  ");
				
				//Anatomy Check
				//Testicle check:
				//([balls]/pelvis)
				if (player.balls > 0) ouptutText("Your [balls] slap");
				else outputText("Your pelvis slaps");
				outputText(" against her pussy, causing wet slapping sounds and coating your [sack] liberally with her sexual secretions.  The plant woman moans weakly");
				if (player.cockTotal() > 1) outputText(" grabs a of your penis and guides it to her vagina.");
				else {
					outputText(", while she ");
					//PC has testicles: (
					if (player.balls > 0) outputText("fondles your testicles sensually; surprisingly she doesn't injure you by squeezing too hard despite the rough fucking.");
				}
				//Vagina check:
				if (player.hasVagina()) {
					if (player.cockTotal() == 1 && player.balls > 0) outputText("  Not content with just teasing your balls, the");
					else outputText("  The");
					outputText(" attractive creature darts her hand down to your [vagina], fingering you passionately as she takes the length of your meat into her hungry sex.");
				}
				
				outputText("\n\nSuddenly, she cries out in orgasm; you wait in eager anticipation and expect more lady fluids to drench you.  Instead you feel vibrations in her breasts, and flower petals burst forth from the sides of her mounds.  You stop, staring at the bizarre occurrence that is occurring before you, her leaking teats situated in the middle of her flowery breasts.  The plant woman's face portrays a sense of embarrassment and shame, causing you to let out a startled laugh. “Well now, I don't mind if I do” You remark as you take her right nipple in your mouth, suckling and licking her breast while caressing her flower petals, which drives her over the edge.  You begin fucking her ass once again, and with a sigh of relief, she takes to enjoying the act once more, with you reaching orgasm not long after.");
				
				outputText("\n\nYou grunt and moan as your " + player.cockDescript(x) + " shoots its anal payload ");
				if (player.cockTotal() > 1) outputText(" along with its vagina-clad brother");
				outputText(".  She slumps against you, lost in pleasure and sensation as you drench her interior with hot, sticky cum.  The plant woman's nectar-flavored milk shoots forth from her breasts and coats the ground in front of the both of you, causing her to shake and moan furiously.");
				if (player.hasVagina()) outputText("Your [vagina] obliges, and a few steams of lady spunk flow from your [clit] and intertwine with the fauna creature's fluids on the ground.");
				outputText("  As the plant woman comes down from her climax, you lick your hands clean of her nectar and pull out from her.  You shoot her a look of appreciation, and she fires back a look of utter contentment and bliss.  You leave her to recuperate from the act and head back to camp.");
				player.orgasm();
				combat.cleanupAfterCombat();
			}
			//(Dominant Let's Fuck! (giving anal) D 1.3
			else {
				outputText("Before the plant gets a chance to take two steps forward,you put your hand out towards her, signaling her to stop. Almost immediately the plant woman pauses her movement towards you, like a herbivore as it listens for the sounds of predators. Knuckles against your chin, you stare longingly at the creature's hips as she stands motionless, wondering why you wanted her to stop. Signaling with your index finger, you instruct the perplexed female to turn around. Reluctantly she spins around and exposes her ample rump to your gaze, causing a violent twitch in your pants as her full bottom comes into view. Satisfied, you proceed towards the plant woman, disrobing as you go.");
				outputText("\n\nThe sound of your gear hitting the ground causes the plant woman to look over her unimposing shoulder, and she grins as you embrace her from behind. Taking her left, average breast in your hand, you fondle both her mound and her anther-like nipple as you caress her stomach with your free hand.  The creature shudders from your touch, and you feel a thin stream of her moist pussy juice slowly run down your leg.  The need to fuck her becomes too overwhelming for you, and [eachCock] presses itself against her ample ass, pulsating with desire.  As you lower a hand to guide your player.cockDescript(suitable cock) into her tight asshole, her hand darts out and grabs your dick instead, beating you to the punch.  Surprised at her speed, you slowly draw your hand back and gasp as the plant woman pushes against your player.cockDescript(suitable cock)'s head, taking it past her tight pucker and into her anus.");
				outputText("\n\nGritting your teeth at the sudden pleasurable sensation, you ease yourself deeper into her well developed ass while you manhandle her breast, squeezing and distorting the mammary mound's shape in your tight grip.  Moaning at the rough treatment of her mounds in your grasp, her tongue darts outward and hangs in the air as she pants heavily from the pleasure.  Pumping her luscious rump, you mash your [hips] and pelvis against her, contemplating her tightness as you push onward into the vixen.");
				//First time: 
				if (flags[kFLAGS.TIMES_FUCKED_PLANTGIRLS_ASS] == 0) {
					outputText("  Given the tightness, she must be an anal virgin!  Gleefully grinning like an idiot, ");
				}
				//Subsequent times: 
				else outputText("  Though you've taken her anal virginity, she's still remarkably tight; almost as tight as your first encounter.  Regardless of  how she keeps so tight you soldier on, ");
				outputText("your free hand lowers to her moist sex, fingers plunging onward as you manhandle her humid twat; an act her own hand joins in on as it descends below your own, rubbing and caressing her lower lips in concert with your passionate assault on her vagina.  No longer content with her neck, you swing your head in under her arm and take the neglected breast in your mouth, forming a vacuum suction on her teat that causes the beauty of nature to wail out at the tight sensation.  The plant woman places her hand on the back of your head and presses it firmly to her breast, encouraging you to continue suckling.  Below the two of you, your player.cockDescript(suitable cock) continues to stretch and spread her tight ass from the inside as it (deflowers/forcefully reshapes) her close-fitting anus. The contours of her depths begin to push you into orgasm, and you quickly grasp her curvy thighs in a firm grip.");
				
				outputText("\n\nWith no holding back, you thrust yourself against her as hard as you can, shooting your seed of life into her now honed out asshole as you cry out in blissful orgasm.  You spasm like a stunned insect as you release your sticky payloads, and your " + player.cockDescript(x) + " even catches some back draft as your spunk oozes down her sphincter, unable to proceed any further into your partner's tight anus.  The slippery, wet feeling of cum sliding around in her drives the plant creature to moan out in what sounds like content, satisfied pleasure and a sense of violation at the foreign sensation in her anus. The high of arousal begins to fade after a while, and you stroke your partner's body in an effort to help her achieve her own orgasm, with fingers sliding furiously along her clit as she moans like an animal in heat.");
				outputText("\n\nWith a distressed moan escaping from her mouth, her body jitters against your own; the sensation of something wet starts to run down");
				if (player.balls > 0) outputText(" your balls [balls] and");
				outputText(" your [leg], and the nectar like scent of her pussy juices hits you with pungent force as you breathe it in.  Content and quite exhausted, you start the delicate task of pulling your " + player.cockDescript(x) + " out of her rectum, taking a little bit more at a time out of her until you hear a loud, wet pop from her rump.  Your flaccid and battered penis flops out, signalling what should be the flood of semen from her lovely hole...yet nothing comes out. Curiously, you edge yourself under her and go to spread her cheeks, intent on seeing what the holdup is.  However, caution stops you from doing so; images of getting hit with your spunky drool flood your mind, and you opt to shrug it off. With a pleased wave to the creature, you gear back up and head back to camp. The floral creature gives a weak wave back, no doubt lost in the bliss of having her anus pleasured so well.");
				player.orgasm();
				doNext(camp.returnToCampUseOneHour);
			}
			flags[kFLAGS.TIMES_FUCKED_PLANTGIRLS_ASS]++;
		}

		//[Victory: Anal (corrupted), Vc 1.3] 
		public function pcBeatsPlantgirlAndCorruptAssFuck():void {
			clearOutput();
			outputText("The plant woman lays on the ground in a heap, utterly defeated; unable to try and have her way with you anymore.  You glower at the plant creature as she whimpers and begin to disrobe in front of the creature.  She looks up  as you do this with humiliation and fear in her eyes. Descending down on top of her, you whisper in an authoritative voice, “What part of 'no' don't you understand, you cunt? Did you think you could have your way with me and I would be okay with that?”  The plant woman lies against the ground, not daring to move, with only her breast occasionally brushing against you as she breathes.  You grab the plant woman by the hips and fall backwards on your [butt], bringing her up from a prone position into a suitable one for straddling. Staring into her eyes you chidingly tell her that she wanted sex, so she's going to get what she craves  You spin her around and lift her up by her thighs, with your " + player.cockDescript(x) + " pressed against her ass. She stares at you out of the corner of her eye while blushing, eager to have you inside of her.");
			
			outputText("\n\nYou lower her onto the tip");
			if (y >= 0) outputText("s");
			outputText(" of your ");
			if (y < 0) outputText(cockDescript(x));
			else outputText("two cocks");
			outputText(", and then let her drop down onto your prick");
			if (y >= 0) outputText("s");
			outputText(".  The plant woman shrieks as she slowly starts to bottom out on your rod");
			if (y >= 0) outputText("s");
			outputText(".  As you lower your hand down to her vagina, you begin to lift her up off of your ");
			if (player.balls > 0) outputText("[balls]");
			else outputText("lap");
			outputText(" and your dick");
			if (y >= 0) outputText("s");
			outputText(".  The plant-like creature begins to moan like a cheap whore as you dig your fingers into her sex, and you drop her on your lap again.  She moans out in pleasure and pain as you do this again and again.  Eventually, you're able to break her in and begin to brutally ass-fuck this abomination of fauna.  responds by bucking against you, surrendering herself to your will and your ravaging of her incredibly tight hole.  “And here you were putting up a fight to get your own way you cheap, easy whore,” you vilely taunt the plant woman as she moans uncontrollably.");
			
			//(If long tongued:
			if (player.tongueType > TONGUE_HUMAN) {
				outputText("\n\nThe sight of her perky, average breasts entices your tongue to want to fool around with them, and with energetic gusto, your long tongue darts out of your mouth.  Lowering your head under her left arm, you lash your tongue out at her right nipple, seizing it in your wet, humid grip.  Grabbing at your hair, the plant woman presses your head against the side of her body while taking a firm hold of her breast, squeezing it to allow you better access to her perked up teat.  Without hesitation, you lick and lap at her nipple, trapping it in a flurry of frenzied lashes from your tongue.");
				//(Continue to Orgasm)
			}
			//(If Naga:
			else {
				if (player.isNaga()) outputText("\n\nLooking down at your snake-morph body, you see your scaly tail lying on the ground looking rather useless.  A sinister grin spreads across you face as you deduce a way to involve your tail in the action... though, it's a question of whether you want to fuck her clit with your tip.");
				//[Penetrate her]    [Stick to anal (ignores penetrate her, proceed to Orgasm]
				menu();
				addButton(0,"Penetrate", nagaPenetrateWithTailDuringPlantGirlMeanAnalPCWin);
				addButton(1,"Stick2Anal", pcBeatsPlantgirlAndCorruptAssFuckPt2);
				return;
			}
			pcBeatsPlantgirlAndCorruptAssFuckPt2()
		}

		//[Penetrate her]
		public function nagaPenetrateWithTailDuringPlantGirlMeanAnalPCWin():void {
			clearOutput();
			outputText("With a twist of your sleek snake tail, you angle your tip to thrust up into her.  The plant woman doesn't see your tail coming and shrieks as you dart up into her clit, tip pushing her pussy lips aside as you work as much tail end into her as possible.  Thrashing manically, the plant woman moans theatrically as you start the process of double pumping her pussy and ass.");
			pcBeatsPlantgirlAndCorruptAssFuckPt2(true);
		}

		public function pcBeatsPlantgirlAndCorruptAssFuckPt2(tail:Boolean = false):void {
			//Orgasm] 
			outputText("\n\nThe urge to cum rises, but you muster all of your self control in order to not orgasm too early; you want her to 'suffer' for her actions.");
			
			outputText("\n\nMinutes pass as the plant woman's incessant moans radiate across the deep woods, echoing off of every tree truck within shouting distance.  The floral beauty's pussy is completely drenched in fluids and has taken to fingering ");
			if (!tail) outputText("herself");
			else outputText("her labia while you fuck her with your tail");
			outputText(" and playing with her breasts as you pump her ass with all of your might.  You can no longer control the timing of your orgasm, and you howl in savage delight as you bottom out in this plant creature's sphincter.  She cries out so loud that you swear she almost ruptures your ear drums, slamming against you in a uncontainable thrashing orgasm.  You place your hands on the top of her thighs and push downward, intent on burying your cock");
			if (y >= 0) outputText("s");
			outputText(" deep in her ass as you fill her up with your tainted splooge.  She quivers violently; her body intent on getting some room but you will have none of it.  You keep her pinned against your lap until you have finished cumming and pull out of her, wiping yourself off with her hair as you proceed to replace your [armor].  The plant woman lies against the ground, now utterly dominated and unable to move.  As you walk away, you hear a rustling in the bush near her.  You let out a loud laugh as you picture an imp or tentacle monster emerging and proceeding to pick up where you left off.  As much as you would like to stick around and find out what fate lies in store for her, you have other things to do.  You turn and head back to camp.");
			player.orgasm();
			combat.cleanupAfterCombat();
		}

		//Victory (light side) or Dominant Let's Fuck!: Suck her dick
		public function victorySuckPlantgirlsDick():void {
			clearOutput();
			// V 1.4 and D 1.4, respectively
			//(Victory intro, V 1.4: 
			if (combat.inCombat)
				outputText("You walk towards the plant woman to assess whether she still poses a threat. Judging by the way her eyes are devoid of any hostility or defiance and how she can barely move, it's safe to say she won't be giving you any trouble.  You stand over her with arms crossed, staring at the bizarreness of this creature.  How the hell can the demon's magic corrupt something to such an extent?  ");
			//(Dominant intro, D 1.4: 
			else {
				outputText("Ideas of popping a large, flowery cock in your mouth and downing this creature's hot, salty cum into your gullet flood your mind, causing you to lick your lips at the imaginary taste of sweet, spunky jism against your wet and eager tongue.  Staring down at the plant creature's pelvis, though, causes a wave of disappointment to wash over you.  As she closes the distance between the two of you, the missing bob, prod, poke - hell; even a pitiful wiggle in her drawers - is soul-crushingly absent.  Her hands caress your [chest] as she helps to remove your [armor], rubbing along your body in an obvious attempt to arouse you. You gaze down on her body once again and sigh, still not seeing any miraculous sprouting of a thick, plump cock for you to lick and suck.  Sensing your discontent and disappointment, the plant woman's eyes meet yours as she gauges the reason for your unhappiness.  To help her understand, you ");
				//PC has a dick: 
				if (player.hasCock()) outputText("take [oneCock] and poke the tip of your head against her pelvis; where a penis would be located if she were a guy... or pretty much everything else around here.");
				//PC doesn't have a dick:
				else outputText("mimic the motions of sucking on a large phallic object, popping your cheek out with your tongue for effect.");
				outputText("\n\nYet nothing happens.");
				
				outputText("\n\nYou pull away to break the embrace that the plant woman has you in, but she directs your body back towards hers; she winks at you with a mischievous, flirty grin on her face as you feel the warmth of her body against yours.  Uncertain, your head arcs back in a confused fashion... and without warning, something jabs you in the bare stomach.  Shocked at the sudden impact, you jump and stare downwards to see what just hit you.  Just like a child stumbling on a hidden treasure, your eyes go wide in excitement and anticipation.  Resting like a fish out of water on your stomach is an 8 inch long, bulbous cock, wet with pre-cum and throbbing, eager to be taken into your moist mouth and assaulted by your soft tongue.");
				//(Scene leads to V and D 1.4)
			}
			//(Victory... where the cock?, V 1.4?:
			if (combat.inCombat) {
				outputText("\n\nYou snap out of your musings to discover that ");
				if (player.hasCock()) outputText("[eachCock] is rigidly erect");
				else if (player.hasVagina()) outputText("your [vagina] is gazed over with your secretions");
				//Genderless: 
				else outputText("your body is flushed with sexual need");
				outputText("; you must have gotten aroused during the fight.  Shaking your head, you decide that you may as well explore the plant woman's anatomy to see what she's bringing to the table; maybe she's hiding a little penile surprise just for you.  You help the plant woman to her feet and draw her in close to you, confusing the hell out of the battered creature.  Obviously perplexed, she distances herself from your embrace.  You decide to reassure her of your intentions and gently begin to caress the sides of her abdomen as you seductively stare into her eyes.  They go wide at the realization of what you're doing, and she relaxes her demeanor, returning your embrace.  Gazing down at your injuries, an expression of sadness spreads across her face; it seems she feels guilty for injuring you during the fight.  She lowers her head to your shoulder and kisses the wounds you sport, taking special care to clean the injury as best as she can.  The feeling of her tender attention doesn't hurt at all - it actually feels good as her lips caress you.");
				outputText("\n\nAs the plant woman finishes up, you refocus on your search.  However, you turn up nothing of 'interest' one vagina, an nice firm ass, and a pair of breasts... but no dick for you to play with.  The plant woman senses your disappointment, with an expression of concern on her face as she stares you in the eyes. Then suddenly they go wide, filled with excitement and giddiness at a realization.  The creature smiles as her pelvis begins to vibrate, causing you to take a step back; you aren't exactly sure of what is going to happen next and decide to err on the side of caution.  As you look on curiously, something bursts forth from her pelvis. You grin like a mad fool when you realize this is what you have been looking for.  The plant woman stands in front of you with a finger in her mouth and her body suggesting anticipation.  You step forward, taking the plant woman's penis in your hand and gently massaging what you assume is her glans.  She arcs her head back as the sensation of your touch floods through her like a wave, quivering as her desire for stimulation is at long last fulfilled.  As you stroke the head you lower yourself onto your knees, eager to take this creature's member in your mouth.  With her eyes closed, the plant woman is too busy enjoying the hand action to take notice of what comes next.");
				//(Scene leads to V and D 1.4)
			}
			//(Victory and Dominant scenes converge here, V and D 1.4: 
			outputText("\n\nWith eager enthusiasm you take the creature's cock into your mouth, allowing your tongue to make contact first as her penis slides along the top of it.  In one swift motion her dick slides past your tongue and hits the back of your throat, of which you intend to bury her cock against.  As you press it against your esophagus you twist your head, moaning in pleasure at the sensation and feeling of her in your mouth. You hear a loud gasp as you twist your head, and the plant woman places her hands on the back of your head as her body shakes. “She's definitely enjoying it so far,” you think to yourself.  You pull back a bit as you form a tight seal around her with your lips, sucking and stroking the top of her shaft with your tongue.  Pre-cum leaks from her liberally as you rock your head back and forth, sliding down your throat as you gasp and swallow in-between sucking her cock.  The taste of her reminds you of a herbal mix the village doctor had you ingest before you began your journey.");
			outputText("\n\nYou pick up speed after a few minutes, having had enough samples of her lady cum; you want the full course.  You place your hands against her hips and begin deep-throating her cock as hard as you can. The plant woman cries out and her legs start to wobble.  The sound of sporadic heavy breathing is soon replaced by frequent wailing from your partner.  You begin to bob back and forth as fast as you can and the feminine creature falls to the ground, overcome by your efforts.  Giggling at her “predicament”, you take the length of her cock into your mouth, allowing it in as slowly as you can.  The creature's eyes go wide, and she screams in orgasm while ramming her cock in as far as she can.  A sappy, sticky load erupts forth from her urethra and strikes you in the tonsil, causing a ticklish sensation.  You almost gag from it as the floral vixen continues bucking her pelvis against your head, now held in a passionate embrace between her thighs.  Stroking your head contently, she finishes shooting thick streams of cum down into your throat as you swallow her lady fluids.  You stare up at her with an appreciative look in your eyes, and the plant-like woman responds by sticking her thumb in her mouth and sucking on the bottom of it, grinning as the last of her cum subsides into your waiting mouth.  Popping her penis out of her mouth, you wipe your lips clean as you grab for your [armor]. You wave to the plant creature as you head back to camp, her sappy load giving you a feeling of fullness in your stomach as you walk.");
			dynStats("lus", 10+player.lib/5);
			if (combat.inCombat)
				combat.cleanupAfterCombat();
			else doNext(camp.returnToCampUseOneHour);
		}

		//Victory (light side) or Dominant Let's Fuck!: anal ride (light side)
		//V 1.5 and D 1.5, respectively]
		public function beatPlantGirlAndTakePlantCockInButt():void {
			clearOutput();
			//(Victory, V 1.5: 
			if (combat.inCombat)
				outputText("Lowering your [weapon], you study the creature that you have just defeated.  As she pants and struggles to get up, you note the corruptive nature the local ecology has had on her body, warping and shaping her sexual features to be more plant-like.  Looking around the battle sight you see the vines that she intended to use to trap you, and an idea crosses your mind.  If she had control over the vines, maybe she can sex your ass with them.  Or maybe she can morph. Who knows?");
			//(Scene leads to V and D 1.5)
			//(Dominant, D 1.5: 
			else outputText("With careful coordination and care, you quickly and deftly sweep the plant woman off her feet and lower her to the ground on her back.  Her eyes go wide as you do so, and she tenses up; possibly because she thinks that you might be attacking her.  The soft descent to the ground changes her demeanor a bit, but her body language suggests that she is still wary.  With uncertainty, she stares up at you and awaits your next move.");
			//Scene leads to V and D 1.5)
			//(Victory and Dominant Scenes converge here, V and D 1.4): 
			outputText("\n\nYou lower yourself to her pelvis and begin to trace your finger across it, making a stroking motion with your other hand as you do so.  The plant woman stares at you in utter confusion.  You shake your head as you stand, spilling a few drops of sweat from your arm on her leafy body in the process.  You grab a vine and start to 'ram' it against your [butt] to signify what you want her to do.  Eyes widening, the plant woman tries to stand while she concentrates on what you're trying to say.  Throwing your hands up in the air, you sigh and start back toward camp.  The plant woman whimpers behind you as you start to leave, causing you to turn around.  Perching herself up against a tree trunk, the plant woman beckons you to come back.  You cross your arms and arc your finger several times to her pelvis. “Look, you don't have what I want, so-” you start to say.  The plant woman's pelvis in response begins to vibrate, with the occasional bump appearing.  Quizzically you stare at her pelvis, wondering just was exactly is happening.  Your questions are soon answered when a plant-like appendage bursts from her pelvic area. “Well,” you think to yourself, “that certainly is a game changer...”");
			
			outputText("\n\nGrinning, you disrobe and gently lay the plant woman on the ground with her cock bobbing in the air in eager anticipation.  As you lower yourself onto her loins, ");
			if (player.hasCock()) outputText("[eachCock] becomes rock solid");
			if (player.gender == 3) outputText(" while ");
			if (player.hasVagina()) outputText("your pussy becomes incredibly wet");
			if (player.gender == 0) outputText("nipples become erect");
			outputText(" in response to your own arousal and desire.  The tip of her penis presses against your cheeks and pushes its way into you as you allow it past your anus and into the depths of your ass.  The creature opens her mouth in an 'ohh' expression, enjoying the sensation of breaking past your [asshole].  As she bottoms out, ");
			if (player.hasCock()) outputText("[eachCock] jerks upward, the last shot of blood filling and hitting them like a thunderous punch");
			if (player.gender == 3) outputText(", while ");
			if (player.hasVagina()) outputText("your pussy leaks a bit of girl cum.  It slowly drools out onto her pelvis");
			if (player.gender == 0) outputText("your body quivers from the sensation");
			outputText(".  ");
			//PC has balls: 
			if (player.balls > 0) outputText("Your [balls] laying on top of her pelvis, y");
			else if (player.hasVagina()) outputText("Your vaginal muscles clenching up along with your sphincter, y");
			else outputText("Y");
			outputText("ou ");
			if (player.balls > 0) outputText("begin to massage your [sack] as you raise your hips upward");
			else if (player.hasVagina()) outputText("relish in the moment and allow a hand to drop to your sex as you raise your hips, eager to please both ends during this act");
			else outputText("grab her nipples and begin to play with them");
			outputText(".  Slowly, you lower your hips back down once again onto the plant woman's penile member, causing your partner to moan in lustful appreciation.  A sense of fullness floods you as you allow yourself to take her entire member inside of you.  You ");
			if (!player.hasVagina()) outputText("place both hands on her shoulders");
			else outputText("continue to finger yourself");
			outputText(" as you bob your [asshole] against her lap, moaning loudly as you do.  The plant woman's hands shoot out and ");
			//PC has a pussy (and/or) a dick:
			if (player.gender > 0) {
				outputText("grab both your [chest] and ");
				if (player.hasCock()) outputText("[oneCock]");
				if (player.hasVagina()) outputText("your vulva");
			}
			//PC is genderless:
			else outputText("your nipples, playfully tugging on them");
			outputText(", intent on magnifying your own pleasure.");
			
			//Dicked and/or pussy equipped players only, genderless skips this part
			outputText("\n\nThe pace quickens as your cheeks begin to slam against her pelvis, while the creature ");
			if (player.hasCock()) outputText("strokes [oneCock] with her hands");
			if (player.gender == 3) outputText(" as she also ");
			if (player.hasVagina()) outputText("massages your labia");
			if (player.gender == 0) outputText("massages you");
			outputText(".");
			outputText("  The plant woman thrusts in kind,  mashing her pelvis against your own as you bounce off the creature. You manage to time your descent with her thrusts to intensify both of your pleasures.  She ");
			if (player.hasCock()) outputText("quickens her pace of stroking your cock");
			if (player.gender == 3) outputText(" and ");
			if (player.hasVagina()) outputText("fingers the interior of your pussy, causing you to roll your eyes into the back of your head as she sensually teases the inside of your sex");
			if (player.gender == 0) outputText("raises herself to deliver a passionate kiss");
			outputText(".  You feel her thrusts getting shorter now, and you know that her she going to blow her load soon.  With gradually closing eyes and increasingly frequent panting and moaning, she grabs your hips and holds them in place as she thrusts upward one last time.  With a lusty moan, her spunk shoots into your hot innards with significant force, allowing you to feel the impact of every shot of cum in your anus.");
			outputText("\n\nYou cry out in fierce orgasm, ");
			if (player.hasCock()) {
				outputText("[eachCock] erupting its own payload onto her face and chest");
			}
			if (player.gender == 3) outputText(", ");
			if (player.hasVagina()) outputText("vaginal muscles clamping down and drooling pussy juice all over the plant woman's lap");
			if (player.gender == 0) outputText("twitching futilely around the plant-girl's swollen seeder");
			outputText(".  With a groan, you collapse against the creature's chest, desperately trying to catch your breath from the taxing ordeal.  The plant woman hums approvingly, stroking your hair as your body ascends and descends from her own because of your heavy breathing.  After some time, you are able to muster the strength to pull yourself off of the plant creature, her cock slipping out of your ass and unleashing a flood of sappy jism from your anus.  Content, she passes out into a deep sleep.  You grin to yourself, putting your [armor] back on and heading back to camp.");
			player.orgasm();
			if (combat.inCombat)
				combat.cleanupAfterCombat();
			doNext(camp.returnToCampUseOneHour);
		}

		//[Victory: Blowjob and Anal (corrupted), both Vc 1.4 and 1.5]
		public function defeatPlantgirlBlowAndButtfuckCorrupt():void {
			clearOutput();
			if (flags[kFLAGS.TIMES_GOT_CORRUPT_BJ_ANAL_PLANTGIRL_SCENE] >= 2) {
				defeatPlantgirlBlowAndButtfuckPure();
				return;
			}
			outputText("Staring triumphantly at your opponent, you grab her and throw her against a tree trunk, her back hitting the trunk and causing her to cry out in pain.  Eager for release, you tower over your conquest. Well now, that wasn't much of a fight was it? you say, taunting the plant creature.  Let's have a looksie for your cock, shall we?");
			outputText("\n\nYou poke, prod, and grope at her pelvis for a few minutes, eager to coax any hidden penis out of her body.  The plant woman's pussy drools with juice at the rough treatment, angering you further; you want a cock, not her pussy goddamnit!  \"<i>Where the hell is your cock? COME ON, I know you have one!  Almost everything around here does!  DON'T YOU DARE HOLD OUT ON ME!</i>\" You yell.  The plant woman's aroused look turns to fear at your tone.  After a few more frustrating moments, you pull back from the plant creature.  \"<i>GODDAMIT! Of all the creature I pick to fuck, this one DOESN'T have a dick! FUCK!</i>\" You yell.  Angrily you return to camp, leaving the bruised and battered creature to lick her wounds.");
			//(Occurs only two times; third time around, the light side scenes play out for Blowjob and Anal)
			flags[kFLAGS.TIMES_GOT_CORRUPT_BJ_ANAL_PLANTGIRL_SCENE]++;
			doNext(camp.returnToCampUseOneHour);
		}

		//Victory and Dominant: Fuck her cock w/ your pussy (light side)
		public function defeatPlantgirlBlowAndButtfuckPure():void {
			//V 1.6 and D 1.6
			clearOutput();
			outputText("With your hands on your hips you " + player.mf("walk","sway"));
			
			//(Victory, V 1.6:)
			if (combat.inCombat)
				outputText(" towards the battered creature as she struggles to get back to her feet.  Her efforts are quite for naught as her arms give out, causing her to hit the ground hard.");
			//(Scene leads to V and D 1.6)
			//(Dominant, D 1.6: 
			else outputText(" towards the plant woman, causing her to giggle in response as she beckons you over to her.");
			//(Scene leads to V and D 1.6)
			doNext(defeatPlantgirlBlowAndButtfuckPure);
		}

		//(Victory and Dominant scenes converge here, V and D 1.6):
		public function defeatPlantgirlBlowAndButtfuckPure():void {
			outputText("\n\nAmused, you disrobe and scan the plant woman's body for something penile to stuff your vagina with; however, much to your chagrin, it appears that this creature DOES NOT have a cock.  Rolling your eyes you gaze across the bush to find something to satiate your needs, and your gaze meets one of the vines that the creature used to try and trap you.  “Well, it will have to do” you say to yourself as you grab the vine and press it against your ");
			if (player.isNaga()) outputText("now exposed ");
			outputText(clitDescript() + ".  The plant woman yelps in surprise as the vine makes contact with your labia, causing you to jump a little.  You turn to face the plant woman, who is blushing profusely and resting her hand on her pussy.  Looking at the vegetation, you deduce that she must be able to feel you along her vines and that these creepers may also function as penile appendages.  A grin spreads across your face as the realization hits you, and you bring the vine back to your sex and tease your vulva.  Soft moans escape the plant girl as the head of the perverted vegetation brushes past your clit, and you ");
			//(pure: 
			if (player.cor < 50) outputText("giggle");
			//Corrupted: 
			else outputText("smirk");
			outputText(" at the woman's predicament.  Deciding to stop teasing the poor girl, you take the head of the creeper and push it into your pussy, edging it upwards at a gradual pace so that your partner can feel the contours of your " + vaginaDescript(0) + ".");
			
			outputText("\n\nThe plant woman sinks down to her knees as she is overcome by the sensation of her vine breaching the head of your vagina, occasionally thrusting her pelvis in the air as she bucks.  Pulling the penile creeper out of you, you walk over to the defeated creature.  “Well, seems I found your weakness” you say as you gloat down at her. “Shall I continue, my dear?” You spin around with the intent of allowing the plant creature to gaze on your [asshole].  The vine in your hand leaks what you assume is pre-cum in response, and you slap your [butt], glad that your little show is getting the plant woman off.  You hear the plant creature slowly rising and you turn, trying to solicit a response to your earlier proposition.  What greets you, though, takes you by surprise; standing firmly and sporting a devilish grin, bizarre floral creature saunters towards you in a seductive way, with... a penis... dangling between her legs “That wasn't there before!” You remark. “You tricky little tease...”");
			
			outputText("\n\nIt seems you have two options now: you can continue to use the vine (and maybe punish her for holding out on you), or you can set out to take what you originally wanted from her.  Though, it looks like you could take more than just one vine if you want.  Or you could have them all!");
			
			menu();
			//[Vine, V and D 1.6vp]	   [Vines, V and D 1.6mvp]     [Cock in pussy only, V and D 1.6c]
			
		}
		//[Vines and cock, V and D 1.6vc]
		public function vineAndCockWithPlantGirlPCWin(scene:int = 1):void {
			//[Sticking with the vine(s), Vine in pussy/Vines in pussy, ass, and mouth, V and D 1.6v, V and D 1.6vp and V and D 1.6mvp, respectively]
			clearOutput();
			//(Sticking with the vines, V and D 1.6v:
			if (scene == 1) outputText("“A little late, don't you think?” You say to the plant creature, holding her vine firmly in your hand.  She stops dead in her tracks, unsure of your tone or intent.  \"<i>I'm quite content with the vine, thank you,</i>\" as you lower your hand to your sex, pressing the vine against your labia once more.  The plant creature's eyes go wide, a sense of shock and longing in her face as you bring her appendage to the mouth of your eager [clit].  Her cock bobs up like a dog whining for attention as she draws you in close, smearing against your thigh as you begin to push the vine into yourself.  \"<i>Now, now, I've made my decision.  You're just going to have to accept it,</i>\" you say through a devilish grin, intending to deny her member the hole it so craves.  She lets out a mix of what sounds like a whine and a moan as you continue to caress your pussy with the one creeper in your hand.  You push her to the ground and lay on top of her, placing her member in-between your ass cheeks and taking the head of the vine into your clit.  \"<i>UUUEEGH,</i>\" the plant woman moans out as her vine penetrates you.");
			
			outputText("\n\nYou snake the penile appendage roughly into your sex and begin to fuck your " + vaginaDescript(0) + " like there's no tomorrow.  Bracing yourself on your knees, you begin to gyrate your pelvis against your motions with the vine, causing you to moan like a cheap whore as you fuck yourself senseless.  The plant woman moans pathetically as she pinches her nipples and plays with her vagina.  Every once in a while, she tries to position her penis against your anus, longing to worm her cock in your ass while you pump yourself; you always slap it away before she can, causing her to moan in frustration at her inability to stimulate her cock.");
			//(Scene leads to V and D 1.6vp or V and D 1.6mvp, depending on player choice).

			//(If PC has slime body: A moment of sheer genius arcs like lightning through your head... she won't get the chance to fuck you vaginally, but you could use your lower, goopy mass like an onahole on her bulbous cock... or you can continue your "No Dicks" policy.
			//[Slime time!]     [No dicks]
		}
		
		
		/*
		[No dicks], leads to V and D 1.6vp or V and D 1.6mvp, depending on player choice.

		[Slime Time!]  Deciding that her torment has lasted long enough, you shift your sticky mass around her shaft and apply just enough pressure so that she knows you have her dick in your "grip".  The plant woman's eyes go wide with pleasant shock, staring up at you as she arcs her mouth open slightly, as if to ask you if this is really happening.  You nod seductively, and with a conscious "twitch," the goopy onahole that is your lower body begins to slide and grind against her cock, unleashing a furor of excited wails from your plant lover.  She raises her body firm the ground to grasp at you, to hold you close in appreciation for "forgiving" her. (leads to V and D 1.6vp or V and D 1.6mvp, depending on player choice).

		[If you chose just the vine, V and D 1.6vp] You slip a hand to your

			(if female) player.breastDescript(0) and start to massage your hardening player.nippleDescriptAll().

			(if herm)) member and begin to (fondle your player.cockDescript(0)).

		Your choice to stimulate yourself rather than your partner's cock annoys the plant woman greatly, and you can see it in-between her expressions of pleasure.  You whisper into her ear, telling her that you're [i]so close[/i]. You savagely ram the vine against your cervix, causing the building pressure in your loins to intensify.  No longer able to contain yourself, you howl in ecstasy as the muscles in your vagina contract, signaling the flow of juices that surge through your cunt.

		(if PC has goo body and decided it's slime time: The plant woman joins in on the chorus of bliss and screams her orgasmic delight to the high heavens, injecting her sappy  jism into you.)

		PC has a cock(s)(Overcome by sensation, your player.multiCockDescriptLight() release their hot semen all over the plant woman, which the feminine creature quickly picks up with her fingers and stuffs into her craw, slurping it up hungrily as she does so.)

		Once your contractions pass (and you finish with (Both)  your "deposit(s)"), you pull the vine out of your vaginaDescript(0) and rise to your feet. You quickly don your (armor) and set off for camp, winking at the worn out, (masturbating/content) plant creature as you walk away.

		[If you chose vines, V and D 1.6mvp]:
		Not content with just one vine you reach out to the bush and grab two more creepers, bringing them to your ass and mouth.  The plant woman whimpers desperately as she brushes her penis against your thigh, pleading through her body language to tend to her aching member.  You stare into her eyes and smile as you insert one vine past your vaginaDescript(0) and assholeDescript(), while taking the third one in your mouth.  The plant woman lets out a frustrated, furious groan as she raises her clenched fists to her mouth. Your sly smile just adds to her "torment' as you go crazy on yourself with the vines.  Abandoning yourself to pure sexual instinct, you pump and fuck as hard as you can, causing the creature that lies underneath to writhe and grab at your wrists.  As the beauty of fauna braces herself against the torrent of pleasure she's receiving, you work the vine in your mouth as deep as possible and use the back of your throat to massage her penile appendage.  You continue your teasing and fucking of the overwhelmed plant girl until you feel the buildup of release approaching.  With a mighty grunt, you cum all over the vines and coat them in your juices, while your female "friend" cradles you close to her as she herself cums, wrapping around you with her arms and legs. Her penis and pussy both erupt like a volcano; her penis covering your (pelvis and stomach/ gooey body) in her sappy jism, and her pussy soaks the ground underneath the two of you.
		With a big sheepish grin, you fall against the feminine perversion of nature as you both pant, desperate to catch your breath.  You smile and peck her on the cheek as you fall into a deep sleep.

		Upon waking you notice that you are still lying on top of the plant woman, who is sleeping comfortably underneath you. You quietly pull yourself from her embrace and suit back up.  Your body aches as you struggle to head back to camp; it's a good ache, but it's going to hurt tomorrow morning.

		[Cock in the pussy, V and D 1.6c]

		As you stare down at the plant creature's cock, the urge to mount and ride her like a bull overtakes you, causing you to leap on her and knock her to the ground.  She lets out a surprised yelp as her plant-y rump makes contact with the earth beneath you and your partner.  Smirking, you

		(If PC's body is non goo: hover your pussy over her spear of love, rubbing your sex's lips across the tip of her shaft. )

		(If PC has goo body: quickly slide over the plant woman's prone body, absorbing her thighs and pelvis into your mass as you work her cock to your hungry snatch).

		Both of you moan as your sexes touch one another, sensation running through your vulva like wildfire. Twitching ever so slightly, the plant woman grabs you by your hipDescript() as she angles her cock to breach the mouth of your vaginaDescript(0).  Without wasting any more time you buck your hips downward, driving her member past your hungry lips and through the walls of your sex, flooding your body with endorphins and bringing on a sensation of giddiness.  Your partner squirms under you as her cock bottoms out inside of you, unable to control herself as her member takes the full blunt of your pussy. Grabbing her by the shoulders you begin to fuck the plant woman, bobbing your [butt] up and down against her lap; the melancholy of your intimate act ringing forth with the sounds of sloppy, wet sex. The nerves in your pussy light up as her member brushes back and forth inside of your fuck-hole, making you cry out occasionally as she “abuses” your cunt like it owes you money.  In response, you make the rough ride you're giving her faster and more savage.  Hands darting upward, the plant woman hungrily grabs your player.breastDescript(0),

		(if breasts: pulling on your player.nippleDescript(0) as she bucks her head back in utter bliss. You let out a pained cry and twist her nipples in response, soliciting a similar reaction from her. Both of	 you grin manically at each other, and you lower yourself to give her a quick kiss before rising back up into your straddling position, eager to abuse her cock until you get her sweet splooge inside of you)

		If flat and manly: massaging them sensually along with the rest of your chest. She moans even louder as she does this, getting off to caressing your (descriptor of muscle), male features.)

		She then...

		(if herm: slips her hand down to your player.multiCockDescriptLight(), taking (it/one at a time) into her hands, stroking (it/them) furiously as you pound her moist love canal.  You let up on the rough fucking for a brief moment as she tends to your dick(s), taking in the euphoria of her soft, leaf like texture on your naughty bit(s). )
		(otherwise) sits up quickly into a sitting position, embracing you tight as you continue to fuck her roughly. She moans intensely in your ear, licking your earlobe in-between gasps and panting.
		Eventually all good things must come to an end;  Your inevitable orgasm approaches, body trembling in anticipation at the thought of covering this creature in cum.  Sexual fluids rush out of you as you concentrate on pushing, forcing them out. Instinct takes hold as you mash your pelvis against the plant woman's lap. (Your player.multiCockDescriptLight()) explode(s),

			Cum multiplier [low]  shooting a few thin strands against the plant woman's chest
			Cum multiplier [medium] liberally covering the plant woman's breasts
			Cum multiplier [high]: drenching the plant woman's chest and face in semen, to the point 
		where she looks more like a goopy marshmallow than a woman of the earth.

		You drop down on her, spent. However, she still has some fuck in her;  grabbing you by the thighs she takes the lead and fucks your vaginaDescript(0), causing your (allBreastsDescript() to flop in the air wildly/ buttDescript's cheeks to bounce against her thighs).  Howling madly at this sensation overload you cum again, driving the plant woman to fuck your hole as hard as she can in-between her increasing shorter thrusts.  Finally, the floral woman screams in orgasmic delight, flooding your vaginaDescript(0) with her sappy semen.  With barely any energy to keep your eyes open, much less to pull yourself off of your sexually exhausted lover, you pass out on top of the plant woman. (Transition to V and D 1.6c ending)

		V and D 1.6c ending: As you wake from the land of dreams, you feel a hand moving through your hairDescript() .  Eyes fluttering open, you turn and look up; the plant woman returns your sleepy gaze with a caring smile. You smile back at her and stretch contently.  She grabs you by the side and helps you to your feet, leading you back to your clothes and helping you to armor back up.  She walks you to the path you first encountered her on and sees you off as you head back to camp.


		[Take them all! picks up here, V and D 1.6vc] (Tentacle dick scenes can also connect to Take them all!)

		One penile appendage is not enough for you; you want as many vines you can handle.  Reaching behind the plant woman and into the bush, you drag a limp creeper across her body and against your quivering assholeDescript(0).  Without a moment's hesitation, you force the head of the vine into your anus, wracking your pucker with delectable pleasure as you slide it deeper into you.  Thrashing wildly under you, the plant woman grunts savagely as her vine like appendage shoots sexual euphoria into her body.  The feeling of getting your buttDescript(0) and vaginaDescript(0) fucked is great, but you hunger for more! Snatching at the closest penile appendage you can find, you drag them in front of the plant woman's face and grin manically; a series of pathetic moans echo from her mouth as she grunts and groans in ecstasy. Letting go of the vine in your ass, you take the other two in each hand and bring them to your mouth and player.breastDescript().  Licking the vine at the entrance to your mouth and ramming the other vine in-between your allbreastDescript(), you begin the process of trying to fuck every orifice (and pair of breasts) on your body.  Having not enough hands to do so though frustrates you to no end, causing you to stare down at your prisoner and point to the vines that you are trying to use, raising your eyebrows suggestively as you do so.  The vines inside of you and in-between your breasts snap to attention and begin to pump you, making you incredibly wet (and hard) at the feeling of being filled with cock like appendages.


		Goddamn checks again, sorry Fen
		(If tentacle dick <36 inches, but long than 18 inches) Your erect, strechy cock juts forward, pushing in-between her flowery mounds.  The plant woman laughs and presses her breasts against your cock as it rocks back and forth between them.  Her pussy drools sweet, nectary lube as you fuck both her pussy and her breasts.
		(Leads to Goo check. If PC fails Goo check, then progress to Climax)

		(If tentacle dick >36 inches, but < 54 inches) Your lengthy cock shoots up into the plant woman's mouth, taking her completely by surprise.  Her eyes go wide at the sudden intruder in her mouth, but she quickly grabs the shaft and begins to lick the head, tongue twisting frantically like a tumbleweed caught in the wind.
		(Leads to Goo check. If PC fails Goo check, then progress to Climax)

		(If tentacle dick > 54 inches: Grinning like a mad fool, you command your cock to pull out of her mouth, leaving trails of pre-cum and drool on the plant woman's face.  Before she can react, your cock wraps itself around her neck and plunges back down her craw.  Careful to not suffocate the poor creature, you keep some slack on your obscenely long cock; you have a firm "grip," but it's nice and snug around her neck.  Eyes glazing over, her fierce moans are muffled by your member as it fights against her tongue. You chuckle, as the scene reminds you of two people having a thumb war.)
		(Leads to Goo check. If PC fails Goo check, then progress to Climax)

		(If PC has goo body: Even though you are wholly content with stuffing yourself with penile creepers, your thoughts wander to the Plant woman's asshole... just sitting there... all alone...  Maybe you can provide some "company" for it...

		[Goo Anal]   [Ignore, leads to climax]


		[Goo anal]
		With a soft giggle, you snap your attention to the gooey mass at the mouth of the plant woman's asshole, and pause briefly to focus.  Your lover stares up at you quizzically for but a brief moment, before her eyes go wide at the slimy intrusion at the opening of her tight pucker.  Lathering her insides up as you go, you direct your gooey body into her tight little asshole  and gradually solidify it into a sticky dildo of sorts. Weakly the creature groans, likely due to the fact that you are triple penetrating yourself with her penile vegetation while fucking both her cock and asshole.  Grinning devilishly, you start your gyrations once more.
		(Leads to Climax)

		[Climax]

		Overwhelmed by your brutal fucking of her bulbous cock (and/ ,) her penile appendages,  the plant woman loses all control and slumps against the ground in a orgasmic wreck, twitching and convulsing under your assault.  The vines inside of you go limp, and the creeper in-between your breasts falls lifeless to the ground.  Undeterred, you continue bucking against the plant creature and even take the vines in your ass and mouth into your hands, opting to drive her to orgasm yourself.  A mighty roar of blissful satisfaction erupts from the plant woman, before she goes limp.  The second she does, you feel a torrent of seminal fluids flooding every orifice in your body.  With a deeply satisfied and lustful moan, your eyes roll back and close as you take in the feeling of being filled with cum, almost like you are a pie being injected with steamy, cream filling.

		With a blissful smile on your face, you lower yourself down to the plant creature and nod off as the fluids shot into you finally begin to leak out.

		As you wake from the land of dreams, you feel a hand moving through your hairDescript().  Eyes fluttering open, you turn and look up; the plant woman returns your sleepy gaze with a caring smile.  You smile back at her and stretch contently.  Grabbing you by the side and helping you to your feet, the floral vixen leads you back to your clothes and helping you to armor back up. She walks you to the path you first encountered her on, and sees you off as you head back to camp.

		Victory or Dominant Let's Fuck: Perform cunnilingus on the plant woman

		 V 1.7 and D 1.7, respectively] 

		(Victory, V 1.7: Aroused from the fight and pent up lust, you disrobe in front of the defeated plant woman; she did, after all, want to have sex with you.  And now that you are in the mood, you feel like burying your face in that petal-like vulva between her leafy, well shaped thighs.  Turning to see what fate her victorious opponent has in store for, she shuffles backwards at the unexpected sight of your (multiCockDescriptLight()/vaginaDescript(0)/multiple sexes/ generless sex). (Scene leads to V and D 1.7)
		(Dominant "Let's fuck!", D 1.7: The display, while amateurish in nature, has driven you into a lustful frenzy;  Now that you are in the mood for loving, you feel like burying your face in that petal-like vulva between her leafy, well shaped thighs.  Drawing her in close, you sneak your hand down to her pussy and begins to caress it lightly; the soft, gradual touch resonates through her clitty causing her to gasp in delight.  Her already eager clit dampens your hand slightly as a thin trail of pussy juice edges its way out of her. (Scene leads to V and D 1.7)
		(Victory and Dominant scenes converge here, V and D 1.7): Catching the scent of her lubricating fluids on her delicate clitty, you breathe heavily, shoulders rising and falling in tandem with your respiration. (If dominant: Looking downward, the plant woman sights) Your player.multiCockDescriptLight() [and]/ (clitdescript()/
		If genderless: player.breastDescript() 
		offer(ing) an enticing sight to the creature as it/they too rise(s) and fall(s) with your breathing, in an almost hypnotic fashion to her.  Edging yourself to your knees, you slip a finger between her wet sex, taking it against your fingers and caressing her petal-like lips.  Her body rises like a cat being pet as her mouth betrays her pleasure at your attentive efforts, forming an "oh" expression as her eyes close, relishing the moment.  Her back arches as she leans against her outstretched arms; her leafy mounds rise upward as if to present themselves to you.  Shrugging in a joking manner, you take her anther-like left nipple in your mouth, pinning it against your lips as you slide your index and middle fingers against her labia.  Her breathing becomes deeper as her body enters a state of arousal, which in turn causes her nipple to harden in your mouth.  Rewarding her body, you take the head of her left breast in your mouth, allowing the nipple to pass your teeth and make contact with your tongue.  You take her left breast into your hand and suck it sensually, tracing your tongue against her mound and nipple as you periodically purse your lips on her teat, sucking at her milk mounds like an infant breastfeeding. 
		After your lust for foreplay is sated, you lower your head to her incredibly moist sex hole, eager to taste her on your lips and tongue.  With bated breath, she awaits your oral gyrations.  Starting at the bottom of her vulva, you lick upwards, allowing yourself to feel the contours and texture of this creature's pussy against your tongue.  A small amount of lady spunk leaks from her quivering button and hits your tongue.  Pausing to smack your lips together, you sample the taste of her in your mouth; the flavor of nectar washes over your taste buds and mixes with your saliva.  You press your lips against her vagina and prod the opening with your tongue, giggling at how fauna like her entire body seems to be.  In response, she wraps her thighs around your head, intent on encouraging you further into her clit.  Bracing yourself against her sizable rump with your hands you thrust forward, twisting and twirling your tongue inside of her as you explore the tight depths  of her sex.  As your mouth muscle brushes against her vagina you can feel her ribbed texture, giving you a perfect target to attack as you drive the plant woman to shudder at the feeling of you inside of her. 
		(if Long tongued: Utilizing your physically perverted tongue, you stretch out deep into the plant woman's pussy and slither around into there like a croc doing a death roll.  Forcefully grabbing your hair, the plant woman releases her pleasurable overload physically as she pulls on the roots, causing a bit of pain in the process.  Thankfully, she doesn't pull so hard that your hair gets ripped out.
		Occasionally you suckle at the lips of her pussy, taking one side at a time in your mouth and licking her clit as you manhandle her delicate features.  The thighs around your head tighten considerably, and the plant woman bucks against you as she lets out a deep moan.  Her whimpered cries of bliss resonate throughout your being, and in a instinct driven frenzy you bury your face against her pelvis, licking and lapping at her sweet pussy with ferocious tenacity.  Your lustful efforts cause the plant woman's head to arch back forcefully, orgasmic pants and moans escaping her mouth as you overwhelm her body.
		Without warning, her thighs squeeze up tight, putting considerable pressure against your (head/horns) and causing a almost headache-like pain. Her orgasmic fluids are a flash flood in the dry river basin that is your mouth, hitting against your tonsil like a tsunami. Without any thought or hesitation, you swallow her nectar-y pussy fluids. Squeezing your head in time with her orgasms she howls in great pleasure, timed perfectly with each spasm of her sex to surge forth as much of her as possible. Overwhelmed, you withdraw from her sex and get slapped in the face with a few thin streams of her humid juices. Sighing heavily, you pull yourself on top of the plant woman and plant a nectar-y kiss on her lips, of which she is almost too eager to return.
		Once you regain your composure, you suit back up and return to camp leaving the plant woman to sleep off her exhaustive efforts.

		Victory: Perform cunnilingus on the plant woman (corrupted), Vc 1.7


		Herm check
		What do you intend to have the plant woman service while eating her out?
		[Cock(s), transitions to Vc 1.7: cock when appropriate]    [Pussy, transitions to Vc 1.7: pussy
		 when appropriate ]

		Intro
		Aroused by your victory over this idiotic, naive creature, you confidently walk over to her still body and disrobe.  You try to ask if she's okay but you know full well she can't understand you; though, you only want her to think you are genuinely concerned about her health.  With puppy dog eyes, the creature looks up at you and takes notice of your buck nakedness.  Her expression of worry turns to intrigue, and she grins as she beckons you forward.  Eager and willing, you lower your 
		(if vagina and/or cock: (vaginaDescript(0)/   /and/ player.multiCockDescriptLight()/ 
		(if genderless: buttDescript( )) to her face as you grab her by the legs. 
		Pulling up violently, you take the plant girl completely by surprise, causing her to gasp as the ground beneath her shifts and her eyes make contact with your 
		(vaginaDescript(0)/ player.multiCockDescriptLight()/ assholeDescript(0) ). 
		Settling on top of her in a crouching position, you bend her backward by pulling her legs toward you, bringing her moist and inviting sex closer and closer to your face.  Her back arches and you can hear the crackling of leafs; no doubt from her body as you contort it to your liking.  With her finally in place you place your 
		(multiCockDescriptLight()/ vaginaDescript(0)/assholeDescript( ) ) 
		against her face, slathering (it/them) down her forehead and past her nose as 
		PC has cock(s): (gravity takes your player.multiCockDescriptLight() and prods (it/them) against her lips) 
		PC has a vagina or is genderless: (your pussy/ass cheeks come to rest against her lips). 
		A noise escapes from underneath you and the creature shudders.  Gazing at her sex, you can tell that she is ready and eager to receive your intimate attention.  Grinding your own sex(es) against her face, you encourage her to continue.
		As you lower yourself to your knees hot, humid wetness... (jumping point for cock size checks)
		Transition check
		(links to Vc 1.7 cock, Vc 1.7 pussy, Vc 1.7 herm, and Vc 1.7g scenes) 


		Vc 1.7: cock: (If PC can use two cocks, use two cocks. If PC can't, just use one)
		(If one-two cocks are present and less than 24 inches (each): encompasses your (cock/cocks) as she takes the head of your prick(s) into her mouth, aggressively pressing her lips and tongue back as she dives her head down your shaft(s).  The sensation of her rough treatment forces a uncontrolled moan of pleasure and minor pain from you as she busily slurps and sucks at your cock(s).  Snapping yourself out of bliss and back to the task at hand, you take her rose-like pussy lips against your own, dragging the top of your tongue against the bottom of her labia and slowly rising to her vaginal hood.  The plant woman lets slip a distorted, muffled moan as you thrust against her.  Not content to licking her "special stamp," you open your jaw up slightly to allow your tongue the maximum leverage to assault her love canal.  Jutting forward like a snake in a sugar cane field, you rush past her clit and inside of her, attacking her nether regions with tumultuous tenacity.  In-between slurps, she sequels in delight as you tongue-fuck her nectar-tasting pussy.  You groan in barely contained passion as (she overwhelms your cock(s) with her enthusiastic efforts/ the breeze against your humongous cock(s) pushes you over the edge) and soon you feel your pent up lust getting ready to release. (leads up to Vc 1.7 cock end)
		(if cock(s) is > 24 (each), but less than 36 inches (each): encompasses (your cock/two of your cocks) as she takes the head of your prick(s) into her mouth, aggressively pressing her lips and tongue back as she dives her head down your shaft(s).  The sensation of her rough treatment forces a uncontrolled moan of pleasure and minor pain from you as she busily slurps and sucks at your cock(s).  Snapping yourself out of bliss and back to the task at hand, you attempt to bring yourself to her sweet smelling cunt, drawing closer and closer. However, like a dog held back on a leash, you cannot proceed any further.  Considering your options, you
			 (if dick is 25 to 44 inches: drop the rest of your multcockDescriptLight() against her 
		chest like a soft, stiff (set of) hammer(s).  She giggles at the "violent" assault of her chest and waits to see what you will do next.  Placing your (cock/cocks) in-between her breasts, you thrust towards her stomach, intent on using it to bring yourself pleasure, and eventually orgasm.  With enough room now, you lower your face to her soft pussy and drag your tongue along the edge of her clit (leads up to Vc 1.7 cock end).
			(If dick is greater than 44 inches, but not 60 inches: You slam your cock(s) against her 
		right hand. With a surprised giggle, she takes your (cock/one of your cocks) in her hand and begins to stroke you with unbridled speed and effort.  Now that that problem is out of the way, you dive your face into her lap and burrow your tongue deep into her, sliding around like an eel in a shallow, narrow stream. (leads up to Vc 1.7 cock end)
			(If dick is greater than 60 inches: take the plant woman's legs and position them against 
		your head, propping your obscenely long dick(s) against her thighs and using them like a tie around a bundle of flowers. You struggle to work your dick(s) out of the way so you can get to her honey pot, and after some frustrated grunting and swearing, you finally work your face close enough to her pussy. With your cock towering over her like a shoddily constructed and slanted tree fort, you take the plunge and dive your face into her lap, assaulting her honey pot with ferocity born out of frustration and aggression. (leads up to Vc 1.7 cock end)
		(All dick scenes converge on Vc 1.7 cock end)


		(Vc 1.7 cock end ): Overtaken with orgasmic need and desire, you thrust like a mad man against...
		COCK size check (IF all other dicks are more than 120 inches, then IGNORE this dick check section)  (If two cock variables are met, then use (and); if three are met, use (, A dick, B dick, and C dick)
		PC has just one-two appropriately sized dicks: her mouth
		PC has other dick(s) 36 to 44 inches: her stomach (and/  , )
		PC has other dick(s) 45 to 60 inches: her hand (and/  , )
		PC has other dicks greater than 60 inches: her pelvis) (and/  , )
		PC has other dicks greater than 120 inches: Ignore said dicks. IF all other dicks are more than 120 inches, then IGNORE this dick check section
		 as you lap her pussy like a puppy at a water bowl.  Her legs twitch as your member(s) (does/do) and you know that her own orgasm is arriving.  Letting out a furious, stifled groan you empty your (testicles/ cock(s) (down the plant woman's throat, soliciting her tongue to massage your prick(s) to eject more of your seed into her/against her stomach, drenching her torso and pelvis in cum/ in her hand; 
		(if small enough for blowjob (less than 25 inches): Her efforts take a sporadic twist as her tongue misses your dick(s) completely and receives a (thin/generous/ thick) coating of cum along her esophagus). 
		(transition to dick size medium check: Your equine length cock(s) also flow with your seed,)
		(dick size medium (25 to 44 inches): firing
		Cum production low: a weak amount of semen along her floral body.
		Cum production moderate: a significant amount of cum along her body and lathering her up nicely in your jism.
		Cum production high: so much cum on her body that you are worried she might actually get stuck to the ground under the volume of your release.) 
		(Transition to dick size large check: Like a ruptured beaver dam, your towering prick(s) 
		(Dick size large: erupt into the air, (thin amounts of/ generous amounts of/ ridiculous amounts of) semen gushing upwards like a smoke signal.  Gravity soon takes its toll, and cum rains down on both of you). 
		The plant woman cries out in savage orgasm as her fluids geyser out of her sex with significant force. They hit you in the face, and a wicked idea crosses your mind.  Raising your knee against her stomach, you press down and apply pressure.  The plant woman gags as the wind is squeezed out of her. “Bitches don't cum harder than me, got it?!” you yell at the helpless plant woman.  Awaiting a response or sign of acknowledgement, you gaze down at her drooling box; several more streams of pussy juice gush out of her, likely in response to your rough treatment.  You sigh as you pop your cock(s) out of her mouth, leaving trails of saliva and semen between the two as you proceed to gear back up.  “Guess I'm just too good,” you mutter to yourself as you head back to camp, leaving the wheezing and exhausted plant woman to recuperate. (end scene for Vc 1.7: cock)

		 (if vagina only, Vc 1.7 pussy: 
		slides against your moist fuck-hole as she flicks her tongue against your clitty, slapping your vaginaDescript(0) lips around like a red headed step child.  You shake in tandem with her loving assault on your pussy and lower your face to her own glazed over sex.  Bruising your lower lips against hers, you drag your face upwards against her pussy, allowing the texture and shape of her labia to slide down the tip of your lip and to your chin.  Your breathing increases and hormones flood your body with sensual euphoria, having gotten a taste of her eager button on your moistened lips. Almost as if you two were aware of the other's desires, you both simultaneously prod each other's holes and then press forward in each other's depths.  You groan as you feel her nectar-y soft tongue dart against the sides of your clit, flailing around inside of you like an unsecured tarp in the wind.  The sensation is too much and you sink to your knees, unable to keep yourself in a crouched position any longer.  The sudden descent slaps your pussy against the plant woman's face, drawing out labored breathing from as you close off her mouth with your drooling sex.  You don't care much for her ability to breathe comfortably, but she doesn't seem to be having any problems at all as she grabs your [butt] and draws you closers to her craw.
		You figure at this point that she's enjoying this a little TOO much; she isn't learning much of a lesson about not forcing herself on you.  Sneering, you retract your tongue from her hole and clamp down on her pussy lips with your teeth, soliciting a surprised cry of pleasure and pain.  Careful to not maul or injure her, you apply just enough  pressure with your teeth to get her attention.
		 (If Naga:  To add to the domination of this creature, you decide to take her neck in your coils.  Arching her head slightly, you twist and turn your tail until you can work  the end of your reptilian tail around her esophagus.  Ensuring she has enough to room to breathe, and that you are going to inflict the "right" amount of tension and pain, you tighten up around her, generating a worried gasp followed by a submissive moan as your partner shakes in delight.) 
		Sliding her lips in-between the bumps and shape of your flat teeth, you "torment" the plant beauty beneath you, leading to a series of moans that are a mix of intense pleasure and minor anguish.  Smiling as you do so, you alternate between flicking your tongue against her fuck-hole in a manner similar to a spinner caught in a windstorm, and gently tugging and caressing her pussy lips with your teeth and tongue. (leads to Vc 1.7 pussy end)
		Vc 1.7 pussy end: Soon, you feel her muscles tensing up and figure that her orgasm will soon be arriving.  Not content to having her orgasm first, you treat her face like two pieces of kindling as you buck against her face, sliding your sex against her in an effort to "ignite" your own sexual release.  Gritting your teeth as you do so, your pussy tingles and becomes overwhelmed with the sensation of brushing your player.clitDescript() against the fauna-like texture of her face.  Pulling back on the plant girl's legs you bate your breath, orgasm flooding through your diaphragm and eager to escape from your mouth. With stifled, passionate moans, you (douse/PC is a squirt-er: spray) your fluids all over the plant creature's face, and she quickly reciprocates with her own barrage of pussy juice against your own face.  Hungrily, you lap and slurp it all up like a person dying of thirst. 
		You hold the contorted position you two are in for several minutes until you regain your strength. Apathetically flopping the fatigued woman to the ground, you proceed to grab your (armor) and head back to camp, pausing only to comment on how you look forward to the next time you get to "punish" the fauna beauty.
		(if genderless. Vc 1.7g: prods the crack of your ass as she parts your [butt], and licks your assholeDescript() with her energetic tongue; oddly enough, it resembles the texture of flower petals, and having that sensation against your hole causes you to quiver.)  Her moist tongue slaps against your hole, leaving it nice and wet as she prods and lathers your hole with her tongue. )
		Scene needs to be expanded, not good at writing anal licking scenes
		*/
	}

}