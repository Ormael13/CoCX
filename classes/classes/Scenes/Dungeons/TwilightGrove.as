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
import classes.Scenes.Areas.Forest.TentacleBeast;
import classes.Scenes.Areas.Plains.Satyr;
import classes.Scenes.Areas.Swamp.CorruptedDrider;
import classes.Scenes.Dungeons.TwilightGrove.*;
import classes.StatusEffects;
import classes.Races;
import classes.CoC;

	public class TwilightGrove extends DungeonAbstractContent
	{
		
		public function TwilightGrove() 
		{}
		
		public function enterDungeon():void {
			inDungeon = true;
			if ((player.cor >= 51 || player.isRaceCached(Races.ALRAUNE)) && flags[kFLAGS.TWILIGHT_GROVE_PURIFICATION] < 1) room1TGCorrupt();
			else {
				if (flags[kFLAGS.TWILIGHT_GROVE_PURIFICATION] > 1) room1TG();
				else room1TGPure();
			}
		}
		
		public function exitDungeon():void {
			inDungeon = false;
			clearOutput();
			outputText("You leave the twilight grove behind and take off back towards the camp.");
			endEncounter();
		}
		
		//Corrupt Path
		
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
		
		//Pure path
		
		public function meetTwilightGroveRandomnMob():void {
			if ((rand(100) < player.statusEffectv1(StatusEffects.TGRandomnMob)) && !player.hasStatusEffect(StatusEffects.ThereCouldBeOnlyOne)) {
				var reset:Number = 20;
				reset -= player.statusEffectv1(StatusEffects.TGRandomnMob);
				player.addStatusValue(StatusEffects.TGRandomnMob, 1, reset);
				player.createStatusEffect(StatusEffects.ThereCouldBeOnlyOne, 0, 0, 0, 0);
				var choice:Number = rand(3);
				if (choice == 0) {
					outputText("\n\nTentacle Beast suddenly appears from nearby passage and attacks!");
					startCombat(new TentacleBeast(), true);
				}
				if (choice == 1) {
					outputText("\n\nSatyr suddenly appears from nearby passage and attacks!");
					startCombat(new Satyr(), true);
				}
				if (choice == 2) {
					outputText("\n\nCorrupted Drider suddenly appears from nearby passage and attacks!");
					startCombat(new CorruptedDrider(), true);
				}
				//doNext(playerMenu);
			}
			else player.addStatusValue(StatusEffects.TGRandomnMob, 1, 20);
		}
		
		private function room1TGPure():void {
			clearOutput();
			dungeonLoc = DUNGEON_TWILIGHT_GROVE_1;
			outputText("As you wander the woods, you stumble on a corrupt glade similar to those you have come across before except at its edge stands a large ornate gate made of entwined brambles. When you approach and touch the brambles out of curiosity, the plant moves on its own, slithering away to block the path from you. Clearly, you are unwelcome. Will you forcefully enter this eerie place or leave?");
			if (flags[kFLAGS.DISCOVERED_TWILIGHT_GROVE_DUNGEON] < 1) flags[kFLAGS.DISCOVERED_TWILIGHT_GROVE_DUNGEON] = 1;
			menu();
			addButton(1, "Force", room1Force);
			addButton(3, "Leave", room1TGPureLeave);
		}
		private function room1TGPureLeave():void {
			inDungeon = false;
			clearOutput();
			outputText("The malice in this area is almost palpable. You should come back when you’re better prepared.");
			endEncounter();
		}
		public function room1Force():void {
			clearOutput();
			outputText("As you try to force your way in, the plant wall comes alive and furiously attacks you, trying to shred you with its thorns!\n\n");
			outputText("<b>You are under attack by a Vampithorn bush!</b>");
			flags[kFLAGS.TWILIGHT_GROVE_PURIFICATION] = 1;
			startCombat(new VampithornBush(), true);
		}
		public function defeatVampithornBush():void {
			clearOutput();
			outputText("You manage to damage the angry plant enough to tear open a hole to slide through harmlessly. Beyond is what looks like an open grove.\n\n");
			player.createStatusEffect(StatusEffects.TGRandomnMob, 20, 0, 0, 0);
			player.createStatusEffect(StatusEffects.TGStorage, 5, 5, 5, 1);
			flags[kFLAGS.TWILIGHT_GROVE_PURIFICATION] = 2;
			cleanupAfterCombat();
		}
		public function defeatedByVampithornBush():void {
			clearOutput();
			outputText("Too weak from blood loss you slowly slide down into unconsciousness. Sadly for you, you will never wake up again for the thirsty plant will suck your blood dry leaving you a lifeless husk on the forest ground. Eventually, your body will decompose into nutrients and the plant will use it as fertilizer for its twisted growth. What a terrible way to go.\n\n");
			//[GAME OVER]
			EventParser.gameOver();
		}
		
		public function room1TG():void {
			dungeonLoc = DUNGEON_TWILIGHT_GROVE_1;
			clearOutput();
			outputText("<b><u>Entrance</u></b>\n");
			outputText("You stand at the entrance. The formerly sealed shut vegetal gate is breached and allows you to enter and leave at your leisure.");
			player.createStatusEffect(StatusEffects.TGRandomnMob, 20, 0, 0, 0);
			dungeons.setDungeonButtons(room2TG, null, null, null);
			addButton(11, "Leave", exitDungeon);
		}
		
		public function room2TG():void {
			dungeonLoc = DUNGEON_TWILIGHT_GROVE_2;
			clearOutput();
			outputText("<b><u>Twilight Grove</u></b>\n");
			meetTwilightGroveRandomnMob();
			if (CoC.instance.inCombat) return;
			outputText("Various corrupted plants cover this eerie part of the forest. You can spot an empty wine amphora which suggests the presence of satyrs.");
			dungeons.setDungeonButtons(room3TG, room1TG, null, null);
		}
		
		public function room3TG():void {
			dungeonLoc = DUNGEON_TWILIGHT_GROVE_3;
			clearOutput();
			outputText("<b><u>Twilight Grove</u></b>\n");
			if (flags[kFLAGS.TWILIGHT_GROVE_PURIFICATION] == 2) {
				outputText("As you enter this part of the grove a dark and somewhat enticing flute begins to play somewhere in your surroundings. You are clearly unwelcome and whoever is playing is filling your body with increasing dread. The plants around you suddenly grow at a massively increased rate until you are stuck in what looks to be a vegetal labyrinth and the worst part is you have no idea how to get out! This ought to be an illusion but it feels all too real, what with your gear having vanished save for your weapon leaving you stark naked. A deep sinister voice echoes around you.\n\n");
				outputText("\"<i>How does it feel, intruder, to be lost in Pan's Labyrinth? I am the hunter… and you are the prey. No one can escape this dimension without my consent.</i>\"\n\n");
				outputText("You turn around, noticing a satyr of oversized proportion standing behind you. His horns are longer than most of his kinsmen, not to mention the large bow he carries. However, his bow is not the thing you are afraid of. In his hand rests a small flute, likely the magical instrument he used earlier. He disappears into the labyrinth with an ominous laugh.\n\n");
				outputText("\"<i>I will take my time driving you insane with years worth of constant terror and rape before presenting you before the mistress as a new fucktoy. Hear my tune and despair!</i>\"\n\n");
				outputText("The music resumes and you feel your arousal rising. His instrument is clearly enchanted with some sort of compulsion magic. You need to prevent him from playing!\n\n");
				startCombat(new ThePansLabyrinthSatyr(), true);
			}
			else outputText("This is the place where you met the satyr musician. The satyr’s body is still on the ground, a testimony of your victory over his mind games.");
			if (CoC.instance.inCombat) return;
			dungeons.setDungeonButtons(room4TG, room2TG, null, null);
		}
		public function defeatThePansLabyrinthSatyr():void {
			clearOutput();
			outputText("You hear the satyr scream in disbelief as your last attack breaks his enchanted instrument. The labyrinth fades as well as any illusion summoned by the infernal flute. The satyr stands before you, mad with rage.\n\n");
			outputText("\"<i>How dare you break my precious flute, I will make you behave!!</i>\"\n\n");
			outputText("He tries to draw his bow, however, you’ve had enough of this trickster and swiftly strike him in retaliation, killing him before he even has a chance to defend himself or enchant you again. Turns out the goat flutist was infinitely easier to defeat without his instrument. With the evil satyr dead you can continue on your exploration of the grove.\n\n");
			flags[kFLAGS.TWILIGHT_GROVE_PURIFICATION] = 3;
			cleanupAfterCombat();
		}
		public function defeatedByThePansLabyrinthSatyr():void {
			clearOutput();
			outputText("It has been years now since you became a part of this otherworldly labyrinth, one lunatic amongst many. Your life has fallen into a cycle of raping and getting raped daily by the many phantasms that populate your broken mind. Unable to discern reality from your delusion anymore, you go so far as to cum even without anything present in the real world to sex you up, your crazed mind alone giving you the delusion of sex. ");
			outputText("When the satyr finally picks you up after all these years and brings you to his mistress, your first reflex is to drool like a panting dog looking for"+(player.gender == 0?" something to get you off":""+(player.hasCock()?" a pussy to fill with your [cock]":"")+(player.gender > 2?" and":"")+(player.hasVagina()?" a cock to fill your [pussy]":"")+"")+". ");
			outputText("A wall of tentacles reaches for you and you happily jump into them to have your body played with as your body is further enhanced with corruptive fluids. Your days as a hero are now long over, and eventually, you become one of the grove’s many guardians, turning into something no better than a beast addicted to pleasure.\n\n");
			//[GAME OVER]
			EventParser.gameOver();
		}
		
		public function room4TG():void {
			dungeonLoc = DUNGEON_TWILIGHT_GROVE_4;
			clearOutput();
			outputText("<b><u>Twilight Grove</u></b>\n");
			meetTwilightGroveRandomnMob();
			if (CoC.instance.inCombat) return;
			outputText("You can spot some demons lazily taking what could be a sunbath if not for the many tentacles fucking them in the distance. There seems to be a storage area full of items on your left.");
			dungeons.setDungeonButtons(room5TG, room3TG, null, null);
			
		}
		
		public function room5TG():void {
			dungeonLoc = DUNGEON_TWILIGHT_GROVE_5;
			clearOutput();
			outputText("<b><u>Twilight Grove</u></b>\n");
			meetTwilightGroveRandomnMob();
			if (CoC.instance.inCombat) return;
			outputText("This is a storage area filled with many boxes full of what looks to be transformatives and less savory items. There also is wine and other alcoholic beverages in here, but you don’t think getting inebriated in the middle of an enemy lair is a bright idea.");
			dungeons.setDungeonButtons(room6TG, room4TG, null, null);
			if (player.statusEffectv1(StatusEffects.TGStorage) > 0) {
				outputText("\n\nThere is an opened box with some item"+(player.statusEffectv1(StatusEffects.TGStorage) == 1 ? "":"s")+" inside.\n\n");
				addButton(0, "Crate 1", takeGroPlus);
			}
			if (player.statusEffectv2(StatusEffects.TGStorage) > 0) {
				outputText("\n\nThere is an opened box with some item"+(player.statusEffectv2(StatusEffects.TGStorage) == 1 ? "":"s")+" inside.\n\n");
				addButton(1, "Crate 2", takeSuccubiMilk);
			}
			if (player.statusEffectv3(StatusEffects.TGStorage) > 0) {
				outputText("\n\nThere is an opened box with some item"+(player.statusEffectv3(StatusEffects.TGStorage) == 1 ? "":"s")+" inside.\n\n");
				addButton(2, "Crate 3", takeIncubiDraft);
			}
			if (player.statusEffectv4(StatusEffects.TGStorage) > 0) {
				outputText("\n\nThere is an opened box with some item inside.\n\n");
				addButton(3, "Crate 4", takeBroBrew);
			}
		}
		private function takeGroPlus():void {
			player.addStatusValue(StatusEffects.TGStorage, 1, -1);
			inventory.takeItem(consumables.GROPLUS, room5TG);
		}
		private function takeSuccubiMilk():void {
			player.addStatusValue(StatusEffects.TGStorage, 2, -1);
			inventory.takeItem(consumables.SUCMILK, room5TG);
		}
		private function takeIncubiDraft():void {
			player.addStatusValue(StatusEffects.TGStorage, 3, -1);
			inventory.takeItem(consumables.INCUBID, room5TG);
		}
		private function takeBroBrew():void {
			player.addStatusValue(StatusEffects.TGStorage, 4, -1);
			inventory.takeItem(consumables.BROBREW, room5TG);
		}
		
		public function room6TG():void {
			dungeonLoc = DUNGEON_TWILIGHT_GROVE_6;
			clearOutput();
			outputText("<b><u>Twilight Grove</u></b>\n");
			if (flags[kFLAGS.TWILIGHT_GROVE_PURIFICATION] == 3) {
				outputText("You walk towards what looks like a corrupted water pond with a small island at the center. On the island rests a black flower of massive size, towering above the entire grove and the sunbathing demons below, though right now you wonder if they are sunbathing or rather enjoying a good fuck from the weird tentacle vines pumping under their beach clothes. Strangely the demons seem to literally not give a single fuck about you standing there. A seductive and somewhat playful voice breaks the silence.\n\n");
				outputText("\"<i>So you came all the way here and defeated all of my retainers, I am impressed by your skill.</i>\"\n\n");
				outputText("The flower blossoms, revealing a dreamily beautiful woman with lavender skin, grass-like pink hair ornamented with real flowers and red eyes that clearly show her heavy corruption.\n\n");
				outputText("\"<i>Since presentations are in order my name is Rafflesia, daughter of the goddess Marae. Wandering adventurer would you grace me with your name.</i>\"\n\n");
				outputText("You proudly tell her your name and that you are a champion here to put an end to this garden of corruption.\n\n");
				outputText("\"<i>Oh, courageous are you? I don’t mind adventurers every now and then, most of them end up eaten by the garden or fucked into becoming new residents, however, you sure made a mess out of my lovely paradise which is why… I desire you even more. You SHALL be mine.</i>\"\n\n");
				outputText(""+(silly() ? "Well that's an obvious yandere flag whatever she has in line for you is going to be a thousand times worse then the classic fate of a harem protagonist. Wait, come to think of it, aren't you an harem protagonist? ":"")+"The plant woman starts laughing sinisterly and you back away ready to flee but all of the grove exits are suddenly shut, the area becoming covered with thick layers of impassable thorny vines blossoming with black orchids.\n\n");
				if (flags[kFLAGS.FACTORY_SHUTDOWN] == 2) outputText("\"<i>I also heard how you helped show my mother Marae the path to carnal delight and endless pleasure. It has been so difficult for me to spread since she severed our ties. However, now that she is assisting me instead of being a nuisance, I can spread my roots and expand my power freely. I will gladly reward your dutiful help with an eternity at my service attending my garden.</i>\"\n\n");
				outputText("A literal army of tentacle vines slowly snake toward you from the laughing plant woman. You will have to defeat her if only to hope escaping this place unchanged.\n\n");
				startCombat(new LadyRafflesia(), true);
			}
			else outputText("Crystal clear water surrounds the small island where Lady Rafflesia used to grow. With its mistress gone, the grove seems to have recovered a semblance of dignity.");
			if (CoC.instance.inCombat) return;
			dungeons.setDungeonButtons(null, room5TG, null, null);
		}
		public function defeatLadyRafflesia():void {
			clearOutput();
			outputText("Rafflesia looks at you defeated and terrified as you prepare to end her.\n\n");
			outputText("\"<i>Nooooo! Please, you don’t have to do this! All I ever wanted was to have children! Thousands of beautiful children that would cover the world with their seeds!</i>\"\n\n");
			outputText("Sadly for her, you have seen enough of her insane pollination plan and decide to finish her off. With Rafflesia dead a semblance of redemption seems to befall this foul place as the waters of the pond slowly begin to filter out the corruption back to what likely was their former crystal clear outlook. As you prepare to leave, you find a stash of 5000 gems, likely the hoard of treasure this death trap amassed from defeated adventurers over the years.\n\n");
			flags[kFLAGS.TWILIGHT_GROVE_PURIFICATION] = 4;
			player.gems += 5000;
			cleanupAfterCombat();
		}
		public function defeatedByLadyRafflesia():void {
			clearOutput();
			outputText("You fall over defeated and look at your opponent, awaiting your end.\n\n");
			outputText("\"<i>Aw... poor thing! You look all messy and hurt now, but don't worry, for I will take good care of you. Just like my mother would have. Now feel the power of my motherly love.</i>\"\n\nYou try to crawl away but her vines swiftly bind your arms, mouth, and legs. You are too weak to struggle as Rafflesia forcefully pulls you toward her pitcher at the center of the pond. ");
			outputText("She lifts her undercarriage revealing what looks like a vagina fit for engulfing things of human size. You plead for mercy and struggle screaming. \"<i>NOOoo!!! Not there!</i>\" But she ignores you and ends your scream by shoving you inch by inch into her massive green hole until nothing is left of you. You eventually lose consciousness briefly from exhaustion.\n\nYou wake up in a fetal position resting in what seems to be a small alcove. You can breathe somehow thanks to air flowing in and out of your prison and a sweet relaxing scent fills the room. ");
			outputText("There isn't much space to move however and so you are stuck in this position which isn’t altogether uncomfortable. Truth be told you feel warm and at ease. Some kind of weird tubular tentacle is gently feeding you a sweet delicious syrup you mindlessly lap on. Your memories are fuzzy...Why are you here? How did you end up here? As you try to figure out the answer to these questions a girl’s voice you can’t recognize echoes through the walls of your fleshy prison.\n\n");
			outputText("\"<i>My womb feels comfortable, doesn’t it? Just let go of any worries you might have and go to sleep my dear [name].</i>\"\n\nYou indeed are tired, so tired. You barely register as a "+(player.gender == 3 ? "pair of":"second")+" ");
			outputText("tendril"+(player.gender == 3 ? "s":"")+" slither"+(player.gender == 3 ? "s":"")+" out of the space under you and gently slither to your privates. "+(player.hasCock()?"Warm welcoming flesh gently wraps around your hardened [cock] suckling and caressing your skin delightfully. ":"")+(player.hasVagina()?"One of the tendrils, like a kind parent, slowly parts your legs and enters your pussy folds, making you gasp in pleasure as warm sap slowly floods the insides of your cunt, probably going all the way to your ovaries. ":"")+"");
			outputText("Your "+(player.hasCock()?"[cock] tingles as it slowly spurts cum, shrinking in size and even retracting inside your body until none of it is left, leaving only a hole that is now your pussy":"")+(player.gender == 3 ? "[cock] tingles as it slowly spurts cum, shrinking in size and even retracting inside your body and into your pussy until none of it is left, it even goes so far as to merge with your clitoris giving you a short orgasm":"")+".  Your pussy suddenly begins to change "+(player.gender == 2 ? "":"as well ")+"your clitoris increasing in length as ");
			outputText("if feeding on the fluid your pleased vagina is constantly filled with. It keeps lengthening to a ridiculous size and you can even see it a fair meter long, squirming inside the tendril like a possessed snake as your pussy keeps gushing fluids again and again. Eventually, the confined space is so flooded, you worry you will be unable to breathe but the feeder tubes somehow keeps you well nourished with oxygen. You close your eyes happily dozing off to the sound of your gushing pussy.\n\n");
			outputText("You wake up as you are forcefully expelled from your alcove by some unseen forces. You see light ahead of you and forge on, eventually reaching the exit and sliding out with a huge sploosh of greenish fluids. You take a breath for the first time in several days, taking the time to look around you, admiring your lilac arms covered with sensible vines and your lovely E cup breast as you caress the orchid in your vegetal hair. ");
			outputText("You made a small mess on the grass, but you don’t care as your gaze focuses on the object of your adoration. Your mother, Lady Rafflesia is giving you a warm smile as you continue exploring the confines of your vegetal body. Your clit changes again and you giggle as a stamen mounted vine surges out of your juicy pussy coiling around your left leg like a snake. Your mother praises you.\n\n");
			outputText("\"<i>You are so beautiful, my sweet daughter, mother is really happy for you. How about you put this stamen to good use and sow seeds across the grove for me.</i>\"\n\n");
			outputText("It is your greatest pride to say \"<i>Yes mother.</i>\" as you move on to the first stamen or pistil you can find, mating again and again so as to grant your beloved mother the granddaughters she so deserves. After a few months, the grove is fully repaired and the resort is running better than ever. As your mom’s favored daughter, it is your greatest pride to receive visitors or fuck their brains silly to the garden.\n\n");
			outputText("Several months later a human woman pretending to be a champion makes it to the garden and you gleefully defeat her for your mother. Once you’ve suitably broken her you resolve to use her as your favorite seedbed. Like mother like daughter.\n\n");
			//[GAME OVER]
			EventParser.gameOver();
		}
	}
}