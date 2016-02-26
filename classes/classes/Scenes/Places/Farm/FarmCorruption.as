package classes.Scenes.Places.Farm
{
	import classes.GlobalFlags.kGAMECLASS;
	import classes.GlobalFlags.kFLAGS;
	import classes.Items.ConsumableLib;
	import classes.Items.Consumables.SimpleConsumable;
	import classes.ItemSlotClass;
	import classes.Scenes.Dungeons.DeepCave.EncapsulationPod;
	import classes.StatusEffects;
	
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
		
		public function corruptFollowers():int
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

		public function whitneyCorruption(mod:Number = 0):int
		{
			if (mod != 0)
			{
				flags[kFLAGS.WHITNEY_CORRUPTION] += mod;
				
				// Track highest corruption value
				if (flags[kFLAGS.WHITNEY_CORRUPTION] > flags[kFLAGS.WHITNEY_CORRUPTION_HIGHEST]) flags[kFLAGS.WHITNEY_CORRUPTION_HIGHEST] = flags[kFLAGS.WHITNEY_CORRUPTION];
			}
			
			// Cap the values into the appropriate range
			if (flags[kFLAGS.FARM_CORRUPTION_APPROACHED_WHITNEY] == 0 && flags[kFLAGS.WHITNEY_CORRUPTION] > 30 )
			{
				flags[kFLAGS.WHITNEY_CORRUPTION] = 30;
				trace("Whitney at 30 corruption clamp.");
			}
			else if (flags[kFLAGS.WHITNEY_LEAVE_0_60] == 0 && flags[kFLAGS.WHITNEY_CORRUPTION] > 60)
			{
				flags[kFLAGS.WHITNEY_CORRUPTION] = 60;
				trace("Whitney at 60 corruption clamp.");
			}
			else if (flags[kFLAGS.WHITNEY_LEAVE_61_90] == 0 && flags[kFLAGS.WHITNEY_CORRUPTION] > 90)
			{
				flags[kFLAGS.WHITNEY_CORRUPTION] = 90;
				trace("Whitney at 90 corruption clamp.");
			}
			else if (flags[kFLAGS.WHITNEY_MENU_91_119] == 0 && flags[kFLAGS.WHITNEY_CORRUPTION] > 119)
			{
				flags[kFLAGS.WHITNEY_CORRUPTION] = 119;
				trace("Whitney at 119 corruption clamp");
			}

			// Clamp values to valid min/max
			if (flags[kFLAGS.WHITNEY_CORRUPTION] < 0) flags[kFLAGS.WHITNEY_CORRUPTION] = 0;
			if (flags[kFLAGS.WHITNEY_CORRUPTION] >= 120)
			{
				flags[kFLAGS.WHITNEY_CORRUPTION] = 120;
			}

			trace("Whitney corruption changed by " + String(mod));
			trace("Whitney corruption now at " + String(flags[kFLAGS.WHITNEY_CORRUPTION]));
				
			return flags[kFLAGS.WHITNEY_CORRUPTION];
		}

		public function whitneyCorrupt():Boolean
		{
			if (flags[kFLAGS.WHITNEY_CORRUPTION_COMPLETE] > 0) return true;
			return false;
		}

		public function whitneyDom():Boolean
		{
			if (flags[kFLAGS.WHITNEY_DOM] == 1) return true;
			return false;
		}

		public function whitneyDefurred():Boolean
		{
			if (flags[kFLAGS.WHITNEY_DEFURRED] == 1) return true;
			return false;
		}

		public function whitneyHasTattoo():Boolean
		{
			if (flags[kFLAGS.WHITNEY_TATTOO_COLLARBONE] != 0) return true;
			if (flags[kFLAGS.WHITNEY_TATTOO_SHOULDERS] != 0) return true;
			if (flags[kFLAGS.WHITNEY_TATTOO_LOWERBACK] != 0) return true;
			if (flags[kFLAGS.WHITNEY_TATTOO_BUTT] != 0) return true;
			return false;
		}

		public function whitneyCockArea():Number
		{
			trace("Update cock area with values from Vapulas dildo.");
			return 10 * 2;
		}

		public function whitneyVagCapacity():Number
		{
			// Stolen from Sheila. Whitney wasn't chaste prior to corruption, so it stands to reason she'd be able to take /something/ reasonably sized given CoC standards.
			return 44;
		}

		public function whitneyMaxedOralTraining():Boolean
		{
			if (flags[kFLAGS.WHITNEY_ORAL_TRAINING] == 100) return true;
			return false;
		}

		// Called once per day, check all the followers that have been set to the farm and change whitneys corruption as appropriate
		// Also going to use this to handle Gem value updates and shit.
		public function updateFarmCorruption():int
		{
			// Early exit if we've not actually started the corruption process
			if (flags[kFLAGS.FARM_CORRUPTION_STARTED] <= 0) return flags[kFLAGS.WHITNEY_CORRUPTION];
			
			// If Whitney was disabled the previous day, set the flag for a follow up
			if (flags[kFLAGS.WHITNEY_DISABLED_FOR_DAY] == 1)
			{
				flags[kFLAGS.WHITNEY_DISABLED_FOR_DAY] = 2;
			}

			// Process queued farm upgrades

			// Breastmilkers
			if (flags[kFLAGS.QUEUE_BREASTMILKER_UPGRADE] != 0 && player.hasKeyItem("Breast Milker - Installed At Whitney's Farm") < 0)
			{
				flags[kFLAGS.QUEUE_BREASTMILKER_UPGRADE] = 0;
				player.createKeyItem("Breast Milker - Installed At Whitney's Farm", 0, 0, 0, 0);
			}

			// Cockmilkers
			if (flags[kFLAGS.QUEUE_COCKMILKER_UPGRADE] != 0 && player.hasKeyItem("Cock Milker - Installed At Whitney's Farm") < 0)
			{
				flags[kFLAGS.QUEUE_COCKMILKER_UPGRADE] = 0;
				player.createKeyItem("Cock Milker - Installed At Whitney's Farm", 0, 0, 0, 0);
			}

			// Contraceptives
			if (flags[kFLAGS.QUEUE_CONTRACEPTIVE_UPGRADE] != 0)
			{
				flags[kFLAGS.QUEUE_CONTRACEPTIVE_UPGRADE]++;

				if (flags[kFLAGS.QUEUE_CONTRACEPTIVE_UPGRADE] > 7)
				{
					flags[kFLAGS.FARM_UPGRADES_CONTRACEPTIVE] = 1;
					flags[kFLAGS.QUEUE_CONTRACEPTIVE_UPGRADE] = 0;
				}
			}

			// Refinery
			if (flags[kFLAGS.QUEUE_REFINERY_UPGRADE] != 0)
			{
				flags[kFLAGS.QUEUE_REFINERY_UPGRADE]++;

				if (flags[kFLAGS.QUEUE_REFINERY_UPGRADE] > 3)
				{
					flags[kFLAGS.FARM_UPGRADES_REFINERY] = 1;
					flags[kFLAGS.QUEUE_REFINERY_UPGRADE] = 0
				}
			}

			// Milktank
			if (flags[kFLAGS.QUEUE_MILKTANK_UPGRADE] != 0)
			{
				flags[kFLAGS.QUEUE_MILKTANK_UPGRADE]++;

				if (flags[kFLAGS.QUEUE_MILKTANK_UPGRADE] > 3)
				{
					flags[kFLAGS.QUEUE_MILKTANK_UPGRADE] = 0;
					flags[kFLAGS.FARM_UPGRADES_MILKTANK] = 1;

					flags[kFLAGS.FOLLOWER_AT_FARM_BATH_GIRL] = 1;
					flags[kFLAGS.MILK_SIZE] = 0;
				}
			}

			// Branding
			if (flags[kFLAGS.QUEUE_BRANDING_UPGRADE] != 0)
			{
				flags[kFLAGS.QUEUE_BRANDING_UPGRADE]++

				if (flags[kFLAGS.QUEUE_BRANDING_UPGRADE] > 2)
				{
					flags[kFLAGS.QUEUE_BRANDING_UPGRADE] = 0;
					flags[kFLAGS.FARM_CORRUPTION_BRANDING_MENU_UNLOCKED] = 1;
					flags[kFLAGS.QUEUE_BRANDING_AVAILABLE_TALK] = 1;
				}
			}

			// Orgyroom
			if (flags[kFLAGS.QUEUE_ORGYROOM_UPGRADE] != 0)
			{
				flags[kFLAGS.QUEUE_ORGYROOM_UPGRADE]++;

				if (flags[kFLAGS.QUEUE_ORGYROOM_UPGRADE] > 7)
				{
					flags[kFLAGS.QUEUE_ORGYROOM_UPGRADE] = 0;
					flags[kFLAGS.FARM_UPGRADES_ORGYROOM] = 2;
				}
			}

			// Figure out how much corruption we're going to slap on to Whitney
			var modValue:Number = -1;

			if (flags[kFLAGS.FOLLOWER_AT_FARM_AMILY] == 1) modValue += 2;
			if (flags[kFLAGS.FOLLOWER_AT_FARM_JOJO] == 1) modValue += 2;
			if (flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 1 && kGAMECLASS.sophieBimbo.bimboSophie()) modValue += 1;
			// Izmael if (flags[kFLAGS.FOLLOWER_AT_FARM_IZMA] == 1) modValue += 1;
			// Bimbo if (flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 1) modValue += 2;
			if (flags[kFLAGS.FOLLOWER_AT_FARM_VAPULA] == 1) modValue += 4;
			if (flags[kFLAGS.FOLLOWER_AT_FARM_LATEXY] == 1) modValue += 1;
			if (flags[kFLAGS.FOLLOWER_AT_FARM_HOLLI] > 0)
			{
				modValue += 4;
			}
			if (flags[kFLAGS.FOLLOWER_AT_FARM_KELLY] == 1) modValue += 2;

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
				if (kGAMECLASS.jojoScene.tentacleJojo()) flags[kFLAGS.FARM_INCUDRAFT_STORED]++;
			}
			
			// If Sophie is producing, count up time since last egg and gib a new one when ready
			if (flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] > 0 && flags[kFLAGS.FOLLOWER_PRODUCTION_SOPHIE] == 1)
			{
				if (flags[kFLAGS.FARM_EGG_STORED] == 0)
				{
					flags[kFLAGS.FARM_EGG_COUNTDOWN]--;
					
					if (flags[kFLAGS.FARM_EGG_COUNTDOWN] == 0)
					{
						flags[kFLAGS.FARM_EGG_STORED] = 1;
						flags[kFLAGS.FARM_EGG_COUNTDOWN] = 7;
					}
				}
			}
			
			// If Vapula is producing, stack up some milks to gib
			if (flags[kFLAGS.FOLLOWER_AT_FARM_VAPULA] == 1 && flags[kFLAGS.FOLLOWER_PRODUCTION_VAPULA] == 1)
			{
				flags[kFLAGS.FARM_SUCCUMILK_STORED]++;
				if (flags[kFLAGS.FARM_UPGRADES_REFINERY] == 1) flags[kFLAGS.FARM_SUCCUMILK_STORED]++;
				
				if (flags[kFLAGS.FOLLOWER_AT_FARM_VAPULA_GIBS_MILK] == 0) flags[kFLAGS.FOLLOWER_AT_FARM_VAPULA_GIBS_MILK] = 1;
			}
			
			// Item caps
			if (flags[kFLAGS.FARM_SUCCUMILK_STORED] > 5)
			{
				flags[kFLAGS.FARM_CORRUPTION_GEMS_WAITING] += (flags[kFLAGS.FARM_SUCCUMILK_STORED] - 5) * 3; // 3 extra gems per succumilk
				flags[kFLAGS.FARM_SUCCUMILK_STORED] = 5;
			}
			if (flags[kFLAGS.FARM_INCUDRAFT_STORED] > 5)
			{
				flags[kFLAGS.FARM_CORRUPTION_GEMS_WAITING] += (flags[kFLAGS.FARM_INCUDRAFT_STORED] - 5) * 5; // 5 extra gems per incudraft (less of them produced etc)
				flags[kFLAGS.FARM_INCUDRAFT_STORED] = 5;
			}
			
			// If Latexy is at the farm, further modify her status values
			if (flags[kFLAGS.FOLLOWER_AT_FARM_LATEXY] == 1)
			{
				kGAMECLASS.latexGirl.gooHappiness( -0.5, false);
				kGAMECLASS.latexGirl.gooObedience(  0.5, false);
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
				outputText("You stroll over to the big rock at the edge of the pepper patch, smiling as you see a small burlap sack shoved underneath a fold in the stone. You scoop it up, open it and count out " + flags[kFLAGS.FARM_CORRUPTION_GEMS_WAITING] + " gems.\n\n");
				
				if (farmValue() < 25) outputText(" You frown; it seems like a feeble amount for such a large operation. Perhaps you could talk to Whitney about that.\n\n");
				
				player.gems += flags[kFLAGS.FARM_CORRUPTION_GEMS_WAITING];
				flags[kFLAGS.FARM_CORRUPTION_GEMS_WAITING] = 0;
				flags[kFLAGS.FARM_CORRUPTION_DAYS_SINCE_LAST_PAYOUT] = 0;
				kGAMECLASS.showStats();
			}
			
			if (flags[kFLAGS.FARM_SUCCUMILK_STORED] > 0 || flags[kFLAGS.FARM_INCUDRAFT_STORED] > 0 || flags[kFLAGS.FARM_EGG_STORED] > 0 || flags[kFLAGS.FARM_CONTRACEPTIVE_STORED] > 0)
			{
				outputText("Your ‘farmers’ have been busy under the watchful eye of their assigned task mistress. A small bundle of goods have been stashed with the gems just awaiting your arrival.\n\n");
			}
			
			menu();
			
			if (flags[kFLAGS.FARM_SUCCUMILK_STORED] > 0)
			{
				outputText("<b>" + flags[kFLAGS.FARM_SUCCUMILK_STORED] + "x ");
				if (flags[kFLAGS.FARM_SUCCUMILK_STORED] == 1) outputText("vial of Succubi milk.");
				else outputText("vials of Succubi milk.");
				outputText("</b>\n");
				addButton(0, getItemObj(kFLAGS.FARM_SUCCUMILK_STORED).shortName, takeItems, kFLAGS.FARM_SUCCUMILK_STORED);
			}
			if (flags[kFLAGS.FARM_INCUDRAFT_STORED] > 0)
			{
				outputText("<b>" + flags[kFLAGS.FARM_INCUDRAFT_STORED] + "x ");
				if (flags[kFLAGS.FARM_INCUDRAFT_STORED] == 1) outputText("vial of Incubi draft.");
				else outputText("vials of Incubi draft.");
				outputText("</b>\n");
				addButton(1, getItemObj(kFLAGS.FARM_INCUDRAFT_STORED).shortName, takeItems, kFLAGS.FARM_INCUDRAFT_STORED);
			}
			if (flags[kFLAGS.FARM_EGG_STORED] > 0)
			{
				outputText("<b>" + flags[kFLAGS.FARM_EGG_STORED] + "x ");
				outputText("large " + flags[kFLAGS.FOLLOWER_PRODUCTION_SOPHIE_COLORCHOICE] + " egg");
				if (flags[kFLAGS.FARM_EGG_STORED] > 1) outputText("s");
				outputText(".");
				outputText("</b>\n");
				addButton(2, getItemObj(kFLAGS.FARM_EGG_STORED).shortName, takeItems, kFLAGS.FARM_EGG_STORED);
			}
			if (flags[kFLAGS.FARM_CONTRACEPTIVE_STORED] > 0)
			{
				outputText("<b>" + flags[kFLAGS.FARM_CONTRACEPTIVE_STORED] + "x ");
				outputText("bundle of Herbal Contraceptive.");
				outputText("</b>\n");
				addButton(3, getItemObj(kFLAGS.FARM_CONTRACEPTIVE_STORED).shortName, takeItems, kFLAGS.FARM_CONTRACEPTIVE_STORED);
			}
			
			addButton(14, "Back", rootScene);
		}
		
		private function getItemObj(flag:int):SimpleConsumable
		{
			if (flag == kFLAGS.FARM_SUCCUMILK_STORED) return consumables.SUCMILK;
			if (flag == kFLAGS.FARM_INCUDRAFT_STORED) return consumables.INCUBID;
			if (flag == kFLAGS.FARM_EGG_STORED) return kGAMECLASS.sophieBimbo.eggTypes[kGAMECLASS.sophieBimbo.eggColors.indexOf(flags[kFLAGS.FOLLOWER_PRODUCTION_SOPHIE_COLORCHOICE])];
			if (flag == kFLAGS.FARM_CONTRACEPTIVE_STORED) return consumables.HRBCNT;
			
			trace("No valid argument given.");
			return null;
		}
		
		private function takeItems(flag:int):void
		{
			var item:SimpleConsumable = getItemObj(flag);
			
			if (flag == kFLAGS.FARM_EGG_STORED) flags[kFLAGS.FARM_EGG_COUNTDOWN] = 7;
			flags[flag]--;
			inventory.takeItem(item, afterTakeItems);
		}
		
		private function afterTakeItems():void {
			if (collectionAvailable())
				collectTheGoodies();
			else rootScene();
		}

		public function farmProtection():int
		{
			var protection:int = 0;

			if (flags[kFLAGS.FOLLOWER_AT_FARM_AMILY] == 1) protection += 1;

			if (flags[kFLAGS.FOLLOWER_AT_FARM_JOJO] == 1) protection += 2;

			if (flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 1)
			{
				if (kGAMECLASS.sophieBimbo.bimboSophie()) protection += 1;
				else protection += 2;
			}

			if (flags[kFLAGS.FOLLOWER_AT_FARM_IZMA] == 1)
			{
				protection += 4;
				// Izmael = 5
			}

			if (flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 1)
			{
				protection += 3;
				// Bimbo = 2
			}

			if (flags[kFLAGS.FOLLOWER_AT_FARM_VAPULA] == 1) protection += 2;

			if (flags[kFLAGS.FOLLOWER_AT_FARM_KELLY] == 1)
			{
				if (flags[kFLAGS.KELT_BREAK_LEVEL] >= 4) protection += 1;
				else protection += 2;
			}

			if (flags[kFLAGS.FOLLOWER_AT_FARM_MARBLE] == 1) protection += 2;

			if (flags[kFLAGS.FOLLOWER_AT_FARM_BATH_GIRL] == 1)
			{
				if (flags[kFLAGS.MILK_SIZE] > 0) protection += 1;
			}
			
			if (flags[kFLAGS.FOLLOWER_AT_FARM_CERAPH] > 0) protection += 7;

			return protection;
		}

		public function farmValue():int
		{
			var fValue:int = 0;

			if (flags[kFLAGS.FOLLOWER_AT_FARM_AMILY] == 1) fValue += 3;
			if (flags[kFLAGS.FOLLOWER_AT_FARM_JOJO] == 1) fValue += 2;

			if (flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 1)
			{
				if (kGAMECLASS.sophieBimbo.bimboSophie()) fValue += 4;
				else fValue += 3;
			}

			if (flags[kFLAGS.FOLLOWER_AT_FARM_IZMA] == 1) fValue += 1;

			if (flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 1) fValue += 3;

			if (flags[kFLAGS.FOLLOWER_AT_FARM_VAPULA] == 1) fValue += 1;

			if (flags[kFLAGS.FOLLOWER_AT_FARM_LATEXY] == 1) fValue += 2;

			if (flags[kFLAGS.FOLLOWER_AT_FARM_KELLY] == 1)
			{
				if (flags[kFLAGS.KELT_BREAK_LEVEL] >= 4) fValue += 1;
			}

			if (flags[kFLAGS.FOLLOWER_AT_FARM_MARBLE] == 1) fValue += 2;

			if (flags[kFLAGS.FOLLOWER_AT_FARM_BATH_GIRL] == 1)
			{
				if (flags[kFLAGS.MILK_SIZE] > 0) fValue += 3;
				else fValue += 7;
			}

			if (flags[kFLAGS.WHITNEY_CORRUPTION_COMPLETE] == 1) fValue *= 1.25;
			return fValue;
		}
		
		public function takeoverPrompt():Boolean
		{
			if (flags[kFLAGS.FARM_CORRUPTION_DISABLED] == 1) return false;
			if (flags[kFLAGS.FARM_CORRUPTION_STARTED] == 1)
			{
				farmMenu();
				return true; // Hook the corrupt menu here
			}
			
			if (player.cor >= 70 && corruptFollowers() >= 2 && player.level >= 12)
			{
				if (flags[kFLAGS.FARM_CORRUPT_PROMPT_DISPLAY] == 0)
				{	
					clearOutput();
					if (flags[kFLAGS.KELT_BREAK_LEVEL] >= 4)
					{
						takeoverPromptKelly();
					}
					else if (player.findStatusEffect(StatusEffects.MarbleRapeAttempted) >= 0)
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
				else if (flags[kFLAGS.FARM_CORRUPT_PROMPT_DISPLAY] == 3 || flags[kFLAGS.FARM_DISABLED] == 1)
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
				outputText("\n\nYou let your anger grow and then rage like a wildfire through you, coursing through your veins; increasingly these days, you are finding that your passion allows you to think clearer, to better fuel your muse. There’s potential in this farm, you can see that, you could turn it to your own purposes, but of course, the narrow minded bitch in the field below will never realize it herself. You will have to go down and put her in her place first. The only question is, now or later?");
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
		
		public function takeoverPromptNow():void
		{
			clearOutput();
			
			outputText("You stride down to the farm and leap over a gate. You move casually, swaggering towards the pepper field with no obvious intent. When Whitney spots you and slowly stands up from her weeding, you raise your hand in friendly greeting"); 
			if (player.weaponName != "fists") outputText(", and to demonstrate your peacefulness, you theatrically hold up your [weapon] and then discard it with a careless swing of your arm.");
			else outputText(".");

			// if PC has Kelly or PC raped Marble
			if (flags[kFLAGS.KELT_BREAK_LEVEL] >= 4 || player.findStatusEffect(StatusEffects.MarbleRapeAttempted) >= 0)
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
			else if (player.findStatusEffect(StatusEffects.MarbleRapeAttempted) >= 0)
			{
				outputText("\n\n“<i>Cute. But, you know, Marble had a hammer which made that thing look like a peashooter. She practiced with it every day. To protect your farm, I believe?</i>” You pause and look her dead in the eye. “<i>If I remember right, after I finished with her, she was a whimpering mess. How well has she been fighting since, because the way I see it, there isn’t much protecting your farm these days. Just about anyone could walk in here and do as they please. As you sleep, perhaps? Quietly taint your food whilst you work? Are you really going to hold onto that crossbow for the rest of your life?</i>” Whitney’s grip is trembling slightly, you can see it in the bolt and string.");
			}
			else
			{
				outputText("\n\n“<i>Cute. But I’ve fought things that had dicks which looked deadlier than that thing.</i>” You pause and look her dead in the eye. “<i>I’ve fought a lot of things since I arrived here, Whitney. Crushed a lot of things underneath my heel. All of Mareth is coming to understand that if you are not useful to me, you are broken and remade so that you </i>are<i>. It would be a damn shame if something like that happened to you because you wouldn’t see sense. After all, just about anyone could walk in here and do as they please, as you sleep, perhaps? Quietly taint your food whilst you work? Are you really going to hold onto that crossbow for the rest of your life?</i>” Whitney’s grip is trembling slightly, you can see it in the bolt and string.");
			}

			outputText("\n\n“<i>What do you want?</i>” she growls in a strangled voice.");

			outputText("\n\n“<i>All I want is to... maximize this farm’s productivity. There’s a lot of slack around here that needs picking up, if you ask me.</i>” You put your hands behind your back and begin to slowly pace back and forth in the pepper patch. She’s still pointing the crossbow, but the arrow’s barb is getting increasingly erratic. “<i>You will let me use the farm as I please. I will send... help... to you, as I see fit. In return, I guarantee that I will not make any attempts on your person, and I guarantee that no harm will come to your farm.</i>” The barb trembles for a while longer. ");

			// if PC has Kelly or PC raped Marble
			if (flags[kFLAGS.KELT_BREAK_LEVEL] >= 4 || player.findStatusEffect(StatusEffects.MarbleRapeAttempted) >= 0)
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
				if (player.findStatusEffect(StatusEffects.MarbleRapeAttempted) < 0 && player.findStatusEffect(StatusEffects.NoMoreMarble) < 0)
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

				outputText("\n\nYou have to admit, it’s going to be plenty painful if she fires her crossbow at you, so much so that you don’t know what will happen afterwards; an image of an inferno consuming a barn flits through your mind. After what seems like an hour of deliberation, though, Whitney lowers the weapon.");

				outputText("\n\n“<i>Alright. Alright, maybe you got me, stranger. I don’t have eyes in the back of my head, so maybe I do need... insurance.</i>” She spits the last word. “<i>Just so long as you stay the fuck away from me, I will do as you say.</i>” You beam.");
			}

			outputText("\n\n“<i>Smart decision. I’ll send along help to you as soon as I can. I look forward to a long and prosperous business relationship with you.</i>” You bow deeply, turn and move almost all the way to the gate before raising a finger.");
			
			outputText("\n\n“<i> Oh, just one more thing. I will be expecting a cut. Seeing as how I’m invested in your little operation now and all. Shall we say 20 % ? If you cannot bear giving me the money yourself, just leave it underneath the rock over yonder every week. Do that and we won’t have any... problems.</i>” You smirk at her.");
			
			outputText("\n\nShe looks at you as if she’s never seen you before in her life, incapable of words. “<i>I guess that’s settled then. Always a pleasure talking to you, Whitney.</i>” You throw your [hips] out in an exaggerated swagger as you slowly make your way back to camp, knowing the dog morph’s eyes will follow you until you disappear into the distance.");

			flags[kFLAGS.FARM_CORRUPTION_STARTED] = 1;
			
			if (player.findStatusEffect(StatusEffects.NoMoreMarble) < 0) flags[kFLAGS.FOLLOWER_AT_FARM_MARBLE] = 0; // Don't have to care about recruitment paths -- she'll fuck off based on corruption before the player can corrupt the farm.
			
			doNext(camp.returnToCampUseOneHour);
		}
		
		protected function takeoverPromptLater():void
		{
			clearOutput();
			
			outputText("You stare for a moment longer, then turn and head back to camp. You will show mercy she does not deserve... for now.");
			
			doNext(camp.returnToCampUseOneHour);
		}
		
		protected function takeoverPromptNever():void
		{
			clearOutput();
			flags[kFLAGS.FARM_CORRUPTION_DISABLED] = 1;
			
			outputText("You close your eyes and take deep, shuddering breaths, drawing in the sweet, grass scented air and listening to the quiet, gentle peace which surrounds this place. The putrid ideas and viciously colorful images crowding your mind fade bit by bit, your blood cools and slowly, eventually, you find inner tranquility.  You promise yourself that come what may you’ll never do anything to this patch of peace you found in this world so long ago, if only as a reminder of what you once were. A heavy lump gathering in your throat, you turn and leave.");
 
			// (Option never displayed again, -5 Corruption)
			dynStats("cor-", 5);
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function rootScene():void
		{
			clearOutput();
			spriteSelect(62);
			
			if (flags[kFLAGS.WHITNEY_DISABLED_FOR_DAY] == 2)
			{
				flags[kFLAGS.WHITNEY_DISABLED_FOR_DAY] = 3;

				outputText("“<i>[name]? [name]!</i>” You turn and watch Whitney shyly step out from the shadow of the barn. She has retained her slim frame and modest clothes, however her fur is all gone and has been replaced by skin of the same sandy color. Human feet peek out from underneath her skirt, and... well. You take a few moments to drink in her human face, still quintessentially Whitney in her long, delicate features, thin but easy smile and rosy color accentuating her high cheekbones; pretty but not beautiful. The only dog features she has kept are her floppy ears and short, perky tail. Scratch that; as you smile approvingly she smiles widely in return, laughing almost in relief, revealing quite pointed teeth and a thinner-than-normal tongue. Still, it’s a pretty decent effort all round.");

				outputText("\n\n“<i>Very good girl,</i>” you say. You slowly approach her. “<i>Such swiftness and willingness to change is an excellent sign. You and I will go very far together indeed.</i>” Again you stand directly in front of her, again you stare deep into her brown eyes; you wait until her breath comes shallow once more. “<i>Now, where were we?</i>”");

				doNext(dontDeFurDoge);
				return;
			}

			// Whitney not corrupt
			if (!whitneyCorrupt())
			{
				outputText("You stand on the rise you’ve taken to using to look down on the farm which you are invested in.")
				
				if (flags[kFLAGS.FARM_UPGRADES_REFINERY] == 1) outputText(" A large machine, bulky and rotund with a conical top, has been built into the milking barn. Fat pipes crawl up onto the roof from it like metal ivy, and white smoke billows busily out of its whistle chimney.");
				
				if (flags[kFLAGS.FARM_UPGRADES_CONTRACEPTIVE] == 1) outputText(" Next to the pepper patch another crop has been planted, a field of verdant green shrubs. Their thin stems bob idly in the breeze.");

				if (flags[kFLAGS.QUEUE_ORGYROOM_UPGRADE] > 1)
				{
					outputText("\n\nIt looks as if Whitney has been doing some major renovation work in and around her farmhouse. The window to her front room has been taken out, white sheets have been draped over everything and by the look of the narrow pits she’s dug it looks as if she’s putting in some plumbing. Whatever she’s building it’s still a work in progress.")
				}
			}
			else
			{
				outputText("You stand on your rise and take in your slave farm. ");
				if (silly())
				{
					outputText(player.mf("You feel an irresistible hankering for a cigar.", "You feel an irresistible hankering for a cigarette holder."));
				}
				if (flags[kFLAGS.FARM_UPGRADES_REFINERY] == 1) outputText(" A large machine, bulky and rotund with a conical top, has been built into the milking barn. Fat pipes crawl up onto the roof from it like metal ivy, and white smoke billows busily out of its whistle chimney.");
				if (flags[kFLAGS.FARM_UPGRADES_CONTRACEPTIVE] == 1) outputText(" Next to the pepper patch another crop has been planted, a field of verdant green shrubs. Their thin stems bob idly in the breeze.");
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
			if (flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 1 && kGAMECLASS.sophieBimbo.bimboSophie())
			{
				outputText("\n\nYou cannot see Sophie but distinctive coos and giggles are coming from the hen coop.");
			}
			
			// Regular Sophie
			if (flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 1 && !kGAMECLASS.sophieBimbo.bimboSophie())
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
			
			if (flags[kFLAGS.WHITNEY_DISABLED_FOR_DAY] != 1)
			{
				if (!whitneyCorrupt()) addButton(0, "Whitney", dogeNotCorruptYet);
				else addButton(0, "Whitney", dogeCorruptedMissionComplete);
			}
			
			if (player.findStatusEffect(StatusEffects.MarbleRapeAttempted) < 0 && player.findStatusEffect(StatusEffects.NoMoreMarble) < 0 && player.findStatusEffect(StatusEffects.Marble) >= 0 && flags[kFLAGS.MARBLE_WARNING] == 0) addButton(1, "Marble", farm.meetMarble);
			
			if (player.findStatusEffect(StatusEffects.Kelt) >= 0 && player.findStatusEffect(StatusEffects.KeltOff) < 0)
			{
				if (flags[kFLAGS.KELT_BREAK_LEVEL] >= 4) addButton(2, "Kelly", farm.kelly.breakingKeltOptions);
				else if (flags[kFLAGS.KELT_BREAK_LEVEL] == 0 && flags[kFLAGS.KELT_TALKED_FARM_MANAGEMENT] == 0) addButton(2, "Kelt", keltAChangeInManagement);
				else addButton(2, "Kelt", farm.kelly.breakingKeltOptions);
			}
			
			if (player.hasKeyItem("Breast Milker - Installed At Whitney's Farm") >= 0) 
			{
				if (player.findStatusEffect(StatusEffects.Milked) >= 0) 
				{
					outputText("\n\n<b>Your " + player.nippleDescript(0) + "s are currently too sore to be milked.  You'll have to wait a while.</b>", false);
				}
				
				addButton(3,"Get Milked", farm.getMilked);
			}
			
			if (player.hasKeyItem("Cock Milker - Installed At Whitney's Farm") >= 0 && player.cockTotal() > 0)
			{
				addButton(4,"Milk Cock", farm.cockPumping);
			}
			
			addButton(5, "Farm", corruptingTheFarmExplore);
			
			if (slavesAtFarm()) addButton(6, "Slaves", slavesAtFarmMenu);
			if (loversAtFarm()) addButton(7, "Lovers", loversAtFarmMenu);
			if (followersAtFarm()) addButton(8, "Followers", followersAtFarmMenu);
			
			addButton(14, "Leave", camp.returnToCampUseOneHour);
		}
		
		private function corruptingTheFarmExplore():void
		{
			menu();
			
			addButton(0, "Explore", farm.exploreFarm);
			addButton(1, "Work", farm.workFarm);
			
			if (flags[kFLAGS.FARM_CORRUPTION_DAYS_SINCE_LAST_PAYOUT] >= 7 || flags[kFLAGS.FARM_SUCCUMILK_STORED] > 0 || flags[kFLAGS.FARM_INCUDRAFT_STORED] > 0 || flags[kFLAGS.FARM_EGG_STORED] > 0 || flags[kFLAGS.FARM_CONTRACEPTIVE_STORED] > 0) addButton(2, "Collect", collectTheGoodies);
			
			addButton(14, "Back", farmMenu);
		}
		
		public function collectionAvailable():Boolean
		{
			if (flags[kFLAGS.FARM_CORRUPTION_DAYS_SINCE_LAST_PAYOUT] >= 7) return true;
			if (flags[kFLAGS.FARM_SUCCUMILK_STORED] > 0) return true;
			if (flags[kFLAGS.FARM_INCUDRAFT_STORED] > 0) return true;
			if (flags[kFLAGS.FARM_EGG_STORED] > 0) return true;
			if (flags[kFLAGS.FARM_CONTRACEPTIVE_STORED] > 0) return true;
			return false;
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
			flags[kFLAGS.FOLLOWER_AT_FARM_KELLY] = 1;
			
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function numSlavesAtFarm():int
		{
			var count:int = 0;

			if (flags[kFLAGS.FOLLOWER_AT_FARM_AMILY] == 1) count++;
			if (flags[kFLAGS.FOLLOWER_AT_FARM_JOJO] == 1) count++;
			if (flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 1 && kGAMECLASS.sophieBimbo.bimboSophie()) count++;
			if (flags[kFLAGS.FOLLOWER_AT_FARM_VAPULA] == 1) count++;
			if (flags[kFLAGS.FOLLOWER_AT_FARM_LATEXY] == 1) count++;
			if (flags[kFLAGS.FOLLOWER_AT_FARM_BATH_GIRL] == 1) count++;

			return count;
		}

		private function slavesAtFarm():Boolean
		{
			if (numSlavesAtFarm() > 0) return true;
			return false;
		}

		private function slavesAtFarmMenu():void
		{
			menu();
			
			if (flags[kFLAGS.FOLLOWER_AT_FARM_AMILY] == 1) addButton(0, "Amily", kGAMECLASS.amilyScene.amilyFollowerEncounter);
			
			if (flags[kFLAGS.FOLLOWER_AT_FARM_JOJO] == 1) addButton(1, "Jojo", kGAMECLASS.jojoScene.corruptCampJojo);
			
			if (flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 1 && kGAMECLASS.sophieBimbo.bimboSophie()) addButton(2, "Sophie", kGAMECLASS.sophieBimbo.approachBimboSophieInCamp);
			
			if (flags[kFLAGS.FOLLOWER_AT_FARM_VAPULA] == 1) addButton(3, "Vapula", kGAMECLASS.vapula.callSlaveVapula);
			
			if (flags[kFLAGS.FOLLOWER_AT_FARM_LATEXY] == 1) addButton(4, flags[kFLAGS.GOO_NAME], kGAMECLASS.latexGirl.approachLatexy);
			
			if (flags[kFLAGS.FOLLOWER_AT_FARM_BATH_GIRL] == 1) addButton(5, flags[kFLAGS.MILK_NAME], kGAMECLASS.milkWaifu.milkyMenu);
			
			addButton(14, "Back", farmMenu);
		}
		
		private function numFollowersAtFarm():int
		{
			var count:int = 0;

			if (flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 1 && !kGAMECLASS.sophieBimbo.bimboSophie()) count++;

			return count;
		}

		private function followersAtFarm():Boolean
		{
			if (numFollowersAtFarm() > 0) return true;
			return false;
		}

		private function followersAtFarmMenu():void
		{
			menu();
			
			if (flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 1 && !kGAMECLASS.sophieBimbo.bimboSophie()) addButton(0, "Sophie", kGAMECLASS.sophieFollowerScene.followerSophieMainScreen);
			
			addButton(14, "Back", farmMenu);
		}
		
		private function numLoversAtFarm():int
		{
			var count:int = 0;

			if (flags[kFLAGS.FOLLOWER_AT_FARM_IZMA] > 0) count++;
			if (flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] > 0) count++;

			return count;
		}

		private function loversAtFarm():Boolean
		{
			if (numLoversAtFarm() > 0) return true;
			return false;
		}

		private function loversAtFarmMenu():void
		{
			menu();
			
			if (flags[kFLAGS.FOLLOWER_AT_FARM_IZMA] == 1) addButton(0, "Izma", kGAMECLASS.izmaScene.izmaFollowerMenu);
			if (flags[kFLAGS.FOLLOWER_AT_FARM_IZMA] == 2) addButton(0, "Izmael", kGAMECLASS.gameOver);
			
			if (flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 1) addButton(1, "Isabella", kGAMECLASS.isabellaFollowerScene.callForFollowerIsabella);
			
			addButton(14, "Back", farmMenu);
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
				else doNext(camp.returnToCampUseOneHour);

				return;
			}

			// 0-30 Farm Corruption
			if (whitneyCorruption() <= 30)
			{
				flags[kFLAGS.FARM_CORRUPTION_APPROACHED_WHITNEY] = 1;
				outputText("You find Whitney sat in the cow field, hand milking one of her herd; her crossbow is propped up against a bucket. As you approach, she looks up sharply before slowly reaching for the weapon. You stop in your tracks, and she stops in kind, her hand frozen on the grip. You take a step forward and she picks it up, her finger finding the trigger, her expression entirely emotionless. You take several hasty steps back, she puts it down and goes back to milking peacefully.");

				outputText("\n\nYou wave in exasperation and leave; if that’s the way she wants it. If she’s working with you and your followers for any length of time, she’ll have to loosen up eventually.");

				if (flags[kFLAGS.WHITNEY_LEAVE_0_60] == 0) doNext(dogeNotCorruptLeaveFirstTime);
				else doNext(camp.returnToCampUseOneHour);

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

			if (whitneyCorruption() >= 91 && whitneyCorruption() <= 119)
			{
				// 91-119 Farm Corruption
				if (flags[kFLAGS.WHITNEY_MENU_91_119] == 0)
				{
					flags[kFLAGS.WHITNEY_MENU_91_119] = 1;

					outputText("There is a sultry atmosphere around the farm these days. The air feels warmer than it should and the breeze which curls over the fields carries with it a musky, enticing perfume which presses irresistibly into your nose and the back of your throat. When you find Whitney on her porch you can’t help but think she looks considerably more relaxed than she has done of late; perhaps it’s just too hard to remain tense in these conditions. ");

					outputText("\n\n“<i>Yes, [name],</i>” she says, so softly you can barely hear her. “<i>What can I do for you?</i>” Cautiously, you ask her how she feels about the changes you have made around the farm.");

					outputText("\n\n“<i>You were right,</i>” she says, again in that incredibly low voice, before clearing her throat and going on in a louder tone, the words spilling out of her. “<i>I hated you when you first came here demanding a share of the farm, more than anything I’ve ever hated in a long time. Someone taking control of my family’s farm, what I had worked on for all these years, through what seemed to me like pure vindictiveness... I fantasized about killing you, didja know that? Shooting you through the neck when you were tendin’ to something else. The only thing that stopped me I think was fear: fear that you were so powerful that you’d survive it somehow. How miserable I was back then... but at some point I just said fuck it, you know? If I couldn’t work up the courage to fight you, what was the point in stayin’ miserable and angry the whole time? And the more I let go of it...</i>”");

					outputText("\n\nAs she talks, you delve into your pocket and bring out a gem, this time with deliberate slowness. Whitney’s eyes are immediately drawn to it and she pauses; you softly motion for her to continue, slowly turning the small, glittering kaleidoscope in your fingers as you do. “<i>...It’s just so much more </i>fun<i> around here these days. The farm feels like it’s alive, I am makin so much more money and... the more I open my mind, the more I let go of those old hates, the more I can think, the more I can feel. Gods, I am feeling things I haven’t in years. I see the way you order your followers around and it feels powerful, I make them do as I will and it feels right, like I’m taking control and shaping the world instead of just layin' back and watchin' it pass me by. It feels like... like...</i>”");

					outputText("\n\n“<i>Like you’re waking up,</i>” you say. You twist the gem back and forth, shining tiny, scattering beams of blinding light into the dog morph’s eyes. Her mouth hangs open and her breath is shallow. “<i>Like since I’ve taken control you’ve woken up to everything that life has to offer, everything that </i>I<i> have to offer, the horizons that appear when you submit to my will. This farm is many times the place it was when you were closed up in your old life of petty certainties. You just told me that and like the farm, </i>you<i> are becoming more and more real the further you open yourself to me.</i>”");

					outputText("\n\nYou think the doggie is close now, so very close to fully opening her mind and entirely tasting reality. All she needs to do is one thing to demonstrate her commitment...");

					outputText("\n\n“<i>What is that,</i>” says Whitney dully. You smile, gently bringing the twisting gem to a halt and putting it back into your pouch. You will know what that is when you are truly ready, you say. With that you turn and leave her, swaying vaguely on the porch, her eyes far, far away. As long as you can keep her immersed in the atmosphere you’ve conjured up over the farm, you think she’ll be ready for the final stage of your plan soon enough.");
					doNext(rootScene);
					return;
				}
				else
				{
					// Subsequent 91-119: 
					outputText("Whitney lays down her work eagerly as you approach. ");

					outputText("\n\n“<i>What’re you after, [name]?</i>” she says, smiling. There’s a barely contained excitement in her eyes; you don’t think she realizes her short tail is wagging furiously.");
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

					outputText("\n\n“<i>It started as a joke - I started giving orders to your followers like you do. You been around here enough it’s easy to imitate your words ‘n tone. That made ‘em start! But then I... I began to fantasize about really owning them, about abusing them, about beating them and then making 'em thank me for the privilege. Because they deserve it, don’t they? That’s what they are there for. That’s how you think and Gods... it feels so right to think that way, it opens up so many possibilities. But then I began to think in a new way....</i>” She licks her lips unconsciously. “<i>When you were around, again just for jokes I’d look at you and call you somethin’ under my breath, and </i>that<i>... every time I did it I had to go, I had to go somewhere quiet an’...</i>” she is unable to continue.");

					outputText("\n\nSoftly, still spinning the gem, you ask her what she called you. Whitney makes a noise which is familiar to you but which you’ve never heard emanating from her; a faint, high pitched whine from the back of her throat. Again, gently but firmly, you ask her what word she used.");

					outputText("\n\n“<i>...[Master],</i>” she says, quietly. You smile triumphantly. It’s time to move onto the final stage of your high-stakes business merger, however such is your control over the dog morph now you could make her change for you, if you so wished.");
					
					menu();
					addButton(0, "Change Her", deFurDoge);
					addButton(1, "Don't Change", dontDeFurDoge);

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
			outputText("“<i>I know what you’re tryin’ to do,</i>” the dog woman says abruptly as you conclude your business and turn to leave. “<i>You think that if you make me work with your slaves, poison this place with your influence and demon magic, you’ll turn me into one of your puppets too. Evil osmosis, or somethin’.</i>” She laughs bitterly. There’s an almost hysterical note to it. Maybe you’re kidding yourself but you think there might also be a brittle, perverse note of excitement in there too. “<i>It don’t work like that. All you’re doing with this business is surroundin’ me with examples of your cruelty, of what corruption and ill-will can do to ordinary folks. I can stand against it, and I will.</i>”");

			outputText("\n\nYou shrug nonchalantly, retrieve a gem from your purse and spin it on your fingertips with the same affected casualness. It’s not about corruption, you say; you aren’t in league with the demons, you have a soul. All you want to do is make the very best of this farm, and open her mind to new possibilities, new ways of thinking. The gem glitters with sunlight as you spin it rhythmically. You think that she’s spent too long on her own; has become so set in her ways she sees anything that changes her world as a threat, even if it is for her own benefit. She should open her eyes and open her mind to the success you’re bringing to her fields; maybe she’d learn how rich life can be if she let go of her prejudices, and accept that from your wider experience you know better. You pinch the gem to a stop and look at Whitney. She stares at the pretty object a moment longer before shaking her head and bringing her eyes up to yours, slightly dazed. You turn and leave, smiling quietly to yourself.");
			
			doNext(rootScene);
		}

		private function dogeNotCorruptYetMenu():void
		{
			menu();

			addButton(0, "Appearance", whitneyAppearanceNotCorrupt);
			addButton(1, "Prosperity", prosperityGoNotCorrupt);
			
			if (availableInvestments()) addButton(2, "Investment", investmentMenu);

			addButton(14, "Back", rootScene);

			if (whitneyCorruption() <= 60 && flags[kFLAGS.WHITNEY_LEAVE_0_60] == 0) addButton(14, "Back", dogeNotCorruptLeaveFirstTime);
			else if (whitneyCorruption() <= 90 && flags[kFLAGS.WHITNEY_LEAVE_61_90] == 0) addButton(14, "Back", dogeNotCorruptLeave6190);
		}
		
		public function availableInvestments():Boolean
		{
			if (player.hasKeyItem("Breast Milker - Installed At Whitney's Farm") < 0 && flags[kFLAGS.QUEUE_BREASTMILKER_UPGRADE] == 0) return true;
			if (player.hasKeyItem("Cock Milker - Installed At Whitney's Farm") < 0 && flags[kFLAGS.QUEUE_COCKMILKER_UPGRADE] == 0) return true;
			if (flags[kFLAGS.FARM_UPGRADES_REFINERY] == 0 && flags[kFLAGS.QUEUE_REFINERY_UPGRADE] == 0) return true;
			if (flags[kFLAGS.FARM_UPGRADES_CONTRACEPTIVE] == 0 && flags[kFLAGS.QUEUE_CONTRACEPTIVE_UPGRADE] == 0) return true;
			if (flags[kFLAGS.FARM_UPGRADES_MILKTANK] == 0 && kGAMECLASS.milkWaifu.milkSlave() && flags[kFLAGS.QUEUE_MILKTANK_UPGRADE] == 0) return true;
			return false;
		}

		private function whitneyAppearanceNotCorrupt():void
		{
			clearOutput();
			whitneySprite();

			outputText("Whitney is a 5’8” dog morph, dressed in a modest cotton blouse and faded long skirt, which has a hole cut in it to allow her short, perky tail to poke through. Her muzzle is suggestive of a golden retriever but really she could be any breed. Her fur is sandy, dusking to black at her extremities. Her ears are floppy, her eyes are a dark brown which matches her shoulder-length hair. She is beyond the flush of youth, however it is obvious from looking at her that she has never known childbirth; though hardened from many years of farm work her frame is relatively slim, her hips and ass widened only with muscle, her small breasts pert against her unprepossessing work-clothes. She has one anus, nestled between her tight buttcheeks where it belongs.");

			menu();
			dogeNotCorruptYetMenu();
		}
		
		private function whitneyAppearanceCorrupt():void
		{
			clearOutput();
			whitneySprite();
			
			outputText("Whitney is a 5’8” dog");
			if (whitneyDefurred()) outputText("-girl. Her human transformation has rendered her pretty in a delicate, diffident kind of way.");
			else outputText("-morph. Her muzzle is suggestive of a golden retriever but really she could be any breed.");
			if (whitneyMaxedOralTraining()) outputText(" In sharp contrast to her otherwise fairly thin features, her lips are plump and a depthless black, shining like wet tar. She constantly moves her tongue over them unconsciously.");
			outputText(" Although she continues to dress in the same modest cotton blouses and long skirts she always has, complete with holes cut in to allow her short, perky tail to poke through, the cut of it and the way she moves and swings herself about, livid with arousal and near-constant sexual frustration, makes the demure outfit more perverse than anything a demon could dream up.\n");

			if (whitneyHasTattoo())
			{
				if (numTattoos("whitney") > 1) outputText("\nShe has the following tattoos emblazoned across her body:\n");
				else outputText("\nShe has ")
				if (flags[kFLAGS.WHITNEY_TATTOO_COLLARBONE] != 0) outputText(flags[kFLAGS.WHITNEY_TATTOO_COLLARBONE] + "\n");
				if (flags[kFLAGS.WHITNEY_TATTOO_SHOULDERS] != 0) outputText(flags[kFLAGS.WHITNEY_TATTOO_SHOULDERS] + "\n");
				if (flags[kFLAGS.WHITNEY_TATTOO_LOWERBACK] != 0) outputText(flags[kFLAGS.WHITNEY_TATTOO_LOWERBACK] + "\n");
				if (flags[kFLAGS.WHITNEY_TATTOO_BUTT] != 0) outputText(flags[kFLAGS.WHITNEY_TATTOO_BUTT] + "\n");
			} 

			outputText("\n");
			if (!whitneyDefurred()) outputText("Her fur is sandy, dusking to black at her extremities");
			else outputText("Her skin is a sandy color, and she wears black nail varnish");
			outputText(". Her ears are floppy, her eyes are a dark brown which matches her shoulder-length hair, flecked now with deep, red desire. Whilst she is beyond the softness of youth, it is obvious from looking at her that she has never known childbirth; though hardened from many years of farm work her frame is relatively slim, her small breasts pert against her unprepossessing work-clothes. She has one anus, between her tight asscheeks where it belongs.");

			menu();
			dogeCorruptedMissionComplete(false);
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
			if (lowValue && lowProtection)
			{
				outputText("\n\nShe shrugs exasperatedly. “<i>I used to get by just fine on my own,</i>” she says. “<i>‘Til you started demanding 20% of everything. You think gems grow on cornstalks?");
				if (numFollowersAtFarm() + numSlavesAtFarm() + numLoversAtFarm() == 0) outputText(" Send me any kind of decent body - someone, anyone - and I can start trying to make more-a this place.");
				else outputText(" I need more hands to make the best of the place. More suitable hands at least.");
				outputText("</i>”");
			}
			// Value high, Protection low: 
			else if (!lowValue && lowProtection) outputText("\n\n“<i>You’ve given me lots’ve good workers, lots’ve good earners, and I’ve been bringing in lots’ve produce.</i>” She sighs. “<i>The trouble is lots’ve produce attracts trouble. Imps, gnolls, that sort. And if there ain’t nobody to stop em, they help themselves. I need strong types to come along here, warriors, watchers, people who’ll stop stuff disappearing in the night. You know?</i>”");
			// Value low, Protection high: 
			else if (lowValue && !lowProtection) outputText("\n\n“<i>Feel plenty safe at night, I can tell you that. You got this place protected better than a bank vault.</i>” Whitney shrugs. “<i>Trouble is, the vault is empty. Guards ‘d be great but they don’t scratch the earth for a living. I need hard workers, people who’ll produce stuff, earners. That’s what this place is crying out for right now.</i>”");
			// Value high, Protection high: 
			if (!lowValue && !lowProtection) outputText("\n\n“<i>Difficult to complain. This place is doing better than I’ve ever known, even going back to my grandma’s day. As long as we keep up this level of hard work and security, we’ll keep making this kinda scratch.</i>” You look at her, unsmiling, and she is momentarily thrown. “<i>It’s not... you aren’t-? Well, the only way we’d earn more money is- but I’d never...</i>” she trails off, not looking at you.");

			dogeNotCorruptYetMenu();
		}

		private function investmentMenu():void
		{
			menu();
			if (player.hasKeyItem("Breast Milker - Installed At Whitney's Farm") < 0 && flags[kFLAGS.QUEUE_BREASTMILKER_UPGRADE] == 0) addButton(0, "Breast Milker", investmentBreastMilker);
			if (player.hasKeyItem("Cock Milker - Installed At Whitney's Farm") < 0 && flags[kFLAGS.QUEUE_COCKMILKER_UPGRADE] == 0) addButton(1, "Cock Milker", investmentCockMilker);
			if (flags[kFLAGS.FARM_UPGRADES_REFINERY] == 0 && flags[kFLAGS.QUEUE_REFINERY_UPGRADE] == 0) addButton(2, "Refinery", investmentRefinery);
			if (flags[kFLAGS.FARM_UPGRADES_CONTRACEPTIVE] == 0 && flags[kFLAGS.QUEUE_CONTRACEPTIVE_UPGRADE] == 0) addButton(3, "Contraceptive", investmentContraceptive);
			if (flags[kFLAGS.FARM_UPGRADES_MILKTANK] == 0 && kGAMECLASS.milkWaifu.milkSlave() && flags[kFLAGS.QUEUE_MILKTANK_UPGRADE] == 0) addButton(4, "MilkTank", investmentMilktank);

			if (!whitneyCorrupt()) addButton(14, "Back", dogeNotCorruptYetMenu);
			else addButton(14, "Back", dogeCorruptedMissionComplete);
		}

		private function investmentBreastMilker():void
		{
			clearOutput();
			whitneySprite();

			if (!whitneyCorrupt())
			{
				outputText("You say you’d like a breast milker installed, one that you could make use of. Whitney frowns, but doesn’t seem as thrown by this idea as you expected.");

				outputText("\n\n“<i>I have a few spare parts knockin’ around, but most everything will have to be specially ordered if you want that,</i>” she says. “<i>If you can pony up 1,000 gems, I can get what you need brought in, built, and installed.</i>”");
			}
			else
			{
				outputText("You say you’d like a breast milker installed, one that you could make use of. Whitney lets her gaze sink down to your [chest].");

				outputText("\n\n“<i>Want to get closer to nature, [master]?</i>” she says, grinning slyly. “<i>I have a few spare parts knockin’ around, but most everything will have to be specially ordered if you want it. If you can pony up 1,000 gems, I can get what you need brought in, built, and installed.</i>”");
			}

			//[Do it][No]
			menu();
			if (player.gems >= 1000) addButton(0, "Do it", doBreastMilkerInvestment);
			else addButton(0, "Do it", turnDownInvestment, true);
			addButton(1, "No", turnDownInvestment);
		}

		private function doBreastMilkerInvestment():void
		{
			clearOutput();
			whitneySprite();

			player.gems -= 1000;
			showStats();

			outputText("You silently hand over a hefty bag of gems. Whitney stows it away.");

			outputText("\n\n“<i>Should have that ready to go by tomorrow, if y’all come back then.</i>”");

			flags[kFLAGS.QUEUE_BREASTMILKER_UPGRADE] = 1;

			doNext(rootScene);
		}

		private function investmentCockMilker():void
		{
			clearOutput();
			whitneySprite();

			if (!whitneyCorrupt())
			{
				outputText("You say you’d like a semen extractor built, one that you could make use of. Whitney frowns, but doesn’t seem as thrown by this idea as you expected.");

				outputText("\n\n“<i>I have a few spare milkin’ parts knockin around, but most everything will have to be specially ordered if you want that,</i>” she says. “<i>If you can pony up 1,000 gems, I can get what you need brought in, built, and installed.</i>”");
			}
			else
			{
				outputText("You say you’d like a semen extractor built, one that you could make use of. Whitney bites her lip at the implication.");

				outputText("\n\n“<i>I have a few spare milkin’ parts knockin’ around, but most everything will have to be specially ordered if you want that, [master],</i>” she says. “<i>If you can pony up 1,000 gems, I can get what you need brought in, built, and installed.</i>”");
			}

			menu();
			if (player.gems >= 1000) addButton(0, "Do it", doCockMilkerInvestment);
			else addButton(0, "Do it", turnDownInvestment, true)
			addButton(1, "No", turnDownInvestment);
		}

		private function doCockMilkerInvestment():void
		{
			clearOutput();
			whitneySprite();

			player.gems -= 1000;
			showStats();

			if (!whitneyCorrupt())
			{
				outputText("You silently hand over a hefty bag of gems. Whitney stows it away.");

				outputText("\n\n“<i>Should have that ready to go by tomorrow, if y’all come back then.</i>”");
			}
			else
			{
				outputText("You silently hand over a hefty bag of gems. Whitney stows it away.");

				outputText("\n\n“<i>Should have that ready to go by tomorrow, [master]!</i>”");
			}

			flags[kFLAGS.QUEUE_COCKMILKER_UPGRADE] = 1;

			doNext(rootScene);
		}

		private function investmentRefinery():void
		{
			clearOutput();
			whitneySprite();

			if (!whitneyCorrupt())
			{
				outputText("You say you want a machine built that could concentrate the fluids your followers produce into actual transformatives. Whitney shudders, but is in no position to argue.");

				outputText("\n\n“<i>A refinery, then? I guess it wouldn’t be too hard to throw up a still of sorts and adapt it from there. It’ll cost money though, ‘ticularly if you want it to be used by anyone for anything. If you give me 1,500 gems, I ‘kin see what I ‘kin do.</i>”");
			}
			else
			{
				outputText("You say you want a machine built that could concentrate the fluids your followers produce into actual transformatives.");

				outputText("\n\n“<i>A refinery, [master]? What a delicious thought.</i>” The dog girl closes her eyes and drifts off into an erotic reverie. You wait patiently until she finally opens her eyes with a sigh and comes back to you. “<i>I guess it wouldn’t be too hard to throw up a still of sorts and adapt it from there. It’ll cost money though, ‘ticularly if you want it to be used by anyone for anything. If you give me 1,500 gems, I ‘kin see what I ‘kin do.</i>”");
			}

			menu();
			if (player.gems >= 1500) addButton(0, "Do it", doRefineryInvestment);
			else addButton(0, "Do it", turnDownInvestment, true);
			addButton(1, "No", turnDownInvestment);
		}

		private function doRefineryInvestment():void
		{
			clearOutput();
			whitneySprite();

			player.gems -= 1500;
			showStats();

			outputText("You silently hand over a hefty bag of gems. Whitney stows it away.");

			outputText("\n\n“<i>I will try and get... that... ready in a few days time, if y’all come back then.</i>”");

			flags[kFLAGS.QUEUE_REFINERY_UPGRADE] = 1;

			doNext(rootScene);
		}

		private function investmentContraceptive():void
		{
			clearOutput();
			whitneySprite();

			if (!whitneyCorrupt())
			{
				outputText("You ask Whitney if she knows of any natural contraceptive that grows in Mareth.");

				outputText("\n\n“<i>The stuff that some of the sharks use, y’mean? Sure. You find it growing in clumps in loamy patches in the forest and along the lake. Most nobody in those parts uses it o’course, owing to them all being locked in a baby arms race with each other.</i>” You say you’d like her to set some land aside and grow it. “<i>If you want. I need seed though, and plenty of compost - only grows in very moist soil as I said. 750 gems can probably make it happen.</i>”");
			}
			else
			{
				outputText("You ask Whitney if she knows of any natural contraceptive that grows in Mareth.");

				outputText("\n\n“<i>The stuff that some of the sharks use, y’mean? Sure. You find it growing in clumps in loamy patches in the forest and along the lake. Most nobody in those parts uses it o’course, owing to them all being locked in a baby arms race with each other.</i>” You say you’d like her to set some land aside and grow it. “<i>If you want, [master]. I need seed though, and plenty of compost- only grows in very moist soil as I said. 750 gems can probably make it happen.</i>”");
			}

			menu();
			if (player.gems >= 750)
			{
				addButton(0, "Do it", doContraceptiveInvestment);
			}
			else
			{
				addButton(0, "Do it", turnDownInvestment, true);
			}
			addButton(1, "No", turnDownInvestment);
		}

		private function doContraceptiveInvestment():void
		{
			clearOutput();
			whitneySprite();

			player.gems -= 750;
			showStats();

			if (!whitneyCorrupt())
			{
				outputText("You hand over the dough. Whitney stows it away.");

				outputText("\n\n“<i>It doesn’t take long to grow, but it’ll still take time,</i>” she says. “<i>I’ll lay the seeds tomorrow and you’ll be able to start pickin it in a week’s time.</i>”");
			}
			else
			{
				outputText("You hand over the dough. Whitney stows it away.");

				outputText("\n\n“<i>It doesn’t take long to grow, but it’ll still take time, [master],</i>” she says. “<i>I’ll lay the seeds tomorrow and you’ll be able to start pickin’ it in a week’s time.</i>”");
			}

			//[“Harvest Contraceptive” option added to main farm menu in 7 days time]
			flags[kFLAGS.QUEUE_CONTRACEPTIVE_UPGRADE] = 1;
			doNext(rootScene);
		}

		private function investmentMilktank():void
		{
			clearOutput();
			whitneySprite();

			if (!whitneyCorrupt())
			{
				// If Bathgirl normal:
				if (flags[kFLAGS.MILK_SIZE] > 0 && flags[kFLAGS.FOLLOWER_AT_FARM_BATH_GIRL] == 1)
				{
					outputText("You tell Whitney you want her to give [bathgirlName] an intensive course of Gro-plus and Lactaid, and to build a small swimming tank to house her.");

					outputText("\n\n“<i>Wh-what?</i>” says the dog woman, aghast. “<i>The pretty lil’ thing who works in the cowshed? She told me you cured her. She’s so happy an, an now you want to... uncure her?</i>” ");

					outputText("\n\nExactly, you say primly. You need her to produce more milk. Whitney looks like she’s going to refuse, but once she’s stared into your unblinking eyes and remembered a few things, she looks at her feet and sighs miserably. “<i>I could probably do that. Because she trusts you, she trusts me, and- 400 gems,</i>” she finishes in a mumble.");
				}
				// If Bathgirl boobed and at camp: 
				else
				{
					outputText("You tell Whitney you want her to build a swimming tank at the farm, then come to your camp, take away your expensively acquired milk slave and install her in it. The dog woman slowly absorbs this.");

					outputText("\n\n“<i>400 gems,</i>” she says finally.");
				}
			}
			else
			{
				if (flags[kFLAGS.MILK_SIZE] > 0 && flags[kFLAGS.FOLLOWER_AT_FARM_BATH_GIRL] == 1)
				{
					outputText("You tell Whitney you want her to give [bathgirlName] an intensive course of Gro-plus and Lactaid, and to build a small swimming tank to house her.");

					outputText("\n\n“<i>[Master] you are so wicked,</i>” the dog woman whispers with overt glee. “<i>Pumpin’ that silly slut full of growth hormones ‘til all she can think about are her big, juicy tits- oh Gods, gimme gems, 400 should do it, I want to start right now!</i>”");
				}
				else
				{
					outputText("\n\nYou tell Whitney you want her to build a swimming tank at the farm before coming to your camp, taking away your expensively acquired milk slave and installing her in it. ");

					outputText("\n\n“<i>Of course, [master],</i>” says Whitney, a grin creeping onto her face at the prospect of another slave under her thumb. “<i>400 gems’ll make it happen.</i>”");
				}
			}

			menu();
			if (player.gems >= 400) addButton(0, "Do it", doMilktankInvestment);
			else addButton(0, "Do it", turnDownInvestment, true);
			addButton(1, "No", turnDownInvestment);
		}

		private function doMilktankInvestment():void
		{
			clearOutput();
			whitneySprite();

			if (!whitneyCorrupt()) outputText("You press the gems into your taskmaster’s hand, turn and leave without another word. Your thoughts turn to huge, delightfully plush brown boobs and luxurious milky baths; it will be well worth it. ");
			else outputText("You press the gems into your taskmaster’s hand, turn and leave without another word. Your thoughts turn to huge, delightfully plush, brown boobs, of luxurious milky baths; it will be well worth the cost. ");

			// In each case Bath girl reverts to her boobed state and is at farm
			flags[kFLAGS.QUEUE_MILKTANK_UPGRADE] = 1;
			player.gems -= 400;

			doNext(rootScene);
		}

		private function turnDownInvestment(money:Boolean = false):void
		{
			clearOutput();
			whitneySprite();

			if (!whitneyCorrupt())
			{
				// Any “No” option:
				outputText("Whitney shrugs, nonplussed.");

				if (money) outputText("\n\n“<i>Come back with the money.</i>”");
				else outputText("\n\n“<i>Come back if you change your mind. With the money.</i>”");
			}
			else
			{
				outputText("Whitney shrugs with a simper. ");

				outputText("\n\n“<i>Come back any time if ya change your mind, [master]. S’long you got the money, it won’t be hard to do.</i>”");
			}

			investmentMenu();
		}

		private function deFurDoge():void
		{
			clearOutput();
			whitneySprite();

			outputText("You put away the gem and move into Whitney, holding her gaze as you gently place your finger and thumb along her jaw line. She doesn’t pull away and lets out a shuddering sigh as you touch her.");

			outputText("\n\n“<i>I’m glad you have finally opened your mind to everything I can do for you, understood what our relationship truly is,</i>” you say. “<i>And I’m ready to teach you all sorts of things. However...</i>” you pinch into her muzzle very slightly and Whitney tenses, unable to tear her gaze away from your eyes. “<i>This isn’t acceptable. Walking, talking animals are an aberration in my eyes. And you know what happens to aberrations, don’t you Whitney?</i>” She doesn’t reply; she’s deep under your influence, deep under your words. “<i>But you’re a smart girl. A girl who has worked with transformatives her whole life. So I’ll come back tomorrow, and you will be different, in a more suitable form, and then we will discuss your exciting new future properly. Ok?</i>”");

			outputText("\n\n“<i>‘s,</i>” says Whitney, very quietly. You smile at her warmly, and release your grip.");

			outputText("\n\n“<i>Good girl.</i>” You turn and leave.");

			//[“Whitney” option removed from farm menu until next day]
			flags[kFLAGS.WHITNEY_DISABLED_FOR_DAY] = 1;
			flags[kFLAGS.WHITNEY_DEFURRED] = 1;

			doNext(camp.returnToCampUseOneHour);
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

			outputText("\n\n“<i>I am... I am your slave!</i>” she cries out. “<i>I own nothing, I don’t want to own nothing i-if it means I can belong to you!</i>” She suddenly breaks free of your grasp and hurls herself with a vengeance at what remains of the weapon, howling and growling as she lifts the hatchet again and again, splintered wood flying as she destroys her old life, her last defense against you in a purging frenzy. You stand and watch the display with a broad smile. You really are too good sometimes.");

			outputText("\n\nWhen Whitney turns back to you, heaving with exertion, color high in her face, her hair and clothes disheveled, there’s something new in her eyes; what were once the most placid pools of hazel are now lit and marbled with a deep, red desire. You have immersed the dog girl in an atmosphere of corruption for so long it seems as if all you had to do at this point was throw the right switch.");

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

			outputText("\n\n“<i>Felt good to do that, didn’t it? To do away with the idea you could stop me, to be entirely open and defenseless to me. Because you are defenseless to me now, aren’t you Whitney?</i>” As you talk, you stop rotating the jewel but continue to hold it directly in front of her eyes, whilst you place your other hand on her hip, sliding it upwards, enjoying the firm contours of your new slave.");

			outputText("\n\nShe whines as you roam far enough upwards to slip underneath the belt of her skirt and then downwards again, smoothing around her tight rump and inner thigh until you touch her labia. It is not surprising to you to find that she is dripping wet, her underclothes soaked with excitement. You gently push your fingers into the wet heat and begin to stroke her inner lips, curving upwards to find and caress her tiny clit as you continue to talk, pressing your compulsion on her as you drown her hypnotized mind in pleasure.");

			outputText("\n\n“<i>You are my bitch, and you will act like it. You will protect my property with your life, and run it to the very best of your abilities. You will put my other slaves to the lash, make them work twice as hard just so you may receive one word of praise from me. When you hear my voice, it will make you wet.");

			if (player.biggestTitSize() >= 2) outputText("\n\nWhen you see my breasts, you will want to suckle on them.");

			if (player.hasCock()) outputText("\n\nWhen you see my dick, you will want to worship it.");

			if (player.hasVagina()) outputText("\n\nWhen you see my cunt, you will want to bathe it in attention.");

			outputText("\n\nAs long as you’re a good girl, you will be my right hand here, and good girls get treats. Bad girls get punished.</i>” Whitney is panting, her eyes unable to look away from the gleaming gem as you stick two fingers into her tight hole and begin to masturbate her briskly. “<i>Now... what are you?</i>” The dog girl’s cunt spasms around your fingers deliriously, and your whole hand is soaked in a sudden gush of fluid.");

			outputText("\n\n“<i>Good... girl!</i>” manages the former farm owner between groaning breaths. You slowly take both hands away, and wait for her eyes to refocus on you.");

			outputText("\n\n“<i>Demonstrate it.</i>” Immediately Whitney sinks down on her knees before you, brown eyes looking up soulfully. You smile widely, and press your hand onto her head.");

			outputText("\n\n“<i>GOOD girl!</i>” She grins happily and her tail wags furiously as you rub her behind the ear. “<i>That’s how I expect to find you every time I come to visit. Now run along, go and make my farm spin gold. I will be along later to see if you need rewarding or punishing.</i>”");

			outputText("\n\n“<i>At once, [master]!</i>” The dog girl is on her feet and off towards the farm in one swift movement, new determination etched into her posture. Your take-over of the farm is complete; you should expect to see a larger share of the profits now that Whitney is your slave taskmaster, entirely bent on serving you.");

			doNext(camp.returnToCampUseOneHour);
		}

		private function makeDogeDommy():void
		{
			clearOutput();
			whitneySprite();

			outputText("You again retrieve your gem, and once more begin to rhythmically turn it. This time, however, you walk steadily towards Whitney, your voice getting louder in her ears, the shining light in her unfocused eyes getting brighter as you go on.");

			outputText("\n\n“<i>You liked doing that, didn’t you Whitney? That letting go, that burst of pure violence, passion given physical form. You always had that within you, but for some reason you chose to bury it, stifle it under a life of complete tedium. Until </i>I<i> came along. Until </i>I<i> I gave you slaves to order around and forced those desires to the surface, an unquenchable thirst to overcome and make your own.</i>”");
 
			outputText("\n\nAs you talk, you stop rotating the jewel but continue to hold it directly in front of her eyes, whilst you place your other hand on her hip, sliding it upwards, enjoying the firm contours of your new slave. The dog girl’s eyes are not unfocused this time; they are staring into the blinding light with a hard, sheer lust, her breath drawing harshly as your hand continues to move. You find your heart quickening at the prospect of what you are about to do; but the thought of fanning those embers of furious passion you have kindled within this once calm woman is too enticing to resist.");

			outputText("\n\nHer breath comes harder as you roam far enough upwards to slip underneath the belt of her skirt and then downwards again, smoothing around her tight rump and inner thigh until you touch her labia. You are not surprised to find that she is dripping wet, her underclothes soaked with excitement. You gently push your fingers into the sopping heat and begin to stroke her inner lips, curving upwards to find and caress her tiny clit as you continue to talk, pressing your compulsion on her as you drown her hypnotized mind in pleasure.");

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

			outputText("\n\n“<i>At once, [master]!</i>” The dog girl turns and is off towards the farm in one swift movement, new determination etched into her posture. Your take-over of the farm is complete; you should expect to see a larger share of the profits now that Whitney is your slave taskmaster, entirely bent on serving you.");


			flags[kFLAGS.WHITNEY_DOM] = 1;

			doNext(camp.returnToCampUseOneHour);
		}

		private function dogeCorruptedMissionComplete(output:Boolean = true):void
		{
			if (flags[kFLAGS.QUEUE_BRANDING_AVAILABLE_TALK] == 1 && output)
			{
				brandingAvailableTalk();
				return;
			}

			if (flags[kFLAGS.FARM_UPGRADES_ORGYROOM] == 2 && output)
			{
				orgyRoomTalk();
				flags[kFLAGS.FARM_UPGRADES_ORGYROOM] = 1;
				return;
			}

			if (output)
			{
				clearOutput();
				whitneySprite();
			}

			if (whitneyDom() && output)
			{
				outputText("Whitney is in front of you before you’ve finished calling her name.");

				outputText("\n\n“<i>Yes, [master]?</i>” she husks, staring hungrily into your eyes. A state of nervous energy, the sense she’s only barely controlling the urge to grab you with great effort, never leaves her. “<i>Business? Or pleasure?</i>”");
			}
			else if (output)
			{
				outputText("Whitney is knelt in front of you before you’ve finished calling her name. Her tail wags as her soulful brown eyes look up at you, lit up with depthless lust.");

				outputText("\n\n“<i>[Master]?</i>”");
			}

			menu();
			addButton(0, "Appearance", whitneyAppearanceCorrupt);
			if (availableInvestments()) addButton(1, "Investment", investmentMenu);
			if (flags[kFLAGS.FARM_CORRUPTION_BRANDING_MENU_UNLOCKED] == 1 || flags[kFLAGS.QUEUE_BRANDING_UPGRADE] < 1) addButton(2, "Branding", brandingMenu);
			if (whitneyDom()) addButton(3, "Pleasure", whitneyDomPleasure);
			else addButton(3, "Pleasure", whitneySubPleasure);
			orgyRoomRouter();
			addButton(14, "Back", rootScene);
		}

		private function whitneySubPleasure():void
		{
			clearOutput();
			whitneySprite();

			var doFunctor:Function = null;
			var functorOnNext:Boolean = false;

			if (flags[kFLAGS.WHITNEY_ORAL_TRAINING] == 0)
			{
				functorOnNext = true;
				firstOralTraining();
			}

			if (player.hasCock())
			{
				doFunctor = cockOralTraining();
			}
			else 
			{
				doFunctor = vaginaOralTraining();
			}

			flags[kFLAGS.WHITNEY_ORAL_TRAINING]++;
			if (functorOnNext)
			{
				doNext(doFunctor);
			}
			else
			{
				doFunctor();
			}
		}

		private function cockOralTraining():Function
		{
			if (flags[kFLAGS.WHITNEY_ORAL_TRAINING] == 0)
			{
				return firstCockOralTraining;
			}
			else if (flags[kFLAGS.WHITNEY_ORAL_TRAINING] <= 3)
			{
				return cockOralTrainingStageOne;
			}
			else if (flags[kFLAGS.WHITNEY_ORAL_TRAINING] == 4)
			{
				return firstCockOralTrainingStageTwo;
			}
			else if (flags[kFLAGS.WHITNEY_ORAL_TRAINING] <= 9)
			{
				return cockOralTrainingStageTwo;
			}
			else if (flags[kFLAGS.WHITNEY_ORAL_TRAINING] == 10)
			{
				return firstCockOralTrainingStageThree;
			}
			else if (flags[kFLAGS.WHITNEY_ORAL_TRAINING] == 11)
			{
				return cockOralTrainingStageThree;
			}
			else
			{
				return cockOralTrainingMaxed;
			}
		}

		private function vaginaOralTraining():Function
		{
			if (flags[kFLAGS.WHITNEY_ORAL_TRAINING] == 0)
			{
				return firstVaginaOralTraining;
			}
			else if (flags[kFLAGS.WHITNEY_ORAL_TRAINING] <= 3)
			{
				return vaginaOralTrainingStageOne;
			}
			else if (flags[kFLAGS.WHITNEY_ORAL_TRAINING] == 4)
			{
				return firstVaginaOralTrainingStageTwo;
			}
			else if (flags[kFLAGS.WHITNEY_ORAL_TRAINING] <= 9)
			{
				return vaginaOralTrainingStageTwo;
			}
			else if (flags[kFLAGS.WHITNEY_ORAL_TRAINING] == 10)
			{
				return firstVaginaOralTrainingStageThree;
			}
			else if (flags[kFLAGS.WHITNEY_ORAL_TRAINING] == 11)
			{
				return vaginaOralTrainingStageThree;
			}
			else
			{
				return vaginaOralTrainingMaxed;
			}
		}

		private function firstOralTraining():void
		{
			outputText("You grin down at your newly acquired slave. It’s certainly a fitting position for a literal bitch, and whether she’s adopted it knowingly or not she’s got the stance down perfectly - the yearning eyes, the slowly wagging tail, back and neck straight. A tempting image of a biscuit balanced on a nose surfaces in your mind... but it is swiftly banished by more pressing thoughts, carnal impulses sinking down to your groin at the sight of your kneeling dog girl. She watches avidly as you slowly peel off your [armor], exposing");
			if (player.hasCock()) outputText(" [eachCock]");
			if (player.hasCock() && player.hasVagina()) outputText(" and");
			if (player.hasVagina()) outputText(" [vagina]");
			outputText(". You tell her huskily it’s time she learned how to service you.");

			outputText("\n\n“<i>I - I want to do that, [master],</i>” she replies tensely. She’s having problems knowing what to look at, her eyes flitting between your gaze and the demanding sight of your " + ((player.hasCock()) ? "[cock biggest]" : "lush cunt") + ", eventually settling on the first. “<i>I want to serve you best I can, but I - don’t know if - it’s just, I’ve never really - I mean, once or twice, but I’ve never been very...</i>” Your growing urge makes you feel impatient and you think about stifling her meek babbling with a good face fucking... but no. There are much better ways of getting the best out of inexperienced slaves.");

			outputText("\n\nIn a kind tone, you tell her not to worry. You’re going to teach her exactly how to give pleasure to her [master], and how it in turn will give her more pleasure than she’s ever known. After a few lessons, you tell her confidently, she’ll be the best and most shameless");
			
			if (player.hasCock()) outputText(" cocksucker");
			else outputText(" pussy eater");
			
			(" there has ever been. Doubt wages war with aroused apprehension on Whitney’s face.");

			outputText("\n\n“<i>I, I will try, [master],</i>” she says. You reach down and hold her around the jaw-line.");

			outputText("\n\n“<i>No,</i>” you say firmly.");
			if (silly()) outputText(" “<i>Do. Or do not. There is no try.</i>”");
			else outputText(" “<i>You will.</i>”");
			outputText(" Determination lines the dog woman’s mouth.");

			outputText("\n\n“<i>Yes, [master]. I will tr- I will.</i>” She takes a long breath and transfers her gaze to " + ((player.hasCock()) ? "[eachCock]" : "[vagina]") +", looking for all the world like she’s about to embark on a marathon.");

			outputText("\n\n“<i>First,</i>” you say, settling yourself down, “<i>Put one hand in your knickers. Find that nice, wet pussy of yours.</i>” You watch her, a smile twitching the corners of your mouth as, blushing furiously, she shifts around in front of you. “<i>You know how to do that, right? All those lonely nights on the farm... good. Nice and easy. Eyes down.</i>” You say the last part adamantly, opening your [hips] wider as you do. Whitney swallows a bit as she strokes at her tiny button whilst staring at your " + ((player.hasCock()) ? "[eachCock]" : "[vagina]") + ", already " + ((player.hasCock()) ? "semi-turgid" : "moist") + " from the display put on by your fresh, nervous slave. “<i>Good,</i>” you murmur. “<i>Now... reach forward, and begin to lick.</i>”");
		}

		private function firstCockOralTraining():void
		{
			clearOutput();
			whitneySprite();

			outputText("Slowly the dog woman does as you ask, bending forward and opening her mouth to lap at the end of your [cock biggest] with her flat tongue. Awkwardly, with one hand in her panties, she grasps your base with her other hand to steady herself with a grunt and sends her tongue running down your sensitive underside; you sigh at the delicious sensation, letting her know exactly what pleases you as she runs her wet, warm muscle over every inch she can reach, quickly making you fully erect and pulsing with urgency. Rather than engulf your head with her mouth though, she keeps tonguing at you, faster and faster. You frown down. It’s pleasant but not satisfying, and she’s already lost herself in the act, eyes closed and lapping at your groin like a dog going at her...");

			outputText("\n\n“<i>Stop,</i>” you say firmly. She looks up at you, slightly dazed. “<i>I am not your butt and I don’t need cleaning. Do it slowly...</i>” you wait until she’s licking at your head again, before pushing gently forwards. “<i>and now swallow me. That’s it!</i>” You sigh as the end of your [cock biggest] is enveloped in fleshy warmth. Her sharp teeth rub uncomfortably against your bulging skin but with a few whispered instructions they disappear, and you begin to slowly push into her sucking wetness, each time pushing further into her mouth.");

			outputText("\n\nShe doesn’t put her delightful tongue to use and she sometimes stops frigging herself, lost in taking more and more of your cock" + ((player.hasVagina()) ? "; further, your [vagina] is beading in frustration at being left out of the oral pleasure. But that’s all right. It’ll all come in time" : ", but that’s all right; it’ll come in time") + ". For now, there is her soft mouth and the delicious pleasure inundating your prick, her warm hand grasped around you as your urge grips you closer, and as you touch the front of her throat she is beginning to moan around your flesh, louder and louder as she-");

			outputText("\n\n“<i>Stop!</i>” you cry out again harshly. Surprised brown eyes look up at you and the mouth around your cock freezes. “<i>Slaves do not get off before their owners,</i>” you say pressingly. “<i>Only if you do well enough to make me cum may you have the same privilege. Now... keep sucking and fingering. Try to do it at the same time. Nice and slow.</i>” You let her get back in the rhythm again, pleasuring the end of your [cock biggest] as you sensually sink more and more of your length into her mouth. Pleasingly, at your explicit instruction she does manage to move both her mouth and the hand buried in her pussy at the same time, and your prick reverberates deliciously to the occasional muffled moan. ");

			//Big Cock
			if (player.biggestCockLength() > 12)
			{
				outputText("\n\nThe desire to holster as much of your dick into your slut as you can eventually becomes too great and you begin to push, gently but insistently, into her throat. You know what to expect and patiently withdraw when she coughs and chokes - but then press back in when she’s recovered. After a few times she manages to get a hold on her gag reflex and you sigh as your [cockHead biggest] sinks into the delicious tightness of her throat.");
			}

			outputText("\n\nWith your blood beginning to sing you let go of your lust’s leash, take hold of her head and begin to thrust into her mouth urgently, the sucking, milking warmth of it pushing you towards your high. She copes poorly with your change of pace - there’s the odd “ack!” and “ick!” below you - but you’re beyond caring, and anyway, she’s going to have to get used to it. You straighten your back and close your eyes beatifically as you surge to your high, your [cock biggest] tensing deep in Whitney’s mouth and then unloading, spurting line after line of jizz down her throat.");

			outputText("\n\n“<i>You may cum now, bitch,</i>” you breathe thickly, in the valley of one of your gratifying pulses.");

			//High cum
			if (player.cumQ() >= 1500)
			{
				outputText("\n\nThe dog woman coughs and splutters around your incredibly thick, voluminous spunk, even more pumping into her stomach as it spurts out of her nose and oozes down her chin, but this doesn’t stop her from furiously moving her hand in her knickers, flicking her clit for all she is worth as she attempts to cope with your huge load at the same time. On the edge already it doesn’t take her long, and her eyes roll as she tenses and shudders, her mouth full of prick. The sight is pleasing enough for you to pull out and spurt the last few jets of cum onto her face and clothes. She barely even notices, panting as she keeps fingering herself ecstatically.");
			}
			else
			{
				outputText("\n\nThe dog woman coughs and splutters around your thick spunk, some of it dribbling out of her nose even as you continue to pump more into her, but this doesn’t stop her from furiously moving her hand in her knickers, flicking her clit for all she is worth as she attempts to cope with your huge load at the same time. On the edge already it doesn’t take her long, and her eyes roll as she tenses and shudders, her mouth full of prick.");
			}

			outputText("\n\nFinally you both come down. You enjoy the haze of emptiness and post-coitus as you look down at your slave; her eyes are unfocused and she seems to be somewhere else entirely. It is obvious she is a complete novice to cocksucking, but the thought of the challenge ahead of turning her into an expert inspires you. As if she heard your thoughts, Whitney blinks and looks up at you, cum dripping off her, smiling unsteadily.");

			outputText("\n\n“<i>Whew. Sorry I wasn’t very good at that, [master],</i>” she says. “<i>I’m sure one of your other servants would do a much better job of it.</i>” You tell her not to be silly - she shows great promise. However there are plenty of things she will need to remember, like the need for a slut to clean a dick she’s been working on after she’s done. The dog girl “oh!”s and quickly bends over your pleasantly aching, semi-turgid [cock biggest] again. After she’s finished the enjoyable task of licking your oozing head clean, you send her on her way.");

			player.orgasm();
			dynStats("sen-", 1);
			doNext(camp.returnToCampUseOneHour);
		}

		private function cockOralTrainingStageOne():void
		{
			clearOutput();
			whitneySprite();

			outputText("Sighing, you slide out of the bottom half of your [armor] and tell her with a smile it’s time for another lesson. Whitney wrings her "+ ((whitneyDefurred()) ? "hands" : "paws") +" at the sight of your [cock biggest] fretfully. You don’t think it’s that she’s reluctant, merely afraid she’ll do a poor job. So you make your instructions gentle and patient. You tell her to start frigging herself again whilst looking at your exposed crotch, and then when she seems to have lost her anxiety a bit, you tell her to start licking.");

			outputText("\n\nWhat follows is an occasionally frustrating but ultimately satisfying fifteen minutes. She can’t seem to kick the instinct to lap at your cock as if it were her own groin, and whilst it’s both a pleasing sensation and quite funny to look at, you have to instruct her quite firmly to make her actually suck you. She has a bit of a problem with multi-tasking, sometimes stopping either working her clit or sucking your cock when she gets too much into one or the other.");
			if (player.hasVagina() || player.cocks.length > 1) outputText(" You know that it’s going to be important for her to work on more than one thing at once, so you are as hard as you can be to make sure that she gets this right, going as far as to cock-slap her when she gets so into flicking her button that she forgets you again. You don’t like doing this because a scolded dog girl is heartbreaking to look at, but needs must.");

			outputText("\n\nShe’s got the basics though; it’s imprinted on her well that she should not get herself off before she finishes with you, and she sighs and moans as she edges herself whilst moving her soft mouth up and down your bulging length. There’s a nice bit of rubbing give and take too which despite the need to tell her what to do slowly but surely builds your ardor into a blazing heat. You forgo words, take her head and begin to thrust into her milking redness hard.");
			if (player.biggestCockLength() > 12) outputText(" She still struggles a bit with her gag reflex but it only takes her a few tries to swallow your thick prick, allowing you to pump into the delightful tightness of her throat without issue.");

			outputText("\n\nYou straighten your back and close your eyes beatifically as you surge to your high, your [cock biggest] tensing deep in Whitney’s mouth and then unloading, spurting line after line of jizz down her throat.");

			outputText("\n\n“<i>You may cum now, bitch,</i>” you breathe thickly, in the valley of one of your gratifying pulses.");

			//High cum
			if (player.cumQ() >= 1500)
			{
				outputText("\n\nThe dog woman coughs and splutters around your incredibly thick, voluminous spunk, even more pumping into her stomach even as it spurts out of her nose and oozes down her chin, but this doesn’t stop her from furiously moving her hand in her knickers, flicking her clit for all she is worth as she attempts to cope with your huge load at the same time. On the edge already, it doesn’t take her long, and her eyes roll as she tenses and shudders, her mouth full of prick. The sight is pleasing enough for you to pull out and spurt the last few jets of cum onto her face and clothes. She barely even notices, panting as she keeps fingering herself ecstatically.");
			}
			else
			{
				outputText("\n\nThe dog woman coughs and splutters around your thick spunk, some of it dribbling out of her nose even as you continue to pump more into her, but this doesn’t stop her furiously moving her hand in her knickers, flicking her clit for all she is worth as she attempts to cope with your huge load at the same time. On the edge already it doesn’t take her long, and her eyes roll as she tenses and shudders, her mouth full of prick.");
			}

			outputText("\n\nAfter you’re done and withdraw, Whitney goes off into her post coital daze again, and you have to pointedly cough and poke her in the face with your pleasantly aching [cock biggest] before she remembers her final task. You sigh as her warm, flat tongue circles your bulging, oozing head, lapping you quite clean.");

			outputText("\n\n“<i>That was pretty fun [master],</i>” she says when she’s finished, grinning. Her expression clouds a bit. “<i>You sure this is workin’, though? I don’t think I’m cut out for it.</i>” You tell her with all the confidence you can muster that she’s progressing fine, and as long as she remembers her lessons she’ll be a champion cocksucker in no time. Whitney nods slowly, evidently trying to believe your words as hard as she can.");

			outputText("\n\n“<i>Alright [master], I’ll tr- I will!</i>”");

			player.orgasm();
			dynStats("sen-", 1);
			doNext(camp.returnToCampUseOneHour);
		}

		private function firstCockOralTrainingStageTwo():void
		{
			clearOutput();
			whitneySprite();

			outputText("Undoing the bottom half of your [armor], you tell her with your usual fond smile it’s time for another lesson. You notice a slight difference in the dog woman kneeled in front of you this time; the usual nervous energy seems to have deserted her, and she focuses on your [cock biggest] with a still, quiet determination. You settle yourself down, open your [hips] and, pausing, give no further instruction. ");

			outputText("\n\nYour faith is immediately repaid. Knowing exactly what to do, Whitney slides one of her hands into her undergarments, levelly keeping her gaze on [eachCock], huffing and puffing a bit as she works herself up before opening her mouth and laying her hot, ever-so-slightly rough tongue on your cock head. After only a few careful licks, lapping over all the sensitive spots she knows will make you bulgingly hot, she opens wide and envelopes your [cockHead biggest] in wet, warm flesh. You make a sound of deep approval as she bobs her head up and down, needing no encouragement from you to work your shaft up and down, engulfing more and more of it into her welcoming mouth. ");

			outputText("\n\nGodsdamn, she’s even learned how to use her tongue at the same time; it rubs delightfully along the underside of your dick, lapping at the exposed base as she works, a shifting texture at odds to her soft, hollowed cheeks. She whimpers around you and begins to move her head faster, tightening her mouth up, fucking herself on you. If she keeps this up you’re going to blow your load in no time...");

			outputText("\n\nWith some effort, you put a firm hand on her shoulder and silently bid her to stop. Your bulging [cock biggest] pops out of her mouth, as frustrated as the worry in Whitney’s eyes is deep.");

			outputText("\n\n“<i>Sorry, [master]. Am I doing something wrong?</i>”");

			outputText("\n\n“<i>Not at all,</i>” you groan, closing your eyes and silently bidding the heat you feel to simmer down slightly. “<i>You’ve been learning well and have come a long way. But now that you’ve got the basics down, you need to grasp the other parts of properly servicing me. Now - keep flicking away at that slutty pussy of yours, and I’ll show you.</i>” You wait until the anxiety has melted away from Whitney’s face, replaced with deep lust as her body jerks to the movement of her hand, before beginning.");

			//Herm w/ balls
			if (player.hasVagina() && player.balls > 0)
			{
				outputText("\n\n“<i>First of all, before you start each time you must work on these.</i>” With your [cock biggest] raised it is easy enough to expose your [balls] to her. “<i>A good slut knows her mistress’s balls need a good polish before she’s deserving of swallowing her cock. Let’s see how you do.</i>” ");

				outputText("\n\nAfter a slight pause Whitney sinks her face so far into your groin you can no longer see her expression. You sigh as you feel her flat tongue dance across your sensitive nuts, kneading them gently and bathing them in saliva. This at last is a task perfectly suited to her tongue you think, and you stifle an insane giggle only with difficulty. “<i>Lick every inch... that’s good. Suckle on them... very good!</i>” You gasp a bit as she envelopes one of your orbs entirely and pulls at it ever so gently, sending delicious sensation thrumming through your crotch.");

				outputText("\n\n“<i>Ooh, you’re a natural. Now that you’ve got that, let’s learn about the other element. This is a bit more delicate than simply being a good little ball-licker though, so follow my instruction carefully.</i>” Whitney peers out around [eachCock]. Her hand is still jammed in her panties and she is panting slightly, color high in her cheeks. You smile at her encouragingly. “<i>Behind them you will find my pussy. I think if you’re knelt there pleasuring yourself you should at least be extending the same courtesy to your mistress, hmm? Start out slow and gentle to begin with.</i>” ");

				outputText("\n\nCarefully, Whitney delves between your [hips], pushing beyond [eachCock] and spit-shone [balls] until her smooth, warm fingers are pressing against your [vagina]. She explores your lips, moistened already by her activities with your male genitalia, awkwardly at first but with growing confidence as she builds up an idea of its shape, slowly pushing into your wet hole. ");

				outputText("\n\nShe does at least have some idea what she’s doing here, curling her fingers into herself at the same time she explores your [vagina]. She’s still frustratingly clumsy at first, struggling to get the angle right, then bumping the tips of her fingers into your [clit] too hard. After you’ve barked in annoyance, her touch is too soft, afraid to hurt you.");

				outputText("\n\nEventually though she starts to get it right, circling your clit slowly before gently running her finger across it, each time making it bulge out of its hood even further. She even manages to stick her index finger into you as she does, curling deliciously at your vaginal walls until your whole female sex feels like it’s unfurled and gleaming with pleasure.");

				outputText("\n\n“<i>Good,</i>” you husk, with some effort keeping your voice level as delicious sensation veins its way through your groin, “<i>now comes the real test. Keep both hands where they are, and go back to sucking my dick.</i>” Whitney steals a moment’s rest, her hands no doubt aching a bit by now, before pulling back and focusing on your [cock biggest]. You sigh deeply, your eyes closing as your [cockHead biggest] is once again enveloped with sweet, wringing warmth, whilst smooth pressure continues to stroke at your [clit] and [vagina].");

				outputText("\n\nOnce again, there are difficulties. You have got your dog girl doing three intense things at once, and she performs the balancing act shakily, usually forgetting either to continue frigging you or herself with her mouth full of cock. You keep an eye on her and whisper instruction and encouragement when she flags, although it becomes increasingly difficult as the heat inundating both your male and female genitals grows. ");

				outputText("\n\nEventually you cannot hold your lust back. You grab her by the head and begin to thrust deep into her " + ((player.biggestCockLength() < 8) ? "mouth" : "throat") + ". Her breath hisses through her nose as she lets you use her mouth, struggling to keep her fingers schlicking away; you coo as your own hard movements force her to move her hands fast and erratically, skittering across your urgently bulging button and making you pump into her wet, milking warmth all the more frenetically.");

				outputText("\n\n“<i>Cum, bitch.</i>” you grit as you surge to your own high. Whitney’s muffled moans are what you hear as your cock-slit dilates and pumps jizz down her throat; you crow with delight as your [vagina] quivers and then clenches in orgasm in ecstatic sympathy with your male sex, " + ((player.wetness() <= 2) ? "wetting your slave’s hand" : "absolutely soaking your slave’s arm") + " with femjizz as it does. She shudders around you and her eyes roll as she finds her own high rooting in her pussy; you are extremely gratified to note that, despite being on a plane of submissive pleasure far away, she still manages to swallow every drop of cum you eject");
				if (player.cumQ() >= 1500)  outputText(" which is no mean feat, given it feels like you’ve fucked what feels like a gallon of it down her gullet. Once you’re almost done, as ever you spurt the last few creamy ropes across her face and clothes");
				outputText(".");

				outputText("\n\nYou exhale long and low when you’re finally done, feeling a glow of intense satisfaction. You gaze dozily down at your slave, who is panting hoarsely, her eyes still closed. You can’t help but notice she occasionally and impulsively licks her lips, as if she is searching for the flavor of something delicious.");

				outputText("\n\n“<i>Gods, that was am- something, mistress,</i>” she says eventually. “<i>Did... did I do well?</i>” You rub behind her floppy ear and tell her she’s getting better, but - and you say this pointedly - she’s still quite forgetful. You watch her closely as she mumbles an apology and then sets about cleaning you, first sending her tongue slicking deliciously around your sopping vagina, licking up every splash of your fluids that she finds, before rising up to your oozing [cock biggest]. There’s an eagerness on display here which you don’t think was evident before as she laps at your cock head, and you think she even stifles a disappointed whine when she’s finished. Smiling softly, you get up and send her on her way.");
			}
			//Herm without balls
			else if (player.hasVagina() && player.balls == 0)
			{
				outputText("\n\n“<i>This is a bit more delicate than simply being a good cocksucker, so follow my instruction carefully.</i>” Whitney peers out around your [eachCock]. Her hand is still jammed in her panties and she is panting slightly, color high in her cheeks. You smile at her encouragingly. “<i>Behind my [dickplural] you’ll find my pussy. I think if you’re knelt there pleasuring yourself you should at least be extending the same courtesy to your mistress, hmm? Start slow and gentle to begin with.</i>”");

				outputText("\n\nCarefully, Whitney delves between your [hips], pushing beyond [eachCock] until her smooth, warm fingers are pressing against your [vagina]. She explores your lips, moistened already by her activities with your male genitalia, awkwardly at first but with growing confidence as she builds up an idea of its shape, before slowly pushing into your wet hole.");

				outputText("\n\nShe does at least have some idea what she’s doing here, curling her fingers into herself at the same time as she explores your [vagina], but she’s still frustratingly clumsy at first, struggling to get the angle right, then bumping the tips of her fingers into your [clit] too hard. After you’ve barked in annoyance, her touch is too soft, afraid to hurt you.");

				outputText("\n\nEventually though she starts to get it right, circling your clit slowly before gently running her finger across it, each time making it bulge out of its hood even further. She even manages to stick her index finger into you as she does, curling deliciously at your vaginal walls until your whole female sex feels like it’s unfurled and gleaming with pleasure.");

				outputText("\n\n“<i>Good,</i>” you husk, with some effort keeping your voice level as delicious sensation veins its way through your groin. “<i>Now comes the real test. Keep both hands where they are, and go back to sucking my dick.</i>” Whitney steals a moment’s rest, her hands no doubt aching a bit by now, before pulling back and focusing on your [cock]. You sigh deeply, your eyes closing as your [cockHead biggest] is once again enveloped with sweet, wringing warmth, whilst smooth pressure continues to stroke at your [clit] and [vagina].");

				outputText("\n\nOnce again, there are difficulties. You have got your dog girl doing three intense things at once, and she performs the balancing act shakily, usually forgetting either to continue frigging you or herself with her mouth full of cock. You keep an eye on her and whisper instruction and encouragement when she flags, although it becomes increasingly difficult as the heat inundating both your male and female genitals grows. ");

				outputText("\n\nEventually you cannot hold your lust back. You grab her by the head and begin to thrust deep into her " + ((player.biggestCockLength() < 8) ? "mouth" : "throat") + ". Her breath hisses through her nose as she lets you use her mouth, struggling to keep her fingers schlicking away; you coo as your own hard movements force her to move her hands faster and more erratically, skittering across your urgently bulging button and making you pump into her wet, milking warmth all the more frenetically.");

				outputText("\n\n“<i>Cum, bitch,</i>” you grit as you surge to your own high. Whitney’s muffled moans are what you hear as your cock-slit dilates and pumps jizz down her throat; you crow with delight as your [vagina] quivers and then clenches in orgasm in ecstatic sympathy with your male sex, " + ((player.wetness() <= 2) ? "wetting your slave’s hand" : "absolutely soaking your slave’s arm") + " with femjizz as it does. She shudders around you and her eyes roll as she finds her own high rooting in her pussy; you are extremely gratified to note that, despite being on a plane of submissive pleasure far away, she still manages to swallow every drop of cum you eject");
				if (player.cumQ() >= 1500) outputText(" which is no mean feat, given it feels like you’ve fucked what feels like a gallon of it down her gullet. Once you’re almost done, as ever you spurt the last few creamy ropes across her face and clothes");
				outputText(".");

				outputText("\n\nYou exhale long and low when you’re finally done, feeling a glow of intense satisfaction. You gaze dozily down at your slave, who is panting hoarsely, her eyes still closed. You can’t help but notice she occasionally and impulsively licks her lips, as if she is searching for the flavor of something delicious.");

				outputText("\n\n“<i>Gods, that was am- something, mistress,</i>” she says eventually. “<i>Did... did I do well?</i>” You rub behind her floppy ear and tell her she’s getting better, but - and you say this pointedly - she’s still quite forgetful. You watch her closely as she mumbles an apology and then sets about cleaning you, first sending her tongue slicking deliciously around your sopping vagina, licking up every splash of your fluids that she finds, before rising up to your oozing [cock biggest]. There’s an eagerness on display here which you don’t think was there before as she laps at your cock head, and you think she even stifles a disappointed whine when she’s finished. Smiling softly, you get up and send her on her way.");
			}
			//Male w/ balls:
			else if (!player.hasVagina() && player.balls > 0)
			{
				outputText("\n\n“<i>First of all, before you start each time you must work on these.</i>” With your [cock] raised it is easy enough to expose your [balls] to her. “<i>A good slut knows her master’s balls need a good polish before she’s deserving of swallowing his cock. Let’s see how you do.</i>” ");

				outputText("\n\nAfter a slight pause Whitney sinks her face so far into your groin you can no longer see her expression. You sigh as you feel her flat tongue dance across your sensitive nuts, kneading them gently and bathing them in saliva. This at least is a task perfectly suited to her tongue, you think, and you stifle an insane laugh only with difficulty. “<i>Lick every inch... that’s good. Suckle on them a bit... very good!</i>” You gasp a bit as she envelopes one of your orbs entirely and pulls at it ever so gently, sending delicious sensation thrumming through your crotch.");

				outputText("\n\n“<i>Ooh, you’re a natural.</i>” ");
				//monocock
				if (player.cocks.length == 1)
				{
					outputText("\n\nYou lean back and consider her luxuriously. “<i>Put your other hand here - there we go - and then you can get back to it.</i>” Her other hand clutching one cheek of your [ass], Whitney steals a moment’s rest, the hand buried in her pussy no doubt aching a bit by now, before pulling back and focusing on your [cock biggest]. You sigh deeply, your eyes closing as your [cockHead biggest] is once again enveloped with sweet, wringing warmth, whilst smooth pressure clutches your behind.");

					outputText("\n\nYou keep an eye on her and whisper instruction and encouragement when she flags, although it becomes increasingly difficult as the heat inundating your genitals grows; her finger occasionally presses against the pad of your [asshole], a delightfully slight but hard sensation which serves to deepen the soft pleasure of the mouth your cock is sunk in by contrast.");

					outputText("\n\nEventually you cannot hold your lust back. You grab her by the head and begin to thrust deep into her " + ((player.biggestCockLength() < 8) ? "mouth" : "throat") + ". Her breath hisses through her nose as she lets you use her mouth, struggling to keep her fingers schlicking away; you coo as your own hard movements force her to push slightly into your ass, making you pump into her wet, milking warmth all the more frenetically.");

					outputText("\n\n“<i>Cum, bitch,</i>” you grit as you surge to your own high. Whitney’s muffled moans are what you hear as your cock-slit dilates and pumps jizz down her throat; she shudders around you and her eye rolls as she finds her own high rooting around in her pussy. You are extremely gratified to note that, despite being on a plane of submissive pleasure far above you, she still manages to swallow every drop of cum you eject");
					if (player.cumQ() >= 1500) outputText(" which is no mean feat, given it feels like you’ve fucked what feels like a gallon of it down her gullet. Once you’re almost done, as ever you spurt the last few creamy ropes across her face and clothes");
					outputText(".");
				}
				// Moolticock? Moolticock!
				else
				{
					outputText("\n\nYou lean back and consider her luxuriously. “<i>Now for the second part. This is a bit more technical than simply being a good little ball-licker, so I want you to pay attention.</i>” You move your hips slightly and indicate your [cock biggest2]. “<i>Put your hand around that. I think if you’re knelt there pleasuring yourself you should at least be extending the same courtesy to your master, hmm? Do it slow and gentle to begin with.</i>” ");

					outputText("\n\nYou sigh as after a short pause she slowly she begins to rub you, your neglected second cock quickly hardening in her warm, smooth grasp. Whilst she has plenty of experience with her own cooch she is once again awkward and inexperienced with a male organ in her hand, first holding you gingerly as if it were a missile in her hand and then clenching down too hard when you ask her to hold you closer. Eventually though she begins to get the hang of it, pumping you in a nice rhythm until your [cock biggest2] is bulging, eager and hot from the velvety friction.");

					outputText("\n\n“<i>Good,</i>” you husk, with some effort keeping your voice level as delicious sensation veins its way through your groin. “<i>Now comes the real test. Keep both hands where they are, and go back to sucking my dick.</i>” Whitney steals a moment’s rest, her hands no doubt aching a bit by now, before pulling back and focusing on your [cock biggest]. You sigh deeply, your eyes closing as your [cockHead biggest] is enveloped with sweet, wringing warmth, whilst smooth pressure continues to coil away at your second prick.");

					outputText("\n\nOnce again, there are difficulties. You have got your dog girl doing three intense things at once, and she performs the balancing act shakily, usually forgetting either to continue rubbing either you or herself whilst her mouth is full of cock. You keep an eye on her and whisper instruction and encouragement when she flags, although it becomes increasingly difficult as the heat inundating your obscene male genitals grows. ");

					outputText("\n\nEventually you cannot hold your lust back. You grab her by the head and begin to thrust deep into her " + ((player.biggestCockLength() < 8) ? "mouth" : "throat") + ". Her breath wheezes through her nose as she lets you use her mouth, struggling to keep both sets of her teasing fingers moving; you coo as your own hard movements force her to move the hand on your [cock biggest2] fast and erratically, wringing your urgently bulging prick tightly and making you pump into her wet, milking warmth all the more frenetically.");
				}

				outputText("\n\n“<i>Cum, bitch,</i>” you grit as you surge to your own high. Whitney’s muffled moans are what you hear as your cock-slit dilates and pumps jizz down her throat; she shudders around you and her eye rolls as she finds her own high rooting around in her pussy. You are extremely gratified to note that, despite being on a plane of submissive pleasure far above you, she still manages to swallow every drop of cum you eject");
				if (player.cumQ() >= 1500) outputText(" which is no mean feat, given it feels like you’ve fucked what feels like a gallon of it down her gullet. Once you’re almost done, as ever you spurt the last few creamy ropes across her face and clothes");
				outputText(".");
				if (player.cocks.length > 1) outputText(" The second cock trapped in her grasp flexes out cum just as eagerly as the first, sweat standing out on your forehead as you are clenched by your twin high; it paints her skirt with its generous discharge.");
			}
			//Male without balls:
			else if (!player.hasVagina() && player.balls == 0)
			{
				//multicock
				if (player.cocks.length > 1)
				{
					outputText("\n\n“<i>This is a bit more technical than simply being a good cocksucker, so I want you to pay attention.</i>” You move your hips slightly and indicate your [cock biggest2]. “<i>Put your hand around that. I think if you’re knelt there pleasuring yourself you should at least be extending the same courtesy to your master, hmm? Do it slow and gentle to begin with.</i>” ");

					outputText("\n\nYou sigh as after a short pause she slowly she begins to rub you, your neglected second cock quickly hardening in her warm, smooth grasp. Whilst she has plenty of experience with her own cooch she is again awkward and inexperienced with a male organ in her hand, first holding you too gingerly as if it were a missile in her hand and then clenching down too hard when you tell her to hold you closer. Eventually though she begins to get the hang of it, pumping you in a nice rhythm until your [cock biggest2] is bulging, eager and hot from the velvety friction.");

					outputText("\n\n“<i>Good,</i>” you husk, with some effort keeping your voice level as delicious sensation veins its way through your groin. “<i>Now comes the real test. Keep both hands where they are, and go back to sucking my dick.</i>” Whitney steals a moment’s rest, her hands no doubt aching a bit by now, before pulling back and focusing on your [cock biggest]. You sigh deeply, your eyes closing as your [cockHead biggest] is enveloped with sweet, wringing warmth, whilst smooth pressure continues to coil away at your second prick.");

					outputText("\n\nOnce again, there are difficulties. You have got your dog girl doing three intense things at once, and she performs the balancing act shakily, usually forgetting either to continue rubbing either you or herself whilst her mouth is full of cock. You keep an eye on her and whisper instruction and encouragement when she flags, although it becomes increasingly difficult as the heat inundating your obscene male sex grows. ");

					outputText("\n\nEventually you cannot hold your lust back. You grab her by the head and begin to thrust deep into her " + ((player.biggestCockLength() < 8) ? "mouth" : "throat") + ". Her breath wheezes through her nose as she lets you use her mouth, struggling to keep both both sets of her teasing fingers moving; you coo as your own hard movements force her to move the hand on your [cock biggest2] faster and more erratic, wringing your urgently bulging prick tightly and making you pump into her wet, milking warmth all the more frenetically.");
				}
				//monocock
				if (player.cocks.length == 1)
				{
					outputText("\n\n“<i>Put your other hand here - there we go - and then you can get back to it.</i>” Her other hand clutching one cheek of your [ass], Whitney steals a moment’s rest, the hand buried in her pussy no doubt aching a bit by now, before pulling back and focusing on your [cock]. You sigh deeply, your eyes closing as your cock end is once again enveloped with sweet, wringing warmth, whilst smooth pressure clutches your behind.");

					outputText("\n\nYou keep an eye on her and whisper instruction and encouragement when she flags, although it becomes increasingly difficult as the heat inundating your genitals grows; her finger occasionally presses against the pad of your [asshole], a delightfully slight but hard sensation which serves to deepen the soft pleasure your mouth is sunk in by contrast. ");

					outputText("\n\nEventually you cannot hold your lust back. You grab her by the head and begin to thrust deep into her " + ((player.biggestCockLength() < 8) ? "mouth" : "throat") + ". Her breath hisses through her nose as she lets you use her mouth, struggling to keep her fingers schlicking away; you coo as your own hard movements force her to push slightly into your ass, making you pump into her wet, milking warmth all the more frenetically.");

					outputText("\n\n“<i>Cum, bitch,</i>” you grit as you surge to your own high. Whitney’s muffled moans are what you hear as your cock-slit dilates and pumps jizz down her throat; she shudders around you and her eye rolls as she finds her own high rooting around in her pussy. You are extremely gratified to note that, despite being on a plane of submissive pleasure far above you, she still manages to swallow every drop of cum you eject");
					if (player.cumQ() >= 1500) outputText(" which is no mean feat, given it feels like you’ve fucked what feels like a gallon of it down her gullet. Once you’re almost done, as ever you spurt the last few creamy ropes across her face and clothes");
					outputText(".");
				}
			}

			//male
			if (!player.hasVagina())
			{
				outputText("\n\nYou exhale long and low when you’re finally done, feeling a glow of intense satisfaction. You gaze dozily down at your slave, who is panting hoarsely, her eyes still closed. You can’t help but notice she occasionally and impulsively licks her lips, as if she is searching for the flavor of something delicious.");

				outputText("\n\n“<i>Gods, that was am- something, master,</i>” she says eventually. “<i>Did... did I do well?</i>” You rub behind her floppy ear and tell her she’s getting better, but - and you say this pointedly - she’s still quite forgetful. You watch her closely as she mumbles an apology and then leans back in to clean your oozing [cock biggest]");
				if (player.cocks.length > 1) outputText(" and [cock biggest2]");
				outputText(". There’s an eagerness on display here which you don’t think was there before as she laps at your cock [headplural], and you think she even stifles a disappointed whine when she’s finished. Smiling softly, you get up, dress and send her on her way.");
			}

			player.orgasm();
			dynStats("sen-", 1);
			doNext(camp.returnToCampUseOneHour);
		}

		private function cockOralTrainingStageTwo():void
		{
			clearOutput();
			whitneySprite();

			outputText("Not saying a word, you undo the bottom half of your [armor], exposing your [cock biggest] with a soft smile. Without any need for instruction Whitney gets to work, her hand delving into her underwear with a contented sigh, her eyes focused on the task in front of her as she steadily stokes the heat in her crotch with tight, urgent jerks of her slim body.");

			//Male
			if (!player.hasVagina())
			{

				outputText("\n\n");
				if (player.balls > 0) outputText("\n\nShe begins as you’ve already bid her, bending in to lap at your [balls], silently sending her warm, wet tongue rolling and questing around your gonads, polishing every inch of them, taking each into her mouth intermittently to bathe them in close, sucking attention. ");
				if (player.cocks.length > 1) outputText("She wraps her hand around your [cock biggest2] when she’s ready, giving it an experimental pump before beginning to softly and slowly work it, remembering exactly how to grip and bend its girth as she prepares for the main course.");

				outputText("\n\nShe rises up and engulfs your [cock biggest] in wet, sucking warmness, already hard from the sight of her eager frigging. You sigh as she gets to work, her head bobbing as she sinks more and more of your length into her welcoming mouth. Again there is a slight sense of awkwardness; ");
				if (player.cocks.length > 1) outputText("she occasionally forgets the length bulging in her hand so eager is she to push her lips further down your [cock biggest] and work at her own clit, and you need to murmur to get her to concentrate.");
				else outputText("she still occasionally forgets the length buried in her mouth, so eager is she to work keenly at her own clit, and you need to murmur to get her to concentrate.");
				outputText(" Nonetheless, the worshipful pleasure inundating your groin is close to masterful and you find yourself drifting away on it, closing your eyes and forgetting about instruction, lost entirely in the waves of your bitch’s soft, exact, ecstatic movements, her sighs and slurps filling your ears.");

				outputText("\n\nWhen your orgasm begins to build, stoked so fiercely by your slave’s warm worship, you’re so far away you almost forget to give the order. However as your seed rises you chance a look down, meeting soulful brown eyes gazing back at you, and remember.");

				outputText("\n\n“<i>Cum.</i>” you manage, as you close your eyes and throw yourself into it. Whitney’s muffled moans are what you hear as your body tenses, your cock-slit dilates and you surge jizz down her throat; she shudders around you and her eyes roll as she finds her own high rooting around in her pussy. You are extremely gratified to note that, despite being on a plane of submissive pleasure far above you, she still manages to swallow every drop of cum you eject");
				if (player.cumQ() >= 1500) outputText(" which is no mean feat, given it feels like you’ve fucked what feels like a gallon of it down her gullet. Once you’re almost done, as ever you spurt the last few creamy ropes across her face and clothes");
				outputText(".");
				if (player.cocks.length > 1) outputText(" The second cock trapped in her grasp flexes out cum just as eagerly as the first, sweat standing out on your forehead as you are clenched by your twin high; it paints her skirt with its generous discharge.");

				outputText("\n\nOnce you have tensed your last you sigh beatifically and float high and formless on your post-blowjob haze. You close your eyes as, without any bidding, ");
				if (player.cocks.length == 1) outputText("Whitney cleans your [cock biggest] with her flat tongue, humming as she laps your oozing head clean, deliciously soothing your aching cock.");
				else outputText("Whitney cleans first your [cock biggest2] and then your [cock biggest] with her flat tongue, humming as she laps each of your oozing heads clean, deliciously soothing your aching cock.");

				outputText("\n\n“<i>Did you enjoy that, [master]?</i>” she says with a slightly woozy edge. She looks slightly drunk, her eyes heavy-lidded. “<i>Think I’ve... think I’ve got it.</i>” She’s become very accomplished, but you know instinctively she’s not quite as good as she can be quite yet. Holding her gaze, you tell her she’s doing well - but the very best cocksuckers never stop finding ways of bettering themselves. Your dog girl accepts this will a slight frown.");

				outputText("\n\n“<i>I, I understand [master]. The next time will be the best yet!</i>”");
			}
			// Herm
			else if (player.hasVagina())
			{

				if (player.balls > 0) outputText("\n\nShe begins as you have bidden her, bending in to lap at your [balls], silently sending her warm, wet tongue rolling and questing around your gonads, polishing every inch of them, taking each into her mouth intermittently to bathe them in close, sucking attention.");
				outputText("She slides her hot little fingers between your thighs once she’s worked herself into a lather, finding your [vagina] and slowly beginning to play with it, beckoning at your [clit] with one soft digit whilst another sinks deep into your tunnel, softly sliding in and around your female sex until it is beading needily, opening eagerly to her careful, teasing movements.");

				outputText("\n\nWhen you give a groan of approval to her treatment of your female sex she rises up and engulfs your [cock biggest] in wet, sucking warmness, already hard from the sight of her eager frigging. You sigh as she gets to work, her head bobbing as she sinks more and more of your length into her welcoming mouth. Again there is a slight sense of awkwardness; she occasionally forgets the [vagina] her hand is buried in and you need to murmur to get her to concentrate. Nonetheless, the worshipful pleasure inundating your groin is close to masterful and you find yourself drifting away on it, closing your eyes and forgetting about instruction, lost entirely in the waves of your bitch’s soft, exact, ecstatic movements, her sighs and slurps filling your ears.");

				outputText("\n\nOnce your orgasm begins to build, stoked so beautifully by your slave’s warm worship, you’re so far away you almost forget to give the order. However as your seed rises you chance a look down, meeting soulful brown eyes gazing back at you, and remember.");

				outputText("\n\n“<i>Cum.</i>” you manage, as you close your eyes and throw yourself into it. Whitney’s muffled moans are what you hear as your body tenses, your cock-slit dilates and pumps jizz down her throat; she shudders around you and her eye rolls as she finds her own high rooting around in her pussy. You are extremely gratified to note that, despite being on a plane of submissive pleasure far away, she still manages to swallow every drop of cum you eject. Your [vagina] quivers around her fingers and orgasms in tandem, making you arch your neck to the overwhelming sensation of a double high, soaking her stroking fingers with warm, female approval.");

				outputText("\n\nOnce you have tensed your last you sigh beatifically and float high and formless on your post-blowjob haze; you close your eyes as, without any bidding, Whitney first cleans your pussy with her flat tongue, sending her tongue searching deliciously around your sopping vagina, licking up every trickle of your juices that she finds, before rising up to your oozing [cock biggest]. She hums as she laps its oozing head clean, deliciously soothing your aching cock.");

				outputText("\n\n“<i>Did you enjoy that, mistress?</i>” she says with a slightly woozy edge. She looks slightly drunk, her eyes dilated. “<i>Think I’ve... think I’ve got it.</i>” She’s become very accomplished, but you know instinctively she’s not quite as good as she can be just yet. Holding her gaze, you tell her she’s doing well - but the very best cocksuckers never stop finding ways of bettering themselves. Your dog girl accepts this will a slight frown.");

				outputText("\n\n“<i>I, I understand master. The next time will be the best yet!</i>”");
			}

			player.orgasm();
			dynStats("sen-", 1);
			doNext(camp.returnToCampUseOneHour);
		}

		private function firstCockOralTrainingStageThree():void
		{
			clearOutput();
			whitneySprite();

			outputText("You smile at Whitney as you take off your... you stop, frowning down at her. Did she whimper just then? She’s completely still, staring at you intently with her big, deep, brown eyes. Without saying a word and pretending to be interested in the sky above, you continue to disrobe, doing it slowly, placing every piece of your [armor] down on the ground with careful deliberation. There is no mistaking it this time - as your [cock biggest] finally bobs into view Whitney moans deep in her throat, squirming uncomfortably in her kneeling position as her gaze bores deep into your crotch. You smile softly, sit yourself down, open your [hips] wide, and wait.");

			//Male 
			if (!player.hasVagina())
			{
				outputText("\n\nOnce you have settled yourself down the dog woman immediately sends her hand burying into her underwear, her heavy breath catching in her throat as she stares at your [cock biggest]. It only takes a few seconds of urgent jerking before she spasms forward, her tongue out and eager to begin.");
				if (player.balls > 0) outputText(" You sigh blissfully as the flat, warm flannel-like tongue spreads itself across your [balls], covering every inch, each sensitive orb taken into your slave’s mouth to be suckled gently until they are thrumming and bulging with packed heat, the loving attention laved on them made all the better by the soft, lustful moans drifting up from between your legs as she polishes them.");

				outputText("\n\nShe rises until her head is level with your semi-erect prick and with long, careful, exquisite licks makes it fiercely erect, running her tongue along its full length and then swirling it around your head, pressing into the sensitive spots she knows will make you dense and tight with need.");
				if (player.cocks.length > 1) outputText(" As she bathes your [cock biggest] in delicious sensation she wraps her hand around your [cock biggest2], softening and then tightening her grip, sliding up and down its stem until it is every bit as rock-hard as the one she is lapping at. She no longer struggles with doing three things at once - the wet roughness and the smooth dryness combine beautifully as she continues to frig herself, making you open your mouth to the shifting delectation inundating your overgrowth of cocks.");

				outputText("\n\nWhen she finally envelopes your jutting head with her mouth, you cannot help but groan with delight. She does it ever so slowly, letting her thin lips slide gradually down your shaft whilst hollowing her cheeks with syncopated suction, blanketing more and more of your [cock biggest] in sucking, liquid warmth. Her head bobs as she immediately finds a sensual rhythm, sending her tongue sliding downwards as her mouth withdraws to your bulbous tip and then back up as she buries your length deep into her mouth, using the alternating movement to send pulses of sheer ecstasy through your groin.");

				outputText("\n\nYou close your eyes, happy to sit back and let your pleasure inexorably build. It is here, at last, that you encounter a problem. The wet, sucking seal around your prick stops for a few moments, accompanied by a profound moan, before starting again, only to stop another ten seconds later. You look down, baffled, and after watching your bitch extend and recede a couple of times, you spot the issue: your effort to link pleasure with servicing you in her mind has finally worked too well. ");

				outputText("\n\nWith one hand schlicking away at her sopping pussy Whitney has become so turned on sucking your cock that she has to pause entirely every few moments to stop herself from orgasming against your instructions. Her eyes closed, profoundly concerned with pleasuring you, she grunts in deep frustration as she pauses again to rest around the bulging meat spreading her lips wide, her heat refusing to simmer down. The final part of her training unfolds itself to you in the sunken, red part of your mind and you grin slowly.");

				outputText("\n\n“<i>Stop,</i>” you murmur. There’s a reluctant popping sound. Whitney’s big brown eyes take a while to focus on you around your [eachCock], dazed with dick.");

				outputText("\n\n“<i>Sorry,</i>” she mumbles, actually looking ashamed. “<i>I can’t - ‘s just too hot now. I told you [master], I told you I wouldn’t be any-</i>“ you shush her kindly.");

				if (player.cocks.length > 2)
				{
					outputText("\n\n“<i>Put your other hand on this.</i>” Slowly she withdraws her fingers from her panties and wraps them around your [cock biggest3]. You sigh to the hot, damp pressure now ringing yet another constituent of your obscene tangle of pricks. “<i>Work them both at the same time - that’s it...</i>” She exceeds your expectations by swiftly picking up a steady beat, jerking your cocks with her smooth, exacting grasp in tandem. Focused back on [eachCock] she quickly forgets her doubt, slipping easily back into subspace.");
				}
				else
				{
					outputText("\n\n“<i>Put your hand here.</i>” Slowly she withdraws her fingers from her panties and wraps them around the base of your [cock biggest]. You sigh at the hot, damp pressure now ringing the very bottom of your saliva-glossed member. “<i>Work it right there... that’s it...</i>” You sigh as she swiftly picks up a steady beat");
						if (player.cocks.length > 1) outputText(" jerking both your cocks with her smooth, exacting grasp in tandem");
						outputText(".");
				}

				outputText("\n\n“<i>Now get back to your main task.</i>” You hum with deep approval as once again your [cock biggest] is swaddled in mouth flesh, her tongue sliding up and down your shaft in the same masterful, alternating oscillation");
				if (player.cocks.length > 1)
				{
					outputText(" all the while your [cock biggest2]");
					if (player.cocks.length > 2) outputText(" and [cock biggest3]");
					outputText(" bulge and vibrate with pleasure in her pumping hand");
					if (player.cocks.length > 2) outputText("s");
				}
				outputText(". Though it would be so easy to lose yourself entirely to her expert movements you keep abreast it for now, holding a close eye on the dog woman kneeling in front of you, now entirely devoted to pleasuring you.");

				outputText("\n\nYou don’t even need to look at her to know your plan is working perfectly. Muffled grunts, slurps and moans fill the air below you, Whitney’s mind now linking sexual release so deeply to gratifying you that she drips and throbs to being on her knees having her mouth and hands packed with your cock without any help whatsoever.");

				outputText("\n\nThe sight and sound of her inundates your senses with the same drowning intensity of the pleasure enveloping your maleness and you pump upwards to an irresistible high, grasping her head and beginning to thrust deep into the tight suction of her" + ((player.biggestCockLength() < 8) ? " mouth" : " throat") +". She moans deeply as you begin to use her like this, and even when you’re face fucking her she does exactly the right things, hollowing her cheeks as you pull outwards to suck deliciously at your receding shaft then softening her mouth completely to give you the best access possible to the beautiful, tight warmth of " + ((player.biggestCockLength() < 8) ? "the back of her mouth" : "her gullet") + " as you spear decisively inwards. ");

				outputText("\n\nYou can’t find the words as you fly into your golden, ecstatic high; you throw your head back as you bury as much of your cock into her as you can, sweat standing out on your brow as you bark wordlessly with each bucket of jizz you fountain down her throat. There’s a series of shrill, strangled squeals below you, her body shakes around you and you know without needing to see Whitney is cumming too, purely from the slavering joy of swallowing every last drop of the thick seed thrust into her by her master. ");

				if (player.cocks.length > 1 || player.cumQ() >= 1500) outputText("\n\n");
				if (player.cocks.length > 1)
				{
					outputText("She doesn’t forget the cock");
					if (player.cocks.length > 2) outputText("s");
					outputText(" trapped in her grasp for a moment; she milks");
					if (player.cocks.length > 2) outputText(" them");
					else outputText(" it");
					outputText(" as hard as you’re fucking her mouth, and");
					if (player.cocks.length > 2) outputText(" they flex");
					else outputText(" it flexes");
					outputText(" out cum just as eagerly as the first, delirium seizing you as you are clenched by your");
					if (player.cocks.length == 2) outputText(" twin");
					else if (player.cocks.length == 3) outputText(" triple");
					else outputText(" transcendent");
					outputText(" high;")
					if (player.cocks.length > 2) outputText(" they paint");
					else outputText(" it paints");
					outputText(" her skirt with")
					if (player.cocks.length > 2) outputText(" their");
					else outputText(" its");
					outputText(" generous discharge. ");
				}
				if (player.cumQ() >= 1500)
				{
					outputText("Once you’re almost done, as ever you pull out and spurt the last few creamy ropes across her face and clothes. Red with her own huge high, the dog woman does her level best to catch them in her mouth.");
				}

				outputText("\n\nOnce you have tensed your last you sigh beatifically and float high and formless on your post-blowjob haze. You close your eyes as, without any bidding, " + ((player.cocks.length == 1) ? "Whitney cleans your [cock biggest] with her flat tongue, lapping your oozing head clean, deliciously soothing your aching cock" : "Whitney cleans all of your pricks with her flat tongue, lapping each of your oozing heads clean, deliciously soothing your aching cock") + ". She moans the low, blissed-out moan of an addict as she cleans you up, actually gently pumping your spent [prickplural] to make the last of it drool out. Gods... just these sounds and sensations, the gentle licking at your [cock biggest]’s tip and the little gasping exhale as she manages to coax a final drop onto her thirsty tongue, make you want to do it all over again... if only she hadn’t just drained you utterly. You pull her up before she makes your cock ache even more, pressing her firm, petite body into your [chest] and gaze proudly and complacently at your champion cocksucker.");

				outputText("\n\n“<i>Think I’ve got it,</i>” she whispers, grinning back at you woozily, red throbbing deep in the brown pools of her eyes. You rub her behind the ear and tell her she almost has; there’s one last lesson she has to learn. You grip her tight, hot body for a few moments more and then send her on her unsteady way.");
			}
			//Herm
			else if (player.hasVagina())
			{

			outputText("\n\nOnce you have settled yourself down the dog woman immediately sends her hand burying into her underwear, her heavy breath catching in her throat as she stares at your [cock biggest]. It only takes a few seconds of urgent jerking before she spasms forward, her tongue out and eager to begin. This time she shows remarkable initiative by burying deep into your crotch to first push her lips and questing tongue onto your [vagina]. ");

			outputText("\n\nYou sigh as she laps at your pussy, first circling your outer lips gently before pushing in, smoothing over your sensitive walls before finding your [clit], humming contentedly as she spreads the thin, wet blanket of her tongue over it, pushing and dabbing at it until it is bulging needily and your tunnel is dripping excitement. Given she’s a novice at that, she’s - you gasp as she sends another sumptuous twinge rippling through you - she’s very good. Once she’s got you nice and wet she replaces her masterful tongue with her warm hand, gently fingering your clit as she moves up.");

			if (player.balls > 0) outputText("\n\nYou sigh blissfully as the flat, warm flannel-like tongue spreads itself across your [balls], covering every inch, each sensitive orb taken into your slave’s mouth to be suckled gently until they are thrumming and bulging with packed heat, the loving attention laved on them made all the better by the soft, lustful moans drifting up from between your legs as she polishes them. ");
			outputText("She rises until her head is level with your semi-erect prick and with long, careful, exquisite licks makes it fiercely erect, running her tongue along its full length and then swirling it around your head, pressing into the sensitive spots she knows will make you dense and tight with need. You close your eyes as the pleasure inundating both your male and female sex combine, a slow but brilliant chemical reaction consuming you from within.");

			outputText("\n\nWhen she finally envelopes your jutting head with her mouth, you cannot help but groan with delight. She does it ever so slowly, letting her thin lips slide gradually down your shaft whilst hollowing her cheeks with syncopated suction, blanketing more and more of your [cock biggest] in sucking, liquid warmth. Her head bobs as she immediately finds a sensual rhythm, sending her tongue sliding downwards as her mouth withdraws to your bulbous tip and then back up as she buries your length deep into her mouth, using the alternating movement to send pulses of sheer ecstasy through your groin. ");

			outputText("\n\nYou close your eyes, happy to sit back and let your pleasure inexorably build. It is here, at last, that you encounter a problem. The wet, sucking seal around your prick stops for a few moments, accompanied by a profound moan, before starting again, only to stop another ten seconds later. You look down, baffled, and after watching your bitch extend and recede a couple of times, you spot the issue: your effort to mentally link pleasure with servicing you has finally worked too well.");

			outputText("\n\nWith one hand schlicking away at her sopping pussy Whitney has become so turned on sucking your cock that she has to pause entirely every few moments to stop herself from orgasming against your instructions. Her eyes closed, profoundly concerned with pleasuring you, she grunts in pure frustration as she pauses again to rest around the bulging meat spreading her lips wide, her heat refusing to simmer down. The final part of her training unfolds itself to you in the sunken, red part of your mind and you grin slowly.");

			outputText("\n\n“<i>Stop,</i>” you murmur. There’s a reluctant popping sound. Whitney’s big brown eyes take a while to focus on you around [eachCock], dazed with dick.");

			outputText("\n\n“<i>Sorry,</i>” she mumbles, actually looking ashamed. “<i>I can’t - ‘s just too hot now. I told you [master], I told you I wouldn’t be any-</i>“ you shush her kindly.");

			if (player.cocks.length >= 2)
			{
				outputText("\n\n“<i>Put your other hand on this.</i>” Slowly she withdraws her fingers from her panties and wraps them around your [cock biggest2]. You sigh at the hot, damp pressure now ringing another constituent of your obscene tangle of pricks. “<i>Work them at the same time... that’s it...</i>” She exceeds your expectations by swiftly picking up a steady beat, jerking both your second cock and curling her searching fingers into your [vagina] in tandem, once again making the overwhelming sensation of combined male and female sexual excitement build inside you. Focused back on [eachCock] and pussy she quickly forgets her doubt, slipping easily back into subspace.");
			}
			else
			{
				outputText("\n\n“<i>Put your hand here.</i>” Slowly she withdraws her fingers from her panties and wraps them around the base of your [cock biggest]. You sigh at the hot, damp pressure now ringing the very bottom of your saliva-glossed member. “<i>Work it right there... that’s it...</i>” You sigh as she swiftly picks up a steady beat, wringing the neglected trunk of your cock whilst curling her searching fingers into your [vagina] in tandem, once again making the overwhelming sensation of combined male and female sexual excitement build inside you.");
			}

			outputText("\n\n“<i>Now get back to your main task.</i>” You hum with deep approval as once again your [cock biggest] is swaddled in mouth flesh, her tongue sliding up and down your shaft in the same masterful, alternating oscillation all the while your [vagina] " + ((player.cocks.length >= 2) ? "and [cock biggest2] thrum and vibrate" : "thrums and vibrates") + " with pleasure from her teasing hands. Though it would be so easy to lose yourself entirely to her expert movements you keep abreast it for now, keeping a close eye on the dog woman kneeling in front of you, entirely devoted now to pleasuring you.");

			outputText("\n\nYou don’t even need to look at her to know your plan is working perfectly. Muffled grunts, slurps and moans fill the air below you, Whitney’s mind now linking sexual release so deeply to debasing herself and gratifying you that she drips and throbs to being on her knees and having her mouth and hands packed with your cock, buried in your cunt, without any help whatsoever.");

			outputText("\n\nThe sight and sound of her inundates your senses with the same drowning intensity of the pleasure enveloping your extensive sex and you pump upwards to an irresistible high, grasping her head and beginning to thrust deep into the tight suction of her " + ((player.biggestCockLength() < 8) ? "mouth" : "throat") + ". She moans deeply as you begin to use her like this, and even when you’re face fucking her she does exactly the right things, hollowing her cheeks as you pull outwards to suck deliciously at your receding shaft then softening her mouth completely to give you the best access possible to the beautiful, tight warmth of ");
			if (player.biggestCockLength() < 8) outputText("the back of her mouth");
			else outputText("her gullet");
			outputText(" as you spear decisively inwards.");

			outputText("\n\nYou can’t find the words as you fly into your golden, ecstatic high; you throw your head back as you bury as much of your cock into her as you can, sweat standing out on your brow as you bark wordlessly with each bucket of jizz you fountain down her throat. There’s a series of shrill, strangled squeals below you, her body shakes around you and you know without needing to see Whitney is cumming too, purely from the slavering joy of swallowing every last drop of the thick seed thrust into her by her master. ");

			outputText("\n\nHer fingers slip and slide around your [vagina] and it quivers and contracts in shared orgasm, ");
			if (player.wetness() > 2) outputText("soaking her arm as it gutters your juices, ");
			outputText("heightening the ecstasy you feel to mind-blowing heights. ");
			if (player.cocks.length > 1) outputText(" She doesn’t forget the cock trapped in her grasp for a moment either; she milks it as hard as you’re fucking her mouth, and it flexes out cum just as eagerly as the first, delirium seizing you as you are clenched by your triple high as it paints her skirt with its generous discharge.");
			if (player.cumQ() >= 1500) outputText(" Once you’re almost done, as ever you pull out and spurt the last few creamy ropes across her face and clothes. Red with her own huge high, the dog woman does her level best to catch them in her mouth.");

			outputText("\n\nOnce you have tensed your last you sigh beatifically and float high and formless on your post-blowjob haze. You close your eyes as, without any bidding, ");
			if (player.cocks.length == 1) outputText("Whitney first cleans your [vagina] and then your [cock biggest] with her flat tongue, polishing your dripping pussy and thighs to a shine before lapping your oozing head clean, deliciously soothing your aching cock.");
			else outputText("Whitney uses her flat tongue to clean first your [vagina], polishing your dripping pussy and thighs to a shine, and then each of your pricks, lapping the oozing heads clean, deliciously soothing your aching cocks.");
			outputText(" She moans the low, blissed-out moan of an addict as she cleans you up, actually gently pumping your spent [prickplural] to make the last of it drool out. Gods... just these sounds and sensations, the gentle licking at your [cock biggest]’s tip and the little gasping exhale as she manages to coax a final drop onto her thirsty tongue, make you want to do it all over again... if only she hadn’t so adroitly drained you utterly. You pull her up before she makes your cock ache even more, pressing her firm, petite body into your [chest] and gaze proudly and complacently at your champion cocksucker.");

			outputText("\n\n“<i>Think I’ve got it,</i>” she whispers, grinning back at you woozily, red throbbing deep in the brown pools of her eyes. You rub her behind the ear and tell her she almost has; there’s one last lesson she has to learn. You grip her tight, hot body for a few moments more and then send her on her unsteady way.");
			}

			player.orgasm();
			dynStats("sen-", 1);
			doNext(camp.returnToCampUseOneHour);
		}

		private function cockOralTrainingStageThree():void
		{
			clearOutput();
			whitneySprite();

			outputText("You smirk at the dog woman knelt before you, letting the silence draw out. She watches you with barely contained anticipation, constantly running her tongue over her lips, her short tail whipping against her skirt as you slowly take off the lower components of your [armor]. As before you do it at a tortuously slow pace; you savor the stifled moans and whimpers below you.");

			outputText("\n\nWhen you finally settle down and heft your [cock biggest] into view as the last of Whitney’s restraint breaks down and she pants openly, her tongue lolling out as she stares avidly at the instrument of her downfall. You let it brush gently against her face");
			if (player.cocks.length >= 2) outputText(", allowing your other cock");
			if (player.cocks.length > 2) outputText("s");
			if (player.cocks.length >= 2) outputText(" to unfurl and bob behind it");
			if (player.hasVagina() && player.cocks.length >= 2) outputText(" and");
			if (player.hasVagina()) outputText(", leisurely exposing your moist [vagina]");
			if (player.cocks.length >= 2 && player.hasVagina()) outputText(" at the same time");
			outputText(", perfuming the air around her with your heavy musk.");

			outputText("\n\n“<i>Oh Gods.</i>” she moans, unable to look away as she swallows heavily.");

			outputText("\n\n“<i>Time for the last thing you need to learn,</i>” you say softly. You glory in the result of all your hard work in front of you inwardly but outwardly display no emotion. “<i>I own a lot of sluts who need fucking and not a great deal of time. So if you want to enjoy what I’ve given you, if you want to be a shameless bitch who wants for nothing but being on her knees and sucking my cock, to moan and wet yourself as you drink my cum, then you will have to ask for it. Nicely.</i>”");

			outputText("\n\n“<i>Yes!</i>” The tail wags harder. ");

			outputText("\n\n“<i>All right. Put your hands out in front of you and bend them. Back straight. Good. Now repeat after me: Please [master], may I suck your cock?</i>”");

			outputText("\n\n“<i>Please [master] may I suck your cock,</i>” says Whitney feverishly, blurring the words together, her soulful, needy gaze never leaving yours as she begs in front of you. You lean back and take time to consider it.");

			outputText("\n\n“<i>Very well,</i>” you say coolly. “<i>But next time you will say it clearer. Begin.</i>”");

			// Male 
			if (!player.hasVagina())
			{
				outputText("\n\nShe spasms forward, her tongue out, overwhelmingly eager to do so. ");
				if (player.balls > 0) outputText("You sigh blissfully as the flat, warm flannel-like tongue spreads itself across your [balls], covering every inch, each sensitive orb taken into your slave’s mouth to be suckled gently until they are thrumming and bulging with packed heat, the loving attention laved on them made all the better by the soft, lustful moans up from between your legs as she obsequiously polishes them. ");
				outputText("She rises until her head is level with your semi-erect prick and with long, careful, exquisite licks makes it fiercely erect, running her tongue along its full length and then swirling it around your [cockHead biggest], pressing into the sensitive spots she knows will make you dense and tight with need. She grips it steadily at the base as she does so, every so often giving it a tight squeeze to contrast with a particularly soft lap at your bulging head.");

				if (player.cocks.length > 1) outputText("\n\nAs she bathes your [cock biggest] in delicious sensation she wraps her hand around your [cock biggest2], softening and then tightening her grip, sliding up and down its stem until it is every bit as rock-hard as the one she is lapping at. ");
				if (player.cocks.length > 2) outputText("Finally, she snakes her other hand around your [cock biggest3], rolling her wrist as she gently wrings it with the same sliding thoroughness.} You open your mouth to the shifting delectation inundating your overgrowth of cocks.");

				outputText("\n\nWhen she finally envelopes your jutting head with her mouth, you cannot help but groan with delight. She does it ever so slowly, letting her thin lips slide gradually down your shaft whilst hollowing her cheeks with syncopated suction, blanketing more and more of your [cock biggest] in sucking, liquid warmth. Her head bobs as she immediately finds a sensual rhythm, sending her tongue sliding downwards as her mouth withdraws to your bulbous tip and then back up as she buries your length deep into her mouth, using the alternating movement to send pulses of sheer ecstasy through your groin. ");

				outputText("\n\nYou keep a close eye on your slave bobbing away below you, but there really is no need to. She knows exactly what she’s doing now, every movement of her hands and mouth guided with exact precision to send lavish sensation and dense heat pulsing through your groin. Doing this to you is possibly giving her even more pleasure than what you’re getting. She moans and gasps as she sinks her mouth down your cock, almost as if it were a second vagina you were penetrating, mired in the corrupted tangle of submissive impulses you have planted deep within her. You grin as you admire your petite slave worshiping your body. That would be a thing wouldn’t it, changing her mouth into a nice, wet pussy? Well, you can’t manage that but... you groan as she sends her tongue sliding right down to your base whilst she sucks almost your whole length tight and close... you think she does deserve a mark of recognition, for all her hard learning.");

				outputText("\n\nYou grab hold of those thoughts, filling them with a black power as the drowning intensity of the pleasure inundating your maleness increases and you begin to pump upwards to an irresistible high, grasping her head and beginning to thrust deep into the tight suck of her " + ((player.biggestCockLength() < 8) ? "mouth" : "throat") +". With some effort you stay afloat and consider the dog woman as she whimpers in delight to you hammering into her juicy mouth");
				if (player.balls > 0) outputText(", your saliva-glossed [balls] beating against her chin");
				outputText(". If there is one deficiency to her right now it is her fairly thin, pale lips. No cocksucking champion has lips like that - they need to be big, bee-stung, constantly wet with the movements of a needy tongue. Luscious whore pillows worthy of having your cock slide between them. You push these succulent, evil thoughts deep into your groin, deep into the heat building inexorably there. ");

				outputText("\n\nEven when you’re face fucking her Whitney does exactly the right things, hollowing her cheeks as you pull outwards to suck deliciously at your receding shaft then softening her mouth completely to give you the best access possible to the beautiful, tight warmth of " + ((player.biggestCockLength() < 8) ? "the back of her mouth" : "her gullet") + " as you spear decisively inwards. You can’t find the words as you fly into your golden, ecstatic high; you throw your head back as you bury as much of your cock into her as you can, sweat standing out on your brow as you bark wordlessly with each bucket of jizz you fountain down her throat. ");

				outputText("\n\nThere’s a series of shrill, strangled squeals below you, her body shakes around you and you know without needing to see Whitney is cumming too, purely from the slavering joy of swallowing every last drop of the thick seed thrust into her by her master. ");
				if (player.cocks.length > 1)
				{
					outputText("She doesn’t forget the cock");
					if (player.cocks.length > 2) outputText("s");
					outputText(" trapped in her grasp for a moment; she milks");
					if (player.cocks.length == 2) outputText(" it");
					else outputText(" them");
					outputText(" as hard as you’re fucking her mouth, and");
					if (player.cocks.length == 2) outputText(" it flexes");
					else outputText(" they flex");
					outputText(" out cum just as eagerly as the first, delirium seizing you as you are clenched by your");
					if (player.cocks.length == 2) outputText(" twin");
					else if (player.cocks.length == 3) outputText(" triple");
					else outputText(" transcendent");
					outputText(" high;");
					if (player.cocks.length == 2) outputText(" it paints");
					else outputText(" they paint");
					outputText(" her skirt with ");
					if (player.cocks.length == 2) outputText(" its");
					else outputText(" their");
					outputText(" generous discharge. ");
				}
				outputText("She suddenly gasps in shock, and you quickly look down. Her lips look swollen, and they seem to be darkening.");

				outputText("\n\nGrunting in exultation, you keep pumping your length into her mouth, finding new legs at this overt demonstration of your corrupt power. With each jet of cum you thrust past them, her lips swell up and darken a little more; her eyes roll as they plump up and begin to shine with a wet, depthless black to your frenetic fucking. Eventually you can give her no more and withdrawing you stumble back, stars swimming in your eyes from the force of it.");

				outputText("\n\nYou sigh beatifically and float high and formless on your post-blowjob haze, listening to Whitney slowly coming to her own senses.");

				outputText("\n\n“<i>M-master, what have you done? My mouth... it’s so-</i>” there is a small, wet sound and a sharp inhalation. A moment later, you feel their wet plumpness smothering the beading head of your aching [cock biggest].");

				outputText("\n\nYou may not have given her a second vagina but it swiftly becomes apparent her new full, black lips are almost as sensitive, at least when applied to you. Whitney does not just sigh contentedly as she cleans");
				if (player.cocks.length > 1) outputText(" all of");
				outputText(" your cock");
				if (player.cocks.length > 1) outputText("s");
				outputText(", first kissing your head deep and then lapping you close; she moans like a whore. She thrusts her ass in the air, sending her tongue pushing all around her new cock pillows with the taste of your cum, gently pumping your spent prick");
				if (player.cocks.length > 1) outputText("s");
				outputText(" to make the last of it drool out.");

				outputText("\n\nYou close your eyes and enjoy the delightful touch of her new lips on your groin, searching out every last trace of your musk and lapping it up with a series of exhalations as deep as if instead of just lying there you were giving her the most mind-blowing sex imaginable. She is not just a masterful cock drain now, she’s addicted to you and perfectly equipped for you to make the most out of both qualities.");

				outputText("\n\nYou pull her off before she makes your cock ache even more, pressing her firm, petite body into your [chest] and gaze lazily down at her. Some of the overriding need in her eyes has calmed down a bit, but it will never truly leave her now.");

				outputText("\n\n“<i>I...</i>“ she whispers, licking her succulent black lips. “<i>I think I’ve got it now, master.</i>” You beam at her proudly, and then silently send your taskmistress slut on her woozy, staggering way with a rub behind the ear and a pat on the tush.");
			}
			//Herm 
			else if (player.hasVagina())
			{
				outputText("\n\nShe spasms forward, her tongue out, overwhelmingly eager to do so. She buries herself deep into your crotch, making you laugh and then coo as she pushes her thin lips and questing tongue onto your [vagina]. You sigh as she laps at your pussy, first circling your outer folds gently before pushing in, smoothing over your sensitive walls before finding your [clit], humming contentedly as she spreads her thin, wet blanket of her tongue over it, pushing and dabbing at it until it is bulging needily and your tunnel is dripping excitement. Given she’s a total novice at that, she’s - you gasp as she sends another sumptuous twinge rippling through you - she’s very good. Once she’s got you nice and wet she replaces her masterful tongue with her warm hand, gently fingering your clit as she moves up.");

				if (player.balls > 0) outputText("\n\nYou sigh blissfully as the flat, warm flannel-like tongue spreads itself across your [balls], covering every inch, each sensitive orb taken into your slave’s mouth to be suckled gently until they are thrumming and bulging with packed heat, the loving attention laved on them made all the better by the soft, lustful moans up from between your legs as she obsequiously polishes them.");

				outputText("\n\nShe rises until her head is level with your semi-erect prick and with long, careful, exquisite licks makes it fiercely erect, running her tongue along its full length and then swirling it around your head, pressing into the sensitive spots she knows will make you dense and tight with need. She grips it steadily at the base as she does so, every so often giving it a tight squeeze to contrast with a particularly soft lap at your bulging head. ");
				if (player.cocks.length > 1) outputText("As she bathes your [cock biggest] in delicious sensation she wraps her hand around your [cock biggest2], softening and then tightening her grip, sliding up and down its stem until it is every bit as rock-hard as the one she is lapping at. ");
				outputText(" You close your eyes as the pleasure inundating both your male and female sex twist around each other, a slow but brilliant chemical reaction consuming you from within.");

				outputText("\n\nWhen she finally envelopes your jutting head with her mouth, you cannot help but groan with delight. She does it ever so slowly, letting her thin lips slide gradually down your shaft whilst hollowing her cheeks with syncopated suction, blanketing more and more of your [cock biggest] in sucking, liquid warmth. Her head bobs as she immediately finds a sensual rhythm, sending her tongue sliding downwards as her mouth withdraws to your bulbous tip and then back up as she buries your length deep into her mouth, using the alternating movement to send pulses of sheer ecstasy through your groin. ");

				outputText("\n\nYou keep a close eye on your slave bobbing away below you, but there really is no need to. She knows exactly what she’s doing now, every movement of her hands and mouth guided with exact precision to send lavish sensation and dense heat pulsing through your groin. Doing this to you is possibly giving her even more pleasure than what you’re getting out of it. She moans and gasps as she sinks her mouth down your cock, almost as if it were a second vagina you were penetrating, mired in the corrupted tangle of submissive impulses you have planted deep within her. You grin as you admire your petite cock slave worshiping your body. That would be a thing wouldn’t it, changing her mouth into a nice, wet pussy? Well, you can’t manage that but... you groan as she sends her tongue sliding right down to your base whilst she sucks almost your whole length tight and close... you think she does deserve a mark of recognition, for all her hard learning.");

				outputText("\n\nYou grab hold of those thoughts, filling them with a black power as the drowning intensity of the pleasure inundating your sex increases and you begin to pump upwards to an irresistible high, grasping her head and beginning to thrust deep into the tight suck of her ");
				if (player.biggestCockLength() < 8) outputText("mouth");
				else outputText("throat");
				outputText(". With some effort you stay afloat and consider the dog woman as she whimpers in delight to you hammering into her juicy mouth");
				if (player.balls > 0) outputText(", your saliva-glossed [balls] beating against her chin");
				outputText(". If there is one deficiency to her right now it is her fairly thin, pale lips. No cocksucking champion has lips like that - they need to be big, bee-stung, constantly wet with the movements of a needy tongue. Luscious whore pillows worthy of having your cock slide between them. You push these succulent, evil thoughts deep into your groin, deep into the heat building inexorably there. ");

				outputText("\n\nEven when you’re face fucking her Whitney does exactly the right things, hollowing her cheeks as you pull outwards to suck deliciously at your receding shaft then softening her mouth completely to give you the best access possible to the beautiful, tight warmth of ");
				if (player.biggestCockLength() < 8) outputText("the back of her mouth");
				else outputText("her gullet");
				outputText(" as you spear decisively inwards. You can’t find the words as you fly into your golden, ecstatic high; you throw your head back as you bury as much of your cock into her as you can, sweat standing out on your brow as you bark and howl with each bucket of jizz you fountain down her throat. ");

				outputText("\n\nThere’s a series of shrill, strangled squeals below you, her body shakes around you and you know without needing to see Whitney is cumming too, purely from the slavering joy of swallowing every last drop of the thick seed thrust into her by her [master]. Her fingers slip and slide around your [vagina] and it quivers and contracts in shared orgasm");
				if (player.wetness() > 2) outputText(", soaking her arm as it gutters your juices");
				outputText(", heightening the ecstasy you feel to mind-blowing heights.");
				if (player.cocks.length > 1)
				{
					outputText(" She doesn’t forget the cock trapped in her grasp for a moment; she milks it as hard as you’re fucking her mouth, and it flexes out cum just as eagerly as the first, delirium seizing you as you are clenched by your ");
					if (player.cocks.length == 2) outputText("triple");
					else outputText("transcendent");
					outputText(" high; it paints her skirt with its generous discharge.");
				}

				outputText("\n\nShe suddenly gasps in shock, and you quickly look down. Her lips look swollen, and they seem to be darkening. Grunting in exultation, you keep pumping your length into her mouth, finding new legs at this overt demonstration of your corrupt power. With each jet of cum you thrust past them, her lips swell up and darken a little more; her eyes roll as they plump up and begin to shine with a wet, depthless black to your frenetic fucking. Eventually you can give her no more and withdrawing you stumble back, stars swimming in your eyes from the force of it.");

				outputText("\n\nYou sigh beatifically and float high and formless on your post-blowjob haze, listening to Whitney slowly coming to her own senses.");

				outputText("\n\n“<i>M-mistress, what have you done? My mouth... it’s so-</i>” There is a small, moist sound and a sharp inhalation. A moment later, you feel hands wrap around your [hips] and their wet, frictionless plumpness pressing on your beading [vagina].");

				outputText("\n\nYou may not have given her a second vagina but it swiftly becomes apparent her new full, black lips are almost as sensitive, at least when applied to you. Whitney does not just sigh contentedly as she cleans your sex, sending her mouth smoothing over your throbbing pussy until it practically shines before moving onto your [cockplural], first kissing your head deep and then lapping you close; she moans like a whore. She thrusts her ass in the air, sending her tongue pushing all around her new cock pillows with the taste of your juices, gently pumping your spent [prickplural] to make the last of your cum drool out. ");

				outputText("\n\nYou close your eyes and enjoy the delightful touch of her new lips on your groin, searching out every last trace of your musk and lapping it up with a series of exhalations as deep as if instead of just lying there you were giving her the most mind-blowing sex imaginable. She is not just a masterful cock drain now, she’s addicted to you and perfectly equipped for you to make the most out of both qualities.");

				outputText("\n\nYou pull her off before she makes your cock ache even more, pressing her firm, petite body into your [chest] and gaze lazily down at her. Some of the overriding need in her eyes has calmed down a bit, but it will never truly leave her now.");

				outputText("\n\n“<i>I...</i>“ she whispers, licking her succulent black lips. “<i>I think I’ve got it now, mistress.</i>” You beam at her proudly, and then silently send your taskmistress slut on her woozy, staggering way with a rub behind the ear and a pat on the tush.");
			}

			player.orgasm();
			dynStats("sen-", 1);
			doNext(camp.returnToCampUseOneHour);
		}

		private function cockOralTrainingMaxed():void
		{
			clearOutput();
			whitneySprite();

			outputText("You settle yourself down and discard the lower half of your [armor]. Whitney cannot stop licking her lips as she watches, making their bee-stung black plumpness shine wetly. She is in position long before you heft your [eachCock] into view, already semi-erect with the lustful knowledge of what is to come: back straight, hands up, wrists bent, begging you wordlessly with her brown eyes full of red desire and slowly wagging tail.");

			outputText("\n\n“<i>Please [master], may I suck your cock?</i>” You let a heavy moment go by.");

			outputText("\n\n“<i>Very well,</i>” you say benevolently, opening your [hips]. “<i>I suppose you do deserve it for being such a hardworking task slut.</i>”");

			//Male 
			if (!player.hasVagina())
			{
				outputText("\n\nShe spasms forward, her tongue out, overwhelmingly eager to begin. ");
				if (player.balls > 0) outputText("You sigh blissfully as her plump lips push into your [balls] before the flat, warm flannel-like tongue spreads itself across them, covering every inch, each sensitive orb first sensuously kissed and then taken into your slave’s mouth to be suckled gently until they are thrumming and bulging with packed heat. The loving attention laved on them is made all the better by the soft, lustful moans turning into outright panting sobs of pleasure drifting up from between your legs as she obsequiously polishes them.");

				outputText("\n\nShe rises until her head is level with your semi-erect prick and with long, careful, exquisite licks makes it fiercely erect, running her tongue along its full length and then swirling it around your head, pressing into the sensitive spots she knows will make you dense and tight with need. She grips it steadily at the base as she does so, every so often giving it a tight squeeze to contrast with a particularly soft lap at your bulging head.");
				if (player.cocks.length > 1) outputText(" As she bathes your [cock biggest] in delicious sensation she wraps her hand around your [cock biggest2], softening and then tightening her grip, sliding up and down its stem until it is every bit as rock-hard as the one she is lapping at.");
				if (player.cocks.length > 2) outputText(" Finally, she snakes her other hand around your [cock biggest3], rolling her wrist as she gently wrings it with the same sliding thoroughness.");
				outputText(" You open your mouth to the shifting delectation inundating [eachCock].");

				outputText("\n\nWhen she finally envelopes your jutting head with her mouth, you cannot help but groan with delight. She does it ever so slowly, letting her full, frictionless lips glissade over your sensitive cock slit before opening wide and sliding gradually down your shaft, hollowing her cheeks with syncopated suction, blanketing more and more of your [cock biggest] in sucking, liquid warmth. Her head bobs as she immediately finds a sensual rhythm, sending her tongue sliding downwards as her mouth withdraws to your bulbous tip and then back up as she buries your length deep into her mouth, using the alternating movement to send sheer ecstasy pulsing through your groin. There is no need for instruction anymore, no need to do anything but to enjoy that plump, wet seal sliding up and down your prick, a tide of warm, shifting pleasure which carries you off into an extended sexual euphoria.");

				outputText("\n\nSuch is her mastery now Whitney probably could make you cum any time if she wanted to, but just like you she wants to keep this going for as long as she possibly can, so she blows you incredibly slowly and sensually. Her intermittent hungry moans send pleasurable vibrations through your cock, pushing as much of her sensitive, cum-addicted lips around your girth as she can. ");
				if (player.cocks.length > 1) outputText("In the long, delicious daze that follows you move her around");
				if (player.cocks.length == 2) outputText(", switching her attention to your [cock biggest2] for a while");
				else if (player.cocks.length >= 3) outputText(" switching her attention first to one cock and then the other");
				if (player.cocks.length > 1) outputText(" so that each of your fiercely erect pricks has time to enjoy the tight, sucking embrace of her mouth.");

				outputText("\n\nPushing her all the way down to the base of your [cock biggest] so that the heavy breath through her nose warms your crotch and holding her there for a time, you enjoy the glorious closeness of the back of her "+ ((player.biggestCockLength() < 8) ? "mouth" : "throat"));
				if (player.balls > 0) outputText(" and her tongue once again sliding across your [balls], ");
				outputText("before wrapping your hand through her silky hair and lifting her carefully but firmly all the way up, above your gleaming cock, at a height where she is just able to reach it with her tongue, telling her to cup her peachy breasts as you do. You enjoy the soft lapping at your beading head and the frustrated moans filling your ears at leisure, reveling in the sight of her, attempting to reconcile the memory of the calm, independent dog woman you once knew with the whimpering bitch dangling from your fist and creaming herself from worshiping your cock now.");

				outputText("\n\nYou let her go and she immediately impales herself back onto your length");
				if (player.cocks.length > 1) outputText(", her hands wrapping back around your other cock");
				if (player.cocks.length > 2) outputText("s");
				if (player.cocks.length > 1) outputText(" as if they never left them");
				outputText(" pulling and kneading you now with real need. The drowning intensity of the pleasure inundating your maleness increases and you begin to pump upwards to an irresistible high, grasping her head and beginning to thrust deep into the tight suction of her "+ ((player.biggestCockLength() < 8) ? "mouth" : "throat") +".");

				outputText("\n\nAs always when you’re face fucking her Whitney does exactly the right things, hollowing her cheeks as you pull outwards to suck deliciously at your receding shaft then softening her mouth completely to give you the best access possible to the beautiful, tight warmth of "+ ((player.biggestCockLength() < 8) ? "the back of her mouth" : "her gullet") +" as you spear decisively inwards, her lush cock pillows providing... not resistance but a wonderful squeezing lushness moving up and down your urgently bulging length.");

				outputText("\n\nYou can’t find the words as you fly into your golden, ecstatic high; you throw your head back as you bury as much of your cock into her as you can, sweat standing out on your brow as you bark wordlessly to each bucket of jizz you fountain down her throat. There’s a series of shrill, strangled squeals below you, her body shakes around you and you know without needing to see Whitney is cumming too, purely from the slavering joy of swallowing every last drop of the thick seed thrust into her by her master.");
				if (player.cocks.length > 1)
				{
					outputText(" She doesn’t forget the cock");
					if (player.cocks.length > 2) outputText("s");
					outputText(" trapped in her grasp for a moment; she milks");
					if (player.cocks.length == 2) outputText(" it");
					else outputText(" them");
					outputText(" as hard as you’re fucking her mouth, and");
					if (player.cocks.length > 2) outputText(" they flex");
					else outputText(" it flexes");
					outputText(" out cum just as eagerly as the first, delirium seizing you as you are clenched by your");
					if (player.cocks.length == 2) outputText(" twin");
					else if (player.cocks.length == 3) outputText(" triple");
					else outputText(" transcendent");
					outputText(" high;");
					if (player.cocks.length == 2) outputText(" it paints");
					else outputText(" they paint");
					outputText(" her skirt with");
					if (player.cocks.length == 2) outputText(" its");
					else outputText(" their");
					outputText(" generous discharge.");
				}
				outputText(" Eventually you can give her no more and withdrawing you stumble back, stars swimming in your eyes from the force of it.");

				outputText("\n\nYou sigh beatifically and float high and formless on your post-blowjob haze. A moment later, you feel Whitney’s wet, frictionless plumpness pressing on the beading head of your aching [cock biggest]. She moans whorishly as she savors your flavor on her lips, sending her tongue pushing all around her black plumpness with the taste of your cum, gently pumping your spent [prickplural] to make the last of it drool out so she can indulge in it even more. You close your eyes and enjoy the delightful touch of her corrupt lips on your groin, searching out every last trace of your musk and lapping it up with a series of exhalations as deep as if instead of just lying there you were giving her the most mind-blowing sex imaginable.");
				 
				outputText("\n\nOnce your whole groin has been burnished with saliva to what feels like a brilliant sheen you pull her off and press her firm, petite body into your [chest] and gaze lazily down at her. Some of the overriding need in her eyes has calmed down a bit, but it never truly leaves her now.");

				outputText("\n\n“<i>What do you say, bitch?</i>”");

				outputText("\n\n“<i>Thank you, [master],</i>” your taskmistress slut whispers, licking her succulent black lips as she stares adoringly into your eyes. You give her a fond rub behind a floppy ear and then send her away with a pat on her tight ass, avoiding the considerable damp patch on her skirt as you do.");
			}
			//Herm 
			else if (player.hasVagina())
			{
				outputText("\n\nShe spasms forward, her tongue out, overwhelmingly eager to begin. You sigh as she laps at your pussy, first circling your outer folds gently before pushing in, smoothing over your sensitive walls before finding your [clit], moaning with profound lust as she spreads her thin, wet blanket of her tongue over it, pushing and dabbing at it until it is bulging needily and your tunnel is dripping excitement. ");

				outputText("\n\nGiven the way her breath comes short and fast as she eats you out, pushing her mouth into your [vagina] so that her full lips can press on your clit, it is almost as if she’s tribbing with you. You thrust your pussy into the sucking wetness gleefully at the thought and are rewarded with a high gasp of pure pleasure. As delightful as this is she’s got a lot more ground to cover, so with a subtle movement of the hips you silently tell her to get on with it. She replaces her masterful tongue with her warm hand, gently fingering your clit and wet passage as she moves up.");

				if (player.balls > 0) outputText("\n\nYou sigh blissfully as her plump lips push into your [balls] before the flat, warm flannel-like tongue spreads itself across them, covering every inch, each sensitive orb first sensuously kissed and then taken into your slave’s mouth to be suckled gently until they are thrumming and bulging with packed heat, the loving attention laved on them made all the better by the soft, lustful moans turning into outright panting sobs of pleasure drifting up from between your legs as she obsequiously polishes them.");

				outputText("\n\nShe rises until her head is level with your semi-erect prick and with long, careful, exquisite licks makes it fiercely erect, running her tongue along its full length and then swirling it around your head, pressing into the sensitive spots she knows will make you dense and tight with need. She grips it steadily at the base as she does so, every so often giving it a tight squeeze to contrast with a particularly soft lap at your bulging head.");
				if (player.cocks.length > 1) outputText(" As she bathes your [cock biggest] in delicious sensation she wraps her hand around your [cock biggest2], softening and then tightening her grip, sliding up and down its stem until it is every bit as rock-hard as the one she is lapping at.");
				outputText(" You open your mouth to the shifting delectation inundating both your male and female sex, her teasing digits moving with innate expertise to send twin pleasure twisting through you, a slow but brilliant chemical reaction consuming you from within.");

				outputText("\n\nWhen she finally envelopes your jutting head with her mouth, you cannot help but groan with delight. She does it ever so slowly, letting her full, frictionless lips glissade over your sensitive cock slit before opening wide and sliding gradually down your shaft, hollowing her cheeks with syncopated suction, blanketing more and more of your [cock biggest] in sucking, liquid warmth. Her head bobs as she immediately finds a sensual rhythm, sending her tongue sliding downwards as her mouth withdraws to your bulbous tip and then back up as she buries your length deep into her mouth, using the alternating movement to send sheer ecstasy pulsing through your groin. There is no need for instruction anymore, no need to do anything but to enjoy that plump, wet seal sliding up and down your prick, a tide of warm, shifting pleasure which carries you off into an extended sexual euphoria.");

				outputText("\n\nSuch is her mastery now Whitney probably could make you cum any time if she wanted to, but just like you she wants to keep this going for as long as she possibly can, so she blows you incredibly slowly and sensually. Her intermittent hungry moans send pleasurable vibrations through your cock, pushing as much of her sensitive, cum-addicted lips around your girth as she can, all the while caressing your [clit] and keeping you wetly simmering.");
				if (player.cocks.length > 1) outputText(" In the long, delicious daze that follows you move her around");
				if (player.cocks.length == 2) outputText(", switching her attention to your [cock biggest2] for a while");
				if (player.cocks.length >= 3) outputText(", switching her first to one cock then another");
				if (player.cocks.length > 1) outputText(" so that each of your fiercely erect pricks has time to enjoy the tight, sucking embrace of her mouth.");

				outputText("\n\nPushing her all the way down to the base of your [cock biggest] so that the heavy breath through her nose warms your crotch and holding her there for a time, you enjoy the glorious closeness of the back of her "+ ((player.biggestCockLength() < 8) ? "mouth" : "throat"));
				if (player.balls > 0) outputText(", and her tongue once again sliding across your [balls]");
				outputText(" before wrapping your hand through her silky hair and lifting her carefully but firmly all the way up, above your [cock biggest] at a height where she is just able to reach it with her tongue, telling her to cup her peachy breasts as you do. You enjoy the soft lapping at your beading head and the frustrated moans filling your ears at leisure, reveling in the sight of her, attempting to reconcile the memory of the calm, independent dog woman you once knew with the whimpering bitch dangling from your fist and creaming herself from worshiping your cock now.");

				outputText("\n\nYou let her go and she immediately impales herself back onto your length, sliding her fingers back into your slickened twat");
				if (player.cocks.length > 1) outputText(" and her other hand wrapping back around your [cock biggest2]");
				outputText(" as if they never left them, pulling, kneading and curling into you now with real need. The drowning intensity of the pleasure inundating your sex increases and you begin to pump upwards to an irresistible high, grasping her head and beginning to thrust deep into the tight suction of her "+ ((player.biggestCockLength() < 8) ? "mouth" : "throat") + ".");

				outputText("\n\nEven when you’re face fucking her Whitney does exactly the right things, hollowing her cheeks as you pull outwards to suck deliciously at your receding shaft then softening her mouth completely to give you the best access possible to the beautiful, tight warmth of "+ ((player.biggestCockLength() < 8) ? "the back of her mouth" : "her gullet") +" as you spear decisively inwards. Her lush cock pillows provide no resistance but a wonderful squeezing lushness running up and down your urgently bulging length. You can’t find the words as you fly into your golden, ecstatic high; you throw your head back as you bury as much of your cock into her as you can, sweat standing out on your brow as you bark wordlessly with each bucket of jizz you fountain down her throat. ");

				outputText("\n\nThere’s a series of shrill, strangled squeals below you, her body shakes around you and you know without needing to see Whitney is cumming too, purely from the slavering joy of swallowing every last drop of the thick seed thrust into her by her [master]. Her fingers slip and slide around your [vagina] before bending in and pressing at your sweet spot; it quivers and contracts in shared orgasm, ");
				if (player.wetness() > 2) outputText("soaking her arm as it gutters your juices, ");
				outputText("heightening the ecstasy you feel to mind-blowing heights.");
				if (player.cocks.length > 1) outputText(" She doesn’t forget the [cock biggest2] trapped in her grasp for a moment; she milks it as hard as you’re fucking her mouth, and it flexes out cum just as eagerly as the first, delirium seizing you as you are clenched by your triple high; it paints her skirt with its generous discharge.");
				outputText(" Eventually you can give her no more and withdraw, stars swimming in your eyes from the force of your orgasm.");

				outputText("\n\nA moment later, you feel hands wrap around your [hips] and her wet, frictionless plumpness pressing on your beading [vagina]. Whitney moans like a whore as she cleans your sex, sending her mouth smoothing over your throbbing pussy until every last drop of your femjizz is gone before moving onto your [cockplural], first kissing your head deep and then lapping you close, gently pumping your spent [prickplural] to make the last of your cum drool out. You close your eyes and enjoy the delightful touch of her corrupt lips on your groin, searching out every last trace of your musk and lapping it up with a series of exhalations as deep as if instead of just lying there you were giving her the most mind-blowing sex imaginable. ");

				outputText("\n\nOnce your whole groin has been burnished with saliva to what feels like a brilliant sheen you pull her off and press her firm, petite body into your [chest] and gaze lazily down at her. Some of the overriding need in her eyes has calmed down a bit, but it never truly leaves her now.");

				outputText("\n\n“<i>What do you say, bitch?</i>”");

				outputText("\n\n“<i>Thank you, [master].</i>” your task-slut whispers, licking her succulent black lips as she stares adoringly into your eyes. You give her a fond rub behind a floppy ear and then send her away with a pat on her tight ass, avoiding the considerable damp patch on her skirt as you do.");
			}

			player.orgasm();
			dynStats("sen-", 1);
			doNext(camp.returnToCampUseOneHour);
		}

		private function firstVaginaOralTraining():void
		{
			clearOutput();
			whitneySprite();

			outputText("Slowly the dog woman does as you ask, bending forward, opening her mouth and pushing her mouth against your [vagina] with her flat tongue. Awkwardly, with one hand in her panties, she scooches forward, wraps a thin, strong arm around one of your [hips] to steady herself with a grunt before lapping at your pearly sex, exploring it with careful slides and flicks of the tongue. ");

			outputText("\n\nYou sigh at the delicious sensation, letting her know exactly what pleases you as she runs her wet, warm muscle across every inch she can reach. It’s clumsy, she doesn’t seem to be able to find your [clit]");
			if (player.clitLength > 3) outputText(" despite the fact it must be practically poking her in the eye");
			outputText(", but nonetheless the licking quickly gets you wet and throbbing with urgency. Rather than spear into your tunnel properly though, she keeps tonguing at your entrance, faster and faster. You frown in response; it’s pleasant but not satisfying, and she’s already lost herself in the act, eyes closed and lapping at your groin like a dog going at her...");

			outputText("\n\n“<i>Stop,</i>” you say firmly. She looks up at you, confused. “<i>I am not your butt and I don’t need cleaning. Do it slowly...</i>” You wait until she’s sending her tongue smoothing across your labia again, before rotating your hips gently forwards. “<i>and now push up into me. That’s it!</i>” you gasp as her hot tongue is enveloped in your fleshy warmness, rubbing the walls of your tunnel delightfully. Her sharp teeth rub uncomfortably against the skin around your pussy but with a few whispered instructions they disappear, and you begin to slowly encourage her tongue into your wetness, gripping down to squeeze it close, each time making it push in deeper. ");

			outputText("\n\nThe rest of her body seems frozen aside from the hand rooting in her panties and your clit is bulging with frustration at being left out of the oral pleasure. But that’s all right. It’ll come in time. For now, there is her soft mouth and the delicious pleasure inundating your vagina, her warm hand grasped around your thigh as your urge grips you closer. As she begins to move and curl her ever-so-slightly rough muscle deep within you she moans around your flesh, louder and louder as she...");

			outputText("\n\n“<i>Stop!</i>” you shout again harshly. Surprised brown eyes look up at you and the tongue in your pussy freezes. “<i>Slaves do not get off before their owners,</i>” you say pressingly. “<i>only if you do well enough to make me cum may you have the same privilege. Now... keep licking and fingering. Try to do it at the same time. Nice and slow.</i>” ");

			outputText("\n\nYou let her get back in the rhythm again, pleasuring first the entrance and then your tunnel sensually sinking more and more into you, making you bead excitement onto her lips. Pleasingly, at your explicit instruction she does manage to move both her mouth and the hand buried in her pussy at the same time, and your flesh reverberates deliciously to the occasional muffled moan. ");

			outputText("\n\nWith your blood singing now you let go of your lust’s leash, take hold of her head and begin to thrust it into your [vagina] urgently, the sucking, smoothing warmth of it pushing you towards your high. She copes poorly with your change of pace - there’s the odd “ack!” and “ick!” below you - but you’re beyond caring and anyway, she’s going to have to get used to it. You straighten your back and close your eyes beatifically as you surge to your high, your [clit] bulging above Whitney’s mouth as your pussy quivers and then contracts, seizing your body with pleasure.");

			outputText("\n\n“<i>You may cum now, bitch,</i>” you breathe thickly, in the valley of one of your gratifying pulses.");
			if (player.wetness() >= 5) outputText(" The dog woman coughs and splutters around the delirious streams of fragrant fem-juice you sluice into her mouth with each contraction, guttering even more down her front as it spurts out of her nose and oozes down her chin, but this doesn’t stop her from furiously moving her hand in her knickers, flicking her clit for all she is worth as she attempts to cope with your extravagantly wet snatch at the same time. On the edge already it doesn’t take her long, and her eyes roll as she tenses and shudders, her mouth full of your pussy and the taste of it. The sight is pleasing enough for you to stand up over her and spurt the last few streams of your musky excitement onto her face and clothes. She barely even notices, panting as she keeps fingering herself ecstatically.");
			else outputText(" The dog woman coughs and splutters around the lubricant you dribble into her, some of it dripping out of her nose even as you continue to push yourself into her, but this doesn’t stop her from furiously moving her hand in her knickers, flicking her clit for all she is worth as she attempts to cope with the pressing demand of your snatch. On the edge already it doesn’t take her long, and her eyes roll as she tenses and shudders.");

			outputText("\n\nFinally you both come down. You enjoy the haze of emptiness and post-coitus as you look down at your slave; her eyes are unfocused and she seems to be somewhere else entirely. It is obvious she is a complete novice to pussy licking, but the thought of the challenge ahead of making her an expert fills you with desire. As if she heard your thoughts, Whitney blinks and looks up at you, cum dripping from her chin, smiling unsteadily.");

			outputText("\n\n“<i>Whew. Sorry I wasn’t very good at that, mistress,</i>” she says. “<i>I’m sure one of your other servants would do a much better job of it.</i>” ");

			outputText("\n\nYou tell her not to be silly - she shows great promise. However there are plenty of things she will have to remember, like the need for a slut to clean a pussy she’s been working on after she’s done. The dog girl “oh!”s and quickly bends over your pleasantly aching, puffy sex again. After she’s finished the enjoyable task of licking your dampened crotch clean, you send her on her way.");

			player.orgasm();
			dynStats("sen-", 1);
			doNext(camp.returnToCampUseOneHour);
		}

		private function vaginaOralTrainingStageOne():void
		{
			clearOutput();
			whitneySprite();

			outputText("Sighing, you slide out of the bottom half of your [armor] and tell her with a smile it’s time for another lesson. Whitney wrings her "+ ((whitneyDefurred()) ? "hands" : "paws") +" at the sight of your [vagina] fretfully. You don’t think it’s that she’s reluctant; she’s just afraid she’ll do a poor job. So your instructions are gentle and patient. You tell her to start frigging herself again whilst looking at your exposed crotch, and then when she seems to have lost her anxiety a bit, you tell her to start licking.");

			outputText("\n\nWhat follows is an occasionally frustrating but ultimately satisfying half hour. She can’t seem to kick the instinct to lap at your twat as if it were her own groin, and whilst it’s both a pleasing sensation and quite funny to look at, you have to instruct her quite firmly to make her actually reach into you and pleasure your tunnel. She has a bit of a problem with multi-tasking, sometimes stopping either working her clit or licking your pussy when she gets too much into one or the other. ");

			outputText("\n\nYou know that ahead it’s going to be important for her to work on more than one thing at once, so you are as hard as you can be that she gets this right, going as far as to make her withdraw and slapping her across the face when she gets so into flicking her button she forgets you again. You don’t like doing this because a scolded dog girl is heartbreaking to look at, but needs must. She’s got the basics though; it’s imprinted on her well that she should not got herself off before she finishes with you, and she sighs and moans as she edges herself whilst moving her soft mouth in and around your wet heat. ");

			outputText("\n\nShe still doesn’t seem to realize the importance of your [clit], frustratingly only giving it one or two licks, but there’s a nice bit of rubbing give and take when she’s deep within you, which despite the need to tell her what to do slowly but surely builds your ardor into a blaze, making you forgo words, take her head and begin to thrust her into your sopping redness hard. She still struggles a bit with this but after two pushes she learns to let her mouth go soft and to let her tongue twist into your tunnel. You straighten your back and close your eyes beatifically as you surge to your high, your [vagina] quivering and then clenching, wringing the flat tongue wedged deep within you for all it's worth.");

			outputText("\n\n“<i>You may cum now, bitch,</i>” you breathe thickly, in the valley of one of your gratifying pulses.");
			if (player.wetness() >= 5) outputText(" The dog woman coughs and splutters around the delirious streams of fragrant fem-juice you sluice into her mouth with each contraction, guttering even more down her front as it spurts out of her nose and oozes down her chin. This doesn’t stop her from furiously moving her hand in her knickers, flicking her clit for all she is worth as she attempts to cope with your extravagantly wet snatch at the same time. On the edge already it doesn’t take her long, and her eyes roll as she tenses and shudders, her mouth full of your pussy and the taste of it. The sight is pleasing enough for you to stand up over her and spurt the last few streams of your musky excitement onto her face and clothes. She barely even notices, panting as she keeps fingering herself ecstatically.");
			else outputText(" The dog woman coughs and splutters around the lubricant you dribble into her, some of it dripping out of her nose even as you continue to push yourself into her. This doesn’t stop her from furiously moving her hand in her knickers, flicking her clit for all she is worth as she attempts to cope with the pressing demand of your snatch. On the edge already it doesn’t take her long, and her eyes roll as she tenses and shudders.");

			outputText("\n\nAfter you’re done and withdraw, Whitney goes off into her post coital daze again, and you have to pointedly cough, your [hips] still splayed, for her to remember the last part. You sigh as her warm, flat tongue circles over and around your oozing vagina, pressing warmly onto your dampened thighs, lapping you quite clean. ");

			outputText("\n\n“<i>That was pretty fun mistress,</i>” she says when she’s finished, grinning. Her expression clouds a bit. “<i>you sure this is working, though? I’m beginning to think I’m just not cut out for it.</i>” ");

			outputText("\n\nYou tell her with all the confidence you can muster that she’s progressing fine, and as long as she remembers her lessons she’ll be a champion rug muncher in no time. Whitney nods slowly, apparently trying to believe your words as hard as she can.");

			outputText("\n\n“<i>Alright mistress, I’ll tr... I will!</i>”");

			player.orgasm();
			dynStats("sen-", 1);
			doNext(camp.returnToCampUseOneHour);
		}

		private function firstVaginaOralTrainingStageTwo():void
		{
			clearOutput();
			whitneySprite();

			outputText("Undoing the bottom half of your [armor], you tell her with your usual fond smile it’s time for another lesson. You notice a slight difference to the dog woman kneeled in front of you this time; the usual nervous energy seems to have deserted her, and she focuses on your crotch with a still, quiet determination. You settle yourself down, open your [hips] and, pausing, give no further instruction. ");

			outputText("\n\nYour faith is immediately paid off. Knowing exactly what to do, Whitney slides one of her hands into her undergarments, levelly keeping her gaze on your [vagina], huffing and puffing a bit as she works herself up before opening her mouth and laying her hot, ever-so-slightly rough tongue on your sex. After only a few careful licks, lapping over all the sensitive spots she knows will make you drip, she opens wide and sends her tongue twisting and seeking into your wet, warm flesh. You make a sound of deep approval as she bobs her head up and down, needing no encouragement from you to first curl at your pink walls before withdrawing to inundate your folds in worship. Godsdamn, she’s even found your [clit] at last; she circles it a few times before delightfully smoothing over it, making it bulge well out of its hood. She whimpers around you and begins to move her tongue faster, thrusting in deep, mouth fucking you. If she keeps this up you’re going to reach your high in no time...");

			outputText("\n\nWith some effort, you put a strong hand on her shoulder and silently bid her to stop. Your [vagina] dribbles lube as she withdraws, as frustrated as the worry in Whitney’s eyes is deep.");

			outputText("\n\n“<i>Sorry, mistress. Am I doing something wrong?</i>”");

			outputText("\n\n“<i>Not at all,</i>” you groan, closing your eyes and silently bidding the heat you feel to simmer down slightly. “<i>you’ve been learning well and have come a long way. But now you’ve got the basics down, you need to grasp the other parts of properly servicing me. Now - keep flicking away at that slutty pussy of yours, and I’ll show you.</i>” You wait until the anxiety has melted away from Whitney’s face, replaced with deep lust as her body jerks to the movement of her hand, before beginning.");

			outputText("\n\n“<i>First of all, before you go down on me each time you must start up here.</i>” You let a hand slide slowly across your [chest], your nipples");
			if (player.lactationQ() > 0) outputText(" dripping slightly");
			else outputText(" semi-erect"); 
			outputText(" from the arousal you already feel. “<i>A good slut knows her mistress’s breasts need to be attended to, her nipples and skin shining with a slave’s worship for all the world to see, before she’s deserving of drinking from her pussy. Let’s see how you do.</i>” ");

			outputText("\n\nAfter a slight pause Whitney rises up, puts her arms around your waist, and bends into one of your [nipples]. You sigh as you feel her flat tongue slide across your softness and then over your");
			if (player.hasFuckableNipples()) outputText(" obscene folds");
			else outputText(" sensitive points");
			outputText(", kneading them gently and bathing them in saliva. Given her initial awkwardness at cunnilingus it’s remarkable how good she is at this. “<i>Lick every inch... that’s good. Suckle on them a bit... very good!</i>” You gasp a bit as she envelopes one of your nipples and");
			if (player.hasFuckableNipples()) outputText(" sends her tongue questing into its sensitive inside.");
			else outputText("bites it ever so gently.");
			if (player.lactationQ() > 0)
			{
				outputText(" The gentle kneading is easily enough to make your fecund teats dribble milk into her mouth, and after being slightly startled by it Whitney evidently enjoys the taste of it, because she begins to pull at your plump breast for more. You allow her another mouthful before gently pulling her away.");

				outputText("\n\n“<i>That isn’t for you,</i>” you say quietly. “<i>You can have that much each time, but no more. You quench your thirst by making me cum, understood?</i>” Whitney looks slightly hazy, but she is focused on you by the time you’ve finished.");

				outputText("\n\n“<i>But it’s so... I- I understand, mistress.</i>”");
			}

			outputText("\n\nSighing with pleasure, you idly point downwards again.");

			outputText("\n\n“<i>Now you’ve got that, let’s learn about the other element. This is a bit more delicate, so follow my instruction carefully.</i>” Whitney crouches down again. Her hand is still jammed in her panties and she is panting slightly, color high in her cheeks. You smile at her encouragingly. “<i>You found my clit with your tongue, now I want you to find it with your fingers. Do it nice and slow.</i>”");

			outputText("\n\nCarefully, Whitney delves between your [hips], her smooth, warm fingers sliding across your [vagina]. She explores your lips, moistened already by her recent activities, awkwardly at first but with growing confidence as she builds up an idea of its shape, before slowly pushing at your [clit]. ");

			outputText("\n\nShe does at least have some idea what she’s doing here, curling her fingers into herself at the same time as she is, but she’s still frustratingly clumsy at first, struggling to get the angle right, then bumping the tips of her fingers into your button too hard. After you’ve barked in annoyance her touch becomes too soft, afraid to hurt you. Eventually though she starts to get it right, circling your clit slowly before gently running her finger across it, each time making it bulge out of its hood even further. She even manages to stick her index finger up you as she does, curling deliciously at your vaginal walls until your whole female sex feels like it’s unfurled and gleaming with pleasure.");

			outputText("\n\n“<i>Good,</i>” you husk, with some effort keeping your voice level as delicious sensation veins its way through your groin. “<i>Now comes the real test. Keep both hands where they are, and get back to licking my pussy.</i>” Whitney steals a moment’s rest, her hands no doubt aching a bit by now, before angling her head below her hand and delving her tongue back into your tunnel. You sigh deeply, your eyes closing as your pearly flesh is once again enveloped with sweet, wringing warmth, whilst smooth pressure continues to stroke at your [clit].");

			outputText("\n\nOnce again, there are difficulties. You have got your dog girl doing three intense things at once, and she performs the balancing act shakily, usually forgetting either to continue frigging you or herself with her mouth enveloped by pussy. You keep an eye on her and whisper instruction and encouragement when she flags, although it becomes increasingly difficult as the heat inundating your sex from all directions grows. ");

			outputText("\n\nEventually you cannot hold your lust back. You grab her by the head and begin to thrust firmly against her lashing tongue. Her breath hisses through her nose as she lets you use her mouth, struggling to keep her fingers schlicking away; you coo as your own hard movements force her to move her hands fast and erratically, skittering across your urgently bulging button and making you pump her tongue all the more frenetically.");

			outputText("\n\n“<i>Cum, bitch,</i>” you grit as you surge to your own high. Whitney’s moans are muffled as your [vagina] quivers and then clenches in ecstatic sympathy with your flexing [clit],");
			if (player.wetness() <= 2) outputText(" wetting both your slave’s hand and mouth");
			else outputText(" absolutely soaking your slave’s face and arm");
			outputText(" with femjizz as it does. She shudders around you and her eyes roll as she finds her own high rooting in her pussy; you are extremely gratified to note that, despite being on a plane of submissive pleasure far above you, she still manages to swallow every drop of cum that showers into her mouth");
			if (player.wetness() >= 5) outputText(" which is no mean feat, given it feels like you gutter what feels like a gallon down her gullet. Once you’re almost done, as ever you get up and spurt the last of it on her hair and clothes");
			outputText(".");

			outputText("\n\nYou exhale long and low when you’re finally done, feeling a glow of intense satisfaction. You gaze dozily down at your slave, who is panting hoarsely, her eyes still closed. You can’t help but notice she occasionally and impulsively licks her lips, as if she is searching for the flavor of something delicious.");

			outputText("\n\n“<i>Gods, that was am- something, mistress,</i>” she says eventually. “<i>Did... did I do well?</i>” ");

			outputText("\n\nYou rub behind her floppy ear and tell her she’s getting better, but - and you say this pointedly - she’s still quite forgetful. You watch her closely as she mumbles an apology and then sets about cleaning you, sending her tongue slicking deliciously around your sopping vagina and the soft undersides of your [hips], licking up every trace of your musk and sweat that she finds. There’s an eagerness on display here which you don’t think was there before as she laps at your gently aching clit, and you think she even stifles a disappointed whine when she’s finished. Smiling softly, you get up and send her on her way.");

			player.orgasm();
			dynStats("sen-", 1);
			doNext(camp.returnToCampUseOneHour);
		}

		private function vaginaOralTrainingStageTwo():void
		{
			clearOutput();
			whitneySprite();

			outputText("Not saying a word, you undo your [armor], exposing your whole body with a soft smile. Without any need for instruction Whitney gets to work, her hand delving into her underwear with a contented sigh, her eyes focused on the task in front of her as she steadily stokes the heat in her crotch with tight, urgent jerks of her slim body.");

			outputText("\n\nShe begins as you already bid her, hugging your waist as she laps at your [chest], eyes closed as she silently sends her warm, wet tongue rolling and questing across your softness, varnishing every inch of them with saliva before taking each of your [nipples] into her mouth to bathe them in close, sucking attention. It’s a process which is beautifully sensuous");
			if (player.lactationQ() > 0) outputText(" and it quickly makes the liquid warmth in your breasts rise to a point, beading milk freely from your teats. Whitney laps and sucks it down eagerly, but gratifyingly she remembers your order and stops reluctantly after only taking a single pull");
			outputText(", leaving your nipples");
			if (!player.hasFuckableNipples()) outputText(" rock-hard and");
			outputText(" shining and your [vagina] beading eagerly.");

			outputText("\n\nShe sinks down onto her knees then, sliding her hot little fingers between your thighs whilst she continues to work herself into a lather, finding your [vagina] and slowly beginning to play with it, beckoning at your [clit] with one soft digit whilst another sinks deep into your tunnel, softly sliding in and around your female sex until it is puffy and wet with her careful, teasing movements.");

			outputText("\n\nWhen you give a groan of approval to her treatment of your female sex she bends in and sinks her tongue into your wet, sucking warmness. You sigh as she gets to work, lapping at your entrance, searching and curling into your vagina whilst her firm digits continue to diddle both herself and you. Again there is a slight sense of awkwardness; she occasionally forgets your clit so involved she gets in eating you out and you need to murmur to get her to concentrate. ");

			outputText("\n\nNonetheless, the worshipful pleasure inundating your groin is close to masterful and you find yourself drifting away on it, closing your eyes and forgetting about instruction, lost entirely in the waves of your bitch’s soft, exact, ecstatic movements, her sighs and slurps filling your ears. Once your orgasm begins to build, stoked so beautifully by your slave’s warm worship you’re almost too far away to give the order. However as your heat rises you take a lazy look down to meet soulful brown eyes looking back up at you, and remember...");

			outputText("\n\n“<i>Cum.</i>” you manage, as you close your eyes and throw yourself into it. Whitney’s muffled moans are what you hear as your body tenses, your vagina clenches up, your clit pulses and suddenly you are thrusting into her mouth and hand in an irrepressible orgasm");
			if (player.wetness() >= 5) outputText(", fountaining fem juice down her throat");
			outputText(". She shudders around you and her eyes roll as she finds her own high rooting around in her pussy. You are extremely gratified to note that, despite being on a plane of submissive pleasure far above you, she still manages to swallow every drop of lube you manage to eject into her. You arch your neck to the sensation of a simultaneous clitoral and vaginal high");
			if (player.wetness() >= 5) outputText(", soaking her again and again with warm, female approval");
			outputText(".");

			outputText("\n\nOnce you have tensed your last you sigh beatifically and float high and formless on your post-cunnilingus haze; you close your eyes as, without any bidding, Whitney cleans your pussy with her flat tongue, sending her tongue searching deliciously around your sopping vagina, licking up every trickle of your juices that she finds on your folds and inner thighs, humming as she deliciously soothes you.");

			outputText("\n\n“<i>Did you enjoy that, mistress?</i>” she says with a slightly woozy edge. She looks slightly drunk, her eyes dilated. “<i>Think I’ve - think I’ve got it.</i>” She’s become very accomplished, but you know instinctively she’s not quite as good as she can be quite yet. ");

			outputText("\n\nHolding her gaze, you tell her she’s doing well - but the very best pussy slaves never stop finding ways of bettering themselves. Your dog girl accepts this will a slight frown.");

			outputText("\n\n“<i>I, I understand mistress. The next time will be the best yet!</i>”");

			player.orgasm();
			dynStats("sen-", 1);
			doNext(camp.returnToCampUseOneHour);
		}

		private function firstVaginaOralTrainingStageThree():void
		{
			clearOutput();
			whitneySprite();

			outputText("You smile at Whitney as you take off your... you stop, frowning down at her. Did she whimper just then? She’s completely still, staring up at you intently with her big, deep, brown eyes. Without saying a word and pretending to be interested in the sky above, you continue to disrobe, doing it slowly, placing every piece of your [armor] down on the ground with careful deliberation. There is no mistaking it this time - as you spread your [hips] and expose your [vagina] Whitney moans deep in her throat, squirming uncomfortably in her kneeling position as her gaze bores deep into your crotch. You smile softly, sit yourself down, open your [legs], and wait.");
			 
			outputText("\n\nOnce you have settled yourself down the dog woman immediately sends her hand burying into her underwear, her heavy breath catching in her throat as she stares at you. It only takes a few seconds of urgent jerking before she spasms forward, her tongue out and eager to begin. She radiates heat as she pushes into your abdomen, pressing her mouth into your [chest]. Eyes closed, she silently sends her warm, flannel-like tongue rolling and questing across your softness, varnishing every inch of them with saliva, catching your skin gently here and there in her teeth, making the blood rise to the surface just so you can enjoy her licking all the more;");
			if (!player.hasFuckableNipples()) outputText(" she takes each of your [nipples] into her mouth to bathe them in close, sucking attention");
			else outputText(" she sends her tongue lapping into each of your cunt nipples, curling at their sensitive pink until they are wet with need");
			outputText(". It’s a process which is beautifully sensuous, made all the more gratifying by the soft, lustful moans she makes as she polishes your softness.");
			if (player.lactationQ() > 0) outputText(" It quickly makes the liquid warmth in your breasts rise to a point, beading milk freely from your teats. Whitney laps and sucks it down eagerly, but gratifyingly she remembers your order and stops reluctantly after only taking a single pull.");
			outputText(" She sinks downwards leaving your nipples");
			if (!player.hasFuckableNipples()) outputText(" rock-hard and");
			outputText(" shining, your [vagina] beading eagerly.");

			outputText("\n\nShe slides her hot little fingers between your thighs whilst she continues to work herself into a lather, finding your [vagina] and slowly beginning to play with it, beckoning at your [clit] with one soft digit whilst another sinks deep into your tunnel, softly sliding in and around your pink until it is puffy and wet with her careful, teasing movements. When you give a groan of approval to her treatment of your sex she bends in and sinks her tongue into your wet, sucking warmness. You sigh as she gets to work, lapping at your entrance, searching and curling into your vagina whilst her firm digits continue to diddle both herself and you. ");

			outputText("\n\nShe is masterful at this now, pressing exactly into the spots in your folds she knows will make you drip and twinge, alternating her treatment of your [clit] and [vagina] so one minute she is flicking at your button hard whilst dabbing gently at your entrance with her tongue, the next minute lapping deep into your tunnel, curling at your sweet spot whilst simply holding her fingers gently still around your clit. The intermittent sighs she emits travel through your sex, combining with the deep pleasure already pulsing there and you find yourself drifting away on it, closing your eyes and forgetting about instruction, lost entirely in the waves of your bitch’s soft, exact, ecstatic movements, her sighs and slurps filling your ears.");

			outputText("\n\nIt is here, at last, that you encounter a problem. The wet, sucking mouth around your pussy and the finger at your clit stop for a few moments, accompanied by a profound moan, before starting again, only to stop another ten seconds later. You look down, baffled, and after watching your bitch lap at you for a bit, you spot the issue: your effort to mentally link pleasure with servicing you has finally worked too well. With one hand schlicking away at her sopping pussy Whitney has become so turned on eating you out that she has to pause entirely every few moments to stop herself from orgasming against your instructions. Her eyes closed, profoundly concerned with pleasuring you, she grunts with pure frustration as she pauses again to rest against your pink flesh, her heat refusing to simmer down. The final part of her training unfolds itself to you in the sunken, red part of your mind and you grin slowly.");

			outputText("\n\n“<i>Stop.</i>” you murmur. There’s a reluctant wet sound. Whitney’s big brown eyes take a while to focus on you under your [chest], dazed with pussy.");

			outputText("\n\n“<i>Sorry,</i>” she mumbles, actually looking ashamed. “<i>I can’t - ‘s just too hot now. I told you mistress, I told you I wouldn’t be any-</i>“ you shush her kindly.");

			outputText("\n\n“<i>Take both your hands and wrap them around my thighs. That’s it.</i>” You smile down at your slave, her arms now locked around your [hips]. “<i>Now go back to your main task.</i>” You hum with deep approval as once again your [vagina] is swaddled in mouth flesh. The dog woman only takes a few moments to adapt to the new position, using her dexterous tongue to pleasure both your clit and your sex, sliding in and all around your sex with her thin arms clamped to your hips.");
			if (player.clitLength >= 4) outputText(" She uses her new anchorage to take your bulging fem-dick entirely into her mouth, sucking on it avidly; she hums as she does it, sending ecstatic pleasure thrumming through you.");

			outputText("\n\nThough it would be so easy to lose yourself entirely to her expert movements you keep abreast it for now, keeping a close eye on the dog woman kneeling in front of you, entirely devoted to pleasuring you. You don’t even need to look at her to know your plan is working perfectly. Muffled grunts, slurps and moans fill the air below you, Whitney’s mind now linking sexual release so deeply to debasing herself and gratifying you she drips and throbs to being on her knees and having her mouth buried in your cunt without any help whatsoever.");

			outputText("\n\nThe sight and sound of her inundates your senses with the same drowning intensity of the pleasure inundating your sex and you radiate to an irresistible high, locking her head tight into your sopping sex with your [legs] and beginning to use her mouth with heavy thrusts. She moans deeply as you begin to use her like this, and even when you’re face fucking her she does exactly the right things, spearing her tongue into your depths as you pump inwards and then sliding deliciously out to your entrance, pushing the base of her cloth-like muscle against your clit as you withdraw.");

			outputText("\n\nYou can’t find the words as you fly into your golden, ecstatic high; you throw your head back as you bury as much of yourself into her as you can, sweat standing out on your brow as you cry out and ride your orgasm on her tongue, arching your neck to the sensation of a simultaneous clitoral and vaginal high");
			if (player.wetness() >= 5) outputText(", soaking her mouth and face again and again with warm, female approval");
			outputText(". There’s a series of shrill, strangled squeals below you, her body shakes around you and you know without needing to see Whitney is cumming too, purely from the slavering joy of swallowing every last drop of the musky fruit guttered into her by her mistress.");
			if (player.wetness() >= 5) outputText(" It is in a state of ecstatic momentum that you rise away from her mouth and spurt the last of it onto her hair and clothes. Red with her own huge high, the dog woman does her level best to catch your spotting fluids in her mouth.");

			outputText("\n\nOnce you have tensed your last you sigh beatifically and float high and formless on your post-cunnilingus haze; you close your eyes as, without any bidding, Whitney cleans your pussy with her flat tongue, sending her tongue searching deliciously around your sopping vagina, licking up every trickle of your juices that she finds on your folds and inner thighs, deliciously soothing you. She moans the low, blissed-out moan of an addict as she does it, actually sending her tongue seeking back into your spent [vagina] to find every last trace of fluid.");

			outputText("\n\nGods... just these sounds and sensations, the gentle licking at your cunt and the little gasping exhale as she manages to coax a final drop onto her thirsty tongue, make you want to do it all over again... if only she hadn’t so adroitly drained you utterly. You pull her up before she makes you ache even more, pressing her firm, petite body into your gleaming [chest] and gaze proudly and complacently at your champion pussy licker.");

			outputText("\n\n“<i>Think I’ve got it.</i>” she whispers, grinning back at you woozily, red throbbing deep in the brown pools of her eyes. ");

			outputText("\n\nYou rub her behind the ear and tell her she almost has; there’s one last lesson she has to learn. You grip her tight, hot body for a few moments more and then send her on her unsteady way.");

			player.orgasm();
			dynStats("sen-", 1);
			doNext(camp.returnToCampUseOneHour);
		}

		private function vaginaOralTrainingStageThree():void
		{
			clearOutput();
			whitneySprite();

			outputText("You smirk at the dog woman knelt before you, letting the silence draw out. She watches you with barely contained anticipation, constantly running her tongue over her lips, her short tail whipping against her skirt as you slowly take off the lower components of your [armor]. As before you do it at a tortuously slow pace; you savor the stifled moans and whimpers below you. ");

			outputText("\n\nWhen you finally settle down and expose your [vagina] the last of Whitney’s restraint to sit quietly breaks down and she pants openly, her tongue lolling out as she stares avidly at the instrument of her downfall. You send a hand roaming down your front, sighing dreamily as you touch a [nipple] as you slide down before gasping as you pierce your [vagina] with a single finger, already gleaming with the knowledge of what is ahead. The air is perfumed with your heavy musk.");

			outputText("\n\n“<i>Oh Gods...</i>” Whitney moans, unable to look away as she swallows heavily.");

			outputText("\n\n“<i>I am not sure you deserve this.</i>” you say. You glory in the result of all your hard work in front of you inwardly, slowly fingering yourself, but outwardly display no emotion except faint disdain. “<i>You could not even get halfway through servicing me last time before you were whorishly wetting your panties. Why should I give the task of caring for my beautiful body to such a feckless slut?</i>”");

			outputText("\n\n“<i>Please, mistress,</i>” Whitney says. She tries to keep her voice level but it is difficult when she is salivating as much as she is. She swallows hard before continuing. “<i>I will be good. I can do this. You told me I could, I thought I couldn’t, but now I - I know I can. I... really need this...</i>” ");

			outputText("\n\n“<i>Hmm,</i>” you muse thoughtfully. “<i>ok. If you want to enjoy what I’ve given you, if you want to be my maid bitch who wants for nothing but keeping my pussy, my breasts, my ass properly polished with her tongue, to moan and cream yourself as you drink my juices, then you will have to ask for it. Nicely.</i>”");

			outputText("\n\n“<i>Yes!</i>” The tail wags harder. ");

			outputText("\n\n“<i>All right. Put your hands out in front of you and bend them. Back straight. Good. Now repeat after me: Please milady, may I lick your pussy?</i>”");

			outputText("\n\n“<i>Please milady may I lick your pussy,</i>” says Whitney feverishly, blurring the words together, her soulful, needy gaze never leaving yours as she begs in front of you. You lean back and take time to consider it.");

			outputText("\n\n“<i>Very well,</i>” you say coolly. “<i>But next time you will say it clearer. Begin.</i>”");

			outputText("\n\nShe radiates heat as she pushes into your abdomen, pressing her mouth into your [chest]. Eyes closed, she silently sends her warm, flannel-like tongue rolling and questing across your softness, varnishing every inch of them with saliva, catching your skin gently here and there in her teeth, making the blood rise to the surface just so you can enjoy her licking all the more;");
			if (!player.hasFuckableNipples()) outputText(" she takes each of your [nipples] into her mouth to bathe them in close, sucking attention");
			else outputText(" she sends her tongue lapping into each of your cunt nipples, curling at their sensitive pink until they are wet with need");
			outputText(". It’s a process which is beautifully sensuous.");
			if (player.lactationQ() > 0) outputText(" It quickly makes the liquid warmth in your breasts rise to a point, beading milk freely from your teats. Whitney laps and sucks it down eagerly, whimpering as she withdraws after taking a single pull. You smile softly, knowing that the small, teasing taste of your sweetness only serves to make her thirstier.");
			outputText(" She sinks downwards leaving your nipples");
			if (player.hasFuckableNipples()) outputText(" rock-hard and");
			outputText(" shining, your [vagina] beading eagerly.");

			outputText("\n\nYou rise above her softly and sinuously, looking over your shoulder at her with an aloof smirk as you display your [butt] to her.");

			outputText("\n\n“<i>Doesn’t get as much air-time as my breasts,</i>” you murmur. “<i>But that’s no excuse for a lady’s maid slut, is it? Off you go.</i>” You sigh as, after a moment’s pause, Whitney’s tongue pushes into the top of your crack, sliding downwards to tongue at your [asshole]. She’s a stranger here but she does what feels like a fine job, bathing your rose in lapping attention until it feels sensuously moist and soft, licking all the way down to touch at the outskirts of your [vagina] before smoothing her tongue across your rump, making the whole of your [ass] feel like it is lubricated and shining with warm worship. However the sensation is pleasurable enough for you, giggling quietly, to twist your rump here and there to make absolutely sure she covers every inch.");

			outputText("\n\nThe petite dog girl clutches your [hips] needily, panting softly, as finally you turn and let her at your [vagina]. She beckons at your [clit] with one soft digit whilst another sinks deep into your tunnel, softly sliding in and around your female sex until it is puffy and wet with her careful, teasing movements. When you give a groan of approval to her treatment of your female sex she bends in and sinks her tongue into your wet, sucking warmness. You sigh as she gets to work, lapping at your entrance, searching and curling into your vagina whilst her firm digits continue to diddle both herself and you. ");

			outputText("\n\nShe is masterful at this now, pressing exactly into the spots in your folds she knows will make you drip and twinge, alternating her treatment of your [clit] and [vagina] so one minute she is flicking at your button hard whilst dabbing gently at your entrance with her tongue, the next minute lapping deep into your tunnel, curling at your sweet spot whilst simply holding her fingers gently still around your clit. Finally she abandons her fingers entirely, hooking her hands around your hips as you have shown her and laving the entirety of your snatch with warm, wet worship. The intermittent moans she emits travel through your sex, combining with the deep pleasure already pulsing there and you find yourself drifting away on it, closing your eyes and forgetting about instruction, lost entirely in the waves of your bitch’s soft, exact, ecstatic movements, her sighs and slurps filling your ears.");

			outputText("\n\nYou keep a close eye on your slave nodding away below you, but there really is no need to. She knows exactly what she’s doing now, every movement of her mouth guided with exact precision to send lavish sensation and dense heat pulsing through your groin. Doing this to you is possibly giving her even more pleasure than what you’re getting out of this. She moans and gasps as she pushes her mouth into your softness, almost as if it was a second vagina of hers you were melding with, mired in the corrupted tangle of submissive impulses you have planted deep within her. ");

			outputText("\n\nYou grin as you admire your petite slut worshiping your body. That would be a thing wouldn’t it, changing her mouth into a nice, wet pussy? It would certainly help with the oiling of your body you’ve trained her to perform. Well, you can’t manage that but... you groan as she engulfs your [clit] in shifting wetness, sucking and pulling at it gently... you think she does deserve a mark of recognition, for all her hard learning.");

			outputText("\n\nYou grab hold of those thoughts, filling them with a black power as the drowning intensity of the pleasure inundating your sex increases, and you lock her head tight into your sopping sex with your [hips] and beginning to use her mouth with heavy thrusts. With some effort you stay afloat and consider the dog woman as she whimpers in delight to you hammering into her juicy mouth, clinching your thighs as she awaits your cum. If there is one deficiency to her right now it is her fairly thin, pale lips. No pussy licking champion has lips like that - they need to be big, bee-stung, constantly wet with the movements of a needy tongue. Luscious whore pillows worthy of sliding across every inch of your body. You push these succulent, evil thoughts deep into your groin, deep into the heat building inexorably there. ");

			outputText("\n\nShe moans deeply as you use her like this, and even when you’re face fucking her she does exactly the right things, spearing her tongue into your depths as you pump inwards and then sliding deliciously out to your entrance, pushing the base of her cloth-like muscle against your clit as you withdraw. You can’t find the words as you fly into your golden, ecstatic high; you throw your head back as you bury as much of yourself into her as you can, sweat standing out on your brow as you cry out and ride your orgasm on her tongue, arching your neck to the sensation of a simultaneous clitoral and vaginal high");
			if (player.wetness() >= 5) outputText(", soaking her mouth and face again and again with warm, female approval");
			outputText(".");

			outputText("\n\nThere’s a series of shrill, strangled squeals below you, her body shakes around you and you know without needing to see Whitney is cumming too, purely from the slavering joy of swallowing every last drop of the musky fruit guttered into her by her mistress. She suddenly gasps in shock, and you quickly look down. Her lips look swollen, and they seem to be darkening. Grunting in exultation, you keep working her tongue, pumping your [hips] powerfully into her face, finding new legs at this overt demonstration of your corrupt power. With each gush of fem-juice you dribble onto them, her lips swell up and darken a little more; her eyes roll as they plump up and begin to shine with a wet, depthless black to your frenetic fucking. Eventually you can give her no more and you stumble backward, stars swimming in your eyes from the force of it. You sigh beatifically and float high and formless on your post-cunnilingus haze, listening to Whitney slowly coming to her own senses.");

			outputText("\n\n“<i>M-mistress, what have you done? My mouth... it’s so-</i>” There is a small, moist sound and a sharp inhalation. A moment later, you feel hands wrap around your [hips] and their wet plumpness pressing on your beading [vagina].");

			outputText("\n\nYou may not have given her a second vagina but it swiftly becomes apparent her new full, black lips are almost as sensitive, at least when applied to you. Whitney does not just sigh contentedly as she cleans your sex, sending her mouth smoothing over your throbbing pussy, she moans like a whore, her ass in the air, sending her tongue pushing all around her new pussy pillows with the taste of your juices, before sending it seeking back into your spent [vagina] to find every last trace of fluid. You close your eyes and enjoy the delightful touch of her new lips on your groin, searching out every last trace of your musk and lapping it up with a series of exhalations as deep as if instead of just lying there you were giving her the most mind-blowing sex imaginable. ");
			 
			outputText("\n\nPerhaps you are just imagining it, but it feels like she is producing more saliva now, and not only that but it has the very slightest clinging, oily quality to it. You pull her off before she makes your cunt ache even more, pressing her firm, petite body into your [chest] and gaze lazily down at her. Some of the overriding need in her eyes has calmed down a bit, but it will never truly leave her now. Not only is she a champion pussy-licker, she’s addicted to you and perfectly equipped for you to make the most out of both qualities. ");

			outputText("\n\n“<i>I-</i>“ she whispers, licking her succulent black lips. “<i>I think I’ve got it now, milady.</i>” ");

			outputText("\n\nYou beam at her proudly, and then silently send your taskmistress slut on her woozy, staggering way with a rub behind the ear and a pat on the tush.");

			player.orgasm();
			dynStats("sen-", 1);
			doNext(camp.returnToCampUseOneHour);
		}

		private function vaginaOralTrainingMaxed():void
		{
			clearOutput();
			whitneySprite();

			outputText("You settle yourself down and dismantle your [armor]. Whitney cannot stop licking her lips as she watches, making their bee-stung black plumpness shine wetly. She is in position long before you expose your [vagina] into view, already moist with the lustful knowledge of what is to come: back straight, hands up, wrists bent, begging you wordlessly with her brown eyes full of red desire and slowly wagging tail.");

			outputText("\n\n“<i>Please milady, may I lick your pussy?</i>” You let a heavy moment go by.");

			outputText("\n\n“<i>Very well,</i>” you say benevolently, opening your [hips]. “<i>I suppose you do deserve it for being such a hardworking task-slut.</i>”");

			outputText("\n\nShe radiates heat as she pushes into your abdomen, pressing her mouth into your [chest]. Eyes closed, she silently pushes her plump lips into your softness before she sends her warm, flannel-like tongue rolling and questing across your skin, varnishing every inch of them with clinging saliva, catching your skin gently here and there in her teeth, making the blood rise to the surface just so you can enjoy her licking all the more;");
			if (!player.hasFuckableNipples()) outputText(" she envelopes each of your [nipples] with her lips, kissing them with their sumptuous sponginess before bathing them in close, sucking attention");
			else outputText(" she pushes her lips against your cunt nipples before sending her tongue gently into each of them, curling at their sensitive pink until they are oozing wetness in delight");
			outputText(". It’s a process which is beautifully sensuous, made all the better by the soft, lustful moans she makes as she polishes your bust.");
			if (player.lactationQ() > 0) outputText(" It quickly makes the liquid warmth in your breasts rise to a point, beading milk freely from your teats. Whitney laps and sucks it down eagerly, whimpering as she withdraws after taking a single pull. You smile softly, knowing that that small, teasing taste of your heavy sweetness only serves to make her thirstier.");
			outputText(" Having left your [chest] gleaming with warm, oily saliva and your nipples");
			if (!player.hasFuckableNipples()) outputText(" rock-hard and");
			outputText(" shining, she sinks down to the next stage.");

			outputText("\n\nYou don’t have to turn as you rise; she slides around herself, her fingers trail longingly down your waist and over your [hips] as she kneels behind you and pushes her hot tongue into the cleavage of your [butt], sliding downwards to tongue at your [asshole].  She first licks your valley quite clean of salt and musk, bathing your rose in lapping attention until it feels sensuously moist and soft, before smoothing her lips and tongue carefully across your ");
			if (player.buttRating < 4) outputText("firm butt");
			if (player.buttRating < 8) outputText("supple rump");
			else outputText("soft ass");
			outputText(", oiling it to a sheen. She makes little gasping, stifled breaths as she goes about it, and a grin comes to your lips.");

			outputText("\n\n“<i>You can stop pretending that licking your mistress’s ass doesn’t make you wet.</i>” you murmur softly. “<i>When I turned you into my maid bitch dignity was the last thing I was thinking about.</i>” She whimpers, long and low, and you sigh as she pushes her plump lips against your anus and buries her tongue deep in your passage, losing yourself in the smooth, obsequious movements of her horny, hot mouth. She makes the whole of your [butt] feel like it is lubricated and shining with warm worship, however the sensation and sound of her is pleasurable enough for you to twist your rump here and there to make absolutely sure she covers every inch, her servile moans and wet licks filling your ears. You make her kiss each cheek before continuing.");

			outputText("\n\nThe petite dog girl clutches your [hips] needily, panting softly, as she finally scooches around to get at your [vagina], beading lushly to the treatment she has lavished on the other sensitive parts of your body. She beckons at your [clit] with one soft digit whilst another sinks deep into your tunnel, softly sliding her fingers over and around your female sex until it is puffy and wet with her careful, teasing movements. When you give a hum of approval she bends in and sinks her tongue into your wet, sucking warmness. You cannot help opening your mouth and arching your back when she does; her plump lips press into your entrance and clit, and when she begins to search and curl her tongue in your depths her soft blackness slides over your folds without friction. ");

			outputText("\n\nShe is masterful at this now, pressing exactly into the spots in your folds she knows will make you drip and twinge, alternating her treatment of your [clit] and [vagina] so one minute she is flicking at your button hard whilst dabbing gently at your entrance with her tongue, the next minute lapping deep into your tunnel, curling at your sweet spot whilst simply holding her fingers gently still around your clit. ");

			outputText("\n\nEventually she abandons her fingers entirely, hooking her hands around your hips as you have shown her and laving the entirety of your sex in warm, wet worship. The intermittent moans she emits travel through your sex, combining with the deep pleasure already pulsing there and you find yourself drifting away on it, closing your eyes and forgetting about instruction, lost entirely in the waves of your bitch’s soft, exact, ecstatic movements, her sighs and slurps filling your ears. There is no need for instruction anymore, no need to do anything but enjoy that plump wetness and ever-so-slightly rough tongue sliding in, over and around your pink, a tide of warm, shifting pleasure which carries you off into an extended sexual euphoria.");

			outputText("\n\nSuch is her mastery now Whitney probably could make you cum any time if she wanted to, but just like you she wants to keep this going for as long as she possibly can. She eats you incredibly slowly and sensually, her intermittent moans sending pleasurable vibrations through your sex, pushing as much of her sensitive, cum-hungry lips into your [vagina] as she can, caressing your [clit] with them, keeping you wetly simmering. Such is the way she gasps and twitches when she presses her lips in it really is as if she had a second vagina, that instead of being licked you were in fact tribbing with her mouth. The thought makes you press back into her eagerly, working your hips, and you are rewarded with the sound of muffled, docile delight as your folds squeeze into her wet mouth. ");

			if (player.clitLength >= 4) outputText("\n\nAfter a couple more minutes of slow licking and revolving your hips into her you wrap your hand through her silky hair and carefully but firmly lift her up so she is just in tongue’s reach of your clit, spearing way out of its hood, telling her thickly to cup her breasts as you do. You enjoy the soft lapping at the tip of your fem-cock, sending twinges of pure ecstasy through your sex, and her frustrated moans which accompany it at leisure, reveling in the sight of her, attempting to reconcile the memory of the calm, independent dog woman you once knew with the whimpering pussy slave dangling from your fist and creaming herself from worshiping you now.");

			outputText("\n\nYou push her down deep onto your [clit], making her envelope it with her juicy mouth by clinching your hips around her head. She licks at you with real need now, attacking your clit with her tongue intently before sliding into your pussy, making you cry out yourself as she presses at your sweet spot again and again. Unable and unwilling to control yourself anymore you begin to hump into her, pushing towards your high. ");

			outputText("\n\nShe moans deeply as you use her like this, and even when you’re face fucking her she does exactly the right things, spearing her tongue into your depths as you pump inwards and then sliding deliciously out to your entrance, pushing the base of her cloth-like muscle against your clit as you withdraw. You can’t find the words as you fly into your golden, ecstatic high; you throw your head back as you bury as much of yourself into her as you can, sweat standing out on your brow as you cry out and ride your orgasm on her tongue, arching your neck to the sensation of a simultaneous clitoral and vaginal high");
			if (player.wetness() >= 5) outputText(", soaking her mouth and face again and again with warm, female approval");
			outputText(".");

			outputText("\n\nThere’s a series of shrill, strangled squeals below you, her body shakes around you and you know without needing to see Whitney is cumming too, purely from the slavering joy of swallowing every last drop of the musky fruit guttered into her by her mistress. Eventually you can give her no more and you stumble backward, stars swimming in your eyes from the force of it.");

			outputText("\n\nA moment later, you feel hands wrap around your [hips] and their wet, frictionless plumpness pressing on your beading [vagina]. Whitney moans whorishly as she cleans your sex, sending her mouth smoothing over your throbbing pussy and inner thighs before sliding it seeking back into your spent [vagina] to find every last trace of fluid. You close your eyes and enjoy the delightful touch of her new lips on your groin, searching out every last trace of your musk and lapping it up with a series of exhalations as deep as if instead of just lying there you were giving her the most mind-blowing sex imaginable.");

			outputText("\n\nOnce your whole groin has been burnished with saliva to what feels like a brilliant sheen you pull her off and press her firm, petite body into your [chest] and gaze lazily down at her. She has done a fine job - your whole body feels oiled, massaged and relaxed, the saliva coating your erogenous zones making you resonate with a calm, laid-back carnality. You feel that with your maid bitch’s lubricant clinging to you and in this open state of mind you could take almost any penetration, and furthermore enjoy it thoroughly. As for her, some of the overriding need in her eyes has calmed down a bit - but that will never truly leave her now. ");

			outputText("\n\n“<i>What do you say, bitch?</i>” you murmur.");

			outputText("\n\n“<i>Thank you, milady.</i>” your task-slut whispers, licking her succulent black lips as she stares adoringly into your eyes. You give her a fond rub behind a floppy ear and then send her away with a pat on her tight ass, avoiding the considerable damp patch on her skirt.");

			// (Vaginal and Anal Wetness set to max for a day
			player.orgasm();
			dynStats("sen-", 1);
			if (player.wetness() < 5 && rand(4) == 0) player.vaginas[0].vaginalWetness++;
			doNext(camp.returnToCampUseOneHour);
		}

		private function whitneyDomPleasure():void
		{
			clearOutput();
			whitneySprite();

			if (flags[kFLAGS.WHITNEY_DOM_FIRST_PLEASURE] == 0)
			{
				firstWhitneyDomPleasure();
				flags[kFLAGS.WHITNEY_DOM_FIRST_PLEASURE] = 1;
			}
			else
			{
				repeatWhitneyDomPleasure();
			}

			var scenes:Array = new Array();

			if (!player.isTaur()) scenes.push(whitneyDomBondageOral);
			if (player.hasCock() || player.hasVagina()) scenes.push(whitneyDomStraponDoggy);
			if (player.hasCock()) scenes.push(whitneyDomRide);

			doNext(scenes[rand(scenes.length)]);
		}

		private function firstWhitneyDomPleasure():void
		{
			outputText("You are slightly apprehensive about this, but you’ve gone to the trouble of crafting Whitney into a fairly unique slave, and it seems churlish not to test just how deep the dominating streak you’ve brought out in her goes. You tell her you could do with a bit of relaxation.");

			outputText("\n\n“<i>Of course, [master]. Relaxation,</i>” murmurs Whitney. She drops a heavy tonal wink over her last two words as she entwines her arm around yours. “<i>Perhaps you’d like to come inside my house? Been making one or two, mmm, adjustments I’d like you to see.</i>” She may be quite petite but it strikes you how strong a lifetime of physical labor has made her; it feels like a small, hot bundle of rope wrapped around your arm which is leading you up the board steps and through the door of Whitney’s farmhouse.");

			outputText("\n\nHer front rooms are pretty much what you expected- sparsely but cosily furnished, polished wood and burnished iron much in evidence- but Whitney is not interested in giving you a tour. She leads you upstairs, opens the door to her bedroom and, with a wide, toothy grin, directs you to have a look inside. ");

			outputText("\n\nIt takes quite a while for you to properly absorb it all. Unless she was a secret doginatrix all along Whitney has certainly not been slow acquiring all she needs, in her fevered opinion, to take care of you. Her bed is covered with snarls of intricate leather straps and metal cuffs, blindfolds, ropes and gags sat on a nearby table, and a truly alarming cityscape of dildos, plugs and candles are stacked neatly on her dresser. The decor of the room is the same modest, plain white and wooden brown which is found everywhere else in Whitney’s house; it makes the disquietingly thorough array of BDSM equipment which decorates it all the more startling. You ask wonderingly where she found all this stuff.");

			outputText("\n\n“<i>No questions,</i>” she says thickly. There is a distinct click as she locks the door behind you and then walks to you, staring unwaveringly into your eyes as she deliberately invades your personal space, so close you can feel the motion of her lips as she speaks. “<i>While y’are within these four walls, you belong to me, and I don’t let things that belong to me speak unless they’re given permission. Now here you are [name], and I have you all to myself. I need satisfaction, and you are going to give it me, in exactly the way </i>I<i> want.</i>” She finishes in a deep, hungry growl, her red-tinted eyes dropping to your body, already pulling it this way and that in the corrupted eye of her mind.");

			outputText("\n\nFor a single moment anger rises up within you, a desire to take her to task for talking that way to you- but no. This is exactly what you asked for. It feels so relaxing to let someone else be in charge for once. She and you may have used the word jokingly but that’s exactly what this acceptance now dawning on you is- relaxing. When she pushes you firmly in the chest you follow her impatient action and fall backwards on to the bed - and just that, allowing yourself to be directed by another’s overriding sexual need, closed up here in the sanctuary of this room, feels very good indeed.");

			outputText("\n\n“<i>Undress,</i>” she directs curtly, and you do so meekly whilst watching her do the same. She rips off her plain work clothes quickly as if she were irritated by them, not driven by any need to put on a show for you, simply overwhelmingly eager to begin. You suddenly feel both very warm and slightly shaky.");
		}

		private function repeatWhitneyDomPleasure():void
		{
			outputText("You say you could do with some relaxation.");

			outputText("\n\n“<i>So soon after the last time?</i>” a delighted Whitney whispers as she wraps her arm around yours tightly. “<i>Guess I’m not relaxing you hard enough.</i>” Again she leads you into her house, again she leads her into her chamber, again she locks the door securely before pushing you feverishly onto her bed, leather straps and buckles shifting beneath you as she begins to strip.");

			outputText("\n\n“<i>Undress,</i>” she directs curtly, and you do so meekly, watching her do the same. She rips off her plain work clothes quickly as if she were irritated by them, not driven by any need to put on a show for you, simply overwhelmingly eager to begin. The now familiar sensation of feeling both warm and shaky returns; you would be lying if you said you didn’t welcome it.");
		}

		// TODO : Split this up
		private function whitneyDomBondageOral():void
		{
			clearOutput();
			whitneySprite();

			outputText("Whitney climbs on top of your supine form, her hands pressing into your [chest], firm hips clenching around your abdomen as she considers you.");

			outputText("\n\n“<i>Yes,</i>” she says after a moment, “<i>this’ll do. Lie still.</i>”");

			if (player.isBiped())
			{
				outputText("\n\nShe works fast as she grabs the leather binds secured to each corner of the bedstead one after the other, threading them around your limbs and jerking them taut with a sharp, sure yank. It only takes a minute at most for you to be spread-eagled, helpless across the bed. It hazily occurs to you what great knot-tying skills you probably pick up around a farm as she clambers back on top of you.");
			}
			else if (player.isNaga())
			{
				outputText("\n\nIt’s obvious she put some thought into this. Your long, heavy tail is wrapped around two of the bed knobs, then secured with leather straps; two more straps secure your wrists to their opposite numbers, jerked taut with sharp, sure yanks. It hazily occurs to you what great knot-tying skills you probably pick up around a farm as she clambers back on top of you.");
			}
			else if (player.isDrider())
			{
				outputText("\n\nIt’s obvious she put some thought into this. She has had long, leather straps attached to the underside of the bed; these are wrapped around the joining of your spindly legs to your heavy abdomen, leaving your chitinous feet pointing helplessly at the ceiling. Two more straps secure your wrists, jerked taut with sharp, sure yanks. It hazily occurs to you what great knot-tying skills you probably pick up around a farm as she clambers back on top of you.");
			}
			else if (player.isGoo())
			{
				outputText("\n\n“<i>I can’t secure you properly,</i>” she breathes, squeezing your gooey form, sinking her fingers into it. “<i>Owing to this nonsense you call a body. So I will just say it again. Lie. Still.</i>” She takes your unresisting wrists and secures them to the bed knobs at the head of her bed.  It hazily occurs to you what great knot-tying skills you probably pick up around a farm as she clambers back on top of you.");
			}
			else
			{
				trace("Missing player body-type, welp.")
			}

			outputText("\n\nYou have a moment to see the overriding urge in her eyes before her knees slide past your ears, her slim thighs lock around your neck and your view is taken up entirely by her pussy, her smooth, neat labia puffy and wet with lust. There is no warning, no teasing; she simply shoves her sopping sex against your mouth, your jaw and ears devoured by the hot, tight muscle of her hips, the soft flat of her abdomen pushing into your forehead. You can’t move or see, and can barely breathe; there is only her cunt, demandingly pushing against your face as her lower body thrusts against your head, and there is only one thing you can do. You press your lips onto hers and push your tongue through her wet opening.");

			outputText("\n\nShe makes a wordless, bestial noise and begins to buck into you, her hips clenching and unclenching around your head vigorously as you lap at her channel before bending your tongue deep into her. You feel hot, dry hands circle your trapped wrists, using them for leverage as you withdraw slightly to send your tongue sliding over her tiny, bulging button. You are immediately rewarded with another bark of joy and a gush of femcum straight down your throat, making you choke and splutter. She continues to ride your face hard, the slightest fuck not given.");

			outputText("\n\n“<i>S’it,</i>” comes her voice. Whitney sounds like she’s on a plain of pleasure far above you. Her grip on your arms tightens. “<i>S’it! Now up. Up!</i>” You can guess what that means. You recover enough to sink your tongue deep into her beading pussy, and she immediately clenches around it, trapping it up there before beginning to use it for all she’s worth. The bed creaks briskly as you lick her tight tunnel, your universe becoming a stifling world of tight flesh, brown " + ((whitneyDefurred()) ? "skin" : "fur") + " and the smell and taste of female excitement. Whitney makes a breathless sound as her pussy contracts around your tongue, her stomach batting into your forehead, and you’re treated to another small, warm trickle of her fluids running down your chin. ");

			outputText("\n\nHer thighs relax and rise a bit, allowing you to join her in panting for breath and recover a bit. In a disconnected daze you watch her " + ((whitneyDefurred()) ? "smooth" : "furry") + " calves shift around you until she is facing the other way, but it is only when you feel her place her hands on your own [hips] that you fully realize that she’s not done with you yet.");

			outputText("\n\n“<i>Glad we got the edge off there,</i>” her lilting voice floats down to you. The pressing tone is gone, replaced with a lazier, playful one. “<i>Whew! Now then. I don’t believe I told you to stop...</i>” she says as she sinks her hips down, her oozing pussy sitting straight back onto your lips as her warm butt cheeks press over your eyes. Your groan is stifled by the returning, smothering demand of her sex. It’s impossible to struggle against it pulled tight as you are, and you are forced to do as she asks, moving your tongue over her sweltering folds in a soft, attentive way you hope will please her. “<i>That’s it. Nice an’ slow, take your time. While you’re doing that, let’s see what you got down here for me, hmm?</i>” You close your eyes as you feel her fingers run softly up your inner thighs.");

			// Male: 
			if (player.hasCock() && !player.hasVagina())
			{
				outputText("\n\nHer dry, smooth digits touch your turgid [cock biggest] at the base, rising slowly up the sensitive stem.");
				if (player.totalCocks() > 1) outputText(" “<i>So many things to play with tucked away in here!</i>” comes her merry voice again, as you feel her grasp your [cock smallest] at the same time; you groan into the confines of her flesh as she gives it a soft, teasing pump. It’s obvious your main member has really caught her attention though, and both her hands soon return to it.");

				outputText("\n\nThe rough oral you’ve been forced to give has sunk heat into your loins and it doesn’t take much of her hands’ gentle stroking for your cock to stand at full mast. You continue to lap away at her moist sex, working away from her labia momentarily to lick up the lubricant which has trickled out before bending in again, directed by the sounds of gratification coming from above you. ");

				outputText("\n\nShe lifts her thighs up and then heavily drops them down, up and then down, allowing you to breathe momentarily before pressing her hot, heavy need imperiously down again. All the while she continues stroking your [cock biggest], letting her hand go soft and then suddenly pumping it with tight vigor. She works her grasp all around your cock but concentrates particularly on the sweet spot two thirds of the way up, stroking that sensitive, bulging stretch over and over. Gods, that is good. You feel your orgasm rising, you begin to thrust your [hips] towards it... Whitney’s hand suddenly grips fiercely around your cock, making you almost choke into her twat.");

				outputText("\n\n“<i>No,</i>” she says. It’s in the same light, teasing tone, but such is the cold steel underlying it you feel a finger run down your spine. “<i>You’re not going anywhere until you get me off again. Until then...</i>” Her hand begins to move again, wringing and stroking your cock with loving care until you feel your blood rising again - and then she grips hard, forcing you back down, but not far, as the teasing begins afresh a few seconds later. ");

				outputText("\n\nYou’re trapped here, being edged with horrible expertise by your slave mistress - you’ve got to make her cum a second time before this drives you mad! You attack her pussy with a vengeance, using the smoldering need suppressed in every other part of your body to tongue at her pearly channel as hard as you can, lapping at the wet softness briskly before turning your attention to her clit again, flicking at it with the very tip of your tongue before smothering it with your mouth. ");

				outputText("\n\nYour masterful ministrations elicit a coo from her and she rewards your diligent work by lifting her lower body upwards again, allowing you take a deep, gulping breath before she sits down hard, once again riding your face with hot, wiry, determined energy. Her thighs close around your ears, your eyes are covered by her shifting, jouncing butt and your whole world narrows down to your mouth fucking and being fucked, whilst her smooth, loving, tormenting fingers keep you perpetually edged, your bulging [cock biggest] almost singing with frustration.");

				outputText("\n\nHer thighs clench almost painfully tight into your neck and you feel rather than hear her cry out exultantly as she begins to ride your face with all she’s got. Your tongue is almost sucked into her clenching tunnel and all you can do is curl your mouth into it, your lips pushing against her bulging button as you lave her sensitive vagina as hard as possible, her clear fluids beading down your cheeks and into your mouth. ");

				outputText("\n\nAs you push her upwards she flicks your [cockHead biggest] with a finger pad once, twice, and then begins to jerk it hard and unceasingly, pulling it back towards your smothered head almost painfully hard. With the fierce action comes surging ecstasy however as you’re finally let go, your seed finally allowed to rise. Her pussy spasms around your tongue and she cries out, thrusting and clenching downwards on you, guttering wetness on you; stars swim across your vision as seconds later you’re allowed to reach your own high. You thrust your hips into it, your body caught in helpless convulsion as you fountain cum, spattering back down onto your stomach and [hips]. You can’t see it but it feels like you must be hitting the ceiling with it, you’re that pent up, Whitney’s unrelenting, smooth grasp that good.");
			}
			else if (player.hasCock() && player.hasVagina())
			{
				// Herm: 
				outputText("\n\nHer dry, smooth digits touch your turgid [cock biggest] at the base, rising slowly up the sensitive stem. ");

				outputText("\n\n“<i>Got so many things to play with tucked away in here!</i>” comes her merry voice again, as you feel her other hand creep between your thighs and touch the lips of your [vagina]; you groan into the confines of her flesh as her fingers slide into your crevice, circling your [clit]. The rough oral you’ve been subjected to has sunk heat into your loins and it doesn’t take much of her hands’ gentle but insistent working of your cock and cunt for you to stand at full mast, for you to start beading excitement. ");

				outputText("\n\nYou continue to lap away at her own moist sex, working away from her labia momentarily to lick up the lubricant which has trickled out before bending in again, directed by the sounds of gratification coming from above you. She lifts her thighs up and then heavily drops them down, up and then down, allowing you to breathe momentarily before pressing her hot, heavy need imperiously down again, all the while stroking your [cock biggest], letting her hand go soft and then suddenly pumping it with tight vigor. She works her grasp all around your cock but concentrates particularly on the sweet spot two thirds of the way up, stroking that sensitive, bulging stretch over and over. ");

				outputText("\n\nHer other hand curls into your female sex, probing deeper into your [vagina], stroking at your sensitive walls, withdrawing to flick at your clit, bulging now well out of its hood. Gods, that is good. You feel your orgasm rising, you begin to thrust your [hips] towards it... Whitney’s hands suddenly grip fiercely around your cock and withdraw entirely from your pussy, making you almost choke into her twat.");

				outputText("\n\n“<i>No,</i>” she says. It’s in the same light, teasing tone, but such is the cold steel underlying it you feel a finger run down your spine. “<i>You’re not going anywhere until you get me off again. Until then...</i>” Her hand begins to move again, wringing and stroking your cock with loving care until you feel your blood rising again - and then she grips hard, forcing you back down, but not far, as the teasing begins afresh a few seconds later. ");

				outputText("\n\nYou’re trapped here, being edged with horrible expertise by your slave mistress - you’ve got to make her cum a second time before this drives you mad! You attack her pussy with a vengeance, using the smoldering need suppressed in every other part of your body to tongue at her pearly channel as hard as you can, lapping at the wet softness briskly before turning your attention to her clit again, flicking at it with the very tip of your tongue before smothering it with your mouth.");

				outputText("\n\nYour masterful ministrations elicit a coo from her, as she rewards your diligent work by lifting her lower body upwards again, allowing you to take a deep, gulping breath before sitting down hard, once again riding your face with hot, wiry, determined energy. Her thighs close around your ears, your eyes are covered by her shifting, jouncing butt and your whole world narrows down to your mouth fucking and being fucked, whilst her smooth, loving, tormenting fingers keep you perpetually edged, your bulging [cock biggest] almost singing with frustration.");

				outputText("\n\nHer thighs clench almost painfully tight into your neck and you feel rather than hear her cry out exultantly as she begins to ride your face with all she’s got. Your tongue is almost sucked into her clenching tunnel and all you can do is curl your mouth into it, your lips pushing against her bulging button as you lave her sensitive vagina as hard as possible, her clear fluids beading down your cheeks and into your mouth.");

				outputText("\n\nAs you push her upwards she flicks your [cockHead biggest] with a finger pad once, twice, and then begins to jerk it hard and unceasingly, pulling it back towards your smothered head almost painfully. At the same time you feel her other hand burrow between the joining of your thighs, spearing back into your [vagina], curling at your prostate at the same time as filling your wet hole, finger fucking you forcefully.");

				outputText("\n\nWith the fierce action comes surging ecstasy as you’re finally let go, your seed finally allowed to rise. Her pussy spasms around your tongue and she cries out, thrusting and clenching downwards on you, guttering wetness on you; stars stream across your vision as seconds later you’re allowed to reach your own high. You thrust your hips into it, your body caught in helpless convulsion as you fountain cum and stream femjizz, spurting your fluids deliriously. You can’t see it but it feels like you must be hitting the ceiling and soaking the bed with it, you’re that pent up, Whitney’s unrelenting, smooth grasp is that good.");
			}
			else if (player.hasVagina() && !player.hasCock())
			{
				// Female: 
				outputText("\n\nHer dry, smooth digits flow down your mound, creep between your thighs and touch the lips of your [vagina]; you groan into the confines of her flesh as her fingers slide into your crevice, circling your [clit]. The rough oral you’ve been subjected to has sunk heat into your groin and it doesn’t take much of her hands’ gentle but insistent working of your cunt for you to start beading excitement.");

				outputText("\n\nYou continue to lap away at her own moist sex, working away from her labia momentarily to lick up the lubricant which has trickled out before bending in again, directed by the sounds of gratification coming from above you. She lifts her thighs up and then heavily drops them down, up and then down, allowing you to breathe momentarily before pressing her hot, heavy need imperiously down again.");

				outputText("\n\nWhilst her hips smother your face, her hands curl into your female sex, one probing deep into your [vagina], stroking at your sensitive walls, whilst the other circles and flicks at your clit, bulging now well out of its hood. Gods, that is good. You feel your orgasm rising, you begin to thrust your [hips] towards it... Whitney’s hands suddenly withdraw entirely from your pussy and a hand smacks flat on your stomach, making you almost choke into her twat.");

				outputText("\n\n“<i>No,</i>” she says. It’s in the same light, teasing tone, but such is the cold steel underlying it you feel a finger run down your spine. “<i>You’re not going anywhere until you get me off again. Until then...</i>” Her hand begins to move again, ever so gently stroking your clit until you feel your blood rising again - and then she withdraws, forcing you back down, but not far, as the teasing begins afresh a few seconds later.");

				outputText("\n\nYou’re trapped here, being edged with horrible expertise by your slave lesbian mistress- you’ve got to make her cum a second time before this drives you mad! You attack her pussy with a vengeance, using the urge physically suppressed in every other part of your body to tongue at her pearly channel as hard as you can, lapping at the wet softness briskly before turning your attention to her clit again, flicking at it with the very tip of your tongue before smothering it with your mouth.");

				outputText("\n\nYour masterful ministrations elicit a coo from her, as she rewards your diligent work by lifting her lower body upwards again so you can take a deep, gulping breath before sitting down hard, once again riding your face with hot, wiry, determined energy. Her thighs close around your ears, your eyes are covered by her shifting, jouncing butt and your whole world narrows down to your mouth fucking and being fucked, whilst her smooth, loving, tormenting fingers keep you perpetually edged, your bulging [clit] almost singing with frustration.");

				outputText("\n\nHer thighs clench almost painfully tight into your jaw and you feel rather than hear her cry out exultantly as she begins to ride your face with all she’s got. Your tongue is almost sucked into her clenching tunnel and all you can do is curl your mouth into it, your lips pushing against her bulging button as you lave her sensitive vagina as hard as possible, her clear fluids beading down your cheeks and into your mouth.");

				outputText("\n\nAs you push her upwards she flicks your [clit] with a finger pad once, twice, and then spears the fingers of her other hand back into your [vagina], curling at your sweet spot as she attacks your clit, finger fucking you forcefully. With the fierce action comes surging ecstasy as you’re finally let go, your seed finally allowed to rise. Her pussy spasms around your tongue and she cries out, thrusting and clenching downwards on you, guttering wetness on you; stars stream across your vision as seconds later you’re allowed to reach your own high. You thrust your hips into it, your body caught in helpless convulsion as you spurt femjizz deliriously. You can’t see it but it feels like you must be soaking the bed, you’re that pent up, Whitney’s unrelenting, smooth fingers are that good.");
			}

			// {merge}
			outputText("\n\nShe thrashes into you forcefully for as long as you continue to spurt and dribble ");
			if (player.hasCock()) outputText("cum");
			else outputText("femcum");
			outputText(", and only after relaxing for a long, heavy moment on your face does she finally slide off you. You heave and pant for breath, still cuffed to the bed, rivulets of femcum trickling down your face, your tongue and ");
			if (player.hasCock()) outputText("[cock biggest]"); 
			if (player.hasCock() && player.hasVagina()) outputText(" and ");
			if (player.hasVagina()) outputText("[vagina]");
			outputText(" aching, oozing. In a deep, post-coital haze you feel someone take a towel to your body before curling into you, throwing a dense thigh over you, holding and running her hands over you possessively as you recover. ");

			outputText("\n\nIt’s only after these enforced cuddles that Whitney finally undoes your clasps and lets you get up. She watches you dress with heavy-lidded satisfaction and sighs wistfully as you get up and head to the door. But one session at a time with this creature you’ve created is about as much as you think you can physically take.");

			outputText("\n\n“<i>I hope you feel suitably relaxed, [master],</i>” she says. “<i>Ready to take on the world and bring it to your heel? Me an’ this room will always be here when you need to get in touch with your true self.</i>”");

			player.orgasm();

			doNext(camp.returnToCampUseOneHour);
		}

		private function whitneyDomStraponDoggy():void
		{
			clearOutput();
			whitneySprite();

			outputText("Once her clothes are off, Whitney climbs onto the bed with you. She takes a few seconds to consider you, and you can’t help but do the same to her; drink in her slim, supple frame, her narrow thighs and arms threaded with tight muscle, moderated by the slight touches of softness here and there. Particularly her small, perky breasts with their hard, brown nipples. Your eyes come up to meet hers, knowing and wicked.");

			outputText("\n\n“<i>Glad you’re enjoying the view,</i>” she says, a grin twitching the corners of her mouth. “<i>Now you’re going to return the favor. Turn around. On your knees.</i>” Slowly you do " + ((!player.isBiped()) ? "as close as you can to what" : "") + " she asks, shifting yourself around on your lower body until you are facing the other way. A hand firmly presses into the back of your head, forcing your nose down into the clean-smelling sheets and your ass up. Heat spreads across your face as Whitney’s other hand lands on your [butt] and moves across it with a testing, admiring possessiveness.");

			outputText("\n\n“<i>D’you know how hard it is to control myself when you’re striding around outside, swinging this bit of business around behind you?</i>” she says huskily. The hand on your head has disappeared; there’s a repetitive, slippery sound coming from behind you and you don’t have to guess to know where it’s gone. “<i>D’you bend over so much just to tease me? I swear you do. I swear you do, you secret little slut.</i>” She grasps your rump hard suddenly, making you gasp. “<i>All the other slaves ‘kin look, but only I get to touch it like this. And I ain’t gonna waste that. I’m gonna make you pay for flauntin’ such a nice, " + ((player.buttRating <= 4) ? "tight ass" : "big bottom") + ", I swear... sit still.</i>”");

			outputText("\n\nHer hand withdraws and you listen to her move around the room behind you before returning to the bed, landing a number of objects on it as she returns to your rear with a business-like zeal. Your hands are grabbed and tied firmly behind your back with what feels like silk rope.");
			if (player.isBiped() || player.isTaur()) outputText(" Next, she pushes your ankles apart, threads a leather strap around each and then pulls them tight with a sharp yank; you carefully test them and find with a cold thrill that there is a metal bar attached between them, forcing you to stay in this position.");
			else if (player.isDrider()) outputText(" You don’t struggle as she then forces your spindly legs beneath the bed, looping a leather strap attached to the frame around them all, trapping them there.");
			else if (player.isNaga()) outputText(" She then ties your reptilian coils around the bedposts, securing them with leather straps fitted for the purpose.");
			else trace("Couldn't determine body type, welp.");

			outputText("\n\nIn a position of complete supplication, your face and [chest] forced down into the bed, you look up in trepidation as your monstrously skilled slave mistress shifts around to your front end. She’s smiling her fanged smile down at you as she dangles the last two items she retrieved from her dressing table.");

			// PC female & has Vapula
			if (player.hasVagina() && !player.hasCock() && kGAMECLASS.vapula.vapulaSlave())
			{
				outputText("\n\nThe wooden paddle in one hand perhaps isn’t much of a surprise, but the other... it’s a double ended strap-on, one end relatively small and flexible-looking, the other a purple monster with garish leopard spots painted across its bumps. It’s immediately recognizable to you and you look up at Whitney with a kind of horror, whose grin only widens.");

				outputText("\n\n“<i>Oh yes. Your succubus was only too glad to let me borrow this when I asked her for help in the bedroom with you. D’you know, she seemed to have the darndest idea you were going to use it on me? Shows how much she knows. Oh c’mon, [name],</i>” she croons, waggling the demonic dildo in front of you teasingly. “<i>As if you never fantasized about gettin it from the other end. And as if you’ve got a choice at this point anyway.</i>”");
			}
			else
			{
				outputText("\n\nThe wooden paddle in one hand isn’t much of a surprise, the other... it’s a double ended dildo fitted with straps, evidently designed to fuck the wearer whilst they themselves are fucking. One end of the shiny black device is relatively small and flexible-looking, the other a thick, nine inch monster with smooth nodules on the end. Whitney’s grin widens as you take it in slowly.");

				outputText("\n\n“<i>Can you guess which end I’m giving you, [name]? Can you? Well... as much as I’d like to keep you in suspense...</i>”");
			}

			outputText("\n\nYou watch as Whitney slowly pushes the smaller end against her pussy, already puffy and wet from her frenetic schlicking. She closes her eyes and sighs dreamily as she slides it in, filling her tight passage up with smooth plastic until she reaches the straps. She returns your gaze heavy-lidded as she buckles herself up, laughing to herself as she swings the thick end around in front of you before dissolving into cooing as the dildo now wedged securely in her cunt bends into her. ");

			outputText("\n\nOnce she’s done you discover she’s got one last surprise for you. She kneels down, almost level with your face, one hand between your [hips] whilst the other searches around on the floor. You close your eyes, unable to stop her gently stroking " + ((player.hasCock()) ? "your semi-erect [cock]" : "the inner lips of your [vagina]") + " even if you wanted to, opening your mouth to sigh as she sends shivers of pleasure through your core.");

			outputText("\n\nYour eyes bulge open as smooth, damp cotton is suddenly shoved past your lips. You retch slightly but the hand behind it is insistent, and your mouth is soon filled with the white garment as well as the heavy, musky scent of it. “<i>You’ll sound a lot cuter muffled,</i>” whispers Whitney, admiring the sight of your mouth filled with her panties. “<i>And I want you to understand what you put me through. Why I gotta pound that ass as hard as I’m gonna.</i>” So saying, she waddles behind your bound, supplicant form.");

			outputText("\n\nA shiver runs down your spine as you feel the thick end of the dildo slap down between your butt cheeks. There really is nothing you could do to stop this frenzy of a woman you’ve stirred into being; with your hands bound behind you and your [vagOrAss] forced to present itself like a bitch in heat, you can only kneel and endure. ");

			outputText("\n\nWhitney rests her thick dildo against the pad of your [asshole],");

			if (player.hasVagina())
			{
				outputText(" slowly leading it down until it touches your labia, teasing you with it gently with slow inward movements. She gently parts your lips, letting the studs on the tip touch against your [clit] and your soft tunnel before withdrawing, rotating the head around the entrance of your [vagina] to make her end dig into her until she’s sighing with pleasure. You can’t help but moan around the damp panties in kind as your pussy softens and wets itself to the insistent motion. This is the signal Whitney seems to have been waiting for. With one firm movement she penetrates you, the thick dildo spreading you wide as the knobbed head spears deep into your depths.");
			}
			else
			{
				outputText("teasing you with it gently with slow inward movements. She insistently forces the faux cock against your rose, letting you feel each stud as they enter before withdrawing, rotating the head against your butt to make her end dig into her sex until she’s sighing with pleasure. You can’t help but moan around the damp panties in kind to the insistent motion. This seems to be the signal Whitney was waiting for. With one firm movement she penetrates you, the thick dildo spreading you wide as the knobbed head spears deep into your depths.");

			}

			// wet and/or loose
			var capacity:Number = (player.hasVagina()) ? player.vaginalCapacity() : player.analCapacity();
			if (capacity >= 36)
			{
				outputText("\n\nThe dog woman huffs in surprise as she slides her prosthetic length in with ease, your ");
				if (player.hasVagina()) outputText("deep, eager vagina");
				else outputText("oily, well-used passage");
				outputText(" eagerly swallowing it up until her hard hips are pressed against your [butt].");
				
				if (player.hasVagina())
				{
					player.cuntChange(36, true, true, false);
				}
				else
				{
					player.buttChange(36, true, true, false);
				}

				outputText("\n\n“<i>You’re no stranger to cock, are you [boy]?</i>” she breathes. You jerk in shock as the paddle lands with a sharp report on your ass cheek. “<i>When you aren’t strutting around here, I bet you ");
				if (player.hasVagina()) outputText("sit and spread ‘em for anything going, don’t you?");
				else outputText("I bet you get on your knees for anything with a nice, juicy cock, right?");
				outputText(" What would your other slaves think of that? My secret little slut.</i>” ");

				outputText("\n\nYou’d like to retort with something along the lines of fucking not equaling submitting but you’re not exactly in a good position to speak up, and it’s getting hard to concentrate on anything but the urge gripping your body and the intense, checkered sensations Whitney is pressing on you.");
			}
			else
			{
				outputText("\n\nThe dog woman works her way into you slowly, groaning in satisfaction at the ");
				if (player.hasVagina()) outputText("take of your tight cunt");
				else outputText("give of your tight ass");
				outputText(", pushing the other end of the dildo into her. An even louder moan is forced out of your throat by the intensity of your tunnel being packed full of cock, albeit an imitation.");
				
				if (player.hasVagina())
				{
					player.cuntChange(36, true, true, false);
				}
				else
				{
					player.buttChange(36, true, true, false);
				}

				outputText("\n\n“<i>S’it,</i>” Whitney breathes exultantly, as her hard hips finally press against your [butt], the whole thing buried in you. “<i>Cry for me, [boy]! This is something you need, isn’t it? Something to think about when you’re lordin’ it over your ");
				if (player.hasVagina()) outputText("servants, you tight, bossy little bitch");
				else outputText("cattle, you tight, bossy little boy-bitch");
				outputText(".</i>” ");

				outputText("\n\nYou jerk in shock as the paddle lands with a sharp report on your ass cheek. You try to remember when you ever agreed to this kind of treatment, but it’s getting hard to concentrate on anything but the urge gripping your body and the acute, checkered sensations Whitney is pressing on you.");
			}

			outputText("\n\nShe withdraws almost all the way out, the knobbed head pulling at your " + ((player.hasVagina()) ? "entrance before thrusting back into your [vagina]" : "sphincter before thrusting back into your [ass]") + ", bringing the paddle down on your reddened behind as she does. In, slap, out, in, slap, out, first one cheek, then the other...");

			outputText("\n\nThe panties in your mouth are dense with the taste and smell of the dog woman’s excitement; stuck high in your nose and throat, the rich musk makes you feel impossibly turned on, and there’s no getting away from it. Although your intention was to take your ‘relaxation’ in a stoical silence befitting of your position, you can’t stop yourself whining and moaning around the soiled cotton, welcoming each hard slap to your [butt] as it heralds another firm stroke from the delightfully thick and bumpy cock" + ((player.hasCock()) ? " bumping delightfully against your prostate, making [eachCock] thrum and bulge urgently in pleasure" : "") + ".");

			outputText("\n\nYou convulse fruitlessly against your bonds as you are pushed relentlessly up to your high, " + ((player.hasVagina()) ? "your pussy quivering and then clenching ardently around the dildo" : "your [cockplural] pulsing, opening wide and then forced to unload, your back passage tightening eagerly around the thick dildo as you spurt cum deliriously") + ", blood rushing to the surface of your behind - only to meet the paddle’s hard blow. Whitney continues to thrust into you indifferent to your orgasm and you groan into your musky gag as the warm, prosthetic dick bends " + ((player.hasVagina()) ? "mercilessly" : "") + " into your sensitive walls " + ((player.hasCock()) ? "continuing to milk you mercilessly, keeping your cock achingly hard" : "") + ".");

			outputText("\n\nIt goes on and on, the creak of the bed and the fleshy slap of her thighs and paddle against your tender [butt] the soundtrack to the deliciously hard sex. It feels as though your kept mistress is simply toying with you for her own amusement, enjoying the sight and sound of you, making pleased noises every time she manages to make you squeak. Increasingly though as her thighs pat into yours she moves with urgency, fucking into you harder in order to force her end of the dildo further into her, panting as she scratches her own itch. ");

			outputText("\n\nA " + ((whitneyDefurred()) ? "hand" : "paw") + " reaches around and clutches your [chest] for anchorage as she finally begins to pound into your tenderized hole with all she’s got. She catches a [nipple] between her fingers and you find yourself being forced towards orgasm again, your ears full of her harsh breathing, your nose full of her heavy scent. She’s no longer thrusting into you for your pleasure though, if she ever was; the hard, feral thrusting of the strap-on into your " + ((player.hasVagina()) ? "oozing cunt" : "ass") + " is all about her, all about working the smaller, teasing end in her own pussy as hard as she can. You are simply a vehicle for her own lusts, and when you come again with a juddering cry into her panties, " + ((player.hasVagina()) ? "wetting the bed this time with the jackhammer force of it" : "") + " she keeps going, hammering into your hapless " + ((player.hasVagina()) ? "[vagina]" : "butt") + ".");

			outputText("\n\nThe relentless pounding forces your eyes to roll and your hands to grip uselessly at the air until finally, with a breathless, ecstatic bark and a final, hard paddle blow to your [butt], she reaches her own peak. You feel utterly dissolved as she thumps into you deliriously, caught in her own sumptuous orgasm for long seconds; you catch yourself thinking you should try timing your orgasms to better suit your mistress.");
			if (player.hasVagina() && !player.hasCock() && kGAMECLASS.vapula.vapulaSlave()) outputText(" You feel the end of the dildo tense deep within you before releasing, filling you full of warm demon spunk until it pools out onto the bed. The feeling is horribly, disgustingly satisfying, and for a moment you can see exactly how Vapula views the world.");

			outputText("\n\nAt long last she comes to a halt. She lays herself on top of you as she gathers her breath, still holstered in you, her small, peachy breasts pushing into your shoulders, her soft stomach against your hands, her breath on the nape of your neck. After a short rest spooned together like this she rolls over and slowly goes about undoing your restraints. You roll onto your back when she’s done, staring at the ceiling as she possessively snuggles into you, feeling distinctly pulverized. You can’t say for sure why you signed on for this, but there’s no question letting Whitney do to you as she may is a strange, intense release you can’t find anywhere else, or at least anywhere else where they let you walk away at the end.");

			outputText("\n\nYou’d like to rest longer, but you can’t. With some difficulty you get the dog woman to let go of you, put your clothes back on and head to the door, walking with a distinctly knock-kneed gait. She laughs softly as she watches you go.");

			outputText("\n\n“<i>I hope you feel suitably relaxed, [master],</i>” she says. “<i>Ready to take on the world and bring it to your heel? Me an’ this room will always be here when you need to get in touch with your true self.</i>”");

			player.orgasm();
			doNext(camp.returnToCampUseOneHour);
		}

		public function whitneyDomRide():void
		{
			clearOutput();
			whitneySprite();

			outputText("Flicking off her underwear, Whitney clambers onto the bed and then onto you, her warm hands and thighs pushing you into the mattress. She looks down at [eachCock] once she’s on top, semi-turgid from the sensation of her strong, slim thighs around your midriff and the sight of her small, pert breasts jouncing briskly to her own movements. There’s a hard, almost cruel lust in her eyes; it’s a look that should by rights make you shrivel but instead only makes you feel warmer, more pliable underneath her.");

			outputText("\n\n“<i>Lie still,</i>” she commands levelly. You do as she says and gaze at the ceiling as you feel nimble fingers grab your wrists, wrap the leather binds secured to each corner of the bedstead around them and jerk them taunt with a sharp, sure yank.");
			if (player.isBiped()) outputText(" She does the same with your ankles, leaving you helplessly spread-eagled across the bed.");
			else if (player.isDrider()) outputText(" She has long, leather straps attached to the underside of the bed; these are wrapped around the joining of your spindly legs to your heavy abdomen, leaving your chitinous feet pointing helplessly at the ceiling.");
			else if (player.isGoo()) outputText(" “<i>I can’t secure you properly,</i>” she breathes, squeezing your gooey form, sinking her fingers into it. “<i>Owing to this nonsense you call a body. So I will jus’ say it again. Lie. Still.</i>”");
			else if (player.isNaga()) outputText(" Your long, heavy tail is wrapped around the bedsteads at the foot of the bed and secured with more leather straps, leaving you helplessly spread-eagled across the bed.");

			outputText("\n\nOnce she’s done tying you down the dog woman gets off the bed with a spring and disappears from your limited sightline, rummaging around her bedroom with ominous-sounding intent. Is she shifting particularly heavy things about just to torment you? You crane your neck to get a glimpse at what she’s holding as she returns to your side - and then cry out in shock as a black curtain falls down on the world.");

			outputText("\n\n“<i>Stop fussing now, sweetheart,</i>” Whitney croons, adjusting the black, elastic blindfold so it is firmly secured over your eyes." + ((player.eyeType == EYES_FOUR_SPIDER_EYES) ? " Once she’s finished with that she places another blindfold over your second pair of eyes. You can only groan with laughter at the sheer level of preparation the dog woman is capable of." : "") + " “<i>Wouldn’t want you to see what’s coming, would we? That’d ruin half the fun.</i>” ");

			outputText("\n\nShe crawls down to your lower body, taking her time now as she slides her hands across your abdomen and [hips] and sits herself down in front of [eachCock]" + ((player.balls > 0) ? ", making you twitch as she momentarily cups your [balls]" : "") + ". She teases you with slow, deliberate movements of her smooth digits, fully aware that all you can do now in your black space is lie there, feeling and listening to what she’s doing to you.");

			outputText("\n\nHer warm hand curls around your [cock biggest], squeezing until her grip is almost painfully tight before receding to the faintest of touches, then increasing the strength of her hold again. Tight... relaxed. Tight... relaxed. Your breath comes quicker as your cock inevitably hardens to the almost tortuous treatment. A slippery, rhythmic sound reaches your ears and it takes you a moment to realize it has nothing to do with what’s being done to you.");

			outputText("\n\n“<i>Yeah,</i>” hisses Whitney, as she masturbates both you and herself at the same time, glorying in the control she has over the supine form before her. “<i>So powerful - and all mine. Mine!</i>” You arch your back as she begins to jerk you hard, your [cock biggest] bulging in her grasp - and then gasp as something clamps around the base of your dick.");

			outputText("\n\n“<i>There we go,</i>” your slave mistress sighs, continuing to stroke your helplessly engorged dick softly, finger catching the cock ring she’s placed around it. “<i>Wouldn’t want you getting away from me, would we? That’d ruin </i>all<i> the fun.</i>” She laughs, long, low and wicked, and you feel wet softness as she pushes her pussy against your captive prick.");

			// Too big:
			// Try and find a cock that will fit within vagCap + 33%
			// This is probably wrong as fuck but it's close enough.
			var cockI:int = player.cockThatFits(whitneyVagCapacity() * 1.33) + 1;
			var tooBig:Boolean = false;

			// Catch a no-cock-fits scenario so we can do things.
			if (cockI == 0)
			{
				tooBig = true;
				cockI = player.smallestCock() + 1;
			}

			if (tooBig)
			{
				outputText("\n\nYour mouth opens as she begins to revolve her supple hips, sliding her wet opening up and down your [cock biggest]. Your cock is forcibly hardened and sensitized to the point that you can feel her lips parted around your huge girth, her tiny clit pushing up and down every vein and bulge it encounters. She has to stand to bump at your cock head, and you can’t help but try and thrust your way into that tantalizingly warm, wet hole. ");

				outputText("\n\nYou groan as with a laugh she pulls away from your crown, shifts herself around, and rubs at the top side of your cock instead. She seems intent on masturbating herself on every inch of your dick, frosting every inch with her femjizz... and she has a lot of ground to cover.");

				outputText("\n\n“<i>Why do you have such a big dick?</i>” she wonders to herself as she slides against your base, her fingers pressing into the sensitive spot near the top. You can’t do anything but pant in reply, trapped in a never-ending moment of heat, even if you knew how to answer the question. ");

				outputText("\n\n“<i>I mean, you wouldn’t be able to fit this into most folks. Certainly I ain’t gonna try. I’m told you have the same number of nerve-endings in an appendage regardless of how big it is, so it ain’t for your benefit either - hell, I imagine it’s a burden just haulin’ this thing around. Is it just to scare people? Put the fear of god into guys in the lil’ boy’s room?</i>” She laughs to herself as she bucks against you. She’s slicked your dick with enough of her own juices that she’s able to thrust herself into you with pace, bending your bulging totem-like prick back towards your head. “<i>It’s just a trophy is how I reckon. A big piece of useless meat you can awe most anyone with without ever having to be brave enough to actually use it. The funny thing is...</i>” ");

				outputText("\n\nSomething suddenly pushes against your engorged cock slit. The intensity of it seizes up your body, and you cry out, almost begging her to stop. Whitney shushes you soothingly, rubbing your bulging length calmly whilst keeping the thin object pushed against its entrance insistently. She waits patiently until your back returns to the mattress before pushing in, spreading your incredibly sensitive urethral passage with it.");

				outputText("\n\nYou grit your teeth; it’s a rigid string of beads, and each round bump slid into your shaft makes sweat stand out on your brow. It’s impossible to focus on anything but the overwhelming sensation as it pushes deeper and deeper into your [cock biggest]. “<i>By having a prick this size, you’ve given me the tightest hole imaginable to play with.</i>” Finally, mercifully, she stops pushing the beads deeper, with the first one almost at the base of your trapped cock. ");

				outputText("\n\nYou feel full, engorged and sensitized by forces entirely out of your control, and you can’t help but arch your back when Whitney, with a teasing hum, gives it a stroke. Both the inside and outside of your manhood feels her soft touch acutely, flexing around the bumpy intrusion as your skin throbs to the pleasure brushing it. “<i>Not only that, now you have somethin’ which is actually useful to me!</i>”");

				outputText("\n\nSo saying, she begins to rub herself against your lubed-up prick again, making you groan as she pushes her tight twat into your stem and slides her way up. Her wet warmth presses into every bead along the way, and she sighs with deep pleasure as her clit bumps over your knobbly prick.");

				outputText("\n\nShe quickly picks up the pace, her thighs clenching around the base of your cock, her " + ((whitneyDefurred()) ? "feet" : "hind paws") + " pushing impatiently into your [chest] and shoulders as she uses your [cock biggest] as the masturbation post she’s turned it into.  The sensation is almost impossible to cope with; your cock feels bottled at both ends, your flesh trapped in a vice of pleasure which heightens unbearably every time she pushes into one of the beads wedged in your urethra and you can’t help but groan and then bark to it, flexing helplessly against your bonds, your hips in spasm to Whitney’s own greedy thrusts. Being blind seems to make the ecstatic torture all the more intense, making your universe narrow down to your oak-like cock, your pride and joy snared and used for your slave mistress’s own ends. ");

				outputText("\n\nShe flexes into you harder and harder, grunting as your helpless convulsions push into her sensitive vagina and bulging clit, bending your cock backwards as she begins to pant with lust, pushing you ruthlessly with her, forcing you to feel her own rising need. Ever since the cock ring was clasped around your [cock biggest] you have felt a dim desperation not to cum - who knows what it will do to your poor, abused dick? ");

				outputText("\n\nAs Whitney’s sopping sex slides over and over your length, rubbing the beads inside and making your whole dick feel like it’s glowing red, you feel your seed being pushed irresistibly past your will. Whitney howls as she reaches her own high, wrapping as much of her hard, petite frame around your dick as she can as her cunt clenches around your raphe and you bark wordlessly with her, arching your back and pushing back into her helplessly as your body is seized with orgasm. The force of it is enough to push past the tight ring around the base... but when your cum meets the other intrusion, it can’t find a way past. Your cock bulges and flexes uselessly, making you cry out as Whitney’s own furious bucking goes on around it, but you can feel at the spout all that comes out is the tiniest oozing drop.");

				outputText("\n\nEventually your pet dominatrix comes to a halt, panting and puffing in exhilaration after releasing her own pent-up lusts; the proof of it trickles warmly down your [hips]. You moan as you feel most of your own juices slowly sink back down your shaft, and you bite your lip when, after a short rest on top of you, Whitney slowly and gently pulls out the cock beads. You feel every single bump as if they were frictionless boulders as they slip out of your cock slit. When they are all finally out, she takes off your binds and blindfold and silently bids you to sit up. ");

				outputText("\n\nThe light hurts your eyes but it isn’t for that reason you close them; once you are upright, the stream of denied cum backed up in your dick leaks out, making you groan croakily as a great warm tidal wave of seed oozes out of you onto the floor. Once it is all out and you’ve spent a couple of seconds recuperating you realize your [cock biggest] is still rock hard, sensitized and bulging with frustration; as far as it is concerned, you haven’t found release at all. Whitney places a smooth hand on it, making you flinch.");

				outputText("\n\n“<i>That’s how I want you,</i>” she whispers into your ear, grinning with obscene pride. “<i>I’ve emptied you out but you’re still feelin ornery, aren’t you? You want to go out an’ slap Mareth in the face with that thing, ‘til it gives up an’ kneels quivering in front of you. That’s how I always want you, ‘cuz more slaves and you cravin release just makes my life sweeter and sweeter. Go out there and put the world in its place, [name]. I’ll be here when your clockwork needs winding again.</i>” ");

				outputText("\n\nSilently, you get up and dress yourself, shakily at first but then with growing conviction. She’s right - though you’ve been thoroughly fucked that horniness, that angry lust that always simmers at the back of your mind is unabated. You feel like your slave mistress’s lusts have been transferred to you, making you want to fuck all the more. You turn and kiss her roughly; she responds in kind, almost attacking the insides of your mouth and your tongue with her own with glee. After a long, wet, muffled moment you turn and stride out.");

				// [Cum reset, Lust remains intact, +1 Libido]
				player.hoursSinceCum = 0;
				dynStats("lib+", 1);
			}
			// Medium - cock area is within 33% of Whitneys cap without going over.
			else if (player.cockArea(cockI - 1) > (whitneyVagCapacity() * 0.66))
			{
				outputText("\n\nYour mouth opens as she begins to revolve her supple hips, sliding her wet opening up and down your [cock " + cockI + "]. Your cock is forcibly hardened and sensitized to the point that you can feel her lips parted around your huge girth, her tiny clit pushing up and down every vein and bulge it encounters. You can’t help but try and thrust your way into that tantalizingly warm, wet hole; you groan as with a laugh she pulls away from your crown, shifts herself around, and rubs at the top side of your cock instead. She seems intent on masturbating herself on every inch of your [cock " + cockI + "], frosting every inch with her femjizz... and she has a fair amount of ground to cover.");

				outputText("\n\n“<i>You’re a pragmatist, aren’t ya, [name]?</i>” she says to herself thoughtfully as she slides against your base, her fingers pressing into the sensitive spot near the top. You can’t do anything but pant in reply, trapped in a never-ending moment of heat, even if you knew how to answer her musings. “<i>Other [guy]s who put together a harem, they’d grow a massive dick, just to signal their status, y’know? Not you, though. You keep it nice an’ modest, just so you can fit it in every hole you can.</i>” She laughs again, softer this time, her clit pushing into your stiff raphe, making you open your mouth. The urge to bury yourself into her only grows with each second but you know she will only lift that teasing, tantalizing wetness away if you try. It strikes you as slightly odd she’s not using her hands to torment you as well; with the care she’s holding herself it’s almost as if she’s carrying something. There is a faint, bland, hot smell in the air.");

				outputText("\n\n“<i>An’ so every hole can use you. Kinda a slutty thing, ain’t it? Oh, you can pretend you’re just being sensible with a prick like this, but y’know what a length like this says to me? It says ‘I’m anyone’s. I aim to please. Use me.’</i>” She grunts the last two words savagely as she finally thrusts down, sinking the upper half of your trapped, bulging cock into her tight cunt. She revolves her hips slowly but surely, bending you into her; you can’t help but gasp at the delicious kneading softness inundating your head. ");

				outputText("\n\nWith effort you elect not to thrust back into her, as she evidently doesn’t think much of you doing that. It’s perfectly pleasant to just lie here and appreciate her enjoyment of you anyway... a small, white drop of pain suddenly forms on your abdomen, as if an incredibly hot finger has just poked you in the stomach, making you bark in surprise and twitch against your bonds. Whitney crows at your response, your spasm making your dick push deep into her. The spot of pain cools slowly, leaving a dull residue and you moan raggedly as you finally realize what she’s holding.");

				outputText("\n\n“<i>Massive centaur cock, lil’ sissy dick, that’d be about you, that’d be a statement about the kinda [guy] you are,</i>” she goes on in a low growl, warming to her theme as she screws you, slowly, rhythmically and surely, the candle she’s clutching somewhere above you. “<i>But you’re weak, ain’t ya? You got no self-control when it comes to pussy. You jus want to be used by anyone and anything. So - get - used!</i>” More liquid wax splashes down, this time on a "+ ((player.isLactating()) ? "moistened" : "taut") +" [nipple] and you can’t help but cringe again, your involuntary movements again making Whitney cry out in pleasure, her tight, succulent sex wringing your [cock " + cockI + "] gleefully.");

				outputText("\n\nShe lapses into harsh sighs and pants, no longer bothering to taunt you as the real business of fucking herself with your cock begins. You have no sense of the passage of time; there is only the tightness of her warm sex enveloping the top of your sensitive flesh, her tight thighs pushing into your own [hips], and the indiscriminate sadism of the candle. Blindfolded and bound as you are, you have no warning at all when Whitney’s brisk bouncing is going to cause more wax to splash down on your [chest] or abdomen, and although you try to stifle your own cries you cannot help twitching every time another white hot spot points into you, furthering your pet dom’s own pleasure each time. ");

				outputText("\n\nShe uses you to push herself to a high, howling out as her pussy and thighs clench up around you - and then simply keeps going, spending a few minutes to lazily move against you before returning to the vigorous thrusting as her heat returns. You can’t reach your own orgasm even if you tried; repeatedly you feel it building before ebbing, deliciously tormenting, as the cock ring denies you. The pain of the candle and squeezing sweetness inundating your cock meld together into a private world of sensation, made all the more intense by your blindness and you lose yourself in it entirely, feeling and moving only as your slave mistress desires.");

				outputText("\n\nFinally, after enough of her own orgasms that you’ve lost count, Whitney takes pity. She rests herself on you after a particularly hard minute of thrusting, your [cock " + cockI + "] aching with it, toying with the hardened pools of wax which cover your front as the hard clasp around your base is finally released. She begins to pump you again, her hands clenched on your shoulders as she works herself up, letting her sweat drip down onto you and her hard breath echo in your ear.");

				outputText("\n\n“<i>Go on then, [boy] toy,</i>” she whispers. “<i>Cum for me.</i>” Her pussy is clenching irresistibly around your pent-up prick and as if it had been waiting all along to hear her order it immediately dilates and surges lines of jizz into that supple, milking wetness. Your whole body is caught in orgasm, your back arching into Whitney as you cry out with the size of it, made huge by the denial you’ve been put through. Your cum quickly oozes back out of her wet hole onto you as your dick continues to flex deliciously, your restrained form seeming to condense all of your energy into your groin, surging your seed upwards until your flesh aches and your prick is pulsing uselessly. At the very edge of your perception you are aware of Whitney’s laughter as she continues to ride you, delighted with the effect she’s had on you.");
			}
			// Small
			// It's like hoofin' a cream cake whole wivout it touchin da sides!
			else
			{
				outputText("\n\nYour mouth opens as she begins to revolve her supple hips, sliding her wet opening onto your [cock " + cockI + "], easily swallowing it whole before withdrawing and coming back, teasing you with her wet warmth. Your cock is forcibly hardened and sensitized to the point that you can feel every inch of her lips parting around your small cock, her tiny clit pushing into the bulging head. You can’t help but try and thrust your way into that tantalizingly warm, wet hole; you groan as with a laugh she pulls away from your crown, shifts herself around, and envelopes you from the other side. She seems intent on masturbating herself on you every way she can.");

				outputText("\n\n“<i>Why would a [guy] who owns a harem be so poorly endowed?</i>” she wonders aloud as she torments your toy-like dick. Though she’s as tight and modestly dimensioned as anyone you’ve fucked, you can’t fully fill her and the feeling of her assuredly moving her folds of flesh over you like this, clenching every so often on your bulging head is one of agonizing deliciousness. You can’t do anything but pant in reply, trapped in a never-ending moment of heat, even if you knew how to answer her musings.");

				outputText("\n\n“<i>Is it sadism? You get to bathe your cute lil’ sissy stick in pussy, your sluts don’t get to feel nothing. Do they moan when you use this thing? They’re thinking of big thick minotaur dick if they do, I guarantee it.</i>” She chuckles to herself lowly as she revolves her hips slowly but surely, bending you into her; you can’t help but gasp at the delicious kneading softness inundating your head. “<i>Nah. I reckon they don’t say nothing. It’s you who whimpers like a spanked schoolgirl when you cum, prolly seconds after a real woman’s so much as touched it.</i>” You can feel a shameful blush climbing onto your face; you desperately want to banish it, try and laugh off her harsh words but it’s so difficult when she’s teasingly kissing you with her pussy like this. Under the circumstances you decide to go for stoicism, to not respond to her at all. It’s perfectly pleasant to just lie here and appreciate her enjoyment of your flesh after all....");

				outputText("\n\nA small, white drop of pain suddenly forms on your abdomen, as if an incredibly hot finger has just poked you in the stomach, making you bark in surprise and twitch against your bonds. Whitney crows at your response, your spasm making your dick push deeper into her. The spot of pain cools slowly, leaving a dull residue and you moan raggedly as you realize what she must be holding.");

				outputText("\n\n“<i>S’it. Cry for me, sissy!</i>” she cries, warming to her theme as she screws you, slowly, rhythmically and surely, the candle she’s clutching somewhere above you. “<i>Gods, a dick this size, you want me to treat you hard, it all makes sense, don’t it? You’re a sissy on the inside, and what sissies want is to be punished and be used. So - get - used!</i>” More liquid wax splashes down, this time on a " + ((player.isLactating()) ? "moistened" : "taut") + " [nipple] and you can’t help but cringe again, your involuntary movements again making Whitney cry out in pleasure, her tight, succulent sex wringing your [cock " + cockI + "] gleefully.");

				outputText("\n\nShe lapses into harsh sighs and pants, no longer bothering to taunt you as the real business of fucking herself on you begins. You have no sense of the passage of time; there is only the tightness of her warm sex enveloping your boy clit entirely, her tight thighs pushing into your own [hips], and the indiscriminate sadism of the candle. Blindfolded and bound as you are, you have no warning at all when Whitney’s brisk bouncing is going to cause more wax to splash down on your [chest] or abdomen, and although you try to stifle your own cries you cannot help twitch every time another white hot spot points into you, furthering your pet dom’s own pleasure each time. ");

				outputText("\n\nWhatever her vocal misgivings on your size she has no problem pushing herself to a high on you, thrusting her bulging bud into your small but extremely stiff length rhythmically, howling out as her pussy and thighs clench up around you - and then simply keeps going, spending a few minutes to lazily move against you before returning to the vigorous thrusting as her heat returns. You can’t reach your own orgasm even if you tried; repeatedly you feel it building before ebbing, deliciously tormenting, as the cock ring denies you. The pain of the candle and squeezing sweetness inundating your cock meld together into a private world of sensation, made all the more intense by your blindness and you lose yourself in it entirely, feeling and moving only as your slave mistress desires.");

				outputText("\n\nFinally, after enough of her own orgasms that you’ve lost count, Whitney takes pity. She rests herself on you after a particularly hard minute of thrusting, your [cock " + cockI + "] aching with it, toying with the hardened pools of wax which cover your front as the hard clasp around your base is finally released. She begins to pump you again, her hands clenched on your shoulders as she works herself up, letting her sweat drip down onto you and her hard breath echo in your ear.");

				outputText("\n\n“<i>Go on then, sissy,</i>” she whispers. “<i>Cum for me.</i>” Her pussy is clenching irresistibly around your pent-up prick and as if it had been waiting all along to hear her order. It immediately dilates and surges lines of jizz into that supple, milking wetness; your whole body is caught in orgasm, your back arching into Whitney as you cry out with the size of it, made huge by the denial you’ve been put through. Your cum quickly oozes back out of her wet hole onto you as your dick continues to flex deliciously, your restrained form seeming to condense all of your energy into your groin, surging your seed upwards until your flesh aches and your prick is pulsing uselessly. At the very edge of your perception you are aware of Whitney’s laughter as she continues to ride you, delighted with the effect she’s had on you.");
			}

			// Medium & Small
			if (!tooBig)
			{
				outputText("\n\nOnce it is finally over and your sore prick slides out of her hole, she settles herself down on you for a long, heavy moment, shifting her hands over her prize for a time before at last sliding off you. You heave and pant for breath, still cuffed and blindfolded, feeling like you are floating on the stars swimming in your blindfolded gaze.");

				outputText("\n\nIn this deep, post-coital haze you feel someone take a towel to your body, rubbing off a considerable amount of hardened wax before curling into you, throwing a dense thigh over you, holding and running her hands over you possessively as you recover. It’s only after these enforced cuddles that Whitney finally undoes your clasps and blindfold and lets you get up. You look down at your front, speckled so red it looks like you’ve had a bad encounter with a nettle thicket, and then stare with a kind of wondering disbelief at the dog woman responsible; she returns your gaze with heavy-lidded satisfaction, the picture of impenitence.");

				outputText("\n\nShe watches you dress and sighs wistfully as you get up and head to the door. But one session at a time with this creature you’ve managed to create is about as much as you think you can physically take. The marks from this encounter will be with you for a while.");

				outputText("\n\n“<i>I hope you feel suitably relaxed, [master],” she says. “<i>Ready to take on the world and bring it to your heel? Me an’ this room will always be here when you need to get in touch with your true self.</i>”");
				
				player.orgasm();
			}

			doNext(camp.returnToCampUseOneHour);
		}

		private function brandingMenu():void
		{
			clearOutput();
			whitneySprite();

			if (flags[kFLAGS.FARM_CORRUPTION_BRANDING_MENU_UNLOCKED] == 0)
			{
				outputText("You idly put an arm around Whitney, drawing her into you. You want her in the right frame of mind before you lead her down this path of inquiry. Her breath is hot and heavy against your [chest], her desire-lit eyes unable to tear away from yours as your hand slides down the curve of her back and round around her enjoyably tight ass. You ask her what she knows about branding.");

				outputText("\n\n“<i>I don’t brand my herd, [master],</i>” she says in a low voice, as you smooth your hand upwards and slip your fingers underneath her skirt. “<i>’s a very cruel practice and without any other farms round there’s no need for it anyway.</i>” But surely she must know of ways to mark cattle, you go on. Ways to make it immediately clear who owns them. You put not-so-subtle emphases on certain words as you touch her sopping vagina, slipping two fingers in easily. “<i>Mayhap... mayhap I do, [master],</i>” the dog woman groans, her breath coming in gulps and hisses as your digits move in her warm wetness. “<i>Somethin’, somethin’ from my granddaddy’s day. If you give me 500 gems and some time, I could... go and make a few things happen...</i>”");

				menu();
				if (player.gems >= 500) addButton(0, "Do it", getBrandingStuff);
				else addButton(0, "Do it", dontGetBrandingStuff);
				addButton(1, "No", dontGetBrandingStuff);
			}
			else
			{
				clearOutput();

				outputText("Your thoughts turn to the ingenious magic of your tattooing gear, stashed away in the barn. Grinning, you consider who you will summon to brand.");

				if (player.gems < 50) outputText("\n\n<b>You don't have enough gems to afford a new brand for any of your slaves.</b>");

				menu();

				if (player.gems >= 50)
				{
					if (hasFreeTattooSlot("whitney")) addButton(0, "Whitney", brandWhitney);
					if (flags[kFLAGS.FOLLOWER_AT_FARM_AMILY] == 1 && hasFreeTattooSlot("amily")) addButton(1, "Amily", brandAmily);
					if (flags[kFLAGS.FOLLOWER_AT_FARM_JOJO] == 1 && hasFreeTattooSlot("jojo")) addButton(2, "Jojo", brandJojo);
					if (flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 1 && kGAMECLASS.sophieBimbo.bimboSophie() && hasFreeTattooSlot("sophie")) addButton(3, "Sophie", brandBimboSophie);
					if (flags[kFLAGS.FOLLOWER_AT_FARM_VAPULA] == 1 && hasFreeTattooSlot("vapula")) addButton(4, "Vapula", brandVapula);
					if (flags[kFLAGS.KELT_BREAK_LEVEL] >= 4 && hasFreeTattooSlot("kelly")) addButton(5, "Kelly", brandKelly);
					if (flags[kFLAGS.FOLLOWER_AT_FARM_BATH_GIRL] == 1 && flags[kFLAGS.MILK_SIZE] > 0 && hasFreeTattooSlot("milky")) addButton(6, flags[kFLAGS.MILK_NAME], brandSmallMilky);
					if (flags[kFLAGS.FOLLOWER_AT_FARM_BATH_GIRL] == 1 && flags[kFLAGS.MILK_SIZE] == 0 && hasFreeTattooSlot("milky")) addButton(6, flags[kFLAGS.MILK_NAME], brandBigMilky);
				}

				addButton(14, "Back", dogeCorruptedMissionComplete);
			}
		}

		private function hasFreeTattooSlot(name:String):Boolean
		{
			if (name == "whitney")
			{
				if (flags[kFLAGS.WHITNEY_TATTOO_COLLARBONE] == 0) return true;
				if (flags[kFLAGS.WHITNEY_TATTOO_LOWERBACK] == 0) return true;
				if (flags[kFLAGS.WHITNEY_TATTOO_SHOULDERS] == 0) return true;
				if (flags[kFLAGS.WHITNEY_TATTOO_BUTT] == 0) return true;
				return false;
			}
			else if (name == "amily")
			{
				if (flags[kFLAGS.AMILY_TATTOO_COLLARBONE] == 0) return true;
				if (flags[kFLAGS.AMILY_TATTOO_LOWERBACK] == 0) return true;
				if (flags[kFLAGS.AMILY_TATTOO_SHOULDERS] == 0) return true;
				if (flags[kFLAGS.AMILY_TATTOO_BUTT] == 0) return true;
				return false;
			}
			else if (name == "jojo")
			{
				if (flags[kFLAGS.JOJO_TATTOO_COLLARBONE] == 0) return true;
				if (flags[kFLAGS.JOJO_TATTOO_LOWERBACK] == 0) return true;
				if (flags[kFLAGS.JOJO_TATTOO_SHOULDERS] == 0) return true;
				if (flags[kFLAGS.JOJO_TATTOO_BUTT] == 0) return true;
				return false;
			}
			else if (name == "sophie")
			{
				if (flags[kFLAGS.SOPHIE_TATTOO_COLLARBONE] == 0) return true;
				if (flags[kFLAGS.SOPHIE_TATTOO_LOWERBACK] == 0) return true;
				if (flags[kFLAGS.SOPHIE_TATTOO_SHOULDERS] == 0) return true;
				if (flags[kFLAGS.SOPHIE_TATTOO_BUTT] == 0) return true;
				return false;
			}
			else if (name == "vapula")
			{
				if (flags[kFLAGS.VAPULA_TATTOO_COLLARBONE] == 0) return true;
				if (flags[kFLAGS.VAPULA_TATTOO_LOWERBACK] == 0) return true;
				if (flags[kFLAGS.VAPULA_TATTOO_SHOULDERS] == 0) return true;
				if (flags[kFLAGS.VAPULA_TATTOO_BUTT] == 0) return true;
				return false;
			}
			else if (name == "kelly")
			{
				if (flags[kFLAGS.KELLY_TATTOO_COLLARBONE] == 0) return true;
				if (flags[kFLAGS.KELLY_TATTOO_LOWERBACK] == 0) return true;
				if (flags[kFLAGS.KELLY_TATTOO_SHOULDERS] == 0) return true;
				if (flags[kFLAGS.KELLY_TATTOO_BUTT] == 0) return true;
				return false;
			}
			else if (name == "milky")
			{
				if (flags[kFLAGS.MILKY_TATTOO_COLLARBONE] == 0) return true;
				if (flags[kFLAGS.MILKY_TATTOO_LOWERBACK] == 0) return true;
				if (flags[kFLAGS.MILKY_TATTOO_SHOULDERS] == 0) return true;
				if (flags[kFLAGS.MILKY_TATTOO_BUTT] == 0) return true;
				return false;
			}
			else
			{
				throw new Error("Unable to determine correct NPC flags.");
			}
		}

		public function hasTattoo(name:String):Boolean
		{
			if (name == "whitney")
			{
				if (flags[kFLAGS.WHITNEY_TATTOO_COLLARBONE] != 0) return true;
				if (flags[kFLAGS.WHITNEY_TATTOO_LOWERBACK] != 0) return true;
				if (flags[kFLAGS.WHITNEY_TATTOO_SHOULDERS] != 0) return true;
				if (flags[kFLAGS.WHITNEY_TATTOO_BUTT] != 0) return true;
				return false;
			}
			else if (name == "amily")
			{
				if (flags[kFLAGS.AMILY_TATTOO_COLLARBONE] != 0) return true;
				if (flags[kFLAGS.AMILY_TATTOO_LOWERBACK] != 0) return true;
				if (flags[kFLAGS.AMILY_TATTOO_SHOULDERS] != 0) return true;
				if (flags[kFLAGS.AMILY_TATTOO_BUTT] != 0) return true;
				return false;
			}
			else if (name == "jojo")
			{
				if (flags[kFLAGS.JOJO_TATTOO_COLLARBONE] != 0) return true;
				if (flags[kFLAGS.JOJO_TATTOO_LOWERBACK] != 0) return true;
				if (flags[kFLAGS.JOJO_TATTOO_SHOULDERS] != 0) return true;
				if (flags[kFLAGS.JOJO_TATTOO_BUTT] != 0) return true;
				return false;
			}
			else if (name == "sophie")
			{
				if (flags[kFLAGS.SOPHIE_TATTOO_COLLARBONE] != 0) return true;
				if (flags[kFLAGS.SOPHIE_TATTOO_LOWERBACK] != 0) return true;
				if (flags[kFLAGS.SOPHIE_TATTOO_SHOULDERS] != 0) return true;
				if (flags[kFLAGS.SOPHIE_TATTOO_BUTT] != 0) return true;
				return false;
			}
			else if (name == "vapula")
			{
				if (flags[kFLAGS.VAPULA_TATTOO_COLLARBONE] != 0) return true;
				if (flags[kFLAGS.VAPULA_TATTOO_LOWERBACK] != 0) return true;
				if (flags[kFLAGS.VAPULA_TATTOO_SHOULDERS] != 0) return true;
				if (flags[kFLAGS.VAPULA_TATTOO_BUTT] != 0) return true;
				return false;
			}
			else if (name == "kelly")
			{
				if (flags[kFLAGS.KELLY_TATTOO_COLLARBONE] != 0) return true;
				if (flags[kFLAGS.KELLY_TATTOO_LOWERBACK] != 0) return true;
				if (flags[kFLAGS.KELLY_TATTOO_SHOULDERS] != 0) return true;
				if (flags[kFLAGS.KELLY_TATTOO_BUTT] != 0) return true;
				return false;
			}
			else if (name == "milky")
			{
				if (flags[kFLAGS.MILKY_TATTOO_COLLARBONE] != 0) return true;
				if (flags[kFLAGS.MILKY_TATTOO_LOWERBACK] != 0) return true;
				if (flags[kFLAGS.MILKY_TATTOO_SHOULDERS] != 0) return true;
				if (flags[kFLAGS.MILKY_TATTOO_BUTT] != 0) return true;
				return false;
			}
			else
			{
				throw new Error("Unable to determine correct NPC flags.");
			}
		}

		public function numTattoos(name:String):int
		{
			var count:int = 0;

			if (name == "whitney")
			{
				if (flags[kFLAGS.WHITNEY_TATTOO_COLLARBONE] != 0) count++;
				if (flags[kFLAGS.WHITNEY_TATTOO_LOWERBACK] != 0) count++;
				if (flags[kFLAGS.WHITNEY_TATTOO_SHOULDERS] != 0) count++;
				if (flags[kFLAGS.WHITNEY_TATTOO_BUTT] != 0) count++;
			}
			else if (name == "amily")
			{
				if (flags[kFLAGS.AMILY_TATTOO_COLLARBONE] != 0) count++;
				if (flags[kFLAGS.AMILY_TATTOO_LOWERBACK] != 0) count++;
				if (flags[kFLAGS.AMILY_TATTOO_SHOULDERS] != 0) count++;
				if (flags[kFLAGS.AMILY_TATTOO_BUTT] != 0) count++;
			}
			else if (name == "jojo")
			{
				if (flags[kFLAGS.JOJO_TATTOO_COLLARBONE] != 0) count++;
				if (flags[kFLAGS.JOJO_TATTOO_LOWERBACK] != 0) count++;
				if (flags[kFLAGS.JOJO_TATTOO_SHOULDERS] != 0) count++;
				if (flags[kFLAGS.JOJO_TATTOO_BUTT] != 0) count++;
			}
			else if (name == "sophie")
			{
				if (flags[kFLAGS.SOPHIE_TATTOO_COLLARBONE] != 0) count++;
				if (flags[kFLAGS.SOPHIE_TATTOO_LOWERBACK] != 0) count++;
				if (flags[kFLAGS.SOPHIE_TATTOO_SHOULDERS] != 0) count++;
				if (flags[kFLAGS.SOPHIE_TATTOO_BUTT] != 0) count++;
			}
			else if (name == "vapula")
			{
				if (flags[kFLAGS.VAPULA_TATTOO_COLLARBONE] != 0) count++;
				if (flags[kFLAGS.VAPULA_TATTOO_LOWERBACK] != 0) count++;
				if (flags[kFLAGS.VAPULA_TATTOO_SHOULDERS] != 0) count++;
				if (flags[kFLAGS.VAPULA_TATTOO_BUTT] != 0) count++;
			}
			else if (name == "kelly")
			{
				if (flags[kFLAGS.KELLY_TATTOO_COLLARBONE] != 0) count++;
				if (flags[kFLAGS.KELLY_TATTOO_LOWERBACK] != 0) count++;
				if (flags[kFLAGS.KELLY_TATTOO_SHOULDERS] != 0) count++;
				if (flags[kFLAGS.KELLY_TATTOO_BUTT] != 0) count++;
			}
			else if (name == "milky")
			{
				if (flags[kFLAGS.MILKY_TATTOO_COLLARBONE] != 0) count++;
				if (flags[kFLAGS.MILKY_TATTOO_LOWERBACK] != 0) count++;
				if (flags[kFLAGS.MILKY_TATTOO_SHOULDERS] != 0) count++;
				if (flags[kFLAGS.MILKY_TATTOO_BUTT] != 0) count++;
			}
			else
			{
				throw new Error("Unable to determine correct NPC flags.");
			}
			return count;
		}

		private function brandWhitney():void
		{
			clearOutput();
			whitneySprite();

			outputText("Whitney knows exactly what it means when you head off to the barn where she stashed your “branding” equipment; the dog girl is already eagerly stripped down by the time you’ve returned. You hold the pots of ink and consider where, and what, to put on her.");

			player.gems -= 50;
			showStats();

			brandSlotSelect();
		}

		public function brandAmily():void
		{
			clearOutput();

			outputText("You retrieve the pots of ink and paper from the barn and, smiling, tell your pet mouse you’re going to give her a treat.");

			outputText("\n\n“<i>How exciting!</i>” she squeaks. “<i>Is it your");
			if (player.hasCock()) outputText(" dick");
			else if (player.hasVagina()) outputText(" pussy");
			else outputText(" body");
			outputText(", [master]? That’s my favorite type of treat.</i>” You consider where, and what, to put on her.");

			player.gems -= 50;
			showStats();
			
			amilyBrandSlotSelect();
		}

		private function brandJojo():void
		{
			clearOutput();

			outputText("You retrieve the pots of ink and paper from the barn and, smiling brightly, tell your pet mouse you’re going to give him a special treat. Jojo knows all too well the nature of your treats. He closes his eyes and waits for the worst as you consider where and what to put on him.");

			player.gems -= 50;
			showStats();

			jojoBrandSlotSelect();
		}

		private function brandBimboSophie():void
		{
			clearOutput();

			outputText("You retrieve the pots of ink and paper from the barn and, smiling, tell your pet harpy you’re going to give her a treat.");

			if (!hasTattoo("sophie"))
			{
				outputText("\n\n“<i>Oh wow like cool, a tattoo kit!</i>” she says excitedly, her eyes fastening immediately on what you’re carrying. “<i>Where did you get that, babe? I’ve been looking like all over for one of those.</i>” How on Mareth could she possibly...? You’re beginning to suspect bimbo liqueur contains a more profound magic than you originally assumed.");

				outputText("\n\nShaking your head, you consider where and what you’re going to put on her.");
			}
			else
			{
				outputText("\n\n“<i>More super sexy tats, [name]?</i>” the harpy beams. “<i>Awesome!</i>”");

				outputText("\n\nShaking your head, you consider where and what you’re going to put on her.");
			}

			player.gems -= 50;
			showStats();

			bimboSophieSlotSelect();
		}

		private function brandVapula():void
		{
			outputText("You retrieve the pots of ink and paper from the barn and, smiling, tell your succubus you’re going to give her a treat.");

			outputText("\n\n“<i>What’s that supposed to be, [name]?</i>” she says, peering at your tools. “<i>Tattooing gear? Wow, that’s crude. You know Lethice has artists whose pens make you feel whatever is drawn on you, so...</i>” You say you don’t give a stuff what Lethice has, you’re here now and you going to tattoo exactly what you like on her.");

			outputText("\n\n“<i>Hhh, I love it when you get all forceful, [master],</i>” Vapula purrs. She narrows her eyes at you provocatively. “<i>Treat me then. I’ve been ever so good.</i>”");

			outputText("\n\nYou consider where and what you’re going to put on her.");

			player.gems -= 50;
			showStats();
			
			vapulaSlotSelect();
		}

		private function brandKelly():void
		{
			outputText("You retrieve the pots of ink and paper from the barn and smilingly tell your centaur cumslut you’re going to give her a treat.");

			outputText("\n\n“<i>Ok,</i>” she says meekly, her wide, green eyes on the objects in your hand. “<i>It won’t hurt, will it?</i>” Like you fucking her in the ass, you tell her soothingly, any initial pain will be more than worth the eventual satisfaction. As she blushes rosily, you consider where and what you’re going to put on her.");

			player.gems -= 50;
			showStats();
			
			kellySlotSelect();
		}

		private function brandSmallMilky():void
		{
			outputText("You retrieve the pots of ink and paper from the barn and, smiling kindly, tell your ex Sand Witch slave you’re going to give her a treat. ");

			outputText("\n\n[bathgirlName] looks at your tattooing paraphernalia apprehensively.");

			outputText("\n\n“<i>Skin pictures? O-ok, I guess.</i>” She breaks her brittle display of casualness with a laugh. “<i>I’ve always quite liked butterflies - You don’t see them out in the desert much. If you’re going to draw something - maybe you could...?</i>”");

			player.gems -= 50;
			showStats();
			
			smallMilkySlotSelect();
		}

		private function brandBigMilky():void
		{
			outputText("You retrieve the pots of ink and paper from the barn and, smiling kindly, tell your ex Sand Witch slave you’re going to give her a treat. ");

			outputText("\n\n[bathgirlName] blinks up at you, and then frowns hard as she considers this.");

			outputText("\n\n“<i>Bath time?</i>” she eventually replies.");

			player.gems -= 50;
			showStats();
			
			bigMilkySlotSelect();
		}

		private function getBrandingStuff():void
		{
			clearOutput();
			whitneySprite();

			player.gems -= 500;
			showStats();

			outputText("You stroke at her tiny, bulging button relentlessly until she releases a wordless bark of ecstasy, soaking your hand with a gratifyingly large gush of femcum. As she pants into your chest you wipe one hand clean on her clothes and press the money into her "+ ((whitneyDefurred()) ? "hands" : "paws") +" with the other.");

			outputText("\n\n“<i>Make it happen,</i>” you murmur into her floppy ear, before turning and leaving.");

			flags[kFLAGS.QUEUE_BRANDING_UPGRADE] = 1;

			doNext(camp.returnToCampUseOneHour);
		}

		private function dontGetBrandingStuff():void
		{
			clearOutput();
			whitneySprite();

			outputText("You stroke at her tiny bulging button until you adjudge she’s on the edge, before withdrawing your hand completely. Maybe some other time, you say airily.");

			outputText("\n\n“<i>Oh [master],</i>” groans Whitney, in a tone of deepest exasperation, her hands between her thighs.");
			if (whitneyDom()) outputText(" “<i>You’ll pay for that later, I swear!</i>”");
			outputText(" Grinning, you turn and leave.");

			dogeCorruptedMissionComplete();
		}

		private function brandingAvailableTalk():void
		{
			clearOutput();
			whitneySprite();

			outputText("“<i>[Master]! [Master], I’ve done as you asked,</i>” says Whitney, her tail wagging frantically as you approach. Her eyes are lit with glee and she’s got a cow with her on tether. You settle down and watch as she produces unassuming pots of black and red ink, and a sheaf of what looks like blotting paper.");

			outputText("\n\n“<i>Thought nobody sold this stuff anymore,</i>” she says with a shake of the head as she unstops a vial. A sharp, solvent smell presses into your nostrils. “<i>But it’s amazing what you kin’ find in that bazaar place, ain’t it? Watch.</i>” She dips a long");
			if (whitneyDefurred()) outputText(" fingernail");
			else outputText(" claw");
			outputText(" into the pot, withdraws it and then, dripping black fluid, presses it against the cow’s ample backside. The animal moos and swishes its tail in mild protest, but it doesn’t seem in any grievous amount of pain as Whitney’s digit moves, artfully tracing a large number 12 with the ink.");

			outputText("\n\n“<i>Then we take some of the paper and press it on to seal it... like so...</i>” There’s a faint hissing sound as Whitney covers the 12 with the white sheet, but again the cow barely seems to notice. When she peels it off she gestures for you to take a look for yourself. This is probably the first and hopefully the last time you inspect a cow’s backside so scrupulously but you can only be impressed by what you see - the number is dried and apparently ingrained deep into the heavy flesh, resisting your own attempts to rub it off easily. This will suit your own purposes perfectly.");

			outputText("\n\n“<i>S’long as you know what you want and move yer finger carefully, you can tattoo anything on anything,</i>” says Whitney. “<i>‘S much easier to do than brandin’, and it’s magic that lasts for years an’ years.</i>” She pauses and looks at you with a sly, knowing grin. “<i>Perhaps you’d like to test it out for yourself, [master]?</i>”");

			flags[kFLAGS.QUEUE_BRANDING_AVAILABLE_TALK] = 0;

			menu();
			addButton(0, "Yes", testBranding);
			addButton(1, "No", dontTestBranding);
		}

		private function testBranding():void
		{
			clearOutput();
			whitneySprite();

			outputText("You return her devilish grin with interest.");

			outputText("\n\n“<i>Since you’ve been such a productive girl, I guess you do deserve a reward. Take your clothes off.</i>” ");

			outputText("\n\nThe dog girl eagerly strips whilst you carefully take the pot of black ink and consider where, and what, to put on her.");

			brandSlotSelect();
		}

		private var slotNames:Array = [
		"collarbone",
		"shoulders",
		"lower back",
		"butt" ];

		public function brandSlotSelect():void
		{
			menu();
			if (flags[kFLAGS.WHITNEY_TATTOO_COLLARBONE] == 0) addButton(0, "Collarbone", brandSelect, 0)
			if (flags[kFLAGS.WHITNEY_TATTOO_SHOULDERS] == 0) addButton(1, "Shoulders", brandSelect, 1);
			if (flags[kFLAGS.WHITNEY_TATTOO_LOWERBACK] == 0) addButton(2, "Lower Back", brandSelect, 2);
			if (flags[kFLAGS.WHITNEY_TATTOO_BUTT] == 0) addButton(3, "Butt", brandSelect, 3);
		}

		public function amilyBrandSlotSelect():void
		{
			menu();
			if (flags[kFLAGS.AMILY_TATTOO_COLLARBONE] == 0) addButton(0, "Collarbone", amilyBrandSelect, 0)
			if (flags[kFLAGS.AMILY_TATTOO_SHOULDERS] == 0) addButton(1, "Shoulders", amilyBrandSelect, 1);
			if (flags[kFLAGS.AMILY_TATTOO_LOWERBACK] == 0) addButton(2, "Lower Back", amilyBrandSelect, 2);
			if (flags[kFLAGS.AMILY_TATTOO_BUTT] == 0) addButton(3, "Butt", amilyBrandSelect, 3);
		}

		public function jojoBrandSlotSelect():void
		{
			menu();
			if (flags[kFLAGS.JOJO_TATTOO_COLLARBONE] == 0) addButton(0, "Collarbone", jojoBrandSelect, 0)
			if (flags[kFLAGS.JOJO_TATTOO_SHOULDERS] == 0) addButton(1, "Shoulders", jojoBrandSelect, 1);
			if (flags[kFLAGS.JOJO_TATTOO_LOWERBACK] == 0) addButton(2, "Lower Back", jojoBrandSelect, 2);
			if (flags[kFLAGS.JOJO_TATTOO_BUTT] == 0) addButton(3, "Butt", jojoBrandSelect, 3);
		}

		public function bimboSophieSlotSelect():void
		{
			menu();
			if (flags[kFLAGS.SOPHIE_TATTOO_COLLARBONE] == 0) addButton(0, "Collarbone", bimboSophieBrandSelect, 0)
			if (flags[kFLAGS.SOPHIE_TATTOO_SHOULDERS] == 0) addButton(1, "Shoulders", bimboSophieBrandSelect, 1);
			if (flags[kFLAGS.SOPHIE_TATTOO_LOWERBACK] == 0) addButton(2, "Lower Back", bimboSophieBrandSelect, 2);
			if (flags[kFLAGS.SOPHIE_TATTOO_BUTT] == 0) addButton(3, "Butt", bimboSophieBrandSelect, 3);
		}

		public function vapulaSlotSelect():void
		{
			menu();
			if (flags[kFLAGS.VAPULA_TATTOO_COLLARBONE] == 0) addButton(0, "Collarbone", vapulaBrandSelect, 0)
			if (flags[kFLAGS.VAPULA_TATTOO_SHOULDERS] == 0) addButton(1, "Shoulders", vapulaBrandSelect, 1);
			if (flags[kFLAGS.VAPULA_TATTOO_LOWERBACK] == 0) addButton(2, "Lower Back", vapulaBrandSelect, 2);
			if (flags[kFLAGS.VAPULA_TATTOO_BUTT] == 0) addButton(3, "Butt", vapulaBrandSelect, 3);
		}

		public function kellySlotSelect():void
		{
			menu();
			if (flags[kFLAGS.KELLY_TATTOO_COLLARBONE] == 0) addButton(0, "Collarbone", kellyBrandSelect, 0)
			if (flags[kFLAGS.KELLY_TATTOO_SHOULDERS] == 0) addButton(1, "Shoulders", kellyBrandSelect, 1);
			if (flags[kFLAGS.KELLY_TATTOO_LOWERBACK] == 0) addButton(2, "Lower Back", kellyBrandSelect, 2);
			if (flags[kFLAGS.KELLY_TATTOO_BUTT] == 0) addButton(3, "Butt", kellyBrandSelect, 3);
		}

		public function smallMilkySlotSelect():void
		{
			menu();
			if (flags[kFLAGS.MILKY_TATTOO_COLLARBONE] == 0) addButton(0, "Collarbone", smallMilkyBrandSelect, 0)
			if (flags[kFLAGS.MILKY_TATTOO_SHOULDERS] == 0) addButton(1, "Shoulders", smallMilkyBrandSelect, 1);
			if (flags[kFLAGS.MILKY_TATTOO_LOWERBACK] == 0) addButton(2, "Lower Back", smallMilkyBrandSelect, 2);
			if (flags[kFLAGS.MILKY_TATTOO_BUTT] == 0) addButton(3, "Butt", smallMilkyBrandSelect, 3);
		}

		public function bigMilkySlotSelect():void
		{
			menu();
			if (flags[kFLAGS.MILKY_TATTOO_COLLARBONE] == 0) addButton(0, "Collarbone", bigMilkyBrandSelect, 0)
			if (flags[kFLAGS.MILKY_TATTOO_SHOULDERS] == 0) addButton(1, "Shoulders", bigMilkyBrandSelect, 1);
			if (flags[kFLAGS.MILKY_TATTOO_LOWERBACK] == 0) addButton(2, "Lower Back", bigMilkyBrandSelect, 2);
			if (flags[kFLAGS.MILKY_TATTOO_BUTT] == 0) addButton(3, "Butt", bigMilkyBrandSelect, 3);
		}

		public function brandSelect(slot:int):void
		{
			clearOutput();
			whitneySprite();

			outputText("What will you draw on her " + slotNames[slot] + "?");

			menu();
			addButton(0, "Tribal", tribalTattoo, slot);
			addButton(1, "Heart", heartTattoo, slot);
			addButton(2, "Property Of", propertyTattoo, slot);
			addButton(3, "No.1 Bitch", no1Tattoo, slot);
			if (player.hasCock() && whitneyMaxedOralTraining()) addButton(4, "Cocksucker", champCocksuckerTattoo, slot);
			if (player.hasVagina() && whitneyMaxedOralTraining()) addButton(5, "Pussylicker", champPussylickerTattoo, slot);

			addButton(14, "Back", brandSlotSelect);
		}

		public function amilyBrandSelect(slot:int):void
		{
			clearOutput();

			outputText("What will you draw on her " + slotNames[slot] + "?");

			menu();
			addButton(0, "Tribal", amilyTribalTattoo, slot);
			addButton(1, "Heart", amilyHeartTattoo, slot);
			addButton(2, "Property Of", amilyPropertyTattoo, slot);
			addButton(3, "Breeding Bitch", amilyBreedingBitchTattoo, slot);
			if (player.hasCock() && slot == 2) addButton(4, "Cock Here", amilyCockGoesHereTattoo, slot);
			if (player.hasVagina()) addButton(5, "Mommy's Girl", amilyMommysGirlTattoo, slot);

			addButton(14, "Back", amilyBrandSlotSelect);
		}

		public function jojoBrandSelect(slot:int):void
		{
			clearOutput();

			outputText("What will you draw on his " + slotNames[slot] + "?");

			menu();
			addButton(0, "Tribal", jojoTribalTattoo, slot);
			addButton(1, "Heart", jojoHeartTattoo, slot);
			addButton(2, "Property Of", jojoPropertyTattoo, slot);
			addButton(3, "Sissy Slut", jojoSissySlutTattoo, slot);
			if (player.hasCock() && slot == 2) addButton(4, "Cock Here", jojoCockGoesHereTattoo, slot);
			if (player.hasVagina()) addButton(5, "Mommy's Boy", jojoMommysBoyTattoo, slot);

			addButton(14, "Back", jojoBrandSlotSelect);
		}

		public function bimboSophieBrandSelect(slot:int):void
		{
			clearOutput();

			outputText("What will you draw on her " + slotNames[slot] + "?");

			menu();
			addButton(0, "Tribal", bimboSophieTribalTattoo, slot);
			addButton(1, "Heart", bimboSophieHeartTattoo, slot);
			addButton(2, "Swallow", bimboSophieSwallowTattoo, slot);
			addButton(3, "Property Of", bimboSophiePropertyOfTattoo, slot);
			addButton(4, "Breeding Bitch", bimboSophieBreedingBitchTattoo, slot);
			if (slot == 3) addButton(5, "Wide Load", bimboSophieWideLoadTattoo, slot);
			if (player.hasCock() && slot == 2) addButton(6, "Cock Goes Here", bimboSophieCockGoesHereTattoo, slot);

			addButton(14, "Back", bimboSophieSlotSelect);
		}

		public function vapulaBrandSelect(slot:int):void
		{
			clearOutput();

			outputText("What will you draw on her " + slotNames[slot] + "?");

			menu();
			addButton(0, "Tribal", vapulaTribalTattoo, slot);
			addButton(1, "Heart", vapulaHeartTattoo, slot);
			addButton(2, "Property Of", vapulaPropertyOfTattoo, slot);
			addButton(3, "Cum Addict", vapulaCumAddictTattoo, slot);
			if (slot == 2 || slot == 3) addButton(4, "Buttslut", vapulaButtslutTattoo, slot);
			if (!player.hasCock()) addButton(5, "Dildo Polisher", vapulaDildoPolisherTattoo, slot);

			addButton(14, "Back", vapulaSlotSelect);
		}

		public function kellyBrandSelect(slot:int):void
		{
			clearOutput();

			outputText("What will you draw on her " + slotNames[slot] + "?");

			menu();
			addButton(0, "Tribal", kellyTribalTattoo, slot);
			addButton(1, "Heart", kellyHeartTattoo, slot);
			addButton(2, "Property Of", kellyPropertyOfTattoo, slot);
			addButton(3, "No.1 Filly", kellyNo1FillyTattoo, slot);
			if (silly()) addButton(4, "Dick Won", kellyDickWonTattoo, slot);
			if (slot == 1) addButton(5, "Horseshoe", kellyHorseshoeTattoo, slot);

			addButton(14, "Back", kellySlotSelect);
		}

		public function smallMilkyBrandSelect(slot:int):void
		{
			clearOutput();

			outputText("What will you draw on her " + slotNames[slot] + "?");

			menu();
			addButton(0, "Tribal", smallMilkyTribalTattoo, slot);
			addButton(1, "Heart", smallMilkyHeartTattoo, slot);
			addButton(2, "Butteryfly", smallMilkyButterflyTattoo, slot);
			addButton(3, "Property Of", smallMilkyPropertyOfTattoo, slot);
			addButton(4, "Bath Toy", smallMilkyBathToyTattoo, slot);
			if (slot == 0) addButton(5, "Mega Milk", smallMilkyMegaMilkTattoo, slot);
			if (slot == 0 && player.hasCock()) addButton(6, "Cock Cozy", smallMilkyCockCozyTattoo, slot);

			addButton(14, "Back", smallMilkySlotSelect);
		}

		public function bigMilkyBrandSelect(slot:int):void
		{
			clearOutput();

			outputText("What will you draw on her " + slotNames[slot] + "?");

			menu();
			addButton(0, "Tribal", bigMilkyTribalTattoo, slot);
			addButton(1, "Heart", bigMilkyHeartTattoo, slot);
			addButton(2, "Property Of", bigMilkyPropertyOfTattoo, slot);
			addButton(3, "Bath Toy", bigMilkyBathToyTattoo, slot);
			if (slot == 0) addButton(4, "Mega Milk", bigMilkyMegaMilkTattoo, slot);
			if (slot == 0 && player.hasCock()) addButton(5, "Cock Cozy", bigMilkyCockCozyTattoo, slot);

			addButton(14, "Back", bigMilkySlotSelect);
		}

		private function collarboneIntro():void
		{
			outputText("You command her to kneel in front of you and be still. Your lithe, naked dog girl does so, staying perfectly still as you dip your finger into the ink, carefully draw your design on her, and then seal it on with the paper.");
		}

		private function amilyCollarboneIntro():void
		{
			outputText("You command her to kneel in front of you and be still. The succubus mouse does so, staying perfectly still as you dip your finger into the ink, carefully draw your design on her, and then seal it on with the paper. ");
		}

		private function jojoCollarboneIntro():void
		{
			outputText("You command him to kneel in front of you and be still. The mouse-demon does so, staying perfectly still as you dip your finger into the ink, carefully draw your design on him, and then seal it on with the paper. ");

			outputText("\n\n“<i>Th-thanks, [master],</i>” he says, when he looks down and sees what you’ve permanently inscribed on his chest. You tussle his adorable ears and tell him he’s quite welcome.");
		}

		private function bimboSophieCollarboneIntro():void
		{
			outputText("You command her to kneel in front of you and be still. It’s difficult to get her to stay still, but she goes into a trance-like state when you finally lay your ink-soaked finger on her, mesmerized by its movement until you lay the paper over the design you’ve drawn and seal the ink.");
		}

		private function vapulaCollarboneIntro():void
		{
			outputText("You command her to kneel in front of you and be still. The succubus does so, staying perfectly still as you dip your finger into the ink, carefully draw your design on her, and then seal it on with the paper. ");
		}

		private function kellyCollarboneIntro():void
		{
			outputText("You command her to kneel in front of you and be still. The centaur does so, staying perfectly still as you dip your finger into the ink, carefully draw your design on her, and then seal it on with the paper. ");
		}

		private function smallMilkyCollarboneIntro():void
		{
			outputText("You command her to take her clothes off, kneel in front of you and be still. The dusky girl does so, staying perfectly still as you dip your finger into the ink, carefully draw your design on her and then seal it on with the paper.");
		}

		private function bigMilkyCollarboneIntro():void
		{
			outputText("\n\nIt’s difficult getting at this area of [bathgirlName]’s anatomy, but you manage to crane yourself around her vast tits and get to work. Dipping your finger into the ink, you carefully draw your design on her skin and then seal it on with the paper. The former sand witch slave gazes down at what you’ve drawn mistily, trailing her fingers over it.");

			outputText("\n\n“<i>Bath time?</i>”");

			outputText("\n\n“<i>Soon,</i>” you reply soothingly, as you turn to go put your branding equipment back.");
		}

		private function shouldersIntro():void
		{
			outputText("You command her to kneel facing away from you and be still. Your lithe, naked dog girl does so, staying perfectly still as you dip your finger into the ink, carefully draw your design on her, and then seal it on with the paper. “<i>What did you draw, [master]?</i>” she says eagerly.");

			outputText("\n\nLaughing, you admire it for yourself and then say she’ll have to ask one of your other slaves... and hope they tell the truth. “<i>Aw no, come on, tell me what it is! It’s a rude word, isn’t it? [Master], it better not be somethin’ the slaves are gonna laugh at.</i>”");
		}

		private function jojoShouldersIntro():void
		{
			outputText("You command him to kneel facing away from you and be still. The mouse-demon does so, staying perfectly still as you dip your finger into the ink, carefully draw your design on him, and then seal it on with the paper. ");

			outputText("\n\n“<i>Th-thanks, [master],</i>” he says. He pauses. “<i>I don’t suppose I could know what it-?</i>” You tussle his adorable ears and tell him of course not.");
		}

		private function amilyShouldersIntro():void
		{
			outputText("You command her to kneel facing away from you and be still. Your succubus mouse does so, staying perfectly still as you dip your finger into the ink, carefully draw your design on her and then seal it on with the paper. ");

			outputText("\n\n“<i>What did you draw, [master]?</i>” she says eagerly. Laughing, you admire it for yourself and then say she’ll have to ask one of your other slaves... and hope they tell the truth. “<i>Aw [master], you know they’ll just lie and say it’s something like ‘breeding bitch’. C’mon, please tell me!</i>”");
		}

		private function bimboSophieShouldersIntro():void
		{
			outputText("You command her to kneel facing away from you and be still. It’s difficult to get her to stay still, but she goes into a trance-like state when you finally lay your ink-soaked finger between her blonde wings, mesmerized by its movement until you lay the paper over the design you’ve drawn and seal the ink.");

			outputText("\n\n“<i>What did you put on?</i>” she says excitedly, turning around. “<i>Can I see?</i>” She turns around again. Her feathery brow furrows as she touches between her shoulder blades. She turns around again...");

			outputText("\n\nYou leave her to it.");
		}

		private function vapulaShouldersIntro():void
		{
			outputText("You command her to kneel facing away from you and be still. Your succubus does so, staying perfectly still as you dip your finger into the ink, carefully draw your design on her, and then seal it on with the paper. ");

			outputText("\n\n“<i>Let’s have a look then,</i>” she sighs, sparks flying off her fingers as she magically forms a mirror trained on her back in her hands. “<i>Ah. Very nice, [name]. I look forward to the next time you mutilate my perfect body with your incredibly crude ideas and instruments.</i>” You intimate that next time you’ll simply draw a giant cock on her face, which does get a laugh from her.");
		}

		private function kellyShouldersIntro():void
		{
			outputText("You command her to kneel facing away from you and be still. The centaur does so, staying perfectly still as you dip your finger into the ink, carefully draw your design on her shoulder blades, and then seal it on with the paper. ");

			outputText("\n\n“<i>What did you draw, [master]?</i>” she asks tentatively when you’re done. Trying to keep a straight face, you say a giant spunky horse cock. “<i>That’s funny, [master]. Ha ha. Y-you didn’t really do that, did you?</i>”");
		}

		private function smallMilkyShouldersIntro():void
		{
			outputText("You command her to kneel facing away from you and be still. The dusky girl does so, keeping her back straight and still as you dip your finger into the ink, carefully draw your design on her, and then seal it on with the paper. ");
		}

		private function bigMilkyShouldersIntro():void
		{
			outputText("You set yourself down behind [bathgirlName] before dipping your finger into the ink, carefully draw your design on her, and then seal it on with the paper. She barely seems to notice.");

			outputText("\n\n“<i>Bath time?</i>”");

			outputText("\n\n“<i>Soon,</i>” you reply soothingly, as you turn to go put your branding equipment back.");
		}

		private function lowerbackIntro():void
		{
			outputText("You command her to set herself down on your [legs], as if she were about to receive a spanking. Your lithe, naked dog girl does so, her laughter at her own compromising permission turning to a sharp coo as you dip your finger into the ink and carefully draw your design on her, before sealing it on with the paper. “<i>What did you draw, [master]?</i>” she says eagerly.");

			outputText("\n\nLaughing, you admire it for yourself and then say she’ll have to ask one of your other slaves... and hope they tell the truth. “<i>Aw no, come on, tell me what it is! It’s a rude word, isn’t it? [Master], it better not be somethin’ the slaves are gonna laugh at...</i>”");
		}

		private function jojoLowerbackIntro():void
		{
			outputText("You command him to set himself face down across your [legs], as if he were about to receive a spanking. The mouse-demon does so, staying perfectly still as you dip your finger into the ink, carefully draw your design on him and then seal it on with the paper. ");

			outputText("\n\n“<i>Th-thanks, [master],</i>” he says. He pauses. “<i>I don’t suppose I could know what it-?</i>” You tussle his adorable ears and tell him of course not.");
		}

		private function amilyLowerBackIntro():void
		{
			outputText("You command her to set herself face down across your [legs], as if she were about to receive a spanking. Your succubus mouse does so, her giggles at her own compromising position turning to a sharp coo as you dip your finger into the ink and carefully draw your design on her, before sealing it on with the paper. ");

			outputText("\n\n“<i>What did you draw, [master]?</i>” she says eagerly. Laughing, you admire it for yourself and then say she’ll have to ask one of your other slaves... and hope they tell the truth. “<i>Aw [master], you know they’ll just lie and say it’s something like ‘breeding bitch’. C’mon, please tell me!</i>”");
		}

		private function bimboSophieLowerBackIntro():void
		{
			outputText("You command her to set herself face down across your [legs], as if she were about to receive a spanking. It’s difficult to get her to stay still, cooing and shaking with giggles at her compromising position. She finally falls into a trance-like state when you lay your ink-soaked finger on her, mesmerized by its movement until you lay the paper over the design you’ve drawn and seal the ink.");

 			outputText("\n\n“<i>What did you put on?</i>” she says excitedly, turning around. “<i>Can I see?</i>” She turns around again. Her feathery brow furrows as she touches her lower back. She turns around again...");

			outputText("\n\nYou leave her to it.");
		}

		private function vapulaLowerBackIntro():void
		{
			outputText("You command her to set herself face down across your [legs], as if she were about to receive a spanking. Your succubus does so, her put-upon sigh turning to a sharp coo as you dip your finger into the ink and carefully draw your design on her, before sealing it on with the paper. ");

			outputText("\n\n“<i>Let’s have a look then,</i>” she says, sparks flying off her fingers as she magically forms a mirror trained on her back in her hands. “<i>Ah. Very nice, [name]. I look forward to the next time you mutilate my perfect body with your incredibly crude ideas and instruments.</i>”");

			outputText("\n\nYou intimate that next time you’ll simply draw a giant cock on her face, which does get a laugh from her.");
		}

		private function kellyLowerBackIntro():void
		{
			outputText("You command her to stand perfectly still.  She can’t quite stop clopping her hooves fretfully as you dip your finger into the ink and carefully draw your design on her human lower back before sealing it on with the paper. ");

			outputText("\n\n“<i>What did you draw, [master]?</i>” she asks tentatively when you’re done. Trying to keep a straight face, you say a giant spunky horse cock. “<i>That’s funny, [master]. Ha ha. Y-you didn’t really do that, did you?</i>”");
		}

		private function smallMilkyLowerBackIntro():void
		{
			outputText("You command her to set herself down across your [legs]. The dusky girl does so, staying perfectly still as you dip your finger into the ink, carefully draw your design on her, and then seal it on with the paper.");
		}

		private function bigMilkyLowerBackIntro():void
		{
			outputText("You set yourself down behind [bathgirlName] before dipping your finger into the ink, carefully draw your design on her, and then seal it on with the paper. She barely seems to notice.");

			outputText("\n\n“<i>Bath time?</i>”");

			outputText("\n\n“<i>Soon,</i>” you reply soothingly, as you turn to go put your branding equipment back.");
		}

		private function buttIntro():void
		{
			outputText("You command her to set herself down on your [legs], as if she were about to receive a spanking. Your lithe, naked dog girl does so, her laughter at her own compromising permission turning to a sharp coo as you dip your finger into the ink and carefully draw your design on the softest part of her anatomy, before sealing it on with the paper.");

			outputText("\n\n“<i>What did you draw, [master]?</i>” she says eagerly. Laughing, you admire it for yourself and then say she’ll have to ask one of your other slaves... and hope they tell the truth. “<i>Aw no, come on, tell me what it is! It’s a rude word, isn’t it? [Master], it better not be somethin’ the slaves are gonna laugh at. Ooh!</i>” You give her new tattoo a playful slap.");
		}

		private function amilyButtIntro():void
		{
			outputText("You command her to set herself face down across your [legs], as if she were about to receive a spanking. Your succubus mouse does so, her laughter at her own compromising position turning to a sharp coo as you dip your finger into the ink and carefully draw your design on the softest part of her anatomy, before sealing it on with the paper. ");

			outputText("\n\n“<i>What did you draw, [master]?</i>” she says eagerly. Laughing, you admire it for yourself and then say she’ll have to ask one of your other slaves... and hope they tell the truth. “<i>Aw [master], you know they’ll just lie and say it’s something like ‘breeding bitch’. C’mon, please tell me! Ooh!</i>” That tattoo is going to be pretty irresistible, you think, as you admire your red handprint over it.");
		}

		private function jojoButtIntro():void
		{
			outputText("You command him to set himself face down across your [legs], as if he were about to receive a spanking. The mouse-demon does so, staying perfectly still as you dip your finger into the ink, carefully draw your design onto the softest part of his body and then seal it on with the paper. ");

			outputText("\n\n“<i>Th-thanks, [master],</i>” he says. He pauses. “<i>I don’t suppose I could know what it-?</i>” You give his new tattoo a playful slap and tell him of course not.");
		}

		private function bimboSophieButtIntro():void
		{
			outputText("You command her to set herself face down across your [legs], as if she were about to receive a spanking. It’s difficult to get her to stay still, cooing and shaking with giggles at her compromising position. She finally falls into a trance-like state when you lay your ink-soaked finger on her, mesmerized by its movement until you lay the paper over the design you’ve drawn and seal the ink. You’ve certainly given yourself a vast if decidedly wobbly canvas to work on.");

			outputText("\n\n“<i>What did you put on?</i>” she says excitedly, turning around. “<i>Can I see?</i>” She turns around again. Her feathery brow furrows as she touches her butt. She turns around again...");

			outputText("\n\nYou leave her to it.");
		}

		private function vapulaButtIntro():void
		{
			outputText("You command her to set herself down across your [legs], as if she were about to receive a spanking. Your succubus does so, her put-upon sigh turning to a sharp coo as you dip your finger into the ink and carefully draw your design on the softest part of her anatomy, before sealing it on with the paper. ");

			outputText("\n\n“<i>Let’s have a look then,</i>” she says, sparks flying off her fingers as she magically forms a mirror trained on her ass in her hands. “<i>Ah. Very nice, [name]. I look forward to the next time you mutilate my perfect body with your incredibly crude ideas and instruments.</i>”");

			outputText("\n\nYou intimate that next time you’ll simply draw a giant cock on her face, which does get a laugh from her.");
		}

		private function kellyButtIntro():void
		{
			outputText("You command her to stand perfectly still.  She can’t quite stop clopping her hooves fretfully as you dip your finger into the ink and carefully draw your design on her smooth, brawny horse ass before sealing it on with the paper. ");

			outputText("\n\n“<i>What did you draw, [master]?</i>” she asks tentatively when you’re done. Trying to keep a straight face, you say the word “spank” on one cheek, “me” on the other. “<i>That’s funny, [master]. Ha ha. Y-you didn’t really do that, did you? Ow!</i>” ");

			outputText("\n\nThinking about it now, as you draw your reddened hand away from what is now tattooed on her irresistibly broad, chestnut behind, that was an opportunity lost. ");
		}

		private function smallMilkyButtIntro():void
		{
			outputText("You command her to set herself down across your [legs]. The dusky girl does so, staying perfectly still as you dip your finger into the ink, carefully draw your design on her fine, round ass, and then seal it on with the paper.");
		}

		private function bigMilkyButtIntro():void
		{
			outputText("You set yourself down behind [bathgirlName] before dipping your finger into the ink, carefully draw your design on her fine, round ass, and then seal it on with the paper. She barely seems to notice.");

			outputText("\n\n“<i>Bath time?</i>”");

			outputText("\n\n“<i>Soon,</i>” you reply soothingly, as you turn to go put your branding equipment back.");
		}

		private function tattooMerge():void
		{
			outputText("\n\nAfter you’re done horsing around, Whitney redresses, unable to stop her hand drifting to the new, indelible inscription on her body as she does.");

			outputText("\n\n“<i>I’m glad you like what I’ve gotten you, [master],</i>” she says. “<i>I’ll put it in the barn so if you ever get the urge to, um, mark more cattle, it’s there. Just be warned [master], magic ink ain’t cheap - each mark’ll cost a good 50 gems.</i>”");

			outputText("\n\nYou tell her she’s done very well, before turning and leaving.");

			doNext(camp.returnToCampUseOneHour);
		}

		private function tribalTattoo(slot:int):void
		{
			clearOutput();
			whitneySprite();

			var tText:String = "A tribal tattoo, all snaking, erotic lines, across her ";

			if (slot == 0)
			{
				collarboneIntro();
				outputText("\n\n“<i>You’ve got skilled fingers, [master],</i>” she says, touching what you’ve drawn admiringly. “<i>Although guess I already knew that.</i>”");
				tText += "collarbone.";
				flags[kFLAGS.WHITNEY_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				shouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.WHITNEY_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				lowerbackIntro();
				tText += "lower back.";
				flags[kFLAGS.WHITNEY_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				buttIntro();
				tText += "butt.";
				flags[kFLAGS.WHITNEY_TATTOO_BUTT] = tText;
			}

			tattooMerge();
		}

		private function amilyTribalTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "A tribal tattoo, all snaking, erotic lines, across her ";

			if (slot == 0)
			{
				amilyCollarboneIntro();
				outputText("\n\n“<i>Does this make me more beautiful to you, [master]?</i>” she says, touching what you’ve drawn admiringly. “<i>If so... it’s exactly what I wanted.</i>”");
				tText += "collarbone.";
				flags[kFLAGS.AMILY_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				amilyShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.AMILY_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				amilyLowerBackIntro();
				tText += "lower back.";
				flags[kFLAGS.AMILY_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				amilyButtIntro();
				tText += "butt.";
				flags[kFLAGS.AMILY_TATTOO_BUTT] = tText;
			}

			doNext(camp.returnToCampUseOneHour);
		}

		private function jojoTribalTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "A tribal tattoo, all snaking, erotic lines, across his ";

			if (slot == 0)
			{
				jojoCollarboneIntro();
				tText += "collarbone.";
				flags[kFLAGS.JOJO_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				jojoShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.JOJO_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				jojoLowerbackIntro();
				tText += "lower back.";
				flags[kFLAGS.JOJO_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				jojoButtIntro();
				tText += "butt.";
				flags[kFLAGS.JOJO_TATTOO_BUTT] = tText;
			}

			doNext(camp.returnToCampUseOneHour);
		}

		private function bimboSophieTribalTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "A tribal tattoo, all snaking, erotic lines, across her ";

			if (slot == 0)
			{
				bimboSophieCollarboneIntro();
				outputText("\n\n“<i>Woah,</i>” she says, awed at your drawing. “<i>You are sooooo artsy [name], that’s beautiful! You’ll like do more on me, right?</i>” Laughing, you tell her maybe, if she behaves well for Mistress Whitney and lays plenty of eggs for you. An expression of deepest determination emerges on the harpy’s beautiful features.");

				outputText("\n\n“<i>If it means more super sexy tats I will do my absolute bestest, babe!</i>”");
				tText += "collarbone.";
				flags[kFLAGS.SOPHIE_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				bimboSophieShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.SOPHIE_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				bimboSophieLowerBackIntro();
				tText += "lower back.";
				flags[kFLAGS.SOPHIE_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				bimboSophieButtIntro();
				tText += "butt.";
				flags[kFLAGS.SOPHIE_TATTOO_BUTT] = tText;
			}

			doNext(camp.returnToCampUseOneHour);
		}

		private function vapulaTribalTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "A tribal tattoo, all snaking, erotic lines, across her ";

			if (slot == 0)
			{
				vapulaCollarboneIntro();
				outputText("\n\n“<i>How gauche,</i>” she yawns after you’re done. “<i>I might have to start wearing clothes now.</i>” You can tell by the grin curling her lip and the way she touches the design she’s quietly pleased with it, though.");
				tText += "collarbone.";
				flags[kFLAGS.VAPULA_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				vapulaShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.VAPULA_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				vapulaLowerBackIntro();
				tText += "lower back.";
				flags[kFLAGS.VAPULA_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				vapulaButtIntro();
				tText += "butt.";
				flags[kFLAGS.VAPULA_TATTOO_BUTT] = tText;
			}

			doNext(camp.returnToCampUseOneHour);
		}

		private function kellyTribalTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "A tribal tattoo, all snaking, erotic lines, across her ";

			if (slot == 0)
			{
				kellyCollarboneIntro();
				outputText("“<i>That’s- that’s actually really pretty, [master]!</i>” Kelly says when you’re done, looking down with delight. “<i>Thank you!</i>”");
				tText += "collarbone.";
				flags[kFLAGS.KELLY_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				kellyShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.KELLY_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				kellyLowerBackIntro();
				tText += "lower back.";
				flags[kFLAGS.KELLY_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				kellyButtIntro();
				tText += "butt.";
				flags[kFLAGS.KELLY_TATTOO_BUTT] = tText;
			}

			doNext(camp.returnToCampUseOneHour);
		}

		private function smallMilkyTribalTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "A tribal tattoo, all snaking, erotic lines, across her ";

			if (slot == 0)
			{
				smallMilkyCollarboneIntro();
				outputText("“<i>Oh hey, that’s quite pretty.</i>” [bathgirlName] smiles down at what you’ve drawn as you withdraw the pen. “<i>Thanks, [name]!</i>” You kiss her fondly on the forehead and send her on her way.");
				tText += "collarbone.";
				flags[kFLAGS.MILKY_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				smallMilkyShouldersIntro();
				outputText("\n\n“<i>So, uh...</i>” she says when you’re done. “<i>What did you do?</i>” Something much better than a butterfly you say, grinning as you touch the permanent marking before turning to go stow the branding gear away.");

				outputText("\n\n“<i>Yes, but what is it? [name]? Hello?</i>”");
				tText += "shoulders.";
				flags[kFLAGS.MILKY_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				smallMilkyLowerBackIntro();
				outputText("\n\n“<i>So, uh...</i>” she says when you’re done. “<i>What did you do?</i>” Something much better than a butterfly you say, grinning as you touch the permanent marking before putting her down to go stow the branding gear away.");

				outputText("\n\n“<i>Yes, but what is it? [name]? Hello?</i>”");
				tText += "lower back.";
				flags[kFLAGS.MILKY_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				smallMilkyButtIntro();
				outputText("\n\n“<i>So, uh...</i>” she says when you’re done. “<i>What did you do?</i>” Something much better than a butterfly you say, grinning as you touch the permanent marking before putting her down to go stow the branding gear away.");

				outputText("\n\n“<i>Yes, but what is it? [name]? Hello?</i>”");
				tText += "butt.";
				flags[kFLAGS.MILKY_TATTOO_BUTT] = tText;
			}

			doNext(camp.returnToCampUseOneHour);
		}

		private function bigMilkyTribalTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "A tribal tattoo, all snaking, erotic lines, across her ";

			if (slot == 0)
			{
				bigMilkyCollarboneIntro();
				tText += "collarbone.";
				flags[kFLAGS.MILKY_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				bigMilkyShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.MILKY_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				bigMilkyLowerBackIntro();
				tText += "lower back.";
				flags[kFLAGS.MILKY_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				bigMilkyButtIntro();
				tText += "butt.";
				flags[kFLAGS.MILKY_TATTOO_BUTT] = tText;
			}

			doNext(camp.returnToCampUseOneHour);
		}

		private function bigMilkyHeartTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "A plump, red love heart tattoo on her ";

			if (slot == 0)
			{
				bigMilkyCollarboneIntro();
				tText += "collarbone.";
				flags[kFLAGS.MILKY_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				bigMilkyShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.MILKY_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				bigMilkyLowerBackIntro();
				tText += "lower back.";
				flags[kFLAGS.MILKY_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				bigMilkyButtIntro();
				tText += "butt.";
				flags[kFLAGS.MILKY_TATTOO_BUTT] = tText;
			}

			doNext(camp.returnToCampUseOneHour);
		}

		private function bigMilkyPropertyOfTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "“Property of [Name]” tattooed across her ";

			if (slot == 0)
			{
				bigMilkyCollarboneIntro();
				tText += "collarbone.";
				flags[kFLAGS.MILKY_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				bigMilkyShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.MILKY_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				bigMilkyLowerBackIntro();
				tText += "lower back.";
				flags[kFLAGS.MILKY_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				bigMilkyButtIntro();
				tText += "butt.";
				flags[kFLAGS.MILKY_TATTOO_BUTT] = tText;
			}

			doNext(camp.returnToCampUseOneHour);
		}

		private function bigMilkyBathToyTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "“Bath Toy” tattooed across her ";

			if (slot == 0)
			{
				bigMilkyCollarboneIntro();
				tText += "collarbone.";
				flags[kFLAGS.MILKY_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				bigMilkyShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.MILKY_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				bigMilkyLowerBackIntro();
				tText += "lower back.";
				flags[kFLAGS.MILKY_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				bigMilkyButtIntro();
				tText += "butt.";
				flags[kFLAGS.MILKY_TATTOO_BUTT] = tText;
			}

			doNext(camp.returnToCampUseOneHour);
		}

		private function bigMilkyMegaMilkTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "“Mega Milk” tattooed across her collarbone.";
			bigMilkyCollarboneIntro();
			flags[kFLAGS.MILKY_TATTOO_COLLARBONE] = tText;


			doNext(camp.returnToCampUseOneHour);
		}

		private function bigMilkyCockCozyTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "“Cock Cozy” tattooed across her collarbone.";
			bigMilkyCollarboneIntro();
			flags[kFLAGS.MILKY_TATTOO_COLLARBONE] = tText;


			doNext(camp.returnToCampUseOneHour);
		}

		private function heartTattoo(slot:int):void
		{
			clearOutput();
			whitneySprite();

			var tText:String = "A plump, red love heart tattoo on her ";

			if (slot == 0)
			{
				collarboneIntro();
				outputText("\n\n“<i>You’ve got skilled fingers, [master],</i>” she says, touching what you’ve drawn admiringly. “<i>Although guess I already knew that.</i>”");
				tText += "collarbone.";
				flags[kFLAGS.WHITNEY_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				shouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.WHITNEY_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				lowerbackIntro();
				tText += "lower back.";
				flags[kFLAGS.WHITNEY_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				buttIntro();
				tText += "butt.";
				flags[kFLAGS.WHITNEY_TATTOO_BUTT] = tText;
			}

			tattooMerge();
		}

		private function amilyHeartTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "A plump, red love heart tattoo on her ";

			if (slot == 0)
			{
				amilyCollarboneIntro();
				outputText("\n\n“<i>Does this make me more beautiful to you, [master]?</i>” she says, touching what you’ve drawn admiringly. “<i>If so... it’s exactly what I wanted.</i>”");
				tText += "collarbone.";
				flags[kFLAGS.AMILY_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				amilyShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.AMILY_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				amilyLowerBackIntro();
				tText += "lower back.";
				flags[kFLAGS.AMILY_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				amilyButtIntro();
				tText += "butt.";
				flags[kFLAGS.AMILY_TATTOO_BUTT] = tText;
			}

			doNext(camp.returnToCampUseOneHour);
		}

		private function jojoHeartTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "A plump, red love heart tattoo on his ";

			if (slot == 0)
			{
				jojoCollarboneIntro();
				tText += "collarbone.";
				flags[kFLAGS.JOJO_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				jojoShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.JOJO_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				jojoLowerbackIntro();
				tText += "lower back.";
				flags[kFLAGS.JOJO_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				jojoButtIntro();
				tText += "butt.";
				flags[kFLAGS.JOJO_TATTOO_BUTT] = tText;
			}

			doNext(camp.returnToCampUseOneHour);
		}

		private function bimboSophieHeartTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "A plump, red love heart tattoo on her ";

			if (slot == 0)
			{
				bimboSophieCollarboneIntro();
				outputText("\n\n“<i>Woah,</i>” she says, awed at your drawing. “<i>You are sooooo artsy [name], that’s beautiful! You’ll like do more on me, right?</i>” Laughing, you tell her maybe, if she behaves well for Mistress Whitney and lays plenty of eggs for you. An expression of deepest determination emerges on the harpy’s beautiful features.");

				outputText("\n\n“<i>If it means more super sexy tats I will do my absolute bestest, babe!</i>”");
				tText += "collarbone.";
				flags[kFLAGS.SOPHIE_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				bimboSophieShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.SOPHIE_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				bimboSophieLowerBackIntro();
				tText += "lower back.";
				flags[kFLAGS.SOPHIE_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				bimboSophieButtIntro();
				tText += "butt.";
				flags[kFLAGS.SOPHIE_TATTOO_BUTT] = tText;
			}

			doNext(camp.returnToCampUseOneHour);
		}

		private function vapulaHeartTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "A plump, red love heart tattoo on her ";

			if (slot == 0)
			{
				vapulaCollarboneIntro();
				outputText("\n\n“<i>How gauche,</i>” she yawns after you’re done. “<i>I might have to start wearing clothes now.</i>” You can tell by the grin curling her lip and the way she touches the design she’s quietly pleased with it, though.");
				tText += "collarbone.";
				flags[kFLAGS.VAPULA_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				vapulaShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.VAPULA_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				vapulaLowerBackIntro();
				tText += "lower back.";
				flags[kFLAGS.VAPULA_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				vapulaButtIntro();
				tText += "butt.";
				flags[kFLAGS.VAPULA_TATTOO_BUTT] = tText;
			}

			doNext(camp.returnToCampUseOneHour);
		}

		private function kellyHeartTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "A plump, red love heart tattoo on her ";

			if (slot == 0)
			{
				kellyCollarboneIntro();
				outputText("“<i>That’s- that’s actually really pretty, [master]!</i>” Kelly says when you’re done, looking down with delight. “<i>Thank you!</i>”");
				tText += "collarbone.";
				flags[kFLAGS.KELLY_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				kellyShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.KELLY_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				kellyLowerBackIntro();
				tText += "lower back.";
				flags[kFLAGS.KELLY_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				kellyButtIntro();
				tText += "butt.";
				flags[kFLAGS.KELLY_TATTOO_BUTT] = tText;
			}

			doNext(camp.returnToCampUseOneHour);
		}

		private function smallMilkyHeartTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "A plump, red love heart tattoo on her ";

			if (slot == 0)
			{
				smallMilkyCollarboneIntro();
				outputText("“<i>Oh hey, that’s quite pretty.</i>” [bathgirlName] smiles down at what you’ve drawn as you withdraw the pen. “<i>Thanks, [name]!</i>” You kiss her fondly on the forehead and send her on her way.");
				tText += "collarbone.";
				flags[kFLAGS.MILKY_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				smallMilkyShouldersIntro();
				outputText("\n\n“<i>So, uh...</i>” she says when you’re done. “<i>What did you do?</i>” Something much better than a butterfly you say, grinning as you touch the permanent marking before turning to go stow the branding gear away.");

				outputText("\n\n“<i>Yes, but what is it? [name]? Hello?...</i>”");
				tText += "shoulders.";
				flags[kFLAGS.MILKY_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				smallMilkyLowerBackIntro();
				outputText("\n\n“<i>So, uh...</i>” she says when you’re done. “<i>What did you do?</i>” Something much better than a butterfly you say, grinning as you touch the permanent marking before putting her down to go stow the branding gear away.");

				outputText("\n\n“<i>Yes, but what is it? [name]? Hello?</i>”");
				tText += "lower back.";
				flags[kFLAGS.MILKY_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				smallMilkyButtIntro();
				outputText("\n\n“<i>So, uh...</i>” she says when you’re done. “<i>What did you do?</i>” Something much better than a butterfly you say, grinning as you touch the permanent marking before putting her down to go stow the branding gear away.");

				outputText("\n\n“<i>Yes, but what is it? [name]? Hello?</i>”");
				tText += "butt.";
				flags[kFLAGS.MILKY_TATTOO_BUTT] = tText;
			}

			doNext(camp.returnToCampUseOneHour);
		}

		private function smallMilkyPropertyOfTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "“Property of [Name]” tattooed across her ";

			if (slot == 0)
			{
				smallMilkyCollarboneIntro();
				outputText("“<i>[name],</i>” [bathgirlName] groans with laughter, deep embarrassment coloring her tan cheeks as she looks down at what you’ve written. “<i>Everyone can see that!</i>” That’s the whole point you reply, with a rakish grin. She sighs in exasperation as you kiss her fondly on the forehead and take your leave.");
				tText += "collarbone.";
				flags[kFLAGS.MILKY_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				smallMilkyShouldersIntro();
				outputText("\n\n“<i>So, uh...</i>” she says when you’re done. “<i>What did you do?</i>” Something much better than a butterfly you say, grinning as you touch the permanent marking before turning to go stow the branding gear away.");

				outputText("\n\n“<i>Yes, but what is it? [name]? Hello?...</i>”");
				tText += "shoulders.";
				flags[kFLAGS.MILKY_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				smallMilkyLowerBackIntro();
				outputText("\n\n“<i>So, uh...</i>” she says when you’re done. “<i>What did you do?</i>” Something much better than a butterfly you say, grinning as you touch the permanent marking before putting her down to go stow the branding gear away.");

				outputText("\n\n“<i>Yes, but what is it? [name]? Hello?</i>”");
				tText += "lower back.";
				flags[kFLAGS.MILKY_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				smallMilkyButtIntro();
				outputText("\n\n“<i>So, uh...</i>” she says when you’re done. “<i>What did you do?</i>” Something much better than a butterfly you say, grinning as you touch the permanent marking before putting her down to go stow the branding gear away.");

				outputText("\n\n“<i>Yes, but what is it? [name]? Hello?</i>”");
				tText += "butt.";
				flags[kFLAGS.MILKY_TATTOO_BUTT] = tText;
			}

			doNext(camp.returnToCampUseOneHour);
		}

		private function smallMilkyBathToyTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "“Bath Toy” tattooed across her ";

			if (slot == 0)
			{
				smallMilkyCollarboneIntro();
				outputText("“<i>[name],</i>” [bathgirlName] groans with laughter, deep embarrassment coloring her tan cheeks as she looks down at what you’ve written. “<i>Everyone can see that!</i>” That’s the whole point you reply, with a rakish grin. She sighs in exasperation as you kiss her fondly on the forehead and take your leave.");
				tText += "collarbone.";
				flags[kFLAGS.MILKY_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				smallMilkyShouldersIntro();
				outputText("\n\n“<i>So, uh...</i>” she says when you’re done. “<i>What did you do?</i>” Something much better than a butterfly you say, grinning as you touch the permanent marking before turning to go stow the branding gear away.");

				outputText("\n\n“<i>Yes, but what is it? [name]? Hello?...</i>”");
				tText += "shoulders.";
				flags[kFLAGS.MILKY_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				smallMilkyLowerBackIntro();
				outputText("\n\n“<i>So, uh...</i>” she says when you’re done. “<i>What did you do?</i>” Something much better than a butterfly you say, grinning as you touch the permanent marking before putting her down to go stow the branding gear away.");

				outputText("\n\n“<i>Yes, but what is it? [name]? Hello?</i>”");
				tText += "lower back.";
				flags[kFLAGS.MILKY_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				smallMilkyButtIntro();
				outputText("\n\n“<i>So, uh...</i>” she says when you’re done. “<i>What did you do?</i>” Something much better than a butterfly you say, grinning as you touch the permanent marking before putting her down to go stow the branding gear away.");

				outputText("\n\n“<i>Yes, but what is it? [name]? Hello?</i>”");
				tText += "butt.";
				flags[kFLAGS.MILKY_TATTOO_BUTT] = tText;
			}

			doNext(camp.returnToCampUseOneHour);
		}

		private function smallMilkyMegaMilkTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "“Mega Milk” tattooed across her collarbone.";

			smallMilkyCollarboneIntro();
			outputText("“<i>[name],</i>” [bathgirlName] groans with laughter, deep embarrassment coloring her tan cheeks as she looks down at what you’ve written. “<i>Everyone can see that!</i>” That’s the whole point you reply, with a rakish grin. She sighs in exasperation as you kiss her fondly on the forehead and take your leave.");
			flags[kFLAGS.MILKY_TATTOO_COLLARBONE] = tText;

			doNext(camp.returnToCampUseOneHour);
		}

		private function smallMilkyCockCozyTattoo():void
		{
			clearOutput();

			var tText:String = "“Cock Cozy” tattooed across her collarbone.";

			smallMilkyCollarboneIntro();
			outputText("“<i>[name],</i>” [bathgirlName] groans with laughter, deep embarrassment coloring her tan cheeks as she looks down at what you’ve written. “<i>Everyone can see that!</i>” That’s the whole point you reply, with a rakish grin. She sighs in exasperation as you kiss her fondly on the forehead and take your leave.");
			flags[kFLAGS.MILKY_TATTOO_COLLARBONE] = tText;

			doNext(camp.returnToCampUseOneHour);
		}

		public function numMilkyButterflyTats():int
		{
			var count:int = 0;
			if (flags[kFLAGS.MILKY_TATTOO_COLLARBONE] is String)
			{
				if (flags[kFLAGS.MILKY_TATTOO_COLLARBONE].indexOf("A butterfly") >= 0) count++;
			}
			if (flags[kFLAGS.MILKY_TATTOO_SHOULDERS] is String)
			{
				if (flags[kFLAGS.MILKY_TATTOO_SHOULDERS].indexOf("A butterfly") >= 0) count++;
			}
			if (flags[kFLAGS.MILKY_TATTOO_LOWERBACK] is String)
			{
				if (flags[kFLAGS.MILKY_TATTOO_LOWERBACK].indexOf("A butterfly") >= 0) count++;
			}
			if (flags[kFLAGS.MILKY_TATTOO_BUTT] is String)
			{
				if (flags[kFLAGS.MILKY_TATTOO_BUTT].indexOf("A butterfly") >= 0) count++;
			}
			return count;
		}

		private function smallMilkyButterflyTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "A butterfly, its four leaf-like wings in flight, tattooed across her ";

			if (slot == 0)
			{
				smallMilkyCollarboneIntro();

				if (numMilkyButterflyTats() < 3)
				{
					outputText("\n\nShe looks down with growing delight as the four winged shape becomes apparent, and then almost completely ruins it by gushing with glee, making her chest quiver, as you add the final red flourishes. Once you’re finished she plants a big kiss on your lips.");

					outputText("\n\n“<i>Thank you so much [name], that’s beautiful! I can’t wait to show it off to everyone else around here!</i>” You smile as you watch her leave, her fingers trailing over her new butterfly, adjusting her clothes to make the most of it.");
				}
				else
				{
					outputText("\n\n“Oh for...” [bathgirlName] sighs with exasperation as, through long experience, she quickly discerns what you’re drawing. Grinning, you tell her again to be still. “<i>I know I said I liked butterflies [name],</i>” she says when you’re done. “<i>But look at me! They’re crawling all over me, it’s ridiculous. I look like... like...</i>” like you took a bath in butterflies, you suggest, sitting back and drinking in her naked, lepidopteron covered form. And it’s absolutely adorable.");

					outputText("\n\n“<i>I’m going to be very careful about what I say I like to you in future,</i>” she says, visibly struggling to stay angry as she turns herself around and around to admire herself. “<i>I guess - they definitely make me look different, don’t they?</i>” You kiss her fondly on the forehead and send her on her way with a clap on the butterfly.");
				}

				tText += "collarbone.";
				flags[kFLAGS.MILKY_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				smallMilkyShouldersIntro();

				if (numMilkyButterflyTats() < 3)
				{
					outputText("\n\n[bathgirlName]’s back quivers when you trace a four winged shape; she’s worked out what you’re doing. Grinning, you tell her to be still. She still almost ruins it by gushing with glee as you add the final red flourishes. Once you’re finished she immediately gets up and plants a big kiss on your lips.");

					outputText("\n\n“<i>Thank you so much [name]! I can’t wait to show it off to everyone else around here!</i>” You smile as you watch her leave, her fingers trailing over her new butterfly, adjusting her clothes to make the most of it.");
				}
				else
				{
					outputText("\n\n“Oh for...” [bathgirlName] sighs with exasperation as, through long experience, she quickly discerns what you’re drawing. Grinning, you tell her again to be still. “<i>I know I said I liked butterflies [name],</i>” she says when you’re done. “<i>But look at me! They’re crawling all over me, it’s ridiculous. I look like... like...</i>” like you took a bath in butterflies, you suggest, sitting back and drinking in her naked, lepidopteron covered form. And it’s absolutely adorable.");

					outputText("\n\n“<i>I’m going to be very careful about what I say I like to you in future,</i>” she says, visibly struggling to stay angry as she turns herself around and around to admire herself. “<i>I guess - they definitely make me look different, don’t they?</i>” You kiss her fondly on the forehead and send her on her way with a clap on the butterfly.");
				}

				tText += "shoulders.";
				flags[kFLAGS.MILKY_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				smallMilkyLowerBackIntro();

				if (numMilkyButterflyTats() < 3)
				{
					outputText("\n\n[bathgirlName]’s back quivers when you trace a four winged shape; she’s worked out what you’re doing. Grinning, you tell her to be still, but she almost ruins it by gushing with glee as you add the final red flourishes. Once you’re finished she immediately gets up and plants a big kiss on your lips.");

					outputText("\n\n“<i>Thank you so much [name]! I can’t wait to show it off to everyone else around here!</i>” You smile as you watch her leave, her fingers trailing over her new butterfly, attempting to adjust her clothes to make the most of it.");
				}
				else
				{
					outputText("\n\n“Oh for...” [bathgirlName] sighs with exasperation as, through long experience, she quickly discerns what you’re drawing. Grinning, you tell her again to be still. “<i>I know I said I liked butterflies [name],</i>” she says when you’re done. “<i>But look at me! They’re crawling all over me, it’s ridiculous. I look like... like...</i>” like you took a bath in butterflies, you suggest, sitting back and drinking in her naked, lepidopteron covered form. And it’s absolutely adorable.");

					outputText("\n\n“<i>I’m going to be very careful about what I say I like to you in future,</i>” she says, visibly struggling to stay angry as she turns herself around and around to admire herself. “<i>I guess - they definitely make me look different, don’t they?</i>” You kiss her fondly on the forehead and send her on her way with a clap on the butterfly.");
				}

				tText += "lower back.";
				flags[kFLAGS.MILKY_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				smallMilkyButtIntro();

				if (numMilkyButterflyTats() < 3)
				{
					outputText("\n\n[bathgirlName]’s back quivers when you trace a four winged shape; she’s worked out what you’re doing. Grinning, you tell her to be still. She still almost ruins it by gushing with glee as you add the final red flourishes. Once you’re finished she immediately gets up and plants a big kiss on your lips.");

					outputText("\n\n“<i>Thank you so much [name]! I can’t wait to show it off to – well, I am so pleased with it, anyway!</i>” You smile as you watch her leave, her fingers trailing over her new butterfly, attempting to adjust her clothes to make the most of it.");
				}
				else
				{
					outputText("\n\n“Oh for...” [bathgirlName] sighs with exasperation as, through long experience, she quickly discerns what you’re drawing. Grinning, you tell her again to be still. “<i>I know I said I liked butterflies [name],</i>” she says when you’re done. “<i>But look at me! They’re crawling all over me, it’s ridiculous. I look like... like...</i>” like you took a bath in butterflies, you suggest, sitting back and drinking in her naked, lepidopteron covered form. And it’s absolutely adorable.");

					outputText("\n\n“<i>I’m going to be very careful about what I say I like to you in future,</i>” she says, visibly struggling to stay angry as she turns herself around and around to admire herself. “<i>I guess - they definitely make me look different, don’t they?</i>” You kiss her fondly on the forehead and send her on her way with a clap on the butterfly.");
				}

				tText += "butt.";
				flags[kFLAGS.MILKY_TATTOO_BUTT] = tText;
			}

			doNext(camp.returnToCampUseOneHour);
		}

		private function kellyHorseshoeTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "A horseshoe imprinted firmly on each shoulder.";

			kellyShouldersIntro();
			flags[kFLAGS.KELLY_TATTOO_SHOULDERS] = tText;

			doNext(camp.returnToCampUseOneHour);
		}

		private function kellyPropertyOfTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "“Property of [Name]” tattooed across her ";

			if (slot == 0)
			{
				kellyCollarboneIntro();
				outputText("\n\n“<i>Oh, [master],</i>” Kelly sighs with a mixture of exasperation and shameless lust when you’re done, looking at what you’ve permanently inscribed on her chest. “<i>Did you have to write it quite so large?</i>” You say in a tone of complete reasonableness that you tattoo things relative to the size of the truth behind them, to which she has no answer.");
				tText += "collarbone.";
				flags[kFLAGS.KELLY_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				kellyShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.KELLY_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				kellyLowerBackIntro();
				tText += "lower back.";
				flags[kFLAGS.KELLY_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				kellyButtIntro();
				tText += "butt.";
				flags[kFLAGS.KELLY_TATTOO_BUTT] = tText;
			}

			doNext(camp.returnToCampUseOneHour);
		}

		private function kellyNo1FillyTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "“#1 Filly” tattooed across her ";

			if (slot == 0)
			{
				kellyCollarboneIntro();
				outputText("\n\n“<i>Oh, [master],</i>” Kelly sighs with a mixture of exasperation and shameless lust when you’re done, looking at what you’ve permanently inscribed on her chest. “<i>Did you have to write it quite so large?</i>” You say in a tone of complete reasonableness that you tattoo things relative to the size of the truth behind them, to which she has no answer.");
				tText += "collarbone.";
				flags[kFLAGS.KELLY_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				kellyShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.KELLY_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				kellyLowerBackIntro();
				tText += "lower back.";
				flags[kFLAGS.KELLY_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				kellyButtIntro();
				tText += "butt.";
				flags[kFLAGS.KELLY_TATTOO_BUTT] = tText;
			}

			doNext(camp.returnToCampUseOneHour);
		}

		private function kellyDickWonTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "“I Fought the Dick And the Dick Won” tattooed in fine text across her ";

			if (slot == 0)
			{
				kellyCollarboneIntro();
				outputText("\n\n“<i>Oh, [master],</i>” Kelly sighs with a mixture of exasperation and shameless lust when you’re done, looking at what you’ve permanently inscribed on her chest. “<i>Did you have to write it quite so large?</i>” You say in a tone of complete reasonableness that you tattoo things relative to the size of the truth behind them, to which she has no answer.");
				tText += "collarbone.";
				flags[kFLAGS.KELLY_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				kellyShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.KELLY_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				kellyLowerBackIntro();
				tText += "lower back.";
				flags[kFLAGS.KELLY_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				kellyButtIntro();
				tText += "butt.";
				flags[kFLAGS.KELLY_TATTOO_BUTT] = tText;
			}

			doNext(camp.returnToCampUseOneHour);
		}

		private function propertyTattoo(slot:int):void
		{
			clearOutput();
			whitneySprite();

			var tText:String = "“Property of [Name]” tattooed across her ";

			if (slot == 0)
			{
				collarboneIntro();
				outputText("\n\n“<i>As if I ever need reminding of that, [master],</i>” she says with an exasperated, flustered laugh, when she looks down at what is now inscribed for all to see on her chest.");
				tText += "collarbone.";
				flags[kFLAGS.WHITNEY_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				shouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.WHITNEY_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				lowerbackIntro();
				tText += "lower back.";
				flags[kFLAGS.WHITNEY_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				buttIntro();
				tText += "butt.";
				flags[kFLAGS.WHITNEY_TATTOO_BUTT] = tText;
			}

			tattooMerge();
		}

		private function amilyPropertyTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "“Property of [Name]” tattooed across her ";

			if (slot == 0)
			{
				amilyCollarboneIntro();
				outputText("\n\n“<i>As if I ever need reminding of that, [master],</i>” she says with a delighted laugh when she looks down at what is now inscribed for all to see on her naked chest.");
				tText += "collarbone.";
				flags[kFLAGS.AMILY_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				amilyShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.AMILY_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				amilyLowerBackIntro();
				tText += "lower back.";
				flags[kFLAGS.AMILY_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				amilyButtIntro();
				tText += "butt.";
				flags[kFLAGS.AMILY_TATTOO_BUTT] = tText;
			}

			doNext(camp.returnToCampUseOneHour);
		}

		private function jojoPropertyTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "“Property of [Name]” tattooed across his ";

			if (slot == 0)
			{
				jojoCollarboneIntro();
				tText += "collarbone.";
				flags[kFLAGS.JOJO_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				jojoShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.JOJO_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				jojoLowerbackIntro();
				tText += "lower back.";
				flags[kFLAGS.JOJO_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				jojoButtIntro();
				tText += "butt.";
				flags[kFLAGS.JOJO_TATTOO_BUTT] = tText;
			}

			doNext(camp.returnToCampUseOneHour);
		}
		
		private function jojoSissySlutTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "“Sissy Slut” tattooed across his ";

			if (slot == 0)
			{
				jojoCollarboneIntro();
				tText += "collarbone.";
				flags[kFLAGS.JOJO_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				jojoShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.JOJO_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				jojoLowerbackIntro();
				tText += "lower back.";
				flags[kFLAGS.JOJO_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				jojoButtIntro();
				tText += "butt.";
				flags[kFLAGS.JOJO_TATTOO_BUTT] = tText;
			}

			doNext(camp.returnToCampUseOneHour);
		}

		private function bimboSophiePropertyOfTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "“Property of [Name]” tattooed across her ";

			if (slot == 0)
			{
				bimboSophieCollarboneIntro();
				outputText("\n\n“<i>F...</i>” she says, looking down and reading aloud. “<i>Fa...wait. Is that a p? P...pro...no wait, I am a silly! It’s an R. Ro...</i>”");

				outputText("\n\nYou leave her to it.");
				tText += "collarbone.";
				flags[kFLAGS.SOPHIE_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				bimboSophieShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.SOPHIE_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				bimboSophieLowerBackIntro();
				tText += "lower back.";
				flags[kFLAGS.SOPHIE_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				bimboSophieButtIntro();
				tText += "butt.";
				flags[kFLAGS.SOPHIE_TATTOO_BUTT] = tText;
			}

			doNext(camp.returnToCampUseOneHour);
		}

		private function vapulaPropertyOfTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "“Property of [Name]” tattooed across her ";

			if (slot == 0)
			{
				vapulaCollarboneIntro();
				outputText("\n\n“<i>Way to state the blindingly obvious, [master],</i>” she sighs with a roll of the eyes after she’s glanced down. You can tell by the grin curling her lip and the way she touches the words the slut is quietly pleased with it though.");
				tText += "collarbone.";
				flags[kFLAGS.VAPULA_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				vapulaShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.VAPULA_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				vapulaLowerBackIntro();
				tText += "lower back.";
				flags[kFLAGS.VAPULA_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				vapulaButtIntro();
				tText += "butt.";
				flags[kFLAGS.VAPULA_TATTOO_BUTT] = tText;
			}

			doNext(camp.returnToCampUseOneHour);
		}

		private function vapulaCumAddictTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "“Cum Addict” tattooed across her ";

			if (slot == 0)
			{
				vapulaCollarboneIntro();
				outputText("\n\n“<i>Way to state the blindingly obvious, [master],</i>” she sighs with a roll of the eyes after she’s glanced down. You can tell by the grin curling her lip and the way she touches the words the slut is quietly pleased with it though.");
				tText += "collarbone.";
				flags[kFLAGS.VAPULA_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				vapulaShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.VAPULA_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				vapulaLowerBackIntro();
				tText += "lower back.";
				flags[kFLAGS.VAPULA_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				vapulaButtIntro();
				tText += "butt.";
				flags[kFLAGS.VAPULA_TATTOO_BUTT] = tText;
			}

			doNext(camp.returnToCampUseOneHour);
		}

		private function vapulaButtslutTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "“Buttslut” tattooed in a red love heart across her lower back.";

			vapulaLowerBackIntro();
			flags[kFLAGS.VAPULA_TATTOO_LOWERBACK] = tText;

			doNext(camp.returnToCampUseOneHour);
		}

		private function vapulaDildoPolisherTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "“Dildo Polisher” tattooed across her ";

			if (slot == 0)
			{
				vapulaCollarboneIntro();
				outputText("\n\n“<i>Way to state the blindingly obvious, [master],</i>” she sighs with a roll of the eyes after she’s glanced down. You can tell by the grin curling her lip and the way she touches the words the slut is quietly pleased with it though.");
				tText += "collarbone.";
				flags[kFLAGS.VAPULA_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				vapulaShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.VAPULA_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				vapulaLowerBackIntro();
				tText += "lower back.";
				flags[kFLAGS.VAPULA_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				vapulaButtIntro();
				tText += "butt.";
				flags[kFLAGS.VAPULA_TATTOO_BUTT] = tText;
			}

			doNext(camp.returnToCampUseOneHour);
		}

		private function bimboSophieSwallowTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "A swallow with its tapering wings in flight across her ";

			if (slot == 0)
			{
				bimboSophieCollarboneIntro();
				outputText("\n\n“<i>Woah,</i>” she says, awed at your drawing. “<i>You are sooooo artsy [name], that’s beautiful! You’ll like do more on me, right?</i>” Laughing, you tell her maybe, if she behaves well for Mistress Whitney and lays plenty of eggs for you. An expression of deepest determination emerges on the harpy’s beautiful features.");

				outputText("\n\n“<i>If it means more super sexy tats I will do my absolute bestest, babe!</i>”");
				tText += "collarbone.";
				flags[kFLAGS.SOPHIE_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				bimboSophieShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.SOPHIE_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				bimboSophieLowerBackIntro();
				tText += "lower back.";
				flags[kFLAGS.SOPHIE_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				bimboSophieButtIntro();
				tText += "butt.";
				flags[kFLAGS.SOPHIE_TATTOO_BUTT] = tText;
			}

			doNext(camp.returnToCampUseOneHour);
		}

		private function bimboSophieBreedingBitchTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "“Breeding Bitch” tattooed across her ";

			if (slot == 0)
			{
				bimboSophieCollarboneIntro();
				outputText("\n\n“<i>Woah,</i>” she says, awed at your drawing. “<i>You are sooooo artsy [name], that’s beautiful! You’ll like do more on me, right?</i>” Laughing, you tell her maybe, if she behaves well for Mistress Whitney and lays plenty of eggs for you. An expression of deepest determination emerges on the harpy’s beautiful features.");

				outputText("\n\n“<i>If it means more super sexy tats I will do my absolute bestest, babe!</i>”");
				tText += "collarbone.";
				flags[kFLAGS.SOPHIE_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				bimboSophieShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.SOPHIE_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				bimboSophieLowerBackIntro();
				tText += "lower back.";
				flags[kFLAGS.SOPHIE_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				bimboSophieButtIntro();
				tText += "butt.";
				flags[kFLAGS.SOPHIE_TATTOO_BUTT] = tText;
			}

			doNext(camp.returnToCampUseOneHour);
		}

		private function bimboSophieCockGoesHereTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "“Cock Goes Here” tattooed across her lower back.";

			bimboSophieLowerBackIntro();
			flags[kFLAGS.SOPHIE_TATTOO_LOWERBACK] = tText;

			doNext(camp.returnToCampUseOneHour);
		}

		private function bimboSophieWideLoadTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "“Wide” tattooed across one butt cheek and “Load” tattooed on the other.";

			bimboSophieButtIntro();
			flags[kFLAGS.SOPHIE_TATTOO_BUTT] = tText;

			doNext(camp.returnToCampUseOneHour);
		}

		private function no1Tattoo(slot:int):void
		{
			clearOutput();
			whitneySprite();

			var tText:String = "“No. 1 Bitch” tattooed across her ";

			if (slot == 0)
			{
				collarboneIntro();
				outputText("\n\n“<i>As if I ever need reminding of that, [master],</i>” she says with an exasperated, flustered laugh, when she looks down at what is now inscribed for all to see on her chest.");
				tText += "collarbone.";
				flags[kFLAGS.WHITNEY_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				shouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.WHITNEY_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				lowerbackIntro();
				tText += "lower back.";
				flags[kFLAGS.WHITNEY_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				buttIntro();
				tText += "butt.";
				flags[kFLAGS.WHITNEY_TATTOO_BUTT] = tText;
			}

			tattooMerge();
		}

		private function amilyBreedingBitchTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "“Breeding Bitch” tattooed across her ";

			if (slot == 0)
			{
				amilyCollarboneIntro();
				outputText("\n\n“<i>As if I ever need reminding of that, [master],</i>” she says with a delighted laugh when she looks down at what is now inscribed for all to see on her naked chest.");
				tText += "collarbone.";
				flags[kFLAGS.AMILY_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				amilyShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.AMILY_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				amilyLowerBackIntro();
				tText += "lower back.";
				flags[kFLAGS.AMILY_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				amilyButtIntro();
				tText += "butt.";
				flags[kFLAGS.AMILY_TATTOO_BUTT] = tText;
			}

			doNext(camp.returnToCampUseOneHour);
		}

		private function champCocksuckerTattoo(slot:int):void
		{
			clearOutput();
			whitneySprite();

			var tText:String = "“Champion Cocksucker” tattooed across her ";

			if (slot == 0)
			{
				collarboneIntro();
				outputText("\n\n“<i>As if I ever need reminding of that, [master],</i>” she says with an exasperated, flustered laugh, when she looks down at what is now inscribed for all to see on her chest.");
				tText += "collarbone.";
				flags[kFLAGS.WHITNEY_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				shouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.WHITNEY_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				lowerbackIntro();
				tText += "lower back.";
				flags[kFLAGS.WHITNEY_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				buttIntro();
				tText += "butt.";
				flags[kFLAGS.WHITNEY_TATTOO_BUTT] = tText;
			}

			tattooMerge();
		}

		private function amilyCockGoesHereTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "“Cock Goes Here” tattooed across her ";

			if (slot == 0)
			{
				amilyCollarboneIntro();
				outputText("\n\n“<i>As if I ever need reminding of that, [master],</i>” she says with a delighted laugh when she looks down at what is now inscribed for all to see on her naked chest.");
				tText += "collarbone.";
				flags[kFLAGS.AMILY_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				amilyShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.AMILY_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				amilyLowerBackIntro();
				tText += "lower back.";
				flags[kFLAGS.AMILY_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				amilyButtIntro();
				tText += "butt.";
				flags[kFLAGS.AMILY_TATTOO_BUTT] = tText;
			}

			doNext(camp.returnToCampUseOneHour);
		}

		private function jojoCockGoesHereTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "“Cock Goes Here” tattooed across his ";

			if (slot == 0)
			{
				jojoCollarboneIntro();
				tText += "collarbone.";
				flags[kFLAGS.JOJO_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				jojoShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.JOJO_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				jojoLowerbackIntro();
				tText += "lower back.";
				flags[kFLAGS.JOJO_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				jojoButtIntro();
				tText += "butt.";
				flags[kFLAGS.JOJO_TATTOO_BUTT] = tText;
			}

			doNext(camp.returnToCampUseOneHour);
		}

		private function amilyMommysGirlTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "“Mommy’s Girl” tattooed across her ";

			if (slot == 0)
			{
				amilyCollarboneIntro();
				outputText("\n\n“<i>As if I ever need reminding of that, [master],</i>” she says with a delighted laugh when she looks down at what is now inscribed for all to see on her naked chest.");
				tText += "collarbone.";
				flags[kFLAGS.AMILY_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				amilyShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.AMILY_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				amilyLowerBackIntro();
				tText += "lower back.";
				flags[kFLAGS.AMILY_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				amilyButtIntro();
				tText += "butt.";
				flags[kFLAGS.AMILY_TATTOO_BUTT] = tText;
			}

			doNext(camp.returnToCampUseOneHour);
		}

		private function jojoMommysBoyTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "“Mommy’s Boy” tattooed across his ";

			if (slot == 0)
			{
				jojoCollarboneIntro();
				tText += "collarbone.";
				flags[kFLAGS.JOJO_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				jojoShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.JOJO_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				jojoLowerbackIntro();
				tText += "lower back.";
				flags[kFLAGS.JOJO_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				jojoButtIntro();
				tText += "butt.";
				flags[kFLAGS.JOJO_TATTOO_BUTT] = tText;
			}

			doNext(camp.returnToCampUseOneHour);
		}

		private function champPussylickerTattoo(slot:int):void
		{
			clearOutput();
			whitneySprite();

			var tText:String = "“Champion Pussylicker” tattooed across her ";

			if (slot == 0)
			{
				collarboneIntro();
				outputText("\n\n“<i>As if I ever need reminding of that, [master],</i>” she says with an exasperated, flustered laugh, when she looks down at what is now inscribed for all to see on her chest.");
				tText += "collarbone.";
				flags[kFLAGS.WHITNEY_TATTOO_COLLARBONE] += tText;
			}
			else if (slot == 1)
			{
				shouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.WHITNEY_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				lowerbackIntro();
				tText += "lower back.";
				flags[kFLAGS.WHITNEY_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				buttIntro();
				tText += "butt.";
				flags[kFLAGS.WHITNEY_TATTOO_BUTT] = tText;
			}

			tattooMerge();
		}

		private function dontTestBranding():void
		{
			clearOutput();
			whitneySprite();

			outputText("Maybe later, you say. Whitney looks disappointed.");

			outputText("\n\n“<i>Fine. I’ll put it in the barn so if you ever get the urge to, um, mark some cattle, it’s there. Be warned though [master], that ink ain’t cheap- each mark’ll cost 50 gems.</i>”");

			outputText("\n\nYou tell her she’s done very well, before turning and leaving.");

			doNext(camp.returnToCampUseOneHour);
		}

		private function numAmilyTribalTats():int
		{
			var count:int = 0;
			if (flags[kFLAGS.AMILY_TATTOO_COLLARBONE] is String)
			{
				if (flags[kFLAGS.AMILY_TATTOO_COLLARBONE].indexOf("A tribal tattoo") >= 0) count++;
			}
			if (flags[kFLAGS.AMILY_TATTOO_SHOULDERS] is String)
			{
				if (flags[kFLAGS.AMILY_TATTOO_SHOULDERS].indexOf("A tribal tattoo") >= 0) count++;
			}
			if (flags[kFLAGS.AMILY_TATTOO_LOWERBACK] is String)
			{
				if (flags[kFLAGS.AMILY_TATTOO_LOWERBACK].indexOf("A tribal tattoo") >= 0) count++;
			}
			if (flags[kFLAGS.AMILY_TATTOO_BUTT] is String)
			{
				if (flags[kFLAGS.AMILY_TATTOO_BUTT].indexOf("A tribal tattoo") >= 0) count++;
			}
			return count;
		}

		private function numWhitneyTribalTats():int
		{
			var count:int = 0;
			if (flags[kFLAGS.WHITNEY_TATTOO_COLLARBONE] is String)
			{
				if (flags[kFLAGS.WHITNEY_TATTOO_COLLARBONE].indexOf("A tribal tattoo") >= 0) count++;
			}
			if (flags[kFLAGS.WHITNEY_TATTOO_SHOULDERS] is String)
			{
				if (flags[kFLAGS.WHITNEY_TATTOO_SHOULDERS].indexOf("A tribal tattoo") >= 0) count++;
			}
			if (flags[kFLAGS.WHITNEY_TATTOO_LOWERBACK] is String)
			{
				if (flags[kFLAGS.WHITNEY_TATTOO_LOWERBACK].indexOf("A tribal tattoo") >= 0) count++;
			}
			if (flags[kFLAGS.WHITNEY_TATTOO_BUTT] is String)
			{
				if (flags[kFLAGS.WHITNEY_TATTOO_BUTT].indexOf("A tribal tattoo") >= 0) count++;
			}
			return count;
		}

		public function whitneyFullTribalTats():Boolean
		{
			if (numWhitneyTribalTats() == 4) return true;
			return false;
		}

		public function amilyFullTribalTats():Boolean
		{
			if (numAmilyTribalTats() == 4) return true;
			return false;
		}

		private function numJojoTribalTats():int
		{
			var count:int = 0;
			if (flags[kFLAGS.JOJO_TATTOO_COLLARBONE] is String)
			{
				if (flags[kFLAGS.JOJO_TATTOO_COLLARBONE].indexOf("A tribal tattoo") >= 0) count++;
			}
			if (flags[kFLAGS.JOJO_TATTOO_SHOULDERS] is String)
			{
				if (flags[kFLAGS.JOJO_TATTOO_SHOULDERS].indexOf("A tribal tattoo") >= 0) count++;
			}
			if (flags[kFLAGS.JOJO_TATTOO_LOWERBACK] is String)
			{
				if (flags[kFLAGS.JOJO_TATTOO_LOWERBACK].indexOf("A tribal tattoo") >= 0) count++;
			}
			if (flags[kFLAGS.JOJO_TATTOO_BUTT] is String)
			{
				if (flags[kFLAGS.JOJO_TATTOO_BUTT].indexOf("A tribal tattoo") >= 0) count++;
			}
			return count;
		}

		public function jojoFullTribalTats():Boolean
		{
			if (numJojoTribalTats() == 4) return true;
			return false;
		}

		private function numSophieTribalTats():int
		{
			var count:int = 0;
			if (flags[kFLAGS.SOPHIE_TATTOO_COLLARBONE] is String)
			{
				if (flags[kFLAGS.SOPHIE_TATTOO_COLLARBONE].indexOf("A tribal tattoo") >= 0) count++;
			}
			if (flags[kFLAGS.SOPHIE_TATTOO_SHOULDERS] is String)
			{
				if (flags[kFLAGS.SOPHIE_TATTOO_SHOULDERS].indexOf("A tribal tattoo") >= 0) count++;
			}
			if (flags[kFLAGS.SOPHIE_TATTOO_LOWERBACK] is String)
			{
				if (flags[kFLAGS.SOPHIE_TATTOO_LOWERBACK].indexOf("A tribal tattoo") >= 0) count++;
			}
			if (flags[kFLAGS.SOPHIE_TATTOO_BUTT] is String)
			{
				if (flags[kFLAGS.SOPHIE_TATTOO_BUTT].indexOf("A tribal tattoo") >= 0) count++;
			}
			return count;
		}

		public function sophieFullTribalTats():Boolean
		{
			if (numSophieTribalTats() == 4) return true;
			return false;
		}

		private function numVapulaTribalTats():int
		{
			var count:int = 0;
			if (flags[kFLAGS.VAPULA_TATTOO_COLLARBONE] is String)
			{
				if (flags[kFLAGS.VAPULA_TATTOO_COLLARBONE].indexOf("A tribal tattoo") >= 0) count++;
			}
			if (flags[kFLAGS.VAPULA_TATTOO_SHOULDERS] is String)
			{
				if (flags[kFLAGS.VAPULA_TATTOO_SHOULDERS].indexOf("A tribal tattoo") >= 0) count++;
			}
			if (flags[kFLAGS.VAPULA_TATTOO_LOWERBACK] is String)
			{
				if (flags[kFLAGS.VAPULA_TATTOO_LOWERBACK].indexOf("A tribal tattoo") >= 0) count++;
			}
			if (flags[kFLAGS.VAPULA_TATTOO_BUTT] is String)
			{
				if (flags[kFLAGS.VAPULA_TATTOO_BUTT].indexOf("A tribal tattoo") >= 0) count++;
			}
			return count;
		}

		public function vapulaFullTribalTats():Boolean
		{
			if (numVapulaTribalTats() == 4) return true;
			return false;
		}

		private function numKellyTribalTats():int
		{
			var count:int = 0;
			if (flags[kFLAGS.KELLY_TATTOO_COLLARBONE] is String)
			{
				if (flags[kFLAGS.KELLY_TATTOO_COLLARBONE].indexOf("A tribal tattoo") >= 0) count++;
			}
			if (flags[kFLAGS.KELLY_TATTOO_SHOULDERS] is String)
			{
				if (flags[kFLAGS.KELLY_TATTOO_SHOULDERS].indexOf("A tribal tattoo") >= 0) count++;
			}
			if (flags[kFLAGS.KELLY_TATTOO_LOWERBACK] is String)
			{
				if (flags[kFLAGS.KELLY_TATTOO_LOWERBACK].indexOf("A tribal tattoo") >= 0) count++;
			}
			if (flags[kFLAGS.KELLY_TATTOO_BUTT] is String)
			{
				if (flags[kFLAGS.KELLY_TATTOO_BUTT].indexOf("A tribal tattoo") >= 0) count++;
			}
			return count;
		}

		public function kellyFullTribalTats():Boolean
		{
			if (numKellyTribalTats() == 4) return true;
			return false;
		}

		private function numMilkyTribalTats():int
		{
			var count:int = 0;
			if (flags[kFLAGS.MILKY_TATTOO_COLLARBONE] is String)
			{
				if (flags[kFLAGS.MILKY_TATTOO_COLLARBONE].indexOf("A tribal tattoo") >= 0) count++;
			}
			if (flags[kFLAGS.MILKY_TATTOO_SHOULDERS] is String)
			{
				if (flags[kFLAGS.MILKY_TATTOO_SHOULDERS].indexOf("A tribal tattoo") >= 0) count++;
			}
			if (flags[kFLAGS.MILKY_TATTOO_LOWERBACK] is String)
			{
				if (flags[kFLAGS.MILKY_TATTOO_LOWERBACK].indexOf("A tribal tattoo") >= 0) count++;
			}
			if (flags[kFLAGS.MILKY_TATTOO_BUTT] is String)
			{
				if (flags[kFLAGS.MILKY_TATTOO_BUTT].indexOf("A tribal tattoo") >= 0) count++;
			}
			return count;
		}

		public function milkyFullTribalTats():Boolean
		{
			if (numMilkyTribalTats() == 4) return true;
			return false;
		}

		private function orgyRoomRouter():void
		{
			var doFunctor:Function = null;

			if (flags[kFLAGS.FARM_UPGRADES_ORGYROOM] == 0 && flags[kFLAGS.QUEUE_ORGYROOM_UPGRADE] == 0 && !whitneyDom())
			{
				doFunctor = wantOrgyRoom;
			}

			if (flags[kFLAGS.FARM_UPGRADES_ORGYROOM] == 1)
			{
				if (whitneyDom())
				{
					// Nothing... yet. Hopefully.
				}
				else
				{
					if (!player.isGoo() && !player.isTaur() && (player.hasCock() || player.hasVagina())) doFunctor = orgyRoomSubMassage;
				}
			}

			if (doFunctor != null) addButton(4, "Massage", doFunctor);
		}

		private function wantOrgyRoom():void
		{
			clearOutput();
			whitneySprite();

			outputText("“<i>[Master],</i>” says Whitney haltingly, after she’s knelt in front of you. “<i>May I make a suggestion?</i>” You shrug nonchalantly. “<i>Well... it’s just you often roll in here looking quite worn out, like. From fightin’ demons and dragons and such, whatever it is you do out there in the wastelands. It must be real important, cause you’re often banged up. To mention nothing of you needing to take care of... your chattel...</i>” she closes her eyes and sighs deeply. ");

			outputText("\n\nYou move your [legs] restlessly when the silence drags out a bit. “<i>Well, understand I ‘kin only talk as a farmer. But if I got a prime "+ player.mf("stud", "mare") +" who is constantly exerting themselves - a lot of the time it’s them who’s doing it not me, they’re just so big and, and dominant they don’t want to stop throwing themselves around even for a moment - they get stress injuries. Which just get worse the more they try and pretend they don’t exist. Now I ain’t saying you got something like that, but when I see you come here, all forceful and fretful, and then leave in such a rush - it breaks my heart a little. Cos’ I could help you, at least a bit. Don’t look after livestock your whole life without learning some about muscle groups and medicine. I could help you not be the [guy] who suddenly keels over in the middle of a fight screamin’ their hamstring’s gone.</i>”");

			outputText("\n\nYou look at her shrewdly. She doesn’t move her hands from her knees during all of this, hasn’t tried to touch you at all, demonstrated what she might be capable of. You ask what she’s really suggesting here.");

			outputText("\n\n“<i>I want to make it really good for you [master],</i>” she says fervently. “<i>So if you give me 2,200 gems...</i>”");

			outputText("\n\n“<i>2,200 gems?!</i>”");

			outputText("\n\n“<i>...I could convert my front room into a relaxation room for you,</i>” the dog woman goes on doggedly. “<i>It would have everything I need to properly take care of you. Like a hot tub. And I would pack it with all the sorts of things...</i>“ she sighs dreamily again “<i>all the sorts of things a big, strong "+ player.mf("lord", "lady") +" of the land might want. For when [he] is taking care of [his] servants. Like lots of ‘em. At the same time.</i>”");
	
			menu();
			
			var noT:String = "No";
			if (player.gems >= 2200) 
			{
				addButton(0, "Yes", getOrgyRoom);
			}
			else 
			{
				noT = "Too Much";
			}
			
			addButton(1, noT, noOrgyRoomPlz);
		}

		private function getOrgyRoom():void
		{
			clearOutput();
			whitneySprite();

			outputText("It’s a heavy investment, but her description of what she intends has definitely piqued your interest. Slowly you turn and, with a flick of the head, indicate the rock where she leaves the farm’s profit each week. Whitney breaks out onto a wide grin, her hands scrunching up on her skirt.");

			outputText("\n\n“<i>You won’t regret this [master], I promise!</i>”");

			player.gems -= 2200;
			showStats();
			
			flags[kFLAGS.QUEUE_ORGYROOM_UPGRADE] = 1;
			
			doNext(camp.returnToCampUseOneHour);
		}

		private function noOrgyRoomPlz():void
		{
			clearOutput();
			whitneySprite();
			
			outputText("You tell her it’s a fine idea, but it will have to wait for now.");

			outputText("\n\n“<i>I can wait,</i>” your taskmistress murmurs, the picture of serenity. “<i>I just don’t know if the knot in your triceps can. It would be a good investment [master], trust me.</i>”");

			doNext(dogeCorruptedMissionComplete);

			// Orgy Room added to Investments menu
		}

		private function orgyRoomTalk():void
		{
			clearOutput();
			whitneySprite();

			outputText("You can hear Whitney humming to herself happily as you approach her outside the milking shed, and when she sees you she rushes over to clutch at your arm excitedly.");

			outputText("\n\n“<i>It’s finished [master], c’mon, let me show you!</i>” You are lead by the hand to the front of her whiteboard farmstead, which carries the bald, awkward look of a facade recently rebuilt, and then spirited inside. She leads you to her front room and, grinning proudly from ear to ear, steps to one side to let you in.");

			outputText("\n\nGood gods, did she say this was going to be a relaxation room? One scan of it tells you immediately you’re more likely to be spending time straining yourself silly in here. She has painted the whole room a deep red, furnished it with a black massage slab and rambling cushion hillsides, and put the gas lights in here in dim, patterned shades. With the heavy purple curtains drawn the effect is sultry, to say the least. In one corner is the piece de resistance: a blocky, sunken hollow resplendent in brass and porcelain which can only be the promised hot tub. Your taskmistress all but drags you over to it with her hot little hand to demonstrate how it works.");

			outputText("\n\n“<i>My grandpa put together a suction pump to bring water up from the lake decades ago,</i>” she says. “<i>He used to say that one winter usin’ the outhouse with lumbago was enough. It was me who bought the magic heater though. Expensive, but so, so good after a long day on the farm.</i>” There’s already a small amount of water in the tub; with a twist of a knob more gushes out of a faucet. Steam idly curls its way upwards, as does the faint, unpleasant smell of sulfur. ");

			outputText("\n\n“<i>And... with a bit of expansion and adjustment to the generator...</i>” She twists another brass knob, and bubbles explode into life in the water below, making the surface seethe. You’re so enthralled with it that when something hisses nears your ear it makes you start. Whitney simpers apologetically, a glass bottle with a pump nozzle in her hand. Heavy, spicy fragrance pushes into your nose, masking the smell of rotten eggs. She really did think of everything.");

			outputText("\n\nTrying not to appear too overawed, you turn away to take in more of her not-even-pretending-to-be-a massage parlor. On a shelf near the hot tub she has stacked an irregular range of bottled oils and dildos. You might be wrong but it looks like a number of other things are stacked up there. Black, leather things. ");
			if (whitneyDom()) outputText("The sight sends a shuddering thrill down your spine. “<i>You didn’t think I’d forget those, did you [master]? We both know how important they are for properly relaxing you,</i>” Whitney murmurs, pushing her hot suppleness into your side. ");
			else outputText("You raise an eyebrow at these and Whitney giggles and blushes. “<i>Just in case you’re feeling adventurous, [master]. Or, um, want help.</i>”");
			outputText("You might be able to recognize those but you have no idea what the final object you can make out in the room’s dusky gloom is, stood against the far wall. It’s at least four foot tall and looks like an ornate stone urn, with a round bottom, a thin body, some sort of square contraption at the top, and a series of long tubes emerging from its stem. There’s a very small brazier next to it, with a few pebbles of charcoal huffing feebly at the bottom.");

			outputText("\n\n“<i>Saw this at the Bazaar whilst I was getting supplies and had to pick it up too.</i>” Whitney says happily. She produces a ball of brown pulp, sticks it into the square compartment, and then scatters a few tiny coals onto the thin metal mesh on top. “<i>You know about numb-root, don’t you [master]? They use it to make rock candy, I grow some of it with the peppers. Well, it’s got a much better effect if you take it like...</i>” She takes one of the flexible tubes and blows gently down it. There’s a faint bubbling sound at the bottom of the device. She proffers the hose to you.");

			outputText("\n\nCautiously you stick it into your mouth and take a slight pull. Smoke immediately shoots down your throat, but it isn’t at all harsh and carcinogenic as you were expecting; instead you get nothing but a mouthful of warm, fragrant air with a cloying herbal edge. You hand the pipe back and frown thoughtfully. You don’t feel any immediate effect. Except... you reach your hand out and experimentally touch Whitney’s jaw. Your fingers feel ever so slightly blunt, desensitized.");

			outputText("\n\n“<i>It’s got nowhere near the same power as the candy,</i>” the dog woman explains excitedly. “<i>It’ll wear off after a while, but if you take a few huffs, you’ll be able to last a lot longer in here than you might otherwise.</i>” Her breath comes faster, her corrupted mind overwhelmed with sprouting and rooting possibilities. ");
			if (!whitneyDom()) outputText("“<i>It’s exactly what a harem owner needs, [master] - with this you could take care of me and your other sluts all night, every night!</i>”");
			else outputText("“<i>I could do so many things to you [master], if you were on this stuff. And for so long. Just imagine it!</i>”");
			outputText(" You don’t feel woozy or spaced out at all - if anything, you feel slightly more aware and in control of your surroundings, it’s just that your skin feels like it’s coated with something vaguely fuzzy. ");

			outputText("\n\nYou marvel at it all. Whitney has combined her natural practicality with the filthy imagination you’ve implanted in her to give you something here that you never asked for but is something you now realize you’ve badly needed ever since you started collecting bitches: a very well-equipped harem chamber. The thought of putting it to thorough use sends blood sinking down to your groin. You grab her by the waist, delighted, and ask in a laughing tone what kind of dirty little girl is contracted to make a physio room and turns out a bordello?");

			outputText("\n\n“<i>You didn’t really think I was going to make a boring old clinic, did you?</i>” she chortles in return. Her hands snake down to your [butt], her eyes staring into yours, pulsing with lust. “<i>I know what you like, [master]. And what you want, I want.</i>” You kiss her hungrily, bending your mouth into hers and snaking your tongue around hers whilst your hands greedily move across each other’s bodies, know she’s imagining what you’ll do with each other in here just as vividly as you are. ");

			outputText("\n\nReluctantly you pull away before you get too involved, telling her as you head to the door you tell her she had better be prepared for when you come back later to give it a thorough test drive. She just bites her lip to this, and you feel her eyes burning into your back as you leave the farmhouse.");

			doNext(camp.returnToCampUseOneHour);
		}

		private function orgyRoomSubMassage():void
		{
			clearOutput();
			whitneySprite();

			outputText("You say in a grand, wearied tone that you’ve arrived from another hard day of bringing Mareth to its knees, and that you require the services of your pet masseuse. ");

			outputText("\n\n“<i>At once, [master]!</i>” Whitney’s eyes flick across your body once and then she is on her feet, running to the farmstead. You follow at a more leisured pace, enjoying the warm, sultry air of your farm, allowing her time to get herself prepared. By the time you pace through her front door and enter the orgy room, an even warmer breath of air is there to press into your face.");

			outputText("\n\nWhitney has got the hot tub bubbling away and has lit a number of candles around the massage slab, filling the plush, exotic space with a soft glow of heat and light. Rubbing her hands into a towel, she indicates the slab with a smile. You slowly clamber out of your clothes. After all the frenetic fighting and fucking you’ve been doing recently, just that action, baring your flesh in this secure, warm environment with your trusted slave on standby, feels very good indeed. You sigh as");
			if (player.isBiped()) outputText(" you clamber onto the heated slab, placing your chin on your hands on the cushion at the end");
			else if (player.isDrider()) outputText(" you tick-tack over and sink your spider underbelly onto the heated marble, before resting your human half down as well. Whitney was foresighted enough to make the slab quite long, and you complete the action in comfort");
			else if (player.isNaga()) outputText(" you slither over and slide onto the heated slab, placing your chin on your hands on the cushion at the end. You allow your long, heavy tail to pool onto the floor below");
			outputText(".");

			outputText("\n\nThere’s the sound of cloth falling onto the floor behind you, which you realize is Whitney taking her garments off when a moment later you feel her "+ ((whitneyDefurred()) ? "smooth" : "fluffy") +" thighs brush into your side, sitting herself down gently at the bottom of your back. You are not exactly sure how you’re going to relax with her moist pussy pushing into your rise of your [butt], but you give her the benefit of the doubt for now.");

			outputText("\n\n“<i>Ok [master],</i>” she sighs. The sound of oily palms being rubbed together above you. “<i>First, I need you to start breathin’ slow and deep. In time with me, if you can.</i>” You do as she says, filling your lungs to full capacity before gradually exhaling. You feel self-conscious at first but, as you listen for her own breath and fall in time to it the tactile rhythm of it deepens the serenity of the room, and as nothing but your own synchronized breathing fills the space for long moments, makes you feel connected with the dog girl knelt on you.");

			outputText("\n\nAs you breathe all the way out, her warm, greased hands press into the bottom of your ribcage, and slowly push upwards as you inhale, along either side of your spine. She digs her black nails in ever so slightly when she gets to your shoulders, before withdrawing to slide her fingers back downwards as you exhale, almost as if she were pressing the air gently out of your chest. The warm, oily pressure sweeps upwards again as you exhale... the way she moves with your breathing accentuates the sensation of being connected to her, moving together as if your body is an instrument that she is accompanying in perfect time. ");

			outputText("\n\nHer hands move up to your shoulders, pressing together and rotating across each of your shoulder-blades before returning soothingly to your back, very gently compressing the bumps of your spine as she curves down, sending little twinges of sensation nibbling through your core. Once she’s finished with each, she turns her searching, sliding fingers to your arms, going with the grain of your muscles, sliding up and down your biceps until they feel like kneaded dough. ");

			outputText("\n\nOnce your upper body has completely relaxed under her oily palms she becomes slightly more vigorous; at the end of each sensuous slide she digs her grip in just a bit, working at the knots and tension she finds buried in your flesh. And there are a lot. You don’t really realize whilst you’re caught up in the wild, impulsive lifestyle you have adopted since you arrived in Mareth, but your body carries the testament of a great deal of traveling, fighting and sleeping rough. You murmur appreciatively as Whitney worshipfully seeks out every strain and tension she can find in your torso and lightly wrings them out, as if you were a ball of string she is meticulously untangling.");

			outputText("\n\nYou are all but lost to the gliding balm of her hands, but it begins to woozily occur to you, as you respire in time with her, that her breathing isn’t quite level; it occasionally catches, or goes slightly faster. After another few moments of enjoying her touch you begin to notice when this happens: every time her fingers move over one of the many mild scars and lumps you carry from your time adventuring. You grin; it’s pleasing to imagine soothing over the proof of your many hard victories turns her on a bit. ");

			outputText("\n\nThe erotic tension builds as she finishes with your arms and slides her palms down to your [butt]. You don’t think this part of your anatomy needs much work but she goes about it anyway, sighing deeply as she moves her oiled hands in slow, wide circuits across the convex of your ");
			if (player.buttRating >= 6) outputText("soft");
			else outputText("brawny");
			outputText(" rear. After she’s finished making your butt feel red and smooth she dips a heated, greasy hand between your [hips] and");
			if (player.hasCock()) outputText(" grips your [cock]");
			else if (player.hasVagina()) outputText(" traces the entrance of your [vagina]");
			outputText(" for a moment... before sliding out with a throaty giggle, moving on down to your hips.");

			outputText("\n\nThe thicker flesh here takes longer to work loose, but your pet is patient, and eventually the lattice of muscles and meat in your thighs relax under the relentless smooth wash of the pads of her hands, giving up all the small aches and strains that are buried in there as she sends her fingers questing along their lines and valleys. Pausing to rub more oil into her hands and shuffle further down the slab, she moves on finally to your [legs].");

			// Biped: 
			if (player.isBiped())
			{
				outputText("\n\nShe spends a short time with your calves before encapsulating a [foot] in her oily hands.");
				if (!(player.lowerBody == LOWER_BODY_TYPE_HOOFED || player.lowerBody == LOWER_BODY_TYPE_NAGA || player.lowerBody == LOWER_BODY_TYPE_GOO || player.lowerBody == LOWER_BODY_TYPE_PONY))
				{
					outputText(" Your mouth opens as a twinge of pure pleasure veins up your [leg] as she massages the soft arch of the sole, making your");
					if (player.hasCock()) outputText(" cock thicken");
					if (player.hasCock() && player.hasVagina()) outputText(" and your");
					if (player.hasVagina()) outputText(" pussy moisten");
					outputText(".");

					outputText(" There must be a direct nerve link leading right from the bottom of your body up to your groin because my word, that really shouldn’t feel as good as it does. She swirls her thumbs across the rougher pads of your feet, dipping her warm fingers in and around the valleys of your");
					if (player.lowerBody == LOWER_BODY_TYPE_DEMONIC_CLAWS || player.lowerBody == LOWER_BODY_TYPE_LIZARD || player.lowerBody == LOWER_BODY_TYPE_HARPY || player.lowerBody == LOWER_BODY_TYPE_DRAGON) outputText(" claws");
					else outputText(" toes")
					outputText(", before returning deliberately to stroke at your arch, indulging that nervous link until you are deep in the unexpected bliss of it... before slowly releasing, leaving you to wallow delightfully in the knowledge that that same slow, delicious attention is about to be lavished on your other [foot].")
				}
				else
				{
					outputText("\n\nShe spends a short time with your strangely jointed calves before encapsulating a hoof in her oily hands. Your mouth opens as a twinge of pure pleasure veins up your leg as she massages the soft underbelly of your foot behind the unyielding keratin, making your");
					if (player.hasCock()) outputText(" cock thicken");
					if (player.hasCock() && player.hasVagina()) outputText(" and your");
					if (player.hasVagina()) outputText(" pussy moisten");
					outputText(".");
					outputText(" There must be a direct nerve link leading right from the bottom of your body up to your groin because my word, that really shouldn’t feel as good as it does. She swirls her thumbs across the joining of flesh and hoof, working out every bit of dirt and rock wedged in there before returning deliberately to stroke at the underbelly, indulging that nervous link until you are deep in the unexpected bliss of it, before slowly releasing, leaving you to wallow delightfully in the knowledge that that same slow, delicious attention is about to be lavished on your other hoof.");
				}
			}
			// Drider: 
			else if (player.isDrider())
			{
				outputText("\n\nYou didn’t really expect even the most devoted of servants to try massaging the vast and intricate octet of exoskeleton legs that is your mode of locomotion, but Whitney seems determined to try. She places her hands around one armored leg stem and slides her fingers into the main joint, working at it carefully but closely. With eight legs you find you can easily ignore the aches and stiffness you sometimes develop in one or the other - to have this kind of attention lavished on a usually ignored part of your anatomy feels very nice indeed. You lift the leg so she can work on the next joint down, asking lowly where on Mareth she learned to massage spiders.");

				outputText("\n\n“<i>It’s just from watching you, [master].</i>” she replies quietly, as pleasurable sensation inundates your second joint. “<i>When you sc- walk around, you can see where the stress lands and builds. All animals that move around a lot have the same needs, least when it comes to their hinges.</i>”");

				outputText("\n\n“<i>You watch me a lot, then?</i>” Silence from behind your undercarriage as the questing, rubbing oil moves onto your second leg. You grin. “<i>I imagine watching your [master] move around is almost a masochistic experience for you. Something so alien and unnerving now linked forever with pleasure and obedience. Is that how it is? You can’t stop staring at my beautiful, deadly form because it’s almost like a slutty punishment for you?</i>”");

				outputText("\n\n“<i>S-something like that,</i>” Whitney whispers, shakily. “<i>Your next leg [master], please.</i>” You smile serenely as you lift the next intricate point into her warm, waiting grasp. It takes almost as long again for her to rub oil into each of your legs as she spent on the rest of her body, but it’s well worth it.");
			}
			// Naga: 
			else if (player.isNaga())
			{
				outputText("\n\nYou didn’t really expect even the most devoted of servants to try massaging your long, reptilian half, but Whitney seems determined to try. She slides her hands all around the thick joining of your hips to your tubular bottom half and moves slowly down, simply glossing the scales of your top half in glistening pleasure. When she gets nearer the thin end though she begins to work more strenuously, working the thick, obdurate muscles beneath your hide loose, focusing particularly on the flexible groups on your underbelly whose flowing undulation you use to move. The patient massage sends lazy pleasure veining up your trunk, and with a delighted sigh you ask where on Mareth she learned to massage snakes.");

				outputText("\n\n“<i>It’s just from watching you, [master],</i>” she replies quietly, as relaxing sensation inundates your lower half. “<i>When you sl- move around, you can see where the stress lands and builds. You may not have any hinges down here, but that don’t mean you don’t have the same needs as animals that do.</i>”");

				outputText("\n\n“<i>You watch me a lot, then?</i>” Silence from behind you as the questing, rubbing oil moves down almost to your tip.");
				if (player.tongueType == TONGUE_SNAKE) outputText(" You grin, flicking your forked tongue out to smell her arousal.");
				outputText(" “<i>I imagine watching your [master] move around is almost a masochistic experience for you. Something so alien and unnerving now linked forever with pleasure and obedience. Is that how it is? You can’t stop staring at my beautiful, deadly form because it’s almost like a slutty punishment for you?</i>”");

				outputText("\n\n“<i>S-something like that,</i>” Whitney whispers, shakily. You smile serenely as a warm, oily hand grasps your reptilian tip, moving up and down in an almost masturbatory rhythm. It took almost as long again for her to rub oil into your coils as she spent on the rest of her body, but it was well worth it.");
			}

			outputText("\n\nWith one last glide of the hand from your [legs] up to your neck, Whitney steps off the slab. You roll over and gaze at her contentedly, reveling in the smooth glow she has worked into every part of your form. You not only feel incredibly relaxed and limber, but also profoundly connected to your body - you feel as if you can move with grace and oiled precision, and do exactly what you intend with the right inflection with every movement.");

			outputText("\n\n“<i>Was that good for you, [master]?</i>” the dog girl says, smiling the gratified smile of a job well done.");
			if (player.lust >= 33) outputText(" The hot tub bubbles quietly behind her and it is not just oil which is making your skin glow. This would be the moment to pursue a happy ending if you so wished.");
			else outputText(" You play with the idea of ‘rewarding’ her but... damn. She’s actually managed to relax you <i>too</i> much. You thank her regally, redress, and head out the door, enjoying the lightness of step and self-control which thrums through you.");

			menu();
			if (player.lust >= 33 && (player.hasCock() && player.cockThatFits(whitneyVagCapacity() * 1.33) != -1 || player.hasVagina()))
			{
				addButton(0, "Happy Ending", orgyRoomSubMassageHappyEnding);
				addButton(1, "Leave", camp.returnToCampUseOneHour);
			}
			else
			{
				addButton(0, "Next", camp.returnToCampUseOneHour);
			}
		}

		private function orgyRoomSubMassageHappyEnding():void
		{
			clearOutput();
			whitneySprite();

			outputText("You silently rise from the slab and put your arm around your masseuse’s tight body. It radiates heat into you as you send a hand sliding down the curve of her back to squeeze at her tight, supple butt.");

			outputText("\n\n“<i>M-[master].</i>” Whitney giggles, lowering the gaze of her red-flecked eyes and pushing her hands into your chest with faux-modesty. “<i>You’ll undo all the muscle therapy we’ve done if you go and get oil all over - oop!</i>”");
			if (player.tallness >= 67)
			{
				outputText(" With a single movement you swing her hot, compact weight over your shoulder. You growl into her ear that she’s still got plenty to do if she’s to finish her job of thoroughly relaxing every part of you.");

				outputText("\n\n“<i>Oh my!</i>” comes the laughing reply from behind your head. “<i>You’d better show me what part of you still needs a good massage, then...</i>” Carefully you carry her over to the hot tub, divesting her of her work-skirt as you do, and plonk her on the edge. She doesn’t need any help to rip her blouse off, her hungry eyes running up and down your oiled, naked form as you slowly step into the bubbling water.");
			}
			else
			{
				outputText(" You tighten your grip on her pert behind and growl that she’s still got plenty to do if she’s to finish her job of thoroughly relaxing every part of you.");

				outputText("\n\n“<i>Oh my!</i>” she laughs in return. “<i>You’d better show me what part of you still needs a massage then, big [boy]...</i>” You lead her over to the hot tub, divesting her of her work-skirt as you do, and plonk her on the edge. She doesn’t need any help to rip her blouse off, her hungry eyes running up and down your oiled, naked form as you slowly step into the bubbling water.");
			}

			outputText("\n\nYou sigh as you sink further and further into the tub, the hot water and air wrapping itself around your limbs and groin, a virtual second massage for your ridiculously pampered form. If you could feel more at peace with the world, you’d be horizontal. That said... you sit and watch through heavily lidded eyes the deeply enjoyable sight of Whitney following suit on the opposite side, sinking her slim, brown body into the water, gasping slightly as her tidy, pretty pussy disappears beneath the roiling surface. Even in the heavy humidity the nipples on her prim, perky breasts remain rock hard, pointing at you accusingly, and blood pumps insistently to your groin, leaving you feeling light-headed in the heat.");

			if (player.hasCock() && player.cockThatFits(whitneyVagCapacity() * 1.33) != -1 && player.hasVagina())
			{
				outputText(" You take a long moment to consider which of your sexes you will satisfy yourself with.");
			}

			//[Male][Female]/[Next]
			menu();
			if (player.cockThatFits(whitneyVagCapacity() * 1.33) != -1) addButton(0, "Male", subHappyEndingMale);
			if (player.hasVagina()) addButton(1, "Female", subHappyEndingFemale);
		}

		private function subHappyEndingMale():void
		{
			clearOutput();
			var cockThatFits:int = player.cockThatFits(whitneyVagCapacity() * 1.33) + 1;
			var hasBiggerCock:Boolean = false;

			if (player.cockArea(cockThatFits -1) != player.biggestCockArea()) hasBiggerCock = true;

			outputText("You drift across and envelope her in your body, your [chest] pushing into the soft suppleness of her small breasts. Feeling your urge but not overcome by it in your relaxed state you instead take time to enjoy the give and take of your slave’s body, her flat stomach planing over yours, the feeling of her hard nipples against your chest, her long, "+ ((whitneyDefurred()) ? "smooth" : "downy") +" legs tangling with yours in the slow motion of the water.  Her breath catches in her chest, panting and trembling there as you push your hand between her thighs, sinking your fingers into her tight, welcoming hole. ");

			outputText("\n\nYou slide your [cock " + cockThatFits + "] up and down her abdomen and then between her lips, hardening it as you tease at her wetness with it.");
			if (hasBiggerCock) outputText(" Your [cock biggest], so used to getting preferential treatment, bulges in agitation and the lizard impulse to fuck her wide and silly with it saturates the back of your mind; but you know it makes much more sense to keep her nice and tight rather than turn her into another blown out whore in a single bull-in-a-china-shop fuckfest. And anyway... as you test her with your [cock " + cockThatFits + "], you slide your [cock biggest] up her abdomen, enjoying the smoothness of her flesh on one side and the sloshing hot foam on the other. Whitney hums with pleasure and clasps the thick cock pointing towards her breasts in her hands, slowly rubbing it up and down as you prepare to penetrate her.}");

			// First time:
			if (flags[kFLAGS.MASSAGE_HAPPY_ENDINGS] == 0)
			{
				outputText("\n\n“<i>Been a while, I take it?</i>” you say softly, as you line your [cock " + cockThatFits +"] up to her pink slit, sighing at its soft, delicious resistance.");

				outputText("\n\n“<i>Seems like- like forever, [master]. I don’t know why I- ooh...</i>” the thought is lost as you sink into her, pushing deep into her depths, exhaling at how her moist walls push into your prick from every direction. You go slow, stopping and withdrawing almost all the way out when her breath catches in her throat, before gently spearing your way into that delicious tightness again, each time dipping a little further in. Her body remembers the rhythm of it quickly - no doubt aided by the corruption you’ve mired her in - and in no time her hips are gripping into yours, willing the return strokes of your [cock " + cockThatFits + "].");
			}
			// Subsequent: 
			else
			{
				outputText("\n\nShe gasps as you push open her lips and spear into her depths with one thrust. Her pussy is used to your [cock " + cockThatFits + "] now, still deliciously tight and clenching but welcoming as well, perfectly designed to holster and squeeze every inch of your modestly sized prick with wet pleasure. Within a few moments your hips are touching hers, taking your cock down to the hilt. Her thighs tighten around your frame and you begin to lose yourself in the soft, slow rhythm.");
			}

			outputText("\n\n“<i>Breathe in time with me if you can,</i>” you murmur with a mocking edge, looking into her eyes as you push gently into her. “<i>If you can’t manage it - I might have to go a bit faster.</i>” It’s meant as a tease but as you slowly rock into her, pushing her back into the side of the hot tub with the languorous washes of your body’s motion, she determinedly falls into time with your breathing, once again filling the sultry, warm space of the room with the sensual, intimate sound of your shared respiration. ");

			outputText("\n\nThe sensation of sliding in and out of her whilst buried deep in the heat and froth of the tub is exquisite, however her thorough massage has left you feeling very much in control of your body, in control of everything - even Whitney, her heavy breathes matching your own exactly, her supple frame wrapped and clenched around yours. You feel like you could stay here, lavishing in the steam and the tightness of your slave for a great deal longer...");

			outputText("\n\nWhitney’s breath catches, her hand gripping harder");
			if (hasBiggerCock) outputText(" [cock biggest]");
			else if (player.isBiped()) outputText(" against your [hips]");
			else outputText(" around your back");
			outputText(" momentarily. You grin, and begin to pump into her a little harder, using the full breadth of movement afforded to you by your oiled, [hips] to do so. It has the effect you anticipated. After a few more moments gamely keeping time with your own heavy exhalations the dog girl you’re buried into gasps, unable to contain herself. You winch her legs up by the knees and go at her faster again, still using the full movement of your pelvis to withdraw and sink every inch of your [cock " + cockThatFits + "], pushing into her pink tightness vigorously enough for the water around to splash briskly, buried into her even deeper. ");

			outputText("\n\nWhitney does her best to keep her breath steady as you bump and press her back into the side of the tub, but as you use the extra leverage afforded to you by holding her thighs up to push into her walls at a new angle she can’t contain herself and bites hard into your shoulder to prevent herself crying out. You grin, enjoying the contrast between the sharpness of her love bite and the soft warmth which inundates every other part of your body. You have to give her credit for quick thinking, but it’s not going to stop you picking up the pace again...");

			outputText("\n\nThe breathing tease quickly cascades to the point where she stops trying, and she moans, yelps and squeals as you fuck her with heavy, quick strokes, going as fast as you can in the heavy humidity, her self-control gone and insensate to everything but your dick filling every inch of her tight pussy. You deeply enjoyed getting her into this state, but you’d be lying if you felt the same level of discipline you did to begin with - now you push into her just as eagerly, glorying in her every shrill cry, your nerve endings buzzing as the pressure builds in your");
			if (player.balls > 0) outputText(" [balls].");
			else outputText(" groin.");

			outputText("\n\nYou hold her tight and join in her groans as you holster every inch of your [cock " + cockThatFits + "] into her and unload, clenching and pulsing your seed into her. If she didn’t manage it before the dog girl certainly does now; her back arches and her eyes roll as you fill her womb full of your hot spunk, her pussy squeezing around you almost unbearably close, almost sucking the cum out of you.");
			if (player.cumQ() >= 1500) outputText(" Her small capacity is almost immediately filled and jizz spurts out with every rich thrust you make, polluting the water around you with your massive load.");
			if (hasBiggerCock) outputText(" Whitney has stroked and tantalized your [cock biggest] with her hot hands and smooth belly intermittently this whole time, and as your orgasm builds and overwhelms you she gets her just reward for it; you jet cum from [eachCock], pasting first her face and then her tight breasts with your thick cream as you ride her hard.");

			happyEndingMerge();

		}

		private function subHappyEndingFemale():void
		{
			clearOutput();
			whitneySprite();

			outputText("You drift across and envelope her in your body, your [chest] pushing into the soft suppleness of her small breasts. Feeling your urge but not overcome by it in your relaxed state you instead take time to enjoy the give and take of your slave’s body, her flat stomach planing over yours, the feeling of her hard nipples against your chest, her long, "+ ((whitneyDefurred()) ? "smooth" : "downy") +" legs tangling with yours in the slow motion of the water.  Her breath catches in her chest, panting and trembling there as you push your hand between her thighs, brushing through the neat thatch of her public hair to sink your fingers into her tight, welcoming hole.  You winch one of your [legs] over hers, pushing your [vagina] against hers, sighing as your lips touch and rub over each other. ");

			if (player.hasCock()) outputText("\n\nYour [cock biggest], so used to getting the premium treatment, bulges in agitation and the male impulse to fuck her wide and silly with it saturates the back of your mind - but in this steamy, leisured moment you are much more interested in indulging your female side. And anyway... as you push your [vagina] into her, you slide your [cock biggest] up her abdomen, enjoying the smoothness of her flesh on one side and the sloshing hot foam on the other. Whitney hums with pleasure and clasps the thick cock pointing towards her breasts in her hands, slowly rubbing it up and down as you prepare to scissor her.");

			// First time:
			if (flags[kFLAGS.MASSAGE_HAPPY_ENDINGS] == 0)
			{
				outputText("\n\n“<i>Been a while, I take it?</i>” you say softly, sighing at the soft, delicious resistance of her puffy vulva against your [clit].");

				outputText("\n\n“<i>Never - never with another woman, mistress. I don’t know why I - ooh...</i>” the thought is lost as you clench into her, melding your pussies together emphatically. At first she is frozen, apparently without a clue as to what to do or how to react to the pressure of your mound against hers, flexing into her lips and inner pink pleasantly. You go as slowly and sensually as you can, sliding your grip over her supple, wet flesh, kissing and licking her face and neck possessively, murmuring encouragement when she sighs blissfully to a movement of your hand or hip. You unlock her slowly but surely, and it isn’t long before she is flexing back into you eagerly, giving as well as taking your sex.");
			}
			// Subsequent: 
			else
			{
				outputText("\n\nShe gasps as you clench into her, locking your bodies together forcefully. She is used to your [vagina] now and gladly pushes her slim frame back into yours, your pussies rubbing over and around each other, teasing first your clit and then hers until they are both bulging needily.  Your sex wettens and unfurls as you scissor against her deeply. Her thighs tighten around your own and you begin to lose yourself in the soft, slow, sapphic rhythm.");
			}

			outputText("\n\n“<i>Breathe in time with me if you can,</i>” you murmur with a mocking edge, looking into her eyes as you push gently into her. “<i>If you can’t manage it - I might have to go a bit faster.</i>” It’s meant as a tease but as you slowly rock against her, pushing her back into the side of the hot tub with the languorous washes of your body’s motion, she determinedly falls into time with your breathing, once again filling the sultry, warm space of the room with the intimate sound of your shared respiration. ");

			outputText("\n\nThe sensation of sliding against her whilst buried deep in the heat and froth of the tub is exquisite, however her thorough massage has left you feeling very much in control of your body, in control of everything, even Whitney.  Her heavy breaths match your own exactly, her supple frame wrapped and clenched around yours. You feel like you could stay here, lavishing in the steam and the tightness of your slave for a great deal longer....");

			outputText("\n\nWhitney’s breath catches, her hand gripping harder");
			if (player.hasCock()) outputText(" [cock biggest]");
			else if (player.isBiped()) outputText(" against your [hips]");
			else outputText(" around your back");
			outputText(" momentarily. You grin, and begin to pump into her a little harder, using the full breadth of moment afforded to you by your [hips] to do so. It has the effect you’d expect. After a few more moments gamely keeping time with your own heavy exhalations the dog girl you’re tangled with bursts into gasps, unable to contain herself. In response you lower your head and suck her hard nipples, engulfing them with your mouth before chewing first one and then the other gently, pushing your [clit] against her pink tightness vigorously enough for the water around to splash briskly as you do. ");

			outputText("\n\nWhitney does her best to keep her breath steady as you bump and press her back into the side of the tub, but as you pull a tan nipple outwards with your lips she can’t contain herself and bites hard into your shoulder to prevent herself crying out. You grin, enjoying the contrast between the sharpness of her love bite and the soft warmth which inundates every other part of your body. You have to give her credit for quick thinking, but it’s not going to stop you picking up the pace again...");

			outputText("\n\nThe breathing tease quickly cascades to the point where she stops trying, and she moans, yelps and squeals as you rut against her with heavy, quick strokes.  You’re going as fast as you can in the smothering humidity, whilst her self-control is long gone; she’s insensate to everything but your pussies and clits grinding into each other. You deeply enjoyed getting her into this state, but you’d be lying if you felt the same level of discipline you did to begin with - now you grind against her just as eagerly, glorying in her every shrill cry, your nerve endings buzzing as heat builds in your crotch. ");

			outputText("\n\nYou hold her tight and join in her groans as you wrap as much of yourself around her as you can, your [chest] pushing into her sorely teased nipples as your [vagina] quivers and then clenches. If she didn’t manage it before the dog girl certainly does now; her back arches and her eyes roll as her tight cunt squeezes in sympathetic orgasm with you.");
			if (player.wetness() >= 5) outputText(" Your pussy spurts excitement gleefully with each thrust, utterly drowning her own in your juices, polluting the water around you with your musk.");
			if (player.hasCock()) outputText(" Whitney has stroked and tantalized your [cock biggest] with her hot hands and smooth belly intermittently this whole time, and as your orgasm builds and overwhelms you she gets her just reward for it; you jet cum from [eachCock], pasting first her face and then her tight breasts with your thick cream as you ride her hard.");

			happyEndingMerge();
		}

		private function happyEndingMerge():void
		{
			outputText("\n\nOnce you have thrashed the last of it out you disentangle yourself and sink off down to one side, gasping for air, your heart thudding. It certainly pays not to get too vigorous too fast in the sweltering heat of this thing - as it is sweat beads your forehead and your vision swims for a few seconds as you stare up at the ceiling, waiting for the pulse beating in your brow to calm. In a beatific haze you listen to Whitney’s own breathing return to normal, feel her slide her arms back around your frame beneath the foam.");

			outputText("\n\n“<i>Are you fully relaxed now?</i>” she asks, in a low, teasing voice. “<i>Or am I going to have to massage you all over again?</i>” ");

			outputText("\n\nGods... how wonderful it would be to stay in here forever, alternating between getting oiled and fucking her silly. However, you know these sessions wouldn’t feel half as good if you didn’t spend the rest of your time willfully exerting yourself elsewhere. You pull her into you, give her a nice scratch behind the ear and tell her that her [master] feels thoroughly unwound, and that she’s a good girl. Thwip thwip thwip thwip goes her tail in the water.");

			outputText("\n\nAfter a short time enjoying the heat and closeness of your slave’s body a bit more you get up, towel down, and leave, enjoying the cleanliness, lightness of step and self-control which thrums through you as you head out the front door.");

			// [Whether happy ending taken or not PC gets +10% exp and +10% crit chance for 24 hours after massage]
			flags[kFLAGS.MASSAGE_HAPPY_ENDINGS]++;
			player.orgasm();
			dynStats("sen-", 1);
			doNext(camp.returnToCampUseOneHour);
		}

	}

}