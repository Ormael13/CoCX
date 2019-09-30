/**
 * Quest Dungeon: The Ebon Labyrinth (for Alvina Black Rose Quest)
 * @author Liadri
 */
package classes.Scenes.Dungeons 
{
import classes.CockTypesEnum;
import classes.EventParser;
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

	public class EbonLabyrinth extends DungeonAbstractContent
	{
		private static const DUNGEON_EBON_LABYRINTH_0:int	= 131;
		private static const DUNGEON_EBON_LABYRINTH_1:int	= 132;
		private static const DUNGEON_EBON_LABYRINTH_2:int	= 133;
		private static const DUNGEON_EBON_LABYRINTH_3:int	= 134;
		
		public var elDisplacerbeast:DisplacerBeastScene = new DisplacerBeastScene();
		public var ancientTentacleBeast:TentacleBeastScene = new TentacleBeastScene();
		
		public function EbonLabyrinth() {}
		
		public function ebonlabyrinthdiscovery():void {
			flags[kFLAGS.EBON_LABYRINTH] = 1;
			clearOutput();
			outputText("You find the entrance to what appears like a tunnel made of stone. This place looks man made as if carved by humanoid hands yet sports no decoration. Just empty linear corridors and corners dimly lit by magical torches. On a wall you find a sign reading ");
			outputText("-Woe to who seeketh the black rose. Thy who enter beware for, while riches you may find, death lurks in the Labyrinth deepest reaches. It ever hungers.- how charming. The ruin of an old campfire is all that's left of the previous adventurers to come here.\n\n");
			outputText("<b>You found the Ebon Labyrinth.</b>\n\n");
			doNext(enterDungeon);
		}
		public function enterDungeon():void {
			inDungeon = true;
			dungeonLoc = 131;
			player.createStatusEffect(StatusEffects.EbonLabyrinthA, 10, 0, 0, 0);
			player.createStatusEffect(StatusEffects.EbonLabyrinthB, 0, 0, 0, 0);
			playerMenu();
		}
		public function exitDungeon():void {
			inDungeon = false;
			clearOutput();
			outputText("You leave the Ebon Labyrinth behind and take off back towards the camp.");
			player.removeStatusEffect(StatusEffects.EbonLabyrinthA);
			player.removeStatusEffect(StatusEffects.EbonLabyrinthB);
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
			outputText("\n\n");
			//[GAME OVER]
			EventParser.gameOver();
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
			outputText("Upon your defeat the tentacled fiends draw an appendage ending up with a nasty needle and force in your left side pouring into you transformative fluid.");
			outputText(" Your chest begins to puff up growing up in size");
			if (player.biggestTitSize() < 1) outputText(" from nothing");
			player.growTits(1 + rand(3), 1, false, 3);
			outputText("! Milks churns inside ready for the harvest.");
			player.boostLactation(1.5);
			if (player.cocks.length == 0) {
				outputText(" Just as you were thinking about your breast you feel a bump of flesh between your legs growing steadily until it breaks out standing erect. This… this thing is a penis!");
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
				if (player.hasCock()) outputText(" Oh no your a full herm now!");
			}
			outputText("\n\nWhile you attempt to resist the abomination, its raw muscle mass is too much. It pins you to the ground easily. You immediately feel a sharp, horrible pain at the base of your ample cock. You look down to see the end of a thorny tendril impaled in your pelvic region. Fiery pain courses through your veins as you feel ");
			outputText("the creature inject you with some sort of liquid. As the pain sears through you, your member immediately becomes fully erect and pre-cum leaks liberally from your tip.  Two thorny tentacles pierce your nipples, and you feel as if someone shot acid into your tits, which immediately begin to swell.\n\n");
			outputText("Realizing what is about to happen, you try to struggle. The beast responds by slamming you to the ground a few times, stunning you. In your daze you see a monstrous, hollow tentacle poised over your furious cock. You scream in shock and protest, but your cries fall upon deaf ears. ");
			outputText("The tentacle descends upon your nice cock, now begging for release, and clamps down upon your pubic mound, fully encapsulating your member.\n\n");
			ancientTentacleBeast.futaTentacleBadEndEL();
		}
		public function defeatedByLabyrinthMinotaur():void {
			clearOutput();
			outputText("\n\n");
			//[GAME OVER]
			EventParser.gameOver();
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
			outputText("\n\n");
			//[GAME OVER]
			EventParser.gameOver();
		}
		
		private function encountersRuletteBossesEL():void {
			if (flags[kFLAGS.ALVINA_FOLLOWER] == 17) {
				outputText("You finally find the center of the labyrinth, somewhat exhausted. You can see the rose from here in all its dark beauty. As you are about to approach it, a monstrous creature lands right in front of you. This beast has no less than four heads! A dragon on the left, a lion on the center, a goat on ");
				outputText("the right and, at the tip of its tail, the head of a snake! All four heads roar a warning at you as the beast stands up on its leonine legs, easily twelve feet tall, its massive wings opening in a threatening display revealing nothing short of four erect thirty inches cock already drooling precum!\n\n");
				outputText("\"<i>Foolish intruder, you walked to your death! No one but me will ever touch the rose for it is mine and no one else's! I will rape you and then devour you alive!</i>\"\n\n");
				outputText("<b>It's too late to run as you're fighting the chaos chimera!</b>");
				startCombat(new ChaosChimera(), true);
			}
			else {
				outputText("You turn around the corner and come face to face with a greyish six armed catgirl. She would be terrifying already even without the two tentacles on her back that writhe in excitation. Readying for battle is the best you can do as the beast woman charges you with a gleam of hunger in her feral eyes.\n\n");
				outputText("<b>It's placeholder enocunter to test procing boss fight!</b>");
				startCombat(new DisplacerBeast(), true);
			}
		}
		private function encountersRuletteEL():void {
			if (rand(100) < player.statusEffectv1(StatusEffects.EbonLabyrinthA)) {
				var reset:Number = 10;
				reset -= player.statusEffectv1(StatusEffects.EbonLabyrinthA);
				player.addStatusValue(StatusEffects.EbonLabyrinthA, 1, reset);
				var choice:Number = rand(8);
				if (choice == 0) {
					outputText("You turn around the corner and come face to face with a greyish six armed catgirl. She would be terrifying already even without the two tentacles on her back that writhe in excitation. Readying for battle is the best you can do as the beast woman charges you with a gleam of hunger in her feral eyes.");
					startCombat(new DisplacerBeast(), true);
				}
				if (choice >= 1 && choice < 5) {
				//if (choice == 1) {
					//spriteSelect(25);
					outputText("As you wander into a new corridor you come face to face with a purplish jelly-like woman. She giggles upon spotting you, her small, sphere-shaped core emitting an ominous light as she surges toward you with a gooey smile.\n\n");
					outputText("\"<i>Dinner is served! Your fluids are mine, so surrender them now intruder and I promise to make it very pleasurable for you!</i>\"");
					startCombat(new DarkSlime(), true);
				}/*
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
				}*/
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
					startCombat(new Minotaur(), true);
				}
				//Dark Slime, Mindbreaker
				doNext(playerMenu);
			}
			else player.addStatusValue(StatusEffects.EbonLabyrinthA, 1, 10);
		}
		private function nightAmbushRuletteEL():void {
			var choice:Number = rand(8);
			if (choice == 0) startCombat(new DisplacerBeast(), true);
			if (choice == 1) startCombat(new DarkSlime(), true);
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
				startCombat(new Minotaur(), true);
			}
			//Dark Slime, Mindbreaker
			doNext(playerMenu);
		}
		public function doSleepEL():void {
			if (rand(2) == 0) {
				outputText("You ready your bedroll and go to sleep keen on continuing your exploration tomorrow. Sadly as you prepare to lay down, a creature from the labyrinth stumbles upon your makeshift camp and you are forced to defend yourself.\n");
				nightAmbushRuletteEL();
			}
			else {
				var timeQ:Number = 0;
				if(model.time.hours == 21) timeQ = 540;
				if(model.time.hours == 22) timeQ = 480;
				if(model.time.hours >= 23) timeQ = 420;
				if(model.time.hours == 0) timeQ = 360;
				if(model.time.hours == 1) timeQ = 300;
				if(model.time.hours == 2) timeQ = 240;
				if(model.time.hours == 3) timeQ = 180;
				if(model.time.hours == 4) timeQ = 120;
				if(model.time.hours == 5) timeQ = 60;
				clearOutput();
				if (player.isGargoyle()) outputText("You sit on your pedestal, your body petrifying like stone as you go to sleep, keen on continuing your exploration tomorrow.\n");
				else outputText("You ready your bedroll and go to sleep, keen on continuing your exploration tomorrow.\n");
				camp.sleepRecovery(true);
				cheatTime2(timeQ);
			}
		}
		
		//Rooms
		public function roomAAA():void {
			dungeonLoc = 131;
			clearOutput();
			if (player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 4 || player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 9) encountersRuletteBossesEL();
			else encountersRuletteEL();
			player.addStatusValue(StatusEffects.EbonLabyrinthB, 1, 1);
			checkingELAchievs();
			if (CoC.instance.inCombat) return;
			outputText("<b><u>Corridor</u></b>\n");
			outputText("You walk into an empty corridor thankfully it seems to be void of monsters so far.");
			outputText("\n\nRooms Explored: " + player.statusEffectv1(StatusEffects.EbonLabyrinthB));
			dungeons.setDungeonButtonsEL(roomDDD, roomDDD, roomBBB, roomBBB);
		}
		public function roomBBB():void {
			dungeonLoc = 132;
			clearOutput();
			if (player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 4 || player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 9) encountersRuletteBossesEL();
			else encountersRuletteEL();
			player.addStatusValue(StatusEffects.EbonLabyrinthB, 1, 1);
			checkingELAchievs();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Corridor</b>\n");
			outputText("You turn the corner wandering into a new corridor which thankfully seems to be void of monsters so far.");
			outputText("\n\nRooms Explored: " + player.statusEffectv1(StatusEffects.EbonLabyrinthB));
			dungeons.setDungeonButtonsEL(roomCCC, roomCCC, roomAAA, roomAAA);
		}
		public function roomCCC():void {
			dungeonLoc = 133;
			clearOutput();
			if (player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 4 || player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 9) encountersRuletteBossesEL();
			else encountersRuletteEL();
			player.addStatusValue(StatusEffects.EbonLabyrinthB, 1, 1);
			checkingELAchievs();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Corridor</b>\n");
			outputText("You walk into an empty corridor thankfully it seems to be void of monsters so far.");
			outputText("\n\nRooms Explored: " + player.statusEffectv1(StatusEffects.EbonLabyrinthB));
			dungeons.setDungeonButtonsEL(roomBBB, roomBBB, roomDDD, roomDDD);
		}
		public function roomDDD():void {
			dungeonLoc = 134;
			clearOutput();
			if (player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 4 || player.statusEffectv1(StatusEffects.EbonLabyrinthB) == 9) encountersRuletteBossesEL();
			else encountersRuletteEL();
			player.addStatusValue(StatusEffects.EbonLabyrinthB, 1, 1);
			checkingELAchievs();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Corridor</b>\n");
			outputText("You turn the corner wandering into a new corridor which thankfully seems to be void of monsters so far.");
			outputText("\n\nRooms Explored: " + player.statusEffectv1(StatusEffects.EbonLabyrinthB));
			dungeons.setDungeonButtonsEL(roomAAA, roomAAA, roomCCC, roomCCC);
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
		}
	}
}