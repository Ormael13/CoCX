//Scruffy the Imp Janitor
package classes.Scenes.Places.Prison 
{
	import classes.*;
	import classes.GlobalFlags.*;
	
	public class ScruffyScene extends BaseContent
	{
		
		public function ScruffyScene() 
		{
			
		}
		
		public function prisonCaptorScruffyStatusText():void
		{
			var scruffyMet:* = undefined;
			var happiness:* = prisonCaptorScruffyHappiness();
			scruffyMet = prisonCaptorScruffyMet();
			scruffyMet < 1;
		}
		
		public function prisonCaptorScruffyOptedOut():Boolean
		{
			var testVal:* = undefined;
			if (player.findStatusEffect(StatusEffects.PrisonCaptorEllyScruffy) < 0)
			{
				player.createStatusEffect(StatusEffects.PrisonCaptorEllyScruffy,0,0,0,0);
			}
			testVal = player.statusEffectv1(StatusEffects.PrisonCaptorEllyScruffy);
			if (testVal < 0)
			{
				return true;
			}
			return false;
		}
		
		public function prisonCaptorScruffyMet():Number
		{
			if (player.findStatusEffect(StatusEffects.PrisonCaptorEllyScruffy) < 0)
			{
				player.createStatusEffect(StatusEffects.PrisonCaptorEllyScruffy,0,0,0,0);
			}
			return player.statusEffectv1(StatusEffects.PrisonCaptorEllyScruffy);
		}
		
		public function prisonCaptorScruffyMetSet(newVal:Number):void
		{
			if (player.findStatusEffect(StatusEffects.PrisonCaptorEllyScruffy) < 0)
			{
				player.createStatusEffect(StatusEffects.PrisonCaptorEllyScruffy,0,0,0,0);
			}
			player.changeStatusValue(StatusEffects.PrisonCaptorEllyScruffy,1,newVal);
		}
		
		public function prisonCaptorScruffyMetChange(changeVal:Number):void
		{
			var newVal:* = undefined;
			if (player.findStatusEffect(StatusEffects.PrisonCaptorEllyScruffy) < 0)
			{
				player.createStatusEffect(StatusEffects.PrisonCaptorEllyScruffy,0,0,0,0);
			}
			newVal = player.statusEffectv1(StatusEffects.PrisonCaptorEllyScruffy) + changeVal;
			if (newVal < 0)
			{
				newVal = 0;
			}
			if (newVal > 100)
			{
				newVal = 100;
			}
			player.changeStatusValue(StatusEffects.PrisonCaptorEllyScruffy,1,newVal);
		}
		
		public function prisonCaptorScruffyHappiness():Number
		{
			if (player.findStatusEffect(StatusEffects.PrisonCaptorEllyScruffy) < 0)
			{
				player.createStatusEffect(StatusEffects.PrisonCaptorEllyScruffy,0,0,0,0);
			}
			return player.statusEffectv2(StatusEffects.PrisonCaptorEllyScruffy);
		}
		
		public function prisonCaptorScruffyHappinessSet(newVal:Number):void
		{
			if (player.findStatusEffect(StatusEffects.PrisonCaptorEllyScruffy) < 0)
			{
				player.createStatusEffect(StatusEffects.PrisonCaptorEllyScruffy,0,0,0,0);
			}
			player.changeStatusValue(StatusEffects.PrisonCaptorEllyScruffy,2,newVal);
		}
		
		public function prisonCaptorScruffyHappinessChange(changeVal:Number):void
		{
			var newVal:* = undefined;
			if (player.findStatusEffect(StatusEffects.PrisonCaptorEllyScruffy) < 0)
			{
				player.createStatusEffect(StatusEffects.PrisonCaptorEllyScruffy,0,0,0,0);
			}
			newVal = player.statusEffectv2(StatusEffects.PrisonCaptorEllyScruffy) + changeVal;
			player.changeStatusValue(StatusEffects.PrisonCaptorEllyScruffy,2,newVal);
		}
		
		public function prisonCaptorScruffyEvent():Number
		{
			if (player.findStatusEffect(StatusEffects.PrisonCaptorEllyScruffy) < 0)
			{
				player.createStatusEffect(StatusEffects.PrisonCaptorEllyScruffy,0,0,0,0);
			}
			return player.statusEffectv3(StatusEffects.PrisonCaptorEllyScruffy);
		}
		
		public function prisonCaptorScruffyEventSet(newVal:Number):void
		{
			if (player.findStatusEffect(StatusEffects.PrisonCaptorEllyScruffy) < 0)
			{
				player.createStatusEffect(StatusEffects.PrisonCaptorEllyScruffy,0,0,0,0);
			}
			player.changeStatusValue(StatusEffects.PrisonCaptorEllyScruffy,3,newVal);
		}
		
		public function prisonCaptorScruffyEventChange(changeVal:Number):void
		{
			var newVal:* = undefined;
			if (player.findStatusEffect(StatusEffects.PrisonCaptorEllyScruffy) < 0)
			{
				player.createStatusEffect(StatusEffects.PrisonCaptorEllyScruffy,0,0,0,0);
			}
			newVal = player.statusEffectv3(StatusEffects.PrisonCaptorEllyScruffy) + changeVal;
			if (newVal < 0)
			{
				newVal = 0;
			}
			if (newVal > 100)
			{
				newVal = 100;
			}
			player.changeStatusValue(StatusEffects.PrisonCaptorEllyScruffy,3,newVal);
		}
		
		public function prisonCaptorScruffyScratch():Number
		{
			if (player.findStatusEffect(StatusEffects.PrisonCaptorEllyScruffy) < 0)
			{
				player.createStatusEffect(StatusEffects.PrisonCaptorEllyScruffy,0,0,0,0);
			}
			return player.statusEffectv4(StatusEffects.PrisonCaptorEllyScruffy);
		}
		
		public function prisonCaptorScruffyScratchSet(newVal:Number):void
		{
			if (player.findStatusEffect(StatusEffects.PrisonCaptorEllyScruffy) < 0)
			{
				player.createStatusEffect(StatusEffects.PrisonCaptorEllyScruffy,0,0,0,0);
			}
			player.changeStatusValue(StatusEffects.PrisonCaptorEllyScruffy,4,newVal);
		}
		
		public function prisonCaptorScruffyScratchChange(changeVal:Number):void
		{
			var newVal:* = undefined;
			if (player.findStatusEffect(StatusEffects.PrisonCaptorEllyScruffy) < 0)
			{
				player.createStatusEffect(StatusEffects.PrisonCaptorEllyScruffy,0,0,0,0);
			}
			newVal = player.statusEffectv4(StatusEffects.PrisonCaptorEllyScruffy) + changeVal;
			if (newVal < 0)
			{
				newVal = 0;
			}
			if (newVal > 100)
			{
				newVal = 100;
			}
			player.changeStatusValue(StatusEffects.PrisonCaptorEllyScruffy,4,newVal);
		}
		
		public function prisonCaptorRandomEventJizzJanitor():Boolean
		{
			hideMenus();
			clearOutput();
			var newCleanliness:int = 0;
			var refuse:Function = prisonCaptorRandomEventJizzJanitorRefuse;
			var accept:Function = prisonCaptorRandomEventJizzJanitorAccept;
			var reject:Function = prisonCaptorRandomEventJizzJanitorReject;
			var perform:Function = prisonCaptorRandomEventJizzJanitorPerform;
			outputText("You look up as the door squeaks open and see a skinny imp enter the room with a mop and a bucket.  He's wearing a janitor's scrub top with a nametag that reads \"Scruffy\" but you doubt it originally belonged to him since it is about five sizes too large and he is very noticeably not wearing the matching scrub pants that should go with it. He flatly ignores you as he begins the unenviable task of cleaning your cell, but after a few minutes of lackadaisical cleaning he turns and seems to notice your presence for the first time. ",false);
			outputText("\n\n\"<i>Well, aren't you a tasty little thing?  The " + prison.prisonCaptor.captorTitle + " sure knows how to pick em'.</i>\" he growls, looking you up and down appraisingly. You notice his not insubstantial cock begin to stir and start to get a sinking feeling.\n\n",false);
			outputText("\"<i>Anyway, don't ever let me hear you complainin' about " + prison.prisonCaptor.captorPronoun2 + ", 'cause ",false);
			if (flags[kFLAGS.PRISON_DIRT_ENABLED] > 0)
			{
				outputText(prison.prisonCaptor.captorPronoun1 + "'s givin' you a break today sending me in to help clean out this pigsty of a cell that you seem to be content to live in.",false);
				newCleanliness = player.statusEffectv2(StatusEffects.PrisonCaptorEllyStatus) - 50;
				if (newCleanliness < 0)
				{
					newCleanliness = 0;
				}
				player.changeStatusValue(StatusEffects.PrisonCaptorEllyStatus,2,newCleanliness);
			}
			else
			{
				outputText(prison.prisonCaptor.captorPronoun1 + " makes most of the cum-dumpsters in training clean up their own filth. Clearly " + prison.prisonCaptor.captorPronoun1 + " thinks you're something special though, sending me in to do your dirty work for you. ",false);
			}
			outputText("Seriously, I'll never understand the way you ungrateful little sluts disrespect " + prison.prisonCaptor.captorPronoun2 + ".</i>\" As he finishes the sentence he seems to drift off in a cloud of love and reverence, but he soon comes back down to earth and turns his attention back to you.",false);
			outputText("\n\n\"<i>Speaking of respect and gratitude,</i>\" he says with a lecherous grin,\"<i>",false);
			if (player.hunger < 20)
			{
				outputText("You look absolutely famished ",false);
			}
			else
			{
				outputText("I know good meals can be few and far between in this place ",false);
			}
			outputText("and I just happen to have some extra food I'd be willing to share with you if you were to show me some, ahem --</i>\" he pauses to lewdly and intricately pantomime giving a blowjob, complete with creating a bulge in one cheek with his tongue, \"<i>respect and gratitude for the great efforts I'm putting into making your cell a little more habitable.</i>\"\n\n",false);
			outputText("You consider how you should respond to Scruffy's offer.\n\n",false);
			if (player.hunger <= 0 && (player.esteem < 40 || player.esteem < 60 && player.obey > 10))
			{
				outputText("\nYou are simply too hungry to turn the offer down.\n",false);
				refuse = null;
				reject = null;
			}
			else
			{
				outputText("You could politely refuse " + prison.prisonWillCostDescript(5),false);
				if (player.esteem < 20 || player.esteem < 40 && player.obey > 25)
				{
					outputText(" but you don't think you could manage any stronger a rebuke to someone trying to show you kindness due to your your obvious powerlessness and insignificance.",false);
					reject = null;
				}
				else
				{
					outputText(" or you could angrily reject the offer " + prison.prisonWillCostDescript(15) + ".",false);
				}
			}
			if (player.hunger > 0 && (player.esteem > 90 || player.esteem > 70 && player.obey < 10))
			{
				outputText("\n\nYou have too much dignity to accept, regardless of the fact that it seems like his intention was to help you, even if it was in his own perverted way.\n",false);
				accept = null;
				perform = null;
			}
			else
			{
				outputText("\n\nYou could accept Scruffy's charity, ",false);
				if (player.esteem > 60 || player.esteem > 40 && player.obey < 25)
				{
					outputText("but you have too much dignity to really put your heart into it.\n",false);
					perform = null;
				}
				else
				{
					outputText("or you could really show your gratitude and perform above and beyond what he's asked for. \n",false);
				}
			}
			menu();
			addButton(0, "Refuse", refuse);
			addButton(1, "Accept", accept);
			addButton(5, "Reject", reject);
			addButton(6, "Perform", perform);
			if (prisonCaptorScruffyScratch() >= 2) addButton(7, "FIGHT!", fightScruffy);
			return true;
		}
		
		public function prisonCaptorRandomEventJizzJanitorRefuse():void
		{
			clearOutput();
			if (player.will < prison.prisonWillCost(5))
			{
				outputText("While you'd like to preserve a bit of your dignity and politely turn down the offer, you simply don't have the willpower to resist Scruffy's advances right now. ",false);
				if (rand(player.esteem * 3) > player.obey + player.lust + player.cor)
				{
					prison.changeEsteem(2,prison.inPrison);
					outputText("\n\n",false);
					prisonCaptorRandomEventJizzJanitorAccept();
				}
				else
				{
					outputText(" In fact, while a second ago you thought you had the desire to resist him, now the thought of debasing yourself for his approval and the sight of his girthy dick are filling you with an overwheling desire to do the exact opposite and show him just how grateful you are for his kindness.\n\n",false);
					prisonCaptorRandomEventJizzJanitorPerform();
				}
			}
			else
			{
				outputText("You realize that this was probably the closest thing to a friendly gesture you are likely to encounter in this place, so you ",false);
				if (player.statusEffectv4(StatusEffects.PrisonRestraints) == 0)
				{
					outputText("politely but firmly turn down the offer. ",false);
				}
				else
				{
					outputText("assume a friendly posture and communicate your refusal by shaking your head. ",false);
				}
				outputText("\n\nBefore you can even begin to react, you see his face turn to a mask of rage as he hammers you over the head with the bucket he was so recently using to clean up your filth. You momentarily black out, and when you come to you realize that he has bound your hands behind your back and used them to hang you by a chain to an eyelet in the ceiling. Your body is suspended in a fashion such that your back is arched suggestively, your head is hanging at knee height, and your feet are only touching the ground with the tips of your toes. [if (isBiped = true) \"What's more, he has used his mop as a makeshift spreader bar to hold your ankles as far apart as they will go leaving your [vagOrAss] completely exposed between the parted cheeks of your [ass]\"][if (isBiped = false) \"With your [legs] hanging as they are your [vagOrAss] is completely exposed between the cheeks of your [ass]\"].",false);
				outputText("\n\n(Placeholder) Scruffy then fucks your [vagOrAss], makes you lick up the cum pool to 'feed' you, leaves you hogtied with a stern warning to improve your behavior.",false);
				if (player.hasVagina())
				{
					player.cuntChange(20, true, true, false);
					player.knockUp(PregnancyStore.PREGNANCY_IMP, PregnancyStore.INCUBATION_IMP);
				}
				else
				{
					player.buttChange(20,true,true,false);
				}
				player.slimeFeed();
				player.changeStatusValue(StatusEffects.PrisonRestraints,2,2);
				player.changeStatusValue(StatusEffects.PrisonRestraints,3,2);
				player.changeStatusValue(StatusEffects.PrisonRestraints, 4, 0);
				player.refillHunger(10);
				prison.changeEsteem(5,prison.inPrison);
				prison.changeObey(-1,prison.inPrison);
				prison.changeWill(-prison.prisonWillCost(5));
				prisonCaptorScruffyScratchChange(1);
				doNext(playerMenu);
			}
		}
		
		public function prisonCaptorRandomEventJizzJanitorAccept():void
		{
			clearOutput();
			outputText("Acknowledging how true it is that a good meal is hard to come by in your current situation, you decide that it wouldn't hurt to (as the imp put it) show a bit of gratitude in exchange for some extra food, especially considering that relative to your other experiences in this place Scruffy's offer was downright good natured. ",false);
			outputText("Your mind made up, you assume a subservient posture and meeky communicate your acceptance ",true);
			if (player.statusEffectv4(StatusEffects.PrisonRestraints) == 0)
			{
				outputText("with a mumbled word. ",false);
			}
			else
			{
				outputText("by nodding your head. ",false);
			}
			outputText("\n\n(Placeholder)  Scruffy puts on/switches you to an open mouth gag because he doesn't want you biting but removes other bindings, doesn't find your performance good enough and fucks your [face]. He leaves you telling you to improve your performance, and your body via the item he gives you.",false);
			outputText("\n\n\"<i>Well, at least you show you understand that you are only here to be used by your betters. Put some effort into it next time and maybe I'll give you a little something extra as well. Be sure to eat what I have given you, though -- it'll help make your body more pleasing to old Scruffy the next time I come around.</i>\"",false);
			player.slimeFeed();
			player.changeStatusValue(StatusEffects.PrisonRestraints,2,0);
			player.changeStatusValue(StatusEffects.PrisonRestraints,3,0);
			player.changeStatusValue(StatusEffects.PrisonRestraints,4,4);
			prison.changeEsteem(-5,prison.inPrison);
			outputText("\n\n", false);
			inventory.takeItem(consumables.SUCMILK, camp.returnToCampUseOneHour);
		}
		
		public function prisonCaptorRandomEventJizzJanitorReject():void
		{
			clearOutput();
			if (player.will < prison.prisonWillCost(15))
			{
				outputText("While you'd love nothing more than to outright reject the humiliating offer, you simply don't have the willpower to resist Scruffy's advances right now. ",false);
				if (rand(player.esteem * 3) > player.obey + player.lust + player.cor)
				{
					prison.changeEsteem(3,prison.inPrison);
					outputText("\n\n",false);
					prisonCaptorRandomEventJizzJanitorAccept();
				}
				else
				{
					outputText(" In fact, while a second ago you thought you had the desire to resist him, now the thought of debasing yourself for his approval and the sight of his girthy dick are filling you with an overwheling desire to do the exact opposite and show him just how grateful you are for his kindness.\n\n",false);
					prisonCaptorRandomEventJizzJanitorPerform();
				}
			}
			else
			{
				outputText("An attempt at kindness or not, the offer is humiliating in a way you aren't willing to accept at the moment. Gathering your courage, ",false);
				if (player.statusEffectv4(StatusEffects.PrisonRestraints) == 0)
				{
					outputText("you unleash a verbal stream of pent up aggression on the scrawny imp janitor, flatly rejecting his deal. ",false);
				}
				else
				{
					outputText("you assume a defensive posture and scream your rejection of the deal through your gag. ",false);
				}
				outputText("\n\nBefore you can even begin to react, you see his face turn to a mask of rage as he hammers you over the head with the bucket he was so recently using to clean up your filth. You momentarily black out, and when you come to you realize that ",false);
				if (player.statusEffectv2(StatusEffects.PrisonRestraints) != 2)
				{
					outputText("he has hogtied you. ",false);
				}
				else
				{
					outputText("he has savagely tightened your bindings. ",false);
				}
				outputText("You also notice that his dick has gone limp and wonder how that bodes for your fortunes. The answer comes quickly enough.\n\n ",false);
				outputText("\"<i>You ungrateful little bitch. Normally I'd teach you a lesson in humility and obedience more directly, but somehow you've managed to kill my mood.</i>\" He punctuates the sentence by delivering a swift kick to your ribs, and then dramatically draws the largest dildo gag you've ever seen from behind his back. \"<i>Well, I suppose this will have to suffice for your reeducation today. Perhaps the next time you see me you'll remember how much better off you would have been with my prick in your mouth instead.</i>\"",false);
				outputText("\n\nAnd with that he forces the monstrous rubber phallus into your mouth, locks the straps behind your head, grabs his mop and bucket and leaves the room in an exaggerated huff. You manage to take some solace in the fact that you stood up for yourself and avoided servicing the little jizz janitor, but you are unsure if the price was worth it.\n",false);
				player.changeStatusValue(StatusEffects.PrisonRestraints,2,2);
				player.changeStatusValue(StatusEffects.PrisonRestraints,3,2);
				player.changeStatusValue(StatusEffects.PrisonRestraints,4,3);
				prison.changeEsteem(10,prison.inPrison);
				prison.changeObey(-2,prison.inPrison);
				prison.changeWill(-prison.prisonWillCost(15));
				prisonCaptorScruffyScratchChange(1);
				doNext(playerMenu);
			}
		}
		
		public function prisonCaptorRandomEventJizzJanitorPerform():void
		{
			clearOutput();
			var freeitemslots:int = inventory.getMaxSlots() - inventory.getOccupiedSlots();
			outputText("(Placeholder) Scruffy puts on/switches you to an open mouth gag because he doesn't want you biting but removes other bindings, you give a super hot BJ including a titfuck if you have tits, and he leaves giving you praise for being a good slave, but tells you to improve your body with the items he gives you.",false);
			outputText("\n\n\"<i>Well, it certainly is nice to see that you've been taking your lessons to heart and know how you are expected to behave. In fact, ",false);
			if (freeitemslots > 1)
			{
				outputText(" I think that quality of performance deserves extra rewards. Now be a good little cum-dumpster and be sure to eat it all -- it'll help make your body more pleasing to old Scruffy the next time I come around.",false);
			}
			else
			{
				outputText(" I'd be inclined to give you something extra if you didn't have such a stash of goodies saved up already. Be sure to eat what I have given you you, though -- it'll help make your body more pleasing to old Scruffy the next time I come around.",false);
			}
			outputText("</i>\"",false);
			player.slimeFeed();
			player.changeStatusValue(StatusEffects.PrisonRestraints,2,0);
			player.changeStatusValue(StatusEffects.PrisonRestraints,3,0);
			player.changeStatusValue(StatusEffects.PrisonRestraints,4,4);
			prison.changeEsteem(-7,prison.inPrison);
			prison.changeObey(1,prison.inPrison);
			outputText("\n\n",false);
			inventory.takeItem(consumables.SUCMILK, camp.returnToCampUseOneHour);
			if (freeitemslots > 1)
			{
				outputText("\n\n",false);
				inventory.takeItem(consumables.NPNKEGG, camp.returnToCampUseOneHour);
			}
			if (freeitemslots > 2)
			{
				outputText("\n\n",false);
				inventory.takeItem(consumables.PINKEGG, camp.returnToCampUseOneHour);
			}
		}
		
		public function fightScruffy():void {
			clearOutput();
			outputText("How dare he keeps coming. If you refuse even in the slightest manner, he would flip out and punish you. Time to teach him a lesson.");
			prison.prisonCombatWinEvent = null;
			startCombat(new Scruffy());
		}
		
		public function prisonCaptorRandomEventJizzJanitorBeatenUp():void {
			clearOutput();
			if (monster.HP <= 0) outputText("Scruffy collapses from his injuries.");
			else outputText("Scruffy collapses from his overwhelming arousal.");
			outputText("\n\nYou drag him out the door. Hopefully he won't bother you for a while.");
			prison.randomCooldownScruffy += 12 + rand(36);
			combat.cleanupAfterCombat();
		}
		
		public function prisonCaptorRandomEventJizzJanitorLoss():void {
			clearOutput();
			if (player.HP <= 0) outputText("<b>Scruffy has knocked you off your feet.</b>");
			else outputText("<b>You are too aroused to continue fighting. You give in.</b>");
			outputText("\n\n\"<i>You ungrateful little bitch. Normally I'd teach you a lesson in humility and obedience more directly, but somehow you've managed to kill my mood.</i>\" He punctuates the sentence by delivering a swift kick to your ribs, and then dramatically draws the largest dildo gag you've ever seen from behind his back. \"<i>Well, I suppose this will have to suffice for your reeducation today. Perhaps the next time you see me you'll remember how much better off you would have been with my prick in your mouth instead.</i>\"",false);
			outputText("\n\nAnd with that he forces the monstrous rubber phallus into your mouth, locks the straps behind your head, grabs his mop and bucket and leaves the room in an exaggerated huff. You manage to take some solace in the fact that you stood up for yourself and avoided servicing the little jizz janitor, but you are unsure if the price was worth it.\n",false);
			player.changeStatusValue(StatusEffects.PrisonRestraints, 2, 2);
			player.changeStatusValue(StatusEffects.PrisonRestraints, 3, 2);
			player.changeStatusValue(StatusEffects.PrisonRestraints, 4, 3);
			combat.cleanupAfterCombat();
		}
	}
}
