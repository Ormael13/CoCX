package classes.Scenes.Places.Prison 
{
	import classes.*;
	import classes.GlobalFlags.*;
	
	public class Punishments extends BaseContent
	{	
		public function Punishments() { }
		
		//-----------------------------------------------------------------------
		//		*******	Stockades Punishment *******
		//-----------------------------------------------------------------------
		public function prisonCaptorPunishmentStockades():void
		{
			//Punishment Intro 
			outputText("(Placeholder) " + prison.prisonCaptor.captorTitle + " " + prison.prisonCaptor.captorName + " drags you to the stockades in the middle of the room, forces you to bend over them, and clamps your head and hands securely within them. She then inserts a cleverly shaped dildo in your ass. Aside from the penetrating tip, it is thin, broad, and rigid in order to allow other things to enter your " + player.assholeDescript() + " while it is in place, with a handle on the outside of your " + player.assDescript() + " that curves upward in a hook-like shape. She then attaches a chain between the handle and the ceiling, and tightens it such that should your [legs] go slack even the slightest bit, the entire weight of your torso would be suspended by your asshole. \n\n",false);
			outputText("(Placeholder)\"<i>Since you seem reluctant to accept what you are, I think it's time for a bit of a crash course. When you have shown you truly understand that your only value is as a source of pleasure and entertainment for others, I will give you a chance to apologize for your impertinance. Until then, you will remain hanging by your ass locked in my stockades, and you will <b>learn</b> from it. And then, if I feel like it, you will hang there some more for no other reason than because it gives <b>me</b> pleasure to see squirm. And you will learn from that, too.</i>\"",false);
			
			// dont really know what this does 
			player.changeStatusValue(StatusEffects.PrisonCaptorEllyStatus,3,12 + rand(4));
			player.changeStatusValue(StatusEffects.PrisonCaptorEllyStatus,4,0);
			
			// Add Restriants
			player.changeStatusValue(StatusEffects.PrisonRestraints,1,0);
			player.changeStatusValue(StatusEffects.PrisonRestraints,2,0);
			player.changeStatusValue(StatusEffects.PrisonRestraints,3,1);
			player.changeStatusValue(StatusEffects.PrisonRestraints,4,4);
			
			//Add a flag indicating the player is in the stockades
			flags[kFLAGS.PRISON_PUNISHMENT] = 1;
			doNext(playerMenu);
		}
		
		public function prisonCaptorPunishmentStockadesCallout():void
		{
			clearOutput();
			outputText("You call out, hoping someone might come help you.\n\n",false);
			if (rand(2) == 1)
			{
				prisonCaptorPunishmentStockadesVisitor();
				return;
			}
			if (rand(2) == 1)
			{
				prisonCaptorPunishmentStockadesFreedom();
				return;
			}
			outputText("You scream yourself hoarse but no one seems to hear you.\n\n",false);
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function prisonCaptorPunishmentStockadesVisitor():void
		{
			var selector:int = 0;
			selector = rand(4);
			switch(selector)
			{
				case 0:
					outputText("(Placeholder) A passing guard sees your predicament, and decides to \"help\" by feeding you his cock. With your head securely clamped in the stocks and the ring gag holding your mouth wide open, all you can do is drool and look up plaintively as he stuffs your throat, and leaves you with a stomach full of sperm.",false);
					player.changeStatusValue(StatusEffects.PrisonCaptorEllyStatus,4,player.statusEffectv4(StatusEffects.PrisonCaptorEllyStatus) + 1);
					player.slimeFeed();
					player.refillHunger(15);
					prison.changeEsteem(-1,prison.inPrison);
					break;
				case 1:
					outputText("(Placeholder) A passing guard sees your predicament, and decides to \"help\" by feeding you his cock. With your head securely clamped in the stocks and the ring gag holding your mouth wide open, all you can do is drool and look up plaintively as he stuffs your throat. However, at the last moment he says that the " + prison.prisonCaptor.captorTitle + " probably wouldn't be happy if he provided you with extra \"nutrition\" right now, so instead he pulls out of your mouth and coats your [face] instead. He cums for what seems like minutes, not only covering your face in a thick layer of jizz but soaking your " + player.hairDescript() + " as well. He leaves you to drown in your humiliation while spunk drips from your chin, slides down your neck, and dries into a sticky crust in your hair and on your face.",false);
					player.changeStatusValue(StatusEffects.PrisonCaptorEllyStatus,4,player.statusEffectv4(StatusEffects.PrisonCaptorEllyStatus) + 1);
					prison.changeEsteem(-5,prison.inPrison);
					prison.changeObey(0.5,prison.inPrison);
					break;
				case 2:
					outputText("(Placeholder) A pair of guards enter the room, excited to see that another slave has been put in the stockades to be freely used. They waste no time in making use of you, each taking multiple turns with in your mouth",false);
					if (player.vaginas.length > 0)
					{
						outputText(", ass, and cunt.",false);
					}
					else
					{
						outputText(" and ass.",false);
					}
					outputText(" As they pound away they take great pleasure in verbally berating while making you cum over and over, which takes an undeniable toll on your psyche.",false);
					if (player.hasVagina())
					{
						player.cuntChange(15,true,true,false);
						player.buttChange(15,true,true,false);
					}
					else
					{
						player.buttChange(20,true,true,false);
					}
					outputText("\n\n");
					player.changeStatusValue(StatusEffects.PrisonCaptorEllyStatus,4,player.statusEffectv4(StatusEffects.PrisonCaptorEllyStatus) + 2);
					player.knockUp(PregnancyStore.PREGNANCY_IMP, PregnancyStore.INCUBATION_IMP);
					player.slimeFeed();
					player.refillHunger(25);
					player.orgasm();
					prison.changeEsteem(-3,prison.inPrison);
					prison.changeObey(1,prison.inPrison);
					break;
				case 3:
					outputText("(Placeholder) A guard enters, but rather than helping you or taking advantage of your helplessness he adjusts the chain attached to the hook in your ass, shortening it by several inches leaving you barely able to reach the ground. He then looks on, chuckling with amusement as you wear yourself out trying to avoid the mortifying situation of being left hanging helplessly by your asshole.",false);
					player.changeFatigue(20);
					break;
			}
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function prisonCaptorPunishmentStockadesFreedom():void
		{
			clearOutput();
			var begEvent:Function = null;
			var acceptEvent:Function = null;
			var rejectEvent:Function = null;
			
			//Check to see if the player is ready to be released
			if (player.statusEffectv4(StatusEffects.PrisonCaptorEllyStatus) < 2 + rand(5))
			{
				outputText("(Placeholder) Your " + prison.prisonCaptor.captorTitle + " enters and briefly considers giving you a chance to beg for your release, but decides against it. \"<i>Before I can consider letting you apologize for your behavior, you need to try harder to atone for your actions and learn your place. If you truly want to be released from these stocks, suck a few more cocks and be ready to be truly penitent when I return.</i>\"",false);
				player.changeStatusValue(StatusEffects.PrisonCaptorEllyStatus,3,8 + rand(4));
				doNext(camp.returnToCampUseOneHour);
				return;
			}
			outputText("(Placeholder) You are given a chance to be released from the stockades -- all you need do is admit that you deserved to be punished, and apologize for what you did wrong. ",false);
			begEvent = prisonCaptorPunishmentStockadesFreedomBeg;
			acceptEvent = prisonCaptorPunishmentStockadesFreedomAccept;
			rejectEvent = prisonCaptorPunishmentStockadesFreedomReject;
			
			//Checks Player "Self Esteem" and "Obedience" to see whether the player will beg for freedom or simply accept it 
			if (player.esteem > 40 || player.obey < 10)
			{
				begEvent = null;
			}
			if (player.esteem < 20 && player.obey > 45)
			{
				acceptEvent = null;
			}
			outputText("Do you accept your " + prison.prisonCaptor.captorTitle + "'s terms, or do refuse? " + prison.prisonWillCostDescript(15),false);
			simpleChoices("Beg",begEvent,"Accept",acceptEvent,"Reject",rejectEvent,"",null,"",null);
		}
		
		public function prisonCaptorPunishmentStockadesFreedomReject():void
		{
			
			clearOutput();
			
			//Checks to see if the player actually has enough willpower to resist
			if (player.will < prison.prisonWillCost(15))
			{
				outputText("While you'd like to preserve a bit of your dignity, you simply don't have the willpower to resist right now. \n\n",false);
				prison.changeEsteem(2,prison.inPrison);
				if (player.esteem < 20 && player.obey > 45)
				{
					prisonCaptorPunishmentStockadesFreedomBeg();
				}
				else
				{
					prisonCaptorPunishmentStockadesFreedomAccept();
				}
				return;
			}
			outputText("(Placeholder) You refuse your " + prison.prisonCaptor.captorTitle + "'s terms, and thus must endure more time in the stockades.",false);
			player.changeStatusValue(StatusEffects.PrisonCaptorEllyStatus,3,12 + rand(4));
			prison.changeEsteem(10,prison.inPrison);
			prison.changeObey(-2.5,prison.inPrison);
			prison.changeWill(-prison.prisonWillCost(15));
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function prisonCaptorPunishmentStockadesFreedomBeg():void
		{
			clearOutput();
			outputText("(Placeholder) You break down and beg your " + prison.prisonCaptor.captorTitle + " to release you, and promise to do as " + prison.prisonCaptor.captorPronoun1 + " commands in the future. You are then given a chance to demonstrate your commitment as " + prison.prisonCaptor.captorPronoun1 + " walks around behind you and allows you to stuggle to fuck yourself on " + prison.prisonCaptor.captorPronoun3 + " cock. After much struggle your [vagOrAss] is fill with jizz, but you are left horny and needing release.",false);
			player.slimeFeed();
			dynStats("lus", 50);
			prison.changeEsteem(-5,prison.inPrison);
			prison.changeObey(2,prison.inPrison);
			prisonCaptorPunishmentStockadesFreedomRelease();
		}
		
		public function prisonCaptorPunishmentStockadesFreedomAccept():void
		{
			clearOutput();
			outputText("(Placeholder) You reluctantly accept your " + prison.prisonCaptor.captorTitle + "'s terms, and apologize for misbehaving. ",false);
			prison.changeEsteem(-3,prison.inPrison);
			prison.changeObey(1,prison.inPrison);
			if (rand(4) == 1)
			{
				outputText("\n\n(Placeholder) Your " + prison.prisonCaptor.captorTitle + " isn't satisfied that you've learned your lesson, and decides to leave you in the stockades a bit longer. ",false);
				player.changeStatusValue(StatusEffects.PrisonCaptorEllyStatus,3,2 + rand(4));
				doNext(camp.returnToCampUseOneHour);
				return;
			}
			outputText("\n\n(Placeholder) Your " + prison.prisonCaptor.captorTitle + " accepts your apology, but responds to your reticence by giving your [face] one final  fucking while your head is still clamped tightly in the stocks. ",false);
			player.slimeFeed();
			player.refillHunger(5);
			prisonCaptorPunishmentStockadesFreedomRelease();
		}
		
		public function prisonCaptorPunishmentStockadesFreedomRelease():void
		{
			//Punishment Outro
			outputText("\n\n(Placeholder) Afterward, " + prison.prisonCaptor.captorPronoun1 + " releases you. Apology or not, you are left bound and gagged, but for the time being you are just happy to be free of the neverending humiliation of the stockades.",false);
			
			//Add a flag indicating the player is no longer in the stockades
			flags[kFLAGS.PRISON_PUNISHMENT] = 0;
			
			//Reset random event timers
			prison.prisonCaptor.updateNextWaitRandomEvent(model.time.hours, model.time.days);
			prison.prisonCaptor.updateNextRoomRandomEvent(model.time.hours, model.time.days);
			
			//Remove Restraints 
			player.changeStatusValue(StatusEffects.PrisonRestraints,1,2);
			player.changeStatusValue(StatusEffects.PrisonRestraints,2,1);
			player.changeStatusValue(StatusEffects.PrisonRestraints,3,1);
			player.changeStatusValue(StatusEffects.PrisonRestraints,4,4);
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function prisonCaptorPunishmentStockadeBreak():void 
		{
			clearOutput();
			//Checks if the player has enough willpower to attempt to break
			if (player.will < prison.prisonWillCost(10)) 
			{
				outputText("Try as you might, you just don't have enough willpower to attempt to break out of the Stockades.");
				doNext(playerMenu);
				return;
			}
			prison.changeWill(-prison.prisonWillCost(10));
			var chance:int = 10;
			chance += player.str * 0.8;
			if (rand(100) < chance) // If Strength Level multiplied by 0.8 is greater than a random number between 1 and 100, then the player breaks the stockade.
			{
				outputText("With all your strength, you finally manage to break the stockade! Loud snapping sound echoes throughout your cell.");
				outputText("\n\n" + prison.prisonCaptor.captorTitle + prison.prisonCaptor.captorName + " hears the sound and rushes over to your cell to find out that you've broken the stockade. \"<i>No! You BROKE the stockade! Very well, I'll lift your punishment.</i>\" She looks angry.");
				
				//Add a flag indicating the player is no longer in the stockades
				flags[kFLAGS.PRISON_PUNISHMENT] = 0;
			}
			else {
				//Break Attempt Fails
				outputText("You struggle against the wooden confines but despite your best efforts, you just can't break the stockade.");
			}
			doNext(playerMenu);
		}
		
		//-----------------------------------------------------------------------
		//		*******	Confinement Punishment *******
		//-----------------------------------------------------------------------
		public function prisonCaptorPunishmentConfinement():void
		{
			outputText("(Placeholder)A dark resolve comes over your [captorTitle], and [captorhe] drags you to the stone box in the corner of the room and presses a hidden switch somewhere near its base. The front panel slides open and " + prison.prisonCaptor.captorPronoun1 + " quickly forces you inside the narrow chamber.\n\n",false);
			outputText("\"<i>I'm afraid I've done you a disservice by allowing you to take my kindness for granted for so long. Well, I'll correct that mistake today. You will soon feel like you are being harshly punished, but trust me, in the end you will thank me for it. You will thank me for breaking you of your false impressions about your station in life. You will thank me because you will understand just how kind I have been. You will thank me because you will have a new found appreciation for the truth that both your mind and your body eventually submit to my will no matter how hard you try to fight it. And until you <b>do</b> thank me <b>and</b> apologize for your bad behavior, you <b>will</b> remain in this box and learn its very direct and pointed lesson.</i>\"\n\n",false);
			outputText("With that very conclusive statement " + prison.prisonCaptor.captorPronoun1 + " fastens a girdle around your waste and uses four belts to attach it to vertical metal bars in each of the four corners of the stone box. Once the belts are properly tightened you realize that they are designed to hold you securely in the center of the stone box. You can barely squirm more than an inch in any direction, and thus are completely unable to lean on the walls of the chamber.\n\n",false);
			outputText("But despite preventing any sideways movement, the straps wrap around the bars in a way that does allow you to crouch and stand freely. You understand why as your " + prison.prisonCaptor.captorTitle + " presents the final piece of the puzzle: a horizontal bar with a collection of demonically animated monstrous dildos bristling upwards along its length. Grinning, " + prison.prisonCaptor.captorPronoun1 + " positions the bar between your [legs] at a height where even if you stand on the tips of your toes the wriggling beasts can just barely find their way into your " + player.assholeDescript(),false);
			if (player.vaginas.length > 0)
			{
				outputText(" and " + player.vaginaDescript(),false);
			}
			outputText(". And with you properly strapped into the hellish box, " + prison.prisonCaptor.captorTitle + " " + prison.prisonCaptor.captorName + " shoves a penis gag down your throat, straps it in place, and closes the stone door without another word. You are left in complete darkness and silence with nothing to keep you company but your panicked thoughts and the ravenous shafts between your legs.",false);
			player.changeStatusValue(StatusEffects.PrisonCaptorEllyStatus,3,12 + rand(4));
			player.changeStatusValue(StatusEffects.PrisonCaptorEllyStatus,4,0.5 + rand(2));
			player.changeStatusValue(StatusEffects.PrisonRestraints,1,2);
			player.changeStatusValue(StatusEffects.PrisonRestraints,2,0);
			player.changeStatusValue(StatusEffects.PrisonRestraints,3,2);
			player.changeStatusValue(StatusEffects.PrisonRestraints,4,3);
			flags[kFLAGS.PRISON_PUNISHMENT] = 2;
			doNext(playerMenu);
		}
		
		public function prisonCaptorPunishmentConfinementStandup():void
		{
			clearOutput();
			var newVal:Number = 0;
			outputText("(Placeholder) You try to save some dignity by standing up off the dildos beneath you. ",false);
			newVal = player.statusEffectv4(StatusEffects.PrisonCaptorEllyStatus) - rand(3) - 2;
			if (newVal < 0)
			{
				newVal = 0.5;
			}
			if (newVal > 20)
			{
				newVal = 20;
			}
			player.changeStatusValue(StatusEffects.PrisonCaptorEllyStatus,4,newVal);
			prisonCaptorPunishmentConfinementDescribeStatus();
			if (player.hasVagina())
			{
				player.cuntChange(1.5 * newVal,true,true,false);
				player.buttChange(1.5 * newVal,true,true,false);
			}
			else
			{
				player.buttChange(1.5 * newVal,true,true,false);
			}
			if (rand(player.lust) > 70)
			{
				outputText("\n\n",false);
				prisonCaptorPunishmentConfinementMasturbate();
				return;
			}
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function prisonCaptorPunishmentConfinementRestlegs():void
		{
			clearOutput();
			var newVal:Number = 0;
			newVal = player.statusEffectv4(StatusEffects.PrisonCaptorEllyStatus) + rand(4) + 1;
			if (newVal < 0)
			{
				newVal = 0.5;
			}
			if (newVal > 20)
			{
				newVal = 20;
			}
			player.changeStatusValue(StatusEffects.PrisonCaptorEllyStatus,4,newVal);
			prisonCaptorPunishmentConfinementDescribeStatus();
			if (player.hasVagina())
			{
				player.cuntChange(1.5 * newVal,true,true,false);
				player.buttChange(1.5 * newVal,true,true,false);
			}
			else
			{
				player.buttChange(1.5 * newVal,true,true,false);
			}
			if (rand(player.lust) > 50)
			{
				outputText("\n\n",false);
				prisonCaptorPunishmentConfinementMasturbate();
				return;
			}
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function prisonCaptorPunishmentConfinementDescribeStatus(verbose:Boolean = false):void
		{
			var statusVal:Number = 0;
			statusVal = player.statusEffectv4(StatusEffects.PrisonCaptorEllyStatus);
			if (statusVal <= 1)
			{
				outputText("There is now less than an inch of dildo wriggling around inside your " + player.assholeDescript(),false);
			}
			else if (statusVal >= 20)
			{
				outputText("You've sank down as far as you can go and your " + player.assDescript() + " now rests on the bar. Over 20 inches of dildo are buried in your " + player.assholeDescript(),false);
			}
			else
			{
				outputText("There are now almost " + Math.ceil(statusVal) + " inches of dildo wriggling around inside your " + player.assholeDescript(),false);
			}
			
			if (player.vaginas.length > 0)
			{
				outputText(" and " + player.vaginaDescript(),false);
			}
			outputText(". ",false);
			if (verbose)
			{
				if (statusVal <= 3)
				{
					outputText("Keeping such a small amount of dildo inside of you requires you to stand on the tips of your toes, which is incredibly taxing physically.",false);
				}
				else if (statusVal <= 7)
				{
					outputText("You are standing more or less normally so your [legs] aren't particularly fatigued by this position, but the movement inside your nether regions is undeniably arousing.",false);
				}
				else if (statusVal <= 17)
				{
					outputText("You are in something of a half squat which does rest some of your muscles but is still taking a moderate toll on you physically. On top of that the devious sensations being generated by the ",false);
					if (player.vaginas.length > 0)
					{
						outputText("pair of girthy shafts buried deep inside your body",false);
					}
					else
					{
						outputText("girthy shaft buried deep inside your ass",false);
					}
					outputText(" are unbearably arousing.",false);
				}
				else
				{
					outputText("You are awkwardly collapsed with most of your weight supported by the ",false);
					if (player.vaginas.length > 0)
					{
						outputText("pair of enormous dildos embedded in the depths of your womb and rectum. To your great distress, your intruders are",false);
					}
					else
					{
						outputText("enormous dildo embedded in the depths of your rectum. To your great distress, your intruder is",false);
					}
					outputText(" far enough from the floor that despite being close to a kneeling position no matter how you shift your body around you can never quite get [if (isBiped = true) \"your knees to support you\"][if (isBiped = false) \"your lower body to provide the support you so desperately need\"]. The exertion of supporting yourself is turning your [legs] into useless quivering pieces of flesh, and your mind is swimming with the desire pouring from your loins.",false);
				}
				
				
			}
		}
		
		public function prisonCaptorPunishmentConfinementMasturbate():void
		{
			var newVal:Number = 0;
			outputText("(Placeholder) Overcome with lust, you masturbate on the dildos beneath you. You are filled with shame for letting the device get the better of you, and the sheer helplessness of your situation overwhelms you, damaging your will to resist your " + prison.prisonCaptor.captorTitle + ".",false);
			newVal = player.statusEffectv4(StatusEffects.PrisonCaptorEllyStatus) + 4.5;
			if (newVal > 20)
			{
				newVal = 20;
			}
			player.changeStatusValue(StatusEffects.PrisonCaptorEllyStatus,4,newVal);
			if (player.hasVagina())
			{
				player.cuntChange(1.7 * newVal,true,true,false);
				player.buttChange(1.7 * newVal,true,true,false);
			}
			else
			{
				player.buttChange(1.7 * newVal,true,true,false);
			}
			player.orgasm();
			prison.changeEsteem(-5,prison.inPrison);
			prison.changeObey(2,prison.inPrison);
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function prisonCaptorPunishmentConfinementFreedom():void
		{
			clearOutput();
			var begEvent:Function = null;
			var acceptEvent:Function = null;
			var rejectEvent:Function = null;
			outputText("(Placeholder) You are given a chance to be released from the isolation chamber -- all you need do is admit that you deserved to be punished, thank your " + prison.prisonCaptor.captorTitle + " for the lesson, and apologize for what you did wrong. ",false);
			begEvent = prisonCaptorPunishmentConfinementFreedomBeg;
			acceptEvent = prisonCaptorPunishmentConfinementFreedomAccept;
			rejectEvent = prisonCaptorPunishmentConfinementFreedomReject;
			if (player.esteem > 40 || player.obey < 10)
			{
				begEvent = null;
			}
			if (player.esteem < 20 && player.obey > 45)
			{
				acceptEvent = null;
			}
			outputText("Do accept your " + prison.prisonCaptor.captorTitle + "'s terms, or do you refuse? " + prison.prisonWillCostDescript(15),false);
			simpleChoices("Beg",begEvent,"Accept",acceptEvent,"Reject",rejectEvent,"",null,"",null);
		}
		
		public function prisonCaptorPunishmentConfinementFreedomReject():void
		{
			clearOutput();
			if (player.will < prison.prisonWillCost(15))
			{
				outputText("While you'd like to preserve a bit of your dignity, you simply don't have the willpower to resist right now. \n\n",false);
				prison.changeEsteem(2,prison.inPrison);
				if (player.esteem < 20 && player.obey > 45)
				{
					doNext(prisonCaptorPunishmentConfinementFreedomBeg);
				}
				else
				{
					doNext(prisonCaptorPunishmentConfinementFreedomAccept);
				}
				return;
			}
			outputText("(Placeholder) You refuse your " + prison.prisonCaptor.captorTitle + "'s terms, and thus must endure more time in the stone box.",false);
			player.changeStatusValue(StatusEffects.PrisonCaptorEllyStatus,3,12 + rand(4));
			prison.changeEsteem(10,prison.inPrison);
			prison.changeObey(-2.5,prison.inPrison);
			prison.changeWill(-prison.prisonWillCost(15));
			doNext(playerMenu);
		}
		
		public function prisonCaptorPunishmentConfinementFreedomBeg():void
		{
			clearOutput();
			outputText("(Placeholder) You break down and beg your " + prison.prisonCaptor.captorTitle + " to release you, thanking her for her kindness and for teaching you your place, and promise to do as " + prison.prisonCaptor.captorPronoun1 + " commands in the future. ",false);
			prison.changeEsteem(-5,prison.inPrison);
			prison.changeObey(3,prison.inPrison);
			prisonCaptorPunishmentConfinementFreedomRelease();
		}
		
		public function prisonCaptorPunishmentConfinementFreedomAccept():void
		{
			clearOutput();
			outputText("(Placeholder) You reluctantly accept your " + prison.prisonCaptor.captorTitle + "'s terms, half heartedly thanking her for punishing you and apologize for misbehaving. ",false);
			prison.changeEsteem(-3,prison.inPrison);
			prison.changeObey(1,prison.inPrison);
			if (rand(4) == 1)
			{
				outputText("\n\n(Placeholder) Your " + prison.prisonCaptor.captorTitle + " isn't satisfied that you've learned your lesson, and decides to leave you in the confinement box a bit longer. ",false);
				player.changeStatusValue(StatusEffects.PrisonCaptorEllyStatus,3,2 + rand(4));
				doNext(playerMenu);
				return;
			}
			prisonCaptorPunishmentConfinementFreedomRelease();
		}
		
		public function prisonCaptorPunishmentConfinementFreedomRelease():void
		{
			outputText("\n\n(Placeholder) In exchange, you are released from the confinement box. Apology or not, you are left bound and gagged, but for the time being you are just happy to be free of the darkness and unending physical stress of the box.",false);
			prison.prisonCaptor.updateNextWaitRandomEvent(model.time.hours, model.time.days);
			prison.prisonCaptor.updateNextRoomRandomEvent(model.time.hours, model.time.days);
			player.changeStatusValue(StatusEffects.PrisonRestraints,1,2);
			player.changeStatusValue(StatusEffects.PrisonRestraints,2,1);
			player.changeStatusValue(StatusEffects.PrisonRestraints,3,2);
			player.changeStatusValue(StatusEffects.PrisonRestraints,4,3);
			flags[kFLAGS.PRISON_PUNISHMENT] = 0;
			doNext(playerMenu);
		}
		
		public function prisonCaptorPunishmentConfinementBreak():void {
			clearOutput();
			if (player.will < prison.prisonWillCost(10)) {
				outputText("Try as you might, you just don't have enough willpower to attempt that.");
				doNext(playerMenu);
				return;
			}
			prison.changeWill(-prison.prisonWillCost(10));
			var successChance:int = 5;
			successChance += (player.str / 4);
			if (player.lowerBody == LOWER_BODY_TYPE_HOOFED || player.lowerBody == LOWER_BODY_TYPE_BUNNY || player.lowerBody == LOWER_BODY_TYPE_KANGAROO) successChance += 10;
			if (rand(100) < successChance) {
				outputText("You struggle as hard as you can. With all of your strength, you manage to snap the belts attaching you to vertical metal bars. You kick the panel as hard as you can and with a loud THUD, the panel breaks off!");
				outputText("\n\n" + prison.prisonCaptor.captorTitle + prison.prisonCaptor.captorName + " hears the sound and rushes over to your cell to find out that you've broken the confinement box. \"<i>No! You BROKE the confinement box! You know this thing costs 1,000 gems to order and you've ruined it. I'll have to send it to get it repaired. Very well, I'll lift your punishment.</i>\" She looks angry.");
				flags[kFLAGS.PRISON_PUNISHMENT] = 0;
			}
			else {
				outputText("You struggle against the stone confines but despite your best efforts, you just can't break the box.");
			}
			doNext(playerMenu);
		}
		
		
		//-----------------------------------------------------------------------
		//		*******	BJ Trainer Punishment *******
		//-----------------------------------------------------------------------
		public function prisonCaptorPunishmentBJTrainer():void
		{
			if (flags[kFLAGS.PRISON_PUNISHMENT] == 3)
			{
				outputText("\"<i>I should be clapping you in the stockade or strapping you to the rack for your continued disobedience, but I want you to finish your current lesson first. The clock is ticking, slut. Start sucking if you really want to be free.</i>\"\n\n ",false);
				doNext(playerMenu);
				return;
			}
			outputText("(Placeholder) A devious look crosses your " + prison.prisonCaptor.captorTitle + "'s face. \"<i>Normally, this kind of behavior would call for stern punishment. But today, I think I'll teach you a lesson of a different kind. You still seem to be holding onto the idea that you want to be free. I'm going to show you that deep down in your soul you have already accepted the fact that I own both your body and your mind.</i>\"\n\n",false);
			outputText("Two containers are brought into the room by imp guards. The larger of the two looks like it has a capacity of roughly twenty gallons, the smaller maybe five. Your " + prison.prisonCaptor.captorTitle + " points to the smaller one and says, \"<i>Copies of the keys to your restraints and to the door are inside this basin. As you see, it has a narrow neck that your hands won't be able to reach into, but don't lose hope: they have been attached to an object that will float. If you fill the basin with enough fluid, the keys will float up through the narrow opening and you will be able to take and use them to free yourself. However, you won't be able to fill the basin without a bit of effort. As you can see, the basin has a lid which is attached by a pneumatic tube to this device here.</i>\"\n\n",false);
			outputText("Your eyes follow the tube across the room to the larger container, which " + prison.prisonCaptor.captorPronoun1 + " has had the imps set up about six feet away from the basin with the keys inside. The cask seems to have no obvious opening on top, but where the tube connects to the container there is a complicated valve with, unsurprisingly, a large, thick dildo attached. You notice that in addition to an opening at the tip, about six or seven inches down the shaft of the dildo there are a series of holes spread around the girthy circumfrence of the thing. You realize that sucking only on the head of the cock will do nothing thanks to those holes -- you will have to swallow the shaft to the point where the holes are all inside your mouth if you want anything to come of your efforts. You are starting to get a good idea of what you are meant to do with this contraption, but " + prison.prisonCaptor.captorTitle + " " + prison.prisonCaptor.captorName + " wants to be sure you fully understand and spells it out for you.\n\n",false);
			outputText("\"<i>Form a good seal around the holes on this dick and suck hard, and the fluid you need will come out. Suck enough fluid through that valve, and the pressure generated will cause the pneumatic tube to open the lid to the basin giving you a few moments to deliver the fluid in your mouth to the basin. Do be careful not to waste the opportunity; it takes quite a while for my men to fill one of these casks with cum so you won't get another chance any time soon. Repeat this process until the basin is full, and you earn your freedom. Simple, yes?</i>\" As " + prison.prisonCaptor.captorPronoun1 + " continues speaking, she binds your arms behind your back and hobbles your legs.\n\n ",false);
			outputText("\"<i>A small extra degree of difficulty. I do want you to feel like you've really earned it, after all. But don't worry, you'll have plenty of time to work at it. Ten hours should suffice, I think. Maybe even a little more if I feel generous. In any case, it will be more than enough time for a person who truly craves freedom to fill the basin and get the keys. But as I said, deep down you don't want freedom. Deep down you love being nothing more than a piece of flesh here to entertain me. I have no doubt that you will spend the next half a day sucking on that dildo and crawling back and forth to that basin with your mouth full of jizz, ostensibly to reach those keys. But really, you will be doing it because you enjoy the abject humiliation of the act. And that, ultimately, will be the lesson you learn today.</i>\" And with that " + prison.prisonCaptor.captorPronoun1 + " leaves you alone in your cell once again.\n\n ",false);
			player.changeStatusValue(StatusEffects.PrisonCaptorEllyStatus,3,10 + rand(3));
			player.changeStatusValue(StatusEffects.PrisonCaptorEllyStatus,4,0);
			player.changeStatusValue(StatusEffects.PrisonRestraints,1,1);
			player.changeStatusValue(StatusEffects.PrisonRestraints,2,2);
			player.changeStatusValue(StatusEffects.PrisonRestraints,3,2);
			player.changeStatusValue(StatusEffects.PrisonRestraints,4,0);
			flags[kFLAGS.PRISON_PUNISHMENT] = 3;
			doNext(playerMenu);
		}
		
		public function prisonCaptorPunishmentBJTrainerSuck():void
		{
			clearOutput();
			var fillVal:int = 0;
			var selector:int = 0;
			if (player.statusEffectv4(StatusEffects.PrisonRestraints) > 0 && !(player.statusEffectv4(StatusEffects.PrisonRestraints) == 4))
			{
				outputText("Because of the way your mouth is gagged you are unable to suck on the dildo. You are consumed by the thought that the next time you are given the chance to earn your freedom this way, it might be wise to avoid doing things that would earn you a gag.",true);
				doNext(playerMenu);
				return;
			}
			if (player.statusEffectv2(StatusEffects.PrisonRestraints) > 1)
			{
				outputText("(Placeholder) You squirm your way over to the cask, prop yourself up on your knees, ",false);
			}
			else
			{
				outputText("(Placeholder) You walk over to the cask, squat down on your knees, ",false);
			}
			outputText("and wrap your lips around the dildo.\n\n",false);
			if (rand(20) > player.cor)
			{
				outputText("You spend the better part of an hour trying, but again and again you squeamishly balk before you manage to swallow enough of the simulated cock to cover the holes that dot the shaft about seven inches down. As a result, you never manage to form enough of a seal to suck more that a few dribbles of cum out of the cask leaving the basin exactly as full as it was before you started. This leaves you feeling especially humiliated and demoralized.\n\n",false);
				prison.changeObey(1,prison.inPrison);
				prison.changeEsteem(-1,prison.inPrison);
				doNext(camp.returnToCampUseOneHour);
				return;
			}
			fillVal = player.statusEffectv4(StatusEffects.PrisonCaptorEllyStatus) + 5 + rand(10);
			outputText("You slavishly struggle to cram the simulated cock into your throat, and eventually manage to swallow enough to form a proper seal around the holes that dot the shaft about seven inches down. You then begin to pump away, and before long a steady stream of cum begins pouring through the thing. With the hole at the tip of the cock so far down your throat the majority of it flows directly into your stomach. Nevertheless, your mouth is full to bursting with spunk several minutes later when you finally hear a loud click from the valve at the base of the dildo, followed by the sound of the basin's lid clanging open from the pressure you've induced on the pneumatic tube. \n\n",false);
			outputText("As quick as you can you extract the dong from your gullet, ",false);
			if (player.statusEffectv2(StatusEffects.PrisonRestraints) > 1)
			{
				outputText("wriggle your way across the six feet between you and the basin, ",false);
			}
			else
			{
				outputText("walk over to the basin, ",false);
			}
			outputText("and spit the prodigious load into the opening just before the lid closes again. \n\n",false);
			if (rand(65) > player.spe)
			{
				outputText("Unfortunately, thoughout the next hour as you attempt to make subsequent trips between the cask and the basin much of the time you are too slow and clumsy to reach the basin before the pneumatic tube loses pressure and the lid claps shut. When this happens you have no choice but to either swallow your mouthful of cum or let it dribble down your chin, and go back to try again.\n\n",false);
			}
			else
			{
				selector = rand(10);
				switch(selector)
				{
					case 0:
						outputText("Spurred on by your success, you return to the dildo and repeat the process. On your third trip back to the dildo, however, the click in the valve sounds a bit different and in addition to the basin lid opening behind you it seems to trigger a demoralizing change in the dildo. Before you can react the portion of the dildo inside your mouth balloons out like the knot in a dog's cock, more than doubling in diameter and stretching your jaw to its limit. When you try to extract it from your throat you find you are unable to squeeze the knot past your teeth, and so you spend the rest of the hour struggling to breath around the intruder. Meanwhile, cum continues to pour out of the dong, filling your stomach to capacity and dribbling out the corners of your mouth and over your cheeks and chin like a perverse fountain. Needless to say, the experience leaves you feeling particularly helpless.",false);
						prison.changeObey(0.5,prison.inPrison);
						player.refillHunger(5);
						player.changeFatigue(5);
						fillVal = fillVal + (1 + rand(2));
						break;
					case 1:
						outputText("Spurred on by your success, you return to the dildo and repeat the process. On your third trip back to the dildo, however, the click in the valve sounds a bit different and in addition to the basin lid opening behind you it seems to trigger a demoralizing change in the dildo. A new ring of holes pops open around the shaft an additional three inches below the original set. You spend the rest of the hour working to envelop the full ten inches of dildo now required to make a proper seal and generate suction, but when you finally do you are unable to pump the shaft fast enough to trigger the pressure valve again. Needless to say, the experience leaves you feeling helpless and exhausted.",false);
						prison.changeObey(0.5,prison.inPrison);
						player.changeFatigue(15);
						fillVal = fillVal + (1 + rand(2));
						break;
					case 2:
					case 3:
					case 4:
						outputText("Spurred on by your success, you return to the dildo and over the next hour or so you become more and more efficient, delivering an above average quantity of cum to the basin for the time spent.",false);
						fillVal = fillVal + (3 + rand(3));
						break;
					case 5:
					case 6:
					case 7:
					case 8:
					case 9:
					default:
						outputText("Spurred on by your success, you return to the dildo and over the next hour or so you make several more deliveries to the basin.",false);
						fillVal = fillVal + (2 + rand(3));
				}
			}
			player.slimeFeed();
			prison.changeObey(0.5,prison.inPrison);
			prison.changeEsteem(-0.5,prison.inPrison);
			player.refillHunger(5);
			player.changeStatusValue(StatusEffects.PrisonCaptorEllyStatus,4,fillVal);
			if (player.statusEffectv4(StatusEffects.PrisonCaptorEllyStatus) > 100)
			{
				outputText("\n\n(Placeholder) The basin is now full enough that you can see the keys bobbing around in the vat of cum above the narrow neck. You quickly scramble around to reach your hands inside, and pull the keys free. Elated and triumphant, you hastily remove your bindings and unlock the door, then consider what to do next.",false);
				player.changeStatusValue(StatusEffects.PrisonRestraints,1,0);
				player.changeStatusValue(StatusEffects.PrisonRestraints,2,0);
				player.changeStatusValue(StatusEffects.PrisonRestraints,3,0);
				player.changeStatusValue(StatusEffects.PrisonRestraints,4,0);
				flags[kFLAGS.PRISON_PUNISHMENT] = 0;
				flags[kFLAGS.PRISON_DOOR_UNLOCKED] = 1;
				prison.changeEsteem(10,prison.inPrison);
				doNext(playerMenu);
				return;
			}
			outputText("\n\n",false);
			prisonCaptorPunishmentBJTrainerDescribeStatus();
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function prisonCaptorPunishmentBJTrainerDescribeStatus(verbose:Boolean = false):void
		{
			var statusVal:int = 0;
			statusVal = player.statusEffectv4(StatusEffects.PrisonCaptorEllyStatus);
			outputText("The basin containing the keys is ",false);
			if (statusVal <= 10)
			{
				outputText("practically empty. ",false);
			}
			else if (statusVal <= 25)
			{
				outputText("approaching one quarter full. ",false);
			}
			else if (statusVal <= 50)
			{
				outputText("approaching half full. ",false);
			}
			else if (statusVal <= 75)
			{
				outputText("approaching three quarters full. ",false);
			}
			else if (statusVal <= 90)
			{
				outputText("nearly full to the narrow neck. ",false);
			}
			else
			{
				outputText("inches away from being full enough for you to reach the key. ",false);
			}
			
			if (verbose)
			{
				if (statusVal <= 10)
				{
					outputText(" You have a long way to go if you intend to reach the keys. ",false);
				}
				else if (statusVal <= 25)
				{
					outputText(" A small trail of cum drops is forming between the cask and the basin. ",false);
				}
				else if (statusVal <= 50)
				{
					outputText(" Your stomach churns with the cum you've swallowed in the process of filling it this far. ",false);
				}
				else if (statusVal <= 75)
				{
					outputText(" The area between the cask and the basin is now essentially a large sticky pool of cum formed from what you've spilled moving between them. ",false);
				}
				else if (statusVal <= 90)
				{
					outputText(" Your face, " + player.allChestDesc() + ", knees, and indeed pratically your whole body are coated in a sticky residue from wallowing back and forth in the lake of cum that has formed between the cask and the basin. ",false);
				}
				else
				{
					outputText(" inches away from being full enough for you to reach the key. ",false);
				}
				
			}
		}
		
		public function prisonCaptorPunishmentBJTrainerTimesup():void
		{
			outputText("(Placeholder) As " + prison.prisonCaptor.captorTitle + " " + prison.prisonCaptor.captorName + " enters the room a pair of imp guards drag the containers from your cell. \"<i>Time's up slut. See? What did I tell you? You clearly didn't actually want freedom after all, did you? Or are you going to claim that you just aren't good enough at sucking cock? Well, don't worry -- as soon as my servants produce another cask of cum I'll be sure to give you another chance to practice.</i>\"",false);
			flags[kFLAGS.PRISON_PUNISHMENT] = 0;
			prison.changeObey(1.5,prison.inPrison);
			doNext(playerMenu);
		}
	}

}
