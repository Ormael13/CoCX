/**
 * Side Dungeon: Twilight Grove (Corrupted Alraune grove)
 * @author Liadri
 */
package classes.Scenes.Dungeons 
{
import classes.EventParser;
import classes.BodyParts.LowerBody;
import classes.GlobalFlags.kFLAGS;
import classes.Races;

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
			doNext(camp.returnToCampUseOneHour);
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
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function room1TGCorrupt():void {
			clearOutput();
			dungeonLoc = DUNGEON_TWILIGHT_GROVE_1;
			if (flags[kFLAGS.DISCOVERED_TWILIGHT_GROVE_DUNGEON] > 1) {
				menu();
				//2 - dryad boss npc
				addButton(3, "Leave", room1TGCorruptLeave);
				if (playerIsAlraune()) {
					outputText("Aster the satyr is quietly waiting at his desk at the entrance for potential customers. Since you are the sister of the owner you can enjoy the place for free.\n\n");
					addButton(1, "Have a rest", corruptTGHaveARest);
				}
				else {
					outputText("Aster the satyr is quietly waiting at his desk at the entrance for potential customers. If you have corrupted items you could buy yourself some well needed-relaxation.\n\n");
					if (flags[kFLAGS.DISCOVERED_TWILIGHT_GROVE_DUNGEON] > 2) addButton(1, "Have a rest", corruptTGHaveARest);
					else {
						addButtonIfTrue(1, "Have a rest", corruptTGHaveARest, "You would like to use the resort but don’t have any corrupted items to pay for it.", (player.hasItem(consumables.SUCMILK, 1) || player.hasItem(consumables.INCUBID, 1) || player.hasItem(consumables.SDELITE, 1)));
						if (flags[kFLAGS.DISCOVERED_TWILIGHT_GROVE_DUNGEON] == 2) addButtonIfTrue(7, "VIP", corruptTGHaveARestVIPBuyItBuyItNowBeforeItPriceRise, "Req. 500+ gems", player.gems >= 500);
					}
				}
				outputText("\"<i></i>\"\n\n");
				outputText("\n\n");
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
			doNext(camp.returnToCampUseOneHour);
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
			addButton(1, "Enjoy some rest", corruptTGHaveARest);
			addButton(3, "Leave", exitDungeon);
		}
		private function corruptTGHaveARest():void {
			clearOutput();
			outputText("Aster nods ");
			if (flags[kFLAGS.DISCOVERED_TWILIGHT_GROVE_DUNGEON] == 2 && !playerIsAlraune()) {
				if (player.hasItem(consumables.SUCMILK, 1)) player.destroyItems(consumables.SUCMILK, 1);
				else if (player.hasItem(consumables.INCUBID, 1)) player.destroyItems(consumables.INCUBID, 1);
				else player.destroyItems(consumables.SDELITE, 1);
				outputText("and takes the payment ");
			}
			outputText("then helps you into the Grove.");
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
			//2 - Sangria
			addButtonIfTrue(3, "Fertilizer", corruptTGHaveARestFertilizer, "Req. to be plant-morph or alraune/liliraune.", (player.isRaceCached(Races.ALRAUNE) || player.isRaceCached(Races.PLANT)));
		}
		private function corruptTGHaveARestFruits():void {
			inDungeon = false;
			clearOutput();
			outputText("Those fruits look juicy, so you request a plate. You slowly eat black cherries and purple plums as "+(playerIsAlraune()?"you work a green succubus slit over with your stamens":"the vines work you up")+". You never would’ve thought that eating while fucking would feel so good. The fruits also seem to have an effect on your body, granting you a greater clarity of spirit as well as leaving your mind wandering about the numerous sexy things you’ve yet to try out. ");
			outputText("The simple act of slowly eating these delicious fruits, their juices running over your tongue and their soft flesh yielding to you makes you shudder in pleasure as if your mouth was an actual vagina. This is enough to drive you over the edge as you climax from "+(playerIsAlraune()?"your":"the")+" vines ministration, some of your fluids flowing down into the pond.\n\n");
			outputText("Done enjoying yourself, you head back to camp thanking the Satyr for the quality time.\n\n");
			doNext(camp.returnToCampUseOneHour);
		}
		private function corruptTGHaveARestSangria():void {
			inDungeon = false;
			clearOutput();
			outputText("\n\n");
			outputText("\"<i></i>\"\n\n");
			outputText("\n\n");
			doNext(camp.returnToCampUseOneHour);
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
			doNext(camp.returnToCampUseOneHour);
		}
		private function corruptTGHaveARestVIPBuyItBuyItNowBeforeItPriceRise():void {
			clearOutput();
			outputText("You pay Aster 500 gems in order to aquire a VIP pass and the satyr gladly oblige you will now be able to use the grove for free at all time!\n\n");
			player.gems -= 500;
			menu();
			addButton(1, "Have a rest", corruptTGHaveARest);
			//2 - dryad boss npc
			addButton(3, "Leave", room1TGCorruptLeave);
		}
		private function playerIsAlraune():Boolean {
			if (player.isRaceCached(Races.ALRAUNE)) return true;
			else return false;
		}
		
		public function room1TG():void {
			dungeonLoc = DUNGEON_TWILIGHT_GROVE_1;
			clearOutput();
			outputText("<b><u></u>Entrance</b>\n");
			if (flags[kFLAGS.TIFA_FOLLOWER] > 5) {
				outputText("The guards let you pass into the Hive reminding you not to stir troubles.\n\n");
				outputText("\"<i>You are welcome into the Hive azzz by the queen'zzz orderzzz zzzo long azzz you don’t go further than the honeybrewerzzz hallzzz</i>\"");
			}
			else if (flags[kFLAGS.DISCOVERED_BEE_HIVE_DUNGEON] > 2.5) outputText("No one's there to block your path to the Hive, it seems you can proceed.");
			else outputText("The two guards fall to the ground, "+(flags[kFLAGS.DISCOVERED_BEE_HIVE_DUNGEON] == 2.5 ? "too busy masturbating":"their wounds too great")+" to keep up on fighting. You get past them and enter the Hive.");
			//dungeons.setDungeonButtons(room2Center, null, null, null);
			addButton(11, "Leave", exitDungeon);
		}
		
	}

}