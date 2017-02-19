package classes.Scenes.Places.Prison 
{
	import classes.*;
	import classes.GlobalFlags.*;
	import classes.Items.Useable;
	
	public class TrainingFeeding extends BaseContent
	{
		
		public function TrainingFeeding() { }
		
		public function prisonCaptorFeedingOrgasmTrainingAccept(branchChoice:String = "choose"):void
		{
			clearOutput();
			var resistanceCounter:int = 0;
			var totalResistance:int = 0;
			var saidNo:int = 0;
			var lustChange:int = 0;
			var sceneVariation:int = 0;
			var begVariation:int = 0;
			resistanceCounter = prison.prisonCaptor.prisonCaptorScratch(1);
			totalResistance = prison.prisonCaptor.prisonCaptorScratch(2);
			saidNo = prison.prisonCaptor.prisonCaptorScratch(3);
			if (branchChoice == "choose")
			{
				outputText("Your head begins to bob more vigorously along Mistress Elly's shaft, your tongue timidly collecting the salty rivulets that wreathe her length, and you acknowledge that your body seems to have made the decision for you. You need to come, ");
				if (player.esteem < 40)
				{
					outputText("and if you can please your Mistress by giving her control of your orgasm's timing, well, you ought to just do so. ");
				}
				else if (player.esteem < 60)
				{
					outputText("and if it will make her happy to dictate exactly when your orgasm comes, well, it's probably best not to deny her.");
				}
				else
				{
					outputText("and if coming on command will keep her happy, it would probably be smart to do so.");
				}
				
				outputText(" So resolved, your hand [if (esteem < 40) meekly][if (esteem >= 40) slowly] ");
				if (player.hasCock())
				{
					outputText("wraps itself around your rock hard cock and gives a tentative squeeze up and over your [cockHead biggest]");
				}
				else if (player.hasVagina())
				{
					outputText("reaches between your legs, fingers spreading your already glistening lips and tentatively sliding upward to softly stroke your rock hard [clit]");
				}
				else
				{
					outputText("reaches between your legs, tentatively caressing your sensitive mound then sliding backward to dip a finger into the rim of your [asshole]");
				}
				
				outputText(" -- but despite your light touch, the resulting wave of pleasure surges through your body with surprising force. Your toes twitch, your eyes flutter, and a wavering high pitched moan issues past the knob lodged in your throat and out through your lips as your jaw goes slack around her.\n\n");
				if (player.esteem < 40)
				{
					outputText("You are shocked and mortified by the sound, but even more so by the realization that sucking her cock and being painted with her cum is all that was needed to put you in this state. It's just one more piece of evidence that your Mistress probably does know your nature better than you do, and your heart sinks as you process it. Your hand, meanwhile, is not at all discouraged by this development -- its motion quickly accelerates from timid to feverish, desperately working to build you a refuge from your shame.");
				}
				else if (player.esteem < 60)
				{
					outputText("As disturbing as the sound is, you are more troubled by the puzzle of how you became excited enough to make it with so little provocation. It would be a lie if you tried to deny the illicit thrill of servicing your Mistress, but this reaction is far beyond what you are comfortable accepting. This does nothing to dissuade your hand, though, whose pace hastens with each passing moment, perhaps with the intent of distracting you from your inner turmoil.");
				}
				else
				{
					outputText("The sound triggers an alarm in your brain, and when a second flick of your wrist elicits an encore performance you scramble desperately to regain control. Your body's excessive response to your modest stimulation throws your makeshift game plan into disarray before you've even really started to execute, so you try to redirect your attention towards managing the movement of your tongue against her hardness instead. Lapping at her enticing cinnamon savory sweetness for some reason only adds to your confusion, providing an opportunity for your hand's pace to quicken without your consent. \n\n");
					outputText("Your head begins to spin, and a voice screams from the dark recesses of your mind that you are overthinking the situation; your only real option here is to let go, to stop fighting your body's unbecoming but natural response.");
				}
				
				outputText(" However, even as your loins fill with an all consuming blaze, you find yourself unable to surrender to it. Instead it intensifies the chaos within you, leaving you scattered and unable to properly focus on pleasuring either yourself or your Mistress, and as panic sets in you find yourself frantically pumping at her cock and your ");
				if (player.hasCock())
				{
					outputText("own");
				}
				else if (player.hasVagina())
				{
					outputText("button");
				}
				else
				{
					outputText("mound");
				}
				
				outputText(" in a vain and misguided attempt to bring the encounter to an end.\n\n");
				outputText("\"<i>Stop.</i>\"\n\n");
				outputText("So stern and forceful is the command that you freeze mid-stroke, sitting absolutely still for full second before your frenzied energy catches up to you. Your head swims, your vision blurs, your hand begins to shake and ");
				if (player.hasCock())
				{
					outputText("clench nervously around your [cock biggest]");
				}
				else if (player.hasVagina())
				{
					outputText("twitch nervously between the lips of your [cunt]");
				}
				else
				{
					outputText("twitch nervously between your thighs");
				}
				
				outputText(", and you are intensely aware of her cock dribbling salty lubricant over the base of your tongue. Completely at a loss as to how to recover yourself, you turn your misty eyes upward searching for direction.\n\n");
				outputText("\"<i>You've completely missed the point of this lesson, [if (esteem < 40) dear][if (esteem >= 40) slave].</i>\" Although her voice still unwaveringly authoritative, there is compassion in her eyes as she captures your gaze, and it filters into her words as she continues to speak. \"<i>I have no desire to watch you bludgeon yourself for me. Your body is dying to reward you for letting it revel in its true nature, and it's plain to see that this scares you.</i>\" She pulls her cock from your mouth, upsetting your precarious balance, but she quickly kneels down and catches you. Her firm grasp on your shoulders first steadies you, then begins to massage away your tension. \"<i>But it's time for you to confront that fear. It's time to move past it. I see how ready you are. I feel it.</i>\" She leans forward, almost embracing you as her hands work their way down your spine, melting the stress from your muscles in their wake, and you can feel her warm breath on your cheek as her now soft whispers drift into your ears.\n\n");
				outputText("\"<i>You know I'm right.</i>\" [if (esteem < 40) Is she?][if (esteem >= 40) She can't be...]\n\n");
				outputText("\"<i>You know you're ready.</i>\" [if (esteem < 40) Maybe you are...][if (esteem >= 40) She's wrong. You're not... are you?]\n\n");
				outputText("\"<i>The question is, are you ready to show me?</i>\"\n\n");
				outputText("\n\n");
				prison.prisonCaptor.prisonCaptorScratchSet(1,0);
				prison.prisonCaptor.prisonCaptorScratchSet(2,0);
				prison.prisonCaptor.prisonCaptorScratchSet(3,0);
				menu();
				addButton(0,"Yes, Mistress",prisonCaptorFeedingOrgasmTrainingAccept,1);
				addButton(1,"No, Mistress",prisonCaptorFeedingOrgasmTrainingAccept,2);
				return;
			}
			if (branchChoice == "1" || branchChoice == "2")
			{
				outputText("",true);
				if (branchChoice == "1")
				{
					outputText("\"<i>Yes, Mistress,</i>\" ");
					if (player.esteem < 40)
					{
						outputText("you squeak, admitting the truth to yourself as much as to her. At least at this moment in time, you <i>are</i> ready to give up the fight for your dignity and wallow in the lascivious pleasure of being her devoted servant. Only, you aren't sure how to do so.");
					}
					else if (player.esteem < 60)
					{
						outputText("your say breathily, entirely uncertain if you are simply saying the words to placate her or if you are actually the speaking the truth. Maybe you <i>are</i> ready to stop fighting and embrace the pleasures of servitude. Either way, though, you have no idea how to so in this moment.");
					}
					else
					{
						outputText("you say with a shaky facsimile of confidence. You honestly aren't sure what the real answer to her question is -- although it makes you uncomfortable to realize that it isn't a flat out 'No' -- but whether or not you actually are ready to accept her perception of you as the truth, right now you need to come and being polite offers the best chance of that happening. Still, even having claimed you are ready, you are unsure of how to proceed.");
					}
					
					outputText("\n\n");
					outputText("\"<i>Oh, you're so brave, dear. I understand how hard this is, though, so let me help you.</i>\"");
				}
				else
				{
					prison.prisonCaptor.prisonCaptorScratchChange(1,1);
					prison.prisonCaptor.prisonCaptorScratchChange(2,1);
					prison.prisonCaptor.prisonCaptorScratchSet(3,1);
					saidNo = 1;
					outputText("\"<i>No, Mistress,</i>\" ");
					if (player.esteem < 40)
					{
						outputText("you squeak, bravely trying to convince yourself it's the truth. However, at least at this moment in time, you really <i>are</i> ready to give up the fight for your dignity and wallow in the lascivious pleasure of being her devoted servant. But you are going to pretend that's not the case at least this one more time.");
					}
					else if (player.esteem < 60)
					{
						outputText("your say breathily, entirely uncertain if you are simply saying the words to spite her or if you are actually the speaking the truth. Maybe you <i>are</i> ready to stop fighting and embrace the pleasures of servitude. Either way, though, you aren't ready to admit it at this moment.");
					}
					else
					{
						outputText("you say with a shaky facsimile of confidence. You honestly aren't sure what the real answer to her question is -- although it makes you uncomfortable to realize that it isn't unequivocally 'No' -- but whether or not you actually are ready to accept her perception of you as the truth, right now it seems more important to insist on a small bit of dignity than to genuinely analyze how you feel.");
					}
					
					outputText("\n\n");
					outputText("\"<i>Oh, you poor dear. I know you'll find the courage to show me how you feel very soon, but for today, don't worry -- I'll help you.</i>\"");
				}
				outputText(" Her words are delivered with tender sincerity, and she puts enough space between you that you are once again staring at her kindly, encouraging expression as she speaks. Her hands continue to work their magic, though, sewing unexpected relaxation throughout your previously tense body. Before long they find their way back up to your neck, then cup your cheeks affectionately, thumbs working her cum into your skin as though it was a fine lotion. You are simultaneously scandalized and titillated, which does not go unnoticed, her solicitous smile filling with gleeful exuberance. \"<i>See? You're getting there, [if (esteem < 40) dear][if (esteem >= 40) slave], but I think this will be easier for you with a bit less distraction.</i>\"\n\n");
				outputText("Her hands fall from your cheeks and then reappear holding a broad, thick strip of black velvet before your eyes. An instant later the cloth is fastened about your head, and your already loopy senses are plunged into soft, disorienting darkness. Her fingers give you one last alluring caress as they depart, and she melts away into a disembodied voice.\n\n");
				outputText("\"<i>Now, slave, take a moment to breathe deeply and listen to your body.</i>\" Almost without thought you do as she says, inhaling and exhaling, drifting loosely through the blackness, willing the slow rhythm of your lungs to calm the sound of your racing heart pounding in your ears. \"<i>Very good. Now stand up and begin again.</i>\" Simple as the directive is, it seems an incongruous and onerous order to give just as you are growing relaxed and comfortable in your lust. Still, you can think of no reasonable objection to raise, so you clumsily feel your way to your knees, then carefully find your feet. Your calves tingle as the blood rushes in, making you wobble about, your arms waving haphazardly in the cool air around you in an attempt to maintain your balance. Even more disoriented than before, you abruptly feel incredibly exposed as a light breeze through the window raises goosebumps across your torso, and you realize that you've completely lost track of Mistress Elly.\n\n");
				outputText("You feel the sensation of a warm breath ");
				if (player.hasCock())
				{
					outputText("against the [sheath] of your painfully erect [cock biggest]");
					if (player.hasVagina())
					{
						outputText(" and across the quivering lips of your [cunt]");
					}
				}
				else if (player.hasVagina())
				{
					outputText("pass through the quivering lips of your [cunt]");
				}
				else
				{
					outputText("blow over your sensitive mound and between your quivering thighs");
				}
				
				outputText(", stoking your fire and making you think for a moment that she must still be squatting on the floor in front of you. Then a rustling in a corner of your cell makes you wonder your desire has run away with your imagination, but either way you heed the reminder of the humiliating thing your Mistress has asked you to do. Having finally stabilized yourself, you pull your arms back inwards, timidly crossing your hands on your [chest], then slowly forcing them to descend over your prickly flesh, ");
				if (player.pregnancyType > 0 && player.pregnancyIncubation > 0 && player.pregnancyIncubation <= 280)
				{
					outputText("relishing the curves of your distended belly");
				}
				else
				{
					outputText("sweeping haltingly over the lines of your pelvis");
				}
				outputText(" before falling shyly between your legs to once again caress ");
				if (player.hasCock())
				{
					outputText("your engorged cock");
					if (player.hasVagina())
					{
						outputText(" and aching cunt");
					}
				}
				else if (player.hasVagina())
				{
					outputText("your aching cunt");
				}
				else
				{
					outputText("the soft, sensitive places within");
				}
				
				outputText(". As before, regardless of how gently you stroke yourself, the satisfaction of each touch is overwhelming, and as you stand in chilly, velvety shadow you find the blinding warmth nearly irresistible. Overcoming your growing sense of vulnerability, you proceed, hands pushing back the gloom. Before long, you start to feel all other concerns start to slip away, and your Mistress once again reveals herself to you.\n\n");
				outputText("\"<i>That's a good [boy],</i>\" she says from somewhere behind you, her tone still caring and affectionate, but with a hint of predatory glee lurking around the edges. Her soft, silky fingers press lightly into the small of your back as her voice swims around you, and your heart quickens. \"<i>Doesn't it just feel...</i>\" A fingertip trails goosebumps lightly up and down your spine, and your hand races to catch up with your heart. \"<i>Heavenly?</i>\" A nibble at the nape of your neck sets off fireworks before your eyes, and draws a long, lewd, breathy sigh through your lips. \"<i>Yes, slave, moan for your Mistress.</i>\" Suddenly mortified all over again, you try to resist the urge to do so, but her tongue tickles the back of your ear and your now shallow, hasty breaths begin to produce small but audible gasps in time with the needy movement of your ");
				if (player.hasCock())
				{
					outputText("hand");
				}
				else
				{
					outputText("fingers");
				}
				outputText(".\n\n");
				outputText("\"<i>Huhn... Huhn...</i>\" For a moment you imagine that you could not feel any more humiliated, but then the fingers of her other hand brush delicately across your ass and your hips swing back to meet them.\n\n");
				outputText("\"<i>Huhnn... Huhnn...</i>\" You don't care. It feels too good.\n\n");
				outputText("\"<i>Louder, slave.</i>\"\n\n");
				outputText("\"<i>Haahh... Haahh...</i>\" Your compliance is reinforced by her soft hands squeezing more firmly at your [ass], then traveling in small, soothing circles upwards and around your waist.\n\n");
				outputText("\"<i>Slower, slave.</i>\"\n\n");
				outputText("\"<i>Haahhhnn... Haahhhnn...</i>\" Her hands cross each other, pulling you backwards into her embrace. Her arms wrap around you, your shoulders collapse into her bosom, and your back presses against the firm but silken skin of her stomach. At some point while you are lost in your exquisite haze she must have removed her corset and sleeves, because every inch of your body seems to be enveloped in her tender yet commanding warmth.\n\n");
				outputText("\"<i>Deeper, slave.</i>\"\n\n");
				outputText("\"<i>Haauuhh! Huu... haauuhh!</i>\" [if (biggestTitSize > 1) She kneads at your [fullChest] with domineering purpose\" else \"She traces her fingers enticingly across your chest] then gives your [nipples] a savage pinch, twisting and pulling[if (milkQuantity > 10)  until they begin to leak]. The resulting onslaught of pleasure and pain makes you squirm against her, crushing your ass cheeks around the pillar of manhood that rests between you.\n\n");
				outputText("\"<i>Good [boy]. Keep going.</i>\"  One of her hands stays at your nipples to orchestrate the gyration of your body against her own, but the other lithely descends to caress and guide your fingers ");
				if (player.hasCock())
				{
					outputText("as they slide vigorously over your [cock biggest]");
					if (player.hasVagina())
					{
						outputText(" and dip between the lips of your [cunt]");
					}
				}
				else if (player.hasVagina())
				{
					outputText("dip between the lips of your [cunt] and flutter across your [clit]");
				}
				else
				{
					outputText("rub vigorously at your sensitive mound and tease at your [asshole]");
				}
				
				outputText(".\n\n");
				outputText("\"<i>Huu... haaaauuuh!</i>\" You feel yourself teetering on the edge of climax, but even if you wanted to disobey and come, her hand's supervision prevents it. She giggles playfully in your ear at your increasing distress, and allows it to continue for what feels like an eternity.\n\n");
				if (branchChoice == "1")
				{
					outputText("\"<i>Okay, slave, you've clearly overcome your fear now. Whenever you are ready for your orgasm, you may fall to your knees and ask for it.</i>\"\n\n");
				}
				else
				{
					outputText("\"<i>Well, slave, it seems like you're well on your way to conquering that fear. So, are you ready to show me now? You only need to fall to your knees and ask for permission, and I'll allow it.</i>\"\n\n");
				}
				menu();
				if (saidNo == 1)
				{
					addButton(0,"Resist",prisonCaptorFeedingOrgasmTrainingAccept,3);
				}
				else
				{
					addButton(0,"Endure",prisonCaptorFeedingOrgasmTrainingAccept,3);
				}
				addButton(1,"Collapse",prisonCaptorFeedingOrgasmTrainingAccept,4);
				return;
			}
			if (branchChoice == "3")
			{
				sceneVariation = resistanceCounter - saidNo;
				prison.prisonCaptor.prisonCaptorScratchChange(1,1);
				resistanceCounter++;
				prison.prisonCaptor.prisonCaptorScratchChange(2,1);
				totalResistance++;
				outputText("",true);
				prison.changeEsteem(1,prison.inPrison);
				if (saidNo == 1)
				{
					prison.changeWill(-prison.prisonWillCost(3));
					if (player.esteem < 40)
					{
						outputText("You know she's right about you, at least at the moment, and you desperately need to come. However, you still aren't quite ready to admit it to her");
					}
					else if (player.esteem < 60)
					{
						outputText("The only thing you know for certain is that you need to come, and soon. However, whether or not she is right about you, you still aren't quite ready to beg her for release.");
					}
					else
					{
						outputText("It's painfully obvious that she has you beat -- regardless of whether or not you believe her opinion of you, you will be begging her for your orgasm before long. In the meantime, though, you intend salvage some piece of your dignity by resisting as long as you can.");
					}
					
				}
				else if (player.esteem < 40)
				{
					outputText("Every fiber of your body is ready to explode, but something inside you needs to impress her, and so you fight with all your being to remain standing just a bit longer.");
				}
				else if (player.esteem < 60)
				{
					outputText("Soon your body will give you no choice but to collapse, but for now you get the impression that she will be more impressed if you manage to keep standing even a little bit longer.");
				}
				else
				{
					outputText("You are close to losing control to your body's urges, but for now you sense an opportunity to curry favor by demonstrating your endurance a little while longer.");
				}
				
				
				switch(sceneVariation)
				{
					case 0:
						outputText(" Your resolution is promptly rewarded with a sharp tug at your [nipple],[if (milkQuantity > 50)  making you squirt prodigiously and] chasing the last semblance of modesty from your breathy moans.\n\n");
						outputText("\"<i>Aaaaahhh...  Aaaahhaahaa!</i>\" you hear yourself scream in the artificial darkness, and feel your hips writhe with delight, grinding wantonly against her hardness. Her embrace constricts around you, and she exhales a satisfied growl in your ear.\n\n");
						outputText("\"<i>Very well, slave. Up on your toes, then.</i>\" Despite your body being near to revolt, somehow you comply. Calves trembling, you fight through crippling waves of pleasure to rise up, drawing you far enough away from her pelvis that her cock begins to slide down your ass crack. It leaves a tantalizing trail of warm, sticky lubricant in its wake, and triggers a[if (corruption < 20)  disturbing][if (corruption >= 20)  surprising] anticipatory shiver as it slips past your [asshole] and drops between your legs. \"<i>And back down again.</i>\" You give a whimpering sigh of relief and drop back against her, now resting astride her monstrous shaft.\n\n");
						outputText("You are not allowed even the slightest moment of respite, though, as she promptly returns to conducting your chorus of moans and quivering dance of self gratification. Every twist and shake of your body wedges her rod more firmly between your thighs, and soon ");
						if (player.hasVagina())
						{
							outputText("you feel the lips of your pussy spread around the barrel of her fleshy pole, and the need within you instantly amplifies tenfold. Your hips begin to buck and gyrate uncontrollably, smearing your juices along her length in a primal attempt to entice the bestial thing to skewer you. Mistress Elly's only reply is to continue [if (milkQuantity > 50) milking\" else \"manhandling] your [chest] with renewed authority, chuckling mischievously and nibbling at your earlobe as your lust intensifies.");
						}
						else
						{
							outputText("the fleshy, lubricated pole is flush with your taint. \"<i>Squeeze, slave,</i>\" she whispers seductively in your ear, and without thought you obey, making every gyration of your hips an even more pleasurable expression of submission to your Mistress. \"<i>Good [boy],</i>\" she coos, reinforcing your behavior by [if (milkQuantity > 50) milking\" else \"manhandling] your [chest] with renewed intensity.");
						}
						outputText(" Meanwhile, her other hand guides yours ");
						if (player.hasCock())
						{
							if (player.longestCockLength() < 7)
							{
								outputText("out to where her own tip bobs in front of");
							}
							else
							{
								outputText("down to where her own tip bobs below");
							}
							outputText(" [eachCock] to gather her copious drippings, then back to rub them into ");
							if (player.totalCocks() == 1)
							{
								outputText("your");
							}
							else
							{
								outputText("your bundle of");
							}
							outputText(" cockflesh like a fine lotion.\n\n");
						}
						else
						{
							outputText("out to where her tip bobs in front of your crotch, making you squeeze at it as though it were attached to your own body, gathering her copious drippings in the process. She then returns your fingers to their business between your legs, where they proceed to rub her juices into your sensitive flesh like a fine lotion. \n\n");
						}
						break;
					default:
						outputText(" Your resolution is once again rewarded with a renewed assault on your brutalized [nipples],[if (milkQuantity > 50)  summoning more of your milky excretions to dribble down your [fullChest] and] amplifying your already loud and desperate moans.\n\n");
						outputText("\"<i>Oooohhhh...  ooAHH! Ooooohhh...</i>\" you scream with abandon, as she continues to hold you tight against her impossibly smooth body, masterfully directing your self flagellation and debauched undulation astride her forearm sized pillar of manhood. ");
						if (player.hasVagina())
						{
							outputText("Like a ravenous beast, the lips of your [cunt] squeeze tightly around the barrel of her shaft, making wet slurping noises as they slither along her length -- every sloppy stroke encouraged by irresistibly seductive whispers licking at your ears.");
						}
						else
						{
							outputText("Waves of electricity course through your body causing your thigh muscles to loosen and constrict rhythmically in time with the bucking of your hips. In tandem with the ever increasing slimy wetness within, the pit of your crotch becomes more effective in its role as a makeshift pussy with each passing moment -- a fact that is being well acknowledged in the stream of provocative whispers that fill your ears.");
						}
						outputText(" Your hands in the meantime are kept busy ");
						if (player.hasCock())
						{
							outputText("travelling between her knob and [eachCock], fitfully rubbing them together, coating your flesh with layer after layer of her sticky seed.\n\n");
						}
						else
						{
							outputText("paying homage to the knob of the powerful rod jutting out before you, and adding the viscous fluid that they collect there to the sticky mess between you legs.\n\n");
						}
				}
				outputText("Mistress Elly permits you to wallow atop her cock in this way for a bit longer before interrupting again. ");
				switch(sceneVariation)
				{
					case 0:
					case 2:
						if (saidNo == 1)
						{
							outputText("\"<i>Remember, slave, when you've reached the point where you need your orgasm you have my permission to fall to your knees and ask for it.</i>\"\n\n");
						}
						else
						{
							outputText("\"<i>Your fear is melting away, slave. As soon as you are ready to show me you've conquered it, you only need to fall to your knees and ask for permission, and I'll allow it.</i>\"\n\n");
						}
						break;
					case 1:
						outputText("\"<i>I know, slave, you want my dick inside your [vagOrAss] so badly you can taste it. If you behave yourself, you'll get it soon enough. For today, though, your hand is all you're entitled to. Are you ready yet? Just fall to your knees when you are.</i>\"\n\n");
						break;
					case 3:
						outputText("\"<i>I know, slave, you want your Mistress to wear your [vagOrAss] like a sleeve around her magnificent cock. If you behave yourself, you'll get your wish soon enough. For today, though, your hand is all you're entitled to. Are you ready yet? Just fall to your knees when you are.</i>\"\n\n");
						break;
					case 4:
					default:
						outputText("\"<i>Can you last any longer, slave? I don't think you can. Your knees are shaking. You're screaming loud enough to wake the dead. ");
						if (player.hasVagina())
						{
							outputText("Your gaping pussy has lubricated me well enough to comfortably fuck an entire harem of dry, virgin assholes.");
						}
						else if (player.hasCock())
						{
							if (player.totalCocks() == 1)
							{
								outputText("Your silly little cock is");
							}
							else if (player.totalCocks() == 1)
							{
								outputText("Your silly pair of cocks are");
							}
							else
							{
								outputText("Your silly collection of cocks are");
							}
							
							outputText(" going to have the flavor and scent of my cum for a month -- not that anyone other than you is likely to taste ");
							if (player.totalCocks() == 1)
							{
								outputText("it");
							}
							else
							{
								outputText("them");
							}
							outputText(" any time soon.");
						}
						else
						{
							outputText("Your ridiculous shapeless crotch is wetter and needier than any pussy I've fucked in the last month -- and every pussy I fuck is quite wet and needy.");
						}
						
						outputText(" The desire you felt while kneeling at my feet worshiping my dick has utterly consumed you, and it is now time for you to kneel once again and beg for the privilege of releasing it.</i>\"\n\n");
				}
				menu();
				if (sceneVariation < 4)
				{
					if (saidNo == 1 && player.will > prison.prisonWillCost(3))
					{
						addButton(0,"Resist",prisonCaptorFeedingOrgasmTrainingAccept,3);
					}
					else if (saidNo == 0)
					{
						addButton(0,"Endure",prisonCaptorFeedingOrgasmTrainingAccept,3);
					}
					
				}
				addButton(1,"Collapse",prisonCaptorFeedingOrgasmTrainingAccept,4);
				return;
			}
			if (branchChoice == "4")
			{
				outputText("",true);
				outputText("Every muscle in your legs has become a twitching, gelatinous mass, and as the last twinkle of willpower within you blinks out they all collapse at once. Thankfully, Mistress Elly is there to support your weight as you fall");
				if (totalResistance - saidNo > 0)
				{
					outputText(", slick crotch sliding down the substantial length her shaft as you do");
				}
				outputText(". You settle unceremoniously to your knees, hunched over and oblivious, hands still working feverishly between your legs.\n\n");
				outputText("Sudden, blinding light rips you halfway back to your senses as the strip of velvety cloth is pulled from your eyes. Blinking and squinting, you look up to see your Mistress standing in front of you, wearing her leather sleeves and corset as though she had never removed them. In another state of mind you might take a moment to puzzle at this, but as you are you simply gaze upon her cheerful, smiling face, then turn your attention down to the hypnotic motion of her hands ardently massaging her shaft in alternating downward strokes.\n\n");
				outputText("\"<i>Now, slave, ask your Mistress for permission to come.</i>\"\n\n");
				menu();
				addButton(0,"Beg to Come",prisonCaptorFeedingOrgasmTrainingAccept,5);
				return;
			}
			if (branchChoice == "5" || branchChoice == "6")
			{
				begVariation = totalResistance - resistanceCounter;
				outputText("",true);
				prison.changeEsteem(-1,prison.inPrison);
				if (resistanceCounter == totalResistance)
				{
					outputText("\"<i>Mistress... may I... ooh...  [if (esteem < 40) <b>please</b>\" else \"please] have permission... haahh... to come?</i>\" you beg between breathy moans.\n\n");
					if (resistanceCounter == 1)
					{
						outputText("\"<i>Very soon. But first, I think there is something you need to confess to yourself before I allow it.</i>\" Your jaw drops wide in an expression of anguish and yearning. \"<i>Now, slave, ");
					}
					else if (resistanceCounter > 1)
					{
						outputText("\"<i>Very soon. But first, I think there are some things you need to confess to yourself before I allow it.</i>\" Your jaw drops wide in an expression of anguish and yearning. \"<i>To begin with, ");
					}
					else
					{
						outputText("\"<i>Yes, dear. You may come now.</i>\"\n\n");
					}
					
				}
				else
				{
					switch(begVariation)
					{
						case 1:
							if (saidNo == 1)
							{
								outputText("\"<i>Servicing --</i>\"\n\n");
								outputText("\"<i>Manners, slave.</i>\"\n\n");
							}
							if (branchChoice == "5")
							{
								outputText("\"<i>Mistress... servicing your cock...</i>\" your admission breaks into another lewd moan. Mistress Elly waits with patient delight for you to compose yourself. \"<i>it, ooh... it makes me so horny.</i>\" You're not sure what's more humiliating: the way you're debasing yourself, that you're such a wreck you can barely submit successfully, or that you're not even resisting it anymore.\n\n");
							}
							else
							{
								outputText("\"<i>Mistress... servicing your cock...</i>\" your admission breaks into another lewd moan. Mistress Elly waits with patient delight for you to compose yourself. \"<i>it... it makes me horny.</i>\" You're not sure what's more humiliating: the way you're debasing yourself or that you're such a wreck you can't repeat one simple sentence successfully.\n\n");
							}
							break;
						case 2:
							if (branchChoice == "5")
							{
								outputText("\"<i>Mistress, crawling to you... crawling like a bitch in heat...[if (esteem < 40)  it makes me feel good --\" else \"it makes me feel, uhm...] free, natural... uncomplicated.</i>\" [if (esteem < 40) Almost like your body was built for it.\" else \"Again, there is more truth in your words than you'd like.]\n\n");
							}
							else
							{
								outputText("\"<i>Mistress, crawling to you... crawling like a bitch in heat...[if (esteem < 40)  it makes me feel good --\" else \"it makes me feel, uhm...] free, natural... uncomplicated.</i>\" [if (esteem < 40) Almost like your body was built for it.\" else \"Again, there is more truth in your words than you'd like.]\n\n");
							}
							break;
						case 3:
							if (branchChoice == "5")
							{
								outputText("\"<i>Mistress, when I feel... aaah... feel you come,[if (esteem < 40)  when you feed me,] when you fill my stomach... haaahhh... it's wonderful[if (esteem < 40) ... it makes me, uhm, happy].</i>\" [if (esteem >= 40) Is it really? You pray it's just your pent up orgasm talking.]\n\n");
							}
							else
							{
								outputText("\"<i>Mistress, when I feel... aaah... feel you come,[if (esteem < 40)  when you feed me,] when you fill my stomach... haaahhh... it's wonderful[if (esteem < 40) ... it makes me, uhm, happy].</i>\" [if (esteem >= 40) Is it really? You pray it's just your pent up orgasm talking.]\n\n");
							}
							break;
						case 4:
							if (branchChoice == "5")
							{
								outputText("\"<i>Mistress...</i>\" Even in your wretched state this is getting harder to do.\n\n");
								outputText("\"<i>Yes, dear, continue.</i>\"\n\n");
								if (player.esteem < 20)
								{
									outputText("\"<i>I like it... ohh, Mistress... I like it when you come all over me... yesss... I know you love me when you do... ah...ahh.. ahha... I know you'll care for me...</i>\"\n\n");
								}
								else if (player.esteem < 50)
								{
									outputText("\"<i>When you come... when I'm covered in your cum... I feel loved... and I feel how powerful you are.</i>\"\n\n");
								}
								else
								{
									outputText("Just tear the bandage off. \"<i>Mistress, being covered in.. uuhhh... in your cum makes me feel loved and protected.</i>\"\n\n");
								}
								
							}
							else
							{
								outputText("\"<i>Mistress...</i>\" Even in your wretched state this is getting harder to do.\n\n");
								outputText("\"<i>Yes, dear, continue.</i>\"\n\n");
								if (player.esteem < 20)
								{
									outputText("\"<i>I like it... ohh, Mistress... I like it when you come all over me... yesss... I know you love me when you do... ah...ahh.. ahha... I know you'll care for me...</i>\"\n\n");
								}
								else if (player.esteem < 50)
								{
									outputText("\"<i>When you come... when I'm covered in your cum... I feel loved... and I feel how powerful you are.</i>\"\n\n");
								}
								else
								{
									outputText("Just tear the bandage off. \"<i>Mistress, being covered in.. uuhhh... in your cum makes me feel loved and protected.</i>\"\n\n");
								}
								
							}
							break;
						case 5:
							if (branchChoice == "5")
							{
								if (player.esteem < 40)
								{
									outputText("\"<i>Mistress... ohh gods... you are right about me... I'm wrong... please, Mistress, <b>please</b> let your slave come.</i>\"\n\n");
								}
								else if (player.esteem < 60)
								{
									outputText("\"<i>Mistress, you... you know... oooohh.... you know my nature better than I do...</i>\"\n\n");
								}
								else
								{
									outputText("\"<i>Yes, Mistress, you knoooohhhh...  you know the truth about me, much more than I do.</i>\"\n\n");
								}
								
							}
							else if (player.esteem < 40)
							{
								outputText("\"<i>Mistress... ohh gods... you are right about me... I'm wrong... please, Mistress, <b>please</b> let your slave come.</i>\"\n\n");
							}
							else if (player.esteem < 60)
							{
								outputText("\"<i>Mistress, you... you know... oooohh.... you know my nature better than I do...</i>\"\n\n");
							}
							else
							{
								outputText("\"<i>Yes, Mistress, you knoooohhhh...  you know the truth about me, much more than I do.</i>\"\n\n");
							}
							
							
							break;
						case 6:
							if (branchChoice == "5")
							{
								if (player.esteem < 20)
								{
									outputText("\"<i>Yes! Please, Mistress! Please come on me again! Shower your slave in cum while [he] orgasms for you so [he] can enjoy it!</i>\"\n\n");
								}
								else if (player.esteem < 50)
								{
									outputText("\"<i>Please, Mistress... show me your love again while I come... so I can... oohh yeaass... truly enjoy myself.</i>\"\n\n");
								}
								else
								{
									outputText("\"<i>Mistress, please come on me again... huuuhhnn... when I come... ah... so I can enjoy my release.</i>\"\n\n");
								}
								
							}
							else if (player.esteem < 20)
							{
								outputText("\"<i>Yes! Please, Mistress! Please come on me again! Shower your slave in cum while [he] orgasms for you so [he] can enjoy it!</i>\"\n\n");
							}
							else if (player.esteem < 50)
							{
								outputText("\"<i>Please, Mistress... show me your love again while I come... so I can... oohh yeaass... truly enjoy myself.</i>\"\n\n");
							}
							else
							{
								outputText("\"<i>Mistress, please come on me again... huuuhhnn... when I come... ah... so I can enjoy my release.</i>\"\n\n");
							}
							
							
							break;
						default:
							outputText("Saying prompt number " + begVariation + "\n\n");
					}
					if (resistanceCounter < 1)
					{
						outputText("\"<i>Very good, dear. You may come now.</i>\"\n\n");
					}
					else if (resistanceCounter == 1)
					{
						outputText("\"<i>Good [boy]. Now, slave, ");
					}
					else
					{
						outputText("\"<i>Good [boy]. Next, ");
					}
					
				}
				prison.prisonCaptor.prisonCaptorScratchChange(1,-1);
				resistanceCounter--;
				if (resistanceCounter >= 0)
				{
					menu();
					begVariation++;
					switch(begVariation)
					{
						case 1:
							outputText("admit that servicing my cock makes you horny.</i>\"\n\n");
							addButton(0,"Admit It",prisonCaptorFeedingOrgasmTrainingAccept,5);
							break;
						case 2:
							outputText("confess that crawling across your cell like a bitch in heat makes you feel free and unburdened.</i>\"\n\n");
							addButton(0,"Confess",prisonCaptorFeedingOrgasmTrainingAccept,5);
							break;
						case 3:
							outputText("admit that the moment you feel me begin to pump my seed down your throat is the highlight of your day.</i>\"\n\n");
							addButton(0,"Admit It",prisonCaptorFeedingOrgasmTrainingAccept,5);
							break;
						case 4:
							outputText("confess that being bathed in my cum makes you feel loved and protected.</i>\"\n\n");
							addButton(0,"Confess",prisonCaptorFeedingOrgasmTrainingAccept,5);
							break;
						case 5:
							outputText("admit that I know the truth about what you are much better than you do.</i>\"\n\n");
							addButton(0,"Admit It",prisonCaptorFeedingOrgasmTrainingAccept,5);
							break;
						case 6:
							outputText("beg for me to shower you in cum while you orgasm so that you can fully enjoy your release.</i>\"\n\n");
							addButton(0,"Beg",prisonCaptorFeedingOrgasmTrainingAccept,5);
							break;
						default:
							outputText("Ordering prompt number " + begVariation + " </i>\"\n\n");
							addButton(0,"Beg",prisonCaptorFeedingOrgasmTrainingAccept,5);
					}
					return;
				}
			}
			if (player.hasCock())
			{
				outputText("With just one more stroke of your [cock biggest], ");
			}
			else if (player.hasVagina())
			{
				outputText("With just one more flick at your [clit], ");
			}
			else
			{
				outputText("With just one more tickle of your [asshole], ");
			}
			
			outputText("you do. Every muscle in your body seizes up at once, back arching, arms clenching, legs spasming, eyelids slamming shut, jaw dropping wide open. In the same instant you feel the first jet of cum from your Mistress's cock splash across your face, a seemingly unending rope that coats your nose, cheeks, and brow all at once, and so thickly that for a moment you eyes are sealed shut. Just as you manage to force one lid up, you see a second, equally long spurt launch from her tip. At first it lands squarely in your open mouth giving your tongue yet another taste of her exotic flavors, but then a convulsion of pleasure tears up your spine and causes your head to roll about your neck, disrupting her aim and covering your lips, chin, and jawline with a fresh layer of thick, white paint.\n\n");
			if ((player.hasCock()) || (player.hasVagina()))
			{
				outputText("At the same time your hands are busy managing a fountain of your own. ");
				if (player.hasCock())
				{
					outputText("Cum pours from your own cock");
					if (player.totalCocks() > 1)
					{
						outputText("s");
					}
					if (player.cumQ() < 750)
					{
						outputText(", albeit in quantities that pale in comparison to your Mistress");
					}
					else if (player.cumQ() < 1500)
					{
						outputText(" in quantities almost as prodigious as your Mistress");
					}
					else if (player.cumQ() < 2000)
					{
						outputText(", equal in volume to the load currently exploding across your [face]");
					}
					else
					{
						outputText(" in quantities even more prodigious than your Mistress");
					}
					
					
					outputText(", spraying wildly through the air to land all over and around your lap. ");
				}
				if (player.hasVagina())
				{
					if (player.hasCock())
					{
						outputText("What's more, with");
					}
					else
					{
						outputText("With");
					}
					outputText(" every clench of your pelvic muscles");
					if (player.wetness() >= 4)
					{
						outputText(" a torrent of fluid shoots from your [cunt], splashing your thighs and soaking your calves, feet, and the floor beneath you. ");
					}
					else
					{
						outputText(" rivulets of fluid leak from your [cunt], running down your thighs as dripping down onto your calves, feet, and the floor beneath you. ");
					}
				}
			}
			outputText("Wave after wave, you tremble and shudder before her, watching through your bleary, jizz shuttered eyes as her hands continue to pump down her shaft, delivering load after load until there is hardly an inch of your body that isn't dripping with her sticky warmth. As her orgasm abates, her final voluminous salvo hits you across your neck and collarbone, generating an avalanche of cum ");
			if (player.biggestTitSize() <= 1)
			{
				outputText("that flows down your [fullChest]");
			}
			else if (player.biggestTitSize() <= 3)
			{
				outputText("that flows down through the cleavage of your [fullChest]");
			}
			else
			{
				outputText("that pools atop your [fullChest] before flowing down through your cleavage");
			}
			
			outputText(" and over your belly, then gushes down between your legs ");
			if (player.hasCock())
			{
				outputText("washing over [eachCock][if (hasBalls = true)  and coating your [sack]] ");
			}
			else if (player.hasVagina())
			{
				outputText("washing over your [clit] and through your pussy lips ");
			}
			
			outputText("before splashing audibly below you. And with this last humiliating sensation, your body gives one final shiver then tumbles forward falling loosely to the floor.\n\n");
			outputText("So overwhelmingly powerful was your orgasm that you fight to retain consciousness as you lie in a broad, shallow puddle of sexual fluids. You are only vaguely aware of Mistress Elly squatting down beside you with a contented grin on her face, but you do feel yourself sigh happily when she begins to run her fingers softly through your cum-soaked [hair].\n\n");
			outputText("\"<i>Now, wasn't that nice, dear?</i>\"\n\n");
			outputText("\"<i>Yes, Mistress.</i>\" You struggle to focus your eyes on her face as you speak. \n\n");
			outputText("\"<i>And are you grateful that I allowed you to come?</i>\"\n\n");
			outputText("\"<i>Yes, Mistress. Thank you, Mistress.</i>\" The drowsy words come automatically, your awareness of your surroundings rapidly fading away. \n\n");
			outputText("\"<i>Good [boy] -- always remember you manners, especially when you've been given such a nice gift. Sadly, I can't also give you a full meal since you were so resistant early on, but you'll find a nice bowl of soup over where you were kneeling.</i>\" You struggle against your growing weariness to turn your head, and see there is indeed a bowl behind you. Given that it sits overflowing with what can only be a mixture of her leavings and your own, she must have set it below your ass as you squatted to receive your facial. You make a sleepy effort to reach out for it, but your Mistress stops you, taking hold of your arm and drawing it around so that your hand pillows your cheek.\n\n");
			outputText("\"<i>Rest now, dear. It will be there for you to enjoy when you wake up.</i>\" She gives you one more gentle pat on your head, coaxing you to give up the fight, and you drift quietly into a blissful sleep.\n\n");
			if (prison.prisonIsRestrained())
			{
				outputText("As the door closes behind her, your restraints reappear.\n\n",false);
			}
			player.slimeFeed();
			player.refillHunger(5);
			prison.changeEsteem(-4,prison.inPrison);
			prison.changeObey(2,prison.inPrison);
			player.orgasm();
			flags[kFLAGS.PRISON_TRAINING_LEVEL]++;
			if (flags[kFLAGS.PRISON_TRAINING_LEVEL] > 4 && player.obey > 45 + rand(6) - (flags[kFLAGS.PRISON_TRAINING_LEVEL] * 2))
			{
				player.changeStatusValue(StatusEffects.PrisonCaptorEllyStatus,1,4);
				flags[kFLAGS.PRISON_TRAINING_LEVEL] = 0;
			}
			flags[kFLAGS.PRISON_TRAIN_SELF_CONTROL_UNLOCKED] = 1;
			inventory.takeItem(consumables.C_BREAD, camp.returnToCampUseTwoHours);
		}
		
		public function prisonCaptorFeedingOrgasmTrainingPerform():void
		{
			clearOutput();
			outputText("(Placehoder) You let yourself go and give her an excellent BJ while masturbating furiously, and orgasm prodigiously when told to. She is quite pleased, and rewards you with an untainted meal.\n\n",false);
			if (prison.prisonIsRestrained())
			{
				outputText("As the door closes behind her, your restraints reappear.\n\n",false);
			}
			player.slimeFeed();
			player.refillHunger(15, true);
			prison.changeEsteem(-6,prison.inPrison);
			prison.changeObey(2.5,prison.inPrison);
			player.orgasm();
			flags[kFLAGS.PRISON_TRAINING_LEVEL]++;
			if (flags[kFLAGS.PRISON_TRAINING_LEVEL] > 4 && player.obey > 45 + rand(3) - (flags[kFLAGS.PRISON_TRAINING_LEVEL] * 2))
			{
				player.changeStatusValue(StatusEffects.PrisonCaptorEllyStatus,1,4);
				flags[kFLAGS.PRISON_TRAINING_LEVEL] = 0;
			}
			flags[kFLAGS.PRISON_TRAIN_SELF_CONTROL_UNLOCKED] = 1;
			inventory.takeItem(consumables.P_BREAD, camp.returnToCampUseOneHour);
		}
		
		public function prisonCaptorFeedingAnalTrainingAccept():void
		{
			clearOutput();
			outputText("(Placehoder) You meekly agree and clumsily pound her dick into your ass while masturbating, but don't orgasm exactly when she does. You have to keep fucking away with an ass stuffed with cum until you finally manage to cum, and then lick her dick clean greatful to have the ordeal overwith. She is happy, but since you didn't put your heart into it you get a bowl of cum. Try harder next time!",false);
			outputText("\n\nOut of thin air she produces a pitiful loaf of bread and crumbles it into a bowl. With a smile of supreme satisfaction, she begins to milk her cock into it. Before long, the bowl is overflowing with her sticky seed. She sets it on the ground and gives you a playful wink before leaving you alone in the cell.\n\n",false);
			if (prison.prisonIsRestrained())
			{
				outputText("As the door closes behind her, your restraints reappear.\n\n",false);
			}
			player.buttChange(32,true,true,false);
			player.slimeFeed();
			prison.changeEsteem(-5,prison.inPrison);
			prison.changeObey(2.5,prison.inPrison);
			player.orgasm();
			flags[kFLAGS.PRISON_TRAINING_LEVEL]++;
			if (flags[kFLAGS.PRISON_TRAINING_LEVEL] > 4 && player.obey > 70 + rand(6) - (flags[kFLAGS.PRISON_TRAINING_LEVEL] * 2))
			{
				player.changeStatusValue(StatusEffects.PrisonCaptorEllyStatus,1,5);
				flags[kFLAGS.PRISON_TRAINING_LEVEL] = 0;
			}
			flags[kFLAGS.PRISON_TRAIN_ANAL_CAPACITY_UNLOCKED] = 1;
			inventory.takeItem(consumables.C_BREAD, camp.returnToCampUseOneHour);
		}
		
		public function prisonCaptorFeedingAnalTrainingPerform():void
		{
			clearOutput();
			outputText("(Placehoder) You let yourself go and plow yourself unthinkingly onto her cock, spasming with pleasure the moment you feel your ass inflate with her seed. You then greedily lick every bit of cum from her dick, and for an encore lick the pools of cum off the floor that dripped from your ass. She is quite pleased, and rewards you with an untainted meal.\n\n",false);
			if (prison.prisonIsRestrained())
			{
				outputText("As the door closes behind her, your restraints reappear.\n\n",false);
			}
			player.buttChange(32, true, true, false);
			player.obeySoftCap = false;
			player.slimeFeed();
			player.refillHunger(5);
			prison.changeEsteem(-7,prison.inPrison);
			prison.changeObey(3,prison.inPrison);
			player.orgasm();
			flags[kFLAGS.PRISON_TRAINING_LEVEL]++;
			if (flags[kFLAGS.PRISON_TRAINING_LEVEL] > 4 && player.obey > 70 + rand(3) - (flags[kFLAGS.PRISON_TRAINING_LEVEL] * 2))
			{
				player.changeStatusValue(StatusEffects.PrisonCaptorEllyStatus,1,5);
				flags[kFLAGS.PRISON_TRAINING_LEVEL] = 0;
			}
			flags[kFLAGS.PRISON_TRAIN_ANAL_CAPACITY_UNLOCKED] = 1;
			inventory.takeItem(consumables.P_BREAD, camp.returnToCampUseOneHour);
		}
		
		public function prisonCaptorFeedingEvent():Boolean
		{
			clearOutput();
			if (prison.prisonCaptor.captorName != "Elly")
			{
				outputText("The door opens and a guard tosses a pathetic piece of bread at your feet.\n\n",false);
				inventory.takeItem(consumables.P_BREAD, playerMenu);
				return true;
			}
			prison.prisonCaptorTrainingStatusUpdate();
			switch(player.statusEffectv1(StatusEffects.PrisonCaptorEllyStatus))
			{
				case 0:
				case 1:
					prisonCaptorFeedingTitleTraining();
					return true;
				case 2:
					prisonCaptorFeedingBJTraining();
					return true;
				case 3:
					prisonCaptorFeedingOrgasmTraining();
					return true;
				case 4:
					prisonCaptorFeedingAnalTraining();
					return true;
				case 5:
					prisonCaptorFeedingQuestTraining();
					return true;
				default:
					prisonCaptorFeedingFullyTrained();
					return true;
			}
		}

		public function prisonCaptorFeedingTrainingRefuse():void
		{
			clearOutput();
			var outcomeSelect:int = 0;
			var lustChange:int = 0;
			if (player.will < prison.prisonWillCost(5))
			{
				outputText("While you'd like to preserve a bit of your dignity and refuse to do as you have been told, you simply don't have the willpower to resist Mistress Elly right now. ",false);
				if (rand(player.esteem * 3) > player.obey + player.lust + player.cor)
				{
					prison.changeEsteem(2,prison.inPrison);
					outputText("\n\n",false);
					switch(player.statusEffectv1(StatusEffects.PrisonCaptorEllyStatus))
					{
						case 1:
							prisonCaptorFeedingTitleTrainingAccept();
							return;
						case 2:
							prisonCaptorFeedingBJTrainingAccept();
							return;
						case 3:
							prisonCaptorFeedingOrgasmTrainingAccept();
							return;
						case 4:
							prisonCaptorFeedingAnalTrainingAccept();
							return;
						case 5:
							prisonCaptorFeedingQuestTrainingAccept();
							return;
						default:
							prisonCaptorFeedingTitleTrainingAccept();
							return;
					}
				}
				else
				{
					outputText(" In fact, while a second ago you thought you had the desire to refuse, now the thought of debasing yourself for her approval is filling you with an overwheling desire to do the exact opposite and put all your heart into doing as you gave been told.\n\n",false);
					prison.changeEsteem(2,prison.inPrison);
					outputText("\n\n",false);
					switch(player.statusEffectv1(StatusEffects.PrisonCaptorEllyStatus))
					{
						case 1:
							prisonCaptorFeedingTitleTrainingPerform();
							return;
						case 2:
							prisonCaptorFeedingBJTrainingPerform();
							return;
						case 3:
							prisonCaptorFeedingOrgasmTrainingPerform();
							return;
						case 4:
							prisonCaptorFeedingAnalTrainingPerform();
							return;
						case 5:
							prisonCaptorFeedingQuestTrainingAccept();
							return;
						default:
							prisonCaptorFeedingTitleTrainingPerform();
							return;
					}
				}
			}
			else
			{
				if (prisonCaptorFeedingQuestTrainingExists())
				{
					player.changeStatusValue(StatusEffects.PrisonCaptorEllyQuest,1,0);
					player.changeStatusValue(StatusEffects.PrisonCaptorEllyQuest,2,0);
					player.changeStatusValue(StatusEffects.PrisonCaptorEllyQuest,3,0);
					player.changeStatusValue(StatusEffects.PrisonCaptorEllyQuest,4,0);
				}
				prison.changeWill(-prison.prisonWillCost(5));
				outputText("Though you are unwilling to obey [if (obey <= 25) your captor][if (obey > 25) your Mistress] in this moment, ",false);
				if (player.obey < 10)
				{
					if (player.esteem < 15)
					{
						outputText("you are afraid of what might happen should you truly anger her.",false);
					}
					else if (player.esteem < 40)
					{
						outputText("you don't feel confident enough to confront her right now.",false);
					}
					else if (player.esteem < 60)
					{
						outputText("you would prefer not to anger her, either.",false);
					}
					else if (player.esteem < 85)
					{
						outputText("you see no reason to provoke her, either.",false);
					}
					else
					{
						outputText("you see no advantage to provoking her, either.",false);
					}
					
				}
				else if (player.obey < 25)
				{
					if (player.esteem < 15)
					{
						outputText("you desperately hope that your failure does not upset her.",false);
					}
					else if (player.esteem < 40)
					{
						outputText("you hope that your refusal does not upset her.",false);
					}
					else if (player.esteem < 60)
					{
						outputText("you know your life will be a lot easier if you can avoid upsetting her.",false);
					}
					else if (player.esteem < 85)
					{
						outputText("you feel it would be wise to remain civil.",false);
					}
					else
					{
						outputText("you feel that you should at least remain tactful.",false);
					}
					
				}
				else if (player.obey < 45)
				{
					if (player.esteem < 15)
					{
						outputText("you hope that she can forgive your inability to please her.",false);
					}
					else if (player.esteem < 40)
					{
						outputText("you hope that she knows you are sorry to have refused her.",false);
					}
					else if (player.esteem < 60)
					{
						outputText("you know it's better to keep your Mistress happy with you whenever you can.",false);
					}
					else if (player.esteem < 85)
					{
						outputText("you do not wish to displease her, either.",false);
					}
					else
					{
						outputText("you want to remain as courteous as possible.",false);
					}
					
				}
				else if (player.obey < 70)
				{
					if (player.esteem < 15)
					{
						outputText("you find the anticipation of her disappointment more harrowing than any punishment.",false);
					}
					else if (player.esteem < 40)
					{
						outputText("you feel immediately  ashamed by your petty defiance.",false);
					}
					else if (player.esteem < 60)
					{
						outputText("the thought of disappointing your Mistress is hard to stomach..",false);
					}
					else if (player.esteem < 85)
					{
						outputText("you earnestly regret your inability to perform for her.",false);
					}
					else
					{
						outputText("you tacitly realize that your failure to perform warrants punishment.",false);
					}
					
				}
				else if (player.esteem < 15)
				{
					outputText("you feel the need for her to protect you from your lingering defiance.",false);
				}
				else if (player.esteem < 40)
				{
					outputText("you hope that she can help you learn to be a better slave.",false);
				}
				else if (player.esteem < 60)
				{
					outputText("you feel compelled to prove your desire to be a better slave.",false);
				}
				else if (player.esteem < 85)
				{
					outputText("you wish you could bring yourself to always do as she asks.",false);
				}
				else
				{
					outputText("you hope that she knows how sorry you are to require her discipline.",false);
				}
				
				if (player.statusEffectv1(StatusEffects.PrisonCaptorEllyStatus) == 3)
				{
					outputText("You remove her cock from your mouth, but continue to hold it gently in your hand. Then, assuming an apologetic tone, you ");
				}
				else
				{
					outputText(" Assuming a penitent posture and an apologetic tone, you ");
				}
				if (player.obey <= 25)
				{
					if (player.esteem < 15)
					{
						outputText("meekly explain your refusal to do as asked, your eyes to the floor and your voice barely audible.",false);
					}
					else if (player.esteem < 40)
					{
						outputText("state your refusal to do as asked, making a point to avoid Mistress Elly's gaze.",false);
					}
					else if (player.esteem < 60)
					{
						outputText("state your refusal to do as asked, making a point to avoid Mistress Elly's gaze.",false);
					}
					else if (player.esteem < 85)
					{
						outputText("state your refusal to do as asked, making a point to avoid Mistress Elly's gaze.",false);
					}
					else
					{
						outputText("calmly declare your defiance, briefly seeking out her violet eyes to show your resolve.",false);
					}
					
				}
				else if (player.esteem < 15)
				{
					outputText("beg forgiveness for your refusal to do as asked, your eyes to the floor and your voice barely audible.",false);
				}
				else if (player.esteem < 40)
				{
					outputText("state your refusal to do as asked, making a point to avoid Mistress Elly's gaze.",false);
				}
				else if (player.esteem < 60)
				{
					outputText("state your refusal to do as asked, making a point to avoid Mistress Elly's gaze.",false);
				}
				else if (player.esteem < 85)
				{
					outputText("state your refusal to do as asked, making a point to avoid Mistress Elly's gaze.",false);
				}
				else
				{
					outputText("calmly declare your defiance, briefly seeking out her violet eyes to show your resolve.",false);
				}
				
				outputText(" A moment that feels like an eternity passes as you sit in the shadow of her imposing figure, awaiting her rebuke ");
				if (player.obey <= 45)
				{
					if (player.esteem < 15)
					{
						outputText("and visibly shivering with uncertainty.",false);
					}
					else if (player.esteem < 40)
					{
						outputText("with growing trepidation.",false);
					}
					else if (player.esteem < 60)
					{
						outputText("with growing trepidation.",false);
					}
					else if (player.esteem < 85)
					{
						outputText("with growing trepidation.",false);
					}
					else
					{
						outputText("with a hard, stoic expression.",false);
					}
					
				}
				else if (player.esteem < 15)
				{
					outputText(", heart pounding in anticipation.",false);
				}
				else if (player.esteem < 40)
				{
					outputText("with a mixture of fear and excitement.",false);
				}
				else if (player.esteem < 60)
				{
					outputText("with a mixture of fear and excitement.",false);
				}
				else if (player.esteem < 85)
				{
					outputText("with a mixture of fear and excitement.",false);
				}
				else
				{
					outputText("as an unbidden curiosity ignites inside you.",false);
				}
				
				outputText("\n\n");
				outcomeSelect = rand(5);
				if (outcomeSelect == 0)
				{
					outputText("To your great relief, you see her look of stern disappointment soften into one of concern and caring. She takes a gentle step towards you then reaches down and lifts you to your feet, cupping your [face] softly in her hands. \"<i>Oh, you poor, pitiful little creature. I can only imagine how hard it must be coming to terms with what you are, and I can see how desperately you want to.</i>\" As she speaks, still cradling your cheek in her left hand, her right descends with delicate purpose. Her fingers trace the nape of your neck, briefly lingering on your collarbone, before slowly snaking their way over your [chest]. A wave of goosebumps follows her touch, and she gives a savage twist to one of your suddenly erect [nipples][if (milkQuantity > 10) , eliciting a tentative spurt of milk in response]. \"<i>Yes, quite desperately.</i>\"\n\n",false);
					outputText("A wicked, satisfied smile crosses her lips at your surprised gasp, but just as quickly her expression returns to its previous nurturing state as she pulls you into a sympathetic embrace. Her right hand fondles and pinches at your [nipple] with calculated cruelty, but her left hand now rhythmically strokes up and down your spine, inducing ever stronger waves of gooseflesh which shiver their way through your body. Reflexive or not, the pleasant sensations momentarily overwhelm you causing your [asshole] to pucker uncontrollably and leaving your mind blank as her soothing voice continues to speak.\n\n",false);
					outputText("\"<i>As ever, my dear, I'm here to help you get what you want. You want to be a good little " + player.mf("boy", "girl") + " and do as your Mistress asks, but you have too many unhelpful thoughts bouncing around your head. At moments like that, you need to learn to listen to your body instead.</i>\" Her left hand drifts around to your crotch and begins to gingerly pet your ",false);
					if (player.hasCock())
					{
						outputText("[cock]'s [cockHead]");
					}
					else if (player.hasVagina())
					{
						outputText("[clit]");
					}
					else
					{
						outputText("sensitive pubic mound");
					}
					
					outputText(", and a new wavefront of pleasure crashes into the wake of shivers still being generated by her savage treatment of your [chest].\n\n");
					outputText("Your previously blank mind is now drowning, struggling for the oxygen it needs to combat the onslaught of her alluring words. \"<i>Your body doesn't lie, slave. It knows its place, even if you are still struggling to understand. So I'm going to leave you with the gift of hunger. I know it can be unpleasant, but it's a useful tool. Revel in it. Let it teach you to listen to what your body needs. And next time I visit to feed you, I think you will find it a lot easier to fulfill your desire to please me.</i>\"\n\n");
					outputText("All at once she releases her grasp on you and steps back. Your [legs] make a halfhearted attempt to find their strength, but collapse in the riptide of sensations left behind by her abrupt absence. As you slowly regain control of your senses, your ears are ringing and you find your body crumpled into a quivering mass at Mistress Elly's feet[if (milkQuantity > 250) , your [face] resting in a sticky pool of your own milk]. She favors you with one last triumphant smile, then turns her back and walks out the door.\n\n");
					if (prison.prisonIsRestrained())
					{
						outputText("As the door closes behind her, your restraints reappear.\n\n",false);
					}
					lustChange = 40;
					dynStats("lus", lustChange);
					prison.changeEsteem(1,prison.inPrison);
					doNext(playerMenu);
					return;
				}
				if (outcomeSelect == 1)
				{
					outputText("You can't help but feel a rush of shame as you see her look of stern disappointment cloud over with pity. She moves back towards the door, pauses to think for a moment, then turns back toward you. \"<i>Apology or not, you've disobeyed me and have not earned the right to eat today. But I have a soft spot for you, little slave, and you have shown that you have a desire to be a better servant. While you should still expect to be punished for anything but absolute obedience, today I will make an exception and reward your desire despite your failure to please me.</i>\" Out of thin air she produces a pitiful loaf of bread and crumbles it into a bowl. With a smile of supreme satisfaction, she begins to milk her cock into it. Before long, the bowl is overflowing with her sticky seed. She sets it on the ground and gives you a playful wink and a flick of her spade-tipped tail before leaving you alone in the cell.\n\n",false);
					if (prison.prisonIsRestrained())
					{
						outputText("As the door closes behind her, your restraints reappear.\n\n",false);
					}
					prison.changeEsteem(3,prison.inPrison);
					inventory.takeItem(consumables.C_BREAD, camp.returnToCampUseOneHour);
					
					return;
				}
				outputText("Your stomach fills with lead as you watch her look of stern dissapointment harden on her face. \"<i>Apology or not, you've disobeyed me. I am glad to see that you have a desire to please me, but desire alone does not earn you the privilege of being fed. But I am not heartless -- quite to the contrary, I think you are coming to understand just how much I want to help you. And so now I'm going to help you embrace your desire to please me by showing you what happens when you do not.</i>\"\n\n",false);
				prison.changeEsteem(3,prison.inPrison);
				prison.prisonPunishment(80);
				return;
			}
		}
		
		public function prisonCaptorFeedingTrainingReject():void
		{
			clearOutput();
			if (player.will < prison.prisonWillCost(15))
			{
				outputText("While you'd like to preserve a bit of your dignity and refuse to do as you have been told, you simply don't have the willpower to resist Mistress Elly right now. ",false);
				if (rand(player.esteem * 3) > player.obey + player.lust + player.cor)
				{
					prison.changeEsteem(2,prison.inPrison);
					outputText("\n\n",false);
					switch(player.statusEffectv1(StatusEffects.PrisonCaptorEllyStatus))
					{
						case 1:
							prisonCaptorFeedingTitleTrainingAccept();
							return;
						case 2:
							prisonCaptorFeedingBJTrainingAccept();
							return;
						case 3:
							prisonCaptorFeedingOrgasmTrainingAccept();
							return;
						case 4:
							prisonCaptorFeedingAnalTrainingAccept();
							return;
						case 5:
							prisonCaptorFeedingQuestTrainingAccept();
							return;
						default:
							prisonCaptorFeedingTitleTrainingAccept();
							return;
					}
				}
				else
				{
					outputText(" In fact, while a second ago you thought you had the desire to refuse, now the thought of debasing yourself for her approval is filling you with an overwheling desire to do the exact opposite and put all your heart into doing as you gave been told.\n\n",false);
					prison.changeEsteem(2,prison.inPrison);
					outputText("\n\n",false);
					switch(player.statusEffectv1(StatusEffects.PrisonCaptorEllyStatus))
					{
						case 1:
							prisonCaptorFeedingTitleTrainingPerform();
							return;
						case 2:
							prisonCaptorFeedingBJTrainingPerform();
							return;
						case 3:
							prisonCaptorFeedingOrgasmTrainingPerform();
							return;
						case 4:
							prisonCaptorFeedingAnalTrainingPerform();
							return;
						case 5:
							prisonCaptorFeedingQuestTrainingAccept();
							return;
						default:
							prisonCaptorFeedingTitleTrainingPerform();
							return;
					}
				}
			}
			else
			{
				if (prisonCaptorFeedingQuestTrainingExists())
				{
					player.changeStatusValue(StatusEffects.PrisonCaptorEllyQuest,1,0);
					player.changeStatusValue(StatusEffects.PrisonCaptorEllyQuest,2,0);
					player.changeStatusValue(StatusEffects.PrisonCaptorEllyQuest,3,0);
					player.changeStatusValue(StatusEffects.PrisonCaptorEllyQuest,4,0);
				}
				prison.changeWill(-prison.prisonWillCost(15));
				outputText("Mistress Elly has simply asked too much from you -- you can't bring yourself to do as you have been instructed. What's more, ",false);
				if (player.obey < 10)
				{
					if (player.esteem < 15)
					{
						outputText("the ball of rage and indignation building in the pit of your stomach demands that you resist as fiercely as possible.",false);
					}
					else if (player.esteem < 40)
					{
						outputText("the ball of rage and indignation building in the pit of your stomach demands that you resist as fiercely as possible.",false);
					}
					else if (player.esteem < 60)
					{
						outputText("the ball of rage and indignation building in the pit of your stomach demands that you resist as fiercely as possible.",false);
					}
					else if (player.esteem < 85)
					{
						outputText("the ball of rage and indignation building in the pit of your stomach demands that you resist as fiercely as possible.",false);
					}
					else
					{
						outputText("the ball of rage and indignation building in the pit of your stomach demands that you resist as fiercely as possible.",false);
					}
					
					
					
				}
				else if (player.obey < 25)
				{
					if (player.esteem < 15)
					{
						outputText("while you understand that there will be consequences there is only so much indignity that you can stomach politely.",false);
					}
					else if (player.esteem < 40)
					{
						outputText("while you understand that there will be consequences there is only so much indignity that you can stomach politely.",false);
					}
					else if (player.esteem < 60)
					{
						outputText("while you understand that there will be consequences there is only so much indignity that you can stomach politely.",false);
					}
					else if (player.esteem < 85)
					{
						outputText("while you understand that there will be consequences there is only so much indignity that you can stomach politely.",false);
					}
					else
					{
						outputText("while you understand that there will be consequences there is only so much indignity that you can stomach politely.",false);
					}
					
				}
				else if (player.obey < 45)
				{
					if (player.esteem < 15)
					{
						outputText("your fear of displeasing your Mistress will not be be enough to keep you respectful in your refusal to comply.",false);
					}
					else if (player.esteem < 40)
					{
						outputText("your fear of displeasing your Mistress will not be be enough to keep you respectful in your refusal to comply.",false);
					}
					else if (player.esteem < 60)
					{
						outputText("your fear of displeasing your Mistress will not be be enough to keep you respectful in your refusal to comply.",false);
					}
					else if (player.esteem < 85)
					{
						outputText("your fear of displeasing your Mistress will not be be enough to keep you respectful in your refusal to comply.",false);
					}
					else
					{
						outputText("your fear of displeasing your Mistress will not be be enough to keep you respectful in your refusal to comply.",false);
					}
					
				}
				else if (player.obey < 70)
				{
					if (player.esteem < 15)
					{
						outputText("while the shameful nature of the request is undeniably arousing, it has also robbed you of your ability to be civil about it. Perhaps your Mistress will find a good way to help you learn to accept it better.",false);
					}
					else if (player.esteem < 40)
					{
						outputText("while the shameful nature of the request is undeniably arousing, it has also robbed you of your ability to be civil about it. Perhaps your Mistress will find a good way to help you learn to accept it better.",false);
					}
					else if (player.esteem < 60)
					{
						outputText("while the shameful nature of the request is undeniably arousing, it has also robbed you of your ability to be civil about it. Perhaps your Mistress will find a good way to help you learn to accept it better.",false);
					}
					else if (player.esteem < 85)
					{
						outputText("while the shameful nature of the request is undeniably arousing, it has also robbed you of your ability to be civil about it. Perhaps your Mistress will find a good way to help you learn to accept it better.",false);
					}
					else
					{
						outputText("while the shameful nature of the request is undeniably arousing, it has also robbed you of your ability to be civil about it. Perhaps your Mistress will find a good way to help you learn to accept it better.",false);
					}
					
					
					
				}
				else if (player.esteem < 15)
				{
					outputText("you know you will have to be rude about it to ensure you get the punishment you crave for your failure to live up to your true nature.",false);
				}
				else if (player.esteem < 40)
				{
					outputText("you know you will have to be rude about it to ensure you get the punishment you crave for your failure to live up to your true nature.",false);
				}
				else if (player.esteem < 60)
				{
					outputText("you know you will have to be rude about it to ensure you get the punishment you crave for your failure to live up to your true nature.",false);
				}
				else if (player.esteem < 85)
				{
					outputText("you know you will have to be rude about it to ensure you get the punishment you crave for your failure to live up to your true nature.",false);
				}
				else
				{
					outputText("you know you will have to be rude about it to ensure you get the punishment you crave for your failure to live up to your true nature.",false);
				}
				
				if (player.statusEffectv1(StatusEffects.PrisonCaptorEllyStatus) == 3)
				{
					outputText(" You pull her cock from your mouth and shrink away, assume a combative tone, and ");
				}
				else
				{
					outputText(" You assume a defiant posture and a combative tone, and ");
				}
				if (player.obey <= 25)
				{
					if (player.esteem < 15)
					{
						outputText("angrily",false);
					}
					else if (player.esteem < 40)
					{
						outputText("angrily",false);
					}
					else if (player.esteem < 60)
					{
						outputText("angrily",false);
					}
					else if (player.esteem < 85)
					{
						outputText("angrily",false);
					}
					else
					{
						outputText("angrily",false);
					}
					
				}
				else if (player.esteem < 15)
				{
					outputText("flatly",false);
				}
				else if (player.esteem < 40)
				{
					outputText("flatly",false);
				}
				else if (player.esteem < 60)
				{
					outputText("flatly",false);
				}
				else if (player.esteem < 85)
				{
					outputText("flatly",false);
				}
				else
				{
					outputText("flatly",false);
				}
				
				outputText(" refuse to do as she has asked. You await her response ");
				if (player.obey <= 45)
				{
					if (player.esteem < 15)
					{
						outputText("in stoic foreboding.",false);
					}
					else if (player.esteem < 40)
					{
						outputText("in stoic foreboding.",false);
					}
					else if (player.esteem < 60)
					{
						outputText("in stoic foreboding.",false);
					}
					else if (player.esteem < 85)
					{
						outputText("in stoic foreboding.",false);
					}
					else
					{
						outputText("in stoic foreboding.",false);
					}
					
				}
				else if (player.esteem < 15)
				{
					outputText("with a mixture of fear and excitement.",false);
				}
				else if (player.esteem < 40)
				{
					outputText("with a mixture of fear and excitement.",false);
				}
				else if (player.esteem < 60)
				{
					outputText("with a mixture of fear and excitement.",false);
				}
				else if (player.esteem < 85)
				{
					outputText("with a mixture of fear and excitement.",false);
				}
				else
				{
					outputText("with a mixture of fear and excitement.",false);
				}
				
				outputText("\n\n",false);
				outputText("Mistress Elly simply stares at you with a mixture of disappointment and patience, like a caring parent deciding how to discipline a petulant child. There is no anger or frustration in her voice or her body language as she crouches down and takes a firm grip on your shoulder. \"<i>I know this is a hard process. I know you are still learning to cope with the shame of what you are. But that doesn't excuse rudeness.</i>\" With just a light flick of her wrist she flings you onto your back so forcefully that the wind is knocked out of you, and in a blink of an eye she is crouched on top of you with her right knee crushing your [fullChest]. She leans in so close that you can feel the warmth of her breath on your [face] and see her violet eyes fill with fire. \"<i>But I am not vengeful, nor am I unkind. I want to help you learn, and even your rudeness won't keep me from teaching you a useful lesson today.</i>\" \n\n");
				outputText("Satisfied with your reaction, she stands back up and pauses for a moment.\n\n");
				prison.changeEsteem(5,prison.inPrison);
				prison.changeObey(-1,prison.inPrison);
				prison.prisonPunishment(25);
				return;
			}
		}
		
		public function prisonCaptorFeedingTitleTrainingAccept():void
		{
			clearOutput();
			outputText("With a heavy sigh, you decide that it would be best to play along with this charade. [if (esteem < 40) Disturbingly, accepting your predicament isn't as as hard as you expected. ][if (esteem > 60) Swallowing your pride is particularly challenging, but preferable to the alternatives. ]You look up and see her waiting expectantly, a sly smirk creeping across her exotic features, and turn your eyes back down -- you aren't sure you could handle watching her reaction as you give in to her demands. After a pregnant moment of hesitation, the words slip past your lips in a monotone whisper\n\n");
			outputText("\"<i>Hello... Mistress... how may I... serve you today?</i>\" [if (esteem < 15) Despite your hesitation, the words feel, well, good as they tumble out. Without meaning to, you sheepishly lift your gaze, overcome by a need to know if she approved.][if (esteem > 70) The words feel like bile on your tongue as they lurch from your mouth.]\n\n");
			outputText("\"<i>I'm sorry, slave, I couldn't quite hear you. I expect you to respond to my orders loudly, clearly, and without hesitation. It also wouldn't hurt for you speak in a more reverential tone, but don't worry: that will come naturally with time. <b>Now, try again.</b></i>\" She punctuates the order with a single forceful tap of her spiked boot heel against the floor. The sharp, harsh clack rings in your ears, bringing an unbidden rush of adrenaline to your heart, and you find yourself responding before you have time to think.\n\n");
			outputText("\"<i>Hello Mistress, how may I... serve you today?</i>\" This time you speak the words more clearly, but still without any feeling. [if (esteem < 15) Somehow demeaning yourself this way wasn't nearly as hard as you expected it to be.][if (esteem > 70) You still nearly choked on the word 'serve'.]\n\n");
			outputText("\"<i>It's a start, but I'm afraid it's not enough for a full meal. Practice, and try harder next time. For now I'm afraid you'll have to make do with soup.</i>\" Out of thin air she produces a pitiful loaf of bread and crumbles it into a bowl. With a smile of supreme satisfaction, she begins to milk her cock into it. Before long, the bowl is overflowing with her sticky seed. She sets it on the ground and gives you a playful wink and a flick of her spade-tipped tail before leaving you alone in the cell.\n\n");
			if (prison.prisonIsRestrained())
			{
				outputText("As the door closes behind her, your restraints reappear.\n\n",false);
			}
			prison.changeEsteem(-3,prison.inPrison);
			prison.changeObey(1,prison.inPrison);
			flags[kFLAGS.PRISON_TRAINING_LEVEL]++;
			if (flags[kFLAGS.PRISON_TRAINING_LEVEL] > 3 && player.obey > 10 + rand(6))
			{
				player.changeStatusValue(StatusEffects.PrisonCaptorEllyStatus,1,2);
				flags[kFLAGS.PRISON_TRAINING_LEVEL] = 0;
			}
			flags[kFLAGS.PRISON_STUDY_MANNERS_UNLOCKED] = 1;
			inventory.takeItem(consumables.C_BREAD, camp.returnToCampUseOneHour);
		}
		
		public function prisonCaptorFeedingTitleTrainingPerform():void
		{
			clearOutput();
			outputText("You decide you might as well give [if (esteem < 40) your Mistress][if (esteem >= 40) her] a show[if (esteem < 40)  -- it might even be a fun little diversion to play along with her games a bit][if (esteem > 60)  -- after all, you see no harm in saying a few little words].[if (hunger > 50)  And the more you think about it, a good solid meal DOES sound very appealing.] You look up and see her waiting expectantly with a sly smirk creeping across her exotic features. Steeling your resolve, you fix her with your best impression of the doe eyed, pliable look you think she hopes to see. A subtle widening of her almond shaped eyes betrays her approval amidst her otherwise static expression, encouraging you to sit up straight with your back lightly arched and say the words in the same lilting voice that she used in demonstration.\n\n");
			outputText("\"<i>Hello Mistress, how may I serve you today?</i>\" To top off the performance, you await her response with a pleasant smile drawn across your face. [if (esteem < 15) There is less artifice in the smile than you'd like to admit -- playing up this role was every bit as entertaining as you expected.][if (esteem > 70) Underneath though, you are feeling oddly conflicted -- was your act maybe a bit too good?]\n\n");
			outputText("She claps her hands with giddy excitement and closes the distance between you with a triumphant dance. \"<i>Oh, what a good little " + player.mf("boy", "girl") + " you are. SO good!</i>\" She reaches down and gives you an exaggerated congratulatory pat on the head, resting her right hand in your [hair]. She is standing so close to you that her cock sways hypnotically just inches from your [face], semi-erect but fully imposing. You do your best to maintain your composure and suppliant posture, but the sight still makes you blush with [if (corruption < 30) embarrassment][if (corruption >= 30) arousal] as she continues to speak.\n\n");
			outputText("\"<i>It's a special thing when a slave proves me right so early in their training. Oh, I know, you probably think you are just pretending. But are you pretending for my sake, or your own?</i>\" Your mind tries to process the question, but to your great frustration the indecent motion of her fleshy rod and its musky, intoxicating scent have you too distracted to think clearly.\n\n");
			outputText("\"<i>Either way, it doesn't matter: it's a delicious taste of your true nature.</i>\" Her slender tongue darts over her shapely ruby lips[if (corruption >= 30)  and her tail flicks through the air]. \"<i><b>Now, say it again.</b></i>\" She punctuates the order with a single forceful tap of her spiked boot heel against the floor. The sharp, harsh clack rings in your ears, bringing an unbidden rush of adrenaline to your heart, and you find yourself responding before you have time to think.\n\n");
			outputText("\"<i>Hello Mistress, how may I serve you today?</i>\" You say it with the same fervor as before, but this time the performance comes much more naturally. [if (esteem > 70) Disturbingly so, if you are honest with yourself.]");
			if (player.esteem < 15)
			{
				outputText(" You do your best to ignore the sudden ");
				if (player.hasCock())
				{
					outputText("stirring in [eachCock]");
					if (player.hasVagina())
					{
						outputText(" and the dampness of your [cunt]");
					}
				}
				else if (player.hasVagina())
				{
					outputText("stirring in your womb and tingling of your [clit]");
				}
				else
				{
					outputText("dilation of your [asshole]");
				}
				
				outputText(", but the glimmer in her violet eyes tells you that your arousal did not go unnoticed. Your cheeks burn with shame.");
			}
			outputText("\n\nShe gives her shaft a relaxed squeeze and several slow anticipatory strokes with her left hand while once again patting your head with her right. \"<i>Oh, good " + player.mf("boy", "girl") + " indeed. You're going to have so much fun learning to please your Mistress.</i>\" She turns away, the tip of her shaft glancing across your upper lip. As it slides past it leaves behind a sticky residue[if (corruption < 30) , filling you with disgust for allowing it to happen][if (corruption >= 30) , which, to your dismay, your tongue darts out to collect of its own accord].[if (esteem > 55)  The indignity becomes too much to handle, and your facade of self confidence begins to shake at its foundation.]\n\n");
			outputText("She walks towards the door and almost as an afterthought tosses a pitiful loaf of bread over her shoulder. \"<i>Enjoy your well-earned meal, slave.</i>\" The satisfaction in her voice is palpable.\n\n");
			if (prison.prisonIsRestrained())
			{
				outputText("As the door closes behind her, your restraints reappear.\n\n",false);
			}
			prison.changeEsteem(-5,prison.inPrison);
			prison.changeObey(1.5,prison.inPrison);
			flags[kFLAGS.PRISON_TRAINING_LEVEL]++;
			if (flags[kFLAGS.PRISON_TRAINING_LEVEL] > 3 && player.obey > 10 + rand(3))
			{
				player.changeStatusValue(StatusEffects.PrisonCaptorEllyStatus,1,2);
				flags[kFLAGS.PRISON_TRAINING_LEVEL] = 0;
			}
			flags[kFLAGS.PRISON_STUDY_MANNERS_UNLOCKED] = 1;
			inventory.takeItem(consumables.P_BREAD, camp.returnToCampUseOneHour);
		}
		
		public function prisonCaptorFeedingBJTrainingAccept(branchChoice:String = "choose"):void
		{
			clearOutput();
			var fastLearner:Boolean = false;
			var lustChange:int = 0;
			var doneChoice:Boolean = false;
			var begChoice:Boolean = false;
			fastLearner = false;
			if (branchChoice == "choose")
			{
				outputText("[if (esteem < 50) Being][if (esteem >= 50) Allowing yourself to be] taught to call her Mistress may have broken your spirit a bit, but not enough to make following this order even remotely easy. Still, ");
				if (player.hunger < 40)
				{
					outputText("a powerful combination of hunger and [if (esteem < 50) desire to avoid her anger][if (esteem >= 50) cautious self preservation] have coalesced into an uncomfortable resolution to do as you have been instructed.[if (esteem >= 70)  You'll do what's required to earn your meal, and then consider what to do next afterward.]");
				}
				else
				{
					outputText("having weighed your options, [if (esteem < 50) the consequences of upsetting her seem][if (esteem >= 50) the potential risk of disobedience seems] worth avoiding -- even considering what has been asked of you[if (esteem >= 70) -- especially if you can keep things from getting out of hand].");
				}
				outputText(" Despite having rationalized the decision, humiliation burns through your body like wild fire as you lean forward onto your hands and knees and lift your [ass] into the air. Watching intently from across the room, Mistress Elly beckons with two fingers as she sees you begin to move. \n\n",false);
				outputText("You reach forward with your left hand and lock your eyes on the ground directly below you.\n");
				outputText("You follow with your right hand and pull your [legs] forward behind you.\n");
				outputText("You reach again with your left hand, and notice your fingers wavering.\n\n");
				outputText("As you place it down, a shiver runs through your limbs, the stone floor cold against your flesh. As a single bead of sweat forms on your brow, you find yourself painfully aware of every movement your body is making, and time seems to slow to a crawl.\n\n");
				outputText("You imagine how you must look: face down, ass up, slinking on all fours, and part of you wants to just stop and ");
				if (player.esteem < 30)
				{
					outputText("curl up in shame");
				}
				else if (player.esteem < 70)
				{
					outputText("close your eyes");
				}
				else
				{
					outputText("stand back up");
				}
				
				outputText(". But you remember the demon across the room who is unlikely to tolerate that, as well as your resolution to appease her [if (esteem > 70) -- <b>this</b> time].\n\n");
				outputText("You move your right hand. Your stiffening muscles cause you to wobble as you move[if (hasCock = true)  and your [cock longest] slaps against your thigh].\n\n");
				outputText("Left hand. You move smoothly until your knee scrapes across a crack. Your eyes swim and the edge of your vision blurs, more from frustration than pain.\n\n");
				outputText("Right. Your palms begin to sweat, and you nearly slip as you shift your weight[if (biggestTitSize >= 3) , your [fullChest] swinging wildly between your arms].\n\n");
				outputText("Left. Desperately hoping you're almost there, you [if (esteem < 40) steal a glance][if (esteem >= 40) take a peek] up, and for a moment those leather clad legs seem farther away than when you began.\n\n");
				outputText("Right. Your breath becomes shallow and staggered; your pulse thumps in your ears.\n\n");
				outputText("Left...<b>Left</b>! You lift your left hand, but quickly set it back down in the same spot, unable to move it forward. [if (esteem < 60) Your throat knots in terror at your paralysis][if (esteem >= 60) You try again, but this time it will not even lift]; your arms have become quivering leaden masses.\n\n");
				if (player.esteem < 30)
				{
					outputText("All at once your resolve cracks. Tears form in your eyes, your torso convulses with a powerful sob, and all intelligent thought is blown away in a maelstrom of emotion. Disgrace, impotence,[if (corruption > 30)  arousal,] anger, degradation, and hopelessness all mix together and wash away any pretension of self determination you may have been harboring. You soak in it for a moment, but then the sound of an impatient booted toe tapping on the floor penetrates your misery and you realize you have no choice but to find a way to continue. You shake your head to clear away the flotsam, shakily pick yourself off the ground, take a deep breath, and begin again with steady, resigned purpose.");
				}
				else if (player.esteem < 70)
				{
					outputText("While you knew this would be a challenge, you didn't expect to find yourself on the verge of an emotional collapse a third of the way across the room. You draw your chin down to your chest, close your eyes, and focus on breathing deeply. You push back the rage,[if (corruption > 30)  the arousal,] the embarrassment, the overwhelming sense of helplessness. You remind yourself that while this is her game, it was your choice to play it, and you made it for good reasons. You open your eyes, look back up, ignore her raised eyebrow and sly, self satisfied smile, and fix your gaze once again on the floor just in front of you. Slowly, but with measured control, you move forward.");
				}
				else
				{
					outputText("You curse your body's rebellion, and hope that your moment of weakness was not as visibly obvious to your captor as you fear it might have been. You fix your gaze on the toes of her spike-heeled boots and set your jaw, willing away the rage[if (corruption > 30)  and the arousal] and the shame and panic that had threatened to overthrow you. You allow yourself a few seconds to sit with a clear mind, then proceed forward with steady, resolved purpose.");
				}
				
				outputText(" While you remain stiff and frigid, you manage to cross the remaining distance without letting your uncertainty overcome you again.\n\n");
				if (player.esteem < 15)
				{
					outputText("When you arrive at her feet you feet, though, you freeze up again and find yourself dumbly staring at her boots, mind blank and unsure what to do next. Mistress Elly responds to your hesitation by sliding one foot forward a few inches and clearing her throat. In a confused panic you make a guess at what she wants and lean down to kiss her toe. She chuckles, hooks her toe under your chin, and guides you upwards. You shift about awkwardly, and find yourself sitting back on your ass with your legs folded on either side of you.\n\n");
				}
				else
				{
					outputText("You arrive at her feet, exhale a sigh of resignation, and sit back on your ass with your legs folded on either side of you.\n\n");
				}
				outputText("You cannot help but feel [if (esteem < 40) small and powerless][if (esteem >= 40) humbled] as she looms over you, shoulders drawn back confidently, hands resting jauntily on her hips, tail swinging playfully between her legs. Although it has only begun to fill with blood, you find yourself having to crane your head to peer around her phallus and find her face. She looks down at you for a few beats, her expression a mixture of expectation, indulgence, and evaluation, then rolls her eyes in amused exasperation at your inaction.\n\n");
				outputText("\"<i>You've done well so far, dear, and the hardest part is over.</i>\" You are taken aback -- there is no note of condescension, no mocking undertones, no hint of ulterior motives. Her voice is simply kind, and her face genuinely caring. \"<i>Of course, before long you'll enjoy that part too; it gives you a chance to relish how shameful a creature you are.</i>\" ");
				if (player.esteem < 40)
				{
					outputText("You know her words should upset you, but as you realize you <i>are</i> in a rather shameful position, you actually end up[if (obey < 20)  a little] thankful that she pointed it out so gently. Your mind and muscles relax considerably as you are kept docile by her soothing tone and countenance.");
				}
				else if (player.esteem < 60)
				{
					outputText("You should be angry, but her soothing tone and countenance soften the blow of her words. Not wanting confrontation[if (obey > 20)  and not even that upset], you end up listening as politely as she speaks, both your muscles and mind softening under her gentle voice.");
				}
				else
				{
					outputText("You should be enraged by her words, but her soothing tone and countenance mitigate the insult. You dismiss her demeaning prediction, but still find your mind and muscles relaxing under her gentle voice.");
				}
				
				outputText(" \"<i>But now you get to have some fun. No really, you'll see -- you're going to enjoy  Begin by taking my shaft in your hands.</i>\"\n\n");
				outputText("Without thinking, you reach up and wrap your left hand around her girth. Even in her half-flaccid state your fingers barely touch your thumb as you tighten your grip. \"<i>Both hands, darling.</i>\" Your right hand follows the left, grabbing closer to the base, and you are amazed to note that there is room enough along her length that a third hand could fit comfortably as well. You are also surprised to find that the flesh of her cock is every bit as soft and silky as the rest of her skin, and the sensation of touching it is actually incredibly pleasant. Holding it this way has pulled the tip down almost level with your nose, and when you look back up for further direction you find it's dark, musky scent invading your nostrils. You begin to feel lightheaded. \"<i>Now, put it in your mouth. Just the tip, mind you.</i>\"\n\n");
				if (player.esteem < 30)
				{
					outputText("Fireworks of embarrassment explode across your cheeks, but you know you have no choice but to do as you are told.");
				}
				else if (player.esteem < 70)
				{
					outputText("You feel your cheeks flush with color, but push yourself to continue.");
				}
				else
				{
					outputText("You force your pride down, and commit to your plan.");
				}
				
				outputText(" You straighten your back as you reach upwards with your mouth and slide her cock head through your lips, stopping just before the flared crown. \"<i>Good [boy]. Now hold it there.</i>\" You do so, trying your hardest to ignore how enjoyable her skin felt gliding in, how good it still feels pressed between your lips, and how enticing the taste of it is as it gently pins your tongue to the floor of your mouth. There are all the expected earthy, natural flavors, but also something strangely sweet, almost like cinnamon. In the stillness of the moment this cacophony of sensory input throws your already light head into disarray, and it is only when you hear Mistress Elly peep with delight that your realize the tip of your tongue has begun to tentatively flick at the underside of her glans. \"<i>Patience, slave, we'll get there,</i>\" she says, but as she does she pushes forward ever so slightly.\n\n");
				outputText("Your lips slacken to accept the motion and the ridge of her head slips through the tight ring of your lips. Once again you attempt to remain still, but once again it''s not long before your tongue begins to act, teasing its way around the lower rim of the intruder. A soft moan escapes her lips, you feel her pulse quicken, and with every beat of her heart she swells, first stretching your lips into a wider 'O' shape, then forcing open your jaw to better accommodate her. Finally it seems to stop growing, but only when the upper ridge her cock is pressing into your palate despite the underside still being pressed firmly against your tongue. Salty precum begins to leak from her tip, and to your dismay it only seems to improve the taste of her flesh");
				if (player.esteem >= 40)
				{
					outputText(", gnawing at your resolution to remain dignified");
					if (player.hunger < 20 || player.cor > 40)
					{
						outputText(" and coaxing a telling growl from your stomach");
					}
				}
				else if (player.hunger < 20 || player.cor > 40)
				{
					outputText(", coaxing a telling growl from your stomach");
				}
				
				outputText(".Though you finally manage to suppress your tongue's efforts, it's too late.\n\n");
				outputText("\"<i>Ah, suddenly shy again? Listen to your body, slave. It knows what you are, and it wants so badly to show you.</i>\" Her body is now visibly filling with ardor, her ample bosom rising and falling with each deep breath, but her tone remains kind and supportive. \"<i>But I know you can overcome your nerves -- you have so much potential just waiting to be released. Now, pleasure the head. In and out, slowly.</i>\" [if (esteem < 30) With little hesitation, you][if (esteem >= 30) You hesitate briefly, but] pull back over the ridge and down the slope beyond until your lips are nearly closed around the tip.[if (esteem < 15)  The emptiness in your mouth feels odd, almost unpleasant, after having rested around the fullness of your Mistress' dick for so long, and you][if (esteem >= 15)  You consider waiting a moment to rest your jaw, but you guess Mistress Elly wouldn't approve. You push the thought aside, and] lean forward to once again fill your mouth.\n\n");
				outputText("With each subsequent stroke the knob becomes more slick with your saliva and her salty lubricant. As it does, the sensations of her skin slipping through your lips and over your tongue grow ever more enticing, and the taste of her flesh becomes maddeningly irresistible.[if (esteem < 60)  It takes all your willpower to remain composed and not lose yourself pumping away at her delectable shaft of meat.][if (esteem < 30)  Even still, you briefly indulge a lesser urge, moving your hand up to gather some of the growing slickness from the head and spreading  it down the barrel of her cock. You marvel at the feel of her unique skin between your fingers as you give her several deep squeezes.] But eventually, you manage to tune out your undesirable enjoyment of the act, delivering short, staccato strokes devoid of the passion growing in the back of your mind.\n\n");
				outputText("\"<i>You're fighting it again, slave,</i>\" she sighs as a look of disappointment clouds her previously blissful expression. \"<i>I was hoping your very obvious innate enjoyment of sucking dick would drive you to perform well, but clearly you need further encouragement to embrace it. That's okay; I'll just have to take a more hands on approach for the remainder of your lesson.</i>\" She rests her hand on your head, fixes her violet eyes on yours, and continues in a pedantic voice. \"<i>Now, keep your mouth around me, but place your hands behind your back.</i>\" You do so in a mechanical manner, but can't help but notice that this has forced you to arch your back and present your [chest] suggestively. \"<i>You are not to move your arms from that position until I say so. Is that understood?</i>\" ");
				if (player.esteem < 35)
				{
					outputText("Wilting under her demanding gaze, you shift your eyes down to her boots and mumble a sound of compliance around the bulge of flesh that fills your mouth.");
				}
				else if (player.esteem < 65)
				{
					outputText("Cowed by her demanding gaze, you meekly stare down the length of her shaft and attempt to nod your head. The gesture is somewhat clumsy, impaled as you are.");
				}
				else
				{
					outputText("You stare back at her in half hearted defiance, but her fierce gaze is enough to keep you from further action. The distracting sensations of her cock on your tongue are making it hard to mount any serious resistance.");
				}
				
				outputText("\n\n");
				outputText("\"<i>No, slave. Say, 'Yes Mistress, I understand.' </i>\"[if (esteem < 65)  She tilts your head back so that you are once again looking into her eyes.] One glance at her face is enough to tell you that she will accept nothing less that total submission on this matter.\n\n");
				outputText("\"<i>Yesth... Misth... treth... I undahh... thtand.</i>\" The sloppy sound of your voice sounding out the syllables brings color to your cheeks all over again[if (esteem < 20) , but now the unclean warmth is less distressing -- almost soothing][if (esteem > 60) , and you hope that this will placate her desire to degrade you for the time being].\n\n");
				outputText("\"<i>Much better. Always remember your manners, slave, especially when your mouth is full. Now, feel free to relax and enjoy this, but do pay attention: I expect you to learn your lesson well.</i>\" She reaches down");
				if (player.hornType > 0 && player.horns > 1)
				{
					outputText(" and grabs you firmly by your horns");
				}
				else if (player.hairLength >= 10)
				{
					outputText(", gathers your [hair] up into pigtails, and grips them firmly");
				}
				else
				{
					outputText(" and gets a firm grip on your ");
					switch(player.earType)
					{
						case 1:
							outputText("horse-like ears");
							break;
						case 2:
							outputText("pointed dog-ears");
							break;
						case 3:
							outputText("rounded cow-ears");
							break;
						case 4:
							outputText("cute pointed ears");
							break;
						case 5:
							outputText("fuzzy cat-ears");
							break;
						case 6:
							outputText("ear bumps");
							break;
						case 7:
							outputText("floppy rabbit ears");
							break;
						case 8:
							outputText("furred kangaroo-ears");
							break;
						case 9:
							outputText("large fox ears");
							break;
						default:
							outputText("ears");
					}
				}
				
				outputText(". Making use of her new handles, she begins to gently pull your [face] toward her. With meticulous care she pushes her rod into your mouth one millimeter at a time, backing off the moment even the slightest bit of discomfort shows on your face. \n\n");
				outputText("\"<i>I told you I would ease you into this, slave, and I keep my promises. Remember that.</i>\" Indeed, aside from the a slight ache in your jaw due to being stretched so wide, an eternity passes where your entire awareness is consumed by the agonizingly alluring feel of her slick, silky skin slowly invading your mouth. ");
				if (player.cor > 25)
				{
					outputText("To your chagrin, you find yourself daydreaming about how wonderful it would feel to have your ");
					if (player.hasVagina())
					{
						outputText("[cunt]");
					}
					else
					{
						outputText("[asshole]");
					}
					outputText(" violated in the same way. ");
				}
				outputText("Finally, with barely more than a third of her length inside your mouth, you feel her tip press against the entrance to your throat. She stops pulling, but continues to hold your head in place.\n\n");
				outputText("\"<i>There's a good [boy]. See? It's not unpleasant at all when you submit and let it happen.</i>\" Her almond shaped eyes narrow, one eyebrow arches, and the corner of her mouth curls upward. \"<i>Quite the opposite, it seems to me. Now, slave, practice breathing.</i>\" \n\n");
				outputText("You override your reflexive reaction to breathe through your mouth by pressing your lips and tongue tight against her inviting flesh, and inhale deeply through your nostrils. Your senses are flooded with her intoxicating scents, flavors, and textures, and you hold the breath longer than you intend to while involuntarily savoring the illicit rush. You release it, then repeat the act with unexpected zeal, eyes rolling back, lids closing, and mouth salivating.[if (esteem < 30)  To your extreme shame, you realize that your lips have begun to pucker and squeeze around her girth, and that your tongue is making luxurious undulations against the shaft that pins it down, as if to wring it of its sweet and savory essence.]\n\n");
				outputText("On the third intake of air, something even more odd happens: what feels like a thick, velvet rope wraps around your torso and rubs you with an upward motion, as if encouraging the action of your diaphragm. As you exhale, it massages back down. The sensation is not at all unpleasant, but distracting curiosity pulls you from your reverie. When the velvety massage again follows your fourth breath, you rotate your head sideways in her grip in order to glance downwards. From the corner of your vision, you see that the rope is actually Mistress Elly's agile tail, reaching forward through her legs to stimulate you.\n\n");
				outputText("\"<i>Focus, dear. It is important for you to learn this lesson well.</i>\" You breathe again, and again her tail softly follows the motion with its calming and supportive hug, instantly transforming from a distraction into one more delightfully effective piece of her unrelenting sensory assault. This happens several more times, and soon you are unsure if the tail's relaxing motion is reinforcing your breathing or controlling it as you fall into an aroused trance. \"<i>Good [boy].</i>\" Taking advantage of your weak and malleable state, she begins to move your head again, all the while continuing to coach your breathing with the comforting movements of her smooth tail. At first she moves you only the smallest bit, and inch out (exhale), and then an inch back in (inhale), then two inches out (exhale), and two inches in (inhale). \n\n");
				outputText("But as you grow accustomed to her rhythm, her inward strokes begin to push further and her outward ones retreat less, while your breaths grow deeper and the dizzying wait between them grows longer. You make an effort to push back your receptive daze, but only manage to reclaim enough of your consciousness to stare down the bridge of your nose at the hypnotic thrusting of her olive skinned rod. In a fleeting lucid moment you note that the shallowest point of her stroke is now the depth where she was previously teaching you to breathe. At the bottom of one stroke you can still see half of her cock[if (esteem < 15)  and your eyes widen at the thought of taking more][if (esteem > 50)  and you wonder how much more will fit], then at the bottom of the next [if (esteem < 15) you are overcome with relief when ][if (esteem > 50) you are amazed at your capacity when ]you barely see more than a third.\n\n");
				outputText("As she finally bottoms out and your nose presses into her smooth, sweet smelling public mound, a conflagration ignites beneath your thoroughly conquered senses. You find yourself verging on orgasm and your eyes roll skyward, your visage rather obscene thanks to the tight, hairless testicles on your chin and the dramatic bulge in your neck.\n\n");
				outputText("A tickle at your groin suggests the source of the lusty spark; somewhere in the build up she must have begun teasing and rubbing at your ");
				if (player.hasVagina())
				{
					outputText("[clit]");
				}
				else if (player.hasCock())
				{
					outputText("[cock biggest]");
				}
				else
				{
					outputText("sensitive nether region");
				}
				
				outputText(" with the spaded tip of her clever tail. [if (esteem < 40) You briefly wonder if you might have resisted][if (esteem >= 40) You wish you had noticed in time to resist], but the damage is done.\n\n");
				outputText("She confidently holds her entire length buried within you, and even though stars flash in your eyes and your lungs burn, you hear yourself wasting precious oxygen on a moan -- not of pain, or anguish, or rage, but of pleasure -- begging for more. You make ");
				if (player.esteem < 30)
				{
					outputText("a meager");
				}
				else if (player.esteem < 70)
				{
					outputText("a worthy");
				}
				else
				{
					outputText("a desperate");
				}
				
				outputText(" effort to restrain it, but as the long, lewd noise slowly escapes your lips, you ");
				if (player.esteem < 30)
				{
					outputText("shamefully");
				}
				else if (player.esteem < 70)
				{
					outputText("reluctantly");
				}
				else
				{
					outputText("furiously");
				}
				
				outputText(" admit to yourself that [if (esteem < 10) she has won this encounter][if (esteem >= 10) the situation has escaped your control]. The disheartening thought is barely finished, though, when your body grabs you in a riptide of need -- just as your mind was scrambling free of the previous wave's wake.\n\n");
				outputText("Mistress Elly echoes your moan with an utterance of her own, the grunt of a master chef tasting a successful new recipe for the first time. With all the tenderness and patience with which she began the process, she slowly draws her dick up and out of your throat, letting you once again savor the sensations of her skin gliding past yours. As the blockage slips past your windpipe her tail once again guides your breathing with its velvet hug, but thanks to the continuing ministrations of the tail's tip you barely notice the rush of air returning to your lungs. Instead you find yourself enthralled by her cock's movement, licking slavishly at the knob as it grinds past, and sucking with such greed that that there is a wet, audible pop as she pulls it through the seal formed by your lips.\n\n");
				outputText("She holds your [face] several inches from her cock head, strands of saliva and precum dripping between her tip and your lips. Several times you feel yourself try to lean forward, but her firm grip stops you. Unhappy with being so denied, your tongue makes a desperate attempt to close the gap on its own, spurred on by her tail's merciless teasing of your sex. Momentarily shocked back to your senses by your wanton behavior, you [if (esteem < 30) hope that you can][if (esteem >= 30) make a silent vow to] remain more dignified the next time you find yourself in this position.\n\n");
				outputText("As if sensing your internal conflict, she asks, \"<i>Are you enjoying yourself, dear?</i>\" The words drip with sultry bravado. Already slipping back into your lust-induced stupor, you reply \"<i>Yes, Mistress</i>\" with ");
				if (player.esteem < 40)
				{
					if (player.obey < 20)
					{
						outputText("abashed sincerity");
					}
					else
					{
						outputText("unabashed sincerity");
					}
				}
				else if (player.esteem < 60)
				{
					outputText("a sincerity that shakes your confidence in yourself");
				}
				else
				{
					outputText("a haste that makes you uncomfortable");
				}
				
				outputText(".\n\n");
				outputText("\"<i>Do you think we're done, or would you like me to teach you more?</i>\"\n\n");
				if (player.esteem > 60)
				{
					outputText("You remember your initial resolve when choosing this course of action -- and this may be your last chance to act on it -- [if (will < 15) but you're not sure you could resist her if you tried, in your current state][if (will >= 15) but her allure is almost overwhelming]. You've already gone so far; it would be so easy to just give in and go a little further...[if (obey >= 20) or even submit entirely -- just this once.]\n\n");
					doneChoice = true;
				}
				else
				{
					outputText("You tremble, silent for a moment as your pride fights desire for your answer. Overwhelmed as you are, though, you fear you already know which is winning...[if (obey >= 20) the only question left is whether or not you embrace it.]\n\n");
				}
				if (player.obey >= 20)
				{
					begChoice = true;
				}
				outputText("\n\n");
				menu();
				if (doneChoice) addButton(0, "Done", prisonCaptorFeedingBJTrainingAccept, "done");
				addButton(1, "More...", prisonCaptorFeedingBJTrainingAccept, "more");
				if (begChoice) addButton(2, "More!", prisonCaptorFeedingBJTrainingAccept, "beg");
				return;
			}
			if (branchChoice == "done")
			{
				if (player.obey < 20)
				{
					outputText("A voice inside you roars that yes: you're done, but you cannot quite externalize it. Gears grind desperately in your mind as your eyes remain fixed on Mistress Elly's hypnotic cock, jaw quivering as your pride fights desire for your answer. Drawing in a short breath, you strain your mouth open to speak your objection, only to hear a pleased titter above you. \"<i>Ah -- that looks like a 'Yes, Mistress' to me!</i>\" Your imminent refusal is lost in surprise as you feel her grip close around you again.\n\n");
				}
				else
				{
					outputText("A voice inside you declares yes: you're done, but you struggle to externalize it. Even as gears grind desperately in your mind, you actually feel yourself nodding your assent for more.\n\n");
					outputText("\"<i>Uh-uh,</i>\" your Mistress chides above you. \"<i>If you want it, ask for it.</i>\" Her demand actually fans your resistance, though, and despite your lost speech, you tilt your head up to express your refusal.\n\n");
					outputText("But as you meet her gaze, she tilts her head invitingly and your resolve lasts only a moment before dissolving from a quickening of her tail's caress. She smirks, giving her cock just enough of a flex to flick over your lips, and an encore of your immodest moan ascends your throat. Though you make an effort to suppress it, the final, needy whine is even more telling of your desire.\n\n");
					outputText("Tears well in your eyes as her succulent lips mouth the answer she expects: \"<i>More. please. Mistress,</i>\" she enunciates crisply. Your own lips, jaw, and tongue obediently echo her words, but you manage to restrain your voice from joining them. Her eyes flicker for a moment, as if in contemplation. Pre-empting any further indignity she might demand, you employ the curious reprieve to take a deep breath, focus, and muster your <i>real</i> answer. You're <b>done.</b> \n\n");
					if (player.will < 15)
					{
						outputText("You open your mouth ready to object, but waver, more of your thoughts turning to the musky pre-cum on your lips...the gentle tail on your flesh -- \"<i>More please, Mistress,</i>\" you abruptly beg in spite of yourself. Your heart sinks as you realize your lapse, not to mention the triumph in her widening smile.");
					}
					else
					{
						outputText("\"<i>Aw, lost your voice? I guess that'll have to do, then,</i>\" she decides abruptly, taking you in her grasp before you have time to object. ");
					}
				}
			}
			else if (branchChoice == "beg")
			{
				if (player.esteem < 45)
				{
					outputText("Some far, far away part of you wanted this to be as quick and pastel as possible, but you know exactly what <i>she</i> wants, and right now you want to give it to her more than you ever imagined.");
				}
				else if (player.esteem < 60)
				{
					outputText("Some part of you wanted to be done with this, knowing you've endured enough indignity, but you accept that all you want right now is another mouthful of her soft, slick, delectable flesh.");
				}
				else
				{
					outputText("A quiet voice whispers that you didn't want this, but you ignore it. Humiliation and indignation burn through you as your lips begin to move, but -- if only for now -- you look past them and into the welcoming inferno of desire.");
				}
				
				outputText("\"<i>More!</i>\" you declare in a breathless tone. Elly's eyes flicker with genuine surprise at your desperation, and for a moment you ");
				if (player.esteem < 30)
				{
					outputText("worry you've done something wrong");
				}
				else if (player.esteem < 60)
				{
					outputText("worry she's going to deny you");
				}
				else
				{
					outputText("smolder in your shameful need");
				}
				
				outputText(" before she merely lifts an eyebrow in gentle reprisal.\n\n");
				outputText("\"<i>Manners, slave,</i>\" she chimes through a growing smile, her expression settling into one of ");
				if (player.esteem < 30)
				{
					outputText("amused endearment as she locks on your own pleading");
				}
				else if (player.esteem < 60)
				{
					outputText("predatory delight as she locks on your own enchanted");
				}
				else
				{
					outputText("content curiosity as she locks on your own far away");
				}
				
				outputText(" gaze. You do not even notice her heel touch the floor, but it draws a soft, familiar tap.\n\n");
				outputText("\"<i>More please, Mistress!</i>\" you answer in earnest, ");
				if (player.esteem < 35)
				{
					outputText("your needy, dampening eyes begging even more than your voice.");
				}
				else if (player.esteem < 60)
				{
					outputText("mouth drifting open in awed anticipation.");
				}
				else
				{
					outputText("trying not to focus on how good it felt to say it.");
				}
				
				outputText(" ");
			}
			else if (player.esteem < 30)
			{
				if (player.obey < 20)
				{
					outputText("Caught in the moment, a shudder of anticipation passes over you, and you look up at your Mistress with a desperate expression. Some far away part of you wanted this to be as quick and pastel as possible, but you know exactly what <i>she</i> wants, and find your heart pounding away your ability to deny it.\n\n");
					outputText("Giving in, you try to form the words to convey this, but end up spouting a nonsensical string of needy, monosyllabic whines. Your eyes water as you realize you're not even strong enough to <i>submit</i> correctly. Her chuckling does not improve your confidence, though she does finally provide some direction. \"<i>I think what you are trying to say, slave, is 'More please, Mistress.'</i>\"\n\n");
					outputText("Your head bobs in a reflexive nod and you make an attempt to steady your quivering jaw, but the words still tumble out in a fractured mess of saliva. \"<i>M-m-more pleas-se, M-mis-mistress.</i>\" With another chuckle, she leans down a little, brushing a fiery bang aside to cup a hand over her ear.\n\n");
					outputText("\"<i>What was that, slave? I couldn't quite hear you.</i>\" She fixes you with a patient, encouraging gaze absent of any derision. The earnest support catches you off guard, but the cool violet pull of her eyes becomes an aid, leading you just far enough from your lusts to regain control of your enunciation.\n\n");
					outputText("\"<i>More please, Mistress,</i>\" you cry emphatically, feeling a sense of relief as a satisfied smile spreads across her lips. ");
				}
				else
				{
					outputText("Caught in the moment, a shudder of anticipation passes over you, and you look up at your Mistress with a desperate expression. Some far away part of you wanted this to be as quick and pastel as possible, but you know exactly what <i>she</i> wants, and find your pounding heart inclined to agree.\n\n");
					outputText("Noticing your head softly bobbing your assent already, you try to form the words to match. Need has overwhelmed your ability to speak, though, and you end up merely mouthing them in desperation, your throat and jaw seeming far away. \"<i>You need to actually say it, dear,</i>\" she chides playfully. Straining to respond, you summon the noise, but no articulation, crafting little more than a pleading moan. The edges of your vision blur as you glance up at her[if (esteem < 15)  in a mix of apology and appeal].\n\n");
					outputText("\"<i>Did I not just teach you this, slave? <b>Breathe</b>.</i>\" Though her tone is slightly admonishing, her expression is transparently amused, mitigating your concern somewhat as her tail further constricts your torso and jolts downward, wringing you of a hollow sigh, before ascending considerably more gently, coaxing you into a long, deep inhale. \"<i>Now, dear, what was it you wanted to say?</i>\"\n\n");
					outputText("As her tail slides down again, you use the momentum to make your request: \"<i>M-more please...</i>\" It feels surprisingly calming to let her tail draw the words from you, but the sensation is disrupted as it tugs back up -- somewhat painfully. \"<i>Manners...</i>\" she reminds sternly, but with a kind smile, her countenance significantly softer than her gesture. [if (esteem < 15) You give her a penitent gaze as her][if (esteem >= 15) Her] tail drops again.\n\n");
					outputText("\"<i>More please, Mistress,</i>\" you cry eagerly, feeling a rush of euphoria [if (esteem < 10) until her proud, delighted expression flickers for a moment into something...predatory][if (esteem >= 10) as a satisfied -- even proud -- smile spreads across her lips].\n\n");
					if (player.esteem < 10)
					{
						outputText("\"<i>Say it again, dear,</i>\" she demands abruptly. You blink, blushing a little more that she's making you repeat yourself, but you do find it easier this time, managing to intone the phrase almost flawlessly.\n\n");
						outputText("\"<i>More please, Mistress.</i>\"\n\n");
						outputText("\"<i>Good [boy]. Again.</i>\" Your heart quickens as you worry you may have done something wrong, but as you move to glance away and collect yourself her hand is already on your chin, keeping it in place. \"<i>Look at me, dear, and say it <b>again</b>.</i>\" Your eyes drift back to hers, half expecting a sharp strike of her heel to flood your ears, but none comes. She merely looks at you, patiently and supportively -- but expectantly -- as your tentative gaze traces the edge of her almond sockets for fear of the violet orbs themselves.\n\n");
						outputText("\"<i>...More please, Mistress.</i>\"\n\n");
						outputText("\"<i>And again...</i>\" Air slides into your lungs as her tail relaxes, returning your control over your breathing. You're thankful at first, but immediately realize that the control is a liability as you again struggle for words. Your recall your pleading expression, but this time she merely shifts her lips, mouthing soundlessly: <i>Breathe</i>. You inhale to your best ability, trying to imagine her tail guiding your diaphragm, and speak.\n\n");
						outputText("\"<i>M-More...please...Mistress.</i>\" You wince at your own vocal stumbling, but before you can even think of a way to make it up to her, she moves on.\n\n");
						outputText("\"<i>Again.</i>\" Relieved by her leniency, you manage to repeat it without delay and with significantly more stability. Another rush of euphoria passes through you, and you find yourself more proud of your accomplishment than ashamed that you are being made a plaything by your demon kidnapper.\n\n");
						outputText("\"<i>Good [boy],</i>\" she whispers, kneading her thumb into your cheek as her tail constricts again. You shudder in comfort, only fully appreciating the difficulty of your own breathing and speaking once eased back into her spade-tipped guidance. Her expression flickers once more. \"<i>Now <b>look at me</b>.</i>\"\n\n");
						outputText("Already idly following her almond contours, your eyes can't help but center on hers as they jump from the sudden instruction. Fixed in your vision with two violet anchors, her gentle expression has lost most of its patience, and replaced its endless encouragement with cold, raw, command. You feel yourself freeze under the penetrating stare, and worry you would suffocate if not for her tail. She has lost none of her kindness, though.\n\n");
						outputText("\"<i>Can you hear me okay?</i>\" You nod as best you can, the gesture still so timid that it is barely visible.\n\n");
						outputText("\"<i>Can you breathe alright?</i>\" You nod again -- this time with a bit more vigor.\n\n");
						outputText("\"<i>Can you still speak?</i>\" You nod again, and with the help of her tail even manage to offer a whisper of affirmation.\n\n");
						outputText("\"<i>Good. In that case, I want you to say it again -- one more time -- and <b>mean it</b>.</i>\"\n\n");
						outputText("Your eyes can't help but widen, body straining under what it understands as the magnitude of her request, but your mind is made up -- with or without you --  even as your thoughts trail on. Her inviting gaze... her encouraging voice... each tug of the spade-tipped leash against your chest and loins... Of course you want more -- why wouldn't you mean it?\n\n");
						outputText("Color floods your cheeks and warmth your body as the words escape your lips, while her own curl into a caring but unmistakably prideful smirk. \"<i>Good [boy].</i>\"\n\n");
						fastLearner = true;
					}
				}
			}
			else if (player.obey < 20)
			{
				outputText("A large part of you wants to be done with this, knowing you've endured enough indignity, but despite your efforts you can't quite overcome the lust running through you or shake your recollection of your captor's soft, slick, delectable flesh. Your mouth opens to answer for you as you think about giving in, but your lingering pride constricts your answer into an indecent grunt of assent.\n\n");
				outputText("After waiting a moment with nothing else to say, you hear a light sigh in response to your mixed noise. \"<i>No mumbling, slave -- commit to it,</i>\" she says gently but firmly, and gives her cock just enough of a flex to flick over your lips. You try to be angry, but your mind nearly blanks out from the renewed sensation.\n\n");
				outputText("\"<i>More,</i>\" you bark, the extra serving of her precum lending you some temporary focus. You say nothing else, dumbly drooling as you gaze at her imposing member. Another sigh, less patient. \"<i>Manners, slave,</i>\" she responds sternly, her heel lightly tapping the stone floor; there is a soft, familiar click.\n\n");
				outputText("\"<i>More please...</i>\" you mutter, your heart fluttering with the faint pulse of adrenaline as your eyes remain fixed on her hypnotic cock. Another sigh, and this time she sounds even less pleased. The next thing you hear is a sharp, harsh clack, and the ringing in your ears brings you out of your stupor just enough to fully indulge her.\n\n");
				outputText("\"<i>More please, Mistress,</i>\" you whisper. Another clack. You blink.\n\n");
				outputText("\"<i>More please, Mistress!</i>\" you shout with almost embarrassing volume, cheeks flushing as your subdued dignity offers one last flicker.\n\n");
				outputText("You hear a triumphant chuckle. ");
			}
			else
			{
				outputText("Some part of you wants to be done with this, knowing you've endured enough indignity, but no matter your efforts you can't overcome the lust running through you or shake your recollection of your Mistress's soft, slick, delectable flesh -- and another part of you no longer wants to. That part keeps telling you it wouldn't be so bad to mindlessly nurse at her cock all day, rendering her offer increasingly difficult to deny. But it's also difficult to accept, with her overwhelming presence stifling your ability to speak. You settle for a nod -- significantly more eager than you'd like -- hoping it effectively conveys your assent for more.\n\n");
				outputText("\"<i>Uh-uh,</i>\" your Mistress chides above you. \"<i>If you want it, ask for it.</i>\" Her demand actually fans your resistance, but even that is not enough for you to overcome your body's enkindled state. When she gives her cock just enough of a flex to flick over your lips, your defiance dissolves into a compulsion to vocalize your need.\n\n");
				outputText("\"<i>More...</i>\" you moan breathlessly, and see her foot tilt gently off the floor. You think you know what's coming, and think you're better off pre-empting it than suffering another shock to your psyche at the moment.\n\n");
				outputText("\"<i>Please...</i>\" you amend, barely succeeding at keeping your attention on her feedback while her hypnotic cock dangles right in front of you. You manage to pull your eyes away from it for a moment and look up at her. Her head is tilted in a curious expression, a thin smile spreading across her face.\n\n");
				outputText("\"<i>Almost, slave, but aren't you forgetting something?</i>\"\n\n");
				outputText("\"<i>More...please...uh.</i>\" You try and complete the phrase, fumbling for words as the maelstrom of intoxicating sensations beats against what few shelters of dignity you have left. Then, without any further prompting, it suddenly becomes clear.\n\n");
				outputText("\"<i>More please, Mistress,</i>\" you say with some stability. She smiles with a hint of pleasant surprise, and while you never saw her raise it, you notice her heel meet the floor without the slightest sound.\n\n");
			}
			
			
			
			outputText("\"<i>I knew there was an eager student hiding inside you. Now, [if (esteem < 30) dear][if (esteem >= 30) slave], pay attention and you will learn how to properly receive my seed.</i>\" Before she finishes the sentence, she has pulled your head back onto her cock and her balls are once again pressed against your slimy chin. She holds you there until you are close to blacking out once more, and then begins moving your head in long, sumptuous strokes. With each one she pulls her knob all the way back to the opening of your mouth, giving you a second to worship it with your tongue, then with gentle force feeds you her entire length all over again. [if (esteem < 60) As a testament to how well she has prepared you,][if (esteem >= 60) As proof of the hidden talents she claims to see in you,] this treatment is far from the uncomforable experience you would have expected it to be. Aside from mild stretching and a feeling of being overfull, your gullet receives her pounding as if you were made for it.\n\n");
			outputText("As you fall back into your previous fugue state, her teasing at your ");
			if (player.hasVagina())
			{
				outputText("[clit]");
			}
			else if (player.hasCock())
			{
				outputText("[cock biggest]");
			}
			else
			{
				outputText("mound");
			}
			
			outputText(" becomes unbearable. You begin to creep your hands back around to the front of your body, intent on giving yourself the release she is denying you. The second your shoulders go slack, though, she delivers a sharp slap to your right cheek, then resumes her fucking with increased vigor. \"<i>You haven't... earned... the right... to do that yet... slave.</i>\" Her voice is like a whip as she delivers the reproach in time with her strokes. You pull your arms back, incapable of any other response, and struggle to endure the torture as her tail redoubles its efforts. \n\n");
			outputText("Soon you feel her grow stiff in your throat, and she erupts with one final, powerful stroke. Her testicles begin to twitch against your chin, and wave after wave of bulges travel though your lips, squeeze past your billowing tongue, and pump their way down your throat to pour straight into your stomach. Before long you are full to bursting and you feel her seed creeping its way back up your esophagus and into the back of your mouth. At this point she smoothly withdraws so that just the tip of her cock remains inside your mouth. Even though the waves begin to abate, she still manages to fill your mouth such that your cheeks balloon with her cum and a steady stream leaks through the ring of your lips locked around her head. \"<i>Do not swallow until I tell you to, slave.</i>\" Then, with your tongue drowning in a sea of her briney load, she fully withdraws and delivers her last few white ropes across your [face] and into your [hair].\n\n");
			outputText("\"<i>An admirable effort, [if (esteem < 30) dear][if (esteem >= 30) slave].</i>\" she says, as she unceremoniously drops you to the floor. The sudden impact winds you and a good portion of her bounty sprays from your mouth, but you hold tight to what remains. ");
			if (player.esteem < 35)
			{
				outputText("After what you just experienced, you aren't going to upset her by failing to meet her expectations now.");
			}
			else if (player.esteem < 65)
			{
				outputText("With your body still dominated by arousal and your ego brutally beaten, you want to avoid upsetting her -- if only to gain enough time to process whatever just happened.");
			}
			else
			{
				outputText("Until you have time figure out how this situation got so far out of your control, you decide it's best to continue to show her the perverse respect that she wants from you.");
			}
			
			outputText(" And so you lie still, defiled cheek resting in the sticky pool dribbling from the corner of your mouth, arms still held behind your back crushing your [chest] to the floor, [nipples] hard and chafing against the cold stone. \"<i>You may swallow when I have left the room; consider it a gift for your good behavior at the end. Still, I'm afraid you'll need to perform that way the entire time if you want to earn a meal beyond a simple bowl of soup.</i>\"\n\n");
			outputText("Out of thin air she produces a pitiful loaf of bread and crumbles it into a bowl. With a smile of supreme satisfaction, she begins to milk her cock into it. Before long, the bowl is overflowing with her sticky seed, making you wonder if there is any end to her supply. She sets it on the ground and gives you a playful wink before leaving you alone in the cell.\n\n",false);
			if (prison.prisonIsRestrained())
			{
				outputText("As the door closes behind her, your restraints reappear.\n\n",false);
			}
			player.slimeFeed();
			player.refillHunger(5);
			prison.changeEsteem(-3,prison.inPrison);
			prison.changeObey(1.5,prison.inPrison);
			lustChange = 100;
			dynStats("lus", lustChange);
			flags[kFLAGS.PRISON_TRAINING_LEVEL]++;
			if (flags[kFLAGS.PRISON_TRAINING_LEVEL] > 4 && ((fastLearner && player.obey >= 25) || (player.obey > 25 + rand(6) - (flags[kFLAGS.PRISON_TRAINING_LEVEL] * 2))))
			{
				player.changeStatusValue(StatusEffects.PrisonCaptorEllyStatus,1,3);
				flags[kFLAGS.PRISON_TRAINING_LEVEL] = 0;
			}
			flags[kFLAGS.PRISON_STUDY_BREATHING_UNLOCKED] = 1;
			inventory.takeItem(consumables.P_BREAD, camp.returnToCampUseOneHour);
		}
		
		public function prisonCaptorFeedingBJTrainingPerform(branchChoice:String = "choose"):void
		{
			clearOutput();
			var lustChange:int = 0;
			var titChoice:Boolean = false;
			var cuntChoice:Boolean = false;
			var itemSelector:int = 0;
			if (branchChoice == "choose")
			{
				outputText("You reach a[if (esteem >= 40)  bold but] difficult[if (esteem < 40)  and desperate] decision. ");
				if (player.hunger < 40)
				{
					outputText("If you want to have any hope of withstanding Mistress Elly's relentless siege of your free will, you need to take the edge off your [if (esteem < 60) demoralizing][if (esteem >= 60) distracting] and seemingly ever present hunger. But to do that, you are going to have to open the gate for the time being and");
				}
				else
				{
					outputText("You know that to earn her satisfaction and an untainted meal, you're going to have to commit to doing this well and right. So, as much as her demands weigh on you, this time you are going to [if (esteem < 60) make an extra effort][if (esteem >= 60) bear the indignity] and");
				}
				outputText(" do as she has instructed[if (corruption > 25)  -- perhaps even a bit more]. ");
				if (player.esteem < 30)
				{
					outputText("You're not certain you can really convince her without suffering some indignity, but even if something goes wrong, you'll hopefully be fed and she'll hopefully be happy with you.");
				}
				else if (player.esteem < 60)
				{
					outputText("After all, while you realize it may be foolhardy to engage an Omnibus in a sex game, maybe you can make some progress or gain an advantage by taking initiative. Either way, your efforts should at least earn you a decent meal.");
				}
				else
				{
					outputText("She may appear to get what she wants, but you'll be the architect of your fate regardless of the concessions your body has to make.");
				}
				
				outputText("\n\n");
				if (player.cor < 30)
				{
					outputText("Even having [if (esteem < 30) made the difficult rationalization][if (esteem >= 30) reached your difficult resolution], though, lighting the spark to act is still a challenge. You spend a long moment with your eyes closed, searching within for courage and inspiration, ");
					if (player.esteem < 30)
					{
						outputText("but despite your decision, the thought of actually crawling over to her with such enthusiasm is paralyzing, and you can find nothing inside of yourself [if (hunger > 60) -- not even your hollow stomach --] to reconcile that. As you open your eyes, though, you see her staring straight at you. Her countenance is not the impatient, demanding terror that you expected for your hesitation, but a kind, inviting grin. She gently taps her knee in beckoning, but maintains a relaxed stance, seemingly more curious as to if you'll approach than insistent on it.\n\n");
						outputText("In the back of your mind, you know she's a demon with all the perversion and cruelty and evil attached, but none of that shows in the woman waiting for you across the room; you think you can bring yourself to go to <i>her</i> -- at least. ");
					}
					else if (player.esteem < 60)
					{
						outputText("but despite your decision, it's difficult to actually immerse yourself in the depravity. You imagine her sneers and taunts and yourself pretending not to notice -- or <i>enjoy it</i> -- and you just can't. But when you open your eyes, none of that is there. She's clearly confident in her position with one hand on her hip and the other idly twirling a fiery bang, but for now she looks content to allow you to follow her orders at your own pace without comment, and you promised yourself you wouldn't balk at that. ");
					}
					else
					{
						outputText("but while you can endure the play-acting, you still hesitate, knowing every weapon in her arsenal is made to wring more out of you. You have your merits and virtues, but you tense with the knowledge of the tendency of demons to bind their victims with every inch they're given. You open your eyes to less of a demon, though. Small horns and human features... no eldritch organs or feeling of irrevocable taint with her every touch. There's no doubting her nature, but she's certainly a different manifestation of it, maybe even one you can handle. As if responding to your appraisal, she tilts her head and raises an inviting eyebrow: a taunt -- perhaps a challenge -- but one you're ready to meet. ");
					}
					
				}
				else
				{
					outputText("And once you have made the difficult decision, finding the inspiration to act on it is much less of a challenge. ");
					if (player.esteem < 30)
					{
						outputText("Her intentions aside, it is difficult to deny her unearthly, enthralling beauty and charm as she stands confidently with her right hand on her hip and her left absentmindedly teasing her long, fiery bangs. Noticing your inadvertent adoration, she gives a curl of hair a bewitchingly playful flick and reaches her left hand forward to beckon you saucily. Heart beating a little faster than you expected, you find the nerve to begin your performance. ");
					}
					else if (player.esteem < 60)
					{
						outputText("Regardless of how you feel about her crusade to crush your spirit, she does have a certain allure just standing with her right hand on her hip and her left absentmindedly teasing her long, fiery bangs. Noticing your gaze, she gives a curl of hair a bewitchingly playful flick and reaches her left hand forward to beckon you saucily. That's all the encouragement you need to go ahead with your performance, even if you might not be in the exact position you wanted. ");
					}
					else
					{
						outputText("While you may not always see eye to eye, she is a creature of exotic beauty and charm, and under many other circumstances you might actively and willingly pursue as a sexual partner. As if responding to your appraisal, she tilts her head and raises an expectant eyebrow: an invitation -- perhaps a challenge -- and one you're actually somewhat enthused to meet. ");
					}
					
				}
				outputText("Thus encouraged, you reach forward[if (corruption > 25)  with all the flirtatious grace you can muster] and start to crawl towards [if (obey >= 20) your Mistress][if (obey < 20) her].\n\n");
				outputText("The stone floor is cold and harsh beneath you as you move, but you ignore the discomfort and attempt to lose yourself in your act. You set your face into a mask of suppliant desire, chase away your lingering [if (corruption < 20) self-consciousness][if (corruption >= 20) uncertainty], arch your back suggestively, and quickly find sultry tempo in your movement. With each pull of an arm you swing your [ass] heavily in the opposite direction");
				if ((player.hasCock()) || player.biggestTitSize() > 2)
				{
					outputText(", and the resulting shifting of your weight causes ");
					if (player.hasCock())
					{
						outputText("[eachCock] to slap lewdly back and forth between your thighs");
					}
					if ((player.hasCock()) && player.biggestTitSize() > 2)
					{
						outputText(" and");
					}
					if (player.biggestTitSize() > 2)
					{
						outputText(" your [fullChest] to bounce and jiggle beneath you");
					}
					outputText(". While humiliating, displaying your endowments this way gives you a[if (corruption < 20) n unsettling but] much needed burst of confidence.");
				}
				else
				{
					outputText(", trying your hardest to exude the compliant sensuality that she wants to see.");
				}
				outputText(" You bow your head deferentially as you crawl, but fix her with doe eyes so you can furtively watch her face as you go. Her approval is plainly growing by the time you are halfway to her feet, so you redouble your efforts as you continue. She beams you a knowing smile, then leans forward cheerfully and claps her hands against her thighs.\n\n");
				outputText("\"<i>Oh, what a good [boy] you are!</i>\" she calls out, as though she was congratulating a well behaved puppy. \"<i>That's it, just little further and you can enjoy your treat.</i>\" You blush [if (esteem < 60) wildly ][if (esteem >= 60) angrily ] at the appalling implication, but only after a[if (esteem < 60) n unexpected] shiver of pride rushes down your spine in response to her demeaning praise. ");
				if (player.tailType > 0 && player.esteem < 60)
				{
					outputText("Worse still, you find that your tail has begun to wag energetically of its own accord. ");
				}
				if (!prison.trainingPet.prisonCaptorPetOptedOut() && player.esteem < 15 && player.cor < 10)
				{
					outputText("Rather than resisting it, though, you find yourself embracing its strangely appealing innocence. You know she's making fun of you, but she's complimenting you too, and there is some comfort you cannot quite place in being treated this way. A good [boy] is attentive, loyal, and obedient. That seems almost virtuous compared to the depravities she usually asks of you, when you think about it...\n\n");
					outputText("...And you have to indulge her in <i>some</i> way to earn your treat. A rather clever idea forming in your mind, you lift your left hand from the floor and curl your fingers slightly before putting it back down. You do the same with your right, and after lowering your entire body somewhat closer to the floor, try to make it the rest of the way on your \"paws,\" You're startled and a little abashed by how quickly you close the distance, but attribute it to exhaustion as you reach your owner, panting heavily -- and notice your tongue lolling out.\n\n");
					outputText("Though the realization further colours your cheeks, you focus instead on your owner's imposing boots. With an idea of how to really impress her, you lean down and begin licking at them. As your tongue meets the leather in long, thorough strokes, you actually find it somewhat peaceful. Even if it's just an act, you're glad it's as her good, virtuous [boy] instead of something corrupt.\n\n");
					outputText("\"<i>Well done! Aren't you just the cutest little slut ever?</i>\" She reaches down and tussles your [hair], and once again a rush of confusing feelings comes to the fore. Her form of address violently snaps you out of your reverie, but her affectionate gesture mitigates the sting. \"<i>Yes you are! Now, demonstrate what a good [boy] you are again by sitting back on your haunches and showing me what other tricks you can do.</i>\" \n\n");
					outputText("As instructed, you look up from licking her boots and deferentially rise to your knees, assuming a docile posture. You immediately feel uncertainty welling within you again, especially as you briefly meet her gaze. Though you are excited to find her expression appearing very pleased, you see her eyes flicker with a mix of concern and -- seemingly -- genuine confusion.\n\n");
					outputText("You quickly lower your gaze, wondering what's wrong, when you realize your own expression had contorted into a sort of wounded pout. Deciding to try and rectify your mistake, you reclaim your look of doe-eyed submission and focus on the next \"trick\" she asked for.\n\n");
					outputText("You're momentarily at a loss, having already heeled and sat to what you hope is her satisfaction, when you remember your \"paws\" resting politely in your lap. As you realize what she must be asking, you feel a bit faint, but take a deep breath and let your wince pass.\n\n");
					outputText("Looking back up with the most suppliant expression you can muster, you let your jaw drop and your tongue hang out invitingly. Your expression wavers as you tense both physically and emotionally, but you can't help but be a little impressed by the smooth precision with which you execute the gesture that follows. All in one motion you let your wrists hang slack, raise your hands to either side of your face, and sit up on your haunches, doing your best to mimic a begging dog.\n\n");
					outputText("Mistress Elly's eyes merely widen for a moment in silence, before she closes them gently and a bemused smile crosses her face. She chuckles to herself, as if aware of some secret joke.\n\n");
					outputText("Even if your previous theatrics were mostly harmless -- maybe even a little fun -- you can't deny how utterly humbling your current pose is. Still, as your owner's eyes open again in delighted enthusiasm, another sensation of innocent tranquility passes over you");
					if (player.hasKeyItem("Mistress Elly's Slave Collar") >= 0)
					{
						outputText(" and for once, the band around your neck feels comfortable rather than constricting");
					}
					outputText(".\n\n");
					outputText("\"<i>Oh. Oh my! You really are a good [boy], aren't you? So so good! Well, I won't make you \"beg\" any longer. You may proceed.</i>\" \n\n");
				}
				else if (player.esteem < 25)
				{
					outputText("Unable to manage this perplexing response, you instead choose to hide from it by falling deeper into your act. As soon as you do, your shame changes into an inspired idea. ");
					if (player.cor < 20)
					{
						outputText("As you lift your left hand from the floor, you curl your fingers slightly before putting it back down. You do the same with your right, and after lowering your entire body somewhat closer to the floor, try to make it the rest of the way on your \"paws.\"");
					}
					else
					{
						outputText("You cross the remaining distance not on your hands, but down on your elbows, further accentuating the submissive curvature of your back and the needy sway of your ass.");
					}
					outputText(" You're panting heavily when you finally reach your Mistress, and your cheeks are painted darker as you notice your tongue lolling out.\n\n");
					outputText("[if (corruption < 20) Unsure of what to do][if (corruption >= 20) Thinking you know how to make a special show of it], you drop low, lean towards Mistress Elly's imposing boots, and begin licking at them. As your tongue meets the leather in [if (corruption < 20) short, tentative strokes][if (corruption >= 20) playful, dramatic flicks] you swim in a mix of shame and comfort. You probably look absurd, but at least worshipping your Mistress's boots is [if (corruption < 20) a sort of reprieve][if (corruption >= 20) an easy indulgence].\n\n");
					outputText("\"<i>Well done! Aren't you just the cutest little slut ever?</i>\" She reaches down and tussles your [hair], and once again a rush of confusing feelings comes to the fore. [if (corruption < 20) Her demeaning address is jarring, but you can't help being soothed by the affectionate gesture that comes with it.][if (corruption >= 20) Being reminded of how pathetic you're acting makes your stomach turn, but at least she's pleased with you.] \"<i>Yes you are! Now, demonstrate what a good [boy] you are again by sitting back on your haunches and showing me what other tricks you can do.</i>\" \n\n");
					outputText("You find yourself in very real danger of succumbing to the storm raging inside you, but after a moment of staring blankly at the now damp leather below of you, you realize that your only choice is to keep running from your insecurity until the performance is done. So resolved, you gather the seductive momentum you built crawling across the room, return the look of submission to your face, and raise yourself up to your knees.\n\n");
				}
				else if (player.esteem < 60)
				{
					outputText("Your confusing response to her words briefly muddies your resolve, but you are determined to stick to your plan and not allow her to use your weakness to spin you out of control. Guessing that it is already too late to hide it, you let the unnerving pride show through in an appreciative smile, then attempt to continue on as though you were otherwise unaffected by her words. \n\n");
					outputText("Shaken as you are, though, your movements no longer come so effortlessly, and your mind scrambles to maintain the illusion that your body so easily built. At one point when you find yourself focused on guiding your arms you worry that you may not have swung your hips with your last stride. Studying her face anxiously, you allow her widening smile to reassure you -- she is unquestionably quite pleased with what she is seeing. Nevertheless, when you arrive at her feet you take a dangerous moment to recenter yourself, hoping to avoid repeating such a mishap, then rise to your knees as calmly as you can and look upwards for direction.\n\n");
					outputText("\"<i>Very good! I can see just how willing and eager you are, so I won't make you wait any longer. You may proceed.</i>\"\n\n");
				}
				else
				{
					outputText("You didn't expect her to fall for your act this easily, and while you resent her treating you like an animal, you decide to use it to your advantage. Focusing on making your behavior appear natural, you respond to her words with an open mouthed look of gratitude and stop dead in your tracks as though you were stunned with excitement. ");
					if (player.cor < 25)
					{
						outputText("You then let your tongue hang from your mouth");
						if (player.tailType > 0)
						{
							outputText(", begin to wag your tail energetically, ");
						}
						outputText("and add an infectiously playful bounce to your movement as you complete your approach. So convincing is your act that as you watch a charmed smile spread across her face you begin to genuinely feel a bit of the enthusiasm you are feigning, and have to remind yourself to stay calm and in control.\n\n");
					}
					else
					{
						outputText("You then make a show of widening your stance and curling your [ass] into the air as though presenting yourself for breeding, ");
						if (player.tailType > 0)
						{
							outputText("begin to wag your tail energetically, ");
						}
						outputText("and add an extra happy twist at the end of each seductive wiggle of your hindquarters as you complete your approach. A brief moment of wide eyed amusement resolves into a look of titillated glee on Mistress Elly's face, one that you struggle not to mirror as her tongue teases at her crimson lips.\n\n");
					}
					outputText("Upon arriving at your feet, you keep your new act going. [if (corruption < 25) You give a sunny whimper and rub your cheek affectionately at her thigh, earning a delighted coo and a pat on the head from your captor. Then, with a vacuous grin][if (corruption >= 25) With perhaps a bit too much genuine devotion, you give a passionate lick up her leather clad calf and soft, fleshy inner thigh. Then, with a frisky smile] you joyfully rise to your haunches, fold your hands politely in your lap, and arch your back with a playful snap of your shoulders[if (biggestTitSize > 2)  that makes your [chest] heave and bounce merrily].\n\n");
					outputText("\"<i>And you've even taught yourself to sit!</i>\" You continue to play along, smiling broadly as she patronizes you, but it does occur to you that the obedient gesture came easier than you expected. \"<i>Now, be a good [boy] and show me what other tricks you can do.</i>\"\n\n");
				}
				
				
				if (!prison.trainingPet.prisonCaptorPetOptedOut() && player.esteem < 15 && player.cor < 10)
				{
					outputText("You suddenly realize what she still expects of you -- what she's really been expecting this whole time -- and your calm collapses into resigned dread as her fully erect cock bobs to and fro before your eyes. Its head is as big as of a small apple, its shaft the length of your forearm, and its girth nearly equivalent to your wrist. As you let your begging stance drop and inch closer, you again you fail to notice your convincing expression waver, this time plainly grimacing as your jaw indecisively lowers and rises.\n\n");
					outputText("Your [if (obey < 20) captor][if (obey >= 20) Mistress] lightly clears her throat at your hesitation, but rather than continuing forward, you look to her attentively as your ears perk up, still inadvertently showing a rather mopey expression. Again she raises a curious eyebrow, but her delighted smile remains. You find yourself unable to read her gaze, but she must be happy as she gives you a heartening wink and ruffles your hair again.\n\n");
					outputText("\"<i>Come on, [boy]; you can do it -- I'm not <b>that</b> big.</i>\" Feeling an unfamiliar rush of confidence [if (obey >= 20) , and gratitude for the encouragement that brought it on], you look back down at your goal, open your mouth wide, and close your eyes. Keeping your paws planted in front of you and your posture reverent, you press your lips to her tip and lean forward.\n\n");
				}
				else
				{
					outputText("Having maintained your conviction thus far, you see no reason to delay the inevitable. Her fully erect cock bobs to and fro before your eyes, concrete evidence that your display has had the desired effect. Its head is as big as of a small apple, its shaft the length of your forearm, and its girth nearly equivalent to your wrist, but you decide to throw caution to the wind and attempt to [if (esteem < 40) overcome how intimidated you are][if (esteem >= 40) prove that you aren't intimidated] by her size. You close your eyes, keep your arms at your side and your posture reverent, press your lips to her tip, and lean forward. \n\n");
				}
				outputText("Even unlubricated, her silky soft skin slides smoothly past your ");
				if (player.femininity < 35)
				{
					outputText("strong lips");
				}
				else if (player.femininity < 65)
				{
					outputText("supple lips");
				}
				else
				{
					outputText("plump lips");
				}
				
				outputText(", first easing your mouth open, then stretching your jaw wide as you let your own weight slowly impale you. While you intended to make this as impressive as possible, you surprise even yourself by how much of her rod you manage to consume in one movement. Between the luxurious texture of her flesh and its unusually sweet and savory taste, her cock is a much more pleasant guest than one might expect, and your mouth seems compelled to be a welcoming host. Each time you begin to feel like your maw is simply not large enough to accommodate any more, it responds by salivating and opening wider, giving her knob the ability to push even deeper. Only when it is lodged in the entrance to your throat and starts to cut off your air supply do you decide to stop and open your eyes.\n\n");
				if (player.esteem < 40)
				{
					outputText("You are disheartened to see that more than half of her length remains exposed outside your mouth, but you take encouragement from the soft utterance of pleasure and approval that your effort draws from Mistress Elly's lips.");
				}
				else if (player.esteem < 60)
				{
					outputText("You are shocked to see that you've managed to fit almost half of her tremendous length inside of you, and you feel a rush of excitement at the prospect that you might be able to pull this plan off.");
				}
				else
				{
					outputText("You are thrilled to see that nearly half her cock is now inside your mouth, and even more pleased to hear her surprised and happy moan at your success; fooling her may prove easier than you had hoped.");
				}
				
				outputText(" You decide to make your next move even more impactful, and fix her eyes with a hungry gaze as you proceed. Her exotic features betray unmitigated excitement as she watches you slowly back off her cock, weaving your head side to side as you go. You palpate your lips around her shaft and tease at her underside with your tongue such that you leave behind a slick, slimy trail of saliva and pre-cum along her entire length. As you reach the end of your retreat, you hold your mouth open and slowly draw yourself away from the tip so that viscous streamers stretch between your tongue and her tip, continuing to lock eyes with her as you do.\n\n");
				outputText("The delight in her violet orbs grows more intense with every passing moment, ");
				if (!prison.trainingPet.prisonCaptorPetOptedOut() && player.esteem < 15 && player.cor < 10)
				{
					outputText("and your heart skips a beat as something predatory curls into her smile. You make an effort to let it pass, but end up feeling more and more anxious until your gaze flickers, then breaks into a sheepish wince. Looking down, you try to just focus on your task.");
				}
				else if (player.esteem < 40)
				{
					outputText("and although her wolfish grin is slightly alarming, the simple thrill of seeing your success on her face spurs you onward.");
				}
				else if (player.esteem < 60)
				{
					outputText("but something about the predatory glee in her smile alarms you, and you respond by pushing the act even harder.");
				}
				else
				{
					outputText("but her open toothed grin is that of a predator about to strike, and so you do your best to stay one step ahead of her.");
				}
				
				
				outputText(" You make an especially lurid show of licking your tongue about your lips, and when strands begin to break free you quickly drop your head down to catch them. As you follow them back upwards you collect most of the drippy goo on your tongue, but you snake your neck just enough to make a slimy mess of your nose, cheeks, and chin, and when you reach her cock you tease and suckle at her tip until it is clean. ");
				if (!prison.trainingPet.prisonCaptorPetOptedOut() && player.esteem < 15 && player.cor < 10)
				{
					outputText("Though you can no longer see her expression, another dainty sigh suggests you're on the right track, giving you another push to overcome your trepidation. With a determined huff, you begin making long, dutiful strokes along the first half of her succulent cock.\n\n");
				}
				else
				{
					outputText("Her eyes briefly flutter and roll at this, breaking from your ravenous stare for the first time since it began, and when they return you attempt to press your advantage. You maintain your [if (esteem < 40) needy][if (esteem >= 40) lusty] eye contact, and begin making long, dutiful strokes along the first half of her succulent cock.\n\n");
				}
				outputText("She allows you to pump away in breathy silence about half a dozen times, your body finding a rhythm in the act despite how distractingly agreeable you find the flavors and textures of her peculiar skin to be. As you settle in, though, she rests her hand firmly but gently on the back of your head, careful not to disrupt your line of sight, and begins to vocalize the fervor building in her expression.\n\n");
				outputText("\"<i>Yes, slave, very-oh-good. See... this, this is what I knew... ah, flick at the tip, yes... what I knew was hiding within you.</i>\" You cannot help but flare your eyes, elated that she is so [if (esteem < 40) pleased with][if (esteem >= 40) convinced by] your exploits. \"<i>Can't you... can't you just feel... oh, a bit deeper, dear... can't you just feel what a natural cocksucker you-ahhhh-are? </i>\" With each stroke more of her salty juice mixes in with your saliva, and you find yourself increasing your pace as the last bit of friction between your lips disappears into sublime, slippery, sensation. \"<i>Doesn't...mmm... it just... ohhh... feel wonderful... aaah... to-oh!-<b>accept it</b>?</i>\"\n\n");
				outputText("Abruptly, she grasps you by your [hair], pulls you off her cock, and yanks your head back so that you couldn't break her gaze even if you wanted to. \"<i>Well, slave, doesn't it?</i>\"\n\n");
				outputText("\"<i>Yes, Mistress!</i>\" you reply hastily, eager to ");
				if (player.esteem < 40)
				{
					outputText("keep her in the good mood you've worked so hard to build.");
				}
				else if (player.esteem < 60)
				{
					outputText("avoid upsetting her.");
				}
				else
				{
					outputText("maintain your ruse.");
				}
				
				outputText("\n\n");
				outputText("\"<i>Oh, I know.</i>\" Given how excited she was moments ago, she is suddenly remarkably tranquil. She favors you with a conspiratorial wink and leans down to whisper derisively in your ear. \"<i>See, we both know how to pretend, slave -- only, I think the only person that <b>you</b> are managing to fool is yourself.</i>\" Her warm breath tickles at your ear, and ");
				if (player.esteem < 40)
				{
					outputText("a mortified shudder rips through you.");
				}
				else if (player.esteem < 60)
				{
					outputText("you are gripped by a wave of panic.");
				}
				else
				{
					outputText("your mind scrambles to regain its footing.");
				}
				
				outputText("\"<i>But by all means, continue to pretend. It's excellent practice. But while you do so, I think I'll satisfy my curiosity a bit and monitor how you are <b>really</b> feeling about sucking my cock. I'll keep my promise either way, but I think it will be a bit more... educational this way.</i>\"\n\n");
				outputText("She pulls your head back by your hair and stares directly into your eyes, watching your reaction intently as you feel a thick, velvet rope wrap around your waist. It cinches itself in place, then ");
				if (player.hasCock())
				{
					outputText("coils itself tightly around your [if (corruption < 20) limp][if (corruption >= 20) semi-erect] [cock biggest].");
					if (player.hasVagina())
					{
						outputText(" Afterwards, it straps itself between your legs, spreading your[if (corruption >= 20)  damp] lips and squeezing tightly against your [clit].");
					}
				}
				else if (player.hasVagina())
				{
					outputText("straps itself between your legs, spreading your[if (corruption >= 20)  damp] lips and squeezing tightly against your [clit].");
				}
				else
				{
					outputText("straps itself between your legs, spreading the cheeks of your [ass] and squeezing tightly against your [asshole].");
				}
				
				if (!prison.trainingPet.prisonCaptorPetOptedOut() && player.esteem < 15 && player.cor < 10)
				{
					outputText(" It proves unnecessary, though, as your stare back at her with a stunned, distraught expression, your eyes filling with tears and your jaw quivering madly. Once again, her own violet orbs flicker with momentary uncertainty and she relaxes her grip a little, favoring your heartbroken countenance with an affectionate smirk.\n\n");
					outputText("\"<i>Now, slave; don't look at me like that...</i>\" You make no response, still overcome with despair that she remains fairly indifferent despite your extraordinary show of effort. As your captor/Mistress keeps hold of your watery gaze, though, she releases a light sigh.\n\n");
					outputText("\"<i>I told you, dear, you aren't fooling me.</i>\" With a sniffle, you look dejectedly away from her. She may not have believed your performance, but she doesn't have to stare you down and keep taunting you over it, either -- especially with how hard you tried. Out of the corner of your misty vision, you see her mouth drift open as if in amused astonishment.\n\n");
					outputText("\"<i>Oh, alright. You were quite the talented little boot-licker, I suppose.</i>\" You tentatively glance back at her, the last tears dripping from your eyes as you feel an unbidden beat of tranquil pride. She actually looks somewhat relieved that you haven't given up completely, and you feel her thumb gently brush your cheek. \"<i>And maybe your devotion wasn't... completely dishonest, hm?</i>\" she muses more to herself than as a legitimate question. You feel yourself blushing, uncertain of her implication, but with a wink of encouragement she tilts your head back to face her cock.\n\n");
					outputText("\"<i>But enough playing; do this properly. Or did you not want to be fed after all?</i>\" she teases.\n\n");
					outputText("Though still less than enthused about this aspect of your task, you are certainly eager to put her provocation behind you and earn your treat. Leaning forward again, you take her in your mouth and quickly return to your earlier technique, urgently devouring then slurping your way off her shaft. However, when you look up at her to check your progress, you find yourself quailing before her skeptical visage, and instead fix your eyes on the pillar of meat gliding through your lips. ");
				}
				else
				{
					outputText(" You realize that she must be able to read the ");
					if (player.esteem < 40)
					{
						outputText("resignation");
					}
					else if (player.esteem < 60)
					{
						outputText("agitation");
					}
					else
					{
						outputText("indignation");
					}
					
					outputText(" in your face, but you force yourself to push it back down and get back on your game. She smirks, releases her grip, and stands back up, and you find yourself once again staring between her legs with her cock twitching in front of your [face]. You are also now able to confirm your suspicion that the rope now wrapped about your crotch is actually her tail, but you do your best to ignore its tender squeezing as you pick up where you left off with as much passion as you can summon.\n\n");
					if (player.esteem < 40)
					{
						outputText("Desperate to put her provocation behind you, you quickly return to your earlier technique, urgently devouring then slurping your way off her shaft. However, when you try to once again fix her with a seductive stare you find yourself quailing before her confident visage, and instead fix your eyes on the pillar of meat gliding alluringly through your lips.");
					}
					else if (player.esteem < 60)
					{
						outputText("Intent on putting her provocation behind you, you calmly return to your earlier technique, sensually devouring then slurping your way off her shaft. As your confidence returns you once again fix her with a seductive stare, although you now find it much harder to maintain your facade as you look up at her smugly confident visage.");
					}
					else
					{
						outputText("Refusing to respond to her provocation, you confidently return to your earlier technique, dramatically devouring then slurping your way off her shaft. At the same time you once again fix her with a defiantly seductive stare, and do your best to ignore her smugly satisfied smile.");
					}
					
				}
				outputText(" For several minutes of this she simply watches you go, smirking and chuckling at your provocative efforts. Then, as your jaw is tiring and your [if (esteem < 40) spirit][if (esteem >= 40) energy] waning, she rolls her eyes and sighs. \"<i>It was a good show at first, but you're boring me now, slave. If you want to earn your meal, you're going to have to do something special to impress me.</i>\"\n\n");
				outputText("You stop moving halfway through a stroke, overcome with [if (esteem < 50) panic][if (esteem >= 50) frustration]. ");
				if (!prison.trainingPet.prisonCaptorPetOptedOut() && player.esteem < 15 && player.cor < 10)
				{
					outputText("There is no way you can simply give up after coming this far, and so with her knob still leaking in your mouth you consider how you might impress her. She did say she was happy with your attending her boots before...maybe your tongue could be of further use?");
				}
				else
				{
					outputText("There is no way you are going to go this far and simply give up, and so with her knob still leaking its sticky lubricant onto your tongue you consider how to go about impressing her.");
				}
				outputText("\n\n");
				if (player.esteem < 15 || player.biggestTitSize() >= 2)
				{
					titChoice = true;
				}
				if (player.esteem >= 50 || (player.hasCock()) || !prison.trainingPet.prisonCaptorPetOptedOut() && player.esteem < 15 && player.cor < 10)
				{
					cuntChoice = true;
				}
				menu();
				if (titChoice) addButton(0, "Titfuck", prisonCaptorFeedingBJTrainingPerform, "titfuck");
				if (cuntChoice) addButton(1, "Cunnilingus", prisonCaptorFeedingBJTrainingPerform, "cunt");
				addButton(2, "Deep Throat", prisonCaptorFeedingBJTrainingPerform, "deepthroat");
				return;
			}
			if (branchChoice == "titfuck")
			{
				if (player.cor < 20)
				{
					outputText("You know that Mistress Elly expects you to find some way to debase yourself even further, but for a moment you are[if (esteem < 40)  completely] at a loss as to how to do so. You can see her growing impatient, and you attempt to buy yourself some time by making another show of playing with strands of saliva and pre-cum, only to earn another roll of her eyes. Your [if (esteem < 50) panic][if (esteem >= 50) frustration] deepens, but then a thread of fluid falls to your [chest] and you find the inspiration you were searching for.\n\n");
				}
				else
				{
					outputText("You can read Mistress Elly's growing impatience as plain as day on her face, and you know you are going to have to act quickly if you want to [if (esteem < 40) please her][if (esteem >= 40) keep control of the encounter]. Thankfully, it only takes a moment for your creativity to express itself.\n\n");
				}
				outputText("You gather your determination while treating her to another[if (esteem < 30)  desperate,] lust filled look, then rise up to a low squat, bringing her cock level with your chest. Your movement causes her tail to constrict about your crotch, but you do your best to ignore the pleasurable feelings this generates and focus on your intended theatrics. ");
				if (player.biggestTitSize() < 2)
				{
					outputText("Although your [if (biggestTitSize >= 1) barely-there bust][if (biggestTitSize < 1) manly chest] won't be able to offer her any real stimulation, you can think of no better way to display the lascivious subservience that her domineering presence demands than to make a naughty show of worshiping her cock as if you had a bosom to wrap around it.\n\n");
					outputText("Still, as you take hold of her monstrous shaft and press it against the flesh in the center of your barren chest, you cannot bring yourself to continue watching her reaction -- what you are about to do is already disgraceful enough without her input. Instead you close your eyes and make your [face] present an exaggerated expression of ecstasy, then begin to writhe your body against her slick, imposing warmth.\n\n");
					outputText("A soft, contended moan above you and a subtle shifting of her weight towards you serve as comforting indications that you are on the right track, but you soon begin to question the wisdom of moving your body in this fashion. With each undulation and twist ");
					if (player.hasCock())
					{
						outputText("your [cock biggest] slides through the enticing velvet embrace of her tail");
						if (player.hasVagina())
						{
							outputText(" and your [clit] shudders as it shifts between your legs");
						}
					}
					else if (player.hasVagina())
					{
						outputText("the enticing velvet embrace of her tail rubs vigorously against your [clit]");
					}
					else
					{
						outputText("the enticing velvet embrace of her tail rubs vigorously between your legs");
					}
					
					outputText(", making your ecstasy much less of an exaggeration as you go. You attempt to distract yourself, running your hands along her silky, lubricated length to provide the treatment that your inadequate [chest] cannot, and massaging her tip with a welcoming mouth every time it slides near, but it only makes matters worse. Before long you are releasing long, plaintive moans of your own each time her knob pulls wetly through your lips, and you lack the presence of mind to even pretend they are intentional.\n\n");
					if (!prison.trainingPet.prisonCaptorPetOptedOut() && player.esteem < 15 && player.cor < 10)
					{
						outputText("\"<i>You poor, pitiful thing,</i>\" she chuckles down at you as you thrash about before her. \"<i>If you want so badly to have a pair of tits for me to fuck, all you need to do is ask nicely.</i>\" Her tail constricts sharply about your crotch and the only response you can manage is an open mouthed gasp. \"<i>Good enough. Finish earning your meal, and maybe I'll consider helping you with that in the future.</i>\"\n\n");
					}
					else
					{
						outputText("\"<i>You poor, pitiful thing,</i>\" she chuckles down at you as you thrash about before her. \"<i>If you want so badly to have a pair of tits for me to fuck, all you need to do is ask nicely.</i>\" Her tail constricts sharply about your crotch and the only response you can manage is an open mouthed gasp. \"<i>Good enough. Finish earning your meal, and I'll give you something special to help with that.</i>\"\n\n");
					}
				}
				else if (player.biggestTitSize() < 5)
				{
					outputText("Although your [chest] aren't large enough to fully engulf her intimidating girth, you can think of no better way to display the [if (esteem < 40) the lascivious subservience that her domineering presence demands][if (esteem >= 40) the lascivious behavior that she expects to see] than to make a naughty show of [if (esteem < 20) worshiping][if (esteem >= 20) massaging] her cock with your bosom.\n\n");
					if (player.esteem < 40)
					{
						outputText("Still, as you take hold of her monstrous shaft and press it between your [if (biggestTitSize >= 3) shapely][if (biggestTitSize < 3) modest] tits, you cannot bring yourself to continue watching her reaction -- what you are about to do is already disgraceful enough without her input. Instead you close your eyes and make your [face] present an exaggerated expression of ecstasy, then begin to writhe your body against her slick, imposing warmth, using your palms to crush your flesh against her.\n\n");
					}
					else
					{
						outputText("As you take hold of her monstrous shaft and press it between your [if (biggestTitSize >= 3) shapely][if (biggestTitSize < 3) modest] tits, you decide to forgo watching her reaction in favor of making a shift in your dramatic approach. You close your eyes, use your palms to crush your flesh against her, make your [face] present an exaggerated expression of ecstasy, and begin to writhe your body against her slick, imposing warmth.\n\n");
					}
					outputText("A soft, contended moan above you and a subtle shifting of her weight towards you serve as comforting indications that you are on the right track, but you soon begin to question the wisdom of moving your body in this fashion. With each undulation and twist ");
					if (player.hasCock())
					{
						outputText("your [cock biggest] slides through the enticing velvet embrace of her tail");
						if (player.hasVagina())
						{
							outputText(" and your [clit] shudders as it shifts between your legs");
						}
					}
					else if (player.hasVagina())
					{
						outputText("the enticing velvet embrace of her tail rubs vigorously against your [clit]");
					}
					else
					{
						outputText("the enticing velvet embrace of her tail rubs vigorously between your legs");
					}
					
					outputText(", making your ecstasy much less of an exaggeration as you go. You attempt to distract yourself, shifting your [chest] around her silky, lubricated length to provide as much stimulation as you can as you rub against it, and massaging her tip with a welcoming mouth every time it slides near, but it only makes matters worse. Before long you are releasing long, plaintive moans of your own each time her knob pulls wetly through your lips, and tugging salaciously at your engorged [nipples][if (milkQuantity > 10)  so that their milky excretions can join your exaltation of her manhood].\n\n");
					outputText("\"<i>See, now you are being a bit more honest, slave,</i>\" she chuckles down at you as you thrash about before her. \"<i>Wouldn't you agree?</i>\" Her tail constricts sharply about your crotch and the only response you can manage is an open mouthed gasp. \"<i>I thought so.</i>\"\n\n");
				}
				else
				{
					outputText("As intimidating as her girth may be, your [chest] could easily engulf her, and you can think of no better way to display the [if (esteem < 40) the lascivious subservience that her domineering presence demands][if (esteem >= 40) the lascivious behavior that she expects to see] than to make a naughty show of [if (esteem < 20) worshiping][if (esteem >= 20) massaging] her cock within your bosom.\n\n");
					if (player.esteem < 40)
					{
						outputText("Still, as you take hold of her monstrous shaft and wrap your voluptuous tits around it, you cannot bring yourself to continue watching her reaction -- what you are about to do is already disgraceful enough without her input. Instead you close your eyes and make your [face] present an exaggerated expression of ecstasy, then begin to writhe your body against her slick, imposing warmth, using your palms to crush your flesh about her.\n\n");
					}
					else
					{
						outputText("As you take hold of her monstrous shaft and wrap your voluptuous tits around it, you decide to forgo watching her reaction in favor of making a shift in your dramatic approach. You close your eyes, use your palms to crush your flesh about her, make your [face] present an exaggerated expression of ecstasy, and begin to writhe your body against her slick, imposing warmth.\n\n");
					}
					outputText("A soft, contended moan above you and a subtle shifting of her weight towards you serve as comforting indications that you are on the right track, but you soon begin to question the wisdom of moving your body in this fashion. With each undulation and twist ");
					if (player.hasCock())
					{
						outputText("your [cock biggest] slides through the enticing velvet embrace of her tail");
						if (player.hasVagina())
						{
							outputText(" and your [clit] shudders as it shifts between your legs");
						}
					}
					else if (player.hasVagina())
					{
						outputText("the enticing velvet embrace of her tail rubs vigorously against your [clit]");
					}
					else
					{
						outputText("the enticing velvet embrace of her tail rubs vigorously between your legs");
					}
					
					outputText(", making your ecstasy much less of an exaggeration as you go. You attempt to distract yourself, squeezing your [chest] around her silky, lubricated length to provide as much stimulation as you can as you billow over it, and lowering your chin to your sternum so that her tip enters your welcoming mouth as it pokes through the top of your pillowy embrace, but it only makes matters worse. Before long you are releasing long, plaintive moans of your own each time her knob pulls wetly through your lips, and tugging salaciously at your engorged [nipples][if (milkQuantity > 10)  so that their milky excretions can join your exaltation of her manhood].\n\n");
					outputText("\"<i>See, now you are being a bit more honest, slave,</i>\" she chuckles down at you as you thrash about before her. \"<i>Wouldn't you agree?</i>\" Her tail constricts sharply about your crotch and the only response you can manage is an open mouthed gasp. \"<i>I thought so.</i>\"\n\n");
				}
				
				outputText("\"<i>Now, slave, as much as I know you're enjoying rubbing your ");
				if (player.biggestTitSize() > 1)
				{
					outputText("udders");
				}
				else
				{
					outputText("\"breasts\"");
				}
				outputText(" on my dick, you are here for my pleasure, not your own. I think it is time for you to swallow me whole and show me you know what to do with my seed.</i>\"");
			}
			else if (branchChoice == "cunt")
			{
				if (!prison.trainingPet.prisonCaptorPetOptedOut() && player.esteem < 15 && player.cor < 10)
				{
					outputText("As you consider how to go about impressing Mistress Elly you find it hard not to be distracted by the shifting of her velvety rope. You can read her growing impatience as plain as day on her face, and you know you need to act quickly if you want to please her, but every twitch of her tail sends an increasingly potent shiver up your spine. Unable to endure it, you begin to convulse, pulling gradually away until her cock suddenly leaves your mouth with a soggy pop and you arch your back with an indecent whine, drool seeping down your chin and neck as tears fill your eyes. Your [if (obey < 20) captor][if (obey >= 20) Mistress] lets her cord go slack with an amused, triumphant sigh, and you collapse forward between her legs with a thud.\n\n");
					outputText("\"<i>My, my. Maybe you should have let me teach you more basics before attempting to impress me, hm?</i>\" she offers with a chuckle. \"<i>Or at least developed enough... endurance... that my little 'diagnostic' wouldn't reduce you to a slobbering mess?</i>\" At that, the tears begin running in rivulets down your face; not only do her words sting, but she sounds more satisfied <i>now</i> than at any point while you were nursing her cock.\n\n");
					outputText("As a result you merely lie on the floor, wallowing in failure for several beats, until her tail constricts again and you feel a sharp tap on your [ass].\n\n");
					outputText("\"<i>Rise and shine, sleepyhead,</i>\" she sings, clearly enjoying her moment enough not to hurry rousing you, her spade-tipped whip lightly alternating between your cheeks. \"<i>You still have a job to finish, remember?</i>\"\n\n");
					outputText("The <i>last</i> thing you want to finish right now is swallowing her cock, but as her tail strikes gradually intensify, you realize you don't have much choice. Lifting yourself back off your paws with a strained sigh, you look up at your fate -- and inspiration hits you.\n\n");
					outputText("You crane your neck and rise quickly, seeing an opportunity to put your tongue to better use. Her female sex is every bit as beautifully sculpted as the rest of her body; smooth, supple lips spread coyly about her slit, glistening with dewy residue and a lively rosy pink in color, and where they elegantly come together a delightfully petite button of glossy flesh peaks through, begging for attention. Eager to oblige, you reach out, and as you make contact her heady aroma fills your nostrils and explodes on your tongue. As with the rest of her flesh, there is an uncanny mixture of earthy overtones and sweet, cinnamon infused highlights, but here there are also complimentary light, floral notes that leave you dazed and loopy. Stunned by the rush of sensations, you take a moment to just stare up at her at her perfect folds, before following your tongue as it seems to sneak out for more of its own accord.\n\n");
				}
				else
				{
					if (player.hasCock())
					{
						outputText("As you consider how to go about impressing Mistress Elly you find it hard not to be distracted by the velvety coils shifting around your [cock biggest]. You can read her growing impatience as plain as day on her face, and you know you are going to have to act quickly if you want to [if (esteem < 40) please her][if (esteem >= 40) keep control of the encounter], but [if (corruption < 20) it's all you can do to stave off the carnal assault of your imagination][if (corruption >= 20) at the moment your imagination has run away with your senses]. Every twitch of her tail fills your mind with thoughts of [if (esteem < 60) a warm, moist pussy slowly enveloping you][if (esteem >= 60) pushing yourself into a warm, moist pussy], deepening your abiding [if (esteem < 50) panic][if (esteem >= 50) frustration]. Then, noting a dampness between her shapely legs, inspiration hits you.\n\n");
					}
					else
					{
						outputText("As you consider how to go about impressing Mistress Elly, the firm, velvety grasp of her tail between your legs gives you a sudden burst of inspiration. [if (corruption < 20) Not only will you surprise her, but perhaps you may even be able to shift the focus of this encounter to a slightly more comfortable venue.][if (corruption >= 20) Perhaps if you explore her more sensitive side you can throw her off balance and really take control of this encounter.]\n\n");
					}
					outputText("You pull her cock from your mouth with a soggy pop, take hold of her tip with your left hand, and treat her to another[if (esteem < 30)  desperate,] lust filled look. Then, while lowering yourself down to sit with your ass between your bent knees, you lick your way down the underside of her cock toward her balls. Your movement causes her tail to constrict about your crotch, but you do your best to ignore the pleasurable feelings this generates and focus on carrying out your delicate strategy. You give her sack a perfunctory suckle, then grab hold of it with your right hand and begin to caress it gently, all the while massaging your left hand along her slimy length. Only after seeing your ministrations bring pleasure back to her face do you surreptitiously lift her phallic parts and expose your true destination.\n\n");
					outputText("You crane your neck and lean forward quickly, [if (esteem < 50) overcome with a sudden desire to explore her folds][if (esteem >= 50) so as to not allow her time to react]. Unsurprisingly, her female sex is every bit as beautifully sculpted as the rest of her body; smooth, supple lips spread coyly about her slit, glistening with dewy residue and a lively rosy pink in color, and where they elegantly come together a delightfully petite button of glossy flesh peaks through, begging for attention. [if (esteem < 50) Eager to][if (esteem >= 50) Happy to] oblige, you reach out, and as you make contact her heady aroma fills your nostrils and explodes on your tongue. As with the rest of her flesh, there is an uncanny mixture of earthy overtones and sweet, cinnamon infused highlights, but here there are also complimentary light, floral notes that leave you dazed and loopy.\n\n");
				}
				outputText("Above you there is a sharp intake of breath and light laugh, but you tune that out and lose yourself in the sensory wonderland of your performance. You commence your offensive by lightly teasing your tongue around the delicate folds of skin that shield her clitoris, then follow with a series of slow, heavy flicks directly over her sensitive button. In response to each her tail ");
				if (player.hasCock())
				{
					if (player.hasVagina())
					{
						outputText("mirrors your tongue's movement against your own [clit], and ");
					}
					outputText("shifts and squeezes around your [if (corruption < 20) semi-erect][if (corruption >= 20) already hard] [cock biggest].");
				}
				else if (player.hasVagina())
				{
					outputText("mirrors your tongue's movement against your own [clit], and squeezes itself suggestively between your[if (corruption >= 20)  damp][if (corruption >= 20) already wet] lips.");
				}
				else
				{
					outputText("squeezes between your legs, mirroring your tongue's movement against your own [asshole].");
				}
				
				if (!prison.trainingPet.prisonCaptorPetOptedOut() && player.esteem < 15 && player.cor < 10)
				{
					outputText(" \"<i>Well, well,</i>\" she muses with a giggle. \"<i>You really are desperate to see this through, aren't you?</i>\" You tune that out as well, barely hearing her as the wet rustle of your lapping and breathing fills your ears. Your entire body flush with the warmth of her aroma, you take a deep, indulgent lick across and into her slit, eyes fluttering as you savor the taste. More than taken with the sensations enveloping your ever reddening face, you don't even notice her tail abruptly stop -- as if distracted.\n\n");
					outputText("\"<i>Well, alright dear. I appreciate your... determination, if nothing else. Now...enough; be a good [boy] and come...show me you can swallow my...</i>\" You don't notice her unusual meter -- in fact, you don't really notice anything she's saying. But two of her words manage to slip through your distracted ears, and they perk up as you're overcome with a serene, radiant urge to redouble your efforts.\n\n");
					outputText("You continue to make long, thorough strokes in and around her folds, occasionally giving her button a shy, tentative suckle. You think you hear some murmuring, but it's too choppy to make out, and your mind is too busy basking in your owner's delicious cunt anyhow. So you continue, submissively slurping and lapping and kissing until your euphoric bubble is suddenly popped by the sound of a loud, sharp moan.\n\n");
					outputText("You've barely had time to blink when a sharp tug of your [hair] drags you out from between Elly's legs and curls your neck to look up at her -- which you do, your eyes wavering without focus, your cheeks glistening like rubies and your tongue lolling dumbly in a faint, innocent, absent-minded grin.\n\n");
					outputText("The amethyst fury of <i>her</i> countenance seems somewhat unwarranted, then, but it quickly softens into muted exasperation as you take notice and your own expression wilts into a terrified apology. By the time she speaks, though, you've calmed down; her lips have pursed into a saintly, sympathetic smile, her eyes have settled into an authoritative but comforting stare, and her olive skin has an endearing tint that you don't recall having seen before.\n\n");
					outputText("\"<i>You haven't earned that privilege, [boy]. But for your... spirited effort... I'll let it slide this time.</i>\" Her voice is soft, as if an amplified whisper, and preternaturally calm, as if restraining something. It sounds like she's restraining your punishment, though, so you merely lower your eyes [if (obey < 20) agreeably][if (obey >= 20) submissively] as she relaxes her grip. As she tilts your head back towards its primary duty, your lower lip quivers a bit, but you feel a little better as your heedlessly probing tongue collects a smear of juice left on your cheek and your mouth fills again with fruit and flowers.\n\n");
					outputText("\"<i>Now then...</i>\" she says with a relaxed sigh, her tone seemingly back to normal. \"<i>show me you know how to receive my <b>seed</b>, too.</i>\" She gives your hair another affectionate tussle, but her hand does not leave your locks, her fingers actually winding through them as if to keep an intimate hold.");
				}
				else
				{
					outputText(" You try to tune this out as well, [if (esteem < 50) but to little effect][if (esteem >= 50) but find only moderate success]. Still you persist, tracing your way through the folds of her lips all the way around her entrance, then alternating between licking lightly at her clit and teasing your tongue in and out of her hole, doing your best to endure your own growing urges as her tail echoes your every move.\n\n");
					outputText("Soon the sound of heavy breathing fills your ears, and you hasten your attack, momentarily awash in jubilant zeal. Only when her tail's corresponding blitz doubles you over do you stop and realize that the breathing was your own. \"<i>Well, that was a fun diversion. I should punish you for assuming you've earned the privilege of tasting my cunt, but it was such a spirited effort that I'll overlook it this once.</i>\" She gives a disdainful snort, unable to contain her contemptuous mirth. \"<i>A witless and clumsy effort, mind you, but still spirited.</i>\" [if (esteem < 40) You make a bashful attempt to ignore her dismissive mockery, but true or not her words still sting.][if (esteem >= 40) While you recongnize her taunt for what it is, the words still wound your pride.]\n\n");
					outputText("\"<i>Now, slave, get back to doing what your slutty little mouth was made for: swallow me whole and show me you know what to do with my seed.</i>\"");
				}
			}
			else
			{
				if (player.cor < 20)
				{
					outputText("You know that Mistress Elly expects you to find some way to debase yourself even further, but for a moment you are[if (esteem < 40)  completely] at a loss as to how to do so. You can see her growing impatient, and you attempt to buy yourself some time by making another show of playing with strands of saliva and pre-cum, only to earn another roll of her eyes. Your [if (esteem < 50) panic][if (esteem >= 50) frustration] deepens, but then as you stare down her monumental length you realize what you need to do.\n\n");
				}
				else
				{
					outputText("You can read Mistress Elly's growing impatience as plain as day on her face, and you know you are going to have to act quickly if you want to [if (esteem < 40) please her][if (esteem >= 40) keep control of the encounter]. Staring down the length of her cock, you can only really think of one thing to do.\n\n");
				}
				outputText("You gather your determination while treating her to another[if (esteem < 30)  desperate,] lust filled look, then rise up as high as you can on your knees and grasp her cock tentatively with both hands. Your movement causes her tail to constrict about your crotch, but you do your best to ignore the pleasurable feelings this generates and focus on the substantial challenge before you. ");
				if (player.esteem < 40)
				{
					outputText("As you take in the sight of her throbbing girth you can't help but flinch, suddenly consumed by self-doubt. However, faced with the prospect of failing to please your [if (obey < 20) captor][if (obey >= 20) Mistress] after already succumbing to so much indignity, you accept that this drastic measure is you only real option,");
				}
				else if (player.esteem < 60)
				{
					outputText("You once again stare down the barrel of her throbbing girth and tell yourself that you can do this -- or at the very least, you have to try --");
				}
				else
				{
					outputText("Her throbbing girth is undeniably imposing, but you are confident that this is the right way to proceed,");
				}
				
				outputText(" and so you plow forward.\n\n");
				outputText("More lubricated than ever thanks to your recent efforts, you manage to slide almost two thirds of her length down your throat on your first attempt, but immediately regret having pushed so hard. You come away choking and sputtering, and at the edge of your vision you see her slowly shaking her head in amused contempt. ");
				if (player.esteem < 40)
				{
					outputText("Dismayed at the thought of what might happen if you can't do better,");
				}
				else if (player.esteem < 60)
				{
					outputText("Irritated by your failure,");
				}
				else
				{
					outputText("Determined to not repeat the same mistake again,");
				}
				
				outputText(" you take a more measured approach on your second try and get bit further before running out of air. This time you make a concerted effort to make a good show of it, though, and return to your earlier technique of flirtatiously drawing her cock back out of your mouth while preparing for your next stroke.\n\n");
				outputText("Presumably as a reward for this choice, you feel her tail ");
				if (player.hasCock())
				{
					if (player.hasVagina())
					{
						outputText("squeeze tenderly at your [clit] while constricting");
					}
					else
					{
						outputText("constrict");
					}
					outputText(" around your [cock biggest], bringing it quickly to attention with its velvet embrace.");
				}
				else if (player.hasVagina())
				{
					outputText("squeeze your [clit] tenderly in its velvet embrace, then tease apart your lower lips as they grow damp.");
				}
				else
				{
					outputText("squeeze your crotch tenderly in its velvet embrace, tickling at your [asshole] until it puckers in response.");
				}
				
				outputText(" Each subsequent attempt goes a bit further, and earns a slightly more intense reply from her tail. Despite [if (esteem < 30) a halfhearted][if (esteem >= 30) a concerted] effort to remain calm and collected, she has you whipped near to a frenzy by the time your nose touches her pelvis. [if (esteem < 50) Yielding to][if (esteem >= 50) Unleashing] your rapidly growing lust, you strain your tongue out of your mouth and give her testicles a playful flick, then withdraw once more and[if (esteem < 40)  sheepishly] look upward to see her reaction.\n\n");
				outputText("Her sardonic smirk does not bode well. \"<i>Congratulations, [if (esteem < 20) dear][if (esteem >= 20) slave]. In your adorable effort to impress me, you've managed to achieve something that is expected of you every time my dick touches your cute little lips.</i>\" Your heart begins to sink, but before your manic desire can dissipate she fans your fire with another squeeze of her tail, and her countenance becomes friendly and consoling.\n\n");
				outputText("\"<i>No need to cry, dear -- I can feel how desperately you want to prove your dedication to me. Well, now is your chance: get my cock back down your throat and show me you know how to receive my seed.</i>\"");
			}
			
			if (player.esteem < 40)
			{
				outputText(" In your now thoroughly aroused state you don't waste time considering your response.");
			}
			else if (player.esteem < 60)
			{
				outputText(" Given your now thoroughly aroused state you decide it's best to not draw out the moment considering your response.");
			}
			else
			{
				outputText(" You decide to use your now thoroughly aroused state to your advantage and act without further consideration.");
			}
			
			if (!prison.trainingPet.prisonCaptorPetOptedOut() && player.esteem < 15 && player.cor < 10)
			{
				outputText(" You shift your weight back into a comfortable kneeling position, return your paws obediently to the stone in front of you, and fill your mouth once again with her cock. It isn't long before you are again pumping your mouth along her shaft at your earlier pace, only now each stroke terminates with your [face] flush with her crotch and her tight ball sack slapping lewdly against your chin");
			}
			else
			{
				outputText(" You shift your weight back into a comfortable kneeling position, return your hands obediently to your lap, and fill your mouth once again with her cock. It isn't long before you are again pumping your mouth along her shaft at your earlier pace, only now each stroke terminates with your [face] flush with her crotch and her tight ball sack slapping lewdly against your chin");
			}
			if (branchChoice != "deepthroat")
			{
				outputText(" -- something you would marvel at were you less overcome with lust");
			}
			outputText(". \n\n");
			outputText("\"<i>See, dear? Isn't it so much easier now that you've dropped the pretense?</i>\" The words pummel at your crumbling defenses, and you are vaguely aware of your hips bucking against their gentle restraint in time with the rhythm of your head. You feel a fleeting regret at not having the capacity to counter her insinuation, but what remains of your conscious mind is now dedicated to ");
			if (player.esteem < 40)
			{
				outputText("pleasing your [if (obey < 20) captor][if (obey >= 20) Mistress].");
			}
			else if (player.esteem < 60)
			{
				outputText("doing as you have been told.");
			}
			else
			{
				outputText("completing your task.");
			}
			
			outputText("\n\n");
			outputText("Any doubt you have in your ability to do so quickly melts away in the heat spreading from your loins, along with any difficulty you imagined there would be in stuffing her pillar of flesh inside of you. Where the taste and touch of her cock had previously been unexpectedly pleasant, the thing now pressed against your tongue is a feast for your inflamed senses, and you [if (esteem < 40) find yourself sucking][if (esteem >= 40) permit yourself to suck] with greedy abandon. You notice her begin to pulse within you, but it takes several moments for you to realize that your stomach is filling with her lust. In response, you hold still until your gut starts to expand, ");
			if (!prison.trainingPet.prisonCaptorPetOptedOut() && player.esteem < 15 && player.cor < 10)
			{
				outputText("your eyes watering as a frightening but overpowering flood of arousal washes over you. Smoldering in a daze of lust and embarrassment, you begin to slide off her rod in a slow, captivated motion.\n\n");
			}
			else
			{
				if (player.esteem < 40)
				{
					outputText("allowing the feeling to wash over you,");
				}
				else if (player.esteem < 60)
				{
					outputText("guessing that she might expect you to do so,");
				}
				else
				{
					outputText("triumphantly noting the rapturous state this puts her in,");
				}
				
				outputText(" then draw yourself off of her rod in a slow, sumptuous motion. \n\n");
			}
			outputText("The torrent of cum continues as you do, and by the time her knob pops through the seal of your lips your mouth is every bit as overfull as your stomach. There is no time to consider what to with it, though, as a white rope splashes across your cheek, notifying you that she is still not finished. ");
			if (!prison.trainingPet.prisonCaptorPetOptedOut() && player.esteem < 15 && player.cor < 10)
			{
				outputText("Almost nauseous from how full you already are but not daring to risk displeasing her, you resign yourself to being painted white as her remaining spurts coat your face and chest.\n\n");
				outputText("\"<i>You didn't swallow without my permission, did you?</i>\" she asks warningly, finally done and her breasts heaving as she catches her breath. You pitifully shake your head no, trying to hold back a vocal sob as tears begin mixing into your sloppy mess of a face.\n\n");
				outputText("\"<i>Good [boy]!</i>\" she says delightedly, seemingly enjoying your discomfort. Out of thin air she produces a pitiful loaf of bread and crumbles it into a bowl. \"<i>You've made me so proud today, you know? You deserve a nice, tasty meal, don't you? Yes you do!</i>\" With a smile of supreme satisfaction, she leans down, holding the bowl beneath your chin with one hand while ruffling your hair with the other, and opens her mouth: \"<i>Now say 'aaah~'</i>\"\n\n");
				outputText("As you mirror her gesture and make the mortifying noise, her seed pours down your chin like a waterfall and before long the bowl is overflowing. She makes little effort to stifle her laughter at your predicament.\n\n");
				outputText("\"<i>And when you eat it up...</i>\" she says as she rises, \"<i>feel free to use only your tongue, if you prefer.</i>\" Her tail gives you one final tantalizing hug, then she releases you with another conspiratorial wink. Without further ado she turns and walks to the door, dripping satisfaction with every step she takes...wait a minute -- wasn't all this effort to earn an <i>untainted</i> meal?\n\n");
				outputText("You know you're in no position to call her out or defy her, but you could try to appeal for your reward politely, or at least get her attention...\n\n");
				outputText("\n\n");
				menu();
				addButton(0, "Say Something", prison.trainingPet.prisonCaptorFeedingBJTrainingPerformPuppyFinale, "complain");
				addButton(1, "Let it Go", prison.trainingPet.prisonCaptorFeedingBJTrainingPerformPuppyFinale, "letgo");
				return;
			}
			if (player.esteem < 40)
			{
				outputText("Wanting to ensure that her final impression of your act is a good one,");
			}
			else if (player.esteem < 60)
			{
				outputText("Not wanting to stumble as you approach the finish line,");
			}
			else
			{
				outputText("Seeing an opportunity to finish your performance with a flourish,");
			}
			
			outputText(" you quickly grab hold of her cock and make a hedonistic show of guiding her remaining spurts over your face and [chest].\n\n");
			outputText("\"<i>Did you swallow without my permission, slave?</i>\" she asks when she is finally done, breasts heaving as she catches her breath. You shake your head no, suddenly grateful that you were too distracted to do anything other than hold her load. \"<i>I can't hear you, [if (esteem < 20) dear][if (esteem >= 20) slave].</i>\" Even engulfed in lust and success as you are, color still floods your cheeks as what she wants to see dawns on you. Regardless, a forceful squeeze from her tail coaxes you into action.\n\n");
			outputText("\"<i>Nooo... Millth... streth...</i>\" you say, head tilted back so as to avoid spilling as you gargle out the syllables. Despite your best efforts, a waterfall of cum still flows down your chin, the sight of which makes her smile from ear to ear.\n\n");
			outputText("\"<i>Good [boy]! Oh, you've made me so proud today. You may swallow once I've left -- masturbate too, should you feel the need.</i>\" Her tail gives you one final tantalizing hug, then she releases you with another conspiratorial wink. ");
			var shortName:Useable = consumables.P_BREAD;
			if (branchChoice == "titfuck" && player.biggestTitSize() < 3)
			{
				outputText("\"<i>And, as promised, here's a special meal to help you grow the tits you so clearly desire. Trust me, you've earned it.</i>\" With no further ado she turns and walks to the door, dripping satisfaction with every step she takes.\n\n");
				itemSelector = rand(4);
				switch(itemSelector)
				{
					case 0:
						shortName = consumables.SUCMILK;
						break;
					case 1:
						shortName = consumables.P_S_MLK;
						break;
					case 2:
						shortName = consumables.LABOVA_;
						break;
					case 3:
						shortName = consumables.P_LBOVA;
						break;
					default:
						shortName = consumables.P_S_MLK;
				}
			}
			else
			{
				outputText("\"<i>And, of course, here is your well-earned meal. Enjoy!</i>\" With no further ado she turns and walks to the door, dripping satisfaction with every step she takes.\n\n");
				shortName = consumables.P_BREAD;
			}
			if (player.obey >= 20)
			{
				outputText("[if (esteem < 40) Unable to control yourself][if (esteem >= 40) Lamenting the scattered remnants of your plans], you do exactly as she suggested the moment she is gone, rubbing [if (esteem < 30) desperately][if (esteem >= 30) distractedly] at your ");
				if (player.hasCock())
				{
					outputText("engorged [cock biggest]");
				}
				else if (player.hasVagina())
				{
					outputText("engorged [clit]");
				}
				else
				{
					outputText("aroused pelvis");
				}
				
				outputText(" while [if (esteem < 30) dutifully][if (esteem >= 30) absentmindedly] ingesting her seed.\n\n");
			}
			if (prison.prisonIsRestrained())
			{
				outputText("With the door once again closed behind her, your restraints reappear.\n\n",false);
			}
			player.slimeFeed();
			player.refillHunger(15);
			lustChange = 75;
			dynStats("lus", lustChange);
			prison.changeEsteem(-5,prison.inPrison);
			prison.changeObey(2,prison.inPrison);
			flags[kFLAGS.PRISON_TRAINING_LEVEL]++;
			if (flags[kFLAGS.PRISON_TRAINING_LEVEL] > 4 && player.obey > 25 + rand(3) - (flags[kFLAGS.PRISON_TRAINING_LEVEL] * 2))
			{
				player.changeStatusValue(StatusEffects.PrisonCaptorEllyStatus,1,3);
				flags[kFLAGS.PRISON_TRAINING_LEVEL] = 0;
			}
			flags[kFLAGS.PRISON_STUDY_BREATHING_UNLOCKED] = 1;
			inventory.takeItem(shortName, camp.returnToCampUseOneHour);
		}
		
		public function prisonCaptorFeedingTitleTraining():void
		{
			clearOutput();
			var refuse:Function = prisonCaptorFeedingTrainingRefuse;
			var accept:Function = prisonCaptorFeedingTitleTrainingAccept;
			var reject:Function = prisonCaptorFeedingTrainingReject;
			var perform:Function = prisonCaptorFeedingTitleTrainingPerform;
			if (flags[kFLAGS.PRISON_TRAINING_LEVEL] == 0)
			{
				outputText("Curled up on the floor in a miserable fog of thought and pondering how you found yourself in this hopeless situation, you are startled by the sound of the door to your cell being quickly opened and confidently slammed shut. You look up to see [captorTitle] [captorName] studying you with an amused expression. Just as when you first met her, you are alarmed by the extent to which her commanding presence, intoxicating charisma, and exotic beauty pacifies you. For some reason, your usual instinct when presented with a threat, to defend yourself with force, refuses to activate  -- and even if it did, ",false);
				if (player.level < 3)
				{
					outputText("you know without a doubt that you lack the experience to fight a creature this powerful.",false);
				}
				else if (player.level < 8)
				{
					outputText("her clearly formidable power erodes your usual confidence when evaluating an opponent.",false);
				}
				else
				{
					outputText("as confident and experienced a warrior as you may be, an uncommon sense of self doubt drives you to exercise caution.",false);
				}
				
				outputText("\n\nIt crosses your mind that this feeling could be the result of some foul spell or trickery being worked on you, but the result is the same: you have no choice but to engage her in a battle of her choosing, one of willpower and cunning, rather than your preferred approach to combat. As you steel yourself for the first salvo, she clearly notices your change in countenance and gives a light hearted and disarming laugh.",false);
				outputText("\n\n\"<i>Oh dear, you look rather upset. You should be happy; I'm here to feed you. But it's understandable, I suppose -- after all, you are a poor, frightened, directionless little wreck of a creature aren't you? Oh, it makes me so sad to see you this way.</i>\" She is anything but sad. In fact, with each sentence she seems less and less able to contain her mirth, clearly enjoying your every grimace like a mischievous cat toying with a cornered mouse. \"<i>Well, put your mind at ease, slave. Today we are going to begin the process of fixing you, and before long I'll have you living contentedly with your true nature. We'll start small and simple, too -- you'll be surprised by how painless and easy it is to please your Mistress and earn your meal for the day.</i>\"",false);
				if (prison.prisonIsRestrained())
				{
					outputText("\n\nWith a snap of her fingers, your restraints vanish into thin air.",false);
				}
				outputText("\n\nShe gives you a condescending pat on the head, and you seethe with shame and impotent rage, meekly enduring the gesture. As she then trails her graceful fingers down the side of your face, the shame intensifies but the rage melts into desire, and [if (sensitivity < 50) it is all you can do to resist the urge to][if (sensitivity >= 50) you are overcome by an urge to] lean into her electrifying caress. Her capacity to play your emotions like a fine instrument is deeply alarming, and for a moment it occurs to you that you may even be less equipped to fight this demon emotionally than you are phyiscally. You are denied the time to dwell on it, though, as she ends her caress. Squatting down on her haunches, she takes your chin in a soft but firm grasp, enthralling your gaze with her piercing violet eyes.\n\n",false);
				outputText("\"<i>The first step is to learn to show your Mistress the proper respect.</i>\" Just as in your first encounter she drifts closer to you as she speaks, overwhelming your senses with her powerful scent. \"<i>All you need to do is politely say one little sentence for me.</i>\" She lightly tilts your chin in her grasp, your eyes drifting down to watch her moist, shapely lips mouth the words you are to learn with a lilting, pliable voice. \"<i>Hello Mistress, how may I serve you today?</i>\" Her thumb grazes across your lower lip and [if (libido >= 60) your mouth involuntarily drifts open, as if inviting the intruder in][if (libido < 60) you blush at the rush of excitement the touch sends through your body]. A knowing smile crosses her face[if (libido >= 60)  and her tail curls behind her back], but she doesn't press the advantage. Instead she backs off, perhaps to see how you react when not so directly under her overpowering influence.\n\n",false);
				flags[kFLAGS.PRISON_TRAINING_LEVEL] = 1;
			}
			else if (flags[kFLAGS.PRISON_TRAINING_LEVEL] == -1)
			{
				outputText("The door to your cell opens and you look up to see [captorTitle] [captorName] enter the room with an air of stern disappointment. ",false);
				if (prison.prisonIsRestrained())
				{
					outputText("She snaps her fingers and your restraints vanish into thin air. ",false);
				}
				outputText("\"<i>You poor little slave. I'm afraid I've come dangerously close to letting you down. I was so excited by your progress that I moved you on to more advanced lessons before you truly absorbed the first one. Thankfully, we still have time to fix that, but I'm afraid that we're going to have to go back to basics today and give you another chance to focus on learning the proper respect.</i>\" She approaches you with genuine compassion, her expression sympathetic and her steps surprisingly gentle against the hard floor. Then, more quickly than your eye can track the motion, her leather laced arm snaps back and her palm strikes your cheek with enough force to send you tumbling over sidewise onto the floor.\n\n",false);
				outputText("Just as quickly, she kneels at your side and lifts your head up by your [hair]. Her posture is now imposing and her face now fierce, but she maintains her caring tone of conversation. \"<i>Now, you remember your lesson, don't you? All you need to do is politely say one little sentence for me and you'll have a nice nourishing meal to enjoy. You know the words to say, yes?</i>\" She lets loose her grip on you and stands back up, looming over you with her cock fully erect and throbbing. \"<i>Hello Mistress, how may I serve you today?</i>\" As she intones the words her body seems to clinch with pleasure, her tail twisting through the air, and several drops of precum leak from her shaft and splash across your [face]. One final drop lands on your lips",false);
				if (player.cor > 30)
				{
					outputText("and momentarily overwhelmed by the musty scent of it, your tongue darts out to taste it.",false);
				}
				else
				{
					outputText(" and the musty scent of it nearly overwhelms you.",false);
				}
				outputText(" A knowing smile crosses her face, but she doesn't press the advantage. Instead she steps back, perhaps to see how you react when not so directly under her overpowering influence.\n\n",false);
				flags[kFLAGS.PRISON_TRAINING_LEVEL] = 1;
			}
			else
			{
				outputText("The door to your cell opens and you look up to see [captorTitle] [captorName] enter the room swinging her hips with cheerful, seductive purpose. She approaches you and treats you to a mocking pouty face. \"<i>Looking a bit hungry there, slave. Are you ready for your lesson then?</i>\" [if (hunger > 50) As if on cue, your stomach rumbles. ]She reaches out and runs her fingers softly over your chin and jaw.\"<i>All you need to do is politely say that one little sentence for me.</i>\"\n\n",false);
				if (prison.prisonIsRestrained())
				{
					outputText("With a snap of her fingers, your restraints vanish into thin air. ",false);
				}
				outputText("She lightly tilts your chin and your eyes drift down to see her moist, shapely lips as she mouths the words you are to learn. \"<i>Hello Mistress, how may I serve you today?</i>\" Her thumb grazes across your lower lip and [if (libido >= 40) your mouth involuntarily drifts open, as if inviting the intruder in][if (libido < 40) you blush at the rush of excitement the touch sends through your body]. A knowing smile crosses her face, but she doesn't press the advantage. Instead she backs off, perhaps to see how you react when not so directly under her overpowering influence.\n\n",false);
			}
			
			outputText("You consider how you should respond to Mistress Elly's order.\n\n",false);
			if (player.hunger <= 0 && (player.esteem < 40 || player.esteem < 60 && player.obey > 10))
			{
				outputText("\nYou are simply too hungry to refuse to do as you are told.\n",false);
				refuse = null;
				reject = null;
			}
			else
			{
				outputText("You could meekly refuse " + prison.prisonWillCostDescript(5),false);
				if (player.esteem < 20 || player.esteem < 40 && player.obey > 25)
				{
					outputText(" but you don't think you could manage any stronger a defense of your dignity due to your your obvious powerlessness and insignificance.",false);
					reject = null;
				}
				else
				{
					outputText(" or you could angrily reject the order " + prison.prisonWillCostDescript(15) + ".",false);
				}
			}
			if (player.hunger > 0 && player.esteem > 75 && player.obey < 5)
			{
				outputText("\n\nYou have too much dignity to do as you have been told.\n",false);
				accept = null;
				perform = null;
			}
			else
			{
				outputText("\n\nYou could give in and accept Mistress Elly's order, ",false);
				if (player.esteem > 90 || player.esteem > 60 && player.obey < 8)
				{
					outputText("but you have too much dignity to really put your heart into it.\n",false);
					perform = null;
				}
				else
				{
					outputText("or you could really show your acceptance of your position and perform above and beyond what she's asked for. \n",false);
				}
			}
			addButton(0, "Refuse", refuse);
			addButton(1, "Accept", accept);
			addButton(5, "Reject", reject);
			addButton(6, "Perform", perform);
		}
		
		public function prisonCaptorFeedingBJTraining():void
		{
			clearOutput();
			var refuse:Function = prisonCaptorFeedingTrainingRefuse;
			var accept:Function = prisonCaptorFeedingBJTrainingAccept;
			var reject:Function = prisonCaptorFeedingTrainingReject;
			var perform:Function = prisonCaptorFeedingBJTrainingPerform;
			if (flags[kFLAGS.PRISON_TRAINING_LEVEL] == 0)
			{
				outputText("The door to your cell opens and you realize it must be feeding time as [captorTitle] [captorName] enters the room with a sense of mischievous purpose. \"<i>Hello, <b>slave</b>,\"</i> she purrs, and punctuates the word with a single forceful tap of her spiked boot heel against the floor. The sharp, harsh clack rings in your ears, bringing an unbidden but now familiar rush of adrenaline to your heart.\n\n");
				outputText("\"<i>Hello Mistress, how may I serve you today?</i>\"\n\n");
				outputText("The conditioned response pours from your mouth in the lilting, sycophantic tone that she suggested during your lessons. As it slips through your lips, you ");
				if (player.esteem < 40)
				{
					outputText("blush");
				}
				else if (player.esteem < 60)
				{
					outputText("blink");
				}
				else
				{
					outputText("grimace");
				}
				
				outputText(" at the realization that she didn't even ask[if (esteem < 15) , though saying it did feel, well, good..][if (esteem > 50) , infuriated at having acted without thinking].[if (esteem > 60) You scramble to regain some control of the situation but you aren't afforded enough time to think, let alone act.]\n\n");
				outputText("\"<i>Good " + player.mf("boy", "girl") + ".</i>\" You see a brief shudder of ecstasy race through her body, her mouth drifting agape, her eyes rolling into their sockets, and her spade-tipped tail twitching behind her. \"<i>Now that you've mastered your first lesson, slave, you can begin to learn the answer to that question.</i>\"\n\n");
				outputText("Though her composure returns, she continues to grin from ear to ear, making no attempt to conceal how pleased she is with herself. \"<i>A good slave knows to ask [his] Mistress what she wants without thinking. A better slave begins answering the question as [he] asks it. But to do so, a slave needs to understand what [his] owner wants from [him]. Some Masters might want to see their slaves pose seductively, or hear them speak words of reverence and praise, or simply have them wait motionless for direction. That's all fine, but I like my slaves to be a bit more... expressive of their love for me.</i>\"");
				if (prison.prisonIsRestrained())
				{
					outputText(" With a snap of her fingers, your restraints vanish into thin air.\n\n",false);
				}
				else
				{
					outputText("\n\n");
				}
				outputText("\"<i>Most of my slaves have to learn exactly what that means through trial and error, but you show special promise.</i>\" She scratches her chin in an intentionally exaggerated gesture of contemplation. \"<i>Yes, I can see that you want to become the best slave possible as quickly as you can, so I'm going to make an exception and let you skip that step.</i>\" She strides across the room to where you sit and looks down at you, trailing her index finger purposefully over your cheek towards your mouth.\n\n");
				outputText("\"<i>What I want is to see my slave crawl across [his] cell to meet me, kneel at my feet, and wrap [his] ");
				if (player.femininity < 35)
				{
					outputText("strong, manly lips");
				}
				else if (player.femininity < 65)
				{
					outputText("supple, inviting lips");
				}
				else
				{
					outputText("plump, sexy lips");
				}
				
				outputText(" around my juicy, delicious cock.</i>\" Her fingernail rakes across your lips as she says it and you pull your head away in [if (esteem < 30) abashed ][if (esteem < 50) shame][if (esteem >= 50) anger][if (esteem >= 70)  and indignation]. [if (corruption < 30) The nature of the request is hardly a surprise but it still embarrasses you to face it head on.][if (corruption >= 30) While the suggestion is actually tame compared to things you've seen and done in your time in Mareth, it still twists a knife in your gut in this context.] She chuckles at your reaction, squatting down to [if (esteem < 50) gently][if (esteem >= 50) forcefully] turn your head back to her eyes.\n\n");
				outputText("\"<i>Oh dear, so modest. ");
				if (player.cor < 30)
				{
					if (player.pregnancyType > 0 && player.pregnancyIncubation > 0 && player.pregnancyIncubation <= 280)
					{
						outputText("You shudder and blush,</i>\" she gives your swollen belly a gentle pat, \"<i>but I'd say you've had at least one cock inside of you recently. Oh, I know, it wasn't your choice -- some mean old monster attacked you, right? And when he overpowered you and took your precious virginity, you didn't enjoy yourself even for a moment. Well, don't worry darling; I'm no monster, and you <b>will</b> enjoy it with me. ");
					}
					else
					{
						outputText("Don't worry, baby, you'll get the hang of it. You shudder and blush now, but you'll be shocked by how much fun you'll have once you get started. ");
					}
				}
				else if (player.pregnancyType > 0 && player.pregnancyIncubation > 0 && player.pregnancyIncubation <= 280)
				{
					outputText("It's a cute act,</i>\" she gives your swollen belly a gentle pat, \"<i>but I can see as plain as day how much you love a good cock inside of you. One day very soon you'll be begging me to put a baby in there myself, but for now you can pretend all you like. I'll even play along. ");
				}
				else
				{
					outputText("Playing the shrinking violet I see. But I also I see the longing in your eyes, slave,</i>\" her glance flicks down to your crotch, \"<i>and I smell the arousal on your skin. But by all means, pretend you don't want it if you like. I'll even play along. ");
				}
				
				outputText("I'll take it nice and slow, and I'll tell you exactly what to do. You won't have to think, just let your body act.</i>\"\n\n");
				outputText("Her almond shaped eyes narrow as she looks you over in ravenous appraisal, her lithe finger following close behind the path of her eyes. Your [nipples] [if (sensitivity > 40) stand at attention][if (sensitivity <= 40) tingle]");
				outputText(" as it passes down the middle of your [fullChest] and ");
				if (player.hasCock())
				{
					outputText("[eachCock] [if (libido > 40) hardens][if (sensitivity <= 40) stirs]");
				}
				else if (player.hasVagina())
				{
					outputText("your [clit] [if (libido > 40) hardens][if (sensitivity <= 40) stirs]");
				}
				else
				{
					outputText("your [asshole] [if (libido > 40) clenches][if (sensitivity <= 40) stirs]");
				}
				
				outputText(" as the finger teases its way around your pubic mound. She leans in close and whispers huskily in your ear, \"<i>Trust me, it knows what to do. Listen to it, and learn the truth about yourself.</i>\"\n\n");
				outputText("Abruptly, she stands and walks back across the room, affording you a brief moment to collect your thoughts. \"<i>Now, slave: <b>start crawling</b>.</i>\"\n\n");
				flags[kFLAGS.PRISON_TRAINING_LEVEL] = 1;
			}
			else if (flags[kFLAGS.PRISON_TRAINING_LEVEL] == -1)
			{
				outputText("The door to your cell opens and you realize it must be feeding time as [captorTitle] [captorName] enters the room. ");
				if (prison.prisonIsRestrained())
				{
					outputText("She snaps her fingers to remove your restraints and looks at you expectantly,",false);
				}
				else
				{
					outputText("She looks at you expectantly,");
				}
				outputText(" but when you stare back at her blankly she becomes annoyed. \"<i>Hello, <b>slave</b>,\"</i> she snaps, and punctuates the word with a single forceful tap of her spiked boot heel against the floor. The sharp, harsh clack rings in your ears, bringing the familiar rush of adrenaline to your heart. The conditioned response pours from your mouth[if (esteem < 15) , giving you strong reminder of how good it can feel to follow her lead][if (esteem > 50) , frustrating you as you realize that you still cannot control this behavior].\n\n");
				outputText("\"<i>Hello Mistress, how may I serve you today?</i>\" You even find yourself saying it in the lilting, sycophantic tone that Mistress Elly suggested while teaching you this lesson. [if (esteem < 40) You hope that your spirited performance will help her forgive whatever you have done to upset her.][if (esteem > 60) Your bruised ego is comforted by the thought that your show of spirit might sweeten her sour mood, and perhaps prevent retribution.] After a tense moment in which you feel her foul temper radiate across the distance between you, she softens.\n\n");
				outputText("\"<i>Well, at least you still remember your manners. But you know very well that you should be answering that question from the moment you speak it.</i>\" Her tone is that of a teacher correcting a habitually slow student as she lectures you from where she stands, and you ");
				if (player.esteem < 40)
				{
					outputText("avert your gaze shamefully to the floor");
				}
				else if (player.esteem < 60)
				{
					outputText("shift uncomfortably and look around the room");
				}
				else
				{
					outputText("roll your eyes and stare at the ceiling");
				}
				
				outputText(" in response. \"<i>You also know exactly how I expect you to be answering it. Frankly, slave, you are <b>disappointing</b>.</i>\"\n\n");
				outputText("The last word is a loud hiss in your ear; somehow in the moment you weren't watching she ceased to be standing by the door and reappeared crouching behind you. With your mind reeling to comprehend her impossible movement, you fail to respond when she grabs your arms, holds them behind your back with one hand, and ");
				if (player.hasKeyItem("Mistress Elly's Slave Collar") >= 0)
				{
					outputText("violently tugs at the ring on the back of your collar with the other.");
				}
				else
				{
					outputText("wraps the other tightly around the front of your throat.");
				}
				outputText(" Your head is pulled backward and immobilized and your breathing is restricted as she continues to whisper fiercely in your ear.\n\n");
				outputText("\"<i>But I know you don't want to disappoint me. You want to be a good little slave, and relearn the lesson you seem to have forgotten. So pay close attention.</i>\" She gives another pull at your throat and you tilt backward, your arms now pinned tightly between your torso and hers, the arousing warmth of her soft but powerful form captivating your senses.\n\n");
				outputText("\"<i>When I tell you to, you will <b>crawl</b> across the floor to meet me.</i>\" A flick of her moist tongue across the back rim of your earlobe makes your body explode in goosebumps. \n\n");
				outputText("\"<i>You will <b>kneel</b> at my feet.</i>\" A sharp nibble makes your back arch and your chest jut forward in surprise, ");
				if (player.biggestTitSize() > 1)
				{
					outputText("your [fullChest] bouncing lewdly and ");
				}
				outputText("your [nipples] instantly hard. \n\n");
				outputText("\"<i>And you will wrap your ");
				if (player.femininity < 35)
				{
					outputText("manly lips");
				}
				else if (player.femininity < 65)
				{
					outputText("supple lips");
				}
				else
				{
					outputText("plump lips");
				}
				
				outputText(" around my shaft like the dirty, ");
				if (player.pregnancyType > 0 && player.pregnancyIncubation > 0 && player.pregnancyIncubation <= 280)
				{
					outputText("pregnant, ");
				}
				outputText("<b>cock-hungry</b> little bitch that you are.</i>\" She gives one last tug at your neck, then releases your arms and shoves you forward. You are so off balance that you completely fail to catch yourself, tumbling unceremoniously, face first into the floor. By the time you manage to collect yourself and look back up, she is once again standing by the door.\n\n");
				outputText("\"<i>Now, slave: <b>start crawling</b>.</i>\"\n\n");
				flags[kFLAGS.PRISON_TRAINING_LEVEL] = 1;
			}
			else
			{
				outputText("The door to your cell opens and you realize it must be feeding time as [captorTitle] [captorName] enters the room with a confident air about her. \"<i>Hello, <b>slave</b>,\"</i> she sings, punctuating the word with a single forceful tap of her spiked boot heel against the floor. The sharp, harsh clack rings in your ears, bringing a familiar rush of adrenaline to your heart. The conditioned response pours from your mouth[if (esteem < 15) , filling you with a queer sense of comfort][if (esteem > 50) , annoying you as you realize that you cannot control this behavior].\n\n");
				outputText("\"<i>Hello Mistress, how may I serve you today?</i>\" you find yourself saying in the lilting, sycophantic tone that she suggested while teaching you this lesson. [if (esteem > 60) While it stings your ego to repeat the words again, the thought that you may have at least earned yourself some good favor provides some comfort.]\n\n");
				if (prison.prisonIsRestrained())
				{
					outputText("With a snap of her fingers, your restraints vanish into thin air.",false);
				}
				outputText("\"<i>You're a good slave for asking, but you know that you would be a better slave if you were already acting.</i>\" She crosses her arms, shifts her weight to her other foot, and you hear a note of impatience lace her voice. \"<i>If you want to eat, you need to learn to please me even before I give you instructions. So:</i>\"\n\n");
				outputText("\"<i>First, crawl across the room. Be sure to arch your back so that you present your [ass] like a bitch in heat");
				if (player.tailType > 0)
				{
					outputText(" -- and wag that cute little tail while you're at it.</i>\"");
				}
				else if (player.hasCock())
				{
					outputText("-- and wag that cute little...tail...while you're at it.</i>\" ");
					if (player.esteem < 30)
					{
						outputText("Your cheeks ignite as your \"tail\" stirs from");
					}
					else
					{
						outputText("You bristle at");
					}
					outputText(" her implication.");
				}
				else if (player.biggestTitSize() >= 1)
				{
					outputText("-- and jiggle those [chest] while you're at it.</i>\"");
				}
				else
				{
					outputText(".");
				}
				
				
				outputText("\n\n");
				outputText("\"<i>Next, kneel at my feet. Chin up, eyes forward, back arched again so that you are presenting your [chest] to me. It will put you in the right state of mind for what comes next.</i>\"\n\n");
				outputText("\"<i>Finally: lean forward, open your slutty mouth, wrap your ");
				if (player.femininity < 35)
				{
					outputText("strong, manly lips");
				}
				else if (player.femininity < 65)
				{
					outputText("supple, inviting lips");
				}
				else
				{
					outputText("plump, sexy lips");
				}
				
				outputText(" around the tip of my dick, and start pumping. Continue to do so until my cum is leaking from the corners of your mouth and dripping down your chin. Then keep going until I tell you that you can stop.</i>\"\n\n");
				outputText("\"<i>Understand? Good. Now, slave: <b>start crawling</b>.</i>\"\n\n");
			}
			
			outputText("You consider how you should respond to Mistress Elly.\n\n",false);
			if (player.hunger <= 0 && (player.esteem < 40 || player.esteem < 60 && player.obey > 25))
			{
				outputText("\nYou are simply too hungry to refuse to do as you are told.\n",false);
				refuse = null;
				reject = null;
			}
			else
			{
				outputText("You could meekly refuse " + prison.prisonWillCostDescript(5),false);
				if (player.esteem < 15 || player.esteem < 35 && player.obey > 35)
				{
					outputText(" but you don't think you could manage any stronger a defense of your dignity due to your your obvious powerlessness and insignificance.",false);
					reject = null;
				}
				else
				{
					outputText(" or you could angrily reject the order " + prison.prisonWillCostDescript(15) + ".",false);
				}
			}
			if (player.hunger > 0 && player.esteem > 85 && player.obey < 15)
			{
				outputText("\n\nYou have too much dignity to do as you have been told.\n",false);
				accept = null;
				perform = null;
			}
			else
			{
				outputText("\n\nYou could give in and accept Mistress Elly's order, ",false);
				if (player.esteem > 70 && player.obey < 20)
				{
					outputText("but you have too much dignity to really put your heart into it.\n",false);
					perform = null;
				}
				else
				{
					outputText("or you could really show your acceptance of your position and perform above and beyond what she's asked for. \n",false);
				}
			}
			addButton(0, "Refuse", refuse);
			addButton(1, "Accept", accept);
			addButton(5, "Reject", reject);
			addButton(6, "Perform", perform);
		}
		
		public function prisonCaptorFeedingOrgasmTraining():void
		{
			clearOutput();
			var refuse:Function = prisonCaptorFeedingTrainingRefuse;
			var accept:Function = prisonCaptorFeedingOrgasmTrainingAccept;
			var reject:Function = prisonCaptorFeedingTrainingReject;
			var perform:Function = prisonCaptorFeedingOrgasmTrainingPerform;
			if (flags[kFLAGS.PRISON_TRAINING_LEVEL] == 0)
			{
				if (prison.prisonIsRestrained())
				{
					outputText("Mistress Elly enters the room and with a snap of her fingers, your restraints vanish into thin air.",false);
				}
				else
				{
					outputText("Mistress Elly enters the room and waits by the door.");
				}
				outputText(" Guessing it must be feeding time, you decide to save yourself the indignity of being prompted to do so and offer her your deferential greeting in a now habitual lilting tone.\n\n");
				outputText("\"<i>Hello Mistress, how may I serve you?</i>\" This concession having been freely made, though, you realize ");
				if (player.esteem < 40)
				{
					outputText("you ought to just go ahead and do what comes next. She will be happy to see you eager to please her, and life is much more bearable when she is happy.");
				}
				else if (player.esteem < 60)
				{
					outputText("that while you can only accept so much abuse, there really is no point in resisting what comes next. You will be doing it anyway, so you might as well keep her happy by doing so without being told to.");
				}
				else
				{
					outputText("that it probably be wise to go ahead and do what comes next without being prompted as well. The lesson may have been hard learned, but you now understand the value of showing her the courtesy she demands of you.");
				}
				
				outputText("\n\n");
				outputText("Once you've begun the humbling but unavoidable journey, it's almost shocking how much more naturally the act of slinking across the cold stone floor comes to you now that you are not being coerced into doing so. You find yourself unexpectedly adept at managing the seductive swing of your hips that is the cornerstone of the act, and effortlessly add a playful arch and bounce to each stride. And when your flirtatious antics begin to draw giggles of delight from your Mistress, you grudgingly allow yourself to enjoy a moment of [if (esteem < 40) satisfaction][if (esteem >= 40) pride] at a job well done.\n\n");
				outputText("This lighthearted ease quickly dissapates upon arriving in her shadow, though. Thinking of what comes next, you find yourself once again harried by the specters of hesitation[if (corruption < 20) , pious outrage,] and self loathing. ");
				if (player.esteem < 40)
				{
					outputText("You know that these feelings are justified, but it is plainly obvious that you don't have the ability to indulge them anymore. In order to buy yourself a moment to chase them away and replace them with the subservient spirit you need for the task ahead, you lower your head to the ground and polish the toe of her boot with your tongue. Only when it glistens below you do you rise docilely and set yourself to work.\n\n");
				}
				else if (player.esteem < 60)
				{
					outputText("While you allow these feelings to steep in the back of your mind, you know that now is not the time to indulge them. Masking them behind a pouty, doe-eyed look of longing, you gather in their place a sense of composed surrender. Nerves properly settled, you then rise to your knees with an air of polite dignity and set about the task at hand.\n\n");
				}
				else
				{
					outputText("As much as you would like to indulge these feelings, you know that it would be counterproductive to do so. Instead, you assume an air of self-possessed immodesty and joyfully rise to your haunches, back arched and [chest] thrust forward [if (corruption < 20) assertively][if (corruption >= 20) seductively], and attack the task at hand with flirtatious enthusiasm.\n\n");
				}
				
				outputText("Once your lips close around her tip, things suddenly become simple again. Your senses are instantly awash in her musky aromas, her uniquely pleasant, savory yet sweet taste, and the silky, alluring feel of her skin. The rush of confused but arousing emotions that they conjure within you ease you into a state of relaxed focus [if (esteem < 40) and unanticipated comfort][if (esteem >= 40) despite your troubled mind]. While you do apply a small amount of conscious effort towards satisfying your Mistress, mostly you [if (esteem < 40) surrender yourself to][if (esteem >= 40) rely on] muscle memory and allow your body to act on your behalf -- and despite the stirring in your loins, you remain [if (esteem < 60) thankful that your body is now capable of carrying you through your act][if (esteem >= 60) glad that your body is working in your favor now].\n\n");
				outputText("Experienced as your body now is at servicing her this way, it isn't long before her dick is deep in your throat pouring her seed directly into your stomach. Mindful of her preferences, you wait until her torrent to begins to subside, then pull back slowly, savoring the sensations as you [if (esteem < 40) succumb][if (esteem >= 40) resign yourself] to the lustful nature of the act. You pause to massage her tip lavishly with your lips until your tongue is swimming in jizz, then finally pull her from your mouth so that the last few spurts can coat your [face] and [chest] with a pale, viscous reminder of your servile compliance.\n\n");
				outputText("\"<i>My, my, my, what a good little [boy] you've become -- and in such a short time too. You may swallow your reward.</i>\" Spasms of pleasure continue to shiver across her body as she compliments you, unquestionably beyond pleased with your display, and you are inundated by an unbidden rush of [if (esteem < 50) fulfillment][if (esteem >=50) confidence] as you ingest her load.");
				if (player.hasKeyItem("Mistress Elly's Slave Collar") < 0)
				{
					player.createKeyItem("Mistress Elly's Slave Collar",0,0,0,0);
					prison.trainingPet.prisonCaptorPetTierUpdate();
					outputText(" \"<i>Now that you've accepted what an insatiable, dutiful little cocksucker you are, I think it is time for me to give you a very special gift.</i>\" She produces a long, thin strip of malevolent shiny black material about an inch wide, with a violet gemstone affixed in the middle and a steel ring on one end. \"<i>This collar is an acknowledgment of what you've been working so hard to become. It will be a constant reminder to you and everyone who sees you that you are my valued property.</i>\" She leans forward and wraps it around your neck so that the gem rests atop your windpipe, but instead of the sound of a buckle or snap that you expect to hear there is an odd sizzle and pop. \"<i>There you go, darling.</i>\"\n\n");
					outputText("You reach up to feel your new adornment. It is fit so snugly around your throat that you feel its constriction every time you swallow or inhale deeply, and it will not rotate or shift about your neck even the smallest bit. Your fingers follow its line around to the back of your neck and find the steel ring positioned in the center, where it provides a convenient location to attach a leash or chain. But as the sounds you heard hinted, there is no buckle or button or fastener of any other sort to be found. The strap seems to have fused to itself to form a permanent unbroken loop, with no apparent method of removal. The thought of it sits heavily in your gut.\n\n",false);
					outputText("\"<i>Oh, such a pretty sight. Don't you just love it, slave?</i>\" ");
					if (player.esteem < 40)
					{
						outputText("Although it is rather uncomfortable, you admit to yourself that in a very primal way it is satisfying to have your efforts recognized like ");
					}
					else if (player.esteem < 60)
					{
						outputText("Although it is rather uncomfortable, it seems to have put her in an especially good mood to have given you this gift, and you've come to appreciate anything that keeps her happy.");
					}
					else
					{
						outputText("If it serves as a tool to help keep you on her good side, you suppose it might be worth putting up with the undeniable discomfort it brings.");
					}
					
					outputText(" Her look of appraisal tells you that your jumbled feelings must be showing on your face, but she continues on as if you were entirely joyful. \"<i>Yes, I can see how much you do. And now that that's taken care of, let's discuss how you'll be earning your meal for today.</i>\"\n\n");
				}
				else
				{
					outputText(" \"<i>It's plain to see that you've taken my lessons to heart and are becoming comfortable with what an insatiable, dutiful, little cocksucker you are. But now that you've enjoyed your appetizer,</i>\" she scrapes a bit of her fluid from your face with her index finger and smears it across your already cum-soaked lips, \"<i>we can discuss how you'll be earning your meal for today.</i>\"\n\n");
				}
				if (player.esteem < 40)
				{
					outputText("Even in your dazed and malleable state, her words hit you like a blow to the stomach, and you look up at her with a wide-eyed look of despair, face glowing red between dripping layers of milky white. You've just freely given her everything she's ever asked of you, and you are unsure what more you could possibly do for her.");
				}
				else if (player.esteem < 60)
				{
					outputText("Her words pull you out of your cum-drunk haze, and hit you like a slap in the face. You look up with her with a look of indignant betrayal, and you feel your lower lip begin to twitch at the sudden reminder of your helplessness. Is the drippy, debauched mess you've made of yourself not enough for her? What more could she want from you?");
				}
				else
				{
					outputText("A second ago you were inclined to bathe your lusty success, but her words bring forth the painful realization that you were signaling far more than you understood with your actions. It was still probably wise to capitulate as you did, but it bothers you that your growing desire blinded you to what was likely to come next.");
				}
				
				outputText(" But before you can regain some semblance of balance and turn your troubled expression into a more concrete objection, you are sent reeling once again as Mistress Elly gives your cheek a playful smack -- with her cock. The impact, though harmless, is surprisingly sharp, and between the scandalously sloppy sound reverberating in your ear and the accelerated sensation of your syrupy mask melting over your jawline and down our neck, you're left utterly stunned and mortified.\n\n");
				outputText("\"<i>No moping, slave. Your heartfelt show of respect and subservience is appreciated, but you know that you don't earn your meals by doing what is expected of you. You earn them by learning new things. But cheer up,</i>\" she comforts, pressing her knob to your cheek and slowly, sensually beginning to trace it through her muck, \"<i>I think you'll enjoy this lesson almost as much as you love sucking cock.</i>\" As her bulbous member sweeps downward across your dripping chin, then back up the other sloppy cheek and over the bridge of your nose, you awaken from your cock-slapped daze -- not with the outrage you [if (esteem < 40) might deserve ][if (esteem >= 40) had been channeling previously] -- but in the bewildering jumble of pacifying arousal and [if (esteem < 40) soothing][if (esteem >= 40) reluctant] resignation that you felt servicing her just moments ago.\n\n");
				if (player.cor < 30)
				{
					if (player.esteem < 30)
					{
						outputText("As she draws ever tighter circles around your mouth you shrink away, more abashed at your own reaction than by her actions. \"<i>Oh, come now, dear,</i>\" she titters, \"<i>I think we've moved beyond playacting.</i>\"");
					}
					else if (player.esteem < 60)
					{
						outputText("She continues to draw ever tightening circles around your mouth, while you struggle against an immodest urge to chase after the illicit sensation. \"<i>I see what you want dear.</i>\" she titters, \"<i>And I promise you will get it.</i>\"");
					}
					else
					{
						outputText("You glare at her indignantly as her cock draws ever tighter circles around your mouth, wishing deeply that there was more authentic feeling in your defiance. \"<i>Oh, come now, dear,</i>\" she titters, \"<i>I think we've moved beyond playacting.</i>\"");
					}
					
				}
				else if (player.esteem < 30)
				{
					outputText("As her cock draws ever tighter circles around your mouth, you are unable to resist the urge to open your mouth in passive invitation. \"<i>Oh, my!</i>\" she titters, \"<i>You are quite the eager little slave, aren't you?</i>\"");
				}
				else if (player.esteem < 60)
				{
					outputText("To your chagrin, you find yourself chasing after her cock as it draws ever tighter circles around your mouth. \"<i>Aww, see?</i>\" she titters, \"<i>you're already getting back in the spirit.</i>\"");
				}
				else
				{
					outputText("She continues to draw ever tightening circles around your mouth, while you struggle against an intense urge to chase after the delightful sensation. \"<i>I see what you want dear.</i>\" she titters, \"<i>And I promise you will get it.</i>\"");
				}
				
				
				outputText(" Pressing her advantage, she drags her tip across your moist lips, which [if (esteem < 30) longingly part in its wake][if (esteem >= 30) frustrate you by gently parting in its wake]. \"<i>Now, dear, I'm going to allow you to taste me again,</i>\" her tip teases through your lips, \"<i>and you are going to show me your gratitude by rubbing that cute little ");
				if (player.hasCock())
				{
					outputText("cock");
				}
				else if (player.hasVagina())
				{
					outputText("clit");
				}
				else
				{
					outputText("asshole");
				}
				
				outputText(" for me, nice and slow.</i>\" ");
				if (player.cor < 30)
				{
					outputText("You make a halfhearted attempt to pull away from her impish prodding, but she presses her offense faster than you can retreat. Impaled once again, you [if (esteem < 60) coyly][if (esteem >= 60) wearily] acquiesce and allow your now well-schooled mouth to suckle at her once more.\n\n");
				}
				else
				{
					outputText("Unable to resist her goading any longer you attempt to grasp her in your mouth, only to bite air as she retreats beyond your reach. She taunts you in this manner twice more before finally allowing you to catch her, and your well schooled response overcomes your waning reluctance as you start to suckle once more.\n\n");
				}
				outputText("\"<i>Yessss, that's a good, good [boy]. Now, that we've settled that matter, it is time for you to learn that your pleasure comes at my whim. You may continue to suck my cock, but you will masturbate as you do, and you will come when -- and only when -- I tell you to. Is that understood, slave?</i>\"\n\n");
				outputText("The heat coursing through your body practically begs you to do as you have been told, but even as you[if (corruption > 30)  greedily] lick the salty leavings from her shaft you still feel reluctant to allow her such intimate control over your body.\n\n");
				flags[kFLAGS.PRISON_TRAINING_LEVEL] = 1;
			}
			else if (flags[kFLAGS.PRISON_TRAINING_LEVEL] == -1)
			{
				if (prison.prisonIsRestrained())
				{
					outputText("Mistress Elly enters the room and with a snap of her fingers, your restraints vanish into thin air.\n\n",false);
				}
				else
				{
					outputText("Mistress Elly enters the room and waits by the door.\n\n");
				}
				outputText("\"<i>Hello Mistress, how may I serve you?</i>\" You say dutifully, knowing it must be feeding time, but for some reason you find yourself gripped by an unexpected anxious reluctance and sit still dumbly rather than reacting to her presence as you should. She looks at you expectantly for a few moments, but when you continue to waver in an uncomfortable panic her face clouds over with a look of genuine concern.\n\n");
				outputText("\"<i>Are you feeling okay, dear?</i>\" Her soft, caring tone alone goes a long way towards calming your nerves ");
				if (player.esteem < 40)
				{
					outputText("and gives you hope that your failure to act promptly might not have disappointed her too much.");
				}
				else if (player.esteem < 60)
				{
					outputText("and quieting your unease at having potentially disappointed her.");
				}
				else
				{
					outputText("and gives you hope that your failure to to perform might not have warranted punishment.");
				}
				
				outputText(" \"<i>Well, let's get a nice meal in in you and see if we can't cheer you up a bit. For today you can just focus on the basics, okay? </i>\" She favors you with a smile so warm it could melt ice, and beckons you with cordial gesture and a beguiling glimmer in her eyes. \"<i>Now, sweetie, why don't you come on over here and have your appetizer?</i>\"\n\n");
				outputText("You breathe a heavy sigh of relief at her invitation, a dam breaking within you. Despite the sense of disquiet still lingering in the back of your mind, a flood of gratitude washes over you for the respite from her emotionally and physically demanding lessons. While you have no delusion that she won't be expecting you to perform for her, you also know that she is as good as her word and will allow you to relax and deliver only the service that you are already comfortable with, humiliating as it may be. With your spirits buoyed by her kindness [if (esteem < 60) and your heart eager to avoid disappointing her any further][if (esteem >= 60) and your heart set on meeting her expectations], you force yourself to begin crawling towards her, hoping the sensual ritual of the act will finish the job of preparing you for what follows.\n\n");
				outputText("Sure enough, you quickly push past the shame of engaging in this dance of subservience and slink towards her with a well practiced swing in your hips, finding precisely the aroused acquiescence you need as your body delivers its flirtatious show in spite of your earlier equivocation. And upon arriving at her feet, you rely on this building lighthearted momentum to ");
				if (player.esteem < 40)
				{
					outputText("overcome the counterproductive feelings of resistance and self-loathing that the moment stirs within you. You give her boots a deferential kiss, then meekly rise to take her in your mouth.");
				}
				else if (player.esteem < 60)
				{
					outputText("help you bury the resistant, angry feelings that work against your resolve. You make yourself politely rise without the slightest sign of hesitation, and fill your mouth with her girth.");
				}
				else
				{
					outputText("combat your resistance against the undesirable indignity of what you must do next. You win the war within yourself, and rise to your haunches with as much immodest joy as you can muster, back arched and [chest] thrust forward [if (corruption < 20) assertively][if (corruption >= 20) seductively], and fill your mouth with overwrought enthusiasm.");
				}
				
				outputText("\n\n");
				outputText("Once your lips close around her tip, the need to maintain a facade quickly fades away. Your senses are instantly awash in her musky aromas, her uniquely pleasant, savory yet sweet taste, and the silky, alluring feel of her skin. The rush of soothing and arousing emotions that they conjure within you uplift you into a state of relaxed focus[if (esteem < 40)  and familiar comfort][if (esteem >= 40) , quieting your troubled mind]. You do apply a small amount of conscious effort towards satisfying your Mistress, but mostly you [if (esteem < 40) surrender yourself to][if (esteem >= 40) rely on] muscle memory and allow your body to act on your behalf -- and despite the distracting stirring in your loins, you remain [if (esteem < 60) thankful that your body is still capable of carrying you through your act][if (esteem >= 60) glad that your body is working in your favor again].\n\n");
				outputText("Experienced as your body is at servicing her this way, it isn't long before her dick is deep in your throat pouring her seed directly into your stomach. Mindful of her preferences, you wait until her torrent to begins to subside, then pull back slowly, savoring the sensations as you [if (esteem < 40)\"succumb to][if (esteem >= 40) accept] the lustful nature of the act. You pause to massage her tip lavishly with your lips until your tongue is inundated with her intoxicating jizz, quenching a thirst you were only vaguely aware of. Finally, with a somewhat disturbing level of anticipation building within you, you pull her from your mouth so that the last few spurts can coat your [face] and [chest] with a warm, viscous reminder of your servile compliance, each sticky splash simultaneously eroding your will to resist and filling you with a queer sense of purpose.\n\n");
				outputText("\"<i>Yes, there's my good little [boy] -- go ahead and swallow it all if you like. I knew sucking my cock would help you feel better.</i>\" Spasms of pleasure continue to shiver across her body as she speaks, eliciting an unbidden rush of [if (esteem < 50) fulfillment][if (esteem >=50) satisfaction] within you, and as you ingest her load you grudgingly admit to yourself that she wasn't wrong. \"<i>Don't worry dear, I'll always be here to help pick you up any time you are feeling down.</i>\" She gives you a comforting pat on your head, then softly trails her fingers down your cum-soaked cheek, feeding them through your welcoming lips when they arrive at your mouth. \"<i>Well, now that you've had a nice snack and are feeling more yourself, I imagine you must be ready to earn your main course.</i>\"\n\n");
				if (player.esteem < 40)
				{
					outputText("A whisper of your earlier anxiety begins to creep back from the recesses of your subconscious, even as you kneel before her in a content and malleable state. It briefly occurs to you that servicing her as you just have was enough to earn her approval not all that long ago, but the resentful thought ultimately finds little purchase in your aroused, cum-soaked mind.");
				}
				else if (player.esteem < 60)
				{
					outputText("Even as you sit in your pleasant cum-drunk haze, a mild echo of your earlier anxiety arises in response to her question. Your lower lip twitches at the reminder of your helplessness, flustered that making a drippy, debauched mess of yourself is not enough for her anymore, but other than that her words wash over you in state of restless arousal.");
				}
				else
				{
					outputText("As you bathe your lusty success you find your confidence surge within you, and you are barely phased by the fact that she is about to demand more of you. You remember that there can be wisdom in capitulation and that victory can be found in unexpected places.");
				}
				
				outputText(" But before you truly have time to react, Mistress Elly saves you from your thoughts by playfully teasing her cock around the messy ruin of your [face], quickly reclaiming your undivided attention.\n\n");
				outputText("\"<i>Yes, dear,</i>\" she comforts, sweeping her knob downward across your dripping chin, then back up the other sloppy cheek and over the bridge of your nose, \"<i>all you need to do is practice your favorite lesson.</i>\" ");
				if (player.cor < 30)
				{
					if (player.esteem < 30)
					{
						outputText("She draws ever tighter circles around your mouth, and you try your best not to react, suddenly abashed at your wanton appetite. \"<i>It's so cute that you still try to play shy',</i>\" she titters, \"<i>given what you are about to do.</i>\"");
					}
					else if (player.esteem < 60)
					{
						outputText("She draws ever tighter circles around your mouth while you struggle vainly against your immodest urge to chase after the illicit sensation. \"<i>Oh, the look on your face right now is the best part.</i>\" she titters, \"<i>Give in, slave. Accept your desire.</i>\"");
					}
					else
					{
						outputText("You do your best to feign indignation as her cock draws ever tighter circles around your mouth, wishing halfheartedly that there was an ounce of authentic feeling in your mock defiance. \"<i>It's so cute that you still try to play shy',</i>\" she titters, \"<i>given what you are about to do.</i>\"");
					}
					
				}
				else if (player.esteem < 30)
				{
					outputText("Her cock draws ever tighter circles around your mouth, and like a windup toy you yield to your urges and open your mouth in passive invitation. \"<i>Oh my, what a darling thing you are!</i>\" she titters, \"<i>Seeing that reaction will never get old.</i>\"");
				}
				else if (player.esteem < 60)
				{
					outputText("As usual, you find yourself chasing after her cock as it draws ever tighter circles around your mouth. \"<i>Such devotion!</i>\" she titters, \"<i>Well, dear, it's soon to be rewarded.</i>\" ");
				}
				else
				{
					outputText("As usual, she draws ever tightening circles around your mouth, while you struggle vainly against an intense urge to chase after the delightful sensation. \"<i>Oh, the look on your face right now is the best part.</i>\" she titters, \"<i>Give in, slave. Accept your desire.</i>\"");
				}
				
				outputText(" With full knowledge of how you will respond, she drags her tip across your moist lips, which [if (esteem < 30) longingly part in its wake][if (esteem >= 30) gently part in its wake]. \"<i>Yes indeed, you are going to get exactly what you want. I'm going to allow you to taste me again,</i>\" her tip teases through your lips, \"<i>and you are going to show me your gratitude by rubbing that cute little ");
				if (player.hasCock())
				{
					outputText("cock");
				}
				else if (player.hasVagina())
				{
					outputText("clit");
				}
				else
				{
					outputText("asshole");
				}
				
				outputText(" for me, nice and slow.</i>\" ");
				if (player.cor < 30)
				{
					outputText("You make a superficial attempt to pull away from her impish prodding, but she easily overwhelms your false retreat. Impaled once again, you [if (esteem < 60) coyly][if (esteem >= 60) quietly] acquiesce and allow your well-schooled mouth to suckle at her once more.\n\n");
				}
				else
				{
					outputText("Unable to resist her goading any longer you attempt to grasp her in your mouth, only to bite air as she retreats beyond your reach. Sinking deeper into your lasciviousness, you willingly play along as she taunts you this way several more times, then when she finally allows you to catch her your well schooled response overcomes your fading reluctance as you readily suckle once more.\n\n");
				}
				outputText("\"<i>Oh god, you are such good, good [boy]. Now, show me that you know your pleasure comes at my whim. Continue to suck my cock, and masturbate as you do, but remember: you will come when -- and only when -- I tell you to. Is that understood, slave?</i>\"\n\n");
				outputText("The heat coursing through your body practically begs you to do as you have been told, but even as you[if (corruption > 30)  greedily] lick the salty leavings from her shaft you still feel an odd reluctance to allow her such intimate control over your body.\n\n");
				flags[kFLAGS.PRISON_TRAINING_LEVEL] = 1;
			}
			else
			{
				if (prison.prisonIsRestrained())
				{
					outputText("Mistress Elly enters the room and with a snap of her fingers, your restraints vanish into thin air.",false);
				}
				else
				{
					outputText("Mistress Elly enters the room and waits by the door.");
				}
				outputText(" Guessing it must be feeding time, you decide to save yourself the indignity of being prompted to do so and offer her your deferential greeting in the expected lilting tone.\n\n");
				outputText("\"<i>Hello Mistress, how may I serve you?</i>\" This concession having been freely and easily made, you ");
				if (player.esteem < 40)
				{
					outputText("accept the inevitability of the more demanding display that is necessary to please her");
				}
				else if (player.esteem < 60)
				{
					outputText("resign yourself to the challenging task that you know must follow if you wish to make her happy");
				}
				else
				{
					outputText("focus on the far more distasteful piece of the act required if you wish to keep on her good side");
				}
				
				outputText(" and begin the humbling journey to her feet.\n\n");
				outputText("Thankfully, starting is now the hardest part, and once you are underway you quickly find the fun in seductively slinking across the cold stone floor; the moment you stopped allowing yourself to be coerced into the act, you found that it came to you much more naturally. With each subsequent crawl you grow more skillful at managing the seductive swing of your hips that is the cornerstone of the performance, effortlessly adding playful arches and bounces to each stride and filling your face with desirous expressions to match. The rapid improvement in your flirtatious antics does not go unnoticed, and as you draw giggles of delight from your Mistress you permit yourself to indulge in a moment of [if (esteem < 40) satisfaction][if (esteem >= 40) pride] at a job well done.\n\n");
				outputText("Arriving at her feet, you rely on the momentum of this lighthearted ease to ");
				if (player.esteem < 40)
				{
					outputText("push you past the counterproductive feelings of resistance and self-loathing that the moment stirs within you. You give her boots a deferential kiss, then meekly rise to take her in your mouth.");
				}
				else if (player.esteem < 60)
				{
					outputText("help you bury the resistant, angry feelings that work against your resolve. Without the slightest sign of hesitation, you make yourself rise with polite and dignified posture and fill your mouth with her girth.");
				}
				else
				{
					outputText("combat your resistance against the hateful indignity of what you must do next. Winning the war within yourself, you assume an air of self-possessed immodesty and joyfully rise to your haunches, back arched and [chest] thrust forward [if (corruption < 20) assertively][if (corruption >= 20) seductively], and fill your mouth with flirtatious enthusiasm.");
				}
				
				outputText(" And once your lips close around her tip, the need to maintain a facade quickly fades away. Your senses are instantly awash in her musky aromas, her uniquely pleasant, savory yet sweet taste, and the silky, alluring feel of her skin. The rush of confused but arousing emotions that they conjure within you uplift you into a state of relaxed focus[if (esteem < 40)  and familiar comfort][if (esteem >= 40) , quieting your troubled mind]. You do apply a small amount of conscious effort towards satisfying your Mistress, but mostly you [if (esteem < 40) surrender yourself to][if (esteem >= 40) rely on] muscle memory and allow your body to act on your behalf -- and despite the grudgingly expected stirring in your loins, you remain [if (esteem < 60) thankful that your body is capable of carrying you through your act][if (esteem >= 60) glad that your body is working in your favor now].\n\n");
				outputText("Experienced as your body now is at servicing her this way, it isn't long before her dick is deep in your throat pouring her seed directly into your stomach. Mindful of her preferences, you wait until her torrent to begins to subside, then pull back slowly, savoring the sensations as you [if (esteem < 40)\"succumb][if (esteem >= 40) resign yourself] to the lustful nature of the act. You pause to massage her tip lavishly with your lips until your tongue is swimming in jizz, then finally pull her from your mouth so that the last few spurts can coat your [face] and [chest] with a pale, viscous reminder of your servile compliance.\n\n");
				outputText("\"<i>Ahhhh, yes, what a good little [boy] you are -- you become more impressive every day, slave. Go ahead and swallow your reward now.</i>\" Spasms of pleasure continue to shiver across her body as she compliments you, unquestionably beyond pleased with your display, and you are inundated by the usual unbidden rush of [if (esteem < 50) fulfillment][if (esteem >=50) confidence] as you ingest her load. \"<i>It's plain to see that you're taking my lessons to heart and are becoming comfortable with what an insatiable and dutiful cocksucker you are. But now that you've enjoyed your appetizer,</i>\" she scrapes a bit of her fluid from your face with her index finger and smears it across your already cum-soaked lips, \"<i>it's time for you to earn your meal for today.</i>\"\n\n");
				if (player.esteem < 40)
				{
					outputText("You knew that this moment was coming and wanted to be prepared for it, but now that it is here you simply kneel before her in a dazed and malleable state. You try desperately to conjure up some measure of indignation at the fact that servicing her as you just have is not enough to earn her approval, but the anger you want to summon finds no purchase in your aroused, cum-soaked mind.");
				}
				else if (player.esteem < 60)
				{
					outputText("You sit in a cum-drunk haze with a phantom of indignant betrayal attempting to take hold within you. Your lower lip begins to twitch at the routine reminder of your helplessness, distraught that making a drippy, debauched mess of yourself is not enough for her anymore, but other than that her words wash over you in state of resigned arousal.");
				}
				else
				{
					outputText("You refuse to be phased by the fact that she is about to demand more of you, and allow yourself a moment to bathe your lusty success. You know it was wise to capitulate as you did, and you will enjoy your victory regardless of what might follow.");
				}
				
				outputText("\"<i>Don't make me cock-slap you again, slave -- you know you earn meals by learning new things, not by doing what is expected of you. Cheer up,</i>\" she comforts, pressing her knob to your cheek and slowly, sensually beginning to trace it through her muck, \"<i>We both know you'll enjoy this lesson almost as much as you love sucking cock.</i>\" Her bulbous member sweeps downward across your dripping chin, then back up the other sloppy cheek and over the bridge of your nose, waking you from your taciturn temper -- not to the outrage you [if (esteem < 40) might deserve ][if (esteem >= 40) no doubt should feel] -- but back to the bewildering jumble of pacifying arousal and [if (esteem < 40) soothing][if (esteem >= 40) reluctant] resignation that you felt as you gorged on her cinnamon-savory flesh and seed.\n\n");
				outputText("Although her tactic is now familiar, it still manages to rouse you just as effectively as the first time.");
				if (player.cor < 30)
				{
					if (player.esteem < 30)
					{
						outputText("She draws ever tighter circles around your mouth, and you attempt to shrink away, more abashed at your own reaction than by her actions. \"<i>It's so cute that you still try to play shy',</i>\" she titters, \"<i>given what you are about to do.</i>\"");
					}
					else if (player.esteem < 60)
					{
						outputText("As before, she draws ever tighter circles around your mouth while you struggle vainly against your immodest urge to chase after the illicit sensation. \"<i>Oh, the look on your face right now is the best part.</i>\" she titters, \"<i>Give in, slave. Accept your desire.</i>\"");
					}
					else
					{
						outputText("You glare at her with wavering indignation as her cock draws ever tighter circles around your mouth, wishing halfheartedly that there was more authentic feeling in your defiance. \"<i>It's so cute that you still try to play shy',</i>\" she titters, \"<i>given what you are about to do.</i>\"");
					}
					
				}
				else if (player.esteem < 30)
				{
					outputText("Her cock draws ever tighter circles around your mouth, and like a windup toy you yield to your urges and open your mouth in passive invitation. \"<i>Oh my, what a darling thing you are!</i>\" she titters, \"<i>Seeing that reaction will never get old.</i>\"");
				}
				else if (player.esteem < 60)
				{
					outputText("To your chagrin, you find yourself once again chasing after her cock as it draws ever tighter circles around your mouth. \"<i>Such devotion!</i>\" she titters, \"<i>Well, dear, it's soon to be rewarded.</i>\" ");
				}
				else
				{
					outputText("As before, she draws ever tightening circles around your mouth, while you struggle vainly against an intense urge to chase after the delightful sensation. \"<i>Oh, the look on your face right now is the best part.</i>\" she titters, \"<i>Give in, slave. Accept your desire.</i>\"");
				}
				
				
				outputText(" Pressing her advantage, she drags her tip across your moist lips, which [if (esteem < 30) longingly part in its wake][if (esteem >= 30) confound you by gently parting in its wake]. \"<i>Now, dear, I'm going to allow you to taste me again,</i>\" her tip teases through your lips, \"<i>and you are going to show me your gratitude by rubbing that cute little ");
				if (player.hasCock())
				{
					outputText("cock");
				}
				else if (player.hasVagina())
				{
					outputText("clit");
				}
				else
				{
					outputText("asshole");
				}
				
				outputText(" for me, nice and slow.</i>\" ");
				if (player.cor < 30)
				{
					outputText("You make a perfunctory attempt to pull away from her impish prodding, but she easily overwhelms your retreat. Impaled once again, you [if (esteem < 60) coyly][if (esteem >= 60) wearily] acquiesce and allow your now well-schooled mouth to suckle at her once more.\n\n");
				}
				else
				{
					outputText("Unable to resist her goading any longer you attempt to grasp her in your mouth, only to bite air as she retreats beyond your reach. Sinking deeper into your lasciviousness, you willingly play along as she taunts you this way several more times, then when she finally allows you to catch her your well schooled response overcomes your dwindling reluctance as you start to suckle once more.\n\n");
				}
				outputText("\"<i>Yessss, that's a good, good [boy]. Now, it is time for you to learn that your pleasure comes at my whim. You may continue to suck my cock, but you will masturbate as you do, and you will come when -- and only when -- I tell you to. Is that understood, slave?</i>\"\n\n");
				outputText("The heat coursing through your body practically begs you to do as you have been told, but even as you[if (corruption > 30)  greedily] lick the salty leavings from her shaft you still feel reluctant to allow her such intimate control over your body.\n\n");
			}
			
			player.slimeFeed();
			player.refillHunger(15);
			dynStats("lus", 30);
			outputText("You consider how you should respond to Mistress Elly.\n\n",false);
			if (player.hunger <= 0 && (player.esteem < 30 || player.esteem < 50 && player.obey > 45))
			{
				outputText("\nYou are simply too hungry to refuse to do as you are told.\n",false);
				refuse = null;
				reject = null;
			}
			else
			{
				outputText("You could meekly refuse " + prison.prisonWillCostDescript(5),false);
				if (player.esteem < 10 || player.esteem < 25 && player.obey > 40)
				{
					outputText(" but you don't think you could manage any stronger a defense of your dignity due to your your obvious powerlessness and insignificance.",false);
					reject = null;
				}
				else
				{
					outputText(" or you could angrily reject the order " + prison.prisonWillCostDescript(15) + ".",false);
				}
			}
			if (player.hunger > 0 && (player.esteem > 95 || player.esteem > 80 && player.obey < 30))
			{
				outputText("\n\nYou have too much dignity to do as you have been told.\n",false);
				accept = null;
				perform = null;
			}
			else
			{
				outputText("\n\nYou could give in and accept Mistress Elly's order, ",false);
				if (player.esteem > 90 || player.esteem > 80 && player.obey < 35)
				{
					outputText("but you have too much dignity to really put your heart into it.\n",false);
					perform = null;
				}
				else
				{
					outputText("or you could really show your acceptance of your position and perform above and beyond what she's asked for. \n",false);
				}
			}
			addButton(0, "Refuse", refuse);
			addButton(1, "Accept", accept);
			addButton(5, "Reject", reject);
			addButton(6, "Perform", perform);
		}
		
		public function prisonCaptorFeedingAnalTraining():void
		{
			clearOutput();
			var refuse:Function = prisonCaptorFeedingTrainingRefuse;
			var accept:Function = prisonCaptorFeedingAnalTrainingAccept;
			var reject:Function = prisonCaptorFeedingTrainingReject;
			var perform:Function = prisonCaptorFeedingAnalTrainingPerform;
			if (flags[kFLAGS.PRISON_TRAINING_LEVEL] == 0)
			{
				outputText("(Placeholder) Intro to new level of training.\n\n",false);
				flags[kFLAGS.PRISON_TRAINING_LEVEL] = 1;
			}
			if (flags[kFLAGS.PRISON_TRAINING_LEVEL] == -1)
			{
				outputText("(Placeholder) Intro to reduced training level.\n\n",false);
				flags[kFLAGS.PRISON_TRAINING_LEVEL] = 1;
			}
			if (prison.prisonIsRestrained())
			{
				outputText("With a snap of her fingers, your restraints vanish into thin air.\n\n",false);
			}
			outputText("(Placeholder) You have now been trained to say \"Hello Mistress, how may I serve you?\" and to suck her cock without thinking while masturbating (only coming when told to) when Elly comes to feed you. This no longer earns your meal or your orgasm, though. Now she requires that you follow your warmup cocksucking by fucking yourself in the ass with her cock -- you will then be allowed to orgasm once your ass is full of her cum and you have sucked her cock clean.\n\n",false);
			player.slimeFeed();
			player.refillHunger(5);
			outputText("You consider how you should respond to Mistress Elly.\n\n",false);
			if (player.hunger <= 0 && (player.esteem < 30 || player.esteem < 50 && player.obey > 45))
			{
				outputText("\nYou are simply too hungry to refuse to do as you are told.\n",false);
				refuse = null;
				reject = null;
			}
			else
			{
				outputText("You could meekly refuse " + prison.prisonWillCostDescript(5),false);
				if (player.esteem < 10 || player.esteem < 25 && player.obey > 40)
				{
					outputText(" but you don't think you could manage any stronger a defense of your dignity due to your your obvious powerlessness and insignificance.",false);
					reject = null;
				}
				else
				{
					outputText(" or you could angrily reject the order " + prison.prisonWillCostDescript(15) + ".",false);
				}
			}
			if (player.hunger > 0 && (player.esteem > 95 || player.esteem > 90 && player.obey < 45))
			{
				outputText("\n\nYou have too much dignity to do as you have been told.\n",false);
				accept = null;
				perform = null;
			}
			else
			{
				outputText("\n\nYou could give in and accept Mistress Elly's order, ",false);
				if (player.esteem > 40 || player.esteem > 85 && player.obey < 45)
				{
					outputText("but you have too much dignity to really put your heart into it.\n",false);
					perform = null;
				}
				else
				{
					outputText("or you could really show your acceptance of your position and perform above and beyond what she's asked for. \n",false);
				}
			}
			addButton(0, "Refuse", refuse);
			addButton(1, "Accept", accept);
			addButton(5, "Reject", reject);
			addButton(6, "Perform", perform);
		}
		
		public function prisonCaptorFeedingQuestTraining():void
		{
			clearOutput();
			if (prisonCaptorFeedingQuestOptedOut()) {
				prisonCaptorFeedingAnalTraining();
				return;
			}
			var refuse:Function = prisonCaptorFeedingTrainingRefuse;
			var accept:Function = prisonCaptorFeedingQuestTrainingAccept;
			var reject:Function = prisonCaptorFeedingTrainingReject;
			var perform:Function = null;
			if (player.findStatusEffect(StatusEffects.PrisonCaptorEllyQuest) < 0)
			{
				player.createStatusEffect(StatusEffects.PrisonCaptorEllyQuest,0,0,0,0);
			}
			if ((prisonCaptorFeedingQuestTrainingExists()) && ((prisonCaptorFeedingQuestTrainingIsComplete()) || (prisonCaptorFeedingQuestTrainingIsTimeUp())))
			{
				prisonCaptorFeedingQuestTrainingResolve();
				return;
			}
			if ((prisonCaptorFeedingQuestTrainingExists()) && !prisonCaptorFeedingQuestTrainingIsTimeUp())
			{
				outputText("(Placeholder) Mistress Elly enters the room and chastises you for not being out working on her quest.\n\n");
				doNext(playerMenu);
				return;
			}
			if (flags[kFLAGS.PRISON_TRAINING_LEVEL] == 0)
			{
				outputText("(Placeholder) Intro to new level of training.\n\n",false);
				flags[kFLAGS.PRISON_TRAINING_LEVEL] = 1;
			}
			if (flags[kFLAGS.PRISON_TRAINING_LEVEL] == -1)
			{
				outputText("(Placeholder) Intro to reduced training level.\n\n",false);
				flags[kFLAGS.PRISON_TRAINING_LEVEL] = 1;
			}
			if (prison.prisonIsRestrained())
			{
				outputText("With a snap of her fingers, your restraints vanish into thin air.\n\n",false);
			}
			outputText("(Placeholder) You are fully trained at this point. When Elly enters your room to feed you, you instinctually do all the depraved things she has trained you to do in exchange for food, and you have no choice in the matter.\n\n",false);
			outputText("(Placeholder) You plow yourself unthinkingly onto her cock, spasming with pleasure the moment you feel your ass inflate with her seed. You then greedily lick every bit of cum from her dick, suck her until she cums again in your mouth, lick the pools of cum off the floor that dripped from your ass, then beg her to fuck you more. She doesn't, but she praises your good behavior. Ironically, you now never get regular bread since you are so broken that you desire the humiliation of eating the bowl of cum soaked bread.\n\n",false);
			player.buttChange(32,true,true,false);
			outputText("\n\n");
			outputText("(Placehoder) Now, though, she wants you to show your devotion by completing a humiliating quest.\n\n");
			prisonCaptorFeedingQuestTrainingSelect();
			player.slimeFeed();
			player.refillHunger(25);
			outputText("You consider how you should respond to Mistress Elly.\n\n",false);
			if (player.hunger <= 0 && (player.esteem < 30 || player.esteem < 50 && player.obey > 45))
			{
				outputText("\nYou are simply too hungry to refuse to do as you are told.\n",false);
				refuse = null;
				reject = null;
			}
			else
			{
				outputText("You could meekly refuse " + prison.prisonWillCostDescript(5),false);
				if (player.esteem < 10 || player.esteem < 25 && player.obey > 40)
				{
					outputText(" but you don't think you could manage any stronger a defense of your dignity due to your your obvious powerlessness and insignificance.",false);
					reject = null;
				}
				else
				{
					outputText(" or you could angrily reject the order " + prison.prisonWillCostDescript(15) + ".",false);
				}
			}
			if (player.hunger > 0 && player.esteem > 75 && player.obey < 55)
			{
				outputText("\n\nYou have too much dignity to do as you have been told.\n",false);
				accept = null;
				perform = null;
			}
			else
			{
				outputText("\n\nYou could accept Mistress Elly's order. ",false);
			}
			menu();
			addButton(0, "Refuse", refuse);
			addButton(1, "Accept", accept);
			addButton(5, "Reject", reject);
			addButton(6, "Perform", perform);
			addButton(10, "NEVER!", noFuckQuestForGood);
		}
		
		public function noFuckQuestForGood():void 
		{
			clearOutput();
			outputText("(Placeholder) You angrily reject the quest and state that you'll NEVER do such humiliating quest, no matter how much of a slut and no matter how obedient you may be. You WANT her, not those other corrupt creatures.\n\n");
			outputText("(Placeholder) Mistress Elly looks down at you. \"<i>Fine. I respect your preferences. I will not assign those quests again. But I still must punish you for your disobedience.</i>\"");
			player.changeStatusValue(StatusEffects.PrisonCaptorEllyQuest, 1, -1);
			prison.changeObey(-5);
			prison.changeEsteem(5);
			prison.prisonPunishment(80);
			//doNext(camp.returnToCampUseOneHour);
		}
		
		public function prisonCaptorFeedingQuestTrainingSelect():void
		{
			if (prisonCaptorFeedingQuestOptedOut()) return;
			outputText("(Placeholder) She assigns you a random humiliating thing to go out into the world and do, and tells you how long you will have to do it.\n\n");
			outputText("(Placeholder) For testing and demonstration purposes, your quest is to go out and get fucked by at least five monsters in the next four days. And no, it doesn't count if you beat them up first.\n\n");
			player.changeStatusValue(StatusEffects.PrisonCaptorEllyQuest,1,1);
			player.changeStatusValue(StatusEffects.PrisonCaptorEllyQuest,2,96);
			player.changeStatusValue(StatusEffects.PrisonCaptorEllyQuest,3,0);
			player.changeStatusValue(StatusEffects.PrisonCaptorEllyQuest,4,0);
		}
		
		public function prisonCaptorFeedingFullyTrained():void
		{
			clearOutput();
			if (prisonCaptorFeedingQuestOptedOut()) {
				prisonCaptorFeedingAnalTraining();
				return;
			}
			if ((prisonCaptorFeedingQuestTrainingExists()) && ((prisonCaptorFeedingQuestTrainingIsComplete()) || (prisonCaptorFeedingQuestTrainingIsTimeUp())))
			{
				prisonCaptorFeedingQuestTrainingResolve();
				return;
			}
			if ((prisonCaptorFeedingQuestTrainingExists()) && !prisonCaptorFeedingQuestTrainingIsTimeUp())
			{
				outputText("(Placeholder) Mistress Elly enters the room and chastises you for not being out working on her quest.\n\n");
				prison.prisonPunishment(50);
				doNext(playerMenu);
				return;
			}
			var lustChange:int = 0;
			if (flags[kFLAGS.PRISON_TRAINING_LEVEL] == 0)
			{
				outputText("(Placeholder) Intro to new level of training.\n\n",false);
				flags[kFLAGS.PRISON_TRAINING_LEVEL] = 1;
			}
			if (flags[kFLAGS.PRISON_TRAINING_LEVEL] == -1)
			{
				outputText("(Placeholder) Intro to reduced training level.\n\n",false);
				flags[kFLAGS.PRISON_TRAINING_LEVEL] = 1;
			}
			if (prison.prisonIsRestrained())
			{
				outputText("With a snap of her fingers, your restraints vanish into thin air.\n\n",false);
			}
			outputText("(Placeholder) You are now a willing slave. When Elly enters your room to feed you, you instinctually do all the depraved things she has trained you to do in exchange for food, and afterward you automatically accept whatever quest she gives you with no choice in the matter.\n\n",false);
			outputText("(Placeholder) You plow yourself unthinkingly onto her cock, spasming with pleasure the moment you feel your ass inflate with her seed. You then greedily lick every bit of cum from her dick, suck her until she cums again in your mouth, lick the pools of cum off the floor that dripped from your ass, then beg her to fuck you more. She doesn't, but she praises your good behavior. Ironically, you now never get regular bread since you are so broken that you desire the humiliation of eating the bowl of cum soaked bread.",false);
			player.buttChange(32,true,true,false);
			outputText("\n\n");
			prisonCaptorFeedingQuestTrainingSelect();
			player.slimeFeed();
			player.refillHunger(15);
			player.orgasm();
			doNext(prisonCaptorFeedingQuestTrainingAccept);
		}
		
		public function prisonCaptorFeedingQuestTrainingAccept():void
		{
			clearOutput();
			if (prisonCaptorFeedingQuestOptedOut()) { //If quest is disabled, route to anal training.
				prisonCaptorFeedingAnalTrainingAccept();
				return;
			}
			outputText("(Placeholder) You agree to attempt the quest, and she unlocks the door (and does not return any other restraints you might have had) but makes sure you understand that this does NOT mean you are free. She instructs you to find your way back as soon as you complete your task, and warns you that as soon as you run out of time you WILL find yourself back in your cell. Finally, she decides to give you a going away present, but warns you that you might want to eat it before you leave.",false);
			outputText("\n\nOut of thin air she produces a pitiful loaf of bread and crumbles it into a bowl. With a smile of supreme satisfaction, she begins to milk her cock into it. Before long, the bowl is overflowing with her sticky seed. She sets it on the ground and gives you a playful wink before leaving you alone in the cell.\n\n",false);
			if (prison.prisonIsRestrained())
			{
			}
			player.changeStatusValue(StatusEffects.PrisonRestraints,1,0);
			player.changeStatusValue(StatusEffects.PrisonRestraints,2,0);
			player.changeStatusValue(StatusEffects.PrisonRestraints,3,0);
			player.changeStatusValue(StatusEffects.PrisonRestraints,4,0);
			flags[kFLAGS.PRISON_DOOR_UNLOCKED] = 1;
			prison.changeEsteem(-5, prison.inPrison);
			prison.changeObey(2.5, prison.inPrison);
			flags[kFLAGS.PRISON_TRAINING_LEVEL]++;
			if (flags[kFLAGS.PRISON_TRAINING_LEVEL] > 4 && player.obey > 90)
			{
				player.changeStatusValue(StatusEffects.PrisonCaptorEllyStatus,1,6);
				flags[kFLAGS.PRISON_TRAINING_LEVEL] = 0;
			}
			inventory.takeItem(consumables.C_BREAD, camp.returnToCampUseOneHour);
		}
		
		public function prisonCaptorFeedingQuestTrainingIsComplete():Boolean
		{
			if (player.findStatusEffect(StatusEffects.PrisonCaptorEllyQuest) < 0)
			{
				return false;
			}
			switch(player.statusEffectv1(StatusEffects.PrisonCaptorEllyQuest))
			{
				case 1:
					trace("CHECKING FUCK QUEST " + player.statusEffectv3(StatusEffects.PrisonCaptorEllyQuest) + "");
					if (player.statusEffectv3(StatusEffects.PrisonCaptorEllyQuest) >= 5)
					{
						trace("\nQUEST COMPLETE\n");
						return true;
					}
					trace("\nQUEST INCOMPLETE\n");
					return false;
				default:
					return false;
			}
		}
		
		public function prisonCaptorFeedingQuestOptedOut():Boolean
		{
			if (player.findStatusEffect(StatusEffects.PrisonCaptorEllyQuest) >= 0 && player.statusEffectv1(StatusEffects.PrisonCaptorEllyQuest) < 0)
			{
				return true;
			}
			return false;
		}
		
		public function prisonCaptorFeedingQuestTrainingExists():Boolean
		{
			if (player.findStatusEffect(StatusEffects.PrisonCaptorEllyQuest) >= 0 && player.statusEffectv1(StatusEffects.PrisonCaptorEllyQuest) > 0)
			{
				return true;
			}
			return false;
		}
		
		public function prisonCaptorFeedingQuestTrainingIsTimeUp():Boolean
		{
			if (player.findStatusEffect(StatusEffects.PrisonCaptorEllyQuest) >= 0 && player.statusEffectv2(StatusEffects.PrisonCaptorEllyQuest) <= 0)
			{
				return true;
			}
			return false;
		}
		
		public function prisonCaptorFeedingQuestTrainingStatusText():void
		{
			outputText("<b>Mistress Elly\'s Quest: </b>");
			switch(player.statusEffectv1(StatusEffects.PrisonCaptorEllyQuest))
			{
				case 1:
					outputText("Get fucked by five monsters\n");
					outputText("<b>Quest Progress: </b>" + player.statusEffectv3(StatusEffects.PrisonCaptorEllyQuest) + " monster(s)\n");
					break;
				default:
					outputText("No current quest!\n");
			}
			outputText("<b>Quest Time Remaining: </b>" + player.statusEffectv2(StatusEffects.PrisonCaptorEllyQuest) + " hours\n");
		}
		
		public function prisonCaptorFeedingQuestTrainingDecrementTime():void
		{
			var newVal:* = undefined;
			if (player.findStatusEffect(StatusEffects.PrisonCaptorEllyQuest) < 0)
			{
				return;
			}
			newVal = player.statusEffectv2(StatusEffects.PrisonCaptorEllyQuest) - 1;
			if (newVal < 0)
			{
				newVal = 0;
			}
			player.changeStatusValue(StatusEffects.PrisonCaptorEllyQuest,2,newVal);
		}
		
		public function prisonCaptorFeedingQuestTrainingProgress(questID:Number, val1:Number = 0, val2:Number = 0):void
		{
			var newval1:* = undefined;
			var newval2:* = undefined;
			if (player.findStatusEffect(StatusEffects.PrisonCaptorEllyQuest) < 0 || !(player.statusEffectv1(StatusEffects.PrisonCaptorEllyQuest) == questID))
			{
				return;
			}
			newval1 = player.statusEffectv3(StatusEffects.PrisonCaptorEllyQuest) + val1;
			newval2 = player.statusEffectv4(StatusEffects.PrisonCaptorEllyQuest) + val2;
			player.changeStatusValue(StatusEffects.PrisonCaptorEllyQuest,3,newval1);
			player.changeStatusValue(StatusEffects.PrisonCaptorEllyQuest,4,newval2);
		}
		
		public function prisonCaptorFeedingQuestTrainingResolve():void
		{
			outputText("(Placeholder) You\'ve returned to your cell and now it is time to evaluate how you did on your quest. \n\n");
			//prison.prisonCaptor.updateNextFeedingEvent(model.time.hours, model.time.days);
			if (prisonCaptorFeedingQuestTrainingIsComplete())
			{
				switch(player.statusEffectv1(StatusEffects.PrisonCaptorEllyQuest))
				{
					case 1:
						outputText("(Placeholder) You got fucked by five monsters in just four days. Congratulations! Mistress Elly is very proud of her obedient little slut. \n\n");
						break;
					default:
						outputText("Somehow you finished an unknown quest. Well done, I guess? (This is a bug, by the way.)\n\n");
				}
				player.changeStatusValue(StatusEffects.PrisonCaptorEllyQuest,1,0);
				player.changeStatusValue(StatusEffects.PrisonCaptorEllyQuest,2,0);
				player.changeStatusValue(StatusEffects.PrisonCaptorEllyQuest,3,0);
				player.changeStatusValue(StatusEffects.PrisonCaptorEllyQuest,4,0);
				outputText("(Placeholder) As a reward you get a bowl of cum, since that\'s pretty much what you want at this point, right?\n\n");
				outputText("\n\nOut of thin air she produces a pitiful loaf of bread and crumbles it into a bowl. With a smile of supreme satisfaction, she begins to milk her cock into it. Before long, the bowl is overflowing with her sticky seed. She sets it on the ground and gives you a playful wink before leaving you alone in the cell.\n\n",false);
				prison.changeEsteem(-7, prison.inPrison);
				prison.changeObey(3, prison.inPrison);
				inventory.takeItem(consumables.C_BREAD, camp.returnToCampUseOneHour);
				return;
			}
			outputText("(Placeholder) Mistress Elly is not pleased with your failure to do as instructed. Punishment time! (For now, an equal chance of light vs heavy punishment. Might be good to case this on quest difficulty or something. \n\n");
			prison.changeEsteem(3, prison.inPrison);
			player.changeStatusValue(StatusEffects.PrisonCaptorEllyQuest,1,0);
			player.changeStatusValue(StatusEffects.PrisonCaptorEllyQuest,2,0);
			player.changeStatusValue(StatusEffects.PrisonCaptorEllyQuest,3,0);
			player.changeStatusValue(StatusEffects.PrisonCaptorEllyQuest,4,0);
			prison.prisonPunishment(80);
		}
		
	}

}