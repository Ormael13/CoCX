package classes.Scenes.Places.Prison 
{
	import classes.*;
	import classes.GlobalFlags.*;
	
	public class TrainingPet extends BaseContent
	{
		
		public function TrainingPet() {}
		
		public function prisonCaptorPetStatusText():void
		{
			var currentTier:int = 0;
			var currentEvent:int = 0;
			var petScore:int = 0;
			currentTier = prisonCaptorPetTier();
			currentEvent = prisonCaptorPetEvent();
			petScore = prisonCaptorPetScore();
			if (currentTier < 3)
			{
				return;
			}
			outputText("<b>Mistress Elly's Pet Status: </b>");
			switch(currentTier)
			{
				case 1:
					outputText("Curious\n");
					outputText("<b>Licked bowl: </b>" + currentEvent + " times\n");
					break;
				case 2:
					outputText("Dreaming\n");
					outputText("<b>Dream Progress: </b>");
					if (currentEvent == 0)
					{
						outputText("none/teasing\n");
					}
					else if (currentEvent == 1)
					{
						outputText("intro seen\n");
					}
					else if (currentEvent == 2)
					{
						outputText("lazy seen\n");
					}
					else if (currentEvent == 3)
					{
						outputText("modest seen\n");
					}
					else if (currentEvent == 4)
					{
						outputText("excited seen\n");
					}
					else if (currentEvent == 5)
					{
						outputText("had a chance to play\n");
					}
					else
					{
						outputText("played " + (currentEvent - 5) + " times\n");
					}
					
					outputText("<b>Refused training offer: </b>");
					if (flags[kFLAGS.PRISON_TRAINING_REFUSED] > 0)
					{
						outputText("yes\n");
					}
					else
					{
						outputText("no\n");
					}
					break;
				case 3:
					outputText("In Training\n");
					break;
				case 4:
					outputText("Well Trained\n");
					break;
				default:
					outputText("Something else!\n");
			}
			outputText("<b>Current Pet Score: </b>" + petScore + " \n");
		}
		
		public function prisonCaptorPetOptedOut():Boolean
		{
			var testVal:* = undefined;
			if (player.findStatusEffect(StatusEffects.PrisonCaptorEllyPet) < 0)
			{
				player.createStatusEffect(StatusEffects.PrisonCaptorEllyPet,0,0,0,0);
			}
			testVal = player.statusEffectv1(StatusEffects.PrisonCaptorEllyPet);
			if (testVal < 0)
			{
				return true;
			}
			return false;
		}
		
		public function prisonCaptorPetScore():Number
		{
			if (player.findStatusEffect(StatusEffects.PrisonCaptorEllyPet) < 0)
			{
				player.createStatusEffect(StatusEffects.PrisonCaptorEllyPet,0,0,0,0);
			}
			return player.statusEffectv1(StatusEffects.PrisonCaptorEllyPet);
		}
		
		public function prisonCaptorPetScoreSet(newVal:Number):void
		{
			if (player.findStatusEffect(StatusEffects.PrisonCaptorEllyPet) < 0)
			{
				player.createStatusEffect(StatusEffects.PrisonCaptorEllyPet,0,0,0,0);
			}
			player.changeStatusValue(StatusEffects.PrisonCaptorEllyPet,1,newVal);
		}
		
		public function prisonCaptorPetScoreChange(changeVal:Number):void
		{
			var newVal:* = undefined;
			if (player.findStatusEffect(StatusEffects.PrisonCaptorEllyPet) < 0)
			{
				player.createStatusEffect(StatusEffects.PrisonCaptorEllyPet,0,0,0,0);
			}
			newVal = player.statusEffectv1(StatusEffects.PrisonCaptorEllyPet) + changeVal;
			if (newVal < 0)
			{
				newVal = 0;
			}
			if (newVal > 100)
			{
				newVal = 100;
			}
			player.changeStatusValue(StatusEffects.PrisonCaptorEllyPet,1,newVal);
		}
		
		public function prisonCaptorPetTier():Number
		{
			if (player.findStatusEffect(StatusEffects.PrisonCaptorEllyPet) < 0)
			{
				player.createStatusEffect(StatusEffects.PrisonCaptorEllyPet,0,0,0,0);
			}
			return player.statusEffectv2(StatusEffects.PrisonCaptorEllyPet);
		}
		
		public function prisonCaptorPetTierSet(newVal:Number):void
		{
			if (player.findStatusEffect(StatusEffects.PrisonCaptorEllyPet) < 0)
			{
				player.createStatusEffect(StatusEffects.PrisonCaptorEllyPet,0,0,0,0);
			}
			player.changeStatusValue(StatusEffects.PrisonCaptorEllyPet,2,newVal);
		}
		
		public function prisonCaptorPetTierUpdate(forceUpdate:Boolean = false):void
		{
			var currentTier:int = 0;
			var currentEvent:int = 0;
			var petScore:int = 0;
			currentTier = prisonCaptorPetTier();
			currentEvent = prisonCaptorPetEvent();
			petScore = prisonCaptorPetScore();
			switch(currentTier)
			{
				case 0:
					prisonCaptorPetTierSet(1);
					prisonCaptorPetEventSet(0);
					break;
				case 1:
					if (petScore >= 5 && currentEvent > 0 && player.hasKeyItem("Mistress Elly's Slave Collar") >= 0 && player.esteem < 30 && player.cor < 15)
					{
						prisonCaptorPetTierSet(2);
						prisonCaptorPetEventSet(0);
					}
					break;
				case 2:
					if (forceUpdate)
					{
						prisonCaptorPetTierSet(3);
						prisonCaptorPetEventSet(0);
						prisonCaptorPetScoreSet(0);
						flags[kFLAGS.PRISON_TRAINING_REFUSED] = 0;
					}
					break;
				case 3:
				case 4:
					break;
			}
		}
		
		public function prisonCaptorPetEvent():Number
		{
			if (player.findStatusEffect(StatusEffects.PrisonCaptorEllyPet) < 0)
			{
				player.createStatusEffect(StatusEffects.PrisonCaptorEllyPet,0,0,0,0);
			}
			return player.statusEffectv3(StatusEffects.PrisonCaptorEllyPet);
		}
		
		public function prisonCaptorPetEventSet(newVal:Number):void
		{
			if (player.findStatusEffect(StatusEffects.PrisonCaptorEllyPet) < 0)
			{
				player.createStatusEffect(StatusEffects.PrisonCaptorEllyPet,0,0,0,0);
			}
			player.changeStatusValue(StatusEffects.PrisonCaptorEllyPet,3,newVal);
		}
		
		public function prisonCaptorPetEventChange(changeVal:Number):void
		{
			var newVal:* = undefined;
			if (player.findStatusEffect(StatusEffects.PrisonCaptorEllyPet) < 0)
			{
				player.createStatusEffect(StatusEffects.PrisonCaptorEllyPet,0,0,0,0);
			}
			newVal = player.statusEffectv3(StatusEffects.PrisonCaptorEllyPet) + changeVal;
			if (newVal < 0)
			{
				newVal = 0;
			}
			if (newVal > 100)
			{
				newVal = 100;
			}
			player.changeStatusValue(StatusEffects.PrisonCaptorEllyPet,3,newVal);
		}
		
		public function prisonCaptorPetScratch():Number
		{
			if (player.findStatusEffect(StatusEffects.PrisonCaptorEllyPet) < 0)
			{
				player.createStatusEffect(StatusEffects.PrisonCaptorEllyPet,0,0,0,0);
			}
			return player.statusEffectv4(StatusEffects.PrisonCaptorEllyPet);
		}
		
		public function prisonCaptorPetScratchSet(newVal:Number):void
		{
			if (player.findStatusEffect(StatusEffects.PrisonCaptorEllyPet) < 0)
			{
				player.createStatusEffect(StatusEffects.PrisonCaptorEllyPet,0,0,0,0);
			}
			player.changeStatusValue(StatusEffects.PrisonCaptorEllyPet,4,newVal);
		}
		
		public function prisonCaptorPetScratchChange(changeVal:Number):void
		{
			var newVal:* = undefined;
			if (player.findStatusEffect(StatusEffects.PrisonCaptorEllyPet) < 0)
			{
				player.createStatusEffect(StatusEffects.PrisonCaptorEllyPet,0,0,0,0);
			}
			newVal = player.statusEffectv4(StatusEffects.PrisonCaptorEllyPet) + changeVal;
			if (newVal < 0)
			{
				newVal = 0;
			}
			if (newVal > 100)
			{
				newVal = 100;
			}
			player.changeStatusValue(StatusEffects.PrisonCaptorEllyPet,4,newVal);
		}
		
		public function prisonCaptorPetLickCumBowl(branchChoice:String, previousEvent:Function = null):void
		{
			var currentScore:int = 0;
			var itemEvent:Function = null;
			
			if (branchChoice == "choose")
			{
				clearOutput();
				outputText("You look at the bowl full of cum with bits of soggy bread floating in it, and take a moment to decide whether you should eat it normally, or set the bowl on the ground and lick it clean using just your tongue.");
				outputText("\n\n");
				prison.prisonItemEventCheck = false;
				//prison.trainingPet.prisonCaptorPetScratchSet(previousEvent);
				menu();
				addButton(0, "Lick", prisonCaptorPetLickCumBowl, "lick");
				addButton(1, "Eat", prison.prisonItemBread, true, false);
				return;
			}
			if (branchChoice == "afterlick")
			{
				outputText("(Placeholder) Afterward, you find yourself overcome with an odd sensation of tranquility. ");
				prisonCaptorPetScratchSet(0);
				doNext(inventory.inventoryMenu);
				player.refillHunger(20);
				return;
			}
			outputText("(Placeholder) You place the bowl on the floor, get down on all fours, and lick the bowl clean using only your tongue. \n\n");
			prison.prisonItemBreadHeatEffect(15);
			if (prisonCaptorPetTier() == 1)
			{
				prisonCaptorPetEventChange(1);
			}
			currentScore = prisonCaptorPetScore();
			if (currentScore < 10)
			{
				prisonCaptorPetScoreChange(1);
			}
			else if (currentScore < 20)
			{
				prisonCaptorPetScoreChange(0.5);
			}
			prisonCaptorPetTierUpdate();
			//itemEvent = prisonCaptorPetScratch();
			prisonCaptorPetScratchSet( -1);
			prisonCaptorPetLickCumBowl("afterlick");
			doNext(playerMenu);
		}
		
		public function prisonCaptorPetDreamStart(branchChoice:String = "choose"):Boolean
		{
			//var _loc8_:* = undefined;
			var currentTier:* = prisonCaptorPetTier();
			var currentEvent:* = prisonCaptorPetEvent();
			var petScore:* = prisonCaptorPetScore();
			var demandFlagged:* = flags[kFLAGS.PRISON_TRAINING_REFUSED];
			return false;
		}
		
		public function prisonCaptorPetDreamTeaser(branchChoice:String = "choose"):void
		{
			outputText("(Placeholder) (Teaser dream) Convince player to lose their corruption/esteem so that they can do pet content.\n\n");
			doNext(playerMenu);
		}
		
		public function prisonCaptorPetDreamIntro(branchChoice:String = "choose"):void
		{
			var currentTier:* = undefined;
			var corChange:* = undefined;
			currentTier = prisonCaptorPetTier();
			if (branchChoice == "choose")
			{
				if (currentTier == 2)
				{
					prisonCaptorPetEventSet(1);
				}
				prisonCaptorPetScoreSet(5);
				outputText("\n\n");
				outputText("(Placeholder) (Intro dream) PC imagines lying in grass on a cloudy day, his arms under his cheek and his legs curled up. [He]'s naked save a collar, but it feels strangely comfortable. A woman's voice greets him, but as [he] looks up the sun blurs [his] vision a moment before she pushes his head back down, ruffling his hair with a giggle. PC feels a sudden warmth, and wakes up flushed.\n\n");
				outputText("How do you feel about that?  (Probably should telegraph that 'outraged' is an optout.)\n\n");
				outputText("\n\n");
				menu();
				addButton(0,"Good",prisonCaptorPetDreamIntro,1);
				addButton(1,"Unsure...",prisonCaptorPetDreamIntro,2);
				addButton(2,"Outraged",prisonCaptorPetDreamIntro,3);
				return;
			}
			if (branchChoice == "1")
			{
				clearOutput();
				outputText("(Placeholder) (Intro dream) PC decides he liked it, giving his petScore an initial bump to make the randomized dreams more frequent.\n\n");
				prisonCaptorPetScoreChange(3);
				prison.changeEsteem(-1, prison.inPrison);
				prison.changeWill(10);
				corChange = -1;
				dynStats("cor", corChange);
			}
			else if (branchChoice == "2")
			{
				clearOutput();
				outputText("(Placeholder) (Intro dream) PC is unsure and decides to figure it out later. Event proceeds as normal, but the dreams will be less frequent and he'll have to indulge a few extra to reach the next Tier.\n\n");
			}
			else if (branchChoice == "3")
			{
				clearOutput();
				outputText("(Placeholder) (Intro dream) Text indicating that the PC resolves to never enjoy being treated like a dog and will probably never such dreams again.\n\n");
				prisonCaptorPetScoreSet(-1);
			}
			
			
			doNext(playerMenu);
		}
		
		public function prisonCaptorPetDreamLazy(branchChoice:String = "choose"):void
		{
			var currentTier:int = prisonCaptorPetTier()
			var currentEvent:int = prisonCaptorPetEvent();
			var previousDreamValue:int = 0;
			var dreamValue:int = 0;
			var dreamSelect:int = 0;
			var corChange:Number = 0;
			var petScore:int = prisonCaptorPetScore();
			previousDreamValue = prisonCaptorPetScratch();
			var demandFlagged:int = flags[kFLAGS.PRISON_TRAINING_REFUSED];
			if (branchChoice == "choose")
			{
				if (currentTier == 2 && currentEvent < 2)
				{
					prisonCaptorPetEventSet(2);
				}
				outputText("\n\n");
				outputText("(Placeholder) (Lazy dream) PC imagines something similar to the intro dream, as well as other passive facets of being a pet. There would probably be a few variations, but they would mostly be short snippets of him being coddled or resting or played with.\n\n");
				dreamValue = 0;
				dreamSelect = 0;
				do
				{
					dreamSelect = rand(3);
					dreamValue = 10 + dreamSelect;
				}
				while(previousDreamValue == dreamValue);
				
				prisonCaptorPetScratchSet(dreamValue);
				switch(dreamSelect)
				{
					case 0:
						outputText("(Placeholder) (Lazy dream) Variation 0. \n\n");
						break;
					case 1:
						outputText("(Placeholder) (Lazy dream) Variation 1. \n\n");
						break;
					case 2:
						outputText("(Placeholder) (Lazy dream) Variation 2. \n\n");
						break;
				}
				outputText("How do you react to this unexpected reverie?\n\n");
				outputText("\n\n");
				menu();
				addButton(0,"Enjoy It",prisonCaptorPetDreamLazy,1);
				addButton(1,"Wake Up",prisonCaptorPetDreamLazy,2);
				return;
			}
			if (branchChoice == "1")
			{
				clearOutput();
				outputText("(Placeholder) (Lazy dream) PC decides to see the dream through, getting a cute conclusion and increasing his petScore.\n\n");
				prisonCaptorPetScoreChange(1);
				prison.changeEsteem(-1, prison.inPrison);
				prison.changeWill(10);
				corChange = -0.25;
				dynStats("cor", corChange);
			}
			else if (branchChoice == "2")
			{
				clearOutput();
				outputText("(Placeholder) (Lazy dream) PC decides to stop the dream for whatever reason, reducing his petScore.\n\n");
				prisonCaptorPetScoreChange(-1);
			}
			
			doNext(playerMenu);
		}
		
		public function prisonCaptorPetDreamModest(branchChoice:String = "choose"):void
		{
			var currentTier:* = undefined;
			var currentEvent:* = undefined;
			var previousDreamValue:* = undefined;
			var dreamValue:* = undefined;
			var dreamSelect:* = undefined;
			var corChange:* = undefined;
			currentTier = prisonCaptorPetTier();
			currentEvent = prisonCaptorPetEvent();
			var petScore:* = prisonCaptorPetScore();
			previousDreamValue = prisonCaptorPetScratch();
			var demandFlagged:* = flags[kFLAGS.PRISON_TRAINING_REFUSED];
			if (branchChoice == "choose")
			{
				if (currentTier == 2 && currentEvent < 3)
				{
					prisonCaptorPetEventSet(3);
				}
				outputText("\n\n");
				outputText("(Placeholder) (Modest dream) PC has dreams involving behavior more associated with being a dog rather than just being comforted. Could be training for simple tricks, being fed or walked, etc. Now the PC has some agency in the dream, and can either play along or wake up\n\n");
				dreamValue = 0;
				dreamSelect = 0;
				do
				{
					dreamSelect = rand(3);
					dreamValue = 20 + dreamSelect;
				}
				while(previousDreamValue == dreamValue);
				
				prisonCaptorPetScratchSet(dreamValue);
				switch(dreamSelect)
				{
					case 0:
						outputText("(Placeholder) (Modest dream) Variation 0. \n\n");
						break;
					case 1:
						outputText("(Placeholder) (Modest dream) Variation 1. \n\n");
						break;
					case 2:
						outputText("(Placeholder) (Modest dream) Variation 2. \n\n");
						break;
				}
				outputText("How do you react to this unexpected reverie?\n\n");
				outputText("\n\n");
				outputText("\n\n");
				outputText("\n\n");
				menu();
				addButton(0,"Play Along",prisonCaptorPetDreamModest,1);
				addButton(1,"Wake Up",prisonCaptorPetDreamModest,2);
				return;
			}
			if (branchChoice == "1")
			{
				clearOutput();
				outputText("(Placeholder) (Modest dream) PC decides to progress the dream, seeing the cute conclusion and increasing his petScore.\n\n");
				prisonCaptorPetScoreChange(1);
				prison.changeEsteem(-1, prison.inPrison);
				prison.changeWill(10);
				corChange = -0.25;
				dynStats("cor", corChange);
			}
			else if (branchChoice == "2")
			{
				clearOutput();
				outputText("(Placeholder) (Modest dream) PC decides to stop the dream for whatever reason, reducing his petScore.\n\n");
				prisonCaptorPetScoreChange(-1);
			}
			
			doNext(playerMenu);
		}
		
		public function prisonCaptorPetDreamExcited(branchChoice:String = "choose"):void
		{
			var currentTier:* = undefined;
			var currentEvent:* = undefined;
			var petScore:* = undefined;
			var previousDreamValue:* = undefined;
			var dreamValue:* = undefined;
			var dreamSelect:* = undefined;
			var corChange:* = undefined;
			currentTier = prisonCaptorPetTier();
			currentEvent = prisonCaptorPetEvent();
			petScore = prisonCaptorPetScore();
			previousDreamValue = prisonCaptorPetScratch();
			var demandFlagged:int = flags[kFLAGS.PRISON_TRAINING_REFUSED];
			if (branchChoice == "choose")
			{
				if (currentTier == 2 && currentEvent < 4)
				{
					prisonCaptorPetEventSet(4);
				}
				outputText("\n\n");
				outputText("(Placeholder) (Excited dream) PC has dreams where he is very lucid, perhaps revisiting scenarios from the Lazy/Modest variants or having some new ones. At some point, the PC will feel an instinct to bark. He can either indulge it or stop himself and wake up.\n\n");
				dreamValue = 0;
				dreamSelect = 0;
				do
				{
					dreamSelect = rand(3);
					dreamValue = 20 + dreamSelect;
				}
				while(previousDreamValue == dreamValue);
				
				prisonCaptorPetScratchSet(dreamValue);
				switch(dreamSelect)
				{
					case 0:
						outputText("(Placeholder) (Excited dream) Variation 0. \n\n");
						break;
					case 1:
						outputText("(Placeholder) (Excited dream) Variation 1. \n\n");
						break;
					case 2:
						outputText("(Placeholder) (Excited dream) Variation 2. \n\n");
						break;
				}
				outputText("How do you react to this unexpected reverie?\n\n");
				outputText("\n\n");
				outputText("\n\n");
				outputText("\n\n");
				menu();
				addButton(0,"Woof!",prisonCaptorPetDreamExcited,1);
				addButton(1,"Enough!",prisonCaptorPetDreamExcited,2);
				return;
			}
			if (branchChoice == "1")
			{
				clearOutput();
				outputText("(Placeholder) (Excited dream) PC barks, having fun with his indulgence, seeing the cute conclusion and increasing his petScore.\n\n");
				prisonCaptorPetScoreChange(1);
				prison.changeEsteem(-1, prison.inPrison);
				prison.changeWill(10);
				corChange = -0.25;
				dynStats("cor", corChange);
				if (petScore >= 20)
				{
					outputText("(Placeholder) (Excited dream) Smooth transition to play offer event. \"...suddenly you feel your belly being rubbed.\"\n\n");
					menu();
					addButton(0,"Enjoy it!",prisonCaptorPetPlayOffer);
					return;
				}
				outputText("(Placeholder) (Excited dream) If you need to have a smooth ending instead of transitioning to play offer, it goes here.\n\n");
			}
			else if (branchChoice == "2")
			{
				clearOutput();
				outputText("(Placeholder) (Excited dream) PC decides to stop the dream for whatever reason, reducing his petScore by 2).\n\n");
				prisonCaptorPetScoreChange(-2);
			}
			
			doNext(playerMenu);
		}
		
		public function prisonCaptorPetPlayOffer(branchChoice:String = "choose"):void
		{
			var currentTier:* = undefined;
			var currentEvent:* = undefined;
			var petScore:* = undefined;
			var corChange:* = undefined;
			currentTier = prisonCaptorPetTier();
			currentEvent = prisonCaptorPetEvent();
			petScore = prisonCaptorPetScore();
			var previousDreamValue:* = prisonCaptorPetScratch();
			var demandFlagged:int = flags[kFLAGS.PRISON_TRAINING_REFUSED];
			corChange = 0;
			if (prisonCaptorPetEvent() < 5 && currentTier == 2)
			{
				prisonCaptorPetEventSet(5);
			}
			if (branchChoice == "choose")
			{
				clearOutput();
				outputText("(Placeholder) (Play offer) PC is thoroughly enjoying his little dream, his owner doing something above/away from him while he feels his belly being rubbed. Rolling over to enjoy it, it faintly occurs to him that the sensation is coming from...nowhere? His reverie slowly fades away and his eyes flutter open to see Mistress Elly rubbing his belly while he yaps and paddles his limbs playfully in the air. Assuming he survives the heart attack...\n\n");
				outputText("\"<i>Having fun, [boy]?</i>\"...and your cheeks turn bright enough to light the solar system.\n\n");
				outputText("Before PC has time to freak out too much, Elly simply offers to play with him. Maybe pulls out a leash to really get the point across for the intro scene.\n\n");
				outputText("How do you react to this offer?\n\n");
				outputText("\n\n");
				menu();
				addButton(0,"Eagerly",prisonCaptorPetPlayOffer,1);
				addButton(1,"Shyly",prisonCaptorPetPlayOffer,2);
				addButton(2,"Decline",prisonCaptorPetPlayOffer,3);
				if (currentTier == 2)
				{
					addButton(3,"Never!",prisonCaptorPetPlayOffer,4);
				}
				return;
			}
			if (branchChoice == "1")
			{
				clearOutput();
				outputText("(Placeholder) (Play offer) PC dives right in and does the equivalent of a \"Perform\" for Elly.\n\n");
				prisonCaptorPetScoreChange(3);
				if (currentTier == 2)
				{
					prisonCaptorPetEventChange(1);
				}
				prison.changeEsteem(-1, prison.inPrison);
				prison.changeWill(10);
				corChange = -0.25;
				dynStats("cor", corChange);
				if (petScore >= 30 && currentTier == 2 && currentEvent >= 7)
				{
					outputText("(Placeholder) (Play offer) Smooth transition to training offer event. \"As you begin to tire out, Mistress Elly gives you a calculating glance.\"\n\n");
					menu();
					addButton(0,"Woof?",prisonCaptorPetTrainingOffer);
					return;
				}
				outputText("(Placeholder) (Play offer) If you need to have a smooth ending instead of transitioning to training offer, it goes here.\n\n");
			}
			else if (branchChoice == "2")
			{
				clearOutput();
				outputText("(Placeholder) (Play offer) PC decides to give it a try for reasons left ambiguous. The text would probably hint that he is either legitimately shy but interested or simply too startled to mount a refusal.\n\n");
				prisonCaptorPetScoreChange(2);
				if (currentTier == 2)
				{
					prisonCaptorPetEventChange(1);
				}
				corChange = -0.25;
				dynStats("cor", corChange);
				if (petScore >= 30 && currentTier == 2 && currentEvent >= 7)
				{
					outputText("(Placeholder) (Play offer) Smooth transition to training offer event. \"As you begin to tire out, Mistress Elly gives you a calculating glance.\"\n\n");
					menu();
					addButton(0,"Woof?",prisonCaptorPetTrainingOffer);
					return;
				}
				outputText("(Placeholder) (Play offer) If you need to have a smooth ending instead of transitioning to training offer, it goes here.\n\n");
			}
			else
			{
				if (branchChoice == "3")
				{
					clearOutput();
					outputText("(Placeholder) (Play offer) PC politely declines. Elly coaxes him by offering a treat.\n\n");
					outputText("\n\n");
					outputText("\n\n");
					outputText("\n\n");
					menu();
					addButton(0,"Alright...",prisonCaptorPetPlayOffer,5);
					if (currentTier == 2)
					{
						addButton(1,"No!",prisonCaptorPetPlayOffer,6);
					}
					return;
				}
				if (branchChoice == "4")
				{
					clearOutput();
					outputText("(Placeholder) (Play offer) PC does the equivalent of a \"Reject\", Elly gets mad and decides to remind him what he is if he's not willing to be her pet. Box/Stockades/Etc.\n\n");
					prisonCaptorPetScoreSet(-1);
					prison.prisonPunishment(0);
					return;
				}
				if (branchChoice == "5")
				{
					clearOutput();
					outputText("(Placeholder) (Play offer) Transitions into \"Shyly\", which should give a treat anyway but I suppose would be made to if necessary.\n\n");
					prisonCaptorPetScoreChange(1);
					if (currentTier == 2)
					{
						prisonCaptorPetEventChange(1);
					}
					corChange = -0.25;
					dynStats("cor", corChange);
					if (petScore >= 30 && currentTier == 2 && currentEvent >= 7)
					{
						outputText("(Placeholder) (Play offer) Smooth transition to training offer event. \"As you begin to tire out, Mistress Elly gives you a calculating glance.\"\n\n");
						menu();
						addButton(0,"Woof?",prisonCaptorPetTrainingOffer);
						return;
					}
					outputText("(Placeholder) (Play offer) If you need to have a smooth ending instead of transitioning to training offer, it goes here.\n\n");
				}
				else if (branchChoice == "6")
				{
					clearOutput();
					outputText("(Placeholder) (Play offer) Elly makes fun of the PC and teases him for being reluctant, but does not force the issue. Might make a chance for \"punish\" reluctant puppies if I can think of any compelling scenes that would fit this tier.\n\n");
					prisonCaptorPetScoreSet(20);
					corChange = -0.25;
					dynStats("cor", corChange);
				}
				
			}
			
			doNext(playerMenu);
		}
		
		public function prisonCaptorPetTrainingOffer(branchChoice:String = "choose"):void
		{
			var currentTier:* = undefined;
			var corChange:* = undefined;
			currentTier = prisonCaptorPetTier();
			var currentEvent:* = prisonCaptorPetEvent();
			var petScore:* = prisonCaptorPetScore();
			var previousDreamValue:* = prisonCaptorPetScratch();
			var demandFlagged:int = flags[kFLAGS.PRISON_TRAINING_REFUSED];
			corChange = 0;
			if (branchChoice == "choose")
			{
				outputText("\n\n");
				outputText("(Placeholder) (Training offer) Elly tells the PC they could have much more fun if he were more proficient and says she should start \"training\" him to be a proper puppy.\n\n");
				outputText("How do you react to this offer?\n\n");
				outputText("\n\n");
				menu();
				addButton(0,"Accept",prisonCaptorPetTrainingOffer,1);
				addButton(1,"Decline",prisonCaptorPetTrainingOffer,2);
				return;
			}
			if (branchChoice == "1")
			{
				clearOutput();
				outputText("(Placeholder) (Training offer) PC accepts her offer to be trained; she's very happy and gives the player a treat.\n\n");
				prisonCaptorPetTierUpdate(true);
				prisonCaptorPetScoreChange(15);
				prison.changeEsteem(-1, prison.inPrison);
				prison.changeWill(10);
				player.refillHunger(40);
				corChange = -0.25;
				dynStats("cor", corChange);
				menu();
				addButton(0,"Continue...",prisonCaptorPetTrainingAcceptedIntro,0);
				return;
			}
			if (branchChoice == "2")
			{
				clearOutput();
				outputText("(Placeholder) (Training offer) PC politely declines. Implies he's not comfortable with being \"trained\" even if he enjoys this a bit. Elly eggs him on.\n\n");
				outputText("\n\n");
				menu();
				addButton(0,"Alright...",prisonCaptorPetTrainingOffer,3);
				addButton(1,"No!",prisonCaptorPetTrainingOffer,4);
				return;
			}
			if (branchChoice == "3")
			{
				clearOutput();
				outputText("(Placeholder) (Training offer) Transitions into a shy version of \"Accept\" scene.\n\n");
				prisonCaptorPetTierUpdate(true);
				prisonCaptorPetScoreChange(10);
				corChange = -0.25;
				dynStats("cor", corChange);
				menu();
				addButton(0,"Continue...",prisonCaptorPetTrainingAcceptedIntro,1);
				return;
			}
			if (branchChoice == "4")
			{
				clearOutput();
				outputText("(Placeholder) (Training offer) PC refuses training more forcefully. Elly warns him that she's not going to play with him if he can't be a good boy.\n\n");
				prisonCaptorPetScoreSet(30);
				if (currentTier == 2)
				{
					prisonCaptorPetEventSet(5);
				}
				flags[kFLAGS.PRISON_TRAINING_REFUSED] = 1;
				corChange = -0.25;
				dynStats("cor", corChange);
			}
			doNext(playerMenu);
		}
		
		public function prisonCaptorPetTrainingDemand(branchChoice:String = "choose"):void
		{
			var corChange:* = undefined;
			var currentTier:* = prisonCaptorPetTier();
			var currentEvent:* = prisonCaptorPetEvent();
			var petScore:* = prisonCaptorPetScore();
			var previousDreamValue:* = prisonCaptorPetScratch();
			var demandFlagged:int = flags[kFLAGS.PRISON_TRAINING_REFUSED];
			corChange = 0;
			if (branchChoice == "choose")
			{
				outputText("\n\n");
				outputText("(Placeholder) (Training Demand!) Elly informs the PC that since he clearly wants to be her puppy, but is too shy / rambunctious to accept being trained, she's no longer giving him the choice. Probably apologizes for giving him the choice to begin with and comforts that she won't put that burden on him ever again. Probably brings a leash, too...\n\n");
				outputText("How do you react?\n\n");
				outputText("\n\n");
				menu();
				addButton(0,"Submit",prisonCaptorPetTrainingDemand,1);
				addButton(1,"Refuse",prisonCaptorPetTrainingDemand,2);
				return;
			}
			if (branchChoice == "1")
			{
				clearOutput();
				outputText("(Placeholder) (Training Demand!) PC displays his submission; she's very happy and puts a leash on him.\n\n");
				prisonCaptorPetTierUpdate(true);
				prisonCaptorPetScoreChange(10);
				prison.changeEsteem(-1, prison.inPrison);
				prison.changeWill(10);
				corChange = -0.25;
				dynStats("cor", corChange);
				menu();
				addButton(0,"Continue...",prisonCaptorPetTrainingAcceptedIntro,1);
				return;
			}
			if (branchChoice == "2")
			{
				clearOutput();
				outputText("(Placeholder) (Training Demand!) PC politely declines. Elly informs him that she is not asking and tells him to stay still so she can leash him.\n\n");
				outputText("How do you react?\n\n");
				outputText("\n\n");
				menu();
				addButton(0,"Let her",prisonCaptorPetTrainingDemand,3);
				addButton(1,"Resist",prisonCaptorPetTrainingDemand,4);
				return;
			}
			if (branchChoice == "3")
			{
				clearOutput();
				outputText("(Placeholder) (Training Demand!) Transitions into a shy version of \"Submit\" scene.\n\n");
				prisonCaptorPetTierUpdate(true);
				prisonCaptorPetScoreChange(7);
				corChange = -0.25;
				dynStats("cor", corChange);
				menu();
				addButton(0,"Continue...",prisonCaptorPetTrainingAcceptedIntro,2);
				return;
			}
			if (branchChoice == "4")
			{
				clearOutput();
				outputText("(Placeholder) (Training Demand!) PC backs away. Elly forcefully warns him that he is going to learn his lessons and his only choice is whether he wants it to be hard or easy.\n\n");
				outputText("How do you react?\n\n");
				outputText("\n\n");
				menu();
				addButton(0,"Easy...",prisonCaptorPetTrainingDemand,5);
				addButton(1,"Never!",prisonCaptorPetTrainingCrateIntro);
				return;
			}
			if (branchChoice == "5")
			{
				clearOutput();
				outputText("(Placeholder) (Training Demand!) Transitions into a shy version of \"Submit\" with additional text of Elly apologizing for having to be so forceful but being proud of him for recognizing his place.\n\n");
				prisonCaptorPetTierUpdate(true);
				prisonCaptorPetScoreChange(5);
				corChange = -0.25;
				dynStats("cor", corChange);
				menu();
				addButton(0,"Continue...",prisonCaptorPetTrainingAcceptedIntro,2);
				return;
			}
			doNext(playerMenu);
		}
		
		public function prisonCaptorPetTrainingCrateIntro(branchChoice:String = "choose"):void
		{
			var currentTier:* = undefined;
			currentTier = prisonCaptorPetTier();
			var currentEvent:* = prisonCaptorPetEvent();
			var petScore:* = prisonCaptorPetScore();
			var previousDreamValue:* = prisonCaptorPetScratch();
			clearOutput();
			if (branchChoice == "choose")
			{
				player.changeStatusValue(StatusEffects.PrisonCaptorEllyStatus,4,0);
				prison.changeEsteem(20, prison.inPrison);
			}
			else
			{
				player.changeStatusValue(StatusEffects.PrisonCaptorEllyStatus,4,1);
			}
			outputText("(Placeholder) (Training Crate Intro) PC opts-out -- oops too late. Elly laments that she needs to begin with such a harsh lesson, but tells the PC [he] needs to learn to behave if they're ever going to get anywhere.\n\n");
			outputText("(Placeholder) (Training Crate Intro) Mistress Elly snaps her fingers, and within moments the door opens and two imps enter the room hauling a sizeable rectangular cage between them -- apparently she was well prepared for your resistance. Once the imps have set it up in the corner of your cell and departed, she hauls you roughly by your collar towards the open door on the cage's broad side. It appears as though it was designed to house a large dog, being roughly twice as long as it is wide and tall, and as she ushers you inside with a stern spank on your [ass] you find that there is only barely enough room for you to turn about, and space enough for you to rise to your hands and knees, but no higher. Thankfully the cage is furnished with a large, soft pad, allowing you to rest comfortably within. It is also equipped with a water dish and a food bowl, although the latter is notably empty.\n\n");
			outputText("(Placeholder) (Training Crate Intro) Once you are locked inside, Mistress Elly explains that you will remain inside your crate until you are willing to accept what you are and show your submission by putting on your leash, picking it up in your mouth, and begging for your Mistress to train you as she <i>so kindly</i> offered to do before you rudely refused her help.\n\n");
			if (currentTier == 2)
			{
				prisonCaptorPetTierUpdate(true);
			}
			player.changeStatusValue(StatusEffects.PrisonCaptorEllyStatus,3,0);
			if (player.hasKeyItem("Training Crate - Installed In Prison Cell") < 0)
			{
				player.createKeyItem("Training Crate - Installed In Prison Cell",0,0,0,0);
			}
			player.changeStatusValue(StatusEffects.PrisonRestraints,1,2);
			player.changeStatusValue(StatusEffects.PrisonRestraints,2,0);
			player.changeStatusValue(StatusEffects.PrisonRestraints,3,0);
			player.changeStatusValue(StatusEffects.PrisonRestraints,4,0);
			flags[kFLAGS.PRISON_PUNISHMENT] = 4;
			doNext(playerMenu);
		}
		
		public function prisonCaptorPetTrainingCrateBehave(branchChoice:String = "choose"):void
		{
			var behaviorCounter:int = 0;
			behaviorCounter = player.statusEffectv3(StatusEffects.PrisonCaptorEllyStatus) + 1;
			if (player.fatigue > player.maxFatigue() - 20)
			{
				outputText("(Placeholder) (Training Crate Behave) You pass an hour trying to behave but are too cramped and fatigued to get comfortable, and end up wallowing and whining instead.\n\n");
				player.damageHunger(5);
			}
			else if (player.hunger < 20)
			{
				outputText("(Placeholder) (Training Crate Behave) You pass an hour trying to behave but are too hungry to settle down, and end up wallowing and whining instead.\n\n");
				player.changeFatigue(7);
			}
			else if (player.lust > 90)
			{
				outputText("(Placeholder) (Training Crate Behave) You pass an hour trying to behave but are too horny to settle down, and end up wallowing and whining instead.\n\n");
				player.changeFatigue(7);
			}
			else
			{
				outputText("(Placeholder) (Training Crate Behave) You pass an hour on your best behavior, sitting quietly on your bed and occasionally lapping water from your bowl.\n\n");
				prison.changeEsteem(-1);
				behaviorCounter++;
			}
			
			
			player.changeFatigue(7);
			outputText("(Placeholder) new behavior value is " + behaviorCounter + "\n\n");
			player.changeStatusValue(StatusEffects.PrisonCaptorEllyStatus,3,behaviorCounter);
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function prisonCaptorPetTrainingCrateMisbehave(branchChoice:String = "choose"):void
		{
			var behaviorCounter:* = undefined;
			outputText("(Placeholder) (Training Crate Misbehave) Tired, hungry, horny and upset, you thrash about in your cage alternating between screaming angrily and crying for help.\n\n");
			if (player.will < 10)
			{
				outputText("(Placeholder) (Training Crate Misbehave) Being low on willpower, your tantrum is especially pathetic.");
				player.changeFatigue(20);
				prison.changeEsteem(1);
			}
			else
			{
				player.changeFatigue(15);
				prison.changeEsteem(2);
			}
			prison.changeWill(-10);
			behaviorCounter = player.statusEffectv3(StatusEffects.PrisonCaptorEllyStatus) - 2;
			outputText("(Placeholder) new behavior value is " + behaviorCounter + "\n\n");
			player.changeStatusValue(StatusEffects.PrisonCaptorEllyStatus,3,behaviorCounter);
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function prisonCaptorPetTrainingCrateMasturbate(branchChoice:String = "choose"):void
		{
			var behaviorCounter:int = undefined;
			outputText("(Placeholder) (Training Crate Masturbate) Overwhelmed with desire, you sheepishly masturbate, staining your bedding with your fluids.\n\n");
			player.orgasm();
			behaviorCounter = player.statusEffectv3(StatusEffects.PrisonCaptorEllyStatus) - 2;
			outputText("(Placeholder) new behavior value is " + behaviorCounter + "\n\n");
			player.changeStatusValue(StatusEffects.PrisonCaptorEllyStatus,3,behaviorCounter);
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function prisonCaptorPetTrainingCrateCallOut(branchChoice:String = "choose"):void
		{
			var corChange:* = undefined;
			var lustChange:* = undefined;
			var behaviorCounter:* = undefined;
			corChange = 0;
			lustChange = 0;
			behaviorCounter = player.statusEffectv3(StatusEffects.PrisonCaptorEllyStatus);
			if (branchChoice == "choose")
			{
				outputText("(Placeholder) (Training Crate Callout) Politely as you can, you call out for  Mistress Elly. She comes to see you, makes some comments about your current state of esteem, lust, hunger, and fatigue, as well as your recent behavior. She then asks \"<i>What's wrong [boy]?</i>\"\n\n");
				outputText("How do you respond?\n\n");
				outputText("\n\n");
				outputText("\n\n");
				outputText("\n\n");
				menu();
				if (player.lust < 100)
				{
					addButton(0,"Food",prisonCaptorPetTrainingCrateCallOut,1);
					addButton(1,"Release",prisonCaptorPetTrainingCrateCallOut,2);
				}
				if (player.lust >= 70)
				{
					addButton(2,"\"Release\"",prisonCaptorPetTrainingCrateCallOut,5);
				}
				if (player.esteem < 3)
				{
					addButton(3,"Submit",prisonCaptorPetTrainingCrateLeash,0);
				}
				if (player.lust < 100)
				{
					addButton(4,"Nothing",prisonCaptorPetTrainingCrateCallOut,6);
				}
				return;
			}
			if (branchChoice == "1")
			{
				clearOutput();
				outputText("(Placeholder) (Training Crate Callout) You indicate that you are hungry. Depending on your recent behavior and your hunger level, she might feed you.\n\n");
				if (player.hunger > 60)
				{
					outputText("(Placeholder) (Training Crate Callout) She chides you for begging for food when you aren't really hungry.\n\n");
				}
				else if (player.hunger > 40 && behaviorCounter < 0)
				{
					outputText("(Placeholder) (Training Crate Callout) She says that perhaps a little hunger will inspire you to behave better.\n\n");
				}
				else
				{
					outputText("(Placeholder) (Training Crate Callout) She feeds you, but probably with variations based on recent behavior.\n\n");
					behaviorCounter = player.statusEffectv3(StatusEffects.PrisonCaptorEllyStatus) + 1;
					outputText("(Placeholder) new behavior value is " + behaviorCounter + "\n\n");
					player.changeStatusValue(StatusEffects.PrisonCaptorEllyStatus,3,behaviorCounter);
					prison.changeEsteem(-1, prison.inPrison);
					player.refillHunger(50);
				}
				
				corChange = -0.25;
				dynStats("cor", corChange);
			}
			else
			{
				if (branchChoice == "2")
				{
					clearOutput();
					outputText("(Placeholder) (Training Crate Callout) You indicate that you are are restless, and need to move around. She will offer you a chance to walk around the room, but only if you allow her to leash you.\n\n");
					outputText("How do you respond?\n\n");
					outputText("\n\n");
					menu();
					addButton(0,"Accept",prisonCaptorPetTrainingCrateCallOut,3);
					if (player.fatigue < player.maxFatigue() - 20)
					{
						addButton(1,"Nevermind",prisonCaptorPetTrainingCrateCallOut,4);
					}
					return;
				}
				if (branchChoice == "3")
				{
					clearOutput();
					outputText("(Placeholder) (Training Crate Callout) You allow her to leash you, and she walks you around your cell so that you can stretch and work the cramps out of your muscles.\n\n");
					prison.changeEsteem(-2, prison.inPrison);
					player.changeFatigue(-50);
					behaviorCounter = player.statusEffectv3(StatusEffects.PrisonCaptorEllyStatus) + 2;
					outputText("(Placeholder) new behavior value is " + behaviorCounter + "\n\n");
					player.changeStatusValue(StatusEffects.PrisonCaptorEllyStatus,3,behaviorCounter);
					corChange = -0.25;
					dynStats("cor", corChange);
				}
				else if (branchChoice == "4")
				{
					clearOutput();
					outputText("(Placeholder) (Training Crate Callout) You decline her offer. She chastises you, and leaves you to continue to stew in your cage. \n\n");
					prison.changeEsteem(1, prison.inPrison);
					behaviorCounter = player.statusEffectv3(StatusEffects.PrisonCaptorEllyStatus) - 1;
					outputText("(Placeholder) new behavior value is " + behaviorCounter + "\n\n");
					player.changeStatusValue(StatusEffects.PrisonCaptorEllyStatus,3,behaviorCounter);
					corChange = -0.25;
					dynStats("cor", corChange);
				}
				else if (branchChoice == "5")
				{
					clearOutput();
					outputText("(Placeholder) (Training Crate Callout) You indicate that you are horny, and don't want to make a mess of your bed.'.\n\n");
					if (behaviorCounter < 0)
					{
						outputText("(Placeholder) (Training Crate Callout) You haven't behaved well enough to be able to leave your cage, so she instructs you to get on your hands and knees, put your food/water bowl below you, and then she gets you off with her tail, with most of the mess getting in your bowls instead of on your bedding.\n\n");
					}
					else
					{
						outputText("(Placeholder) (Training Crate Callout) She allows you to exit your cage and masturbate at her feet.\n\n");
					}
					prison.changeEsteem(-1, prison.inPrison);
					behaviorCounter = player.statusEffectv3(StatusEffects.PrisonCaptorEllyStatus) + 1;
					outputText("(Placeholder) new behavior value is " + behaviorCounter + "\n\n");
					player.changeStatusValue(StatusEffects.PrisonCaptorEllyStatus,3,behaviorCounter);
					player.orgasm();
					corChange = -0.25;
					dynStats("cor", corChange);
				}
				else if (branchChoice == "6")
				{
					clearOutput();
					outputText("(Placeholder) (Training Crate Callout) You sheepishly say you don't need anything.\n\n");
					if (behaviorCounter < 0)
					{
						outputText("(Placeholder) (Training Crate Callout) Bad dog! Bad!.\n\n");
					}
					else
					{
						outputText("(Placeholder) (Training Crate Callout) Aww, you just wanted to see me that badly, eh? Still, a good dog doesn't bother [his] owner.\n\n");
					}
					behaviorCounter = player.statusEffectv3(StatusEffects.PrisonCaptorEllyStatus) - 1;
					outputText("(Placeholder) new behavior value is " + behaviorCounter + "\n\n");
					player.changeStatusValue(StatusEffects.PrisonCaptorEllyStatus,3,behaviorCounter);
				}
				
				
				
			}
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function prisonCaptorPetTrainingCrateLeash(branchChoice:String = "choose"):void
		{
			var corChange:Number = 0;
			var behaviorCounter:int = 0;
			var trainingSource:int = 0;
			var entryPath:Number = 0;
			behaviorCounter = player.statusEffectv3(StatusEffects.PrisonCaptorEllyStatus);
			trainingSource = player.statusEffectv4(StatusEffects.PrisonCaptorEllyStatus);
			entryPath = prisonCaptorPetScratch();
			if (!(entryPath == 1) && !(entryPath == 2))
			{
				entryPath = 1;
			}
			if (branchChoice == "choose")
			{
				prisonCaptorPetScratchSet(1);
				outputText("(Placeholder) (Training Crate Leash) You examine the leash that Mistress Elly has left for you.\n\n");
				outputText("You consider what to do with the leash");
				if (player.esteem > 15)
				{
					outputText(" but you find you still have too much dignity to anything but put it back down");
				}
				outputText(".\n\n");
				outputText("\n\n");
				menu();
				if (player.esteem < 15)
				{
					addButton(0,"Fasten",prisonCaptorPetTrainingCrateLeash,1);
				}
				addButton(1,"Put Down",prisonCaptorPetTrainingCrateLeash,2);
				return;
			}
			if (branchChoice == "0")
			{
				clearOutput();
				prisonCaptorPetScratchSet(2);
				outputText("(Placeholder) (Training Crate Leash) Mistress Elly points at your leash.\n\n");
				outputText("\n\n");
				menu();
				addButton(0,"Fasten",prisonCaptorPetTrainingCrateLeash,1);
				return;
			}
			if (branchChoice == "1")
			{
				clearOutput();
				outputText("(Placeholder) (Training Crate Leash) You attach the leash to the ring on the back of your collar.\n\n");
				if (entryPath == 2)
				{
					outputText("(Placeholder) (Training Crate Leash) Mistress Elly watches with approval.\n\n");
				}
				outputText("What do you do next?\n\n");
				outputText("\n\n");
				prison.changeEsteem(-0.25, prison.inPrison);
				corChange = -0.25;
				dynStats("cor", corChange);
				menu();
				addButton(0,"Bite Leash",prisonCaptorPetTrainingCrateLeash,3);
				return;
			}
			if (branchChoice == "2")
			{
				clearOutput();
				outputText("(Placeholder) (Training Crate Leash) You can't bring yourself to go any farther at the moment. Perhaps if you focus on behaving like a good dog, you might be able to get your ego in check enough to ask her to train you.\n\n");
				prison.changeEsteem(0.5, prison.inPrison);
				behaviorCounter = player.statusEffectv3(StatusEffects.PrisonCaptorEllyStatus) - 1;
				player.changeStatusValue(StatusEffects.PrisonCaptorEllyStatus,3,behaviorCounter);
			}
			else
			{
				if (branchChoice == "3")
				{
					clearOutput();
					outputText("(Placeholder) (Training Crate Leash) You pick the leash up with your mouth.\n\n");
					outputText("What do you do next?\n\n");
					outputText("\n\n");
					prison.changeEsteem(-0.25, prison.inPrison);
					corChange = -0.25;
					dynStats("cor", corChange);
					menu();
					if (entryPath == 2)
					{
						addButton(0,"Beg",prisonCaptorPetTrainingCrateLeash,6);
					}
					else
					{
						if (player.esteem < 5)
						{
							addButton(0,"Call Out",prisonCaptorPetTrainingCrateLeash,4);
							addButton(1,"Wait Patiently",prisonCaptorPetTrainingCrateLeash,5);
						}
						if (player.esteem > 2)
						{
							addButton(2,"Nevermind",prisonCaptorPetTrainingCrateLeash,2);
						}
					}
					return;
				}
				if (branchChoice == "4" || branchChoice == "5")
				{
					clearOutput();
					if (branchChoice == "4")
					{
						outputText("(Placeholder) (Training Crate Leash) You bark around the leather strap in your mouth, and Mistress Elly appears. She is quite pleased to see you wearing your leash and prepared to give it to her.\n\n");
						prisonCaptorPetScoreChange(1);
					}
					else
					{
						outputText("(Placeholder) (Training Crate Leash) You decide to wait patiently, and Mistress Elly appears. She is quite pleased to see you wearing your leash and prepared to give it to her, and even more pleased that you waited deferentially until she was ready to see you.\n\n");
						prisonCaptorPetScoreChange(3);
					}
					outputText("(Placeholder) (Training Crate Leash) She lets you out of your cage and looks at you expectantly.\n\n");
					outputText("What do you do next?\n\n");
					outputText("\n\n");
					corChange = -0.25;
					dynStats("cor", corChange);
					menu();
					addButton(0,"Beg",prisonCaptorPetTrainingCrateLeash,6);
					return;
				}
				if (branchChoice == "6")
				{
					clearOutput();
					if (entryPath == 2)
					{
						outputText("(Placeholder) (Training Crate Leash) Transition directly from bite leash for players who submit.\n\n");
					}
					outputText("(Placeholder) (Training Crate Leash) You make an appealing show of begging like a dog, and she congratulates you for being such a good [boy] in accepting what you are...\n\n");
					prisonCaptorPetScoreChange(3);
					prison.changeEsteem(-5, prison.inPrison);
					corChange = -2;
					dynStats("cor", corChange);
					prisonCaptorPetScratchSet(0);
					prison.prisonCaptor.updateNextWaitRandomEvent(model.time.hours, model.time.days);
					prison.prisonCaptor.updateNextRoomRandomEvent(model.time.hours, model.time.days);
					player.changeStatusValue(StatusEffects.PrisonRestraints,1,2);
					player.changeStatusValue(StatusEffects.PrisonRestraints,2,0);
					player.changeStatusValue(StatusEffects.PrisonRestraints,3,0);
					player.changeStatusValue(StatusEffects.PrisonRestraints,4,0);
					flags[kFLAGS.PRISON_PUNISHMENT] = 0;
					flags[kFLAGS.PRISON_TRAINING_REFUSED] = 1;
					menu();
					if (trainingSource == 0)
					{
						addButton(0, "Continue...", prisonCaptorPetTrainingAcceptedIntro, 3);
					}
					else
					{
						addButton(0, "Continue...", camp.returnToCampUseOneHour);
					}
					return;
				}
			}
			prisonCaptorPetScratchSet(0);
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function prisonCaptorPetTrainingAcceptedIntro(branchChoice:String = "choose"):void
		{
			clearOutput();
			outputText("(Placeholder) (Training Accepted Intro) Now that you've agreed to be trained as a dog, Elly explains what this means and what is expected of you.\n\n");
			switch(branchChoice)
			{
				case 0:
					outputText("Eager variation\n\n");
					break;
				case 1:
					outputText("Reluctant variation\n\n");
					break;
				case 2:
					outputText("Very reluctant variation\n\n");
					break;
				case 3:
					outputText("Crate broken variation\n\n");
					break;
			}
			flags[kFLAGS.PRISON_TRAIN_PUPPY_TRICKS_UNLOCKED] = 1;
			doNext(playerMenu);
		}
		
		public function prisonCaptorPetCrateDescribe():void
		{
			outputText("\n\nYour training crate sits in the corner of the room, complete with comfortable bedding, your water dish, and your food bowl.");
		}
		
		public function prisonCaptorPetCrateRest():void
		{
			menu();
			if (model.time.hours < 6 || model.time.hours > 20)
			{
				outputText("You crawl into your training crate, curl up on your bedding, and go to sleep for the night.");
				addButton(0, "Sleep", camp.doSleep);
			}
			else
			{
				outputText("You crawl into your training crate, curl up on your bedding, and rest for a while.");
				addButton(0, "Rest", camp.rest);
			}
			prisonCaptorPetScoreChange(0.25);
		}
		
		public function prisonCaptorPetDreamFailure(branchChoice:String = "choose"):void
		{
			outputText("(Placeholder) (Dream Failure) Replace with actual code when it's complete!");
			doNext(playerMenu);
		}
		
		public function prisonCaptorFeedingBJTrainingPerformPuppyFinale(branchChoice:String) : void
		{
			var lustChange:int = 75;
			var shortName:ItemType = null;
			prisonCaptorPetTierUpdate();
			if (branchChoice == "complain")
			{
				outputText("\"<i>B-but...</i>\" you whisper almost silently, mouth still hanging open. As she doesn't even seem to notice, you can't help but release a mournful whimper, too overcome with shame and arousal to muster much else.\n\n");
				outputText("At that, the light clicking of her departure ceases, and you see her turn. Her expression is difficult to make out through your misty eyes, but another light chuckle betrays an amused curiosity. \"<i>Why, whatever's the matter, dear?</i>\" As you timidly lower your eyes to the bowl of soup before you, she gives a short, sympathetic breath of understanding.\n\n");
				outputText("\"<i>Oh, you didn't want it in a bowl? But...however would you manage a loaf when all you seem to know how to use is that cute little tongue?</i>\" She sounds genuinely considerate, but the words still sting. You bite your lip to avoid crying any more and look even deeper at the floor as she continues: \"<i>Could you even hold it with those, ah, 'hands' of yours?</i>\"\n\n");
				outputText("Your eyes can't help but flicker to your arms at her implication, where you find that even now your fingers remain half-curled into a semblance of paws. Starting to tremble with insecurity over her utterly debasing analysis, you try to blink the tears from your eyes and look back to her with a hopeless, pleading expression -- your heartbreak even more obvious than perhaps you wanted. She merely absorbs your gaze for a time, maintaining the cool, considerate countenance that doubtless carried her incisive rationale. It slowly warms, though, into sympathy, and then pity.\n\n");
				outputText("\"<i>Well...</i>\" she muses in a solemn, pondering tone, before her eyes roll dramatically and she blows a bang from her face with a sarcastic huff of feigned resignation. \"<i>I suppose I <b>did</b> promise you a treat.</i>\" Out of thin air she produces...\n\n");
				outputText("<i>...oh...</i>\n\n");
				outputText("A mischievous grin spreads across Mistress Elly's face as she reveals a modest chunk of bread. It's nothing special, but it looks a little better than the pitiful slabs you're used to. \"<i>Is...<b>this</b>...is what you wanted?</i>\" she asks, plucking off a piece and gently slipping it between her lips. A modest grunt of delight escapes a moment later. Fixed on the soft, fluffy inside that her tease revealed, you merely bob your head in answer, your eyes widening with excitement. \"<i>Well then,</i>\" she concludes, turning the prize in her hands to give you a better view, \"<i>if you want it so much...</i>\"\n\n");
				outputText("\"<i>Show me.</i>\" She abruptly draws her arms behind her back, hiding your treat from view. You look at her blankly for a moment, unsure of how to respond; your enthusiasm certainly <i>felt</i> well showcased... but after you take no further action she fixes you with a firm but gentle expression.\n\n");
				outputText("\"<i>Come, now... if you really want your treat, be a good [boy] and ask for it properly. You remember how to be a good [boy], don't you?</i>\" She tilts her head and raises an eyebrow expectantly.\n\n");
				outputText("Your throat knots and your heart skips a beat as you realize what she wants from you. You <i>did</i> do it once already... but that was different, and the tranquility you felt playing for her before is a faint memory beside the heat in your loins and the spunk coating your upper torso. Still, you <i>earned</i> that chunk of bread and it hurts to let it go. As you begin to tremble again, your Mistress crosses her arms and awaits your answer.\n\n");
				outputText("You could give in and play her dog again. It should earn you your real meal, but might also give Mistress Elly the impression that you enjoy this treatment.\n\n");
				outputText("On the other hand, you still have your bowl of soup to keep you fed, and merely seeing her other offer has sated your hunger a little. It's tough to let your reward go, but even you know that what she's asking just isn't fair for a bit of plain bread.\n\n");
				outputText("And if you do refuse her, you could proclaim your resolve to <b>never allow yourself to be treated this way</b> to discourage her from trying to put you in such a position in the future.\n\n");
				outputText("\n\n");
				prison.changeEsteem(1, prison.inPrison);
				menu();
				addButton(0, "Beg...", prisonCaptorFeedingBJTrainingPerformPuppyFinale, "beg");
				addButton(1, "Nevermind...", prisonCaptorFeedingBJTrainingPerformPuppyFinale, "nevermind");
				addButton(2, "Never again", prisonCaptorFeedingBJTrainingPerformPuppyFinale, "optout");
				return;
			}
			if (branchChoice == "letgo")
			{
				outputText("You decide there's not much point trying to convince her and watch your [if (obey < 20) captor\"][if (obey >= 20) \"Mistress\"] depart. As you look down at your reward, you can't help but admit that your performance <i>was</i> asking for this a little -- and even though her suggestion was a tease, the thought of lapping up your meal on all fours makes your heart flutter for a moment.\n\n");
				outputText("You figure that if you want to avoid being treated like an animal, you should probably avoid acting like one.\n\n");
				shortName = consumables.C_BREAD;
			}
			else if (branchChoice == "beg")
			{
				outputText("You give your Mistress a faint nod. She responds with a delighted smile, giving another encouraging show of your treat, and you close your eyes. You begin a deep breath in an attempt to compose yourself, but your lungs stagger under the battering sensations of the heat in your loins, the hole in your heart, and the chill creeping down your torso in slow, viscous rivulets. As you give up -- swallowing the rest of your breath in an apprehensive gulp -- you lower your head, let your vision seep back, and look upon your half-curled hands...\n\n");
				outputText("…with no idea how you managed to do this in a single movement before. Not only do you find your limbs numb with embarrassment at the thought of it, but the practical considerations alone are disorienting. You <i>did</i> do it once, though...\n\n");
				outputText("Deciding to take it in pieces, you begin with your paws, hesitantly raising your left off the floor and holding it before your eyes like some sort of foreign object. You repeat the motion with your right, and then look painfully between them as you try to arrange them in front of your face at some approximation of equal height, depth, and distance. Now and then you flick your eyes to your Mistress in a meek attempt to measure her expression, and each time her lips widen for a moment in approval.\n\n");
				outputText("Finally satisfied with the placement of your paws, you lean back and begin shifting your legs. They're almost asleep from how long you've been sitting on them, but after some ineffectual squirming they begin to wake and you shudder with dread as a tingling sensation begins creeping through you. You don't think you'll be able to do this with <i>another</i> distraction.\n\n");
				outputText("In a rush of panic, you decide to end this and get your treat before your body can betray you any further. Rising up on your haunches a little, you confirm the position of your paws and fix Mistress Elly with a submissive, doe-eyed expression.\n\n");
				outputText("\"<i>That's all?</i>\" she says plainly, her lips curling into a curious smirk. You feel your eyes welling at her plain disappointment as she walks over to you, her expression fading into thoughtful concern. \"<i>What's wrong, [boy]?</i>\" she asks, searching your misty gaze as though there was nothing behind it. \"<i>You did it so well before...</i>\"\n\n");
				outputText("You shut your eyes and sink into your shoulders, cowering away from her appraisal as you try to determine what you did wrong. Were your hands off balance? Was your head too low? Did you forget to straighten your back? Your legs still feel far away -- had they not actually moved?\n\n");
				outputText("\"<i>Stop,</i>\" a voice whispers sharply in your ear. It's not harsh, but it gets your attention.\n");
				outputText("\"<i>Open your eyes and look at me.</i>\" You do as you're told, shyly lifting your head just enough to meet the violet orbs lying in wait. They glow with what seems like genuine sympathy.\n");
				outputText("\"<i>You're thinking too much,</i>\" she whispers playfully, as if letting you in on some clever secret.\n");
				outputText("\"<i>Or at least...</i>\" she adds, breaking your gaze as she leans to the side, \"<i>...thinking about the wrong things.</i>\" You feel a smooth digit on your left, downturned palm.\n\n");
				outputText("\"<i>Raise your paw,</i>\" she orders gently, pressing just enough to make it clear which she's referring to. You glance over to determine how much, but find your eyes drifting the other way as golden-brown blur passes in front of them. \"<i>Wouldn't you rather focus on this right now..?</i>\"\n\n");
				outputText("Your mouth drops open and you forget all about your hand as she holds the crisp, smooth chunk of bread only inches from your face. It was palatable from afar, but up close... and the smell... your nostrils twitch as you slowly inhale, teary eyes glazing over as you imagine how it must <i>taste</i>. \"<i>Or...ah, <b>this</b>?</i>\"\n\n");
				outputText("Your heart skips and your body jumps as a velvet spade ");
				if (player.hasCock())
				{
					outputText("briefly flicks across the length of your cock, bringing it back to full attention and");
				}
				else if (player.hasVagina())
				{
					outputText("gives a fierce but playful flick at your [clit]");
				}
				else
				{
					outputText("prods playfully at your [asshole]");
				}
				
				outputText(" inducing another deluge of need. You feel your hips buck at the air, raising your stance a little farther as they chase her departing tail. You begin sobbing in earnest, then, a stream of tears washing a path down your sticky face. You tell yourself you've done your best, but you know you're just not strong enough to endure being teased and humiliated and denied like  Desperate to fulfill at least <i>one</i> of your cravings, you lean forward and bite at your prize with a needy whine.\n\n");
				outputText("\"<i>Uh-uh,</i>\" Mistress Elly chides, retracting her hand as your mouth, too, catches only air and you let your gaze drop to the floor with a sniffle. \"<i>Don't pout, [boy],</i>\" she comforts with feigned admonishment. \"<i>You're already doing <b>much</b> better.</i>\" Curious of her unexpected compliment in spite of your embarrassment, you can't help but look up as you feel another tap on your palm and find her gently holding your left hand. You feel as though your center of gravity has shifted, and realize with a quiet, unbidden gasp that while distracting you with her teasing she actually improved your posture tremendously.\n\n");
				outputText("You know you should probably be angry about how she's treating you, but can't help feeling something closer to guilt as you dwell on her sly assistance. As your eyes drift back to her, you find yourself offering an abashed, apologetic expression. She responds with no more than a knowing, absolving wink, but it lights a spark in your heart and you feel your guilt turn to gratitude.\n\n");
				outputText("\"<i>Now the rest,</i>\" she says, letting your hand go as her violet gaze darts over your kneeling form, \"<i>you need to do on your own. But I know you can do that, can't you [boy]?</i>\" she asks, her eyes meeting yours in invitation; while you're still not particularly confident, <i>she</i> seems to be, and you find yourself trusting in that as you answer her with a timid nod. \"<i>Well then,</i>\" she chimes, cupping her chin as she gently tilts her head in appraisal, \"<i>Right paw up.</i>\"\n\n");
				outputText("You blink, a little surprised by the flat tone of the order, but quickly eye your right hand and lift it to the level that she had placed your left. You look down your arm to make sure your elbows align, when her tail sharply whips your [ass]. \"<i>Back straight.</i>\" Your shoulders jolt back from the harmless but startling strike, and you hear the light tapping of boots as Mistress Elly begins circling you.\n\n");
				outputText("\"<i>Part your legs. Relax your wrists. <b>Just</b> your wrists -- left paw back up; that's it...</i>\" You can't help but feel pathetic, shifting your body to her whims like a marionette, and with each command you follow, buds of deep, warm blush speckle your face, then your torso, then even your limbs. But even if she's toying with you, you find yourself a little proud as her criticisms become smaller and she takes more time between them. As her commands become more esoteric, you even have some fun determining how to obey them with the most speed and elegance. You keep your eyes closed to concentrate, but as her voice becomes more affectionate and she even begins chuckling a little between the odd order, you nearly forget there's a demon only inches away and some of the buds on your torso begin to blossom.\n\n");
				outputText("\"<i>There now,</i>\" your Mistress coaxes, her voice coming from in from in front of you. \"<i>Feeling better, [boy]?</i>\" It's hard to deny that you do, a soft, soothing heat seeming to follow wherever your flush skin starts to flourish. You shiver with ticklish delight as the sensation mixes with the cool air of your cell and bite your lip to avoid giggling as a trail of her seed slips into your navel. At that, some of the flowers on your face begin to bloom.\n\n");
				outputText("\"<i>I thought so,</i>\" she says knowingly. \"<i>Alright, up off your haunches...</i>\" Despite the physical strain, you find your legs relaxing as warmth winds its way through them and they bask in the same glow quickly overtaking the rest of you. As you reach your peak, you take another long, staggered breath -- only this time shake by excitement.\n\n");
				outputText("\"<i>Chin up.</i>\" You obey, faintly smiling as you imagine your pleased owner right in front of you.\n");
				outputText("\"<i>Mouth open.</i>\" You obey, your ears perking up at the sound of a few soft clicks.\n");
				outputText("\"<i>Tongue out.</i>\" You obey, letting your chest fall in a relaxed breath.\n");
				outputText("\"<i>Good [boy].</i>\" What few flush buds remain on your skin unravel as your body fills with radiance and your eyes flutter open with an expression of warm, docile serenity.\n\n");
				outputText("You blink, feeling a soft weight hit the back of your tongue. Mistress Elly, now standing a few meters away, quickly raises something held between her thumb and forefinger before giving a playful wink and flicking her hand. A small object gently arcs through the air towards you, and when it begins curving to your left, you lean to the side and intercept it it your open mouth on sheer reflex.\n\n");
				outputText("\"<i>Oh~ <b>very</b> good [boy]!</i>\" she coos. You're glad she's excited; hopefully that means you'll <i>finally</i> get your treat. And sliding your tongue back as a delightful taste suggests what she just tossed you, you're not sure you'll be able to save it for very long. The flavor, while fairly plain, is still rich and filling, but the <i>texture</i>! Until your prospects turned to stale husks and seed soup, you never imagined how good a piece of soft, fluffy bread could feel.\n\n");
				outputText("\"<i>The tricks I could teach that mouth of yours...</i>\" she muses to herself, closing the distance again. You look up at her expectantly, unfazed by the comment, and she smiles back down with a glint in her eye. \"<i>But right now you've earned a treat, haven't you?</i>\" she asks, again revealing your well-baked reward. You nod fervently. While the humiliation of being made to beg like a dog still smolders somewhere in the back of your mind, it's difficult to notice behind the bright glow of pride at having performed the physical feat and anticipation of the prize it's won.\n\n");
				outputText("She plucks off a piece and holds it in front of you. Looking it over hungrily, you give her another nod, unsure of how else to close this \"deal.\" With a titter, she raises an eyebrow and looks at <i>you</i> expectantly. \"<i>You need to open your mouth, [boy],</i>\" she says instructively, as if you're merely being slow. You lose some of your luster as you realize her intentions, your brow furrowing into a recalcitrant pout. You know how precarious it is to resist her and really aren't trying to upset her, but she promised to feed you, not <i>feed</i> you.\n\n");
				outputText("Fortunately, Mistress Elly's smile merely widens, her features taking a skeptical slant. You're relieved at first, but your \"hard\" eyes begin to wilt as you realize how quaint your \"defiance\" must look in the midst of your overwhelmingly submissive posture. Suddenly feeling very shy, you find your eyes searching the room for anything that isn't violet.\n\n");
				outputText("\"<i>Didn't we go over this?</i>\" she asks, not even addressing your insignificant rebellion as her hand lowers the bite beneath the edge of your vision, \"<i>How are you going to eat it yourself without your little paws making a mess of things? You have to keep your room clean, remember?</i>\" You purse your lips in an indignant huff at that. You know she's being unfair; she could crumble it into a bowl for you like other bread, after all. \"<i>And honestly?</i>\" she adds in a sincere, almost pitying whisper, \"<i>if the state of your face is any indication, you'll be lucky to handle the soup.</i>\"\n\n");
				outputText("You wouldn't have thought you could flush any further, but the entire shade wreathing your body deepens at her implication. \"<i>Now say 'aaah~'</i>\" she orders again, but before you can contemplate obeying or refusing her, you feel a ");
				if (player.hasCock())
				{
					outputText("velvet loop around your cock");
				}
				else if (player.hasVagina())
				{
					outputText("velvet spade flick at the entrance to your [vagina]");
				}
				else
				{
					outputText("velvet spade tickle at your [asshole]");
				}
				
				outputText(" and a soft pressure against your belly-button; they pull upward in unison.\n\n");
				outputText(" \"<i>Aaaaah!</i>\" you moan with an undignified lilt, your jaw dropping as you shudder from the mix of sensations. The bite of your treat returns to your face, though now it appears coated like a proper pastry. \"<i>Aah!</i>\" you cry in refusal as you realize the nature of the frosting, but by then she's already pressed it hard to your tongue. \"<i>A-ah-uuh...uhh...</i>\"\n\n");
				outputText("Mistress Elly fixes you with a gaze of casual, almost indifferent triumph -- as if she's used to constantly proving you wrong about yourself. You feel <i>yourself</i> getting frightfully used to it, too, but seeing it mean so little to her very nearly breaks your luminous reverie. But before you have time to reflect, she slowly closes her own mouth, shifts her jaw around to imitate chewing, and slowly withdraws her fingers, teasing out a long strand of saliva before flicking it over your nose and lips. Your will to struggle with this heartbreaking charade any further finally and thoroughly devastated, you feel your quivering jaw repeat her motions, the cum-coated bread crumbling and soaking into your mouth, and then a knot in your throat.\n\n");
				outputText("It's delicious. Her seed did nothing to the dense, fluffy texture, but the <i>flavor</i>. What was once a simple, filling snack now tastes like an lush, cinnamon delicacy. It hurts to admit it, but as your throat relaxes you manage to swallow and the delectable sensation travels all the way down your gullet, you want <b>more</b>.\n\n");
				outputText("Your Mistress merely smirks at your dazed expression, rising and again stepping around to your side. As she does so, she plucks off another piece, swirls it affectionately on your cheek for a moment, then places it against your lips, which immediately open to accept her deposit. You feel your hair being ruffled as the click of her steps ceases directly behind you. A soft brush swipes under your drippy chin, then pulls up, tilting your head back to see your Mistress looking down at you with predatory delight.\n\n");
				outputText("\"<i>You know,</i>\" she says, holding another succulent morsel before your lips.\n");
				outputText("\"<i>I really did think you were only pretending.</i>\" You open your mouth to accept, your ravenous eyes imploring her with suppliant innocence.\n");
				outputText("\"<i>And well, maybe you <b>were</b>, in one way.</i>\" She does not lower the bread, and as you strain a little more to clutch it, she lifts it slightly farther.\n");
				outputText("\"<i>Maybe you still will, when we're done here.</i>\" You faintly realize you must have been slouching, because as you stretch upwards your legs give out. Whether it's due to the burning in your muscles or the burning in your loins, you see no option but to stick out your tongue and hope your owner indulges your begging.\n\n");
				outputText("\"<i>But now, at least... I see you're finally being honest with yourself.</i>\" With a wink to your effort, she lets the makeshift cinnamon bun fall into your mouth. And after a long, soft stroke snakes across your chest and under your jaw, you see her hold up what appears to be the remainder of your treat, now amply flavored.\n\n");
				outputText("\"<i>And I'm so, <b>so</b> proud of you!</i>\" She holds it to your mouth, and you voraciously devour the tasty block, then begin nibbling her palm and licking through her fingers for the crumbs.\n\n");
				outputText("\"<i>So proud, in fact, that my good [boy] gets <b>another</b> reward.</i>\" Her velvet tail stirs again and you shudder as the surge of need grants you a moment of lucidity. Startled and still reeling from what has transpired, your shyness overcomes your arousal and you fumble an awkward attempt to push away from her, but ultimately fall back into your compromised position and resume your fevered lapping -- desperately trying to clean her hand of both bread and frosting -- as your mind and body scramble to sort out exactly what it wants and what it needs.\n\n");
				outputText("\"<i>There, there...</i>\" she chimes, almost as an aside, as her free hand clutches your throat with surprising force. Her tail quickens and your limbs begin to writhe, and as you lose your balance she tugs you backward into a soft embrace. \"<i>You don't have to pretend any more...</i>\"\n\n");
				outputText("\"<i>Just let go and accept how much you want to be a docile...</i>\" Your tongue seizes up, finally ceasing to chase her fingers, your jaw begins to shake uncontrollably, and your entire body tenses as her velvet ministrations build to a frenzied pace.\n\n");
				outputText("\"<i>Obedient...</i>\" Every flush flowered across your body seems as though they're blossoming all over again, your skin feeling hot enough against the air and stone to steam.\n\n");
				outputText("\"<i>Pet.</i>\" Your eyes roll skyward and your hips buck against her tail as you climax, ");
				if (player.hasCock())
				{
					outputText("your own ample seed adding to the contents of the bowl in front of you.");
				}
				else if (player.hasVagina())
				{
					outputText("an explosion of fluid coating your thighs and seasoning the contents of the bowl in front of you.");
				}
				else
				{
					outputText("[asshole] spasming with need.");
				}
				
				outputText(" A long whine slips through your lips, an undulating harmonic of fear, shame, and relief, before your body finally overwhelms you and your dainty pose collapses. You immediately follow, plummeting forward, nearly landing your soup, before your owner tilts you to the side and gently sets your head down beside it instead.\n\n");
				outputText("\"<i>Or am I wrong?</i>\" she whispers in your ear, her voice quieter than the breath that carries it. You have no time to contemplate, your consciousness quickly fading as your ");
				if (player.tailType > 0)
				{
					outputText("tail");
				}
				else
				{
					outputText("leg");
				}
				outputText(" twitches in the wake of your pleasure.\n\n");
				outputText("You should come to in about an hour, having learned a profound lesson about the potential rewards -- and consequences -- of behaving too convincingly as an animal in Mistress Elly's presence.\n\n");
				prison.changeEsteem(-1, prison.inPrison);
				prison.changeWill(10);
				player.refillHunger(40);
				prisonCaptorPetScoreChange(2);
				player.orgasm();
				prisonCaptorPetTierUpdate();
				shortName = consumables.C_BREAD;
			}
			else if (branchChoice == "optout")
			{
				outputText("This is outrageous! You know you can't stop her from refusing you your meal, but your performance is <i>over</i> and you're not going to let yourself be treated this way <b>ever</b> again.\n\n");
				outputText("\"<i>I'm not your damn <b>DOG</b>!</i>\" you yell viciously, tears clouding your eyes as your body strains against your show of rebellion. A stone seems to settle in your stomach as you realize what you've done, and your enraged expression goes blank as you blink away the dampness to find that Mistress Elly isn't there anymore.\n\n");
				outputText("\"<i>No,</i>\" you hear a voice seethe behind you. \"<i>I suppose you're not.</i>\"\n\n");
				outputText("As you turn, your vision blurs again as a deafening impact fills your right ear. You feel your left cheek meet the floor, and next you know your head is pounding as a pressure on your shoulder rolls you onto your back. Your vision is still unfocused, but you can make out the who's standing above you well enough. Her arms are crossed admonishingly, but her expression appears somewhat... delighted?\n\n");
				outputText("\"<i>You're my <b>slave</b>,</i>\" she declares strangely quietly, her lips opening wide as she mouths the words. \"<i>So remember your manners.</i>\"\n\n");
				outputText("With a far away giggle, she steps away and you faintly hear your cell door close with a thud. Well, a knuckle-sandwich wasn't the meal you had in mind, but you do feel a bit less hungry and you think you still got your point across. Your hearing should return to normal within the hour.\n\n");
				prisonCaptorPetScoreSet(-1);
				player.refillHunger(15);
				prison.changeEsteem(3, prison.inPrison);
				shortName = consumables.C_BREAD;
			}
			else if (branchChoice == "nevermind")
			{
				outputText("You look away from her indecisively and finally lift your hands from the floor. When you unravel your paws and cross your arms in a meek show of reticence, she lets slip an affectionate laugh.\n\n");
				outputText("\"<i>You're a bit late to play shy, dear, but alright. Enjoy your bowl, okay?</i>\" She finishes with expected sincerity, and you can't help but glance back at her as she turns to depart. There's a violet glint as she gives you a parting wink, and you feel yourself blush as you look down at your reward.\n\n");
				outputText("It still stings to have been denied your prize, but maybe your performance <i>was</i> asking for this a little -- and even though her suggestion was a tease, the thought of lapping up your meal on all fours makes your heart flutter for a moment.\n\n");
				outputText("You figure that if you want to avoid being treated like an animal, you should probably avoid acting like one.\n\n");
				player.refillHunger(5);
				prison.changeEsteem(1, prison.inPrison);
				shortName = consumables.C_BREAD;
			}
			
			player.slimeFeed();
			player.refillHunger(5);
			dynStats("lus", lustChange);
			prison.changeEsteem(-5, prison.inPrison);
			prison.changeObey(2, prison.inPrison);
			flags[kFLAGS.PRISON_TRAINING_LEVEL]++;
			if (flags[kFLAGS.PRISON_TRAINING_LEVEL] > 4 && player.obey > 25 + rand(3))
			{
				player.changeStatusValue(StatusEffects.PrisonCaptorEllyStatus,1,3);
				flags[kFLAGS.PRISON_TRAINING_LEVEL] = 0;
			}
			inventory.takeItem(shortName, camp.returnToCampUseOneHour);
		}
		
	}

}