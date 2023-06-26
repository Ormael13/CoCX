/**
 * Side Dungeon: River Dungeon (Dungeon with multiple floors below He'Xin'Dao)
 * @author Ormael, Liadri
 */
package classes.Scenes.Dungeons
{
import classes.CoC;
import classes.EventParser;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Shield;
import classes.Items.Weapon;
import classes.PerkLib;
import classes.Scenes.Areas.GlacialRift.Yeti;
import classes.Scenes.Areas.Mountain.HellHound;
import classes.Scenes.Dungeons.RiverDungeon.*;
import classes.Scenes.Monsters.FeralImps;
import classes.Scenes.Monsters.GolemDummyImproved;
import classes.Scenes.NPCs.Electra;
import classes.Scenes.SceneLib;
import classes.StatusEffects;
import classes.display.SpriteDb;

public class RiverDungeon extends DungeonAbstractContent
	{
		public function RiverDungeon() {} //flags[kFLAGS.RIVER_DUNGEON_FLOORS_PROGRESS] 1 - pok 1 golema, 2 pokonanie obu golemów, 3-6 pokonanie 4 żywiołaków sub bossów, 7 pokonanie chimerycznego żywiołaka, 8 otwarcie drzwi do bossa 3 poziomu, 9 pokonanie bossa 3 poziomu
		
		public function enterDungeon():void {
			inDungeon = true;
			dungeonLoc = DUNGEON_RIVER_FLOOR_01_ROOM_01;
			player.createStatusEffect(StatusEffects.RiverDungeonA, 10, 0, 0, 0);
			if (!player.hasStatusEffect(StatusEffects.RivereDungeonIB)) player.createStatusEffect(StatusEffects.RivereDungeonIB, 0, 0, 0, 0);
			playerMenu();
		}
		public function exitDungeon():void {
			inDungeon = false;
			clearOutput();
			if (flags[kFLAGS.NEISA_FOLLOWER] == 3) {
				outputText("As the pair of you leave the dungeon Neisa waves you off, heading back to town.\n\n");
				outputText("\"<i>Nice going along with you [name]. I’m going to go and spend this bling. If you ever need of my services again, I'll be at the bar.</i>\"\n\n");
				player.removeStatusEffect(StatusEffects.CombatFollowerNeisa);
				flags[kFLAGS.PLAYER_COMPANION_1] = "";
				flags[kFLAGS.NEISA_FOLLOWER] = 4;
				outputText("Working together with another person has taught you how to fight in a group. <b>Gained Perk: Basic Leadership</b>");
				player.createPerk(PerkLib.BasicLeadership,0,0,0,0);
			}
			else outputText("You leave the river dungeon behind and take off, heading through He'Xin'Dao and back to camp.");
			if (player.hasStatusEffect(StatusEffects.ThereCouldBeOnlyOne)) player.removeStatusEffect(StatusEffects.ThereCouldBeOnlyOne);
			player.removeStatusEffect(StatusEffects.RiverDungeonA);
			doNext(camp.returnToCampUseOneHour);
		}
		private function encountersRulette():Boolean {
			return (rand(100) < player.statusEffectv1(StatusEffects.RiverDungeonA)) && !player.hasStatusEffect(StatusEffects.ThereCouldBeOnlyOne);
		}
		
		private function encountersRuletteA():void {
			if (encountersRulette()) {
				var reset:Number = 10;
				reset -= player.statusEffectv1(StatusEffects.RiverDungeonA);
				player.addStatusValue(StatusEffects.RiverDungeonA, 1, reset);
				player.createStatusEffect(StatusEffects.ThereCouldBeOnlyOne, 0, 0, 0, 0);
				var choice:Number = rand(3);
				if (choice == 0) {
					spriteSelect(SpriteDb.s_imp);
					outputText("A feral imp suddenly appears from nearby passage and attacks!");
					camp.codex.unlockEntry(kFLAGS.CODEX_ENTRY_IMPS);
					flags[kFLAGS.FERAL_EXTRAS] = 5;
					startCombat(new FeralImps(), true);
				}
				if (choice == 1) {
					//spriteSelect(SpriteDb.);
					outputText("A soft shuffling splat catches your attention and you turn around, spotting an amorphous red mass sliding towards you!  Realizing it's been spotted, the ooze's mass surges upwards into a humanoid form with thick arms and wide shoulders.  The beast surges forward to attack!");
					flags[kFLAGS.RED_OOZE_SUBTYPE] = 2;
					startCombat(new RedOoze(), true);
				}
				if (choice == 2) {
					spriteSelect(SpriteDb.s_hellhound);
					outputText("You hear a fiery howl as a demonic, two-headed beast-man leaps out of a nearby passage!");
					camp.codex.unlockEntry(kFLAGS.CODEX_ENTRY_HELLHOUNDS);
					startCombat(new HellHound(), true);
				}
				//doNext(playerMenu);
			}
			else player.addStatusValue(StatusEffects.RiverDungeonA, 1, 10);
		}
		public function defeatedByFeralImp():void {
			clearOutput();
			outputText("Your opponent, done toying with your body, carries you all the way back to the dungeon entrance. They toss you onto the ground outside. Guess it's back to square one.\n\n");
			dungeonLoc = DUNGEON_RIVER_FLOOR_01_ROOM_01;
			cleanupAfterCombat();
		}
		public function defeatedByRedOoze():void {
			clearOutput();
			outputText("Your opponent, done toying with your body, carries you all the way back to the dungeon entrance. They toss you onto the ground outside. Guess it's back to square one.\n\n");
			dungeonLoc = DUNGEON_RIVER_FLOOR_01_ROOM_01;
			cleanupAfterCombat();
		}
		public function defeatedByHellHound():void {
			clearOutput();
			outputText("Your opponent, done toying with your body, carries you all the way back to the dungeon entrance. They toss you onto the ground outside. Guess it's back to square one.\n\n");
			dungeonLoc = DUNGEON_RIVER_FLOOR_01_ROOM_01;
			cleanupAfterCombat();
		}
		public function defeatedByAetherGolem():void {
			clearOutput();
			outputText("Beaten, you don’t have enough strength left to stop the golem from knocking you out. After you wake up you find out that you’ve got a pair of gauntlets on your hands connected to a net of thin goo-like things that cover your whole body.\n\n");
			outputText(" You suddenly hear a feminine voice in your head.<i>This one would be much better than those mindless golems we used so far,</i> A second voice responds, nearly identical to the first. <i>Of course, living flesh is way better than simple animated stones. Goodnight, meatsack.</i> With that you once again lose consciousness for the last time. \n\n");
			outputText("After taking over control of the champion’s body, the new owners command it to go out of the dungeon, and leave He'Xin'Dao. Both gauntlets let out girlish laughter as they escape, commanding their new host body to go, piloting towards a destination known only by them...\n\n");
			//[GAME OVER]
			EventParser.gameOver();
		}
		public function takeAetherSister1():void {
			clearOutput();
			outputText("Succumbing to your skill in battle, the aether golem slumps backwards against the wall, unable to stand.  You loom over it, grinning as you loom over your helpless opponent.\n\n");
			outputText("\"<i>Wait!</i>\" the voice resounds in your head. \"<i>You're much better than this souless golem. This place...is boring and dark. Let me join you.");
			if (flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] == 2) outputText(" You even have my twin sister.");
			outputText(" So shall I come with you? </i> An image of your camp flashes through your mind, and you blink, startled. <i> or shall I wait for you there?</i>\"");
			flags[kFLAGS.AETHER_DEXTER_EVO] = 1;
			menu();
			addButton(0, "Wait", takeAetherSister1a);
			addButton(1, "Come", takeAetherSister1b);
		}
		public function takeAetherSister1a():void {
			outputText("\n\nYou tell the voice to wait at the camp. The moment you say it, a thin tendril extends from the golem, wrapping around you for a moment. You see a flash of your camp, a spot not far from the edge of camp, and the gauntlet sitting there. The tendril receeds, and the ones covering the golem's body writhe, detaching and returning to the gauntlet. Once all the tendrils have vanished, the gauntlet vanishes in a flash of light, leaving only a damaged golem behind.");
			flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] = 1;
			cleanupAfterCombat();
			doNext(playerMenu);
		}
		public function takeAetherSister1b():void {
			var item:Weapon = player.setWeapon(weapons.AETHERD);
			cleanupAfterCombat();
			outputText("You tell the voice to come to you. With a giggle, the gauntlet that was covering the golem's arm moves, tendrils detaching from its previous host. The tendrils entwine, pulling it from the arm, crawling across the floor until it reaches you. The gauntlet's tendrils wrap around your arm, pulling it up and over your arm. \"<i>Let's bust some heads!");
			if (flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] == 2) outputText("</i>\" After this you hear other voice in your head. \"<i>The Aether twins united. Go go go twins!!!");
			outputText("</i>\"\n\n");
			if (item == null) inventory.takeItem(weapons.AETHERD, playerMenu); // failed to equip
			else if (item.isNothing) doNext(playerMenu); // equip to empty slot
			else inventory.takeItem(item, playerMenu);
		}
		public function takeAetherSister2():void {
			clearOutput();
			outputText("Succumbing to your skill in battle, the aether golem slumps backwards against the wall, unable to stand.  You loom over it, grinning as you contemplate what to do with your helpless opponent.\n\n");
			outputText("\"<i>Wait!</i>\" the voice resounds in your head. \"<i>You're much better than this souless golem. This place...is boring and dark. Let me join you.");
			if (flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] == 2) outputText(" You even have my twin sister.");
			outputText(" So shall I come with you? </i> An image of your camp flashes through your mind, and you blink, startled. <i> or shall I wait for you there?</i>\"");
			flags[kFLAGS.AETHER_SINISTER_EVO] = 1;
			menu();
			addButton(0, "Wait", takeAetherSister2a);
			addButton(1, "Come", takeAetherSister2b);
		}
		public function takeAetherSister2a():void {
			outputText("\n\nYou tell the voice to wait at the camp. The moment you say it, a thin tendril extends from the golem, wrapping around you for a moment. You see a flash of your camp, a spot not far from the edge of camp, and the gauntlet sitting there. The tendril receeds, and the ones covering the golem's body writhe, detaching and returning to the gauntlet. Once all the tendrils have vanished, the gauntlet vanishes in a flash of light, leaving only a damaged golem behind.");
			flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] = 1;
			cleanupAfterCombat();
			doNext(playerMenu);
		}
		public function takeAetherSister2b():void {
			var item:Shield = player.setShield(shields.AETHERS); //Item is now the player's old shield
			cleanupAfterCombat();
			outputText("You tell the voice to come to you. With a giggle, the gauntlet that was covering the golem's arm moves, tendrils detaching from its previous host. The tendrils entwine, pulling it from the arm, crawling across the floor until it reaches you. The gauntlet's tendrils wrap around your arm, pulling it up and over your right arm. \"<i>Let's bust some heads!");
			if (flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] == 2) outputText("</i>\" After this you hear other voice in your head. \"<i>The Aether twins are united!");
			outputText("</i>\"\n\n");
			if (item == null) inventory.takeItem(shields.AETHERS, playerMenu); // failed to equip
			else if (item.isNothing) doNext(playerMenu); // equip to empty slot
			else inventory.takeItem(item, playerMenu);
		}
		
		private function encountersRuletteB():void {
			if (encountersRulette()) {
				var reset:Number = 10;
				reset -= player.statusEffectv1(StatusEffects.RiverDungeonA);
				player.addStatusValue(StatusEffects.RiverDungeonA, 1, reset);
				player.createStatusEffect(StatusEffects.ThereCouldBeOnlyOne, 0, 0, 0, 0);
				var choice:Number = rand(4);
				if (choice == 0) {
					//spriteSelect(SpriteDb.s_green_slime);
					outputText("A soft shuffling sound catches your attention and you turn around, spotting a small ball of flame hurtling towards you!  Realizing it's been spotted, the elemental's body blazes, orange flames shooting from its body, in the crude shape of arms and legs. It advances, the air hissing and popping around it.");
					flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] = rand(3);
					startCombat(new FireElemental(), true);
				}
				if (choice == 1) {
					//spriteSelect(SpriteDb.s_green_slime);
					outputText("A soft shuffling sound catches your attention and you turn around, spotting a blob of water flowing towards you!  Realizing it's been spotted, the elemental's body splashes into the ground, flowing upwards into a humanoid form. The creature leans forward, sloshing in to attack");
					flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] = rand(3);
					startCombat(new WaterElemental(), true);
				}
				if (choice == 2) {
					//spriteSelect(SpriteDb.s_green_slime);
					outputText("A soft shuffling sound catches your attention and you turn around, spotting a small ball of wind rushing towards you!  Realizing it's been spotted, the elemental's body whirls, whipping winds visibly wrapping around, making crude arms and legs. It motions, sending debris your way.");
					flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] = rand(3);
					startCombat(new AirElemental(), true);
				}
				if (choice == 3) {
					//spriteSelect(SpriteDb.s_green_slime);
					outputText("A soft shuffling sound catches your attention and you turn around, spotting small mass of earth rumbling towards you!  Realizing it's been spotted, the elemental's body shoots from the ground, pillars of stone forming legs. Dirt arms sprout from the creature's core, and it lunges at you!");
					flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] = rand(3);
					startCombat(new EarthElemental(), true);
				}
				//doNext(playerMenu);
			}
			else player.addStatusValue(StatusEffects.RiverDungeonA, 1, 10);
		}
		private function encountersRuletteBFire():void {
			if (encountersRulette()) {
				var reset:Number = 10;
				reset -= player.statusEffectv1(StatusEffects.RiverDungeonA);
				player.addStatusValue(StatusEffects.RiverDungeonA, 1, reset);
				player.createStatusEffect(StatusEffects.ThereCouldBeOnlyOne, 0, 0, 0, 0);
				//spriteSelect(SpriteDb.s_green_slime);
				outputText("A soft shuffling sound catches your attention and you turn around, spotting a large ball of flame rushing towards you!  Realizing it's been spotted, the elemental's body blazes, sprouting crude arms and legs. It shoots a burst of flame in your direction, crackling angrily.");
				flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] = 3;
				startCombat(new FireElemental(), true);
				//doNext(playerMenu);
			}
			else player.addStatusValue(StatusEffects.RiverDungeonA, 1, 20);
		}
		private function encountersRuletteBWater():void {
			if (encountersRulette()) {
				var reset:Number = 10;
				reset -= player.statusEffectv1(StatusEffects.RiverDungeonA);
				player.addStatusValue(StatusEffects.RiverDungeonA, 1, reset);
				player.createStatusEffect(StatusEffects.ThereCouldBeOnlyOne, 0, 0, 0, 0);
				outputText("A soft shuffling sound catches your attention and you turn around, spotting a large blob of water rushing towards you!  Realizing it's been spotted, the elemental's body flows, growing pseudopods of water. It takes a humanoid shape, advancing to attack.");
				flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] = 3;
				startCombat(new WaterElemental(), true);
				//doNext(playerMenu);
			}
			else player.addStatusValue(StatusEffects.RiverDungeonA, 1, 20);
		}
		private function encountersRuletteBAir():void {
			if (encountersRulette()) {
				var reset:Number = 10;
				reset -= player.statusEffectv1(StatusEffects.RiverDungeonA);
				player.addStatusValue(StatusEffects.RiverDungeonA, 1, reset);
				player.createStatusEffect(StatusEffects.ThereCouldBeOnlyOne, 0, 0, 0, 0);
				//spriteSelect(SpriteDb.s_green_slime);
				outputText("A soft shuffling sound catches your attention and you turn around, spotting a large gust of wind rushing towards you!  Realizing it's been spotted, the elemental's body changes into a humanoid form and attacks!");
				flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] = 3;
				startCombat(new AirElemental(), true);
				//doNext(playerMenu);
			}
			else player.addStatusValue(StatusEffects.RiverDungeonA, 1, 20);
		}
		private function encountersRuletteBEarth():void {
			if (encountersRulette()) {
				var reset:Number = 10;
				reset -= player.statusEffectv1(StatusEffects.RiverDungeonA);
				player.addStatusValue(StatusEffects.RiverDungeonA, 1, reset);
				player.createStatusEffect(StatusEffects.ThereCouldBeOnlyOne, 0, 0, 0, 0);
				//spriteSelect(SpriteDb.s_green_slime);
				outputText("A soft shuffling sound catches your attention and you turn around, spotting large mass of earth rushing towards you!  Realizing it's been spotted, the elemental's body reforms into a humanoid form and attacks!");
				flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] = 3;
				startCombat(new EarthElemental(), true);
				//doNext(playerMenu);
			}
			else player.addStatusValue(StatusEffects.RiverDungeonA, 1, 20);
		}
		
		public function defeatedByFireElemental():void {
			clearOutput();
			outputText("Your opponent punches you a few more times, then carries you all the way back to the floor entrance. Your flesh sizzles in its grasp, and you groan in pain. It drops your body there, turning back into the dungeon. \n\n");
			dungeonLoc = DUNGEON_RIVER_FLOOR_02_ROOM_01;
			cleanupAfterCombat();
		}
		public function defeatedByWaterElemental():void {
			clearOutput();
			outputText("Your opponent punches you few more times, then carries you all the way back to the floor entrance. It drops you there, soaking wet. Guess it's back to square one on this floor.\n\n");
			dungeonLoc = DUNGEON_RIVER_FLOOR_02_ROOM_01;
			cleanupAfterCombat();
		}
		public function defeatedByAirElemental():void {
			clearOutput();
			outputText("Your opponent knocks you to the ground in a stunned heap. It then carries you all the way back to the floor entrance, your [skin] tender from windburn. It tosses you, then returns to the dungeon. \n\n");
			dungeonLoc = DUNGEON_RIVER_FLOOR_02_ROOM_01;
			cleanupAfterCombat();
		}
		public function defeatedByEarthElemental():void {
			clearOutput();
			outputText("Your opponent knocks you to the ground in a stunned heap. It carries all the way back to the floor entrance and drops you there, covered in mud. Guess it's back to square one on this floor.\n\n");
			dungeonLoc = DUNGEON_RIVER_FLOOR_02_ROOM_01;
			cleanupAfterCombat();
		}
		public function defeatedByFireElementalSubBoss():void {
			clearOutput();
			outputText("As You collapse, unable to fight any longer, the Ifrit summons several additional blazing spheres. Her hands heat with blazing fire as she continues the somatics, condensing her hands together as the spheres shoot toward you.\n\n");
			outputText("Your world is set aflame as the fire burns you to ashes. There is nothing left of you but a few burnt remains, and your [weapon], left there as a grim reminder.\n\n");
			//[GAME OVER]
			EventParser.gameOver();
		}
		public function defeatedByWaterElementalSubBoss():void {
			clearOutput();
			outputText("You collapse from your wounds, unable to fight any longer as Undine presses the attack, freely flicking sharp, crescent-shaped shards of water at you.\n\n");
			outputText("As your [skin] is carved away from the jets of water, your mind swirls. Mercifully, you black out, not feeling any more of your own death.\n\n");
			//[GAME OVER]
			EventParser.gameOver();
		}
		public function defeatedByAirElementalSubBoss():void {
			clearOutput();
			outputText("As you fall, unable to fight any longer, the Sylph advances upon you. The wind around you swirls as the Sylph prepares another strike. Air currents condense into new crescent-shaped wind blades, covering your paths of retreat. You pause, watching in horror as a wall of wind blades surround you. The sylph waves its hand, sending every last blade in your direction.\n\n");
			outputText("You brace yourself for the lacerations, each blade cuts through you, sending your blood spattering across the floor and walls. Your journey comes to an end, gone with the wind.\n\n");
			//[GAME OVER]
			EventParser.gameOver();
		}
		public function defeatedByEarthElementalSubBoss():void {
			clearOutput();
			outputText("As you collapse, unable to fight any longer, you notice numerous pointed stones circle around the air. The golem swings her hand in a single fluid motion before the razor-like stones dig into you.\n\n");
			outputText("You don't have enough time to scream as the rocks separate your [skin] from the rest of your body. Buried and crushed beneath the stone, your journey comes to an end.\n\n");
			//[GAME OVER]
			EventParser.gameOver();
		}
		public function defeatedByQuatroElementalBoss():void {
			clearOutput();
			outputText("You collapse, too wounded to continue fighting. The elemental stops, considering your fallen form for a moment. Out of the corner of your eye, you can see the creature approaching, the heat building. Limply, you try to move, but you're barely able to roll over before it reaches you. Wordlessly, it reaches down, grabbing you by the neck and lifting you into the air. It takes four limbs, clamping down on one of yours. Your flesh burns, charring black where it touches you. After a few seconds, your limbs fall limp, unresponsive to your commands. Once your limbs stop moving, it makes a smoky growl, two smaller limbs grabbing your chest as it pins you to the floor. ");
			if (player.statusEffectv1(StatusEffects.RivereDungeonIB) == 3) outputText("Flames");
			if (player.statusEffectv4(StatusEffects.RivereDungeonIB) == 3) outputText("Magma");
			if (player.statusEffectv2(StatusEffects.RivereDungeonIB) == 3) outputText("Magma and steam");
			if (player.statusEffectv3(StatusEffects.RivereDungeonIB) == 3) outputText("Magma, steam and razor sharp air currents");
			outputText(" that are covering them starts to slowly whirl around you, closing in. It starts as little jabs of contact, bursts of heat and pain, but steadily builds, each strike lasting longer, doing more damage than the one before. Each piece drags slowly across you, and with each groan, each twitch of pain, the elemental seems to enjoy it more. Your groans grow, becoming small cries of pain, then yelps as the heat builds, charring your [skin]. You struggle, but each time you try to get away, your [legs] are hit with a black flame, throwing you down once more. Your agonized cries fading to whimpers, black creeps up your vision as you struggle to stay awake. The pain seems to dull, but you can smell your flesh burning...You know it's over. Exhaling a ragged breath, you close your eyes for the last time.\n\n");
			//[GAME OVER]
			EventParser.gameOver();
		}
		public function defeatFireElementalSubBoss():void {
			clearOutput();
			outputText("The Ifrit gives you a blank stare, as if deciding her next action. As she stands silently, the flames around her body crackle with embers, her entire form shining brightly like a dying star. You're forced to avert your eyes from the searing white light, eyes burning from even a brief look.\n\n");
			outputText("The light quickly fades as you turn back to where the Ifrit once stood. The only thing that remains is a reddish core, lying dormant on the ground.\n\n<b>You have gained Key Item: Fire Ifrit Core</b>\n\n");
			player.createKeyItem("Fire Ifrit Core", 0, 0, 0, 0);
			player.addStatusValue(StatusEffects.RivereDungeonIB, 1, 1);
			flags[kFLAGS.RIVER_DUNGEON_FLOORS_PROGRESS]++;
			cleanupAfterCombat();
			doNext(playerMenu);
		}
		public function defeatWaterElementalSubBoss():void {
			clearOutput();
			outputText("The Undine stops moving, holding its place like a body of undisturbed water. Suddenly, without any signs it the body loses shape, the fluid spills onto the ground in a small puddle.\n\n");
			outputText("You notice something lying dormantly within the small pool of water. You cautiously approach to retrieve the blue sphere.\n\n<b>You have gained Key Item: Water Undine Core</b>\n\n");
			player.createKeyItem("Water Undine Core", 0, 0, 0, 0);
			player.addStatusValue(StatusEffects.RivereDungeonIB, 2, 1);
			flags[kFLAGS.RIVER_DUNGEON_FLOORS_PROGRESS]++;
			cleanupAfterCombat();
			doNext(playerMenu);
		}
		public function defeatAirElementalSubBoss():void {
			clearOutput();
			outputText("The Sylph pauses in its tracks. Without warning, it suddenly shoots a strong gust of wind toward you. You reflexively brace yourself for the attack but the wind dissipates before reaching you.\n\n");
			outputText("You look toward where the air elemental used to be, now nothing but a small, dormant sphere suspended in the air. It slowly descends to the ground as a feather would before you decide to inspect it.\n\n<b>You have gained Key Item: Air Sylph Core</b>\n\n");
			player.createKeyItem("Air Sylph Core", 0, 0, 0, 0);
			player.addStatusValue(StatusEffects.RivereDungeonIB, 3, 1);
			flags[kFLAGS.RIVER_DUNGEON_FLOORS_PROGRESS]++;
			cleanupAfterCombat();
			doNext(playerMenu);
		}
		public function defeatEarthElementalSubBoss():void {
			clearOutput();
			outputText("The Golem stands for a moment as a low rumbling sound enemates from it. Quickly, stones begin sloughing off its body, one by one. As quickly as it started, the humanoid form is lost to a small mound of rubble.\n\n");
			outputText("A single sphere sticks out from the top of the pile of rocks. It lies dormantly before you before you as you inspect it.\n\n<b>You have gained Key Item: Earth Golem Core</b>\n\n");
			player.createKeyItem("Earth Golem Core", 0, 0, 0, 0);
			player.addStatusValue(StatusEffects.RivereDungeonIB, 4, 1);
			flags[kFLAGS.RIVER_DUNGEON_FLOORS_PROGRESS]++;
			cleanupAfterCombat();
			doNext(playerMenu);
		}
		public function defeatQuatroElementalBoss():void {
			clearOutput();
			outputText("The revenant collapses as all the elements it's gained die out. The rubble begins slowly sinking into the ground. The voices ring as sparks of multicolored embers, each resembling one of the four elements it aligned with fly out, <i>\"The elements will rise again.\"</i>\n\n");
			outputText("As the sparks fade, all that remains is an empty shell, cold and lifeless. You inspect the elemental carefully, but somehow you know nothing will come from it this time. It's apparently bare now. Though, you can't say for sure if you won't be meeting something like it again later.\n\n");
			outputText("As you begin to take your leave, a sudden glow illuminates within the rubble, pulsating gently. Carefully, you draw closer, moving aside the debris to reveal a small, glowing heart. It pulses gently within your grasp, warm, almost alive.\n\n<b>You have gained Key Item: Flame Heart</b>\n\n");
			player.addStatusValue(StatusEffects.RivereDungeonIB, 3, 1);
			player.createKeyItem("Flame Heart", 0, 0, 0, 0);
			flags[kFLAGS.RIVER_DUNGEON_FLOORS_PROGRESS]++;
			cleanupAfterCombat();
			doNext(playerMenu);
		}
		
		private function encountersRuletteC():void {
			if (encountersRulette()) {
				var reset:Number = 10;
				reset -= player.statusEffectv1(StatusEffects.RiverDungeonA);
				player.addStatusValue(StatusEffects.RiverDungeonA, 1, reset);
				player.createStatusEffect(StatusEffects.ThereCouldBeOnlyOne, 0, 0, 0, 0);
				var choice:Number = rand(5);
				if (choice == 0) {
					//spriteSelect(SpriteDb.s_green_slime);
					outputText("A soft shuffling sound catches your attention and you turn around, spotting a small cluster of ice sliding towards you!  Realizing it's been spotted, the elemental's body crystalises into a humanoid form, raising crude arms ending with sharp icicle blades, stabbing towards you.");
					flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] = rand(4);
					startCombat(new IceElemental(), true);
				}
				if (choice == 1) {
					//spriteSelect(SpriteDb.s_green_slime);
					outputText("A soft shuffling sound catches your attention You turn around, spotting a small ball of darkness rushing towards you!  Realizing it's been spotted, the elemental's body changes, growing arms and legs. The now humanoid shadow attacks!");
					flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] = rand(4);
					startCombat(new DarknessElemental(), true);
				}
				if (choice == 2) {
					//spriteSelect(SpriteDb.s_green_slime);
					outputText("A soft shuffling sound catches your attention and you turn around, spotting a small ball of lighting rushing towards you!  Realizing it's been spotted, the elemental's body sparks, glowing tendrils of lightning forming arms and legs. It advances on its new limbs, ready to attack!");
					flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] = rand(4);
					startCombat(new LightningElemental(), true);
				}
				if (choice == 3) {
					//spriteSelect(SpriteDb.s_green_slime);
					outputText("Hearing a thunderous roar, you ready yourself for a fight. A massive hulking creature barrels around the corner and sets its gaze on you, its clawed hands and feet launching its body over the narrow corridors with ease as you stare the beast down. The white blur of an ice yeti attacks you!");
					startCombat(new Yeti(), true);
				}
				if (choice == 4) {
					spriteSelect(SpriteDb.s_electra);
					outputText("As you wander the dungeon you hear the sound of echoing thunder. Turning around you see a single girl with animalistic features running towards you. Sparks fly from her eyes, and she grins, baring sharp white teeth.\n\n");
					outputText("\"<i>You will be my lightning rod!!!!</i>\"");
					outputText("\n\nYou are under attack by a Raiju!");
					camp.codex.unlockEntry(kFLAGS.CODEX_ENTRY_RAIJU);
					startCombat(new Electra(), true);
				}
				//doNext(playerMenu);
			}
			else player.addStatusValue(StatusEffects.RiverDungeonA, 1, 10);
		}
		private function encountersRuletteCDarkness():void {
			if (encountersRulette()) {
				var reset:Number = 10;
				reset -= player.statusEffectv1(StatusEffects.RiverDungeonA);
				player.addStatusValue(StatusEffects.RiverDungeonA, 1, reset);
				player.createStatusEffect(StatusEffects.ThereCouldBeOnlyOne, 0, 0, 0, 0);
				//spriteSelect(SpriteDb.s_green_slime);
				if (player.hasKeyItem("Key Of Darkness") >= 0 || flags[kFLAGS.RIVER_DUNGEON_FLOORS_PROGRESS] > 7) flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] = rand(4);
				else flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] = rand(5);
				if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 4) {
					outputText("A soft shuffling sound catches your attention and you turn around, spotting a large, shadowy mass rushing towards you!  When it it almost next to you it starts to morph into a copy of you, made up of an inky, black darkness. nearly nine feet tall, the creature seems to draw in light, casting a dark shadow through the hallway.");
					outputText("As you strain to see this blackened doppelganger, it lurches toward you!");
				}
				else outputText("A soft shuffling sound catches your attention and you turn around, spotting a small ball of darkness rushing towards you!  Realizing it's been spotted, the elemental's body shoots up from the ground, shadowy tendrils expanding from its inky mass. Arms and legs grown, it attacks!");
				startCombat(new DarknessElemental(), true);
				//doNext(playerMenu);
			}
			else player.addStatusValue(StatusEffects.RiverDungeonA, 1, 10);
		}
		
		public function defeatVegot():void {
			clearOutput();
			outputText("The shield of arrogance he's barricaded himself with crumbles before you as the so-called 'king' falls to his knees. Even injured, he tries to fight his way to his feet, refusing to back down.\n\n");
			outputText("\"<i>This proves <b>NOTHING!</b> I... am still the kin-</i>\" His tirade is cut short as a sharp ethereal spike pierces his torso from behind. Bits of metal drop to the floor as the spike slices through the chain holding his amulet tightly to his neck.\n\n");
			outputText("\"<i>You dare to claim yourself a king? Foolish creature. Everything you have is by an extension of what I've given to you.</i>\" A warped voice resonates from a portal that parts, still shimmering behind him. Several more spikes lash out, impaling the Raiju, tips twisting, extending and trapping the violet metal in the 'king''s flesh.\n\n");
			outputText("Vegot coughs, sputtering between his words, \"<i>No... my... my...</i>\" He reaches his hand toward his amulet but is unable to move with the spikes pinning his limbs down. As the spikes rise from his body, he is dragged with them before slowly sliding off, collapsing to the ground, and rolling toward you.\n\n");
			outputText("\"<i>Now, be an obedient puppet. You're coming with me.</i>\" The voice quickly grows impatient as the spikes morph into chains, tying around his body before dragging him into the ominous portal.\n\n");
			outputText("The portal begins to seal, not without a final word, \"<i>We will meet again, stranger...</i>\"\n\n");
			outputText("Now alone, you notice the amulet he wore is sitting on the ground. It pulsates with a gentle hum of electricity, almost mocking the drum of a heartbeat.\n\n<b>You have gained Key Item: Frost Heart</b>\n\n");
			player.createKeyItem("Frost Heart", 0, 0, 0, 0);
			flags[kFLAGS.RIVER_DUNGEON_FLOORS_PROGRESS]++;
			cleanupAfterCombat();
			doNext(playerMenu);
		}
		public function defeatedByIceElemental():void {
			clearOutput();
			outputText("Your opponent punches you a few more times, then carries you all the way back to the floor entrance. It drops you by the entrance, shivering from its icy touch.\n\n");
			dungeonLoc = DUNGEON_RIVER_FLOOR_03_ROOM_01;
			cleanupAfterCombat();
		}
		public function defeatedByLightningElemental():void {
			clearOutput();
			outputText("Your opponent punches you a few more times, then carries you all the way back to the floor entrance. It drops you by the entrance, sparks playing across your [skin], your fingers numb from the creature's touch. \n\n");
			dungeonLoc = DUNGEON_RIVER_FLOOR_03_ROOM_01;
			cleanupAfterCombat();
		}
		public function defeatedByDarknessElemental():void {
			clearOutput();
			outputText("Your opponent punches you a few more times, then carries you all the way back to the floor entrance. It drops you by the entrance. You can barely see, your eyes struggling after being handled by that blob of black darkness. You shudder, barely able to see. \n\n");
			dungeonLoc = DUNGEON_RIVER_FLOOR_03_ROOM_01;
			cleanupAfterCombat();
		}
		public function defeatedByYeti():void {
			clearOutput();
			outputText("As you fall on the ground you barely get a glimpse of the Yeti grabbing a rock and dropping it on your head. When you wake up you are back at the entrance of the dungeon. Guess this could've gone worse but now you have to do the whole thing all over again.\n\n");
			dungeonLoc = DUNGEON_RIVER_FLOOR_03_ROOM_01;
			cleanupAfterCombat();
		}
		public function defeatedByRaiju():void {
			clearOutput();
			outputText("Placeholder Bad End.\n\n");
			dungeonLoc = DUNGEON_RIVER_FLOOR_03_ROOM_01;
			cleanupAfterCombat();
		}
		public function defeatedByDarknessElementalSubBoss():void {
			clearOutput();
			outputText("Placeholder Bad End.\n\n");//embrace the darkness(silly - dorkness) > boss invade all pc orfices and then rips apart from inside out or just devour from inside
			//[GAME OVER]
			EventParser.gameOver();
		}
		public function defeatedByVegot():void {
			clearOutput();
			outputText("You collapse, your wounds burdening your body as your will to fight falters. Knowing his victory, Vegot slowly strides toward you, \"<i>I made a promise, one that I intend to keep... Now, it's time to uphold that.</i>\" After he speaks, he bends down, touching your forehead.\n\n");
			outputText("You shout in pain as a cold current of electricity invades your body as it circulates through you. A trio of icy horns marks along your forehead.\n\n");
			outputText("\"<i>And now you're mine.</i>\"\n\n");
			outputText("As if on queue, a portal opens behind him. Vegot reflexively knees, facing the opening before speaking respectfully, \"<i>My liege, you're here. What are your orders?</i>\"\n\n");
			outputText("A warped voice resonates out of the shimmering barrier, \"<i>It seems you've obtained a new puppet. Bring it to me.</i>\"\n\n");
			outputText("The portal expands slowly as Vegot hoists you in his arms effortlessly. You watch, unable to move as the portal expands large enough for you to pass through, with you in your new master's arms.\n\n");
			outputText("On the other side is a throne room, albeit with significantly more grandeur than the one Vegot had in his icy palace. At the center, many skeletons, bloodsuckers and spectral beings guard it. A tall skeleton adorned in long, extravagant robes stares into you, his empty eye sockets glow with a purple hue.\n\n");
			outputText("The skeleton speaks with a warped voice, \"<i>An interesting find, this one may prove useful. I shall compensate you later.</i>\"\n\n");
			outputText("Vegot kneels, lying you on the ground.\n\n");
			outputText("\"<i>You may return to your domain, notify me at once the moment you find another specimen for me.</i>\"\n\n");
			outputText("\"<i>As you command, my Liege,</i>\" Vegot responds yieldingly. He stands up, returning through the portal you entered.\n\n");
			outputText("The skeleton shifts its attention toward you again, \"<i>Oh, you're still conscious? Sentience intact? Hmmm, no, no, no. That won't do. That won't do at all.</i>\"\n\n");
			outputText("Everything goes black, like a candle snuffed out from an overpowering blizzard.\n\n");
			//[GAME OVER]
			EventParser.gameOver();
		}
		public function defeatDarknessElementalSubBoss():void {
			clearOutput();
			outputText("Beaten, the Darkness Elemental slowly begins to disperse. The only thing that remains is a piece of a black object lying on the ground.\n\n");
			if (player.hasKeyItem("Key Of Darkness (2/3)") >= 0) {
				player.removeKeyItem("Key Of Darkness (2/3)");
				player.createKeyItem("Key Of Darkness", 0, 0, 0, 0);
				outputText("Once again kneeling you take out the incomplete key, whcih as you expected merge with the piece on the ground. Now it looks like a proper key. It's cracked, but made of an ebony-black metal. \n\n<b>You have gained Key Item: Key Of Darkness</b>");
			}
			else if (player.hasKeyItem("Key Of Darkness (1/3)") >= 0) {
				player.removeKeyItem("Key Of Darkness (1/3)");
				player.createKeyItem("Key Of Darkness (2/3)", 0, 0, 0, 0);
				outputText("As you kneel to pick it up, it flashes with black and purple light, vanishing. Your pocket feels a bit heavier, and you take out your key of darkness. It's bigger than before, and you nod, putting it back away.\n\n<b>You have gained Key Item: Key Of Darkness (2/3)</b>");
			}
			else {
				player.createKeyItem("Key Of Darkness (1/3)", 0, 0, 0, 0);
				outputText("<b>You have gained Key Item: Key Of Darkness (1/3)</b>");
			}
			outputText("\n\n");
			cleanupAfterCombat();
			doNext(playerMenu);
		}
		
		private function encountersRuletteD():void {
			if (encountersRulette()) {
				var reset:Number = 10;
				reset -= player.statusEffectv1(StatusEffects.RiverDungeonA);
				player.addStatusValue(StatusEffects.RiverDungeonA, 1, reset);
				player.createStatusEffect(StatusEffects.ThereCouldBeOnlyOne, 0, 0, 0, 0);
				var choice:Number = rand(2);
				if (choice == 0) {
					//spriteSelect(SpriteDb.s_green_slime);
					outputText("A soft shuffling splat catches your attention and you turn around, spotting an amorphous red mass sliding towards you!  Realizing it's been spotted, the ooze's mass surges upwards into a humanoid form with thick arms and wide shoulders.  Then you notice it's covered with nearly blending with rest of it skin purple glowing veins.  The beast surges forward to attack!");
					flags[kFLAGS.RED_OOZE_SUBTYPE] = 1;
					startCombat(new RedOoze(), true);
				}
				if (choice == 1) {
					//spriteSelect(SpriteDb.s_green_slime);
					outputText("A soft shuffling splat catches your attention and you turn around, spotting an amorphous red mass sliding towards you!  Realizing it's been spotted, the ooze's mass surges upwards into a humanoid form with thick arms and wide shoulders.  Then you notice it's covered with nearly blending with rest of it skin purple glowing veins.  The beast surges forward to attack!");
					flags[kFLAGS.RED_OOZE_SUBTYPE] = 1;
					startCombat(new RedOoze(), true);
				}/*
				if (choice == 2) {
					//spriteSelect(SpriteDb.s_green_slime);
					outputText("A soft shuffling splat catches your attention and you turn around, spotting an amorphous red mass sliding towards you!  Realizing it's been spotted, the ooze's mass surges upwards into a humanoid form with thick arms and wide shoulders.  The beast surges forward to attack!");
					startCombat(new RedOoze(), true);
				}
				if (choice == 3) {
					//spriteSelect(SpriteDb.s_green_slime);
					outputText("A soft shuffling splat catches your attention and you turn around, spotting an amorphous red mass sliding towards you!  Realizing it's been spotted, the ooze's mass surges upwards into a humanoid form with thick arms and wide shoulders.  The beast surges forward to attack!");
					startCombat(new RedOoze(), true);
				}
				if (choice == 4) {
					//spriteSelect(SpriteDb.s_electra);
					outputText("A soft shuffling splat catches your attention and you turn around, spotting an amorphous red mass sliding towards you!  Realizing it's been spotted, the ooze's mass surges upwards into a humanoid form with thick arms and wide shoulders.  The beast surges forward to attack!");
					startCombat(new RedOoze(), true);
				}
				if (choice == 5) {
					//spriteSelect(SpriteDb.s_electra);
					outputText("A soft shuffling splat catches your attention and you turn around, spotting an amorphous red mass sliding towards you!  Realizing it's been spotted, the ooze's mass surges upwards into a humanoid form with thick arms and wide shoulders.  The beast surges forward to attack!");
					startCombat(new RedOoze(), true);
				}*/
				//doNext(playerMenu);
			}
			else player.addStatusValue(StatusEffects.RiverDungeonA, 1, 10);
		}
		public function defeatedByRedMistOoze():void {
			clearOutput();
			outputText("Your opponent, done toying with your body, carries you all the way back to the dungeon entrance. They toss you onto the ground outside. Guess it's back to square one.\n\n");
			dungeonLoc = DUNGEON_RIVER_FLOOR_04_ROOM_07;
			cleanupAfterCombat();
		}

		//Rooms
		public function roomA01():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_01_ROOM_01;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u>Entrance</u></b>\n");
			outputText("You run into an old campsite. By the looks of it an adventurer must have rested there, through the fire's long dead. It died a month ago, from what you can tell. What a peculiar fire too, just who the hell would grab bones, set them in a stone circle and then impale a skull on a rusty longsword before setting fire to it?");
			dungeons.setDungeonButtonsRD(null, null, null, roomA02);
			addButton(0, "Teleport C.", teleportCircleFloor1);
			if (flags[kFLAGS.NEISA_AFFECTION] < 10 && flags[kFLAGS.NEISA_FOLLOWER] < 4) addButtonDisabled(10, "Up", "You would leave now but you have yet to find enough to pay Neisa.");
			else addButton(10, "Up", exitDungeon);
		}
		public function roomA02():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_01_ROOM_02;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Small glittering bones covers the rocky ground ahead of you. Likely those are the remains of some ancient monsters that used to live on Mareth a long time ago.");
			dungeons.setDungeonButtonsRD(roomA03, null, roomA01, null);
		}
		public function roomA03():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_01_ROOM_03;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("You spot a small lizard lazily resting on the cold hard stone above you. The air is humid and cold. On the walls are old graffiti likely left by ancient civilisations of animal morphs.");
			dungeons.setDungeonButtonsRD(roomA08, roomA02, null, roomA04);
			if (flags[kFLAGS.NEISA_AFFECTION] < 5 && flags[kFLAGS.NEISA_FOLLOWER] < 4) tresureRoom1A();
		}
		public function roomA04():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_01_ROOM_04;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("You can hear water running on a nearby wall from a fissure in the rock. You can only hope this thing won’t break open and flood the place over while you are deeper in.");
			dungeons.setDungeonButtonsRD(null, null, roomA03, roomA05);
		}
		public function roomA05():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_01_ROOM_05;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Small glittering bones covers the rocky ground ahead of you. Likely those are the remains of some ancient monsters that used to live on Mareth a long time ago.");
			dungeons.setDungeonButtonsRD(roomA16, roomA06, roomA04, null);
		}
		public function roomA06():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_01_ROOM_06;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Small Bats fly out as you walk by above your head hangs some large stalactites. It would be most unfortunate if one of these was to randomly fall down and run you through.");
			dungeons.setDungeonButtonsRD(roomA05, null, null, null);
			if (flags[kFLAGS.RIVER_DUNGEON_FLOORS_PROGRESS] > 1) addButton(11, "Down", roomB01);
			else addButtonDisabled(11, "Down", "You still need to beat the guardians of this floor to descend into lower strata of the dungeon.");
		}
		public function roomA07():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_01_ROOM_07;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("You run into an old campsite. by the looks of it an adventurer must have rested there, through the fire looks like it died a month ago. What a peculiar fire too, just who the hell would grab bones, set them in a stone circle and then impale a skull on a rusty longsword before setting fire to it?");
			dungeons.setDungeonButtonsRD(roomA11, null, null, roomA08);
		}
		public function roomA08():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_01_ROOM_08;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Small Bats fly out as you walk by above your head hangs some large stalactites. It would be most unfortunate if one of these was to randomly fall down and run you through.");
			dungeons.setDungeonButtonsRD(null, roomA03, roomA07, roomA09);
		}
		public function roomA09():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_01_ROOM_09;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("You can hear running water above you, the river is likely flowing right above your head. Guess explosive magic right now is ill advised.");
			dungeons.setDungeonButtonsRD(roomA10, null, roomA08, null);
		}
		public function roomA10():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_01_ROOM_10;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("You spot a small lizard lazily resting on the cold hard stone above you. The air is humid and cold. On the walls are old graffiti, likely left by animal-morph ancestors.");
			dungeons.setDungeonButtonsRD(null, roomA09, null, null);
			if (flags[kFLAGS.NEISA_AFFECTION] == 5 && flags[kFLAGS.NEISA_FOLLOWER] < 4) tresureRoom2A();
		}
		public function roomA11():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_01_ROOM_11;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("The walls around you are covered with ancient lichen. You can see a fissure from which small droplets of water fall. The water splashes, flowing deeper in the dungeon.");
			dungeons.setDungeonButtonsRD(roomA12, roomA07, null, null);
		}
		public function roomA12():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_01_ROOM_12;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Small glowing mushrooms cover the walls of the room you move through, just enough for you to see a short distance ahead.");
			dungeons.setDungeonButtonsRD(null, roomA11, roomA13, null);
		}
		public function roomA13():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_01_ROOM_13;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("A small underground lake has formed in the massive room you move by. You tread a safe distance away from the dark waters, wary of what may lurk in its depths.");
			dungeons.setDungeonButtonsRD(roomA15, null, roomA14, roomA12);
		}
		public function roomA14():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_01_ROOM_14;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("The walls around you are covered with ancient lichen. You can see a fissure from which small droplets of water fall down, rivulets flowing deeper into the dungeon.");
			dungeons.setDungeonButtonsRD(null, null, null, roomA13);
		}
		public function roomA15():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_01_ROOM_15;
			clearOutput();
			if (flags[kFLAGS.AETHER_SINISTER_EVO] < 1) {
				flags[kFLAGS.AETHER_SINISTER_EVO] = 0.5;
				if (!player.hasStatusEffect(StatusEffects.ThereCouldBeOnlyOne)) player.createStatusEffect(StatusEffects.ThereCouldBeOnlyOne, 0, 0, 0, 0);
				outputText("As you peek into a room, a golem shakes, emerging from the shadows. Unlike most, this golem wears a gauntlet on its hand, the entire side of its body covered in fleshy tendrils. You ready your [weapon] for a fight!");
				startCombat(new GolemDummyImproved(), true);
			}
			else if (!player.hasStatusEffect(StatusEffects.ThereCouldBeOnlyOne)) encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("You find some old bones on the ground, likely those of a beast that died here. To your alarm ,these bones appear to be cow-sized, the bones themselves chewed on.");
			dungeons.setDungeonButtonsRD(null, roomA13, null, null);
		}
		public function roomA16():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_01_ROOM_16;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("You can hear running water above you, the river is likely flowing just above your head. An explosion could bring the entire river down on top of you!");
			dungeons.setDungeonButtonsRD(roomA17, roomA05, null, null);
		}
		public function roomA17():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_01_ROOM_17;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Small glowing mushrooms cover the walls of the room you move through, just enough for you to see a short distance ahead.");
			dungeons.setDungeonButtonsRD(null, roomA16, null, roomA18);
		}
		public function roomA18():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_01_ROOM_18;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("A small underground lake has formed in the massive room you move by. You tread a safe distance away from the dark waters, wary of what may lurk in its depths.");
			dungeons.setDungeonButtonsRD(roomA20, null, roomA17, roomA19);
		}
		public function roomA19():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_01_ROOM_19;
			clearOutput();
			encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("You can hear water running on a nearby wall from a fissure in the rock. You can only hope this thing won’t break open and flood the place over.");
			dungeons.setDungeonButtonsRD(null, null, roomA18, null);
		}
		public function roomA20():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_01_ROOM_20;
			clearOutput();
			if (flags[kFLAGS.AETHER_DEXTER_EVO] < 1) {
				flags[kFLAGS.AETHER_DEXTER_EVO] = 0.5;
				if (!player.hasStatusEffect(StatusEffects.ThereCouldBeOnlyOne)) player.createStatusEffect(StatusEffects.ThereCouldBeOnlyOne, 0, 0, 0, 0);
				outputText("As you peek into a room, a golem shakes, emerging from the shadows. Unlike most, this golem wears a gauntlet on its hand, the entire side of its body covered in fleshy tendrils. You ready your [weapon] for a fight!");
				startCombat(new GolemDummyImproved(), true);
			}
			else if (!player.hasStatusEffect(StatusEffects.ThereCouldBeOnlyOne)) encountersRuletteA();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("You find some old bones on the ground likely those of a beast that died here. The bones are cow-sized, at least, and clearly weren't from some docile herbivore, either.");
			dungeons.setDungeonButtonsRD(null, roomA18, null, null);
		}
		
		public function roomB01():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_02_ROOM_01;
			clearOutput();
			encountersRuletteB();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Your vision is obscured by thick fog. You instinctively tense as the echoes of footsteps bounce off the walls. Enemies could be right next to you, and you wouldn't know unless you bump into one. You break into a light sweat, or is that the moisture condescending onto your [skin]?");
			dungeons.setDungeonButtonsRD(roomB02, null, null, null);
			addButton(0, "Teleport C.", teleportCircleFloor2);
			addButton(11, "Up", roomA06);
		}
		public function roomB02():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_02_ROOM_02;
			clearOutput();
			encountersRuletteB();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Roiling Mist covers your surroundings, making you unable to see anything past a few feet.");
			dungeons.setDungeonButtonsRD(roomB16, roomB01, null, roomB06);
		}
		public function roomB03():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_02_ROOM_03;
			clearOutput();
			encountersRuletteB();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Roiling Mist covers your surroundings, making you unable to see anything past a few feet.");
			dungeons.setDungeonButtonsRD(roomB04, null, roomB25, null);
		}
		public function roomB04():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_02_ROOM_04;
			clearOutput();
			encountersRuletteB();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Your vision is obscured by thick fog. You instinctively tense as the echoes of footsteps bounce off the walls. Enemies could be right next to you, and you wouldn't know unless you bump into one. You break into a light sweat, or is that the moisture condescending onto your [skin]?");
			dungeons.setDungeonButtonsRD(roomB05, roomB03, null, roomB07);
		}
		public function roomB05():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_02_ROOM_05;
			clearOutput();
			encountersRuletteB();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Roiling Mist covers your surroundings, making you unable to see anything past a few feet.");
			dungeons.setDungeonButtonsRD(roomB06, roomB04, null, roomB08);
		}
		public function roomB06():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_02_ROOM_06;
			clearOutput();
			encountersRuletteB();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Roiling Mist covers your surroundings, making you unable to see anything past a few feet.");
			dungeons.setDungeonButtonsRD(null, roomB05, roomB02, roomB09);
		}
		public function roomB07():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_02_ROOM_07;
			clearOutput();
			encountersRuletteB();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Your vision is obscured by thick fog. You instinctively tense as the echoes of footsteps bounce off the walls. Enemies could be right next to you, and you wouldn't know unless you bump into one. You break into a light sweat, or is that the moisture condescending onto your [skin]?");
			dungeons.setDungeonButtonsRD(roomB08, null, roomB04, roomB10);
		}
		public function roomB08():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_02_ROOM_08;
			clearOutput();//boss room
			if (player.statusEffectv1(StatusEffects.RivereDungeonIB) == 1 && player.statusEffectv2(StatusEffects.RivereDungeonIB) == 1 && player.statusEffectv3(StatusEffects.RivereDungeonIB) == 1 && player.statusEffectv4(StatusEffects.RivereDungeonIB) == 1) {
				player.addStatusValue(StatusEffects.RivereDungeonIB, 1, 1);
				player.addStatusValue(StatusEffects.RivereDungeonIB, 2, 1);
				player.addStatusValue(StatusEffects.RivereDungeonIB, 3, 1);
				player.addStatusValue(StatusEffects.RivereDungeonIB, 4, 1);
				if (!player.hasStatusEffect(StatusEffects.ThereCouldBeOnlyOne)) player.createStatusEffect(StatusEffects.ThereCouldBeOnlyOne, 0, 0, 0, 0);
				outputText("As you step into the room, four incense burners suddenly erupt with a raucous of flames as the faint smell of incense fills the room. Your ears perk at the distant sound of wind within the tunnels. An echo follows with a gentle stream of water steadily growing closer.\n\n");
				outputText("Your balance shifts as the ground quakes beneath you. You reflexively step back as the ground splits before you as a rift opens. "+(silly() ? "Is that boss music?":"")+" From the darkness of the unsealed rift, a hand emerges before pulling itself out of the crevice.\n\n");
				outputText("The creature hovers ominously. Its ellipsoid torso is accompanied by two short arms, thin with visible segments, tapering into a single point. From its shoulders sprout two additional pairs of arms, twice the size of the smaller one as it ends in insect-like claws.\n\n");
				outputText("Tapering down from its torso is a tail much longer than the body, slowly dangling in the still air. The thing levitates with its lack of legs as you quickly examine it. Its eyes begin to open; the four of them aligning into a diamond shape. The creature stares at you with a distant glare, as if it hasn't realized its purpose in this reality.\n\n");
				outputText("Embers from the braziers slowly crawl toward the rift as the fissure begins to seal.\n\n");
				outputText("The flames begin to merge with the being, setting its arms alight before it hurls itself toward you.\n\n");
				outputText("You brace yourself, it's a fight!\n\n");
				startCombat(new QuatroElementalBoss(), true);
			}
			else if (!player.hasStatusEffect(StatusEffects.ThereCouldBeOnlyOne)) encountersRuletteB();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Roiling Mist covers your surroundings, making you unable to see anything past a few feet.");
			outputText("\n\nIn four corners of this area are incense burners.\n\nNorthwest one ");
			if (player.hasStatusEffect(StatusEffects.RivereDungeonIB) && (player.statusEffectv1(StatusEffects.RivereDungeonIB) == 1 || player.statusEffectv1(StatusEffects.RivereDungeonIB) == 3)) outputText("burning with a red flame");
			else outputText("is extinguished");
			outputText(".\nNortheast one ");
			if (player.hasStatusEffect(StatusEffects.RivereDungeonIB) && (player.statusEffectv2(StatusEffects.RivereDungeonIB) == 1 || player.statusEffectv2(StatusEffects.RivereDungeonIB) == 3)) outputText("burning with a blue flame");
			else outputText("is extinguished");
			outputText(".\nSoutheast one ");
			if (player.hasStatusEffect(StatusEffects.RivereDungeonIB) && (player.statusEffectv3(StatusEffects.RivereDungeonIB) == 1 || player.statusEffectv3(StatusEffects.RivereDungeonIB) == 3)) outputText("burning with a white flame");
			else outputText("is extinguished");
			outputText(".\nSouthwest one ");
			if (player.hasStatusEffect(StatusEffects.RivereDungeonIB) && (player.statusEffectv4(StatusEffects.RivereDungeonIB) == 1 || player.statusEffectv4(StatusEffects.RivereDungeonIB) == 3)) outputText("burning with a brown flame");
			else outputText("is extinguished");
			outputText(".");
			dungeons.setDungeonButtonsRD(roomB09, roomB07, roomB05, roomB11);
		}
		public function roomB09():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_02_ROOM_09;
			clearOutput();
			encountersRuletteB();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Roiling Mist covers your surroundings, making you unable to see anything past a few feet.");
			dungeons.setDungeonButtonsRD(null, roomB08, roomB06, roomB12);
		}
		public function roomB10():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_02_ROOM_10;
			clearOutput();
			encountersRuletteB();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Your vision is obscured by thick fog. You instinctively tense as the echoes of footsteps bounce off the walls. Enemies could be right next to you, and you wouldn't know unless you bump into one. You break into a light sweat, or is that the moisture condescending onto your [skin]?");
			dungeons.setDungeonButtonsRD(roomB11, null, roomB07, roomB14);
		}
		public function roomB11():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_02_ROOM_11;
			clearOutput();
			encountersRuletteB();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Roiling Mist covers your surroundings, making you unable to see anything past a few feet.");
			dungeons.setDungeonButtonsRD(roomB12, roomB10, roomB08, null);
		}
		public function roomB12():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_02_ROOM_12;
			clearOutput();
			encountersRuletteB();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Your vision is obscured by thick fog. You instinctively tense as the echoes of footsteps bounce off the walls. Enemies could be right next to you, and you wouldn't know unless you bump into one. You break into a light sweat, or is that the moisture condescending onto your [skin]?");
			dungeons.setDungeonButtonsRD(roomB13, roomB11, roomB09, null);
		}
		public function roomB13():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_02_ROOM_13;
			clearOutput();
			encountersRuletteB();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Roiling Mist covers your surroundings, making you unable to see anything past a few feet.");
			dungeons.setDungeonButtonsRD(null, roomB12, null, roomB19);
		}
		public function roomB14():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_02_ROOM_14;
			clearOutput();
			encountersRuletteB();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Roiling Mist covers your surroundings, making you unable to see anything past a few feet.");
			dungeons.setDungeonButtonsRD(roomB15, roomB22, roomB10, null);
		}
		public function roomB15():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_02_ROOM_15;
			clearOutput();
			encountersRuletteB();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Your vision is obscured by thick fog. You instinctively tense as the echoes of footsteps bounce off the walls. Enemies could be right next to you, and you wouldn't know unless you bump into one. You break into a light sweat, or is that the moisture condescending onto your [skin]?");
			dungeons.setDungeonButtonsRD(null, roomB14, null, null);
			if (flags[kFLAGS.RIVER_DUNGEON_FLOORS_PROGRESS] > 6) addButton(6, "Down", roomC01);
			else addButtonDisabled(6, "Down", "You still need to beat the guardian of this floor to descend further into the dungeon");
		}
		public function roomB16():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_02_ROOM_16;
			clearOutput();
			encountersRuletteBFire();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("As you enter the new area, your breaths grow shallow. Heat washes over you as the sides of the room glow with an orange hue. \n\nPeriodically, you hear a loud hissing as steam rises in the air. Coughing, you continue through the tunnels, wary of potential dangers.");
			dungeons.setDungeonButtonsRD(null, roomB02, roomB17, null);
		}
		public function roomB17():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_02_ROOM_17;
			clearOutput();
			encountersRuletteBFire();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("As you enter the new area, your breaths grow shallow. Heat washes over you as the sides of the room glow with an orange hue. \n\nPeriodically, you hear a loud hissing as steam rises in the air. Coughing, you continue through the tunnels, wary of potential dangers.");
			dungeons.setDungeonButtonsRD(null, roomB18, null, roomB16);
		}
		public function roomB18():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_02_ROOM_18;
			clearOutput();
			if (player.statusEffectv1(StatusEffects.RivereDungeonIB) == 0) {
				outputText("A crackling sound emanates from this distance. You turn to face a large ball of fire rushing toward you. The ball slows, noticing you've seen it.");
				outputText("It morphs into nine-foot-tall ifrit with a clear feminine shape.  Its entire body is alight as it attacks. Prepare to fight!");
				if (!player.hasStatusEffect(StatusEffects.ThereCouldBeOnlyOne)) player.createStatusEffect(StatusEffects.ThereCouldBeOnlyOne, 0, 0, 0, 0);
				flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] = 4;
				startCombat(new FireElemental(), true);
			}
			else if (!player.hasStatusEffect(StatusEffects.ThereCouldBeOnlyOne)) encountersRuletteBFire();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("As you enter the new area, your breaths grow shallow as you have difficulty breathing in new air. Heat washes over you as the sides of the room glow with an orange hue. \n\nPeriodically, you hear a loud hissing as steam rises in the air. Coughing, you continue through the tunnels, wary of potential dangers.");
			dungeons.setDungeonButtonsRD(roomB17, null, null, null);
		}
		public function roomB19():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_02_ROOM_19;
			clearOutput();
			encountersRuletteBWater();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("As you step into the next room, your balance is nearly thrown off as you can feel yourself sinking slightly with each second of movement. You look down, noticing the thick mud beneath you. Best not to stand still too long lest you get stuck.\n\nThe room is much like the densest bog you've ever traveled in. The mist is so thick, you can hardly see more than a few feet in front of you. ");
			outputText("You tread gingerly through the dank room, making sure not to step in anything you wouldn't want to.");
			dungeons.setDungeonButtonsRD(roomB20, null, roomB13, null);
		}
		public function roomB20():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_02_ROOM_20;
			clearOutput();
			encountersRuletteBWater();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("As you step into the next room, your balance is nearly thrown off as you can feel yourself sinking slightly with each second of movement. Best not to stand still too long lest you get stuck.\n\nThe room is much like the densest bog you've ever traveled in. The mist is so thick, you can hardly see more than a few feet in front of you. ");
			outputText("You tread gingerly through the dank room, making sure not to step in anything you wouldn't want to.");
			dungeons.setDungeonButtonsRD(null, roomB19, roomB21, null);
		}
		public function roomB21():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_02_ROOM_21;
			clearOutput();
			if (player.statusEffectv2(StatusEffects.RivereDungeonIB) == 0) {
				outputText("A soft warble emanates from nearby; it sounds much like rolling waves, quickly approaching. You notice a large sphere of water rolling toward you.  It bounces, the ball jiggling with each hop before it quickly begins to take form.  ");
				outputText("The body of water quickly coalesces into a humanoid form with clear masculine features.  The Undine focuses its attention on you, still dripping with water, before it shifts aggressively, prepared to attack. It's a fight!");
				if (!player.hasStatusEffect(StatusEffects.ThereCouldBeOnlyOne)) player.createStatusEffect(StatusEffects.ThereCouldBeOnlyOne, 0, 0, 0, 0);
				flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] = 4;
				startCombat(new WaterElemental(), true);
			}
			else if (!player.hasStatusEffect(StatusEffects.ThereCouldBeOnlyOne)) encountersRuletteBWater();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("As you step into the next room, your balance is nearly thrown off as you can feel yourself sinking slightly with each second of movement. Best not to stand still too long lest you get stuck.\n\nThe room is much like the densest bog you've ever traveled in. The mist is so thick, you can hardly see more than a few feet in front of you. ");
			outputText("You tread gingerly through the dank room, making sure not to step in anything you wouldn't want to.");
			dungeons.setDungeonButtonsRD(null, null, null, roomB20);
		}
		public function roomB22():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_02_ROOM_22;
			clearOutput();
			encountersRuletteBAir();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("A dense blanket of dark clouds cover the ceiling of the room, not unlike the storms you remember back home in Ignam. Thunder and lightning crash throughout the room at random, accompanied by forceful gusts of wind. If you're not careful, you could be thrown off your feet or struck at any moment. ");
			outputText("Small vortexes swirl within the room, spawning at random. They briefly clear a visible path for you ahead, but you remain careful as you push forward.");
			dungeons.setDungeonButtonsRD(roomB14, null, null, roomB23);
		}
		public function roomB23():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_02_ROOM_23;
			clearOutput();
			encountersRuletteBAir();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("A dense blanket of dark clouds cover the ceiling of the room, not unlike the storms you remember back home in Ignam. Thunder and lightning crash throughout the room at random, accompanied by forceful gusts of wind. If you're not careful, you could be thrown off your feet or struck at any moment. ");
			outputText("Small vortexes swirl within the room, spawning at random. They briefly clear a visible path for you ahead, but you remain careful as you push forward.");
			dungeons.setDungeonButtonsRD(roomB24, null, roomB22, null);
		}
		public function roomB24():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_02_ROOM_24;
			clearOutput();
			if (player.statusEffectv3(StatusEffects.RivereDungeonIB) == 0) {
				outputText("A loud howl of wind is heard not far, you turn your attention to the source of the noise as you notice a tornado spinning itself toward you. The tornado is twice the size of the miniature vortexes you've seen earlier. As it draws closer, it quickly shifts into a humanoid form.  ");
				outputText("As the harsh winds die out, the sylph takes a masculine form.  Its eyes focus upon you before it darts toward you. You brace yourself for combat.");
				if (!player.hasStatusEffect(StatusEffects.ThereCouldBeOnlyOne)) player.createStatusEffect(StatusEffects.ThereCouldBeOnlyOne, 0, 0, 0, 0);
				flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] = 4;
				startCombat(new AirElemental(), true);
			}
			else if (!player.hasStatusEffect(StatusEffects.ThereCouldBeOnlyOne)) encountersRuletteBAir();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("A dense blanket of dark clouds cover the ceiling of the room, not unlike the storms you remember back home in Ignam. Thunder and lightning crash throughout the room at random, accompanied by forceful gusts of wind. If you're not careful, you could be thrown off your feet or struck at any moment. ");
			outputText("Small vortexes swirl within the room, spawning at random. They briefly clear a visible path for you ahead, but you remain careful as you push forward.");
			dungeons.setDungeonButtonsRD(null, roomB23, null, null);
		}
		public function roomB25():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_02_ROOM_25;
			clearOutput();
			encountersRuletteBEarth();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("As you tread through the sandy, desert-like area, you're constantly buffeted by swirling sand. Dust devils whirl about from the strange wind emitting from the walls. You try to shield your eyes from the rough sand, and the howling sandstorm is deafening, to the point where you can hardly hear anything else. ");
			outputText("The eerie fog of the dungeon remains, tossed about by the raging fury of disturbed sand. Treading is nearly impossible, but you persevere, mindful of each step you take.");
			dungeons.setDungeonButtonsRD(null, roomB26, null, roomB03);
		}
		public function roomB26():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_02_ROOM_26;
			clearOutput();
			encountersRuletteBEarth();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("As you tread through the sandy, desert-like area, you're constantly buffeted by swirling sand. Dust devils whirl about from the strange wind emitting from the walls. You shield your eyes from the rough sand, and the howling sandstorm is deafening, to the point where you can hardly hear anything else. ");
			outputText("The eerie fog of the dungeon remains, tossed about by the raging fury of disturbed sand. Treading is nearly impossible, but you persevere, mindful of each step you take.");
			dungeons.setDungeonButtonsRD(roomB25, null, null, roomB27);
		}
		public function roomB27():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_02_ROOM_27;
			clearOutput();
			if (player.statusEffectv4(StatusEffects.RivereDungeonIB) == 0) {
				outputText("An avalanche of rocks rumbles the ground. You glance over and notice a series of stones rolling over each other toward your direction.  It's much larger than the usual elementals.  As it approaches, the stone quickly take shape of a humanoid figure. ");
				outputText("The rocks roll over, taking on a feminine form. Its eyes focus before it raises a fist. You brace yourself, it looks like the fight is on!");
				if (!player.hasStatusEffect(StatusEffects.ThereCouldBeOnlyOne)) player.createStatusEffect(StatusEffects.ThereCouldBeOnlyOne, 0, 0, 0, 0);
				flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] = 4;
				startCombat(new EarthElemental(), true);
			}
			else if (!player.hasStatusEffect(StatusEffects.ThereCouldBeOnlyOne)) encountersRuletteBEarth();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("As you tread through the sandy, desert-like area, you're constantly buffeted by swirling sand. Dust devils whirl about from the strange wind emitting from the walls. You try to shield your eyes from the rough sand, and the howling sandstorm is deafening, to the point you can hardly hear anything else. ");
			outputText("The eerie fog of the dungeon remains, tossed about by the raging fury of disturbed sand. Treading is nearly impossible, but you persevere, mindful of each step you take.");
			dungeons.setDungeonButtonsRD(null, null, roomB26, null);
		}
		public function roomC01():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_03_ROOM_01;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Roiling Mist covers your surroundings, making you unable to see anything past a few feet.");
			dungeons.setDungeonButtonsRD(null, roomC02, null, null);
			addButton(0, "Teleport C.", teleportCircleFloor3);
			addButton(6, "Up", roomB15);
		}
		public function roomC02():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_03_ROOM_02;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Roiling Mist covers your surroundings, making you unable to see anything past a few feet.");
			dungeons.setDungeonButtonsRD(roomC01, null, roomC03, null);
		}
		public function roomC03():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_03_ROOM_03;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Roiling Mist covers your surroundings, making you unable to see anything past a few feet.");
			dungeons.setDungeonButtonsRD(null, roomC08, roomC04, roomC02);
		}
		public function roomC04():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_03_ROOM_04;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Roiling Mist covers your surroundings, making you unable to see anything past a few feet.");
			dungeons.setDungeonButtonsRD(roomC21, null, null, roomC03);
		}
		public function roomC05():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_03_ROOM_05;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Roiling Mist covers your surroundings, making you unable to see anything past a few feet.");
			dungeons.setDungeonButtonsRD(null, roomC10, roomC06, null);
		}
		public function roomC06():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_03_ROOM_06;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Roiling Mist covers your surroundings, making you unable to see anything past a few feet.");
			dungeons.setDungeonButtonsRD(null, null, roomC07, roomC05);
		}
		public function roomC07():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_03_ROOM_07;
			clearOutput();
			encountersRuletteCDarkness();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Gloomy Underground Passage</b>\n");
			outputText("An aura of doom and gloom coats the tunnel you're in with a dark atmosphere. The shadows wick about in your peripherals as if they were living creatures encroaching just outside your field of view.");
			dungeons.setDungeonButtonsRD(null, roomC11, roomC08, roomC06);
		}
		public function roomC08():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_03_ROOM_08;
			clearOutput();
			encountersRuletteCDarkness();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Gloomy Underground Passage</b>\n");
			outputText("An aura of doom and gloom coats the tunnel you're in with a dark atmosphere. The shadows wick about in your peripherals as if they were living creatures encroaching just outside your field of view.");
			dungeons.setDungeonButtonsRD(roomC03, roomC12, null, roomC07);
		}
		public function roomC09():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_03_ROOM_09;
			clearOutput();
			encountersRuletteC();//one of three trigger locations
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Roiling Mist covers your surroundings, making you unable to see anything past a few feet.");
			dungeons.setDungeonButtonsRD(null, roomC15, null, null);
		}
		public function roomC10():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_03_ROOM_10;
			clearOutput();
			encountersRuletteC();//one of three trigger locations
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Roiling Mist covers your surroundings, making you unable to see anything past a few feet.");
			dungeons.setDungeonButtonsRD(roomC05, null, null, null);
		}
		public function roomC11():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_03_ROOM_11;
			clearOutput();
			encountersRuletteCDarkness();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Gloomy Underground Passage</b>\n");
			outputText("An aura of doom and gloom coats the tunnel you're in with a dark atmosphere. The shadows wick about in your peripherals as if they were living creatures encroaching just outside your field of view.");
			dungeons.setDungeonButtonsRD(roomC07, roomC17, null, null);
		}
		public function roomC12():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_03_ROOM_12;
			clearOutput();
			encountersRuletteCDarkness();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Gloomy Underground Passage</b>\n");
			outputText("An aura of doom and gloom coats the tunnel you're in with a dark atmosphere. The shadows wick about in your peripherals as if they were living creatures encroaching just outside your field of view.");
			dungeons.setDungeonButtonsRD(roomC08, null, roomC13, null);
		}
		public function roomC13():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_03_ROOM_13;
			clearOutput();
			encountersRuletteCDarkness();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Gloomy Underground Passage</b>\n");
			outputText("An aura of doom and gloom coats the tunnel you're in with a dark atmosphere. The shadows wick about in your peripherals as if they were living creatures encroaching just outside your field of view.");
			dungeons.setDungeonButtonsRD(null, roomC19, roomC14, roomC12);
		}
		public function roomC14():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_03_ROOM_14;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Roiling Mist covers your surroundings, making you unable to see anything past a few feet.");
			dungeons.setDungeonButtonsRD(null, null, roomC15, roomC13);
		}
		public function roomC15():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_03_ROOM_15;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Roiling Mist covers your surroundings, making you unable to see anything past a few feet.");
			dungeons.setDungeonButtonsRD(roomC09, roomC20, null, roomC14);
		}
		public function roomC16():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_03_ROOM_16;
			clearOutput();
			encountersRuletteC();//one of three trigger locations
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Roiling Mist covers your surroundings, making you unable to see anything past a few feet.");
			dungeons.setDungeonButtonsRD(null, null, roomC17, null);
		}
		public function roomC17():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_03_ROOM_17;
			clearOutput();
			encountersRuletteCDarkness();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Gloomy Underground Passage</b>\n");
			outputText("An aura of doom and gloom coats the tunnel you're in with a dark atmosphere. The shadows wick about in your peripherals as if they were living creatures encroaching just outside your field of view.");
			dungeons.setDungeonButtonsRD(roomC11, null, roomC18, roomC16);
		}
		public function roomC18():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_03_ROOM_18;
			clearOutput();
			encountersRuletteCDarkness();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Gloomy Underground Passage</b>\n");
			outputText("An aura of doom and gloom coats the tunnel you're in with a dark atmosphere. The shadows wick about in your peripherals as if they were living creatures encroaching just outside your field of view.");
			dungeons.setDungeonButtonsRD(null, null, roomC19, roomC17);
		}
		public function roomC19():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_03_ROOM_19;
			clearOutput();
			encountersRuletteCDarkness();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Gloomy Underground Passage</b>\n");
			outputText("An aura of doom and gloom coats the tunnel you're in with a dark atmosphere. The shadows wick about in your peripherals as if they were living creatures encroaching just outside your field of view.");
			dungeons.setDungeonButtonsRD(roomC13, null, null, roomC18);
		}
		public function roomC20():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_03_ROOM_20;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Roiling Mist covers your surroundings, making you unable to see anything past a few feet.");
			dungeons.setDungeonButtonsRD(roomC15, null, null, null);
			if (flags[kFLAGS.RIVER_DUNGEON_FLOORS_PROGRESS] > 8) addButton(11, "Down", roomD07);
			else addButtonDisabled(11, "Down", "You still need to beat guardian of this floor to descend into lower strata of the dungeon.");
		}
		public function roomC21():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_03_ROOM_21;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Hall</b>\n");
			outputText("You stand in a massive hall decorated with lavishly ornate trinkets. The baubles glimmer in the light, many of which resemble ice, snowflakes or bolts of lightning.\n\n");
			outputText("The walls to the manor have paintings depicting a battle between a man and his foes, the monsters range in size from humans to giants. It's difficult to distinguish what exactly the paintings were, time has long since faded the colors. Holes in the canvas trail strands of material.");
			dungeons.setDungeonButtonsRD(roomC22, roomC04, null, null);
		}
		public function roomC22():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_03_ROOM_22;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Hall</b>\n");
			outputText("You stand in a massive hall decorated with lavishly ornate trinkets. The baubles glimmer in the light, many of which resemble ice, snowflakes or bolts of lightning.\n\n");
			outputText("The walls to the manor have paintings depicting a battle between a man and his foes, the monsters range in size from humans to giants. It's difficult to distinguish what exactly the paintings were, time has long since faded the colors. Holes in the canvas trail strands of material.");
			dungeons.setDungeonButtonsRD(roomC23, roomC21, roomC25, null);
		}
		public function roomC23():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_03_ROOM_23;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Hall</b>\n");
			outputText("You stand in a massive hall decorated with lavishly ornate trinkets. The baubles glimmer in the light, many of which resemble ice, snowflakes or bolts of lightning.\n\n");
			outputText("The walls to the manor have paintings depicting a battle between a man and his foes, the monsters range in size from humans to giants. It's difficult to distinguish what exactly the paintings were, time has long since faded the colors. Holes in the canvas trail strands of material.");
			dungeons.setDungeonButtonsRD(roomC24, roomC22, roomC26, null);
		}
		public function roomC24():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_03_ROOM_24;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Hall</b>\n");
			outputText("You stand in a massive hall decorated with lavishly ornate trinkets. The baubles glimmer in the light, many of which resemble ice, snowflakes or bolts of lightning.\n\n");
			outputText("The walls to the manor have paintings depicting a battle between a man and his foes, the monsters range in size from humans to giants. It's difficult to distinguish what exactly the paintings were, time has long since faded the colors. Holes in the canvas trail strands of material.");
			dungeons.setDungeonButtonsRD(null, roomC23, roomC27, null);
		}
		public function roomC25():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_03_ROOM_25;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Hall</b>\n");
			outputText("You stand in a massive hall decorated with lavishly ornate trinkets. The baubles glimmer in the light, many of which resemble ice, snowflakes or bolts of lightning.\n\n");
			outputText("The walls to the manor have paintings depicting a battle between a man and his foes, the monsters range in size from humans to giants. It's difficult to distinguish what exactly the paintings were, time has long since faded the colors. Holes in the canvas trail strands of material.");
			dungeons.setDungeonButtonsRD(roomC26, null, roomC28, roomC22);
		}
		public function roomC26():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_03_ROOM_26;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Hall</b>\n");
			outputText("You stand in a massive hall decorated with lavishly ornate trinkets. The baubles glimmer in the light, many of which resemble ice, snowflakes or bolts of lightning.\n\n");
			outputText("The walls to the manor have paintings depicting a battle between a man and his foes, the monsters range in size from humans to giants. It's difficult to distinguish what exactly the paintings were, time has long since faded the colors. Holes in the canvas trail strands of material.");
			dungeons.setDungeonButtonsRD(roomC27, roomC25, roomC29, roomC23);
		}
		public function roomC27():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_03_ROOM_27;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Hall</b>\n");
			outputText("You stand in a massive hall decorated with lavishly ornate trinkets. The baubles glimmer in the light, many of which resemble ice, snowflakes or bolts of lightning.\n\n");
			outputText("The walls to the manor have paintings depicting a battle between a man and his foes, the monsters range in size from humans to giants. It's difficult to distinguish what exactly the paintings were, time has long since faded the colors. Holes in the canvas trail strands of material.");
			dungeons.setDungeonButtonsRD(null, roomC26, roomC30, roomC24);
		}
		public function roomC28():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_03_ROOM_28;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Hall</b>\n");
			outputText("You stand in a massive hall decorated with lavishly ornate trinkets. The baubles glimmer in the light, many of which resemble ice, snowflakes or bolts of lightning.\n\n");
			outputText("The walls to the manor have paintings depicting a battle between a man and his foes, the monsters range in size from humans to giants. It's difficult to distinguish what exactly the paintings were, time has long since faded the colors. Holes in the canvas trail strands of material.");
			dungeons.setDungeonButtonsRD(roomC29, null, roomC32, roomC25);
		}
		public function roomC29():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_03_ROOM_29;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Hall</b>\n");
			outputText("You stand in a massive hall decorated with lavishly ornate trinkets. The baubles glimmer in the light, many of which resemble ice, snowflakes or bolts of lightning.\n\n");
			outputText("The walls to the manor have paintings depicting a battle between a man and his foes, the monsters range in size from humans to giants. It's difficult to distinguish what exactly the paintings were, time has long since faded the colors. Holes in the canvas trail strands of material.");
			dungeons.setDungeonButtonsRD(roomC30, roomC28, roomC33, roomC26);
		}
		public function roomC30():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_03_ROOM_30;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Hall</b>\n");
			outputText("You stand in a massive hall decorated with lavishly ornate trinkets. The baubles glimmer in the light, many of which resemble ice, snowflakes or bolts of lightning.\n\n");
			outputText("The walls to the manor have paintings depicting a battle between a man and his foes, the monsters range in size from humans to giants. It's difficult to distinguish what exactly the paintings were, time has long since faded the colors. Holes in the canvas trail strands of material.");
			dungeons.setDungeonButtonsRD(null, roomC29, roomC34, roomC27);
		}
		public function roomC31():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_03_ROOM_31;//boss room
			clearOutput();
			if (flags[kFLAGS.RIVER_DUNGEON_FLOORS_PROGRESS] == 8) {
				outputText("Cautiously, you enter the room only to notice several rows of ice pillars on either side of a gold-plated throne with elaborate lightning and snowflake inlay. As you focus your eyes, you realize that on the throne lies a... Raiju?\n\n");
				outputText("Icy blue eyes glower toward you, his penetrative gaze feeds off nothing but scorn. A charcoal-like crown rests at the top of his head, accompanying his chiseled jawline. His toned frame is coated with an ornate cape and glittering spaulders linked together by a chain.\n\n");
				outputText("His voice booms, \"<i>A new subject? You look... inept.</i>\" He slowly rises from his throne, grabbing a longsword resting at his side as he takes a few long strides toward you. \"<i>Still... Your soul remains clean from my touch. How about I leave a mark on your essence that you'll never forget? Then hopefully you'll remember me, the one King Vegot.</i>\"\n\n");
				outputText("He drags the tip of the blade along the ground with each step. You notice an amulet wrapped around his neck. It glimmers with a frosted crust, pulsating with faint hums of electricity within.\n\n");
				outputText("\"<i>You're in my domain, now.</i>\" With only a single utterance from his voice, the entire room begins to freeze. A harsh wind picks up as snow flies around the room. You brace yourself against the blizzard; <b>the fight is on!</b>\n\n");
				if (!player.hasStatusEffect(StatusEffects.ThereCouldBeOnlyOne)) player.createStatusEffect(StatusEffects.ThereCouldBeOnlyOne, 0, 0, 0, 0);
				SceneLib.glacialRift.GlacialRiftConditions();
				startCombat(new Vegot(), true);
			}
			else if (!player.hasStatusEffect(StatusEffects.ThereCouldBeOnlyOne)) encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Frostlight Hall</b>\n");
			outputText("You stand in the large hall gaving upon several rows of ice pillars on either side of a gold-plated throne with elaborate lightning and snowflake inlay.\n\n");
			outputText("The throne of ice is empty as the previous owner has been taken away violently.");
			dungeons.setDungeonButtonsRD(roomC32, null, null, null);
		}
		public function roomC32():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_03_ROOM_32;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Hall</b>\n");
			outputText("You stand in a massive hall decorated with lavishly ornate trinkets. The baubles glimmer in the light, many of which resemble ice, snowflakes or bolts of lightning.\n\n");
			outputText("The walls to the manor have paintings depicting a battle between a man and his foes, the monsters range in size from humans to giants. It's difficult to distinguish what exactly the paintings were, time has long since faded the colors. Holes in the canvas trail strands of material.");
			if (flags[kFLAGS.RIVER_DUNGEON_FLOORS_PROGRESS] > 7) dungeons.setDungeonButtonsRD(roomC33, roomC31, null, roomC28);
			else {
				dungeons.setDungeonButtonsRD(roomC33, null, null, roomC28);
				addButtonDisabled(11, "South", "There are massive doors with a simple keyhole in middle of it. Maybe you should look for a key? It should be still somehwere on this floor, right?");
				if (player.hasKeyItem("Key Of Darkness") >= 0) addButton(0, "Insert Key", insertTheKey).hint("Now you have the key. Do you open the double door?");
				else addButtonDisabled(0, "Insert Key", "Would you kindly find the key first?");
			}
		}
		public function roomC33():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_03_ROOM_33;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Hall</b>\n");
			outputText("You stand in a massive hall decorated with lavishly ornate trinkets. The baubles glimmer in the light, many of which resemble ice, snowflakes or bolts of lightning.\n\n");
			outputText("The walls to the manor have paintings depicting a battle between a man and his foes, the monsters range in size from humans to giants. It's difficult to distinguish what exactly the paintings were, they have long been worn from time and gently torn from the walls.");
			dungeons.setDungeonButtonsRD(roomC34, roomC32, null, roomC29);
		}
		public function roomC34():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_03_ROOM_34;
			clearOutput();
			encountersRuletteC();//some unknown for now trigger locations
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Hall</b>\n");
			outputText("You stand in a massive hall decorated with lavishly ornate trinkets. The baubles glimmer in the light, many of which resemble ice, snowflakes or bolts of lightning.\n\n");
			outputText("The walls to the manor have paintings depicting a battle between a man and his foes, the monsters range in size from humans to giants. It's difficult to distinguish what exactly the paintings were, they have long been worn from time and gently torn from the walls.");
			dungeons.setDungeonButtonsRD(null, roomC33, null, roomC30);
		}/*
		public function roomD01():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_04_ROOM_01;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Roiling Mist covers your surroundings, making you unable to see anything past a few feet.");
			dungeons.setDungeonButtonsRD(null, null, null, null);
		}
		public function roomD02():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_04_ROOM_02;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Roiling Mist covers your surroundings, making you unable to see anything past a few feet.");
			dungeons.setDungeonButtonsRD(null, null, null, null);
		}
		public function roomD03():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_04_ROOM_03;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Roiling Mist covers your surroundings, making you unable to see anything past a few feet.");
			dungeons.setDungeonButtonsRD(null, null, null, null);
		}
		public function roomD04():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_04_ROOM_04;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Roiling Mist covers your surroundings, making you unable to see anything past a few feet.");
			dungeons.setDungeonButtonsRD(null, null, null, null);
		}
		public function roomD05():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_04_ROOM_05;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Roiling Mist covers your surroundings, making you unable to see anything past a few feet.");
			dungeons.setDungeonButtonsRD(null, null, null, null);
		}
		public function roomD06():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_04_ROOM_06;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Roiling Mist covers your surroundings, making you unable to see anything past a few feet.");
			dungeons.setDungeonButtonsRD(null, null, null, null);
		}*/
		public function roomD07():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_04_ROOM_07;
			clearOutput();
			encountersRuletteD();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Roiling Mist covers your surroundings, making you unable to see anything past a few feet.");
			dungeons.setDungeonButtonsRD(null, null, roomD08, null);
			addButton(0, "Teleport C.", teleportCircleFloor4);
			addButton(12, "Up", roomC20);
		}
		public function roomD08():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_04_ROOM_08;
			clearOutput();
			encountersRuletteD();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Roiling Mist covers your surroundings, making you unable to see anything past a few feet.");
			dungeons.setDungeonButtonsRD(null, null, roomD09, roomD07);
		}
		public function roomD09():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_04_ROOM_09;
			clearOutput();
			encountersRuletteD();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Roiling Mist covers your surroundings, making you unable to see anything past a few feet.");
			dungeons.setDungeonButtonsRD(null, null, roomD10, roomD08);
		}
		public function roomD10():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_04_ROOM_10;
			clearOutput();
			encountersRuletteD();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Roiling Mist covers your surroundings, making you unable to see anything past a few feet.");
			dungeons.setDungeonButtonsRD(null, null, null, roomD09);
		}/*
		public function roomD11():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_04_ROOM_11;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Roiling Mist covers your surroundings, making you unable to see anything past a few feet.");
			dungeons.setDungeonButtonsRD(null, null, null, null);
		}
		public function roomD12():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_04_ROOM_12;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Roiling Mist covers your surroundings, making you unable to see anything past a few feet.");
			dungeons.setDungeonButtonsRD(null, null, null, null);
		}
		public function roomD13():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_04_ROOM_13;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Roiling Mist covers your surroundings, making you unable to see anything past a few feet.");
			dungeons.setDungeonButtonsRD(null, null, null, null);
		}
		public function roomD14():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_04_ROOM_14;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Roiling Mist covers your surroundings, making you unable to see anything past a few feet.");
			dungeons.setDungeonButtonsRD(null, null, null, null);
		}
		public function roomD15():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_04_ROOM_15;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Roiling Mist covers your surroundings, making you unable to see anything past a few feet.");
			dungeons.setDungeonButtonsRD(null, null, null, null);
		}
		public function roomD16():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_04_ROOM_16;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Roiling Mist covers your surroundings, making you unable to see anything past a few feet.");
			dungeons.setDungeonButtonsRD(null, null, null, null);
		}
		public function roomD17():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_04_ROOM_17;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Roiling Mist covers your surroundings, making you unable to see anything past a few feet.");
			dungeons.setDungeonButtonsRD(null, null, null, null);
		}
		public function roomD18():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_04_ROOM_18;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Roiling Mist covers your surroundings, making you unable to see anything past a few feet.");
			dungeons.setDungeonButtonsRD(null, null, null, null);
		}
		public function roomD19():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_04_ROOM_19;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Roiling Mist covers your surroundings, making you unable to see anything past a few feet.");
			dungeons.setDungeonButtonsRD(null, null, null, null);
		}
		public function roomD20():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_04_ROOM_20;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Roiling Mist covers your surroundings, making you unable to see anything past a few feet.");
			dungeons.setDungeonButtonsRD(null, null, null, null);
		}
		public function roomD21():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_04_ROOM_21;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Roiling Mist covers your surroundings, making you unable to see anything past a few feet.");
			dungeons.setDungeonButtonsRD(null, null, null, null);
		}
		public function roomD22():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_04_ROOM_22;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Roiling Mist covers your surroundings, making you unable to see anything past a few feet.");
			dungeons.setDungeonButtonsRD(null, null, null, null);
		}
		public function roomD23():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_04_ROOM_23;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Roiling Mist covers your surroundings, making you unable to see anything past a few feet.");
			dungeons.setDungeonButtonsRD(null, null, null, null);
		}
		public function roomD24():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_04_ROOM_24;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Roiling Mist covers your surroundings, making you unable to see anything past a few feet.");
			dungeons.setDungeonButtonsRD(null, null, null, null);
		}
		public function roomD25():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_04_ROOM_25;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Roiling Mist covers your surroundings, making you unable to see anything past a few feet.");
			dungeons.setDungeonButtonsRD(null, null, null, null);
		}
		public function roomE01():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_05_ROOM_01;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Roiling Mist covers your surroundings, making you unable to see anything past a few feet.");
			dungeons.setDungeonButtonsRD(null, null, null, null);
		}
		public function roomE02():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_05_ROOM_02;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Roiling Mist covers your surroundings, making you unable to see anything past a few feet.");
			dungeons.setDungeonButtonsRD(null, null, null, null);
		}
		public function roomE03():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_05_ROOM_03;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Roiling Mist covers your surroundings, making you unable to see anything past a few feet.");
			dungeons.setDungeonButtonsRD(null, null, null, null);
		}
		public function roomE04():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_05_ROOM_04;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Roiling Mist covers your surroundings, making you unable to see anything past a few feet.");
			dungeons.setDungeonButtonsRD(null, null, null, null);
		}
		public function roomE05():void {
			dungeonLoc = DUNGEON_RIVER_FLOOR_05_ROOM_05;
			clearOutput();
			encountersRuletteC();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Underground Passage</b>\n");
			outputText("Roiling Mist covers your surroundings, making you unable to see anything past a few feet.");
			dungeons.setDungeonButtonsRD(null, null, null, null);
		}
		*/
		private function tresureRoom1A():void {
			clearOutput();
			outputText("You notice a faint glimmer in the distance and approach it. The glimmer reveals itself to be a mosaic, glittering gems embedded into the wall. Neisa is quick to notice it, too.\n\n");
			outputText("\"<i>Heya, [name], this is my pay. Thank Marae that I brought a pair of pickaxes just in case, now lets get digging.</i>\"\n\n");
			outputText("The two of you proceed to carefully extract the precious gemstones from the wall as Nessa pockets her payment.\n\n");
			flags[kFLAGS.NEISA_AFFECTION] = 5;
			doNext(roomA03);
		}
		private function tresureRoom2A():void {
			clearOutput();
			outputText("As you tread within the dungeon, you run into what appears to be a pile of loot. Is it a trap? Perhaps more likely it's the hoard and gear of some adventurer before he was taken by demons... or worse. Having seen the horrors of Mareth firsthand, you know the risks of adventuring. Neisa is quick to acknowledge the loot as well.\n\n");
			outputText("\"<i>Aye, I guess one person's misfortune is our benefit. Help me put these into a bag. This should help cover my pay.</i>\"\n\n");
			outputText("After looting the corpse, the two of you continue on your way.\n\n");
			flags[kFLAGS.NEISA_AFFECTION] = 10;
			doNext(roomA10);
		}
		private function insertTheKey():void {
			clearOutput();
			var compcou:Number = 0;
			if (flags[kFLAGS.PLAYER_COMPANION_1] != "") compcou += 1;
			if (flags[kFLAGS.PLAYER_COMPANION_2] != "") compcou += 1;
			if (flags[kFLAGS.PLAYER_COMPANION_3] != "") compcou += 1;
			var compname:String = "";
			if (flags[kFLAGS.PLAYER_COMPANION_1] != "") compname = ""+flags[kFLAGS.PLAYER_COMPANION_1]+"";
			else if (flags[kFLAGS.PLAYER_COMPANION_2] != "") compname = ""+flags[kFLAGS.PLAYER_COMPANION_2]+"";
			else if (flags[kFLAGS.PLAYER_COMPANION_3] != "") compname = ""+flags[kFLAGS.PLAYER_COMPANION_3]+"";
			outputText("You insert the key, only for it to immediately begin fusing with the doors. You step back as symbols start to emerge, glowing faintly as they form text:\n\n");
			outputText("<i>This is my kingdom</i>\n");
			outputText("<i>This is my domain</i>\n");
			outputText("<i>You cant take it from me, the greatest you've seen</i>\n");
			outputText("<i>You'll remember my name</i>\n");
			outputText("<i>Call me a god, call me a king</i>\n");
			outputText("<i>You're out of my realm, so bend the knee</i>\n\n");
			outputText("Whoever this is, they seem to be rather conceited. You glance over to your companion"+(compcou > 1 ? "s":"")+", making sure "+(compcou > 1 ? "they are":""+compname+" is")+" ready to continue. With a nod, the two of you push open the door as a wave of cold air hits your face. You feel a faint hum of electricity emanating from inside as the door opens fully.\n\n");
			if (player.hasKeyItem("Key Of Darkness") >= 0) player.removeKeyItem("Key Of Darkness");
			player.createStatusEffect(StatusEffects.ThereCouldBeOnlyOne, 0, 0, 0, 0);
			flags[kFLAGS.RIVER_DUNGEON_FLOORS_PROGRESS]++;
			doNext(roomC32);
		}
		private function teleportCircleFloor1():void {
			menu();
			addButtonDisabled(0, "Floor 1", "You're currently at Floor 1.");
			if (flags[kFLAGS.RIVER_DUNGEON_FLOORS_PROGRESS] > 1) addButton(1, "Floor 2", teleportToFloor2);
			else addButtonDisabled(1, "Floor 2", "You still need to beat guardians of floor 1 to use this teleport option.");
			if (flags[kFLAGS.RIVER_DUNGEON_FLOORS_PROGRESS] > 6) addButton(2, "Floor 3", teleportToFloor3);
			else addButtonDisabled(2, "Floor 3", "You still need to beat guardian of floor 2 to use this teleport option.");
			if (flags[kFLAGS.RIVER_DUNGEON_FLOORS_PROGRESS] > 8) addButton(3, "Floor 4", teleportToFloor4);
			else addButtonDisabled(3, "Floor 4", "You still need to beat guardian of floor 3 to use this teleport option.");
			//5
			addButton(14, "Back", roomA01);
		}
		private function teleportCircleFloor2():void {
			menu();
			addButton(0, "Floor 1", teleportToFloor1);
			addButtonDisabled(1, "Floor 2", "You're currently at Floor 2.");
			if (flags[kFLAGS.RIVER_DUNGEON_FLOORS_PROGRESS] > 6) addButton(2, "Floor 3", teleportToFloor3);
			else addButtonDisabled(2, "Floor 3", "You need to beat the guardian of floor 2 to use this teleport.");
			if (flags[kFLAGS.RIVER_DUNGEON_FLOORS_PROGRESS] > 8) addButton(3, "Floor 4", teleportToFloor4);
			else addButtonDisabled(3, "Floor 4", "You still need to beat guardian of floor 3 to use this teleport option.");
			//5
			addButton(14, "Back", roomB01);
		}
		private function teleportCircleFloor3():void {
			menu();
			addButton(0, "Floor 1", teleportToFloor1);
			addButton(1, "Floor 2", teleportToFloor2);
			addButtonDisabled(2, "Floor 3", "You're currently at Floor 3.");
			if (flags[kFLAGS.RIVER_DUNGEON_FLOORS_PROGRESS] > 8) addButton(3, "Floor 4", teleportToFloor4);
			else addButtonDisabled(3, "Floor 4", "You still need to beat guardian of floor 3 to use this teleport option.");
			//5
			addButton(14, "Back", roomC01);
		}
		private function teleportCircleFloor4():void {
			menu();
			addButton(0, "Floor 1", teleportToFloor1);//1-10
			addButton(1, "Floor 2", teleportToFloor2);//11-20
			addButton(2, "Floor 3", teleportToFloor3);//21-35
			addButtonDisabled(3, "Floor 4", "You're currently at Floor 4.");//36-50
			//5
			addButton(14, "Back", roomC01);
		}
		private function teleportToFloor1():void {
			clearOutput();
			outputText("A circle of energy slowly emerges, wrapping around your team. Magic surges as your vision blurs. In nearly an instant, you're transported to the first floor.\n\n");
			dungeonLoc = DUNGEON_RIVER_FLOOR_01_ROOM_01;
			playerMenu();
		}
		private function teleportToFloor2():void {
			clearOutput();
			outputText("A circle of energy slowly emerges, wrapping around your team. Magic surges as your vision blurs. In nearly an instant, you're transported to the second floor.\n\n");
			dungeonLoc = DUNGEON_RIVER_FLOOR_02_ROOM_01;
			playerMenu();
		}
		private function teleportToFloor3():void {
			clearOutput();
			outputText("A circle of energy slowly emerges, wrapping around your team. Magic surges as your vision blurs. In nearly an instant, you're transported to the third floor.\n\n");
			dungeonLoc = DUNGEON_RIVER_FLOOR_03_ROOM_01;
			playerMenu();
		}
		private function teleportToFloor4():void {
			clearOutput();
			outputText("A circle of energy slowly emerges, wrapping around your team. Magic surges as your vision blurs. In nearly an instant, you're transported to the fourth floor.\n\n");
			dungeonLoc = DUNGEON_RIVER_FLOOR_04_ROOM_07;
			playerMenu();
		}
	}
}