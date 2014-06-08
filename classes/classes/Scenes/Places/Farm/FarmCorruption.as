package classes.Scenes.Places.Farm
{
	import classes.GlobalFlags.kGAMECLASS;
	import classes.GlobalFlags.kFLAGS;
	import classes.Items.ConsumableLib;
	import classes.Items.Consumables.SimpleConsumable;
	import classes.ItemSlotClass;
	import classes.Scenes.Dungeons.DeepCave.EncapsulationPod;
	import classes.StatusAffects;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class FarmCorruption extends AbstractFarmContent
	{
		
		public function FarmCorruption() 
		{
			
		}
		
		protected function corruptFollowers():int
		{
			var count:int = 0;
			
			if (kGAMECLASS.jojoScene.campCorruptJojo()) count++;
			if (kGAMECLASS.amilyScene.amilyCorrupt()) count++;
			if (kGAMECLASS.izmaScene.izmaFollower()) count++;
			if (kGAMECLASS.sophieBimbo.bimboSophie()) count++;
			if (kGAMECLASS.vapula.vapulaSlave()) count++;
			if (kGAMECLASS.ceraphScene.ceraphIsFollower()) count++;
			if (kGAMECLASS.latexGirl.latexGooFollower()) count++;
			
			return count;
		}

		public function whitneyCorruption(mod:int = 0):int
		{
			if (mod != 0) flags[kFLAGS.WHITNEY_CORRUPTION] += mod;
			var corruptionFinished:int = flags[kFLAGS.WHITNEY_CORRUPTION_COMPLETE];

			if (flags[kFLAGS.WHITNEY_CORRUPTION] < 0) flags[kFLAGS.WHITNEY_CORRUPTION] = 0;
			if (flags[kFLAGS.WHITNEY_CORRUPTION] >= 120)
			{
				flags[kFLAGS.WHITNEY_CORRUPTION] = 120;
				flags[kFLAGS.WHITNEY_CORRUPTION_COMPLETE] = 1;
			}

			if (corruptionFinished == 0 && flags[kFLAGS.WHITNEY_CORRUPTION_COMPLETE] == 1)
			{
				flags[kFLAGS.FARM_CORRUPTION_FIRST_DATE] = kGAMECLASS.time.days;
			}

			return flags[kFLAGS.WHITNEY_CORRUPTION];
		}

		public function whitneyCorrupt():Boolean
		{
			if (flags[kFLAGS.WHITNEY_CORRUPTION_COMPLETE] > 0) return true;
			return false;
		}

		// Called once per day, check all the followers that have been set to the farm and change whitneys corruption as appropriate
		// Also going to use this to handle Gem value updates and shit.
		public function updateFarmCorruption():int
		{
			// Early exit if we've not actually started the corruption process
			if (flags[kFLAGS.FARM_CORRUPTION_STARTED] <= 0) return;
			
			// Figure out how much corruption we're going to slap on to Whitney
			var modValue:int = -1;

			if (flags[kFLAGS.FOLLOWER_AT_FARM_AMILY] == 1) modValue += 1;
			if (flags[kFLAGS.FOLLOWER_AT_FARM_JOJO] == 1) modValue += 1;
			if (flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 2) modValue += 0.5;
			if (flags[kFLAGS.FOLLOWER_AT_FARM_IZMA] == 2) modValue += 0.5;
			if (flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 2) modValue += 0.5;
			if (flags[kFLAGS.FOLLOWER_AT_FARM_VAPULA] == 1) modValue += 2;
			if (flags[kFLAGS.FOLLOWER_AT_FARM_LATEXY] == 1) modValue += 0.5;
			if (flags[kFLAGS.FOLLOWER_AT_FARM_HOLLI] > 0 && flags[kFLAGS.FOLLOWER_AT_FARM_HOLLI] <= 20)
			{
				flags[kFLAGS.FOLLOWER_AT_FARM_HOLLI]++;
				modValue += 2;
			}
			if (flags[kFLAGS.FOLLOWER_AT_FARM_KELLY] == 1) modValue += 1;

			whitneyCorruption(modValue);

			// Now figure out how many gems we're gonna get for the day
			flags[kFLAGS.FARM_CORRUPTION_GEMS_WAITING] += farmValue();

			// If Amily is producing, stack up some milks to gib
			if (flags[kFLAGS.FOLLOWER_AT_FARM_AMILY] == 1 && flags[kFLAGS.FOLLOWER_PRODUCTION_AMILY] == 1 && flags[kFLAGS.FARM_UPGRADES_REFINERY] == 1)
			{
				if (flags[kFLAGS.FOLLOWER_AT_FARM_AMILY_GIBS_MILK] == 0) flags[kFLAGS.FOLLOWER_AT_FARM_AMILY_GIBS_MILK] = 1;
				flags[kFLAGS.FARM_SUCCUMILK_STORED]++;
			}
			
			// If jojo is producing, stack up some drafts to gib
			if (flags[kFLAGS.FOLLOWER_AT_FARM_JOJO] == 1 && flags[kFLAGS.FOLLOWER_PRODUCTION_JOJO] == 1 && flags[kFLAGS.FARM_UPGRADES_REFINERY] == 1)
			{
				if (flags[kFLAGS.FOLLOWER_AT_FARM_JOJO_GIBS_DRAFT] == 0) flags[kFLAGS.FOLLOWER_AT_FARM_JOJO_GIBS_DRAFT] = 1;
				flags[kFLAGS.FARM_INCUDRAFT_STORED]++;
			}
			
			// If Sophie is producing, count up time since last egg and gib a new one when ready
			if (flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] > 0 && flags[kFLAGS.FOLLOWER_PRODUCTION_SOPHIE] == 1)
			{
				if (flags[kFLAGS.FARM_EGG_COUNTDOWN] == 0)
				{
					flags[kFLAGS.FARM_EGG_STORED] = 1;
				}
				else
				{
					flags[kFLAGS.FARM_EGG_COUNTDOWN]--;
				}
			}
			
			// If Vapula is producing, stack up some milks to gib
			if (flags[kFLAGS.FOLLOWER_AT_FARM_VAPULA] == 1 && flags[kFLAGS.FOLLOWER_PRODUCTION_VAPULA] == 1)
			{
				flags[kFLAGS.FARM_SUCCUMILK_STORED]++;
				if (flags[kFLAGS.FARM_UPGRADES_REFINERY] == 1) flags[kFLAGS.FARM_SUCCUMILK_STORED]++;
				
				if (flags[kFLAGS.FOLLOWER_AT_FARM_VAPULA_GIBS_MILK] == 0) flags[kFLAGS.FOLLOWER_AT_FARM_VAPULA_GIBS_MILK] == 1;
			}
			
			// If Latexy is at the farm, further modify her status values
			if (flags[kFLAGS.FOLLOWER_AT_FARM_LATEXY] == 1)
			{
				kGAMECLASS.latexGirl.gooHappiness( -0.5);
				kGAMECLASS.latexGirl.gooObedience(  0.5);
			}
			
			// If Ceraph is doing her thing
			if (flags[kFLAGS.FOLLOWER_AT_FARM_CERAPH] > 0)
			{
				flags[kFLAGS.FOLLOWER_AT_FARM_CERAPH]++;
				
				if (flags[kFLAGS.FOLLOWER_AT_FARM_CERAPH] > 7) flags[kFLAGS.FOLLOWER_AT_FARM_CERAPH] = -1;
			}
			
			// If Holli is doing her thing
			if (flags[kFLAGS.FOLLOWER_AT_FARM_HOLLI] > 0)
			{
				flags[kFLAGS.FOLLOWER_AT_FARM_HOLLI]++;
				
				if (flags[kFLAGS.FOLLOWER_AT_FARM_HOLLI] > 20) flags[kFLAGS.FOLLOWER_AT_FARM_HOLLI] = -1;
				
				modValue += 10;
				whitneyCorruption(2);
			}
			
			// Increment days since last paid out
			flags[kFLAGS.FARM_CORRUPTION_DAYS_SINCE_LAST_PAYOUT] += 1;
			
			return modValue;
		}
		
		public function collectTheGoodies():void
		{
			clearOutput();
			
			outputText("You can see the following items stashed around the place all haphazard like:");
			
			outputText("\n");
			
			// Get gems
			player.gems += flags[kFLAGS.FARM_CORRUPTION_GEMS_WAITING];
			flags[kFLAGS.FARM_CORRUPTION_GEMS_WAITING] = 0;
			
			if (flags[kFLAGS.FARM_SUCCUMILK_STORED] > 0) offerItems(kFLAGS.FARM_SUCCUMILK_STORED);
			if (flags[kFLAGS.FARM_INCUDRAFT_STORED] > 0) offerItems(kFLAGS.FARM_INCUDRAFT_STORED);
			if (flags[kFLAGS.FARM_EGG_STORED] > 0) offerItems(kFLAGS.FARM_EGG_STORED);
		}
		
		private function getItemObj(flag:int):SimpleConsumable
		{
			if (flag == kFLAGS.FARM_SUCCUMILK_STORED) return consumables.SUCMILK;
			if (flag == kFLAGS.FARM_INCUDRAFT_STORED) return consumables.INCUBID;
			if (flag == kFLAGS.FARM_EGG_STORED) return kGAMECLASS.sophieBimbo.eggTypes[kGAMECLASS.sophieBimbo.eggColors.indexOf(flags[kFLAGS.FOLLOWER_PRODUCTION_SOPHIE_COLOURCHOICE])];
		}
		
		private function offerItems(flag:int):void
		{
			outputText("\n");
			
			outputText("<b>");
			
			if (flags[flag] > 1) outputText(flags[flag] + "x ");
			outputText(getItemObj(flag).longName);
			
			outputText("</b>");
			outputText("\n");
		}
		
		private function takeItems(flag:int):void
		{
			var item:SimpleConsumable = getItemObj(flag);
			
			if (flag == kFLAGS.FARM_EGG_STORED)
			{
				flags[kFLAGS.FARM_EGG_COUNTDOWN] = 7;
			}
			
			inventory.takeItem(item);
			flags[flag]--;
			
			doNext(collectTheGoodies);
		}

		public function farmProtection():int
		{
			var protection:int = 0;

			if (flags[kFLAGS.FOLLOWER_AT_FARM_AMILY] == 1) protection += 1;

			if (flags[kFLAGS.FOLLOWER_AT_FARM_JOJO] == 1) protection += 2;

			if (flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 1)
			{
				protection += 2;
			}
			else if (flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 2)
			{
				protection += 1;
			}

			if (flags[kFLAGS.FOLLOWER_AT_FARM_IZMA] == 1)
			{
				protection += 4;
			}
			else if (flags[kFLAGS.FOLLOWER_AT_FARM_IZMA] == 2)
			{
				protection += 5;
			}

			if (flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 1)
			{
				protection += 3;
			}
			else if (flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 2)
			{
				protection += 2;
			}

			if (flags[kFLAGS.FOLLOWER_AT_FARM_VAPULA] == 1) protection += 2;

			// if (flags[kFLAGS.FOLLOWER_AT_FARM_LATEXY] == 1)

			if (flags[kFLAGS.FOLLOWER_AT_FARM_KELLY] == 1)
			{
				protection += 1;
			}
			else if (flags[kFLAGS.FOLLOWER_AT_FARM_KELLY] == 2)
			{
				protection += 2;
			}

			if (flags[kFLAGS.FOLLOWER_AT_FARM_MARBLE] == 1) protection += 2;

			if (flags[kFLAGS.FOLLOWER_AT_FARM_BATH_GIRL] == 1)
			{
				protection += 1;
			}
			
			if (flags[kFLAGS.FOLLOWER_AT_FARM_CERAPH] > 0) protection += 7;

			return protection;
		}

		public function farmValue():int
		{
			var fValue:int = 0;

			if (flags[kFLAGS.FOLLOWER_AT_FARM_AMILY] == 1) fValue += 3;
			if (flags[kFLAGS.FOLLOWER_AT_FARM_JOJO] == 1) fValue += 2;

			if (flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 1) fValue += 3
			else if (flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 2) fValue += 4;

			if (flags[kFLAGS.FOLLOWER_AT_FARM_IZMA] == 1) fValue += 1;

			if (flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 1) fValue += 3;
			else if (flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 2) fValue += 4;

			if (flags[kFLAGS.FOLLOWER_AT_FARM_VAPULA] == 1) fValue == 1;

			if (flags[kFLAGS.FOLLOWER_AT_FARM_LATEXY] == 1) fValue += 2;

			if (flags[kFLAGS.FOLLOWER_AT_FARM_KELLY] == 1) fValue += 1;

			if (flags[kFLAGS.FOLLOWER_AT_FARM_MARBLE] == 1) fValue == 2;

			if (flags[kFLAGS.FOLLOWER_AT_FARM_BATH_GIRL] == 1) fValue += 3;
			else if (flags[kFLAGS.FOLLOWER_AT_FARM_BATH_GIRL] == 2) fValue += 7;

			return fValue;
		}
		
		public function takeoverPrompt():Boolean
		{
			if (flags[kFLAGS.FARM_CORRUPTION_DISABLED] == 1) return false;
			if (flags[kFLAGS.FARM_CORRUPTION_STARTED] == 1) return false; // Hook the corrupt menu here
			
			if (player.cor >= 70 && corruptFollowers() >= 2 && player.level >= 12)
			{
				if (flags[kFLAGS.FARM_CORRUPT_PROMPT_DISPLAY] == 0)
				{	
					clearOutput();
					if (flags[kFLAGS.KELT_BREAK_LEVEL] >= 4)
					{
						takeoverPromptKelly();
					}
					else if (player.findStatusAffect(StatusAffects.MarbleRapeAttempted) >= 0)
					{
						takeoverPromptMarbleRape();
					}
					else
					{
						takeoverPromptGeneric();
					}
					
					takeoverPromptMerge(true);
					
					return true;
				}
				else if (flags[kFLAGS.FARM_CORRUPT_PROMPT_DISPLAY] == 2)
				{
					clearOutput();
					takeoverPromptMerge();
					return true;
				}
				else
				{
					flags[kFLAGS.FARM_CORRUPT_PROMPT_DISPLAY]++;
					return false;
				}
			}
			
			return false;
		}
		
		protected function takeoverPromptKelly():void
		{
			outputText("You stand at the top of a small rise overlooking the farm. From here you can just about pick out a beige-furred figure in the pepper field, hard at work. You shake your head almost in disbelief at the pastoral tableau. You remember when you found the farm when you were taking your first faltering steps in this land, with barely anything but the clothes you stood up in. You remember the relief you felt when you found this place, a pocket of peace in this disturbed land, how grateful you were to its owner to grub in the dirt with her and work for a pittance.");
			
			outputText("\n\nNow you feel nothing but contempt. How <b>dare</b> that bitch kick you off her land as if you were some common vagrant, simply because you took your rightful revenge on the centaur cunt she allowed to hang around and do as he pleased? Would she have stepped in if he had done to you what you have done to him? You think not, no, not Whitney, she’d have quite happily sat on the hill and read her book whilst her pet asshole raped the hell out of you.");
			
			outputText("\n\nOnce it affects her, well skies above, we can’t be doing with that can we? Does she have any idea how lucky she is? Who she is dealing with? How easy it would be to do to her as you have done to Kelt");
			if (kGAMECLASS.amilyScene.amilyCorrupt() || kGAMECLASS.jojoScene.campCorruptJojo())
			{
				outputText(" and the rodent slut");
				if (kGAMECLASS.amilyScene.amilyCorrupt() && kGAMECLASS.jojoScene.campCorruptJojo())
				{
					outputText("s");
				}
				outputText(" before him");
			}
			outputText("?");
		}
		
		protected function takeoverPromptMarbleRape():void
		{
			outputText("You stand at the top of a small rise overlooking the farm. From here you can just about pick out a beige-furred figure in the pepper field, hard at work. You shake your head almost in disbelief at the pastoral tableau. You remember when you found the farm when you were taking your first faltering steps in this land, with barely anything but the clothes you stood up in. You remember the relief you felt when you found this place, a pocket of peace in this disturbed land, how grateful you were to its owner to grub in the dirt with her and work for a pittance.");
			
			outputText("\n\nNow you feel nothing but contempt. How <b>dare</b> that bitch kick you off her land, as if you were some common vagrant, simply because you took what was rightfully yours from the cow bitch. Would Whitney have stepped in if Marble had done to you what you did to her? You think not, no, not Whitney, she’d have quite happily sat on the hill and read her book whilst the cow bitch did what she felt like to you, probably forcing her damn milk down your throat. But once it affects her, well skies above, we can’t be doing with that can we?");
			
			outputText("\n\nDoes she have any idea how lucky she is? Who she is dealing with? How easy it would be to break her will and make her your willing slave");
			if (kGAMECLASS.amilyScene.amilyCorrupt() || kGAMECLASS.jojoScene.campCorruptJojo())
			{
				outputText(" and the rodent slut");
				if (kGAMECLASS.amilyScene.amilyCorrupt() && kGAMECLASS.jojoScene.campCorruptJojo())
				{
					outputText("s");
				}
				outputText(" before her");
			}
			outputText("?");
		}
		
		protected function takeoverPromptGeneric():void
		{
			outputText("You stand at the top of a small rise overlooking the farm. From here you can just about pick out a beige-furred figure in the pepper field, hard at work. You shake your head almost in disbelief at the pastoral tableau. You remember when you found the farm when you were taking your first faltering steps in this land, with barely anything but the clothes you stood up in.");
			
			outputText("\n\nYou remember the relief you felt when you found this place, a pocket of peace in this disturbed land, how grateful you were to its owner to grub in the dirt with her and work for a pittance.");
			
			outputText("\n\nNow you feel nothing but contempt. Who chooses to live their life out here in staid idleness? What kind of sexless nothing nods her head at passing champions and then goes back to her book, not giving a flying fuck about anyone or anything as long as it doesn’t directly affect them? Does she have any idea how lucky she is, how merciful you are that you let her live her useless life in peace, with you just over the hill with a pile of sex slaves gathering? What you would give, what you would do to make her eyes open wide in dismay, to make her see a [man] she ignored passing through her yard with bigger ideas, coming back to completely destroy her.");
		}
		
		protected function takeoverPromptMerge(firstTime:Boolean = false):void
		{
			flags[kFLAGS.FARM_CORRUPT_PROMPT_DISPLAY] = 1;
			
			if (firstTime)
			{
				outputText("\n\nYou let your anger grow and then rage like a wildfire through you, coursing through your veins; increasingly these days, you are finding that your passion allows you to think clearer, to better fuel your muse. There’s potential in this farm, you can see that, you could turn it to your own purposes, but of course, the narrow minded bitch in the field below will never realise it herself. You will have to go down and put her in her place first. The only question is, now or later?");
			}
			else
			{
				// (plays every two times PC visits the farm for as long as they meet requirements) 
				outputText("Again, you find yourself standing on the bluff overlooking the farm, and you feel yourself filled with unholy rage at the woman below who stands against you and your plans for this piece of property. Do you put your plan into motion now or later?");
			}
			
			menu();
			addButton(0, "Now", takeoverPromptNow);
			addButton(1, "Later", takeoverPromptLater);
			addButton(2, "Never", takeoverPromptNever);
		}
		
		protected function takeoverPromptNow():void
		{
			clearOutput();
			
			outputText("You stride down to the farm and leap over a gate. You move casually, swaggering towards the pepper field with no obvious intent. When Whitney spots you and slowly stands up from her weeding, you raise your hand in friendly greeting, and to demonstrate your peacefulness, you theatrically hold up your [weapon] and then discard it with a careless swing of your arm.");

			// if PC has Kelly or PC raped Marble
			if (flags[kFLAGS.KELT_BREAK_LEVEL] >= 4 || player.findStatusAffect(StatusAffects.MarbleRapeAttempted) >= 0)
			{
				outputText("\n\nShe doesn’t move or shoo you away, but you can see a great deal of tenseness in her face. “<i>I already told you, I don’t want you on my farm,</i>” she says when you are face to face, her voice low and angry. You shoot your hands up and look around you in mocking exasperation, appealing to an audience that isn’t there.");
			}
			else
			{
				outputText("\n\nShe looks at you with tense uncertainty. “<i>Listen [name], I’m glad you’re here. I’ve been meaning to talk to you. I... I don’t think I want you coming to the farm no more. You’ve changed since I first got to know you, you... smell different these days. Like a demon, if you want the truth. I let it go because I know you and I’ve always said you gotta tend to your own knittin', but...</i>” She trails off as you stick out your lower lip in mocking hurt.");
			}

			outputText("\n\n“<i>All I want to do is talk. I’ve got some big plans for your farm, and I want to discuss them with you.</i>”");

			outputText("\n\n“<i>There is nothing to discuss.</i>” she replies.");

			outputText("\n\n“<i>Oh, but I think there is.</i>” You take a step towards Whitney, and immediately she steps back, gropes into her wheelbarrow, brings out a cocked crossbow, and points it at you. You grin.");

			// if PC has Kelly
			if (flags[kFLAGS.KELT_BREAK_LEVEL] >= 4)
			{
				outputText("\n\n“<i>Cute. But, you know, Kelt had a bow. He practiced with it every day. To protect your farm, I believe.</i>” You pause and look her dead in the eye. “<i>Get a good look at Kelt recently? Would you like that to happen to you? To be on your knees, begging me to cum on your face? Because the way I see it, there isn’t much protecting your farm these days. Just about anyone could walk in here and do as they please. As you sleep, perhaps? Quietly taint your food whilst you work? Are you really going to hold onto that crossbow for the rest of your life?</i>” Whitney’s grip is trembling slightly, you can see it in the bolt and string.");
			}
			// else if PC raped Marble
			else if (player.findStatusAffect(StatusAffects.MarbleRapeAttempted) >= 0)
			{
				outputText("\n\n“<i>Cute. But, you know, Marble had a hammer which made that thing look like a peashooter. She practiced with it every day. To protect your farm, I believe?</i>” You pause and look her dead in the eye. “<i>If I remember right, after I finished with her, she was a whimpering mess. How well has she been fighting since, because the way I see it, there isn’t much protecting your farm these days. Just about anyone could walk in here and do as they please. As you sleep, perhaps? Quietly taint your food whilst you work? Are you really going to hold onto that crossbow for the rest of your life?</i>” Whitney’s grip is trembling slightly, you can see it in the bolt and string.");
			}
			else
			{
				outputText("\n\n“<i>Cute. But I’ve fought things that had dicks which looked deadlier than that thing.</i>” You pause and look her dead in the eye. “<i>I’ve fought a lot of things since I arrived here, Whitney. Crushed a lot of things underneath my heel. All of Mareth is coming to understand that if you are not useful to me, you are broken and remade so that you </i>are<i>. It would be a damn shame if something like that happened to you because you wouldn’t see sense. After all, just about anyone could walk in here and do as they please, as you sleep, perhaps? Quietly taint your food whilst you work? Are you really going to hold onto that crossbow for the rest of your life?</i>” Whitney’s grip is trembling slightly, you can see it in the bolt and string.");
			}

			outputText("\n\n“<i>What do you want?</i>” she growls in a strangled voice.");

			outputText("\n\n“<i>All I want is to... maximise this farm’s productivity. There’s a lot of slack around here that needs picking up, if you ask me.</i>” You put your hands behind your back and begin to slowly pace back and forth in the pepper patch. She’s still pointing the crossbow, but the arrow’s barb is getting increasingly erratic. “<i>You will let me use the farm as I please. I will send... help... to you, as I see fit. In return, I guarantee that I will not make any attempts on your person, and I guarantee that no harm will come to your farm.</i>” The barb trembles for a while longer. ");

			// if PC has Kelly or PC raped Marble
			if (flags[kFLAGS.KELT_BREAK_LEVEL] >= 4 || player.findStatusAffect(StatusAffects.MarbleRapeAttempted) >= 0)
			{
				outputText("\n\nYou have to admit, it’s going to be plenty painful if she fires it, so much so that you don’t know what will happen afterwards; an image of an inferno consuming a barn flits through your mind. After what seems like an hour of deliberation, though, Whitney lowers the crossbow.");

				outputText("\n\n“<i>Alright. Alright, maybe you got me, stranger. Without");
				if (flags[kFLAGS.KELT_BREAK_LEVEL] >=  4) outputText(" Kelt");
				else outputText(" Marble");
				outputText(" I cannot properly protect the place, so maybe I do need... insurance.</i>” She spits the last word. “<i>Just so long as you stay the fuck away from me, I will do as you say.</i>” You beam.");
			}
			else
			{
				// if Marble is at the Farm
				if (player.findStatusAffect(StatusAffects.MarbleRapeAttempted) < 0 && player.findStatusAffect(StatusAffects.NoMoreMarble) < 0)
				{
					outputText("\n\n“<i>Marble will not stand for it,</i>” Whitney says, her voice barely above a whisper.");

					outputText("\n\n“<i>Marble can fucking swivel,</i>” you reply calmly. “<i>I outnumber her.</i>”");
				}

				// if Kelt is still around
				// (Kelt being disabled doesn't remove him from the farm iirc, so it's literally just if Kelt != Kelly)
				if (flags[kFLAGS.KELT_BREAK_LEVEL] < 4)
				{
					outputText("\n\n“<i>Do you think Kelt will take you muscling in on his territory? He’ll kill you before letting that happen.</i>”");

					outputText("\n\n“<i>If Kelt is willing to take direction from someone like you he will take it from me, I think,</i>” you say, shrugging casually. “<i>If you think I’m frightened of that moronic blowhard you’ve got another thing coming.</i>”");
				}

				outputText("\n\nYou have to admit, it’s going to be plenty painful if she fires it, so much so that you don’t know what will happen afterwards; an image of an inferno consuming a barn flits through your mind. After what seems like an hour of deliberation, though, Whitney lowers the crossbow.");

				outputText("\n\n“<i>Alright. Alright, maybe you got me, stranger. I don’t have eyes in the back of my head, so maybe I do need... insurance.</i>” She spits the last word. “<i>Just so long as you stay the fuck away from me, I will do as you say.</i>” You beam.");
			}

			outputText("\n\n“<i>Smart decision. I’ll send along help to you as soon as I can. I look forward to a long and prosperous business relationship with you.</i>” You bow deeply, turn and move almost all the way to the gate before raising a finger. “<i>Oh, just one more thing. I will be expecting a cut. Seeing as how I’m invested in your little operation now and all. Shall we say 20%? If you cannot bear giving me the money yourself, just leave it underneath the rock over yonder every week. Do that and we won’t have any... problems.</i>” You smirk at her. She looks at you as if she’s never seen you before in her life, incapable of words. “<i>I guess that’s settled then. Always a pleasure talking to you, Whitney.</i>” You throw your [hips] out in an exaggerated swagger as you slowly make your way back to camp, knowing the dog morph’s eyes will follow you until you disappear into the distance.");

			flags[kFLAGS.FARM_CORRUPTION_STARTED] = 1;
			
			doNext(13);
		}
		
		protected function takeoverPromptLater():void
		{
			clearOutput();
			
			outputText("You stare for a moment longer, then turn and head back to camp. You will show mercy she does not deserve... for now.");
			
			doNext(13);
		}
		
		protected function takeoverPromptNever():void
		{
			clearOutput();
			
			outputText("You close your eyes and take deep, shuddering breaths, drawing in the sweet, grass scented air and listening to the quiet, gentle peace which surrounds this place. The putrid ideas and viciously colourful images crowding your mind fade bit by bit, your blood cools and slowly, eventually, you find inner tranquillity.  You promise yourself that come what may you’ll never do anything to this patch of peace you found in this world so long ago, if only as a reminder of what you once were. A heavy lump gathering in your throat, you turn and leave.");
 
			// (Option never displayed again, -5 Corruption)
			dynStats("cor-", 5);
			doNext(13);
		}
		
		public function rootScene():void
		{
			clearOutput();
			spriteSelect(62);
			
			var firstInsert:Boolean = true;
			
			// Amily
			if (flags[kFLAGS.FOLLOWER_AT_FARM_AMILY] == 1)
			{
				if (!firstInsert) outputText("\n\n");
				firstInsert = false;
				outputText("Amily is in the pepper patch with a trowel happily beavering away. If she wasn’t purple and naked apart from her work gloves it would be difficult to believe she was corrupt at all.");
				
			}
			
			// Jojo
			if (flags[kFLAGS.FOLLOWER_AT_FARM_JOJO] == 1)
			{
				if (!firstInsert) outputText("\n\n");
				firstInsert = false;
				outputText("You cannot see Jojo but you have no doubt he was aware of your presence the moment you arrived, and that he’s somewhere nearby, watching.");
			}
			
			// Bimbo Sophie
			if (flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 2)
			{
				if (!firstInsert) outputText("\n\n");
				firstInsert = false;
				outputText("You cannot see Sophie but distinctive coos and giggles are coming from the hen coop.");
			}
			
			// Regular Sophie
			if (flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 1)
			{
				if (!firstInsert) outputText("\n\n");
				firstInsert = false;
				outputText("Sophie has put together a huge nest on top of the hen coop from which she pensively stares out at the lake. When she sees you looking she brightens noticeably and begins to preen her plumage.");
			}
			
			// Izma
			if (flags[kFLAGS.FOLLOWER_AT_FARM_IZMA] == 1)
			{
				if (!firstInsert) outputText("\n\n");
				firstInsert = false;
				outputText("Izma is sitting in Whitney’s old spot below the oak tree, curled up in a book.");
			}
			
			// Isabella
			if (flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 1)
			{
				if (!firstInsert) outputText("\n\n");
				firstInsert = false;
				outputText("Isabella is hauling steel canisters in and out of the milking barn, singing merrily to herself as she does.");
			}
			
			// Vapula
			if (flags[kFLAGS.FOLLOWER_AT_FARM_VAPULA] == 1)
			{
				if (!firstInsert) outputText("\n\n");
				firstInsert = false;
				outputText("Vapula is slouched against a barn wall, looking like the world’s grumpiest one woman gang. Not even a number of comatose imps nearby seem to have been able to cheer her up.");
			}
			
			// Latexy
			if (flags[kFLAGS.FOLLOWER_AT_FARM_LATEXY] == 1)
			{
				if (!firstInsert) outputText("\n\n");
				firstInsert = false;
				outputText("You can see something black shimmering wetly underneath Whitney’s porch which can only be a certain latex goo.");
			}
			
			// BathSlut
			if (flags[kFLAGS.FOLLOWER_AT_FARM_BATH_GIRL] == 1)
			{
				if (!firstInsert) outputText("\n\n");
				firstInsert = false;
				
				if (flags[kFLAGS.MILK_SIZE] > 0)
				{
					outputText("[bathgirlname] is rather predictably in the cow shed, milking the cattle. She looks tan, bright and happy; the country air is doing her good.");
				}
				else
				{
					outputText("[bathgirlname] is sat on the edge of her tank next to the cow shed, rubbing her huge tits in slow, mesmeric patterns. Her gaze is vacant except when it lands on you, whereon it becomes hopeful.");
				}
			}
			
			farmMenu();
		}
		
		public function farmMenu():void
		{
			menu();
			addButton(4, "Slaves", slavesAtFarmMenu);
			addButton(5, "Lovers", loversAtFarmMenu);
			addButton(6, "Followers", followersAtFarmMenu);
		}
		
		private function slavesAtFarm():void
		{
			menu();
			
			if (flags[kFLAGS.FOLLOWER_AT_FARM_AMILY] == 1) addButton(0, "Amily", kGAMECLASS.amilyScene.amilyFollowerEncounter);
			
			if (flags[kFLAGS.FOLLOWER_AT_FARM_JOJO] == 1) addButton(1, "Jojo", kGAMECLASS.jojoScene.corruptCampJojo);
			
			if (flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 2) addButton(2, "Sophie", kGAMECLASS.sophieBimbo.approachBimboSophieInCamp);
			
			if (flags[kFLAGS.FOLLOWER_AT_FARM_VAPULA] == 1) addButton(3, "Vapula", kGAMECLASS.vapula.callSlaveVapula);
			
			if (flags[kFLAGS.FOLLOWER_AT_FARM_LATEXY] == 1) addButton(4, flags[kFLAGS.GOO_NAME], kGAMECLASS.latexGirl.approachLatexy);
			
			if (flags[kFLAGS.FOLLOWER_AT_FARM_BATH_GIRL] == 1) addButton(5, flags[kFLAGS.MILK_NAME], kGAMECLASS.milkWaifu.milkyMenu);
			
			addButton(9, "Back", farmMenu);
		}
		
		private function followersAtFarmMenu():void
		{
			menu();
			
			if (flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 1) addButton(0, "Sophie", kGAMECLASS.sophieFollowerScene.followerSophieMainScreen);
			
			addButton(0, "Back", farmMenu);
		}
		
		private function loversAtFarmMenu():void
		{
			menu();
			
			if (flags[kFLAGS.FOLLOWER_AT_FARM_IZMA] == 1) addButton(0, "Izma", kGAMECLASS.izmaScene.izmaFollowerMenu);
			if (flags[kFLAGS.FOLLOWER_AT_FARM_IZMA] == 2) addButton(0, "Izmael", eventParser, 9999);
			
			if (flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 1) addButton(1, "Isabella", kGAMECLASS.isabellaFollowerScene.callForFollowerIsabella);
			
			addButton(0, "Back, farmMenu);
		}
	}

}