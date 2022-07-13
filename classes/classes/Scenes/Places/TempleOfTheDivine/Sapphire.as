/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Places.TempleOfTheDivine
{
import classes.*;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kFLAGS;
import classes.display.SpriteDb;
import classes.Scenes.SceneLib;

use namespace CoC;

	public class Sapphire extends BaseContent {

		public function Sapphire() {
		}

		/*
		* <60 - not talked enough.
		* Reaches 60 after 3 talks (full story), then ready for sex.
		* After sex talk, 100 - horny.
		* */
		public function sapphireAffection(changes:Number = 0):Number {
			flags[kFLAGS.SAPPHIRE_AFFECTION] += changes;
			if (flags[kFLAGS.SAPPHIRE_AFFECTION] > 100) flags[kFLAGS.SAPPHIRE_AFFECTION] = 100;
			return flags[kFLAGS.SAPPHIRE_AFFECTION];
		}

		public function canSex():Boolean {
			return flags[kFLAGS.SAPPHIRE_AFFECTION] >= 60;
		}

		public function sapphiremenu():void {
			clearOutput()
			spriteSelect(SpriteDb.s_sapphire);
			outputText("You admit that you were actually looking for her, a response which she seems happy about, as she casually sits next to you and starts conversing.\n\n");
			outputText("\n\n\"<i>So [name] what did you want to talk about?</i>\"");
			menu();
			addButton(0, "This place", TalkThisPlace).hint("Learn about the temple.");
			addButton(1, "Her", TalkHer).hint("How about her?");
			addButtonIfTrue(2, "Sex", TalkSex, "You need to know her better.", canSex(), "Have some sweet time with her.");
			if (!flags[kFLAGS.WEDDINGS_UNLOCKED])
				addButton(3, "Weddings", talkWeddings).hint("Ask if you can have a wedding in the temple.");
			addButton(4, "Back", SceneLib.templeofdivine.templeMainMenu);
		}

		public function TalkThisPlace():void {
			clearOutput();
			spriteSelect(SpriteDb.s_sapphire);
			outputText(" You admit to being curious and Sapphire is glad to tell you about the history of the building. She starts to ");
			if (flags[kFLAGS.TEMPLE_OF_THE_DIVINE_PROGRESS] >= 1) {
				outputText("explain again.\n\n");
			}
			else {
				outputText("explain.\n\n");
				flags[kFLAGS.TEMPLE_OF_THE_DIVINE_PROGRESS] = 1;
			}
			outputText("\"<i>This is the Temple of the Divines. While there are many churches and holy sites across Mareth, this one is the most important of them all. It was built by mortals for the worship of not one deity, but instead all the deities of Mareth. It serves as a neutral ground for everyone, including rival cults.</i>\"\n\n");
			outputText("Curious, you ask about the broken altars and the shattered gargoyles littering the floor. Why is the temple in ruins?\n\n");
			outputText("Sapphire's expression switches to one of anger.\n\n");
			outputText("\"<i>That is the demons doing... This temple is very close to the area were they first started appearing. Their queen's attention was drawn to this place, and the first thing they did was to attempt to destroy and defile it. For the demons, gods are not beings to worship, but rather huge sources of power, only good for corruption and then harvesting. Unfortunately, a god is only as strong as the collective belief of his or her adherents. The most direct way to weaken a deity is by attacking his or her followers and desecrating any consecrated altars.");
			outputText(" I managed to slay the fiends who invaded the place, but not before they did great damage to the temple; so much damage, that it is no longer able to house any divine power. I would repair the damage myself, but sadly as the sole guardian and caretaker I can't leave my post to gather materials like stone and wood, lest the demons use that opportunity to destroy what's left of the temple. Maybe if you were to bring materials and repair the temple's many features, the link to the various gods of Mareth would be restored.</i>\"\n\n");
			outputText("Repairing the temple, eh? Well, that's one thing you could do. You thank her for her time and proceed to head back to camp.");
			doNext(camp.returnToCampUseOneHour);
		}

		public function TalkHer():void {
			clearOutput();
			spriteSelect(SpriteDb.s_sapphire);
			if (flags[kFLAGS.SAPPHIRE_TALKS] == 2) {
				outputText("Now, that some time has passed, you ask her if she is ready to tell you more about the events she foreshadowed in your previous discussion.\n\n");
				outputText("\"<i>It pains me to even think about the events of that day, the day the demons appeared. They poured into the cities below us like a tidal wave, devouring souls and corrupting everything in their path. Eventually they began climbing the mountain, and we knew they would be on our doorstep within hours. To prevent them from destroying this holy ground we devised a plan. No matter what the cost to us, the temple had to be protected. ");
				outputText("As such one by one, we sacrificed ourselves in a ritual to create from us everlasting guardians. I was the last one to be put on the altar. They finished the ritual just as the demons started pouring in. Many desperate enchantments and prayers were put into the creation of each of us, hoping to create a combination by chance that would correctly dispatch the demons. The other gargoyles didn't receive the protections required to face the demons as I did, thus they were destroyed one by one. ");
				outputText("Amidst the chaos, the altars were damaged extensively and rendered useless. As I kept killing more and more of them, they retreated. Satisfied with their dirty work, they just ran away, like the cowards they are, to prevent further casualties.</i>\"\n\n");
				outputText("What of her? Why did the demons spare her?\n\n");
				outputText("\"<i>Their work was done. The numerous altars in the church were no longer able to channel divine powers, and the abbot was captured alive and brought inside the hellhole that is now Lethice's stronghold. I think they simply left because they had no interest in getting slaughtered by a being they could not corrupt or destroy. With everyone gone or dead, it feels so lonely in this place now.</i>\"\n\n");
				outputText("You thank her for her time and walk back to camp.");
				flags[kFLAGS.SAPPHIRE_TALKS]++;
			}
			if (flags[kFLAGS.SAPPHIRE_TALKS] == 1) {
				outputText("Didn't she say that she was raised in the temple? Last time you checked Gargoyles were magically constructed creatures that do not age or die. How could she have been raised in the first place?\n\n");
				outputText("\"<i>This isn’t how I used to be. I was once of flesh and blood just like you. I was born in the former capital city, which serves as the main demon base now. My mother was a priestess at the temple, so naturally I became one as well . My childhood was mostly spent learning holy texts and chanting in the chorus. I don't think it was a waste, these lands used to be beautiful before the demon outbreak. At 16, I was among many selected to work directly in the temple of the divine. It was a great privilege. ");
				outputText("I prayed, tended to the temple, and worked under the abbot for many years as a nun. I would have continued to do so had the demons not come. In the end I couldn’t save anyone... I'm sorry, I don't feel like talking about this any further, at least for now. Please, leave me be.</i>\"\n\n");
				outputText("You excuse yourself and leave, returning back to your camp.");
				flags[kFLAGS.SAPPHIRE_TALKS]++;
			}
			if (flags[kFLAGS.SAPPHIRE_TALKS] == 0) {
				outputText("You're curious about her story and decide to ask her.\n\n");
				outputText("\"<i>My story? Well that's nothing special. I have been guarding this place for years, even before the demons came. I was raised here in this temple. I have always had a fascination with gods, Marae in particular. It was only natural for me to become a priestess of her cult. In recent years, I mostly dealt with the occasional thieves and demons that somehow manage to break through the ward. Even then, only a very powerful opponent could manage that.</i>\"\n\n");
				outputText("You ask her how she is able to contend with demons, especially the most dangerous ones.\n\n");
				outputText("\"<i>I understand that my body looks like something more fitting for a whore than a chaste being. My sexual desire is next to zero. As far as I know, I’m as cold as the stone I'm made from. Therefore, demons have a very difficult time getting me to even start being aroused. As arousal and black magic is their main weapon, I’m pretty much the worst opponent they could encounter.</i>\"\n\n");
				outputText("You thank her for her time and proceed to head back to your camp.");
				flags[kFLAGS.SAPPHIRE_TALKS]++;
			}
			if (flags[kFLAGS.SAPPHIRE_AFFECTION] < 60)
				sapphireAffection(20); //raise until pre-sex cap
			if (flags[kFLAGS.SAPPHIRE_TALKS] == 3) flags[kFLAGS.SAPPHIRE_TALKS] = 0;
			doNext(camp.returnToCampUseOneHour);
		}

		private function talkWeddings():void {
			clearOutput();
			outputText("You would like to have a wedding here at the temple. Would this pose a problem?\n\n");
			outputText("\"<i>Certainly not. I would even gladly put on the mantle of priestess for the event. ");
			if (!flags[kFLAGS.TEMPLE_OF_THE_DIVINE_MARAE]) {
				outputText("However, with the altar of Marae in this state, I cannot formally operate the ritual of the sacred vow. If you repaired the altar, I would definitively see to it that those two fortunate souls be united.");
				outputText("</i>\"\n\nWell... time to get back to rebuilding then.");
			}
			else {
				outputText("Also, thanks to your assistance, the temple has a functional altar now, and thus I can perform the sacred rites in accordance to traditions. Be wary though, that during the rites, the temple defences will be down. Should the demon decide to attack, you may have to handle the wedding crashers.");
				outputText("</i>\"\n\nYou will keep that in mind. On this, you thank her for her assistance. She bows.");
				outputText("\n\n\"<i>Anytime champion.</i>\"");
				flags[kFLAGS.WEDDINGS_UNLOCKED] = 1;
			}
			doNext(camp.returnToCampUseOneHour);
		}

		public function TalkSex():void {
			clearOutput();
			if (flags[kFLAGS.SAPPHIRE_AFFECTION] < 100) {
				sapphireFirstTime();
				return;
			}
			outputText("Sapphire looks at you expectantly her tail agitated by the excitement of potential physical release.\n\n");
			outputText("\"<i>Feeling antsy? How would you like us to do it then?");
			if (player.isGargoyle()) outputText(" There’s even running water if we ever need... something slippery.");
			outputText("</i>\"\n\n");
			sceneHunter.print("Most scenes have variations for Gargoyle PC.");
			menu();
			if (player.lust > 33) {
				addButtonIfTrue(0, "G.D.Tailfuck", SapphireGargoyleDoubleTailfuck,
					"Req. to be a gargoyle and have a vagina.",
					player.isGargoyle() && player.hasVagina(),
					"Let's put these tails to use.");
				if (flags[kFLAGS.ONYX_PATH] > 0)
					addButtonIfTrue(1, "T.T.Ouroboros", SapphireTripleTailOuroboros,
						"Req. to be a gargoyle OR have a long (naga/lizard/draconic/salamander) tail.",
						player.isGargoyle() || player.isNaga() || player.tailType == Tail.LIZARD || player.tailType == Tail.DRACONIC || player.tailType == Tail.SALAMANDER,
						"How about you all uses your tails to get eachother off?");
				else addButtonDisabled(2, "???", "Sapphire needs a friend. Maybe another gargoyle will suffice?");
				addButton(2, "MutualMast.", SapphireMutualMasturbation).hint("Help both you and her soothe that itch.");
				if (player.hasCock()) addButton(3, "FuckHer", SapphireFuckHer).hint("Let's plunder that stony cavern of hers.");
			}
			addButton(4, "Back", sapphiremenu);
		}

		public function sapphireFirstTime():void {
			clearOutput();
			if (!recalling) outputText("<b>New scene is unlocked in 'Recall' menu!</b>\n\n");
			outputText("She said that she is sexually dead. That’s something very rare on Mareth, considering the number of lunatics who spend their day fornicating even in the most pure pockets of the world.\n\n");
			outputText("\"<i>Don’t think of it that way, I never said I couldn't feel it, just that my desires are deadened. I don't actually feel the need at all, although, like just anyone, I can have a good time. My body won't feel it unless I desire it. And since i've never been in love before...</i>\"\n\n");
			outputText("Oh, so she can actually enjoy sex? What about you? Would she like to empty many years of sexual frustration on you?\n\n");
			outputText("\"<i>Look I haven’t played with myself in several years and unless you... wait what the hell are you doing!</i>\"\n\n");
			outputText("While she is distracted, you surprise her with a hug and start kissing her. Weirdly enough Sapphire doesn't seem to hate it, actually she reacts quite favorably to it, only breaking the kiss several seconds later. Perhaps she just needs a reminder of how it can feel?\n\n");
			outputText("\"<i>That... was not something I expected. I guess it's the result of many years living alone in this temple. I'm a person too, it’s just that I had forgotten how sweet it feels to indulge into a kiss let alone love. Maybe it's the fact that you’re the first living person to come here, listen to me and actually even care so much about my problems. Can we... can we continue further? I would like to...</i>\"\n\n");
			outputText("You silence her, placing your finger to her stone lips, pulling her to the cold stone floor, and saying \"<i>Shhh it will be alright...</i>\" as you slowly lower your other hand down to the former priestess’ pussy. She coos as you slowly insert a finger inside and gently massage her.\n\n");
			outputText("\"<i>Aaaah! It's been such a long time since I...I didn't get to enjoy.. such simple pleasures... please don’t stop!</i>\"\n\n");
			outputText("You proceed to masturbate her for several minutes. Her stone body hugging you tightly all the while, as she proceeds to get you off in the same way. Both of you toy with each others body until finally you reach your peak and climax, soaking the ground and your gargoyle partner with your fluids.\n\n");
			outputText("Sapphire would blush if she could however she’s frozen in a post orgasm rigor mortis, her expression seems to be as close to happiness as one can be. After a minute, she recovers mobility.\n\n");
			outputText("\"<i>Thanks for letting me discover again what it is to be a woman. Please come back more often, it feels empty in the temple without you around.</i>\"\n\n");
			outputText("You smile, leaving her embrace as you promise to come back and visit.\n\n");
			if (!recalling) {
				sapphireAffection(100); //jump to max - failsafe.
				doNext(camp.returnToCampUseOneHour);
			}
			else doNext(recallWakeUp);
		}

		public function SapphireGargoyleDoubleTailfuck():void {
			clearOutput();
			spriteSelect(SpriteDb.s_sapphire);
			outputText("You check Sapphire’s tail then look at yours. An idea sparks in your mind as you tell Sapphire to get on all fours.\n\n");
			outputText("\"<i>I don't know what’s on your mind, but I'm very curious to try it now.</i>\"\n\n");
			outputText("She complies, and you go to her backside, positioning yourself to have your [ass] facing hers. You tell her to entwine her tail around yours, then insert her tip in your pussy. She gets the hint as you proceed to do the same with hers. Now, having both of your tail tips in each others pussies, you tell her to move forward and backward. She yelps in surprise as you do the same, both of your tails sliding in and out of each other's pussies at a decent rhythm. Gosh truth be told you are enjoying your tail just as much as your pussy right now. It’s like discovering you had a " + (player.gender == 3 ? "third" : "second") + " sexual organ all along. It feels very similar to a cock in a way");
			if (player.gender == 3) outputText(", maybe even better than a cock");
			outputText(", at this rate you will develop a tail fetish.\n\n");
			outputText("You fuck each other passionately, drawing closer, then moving apart, making both of you moan in delight at this intense mutual penetration. This is like fucking and getting fucked at the same time… simply perfect. By all means you don’t know anymore whether you will cum from your tail or from your pussy.\n\n");
			outputText("After a fair hour of constant sex, the pair of you finally orgasm, and you both fall on the ground tails still tangled up and petrified in pleasure. You wake up a few minutes later tail still in each other pussy and completely satisfied. You get back your gear and wave a goodbye to Sapphire as you head back to camp.\n\n");
			player.sexReward("no");
			doNext(camp.returnToCampUseOneHour);
		}

		public function SapphireTripleTailOuroboros():void {
			clearOutput();
			spriteSelect(SpriteDb.s_sapphire);
			outputText("You think it over then remember about [onyx name] being there too. The third gargoyle must be starving for sex. Unable to decide, which one you want to fuck or get fucked by, you propose the lot of you tail fuck each other, something to which your two stony mates are more than happy to agree. You all sit in a perfect triangle, positioning your tails appropriately and smiling in anticipation for a threesome that will go down in history.\n\n");
			outputText("You begin by kissing Sapphire then exchanging with [onyx name] the tree of you taking turns in order to feel each other's properly. You are not surprised to discover that out of the three of you [onyx name] is the best kisser. Once you all are suitably aroused you playfully insert your tail in Sapphire’s pussy as she positions hers over ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("Krystal’s waiting cunt");
			else outputText("Onyx’s rock hard dick");
			outputText(". Not to be left unstimulated you welcome [onyx name]’s tail ");
			if (player.gender == 2 || player.gender == 3) outputText("in your ready snatch");
			if (player.gender == 3) outputText(" and ");
			if (player.gender == 1 || player.gender == 3) outputText("around your throbbing [cock]");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText(". Krystal giggle");
			else outputText(". Onyx chuckle");
			outputText(" at the anticipation of [onyx eir] privates being played with.\n\n\"<i>Oh [name] this is gunna be so much fun!</i>\"\n\n");
			outputText("You count to ten, and the three of you begin tail teasing each other, making a chorus of moans sapphire tigh vagina gripping your tail.\n\n");
			outputText("\"<i>Oh my gosh [name]!!... this feeling is aaahh...Aaaaaaahhhn!!! Fuck meee fuck my brain out!</i>\"\n\n");
			outputText("This was an understatement, Sapphire’s cunt is pretty much eating your tail and although it does not produce any form of lubrication, her rough stone skin slides perfectly against yours, the friction creating heat ");
			if (player.isGargoyle()) outputText("and sparks ");
			outputText("inside her vagina like a wet stone and making you gasp at the caressing of your tail tip. Gosh your tail is feeling so good, you wouldn’t even mind it if the rest of your body was left unattended!");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText(" Krystal seems to be locked in a blissful dreamy expression of her own");
			else outputText(" Onyx seems to enjoy the feeling of his cock");
			outputText(" as [onyx ey]");
			if (player.gender == 1 || player.gender == 3) outputText(" jerks");
			if (player.gender == 3) outputText(" and");
			if (player.gender == 2 || player.gender == 3) outputText(" penetrates");
			outputText(" you masterfully. Your ");
			if (player.gender == 2 || player.gender == 3) outputText("pussy is alight with pleasure");
			if (player.gender == 3) outputText(" and your ");
			if (player.gender == 1 || player.gender == 3) {
				outputText("rock hard cock is pulsing from [onyx eir] ministration");
			}
			outputText(" making you moan in complete bliss. Truth be told, you don’t know how long you will hold out until you reach your peak and lose control. Your tail is not any less sensible than your ");
			if (player.gender == 2 || player.gender == 3) outputText("pussy");
			if (player.gender == 3) outputText("or your ");
			if (player.gender == 1 || player.gender == 3) outputText("cock");
			outputText(", it quakes in Sapphire hot cunt from the constant pleasure of penetration and touch, squirming and feeling for Sapphire every hot spots just like a cock, only increasing Sapphire own delight. The tempo accelerate as the sound of rock grinding against rock and heavy panting assisted with moans fills the temple. Soon the three of you lock in a silent scream as you all orgasm together, ");
			if (!player.isGargoyle()) outputText("Sapphire and [onyx name] ");
			outputText("freezing in the characteristic immobilism related to a gargoyle's stone form as you all lose consciousness from the intense fuck. ");
			if (player.isGargoyle()) {
				outputText("Anybody finding the three of you right now would think the artists of the temple were serious perverts carving a trio of statues fucking");
				if (flags[kFLAGS.ONYX_GENDER] == 2 || flags[kFLAGS.ONYX_GENDER] == 3 || player.hasCock()) outputText("(if a male present) and jerking");
				outputText(" each other.\n\n");
			}
			else outputText("You regain your sense faster than your two stony friends. Mainly because you can’t petrify from pleasure like they do.\n\n");
			if (player.isGargoyle()) {
				outputText("The three of you come to way later, somewhat aware of having frozen for several hours. You proceed to break out from the other two as they do the same, still smiling after this incident. Sapphire and [onyx name] nod as you propose that you should have that kind of bonding more often.\n\n");
				player.sexReward("no");
				doNext(camp.returnToCampUseFourHours);
			}
			else {
				outputText("You proceed to break out from the other two still locked in their stone form. Sapphire and [onyx name] are still frozen in time, but you guess from their looks that they will want to do this again.\n\n");
				player.sexReward("no");
				doNext(camp.returnToCampUseOneHour);
			}
		}

		public function SapphireMutualMasturbation():void {
			clearOutput();
			spriteSelect(SpriteDb.s_sapphire);
			outputText("Unable to decide on a position you decide to help the temple guardian blow some steam by fingering her. Both of you sit down next to each other, and you open the games by kissing Sapphire.");
			if (player.isGargoyle()) outputText(" While neither of you actually have saliva, the feeling of her stone rugged tongue against yours is quite good.");
			else outputText(" Her mouth lacking fluids is a weird experience at first but once her tongue is slick with your saliva it starts to feel like anyone else’s, albeit her tongue is slightly longer.");
			outputText("\n\n\"<i>I didn’t get to kiss anyone until you came, so I never had any idea it felt this nice. Would you...</i>\"\n\n");
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
			else outputText(" Not so surprisingly Sapphire has no fluids of her own, but you give her plenty as your genitals splash her nethers. Sapphire own orgasm cause her to petrify and harden into rigor mortis.");
			outputText(" It takes a few minute before ");
			if (player.isGargoyle()) outputText("you both");
			else outputText("she");
			outputText(" unfreeze and break the embrace, as she removes her stony tail from your private.\n\n");
			outputText("You smile, leaving her embrace as you promise to come back and visit.\n\n");
			player.sexReward("no");
			doNext(camp.returnToCampUseOneHour);
		}

		public function SapphireFuckHer():void {
			clearOutput();
			spriteSelect(SpriteDb.s_sapphire);
			outputText("Her pussy lips shine polished gems, and you can’t stop your cock from hardening in prospect of the gargoyle waiting folds.\n\n");
			outputText("You begin to gently pull sapphire into a kiss as you lay her over the nearest altar. Sapphire tongue is actually quite skilled for someone who barely discovered the joy of sex. You entwine and seek each other's out for a few minute caressing the gargoyle smooth stone skin with your hand. Sapphire gasp as your fingers trace the outline of her perfectly sculpted curves.\n\n");
			outputText("\"<i>Ahhhn [name] I...mmm</i>\"\n\n");
			outputText("You tease her skin for a while then get down to business exposing your [cock] to the temple cold air. You shiver for a moment but this is only momentaneous as your tips finds the entrance to sapphire warm canal slowly pressing against it. Sapphire gasp as you gently press your tip near her tight folds not going in yet.\n\n");
			outputText("\"<i>P..please [name] do not make me wait anymore I...I can’t..</i>\"\n\n");
			outputText("You finally decide to oblige her, her eyes going wide as you plunge in as far as you can go burying your length into her tight pussy. As a creature made of living stone, you should have guessed by now, her cunt wouldn't be the most flexible. It squeezes on your cock like a vice. Sapphire's long tongue is lolling out, and she pants slowly this must be quite the experience for her. ");
			outputText("You begin to slowly slide in and out of her your gargoyle lover arms and legs locking you in a tight grip as pleasure overtake her. You are unlikely to escape for as long as she is not satisfied. Her tight crazy cunt attempts to milk you for all its worth, and soon you find yourself on the verge of orgasm.\n\n");
			if (player.isGargoyle()) {
				outputText("Sapphire and you make a high-pitched screech as she clamps on your [cock], her cunt pulsing as you fuck her with wild abandon, pulling your penis in and out at high speed. The sound of two wet rock sliding against each other echoes in the temple. Sapphire, on her side, keeps mercilessly milking your cock forcing you both to pass through several orgasms until you reach your final peak, petrifying together into a complete pleasure addled expression. ");
				outputText("The two of you stay somewhat unconscious a fair hour the pleasure echoing into the core of your very being before you regain mobility your cock sliding out of her cunt with the sound of grinding stone.\n\n");
				outputText("\"<i>Mmmm that sure was one hell of a ride to heaven [name] I hope we will do this again some other time.</i>\"\n\n");
				outputText("You nod still mouth gaping from the feeling of your cock and gear up as you head back to camp.\n\n");
			}
			else {
				outputText("Sapphire makes a high-pitched screech as she clamps on your [cock], her cunt pulsing as you fill her with your load painting her stone insides with your cum. You try to slide out, but she is far too gone to let you go and keeps mercilessly milking your cock, forcing you to pass through several orgasms until she reaches her final peak, petrifying into hard stone. ");
				outputText("To your dismay, your cock is buried hilt deep into her, and you wait a fair hour before she regains mobility. Cum is flowing out of her cunt as she slides off.\n\n");
				outputText("\"<i>Oops... I got carried away. I hope you don’t mind [name].</i>\"\n\n");
				outputText("You nod absentmindedly and gear up as you head back to camp.\n\n");
			}
			player.sexReward("no");
			doNext(camp.returnToCampUseOneHour);
		}
	}
}