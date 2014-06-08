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
		
		public function whitneySprite():void
		{
			farm.whitneySprite();
		}
		
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
			if (mod != 0)
			{
				flags[kFLAGS.WHITNEY_CORRUPTION] += mod;
				
				// Track highest corruption value
				if (flags[kFLAGS.WHITNEY_CORRUPTION] > flags[kFLAGS.WHITNEY_CORRUPTION_HIGHEST]) flags[kFLAGS.WHITNEY_CORRUPTION_HIGHEST] = flags[kFLAGS.WHITNEY_CORRUPTION];
			}
			
			// Cap the values into the appropriate range
			if (flags[kFLAGS.FARM_CORRUPTION_APPROACHED_WHITNEY] == 0 && flags[kFLAGS.WHITNEY_CORRUPTION] > 30 ) flags[kFLAGS.WHITNEY_CORRUPTION] = 30;
			else if (flags[kFLAGS.WHITNEY_LEAVE_0_60] == 0 && flags[kFLAGS.WHITNEY_CORRUPTION] > 60) flags[kFLAGS.WHITNEY_CORRUPTION] = 60;
			else if (flags[kFLAGS.WHITNEY_LEAVE_61_90] == 0 && flags[kFLAGS.WHITNEY_CORRUPTION] > 90) flags[kFLAGS.WHITNEY_CORRUPTION] = 90;
			else if (flags[kFLAGS.WHITNEY_MENU_91_119] == 0 && flags[kFLAGS.WHITNEY_CORRUPTION] > 119) flags[kFLAGS.WHITNEY_CORRUPTION] = 119;

			// Clamp values to valid min/max
			if (flags[kFLAGS.WHITNEY_CORRUPTION] < 0) flags[kFLAGS.WHITNEY_CORRUPTION] = 0;
			if (flags[kFLAGS.WHITNEY_CORRUPTION] >= 120)
			{
				flags[kFLAGS.WHITNEY_CORRUPTION] = 120;
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
			
			// If Whitney was disabled the previous day, set the flag for a follow up
			if (flags[kFLAGS.WHITNEY_DISABLED_FOR_DAY] == 1)
			{
				flags[kFLAGS.WHITNEY_DISABLED_FOR_DAY] = 2;
			}

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
			
			// Contraceptives
			if (flags[kFLAGS.FARM_UPGRADES_CONTRACEPTIVE] == 1)
			{
				if (flags[kFLAGS.FARM_CONTRACEPTIVE_STORED] == 0) flags[kFLAGS.FARM_CONTRACEPTIVE_STORED] = 1;
			}
			
			// Increment days since last paid out
			flags[kFLAGS.FARM_CORRUPTION_DAYS_SINCE_LAST_PAYOUT] += 1;
			
			return modValue;
		}
		
		public function collectTheGoodies():void
		{
			clearOutput();
			
			// Get gems
			if (flags[kFLAGS.FARM_CORRUPTION_DAYS_SINCE_LAST_PAYOUT] >= 7)
			{
				outputText("You stroll over to the big rock at the edge of the pepper patch, smiling as you see a small burlap sack shoved underneath a fold in the stone. You scoop it up, open it and count out " + flags[kFLAGS.FARM_CORRUPTION_GEMS_WAITING] + " gems.");
				
				if (farmValue < 25) outputText(" You frown; it seems like a feeble amount for such a large operation. Perhaps you could talk to Whitney about that.");
				
				player.gems += flags[kFLAGS.FARM_CORRUPTION_GEMS_WAITING];
				flags[kFLAGS.FARM_CORRUPTION_GEMS_WAITING] = 0;
			}
			
			outputText("\n");
			
			if (flags[kFLAGS.FARM_SUCCUMILK_STORED] > 0 || flags[kFLAGS.FARM_INCUDRAFT_STORED] > 0 || flags[kFLAGS.FARM_EGG_STORED] > 0)
			{
				outputText("\nYour ‘farmers’ have been busy under the watchful eye of their assigned task mistress. A small bundle of goods have been stashed with the gems just awaiting your arrival.\n\n");
			}
						
			if (flags[kFLAGS.FARM_SUCCUMILK_STORED] > 0) offerItems(kFLAGS.FARM_SUCCUMILK_STORED);
			if (flags[kFLAGS.FARM_INCUDRAFT_STORED] > 0) offerItems(kFLAGS.FARM_INCUDRAFT_STORED);
			if (flags[kFLAGS.FARM_EGG_STORED] > 0) offerItems(kFLAGS.FARM_EGG_STORED);
			if (flags[kFLAGS.FARM_CONTRACEPTIVE_STORED] > 0) offerItems(kFLAGS.FARM_CONTRACEPTIVE_STORED);
			
			addButton(9, "Back", rootScene);
		}
		
		private function getItemObj(flag:int):SimpleConsumable
		{
			if (flag == kFLAGS.FARM_SUCCUMILK_STORED) return consumables.SUCMILK;
			if (flag == kFLAGS.FARM_INCUDRAFT_STORED) return consumables.INCUBID;
			if (flag == kFLAGS.FARM_EGG_STORED) return kGAMECLASS.sophieBimbo.eggTypes[kGAMECLASS.sophieBimbo.eggColors.indexOf(flags[kFLAGS.FOLLOWER_PRODUCTION_SOPHIE_COLOURCHOICE])];
			if (flag == kFLAGS.FARM_CONTRACEPTIVE_STORED) return consumables.HRBCNT;
		}
		
		private function offerItems(flag:int):void
		{
			outputText("<b>");
			
			if (flags[flag] > 1) outputText(flags[flag] + "x ");
			else outputText("A ");
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
			
			kGAMECLASS.menuLoc = 30;
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

			if (flags[kFLAGS.FOLLOWER_AT_FARM_VAPULA] == 1) fValue += 1;

			if (flags[kFLAGS.FOLLOWER_AT_FARM_LATEXY] == 1) fValue += 2;

			if (flags[kFLAGS.FOLLOWER_AT_FARM_KELLY] == 1) fValue += 1;

			if (flags[kFLAGS.FOLLOWER_AT_FARM_MARBLE] == 1) fValue += 2;

			if (flags[kFLAGS.FOLLOWER_AT_FARM_BATH_GIRL] == 1) fValue += 3;
			else if (flags[kFLAGS.FOLLOWER_AT_FARM_BATH_GIRL] == 2) fValue += 7;

			if (flags[kFLAGS.WHITNEY_CORRUPTION_COMPLETE] == 1) fValue *= 1.25;
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
			
			if (flags[kFLAGS.WHITNEY_DISABLED_FOR_DAY] == 2)
			{
				flags[kFLAGS.WHITNEY_DISABLED_FOR_DAY] = 3;

				outputText("“<i>[name]? [name]!</i>” You turn and watch Whitney shyly step out from the shadow of the barn. She has retained her slim frame and modest clothes, however her fur is all gone and has been replaced by skin of the same sandy colour. Human feet peek out from underneath her skirt, and... well. You take a few moments to drink in her human face, still quintessentially Whitney in her long, delicate features, thin but easy smile and rosy colour accentuating her high cheekbones; pretty but not beautiful. The only dog features she has kept are her floppy ears and short, perky tail. Scratch that; as you smile approvingly she smiles widely in return, laughing almost in relief, revealing quite pointed teeth and a thinner-than-normal tongue. Still, it’s a pretty decent effort all round.");

				outputText("\n\n“<i>Very good girl,</i>” you say. You slowly approach her. “<i>Such swiftness and willingness to change is an excellent sign. You and I will go very far together indeed.</i>” Again you stand directly in front of her, again you stare deep into her brown eyes; you wait until her breath comes shallow once more. “<i>Now, where were we?</i>”");

				doNext(dontDeFurDoge);
				return;
			}

			// Whitney not corrupt
			if (!whitneyCorrupt())
			{
				outputText("You stand on the rise you’ve taken to using to look down on the farm which you are invested in.")
				
				if (flags[kFLAGS.FARM_UPGRADES_REFINERY] == 1) outputText(" A large machine, bulky and rotund with a conical top, has been built into the milking barn. Fat pipes crawl up onto the roof from it like metal ivy, and white smoke billows busily out of its whistle chimney.");
				
				if (flags[kFLAGS.FARM_UPGRADES_CONTRAPCEPTIVE] == 1) outputText(" Next to the pepper patch another crop has been planted, a field of verdant green shrubs. Their thin stems bob idly in the breeze.");
			}
			else
			{
				outputText("You stand on your rise and take in your slave farm. ");
				if (silly)
				{
					outputText(player.mf("You feel an irresistible hankering for a cigar.", "You feel an irresistible hankering for a cigarette holder.");
				}
				if (flags[kFLAGS.FARM_UPGRADES_REFINERY] == 1) outputText(" A large machine, bulky and rotund with a conical top, has been built into the milking barn. Fat pipes crawl up onto the roof from it like metal ivy, and white smoke billows busily out of its whistle chimney.");
				if (flags[kFLAGS.FARM_UPGRADES_CONTRAPCEPTIVE] == 1) outputText(" Next to the pepper patch another crop has been planted, a field of verdant green shrubs. Their thin stems bob idly in the breeze.");
			}

			// [Follower taster and “blessing” text goes here]
			
			// Ceraphs Influence
			if (flags[kFLAGS.FOLLOWER_AT_FARM_CERAPH] > 0)
			{
				outputText("\n\nThere is an indefinable aura of corruption slathered across the farm; you can taste it at the back of your throat, you can practically see it like a blaze on your retina from looking at a purple light too long. The area has definitely been marked by a demon.");
			}
			
			// Holli Influence
			if (flags[kFLAGS.FOLLOWER_AT_FARM_HOLLI] > 0)
			{
				outputText("\n\nThe crops and grass which surround you seem to blaze with life, almost feverishly so. Suggestively shaped vines have curled up one or two of the trees, and some of the wildflowers look... different. Holli’s blessing has caused everything on the farm to grow faster, but if you peer closely at the grass at your feet, you can make out the purple tendrils of corruption within.");
			}
			
			// Amily
			if (flags[kFLAGS.FOLLOWER_AT_FARM_AMILY] == 1)
			{
				outputText("\n\nAmily is in the pepper patch with a trowel happily beavering away. If she wasn’t purple and naked apart from her work gloves it would be difficult to believe she was corrupt at all.");
				
			}
			
			// Jojo
			if (flags[kFLAGS.FOLLOWER_AT_FARM_JOJO] == 1)
			{
				outputText("\n\nYou cannot see Jojo but you have no doubt he was aware of your presence the moment you arrived, and that he’s somewhere nearby, watching.");
			}
			
			// Bimbo Sophie
			if (flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 2)
			{
				outputText("\n\nYou cannot see Sophie but distinctive coos and giggles are coming from the hen coop.");
			}
			
			// Regular Sophie
			if (flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 1)
			{
				outputText("\n\nSophie has put together a huge nest on top of the hen coop from which she pensively stares out at the lake. When she sees you looking she brightens noticeably and begins to preen her plumage.");
			}
			
			// Izma
			if (flags[kFLAGS.FOLLOWER_AT_FARM_IZMA] == 1)
			{
				outputText("\n\nIzma is sitting in Whitney’s old spot below the oak tree, curled up in a book.");
			}
			
			// Isabella
			if (flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 1)
			{
				outputText("\n\nIsabella is hauling steel canisters in and out of the milking barn, singing merrily to herself as she does.");
			}
			
			// Vapula
			if (flags[kFLAGS.FOLLOWER_AT_FARM_VAPULA] == 1)
			{
				outputText("\n\nVapula is slouched against a barn wall, looking like the world’s grumpiest one woman gang. Not even a number of comatose imps nearby seem to have been able to cheer her up.");
			}
			
			// Latexy
			if (flags[kFLAGS.FOLLOWER_AT_FARM_LATEXY] == 1)
			{
				outputText("\n\nYou can see something black shimmering wetly underneath Whitney’s porch which could only be a certain latex goo.");
			}
			
			// BathSlut
			if (flags[kFLAGS.FOLLOWER_AT_FARM_BATH_GIRL] == 1)
			{
				if (flags[kFLAGS.MILK_SIZE] > 0)
				{
					outputText("\n\n[Bathgirlname] is rather predictably in the cow shed, milking the cattle. She looks tan, bright and happy; the country air is doing her good.");
				}
				else
				{
					outputText("\n\n[Bathgirlname] is sat on the edge of her tank next to the cow shed, rubbing her huge tits in slow, mesmeric patterns. Her gaze is vacant except when it lands on you, whereon it becomes hopeful.");
				}
			}
			
			farmMenu();
		}
		
		public function farmMenu():void
		{
			menu();
			
			if (flags[kFLAGS.WHITNEY_DISABLED_FOR_DAY] == 0)
			{
				if (!whitneyCorrupt()) addButton(0, "Whitney", dogeNotCorruptYet);
				else addButton(0, "Whitney", dogeCorruptedMissionComplete);
			}

			addButton(0, "Whitney", eventParser, 9999);
			
			if (player.findStatusAffect(StatusAffects.MarbleRapeAttempted) < 0 && player.findStatusAffect(StatusAffects.NoMoreMarble) < 0 && player.findStatusAffect(StatusAffects.Marble) >= 0 && flags[kFLAGS.MARBLE_WARNING] == 0) addButton(1, "Marble", farm.meetMarble);
			
			if (player.findStatusAffect(StatusAffects.Kelt) >= 0 && player.findStatusAffect(Keltoff) < 0)
			{
				if (flags[kFLAGS.KELT_BREAK_LEVEL] >= 4) addButton(2, "Kelly", farm.kelly.breakingKeltOptions);
				else if (flags[kFLAGS.KELT_BREAK_LEVEL] > 0 && flags[kFLAGS.KELT_TALKED_FARM_MANAGEMENT] == 0) addButton(2, "Kelt", keltAChangeInManagement);
				else addButton(2, "Kelt", farm.kelly.breakingKeltOptions);
			}
			
			if (player.hasKeyItem("Breast Milker - Installed At Whitney's Farm") >= 0) 
			{
				if (player.findStatusAffect(StatusAffects.Milked) >= 0) 
				{
					outputText("\n\n<b>Your " + nippleDescript(0) + "s are currently too sore to be milked.  You'll have to wait a while.</b>", false);
				}
				
				addButton(3,"Get Milked", farm.getMilked);
			}
			
			if(player.hasKeyItem("Cock Milker - Installed At Whitney's Farm") >= 0 && player.cockTotal() > 0)
			{
				addButton(4,"Milk Cock", farm.cockPumping);
			}
			
			addButton(5, "Farm", corruptingTheFarmExplore);
			
			if (slavesAtFarm()) addButton(6, "Slaves", slavesAtFarmMenu);
			if (loversAtFarm()) addButton(7, "Lovers", loversAtFarmMenu);
			if (followersAtFarm()) addButton(8, "Followers", followersAtFarmMenu);
			
			addButton(9, "Leave", eventParser, 13);
		}
		
		private function corruptingTheFarmExplore():void
		{
			menu();
			
			addButton(0, "Explore", farm.exploreFarm);
			
			addButton(1, "Collect", collectTheGoodies);
			
			addButton(9, "Back", farmMenu);
		}
		
		private function keltAChangeInManagement():void
		{
			clearOutput();
			
			outputText("“<i>Hear there’s been a change in management,</i>” says Kelt, clopping to a halt in front of you. You confirm that that is the case. The big centaur looks at you thoughtfully. There’s something different in his dark eyes and rugged scowl than his usual wearied contempt. Grudging admiration?");

			outputText("“<i>Find it difficult to believe someone like you could put a bitch in her place,</i>” he says eventually. “<i>Perhaps you’ve got bigger balls than I thought you had."); 
			if (player.balls == 0) outputText(" So to speak, anyway.");
			outputText("</i>” He snorts, and trots towards the butts. “<i>Just don’t expect me to treat you any different. As long as you’re getting free instruction from me, I’m the master and you’re the whelp. Got that?</i>”");
			
			outputText("\n\nYou reply evenly you can get along with that, and he’s welcome to stay on at the farm, but if he lays a finger on any of your own slaves you’re going to break every bone in his hands. Kelt roars with laughter.");

			outputText("“<i>Do I look like I want or need your sloppy seconds? Godsdamn, I can only imagine what kind of pathetic creatures would have </i>you<i> lording it over them. What a joke! Now, are we going to go watch you fail miserably to hit a target from five yards or what?</i>”");

			outputText("It’s better than you were expecting from him in all honesty. You take your bow out and silently follow him to the archery range.");
			
			flags[kFLAGS.KELT_TALKED_FARM_MANAGEMENT] = 1;
			
			doNext(13);
		}
		
		private function numSlavesAtFarm():int
		{
			var count:int = 0;

			if (flags[kFLAGS.FOLLOWER_AT_FARM_AMILY] == 1) count++;
			if (flags[kFLAGS.FOLLOWER_AT_FARM_JOJO] == 1) count++;
			if (flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 2) count++;
			if (flags[kFLAGS.FOLLOWER_AT_FARM_VAPULA] == 1) count++;
			if (flags[kFLAGS.FOLLOWER_AT_FARM_LATEXY] == 1) count++;
			if (flags[kFLAGS.FOLLOWER_AT_FARM_BATH_GIRL] == 1) count++;

			return count;
		}

		private function slavesAtFarm():Boolean
		{
			if (numSlavesAtFarm() > 0) return true;
		}

		private function slavesAtFarmMenu():void
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
		
		private function numFollowersAtFarm():int
		{
			var count:int = 0;

			if (flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 1) count++;

			return count;
		}

		private function followersAtFarm():Boolean
		{
			if (numFollowersAtFarm() > 0) return true;
		}

		private function followersAtFarmMenu():void
		{
			menu();
			
			if (flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 1) addButton(0, "Sophie", kGAMECLASS.sophieFollowerScene.followerSophieMainScreen);
			
			addButton(0, "Back", farmMenu);
		}
		
		private function numLoversAtFarm():int
		{
			var count:int = 0;

			if (flags[kFLAGS.FOLLOTER_AT_FARM_IZMA] > 0) count++;
			if (flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] > 0) count++;

			return count;
		}

		private function loversAtFarm():Boolean
		{
			if (numLoversAtFarm() > 0) return true;
		}

		private function loversAtFarmMenu():void
		{
			menu();
			
			if (flags[kFLAGS.FOLLOWER_AT_FARM_IZMA] == 1) addButton(0, "Izma", kGAMECLASS.izmaScene.izmaFollowerMenu);
			if (flags[kFLAGS.FOLLOWER_AT_FARM_IZMA] == 2) addButton(0, "Izmael", eventParser, 9999);
			
			if (flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 1) addButton(1, "Isabella", kGAMECLASS.isabellaFollowerScene.callForFollowerIsabella);
			
			addButton(0, "Back", farmMenu);
		}

		private function dogeNotCorruptYet():void
		{
			clearOutput();
			whitneySprite();

			flags[kFLAGS.FARM_CORRUPTION_APPROACHED_WHITNEY] = 1;

			// Farm Corruption drops below 30 after being higher: 
			if (whitneyCorruption() < 30 && flags[kFLAGS.WHITNEY_CORRUPTION_HIGHEST] > 30 && flags[kFLAGS.WHITNEY_CORRUPTION_0_30_DROP_MESSAGE] == 0)
			{
				outputText("You hail Whitney as she hauls a bag of grain towards the storage barn. She entirely ignores you; there’s an expression of cold triumph on her face as she breezes past you, color high in her cheeks. You notice that she’s rediscovered her crossbow and has it strapped to her back. It hurts your eyes slightly to look at her, as if she’s standing directly in front of the sun. You scowl at her retreating back. You’ll have to do something about this.");

				// [Plays once, reverts to standard message]
				flags[kFLAGS.WHITNEY_CORRUPTION_0_30_DROP_MESSAGE] = 1;
				
				if (flags[kFLAGS.WHITNEY_LEAVE_0_60] == 0) doNext(dogeNotCorruptLeaveFirstTime);
				else doNext(13);

				return;
			}

			// 0-30 Farm Corruption
			if (whitneyCorruption() <= 30)
			{
				flags[kFLAGS.FARM_CORRUPTION_APPROACHED_WHITNEY] = 1;
				outputText("You find Whitney sat in the cow field, hand milking one of her herd; her crossbow is propped up against a bucket. As you approach, she looks up sharply before slowly reaching for the weapon. You stop in your tracks, and she stops in kind, her hand frozen on the grip. You take a step forward and she picks it up, her finger finding the trigger, her expression entirely emotionless. You take several hasty steps back, she puts it down and goes back to milking peacefully.");

				outputText("\n\nYou wave in exasperation and leave; if that’s the way she wants it. If she’s working with you and your followers for any length of time, she’ll have to loosen up eventually.");

				if (flags[kFLAGS.WHITNEY_LEAVE_0_60] == 0) doNext(dogeNotCorruptLeaveFirstTime);
				else doNext(13);

				return;
			}

			// 31-60 Farm Corruption
			if (whitneyCorruption() >= 31 && whitneyCorruption() <= 60)
			{
				if (flags[kFLAGS.WHITNEY_MENU_31_60] == 0)
				{
					flags[kFLAGS.WHITNEY_MENU_31_60] = 1;

					outputText("Once again you approach Whitney, this time as she is carrying full buckets of milk towards the bottling station. She sees you coming and quickens her step. You notice this time however she doesn’t have her crossbow, and this emboldens you.");

					outputText("\n\n“<i>You can’t ignore me for the rest of your life!</i>” you yell. “<i>Let me talk to you about the farm, at least! I’m invested in this place, I’m throwing help at it and the owner won’t even tell me what she actually needs!</i>” Whitney slows to a halt, and then after a long moment sighs, puts the buckets down and turns.");

					outputText("\n\n“<i>Alright,</i>” she mutters. You notice her eyes are red and raw at the edges. “<i>I’m gettin sick of this game too. I cannot pretend you and your servants ain’t here, so I guess I gotta face reality, as piss unpleasant as it is, and talk to you about the wheres and whys of it.</i>” She shudders involuntarily, and then lifts her eyes reluctantly to yours. “<i>What do you want to talk about?</i>”");
				}
				else
				{
					// Subsequent 31-60: 
					outputText("Whitney puts down her work as you stride towards her, resigned unhappiness in her expression.");

					outputText("\n\n“<i>What is it?</i>”");
				}

				// [Unlocks Whitney main menu]
				dogeNotCorruptYetMenu();
				return;
			}

			if (whitneyCorruption() >= 61 && whitneyCorruption() <= 90)
			{
				if (flags[kFLAGS.WHITNEY_MENU_61_90] == 0)
				{
					flags[kFLAGS.WHITNEY_MENU_61_90] = 1;

					// 61-90 Farm Corruption
					outputText("You find Whitney on the steps of the porch to her small house, adjoined to the storage barn. There’s a book next to her but she is simply sat drinking in the sun, her eyes closed. When she opens them and sees you standing there she smiles at you wanly; it’s the first time you’ve seen her do that for some time. There is something indefinable in her gaze and the long lines of her face: trepidation perhaps, coated patchily with coyness.");

					outputText("\n\n“<i>Hello [name],</i>” she says softly. “<i>Something on your mind?</i>”");
				}
				else
				{
					// 61-90 Subsequent: 
					outputText("Whitney puts down her work and smiles at you vaguely as you approach her. You again sense that queasy mixture of anxiety, unhappiness and excitement in her jerky, cramped movements and expression.");

					outputText("\n\n“<i>Hello [name]. Is there something you want?</i>”");
				}

				dogeNotCorruptYetMenu();
				return;
			}

			if (whitneyMenu() >= 91 && whitneyMenu() <= 119)
			{
				// 91-119 Farm Corruption
				if (flags[kFLAGS.WHITNEY_MENU_91_119] == 0)
				{
					flags[kFLAGS.WHITNEY_MENU_91_119] = 1;

					outputText("There is a sultry atmosphere around the farm these days. The air feels warmer than it should and the breeze which curls over the fields carries with it a musky, enticing perfume which presses irresistibly into your nose and the back of your throat. When you find Whitney on her porch you can’t help but think she looks considerably more relaxed than she has done of late; perhaps it’s just too hard to remain tense in these conditions. ");

				outputText("\n\n“<i>Yes, [name],</i>” she says, so softly you can barely hear her. “<i>What can I do for you?</i>” Cautiously, you ask her how she feels about the changes you have made around the farm.");

				outputText("\n\n“<i>You were right,</i>” she says, again in that incredibly low voice, before clearing her throat and going on in a louder tone, the words spilling out of her. “<i>I hated you when you first came here demanding a share of the farm, more than anything I’ve ever hated in a long time. Someone taking control of my family’s farm, what I had worked on for all these years, through what seemed to me like pure vindictiveness… I fantasized about killing you, didja know that? Shooting you through the neck when you were tendin’ to something else. The only thing that stopped me I think was fear: fear that you were so powerful that you’d survive it somehow. How miserable I was back then... but at some point I just said fuck it, you know? If I couldn’t work up the courage to fight you, what was the point in stayin’ miserable and angry the whole time? And the more I let go of it...</i>”");

				outputText("\n\nAs she talks, you delve into your pocket and bring out a gem, this time with deliberate slowness. Whitney’s eyes are immediately drawn to it and she pauses; you softly motion for her to continue, slowly turning the small, glittering kaleidoscope in your fingers as you do. “<i>...It’s just so much more </i>fun<i> around here these days. The farm feels like it’s alive, I am makin so much more money and... the more I open my mind, the more I let go of those old hates, the more I can think, the more I can feel. Gods, I am feeling things I haven’t in years. I see the way you order your followers around and it feels powerful, I make them do as I will and it feels right, like I’m taking control and shaping the world instead of just layin back and watchin it pass me by. It feels like... like...</i>”");

				outputText("\n\n“<i>Like you’re waking up,</i>” you say. You twist the gem back and forth, shining tiny, scattering beams of blinding light into the dog morph’s eyes. Her mouth hands open and her breath is shallow. “Like since I’ve taken control you’ve woken up to everything that life has to offer, everything that </i>I<i> have to offer, the horizons that appear when you submit to my will. This farm is many times the place it was when you were closed up in your old life of petty certainties. You just told me that and like the farm, </i>you<i> are becoming more and more real the further you open yourself to me.”");

				outputText("\n\nYou think the doggie is close now, so very close to fully opening her mind and entirely tasting reality. All she needs to do is one thing to demonstrate her commitment....");

				outputText("\n\n”<i>What is that,</i>” says Whitney dully. You smile, gently bringing the twisting gem to a halt and putting it back into your pouch. You will know what that is when you are truly ready, you say. With that you turn and leave her, swaying vaguely on the porch, her eyes far, far away. As long as you can keep her immersed in the atmosphere you’ve conjured up over the farm, you think she’ll be ready for the final stage of your plan soon enough.");
				}
				else
				{
					// Subsequent 91-119: 
					outputText("Whitney lays down her work eagerly as you approach. ");

					outputText("\n\n“<i>What’re you after, [name]?</i>” she says, smiling. There’s a barely contained excitement in her eyes; you don’t think she realises her short tail is wagging furiously.");
				}

				dogeNotCorruptYetMenu();
				return;
			}

			if (whitneyCorruption() == 120)
			{
				if (flags[kFLAGS.WHITNEY_CORRUPTION_COMPLETE] == 0)
				{
					flags[kFLAGS.WHITNEY_CORRUPTION_COMPLETE] = 1;
					
					// 120 Farm Corruption 
					outputText("You don’t need to seek out Whitney this time; almost the moment you arrive on the farm a sandy furred figure is hurrying over to you. There’s deep excitement in her face and her breast is heaving with more than just exertion.");

					outputText("\n\n“<i>[name], can I... can I talk to you? I really need t-to talk.</i>” You know what she’s really asking for here. You smile, withdraw the gem and once again begin to slowly turn it, clockwise, then anti-clockwise... Whitney’s eyes are full of reflected, sparkling light.");

					outputText("\n\n“<i>You won’t ever leave here, will you?</i>” she says breathlessly. “<i>I-I’ve started thinking things, so many delicious </i>things<i>, and I... I’m worried they’ll stop when you do. You promise you won’t stop coming around?</i>” You say coolly that your continued involvement depends on her telling you exactly what she’s been thinking about. Whitney pauses for a moment and then goes on. Her mouth is so dry you struggle not to swallow in sympathy.");

					outputText("\n\n“<i>It started as a joke - I started giving orders to your followers like you do. You been around here enough it’s easy to imitate your words ‘n tone. That made ‘em start! But then I... I began to fantasise about really owning them, about abusing them, about beating them and then making em thank me for the privilege. Because they deserve it, don’t they? That’s what they are there for. That’s how you think and Gods... it feels so right to think that way, it opens up so many possibilities. But then I began to think in a new way....</i>” She licks her lips unconsciously. “<i>When you were around, again just for jokes I’d look at you and call you somethin’ under my breath, and </i>that<i>... every time I did it I had to go, I had to go somewhere quiet an’...</i>” she is unable to continue.");

					outputText("\n\nSoftly, still spinning the gem, you ask her what she called you. Whitney makes a noise which is familiar to you but which you’ve never heard emanating from her; a faint, high pitched whine from the back of her throat. Again, gently but firmly, you ask her what word she used.");

					outputText("\n\n“<i>...[Master],</i>” she says, quietly. You smile triumphantly. It’s time to move onto the final stage of your high-stakes business merger, however such is your control over the dog morph now you could make her change for you, if you so wished.");

					///[Defur][Get on with it]
				}
			}
		}

		private function dogeNotCorruptLeaveFirstTime():void
		{
			clearOutput();
			whitneySprite();

			flags[kFLAGS.WHITNEY_LEAVE_0_60] = 1;

			// Leave first time: [otherwise defaults to main farm menu] 
			outputText("As you turn to leave, you feel something tug on your [armor]. You turn back to look into Whitney’s searching eyes.");

			outputText("\n\n“<i>How... how do you do it?</i>” she asks haltingly. “<i>How can you force other people into becoming your... your puppets, your chattel? Doesn’t it sicken your stomach?</i>” You shrug nonchalantly and say that almost all of your harem had ideas about your personal freedom, your genitals, and how they would use them to fuel their own selfish purposes; your will and desires simply proved to be stronger than theirs. You have discovered through hard experience that that is the way of this world and those who think otherwise are simply prey to those who are more ruthless. You stare for a moment longer into her eyes, and then sweep away.");

			doNext(rootScene);
		}

		private function dogeNotCorruptLeave6190():void
		{
			clearOutput();
			whitneySprite();

			flags[kFLAGS.WHITNEY_LEAVE_61_90] = 1;

			// Leave first time: 
			outputText("“<i>I know what you’re tryin to do,</i>” the dog woman says abruptly as you conclude your business and turn to leave. “<i>You think that if you make me work with your slaves, poison this place with your influence and demon magic, you’ll turn me into one of your puppets too. Evil osmosis, or somethin.</i>” She laughs bitterly. There’s an almost hysterical note to it. Maybe you’re kidding yourself but you think there might also be a brittle, perverse note of excitement in there too. “<i>It don’t work like that. All you’re doing with this business is surroundin me with examples of your cruelty, of what corruption and ill-will can do to ordinary folks. I can stand against it, and I will.</i>”");

			outputText("\n\nYou shrug nonchalantly, retrieve a gem from your purse and spin it on your fingertips with the same affected casualness. It’s not about corruption, you say; you aren’t in league with the demons, you have a soul. All you want to do is make the very best of this farm, and open her mind to new possibilities, new ways of thinking. The gem glitters with sunlight as you spin it rhythmically. You think that she’s spent too long on her own; has become so set in her ways she sees anything that changes her world as a threat, even if it is for her own benefit. She should open her eyes and open her mind to the success you’re bringing to her fields; maybe she’d learn how rich life can be if she let go of her prejudices, and accept that from your wider experience you know better. You pinch the gem to a stop and look at Whitney. She stares at the pretty object a moment longer before shaking her head and bringing her eyes up to yours, slightly dazed. You turn and leave, smiling quietly to yourself.");
		}

		private function dogeNotCorruptYetMenu():void
		{
			menu();

			addButton(0, "Appearance", whitneyAppearanceNotCorrupt);
			addButton(1, "Prosperity", prosperityGoNotCorrupt);
			addButton(2, "Investment", investmentGoNotCorrupt);

			addButton(9, "Back", rootScene);

			if (whitneyCorruption() <= 60 && flags[kFLAGS.WHITNEY_LEAVE_0_60] == 0) addButton(9, "Back", dogeNotCorruptLeaveFirstTime);
			else if (whitneyCorruption() <= 90 && flags[kFLAGS.WHITNEY_LEAVE_61_90] == 0) addButton(9, "Back", dogeNotCorruptLeave6190);
		}

		private function whitneyAppearanceNotCorrupt():void
		{
			clearOutput();
			whitneySprite();

			outputText("\n\nWhitney is a 5’8” dog morph, dressed in a modest cotton blouse and faded long skirt, which has a hole cut in it to allow her short, perky tail to poke through. Her muzzle is suggestive of a golden retriever but really she could be any breed. Her fur is sandy, dusking to black at her extremities. Her ears are floppy, her eyes are a dark brown which matches her shoulder-length hair. She is beyond the flush of youth, however it is obvious from looking at her that she has never known childbirth; though hardened from many years of farm work her frame is relatively slim, her hips and ass widened only with muscle, her small breasts pert against her unprepossessing work-clothes. She has one anus, nestled between her tight buttcheeks where it belongs.");

			dogeNotCorruptYetMenu();
			addButton(0, "", null);
		}

		private function prosperityGoNotCorrupt():void
		{
			clearOutput();
			whitneySprite();

			outputText("You ask her how the help is coming on.");

			var lowProtection:Boolean;
			var lowValue:Boolean;

			if (farmProtection() < 12) lowProtection = true;
			if (farmValue() < 12) lowValue = true;

			// Value low, Protection low:
			if (lowValue && lowProtection) outputText("\n\nShe shrugs exasperatedly. “<i>I used to get by just fine on my own,</i>” she says. “<i>‘Til you started demanding 20% of everything. You think gems grow on cornstalks? Send me any kind of decent body - someone, anyone - and I can start trying to make more-a this place.</i>”");

			// Value high, Protection low: 
			if (!lowValue && lowProtection) outputText("\n\n“<i>You’ve given me lots’ve good workers, lots’ve good earners, and I’ve been bringing in lots’ve produce.</i>” She sighs. “<i>The trouble is lots’ve produce attracts trouble. Imps, gnolls, that sort. And if there ain’t nobody to stop em, they help themselves. I need strong types to come along here, warriors, watchers, people who’ll stop stuff disappearing in the night. You know?</i>”");

			// Value low, Protection high: 
			if (lowValue && !lowProtection) outputText("\n\n“<i>Feel plenty safe at night, I can tell you that. You got this place protected better than a bank vault.</i>” Whitney shrugs. “<i>Trouble is, the vault is empty. Guards ‘d be great but they don’t scratch the earth for a living. I need hard workers, people who’ll produce stuff, earners. That’s what this place is crying out for right now.</i>”");

			// Value high, Protection high: 
			if (!lowValue && !lowProtection) outputText("\n\n“<i>Difficult to complain. This place is doing better than I’ve ever known, even going back to my grandma’s day. As long as we keep up this level of hard work and security, we’ll keep making this kinda scratch.</i>” You look at her, unsmiling, and she is momentarily thrown. “<i>It’s not.... You aren’t-? Well, the only way we’d earn more money is- but I’d never…</i>” she trails off, not looking at you.");

			dogeNotCorruptYetMenu();
			addButton(1, "", null);
		}

		private function investmentGoNotCorrupt():void
		{
			menu();
			if (player.hasKeyItem("Breast Milker - Installed At Whitney's Farm") < 0) addButton(0, "Breast Milker", investmentBreastMilkerNotCorrupt);
			if(player.hasKeyItem("Cock Milker - Installed At Whitney's Farm") < 0) addButton(1, "Cock Milker", investmentCockMilkerNotCorrupt);
			if (flags[kFLAGS.FARM_UPGRADES_REFINERY] == 0) addButton(2, "Refinery", investmentRefineryNotCorrupt);
			if (flags[kFLAGS.FARM_UPGRADES_CONTRACEPTIVE] == 0) addButton(3, "Contraceptive", investmentContraceptiveNotCorrupt);
			if (flags[kFLAGS.FARM_UPGRADES_MILKTANK] == 0) addButton(4, "MilkTank", investmentMilktankNotCorrupt);

			addButton(9, "Back", dogeNotCorruptYetMenu);
		}

		private function deFurDoge():void
		{
			clearOutput();
			whitneySprite();

			outputText("You put away the gem and move into Whitney, holding her gaze as you gently place your finger and thumb along her jaw line. She doesn’t pull away and lets out a shuddering sigh as you touch her.");

			outputText("\n\n“<i>I’m glad you have finally opened your mind to everything I can do for you, understood what our relationship truly is,</i>” you say. “<i>And I’m ready to teach you all sorts of things. However…</i>” you pinch into her muzzle very slightly and Whitney tenses, unable to tear her gaze away from your eyes. “<i>This isn’t acceptable. Walking, talking animals are an aberration in my eyes. And you know what happens to aberrations, don’t you Whitney?</i>” She doesn’t reply; she’s deep under your influence, deep under your words. “<i>But you’re a smart girl. A girl who has worked with transformatives her whole life. So I’ll come back tomorrow, and you will be different, in a more suitable form, and then we will discuss your exciting new future properly. Ok?</i>”");

			outputText("\n\n“<i>‘s,</i>” says Whitney, very quietly. You smile at her warmly, and release your grip.");

			outputText("\n\n“<i>Good girl.</i>” You turn and leave.");

			//[“Whitney” option removed from farm menu until next day]
			flags[kFLAGS.WHITNEY_DISABLED_FOR_DAY] = 1;
			flags[kFLAGS.WHITNEY_DEFURRED] = 1;

			doNext(13);
		}

		private function dontDeFurDoge():void
		{
			clearOutput();
			whitneySprite();

			outputText("“<i>I told you there was something you had to do, to demonstrate you fully understood your new reality,</i>” you say, your gaze boring into hers. Whitney’s lips begin to form words, but you ride roughshod over them. “<i>I think you know what it is.</i>” She blinks a couple of times, comprehension dawning on her face, before silently turning and heading towards her house. Whilst she is gone, you stride over to the woodpile to retrieve what you yourself will need for this.");

			outputText("\n\nWhitney pauses when she sees the hatchet resting on your shoulder; she clutches the object she holds in her own hands tighter.");

			outputText("\n\n“<i>Give it here,</i>” you say softly. Whitney is still for a while longer, her eyes fixed on the axe, and you wonder for a moment if you will have to reach for the gem again. However, with a long, shuddering sigh, she holds it out for you of her own accord. Your hands touch as you take her crossbow; she is blazing with heat.");

			outputText("\n\nYou take a moment to consider the weapon. It’s not a bad piece at all. It looks well balanced, its wood burnished, string well greased, the bolt sharp and of obvious quality- you notice it’s got ‘Tel’Adre Guard’ stamped into its handle. You carefully place it on the ground and then approach Whitney. She tenses but does not resist when you stand behind her and take her by the wrists, pushing into her firmly. You stay like that for a long time, your breath in her ear, enjoying her heat and thumping pulse against your [chest] and arms, your groin against her tight ass, waiting for her to relax. When she eventually does so, you push the hatchet into her hands. Her grip closes on the handle and with only a slight amount of resistance you push her wrists upwards with your own hands. You stop applying any force when the hatchet is hovering over her head, but maintain hold of her wrists.");

			outputText("\n\n“<i>Now... who does the farm belong to?</i>” you say quietly into her ear. Whitney is frozen in the stance you’ve steadily pushed her into for what seems like an eternity, the two of you a tableau of anticipated violence. Then, finally, with a whistling gasp, she brings the hatchet down with a splintering crash on the crossbow, hard enough that it wedges halfway into the grip.");

			outputText("\n\n“<i>You,</i>” she mumbles. She stares downwards and then uses her foot to free the blade. “<i>It belongs to you.</i>” Again you grip her wrists and raise the hatchet above her head.");

			outputText("\n\n“<i>And who am I?</i>” you murmur. A second’s pause, and the hatchet comes hurtling down. It’s a more calculated blow this time, and most of the crossbow’s handle goes flying off into the long grass.");

			outputText("\n\n“<i>[Master],</i>” she says, louder this time. “<i>You are this farm’s [master], and y-you are my [master]!</i>” You hold her tight and grind your");
			if (player.hasCock()) outputText(" crotch into");
			else outputText(" hips against");
			outputText(" her firm ass and she moans, her breath starting to come in shallow gulps, her heart beating furiously against your skin. Although you keep hold of her you don’t have to do anything to make the hatchet rise again.");

			outputText("\n\n“<i>Very good,</i>” you say, continuing to press your own hot, measured breath into her floppy ear. “<i>So if I’m the [master], what would that make you?</i>” The hatchet head is a grey streak in the air and then the string is broken, the bolt smashed and the stock dented.");

			outputText("\n\n“<i>I am... I am your slave!</i>” she cries out. “<i>I own nothing, I don’t want to own nothing i-if it means I can belong to you!</i>” She suddenly breaks free of your grasp and hurls herself with a vengeance at what remains of the weapon, howling and growling as she lifts the hatchet again and again, splintered wood flying as she destroys her old life, her last defence against you in a purging frenzy. You stand and watch the display with a broad smile. You really are too good sometimes.");

			outputText("\n\nWhen Whitney turns back to you, heaving with exertion, colour high in her face, her hair and clothes dishevelled, there’s something new in her eyes; what were once the most placid pools of hazel are now lit and marbled with a deep, red desire. You have immersed the dog girl in an atmosphere of corruption for so long it seems as if all you had to do at this point was throw the right switch.");

			outputText("\n\n“<i>Did that please [master]?</i>” she says, grinning.");

			outputText("\n\n“<i>Very much so,</i>” you reply as you continue to consider her. It occurs to you that you have caused both dominant and submissive tendencies to bubble to the surface of her psyche during her transformation; although you are now indisputably the overall master of her and her farm, in her vulnerable state now it would only take a few words and actions to make her act one way or the other towards you sexually.");

			///[Make Sub][Make Dom]
			menu();
			addButton(0, "Make Sub", makeDogeSubby);
			addButton(1, "Make Dom", makeDogeDommy);
		}

		private function makeDogeSubby():void
		{
			clearOutput();
			whitneySprite();

			outputText("You again retrieve your gem, and once more begin to rhythmically turn it; this time, however, you walk steadily towards Whitney, your voice getting louder in her ears and the shining light in her unfocused eyes getting brighter as you go on.");

			outputText("\n\n“<i>Felt good to do that, didn’t it? To do away with the idea you could stop me, to be entirely open and defenceless to me. Because you are defenceless to me now, aren’t you Whitney?</i>” As you talk, you stop rotating the jewel but continue to hold it directly in front of her eyes, whilst you place your other hand on her hip, sliding it upwards, enjoying the firm contours of your new slave.");

			outputText("\n\nShe whines as you roam far enough upwards to slip underneath the belt of her skirt and then downwards again, smoothing around her tight rump and inner thigh until you touch her labia. It is not surprising to you to find that she is dripping wet, her underclothes soaked with excitement. You gently push your fingers into the wet heat and begin to stroke her inner lips, curving upwards to find and caress her tiny clit as you continue to talk, pressing your compulsion on her as you drown her hypnotised mind in pleasure.");

			outputText("\n\n“<i>You are my bitch, and you will act like it. You will protect my property with your life, and run it to the very best of your abilities. You will put my other slaves to the lash, make them work twice as hard just so you may receive one word of praise from me. When you hear my voice, it will make you wet.");

			if (player.biggestTitSize() >= 2) outputText("\n\nWhen you see my breasts, you will want to suckle on them.");

			if (player.hasCock()) outputText("\n\nWhen you see my dick, you will want to worship it.");

			if (player.hasVagina()) outputText("\n\nWhen you see my cunt, you will want to bathe it in attention.");

			outputText("\n\nAs long as you’re a good girl, you will be my right hand here, and good girls get treats. Bad girls get punished.</i>” Whitney is panting, her eyes unable to look away from the gleaming gem as you stick two fingers into her tight hole and begin to masturbate her briskly. “<i>Now... what are you?</i>” The dog girl’s cunt spasms around your fingers deliriously, and your whole hand is soaked in a sudden gush of fluid.");

			outputText("\n\n“<i>Good... girl!</i>” manages the former farm owner between groaning breaths. You slowly take both hands away, and wait for her eyes to refocus on you.");

			outputText("\n\n“<i>Demonstrate it.</i>” Immediately Whitney sinks down on her knees before you, brown eyes looking up soulfully. You smile widely, and press your hand onto her head.");

			outputText("\n\n“<i>GOOD girl!</i>” She grins happily and her tail wags furiously as you rub her behind the ear. “<i>That’s how I expect to find you every time I come to visit. Now run along, go and make my farm spin gold. I will be along later to see if you need rewarding or punishing.</i>”");

			outputText("\n\n“<i>At once, [master]!</i>” The dog girl is on her feet and off towards the farm in one swift movement, new determination etched into her posture. Your take-over of the farm is complete; you should expect to see a larger share of the profits now Whitney is your slave taskmaster, entirely bent on serving you.");

			doNext(13);
		}

		private function makeDogeDommy():void
		{
			clearOutput();
			whitneySprite();

			outputText("You again retrieve your gem, and once more begin to rhythmically turn it. This time, however, you walk steadily towards Whitney, your voice getting louder in her ears, the shining light in her unfocused eyes getting brighter as you go on.");

			outputText("\n\n“<i>You liked doing that, didn’t you Whitney? That letting go, that burst of pure violence, passion given physical form. You always had that within you, but for some reason you chose to bury it, stifle it under a life of complete tedium. Until </i>I<i> came along. Until </i>I<i> I gave you slaves to order around and forced those desires to the surface, an unquenchable thirst to overcome and make your own.</i>”");
 
			outputText("\n\nAs you talk, you stop rotating the jewel but continue to hold it directly in front of her eyes, whilst you place your other hand on her hip, sliding it upwards, enjoying the firm contours of your new slave. The dog girl’s eyes are not unfocused this time; they are staring into the blinding light with a hard, sheer lust, her breath drawing harshly as your hand continues to move. You find your heart quickening at the prospect of what you are about to do; but the thought of fanning those embers of furious passion you have kindled within this once calm woman is too enticing to resist.");

			outputText("\n\nHer breath comes harder as you roam far enough upwards to slip underneath the belt of her skirt and then downwards again, smoothing around her tight rump and inner thigh until you touch her labia. You are not surprised to find that she is dripping wet, her underclothes soaked with excitement. You gently push your fingers into the sopping heat and begin to stroke her inner lips, curving upwards to find and caress her tiny clit as you continue to talk, pressing your compulsion on her as you drown her hypnotised mind in pleasure.");

			outputText("\n\n“<i>It’s so good that I came along and opened your mind to those sensations isn’t it, slave? And you want to thank me in any way you can, don’t you?</i>”");

			outputText("\n\n“<i>Yes,</i>” she breathes, her mouth open, unable to tear her hardened eyes away from the gem.");

			outputText("\n\n“<i>Good. Because I have use for those passions of yours. You will use them to work my other slaves twice as hard, you will put them to the lash until they beg you for mercy, and then you will do it some more just because it gives you pleasure. An absolute bitch, that’s what you will become. My bitch. The hand I use to keep my harem in line. Can you be that for me, Whitney? Are you strong enough? Or are you going to be another mewling slut I need to constantly discipline?</i>”");

			outputText("\n\n“<i>No,</i>” she says, gritting her teeth. Her breath comes ragged as you stick two fingers into her tight hole and begin to masturbate her briskly. “<i>I can be that. I want to be your right hand, I want the other slaves to cower in the dirt before me, I want to drill ‘em to better serve you. I want - I need that!</i>”");

			outputText("\n\n“<i>I will let you become that,</i>” you say softly, “<i>if you do exactly as I order.</i>”");

			outputText("\n\n“<i>Yes!</i>” You say nothing for a short while as you continue to frig her, breathing in the wild scent which permeates the air around you as you dip your fingers up to the base in her tight hole, licking and curling at her until she is panting. You speak next as you feel the urgency of impending climax grip her muscles.");

			outputText("\n\n“<i>So if,</i>” you whisper, “<i>your master ordered you to release your passions on [him], would you do that?</i>” Incomprehension wrinkles Whitney’s brow for a single moment before being replaced by a euphoric dawning of understanding, an epiphany of lust.");

			outputText("\n\n“<i>Yes,</i>” she pants, the light shining from the gem reflected back at you as hard lust, as she begins to buck her hips frantically against your hand. “<i>Gods, yes I would. I would be strong for [master]... I would become [his] taskmaster, train his cattle to the very best of my abilities... just so I could learn how to take... </i>very<i>... good care of [master]!</i>” She punctuates each growled word with thrusts against your fingers, her cunt spasming deliriously around them, and your whole hand is soaked in a sudden gush of fluid. You slowly withdraw both your hands and wait for her eyes to refocus on you. The fire there is undiminished.");

			outputText("\n\n“<i>Good,</i>” you say quietly. “<i>Because the most hardworking of " + player.mf("masters", "mistresses") + " need some R and R from time to time. A bit of private alone time, with a very trusted slave. A slave who would know not to betray the confidence placed in them, because of all the examples surrounding her of how far she could fall if she did. You following me?</i>”");

			outputText("\n\n“<i>You’ve broken something open in me I never knew existed,</i>” says Whitney fervently between ragged, sighing breaths. “<i>And then given me a life which I will goddang love every minute of. I want to use it to love you and touch you and fuck you and make you cry out in ways you never knew existed with it. It’s all I want, [master], let me show you just how much you can trust me!</i>” She is possessed by a nervous energy, her fingers twitching, as if she’s repressing an urge to grab you only with immense difficulty. You smile at her softly.");

			outputText("\n\n“<i>Later. There will be an endless later, now you have fully opened your mind to me. For now... run along, go and make my farm spin gold.</i>”");

			outputText("\n\n“<i>At once, [master]!</i>” The dog girl turns and is off towards the farm in one swift movement, new determination etched into her posture. Your take-over of the farm is complete; you should expect to see a larger share of the profits now Whitney is your slave taskmaster, entirely bent on serving you.");


			flags[kFLAGS.WHITNEY_DOM] = 1;

			doNext(13);
		}

		private function dogeCorruptedMissionComplete():void
		{

		}
	}

}