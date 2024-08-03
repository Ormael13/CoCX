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
import classes.Scenes.NPCs.JojoScene;
import classes.Scenes.SceneLib;
import classes.Stats.Buff;
import classes.display.SpriteDb;

public class DemonLair extends BaseContent
	{
		
		public function DemonLair() {}
		
		public function questProgressScenes():void {
			clearOutput();
			if (player.statusEffectv1(StatusEffects.MeetXuviel) == 3) {
				outputText("You feel the pull of Xuviel’s necklace again and head to him. Your pussy drooling knowingly in anticipation, despite your terror. You can’t help but think about what abuses the fiend will subject you to this time.\n\n");
				outputText("You’re back in the throne room. Seems the demon lord didn’t feel like having you join him in his bedroom this time. Xuviel grins as he sees you enter the room, his harem chuckling at your approach.\n\n");
				outputText("\"<i>It’s a pleasure to see you, [name]. The girls were actually talking about your latest performance, most impressive.</i>\"\n\n");
				outputText("You ponder whether he's talking about how you handled marae and the factory or about what you did to his… actually, you’re very keen on forgetting that. Xuviel teases you further.\n\n");
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
			endEncounter();
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
			endEncounter();
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
			if (player.cor >= 100) {
				player.addStatusValue(StatusEffects.MeetXuviel, 1, 1);
				player.addStatusValue(StatusEffects.MeetXuviel, 2, 7);
			}
			endEncounter();
		}
		public function questProgressScenes08():void {
			outputText("No, he’s wrong! You will keep defying him for as long as it takes until he sets you free!\n\n");
			dynStats("cor", -5);
			questProgressScenes06();
			if (player.cor >= 100) {
				player.addStatusValue(StatusEffects.MeetXuviel, 1, 1);
				player.addStatusValue(StatusEffects.MeetXuviel, 2, 7);
			}
			endEncounter();
		}
		public function questProgressScenes09():void {
			outputText("He lifts a glass of wine to you and this only angers you more. How dare he mock you, you’re going to make him pay for that! The moment the necklace's control weakens you’re going to give him nightmares for weeks. It’s only as your rage reaches its peak that you finally realize. The pull of the necklace is gone! Perhaps it’s time for revenge but then again if he defeats you he might fix your necklace and you may never get such a chance to strike back at him again. ");
			outputText("Heck the necklace weakening now might just be a trick from him in order for you to let your guard down and do something foolish. Do you use this opportunity to flee or attack him?\n\n");
			menu();
			addButton(1, "Assault", questProgressScenes11);
			addButton(3, "Run", questProgressScenes10);
		}
		public function questProgressScenes10():void {
			outputText("Striking him down in your current state of mind and body is downright foolishness. There's no telling how it might end! No, you ought to run while you can and get this necklace off by any means necessary!\n\n");
			outputText("As you run for the exit, you hear Xuviel’s mocking voice behind you.\n\n");
			outputText("\"<i>Run.. yes run however long you want [name], inevitably you will come back here of your own volition! You belong to me body and soul, you just don't know it yet.</i>\"\n\n");
			endEncounter();
		}
		public function questProgressScenes11():void {
			outputText("You smirk at Xuviel, dash at him, grab him, and then pull him off his chair. You growl. For every minute he raped you, you’re going to punish him, for every shame he inflicted upon you, you’re going to shame him, an eye for an eye. You forcefully pull him to the ground, but the demon is still smirking. Gosh, you’re going to erase that awful smile right away. With rage, you yell at him what you think of his attitude!\n\n");
			outputText("<i>You will not be controlled by this asshole. You will not be his bitch forever! You are nobody’s slave, let alone his! Now, you will show him what happens when one stoops so slow as to attempt to dominate their entire mind.</i>\n\n");
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
			if (!player.hasPerk(PerkLib.Soulless)) player.createPerk(PerkLib.Soulless, 0, 0, 0, 0);
			outputText("A breathtakingly beautiful woman with "+player.skinColor1+" skin stares back at you. She has a jaw-dropping face crowned by "+player.hairColor+" hair. She dons a pair of supple " + player.breastCup(0) + " sized breasts, which hypnotically seems to draw your stare down. Her body seems shaped in every way to tempt men yet what stands out is the horns, graceful bat-shaped wings and that long sinuous spaded tail of hers. Her eyes are slit like those of a fiend, staring back at you in troubled confusion. It takes you a full minute to realize this woman is actually you as you eye down what's drooling from your pussy.\n\n");
			outputText("In a puddle of black fluids is a fairly sizeable purple gem that you proceed to pick up. A strange hunger takes hold of you and you swiftly gulp down the gem before a feeling of raw power courses through you. An understanding reaches your mind. You are [name], Champion of Ingnam, but you are also a succubus. Come to think of it… why are you even championing those idiots? They literally sent you through the portal to be enslaved and turned into a cum pump. The elders and the village should burn. ");
			outputText("You realize that while your goals have diametrically changed, you are still you. You don’t exactly care for Ingnam anymore, what you care about now is to grow stronger, satisfy your deprived desire and own as many things as possible. Not to mention that you seem to have gained an insatiable desire for power that only the acquisition of more of those crystals can fulfill. You look back at Xuviel and ponder an important question.\n\n");
			outputText("<i>Where can I find more of these…</i>\n\n");
			outputText("He looks at you pensively then shrugs.\n\n");
			outputText("\"<i>Obviously, only people still yielding a soul can offer you lethicite. If you’re really this eager to obtain more, you should seek out the demon queen Lethice. She has the bulk of it stored in her castle. That said no one has the guts to put her off the throne, perhaps it’s time some more ambitious demons took control</i>\"\n\n");
			outputText("You resolve to make this so-called lethicite your own. That said, you ponder your relationship to Xuviel now. You're fully free from the necklace’s influence and can think clearly now. Well as clearly as any demon would. He's the one who fixed you… made you see this wicked world for what it is. This handsome demon freed you from your ignorance and made you like this. Some part of you desires to stay with him, you're his and he's yours, however you need to put on a proper facade so you can retain as much autonomy as possible. ");
			outputText("After all, you want the demon to keep up on the game and never assume that he owns you completely so that you can get as many advantages from him as possible. Perhaps he could assist you in your quest? That’s without mentioning satisfying your urges, of course. Xuviel considers you for a moment, then laughs.\n\n");
			outputText("\"<i>Ah, indeed, you make a fine succubus, [name], already looking for your own profit in this arrangement, however, you will swiftly go hungry without a man to feed from. Perhaps you should consider becoming my wife in full or at least make an alliance with me. I will offer you as much sex as your depraved heart desires, in exchange, I merely request you formally join my harem. I have many favors and gifts I’m willing to give you should you freely give yourself to me.</i>\"\n\n");
			outputText("Now that’s an interesting deal. Hunting for food in the wild yields little interest to you, and indeed, having full access to Xuviel’s many resources and delicious dick could prove a profitable relationship.\n\n");
			if (player.hasStatusEffect(StatusEffects.PureCampJojo)) {
				player.removeStatusEffect(StatusEffects.JojoNightWatch);
				player.removeStatusEffect(StatusEffects.PureCampJojo);
				JojoScene.monk = 1;
			}
			if (flags[kFLAGS.AMILY_FOLLOWER] == 1) {
				flags[kFLAGS.AMILY_FOLLOWER] = 0;
				flags[kFLAGS.AMILY_CORRUPT_FLIPOUT] = 1;
				flags[kFLAGS.AMILY_VILLAGE_ENCOUNTERS_DISABLED] = 0;
			}
			if (flags[kFLAGS.KIHA_FOLLOWER] > 0) flags[kFLAGS.KIHA_CORRUPTION_BITCH] == 1;
			player.addStatusValue(StatusEffects.MeetXuviel, 1, 1);
			endEncounter();
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
			addButton(14, "Only visiting", explorer.done);
		}
		
		private function demonLairTalkMainMenu():void {
			clearOutput();
			outputText("You actually came over to have a chat. Xuviel shrugs, the succubus sucking his dick continuing her job diligently.\n\n");
			outputText("\"<i>Go on then [name], what is on your mind?</i>\"\n\n");
			menu();
			addButton(0, "Him", demonLairTalkHim);
			addButton(1, "Harem", demonLairTalkHarem);
			addButton(2, "His position", demonLairTalkHisPosition);
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
		
		private function demonLairSexMainMenu():void {
			clearOutput();
			outputText("\"<i></i>\"\n\n");
			menu();
			addButton(14, "Back", demonLairMainMenu);
		}
	}
}