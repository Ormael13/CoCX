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
import classes.BodyParts.Horns;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kFLAGS;
import classes.Races.YgddrasilRace;
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
			if (!player.isRace(Races.PLANT, 1, false) && player.racialScore(Races.YGGDRASIL, false) == 0) {
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
					YggdrasilMenu();
				}
				else {
					outputText("You calmly walk into the tree, feeling the illusion like bark part around you as you enter the chamber within, and feel the presence of Yggdrasil all around you. \"<i>Welcome back, ");
					if (flags[kFLAGS.YGGDRASIL_TF] < 1) outputText("Champion");
					else outputText("my child");
					outputText(".  If you have questions, ask.  If you have any requests, i will do what i can to fulfil them.</i>\"\n\n");
					YggdrasilMenu();
				}
			}

		}

		public function YggdrasilMainMenu():void {
			clearOutput();
			outputText("PLACEHOLDER TILL ZAVOS WIRTE TEXT FOR THIS MENU.\n\n");
			YggdrasilMenu();
		}

		public function YggdrasilMenu():void {
			menu();
			addButton(0, "What are you", WhatAreYou).hint("What is Yggdrasil, exactly?");
			addButton(1, "Purity & Corruption", PurityCorruption).hint("What side is Yggdrasil on, pure or corrupt?");
			if (flags[kFLAGS.YGGDRASIL_BRANCH] < 1) addButton(2, "Aid", AidTakeBranch).hint("Can Yggdrasil provide any assistance for your quest?");
			else addButton(2, "Take Branch", AidTakeBranch).hint("Take a fallen branch of the world tree");
			if (flags[kFLAGS.YGGDRASIL_TF] < 1) addButton(3, "Accept", AcceptTransform);
			else addButton(3, "Transform", AcceptTransform);
			if (flags[kFLAGS.YGGDRASIL_TF] < 1) addButton(14, "Decline", DeclineWolrdTreeOffer);
			else addButton(14, "Leave", LeaveWorldTree);
		}

		public function WhatAreYou():void {
			clearOutput();
			outputText("\"<i>We are Yggdrasil. You do not understand. You could, but you probably would not. We are the natural life of Mareth, from every tree to every blade of grass. We are the natural world. You stand in our \"body\", but it is nothing but a shell to be filled with our voices, to hone our whispers into a song of life, an image to speak on our behalf. Alone, we are nothing, unthinking.  Together, we are Yggdrasil.</i>\"\n\n");
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
				if (!player.isRace(Races.YGGDRASIL, 1, false)) outputText("What power we can grant you, we offer freely, you need only accept.");
				else outputText("We have already offered you what power we could.");
				outputText(" But perhaps there is something more. This tree is naught but a shell, but millennia of focusing our song has imbued it with a fragment of our power. Granted it what you call \"soulforce\".</i>\"\n\n");
				outputText("You hear rumbling all around you. Its an earthquake! As you struggle to maintain your balance, branches fall around you from the darkness above. As the tremors still, you look around, and then up. You’re inside a tree, how did the branches get... there? \"<i>These twigs have power beyond mere wood. Take any piece you desire, ");
				if (player.hasStatusEffect(StatusEffects.CampRathazul)) outputText("you already know someone who can turn it into a weapon befitting a champion.</i>\"\n\n");
				else outputText("we have faith you will find a way to use it in our defense.</i>\"\n\n");
				if (flags[kFLAGS.YGGDRASIL_BRANCH] < 1) flags[kFLAGS.YGGDRASIL_BRANCH]++;
			}
			else {
				if (flags[kFLAGS.YGGDRASIL_BRANCH] > 1) {
					outputText("\"<i>You ask Yggdrasil for permission to take another fallen branch from her tree. \"Of course, do with it what you will.</i>\"  ");
				}
				outputText("You look for the most promising of the sections of wood around you. While at first they all look different, the quality of wood in every branch is high, and they are all large enough to create a two handed weapon if you so desire. A bow perhaps? Or maybe a staff?\n\n");
				if (flags[kFLAGS.YGGDRASIL_BRANCH] < 2) flags[kFLAGS.YGGDRASIL_BRANCH]++;
			}
			inventory.takeItem(useables.WT_BRAN, YggdrasilMainMenu);
		}

		public function AcceptTransform():void {
			clearOutput();
			outputText("\"<i>Then listen to our song. Here, at the center of our power, accept it into yourself.</i>\" You nod and begin to focus... the song is all around you, the resonation of countless flora and fauna. As time passes you begin to feel as though you are more than a listener, you feel as if you are swimming in a river of power that begs you to let it in. After a moment of hesitation, you mentally submerge yourself in the song, feeling it resonate in your mind, body and soul.");
			yggdrasilTF();
			outputText("\n\nAfter the transformations brought about by the song subside, you stand and examine your new body. ");
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
						transformations.CockTentacle(i).applyEffect();
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
							transformations.CockTentacle(i);
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
							transformations.CockStamen(i).applyEffect();
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
						transformations.CockStamen(i).applyEffect();
						dynStats("sen", 3, "lus", 10);
						changes++;
					}
				}
			}
			//{hair exists, no leaves/tentacle hair: leaves/tentacle hair tf}
			if (player.hairColor == "green" && player.hairLength > 0 && (player.hairType != Hair.LEAF && player.hairType != Hair.GRASS && player.hairType != Hair.ANEMONE) && !player.isGargoyle() && changes < changeLimit)
			{
				if (player.cor >= 66) {
					outputText("\n\n");
					CoC.instance.transformations.HairAnemone.applyEffect();
				}
				if (player.cor >= 33 && player.cor < 66) {
					if (rand(2) == 0) {
						outputText("\n\n");
						CoC.instance.transformations.HairAnemone.applyEffect();
					} else {
						if (rand(2) == 0) {
							outputText("\n\n");
							CoC.instance.transformations.HairGrass.applyEffect();
						}	else {
							outputText("\n\n");
							CoC.instance.transformations.HairLeaf.applyEffect();
						}
					}
				}
				if (player.cor < 33) {
					if (rand(2) == 0) {
						outputText("\n\n");
						CoC.instance.transformations.HairGrass.applyEffect();
					}	else {
						outputText("\n\n");
						CoC.instance.transformations.HairLeaf.applyEffect();
					}
				}
				changes++;
			}
			//green hair
			if (player.hairColor != "green" && !player.isGargoyle() && changes < changeLimit)
			{
				outputText("\n\nAt first it looks like nothing changed but then you realize all the hair on your body has shifted to a verdant green color.  <b>You now have green hair.</b>");
				player.hairColor = "green";
			}
			//horns
			if (player.horns.type != Horns.OAK && (player.hairType == Hair.LEAF || player.hairType == Hair.GRASS || player.hairType == Hair.ANEMONE) && changes < changeLimit) {
				outputText("\n\n");
				CoC.instance.transformations.HornsOak.applyEffect();
				changes++;
			}
			//Vines/tentacles arms
			if (player.cor >= 66) {
				if (player.arms.type != Arms.PLANT2 && changes < changeLimit) {
					outputText("\n\n");
					CoC.instance.transformations.ArmsPlant2.applyEffect();
					changes++;
				}
			}
			if (player.cor >= 33 && player.cor < 66) {
				if (rand(2) == 0) {
					if (player.arms.type != Arms.PLANT2 && changes < changeLimit) {
						outputText("\n\n");
						CoC.instance.transformations.ArmsPlant2.applyEffect();
						changes++;
					}
				}
				else {
					if (player.arms.type != Arms.PLANT && changes < changeLimit) {
						outputText("\n\n");
						CoC.instance.transformations.ArmsPlant.applyEffect();
						changes++;
					}
				}
			}
			if (player.cor < 33) {
				if (player.arms.type != Arms.PLANT && changes < changeLimit) {
					outputText("\n\n");
					CoC.instance.transformations.ArmsPlant.applyEffect();
					changes++;
				}
			}
			//Plant-like wings
			if (player.wings.type == Wings.YGGDRASIL_HUGE && changes < changeLimit && rand(3) == 0) {
				outputText("\n\n");
				CoC.instance.transformations.WingsYggdrasilQuadrupleHuge.applyEffect();
				changes++;
			}
			if (player.wings.type == Wings.YGGDRASIL_LARGE && changes < changeLimit && rand(3) == 0) {
				outputText("\n\n");
				CoC.instance.transformations.WingsYggdrasilHuge.applyEffect();
				changes++;
			}
			if ((player.arms.type == Arms.PLANT || player.arms.type == Arms.PLANT2) && player.wings.type != Wings.YGGDRASIL_LARGE && player.wings.type != Wings.YGGDRASIL_HUGE && player.wings.type != Wings.YGGDRASIL_HUGE_2 && player.lowerBody != LowerBody.PLANT_FLOWER && changes < changeLimit && rand(3) == 0) {
				outputText("\n\n");
				CoC.instance.transformations.WingsYggdrasilLarge.applyEffect();
				changes++;
			}
			//Bark claws
		//	if (player.arms.type != ORCA && changes < changeLimit) {
		//		outputText("\n\nRemarkably, the sunscreen has no effect.  Maybe next time?");
		//		player.arms.type = ORCA;
		//		changes++;
		//	}
			//Root claws
			if ((player.wings.type == Wings.YGGDRASIL_LARGE || player.wings.type == Wings.YGGDRASIL_HUGE || player.wings.type == Wings.YGGDRASIL_HUGE_2) && player.lowerBody != LowerBody.YGG_ROOT_CLAWS && changes < changeLimit) {
				outputText("\n\n");
				CoC.instance.transformations.LowerBodyYgddrasilRootClaws.applyEffect();
				changes++;
			}
			//Plant Dragon face
			if (player.lowerBody == LowerBody.YGG_ROOT_CLAWS && player.faceType != Face.PLANT_DRAGON && changes < changeLimit) {
				outputText("\n\n");
				CoC.instance.transformations.FacePlantDragon.applyEffect();
				changes++;
			}
			//Plant dragon tail
			if (player.faceType == Face.PLANT_DRAGON && player.tailType != Tail.YGGDRASIL && changes < changeLimit) {
				outputText("\n\n");
				CoC.instance.transformations.TailYgddrasil.applyEffect();
				changes++;
			}
			//Moss (fur)/else Bark skin
			if (!player.isBarkSkin() && !player.isGargoyle() && changes < changeLimit && player.faceType == Face.PLANT_DRAGON) {
				outputText("\n\n");
				CoC.instance.transformations.SkinBark(Skin.COVERAGE_COMPLETE, {colors: YgddrasilRace.YgddrasilSkinColors}).applyEffect();
				changes++;
			}
			if (player.ears.type != Ears.LIZARD && player.tailType == Tail.YGGDRASIL && player.lowerBody == LowerBody.YGG_ROOT_CLAWS && changes < changeLimit) {
				outputText("\n\nAll around you, a omnipresent buzzing is gradually becoming louder and louder.  Suddenly, you realize that it’s become painfully loud, the force of the sound making your eardrums throb painfully.  You attempt to block the sound with your ears, but your hands can’t find any ears to plug!  Suddenly, the buzzing stops, and the ringing in your ears begins to subside.  Probing the side of your head with your hands, you realize that your ears have become ");
				if (player.isFurCovered() || player.hairLength > 0) outputText("discreet ");
				outputText("earholes onthe side of your head. <b>You now have lizardlike ears.</b>");
				CoC.instance.transformations.EarsLizard.applyEffect(false);
				changes++;
			}
			if (changes < changeLimit && player.isRaceCached(Races.YGGDRASIL) && !player.hasPerk(PerkLib.DragonPoisonousSapBreath)) {
				outputText("\n\nYou feel something awakening within you... then a sudden sensation of choking grabs hold of your throat, sending you to your knees as you clutch and gasp for breath.  It feels like there's something trapped inside your windpipe, clawing and crawling its way up.  You retch and splutter and then, with a feeling of almost painful relief, you expel a bellowing roar from deep inside of yourself... ");
				outputText("with enough force that clods of dirt and shattered gravel are sent flying all around.  You look at the small crater you have literally blasted into the landscape with a mixture of awe and surprise.\n\nIt seems song has awaked some kind of power within you... your throat and chest feel very... strange and you can't put a finger what this feeling exactly is, however; you doubt you can force out more than one such blast before resting.  (<b>Gained Perk: Dragon poison breath!</b>)");
				player.createPerk(PerkLib.DragonPoisonousSapBreath, 0, 0, 0, 0);
				changes++;
			}
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}
	}
}