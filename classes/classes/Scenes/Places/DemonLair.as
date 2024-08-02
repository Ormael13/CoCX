/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Places 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.Stats.Buff;
import classes.display.SpriteDb;

public class DemonLair extends BaseContent
	{
		
		public function DemonLair() {}
		
		public function questProgressScenes():void {
			clearOutput();
			if (player.statusEffectv1(StatusEffects.MeetXuviel) == 3) {
				outputText("\"<i></i>\"\n\n");
			}
			if (player.statusEffectv1(StatusEffects.MeetXuviel) == 2) {
				outputText("Instead of going to your destination you feel Xuviel forcefully pulling you again toward his lair, your pussy instinctively drooling in anticipation despite your terror. You can’t help but worry about what the fiend will do to you this time.\n\n");
				outputText("The silver gate opens for you yet again as you head for a different room. This seems to be Xuviel’s master chamber, decorated with red drapes and a large bed fit for 4 people if need be. The demon in question is currently sitting on a chair in a nightgown holding what seems to be a glass of wine. Upon your entry, he soon acknowledges your presence.\n\n");
				outputText("\"<i>Good evening [name]. I have been waiting for you.</i>\"\n\n");
				outputText("Xuviel motions for you to move toward the bed, and naturally, your body obeys him like a puppet.\n\n");
				outputText("\"<i></i>\"\n\n");
				outputText("\"<i></i>\"\n\n");
				outputText("\"<i></i>\"\n\n");
				outputText("\"<i></i>\"\n\n");
				outputText("\"<i></i>\"\n\n");
				outputText("\"<i></i>\"\n\n");
				outputText("\"<i></i>\"\n\n");
			}
			if (player.statusEffectv1(StatusEffects.MeetXuviel) == 1) {
				outputText("Instead of going to your destination, an unknown force pushes you in a different direction. You know where you are going the moment you see the silver door again, your pussy instinctively drooling in anticipation, despite your terror.\n\n");
				outputText("This time you walk to what looks to be a dining room. Xuviel is casually sitting by the table eating what seems to be "+(((player.itemCount(consumables.LETHITE)+player.itemCount(consumables.LETH1TE)+player.itemCount(consumables.LETH2TE)+player.itemCount(consumables.LETH3TE))>0)?"lethicites":"purple crystals")+"(if seen lethicite before) (Else) (end of cut) and he greets you the moment you arrive.\n\n");
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
				//Apply cosmetic effect and text from kitsune tight and succubus breast if pc is below standards
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
				player.addStatusValue(StatusEffects.MeetXuviel, 1, 1);
				player.addStatusValue(StatusEffects.MeetXuviel, 2, 7);
			}
			endEncounter();
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
		}
		public function questProgressScenes04():void {
			outputText("You will die or lose your sanity long before he gets you to do anything perverse.\n\n");
			questProgressScenes02();
			player.addStatusValue(StatusEffects.MeetXuviel, 3, 2);
			dynStats("cor", 5);
			dynStats("lib", 5);
			dynStats("sens", 5);
		}
		
		public function demonLairMainMenu():void {
			clearOutput();
			outputText("\"<i></i>\"\n\n");
			menu();
			addButton(14, "Leave", explorer.done);
		}
	}
}