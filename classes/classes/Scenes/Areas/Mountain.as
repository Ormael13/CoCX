/**
 * Created by aimozg on 06.01.14.
 */
package classes.Scenes.Areas
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Scenes.Areas.Mountain.*;
	import classes.Scenes.Monsters.Goblin;
	import classes.Scenes.Monsters.Imp;
	import classes.Scenes.Quests.UrtaQuest.MinotaurLord;

	use namespace kGAMECLASS;

	public class Mountain extends BaseContent
	{
		public var hellHoundScene:HellHoundScene = new HellHoundScene();
		public var infestedHellhoundScene:InfestedHellhoundScene = new InfestedHellhoundScene();
		public var minotaurScene:MinotaurScene = new MinotaurScene();
		public var wormsScene:WormsScene = new WormsScene();
		public var salon:Salon = new Salon();
		
		public function Mountain()
		{
		}
		//Explore Mountain
		public function exploreMountain():void
		{
			player.exploredMountain++;
			var chooser:Number = rand(5);
			if (chooser == 5 && player.level < 3 && model.time.days < 20) //Disable mimic if requirements not met (Can still be encountered in level 1 run)
				chooser = rand(4);
			//Helia monogamy fucks
			if (flags[kFLAGS.PC_PROMISED_HEL_MONOGAMY_FUCKS] == 1 && flags[kFLAGS.HEL_RAPED_TODAY] == 0 && rand(10) == 0 && player.gender > 0 && !kGAMECLASS.helScene.followerHel()) {
				kGAMECLASS.helScene.helSexualAmbush();
				return;
			}
			//Discover 'high mountain' at level 5 or 40 explores of mountain
			if ((player.level >= 5 || player.exploredMountain >= 40) && flags[kFLAGS.DISCOVERED_HIGH_MOUNTAIN] == 0) {
				outputText("While exploring the mountain, you come across a relatively safe way to get at its higher reaches.  You judge that with this route you'll be able to get about two thirds of the way up the mountain.  With your newfound discovery fresh in your mind, you return to camp.\n\n(<b>High Mountain exploration location unlocked!</b>)", true);
				flags[kFLAGS.DISCOVERED_HIGH_MOUNTAIN]++;
				doNext(camp.returnToCampUseOneHour);
				return;
			}
			if (isHolidays()) {
				//Gats xmas adventure!
				if (rand(5) == 0 && player.gender > 0 && isHolidays() && flags[kFLAGS.GATS_ANGEL_DISABLED] == 0 && flags[kFLAGS.GATS_ANGEL_GOOD_ENDED] == 0 && (flags[kFLAGS.GATS_ANGEL_QUEST_BEGAN] > 0 && player.hasKeyItem("North Star Key") < 0)) {
					kGAMECLASS.xmas.snowAngel.gatsSpectacularRouter();
					return;
				}
				if (rand(6) == 0 && flags[kFLAGS.JACK_FROST_YEAR] < date.fullYear && silly()) {
					kGAMECLASS.xmas.jackFrost.meetJackFrostInTheMountains();
					return;
				}
			}
			//8% chance of hellhoundsplosions if appropriate
			if (rand(100) <= 77) {
				if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00141] < 3) {
					trace("CHANCE AT HELLHOUND GAO");
					//Requires canine face, [either two dog dicks, or a vag and pregnant with a hellhound], at least two other hellhound features (black fur, dog legs, dog tail), and corruption >=60.
					if (player.faceType == FACE_DOG && (player.dogCocks() >= 2 || (player.hasVagina() && player.pregnancyType == PregnancyStore.PREGNANCY_HELL_HOUND)) && player.cor >= 60 && player.tailType == TAIL_TYPE_DOG && (player.lowerBody == LOWER_BODY_TYPE_DOG || player.hairColor == "midnight black")) {
						trace("PASS BODYCHECK");
						if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00141] == 0) {
							hellHoundScene.HellHoundMasterEncounter();
							return;
						}
						//Level 2 requires lethecite
						else if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00141] == 1 && player.hasKeyItem("Marae's Lethicite") >= 0 && player.keyItemv2("Marae's Lethicite") < 3) {
							hellHoundScene.HellHoundMasterEncounter();
							return;
						}
					}
				}
			}
			//Rarer 'nice' Ceraph encounter
			//Overlaps half the old encounters once pierced.
			if (!kGAMECLASS.ceraphFollowerScene.ceraphIsFollower() && player.level > 2 && (player.exploredMountain % 30 == 0) && flags[kFLAGS.PC_FETISH] > 0) {
				kGAMECLASS.ceraphScene.friendlyNeighborhoodSpiderManCeraph();
				return;
			}
			//15% chance of Ceraph
			if (!kGAMECLASS.ceraphFollowerScene.ceraphIsFollower() && player.level > 2 && (player.exploredMountain % 15 == 0) && flags[kFLAGS.PC_FETISH] != 1) {
				kGAMECLASS.ceraphScene.encounterCeraph();
				return;
			}
			//10% chance of hairdresser encounter if not found yet
			if (rand(10) == 0 && player.findStatusEffect(StatusEffects.HairdresserMeeting) < 0) chooser = 5;
			if ((rand(8) == 0 && flags[kFLAGS.MARAE_QUEST_START] >= 1) && flags[kFLAGS.FACTORY_FOUND] <= 0) {
				trace("Dungeon start!")
				kGAMECLASS.dungeons.enterFactory();
				return;
			}
			//Boosts mino and hellhound rates!
			if (player.findPerk(PerkLib.PiercedFurrite) >= 0 && rand(3) == 0) {
				if (rand(2) == 0) chooser = 1;
				else chooser = 3;
			}
			//10% chance to mino encounter rate if addicted
			if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] > 0 && rand(10) == 0) {
				chooser = 1;
			}
			//10% MORE chance for minos if uber-addicted
			if (player.findPerk(PerkLib.MinotaurCumAddict) >= 0 && rand(10) == 0) {
				chooser = 1;
			}
			//Every 15 explorations chance at mino bad-end!
			if (player.exploredMountain % 16 == 0 && player.findPerk(PerkLib.MinotaurCumAddict) >= 0 && rand(3) == 0) {
				spriteSelect(44);
				minotaurScene.minoAddictionBadEndEncounter();
				return;
			}
			//Generic Goblin/Imp encounter
			if (chooser == 0) {
				kGAMECLASS.exploration.genericGobImpEncounters();
			}
			//Minotauuuuur
			if (chooser == 1) {
				spriteSelect(44);
				if (player.findStatusEffect(StatusEffects.TF2) < 0 && player.level <= 1 && player.str <= 40) {
					if (silly()) {
						//(Ideally, this should occur the first time the player would normally get an auto-rape encounter with the minotaur. The idea is to give a breather encounter to serve as a warning of how dangerous the mountain is)
						outputText("Crossing over the treacherous mountain paths, you walk past an ominous cave.  The bones and the smell of death convince you to hasten your pace.  However, as you walk by, you hear a deep bellow and a snort as a monstrous man with a bull's head steps out.  With hell in his eyes and a giant ax in his hand, he begins to approach you in clear rage.  As he comes out into the light, you see that he is completely naked and sports a monstrous erection as angry as the minotaur himself, freely leaking a steady stream of pre-cum as he stalks you.\n\n", true);
						outputText("You stumble in your attempt to escape and realize that you are completely helpless.  The minotaur towers over you and heaves his ax for a <i>coup de grace</i>.  As he readies the blow, a monstrous explosion rocks the entire mountainside, causing the bull-man to stumble before he can finish you off. You look around, bewildered, trying to understand this strange new turn of events, and notice a group of maybe half a dozen people approaching from further up the path.  They appear to be a motley crew clad in blue and carrying monstrous weapons.  The tallest man holds a weapon made of multiple rotating tubes, and begins spinning the barrels.  A second later, while screaming in a language you do not understand, a rain of lead begins shredding the minotaur into a cloud of blood and flesh.\n\n", false);
						outputText("An equally imposing black man with a patch over one eye begins firing canisters at the beast, which explode violently.  \"<i>Ya ragged-arsed beast man!</i>\" he taunts.  \"<i>Ye should pick on someone yer own size, BOY-O! HEHEHE!</i>\"\n\n", false);
						outputText("Coming up the path next is a freak of a person clad in a contained shiny suit with a weapon that burns with flame.  He freely walks into the explosions and gunfire and begins igniting the beast.\n\n", false);
						outputText("\"<i>MRPHHUMFHRUFH!!!!! HUMFHUFMMRUF!</i>\" the freak mumbles through his mask.\n\n", false);
						outputText("\"<i>I like me steak well done, ye crazy bugger!</i>\" yells the black man.\n\n", false);
						outputText("The beast collapses in a charred and bloody heap.   As you stand back up, you hear a strange noise behind you.  You turn around to find a well-dressed man wearing a ski mask and smoking a cigarette.  \"<i>Don't you know ze mountains are dangereuse,</i>\" the man says with a thick accent.  \"<i>You will get FUCKED up here if you are not careful.</i>\"\n\n", false);
						outputText("You thank the man and his team, but they brush off your gratitude.  \"<i>Non, non!</i>\" the man with the accent says.  \"<i>As zey say, everyone gets ONE.</i>\" With that, he touches the watch on his wrist and disappears.  The rest of the group continues on their way.\n\n", false);
						outputText("As they leave, the giant with the chain gun yells in a horribly accented manner, \"<i>YOU LEAVE SANDVICH ALONE! SANDVICH IS MINE!</i>\"\n\n", false);
						outputText("With that, another hail of bullets break the scene as they walk away, leaving you safe from the minotaur, but utterly baffled as to what in hell just happened.", false);
					}
					else {
						outputText("Crossing over the treacherous mountain paths, you walk past an ominous cave.  The bones and the smell of death convince you to hasten your pace.  However, as you walk by, you hear a deep bellow and a snort as a monstrous man with a bull's head steps out.  With hell in his eyes and a giant ax in his hand, he begins to approach you in clear rage.  As he comes out into the light, you see that he is completely naked and sports a monstrous erection as angry as the minotaur himself, freely leaking a steady stream of pre-cum as he stalks you.\n\n", true);
						outputText("You stumble in your attempt to escape and realize that you are completely helpless.  The minotaur towers over you and heaves his ax for a <i>coup de grace</i>.  As he readies the blow, another beast-man slams into him from the side.  The two of them begin to fight for the honor of raping you, giving you the opening you need to escape.  You quietly sneak away while they fight – perhaps you should avoid the mountains for now?\n\n", false);
					}
					player.createStatusEffect(StatusEffects.TF2, 0, 0, 0, 0);
					doNext(camp.returnToCampUseOneHour);
					return;
				}
				//Mino gangbang
				if (player.findStatusEffect(StatusEffects.MinoPlusCowgirl) < 0 || rand(10) == 0) {
					if (flags[kFLAGS.HAS_SEEN_MINO_AND_COWGIRL] == 1 && player.cowScore() >= 4 && player.lactationQ() >= 200 && player.biggestTitSize() >= 3 && player.minotaurAddicted()) {
						//PC must be a cowmorph (horns, legs, ears, tail, lactating, breasts at least C-cup)
						//Must be addicted to minocum
						outputText("As you pass a shadowy cleft in the mountainside, you hear the now-familiar call of a cowgirl echoing from within.  Knowing what's in store, you carefully inch closer and peek around the corner.");
						outputText("\n\nTwo humanoid shapes come into view, both with pronounced bovine features - tails, horns and hooves instead of feet.  Their genders are immediately apparent due to their stark nudity.  The first is the epitome of primal femininity, with a pair of massive, udder-like breasts and wide child-bearing hips. The other is the pinnacle of masculinity, with a broad, muscular chest, a huge horse-like penis and a heavy set of balls more appropriate on a breeding stud than a person.  You have once again stumbled upon a cow-girl engaging in a not-so-secret rendezvous with her minotaur lover.");
						if (flags[kFLAGS.CODEX_ENTRY_MINOTAURS] <= 0) {
							flags[kFLAGS.CODEX_ENTRY_MINOTAURS] = 1;
							outputText("<b>New codex entry unlocked: Minotaurs!</b>\n\n")
						}
						if (flags[kFLAGS.CODEX_ENTRY_LABOVINES] <= 0) {
							flags[kFLAGS.CODEX_ENTRY_LABOVINES] = 1;
							outputText("<b>New codex entry unlocked: Lacta Bovines/Cowgirl!</b>\n\n")
						}
						outputText("\n\nYou settle in behind an outcropping, predicting what comes next.  You see the stark silhouettes of imps and goblins take up similar positions around this makeshift theatre, this circular clearing surrounded on the edge by boulders and nooks where all manner of creatures might hide. You wonder if they're as eager for the upcoming show as you are.  The heady scent of impending sex rises in the air... and with it comes something masculine, something that makes your stomach rumble in anticipation.  The mouth-watering aroma of fresh minotaur cum wafts up to your nose, making your whole body quiver in need.  Your [vagOrAss] immediately ");
						if (player.hasVagina()) outputText("dampens");
						else outputText("twinges");
						outputText(", aching to be filled");
						if (player.hasCock()) outputText(", while [eachCock] rises to attention, straining at your [armor]");
						outputText(".");

						outputText("\n\nYou can barely see it from your vantage point, but you can imagine it: the semi-transparent pre-cum dribbling from the minotaur's cumslit, oozing down onto your tongue.  Your entire body shivers at the thought, whether from disgust or desire you aren't sure.  You imagine your lips wrapping around that large equine cock, milking it for all of its delicious cum.  Your body burns hot like the noonday sun at the thought, hot with need, with envy at the cow-girl, but most of all with arousal.");

						outputText("\n\nSnapping out of your imaginative reverie, you turn your attention back to the show. You wonder if you could make your way over there and join them, or if you should simply remain here and watch, as you have in the past.");
						menu();
						//[Join] [Watch]
						addButton(0, "Join", minotaurScene.joinBeingAMinoCumSlut);
						addButton(1, "Watch", minotaurScene.watchAMinoCumSlut);
						return;
					}
					flags[kFLAGS.HAS_SEEN_MINO_AND_COWGIRL] = 1;
					if (player.findStatusEffect(StatusEffects.MinoPlusCowgirl) < 0) player.createStatusEffect(StatusEffects.MinoPlusCowgirl, 0, 0, 0, 0);
					else player.addStatusValue(StatusEffects.MinoPlusCowgirl, 1, 1);
					outputText("As you pass a shadowy cleft in the mountainside, you hear the sounds of a cow coming out from it. Wondering how a cow got up here, but mindful of this land's dangers, you cautiously sneak closer and peek around the corner.\n\n", true);
					outputText("What you see is not a cow, but two large human-shaped creatures with pronounced bovine features -- tails, horns, muzzles, and hooves instead of feet. They're still biped, however, and their genders are obvious due to their stark nudity. One has massive, udder-like breasts and wide hips, the other a gigantic, horse-like dong and a heavy set of balls more appropriate to a breeding stud than a person. You've stumbled upon a cow-girl and a minotaur.\n\n", false);
					if (flags[kFLAGS.CODEX_ENTRY_MINOTAURS] <= 0) {
						flags[kFLAGS.CODEX_ENTRY_MINOTAURS] = 1;
						outputText("<b>New codex entry unlocked: Minotaurs!</b>\n\n")
					}
					if (flags[kFLAGS.CODEX_ENTRY_LABOVINES] <= 0) {
						flags[kFLAGS.CODEX_ENTRY_LABOVINES] = 1;
						outputText("<b>New codex entry unlocked: Lacta Bovines/Cowgirl!</b>\n\n")
					}
					outputText("A part of your mind registers bits of clothing tossed aside and the heady scent of impending sex in the air, but your attention is riveted on the actions of the pair. The cow-girl turns and places her hands on a low ledge, causing her to bend over, her ample ass facing the minotaur. The minotaur closes the distance between them in a single step.\n\n", false);
					outputText("She bellows, almost moaning, as the minotaur grabs her cushiony ass-cheeks with both massive hands. Her tail raises to expose a glistening wet snatch, its lips already parted with desire. She moos again as his rapidly hardening bull-cock brushes her crotch. You can't tear your eyes away as he positions himself, his flaring, mushroom-like cock-head eliciting another moan as it pushes against her nether lips.\n\n", false);
					outputText("With a hearty thrust, the minotaur plunges into the cow-girl's eager fuck-hole, burying himself past one -- two of his oversized cock's three ridge rings. She screams in half pain, half ecstasy and pushes back, hungry for his full length. After pulling back only slightly, he pushes deeper, driving every inch of his gigantic dick into his willing partner who writhes in pleasure, impaled exactly as she wanted.\n\n", false);
					outputText("The pair quickly settles into a rhythm, punctuated with numerous grunts, groans, and moans of sexual excess. To you it's almost a violent assault sure to leave both of them bruised and sore, but the cow-girl's lolling tongue and expression of overwhelming desire tells you otherwise. She's enjoying every thrust as well as the strokes, gropes, and seemingly painful squeezes the minotaur's powerful hands deliver to her jiggling ass and ponderous tits. He's little better, his eyes glazed over with lust as he continues banging the fuck-hole he found and all but mauling its owner.", false);
					doNext(minotaurScene.continueMinoVoyeurism);
					return;
				}
				//Cum addictus interruptus!  LOL HARRY POTTERFAG
				//Withdrawl auto-fuck!
				if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 3 && rand(2) == 0 && player.inte/10 + rand(20) < 15) {
					minotaurScene.minoAddictionFuck();
					return;
				}
				//Rare Minotaur Lord
				if (rand(5) == 0 && player.level >= 10) {
					outputText("Minding your own business, you walk along the winding paths.  You take your time to enjoy the view until you see a shadow approaching you.  You turn around to see a minotaur!  However, he is much bigger than the other minotaurs you've seen.  You estimate him to be eleven feet tall and he's wielding a chain-whip.  He's intent on raping you!", true);
					startCombat(new MinotaurLord());
					return;
				}
				minotaurScene.getRapedByMinotaur(true);
				spriteSelect(44);
			}
			//Worms
			if (chooser == 2) {
				//If worms are on and not infested.
				if (player.findStatusEffect(StatusEffects.WormsOn) >= 0 && player.findStatusEffect(StatusEffects.Infested) < 0) {
					if (player.findStatusEffect(StatusEffects.WormsHalf) >= 0 && rand(2) == 0) {
						if (player.cor < 90) {
							outputText("Your hike in the mountains, while fruitless, reveals pleasant vistas and provides you with good exercise and relaxation.", true);
							dynStats("tou", .25, "spe", .5, "lus", player.lib / 10 - 15);
						}
						else {
							outputText("During your hike into the mountains, your depraved mind keeps replaying your most obcenely warped sexual encounters, always imagining new perverse ways of causing pleasure.\n\nIt is a miracle no predator picked up on the strong sexual scent you are emitting.", true);
							dynStats("tou", .25, "spe", .5, "lib", .25, "lus", player.lib / 10);
						}
						doNext(camp.returnToCampUseOneHour);
						return;
					}
					wormsScene.wormEncounter();
				}
				else {
					//If worms are off or the PC is infested, no worms.
					if (player.findStatusEffect(StatusEffects.WormsOff) >= 0 || player.findStatusEffect(StatusEffects.Infested) >= 0 || (rand(2) == 0 && player.findStatusEffect(StatusEffects.WormsHalf) >= 0)) {
						if (player.findStatusEffect(StatusEffects.WormsOff) >= 0 && player.findStatusEffect(StatusEffects.MetWorms) < 0) {
							wormsScene.wormEncounter(); //You can only encounter the worms once.
							return;
						}
						if (player.cor < 90) {
							outputText("Your hike in the mountains, while fruitless, reveals pleasant vistas and provides you with good exercise and relaxation.", true);
							dynStats("tou", .25, "spe", .5, "lus", player.lib / 10 - 15);
						}
						else {
							outputText("During your hike into the mountains, your depraved mind keeps replaying your most obcenely warped sexual encounters, always imagining new perverse ways of causing pleasure.\n\nIt is a miracle no predator picked up on the strong sexual scent you are emitting.", true);
							dynStats("tou", .25, "spe", .5, "lib", .25, "lus", player.lib / 10);
						}
						doNext(camp.returnToCampUseOneHour);
					}
					else {
						wormsScene.wormToggle();
					}
				}
			}
			//Hellhound
			if (chooser == 3) {
				spriteSelect(27);
				if (player.findStatusEffect(StatusEffects.WormsOn) >= 0 && rand(2) == 0) {
					//If lowered encounter rate, 25% chance, otherwise 50%.
					if (player.findStatusEffect(StatusEffects.WormsHalf) >= 0 && rand(2) == 0) {
						hellHoundScene.hellhoundEncounter();
						return;
					}
					infestedHellhoundScene.infestedHellhoundEncounter();
					return;
				}
				hellHoundScene.hellhoundEncounter();
			}
			//Mimic
			if (chooser == 4) {
				getGame().mimicScene.mimicTentacleStart(2);
			}
			//Hairdresser
			if (chooser == 5) {
				salon.hairDresser();
			}
		}
		
		private function findOre():void { //Not used. Doubt if it will ever be added.
			var ore:int = rand(3); //0 = copper, 1 = tin, 2 = iron
		}
	}
}
