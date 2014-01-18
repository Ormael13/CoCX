/**
 * Created by aimozg on 06.01.14.
 */
package classes.Scenes.Areas
{
	import classes.Appearance;
	import classes.BaseContent;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Scenes.Areas.Forest.*;
	import classes.Scenes.Monsters.Goblin;
	import classes.Scenes.Monsters.Imp;
	import classes.Scenes.Monsters.GoblinAssassinScene;
	import classes.Scenes.NPCs.Jojo;

	use namespace kGAMECLASS;

	public class Forest extends BaseContent
	{
		public var akbalScene:AkbalScene = new AkbalScene();
		public var beeGirlScene:BeeGirlScene = new BeeGirlScene();
		public var essrayle:Essrayle = new Essrayle();
		public var faerie:Faerie = new Faerie();
		public var kitsuneScene:KitsuneScene = new KitsuneScene();
		public var tamaniDaughtersScene:TamainsDaughtersScene = new TamainsDaughtersScene();
		public var tamaniScene:TamaniScene = new TamaniScene();
		public var tentacleBeastScene:TentacleBeastScene = new TentacleBeastScene();
		public function Forest()
		{
		}
		public function exploreDeepwoods():void
		{
			player.addStatusValue("exploredDeepwoods", 1, 1);
			var chooser:Number = rand(5);
			var temp2:Number = 0;
			//Every tenth exploration finds a pumpkin if eligible!
			if (player.statusAffectv1("exploredDeepwoods") % 10 == 0 && isHalloween()) {
				//If Fera isn't free yet...
				if (player.hasPerk("Fera's Boon - Breeding Bitch") < 0 && player.hasPerk("Fera's Boon - Alpha") < 0) {
					if (date.fullYear > flags[kFLAGS.PUMPKIN_FUCK_YEAR_DONE]) {
						kGAMECLASS.pumpkinFuckEncounter();
						return;
					}
				}
				//Fera is free!
				else {
					if (flags[kFLAGS.FERAS_TRAP_SPRUNG_YEAR] == 0) {
						if (date.fullYear > flags[kFLAGS.FERAS_GLADE_EXPLORED_YEAR]) {
							kGAMECLASS.feraSceneTwoIntroduction();
							return;
						}
					}
				}
			}
			//Hel jumps you for sex.
			if (flags[kFLAGS.PC_PROMISED_HEL_MONOGAMY_FUCKS] == 1 && flags[kFLAGS.HEL_RAPED_TODAY] == 0 && rand(10) == 0 && player.gender > 0 && !kGAMECLASS.helScene.followerHel()) {
				kGAMECLASS.helScene.helSexualAmbush();
				return;
			}
			//Every 5th exploration encounters d2 if hasnt been met yet and factory done
			if (flags[kFLAGS.DISCOVERED_DUNGEON_2_ZETAZ] == 0 && player.statusAffectv1("exploredDeepwoods") % 5 == 0 && player.hasStatusAffect("DungeonShutDown") >= 0) {
				outputText("While you explore the deepwoods, you do your best to forge into new, unexplored locations.  While you're pushing away vegetation and slapping at plant-life, you spot a half-overgrown orifice buried in the side of a ravine.  There's a large number of imp-tracks around the cavern's darkened entryway.  Perhaps this is where the imp, Zetaz, makes his lair?  In any event, it's past time you checked back on the portal.  You make a mental note of the cave's location so that you can return when you're ready.", true);
				outputText("\n\n<b>You've discovered the location of Zetaz's lair!</b>", false);
				simpleChoices("Enter", 11076, "", 0, "", 0, "", 0, "Leave", 13);
				flags[kFLAGS.DISCOVERED_DUNGEON_2_ZETAZ]++;
				return;
			}
			//Tamani 20% encounter rate
			if (flags[kFLAGS.TAMANI_TIME_OUT] == 0 && rand(5) == 0 && player.gender > 0 && (player.totalCocks() > 0 || player.hasKeyItem("Deluxe Dildo") < 0)) {
				if (player.totalCocks() > 0 && flags[kFLAGS.TAMANI_DAUGHTER_PREGGO_COUNTDOWN] == 0 && int(player.statusAffectv2("Tamani") / 2) >= 12) {
					tamaniDaughtersScene.encounterTamanisDaughters();
				}
				else
					tamaniScene.encounterTamani();
				return;
			}
			//Faerie
			if (chooser == 0) {
				faerie.encounterFaerie();
				return;
			}
			//Tentacle monster
			if (chooser == 1) {
				//Reset hilarious shit
				if (player.gender > 0) flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00247] = 0;
				//Tentacle avoidance chance due to dangerous plants
				if (player.hasKeyItem("Dangerous Plants") >= 0 && player.inte / 2 > rand(50)) {
					trace("TENTACLE'S AVOIDED DUE TO BOOK!");
					outputText("Using the knowledge contained in your 'Dangerous Plants' book, you determine a tentacle beast's lair is nearby, do you continue?  If not you could return to camp.\n\n", true);
					simpleChoices("Continue", 2009, "", 0, "", 0, "", 0, "Leave", 13);
					return;
				}
				else {
					eventParser(2009);
					return;
				}
			}
			//Corrupted Glade
			if (chooser == 2) {
				if (rand(4) == 0) {
					trappedSatyr();
					return;
				}
				spriteSelect(92);
				outputText("Walking through the woods, you find a damp patch overgrown with corrupted plant-life.  Every flower seems warped into a colorful imitation of female genitals, each vine appears throbbing and veiny, and every knot on the nearby trees is capped with a nipple-like protrusion, leaking dark sap.", true);
				//disgusted reaction
				if (player.cor <= 33) {
					//Get plant-cum dripped on you if not fast and unlucky!
					if (player.spe < 60 && rand(player.spe + 50) < 50) {
						outputText("  Disgusted by this perversion of nature, you turn to leave, catching a faceful of the white goop that's spurting down from the vines above!  It's slimy, gross, and difficult to clear from your eyes, nose, and mouth.  The musky smell and delicious salty flavor are undoubtedly a result of the plant's corruption.  You escape the tainted glade, but feel warmer and warmer as time passes...", false);
						dynStats("lus", 20 + player.lib / 5);
					}
					else {
						outputText("  Disgusted by this perversion of nature, you turn away to leave, narrowly avoiding a sudden dripping of thick white fluid from the vines overhead.", false);
						dynStats("lus", 2);
					}
					doNext(13);
					return;
				}
				//intrigued reaction
				if (player.cor > 33 && player.cor <= 66) {
					outputText("  You explore the glade with equal parts caution and curiosity.  ", false);
					temp2 = rand(3);
					//flowers...
					if (temp2 == 0) {
						outputText("A group of perverted looking flowers catch your eye, and leading you to bend closer for a better look at the intricately folded petals, noting the beads of slick moisture that seems to perspire from inside the plant.  Awed by the corrupt yet beautiful flower, you take a deep breath, inhaling a lungful of it's pungent yet sweet scents.  It matches the flower somehow, lingering in your nose even after you pull away.  The smell makes you wonder just how functional the pussy flowers are, as they do have fairly large stalks.\n\nYou sigh and take one last sniff from the flower's honeypot before moving on.  Your body flushes happily with desire as your blood pools in your groin.  You giggle, wishing you could feel like this more often.", false);
						dynStats("lus", 20 + player.lib / 5, "cor", .5);
					}
					//vines...
					if (temp2 == 1) {
						outputText("A few vines dangling from the trees catch your eye due to their rather 'unique' tips.  Every single one of them ends in a flared mushroom-like head, each twice as wide as the already thick vine.  You touch a vine gently, musing at its slippery texture and how similar it would be to a penis if the 'head' were smaller.  You encircle the vine with your hand, stroking it and giggling at the absurdity of this place.  The vine suddenly flexes in your grasp, pulsating and contracting as its head grows bigger, turning shiny and red.  Pulling away in shock, you gasp as the vine begins spurting out huge ropes of thick viscous fluid, splattering everywhere.  The plant-gasm ends as suddenly as it started, the 'head' retaining the size it gained and dripping the last of its strange load.  Overcome with curiosity, you sniff at the dripping spunk and swoon at the overpoweringly musky scent.  Gathering your wits, you decide to leave before you end up with one of those inside you.  You escape the corrupted glade, but stay flush with arousal.", false);
						dynStats("lus", 20 + player.lib / 5, "cor", .5);
					}
					//trees...
					if (temp2 == 2) {
						outputText("A cluster of huge breast-like knots on a nearby tree draws your attention.  Unable to resist, you poke one, and burst into giggles as it jiggles like a real breast!  You cautiously begin groping the tree-tit, and smile as it begins leaking sweet-smelling sap.  The scent conjures memories of helping to make maple syrup back home, and before you realize it, you've gathered a drop of the sap on your finger and tasted it.  It's powerfully sweet, making your tongue tingle and heart beat faster.  Unbidden, the thought of suckling the teat dry of its sweet treat comes to mind, but you manage to reject it and stumble away from the corrupted glade.  You have trouble with your tongue for the next hour: it won't stay in your mouth, and keeps licking your lips, seeking any leftover sweetness.  It almost distracts you from the palpable heat gathering between your thighs.", false);
						dynStats("lus", 20 + player.lib / 5, "cor", .5);
					}
					doNext(13);
					return;
				}
				//drink sap/lick flower reaction
				if (player.cor > 66 && player.cor <= 100) {
					outputText("  You smile as you enter the glade, wondering which of the forbidden fruits you should try...\n\nThere are flowers that bear more than a passing resemblance to pussies,\nvines with absurdly large penis-like tips,\nand trees covered in breast-like knots, leaking sap.", false);
					simpleChoices("Flowers", 2012, "Vines", 2013, "Trees", 2084, "", 0, "Leave", 13);
					return;
				}
				//Wallow in decadence reaction - UNFINISHED
			}
			if (chooser == 3) {
				akbalScene.supahAkabalEdition();
			}
			else if (chooser == 4) {
				if (rand(3) == 0) kitsuneScene.kitsuneShrine();
				else kitsuneScene.enterTheTrickster();
			}
		}

		//Explore forest
		public function exploreForest():void
		{
			player.exploredForest++;

			trace("FOREST EVENT CALLED");
			var chooser:Number = rand(4);
			var temp2:Number = 0;
			//Cut bee encounter rate 50%
			if (chooser == 3 && rand(2)) chooser = rand(3);
			//Quick changes:
			//If monk is fully corrupted, encounter him less (unless haz ferriiite).
			if (chooser == 1 && kGAMECLASS.monk >= 2) {
				temp = rand(4);
				if (temp == 0) chooser = 0;
				if (temp == 1) chooser = 2;
				if (temp == 2) chooser = 3;
			}
			//Helia monogamy fucks
			if (flags[kFLAGS.PC_PROMISED_HEL_MONOGAMY_FUCKS] == 1 && flags[kFLAGS.HEL_RAPED_TODAY] == 0 && rand(10) == 0 && player.gender > 0 && !kGAMECLASS.helScene.followerHel()) {
				kGAMECLASS.helScene.helSexualAmbush();
				return;
			}
			//Raise Jojo chances for furrite
			if (player.hasPerk("Pierced: Furrite") >= 0 && rand(5) == 0 && (player.cor > 25 || kGAMECLASS.monk > 0)) {
				chooser = 1;
			}
			//If Jojo lives in camp, never encounter him
			if (player.hasStatusAffect("PureCampJojo") >= 0 || flags[kFLAGS.JOJO_DEAD_OR_GONE] == 1) {
				chooser = rand(3);
				if (chooser >= 1) chooser++;
			}
			//Chance to discover deepwoods
			if ((player.exploredForest >= 20) && player.hasStatusAffect("exploredDeepwoods") < 0) {
				player.createStatusAffect("exploredDeepwoods", 0, 0, 0, 0);
				outputText("After exploring the forest so many times, you decide to really push it, and plunge deeper and deeper into the woods.  The further you go the darker it gets, but you courageously press on.  The plant-life changes too, and you spot more and more lichens and fungi, many of which are luminescent.  Finally, a wall of tree-trunks as wide as houses blocks your progress.  There is a knot-hole like opening in the center, and a small sign marking it as the entrance to the 'Deepwoods'.  You don't press on for now, but you could easily find your way back to explore the Deepwoods.\n\n<b>Deepwoods exploration unlocked!</b>", true);
				doNext(13);
				return;
			}
			//Essy every 20 explores or so
			if ((rand(100) <= 1) && player.gender > 0 && (flags[kFLAGS.ESSY_MET_IN_DUNGEON] == 0 || flags[kFLAGS.TOLD_MOTHER_TO_RELEASE_ESSY] == 1)) {
				essrayle.essrayleMeetingI();
				return;
			}
			//Chance of dick-dragging! 10% + 10% per two foot up to 30%
			temp = 10 + (player.longestCockLength() - player.tallness) / 24 * 10;
			if (temp > 30) temp = 30;
			if (temp > rand(100) && player.longestCockLength() >= player.tallness && player.totalCockThickness() >= 12) {
				bigJunkForestScene();
				return;
			}
			//Marble randomness
			if (player.exploredForest % 50 == 0 && player.exploredForest > 0 && player.hasStatusAffect("Marble Rape Attempted") < 0 && player.hasStatusAffect("No More Marble") < 0 && player.hasStatusAffect("Marble") >= 0 && flags[kFLAGS.MARBLE_WARNING] == 0) {
				//can be triggered one time after Marble has been met, but before the addiction quest starts.
				clearOutput();
				outputText("While you're moving through the trees, you suddenly hear yelling ahead, followed by a crash and a scream as an imp comes flying at high speed through the foliage and impacts a nearby tree.  The small demon slowly slides down the tree before landing at the base, still.  A moment later, a familiar-looking cow-girl steps through the bushes brandishing a huge two-handed hammer with an angry look on her face.");
				outputText("\n\nShe goes up to the imp, and kicks it once.  Satisfied that the creature isn't moving, she turns around to face you and gives you a smile.  \"<i>Sorry about that, but I prefer to take care of these buggers quickly.  If they get the chance to call on their friends, they can actually become a nuisance.</i>\"  She disappears back into the foliage briefly before reappearing holding two large pile of logs under her arms, with a fire axe and her hammer strapped to her back.  \"<i>I'm gathering firewood for the farm, as you can see; what brings you to the forest, sweetie?</i>\"  You inform her that you're just exploring.");
				outputText("\n\nShe gives a wistful sigh. \"<i>I haven't really explored much since getting to the farm.  Between the jobs Whitney gives me, keeping in practice with my hammer, milking to make sure I don't get too full, cooking, and beauty sleep, I don't get a lot of free time to do much else.</i>\"  She sighs again.  \"<i>Well, I need to get this back, so I'll see you later!</i>\"");
				//end event
				doNext(13);
				return;
			}
			if (chooser == 0) {
				//Determines likelyhood of imp/goblins
				//Below - goblin, Equal and up - imp
				var impGob:Number = 5;
				trace("IMP/Gobb");

				//Dicks + lots of cum boosts goblin probability
				//Vags + Fertility boosts imp probability
				if (player.totalCocks() > 0) impGob--;
				if (player.hasVagina()) impGob++;
				if (player.fertility + player.bonusFertility() >= 30) impGob++;
				if (player.cumQ() >= 200) impGob--;
				if (player.hasPerk("Pierced: Lethite") >= 0) {
					if (impGob <= 3) impGob += 2;
					else if (impGob < 7) impGob = 7;
				}
				//Imptacular Encounter
				if (rand(10) < impGob) {
					if (player.level >= 8 && rand(2) == 0) {
						kGAMECLASS.impScene.impLordEncounter();
					}
					else {
						outputText("An imp leaps out of the bushes and attacks!", true);
						startCombat(new Imp());
					}
					spriteSelect(29);
					return;
				}
				//Encounter Gobbalin!
				else {
					//Tamani 25% of all goblin encounters encounter rate
					if (rand(4) <= 0 && flags[kFLAGS.TAMANI_TIME_OUT] == 0 && player.gender > 0 && (player.totalCocks() > 0 || player.hasKeyItem("Deluxe Dildo") < 0)) {
						if (player.totalCocks() > 0 && flags[kFLAGS.TAMANI_DAUGHTER_PREGGO_COUNTDOWN] == 0 && int(player.statusAffectv2("Tamani") / 2) >= 12) {
							tamaniDaughtersScene.encounterTamanisDaughters();
						}
						else
							tamaniScene.encounterTamani();
						return;
					}
					//50% of the time, goblin assassin!
					if (player.level >= 10 && rand(2) == 0) {
						kGAMECLASS.goblinAssassinScene.goblinAssassinEncounter();
						return;
					}
					if (player.gender > 0) {
						outputText("A goblin saunters out of the bushes with a dangerous glint in her eyes.\n\nShe says, \"<i>Time to get fucked, " + player.mf("stud", "slut"), true);
						outputText(".</i>\"", false);
						startCombat(new Goblin());
						spriteSelect(24);
						return;
					}
					else {
						outputText("A goblin saunters out of the bushes with a dangerous glint in her eyes.\n\nShe says, \"<i>Time to get fuc-oh shit, you don't even have anything to play with!  This is for wasting my time!", true);
						outputText("</i>\"", false);
						startCombat(new Goblin());
						spriteSelect(24);
						return;
					}
				}
			}
			if (chooser == 1) {
				doNext(13);
				outputText("", true);
				if (kGAMECLASS.monk == 0) {
					if (player.cor < 25) {
						outputText("You enjoy a peaceful walk in the woods.  It gives you time to think over the recent, disturbing events.", true);
						dynStats("tou", .5, "int", 1);
						doNext(13);
						return;
					}
					kGAMECLASS.monk = 1;
					kGAMECLASS.jojoScene.jojoSprite();
					outputText("While marvelling at the strange trees and vegetation of the forest, the bushes ruffle ominously.  A bush seems to explode into a flurry of swirling leaves and movement.  Before you can react you feel your " + player.feet() + " swept out from under you, and land hard on your back.\n\n", false);
					outputText("The angry visage of a lithe white mouse gazes down on your prone form with a look of confusion.", false);
					outputText("\n\n\"<i>I'm sorry, I sensed a great deal of corruption, and thought a demon or monster had come to my woods,</i>\" says the mouse, \"<i>Oh, where are my manners!</i>\"\n\nHe helps you to your feet and introduces himself as Jojo.  Now that you have a good look at him, it is obvious this mouse is some kind of monk, dressed in robes, holy symbols, and draped with prayer beads.\n\nHe smiles knowingly, \"<i>Yes I am a monk, and yes this is a strange place for one such as I... this world was not always this way.  Long ago this world was home to many villages, including my own.  But then the demons came.  I'm not sure if they were summoned, created, or simply a perversion of magic or breeding, but they came swarming out of the mountains to destroy everything in their path.</i>\"", false);
					outputText("\n\nJojo sighs sadly, \"<i>Enough of my woes.  You are very corrupted.  If you cannot be sufficiently purified you WILL become one of them in time.  Will you let me help you?", false);
					if (player.gender > 0) {
						trace("Gender != 0");
						simpleChoices("Accept", 2003, "Rape Him", kGAMECLASS.jojoScene.jojoRape, "BWUH?", 0, "Decline", 13, "", 0);
					}
					else {
						trace("Gender == 0");
						simpleChoices("Accept", 2003, "Rape Him", 0, "BWUH?", 0, "Decline", 13, "", 0);
					}
					return;
				}
				if (kGAMECLASS.monk == 1) {
					if (player.cor < 10) {
						outputText("You enjoy a peaceful walk in the woods, it gives you time to think.", true);
						dynStats("tou", .5, "int", 1);
						doNext(13);
						return;
					}
					if (player.hasStatusAffect("infested") >= 0) {
						kGAMECLASS.jojoScene.jojoSprite();
						outputText("As you approach the serene monk, you see his nose twitch, disturbing his meditation.\n\n", true);
						outputText("\"<i>It seems that the agents of corruption have taken residence within the temple that is your body.</i>\", Jojo says flatly. \"<i>This is a most unfortunate development. There is no reason to despair as there are always ways to fight the corruption. However, great effort will be needed to combat this form of corruption and may leave lasting impressions upon you. If you are ready, we can purge your being of the rogue creatures of lust.</i>\"\n\n", false);
						if (player.gender > 0) simpleChoices("Purge", 2083, "Meditate", 2003, "Rape", kGAMECLASS.jojoScene.jojoRape, "", 0, "Leave", 13);
						else simpleChoices("Purge", 2083, "Meditate", 2003, "Rape", 0, "", 0, "Leave", 13);
						return;
					}
					kGAMECLASS.jojoScene.jojoSprite();
					outputText("Jojo the monk appears before you, robes and soft white fur fluttering in the breeze.  He asks, \"<i>Are you ready for a meditation session?</i>\"", false);
					if (player.gender > 0) simpleChoices("Yes", 2003, "No", 13, "BWUH", 0, "Rape Him", kGAMECLASS.jojoScene.jojoRape, "", 0);
					else simpleChoices("Yes", 2003, "No", 13, "BWUH", 0, "Rape Him", 0, "", 0);
				}
				if (kGAMECLASS.monk >= 2) {
					kGAMECLASS.jojoScene.jojoSprite();
					outputText("You are enjoying a peaceful walk through the woods when Jojo drops out of the trees ahead, ", true);
					if (kGAMECLASS.monk == 2) outputText("his mousey visage twisted into a ferocious snarl.  \"YOU!\" he screams, launching himself towards you, claws extended.", false);
					if (kGAMECLASS.monk == 3) outputText("unsteady on his feet, but looking for a fight!", false);
					if (kGAMECLASS.monk == 4) outputText("visibly tenting his robes, but intent on fighting you.", false);
					if (kGAMECLASS.monk == 5) outputText("panting and nude, his fur rustling in the breeze, a twitching behemoth of a cock pulsing between his legs.", false);
					startCombat(new Jojo());
				}
			}
			//Tentacles 25% of the time...
			if (chooser == 2) {
				trace("TRACE TENTACRUELS");
				outputText("", true);
				temp = rand(5);
				//Oh noes, tentacles!
				if (temp == 0) {
					//Tentacle avoidance chance due to dangerous plants
					if (player.hasKeyItem("Dangerous Plants") >= 0 && player.inte / 2 > rand(50)) {
						trace("TENTACLE'S AVOIDED DUE TO BOOK!");
						outputText("Using the knowledge contained in your 'Dangerous Plants' book, you determine a tentacle beast's lair is nearby, do you continue?  If not you could return to camp.\n\n", false);
						simpleChoices("Continue", 2009, "", 0, "", 0, "", 0, "Leave", 13);
						return;
					}
					else {
						eventParser(2009);
						return;
					}
				}
				if (temp == 1) {
					if (player.cor < 80) {
						outputText("You enjoy a peaceful walk in the woods, it gives you time to think.", false);
						dynStats("tou", .5, "int", 1);
					}
					else {
						outputText("As you wander in the forest, you keep ", false);
						if (player.gender == 1) outputText("stroking your half-erect " + multiCockDescriptLight() + " as you daydream about fucking all kinds of women, from weeping tight virgins to lustful succubi with gaping, drooling fuck-holes.", false);
						if (player.gender == 2) outputText("idly toying with your " + vaginaDescript(0) + " as you daydream about getting fucked by all kinds of monstrous cocks, from minotaurs' thick, smelly dongs to demons' towering, bumpy pleasure-rods.", false);
						if (player.gender == 3) outputText("stroking alternatively your " + multiCockDescriptLight() + " and your " + vaginaDescript(0) + " as you daydream about fucking all kinds of women, from weeping tight virgins to lustful succubi with gaping, drooling fuck-holes, before, or while, getting fucked by various monstrous cocks, from minotaurs' thick, smelly dongs to demons' towering, bumpy pleasure-rods.", false);
						if (player.gender == 0) outputText("daydreaming about sex-demons with huge sexual attributes, and how you could please them.", false);
						outputText("", false);
						dynStats("tou", .5, "lib", .25, "lus", player.lib / 5);
					}
					doNext(13);
					return;
				}
				//CORRUPTED GLADE
				if (temp == 2 || temp >= 4) {
					if (rand(4) == 0) {
						trappedSatyr();
						return;
					}
					spriteSelect(92);
					outputText("Walking through the woods, you find a damp patch overgrown with corrupted plant-life.  Every flower seems warped into a colorful imitation of a female's genitals, each vine appears throbbing and veiny, and every knot on the nearby trees is capped with a nipple-like protrusion, leaking dark sap.", false);
					//disgusted reaction
					if (player.cor <= 33) {
						//Get plant-cum dripped on you if not fast and unlucky!
						if (player.spe < 60 && rand(player.spe + 50) < 50) {
							outputText("  Disgusted by this perversion of nature, you turn to leave, catching a faceful of the white goop that's spurting down from the vines above!  It's slimy, gross, and difficult to clear from your eyes, nose, and mouth.  The musky smell and delicious salty flavor are undoubtedly a result of the plant's corruption.  You escape the tainted glade, but feel warmer and warmer as time passes...", false);
							dynStats("lus", 20 + player.lib / 5);
						}
						else {
							outputText("  Disgusted by this perversion of nature, you turn away to leave, narrowly avoiding a sudden dripping of thick white fluid from the vines overhead.", false);
							dynStats("lus", 2);
						}
						doNext(13);
						return;
					}
					//intrigued reaction
					if (player.cor > 33 && player.cor <= 66) {
						outputText("  You explore the glade with equal parts caution and curiosity.  ", false);
						temp2 = rand(3);
						//flowers...
						if (temp2 == 0) {
							outputText("A group of perverted looking flowers catch your eye, leading you to bend closer for a better look at the intricately folded petals, noting the beads of slick moisture that seems to perspire from inside the plant.  Awed by the corrupt yet beautiful flower, you take a deep breath, inhaling a lungful of its pungent yet sweet scents.  It matches the flower somehow, lingering in your nose even after you pull away.  The smell makes you wonder just how functional the pussy flowers are, they do have fairly large stalks.\n\nYou sigh and take one last sniff from the flower's honeypot before moving on.  Your body flushes happily with desire as your blood pools in your groin.  You giggle, wishing you could feel like this more often.", false);
							dynStats("lus", 20 + player.lib / 5, "cor", .5);
						}
						//vines...
						if (temp2 == 1) {
							outputText("A few vines dangling from the trees catch your eye due to their rather 'unique' tips.  Every single one of them ends in a flared mushroom-like head, each twice as wide as the already thick vine.  You touch a vine gently, musing at its slippery texture and how similar it would be to a penis if the 'head' were smaller.  You encircle the vine with your hand, stroking it and giggling at the absurdity of this place.  The vine suddenly flexes in your grasp, pulsating and contracting as it's head grows bigger, turning shiny and red.  Pulling away in shock, you gasp as the vine begins spurting out huge ropes of thick viscous fluid, splattering everywhere.  The plant-gasm ends as suddenly as it started, the 'head' retaining the size it gained and dripping the last of its strange load.  Overcome with curiosity, you sniff at the dripping spunk and swoon at the overpoweringly musky scent.  Gathering your wits, you decide to leave before you end up with one of those inside you.  You escape the corrupted glade, but stay flush with arousal.", false);
							dynStats("lus", 20 + player.lib / 5, "cor", .5);
						}
						//trees...
						if (temp2 == 2) {
							outputText("A cluster of huge breast-like knots on a nearby tree draws your attention.  Unable to resist, you poke one, and burst into giggles as it jiggles like a real breast!  You cautiously begin groping the tree-tit, and smile as it begins leaking sweet-smelling sap.  The scent conjures memories of helping to make maple syrup back home, and before you realize it, you've gathered a drop of the sap on your finger and tasted it.  It's powerfully sweet, making your tongue tingle and heart beat faster.  Unbidden, the thought of suckling the teat dry of its sweet treat comes to mind, but you manage to reject it and stumble away from the corrupted glade.  You have trouble with your tongue for the next hour: it won't stay in your mouth, and keeps licking your lips, seeking any leftover sweetness.  It almost distracts you from the palpable heat gathering between your thighs.", false);
							dynStats("lus", 20 + player.lib / 5, "cor", .5);
						}
						doNext(13);
						return;
					}
					//drink sap/lick flower reaction
					if (player.cor > 66 && player.cor <= 100) {
						outputText("  You smile as you enter the glade, wondering which of the forbidden fruits you should try...\n\nThere are flowers that bear more than a passing resemblance to pussies,\nvines with absurdly large penis-like tips,\nand trees covered in breast-like knots, leaking sap.", false);
						simpleChoices("Flowers", 2012, "Vines", 2013, "Trees", 2084, "", 0, "Leave", 13);
						return;
					}
					//Wallow in decadence reaction - UNFINISHED
				}
				//Trip on a root!
				if (temp == 3) {
					outputText("You trip on an exposed root, scraping yourself somewhat, but otherwise the hour is uneventful.", false);
					player.takeDamage(10);
					doNext(13);
					trace("FIX MEEEEE");
					return;
				}
			}
			//Bee-girl encounter
			if (chooser == 3) {
				if (rand(10) == 0) {
					menuLoc = 2;
					kGAMECLASS.rathazul.carapaceFind();
					return;
				}
				beeGirlScene.beeEncounter();
			}
		}
		//[FOREST]
//[RANDOM SCENE IF CHARACTER HAS AT LEAST ONE COCK LARGER THAN THEIR HEIGHT, AND THE TOTAL COMBINED WIDTH OF ALL THEIR COCKS IS TWELVE INCHES OR GREATER]
		internal function bigJunkForestScene(lake:Boolean = false):void
		{
			outputText("", true);
			var x:Number = player.longestCock();

			//PARAGRAPH 1
			outputText("Walking along the ", false);
			if (lake) outputText("grassy and muddy shores of the lake", false);
			else outputText("various paths of the forest", false);
			outputText(", you find yourself increasingly impeded by the bulk of your " + cockDescript(x) + " dragging along the ", false);
			if (lake) outputText("wet ground behind you.", false);
			else outputText("earth behind you.", false);
			if (player.cocks.length == 1) {
				if (lake) outputText("  As it drags through the lakeside mud, the sensation forces you to imagine the velvety folds of a monstrous pussy sliding along the head of your " + Appearance.cockNoun(player.cocks[x].cockType) + ", gently attempting to suck it off.", false);
				else outputText("  As it drags across the grass, twigs, and exposed tree roots, the sensation forces you to imagine the fingers of a giant hand sliding along the head of your " + Appearance.cockNoun(player.cocks[x].cockType) + ", gently jerking it off.", false);
			}
			else if (player.cocks.length >= 2) {
				if (lake) outputText("  With all of your " + multiCockDescriptLight() + " dragging through the mud, they begin feeling as if the lips of " + num2Text(player.cockTotal()) + " different cunts were slobbering over each one.", false);
				else outputText("  With all of your " + multiCockDescriptLight() + " dragging across the grass, twigs, and exposed tree roots, they begin feeling as if the rough fingers of " + num2Text(player.cockTotal()) + " different monstrous hands were sliding over each shaft, gently jerking them off.", false);
			}
			outputText("\n\n", false);

			//PARAGRAPH 2
			//FOR NON-CENTAURS]
			if (!player.isTaur()) {
				outputText("The impending erection can't seem to be stopped.  Your sexual frustration forces stiffness into your " + multiCockDescriptLight() + ", which forces your torso to the ground.  Normally your erection would merely raise itself skyward, but your genitals have grown too large and heavy for your " + hipDescript() + " to hold them aloft.  Instead, you feel your body forcibly pivoting at the hips until your torso is compelled to rest face down atop your " + multiCockDescriptLight() + ".", false);
				//IF CHARACTER HAS GIANT BREASTS ADD SENTENCE
				if (player.biggestTitSize() >= 35) {
					if (lake) outputText("  Your " + chestDesc() + " hang lewdly off your torso to rest in the lakeside mud, covering much of the ground to either side of you.  Their immense weight anchors your body, further preventing your torso from lifting itself up.  Mud cakes against their undersides and coats your " + nippleDescript(0) + "s.", false);
					else outputText("  Your " + chestDesc() + " hang lewdly off your torso to rest on the twings and dirt, covering up much of the ground to either side of you.  Their immense weight anchors your body, further preventing your torso from lifting itself up.  The rough texture of the bark on various tree roots teases your " + nippleDescript(0) + "s mercilessly.", false);
				}
				//IF CHARACTER HAS A BALLS ADD SENTENCE
				if (player.balls > 0) {
					outputText("  Your " + player.skinTone + sackDescript() + " rests beneath your raised " + buttDescript() + ".  Your " + ballsDescriptLight() + " pulse with the need to release their sperm through your " + multiCockDescriptLight() + " and ", false);
					if (lake) outputText("into the waters of the nearby lake.", false);
					else outputText("onto the fertile soil of the forest.", false);
				}
				//IF CHARACTER HAS A VAGINA ADD SENTENCE
				if (player.vaginas.length >= 1) {
					outputText("  Your " + vaginaDescript() + " and " + clitDescript() + " are thoroughly squashed between the bulky flesh where your male genitals protrude from between your hips and the " + buttDescript() + " above.", false);
					//IF CHARACTER HAS A DROOLING PUSSY ADD SENTENCE
					if (player.vaginas[0].vaginalWetness >= VAGINA_WETNESS_DROOLING) {
						outputText("  Juices stream from your womanhood and begin pooling on the dirt and twigs beneath you.  ", false);
						if (lake) outputText("The drooling fem-spunk only makes the ground more muddy.", false);
						else outputText("The sticky fem-spunk immediately soaks down into the rich soil.", false);
					}
				}
			}
			//FOR CENTAURS
			else if (player.lowerBody == LOWER_BODY_TYPE_CENTAUR) {
				outputText("  The impending erection can't seem to be stopped.  Your sexual frustration forces stiffness into your " + multiCockDescriptLight() + ", which forces the barrel of your horse-like torso to the ground.  Normally your erection would merely hover above the ground in between your centaurian legs, but your genitals have grown too large and heavy for your " + hipDescript() + " to hold them aloft.  Instead, you feel your body forcibly pulled down at your hind legs until your equine body is resting on top of your " + multiCockDescriptLight() + ".", false);
				//IF CHARACTER HAS GIANT BREASTS ADD SENTENCE
				if (player.biggestTitSize() >= 35) {
					if (lake) outputText("  Your " + chestDesc() + " pull your human torso forward until it also is forced to face the ground, obscured as it is in boob-flesh.  Your tits rest on the wet earth to either side of you.  Their immense weight anchors you, further preventing any part of your equine body from lifting itself up.  Mud cakes their undersides and coats your " + nippleDescript(0) + "s.", false);
					else outputText("  Your " + chestDesc() + " pull your human torso forward until it also is forced to face the ground, obscured as it is in boob-flesh.  Your tits rest on the dirt and twigs to either side of you.  Their immense weight anchors you, further preventing any part of your equine body from lifting itself up.  The rough texture of the bark on various tree roots teases your " + nippleDescript(0) + "s mercilessly.", false);
				}
				//IF CHARACTER HAS A BALLS ADD SENTENCE
				if (player.balls > 0) {
					outputText("  Your " + player.skinTone + sackDescript() + " rests beneath your raised " + buttDescript() + ".  Your " + ballsDescriptLight() + " pulse with the need to release their sperm through your " + multiCockDescriptLight() + " and ", false);
					if (lake) outputText("into the waters of the nearby lake.", false);
					else outputText("onto the fertile soil of the forest floor.", false);
				}
				//IF CHARACTER HAS A VAGINA ADD SENTENCE
				if (player.vaginas.length >= 1) {
					outputText("  Your " + vaginaDescript() + " and " + clitDescript() + " are thoroughly squashed between the bulky flesh where your male genitals protrude from between your hips and the " + buttDescript() + " above.", false);
					//IF CHARACTER HAS A DROOLING PUSSY ADD SENTENCE
					if (player.vaginas[0].vaginalWetness >= VAGINA_WETNESS_DROOLING) {
						if (lake) outputText("  A leaf falls from a tree and lands on the wet lips of your cunt, its light touch teasing your sensitive skin.  Like a mare or cow in heat, your juices stream from your womanhood and pool in the mud beneath you.  The sloppy fem-spunk only makes the ground more muddy.", false);
						else outputText("  A leaf falls from a tree and lands on the wet lips of your cunt, its light touch teasing your sensitive skin.  Like a mare or cow in heat, your juices stream from your womanhood and pool in the dirt and twigs beneath you.", false);
					}
				}
			}
			outputText("\n\n", false);
			//PARAGRAPH 3
			outputText("You realize you are effectively trapped here by your own body.", false);
			//CORRUPTION BASED CHARACTER'S VIEW OF SITUATION
			if (player.cor < 33) outputText("  Panic slips into your heart as you realize that if any dangerous predator were to find you in this state, you'd be completely defenseless.  You must find a way to regain your mobility immediately!", false);
			else if (player.cor < 66) outputText("  You realize that if any dangerous predator were to find you in this state, you'd be completely defenseless!  You must find a way to regain your mobility... yet there is a certain appeal to imagining how pleasurable it would be for a sexual predator to take advantage of your obscene body.", false);
			else outputText("  Your endowments have rendered you completely helpless should any predators find you.  Somewhere in your heart, you find this prospect almost exhilarating.  The idea of being a helpless fucktoy for a wandering beast is unusually inviting to you.  Were it not for the thought that you might starve to death, you'd be incredibly tempted to remain right where you are.", false);


			if (lake) {
				//SCENE END = IF CHARACTER HAS FULL WINGS ADD SENTENCE
				if (player.canFly()) outputText("  You extend your wings and flap as hard as you can until at last, you manage to lighten the bulk of your body.  It helps just enough to let you drag your genitals out of the mud and back to camp.  The ordeal takes nearly an hour for you to return and deal with.", false);
				//Taurs
				else if (player.lowerBody == LOWER_BODY_TYPE_CENTAUR) outputText("  You struggle and work your equine legs against the wet ground.  Your " + player.feet() + " have consistent trouble finding footing as the mud fails to provide enough leverage to lift your bulk.  You breath in deeply and lean side to side, trying to find some easier vertical leverage beneath your feet.  Eventually, with a crude crawl, your centaur legs manages to push the bulk of your body onto more solid ground.  With great difficulty, you spend the next hour shuffling your genitals back to camp.", false);
				//SCENE END = FOR ALL OTHER CHARACTERS
				else outputText("  You struggle and push with your " + player.legs() + " as hard as you can, but it's no use.  You do the only thing you can and begin stroking your " + multiCockDescriptLight() + " with as much vigor as you can muster.  Eventually, your body tenses and a light load of jizz erupts from your body, but the orgasm is truly mild compared to what you need.  You're far too weary from struggling to give yourself the masturbation you truly need, but you continue to try.  Nearly an hour later, " + sMultiCockDesc() + " has softened enough to allow you to stand again, and you make your way back to camp, still dragging your genitals through the mud.", false);
			}
			else {
				//SCENE END = IF CHARACTER HAS FULL WINGS ADD SENTENCE
				if (player.canFly()) outputText("  You extend your wings and flap as hard as you can, until at last, you manage to lighten the bulk of your body.  It helps just enough to let you drag your genitals out of the forest and back to camp.  The ordeal takes nearly an hour for you to return and deal with.", false);
				//SCENE END IF CHARACTER HAS CENTAUR BODY
				else if (player.lowerBody == LOWER_BODY_TYPE_CENTAUR) outputText("  You struggle and work your equine legs against the soft dirt.  Your " + player.feet() + " have consistent trouble finding footing as the ground fails to provide enough leverage to lift your bulk.  You breath in deeply and lean side to side, until eventually, your feet brace against the various roots of the trees around you.  With a crude crawl, your centaur legs manage to shuffle your body and genitals out of the forest and back to camp.", false);
				//SCENE END = FOR ALL OTHER CHARACTERS
				else outputText("  You struggle and push with your " + player.legs() + " as hard as you can, but it's no use.  You do the only thing you can and begin stroking your " + multiCockDescriptLight() + " with as much vigor as you can muster.  Eventually, your body tenses and a light load of jizz erupts from your loins, but the orgasm is truly mild compared to what you need.  You're far too weary from struggling to give yourself the masturbation you truly need, but you continue to try.  Nearly an hour later, " + sMultiCockDesc() + " has softened enough to allow you to stand again, and you make your way back to camp, still dragging your genitals across the forest floor.", false);
			}
			dynStats("lus", 25 + rand(player.cor / 5), "resisted", false);
			fatigue(5);
			doNext(13);
		}
		//Catch a Satyr using the corrupt glade and either leave or have your way with him.
		//Suggested to Fen as the MaleXMale submission.
		//Will be standalone
		private function trappedSatyr():void {
			outputText("", true);
			spriteSelect(99);
			outputText("As you wander through the woods, you find yourself straying into yet another corrupt glade.  However, this time the perverse grove isn't unoccupied; loud bleatings and brayings of pleasure split the air, and as you push past a bush covered in dripping, glans-shaped berries, you spot the source.\n\n", false);

			outputText("A humanoid figure with a set of goat-like horns and legs - a satyr - is currently buried balls-deep in one of the vagina-flowers that scatter the grove, whooping in delight as he hungrily pounds into its ravenously sucking depths.  He stops on occasion to turn and take a slobbering suckle from a nearby breast-like growth; evidently, he doesn't care that he's stuck there until the flower's done with him.\n\n", false);

			//(Player lacks a penis:
			if(!player.hasCock()) {
				outputText("You can't really see any way to take advantage of this scenario, so you simply turn back and leave the way you came.", false);
				doNext(13);
			}
			//Player returns to camp)
			//(Player has penis:
			else {
				outputText("You can see his goat tail flitting happily above his tight, squeezable asscheeks, the loincloth discarded beside him failing to obscure his black cherry, ripe for the picking.  Do you take advantage of his distraction and ravage his ass while he's helpless?\n\n", false);
				//[Yes] [No]
				simpleChoices("Ravage",rapeSatyr,"",0,"",0,"",0,"Leave",ignoreSatyr);
			}
		}

		//[=No=]
		private function ignoreSatyr():void {
			outputText("", true);
			spriteSelect(99);
			outputText("You shake your head, ", false);
			if(player.cor < 50) outputText("disgusted by the strange thoughts this place seems to put into your mind", false);
			else outputText("not feeling inclined to rape some satyr butt right now", false);
			outputText(", and silently leave him to his pleasures.", false);
			dynStats("lus", 5+player.lib/20);
			doNext(13);
		}
		//Player returns to camp
		private function rapeSatyr():void {
			outputText("", true);
			spriteSelect(99);
			var x:Number = player.biggestCockIndex();

			//(Low Corruption)
			if(player.cor < 33) outputText("For a moment you hesitate... taking someone from behind without their consent seems wrong... but then again you doubt a satyr would pass on the opportunity if you were in his position.", false);
			//(Medium Corruption)
			else if(player.cor < 66) outputText("You smirk; normally you would have given this some thought, but the idea of free booty is all you need to make a decision.", false);
			//High Corruption
			else outputText("You grin; this is not even a choice!  Passing on free anal is just not something a decent person does, is it?", false);

			outputText("  You silently strip your " + player.armorName + " and ", false);
			if(player.isNaga()) outputText("slither", false);
			else outputText("sneak", false);

			outputText(" towards the distracted satyr; stopping a few feet away, you stroke your " + cockDescript(x) + ", urging it to full erection and coaxing a few beads of pre, which you smear along your " + cockHead(x) + ".  With no warning, you lunge forward, grabbing and pulling his hips towards your " + cockDescript(x) + " and shoving as much of yourself inside his tight ass as you can.\n\n", false);

			outputText("The satyr lets out a startled yelp, struggling against you, but between his awkward position and the mutant flower ravenously sucking on his sizable cock, he's helpless.\n\n", false);

			outputText("You slap his butt with a open palm, leaving a clear mark on his taut behind.  He bleats, bucking wildly, but this serves only to slam his butt into your crotch until the flower hungrily sucks him back, sliding him off your prick.  You smile as a wicked idea hits you; you hit his ass again and again, making him buck into your throbbing " + Appearance.cockNoun(player.cocks[x].cockType) + ", while the flower keeps pulling him back inside; effectively making the satyr fuck himself.\n\n", false);

			outputText("Eventually, his bleating and screaming start to annoy you, so you silence him by grabbing at his horns and shoving his head to the side, into one of the breast-like growths nearby.  The satyr unthinkingly latches onto the floral nipple and starts to suckle, quieting him as you hoped.  You're not sure why, but he starts to voluntarily buck back and forth between you and the flower; maybe he's getting into the spirit of things, or maybe the vegetal teat he's pulling on has introduced an aphrodisiac chemical after so many violent attempts to pull out of the kindred flower.\n\n", false);

			outputText("You resolve not think about it right now and just enjoy pounding the satyr's ass.  With his bucking you're able to thrust even farther into his tight puckered cherry, ", false);
			if(player.cockArea(x) >= 100) outputText("stretching it all out of normal proportion and ruining it for whomever might happen to use it next.", false);
			else outputText("stretching it to fit your " + cockDescript(x) + " like a condom.", false);
			outputText("  Your groin throbs, ", false);
			if(player.balls > 0) outputText("your balls churn, ", false);
			outputText("and you grunt as you feel the first shots of cum flowing along " + sMultiCockDesc() + ", only to pour out into", false);
			if(player.cockTotal() > 1) outputText(" and onto", false);
			outputText(" the satyr's abused ass; you continue pounding him even as you climax, causing rivulets of cum to run down his cheeks and legs.\n\n", false);

			outputText("Still slurping obscenely on the fake breast, the satyr groans and murmurs; you're not sure how much of a role the sap he's swallowing or the cunt-flower on his cock is playing, but it looks like he's actually enjoying himself now.", false);

			//(Low Cum Amount)
			if(player.cumQ() < 250) outputText("  As much as you'd love to fill his belly so full of spunk he'd look pregnant, you just can't muster any more, and pull out with a sigh.\n\n", false);
			//(Medium Cum Amount)
			else if(player.cumQ() < 1000) outputText("  You cum and cum, filling every crevice of his anal passage with warm jism, the slutty goatman doesn't seem to mind this in the least.  When you're finally spent, you pull out with a sigh, and watch as your cum backflows out of his ass to fall on the grass below.\n\n", false);
			//(Large Cum Amount)
			else outputText("  You cum and cum, filling every crevice of his anal passage with warm jism, and the slutty goatman doesn't seem to mind this in the least - yet.  You push him to his limits; cum backflows out of his ass and around your spewing prick, but still you dump more and more of your heavy load inside your now-willing cock-sleeve, inflating his belly like a balloon.  When you're finally spent, you pull out with a sigh and look at your handiwork; cum pours out of his ass like an open tap and his belly is absolutely bulging, making him look pregnant.\n\n", false);

			outputText("The satyr is too absorbed in his own fucking of the plant-pussy, and his nursing of the tree boob to bewail your absence", false);
			if(player.cumQ() >= 1000) outputText(", although his eyes have widened perceptibly along with the stretching of his stomach", false);
			outputText(".\n\n", false);

			outputText("You can't help but smile inwardly at the helpless goatman's eagerness, and decide to stick around and watch him a little longer.  It's not everyday you see a creature like him at your mercy.  Every once in awhile you egg him on with a fresh slapping of his butt. The satyr grumbles and huffs, but continues to thrust and rut mindlessly into the vegetative pussy feeding on his cock. You don't think it'll be long before he cums...\n\n", false);

			outputText("As you watch the lewd display, you feel your arousal building and your " + cockDescript(x) + " growing back into full mast. Figuring you already have a willing slut readily available, you consider using him to relieve yourself once more... What do you do?", false);
			dynStats("lus=", 0);
			//[Again][Leave]
			simpleChoices("Again",secondSatyrFuck,"",0,"",0,"",0,"Leave",dontRepeatFuckSatyr);
		}

		//[=Leave=]
		private function dontRepeatFuckSatyr():void {
			outputText("", true);
			spriteSelect(99);
			outputText("You've had your fun, and you don't really want to fool around in the forest all day, so you grab your " + player.armorName + " and leave the rutting satyr behind.\n\n", false);
			doNext(13);
		}
		//[=Again=]
		private function secondSatyrFuck():void {
			var x:int = player.cockThatFits(monster.analCapacity());
			if(x < 0) x = player.smallestCockIndex();
			outputText("", true);
			outputText("There's no harm in using the helpless goat once more... This time though, you decide you'll use his mouth.  With a yank on his horns, you forcefully dislodge him from the breast-plant and force him to his knees, turning his head towards you; he doesn't put up much resistance and when you present your erect shaft to him, he licks his lips in excitement and latches onto your " + cockDescript(x) + ".\n\n", false);

			outputText("His mouth is exquisite; it feels slippery and warm and his lips are soft while his tongue wriggles about your shaft, trying to embrace and massage it.  He gloms onto your manhood with eager hunger, desperate to ravish you with his mouth.  Quivers of pleasure ripple and shudder through his body as he slobbers and gulps - and no wonder!  From the remnants of sap still in his mouth, you can feel currents of arousal tingling down your cock; if he's been drinking it straight, his mouth must be as sensitive as a cunt from the effects of this stuff.\n\n", false);

			outputText("Having had your first orgasm mere minutes ago, you don't last long.  Within a few moments of his beginning you flood his mouth with a second load of cum, pulling out to paint his face with the last couple jets.\n\n", false);

			outputText("With a great, garbled cry, the satyr cums on his own, gurgling through the sap-tinted cum drooling from his mouth as he spews into the waiting opening of his rapacious plant lover.  It swells and bloats as it gorges itself on his thick, stinking seed, stretching its stem until it is almost spherical, finally releasing him to collapse on his knees, free at last of the plant's grip.  He moans and bleats softly, leaking cummy sap from his chin onto his hairy chest, too overwhelmed by the combined fucking of yourself and the flower and too poisoned by whatever aphrodisiac he's been slurping on to move.\n\n", false);

			outputText("You give your sensitive member a few trembling, almost-painful strokes... maybe you overdid it a bit.  Shrugging, you gather your " + player.armorName + " and leave the passed-out satyr behind as you go back to your camp.", false);
			dynStats("lib", 1, "sen", -5, "lus=", 0);
			doNext(13);
		}
	}
}
