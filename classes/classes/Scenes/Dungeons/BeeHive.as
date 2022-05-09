/**
 * Side Dungeon: Bee Hive
 * @author Liadri and others
 */
package classes.Scenes.Dungeons 
{
import classes.EventParser;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.GlobalFlags.kFLAGS;
import classes.CoC;
import classes.EngineCore;
import classes.Scenes.Dungeons.BeeHive.BeeGuards;
import classes.Scenes.Dungeons.BeeHive.CorruptBeeQueen;
import classes.Scenes.Dungeons.BeeHive.DemonicBee;
import classes.Scenes.Dungeons.BeeHive.TheCorruptedHandmaidens;

	public class BeeHive extends DungeonAbstractContent
	{		
		public function BeeHive() {}
		
		public function enterDungeon():void {
			inDungeon = true;
			if (flags[kFLAGS.DISCOVERED_BEE_HIVE_DUNGEON] < 2.75) room1Pass();
			else room1South();
		}
		
		public function exitDungeon():void {
			inDungeon = false;
			clearOutput();
			outputText("You leave the bee hive behind and take off back towards the camp.");
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function room1Pass():void {
			clearOutput();
			dungeonLoc = DUNGEON_BEE_HIVE_1;
			outputText("As vague as the directions from that bee-girl were, you still managed to find the path she was indicating, and now you find yourself staring at the \"Hive\" she was talking about. It's quite an impressive sight, an edifice of wax built around the trees of the Deepwoods, it's almost the size of a small hill, it’s top reaching for the canopy and its sides vanishing into the gloom on either side of your vision. ");
			outputText("Fortunately, there are no battles being fought in your path, despite the mental image of her usage of the word \"siege\" had invoked, and you can see an entrance into the hive. Unfortunately, it's not unguarded.\n\n");
			outputText("There are two creatures standing in your way, and they could be identical twin sisters. They look like the bee-girls you have seen in the Forest... and yet they couldn't be more different. They're huge, easily seven feet tall and while their breasts aren't exactly small, their physiques can only be described as amazonian, with muscles visibly rippling under their tanned yellow skin even from here. ");
			outputText("Their almond-shaped eyes are solid black, their black hair is roughly trimmed short, their abdomens are huge and clearly solid muscle, tipped with smooth, venom-slick stingers as long as short swords. They look very imposing... and yet, at the same time, not very bright. One of them seems to be staring off into space, while her hand is... ");
			outputText("You blink, and then you confirm that, yes, her hand is absently playing with her naked vagina, in an awkward, half-hearted way that suggests she has never actually done it before, or that she isn't entirely sure she should be doing so now.\n\n");
			outputText("As you approach, the other Warrior Bee spots you and buzzes a quick \"<i>zzztop playing wizzz yourzzzelf!</i>\" to the first, who whines that she can't help it before joining her sister in threatening you. \"<i>Who goezzz there?</i>\" They snap as one.\n\n");
			if (player.beeScore() >= 9) {
				if (player.gender == 0 || player.gender == 2) {
					outputText("They stop, stare at you, and then look less threatening. \"<i>Where have you been, zzzizzzter? The queen wantzzz uzzz all to stay in the Hive until further notice!</i>\"\n\n");
					outputText("You can't believe your luck, but make up a vague excuse and hurry past them as they usher you into the entrance. "+(player.inte >= 50 ? "Fortunately, the corruption is clearly messing with their brains, and so they obviously can't think straight enough to realize you're not one of their sisters.":"You can't believe you're luck, they must be really dumb.")+"\n\n");
				}
				else if (player.gender == 1) {
					outputText("The fierce expressions on their faces melts away as they take in your own bee-like features, and the obvious sign of male gender. \"<i>What'zzz a drone doing out of the Hive?</i>\" One murmurs. The other doesn't speak, she's staring at you, fixated. The first one shakes her head and then points emphatically at the entrance to the Hive. ");
					outputText("\"<i>You're not supposed to be out here! Get inzzzide, where you belong!</i>\"\n\nYou do as you are told, thankful of the chance to avoid fighting. Indeed, given the way they both lick their lips as you slink past, you wonder if maybe you could have bribed them with sex to let you pass.\n\n");
				}
				else {
					outputText("\"<i>Zzzizzzter? Drone? Whatever, all Beezzz are supposed to be inside until the Queen givezzz further notice!</i>\" They snap.\n\n");
					outputText("Apologising, you hurry past them before they realize you aren't actually one of them.\n\n");
				}
				EngineCore.awardAchievement("Buzz Off", kACHIEVEMENTS.DUNGEON_BUZZ_OFF);
				flags[kFLAGS.DISCOVERED_BEE_HIVE_DUNGEON] = 2.75;
				doNext(playerMenu);
			}
			else {
				outputText("You tell them that you come in peace, trying to look non-threatening as you approach.\n\n");
				outputText("\"<i>Nobody enterzzz the Hive except for beezzz! Get out of here, or we will make you!</i>\" The guard who was masturbating just before demands.\n\n");
				menu();
				addButton(1, "Fight", room1Fight);
				addButton(2, "Talk", room1Talk);
				addButton(3, "Leave", room1Leave);
			}
		}
		private function room1Fight():void {
			clearOutput();
			outputText("Angered at being denied entrance, you give a war cry and attack! The Bees are caught off-guard by you taking the first offensive, but quickly rally to challenge you.\n\n");
			startCombat(new BeeGuards(), true);
		}
		private function room1Talk():void {
			clearOutput();
			outputText("You protest that you're an ally, you're here to help.\n\n");
			outputText("\"<i>Ally? You're no bee! Not a bee, not allowed in the Hive! Go now, or we will drop you into the treezzz bellow!</i>\" The other guard shrills fiercely. It's obvious that both of them will attack you if you don't turn around and walk right now.\n\n");
			menu();
			addButton(1, "Fight", room1Fight);
			addButton(3, "Leave", room1Leave);
		}
		private function room1Leave():void {
			inDungeon = false;
			clearOutput();
			outputText("Unwilling to risk a confrontation with actual Warrior Bees, you turn and leave the Hive.");
			doNext(camp.returnToCampUseOneHour);
		}
		public function room1LostToGuards():void {
			clearOutput();
			outputText("Defeated you fall to the ground"+(player.lust >= player.maxLust() ? " furiously masturbating":"")+". The guards roughly carry you a fair distance away from the hive dropping you in the trees from the air. Thanks to the leaves your landing isn't too harsh. You head back to camp for now to recover.");
			inDungeon = false;
			cleanupAfterCombat();
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function room2HoneyMerchant():void {
			clearOutput();
			outputText("You approach a counter where a bee girl stocks bottles of purified honey.\n\n");
			outputText("\"<i>Oh itzzz you! Welcome back to the Hive. Are you here to purchazzze honey? It's only 10 gems and it can help cure afflictions and recover from woundzzz, the best medicine really.</i>\"\n\n");
			menu();
			addButton(0, "Buy Honey", room2HoneyMerchantBuyHoney);
			addButton(4, "Leave", room2Center);
		}
		public function room2HoneyMerchantBuyHoney():void {
			clearOutput();
			if (player.gems < 10) {
				outputText("\n<b>You don't have enough gems...</b>");
				doNext(room2HoneyMerchant);
			}
			else room2HoneyMerchantTransact();
		}

		public function room2HoneyMerchantTransact():void {
			player.gems -= 10
			statScreenRefresh();
			inventory.takeItem(consumables.PURHONY, room2HoneyMerchant);
		}
		
		private function room3():void {
			if (flags[kFLAGS.TIFA_FOLLOWER] < 4){
				if (flags[kFLAGS.TIFA_FOLLOWER] == 3) outputText("You go back to the blocked path trying to find a way to open it.");
				else {
					outputText("As you make your way through the lambent hallway, it opens up to a beautiful golden-roofed atrium, letting sunlight pour in from above. However, your progress is hindered due to a few large bookshelves in your way, which you notice have been hastily pushed into position to barricade the entrance.\n\n");
					outputText("Despite your efforts, they do not budge, and you realize why. A very dark translucent material is used as a makeshift glue, bonding the bookcases together. Further inspection reveals it to be very reminiscent of caramel. Short of licking it away, you would be hard-pressed to remove the hard, congealed substance.");
				}
				outputText(" As you silently fume and ponder the situation, a voice suddenly calls out from behind the shelves with an angry buzzing accompanying it.\n\n\"<i>Begone intruderzzz! You zzzhall not pazzz!</i>\" the voice shouts"+(silly() ? ", emphasizing her last statement with a <i>thump</i> sounding like if someone broke a bridge with a staff":"")+".\n\n");
				if (flags[kFLAGS.TIFA_FOLLOWER] == 0) {
					outputText("You decide to come back later as you have no way to convince this bee to let you in.\n\n");
					flags[kFLAGS.TIFA_FOLLOWER] = 1;
				}
				else if (flags[kFLAGS.TIFA_FOLLOWER] >= 2){
					outputText("In return, you quickly explain who you are, and the situation with the other princesses and how Bridgess told you to find Tifa. This causes the voice to put on a more quizzical buzz than a threatening one.\n\n");
					outputText("\"<i>Normally I wouldn’t believe that zzzteaming load, but you don’t zzzound like a local, zzzo I guezzz you can come in. But I warn you, no funny buzzinezzz!</i>\"\n\n");
					doNext(room3part2);
				}
			}
		}
		private function room3part2():void {
			clearOutput();
			outputText("Wondering what on earth she could do to move the bookcases where you failed, you hear a slight moan and a squelching sound from the other side, as a sickly sweet smell fills the air. Amazingly, a small hole opens in the caramel, allowing you to see what is happening on the other side making you stare in disbelief. ");
			outputText("A red-gloved carapacial hand seems to covered in glittering golden honey, smearing itself across the caramel, and then suddenly disappears from view, eliciting another moan. The caramel starts to liquefy in contact with the honey, making the hole bigger. Again and again, the honey-smeared hand comes into view, speeding up the liquefaction process.\n\n");
			outputText("After what seems like an eternity, more and more holes begin to appear all over the caramel, and it becomes apparent that you could try once again to push the bookcases open. You do so, and are floored by what you see.\n\n");
			outputText("A magnificent bee woman is standing in front of you, out of breath and panting, with sweat running down her black and yellow fuzz, and antennae drooping slightly. She is wearing a white high-cut tank top giving you an excellent view of her considerable cleavage and waist. Black carapace gauntlets cover her elbows down to her hands, ");
			outputText("ending in the same fingerless red gloves you saw before. Her large abdomen extends out behind her, connected to her through a hole in her suspended leather mini-skirt, which you notice is extremely damp around her crotch. You smirk as you realize exactly how she ‘procured’ the honey to liquefy the caramel.\n\n");
			menu();
			addButton(1, "Talk", room3part3);
		}
		private function room3part3():void {
			clearOutput();
			outputText("You ask the bee girl how you can actually save the queen.\n\n");
			outputText("\"<i>If you are seriouzzz about this you will have to get to the throne room which is blocked by a gate that will only open to royal honey. I can grant you accezzz but after that, you are on your own.</i>\"\n\n");
			outputText("<b>Tifa is following you for now!</b>\n\n");
			flags[kFLAGS.TIFA_FOLLOWER] = 4;
			doNext(room3West);
		}
		
		private function room4():void {
			outputText("This latest chamber you have found yourself in is made entirely from honeycombs. Extremely large cells of wax are positioned vertically all around you - each big enough to house at least one person. The largest one of all is in front of you, and it is covered in a cap of solidified wax. However, it's just translucent enough that you can see shadowy figures inside it... ");
			outputText("especially as several of them are beating on the other side of the wax wall.\n\n\"<i>Let uzzz out of 'ere! You cannot do zizzz to uzzz! You cannot keep uzz prizzzner!</i>\" One of the shadows buzzes angrily.\n\n");
			outputText("These, you realize, are prisoners - and it doesn't take a genius to realize that they are thusly members of the hive who haven't fallen to corruption. Approaching the wax cell, you call out to them.\n\n");
			if (player.beeScore() >= 9) {
				outputText("\"<i>Let uzzz out of here, you zzzcum! Demon-tainted filth!</i>\" One of the figures buzzes shrilly.\n\n");
				outputText("You protest that you are not a member of the corrupted bees - or any hive for that matter.\n\n");
				outputText("They fall silent, but then one of them, the largest-looking shadow, speaks up. \"<i>Thizz accurzzzed wax blockzzz much of zzze zzzzentzzz, but... you don't zzzmell like a bee... and your aczzzent izzz awful. Maybe you're telling zzze truth.</i>\"\n\n");
				outputText("You assure them that you are, and you've come to help besides. But first, you need information.\n\n");
			}
			else {
				outputText("\"<i>How did you get in 'ere? What about thee guardzzz?</i>\" One asks, curious and clearly hard-pressed to believe it.\n\n");
				outputText("\"<i>Doezzz it matter?</i>\" One of the others asks. \"<i>Pleazzze, you must help uzzz!</i>\" She protests.\n\n");
				outputText("You assure her that is what you intend, but first, she needs to answer some questions.\n\n");
			}
			outputText("\"<i>Yezzz, anything! But we muzzzt be quick - the guard could be back any minute!</i>\"\n\n");
			outputText("You promise her you'll be quick, but you need to know just what's going on, how all this happened.\n\n");
			outputText("\"<i>Some of our handmaidenzzz came back home changed, they zztarted meddling with the other bees, and it soon became impozzzible to contain the corruption! Now they are trying to corrupt motherzzz, should they zzzucceed the entire hive will follow suit.</i>\" She explains.\n\n");
			outputText("You ask why they haven't succumbed to the corruption yet\n\n");
			outputText("\"<i>Becauzzze we are princezzezz, that is why! No queen can be corrupted so eazzzily - the lezzzer beezzz are falling azzz our mother izzz being corrupted, but we muzzzt be corrupted azzz individualzzz. The fallen sisterzzz ...are too buzzy focusing on our mother to do anything with uzzz juzzzt yet.</i>\"\n\n");
			outputText("Suddenly, she stiffens, as do the others behind the wax. \"<i>The guard - zzzhe izzz coming! You muzzzt go, now, quickly! Zzzhe will capture or kill you!</i>\"\n\n");
			outputText("That gets your attention, and as your eyes dart around the chamber, you see what you were too distracted to see before, the corpses of bees, Workers, Handmaidens, even Warriors, lying broken and discarded on the waxen floor. And you can hear a faint, ominous droning noise starting to grow louder and louder. Desperately, you ask what you can do to help.\n\n");
			outputText("\"<i>One of uzzz, the rebellious one, managed to barricade herzzzelf in a room. If you talk with her, zzzhe should be able to help you.</i>\"\n\n");
			outputText("You promise that is what you will do, and start to run for the exit. As you go, she calls out to you one last bit of information. \"<i>Her name izzz Tifa, tell her that Bridgezz zzzent you!</i>\"\n\n");
			outputText("Just as you’re ready to leave the cell, you come upon a particularly corrupted bee guard. Her entire body is twilight black, and she’s sporting a bee cock large enough to give you nightmare fuel. Her translucent wings are a mix between bat and bug and truth be told her twin horns alone give her away as a demonic bee.\n\n");
			outputText("\"<i>Want to meet the queenz? Thatzzz too bad, zzzhe is very busy having the orgazzzm of her life. Would you prefer my eggzzz or my zzzemen intruder? I think I will fill you both wayzzz. Onzzze I’m done I will give you azzz breeding zzztock for the fallen handmaidenzzz.</i>\"\n\n");
			if (flags[kFLAGS.TIFA_FOLLOWER] == 1) flags[kFLAGS.TIFA_FOLLOWER] = 3;
			else flags[kFLAGS.TIFA_FOLLOWER] = 2;
			startCombat(new DemonicBee(), true);
		}
		
		private function room6():void {
			clearOutput();
			outputText("As you enter, the first thing that hits you is the overpowering smell of honey. At the deepest reach of the room is a large shape of a sex-addled bee you presume to be the queen. Several smaller bees, the corrupted handmaidens, are busily pistoning in and out of a multitude of orifices in her abdomen.\n\n");
			outputText("As you approach the queen they finally take notice of you.\n\n");
			outputText("\"<i>Hey, girlzzz therezzz an interloper in the throne room! Letzzz add it to the orgy, mother izzz about to turn, and we will need willing incubatorzzz.</i>\"\n\n");
			outputText("The majority of the hermaphrodite handmaidens detach from the queen and fly to you, a hand on their bee cocks and another on their honeypot with drooling smiles.\n\n");
			startCombat(new TheCorruptedHandmaidens(), true);
		}
		
		public function defeatedByDemonicBee():void {
			clearOutput();
			outputText("The demonic bee smirks wickedly as you fall defeated on the floor. Before you can see it, her stinger pierces you, pumping a massive injection of aphrodisiac into you, and as if you have lost all control of your body, you jump into her arms, happy. As she holds you close, a thick knot-like organ covered in a sweet-smelling lubricant slowly emerges from her abdomen. ");
			outputText("As your mind synesthetically sees a myriad of colors and scents, you don’t resist as she gently pushes you down to your stomach. Nor do you protest as she leans over you, her stinger - thank goodness it isn’t poisonous - looming close to your anus. With no more words, she shoves the thick, lengthy stinger and knot inside of you. ");
			outputText("Her 'ovipositor' slips in slowly, the lubricant keeping you from shaking out of your scent-induced pleasure coma. Your hands even venture toward your "+(player.hasCock() ? "engorged member":"")+(player.gender == 3 ? " and ":"")+(player.hasVagina() ? "drooling pussy":"")+" as she rather forcefully rapes your hole, humming her lewd tune all the while.\n\n");
			outputText("After hours of her forcefully filling your hole, her stinger pumping what feels like gallons of her bee-seed into your very bowels"+(player.hasCock() ? ", and of you stroking yourself to ejaculation,":"")+" she finally pulls out. ");
			outputText("With her stinger still dripping seed onto your back, she smiles "+(player.hasCock() ? "while watching you blow your last load into a pool of semen underneath you, her own cock splattering cum on your chest ":"")+"before you collapse - exhausted.\n\n");
			outputText("You awaken in what is likely");
			defeatedBy();
		}
		public function defeatedByCorruptedHandmaidens():void {
			clearOutput();
			outputText("Defeated you fall to the ground as the handmaidens close in on you, licking their lips and holding their shafts at the prospect of taking turns. This is your last waking memory before you black out.\n\n");
			outputText("You awaken in");
			defeatedBy();
		}
		public function defeatedByCorruptBeeQueen():void {
			clearOutput();
			outputText("Defeated you fall to the ground as the bee queen’s shadow ominously covers you. This is your last waking memory before blacking out.\n\n");
			outputText("You awaken in");
			defeatedBy();
		}
		private function defeatedBy():void {
			outputText(" the throne room of the hive. You try to move and discover in horror that your legs and arms are glued up to a wall with solid resin. You are naked, your"+(player.biggestTitSize() >= 2 ? " [breasts] and":"")+" privates on display for all to see. You try to struggle free but quickly find out your bindings are nigh indestructible.\n\n");
			outputText("\"<i>Ohhh our guezzzt izzz awake, how convenient!</i>\"\n\n");
			outputText("The corrupted bee queen is looking at you… basking in her corruption and smiling wickedly at your bound form.\n\n");
			outputText("\"<i>Handmaidenzzz if you would… the incubator is yourzzz to uzzze.</i>\"\n\n");
			outputText("You watch in horror as demon-like bee girls make a line in front of you, their ovipositor and cocks drooling in anticipation. You will spend the rest of your life glued to this wall as one of the queen’s many incubator slaves for the handmaidens to use, to bear their eggs, keeping you alive so you can carry their fiendish brood.\n\n");
			//[GAME OVER]
			EventParser.gameOver();
		}
		public function defeatCorruptedHandmiadens():void {
			clearOutput();
			outputText("As the last of the handmaidens fall defeated the queen rises up from her seat, a dreamy expression in her eyes and a set of demonic horns in her hair. You were too late, the handmaidens managed to corrupt the queen!\n\n");
			outputText("\"<i>FUCK yezzz….zzzeed I need to ZZZEED! I want to zzzpread my eggzzz, so full of eggzzz! I need to share thozzze, where are my handmaidenzzz, my zzzlavezzz, when I need them zzzo I can zzzpread my brood.</i>\"\n\n");
			outputText("Between her legs stands a massive 50-inch penis dripping with semen and her massive abdomen is bulging from its contained cargo. Her debased gaze focuses on you, the last awake person in the room.\n\n");
			outputText("\"<i>Mmmmm your body will do nizzzely let me uzzze it as a vezzzel in celebration of my rebirth!!!</i>\"\n\n");
			outputText("<b>It’s too late to run now!</b>\n\n");
			startCombat(new CorruptBeeQueen(), true);
		}
		public function defeatCorruptBeeQueen():void {
			clearOutput();
			inDungeon = false;
			flags[kFLAGS.TIFA_FOLLOWER] = 6;
			flags[kFLAGS.TIFA_AFFECTION] = 1;
			outputText("As you put an end to the life of the fallen bee queen, the princesses and the remaining guards fill the room, looking at the scene with grief. Bridgess talks first.\n\n");
			outputText("\"<i>Mother izzz dead, thizzz izzz a terrible day for all of uzzz. However azzz the eldezzzt it izzz my rezzzponsability to take up to the tazzzk of queen in her zzztead.</i>\"\n\n");
			outputText("She walks up to you and does a formal gesture.\n\n");
			outputText("\"<i>You have our thankzzz for zzzaving our hive from corruption and azzz zzzuch I will give you permizzzion to have free pazzzage into the Hive and trade with my honeybrewerzzz for our zzzpecializzzed goodzzz. For now, pleazzze leave, I need zzzome time to mourn my motherzzz death.</i>\"\n\n");
			outputText("You are escorted out of the Hive but just as you are about to go back to camp, Tifa grabs your arm.\n\n");
			outputText("\"<i>I’m zzzorry that you had to do thizzz but again thizzz wazzz for the bezzzt. Zzzay what izzz your name?</i>\"\n\n");
			outputText("You tell her that you are [name] champion of Ingnam.\n\n");
			outputText("\"<i>[name] if you would allow me I would leave my hive to go with you and explore the world. I have never been comfortable there anyway and azzz the lazzzt in line for zzzucccezzzion I am unlikely to become queen after Bridgezzz.</i>\"\n\n");
			outputText("Well, you aren’t against her coming to your camp as long as she does not go too far away.\n\n");
			outputText("\"<i>Thankzzz I promizzze you will not regret it and the pozzzibility to live next to the champion of Ingnam will likely guarantee my safety. Zzzome of my little zzzisterzzz will follow me there too, I’m zzztill a princezzz after all</i>\"\n\n");
			outputText("<b>Tifa was added to follower tab.</b>\n\n");
			cleanupAfterCombat(camp.returnToCampUseOneHour);
		}
		
		public function room1South():void {
			dungeonLoc = DUNGEON_BEE_HIVE_1;
			clearOutput();
			outputText("<b><u></u>Entrance</b>\n");
			if (flags[kFLAGS.TIFA_FOLLOWER] > 5) {
				outputText("The guards let you pass into the Hive reminding you not to stir troubles.\n\n");
				outputText("\"<i>You are welcome into the Hive azzz by the queen'zzz orderzzz zzzo long azzz you don’t go further than the honeybrewerzzz hallzzz</i>\"");
			}
			else if (flags[kFLAGS.DISCOVERED_BEE_HIVE_DUNGEON] > 2.5) outputText("No one's there to block your path to the Hive, it seems you can proceed.");
			else outputText("The two guards fall to the ground, "+(flags[kFLAGS.DISCOVERED_BEE_HIVE_DUNGEON] == 2.5 ? "too busy masturbating":"their wounds too great")+" to keep up on fighting. You get past them and enter the Hive.");
			dungeons.setDungeonButtons(room2Center, null, null, null);
			addButton(11, "Leave", exitDungeon);
		}
		public function room4East():void {
			dungeonLoc = DUNGEON_BEE_HIVE_2;
			clearOutput();
			if (flags[kFLAGS.TIFA_FOLLOWER] < 2) room4();
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Princess cells</b>\n");
			outputText("Even with the corrupted guard defeated, lingering in this area is dangerous, best not tarry long.");
			dungeons.setDungeonButtons(null, null, room2Center, null);
		}
		public function room2Center():void {
			dungeonLoc = DUNGEON_BEE_HIVE_3;
			clearOutput();
			outputText("<b><u></u>Honey Brewers halls</b>\n");
			if (flags[kFLAGS.TIFA_FOLLOWER] > 5) {
				outputText("There is a counter selling honey on the side. Bee guards are blocking your path to the other rooms.");
				dungeons.setDungeonButtons(null, room1South, null, null);
				addButton(0, "Honey merchant", room2HoneyMerchant);
			}
			else {
				outputText("This place would be really busy if not for the fact the Hive is under siege. The honey brewers are likely hiding.");
				dungeons.setDungeonButtons(room5North, room1South, room3West, room4East);
			}
		}
		public function room3West():void {
			dungeonLoc = DUNGEON_BEE_HIVE_4;
			clearOutput();
			outputText("<b><u></u>The Library</b>\n");
			room3();
			if (flags[kFLAGS.TIFA_FOLLOWER] > 3) outputText("The library is empty right now.\n");
			if ((flags[kFLAGS.TIFA_FOLLOWER] != 2) && (flags[kFLAGS.TIFA_FOLLOWER] != 3)){
				dungeons.setDungeonButtons(null, null, null, room2Center);
			}
		}
		public function room5North(first:Boolean = true):void {
			dungeonLoc = DUNGEON_BEE_HIVE_5;
			clearOutput();
			outputText("<b><u></u>Far corridor towards the throne room</b>\n");
			if (flags[kFLAGS.TIFA_FOLLOWER] > 4) outputText("The way to the throne room is open.");
			else if (flags[kFLAGS.TIFA_FOLLOWER] > 3) {
				flags[kFLAGS.TIFA_FOLLOWER] = 5;
				outputText("You walk into "+(first ? "a":"the")+" wall of caramel colored substance. Tifa walks in front of you.\n\n");
				outputText("\"<i>Zzztand aside… I will open up a pazzzageway.</i>\"\n\n");
				outputText("You are about to ask how when you see her fiercely finger herself and then apply her honey covered hands on the walls. A doorway is melted out of the structure with enough space for you to get through. Tifa backs away then heads back toward the library.\n\n");
				outputText("\"<i>The rezzzt izzz up to you now.</i>\"\n\n");
			}
			else outputText("You walk into "+(first ? "a":"the")+" wall of caramel colored substance. Though you can see through it like glass, you have no way to get through it for now.");
			dungeons.setDungeonButtons(null, room2Center, null, null);
			if (flags[kFLAGS.TIFA_FOLLOWER] == 5) addButton(6, "Get through", room6);
		}
		
	}

}