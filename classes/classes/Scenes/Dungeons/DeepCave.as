//Dungeon 2: Deep Cave
package classes.Scenes.Dungeons 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.BaseContent;
	import classes.Scenes.Dungeons.DungeonAbstractContent;
	import classes.Scenes.Dungeons.DungeonEngine;
	import classes.Scenes.Dungeons.DeepCave.*;
	
	import classes.internals.Utils;
	import classes.Scenes.NPCs.ShouldraFollower;
	import coc.model.GameModel;
	
	use namespace kGAMECLASS;
	
	public class DeepCave extends DungeonAbstractContent
	{
		private static const DUNGEON_CAVE_ENTRANCE:int			= 10;
		private static const DUNGEON_CAVE_TUNNEL:int			= 11;
		private static const DUNGEON_CAVE_GATHERING_HALL:int	= 12;
		private static const DUNGEON_CAVE_FUNGUS_CAVERN:int		= 13;
		private static const DUNGEON_CAVE_TORTURE_ROOM:int		= 14;
		private static const DUNGEON_CAVE_SECRET_TUNNEL:int		= 15;
		private static const DUNGEON_CAVE_ZETAZ_CHAMBER:int		= 16;
		
		public var vala:ValaScene = new ValaScene();
		public var shouldraFollower:ShouldraFollower = new ShouldraFollower();
		
		public function DeepCave() {}
		
		public function enterDungeon():void {
			clearOutput();
			outputText(images.showImage("dungeon-entrance-deepcave"));
			kGAMECLASS.inDungeon = true;
			if (flags[kFLAGS.DISCOVERED_DUNGEON_2_ZETAZ] < 1) {
				
				outputText("While you explore the deepwoods, you do your best to forge into new, unexplored locations.  While you're pushing away vegetation and slapping at plant-life, you spot a half-overgrown orifice buried in the side of a ravine.  There's a large number of imp-tracks around the cavern's darkened entryway.  Perhaps this is where the imp, Zetaz, makes his lair?  In any event, it's past time you checked back on the portal.  You make a mental note of the cave's location so that you can return when you're ready.");
				outputText("\n\n<b>You've discovered the location of Zetaz's lair! You can visit anytime from the dungeons menu in Places tab.</b>");
				flags[kFLAGS.DISCOVERED_DUNGEON_2_ZETAZ] = 1
				simpleChoices("Enter", roomEntrance, "", null, "", null, "", null, "Leave", exitDungeon);
			}
			else 
			{
				outputText("You make your way back to the cave entrance.");
				doNext(roomEntrance);
			}
		}
		
		private function exitDungeon():void {
			kGAMECLASS.inDungeon = false;
			outputText("You leave the cave behind and take off through the deepwoods back towards camp.", true);
			doNext(camp.returnToCampUseOneHour);	
		}
		
		private function checkDoor1():void {
			if (flags[kFLAGS.ZETAZ_DOOR_UNLOCKED] <= 0)
			{
				outputText("The door won't budge.", true);
				doNext(roomGatheringHall);
				return;
			}
			else roomZetazChamber();
		}
		private function checkExit():void {
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 3 && flags[kFLAGS.ZETAZ_DEFEATED_AND_KILLED] <= 0) {
				outputText("The door appears to be locked as if by magic! You'll have to defeat Zetaz before you can leave.", true);
				doNext(roomGatheringHall);
				return;
			}
			else roomTunnel();
		}
		
		private function takeBondageStraps():void {
			clearOutput();
			flags[kFLAGS.ZETAZ_LAIR_TOOK_BONDAGE_STRAPS]++;
			inventory.takeItem(armors.BONSTRP, roomSecretPassage);			
		}
		
		//Sean the Incubus
		private function investigate():void {
			spriteSelect(52);
			clearOutput();
			outputText("You try to sneak closer to get a closer look at him, but the demon immediately stops what he's doing and stares straight at you.  He laughs, \"<i>Well now I know what happened to all the demons inside.  I really would've expected a bunch of renegades like them to put up a better fight.</i>\"\n\n", false);
			outputText("Caught, you stand up and ready your " + player.weaponName + ", taking up a defensive stance to ready yourself for whatever new attacks this demon has.  Strangely, he just starts laughing again, and he has to stop to wipe tears from the corners of his eyes before he talks, \"<i>Oh that's rich!  I'm not here to fight you, Champion.  I doubt I'd stand much of a chance anyways.  I heard there were some renegades around this area, so I thought I'd show up to offer my services.  You see, I'm a procurer of strange and rare alchemical solutions.  Of course you beat down everyone before I got here, but I thought I'd stick around and see if some scouts were still around before I high-tailed it out of here.</i>\"\n\n", false);
			outputText("You stare, blinking your eyes in confusion.  A demon of lust, and he's not interested in fighting or raping you?  He laughs again as he reads your expression and calmly states, \"<i>No, I'm far from your average incubus.  To tell the truth I enjoy a spirited debate or the thrill of discovery over sating my sexual appetite, though of course I do indulge that from time to time.</i>\"\n\n", false);
			outputText("The strange incubus flashes you a smile that makes you feel a tad uncomfortable before he finally introduces himself, \"<i>The name's Sean, and as you seem to be kicking the living shit out of Lethice's followers and enemies alike, I'd like to be on your side.  So I propose a mutually beneficial agreement – I'll sell you items you can't get anywhere else, and you let me live in this cave.  What do you say?</i>\"\n\n", false);
			simpleChoices("Deal", seanDeal, "No Deal", seanNoDeal, "Not Now", seanNotNow, "", null, "", null);
		}
		
		private function seanDeal():void {
			spriteSelect(52);
			clearOutput();
			outputText("\"<i>Excellent!  Give me a few moments to gather my things and I'll be open for business!</i>\" exclaims the strange demon.  If his story is true it's no wonder he doesn't get along with the rest of his kind.");
			
			//[Next – to room]
			flags[kFLAGS.ZETAZ_LAIR_DEMON_VENDOR_PRESENT] = 1;
			doNext(roomEntrance);
		}
		private function seanNoDeal():void {
			spriteSelect(52);
			clearOutput();
			flags[kFLAGS.ZETAZ_LAIR_DEMON_VENDOR_PRESENT] = -1;
			outputText("Sean nods, grabs a pack, and takes off running before you have a chance to kill him.");
			doNext(roomEntrance);
		}
		private function seanNotNow():void {
			spriteSelect(52);
			clearOutput();
			outputText("\"<i>Very well. Come back when you've changed your mind,</i>\" Sean sighs.");
			doNext(roomEntrance);
		}
		
		public function incubusShop():void {
			spriteSelect(52);
			if (flags[kFLAGS.NIAMH_SEAN_BREW_BIMBO_LIQUEUR_COUNTER] == 1) {
				kGAMECLASS.telAdre.niamh.getBimboozeFromSean();
				return;
			}
			clearOutput();
			outputText("Sean nods at you and slicks his hair back into place, threading it carefully around the small nubs of his horns before asking, \"<i>What can I do for you?</i>\"", false);
			menu();
			if (player.hasItem(consumables.BIMBOCH) && flags[kFLAGS.NIAMH_SEAN_BREW_BIMBO_LIQUEUR_COUNTER] == 0) {
				outputText("\n\nSean could probably do something with the Bimbo Champagne if you had enough of it...");
				if (player.hasItem(consumables.BIMBOCH, 5)) {
					addButton(4, consumables.BIMBOLQ.shortName, kGAMECLASS.telAdre.niamh.yeahSeanLetsBimbooze);
					outputText("  Luckily, you do!");
				}
			}
			addButton(0, consumables.NUMBROX.shortName, buyItem, 0);
			addButton(1, consumables.SENSDRF.shortName, buyItem, 1);
			addButton(2, consumables.REDUCTO.shortName, buyItem, 2);
			addButton(3, weapons.SUCWHIP.shortName, buyItem, 3);
			addButton(14, "Leave", roomEntrance);
		}		
		
		private function buyItem(item:Number = 0):void
		{
			spriteSelect(52);
			if (item == 0) incubusBuy(consumables.NUMBROX);
			if (item == 1) incubusBuy(consumables.SENSDRF);
			if (item == 2) incubusBuy(consumables.REDUCTO);
			if (item == 3) incubusBuy(weapons.SUCWHIP);
		}

		public function incubusBuy(itype:ItemType):void {
			spriteSelect(52);
			clearOutput();
			outputText("The incubus lifts " + itype.longName + " from his shelves and says, \"<i>That will be " + (itype.value * 3) + " gems.  Are you sure you want to buy it?</i>\"", false);
			if (player.gems < (itype.value * 3)) {
				outputText("\n<b>You don't have enough gems...</b>", false);
				doNext(incubusShop);
				return;
			}
			doYesNo(Utils.curry(incubusTransact,itype), incubusShop);
		}

		public function incubusTransact(itype:ItemType):void {
			spriteSelect(52);
			clearOutput();
			player.gems -= itype.value * 3;
			statScreenRefresh();
			inventory.takeItem(itype, incubusShop);
		}
		
		private function fightImpHorde():void {
			startCombat(new ImpHorde(),true);
			playerMenu();
		}
		
		//Encapsulation pod
		public function getSwordAndGetTrapped():void {
			clearOutput();
			outputText("You start to walk over to the corpse and its discarded weapon, but halfway through your journey, the unexpected happens.   The leaf-like petals shift underfoot, snapping up with lightning-quick speed.  You ", false);
			if (player.spe < 50) outputText("fall flat on your " + player.assDescript() + ", slipping on the slick, shifting surface.", false);
			else outputText("stumble and nearly fall, slipping on the shifting, slick surface.", false);
			getTrappedContinuation();
		}
		public function flyToSwordAndGetTrapped():void {
			clearOutput();
			outputText("You start to fly over to the corpse and its discarded weapon, but about halfway through your flight, the unexpected happens.  One of the leaf-like petals springs up and slaps into your face with stunning force, dropping you to the ground.  You try to pick yourself up, but slip on the shifting, slick surface of another pad.", false);
			getTrappedContinuation();
		}
		public function getTrappedContinuation():void {
			outputText("\n\nA loud 'slap' nearly deafens you, and the visible light instantly diminishes to a barely visible, purple glow.  The fungal 'leaves' have completely encapsulated you, sealing you inside a fleshy, purple pod.  No light can penetrate the thick sheath surrounding you, but muted illumination pulses from the flexing walls of your new prison, oscillating in strength with the subtle shifts of the organic chamber.\n\n", false);
			outputText("The sweet aroma that you smelled before is much, MUCH stronger when enclosed like this.  It's strong enough to make you feel a little dizzy and light-headed.  Deciding that you had best escape from this impromptu prison with all possible speed, you try to find a joint to force your way out through, but the pod's walls appear completely seamless.  You pound on the mushy surface, but your repeated blows have little effect.  Each impact brings with it a burst of violet radiance, but the fungus seems built to resist such struggles.  Moisture beads on the capsule's walls in larger and larger quantities, drooling into a puddle around your feet.\n\n", false);
			outputText("Meanwhile, a number of tentacles have sprung up from below, and are crawling up your " + player.legs() + ".  It's becoming fairly clear how the skeleton wound up in this cave...  You've got to escape!", false);
			startCombat(new EncapsulationPod(),true);
		}
		public function encapsulationVictory():void {
			if (monster.HP <= 0) {
				flags[kFLAGS.ZETAZ_FUNGUS_ROOM_DEFEATED]++;
				clearOutput();
				outputText("The pod's wall bursts under your onslaught.  The strength goes out of the tentacles holding you at once, giving them all the power of a limp noodle.  The spongy surface of the pod gives out, and the 'petals' split apart, falling down to the ground with a heavy 'thwack'.  You stand there, exulting in your freedom.  You've won!\n\nThe rapier you approached originally still lies there, and you claim your prize.", false);
			}
			combat.cleanupAfterCombat();
		}
		
		//Vala
		public function loseToVala():void {
			spriteSelect(85);
			if (player.gender == 3) loseToValaAsHerm();
			if (player.gender == 1) loseToValaAsMale();
			if (player.gender == 2) loseToValaFemale();
			if (player.gender == 0) {
				clearOutput();
				outputText("Vala forces a bottle into your throat before your defeated form has a chance to react, and you grunt with pleasure as a new gash opens between your " + player.legs() + "!", false);
				player.createVagina();
				player.gender = 2;
				doNext(loseToValaFemale);
			}
		}
		//Fight Loss-
		//(Herm)
		public function loseToValaAsHerm():void {
			spriteSelect(85);
			clearOutput();
			outputText("You collapse, no longer able to stand, and gasp weakly. The fairy took entirely too much delight in the fight, and her wet pussy is practically squirting with every heartbeat as she hovers over you, rubbing herself in anticipation. \"<i>The masters' will be happy. They will reward their Bitch with cum.</i>\" Her mouth drools as much as her slavering snatch. \"<i>Oh so much cum, and all for their good little pet.</i>\"\n\n", false);
			outputText("With a strength that seems out of place for the girl's rail-thin arms, she drags you to the center of the room and lifts your arms into the air. Licking up and down your " + player.skinDesc + ", she grabs a pair of dangling manacles from the ceiling and claps them around your wrists with a metallic snap that seems horribly final to you. Responding to the sudden weight, the device the manacles are attached to begins to haul upward, pulling your chain into the air and lifting you by your arms into a slouched heap, dangling helplessly. The girl licks down your ribs, over your abdomen, and slathers your " + player.hipDescript() + " in her saliva. More clapping irons puncture your weakened awareness and you jerk your body to find that she's bound your " + player.legs() + " to the floor. You shiver, hanging in the rusty fetters, fearing what must surely be coming.\n\n", false);
			outputText("Expecting her to call for the imps at any moment, you are surprised when the fairy flies up to the ceiling and pulls down a long, cow skin hose. The leather pipe is stained, its stitching is crude at best, and bears a small, twistable spigot, but what worries you are the nozzles. Made of a blackened iron, the head of the hose branches into two, forking protrusions, both shaped like the foul, hooked cocks of imps. She licks the device reverently and lowers it toward her own, dripping pussy, nearly stuffing it inside her body before she remembers the rewards her masters are sure to shower her with, perhaps literally.\n\n", false); 
			outputText("At least the fairy's desire lubricated the thing, you think, giving yourself small comfort before the fairy brings the wicked, two-pronged device to your " + player.vaginaDescript(0) + " and " + player.assholeDescript() + ". You tremble at how cold it is, and try to shift away, but the chains and your own weakness leave you at the girl's mercies. She slides the dildo into your holes with agonizing slowness, giggling the whole time, until the metal cockheads are fully inside you. \"<i>It is good to be a toy,</i>\" she coos. \"<i>Good toys get used every day.</i>\" With a playful kiss on your rump, she gives the spigot the tiniest of turns and you hear a gurgling surge from somewhere above you. The hose comes alive in her hands and begins to twist and writhe in the air as some horrible fluid is pumped through it, toward the iron cocks and your defenseless nethers. You clench as hard as you can, trying to expel the penetrating shafts, but the fairy seems to be getting stronger and more mad the longer this goes on. You moan and try to prepare for the worst.\n\n", false);
			//[Next]
			doNext(loseToValaAsHermPartII);
		}
		public function loseToValaAsHermPartII():void {
			spriteSelect(85);
			clearOutput();
			outputText("It proves to be so much worse than you thought. Even though the nozzle is at its lowest setting, you can feel hot spunk flowing into your cunt and colon, the hose jerking as globs of the jizz begin to ooze into your recesses. The fairy laughs with a voice that is all the more wicked from the pure, clean, crystal tones it carries. \"<i>The masters' love is so sweet inside us. More future masters for us to birth and so many orgasms.</i>\" She begins to tweak her clit and turns up the crank a notch, the trickle of slimy goo becoming a regular pumping. If not for the coldness of the metal inside you, the heat of the cum would be unbearable. You have the horrible realization that imps must be filling the hidden reservoir even as their fairy slave guides it into you. You scream in disgust and wriggle your " + player.buttDescript() + ", trying to get the cursed toy out of you.\n\n", false);
			outputText("The fairy is too aroused by your bondage and she can't help herself from joining in. She pulls the cum pump from your sopping holes and flutters against your chest. Slamming herself on your " + player.cockDescript(0) + ", she twists the hooking tubes so that one plugs back into your spunk-drooling " + player.vaginaDescript(0) + " and the other into her ass. The girl screams right along with you, her mindless joy drowning out your dismay as she bucks against your " + player.hipDescript() + " in time to the cum flooding the two of you. \"<i>We're good sluts,</i>\" she gurgles. \"<i>Maybe- ah- Bitch will keep you secret from t-t-the masters for a while longer. Prepare you- ooo- for them. You will be so o-O-OBEDIENT. You'll learn to love Vala,</i>\" she whispers, a gleam of intellect shining through her broken mind for an instant. She grips the iron shafts and jams them deeper into your bodies, her bloated labia squeezing your " + player.cockDescript(0) + " all the tighter. The hooked glans at the tip of the pump drive her wild and she begins hard-fucking the two of you with it, parting your cervix even as you slam into hers.\n\n", false); 
			outputText("She kisses your " + player.nippleDescript(0) + " and your spine shivers as you hear her twisting the spigot off of the base, releasing the flow. You try to scream, but your voice is ripped from your throat as a cascading geyser of fresh imp cum is blasted into your womb with enough force to launch you forward, straining against the mounted fairy, only held aloft by your chains. Your senses are assaulted by the unholy scene, the sound of creaming seed spurting against your womb carries over the pitched voices with a frothing gush. The firehose of jizz inflates your body with the foaming spunk even as it fills the fairy like an overused onahole, her fey waist bloating against your groin as your abdomen swells to meet it. The pressure of the straining cavities squishes some of the cum back out of your " + player.vaginaDescript(0) + ", just as you orgasm, splattering your seed into the overstuffed fairy. The mind-erasing cum flood pumping into you feels like it has lit a fire in your body that is searing your womb and working its way up your gut toward your head.\n\n", false); 
			outputText("You cry out desperately, but the fairy is the only one to hear your pleas and she is lost in her own sea of brainless orgasms. You resist the swarming sensations, trying to avoid the fairy's fate, but she's got you trapped between her twitching cunt and the jizz-blasting hose. All you can think of is the over-ripe sweetness of the fairy's fluids splashing against your thighs and the jack-hammering blasts of seed flooding your blazing cunt. The fire in your gut creeps up to your " + player.allBreastsDescript() + " and your heart pounds with as much force as the foot of cum-fed iron inside your overflowing " + player.vaginaDescript(0) + ". You try to promise yourself that you won't give in, but your captor twisting on your cumming cock and the barbed dildo inside your spunk-inflated womb drive the words from your mind. The heat in your breast surges into your head and it almost feels as if the seed blasting into your birth canal has made it up to your brain. You try to think, but it's too difficult. Thinking brings terrible pain, it's so much easier to surrender. To let yourself break. You look into the enslaved fairy's empty, pink eyes one more time and whisper a prayer of thanks to your Mistress. She seems started by the title and a slow smile spreads across her heart-shaped face. Then, all thought fades and your world becomes pink.\n\n", false);
			//[Go to Bad End 1]
			doNext(badEndValaNumber1);
		}
		//Fight Loss-
		public function loseToValaAsMale():void {
			spriteSelect(85);
			outputText("You collapse, no longer able to stand, and gasp weakly. The fairy took entirely too much delight in the fight, and her wet pussy is practically squirting with every heartbeat as she hovers over you, rubbing herself in anticipation. \"<i>Bitch will show you the masters' pleasures. They will reward it with cum.</i>\" Her mouth drools as much as her slavering snatch. \"<i>Oh so much cum, and all for their good little slut.</i>\"\n\n", false);
			outputText("You are powerless to stop the fairy as she drags you to the south wall and up to the wooden rail secured a couple of feet off the ground. \"<i>When she was still growing, Bitch was too small and tight for the masters,</i>\" your captor tells you. \"<i>They blessed her with this ladder to make us big enough. You will feel their generosity.</i>\" Gripping you under the arms, the fairy's lust-fuelled strength lifts you off the ground and flies you directly over the bristling peg ladder.\n\n", false);
			//[Next]
			if (player.ass.analLooseness < 2) doNext(loseToValaAsMaleIITight);
			else if (player.ass.analLooseness < 3) doNext(loseToValaMaleIILoose);
			else if (player.ass.analLooseness < 5) doNext(loseToValaMaleIIVeryLoose);
			else doNext(loseToValaMaleIIGape);
		}
		public function loseToValaAsMaleIITight():void {
			spriteSelect(85);
			clearOutput();
			//(tight ass)
		//	if (player.ass.analLooseness <= 1) {
			outputText("\"<i>It will never please them like that,</i>\" she scolds. \"<i>You must be made more to their liking or they will never grant you endless joy.</i>\" She grinds her button-stiff clit against your abdomen as she lowers you toward the smallest peg on the rail, an uncarved, lacquered wooden nub an inch wide and three inches long, barely larger than a finger. You try to attack the fairy before she can plug you in, but she simply drops you the rest of the way, and what should've been a relatively painless insertion becomes agonizing as you hit the peg and three inches of hardened wood fill your " + player.assholeDescript() + ". You gasp and try to get off the device, but the fairy has already grabbed you again and pulls you back into the air. You clench your muscles as you look at the far end of the ladder in horrified fascination at a wooden carving that would shame a minotaur. The fairy moves up a couple of notches.", false);
			//[Player gets looser ass, and move to next level]
			player.ass.analLooseness = 2;
			//[Next]
			doNext(loseToValaMaleIILoose);
		}
		public function loseToValaMaleIILoose():void {
			spriteSelect(85);
			clearOutput();
			//(loose ass)
			outputText("\"<i>Sluts are trained well,</i>\" she sighs, happily. \"<i>This one knows only the pleasures of the masters, now.</i>\" The peg under you would be above average on a normal human- easily 7 inches long and two inches wide. Your " + player.assholeDescript() + " clenches and you writhe in the fairy's arms, but she lets gravity do her dirty work, lowering you onto the human-sized wooden cock, the varnished surface pulling apart your " + player.buttDescript() + " and sliding into your nethers with an uncomfortable tight sensation. Despite the humiliation of the rape, the pressure on your prostate begins pumping blood into your " + player.cockDescript(0) + ", turning your body into a traitor. You don't dare try to pull off, for fear of the damage it might do to your anus, and you are forced to sit in shame on the wooden erection. The girl flutters down and laps at your stiffening cock, trying as hard as she can not to mount you then and there. Her hungry tongue takes some of the building pain from you. Finally, she decides you've had enough and lifts you into the air, but to your dismay, she takes you another few notches down the line.", false);
			//[Player's ass widens and go to next]
			player.ass.analLooseness++;
			//[Next]
			doNext(loseToValaMaleIIVeryLoose);
		}
		//(Very loose ass)
		public function loseToValaMaleIIVeryLoose():void {
			spriteSelect(85);
			clearOutput();
			outputText("The fairy suspends you over a bulbous cock, at least a foot long and three inches wide, carved to resemble an imp's barbed, demonic shaft. \"<i>The masters are very kind,</i>\" the girl promises, \"<i>They know a slut's limits and gladly help it exceed them. They will rebuild you to their liking.</i>\" The memory of her own training has overwhelmed her dulled expression and she can't help but mount you in the air, swinging her legs around your waist and guiding her slavering pussy to your " + player.cockDescript(0) + ". Just as your head slides into her cunt, however, she loses her grip and you fall from her arms, landing atop the imp dick, drawing an agonized scream of pain. The twelve inches of wood worn down to a polished gleam vanish up your " + player.assholeDescript() + " and distort your intestines. You are so full that you feel like you've been speared through the gut, but your prostate does not care about your misery. Full penetration drives your cock wild and it surges to life, pulsing with every heartbeat. You can feel an orgasm building, but all you care about is the crushing pressure in your nethers. Just before you can cum, the fairy lifts you off the terrible prong and you actually sigh in relief, despite being denied release. Your cock twitches in the open air and it feels like a weight has been lifted from your chest. She giggles and flies you all the way to the last prong.\n\n", false);
			//[Player's ass widens and go to last]
			player.ass.analLooseness = 5;
			//[Next]
			doNext(loseToValaMaleIIGape);
		}
		//(Gaping asshole)
		public function loseToValaMaleIIGape():void {
			spriteSelect(85);
			clearOutput();
			outputText("The fairy takes you to the final peg along the rail. It is a nightmarish mix of horse, dog, and minotaur cock. It has a flared head, to make the initial penetration all the more painful, a bulging knot on the end to utterly destroy your spincter, and the whole thing stands a foot and a half tall, nearly five inches wide at the tip. You beg the fairy. You plead. There is no way you can go onto that, you say, it will kill you. All dignity flees as you pitifully sob up to her. You'll do whatever the imps want- whatever the Masters want, you correct yourself. You'll be their toy and cum dump, you'll drink every last bit of your masters' love until you can't taste anything else. You will surrender yourself to them, body and soul. Whatever it takes, you implore, just not that peg! The fairy doesn't respond, her pupil-less eyes unchanging and unmoved by your agony, just swirling with pink lust and trained obedience. She lowers you just enough for you to feel the hard, flared tip of the monstrous thing press against your " + player.assholeDescript() + " and your resolve fails you. You promise the fairy everything. She lifts you up off the terrible final peg and you laugh in relief.\n\n", false);
			outputText("Turning you around in her arms, the fairy lets you see the full depths of mindless depravity in her empty gaze. She strokes your " + player.cockDescript(0) + ", bringing it just shy of climax before mounting you, her sopping cunny softer and warmer than anything you can remember. \"<i>Silly toy,</i>\" she whispers to you. \"<i>It has nothing to give. The masters possess everything already.</i>\" She gives you a peck on the cheek and stops flapping her dragon-fly wings, letting the two of you plummet toward the monstrosity. Your world explodes into pain and your cock erupts with a mind-breaking orgasm inside the girl before your vision fails and the merciful oblivion of unconsciousness rushes over you.", false);
			//[Go to Bad End 2]
			doNext(badEndValaNumber2);
		}
		//Fight Loss-
		//(Female)
		public function loseToValaFemale():void {
			spriteSelect(85);
			clearOutput();
			outputText("You collapse, no longer able to stand, and gasp weakly. The fairy took entirely too much delight in the fight, and her wet pussy is practically squirting with every heartbeat as she hovers over you, rubbing herself in anticipation. \"<i>It will show you the masters' pleasures. They will reward it with cum.</i>\" Her mouth drools as much as her slavering snatch. \"<i>Oh so much cum, and all for their good little Bitch.</i>\"\n\n", false);
			outputText("The fairy paces around you, a look of false sympathy running across her face like a mask. \"<i>Does it hurt? Come, Bitch will make you feel better.</i>\" She loops one of your arms around her slim shoulders and lifts you with an ease that makes you shudder. With surprising strength, she flies you to a corner of the room and carefully sets you down atop a dingy, cum-stained pillow. Despite the disgusting conditions, it is more comfort than you expected at the mad girl's hands and you allow yourself a sigh as you gather your thoughts, trying to think of a way out of this predicament. You are startled when a loud clank breaks your reprieve and you try to rise, only to be jerked back down to your " + player.buttDescript() + ". You claw at your neck and find that the fairy has slapped a steel collar around you, with barely two feet of chain keeping it off the ground.\n\n", false);
			outputText("\"<i>It is so tired after such a big day, aren't you?</i>\" she asks, sweetly. \"<i>Sluts just need a bath and a warm meal. We will be much happier soon.</i>\" The girl lifts her hand to a lever set cleverly into the wall so as to be nearly invisible. You tremble at the implications and are nearly relieved when all it produces is an ice-cold bath from a nozzle in the ceiling above. You gasp at the freezing water and struggle to get out of the downpour, but your collar keeps you under it, the water washing over you and stealing the warmth from your limbs. The cold turns your chest into a crushing weight that squeezes the breath from your lungs. When it finally relents, you pant desperately while the water washes down the drain in the center of the room. You feel like a soggy mess, " + player.hairDescript() + " wet and icy.\n\n", false);
			outputText("Trying to regain your composure after nearly being drowned and frozen in one go, you hardly even notice when the fairy places a big bucket in front of you. \"<i>All clean? The slut looks so pretty now. But it has to make itself presentable. The masters must enjoy your appearance and smell as much as your flesh. One warm meal for a good pet.</i>\" You curse the slave and knock the bucket over, spilling its vile contents onto the floor, seething spunk sliding down to the drain. The girl laughs, spritely voice like shattered crystal. \"<i>Bitch remembers when she was as defiant as you. If the sweet slut does not want her meal, perhaps another bath?</i>\" She slides her hand to another switch and leans on it, while licking her lips. Instead of rushing water, a curtain of white fills your eyes, nose, and mouth, a rush of seething heat pouring around you. Clawing at your face and the collar, you realize she's dumped a shower of splattering cum on you from some recessed reservoir in the ceiling. You scream and thrash, but the goo just keeps coming, burying you in a slimy shell, your defiance only allowing it to roll down your throat with hacking swallows. When you finally slump down and let it run over you, the fairy relents.", false);
			
			//[Next]
			doNext(loseToValueFemalePtII);
		}
		public function loseToValueFemalePtII():void {
			spriteSelect(85);
			clearOutput();
			outputText("You shiver uncontrollably and hug yourself like a wounded animal. Your " + player.nippleDescript(0) + " and " + player.clitDescript() + " burn under the pale goop, rock hard and pulsing with demands for stimulation. The fairy bitch happily places a new bucket next to you, this one fuller than the first. \"<i>It wants a meal?</i>\" she inquires doubtfully, perhaps hoping to keep it for herself. You reluctantly reach for the bucket, nearly lunging when it looks like the fairy is about to pull the lever again. You look into the bucket and shiver as the stench of the spooge assails your nostrils, even more potent than the jizz bath rolling down your bare skin in cream bulbs. You reluctantly take a glob between your fingers and thumb and with a timid motion, you raise your fistful of the odious syrup and spread it over your lips like a soapy lather. Rubbing the vile goo so close to your nose makes you nearly convulse at the reek and you hug at your slime-soaked body, trying to curl up, away from the reeking bucket. Your lower torso becomes a sloppy mess of pale, nearly clear fluid rolling off of your curves in blobby clumps.", false);
			
			outputText("You catch yourself rubbing the spooge against your " + player.skinDesc + " and into your " + player.allBreastsDescript() + " and you shake your head, trying to clear your mind. Remember how horrible it smells, you stress to yourself. It's disgusting and you're only doing it to please the insane fairy. Still, you shiver when you reach your nipples and find your thumbs applying too much pressure to your yielding softness, rubbing the spunk across your " + player.skinDesc + " in tight circles. Your next handful is larger and the next is larger still, until you drag the bucket closer to catch more of its dripping load with your flesh. You rub the warm jizz into your flesh, reveling in the heat it bleeds into your dripping body, the smell curling around your nostrils and filtering into your brain. You slop globs of oily cum across your face and head, rubbing it into your nostrils with your pinkies.\n\n", false);
			
			outputText("You lift the bucket, ready to slurp up the whole pail when the fairy makes an off-handed comment. \"<i>The masters mix their love with minotaur beasts, to make it seep into your mind,</i>\" she sighs, wistfully, looking terribly envious of your position. The girl seems to regret giving you the addictive cum, her words dulled by your jizz-drunk senses. Dimly, some part of your mind wonders if the minotaurs' drug-like seed is already working, but it hardly matters anymore. You're too far gone by now. You put the bucket in your lap and bend down, into it. Placing the tip of your nose against its lurid surface, you breathe deeply, drinking in the odor as much as savoring the moment. Then, with relish, you submerge your " + player.face() + " into the inky abyss of the spunk bucket, inhaling the sweet honey with an open mouth, air escaping your throat and bubbling up as you suck down gulp after gulp from your full-facial meal. The imp juice shower set your skin on fire, but drinking their salty discharge fills your organs with a raging inferno that drives away your memories, one by one. You gulp mouthfuls down, without even pausing to breathe. Every swallow blanks a part of your mind, first your crusade against the demons of the cave, then the friends you've met in this world, and then even your home. The liquid passion fills your mind, burying all else. Every part of your personality is replaced by the need for ejaculate and your vision turns white as, finally, you can't seem to recall your name.", false);
			
			//[Go to Bad End 2]
			doNext(badEndValaNumber2);
		}
		//Fight Win-
		public function fightValaVictory():void {
			spriteSelect(85);
			clearOutput();
			outputText("The fairy girl collapses, well-drilled obedience robbing her limbs of their fight. She squirms to a crouching bow, fully accepting you as her new " + player.mf("Master","Mistress") + ". The warped fae's empty eyes look up at you, her face a mask of rapture as she anxiously awaits her punishment, wagging her butt in the air as lubrication gushes down her thighs. It seems being defeated has excited the broken creature to a breeding frenzy. Her endurance must be incredible to be this frisky after your battle.", false);
			flags[kFLAGS.TIMES_PC_DEFEATED_VALA]++;
			//[Fuck] [Leave]
			if (player.gender > 0) {
				outputText(" What will you do?", false);
				simpleChoices("Fuck",vala.valaFightVictoryFuck,"", null,"", null,"", null,"Leave", combat.cleanupAfterCombat);
			}
			else combat.cleanupAfterCombat();
		}
		
		//Imp gang
		public function impGangVICTORY():void {
			clearOutput();
			//Flag them defeated!
			flags[kFLAGS.ZETAZ_IMP_HORDE_DEFEATED] = 1;
			if (monster.HP < 1) outputText("The last of the imps collapses into the pile of his defeated comrades.  You're not sure how you managed to win a lopsided fight, but it's a testament to your new-found prowess that you succeeded at all.", false);
			else outputText("The last of the imps collapses, pulling its demon-prick free from the confines of its loincloth.  Surrounded by masturbating imps, you sigh as you realize how enslaved by their libidos the foul creatures are.", false);
			if (player.lust >= 33 && player.gender > 0) {
				outputText("\n\nFeeling a bit horny, you wonder if you should use them to sate your budding urges before moving on.  Do you rape them?", false);
				if (player.gender == 1) simpleChoices("Rape",impGangGetsRapedByMale,"", null,"", null,"", null,"Leave", combat.cleanupAfterCombat);
				if (player.gender == 2) simpleChoices("Rape",impGangGetsRapedByFemale,"", null,"", null,"", null,"Leave", combat.cleanupAfterCombat);
				if (player.gender == 3) simpleChoices("Male Rape",impGangGetsRapedByMale,"Female Rape",impGangGetsRapedByFemale,"", null,"", null,"Leave", combat.cleanupAfterCombat);
			}
			else combat.cleanupAfterCombat();
		}
		public function impGangGetsRapedByMale():void {
			clearOutput();
			outputText("You walk around and pick out three of the demons with the cutest, girliest faces.  You set them on a table and pull aside your " + player.armorName + ", revealing your " + player.multiCockDescriptLight() + ".  You say, \"<i>Lick,</i>\" in a tone that brooks no argument.  The feminine imps nod and open wide, letting their long tongues free.   Narrow and slightly forked at the tips, the slippery tongues wrap around your " + player.cockDescript(0) + ", slurping wetly as they pass over each other in their attempts to please you.\n\n", false);
			
			outputText("Grabbing the center one by his horns, you pull him forwards until your shaft is pressed against the back of his throat.  He gags audibly, but you pull him back before it can overwhelm him, only to slam it in deep again.  ", false);
			outputText("The girly imp to your left, seeing how occupied your " + player.cockDescript(0) + " is, shifts his attention down to your ", false);
			if (player.balls > 0) outputText(player.ballsDescriptLight(), false);
			else if (player.hasVagina()) outputText(player.vaginaDescript(0), false);
			else outputText("ass", false);
			outputText(", licking with care", false);
			if (player.balls == 0) outputText(" and plunging deep inside", false);
			outputText(".  The imp to the right wraps his tongue around the base ", false);
			if (player.hasSheath()) outputText("just above your sheath ", false);
			outputText(" and pulls it tight, acting as an organic cock-ring.\n\n", false);
			
			outputText("Fucking the little bitch of a demon is just too good, and you quickly reach orgasm.  ", false);
			if (player.balls > 0) outputText("Cum boils in your balls, ready to paint your foe white.  ", false);
			outputText("With a mighty heave, you yank the imp forward, ramming your cock deep into his throat.  He gurgles noisily as you unload directly into his belly.   Sloshing wet noises echo in the room as his belly bulges slightly from the load, and his nose dribbles cum.   You pull him off and push him away.  He coughs and sputters, but immediately starts stroking himself, too turned on to care.", false);
			if (player.cumQ() > 1000) outputText("  You keep cumming while the other two imps keep licking and servicing you.   By the time you finish, they're glazed in spooge and masturbating as well.", false);
			outputText("\n\n", false);
			
			outputText("Satisfied, you redress and prepare to continue with your exploration of the cave.", false);
			player.orgasm();
			combat.cleanupAfterCombat();
		}
		public function impGangGetsRapedByFemale():void {
			clearOutput();
			outputText("You walk around to one of the demons and push him onto his back.  Your " + player.armorName + " falls to the ground around you as you disrobe, looking over your tiny conquest.  A quick ripping motion disposes of his tiny loincloth, leaving his thick demon-tool totally unprotected. You grab and squat down towards it, rubbing the corrupted tool between your legs ", false);
			if (player.vaginas[0].vaginalWetness >= VAGINA_WETNESS_SLICK) outputText("and coating it with feminine drool ", false);
			outputText("as you become more and more aroused.  It parts your lips and slowly slides in.  The ring of tainted nodules tickles you just right as you take the oddly textured member further and further into your willing depths.", false);
			player.cuntChange(15,true,true,false);
			outputText("\n\n", false);
			
			outputText("At last you feel it bottom out, bumping against your cervix with the tiniest amount of pressure.  Grinning like a cat with the cream, you swivel your hips, grinding your " + player.clitDescript() + " against him in triumph.  ", false);
			if (player.clitLength > 3) outputText("You stroke the cock-like appendage in your hand, trembling with delight.  ", false);
			outputText("You begin riding the tiny demon, lifting up, and then dropping down, feeling each of the nodes gliding along your sex-lubed walls.   As time passes and your pleasure mounts, you pick up the pace, until you're bouncing happily atop your living demon-dildo.\n\n", false);
			
			outputText("The two of you cum together, though the demon's pleasure starts first.  A blast of his tainted seed pushes you over the edge.  You sink the whole way down, feeling him bump your cervix and twitch inside you, the bumps on his dick swelling in a pulsating wave in time with each explosion of fluid.  ", false);
			if (player.vaginas[0].vaginalWetness >= VAGINA_WETNESS_SLAVERING) outputText("Cunt juices splatter him as you squirt explosively, leaving a puddle underneath him.  ", false);
			else outputText("Cunt juices drip down his shaft, oozing off his balls to puddle underneath him.  ", false);
			outputText("The two of you lie together, trembling happily as you're filled to the brim with tainted fluids.\n\n", false);
			
			outputText("Sated for now, you rise up, your body dripping gooey whiteness.  Though in retrospect it isn't nearly as much as was pumped into your womb.", false);
			if (player.pregnancyIncubation == 0) outputText("  You'll probably get pregnant.", false);
			player.orgasm();
			player.knockUp(PregnancyStore.PREGNANCY_IMP, PregnancyStore.INCUBATION_IMP - 14, 50);
			combat.cleanupAfterCombat();
		}
		public function loseToImpMob():void {
			clearOutput();
			//(HP) 
			if (player.HP < 1) outputText("Unable to handle your myriad wounds, you collapse with your strength exhausted.\n\n", false);
			//(LUST)
			else outputText("Unable to handle the lust coursing through your body, you give up and collapse, hoping the mob will get you off.\n\n", false);
			
			outputText("In seconds, the squirming red bodies swarm over you, blotting the rest of the room from your vision.  You can feel their scrabbling fingers and hands tearing off your " + player.armorName + ", exposing your body to their always hungry eyes.   Their loincloths disappear as their growing demonic members make themselves known, pushing the tiny flaps of fabric out of the way or outright tearing through them.   You're groped, touched, and licked all over, drowning in a sea of long tongues and small nude bodies.\n\n", false);
					   
			outputText("You're grabbed by the chin, and your jaw is pried open to make room for a swollen dog-dick.   It's shoved in without any warmup or fan-fare, and you're forced to taste his pre in the back of your throat.  You don't dare bite down or resist in such a compromised position, and you're forced to try and suppress your gag reflex and keep your teeth back as he pushes the rest of the way in, burying his knot behind your lips.\n\n", false);
			
			//(tits)
			if (player.biggestTitSize() > 1) {
				outputText("A sudden weight drops onto your chest as one of the demons straddles your belly, allowing his thick, tainted fuck-stick to plop down between your " + player.allBreastsDescript() + ".  The hot fluid leaking from his nodule-ringed crown  swiftly lubricates your cleavage.  In seconds the little devil is squeezing your " + player.breastDescript(0) + " around himself as he starts pounding his member into your tits.  The purplish tip peeks out between your jiggling flesh mounds, dripping with tainted moisture.", false);
				if (player.biggestLactation() > 1) outputText("  Milk starts to squirt from the pressure being applied to your " + player.breastDescript(0) + ", which only encourages the imp to squeeze even harder.", false);
				outputText("\n\n", false);
			}
			//(NIPPLECUNTS!)
			if (player.hasFuckableNipples()) {
				outputText("A rough tweak on one of your nipples startles you, but your grunt of protest is turned into a muffled moan when one of the imp's tiny fingers plunges inside your " + player.nippleDescript(0) + ".  He pulls his hand out, marveling at the sticky mess, and wastes no time grabbing the top of your tit with both hands and plunging himself in.", false);
				if (player.biggestTitSize() < 7) outputText("  He can only get partway in, but it doesn't seem to deter him.", false);
				else outputText("  Thanks to your massive bust, he is able to fit his entire throbbing prick inside you.", false);
				outputText("  The demon starts pounding your tit with inhuman vigor, making the entire thing wobble enticingly.  The others, seeing their brother's good time, pounce on ", false);
				if (player.totalNipples() > 2) outputText("each of ", false);
				outputText("your other " + player.nippleDescript(0), false);
				if (player.totalNipples() > 2) outputText("s", false);
				outputText(", fighting over the opening", false);
				if (player.totalNipples() > 2) outputText("s", false);
				outputText(".  A victor quickly emerges, and in no time ", false);
				if (player.totalNipples() == 2) outputText("both", false);
				else outputText("all the", false);
				outputText(" openings on your chest are plugged with a tumescent demon-cock.\n\n", false);
			}
			//(SINGLE PEN) 
			if (!player.hasVagina()) {
				outputText("Most of the crowd centers itself around your lower body, taking a good long look at your " + player.assholeDescript() + ".  An intrepid imp steps forwards and pushes his member into the unfilled orifice.  You're stretched wide by the massive and unexpectedly forceful intrusion.  The tiny corrupted nodules stroke every inch of your interior, eliciting uncontrollable spasms from your inner muscles.  The unintentional dick massage gives your rapist a wide smile, and he reaches down to smack your ass over and over again throughout the ordeal.", false);
				player.buttChange(12,true,true,false);
				outputText("\n\n", false);
			}
			//(DOUBLE PEN)
			else {
				outputText("Most of the crowd centers itself around your lower body, taking a good long look at your pussy and asshole.  Two intrepid imps step forward and push their members into the unplugged orifices.  You're stretched wide by the massive, unexpectedly forceful intrusions.  The tiny corrupted nodules stroke every inch of your interiors, eliciting uncontrollable spasms from your inner walls.  The unintentional dick massage gives your rapists knowing smiles, and they go to town on your ass, slapping it repeatedly as they double-penetrate you.", false);
				player.buttChange(12,true,true,false);
				player.cuntChange(12,true,true,false);
				outputText("\n\n", false);
			}
			//(DICK!)
			if (player.totalCocks() > 0) {
				outputText("Some of the other imps, feeling left out, fish out your " + player.multiCockDescript() + ".  They pull their own members alongside yours and begin humping against you, frotting as their demonic lubricants coat the bundle of cock with slippery slime.   Tiny hands bundle the dicks together and you find yourself enjoying the stimulation in spite of the brutal fucking you're forced to take.  Pre bubbles up, mixing with the demonic seed that leaks from your captors members until your crotch is sticky with frothing pre.\n\n", false);
			}
			//(ORGAZMO)
			outputText("As one, the crowd of demons orgasm.  Hot spunk gushes into your ass, filling you with uncomfortable pressure.  ", false);
			if (player.hasVagina()) outputText("A thick load bastes your pussy with whiteness, and you can feel it seeping deeper inside your fertile womb.  ", false);
			outputText("Your mouth is filled with a wave of thick cream.  Plugged as you are by the demon's knot, you're forced to guzzle down the stuff, lest you choke on his tainted baby-batter.", false);
			if (player.biggestTitSize() > 1) {
				outputText("  More and more hits your chin as the dick sandwiched between your tits unloads, leaving the whitish juice to dribble down to your neck.", false);
				if (player.hasFuckableNipples()) {
					if (player.totalNipples() == 2) outputText("  The pair", false);
					else outputText("  The group", false);
					outputText(" of cocks buried in your " + player.nippleDescript(0) + " pull free before they cum, dumping the spooge into the gaping holes they've left behind.  It tingles hotly, making you quiver with pleasure.", false);
				}
			}
			outputText("  Finally, your own orgasm arrives, ", false);
			if (player.cockTotal() == 0) outputText("and you clench tightly around the uncomfortable intrusion.", false);
			else {
				outputText("and " + player.sMultiCockDesc() + " unloads, splattering the many demons with a bit of your own seed.  You'd smile if your mouth wasn't so full of cock.  At least you got to make a mess of them!", false);
			}
			if (player.hasVagina()) {
				outputText("  Your cunt clenches around the invading cock as orgasm takes you, massaging the demonic tool with its instinctual desire to breed.  Somehow you get him off again, and take another squirt of seed into your waiting cunt.", false);
			}
			outputText("\n\n", false);
			
			outputText("Powerless and in the throes of post-coital bliss, you don't object as you're lifted on the table", false);
			if (!player.hasVagina()) outputText(" and forced to start drinking bottle after bottle of succubi milk", false);
			outputText(".  You pass out just as round two is getting started, but the demons don't seem to mind....", false);
			doNext(loseToImpMobII);
		}
		//[IMP GANGBANG VOL 2]
		public function loseToImpMobII():void {
			clearOutput();
			outputText("You wake up, sore from the previous activity and a bit groggy.  You try to move, but find yourself incapable.  Struggling futilely, you thrash around until you realize your arms and legs are strapped down with heavy iron restraints.  You gasp out loud when you look down and discover your ", false);
			if (player.biggestTitSize() < 1) outputText("new", false);
			else outputText("much larger", false);
			outputText(" tits, wobbling with every twist and movement you make.  You're stark naked, save for a sheer and somewhat perverse nurse's outfit.   The room around you looks to be empty, though you can see a number of blankets piled in the corners and a few cages full of spooge-covered faeries, all snoring contently.\n\n", false);
			
			
			outputText("Eventually a lone imp enters the room.  It's Zetaz!  He looks you up and down and decrees, \"<i>You're ready.</i>\"  You struggle to shout him down, but all that escapes the gag in your mouth is incomprehensible gibberish.  He chuckles and flips a switch on the wall, and suddenly the most heavenly vibration begins within your sopping twat.", false);
			if (!player.hasVagina()) {
				outputText("...Wait, your what?  You have a cunt now!?", false);
			}
			outputText("  Your eyes cross at the pleasure as your mind struggles to figure out why it feels so good.\n\n", false);
			
			outputText("Zetaz pours a few bottles into a larger container and connects a tube to an opening on the bottom of the bottle.  Your eyes trace the tube back to the gag in your mouth, and after feeling around with your tongue, you realize it's been threaded through the gag and down your throat.   Zetaz lifts up the bottle and hangs it from a hook on the ceiling, and you watch in horror as the fluid flows through the tube, helpless to stop it.  You shake your head desperately, furious at having fallen into the little fucker's hands at last.\n\n", false);
			
			outputText("Zetaz walks up and paws at your ", false);
			if (player.biggestTitSize() < 1) outputText("new", false);
			else outputText("larger", false);
			outputText(" mounds, flitting into the air to bring himself to eye-level.  He rambles, \"<i>It's so good to see you again, " + player.short + ".  Because of you, I had to flee from my honored place by Lethice's side.  I've had to hide in this fetid forest.  I'll admit, it hasn't been all bad.  We've caught a few faeries to play with, and with you here, the boys and I will have lots of fun.  We just need to reshape that troubled mind a little bit.</i>\"\n\n", false);
			
			outputText("You barely register his monologue.  You're far too busy cumming hard on the vibrating intruder that's currently giving your stuffed snatch the workout of a lifetime.  Zetaz chuckles at your vacant stare and massages your temples gently, and you feel the touch of his dark magic INSIDE you.  It feels warm and wet, matching the feel of your body's other intrusion.   You try to fight it, and for a moment you feel like you might push the demon out of your mind.  Then your body cums, and your resistance melts away.  You violently thrash against your restraints, caving in to the pleasure as the imp rapes your body and mind as one.\n\n", false);
			
			outputText("The desire to protect your village drips out between your legs, and thoughts of your independence are fucked away into nothing.  It feels good to cum, and your eyes cross when you see the bulge at your master's crotch, indicative of how well you're pleasing him.  It feels so good to obey!  Zetaz suddenly kisses you, and you enthusiastically respond in between orgasms.\n\n", false);
			
			outputText("You gladly live out the rest of your life, fucking and birthing imps over and over as their live-in broodmother.", false);
			player.orgasm();
			player.HP += 100;
			//GAME OVER NERD
			getGame().gameOver();
		}		
		public function defeatZetaz():void {
			flags[kFLAGS.DEFEATED_ZETAZ]++;
			clearOutput();
			//[VICTORY HP]
			if (monster.HP < 1) outputText("Zetaz sinks down on his knees, too wounded to continue.  He looks up at you with helpless rage in his eyes and asks, \"<i>Are you satisfied now?  Go ahead then, kill me.  My life hasn't been worth living since I met you anyway.</i>\"\n\n", false);
			//[VICTORY LUST] 
			else outputText("Zetaz sinks down on his knees and fishes his massive, pre-drooling member from under his loincloth.  He looks up at you, nearly crying and moans, \"<i>Why? Ruining my life wasn't enough?  You had to make me jerk off at your feet too?  Just kill me, I don't want to live anymore.</i>\"\n\n", false);
			
			//[Both] 
			outputText("He can't die yet.  You need to know where his master, this 'Lethice', is.  It sounds like she's the queen-bitch of the demons, and if you're going to break this vicious cycle", false);
			//( or take her place)
			if (player.cor > 66) outputText(" or take her place", false);
			outputText(", you need to find her and bring her down.  What do you do?", false);
			outputText("\n\n(Sexually Interrogate, Kill Him, or Offer Safety for Information?)\n", false);
			//[Sexual Interrogation] [Brutal Interrogation] [Release for Info]
			menu();
			addButton(0, "Sexual", sexualInterrogation, null, null, null, "Chain the imp up and sexually interrogate him.");
			addButton(1, "End Him", endZetaz, null, null, null, "Kill the imp. After all, he deserves to be bad-ended.");
			addButton(2, "Safety", releaseZForInfo, null, null, null, "Release the imp after you get the information you need.");
			//addButton(3, "Rape", rapeZetaz);
		}

		//[Release Zetaz 4 Info Win]
		public function releaseZForInfo():void {
			clearOutput();
			outputText("You look the pathetic imp up and down and smirk.  He closes his eyes, expecting a summary execution, but you present him with an offer instead.  If he gives you more information on Lethice and where to find her, you'll let him go scot-free and avoid him if he doesn't make a nuisance of himself.\n\n", false);
			
			outputText("\"<i>Really?</i>\" questions Zetaz in a voice laced with suspicion. \"<i>For fuck's sake, I'm already a renegade.  I'll take your deal.  It's not like it costs me anything I wouldn't give away for free anyway.</i>\"\n\n", false);
			
			outputText("Invigorated by the promise of safety and freedom, Zetaz pulls himself up and ", false);
			if (monster.HP < 1) outputText("staggers", false);
			else outputText("nearly stumbles over his lust-filled cock", false);
			outputText(" towards a desk.  His dextrous fingers twist the knob on the top drawer expertly until a quiet 'click' comes from the furniture.  He reaches down to the divider between the drawers and pulls on it, revealing a tiny, hidden compartment.  In the center of it is a detailed map of the mountain and its upper reaches.  Though the secret diagram is quite crude, it depicts a winding trail that bypasses numerous harpy nests, minotaur caves, and various unrecognizable pitfalls to reach the cloud-shrouded mountain peak.  The drawing loses much of its detail once it gets to the demon fortifications at the top, but it can't be that hard to track down Lethice once you've entered the seat of her power, can it?\n\n", false);
			
			outputText("A loincloth flies across the room and deposits itself on your shoulder, startling you from your planning.  You glance back and see Zetaz tearing through his possessions, tossing his most prized items into a burlap sack with reckless abandon.  His whole body is trembling, as he ties it to a wooden pole, never once looking up at you.  Perhaps he fears you might change your mind?  ", false);
			if (player.cor > 66) {
				outputText("You smirk down at him and fold your arms over your ", false);
				if (player.biggestTitSize() < 1) outputText("chest", false);
				else outputText(player.breastDescript(0), false);
				outputText(", relishing his fear while you consider the possibilities", false);
			}
			else if (player.cor > 33) {
				outputText("You chuckle with amusement and watch the little bastard scrabble to pack up his life, relishing the chance to pay him back for your previous encounter", false);
			}
			else {
				outputText("You sigh and rub at your temples as the little jerk scrabbles to pack his life away.  In spite of yourself, you actually feel a little bad about the situation", false);
			}
			outputText(".  Zetaz scrambles out the south door, never once looking back at the tattered remnants of his old home.", false);
			outputText("\n\n<b>(Key Item Acquired: Zetaz's Map!)</b>", false);
			player.createKeyItem("Zetaz's Map",0,0,0,0);
			combat.cleanupAfterCombat();
		}
			
		//[Sexual Interrogation]
		public function sexualInterrogation():void {
			clearOutput();
			outputText("You lean down until your face hovers over Zetaz, looking him square in the eyes, and explain, \"<i>I can't have someone who knows the way to the demons' headquarters dying before they tell me how to get there, can I?</i>\"\n\n", false);
			
			outputText("\"<i>Piss off!  You won't get shit from me,</i>\" retorts the defeated demon, \"<i>You may as well finish me off – I'll NEVER help a " + player.mf("jackass","bitch") + " like you!</i>\"\n\n", false);
			
			outputText("Smirking, you grab a strip of leather from Zetaz's dresser and dangle it over his nose.\n\n", false);
			
			outputText("You whisper, \"<i>This is all I'll need.</i>\"\n\n", false);
			
			outputText("The imp looks up with his face shrouded in confusion as he asks, \"<i>I don't think a string is going to help you much, " + player.mf("dork","skank") + ".</i>\"\n\n", false);
			
			outputText("\"<i>Give me a moment, my stupid little snitch,</i>\" you taunt as you lift his loincloth, exposing the hardness concealed within.  It pulses, growing harder and an inch longer just from your brief touch and exposure to the air.  Perhaps the imp isn't as in control of his libido as he'd like you to think?  You twirl the leather strip around his base and swiftly knot it, getting a tight enough seal to make Zetaz grunt in discomfort. \"<i>Ungh! What the fuck!? Ow, goddamnit!</i>\"\n\n", false);
			
			outputText("Even with his protests and cries, you watch his cock inflate further, until it looks stuffed far beyond his normal capacity.  It twitches and drools corrupted pre-seed as you slide your finger along his urethra, watching the member bob and twitch from the slight, soft touches.  That must feel quite good.  Zetaz confirms your hunch by lifting his hips off the ground, shaking them lewdly to try to grind against your hand.  You don't deny him the friction he craves, wrapping your hand around as much of his meat as your fingers will encircle until steady dribbles of fluid escape from his urethra.  The tainted nodules of his demonic dick begin to flare and pulse, signaling that his orgasm is almost upon him.\n\n", false);
			
			outputText("He's NOT allowed to cum – not until you get the information you need!   You slide your fingers down to his base in one fluid stroke, slamming your hand against his crotch as his orgasm starts to bubble up.  Before your opponent can attain release, you squeeze hard with one hand and tighten the leather cord with the other, clamping the base until the imp's cum is bottled up in his abdomen.  Zetaz cries, \"<i>No-no-no, let me cum, please let me cum, need-ta-cum-nooowwww.</i>\"\n\n", false);
			
			outputText("No such luck.  You wait for his body to stop convulsing and return to your task, one hand sealed around his base while the other begins to stroke him with firm, steady motions, sliding over the pebbly surface of his dick's nubs.  Your victim continues his begging and crying, but you don't let up as you pause to gather his escaped pre-cum and smear it over his tip.  Zetaz pants and groans, trembling and swelling in your hand from your efficient hand-job.   Spitting on your palm, you bump up the tempo and begin to stroke him hard and fast, sliding over his cockring-swollen prick with practiced, deliberate motions.\n\n", false);
			
			outputText("\"<i>Tell me how to find the head demon and I'll let you cum.  Don't make this any 'harder' than it has to be,</i>\" you whisper.\n\n", false);
			
			outputText("The demon's voice starts to crack in spite of his efforts to remain defiant. \"<i>No!  I-uh-won't let yo-oooooh-control meeeeee!</i>\"\n\n", false);
			
			outputText("His protests trail into incoherent squeals and babbles as you bottle up his second orgasm behind the tightly tied strap.  Again, his body twists and writhes in your grip, tortured with the ever-increasing sexual tension.  Zetaz looks up at you with a pleading, cross-eyed expression as he tries to regain his wits, but you just keep pumping away.  His balls are visibly pulsing and quivering, desperately needing to release the building pressure.  You meet his gaze calmly, your hands continuing their work on the bloated imp-cock, and you break into a knowing smile as he thickens in your grip for the third time.\n\n", false);
			
			outputText("\"<i>Well Zetaz?  Is three the lucky number, or do I have to switch hands and keep backing you up until you go mad?</i>\" you ask.\n\n", false);
			
			outputText("His hands claw the rug underneath him as he gasps, \"<i>You win, you win!  The desk has a-ah ah ahh-hidden drawer with a map to Lethice's hideout.  Please justletmecomeletmecomeletmecomePLEAAAAASE!</i>\"\n\n", false);
			
			outputText("What do you do?", false);
			//['Release' him] [Tighten Strap] [End Him]
			menu();
			addButton(0, "'Release'", sexualTortureReleaseZetaz, null, null, null, "Let the imp cum and release him from the bonds.");
			addButton(1, "Tighten", sexualTortureTightenZetaz, null, null, null, "Tighten the straps.");
			addButton(2, "End Him", endZetaz, null, null, null, "Kill the imp. After all, he deserves to be bad-ended.");
		}

		//[Release Him]
		public function sexualTortureReleaseZetaz():void {
			clearOutput();
			outputText("In a moment of kindness", false);
			if (player.lust > 60 || player.lib > 60 || player.cor > 60) outputText(", or perhaps perversion,", false);
			outputText(" you release the taut cord and allow it to unravel.  It whips off Zetaz's prick at once, tossed across the chamber by the pressure boiling forth from the imp's shaking hips.   Nodules flare from his prick's base to his tip in a wavelike motion, nearly doubling in size by the time the 'wave' reaches the ring around his crown.  Simultaneously, his urethra parts and unloads the imp's pent-up cargo with cannon-like force.  Sticky spoo rockets upwards, splatters against the ceiling, and hangs for a moment as the first 'jet' glazes the roof.  The eruption slowly peters out, letting the last of the rope fall over Zetaz's form.\n\n", false);
			
			outputText("You marvel at the force as you feel the next bulge moving up that demon-dick, squeezing past your gently caressing fingertips.  The next burst doesn't surface with the explosive force of its precursor, but what it lacks in speed, it makes up for in raw volume.  Zetaz's body arches and twitches with the effort of trying to push out three orgasms worth of backed-up demon jizz, and easily launches a missile-like globule onto his bed, where it splatters to great effect.  The third spout of white lacks the thrust and mass of it's predecessors, but easily puts out more love juice than most people's entire orgasm.  With a knowing smile on your face, you stroke out the remainder of his seed, keeping count of each rope as it's fired – four, five, six, seven, eight, nine, ten... eleven.\n\n", false);
			
			outputText("The imp has managed to soak his body, his nightstand, the bed, one of the walls, and even the ceiling, but all that pleasure came at a cost.  Zetaz's eyes have closed – the little guy passed out.  Smirking, you wipe your hand off in his hair and head over to the desk.  Somehow it managed to avoid the great spoogey deluge, and it almost seems to be standing aloof from the depraved scene that's devoured the rest of the room.  It has two visible drawers with a divider between them, but at a glance there doesn't seem to be enough room in the furniture to contain a hidden drawer or compartment.\n\n", false);
			
			outputText("You poke and prod around the desk's circumference, checking for false panels, weak points, or hidden latches inside the woodwork.  It refuses to give up its secrets, and you find yourself wondering for a moment if it's somehow capable of such deception before you dismiss the notion as insane.  For all this place's craziness, you doubt Zetaz would have a piece of possessed furniture in his bedroom.  Irritated, you yank open each drawer, but nothing seems out of the ordinary.  You grumble and slam them closed, twisting on the knobs with accidental fury.  A barely audible 'click' reaches your ears, and the divider between the drawers now protrudes ever so slightly forward, far enough to get a good grip on.\n\n", false);
			
			outputText("The unfinished wood behind the divider's facade chafes your fingertips as you gently pull on it, revealing a narrow, hidden compartment.  The only object inside is a detailed map of the mountain and its upper reaches.  Though the secret diagram is quite crude, it depicts a winding trail that bypasses numerous harpy nests, minotaur caves, and various unrecognizable pitfalls to reach the cloud-shrouded mountain peak.  The drawing loses much of its detail once it gets to the demon fortifications at the top, but it can't be that hard to track down Lethice once you've entered the seat of her power, can it?\n\n", false);
			
			outputText("You hear the faint scrabble of claws on stone and turn around, alarmed, but there's nothing there.  Not even Zetaz.  You imagine the cum-slicked imp sprinting from his own cave and into the deep woods, and the absurd image brings a smile to your face.\n\n", false);
			
			outputText("<b>(Key Item Acquired: Zetaz's Map!)</b>", false);
			player.createKeyItem("Zetaz's Map",0,0,0,0);
			combat.cleanupAfterCombat();
		}

		//[Tighten Strap] 
		public function sexualTortureTightenZetaz():void {
			clearOutput();
			outputText("\"<i>Idiot,</i>\" you taunt while you tighten the strap further.  Zetaz actually starts to bawl in anguish while another orgasm worth of cum backs up inside him.  You don't want him to get out of the binding while you search for his map, so you pull the cord under his leg and use the free end to bind his wrists together behind his back.  Fondling his turgid prick one last time for good luck, you leave him to struggle with his need as you search for your map.  It's difficult to blank out all the whines and cries, but you manage.\n\n", false);
			
			outputText("Zetaz's desk sits against a wall, just far enough away from the rest of the furniture to give it an aloof appearance.  You get up and walk closer, kicking the imp in the belly on your way in order to get a little peace and quiet.  The desk has two visible drawers with a divider between them, but at a glance there doesn't seem to be enough room in the furniture to contain a hidden drawer or compartment. It will take a more careful examination to uncover this 'map'.\n\n", false);
			
			outputText("You poke and prod around the desk's circumference, checking for false panels, weak points, or hidden latches inside the woodwork.  It refuses to give up its secrets, and you find yourself wondering for a moment if it's somehow capable of such deception before you dismiss the notion as insane.  For all this place's craziness, you doubt Zetaz would have a piece of possessed furniture in his bedroom.  Irritated, you yank open each drawer, but nothing seems out of the ordinary.  You grumble and slam them closed, twisting on the knobs with accidental fury.  A barely audible 'click' reaches your ears, and the divider between the drawers now protrudes ever so slightly forward, far enough to get a good grip on.\n\n", false);
			
			outputText("The unfinished wood behind the divider's facade grates your fingertips as you gently pull on it, revealing a narrow, hidden compartment.  The only object inside is a detailed map of the mountain and its upper reaches.  Though the secret diagram is quite crude, it depicts a winding trail that bypasses numerous harpy nests, minotaur caves, and various unrecognizable pitfalls to reach the cloud-shrouded mountain peak.  The drawing loses much of its detail once it gets to the demon fortifications at the top, but it can't be that hard to track down Lethice once you've entered the seat of her power, can it?\n\n", false);
			
			outputText("You hear the faint scrabble of claws on stone and turn around, alarmed, but there's nothing there.  Not even Zetaz.  You imagine the partly hog-tied imp sprinting from his own cave and into the deep woods, his bloated cock bobbing dangerously with every step, and the absurd image brings a smile to your face.\n\n", false);
			
			outputText("<b>(Key Item Acquired: Zetaz's Map!)</b>", false);
			player.createKeyItem("Zetaz's Map",0,0,0,0);
			combat.cleanupAfterCombat();
		}

		//[END HIM – Ew death!]
		public function endZetaz():void {
			clearOutput();
			outputText("You grab his head in both hands and twist violently, popping his neck in an instant.  Glaring down at the corpse of your first demonic foe, you utter, \"<i>Wish granted.</i>\"\n\n", false);
			outputText("With him dead, you'll have to see if there's anything here that could lead you to this 'Lethice', so that you can put an end to the ridiculous plague affecting Mareth once and for all.  Perhaps you'll even get to go home, see your family, and have a rather violent talk with certain elders?  You tear through every drawer, pack, and chest in the place, but all you find are loincloths, extraordinairily fetishist porn, and junk.  Desperate for any clue, you even search under the bed and move the furniture, but it doesn't help.  You take your displeasure out on Zetaz's furnishings, slamming them into one another with all your might.\n\n", false);
			outputText("The chair in your hands disintegrates, the desk it impacts splinters apart, and you feel a little bit better.  A piece of parchment flutters back and forth in the middle of it all, freed from some hidden compartment and mostly unscathed.  One of the corners is ripped off, and it has a tear half way across, but it's still perfectly legible.  It's a map!  Though the secret diagram is quite crude, it depicts a winding trail that bypasses numerous harpy nests, minotaur caves, and various unrecognizable pitfalls to reach the cloud-shrouded mountain peak.  The drawing loses much of its detail once it gets to the demon fortifications at the top, but it can't be that hard to track down Lethice once you've entered the seat of her power, can it?\n\n", false);
			outputText("<b>(Key Item Acquired: Zetaz's Map!)</b>", false);
			player.createKeyItem("Zetaz's Map",0,0,0,0);
			//(ZETAZ IS DEAD)
			flags[kFLAGS.ZETAZ_DEFEATED_AND_KILLED]++;
			combat.cleanupAfterCombat();
		}

		//[Lose to Zetaz]
		public function loseToZetaz():void {
			clearOutput();
			outputText("\"<i>Well, isn't this familiar?</i>\" asks Zetaz as he watches your ", false);
			if (player.lust >= player.maxLust()) outputText("masturbating", false);
			else outputText("prone", false);
			outputText(" form with an amused expression, \"<i>The first champion in ages to retain " + player.mf("his","her") + " free will for more than a few minutes, and " + player.mf("he","she") + "'s brought to " + player.mf("his","her") + " knees by the very imp " + player.mf("he","she") + " escaped!  Once you've learned your proper place, you'll guarantee my safe return to my rightful station.  Perhaps I'll even get a promotion?  After all, you've defeated so many higher ranking demons already.</i>\"\n\n", false);
			
			//'Fix' genderless folks.
			if (player.gender == 0) {
				outputText("He squints down at you with a bemused look and laughs, \"<i>How did you lose your gender anyhow?  Never mind, we've got to do something about that!</i>\"\n\n", false);
				outputText("Zetaz grabs a bottle, uncorks it, and crams it against your lips while you're still too dazed to resist.  He massages your throat to make you swallow the milk-like fluid, and in seconds the skin of your groin splits to form a new, virgin pussy.\n\n", false);
				player.createVagina();
				player.gender = 2;
			}
			//(fork to male/female/herm)
			if (player.gender == 1) malesZetazOver();
			if (player.gender == 2) femaleZetazOver();
			if (player.gender == 3) hermZetazOver();
		}

		public function femaleZetazOver():void {
			//F-drugged up and tied to the table in the main room.  Cum in by all the imps till pregnant.  Daily fuckings with accompanying mind-fuck.
				
			outputText("With your resistance ", false);
			if (player.HP < 1) outputText("beaten out of you", false);
			else outputText("moistening the delta of your legs", false);
			outputText(", you don't even struggle as Zetaz calls in several friends.   You just lie there, meek and defeated as they carry you through the tunnels towards their dining room, but from the looks in the small demons' eyes, they aren't planning to feed you... not with food, anyway.  The mob you defeated earlier seems to have returned, and gleeful hoots and catcalls ", false);
			if (player.cor < 33) outputText("shame", false);
			else if (player.cor < 66) outputText("confuse", false);
			else outputText("arouse", false);
			outputText(" you as you're thrown atop one of the tables.   You grunt as leather straps are produced and laid over your form to restrain you.  In the span of a minute you're completely immobilized from the neck down, and your " + player.legs() + " are kept spread to allow easy access to your " + player.vaginaDescript(0) + ".\n\n", false);
			
			outputText("Shuffling as they remove their garments, the entire gang of imps, as well as Zetaz, are completely nude.  They've all grown full and hard from the sight of your nubile, restrained body, and in spite of yourself you get ", false);
			if (player.vaginas[0].vaginalWetness >= VAGINA_WETNESS_DROOLING) outputText("even more wet ", false);
			else outputText("a little wet ", false);
			outputText("from the masculine scent the aroused penises are producing.  ", false);
			if (player.cor < 33) outputText("How could you be turned on by such a repulsive situation?  You're going to be raped, brainwashed, and either kept as a pet or tossed in a milking tube for the rest of your life and your body is acting like some horny slut!", false);
			else if (player.cor < 66) outputText("You marvel at just how turned on you're getting from the strange situation.  You know you'll be raped, drugged, and used as a toy or milk cow, but your loins are thrumming with warm, wet desire.", false);
			else outputText("How did you wind up in such an arousing situation?  You're going to be raped, drugged, and probably milked in a factory for the rest of your life.  Your body is so fucking turned on that you know you'll love every second of it, but your desire to triumph and dominate mourns the loss of your freedom.", false);
			outputText("  The crowd draws close, but Zetaz's voice rings out, thick with the tone of command, \"<i>Not yet, my brothers; this one will be mine first.  I'll claim each of her holes, then you may each have your fill of her.</i>\"\n\n", false);
			
			outputText("The imps draw back, clearing a path for their leader to emerge, and the new, much more imposing Zetaz climbs atop the table.   He glances at your " + player.vaginaDescript(0) + " with a knowing eye and smiles, walking further forward until he's standing next to your face with his tainted, corruption-filled cock dangling overhead.  You're so distracted by the purplish-black demon-cock swinging above your lips that the sharp pain takes you completely off-guard. As soon as the discomfort passes you twist your head around to try and find the source of your irritation.\n\n", false);
			
			outputText("Zetaz turns away from you, holding a spent needle in one of his clawed hands as he exchanges it with one of his kin for another injector, only this one is filled with viscous white fluid.  He glances down at you, watching you intently for some kind of reaction, but you won't give him the satisfaction!  Even so, the room is getting so bright that your eyes start tearing up, and you blink repeatedly to rid yourself of them before half-closing your eyelids to shield your poor pupils.  Maybe that's what he's looking for?  The room spins and you find yourself thankful to be strapped down; even if only seated, you would probably tumble from your chair.\n\n", false);
			
			outputText("Your lips start to tingle, and you run your tongue over them reflexively.  A shiver of pleasure worms through your body, and you instinctively press your " + player.legs() + " against the straps in an effort to spread them further.  Worse yet, your lips feel much plumper and fuller than a few moments ago.  ", false);
			if (flags[kFLAGS.NUMBER_OF_TIMES_MET_SCYLLA] > 0) outputText("Unbidden, Scylla's face comes to mind, and you realize the drugs coursing through your veins must be doing something similar to you!  Her visage changes to your own, though the thick, cock-sucking lips remain behind, eager to be penetrated.", false);
			else outputText("Unbidden, you imagine yourself with thick, cock-sucking lips, so swollen and bloated that they're slightly pursed and ready to be penetrated.", false);
			outputText("  Warm slipperiness slides over your lips again, feeling nearly as good as it would on your lower lips, and you pull your rebellious tongue back into your mouth with a gasp of pleasure.\n\n", false);
			
			outputText("This must be what Zetaz was waiting for, and the imp carefully injects the next chemical cocktail into the other side of your neck while you're distracted by orally masturbating your new mouth.  Your " + player.vaginaDescript(0) + " ", false);
			if (player.vaginas[0].vaginalWetness >= VAGINA_WETNESS_DROOLING) outputText("gushes fresh fluids into a puddle on the table", false);
			else if (player.vaginas[0].vaginalWetness >= VAGINA_WETNESS_WET) outputText("drools a heavy flow of liquid arousal onto the hardwood table", false);
			else outputText("begins to dribble a steady flow of liquid on to the table's girl-slicked boards", false);
			outputText(".  ", false);
			if (player.inHeat) outputText("D", false);
			else outputText("Foreign d", false);
			outputText("esires wash through your doped up body, and your hungry slit practically demands to be filled with cock and injected with semen.  It wants to be filled with... with males, and with their hot, sticky cum. No, your hot little pussy doesn't want that – you do.  Gods above and below, you want to feel your belly pumped full of imp sperm until their offspring are wriggling in your womb.  And then you want them to come in you some more!\n\n", false);
			
			outputText("That sexy-... no, that bastard's dick is so hard, and he's starting to squat down now that you're feeling so randy.  The artificial needs coursing through your body make it hard to resist, but you've got to try!  You can't open your mouth and... mmm, it feels so good when those nubs touch your bee-stung lips.  Giving in isn't an option, even if you can't stop him from fucking your mouth, you aren't going to curl your tongue around his member and lick it, just like that, sliding it over his bumpy surface until corrupted pre is dripping onto your tongue. Yes, you won't let him out of your mouth until you can get his seed inside you, what are the other imps waiting for?  Your other hole is soooo hungry!\n\n", false);
			
			outputText("The mental incongruities in your thoughts are subsumed in a wave of hot, sticky fuck that's slowly rising over your thought processes with each lick and suck of Zetaz's thick, sexy dick.  He plunges down, stuffing your greedy gullet with the full length of his elephantine member and letting you know just how much he's enjoying your oral cum-hole.  You stick your tongue out to slurp at his desire-filled balls, swooning at the feeling of so much cock-flesh and slippery tongue sliding between your sensitive-as-a-pussy lips.  They twitch and pull tightly against his groin as he grabs your " + player.hairDescript() + " and hilts himself, allowing your lips to seal around his base as his urethra rhythmically bulges with orgasm.  A feeling of warm fullness grows in your gut with each pulse of cum, and you work your throat muscles to squeeze his tip of every last drop while you try to get off on the feelings coming from your mouth.\n\n", false);
			
			outputText("Once finished, the imp yanks himself up and pulls his orgasm-distended member from your lips with such force that it feels like each of his nubs is flicking your lips.  The orgy of oral pleasure sets off fireworks in your head strong enough to cross your eyes and make you babble incoherent 'thank-you's and moans.  You pant happily and lick the residue of Zetaz's love from your lips, shivering from the sensitivity and trying to come to grips with what happened.  It doesn't do much good – you're already getting horny again, and you still haven't been knocked up.  Even though you know something about the situation is deeply wrong, you're horny as hell and desperately desire to be a mother.  Maybe it's just that there's all these strong, handsome males here but none of them are fucking your horny, wet twat.  There's something wrong with that!", false);
			//(max libido, lust, and sensitivity)
			dynStats("lib", 100, "sen", 100, "lus=", 1000, "cor", 50);
			//[NEXT]
			doNext(femaleZetazOverPtII);
		}

		public function femaleZetazOverPtII():void {
			clearOutput();
			hideUpDown();
			outputText("While you're gathering your thoughts, Zetaz staggers back down the table and accepts a flask from one of his lackeys.  He guzzles down the bubbling pink fluid in seconds, and the effect is immediate and greatly pleasing to your fuck-happy worldview.  The imp's cock, which had been slowly retracting, thickens at the base and rapidly fills until it's hard and twitching with sexual need.  He glances down at your exposed " + player.vaginaDescript(0) + " with a hungry look and drops to his knees, lining the nodule-ringed crown of his wondrous dick up with your lust-juiced slit.\n\n", false);
			
			outputText("You look down at the male and moan, \"<i>Please, hurry up... I need your cum... your babies.  Put your cock inside me!</i>\"\n\n", false);
			
			outputText("Zetaz looks surprised at your words, and you start to wonder why, but the heat and pleasure of his long, thick member spearing your love-canal interrupts your thought process.  He reaches up, and begins to ", false);
			if (player.biggestTitSize() < 1) outputText("tweak your " + player.nippleDescript(0) + "s roughly, pulling and yanking on them as", false);
			else outputText("maul at your " + player.allBreastsDescript() + ", slapping and squeezing them as", false);
			outputText(" he begins to repeatedly thrust against your " + player.vaginaDescript(0) + ", fucking you in earnest.  The wet slap of his balls on your juice-slimed body fills the chamber and sends ripples of pleasure down your " + player.legs() + ".  With your eyelids half-closed, your tongue masturbating your lips, and your pussy practically squirting lubricants at the end of each thrust, you must look like every male's wet dream.\n\n", false);
			
			outputText("Looking around, you see a large number of the imps are masturbating, and one of the larger ones has the audacity to speak while his boss is plowing your quim with savage strokes. \"<i>Since you already got to use her mouth, I'm going to put that fuck-hole to use.</i>\"\n\n", false);
			
			outputText("Zetaz waves his hand, though you aren't sure if it's meant to be a dismissal or permission.  He's far too busy sawing away, sending bliss up your spine that makes you giggle and moan with desire.  You're already getting close to cumming!  Before you can vocalize just how great it feels, the imp that spoke is straddling your neck and dangling his own member towards the bloated, bimbo-like cum-receptacle that was once your mouth.\n\n", false);
			
			outputText("The pointed tip of the new imps dick slides through your sensitive orifice with ease, at least until you feel the curvature of his knot pushing apart your jaw.  The utter wrongness of being double-teamed by tiny, huge-cocked demons rears its ugly head, and you knit your brows together as you try to puzzle it out.  What could be wrong?  Your lips feel so good and you're about to be pregnant.  Wasn't there a reason not to, though?  Something about saving something?  You unconsciously lick at the new invader as his knot finally gets past your lips, humming and sucking while your drug-dulled mind tries to refocus on something other than getting knocked up.\n\n", false);
			
			outputText("Zetaz grunts and bottoms out, punching his tip into your cervix and blasting a thick rope of seed into your empty, ready womb.  You climax immediately from the act, and moan into the dog-cock that fills your mouth, using it like a ballgag.  There wasn't any natural buildup, just spunk hitting your womb and then a climax strong enough to make you see white.  Your " + player.vaginaDescript(0) + " clenches tightly, hugging and squeezing Zetaz's potent prick as it dumps more and more of his corrupt demon-spoo into your fertile breeding grounds.  The thick goop tingles in a way that makes you sure you'll be giving him a litter of horny little sons before long.  Maybe they'll fuck you like they do Vala?\n\n", false);
			
			outputText("The knot in your mouth pops out, and your belly gurgles, feeling very full.  The second imp must have come while his master was fertilizing your pussy.  You sigh and sag against your restraints as Zetaz steps away and lines begin to form.  In a few seconds, you've got a rubbery, spined cat-cock twitching inside your cunt, and are wrapping your sensitive lips around a horse-cock.  This must be what nirvana feels like.", false);
			player.orgasm();
			dynStats("cor", 50);
			
			//[Epilogue]
			doNext(zetazBadEndEpilogue);
		}

		//[HERMS]
		public function hermZetazOver():void {
			//H-fed incubi and succubi potions repeatedly until demonic and even more over-endowed, knocked up while dick is milked by factory like milker + MC?
			outputText("With your resistance ", false);
			if (player.HP < 1) outputText("beaten out of you", false);
			else outputText("moistening the delta of your legs", false);
			outputText(", you don't even struggle as Zetaz calls in several friends.   You just lie there, meek and defeated as they carry you through the tunnels towards their dining room, but from the looks in the small demons' eyes, they aren't planning to feed you, not food anyway.  The mob you defeated earlier seems to have returned, and gleeful hoots and catcalls ", false);
			if (player.cor < 33) outputText("shame", false);
			else if (player.cor < 66) outputText("confuse", false);
			else outputText("arouse", false);
			outputText(" you as you're thrown atop one of the tables.   You grunt as leather straps are produced and laid over your form to restrain you.  In the span of a minute you're completely immobilized from the neck down, and your " + player.legs() + " are kept spread to allow easy access to your " + player.vaginaDescript(0) + ".\n\n", false);
			
			outputText("Your willpower starts to come back, and you struggle in vain against the tight leather straps, accomplishing nothing.  Zetaz leers down at your double-sexed form and roughly manhandles both your male and female organs as he taunts, \"<i>I don't remember ", false);
			if (player.cockTotal() == 1) outputText("both", false);
			else outputText("all", false);
			outputText(" of these being here when we met.  Did you sample some incubi draft?  Or did you guzzle some succubi milk?  Perhaps both?  In any event, I think you could do with a little more of each.</i>\"\n\n", false);
			
			outputText("Oh no.  Your eyes widen in fear at his bold declaration, but Zetaz only throws back his head and laughs, \"<i>Oh yes!</i>\"  He turns to the mob and orders something in a tongue you don't understand, then returns to fondling your " + player.cockDescript(0) + ".  \"<i>How perverse.  Why would you have something like this when you have such a beautiful pussy hiding below it?</i>\" asks the imp lord.  Despite his questioning words, he doesn't stop stroking you until you're full, hard and twitching.  Your poor " + player.vaginaDescript(0) + " is aching from being ignored with all this building sexual tension.\n\n", false);
			
			outputText("The sounds of numerous footfalls and clinking glass signal that the mob of imps has returned, bringing what sounds like hundreds of vials worth of their foul concoctions.  Zetaz releases your tumescent member and reaches over for something, then returns to your view bearing a ring gag.  Even turned on, defeated, and immobilized on a table, you try your best to fight him, but all that gets you is slapped.  The imp's palm smacks you hard enough to stun you and leave your ears ringing, and when you blink the stars from your eyes, your mouth is forced open with your tongue hanging out lewdly.\n\n", false);
			
			outputText("Another of Zetaz's brothers, or perhaps sons, hands him a tube with a funnel, and he easily threads the funnel's tube through the ring gag.  Foul remnants of whatever it was used for last leave a sour taste on your tongue, but worse yet is the knowledge that you're going to be force-fed tainted, body-altering, mind-melting drugs.  A drop of pre-cum hits your belly and your thighs grow ", false);
			if (player.vaginas[0].vaginalWetness < VAGINA_WETNESS_DROOLING) outputText("sticky", false);
			else outputText("soaked", false);
			outputText(" from the thoughts.  ", false);
			if (player.cor < 33) outputText("Are you really being turned on by such lewd, debased thoughts?", false);
			else if (player.cor < 66) outputText("Are you this much of a pervert?  Yes, it'll feel good, but you're a little ashamed of your body's immediate and lewd reaction.", false);
			else outputText("Are you really this much of a submissive?  Yeah, sucking down drinks like this is hot as hell, but you'd like to be doing it on your own terms.  At least you'll probably start cumming after a few bottles worth of the stuff.", false);
			outputText("\n\n", false);
			
			outputText("\"<i>Hey boss!  She's already starting to drip!  To think she tried to fight us.  She's showing us her true nature – that of a pervert-slut,</i>\" raves one of the horde.  You can't pick out the source of his voice in the crowd, but the words sting enough to make your whole body blush with ", false);
			if (player.cor < 33) outputText("shame", false);
			else if (player.cor < 66) outputText("confusion", false);
			else outputText("arousal", false);
			outputText(".  The imp lord nods in agreement and upends the first bottle over the funnel, channeling fragrant white fluid into your mouth.  It tastes fantastic!  Your throat instinctively gulps down the creamy delight before you can make a conscious decision.  The effect is immediate and strong.  Warmth builds on your chest as weight is added to your " + player.allBreastsDescript() + " while a gush of fluid squirts from your " + player.vaginaDescript(0) + ".\n\n", false);
			
			outputText("Zetaz is just getting started.  Before you have time to react to your predicament, the next bottle is empty and thicker cream is flooding your mouth.  You don't swallow for a moment, so the imp pours another bottle in, backing up more of the fluid.  Faced with a choice between corruption and drowning, you try to gulp down enough liquid to breathe.  " + player.SMultiCockDesc() + " puffs and swells, spurting thick ropes of cum as it adds a half-dozen inches to its length.  Your eyes cross from the sudden change, but you get a fresh breath before the imps begin to pour several bottles in at once.\n\n", false);
			
			outputText("You swallow in loud, greedy gulps as your body is slowly warped by the fluids you're consuming.  Though your " + player.allBreastsDescript() + " and " + player.multiCockDescriptLight() + " sometimes shrink, they grow far more often, and after a few minutes of force-feeding, you're pleading for more each time they stop to let you breath.  You're a mess of sexual fluids, your tits are squirting milk, and your pussy squirts from every touch.  Demon horns are swelling from your brow, curling back over your ears", false);
			if (player.horns > 0) outputText(" and adding to your existing pair", false);
			else outputText(" and giving you an exotic, tainted appearance", false);
			outputText(".  ", false);
			if (player.lowerBody != LOWER_BODY_TYPE_DEMONIC_HIGH_HEELS) outputText("Your " + player.feet() + " have been changing throughout the ordeal, but you didn't notice your " + player.legs() + " becoming such lissom, lengthy legs, or your heels growing long, high-heel-like spikes.  ", false);
			if (player.tailType != TAIL_TYPE_DEMONIC) outputText("A tail snakes around your leg and begins to caress your " + player.vaginaDescript(0) + ", then plunges in to fuck the squirting orifice while you drink.  ", false);
			else outputText("Your tail snakes around your leg and begins to caress your " + player.vaginaDescript(0) + ", then plunges in to fuck the squirting orifice while you drink.  ", false);
			outputText("The imps start hooting and cat-calling, laughing and prodding your body with their twisted demonic members as your mind starts to come apart in the seething oven of unnatural lust.\n\n", false);
			//NEXT
			dynStats("lib", 100, "sen", 100, "lus=", 1000, "cor", 50);
			doNext(hermZetazOverPtII);
		}

		public function hermZetazOverPtII():void {
			hideUpDown();
			clearOutput();
			outputText("You awaken midway through a loud moan and nearly jump out of your " + player.skinDesc + " in surprise, but the fire of your unnaturally stoked libido immediately reasserts yourself.  You twitch your hips to and fro, thrusting against a ", false);
			if (player.cockTotal() > 1) outputText("number of ", false);
			outputText("mechanical milking device", false);
			if (player.cockTotal() > 1) outputText("s", false);
			outputText(".  " + player.SMultiCockDesc() + " is sucked rhythmically, producing a loud, wet, slurping noise that echoes around the small room.  You're suspended from a set of shackles on the wall, next to Vala.  The sexy faerie is chained up in a similar manner, but she's locked in coitus with a well-endowed imp, and making no secret of her enjoyment.  The sexual sight stirs your well-stimulated loins and you groan, filling the milker with what feels like gallons of male cream over the next minute and a half.\n\n", false);
			
			outputText("Slumping forwards, you hang there, but the corruption and lust in your blood refuses to be sated.  " + player.SMultiCockDesc() + " is already hard again, and after sucking your cum down some tubes, the milker begins its oh-so-pleasurable work again.  Still, you estimate it will be a few minutes before it gets you off again, so you look around the room.  A platform is set up in front of you, about knee-height and poorly built.  Judging by its height, it's probably there so that the imps can use it to fuck you without having to fly.  There's also a pair of platforms built into the walls next to each of your shoulders, though their function is less clear.\n\n", false);
			
			outputText("The door to the room bangs open, and Zetaz steps in, followed by two scrawnier-than-usual imps.  He smiles when he sees you awake and flushed, and steps up onto the platform, rubbing his palms together in excitement.\n\n", false);
			
			outputText("\"<i>You took quite well to our little experiment,</i>\" he announces, \"<i>In fact, your body is a demonic fucking machine.  I won't be transforming you into an actual demon though.  But we're going to have to have a little training to get you ready to meet Lethice.  After all the trouble you've caused her, she might want to turn you herself, or maybe hook you up in a factory?  I can't say for sure.</i>\"\n\n", false);
			
			outputText("With a flourish, the imp lord discards his loincloth, tossing it over his shoulder to reveal his erect demon dick.  He taunts, \"<i>Like what you see?</i>\" and orders his lackeys, \"<i>Go on, you know what to do.</i>\"  The pair of scrawny imps flit up to their perches while Zetaz advances and strokes himself, preparing for penetration.  Dozens of unanswered questions swarm through your mind, actually distracting you from your pending orgasm enough to ask, \"<i>Wha-what are you going to do to me?</i>\"\n\n", false);
			
			outputText("\"<i>Shhhh, shhh,</i>\" responds Zetaz, \"<i>just relax my pet.</i>\"  He ", false);
			if (player.balls > 0) outputText("gently shifts your  " + player.ballsDescript() + " out of the way and ", false);
			outputText("lines up with your drooling fuck-hole, and with a long smooth stroke, he's inside you.  You cum immediately and hard, barely noticing the chanting that has started up on the adjacent platforms.  Each squirt of cum is accompanied by a thrust from Zetaz, sliding over your lube-leaking walls with ease.  The orgasm lasts nearly twice as long as your last one.  It never seems to end, but when it slowly trails off, you find yourself wondering how soon you can cum again.\n\n", false);
			
			outputText("You envision yourself on all fours, being taken in both openings by a pair of imps while you suck off a shadowy figure that your mind recognizes as your lord and master.  " + player.SMultiCockDesc() + " spurts and squirts with each penetration as your twin violators get off and stuff you full of their yummy imp cum, glazing your insides with corrupted white goo.  Maybe you'll get pregnant this time?  It's been a few weeks since your last litter.  You suck harder on your master's penis and caress his balls until he shows his affection by giving you a salty treat.  He pulls out and blasts a few ropes over your face and hair, so you do your best to look slutty to encourage him.  When he finishes, you lick your lips and beam at your master, Zetaz.\n\n", false);
			
			outputText("Wait- what!?  You shake your head and clear away the fantasy, though your sexual organs' constant delightful throbbings aren't doing much to help.  Zetaz is still fucking your pussy, taking it with long slow strokes that would've made your demonic legs give out ages ago if you weren't hanging on a wall.  The chanting is so loud, so insidious.  You can feel it snaking through your brain, twisting your thoughts and ideas.  You close your eyes, desperate to fight it, but it only enhances the sensation of dick-milking and being fucked by your- no, by that demon!\n\n", false);
			
			outputText("Glancing down at him, you remark that the little bastard is quite handsome for an imp.  With his perfect jawline and marvelous cock, you find yourself hard-pressed to justify resisting him so long ago.    How did you resist his charms?  His cock feels soooo fucking good inside you.  With an explosive burst, " + player.sMultiCockDesc() + " erupts again, squirting thick arousal and submission into the milker while your " + player.vaginaDescript(0) + " wrings Zetaz's nodule-ringed cock incessantly.  His turgid member bulges obscenely, and he starts to cum inside you, squirting master's thick seed into your breeding hole.  Breeding hole?  Why would you call your slutty fuck-hole a breeding hole?  Something seems off about that last thought, but you can't place it.\n\n", false);
			
			outputText("Your master finishes squirting inside you and withdraws, pawing at your milk-leaking teats for a moment as you continue to shudder and cum like a good bitch.  Wow, you really are a good bitch aren't you?  Pride wells in your breast as the imp's chanting reaches a crescendo and a relaxed smile forms on your " + player.face() + ".  Yes, you're a good, breeding bitch.   Master is smiling up at you and you know you've made him feel very happy.  Hopefully he'll come back soon and fuck you some more.  Your pussy feels so empty without him.", false);
			player.orgasm();
			dynStats("cor", 50);
			doNext(zetazBadEndEpilogue);
		}
			
		//M-Males – drugged & pegged, slowly have their memories erased/brainwashed.
		//[Males]
		public function malesZetazOver():void {
			outputText("You've been so thoroughly ", false);
			if (player.HP < 1) outputText("beaten", false);
			else outputText("teased", false);
			outputText(" that you don't even resist as Zetaz calls in several friends.   You just lie there, meek and defeated as they carry you through the tunnels towards their dining room, but from the looks in the small demons' eyes, they aren't planning to feed you... not with food anyway.  The mob you defeated earlier seems to have returned, and gleeful hoots and catcalls ", false);
			if (player.cor < 33) outputText("shame", false);
			else if (player.cor < 66) outputText("confuse", false);
			else outputText("arouse", false);
			outputText(" you as you're thrown atop one of the tables and rolled onto your side.   You grunt as leather straps are produced and laid over your form to restrain you.  In the span of a minute you're completely immobilized from the neck down, and your " + player.legs() + " are kept spread to allow easy access to " + player.sMultiCockDesc() + " and " + player.assholeDescript() + ".\n\n", false);
			
			outputText("Zetaz leaps atop the table in a single bound, the barely concealed bulge in his loincloth dangling freely underneath.  You begin to struggle, fearful of the cruel imp's intentions and ", false);
			if (player.ass.analLooseness < 4) outputText("worried he'll try to force the mammoth between his thighs into your backdoor", false);
			else outputText("worried he'll take advantage of your well-stretched backdoor", false);
			outputText(", but your feverish efforts are in vain – the restraints are too strong!  The imps start to laugh at your predicament, and Zetaz pushes the humiliation a step further by stepping squarely on your groin, painfully squeezing your " + player.cockDescript(0) + " with his heel.  He throws his arms up in the air and shouts, \"<i>I am your champion!  I have brought the scourge of our kind to his knees, and ground him under my heel!</i>\"\n\n", false);
			
			outputText("You whine plaintively and squirm under the imp's heel, utterly humiliated and helpless.  Zetaz smirks down at your taunts, \"<i>What's the matter?  Is something bothering you?</i>\"  He raises his foot, letting you gasp, \"<i>Thank you,</i>\" before he delivers a kick to your gut, knocking the wind out of you.  Restrained as you are, your body convulses underneath the leather, trying to curl up while your diaphragm spasms repeatedly.  A strap is fastened around your head, and a ring gag is slipped into your mouth, holding it open and ready for whatever sick plans the imps have devised.\n\n", false);
			
			outputText("The imp lord gestures at his underlings with an irritated scowl while you catch your breath, and the horde scrambles to satisfy him before they can draw his ire.  A funnel with a clear tube suspended from the bottle is passed from the mass of bodies up to Zetaz, along with a few bottles filled with roiling pink and red fluids.   The funnel's exit-tube is threaded into your ring gag and there's nothing you can do but grunt in wide-eyed panic while it's secured in place.  The first bottle of what you assume to be lust-draft is upended into the funnel, and there's nothing you can do but drink or drown.\n\n", false);
			
			outputText("It has a bubblegum-like taste that makes your tongue tingle as it passes into your belly, but the more pressing sensation of " + player.sMultiCockDesc() + " getting rock-hard lets you know exactly what you just drank.  Even though you just finished chugging down that foul drink, the imps uncork another pair of potions and dump them into the funnel.  The sweet fluids flood your mouth, and once again you swallow and chug rather than drown.   After you finish the last swallow, you pant, completely out of breath and getting hotter by the moment.  Your " + player.skinDesc + " tingles and sweats, growing more and more sensitive with every passing second while " + player.sMultiCockDesc() + " begins to drip and drool.\n", false);
			
			outputText("Zetaz hands the funnel to an underling with a knowing laugh and repositions himself over your " + player.legs() + ".  Warm pressure pushes at your " + player.assholeDescript() + ", forcing your clenching flesh to yield around the intruder.  Normally such an instant penetration would be irritating, or perhaps painful, but the sudden pressure on your prostate only serves to release a copious squirt of pre-cum.  An unwelcome moan slips past your lips and sends a titter of laughter through the mob.  As if losing wasn't bad enough – they all know you're getting off on having your " + player.assDescript() + " penetrated.  The worst part is that the humiliation is just making the situation hotter and " + player.sMultiCockDesc() + " harder.\n\n", false);
			
			outputText("You nearly choke as an unexpected wave of potions washes through the funnel into your mouth, but you start swallowing and gulp down what feels like a half-dozen lust potions before you can breathe again.  " + player.SMultiCockDesc() + " starts squirting and spurting, dumping heavy loads of cum onto the table and your belly from the effects of the potions alone.  Zetaz gathers a massive dollop in his hand and smears it over himself, using it as lubricant to penetrate your poor, beleaguered asshole with savage, rough strokes that smash against your prostate at the apex of each thrust.  You moan loudly and lewdly through the tube in your mouth, wriggling against your restraints and spurting helplessly as you're penetrated over and over.\n\n", false); 
			
			outputText("As soon as your orgasm concludes, another wave of aphrodisiacs enters your mouth, and you have to drink all over again.  Something warm flashes in your backside, making you feel stuffed and hot, but then Zetaz pulls his cock free and another, slightly different prick is buried in your asshole.  The imps take turns battering your backdoor, force-feeding you potions, and sometimes even jerking you off to see how much you squirt, until your mind shuts down from the constant assault of drugs, sex, and pleasure.\n\n", false);
			
			dynStats("lib", 100, "sen", 100, "lus=", 1000, "cor", 50);
			doNext(malesZetazOverPtII);
		}

		public function malesZetazOverPtII():void {
			clearOutput();
			outputText("You wake to a desert-dry, sandpapery feeling in the back of your throat as yet another moan escapes your mouth.   The ring gag is still there, and easily thwarts your tongues attempts to lick at your parched lips, but the jolts of pleasure exploding up your spine make it hard to get upset about it.  Hips rocking, you keep squirting and squirting from your orgasm, feeling each hot blast burst from your manhood until the wave of lust passes and you open your eyes.  You're in a dim cave, the one they used to hold Vala, and chained up to the wall in a similar manner.\n\n", false);
			
			outputText("While you observe the room, you realize that the waves of pleasure sliding up your spinal cord haven't stopped, and that your entire body is being shaken rhythmically.  You look down with a look of incredible, still-drugged confusion and behold the last thing you expected to see.  Somehow " + player.sMultiCockDesc() + " has been shrunk to less than half of its previous size", false);
			if (player.balls > 0) outputText(", and your balls have completely vanished", false);
			outputText("!  Just below your pint-sized shaft, a massive imp-cock is plowing in and out of your new, wet snatch with juicy-sounding slaps.  Y-you're a hermaphrodite!?  And what's happening to your dick?\n\n", false);
			
			outputText("A nearby imp with a limp dick and a bored-but-tired look on his face steps up after your orgasm and slathers your dick in some strange, pungent cream, chuckling up at you while he does so, \"Heh heh, your ", false);
			if (player.cockTotal() == 1) outputText("cock's", false);
			else outputText("cocks're", false);
			outputText(" gonna be so tiny ", false);
			if (player.cockTotal() == 1) outputText("it", false);
			else outputText("they", false);
			outputText("'ll make a baby's look huge.  Boss said we need to dose you with Reducto after each orgasm, so try not to cum too much while we gangbang you, okay?  Oh yeah, I almost forgot, I have to inject something too...</i>\"\n\n", false);
			
			outputText("The little demon picks an small, glass injector stamped in black ink with the words 'GroPlus'.  Your eyes go wide at sight of the lettering.  As your maleness dwindles, the imp carelessly flicks it to the side and lines the needle's tip up with your tiny bud – they're going to shrink your dick to nothing and pump your clit full of growth chemicals!  He plunges it in, lighting your world up with pain, but the bindings around your body prevent you from escaping or injuring yourself in struggle.  Heat erupts inside your clitty, and it visibly swells up until it nearly reaches the size of your shrinking wang.  Your rapist, or 'sexual partner' with how horny you are, thrusts hard inside you and swells, stroking your walls with the nubby protrusions of a demon's cock.  It feels so good that another orgasm builds on the spot.\n\n", false);
			
			outputText("With hot, tainted jism filling your womb, your body starts to spasm and squirt, actually making your increasingly tiny dick shake around from the force of ejaculation.  It splatters off the imp's horns and forehead, but he doesn't seem to mind much as he slumps down, dragging his still-rigid member from your cock-hungry fem-sex.  You moan wantonly, still spurting as the imp 'medic' applies another layer of Reducto to " + player.sMultiCockDesc() + ", rapidly shortening ", false);
			if (player.cockTotal() == 1) outputText("it until it's", false);
			else outputText("them until they're", false);
			outputText(" barely three inches long, even while hard.  He pulls out another plunger and rams the needle into your still-aching clit, making it swell until it's almost five inches long and trembling like your manhood used to.\n\n", false);
			
			outputText("\"<i>Now you're starting to look like a proper bitch.  ", false);
			if (player.biggestTitSize() < 2) outputText("It doesn't look right without a decent rack, but boss said no tits for the new breeding bitch.  Sure makes it hard to get excited about fucking that new twat of yours though...", false);
			else outputText("With a rack like that and a nice, wet cunt, you'll have the other guys lining up for their turn in no time...", false);
			outputText("</i>\" rambles one of the imps.  You groan and shake your hips lewdly, still turned on after all the fucking, feeling empty without the unholy heat of an imp inside you.  A hunger buzzes away in your womb, demanding you get pregnant, and you're thrilled to see Zetaz stride in with a raging, fully erect stiffy.  It throbs hungrily as he smiles up at you and climbs atop the conveniently positioned platform.\n\n", false);
			
			outputText("\"<i>It looks like you're ready now, huh?  Nice, wet cunt, barely discernible dick, and a huge, lewd clit.  I considered getting rid of your dick, but I figured it would be more humiliating to keep that to remind you how far you've fallen.  And with all that cum dripping from that hole above your " + player.legs() + ", you'll probably get pregnant, but I should make sure shouldn't I?</i>\" questions your old foe.\n\n", false);
			
			outputText("Before he gets started, Zetaz picks up another needle of GroPlus and jams it into your clit, making the love-button swell up to the size of a large, veiny prick.  He strokes it hard and slides himself into you, spearing you while you're distracted by the sensations of your over-sized buzzer.   The sudden penetration makes your eyes cross and your tongue loll out from its ring-gag prison.  You moan and pant, shaking against him, still dripping the last of your male orgasms from your tiny, under-sized dick onto your long, thick clit.\n\n", false);
			
			outputText("Zetaz laughs and pumps at the huge button; even though it's quite lacking in femininity, it still makes you squeal like a little girl.  Your " + player.legs() + " shake wildly, trembling against the wall while your juicy snatch gets fucked good and hard and the mixed jism boils out around the imp lord's massive, swollen member.   The fucking is hard, fast, and so brutal that you get off multiple times in the span of a few minutes, though the imps don't even try to dose you for each one.  Zetaz slaps your " + player.assDescript() + " a few times before he pushes himself to the hilt, stretching your well-fucked cunt to its limits.  He twitches and grunts, and a blast of gooey heat suffuses your core with corrupt pleasure.  Somehow you know, just know, that you'll be pregnant from this, but you have a hard time caring.  It feels too good...\n\n", false);
			
			dynStats("lib", 100, "sen", 100, "lus=", 1000, "cor", 50);
			doNext(zetazBadEndEpilogue);
		}
		//BAD ENDS
		public function badEndValaNumber1():void {
			spriteSelect(85);
			clearOutput();
			outputText("When you regain your senses, you're no longer in the cavernous dungeon you passed out in. You blink, trying to adjust to the bright light around you, but it doesn't help. Every sense is aflame and it's impossible for you to move without exciting some nerve ending, sending a thrill of pleasure radiating along your sensitive regions. You try to think, to reason out where you are, but holding a thought in your head for longer than a minute is extremely difficult, as if your mind was muffled by thick wool. You try to remember what happened, but that too is just out of your reach. All this mental exercise is giving you a headache, so you give up, and just drink in the sensations around your body. A shimmering, spritely face comes into view and a thought blazes a clear, white-hot path through your groggy brain. Recognition clears all your doubts and worries away. Your Mistress. This is your Mistress.\n\n", false);
			outputText("The fairy girl smiles broadly, stroking your face affectionately, her almond-shaped pink eyes full of sweet desire. \"<i>How is my Pet this morning?</i>\" she inquires, voice like silver chimes ringing in your head. \"<i>Aw, are you still waking up with headaches, Pet? Ooo, let your Mistress clear that poor head of yours.</i>\" She uncorks a small vial of pink fluid and places it against your lips, but you hardly need the encouragement. You wrap your mouth around the lust draft and drink greedily, sucking down the wine-sweet draught, fiery passion driving the pain from your mind in a second and you reach out to embrace your dear Mistress. She giggles and shoos you back down with a touch. \"<i>No no, Pet. It's meal time first, remember? Every day I steal more potions from those nasty demons, and we see what they do, don't you recall?</i>\"\n\n", false);
			outputText("Dimly, in some corner of your mind, you seem to recall having this conversation before, perhaps several times. And didn't your Mistress use to be the one who had difficulty thinking straight? Back before you were simply Pet, didn't people call you something else? A name floats just out of reach, but you shake it away as your Mistress produces a dizzying array of bottles. She feeds you a thick, green beer that fills your tummy with pleasant warmth and makes your head swim. You can feel your body changing, as your " + player.vaginaDescript(0) + " grows deeper and wider and you giggle, flicking your fingers in and out of your pussy, playing with the hot passage. Your Mistress takes a gulp of her own and coos as the thick white fluid rolls down her throat. She raises her voice in a spritely gasp of pleasant surprise and you can see her tiny joy buzzer of a clit growing longer and thicker before your eyes. It swells to six inches, then eight, before finally settling at 10\". Gradually, it gains definition and its tip broadens into a head, a small slit opening at the top, a bead of pearly cum rolling out and down the bright pink shaft. She strokes the newly grown dick with slim fingers and trembles in excitement, eyeing your body hungrily.", false);
			outputText("You giggle, mindlessly, and let your Mistress sate her unquenchable lust with your yielding body, savoring the submission. She rides you raw, fucking your drug and sex-addled body hard enough to knock the memories of the day out of your head, just as she did yesterday and the day before that. With each passing day, you lose more of yourself to your Mistress and, in time, all that is left is the warped fairy's broken Pet.", false);  
			//GAME OVER.
			getGame().gameOver();
		}
		public function badEndValaNumber2():void {
			spriteSelect(85);
			//(Imp)
			clearOutput();
			outputText("You come to with a splitting headache and the taste of something foul in your mouth. You struggle, but find that your limbs have been chained up and your " + player.legs() + " bound by a thick, rubber coating, squeezing your lower body painfully. You've been fitted with several rubber pieces of the same sort, in fact- the most notable is the black corset that makes breathing difficult and binds your waist to a hyper-feminine fantasy. You've also been fitted with large, rubber fairy wings attached by straps around your shoulders that pull your chest forward, painfully. An O-ring gag has been latched around your face, connected to a long, clear tube that's been fed a foot or two down your throat. You try to shake it loose, but it's far too deep for you to have a hope of removing it without help.\n\n", false);
			outputText("Your struggles have alerted your captors that you've awakened. A large imp steps in front of your vision, his arms tucked behind his back, contemplatively, as he admires your predicament. Instead of speaking, he simply produces a bronze placard with your name engraved on it and taps a long finger on the metal plate. Then, he gestures at the contraption you've been hooked to. The tube leading into your mouth winds upward, to a large funnel, with a twistable knob on it. Above the funnel, the four-foot fairy is suspended by new chains, practically covered in a swarm of tiny imps. The demons are barely a foot tall, perhaps immature or half-breeds, and cling onto her skin with a mixture of lust for her flesh and fear of the drop, using any convenient hole both to fuck and keep from falling. Two are using her pussy at once, another at her ass, a fourth on her face, a pair fucking either hand, and half a dozen more, rubbing themselves across her armpits, the back of her knees, even just using her purple hair for added friction as they jerk themselves off. All the spunk from their frantic rutting splashes into a wide basin below, flowing into the funnel connected to your tube.\n\n", false);
			outputText("The large imp in front of you gives the knob on the funnel a twist and, to your horror, the sloshing flood of imp seed and fairy jizz comes washing down the winding pipe, sliding right past your undefended lips and down your penetrated gullet. Your stomach recoils at the infernal meal, but it just keeps pouring from the over-fucked fairy girl and her precariously perched offspring. As the cum washes down the hose, the silent imp uncorks a little black vial and pours it into the funnel, mixing it with the seething river running into your belly. You try to close your throat, to vomit, to bite through the gag, anything to keep the concoction from reaching you, but your attempts are in vain, and the sable fluid runs into your body. You shudder, mind racing for ways to escape, but your thoughts are interrupted when the apparent leader of the imps leans down and takes your chin in his hand, smiling a wicked grin of jagged, uneven teeth.", false);
			//[Next]
			doNext(badEndValaNumber2Pt2);
		}
		public function badEndValaNumber2Pt2():void {
			spriteSelect(85);
			clearOutput();
			outputText("\"<i>When we captured Vala, I entertained the thought of breaking her on my dick like a crystalline condom, but I'm rather glad I chose to raise her to be my pet instead.</i>\" The imp's voice is familiar and your mind lurches to the memory of that first violation you suffered when you stepped through the portal to this world. Zetaz. He said never to forget the name Zetaz. You eyes roll in panic, but he holds your chin, his leering face filling your vision. \"<i>As a reward to obedient little Vala, I've decided to remake you in her image. We'll crush all that fatty flesh from your waist, keep your torso bound until you're too weak to walk, and pump you so full of drugs and cum that even seeing your name will be painful,</i>\" he taps the bronze plaque he's prepared for you, a mirror to the fairy's. \"<i>Why, in a few months, we'll be hard pressed to tell the two of you apart.</i>\" A fresh wave of fairy-lubricated imp-seed pumps into your abdomen and the rubber girdle strains, but holds, washing the spunk back up, into your throat, until it feels like you might drown in the frothing cream.\n\n", false);
			outputText("There's no time to contemplate your fate, however, as the imp's black poison seems to take hold and you feel a burning all along your body. ", false);
			//(No vagina: 
			if (!player.hasVagina()) {
				outputText("Between your thighs, a wet slurping tears through the air and a sudden seething heat fills your groin as a fresh pussy opens up, just under your dick.  ", false);
				player.createVagina(true, 1, 0);
			}
			//(No breasts: 
			if (player.biggestTitSize() < 1) outputText("You shudder and your chest feels like it's being flooded by the spooge floating at your tonsils. Before your eyes, the girdle around your chest is pushed down and a pair of swelling breasts fills your vision, filling heavily with milk just aching to be sucked from your distended nipples.  ", false);
			outputText("The space between your shoulder blades feels like it's been torn open and your muscles reknit themselves as gossamer wings burst from your skin, thin as a dragonfly's and nearly as long as you are tall, settling against their rubber counterparts. Every inch of your skin seems to blister as a feeling of molten glass pouring over you causes you to tremble with agonized shudders, your pores sealing and skin gaining a glossy sheen.\n\n", false);
			outputText("\"<i>You're looking more like her by the second,</i>\" Zetaz compliments, stroking your now-flawless face. \"<i>Don't worry about that pesky mind of yours- I don't like using drugs to wipe that imperfection away like some of my kin. No, we'll just use you until you break. Perhaps I'll let Vala have you from time to time, too. Won't that be fun? The two of you will grow to be inseparable, I'm sure.</i>\" Zetaz steps back and signals the imps clinging to the fairy to come down. \"<i>Why don't we get started?</i>\"", false);
			//GAME OVER.
			getGame().gameOver();
		}		
		
		public function loseToThisShitPartII():void {
			hideUpDown();
			clearOutput();
			//[OPTIONAL CUM ESCAPE]
			if (player.cumQ() > 3500) {
				outputText("Your orgasm drags on for so long that you begin to feel pressure from the cum-slime surrounding you.  It doesn't seem to matter to " + player.sMultiCockDesc() + ", which is too busy sending bliss to your brain and squirting cum for the tentacles to care.  It actually kind of hurts.  The oscillating purple ambiance flashes brighter in protest for a second, and then everything releases all at once.  The pressure is gone and you're sliding down on a wave of fungal-slime cum, feeling the tentacles being pulled from you by the sudden shift of position.  Moist cave air tickles at your " + player.skinDesc + " as you come to rest on another spongy petal and begin to cough out the sludge.\n\n", false);
				
				outputText("Over the next minute your head clears and your strength returns.  You push yourself up on something hard, then glance down and realize you washed up next to the skeleton!  The bleached bone leers up at you knowingly, and everything you can see is covered in a thick layer of your spooge.  " + player.SMultiCockDesc() + " is still dripping more spunk.  Clearly your ruined orgasm didn't pump it ALL out.  You look down at the rapier and pick it up out of your mess, examining it.  The blade shines keenly, and the sword is balanced to perfection.  Though you succumbed to the same fate as its owner, your warped body saved you from sharing his fate.  Thankfully potential pods that carpet the floor don't even twitch at you.  Perhaps your orgasm was enough to sate them all?  Or maybe they've learned their lesson.", false);
				//(switch from loss to victory, sword loot)
				monster.lust = 100;
				player.orgasm();
			}
			//[OPTIONAL MILK ESCAPE]
			else if (player.lactationQ() > 3500 || (player.lactationQ() + player.cumQ() > 4500)) {
				outputText("Your milk-spouting " + player.nippleDescript(0) + "s continuously pour your breast-milk into the soupy fluids surrounding you.  Once you let down your milk, there was no stopping it.  Pressure backs up inside the flesh-pod, pressing down on you with near painful intensity, but your " + player.allBreastsDescript() + " refuse to give up or slow down.  Even though each squirt jacks up the force on your body, your unholy milk production will not relent.  The oscillating purple ambience flashes bright in protest, then gives out entirely, along with the pressure.  At once you're pulled away by a wave of milk-laced fungus-slime, yanking the tentacles away from your body with the change in position.\n\n", false);
				
				outputText("Over the next minute your head clears and your strength returns.  You push yourself up on something hard, then glance down and realize you washed up next to the skeleton!  The bleached bone leers up at you knowingly, and everything you can see is covered in a thick layer of slime and milk.  Your " + player.breastDescript(0) + " are still pouring out milk.  Clearly you weren't even close to done with your pleasure-induced lactation.  You look down at the rapier and pick it up out of your mess, examining it.  The blade shines keenly, and the sword is balanced to perfection.  Though you succumbed to the same fate as its owner, your warped body saved you from sharing his fate.  Thankfully potential pods that carpet the floor don't even twitch at you.  Perhaps your milk was enough to sate them all?  Or maybe they've learned their lesson.", false);
				//(switch from loss to victory, sword loot)
				monster.lust = 100;
				player.orgasm();
			}
			//(GENDERLESS)
			else if (player.gender == 0) {
				outputText("You orgasm around the tentacle in your " + player.assholeDescript() + " for what feels like hours, though some dim, half forgotten whisper of your mind tells you it can't possibly have gone on for that long.  It feels so right and so perfect that resistance is almost a foreign concept to you at this point.  How could you have tried to fight off this heaven?  You're completely limp, totally helpless, and happier than you ever remember.  The pulsing lights of your womb-like prison continue their steady beat in time with the tentacle buried in your ass, soothing you while your body is played like a violin heading towards its latest crescendo.\n\n", false);
				
				outputText("In spite of the constant stimulation, it unceremoniously comes to a halt.  The tentacle in your " + player.assholeDescript() + " yanks out with near-spiteful force, and the fluid starts to drain from around you.  With so many strange chemicals pumping in your blood, it's too hard to stand, so you lie down on the fleshy 'floor' as the last of the pod's ooze empties out.  The petals unfold, returning the view of the outside world to your drug and orgasm riddled mind.  Over the next minute your head clears and your strength slowly returns.\n\n", false);
				
				outputText("You walk over to the skeleton and get a good look at it.  The bleached bone leers up at you knowingly, and its jaw is locked in a rictus grin.  Looking down at the rapier, you decide to pick it up out of your mess and examine it.  The blade shines keenly, and the sword is balanced to perfection.  Though you succumbed to the same fate as its owner, your genderless body must have saved you from sharing his fate.  The potential pods that carpet the floor don't even twitch at you, and you breathe a silent prayer of thanks while a dark part of you curses.", false);
				monster.lust = 100;
				monster.XP = 1;
				player.orgasm();
			}
			//Done if escaped
			if (monster.lust == 100) {
				flags[kFLAGS.ZETAZ_FUNGUS_ROOM_DEFEATED]++;
				combat.cleanupAfterCombat();
				return;
			}
			//[BAD-END GO]
			//(MALE)  
			if (player.gender == 1 || (player.gender == 3 && rand(2) == 0)) {
				outputText("The orgasm squirts and drips from " + player.sMultiCockDesc() + " for what seems like forever.  It feels so right, so perfect, that you actually whine in disappointment when it finally does end.  You can't even be bothered to reach down and stroke yourself.  The softening in your loins is nothing compared to your flaccid, listless muscles.  You couldn't make your arms reach down to touch yourself even if you could work up the motivation to try.  Thankfully the slippery tentacles curl back around your ", false);
				if (!player.hasSheath()) outputText("base", false);
				else outputText("sheath", false);
				outputText(" and squeeze, forcing " + player.sMultiCockDesc() + " to inflate to readiness.  Deep inside your " + player.assholeDescript() + ", the tentacle starts to rub against your prostate.  It caresses the male organ on each side and pauses to squeeze the center of it, pushing a few drops of sticky cum from your trembling " + Appearance.cockNoun(CockTypesEnum.HUMAN) + ".\n\n", false);
				
				outputText("The vine-like stalks currently hugging " + player.sMultiCockDesc() + " constrict the base and begin to swirl around it in a circular motion.  Warm fungi-flesh and viscous, drugged ooze work together to send hot spikes of pleasure up your spinal-cord.  Despite your recent orgasm, you aren't being given any chance to recover or refill your ", false);
				if (player.balls > 0) outputText("balls", false);
				else outputText("prostate", false);
				outputText(".  Things like logic and rest don't matter in this warm, soupy environment, at least not to your poor, unthinking mind and erect, sensitive dick", false);
				if (player.cockTotal() > 1) outputText("s", false);
				outputText(".  With such stimulation coming so closely on the heels of your last orgasm, [eachCock] is suffering painful levels of pleasure.  Your whole body shakes from the sensory overload; though with your muscles so completely shut down, it's more of a shiver.\n\n", false);
				
				outputText("Another wave of sperm begins the slow escape from your helpless, pinned form, drawn out by the fungus' constant sexual ministrations.  The fluid inside your pod gurgles noisily as the fluids are exchanged, but the sensory input doesn't register to your overloaded, drugged-out shell of a mind.  You've lost yourself to mindless pleasure, and repeated, endless orgasms.  The rest of your life is spent floating in an artificial womb, orgasming over and over to feed your fungus prison, and enjoying the pleasure that long ago eroded your ability to reason.", false);
				getGame().gameOver();
				//GAME OVER 
			}
			//(FEM)
			else {
				outputText("You orgasm around the tentacles in your " + player.vaginaDescript(0) + " and " + player.assholeDescript() + " for what feels like hours, though some dim, half forgotten whisper of your mind tells you it can't possibly have gone on for that long.  It feels so right and so perfect that resistance is almost a foreign concept to you at this point.  How could you have tried to fight off this heaven?  You're completely limp, totally helpless, and happier than you ever remember.  The pulsing lights of your womb-like prison continue their steady beat in time with the tentacles buried in your snatch, soothing you while your body is played like a violin heading towards its latest crescendo.\n\n", false);
				outputText("The steady rhythm of your penetration sends rockets of bliss-powered pleasure up your spinal cord and straight into your brain, where it explodes in orgasm.  Your body barely twitches, too relaxed to work up any muscle response, involuntary or otherwise.  A moment to rest never presents itself.  The cruel fungus never relents.  It never slows, unless it's only the briefest pause to intensify the next thrust.  Were you in the open air, away from the strange fluid you're now breathing, you'd be twisting and screaming with pleasure.  Instead you float and cum in silence.\n\n", false);
				outputText("Fluids gurgle and shift inside the pod as they are exchanged.  If you were capable of noticing the sound or change, you might wonder if it's harvesting your sexual fluids, but even those thoughts are beyond you now. You've lost yourself to mindless pleasure, and repeated, endless orgasms.  The rest of your life is spent floating in an artificial womb, orgasming over and over to feed your fungus prison, and enjoying the pleasure that long ago eroded your ability to reason.", false);
				getGame().gameOver();
				//GAME OVER 
			}
		}
		
		public function zetazBadEndEpilogue():void {
			clearOutput();
			if (player.gender == 2) {
				outputText("The once-champion, " + player.short + " was raped repeatedly by every imp that survived her initial assault.  Her mind never recovered from the initial orgy, and she found herself happy to be named 'Fuck-cow'.  She quickly became a favorite of Zetaz's ever growing brood, and surprised them all with her fertility and rapidly decreasing incubation times.  Within a few months, she was popping out litters of tiny masters even faster than Vala.  Within a year, her body was so well trained and her womb so stretched that she could keep multiple litters growing within at all times.\n\n", false);
			
				outputText("It was rare for Fuck-cow's cunt or mouth to be empty, and she delighted in servicing any male she was presented with.  Her masters even captured bee-girls, so that fuck-cow's ass could be kept as pregnant as her belly.  Fuck-cow came to love her masters dearly, and with her constantly growing ability to birth imps, she was able to incubate enough troops for Zetaz to challenge Lethice's armies.  The imps never managed to overthrow the old demon lord, but the land was eventually divided in half, split between two growing demonic empires.", false);
			}
			else if (player.gender == 3) {
				//[Epilogue]
				outputText("The champion was fucked and brainwashed repeatedly for a few more days until Zetaz was sure she understood her place in the world.  Once rendered completely obedient, they released her from her bindings.  It was time she was turned over to Lethice.  ", false);
				if (player.wingType != WING_TYPE_BAT_LIKE_TINY || player.wingType != WING_TYPE_BAT_LIKE_LARGE) outputText("Zetaz gave her one of the weaker imps to penetrate and taught her to fly with her new, demonic wings.  ", false);
				else outputText("Zetaz gave her one of the weaker imps to penetrate during the journey.  ", false);
				outputText("With preparations complete, Zetaz, the champion, and a few dozen imps flew to the mountain peak.\n\n", false);
				
				outputText("The champion was presented to Lethice, and the demonic mistress was so pleased with Zetaz's gift that she gave him a pair of nubile slave-girls and promoted him over a small army of his own kind.  Once the imps departed, Lethice put the champion through her paces, using her as a fucktoy whenever the mood took her.  The rest of the time the champion was kept bound and unable to orgasm, tortured with unholy levels of arousal, but she didn't mind.  When Lethice allowed her to cum, the champion's orgasms were long and intense enough for her to love her mistress in spite of having to be so pent up.", false);
			}
			else {
				outputText("The imps never released the champion from that chamber after that.  'He' gave birth to a healthy litter of imps a few weeks later, and the hormones from the pregnancy ", false);
				if (player.biggestTitSize() < 1) outputText("created a decent set of chest-bumps.", false);
				else outputText("swelled her already impressive rack with milk.", false);
				outputText("  After that, the imps really took a liking to her, and she was let down from her restraints.  She never got much chance to get up though; she was well and truly fucked at every opportunity.  She was already hooked.  With her incredible libido and the constant fucking, staying was the easy choice.\n\n", false);
				
				outputText("After a few months the champion started to become acclimated to her new life, and began birthing imps in larger broods with shorter gestations.  She had become the ideal broodmother, and her worldview shrank down to two powerful priorities: acquiring cum, and birthing.", false);
			}
			player.orgasm();
			player.HP += 150;
			getGame().gameOver();
		}
		//ROOMS
		public function roomEntrance():void {
			kGAMECLASS.dungeonLoc = 10;
			outputText("<b><u>The Cave Entrance</u></b>\n", true);
			outputText("The entrance to this cave is far bigger than the cave itself.  It looks to be a totally natural formation.  Outside, to the south, is a veritable jungle of plant-life.  There are massive trees, vines, and ferns everywhere.  The cave grows narrower the further north you go, until it's little more than a claustrophobic tunnel burrowing deep into the earth.", false);
			dungeons.setDungeonButtons(roomTunnel, null, null, null);
			addButton(11, "Leave", exitDungeon);
			//Zetaz gone?  Alchemist shits!
			if (flags[kFLAGS.DEFEATED_ZETAZ] > 0) {
				if (flags[kFLAGS.ZETAZ_LAIR_DEMON_VENDOR_PRESENT] == 0) {
					outputText("\n\nThere's a demon lazing around outside the cave entrance.  Judging by his size and apparent gender, he must be an incubus.  You try to stay hidden for now, but all he's doing is throwing darts at a dartboard he's set up across the way from himself.  What kind of demon sits around playing darts?", false);
					addButton(0, "Investigate", investigate);
				}
				else if (flags[kFLAGS.ZETAZ_LAIR_DEMON_VENDOR_PRESENT] > 0) {
					outputText("\n\nThe incubus known as Sean has set up a small stall around the cave entrance, and is busy tending to his shelves and wares.  He's dressed in an incredibly modest, three-piece suit, and nods to you as you approach, \"<i>Let me know if you want to buy anything.  I haven't done much with the cave, so feel free to poke around if you missed anything on your first pass.  I barely use the first room.</i>\"", false);
					addButton(0, "Shop", incubusShop);
				}
			}
		}
		
		public function roomTunnel():void {
			kGAMECLASS.dungeonLoc = 11;
			outputText("<b><u>Cave Tunnel</u></b>\n", true);
			outputText("This cave tunnel slants downwards to the north, and upwards to the south.  You can see sunlight and feel a fresh breeze from the latter direction, though the walls and air around you are damp with moisture.  You realize that the floor of this cave is fairly smooth and even, as if some attempt had been made to level it out.  You can see a bricked up wall along the north end of the tunnel.  It has a crudely fashioned wooden door in the center of it.", false);
			dungeons.setDungeonButtons(roomGatheringHall, roomEntrance, null, null);
		}
		
		public function roomGatheringHall():void {
			kGAMECLASS.dungeonLoc = 12;
			outputText("<b><u>Gathering Hall</u></b>\n", true);
			outputText("This room is clearly some kind of dining or gathering hall.  The chamber's shape has been hewn from the surrounding stone, and judging by the visible tool-marks, it wasn't done with a great deal of care.  Two long wooden tables fill out the room.  They're surprisingly well made, though it appears that part of their legs were hacked off with axes to lower their overall height.  You can't help but wonder where they were stolen from.  The tables haven't been cleaned in ages, as evidenced by their many stains and a number of half-rotten bones that still rest on their battered surfaces.  Two rows of crudely crafted chairs flank their better-made brethren, made to accommodate very short beings.", false);
			//[Imp Mob Fight]
			if (flags[kFLAGS.ZETAZ_IMP_HORDE_DEFEATED] == 0) {
				outputText("\n\nThe place is swarming with two dozen imps, and none of them look happy to see you.  A number of them take flight while the rest form a ring around you, trapping you!  It looks like you'll have to fight your way out!", false);
				menu();
				addButton(0, "FIGHT!", fightImpHorde);
			}
			else {
				dungeons.setDungeonButtons(checkDoor1, roomTunnel,roomFungusCavern, roomTortureRoom);
			}
		}
		
		public function roomFungusCavern():void {
			kGAMECLASS.dungeonLoc = 13;
			outputText("<b><u>Fungus Cavern</u></b>\n", true);
			outputText("This cavern is huge!  Though you can see the edge of a large stalactite to the west, the rest of the cave disappears into darkness beyond twenty or thirty feet away.  The floor is covered in spongy, leaf-shaped fungus.  They're huge, shiny, and purple, and they cover the cavern floor for as far as the illumination will reach.  ");
			if (flags[kFLAGS.ZETAZ_FUNGUS_ROOM_DEFEATED] == 0) {
				outputText("A strange, sweet smell hangs in the cavern's humid air, probably coming from the copious fungal flora.  At the edge of your vision you can see a humanoid skeleton propped up against a stalagmite.  There's a rapier laying a few feet in front of it, and it still looks as good as new.  What do you do?", false);
			}
			//Fungus creature dealt with!
			else {
				outputText("The familiar, sweet smell of them hangs in the cavern's humid air, but you're fairly certain they won't trouble you again.", false);
			}
			dungeons.setDungeonButtons(null, null, null, roomGatheringHall);
			//Had to place the button.
			if (flags[kFLAGS.ZETAZ_FUNGUS_ROOM_DEFEATED] == 0) {
				addButton(0, "Get Sword", getSwordAndGetTrapped);
				if (player.canFly()) {
					addButton(1, "Fly to Sword", flyToSwordAndGetTrapped);
				}
			}
		}
		
		public function roomTortureRoom():void {
			kGAMECLASS.dungeonLoc = 14;
			outputText("<b><u>Filthy Torture Room</u></b>\n", true);
			outputText("You step into a dank room, outfitted somewhere between a prison cell and a torture chamber. The ceiling of the sulfur-lined room is hung with an inventive variety of shackles, chains, and devices whose intent are not clear to you. Against the north wall, there appears to be an alchemy lab, laden with a dizzying collection of vials, flasks, and beakers. Against the south, there is a long, sinister-looking wooden rack bearing a sequence of progressively larger and thicker devices, carved to resemble monstrous cocks.  ", false);
			dungeons.setDungeonButtons(roomSecretPassage, null, roomGatheringHall, null);
			//Vala here?
			if (flags[kFLAGS.FREED_VALA] == 0) {
				spriteSelect(85);
				//Not yet defeated zetaz
				if (flags[kFLAGS.DEFEATED_ZETAZ] == 0) {
					//Intro:
					clearOutput();
					outputText("In the far corner, there is a small woman, her back to you, hanging limply by manacles that keep her suspended in a half-kneel. Rich purple hair hangs in long, clumped strands that sparkle occasionally with a pink glitter. Above her, there is a tarnished bronze nameplate that you think reads 'Vala,' but it's impossible to tell for sure under all the imp graffiti. She does not seem to be conscious.\n\n", false);
					outputText("It isn't until you get closer that you notice the large, dragon-fly wings attached to her back and the ephemeral glow of sunlight faintly radiating from her pale skin. If the girl wasn't almost 4' tall, you'd swear she was a fairy, like the ones you've met in the forest. If the cum-clogged drain in the center of the room is any indication, the imps must be using her for their perverted desires. You begin to get an appreciation for what she's endured when you get near enough to see the small, black marks staining her luminance. On her right shoulder blade, the imps have tattooed \"pussy\" and on the left, \"ass.\" All along her back, the imps have tattooed two columns of hash marks, from her shoulders all the way down her ribs, over her ass, down her legs, and even onto the soles of her feet.\n\n", false);
					outputText("You step around her and are startled to see that while the fey girl is whip-thin, her breasts are disproportionately huge. They'd be at least a DD-cup on a normal human, but for her height and body type, they're practically as large as her head. They jiggle at her slow, uneven breathing, tiny drops of milk bubbling at her nipples with every heartbeat. If she weren't chained to the ceiling, you suspect she wouldn't even be able to stand under her own power. Her eyes are open, but she's staring blankly ahead, unaware of the world around her, pupils constricted to pinpricks amid the ocean of her dulled pink irises. Like this, she's no threat to anybody. You suppose you could let her go, though it's unclear if she's self-aware enough to even move. Alternately, you could blow off a little steam.", false);
					//[Free] [Use] [Leave]
					if (player.gender > 0) {
						addButton(0, "Free", vala.freeValazLooseCoochie)
					}
					if (player.lust >= 33 && shouldraFollower.followerShouldra()) {
						addButton(1, "ShouldraVala", shouldraFollower.shouldraMeetsCorruptVala);
					}
				}
				//Zetaz defeated 
				else {
					outputText("In the far corner, there is a small woman, her back to you, hanging limply by manacles that keep her suspended in a half-kneel. Rich purple hair hangs in long, clumped strands that sparkle occasionally with a pink glitter. Above her, there is a tarnished bronze nameplate that you think reads 'Vala,' but it's impossible to tell for sure under all the imp graffiti. She does not seem to be conscious.\n\n", false);
					//Option to investigate her
					//leftValaAlone()
					addButton(0, "Faerie", vala.leftValaAlone);
				}
			}
			//Not here
			else outputText("In the far corner, there are a set of empty manacles, originally set up to contain Vala, who you've long since freed.", false);
		}
		
		public function roomSecretPassage():void {
			kGAMECLASS.dungeonLoc = 15;
			outputText("<b><u>Secret Tunnel</u></b>\n", true);
			outputText("This passage is the least livable area that you've seen out of the entire cave.  The walls and floor are little more than dirt and rocks, and explosions of dust burst from the ceiling with each tentative movement you make.  For a moment, a wave of claustrophobia threatens to rob you of your nerve, but you blink the pervasive particles from your eyes and focus on why you're here.  ", false);
			//If zetaz not yet defeated
			if (flags[kFLAGS.DEFEATED_ZETAZ] == 0) outputText("You're going to find Zetaz and pay him back for drugging you on your first day here.  ", false);
			outputText("A crude door on the southern edge of the tunnel leads back to the imp's sleeping chambers, but the tunnel continues away, curving sharply to the west where a far more lavish door marks the far side of the subterranean passage.", false);
			//(Item: sexy bondage straps/a set of sexy bondage straps/B.Straps? - Seduce ability?)
			//(Possible effect: +lust every round in combat if afflicted with Ceraph's bondage!)
			dungeons.setDungeonButtons(null, roomTortureRoom, roomZetazChamber, null);
			if (flags[kFLAGS.ZETAZ_LAIR_TOOK_BONDAGE_STRAPS] == 0) {
				outputText("\n\nA pair of fetishy, discarded straps lies on the floor, half obscured by dust.  It looks like something a goblin would wear.  Sexy!", false);
				addButton(0, "B.Straps", takeBondageStraps)
			}
		}
		
		public function roomZetazChamber():void {
			kGAMECLASS.dungeonLoc = 16;
			outputText("<b><u>Zetaz's Chambers</u></b>\n", true);
			outputText("You've stepped into the most lavish room in the entire cave system, and marvel at the difference between this magnificent abode and your own crudely constructed campsite.  The stone walls are covered in stolen tapestries that each look to have been liberated from a unique source.  Judging by the variety of depictions and art styles in this one room, you've barely met a fraction of the races that once inhabited the lands of Mareth.  A pair of bright, smokeless lanterns hang from each wall, lit from within by obviously magical spheres of luminescence.  Various pieces of stolen furniture decorate the room, surrounding a four-post bed decorated with masterfully done carvings of various carnal acts.", false);
			if (flags[kFLAGS.ZETAZ_DOOR_UNLOCKED] == 0) {
				outputText("  <b>There's a bolt holding a door to the south closed, but you give it a gentle tug and it comes unlocked.</b>", false);
				flags[kFLAGS.ZETAZ_DOOR_UNLOCKED] = 1;
			}
			outputText("\n\n", false);
			
			if (flags[kFLAGS.DEFEATED_ZETAZ] == 0) {
				outputText("A familiar imp is looking at you with a bewildered expression painted across his face.  You recognize his face immediately – this is Zetaz!  Oddly, he seems to have grown much larger in the time since your previous meeting.  He's over four feet tall and much more solidly built!\n\n", false);
				outputText("Zetaz whines, \"<i>Seriously?  You show up here!?  First you make me lose my job, and now you beat up my friends and track dirt in my bedroom!?  I've had enough!</i>\"", false);
				startCombat(new Zetaz(),true);
			}
			else {
				dungeons.setDungeonButtons(null, roomGatheringHall, null, roomSecretPassage);
			}
		}
	}

}