package classes.Scenes.Areas.Forest {
	import classes.*;
	import classes.GlobalFlags.kFLAGS;

	public class CorruptedGlade extends BaseContent implements TimeAwareInterface {
		
		public function CorruptedGlade() {
			CoC.timeAwareClassAdd(this);
		}
		
		public function timeChange():Boolean {
			if (flags[kFLAGS.CORRUPTED_GLADES_DESTROYED] > 1 && flags[kFLAGS.CORRUPTED_GLADES_DESTROYED] < 100) { //Extinct if you destroyed 100 Corrupted Glades.
				if (flags[kFLAGS.AMILY_DESTROYING_CORRUPTED_GLADES] > 0 && rand(6) == 0) flags[kFLAGS.CORRUPTED_GLADES_DESTROYED]++;
				if (flags[kFLAGS.KIHA_DESTROYING_CORRUPTED_GLADES] > 0 && rand(4) == 0) flags[kFLAGS.CORRUPTED_GLADES_DESTROYED]++;
				if (model.time.days % 3 == 0 && model.time.hours > 23) flags[kFLAGS.CORRUPTED_GLADES_DESTROYED]--; //Decrement by 1 every 3 days.
			}
			if (flags[kFLAGS.CORRUPTED_GLADES_DESTROYED] >= 100) { //Extinct state
				if (flags[kFLAGS.AMILY_DESTROYING_CORRUPTED_GLADES] > 0) flags[kFLAGS.AMILY_DESTROYING_CORRUPTED_GLADES] = 0;
				if (flags[kFLAGS.KIHA_DESTROYING_CORRUPTED_GLADES] > 0) flags[kFLAGS.KIHA_DESTROYING_CORRUPTED_GLADES] = 0;
			}
			return false;
		}
		
		public function timeChangeLarge():Boolean {
			return false;
		}
		
		public function intro():void {
			spriteSelect(92);
			outputText("Walking through the woods, you find a damp patch overgrown with corrupted plant-life.  Every flower seems warped into a colorful imitation of a female's genitals, each vine appears throbbing and veiny, and every knot on the nearby trees is capped with a nipple-like protrusion, leaking dark sap.");
			if (player.cor <= 33) { //disgusted reaction
				//Get plant-cum dripped on you if not fast and unlucky!
				if (player.spe < 60 && rand(player.spe + 50) < 50) {
					outputText("  Disgusted by this perversion of nature, you turn to leave, catching a faceful of the white goop that's spurting down from the vines above!  It's slimy, gross, and difficult to clear from your eyes, nose, and mouth.  The musky smell and delicious salty flavor are undoubtedly a result of the plant's corruption.  You escape the tainted glade, but feel warmer and warmer as time passes...");
					dynStats("lus", 20 + player.lib / 5);
				}
				else {
					outputText("  Disgusted by this perversion of nature, you turn away to leave, narrowly avoiding a sudden dripping of thick white fluid from the vines overhead.");
					dynStats("lus", 2);
				}
				outputText("\n\nOf course, you could resolve to destroy the corrupted glade if you want to.");
				doNext(camp.returnToCampUseOneHour);
				addButton(1, "Destroy Them", destroyTheCorruptedGladesChoice, null, null, null, "Attempt to destroy the perverted glade.");
			}
			else if (player.cor <= 66) { //intrigued reaction
				outputText("  You explore the glade with equal parts caution and curiosity.  ");
				switch(rand(3)) {
					case  0: //flowers...
						outputText("A group of perverted looking flowers catch your eye, leading you to bend closer for a better look at the intricately folded petals, noting the beads of slick moisture that seem to perspire from inside the plant.  Awed by the corrupt yet beautiful flower, you take a deep breath, inhaling a lungful of its pungent yet sweet scents.  It matches the flower somehow, lingering in your nose even after you pull away.  The smell makes you wonder just how functional the pussy flowers are, as they do have fairly large stalks.\n\nYou sigh and take one last sniff from the flower's honeypot before moving on.  Your body flushes happily with desire as your blood pools in your groin.  You giggle, wishing you could feel like this more often.");
						break;
					case  1: //vines...
						outputText("A few vines dangling from the trees catch your eye due to their rather 'unique' tips.  Every single one of them ends in a flared mushroom-like head, each twice as wide as the already thick vine.  You touch a vine gently, musing at its slippery texture and how similar it would be to a penis if the 'head' were smaller.  You encircle the vine with your hand, stroking it and giggling at the absurdity of this place.  The vine suddenly flexes in your grasp, pulsating and contracting as its head grows bigger, turning shiny and red.  Pulling away in shock, you gasp as the vine begins spurting out huge ropes of thick viscous fluid, splattering everywhere.  The plant-gasm ends as suddenly as it started, the 'head' retaining the size it gained and dripping the last of its strange load.  Overcome with curiosity, you sniff at the dripping spunk and swoon at the overpoweringly musky scent.  Gathering your wits, you decide to leave before you end up with one of those inside you.  You escape the corrupted glade, but stay flushed with arousal.");
						break;
					default: //trees...
						outputText("A cluster of huge breast-like knots on a nearby tree draws your attention.  Unable to resist, you poke one, and burst into giggles as it jiggles like a real breast!  You cautiously begin groping the tree-tit, and smile as it begins leaking sweet-smelling sap.  The scent conjures memories of helping to make maple syrup back home, and before you realize it, you've gathered a drop of the sap on your finger and tasted it.  It's powerfully sweet, making your tongue tingle and heart beat faster.  Unbidden, the thought of suckling the teat dry of its sweet treat comes to mind, but you manage to reject it and stumble away from the corrupted glade.  You have trouble with your tongue for the next hour: it won't stay in your mouth, and keeps licking your lips, seeking any leftover sweetness.  It almost distracts you from the palpable heat gathering between your thighs.");
				}
				dynStats("lus", 20 + player.lib / 5, "cor", .5);
				doNext(camp.returnToCampUseOneHour);
				addButton(1, "Destroy Them", destroyTheCorruptedGladesChoice, null, null, null, "Attempt to destroy the perverted glade.");
			}
			else { //drink sap/lick flower reaction
				outputText("  You smile as you enter the glade, wondering which of the forbidden fruits you should try...\n\nThere are flowers that bear more than a passing resemblance to pussies,\nvines with absurdly large penis-like tips,\nand trees covered in breast-like knots, leaking sap.");
				menu();
				addButton(0, "Flowers", flowerFun, null, null, null, "These flowers look like pussies. Play with the flower.");
				addButton(1, "Vines", tentacleFun, null, null, null, "These vines look like cocks at their tips. Play with the vines.");
				addButton(2, "Trees", treeBoobFun, null, null, null, "The knots on the trees look a lot like breasts. Play with the trees and lick some sap.");
				addButton(3, "Destroy Them", destroyTheCorruptedGladesChoice, null, null, null, "Attempt to destroy the perverted glade.");
				addButton(4, "Leave", camp.returnToCampUseOneHour);
			}
			//Wallow in decadence reaction - UNFINISHED
		}
		
		private function flowerFun():void {
			clearOutput();
			spriteSelect(92);
			if (player.hasCock()) { //Sex scenes for those with cawks
				if (player.cocks.length == 1) { //Single Cawk
					outputText("You grin to yourself as you decide to see just how close to a pussy these perverted little flowers are.  The thick stem bends with ease as you grasp it and bend it towards your groin, your other hand fumbling to open your " + player.armorName + ".  In seconds you free yourself and gingerly bring the folds closer, the musky scent that fills the air rapidly bringing you to a full, throbbing hardness.  The first touch of petals to your skin slicks you with the flower's silky secretions, allowing you to easily slip between the petals.  Though the flower looks fairly deep, you quickly feel yourself bottom out inside the petal's slippery grip.  Shrugging, you decide to make the best of it and begin thrusting into the plant, enjoying the unusual sensations along the front-most parts of your " + player.cockDescript(0) + ".  As you pound away, you begin to notice a change in the rear of the flower.\n\n");

					outputText("It feels as if something is opening up, and the tip of your cock begins slipping through a tight ring, bulging the plant's stem noticeably.  The sudden change worries you enough to pull back for a moment, your " + player.cockDescript(0) + " nearly clearing the opening before dozens of tiny whip-like tendrils burst from the flower, wrapping your maleness with painful tightness.  They constrict further and with a burst of movement, slam the flower down onto your " + player.cockDescript(0) + ", pulling you further and further into the stem with painful force.  You struggle briefly but the pain it causes your over-stimulated member is too much, so you just give up, letting the pussy-like plant draw the last of you inside its stem, the silken flowers cupping around your ");
					if (player.balls > 0)
						outputText("balls and gently squeezing them.\n\n");
					else
						outputText("groin and gently squeezing your taint.\n\n");
						
					outputText("You feel a flood of wetness surge up from the depths of the plant, surrounding your member with even more fluid as the stem begins constricting and squeezing.  Gently at first, and then with increasing insistence, a suction builds inside the stem, drawing more and more blood into your " + player.cockDescript(0) + ".  The stem, now heavily distended by your massive member, continues rippling, squeezing, and sucking your over-engorged meat-pole, overwhelming your mind with sensation far beyond normal.  You'd wonder just what kind of tactile-enhancing fluids that plant excretes, if you weren't already mindlessly pistoning against the tainted plant, still locked inside it by tight little tentacles.\n\n");
				}
				else { //Multicock
					outputText("You grin to yourself as you decide to see just how close to a pussy these perverted little flowers are.  The thick stems bend with ease as you grab a few with your hand and pull them towards your groin, your other hand fumbling to open your " + player.armorName + ".  In seconds you free yourself, and gingerly bring the folds closer.  The musky scent filling the air rapidly brings your " + player.multiCockDescriptLight() + " to a full, throbbing hardness.  The first touch of petals to your skin slicks you with the flower's silky secretions, allowing you to easily slip between the petals.  Though the flowers look fairly deep, you quickly feel yourself bottom out inside the petals' slippery grip.  Shrugging, you decide to make the best of it and begin thrusting into the plant, enjoying the unusual sensations along the front-most parts of your " + player.multiCockDescriptLight() + ".  As you pound away, you begin to notice a change in the rear of the flowers.\n\n");

					outputText("They seem to be gradually opening up, allowing the smallest of your cock-tips to begin slipping through an opening in the backs of the flowers and into the stems.  Shocked by this unexpected development, you pull the bundle of flowers from your " + player.multiCockDescriptLight() + ", but whiplike tendrils shoot forth from deep within the flowers, wrapping tightly around your manhoods, painfully squeezing as they drag your " + player.multiCockDescriptLight() + " back into the tight vaginal openings.  They pull tighter as they force you deeper inside the plant, pulling the full length of each of your members into the constricting stalks.   Wrapped tightly around your base, the tendrils form effective cock-rings, making each of your " + player.multiCockDescriptLight() + " overfill with blood.\n\n");
					
					outputText("You briefly try to free yourself but the pain it causes your groin overwhelms you.  Resigned to your fate, you allow the plants to wrap their petals fully around your groin, encapsulating all of your maleness.  With surprising gentleness, you feel a suction and squeezing building around each and every one of your dicks.  You feel a flood of fluids around each over-engorged member, making them tingle with unnatural sensitivity.  The squeezing and sucking of the plant's stalks, combined with the sudden onset of strange sensation, is too much to bear.  You feel a churning pressure at the base of your groin, liquid heat filling every member as your body makes ready to give these plants what they want.\n\n");
				}
				outputText("You cum, and cum, and cum, the evidence of your pleasure devoured by the plant's sucking, squeezing gullet.  The orgasm drags on for what feels like forever, your " + player.legs() + " eventually giving out, your hips the only muscle that seems to work as they twitch into the air, as if begging for more.  You are milked of a few last big spurts, at last collapsing.\n\n");
				
				outputText("The tendrils encircling your genitals do not release; instead they pull tighter, one of " + (player.cocks.length > 1 ? "each plant's tiny" : "the tiny plant's") + " appendages penetrating your urethra" + (player.cocks.length > 1 ? "s" : "") + ", squirming up your cum slicked passage" + (player.cocks.length > 1 ? "s" : "") + " with uncomfortable slowness.  You lay there, too weak to resist it or fight, hoping that whatever the plants are doing won't hurt much.  You feel it twisting and coiling inside you... until it stops.  You feel a sharp pinch, and then it withdraws, seemingly satisfied.  The tendrils unwrap, allowing the plants to spring back up, exposing your still over-engorged and sensitive member" + (player.cocks.length > 1 ? "s" : "") + ".\n\n");
				
				outputText("You lay there for some time until your muscle control returns, your cock" + (player.cocks.length > 1 ? "s" : "") + " still slightly over-large " + (player.balls >= 2 ? "and your " + player.ballsDescriptLight() : "and") + " feeling sore from the exertion.  At least you hope it's just from the exertion and not from whatever the plant did.\n\n");
				if (player.cumQ() < 25)
					outputText("As you depart, you notice the plants looking remarkably colorful and healthy...");
				else if (player.cumQ() < 250)
					outputText("As you depart, you notice the plants' stalks bulging slightly from your deposit, their flowers wet with moisture and bright red.");
				else if (player.cumQ() < 500)
					outputText("As you depart, you note the plants' stalks bulging obscenely, bits of your seed dripping from the flowers' opening.");
				else outputText("As you depart, you note the plants' stalks bulging out obscenely, looking like overfull balloons.  They're stretched so thin as to be transparent, your cum sloshing about inside them as they attempt to digest their meals.  Steady streams of your jism leak from the flowers' lips, unable to keep it all inside.");
				//Stat changes!
				player.orgasm();
				dynStats("sen", 2);
				var booster:int = 1;
				if (player.balls == 0)
					booster += 3;
				else if (player.ballSize < 6)
					booster += 2;
				if (player.findPerk(PerkLib.MessyOrgasms) >= 0 && player.cumMultiplier < 3) booster += 1;
				player.cumMultiplier += booster;
			}
			else { //Oral sex for those without!
				outputText("You grin to yourself and decide to sample the fine smelling nectar of the flowers. You grip the unusually thick stalk as you lean down, taking in the bright red and iridescent purples of the pussy-flower's petals. You give it an experimental lick, gaining a feeling for the flavor of the nectar. It's delicious, but leaves your tongue tingling and sensitive. A small budding protrusion emerges from between the petals, slick with more of the plants fluid, cherry red and looking very much like an engorged clit.\n\n");

				outputText("Giddy from either the novelty of the situation or the chemicals in the flower's juices, you lick at the plant's bud-like clit and are immediately rewarded with a burst of fruity plant-nectar. The taste becomes the last thing on your mind as your tongue becomes even more sensitive, every touch and taste rapidly becoming highly erotic. You delve into its folds, seeking more nectar, your tongue slurping and licking, noisily tongue-fucking the little plant. The taste deepens, losing some of the sweetness as that clitty swells bigger, drops of tangy moisture oozing from it.\n\n");

				outputText("Closing your eyes, it becomes easy to lose yourself in the feeling of plunging in and out of those petals, your tongue a tiny cock. You revel in the decadence of it all, your lips becoming equally sensitive and engorged, french kissing the pussy-flower with abandon, rubbing your puffy lips over its clit, tongue-fucking the flower with abandon. The petals curl around your face, as a sudden gush of fluid rushes out from deep within the flower, flooding your mouth with tangy sweetness. Your tongue quivers in pleasure as you feel your over-sensitized mouth orgasming, pleasurable and unlike anything else you've experienced. Swallowing instinctively, you collapse back on your haunches, licking your lips and squirming in satisfaction.");
				
				outputText("You walk away, your lips and tongue feeling slightly puffy and sensitive, but none the worse for the wear.");
				player.slimeFeed();
				player.orgasm();
				dynStats("sen", 4, "cor", 1);
			}
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function tentacleFun():void {
			clearOutput();
			spriteSelect(92);
			if (player.vaginas.length > 0 && rand(2) == 0) { //Vaginal Variant 50% of the time
				outputText("You saunter over to a dangling group of perverted looking vines, discarding your " + player.armorName + " along the way. Running your fingertips along the bulbous-tipped tentacle-like vines, you find one that looks ");
				var tentacle:int = rand(3); //Big, medium or small size tentacle
				var tentacleSize:int = 0;
				if (tentacle == 0) { //Small
					outputText("a little small for your ");
					switch (player.vaginas[0].vaginalLooseness) {
						case VAGINA_LOOSENESS_TIGHT:		tentacleSize =   0; break;
						case VAGINA_LOOSENESS_NORMAL:		tentacleSize =   4; break;
						case VAGINA_LOOSENESS_LOOSE:		tentacleSize =  16; break;
						case VAGINA_LOOSENESS_GAPING:		tentacleSize =  40; break;
						case VAGINA_LOOSENESS_GAPING_WIDE:	tentacleSize =  65; break;
						default:							tentacleSize = 100;
					}
				}
				if (tentacle == 1) { //Normal
					outputText("well suited to your ");
					switch (player.vaginas[0].vaginalLooseness) {
						case VAGINA_LOOSENESS_TIGHT:		tentacleSize =   3; break;
						case VAGINA_LOOSENESS_NORMAL:		tentacleSize =   7; break;
						case VAGINA_LOOSENESS_LOOSE:		tentacleSize =  26; break;
						case VAGINA_LOOSENESS_GAPING:		tentacleSize =  60; break;
						case VAGINA_LOOSENESS_GAPING_WIDE:	tentacleSize = 115; break;
						default:							tentacleSize = 175;
					}
				}
				if (tentacle == 2) { //Large
					outputText("almost too big to cram in your ");
					switch (player.vaginas[0].vaginalLooseness) {
						case VAGINA_LOOSENESS_TIGHT:		tentacleSize =   6; break;
						case VAGINA_LOOSENESS_NORMAL:		tentacleSize =   9; break;
						case VAGINA_LOOSENESS_LOOSE:		tentacleSize =  34; break;
						case VAGINA_LOOSENESS_GAPING:		tentacleSize =  78; break;
						case VAGINA_LOOSENESS_GAPING_WIDE:	tentacleSize = 135; break;
						default:							tentacleSize = 210;
					}
				}
				//resume secksings
				outputText(player.vaginaDescript(0) + ". Pulling gently, you manage to yank a bit more vine free, allowing it to brush against the damp forest loam. That same soft earth makes the perfect cushion for you as you lay down, spreading your legs. With both hands you grasp the vine, guiding it towards the entrance of your " + player.vaginaDescript(0) + ". The beaded moisture that covers the vine tingles tantalizingly at the first contact with your lips.\n\n");

				if (tentacle == 0) //Small
					outputText("With a sexy little sigh, you slip the mushroom-like tip between your nether-lips, feeling it bulge a little as it penetrates you. The vine's lubricants combine with your own, turning your horny cunt into a sloppy little slip-and-slide. You take it all the way to your cervix, easily handling its smaller size as you begin to use it like a favorite dildo. Deep inside your " + player.vaginaDescript(0) + ", the vine's lubricants begin to make your passage tingle, intensifying until your entire channel is overloaded with clit-like levels of sensation.\n\n");
				if (tentacle == 1) //Medium
					outputText("With a soft grunt, you manage to wrangle the fat tip of the vine between your nether-lips, feeling the swollen bulge pulse inside you penetrate yourself with it. The vine's lubricants combine with your own, turning your horny cunt into a sloppy slip-and-slide. You force in the rest of the vine's length, taking it all the way to your cervix, enjoying the feeling of fullness it gives you as you begin pumping it in and out like an obscene green dildo. Deep inside your " + player.vaginaDescript(0) + ", the vine's lubricants begin to make your passage tingle, intensifying until your entire channel is overloaded with clit-like levels of sensation.\n\n");
				if (tentacle == 2) //Large
					outputText("With a desperate grunt, you barely manage to force the obscene cock-head of the vine between your nether-lips. The swollen bulge pulses inside you, stretching you uncomfortably as it reacts to the warmth and tightness of your " + player.vaginaDescript(0) + ". The vine's lubricants begin to combine with your own, rapidly transforming your horny cunt into a sloppy slip-and-slide. You manage to cram the vine the rest of the way inside, bottoming it out against your cervix, reveling in the feeling of being stretched so wide, as you begin pumping it in and out of your " + player.vaginaDescript(0) + " like an over-sized sex-toy. Deep inside your " + player.vaginaDescript(0) + ", the vine's lubricants begin to make your passage tingle, intensifying until your entire channel is overloaded with clit-like levels of sensation.\n\n");
				if (player.cuntChange(tentacleSize, true)) outputText("\n\n"); //Stretch cuuuuunt and newline if it gets stretched

				outputText("The rest of the world disappears as your mind tries to cope with the sensation overload coming from your groin. You're dimly aware of your hands pumping the slippery vine in and out, in and out, over and over.  Hips bucking, " + player.vaginaDescript(0) + " squeezing, thighs trembling, you achieve the first of many orgasms.  Incredibly, the sensitivity of your groin redoubles, nearly blacking you out from the pleasure.  Cumming over and over, you writhe in the dirt, pumping the corrupted prick-vine in and out of your spasming cunt.  Your eyes roll back in your head when the vine begins pumping you full of its strange fluid, and you finally lose your battle to remain conscious.\n\n");

				outputText("An hour or two later, you wake feeling very sore, but satisfied.  The vine must have popped free at some point and the bulb now rests on your pussy lips.  You go to brush it off and nearly orgasm from touching your nether-lips, still sensitive and parted from the overlarge tentacle they so recently took.  A rush of white goop escapes from between your thighs as you stand, soaking back into the soil immediately.   A quick stretch later, you don your gear and head back to camp with a smile.\n\n");
				//Normal stat changes
				player.orgasm();
				dynStats("sen", 5, "cor", 2);
				//Xforms
				if (rand(3) == 0 && player.hairColor != "green") { //Change hair to green sometimes
					outputText("You don't get far before you realize all the hair on your body has shifted to a verdant green color.  <b>You now have green hair.</b>  ");
					player.hairColor = "green";
				}
				if (rand(4) == 0 && player.hipRating <= 10) { //+hip up to 10
					outputText("A strange shifting occurs below your waist, making your " + player.armorName + " feel tight.  <b>Your hips have grown larger</b>, becoming " + player.hipDescript() + ".  ");
					player.hipRating += rand(3) + 1;
					player.fertility++;
				}
			}
			else {
				outputText("You approach the swollen vines, noting a drizzle of fluid leaking from one of the bulbous and mushroom-like tips.   Licking your lips as you approach, you feel your heart beat faster in anticipation of sampling the tainted flora of the glade.   Grasping one gently, you lift it up, noting the pebbly texture along the curvature of its head, and the soft nubs on the underside where it rejoins the stalk.  The whole thing feels moist, just barely lubricated with some fluid that the plant seems to sweat.\n\n");

				outputText("Pulling it closer, you open your mouth wide enough to take in the plant, slipping it between your lips.  The taste of the plant is starchy with a tangy aftertaste.  You run your tongue around it lewdly, your efforts swiftly rewarded by a spurt of salty cream.   The penis vine seems more receptive to your actions than the real thing, shifting color to a rapidly darkening pink.  You begin jacking the vine off with your hands, rubbing a fingertip where the 'bulb' joins the stalk.  In no time it starts spurting seed into your throat, bright crimson spreading back along the vine as thick bulges of goo are pumped down the vine.  The bulb in your mouth swells up like a balloon, wrenching your jaws apart and trapping itself behind your teeth.   You're forced to breathe through your nose as it rapidly plugs your oral opening, gulping down each load of throat-filling seed in an effort not to choke.\n\n");

				outputText("You wonder if your efforts are in vain as time passes and your stomach fills with strange alien fluids.  Feeling faint from lack of oxygen, you drop to your knees, throat working overtime to swallow and breathe, only to immediately swallow another load.   Your whole body burns from the effort.  Your lungs hurt, your heart spasms, and your gut gurgles as it takes in the strange liquid.   Nearly unconscious, you sway, the vine pulled tight in your mouth, supporting the weight of your body.\n\n");

				outputText("With a snap you feel consciousness return; the endless torrent of fluid has stopped, though your mouth is still pried wide open by the engorged bulb.  In panic, you thrash backwards, painfully yanking against the now-taut vine.  You struggle in vain  for a moment, the vine not giving an inch, until finally you feel the bulb start to soften.  Working it back and forth, you eventually manage to pry it free with a satisfying 'pop'.   Rubbing your hand against your sore jawline, you step away from the glade, spitting out some of the musky goop with every step.\n\n");
				//Last PG includes change-texts
				outputText("As you leave the corrupted plant-life behind a comforting warmth seems to radiate from your gut, suffusing you with gentle heat that makes your ");
				
				if (player.cocks.length > 0) { //Cocks (and maybe vagina)
					outputText(player.cocks.length == 1 ? player.cockDescript(0) : player.multiCockDescriptLight());
					if (player.vaginas.length > 0) outputText(" and " + player.vaginaDescript(0));
				}
				else if (player.vaginas.length > 0) //Vagina
					outputText(player.vaginaDescript(0));
				else outputText("nipples"); //Nipples
				//Finish sentance
				outputText(" tingle.  ");
				//Simple stat changes - + lust.
				dynStats("lus", 25 + player.lib / 10, "cor", 2);
				//Change hair to green sometimes
				if (rand(3) == 0 && player.hairColor != "green") {
					outputText("You don't get far before you realize all the hair on your body has shifted to a verdant green color.  <b>You now have green hair.</b>  ");
					player.hairColor = "green";
				}
				//+butt up to 10
				if (rand(4) == 0 && player.buttRating <= 10) {
					outputText("A strange shifting occurs on your backside, making your " + player.armorName + " feel tight.  <b>Your butt has grown larger</b>, becoming a " + player.buttDescript() + ".  ");
					player.buttRating += rand(3) + 1;
				}
				//Rarely change one prick to a vine-like tentacle cock. 
				if (rand(3) == 0 && player.cocks.length > 0 && player.hairColor == "green") {
					if (player.countCocksOfType(CockTypesEnum.TENTACLE) < player.cockTotal()) {
						if (player.cocks.length == 1) { //Single cawks
							outputText("Your feel your " + player.cockDescript(0) + " bending and flexing of its own volition... looking down, you see it morph into a green vine-like shape.  <b>You now have a tentacle cock!</b>  ");
							//Set primary cock flag
							player.cocks[0].cockType = CockTypesEnum.TENTACLE;
						}
						if (player.cockTotal() > 1) { //multi
							outputText("Your feel your " + player.multiCockDescriptLight() + " bending and flexing of their own volition... looking down, you watch them morph into flexible vine-like shapes.  <b>You now have green tentacle cocks!</b>  ");
							for (var x:int = 0; x < player.cocks.length; x++) player.cocks[x].cockType = CockTypesEnum.TENTACLE;
						}
					}
				}
			}
			player.slimeFeed();
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function treeBoobFun():void {
			clearOutput();
			spriteSelect(92);
			outputText("Stepping carefully around the other hazards of the glade, you close on the strange trees with equal parts curiosity and desire.  Up close, it's easy to see the strange growths that sprout from the bark – dozens of full ripe-looking breasts, each capped with a swollen and leaking nipple.  You touch one, marveling at the smooth texture of its chocolate-colored skin.   In response a runner of sap oozes free of the nipple and slides down the curved surface.\n\n");
			outputText("You lean forwards and lick around the nipple's surface, sampling the sweetness of the trickling sap.   The stuff nearly overpowers you with a taste like syrupy cream as more sap drips free of the fully-erect tree-nipple.  Unable to resist testing this nonsensical oddity, you engulf the entire nipple between your lips, suckling hard.   The tree seems to oblige your efforts with a fresh discharge of the sticky sap.   Your tongue tingles and vibrates with the sinfully sweet taste in your mouth, dancing in circles around the nipple, coaxing yet more nectar from swollen plant-jug.  It's easy to lose yourself in that taste, falling into a rhythm of alternatively sucking, swallowing, and licking.\n\n");
			outputText("In time you realize the breast has long since been emptied by your hungry mouth, and you pull free with a pop, letting your tongue run over your now over-sensitive lips.  It seems your entire mouth has been affected by the tree's sap, and is now as sensitive and receptive as a maiden's box.  You don't think you could drink any more sap with how full you feel, and you make ready to depart this perverted place.");
			dynStats("sen", 1, "lus", 15, "cor", .5);
			player.slimeFeed();
			if (player.findStatusEffect(StatusEffects.LustyTongue) < 0) {
				if (rand(4) == 0) { //25% Chance of sensitive mouth status – increased lust gain/hour due to licking your lips :3
					outputText("  The feeling doesn't seem to fade, only becoming more and more intense over the coming hour.  It will be hard to keep from getting turned on any time you lick your lips or eat some food.");
					player.createStatusEffect(StatusEffects.LustyTongue, 24, 0, 0, 0);
				}
				else outputText("  Thankfully, the feeling goes away after a few minutes, leaving you feeling just a bit more sensitive.");
			}
			if (rand(2) == 0) { //50% Chance of breast-growth
				if (player.biggestTitSize() > 5) {
					outputText("  As you redress, you feel a sense of added weight on your chest.  After a few moments you realize your already-formidable chest has grown even larger.");
					player.growTits(1, 1 + rand(3), false, 1);
				}
				else {
					if (player.biggestTitSize() == 0) { //No tits yet
						outputText("  As you redress, you realize you have grown a pair of luscious breasts!  Perhaps this was a good idea after all...");
						player.growTits(1, 2 + rand(3), false, 1);
					}
					else { //Small tits growth
						outputText("  As you redress, you realize your breasts have gotten quite a bit larger!  Maybe you can come back later when you aren't so full and plump them up a bit more.");
						player.growTits(1, 1 + rand(3), false, 1);
					}
				}
			}
			doNext(camp.returnToCampUseOneHour);
		}
		
		//DESTROY THE CORRUPTED GLADE!
		private function destroyTheCorruptedGladesChoice():void {
			clearOutput();
			outputText("You ponder over how to destroy the foul glade.");
			menu();
			var button:int = 0;
			if (player.findPerk(PerkLib.Dragonfire) >= 0 || player.findPerk(PerkLib.FireLord) >= 0 || player.findPerk(PerkLib.Hellfire) >= 0) {
				addButton(button++, "Fire Breath", destroyTheCorruptedGlades, 0);
			}
			if (player.findPerk(PerkLib.EnlightenedNinetails) >= 0 || player.findPerk(PerkLib.CorruptedNinetails) >= 0) {
				addButton(button++, "Fox Fire", destroyTheCorruptedGlades, 1);
			}
			if (player.findStatusEffect(StatusEffects.KnowsWhitefire) >= 0) {
				addButton(button++, "Whitefire", destroyTheCorruptedGlades, 2);
			}
			if (player.hasKeyItem("Carpenter's Toolbox") >= 0 || player.weapon == weapons.L__AXE) {
				addButton(button++, "Axe", destroyTheCorruptedGlades, 3);
			}
			if (player.weaponVerb == "stab" || player.weaponVerb == "slash" || player.weaponVerb == "cleave" || player.weaponVerb == "keen cut") {
				addButton(button++, "Weapon", destroyTheCorruptedGlades, 4);
			}
			addButton(button++, "Your Hands", destroyTheCorruptedGlades, 5);
			addButton(14, "Nevermind", camp.returnToCampUseOneHour);
		}
		
		private function destroyTheCorruptedGlades(choice:int):void {
			var destroyAmount:int = 0;
			clearOutput();
			outputText("That's it. Those fucking glades must die!\n\n");
			//Fire abilities
			switch(choice) {
				case 0: //Fire breath
					outputText("You charge the fire within you and as soon as you build it up enough, you unleash it on the glade, lighting them on fire. By the time the fire dies out, charred plants are all that remain of the glade.\n\n");
					destroyAmount++;
					player.changeFatigue(20, 1);
					break;
				case 1: //Nine tails foxfire
					outputText("Holding out your palm, you conjure a flame that dances across your fingertips.  You launch it at the glade with a ferocious throw, and it bursts on impact, setting the glade on fire. By the time the fire dies out, charred plants are all that remain of the glade.\n\n");
					destroyAmount++;
					player.changeFatigue(20, 1);
					break;
				case 2: //Whitefire
					outputText("You narrow your eyes, focusing your mind with deadly intent. You snap your fingers and the glade is enveloped in a flash of white flames! By the time the fire dies out, charred plants are all that remain of the glade.\n\n");
					destroyAmount++;
					player.changeFatigue(20, 1);
					break;
				case 3: //Axe
					outputText("You grab an axe from your toolbox and hack away at the plants without mercy. Eventually, you manage to chop down every perverted plant in the glade save for some of the trees. They gradually wither away. ");
					outputText("Finally, you chop down the trees with all your strength, making wedge-shaped cuts. With one last almighty swing, the tree falls and lands on the ground with a loud THUD. It looks like they would make fine wood. You chop the tree into several pieces and haul the wood to your camp. ");
					camp.cabinProgress.incrementWoodSupply(10);
					player.changeFatigue(30 - (player.str / 10));
					outputText("\n\n");
					break;
				case 4: //Weapon
					outputText("You ready your [weapon] and hack away at the plants without mercy. Eventually, you manage to cut down every perverted plant in the glade except for the trees. They gradually wither away. You give the breast-knotted trees some vandalism before turning to leave.\n\n");
					player.changeFatigue(40 - (player.str / 5));
					break;
				case 5: //Your strength!
					if (player.str < 30) { //Low strength.
						outputText("You grab at one of the plants and easily rip the flower stem. Next, you grab one of the vines and focus on tearing it but despite your best efforts, you can't tear it. Sighing with frustration, you drop the vine. You'll have to come back later. \n\n");
						player.changeFatigue(50);
						doNext(camp.returnToCampUseOneHour);
						return;
					}
					else if (player.str >= 30 && player.str < 70) { //Medium strength
						outputText("You grab at one of the plants and easily rip the flower stem. Next, you grab one of the vines and focus on tearing it and with all your efforts, you manage to tear it. Finally, you look up at the tree but there's no way you could easily take down the tree. \n\n");
						player.changeFatigue(40);
					}
					else { //High strength
						outputText("You grab the pussy-flowers and cock-vines and tear them with little effort. Next, you look up at the breast-knotted tree and grab the knots. With some efforts, you yank and rip out the knots. Finally, you twist and snap the tree, ending its life. \n\n");
						player.changeFatigue(30);
					}
					break;
				default:
					outputText("<b>Please report this error to Kitteh6660.</b>\n\n");
			}
			if (flags[kFLAGS.CORRUPTED_GLADES_DESTROYED] == 0) outputText("That's one glade eliminated! With effort and dedication, you will be able to cleanse the forest of foul glades.");
			else outputText("Once again, the forest is cleansed of a tainted glade.");
			
			dynStats("cor", -1);
			destroyAmount++;
			flags[kFLAGS.CORRUPTED_GLADES_DESTROYED] += destroyAmount;
			//Milestone events
			if (flags[kFLAGS.CORRUPTED_GLADES_DESTROYED] == 25) outputText("\n\nYou have a feeling you'll see the glades somewhat less often.");
			if (flags[kFLAGS.CORRUPTED_GLADES_DESTROYED] == 50) outputText("\n\nYou have a feeling you'll see the glades less often.");
			if (flags[kFLAGS.CORRUPTED_GLADES_DESTROYED] == 75) outputText("\n\nYou have a feeling you'll see the glades much less often.");
			if (flags[kFLAGS.CORRUPTED_GLADES_DESTROYED] == 100) outputText("\n\nThat should be the last of the glades! <b>Corrupted Glades are now extinct.</b>");
			doNext(camp.returnToCampUseOneHour);
		}
	}
}