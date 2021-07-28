/**
 * Created by aimozg on 06.01.14.
 */
package classes.Scenes.Areas
{
import classes.*;
import classes.BodyParts.Face;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.BodyParts.Tongue;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.API.Encounters;
import classes.Scenes.API.FnHelpers;
import classes.Scenes.API.GroupEncounter;
import classes.Scenes.Areas.Mountain.*;
import classes.Scenes.Holidays;
import classes.Scenes.Monsters.DarkElfScene;
import classes.Scenes.NPCs.DivaScene;
import classes.Scenes.Quests.UrtaQuest.MinotaurLord;
import classes.Scenes.SceneLib;

public class Mountain extends BaseContent
	{
		public var hellHoundScene:HellHoundScene = new HellHoundScene();
		public var infestedHellhoundScene:InfestedHellhoundScene = new InfestedHellhoundScene();
		public var minotaurScene:MinotaurScene = new MinotaurScene();
		public var wormsScene:WormsScene = new WormsScene();
		public var salon:Salon = new Salon();
		public var darkelfScene:DarkElfScene = new DarkElfScene();
		
		public function Mountain()
		{
			onGameInit(init);
		}
		private var explorationEncounter:GroupEncounter = null;
		private function init():void {
			const game:CoC     = CoC.instance;
			const fn:FnHelpers = Encounters.fn;
			explorationEncounter =
					Encounters.group(/*game.commonEncounters.withImpGob,*/{
						//General Golems, Goblin and Imp Encounters
						name: "common",
						call: SceneLib.exploration.genericGolGobImpEncounters
					}, {
						//Helia monogamy fucks
						name  : "helcommon",
						call  : SceneLib.helScene.helSexualAmbush,
						chance: 0.2,
						when  : SceneLib.helScene.helSexualAmbushCondition
					}, {
						name  : "etna",
						when  : function():Boolean {
							return flags[kFLAGS.ETNA_FOLLOWER] < 1
								   && flags[kFLAGS.ETNA_TALKED_ABOUT_HER] == 2
								   && !player.hasStatusEffect(StatusEffects.EtnaOff)
								   && (player.level >= 20);
						},
						chance: 0.5,
						call  : SceneLib.etnaScene.repeatYandereEnc
					}, {
						name  : "alvina1",
						when  : function():Boolean {
							return flags[kFLAGS.ALVINA_FOLLOWER] == 8;
						},
						chance: 0.5,
						call  : SceneLib.alvinaFollower.alvinaSecondEncounter
					}, {
						name  : "alvina2",
						when  : function():Boolean {
							return flags[kFLAGS.ALVINA_FOLLOWER] == 9
								   && flags[kFLAGS.LETHICE_DEFEATED] > 0
								   && !player.hasStatusEffect(StatusEffects.LethiceRedemed);
						},
						chance: 0.5,
						call  : SceneLib.alvinaFollower.alvinaSecondBonusEncounter
					}, {
						name: "salon",
						when: fn.not(salon.isDiscovered),
						call: salon.hairDresser
					},{
						/* [INTERMOD: Revamp]
						name: "mimic",
						when: fn.ifLevelMin(3),
						call: curry(game.mimicScene.mimicTentacleStart,2)
					},{
						*/
						name: "highmountains",
						when: function ():Boolean {
							return !SceneLib.highMountains.isDiscovered()
								   && (player.level >= 15)
						},
						call: SceneLib.highMountains.discover,
						chance: Encounters.ALWAYS
					},{
						name: "snowangel",
						when: function():Boolean {
							return isHolidays()
								   && player.gender > 0
								   && flags[kFLAGS.GATS_ANGEL_DISABLED] == 0
								   && flags[kFLAGS.GATS_ANGEL_GOOD_ENDED] == 0
								   && (flags[kFLAGS.GATS_ANGEL_QUEST_BEGAN] > 0
								   && player.hasKeyItem("North Star Key") < 0)
						},
						call: Holidays.gatsSpectacularRouter
					},{
						name:"jackfrost",
						when: function ():Boolean {
							return isHolidays() && flags[kFLAGS.JACK_FROST_YEAR] < date.fullYear && silly();
						},
						call: Holidays.meetJackFrostInTheMountains
					},{
						name:"hellhound",
						call:hellHoundScene.hellhoundEncounter,
						mods:[SceneLib.exploration.furriteMod]
					},{
						name:"infhhound",
						when: function():Boolean {
							return player.hasStatusEffect(StatusEffects.WormsOn);
						},
						chance:function ():Number {
							return player.hasStatusEffect(StatusEffects.WormsHalf) ? 0.25 : 0.5;
						},
						call:infestedHellhoundScene.infestedHellhoundEncounter,
						mods:[SceneLib.exploration.furriteMod]
					},{
						name:"worms1",
						when: function():Boolean {
							return !player.hasStatusEffect(StatusEffects.WormsOn)
								   && !player.hasStatusEffect(StatusEffects.WormsOff);
						},
						call: wormsScene.wormToggle
					},{
						name:"worms2",
						chance: function ():Number {
							return player.hasStatusEffect(StatusEffects.WormsHalf) ? 0.5 : 1;
						},
						when: function ():Boolean {
							return player.hasStatusEffect(StatusEffects.WormsOn)
								&& !player.hasStatusEffect(StatusEffects.Infested)
								&& !player.isGargoyle();
						},
						call: wormsScene.wormEncounter
					},{
						name:"minotaur",
						chance:minotaurChance,
						call:minotaurRouter,
						mods:[SceneLib.exploration.furriteMod]
					},{
						name:"factory",
						when:function():Boolean {
							return flags[kFLAGS.MARAE_QUEST_START] >= 1 && flags[kFLAGS.FACTORY_FOUND] <= 0;
						},
						call: SceneLib.dungeons.enterFactory
					},{
						name:"ceraph",
						chance:0.7,
						when:function ():Boolean {
							return !SceneLib.ceraphFollowerScene.ceraphIsFollower()
									/* [INTERMOD:8chan]
									&& flags[kFLAGS.CERAPH_KILLED] == 0
									 */
									/*&& game.fetishManager.compare(FetishManager.FETISH_EXHIBITION)*/;
						},
						call:ceraphFn,
						mods:[fn.ifLevelMin(2)]
					},{
						name:"hhound_master",
						chance:2,
						when:function():Boolean {
							//Requires canine face, [either two dog dicks, or a vag and pregnant with a hellhound], at least two other hellhound features (black fur, dog legs, dog tail), and corruption >=60.
							var check1:Boolean = player.faceType == Face.DOG && player.cor >= 60;
							var check2:Boolean = player.dogCocks() >= 2
												 || (player.hasVagina() && player.pregnancyType == PregnancyStore.PREGNANCY_HELL_HOUND);
							var check3:int = (player.tail.type == Tail.DOG ? 1 : 0) +
											 (player.lowerBody == LowerBody.DOG ? 1 : 0) +
											 (player.hairColor == "midnight black" ? 1 : 0);
							var check4a:Boolean = flags[kFLAGS.HELLHOUND_MASTER_PROGRESS] == 0;
							var check4b:Boolean = flags[kFLAGS.HELLHOUND_MASTER_PROGRESS] == 1
												  && player.hasKeyItem("Marae's Lethicite") >= 0
												  && player.keyItemv2("Marae's Lethicite") < 3;
							return flags[kFLAGS.HELLHOUND_MASTER_PROGRESS] < 3
								   && check1 && check2 && check3 && (check4a || check4b);
						},
						call:hellHoundScene.HellHoundMasterEncounter
					}, {
						name: "electra",
						when: function ():Boolean {
							return flags[kFLAGS.ELECTRA_FOLLOWER] < 2 && !player.hasStatusEffect(StatusEffects.ElectraOff) && (player.level >= 20);
						},
						chance:0.5,
						call: function ():void {
							if (flags[kFLAGS.ELECTRA_AFFECTION] < 2) SceneLib.electraScene.firstEnc();
							else {
								if (flags[kFLAGS.ELECTRA_AFFECTION] == 100) {
									if (flags[kFLAGS.ELECTRA_FOLLOWER] == 1) SceneLib.electraScene.ElectraRecruitingAgain();
									else SceneLib.electraScene.ElectraRecruiting();
								}
								else SceneLib.electraScene.repeatMountainEnc();
							}
						}
					}, {
						name: "diva",
						when: function():Boolean {
							return flags[kFLAGS.FACTORY_SHUTDOWN] > 0 && DivaScene.instance.status >= 0 && !player.hasStatusEffect(StatusEffects.DivaOff);
						},
						call: DivaScene.encounter
					},{
						name: "quarry",
						when: function():Boolean {
							return player.statusEffectv2(StatusEffects.ResourceNode1) < 5;
						},
						chance: 4,
						call: camp.cabinProgress.quarrySite
					},{
						name: "darkelf",
						call: darkelfScene.introDarkELfScout
					},{
						name: "derpnade launcher",
						when: function ():Boolean {
							return player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns5) && player.statusEffectv2(StatusEffects.TelAdreTripxiGuns5) == 0 && player.hasKeyItem("Derpnade Launcher") < 0;
						},
						chance: 30,
						call: partsofDerpnadeLauncher
					}, {
						name: "ted",
						when: function():Boolean {
							return flags[kFLAGS.TED_LVL_UP] >= 1 && flags[kFLAGS.TED_LVL_UP] < 4 && !player.hasStatusEffect(StatusEffects.TedOff) && player.statusEffectv1(StatusEffects.CampSparingNpcsTimers4) < 1;
						},
						call: SceneLib.tedScene.introPostHiddenCave
					},{
						name:"hike",
						chance:0.2,
						call:hike
					})
			;
		}
		//Explore Mountain
		public function exploreMountain():void {
			player.exploredMountain++;
			explorationEncounter.execEncounter();
		}
		public function ceraphFn():void {
			//Rarer 'nice' Ceraph encounter
			//Overlaps half the old encounters once pierced.
			if (rand(3) == 0
				/* [INTERMOD:8chan]
				&& kGAMECLASS.fetishManager.compare(FetishManager.FETISH_EXHIBITION)
				else */
				&& flags[kFLAGS.PC_FETISH] > 0 /**/
			) SceneLib.ceraphScene.friendlyNeighborhoodSpiderManCeraph();
			else SceneLib.ceraphScene.encounterCeraph();
		}

		public function minotaurChance():Number {
			if (player.hasPerk(PerkLib.MinotaurCumAddict) || player.hasPerk(PerkLib.LactaBovineImmunity)) return 3;
			if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] > 0) return 2;
			return 1;
		}
		public function minotaurRouter():void {
			//Every 15 explorations chance at mino bad-end!
			if (player.hasPerk(PerkLib.MinotaurCumAddict) && !player.hasPerk(PerkLib.LactaBovineImmunity) && rand(16) == 0) {
				spriteSelect(44);
				minotaurScene.minoAddictionBadEndEncounter();
				return;
			} else {
				spriteSelect(44);
				if (!player.hasStatusEffect(StatusEffects.TF2) && player.level <= 1 && player.str <= 40) {
					if (silly()) {
						//(Ideally, this should occur the first time the player would normally get an auto-rape encounter with the minotaur. The idea is to give a breather encounter to serve as a warning of how dangerous the mountain is)
						clearOutput();
						outputText("Crossing over the treacherous mountain paths, you walk past an ominous cave.  The bones and the smell of death convince you to hasten your pace.  However, as you walk by, you hear a deep bellow and a snort as a monstrous man with a bull's head steps out.  With hell in his eyes and a giant ax in his hand, he begins to approach you in clear rage.  As he comes out into the light, you see that he is completely naked and sports a monstrous erection as angry as the minotaur himself, freely leaking a steady stream of pre-cum as he stalks you.\n\n");
						outputText("You stumble in your attempt to escape and realize that you are completely helpless.  The minotaur towers over you and heaves his ax for a <i>coup de grace</i>.  As he readies the blow, a monstrous explosion rocks the entire mountainside, causing the bull-man to stumble before he can finish you off. You look around, bewildered, trying to understand this strange new turn of events, and notice a group of maybe half a dozen people approaching from further up the path.  They appear to be a motley crew clad in blue and carrying monstrous weapons.  The tallest man holds a weapon made of multiple rotating tubes, and begins spinning the barrels.  A second later, while screaming in a language you do not understand, a rain of lead begins shredding the minotaur into a cloud of blood and flesh.\n\n");
						outputText("An equally imposing black man with a patch over one eye begins firing canisters at the beast, which explode violently.  \"<i>Ya ragged-arsed beast man!</i>\" he taunts.  \"<i>Ye should pick on someone yer own size, BOY-O! HEHEHE!</i>\"\n\n");
						outputText("Coming up the path next is a freak of a person clad in a contained shiny suit with a weapon that burns with flame.  He freely walks into the explosions and gunfire and begins igniting the beast.\n\n");
						outputText("\"<i>MRPHHUMFHRUFH!!!!! HUMFHUFMMRUF!</i>\" the freak mumbles through his mask.\n\n");
						outputText("\"<i>I like me steak well done, ye crazy bugger!</i>\" yells the black man.\n\n");
						outputText("The beast collapses in a charred and bloody heap.   As you stand back up, you hear a strange noise behind you.  You turn around to find a well-dressed man wearing a ski mask and smoking a cigarette.  \"<i>Don't you know ze mountains are dangereuse,</i>\" the man says with a thick accent.  \"<i>You will get FUCKED up here if you are not careful.</i>\"\n\n");
						outputText("You thank the man and his team, but they brush off your gratitude.  \"<i>Non, non!</i>\" the man with the accent says.  \"<i>As zey say, everyone gets ONE.</i>\" With that, he touches the watch on his wrist and disappears.  The rest of the group continues on their way.\n\n");
						outputText("As they leave, the giant with the chain gun yells in a horribly accented manner, \"<i>YOU LEAVE SANDVICH ALONE! SANDVICH IS MINE!</i>\"\n\n");
						outputText("With that, another hail of bullets break the scene as they walk away, leaving you safe from the minotaur, but utterly baffled as to what in hell just happened.");
					}
					else {
						clearOutput();
						outputText("Crossing over the treacherous mountain paths, you walk past an ominous cave.  The bones and the smell of death convince you to hasten your pace.  However, as you walk by, you hear a deep bellow and a snort as a monstrous man with a bull's head steps out.  With hell in his eyes and a giant ax in his hand, he begins to approach you in clear rage.  As he comes out into the light, you see that he is completely naked and sports a monstrous erection as angry as the minotaur himself, freely leaking a steady stream of pre-cum as he stalks you.\n\n");
						outputText("You stumble in your attempt to escape and realize that you are completely helpless.  The minotaur towers over you and heaves his ax for a <i>coup de grace</i>.  As he readies the blow, another beast-man slams into him from the side.  The two of them begin to fight for the honor of raping you, giving you the opening you need to escape.  You quietly sneak away while they fight – perhaps you should avoid the mountains for now?\n\n");
					}
					player.createStatusEffect(StatusEffects.TF2, 0, 0, 0, 0);
					doNext(camp.returnToCampUseOneHour);
					return;
				}
				//Mino gangbang
				if (!player.hasStatusEffect(StatusEffects.MinoPlusCowgirl) || rand(10) == 0) {
					if (flags[kFLAGS.HAS_SEEN_MINO_AND_COWGIRL] == 1 && player.cowScore() >= 4 && player.lactationQ() >= 200 && player.biggestTitSize() >= 3 && (player.minotaurAddicted() || player.hasPerk(PerkLib.LactaBovineImmunity))) {
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
						addButton(0, "Join", joinBeingAMinoCumSlut);
						addButton(1, "Watch", watchAMinoCumSlut);
						return;
					}
					flags[kFLAGS.HAS_SEEN_MINO_AND_COWGIRL] = 1;
					if (!player.hasStatusEffect(StatusEffects.MinoPlusCowgirl)) player.createStatusEffect(StatusEffects.MinoPlusCowgirl, 0, 0, 0, 0);
					else player.addStatusValue(StatusEffects.MinoPlusCowgirl, 1, 1);
					clearOutput();
					outputText("As you pass a shadowy cleft in the mountainside, you hear the sounds of a cow coming out from it. Wondering how a cow got up here, but mindful of this land's dangers, you cautiously sneak closer and peek around the corner.\n\n");
					outputText("What you see is not a cow, but two large human-shaped creatures with pronounced bovine features -- tails, horns, muzzles, and hooves instead of feet. They're still biped, however, and their genders are obvious due to their stark nudity. One has massive, udder-like breasts and wide hips, the other a gigantic, horse-like dong and a heavy set of balls more appropriate to a breeding stud than a person. You've stumbled upon a cow-girl and a minotaur.\n\n");
					if (flags[kFLAGS.CODEX_ENTRY_MINOTAURS] <= 0) {
						flags[kFLAGS.CODEX_ENTRY_MINOTAURS] = 1;
						outputText("<b>New codex entry unlocked: Minotaurs!</b>\n\n")
					}
					if (flags[kFLAGS.CODEX_ENTRY_LABOVINES] <= 0) {
						flags[kFLAGS.CODEX_ENTRY_LABOVINES] = 1;
						outputText("<b>New codex entry unlocked: Lacta Bovines/Cowgirl!</b>\n\n")
					}
					outputText("A part of your mind registers bits of clothing tossed aside and the heady scent of impending sex in the air, but your attention is riveted on the actions of the pair. The cow-girl turns and places her hands on a low ledge, causing her to bend over, her ample ass facing the minotaur. The minotaur closes the distance between them in a single step.\n\n");
					outputText("She bellows, almost moaning, as the minotaur grabs her cushiony ass-cheeks with both massive hands. Her tail raises to expose a glistening wet snatch, its lips already parted with desire. She moos again as his rapidly hardening bull-cock brushes her crotch. You can't tear your eyes away as he positions himself, his flaring, mushroom-like cock-head eliciting another moan as it pushes against her nether lips.\n\n");
					outputText("With a hearty thrust, the minotaur plunges into the cow-girl's eager fuck-hole, burying himself past one -- two of his oversized cock's three ridge rings. She screams in half pain, half ecstasy and pushes back, hungry for his full length. After pulling back only slightly, he pushes deeper, driving every inch of his gigantic dick into his willing partner who writhes in pleasure, impaled exactly as she wanted.\n\n");
					outputText("The pair quickly settles into a rhythm, punctuated with numerous grunts, groans, and moans of sexual excess. To you it's almost a violent assault sure to leave both of them bruised and sore, but the cow-girl's lolling tongue and expression of overwhelming desire tells you otherwise. She's enjoying every thrust as well as the strokes, gropes, and seemingly painful squeezes the minotaur's powerful hands deliver to her jiggling ass and ponderous tits. He's little better, his eyes glazed over with lust as he continues banging the fuck-hole he found and all but mauling its owner.");
					doNext(continueMinoVoyeurism);
					return;
				}
				//Cum addictus interruptus!  LOL HARRY POTTERFAG
				//Withdrawl auto-fuck!
				if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 3 && rand(2) == 0 && player.inte / 10 + rand(20) < 15) {
					minotaurScene.minoAddictionFuck();
					return;
				}
				//Rare Minotaur Lord
				if (rand(5) == 0 && player.level >= 10) {
					clearOutput();
					outputText("Minding your own business, you walk along the winding paths.  You take your time to enjoy the view until you see a shadow approaching you.  You turn around to see a minotaur!  However, he is much bigger than the other minotaurs you've seen.  You estimate him to be eleven feet tall and he's wielding a chain-whip.  He's intent on raping you!");
					startCombat(new MinotaurLord());
					return;
				}
				minotaurScene.getRapedByMinotaur(true);
				spriteSelect(44);
			}
		}
		public function partsofDerpnadeLauncher():void {
			clearOutput();
			outputText("As you explore the mountains you run into what appears to be the half buried remains of some old contraption. Wait this might just be what that gun vendor was talking about! You proceed to dig up the items releasing this to indeed be the remains of a broken firearm.\n\n");
			outputText("You carefully put the pieces of the Derpnade Launcher in your back and head back to your camp.\n\n");
			player.addStatusValue(StatusEffects.TelAdreTripxi, 2, 1);
			player.createKeyItem("Derpnade Launcher", 0, 0, 0, 0);
			doNext(camp.returnToCampUseOneHour);
		}
		private function hike():void {
			clearOutput();
			if (player.cor < 90) {
				outputText("Your hike in the mountains, while fruitless, reveals pleasant vistas and provides you with good exercise and relaxation.");
				dynStats("tou", .25, "spe", .5, "lus", player.lib / 10 - 15);
			}
			else {
				outputText("During your hike into the mountains, your depraved mind keeps replaying your most obcenely warped sexual encounters, always imagining new perverse ways of causing pleasure.\n\nIt is a miracle no predator picked up on the strong sexual scent you are emitting.");
				dynStats("tou", .25, "spe", .5, "lib", .25, "lus", player.lib / 10);
			}
			doNext(camp.returnToCampUseOneHour);
		}
		private function joinBeingAMinoCumSlut():void
		{
			clearOutput();
			outputText("The prospect of getting a huge dose of that fresh minotaur cum is just too much to bear.  Before you realize what's happening, you're moving out of your rocky hiding spot and making your way down to the two bovine creatures, stripping your [armor] as you go.  By the time you reach the two figures, you're as naked as they are.  You shiver softly, whether due to some chill in the air or desperate anticipation, you can't say.");
			outputText("\n\nThe cow-girl is bent over, her hands on a low ledge with the minotaurs hands on either side of her ample ass.  She moans, more like a moo than a human groan, as the minotaur plunges into her quaking depths.  As you step forward, suddenly unsure of yourself, both the bull and the cow turn their sharp gazes on to you.  You feel very small");
			if (player.tallness <= 96) outputText(" despite your immense height");
			outputText(" as they look you up and down.  The entire area goes silent, even the goblins and the imps that are no doubt watching seem to be holding their breath, wondering what will happen to you.");
			outputText("\n\nThe minotaur grunts, finally, as if he finds you acceptable, and turns back to the plush ass before him, plowing into it once more.  The cow-girl, however, motions for you to move forward, and latches onto a [nipple] when you do.  Her soft lips encircle your areola, while her tongue dances over the rapidly hardening flesh of your teat.  Your breasts tingle with the slightest bit of suction, making you gasp as small droplets of milk escape your nipple and roll over the cow-girl's tongue.  She sucks more and more, eagerly gulping down your refreshing lactic beverage.");

			outputText("\n\nAll the while the minotaur continues grunting, thrusting his massive member into the woman's hungry cunt.  The two rock back and forth, pushing her face right into your breast before pulling back again.  The cow-girl's legs tremble and you suddenly find her arm grasping your shoulder for support.  Her other hand drifts down between your own naked legs, ");
			if (player.hasCock()) {
				outputText("ignoring your cock");
				if (player.cockTotal() > 1) outputText("s");
				outputText(" entirely, ");
			}
			outputText("slipping a finger into your moistening ");
			if (player.hasVagina()) outputText("pussy");
			else outputText("asshole");
			outputText(".  A low moan escapes your lips as a second finger slips in while the busty bovine woman's thumb ");
			if (player.hasVagina()) outputText("swirls around your clitoris");
			else outputText("presses against your perineum");
			outputText(".");

			outputText("\n\nThe broad-shouldered minotaur urges his mate onto her knees while he does the same, his dick never leaving its temporary home.  The cow-girl pulls you along, bringing you to your knees and then onto your back.  You have a moment of sudden modesty as you fold your legs, trying to block your crotch from view.  The bovine woman simply chuckles in between moans and lightly presses your knees apart.  Your legs spread wide, lewdly showing off your nether region to the cow-girl, and anyone else that's watching.");

			outputText("\n\nWithout wasting any time, the girl leans down and");
			if (player.hasCock()) outputText(", once again ignoring your manhood completely");
			outputText(", dives tongue first into your wet ");
			if (player.hasVagina()) outputText("quim");
			else outputText("back door");
			outputText(".  The movement is so quick that you can't even suppress the sudden, perverted moan that leaves your lips... a moan that sounds shockingly like a cow's moo.  The surprise at your sudden bovine outburst quickly dissipates as the cow-girl's large tongue dips in and out of your ");
			if (player.hasVagina()) outputText("sodden box");
			else outputText("moist butthole");
			outputText(".  Any remaining fears of joining this very public sex show are gone, and you wonder why you didn't join in sooner.");

			outputText("\n\nThe tongue lavishes your hole, paying homage to your crotch in the only way it knows how.  Your breath comes shorter while your arms and legs tingle, fingers and toes curling against your will.  The cow-girl laps and licks, her broad mouth muscle slipping in and out, curving in and around to hit every tender part of your insides.  You run your fingers through the woman's long red hair, forcing her head even deeper into your crotch.  With her head down like this, you have an easy view of her ass high up in the air, getting fucked senseless by the minotaur.  Every thrust makes the cow-girl moan into your lap, the added vibrations causing you to squirm even more.");

			outputText("\n\nThe bull thrusts in to the hilt, letting out one final bellow of pleasure.  The cow-girl brings her head up, her mouth and chin slick and dripping with your juices.  She lets out a moo-like bellow along with the minotaur, whose balls churn, no doubt depositing a heavy load of that delicious cum directly into her waiting womb.  You lick your lips, wishing you could just wrap them around that cock right now, to get your fix and feel the blissful sensations of relief run across your body.");

			outputText("\n\nThe girl gibbers incoherently as she slides off the minotaur's still-rigid cock, a small spurt of pearly white spunk running down her thighs.  The minotaur smirks, smacking the cow's ass and casually pushing her to the side.  A goofy grin is plastered on her face, eyes rolled up into their sockets like she's just experienced the most divine fuck imaginable. He then looks you dead in the eyes and says, in a deep, masculine and very dominant voice, \"<i>You get to ride my cock next, cow.</i>\"");

			outputText("\n\nHis rough, strong hands grasp your legs and draw you closer.  You squirm half-heartedly, not really trying to get away.  Though your mind tries to fight it, you know all you really want is that warm, sticky cum inside you one way or another.  You want to be just like the half-unconscious girl beside you, stuffed with cock and turned into this rugged man's breeding bitch.");

			outputText("\n\n\"<i>Eager for a fucking, huh slut?</i>\" he taunts, his turgid member resting along your stomach.  You nod slowly.  You feel a deep burning in your core. You want that cock inside you.  You want to be filled to bursting with this bull's seed, to feel it churn ");
			if (player.hasVagina()) outputText("within your womb, knocked up by this manly beast");
			else outputText("within your bowels");
			outputText(".  \"<i>That's a good slut,</i>\" he grunts, pulling his cock off your belly and rubbing the slick, flat head against your awaiting [vagOrAss].  He teases you with the slight contact until you open your mouth to voice your complaints, then he suddenly thrusts inside.  Any words forming on your tongue fly away, replaced by a whine of relief as your hole gets stretched wide by the invading member.");
			player.penetrated(player.vagorass,new Minotaur().cocks[0]);

			outputText("\n\n\"<i>Ahh, yeah.  That's some good ");
			if (player.hasVagina()) outputText("cow-pussy");
			else outputText("ass");
			outputText(" right there,</i>\" he groans, more of his bombastic cock slipping deep inside you.  The minotaur hooks an arm under each of your knees, lifting up your lower body, pressing even deeper.  Powerful sensations drift up from your ");
			if (player.hasVagina()) outputText("g-spot");
			else outputText("prostate");
			outputText(" as the minotaur's wide flare strokes it through your ");
			if (player.hasVagina()) outputText("vaginal");
			else outputText("anal");
			outputText(" walls.  Biting your lip with barely contained pleasure, you bring your hands to your breasts, playing with your milk-sodden nipples in between each orgasmic thrust of the bull's hips.");

			outputText("\n\nA giggle comes from your side, as you see the cow-girl is back up onto her knees, having recovered from her exalted orgasm.  She crawls forward, kneeling just over your head and leaning in to kiss her minotaur lover.  The two whisper sweet nothings to each other, too vague and indistinct to hear, but it doesn't matter.  All you can focus on is the dick lodged firmly inside of you... that, and the soaking cunt of the cow-girl just inches from your face.  Alabaster droplets drip down her legs, one even landing on your lips.  Before you can stop yourself, you lick them clean, savoring the taste of the second-hand cum.");

			outputText("\n\nSome part of your mind voices a complaint at what comes next, a voice that's quickly squelched inside the addiction-fueled haze of your brain.  You pull your head upwards and extend your tongue, slurping a large glob of cum from the cow-girl's snatch.  There's a surprised yelp from above you, followed by a coo of pleasure.  To your surprise, the cow-girl actually lowers her cunt down onto your face, giggling madly, filling your nostrils with the scent of her muff, with the scent of recent sex.  Not letting this opportunity go to waste, you repay her actions from earlier, slipping your ");
			if (player.tongue.type == Tongue.SNAKE) outputText("serpentine ");
			else if (player.tongue.type == Tongue.DEMONIC) outputText("demonic ");
			else if (player.tongue.type == Tongue.DRACONIC) outputText("draconic ");
			else if(player.hasLongTongue()) outputText("inhumanly long ");
			outputText("tongue inside her, eagerly licking out and guzzling down the remnants of the minotaur's present.");

			outputText("\n\nThe minotaur, for his part, is in no rush to give you a cream pie of your own. His thrusts are slow and deliberate, with a rhythm that has you writhing with pleasure.  The three of you moan together like some kind of erotic pyramid.  The bull's assault on your ");
			if (player.hasVagina()) outputText("womb");
			else outputText("back door");
			outputText(" increases slowly, and you can feel your limbs tingling at the prospect of your mino-cum-induced orgasm.");

			outputText("\n\nIt starts in your fingers, where your nerves seethe, gathering up fistfuls of grass like one might grab a sheet.  The heat continues down your arms and strikes your body like a lightning bolt, your belly suddenly spiking up, back arching as the orgasmic thunderstorm rolls over you.  The flames don't stop there, however.  They travel down into your crotch, suddenly lighting up every nerve in your ");
			if (player.hasVagina()) outputText("[vagina]");
			else outputText("[asshole]");
			outputText(" like a Christmas tree.  You're acutely aware of every single movement, every pulse, every little bit of contact between you and the huge cock living inside you.");

			outputText("\n\nYour muscles spasm and clench as the minotaur lets loose a powerful roar.  His own member twitches, suddenly releasing a flood of hot cum into your awaiting ");
			if (player.hasVagina()) outputText("womb");
			else outputText("bowels");
			outputText(".  The moment that long-awaited jism hits your walls, it's like another lightning bolt hits.  It travels up your spine and sets your entire brain aglow.  Ecstasy wrapped in bliss with a side of euphoric rapture consumes your thoughts.  Your vision goes white, pearly white like the seed filling your body, and your lips part as a primal \"<i>moo</i>\" slips out.");

			outputText("\n\nFor the longest time, the only thing your cum-addled mind can think about is cocks and cunts, of pregnant bellies and stomachs filled to capacity.  You mind fills itself with visions of yourself on your knees, servicing this minotaur daily, hoping to please him enough that he might grace your ");
			if (!player.hasVagina()) outputText("new ");
			outputText("womb with his divine dick.");

			outputText("\n\nIt takes several minutes for you to come down from this orgasmic high, and when you do, you see your minotaur lover has yet to recover from his.  He lays on his back in the midst of this clearing, his still-rock-hard cock jutting upwards, coating in a mixture of various juices.  The cow-girl sits beside him, carefully licking the towering pillar of cock clean.  You sit up, wobbly and clutch your stomach.  Filled with cum in two ends, you can't help but feel oddly unsatisfied.  Perhaps guzzling down some second-hand cum isn't quite enough to sate your hunger.  Perhaps you need it straight from the tap, as it were.");

			outputText("\n\nYou gingerly sit up, your body still quaking with pleasure.  Every movement sends another luxurious aftershock rippling through your body.  You crawl over to the splayed out minotaur, opposite your cow-girl partner, and join her in licking the man's cock clean.  It takes some work, but soon it glistens in the light of the red sky above you.");

			outputText("\n\nAs if you both possess some kind of bovine telepathy, you both lean forward, wrapping your ");
			if (player.bRows() > 1) outputText("uppermost ");
			outputText("breasts around his monolithic shaft.  Your faces meet and her soft lips press against yours, each of you earnestly pressing your tongues into the other's mouths, swapping the juices you've collected over the past hour or so.  The bull beneath you groans, awakening to the feeling of four breasts surrounding his love muscle.");

			outputText("\n\nThe two of your pump your breasts up and down, your lips barely leaving each other long enough to give his member the occasional kiss, lick or slurp.  Up and down you go, and this time it's the minotaur's body that's wracked with bliss, writhing on the ground.  Milk dribbles from your breasts, coating you, the cow-girl and the minotaur in a fine white sheen and creating a sweet-smelling aroma that permeates the air.");

			outputText("\n\nThe bull groans, biting his lip as a third, and likely final, orgasm rips through him.  His hips buck upwards, his cock flaring up and out of your mammaries.  Ropes of immaculate silver seed jet from his cumslit, arcing up into the air several feet before splattering down on your heads.  Wasting no time, you slip your lips around the flare, gulping down mouthful after mouthful of the sweet man-milk.  Even though it's his third load of the hour, it's just as big as the others, and soon your find you can't swallow any more; your cum-laden belly just won't allow it.");

			outputText("\n\nSadly, you relinquish your hold on his cock and sit back, watching the cow-girl opposite you pick up where you left off, slurping up whatever you missed with a dedicated fervor.");

			outputText("\n\n<b>Now</b> you feel satisfied.  Filled with that precious, precious minotaur spunk in both ends, fresh from the source.  You slump onto your back and drift off into a hazy, bull-filled dream world.");

			outputText("...");

			outputText("\n\nYou awaken several hours later.  The minotaur and the cow-girl are nowhere to be seen, but your [armor] is left neatly folded next to you, along with a small bottle filled with some white liquid, most likely a gift from your \"bull\".");

			outputText("\n\nYou quickly re-dress and head back to camp, spying the occassional goblin or imp scurrying from its hiding spot, no doubt recovering from their own self-inflicted orgasms.");
			player.orgasm();
			dynStats("lib", .5, "sen", -3, "cor", 1);
			if (flags[kFLAGS.PC_FETISH] > 0) {
				outputText("  A thrill runs through you.  Even though you were brought to such a satisfying climax, the whole thought that goblins and imps were watching you and getting off on it... it just makes you hornier than you were before.");
				dynStats("lus=", player.maxLust());
			}
			//Chance to impregnate PC, get mino-fix, and maybe relief from feeder perk.
			player.minoCumAddiction(10);
			if (player.hasUniquePregnancy()) player.impregnationRacialCheck();
			else player.knockUp(PregnancyStore.PREGNANCY_MINOTAUR, PregnancyStore.INCUBATION_MINOTAUR);
			if (player.isGargoyle() && player.hasPerk(PerkLib.GargoyleCorrupted)) player.refillGargoyleHunger(60);
			if (player.hasStatusEffect(StatusEffects.Feeder)) {
				//You've now been milked, reset the timer for that
				player.addStatusValue(StatusEffects.Feeder, 1, 1);
				player.changeStatusValue(StatusEffects.Feeder, 2, 0);
			}
			//(Acquired minotaur cum!)
			model.time.hours++;
			inventory.takeItem(consumables.MINOCUM, camp.returnToCampUseOneHour);
		}

		private function watchAMinoCumSlut():void
		{
			clearOutput();
			outputText("Deciding not to risk it, you settle back into your nook in the rocks and watch on eagerly.  The cow-girl turns and places her hands on a low ledge, causing her to bend over, her ample ass facing the minotaur.  The minotaur closes the distance between them in a single step.");
			outputText("\n\nShe bellows, almost moaning, as the minotaur grabs her cushiony ass-cheeks with both massive hands.  Her tail raises to expose a glistening wet snatch, its lips already parted with desire.  She moos again as his rapidly hardening bull-cock brushes her crotch. You can't tear your eyes away as he positions himself, his flaring, mushroom-like cock-head eliciting another moan as it pushes against her nether lips.");
			outputText("\n\nWith a hearty thrust, the minotaur plunges into the cow-girl's eager fuck-hole, burying himself past one -- two of his oversized cock's three ridge rings.  She screams in half pain, half ecstasy and pushes back, hungry for his full length.  After pulling back only slightly, he pushes deeper, driving every inch of his gigantic dick into his willing partner who writhes in pleasure, impaled exactly as she wanted.");
			outputText("\n\nThe pair quickly settles into a rhythm, punctuated with numerous grunts, groans, and moans of sexual excess.  To you it's almost a violent assault sure to leave both of them bruised and sore, but the cow-girl's lolling tongue and expression of overwhelming desire tells you otherwise.  She's enjoying every thrust as well as the strokes, gropes, and seemingly painful squeezes the minotaur's powerful hands deliver to her jiggling ass and ponderous tits.  He's little better, his eyes glazed over with lust as he continues banging the fuck-hole he found and all but mauling its owner.");
			//[Next]
			dynStats("lus", 10);
			menu();
			addButton(0, "Next", watchMinoCumSlutII);
		}

		private function watchMinoCumSlutII():void
		{
			clearOutput();
			outputText("They go at it for nearly an hour, oblivious to you watching them, before their intensity heightens as they near orgasm.  The results are almost explosive, both of them crying out as they begin twitching uncontrollably.  Clinging desperately to the cow-girl's ass, the minotaur pumps so much cum into her depths that it begins spurting out.  This accidental lubrication releases his grip and the pair collapse to the ground.  Yet the minotaur isn't finished, his man-milk spraying into the air almost like his still-erect dick is a hose and splattering down onto both of them.");
			outputText("\n\nAs you look at the two cum-covered creatures laying there in their exhausted sex-induced stupors, the minotaur's thick horse-cock now slowly deflating, you realize that you've been touching yourself.  You make yourself stop in disgust.");
			outputText("\n\nOnly now do you notice other faces peeking over ledges and ridges.  You count at least two goblins and one imp who quickly pull back.  From the sounds, they were busy getting themselves off.  Apparently this isn't an uncommon show, and the locals enjoy it immensely.");
			dynStats("lus", 25);
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function continueMinoVoyeurism():void {
			clearOutput();
			outputText("They go at it for nearly an hour, oblivious to you watching them, before their intensity heightens as they near orgasm. The results are almost explosive, both of them crying out as they begin twitching uncontrollably. Clinging desperately to the cow-girl's ass, the minotaur pumps so much cum into her depths that it begins spurting out. This accidental lubrication releases his grip and the pair collapse to the ground. Yet the minotaur isn't finished, his man-milk spraying into the air almost like his still-erect dick is a hose and splattering down onto both of them.\n\n");
			outputText("As you look at the two cum-covered creatures laying their in their exhausted sex-induced stupors, the minotaur's thick horse-cock now slowly deflating, you realize that you've been touching yourself.  You make yourself stop ");
			//[low corruption]
			if (player.cor < 33)
				outputText("in disgust.");
			else if (player.cor < 66)
				outputText("in confusion.");
			else
				outputText("reluctantly.");
			outputText("\n\nOnly now do you notice other faces peeking over ledges and ridges. You count at least two goblins and one imp who quickly pull back. From the sounds, they were busy getting themselves off.");
			//[if first appearance of this event]
			if (player.statusEffectv1(StatusEffects.MinoPlusCowgirl) == 0)
				outputText("  Apparently this isn't an uncommon show, and the locals enjoy it immensely.");
			//Lust!
			dynStats("lus", 5 + player.lib / 20 + player.minotaurScore() + player.cowScore());
			doNext(camp.returnToCampUseOneHour);
		}
	}
}