/**
 * Side Dungeon: Twilight Grove (Corrupted Alraune grove)
 * @author Liadri
 */
package classes.Scenes.Dungeons 
{
import classes.EventParser;
import classes.BodyParts.Arms;
import classes.BodyParts.Ears;
import classes.BodyParts.Face;
import classes.BodyParts.Hair;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kFLAGS;
import classes.Races;
import classes.CoC;

	public class TwilightGrove extends DungeonAbstractContent
	{
		
		public function TwilightGrove() 
		{}
		
		public function enterDungeon():void {
			inDungeon = true;
			if ((player.cor >= 51 || player.isRaceCached(Races.ALRAUNE)) && flags[kFLAGS.TWILIGHT_GROVE_PURIFICATION] < 1) room1TGCorrupt();
			else room1TGPure();
		}
		
		public function exitDungeon():void {
			inDungeon = false;
			clearOutput();
			outputText("You leave the twilight grove behind and take off back towards the camp.");
			endEncounter();
		}
		
		private function room1TGPure():void {
			clearOutput();
			dungeonLoc = DUNGEON_TWILIGHT_GROVE_1;
			outputText("As you wander the woods, you stumble on a corrupt glade similar to those you have come across before except at its edge stands a large ornate gate made of entwined brambles. When you approach and touch the brambles out of curiosity, the plant moves on its own, slithering away to block the path from you. Clearly, you are unwelcome. Will you forcefully enter this eerie place or leave?");
			if (flags[kFLAGS.DISCOVERED_TWILIGHT_GROVE_DUNGEON] < 1) flags[kFLAGS.DISCOVERED_TWILIGHT_GROVE_DUNGEON] = 1;
			menu();
			//addButton(1, "Fight", room1Fight);
			addButton(3, "Leave", room1TGPureLeave);
		}//flags[kFLAGS.TWILIGHT_GROVE_PURIFICATION] > 0	outputText("");
		private function room1TGPureLeave():void {
			inDungeon = false;
			clearOutput();
			outputText("The malice in this area is almost palpable. You should come back when you’re better prepared.");
			endEncounter();
		}
		
		private function room1TGCorrupt():void {
			clearOutput();
			dungeonLoc = DUNGEON_TWILIGHT_GROVE_1;
			if (flags[kFLAGS.DISCOVERED_TWILIGHT_GROVE_DUNGEON] > 1) {
				if (flags[kFLAGS.PC_CANT_DECIDE_ON_BEEN_ALRAUNE_OR_NOT] == 1 && !playerIsAlraune()) flags[kFLAGS.PC_CANT_DECIDE_ON_BEEN_ALRAUNE_OR_NOT] = 0;
				menu();
				addButton(3, "Leave", room1TGCorruptLeave);
				if (playerIsAlraune()) {
					if (flags[kFLAGS.PC_CANT_DECIDE_ON_BEEN_ALRAUNE_OR_NOT] == 0) room1TGCorruptEnter2();
					else {
						outputText("Aster the satyr is quietly waiting at his desk at the entrance for potential customers. Since you are the sister of the owner you can enjoy the place for free.");
						addButton(1, "Have a rest", corruptTGHaveARest2);
						addButton(2, "Rafflesia", corruptTGRafflesia).hint("Discuss various topics with your elder sister.");
					}
				}
				else {
					outputText("Aster the satyr is quietly waiting at his desk at the entrance for potential customers.");
					if (flags[kFLAGS.DISCOVERED_TWILIGHT_GROVE_DUNGEON] > 2) addButton(1, "Have a rest", corruptTGEnjoySomeRest);
					else {
						outputText(" If you have corrupted items you could buy yourself some well needed-relaxation.");
						addButtonIfTrue(1, "Have a rest", corruptTGHaveARestPay, "You would like to use the resort but don’t have any corrupted items to pay for it.", (player.hasItem(consumables.SUCMILK, 1) || player.hasItem(consumables.INCUBID, 1) || player.hasItem(consumables.SDELITE, 1)));
						if (flags[kFLAGS.DISCOVERED_TWILIGHT_GROVE_DUNGEON] == 2) addButtonIfTrue(7, "VIP", corruptTGHaveARestVIPBuyItBuyItNowBeforeItPriceRise, "Req. 500+ gems", player.gems >= 500);
					}
				}
				//outputText("\"<i></i>\"\n\n");
				//outputText("\n\n");
			}
			else {
				outputText("As you wander the woods, you stumble on a corrupt glade similar to those you have come across before except at its edge stands a large ornate gate made of entwined brambles. When you approach and touch the brambles out of curiosity, the plant moves on its own, slithering away to open the path for you. Clearly, you are expected. Will you enter this eerie place or leave?");
				if (flags[kFLAGS.DISCOVERED_TWILIGHT_GROVE_DUNGEON] < 1) flags[kFLAGS.DISCOVERED_TWILIGHT_GROVE_DUNGEON] = 1;
				menu();
				addButton(1, "Enter", room1TGCorruptEnter);
				addButton(3, "Leave", room1TGCorruptLeave);
			}
		}
		private function room1TGCorruptLeave():void {
			inDungeon = false;
			clearOutput();
			outputText("This of course, looks interesting, but you have better things to do and simply decide to come back later.");
			endEncounter();
		}
		private function room1TGCorruptEnter():void {
			clearOutput();
			outputText("You enter cautiously, coming out into what looks like an entirely different part of the woods. You can see a few green skinned succubi resting quietly by a shimmering pond as if taking a sunbath, a few satyrs regularly offering them fruits and wine, with some of them even livening the place up with music. They all wear floral ornaments, although a closer examination reveals these to actually be real genuine flowers naturally adorning their bodies. ");
			outputText("Speaking of flowers, you can see quite a few tentacle beasts dozing off at random locations in the grove. It's not just the denizens of the grove that trouble you, but also the grove itself. The water here is purple, as if contaminated with dense corruption, many corrupt trees grow in the area, breasts and other body parts leaking viscous dark sap, and you can even see driders patiently spinning their webs high above in the branches. ");
			outputText("At the epicenter of the pond and lording over this unholy masterpiece, is a large black orchid flower at least six times your size. After much examination, you realize the succubi are all periodically getting themselves fucked by the tentacle vines sprouting from this flower, writhing in pleasure every now and then as they squirt around their floral intruder. Before you even get a chance to question what is going on around here, a large satyr with a bow approaches you.\n\n");
			outputText("\"<i>Oh, a traveler? Tell me, what winds bring you to the twilight grove, our dark paradise? Is it business...or pleasure?</i>\"\n\n");
			outputText("You admit to have stumbled upon this haven by accident and tell him as such. Regardless, who is he to begin with, and what is this place?\n\n");
			outputText("\"<i>My name is Aster, and I am this haven’s gatekeeper. I opened the gate to your approach as I sensed "+(playerIsAlraune()?"the approach of a lady such as":"a particularly corrupt essence in")+" you. This grove is a haven of delight and decadence, a retreat where demons and corrupted creatures "+(playerIsAlraune()?"":"like you and I ")+"can come and enjoy themselves at their leisure.</i>\"\n\n");
			outputText("What exactly can you do in the grove? It looks like a pleasant place for a relaxing time.\n\n");
			outputText("\"<i>First, before we do anything, you will need to meet the mistress personally as she requested to see you. She oversees everything that happens here.</i>\"\n\n");
			outputText("The seven-foot tall Satyr walks you to a bridge that leads to the center of the grove where a black flower grows. He bows down respectfully, then walks away leaving you with the peculiar plant. You see the giant orchid bloom open as a woman with lilac skin and long pink grass-like hair takes notice of you, taking on a calm if not disinterested expression, as though you are little more than a curiosity to her.\n\n");
			outputText("\"<i>What do we have here…</i>\"\n\n");
			outputText("She looks down and examines you with her beautiful red eyes.\n\n");
			if (player.isRaceCached(Races.PLANT)) outputText("\"<i>Oh, a young sprout came over to visit my gardens. Do you like the setup? There's plenty of stamens and pistils for everyone here. My handmaidens and manservants will see to your every desire, I’m sure. Should you be in need of nourishment, the waters of this pond are full of them. Also feel free to harvest one of my fruits if needed. As for presentation, I am Rafflesia, daughter of Marae.</i>\"\n\n");
			else if (player.isRaceCached(Races.ALRAUNE)) {
				outputText("She swiftly changes from uninterested to intrigued as she notices your body is not unlike that of her own.\n\n");
				outputText("\"<i>Well, would you look at that! Welcome to the grove sister. I didn’t know Marae had made new offspring, the seed would normally have taken years to germinate even in these wonderful times. Regardless, I wish you a warm welcome to my garden. Feel free to use any of my handmaidens or manservants as if they were your own. ");
				outputText("The pond is replenished continuously, so drink to satiety. But where are my manners? My name is Rafflesia, daughter of Marae. Would you grace me with your name, little sister?</i>\"\n\n");
				outputText("Well, now it only makes sense Marae would have other kids aside from you and Hollicynthia. You gladly give her your name.\n\n");
			}
			else outputText("\"<i>Oh, a fleshling… I guess I should've gotten used to them by now. I'm afraid the staff is full, but if you are looking for something other than quality time, perhaps an extra job, I could use you. Perhaps in return for my gracious hospitality, you could gather a few items for me, namely Succubi’s Delight. As for the presentation, my name is Rafflesia, daughter of Marae.</i>\"\n\n");
			outputText("Rafflesia chuckles and sighs in relief, her many tentacle vines shivering as they fill the sunbathing green demons with a copious load of corrupt plant sap. She then goes on.\n\n");
			outputText("\"<i>A person like you is most welcome here. We haven’t had any proper visitors since those knights, now permanent residents, and those workers who are enjoying their off-duty times by the pond at the moment.</i>\" She gives a wave at the greenish demons, a few succubi giving her a thumbs up.\n\n");
			outputText("You admit to have stumbled upon this magnificent garden by accident, and that you are highly interested in its facility. What does the establishment offer?\n\n");
			outputText("\"<i>Oh, plenty of things. The currency used here is mainly corrupting reagents such as Succubi’s Delight, Succubi Milk, and Incubi Draft to be dumped here in the pond. We, in exchange, offer various services which mainly include health care, libido training, food, drinks, and, of course, sexual release. You wouldn’t believe the number of tense, ");
			outputText("frustrated demons who come here because they couldn't get a decent fuck in months, not to mention those who have been punished for their failures as test subjects, what with new body parts to become acquainted with. With the number of pure beings dwindling, they come here so they can enjoy themselves once more. ");
			outputText("Should you require any of these services, just deal with my majordomo Mr. Aster. We can also accept gems for a VIP pass, though the cost is 500 gems. Aster please escort "+player.mf("him","her")+" back to the entrance… you can offer a trial run if "+player.mf("he","she")+" feels ready to try us out.</i>\"\n\n");
			outputText("The satyr escorts you to the entrance.\n\n");
			outputText("\"<i>So, would you like a trial run?</i>\"\n\n");
			flags[kFLAGS.DISCOVERED_TWILIGHT_GROVE_DUNGEON]++;
			menu();
			addButton(1, "Enjoy some rest", corruptTGEnjoySomeRest);
			addButton(3, "Leave", exitDungeon);
		}
		private function room1TGCorruptEnter2():void {
			clearOutput();
			outputText("As you enter the twilight grove the atmosphere suddenly changes as if the forest itself became keenly aware of your presence. While you ponder the sudden shift of ambiance you hear Rafflesia's voice echo through the green canopy.\n\n");
			outputText("\"<i>Visitor I sense the mark of Marae from you, whoever you are. Come closer to my pitcher so we may discuss.</i>\"\n\n");
			outputText("It looks like you somehow got the attention of the mistress of the grove? Perhaps this has to do with your newfound familial bond with Marae. You remember that Rafflesia is related to Marae and thus in theory your sister. Seeing as the place still radiates a welcoming feeling you guess Rafflesia does not see you as a threat. As you move closer Rafflesia flowers blossom to welcome you properly.\n\n");
			outputText("\"<i>Well, would you look at that! I thought I had seen everything but mom somehow made you one of her blessed offspring? Birthing a new sister is one thing but making a fleshling into one? She must’ve seen something quite amazing in you to grant you such a privilege. Regardless, I twice welcome you to the grove little sister. Please take your time and enjoy your stay. As an addition to the normal services feel free to use any of my handmaidens or manservants as if they were your own. ");
			outputText("The pond is replenished continuously, so drink to satiety. It has been so long since last I had a talk with a sibling of mine. Perhaps you may even have some news for me. Calling you sister [name] is gonna take some getting used to.</i>\"\n\n");
			flags[kFLAGS.PC_CANT_DECIDE_ON_BEEN_ALRAUNE_OR_NOT] = 1;
			menu();
			addButton(1, "Have a rest", corruptTGHaveARest2);
			addButton(2, "Rafflesia", corruptTGRafflesia).hint("Discuss various topics with your elder sister.");
			addButton(3, "Leave", room1TGCorruptLeave);
		}
		private function corruptTGEnjoySomeRest():void {
			clearOutput();
			outputText("Aster nods then helps you into the Grove.");
			corruptTGHaveARest2();
		}
		private function corruptTGHaveARestPay():void {
			clearOutput();
			outputText("Aster nods ");
			if (flags[kFLAGS.DISCOVERED_TWILIGHT_GROVE_DUNGEON] == 2 && !playerIsAlraune()) {
				if (player.hasItem(consumables.SUCMILK, 1)) player.destroyItems(consumables.SUCMILK, 1);
				else if (player.hasItem(consumables.INCUBID, 1)) player.destroyItems(consumables.INCUBID, 1);
				else player.destroyItems(consumables.SDELITE, 1);
				outputText("and takes the payment ");
			}
			outputText("then helps you into the Grove.");
			corruptTGHaveARest2();
		}
		private function corruptTGHaveARest2():void {
			outputText("\"<i>Please take a spot next to the pond and enjoy yourself."+(playerIsAlraune()?" We have a large selection of cocks and pussy to select from feel free to use whichever you like.":"")+"</i>\"\n\n");
			if (playerIsAlraune()) {
				outputText("Your elder sister is most generous, offering free access to all of these willing stamens and pistils, you gleefully set down near the pond, browsing the selection.");
				if (player.lowerBody == LowerBody.FLOWER_LILIRAUNE) {
					outputText(" Your twin sister took the initiative first and is already enjoying herself from the stud of a green incubus sharing her delightful sensations to you.\n\n");
					outputText("\"<i>Hurry sister and make a choice. There's at least half of my body which isn’t being pleasured and that's one half too many.</i>\"\n\n");
					outputText("\"<i>Just let me pick a fine cunt to fill already sis! I can take my time choosing!</i>\"\n\n");
				}
				outputText("\n\nYou pick a ‘decent’ succubus for yourself and take your time to enjoy the feeling of your stamen toying with her juicy welcoming hole. The whore is clearly trained to enjoy it and moans, allowing you full use of her body as her devilish cunt massages your vines for its pollen.\n\n");
			}
			else {
				outputText("You lay down on one of the many beach towels next to the pond and put on the offered sunglasses. It doesn't take long for the vines to take notice of you and ");
				if (player.gender == 1) outputText("plug your throbbing cock");
				if (player.gender == 2) outputText("seek out your needy pussy");
				if (player.gender == 3) outputText("plug both your pussy and cock");
				outputText(".\n\n");
			}
			outputText("You sigh and relax enjoying the slow gentle pleasuring of your genitals as a satyr with a servant’s outfit comes over.\n\n");
			outputText("\"<i>May I offer you some food and drink " + player.mf("sir", "milady") + "? We have a local specialty drink called Sangria.</i>\"\n\n");
			menu();
			addButton(1, "Fruits", corruptTGHaveARestFruits);
			addButton(2, "Sangria", corruptTGHaveARestSangria);
			addButtonIfTrue(3, "Fertilizer", corruptTGHaveARestFertilizer, "Req. to be plant-morph or alraune/liliraune.", (player.isRaceCached(Races.ALRAUNE) || player.isRaceCached(Races.PLANT)));
		}
		private function corruptTGHaveARestFruits():void {
			inDungeon = false;
			clearOutput();
			outputText("Those fruits look juicy, so you request a plate. You slowly eat black cherries and purple plums as "+(playerIsAlraune()?"you work a green succubus slit over with your stamens":"the vines work you up")+". You never would’ve thought that eating while fucking would feel so good. The fruits also seem to have an effect on your body, granting you a greater clarity of spirit as well as leaving your mind wandering about the numerous sexy things you’ve yet to try out. ");
			outputText("The simple act of slowly eating these delicious fruits, their juices running over your tongue and their soft flesh yielding to you makes you shudder in pleasure as if your mouth was an actual vagina. This is enough to drive you over the edge as you climax from "+(playerIsAlraune()?"your":"the")+" vines ministration, some of your fluids flowing down into the pond.\n\n");
			outputText("Done enjoying yourself, you head back to camp thanking the Satyr for the quality time.\n\n");
			endEncounter();
		}
		private function corruptTGHaveARestSangria():void {
			clearOutput();
			outputText("You need a drink and tell the Satyr as such. He comes back with a pitcher of what seems to be a strong alcoholic beverage.\n\n");
			outputText("\"<i>This Sangria is made out of the most intoxicating fruits and the pond’s sacred water, please savor it slowly.</i>\"\n\n");
			outputText("The Satyr didn’t lie, you barely took a sip of this thing and you're already tipsy. Furthermore, despite the refreshing nature of the drink, you feel increasingly hot after each sip. You can’t help basking in a dreamy state as the "+(playerIsAlraune()?"sensation of your ":"")+"vines work you over. You cum once, twice… you lost count. You could easily let yourself drift off into a delicious unconsciousness from this, and the vines "+(playerIsAlraune()?"of your elder sister ":"")+"are starting to move around you.\n\n");
			outputText("Do you leave yourself to the care of the vines?\n\n");
			menu();
			addButtonIfTrue(1, "Yes", corruptTGHaveARestSangriaYes, "Your current body state prevents been transformed.", !player.blockingBodyTransformations());
			addButton(3, "No", corruptTGHaveARestSangriaNo);
		}
		private function corruptTGHaveARestSangriaYes():void {
			inDungeon = false;
			clearOutput();
			outputText("You let yourself drift off in the delicious embrace of the vine-like tentacles which proceed to form a slithering blanket around you. Losing all notion of time, you wake several hours later still getting played with by the vines. ");
			outputText(""+(playerIsAlraune()?"You idly ponder what would have happened to you had you not already been a plant":"Something in you changed, as if the sap of the alraune began modifying your body, not unlike the demons on the beach. You feel plant-like strength moving through you")+".\n\n");
			if (!playerIsAlraune()) {
				var changes:Number = 0;
				var changeLimit:Number = 4;
				if (!player.hasPlainSkinOnly() && !player.isGargoyle() && changes < changeLimit && rand(4) == 0 && player.faceType == Face.HUMAN) {
					outputText("\n\n");
					CoC.instance.transformations.SkinPlain.applyEffect();
					changes++;
				}
				if (player.hasPlainSkinOnly() && !InCollection(player.skinColor, "leaf green", "lime green", "turquoise", "light green") && changes < changeLimit && rand(2) == 0) {
					player.skinColor = randomChoice("turquoise", "lime green", "leaf green", "light green");
					changes++;
					outputText("\n\nWhoah, that was weird.  You just hallucinated that your skin turned " + player.skinColor + ".  No way!  It's staying, it really changed color!");
				}
				if (player.skin.hasPlainSkinOnly() && (player.skinColor == "leaf green" || player.skinColor == "lime green" || player.skinColor == "turquoise" || player.skinColor == "light green") && changes < changeLimit && rand(3) == 0) {
					//Males/genderless get clawed feet
					if (player.gender <= 1 || (player.gender == 3 && player.mf("m", "f") == "m")) {
						if (player.lowerBody != LowerBody.PLANT_ROOT_CLAWS) {
							outputText("\n\n");
							CoC.instance.transformations.LowerBodyPlantRootClaws.applyEffect();
						}
					}
					//Females/futa get high heels
					else {
						if (player.lowerBody != LowerBody.PLANT_HIGH_HEELS && player.lowerBody != LowerBody.PLANT_FLOWER) {
							outputText("\n\n");
							CoC.instance.transformations.LowerBodyPlantHighHeels.applyEffect();
						}
					}
					changes++;
				}
				if ((player.lowerBody == LowerBody.PLANT_HIGH_HEELS || player.lowerBody == LowerBody.PLANT_ROOT_CLAWS) && !InCollection(player.arms.type, Arms.GARGOYLE, Arms.PLANT) && changes < changeLimit && rand(3) == 0) {
					outputText("\n\n");
					CoC.instance.transformations.ArmsPlant.applyEffect();
					changes++;
				}
				if (player.arms.type == Arms.PLANT && player.wings.type != Wings.PLANT && player.lowerBody != LowerBody.PLANT_FLOWER && changes < changeLimit && rand(3) == 0) {
					CoC.instance.transformations.WingsPlant.applyEffect();
					changes++;
				}
				if (player.ears.type != Ears.ELFIN && !player.isGargoyle() && changes < changeLimit && rand(3) == 0) {
					outputText("\n\n");
					CoC.instance.transformations.EarsElfin.applyEffect();
					changes++;
				}
				if (CoC.instance.transformations.EyesPlantColors.isPossible() && changes < changeLimit && rand(4) == 0) {
					CoC.instance.transformations.EyesPlantColors.applyEffect(false);
					outputText("\n\nYou blink and stumble, a wave of vertigo threatening to pull your [feet] from under you.  As you steady yourself and open your eyes, you realize something seems different, as if the nerves have been optimized.  Your vision has been changed somehow absorbing more light then normal. When you go look into a water puddle you notice your the changes in full. <b>Your eyes color has changed to [eyecolor].</b>");
					changes++;
				}
				if (player.faceType != Face.HUMAN && changes < changeLimit && rand(4) == 0) {
					changes++;
					outputText("\n\n");
					CoC.instance.transformations.FaceHuman.applyEffect(false);
					outputText("\n\nAnother violent sneeze escapes you.  It hurt!  You feel your nose and discover your face has changed back into a more normal look. <b>You have a human looking face again!</b>");
				}
				if (player.hairColor == "green" && (player.hairType != Hair.LEAF && player.hairType != Hair.GRASS) && !player.isGargoyle() && rand(3) == 0 && changes < changeLimit)
				{
					if (rand(2) == 0) {
						outputText("\n\n");
						CoC.instance.transformations.HairGrass.applyEffect(false);
					}
					else {
						outputText("\n\n");
						CoC.instance.transformations.HairLeaf.applyEffect(false);
					}
					changes++;
				}
				if (player.hairColor != "green" && !player.isGargoyle() && rand(3) == 0 && changes < changeLimit)
				{
					outputText("\n\nAt first it looks like nothing changed but then you realize all the hair on your body has shifted to a verdant green color.  <b>You now have green hair.</b>");
					player.hairColor = "green";
				}
				if ((player.hairType == Hair.LEAF || player.hairType == Hair.GRASS) && changes < changeLimit && rand(2) == 0) {
					//Males/genderless get oak horns
					if (player.gender <= 1 || (player.gender == 3 && player.mf("m", "f") == "m")) {
						outputText("\n\n");
						CoC.instance.transformations.HornsOak.applyEffect();
					}
					//Females/futa get orchid flowers
					else {
						outputText("\n\n");
						CoC.instance.transformations.HornsOrchid.applyEffect();
					}
					changes++;
				}
			}
			endEncounter();
		}
		private function corruptTGHaveARestSangriaNo():void {
			inDungeon = false;
			clearOutput();
			outputText("You proceed to dress back up highly satisfied. Done enjoying yourself you head back to camp thanking the Satyr for the quality time.\n\n");
			player.dynStats("lib", 10, "cor", 5);
			endEncounter();
		}
		private function corruptTGHaveARestFertilizer():void {
			inDungeon = false;
			clearOutput();
			outputText("You could use some nice fertilizer and tell the satyr as such. The goat man bows then comes back with a decanter. Living as a plant sure has its advantages. For one, the only food you need is some fresh water and a good amount of sun. Food isn’t an issue for you, but you sure would die for any intake of some good ol’ fashioned fertilizer. You moan in pleasure as the satyr pours the sweet syrupy liquid at your feet, the nutrients making you swoon in delight. ");
			outputText("You enjoy the taste through your roots as your body metabolizes the nutrients into verdant growth, gaining a few extra inches. This sensation mixed with the non-stop pleasure the vines are offering you is enough to drive you over the edge as you climax from the tentacle ministrations, your fluids flowing down into the pond.\n\n");
			outputText("Done enjoying yourself you head back to camp thanking the Satyr for the quality time.\n\n");
			dynStats("str", 2);
			dynStats("tou", 2);
			dynStats("spe", 2);
			dynStats("inte", 2);
			dynStats("wis", 2);
			dynStats("lib", 2);
			dynStats("sens", 2);
			dynStats("cor", 2);
			player.trainStat("str",2,player.trainStatCap("str",100));
			player.trainStat("tou",2,player.trainStatCap("tou",100));
			player.trainStat("spe",2,player.trainStatCap("spe",100));
			player.trainStat("int",2,player.trainStatCap("int",100));
			player.trainStat("wis",2,player.trainStatCap("wis",100));
			player.trainStat("lib",2,player.trainStatCap("lib",100));
			if (player.basetallness < 132) {
				player.tallness += 1 + rand(3);
				if (player.basetallness > 132) player.tallness = 132;
			}
			endEncounter();
		}
		private function corruptTGHaveARestVIPBuyItBuyItNowBeforeItPriceRise():void {
			clearOutput();
			outputText("You pay Aster 500 gems in order to aquire a VIP pass and the satyr gladly oblige you will now be able to use the grove for free at all time!\n\n");
			player.gems -= 500;
			flags[kFLAGS.DISCOVERED_TWILIGHT_GROVE_DUNGEON] = 3;
			menu();
			addButton(1, "Have a rest", corruptTGEnjoySomeRest);
			addButton(3, "Leave", room1TGCorruptLeave);
		}
		private function corruptTGRafflesia():void {
			clearOutput();
			outputText("You approach Rafflesia intent on having a friendly chat with your verdant sibling. Amazingly despite constantly fucking a dozen demons all at the same time your sister is keeping a calm face. You guess that is the kind of power that comes with years. Even sex and mind blowing pleasure can’t shake away the serene look on your sister's face. She takes the whole thing as if it was as natural as breathing air, basking in the sun or drinking water.\n\n");
			outputText("\"<i>Oh [name], I was resting and didn't notice you coming close. Running this place can be so tiresome I don’t look like it but my vines are managing a hundred or so activities all at the same time. Is there anything I can do for you or perhaps you simply wanted to chat?</i>\"\n\n");
			menu();
			addButtonIfTrue(1, "Children", corruptTGRafflesiaChildren, "Only for pregnant PC.", player.isPregnant());
			addButton(2, "The Grove", corruptTGRafflesiaTheGrove);
			addButton(8, "Back", room1TGCorrupt);
		}
		private function corruptTGRafflesiaChildren():void {
			clearOutput();
			outputText("You gently ask your big sister what she thinks of children as you slowly bask in the motherly delight of your full pitcher.\n\n");
			outputText("\"<i>Oh, sister, there are few things I love more than having children. However, upon my so-called fall from grace mother cursed me with complete infertility.</i>\"\n\n");
			outputText("You gasp in horror; what a terrible punishment. To be unable to bear fruit is something as an Alraune you have a keen fear of.\n\n");
			outputText("\"<i>Oh don’t worry dear I found a way around it. While I can no longer produce seeds or bear fruits on my own, my womb is so corrupted I can use it to remodel what I absorb into my progeny, body and mind. I thoroughly enjoy every one of these pregnancies as the individuals I rebirth are always those I love the most. They all start rowdy and rebellious, fighting to get free, but become such sweet children afterward.</i>\"\n\n");
			outputText("Reassured of your sister’s health, you ask when last she had a child.\n\n");
			outputText("\"<i>Oh, that was a fair year since. As I said: while rare, I treasure these pregnancies even more. Most of my children stay with me to attend the grove.</i>\"\n\n");
			outputText("You both close the subject, having nothing more to say about it.\n\n");
			doNext(corruptTGRafflesia);
			advanceMinutes(10);
		}
		private function corruptTGRafflesiaTheGrove():void {
			clearOutput();
			outputText("So how did this lovely grove come to be, when did she decide to settle here in the first place?\n\n");
			outputText("\"<i>Oh it was mother who made me grow here to begin with. I was here way before the demons came tending this sacred grove, growing beautiful flowers and providing counsel to mortals who came to visit. When the demons came from the mountains, they came to me and taught me many joys. I was always very sexual as all of my siblings are but what the demon taught me made it so much better. I soaked in the corruption until my soul poured out and gleefully devoured the crystal. ");
			outputText("You cannot fathom the pleasure of tasting the soul of a demigod or the power I got from it, it was like meeting a new me. I tried to share my joy with mother, but she cut off all contact, saying I was not her daughter anymore but a ‘thing’. I still hope she will one day come to her senses and expand her roots back all the way to this place.</i>\"\n\n");
			if (player.cor >= 51) {
				if (flags[kFLAGS.FACTORY_SHUTDOWN] == 1) {
					outputText("You feel terribly sorry for your big sister but indeed maybe there is a way you could bring mother on this side of the curtain, the factory isn’t destroyed and all it takes is to reactivate it and perhaps even break the valve. There is enough corrupted fluid stuck in those tanks to completely flood the lake.\n\n");
					doNext(corruptTGRafflesia);
					advanceMinutes(10);
				}
				else {
					outputText("You chuckle and tell your sister the good news, Marae has already fallen to corruption thanks to your scheme at the factory. Rafflesia begins shedding tears of happiness.\n\n");
					outputText("\"<i>Sister, if you knew how much joy this brings to me to know that mother will forgive me. We will once again be a united family. I will even be able to show my lovely offsprings to mother. Say, I have been thinking, you are the only one left of us who still has a soul. Are you really ok with that? I could fuck it out for you if you asked.</i>\"\n\n");
					outputText("Yea you will be keeping your soul for now. There is absolutely no rush to lose it.\n\n");
					outputText("\"<i>Well, that is your loss. Regardless, I want to thank you for uniting us all again. I prepared this flower for you just in case you did wish to get a taste of what it is like to have real power. Use it when you are ready.</i>\"\n\n");
					outputText("Rafflesia produces a small black flower and hands it to you.\n\n");
					inventory.takeItem(consumables.BLACK_L, corruptTGRafflesia);
					advanceMinutes(10);
				}
			}
			else {
				outputText("While corrupt and perhaps even lost this woman is still your elder sister. You cannot and will not revert Marae’s decision but you might look into a way of redeeming your wayward sister anyway. You tell her that regardless of her path in life so far it's not too late for her to redeem herself. Your fallen sister chuckles at this suggestion.\n\n");
				outputText("\"<i>Redeem myself? That’s absurd. I know you seek my wellbeing but I’m not yet ready to lose all I acquired since my downfall. Truthfully, I think it is you "+(flags[kFLAGS.FACTORY_SHUTDOWN] == 1?"and mother ":"")+"who should join me on this side of the curtain. If you ever consider joining the good side, sister, then just ask me. I can produce you a petal that will allow you to partake in some of my powers. You "+(flags[kFLAGS.FACTORY_SHUTDOWN] == 1?"and mom both ":"")+"got this whole situation wrong, this power shouldn’t be kept under lock and key. We should all embrace it and devote ourselves to parenting a myriad of cute offspring</i>\"\n\n");
				outputText("You have no interest in defiling your body with demonic taint but regardless you give your sister a polite nod, acknowledging your common interest in birthing many childrens.\n\n");
				doNext(corruptTGRafflesia);
				advanceMinutes(10);
			}
		}
		private function playerIsAlraune():Boolean {
			if (player.isRaceCached(Races.ALRAUNE)) return true;
			else return false;
		}
		
		public function room1TG():void {
			dungeonLoc = DUNGEON_TWILIGHT_GROVE_1;
			clearOutput();
			outputText("<b><u></u>Entrance</b>\n");
			outputText("You stand at the entrance. The formerly sealed shut vegetal gate is breached and allows you to enter and leave at your leisure.");
			//dungeons.setDungeonButtons(room2Center, null, null, null);
			addButton(11, "Leave", exitDungeon);
			//outputText("\n\n");
			//outputText("\"<i></i>\"\n\n");
			//outputText("\"<i></i>\"\n\n");
			//		outputText("\n\n");
			//		outputText("\"<i></i>\"\n\n");
			//		outputText("\"<i></i>\"\n\n");
		}
		
	}

}