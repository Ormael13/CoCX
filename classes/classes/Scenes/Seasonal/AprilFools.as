package classes.Scenes.Seasonal {
	
	import classes.*;
	import classes.GlobalFlags.*;

	public class AprilFools extends BaseContent
	{
		//for all april fools gags
		public function isItAprilFools():Boolean {
			return (date.date == 1 && date.month == 3);
		}

		// Encounter Chance 1 out of 40 and only if you're a centaur
		public function poniesYN():Boolean {
			if (player.lowerBody == LOWER_BODY_TYPE_HOOFED && player.isTaur() && date.date == 1 && date.month == 3 && flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00118] == 0) {
				clearOutput();
				outputText("While walking around the lake, you hear the sound of feminine voices laughing and talking, accompanied by the distinctive clip-clop of hooves. Stepping lightly through the overgrowth you stumble across a group of small brightly colored ponies. The strange part about them isn't so much their size, but rather the shape of their bodies.  They almost look cartoonish in nature, a few even sport fluttery, feathery looking wings.\n\n", false);
				//(option: Approach? Leave them Be?)
				simpleChoices("Approach",approachPonies,"",null,"",null,"",null,"Leave",leavePonies);
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00118]++;
				return true;
			}
			return false;
		}

		//----------Next Page-----------
		public function leavePonies():void {
			clearOutput();
			outputText("Deciding it must be some demonic trick, you decide to retreat from the scene before they notice your presence.", false);
			doNext(camp.returnToCampUseOneHour);
		}
		public function approachPonies():void {
			clearOutput();
			outputText("You slowly begin your approach, though you are spotted almost immediately by the pink one.\n\n", false);

			outputText("You aren't two steps out of the forest before it seems she, and it HAS to be a she, seemingly teleports in front of you with an expression of rapture and joy pasted on her face.  You almost instinctively pull out your " + player.weaponName + ", startled by the appearance of the pink one in your face.  Immediately she starts asking a myriad of questions, speaking at a speed which makes it impossible to understand a word.  Almost as stunning is the fact that she is speaking in a human tongue. Before you have the time to gather yourself up and figure out what the pink one is saying, or even what is going on, the rest of her group have managed to catch up to her, and begin calming her down.\n\n", false);

			outputText("The purple one turns to you looking apologetic and a bit exasperated, \"<i>Sorry for our friend startling you. She gets excited <b>really</b> easily.</i>\"\n\n", false);
			
			outputText("You respond that it's no problem, but she should be more careful approaching strangers", false);
			if (player.weaponName != "fists") outputText(", especially armed strangers", false);
			outputText(".\n\n", false);
			
			outputText("The blue one looks at you in a puzzled manner while hovering above the ground, \"<i>Actually, you are the first person we have seen who isn't a pony.</i>\"\n\n", false);

			outputText("To be fair, you tell them, you haven't seen any one who IS a pony.  The pink one, now slightly calmer, interjects herself into the conversation \"<i>Ponies, not ponies, whatever!  We have a new friend, and I say PARTY!!!</i>\"\n\n", false);

			outputText("These little horses are definitely a rambunctious bunch, especially the white one, who, from the moment she spotted you, hasn't stop complaining about your awful sense of fashion. The only exception seems to be that yellow one hiding behind a screen of squirrels, birds and what you think are three generations of rabbits.\n\n", false);

			outputText("What should you do? You could party with the horses; after all, you haven't had a reason to party since getting here. You can politely decline for now or leave these oddly colored and slightly disturbing creatures for the more familiar sight of demons.\n\n", false);  

			outputText("Whichever you choose, something tells you that you won't see these ponies again.", false);
			//Option one: Leave Politely
			//Option Two: Too creepy...
			//Option three: Yay, party?
			simpleChoices("Too creepy",derpCreepy,"Yay Party!",derpyParty,"",null,"",null,"Leave",derpPolitely);
		}

		public function derpPolitely():void {
			clearOutput();
			outputText("You hold out your arms and stop the ponies.  Once you have their attention you let them know you have something important you need to do for now, but will come back soon.  With a wave you turn and walk back into the trees to a chorus of disappointed \"<i>ahhhs</i>\", mostly from the pink one.", false);
			doNext(camp.returnToCampUseOneHour);
		}
			
		public function derpCreepy():void {
			clearOutput();
			outputText("Cocks, horns and slavering vaginas is one thing, but this is almost too much cute to process.  You determine to leave this grove and never EVER come back again.  Still disturbed by the mental images running through your head, as you make your way back to camp, you callously slaughter an imp. Yeah, that feels better.\n\n(+10 XP!  +5 Gems!)", false);
			player.XP += 10;
			player.gems += 5;
			doNext(camp.returnToCampUseOneHour);
		}
		public function derpyParty():void {
			clearOutput();
			outputText("You watch in amazement as the flying horses string up banners, while the purple one sets a table with snacks and drinks using glowy powers coming from the horn on her head.  Whilst they set up, you discuss your home village with the orange one who compares it with working on an apple farm and you try to ignore  the white one as she primps and fusses around you, obviously unwilling to let you stay in, to quote her own words, \"<i>Hideous attire, lacking any grace or style.</i>\"\n\n", false);
			
			outputText("Time passed, and the rest of the day was a blur, mostly caused by, you assume, the large quantity of Pony Punch you drank.  As you shakily attempt to get up, snippets of the evening's events flash through your mind: a funny joke told by the pink one; the yellow one coming out of hiding to orchestrate an impromptu concerto sung by a choir of songbirds; losing a race to the blue one, (flying is definitely cheating): a derpy looking grey one who was knocking over everything in a two meter radius around her.  Your mind slowly returns to the present and as it does you take a look at yourself.  A first glance at your attire shows the magical 'improvements' the white one made are already fading away, crumbling into a cloud of pink dust that blows away, leaving you back in your " + player.armorName + ".  Watching your clothes change was rather distracting, but now that you are up, and ooh what a headache THAT caused, you see your clothes weren't the only thing that changed!!\n\n", false); 

			outputText("Your strong lower body has shrunk, the firm musculature replaced by an oddly cartoonish looking form.  In fact, from the waist down you look just like one of the ponies!  Everything looks to still be in the same general place, and a quick test of your new lower body proves it still functions somewhat the same. The new shape of your hooves takes a little while to get used to, but other than that you get used to your new lower body almost with no effort\n\n(<i>*Note:You should really check the character viewer</i>)", false);
			player.lowerBody = LOWER_BODY_TYPE_PONY;
			player.legCount = 4;
			doNext(camp.returnToCampUseEightHours);
		}

		//DLC April Fools
		public function DLCPrompt(dlcName:String, dlcPitch:String, dlcPrice:String, nextFunc:Function = null):void {
			clearOutput();
			outputText(dlcPitch);
			outputText("\n\nYou can purchase " + dlcName + " for " + dlcPrice + ". Would you like to purchase it now?");
			menu();
			addButton(0, "Yes", buyDLCPrompt, dlcName, dlcPrice, nextFunc);
			if (nextFunc != null) addButton(1, "No", nextFunc);
			else addButton(1, "No", playerMenu);
		}
		private function buyDLCPrompt(dlcName:String, dlcPrice:String, nextFunc:Function = null):void {
			clearOutput();
			outputText("<b>Item:</b> " + dlcName + "\n");
			outputText("<b>Price:</b> " + dlcPrice + "\n");
			outputText("Please select a purchase method.");
			menu();
			addButton(0, "Credit/Debit", proceedToCheckout, "Credit/Debit Card", nextFunc);
			addButton(1, "PayPal", proceedToCheckout, "Paypal", nextFunc);
			addButton(2, "Interac", proceedToCheckout, "Interac", nextFunc);
			addButton(3, "Gems", proceedToCheckout, "Gems", nextFunc);
			addButton(14, "Cancel", nextFunc);
		}
		private function proceedToCheckout(method:String, nextFunc:Function = null):void {
			clearOutput();
			if (method != "Gems") {
				outputText("You will be taken to an external website to complete your checkout. Proceed?");
			}
			else {
				outputText("Fortunately, you can choose to pay with gems at a rate of $1 per 1000 gems! Proceed?");
			}
			doYesNo(reallyCheckout, nextFunc);
		}
		//You just got TROLLED!
		private function reallyCheckout():void {
			clearOutput();
			outputText(images.showImage("monster-troll"));
			outputText("APRIL FOOLS! The game will ALWAYS be entirely free to play. :)");
			flags[kFLAGS.DLC_APRIL_FOOLS] = 1;
			doNext(playerMenu);
		}
		
		public function pay2WinSelection():void {
			clearOutput();
			displayHeader("Premium Shop");
			outputText("Don't feel like trying to earn these items? Need more gems? Why not purchase them yourself?");
			outputText("\n\n<b><u>Gems</u></b>");
			outputText("\n1000 Gems - $0.99");
			outputText("\n2500 Gems - $1.99");
			outputText("\n5000 Gems - $2.99");
			outputText("\n10,000 Gems - $4.99");
			outputText("\n25,000 Gems - $7.99");
			outputText("\n\n<b><u>Special Items</u></b>");
			outputText("\nLethicite Armour - $2.99");
			outputText("\nDivine Bark Armour - $0.99");
			outputText("\nLethicite Staff - $0.99");
			outputText("\nLethice's Whip - $0.99");
			outputText("\n5x Lethicite - $0.99");
			outputText("\n5x Premium Mead - $1.99");
			outputText("\n5x Peppermint White - $2.99");
			menu();
			addButton(0, "1000 Gems", buyDLCPrompt, "1000 Gems", "$0.99", pay2WinSelection, "Top up on gems to make sure you can afford what you want!");
			addButton(1, "2500 Gems", buyDLCPrompt, "2500 Gems", "$1.99", pay2WinSelection, "Top up on gems to make sure you can afford what you want!");
			addButton(2, "5000 Gems", buyDLCPrompt, "5000 Gems", "$2.99", pay2WinSelection, "Top up on gems to make sure you can afford what you want!");
			addButton(3, "10,000 Gems", buyDLCPrompt, "10,000 Gems", "$4.99", pay2WinSelection, "Top up on gems to make sure you can afford what you want!");
			addButton(4, "25,000 Gems", buyDLCPrompt, "25,000 Gems", "$7.99", pay2WinSelection, "Top up on gems to make sure you can afford what you want!");
			addButton(5, armors.LTHCARM.shortName, buyDLCPrompt, armors.LTHCARM.longName, "$2.99", pay2WinSelection);
			addButton(6, armors.DBARMOR.shortName, buyDLCPrompt, armors.DBARMOR.longName, "$0.99", pay2WinSelection);
			addButton(7, weapons.L_STAFF.shortName, buyDLCPrompt, weapons.L_STAFF.longName, "$0.99", pay2WinSelection);
			addButton(8, weapons.L_WHIP.shortName, buyDLCPrompt, weapons.L_WHIP.longName, "$0.99", pay2WinSelection);
			addButton(9, useables.LETHITE.shortName, buyDLCPrompt, "5x " + useables.LETHITE.longName, "$0.99", pay2WinSelection);
			addButton(10, consumables.PROMEAD.shortName, buyDLCPrompt, "5x " + consumables.PROMEAD.longName, "$1.99", pay2WinSelection);
			addButton(11, consumables.PEPPWHT.shortName, buyDLCPrompt, "5x " + consumables.PEPPWHT.longName, "$2.99", pay2WinSelection);
			addButton(14, "Back", playerMenu);
		}
	}
}

/*Notes:
---------------------------------------------------------------------------------------------------------------------------------------------
1. talk a little to the ponies, aka get to know them a little and their personalities
2. futtershy(yellow one with pink mane) hides in the bushes and you comment of the number of small animals surrounding her
3. rarity(white one with purple mane) comments about your awful dress attire
4.applejack(orange one with sandy blonde mane) asks what are you doing in these parts?
the pink one(pinkie pie) offer to throw a party in honor of our new friend
IF you accept you wake up at you camp groaning from a headache, you definitely drank too much Pony Punch, and all you can remember is bits and pieces of the party, when you inspect yourself you see that your centaur lowerbody changed and looks very similar to the body of the ponies you encountered. You explain that the change may have been caused by the food you ate at the party. You also lose half a foot of height(optional, may not be implemented).
If you don't accept you never encounter them again
the way i explain this one time event is that you accidently stumbled across this place, which is protected by magic. after that you never encounter them again.
*/
