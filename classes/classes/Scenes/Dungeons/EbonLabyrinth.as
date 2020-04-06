/**
 * Quest Dungeon: The Ebon Labyrinth (for Alvina Black Rose Quest)
 * @author Liadri
 */
package classes.Scenes.Dungeons 
{
import classes.CockTypesEnum;
import classes.EventParser;
import classes.PerkLib;
import classes.VaginaClass;
import classes.GlobalFlags.kFLAGS;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Items.Consumables.MinotaurBlood;
import classes.Scenes.SceneLib;
import classes.Scenes.Areas.BlightRidge.Incubus;
import classes.Scenes.Areas.BlightRidge.Omnibus;
import classes.Scenes.Areas.BlightRidge.Succubus;
import classes.Scenes.Areas.Caves.DarkSlime;
import classes.Scenes.Areas.Caves.DisplacerBeast;
import classes.Scenes.Areas.Caves.DisplacerBeastScene;
import classes.Scenes.Areas.Forest.TentacleBeast;
import classes.Scenes.Areas.Forest.TentacleBeastScene;
import classes.Scenes.Areas.Mountain.Minotaur;
import classes.Scenes.Dungeons.EbonLabyrinth.*;
import classes.CoC;
import classes.StatusEffects;
import classes.display.SpriteDb;

public class EbonLabyrinth extends DungeonAbstractContent
	{
		private static const DUNGEON_EBON_LABYRINTH_0:int	= 131;
		private static const DUNGEON_EBON_LABYRINTH_1:int	= 132;
		private static const DUNGEON_EBON_LABYRINTH_2:int	= 133;
		private static const DUNGEON_EBON_LABYRINTH_3:int	= 134;
		
		private var _cuteScene:int = 1;
		
		public var elDisplacerbeast:DisplacerBeastScene = new DisplacerBeastScene();
		public var ancientTentacleBeast:TentacleBeastScene = new TentacleBeastScene();
		
		public function EbonLabyrinth() {}
		
		public function ebonlabyrinthdiscovery():void {
			flags[kFLAGS.EBON_LABYRINTH] = 1;
			clearOutput();
			outputText("You find the entrance to what appears to be a tunnel made of stone. This place looks man made as if carved by humanoid hands yet sports no decoration. Just empty linear corridors and corners dimly lit by magical torches. On a wall you find a sign reading ");
			outputText("-Woe to who seeketh the black rose. Thy who enter beware, while riches you may find, death lurks in the Labyrinth deepest reaches. It ever hungers.- how charming. The ruin of an old campfire is all that's left of the previous adventurers to come here.\n\n");
			outputText("<b>You found the Ebon Labyrinth.</b>\n\n");
			doNext(enterDungeon);
		}
		public function enterDungeon():void {
			inDungeon = true;
			dungeonLoc = 131;
			player.createStatusEffect(StatusEffects.EbonLabyrinthA, 10, 0, 0, 0);
			player.createStatusEffect(StatusEffects.EbonLabyrinthB, 1, 0, 0, 0);
			playerMenu();
		}
		public function exitDungeon():void {
			inDungeon = false;
			clearOutput();
			outputText("You leave the Ebon Labyrinth behind and take off back towards the camp.");
			if (player.hasStatusEffect(StatusEffects.ThereCouldBeOnlyOne)) player.removeStatusEffect(StatusEffects.ThereCouldBeOnlyOne);
			player.removeStatusEffect(StatusEffects.EbonLabyrinthA);
			player.removeStatusEffect(StatusEffects.EbonLabyrinthB);
			if (player.hasStatusEffect(StatusEffects.EbonLabyrinthBoss1)) player.removeStatusEffect(StatusEffects.EbonLabyrinthBoss1);
			if (player.hasStatusEffect(StatusEffects.EbonLabyrinthBoss2)) player.removeStatusEffect(StatusEffects.EbonLabyrinthBoss2);
			doNext(camp.returnToCampUseOneHour);
		}
		//Monsters
		public function defeatedByDisplacerBeast():void {
			inDungeon = false;
			player.removeStatusEffect(StatusEffects.EbonLabyrinthA);
			elDisplacerbeast.displacerBeastDefeat();
		}
		public function defeatedByDarkSlime():void {
			clearOutput();
			if (player.hasKeyItem("Torch") >= 0) {
				outputText("You refuse to end up as a meal to a slime and, unable to pose a decent fight, you keep the thing at bay using a torch.\n\n");
				outputText("\"<i>Not fair! Put that out, damn thing hurts like a bitch. Fucking knew I should have put more work on my fire wards!</i>\"\n\n");
				outputText("Aha! So she can’t stand fire, huh? Well too bad for her, as you proceed to crawl away from the slime keeping the torch between you and her so she can’t approach. Eventually, you manage to stand up and begin running from the, somewhat disappointed, slime girl.\n\n");
				cleanupAfterCombat();
			}
			else {
				//outputText("I will put here scene soon.\n\n");
				cleanupAfterCombat();
			}
		}
		public function defeatedByStrayDemon():void {
			clearOutput();//succubus, incibus or omnibus
			outputText("Defeated you fall to the ground and look up just in time to see a mace coming for your head. When you wake up you're standing on a podium somewhere else. There's demon everywhere around you screaming numbers. Those demons are brandishing gems around for some reasons.\n\n");
			outputText("\"<i>One hundred did I hear one hundred for this ");
			if (player.gender == 3) outputText("herm");
			else if (player.gender == 1) outputText("man");
			else outputText("woman");
			outputText("? One hundred one?!</i>\"\n\n");
			outputText("You realise what's going on now, they're actually auctioning you at the slave market! You try and break free but your bonds are to tight. Eventually you're sold to an Omnibus who just so happen to be collecting human pets. As time passes she eventually sells you to a new master and then you're sold again to another. It never ends. ");
			outputText("Guess you will spend the rest of your life in bondage pleasing some demon until it gets bored and sell you off. Maybe, if your lucky, one will fuck you hard enough that you will cum your soul out and you will actualy get to enjoy rather then loath your slave status.\n\n");
			//[GAME OVER]
			EventParser.gameOver();
		}
		public function defeatedByAncientTentacleBeast():void {
			clearOutput();
			outputText("Upon your defeat the tentacled fiends draws an appendage ending with a nasty needle and forces it in your left side pouring transformative fluid into you.");
			outputText(" Your chest begins to puff up, growing up in size");
			if (player.biggestTitSize() < 1) outputText(" from nothing");
			player.growTits(1 + rand(3), 1, false, 3);
			outputText("! Milks churns inside ready for the harvest.");
			player.boostLactation(1.5);
			if (player.cocks.length == 0) {
				outputText(" Just as you were thinking about your breasts you feel a bump of flesh between your legs growing steadily until it breaks out standing erect. This… this thing is a penis!");
				player.createCock();
				player.cocks[0].cockLength = 6;
				player.cocks[0].cockThickness = 1.5;
				player.cocks[0].cockType = CockTypesEnum.HUMAN;
				player.clitLength = .25;
				if (player.hasVagina()) outputText(" Oh no your a full herm now!");
			}
			if (player.balls == 0) outputText(" Underneath your [cock] a large sack has formed. You feel nauseous as balls drops in churching with fresh cum.");
			if (!player.hasVagina()) {
				outputText(" Just underneath your ballsack you feel flesh parting wetly as your acquire a brand new pussy, one the tentacle beast will be eager to dive in.");
				player.createVagina();
				player.vaginas[0].vaginalLooseness = VaginaClass.LOOSENESS_TIGHT;
				player.vaginas[0].vaginalWetness = VaginaClass.WETNESS_NORMAL;
				player.vaginas[0].virgin = true;
				player.clitLength = .25;
				if (player.hasCock()) outputText(" Oh no you’re a full herm now!");
			}
			outputText("\n\nWhile you attempt to resist the abomination, its raw muscle mass is too much. It pins you to the ground easily. You immediately feel a sharp, horrible pain at the base of your ample cock. You look down to see the end of a thorny tendril impaled in your pelvic region. Fiery pain courses through your veins as you feel ");
			outputText("the creature inject you with some sort of liquid. As the pain sears through you, your member immediately becomes fully erect and pre-cum leaks liberally from your tip. Two thorny tentacles pierce your nipples and you feel as if someone shot acid into your tits, which immediately begin to swell.\n\n");
			outputText("Realizing what is about to happen, you try to struggle. The beast responds by slamming you to the ground a few times, stunning you. In your daze you see a monstrous, hollow tentacle poised over your furious cock. You scream in shock and protest, but your cries fall upon deaf ears. ");
			outputText("The tentacle descends upon your nice cock, now begging for release, and clamps down upon your pubic mound, fully encapsulating your member.\n\n");
			ancientTentacleBeast.futaTentacleBadEndEL();
		}
		public function defeatedByMindBreaker():void {
			clearOutput();
			outputText("\n\n");
			//[GAME OVER]
			EventParser.gameOver();
		}
		//Bosses
		public function defeatedByChaosChimera():void {
			clearOutput();
			if (player.isGoo()) {
				outputText("You fall down in a puddle, defeated and the Chimera approaches you.\n\n");
				outputText("\"<i>Meh, I retire what I said, you're likely not edible! However, I'm not done with you yet.</i>\"\n\n");
				outputText("Its four cocks rise to full mast and you know what will follow. Normally, such a length should terrify you, however, the idea of taking in such a large amount of fluids is way too delicious for you to pass on. You gush toward the monster’s dicks and open wide, ");
				outputText("inserting the quad cocks in your jelly-like body as you shape yourself to accommodate the beast. The chimera is swift to respond, fucking your throat, two breasts, and pussy with beastial fervor.\n\n");
				outputText("\"<i>Aaaaaarh this is perfect. Slimes are poor meals but make for ideal cocksleeves!</i>\"\n\n");
				outputText("Your body shape is bloated with the chimera dicks, deforming into a messy puddle, but this quad penetration is the best fuck you ever had. Soon the beast erupts into your form, flooding your body with at least its size equivalent in cum. You slowly slide off his cocks examining yourself in amazement. ");
				outputText("What an intake of fluid! Your insides were dyed white and now they are slowly returning back to your original color as you metabolize the nutrients… This fuck alone helped you recover from the battle. You're about to challenge the beast to a rematch but you are so full you instead fall asleep. ");
				outputText("You have no knowledge of what happened next but when you woke up you're at the labyrinth entrance, still alive. You can only guess after having its way with you, the Chimera had no interest in keeping you here. It seems you will have to start over.\n\n");
				player.HP = player.maxHP();
				//(gain 20 intakes - for goo crawling)
				dungeonLoc = 131;
				player.removeStatusEffect(StatusEffects.EbonLabyrinthB);
				player.createStatusEffect(StatusEffects.EbonLabyrinthB, 0, 0, 0, 0);
				playerMenu();
			}
			else {
				outputText("As you fall down defeated you register the chimera approaching your prone body, a sadistic smile on each of its heads as its four cocks rise to full mast. These things... they're way too big, you will likely be split apart! You’re brutally thrown on your back the beast aligning with your holes and...\n\n");
				outputText("What follows is too horrible to describe with words alone as the monster raped you with such bestial brutality, you were almost grateful it sent you to the afterlife before meal time.");
				if (SceneLib.shouldraFollower.followerShouldra()) {
					outputText(" Well surprisingly, thanks to Shouldra’s swift action before your death, you did somehow partially survived the horrible experience at the cost of yourself becoming a ghost. However without a physical body to prolong your adventure all you are left with ");
					outputText("is haunting the labyrinth and possessing the body of its many denizens and or occasional adventurers for fun. Not that Shouldra ever disapproved of it.");
				}
				outputText("\n\n");
				//[GAME OVER]
				EventParser.gameOver();
			}
		}
		public function defeatChaosChimera():void {
			clearOutput();
			outputText("You stand victorious over the beast as you finish the abomination off, avenging all of the people it’s killed. You use the Snake neck of the chimera in order to cover the rose’s deadly thorns, so as not to prick yourself, and head back to camp with your prize.\n\n");
			awardAchievement("Four heads better then one", kACHIEVEMENTS.DUNGEON_DUNGEONMASTER);
			flags[kFLAGS.ALVINA_FOLLOWER] = 18;
			cleanupAfterCombat();
		}
		public function defeatedByDarkSlimeEmpress():void {
			clearOutput();
			outputText("As you fall defeated the slimes all cover you, encasing you in jelly.\n\n");
			outputText("\"<i>It is but customary that one should bow or kneel before their empress. Some punishment is in order.</i>\"\n\n");
			outputText("The slime begins to violate you in every way possible. You want to scream in pleasure but when you do the slime takes advantage of your open mouth to pour down your throat. You feel yourself melt and dissolve as your memory and mind become increasingly confused. You are [name] but at the same time you are Clarissa, Elisabeth and Sabrina, a hundred confusing names ");
			outputText("float into your mind until you finally understand. You are one but many, everything and nothing, just one consciousness amongst the hundreds that live within the empress’s immortal jelly. Your body is made of slime but there is only one core to rule them all, the core of your beloved empress. ");
			outputText("The first order she gives is an easy one, to resume the feast and you’re all too happy to partake. A few months later a new human will visit this hall, it will be your greatest pleasure to give him or her a warm, gooey welcome.\n\n");
			//[GAME OVER]
			EventParser.gameOver();
		}
		public function defeatDarkSlimeEmpress():void {
			clearOutput();
			outputText("The empress’s purple legion falter for an instant, the slime blocking the exit falling off. You don't wait for the sovereign to recover her composure and rush for the exit, the empress screaming orders as you leave. Thankfully slimes are not overly fast and you manage to make it back to the corridor junction you came from.\n\n");
			if (player.hasStatusEffect(StatusEffects.TFDealer1) && player.statusEffectv1(StatusEffects.TFDealer1) < 1) player.addStatusValue(StatusEffects.TFDealer1, 1, 1);
			else player.createStatusEffect(StatusEffects.TFDealer1, 1, 0, 0, 0);
			cleanupAfterCombat();
		}
		public function defeatedByHydra():void {
			clearOutput();
			outputText("You fall to the ground in a heap, absolutely defeated. You barely register her shadow towering above your prone form as she picks you up like a doll and proceeds to pull you toward her gaping pussy, lights soon shuts out as you’re squeezed and rammed deeper and deeper past the entrance until you no longer see it. This will sadly eventually prove to be a one way trip as you reach an area even her hands cannot reach, ");
			outputText("vanishing within her fleshy depths were the lack of oxygen will eventually get the better of you.\n\n");
			//[GAME OVER]
			EventParser.gameOver();
		}
		public function defeatHydra():void {
			clearOutput();
			outputText("You thought you had won but, to your frustration, the hydra just keeps on regenerating its wounds. It’s incapacitated for now but it could get back up ready to attack at anytime. You grab a token of her defeat and run for the room exit, back to the previous junction.\n\n");
			if (player.hasStatusEffect(StatusEffects.TFDealer1) && player.statusEffectv2(StatusEffects.TFDealer1) < 1) player.addStatusValue(StatusEffects.TFDealer1, 2, 1);
			else player.createStatusEffect(StatusEffects.TFDealer1, 0, 1, 0, 0);
			cleanupAfterCombat();
		}
		public function defeatedByHellfireSnail():void {
			clearOutput();
			outputText("The snail girl catches you before you even hit the floor, a wide gooey smile on her face.\n\n");
			outputText("\"<i>Aw, no need to be so aggressive, I know exactly what you need! A BIG warm hug!</i>\"\n\n");
			if (player.hasPerk(PerkLib.FireAffinity)) {
				outputText("No way, she's going to hug you!? You scream in panic trying to get free but it's pointless as she has you beneath her shell now. However friendly she is, your body isn't made to endure such crazy heat. Or is it? To your surprise you actually feel comfortable in her grasp and even begin to relax, returning the hug and gently imprinting your hands into her generous breasts.");
				HellfireSnailSex();
				monster.createPerk(PerkLib.NoGemsLost, 0, 0, 0, 0);
				inventory.takeItem(consumables.FSNAILS, cleanupAfterCombat);
			}
			else {
				outputText("No way, she's going to hug you!? You scream in panic, trying to get free but it's pointless as she has you beneath her shell now. However friendly she is, your body isn't made to endure such crazy heat. You perish in silence, your screams muffled by her massive chest as you pretty much disintegrate into her arms. You’re long dead before the lonely snail even realises she's hugging ashes.\n\n");
				//[GAME OVER]
				EventParser.gameOver();
			}
		}
		public function defeatHellfireSnail():void {
			clearOutput();
			outputText("You beat up the snail girl so hard her shell end upside down! She desperately tries to get back on her belly but is stuck swinging from side to side, you get the opportunity to run past her.\n\n");
			if (player.hasStatusEffect(StatusEffects.TFDealer1) && player.statusEffectv3(StatusEffects.TFDealer1) < 1) player.addStatusValue(StatusEffects.TFDealer1, 3, 1);
			else player.createStatusEffect(StatusEffects.TFDealer1, 0, 0, 1, 0);
			cleanupAfterCombat();
		}
		public function defeatedByBoosNo4():void {
			clearOutput();
			outputText("\n\n");
			//[GAME OVER]
			EventParser.gameOver();
		}
		public function defeatBoosNo4():void {
			clearOutput();
			outputText("\n\n");
			cleanupAfterCombat();
		}
		public function defeatedByBoosNo5():void {
			clearOutput();
			outputText("\n\n");
			//[GAME OVER]
			EventParser.gameOver();
		}
		public function defeatBoosNo5():void {
			clearOutput();
			outputText("\n\n");
			cleanupAfterCombat();
		}
		public function defeatedByBoosNo6():void {
			clearOutput();
			outputText("\n\n");
			//[GAME OVER]
			EventParser.gameOver();
		}
		public function defeatBoosNo6():void {
			clearOutput();
			outputText("\n\n");
			cleanupAfterCombat();
		}
		
		private function encountersFountainOfPurity():void {
			player.createStatusEffect(StatusEffects.ThereCouldBeOnlyOne, 0, 0, 0, 0);
			player.addStatusValue(StatusEffects.RathazulAprilFool, 3, 1);
			outputText("As you explore the labyrinth you stumble upon what appears to be a room with fountain of purity.\n\nYou collected a vial of the fountain of purity. It's time to bring it back to Rathazul.\n\n");
		}
		private function encountersLootChest():void {
			player.createStatusEffect(StatusEffects.ThereCouldBeOnlyOne, 0, 0, 0, 0);
			var EXP:Number = 10 * (player.level + 1) * (1 + rand(5));
			EXP = Math.round(EXP);
			player.XP += EXP;
			var GEMS:Number = 500 + (10 * rand(51));
			player.gems += GEMS;
			outputText("As you explore the labyrinth you stumble upon what appears to be a room filled with gems and a pillar upon which sits a single jewel. Grabbing the jewel, you see green mist swirl out of the stone then around you before entering your body. Memories not your own flash through your mind. ");
			outputText("Battles of the present and the past. You know you've learned from these battles and as you gather the gems and leave the room you do so with new enriching experiences. (+" + EXP + " EXP, +" + GEMS + " gems)\n\n");
		}
		private function encountersRuletteBossesEL1():void {
			player.createStatusEffect(StatusEffects.ThereCouldBeOnlyOne, 0, 0, 0, 0);
			if (flags[kFLAGS.ALVINA_FOLLOWER] == 17) {
				if (flags[kFLAGS.CODEX_ENTRY_CHIMERA] <= 0) {
					flags[kFLAGS.CODEX_ENTRY_CHIMERA] = 1;
					outputText("\n\n<b>New codex entry unlocked: Chimera!</b>");
				}
				outputText("You finally find the center of the labyrinth, somewhat exhausted. You can see the rose from here in all its dark beauty. As you are about to approach it, a monstrous creature lands right in front of you. This beast has no less than four heads! A dragon on the left, a lion on the center, a goat on ");
				outputText("the right and, at the tip of its tail, the head of a snake! All four heads roar a warning at you as the beast stands up on its leonine legs, easily twelve feet tall, its massive wings opening in a threatening display revealing nothing short of four erect thirty inches cock already drooling precum!\n\n");
				outputText("\"<i>Foolish intruder, you walked to your death! No one but me will ever touch the rose for it is mine and no one else's! I will rape you and then devour you alive!</i>\"\n\n");
				outputText("<b>It's too late to run as you're fighting the chaos chimera!</b>");
				player.createStatusEffect(StatusEffects.EbonLabyrinthBoss1, 1, 0, 0, 0);
				startCombat(new ChaosChimera(), true);
			}
			else {
				if (player.statusEffectv1(StatusEffects.EbonLabyrinthBoss1) == 4) {
					player.createStatusEffect(StatusEffects.EbonLabyrinthBoss,75,0,0,0);
					encountersRuletteBossesEL1HellSnail();
				}
				if (player.statusEffectv1(StatusEffects.EbonLabyrinthBoss1) == 5) {
					player.createStatusEffect(StatusEffects.EbonLabyrinthBoss,75,0,0,0);
					encountersRuletteBossesEL1Hydra();
				}
				if (player.statusEffectv1(StatusEffects.EbonLabyrinthBoss1) == 6) {
					player.createStatusEffect(StatusEffects.EbonLabyrinthBoss,75,0,0,0);
					encountersRuletteBossesEL1HellSnail();
				}
				if (player.statusEffectv1(StatusEffects.EbonLabyrinthBoss1) == 7) {
					player.createStatusEffect(StatusEffects.EbonLabyrinthBoss,75,0,0,0);
					encountersRuletteBossesEL1DarkSlimeEmpress();
				}
				if (player.statusEffectv1(StatusEffects.EbonLabyrinthBoss1) == 8) {
					player.createStatusEffect(StatusEffects.EbonLabyrinthBoss,75,0,0,0);
					encountersRuletteBossesEL1Hydra();
				}
				if (player.statusEffectv1(StatusEffects.EbonLabyrinthBoss1) == 9) {
					player.createStatusEffect(StatusEffects.EbonLabyrinthBoss,75,0,0,0);
					encountersRuletteBossesEL1DarkSlimeEmpress();
				}
				if (player.statusEffectv1(StatusEffects.EbonLabyrinthBoss1) == 1) {
					player.createStatusEffect(StatusEffects.EbonLabyrinthBoss,70,0,0,0);
					if (rand(2) == 0) {
						player.addStatusValue(StatusEffects.EbonLabyrinthBoss1, 1, 3);
						encountersRuletteBossesEL1Hydra();
					}
					else {
						player.addStatusValue(StatusEffects.EbonLabyrinthBoss1, 1, 4);
						encountersRuletteBossesEL1HellSnail();
					}
				}
				if (player.statusEffectv1(StatusEffects.EbonLabyrinthBoss1) == 2) {
					player.createStatusEffect(StatusEffects.EbonLabyrinthBoss,70,0,0,0);
					if (rand(2) == 0) {
						player.addStatusValue(StatusEffects.EbonLabyrinthBoss1, 1, 4);
						encountersRuletteBossesEL1DarkSlimeEmpress();
					}
					else {
						player.addStatusValue(StatusEffects.EbonLabyrinthBoss1, 1, 5);
						encountersRuletteBossesEL1HellSnail();
					}
				}
				if (player.statusEffectv1(StatusEffects.EbonLabyrinthBoss1) == 3) {
					player.createStatusEffect(StatusEffects.EbonLabyrinthBoss,70,0,0,0);
					if (rand(2) == 0) {
						player.addStatusValue(StatusEffects.EbonLabyrinthBoss1, 1, 5);
						encountersRuletteBossesEL1DarkSlimeEmpress();
					}
					else {
						player.addStatusValue(StatusEffects.EbonLabyrinthBoss1, 1, 6);
						encountersRuletteBossesEL1Hydra();
					}
				}
				if (!player.hasStatusEffect(StatusEffects.EbonLabyrinthBoss1)) {
					player.createStatusEffect(StatusEffects.EbonLabyrinthBoss,65,0,0,0);
					var choice:Number = rand(3);
					if (choice == 0) {
						player.createStatusEffect(StatusEffects.EbonLabyrinthBoss1, 1, 0, 0, 0);
						encountersRuletteBossesEL1DarkSlimeEmpress();
					}
					if (choice == 1) {
						player.createStatusEffect(StatusEffects.EbonLabyrinthBoss1, 2, 0, 0, 0);
						encountersRuletteBossesEL1Hydra();
					}
					if (choice == 2) {
						player.createStatusEffect(StatusEffects.EbonLabyrinthBoss1, 3, 0, 0, 0);
						encountersRuletteBossesEL1HellSnail();
					}
				}
			}
		}//1 - DSE, 2 - H, 3 - HS, 4 - DSE+H, 5 - DSE+HS, 6 - H+DSE, 7 - H+HS, 8 - HS+DSE, 9 - HS+H, 10 - last 3rd not picked boss
		private function encountersRuletteBossesEL1DarkSlimeEmpress():void {
			outputText("As you enter the next room the first thing you hear are the moans. You’re greeted to quite a sight for before you hundreds of slimy shape are making out, fucking each other in the most blatently obsene display you've ever seen. Confused, you try and figure if you stepped into some kind of orgy until you notice one slime at the back of the room who stands out. ");
			outputText("Wearing a crown seemingly made of goop, this regal purple woman sits on a pair of stone slabs which serves it as a makeshift throne.\n\n");
			outputText("\"<i>Why now my loyal subjects, it seems we have a guest, welcome to my domain intruder I hope you intend on joining the feast in my honor of course. Guests… are always welcome.</i>\"\n\n");
			outputText("All of the slime suddenly drop their activities, drooling at you with keen interest. You've got a very bad feeling. This is when you notice that all of them are linked to one another through small trails of slime on the ground. The slimes take on a makeshift formation, drawing what appears to be slimy spears and bows all pointed at you.\n\n");
			outputText("Seeing this, you try to run for it but the purple empress waves her hand, slime sealing shut the exit behind you, the only exit out of this room. The slime giggles, the crowd imitating it shortly.\n\n");
			outputText("\"<i>I hope you are in the mood because you and I are soon going to become very intimate.</i>\"\n\n");
			outputText("<b>It's too late to escape now, it's a fight!</b>");
			startCombat(new DarkSlimeEmpress(), true);
		}
		
		public function encountersRuletteBossesEL1Hydra():void {
			if (flags[kFLAGS.CODEX_ENTRY_HYDRA] <= 0) {
				flags[kFLAGS.CODEX_ENTRY_HYDRA] = 1;
				outputText("\n\n<b>New codex entry unlocked: Hydra!</b>");
			}
			spriteSelect(SpriteDb.s_hydra_16bit);
			outputText("The first telltale that something might have gone really wrong is the hissing which seems to come from all around the room. The only warning you get of the impending attack is a sudden move of the shadows as a massive snake head bites the air mere inches from your face. You ready for battle as several huge snakes comes out of the shadow, each connected to a single junction to what appears to be the body of a very tall woman.\n\n");
			if (player.isNaga()) {
				outputText("\"<i>Why, would you look at that, how did you little grass snake make it all the way here. Are you perhaps lost?</i>\"\n\n");
				outputText("Sometimes you forget that as a naga your body language allows you to understand snakes of all kinds. You reply to the hydra that you're exploring the labyrinth in search of power and treasures.\n\n");
				outputText("\"<i>Um well there's no treasure I know of in this room but perhaps if you can help me with my arousal problem I’d be willing to give you something close to the first. A hydra scale, nothing short, nothing less. That is of course if becoming like me is of any interest to poor puny you. So how about it?</i>\"\n\n");
				if (player.hasStatusEffect(StatusEffects.TFDealer1) && player.statusEffectv2(StatusEffects.TFDealer1) < 1) player.addStatusValue(StatusEffects.TFDealer1, 2, 1);
				else player.createStatusEffect(StatusEffects.TFDealer1, 0, 1, 0, 0);
				_cuteScene = 2;
				menu();
				addButton(1, "Sex", encountersRuletteBossesEL1HydraSex);
				addButton(2, "Pass", encountersRuletteBossesEL1HydraPass);
				addButton(3, "Fight", encountersRuletteBossesEL1HydraFight);
			}
			else {
				outputText("She hisses in perfect coordination with the snakes, her slitted eyes fixating you obsessively, as a drooling gaping slit at the junction between the snakes and her human body tells you exactly what she wants from you. You don't feel you should indulge her however and as such ready to battle.\n\n");
				startCombat(new Hydra(), true);
			}
		}
		public function encountersRuletteBossesEL1HydraOthers():void {
			outputText("She hisses in perfect coordination with the snakes, her slitted eyes fixating you obsessively, as a drooling gaping slit at the junction between the snakes and her human body tells you exactly what she wants from you. You don't feel you should indulge her however and as such ready to battle.\n\n");
			startCombat(new Hydra(), true);
		}
		public function encountersRuletteBossesEL1HydraSex():void {
			outputText("Clearly no cock in the world aside from those of a giant way bigger then your own size would ever fit her massive cunt. This said you got something way bigger then a cock. Her eyes widen and she drools from all six mouths in anticipation as you coil your tail around a nearby wooden log into a spring shape. You made a fleshy dildo three meters long and at least 20 inch thick just for her.\n\n");
			outputText("Without asking for permission the horny hydra picks up your coiled tail and shove it inside her gaping maw of a cunt using your entire tail length up to the thigh to fuck herself like never before. You take great care not to uncoil your tail until your feel her clamping and drenching you all the way to the shoulder in giantess juices. The hydra, now fully satisfied pulls you out and depose you on the ground.\n\n");
			outputText("\"<i>Oh god, it's been so long since I last touched myself. Here you may have this.</i>\"\n\n");
			outputText("She hands you a large scale easily as big as your hand making it clear that you must eat it to gain its power before waving you off.\n\n");
			outputText("\"<i>Stay safe down here little grass snake, not everyone is friendly and I’d hate to think you could be eaten.</i>\"\n\n");
			_cuteScene = 1;
			inventory.takeItem(consumables.HYDRASC, playerMenu);
		}
		public function encountersRuletteBossesEL1HydraPass():void {
			outputText("You decline politely but say you will think about it. The semi disappointed hydra shrugs and lets you exit the room.\n\n");
			_cuteScene = 1;
			doNext(playerMenu);
		}
		public function encountersRuletteBossesEL1HydraFight():void {
			_cuteScene = 1;
			outputText("Wearing a crown seemingly made of goop, this regal purple woman sits on a pair of stone slabs which serves it as a makeshift throne.\n\n");
			startCombat(new Hydra(), true);
		}
		
		public function encountersRuletteBossesEL1HellSnail():void {
			if (player.hasPerk(PerkLib.FireAffinity) && flags[kFLAGS.HELLFIRE_SNAIL_ENC] == 1) {
				outputText("You turn the corner expecting to run into yet another monster out to badly hurt you but sigh in relief as you run into the fire snail girl instead.\n\n");
				outputText("\"<i>Hey it's you again. Having fun down there?</i>\"\n\n");
				outputText("Well you could say that, in a way, yes you are having fun down there.\n\n");
				outputText("\"<i>So uh I've been getting antsy of late could you help me out with…</i>\"\n\n");
				outputText("You shut her up right away with a smoldering kiss of your own. Burning pleasure running down your spine as she cover you with her blanket like undercarriage. You return her hug by gently imprinting your hands into her generous breasts. ");
				HellfireSnailSex();
				inventory.takeItem(consumables.FSNAILS, playerMenu);
			}
			else {
				outputText("As you turn the corner you run into what appears to be a massive rock blocking the passage. You try to move it but"+(player.tallness < 120 ? " to no avail the thing is as heavy as it looks. Your hand begins to burn up as":"")+" the rock suddenly raise in temperature and you swiftly remove them before being burnt. You are set on your guard as a feminine voice calls out.\n\n");
				outputText("\"<i>Hey who's the pervert molesting my ass!?! This is most unfair! Share back the fun!</i>\"\n\n");
				outputText("The rock now red with heat begins to seethe magma as something not unlike a reddish tail slides out from beneath it. On the other side the torso of a comely humanoid woman appears or you would call it human if not for the red skin, glowing ember eyes, drooling mouth and two antenna poking from the front atop her blazing hair! ");
				outputText("The volcanic snail girl eyes you with the kind of drooly obsessed expression you've only seen on slime girls and her intentions become clear as day, she intends to force herself on you!\n\n");
				if (flags[kFLAGS.HELLFIRE_SNAIL_ENC] < 1) flags[kFLAGS.HELLFIRE_SNAIL_ENC] = 1;
				startCombat(new HellfireSnail(), true);
			}
		}
		public function HellfireSnailSex():void {
			outputText("The she snail giggle at your pleasant attention and begin to grind her lubricated pussy against "+(player.hasCock() ? "your burning cock" : "yours")+" in earnest. Blazing goop and other fluids begins to mingle as the two of you make it out the other residents of the labyrinth either oblivious or too scared to interfere with your smoldering mating session. ");
			outputText("This might also be because the both of you spray fire and lava everywhere as part of mating and despite you both being immune to each other the unlooker likely wouldn't. The mating is deliberately slow, gentle and calculated with no single movement wasted as unlike most of Mareth denizen your current partner likes it nice and slow taking her time to make everything count.\n\n");
			outputText("You reach your peak and erupt in orgasm your partner following short mere seconds after");
			if (player.hasCock()) outputText(" as you fill her smoldering lovehole with "+player.race+" seeds");
			if (!player.hasCock()) outputText(" as your girl juice mix with hers");
			outputText(".\n\n\"<i>Uwaaa so long since last I had real sex, most of my partners dies before I even reach the climax. Thank you so much hun for helping me out.</i>\"\n\n");
			outputText("Hey if this can help her be less of a hazard to everyone around her then why not, your glad she appreciates it.\n\n");
			outputText("\"<i>Hey before you go have a vial of this, I don't know if you will find it useful but who knows.</i>\"\n\n");
			outputText("She hands you a vial of her saliva before you head out back in the labyrinth and resume your exploration.\n\n");
			player.orgasm();
		}
		
		private function encountersRuletteBossesEL2():void {
			player.createStatusEffect(StatusEffects.ThereCouldBeOnlyOne, 0, 0, 0, 0);
			outputText("You turn around the corner and come face to face with a greyish six armed catgirl. She would be terrifying already even without the two tentacles on her back that writhe in excitation. Readying for battle is the best you can do as the beast woman charges you with a gleam of hunger in her feral eyes.\n\n");
			outputText("<b>It's placeholder encounter to test procing boss fight!</b>");
			startCombat(new DisplacerBeast(), true);
		}
		private function encountersRuletteEL():void {
			if ((rand(100) < player.statusEffectv1(StatusEffects.EbonLabyrinthA)) && !player.hasStatusEffect(StatusEffects.ThereCouldBeOnlyOne)) {
				var reset:Number = 10;
				reset -= player.statusEffectv1(StatusEffects.EbonLabyrinthA);
				player.addStatusValue(StatusEffects.EbonLabyrinthA, 1, reset);
				player.createStatusEffect(StatusEffects.ThereCouldBeOnlyOne, 0, 0, 0, 0);
				var choice:Number = rand(8);
				if (choice == 0) {
					outputText("You turn around the corner and come face to face with a greyish six armed catgirl. She would be terrifying already even without the two tentacles on her back that writhe in excitation. Readying for battle is the best you can do as the beast woman charges you with a gleam of hunger in her feral eyes.");
					if (flags[kFLAGS.CODEX_ENTRY_DISPLACER_BEAST] <= 0) {
						flags[kFLAGS.CODEX_ENTRY_DISPLACER_BEAST] = 1;
						outputText("<b>New codex entry unlocked: Displacer beast!</b>\n\n")
					}
					startCombat(new DisplacerBeast(), true);
				}
				if (choice == 1) {
					//spriteSelect(25);
					if (player.gooScore() >= 11 || player.magmagooScore() >= 13 || player.darkgooScore() >= 13) {
						outputText("You take the turn at the end of the corridor and run right into a dark slime. For a few second the both of you consider each other before the slime shrugs and simply asks.\n\n");
						outputText("\"<i>No luck finding fluids that way?</i>\"");
						outputText("You didn’t find any and if you did you would have pumped it out until it ran dry.\n\n");
						outputText("\"<i>Well darn, if you spot a fleshling do share!</i>\"");
						outputText("Well that was easy… you can only guess slimes don’t get much out of other slimes’ bodies. You proceed deeper into the labyrinth unhindered, though, you wish you indeed had found someone to milk the fluids off.\n\n");
					}
					else {
						outputText("As you wander into a new corridor you come face to face with a purplish jelly-like woman. She giggles upon spotting you, her small, sphere-shaped core emitting an ominous light as she surges toward you with a gooey smile.\n\n");
						outputText("\"<i>Dinner is served! Your fluids are mine, so surrender them now intruder and I promise to make it very pleasurable for you!</i>\"");
						startCombat(new DarkSlime(), true);
					}
				}
				if (choice == 2) {
					clearOutput();
					outputText("You run right into a demon. The fiend look at you confused, then attacks with glee.");
					if (flags[kFLAGS.CODEX_ENTRY_SUCCUBUS] <= 0) {
						flags[kFLAGS.CODEX_ENTRY_SUCCUBUS] = 1;
						outputText("\n\n<b>New codex entry unlocked: Succubus!</b>")
					}
					startCombat(new Succubus(), true);
				}
				if (choice == 3) {
					clearOutput();
					outputText("You run right into a demon. The fiend look at you confused, then attacks with glee.");
					startCombat(new Incubus(), true);
				}
				if (choice == 4) {
					clearOutput();
					outputText("You run right into a demon. The fiend look at you confused, then attacks with glee.");
					startCombat(new Omnibus(), true);
				}
				if (choice == 5) {
					clearOutput();
					outputText("You’ve barely walked yourself into the corridor when you spot a tentacle beast of absurd size rushing right at you, it looks hungry!");
					startCombat(new TentacleBeast(), true);
				}
				if (choice == 6) {
					clearOutput();
					outputText("Just as you turn the corner, you come face to face with a towering minotaur armed with a pair of huge battle axes and equipped with a full plate armor. The beast smirks as his cock hardens in anticipation. It must’ve been months since he last fucked something!");
					startCombat(new Minotaur(), true);
				}
				if (choice == 7) {
					clearOutput();
					outputText("Just as you turn the corner, you come face to face with a towering minotaur armed with a pair of huge battle axes and equipped with a full plate armor. The beast smirks as his cock hardens in anticipation. It must’ve been months since he last fucked something!");
					startCombat(new Minotaur(), true);//Mindbreaker
				}
				doNext(playerMenu);
			}
			else player.addStatusValue(StatusEffects.EbonLabyrinthA, 1, 10);
		}
		private function nightAmbushRuletteEL():void {
			var choice:Number = rand(8);
			if (choice == 0) {
				if (flags[kFLAGS.CODEX_ENTRY_DISPLACER_BEAST] <= 0) {
					flags[kFLAGS.CODEX_ENTRY_DISPLACER_BEAST] = 1;
					outputText("<b>New codex entry unlocked: Displacer beast!</b>\n\n")
				}
				startCombat(new DisplacerBeast(), true);
			}
			if (choice == 1) startCombat(new DarkSlime(), true);
			if (choice == 2) {
				if (flags[kFLAGS.CODEX_ENTRY_SUCCUBUS] <= 0) {
					flags[kFLAGS.CODEX_ENTRY_SUCCUBUS] = 1;
					outputText("\n\n<b>New codex entry unlocked: Succubus!</b>")
				}
				startCombat(new Succubus(), true);
			}
			if (choice == 3) startCombat(new Incubus(), true);
			if (choice == 4) startCombat(new Omnibus(), true);
			if (choice == 5) startCombat(new TentacleBeast(), true);
			if (choice == 6) startCombat(new Minotaur(), true);
			if (choice == 7) startCombat(new Minotaur(), true);//Mindbreaker
			doNext(playerMenu);
		}
		public function doSleepEL():void {
			if (rand(2) == 0) {
				clearOutput();
				cheatTime2(15);
				outputText("You ready your bedroll and go to sleep, keen on continuing your exploration tomorrow. Sadly as you prepare to lay down, a creature from the labyrinth stumbles upon your makeshift camp and you are forced to defend yourself.\n");
				player.createStatusEffect(StatusEffects.ThereCouldBeOnlyOne, 0, 0, 0, 0);
				nightAmbushRuletteEL();
			}
			else {//ten fragment poniżej wciaż uszkodzony i wymaga naprawy
				clearOutput();
				var timeQ:Number = 0;
				if (model.time.hours == 21) timeQ = 9;
				if (model.time.hours == 22) timeQ = 8;
				if (model.time.hours >= 23) timeQ = 7;
				if (model.time.hours == 0) timeQ = 6;
				if (model.time.hours == 1) timeQ = 5;
				if (model.time.hours == 2) timeQ = 4;
				if (model.time.hours == 3) timeQ = 3;
				if (model.time.hours == 4) timeQ = 2;
				if (model.time.hours == 5) timeQ = 1;
				player.createStatusEffect(StatusEffects.ThereCouldBeOnlyOne, 0, 0, 0, 0);
				if (player.isGargoyle()) outputText("You sit on your pedestal, your body petrifying like stone as you go to sleep, keen on continuing your exploration tomorrow.\n");
				else if (player.isAlraune()) outputText("You lie down in your pitcher, dozing off for the night as you close off your petals to sleep.\n");
				else outputText("You ready your bedroll and go to sleep, keen on continuing your exploration tomorrow.\n");
				var multiplier:Number = 1.0;
				var fatRecovery:Number = 20;
				var hpRecovery:Number = 20;
				if (player.level >= 24) {
					fatRecovery += 10;
					hpRecovery += 10;
				}
				if (player.level >= 42) {
					fatRecovery += 10;
					hpRecovery += 10;
				}
				if (player.findPerk(PerkLib.SpeedyRecovery) >= 0) fatRecovery += 5;
				if (player.findPerk(PerkLib.SpeedyRecuperation) >= 0) fatRecovery += 10;
				if (player.findPerk(PerkLib.SpeedyRejuvenation) >= 0) fatRecovery += 20;
				if (player.findPerk(PerkLib.ControlledBreath) >= 0) fatRecovery *= 1.1;
				if (player.hasStatusEffect(StatusEffects.BathedInHotSpring)) fatRecovery *= 1.2;
				if (player.findPerk(PerkLib.RecuperationSleep) >= 0) multiplier += 1;
				if (player.findPerk(PerkLib.RejuvenationSleep) >= 0) multiplier += 2;
				if (flags[kFLAGS.HUNGER_ENABLED] > 0)
				{
					if (player.hunger < 25)
					{
						outputText("\nYou have difficulty sleeping as your stomach is growling loudly.\n");
						multiplier *= 0.5;
					}
				}
				//Marble withdrawl
				if(player.hasStatusEffect(StatusEffects.MarbleWithdrawl)) {
					outputText("\nYour sleep is very troubled, and you aren't able to settle down.  You get up feeling tired and unsatisfied, always thinking of Marble's milk.\n");
					multiplier *= 0.5;
					dynStats("tou", -.1, "int", -.1);
				}
				//Mino withdrawal
				else if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 3) {
					outputText("\nYou spend much of the night tossing and turning, aching for a taste of minotaur cum.\n");
					multiplier *= 0.75;
				}
				//Bee cock
				if (player.hasCock() && player.cocks[0].cockType == CockTypesEnum.BEE) {
					outputText("\nThe desire to find the bee girl that gave you this cursed [cock] and have her spread honey all over it grows with each passing minute\n");
				}
				//Starved goo armor
				if (player.armor == armors.GOOARMR && flags[kFLAGS.VALERIA_FLUIDS] <= 0) {
					outputText("\nYou feel the fluid-starved goo rubbing all over your groin as if Valeria wants you to feed her.\n");
				}
				HPChange((timeQ * hpRecovery * multiplier), false);
				fatigue( -(timeQ * fatRecovery * multiplier));
				model.time.hours += timeQ;
				SceneLib.combat.regeneration(false);
				if (player.findPerk(PerkLib.JobSoulCultivator) >= 0) SceneLib.combat.soulforceregeneration(false);
				if (player.findPerk(PerkLib.JobSorcerer) >= 0) SceneLib.combat.manaregeneration(false);
				SceneLib.combat.wrathregeneration(false);
				if (model.time.hours > 23) {
					model.time.hours -= 24;
					/*CoC.instance.*/model.time.days++;
				}
				doNext(playerMenu);
			}
		}
		
		//Rooms
		public function roomAAA():void {
			dungeonLoc = 131;
			clearOutput();
			checkingTodayMenu();
			if (CoC.instance.inCombat || _cuteScene == 2) return;
			checkingELAchievs();
			outputText("<b><u>Corridor</u></b>\n");
			outputText("You walk into an empty corridor thankfully it seems to be void of monsters so far.");
			outputText("\n\nRooms Explored: " + player.statusEffectv1(StatusEffects.EbonLabyrinthB));
			dungeons.setDungeonButtonsEL(roomDDD, roomDDD, roomBBB, roomBBB, roomCCC, roomCCC);
		}
		public function roomBBB():void {
			dungeonLoc = 132;
			clearOutput();
			checkingTodayMenu();
			if (CoC.instance.inCombat || _cuteScene == 2) return;
			checkingELAchievs();
			outputText("<b><u>Corridor</u></b>\n");
			outputText("You turn the corner wandering into a new corridor which thankfully seems to be void of monsters so far.");
			outputText("\n\nRooms Explored: " + player.statusEffectv1(StatusEffects.EbonLabyrinthB));
			dungeons.setDungeonButtonsEL(roomCCC, roomCCC, roomAAA, roomAAA, roomDDD, roomDDD);
		}
		public function roomCCC():void {
			dungeonLoc = 133;
			clearOutput();
			checkingTodayMenu();
			if (CoC.instance.inCombat || _cuteScene == 2) return;
			checkingELAchievs();
			outputText("<b><u>Corridor</u></b>\n");
			outputText("You walk into an empty corridor thankfully it seems to be void of monsters so far.");
			outputText("\n\nRooms Explored: " + player.statusEffectv1(StatusEffects.EbonLabyrinthB));
			dungeons.setDungeonButtonsEL(roomBBB, roomBBB, roomDDD, roomDDD, roomAAA, roomAAA);
		}
		public function roomDDD():void {
			dungeonLoc = 134;
			clearOutput();
			checkingTodayMenu();
			if (CoC.instance.inCombat || _cuteScene == 2) return;
			checkingELAchievs();
			outputText("<b><u>Corridor</u></b>\n");
			outputText("You turn the corner wandering into a new corridor which thankfully seems to be void of monsters so far.");
			outputText("\n\nRooms Explored: " + player.statusEffectv1(StatusEffects.EbonLabyrinthB));
			dungeons.setDungeonButtonsEL(roomAAA, roomAAA, roomCCC, roomCCC, roomBBB, roomBBB);
		}
		public function checkingTodayMenu():void {
			if ((player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 10 || player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 20 || player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 30 || player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 40 || 
			player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 60 || player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 70 || player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 80 || player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 90 || 
			player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 110 || player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 120 || player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 130 || player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 140 || 
			player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 160 || player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 170 || player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 180 || player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 190 || 
			player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 210 || player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 220 || player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 230 || player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 240 || 
			player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 260 || player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 270 || player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 280 || player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 290 || 
			player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 310 || player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 320 || player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 330 || player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 340 || 
			player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 360 || player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 370 || player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 380 || player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 390 || 
			player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 410 || player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 420 || player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 430 || player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 440 || 
			player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 460 || player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 470 || player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 480 || player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 490 || 
			player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 510 || player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 520 || player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 530 || player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 540 || 
			player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 560 || player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 570 || player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 580 || player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 590)  && !player.hasStatusEffect(StatusEffects.ThereCouldBeOnlyOne)) {
				player.addStatusValue(StatusEffects.EbonLabyrinthA, 1, 10);
				encountersLootChest();
			}
			else if ((player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 50 || player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 100 || player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 150) && !player.hasStatusEffect(StatusEffects.ThereCouldBeOnlyOne)) {
				player.addStatusValue(StatusEffects.EbonLabyrinthA, 1, 10);
				encountersRuletteBossesEL1();
			}/*
			else if ((player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 200 || player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 250 || player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 300) && !player.hasStatusEffect(StatusEffects.ThereCouldBeOnlyOne)) {
				player.addStatusValue(StatusEffects.EbonLabyrinthA, 1, 10);
				encountersRuletteBossesEL2();
			}*/
			else if (player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 295 && player.hasStatusEffect(StatusEffects.RathazulAprilFool) && player.statusEffectv1(StatusEffects.RathazulAprilFool) == 0 && !player.hasStatusEffect(StatusEffects.ThereCouldBeOnlyOne)) {
				player.addStatusValue(StatusEffects.EbonLabyrinthA, 1, 10);
				encountersFountainOfPurity();
			}
			else encountersRuletteEL();
		}
		public function checkingELAchievs():void {
			if (player.statusEffectv1(StatusEffects.EbonLabyrinthB) >= 50 && flags[kFLAGS.EBON_LABYRINTH] == 1) {
				awardAchievement("Honorary Minotaur", kACHIEVEMENTS.DUNGEON_HONORARY_MINOTAUR);
				flags[kFLAGS.EBON_LABYRINTH] = 2;
			}
			if (player.statusEffectv1(StatusEffects.EbonLabyrinthB) >= 100) awardAchievement("Got lost?", kACHIEVEMENTS.DUNGEON_GOT_LOST);
			if (player.statusEffectv1(StatusEffects.EbonLabyrinthB) >= 150) awardAchievement("Hug the left wall", kACHIEVEMENTS.DUNGEON_HUG_THE_LEFT_WALL);
			if (player.statusEffectv1(StatusEffects.EbonLabyrinthB) >= 200) awardAchievement("Pan ain't got nothing on you", kACHIEVEMENTS.DUNGEON_PAN_AINT_GOT_NOTHING_ON_YOU);
			if (player.statusEffectv1(StatusEffects.EbonLabyrinthB) >= 250) awardAchievement("Master of the labyrinth", kACHIEVEMENTS.DUNGEON_MASTER_OF_THE_LABYRINT);
			if (player.statusEffectv1(StatusEffects.EbonLabyrinthB) >= 300) awardAchievement("Why are you here?", kACHIEVEMENTS.DUNGEON_WHY_ARE_YOU_HERE);
			/*if (player.statusEffectv1(StatusEffects.EbonLabyrinthB) >= 350) awardAchievement("", kACHIEVEMENTS.);
			if (player.statusEffectv1(StatusEffects.EbonLabyrinthB) >= 400) awardAchievement("", kACHIEVEMENTS.);
			if (player.statusEffectv1(StatusEffects.EbonLabyrinthB) >= 450) awardAchievement("", kACHIEVEMENTS.);
			if (player.statusEffectv1(StatusEffects.EbonLabyrinthB) >= 500) awardAchievement("", kACHIEVEMENTS.);
			if (player.statusEffectv1(StatusEffects.EbonLabyrinthB) >= 550) awardAchievement("", kACHIEVEMENTS.);
			if (player.statusEffectv1(StatusEffects.EbonLabyrinthB) >= 600) awardAchievement("", kACHIEVEMENTS.);*/
		}
	}
}