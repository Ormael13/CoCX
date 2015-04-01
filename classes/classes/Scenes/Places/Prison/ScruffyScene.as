//NOT DONE
/*
package classes.Scenes.Places.Prison 
{
	import classes.BaseContent;

	public class ScruffyScene extends BaseContent
	{
		
		public function ScruffyScene() 
		{
			
		}
		
      public function prisonCaptorScruffyStatusText() : void
      {
         var scruffyMet:* = undefined;
         var happiness:* = this.prisonCaptorScruffyHappiness();
         scruffyMet = this.prisonCaptorScruffyMet();
         scruffyMet < 1;
      }
      
      public function prisonCaptorScruffyOptedOut() : Boolean
      {
         var testVal:* = undefined;
         if(this.player.hasStatusAffect("prisonCaptorEllyScruffy") < 0)
         {
            this.player.createStatusAffect("prisonCaptorEllyScruffy",0,0,0,0);
         }
         testVal = this.player.statusAffectv1("prisonCaptorEllyScruffy");
         if(testVal < 0)
         {
            return true;
         }
         return false;
      }
      
      public function prisonCaptorScruffyMet() : Number
      {
         if(this.player.hasStatusAffect("prisonCaptorEllyScruffy") < 0)
         {
            this.player.createStatusAffect("prisonCaptorEllyScruffy",0,0,0,0);
         }
         return this.player.statusAffectv1("prisonCaptorEllyScruffy");
      }
      
      public function prisonCaptorScruffyMetSet(newVal:Number) : void
      {
         if(this.player.hasStatusAffect("prisonCaptorEllyScruffy") < 0)
         {
            this.player.createStatusAffect("prisonCaptorEllyScruffy",0,0,0,0);
         }
         this.player.changeStatusValue("prisonCaptorEllyScruffy",1,newVal);
      }
      
      public function prisonCaptorScruffyMetChange(changeVal:Number) : void
      {
         var newVal:* = undefined;
         if(this.player.hasStatusAffect("prisonCaptorEllyScruffy") < 0)
         {
            this.player.createStatusAffect("prisonCaptorEllyScruffy",0,0,0,0);
         }
         newVal = this.player.statusAffectv1("prisonCaptorEllyScruffy") + changeVal;
         if(newVal < 0)
         {
            newVal = 0;
         }
         if(newVal > 100)
         {
            newVal = 100;
         }
         this.player.changeStatusValue("prisonCaptorEllyScruffy",1,newVal);
      }
      
      public function prisonCaptorScruffyHappiness() : Number
      {
         if(this.player.hasStatusAffect("prisonCaptorEllyScruffy") < 0)
         {
            this.player.createStatusAffect("prisonCaptorEllyScruffy",0,0,0,0);
         }
         return this.player.statusAffectv2("prisonCaptorEllyScruffy");
      }
      
      public function prisonCaptorScruffyHappinessSet(newVal:Number) : void
      {
         if(this.player.hasStatusAffect("prisonCaptorEllyScruffy") < 0)
         {
            this.player.createStatusAffect("prisonCaptorEllyScruffy",0,0,0,0);
         }
         this.player.changeStatusValue("prisonCaptorEllyScruffy",2,newVal);
      }
      
      public function prisonCaptorScruffyHappinessChange(changeVal:Number) : void
      {
         var newVal:* = undefined;
         if(this.player.hasStatusAffect("prisonCaptorEllyScruffy") < 0)
         {
            this.player.createStatusAffect("prisonCaptorEllyScruffy",0,0,0,0);
         }
         newVal = this.player.statusAffectv2("prisonCaptorEllyScruffy") + changeVal;
         this.player.changeStatusValue("prisonCaptorEllyScruffy",2,newVal);
      }
      
      public function prisonCaptorScruffyEvent() : Number
      {
         if(this.player.hasStatusAffect("prisonCaptorEllyScruffy") < 0)
         {
            this.player.createStatusAffect("prisonCaptorEllyScruffy",0,0,0,0);
         }
         return this.player.statusAffectv3("prisonCaptorEllyScruffy");
      }
      
      public function prisonCaptorScruffyEventSet(newVal:Number) : void
      {
         if(this.player.hasStatusAffect("prisonCaptorEllyScruffy") < 0)
         {
            this.player.createStatusAffect("prisonCaptorEllyScruffy",0,0,0,0);
         }
         this.player.changeStatusValue("prisonCaptorEllyScruffy",3,newVal);
      }
      
      public function prisonCaptorScruffyEventChange(changeVal:Number) : void
      {
         var newVal:* = undefined;
         if(this.player.hasStatusAffect("prisonCaptorEllyScruffy") < 0)
         {
            this.player.createStatusAffect("prisonCaptorEllyScruffy",0,0,0,0);
         }
         newVal = this.player.statusAffectv3("prisonCaptorEllyScruffy") + changeVal;
         if(newVal < 0)
         {
            newVal = 0;
         }
         if(newVal > 100)
         {
            newVal = 100;
         }
         this.player.changeStatusValue("prisonCaptorEllyScruffy",3,newVal);
      }
      
      public function prisonCaptorScruffyScratch() : Number
      {
         if(this.player.hasStatusAffect("prisonCaptorEllyScruffy") < 0)
         {
            this.player.createStatusAffect("prisonCaptorEllyScruffy",0,0,0,0);
         }
         return this.player.statusAffectv4("prisonCaptorEllyScruffy");
      }
      
      public function prisonCaptorScruffyScratchSet(newVal:Number) : void
      {
         if(this.player.hasStatusAffect("prisonCaptorEllyScruffy") < 0)
         {
            this.player.createStatusAffect("prisonCaptorEllyScruffy",0,0,0,0);
         }
         this.player.changeStatusValue("prisonCaptorEllyScruffy",4,newVal);
      }
      
      public function prisonCaptorScruffyScratchChange(changeVal:Number) : void
      {
         var newVal:* = undefined;
         if(this.player.hasStatusAffect("prisonCaptorEllyScruffy") < 0)
         {
            this.player.createStatusAffect("prisonCaptorEllyScruffy",0,0,0,0);
         }
         newVal = this.player.statusAffectv4("prisonCaptorEllyScruffy") + changeVal;
         if(newVal < 0)
         {
            newVal = 0;
         }
         if(newVal > 100)
         {
            newVal = 100;
         }
         this.player.changeStatusValue("prisonCaptorEllyScruffy",4,newVal);
      }
      
      public function prisonCaptorRandomEventJizzJanitor() : Boolean
      {
         var choiceEvents:Array = null;
         var choiceTexts:Array = null;
         var newCleanliness:* = NaN;
         choiceEvents = [];
         choiceTexts = [];
         choiceEvents[1] = 50104;
         choiceTexts[1] = "Refuse";
         choiceEvents[2] = 50105;
         choiceTexts[2] = "Accept";
         choiceEvents[3] = 0;
         choiceTexts[3] = "";
         choiceEvents[4] = 0;
         choiceTexts[4] = "";
         choiceEvents[5] = 0;
         choiceTexts[5] = "";
         choiceEvents[6] = 50106;
         choiceTexts[6] = "Reject";
         choiceEvents[7] = 50107;
         choiceTexts[7] = "Perform";
         choiceEvents[8] = 0;
         choiceTexts[8] = "";
         choiceEvents[9] = 0;
         choiceTexts[9] = "";
         this.outputText("\nYou look up as the door squeaks open and see a skinny imp enter the room with a mop and a bucket.  He\'s wearing a janitor\'s scrub top with a nametag that reads \"Scruffy\" but you doubt it originally belonged to him since it is about five sizes too large and he is very noticeably not wearing the matching scrub pants that should go with it. He flatly ignores you as he begins the unenviable task of cleaning your cell, but after a few minutes of lackadaisical cleaning he turns and seems to notice your presence for the first time. ",false);
         this.outputText("\n\n\"<i>Well, aren\'t you a tasty little thing?  The " + this.prisonCaptor.captorTitle + " sure knows how to pick em\'.</i>\" he growls, looking you up and down appraisingly. You notice his not insubstantial cock begin to stir and start to get a sinking feeling.\n\n",false);
         this.outputText("\"<i>Anyway, don\'t ever let me hear you complainin\' about " + this.prisonCaptor.captorPronoun2 + ", \'cause ",false);
         if(this.prisonMenuEventExists("Room",50123))
         {
            this.outputText(this.prisonCaptor.captorPronoun1 + "\'s givin\' you a break today sending me in to help clean out this pigsty of a cell that you seem to be content to live in.",false);
            newCleanliness = this.player.statusAffectv2("prisonCaptorEllyStatus") - 50;
            if(newCleanliness < 0)
            {
               newCleanliness = 0;
            }
            this.player.changeStatusValue("prisonCaptorEllyStatus",2,newCleanliness);
         }
         else
         {
            this.outputText(this.prisonCaptor.captorPronoun1 + " makes most of the cum-dumpsters in training clean up their own filth. Clearly " + this.prisonCaptor.captorPronoun1 + " thinks you\'re something special though, sending me in to do your dirty work for you. ",false);
         }
         this.outputText("Seriously, I\'ll never understand the way you ungrateful little sluts disrespect " + this.prisonCaptor.captorPronoun2 + ".</i>\" As he finishes the sentence he seems to drift off in a cloud of love and reverence, but he soon comes back down to earth and turns his attention back to you.",false);
         this.outputText("\n\n\"<i>Speaking of respect and gratitude,</i>\" he says with a lecherous grin,\"<i>",false);
         if(this.player.hunger > 80)
         {
            this.outputText("You look absolutely famished ",false);
         }
         else
         {
            this.outputText("I know good meals can be few and far between in this place ",false);
         }
         this.outputText("and I just happen to have some extra food I\'d be willing to share with you if you were to show me some, ahem --</i>\" he pauses to lewdly and intricately pantomime giving a blowjob, complete with creating a bulge in one cheek with his tongue, \"<i>respect and gratitude for the great efforts I\'m putting into making your cell a little more habitable.</i>\"\n\n",false);
         this.outputText("You consider how you should respond to Scruffy\'s offer.\n\n",false);
         if(this.player.hunger >= 100 && (this.player.esteem < 40 || this.player.esteem < 60 && this.player.obey > 10))
         {
            this.outputText("\nYou are simply too hungry to turn the offer down.\n",false);
            choiceEvents[1] = 0;
            choiceEvents[6] = 0;
         }
         else
         {
            this.outputText("You could politely refuse " + this.prisonWillCostDescript(5),false);
            if(this.player.esteem < 20 || this.player.esteem < 40 && this.player.obey > 25)
            {
               this.outputText(" but you don\'t think you could manage any stronger a rebuke to someone trying to show you kindness due to your your obvious powerlessness and insignificance.",false);
               choiceEvents[6] = 0;
            }
            else
            {
               this.outputText(" or you could angrily reject the offer " + this.prisonWillCostDescript(15) + ".",false);
            }
         }
         if(this.player.hunger < 100 && (this.player.esteem > 90 || this.player.esteem > 70 && this.player.obey < 10))
         {
            this.outputText("\n\nYou have too much dignity to accept, regardless of the fact that it seems like his intention was to help you, even if it was in his own perverted way.\n",false);
            choiceEvents[2] = 0;
            choiceEvents[7] = 0;
         }
         else
         {
            this.outputText("\n\nYou could accept Scruffy\'s charity, ",false);
            if(this.player.esteem > 60 || this.player.esteem > 40 && this.player.obey < 25)
            {
               this.outputText("but you have too much dignity to really put your heart into it.\n",false);
               choiceEvents[7] = 0;
            }
            else
            {
               this.outputText("or you could really show your gratitude and perform above and beyond what he\'s asked for. \n",false);
            }
         }
         this.choices(choiceTexts[1],choiceEvents[1],choiceTexts[2],choiceEvents[2],choiceTexts[3],choiceEvents[3],choiceTexts[4],choiceEvents[4],choiceTexts[5],choiceEvents[5],choiceTexts[6],choiceEvents[6],choiceTexts[7],choiceEvents[7],choiceTexts[8],choiceEvents[8],choiceTexts[9],choiceEvents[9],"",0);
         return true;
      }
      
      public function prisonCaptorRandomEventJizzJanitorRefuse() : void
      {
         if(this.player.will < this.prisonWillCost(5))
         {
            this.outputText("While you\'d like to preserve a bit of your dignity and politely turn down the offer, you simply don\'t have the willpower to resist Scruffy\'s advances right now. ",false);
            if(this.rand(this.player.esteem * 3) > this.player.obey + this.player.lust + this.player.cor)
            {
               this.changeEsteem(2,this.inPrison);
               this.outputText("\n\n",false);
               this.prisonCaptorRandomEventJizzJanitorAccept();
            }
            else
            {
               this.outputText(" In fact, while a second ago you thought you had the desire to resist him, now the thought of debasing yourself for his approval and the sight of his girthy dick are filling you with an overwheling desire to do the exact opposite and show him just how grateful you are for his kindness.\n\n",false);
               this.prisonCaptorRandomEventJizzJanitorPerform();
            }
         }
         else
         {
            this.outputText("You realize that this was probably the closest thing to a friendly gesture you are likely to encounter in this place, so you ",false);
            if(this.player.statusAffectv4("prisonRestraint") == 0)
            {
               this.outputText("politely but firmly turn down the offer. ",false);
            }
            else
            {
               this.outputText("assume a friendly posture and communicate your refusal by shaking your head. ",false);
            }
            this.outputText("\n\nBefore you can even begin to react, you see his face turn to a mask of rage as he hammers you over the head with the bucket he was so recently using to clean up your filth. You momentarily black out, and when you come to you realize that he has bound your hands behind your back and used them to hang you by a chain to an eyelet in the ceiling. Your body is suspended in a fashion such that your back is arched suggestively, your head is hanging at knee height, and your feet are only touching the ground with the tips of your toes. [if (isBiped = true) \"What\'s more, he has used his mop as a makeshift spreader bar to hold your ankles as far apart as they will go leaving your [vagOrAss] completely exposed between the parted cheeks of your [ass]\"][if (isBiped = false) \"With your [legs] hanging as they are your [vagOrAss] is completely exposed between the cheeks of your [ass]\"].",false);
            this.outputText("\n\n(Placeholder) Scruffy then fucks your [vagOrAss], makes you lick up the cum pool to \'feed\' you, leaves you hogtied with a stern warning to improve your behavior.\n\n",false);
            this.player.knockUp(1,400);
            if(this.player.hasVagina())
            {
               this.cuntChange(20,true,true,false);
            }
            else
            {
               this.buttChange(20,true,true,false);
            }
            this.slimeFeed();
            this.player.changeStatusValue("prisonRestraint",2,2);
            this.player.changeStatusValue("prisonRestraint",3,2);
            this.player.changeStatusValue("prisonRestraint",4,0);
            this.changeEsteem(5,this.inPrison);
            this.changeObey(-1,this.inPrison);
            this.changeHunger(-10,this.inPrison);
            this.changeWill(-this.prisonWillCost(5));
            this.doNext(1);
         }
      }
      
      public function prisonCaptorRandomEventJizzJanitorAccept() : void
      {
         this.outputText("Acknowledging how true it is that a good meal is hard to come by in your current situation, you decide that it wouldn\'t hurt to (as the imp put it) show a bit of gratitude in exchange for some extra food, especially considering that relative to your other experiences in this place Scruffy\'s offer was downright good natured. ",false);
         this.outputText("Your mind made up, you assume a subservient posture and meeky communicate your acceptance ",true);
         if(this.player.statusAffectv4("prisonRestraint") == 0)
         {
            this.outputText("with a mumbled word. ",false);
         }
         else
         {
            this.outputText("by nodding your head. ",false);
         }
         this.outputText("\n\n(Placeholder)  Scruffy puts on/switches you to an open mouth gag because he doesn\'t want you biting but removes other bindings, doesn\'t find your performance good enough and fucks your [face]. He leaves you telling you to improve your performance, and your body via the item he gives you.",false);
         this.outputText("\n\n\"<i>Well, at least you show you understand that you are only here to be used by your betters. Put some effort into it next time and maybe I\'ll give you a little something extra as well. Be sure to eat what I have given you, though -- it\'ll help make your body more pleasing to old Scruffy the next time I come around.</i>\"",false);
         this.slimeFeed();
         this.player.changeStatusValue("prisonRestraint",2,0);
         this.player.changeStatusValue("prisonRestraint",3,0);
         this.player.changeStatusValue("prisonRestraint",4,4);
         this.changeEsteem(-5,this.inPrison);
         this.outputText("\n\n",false);
         this.shortName = "SucMilk";
         this.takeItem();
      }
      
      public function prisonCaptorRandomEventJizzJanitorReject() : void
      {
         if(this.player.will < this.prisonWillCost(15))
         {
            this.outputText("While you\'d love nothing more than to outright reject the humiliating offer, you simply don\'t have the willpower to resist Scruffy\'s advances right now. ",false);
            if(this.rand(this.player.esteem * 3) > this.player.obey + this.player.lust + this.player.cor)
            {
               this.changeEsteem(3,this.inPrison);
               this.outputText("\n\n",false);
               this.prisonCaptorRandomEventJizzJanitorAccept();
            }
            else
            {
               this.outputText(" In fact, while a second ago you thought you had the desire to resist him, now the thought of debasing yourself for his approval and the sight of his girthy dick are filling you with an overwheling desire to do the exact opposite and show him just how grateful you are for his kindness.\n\n",false);
               this.prisonCaptorRandomEventJizzJanitorPerform();
            }
         }
         else
         {
            this.outputText("An attempt at kindness or not, the offer is humiliating in a way you aren\'t willing to accept at the moment. Gathering your courage, ",false);
            if(this.player.statusAffectv4("prisonRestraint") == 0)
            {
               this.outputText("you unleash a verbal stream of pent up aggression on the scrawny imp janitor, flatly rejecting his deal. ",false);
            }
            else
            {
               this.outputText("you assume a defensive posture and scream your rejection of the deal through your gag. ",false);
            }
            this.outputText("\n\nBefore you can even begin to react, you see his face turn to a mask of rage as he hammers you over the head with the bucket he was so recently using to clean up your filth. You momentarily black out, and when you come to you realize that ",false);
            if(this.player.statusAffectv2("prisonRestraint") != 2)
            {
               this.outputText("he has hogtied you. ",false);
            }
            else
            {
               this.outputText("he has savagely tightened your bindings. ",false);
            }
            this.outputText("You also notice that his dick has gone limp and wonder how that bodes for your fortunes. The answer comes quickly enough.\n\n ",false);
            this.outputText("\"<i>You ungrateful little bitch. Normally I\'d teach you a lesson in humility and obedience more directly, but somehow you\'ve managed to kill my mood.</i>\" He punctuates the sentence by delivering a swift kick to your ribs, and then dramatically draws the largest dildo gag you\'ve ever seen from behind his back. \"<i>Well, I suppose this will have to suffice for your reeducation today. Perhaps the next time you see me you\'ll remember how much better off you would have been with my prick in your mouth instead.</i>\"",false);
            this.outputText("\n\nAnd with that he forces the monstrous rubber phallus into your mouth, locks the straps behind your head, grabs his mop and bucket and leaves the room in an exaggerated huff. You manage to take some solace in the fact that you stood up for yourself and avoided servicing the little jizz janitor, but you are unsure if the price was worth it.\n",false);
            this.player.changeStatusValue("prisonRestraint",2,2);
            this.player.changeStatusValue("prisonRestraint",3,2);
            this.player.changeStatusValue("prisonRestraint",4,3);
            this.changeEsteem(10,this.inPrison);
            this.changeObey(-2,this.inPrison);
            this.changeWill(-this.prisonWillCost(15));
            this.doNext(1);
         }
      }
      
      public function prisonCaptorRandomEventJizzJanitorPerform() : void
      {
         var freeitemslots:* = NaN;
         this.outputText("(Placeholder) Scruffy puts on/switches you to an open mouth gag because he doesn\'t want you biting but removes other bindings, you give a super hot BJ including a titfuck if you have tits, and he leaves giving you praise for being a good slave, but tells you to improve your body with the items he gives you.",false);
         freeitemslots = 0;
         if(this.itemSlot1.quantity == 0)
         {
            freeitemslots++;
         }
         if(this.itemSlot2.quantity == 0)
         {
            freeitemslots++;
         }
         if(this.itemSlot3.quantity == 0)
         {
            freeitemslots++;
         }
         if((this.itemSlot4.unlocked) && this.itemSlot4.quantity == 0)
         {
            freeitemslots++;
         }
         if((this.itemSlot5.unlocked) && this.itemSlot5.quantity == 0)
         {
            freeitemslots++;
         }
         this.outputText("\n\n\"<i>Well, it certainly is nice to see that you\'ve been taking your lessons to heart and know how you are expected to behave. In fact, ",false);
         if(freeitemslots > 1)
         {
            this.outputText(" I think that quality of performance deserves extra rewards. Now be a good little cum-dumpster and be sure to eat it all -- it\'ll help make your body more pleasing to old Scruffy the next time I come around.",false);
         }
         else
         {
            this.outputText(" I\'d be inclined to give you something extra if you didn\'t have such a stash of goodies saved up already. Be sure to eat what I have given you you, though -- it\'ll help make your body more pleasing to old Scruffy the next time I come around.",false);
         }
         this.outputText("</i>\"",false);
         this.slimeFeed();
         this.player.changeStatusValue("prisonRestraint",2,0);
         this.player.changeStatusValue("prisonRestraint",3,0);
         this.player.changeStatusValue("prisonRestraint",4,4);
         this.changeEsteem(-7,this.inPrison);
         this.changeObey(1,this.inPrison);
         this.outputText("\n\n",false);
         this.shortName = "SucMilk";
         this.takeItem();
         if(freeitemslots > 1)
         {
            this.outputText("\n\n",false);
            this.shortName = "NPnkEgg";
            this.takeItem();
         }
         if(freeitemslots > 2)
         {
            this.outputText("\n\n",false);
            this.shortName = "PinkEgg";
            this.takeItem();
         }
      }
	}
}
*/