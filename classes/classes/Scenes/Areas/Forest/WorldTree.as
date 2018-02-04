/**
 * ...
 * @author Zavos
 */
package classes.Scenes.Areas.Forest 
{
import classes.*;
import classes.BodyParts.Arms;
import classes.BodyParts.Ears;
import classes.BodyParts.Face;
import classes.BodyParts.Hair;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kFLAGS;
import classes.Items.MutationsHelper;

public class WorldTree extends BaseContent
	{
		public var mutations:MutationsHelper = new MutationsHelper();
		
		public function WorldTree() 
		{
			
		}
		
		public function YggdrasilDiscovery():void {
			clearOutput();
			outputText("With your soul sense, tracing the song back to it’s source is a simple task. Before long, you’re walking the same path in the deep woods as before, and soon you reach the same statuesque tree.\n\n");
			if (player.plantScore() < 4 && player.yggdrasilScore() < 1) {
				outputText("You feel the song resonate within the tree, but you cannot discern its source, or anything about the tree. Its size aside, it appears perfectly normal, and you are certain there are even other trees of similar size elsewhere in the forest. When you take a break to meditate on the tree, you come to the realization that you only felt the song without the soul sense when you were a ");
				outputText("" + player.mf("Treant", "Dryad") +". Perhaps if you regained that particular form, you could understand the true meaning behind this peculiar tree?\n\n");
				doNext(camp.returnToCampUseOneHour);
			}
			else {
				if (flags[kFLAGS.YGGDRASIL_GENERAL] < 1) {
					outputText("You touch the tree, just like you did in your dream, but your hand phases through the bark. You jerk your arm out in shock and cautiously examine the bark. It appears solid, but at the same time experimentation shows that it appears you can move through it as if it was just an illusion.  After mustering what courage you have, you attempt to walk through the surface of the trunk, only to find yourself in a hollow chamber within the tree.\n\n");
					outputText("\"<i>Welcome home.</i>\"  The sound seems to come from everywhere and nowhere at once. \"<i>We are Yggdrasil.</i>\" You look around to find the source of the sound, but you appear to be the only figure in the chamber. \"<i>You appear confused.  We are not one entity, but many.  We are the voice of the forest, of Mareth. We have been watching you...</i>\" You don’t sense any sort of maliciousness from the tree, nor in its words. If anything, it seems to be happy to speak with you.  But why has it been watching you, you ask.\n\n");
					outputText("\"<i>This world is spiraling towards destruction. The war of the pure and the corrupt is slowly suffocating the land. Corruption and purity must be brought into balance, for the good of all life.  To that end, we have been hoping you would restore the balance. We wish to offer you a gift... You have taken the form of one of Marae’s seedlings, but with our blessing you can become a true child of Mareth. A defender of the forest. You can defend us as our child, our champion...</i>\"\n\n");
					outputText("Well, that's quite the proposal.\n\n");
					if (flags[kFLAGS.YGGDRASIL_GENERAL] < 1) flags[kFLAGS.YGGDRASIL_GENERAL]++;
					menu();
					addButton(0, "What are you", WhatAreYou).hint("What is Yggdrasil, exactly?");
					addButton(1, "Purity & Corruption", PurityCorruption).hint("What side is Yggdrasil on, pure or corrupt?");
					if (flags[kFLAGS.YGGDRASIL_BRANCH] < 1) addButton(2, "Aid", AidTakeBranch).hint("Can Yggdrasil provide any assistance for your quest?");
					else addButton(2, "Take Branch", AidTakeBranch).hint("Take a fallen branch of the world tree");
					if (flags[kFLAGS.YGGDRASIL_TF] < 1) addButton(3, "Accept", AcceptTransform);
					else {
						if (player.yggdrasilScore() < 10) addButton(3, "Transform", AcceptTransform);
						else addButtonDisabled(3, "Transform", "You're already full transformed into Yggdrasil.");
					}
					if (flags[kFLAGS.YGGDRASIL_TF] < 1) addButton(14, "Decline", DeclineWolrdTreeOffer);
					else addButton(14, "Leave", LeaveWorldTree);
				}
				else {
					outputText("You calmly walk into the tree, feeling the illusion like bark part around you as you enter the chamber within, and feel the presence of Yggdrasil all around you. \"<i>Welcome back, ");
					if (flags[kFLAGS.YGGDRASIL_TF] < 1) outputText("Champion");
					else outputText("my child");
					outputText(".  If you have questions, ask.  If you have any requests, i will do what i can to fulfil them.</i>\"\n\n");
					menu();
					addButton(0, "What are you", WhatAreYou).hint("What is Yggdrasil, exactly?");
					addButton(1, "Purity & Corruption", PurityCorruption).hint("What side is Yggdrasil on, pure or corrupt?");
					if (flags[kFLAGS.YGGDRASIL_BRANCH] < 1) addButton(2, "Aid", AidTakeBranch).hint("Can Yggdrasil provide any assistance for your quest?");
					else addButton(2, "Take Branch", AidTakeBranch).hint("Take a fallen branch of the world tree");
					if (flags[kFLAGS.YGGDRASIL_TF] < 1) addButton(3, "Accept", AcceptTransform);
					else {
						if (player.yggdrasilScore() < 10) addButton(3, "Transform", AcceptTransform);
						else addButtonDisabled(3, "Transform", "You're already full transformed into Yggdrasil.");
					}
					if (flags[kFLAGS.YGGDRASIL_TF] < 1) addButton(14, "Decline", DeclineWolrdTreeOffer);
					else addButton(14, "Leave", LeaveWorldTree);
				}
			}
			
		}
		
		public function YggdrasilMainMenu():void {
			clearOutput();
			outputText("PLACEHOLDER TILL ZAVOS WIRTE TEXT FOR THIS MENU.\n\n");
			menu();
			addButton(0, "What are you", WhatAreYou).hint("What is Yggdrasil, exactly?");
			addButton(1, "Purity & Corruption", PurityCorruption).hint("What side is Yggdrasil on, pure or corrupt?");
			if (flags[kFLAGS.YGGDRASIL_BRANCH] < 1) addButton(2, "Aid", AidTakeBranch).hint("Can Yggdrasil provide any assistance for your quest?");
			else addButton(2, "Take Branch", AidTakeBranch).hint("Take a fallen branch of the world tree");
			if (flags[kFLAGS.YGGDRASIL_TF] < 1) addButton(3, "Accept", AcceptTransform);
			else {
				if (player.yggdrasilScore() < 10) addButton(3, "Transform", AcceptTransform);
				else addButtonDisabled(3, "Transform", "You're already full transformed into Yggdrasil.");
			}
			if (flags[kFLAGS.YGGDRASIL_TF] < 1) addButton(14, "Decline", DeclineWolrdTreeOffer);
			else addButton(14, "Leave", LeaveWorldTree);
		}
		
		public function WhatAreYou():void {
			clearOutput();
			outputText("\"<i>We are Yggdrasil. You do not understand. You could, but you probably would not. We are the natural life of Mareth, from every tree to every blade of grass. We are the natural world. You stand in our “body”, but it is nothing but a shell to be filled with our voices, to hone our whispers into a song of life, an image to speak on our behalf. Alone, we are nothing, unthinking.  Together, we are Yggdrasil.</i>\"\n\n");
			doNext(YggdrasilMainMenu);
		}
		
		public function PurityCorruption():void {
			clearOutput();
			outputText("\"<i>We are pure. We are corrupt. We embody the natural balance, both corrupt and pure. We are the holy fruits planted by Marae. We are the corrupt vines sown by Lethice. Once, we were naught but purity and neutrality, but now we are a voice for the corrupt as well.  Naught amongst us deserves to exist more than any other.</i>\"\n\n");
			doNext(YggdrasilMainMenu);
		}
		
		public function AidTakeBranch():void {
			clearOutput();
			if (flags[kFLAGS.YGGDRASIL_BRANCH] < 1) {
				outputText("\"<i>We have great power, but our ability to use it is...  limited. ");
				if (player.yggdrasilScore() < 10) outputText("What power we can grant you, we offer freely, you need only accept.");
				else outputText("We have already offered you what power we could.");
				outputText(" But perhaps there is something more. This tree is naught but a shell, but millennia of focusing our song has imbued it with a fragment of our power. Granted it what you call “soulforce”.</i>\"\n\n");
				outputText("You hear rumbling all around you. Its an earthquake! As you struggle to maintain your balance, branches fall around you from the darkness above. As the tremors still, you look around, and then up. You’re inside a tree, how did the branches get... there? \"<i>These twigs have power beyond mere wood. Take any piece you desire, ");
				if (player.hasStatusEffect(StatusEffects.CampRathazul)) outputText("you already know someone who can turn it into a weapon befitting a champion.</i>\"\n\n");
				else outputText("we have faith you will find a way to use it in our defense.</i>\"\n\n");
				if (flags[kFLAGS.YGGDRASIL_BRANCH] < 1) flags[kFLAGS.YGGDRASIL_BRANCH]++;
			}
			else {
				if (flags[kFLAGS.YGGDRASIL_BRANCH] > 1) {
					outputText("\"<i>You ask Yggdrasil for permission to take another fallen branch from her tree. “Of course, do with it what you will.</i>\"  ");
				}
				outputText("You look for the most promising of the sections of wood around you. While at first they all look different, the quality of wood in every branch is high, and they are all large enough to create a two handed weapon if you so desire. A bow perhaps? Or maybe a staff?\n\n");
				if (flags[kFLAGS.YGGDRASIL_BRANCH] < 2) flags[kFLAGS.YGGDRASIL_BRANCH]++;
			}
			inventory.takeItem(useables.WT_BRAN, YggdrasilMainMenu);
		}
		
		public function AcceptTransform():void {
			clearOutput();
			outputText("\"<i>Then listen to our song. Here, at the center of our power, accept it into yourself.</i>\" You nod and begin to focus... the song is all around you, the resonation of countless flora and fauna. As time passes you begin to feel as though you are more than a listener, you feel as if you are swimming in a river of power that begs you to let it in. After a moment of hesitation, you mentally submerge yourself in the song, feeling it resonate in your mind, body and soul.\n\n");
			yggdrasilTF();
			outputText("After the transformations brought about by the song subside, you stand and examine your new body. ");
			if (flags[kFLAGS.YGGDRASIL_TF] < 1) {
				outputText("\"<i>You are now a true child of Mareth. You are now a seedling of Yggdrasil, a child of the world tree. Go, and defend us as our champion!</i>\"");
			}
			else outputText("\"<i>And thus... your true form is restored.</i>\"");
			outputText("You thank the mother tree");
			if (flags[kFLAGS.YGGDRASIL_TF] < 1) outputText("... your adoptive mother");
			outputText(". After some time getting used to your form, you leave the tree and return to your camp.\n\n");
			if (flags[kFLAGS.YGGDRASIL_TF] < 1) flags[kFLAGS.YGGDRASIL_TF]++;
			doNext(YggdrasilMainMenu);
		}
		
		public function DeclineWolrdTreeOffer():void {
			outputText("\"<i>So be it. You are welcome here always, particularly if you change your mind.</i>\" After a minute of looking for the exit, you find the spot you entered from. Once you are out in the daylight, the events within the tree seem somewhat surreal, almost feeling like they were little more than a dream. Shaking your head and resolving to think on this later,you make your way back to your camp.\n\n");
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function LeaveWorldTree():void {
			outputText("You bid Yggdrasil farewell and return to your camp.\n\n");
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function yggdrasilTF():void
		{
			var changes:Number = 0;
			var changeLimit:Number = 2;
			if (rand(2) == 0) changeLimit++;
			if (rand(2) == 0) changeLimit++;
			if (rand(2) == 0) changeLimit++;
			//staman/tentacle cock
			if (player.gender <= 1 || (player.gender == 3 && player.mf("m", "f") == "m")) {
				if (player.cor >= 66) {
					if (player.cockTotal() > player.tentacleCocks()) {
						var choices:Array = [];
						var i:int = 0;
						while(i < player.cockTotal()) {
							if(player.cocks[i].cockType != CockTypesEnum.TENTACLE) choices[choices.length] = i;
							i++;
						}
						i = choices[rand(choices.length)];
						outputText("Your " + num2Text2(i+1) + " penis itches, and you idly scratch at it.  As you do, it begins to grow longer and longer, all the way to the ground before you realize something is wrong.  You pull open your [armor] and look down, discovering your " + cockDescript(i) + " has become a tentacle!  As you watch, it shortens back up; it's colored green except for a purplish head, and evidence seems to suggest you can make it stretch out at will.  <b>You now have a");
						if(player.tentacleCocks() > 0) outputText("nother");
						outputText(" tentacle-cock!</b>\n\n");
						player.cocks[i].cockType = CockTypesEnum.TENTACLE;
						player.cocks[i].knotMultiplier = 1.3;
						dynStats("sen", 3, "lus", 10);
						changes++;
					}
				}
				if (player.cor >= 33 && player.cor < 66) {
					if (rand(2) == 0) {
						if (player.cockTotal() > player.tentacleCocks()) {
							var choices2:Array = [];
							i = 0;
							while(i < player.cockTotal()) {
								if(player.cocks[i].cockType != CockTypesEnum.TENTACLE) choices2[choices2.length] = i;
								i++;
							}
							i = choices2[rand(choices2.length)];
							outputText("Your " + num2Text2(i+1) + " penis itches, and you idly scratch at it.  As you do, it begins to grow longer and longer, all the way to the ground before you realize something is wrong.  You pull open your [armor] and look down, discovering your " + cockDescript(i) + " has become a tentacle!  As you watch, it shortens back up; it's colored green except for a purplish head, and evidence seems to suggest you can make it stretch out at will.  <b>You now have a");
							if(player.tentacleCocks() > 0) outputText("nother");
							outputText(" tentacle-cock!</b>\n\n");
							player.cocks[i].cockType = CockTypesEnum.TENTACLE;
							player.cocks[i].knotMultiplier = 1.3;
							dynStats("sen", 3, "lus", 10);
							changes++;
						}
					}
					else {
						if (player.cockTotal() > player.stamenCocks()) {
							var choices3:Array = [];
							i = 0;
							while(i < player.cockTotal()) {
								if(player.cocks[i].cockType != CockTypesEnum.STAMEN) choices3[choices3.length] = i;
								i++;
							}
							i = choices3[rand(choices3.length)];
							outputText("You feel a strange tingling in your " + num2Text2(i+1) + " cock. You remove your [armor] and look down and witness your cock shifting into a peculiar form. Its tapered, " + player.skinTone + " and crowned by several colorful balls that look sort of like knots. Its covered in sweet smelling dust...  you're secreting pollen!  <b>You now have a");
							if(player.tentacleCocks() > 0) outputText("nother");
							outputText(" plantlike stamen cock!</b>\n\n");
							player.cocks[i].cockType = CockTypesEnum.STAMEN;
							player.cocks[i].knotMultiplier = 1.3;
							dynStats("sen", 3, "lus", 10);
							changes++;
						}
					}
				}
				if (player.cor < 33) {
					if (player.cockTotal() > player.stamenCocks()) {
						var choices4:Array = [];
						i = 0;
						while(i < player.cockTotal()) {
							if(player.cocks[i].cockType != CockTypesEnum.STAMEN) choices4[choices4.length] = i;
							i++;
						}
						i = choices4[rand(choices4.length)];
						outputText("You feel a strange tingling in your " + num2Text2(i+1) + " cock. You remove your [armor] and look down and witness your cock shifting into a peculiar form. Its tapered, " + player.skinTone + " and crowned by several colorful balls that look sort of like knots. Its covered in sweet smelling dust...  you're secreting pollen!  <b>You now have a");
						if(player.tentacleCocks() > 0) outputText("nother");
						outputText(" plantlike stamen cock!</b>\n\n");
						player.cocks[i].cockType = CockTypesEnum.STAMEN;
						player.cocks[i].knotMultiplier = 1.3;
						dynStats("sen", 3, "lus", 10);
						changes++;
					}
				}
			}
			//{hair exists, no leaves/tentacle hair: leaves/tentacle hair tf}
			if (player.hairColor == "green" && player.hairLength > 0 && (player.hairType != Hair.LEAF && player.hairType != Hair.GRASS && player.hairType != Hair.ANEMONE) && !player.isGargoyle() && changes < changeLimit)
			{
				if (player.cor >= 66) {
					outputText("Your balance slides way off, and you plop down on the ground as mass concentrates on your head.  Reaching up, you give a little shriek as you feel a disturbingly thick, squirming thing where your hair should be.  Pulling it down in front of your eyes, you notice it's still attached to your head; what's more, it's the same color as your hair used to be.  <b>You now have squirming tentacles in place of hair!</b>  As you gaze at it, a gentle heat starts to suffuse your hand.  The tentacles must be developing their characteristic stingers!  You quickly let go; you'll have to take care to keep them from rubbing on your skin at all hours.  On the other hand, they're quite short and you find you can now flex and extend them as you would any other muscle, so that shouldn't be too hard.  You settle on a daring, windswept look for now.");
					player.hairType = Hair.ANEMONE;
					player.hairLength = 5;
					if (flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] == 0) {
						outputText("  <b>(Your hair has stopped growing.)</b>\n\n");
						flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] = 1;
					}
				}
				if (player.cor >= 33 && player.cor < 66) {
					if (rand(2) == 0) {
						outputText("Your balance slides way off, and you plop down on the ground as mass concentrates on your head.  Reaching up, you give a little shriek as you feel a disturbingly thick, squirming thing where your hair should be.  Pulling it down in front of your eyes, you notice it's still attached to your head; what's more, it's the same color as your hair used to be.  <b>You now have squirming tentacles in place of hair!</b>  As you gaze at it, a gentle heat starts to suffuse your hand.  The tentacles must be developing their characteristic stingers!  You quickly let go; you'll have to take care to keep them from rubbing on your skin at all hours.  On the other hand, they're quite short and you find you can now flex and extend them as you would any other muscle, so that shouldn't be too hard.  You settle on a daring, windswept look for now.");
						player.hairType = Hair.ANEMONE;
						player.hairLength = 5;
						if (flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] == 0) {
							outputText("  <b>(Your hair has stopped growing.)</b>\n\n");
							flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] = 1;
						}
					}
					else {
						if (rand(2) == 0) {
							outputText("Your [hair] begins to fall out in clumps, eventually leaving your scalp completely bald.  Although, thankfully, it does not remain like that for long.  Within moments a full head of grass sprouts from the skin of your scalp, protecting it from the chilly wind which was starting to annoy you.  You run your hands through your newly grown hair-like grass, stifling a moan at how sensitive the thousands of long, soft and leafy blades that replaced your hair are.  <b>Your hair has been replaced by grass, your scalp is now covered with soft blades of verdant greenery...</b>\n\n");
							player.hairType = Hair.GRASS;
						}
						else {
							outputText("Your [hair] begins to fall out in globs, eventually leaving you with a bald head.  Your head is not left bald for long, though.  Within moments, a full head of leaf sprouts from the skin of your scalp.  You run your hands through your new growth, sighing at the pleasure of being able to feel each individual leaf.  <b>Your hair turned into thin leafs replacing your current hair!</b>\n\n");
							player.hairType = Hair.LEAF;
						}
					}
				}
				if (player.cor < 33) {
					if (rand(2) == 0) {
						outputText("Your [hair] begins to fall out in clumps, eventually leaving your scalp completely bald.  Although, thankfully, it does not remain like that for long.  Within moments a full head of grass sprouts from the skin of your scalp, protecting it from the chilly wind which was starting to annoy you.  You run your hands through your newly grown hair-like grass, stifling a moan at how sensitive the thousands of long, soft and leafy blades that replaced your hair are.  <b>Your hair has been replaced by grass, your scalp is now covered with soft blades of verdant greenery...</b>\n\n");
						player.hairType = Hair.GRASS;
					}
					else {
						outputText("Your [hair] begins to fall out in globs, eventually leaving you with a bald head.  Your head is not left bald for long, though.  Within moments, a full head of leaf sprouts from the skin of your scalp.  You run your hands through your new growth, sighing at the pleasure of being able to feel each individual leaf.  <b>Your hair turned into thin leafs replacing your current hair!</b>\n\n");
						player.hairType = Hair.LEAF;
					}
				}
				changes++;
			}
			//green hair
			if (player.hairColor != "green" && !player.isGargoyle() && changes < changeLimit)
			{
				outputText("At first it looks like nothing changed but then you realize all the hair on your body has shifted to a verdant green color.  <b>You now have green hair.</b>\n\n");
				player.hairColor = "green";
			}
			//Vines/tentacles arms
			if (player.cor >= 66) {
				if (player.arms.type != Arms.PLANT2 && changes < changeLimit) {
					outputText("You watch, spellbound, while your arms gradually change their entire outer structure into plain human-like form. Soon after you start feel something new tickling and crawling its way into being, this time on your shoulders, working its way down your arms.Looking over them you can see veined, vaguely phallic vines wrapping their way around your entire arm, in a manner that is decorative but oddly perverse. They remind you of the tentacle monsters in the forest...  <b>You now have tentacle-covered arms.</b>\n\n");
					player.arms.type = Arms.PLANT2;
					changes++;
				}
			}
			if (player.cor >= 33 && player.cor < 66) {
				if (rand(2) == 0) {
					if (player.arms.type != Arms.PLANT2 && changes < changeLimit) {
						outputText("You watch, spellbound, while your arms gradually change their entire outer structure into plain human-like form. Soon after you start feel something new tickling and crawling its way into being, this time on your shoulders, working its way down your arms.Looking over them you can see veined, vaguely phallic vines wrapping their way around your entire arm, in a manner that is decorative but oddly perverse. They remind you of the tentacle monsters in the forest...  <b>You now have tentacle-covered arms.</b>\n\n");
						player.arms.type = Arms.PLANT2;
						changes++;
					}
				}
				else {
					if (player.arms.type != Arms.PLANT && changes < changeLimit) {
						outputText("You watch, spellbound, while your arms gradually changing it entire outer structure into plain human-like form. Soon after you start feel something new tickling and crawling its way into being, this time on your shoulders, working its way down your arms.  Looking on them you can see a thin, delicate vines, with spade-shaped leaves unfolding from them as they curl snugly around your biceps and deltoids all the way down to your wrists. <b>You now have vine-covered arms.</b>\n\n");
						player.arms.type = Arms.PLANT;
						changes++;
					}
				}
			}
			if (player.cor < 33) {
				if (player.arms.type != Arms.PLANT && changes < changeLimit) {
					outputText("You watch, spellbound, while your arms gradually changing it entire outer structure into plain human-like form. Soon after you start feel something new tickling and crawling its way into being, this time on your shoulders, working its way down your arms.  Looking on them you can see a thin, delicate vines, with spade-shaped leaves unfolding from them as they curl snugly around your biceps and deltoids all the way down to your wrists. <b>You now have vine-covered arms.</b>\n\n");
					player.arms.type = Arms.PLANT;
					changes++;
				}
			}
			//Cockvine wings
			if ((player.arms.type == Arms.PLANT || player.arms.type == Arms.PLANT2) && player.wings.type != Wings.PLANT && player.lowerBody != LowerBody.PLANT_FLOWER && changes < changeLimit && rand(3) == 0) {
				if (player.wings.type != Wings.NONE) {
					outputText("Your old wings are drooping leaving your back as smooth and unbroken as the day you entered the portal. But this state not last long.\n\n");
				}
				outputText("Pressure is building in multiple spots on your upper back. It feels more like several over-eager erections trapped in incredibly tight undies. You can’t help but groan with relief when finally the pressure peaks and many thick protrusions burst impatiently out of your [skin.type]. The hot, thick, vine-like growths thrust their way into being, feet of oily green tentacles, alarmingly energetic and prehensile, thrashing around your " + hipDescript() + ".");
				outputText(" After a moment of concentration you cause one of these growths to rear around into your hand to take a closer look at it. It feels unmistakably dick-like - bulging, tender flesh under the fibrous skin, with quite a bit of flexible, able to bend all along its length and dart its wet, distended head in any direction you wish. <b>You now have cockvine wings.</b>\n\n");
				player.wings.type = Wings.PLANT;
				changes++;
			}
			//Bark claws
		//	if (player.arms.type != ORCA && changes < changeLimit) {
		//		outputText("\n\nRemarkably, the sunscreen has no effect.  Maybe next time?");
		//		player.arms.type = ORCA;
		//		changes++;
		//	}
			//Root claws
			if (player.wings.type == Wings.PLANT && player.lowerBody != LowerBody.YGG_ROOT_CLAWS && changes < changeLimit) {
				outputText("You lose your balance and fall to the ground as your feet begin to contort. You watch as your roots rearrange into a more solid configuration. <b>Your roots have assumed the form of three-toed, clawed feet, complete with a small vestigial claw-toe on the back for added grip.</b>\n\n");
				player.lowerBody = LowerBody.YGG_ROOT_CLAWS;
				if (player.legCount != 2) player.legCount = 2;
				changes++;//player.arms.type == ORCA && 
			}
			//Plant Dragon face
			if (player.lowerBody == LowerBody.YGG_ROOT_CLAWS && player.faceType != Face.PLANT_DRAGON && changes < changeLimit) {
				outputText("The familiar tingle of transformation spreads across your face. Your ");
				if (player.hasMuzzle()) outputText("muzzle");
				else outputText("face");
				outputText(" shifts into a vaguely triangular shape, something that would look at home on a predatory reptile...  or a dragon. You feel pride swell within you as you look at your reflection inh a puddle at your feet, your new look now resembles a majestic creature of the old myths. <b>Your face is now a dragonlike muzzle!</b>\n\n");
				player.faceType = Face.PLANT_DRAGON;
				changes++;
			}
			//Plant dragon tail
			if (player.faceType == Face.PLANT_DRAGON && player.tailType != Tail.YGGDRASIL && changes < changeLimit) {
				outputText("You feel a weird sensation in your ");
				if (player.tailType > Tail.NONE) {
					outputText("tail");
					if (player.tailCount > 1) outputText("s");
				}
				else outputText("tailbone");
				outputText(". It kind of feels cool, pleasurable and makes you queasy all at once. Suddenly, ");
				if (player.tailType > Tail.NONE) outputText("it begins to twist and writhe as the odd sensation intensifies.  Before your eyes, it twists into a reptilian appendage");
				else outputText("your tailbone erupts and elongates into a new limb, your new tail");
				outputText(". Long, thin, prehensile, good for maintaining your balance. As if in conclusion, a leaf suddenly sprouts from the tip of your tail. <b>You now have a leaf-tipped reptilian tail!</b>\n\n");
				player.tailType = Tail.YGGDRASIL;
				if (player.tailCount != 1) player.tailCount = 1;
				changes++;
			}
			//Moss (fur)/else Bark skin
			if ((player.skinType != Skin.BARK || player.skinType != Skin.PARTIAL_BARK) && !player.isGargoyle() && changes < changeLimit && player.faceType == Face.PLANT_DRAGON) {
				if (player.hasFur()) outputText("You scratch yourself, and come away with a large clump of " + player.coatColor + " fur. Panicked, you look down and realize that your fur is falling out in huge clumps. It itches like mad, and you scratch your body relentlessly, removing the fur to see the changes beneath.");
				else outputText("You idly scratch an itch, but recoil when you feel the wrong texture in the wrong place.");
				outputText(" You watch as flakes of skin peel away to reveal...  scales?  On closer examination, it appears that your “scales” are actually some form of bark. <b>You are now covered by scale-like bark from head to toe.</b>\n\n");
				player.skin.growCoat(Skin.SCALES,{color:"mahogany",adj:"bark-like"},Skin.COVERAGE_COMPLETE);
				changes++;	
			}
			if (player.ears.type != Ears.LIZARD && player.tailType == Tail.YGGDRASIL && player.lowerBody == LowerBody.YGG_ROOT_CLAWS && changes < changeLimit) {
				outputText("All around you, a omnipresent buzzing is gradually becoming louder and louder.  Suddenly, you realize that it’s become painfully loud, the force of the sound making your eardrums throb painfully.  You attempt to block the sound with your ears, but your hands can’t find any ears to plug!  Suddenly, the buzzing stops, and the ringing in your ears begins to subside.  Probing the side of your head with your hands, you realize that your ears have become ");
				if (player.hasFur() || player.hairLength > 0) outputText("discreet ");
				outputText("earholes onthe side of your head. <b>You now have lizardlike ears.</b>\n\n");
				player.ears.type = Ears.LIZARD;
				changes++;
			}
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}
		
	}

}