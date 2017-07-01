/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.HighMountains 
{
	import classes.*;
//	import classes.Player;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	
	use namespace kGAMECLASS;
	
	public class TempleOfTheDivine extends BaseContent
	{
//		var race:String = "human";
//		race = player.race();
		
		public function TempleOfTheDivine() 
		{}
		
		public function sapphireAffection(changes:Number = 0):Number
		{
			flags[kFLAGS.SAPPHIRE_AFFECTION] += changes;
		//	if (flags[kFLAGS.SAPPHIRE_AFFECTION] > 100) flags[kFLAGS.SAPPHIRE_AFFECTION] = 100;
			if (flags[kFLAGS.SAPPHIRE_AFFECTION] > 6) flags[kFLAGS.SAPPHIRE_AFFECTION] = 6;
			return flags[kFLAGS.SAPPHIRE_AFFECTION];
		}
		
		public function firstvisitintro():void {
			flags[kFLAGS.FOUND_TEMPLE_OF_THE_DIVINE] = 1;
			flags[kFLAGS.SAPPHIRE_TALKS] = 0;
			clearOutput();
			outputText("As you wander the mountains, you eventually climb to the very top, something you never expected to do. Weirdly enough, sitting on a nearby peak is what appears to be a massive temple. You approach the intimidating doors of the building and open them wide. Instantly you’re taken aback by the sight in front of you. ");
			outputText("There are ancient bloodstains marking the stone floor and stained glass windows depicting various deities adorn each wall. At the end of the building, that obviously once was a holy site, sits one depicting Marae. Under each window is a somewhat damaged altar, the light outside shining faintly upon it.");
			outputText("\n\nAs you walk towards Marae’s Altar, a threatening voice echoes through the temple. \"<i>No one will defile this sacred place! I will slay you before you can cause any further damage!</i>\"");
			outputText("\n\nYou realize that you were never alone in the room, as a large and heavy object hits you from behind, sending you sprawling to the ground. As you try to stand up, something grabs you by the leg, lifting you upside down in the air with apparent ease. While uncomfortable, and most definitely a shock, this gives you enough time to take a good look at what, or more specifically who, grabbed you. ");
			outputText("It seems to be a 7 foot tall, stone-skinned gargoyle. She carries a huge halberd and appears to be about to impale you on it. Although you wriggle, you find no weakness in her grip, you can’t escape from this one. Knowing your death is near, you utter a swift ");
			if (player.cor > 66) outputText("and desperate ");
			outputText("prayer to whichever gods may be listening. This has a surprising effect on the gargoyle, stilling her almost instantly.");
			outputText("\n\n\"<i>Demons... do not pray, you clearly still have a soul. Perhaps I misjudged you.</i>\"");
			outputText("\n\nWith little ceremony, she roughly sets you back on the ground, caring little for your well being, merely in order to thoroughly examine you. You tell her that you ");
			if (kGAMECLASS.dungeons.checkFactoryClear()) {
				if (player.humanScore() < 14) outputText("were");
				else outputText("are");
				outputText(" a human, a champion, sent by your village as tribute to the demons under the guise of being a hero.");
			}
			else {
				if (player.humanScore() < 14) outputText("were");
				else outputText("are");
				outputText(" a human, a champion, sent by your village to defeat the demons. However just what is this place and who is she?");
			}
			outputText("\n\n\"<i>There haven't been many humans in Mareth, especially since the demons took over, so it’s likely that you are the first to make it here in a long time. If you seek salvation, I’m afraid the temple will not provide any, as the gods and their powers have long since left their altars. As for who I am, my name is Sapphire. I am the last guardian of this sacred ground, and the last line of defense against the fiends that desecrate this land.</i>\"");
			outputText("\n\nHer name seems to be somewhat appropriate, her eyes glowing with a faint, azure hue. As you ponder these details the gargoyle turns her back to you, taking flight towards one of the pillars in the room.\n\n\"<i>You are welcome to visit this place as often as you see fit. However, I will be watching you.</i>\"\n\n<b>You can now visit the Temple of the Divines!</b>");
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function repeatvisitintro():void {
			clearOutput();
			outputText("You decide to make a trip to the temple. However as soon as you enter the sacred ground, Sapphire screeches and takes flight, spear at the ready. Luckily, she calms down once she recognizes you, assuming a relaxed pose in the middle of the temple.");			
			outputText("\n\n\"<i>Well, hello there! Nice to see you again [name]. You're welcome here, as usual... So are you here to pray?");
			if (flags[kFLAGS.SAPPHIRE_AFFECTION] > 99) outputText(" Or perhaps you're here for something more... mutually agreeable, instead?");
			outputText("</i>\"");
			if (flags[kFLAGS.SAPPHIRE_AFFECTION] > 99) outputText(" She says, winking with a lusty smile.");
			menu();
			addButtonDisabled(0, "???", "Cummin Sooooon!");
			addButtonDisabled(1, "???", "Cummin Sooooon!");
			addButton(5, "Sapphire", sapphiremenu, null, null, null, "Cummin Sooooon!");
			addButtonDisabled(6, "???", "Cummin Sooooon!");
			addButtonDisabled(7, "???", "Cummin Sooooon!");
		//	addButton(7, "Basement", templeBasement, null, null, null, "Cummin Sooooon!");
			addButton(14,"Leave", camp.returnToCampUseOneHour);
		}
		
		public function templemainmenu():void {
			clearOutput();
			outputText("What would you like to do in the temple?");
			menu();
			addButtonDisabled(0, "???", "Cummin Sooooon!");
			addButtonDisabled(1, "???", "Cummin Sooooon!");
			addButton(5, "Sapphire", sapphiremenu, null, null, null, "Cummin Sooooon!");
			addButtonDisabled(6, "???", "Cummin Sooooon!");
			addButtonDisabled(7, "???", "Cummin Sooooon!");
		//	addButton(7, "Basement", templeBasement, null, null, null, "Cummin Sooooon!");
			addButton(14,"Leave", camp.returnToCampUseOneHour);
		}
		
		public function TempleAltairsRebuildMenu():void {
			outputText("What would you like to do in the temple?");
			menu();
			addButtonDisabled(0, "Marae", "Cummin Sooooon!");
			addButtonDisabled(1, "Taoth", "Cummin Sooooon!");
			addButtonDisabled(2, "Fenrir", "Cummin Sooooon!");
			addButtonDisabled(3, "Fera", "Cummin Sooooon!");
		//	addButtonDisabled(4, "???", "Cummin Sooooon!");
			addButton(14, "Back", templemainmenu);
		}
		
		public function sapphiremenu():void {
			clearOutput();
			outputText("You admit that you were actually looking for her, a response which she seems happy about, as she casually sits next to you and starts conversing.\n\n");
			outputText("\n\n\"<i>So [name] what did you want to talk about?</i>\"");
			menu();
		//	addButton(0,"This place", templemainmenu);
			addButton(1,"Her", TalkHer, null, null, null, "Cummin Sooooon!");
		//	if (flags[kFLAGS.SAPPHIRE_AFFECTION] > 5) addButton(2,"Sex", TalkSex);
			addButton(4,"Back", templemainmenu);
		}
		
		public function TalkHer():void {
			clearOutput();
			if (flags[kFLAGS.SAPPHIRE_TALKS] == 2 || flags[kFLAGS.SAPPHIRE_TALKS] == 5) {
				outputText("You're curious about her story and decide to ask her.\n\n");
				outputText("\"<i>My story? Well that's nothing special. I have been guarding this place for years, even before the demons came. I was raised here in this temple. I have always had a fascination with gods, Marae in particular. It was only natural for me to become a priestess of her cult. In recent years, I mostly dealt with the occasional thieves and demons that somehow manage to break through the ward. Even then, only a very powerful opponent could manage that.</i>\"\n\n");
				outputText("You ask her how she is able to contend with demons, especially the most dangerous ones.\n\n");
				outputText("\"<i>I understand that my body looks like something more fitting for a whore than a chaste being. My sexual desire is next to zero. As far as I know, I’m as cold as the stone I'm made from. Therefore, demons have a very difficult time getting me to even start being aroused. As arousal and black magic is their main weapon, I’m pretty much the worst opponent they could encounter.</i>\"\n\n");
				outputText("You thank her for her time and proceed to head back to your camp.");
				flags[kFLAGS.SAPPHIRE_TALKS]++;
				sapphireAffection(2);
				if (flags[kFLAGS.SAPPHIRE_TALKS] > 4) flags[kFLAGS.SAPPHIRE_TALKS] = 3;
				doNext(camp.returnToCampUseOneHour);
			}
			if (flags[kFLAGS.SAPPHIRE_TALKS] == 1 || flags[kFLAGS.SAPPHIRE_TALKS] == 4) {
				outputText("Didn't she say that she was raised in the temple? Last time you checked Gargoyles were magically constructed creatures that do not age or die. How could she have been raised in the first place?\n\n");
				outputText("\"<i>This isn’t how I used to be. I was once of flesh and blood just like you. I was born in the former capital city which serves as the main demon base now. My mother was a priestess at the temple, so naturally I became one as well . My childhood was mostly spent learning holy texts and chanting in the chorus. I don't think it was a waste, these lands used to be beautiful before the demon outbreak. At 16, I was among many selected to work directly in the temple of the divine. It was a great privilege. ");
				outputText("I prayed, tended to the temple, and worked under the abbot for many years as a nun. I would have continued to do so had the demons not come. In the end I couldn’t save anyone. I'm sorry, I don't feel like talking about this any further, at least for now. Please, leave me be.</i>\"\n\n");
				outputText("You excuse yourself and leave, returning back to your camp.");
				flags[kFLAGS.SAPPHIRE_TALKS]++;
				sapphireAffection(2);
				doNext(camp.returnToCampUseOneHour);
			}
			if (flags[kFLAGS.SAPPHIRE_TALKS] == 0 || flags[kFLAGS.SAPPHIRE_TALKS] == 3) {
				outputText("Now that some time has passed you ask her if she is ready to tell you more about the events she foreshadowed in your previous discussion.\n\n");
				outputText("\"<i>It pains me to even think about the events of that day, the day the demons appeared. They poured into the cities below us like a tidal wave, devouring souls and corrupting everything in their path. Eventually they began climbing the mountain, and we knew they would be on our doorstep within hours. To prevent them from destroying this holy ground we devised a plan. No matter what the cost to us, the temple had to be protected. ");
				outputText("As such one by one, we sacrificed ourselves in a ritual to create from us everlasting guardians. I was the last one to be put on the altar. They finished the ritual just as the demons started pouring in. Many desperate enchantments and prayers were put into the creation of each of us, hoping to create a combination by chance that would correctly dispatch the demons. The other gargoyles didn't receive the protections required to face the demons as I did, thus they were destroyed one by one. ");
				outputText("Amidst the chaos, the altars were damaged extensively and rendered useless. As I kept killing more and more of them, they retreated. Satisfied with their dirty work, they just ran away, like the cowards they are, to prevent further casualties.</i>\"\n\n");
				outputText("What of her? Why did the demons spare her?\n\n");
				outputText("\"<i>Their work was done. The numerous altars in the church were no longer able to channel divine powers and the abbot was captured alive and brought inside the hell hole that is now Lethice's stronghold. I think they simply left because they had no interest in getting slaughtered by a being they could not corrupt or destroy. With everyone gone or dead, it feels so lonely in this place now.</i>\"\n\n");
				outputText("You thank her for her time and walk back to camp.");
				flags[kFLAGS.SAPPHIRE_TALKS]++;
				sapphireAffection(2);
				doNext(camp.returnToCampUseOneHour);
			}
		}
		/*
		public function TalkSex():void {
			clearOutput();
			outputText("She said that she is sexually dead. That’s something very rare on Mareth, considering the number of lunatics who spend their day fornicating even in the most pure pockets of the world.\n\n");
			outputText("\"<i>Don’t think of it that way, I never said I couldn't feel it, just that my desires are deadened. I don't actually feel the need at all, although ,like just anyone, I can have a good time. My body won't feel it unless I desire it. And since i've never been in love before...</i>\"\n\n");
			doNext(camp.returnToCampUseOneHour);
		}
		*/
		public function templeBasement():void {
			clearOutput();
			if (flags[kFLAGS.FOUND_TEMPLE_OF_THE_DIVINE] == 1) {
				outputText("As you wander down into the basement of the temple you find what looks like an old abandoned Atelier. Down there are two unfinished statues of what looks like a gargoyle. Either could be carved in any way you wish.");
				flags[kFLAGS.FOUND_TEMPLE_OF_THE_DIVINE]++;
				doNext(templemainmenu);
			}
			if (flags[kFLAGS.FOUND_TEMPLE_OF_THE_DIVINE] == 2) {
				outputText("You wander back into the Temple basement atelier.");
				addButtonDisabled(0, "Statue", "Cummin Sooooon!");
				addButton(1, "Strange Book", strangeBookOfGolems, null, null, null, "Cummin Sooooon!");
				addButtonDisabled(2, "Spare Statue", "Cummin Sooooon!");
				addButton(4, "Back", templemainmenu);
			}
		}
		
		public function strangeBookOfGolems():void {
			clearOutput();
			outputText("Golemancy is the art of creating artificial being from the combination of a statue and a soul. While any soul can power a golem for the purpose of giving it at least minimal intelligence and autonomy it is recommended to use the soul of a living or deceased humanoid. The most suiting and morale soul for such a purpose is generally the soul of a person near death door or a willing sacrifice. ");
			outputText("Most of the Gargoyle crafted in this way are infused with the soul of pious priests and nun willing to protect the church of Marae for all eternity. Golems knows no hunger or pain but can be destroyed thus freeing their soul back. To prevent such a thing most golem are given the ability to recover by eating raw stone in order to repair themselves magically. To create a golem start by sculpting a suitable vessel for the soul. ");
			outputText("Once this is done place the body of the sacrifice or the captured soul of the behing you wish to infuse your golem with on a sacred altar and have the statue still on its pedestal carried over to face the altar but at a safe distance in case it accidentally lash out at you in confusion upon awakening as if often the case for already dead sacrifice who are snatched from the afterlife or have longed in anguish for months inside the soul gem.\n\n");
			outputText("Finally bind the golem by making a magic circle with the enchantments you wish to place in order to limit its freedom to whatever purpose you want. Make a final magic circle below the pedestal in order to bind the soul to the vessel but keep in mind blood need to be used to craft such a circle. Any blood will do but it always has to be made out of blood which is essentially a symbol of life. ");
			outputText("You will need several additional ingredient including a drake heart flower, some pure honey, powdered coal mixed in the blood and finally a perfectly crafted soul gem ready to be filled with the soul of the sacrifice and already touching the golem in a way or another. Once this is all done you're finally ready to transfer the soul to the golem. ");
			outputText("Should the sacrifice still be alive it will likely die as its soul is sucked into your creation and there is no turning back once it's done so make sure the subject is ready physically and psychologically to welcome the change. Place yourself facing the statue but on the opposite side of the central altar and recite the following arcane word in order to proceed to the transfer.\n\n");
			outputText("Shira Khrim Almisry Ohm Ak Tar Marae Kann Tharr Shul Elysro An Siryr Ahn Ekatyr Evenar Sethe Omaris.\n\n");
			outputText("You think you could use these information to perhaps turn yourself into a living weapon in order to defeat the demon with relative ease. The question you should ask yourself however is... is this really what you want?");
			doNext(templeBasement);
		}
		//GARGOYLE_QUEST - flaga do śledzenia postepu questu
	}
}