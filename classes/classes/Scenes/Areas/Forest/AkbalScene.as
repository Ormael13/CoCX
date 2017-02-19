/**
 * Created by aimozg on 01.01.14.
 */
package classes.Scenes.Areas.Forest
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Items.Armors.LustyMaidensArmor;

	public class AkbalScene extends BaseContent
	{
		public function AkbalScene()
		{
		}

		public function akbalDefeated(hpVictory:Boolean):void{
			flags[kFLAGS.AKBAL_SUBMISSION_STATE] = 1;
			if (hpVictory) //[General Victory]
			{
				/*if (rand(10) == 0) {
				   outputText("Akbal falls to the ground, but as you raise your " + player.weaponName + " to deliver the final blow, a harsh ripping sound rends the air.  A dark form covered in burning violet light flies out of the jaguar's body; the demon has fled, leaving a corpse behind.  You have no doubt that the demon can gain another body, but it's best to take the old one with you to make sure it doesn't regain its form easily.", false);
				   //9999 change monster name to let itemloot know what item to drop.
				   short = "Akbitch";
				   //[Get 'Jaguar Pelt']
				 }*/
				//[Common chance of dropping 'Incubus Draft', 'Smart Tea' or 'Pipe']
				outputText("Akbal falls to the ground in a beaten bloody heap.", true);
			} else //[Victory via Lust]
			{
				outputText("Akbal falls to the ground, unable to go on. Yet a growl still rumbles in his chest, and you quickly recognize the submissive gesture when he bows his head, his cat belly hugging the ground.  His body begins shifting, and soon he has a vaguely humanoid form. You assume this is the form he uses for sex, as his lust is out of control.\n\n", true);
				if (player.lust >= 33 && player.gender > 0 && flags[kFLAGS.SFW_MODE] <= 0)
				{
					outputText("You walk around Akbal's beaten and lust crazed form with a smile on your face. The demon's growl continues as he awaits your judgment.", false);
					var vagoo:Function =null;
					var vagooLick:Function =null;
					var buttFuck:Function =null;
					var bikiniTits:Function =null;
					if (player.hasVagina())
					{
						vagoo = girlsRapeAkbal;
						vagooLick = rapeAkbalForcedFemaleOral;
					}
					if (player.hasVagina() && player.biggestTitSize() >= 4 && player.armor is LustyMaidensArmor)
						bikiniTits = (player.armor as LustyMaidensArmor).lustyMaidenPaizuri;
					if (player.hasCock())
						buttFuck = rapeAkbal;
					outputText("\n\nDo you rape him?", false);
					//Rape / Don't Rape
					kGAMECLASS.simpleChoices("Butt-fuck", buttFuck, "Take Vaginally", vagoo, "Force Lick", vagooLick, "B.Titfuck", bikiniTits, "Leave", combat.cleanupAfterCombat);
					return;
				}
			}
			combat.cleanupAfterCombat();
		}

		public function akbalWon(hpVictory:Boolean,pcCameWorms:Boolean):void{
			flags[kFLAGS.AKBAL_SUBMISSION_STATE] = -1;
			flags[kFLAGS.AKBAL_BITCH_Q] = 0;
			clearOutput();
			if (pcCameWorms){
				outputText("\n\nYour foe doesn't seem disgusted enough to leave...");
				doNext(loseToAckballllllz);
			} else if (hpVictory) {
				outputText("The intense pain causes you to black out. The last thing you see is Akbal standing over you on his two hind legs, his massive cock ominously swinging between them as he watches you lose consciousness.\n\n", false);
			} else {
				loseToAckballllllz();
			}
		}

		//Victory/Defeat Scenes
		private function rapeAkbalForcedFemaleOral():void
		{
			flags[kFLAGS.AKBAL_BITCH_Q]++;
			clearOutput();
			//Naga RAPPUUUUUU
			if (player.isNaga())
			{
				outputText(images.showImage("akbal-deepwoods-naga-forcedfemaleoral"));
				outputText("You slither around the demon cat's form, wrapping him up until a scared whimper rises from his chest.  You continue to tighten your coils around Akbal until he's gasping for breath.  You ask him if he's going to be a good little demon for you.  He nods.\n\n", false);
				outputText("As you uncoil you can't help but bump into the slimy leaking faucet Akbal calls his dick.  At your command he raises his hind quarters, allowing you a perfect view of his low hanging balls and sheath.  You reach around his fuzzy orbs and pull his swollen cock back until the jaguar demon's 15 inch pecker is visible.\n\n", false);

				outputText("Your eyes widen as you see several wicked looking barbs around his pre-pumping slit.  Instead of trying to deal with this massive phallus that looks like it was made to punish sinners you slither around to the front of the creature.\n\n", false);

				outputText("Your scent causes the growl ripping out of Akbal's chest to quiver.  You lay before him, reaching up to smash his furry lips into your " + player.vaginaDescript(0) + ".  The demon, unable to escape his debilitating arousal, begins to lap at your " + player.vaginaDescript(0) + ".  He shoves his face against your " + player.vaginaDescript(0) + " twisting his lips and drilling his tongue into you, mercilessly attacking your " + player.clitDescript() + " as you scream, howl and cringe in ecstasy.\n\n", false);

				outputText("He begins to lift up, probably to get into position above you and sake his lust, but you force his face back down into your " + player.vaginaDescript(0) + ".  After dropping a line about how he has to make your cum or get his head ripped off Akbal whines, obviously distressed at not being able to slip his aching member into your " + player.vaginaDescript(0) + ".\n\n", false);

				outputText("With a sadistic laugh you ride out your orgasm until you're reduced to a shuddering heap on the floor.  After you've recovered you gather your " + player.armorName + ", leaving Akbal in a groaning mess behind you.  He howls as he claws the ground, his barbed cock still rock hard beneath him.  Just as you begin to leave you notice a group of imps watching you and the jaguar demon, their cocks out and leaking as their jagged teeth spread into feral grins.  You even spy a few goblins mixed in the crowd, each twirling a bottle of liquid and playing with her snatch.\n\n", false);

				outputText("As you leave Akbal snarls as the creatures that once feared him use his overtly aroused state to get revenge on the \"god\" of the terrestrial fire.  Even after you've reached the edge of the forest the wails of the jaguar demon can still be heard but just barely over the high pitched laughter of the demon imps and goblin females.", false);
			}
			//Centaur RAPPUUUUU
			else if (player.isTaur())
			{
				outputText(images.showImage("akbal-deepwoods-taur-forcedfemaleoral"));
				outputText("You roughly grab the scruff of the demon's neck, aiming a gut crushing blow to his stomach and causing him to call out in pain.\n\n", false);

				outputText("\"<i>Who's gonna submit now... bitch?</i>\"\n\n", false);
				outputText("Akbal snarls as you shove him back first onto the forest ground.  You look down at him, fully prepared to have your way with his demon dick.  What you see causes your " + player.vaginaDescript(0) + " to flinch at the thought of what would have happened if you had lost and the demon had used that on you.\n\n", false);

				outputText("The head of the massive dick sitting between Akbal's thighs is covered in a dozen tiny barbs that look like they were created to punish sinners.\n\n", false);

				outputText("You walk around the creature, irritated at the fact that you can't squat on that crazily large demon cat dick.  Once you're on the other side of him you sit your hind quarters on his face.\n\n", false);

				outputText("Akbal gives a muffled scream at first but soon he gets the message. His tongue slithers into your " + player.vaginaDescript(0) + ".  You lift yourself a little; well... you lean forward a bit to let the demon actually breath.  This proves to be the right choice as Akbal is ravenous for your " + player.vaginaDescript(0) + ".\n\n", false);

				outputText("He drills his TONGUE into you, mercilessly attacking your " + player.clitDescript() + " as you scream, howl and cringe in ecstasy.  He begins to lift up, probably to get the weight of your body off of the rest of his face, but you grab his tender furry balls in your hand and he stops before you're forced to do something drastic.\n\n", false);

				outputText("After dropping a line about how he has to make you cum or get his head ripped off Akbal whines, obviously distressed at not being able to slip his aching member into your " + player.vaginaDescript(0) + ".\n\n", false);

				outputText("With a sadistic laugh you ride out your orgasm until you're reduced to a shuddering heap.  After you've recovered you stand and gather your " + player.armorName + ", leaving Akbal in a groaning mess behind you.  He howls as he claws the ground, his barbed cock still rock hard beneath him.  Just as you begin to leave you notice a group of imps watching you and the jaguar demon, their cocks out and leaking as their jagged teeth spread into feral grins.  You even spy a few goblins mixed in the crowd, each twirling a bottle of liquid and playing with her snatch.\n\n", false);

				outputText("As you leave Akbal snarls as the creatures that once feared him use his overtly aroused state to get revenge on the \"god\" of the terrestrial fire.  Even after you've reached the edge of the forest the wails of the jaguar demon can still be heard but just barely over the high pitched laughter of the demon imps and goblin females.", false);
			}
			//Everybody else
			else
			{
				outputText(images.showImage("akbal-deepwoods-forcedfemaleoral"));
				outputText("You roughly grab the scruff of the demon's neck and give a gut-crushing blow to his stomach, causing him to call out in pain.", false);
				outputText("\n\n\"<i>Who's gonna submit now, bitch?</i>\"\n\n", false);
				outputText("Akbal grunts as you smash his face into the ground.  At your command he raises his hind quarters, allowing you a perfect view of his low-hanging balls and sheath.  You reach around his fuzzy orbs and pull his swollen cock back until the jaguar demon's 15-inch pecker is visible.\n\n", false);
				outputText("Your eyes widen when you see several wicked-looking barbs around his pre-pumping cockhead.  Instead of trying to deal with this massive phallus that looks like it was made to punish sinners, you walk around to the front of the creature.\n\n", false);
				outputText("Your scent causes Akbal's growling to quiver.  You lay down before him, grabbing his head and smashing his furry lips into your " + player.vaginaDescript(0) + ".  The demon, unable to escape his debilitating arousal, begins to lap at your " + player.vaginaDescript(0) + ".  He twists his lips and drills his tongue into you, mercilessly attacking your " + player.clitDescript() + ", and you scream, howl and cringe in ecstasy.  He begins to lift up, probably to get into position above you, but you force his face back down into your " + player.vaginaDescript(0) + ".  After dropping a line about how he has to make your cum or get his head ripped off, Akbal whines, obviously distressed at not being able to slip his aching member into your " + player.vaginaDescript(0) + ".\n\n", false);

				outputText("With a sadistic laugh you ride out your orgasm until you're reduced to a shuddering heap on the floor.  After you've recovered, you stand and gather your " + player.armorName + ", leaving Akbal in a groaning mess behind you.  He howls as he claws the ground, his barbed cock still rock hard beneath him.  As you walk away, you notice a group of imps watching you and the jaguar demon with their cocks out and leaking, their jagged teeth spread into feral grins.  You even spy a few goblins mixed in the crowd, and each is twirling a bottle of liquid while playing with her snatches.\n\n", false);
				outputText("Akbal snarls as you leave, the creatures that once feared him using his aroused state to get revenge on the 'god' of the terrestrial fire.  Even after you've reached the edge of the forest, the jaguar demon's pained howls can still be heard – though, just barely over the high-pitched laughter of the demon imps and the cackling of the goblin females.", false);
			}
			//END CENTAUR STUFF
			player.orgasm();
			dynStats("cor+",1);
			combat.cleanupAfterCombat();
		}

		//Standard rapes - buttfucks and oral
		private function rapeAkbal():void
		{
			flags[kFLAGS.AKBAL_BITCH_Q]++;
			var primary:Number = player.cockThatFits(50);
			if (primary < 0)
				primary = 0;
			clearOutput();
			//Naga RAPPUUUUUU
			if (player.lowerBody == LOWER_BODY_TYPE_NAGA)
			{
				outputText("You slither around the demon cat's form, wrapping him up until a scared whimper rises from his chest.  You continue to tighten your coils around Akbal until he's gasping for breath.  You ask him if he's going to be a good little demon for you.  He nods.\n\n", false);

				//(If player has a dick)
				if (player.totalCocks() > 0)
				{
					outputText(images.showImage("akbal-deepwoods-male-naga-rapeakbal"));
					//(Sm Penis: 7 inches or less)
					if (player.cocks[primary].cockLength <= 7)
					{
						outputText("As you uncoil you can't help but bump into the slimy leaking faucet Akbal calls his dick.  At your command he raises his hind quarters, giving you a perfect view of his tight pucker.  From the looks of it nothing has ever even touched the tightly sealed rim.  First you poke it with your finger, causing Akbal to flinch at the sensation.  Taking your " + player.cockDescript(primary) + " in hand you shove in without hesitation or mercy.  The virginally-tight hole clamps shut and Akbal hisses in pain as you force him open.  In no time at all you're sawing your " + player.cockDescript(primary) + " in and out of the demon's virginally-tight hole, relishing in the way it quivers and squirms around your embedded " + player.cockDescript(primary) + ".\n\n", false);
					}
					//(Md Penis: 8-12 inches)
					else if (player.cocks[primary].cockLength <= 12)
					{
						outputText("As you uncoil you can't help but bump into the slimy leaking faucet Akbal calls his dick.  At your command he raises his hind quarters, giving you a perfect view of his tight pucker.  From the looks of it nothing has ever even touched the tightly sealed rim.  A light tap of your finger causes the tiny hole to constrict in fear as Akbal's entire body flinches away from you.  You grab your " + player.cockDescript(primary) + " with a cruel smile.\n\n", false);

						outputText("As you shove your " + player.cockDescript(primary) + " into his tight pucker you are not surprised to find your " + player.cockDescript(primary) + " barely able to breach the tightly sealed walls.  Grunting with effort you slowly inch forward, Akbal howling and squirming beneath you as he is taken without regard for his own pleasure.\n\n", false);

						outputText("After a dozen achingly slow thrusts Akbal's asshole begins to loosen and you begin to saw your " + player.cockDescript(primary) + " in and out of his pucker with force as the demon cat's howls range from pained to pleased.\n\n", false);
					}
					//(Lg Penis: 13 inches and up)
					else
					{
						outputText("As you uncoil you can't help but bump into the slimy leaking faucet Akbal calls his dick.  At your command he raises his hind quarters, giving you a perfect view of his tight pucker.  A short glance tells you your " + player.cockDescript(primary) + " won't fit... but since when has that stopped you from trying?\n\n", false);

						outputText("When you slide a single finger against his virginally-tight hole Akbal flinches, the already tight hole clamping shut in fear.\n\n", false);

						outputText("You twist Akbal's tail into your fist and laugh as a scared whimper rises out of the jaguar demon's throat.  You begin to push your huge cock in with one hand as your other pulls Akbal's tail.  The creature wines and howls as you invade its clenching sphincter, forcibly stretching its tight pink hole to a dangerous degree with your " + player.cockDescript(primary) + ".  All too soon you are halted, barely able to fit more than a foot of your huge cock into Akbal's virginally-tight hole.  Deciding that's good enough you pull out and push forward, meeting the same resistance as before.\n\n", false);

						outputText("After hours of resistance and howling, Akbal's body shudders as his asshole relaxes due to complete exhaustion.  Battling with your tremendous cock seems to have made him almost pass out and he no longer has the energy to resist you.  The jaguar demon's body flinches with your every thrust as you begin to pound him raw, without lube and without mercy.\n\n", false);
					}
					//(transition)
					outputText("You rape the jaguar demon's tight hole with steadily mounting force, your " + player.hipDescript() + " smashing into his body with freight train force and causing him to cry out.  Despite this his 15 inch swollen sex organ pumps pre beneath him, letting you know that his pain is mixed with plenty of unwilling pleasure.\n\n", false);

					//(With Fertility/Lots of Jizz Perk)
					if (player.cumQ() > 1000)
					{
						outputText("The crushing tightness of Akbal's quivering hole pushes you over the edge and with a titanic howl you begin hosing down his insides.  The jaguar demon erupts as well, his body convulsing in time with your still thrusting " + player.cockDescript(0) + ".\n\n", false);

						outputText("As your cock continues to pump massive tons of liquid into the jaguar demon you grind your still swelling sex organ inside him and beneath the two of you his belly begins to bulge as he is filled.  As your massive orgasm subsides you pull out, releasing a gargantuan deluge of your thick spunk that rolls down his legs and creates a large puddle in the forest floor.  Akbal heaves a relieved sighs, obviously happy you are done raping him.\n\n", false);
					}
					//(without perk)
					else
						outputText("The crushing tightness of Akbal's quivering hole pushes you over the edge and with a titanic howl you begin hosing down his insides. Beneath you Akbal's own orgasm erupts and the jaguar demon goes limp as you continue to pound him through his orgasm.  When you pull out you aim a slap at Akbal's now very tender ass, making him yelp as your unexpected blow connects.\n\n", false);

					//(Ending)
					outputText("As you stand you gather your " + player.armorName + " and turn to leave the weakened demon behind you.  Just as you begin to walk away you notice a group of imps watching you and the jaguar demon, their cocks out and leaking.  Mixed in with the crowd are several goblins, each with a vial of liquid and a malicious grin.\n\n", false);

					outputText("As you leave Akbal snarls as the creatures that once feared him use his weakened state to exact revenge on the \"god\" of the terrestrial fire.  Even After you've reached the edge of the forest the jaguar demon's pained snarls can still be heard but just barely over the high pitched laughter of the demon imps and the cackling of the goblin females.", false);
				}
				//(If the player has a vagina)
				else
				{
					outputText(images.showImage("akbal-deepwoods-female-naga-rapeakbal"));
					outputText("As you uncoil you can't help but bump into the slimy leaking faucet Akbal calls his dick.  At your command he raises his hind quarters, allowing you a perfect view of his low hanging balls and sheath.  You reach around his fuzzy orbs and pull his swollen cock back until the jaguar demon's 15 inch pecker is visible.\n\n", false);

					outputText("Your eyes widen as you see several wicked looking barbs around his pre-pumping slit.  Instead of trying to deal with this massive phallus that looks like it was made to punish sinners you slither around to the front of the creature.\n\n", false);

					outputText("Your scent causes the growl ripping out of Akbal's chest to quiver.  You lay before him, reaching up to smash his furry lips into your " + player.vaginaDescript(0) + ".  The demon, unable to escape his debilitating arousal, begins to lap at your " + player.vaginaDescript(0) + ".  He shoves his face against your " + player.vaginaDescript(0) + " twisting his lips and drilling his tongue into you, mercilessly attacking your " + player.clitDescript() + " as you scream, howl and cringe in ecstasy.\n\n", false);

					outputText("He begins to lift up, probably to get into position above you and sake his lust, but you force his face back down into your " + player.vaginaDescript(0) + ".  After dropping a line about how he has to make your cum or get his head ripped off Akbal whines, obviously distressed at not being able to slip his aching member into your " + player.vaginaDescript(0) + ".\n\n", false);

					outputText("With a sadistic laugh you ride out your orgasm until you're reduced to a shuddering heap on the floor.  After you've recovered you gather your " + player.armorName + ", leaving Akbal in a groaning mess behind you.  He howls as he claws the ground, his barbed cock still rock hard beneath him.  Just as you begin to leave you notice a group of imps watching you and the jaguar demon, their cocks out and leaking as their jagged teeth spread into feral grins.  You even spy a few goblins mixed in the crowd, each twirling a bottle of liquid and playing with her snatch.\n\n", false);

					outputText("As you leave Akbal snarls as the creatures that once feared him use his overtly aroused state to get revenge on the \"god\" of the terrestrial fire.  Even after you've reached the edge of the forest the wails of the jaguar demon can still be heard but just barely over the high pitched laughter of the demon imps and goblin females.", false);
				}
				player.orgasm();
				dynStats("cor", 1);
				combat.cleanupAfterCombat();
					//END NAGA STUFF
			}
			//Centaur RAPPUUUUU
			else if (player.isTaur())
			{
				outputText("You roughly grab the scruff of the demon's neck, aiming a gut crushing blow to his stomach and causing him to call out in pain.\n\n", false);

				outputText("\"<i>Who's gonna submit now... bitch?</i>\"\n\n", false);

				//(If player has a dick)
				if (player.totalCocks() > 0)
				{
					outputText(images.showImage("akbal-deepwoods-male-taur-rapeakbal"));
					//(Sm Penis: 7 inches or less)
					if (player.cocks[primary].cockLength <= 7)
					{
						outputText("Akbal snarls pitifully as you shove him stomach down against a log.  Your " + player.cockDescript(primary) + " leaks at the thought of bringing this \"god\" down a notch .  At your command he arches his back and lifts his tail, giving you a perfect view of his tight pucker.  From the looks of it nothing has ever even touched the tightly sealed rim.  As you lightly tap it with your finger it flinches, becoming even tighter as Akbal's body jerks away in fear.\n\n", false);

						outputText("You rear up, standing on hind legs for a moment before your front legs fall to the ground, Akbal's head between them with his hair tickling your belly.  You give a few experimental thrusts.  The first one causes your " + player.cockDescript(primary) + " to slide up Akbal's upturned cheeks, making him cringe.  The second one, however, catches.\n\n", false);

						outputText("The virginally-tight hole clamps shut and Akbal hisses in pain as you force him open.  In no time at all you're sawing your " + player.cockDescript(primary) + " in and out of the demon's virginally-tight hole, relishing in the way it quivers and squirms around your embedded " + player.cockDescript(primary) + ".  The sounds coming from Akbal's throat are varied but include many unwillingly pleased groans.  He's obviously liking this more  than he's willing to admit.\n\n", false);
					}
					//(Md Penis: 8-12 inches)
					else if (player.cocks[primary].cockLength <= 12)
					{
						outputText("Akbal snarls pitifully as you shove him stomach down against a log.  Your " + player.cockDescript(primary) + " leaks at the thought of bringing this \"god\" down a notch.  At your command he arches his back and lifts his tail, giving you a perfect view of his tight pucker.  From the looks of it nothing has ever even touched the tightly sealed rim.  As you lightly tap it with your finger it flinches, becoming even tighter as Akbal's body jerks away in fear.\n\n", false);

						outputText("You rear up, standing on hind legs for a moment before your front legs fall to the ground, Akbal's head between them with his hair tickling your belly.  You give a few experimental thrusts.  The first one causes your " + player.cockDescript(primary) + " to slide up Akbal's upturned cheeks, making him cringe.  The second one, however, catches.\n\n", false);

						outputText("As you shove your " + player.cockDescript(primary) + " forward into his virginally-tight pucker you are not surprised to find your " + player.cockDescript(primary) + " barely able to breach the tightly sealed walls.  Grunting with effort you slowly inch forward, Akbal howling and squirming beneath you as he is taken without regard for his own pleasure.\n\n", false);

						outputText("After a dozen achingly slow thrusts Akbal's asshole begins to loosen and you begin to saw your " + player.cockDescript(primary) + " in and out of his pucker.  The demon cat's howls range from pained to pleased, obviously enjoying his butt rape more than he is willing to admit.\n\n", false);
					}
					//(Lg Penis: 13 inches and up)
					else
					{
						outputText("Akbal snarls pitifully as you shove him stomach down against a log. Your " + player.cockDescript(primary) + " leaks at the thought of bringing this \"god\" down a notch .  At your command he arches his back and lifts his tail, giving you a perfect view of his tight pucker.  From the looks of it nothing has ever even touched the tightly sealed rim.  As you lightly tap it with your finger it flinches, becoming even tighter as Akbal's body jerks away in fear.  There's no way in hell your " + player.cockDescript(primary) + " can fit inside something so incredibly tight but... since when has that stopped you?\n\n", false);

						outputText("You rear up, standing on hind legs for a moment before your front legs fall to the ground, Akbal's head between them with his hair tickling your belly.  You give a few experimental thrusts.  The first one causes your " + player.cockDescript(primary) + " to slide up Akbal's upturned cheeks, making him cringe.  The second one, however, catches.\n\n", false);

						outputText("The demon wines and wraps his arms around your front legs, pulling himself away from the burning pressure of your " + player.cockDescript(primary) + ".  His voice breaks as you invade his clenching sphincter, forcibly stretching Akbal's tight pink hole to a dangerous degree.  All too soon you are halted, barely able to fit more than a foot of your huge cock into Akbal's virginally-tight hole.  Deciding that's good enough you pull out and push forward, meeting the same resistance as before.\n\n", false);

						outputText("You grin as you realize that this may take a while...\n\n", false);

						outputText("After hours of resistance and howling, Akbal's body shudders as his asshole relaxes due to complete exhaustion.  Battling with your tremendous cock seems to have made him almost pass out and he no longer has the energy to resist you.  The jaguar demon's body flinches with your every thrust as you begin to pound him raw, without lube and without mercy.\n\n", false);
					}
					//(transition)
					outputText("You rape the jaguar demon's tight hole with steadily mounting force, your trunk smashing into his cringing body with freight train force and causing him to cry out in times with your grunts.  Despite this his 15 inch swollen sex organ pumps pre beneath him, letting you know that his pain is mixed with plenty of unwilling pleasure.\n\n", false);

					//(With Fertility/Lots of Jizz Perk)
					if (player.cumQ() > 1000)
					{
						outputText("The crushing tightness of Akbal's quivering hole pushes you over the edge and with a titanic howl you begin hosing down his insides.  Akbal's suddenly clenching sphincter lets you know he has reached his orgasm as well.  ", false);
						outputText("You continue to slide your still swollen sex organ inside his quivering hole as you pump massive tons of liquid into the false god's stomach and bowels.  Beneath the two of you his belly begins to bulge as he is filled to a dangerous degree.  ", false);
						outputText("Once your massive orgasm subsides you pull out, releasing a gargantuan deluge of your thick spunk that rolls down his legs and creates a large puddle in the forest floor.  Akbal heaves a relieved sigh, obviously happy you are finally done raping him.\n\n", false);
					}
					//(without perk)
					else
					{
						outputText("The crushing tightness of Akbal's quivering hole pushes you over the edge and with a titanic howl you begin hosing down his insides.  Akbal's suddenly clenching sphincter lets you know he has reached his orgasm as well.  The jaguar demon's body goes limp as you continue to pound him through his orgasm.  When you pull out you aim a slap at Akbal's now very tender ass, making him yelp as your unexpected blow connects.\n\n", false);
					}
					//(Ending)
					outputText("As you stand you gather your " + player.armorName + " and turn to leave the weakened demon behind you.  Just as you begin to walk away you notice a group of imps watching you and the jaguar demon, their cocks out and leaking.  Mixed in with the crowd are several goblins, each with a vial of liquid and a malicious grin.\n\n", false);
					outputText("As you leave Akbal snarls as the creatures that once feared him use his weakened state to exact revenge on the \"god\" of the terrestrial fire.  Even After you've reached the edge of the forest the jaguar demon's pained snarls can still be heard but just barely over the high pitched laughter of the demon imps and the cackling of the goblin females.\n\n", false);
				}
				//(If the player has a vagina)
				else
				{
					outputText(images.showImage("akbal-deepwoods-female-taur-rapeakbal"));
					outputText("Akbal snarls as you shove him back first onto the forest ground.  You look down at him, fully prepared to have your way with his demon dick.  What you see causes your " + player.vaginaDescript(0) + " to flinch at the thought of what would have happened if you had lost and the demon had used that on you.\n\n", false);

					outputText("The head of the massive dick sitting between Akbal's thighs is covered in a dozen tiny barbs that look like they were created to punish sinners.\n\n", false);

					outputText("You walk around the creature, irritated at the fact that you can't squat on that crazily large demon cat dick.  Once you're on the other side of him you sit your hind quarters on his face.\n\n", false);

					outputText("Akbal gives a muffled scream at first but soon he gets the message. His tongue slithers into your " + player.vaginaDescript(0) + ".  You lift yourself a little; well... you lean forward a bit to let the demon actually breath.  This proves to be the right choice as Akbal is ravenous for your " + player.vaginaDescript(0) + ".\n\n", false);

					outputText("He drills his TONGUE into you, mercilessly attacking your " + player.clitDescript() + " as you scream, howl and cringe in ecstasy.  He begins to lift up, probably to get the weight of your body off of the rest of his face, but you grab his tender furry balls in your hand and he stops before you're forced to do something drastic.\n\n", false);

					outputText("After dropping a line about how he has to make you cum or get his head ripped off Akbal whines, obviously distressed at not being able to slip his aching member into your " + player.vaginaDescript(0) + ".\n\n", false);

					outputText("With a sadistic laugh you ride out your orgasm until you're reduced to a shuddering heap.  After you've recovered you stand and gather your " + player.armorName + ", leaving Akbal in a groaning mess behind you.  He howls as he claws the ground, his barbed cock still rock hard beneath him.  Just as you begin to leave you notice a group of imps watching you and the jaguar demon, their cocks out and leaking as their jagged teeth spread into feral grins.  You even spy a few goblins mixed in the crowd, each twirling a bottle of liquid and playing with her snatch.\n\n", false);

					outputText("As you leave Akbal snarls as the creatures that once feared him use his overtly aroused state to get revenge on the \"god\" of the terrestrial fire.  Even after you've reached the edge of the forest the wails of the jaguar demon can still be heard but just barely over the high pitched laughter of the demon imps and goblin females.", false);
				}
				player.orgasm();
				dynStats("cor", 1);
				combat.cleanupAfterCombat();
				return;
					//END CENTAUR STUFF
			}
			outputText("You roughly grab the scruff of the demon's neck and give a gut-crushing blow to his stomach, causing him to call out in pain.", false);
			outputText("\n\n\"<i>Who's gonna submit now, bitch?</i>\"\n\n", false);
			//[Player has a dick]
			if (player.totalCocks() > 0)
			{
				outputText(images.showImage("akbal-deepwoods-male-rapeakbal"));
				outputText("Akbal grunts as you smash his face into the ground.  At your command he raises his hind quarters, allowing you a perfect view of his tight pucker.  From the looks of it, his tightly sealed rim would look at home on a virgin.\n\n", false);
				//[Small penis (7 inches or less)]
				if (player.cockArea(0) < 13)
				{
					outputText("You first poke it with your finger, causing Akbal to flinch at the sensation.  Taking your " + player.cockDescript(0) + " in hand, you shove it in without hesitation or mercy.  The virgin-like hole clamps shut and Akbal hisses in pain as you force him open.  In no time at all you're sawing your " + player.cockDescript(0) + " in and out of the demon's tight hole, relishing in the way it quivers and squirms around your embedded " + player.cockDescript(0) + ".\n\n", false);
				}
				//[Medium penis (8-12 inches)]
				else if (player.cockArea(0) < 25)
				{
					outputText("A light tap of your finger causes the tiny hole to constrict and Akbal's entire body flinches in fear.  You grab your " + player.cockDescript(0) + " with a cruel smile.  As you shove yourself into his tight pucker, you aren't surprised to find that your " + player.cockDescript(0) + " is barely able to breach the tightly sealed walls.  Grunting with effort you slowly inch forward, Akbal howling and squirming beneath you as he is taken without regard for his own pleasure.\n\n", false);
					outputText("After a dozen achingly slow thrusts, Akbal's asshole begins to loosen and you start sawing your " + player.cockDescript(0) + " in and out of his pucker with force. The demon cat's howls fluctuate between yelps of pain and moans of pleasure.\n\n", false);
				}
				//[Large penis (13 inches and up)]
				else
				{
					outputText("A single look tells you your " + player.cockDescript(0) + " won't fit... but since when has that stopped you from trying?  You slide a single finger against the virginally-tight hole and Akbal flinches. His already tight hole clamps shut in fear, as if doing so will somehow stop the inevitable intrusion.\n\n", false);
					outputText("You twist Akbal's tail into your fist and laugh as a scared whimper escapes from the jaguar demon's throat.  You begin to push your " + player.cockDescript(0) + " in with one hand as you pull Akbal's tail with the other.  The demon whines and howls as you invade his clenching sphincter, forcibly stretching the tight pink hole to a dangerous degree.  You are halted all too soon, barely able to fit more than a foot of your " + player.cockDescript(0) + " into Akbal's virginally-tight hole.  Deciding that's good enough, you pull out before pushing forward again, meeting the same resistance as before.\n\n", false);
					outputText("After what seems like hours of resistance and howling, Akbal's body shudders and his asshole relaxes from complete exhaustion.  Battling with your " + player.cockDescript(0) + " seems to have nearly made him pass out, and he no longer has the energy to resist you.  The jaguar demon's body flinches with your every thrust as you pound him raw – without lube, and without mercy.\n\n", false);
				}
				outputText("You rape the jaguar demon's tight hole with steadily mounting force, your " + player.hipDescript() + " smashing into his body with freight-train force, and causing him to cry out.  Despite this, his 15-inch swollen sex organ is pumping out pre beneath him, letting you know that his pain is mixed with plenty of unwilling pleasure.\n\n", false);
				outputText("The crushing tightness of Akbal's quivering hole pushes you over the edge, and with a titanic howl you unleash your load inside him.  Akbal's suddenly clenching sphincter lets you know that he has reached his orgasm as well.\n\n", false);

				//[With Fertility/Lots of Jizz Perk]
				if (player.cumQ() > 1000)
				{
					outputText("You continue to slide your still-swollen " + player.cockDescript(0) + " inside his quivering hole as you pump massive tons of liquid into the false god's stomach and bowels.  Beneath the two of you, his belly begins to bulge as he is filled to a dangerous degree.\n\n", false);
					outputText("Once your massive orgasm subsides you pull out, releasing a gargantuan deluge of your thick spunk that rolls down his legs, creating a large puddle in the forest floor.  Akbal heaves a relieved sigh, obviously glad that you are finally done raping him.\n\n", false);
				}
				//[Without Fertility/Lots of Jizz Perk]
				else
				{
					outputText("The jaguar demon's body goes limp as you continue to pound him through his orgasm.  When you finally pull out, you aim a slap at Akbal's now very tender ass and make him yelp when your unexpected blow connects.\n\n", false);
				}
				outputText("Standing up, you gather your " + player.armorName + " and turn to leave the weakened demon behind you.  As you walk away, you notice a group of imps watching you and the jaguar demon with their cocks out and leaking.  Mixed in with the crowd are several goblins, each with a vial of liquid and a malicious grin.\n\n", false);
				outputText("Akbal snarls as you leave, the creatures that once feared him using his weakened state to get revenge on the 'god' of the terrestrial fire.  Even after you've reached the edge of the forest, the jaguar demon's pained howls can still be heard – though, just barely over the high-pitched laughter of the demon imps and the cackling of the goblin females.", false);
			}
			//[Player has a vagina]
			else if (player.hasVagina())
			{
				outputText(images.showImage("akbal-deepwoods-female-rapeakbal"));
				outputText("Akbal grunts as you smash his face into the ground.  At your command he raises his hind quarters, allowing you a perfect view of his low-hanging balls and sheath.  You reach around his fuzzy orbs and pull his swollen cock back until the jaguar demon's 15-inch pecker is visible.\n\n", false);
				outputText("Your eyes widen when you see several wicked-looking barbs around his pre-pumping cockhead.  Instead of trying to deal with this massive phallus that looks like it was made to punish sinners, you walk around to the front of the creature.\n\n", false);
				outputText("Your scent causes Akbal's growling to quiver.  You lay down before him, grabbing his head and smashing his furry lips into your " + player.vaginaDescript(0) + ".  The demon, unable to escape his debilitating arousal, begins to lap at your " + player.vaginaDescript(0) + ".  He twists his lips and drills his tongue into you, mercilessly attacking your " + player.clitDescript() + ", and you scream, howl and cringe in ecstasy.  He begins to lift up, probably to get into position above you, but you force his face back down into your " + player.vaginaDescript(0) + ".  After dropping a line about how he has to make your cum or get his head ripped off, Akbal whines, obviously distressed at not being able to slip his aching member into your " + player.vaginaDescript(0) + ".\n\n", false);

				outputText("With a sadistic laugh you ride out your orgasm until you're reduced to a shuddering heap on the floor.  After you've recovered, you stand and gather your " + player.armorName + ", leaving Akbal in a groaning mess behind you.  He howls as he claws the ground, his barbed cock still rock hard beneath him.  As you walk away, you notice a group of imps watching you and the jaguar demon with their cocks out and leaking, their jagged teeth spread into feral grins.  You even spy a few goblins mixed in the crowd, and each is twirling a bottle of liquid while playing with their snatches.\n\n", false);
				outputText("Akbal snarls as you leave, the creatures that once feared him using his aroused state to get revenge on the 'god' of the terrestrial fire.  Even after you've reached the edge of the forest, the jaguar demon's pained howls can still be heard – though, just barely over the high-pitched laughter of the demon imps and the cackling of the goblin females.", false);
			}
			player.orgasm();
			dynStats("cor", 1);
			combat.cleanupAfterCombat();
		}

		private function girlsRapeAkbal():void
		{
			flags[kFLAGS.AKBAL_BITCH_Q]++;
			clearOutput();
			outputText("You smirk to yourself quietly as the so called \"God of Terrestrial Fire\" lays in a twitching heap on the ground, his flesh squirming as he shifts into his more humanoid form. Removing your " + player.armorName + ", your hand lowers to your feminine slit, pondering how to make use of him.\n\n", false);
			//{If Centaur}
			outputText(images.showImage("akbal-deepwoods-female-bindakbal"));
			if (player.isTaur())
			{
				outputText("Already you can see the trouble of trying to accommodate someone with your body type, but as they said in your village, \"<i>where there's a will, there's a way</i>\". Grabbing some of the vines from the nearby trees, you approach the nearly comatose Akbal and sling him over your back, grinning as you work through the details in your mind.\n\n", false);

				outputText("Before the feline demon can recover and protest, you bind his arms to the end of the longest vines, throwing them over some of the stronger branches to make a makeshift pulley system. Hauling him up against the bark of the tree, he stirs slightly, but is still unable to work up the strength to fight back. Making the most of the time you figure you have left before he fully awakens, you bind his feet near the base of the tree, effectively turning him into a mounted toy for you to impale your " + player.vaginaDescript() + " upon.\n\n", false);

				outputText("With his arms and legs bound, you take the time to examine your prize, reaching forward to stroke his full, baseball sized sack and swinging barbed shaft. It looks that despite the fact that you beat him into submission, the demon isn't totally opposed to the idea as he stirs to life in your hand, throbbing slightly. The jaguar starts to open his emerald eyes and glares at you, but nonetheless tries to push his hips forward, giving a snarl of annoyance when he can't work get proper leverage on the tree thanks to your binding.\n\n", false);

				outputText("Keeping the vines holding his arms up in hand, you slowly turn around and lift your tail, allowing your sopping mare cunt to wink at Akbal", false);
				if (player.hasCock())
					outputText(" " + player.sMultiCockDesc() + " hanging beneath, twitching in anticipation", false);
				outputText(". With a smirk at the helpless Gods expense, you take a step back, lining up before pushing yourself against him roughly, shoving his barbed feline shaft deeply into you.", false);
			}
			//{If Pussy is <loose}
			else if (player.vaginalCapacity() < monster.cockArea(0))
			{
				outputText("Rolling him over onto his back with your foot, you tsk in annoyance, knowing that you won't be able to fit his large kitty-cock between your legs without some considerable pain, and you don't really trust the demon to let his mouth, with all those oh-so-sharp teeth, near your most sensitive areas. Thankfully, another option is available, currently twitching around your feet.\n\n", false);

				outputText("Reaching down, you grab his flicking tail, ignoring his feline yowl of discomfort, stroking the spotted, silky smooth fur with a few fingers, the sensation creating shivers of lust up your spine. Already images bloom in your mind, creating all kinds of acts you could use this appendage for and plucking the most prominent one from your mind, you grab the demon cat by the scruff of his neck, ", false);
				//({If strength >60}
				if (player.str > 60)
					outputText("hauling him towards a tree like a newborn kitten", false);
				else
					outputText("dragging him towards the nearest tree", false);
				outputText(" and forcing him to lean back against it.\n\n", false);

				outputText("Gripping his tail once more, you grab him by the fur of his head and yank him down to meet the tip, pressing insistently against his lips. Even in his weakened state Akbal refuses until you happen to glance down between his legs. It seems like the demon is more turned on by you taking charge than he would like to admit.  ", false);
				//({if Naga}
				if (player.isNaga())
					outputText("You curl the tip of your tail around his length, catching the barbs lightly on your scales and squeezing, coaxing a low yowl of pleasure which you hurriedly make use of, ", false);
				//{If Goo}
				else if (player.isGoo())
					outputText("You focus, extending a small part of your liquid-like body, enveloping his feline meat in yourself, careful to avoid the tip. The sensation of damp warmth around his feline member is too much, making him open his mouth in a silent moan which you hastily use, ", false);
				else
					outputText("Lifting up your " + player.leg() + ", you firmly place the sole of your foot against his barbed flesh, pressing it against his stomach, forcing the jaguar to let out a low moan which you quickly take advantage of, ", false);

				outputText("stuffing his own tail into his maw.  As he tries to push his tail back out, you remove your " + player.foot() + " pointedly, staring down at the demon. Lifting his hips back up weakly towards you, he meekly begins to suckle on his own appendage, closing his vibrant emerald eyes as you return your attention to his shaft.\n\n", false);
			}
			//{If Pussy >= Loose}
			else
			{
				outputText("You grin as you flip him over onto his back, staring down at his breeding tool between his legs, firmly erect as it rests on his rather full set of balls. Quite clearly, this \"<i>God</i>\" hasn't had much action for quite some time, hence his aggressive nature towards you. You finger yourself slightly as you examine his feline shaft, coated with layers of barbs that look as though they would be quite painful. Leaning down, you run your fingers over them, smirking as they bend slightly. They may not be enough to harm you, but sex would definitely be unpleasant... unless you happened to have a source of suitable lube nearby.\n\n", false);
				outputText("Remembering the cats back home", false);
				//({If player has the flexibility Perk}
				if (player.findPerk(PerkLib.Flexibility) >= 0)
					outputText(" and your own experience with such matters", false);
				outputText(", you figure you have a pretty good idea where a reliable source of lube could be. You grin as you grab the demon cat by the scruff of his neck, ", false);
				//({If strength >60}
				if (player.str > 60)
					outputText("hauling him towards a tree like a newborn kitten", false);
				else
					outputText("dragging him towards the nearest tree", false);
				outputText(" and forcing him to lean back against it.\n\n", false);

				outputText("In his dazed state, Akbal offers little resistance when you position him against the tree. That changes however, when you grab the hair of his head and push him down towards his own straining cock. Angry whispers flit at the edge of your mind, easily brushed aside as you reach down and squeeze the demon's cheeks, forcing his mouth to open. Quickly, you plug his maw with his own shaft, holding his head down, forcing him to coat his meat with his own saliva.  ", false);
				//{If Corruption <30}
				if (player.cor < 33)
					outputText("In a brief moment of pity you reach down, stroking Akbal's strained balls as he suckles, feeling them quiver as he noisily slurps and drools.", false);
				else
					outputText("You smirk, grabbing his full sack almost roughly, shaking them as he stares at you with his emerald eyes, although with rage or lust you can't quite tell.", false);
				outputText("\n\n", false);

				outputText("Finally, you judge that he's done enough, allowing him to lift his head back up with a splutter, although considering the flowing pre around his tip and over his lips, the experience was hardly a painful one. He glares at you with his burning green eyes as you ", false);
				//({if Player is naga}
				if (player.isNaga())
					outputText("rear up, supporting your weight on your own tail as your hands explore down below, finding your puffed up slit and slowly parting them with a pair of fingers, allowing your scent and dampness to coat the jaguar's snout.", false);
				else if (player.isGoo())
					outputText("reach out, your liquid-like body coating his legs and holding them open, your hands reaching down to play with your damp, open fuck hole, chuckling as he tries to feign disinterest despite the obvious throbbing of his sack.", false);
				else
					outputText(" begin to stand over him, spreading your legs to reveal your damp, open pussy, his expression turning comically from rage to confusion to one of sheer lust, the feline licking his lips despite his own flavor on them.", false);
				outputText("\n\n", false);

				outputText("Judging by the shudder of longing that runs through his body, it's clear that he's more turned on by your actions than he would have liked. Using your lower body to pin his legs down, you grab his arms as you sink down, moaning more for his benefit as you brush the tip of his slick member against your entrance.", false);
			}
			dynStats("lus", 50);
			//-Page Turn-
			doNext(girlsRapeAkbalPart2);
		}

		private function girlsRapeAkbalPart2():void
		{
			clearOutput();
			kGAMECLASS.hideUpDown();
			//Centaur
			outputText(images.showImage("akbal-deepwoods-female-taur-bindakbal"));
			if (player.isTaur())
			{
				outputText("You moan deeply as the thick shaft spreads your lips wide, throbbing against your clit as the barbs shudder against your inner walls, pushing your rump firmly against his lower abdomen as you squirm, leaking over his waist", false);
				if (player.hasCock())
					outputText(", " + player.sMultiCockDesc() + " swinging back and forth, occasionally bumping into his bound legs", false);
				outputText(". The demon groans, clenching his eyes shut as he refuses to like the treatment you're forcing on him, but his body betrays him as a liar as his felinehood thickens and lengthens, more than eager to stuff your box full. It's with no small shiver of delight when you drink in his moans of longing as you pull back to the very tip of his cock.\n\n", false);

				//({If Corruption > 30}
				if (player.cor > 33)
					outputText("If you weren't so eager on using him to get off, you might have considered teasing him like that then leaving him bound to the tree.  ", false);
				outputText("Quickly, you settle into a rhythm of rocking back and forth, the tree creaking as you throw your weight against it with every plunge down, the cat behind you reduced to a mewling, begging kitten, trying in vain to thrust into your sopping cunt.\n\n", false);

				outputText("You continue like this for the better part of an hour, his barbs raking your insides and sending constant shivers through your body, but you just can't seem to get off on your bounces alone. Without really thinking it through, you release the vines holding Akbal's arms up to grope your own " + player.chestDesc() + ", fondling yourself roughly.\n\n", false);

				outputText("Thankfully, Akbal is just as desperate to get off as you as he makes use of his new found freedom, one hand clutching the base of your tail, the other grabbing your flank with a clawed paw. Immediately he snarls, shoving his feline dong deep into you, a much better sensation then when you were merely rocking on him, your mare cunt squirting and clenching around him, trying to milk his seed", false);
				if (player.hasCock())
					outputText(", while your cock slaps at your stomach, pre flying from the tip to coat your lower body and the earth below", false);
				outputText(". He buries himself deep over and over, his fat, swollen balls slapping against you, feeling oddly natural", false);
				if (player.balls > 0)
				{
					outputText(", your own swaying back to meet him", false);
					//({If >=Grapefruit}
					if (player.ballSize >= 12)
						outputText(" dwarfing him despite his pent up lusts", false);
				}
				outputText(", coaxing moans and groans of sheer pleasure to mingle with his snarls and purrs of enjoyment.\n\n", false);

				outputText("In the end the jaguar finishes first, roaring his pleasure to the trees as he squirts his kitten-cream into your cunt, filling you up. If you were in any state to guess, you could probably imagine the cat filling up your womb as well judging by the swelling of your lower body, causing a flash of concern, wondering if the feline could possibly impregnate your womb. He's not finished however, as he continues to thrust through his release, pulling you higher and higher into orgasmic bliss as you finally release in tandem with his fifth orgasm. Your " + player.vaginaDescript() + " clenches tightly over him, coating his waist in fem juices as you milk him", false);
				if (player.hasCock())
					outputText(" as " + player.sMultiCockDesc() + " twitch and let loose, spraying the ground with your seed", false);
				outputText(".\n\n", false);

				outputText("Your body trembles as the demon sags down onto your lower back, clutching your equine hips lightly, as you want nothing more but to simply sag down with him, his weight oddly comfortable on your back. Shaking your head to clear it, you begin to turn round, careful not to dislodge Akbal from his obviously comfortable position as you feel him slowly start to shift back into his quadruped form, his dripping shaft slipping out of your pussy with an obscene slurping noise. Lowering your tail, you let the demon slip off, fumbling with the vines around his feet, releasing him as he sprawls on the ground in pure contentment. As you straighten up and start to head back to camp, you realize you feel the same way; perfectly content. Maybe it wouldn't be a bad idea to look out for the God in the future...", false);
				//Imp pregnancy
				//Preggers chance!
				player.knockUp(PregnancyStore.PREGNANCY_IMP, PregnancyStore.INCUBATION_IMP, 101);

				player.cuntChange(monster.cockArea(0), true, true, false);
				player.orgasm();
				dynStats("cor", 1);
			}
			//TOIGHT
			else if (player.vaginalCapacity() < monster.cockArea(0))
			{
				//-Page Turn-
				outputText("Judging the silky fur to be slick enough, you yank out the tail from his mouth, pulling it towards your " + player.vaginaDescript() + " lips, teasing your folds with the tip before guiding him in. Taking the hint, the feline squirms his tail, pushing into you as he lifts his hips up once more, purring lightly as he presses himself against your " + player.foot() + ".  His cock is already leaking pre from the tip.  You gasp loudly as his fur bristles inside you, his saliva making your womanhood quiver in need as you feel him slip deeper, coiling and twisting. Making sure not to neglect the feline, you", false);
				//({If Naga}
				if (player.isNaga())
					outputText(" squeeze his meat tighter, moving your coils up and down his feline prick while using the very tip of your tail to tease and poke his urethra, coating it in his pre", false);
				//({If Goo}
				else if (player.isGoo())
					outputText(" squirm and writhe over the base of his feline shaft, vibrating your liquid-like appendage like a living sex toy, causing his balls to jiggle slightly", false);
				//({If Bipedal}
				else
					outputText(" press his shaft firmer against his stomach, slowly slipping the sole of your foot up and down his length, coaxing out small yowls and purrs of pleasure", false);
				outputText(" as silent payment for the pleasure he's flooding your pussy with.\n\n", false);

				outputText("Time seems to stretch as you stand there, pinning the god, once so proud and mighty, now just a mewling kitten devoted to your pleasure", false);
				//({If Herm}
				if (player.hasCock())
					outputText(" while you stroke " + player.oMultiCockDesc() + " in time with his thrusts", false);
				outputText(". His flexible tail pokes and strokes your deepest recesses as you keep him permanently on the edge with your teasing treatment while his sharp claws dig furrows into the earth as he strains up against you, too caught up in his pleasure to mentally voice his desires. Instead, he opens his maw to signal his lust as a savage beast would, full of yowls, snarls and purrs, creating an oddly pleasing cacophony to your ears, making you feel like the " + player.mf("Ruler of Beasts", "Queen of Beasts") + ", adding your own savage calls to his.\n\n", false);

				outputText("The squirming of his tail becomes too much however, as a familiar pressure builds up down below. Increasing the pace upon which you please his shaft, you lower yourself, trying to push more of that skilled tail into you, ", false);
				//({If Herm}
				if (player.gender == 3)
					outputText("stroking " + player.oMultiCockDesc() + " roughly, ", false);
				outputText("moaning loudly as your pussy lips begin to clench and tighten, slick juices trickling down his fur. Sensing your closeness, Akbal redoubles his efforts, his writhing tail bristling, dragging his fur along your insides. Finally it becomes too much as you release, your thick fem juices pouring out of your stuffed pussy, falling down onto his straining shaft", false);
				if (player.hasCock())
					outputText(" as " + player.sMultiCockDesc() + " offers up its bounty, spasming and adding to the mess", false);
				outputText(". The added heat and wetness of your orgasm sets him over the edge as he gives a roar loud enough to shake the trees, his thick, barbed shaft squirting hard, arcing his back as his seed splats onto the leaves of the tree above, falling down as a perverse rain over the pair of you.\n\n", false);

				outputText("Your " + player.chestDesc() + " chest heaves as you struggle to gulp air, " + player.legs() + " quivering from the sheer power of the orgasm the cat's tail gave you.  ", false);
				//({if cum volume > normal}
				if (player.cumQ() > 500)
					outputText("His entire waist is coated in your juices, the once proud cat sitting in a pool of your leavings, with a contented grin on his face, like the cat that caught the canary", false);
				//({If cum volume low/normal}
				else
					outputText("He sits, dazed as your cum covers his groin, his meat still shiny from the torrent you dropped down upon it. Nevertheless, his face is twisted into a purr", false);
				outputText(" as he sags against the tree trunk, overwhelmed by the pleasure. With a satisfied grin of your own, you pick up your " + player.armorName + " and head out. Perhaps you should look out for the \"<i>God of Terrestrial fire</i>\" again sometime...", false);
				//{No Penetration or fluids exchanged = No corruption increase? Poss. Sensitivity increase/decrease due to fur and/or saliva}
				player.orgasm();
			}
			//= = = =
			//Loose
			else
			{
				outputText("You groan loudly as Akbal's impressive shaft stretches your pussy wide, instantly thankful that you had the idea to lube him up beforehand. Your less-than-willing partner adds his own groan to yours, the twitching of his meat signalling that he's not quite to opposed to the idea as he makes out. Maybe he's got a thing about dominance, from either angle. Nevertheless, you continue to push down until your hips reach his with a light bump. The sensation of his immense cock filling you up causes you to shudder, before leaning into the demon, pressing your " + player.chestDesc() + " against his, revealing in his silky fur stroking multiple parts of your body all at once. The yowling male takes off, ducking his head to lick and nip at your " + player.nippleDescript(0) + "s", false);
				//({If Lactating}
				if (player.biggestLactation() >= 1)
					outputText(", adding a purr of pleasant surprise as he locks his lips around one nipple, drawing out mouthfuls of your sweet milk before gulping it down.  The sheer taboo of feeding a demon your milk sends shivers down your spine", false);
				outputText(".\n\n", false);

				outputText("As you lift yourself off, your head begins to swim as his previously unnoticed barbs rake along your inner walls, tugging, catching and massaging from the inside as they start to vibrate, causing you to ", false);
				//({if Naga}
				if (player.isNaga())
					outputText("wrap your coils around him and the tree, adding leverage to your plunges down", false);
				//({If Goo}
				else if (player.isGoo())
					outputText("encase yourself around his hips and groin, your entire lower body writhing and squirming around his shaft", false);
				//({If Bipedal}
				else
					outputText("lock your legs around his torso, bouncing upon him with greater force", false);
				outputText(".  As your mouth hangs open, the demon lunges forward, pressing his own snout against your " + player.face() + ". You can still taste the traces of his own pre on his lips and tongue, furthering your lust as you use his groin roughly, impaling yourself hard enough to leave bruises on the pair of you, while he uses his tail to ", false);
				//({if herm}
				if (player.cockTotal() == 1)
					outputText("wrap around your own straining shaft, the fur enhancing the effects of his pumps", false);
				//({If more than 1 cock}
				else if (player.cockTotal() > 1)
					outputText("wrap around each of your throbbing malehoods with difficulty, teasing them with his bristled fur", false);
				//({If female}
				else
					outputText("stroke and tickle your ass and lower back", false);
				outputText(".\n\n", false);

				outputText("You're not sure how long you sit there, bouncing roughly on the feline demon's cock, his eyes clenched tightly shut as he revels in the feeling of your warm damp pussy and your " + player.buttDescript() + " grinding against his swollen sack. Eventually, his combined efforts of mouth, shaft and tail force you over the edge, your hungry pussy lips clenching tightly over him, rhythmically squeezing as you attempt to milk his shaft", false);
				//({if Herm}
				if (player.hasCock())
					outputText(" as " + player.sMultiCockDesc() + "  twitches and strains, ready to blow", false);
				outputText(", and he certainly doesn't disappoint. With a roar loud enough to shake the trees, he erupts violently within your passage, his hot, steaming, fertile seed pouring into your depths", false);
				//({if Herm}
				if (player.cockTotal() == 1)
					outputText(", setting your own malehood off in sympathy, squirting thick cream over his chest", false);
				else if (player.cockTotal() > 1)
					outputText(" setting each of your malenesses surging, splattering the feline with your seed", false);
				outputText(", his face twisted into a snarl of pleasure and satisfaction.\n\n", false);

				outputText("You slowly come down from your orgasmic high, struggling to remove yourself from the demon's lap and heading unsteadily towards your " + player.armorName + " as fresh feline seed pours down your body, wincing at the slight bruising to your womanhood. Rubbing a hand over your stomach, you start to wonder if perhaps it was a touch risky to allow a demon to shoot his seed into your womb. However, despite the mild throbbing, you feel refreshed and oddly strengthened by Akbal's potent seed, glancing over your shoulder to see the once proud god reveling in his own release. Perhaps it wouldn't be a bad idea to seek him out some other time...", false);
				player.orgasm();
				dynStats("cor", 1);
				//Imp pregnancy
				//Preggers chance!
				player.knockUp(PregnancyStore.PREGNANCY_IMP, PregnancyStore.INCUBATION_IMP, 101);
			}
			combat.cleanupAfterCombat();
		}

		private function loseToAckballllllz():void
		{
			//[Defeat via Lust]
			if (!player.isTaur())
			{
				outputText(images.showImage("akbal-deepwoods-losslust-analed"));
				outputText("You fall to your knees and begin to feverishly masturbate.  Akbal rises onto his two hind legs, his body shifting into a more humanoid form as he stands.  His long cock swings ominously between his legs as he walks towards you.  The first thing he does is pull his massive 15-inch cock to your lips, slapping the shaft against your chin.\n\n", false);
				outputText("Like a whore in heat, you open your mouth and lewdly lick the jaguar demon's cock head, feeling odd barbs rub against your tongue.  Your mouth opens wide, but can't even get past the head before the sheer girth of Akbal's massive sex organ halts its advance.  Akbal is content to let you orally fumble with the head for only a few moments before he pushes down onto your back. His claws tickle your thighs as he forces your " + player.legs() + " up over your head, bringing your " + player.assholeDescript() + " into plain view.\n\n", false);
				outputText("\"<i>Defiance repaid,</i>\" is all you hear from the chorus of voices in your head as Akbal displays his massive length to you.  Your eyes widen in horror, counting a dozen wicked-looking barbs on the head of his overtly thick and over-sized cock.\n\n", false);
			}
			//Centaurs R SPECIALZ
			else if (player.isTaur())
			{
				outputText(images.showImage("akbal-deepwoods-losslust-taur-analed"));
				outputText("You stumble like a drunken pony as your lust goes into the red zone and you know in the pit of your stomach that you are at this wicked demon's mercy.\n\n", false);

				outputText("Akbal rises onto his two hind legs, his body becoming more humanoid as he does. His long, semi-erect cock swings ominously his legs as he walks towards you.\n\n", false);

				outputText("\"<i>Defiance repaid,</i>\" is all you hear from the chorus of voices in your head as Akbal displays his massive length to you. Your eyes widen in horror as you count a dozen wicked looking barbs on the head of his overtly thick, gargantuan cock.\n\n", false);

				//(Small/Virgin Pucker)
				if (player.ass.analLooseness < 3)
				{
					outputText("Akbal begins to push into you, the barbs on his massive head causing you to howl as your " + player.assholeDescript() + " is forcibly stretched. His jaguar claws grab your sides as he uses your body as leverage to force his demonic erection into you.\n\n", false);

					outputText("When Akbal shoves forward the strain makes you feel as though you are going to pass out; the pain from his spiked sex organ is just enough to leave you conscious. He begins to withdraw and you realize he's not even forcing half the length of that swollen sex organ into your " + player.assholeDescript() + ".\n\n", false);

					outputText("After hours of Akbal's long cat dick being slowly forced into your " + player.assholeDescript() + " your body gives out and you become too exhausted from the strain to even lift your arms. With a triumphant growl Akbal thrusts forward, his cock head spikes burying themselves into you but, without your resistance, they seem to vibrate inside you like twelve little beads massaging your innards. The sudden change makes you croon as you paw the ground with your hooves, suddenly desperate for more.", false);
				}
				//(Medium Pucker)
				else if (player.ass.analLooseness < 5)
				{
					outputText("Akbal begins to push into you, the barbs on his massive cock head causing you to wince as you are forcibly stretched. Without warning he forces the entirety of his massive length into you with a snarl. The initial incursion makes you grind your teeth as that spiked rod invades your " + player.assholeDescript() + ".  You widen your stance in an attempt to lessen the sudden slicing pressure created by the barbed cock head. The moment you do the barbs start to vibrate, beginning to feel more like humming sex beads than the wicked looking battering ram you know is inside you. You can't suppress the sudden sounds coming from your throat and exclaiming your ecstasy to your rapist.", false);
				}
				//(Gapping Pucker)
				//[hp heals 50% after this if that's ok with
				//you Fen]
				else
				{
					outputText("Akbal begins to push into you, the barbs on his massive cock head causing you to wince. He bottoms out instantly and you hear a pleased purr behind you. As he begins to pump his blood engorged sex organ in and out of your " + player.assholeDescript() + " with steadily mounting force you can't help but wonder why the barbs aren't causing you pain. You release a groan as those very barbs start to vibrate and begin feeling more like humming sex beads than punishing spikes.\n\n", false);

					outputText("Akbal snarls as he slams his hips into you, obviously happy that you're able to take his massive length. The demon appears to forget he's raping you and begins licking the back of your horse-like bottom half, sending shivers throughout your entire body as he roughly fucks you while painting your back with his saliva.", false);
				}
				player.buttChange(new Akbal().cockArea(0), true);
				outputText("\n\n", false);

				//(Ending)
				outputText("The entire length of Akbal's embedded cock begins to hum inside you, causing you to cry out as he picks up the pace. His every thrust is a hammer-like thump against your hungry cheeks. Without warning his thrusts become sloppy and you feel his giant tool swelling inside you, stretching you out even more.\n\n", false);

				outputText("Suddenly Akbal roars as he reaches his climax. You feel his giant cock hosing down your insides, filling you with his corrupted demon seed as he rides out his orgasm. His hips never stop. You feel your own orgasm rising to the surface only to suddenly fizzle out and you realize the corrupted seed inside you is actually stopping you from reaching climax. Akbal, however, sprays his spunk into your " + player.assholeDescript() + " again and again and never slows for a moment. Soon your stomach is obscenely swollen and you even taste cat jizz in your throat. Yet Akbal just keeps going, brutally fucking your helpless body and denying you release.\n\n", false);

				outputText("After hours of being his toy you pass out, never having reached your own orgasm.", false);
				dynStats("lust+",10 + player.lib / 10,"cor+",5 + rand(10));
				return;
				//Centaur over
			}
			if (player.ass.analLooseness < 3) //[Small/virgin pucker]
			{
				outputText("Akbal begins to push into you, the barbs on his massive cockhead causing you to howl as your " + player.assholeDescript() + " is forcibly stretched.  His jaguar claws grab your shoulders, and he uses your body as leverage to force his demonic erection into you.\n\n", false);
				outputText("The strain from Akbal's shoving makes you feel like you're going to pass out, yet the pain from his spiked sex organ keeps you conscious. After a while, you realize he's not even fucking you with his entire length; his swollen member is slowly forcing less than half its massive length into your " + player.assholeDescript() + ".\n\n", false);
				outputText("After what seems like hours of Akbal's long cat dick being slowly forced into your " + player.assholeDescript() + ", your body finally gives out. You've become so exhausted from the strain that you can barely even lift your arms.  With a triumphant growl Akbal thrusts forward, his cockhead spikes burying themselves into you.  Without your resistance, they seem to vibrate inside you like twelve little beads, massaging your innards.  The sudden change makes you croon as you widen your " + player.legs() + ", suddenly desperate for more.", false);
			} else if (player.ass.analLooseness < 5) //[Medium pucker]
			{
				outputText("Akbal begins to push into you, the barbs on his massive cockhead causing you to wince as are forcibly stretched.  Without warning, he forces the entirety of his massive length into you in with a snarl.  You almost pass out just from the initial incursion, but as he saws his length in and out, your body reacts of its own accord. You widen your " + player.legs() + " in an attempt to lessen the sudden slicing pressure created by the barbed cock head.  The moment you stop resisting, the barbs start to vibrate; they start to feel more like humming sex beads than the wicked-looking barbs you know are inside you.  You can't suppress the shuddering and groaning coming from your body as you are hit with a tidal wave of ecstasy.", false);
			}
			//[Gaping pucker]
			else
			{
				outputText("Akbal begins to push into you, the barbs on his massive cockhead causing you to wince.  He bottoms out near-instantly, and he looks up at you with a feral grin.  Akbal begins to pump his engorged sex organ in and out of your " + player.assholeDescript() + " with a steadily mounting force.  You release a groan as the barbs covering Akbal's long cat-dick start to vibrate and begin to feel more like humming sex beads than anything else.  You widen your " + player.legs() + " in response and Akbal snarls as he slams his hips into you, obviously happy that you're able to take his massive length.  The demon seems to forget that he's raping you; he starts giving your neck licks that send shivers throughout your entire body as he roughly fucks you into the forest floor.", false);
			}
			player.buttChange(new Akbal().cockArea(0), true);
			outputText("\n\n", false);

			outputText("Akbal's embedded cock begins to hum inside you, causing you to cry out as he picks up the pace.  His every thrust is a hammer-like thump against your spread " + player.legs() + ".  Suddenly his thrusts become sloppy, and you feel his giant tool swelling inside you, stretching you out even more.  Akbal roars as he reaches his climax, and you feel his giant cock hosing down your insides, filling you with his corrupted demon seed as he rides out his orgasm.  His hips never stop.  You feel your own orgasm rising to the surface, only to suddenly fizzle out.  It is with horror that you realize that the corrupted seed inside you is actually stopping you from reaching climax.  Akbal, however, sprays his spunk into your " + player.assholeDescript() + " again and again, not slowing for even a moment.  Soon your stomach is obscenely swollen, and you even taste cat jizz in your throat.  Yet Akbal just keeps going, brutally fucking you into the ground.\n\n", false);

			outputText("After hours of being his toy you finally pass out, never having reached your own orgasm.", false);
			dynStats("lust+",10 + player.lib / 10,"cor+",5 + rand(10));
		}

		//  AKBAL_TIMES_BITCHED:int = 902;

		//  AKBAL_BITCH_Q:int = 903;

		//Akbal of the Terrestrial Fire [EDITED]
		//2. AKBAL'S MY BITCH

		//[First Encounter]
		public function supahAkabalEdition():void
		{
			spriteSelect(2);
			//Make sure that the buttchange is set correctly
			//when submitting.  Gotta stretch em all!
			monster.createCock();
			monster.cocks[0].cockLength = 15;
			monster.cocks[0].cockThickness = 2.5;
			monster.cocks[0].cockType = CockTypesEnum.HUMAN;
			if (flags[kFLAGS.AKBAL_BITCH_Q] >= 2)
			{
				akbitchEncounter();
				return;
			}
			if (flags[kFLAGS.AKBAL_SUBMISSION_STATE] == 2)
			{
				repeatAkbalPostSubmission();
				return;
			}
			if (flags[kFLAGS.AKBAL_SUBMISSION_STATE] == 1)
			{
				ackbalRepeatAfterWin();
				return;
			}
			if (flags[kFLAGS.AKBAL_SUBMISSION_STATE] == -1)
			{
				ackbalRepeatAfterLoss();
				return;
			}
			clearOutput();
			//(Player should be level 4 or greater before encounter
			//chance is activated)
			outputText("As you are walking through the forest, a twig suddenly snaps overhead.  You quickly look up towards the source of the noise, only to be met by a pair of glowing emerald eyes hidden in the shadowed canopy of a tree.  A demonic force sweeps over you, keeping you frozen in place as a single jaguar paw emerges from the darkness.  The graceful killer stalks across the branch of its tree and soon is fully exposed to you.  Bathed in the sunlight filtering through the trees overhead, the creature holds you within its gaze – a gaze far too intelligent to belong to a mere wild animal.  A chorus of whispering voices tickles your ear, but too quietly for you to make out what is being said.\n\n", false);

			outputText("The jaguar blinks, releasing you from your trance, and the creature finally jumps down to the ground.  It widens its stance and unleashes a roar so loud that it seems to be coming from every direction at once, drowning out everything but the sound of your own heartbeat hammering away in the confines of your chest.\n\n", false);

			outputText("The creature circles you once before you hear a deep male voice rise amongst the chorus of whispers.\n\n", false);

			outputText("\"<i>I am Akbal, God of the Terrestrial Fire. You are trespassing on sacred ground... Submit, or die.</i>\"\n\n", false);

			outputText("The aura pouring forth from this 'Akbal' is anything but god-like; you recognize the demon for what it truly is.  Yet its ivory teeth and sharp claws prove to you that it can make good on its threat.  What do you do?", false);
			//Talk / Fight / Run
			simpleChoices("Talk", superAkbalioTalk, "Fight", startuAkabalFightomon, "", null, "", null, "Leave", camp.returnToCampUseOneHour);
		}

		//[Talk]
		private function superAkbalioTalk():void
		{
			spriteSelect(2);
			clearOutput();
			outputText("After a few moments of silence you ask, \"<i>What do you mean, 'submit'?</i>\" Akbal grins, revealing a row of wicked ivory teeth as he opens his mouth. You suddenly feel the demon's powerful body pinning you down, a wide tongue licking your neck and claws tickling your back in a way that is both horrifying and sensual. Yet after a moment of taking it in, you realize that he is still there in front of you, unmoved and grinning. You can guess what the image means: he wants you to become his mate for a day to make up for invading his territory.  What do you do?\n\n", false);

			//Submit / Fight
			simpleChoices("Fight", startuAkabalFightomon, "Submit", akbalSubmit, "", null, "", null, "", null);
		}

		//[Encounter if previously submitted]
		private function repeatAkbalPostSubmission():void
		{
			spriteSelect(2);
			clearOutput();
			outputText("As you walk through the forest, you hear a purring coming from behind you.  Turning around reveals that Akbal has come to find you.  He uses his head to push you in the direction of his territory, obviously wanting to dominate you again.\n\n", false);
			outputText("What do you do?", false);
			//Submit / Deny / Fight
			simpleChoices("Submit", akbalSubmit, "Deny", akbalDeny, "Fight", startuAkabalFightomon, "", null, "", null);
		}

		//[Deny]
		private function akbalDeny():void
		{
			spriteSelect(2);
			clearOutput();
			outputText("You shake your head and rub the lust-filled jaguar behind the ear as you tell him you're busy.  The demon's eyes roll, and he licks your " + player.leg() + " before his eyes find an imp in the trees above the two of you.\n\n", false);
			outputText("Knowing he's found a new toy, Akbal allows you to leave unmolested.", false);
			doNext(camp.returnToCampUseOneHour);
		}

		//[Encounter if previously fought and won/raped him]
		private function ackbalRepeatAfterWin():void
		{
			spriteSelect(2);
			clearOutput();
			outputText("As you walk through the forest, you hear a snarl and look up just in time to dodge a surprise attack by the jaguar demon, Akbal.  Your ", false);
			if (player.isTaur())
				outputText("four-legged leap places you a good distance away from him.  Do you fight or flee?\n\n", false);
			else
				outputText("dodging roll places you a good distance away from him.  Do you fight or flee?\n\n", false);
			//Fight / Flee
			simpleChoices("Fight", startuAkabalFightomon, "", null, "", null, "", null, "Leave", camp.returnToCampUseOneHour);
		}

		//[Encounter if previously fought and lost]
		private function ackbalRepeatAfterLoss():void
		{
			spriteSelect(2);
			clearOutput();
			outputText("A chorus of laughter sounds inside your mind as the jaguar demon, Akbal, drops to the ground in front of you.  His masculine voice says, \"<i>Well, if it isn't the defiant welp who, in all their great idiocy, has wandered into my territory again.  Will you submit, or do I have to teach you another harsh lesson?</i>\"\n\n", false);

			//Submit / Fight / Run
			simpleChoices("Submit", akbalSubmit, "Fight", startuAkabalFightomon, "", null, "", null, "Leave", camp.returnToCampUseOneHour);
		}

		//[Fight]
		private function startuAkabalFightomon():void
		{
			spriteSelect(2);
			clearOutput();
			outputText("You ready your " + player.weaponName + " and prepare to battle the demon jaguar.", false);
			//[battle ensues]
			startCombat(new Akbal());
			flags[kFLAGS.PLAYER_RESISTED_AKBAL]++;
		}

		//[Submit]
		private function akbalSubmit():void
		{
			spriteSelect(2);
			player.slimeFeed();
			flags[kFLAGS.AKBAL_SUBMISSION_COUNTER]++;
			flags[kFLAGS.AKBAL_SUBMISSION_STATE] = 2;
			flags[kFLAGS.AKBAL_BITCH_Q] = -1;
			//Big booty special
			if (flags[kFLAGS.AKBAL_SUBMISSION_COUNTER] > 5 && flags[kFLAGS.PLAYER_RESISTED_AKBAL] < 2 && player.buttRating >= 13 && player.tone < 80)
			{
				akbalBigButtSubmit();
				return;
			}
			clearOutput();
			//Naga variant goez here
			if (player.lowerBody == LOWER_BODY_TYPE_NAGA)
			{
				outputText(images.showImage("akbal-deepwoods-naga-sumbitanal"));
				outputText("After a few moments of thinking you nod to Akbal and the masculine voice in your head commands you to disrobe. You take off your " + player.armorName + ", setting it aside moments before the demon is upon you.\n\n", false);

				outputText("Akbal pushes you face first into the ground and places his forward paws on your back, pinning your chest against the ground. He removes the paw and you attempt to reposition yourself only to have your body pushed back down, a silent command for you to stay in this position.  You can't help but squirm a little as your bottom half is bunched up under your abdomen, putting your " + player.buttDescript() + " in the air.\n\n", false);

				outputText("His paws slide to your waist, melting into hands along the way. You look from beneath your arm and watch as Akbal's body changes, becoming more humanoid.  Once his transformation is complete he gets on his knees behind you and roughly pulls your upturned bottom half back.  When he shoves his face into your " + player.buttDescript() + " you flinch at the sudden and inexplicably erotic feeling.\n\n", false);

				outputText("He works his slippery wet tongue into your " + player.assholeDescript() + ", greedily lapping at your exposed backside as if it were a quickly-melting ice cream cone. The sensation causes you to groan as you push back against the tongue, suddenly lost in ecstasy. A part of your long tail wraps around his waist, holding him there as you revel in the sensation of being rimmed by a pro.  You even arch your back, allowing his long, thick jaguar tongue to penetrate deeper into your " + player.assholeDescript() + ". You feel his saliva, thick and warm like melted candy, sliding inside of you and coating your insides.\n\n", false);

				//(transition)
				outputText("A sudden warmth heats your innards, making you shiver in ecstasy.  Akbal takes a moment to uncoil your bottom half from around his chest before he rises to mount you. A single paw shoves your lifted chest and face back into the dirt, causing cold earth to cling to your body as Akbal gets into position above you.\n\n", false);

				//(Small/Virgin Pucker)
				if (player.ass.analLooseness < 3)
				{
					outputText("You feel him poking around your " + player.assholeDescript() + " and quickly realize his member is not only insanely large but its head is covered in a dozen tiny barbs. You grit your teeth, expecting pain and yet, thanks to the weird saliva he slathered your innards with, there is none as his gargantuan member forcibly widens your " + player.assholeDescript() + ".\n\n", false);

					outputText("The feeling of being stretched by Akbal's long, slimy member makes you shudder, the weird spit even heats up, creating a steamy warmth inside you as Akbal's equally hot member stretches you out and makes your body spasm slightly. After a few slow, shallow strokes you begin to feel the barbs vibrate. This vibrating drives you insane, and the wicked looking barbs feel more like humming sex beads than punishing spikes. When Akbal picks up the pace you grit your teeth as you are stretched beyond your natural limits.", false);
				}
				//(Medium Pucker)
				else if (player.ass.analLooseness < 5)
				{
					outputText("You feel him poking around your " + player.assholeDescript() + " and quickly realize his member is not only quite large but covered in almost a dozen tiny barbs. Yet, thanks to the weird spit he slathered your innards with, there is none as his gargantuan member forcibly widens your " + player.assholeDescript() + ".\n\n", false);

					outputText("Akbal's titanic member stretches your " + player.assholeDescript() + " and makes you groan beneath him, reveling in the slick heat and fullness of your bowels. His saliva heats up, creating a steamy,pleasurable warmth inside your body. As he begins to pump his huge sex organ in and out of you the barbs covering his head begin to vibrate and hit your body with tidal waves of unbearable pleasure, feeling more like vibrating sex beads than punishing spikes. Your body begins to act of its own accord, your " + player.buttDescript() + " grinding against his thrusts as his large sex pump slides in with his trunk slamming into your " + player.buttDescript() + " in rhythmic, echoing claps.", false);
				}
				//(Gapping Pucker - Akbal's dick = 15 inches)
				else
				{
					outputText("You feel him poking around your " + player.assholeDescript() + " and quickly realize his member is not only quite large but covered in almost a dozen tiny barbs. When Akbal begins to penetrate you he is surprised when his trunk suddenly slams into your " + player.buttDescript() + ", the sudden invasion causing you to croon.\n\n", false);

					outputText("The weird spit he slathered your insides with begins to heat up instantly and the barbs covering his cock head start vibrating. The sensation of the vibrating barbs is like a dozen small slimy sex beads spinning and shaking as they are pushed inside you. Akbal wastes no time and begins forcibly fucking your " + player.assholeDescript() + " with reckless abandon, his every brutal thrust causing your body to slide forward through the dirt. You try to meet his deep thrusts but the jaguar fucks you with speed and force befitting a cheetah and the constantly vibrating barbs make your body shiver with each hammer blow to your insides.", false);
				}
				player.buttChange(monster.cockArea(0), true);
				outputText("\n\n", false);

				//(ending)
				outputText("Akbal works his hips fast, piston-pumping his long demon-cat dick in and out of your " + player.assholeDescript() + ". Your voice rises and falls with his frantic thrusts. Your body is racked by orgasm after orgasm and soon you're lying on your chest and knees in a pool of your own love juices.\n\n", false);

				outputText("Akbal releases a harsh growl and you feel the large feline member twitching and swelling inside you. A growl sounds in your own chest as the hot, corrupted seed of the demon cat shoots into you. Despite having reached his climax the jaguar's piston-pumping doesn't slow until he's erupted no less than six times, masterfully working your hole the entire time.\n\n", false);

				outputText("After his last massive eruption you feel the jaguar demon pull out, releasing even more of his copious loads from your happy hole in an oddly satisfying cascade of thick white cream that rushes like a waterfall down your body.\n\n", false);

				outputText("The jaguar demon no longer seems to mind your presence in his territory as he drapes his tired body over yours and the two of you fall into a sex-induced coma.", false);
				//[+ 4-12 Corruption]
				dynStats("cor", 4 + rand(8));
				//[+ 1-2 Speed]
				dynStats("spe", 1 + rand(2));
				player.orgasm();
				//[Chance of butt growth]
				if (player.buttRating < 8)
				{
					outputText("\n\nIn your sleep, your ass plumps up slightly, growing to accomodate the demon's wishes...", false);
					player.buttRating++;
				}
				player.createStatusEffect(StatusEffects.PostAkbalSubmission, 0, 0, 0, 0);
				doNext(camp.returnToCampUseEightHours);
				return;
			}
			//Taur variant goez here
			if (player.isTaur())
			{
				outputText(images.showImage("akbal-deepwoods-taur-sumbitanal"));
				outputText("After a few moments of thinking you nod to Akbal.  The deep voice in your head commands you to disrobe.  You take off your " + player.armorName + ", setting it aside while mentally preparing yourself for whatever this demon has in mind.\n\n", false);

				outputText("You watch with fascination as Akbal rises onto his hind legs, his body melting into a more humanoid form.  His long, demonic cat-dick is already rock-hard and jutting out of his sheath.  He walks past your top half, moving around your body while sliding his hand across your haunch.  His hands are oddly warm.", false);

				//(if centaur player has a tail)
				if (player.tailType > TAIL_TYPE_NONE)
					outputText("  As he makes his way to your hind quarters he grabs you by the tail, pulling it up and out the way with a feral, jaguar grin.  His free hand slides a finger across your " + player.assholeDescript() + " making you paw the ground with your hooves.", false);

				//(No tail)
				else
					outputText("  As he makes his way to your hind quarters he grabs your " + player.buttDescript() + ", groping the mass of flesh with one hand and sliding a finger across your exposed " + player.assholeDescript() + ", making you paw the ground with your hooves.", false);
				outputText("\n\n", false);
				//(Transition)

				outputText("The jaguar demon begins pushing you forward with his powerful hips, his demon-cat-dick sliding up the crevice of your " + player.buttDescript() + ".  He steers you towards a tree, forcing you chest-first against the rough bark.\n\n", false);

				outputText("Looking back you watch Akbal bend low, losing sight of the jaguar demon as he disappears behind you.  For a moment you wonder what he's doing but soon you feel him shove his face into your " + player.buttDescript() + " with a snarl.  He begins working his slippery wet tongue into your " + player.assholeDescript() + ", greedily lapping at your exposed backside as if it were a quickly-melting ice cream cone.  The sensation causes you to groan and grind against the tongue, suddenly lost in ecstasy.  You are surprised at the strength in the demon's neck as he smashes your body against the tree with nothing but his mouth.  You feel his saliva, thick and warm like melted candy, sliding inside of you and coating your insides.", false);
				//(If Player has Vagina)
				if (player.hasVagina())
					outputText("  Akbal slurps his way down to your " + player.vaginaDescript(0) + " twisting his face and drilling his tongue into you, mercilessly attacking your " + player.clitDescript() + " as you scream, howl, and cringe in ecstasy.  He then uses his lips to gently suck your " + player.clitDescript() + " into his mouth and twirl his tongue on it, making your grind your swollen sex against his jaguar lips.", false);
				//(If Player has balls)
				if (player.balls > 0)
					outputText("  Akbal slurps his way down to your " + player.sackDescript() + " where he slathers his thick, heated saliva over your orbs, making you groan as your sensitive " + player.ballsDescriptLight() + " are teased and gently juggled by Akbal's masterful tongue.  He sucks both orbs into his mouth.  The sensation sends your eyes to the back of your skull and makes your entire body shiver.", false);
				//(transition)
				outputText("  Once his oral machinations are finished a sudden warmth heats your innards, making you shiver in ecstasy as the demon rises to mount you.\n\n", false);

				//(Small/Virgin Pucker)
				//[Small/virgin pucker]
				if (player.ass.analLooseness < 3)
				{
					outputText("You feel him poking around your " + player.assholeDescript() + " and quickly realize his member is not only insanely large but its head is covered in a dozen tiny barbs.  You grit your teeth, expecting pain and yet, thanks to the weird saliva he slathered your innards with, there is none as his gargantuan member forcibly widens your " + player.assholeDescript() + ".\n\n", false);
					outputText("The feeling of being stretched by Akbal's long, slimy member makes you shudder.  The weird spit even heats up which creates a steamy warmth inside you as Akbal's hot member makes your body spasm slightly.  After a few slow, shallow strokes you begin to feel the barbs vibrate.  This vibrating sends your body into convulsions, the wicked-looking barbs feel more like humming sex beads than punishing spikes.  When Akbal picks up the pace you grit your teeth as you are stretched beyond your natural limits.", false);
				}
				//(Medium Pucker)
				else if (player.ass.analLooseness < 5)
				{
					outputText("You feel him poking around your " + player.assholeDescript() + " and quickly realize his member is not only quite large but covered in almost a dozen tiny barbs.  Yet,  thanks to the weird spit he slathered your innards with, there is none as his gargantuan member forcibly widens your " + player.assholeDescript() + ".\n\n", false);
					outputText("Akbal's titanic member stretches your " + player.assholeDescript() + " and makes you groan and claw at the tree he has you pressed against, reveling in the slick heat and fullness of your bowels.  His saliva heats up, creating a steamy yet pleasurable warmth inside your body.  As he begins to pump his huge sex organ in and out of you the barbs covering his head begin to vibrate and hit your body with tidal waves of unbearable pleasure, feeling more like vibrating sex beads than punishing spikes.  You lean back into his thrusts as his trunk begins slamming into your " + player.buttDescript() + " in rhythmic claps that echo throughout the forest.", false);
				}
				//(Gapping Pucker - Remember Akbal's dick is 15 inches)
				else
				{
					outputText("You feel him poking around your " + player.assholeDescript() + " and quickly realize his member is not only quite large but covered in almost a dozen tiny barbs.  When Akbal begins to penetrate you he groans in surprise as his large dick sinks into your " + player.buttDescript() + " easily, the sudden invasion causing you to croon.\n\n", false);
					outputText("The weird spit he slathered your insides with begins to heat up instantly and the barbs covering his cock head start vibrating.  The sensation is like a dozen small slimy sex beads spinning and shaking as they are pushed inside you.  Akbal wastes no time and begins forcibly fucking your " + player.assholeDescript() + " with reckless abandon, his every brutal thrust causing the tree you're shoved up against to shake back and forth.  You try to meet his deep thrusts but the jaguar fucks you with speed and force befitting a cheetah and the constantly vibrating barbs make your body shiver with each hammer blow to your insides.", false);
				}
				player.buttChange(monster.cockArea(0), true);
				outputText("\n\n", false);

				//(ending)
				outputText("Akbal works his hips fast, piston-pumping his long demon-cat dick in and out of your " + player.assholeDescript() + ".  Your body is racked by orgasm after orgasm and soon the ground beneath your pawing hooves is covered in a thick layer of your own love juices.  Then Akbal releases a harsh growl and you feel the large feline member twitching and swelling inside you.  A growl sounds in your own chest as the hot, corrupted seed of the demon cat shoots into you.  The feeling of the hot, wet warmth being fucked deeper into you is so close to supreme bliss you can scarcely tell the difference.\n\n", false);

				outputText("After a few moments you realize Akbal isn't slowing down.  His piston pumping hips drive right through his orgasm and never stop slamming into your " + player.buttDescript() + ".  He continues until he's erupted no less than eight times, masterfully working your hole the entire time.\n\n", false);

				outputText("After his last massive eruption you feel the jaguar demon pull out, releasing even more of his copious load from your happy hole in an oddly satisfying cascade of thick white cream that rushes like a waterfall down your legs", false);
				if (player.totalCocks() > 0)
					outputText(" to join your own", false);
				outputText(".\n\n", false);

				outputText("You close your eyes, willingly falling into a sex induced sleep.", false);
				//[+ 4-12 Corruption]
				dynStats("cor", 4 + rand(8));
				//[+ 1-2 Speed]
				dynStats("spe", 1 + rand(2));
				player.orgasm();
				//[Chance of butt growth]
				if (player.buttRating < 8)
				{
					outputText("\n\nIn your sleep, your ass plumps up slightly, growing to accomodate the demon's wishes...", false);
					player.buttRating++;
				}
				player.createStatusEffect(StatusEffects.PostAkbalSubmission, 0, 0, 0, 0);
				doNext(camp.returnToCampUseEightHours);
				return;
			}

			outputText(images.showImage("akbal-deepwoods-sumbitanal"));
			outputText("After thinking for a minute, you nod to Akbal.  The deep voice in your head commands you to disrobe.  You obediently take off your " + player.armorName + " and set it aside just before the demon is upon you.\n\n", false);

			outputText("Akbal pushes you face-first into the ground and places his forward paws on your back, pinning your chest against the ground.  He removes them after a few seconds and you attempt to reposition yourself, only for you to be pushed back down again: a silent yet forceful command for you to stay in this position.\n\n", false);

			outputText("His paws slide to your waist, changing into hands along the way.  You look back and watch as his body starts morphing into a more humanoid shape, his muscles shifting themselves beneath his skin as his body changes to something better suited to dominate you.\n\n", false);

			outputText("He suddenly yanks your upturned bottom half toward himself and shoves his face into your " + player.buttDescript() + ".  His slippery wet tongue begins to work its way into your " + player.assholeDescript() + ", greedily lapping at your exposed backside as though it were a quickly-melting ice cream cone.  The sensation causes you to groan and grind against the tongue, quickly losing yourself into ecstasy.  You spread your " + player.legs() + " and arch your back, allowing his long and thick jaguar tongue to drill deeper into your " + player.assholeDescript() + ".  You feel his thick and warm saliva sliding into you and coating your insides.\n\n", false);

			//[Player has a vagina]
			if (player.hasVagina())
			{
				outputText("Akbal slurps his way down to your " + player.vaginaDescript(0) + ", twisting his face and drilling his tongue into you, mercilessly attacking your " + player.clitDescript() + " as you scream, howl and cringe from the stimulation.  He then gently sucks your " + player.clitDescript() + " into his mouth and twirls his tongue around it, making you grind your swollen sex against his jaguar lips.  ", false);
			}
			//[Player has balls]
			else if (player.balls > 0)
			{
				outputText("Akbal slurps his way down to your " + player.sackDescript() + ", slathering his heated saliva over your orbs and making you groan as your sensitive " + player.ballsDescriptLight() + " are teased and gently juggled by Akbal's masterful tongue.  Your body continually twitches with pleasure from the sensations.  ", false);
			}

			outputText("His oral ministrations end when a sudden warmth heats your innards, and you shiver in ecstasy as the demon rises to mount you.  A single paw-like hand shoves your lifted chest and face back into the dirt, causing cold earth to cling to your face as Akbal gets into position above you.\n\n", false);

			outputText("You feel him poking around your " + player.assholeDescript() + ", learning quickly that not only is his member insanely large, but its head is covered in dozens of tiny barbs.  ", false);
			//[Small/virgin pucker]
			if (player.ass.analLooseness < 3)
			{
				outputText("You grit your teeth, expecting pain. However, thanks to the weird saliva he slathered your innards with, you feel none as his gargantuan member forcibly widens your " + player.assholeDescript() + ".", false);
				player.buttChange(monster.cockArea(0), true);
				outputText("\n\n", false);

				outputText("Being stretched by Akbal's long and slick member makes you shudder. The weird spit even begins to heat up, creating a steamy warmth inside you as Akbal's equally hot member stretches you out, your body spasming slightly in response.  After a few slow and shallow strokes, you can feel the barbs begin to vibrate.  The sudden motion sends your body into convulsions, the wicked-looking barbs acting more like humming sex beads than barbs.  When Akbal picks up the pace, you can only grit your teeth harder as you're stretched more and more beyond your natural limits.\n\n", false);
			}
			//[Medium Pucker]
			else if (player.ass.analLooseness < 5)
			{
				outputText("Thanks to the weird saliva he slathered your innards with, you feel no pain as his gargantuan member forcibly widens your " + player.assholeDescript() + ".", false);
				player.buttChange(monster.cockArea(0), true);
				outputText("\n\n", false);

				outputText("Akbal's titanic member stretching your " + player.assholeDescript() + " makes you groan beneath him, reveling in the slick heat and the fullness of your bowels.  His saliva heats up, creating a steamy and pleasurable warmth inside your body.  As he begins to pump his huge member in and out of you, the barbs covering his head begin to vibrate.  Your body is hit with waves of unbearable pleasure, the wicked-looking barbs acting more like humming sex beads than barbs.  Your body begins to act of its own accord; your " + player.buttDescript() + " grinds against his thrusts as his large sex slides in, his trunk slamming into your " + player.buttDescript() + " with rhythmic claps that echo throughout the forest.\n\n", false);
			}
			//[Gapping Pucker - Remember Akbal's dick is 15 inches]
			else
			{
				outputText("As Akbal begins to penetrate you, he groans in surprise at how easily his large dick sinks into your " + player.buttDescript() + ", and the sudden invasion causes you to croon.\n\n", false);

				outputText("The weird spit he slathered your insides with instantly heats up, and the barbs covering his cock head suddenly start vibrating.  The vibrating barbs feel like slimy sex beads, spinning and shaking as they are pushed inside you.  Akbal wastes no time and begins forcibly fucking your " + player.assholeDescript() + " with reckless abandon, his every brutal thrust causing your body to slide forward through the dirt.  You try to meet his deep thrusts, but the jaguar is fucking you with speed and force befitting a cheetah. The constantly vibrating barbs make your body shiver with each hammering blow to your insides.\n\n", false);
			}

			outputText("Akbal works his hips fast, piston-pumping his long demon cat-dick in and out of your " + player.assholeDescript() + ".  The rampant babbling coming from your mouth breaks with his every thrust, and your body is racked by orgasm after orgasm. You're soon on your chest and knees ", false);
			if (player.hasVagina() || player.totalCocks() > 0)
				outputText("in a pool of your own love juices", false);
			else
				outputText("in sexual bliss", false);
			outputText(".\n\n", false);

			outputText("Akbal releases a harsh growl and you feel his large feline member twitch and swell inside you.  You let out a growl of your own as the hot, corrupted seed of the demon cat shoots into you.  Feeling the hot, wet warmth being fucked deeper into you is so close to supreme bliss that you can scarcely tell the difference.\n\n", false);

			outputText("After the sensation begins to settle, you realize Akbal isn't slowing down.  His hips carry on with their pistoning right through his orgasm and continually slam into your " + player.buttDescript() + ".  He persists until he's erupted no less than eight times, masterfully working your hole the entire time.\n\n", false);

			outputText("After his final massive eruption, the jaguar demon pulls out. His copious load is released from your happy hole in an oddly satisfying cascade of thick white cream, rushing like a waterfall down your " + player.legs() + ".\n\n", false);

			outputText("The jaguar demon no longer seems to mind your presence in his territory as he drapes his body over yours, and the two of you fall into a sex-induced sleep.", false);

			//[+ 4-12 Corruption]
			dynStats("cor", 4 + rand(8));
			//[+ 1-2 Speed]
			dynStats("spe", 1 + rand(2));
			player.orgasm();
			//[Chance of butt growth]
			if (player.buttRating < 8)
			{
				outputText("\n\nIn your sleep, your ass plumps up slightly, growing to accomodate the demon's wishes...", false);
				player.buttRating++;
			}
			player.createStatusEffect(StatusEffects.PostAkbalSubmission, 0, 0, 0, 0);
			doNext(camp.returnToCampUseEightHours);
		}

		//[General End]
		//Set flag after submitting, then clear it and run
		//this before going to camp?
		public function akbalSubmissionFollowup():void
		{
			spriteSelect(2);
			clearOutput();
			if (flags[kFLAGS.AKBAL_SUBMISSION_COUNTER] < 4)
			{
				outputText("You awake in your camp feeling dangerous, powerful and fiercely satisfied.", false);
			}
			//[After 8th submission, if whispered and corruption is greater than 80%]
			//(fighting Akbal disables this scene, but you retain the ability if you rape him after)
			else if (flags[kFLAGS.PLAYER_RESISTED_AKBAL] == 0 && flags[kFLAGS.AKBAL_SUBMISSION_COUNTER] >= 8 && player.cor > 80)
			{
				if (player.cor < 80 || player.findPerk(PerkLib.FireLord) >= 0)
				{
					outputText("You awake in your camp feeling dangerous, powerful and fiercely satisfied.", false);
				}
				else
				{
					outputText("You open your eyes and almost yell in surprise when you see Akbal's emerald eyes looking into yours.  You are still in the forest and his lithe jaguar body is still over you; you quickly realize he hasn't moved you, as you're still resting in a puddle of mixed sex juices.\n\n", false);
					outputText("\"<i>You are a loyal pet,</i>\" Akbal says as he stands. The compliment makes you smile, but it quickly fades into a look of fear when he suddenly releases a bone-chilling roar right in your face.  Green flames begin to pour from his open maw, and you scream as you flail your hands in a pointless attempt to block the fire.\n\n", false);
					outputText("After a moment of horror, you realize you aren't burning.  You can feel the emerald flames inside your lungs, glowing with a palpable warmth.  Akbal snaps his teeth together, a feral grin on his face as he halts the torrent of flame.\n\n", false);
					outputText("You can feel Akbal's demonic presence inside your lungs, slowly building up until it finally explodes out of your open mouth in a titanic roar, accompanied with a jet of emerald flame.\n\n", false);
					outputText("(You are now capable of breathing Akbal's fire.)", false);
					//['LOTF' or 'Terrestrial Fire Lord' appears as perk]
					//[Gain 'Terrestrial Fire' in Specials]
					player.createPerk(PerkLib.FireLord, 0, 0, 0, 0);
				}
			}
			//[After 4th submission if corruption is greater than 40%]
			else if (player.findPerk(PerkLib.Whispered) < 0 && player.cor >= 40)
			{
				outputText("You awake in your camp with Akbal standing over you, the chorus of voices in your head reaching the apex of an agonizingly beautiful song, and then falling silent.  When you rise, Akbal licks your face before turning away and sprinting into the forest.\n\n", false);
				if (player.findPerk(PerkLib.Whispered) < 0)
				{
					outputText("(You are now Whispered.)", false);
					player.createPerk(PerkLib.Whispered, 0, 0, 0, 0);
						//['Whispered' appears as perk]
						//[Gain 'Whisper' in Specials]
				}
			}
			else
				outputText("You awake in your camp feeling dangerous, powerful and fiercely satisfied.", false);
			doNext(playerMenu);
		}

		/*
		   [Items]
		   [Jaguar Pelt]
		   The pelt of a Jaguar demon.  It's surprisingly durable and flexible.
		   (maybe have the alchemist or that shop guy offer to turn it into armor)

		   [Demon Jaguar Cloak]
		   Def + 2
		   Speed +10
		   Evasion+5
		 */

		private function akbalBigButtSubmit():void
		{
			clearOutput();
			outputText(images.showImage("akbal-deepwoods-bigbuttanaled"));
			outputText("Smiling in anticipation of servicing the jaguar-lord once more, you remove your [armor] and drop down to all fours, slowly lowering your face down to the ground.  You give your [butt] a slow back-and-forth wiggle as your cheek comes to rest on the dirt, degrading yourself for your demon-god's enjoyment.");
			outputText("\n\nA deep-timbred voice resounds through your open mind, purring, \"<i>A suitable offering.</i>\"  The pleased undertones leave no doubt as to your feline master's opinion - he likes how you look back there.  The panther's softly-padded paws land on your [butt] almost immediately, though as they squeeze and explore the spacious expanse, they gradually twist and lengthen, forming into human digits.  Bones crack and tendons creak as the angle of Akbal's butt-groping pressure changes, suggesting a taller, bipedal shape.  You flick your eyes down submissively, but for a second, you get to see your panther-lord looming over you, fascinated by your bubbly butt.  His body is muscular and toned, sheathed in a veneer of silky black fur that shines like oil.  He is, in a word, glorious.");
			outputText("\n\nA psychic snarl of approval echoes through your skull as Akbal nestles himself between the comfy cushions you've offered him, opening his maw to lap at your [asshole]");
			if (player.balls > 0)
				outputText(" and [balls]");
			else if (player.hasVagina())
				outputText(" and [vagina]");
			outputText(".  You cannot help but squirm from the attention, feeling the slippery-hot length of his muscle probing your sensitive ring.  In its wake, the panther's flexible tongue leaves behind copious amounts of his slick saliva that makes your skin tingle pleasantly.  You don't have long to wonder at this as he broadens his roving attentions to slather each of your cheeks with love, licking and lapping over your " + player.skinFurScales() + " in what could only be described as worship.  A tremor of gleeful pride works through your mind - your master approves of his servant's body!");
			outputText("\n\nWith your ass in the air, you pant in relaxed pleasure, allowing Akbal to work your [butt] into a glorious shine.  Only after every inch of your pillowy derriere has been slathered with panther-spit does he return to his real intent, spreading your cheeks wide to expose your saliva-glossed asshole.  Your pucker twitches hungrily, tingling from your god's perverse fluids, sensitive and desirous of affection.  He does not deny your body's unspoken request, and the long, wriggling tongue slides through, twisting into your back door to deck your interior with more of his lovely juices.  You cannot help but moan at this - it feels better than it should, like a hot, slippery massage for your insides.");
			if (player.hasCock())
				outputText("  Bobbing beneath you, [eachCock] makes no secret of how much you're enjoying this, with thin drops of pre-cum dangling precariously below.");
			else if (player.hasVagina())
				outputText("  Your vulva have long since grown bigger and puffier, visibly aroused and glistening with the moisture of your lust.");
			outputText("\n\nThat tongue goes so deep inside you that after a moment, you stop trying to judge just how far he's going.  Who are you to question HIM?  Your [asshole] is his to do with as he pleases, and the thought brings a happy squeeze through the muscles of your heiny.  His fingers squeeze and caress the feast of butt that you've placed before him, kneading as he licks and kisses, slobbering more and more of his bubbly, tingly spit everywhere.  It feels so good that it robs the strength from your [legs], but you fight to stay upright, trembling.  You must continue to present yourself to him!  That thought, alien as it seems at first, feels too right to resist, and you do as you always do with your lord - obey.");
			outputText("\n\nOnce he sees your [legs] shaking, Akbal gives your [asshole] a kiss and retracts his tongue, leaving you achingly empty, void of anything but a tingle and a hunger for something to enter you.  He does not keep you waiting.  Strong hands sink into the dirt on either side of you, and tufts of his fur skim along your moistened backside as he gets in position.  You shiver again, not struggling to remain ass-up as before, but in eagerness.  Something hot, something simply wondrously warm, presses up against you.  Every single nerve in your [butt] is demanding you push back and take him, smother him with your plush posterior.  You know what is expected of you, however.  You are his to claim, to take, and you will await his pleasure.");
			outputText("\n\nAkbal gives a few gentle pokes and prods, testing you, or perhaps, simply enjoying the feel of his barbed girth sliding through the slobbery valley of your butt-cleavage.  In any case, you wait for your god to finish, and he rewards you.  Throbbingly thick panther-cock plunges into your [asshole], sliding through your spit-soaked ring with ease.  The barbs that cover his cock don't hurt in the slightest, softening as they contact his spit so that they become little more than nubs of pleasure - the prize for obedience.  You moan, low and loud as you are taken, and soon, his furry sack comes to rest on your backside, his length hilted within.  Your rump tingles with the thrill of it all, hot and warm from his corrupt saliva and gleefully massaging his member with instinctive, muscular contractions throughout.");
			player.buttChange(16, true, true, false);
			outputText("\n\nYour eyes cross as you give yourself over to your fiery lord, lost in the sensation of being taken.  Part temple and part sex toy, your body is now his, and you love it.");
			if (player.hasCock())
				outputText("  [EachCock] is drooling freely by this point, and though Akbal doesn't bother to touch, the feeling of his warm pole inside you seems to reach all the way to your [cockHead].");
			else if (player.hasVagina())
				outputText("  Your [vagina] is dripping freely by this point, and though Akbal doesn't bother with it, the feelings radiating from his warm pole seem to reach all the way through your pulsing pussy to your [clit], rigid and soaked as it is.");
			outputText("  Suddenly, that blessed tool departs from your over-sensitive innards, only to return a moment later, plunged back in with a firm, measured stroke.   You squeal as another precision stroke of the demonic jaguar shaft bottoms out into your [asshole] once more, the thrust teasing an orgasm from your pleasure wracked body");
			if (player.hasCock())
			{
				outputText(", your [cock] freely unleashing its load into the mud beneath you and tainting the ground with your wasted cum");
				if (player.cumQ() >= 500)
				{
					outputText(" as it puddles around you");
					if (player.cumQ() >= 1000)
					{
						if (player.cumQ() < 3000)
							outputText(" into a small lake");
						else
							outputText(" into a deep, slimy morass");
					}
				}
			}
			else if (player.hasVagina())
			{
				outputText(", ");
				if (player.wetness() >= 4)
					outputText("squirting ");
				else
					outputText("leaking ");
				outputText("into the dirt until it stinks of your pussy");
			}
			outputText(".");

			outputText("\n\nAkbal groans but does not release, not yet.  He simply continues to take you, fucking you with force but not violently, firmly asserting his dominance over you.  You're kept in a heaven of anal sensation, shaking and orgasming over and over but never truly released.  The panther gradually increases his tempo as time passes; soon he has you babbling in happiness, mindlessly praising your lord and master as he plumbs your soaked buns with expert thrusts.  Your face is dragged back and forth across the forest floor as he takes you with firmer and firmer motions, then, breathing a gout of fire above your head, Akbal blesses your [butt] with his climax.");
			outputText("\n\nThe first jet of his hot, corrupted seed has you shaking and cumming all over again, even harder than the first time.  His jizz surges through your [asshole] while his barbs begin to vibrate.  It's too much for you to take, and you cease your babbling to drool in vacant delight");
			if (player.hasCock())
				outputText(", barely noticing when a fresh wave of your own spunk slops into your mouth");
			outputText(".  You cum and cum, caught up in the rush of taking in Akbal's seed.  It seems to fill your body and soul, flooding anus and mind with hot, corrupted bliss.  Twice... thrice... four times... he just keeps firing more thick seed into you.  The fifth blast has you feeling full of it.  The sixth makes your gut distend slightly.  The seventh bloats you further and squirts from your [asshole] to soak butt and crotch-fur alike.  The eight is the largest and last, flooding you completely with your lord's essence.  It inflates your belly into a rounded sperm tank.  When he pulls back, a river of it washes out, and you cum again.");
			outputText("\n\nSated, you're lifted up and moved to a ");
			if (player.hasCock() && player.cumQ() >= 1000)
				outputText("dry, ");
			outputText("comfortable place.  Akbal wraps his arms around you, though one steals a quick squeeze of your [butt].  Invigorated by this, he docks his cat-cock back inside your spunk-oozing asshole to plug it and snuggles up to you.  You fall asleep like that, dreaming of him taking you again and again.");
			if (player.buttRating < 20)
			{
				outputText("  Tingling in your sleep, your [butt] bulges slightly as it grows bigger, changed by Akbal's saliva to serve him even more capably.");
				player.buttRating++;
			}
			else if (player.tone > 30)
			{
				outputText("  Tingling in your sleep, your [butt] jiggles slightly as it softens along with the rest of your body, changed by Akbal's saliva to be a softer, more pleasant fuck.");
				player.modTone(30, 5);
			}
			player.orgasm();
			dynStats("cor", 5);
			player.slimeFeed();
			player.createStatusEffect(StatusEffects.PostAkbalSubmission, 0, 0, 0, 0);
			doNext(camp.returnToCampUseEightHours);
		}

		//2. AKBAL'S MY BITCH
		//By Foxxling
		//Akbal’s My Bitch Expansion
		//Auto Rape Intro Scene
		private function akbitchEncounter():void
		{
			clearOutput();
			outputText("As you explore the deep woods you begin to hear a soft slurping sound. In this world you know that any strange sound, especially the wet ones, most likely means something dangerous is up ahead... or something dangerous is fucking something a little less dangerous.  As you cautiously advance you spy the pelt of the jaguar demon, Akbal.  The demon jaguar sits in the middle of the clearing with one leg extended as he repeatedly swipes his wide tongue against his hole, probably cleaning up imp spunk thanks to you.  He is so utterly focused on the task that he doesn’t notice your approach.");
			flags[kFLAGS.AKBAL_BITCH_Q] = 1;
			//{corruption < 40/choose no}
			if ((player.cor < 40 && flags[kFLAGS.MEANINGLESS_CORRUPTION] <= 0 && player.findPerk(PerkLib.Pervert) < 0 && player.findPerk(PerkLib.Sadist) < 0) || player.lust < 33)
				akbitchNoThnx(false);
			//{corruption > 40}
			else
			{
				outputText("\n\nDo you take advantage of him again?");
				menu();
				addButton(1, "No", akbitchNoThnx);
				addButton(0, "Yes", takeAdvantageOfAkbitch);
			}
		}

		private function akbitchNoThnx(clear:Boolean = true):void
		{
			if (clear)
				clearOutput();
			else
				outputText("\n\n");
			outputText("You turn back, allowing the demon to finish cleaning himself and thankful he didn’t ambush you this time.");
			if (player.lust < 33)
				outputText("  Besides, you aren't aroused right now, anyway.");
			doNext(camp.returnToCampUseOneHour);
		}

		//{Choose Rape}
		public function takeAdvantageOfAkbitch():void
		{
			clearOutput();
			outputText("You creep behind the many woods trees surrounding Akbal’s clearing until your eyes chance upon a vine.  It’s spongy, long, and hard to rip apart - in other words: perfect.");

			//{if player has feet/centaur}
			if (!player.isNaga())
				outputText("\n\nYou walk on silent [feet] towards Akbal, tying a knot to turn your vine into a lasso.");
			else
				outputText("\n\nYou silently slither towards your prey, tying a knot to turn your vine into a lasso.");

			outputText("\n\nOnce you’re in range, you take the vine in your hand and tackle the unsuspecting demon’s back with a snarl.");

			//(strength < 50)
			if (player.str < 50)
			{
				outputText("\n\nA gout of green fire roars into existence.  The suddenly intense heat causes you to flinch away from the inferno nearly encasing your [face].  The jaguar demon slips your grasp, and when you look up, another green fireball is coming your way.  Looks like you have a fight on your hands.\n\n");
				//(Enter battle with clearscreen and fireball attack.)
				var akbal:Akbal = new Akbal();
				startCombat(akbal);
				akbal.akbalSpecial();
				return;
			}
			//{strength > 50}
			outputText("\n\nA gout of green fire roars into existence.  With little effort, you slam Akbal’s head into the ground. The plume of emerald fire roars across the forest floor, burning nothing but vegetation and bugs. While holding him down with your body and one hand, you grab your vine.  After tying the demon’s arms together, his body begins to shift beneath you, becoming the humanoid form you have come to associate with his aroused state.  Despite the ferocity with which he struggles, you can plainly see he is turned on.  Thanks to his slim build, it's easy for you to out-muscle him. You can almost ignore the way he keeps bucking, trying to throw you off, and keep him pinned.");

			//{Intelligence < 60}
			if (player.inte < 60)
			{
				outputText("\n\nAkbal suddenly stops struggling and you hear someone shout your name.  As you look away Akbal rolls from beneath you.  A blast of terrestrial ignites the vines and he lunges at you, his claws extended.\n\n");
				//(fight - clearscreen and enemyattack)
				startCombat(new Akbal());
				monster.eAttack();
				return;
			}
			//{intelligence > 60}
			outputText("\n\nAkbal suddenly stops struggling and you hear someone shout your name. You smile, knowing the voice is Akbal’s attempt to distract you.  Ignoring his desperate ploy, you grab the demon by the shoulders and slam him into the ground.  He struggles, you push him down again.  After throwing a fit of swearing and cursing, he goes limp.  Accepting his fate, he tells you to get on with it.  With his arms still behind his back, you tie a portion of the vine around his neck like a collar and leave the rest hanging from the main part, resembling a leash.  This is going to be fun.");

			flags[kFLAGS.AKBAL_TIMES_BITCHED]++;
			menu();
			addButton(0, "Normal", basicAkbitchScene);
			//AMB Strength Scene
			//70+
			if (player.str >= 70)
				addButton(1, "Strong", akbitchHighStrengthVariant);
			//AMB Speed Scene
			//70
			if (player.spe >= 70)
				addButton(2, "Fast", akbalBitchSpeed);
			//AMB Toughness Scene
			//70
			if (player.tou >= 70)
				addButton(3, "Toughness", akbitchToughness);
		}

		//Basic AMB Scene (no +70 stats)
		private function basicAkbitchScene():void
		{
			clearOutput();
			outputText("With a grin, you tug on Akbal’s collar, and he lets out a barely suppressed purr.  ");
			if (flags[kFLAGS.AKBAL_TIMES_BITCHED] == 1)
				outputText("The smile on your [face] spreads even wider as the unexpected sound tells you you’ve turned this demonic sexual predator into your own personal slut.  As if to confirm this, h");
			else
				outputText("H");
			outputText("e lifts his tail, giving you a perfect view of his entire package, from his self-lubing sphincter to his full balls, and rock-hard, demon-cat dick.  Through lust, his will has been broken, and now he is yours.");
			outputText("\n\nWhat will you do with him?");

			menu();
			if (player.hasCock())
				addButton(0, "Fuck Him", buttFuckbuttFuckbuttFuckAkbal);
			addButton(1, "Ride Him", topAkbitchFromDaBottom);
		}

		//Butt Fuck - Vaginal - Anal
		private function buttFuckbuttFuckbuttFuckAkbal():void
		{
			clearOutput();
			outputText(images.showImage("akbal-deepwoods-male-buttfuck"));
			//[if (hasCock = true)]
			if (player.hasCock())
				outputText("You widen your stance as you sink into the demon’s moist depths with a grin.");
			if (player.cockTotal() > 1)
				outputText("  You widen your stance and look down, choosing the biggest among [eachCock].");
			outputText("  You lift your [cock biggest] into position, and with a grin, you begin to push into the demon’s moist depths.");

			var x:int = player.biggestCockIndex();

			//{if penis < 7 inches}
			if (player.cocks[x].cockLength < 7)
				outputText("\n\nAkbal croons, and you find yourself wondering why he even bothered resisting in the first place.  You tug his forest-made collar and Akbal begins obediently fucking himself on your [cock biggest].  You’re able to lean back and relax as the demon fucks himself using your [cock biggest].  When he slows down, a sudden smack to his muscular hind-end puts him right back on track.  The naturally lubricated hole even pulses, squeezing your [cock biggest] as Akbal takes every inch you have to offer with a grin on his face.");
			//{If penis = 7in-12in}
			else if (player.cocks[x].cockLength < 12)
				outputText("\n\nAkbal groans deep in his chest as you invade his lube-dripping tailhole. He begins to pull away from your [cock biggest] as you push forward.  A sharp tug on his collar corrects this and you resume your efforts to enter his body.  Once your [cockHead biggest] is inside him, he swoons and pushes his muscular rump back onto your [cock biggest] without need for further instruction.  Every time your full length slides into him, he gives a sharp yelp, a hungry sound that shows both his tightness and his need for your [cock biggest].  He maintains a fevered pace and even throws his head back as he pleasures himself on your [cock biggest].");
			//{if penis > 12in}
			else
				outputText("\n\nAkbal howls and cringes as you begin to stuff yourself into his tight tailhole.  His hips swerve and you have to yank your forest-made collar to keep your [cock biggest] buried within his gloriously wet and unbelievably tight hole.  Once you’ve managed to get your [cockHead biggest] past his tight ring, he begins to whine again.  You have to pull his collar to force him down the length of your [cock biggest], but once a foot of your massive dick is inside him, your advance is halted.  Before you even think to complain his insides begin to squirm, shifting to make room for the rest of your [cock biggest].  You reach down and grab his hips, pulling him back until his plump muscled cheeks softly mash against your trunk.  He howls as you maintain a firm grip on his slender hips, not allowing him to move an inch.  Through your fully embedded [cock biggest] you can feel his hole quivering as it pumps massive gobs of that creamy, slick lube in an attempt to make the fuck easier.  A yank on the collar causes the demon to begin slowly forcing himself up and down the length of your [cock biggest].  After a few incursions Akbal picks up the pace and becomes lost in fucking himself up and down your giant pole.  His natural lube even slides out and drips down your [legs] as he repeatedly smashes his insatiable ass into you.  Unbidden, a groan finds its way out your mouth as the demon works you over, having gone from neophyte to pro in a matter of minutes.");

			menu();
			addButton(0, "Next", fuckAkbitchsButt);
		}

		//- page turn -
		private function fuckAkbitchsButt():void
		{
			clearOutput();
			var x:int = player.biggestCockIndex();
			outputText(images.showImage("akbal-deepwoods-male-buttfuck2"));
			outputText("Without warning, Akbal’s insides become vacuum tight.  Convulsions rocket through his body and you realize he has reached his climax without any attention to his barbed dick.  ");
			if (player.cor < 90)
				outputText("You hold the demon’s make-shift collar, letting him ride out his orgasm as he cries out in pure ecstasy, reveling in the satisfaction of knowing you have made him your bitch.");
			else
				outputText("You pound your bitch’s quivering rectum, reveling in the pulsating pressure as Akbal roars beneath you, a sound of mixed pain and ecstasy as you decimate his clenching hole with brutal thrusts.");

			outputText("\n\nSoon you feel that familiar pressure building. Bearing down on him, you begin to slam into his thrusts and enjoy the demon’s snarling, his tail curling every time your two bodies meet with a loud clap.");

			//{if player has dog cock + knot}
			if (player.hasKnot(x))
				outputText("\n\nYou meet your new bitch’s ass with a clap of your hips, sawing your [cock biggest] in and out of his gloriously tight hole.  He howls as you force your swollen knot into his back door with an audible pop.  He reacts by falling flat against the ground in an attempt to get away from the sudden extra girth invading his tailhole, pulling you with him. With your arms wrapped around his you howl and grind your exploding [cock biggest] into his corked bowels, filling the demon body full of hot seed, causing his stomach to swell slightly.");
			//{if player has horse cock}
			else if (player.cocks[x].cockType == CockTypesEnum.HORSE)
				outputText("\n\nAs your shaft splits Akbal in two, he somehow can’t even begin to keep up with the renewed viciousness of your pounding [cock biggest].  One deep, soul shattering thrust causes Akbal to spit fire as you yank his collar and hold, pouring baby batter into his bowels until it spills from the brutally stretched hole, around your [cock biggest] in streams of thick white goo.");
			//{if player has tentacle dick}
			else if (player.cocks[x].cockType == CockTypesEnum.TENTACLE)
				outputText("\n\nSuddenly your [cock biggest] goes wild.  Akbal is howling as his bowels are rearranged by your [cock biggest].  Looking down you can see your [cock biggest] moving around beneath his skin and fur.  When the first spurts of your orgasm begin to fire into his dancing bowels, Akbal pushes back, smashing himself into you as he is hit by a second orgasm thanks to your [cock biggest] agitating his very swollen and very abused prostate.");
			//{if player has cat dick}
			else if (player.cocks[x].cockType == CockTypesEnum.CAT)
				outputText("\n\nAkbal seems particularly fond of your [cock biggest] as he dances on its rigid length.  When your embedded [cock biggest] begins to spurt hot seed into the demon’s bowels you take control and start mercilessly slamming your [hips] into the jaguar's upturned back side.  He shivers as you beat out a titanic orgasm.  Even after you are spent, he continues to grind against your [cock biggest].");
			//{if player has human/kanga dick}
			else
				outputText("\n\nYou pull on the collar and fall forward.  You begin to blast hot seed into Akbal’s shivering bowels while continuing to pound him into submission, the collar clenched in your fist as you beat out your orgasm, streams of baby batter running down the bitch’s legs and scrotum.");

			outputText("\n\nYou look back at your new bitch with a grin while he regains his senses.  As you leave the forest you hear a promise from Akbal’s chorus of voices, \"<i>You will regret this... Champion.</i>\"");

			player.orgasm();
			dynStats("cor", 3);
			doNext(camp.returnToCampUseOneHour);
		}

		private function topAkbitchFromDaBottom():void
		{
			clearOutput();
			outputText(images.showImage("akbal-deepwoods-male-akbalonback"));
			//[{if goo legs}]
			if (player.isGoo())
				outputText("You lay down in the soft grass with a mischievous grin.  Using the collar, you yank Akbal forward, causing his mouth to splash into your [vagOrAss].  Instantly your entire form feels as if waves of pure ecstasy are cascading through you.  The feeling peaks and recedes in an unpredictable pattern and you’re lost in the feel of the demon’s mystic saliva as you ride out your orgasm, reveling in the heat of his tongue coated in that wonderful spit.  When you can stand it no more, you push the demon onto his back and look upon his rigid tool as it leaks and quivers while pointing to the sky.");
			//[if (biped = true)
			else
			{
				outputText("You lay down in the soft grass with the collar in hand.  You wrap your arms around your [legs], holding them up to give the demon an easier target.  With a light tug the demon takes the hint and smashes his face into your [vagOrAss].  The sensations coursing through your body as his tongue flitters across your ");
				if (player.hasVagina())
					outputText("clit");
				else
					outputText("prostate");
				outputText(" makes you cringe.  Your new toy laps at your [vagOrAss] and sends shivers coursing through your body as your [vagina] becomes drenched.  Something about his saliva causes an almost electric sensation to shoot through you. When you can stand it no more, you push the demon onto his back and look upon his rigid tool as it quivers.");
			}
			outputText("\n\nThe bound demon’s legs stretch straight out, his barbed dick flexing in anticipation.  You touch it, feeling the wetness of the self-lubing demon dick cling to your fingers as you feel one of the barbs.  It is spongy, soft but not too soft.  The demon hisses as you tease him, your fingers sliding across the rubbery barbs that cover his rock-hard sex organ.  When you begin to lower yourself onto his shuddering dick, the demon begins to purr.");

			menu();
			addButton(0, "Next", topAkbitchFromBottomDuex);
		}

		private function topAkbitchFromBottomDuex():void
		{
			clearOutput();
			outputText(images.showImage("akbal-deepwoods-male-akbalonback2"));
			//-page turn-
			//{tight/virgin vag/ass}
			if ((!player.hasVagina() && player.ass.analLooseness < 2) || (player.hasVagina() && player.looseness() <= 2))
				outputText("As you begin to impale yourself on the demonic pole, you gasp as your [vagOrAss] is spread wide by Akbal’s rather large demon-cat dick.  The remnants of his spit on your [vagOrAss] reacts to the mystic lube and any pain you would have felt is gone, replaced by mind numbing bliss.  The demon begins to thrust up into your [vagOrAss], which you cannot help but allow.  The sensation is beyond ecstasy - it is pure euphoria, exploding like a firecracker and blasting through you like a wave.  All too soon the pleasure peaks.");
			//{medium vag/ass}
			else if ((!player.hasVagina() && player.ass.analLooseness < 4) || (player.hasVagina() && player.looseness() < 4))
				outputText("As you impale yourself on the demon’s quivering dick, a moan finds itself coming out of your mouth.  The moment the remnants of saliva in your [vagOrAss] touch the lube coating his barbed cock, you see stars.  Lost in the moment, you cannot believe anything can feel this good.  You ride up and down the entire length of the demon’s damned sex organ.  It’s almost as if you’re bouncing up and down on a rod of pure bliss, like your entire being is being impaled by pure joy.  All too soon the pleasure peaks.");
			//{gapped pussy}
			else
				outputText("As you slide down the demon’s quivering dick your eyes roll back.  As the demonic saliva coating your [vagOrAss] comes into contact with the lube on his barbed, demon-cat dick, you cannot believe anything can feel this good.  Suddenly, you are bouncing as hard as you can while the demon thrusts up into you.  Your bodies slam together causing a thunderous applause to ring out across the clearing as you ride him as hard as you can.  The combination of the size and thickness of his ribbed, textured dick combined with the chemical stimulants makes your entire being cry out.  You feel as if you are drowning in ecstasy, as if an unending paradise is blooming inside you from your [vagOrAss].  All too soon the pleasure peaks.");
			if (player.hasVagina())
				player.cuntChange(16, true, true, false);
			else
				player.buttChange(16, true, true, false);

			//[if (hasCock = true)]
			if (player.hasCock())
			{
				outputText("\n\nYou wrap your hand around [oneCock] as it swells.  Every nerve ending in your body explodes as ");
				if (player.hasVagina())
					outputText("both ");
				outputText("your sex organ");
				if (player.hasVagina())
					outputText("s climax at once");
				else
					outputText(" climaxes");
				outputText(".  Your [vagOrAss] spasms around the demon’s embedded cock as [eachCock] paints his chest and face with a generous coating of baby batter.  Your orgasm rages on, covering the demon cat in your sex fluids, matting his fur and darkening it with more seed than you ever thought possible.");
			}
			//[if (hasCock = false)
			else
				outputText("\n\nEvery nerve ending in your body explodes as you convulse atop the jaguar.  With a hoarse groan, your [vagOrAss] begins to spasm around the embedded pleasure rod as it gushes more fluid than you thought possible.  Soon the Jaguar is soaked from waist to thigh.");

			outputText("\n\nYou look back at your new bitch with a grin while he regains his senses.  As you leave the forest, you hear a promise from Akbal’s chorus of voices, \"<i>You will regret this... Champion.</i>\"");
			player.orgasm();
			dynStats("cor", 3);
			if (player.hasVagina())
				player.knockUp(PregnancyStore.PREGNANCY_IMP, PregnancyStore.INCUBATION_IMP, 101);
			doNext(camp.returnToCampUseOneHour);
		}

		//AMB Strength Scene
		//70+
		private function akbitchHighStrengthVariant():void
		{
			clearOutput();
			outputText("With a wicked grin, you rip off your [armor] and grab the bound demon by the scruff on his neck.  He does this sexy little wiggle as you hoist him until he reaches eye level, easily manipulating his light weight as you inspect his slim, toned body.  His chest heaves, his nipples stand at attention, and his erect demon-cat dick drools a heavy river of thick cream, darkening the fur on his sack and inner thighs.  This is going to be fun.");
			if (player.hasCock())
			{
				outputText(images.showImage("akbal-deepwoods-male-highstrength"));
				//if (hasCock = true)
				outputText("\n\nAkbal licks your [face], quite obviously lost in lust.  You can’t help but chuckle because this self proclaimed god has turned into your submissive little bitch.  You pin him to a nearby tree and slide your hands down his lust crazed body to his slim waist.  You then grab your [cock] and push it up into the demon’s soft cleft.");
				var x:int = player.biggestCockIndex();
				//{If CockLength < 7}
				if (player.cocks[x].cockLength < 7)
					outputText("\n\nAkbal purrs as you shove your [cockHead biggest] into his hot, dripping hole.  The all-natural lube oozing from his anal walls helps you smoothly glide through the tight ring.  In a show of strength, you pull the demon away from the tree, supporting his full weight as you begin to lift him up and down the full length of your [cock biggest].  Akbal purrs as you slam his entire body into your thrusting [cock biggest] with reckless abandon.  His pleasure is made more obvious by the gigantic barbed dick sliding against your [fullChest] as the tightness of his hot, wet tailhole makes you groan.");
				//{if CockLength is between 7 and 12}
				else if (player.cocks[x].cockLength < 12)
					outputText("\n\nAkbal groans as you shove your [cockHead biggest] into his hot, dripping tailhole.  The lube oozing out of his anal walls allows you to slide your full [cock biggest] into the slick chute with little effort, and you spy the demon’s toes wiggling out the corner of your eyes.  Showing off your muscles, you lift the demon’s entire body up until only the tip of your [cock biggest] remains embedded inside his tight opening.  Without warning you thrust forward while slamming him down, ramming your entire [cock biggest] into him as hard as you can.  He flinches and roars.  As you continue to pound his tightly clinging insides while supporting his full weight, his demon-cat dick repeatedly slides against your [fullChest], leaking a steady stream of pre-jizz down your body.  His slim weight is easy to manipulate.  His hole squeezes in time with your thrusts, massaging your embedded [cock] and spurring you to slam up into his quivering hole even harder.");
				//{if CockLength > 12}
				else
					outputText("\n\nAkbal roars as your [cockHead biggest] is shoved into his tight, dripping tailhole.  The all natural lube does little to help you punch your way into his colon.  He squirms in your arms, trying to get away from the sudden pressure of your forcefully invading [cock biggest].  You laugh as you pull his body down while pushing up into his dripping tailhole.  After about a foot of your [cock biggest] forces its way in his hot innards, you are halted.  You begin to feel a rumbling that tickles the embedded portion of your [cock biggest].  You realize Akbal’s insides have begun to shift, making room for your [cock biggest].  The bound demon flinches and growls as you push his slender body down your [cock biggest] until his ass has engulfed your entire length.  The demon shudders as his barbed tool explodes, painting your [fullChest] and [face] with long ropes of sweet, creamy cat-jizz.  Flexing your muscles, you pull his back off the tree and begin to lift Akbal up and down the entire length of your [cock biggest].  Despite his earlier orgasm, Akbal’s barbed dick is still rock hard against your [fullChest] and leaking a heavy river of creamy white down your already soiled front.  You grin as the eyes of this 'god' of the terrestrial fire roll up into his head as you slam him down, splitting the willing bitch open with your [cock biggest].");
				outputText("\n\nSuddenly Akbal’s body goes into convulsions, and you know if his hands were free he’d be clawing at your back.  His legs lock around your waist as a jet of white hot cream hits the bottom of your face, quickly followed by another and another, causing his hole to quiver around your embedded shaft as the demon unloads ");
				if (player.cocks[x].cockLength > 12)
					outputText("another");
				else
					outputText("a");
				outputText(" titanic orgasm onto your [fullChest].");

				//{corruption < 90}
				if (player.cor < 90)
				{
					outputText("\n\nYou can’t help but smile as evidence of the demon’s pleasure continues to spurt, leaving everything below your chin soaked in demon spunk and letting you know that he truly is your little bitch.");
				}
				//{corruption > 90}
				else
					outputText("\n\nYou flex your muscles as you wrap your arms around Akbal’s slim waist, bending down slightly to get a better angle.  You begin to pump into the demon’s quivering hole, abusing the convulsing sheath with brutal thrusts.  The demon’s voice breaks with each soul shattering thrust as his demon-cat dick unloads, leaving you covered from the chin down in a hot, creamy mess.");
				outputText("\n\nAkbal shudders as his orgasm ends.  With your [cock biggest] still embedded, the two of you fall to the forest floor.  You pry his legs from your waist and crush them into his jism soaked chest.  With a snarl you slam your [cock biggest] into him with all your strength as you feel [eachCock] begin to tremble.  Every full length slam of your [cock biggest] forces a yelp out of the demon’s throat.  Soon you feel a familiar pressure building in your groin as you pound Akbal into the ground.");

				//{if player has dog cock + knot}
				if (player.hasKnot(x))
					outputText("\n\nWith all your strength, you slam your [cock biggest] down into the bitch’s abused tailhole, forcing your swollen knot in with an audible pop.  the demon growls as you cork his anal ring, ensuring your seed won’t escape his hot little hole.  With a rumbling howl, you unload into the demon’s corked bowels, your seed pouring into the hot tube until your [cockHead biggest] is swimming in your own baby batter and Akbal’s stomach is slightly swollen.");
				//{if player has horse dick}
				else if (player.cocks[x].cockType == CockTypesEnum.HORSE)
					outputText("\n\nYour thrusts double in force as you throw your head back and ram into the little bitch with all your strength.  Deep inside his rearranged bowls, your [cock biggest] expels a tidal wave of dick snot into Akbal’s quivering insides.  You and the demon cry out together as your [cock biggest] twitches inside him, breeding him with fresh baby batter as you grind your [cock biggest] around in his little bitch hole.");
				//{if player has tentacle dick}
				else if (player.cocks[x].cockType == CockTypesEnum.TENTACLE)
					outputText("\n\nWhen you feel the pressure of your impending orgasm building, you slam your [cock biggest] in to the hilt.  Inside Akbal’s bowels your [cock biggest] goes crazy.  You have to redouble your efforts to hold his thighs to his cum stained chest as he struggles while your [cock biggest] twists and turns inside his overstimulated ass.  When your deeply embedded [cock biggest] begins to spill your seed, you can’t help but grind your [cock biggest] into Akbal’s wrecked bowels as the demon goes limp, too tired to fight the intense sensations your [cock biggest] causes him.");
				//{if player has cat dick}
				else if (player.cocks[x].cockType == CockTypesEnum.CAT)
					outputText("\n\nAs you slam your [cock biggest] in to the hilt, Akbal wraps his legs around your waist, obviously very fond of your [cock biggest].  With your [fullChest] against his jizz-soaked chest, your [cock biggest] begins to blast his innards with hot cum.  As your orgasm rages on, you grind your [cock biggest] around in the demon’s massaging hole.");
				//{if player has dragon dick}
				else if (player.cocks[x].cockType == CockTypesEnum.DRAGON)
					outputText("\n\nAs you slam the full length of your [cock biggest] into Akbal’s upturned ass, he flinches as the bulb at the base of your shaft is shoved into him.  This matters very little to you as your [cockHead biggest] begins to blast torrents of hot seed into his quivering bowels.  The demon squirms as you grind your [cock biggest] into his hole as a river of white cream spills from the abused hole and slides down his body to the forest floor.");
				//{If player has Lizard dick}
				else if (player.cocks[x].cockType == CockTypesEnum.LIZARD)
					outputText("\n\nAs you smash your [hips] into Akbal’s upturned ass, he suddenly clenches.  Relishing in the bumpy texture, the demon groans as your embedded [cock biggest] explodes and shoots hot cream into his stuffed bowels.  As your body convulses with each twitch of your [cock biggest], the bitch’s hole begins to overflow, spilling from his abused hole in thick gobs.");
				//{if player has human/kanga dick}
				else
					outputText("\n\nYou ram your [cock biggest] into his upturned ass with all your strength and hold, causing the demon to roar as you shoot globs of white-hot cream into his wrecked and abused hole.  Soon your seed is dribbling down his upturned ass cheeks and spilling onto the forest floor.");

				//{corruption < 90}
				if (player.cor < 90)
					outputText("\n\nYou stand, allowing Akbal to relax as you gather your [armor].  Once you’re dressed you reach down and untie him before heading back to camp.");
				//{corruption > 90}
				else
					outputText("\n\nYou stand and Akbal’s legs flop from where you had them pinned to his chest.  You gather your [armor] and dress before aiming a wicked slap at Akbal’s tender cheeks and leaving him tied up for the imps and goblins you spy watching the two of you from the trees.\n\nYou tell him he is all theirs and share a conspiratorial grin as you head back to camp.");
				player.orgasm();
				dynStats("cor", 3);
				doNext(camp.returnToCampUseOneHour);
			}
			else
			{
				outputText(images.showImage("akbal-deepwoods-female-highstrength"));
				outputText("\n\nAkbal licks your [face], quite obviously lost in lust.  He’s lost all pretense of being some god and is now your own personal bitch.  With a wicked grin, you drop him ass first onto the ground.  You turn on your heel and squat until your [vagOrAss] is in his face, letting him get a good whiff.  Then you unceremoniously grab the fur on his head and jam him muzzle first into your [vagOrAss].");
				outputText("\n\nAkbal begins tonguing your [vagOrAss] with the technique of a veteran.  As he slathers your ");
				if (player.hasVagina())
					outputText("nether lips");
				else
					outputText("entrance");
				outputText(" with his hot saliva you flinch.  A jolt, like lightning, shoots through your body and causes you to smash yourself into his face.  His long, thick tongue is hot bliss, teasing and pleasing you like a pro.  He uses his black lips to tease your ");
				if (player.hasVagina())
					outputText("clit");
				else
					outputText("prostate");
				outputText(" and drills his long tongue into you, carrying that euphoria inducing spit into your [vagOrAss] over and over.  Your body grinds against the sensation as the good little bitch’s saliva drenches your [vagOrAss] until it’s dripping with a combination of your sex and his spit.  Here you keep him until the teasing pleasure is so intense you’re fit to burst.");

				outputText("\n\nWithout warning, you shove the little bitch onto his back and press his legs to his chest.  His heavy sack is drawn up tight, his self-lubing cock still pumping a river of lubricant and pre.  Using your muscles, you trap him in this position with your legs before reaching behind you to grab his barbed cock.  The barbed appendage is rubbery and wet with slick fluid.  Touching it causes Akbal to try to thrust upward, but it's damn near impossible against someone as strong as you.  Aiming his slick, ribbed demon-cat dick into your [vagOrAss], you begin to ease down onto it.");

				//{tight/virgin vagorass}
				if ((!player.hasVagina() && player.ass.analLooseness < 2) || (player.hasVagina() && player.looseness() <= 2))
					outputText("\n\nAs soon as your [vagOrAss] begins to envelop the thick head of Akbal’s giant, barbed dick, you let out a loud moan.  As the remnants of the spit slathered across your [vagOrAss] mixes with the lube on Akbal’s swollen sex organ, your body flinches from the tidal wave of pleasure.  Even those gorgeous barbs feel as though they’re soft, vibrating beads, wiggling as you envelop the demonic cock.  Thanks to the mixture, you are able to take his full length and revel in the stretched feeling having all that man meat gives you.  Akbal attempts to move, to thrust up into your [vagOrAss], but you hold him here, asserting your dominance as you easily keep the bitch boy pinned.");
				//{medium vagorAss}
				if ((!player.hasVagina() && player.ass.analLooseness < 4) || (player.hasVagina() && player.looseness() < 4))
					outputText("\n\nAs soon as your [vagOrAss] begins to envelop the thick head of Akbal’s giant, barbed dick, you let out a squeal of delight. As your saliva drenched [vagOrAss] comes into contact with the lube soaking his demon dick, you almost pass out from the immense pleasure the mixture causes.  Those wonderful barbs are even vibrating against your tender flesh.  The girthy prick inside you is pure heat and vibrating pleasure that has your body tingling from your [vagOrAss] to your [feet].  Akbal attempts to move, to thrust up into your [vagOrAss] but you hold him here, asserting your dominance as you easily keep the bitch boy pinned.");
				//{Gaped vagorAss}
				else
					outputText("\n\nAs soon as that giant erection touches your [vagOrAss], your face twists into a sexy grimace of pure euphoria.  The spit-drenched opening of your [vagOrAss] coming into contact with his lube soaked sex organ causes you to see stars.  Add to that the way the barbs inside seem to vibrate, and you are in heaven.  You slide down Akbal’s length without a problem.  Akbal attempts to move, to thrust up into your [vagOrAss] but you hold him here, asserting your dominance as you easily keep the bitch-boy pinned.");

				if (player.hasVagina())
					player.cuntChange(16, true, true, false);
				else
					player.buttChange(16, true, true, false);

				outputText("\n\nYou place your hands on Akbal’s muscular calves and push down, causing the demon’s cock to tremble within you.  With your legs positioned outside of his, you squeeze his legs together and begin to rock back and forth.  As you slowly slide up and down the rigid length of Akbal’s pleasure rod, he goes crazy.  You can feel his muscles straining against your vice like grip as you tortuously slide up and down his length as slow as you can, willing yourself to not go wild as you silently assert your dominance over your bitch.  After a while you begin to speed up, slowly increasing tempo as you glide across his rock hard demon dick.");

				outputText("\n\nSoon you feel Akbal’s embedded dick begin to jump, and every sensation is intensified as his hot cream shoots into your now rapidly riding [vagOrAss].  The sensations are too much.");

				//[if (hasVagina = true)
				if (player.hasVagina())
					outputText("\n\nYour [vagina] explodes, causing your body to jerk and twist as you rapidly pump out your orgasm.");
				else
					outputText("\n\nYour body begins to convulse and you feel as though lightning bolts of pure elation are shooting through your soul.");
				//[if (hasCock = true) \"<i>
				if (player.hasCock())
					outputText("  [EachCock] swells and explodes, shooting cream all over Akbal’s thighs, chest and face as you unload thick white rope after rope.");

				player.orgasm();
				dynStats("cor", 3);
				if (player.hasVagina())
					player.knockUp(PregnancyStore.PREGNANCY_IMP, PregnancyStore.INCUBATION_IMP, 101);
				doNext(camp.returnToCampUseOneHour);
			}
		}

		//AMB Speed Scene
		//70
		private function akbalBitchSpeed():void
		{
			clearOutput();
			outputText("Akbal groans as he lies face first in the dirt.  His body has already morphed into a more humanoid form.  You smile as you watch him hump the grass, two hollows forming in his ass cheeks as they clench and unclench.  The sight of him futilely trying to stimulate himself gets you so hot you practically rip off your [armor] and grab the tied up demon with a grin.");
			outputText("\n\n\"<i>[Master],</i>\" Akbal’s chorus of voices croons in your mind.");

			var x:int = player.biggestCockIndex();

			//[if (hasCock = true)]
			if (player.hasCock())
			{
				outputText(images.showImage("akbal-deepwoods-male-highspeed"));
				outputText("\n\nYou pull his tail until the bound demon jaguar is face down, ass up.  His muscular cheeks part themselves thanks to previous incursions.  His soft pink hole shines with the natural lube he creates.  He lifts his spotted tail and spreads his legs, letting you know he’s ready.  You plant your [feet] and lean over his body. With your [cock biggest] in hand, you position your [cockHead biggest] at his rear entrance.  With your free hand, you aim a slap at the demon’s waiting rump, watching the furry, round cheeks jiggle as a dollop of lube drips out of the waiting hole.  Needing no further invitation you begin to push into the demon.");

				//{cockLength < 7}
				if (player.cocks[x].cockLength < 7)
				{
					outputText("\n\nWith your hands at his waist to provide the necessary balance, you begin to jackhammer his insides.  A constant, almost unending slurping fills the air as you repeatedly thrust your [cock biggest] into the demon’s upturned hole.  His ass jiggles with each thrust, and before it's done, another undulation rocks the furred surface.");
					//[if (hasBalls = false)
					if (player.balls == 0)
						outputText("  Your [cock biggest] drips gobs of his slick lube down the lower half of your body.");
					else
						outputText("  Your [cock biggest] drips gobs of his slick lube down your [sack] and the insides of your legs.");
					outputText("  With clenched teeth you spur yourself to fuck the demon even faster, reaching your top speed.");
				}
				//{cockLength between 7 and 12}
				else if (player.cocks[x].cockLength < 12)
				{
					outputText("\n\nAkbal pushes back against you, wiggling his round muscular ass against your trunk as his tail slides up against your [fullChest].  Planting your [feet], you sink inch by inch into the demon’s hot hole.  With your hands at his waist to provide the necessary balance, you begin to jackhammer his insides, causing the demon to growl up at you.  Reaching forward, you push down on the demon’s bound wrists, using them to force him to raise his ass up and give you an easier target.  The slurping caused by your [cock biggest] stabbing into the hot and quivering passage fills the air.   You smash into the furry, jiggling mounds of muscled ass on the demon below you.  The natural lube floods out of Akbal’s stuffed tailhole, painting your [cock biggest] with its creamy heat.  Endowed by your own lust, you begin to piston in and out of the demon’s hole like a madman.");
				}
				//{cockLength > 12}
				else
				{
					outputText("\n\nYou are surprised you can even fit inside the demon’s tailhole.  The flesh wrapped around your [cock biggest] strains as you are halted by Akbal’s body.  You’re only able to fit a foot of your [cock biggest] into the demon, but you can feel his insides shifting.  The demon, stuffed beyond capacity, is somehow making room for the rest of your [cock biggest], and both of you can feel it.  The wriggling dickhole wrapped around your [cock biggest] is hot bliss, sliding, squeezing, and massaging your slowly advancing [cock biggest].  Beneath you, Akbal cringes and softly growls through clenched teeth as you sink, inch by inch, into his shifting innards.  When your trunk softly meshes against the demon’s upturned cheeks, a spasm rocks his body.  His insides tighten until you can’t move and Akbal shudders out a heavy orgasm.  You feel every spasm, every muscle contraction and every convulsion as the demon’s splatters his knees with rope after rope of creamy cat jizz.  Once Akbal’s hole relaxes again, you plant your [feet] and lean over his body with a mischievous grin.  With your hands at his waist to provide the necessary balance, you begin to jackhammer his insides, causing the demon to roar and claw at the ground as you make a mess of his pretty pink hole.  Every thrust forward makes his body flinch, knocking the wind out of him as you rapidly saw your [cock biggest] in and out of his hole.  Gobs of his internal lube drool out of his hole, cling to your shaft and drip down his sac.  Your [cock biggest] becomes a blur as you hit your top speed, making a sound akin to applause ring out as you brutally assault the demon’s hole.");
				}

				outputText("\n\nPushing down on the wrists tied behind his back, you press the demon’s chest flat to the ground as your [cock biggest] begins to swell.  Beneath you Akbal’s hole is fluttering, and you know he’s close.  With one last brutal thrust into the dominated demon-cat’s abused hole, you slam his entire body flat against the forest floor and unload.  Together the two of you howl till your collective voices are hoarse.  With a cringe you pull your [cock biggest] out of Akbal’s jizz dripping hole.");
				outputText("\n\nAkbal lies on the ground, shivering as he rolls over.  The tied up demon jaguar’s stomach and the forest floor are covered in a thick coating of jizz, sticky strings even connect the demon’s chest to the puddle.  With heaving breath, the demon falls asleep as you gather your [armor] and leave.");
			}
			//[if (hasVagina = true)
			else
			{
				outputText(images.showImage("akbal-deepwoods-female-highspeed"));
				outputText("\n\nYou grab Akbal’s leg and use it to roll the tied up demon over until his rigid length is pointing to the sky.  The tall and ribbed demon cat dick excretes a natural lube along with the white pre-cum drooling down its front.  It looks very inviting but the Jaguar’s face, his wide tongue and black lips, look even more so.");
				outputText("\n\nYou stand in a squat above the demon’s face.  Before you even have the chance to smash your [vagOrAss] onto his lips, he lunges upward, shoving his face into you before you are ready.  A cascading rush ofecstasyy enters your body the moment his saliva touches your [vagOrAss].  You fall and the demon follows as you spread your legs wider, giving him an easier target for his bliss inducing oral ministrations.  He slathers your [vagOrAss] with a generous amount of saliva while using his wide tongue to lap at your exposed privates.  When he begins teasing your ");
				if (player.hasVagina())
					outputText("clit");
				else
					outputText("prostate");
				outputText(" with his long tongue, you begin to shiver.  Then you remember what it is you wanted to do.  Before he makes you cum, you shove his face away from you, pushing him onto his back with his cock once again standing tall.  Unable to contain yourself and draw this out any longer, you straddle the more than willing Jaguar demon and lower yourself onto his twitching erection without a second thought.");

				//{tight/virgin vagorass}
				if ((!player.hasVagina() && player.ass.analLooseness < 2) || (player.hasVagina() && player.looseness() <= 2))
				{
					outputText("\n\nWhen the mushroom-shaped head of Akbal’s monstrous dick touches your [vagOrAss], a lightning bolt of ecstasy shoots through your body.  The saliva coating your [vagOrAss] mixes with the fluid coating the demon’s dick and makes you call out from the very depths of your soul.  As if the heated, almost drug-like pleasure wasn’t enough, your [vagOrAss] is being stretched, somehow taking the full length of Akbal’s monster dick without a problem.  Once you’ve fully enveloped him, the barbs begn to vibrate, pulsing like sex beads that send you into overdrive.\n\nYou begin to bounce.  Your body cries out for more and you answer the call by bouncing up and down the entire length of Akbal’s wonderfully rigid dick as fast as you can.  Each time you crash your [vagOrAss] into his, there is a hard clap, and soon, you’re going so fast it sounds like excited applause.  Beneath you, Akbal shakes as you ride him faster and harder than he’s ever been ridden before.  The tightness of your [vagOrAss] seems to be rare treat to such a well-endowed demon.");
				}
				//{medium vagorass}
				else if ((!player.hasVagina() && player.ass.analLooseness < 4) || (player.hasVagina() && player.looseness() < 4))
				{
					outputText("\n\nWhen the mushroom shaped head of Akbal’s barbed dick touches your [vagOrAss], you feel the invasion with your entire body.  The saliva coating your spit-slick vagina reacts with the fluids coating Akbal’s dick, causing a chemically induced euphoria.  As if that wasn’t enough the barbs covering the shaft begin to vibrate, tingling your [vagOrAss] and driving you wild.\n\nYou plant your feet and begin riding Akbal for all you are worth.  With all your speed and strength, you smash your body into his, causing an unsteady, almost unending rhythm.  Beneath you Akbal shivers as you ride him so hard and fast that he can’t keep up. The demon’s toes curl, his eyes are even rolled into the back of his head.");
				}
				//{gaped vagorass}
				else
				{
					outputText("\n\nWhen the mushroom shaped head of Akbal’s gorgeous dick touches your [vagOrAss], you flinch.  The moment your spit-soaked ");
					if (player.hasVagina())
						outputText("vagina");
					else
						outputText("ass");
					outputText(" touched the fluid-soaked demon dick, a tidal wave of pure euphoria cascaded through your entire being.  As if the chemical reaction wasn’t enough, the barbs on Akbal’s dick begin to vibrate, tickling and teasing your [vagOrAss].\n\nYou know what to do with a dick that feels that good: you plant your feet and begin bouncing up and down that ecstasy-inducing dick with all of your strength.  Soon you’re bouncing so fast your body meeting his sounds more like applause than two frisky partners going at it.  You can see the demon’s tongue as it rolls out of his mouth and his eyes as they roll to the back of his head.");
				}

				if (player.hasVagina())
					player.cuntChange(16, true, true, false);
				else
					player.buttChange(16, true, true, false);

				outputText("\n\nFrom his reaction you know he’s definitely enjoying this, but you could care less. He is nothing more than a living sex toy, a creature with a dick and tongue like no other which you are using to make your [vagOrAss] feel these electric sensations of cascading pleasure that steadily intensifies.  Beneath you, the demon begins to buck and soon you feel the heat of his exploding cock as he shoots you full of baby batter.  The euphoria you revelled it this entire time peeks.  Your body cringes involuntarily as your mouth opens in a silent scream.");

				//[if (hasCock = true)]
				if (player.hasCock())
					outputText("\n\nYou can’t help but grip [eachCock] as it explodes, painting Akbal’s chest with your creamy spooge.");
				//[if (hasVagina = true)
				if (player.hasVagina())
					outputText("\n\nYour [vagina] releases a flood of creamy fluid as your body continues to convulse.  Your orgasm lasts for several minutes in which you paint Akbal with the evidence of how much he has pleased you.");
				//{genderless}
				if (player.gender == 0)
					outputText("\n\nYour body begins to convulse as you call out. Your [ass] feels as though the demon’s dick is a lightning rod expelling a constant torrent of elation.");
				outputText("\n\nYour [vagOrAss] is blissfully sore and crazy sensitive as you ease yourself off the demon’s wonderful dick.  With a smile on your [face] you gather your [armor] and turn to leave the forest.  Lost in giddy elation you walk, each movement sending an almost painful jolt of post orgasm pleasure through your [vagOrAss].  It isn’t until you hear the cackling of imps and goblins that you remember that you left Akbal bound and vulnerable... oops.");
				if (player.hasVagina())
					player.knockUp(PregnancyStore.PREGNANCY_IMP, PregnancyStore.INCUBATION_IMP, 101);
			}
			player.orgasm();
			dynStats("cor", 3);
			doNext(camp.returnToCampUseOneHour);
		}

		//AMB Toughness Scene
		//70
		private function akbitchToughness():void
		{
			clearOutput();
			//[if (toughness > 70)]
			outputText("You look down at your handywork and marvel at the fact that being ambushed and dominated has turned the demon on enough for him to shift forms.  Yet you wonder how much the demon jaguar really likes this type of thing...  You grab the vine hanging from his makeshift collar with a malicious grin spreading across your [face].  You step away and with a silent tug, you tell him to come.  His pride sparkles in his burning green eyes and he remains, baring his teeth in a low growl.  One more sudden yank causes him to begin wiggling on the ground, his hands being tied behind his back making it harder for him to move.  Every muscle on his lean body is tense and you know this self-proclaimed \"<i>god</i>\" hates you.  You smile as you watch his muscled ass shift beneath his spotted fur as he shortens the distance between the two of you.  Once he’s close enough you squat. Reaching down you grab his face and look into those desperately defiant eyes.  You can tell from the way he moves his hot little ass around that his erection is bothering him.  His eyes fall to your [feet] as he tries to stifle a purr.");

			outputText("\n\nAs the sound hits your ears, ");
			if (player.hasCock())
				outputText("[eachCock] twitches and begins spilling pre in preparation for what is to come.  Y");
			else
				outputText("y");
			outputText("ou can’t help but rub your [nipple] a little as the demon looks up at you with equal parts fear and defiance while trying to hide how hot you’re making him with a rumbling growl.  What a proud little bitch.");

			outputText("\n\nYou instruct him to stop growling. He not only gets louder but snarls at you as well.  Well, that just won’t do.  You walk around the growling bitch and fall to your knees behind him.  You repeat the command and once again your order goes ignored.  You grab the demon by the scruff of his neck and raise your free hand into the sky before bringing it down with a loud smack that echoes through the trees.");

			outputText("\n\n\"<i>RRRRAAAAAWWWWRRRR</i>\" Akbal screams as you look down at his now tightly clenched, fuzzy ass cheeks.  You rub the spot, enjoying the feel of the fleshy mound as the demon snarls.  Reaching up again you aim for the same spot, causing the demon to bellow again as your hand reconnects with a vengeance.");

			outputText("\n\nYou tell him to shut up, punctuating each syllable with another blow to his posterior.  He howls for all he’s worth, not even trying to follow your order.  You aim a wicked blow at the unmolested cheek and he snarls, the mental voice he uses threatening you with all manners of perverse punishment.  It seems this bitch doesn’t get it, and his constant insults and threats have gotten on your last nerve.");

			outputText("\n\nCasting your false veneer of calm aside, you begin to viciously spank the loud jaguar demon’s upturned cheeks with reckless abandon.  His body jerks while his legs kick wildly beneath you.  He tries to twist around, and you have to hold tight to his fur in order to keep the bitch face down.  Soon your palm is stinging, and he’s gritting his teeth in an effort to keep quiet.  After a few hard, body jarring test slaps you feel like maybe now the bitch is willing to comply.");

			outputText("\n\n\"<i>Good boy,</i>\" you say as you rub the deliciously hot mound of flesh, an act that causes the demon to flinch as you make contact with his stinging buns.");

			outputText("\n\n\"<i>You will pay for this, Champion,</i>\" Akbal promises, his mental voice dripping with venom.");

			outputText("\n\nHow dare a bitch speak to its master in such a way?  Angered by his defiance, you begin to spank his upturned cheek again.  Without mercy or pity for the demon’s cries, you fill the air with the sound of his ass being slapped silly by the blur that is your free hand.  After a few minutes of serious palm-lashing, you switch hands and continue.  The demon continues to writhe and even begins begging for mercy.  He occasionally tries to quiet himself but you are past mere compliance.  Only once your new hand is stinging as fiercely as your old one do you stop.  You grab his ass, and the demon’s entire body tenses but he doesn’t make a sound.  This makes you smile.  As you rub and fondle his burning ass-cheeks, you let him know exactly who is in charge.  You tell him how much of a bitch you know he is.  You even laugh at him for telling you he was a \"<i>god</i>\".  He takes your verbal abuse silently and without retort.  With one slap for finality, you untie the demon’s hands.  He looks off across his clearing as if thinking about making a mad dash for it.  You tug his collar, silently reminding him he’s still bound to you.  A grin spreads across your [face] as he finally truly gives in.");

			//[if (hasCock = true)]
			if (player.hasCock())
			{
				outputText(images.showImage("akbal-deepwoods-male-hightoughness"));
				outputText("\n\nYou tell the demon to put his ass up. When he does, you aid him by shoving his chest into the ground, making sure he arches his back properly.  His furry ass naturally parts, revealing his little dripping pink rosebud.  You begin to shed your [armor], and his hole flexes a few times, causing a creamy lube to drip down his scrotum.  [EachCock] is rigid as you expose yourself to the air.  Akbal wiggles his ass at you and you realize how badly he wants you inside him.  It appears this demon has decided to be a good little bitch.  You grab your [cock biggest] and grin as you lower yourself to mount him.");
				var x:int = player.biggestCockIndex();

				//{cocklength < 7}
				if (player.cocks[x].cockLength < 7)
					outputText("\n\nAs you push your [cockHead biggest] into the jaguar demon, he begins to purr but quickly stops, remembering he’s supposed to be quiet.  The lube that drips from his tight rectal tube heats up as you slide the rigid length of [oneCock] through his fuck tunnel until you’ve buried your entire length into his hungry tailhole.  You aim a smack at his still tender ass, causing the passage to tighten as two hollows appear in his squeezing cheeks.  You begin pump your [cock] in and out of his tight hole slowly, reveling in the heated wetness of the demon’s bowels.");
				//{cockLength between 7 and 12}
				else if (player.cocks[x].cockLength < 12)
					outputText("\n\nWhen you push your [cockHead biggest] into the jaguar demon he flinches and barely manages to stay quiet.  The lube that drips from his anal opening helps you stuff your [cock biggest] into his tight hole.  It takes some trying, but once you’ve sunk all of your [cock biggest] into the demon’s back door, you aim a slap at his still tender ass, causing the demon to tighten his living dick tube of a tailhole around your deeply embedded [cock biggest].  You begin to slowly rock back and forth, enjoying the feeling of his wet rectal passage squeezing your [cock biggest].");
				//{cockLength > 12}
				else
					outputText("\n\nWhen you push your [cockHead biggest] into the jaguar demon his hips swerve, running from your [cock biggest].  You smack his tender rump before grabbing his slender hips and jerking him back into position.  Grabbing the base of his tail with one hand and your [cock biggest] in the other, you slowly force yourself into the bitch’s tight hole.  It’s hard work getting your [cock biggest] to slide into the tight hole.  That vicious spanking he just received isn’t making him the most receptive bitch either.  The demon’s passage quivers against your [cock biggest] as it slowly slides into him.  Once you’ve got a foot of your [cock biggest] into his body your slow advance is halted.  The tight fleshy glove wrapped around the first twelve inches of your [cock biggest] begins to shift.  As you begin to sink more of your [cock biggest] into Akbal you can feel the bitch’s body making more room.  After aiming a wicked slap to his abused cheeks you grab his hips and force the rest of your [cock biggest] into him, stretching the squirming and snarling demon to the limit.  You remind him to shut up, and the demon’s hands fly to his mouth in an attempt to silence himself and avoid further punishment.  When your trunk mashes against the demon’s tender ass, you feel his anal ring clench tight and begin to spasm.  Unable to contain himself, Akbal roars as your giant cock causes him to paint the grass beneath the two of you white.  You laugh as your embedded [cock biggest] is milked by the convulsing passage.  Once that is over he goes limp, forcing you to smack his muscled cheeks again and jerk his tender ass back into the proper position.  Now that he’s back on track you begin to rock back and forth, his passage now far more relaxed and easier to penetrate than before.");

				outputText("\n\nNow that the little bitch is somewhat comfortable, you increase the tempo.  With the full length of your [cock biggest], you begin to pound the demon with echoing claps.  Every time your body slams into his upturned rump, Akbal flinches; several times he lets out a little sexy whimper.  The combination of you plowing into his tender ass cheeks and roughly fucking his tight hole has Akbal almost failing to keep quiet.  You slap his little ass again, and he lets out a cry before desperately trying to shut himself up.  The dripping passage has your [cock biggest] pulsing with need.  As you continue to deep dick the jaguar, he suddenly howls.  His ass shoves itself backwards and clamps down around most of your [cock biggest] as he blasts the ground with ");
				if (player.cocks[x].cockLength > 12)
					outputText("another");
				else
					outputText("a");
				outputText(" blast of corrupted seed.");

				//{corruption < 90}
				if (player.cor < 90)
					outputText("\n\nThe convulsing demon hole around your [cock biggest] makes you groan as Akbal’s orgasm begin to subside, allowing you to move around in his hot, wet rectal passage once again.");
				//{corruption > 90}
				outputText("\n\nYou grab his hips and forcibly pound the little bitch’s quivering anal ring out of shape, reveling in the pulsating pressure as Akbal roars beneath you, a sound of mixed pain and ecstasy as you decimate his clenching hole with brutal thrusts.");

				outputText("\n\nAkbal claws at the ground, roaring as you slam your hips into his used and abused hole with a vengeance.  You feel [eachCock] pulsating with need as you pound the demon, brutally forcing your [cock biggest] through his demonic tailhole until you reach the point of no return.");

				//{if player has dog cock + knot}
				if (player.hasKnot(x))
					outputText("\n\nAkbal hisses as you force your swollen knot into his decimated anal ring.  Your entire body cringes as the swollen flesh is engulfed in his hot wet innards.  Your [cock biggest] explodes with the force of a megaton bomb.  With a wordless scream, you shiver as you fill Akbal full of baby batter.  As your orgasm subsides, you fall into his back, grinding your knot around in his corked bowls until the swelling goes down enough for you to tug your [cock biggest] out of his hole, sending a cascade of your seed down his gaped tailhole.");
				//{if player has horse dick}
				else if (player.cocks[x].cockType == CockTypesEnum.HORSE)
					outputText("\n\nAkbal grabs his face to keep quiet again as your [cock biggest] spears into him and flares.  Trembling, you grab his hips and rear back, blasting your baby batter into the demon’s stuffed bowels with clenched teeth.  You can feel Akbal’s innards convulsing around each segment of your [cock biggest] as he milks it for all he is worth.");
				//{if player has tentacle dick}
				else if (player.cocks[x].cockType == CockTypesEnum.TENTACLE)
					outputText("\n\nYou can hear nothing but the sound of Akbal roaring as you shove the full length of your [cock biggest] into his battered hole.  He grits his teeth as your [cock biggest] goes ballistic, rearranging his intestines with a mad dance that causes the demon to shiver out another smaller orgasm.  The mad dance stretches his hole, causing your seed to spill down your [legs], and his scrotum as you grind your [cock biggest] around in his decimated hole.");
				//{if player has cat dick}
				else if (player.cocks[x].cockType == CockTypesEnum.CAT)
					outputText("\n\nYou feel your [cock biggest] begin to jump around in Akbal’s wrecked tailhole, and he suddenly pushes back, enveloping your entire [cock biggest] and squeezing.  You roar as the demon’s flexing anal muscles send you over the edge of ecstasy.  You blast your seed into his squeezing bowls with violent convulsions that rock your body like hammer blows.  Even after your climax has fully fizzled out, the little bitch still squeezes your softening [cock biggest], making your baby batter stream down your [legs] and his.");
				//{if player has dragon dick}
				else if (player.cocks[x].cockType == CockTypesEnum.DRAGON)
					outputText("\n\nYou pound the demon’s muscular ass with steadily mounting force, sawing the bulb at the base of your [cock biggest] in and out of his hole and making him yelp with each battering ram like hammer blow to his insides.  With a dragon’s roar you climax, filling the demon’s shivering bowls with your funky seed as he shivers from the rough fucking and spanking you’ve given him.  Streams of your white goo spill down his scrotum and your [legs] making you smile as the demon goes limp beneath you.");
				//{If player has Lizard dick}
				else if (player.cocks[x].cockType == CockTypesEnum.LIZARD)
					outputText("\n\nAkbal’s insides quiver in time with your mad thrusts.  You watch the bumpy, purple blur of your [cock biggest] sawing in and out of Akbal until the sensation causes you to throw you head back.  With a groan your [cock biggest] explodes, sending torrents of spunk into Akbal’s bowls as you shove in and hold.  Your body trembles as you yank your still spurting [cock biggest] out of Akbal’s hole and paint his round muscular abused cheeks with a few gouts of jizz.");
				//{if player has human/kanga dick}
				else
					outputText("\n\nAs your [cock biggest] paints Akbal’s anal walls white, you continue to fuck his decimated ass.  Each spurt from your brings a wave of relief as you slam into the demon’s hole with freight train force, pounding his tender ass as you shoot cream into his quivering hole.  As your orgasm subsides, you aim a last slap at the demon’s ass, one that causes him to squeeze his abused cheeks and send cream rushing past your embedded [cock biggest] and down his furry scrotum.");

				outputText("\n\nAs you rise, Akbal goes limp. You cannot help but chuckle as looking down, you realize you have made quite the mess.  The demon’s body trembles as he looks back, his eyes questioning if his bitch duties are done. Satisfied you gather your [armor] and leave Akbal to it. When you reach the edge of the forest you hear the sound of him asserting his dominance over an Imp.  You stop and listen to the sound of the demon trying to reclaim his manhood, knowing the entire time his ass is sore and dripping, reminding him of how much of a bitch he truly is.");
			}
			//{female/genderless}
			else
			{
				outputText(images.showImage("akbal-deepwoods-female-highspeed"));
				outputText("\n\nYou flip the demon over; he barely suppresses a hiss as his sore ass cheeks hit the forest floor.  With the vine that acts as a leash to his little collar, you straddle his face, tugging the demon’s muzzle into your [vagOrAss].");
				outputText("\n\nLike an obedient bitch, he follows your silent command without hesitation.  As the wide jaguar tongue laps at your [vagOrAss], you grind into the sensation of exploding pleasure.  His glorious saliva has you quivering in moments.  If that was not enough, he masterfully manipulates your [vagOrAss], masterfully tickling your ");
				if (player.hasVagina())
					outputText("[clit]");
				else
					outputText("prostate");
				outputText(" with his long tongue.  Your body convulses slightly as you maintain a tight grip on the collar, keeping his face buried under the weight of your [vagOrAss] as that wonderful tongue sends you to paradise.");

				outputText("\n\nYou tell your bitch to use his hands. The demon’s hands fly to your [hips].  The hot palms, covered in soft tickling fur, slide up your ");
				if (player.thickness <= 33)
					outputText("slim");
				else if (player.thickness <= 66)
					outputText("muscular");
				else
					outputText("voluptuous");
				outputText(" body until he reaches your [fullChest].  After a second of feeling around he finds your [nipples].");

				//[if (hasNippleCunts = False)]
				if (!player.hasFuckableNipples())
					outputText("\n\nThe demon gently teases your erect [nipples] with his hands before rubbing your [fullChest] in large circular motions.  The feeling of his soft fur gliding across your " + player.skinFurScales() + " in combination with his mouth and tongue attacking your [vagOrAss] is making your body convulse.");
				else
					outputText("\n\nThe demon lets out a sound of surprise against your [vagOrAss] as he notices your [nipples].  He delves a finger into your [nipple] and swabs the moist cavity with a curious finger.  After a few moments of playing with your [nipples] he begins rubbing your [fullChest] in large circular motions.  He takes time to tease each of your tits with the feeling of his soft fur until you can take no more.");

				outputText("\n\nYou shove the demon away from you, sliding down his body with a sexy little grin.  You waste no time reaching for his barbed dick and aiming it at your [vagOrAss] before squatting down until his rigid length is poised at your entrance.");

				//{tight/virgin Vag/ass}
				if ((!player.hasVagina() && player.ass.analLooseness < 2) || (player.hasVagina() && player.looseness() <= 2))
				{
					outputText("\n\nAs your [vagOrAss] touches the mushroom-shaped head of Akbal’s barbed dick, your body is hit with an explosion of pleasure.  The sensation is pure ecstasy, blasting through your body from your [vagOrAss].  Your [vagOrAss] begins to stretch, the mystic mixture of Akbal’s spit and the lube soaking his erect dick allowing you to take the gargantuan barbed dick without a problem.  The feeling of your flesh widening to encompass Akbal’s dick is both alien and wonderful.  Once you can take the entire length you begin bouncing up and down his euphoria inducing dick with a huge grin on your [face].");
				}
				//{medium vag/ass}
				else if ((!player.hasVagina() && player.ass.analLooseness < 4) || (player.hasVagina() && player.looseness() < 4))
				{
					outputText("\n\nAs your [vagOrAss] touches the mushroom-shaped head of Akbal’s barbed dick, your body is hit with an explosion of ecstasy.  The feeling of Akbal’s giant sex organ just sitting inside your [vagOrAss] sends waves of pure pleasure through your body.  Throwing your head back you ride the demon for all you are worth.");
				}
				//{Gaped vag/ass}
				else
				{
					outputText("\n\nAs your [vagOrAss] touches the wet, mushroom-shaped head of Akbal’s barbed dick, you begin to swoon.  The feeling of his lube-covered dick touching your spit soaked [vagOrAss] is like an ocean of pleasure crashing through your body.  You allow yourself to be swept away by the tidal wave and begin sliding up and down Akbal’s dick with practiced ease.  With a grimace of pure euphoria plastered on your face, you ride the demon with everything you’ve got.");
				}
				//{cunt or butt change}
				if (player.hasVagina())
					player.cuntChange(16, true, true, false);
				else
					player.buttChange(16, true, true, false);

				outputText("\n\nThe demon begins trying to slide his dick up into you to increase his own pleasure.  With a single raise of your hand, he stops and you’re free to control your own pace, and with that freedom, you increase tempo until the demon’s teeth are clenched and his toes curled.  He has to fight to keep still, which amuses you, as his fear of more pain wins out against his legendary lust.  Then you feel it.  His body begins to convulse.  You feel his dick explode inside you, filling you with a hot warmth that intensifies the chemical reactions taking place inside your [vagOrAss].");

				outputText("\n\nWith a shrill cry you cum, your [vagOrAss] erupts, sending a cascade of wetness down Akbal’s embedded shaft.");
				//[if (hasCock = True)
				if (player.hasCock())
					outputText("  [EachCock] erupts at the same time, painting Akbal’s chest with white goo.  As each orgasm overtakes you, you are reduced to a quivering mess.  Say what you want about the little bitch, but his dick is like no other.");
				outputText("  As your orgasm subsides you allow the demon to grind his still erect dick around inside you for a moment. Without needing to threaten him again you rise, sending a cascade of spooge down your legs and onto Akbal’s lap.");

				outputText("\n\nWithout a backwards glance, you gather your [armor] and leave the forest with a big smile on your [face].");
			}
			if (player.hasVagina())
				player.knockUp(PregnancyStore.PREGNANCY_IMP, PregnancyStore.INCUBATION_IMP, 101);
			player.orgasm();
			dynStats("cor", 3);
			doNext(camp.returnToCampUseOneHour);
		}
	}
}
