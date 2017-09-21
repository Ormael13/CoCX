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
		
		public function TempleOfTheDivine() 
		{}
		
		public function sapphireAffection(changes:Number = 0):Number
		{
			flags[kFLAGS.SAPPHIRE_AFFECTION] += changes;
			if (flags[kFLAGS.SAPPHIRE_AFFECTION] > 100) flags[kFLAGS.SAPPHIRE_AFFECTION] = 100;
			return flags[kFLAGS.SAPPHIRE_AFFECTION];
		}
		
		public function firstvisitintro():void {
			flags[kFLAGS.FOUND_TEMPLE_OF_THE_DIVINE] = 1;
			flags[kFLAGS.SAPPHIRE_TALKS] = 0;
			clearOutput();
			outputText("As you wander the mountains, you eventually climb to the very top, something you never expected to do. Weirdly enough, sitting on a nearby peak is what appears to be a massive temple. You approach the intimidating doors of the building and open them wide. Instantly you’re taken aback by the sight in front of you. ");
			outputText("There are ancient bloodstains marking the stone floor and stained glass windows depicting various deities adorning each wall. At the end of the building that obviously once was a holy site, sits one depicting Marae. Under each window is a somewhat damaged altar, the light outside shining faintly upon it.");
			outputText("\n\nAs you walk towards Marae’s Altar, a threatening voice echoes through the temple. \"<i>No one will defile this sacred place! I will slay you before you can cause any further damage!</i>\"");
			outputText("\n\nYou realize that you were never alone in the room as a large and heavy object hits you from behind, sending you sprawling to the ground. As you try to stand up, something grabs you by the leg, lifting you upside down in the air with apparent ease. While uncomfortable, and most definitely a shock, this gives you enough time to take a good look at what, or more specifically who, grabbed you. ");
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
			outputText("\n\nHer name seems to be somewhat appropriate, her eyes glowing with a faint, azure hue. As you ponder these details, the gargoyle turns her back to you, taking flight towards one of the pillars in the room.\n\n\"<i>You are welcome to visit this place as often as you see fit. However, I will be watching you.</i>\"\n\n<b>You can now visit the Temple of the Divines!</b>");
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
			addButton(5, "Sapphire", sapphiremenu).hint("Cummin Sooooon!");
			addButtonDisabled(6, "???", "Cummin Sooooon!");
			addButtonDisabled(7, "???", "Cummin Sooooon!");
			addButton(7, "Basement", templeBasement).hint("Cummin Sooooon!");
			addButton(14,"Leave", camp.returnToCampUseOneHour);
		}
		
		public function templemainmenu():void {
			clearOutput();
			outputText("What would you like to do in the temple?");
			menu();
			addButtonDisabled(0, "???", "Cummin Sooooon!");
			addButtonDisabled(1, "???", "Cummin Sooooon!");
			addButton(5, "Sapphire", sapphiremenu).hint("Cummin Sooooon!");
			addButtonDisabled(6, "???", "Cummin Sooooon!");
			addButtonDisabled(7, "???", "Cummin Sooooon!");
			addButton(7, "Basement", templeBasement).hint("Cummin Sooooon!");
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
			addButton(1,"Her", TalkHer).hint("Fancy tooltip that Lia will surely make soon.");
			if (flags[kFLAGS.SAPPHIRE_AFFECTION] > 5) addButton(2,"Sex", TalkSex).hint("Another fancy tooltip that Lia will surely make soon.");
			addButton(4,"Back", templemainmenu);
		}
		
		public function TalkHer():void {
			clearOutput();
			if (flags[kFLAGS.SAPPHIRE_TALKS] == 2 || flags[kFLAGS.SAPPHIRE_TALKS] == 6) {
				outputText("Now that some time has passed you ask her if she is ready to tell you more about the events she foreshadowed in your previous discussion.\n\n");
				outputText("\"<i>It pains me to even think about the events of that day, the day the demons appeared. They poured into the cities below us like a tidal wave, devouring souls and corrupting everything in their path. Eventually they began climbing the mountain, and we knew they would be on our doorstep within hours. To prevent them from destroying this holy ground we devised a plan. No matter what the cost to us, the temple had to be protected. ");
				outputText("As such one by one, we sacrificed ourselves in a ritual to create from us everlasting guardians. I was the last one to be put on the altar. They finished the ritual just as the demons started pouring in. Many desperate enchantments and prayers were put into the creation of each of us, hoping to create a combination by chance that would correctly dispatch the demons. The other gargoyles didn't receive the protections required to face the demons as I did, thus they were destroyed one by one. ");
				outputText("Amidst the chaos, the altars were damaged extensively and rendered useless. As I kept killing more and more of them, they retreated. Satisfied with their dirty work, they just ran away, like the cowards they are, to prevent further casualties.</i>\"\n\n");
				outputText("What of her? Why did the demons spare her?\n\n");
				outputText("\"<i>Their work was done. The numerous altars in the church were no longer able to channel divine powers and the abbot was captured alive and brought inside the hell hole that is now Lethice's stronghold. I think they simply left because they had no interest in getting slaughtered by a being they could not corrupt or destroy. With everyone gone or dead, it feels so lonely in this place now.</i>\"\n\n");
				outputText("You thank her for her time and walk back to camp.");
				flags[kFLAGS.SAPPHIRE_TALKS]++;
			}
			if (flags[kFLAGS.SAPPHIRE_TALKS] == 1 || flags[kFLAGS.SAPPHIRE_TALKS] == 5) {
				outputText("Didn't she say that she was raised in the temple? Last time you checked Gargoyles were magically constructed creatures that do not age or die. How could she have been raised in the first place?\n\n");
				outputText("\"<i>This isn’t how I used to be. I was once of flesh and blood just like you. I was born in the former capital city which serves as the main demon base now. My mother was a priestess at the temple, so naturally I became one as well . My childhood was mostly spent learning holy texts and chanting in the chorus. I don't think it was a waste, these lands used to be beautiful before the demon outbreak. At 16, I was among many selected to work directly in the temple of the divine. It was a great privilege. ");
				outputText("I prayed, tended to the temple, and worked under the abbot for many years as a nun. I would have continued to do so had the demons not come. In the end I couldn’t save anyone... I'm sorry, I don't feel like talking about this any further, at least for now. Please, leave me be.</i>\"\n\n");
				outputText("You excuse yourself and leave, returning back to your camp.");
				flags[kFLAGS.SAPPHIRE_TALKS]++;
			}
			if (flags[kFLAGS.SAPPHIRE_TALKS] == 0 || flags[kFLAGS.SAPPHIRE_TALKS] == 4) {
				outputText("You're curious about her story and decide to ask her.\n\n");
				outputText("\"<i>My story? Well that's nothing special. I have been guarding this place for years, even before the demons came. I was raised here in this temple. I have always had a fascination with gods, Marae in particular. It was only natural for me to become a priestess of her cult. In recent years, I mostly dealt with the occasional thieves and demons that somehow manage to break through the ward. Even then, only a very powerful opponent could manage that.</i>\"\n\n");
				outputText("You ask her how she is able to contend with demons, especially the most dangerous ones.\n\n");
				outputText("\"<i>I understand that my body looks like something more fitting for a whore than a chaste being. My sexual desire is next to zero. As far as I know, I’m as cold as the stone I'm made from. Therefore, demons have a very difficult time getting me to even start being aroused. As arousal and black magic is their main weapon, I’m pretty much the worst opponent they could encounter.</i>\"\n\n");
				outputText("You thank her for her time and proceed to head back to your camp.");
				flags[kFLAGS.SAPPHIRE_TALKS]++;
			}
			sapphireAffection(2);
			if (flags[kFLAGS.SAPPHIRE_TALKS] > 6) flags[kFLAGS.SAPPHIRE_TALKS] = 4;
			if (flags[kFLAGS.SAPPHIRE_TALKS] == 3) flags[kFLAGS.SAPPHIRE_TALKS]++;
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function TalkSex():void {
			clearOutput();
			if (flags[kFLAGS.SAPPHIRE_SEX] == 1) {
				outputText("Sapphire looks at you expectantly her tail agitated by the excitement of potential physical release.\n\n");
				outputText("\"<i>Feeling antsy? How would you like us to do it then?");
				if (player.isGargoyle()) outputText(" There’s even running water if we ever need... something slippery.");
				outputText("</i>\"\n\n");
				menu();
				if (player.lust > 33) {
					addButtonDisabled(0,"???", "Req. Gargoyle PC.");
					addButtonDisabled(1,"???", "Req. Gargoyle PC and Onyx/Krystal.");
					addButton(2,"MutualMasturbarion", SapphireMutualMasturbation).hint("Lia will make fancy tooltip soon ^^");
					addButtonDisabled(3,"FuckHer", "Lia will make fancy tooltip soon ^^");
				}
				addButton(4,"Back", sapphiremenu);
			}
			else {
				outputText("She said that she is sexually dead. That’s something very rare on Mareth, considering the number of lunatics who spend their day fornicating even in the most pure pockets of the world.\n\n");
				outputText("\"<i>Don’t think of it that way, I never said I couldn't feel it, just that my desires are deadened. I don't actually feel the need at all, although, like just anyone, I can have a good time. My body won't feel it unless I desire it. And since i've never been in love before...</i>\"\n\n");
				outputText("Oh, so she can actually enjoy sex? What about you? Would she like to empty many years of sexual frustration on you?\n\n");
				outputText("\"<i>Look I haven’t played with myself in several years and unless you... wait what the hell are you doing!</i>\"\n\n");
				outputText("While she is distracted, you surprise her with a hug and start kissing her. Weirdly enough Sapphire doesn't seem to hate it, actually she reacts quite favorably to it, only breaking the kiss several seconds later. Perhaps she just needs a reminder of how it can feel?\n\n");
				outputText("\"<i>That... was not something I expected. I guess it's the result of many years living alone in this temple. I'm a person too, it’s just that I had forgotten how sweet it feels to indulge into a kiss let alone love. Maybe it's the fact that you’re the first living person to come here, listen to me and actually even care so much about my problems. Can we... can we continue further? I would like to...</i>\"\n\n");
				outputText("You silence her, placing your finger to her stone lips, pulling her to the cold stone floor, and saying \"<i>Shhh it will be alright...</i>\" as you slowly lower your other hand down to the former priestess’ pussy. She coos as you slowly insert a finger inside and gently massage her.\n\n");
				outputText("\"<i>Aaaah! It's been such a long time since I...I didn't get to enjoy.. such simple pleasures... please don’t stop!</i>\"\n\n");
				outputText("You proceed to masturbate her for several minutes. Her stone body hugging you tightly all the while, as she proceeds to get you off in the same way. The both of you toy with each others body until finally you reach your peak and climax, soaking the ground and your gargoyle partner with your fluids.\n\n");
				outputText("Sapphire would blush if she could however she’s frozen in a post orgasm rigor mortis, her expression seems to be as close to happiness as one can be. After a minute she recover mobility.\n\n");
				outputText("\"<i>Thanks for letting me discover again what it is to be a woman. Please come back more often, it feels empty in the temple without you around.</i>\"\n\n");
				outputText("You smile, leaving her embrace as you promise to come back and visit.\n\n");
				flags[kFLAGS.SAPPHIRE_SEX] = 1;
				sapphireAffection(5);
				doNext(camp.returnToCampUseOneHour);
			}
		}
		
		public function SapphireMutualMasturbation():void {
			clearOutput();
			outputText("Unable to decide on a position you decide to help the temple guardian blow some steam by fingering her. The both of you sit down next to each other and you open the games by kissing Sapphire.");
			if (player.isGargoyle()) outputText(" While neither of you actually have Saliva the feeling of her stone rugged tongue against yours is quite good.");
			else outputText(" Her mouth lacking fluids is a weird experience at first but once her tongue is slick with your saliva it starts to feel like anyone else’s, albeit her tongue is slightly longer.");
			outputText("\n\n\"<i>I didn’t get to kiss anyone until you came so I never had any idea it felt this nice. Would you...</i>\"\n\n");
			outputText("You cut her short by inserting your fingers in her stone cunt making her moan appreciatively from your ministration. You notice her tail moving toward your nethers as she rewards you by");
			if (player.gender == 1 || player.gender == 3) outputText(" wrapping her long appendage around your [cock]");
			if (player.gender == 3) outputText(" and with the rest of her length");
			if (player.gender == 2 || player.gender == 3) outputText(" ramming her long prehensile but flattened macetail into your [cunt]");
			outputText(", slowly masturbating you to satisfaction. Her tail is oddly quite good at");
			if (player.gender == 2 || player.gender == 3) outputText(" hitting all of your spot");
			if (player.gender == 3) outputText(" and");
			if (player.gender == 1 || player.gender == 3) outputText(" teasing your pillar");
			outputText(". You both work each other off for a moment until you finally orgasm locking into a strong hug. ");
			if (player.isGargoyle()) outputText("The pleasure is so powerful your form petrify in rigor mortis for a few minute locking with that of Sapphire who also reached her peak.");
			else outputText(" Not so surprisingly Sapphire has no fluids of her own but you give her plenty as your genitals splash her nethers. Sapphire own orgasm cause her to petrify and harden into rigor mortis.");
			outputText(" It takes a few minute before ");
			if (player.isGargoyle()) outputText("you both");
			else outputText("she");
			outputText(" unfreeze and break the embrace as she remove her stony tail from your private.\n\n");
			outputText("You smile, leaving her embrace as you promise to come back and visit.\n\n");
			sapphireAffection(5);
			player.orgasm();
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function templeBasement():void {
			clearOutput();
			if (flags[kFLAGS.FOUND_TEMPLE_OF_THE_DIVINE] == 2) {
				outputText("You wander back into the Temple basement atelier.");
				menu();
				addButton(0, "Statue", currentStateOfStatue).hint("Cummin Sooooon!");
				addButton(1, "Strange Book", strangeBookOfGolems).hint("Cummin Sooooon!");
				addButtonDisabled(2, "Spare Statue", "Cummin Sooooon!");
				addButton(4, "Back", templemainmenu);
			}
			if (flags[kFLAGS.FOUND_TEMPLE_OF_THE_DIVINE] == 1) {
				outputText("As you wander down into the basement of the temple you find what looks like an old abandoned Atelier. Down there are two unfinished statues of what looks like a gargoyle. Either could be carved in any way you wish.\n\n");
				flags[kFLAGS.FOUND_TEMPLE_OF_THE_DIVINE]++;
				outputText("There are two statues, one looks to be made of alabaster and the other of marble. You're pretty much sure that alabaster would conduct and resist magic easier, although it is less resistant to physical blows, while one made out of marble would be a way stronger material for delivering strikes.");
				menu();
				addButton(0, "Marble", chooseToWorkOnMarbleStatue);
				addButton(1, "Alabaster", chooseToWorkOnAlabasterStatue);
			}
		}
		
		public function chooseToWorkOnMarbleStatue():void {
			flags[kFLAGS.GARGOYLE_BODY_MATERIAL] = 1;
			flags[kFLAGS.GARGOYLE_BODY_SCULPTING_PROGRESS] = 1;
			flags[kFLAGS.GARGOYLE_QUEST] = 1;
			flags[kFLAGS.GARGOYLE_WINGS_TYPE] = 0;
			currentStateOfStatue();
		}
		public function chooseToWorkOnAlabasterStatue():void {
			flags[kFLAGS.GARGOYLE_BODY_MATERIAL] = 2;
			flags[kFLAGS.GARGOYLE_BODY_SCULPTING_PROGRESS] = 1;
			flags[kFLAGS.GARGOYLE_QUEST] = 1;
			flags[kFLAGS.GARGOYLE_WINGS_TYPE] = 0;
			currentStateOfStatue();
		}
		
		public function currentStateOfStatue():void {
			clearOutput();
			outputText("This statue looks like ");
			if (flags[kFLAGS.GARGOYLE_BODY_SCULPTING_PROGRESS] >= 10) outputText("a finished");
			else outputText("an incomplete");
			if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 1) outputText(" marble");
			if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 2) outputText(" alabaster");
			outputText(" gargoyle. This statue looks like ");
			if (player.statusEffectv1(StatusEffects.GargoyleTFSettingTracker1) == 1) outputText("it has a gorgeous female face");
			if (player.statusEffectv1(StatusEffects.GargoyleTFSettingTracker1) == 2) outputText("it has a handsome male face");
			if (player.statusEffectv1(StatusEffects.GargoyleTFSettingTracker1) == 3) outputText("!!! Androgen face desc !!!");
			if (!player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker1) || player.statusEffectv1(StatusEffects.GargoyleTFSettingTracker1) == 0) outputText("its face is yet to be finished");
			outputText(" and its ");
			if (player.statusEffectv1(StatusEffects.GargoyleTFSettingTracker2) == 1) outputText("bald head looks great.");
			if (player.statusEffectv1(StatusEffects.GargoyleTFSettingTracker2) == 2) outputText("short hair looks great.");
			if (player.statusEffectv1(StatusEffects.GargoyleTFSettingTracker2) == 3) outputText("moderately long hair looks great.");
			if (player.statusEffectv1(StatusEffects.GargoyleTFSettingTracker2) == 4) outputText("long hair looks great.");
			if (!player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2) || player.statusEffectv1(StatusEffects.GargoyleTFSettingTracker2) == 0) outputText("hair is yet to be sculpted.");
			if (player.statusEffectv2(StatusEffects.GargoyleTFSettingTracker2) > 0) {
				outputText("\n\nStatue have ");
				if (player.statusEffectv2(StatusEffects.GargoyleTFSettingTracker2) == 1)outputText("flat chest");
				if (player.statusEffectv2(StatusEffects.GargoyleTFSettingTracker2) == 2)outputText("A-cup breasts");
				if (player.statusEffectv2(StatusEffects.GargoyleTFSettingTracker2) == 3)outputText("B-cup breasts");
				if (player.statusEffectv2(StatusEffects.GargoyleTFSettingTracker2) == 4)outputText("C-cup breasts");
				if (player.statusEffectv2(StatusEffects.GargoyleTFSettingTracker2) == 5)outputText("D-cup breasts");
				if (player.statusEffectv2(StatusEffects.GargoyleTFSettingTracker2) == 6)outputText("DD-cup breasts");
				if (player.statusEffectv2(StatusEffects.GargoyleTFSettingTracker2) == 7)outputText("big DD-cup breasts");
				outputText(".\n\n");
			}
			if (!player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2) || player.statusEffectv2(StatusEffects.GargoyleTFSettingTracker2) == 0) outputText("\n\nThere's a block where its chest would be.\n\n");
			if ((!player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2) || player.statusEffectv3(StatusEffects.GargoyleTFSettingTracker2) < 1) && !player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker3)) outputText("There's a block where its crotch would be.");
			else {
				outputText("At statue crotch ");
				if (player.statusEffectv3(StatusEffects.GargoyleTFSettingTracker2) > 1) {
					outputText("there is ");
					if (player.statusEffectv3(StatusEffects.GargoyleTFSettingTracker2) == 2) outputText("4 inch");
					if (player.statusEffectv3(StatusEffects.GargoyleTFSettingTracker2) == 3) outputText("4.5 inch");
					if (player.statusEffectv3(StatusEffects.GargoyleTFSettingTracker2) == 4) outputText("5 inch");
					if (player.statusEffectv3(StatusEffects.GargoyleTFSettingTracker2) == 5) outputText("5.5 inch");
					if (player.statusEffectv3(StatusEffects.GargoyleTFSettingTracker2) == 6) outputText("6 inch");
					if (player.statusEffectv3(StatusEffects.GargoyleTFSettingTracker2) == 7) outputText("6.5 inch");
					if (player.statusEffectv3(StatusEffects.GargoyleTFSettingTracker2) == 8) outputText("7 inch");
					if (player.statusEffectv3(StatusEffects.GargoyleTFSettingTracker2) == 9) outputText("7.5 inch");
					if (player.statusEffectv3(StatusEffects.GargoyleTFSettingTracker2) == 10) outputText("8 inch");
					if (player.statusEffectv3(StatusEffects.GargoyleTFSettingTracker2) == 11) outputText("8.5 inch");
					if (player.statusEffectv3(StatusEffects.GargoyleTFSettingTracker2) == 12) outputText("9 inch");
					outputText(" long cock.");
				}
				if (player.statusEffectv3(StatusEffects.GargoyleTFSettingTracker2) == 1) outputText("there is no cock.");
			}
			outputText("\n\nAll details in its");
			if (flags[kFLAGS.GARGOYLE_WINGS_TYPE] == 2) outputText(" bat");
			if (flags[kFLAGS.GARGOYLE_WINGS_TYPE] == 1) outputText(" feathered");
			outputText(" wings ");
			if (flags[kFLAGS.GARGOYLE_WINGS_TYPE] >= 1) outputText("are completed, wings folded behind its back");
			else outputText("have yet to be done");
			outputText(".\n\nIt's arms ");
			if (player.statusEffectv4(StatusEffects.GargoyleTFSettingTracker1) == 1) outputText("ends with a set of bestial four fingered sharp stone claws");
			if (player.statusEffectv4(StatusEffects.GargoyleTFSettingTracker1) == 2) outputText("ends with very human fist");
			if (!player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker1) || player.statusEffectv3(StatusEffects.GargoyleTFSettingTracker1) == 0)outputText("have yet to be sculpted");
			outputText(". It's legs ");
			if (player.statusEffectv3(StatusEffects.GargoyleTFSettingTracker1) == 1) outputText("ends with clawed bestial feets with three toe at the front and one at the back");
			if (player.statusEffectv3(StatusEffects.GargoyleTFSettingTracker1) == 2) outputText("are human like");
			if (!player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker1) || player.statusEffectv4(StatusEffects.GargoyleTFSettingTracker1) == 0)outputText("have yet to be defined");
			outputText(". Its ");
			if (player.statusEffectv2(StatusEffects.GargoyleTFSettingTracker1) == 1) outputText("mace like");
			if (player.statusEffectv2(StatusEffects.GargoyleTFSettingTracker1) == 2) outputText("axe like");
			if (!player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker1) || player.statusEffectv2(StatusEffects.GargoyleTFSettingTracker1) == 0)outputText("unfinished");
			outputText(" tail seems to be there right above its ");
			if (player.statusEffectv1(StatusEffects.GargoyleTFSettingTracker1) == 1 || player.statusEffectv1(StatusEffects.GargoyleTFSettingTracker1) == 2 || player.statusEffectv1(StatusEffects.GargoyleTFSettingTracker1) == 3) {
				outputText("perfectly made ");
				if (player.statusEffectv1(StatusEffects.GargoyleTFSettingTracker1) == 1) outputText("feminine");
				if (player.statusEffectv1(StatusEffects.GargoyleTFSettingTracker1) == 2) outputText("masculine");
				if (player.statusEffectv1(StatusEffects.GargoyleTFSettingTracker1) == 3) outputText("androgynous");
			}
			if (!player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker1))outputText("unfinished");
			outputText(" body.");
			menu();
			if (!player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker1) || player.statusEffectv1(StatusEffects.GargoyleTFSettingTracker1) < 1) addButton(0, "Frame&Face", SculptFrameAndFace);
			else addButtonDisabled(0, "Frame&Face", "You already sculpted Frame and Face.");
			if (flags[kFLAGS.GARGOYLE_WINGS_TYPE] < 1) addButton(1, "Wings", SculptWings);
			else addButtonDisabled(1, "Wings", "You already sculpted Wings.");
			if (!player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker1) || player.statusEffectv2(StatusEffects.GargoyleTFSettingTracker1) < 1) addButton(2, "Tail", SculptTail);
			else addButtonDisabled(2, "Tail", "You already sculpted Tail.");
			if (!player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker1) || player.statusEffectv3(StatusEffects.GargoyleTFSettingTracker1) < 1) addButton(3, "Legs", SculptLegs);
			else addButtonDisabled(3, "Legs", "You already sculpted Legs.");
			if (!player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker1) || player.statusEffectv4(StatusEffects.GargoyleTFSettingTracker1) < 1) addButton(4, "Arms", SculptArms);
			else addButtonDisabled(4, "Arms", "You already sculpted Arms.");
			if (!player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2) || player.statusEffectv1(StatusEffects.GargoyleTFSettingTracker2) < 1) addButton(5, "Hair", SculptHair);
			else addButtonDisabled(5, "Hair", "You already sculpted Hair.");
			if (!player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2) || player.statusEffectv2(StatusEffects.GargoyleTFSettingTracker2) < 1) addButton(6, "Chest", SculptChest);
			else addButtonDisabled(6, "Chest", "You already sculpted Chest.");//progress flag at 8/10
			if (!player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2) || player.statusEffectv3(StatusEffects.GargoyleTFSettingTracker2) < 1) addButton(8, "Cock", SculptCock);
			else addButtonDisabled(8, "Cock", "You already sculpted Cock Area.");//look at CharCreation.as line 958 for setitng thicknes based on picked length
			addButton(14, "Back", BackToSapphire);
		}
		public function BackToSapphire():void {
			clearOutput();
			outputText("You decide to come back later to finish the work.");
			doNext(templemainmenu);
		}
		
		public function SculptFrameAndFace():void {
			menu();
			addButton(0, "Feminine", SculptFeminineFrameAndFace).hint("Sculpt a feminine frame and face.");
			addButton(1, "Masculine", SculptMasculineFrameAndFace).hint("Sculpt a masculine frame and face.");
			addButton(2, "Androgynous", SculptAndrogynousFrameAndFace).hint("Sculpt a androgynous frame and face.");
			addButton(14, "Back", currentStateOfStatue);
		}
		public function SculptFeminineFrameAndFace():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker1)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker1, 1, 1);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker1, 1, 0, 0, 0);
			SecondPartOfSculptingText();
		}
		public function SculptMasculineFrameAndFace():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker1)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker1, 1, 2);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker1, 2, 0, 0, 0);
			SecondPartOfSculptingText();
		}
		public function SculptAndrogynousFrameAndFace():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker1)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker1, 1, 3);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker1, 3, 0, 0, 0);
			SecondPartOfSculptingText();
		}
		
		public function SculptWings():void {
			menu();
			addButton(0, "Bat", SculptBatWings).hint("Sculpt bat wings.");
			addButton(1, "Feathered", SculptFeatheredWings).hint("Sculpt feathered wings.");
			addButton(14, "Back", currentStateOfStatue);
		}
		public function SculptBatWings():void {
			flags[kFLAGS.GARGOYLE_WINGS_TYPE] = 2;
			SecondPartOfSculptingText();
		}
		public function SculptFeatheredWings():void {
			flags[kFLAGS.GARGOYLE_WINGS_TYPE] = 1;
			SecondPartOfSculptingText();
		}
		
		public function SculptTail():void {
			menu();
			addButton(0, "Mace", SculptMaceTail).hint("Sculpt mace shaped tail tip.");
			addButton(1, "Feathered", SculptAxeTail).hint("Sculpt axe shaped tail tip.");
			addButton(14, "Back", currentStateOfStatue);
		}
		public function SculptMaceTail():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker1)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker1, 2, 1);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker1, 0, 1, 0, 0);
			SecondPartOfSculptingText();
		}
		public function SculptAxeTail():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker1)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker1, 2, 2);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker1, 0, 2, 0, 0);
			SecondPartOfSculptingText();
		}
		
		public function SculptLegs():void {
			menu();
			addButton(0, "Clawed", SculptClawedLegs).hint("Sculpt clawed legs.");
			addButton(1, "Humane", SculptHumaneLegs).hint("Sculpt humane legs.");
			addButton(14, "Back", currentStateOfStatue);
		}
		public function SculptClawedLegs():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker1)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker1, 3, 1);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker1, 0, 0, 1, 0);
			SecondPartOfSculptingText();
		}
		public function SculptHumaneLegs():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker1)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker1, 3, 2);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker1, 0, 0, 2, 0);
			SecondPartOfSculptingText();
		}
		
		public function SculptArms():void {
			menu();
			addButton(0, "Clawed", SculptClawedArms).hint("Sculpt clawed arms.");
			addButton(1, "Humane", SculptHumaneArms).hint("Sculpt humane arms.");
			addButton(14, "Back", currentStateOfStatue);
		}
		public function SculptClawedArms():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker1)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker1, 4, 1);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker1, 0, 0, 0, 1);
			SecondPartOfSculptingText();
		}
		public function SculptHumaneArms():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker1)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker1, 4, 2);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker1, 0, 0, 0, 2);
			SecondPartOfSculptingText();
		}
		
		public function SculptHair():void {
			menu();
			addButton(0, "Bald", SculptBald).hint("Sculpt bald head.");
			addButton(1, "Short", SculptShort).hint("Sculpt short hair on statue head.");
			addButton(2, "Medium", SculptMedium).hint("Sculpt medium long hair on statue head.");
			addButton(3, "Long", SculptLong).hint("Sculpt long hair on statue head.");
			addButton(14, "Back", currentStateOfStatue);
		}
		public function SculptBald():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker2, 1, 1);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker2, 1, 0, 0, 0);
			SecondPartOfSculptingText();
		}
		public function SculptShort():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker2, 1, 2);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker2, 2, 0, 0, 0);
			SecondPartOfSculptingText();
		}
		public function SculptMedium():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker2, 1, 3);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker2, 3, 0, 0, 0);
			SecondPartOfSculptingText();
		}
		public function SculptLong():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker2, 1, 4);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker2, 4, 0, 0, 0);
			SecondPartOfSculptingText();
		}
		
		public function SculptChest():void {
			menu();
			addButton(0, "Flat", SculptFlat).hint("Sculpt flat chest.");
			addButton(1, "A-cup", SculptACup).hint("Sculpt A-cup breasts.");
			addButton(2, "B-cup", SculptBCup).hint("Sculpt B-cup breasts.");
			addButton(3, "C-cup", SculptCCup).hint("Sculpt C-cup breasts.");
			addButton(4, "D-cup", SculptDCup).hint("Sculpt D-cup breasts.");
			addButton(5, "DD-cup", SculptDDCup).hint("Sculpt DD-cup breasts.");
			addButton(6, "Big DD-cup", SculptBigDDCup).hint("Sculpt Big DD-cup breasts.");
			addButton(14, "Back", currentStateOfStatue);
		}
		public function SculptFlat():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker2, 2, 1);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker2, 0, 1, 0, 0);
			SecondPartOfSculptingText();
		}
		public function SculptACup():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker2, 2, 2);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker2, 0, 2, 0, 0);
			SecondPartOfSculptingText();
		}
		public function SculptBCup():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker2, 2, 3);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker2, 0, 3, 0, 0);
			SecondPartOfSculptingText();
		}
		public function SculptCCup():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker2, 2, 4);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker2, 0, 4, 0, 0);
			SecondPartOfSculptingText();
		}
		public function SculptDCup():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker2, 2, 5);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker2, 0, 5, 0, 0);
			SecondPartOfSculptingText();
		}
		public function SculptDDCup():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker2, 2, 6);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker2, 0, 6, 0, 0);
			SecondPartOfSculptingText();
		}
		public function SculptBigDDCup():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker2, 2, 7);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker2, 0, 7, 0, 0);
			SecondPartOfSculptingText();
		}
		
		public function SculptCock():void {
			menu();
			addButton(0, "None", SculptNoCock).hint("Don't sculpt cock.");
			addButton(1, "4\"", SculptCock1).hint("Sculpt 4' cock.");
			addButton(2, "4.5\"", SculptCock2).hint("Sculpt 4.5' cock.");
			addButton(3, "5\"", SculptCock3).hint("Sculpt 5' cock.");
			addButton(4, "5.5\"", SculptCock4).hint("Sculpt 5.5' cock.");
			addButton(5, "6\"", SculptCock5).hint("Sculpt 6' cock.");
			addButton(6, "6.5\"", SculptCock6).hint("Sculpt 6.5' cock.");
			addButton(7, "7\"", SculptCock7).hint("Sculpt 7' cock.");
			addButton(8, "7.5\"", SculptCock8).hint("Sculpt 7.5' cock.");
			addButton(9, "8\"", SculptCock9).hint("Sculpt 8' cock.");
			addButton(10, "8.5\"", SculptCock10).hint("Sculpt 8.5' cock.");
			addButton(11, "9\"", SculptCock11).hint("Sculpt 9' cock.");
			addButton(14, "Back", currentStateOfStatue);
		}
		public function SculptNoCock():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker2, 3, 1);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker2, 0, 0, 1, 0);
			SecondPartOfSculptingText();
		}
		public function SculptCock1():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker2, 3, 2);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker2, 0, 0, 2, 0);
			SecondPartOfSculptingText();
		}
		public function SculptCock2():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker2, 3, 3);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker2, 0, 0, 3, 0);
			SecondPartOfSculptingText();
		}
		public function SculptCock3():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker2, 3, 4);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker2, 0, 0, 4, 0);
			SecondPartOfSculptingText();
		}
		public function SculptCock4():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker2, 3, 5);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker2, 0, 0, 5, 0);
			SecondPartOfSculptingText();
		}
		public function SculptCock5():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker2, 3, 6);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker2, 0, 0, 6, 0);
			SecondPartOfSculptingText();
		}
		public function SculptCock6():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker2, 3, 7);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker2, 0, 0, 7, 0);
			SecondPartOfSculptingText();
		}
		public function SculptCock7():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker2, 3, 8);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker2, 0, 0, 8, 0);
			SecondPartOfSculptingText();
		}
		public function SculptCock8():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker2, 3, 9);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker2, 0, 0, 9, 0);
			SecondPartOfSculptingText();
		}
		public function SculptCock9():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker2, 3, 10);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker2, 0, 0, 10, 0);
			SecondPartOfSculptingText();
		}
		public function SculptCock10():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker2, 3, 11);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker2, 0, 0, 11, 0);
			SecondPartOfSculptingText();
		}
		public function SculptCock11():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker2, 3, 12);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker2, 0, 0, 12, 0);
			SecondPartOfSculptingText();
		}
		
		public function SecondPartOfSculptingText():void {
			clearOutput();
			outputText("You work for six hours, sculpting the statue part to your liking with an artist's passion, then head back to camp for a break.");
			flags[kFLAGS.GARGOYLE_BODY_SCULPTING_PROGRESS]++;
			doNext(camp.returnToCampUseSixHours);
		}
		
		public function strangeBookOfGolems():void {
			clearOutput();
			outputText("This book seems to explain the process of crafting a Gargoyle in length. It seems to imply your friend up there may have been made out from the soul of a willing sacrifice or a long dead person. Will you read it?");
			menu();
			addButton(0, "Read", readStrangeBookOfGolems);
			addButton(1, "Back", templeBasement);
		}
		public function readStrangeBookOfGolems():void {
			clearOutput();
			outputText("Golemancy is the art of creating an artificial being from the combination of a statue and a soul. While any soul can give life to a golem, for the purpose of giving it at least minimal intelligence and autonomy, it is recommended to use the soul of a living or deceased humanoid. The most suiting and moral soul for such a purpose is generally the soul of a person near death’s door or a willing sacrifice. ");
			outputText("Most of the Gargoyle crafted in this way are infused with the soul of pious priests and nun willing to protect the church of Marae for all eternity. Golems knows no hunger or pain but can be destroyed thus freeing their soul back. To prevent such a thing most golem are given the ability to recover by eating raw stone in order to repair themselves magically. To create a golem start by sculpting a suitable vessel for the soul. ");
			outputText("Once this is done, place the body of the sacrifice or the captured soul of the being you wish to infuse your golem with on a sacred altar. Have the statue, still on its pedestal, carried over to face the altar but at a safe distance in case it accidentally lashes out at you in confusion upon awakening. It is often the case for already dead sacrifices, who are often snatched from the afterlife or have lounged in anguish for months inside the soul gem before being prepared.\n\n");
			outputText("Finally, bind the golem by making a magic circle with the enchantments you wish to place in order to limit its freedom to whatever purpose you want. Make a second and final magic circle below the pedestal in order to bind the soul to the vessel, but keep in mind blood is needed to craft such a circle. Any blood will do as it is essentially a symbol of life. Keep in mind using anything but blood will ruin the ritual entirely. ");
			outputText("You will need several additional ingredients: a drake heart flower, some pure honey, powdered coal mixed in the blood and finally a soul gem, ready to be filled with the soul of the sacrifice, if any, with them already touching the golem in a way or another. In the case where the sacrifice is already in the gem make sure the gem touches the statue. Once this is all done you're finally ready to transfer the soul to the golem. ");
			outputText("Should the sacrifice still be alive, it’s physical body will likely die as its soul is sucked into your creation. There is no turning back once it's done, so make sure the subject is ready physically and psychologically to welcome the change. Stand facing the statue but on the opposite side of the central altar and recite the following arcane word in order to proceed to the transfer.\n\n");
			outputText("Shira Khrim Almisry Ohm Ak Tar Marae Kann Tharr Shul Elysro An Siryr Ahn Ekatyr Evenar Sethe Omaris.\n\n");
			outputText("You think you could use this information to perhaps turn yourself into a living weapon in order to defeat the demons with relative ease. The question you should ask yourself however is... is this really what you want?");
			flags[kFLAGS.GARGOYLE_QUEST]++;
			doNext(templeBasement);
		}
		//GARGOYLE_QUEST - flaga do śledzenia postepu questu (po zdobyciu zapisków jest na wartości 3)
	}
}