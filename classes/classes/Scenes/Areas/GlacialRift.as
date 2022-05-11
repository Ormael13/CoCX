/**
 * Created by Kitteh6660.
 * Glacial Rift is a area with level 70-100 (outer) or 105-140 (inner) encounters
 * Please see this project. (This is not mine.) http://forum.fenoxo.com/thread-10719.html
 */
package classes.Scenes.Areas
{
import classes.*;
import classes.BodyParts.Arms;
import classes.BodyParts.Ears;
import classes.BodyParts.Eyes;
import classes.BodyParts.Face;
import classes.BodyParts.LowerBody;
import classes.BodyParts.RearBody;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Areas.GlacialRift.*;
import classes.Scenes.Areas.Tundra.Valkyrie;
import classes.Scenes.Holidays;
import classes.Scenes.NPCs.Valeria;
import classes.Scenes.SceneLib;
import classes.display.SpriteDb;

use namespace CoC;

	public class GlacialRift extends BaseContent
	{
		public var yukionnaScene:YukiOnnaScene = new YukiOnnaScene();
		public var yetiScene:YetiScene = new YetiScene();
		public var giantScene:FrostGiantScene = new FrostGiantScene();
		public var winterwolfScene:WinterWolfScene = new WinterWolfScene();
		public var wendigoScene:WendigoScene = new WendigoScene();

		public function GlacialRift()
		{
		}

		public function exploreGlacialRift():void {
			flags[kFLAGS.DISCOVERED_GLACIAL_RIFT]++;
			if (!player.hasPerk(PerkLib.ColdAffinity)) SubZeroConditionsTick();
			doNext(playerMenu);

			var choice:Array = [];
			var select:int;

			//Build choice list!
			choice[choice.length] = 0; //Yuki Onna (lvl 71) OR Frost Giant (lvl 89)
			choice[choice.length] = 1; //Yeti (lvl 76)
			choice[choice.length] = 2; //Frost Giant (lvl 89)
			choice[choice.length] = 3; //Winter Wolf (lvl 99)
			choice[choice.length] = 4; //Ice True Golems (lvl 80)
			choice[choice.length] = 5; //Glacial Troll (M & F variants) (lvl 94)
			choice[choice.length] = 6; //Wendigo (lvl 84)
			if ((flags[kFLAGS.HARPY_QUEEN_EXECUTED] != 0 || flags[kFLAGS.HEL_REDUCED_ENCOUNTER_RATE] > 0) && flags[kFLAGS.VALARIA_AT_CAMP] == 0 && flags[kFLAGS.TOOK_GOO_ARMOR] == 0 && player.armor != armors.GOOARMR) choice[choice.length] = 7; //Valeria
			if (rand(3) == 0) choice[choice.length] = 8; //Freebie items!
			if (rand(15) == 0) choice[choice.length] = 9; //Ornate Chest or cache of gems/pile of stones
			choice[choice.length] = 10; //Find nothing!

			//DLC april fools
			if (isAprilFools() && flags[kFLAGS.DLC_APRIL_FOOLS] == 0) {
                Holidays.DLCPrompt("Extreme Zones DLC", "Get the Extreme Zones DLC to be able to visit Glacial Rift and Volcanic Crag and discover the realms within!", "$4.99");
                return;
			}
			//Helia monogamy fucks
			if (flags[kFLAGS.PC_PROMISED_HEL_MONOGAMY_FUCKS] == 1 && flags[kFLAGS.HEL_RAPED_TODAY] == 0 && rand(10) == 0 && player.gender > 0 && !SceneLib.helScene.followerHel()) {
				GlacialRiftConditions();
				SceneLib.helScene.helSexualAmbush();
				return;
			}
			//Etna
			if (flags[kFLAGS.ETNA_FOLLOWER] < 1 && flags[kFLAGS.ETNA_TALKED_ABOUT_HER] == 2 && !player.hasStatusEffect(StatusEffects.EtnaOff) && rand(5) == 0 && (player.level >= 20)) {
				GlacialRiftConditions();
				SceneLib.etnaScene.repeatYandereEnc();
				return;
			}
			//Anzu
			if (flags[kFLAGS.ANZU_PALACE_UNLOCKED] < 1 && rand(5) == 0) {
				SceneLib.anzu.initialPalaceEncounter();
				return;
			}
			//Yu shop
			if (flags[kFLAGS.YU_SHOP] < 2 && rand(5) == 0) {
				SceneLib.glacialYuShop.YuIntro();
				return;
			}
			//Fenrir ruined shrine
			if ((player.faceType == Face.WOLF || player.faceType == Face.ANIMAL_TOOTHS) && player.ears.type == Ears.WOLF && player.arms.type == Arms.WOLF && player.lowerBody == LowerBody.WOLF && player.tailType == Tail.WOLF && player.hasFur() && player.hairColor == "glacial white" && player.coatColor == "glacial white" && player.hasKeyItem("Gleipnir Collar") < 0 && rand(5) == 0) {
				FenrirRuinedShrine();
				return;
			}
			select = choice[rand(choice.length)];
			switch(select) {
				case 0: //Yuki Onna OR Frost Gigant
					clearOutput();
					if (rand(2) == 0 && flags[kFLAGS.YU_SHOP] > 0) {
						yukionnaScene.encounterYukiOnna();
					}
					else {
						outputText("You wander the frozen landscape of the Rift, frozen rocks, frosted hills and forested mountains your only landmarks. As you cross the peak of a rather large, lightly forested hill, you come face to gigantic face with a Frost Giant! He belches fiercely at you and you tumble back down the hill. He mostly steps over it as you come to your senses. You quickly draw your [weapon] and withdraw from the hill to prepare for battle.\n\n");
						GlacialRiftConditions();
						startCombat(new FrostGiant());
					}
					break;
				case 1: //Yeti
					clearOutput();
					outputText("You grow tired trudging through the hard-packed snow under you, shielding your face with an arm as the wind lashes against you, slowing your progress. The whistle of the wind rings in your ears, only broken with the dull crunch of snow compacting underfoot. You can’t help but regret wandering into this storm and wish for shelter and warmth. Your body freezes at the sound of a loud crack, and turning your head to see the source of the noise, you notice too late that your lower body is sinking in the snow floor. You flail your limbs as your body is swept under by the moving snow, and you feel yourself sliding down some sort of shaft: it’s too dark to see where you are going. With a thump, you come to a stop.\n\n");
					if (flags[kFLAGS.MET_YETI_FIRST_TIME] <= 0) {
						outputText("Quickly wiping the snow off your body, you take in your surroundings. There are torches overhead that provide light and a small amount of warmth, making the ice cavern almost beautiful to be in, the light reflecting and shimmering off the polished ice walls, ceiling, and large icicles. There are a number of holes like the one you must have came out of, like a network of chutes that all lead to your location. You are surprised to find something under you, a large pile of white furs broke your fall. Though you are unnerved to find a large collection of bones lining the sides of the ice cavern, all white like snow, cleaned to a shine. Taking all this in, it’s obvious you are in someone’s or something’s residence. ");
						if (silly()) {
							outputText("You notice the bodies of a number of strange, bipedal horse-like creatures, all covered in thick white fur hanging from the nearby wall; laying beneath one is a strange metallic cylinder, not unlike a sword hilt, that gives off a strange, soft heat. ")
						}
						outputText("You brush off the snow and get to your feet, turning your head as you notice a passageway.\n\n");
						flags[kFLAGS.MET_YETI_FIRST_TIME] = 1;
					}
					else {
						outputText("Taking in the familiar surroundings, you realize you must have fallen through one of those chutes again. You begin to wonder if they are for the Yeti’s use, or if they are meant to bring in unsuspecting travelers. A meal delivery service set up with their limited ice magic? You shake off the snow on you and get to your feet. Looking to the passage, sure enough shadows dance along the walls as the thumps reach your ears.\n\n")
					}
					outputText("Hearing a thunderous roar, you ready yourself for a fight");
					if (player.weaponName != "fists") outputText(", holding your [weapon] at the ready");
					if (player.yetiScore() > 14 && player.hasVagina() && player.femininity > 40) {
						yetiScene.FemalePCMeetYeti();
						break;
					}
					else {
						sceneHunter.print("Check failed: yeti race, vagina, high femininity");
						outputText(". A massive hulking creature barrels around the corner and sets its gaze on you, its clawed hands and feet launching its body over the iced caverns with ease as you stare the beast down. The white blur of an ice yeti attacks you!");
						GlacialRiftConditions();
						startCombat(new Yeti());
						break;
					}
				case 2: //Frost Giant
					clearOutput();
					outputText("You wander the frozen landscape of the Rift, frozen rocks, frosted hills and forested mountains your only landmarks. As you cross the peak of a rather large, lightly forested hill, you come face to gigantic face with a Frost Giant! He belches fiercely at you and you tumble back down the hill. He mostly steps over it as you come to your senses. You quickly draw your [weapon] and withdraw from the hill to prepare for battle.\n\n");
					GlacialRiftConditions();
					startCombat(new FrostGiant());
					break;
				case 3: //Winter Wolf
					clearOutput();
					spriteSelect(SpriteDb.s_winterWolf);
					outputText("A titanic howling sound is heard nearby as an enormous shape jump off a nearby cliff into the snow right in front of you. As the flying snow clear off you see a wolf of immaculate pelt and size bordering the absurd. You likely accidentally stepped into its hunting territory and to clearly show its displeasure the ten feet tall monster growl at you showing its dagger-like teeth then start running in your direction howling what sounds to be a challenge.\n\n");
					GlacialRiftConditions();
					startCombat(new WinterWolf());
					break;
				case 4: //True Ice Golems
					clearOutput();
					outputText("As you take a stroll, out of the nearby glaciers emerge a group of golems. Looks like you have encountered some true ice golems! You ready your [weapon] for a fight!");
					GlacialRiftConditions();
					startCombat(new GolemsTrueIce());
					break;
				case 5:
					if (rand(2) == 0) SceneLib.trollScene.encounterAdultGlacialFemaleTroll();
					else SceneLib.trollScene.encounterAdultGlacialMaleTroll();
					break;
				case 6:
					wendigoScene.encounterWendigo();
					break;
				case 7: //Find Valeria! She can be found there if you rejected her offer initially at Tower of the Phoenix or didn't find her. She can never be Lost Forever.
					spriteSelect(SpriteDb.s_valeria);
					flags[kFLAGS.VALERIA_FOUND_IN_GLACIAL_RIFT] = 1;
					clearOutput();
					outputText("As you make your way across the Rift's icy extremities, you hear a metallic CLANK CLANK approaching through the snow flurries. You turn in time to see a suit of plated mail charging toward you, its helm and limbs filled with bright blue goo. It skids to a stop a few yards away, a greatsword forming from the goo of its hand. A beautiful, feminine face appears beneath the armor’s visor grinning at you. You suddenly recognize her face!\n\n");
					outputText("\"<i>This is my territory!</i>\" she shouts, bringing her two-handed sword to bare. \"<i>You’ll give me your fluids, or I’ll take them.</i>\"");
					addButton(0, "Fight", fightValeria);
					addButton(1, "Submit", SceneLib.valeria.pcWinsValeriaSparDefeat, true);
					break;
				case 8: //Find Aria of item!
					clearOutput();/*
					if (rand(2) == 0) {
						SceneLib.ariaScene.MelkieEncounter();
					}
					else {*/
						var itemChooser:Number = rand(2);
						if (itemChooser == 0) {
							outputText("As you cross one of the floating ice sheets that make up the bulk of the rift, your eyes are drawn to a bright glint amidst the white backdrop.  As you eagerly approach the gleam, you discover a single tiny spire of ice, jutting from the surrounding snow.  You pluck it gently from the ground, give it a quick glance over and, satisfied that it won’t try and kill you, drop it in your bag. ");
							inventory.takeItem(consumables.ICICLE_, camp.returnToCampUseOneHour);
						}
						else if (itemChooser == 1) {
							outputText("As you make your way across the icy wastes, you notice a small corked ivory horns half-buried under the snow, filled with a thick sweet-looking liquor. You stop and dig it up, sniffing curiously at the liquid. The scent reminds you of the honey secreted by the bee-girls of Mareth, though with hints of alcohol and... something else. You place the horns of mead in your bag and continue on your way. ");
							inventory.takeItem(consumables.GODMEAD, camp.returnToCampUseOneHour);
						}
					//}
					break;
				case 9: //Find ornate chest!
					if (player.hasKeyItem("Camp - Ornate Chest") < 0) {
						var gemsFound:int = 400 + rand(400);
						outputText("While you're minding your own business, you spot an ornately-decorated chest somewhat buried in the snow. You walk on the snowy grounds you finally reach the chest. As you open the chest, you find " + String(gemsFound) + " gems inside the chest! You pocket the gems and haul the chest home. It looks nice and would make a good storage.");
						player.createKeyItem("Camp - Ornate Chest", 0, 0, 0, 0);
						for (var i:int = 0; i < 4; i++) {
							inventory.createStorage();
						}
						player.gems += gemsFound;
						statScreenRefresh();
						outputText("\n\n<b>You now have " + num2Text(inventory.itemStorageDirectGet().length) + " storage item slots at camp.</b>");
					}
					else {
						if (rand(2) == 0) {
							var stonesHarvested:Number = 10;
							var stonesCapacity:Number = 300;
							if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 4) stonesCapacity += 600;
							outputText("You find a big amount of stone rubble in the rift and begin to harvest them for your constructions. ");
							if (SceneLib.emberScene.followerEmber() || SceneLib.kihaFollower.followerKiha()) {
								stonesHarvested += 10;
								if (SceneLib.emberScene.followerEmber() && SceneLib.kihaFollower.followerKiha()) {
									outputText("Kiha and Ember");
									stonesHarvested += 10;
								}
								else if (SceneLib.emberScene.followerEmber()) {
									outputText("Ember");
									if (SceneLib.kihaFollower.followerKiha()) outputText(" and ");
								}
								else outputText("Kiha");
								outputText(" assist you into bringing as many as possible back to camp. ");
							}
							if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] + stonesHarvested < stonesCapacity) flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] += stonesHarvested;
							else flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] = stonesCapacity;
						}
						else {
							var gemsFound2:int = 40 + rand(160);
							outputText("As you wander the rift your foot hits something burrowed under the snow. It is a treasure chest and it looks packed to the brim.\n\n Inside was " + String(gemsFound) + " gems! ");
							player.gems += gemsFound2;
							statScreenRefresh();
						}
					}
					doNext(camp.returnToCampUseOneHour);
					break;
				default:
					clearOutput();
					outputText("You spend an hour trudging through the bleak and bitingly cold glaciers but you don’t find anything interesting. ");
					if (player.tou < 50){
						outputText("But on your way back you feel you're a little more used to traveling through this harsh area.");
						player.trainStat("tou", +1, 50);
					}
					dynStats("tou", .5);
					doNext(camp.returnToCampUseOneHour);
			}
		}

		public function GlacialRiftConditions():void {
			if (!player.headJewelry == headjewelries.SKIGOGG) player.createStatusEffect(StatusEffects.Snowstorms,0,0,0,0);
			if (!player.miscJewelry == miscjewelries.SNOWBOA && !player.miscJewelry2 == miscjewelries.SNOWBOA) player.createStatusEffect(StatusEffects.Snow,0,0,0,0);
			if (!player.hasPerk(PerkLib.ColdAffinity)) player.createStatusEffect(StatusEffects.SubZeroConditions,0,0,0,0);
		}

		public function SubZeroConditionsTick():void {
			var HPD:Number = 0.05;
			if (player.hasPerk(PerkLib.FireAffinity) || player.hasPerk(PerkLib.AffinityIgnis)) HPD *= 2;
			HPD *= player.maxHP();
			HPD = Math.round(HPD);
			outputText("Cold environment slowly seeps into your body. ");
			player.takeIceDamage(HPD, true);
			outputText("\n\n");
		}

		private function fightValeria():void {
			clearOutput();
			outputText("You ready your [weapon] for a fight!");
			GlacialRiftConditions();
			startCombat(new Valeria());
		}

		private function FenrirRuinedShrine():void {
			clearOutput();
			if (flags[kFLAGS.FENRIR_COLLAR] == 2) {
				outputText("Once more you are drawn into the Temple of Fenrir, and the collar stands before you on Fenrir's petrified form. The god does not speak, but you feel him watching you, silently posing his dreadful question again.\n\n");
				outputText("Will you take the collar and inherit the dark god's will, or will you refuse, for now?\n\n");
				addButton(0, "Take It", putTheCollar);
				addButton(1, "Leave", leaveShrine);
			}
			else if (flags[kFLAGS.FENRIR_COLLAR] == 1) {
				outputText("Wandering the Glacial Rift you find yourself drawn once more to the ruins of the Temple of Fenrir. You enter it again, drawn by the thread of Urdr, and the menacing voice of Fenrir echoes in your mind.\n\n");
				outputText("\"<i>Welcome, feeble one. You see my words were true, as they always are. Shall you reconsider my offer? So long as you bear the shape of my fallen children the choice shall remain open to you.</i>\"\n\n");
				outputText("The chained collar still sits around the neck of Fenrir's petrified form. Will you take the collar and inherit the dark god's will, or will you refuse, for now?\n\n");
				flags[kFLAGS.FENRIR_COLLAR]++;
				addButton(0, "Take It", putTheCollar);
				addButton(1, "Leave", leaveShrine);
			}
			else {
				outputText("As you explore the frigid wasteland at the foot of the icy mountains, you realize that for the last few minutes your steps have been guided by something; not a smell of the kind you've found so vibrantly part of your new lupine awareness, but some sort of call that reaches similarly into you and pulls you onward with the weight of destiny, or doom. You attempt to redirect yourself several times, but somehow the minute your mind wanders again from conscious resistance you find yourself facing the same way again, and after a time you give up, submitting yourself to the mysterious attraction and whatever awaits you at its source.\n\n");
				outputText("Cresting a small hill, the ice beneath you suddenly cracks, and you tumble down a steep slope; fortunately you come to rest without harm, and when you regain your footing you find yourself at the bottom of a small well in the ice. The air here is clear, cold, and still; you can see the perpetual ice-storm blowing dozens of feet above your head, obscuring your view of the sky and the mountains, but straight ahead you can see clear to the other side of the depression, hundreds of feet. There, standing from the frozen ground in ghastly relief you can see a ruined building. In fact, you can see little else; your eyes are drawn magnetically to it, and before you even gather your thoughts you are standing nearly at the threshold, your feet having carried you there on their own. It is a building of gray stone, with cruel, brutal lines, as if the twisted peak of an unclimbable mountain were snapped off by a malevolent giant and placed here in the realm of the earthbound as a mockery, or a warning. A yawning archway, symmetrical and carved with an unfamiliar, harshly angular script opens into darkness, and you step inside.\n\n");
				outputText("Somehow, beyond the forbidding entryway the interior is not dark; or perhaps your eyes have somehow adjusted to the gloom. There is only one way forward, and you follow the smooth, stone passage into a great gallery, much larger than the structure's appearance would have indicated; perhaps you have descended and are underneath the frozen surface? Certainly the walls appear coated with a thick layer of ice-cold enough to have acquired dust, and a muted, chilly luminescence drifts down from the ceiling, making it difficult to tell exactly how high the room goes. The floor, too, is coated in ice, but some feet below you can see a stone floor, gouged and cracked from some terrible movement of the earth, or perhaps some other violence of similar power. Carved pillars of stone stretch up around the perimeter, some shattered similarly to the floor.\n\n");
				outputText("At the far end of the room there is a statue of pale, faintly marbled stone carven in the shape of a wolf. Or, not <i>a</i> wolf, surely <i>the</i> wolf, you think; the form of all that is lupine. Its lips are parted and peeled in a feral snarl, revealing sharp fangs that seem dripping with hunger even in this lifeless form. Its eyes are open and focused forward with all the intensity of the most terrifying predator, and draw you in with shuddering magnetism despite being only a shape carved in the statue's surface. Its lean, haggard, but ruggedly muscled form is half-turned sideways, as if it were circling you, cutting off any escape, and ready to pounce on your exhausted spirit. You approach it in a mixture of fear and reverence; something in your wolfish instincts resonates to this terrible form, and you approach it despite your misgivings.\n\n");
				outputText("The only part of the statue not carved of the same pale stone is a great collar of black leather, lined with great white spikes jutting outward, each several inches long, wickedly sharp, and scored with runes similar to those lining the entrance of this place and the pillars. Thick chains trail down from it, anchoring the wolf's neck to something below the ice; glancing down, you realize the raised bed of stone on which the statue sits is really the top of an imposing dais or altar. Moved by a strange impulse to reach out and touch the collar.\n\n");
				outputText("\n\n\"<i>Hold, feeble one!</i>\" A voice, seemingly without source, cuts through your body like a chill wind. It sounds infinitely distant, but somehow all around you, and something in its quality suggests the same curled-back, snarling lips and knife-like fangs of the gaping mouth in front of you.\n\n");
				outputText("You stop your paw, unable to resist the command; the voice takes hold of your body from the inside-out, nearly driving your own will and consciousness from you. By an intense act of will you keep yourself conscious enough to listen as the voice continues its icy proclamation.");
				outputText("\"<i>Full many ages has it been since aught but ghosts trod these cursed, forbidden halls. You, mortal, you are of the tribe of men, yet by some magic you wear the form of my lost children, long scattered and reduced to mere beasts. Willingly, it would seem; I smell no geas upon you. What drew you to my prison, my grave? Speak, I command you, and do not remain silent, for I am Fenrir!</i>\"\n\n");
				outputText("You speak, and do not remain silent, humbly introducing yourself and explaining your quest to free Mareth of its demonic oppressors. Fenrir's voice does not interrupt you, yet you feel the pressure of his judgment against your body all the same. When you have finished your explanation, Fenrir gives a scornful chuckle.\n\n");
				outputText("\"<i>Heh heh heh... to think, those who came after I slaughtered my ancient enemies, to rebuild the ruins of the old world, who feared my strength yet were strong enough to chain me here for all their age, have fallen so far as to fear mere vermin? These false immortals, cursed bodies kept alive only by the loss of that which would carry them beyond death? Would a great warrior cast away his weapons and save his life at the cost of his lasting glory? What poets would sing of him, save in mockery, until his very name were a shape of laughter? Would not his fall rob even his children of that which would grant them immortality? Such fools could be a threat only to the weakest of the weak. Ha ha ha... HAAA HAAAAA HAAAAAAAA!</i>\"\n\n");
				outputText("You shudder at the malice dripping from the voice's cruel, vindictive speech, and the harsh, mocking laughter with which he dismisses all the pain and suffering you've seen during your travels. Yet, somehow, you also find it attractive; surely this is the voice of true strength, laughing at the weak and their struggles? You ask the voice who it really is. Is the wolf on the alter him? You have not heard the name Fenrir before, in any of the stories from your own world nor here in Mareth.\n\n");
				outputText("\"<i>It is no surprise that the usurpers have buried my name, as they buried my prison, terrified as they were of my prowess. Know this, feeble one: I am Fenrir! The Deadly Bite of Winter's Chill, Son of Giants, the God-Beast most feared by the Aesir behind the All-Devouring Serpent himself. At the last I swallowed the Sun and plunged the world of men into eternal darkness, and proved the bane of the Chief of the Aesir, whose one eye could not follow my speed nor his magical spear find my hide. With his blood I whetted my appetite for death, and on death did I feast until nought remained, and the world went silent save for my howling, until the usurpers arose to begin the great cycle anew.</i>\n\n");
				outputText("Somehow despite the obvious boasts coming from the voice, which seems to crawl into your skin and dance up your spine with cold claws until you are left rattling with a cold that your fur cannot protect you from, you are left with absolutely no doubt that every word it speaks is the ungarnished truth. Surely you have uncovered an ancient evil that must not be released upon the world? You turn to leave, but the voice commands you once more.\n\n");
				outputText("\"<i>Halt, mortal. I am not finished.</i>\" Once more you obey despite yourself; again it is all you can manage just to keep your mind mostly in charge of your body. The voice continues. \"<i>What I have spoken is true, but it is also true that my confinement has done what no god's spear or ancient warrior's blade could do, and my true strength has waned far from what it was. I will never again take form in this world, even if you were to release me from Gleipnir, this cursed chain forged of the sound of cat's silent steps and other falsities, against which I am powerless. But... I could let the last of my power into those chains, and the collar that binds me. Those you could take, and inherit my will and my power; you could unleash the wild howl of winter across this world once more, and sweep the Demons you so fear away like the last leaves of autumn before the blizzard! Come, will you take my offer? My power, the power of a god, yours to command?</i>\"\n\n");
				outputText("You ask if this would not mean his death.\n\n");
				outputText("\"<i>Ha ha ha! Fool! I am a god! I fear no death, for my being lies in my power, not in my thoughts, memory, or shape. Those can pass away into the forgotten past, yet if my power continues to shape the world whoever wields it will be but writing the new chapter of my saga, and their deeds will carry me forward into the immortal future. But I am not my father; no weaver of pleasant lies or cunning traps am I. My power is in strength, cruelty, the ferocity of the hunter who tears the throat of its prey from the front. See what is before you with my eyes, and decide for yourself what you wish to do. I will not trick you or force you; an unwilling vessel for my power would write but a poor tale to glorify me.</i>\"\n\n");
				outputText("With a rush of cold you feel something take hold of your body, and suddenly you see the wolf statue, the collar, and the chain in front of you with eyes that understand. The wolf statue seems blurred, overlaid with itself in a wavering fashion, and you realize that, far from a statue, it is truly all that remains of Fenrir as he once was; his spirit weakly clings to it but cannot shake free of the chains that bind him.\n\n");
				outputText("The chain glows with a ghostly, pale light, and it is nearly transparent; what looked to your mortal eyes like heavy metal links now looks more like rings of air coated in thinly laid spidersilk. Surely they must be light as a feather, weightless, yet you understand that it is their very ephemerality that makes them strong: how can you break what never held together in the first place? You cannot grapple with smoke, so what if smoke grappled with you? You shudder at the thought of being bound with those chains. The spikes on the collar with their runic carvings you can now read and understand; they are curses of finality, of inescapability. You know that once you put on that collar your fate will be irrevocably changed. There will be no going back from this decision. And yet, for all that, you see, or at least feel, the sheer vastness of the power you are being offered. It is a violent, cruel power; the power to destroy, to devour, to drive the life and light from the world. You doubt that your use of that power can lead to a truly happy end... and yet, you can easily see Lethice and her Demon army scattering before it, so vast is its potential even in this diminshed state.\n\n");
				outputText("You hear Fenrir's voice chuckle one more time as he tempts you, yet you do not doubt that what you have seen is the truth of the matter. Will you assume the mantle of the evil god of winter and darkness, or will you retain what is left of your humanity?\n\n");
				addButton(0, "Wear It", putTheCollar);
				addButton(1, "Leave", leaveShrine);
			}
		}

		private function putTheCollar():void {
			clearOutput();
			outputText("Moving with the weight of destiny, you pull on the chains where they emerge from the icy floor. Strangely, they break easily in your hands, shattering like the shell of ice over a frozen puddle, then hanging limply from the collar. Fenrir remains silent, but you feel his presence pounding with expectation as you approach the statue's gaping mouth to pull the collar over it. You try to remove the chains, but for whatever reason what remains of them feels as unyielding as the hardest steel, even though they are, as you expected, nearly weightless. The collar is supple even after however many hundreds or thousands of years it has sat in this frozen, forgotten place, and it slips over the wolf's head easily, as if its size were a matter of context. Indeed, as you slip it over your own head in your final act of acceptance of the dark god's offer, you find that once it is around your neck it fits you as if it were made for you, and by no effort can you get it back off again. You will not be removing this collar, perhaps ever.\n\n");
			outputText("\"<i>IT IS DONE!!!!!</i>\" echoes Fenrir's voice, with such force that patches of ice on the walls and floor around you begin to shatter and crumble. The room trembles ominously, and you run quickly to the exit, the rumbling increasing in intensity behind you. Something prevents you from looking back, but you strongly suspect that no one, mortal or otherwise, will be entering that chamber ever again.\n\n");
			outputText("You feel power flowing into your limbs and, somehow, into your soul. The black god speaks up once more. \"<i>So you see, I spoke no lie to you, feeble one... no, little godling. You shall not hear my voice again; henceforth your voice shall be the voice of Fenrir, bringing terror to the weak, drawing to fierce battle the courageous who dare stand against you. You shall write the story of my glory for the new age, and ages to come. Rejoice, godling, <b>you are the Fenrir</b>. Go forth and hunt, and taste deeply of death. With my last words I give you my blessing, before I pass beyond time and memory: your enemies shall know the bite of winter's chill.</i>\"\n\n");
			outputText("Fenrir's last act, or the old god's last act, is a mighty howl that surely must echo across all of the Glacial Rift and beyond; you see the mountaintops shaking and hear the sound of a hundred avalanches as the dread sound disturbs the frozen peace of this place; and then, like a passing dream, it is gone, and you hear no more. Then you feel many strange sensations hit you all at once, beginning with your eyes, which suddenly begin to freeze over in an amazingly painful way. You try to blink, to rub them, to claw the ice away, but nothing works, and you collapse to your knees howling in agony until suddenly the pain ceases, and once more you can see and blink. Your eyes still feel cold, but the sensation no longer registers as pain, as if it were your natural state. <b>You now have glowing icy eyes!</b>\n\n");
			outputText("The feeling then sprouts along the back of your neck and down your spine, and you pitch forward in simliar agony as you feel something pierce through your skin outward, freezing and burning its way out and down all the way to the base of your lupine tail. Once more you howl in pain, then once more the pain abruptly ceases, but not the feeling of the cold. Indeed, you notice that even the cold of the air and the frozen ground no longer feel painful; they feel comfortable, in fact. The chill air is bracing and energizing, and you are filled with the urge to race forward and chase, corner, bite, devour, kill. The frozen wastes of the world belong to <b>you</b>. They are <b>your</b> hunting ground, <b>your</b> kingdom, and let all who dare to trespass fear your wrath! <b>Your back is now covered with sharp ice spike constantly cooling the air around you and protecting you from the cold. (Gained Frozen Waste and Cold Mastery perks)</b>\n\n");
			outputText("Then, suddenly, you feel even the warmth inside your own body die out, replaced by a creeping chill that starts at your extremities and creeps inward, killing the heat of life, the palpable kindness of living warmth, and replacing it with the cruel chill of the dead, still air of a lightless winter night. As it spreads up your torso something forces its way up and out, and you howl one last time, not in pain but in exultation, and the very air before you stills its movement as your voice saps the life and warmth from it. <b>You can now use Freezing Breath and Frostbite.</b>\n\n");
			outputText("With a new sense of purpose and the thrill of the coming hunt you return to your camp. Let Lethice and her Demons tremble in the cold of the coming winter; Mareth has something far greater to fear now. Your ice will spread and cover the world of the living until all know and shiver at the name of <b>Fenrir</b>.\n\n");
			if (player.faceType == Face.ANIMAL_TOOTHS) CoC.instance.transformations.FaceWolf.applyEffect(false);
			CoC.instance.transformations.EyesFenrir.applyEffect(false);
			CoC.instance.transformations.RearBodyFenrirIceSpikes.applyEffect(false);
			player.createPerk(PerkLib.ColdMastery, 0, 0, 0, 0);
			player.createPerk(PerkLib.FreezingBreath, 0, 0, 0, 0);
			player.createPerk(PerkLib.FromTheFrozenWaste, 0, 0, 0, 0);
			player.createPerk(PerkLib.FenrirSpikedCollar, 0, 0, 0, 0);
			player.createKeyItem("Gleipnir Collar", 0, 0, 0, 0);
			dynStats("cor", 100);
			doNext(camp.returnToCampUseOneHour);
		}

		private function leaveShrine():void {
			clearOutput();
			if (flags[kFLAGS.FENRIR_COLLAR] == 1) outputText("You turn to leave, still refusing Fenrir's offer. His voice echoes softly behind you. \"<i>Until next time, feeble one. May you live until the thread of Urdr draws you here once more.</i>\"");
			else if (flags[kFLAGS.FENRIR_COLLAR] < 1) {
				outputText("This seems like a bad idea. You don't doubt that the dark god has shown you the truth, but you've come this far without making choices you can't take back, and this choice in particular doesn't feel like the place to start. You return your paw to your side and move to leave the cavern, and Fenrir's voice echoes around you one more time.");
				outputText("\n\n\"<i>Your choice is your own, feeble one. I speak the truth; I shall not force you. You will be a fitting vessel for my power only if you take it willingly, and knowing full well what it entails. Until you decide differently I will wait here, patiently. But know this: it was the weight of Urdr's thread that brought you to this place, and you may find resisting it as hard a burden as the one you already bear. Make no mistake, so long as you bear the shape of my scattered children we will meet here again, and you will have to choose once more.</i>\"");
				outputText("\n\nOn those word Fenrir falls silent again as you make your way back to your camp.");
				flags[kFLAGS.FENRIR_COLLAR] = 1;
			}
			doNext(camp.returnToCampUseOneHour);
		}
	}
}
