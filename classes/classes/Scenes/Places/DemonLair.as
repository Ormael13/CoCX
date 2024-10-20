/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Places 
{
import classes.*;
import classes.BodyParts.*;
import classes.GlobalFlags.kFLAGS;
import classes.Races.DemonRace;
import classes.Scenes.SceneLib;
import classes.Stats.Buff;
import classes.display.SpriteDb;

import coc.view.ButtonDataList;

public class DemonLair extends BaseContent
	{
		
		public function DemonLair() {}
		
		public function questProgressScenes():void {
			clearOutput();
			if (player.statusEffectv1(StatusEffects.MeetXuviel) == 3) {
				outputText("You feel the pull of Xuviel’s necklace again and head to him. Your pussy drooling knowingly in anticipation, despite your terror. You can’t help but think about what abuses the fiend will subject you to this time.\n\n");
				outputText("You’re back in the throne room. Seems the demon lord didn’t feel like having you join him in his bedroom this time. Xuviel grins as he sees you enter the room, his harem chuckling at your approach.\n\n");
				outputText("\"<i>It’s a pleasure to see you, [name]. The girls were actually talking about your latest performance, most impressive.</i>\"\n\n");
				outputText("You ponder whether he's talking about how you handled "+(SceneLib.dungeons.checkFactoryClear()?"marae and the factory":"your latest opponent")+" or about what you did to his… actually, you’re very keen on forgetting that. Xuviel teases you further.\n\n");
				outputText("\"<i>Still too weak-willed to get rid of my necklace? I must say I’m amazed, [name], you really are the best. Both at cocksucking and heroing about.</i>\"\n\n");
				questProgressScenes09();
			}
			if (player.statusEffectv1(StatusEffects.MeetXuviel) == 2) {
				outputText("Instead of going to your destination you feel Xuviel forcefully pulling you again toward his lair, your pussy instinctively drooling in anticipation despite your terror. You can’t help but worry about what the fiend will do to you this time.\n\n");
				outputText("The silver gate opens for you yet again as you head for a different room. This seems to be Xuviel’s master chamber, decorated with red drapes and a large bed fit for 4 people if need be. The demon in question is currently sitting on a chair in a nightgown holding what seems to be a glass of wine. Upon your entry, he soon acknowledges your presence.\n\n");
				outputText("\"<i>Good evening [name]. I have been waiting for you.</i>\"\n\n");
				outputText("Xuviel motions for you to move toward the bed, and naturally, your body obeys him like a puppet.\n\n");
				outputText("\"<i>You know, [name], I see and witness your everyday challenges. It does not suit a woman of your quality to simply live in the waste like this. No, not in the least… Yet I can see it in your eyes, despite all I could offer you, you hate me, you despise me. If I gave you free rein and a weapon right now you would definitely go for my throat. Oh I do love those defiant eyes of yours.</i>\"\n\n");
				outputText("Of course you do. This asshole is playing you like a marionette and forces you to do as he pleases. Why wouldn’t you hate him!?\n\n");
				outputText("\"<i>Still, the truth is if you wanted to be free of me you would have done so a long while ago. Oh, I can see it in your eyes, you did consider the option, yet never sought freedom. Do you know why that is? I sure do. Curiosity, you are curious about what will happen, all while denying what your mind and body have truly come to desire, which is the delights and pleasure that only I can provide. Perhaps even you get off from said abuse… a small tinge of masochism?</i>\"\n\n");
				outputText("He gently brings the cup your chin, staring you straight in the eyes with an amused expression.\n\n");
				questProgressScenes05();
			}
			if (player.statusEffectv1(StatusEffects.MeetXuviel) == 1) {
				outputText("Instead of going to your destination, an unknown force pushes you in a different direction. You know where you are going the moment you see the silver door again, your pussy instinctively drooling in anticipation, despite your terror.\n\n");
				outputText("This time you walk to what looks to be a dining room. Xuviel is casually sitting by the table eating what seems to be "+(((player.itemCount(consumables.LETHITE)+player.itemCount(consumables.LETH1TE)+player.itemCount(consumables.LETH2TE)+player.itemCount(consumables.LETH3TE))>0)?"lethicites":"purple crystals")+" and he greets you the moment you arrive.\n\n");
				outputText("\"<i>Oh, [name], how wonderful of you to join my table tonight. Please, have a seat.</i>\"\n\n");
				outputText("You mention to your host that you didn’t join him, he forced you to come over.\n\n");
				outputText("\"<i>Oh the intent means little, all that matters is that you are here.</i>\"\n\n");
				outputText("On your plate is what could pass for a strange creature. Its body is similar to a large eel but its head is like the tip of a cock.\n\n");
				outputText("\"<i>Today's meal for you is an Eel schlong, do not forget to use the sauce. I prepared all of this just for you!</i>\" he proudly exclaims.\n\n");
				outputText("He waves to a nearby saucer and your hands mechanically move to it. The smell is salty and musky, if not enticing… Did he seriously fill the saucer full of cum? You watch, torn between arousal and confusion, as you pour the ‘sauce’ on the eel. An errant thought passes through your mind as to what the fiend aims for you to do. It is all fully revealed when you begin to remove your clothes. You reposition yourself on the chair so that your [pussy] faces the plate. ");
				outputText("This must be the mouth Xuviel truly intends for you to feed with. The eel slowly slithers from the plate, its fat head aligning with your ready hole. You beg it to stop, but to no avail, as the thing hisses and shoves itself right into your pussy. You scream in horror and pleasure as the thing pushes into your body inch by inch, leaving your legs weak on the chair. ");
				outputText("The demon’s cum isn't helping either, as it not only acts as a lube when mixed with your abundant juices but also as an aphrodisiac, your head filling with pink-tinted lusty thoughts as the thing ravages your cunt. Xuviel watches the spectacle, unphased as though this is all normal, and addresses you like you would a ‘guest’ to your table.\n\n");
				outputText("\"<i>I'm glad you are enjoying your meal, [name]. These creatures are the products of alchemy mixed with dark magic and I wouldn’t have been happy had your mouth not been devouring it so voraciously. These will be very important for your growth.</i>\"You want to voice him back a blade sharp reply for this but your mouth is too busy moaning from the sensation of your lower mouth to formulate anything coherent. \n\n");
				outputText("You can feel the eel's fat head stretch your walls as it goes in and then scrapes those same vaginal walls with its crown as it pulls back, roughly but easily grazing upon nerve endings in your pussy that have never been touched before. Such a thorough treatment of your cunt makes it nigh unbearable to not just give in to whatever Xuviel wants. Xuviel, in response to your babble, gives you a coy reply.\n\n");
				outputText("\"<i>My my, don’t you look to be enjoying this. But to fully savor it, I would have you drink this brew of mine. Please, quench your thirst.</i>\"\n\n");
				outputText("You don’t want to but your hand grabs the glass anyway, forcing you to drink. Well, that’s weird, you expected the drink to taste like something but it's bland like water. Your confusion doesn’t last long however as the taste of cum rushes to your mouth. Wait… you never had cum in your mouth to begin with! You finally realize what's going on as your lower mouth drools clear drops of fresh cum. Did the thing cum inside you so hard you can now taste it with your pussy? Xuviel brushes your concern aside with the back of his hand.\n\n");
				outputText("\"<i>Get used to it. This potion I made you drink will allow you to taste a dick in your love hole just as well as you would in your mouth so that you can fully savor and enjoy the taste of my fresh cum in whatever hole it goes. This is just the beginning, however, do not worry, I will have tons of cocktails for you yet my dear. That said, those effects are not permanent… not yet. I will need you to drink your medicine everytime we meet to prolong those effects until they are.</i>\"\n\n");
				outputText("Xuviel slowly sips a cup of wine as your pussy devours the eel inch by inch. Gosh, it’s way past your cervix now. Some of it even made it to your womb and your belly’s inflated from it. Thankfully the chair is both heavier and bigger than you or you would have tripped over. You lay down and try to relax as the last of the eel tail disappears into your cunt with a wet ‘shloop’, its entire length now inside of you. ");
				outputText("Your eyes cross as your tormented pussy finally gushes a torrent of mixed fluid on the ground. Something's not right, instead of staying like this your belly begins to shrink. To your surprise, you go back to your original shape. Where did the thing go?! Xuviel doesn’t seem as worried as you are.\n\n");
				outputText("\"<i>You absorbed it, of course, corruption and all. This creature was made out of raw corruption via alchemy, you may think of it as a gift from me.</i>\"\n\n");
				outputText("Your body indeed seemed to have soaked in corruption as your form changes, becoming more voluptuous as a response.\n\n");
				if (player.butt.type < 9) player.butt.type = 9;
				if (player.hips.type < 12) player.hips.type = 12;
				if (player.biggestTitSize() <= 20) {
					var how:Number = 20 - player.biggestTitSize();
					player.growTits(how, 1, false, 3);
				}
				outputText("You watch yourself in disbelief and Xuviel chuckles at what's happening to you.\"\n\n");
				outputText("\"<i>You may go, I will call you back later.</i>\"\n\n");
				outputText("On this, he snaps his fingers as you lose consciousness. When you wake up, you are back in your camp. Whatever Xuviel is doing to you, it’s getting worse. Something tells you this will end poorly but at the same time, you’re almost anxious about what he will do to you next.\n\n");
				if (player.statusEffectv3(StatusEffects.MeetXuviel) > 1) {
					dynStats("cor", 5);
					dynStats("lib", 5);
					dynStats("sens", 5);
				}
				else {
					dynStats("cor", 10);
					dynStats("lib", 10);
					dynStats("sens", 10);
				}
				player.addStatusValue(StatusEffects.MeetXuviel, 1, 1);
				player.addStatusValue(StatusEffects.MeetXuviel, 2, 7);
				endEncounter();
			}
			if (player.statusEffectv1(StatusEffects.MeetXuviel) == 0) {
				outputText("You feel a strange pull compelling you to walk in a specific direction. You walk into an increasingly sinister area until you reach what looks like a cave at first glance. Something stronger than your own will compels you to walk inside, and so you do. Torches lining the walls cast light on your passage until you reach a silver ornamented door which opens before you, only to close again once you are in. ");
				outputText("Whoever resides here is both powerful and rich, as this cave is decorated with beautiful vases and precious metal ornaments. You eventually reach what seems to be a throne room. At the opposite side of the room, there appears to be a strikingly comely man whose handsome human features piques your interest for a moment. ");
				outputText("However, upon closer inspection, you see a spaded tail swishing behind him and a pair of small horns jutting from his carefully combed hair, which clearly distinguishes him as a fiend. He’s currently sitting upon his throne. A harem of at least 8 beautiful succubi surrounding him, accentuating his power as a dominant male. He eyes you for a moment as you shiver under his gaze.\n\n");
				outputText("\"<i>Welcome to my home, [name]. I have been expecting you.</i>\"\n\n");
				outputText("He lifts himself off his seat and closes the distance, after which he takes in the scent of your hair, the silken skin of his hand caressing your cheek. Something in you screams to stop him but you are held still by the same mysterious force that compelled you to come here. That and the fact that his caress feels strangely good, leaves you standing there gawking.\n\n");
				outputText("\"<i>Hm… I imagine you are very confused about how and why you walked into my home, let alone who I am.</i>\"\n\n");
				outputText("He steps back, giving you a full display of his immaculately sculpted body.\n\n");
				outputText("\"<i>Since presentations are in order, you may call me Xuviel. I already know your name, Champion of Ingnam. The moment you stepped out of the portal I had my eye on you. Lethice sends most of the village's champions to the factory upon capture but I have a deal with the imp who's on the capture job. Thanks to my arrangements, ");
				outputText("I have first pick on the prisoners should an interesting piece come into the board. That said, you surpassed my greatest expectations and got free before I could even pick you up.</i>\"\n\n");
				outputText("You tell him you have no intentions to stay here and try to ready yourself for a fight but your body refuses to obey you. One of the succubi notices your inner struggle right away and chuckles.\n\n");
				outputText("\"<i>Lord Xuviel, are you sure she will do? If she’s too stubborn we can always send her back to…</i>\"\n\n");
				outputText("Xuviel lifts his left hand signaling her to stop. He does not even bother to look at her.\n\n");
				outputText("\"<i>[name], is exactly what I want... if she was an easy capture I wouldn’t have taken all the trouble to acquire her. Are you questioning me?</i>\"\n\n");
				outputText("The succubus bows her head down submissively. Xuviel must definitely be a demon of great power if all of these succubi are serving him so faithfully.\n\n");
				outputText("\"<i>O...of course not milord.</i>\"\n\n");
				outputText("You growl in frustration, unable to attack the demon head-on. What sorcery is this? Xuviel gives you an amused smile before adding:\n\n");
				questProgressScenes01();
			}
		}
		public function questProgressScenes01():void {
			outputText("\"<i>Besides… I love it when they struggle, it makes bending them all the more fun. Tell me, [name], are you the kind that bends… or breaks?</i>\"\n\n");
			menu();
			addButton(1, "Bend", questProgressScenes03);
			addButton(3, "Break", questProgressScenes04);
		}
		public function questProgressScenes02():void {
			outputText("\"<i>I see, regardless, the end result is the same is it not? "+(SceneLib.dungeons.checkFactoryClear()?"I heard you shut down Lethice’s factory, an amusing feat for someone who barely escaped capture, but again, I knew you had it in you like all of my precious here. ":"")+"Still, I can’t let you out of here without properly training you a little first right? Girls, would you kindly give [name] a taste of your talents? I shall be watching, this is as much a test to her as it is to you.</i>\"\n\n");
			outputText("Xuviel laid back comfortably in his throne to enjoy the spectacle as his harem closes in on you, the succubi licking their lips in anticipation. You desperately try and fight back but the necklace keeps you docile as the girls slowly remove your clothes, their tails tracing your skin in the process. One of them with red hair and tan skin pulls you into a kiss as you are pushed onto the ground with your body on full display. You react with indignation, but the necklace is preventing you from biting. ");
			outputText("All you can do is try to evade her tongue with yours, which ends up being all the more lewder as she always manages to catch it. One demoness is licking your inner thigh, sending shivers along your legs as another tweaks your hardening nipples with her hands. Meanwhile, one succubus managed to insert a finger in your -pussy-, her digit playing your insides as good as any dick would. You stifle a moan of unwanted pleasure as the demons play your naked body like a perfectly tuned violin.\n\n");
			outputText("You hate this, you want to fight back, but the more they tease you the less combative you get. Your body is betraying your mind entirely as your legs begin to buck on their own. The demons won’t let you orgasm so easily, however. The moment you’re about to reach your peak they stop only long enough to let your pleasure die out before starting again. Your pussy is dripping from repeated failed orgasms. ");
			outputText("You feel one of the succubi spitting inside your cunt, her corrupt saliva mixing with your juices and leaving a tingling sensation along your walls. They keep at this for a while, never letting you cum. The stone under you is now wet with your fluids when Xuviel finally decides that enough is enough, casting a swift spell with one of his hands.\n\n");
			outputText("\"<i>You have been a good girl, you may cum now, [name].</i>\"\n\n");
			outputText("Some weird switch in your mind flips and your [pussy] spontaneously explodes with such pleasure that your eyes cross. The succubi moves away from you as your cunt gushes like a fountain with every previously wasted orgasm hitting you at the same time, splattering fluids everywhere. For an entire minute, you stay down on the ground babbling incoherently as your pussy floods the floor with your juices, which drains into a nearby grate. ");
			outputText("You slowly regain control and try to stand, noticing that even after you try and dry your pussy, it still drips fluid constantly. <b>It seems you are now a squirter, always lubricated for fucks!</b>\n\n");
			player.vaginas[0].vaginalWetness = VaginaClass.WETNESS_DROOLING;
			outputText("Xuviel nods at the change as his harem takes back its place around him.\n\n");
			outputText("\"<i>That will be all for today. You are free to go back to your adventures or whatever pointless things you normally do until I call you again, and trust me, I will.</i>\"\n\n");
			outputText("You don’t know what happened next past that point, all you remember is that he waved his hand and you fainted. When you came back to, you were sleeping lazily in your camp. He said he would call you back which means you definitely need to find a way to remove this necklace. On the other hand, your mind longs for the wrecking pleasure your body was subjected to, so perhaps you should indulge him and wait for his call?\n\n");
		}
		public function questProgressScenes03():void {
			outputText("You aren't easily swayed, but his attractiveness and magical powers certainly have an… alluring effect.\n\n");
			questProgressScenes02();
			player.addStatusValue(StatusEffects.MeetXuviel, 3, 1);
			dynStats("cor", 20);
			dynStats("lib", 20);
			dynStats("sens", 20);
			player.addStatusValue(StatusEffects.MeetXuviel, 1, 1);
			player.addStatusValue(StatusEffects.MeetXuviel, 2, 7);
			doNext(camp.returnToCampUseOneHour);
		}
		public function questProgressScenes04():void {
			outputText("You will die or lose your sanity long before he gets you to do anything perverse.\n\n");
			questProgressScenes02();
			player.addStatusValue(StatusEffects.MeetXuviel, 3, 2);
			dynStats("cor", 5);
			dynStats("lib", 5);
			dynStats("sens", 5);
			player.addStatusValue(StatusEffects.MeetXuviel, 1, 1);
			player.addStatusValue(StatusEffects.MeetXuviel, 2, 7);
			doNext(camp.returnToCampUseOneHour);
		}
		public function questProgressScenes05():void {
			outputText("\"<i>Am I right to assume you are secretly enjoying this, [name]?</i>\"\n\n");
			menu();
			addButton(1, "He's right", questProgressScenes07);
			addButton(3, "No way!", questProgressScenes08);
		}
		public function questProgressScenes06():void {
			outputText("Xuviel nods at your reply.\n\n");
			outputText("\"<i>Yes… I figured you would say that. It’s all right, I will assist you in discovering the real you. The one that desires to give yourself, body and soul, to me"+(player.statusEffectv4(StatusEffects.MeetXuviel) > 0 ? "":". To this end, I had yet another mixture prepared just for you")+".</i>\"\n\n");
			if (player.statusEffectv4(StatusEffects.MeetXuviel) == 0) {
				outputText("Xuviel smiles as he retrieves a potion from a nearby cabinet and pours some of the liquid in a cup, offering it to you.\n\n");
				outputText("\"<i>Drink your fill, [name].</i>\"\n\n");
				outputText("Your hands are swift to betray you as you reach for the cup, pouring it into your mouth. As much as you'd like to prevent it, you are forced yet again, to drink one of Xuviel’s sinister concoctions. Your body is feeling incredibly hot now, your skin sensitive and aching for his caress. ");
			}
			outputText("Xuviel’s hands slide on your skin, making you shiver in delight as your body undresses on its own. He removes his own clothes, revealing his girthy 15 inch tool. The moment your hands grab your breasts and squeeze his member between them, you know what's going to happen. Your mouth acts on its own, taking his tip in as you slide his delicious member between your [breasts]. Something feels weird in your mouth, are you feeling pleasure from your tongue? The sensation is captivating, ");
			outputText("drowning your thoughts in a pool of ecstasy… Indeed, each time he thrust his cock in your mouth, you can feel it as if it were a second vagina, with your tongue as a second way larger clit. Your nerves are set aflame with pleasure. It seems like your mouth has turned into a sexual organ of its own! The more you please him, the more you are pleasured, and before long you’re too lost in it to even realize the necklace isn't forcing your body anymore licking and sucking Xuviel’s amazing cock all of your own volition.\n\n");
			outputText("\"<i>Mmmm, you sure are wonderfully skilled with that mouth of yours, [name], bet you’re enjoying yourself too.</i>\"\n\n");
			outputText("Your pussy is drooling all over the ground as your clit-like tongue wraps around his member in an attempt to maximize your pleasure.\n\n");
			outputText("\"<i>Ah, good girl… Here's your reward, try not to spill a drop.</i>\"\n\n");
			outputText("Thrusting further into you, his balls pressing against the underside of your chin, Xuviel floods your mouth and throat with his cum, making you almost choke on it. The excess drool from your mouth drops right onto your breast as you fall, spread eagle on the floor, reaching an oral orgasm which causes your pussy to quiver and gush. You can’t help but swallow what's in your mouth as the excess is slowly absorbed into your skin. "+(player.statusEffectv4(StatusEffects.MeetXuviel) > 0 ? "":"Wait absorbed? "));
			outputText("You can "+(player.statusEffectv4(StatusEffects.MeetXuviel) > 0 ? "":"indeed ")+"taste his cum with your every pore as your lustrous breasts absorb it all inside, your skin seemingly gaining in healthiness as you feel your latent hunger being sated and your energy refilled. "+(player.statusEffectv4(StatusEffects.MeetXuviel) > 0 ? "":"Wow, this is getting ridiculous! How much of a freak did you become to the point of being satisfied and nourished by cum?! ")+"");
			outputText("Xuviel "+(player.statusEffectv4(StatusEffects.MeetXuviel) > 0 ? "":"doesn’t care for your inner battle and ")+"dismisses you, sending you back to camp.\n\n");
			outputText("It is not too late to stop now, those effects are likely temporary, but you’re afraid… and more than slightly excited by what may happen if you let him use you much longer.\n\n");
			if (player.statusEffectv4(StatusEffects.MeetXuviel) == 0) player.addStatusValue(StatusEffects.MeetXuviel, 4, 1);
			if (player.statusEffectv3(StatusEffects.MeetXuviel) > 1) {
				dynStats("cor", 5);
				dynStats("lib", 5);
				dynStats("sens", 5);
			}
			else {
				dynStats("cor", 10);
				dynStats("lib", 10);
				dynStats("sens", 10);
			}
		}
		public function questProgressScenes07():void {
			outputText("He's so right about it. No matter how much you try to deny it, you desire his touch and the tormenting pleasures he offers. Even now, you can’t help but admire his perfect body, fantasizing him toying with you personally. Yet some fear of what might happen holds you from completely giving in and becoming fully his.\n\n");
			dynStats("cor", 5);
			questProgressScenes06();
			player.addStatusValue(StatusEffects.MeetXuviel, 2, 7);
			if (player.cor >= 100) player.addStatusValue(StatusEffects.MeetXuviel, 1, 1);
			doNext(camp.returnToCampUseOneHour);
		}
		public function questProgressScenes08():void {
			outputText("No, he’s wrong! You will keep defying him for as long as it takes until he sets you free!\n\n");
			dynStats("cor", -5);
			questProgressScenes06();
			player.addStatusValue(StatusEffects.MeetXuviel, 2, 7);
			if (player.cor >= 100) player.addStatusValue(StatusEffects.MeetXuviel, 1, 1);
			doNext(camp.returnToCampUseOneHour);
		}
		public function questProgressScenes09():void {
			outputText("He lifts a glass of wine to you and this only angers you more. How dare he mock you, you’re going to make him pay for that! The moment the necklace's control weakens you’re going to give him nightmares for weeks. It’s only as your rage reaches its peak that you finally realize. The pull of the necklace is gone! Perhaps it’s time for revenge but then again if he defeats you he might fix your necklace and you may never get such a chance to strike back at him again. ");
			outputText("Heck the necklace weakening now might just be a trick from him in order for you to let your guard down and do something foolish. Do you use this opportunity to flee or attack him?\n\n");
			menu();
			addButtonIfTrue(1, "Assault", questProgressScenes11, "You're pernamently transformed!!!", !player.blockingBodyTransformations());
			addButton(3, "Run", questProgressScenes10);
		}
		public function questProgressScenes10():void {
			outputText("Striking him down in your current state of mind and body is downright foolishness. There's no telling how it might end! No, you ought to run while you can and get this necklace off by any means necessary!\n\n");
			outputText("As you run for the exit, you hear Xuviel’s mocking voice behind you.\n\n");
			outputText("\"<i>Run.. yes, run however long you want [name], inevitably you will come back here of your own volition! You belong to me body and soul, you just don't know it yet.</i>\"\n\n");
			doNext(camp.returnToCampUseOneHour);
		}
		public function questProgressScenes11():void {
			outputText("You smirk at Xuviel, dash at him, grab him, and then pull him off his chair. You growl. For every minute he raped you, you’re going to punish him, for every shame he inflicted upon you, you’re going to shame him, an eye for an eye. You forcefully pull him to the ground, but the demon is still smirking. Gosh, you’re going to erase that awful smile right away. With rage, you yell at him what you think of his attitude!\n\n");
			outputText("<i>You will not be controlled by this asshole. You will not be his bitch forever! You are nobody’s slave, let alone his! Now, you will show him what happens when one stoops so slow as to attempt to dominate your entire mind.</i>\n\n");
			outputText("You fiercely grab his cock with your hand and shove it between your breasts. The thought of raping Xuviel back for all the shit he inflicted upon you has you in complete euphoria as you proceed to lick his dick with a vengeful smile. Damn it feels so good to finally be in control, but with that said, his cocky expression still hasn’t disappeared, which enrages you further. You proceed to suck on his delicious tool, wrapping your breasts around the base and pumping in an attempt to force a moan or a wince from him but the demon just keeps smirking. ");
			outputText("Oh really? Now he thinks you will just sit there and lick him? Well you got other plans for him! While the taste of his precum and the sensory feeling in your mouth is delightful, it’s with your lower mouth that you want to devour him whole. You pull his demonic cock out of your devilish mouth and proceed to spread your vaginal lips open with two fingers, displaying your dripping pussy for him so he knows exactly what you’re going to do.\n\n");
			outputText("<i>You’re going to wipe that disgusting fucking smile off his face!</i>\n\n");
			outputText("Ah! Even his harem is watching now and they stare as you rape their master, which only makes you all the more hornier. You slowly slide down on his cock allowing yourself to sigh in delight as inch after inch of his tool fills your hungry pussy, you can even taste his precum with your vaginal walls and hell, this guy’s cum tastes good! Unable to hold yourself any longer, you begin to slowly slide along his length, torturing both his cock and your pussy with the slowest pace you can muster. Xuviel smirks at you and finally gives you the first reply since you started assaulting his dick.\n\n");
			outputText("\"<i>Yes yes, embrace your hatred, [name]!</i>\"\n\n");
			outputText("You’re going to show you hate him with every fiber of your body! You begin to accelerate the pace, forcing dollop after dollop of his delicious corrupted precum right into your pussy. You moan in delight as you finally see the signs of his own impending climax, his frustrating smile slowly fading from his face. You’re going to erase it… fuck him until all that's left is a gaping mouth moaning for pleasure! ");
			outputText("You and Xuviel begin moaning in unison as you do your damnedest to pull him to his climax! After a while, his cock finally begins to ripple with the telltale sign of his impending orgasm as you ready for your own. Xuviel however, despite your incoming victory, keeps sneering at you.\n\n");
			outputText("\"<i>Not bad, girl… that said, I’d advise you to look down between your legs…</i>\"\n\n");
			outputText("Something feels wrong, and you look down in horror to see a mysterious liquid dripping out of your pussy. It's a puddle of black fluids that’s unlike anything you've ever seen before, and you can feel its corruption seeping into your body. That’s when the realization that you have been doing exactly as the demon wanted hits you.\n\n");
			outputText("That’s not… It’s impossible, right?\n\n");
			outputText("You try to crawl away from him but your pleasure- legs are unable to bring you farther than a meter before Xuviel grabs you from behind.\n\n");
			outputText("\"<i>You wanted me to cum, [name], so let’s not stop when I’m so close to it, shall we? I wanted to see how long it would take you to willingly seek out my dick with your cunt. After all so long as you were pure and resolute there is no way you would willingly impale yourself on my dick right? The truth is your soul is now dyed so black with corruption that you can't see the difference between friends and foe… don't you worry I've been watching all the stuff you've been doing. ");
			outputText(""+(camp.slavesCount() > 0?"You even started collecting some slaves of your own, you kinky slut. Perhaps you are secretly a sadomasochist? Or maybe you envy my control so much you wanted pets of your own. Don't you worry once you're fully mine I will spoil you rotten with as many sex slaves as you want. ":"")+"This is the true you, the naughty girl unrestrained by morality that wishes only for her own pleasure and fun.</i>\"\n\n");
			outputText("You beg him to stop and let you leave, but it's too late now. The moment his cock enters your [pussy] again, pleasure locks you in place as your body betrays you, Xuviel’s now proving he’s the true master of this territory. Like a key to a lock, Xuviel unholy cock fits your cunt and unlocks every hidden pleasure your brain could ever dream to process. How foolish you were to challenge a demon on his own battlefield, let alone this one!\n\n");
			outputText("\"<i>So you finally understand, [name], you were never truly free from me, it’s the reverse: you desire my touch and even more than anything, my cum to the point that the necklace is no longer necessary to keep you pliant. Well, allow me to properly reward you for your blind devotion to your beloved master.</i>\"\n\n");
			outputText("He's right… you definitely desire him, it just took your mind a long time to reach the conclusion your body had already accepted. There is a very thin barrier between love and hate. Normally people take it the other way around, but after a while you end up not only desiring the pleasure he gives you, but also his own! Each trust of his fat, awe inspiring member teaches your flesh just that. Xuviel laughs as his cock unloads a massive amount of corrupted cum right into your pussy, ");
			outputText("sending you straight to your climax as your blasphemous cunt devours every drop of it, absorbing it into your being. You feel something drip between your legs as your mind goes blank. Something breaks within you as you feel your juice flow from the multiple consecutive orgasm Xuviel’s unholy sperm provides you, your entire body spasming like a sexual organ as corruption soaks your entire being. You don’t know how it happened but when you finally come to your senses you take notice of something on the perfectly polished ground.\n\n");
			if (player.hasCock()) player.lowerBody = LowerBody.DEMONIC_CLAWS;
			else {
				if (rand(2) == 0) player.lowerBody = LowerBody.DEMONIC_CLAWS;
				else {
					if (rand(2) == 0) player.lowerBody = LowerBody.DEMONIC_HIGH_HEELS;
					else player.lowerBody = LowerBody.DEMONIC_GRACEFUL_FEET;
				}
			}
			player.legCount = 2;
			if (player.biggestTitSize() <= 28) {
				var how:Number = 28 - player.biggestTitSize();
				player.growTits(how, 1, false, 3);
			}
			player.skin.setBaseOnly({type:Skin.PLAIN, color1:"blue", pattern: Skin.PATTERN_DEMONIC_PLEASURE_RUNE});
			if (!InCollection(player.skinColor1, DemonRace.DemonSkinColors) && !InCollection(player.skinColor2, DemonRace.DemonSkin2Colors)) {
				var choice1:String = randomChoice(DemonRace.DemonSkinColors);
                var choice2:String = randomChoice(DemonRace.DemonSkin2Colors);
                player.skinColor1 = choice1;
                player.skinColor2 = choice2;
			}
			if (rand(2) == 0) player.skinColor1 = "pink";
			transformations.TailDemonic.applyEffect(false);
			transformations.HairHuman.applyEffect(false);
			transformations.FaceDemon.applyEffect(false);
			transformations.EyesDemon.applyEffect(false);
			transformations.ArmsDemon.applyEffect(false);
			transformations.TongueDemonic.applyEffect(false);
			transformations.EarsElfin.applyEffect(false);
			transformations.HornsDemonic.applyEffect(false);
			transformations.AntennaeNone.applyEffect(false);
			transformations.GillsNone.applyEffect(false);
			transformations.WingsDemonicLarge.applyEffect(false);
			transformations.RearBodyNone.applyEffect(false);
			if (player.hasCock()) player.killCocks( -1);
			if (player.hasBalls()) {
                player.balls = 0;
                player.ballSize = 1;
			}
			if (player.hasVagina()) transformations.VaginaDemonic().applyEffect(false);
			if (!player.hasPerk(PerkLib.Soulless)) {
				player.createPerk(PerkLib.Soulless, 0, 0, 0, 0);
				player.npcsThatLeaveSoullessPC();
			}
			outputText("A breathtakingly beautiful woman with "+player.skinColor1+" skin stares back at you. She has a jaw-dropping face crowned by "+player.hairColor+" hair. She dons a pair of supple " + player.breastCup(0) + " sized breasts, which hypnotically seems to draw your stare down. Her body seems shaped in every way to tempt men yet what stands out is the horns, graceful bat-shaped wings and that long sinuous spaded tail of hers. Her eyes are slit like those of a fiend, staring back at you in troubled confusion. It takes you a full minute to realize this woman is actually you as you eye down what's drooling from your pussy.\n\n");
			outputText("In a puddle of black fluids is a fairly sizeable purple gem that you proceed to pick up. A strange hunger takes hold of you and you swiftly gulp down the gem before a feeling of raw power courses through you. An understanding reaches your mind. You are [name], Champion of Ingnam, but you are also a succubus. Come to think of it… why are you even championing those idiots? They literally sent you through the portal to be enslaved and turned into a cum pump. The elders and the village should burn. ");
			outputText("You realize that while your goals have diametrically changed, you are still you. You don’t exactly care for Ingnam anymore, what you care about now is to grow stronger, satisfy your deprived desire and own as many things as possible. Not to mention that you seem to have gained an insatiable desire for power that only the acquisition of more of those crystals can fulfill. You look back at Xuviel and ponder an important question.\n\n");
			outputText("<i>Where can I find more of these…</i>\n\n");
			outputText("He looks at you pensively then shrugs.\n\n");
			outputText("\"<i>Obviously, only people still yielding a soul can offer you lethicite. If you’re really this eager to obtain more, you should seek out the demon queen Lethice. She has the bulk of it stored in her castle. That said no one has the guts to put her off the throne, perhaps it’s time some more ambitious demons took control</i>\"\n\n");
			outputText("You resolve to make this so-called lethicite your own. That said, you ponder your relationship to Xuviel now. You're fully free from the necklace’s influence and can think clearly now. Well, as clearly as any demon would. He's the one who fixed you… made you see this wicked world for what it is. This handsome demon freed you from your ignorance and made you like this. Some part of you desires to stay with him, you're his and he's yours, however you need to put on a proper facade so you can retain as much autonomy as possible. ");
			outputText("After all, you want the demon to keep up on the game and never assume that he owns you completely so that you can get as many advantages from him as possible. Perhaps he could assist you in your quest? That’s without mentioning satisfying your urges, of course. Xuviel considers you for a moment, then laughs.\n\n");
			outputText("\"<i>Ah, indeed, you make a fine succubus, [name], already looking for your own profit in this arrangement, however, you will swiftly go hungry without a man to feed from. Perhaps you should consider becoming my wife in full or at least make an alliance with me. I will offer you as much sex as your depraved heart desires, in exchange, I merely request you formally join my harem. I have many favors and gifts I’m willing to give you should you freely give yourself to me.</i>\"\n\n");
			outputText("Now that’s an interesting deal. Hunting for food in the wild yields little interest to you, and indeed, having full access to Xuviel’s many resources and delicious dick could prove a profitable relationship.\n\n");
			player.addStatusValue(StatusEffects.MeetXuviel, 1, 1);
			player.createStatusEffect(StatusEffects.MeetXuviel2, 0, 0, 0, 0);
			player.demonicenergy += 50;
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function demonLairMainMenu():void {
			clearOutput();
			outputText("You go home to Xuviel’s lair"+(player.isNaked()?"":", undressing and seductively dropping your clothes at the entrance, you won’t need those hindrances here")+". The master of the place is by his usual self, busy enjoying one of his many wives. He’s quick however to acknowledge your presence as another succubus is dutifully worshiping his cock.\n\n");
			outputText("\"<i>Well how nice of you to come home, [name], how are your travels? Please, put yourself at ease and have a seat.</i>\"\n\n");
			outputText("You don’t wait for him to repeat himself and go lay next to him, licking your lips as you see the succubus miss a small dollop of his cum.");
			if (player.statusEffectv1(StatusEffects.MeetXuviel) == 4) {
				outputText(" Since you accepted his deal and became one of his wives, Lord Xuviel was kind enough to prepare a ninth cushion just for you, so you can sit closer to him and enjoy the intoxicating scent of his cock at your leisure.");
				player.addStatusValue(StatusEffects.MeetXuviel, 1, 1);
			}
			outputText("\n\n\"<i>So… [name], what did you come home for? Got bored of your insipid slaves?</i>\"\n\n");
			menu();
			addButton(0, "Talk", demonLairTalkMainMenu);
			addButton(1, "Sex", demonLairSexMainMenu);
			addButton(2, "FoC", demonLairFontOfCorruption).hint("Font of corruption");
			//3 - Private quarters
			addButton(14, "Only visiting", demonLairOnlyVisiting);
		}
		
		private function demonLairTalkMainMenu():void {
			clearOutput();
			outputText("You actually came over to have a chat. Xuviel shrugs, the succubus sucking his dick continuing her job diligently.\n\n");
			outputText("\"<i>Go on then [name], what is on your mind?</i>\"\n\n");
			menu();
			addButton(0, "Him", demonLairTalkHim);
			addButton(1, "Harem", demonLairTalkHarem);
			addButton(2, "His position", demonLairTalkHisPosition);
			addButton(3, "Gifts", demonLairTalkGifts);
			addButton(4, "Other girls", demonLairTalkOtherGirls).hint("Actually, you wanted to talk with the rest of the harem.");
			addButton(14, "Back", demonLairMainMenu);
		}
		private function demonLairTalkHim():void {
			clearOutput();
			outputText("You ask Xuviel if he can chat for a little about himself. Mind you it’s easier to fuck someone you properly know. Xuviel shrugs.\n\n");
			outputText("\"<i>Truthfully, I was born and raised here on Mareth. I was a lord even before demonhood became a thing. That said once I discovered I had eternity ahead of me, collecting money and treasure didn’t appear as interesting. I needed to find some new pastimes and it’s when I began collecting women of exception such as yourself. I developed a particular fondness for the people of Ingnam after one of the more… daring champions managed to grab my attention, so I decided to take on the hobby of collecting nine of the most perfect women I could find. You girls are quite the breed.</i>\"\n\n");
			outputText("Umph so to him you are a conquest, nothing more? A new purebred horse to add to his collections?\n\n");
			outputText("\"<i>Oh but I said nothing of the sort. No my lovely demoness, by all means, I consider every member of my harem my wife with all the details and needs it entails. Meredith, for example, requests a new set of gifts every month and has quite the weird taste in slaves, so I tend to be forced to buy her new toys every now and then while Octavia only want's a new magical trinket once in a while, the kind that distort and mess someone’s body… who knows what she even does with those. You could say I’m the ideal sugar daddy without the age factor.</i>\"\n\n");
			if (player.statusEffectv1(StatusEffects.MeetXuviel) == 5) {
				outputText("Slaves eh… now that's interesting. You could indeed use some.\n\n");
				player.addStatusValue(StatusEffects.MeetXuviel, 1, 1);
			}
			doNext(demonLairTalkMainMenu);
			advanceMinutes(5);
		}
		private function demonLairTalkHarem():void {
			clearOutput();
			outputText("So what’s his deal with collecting wives, can’t he be satisfied with you alone? Your tear-drop breasts, your cock hungry asshole, your thirsty pussy willing to devour anything, and your mouth that only asks for a chance to suck him for his delicious cream to which you are addicted? Aren’t all of these enough for him?\n\n");
			outputText("Xuviel sighs and answers right as his cock fills the succubus’s mouth with a thick load of his corrupted cum. \"<i>How to put this… I’m not the kind of man to stop after the first. No, I would rather have every woman in creation take a turn to sleeve my cock with their needy cunt but the fact is I can’t. Heck nine wives is a good number so I think I will stop there before I begin to forget or mess up your names.</i>\"\n\n");
			outputText("Well, that’s thoughtful of him and it limits the competitions though you still wish deep inside that cock was yours alone.\n\n");
			doNext(demonLairTalkMainMenu);
			advanceMinutes(5);
		}
		private function demonLairTalkHisPosition():void {
			clearOutput();
			outputText("Honestly what position does Xuviel even hold in the demon society to begin with?\n\n");
			outputText("\"<i>Well, while I did wish I was king, I’m only what could be referred to as a duke. The demonic nobility has many greater demons in its ranks. Most rise to power or fall. I recall that one of my fellow nobles was defeated by a permanent curse before being sealed inside the deepwoods. That said he never had my patience or cunning. Another I know is too busy playing with his kennel to manage politics and the last one just wants to play slave maker… like absolutely zero ambition in that omnibus.</i>\"\n\n");
			outputText("Well, you sure did dream for a time to be a princess back in Ingnam but those were childhood dreams. Marrying into wealth and nobility was something you would’ve thought out of your league back then.\n\n");
			outputText("Xuviel goes on. \"<i>The queen however… She rules only because no one has the guts to make an open move against her and has grown fat and lazy over her throne. Lethice hasn’t made a single attempt to conquer in decades. I suggest she is long overdue for replacement. You know… should you manage to actually put those talents of yours to use and accomplish what many of those idiots call the impossible, namely defeat Lethice, I could move in and become king instead, in which case I would make you both queen of my harem and queen of all demons.</i>\"\n\n");
			outputText("Now this sounds like a very tantalizing perspective. You absolutely love the idea of ruling over Mareth and mostly being on top of all your rivals when it comes to him. All you need to do now is steal the throne from Lethice.\n\n");
			doNext(demonLairTalkMainMenu);
			advanceMinutes(5);
		}
		private function demonLairTalkGifts():void {
			clearOutput();
			menu();
			outputText("You tell Xuviel you would like a gift. ");
			if (player.statusEffectv1(StatusEffects.MeetXuviel2) > 0) {
				outputText("Xuviel responds in the negative.\n\n");
				outputText("\"<i>I’m sorry [name] but to avoid causing jealousy across my harem I only give one gift per month. Ask again in a while and we'll see.</i>\"\n\n");
				addButtonDisabled(1, "Gift of wealth", "Gift of wealth");
				addButtonDisabled(2, "Gift of power", "Gift of power");
				//addButtonDisabled(3, "Gift of authority", "Gift of authority");
			}
			else {
				outputText("He nods, acknowledging your request.\n\n");
				outputText("\"<i>Sure, my dear. Would you like wealth, power, or perhaps slaves to entertain you?</i>\"\n\n");
				addButton(1, "Gift of wealth", demonLairTalkGiftOfWealth).hint("Gain gems.");
				addButton(2, "Gift of power", demonLairTalkGiftOfPower).hint("Increases all trainable stats by 10 points. (up to cap)");
				//addButton(3, "Gift of authority", demonLairTalkGiftOfAuthority).hint("Gain a new slave for your personal harem.");
			}
			addButton(14, "Back", demonLairTalkMainMenu);
		}
		private function demonLairTalkGiftOfWealth():void {
			clearOutput();
			outputText("You could use some spare money right now for your expenses and so you make it clear to him. Xuviel sighs and waves a finger at one of the succubi, making her fly to a different room and coming back with a chest packed full of gems.\n\n");
			outputText("\"<i>Here’s your spare change. Try not to spend it all in a day…</i>\"\n\n");
			var giftofwealth:Number = 500 + rand(501);
			outputText("<b>You " + (silly()?"pass go and ":"") + "collect " + giftofwealth + " gems!</b>\n\n");
			player.gems += giftofwealth;
			player.addStatusValue(StatusEffects.MeetXuviel2, 1, 567);
			statScreenRefresh();
			doNext(demonLairTalkMainMenu);
			advanceMinutes(10);
		}
		private function demonLairTalkGiftOfPower():void {
			clearOutput();
			outputText("If he's that strong why doesn't he share some of that power to you.\n\n");
			outputText("Xuviel sighs and brings you in for a kiss. You can feel the energy and raw corruption flow through your lips as you exchange saliva with him. How thoughtful of him.\n\n");
			outputText("\"<i>Hope you are satisfied, because I’m not sharing again for a full month.</i>\"\n\n");
			outputText("Your corrupted body indeed responds to his fluids, growing stronger.\n\n");
			player.trainStat("str",10,player.trainStatCap("str",100));
			player.trainStat("tou",10,player.trainStatCap("tou",100));
			player.trainStat("spe",10,player.trainStatCap("spe",100));
			player.trainStat("int",10,player.trainStatCap("int",100));
			player.trainStat("wis",10,player.trainStatCap("wis",100));
			player.trainStat("lib",10,player.trainStatCap("lib",100));
			player.addStatusValue(StatusEffects.MeetXuviel2, 1, 567);
			statScreenRefresh();
			doNext(demonLairTalkMainMenu);
			advanceMinutes(10);
		}
		private function demonLairTalkGiftOfAuthority():void {
			clearOutput();
			outputText("\"<i></i>\"\n\n");
			menu();
			addButton(14, "Back", demonLairTalkMainMenu);
		}
		private function demonLairTalkOtherGirls():void {
			clearOutput();
			outputText("Xuviel waves at you invitingly, telling you you are free to do as you please as you turn to the succubus sitting next to you, the one that first questioned your presence in Xuviel’s pleasure palace that is. Her tail is tracing circles in the air out of boredom.\n\n");
			outputText("\"<i>Honestly, [name], I still can’t figure what master Xuviel saw in you, because back in Ingnam I saw nothing.</i>\"\n\n");
			outputText("Wait what? She’s from Ingnam? Now that she mentions it, she indeed reminds you of one of the local farmer’s eldest girls, named Misha if you remember right. Why would such a strong, smart, and beautiful girl like her be selected as Ingnam’s yearly sacrificial cow if their aim is to get rid of people they don’t want?\n\n");
			outputText("\"<i>Like you don’t know, [name]. I bet you just went with the elders' plan the moment they proclaimed you as the next champion. Fact is, I was selected because I knew too much. See, smarts don't pay off in Ingnam, and I was about to figure out what was going on, so the council decided to get rid of me. Bet they gave you the excuse I was in such a rush to protect the village that I ran straight to the portal ahead of my time?</i>\"\n\n");
			outputText("So that’s why she disappeared early! Well, you can’t say she looks any worse for the wear considering she ended up in Xuviel’s hands instead of the factory.\n\n");
			outputText("\"<i>Xuviel only ever picks up the girls he likes, he has a long story of dealings with Zetaz and the factory overseer to get his own pick out of the year’s champions should they strike his fancy, and does this right under Lethice’s nose. Did you know he offered that imp nothing short of two thousand gems for you? ");
			outputText("Gems he likely won’t have to spend as Zetaz actually never managed to properly capture you. Heck, you even went and shut down the factory, so it’s likely he will have to go browse elsewhere. Nice job to whoever got that necklace on you, that person’s probably rich right now.</i>\"\n\n");
			outputText("She regrets nothing of her old life?\n\n");
			outputText("\"<i>Regrets? I’ve been with Xuviel long enough that I don't even care anymore. He fucks me when I want it, showers me with gifts and gives me anything I wish for. I don’t know how you still manage to go back out there and sleep out in the wild when he can provide you comfort and luxury fit for nothing short of the demonic noblesse.</i>\"\n\n");
			outputText("Well, you’ve got your reasons. Starting with the fact you plan on overthrowing Lethice, and a base of operations at the center of Mareth is still the ideal location for exploration.\n\n");
			outputText("\"<i>Lethice? Why do you even care? The sooner she has Mareth under her heel, the better.</i>\"\n\n");
			outputText("Vengeance, pure and simple. Once you have access to all of Lethice’s resources you will also acquire her supply of lethicite for yourself, then you can go back home and have a nice chat with Ingnam’s elders. Sure you could wait until Lethice has full control of Mareth and decide to invade a different world, but you aren’t patient enough to wait for that, not to mention she might simply choose to invade one of the many other dimensions which connect with Mareth.\n\n");
			outputText("\"<i>If that ever happens, count me in! I owe Nomur for knocking me unconscious and sending me through the portal in a bag.</i>\"\n\n");
			outputText("Nomur, eh? You sure got special plans for that one.\n\n");
			if (player.statusEffectv2(StatusEffects.MeetXuviel2) < 1) player.addStatusValue(StatusEffects.MeetXuviel2, 2, 1);
			doNext(demonLairTalkMainMenu);
			advanceMinutes(10);
		}
		
		private function demonLairSexMainMenu():void {
			clearOutput();
			outputText("\"<i></i>\"\n\n");
			menu();
			if (player.biggestTitSize() <= 1) addButton(0, "Naizuri", demonLairSexPaizuriNaizuri);
			else addButton(0, "Paizuri", demonLairSexPaizuriNaizuri);
			addButton(1, "From behind", demonLairSexFromBehind);
			addButtonIfTrue(2, "Tailjob + Vaginal", demonLairSexTailjobVaginal, "Lacking Demon Tail.", player.tailType == Tail.DEMONIC);
			addButton(3, "Throne fuck", demonLairSexThroneFuck);
			addButtonIfTrue(4, "Harem yuri time", demonLairSexHaremYuriTime, "Req. to see 'Other Girls' talk option.", player.statusEffectv2(StatusEffects.MeetXuviel2) > 0);
			addButton(14, "Back", demonLairMainMenu);
		}
		private function demonLairSexPaizuriNaizuri():void {
			clearOutput();
			outputText("You kneel before Xuviel and let his hands slide on your skin, making you shiver in delight. You grab your breasts and squeeze his member between them, planning to give him the best titfuck in his harem. You gleefully take his tip in your mouth as you slide his delicious member between your [breasts]. Humans are so boring, they can’t truly feel the pleasure you get just from sucking him. ");
			outputText("Thanks to your succubus enhanced body, each time you thrust his cock in your mouth you can feel it as if it were a second vagina, with your tongue as a second clit. Your oral nerves are set aflame with pleasure as you gleefully suck on Xuviel’s cock. The more you please him, the more you are pleasured, and before long you’re too lost in it to even grasp the notion of time as you methodically slide his cock up and down in your sensitive breast.\n\n");
			outputText("\"<i>Mmmm, as expected from one of the best succubus on Mareth, bet you’re enjoying yourself as much as I do. Take your time to savor it.</i>\"\n\n");
			outputText("Ah, you don’t say! Your pussy is drooling all over the ground as your clit-like tongue wraps around his member in an attempt to maximize your pleasure and his. That said, everything must come to an end and you can feel your lover’s incoming orgasm far before he voices it.\n\n");
			outputText("\"<i>Ah, good girl… Here's your reward, try not to spill a drop.</i>\"\n\n");
			outputText("Xuviel floods your mouth and throat with his cum and you gulp it eagerly. He pulls out and shoots two final threads on your face and right onto your breasts as you moan, reaching an oral orgasm which causes your pussy to pulse and gush. You can taste his cum with your every pore as your lustrous breasts absorb it all inside like a sponge, your skin gaining in healthiness as you feel your latent hunger being sated and your energy refilled.\n\n");
			outputText("You clean your lips lasciviously and grabs one of your teats, licking whatever is left of your dinner that your body didn’t already take in. Living as a succubus is so different from what you were before. Cum, for instance, tastes better than any food you could get and of course of all cum from a powerful incubus like Xuviel suits you best. Satisfied, you stand to the side and lay down to rest, leaving the place for the next succubus.\n\n");
			doNext(demonLairSexPaizuriNaizuri2);
		}
		private function demonLairSexPaizuriNaizuri2():void {
			clearOutput();
			outputText("You wake up with a cute yawn where you dozed off. Xuviel is busy reading a manuscript as one of his other wives attends to him. What are you in the mood for now?\n\n");
			player.sexReward("no", "Dick");
			doNext(demonLairMainMenu);
			advanceMinutes(60);
		}
		private function demonLairSexFromBehind():void {
			clearOutput();
			outputText("You move in front of him then ask Xuviel if he would be in the mood to punish his most depraved succubus. After all, you have been a very bad demon. To punctuate this, you drop on all four and sway your [ass] from one side to another in a clear invitation"+(player.tailType == Tail.DEMONIC ? " your tail tip drawing circles in the air around your pucker":"")+".\n\n");
			outputText("\"<i>Mmm I guess punishment is indeed in order for such an indecent display [name]... stay right where you are.</i>\"\n\n");
			outputText("You smile as he moves to you and grabs your tits for handles, his unholy cock lubing itself on your vaginal lips, slathering it tauntingly with demonic pre before moving toward your inviting butt. He slowly slides between your generous ass cheeks before breaking through your pucker and you gasp in pleasure as he squeezes your boobs with his powerful grasp, thin beads of milk surging out. ");
			outputText("Within further warning, Xuviel thrusts himself into your fine piece of ass, to which you can’t help but giggle at the sound of your voluptuous ass slapping against his body. Xuviel’s cock slowly works against your pucker with each thrust, pumping in and out, letting you feel every inch of his girthy dick. His tingling precum helps loosen and lubricate your passage in just the right way as you reflexively loosen up for more of him.\n\n");
			outputText("You get a hint of your performance the moment he thrusts into you with an assertive grunt, filling you with more of his pre, leaving you salivating as your incubus lover feeds you his seed drop by drop. You squeeze his juicy cock between your ass cheek in an attempt to increase his delight, the many feelers in your holes tasting every inch of him inside you as he slaps your butt between ");
			outputText("trust"+(player.tailType == Tail.DEMONIC ? ". He grows weary of your tail waving in his face as he grabs it firmly with his free hand, yanking it up, tugging it tauntingly in a painful mix of pleasure as his penis forces out delirious moans out of your mouth":"")+".\n\nFinishing up his appetizer Xuviel, decides it's time to finish you up. ");
			outputText("You gasp in delight as your master grips you by the hips, thrusting into you with greater force as he gives a low growl, leaning into you as his abs press against your backside. With a final, assertive thrust, he hilts himself completely into you with every inch of his fat cock, finally shooting the long-awaited deluge of his warm, demonic seed deep into you. Savoring the taste of your master, you feel it fill you up to your stomach.\n\n");
			outputText("Xuviel lets you drop back on the floor as you crawl on all fours back to your cushiony pillow, savoring your meal as a different succubus begs to be punished next. You doze off satisfied for the next hour.\n\n");
			player.sexReward("cum","Anal");
			doNext(demonLairMainMenu);
			advanceMinutes(60);
		}
		private function demonLairSexTailjobVaginal():void {
			clearOutput();
			outputText("Well, how about getting a shot where it really matters now? Xuviel notices the offer right away.\n\n");
			outputText("\"<i>I don’t think my audience room is suitable for such actions. Perhaps a strategic withdrawal to my inner sanctum is called for? I need a break from my paperwork anyway.</i>\"\n\n");
			outputText("Oh, this is just perfect, you're going to have him all by yourself too. You smile as he opens the door before you walk in, your tail swishing with anticipation. Xuviel starts to slowly undress before he lies down on the bed, offering you a full view of his perfect body. You begin to crawl on the bed, wings open and tail waving like that of a cat on the prowl as you mouse over, pressing your [breasts] on his broad, manly chest. ");
			outputText("It would be a shame to simply fuck the incubus so early, and so, your wrap your tail, just like a whip around his cock, your spaded tip teasing his gland ever slowly. Xuviel rewards your attention by grabbing your inviting breasts pressing into them with his expert hands.\n\n");
			outputText("You moan in delight, your tail squeezing the base of his cock, but delaying the orgasm so as to properly ripen the treasure in his balls, you will definitely want everything of it. Your lips meet for a few instants, tongues dancing as your tail tip ever teases the entrance of his urethra. Had Xuviel been one of those cute human pets, he would have came already from the unnatural amount of pleasure you are giving him, ");
			outputText("but his endurance as an incubus far surpasses that of any normal man. Xuviel, however, rewards your skill with a few drops of precum flowing out of his tool which you swiftly smear all over his length with the coil of your tail. He is about ready for you now. You give a quick glance behind, Xuviel’s hand still massaging your tender breast flesh and admire his cock.\n\n");
			outputText("His proud tool is covered with black veins, pulsing as the member drools precum, indicating its readiness. You lick your lips as you slowly lower yourself on his tool and sit on his lap, lifting yourself from his chest with your two arms so he can get a full display of your drenched pussy molding his cock. You go on, whispering to him in invitation.\n\n");
			outputText("\"<i>How about you make me your princess tonight, lord of darkness? Go on and fill my devoted pussy with your corruption.</i>\"\n\n");
			outputText("Xuviel smiles and gropes your breasts as he holds you with himself, pleasure deliciously flowing from your chest as he accompanies the rhythmic movement of your backside with thrusts of his own. Devilish pleasure creeps to your mind but you hold on, increasing its length way beyond reasonable limits as you mold your vaginal walls in the ideal shape of his cock, every inch of your temptress pussy pleasuring him like only a succubus can. ");
			outputText("You lift your head skyward for a set of delighted mewls as his unholy cock pulses with the telltale sign of a long-awaited orgasm. He thrusts deeper into you as you squeal, begging for his demonic warmth. Your pussy clenches instinctively to trap the cum inside as Xuviel rewards you with a generous stream of his cum. Ohhh such a meal. Highly satisfied, you lay down against him for a short rest awaiting his second wind.\n\n");
			doNext(demonLairSexTailjobVaginal2);
		}
		private function demonLairSexTailjobVaginal2():void {
			clearOutput();
			outputText("After several hours of feeding, you finally reach complete satisfaction, heading back right after Xuviel to the audience room. You’re still hungry of course, you’re always hungry for more. You sit on your pillow and wrap your tail across your legs as the master of the house resumes his reading, the next succubus already taking advantage of his cock’s availability. What are you in the mood for now?\n\n");
			player.sexReward("cum", "Vaginal");
			player.sexReward("cum", "Vaginal");
			player.sexReward("cum", "Vaginal");
			player.sexReward("cum", "Vaginal");
			player.sexReward("cum", "Vaginal");
			doNext(demonLairMainMenu);
			advanceMinutes(300);
		}
		private function demonLairSexThroneFuck():void {
			clearOutput();
			outputText("Well, now you think about it, this pillow you use isn't exactly the seat you want. Eyeing Xuviel, you ask him if he has some space on that throne of his. He opens his arms in invitation as you sashay to him and slowly sit on his lap, inserting his delicious member inch by inch into your voracious pussy.\n\n");
			outputText("Of course, as his dick is shaped with the purpose to fuck the brains out of any female, he’s just the ideal size for you, and you moan in delight as you finally engulf the last of his rod inside, Xuviel pulls your head to his for a kiss. Your tongues dance with each other, playing hide and seek for a minute before your lips part ways, a small strand of saliva still linking them. Ready for the next step you whisper softly to him.\n\n");
			outputText("\"<i>Do not worry I will handle everything. Just you relax my lord, and taste my caresses.</i>\"\n\n");
			outputText("You mold your unholy labia around his cock, your organ-like walls caressing his flesh like only those of a succubus can, something your former pathetic human body couldn’t have done due to its many sensory and physical limitations. You pity those mortals really, unable to access such heights of carnal pleasure only available for those who like you became demons. The pleasure between your legs pulls you back out of your thoughts however ");
			outputText("and you gasp as Xuviel himself reminds you of the situation by thrusting his cock up and high into your pleasure buzzer as if to tell you to get to it. You feel him quite well in there and you got enough control over your pussy to even guide him straight to your sweet spot on every thrust just as if holding his fiendish cock in your hand. You begin to slide on his dick, bouncing up and down, your jiggly breasts following the motion. ");
			outputText("Xuviel responds by grabbing your chest from behind and imprinting the shape of his hands in your two perfect spheres. You cry out for your master in delight as his tongue slithers off and gives your areola a playful lick"+(player.tailType == Tail.DEMONIC ? ", your spaded tail waving behind you like that of a cat on the prowl":"")+". Ohhh you sure are enjoying this and the ripple of his perfect cock in your [vagina] is simply divine.\n\n");
			outputText("You can taste his precum in your sinful pussy already and soon delicious cream is gonna flow out of these churning balls of his and sate your thirst. You maximize your efforts to ripen the mix, caressing his cock and teasing his balls with your fingers like only you can and eventually he gives in. He gives you an almost reprimanding thrust, causing you to bite your lip in response as his pulsating member digs deeper into you with each pump. Your mind goes as white, ");
			outputText("desperately trying to clench around your demonic lover as the fluids that drench every millimeter of your vaginal walls as Xuviel finally feeds your thirsty demonic cunt with a full load of warm fresh corrupted cum, your womb drinking it in"+(player.isPregnant()?"":". Mmmmm you muse as you savor the cum in your womb that with some luck you might actually get pregnant with a litter of imps or two")+".\n\n");
			outputText("Satisfied you unplug, a small strand of cum drooling out of your vagina before being pulled back in with a suction sound, why waste a single drop? you stand to the side and lay down to rest leaving the place to the next succubus.\n\n");
			doNext(demonLairSexThroneFuck2);
		}
		private function demonLairSexThroneFuck2():void {
			clearOutput();
			outputText("You wake up with a cute yawn where you were dozing off. Xuviel is busy reading a manuscript as one of his other wives attends his unholy cock. What are you in the mood for now?\n\n");
			player.sexReward("cum", "Vaginal");
			doNext(demonLairMainMenu);
			advanceMinutes(60);
		}
		private function demonLairSexHaremYuriTime():void {
			clearOutput();
			outputText("You feel like getting off but you are not in the mood to do it alone. Xuviel notices this and laughs, addressing the harem as a whole.\n\n");
			outputText("\"<i>Girls, you need not restrain yourselves. If you all want to take me at the same time I will gladly take you all. But first, show me a display of your talents, the harder I get the better the fuck will be.</i>\"\n\n");
			outputText("He snaps his fingers and you all smirk knowingly before plunging into the fray. Your eyes have already found and targeted Misha, you’re going to teach that slut some manners especially after mocking you on your first entrance. It's about time you get the freedom to properly punish her sinful cunt. Misha also takes note of your perverted gaze and realizing you’re going to make a drooling mess out of her, gets ready to retaliate.\n\n");
			outputText("You jump on your rival with the speed and agility of a prowling panther, some of your fingers already probing the entrance of her pussy. She is about just as fast to latch her hand to your breast, her spaded tail tip flicking in your now drooling cunt and exciting your clitoris. While your rival got a better start than you, you refuse to admit defeat and viciously pinch her nipple using the momentum to take hold of her now gasping mouth into a forced kiss. ");
			outputText("The two of you could catfight for minutes, but there’s nine of you in this fuckfest. Before you know it, one of the other girls has inserted her tail into your deliciously plowable ass and is in the process of giving you a good stretch while a second succubus is grabbing your breasts and kissing your areola. There isn’t a single one of your privates that’s not being thoroughly and masterfully toyed with, ");
			outputText("and all of this happens under the watchful eyes of master Xuviel. Your eyes catch a glimpse of his hardening, vein pulsing cock and this turns you on even more…mmmmm if the master is watching you get off you will have a hard time holding back your desire to cum and hells under, a few seconds later, you achieve a messy orgasm that should provide all the lube your lover could ever need. You moan and dip some of your fingers in your fluids, ");
			outputText("playfully pulling them back to your mouth before licking them clean. Xuviel, aroused by the show, roars in pleasure, his unholy dick dripping precum, no longer able to restrain its desire for all these offered pussies. It answers its owner’s needs by exploding into a set of nine long perverted writhing tentacle cocks, a show that leaves you wide-eyed and licking your lips in anticipation of what will come next.\n\n");
			outputText("Before this spectacle, it is the only rational choice that the nine of you display your dripping pussies for the aroused incubus lord to fuck your brains out. One of Xuviel’s many dicks wrap around your arms, slides between your breast, wrap around your "+(player.isNaga()?"tail":"legs")+" and viciously rams itself into your pussy, lifting you in the air to make better use of gravity. You gasp in rapture as your succubus body is thoroughly violated by your demonic lover, ");
			outputText("his tentacle pulling you just close enough for him to gently pat you on the head as your eyes cross from the influx of pleasure your depraved flesh is subjected to. The tentacles in you suddenly start to twitch and you can follow the travel of the cum influx all along its length. The nine of you screams your master’s name as your thirsty wombs are at long last flooded by his unholy cream progressively inflating to a near pregnant size. ");
			outputText("This is the best bukkake ever and hell, even if you don’t become pregnant from this, your bellies will at least stay big and ballooney for a few hours before your cum starved bodies finish drinking it all. There’s no question left unanswered, this is why Xuviel is the king of this harem and one hell of a king he is. ");
			outputText("He would not be satisfied with filling you alone however, that would be disappointing from a man such as him. You reach orgasm several times fold as his cock keeps pumping your hellish cunt all the way to the point your brain ceases to follow and you fall into unconsciousness.\n\n");
			outputText("You wake up later feeling satiated, back on your cushion. Xuviel is busy reading a manuscript as one of his other wives attends his unholy cock, you almost feel guilty for not waking up first. That said, what are you in the mood to do now?\n\n");
			player.sexReward("cum", "Vaginal");
			doNext(demonLairMainMenu);
			advanceMinutes(60);
		}
		
		private function demonLairFontOfCorruption():void {
			clearOutput();
			outputText("You let Xuviel know you would like to use the font to the side and he waves you to it. A font of purplish water indeed gushes constantly at the left corner of the room. It's ornament, the statue of a succubus achieving orgasm constantly gushing fluids through her polished stone pussy. You are pretty sure immerging items in such a font would enhance them with untold powers. Let alone what kind of powers you might gain by drinking directly from the fountain.\n\n");
			menu();
			addButton(1, "Defile item", demonLairFontOfCorruptionDefileItem);
			addButton(3, "Drink from font", demonLairFontOfCorruptionDrinkFromFont);
			addButton(14, "Back", demonLairMainMenu);
		}
		public function demonLairFontOfCorruptionDefileItem():void {
			var improvableItems:Array = [
				[weapons.BFSWORD, weapons.NPHBLDE, weapons.EBNYBLD],
				[weapons.DBFSWO, weapons.T_HEART, weapons.DORSOUL],
				[weapons.MASTGLO, weapons.KARMTOU, weapons.YAMARG],
				[weapons.KATANA, weapons.MASAMUN, weapons.BLETTER],
				[weapons.W_STAFF, weapons.U_STAFF, weapons.N_STAFF],
				[weapons.DEMSCYT, weapons.LHSCYTH, weapons.HELRAIS],
				[weapons.UGATANA, weapons.MOONLIT, weapons.C_BLADE],
				[weapons.L__AXE, weapons.WG_GAXE, weapons.DE_GAXE],
				[weapons.SPEAR, weapons.SESPEAR, weapons.DSSPEAR],
				[weapons.JRAPIER, weapons.Q_GUARD, weapons.B_WIDOW],
				[weapons.OTETSU, weapons.POCDEST, weapons.DOCDEST],
				[weapons.BFTHSWORD, weapons.ARMAGED, weapons.CHAOSEA],
				[weapons.A_WAND, weapons.OCCULUS, weapons.ECLIPSE],
				[weapons.PFLUTTE, weapons.ELYSIUM, weapons.HELLCAL],
				[weaponsrange.BOWLONG, weaponsrange.ARTEMIS, weaponsrange.WILDHUN],
				[weaponsrange.SHUNHAR, weaponsrange.KSLHARP, weaponsrange.LEVHARP],
				[weaponsrange.SIXSHOT, weaponsrange.GOODSAM, weaponsrange.BADOMEN],
				[shields.SANCTYN, shields.SANCTYL, shields.SANCTYD],
				[armors.LMARMOR, armors.BMARMOR, armors.S_ARMOR],
				[armors.BLKIMONO, armors.IBKIMO, armors.TCKIMO],
				[armors.BKIMONO, armors.IBKIMO, armors.TCKIMO],
				[armors.PKIMONO, armors.IBKIMO, armors.TCKIMO],
				[armors.RKIMONO, armors.IBKIMO, armors.TCKIMO],
				[armors.WKIMONO, armors.IBKIMO, armors.TCKIMO],
				[armors.SPKIMO, armors.OEKIMO, armors.OTKIMO],
				[armors.CTPALAD, armors.CTHPALA, armors.CTBGUAR],
				[armors.LTHRPNT, null, armors.CGUNSLI],
				[armors.DEATHPO, null, armors.DEATHPGA],
				[armors.B_QIPAO, armors.SFLAREQ, null],
				[armors.G_QIPAO, armors.SFLAREQ, null],
				[armors.P_QIPAO, armors.SFLAREQ, null],
				[armors.R_QIPAO, armors.SFLAREQ, null]
			];
			clearOutput();
			outputText("What item would you like to defile with the corruption of the font?");
			outputText("\n\n<b>You currently have " + player.keyItemvX("Radiant shard", 1) + " radiant shards.</b>");
			var selectfrom:int = 2;
			var selectMenu:ButtonDataList = new ButtonDataList();
			for (var i:int = 0; i < improvableItems.length; i++) {
				if (improvableItems[i][selectfrom] == null) {/*do nothing*/
				}
				else {
					var item:ItemType = improvableItems[i][selectfrom];
					var from:ItemType = improvableItems[i][0];
					selectMenu.add(item.id, curry(improveItem, item, from)).disableIf(!player.hasItem(from),"You need "+from.longName+" as a base to create this item")
					.disableIf(player.keyItemvX("Radiant shard", 1) < 3,"You need at least three radiant shards in order to create this item.")
					.disableIf(player.gems < 20000,"You need at least 20 000 gems in order to create this item");
				}
			}
			submenu(selectMenu, demonLairFontOfCorruption);
			
			function improveItem(item:ItemType, from:ItemType):void {
				clearOutput();
				outputText("You immerse the item in the unholy fountain, smiling with glee as slimy darkness seems to creep in, attempting to remake it into something new and immensely powerful, gear worthy of a succubus. The item seems to resist the corruption for a moment but the material, like a cumming virgin, finally begin to soak and drink in the font’s liquid corruption darkening as something not unlike purple veins course across it. After a minute you pull the empowered item out of the font. You can’t wait to make use of it.\n\n");
				if(player.keyItemvX("Radiant shard", 1) == 3) player.removeKeyItem("Radiant shard");
				else player.addKeyValue("Radiant shard",1,-3);
				player.gems -= 20000;
				player.destroyItems(from, 1);
				inventory.takeItem(item, explorer.done);
			}
		}
		private function demonLairFontOfCorruptionDrinkFromFont():void {
			clearOutput();
			outputText("You drink a cup of the unholy waters, achieving spontaneous orgasm as pure corruption washes over you. You feel powerful and attractive, temptation made flesh. Your corrupted body demands to be looked at and touched and will likely prove the downfall of many mortals. You are well aware of how much, for a while, your seduction attempts will be enhanced by the unholy waters of the font.\n\n");
			if (player.hasStatusEffect(StatusEffects.FontOfCorruption)) player.removeStatusEffect(StatusEffects.FontOfCorruption);
			player.createStatusEffect(StatusEffects.FontOfCorruption, 7, 0, 0, 0);
			doNext(demonLairFontOfCorruption);
			advanceMinutes(5);
		}
		
		private function demonLairPrivateQuarters():void {
			clearOutput();
			outputText("\"<i></i>\"\n\n");
			menu();
			addButton(14, "Back", demonLairMainMenu);
		}
		
		private function demonLairOnlyVisiting():void {
			clearOutput();
			outputText("You are only here to say hi to your beloved, a short visit it may be. You tell Xuviel of your latest accomplishment, regaling him with your story before departing, you have more misdeeds to do yet.\n\n");
			doNext(camp.returnToCampUseOneHour);
		}
	}
}