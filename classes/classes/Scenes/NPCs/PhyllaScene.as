/**
 * Created by aimozg on 05.01.14.
 */
package classes.Scenes.NPCs
{
import classes.*;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Camp.CampStatsAndResources;
import classes.Scenes.SceneLib;
import classes.display.SpriteDb;

public class PhyllaScene extends BaseContent implements TimeAwareInterface
	{

		public const phyllaCapacity:Number = 50;

		public var pregnancy:PregnancyStore;

		public function PhyllaScene()
		{
			pregnancy = new PregnancyStore(kFLAGS.PHYLLA_VAGINAL_PREGNANCY_TYPE, kFLAGS.PHYLLA_DRIDER_INCUBATION, 0, 0);
			EventParser.timeAwareClassAdd(this);
		}

		//Implementation of TimeAwareInterface
		public function timeChange():Boolean
		{
			pregnancy.pregnancyAdvance();
			if (flags[kFLAGS.PHYLLA_EGG_LAYING] > 0 && rand(5) == 0 && flags[kFLAGS.ANT_KIDS] < 5000) flags[kFLAGS.ANT_KIDS]++;
			if (model.time.hours > 23) {
				//The pregnancyStore doesn't handle Phylla's ant eggs because they are continuous. The regular egg production is all handled here.
				if (flags[kFLAGS.PHYLLA_EGG_LAYING] > 0) flags[kFLAGS.DAYS_PHYLLA_HAS_SPENT_BIRTHING]++;
				if (flags[kFLAGS.PHYLLA_GEMS_HUNTED_TODAY] > 0) flags[kFLAGS.PHYLLA_GEMS_HUNTED_TODAY] = 0;
				if (phyllaWaifu()) flags[kFLAGS.DAYS_PHYLLA_IN_CAMP]++;
			}
			return false;
		}

		public function timeChangeLarge():Boolean {
			return false;
		}
		//End of Interface Implementation

		public function phyllaWaifu():Boolean
		{
			return flags[kFLAGS.ANT_WAIFU] > 0;
		}

		public function phyllaSprite(nude:Boolean = false):void {
			if (flags[kFLAGS.PHYLLA_EGG_LAYING] == 0) {
				if (nude) spriteSelect(SpriteDb.s_phylla_nude);
				else spriteSelect(SpriteDb.s_phylla);
			}
			else spriteSelect(SpriteDb.s_phylla_preg);
		}

		public function introductionToPhyllaFollower():void
		{
			clearOutput();
			if (pregnancy.isPregnant && pregnancy.incubation == 0) {
				phyllaLaysSomeDriderEggs();
				return;
			}
            phyllaSprite();
			//[Follower > Phylla Intro (First Time)]
			if (flags[kFLAGS.PHYLLA_CAMP_VISITS] == 0) {
				outputText("Gazing into the distance, you see a small dirt hill you can only assume is the beginning of Phylla's colony.  Every now and then you see Phylla's silhouette pop out of the hole then immediately dive back into it.  You smile to yourself as you walk along the unfamiliar path towards the growing anthill.  Not very long after you start down the path, you end your journey at the base of her colony's entrance.  It's pretty impressive that Phylla has moved so much earth in such a small amount of time given that she is alone and 'royalty.'  Then again, she has four arms.  You cautiously make your way down through the threshold of the colony's entrance.  As you walk down the tunnel, you can't help but see the contrast between this single tunnel and her mother's massive, bewildering, colony.");
				outputText("\n\nYou come to the end of the tunnel and find Phylla sprawled on her pillows, napping, completely naked.  She seems to have hollowed out a makeshift room for herself.  Everything in the room is carved out of stone.  Then you realize something; this room is almost a carbon copy of your campsite on the surface!  It's even complete with a bedroll and firepit, both completely made of stone, rendering them quite useless.  Clearly Phylla did this to make you more comfortable, but failed in a very cute way.  She wakes up with a weary yawn, stretching all six of her limbs and flexing her abdomen.  Opening her eyes groggily, she jumps in surprise when she notices you standing in her doorway.  Clearly startled, Phylla frantically grasps for her pillows to cover her nudity.");

				outputText("\n\n\"<i>Oh! You came! I'm so happy!  I mean, I thought for a second you might not come... I mean...</i>\"");

				outputText("\n\nShe trails off, noticing you gazing around the room and taking in the familiar scenery.  She hesitantly admits that her new colony is all because of you.");

				outputText("\n\n\"<i>I-I'm trying to... do you like it?  I mean, it's very small, and I know it's not as nice as the surface, but I like it. I mean, are you comfortable?  Is there anything I can...</i>\"");

				outputText("\n\nYou cut her off with a funny look.  She takes a deep breath and attempts to calm down.");

				outputText("\n\n\"<i>There's been something I've been wanting to tell you.  I mean, if you want to hear it.</i>\"");
				outputText("\n\nYou nod.  Couldn't hurt to hear what she has to-");
				outputText("\n\n\"<i>I'm pregnant.</i>\"");

				outputText("\n\nYour thoughts grind to a halt and display a shocked look on your face.  Your stomach quickly feels like it's knotted up inside of you at the mere surprise and mention of this startling fact.");
				outputText("\n\nSeeing your reaction, she frantically waves with all four of her arms as she continues.");

				outputText("\n\n\"<i>No! It's not like that!  I mean, I can choose to have children - I mean, I can be not pregnant, too!</i>\"");
				outputText("\n\nThe look on your face painfully displays that you don't understand what she's talking about.");
				outputText("\n\n\"<i>W-we only need to have sex the one time, I mean! I want to have sex with you more!</i>\"  She quickly covers her mouth and blushes deeply after her mind catches up to what her mouth just blurted out.  Drawing her arms inward around her body, she stoops low in embarrassment but continues on.");

				outputText("\n\n\"<i>Ever since my first time with you, I've been pregnant.  I can choose to have children or not.  I-I mean.. my kind, lay eggs. They grow up fast... or fast compared to people like you.  So if you want, I can build us a colony full of our offspring, or I can just be here all by myself.  I don't care as long I'm with you.  The choice is up to you. I mean, if you don't mind.  You don't have to make this choice now either; I mean, I'm always here.</i>\"");
				if (flags[kFLAGS.DIDNT_FUCK_PHYLLA_ON_RECRUITMENT] == 1 && player.hasCock()) {
					outputText("\n\nYou raise your eyebrow and ask her how she can be pregnant if you never stuck it in.");
					outputText("\n\nShe takes a deep breath and continues.");
					outputText("\n\n\"<i>I don't need semen to have children; I just need certain fluids.</i>\"  Again she blushes and half covers her face with a pillow.  She looks as if she's not going to continue until she looks down between your legs.  \"<i>You were kind of leaking them...</i>\"  All she can muster is a deeper blush...");
				}
				else if (!player.hasCock()) {
					outputText("\n\nYou raise your eyebrow and ask her how she can be pregnant if neither of you have a penis.");
					outputText("\n\nShe takes a deep breath and continues.");
					outputText("\n\n\"<i>I don't need semen to have children; I just need certain fluids.</i>\"  Again she blushes and half covers her face with a pillow.  She looks as if she's not going to continue until she looks down between your legs.  \"<i>You know the kind of fluids I'm talking about...  I mean, they're sweet and we shared them... they come from our... I mean, your...</i>\"  All she can muster is to point at where your vagina is located...");
				}
				outputText("\n\nYou give her a knowing look and she continues, her voice a little more confident than before.");
				outputText("\n\n\"<i>Thank you.  Sometimes I just get embarassed to talk about things like that, I mean. I'm just happy to see you here.  What do you want to do?</i>\"");

			}
			//►[Follower > Phylla Intro (Repeat)]
			else {
				outputText("Making your way down the familiar path away from your camp it's not long until you reach the growing anthill that is Phylla's campsite-adjacent colony.  You climb to the crest of the ever-increasing anthill, and enter down the passage to the caves below.  Once you get to Phylla's room, you see she's working on carving something on the wall.  Half of it looks like a copy of the art you did and the other half looks like a map of her colony with all the networked caves.");

				//If <10 days in camp:
				if (flags[kFLAGS.DAYS_PHYLLA_IN_CAMP] < 10) outputText("\n\nSo far the map of the caves doesn't look very impressive.");
				//If <30 days in camp:
				else if (flags[kFLAGS.DAYS_PHYLLA_IN_CAMP] < 30) outputText("\n\nThe map of the cave network is starting to look pretty impressive. You could get lost for quite a while if you didn't know where you were going.");
				//If <100 days in camp:
				else outputText("\n\nJust looking at the carving makes your head spin.  It's almost certain that if you didn't know where you were going, you could easily get lost forever.");

				outputText("\n\nThe second your eyes lock onto her back, you feel something in your mind twitch.  You see the same thing happen to her as her whole body twitches.  She quickly turns around and runs over to you.");
				outputText("\n\n\"<i>You came back! I mean... I hope you like it. I mean welcome... What do you want to talk about?</i>\"");
			}
			//[Talk] [Sex] [Lay Eggs / Don't Lay Eggs] [Children] [Appearance] [Gems] [Stones]
			menu();
			addButton(0, "Talk", phyllaTalkChoices);
			addButton(1, "Sex", phyllaSexMenu)
				.disableIf(player.lust < 33, "Not aroused enough!");
			if (flags[kFLAGS.PHYLLA_EGG_LAYING] == 0) addButton(2, "Lay Eggs", phyllaLaysEggsToggle);
			else addButton(2, "No Eggs", phyllaLaysEggsToggle);
			if (flags[kFLAGS.ANT_KIDS] > 0) addButton(3, "Children", phyllasKidsChildren);
			addButton(4, "Appearance", phyllaPearance);
			addButton(5, "Find Gems", phyllaDigsForGems);
			addButton(6, "Take Stones", phyllaStones);
			addButton(14, "Back", camp.campLoversMenu);

			flags[kFLAGS.PHYLLA_CAMP_VISITS]++;
		}

		private function phyllaSexMenu():void
		{
			var egg:Boolean = flags[kFLAGS.PHYLLA_EGG_LAYING] > 0 && flags[kFLAGS.ANT_KIDS] >= 10;
			menu();
			//Dick
			addButton(0, "Get BJ", phyllaBeeeJays)
				.disableIf(!player.hasCock(), "Req. a cock!");
			addButton(1, "FuckHer", dickPhylla)
				.disableIf(egg, "Phylla should not be laying eggs at the moment.")
				.disableIf(!player.hasCock(), "Req. a cock!");
			addButton(2, "FuckHer(Egg)", dudesFuckEggLayingBitches)
				.disableIf(!egg, "Phylla should be laying eggs and have at least 10 children.")
				.disableIf(!player.hasCock(), "Req. a cock!");
			addButton(3, "Orgy(Male)", orgyWithDatColonyCorruptDudes)
				.disableIf(flags[kFLAGS.ANT_KIDS] < 10, "You need more children for this.")
				.disableIf(!player.hasCock(), "Req. a cock!")
				.disableIf(player.cor < 75 - player.corruptionTolerance, "You're not corrupted enough!", "???");
			//Pussy
			addButton(6, "Lesbi", lesbianFisting)
				.disableIf(egg, "Phylla should not be laying eggs at the moment.")
				.disableIf(!player.hasVagina(), "Req. a vagina!");
			addButton(7, "Lesbi(Egg)", birfingSexWithAntsForDasLadies)
				.disableIf(!egg, "Phylla should be laying eggs and have at least 10 children.")
				.disableIf(!player.hasVagina(), "Req. a vagina!");
			addButton(8, "Orgy(Female)", antColonyOrgy4Ladies)
				.disableIf(flags[kFLAGS.ANT_KIDS] < 10, "You need more children for this.")
				.disableIf(!player.hasVagina(), "Req. a vagina!")
				.disableIf(player.cor < 75 - player.corruptionTolerance, "You're not corrupted enough!", "???");
			//Driderimpregnation scene for Phylla
			addButton(10, "Oviposit", eggDatBitch)
				.disableIf(!player.canOvipositSpider(), "Req. a spider ovipositor!");
			addButton(14, "Back", introductionToPhyllaFollower);
		}

		private function phyllaTalkChoices():void
		{
			menu();
			addButton(0, "History", talkAboutAntHistory);
			addButton(1, "Mating", talkAboutAntMatingAndRituals);
			addButton(2, "Her Life", phyllasLifePastAndFuture);
			addButton(14, "Back", introductionToPhyllaFollower);
		}

//►[Talk]
//..(Ant Morph History)
		private function talkAboutAntHistory():void
		{
			clearOutput();
			flags[kFLAGS.TALKED_WITH_PHYLLA_ABOUT_HISTORY] = 1;
			outputText("You relax on one of the many available pillows and ask Phylla about her race's history. She pulls a pillow up next to yours and cuddles in.  \"<i>It's not a very happy story, are you sure you want to hear it?</i>\" You nod and move your hand to hold one of hers.");

			outputText("\n\nShe looks down into the darkened tunnel that leads to her room, seeming slightly detached for a moment.  \"<i>There was a time when my people were very prevalent here in Mareth.  We were called the Myrmi by different Tribes.  Though we never really interacted, I mean... we would forage on the surface sometimes, but we mostly kept to ourselves.  The only time we truly interacted with the surface is when a new Princess would go out looking for... for... suitors... if she couldn't find one among her own colony.</i>\"  A flush of red washes over her face as she continues.");

			outputText("\n\n\"<i>Sometimes colonies would become so large, that they would connect to each other underground.  Therefore some colonies would never need to go to the surface again.</i>\"");

			outputText("\n\nYou try to imagine what these super colonies would have looked like, but the thought boggles your mind.");
			outputText("\n\n\"<i>It was a better time, before the demons...</i>\"  Her voice seems to trail off.");

			outputText("\n\nYou inquire what happened after the demons came.  \"<i>It was difficult; we were almost driven to extinction.  Whole colonies became corrupted, and because our race only produces a few female eggs, most colonies quickly just turned into massive...</i>\"  Her voice cut, as if she didn't want to say the next word.");

			outputText("\n\nYou try and implore her to continue, understanding the implication of her long pause.");

			outputText("\n\n\"<i>Massive... orgies...</i>\" She says demurely looking down.  \"<i>The libido of both the workers and warriors became corrupted, they would just about have sex with anything that moved.  Quickly the surface tribes would kill us on sight, for fear of my people dragging them off into the night. We have particularly good night vision.</i>\"  She tries to change subjects but you continue to press her for her history.");
			outputText("\n\n\"<i>Queens soon stopped giving birth to females because their lust drove them to crave any male...  even of their own offspring.  Any eggs these queens laid were just as corrupt as the queen herself. So the cycle could never break itself.  The few of us, like my mother, who could still reproduce uncorrupted children, had to flee deeper and deeper into harsh environments to escape the surface, other colonies, and lastly the demons themselves.</i>\"");

			outputText("\n\nPhylla looked on the verge of tears, but squeezing your hand, she musters the strength to continue her tale.  \"<i>My mother... she... committed a genocide on her own people... even her own offspring.  Just to remove her colony from the massive underground network that connected all the main colonies.  Digging deep into the desert, far away from everything... and everyone. That's where we've been living for a long time.  Alone, and afraid.</i>\"");

			outputText("\n\nTears begin trickling down her cheeks.  Then to your surprise, a smile lights up her face. She turns to you and wipes her tears and nose with her other three hands.  \"<i>That was... until I met you. From the day we met, I knew you were special.  Together, we will write a new chapter for my people. One that has...</i>\"");
			menu();
			addButton(0, "Comfort", comfort);
			addButton(1, "Boring...", boring);
			addButton(2, "Berate", berate);

			function comfort():void {
				outputText("\n\nBefore she finishes her sentence, you pull her to you and kiss her deeply.");
				outputText("\n\nYour mind is suddenly bombarded with images of when you first met Phylla.  You watch yourself burst from your hiding spot and heroically defeat the Oasis Demons.  Only this time from her perspective.  The suffocating fear of being pinned down and gang raped replaced with a glimmer of hope that the individual before her would save her from the tainted creatures.  Next, you see yourself in the trials, fighting off each and every horror they sent at you; the same feeling of hope she felt earlier filling her body as you ducked and weaved past minotaurs and the like.  The feeling of this strange yet courageous individual dueling those monsters being the one that would rise to the challenge of being her mate.  You feel an overwhelming sense of love and compassion as Phylla breaks the kiss.");

				outputText("\n\n\"<i>...just happy memories.</i>\" she finishes.");
				outputText("\n\nYou try to stand and almost fall over; you thought that this mind-link would get easier over time - you were clearly wrong. Phylla catches you in her arms and helps you to the exit of the colony.  Staggering back to camp like a drunkard you feel the weight on your mind ease with each step and by the time you've arrived you feel right as rain.");
				dynStats("cor", -1);
				doNext(camp.returnToCampUseOneHour);
			}
			function boring():void {
				outputText("\n\nYou interrupt her loving speech by standing up, leaving her momentarily confused.  You then comment on how you were never really interested in her people's history to begin with. All you really wanted was to get away from the surface for a while.  \"<i>W-what?</i>\" she says meekly.  With a small yawn you start to stretch in front of her, sighing to yourself as now you have to explain.");

				outputText("\n\nYou tell her you have better things to do than sit here and listen to her half-babble, half-cry on about her mother and the demons.  You're a champion after all; if you wanted to hear people babble on and on about history you would have been a scholar.  Any interest in the subject is long gone at this point.");

				outputText("\n\n\"<i>I didn't mean to, I mean, you asked!  I didn't want to bore you, I-I just thought...</i>\" She says timidly, trying to recover the conversation.");
				outputText("\n\nYou cut off both her speaking and her attempt to stand up by saying she thought wrong. Maybe she should stop thinking so much and just listen to you.  Also, if she hadn't been crying the whole time the story would have been a lot easier to listen to.");
				outputText("\n\nYou don't have time to deal with this right now; you gather your things and head back to camp, leaving Phylla alone in her room, with her sad memories.");
				dynStats("cor", 1);
				doNext(camp.returnToCampUseOneHour);
			}
			function berate():void {
				outputText("\n\nWith a disgusted scoff you abruptly stand up, cutting Phylla off and pushing her into the uncushioned stone floor.  You look down at her and she looks up at you, shocked.");

				outputText("\n\nWith no sympathy for her own feelings, you berate her about how her people were weak and pathetic; they had the numbers and the strength to help stop the demons from spreading as quickly as they did.  Hell, her people could have stopped the invasion altogether if they had cooperated with the surface races.  But no!  They choose to stay underground hiding like cowards as the rest of the surface was systematically ruined by demons and corruption!");

				outputText("\n\nIn response to this shaming, she looks into your eyes as though you had just stabbed her in the heart.  She starts shaking and tears are running down both sides of her face.");

				outputText("\n\n\"<i>I wasn't even alive... how could you say...</i>\"");

				outputText("\n\nThough you've taken 'advantage' of the corruption yourself, it makes you a little horny verbally asserting your dominance over Phylla.");

				//(If PC has not completed the factory)
				if (flags[kFLAGS.FACTORY_SHUTDOWN] <= 0) {
					outputText("\n\nEvery year!  Every year, your people valiantly send one of their own through that hellish portal to this place in the hopes to try and quell or even stop the spread of corruption.  Now you just learned that it all could have been slowed or even stopped completely by Phylla's race had they all not been gutless yellow-bellied cowards!");
				}
				//(If PC has completed the factory)
				else {
					outputText("\n\nKnowing exactly what has happened to those who came before you makes what you're about to say all the sweeter.  You tell Phylla that there have been others before you, and you explain in vivid detail about the factory: how your people were sent as sacrifices, and how Phylla's people could have stopped this if they had even an ounce of courage and intellect to stop them.");
				}
				outputText("\n\nPhylla looks shocked that such a place could exist at all.  You continue by telling her that if she doesn't start to shape up, she may very well \"<i>see</i>\" the factory for herself.  Though your comment is jestful in nature and you don't mean that you would send her there to be a slave (yet), she doesn't seem to understand and pleads with you to stop.");

				outputText("\n\n\"<i>I'll be better, I'll do whatever you want!  P-please... don't send me away!</i>\"");

				outputText("\n\nHow presumptuous.  You tell her to stop reading into things, that she had better follow your instruction and orders, lest she fall prey to this world - once it gets its hooks into you, it doesn't let go until you're perfect for the darkness and its needs.");

				outputText("\n\nTurning to leave back to camp, you hear Phylla crying.  Maybe some time alone with her thoughts will help her see what you're trying to accomplish here.");
				dynStats("cor", 3);
				doNext(camp.returnToCampUseOneHour);
			}
		}

//(Ant Morph Mating Ritual / Inherited Knowledge)
		private function talkAboutAntMatingAndRituals():void
		{
			flags[kFLAGS.PHYLLA_INHERITED_KNOWLEDGE] = 1;
			clearOutput();
			outputText("You've always wondered how Phylla can project thoughts and images of her life into your mind. Seeing as how she's not busy, you ask her about it.  She tilts her head, trying to think of a way to explain it.  You can see this is taking some thought as she stays silent for almost a minute.");
			outputText("\n\n\"<i>It's what we call Inherited Knowledge.  No doubt you felt it when you saved me from the demons. I-I 'marked' you as my potential mate with it.</i>\"  She blushes.  \"<i>I mean! It's not like that.</i>\" She waves all four of her hands frantically.  \"<i>I mean, we princesses have to choose mates that way! Y-you were my first; I had no idea what to expect myself.</i>\"");

			outputText("\n\nYou rest your hand on your face and smile as she continues, thinking how cute she is when she stutters.  She gives you an 'Oh right!' look and continues.  \"<i>It's how we are able to pass our thoughts to others that are not like us.  It's not something we control either, at least when connecting to others.  In very intimate situations or when under extreme stress is when everyone's minds are at their most vulnerable.  Under normal conditions our minds can't link, but if your mind is open, my mind can invade yours.  I mean, I don't want it to sound like I'm attacking you! I mean, I wouldn't ever...</i>\"");

			outputText("\n\nYou're well aware of that and you make a wickedly playful face to show her you know.  She blushes deeply, her cheeks turning bright red and her hands start to fidget.  \"<i>During mating... I-I mean s-sex, is when the link is the strongest. It's when both minds are open.  It's also why we can... control each others' urges.</i>\"  Phylla still seems very shy when it comes to talking about sex.");
			//If Phylla has ever Laid Eggs:
			if (flags[kFLAGS.ANT_KIDS] > 0) outputText("\n\n\"<i>Unlike trying to connect to you, I can share knowledge freely with all of my children.  We never even need to make physical contact.  In the same way, they can share with me.</i>\"");
			//If player has made Phylla have Drider Children:
			if (flags[kFLAGS.PHYLLA_TIMES_DRIDER_EGG_LAYED] > 0) outputText("\n\n\"<i>This of course doesn't extend to our non-ant children.  Like our lovely drider offspring for instance.</i>\"");
			//If Phylla has Ant Children:
			else if (flags[kFLAGS.ANT_KIDS] > 0) {
				outputText("\n\nYou're a little amazed; you ask her if she can sense all of her children right now.  \"<i>It's not like that. I mean... feeling their every thought, all the time, would probably kill me.</i>\"  She pauses, trying to clear the morbid thought from her mind before a brilliant analogy pops into her head.  You comment that you aren't sure that would happen, but the inevitable headaches would certainly be debilitating.  Or drive her crazy.");
			}
			outputText("\n\n\"<i>It's like trying to think of every number between 1 and a 100 at the same time.  I can pick out numbers, but thinking about them all at once is too much.  I can also feel if one of them is in trouble or is sending me a specific feeling.  Fear, triumph, or kinds of rock or dirt...</i>\"");
			outputText("\n\nYou giggle at the last one, cutting her off.  Although why you did is clearly lost to Phylla as she gives you a strange look.  You try to explain that normally people aren't concerned with kinds of rocks or dirt.  She gives you a pouty look while crossing all four of her arms, stating those things are very important to ants.  You both pause for a moment then simultaneously burst into laughter.");
			outputText("\n\nTrying to completely understand how Inherited Knowledge works seems difficult. At least you have a basic understanding now.");
			menu();
			addButton(0, "Kiss", kiss);
			addButton(1, "Embarrass", embarrass)
				.disableIf(player.cor < 33 - player.corruptionTolerance, "Not corrupted enough.");
			//(Leads to - Corruption Checks)
			//If corruption less than 40:
			function kiss():void {
				dynStats("cor", -1);
				outputText("\n\nYou walk over to her and give her a big kiss.  Nothing happens, so you give her a look and a sarcastic quip about how you were expecting something to happen.");
				outputText("\n\nShe gives you a pouty face and then reiterates, again, that she can't control it.");

				outputText("\n\nYou thank her for telling you everything, although as you turn to leave you swear she's covertly touching herself, trying to persuade you into a more passionate action.");
				outputText("\n\nYou grin and head back to camp thinking you should come visit her again soon.");
				doNext(camp.returnToCampUseOneHour);
			}
			//If corruption more than 60:
			function embarrass():void {
				dynStats("cor", 1);
				outputText("\n\nIt seems to be almost torture for her to keep describing her sexual organs, or even sex for that matter.  You get a very evil idea - something you know she won't pick up on.");

				outputText("\n\nYou feign innocence, asking her to show you all the different parts of her body.  This is met with a look of shock, as if you just asked her to strip down in front of a room full of strangers.  She looks around the empty room as if to make sure nobody but you is watching before proceeding.");
				outputText("\n\nVery quietly she says, \"<i>These are my...</i>\"");
				outputText("\n\nYou lean in telling her she's speaking too softly and you can't hear.");
				outputText("\n\nA little louder she starts again.");
				outputText("\n\n\"<i>These are my breasts; they're not very impressive...</i>\"");
				//If PC has over D Cup Continue:
				if (player.biggestTitSize() >= 4) outputText("\n\n\"<i>At least not like yours... I mean, yours are nicer!</i>\"");
				outputText("\n\nShe cups both of her breasts with her two larger hands.");
				outputText("\n\nAnd?  \"<i>...and my nipples.</i>\"  Her nipples immediately get hard.  Either from her hands rubbing them or her talking about them, you're not quite sure.");

				//If Phylla is not laying eggs:
				if (flags[kFLAGS.PHYLLA_EGG_LAYING] == 0) outputText("\n\n\"<i>They don't produce milk unless I'm laying, but... they're very sensitive. I mean, you know that already.</i>\"  Seeing her struggle like this is thrilling in a very sexual way. You ask her just how sensitive they are.  \"<i>I don't... I mean...</i>\" She looks away from you as you stare at her.  You tell her to play with them. You want to see how sensitive they are.  She does, eliciting a gasp of surprised excitement from her open mouth.");
				else outputText("\n\n\"<i>R-right now they're much bigger because... I-I'm producing milk for our children.</i>\"  You can tell she hasn't been suckled recently as her breasts are much larger than normal. You ask to see her milk.  Shocked, she turns her head away but does as she's told.  Her two larger hands cup the bottom on her breasts and give a squeeze. You hear her moaning exhale as white milk sprays out of her nipples.  She does it again without you even telling her to - again a louder moan escapes her.  \"<i>I t-told you they're very sensitive...</i>\" Phylla says between deep breaths.");

				outputText("\n\nYou make a quip about how you'll keep that in mind the next time you two have sex. She quickly covers her chest with her hands, retracting inward.  \"<i>I don't want to... I mean... I do, but... I'm embarrassed... P-please...</i>\"");
				menu();
				addButton(0, "Push It!", pushIt)
					.disableIf(player.cor < 66 - player.corruptionTolerance, "Not corrupted enough.");
				addButton(1, "Stop", stopPushing);

				function pushIt():void {
					outputText("\n\nShe continues apprehensively by removing her two upper hands from her boobs, but still keeping the lower two covering her nipples.");
					outputText("\n\n\"<i>This... this is... my... v-v...</i>\"");
					outputText("\n\n\"<i>Your...?</i>\"  You try to coax out of her.");
					outputText("\n\n\"<i>My vagina.</i>\"  She says it so quietly, it's almost as if she didn't make any sound at all.");
					outputText("\n\nYou say you didn't hear her, and ask her what is it again.  \"<i>You know what this is... I mean, you... w-we...</i>\" She tries to plead, looking for any way out of this.  Watching this is great!  You've never watched anyone get so worked up over a word before.");
					outputText("\n\n\"<i>It's my vagina.</i>\" She finally states.");
					outputText("\n\n\"<i>Your cunt.</i>\" You quickly correct her.");
					outputText("\n\n\"<i>My... c... cunt,</i>\" she says with a defeated tone.");

					outputText("\n\nYou tell her you can see her clit sticking out from between her lips.  She quickly looks down and confirms your words.  She quickly places all four of her hands over her pussy, uncovering her still hardened ");
					if (flags[kFLAGS.PHYLLA_EGG_LAYING] > 0) outputText("milk dripping ");
					outputText("nipples.  You tell her you want to see the inside and for her to explain why she doesn't give birth from it.  By this time, you can see you've started making her horny and her modesty is slowly melting away.  She parts her pussy lips for you with her larger arms and then starts pointing at her long clit with one of her lower hands.");

					outputText("\n\n\"<i>This is my... m-my...</i>\"  With a gulp of courage she continues.  \"<i>My clitoris.  It's hypersensitive and just touching it can cause me to...</i>\" Her voice trails off.  \"<i>Cause you to...?</i>\"  You probe for the answer with a smile on your face, knowing she isn't looking at you anyway.  \"<i>Orgasm.</i>\"  She says blankly.  You can tell by her changing tone and attitude her lust must be consuming all her thoughts.  You ask for a demonstration, causing her head to twist around to give you a long, hard stare.  You've wiped the wicked smile from your face and replaced it with an innocently inquiring one; a true master of deception on one shoulder, and a devil in disguise on the other.");
					outputText("\n\nWith her two upper hands still holding her pussy open for you to see, the lower hand not resting on her clit starts to run up and down the entrance of her quickly moistening cunt.  She moves her smaller right hand and starts from the tip of her love button and slowly runs all her fingers down it.  She moans loudly every time she reaches the base of her clit. Her shoulders tense up and her body shakes as she almost instantly builds to an orgasm.  The resulting climaxes, as you are well aware, are very messy.  With her small left hand, she thrusts two of her fingers into herself, and you watch as she moans deeply and starts masturbating her clit quicker. The two larger hands cease holding her pussy lips apart and start to pinch her nipples");
					if (flags[kFLAGS.PHYLLA_EGG_LAYING] > 0) outputText(", sending jets of milk shooting out onto the floor");
					outputText(".  With a loud moan she orgasms, covering her smaller two forearms, her inner thighs, and the floor below her in thick, sweet-smelling, girl cum.");

					outputText("\n\nShe looks at her smaller hands as she pulls them away from her soaked cunt. They're completely covered in her juices.  Amazed at herself after what she did to herself in front of you, she looks at you blankly for guidance.  You then ask her how many orgasms she can have.");
					outputText("\n\nPhylla's glazed eyes roll into the back of her skull for a moment as she reaches down between her legs again.");
					outputText("\n\n<b>Time passes...</b>");
					outputText("\n\nThough you tried to count over such a long period of watching her masturbate, you lost track at around 15.");
					outputText("\n\nShe's tried to stop a few times, pleading to you that it's too much but you just kept forcing her to continue.  After what you can only guess would be a few hours of watching her cum again and again in an almost heroic display of fortitude, she breaks.  Phylla falls over, completely spent. Sprawled out in front of you, her whole body from head to foot is covered in her own juices.");
					outputText("\n\nYou don't say a word to her as she lies in the pool of her own secretions, her blank eyes gazing into nothingness.  Maybe you broke her, only time will tell, she'll need to recover first.  You set out back to camp, knowing full well she's now just another plaything for you.");
					model.time.hours++;
					dynStats("lus", 25, "scale", false);
					doNext(camp.returnToCampUseOneHour);
				}
				function stopPushing():void {
					outputText("\n\nYou've had your fun, and Phylla is none the wiser.  You wink at her and thank her for the show. The comment clearly goes over her head leaving her wondering about your meaning as you set off back to camp.");
					dynStats("lus", 15, "scale", false);
					doNext(camp.returnToCampUseOneHour);
				}
			}
		}

//(Phylla's Life Past & Future)
		private function phyllasLifePastAndFuture():void
		{
			clearOutput();
			if (SceneLib.izmaScene.izmaFollower() && flags[kFLAGS.PHYLLA_IZMA_TALK] == 0) izmaTalk();
			else normalTalk();

			//======================
			function izmaTalk():void {
				flags[kFLAGS.PHYLLA_IZMA_TALK] = 1;
				outputText("Phylla seems to be a little distant today as you sit down to talk.  You point it out to her and she cautiously asks about Izma.");
				outputText("\n\n\"<i>I k-know there's someone else at your camp.  I mean... I don't want to pretend I'm the only one you'll ever mate with, but this one is special.  I mean, I can feel it inside here.</i>\"  She points to your head with the two arms on her right side, and her head with the two arms on her left side. Seeing you don't deny it, Phylla's eyes well up as she tries to hold back tears.  \"<i>I d-don't know why you didn't tell me you had others staying closer to you...</i>\"");
				outputText("\n\nShe seems extremely distressed and your hesitation while you ponder how to respond only compounds it.  \"<i>I want to know how you feel about her.  I saw you two... I mean, I didn't mean to, I just heard moaning and I was tunneling out the colony and glanced over to your camp.  I didn't mean to watch but...</i>\"");
				menu();
				addButton(0, "Explain", explain);
				addButton(1, "Retort", retort);
				//(Leads to - Corruption Checks)
				//If Corruption less than 40:
				function explain():void {
					outputText("\n\nYou do your best to explain Izma's situation.  Mostly focusing on the fact that she's not like the other shark morphs.  She withstood the corruption by reading and she's naturally faster and stronger than almost anything that could have corrupted her anyway.");
					outputText("\n\nPhylla doesn't look particularly thrilled and seems unsatisfied at your explanation. She sniffles and crosses all four of her arms waiting for further explanation.  There's really not much more to say unless...  You start to explain how Izma and you fought on several occasions.  Phylla looks shocked; the fact that you would attack someone you're in a 'relationship' with clearly escapes her.");
					outputText("\n\n\"<i>Y-you fought? Ww-why...?</i>\"");
					outputText("\n\nYou try and recover saying how it was Izma's idea in the first place, and continue to talk about your alpha-beta relationship.  Once you're done explaining, Phylla seems a little less stressed than before, but she still has questions.");
					outputText("\n\n\"<i>T-the only reason you're with her is because you're stronger than her?</i>\"  Phylla says with a shy but hopeful tone.  You tell her that's not exactly how it is.  Izma means a lot to you in certain respects.  You try to explain how your relationship with Izma is complicated and that it's hard to explain with words.");
					outputText("\n\nOnce Phylla hears that she perks up.");
					outputText("\n\n\"<i>What if... you know... we... I mean...</i>\"  You raise an eyebrow and give her an inquisitive look.  \"<i>We could join...</i>\" She points at her head and yours, again.");
					//If PC Has the 'inherited knowledge' talk:
					if (flags[kFLAGS.PHYLLA_INHERITED_KNOWLEDGE] == 1) {
						outputText("\n\nYou comment on how you thought she couldn't control that. \"<i>I can't... I mean not directly... I've just been stressed recently... ever since I saw the two of you... I think I could... I mean!  I just thought... if you want to try...</i>\"");
					}
					outputText("\n\nYou might as well try; Phylla seems pretty worked up over this and you want to help ease her stress in whatever way you can.");
					outputText("\n\nYou nod and she walks over to you. All four of her arms wrap around you.  She seems to wait for you to take control of the situation, not wanting to take the lead herself.  You put your index finger on her chin and raise her head up so your mouths meet.  At first, you don't feel anything; assuming it's not working, you slide your tongue past her lips into her mouth.  Her grip on you tightens but still nothing happens.  Starting to pull back from her assuming it's not going to work, you feel her grip you hard in desperation as she uses her two upper arms to grab the back of your head to force your tongue deeper into her mouth.  Then, like a triple shot of whiskey right to the brain your mind becomes disoriented with images of Phylla pacing around her room telling herself she didn't see you and Izma together and that it's all just in her mind.");
					outputText("\n\nA flash of her crying, trying desperately to console herself about the fact that you would let a corrupt shark morph have their way with you.  After this, there's a lull in the mind link... you feel as if it's your time to present Izma's case for Phylla's understanding.  Thinking back to the first time you and Izma met, and how she was kind and even let you read her books.  You recall her conversation about how her people work out their relationships with each other.  Bringing up your memories of Izma and you locked in ferocious battle for dominance, you feel Phylla get scared at these particular memories but you force the memories of you pulling some of your more brutal attacks so Izma didn't take any real wounds.");
					outputText("\n\nThough still off-putting this seems to calm Phylla a bit.  The last memory you recall is the one where Izma submitted to you. At the end of one of your 'fights' Izma confesses that you're her alpha and, if allowed, she would be happy to spend her life at your camp.");
					outputText("\n\nYou feel Phylla's grip on you ease and then release. You slowly break the kiss and look into Phylla's eyes.  Your mind still aches as it always does after these things.");
					outputText("\n\n\"<i>I don't know what to say... I was wrong... about her... I mean, about you... I'm so sorry.</i>\"");
					outputText("\n\nYou tell her it's understandable, but sometimes making assumptions before you have all the facts can be disastrous.  \"<i>I know. I'll never doubt you... or Iz-Izma again.</i>\"  You ask Phylla if she would like to meet Izma someday.  She shyly says, \"<i>Only if you think that would be a good idea. She seems very... aggressive.  I mean not that that's a bad thing... I just don't think... I'm strong, too, but I don't like to fight like she does.</i>\"");
					outputText("\n\nYou chuckle, giving Phylla a heavy clap on her chitinous armor, as if to try and reassure her. She'll be fine as long as she's with you.  You are the alpha in the relationship after all.");
					outputText("\n\nThis seems to sit right with Phylla, and she smiles widely.  \"<i>Thank you... for everything.</i>\" She says, her voice finally returning to its normal demure tone.");
					outputText("\n\nYou head back to your camp.  When you get there you see Izma drying off after a swim in the stream. You give her a devious look and a very wide smile.  She looks around to make sure you're actually smiling at her.  \"<i>What's that about?</i>\" She inquires.  You tell her it's nothing she needs to worry about for now.");
					dynStats("cor", -2);
					doNext(camp.returnToCampUseOneHour);
				}
				//If Corruption more than 40: (Continued From: I didn't mean to watch but...</i>\")
				function retort():void {
					outputText("\n\nYou start to retort but Phylla aggressively kisses you.  She grabs your head and neck with all four of her hands so you can't really break the kiss until she's gotten what she wants from you.");
					outputText("\n\nClearly the stress has driven her mind meld to kick in.  She aggressively probes your mind looking for thoughts or memories of Izma.  It's not at all a pleasant feeling; it's as if your mind is being carved up and sorted, piece by piece.  Finally images flash of you first meeting Izma and how she showed you her collection of books.  The next thing you see is you and Izma sitting on a beach reading books together and chit-chatting about how Izma has withstood the corruption by reading.  That image suddenly fades as you see yourself in a fist fight with Izma vying for dominance in your estranged relationship. Eventually you see yourself dominating Izma to the point where she asks you if she's allowed to come back to camp with you.");
					menu();
					addButton(0, "HowDareShe?!", howDareShe)
						.disableIf(player.cor < 50 - player.corruptionTolerance, "Not corrupted enough.");
					addButton(1, "ProbeHer", probeHer);

					//If Corruption more than 80: (Continued From: You're determined to not let this go without protest.)
					function howDareShe():void {
						outputText("\n\nHow dare she!");
						outputText("\n\nAs Phylla attempts to conjure up another memory in your mind, you push her away with all of your strength.  Feeling her hands on the sides of your face start to slip, with one final grunt you send her staggering across the room.  Wiping her saliva from your mouth with the back of your hand, you spit whatever's left onto the floor.  She looks at you with stunned awe.  Clearly she didn't think you could escape.");
						outputText("\n\n\"<i>I-I didn't...  I mean...  she...!</i>\"  She tries to confess, scrambling for words to make you less angry.");
						outputText("\n\nYou collect yourself, but it's not easy - your head is pounding like a morning after a night of heavy drinking and bad decisions.  As soon as you're clearheaded, you see Phylla is sitting in the corner crying, although this doesn't stop you from verbally attacking her.  You curse her up and down, giving her the proverbial 'What the fuck was that for?!' speech.");
						outputText("\n\nEach curse word, each insult, only seems to make her shrink into her corner a little more.  You keep railing on her that she NEVER, EVER has the right to use your own memories and emotions as a weapon against you!  You go on to tell her she was right all along and she's not the only person you're going to \"<i>mate</i>\" with.");
						outputText("\n\nSeeing that last insult, in particular, seemed to make her flinch in pain you continue down that line.  You tell her you two were never exclusive, nor did you ever say you wanted to be.  You start chewing her out, telling her, \"<i>Is this how you repay your lover, your hero?  Did I not save you from being gang raped?  Or how about fighting for your life in the arena, just for you?  How about letting her make her own colony right next to MY camp?  This is how she repays me for all of my kindness!?</i>\"");
						outputText("\n\nYou could slap her, pin her to the ground and make her beg to be willingly bred; she's in no condition to defend herself.  But in a moment of pure genius, you come a better answer.  You walk over to her and seeing how vulnerable she is, you think you have the perfect idea.  You raise your hand and as you do she looks up and flinches, expecting you to hit her.");
						outputText("\n\nInstead you just grab her hair and forcibly pull her head back so she's looking at you.  She's crying, but really, when is she not crying, the dumb bitch!");
						outputText("\n\nWith a firm grasp on her neck, you dart in and kiss her, holding her in place so she can't escape. As your tongue enters her mouth you can feel her jump in surprise,  but you hold her steady.  Her four arms claw at your chest and back, but not enough to actually hurt you.  As your minds synchronize, you feel her mind and how scared she is - how unwanted this is.  So!  She must be feeling what your mind felt like when she did this to you.  Unfortunately for her, you'll be just as rough with her mind as she was with yours.");
						outputText("\n\nYou begin to conjure up all the depraved and disgusting acts you've ever done or seen done. Especially dealing with Izma at first.  Your fights, your sexual exploits, even your deepest depraved thoughts of things you wanted to do to Izma.  Once you're done sending her your thoughts with Izma you move on to Goblins, then Minotaurs, then Tentacle Beasts, and so on.  Each memory you send her seems to be worse than the last, causing her to shake from the vivid imagery.  By the time you've gotten to the Oasis Demons she's stopped wriggling completely; rather, she appears to be enjoying it now.  Her mind is completely open to yours.  In fact, you get the feeling she's starting to welcome these memories, like the broken slut she deserved to be from the start.");
						outputText("\n\nYou can feel her start to probe your mind for anything you haven't already shown her.  You know it probably won't last and you don't really care at this point.  When you finally break your forced kiss, Phylla drops from your arms and hits the rocky floor with a small splash.  You look down to see she had been cumming pretty much the whole time you were overwhelming her mind.");
						outputText("\n\nYou laugh in her face before leaving to return to your camp. You should introduce your new plaything to Izma.  Maybe, if you allow it, Izma can have her very own beta.");
						dynStats("cor", 2);
						doNext(camp.returnToCampUseOneHour);
					}
					function probeHer():void {
						outputText("\n\nYou're determined to not let this go without protest so you do your best to probe Phylla's mind; you reach for anything, but all you feel is her profound sense of loneliness and betrayal.  The next thing you start to see is yourself walking up to Izma, at your campsite, with a seductive glint in your eye.  Before the next memory rises up Phylla breaks the kiss and steps away from you, tears already starting to pool around her eyes.");
						outputText("\n\nThere's a long awkward pause as both of you search for the words to make this all better.  Finally after what seems like an eternity Phylla breaks the silence.  \"<i>I'm so sorry.  I thought... I mean...  She's a...  I thought maybe she did something to you... made you her slave or worse!  I can't put my finger on it, but you're just different somehow.  I just...  Their kind isn't known for...</i>\" Phylla starts to sob loudly.");
						outputText("\n\n\"<i>I was so wrong; she's just another person trying her best to fight the corruption.  I don't know what I was thinking...  I was just so jealous and stressed... just don't hate me, p-please.  I'm so sorry.</i>\"");
						outputText("\n\nPhylla turns away from you and starts crying into all four of her hands.  Having your mind invaded like that was not something you ever expected from Phylla.  You walk over to the frightened ant and grab her by the shoulders and spin her around to face you.  Holding your head like you have a bad hangover, you scold Phylla on how she should never do that to you without your permission.");
						outputText("\n\nYou tell her that Izma means a great deal to you, and this seems to break her heart, as her eyes widen in fear.  Sighing, you do your best to explain to her your alpha-beta relationship with Izma but Phylla perks up a little upon hearing that you haven't completely forgotten about her.  \"<i>So... she's just... your plaything?</i>\"  She manages to say between sobs.");
						outputText("\n\nYou continue in your chastising tone, telling her that Izma isn't your 'plaything' nor will she ever be.  She's your friend and one of your lovers.  That last comment hits Phylla as hard if you had physically punched her.  She staggers backwards, even more tears than before now rolling down her face as she continues to sob loudly.  Though leaving her here like this would be appropriate, given the circumstances, you decide that a last ditch effort to make this right would be the way to go.");
						outputText("\n\nYou explain to her that both she and Izma mean a lot to you.  The relationships you have with each of them are different, but that doesn't mean better or worse.");
						outputText("\n\nTo your surprise Phylla wipes her eyes and tries to calm her sobbing.");
						outputText("\n\n\"<i>Do you... do you really mean that?</i>\"");
						outputText("\n\nYou nod.");
						outputText("\n\nThere's a long silence between you two, as she does her best to stop crying.  \"<i>Thank you. I mean, I should have trusted you... I'll do better.</i>\"  You think Phylla finally understands this strange love triangle you've got going, but who knows for sure.  Izma isn't known for her stealth when you two go at it; it's really no surprise to you that Phylla saw you and Izma together.  You leave her still half sobbing, thinking to yourself that she needs some time to think about what you said.  On your walk back to camp you consider introducing them to each other someday - that might break the tension.");
						doNext(camp.returnToCampUseOneHour);
					}
				}
			}

			function normalTalk():void {
				outputText("You take a seat on one of the many fluffy cushions in her room and she proceeds to cuddle in close, pressing her head against your chest and wrapping her abdomen around you.  She then looks up at you and asks what's on your mind.");
				outputText("\n\nYou tell her you want to know what her past was like, and what her plan is for the future.");
				outputText("\n\nShe places her back on your chest and seems to relax as she tells you about her past.");
				outputText("\n\n\"<i>Well, I mean... I was the first female to be born from my mother... I mean... no doubt she's had another princess by now.  My mother guarded me fiercely and well, I grew up under constant guard and I absolutely... I hated it.  I mean I appreciate it now, but at the time it was suffocating.  I never got to do anything!  I mean... except eating and sleeping... I was confined to my room after...</i>\"  She shudders before continuing on.  \"<i>After some corrupted ants tried to rape me.  My... my guards saw to it that nobody ever laid a hand on me.  That was... well... until I got these urges...</i>\"  Her face turning red as she finishes her last thought.");

				outputText("\n\n\"<i>Every young princess has to seek out a... well you know, partner.  I mean... mate - when they reach adulthood that is.  I searched in the colony, and even had some warriors attempt the trials in my name, but none of them... none could pass the tests.  So my mother decided if I could not find a mate in the colony, I would have to find one outside of it.  We both know what happened after that... I found you, and you're the best thing to ever happen to me.  The great Champion to keep me safe... and I couldn't be happier.</i>\"");

				outputText("\n\nShe playfully squeezes the muscles in your arm.  \"<i>As for the future, that's really up to you. We're joined now, both in mind and destiny.</i>\"");

				//If Phylla has never laid eggs:
				if (flags[kFLAGS.ANT_KIDS] == 0) outputText("\n\n\"<i>As I've said before, I can give us a growing colony with hundreds of children or I could just stay here with you.</i>\"  She pauses, hesitating to continue.  \"<i>Although if we have a large colony, it would mean we could repopulate my people...</i>\"  You get the distinct feeling that Phylla really wants to have kids with you.");
				//If Phylla has/is laid/laying eggs:
				else outputText("\n\nYou see Phylla looking around as your children scurry about past the doorway to her room.  \"<i>I couldn't think of anything I've ever wanted more. Just to have you visit is like a dream.  Although we could always do... other things, I mean!  It doesn't have to be now, just you know...  I-I get lonely sometimes.</i>\"");

				outputText("\n\nYou mull this over in your head, and you must have been thinking pretty hard.  When you get up to leave you find Phylla has completely passed out on your lap.  You take this opportunity to gently unwrap yourself from her, and head back to camp.");
				doNext(camp.returnToCampUseOneHour);
			}
		}


//First Time Blowjob:
		private function phyllaBeeeJays():void
		{
			clearOutput();
            phyllaSprite(true);
			flags[kFLAGS.PHYLLA_BLOWJOBS]++;
			if (flags[kFLAGS.PHYLLA_BLOWJOBS] == 1) {
				outputText("Turning to Phylla, you can't help but smile as you flash her a seductive look, making sure you have her undivided attention before glancing down at the bulge in your pants.  Raising a hand to her mouth in sultry intrigue, Phylla giggles and shoots you a devilish look back.  Turning towards the bed, Phylla presumptuously begins to disrobe...  close!  But not what you had in mind.");
				outputText("\n\nCrossing your arms, you let out a loud cough in order to redirect the confused ant morph's attention back to you.  She turns around slowly, obviously uncertain of what you have in mind for intimacy.");

				outputText("\n\n\"<i>I thought...  I mean...  that look...</i>\"  She struggles to relay why she was undressing to you.  With a raised eyebrow and a perverted, inviting grin, you beckon her to come back over to you.  Eager, aroused, and a little nervous, Phylla clatters over to you, trying her best to put on her most seductive strut for you, though her inexperience shows.  She almost trips over herself as she throws one leg in front of the other, hips and abdomen in sway.  It's a bit awkward to watch. Nevertheless, you can't help but be aroused as she finishes her little walk.  Her emerald green eyes gaze into your own eyes with wanting and impatient anticipation for your next instruction.");

				outputText("\n\nRaising your arms up to her sides, you pull her in close and begin to glide your hands up her stomach.  Teasingly, you caress her breasts as your hands glide to her shoulders.  When your hands stop atop her chitinous shoulders you smile at her thinking: this is where the fun begins.  Pushing down on her shoulders you show her exactly what's in store.  Feeling her shoulders stand stiff for a moment, lingering just long enough before the realization strikes her.  You continue to guide her until she's down to her knees.  Hearing her chitinous knees clatter against the stony floor brings a smile to your face. Giggling in surprise, she rubs the outline of your package through your pants.");
				outputText("\n\n\"<i>Y-you want me to...  I mean...  I've never...</i>\"  She shyly wavers between her growing sexual emotions and trying to keep a royal attitude.  Her eyes are locked on your growing package, rubbing at the bulge in your pants, lost in contemplation on how to do this act.  Slowly closing her eyes, she takes a deep breath as if preparing herself to the task you've set for her.  Opening her eyes slowly, she shuffles on her knees to the side your bulge is protruding down.  She coos while attempting to give you a good angle of her face; you catch her lustful and flirty gaze from behind her eyebrows.");

				outputText("\n\n\"<i>I-I guess I could give it a shot...  I mean...</i>\"  She stammers, deciding to abandon her following words and get down to business.");
			}
			//Subsequent Blowjobs:
			else {
				outputText("Approaching Phylla, you cross your arms and lean against the wall of her bedchamber while sporting a tell-tale tent in your pants.  Phylla stares down at your bulge and picks up immediately on your intentions.");
				outputText("\n\n\"<i>Y-You gonna ask me nicely, or let your penis");
				if (player.cockTotal() > 1) outputText("es");
				outputText(" do all the convincing?</i>\"  She teases.  Shrugging, you inform her that whatever works for her works for you.");
			}
			//Continued...
			//If Phylla is not Laying Eggs:
			if (flags[kFLAGS.PHYLLA_EGG_LAYING] == 0) outputText("\n\nPhylla can't help but grin as she walks over to you, zeroing in on your crotch as she closes in.");
			//If Phylla is Laying Eggs:
			else outputText("\n\nPhylla looks a little stuck as she attempts to shift her egg-enlarged abdomen.  \"<i>I'm s-sorry I can't...</i>\" she says, looking on the verge of tears.  Taking a hint you walk over to her and climb atop the bed, leaving your package on an equal level with her mouth.  She immediately locks on to you with her eyes...");

			//First time:
			if (flags[kFLAGS.PHYLLA_BLOWJOBS] == 1) outputText("\n\n\"<i>Oh!  I get the meal delivered to me.  H-How... kind of you.</i>\"");
			//Subsequent times:
			else outputText("\n\n\"<i>Breakfast in bed?  Y-You shouldn't have.</i>\"  She coos playfully.");
			sceneHunter.callFitNofit(scene, 60);

			function scene(x:int):void {
				//Dick size less than 60 inches:
				if (player.cockArea(x) < 60) {
					outputText("\n\nWithout even having to utter a word, Phylla jumps right in and starts to work your [cocks] free of ");
					if (player.cockTotal() == 1) outputText("its");
					else outputText("their");
					outputText(" oppressive trappings. You can feel her undoing the straps of your clothes before gazing at the significantly larger bulge that is held behind the fabric of underwear.  \"<i>How many layers of wrapping do you have on this thing?</i>\"  Phylla jokingly teases, hints of her shy and nervous nature can be heard as she fools around with you.");

					outputText("\n\nWith both sets of fingers placed in the fabric band of your undergarments, Phylla pulls downward and releases your [cocks], ");
					if (player.cockTotal() > 1) outputText("all ");
					outputText("bobbing up");
					//Dick size less than 5 inches:
					if (player.cocks[x].cockLength < 5) outputText(" \"tall\" and proud, rock hard and ready for action.");
					else outputText(" tall and proud, rock hard and ready for action.");
				} else {
					//Dick size more than 60 inches (First Time):
					if (flags[kFLAGS.PHYLLA_BLOWJOBS] == 1) {
						outputText("\n\nPhylla jumps in to tug and free your member");
						if (player.cockTotal() > 1) outputText("s");
						outputText(" from your pants, but apparently doesn't realize just how big ");
						if (player.cockTotal() == 1) outputText("this");
						else outputText("these");
						outputText(" battering ram");
						if (player.cockTotal() > 1) outputText("s");
						outputText(" can get.  Chuckling at her ignorance, you tell Phylla she'd better back up.  Phylla rolls her eyes and looks up at you, giving you an unamused look.");

						outputText("\n\n\"<i>I-It can't be THAT big, [name]...</i>\"  She chiddingly remarks, causing you to raise an eyebrow in eager amusement.  You know she's not ready to meet the challenge you're about to unleash upon her.");
						outputText("\n\nYou work to release yourself from your clothing.  Once you're completely free you watch as Phylla's eyes widen in horror.  Smiling, you start to stroke your [cocks] and work ");
						if (player.cockTotal() == 1) outputText("it");
						else outputText("them");
						outputText(" up to a full raging erection, achieving your maximum state of \"<i>readiness</i>\" in no time at all.");

						outputText("\n\nDumbfounded, Phylla stares in awe at how big your [cocks] can really get; you can see the look of complete intimidation on her face and who could blame her?  You've seen ship cannons that pale in comparison to your man meat.");
						//If multiple cocks:
						if (player.cockTotal() > 1) {
							outputText("\n\nShe's staring down a mighty series of threatening fleshy spears.");
						}
						outputText("\n\n\"<i>I don't know if I can... wow...</i>\" She sputters out.  Laughing out loud, you grin down at her and inform her that, in this instance, her slight ignorance IS bliss.  Twitching the muscles in your [cocks] to bob a bit in her face you let her know that you rose to the challenge; now it's time for her to \"<i>fulfill</i>\" her end of the bargain: the cock end that is.");
					}
					//Dick size more than 60 inches (subsequent blowjobs):
					else {
						outputText("\n\n\"<i>Okay, you're gonna have to be careful so we don't have a repeat of ");
						if (flags[kFLAGS.PHYLLA_BLOWJOBS] == 2) outputText("last time");
						else outputText("our first time");
						outputText(".  I'll help to free ");
						if (player.cockTotal() == 1) outputText("that monster");
						else outputText("those monsters");
						outputText(", but p-please be careful about my valuables.</i>\"  Phylla asks nervously.");
						outputText("\n\nYou tell her that as long as she's helping, there shouldn't be any \"<i>accidents.</i>\"  With synchronous effort, your hulking [cocks] ");
						if (player.cockTotal() == 1) outputText("is");
						else outputText("are");
						outputText(" freed once more, ready and raring to \"re-acquaint\" with Phylla.  Taking the hint, Phylla closes in and takes the ");
						//Dick size less than 16 inches:
						if (player.cocks[x].cockLength < 16) outputText("base");
						else outputText("middle");
						outputText(" of your shaft against her tongue.  You hear a mix of a giggle and hum as she drags her tongue towards the head of your " + cockDescript(x) + ".  Phylla teases your shaft as she reaches the peak and suckles at your urethral opening.  You feel her drawing up as much pre-cum as she can and lapping it up like she's dying of thirst.  She continues this for a bit, until it becomes apparent that she's either not too sure of what else to do, or that she's never heard of how to properly fellate someone.");
						outputText("\n\nWith a chuckle, you pull your " + cockDescript(x) + " away from her mouth and ask her to look up at you. Clearly embarrassed at your realization of her skills, she begins to tremor softly.  \"<i>S-sorry! I mean, I've never done this!  This act is uncommon for my people.  Such things are not proper for a queen to be...  taught, or learn.</i>\"  She apologizes, begging your forgiveness with her body language and demeanor.");
					}
				}
				menu();
				addButton(0, "CalmHer", purePhyllaBJOver);
				addButton(1, "ForceHer", corruptPhyllaEndings)
					.disableIf(player.cor < 66 - player.corruptionTolerance, "Not corrupted enough!");
			}
		}

//Pure BJ:
		private function purePhyllaBJOver():void
		{
			clearOutput();
			var x:int = player.smallestCockIndex();
			outputText("You quickly and softly tell her to calm down, she needn't worry; you'll be more than happy to help her learn how as surely as she would help you if your situations were reversed.  At the mention of counter positions she nods cheerfully.");
			outputText("\n\n\"<i>You... know I'd d-do anything for you... I'll get good, I will!</i>\"");

			outputText("\n\nHappy and secure that you're willing to tolerate her lack of experience, Phylla lowers herself back down to your " + cockDescript(x) + " and gives you a tender lick on your head, slurping in all the pre-cum you've been accumulating.  You opt to help her with a more direct approach; you lower your hand down to her chin and tilt her head up so her eyes meet yours.  The tension in Phylla's jaw is fierce, and you tell her that she's putting too much thought and effort into this: just relax. You move your thumb over her lips and part her mouth slightly.  A calm washes over her as your directive registers.");
			outputText("\n\nPeacefully, you tell her to open her mouth just a bit and to let your " + cockDescript(x) + " slide into her mouth, advising her to watch the teeth.  Once she's got it in there, you tell her she can massage your head with her tongue and lips to begin with.  Eventually she'll work her way up to experimenting with the interior of her mouth.  Then, once she gets that down, she can take you into her throat, but that's a more 'advanced technique.'");
			outputText("Taking your directions, Phylla takes the head of your cock along the top of her wet and humid tongue, leisurely batting around before trapping it with her lips.");

			//(If PC has Multidicks Add Section  - Multidick)
			//(If PC likes Anal Add Section - Anal)
			//(If PC has Vagina Add Section - Vagina)
			//(Else Continue to - Continuation)
			//Multidick:
			if (player.cockTotal() > 1) {
				outputText("\n\nGasping for a brief moment, you ask Phylla to tend to ");
				if (player.cockTotal() == 2) outputText("your other dick");
				else outputText("the rest of your dicks");
				outputText("; if she would be \"<i>so kind.</i>\" With gusto, her four hands shoot up and take your ");
				if (player.cockTotal() == 2) outputText("cocks into their firm grips");
				else outputText("cock into their firm grips");
				outputText(".  Phylla mumbles something but absentmindedly realizes she still has your cock in her mouth and gives up on whatever it was she was trying to say.");
			}
			//Vagina:
			if (player.hasVagina()) {
				outputText("\n\nYou ask Phylla if she can take care of your womanhood while she's at it.  Phylla moves one of her small arms in between your legs and rubs against your " + clitDescript() + ".  She caresses your labia in between her fingers before inserting them inside of you.  Phylla begins working her wrist diligently in conjunction with her head bobbing.");
			}
			//(Transitions to Continuation, below)
			//Continuation:
			outputText("\n\nPushing her short brown unkempt hair back past her ears, you take hold of her head and gently guide her mouth along all the sweet spots on your rod.  As she does, you give her tips on how to better adapt her \"<i>technique.</i>\"  You learn that she's a quick study as she uses your suggestions to hit your sweet spots with startling precision... for a rookie.");
			outputText("\n\nMinutes fly by as you \"<i>teach</i>\" Phylla how to give proper fellatio, the time notably marked by some sensual moaning on your part... and some corrections in other parts when Phylla gets a little carried away with her sucking or when you feel teeth. Still, for her first time she's doing pretty well.");
			outputText("\n\nAfter a while of this, you think Phylla doesn't need guidance anymore and you start to relax yourself.  However, Phylla removes your cock from her mouth right as it's getting good.");
			outputText("\n\n\"<i>T-this... doesn't do me...  I~mean... I'm in heat now... can we join so... I can feel this too?</i>\" She looks as if she didn't want to say it at all but her growing sexual appetite seems to be overtaking her timidness.");
			//[Sure]  [Nope]
			menu();
			addButton(0, "Sure", surePhyllaLetsFuck);
			addButton(1, "Nope", nopeNotOnMouthOrWhateverFuckThisNoise);
		}

//[Sure]
		private function surePhyllaLetsFuck():void
		{
			clearOutput();
			var x:int = player.smallestCockIndex();
			outputText("\"<i>We'll have to... kiss...  I mean, I can still taste you... inside my mouth...  I could go wash or... ah~!</i>\" You cut her off by pulling her mouth on to yours.");

			outputText("\n\nLike a tidal wave, her pleasures and emotions become one with yours, and you can feel the sensation of her longing for more of your " + cockDescript(x) + " along her tongue.  You feel how her mind has given into the texture, the scent, the taste of your dick.  It's almost as though she doesn't want to stop - how cute she finds stimulating that one little area of your dick when she wants a shot of pre or how she wants to coax more and more precum out of you until you explode in her mouth.  You feel her wanting to try some more of those 'advanced techniques' you mentioned before, wanting to try and drive your cock down her throat and flood her gullet with all the cum you can muster.  A symphony of ideas and images ring out, drowning your thoughts and overwhelming you with a single chorus chant.  Phylla's voice stands out: \"<i>Cum. Cum! CUM! <b>PLEASE I NEED IT! CUM!</b></i>\"");

			outputText("\n\nYou open your eyes to find Phylla staring up at you; you didn't even feel her break the kiss.  Never breaking her longing gaze, she once again wraps her mouth around your member and starts bobbing up and down.  Her eyes continue to lock on yours looking like a begging dog.  You feel the shaft and head of your cock rub along her lips as if you were fellating your own member.");
			//If PC can Autofellatio:
			if (player.canAutoFellate()) outputText("\n\nThis isn't really a new experience for you, but it's different this time as you feel Phylla's mind being overcome with the need for your nectar.");
			outputText("\n\nShe beseeches both your mind and your body to orgasm and fill her mouth and stomach with your seed.");
			//(Leads to - Pure BJ Ending)
			pureBJEnding(true);
		}

//[Nope]
		private function nopeNotOnMouthOrWhateverFuckThisNoise():void
		{
			clearOutput();
			outputText("You pass on her offer, not wanting to know what THAT sensation");
			//If PC can't Autofellatio:
			if (!player.canAutoFellate()) outputText(" or anything like it would feel like.");
			else outputText(" feels like with Phylla's mind linked to your own.");

			outputText("\n\nShe whines playfully, but respects your wishes. Getting back into it, she doesn't hold back. Acting as if this is a daily routine for her, she once again stimulates that one little area of your dick when she wants a shot of pre.  You can feel how she wants to coax more and more precum out of you until you explode in her mouth, how she wants you to drive your cock down her throat and flood her gullet with all the cum you can muster.");
			outputText("\n\nYou open your eyes to find Phylla staring up at you, never breaking her longing gaze as she gives a look that begs, beseeches you to orgasm and cave to her desires for your seed.");
			//(Leads to - Pure BJ Ending)
			pureBJEnding(false);
		}

//Pure BJ Ending
		private function pureBJEnding(linked:Boolean = true):void
		{
			outputText("\n\nTo your surprise, Phylla has fully embraced this new talent you've helped 'teach' her");
			if (!linked) outputText(".");
			else if (flags[kFLAGS.TIMES_LINKED_BJ_SUCK] == 0) {
				outputText(", ");
				//If PC linked, first time occurring:
				outputText("leading to you jesting through the link and calling her a damn dirty cheater.");
			}
			if (flags[kFLAGS.TIMES_LINKED_BJ_SUCK] > 0) outputText("  You can feel her relying less and less on the link with every subsequent time; there's no doubt in your mind that she will no longer \"<i>cheat</i>\" her way into making you cum before you know it.");
			var x:int = player.smallestCockIndex();
			outputText("\n\nShe giggles up at you as she bobs back and forth along your shaft, sensing the telltale signs of your pending orgasm with her mouth.  When you feel the moment of climax finally arrive, you grab onto the back of her head with your hands. She jumps at the unexpected feeling, but before she can react you roar, thrusting your hips forward.  Phylla, like a pro, times her motions with your release, drawing a steady stream of semen out of your rod.  With each spasm of your cock you shoot your cum into her mouth.  She doesn't relent until she's got a mouthful, pulling free of your " + cockDescript(x) + " as ");
			if (player.cumQ() < 250) outputText("thin");
			else if (player.cumQ() > 1000) outputText("thick");
			outputText(" strands of cum hang wildly between her lips and your prick.");
			//If cum volume over 1000ml::
			if (player.cumQ() > 1000) outputText("  Though she might have a mouthful, you're not finished yet!  You continue to unload the remainder of your hot load on her breasts and stomach.");
			if (player.cockTotal() > 1) {
				//If multi cock::
				outputText("  Your other cock");
				if (player.cockTotal() > 2) outputText("s shower");
				else outputText(" showers");
				outputText(" her hands and body in your white goo as she continues to pump ");
				if (player.cockTotal() == 2) outputText("on each of ");
				outputText("them lovingly.");
			}

			outputText("\n\nWith a heavy sigh, and significantly lighter ");
			if (player.hasBalls()) outputText("balls");
			else outputText("in the pelvis");
			outputText(", you rub Phylla's hair playfully");
			if (flags[kFLAGS.PHYLLA_BLOWJOBS] != 1) outputText(".");
			//If first time:
			else outputText(" and congratulate her on her first time.");

			outputText("\n\nShe smiles, but you notice that her cheeks are puffed up; turning your head quizzically, you ask Phylla what's she doing.  Embarrassed, she blushes and opens her mouth.  All of your deposit clings to her tongue and teeth. She can't talk but you can tell that she's looking for direction.");
			player.sexReward("saliva","Dick");
			//[Swallow it up]   [Spit it out]
			menu();
			addButton(0, "Swallow It", swallowDatJismPhylla);
			addButton(1, "SpitItOut", spitItOutYouCunt);
		}

//[Swallow It]
		private function swallowDatJismPhylla():void
		{
			clearOutput();
			outputText("Placing your hands on your hips, you smirk and tell Phylla that a true queen never spits. Phylla shoots you a slutty look and gulps your load greedily, taking a moment to savor the warmth and texture as it works its way down her throat.  She ahhhs loudly as she rubs her stomach, humming in pleasure as the steamy load spreads its heat to her belly.  \"<i>Thank you, [name].  That hit the spot.</i>\"");
			doNext(camp.returnToCampUseOneHour);
		}

//[Spit it out]
		private function spitItOutYouCunt():void
		{
			clearOutput();
			outputText("Crossing your arms, you tell Phylla to spit your load out.  As you dress yourself back up in your [armor], you hear Phylla frantically dig out a hole in the floor.  She playfully leans over and spits the salty payload into it.  She makes a soft hum when she's finished, before quickly covering it up again.  \"<i>Thank you, [name].  Next time I'll do better, I promise.</i>\"");
			doNext(camp.returnToCampUseOneHour);
		}

//Corrupt BJ Ending
		private function corruptPhyllaEndings():void
		{
			clearOutput();
			var x:int = player.smallestCockIndex();
			outputText("\"<i>A slut that can't suck a dick... how can this get any worse?</i>\"  You ponder to yourself while rubbing your nasal bridge. You tell the innocent little ant that she'll learn how to suck a mean cock, even if it kills her.  You're knee-deep at this point - might as well turn her into something salvageable.  Commanding her attention, you lift her face up and hover your " + cockDescript(x) + " close to her lips, smothering her lips with your precum.  She attempts to turn away but you react before she can.  Holding her head in place you comment on how this is what you want from her.");
			outputText("\n\n\"<i>Open wide!</i>\"  You forcefully tell her.  Phylla does it immediately, seeing that you're using your 'serious voice.'  You slide your cock in and smash into her tongue.  Smirking, you instruct your fuck toy to close up her mouth and form a tight seal around your rod; you have no intention of fucking an orifice that resembles a goblin brood mother's twat.  Phylla complies, but pulls away to hesitatingly ask if she's ");
			//If first time:
			if (flags[kFLAGS.PHYLLA_BLOWJOBS] == 1) outputText("achieved the desired effect.");
			//Every other time:
			else outputText("improved since the last time.");

			outputText("\n\nYou brutishly confirm she has by grabbing the back of her head and shoving it back onto your cock.  With an apathetic tone, you snidely remark that this is how she needs to react every time you approach her.");
			outputText("\n\nPhylla groans at the rough treatment, not used to being treated so coarsely as your " + cockDescript(x) + " lunges back and forth in her mouth, grinding along her cheek and tongue. Your cock seems to have a mind of its own as you somehow manage to wrap her tongue around yourself, knowing full well Phylla lacks the technique required to do it on her own.  The little queen is about to receive a rude awakening about pleasing her master.");
			outputText("\n\nMoan after muffled moan escapes from Phylla's mouth as you continue your callous fucking of her delicate little face.  Your little slut is trying her best to keep up with your thrusts but is ultimately failing.  Perhaps she needs a little motivation?  Withdrawing your " + cockDescript(x) + ", you tell her she doesn't get to suck your dick any more unless she fingers her tight little hole. Desperate to fulfill your desires, she quickly darts a hand to her pussy and fingers that little fuckhole like her life depends on it.  Within seconds, you see her long clit protruding, begging to be touched.");

			//(If PC has Multidicks Add Section  - Multidick)
			//(If PC likes Anal Add Section - Anal)
			//(If PC has Vagina Add Section - Vagina)
			//(Else Continue to - Continuation)
			//Multidick:
			if (player.cockTotal() > 1) {
				outputText("\n\nGasping for a brief moment, you ask Phylla to tend to ");
				if (player.cockTotal() == 2) outputText("your other dick");
				else outputText("the rest of your dicks");
				outputText(" if she would be \"<i>so kind</i>\".  With gusto, her four hands shoot up and take your cocks into their firm grips.  Phylla mumbles something but absentmindedly realizes she still has your cock in her mouth and gives up on whatever it was she was trying to say.");
			}
			//Vagina:
			if (player.hasVagina()) {
				outputText("\n\nYou ask Phylla if she can take care of your womanhood while she's at it.  Phylla moves one of her small arms in between your legs and rubs against your " + clitDescript() + ".  She caresses your labia in between her fingers before inserting them inside of you.  Phylla begins working her wrist diligently in conjunction with her head bobbing.");
			}
			//Continuation:
			outputText("\n\nCongratulating her for her hasty heeding of your wishes, you ram your " + cockDescript(x) + " back into her mouth and continue the face fucking once more.  Phylla picks up the effort as she starts working her head and tongue in tandem with your hips.  Soon she's driving you perilously close to an orgasm.  With one last directive, you ask Phylla if she's ready to receive your seed.  Though since you continue your brutal fucking of her mouth, she has no opportunity to reply.");
			outputText("\n\n\"<i>WELL?!</i>\" You cheekily yell, making sure your shout echoes off the walls.  Phylla looks up at you with glazed over eyes, letting out a soft appreciative moan from behind your cock.  You act deaf and decide to ask her again, telling her you can't quite \"<i>hear</i>\" her.  Another moan, much louder than the last, rings out from Phylla's full mouth.  Her tongue works at a rapid pace, as if begging you to flood her mouth with your cum and drown her taste buds in your salty surprise.");
			outputText("\n\n\"<i>That's more like it,</i>\" you think to yourself, lowering your other arm to the back of her head as you pump her like the local well.  The pressure in your loins cannot be contained any longer; the orgasm your body craves will not be denied this day!  Your cock flexes as a wave of ecstasy washes over you.  Grunting with great relief and release, your semen rushes into her mouth, filling her wanting craw with your salty jizz on the first salvo.  Her tonsils take the brunt of the second salvo, followed by the back of her throat for the third.  Pulling out, you point your spasming spear of lust into Phylla's face, giving her a ");
			// If PC has under 10ml of Cum:
			if (player.cumQ() < 100) outputText("tiny");
			else if (player.cumQ() < 1000) outputText("respectable");
			else outputText("massive");
			outputText(" facial, covering her petite features in cum.");

			//Silly Mode, cum multiplier huge  (Red Letter Media reference)]:
			if (silly() && player.cumQ() >= 5000) {
				outputText("\n\nYet, your constant stream does not stop.  It gets worse - much worse!  The flow of cum simply cannot be controlled as your loins release their fury into Phylla's face.  \"<i>OH, GOD! I CAN'T STOP CUMMING! OH, FUCK!</i>\" You howl out.");

				outputText("\n\nPhylla certainly doesn't mind though, bathing her body in your torrent of cum as you continue your painful and torturous ejaculation.  The pain causes your deranged howls to become deeper and longer, echoing throughout the colony as your body squeezes your loins like a package of soy, emptying you out all over your horny slut until there's no sperm left in your ");
				if (player.hasBalls()) outputText("[balls]");
				else outputText(cockDescript(x));
				outputText(".  Somehow, you succeed your fortitude roll and remain conscious without passing out even after plummeting to the ground from sheer exhaustion.  You and Phylla can't help but slowly drift off to sleep in a pool of your cum to dream about the bizarre pleasures you two have indulged in.");
			}
			//(If silly mode is engaged. Transition to End of blowjob scene (silly)
			//(Else transition to end of blowjob scene (non-silly)
			//End of blowjob scene (non-silly mode)
			if (!silly()) {
				outputText("\n\nPhylla works your " + cockDescript(x) + " the entire time you cum, as if pleading for just a little more to come out.  You grab her hands, signaling you had just about enough.  Coming down from your climax, you thank your slut for the oral and sit down on the bed and start gathering your scattered clothing.");
				outputText("\n\nHowever, you realize Phylla isn't done with her clit yet.  You had almost forgotten you even asked her to play with herself in the first place.  She sits back against the cushion that you might consider her \"<i>headboard</i>\", spreading her legs wide, giving you a full view of herself.  You dismissively tell her to finish herself off, watching in both pride and amusement as your slut eventually brings herself to orgasm.  She violently arches her back, forcing herself up onto her knees as she rubs her cunt furiously.  Her juices seem to flow freely and pool below her. Her moans of orgasm ring through your being and it brings you a great sense of joy at her ability to listen to and obey her master's commands.  Once you're sure she's finished up, you're amazed by the amount of cum she produces as the liquid seems to squirt out from between her legs long after her own orgasm.  You decide to help Phylla to her feet; can't have injured or sidelined lovers, can you?");
			}
			//End of blowjob scene (silly)
			else {
				outputText("\n\nAs you stir from your impromptu slumber, you feel the pangs of discomfort shooting up your back. Sleeping on the floor sounds good when you're dead tired, but you always end up regretting it when you wake from the land of dreams. Rising to your feet, you take note of the impact you've had on Phylla's room; she's gonna be busy cleaning this place up to be sure.  The quiet groan of bliss coos forth from your naive lover, and for a moment you are left to consider leaving her on the floor and getting on with your day. Though, can you afford a sidelined lover when your loins stir with need once more?");
			}
			//***Both mode endings converge here***
			outputText("\n\n...Can you? You muse again, thinking about it.  After a few moments of helping Phylla to the pile of, now very wet, cushions she calls a bed, you finish donning your [armor] and head back to the surface.");
			player.sexReward("saliva","Dick");
			dynStats("cor", 5);
			doNext(camp.returnToCampUseOneHour);
		}

//\"<i>Use Dick</i>\"
		private function dickPhylla():void
		{
            //shitty implementation, but sounds logical
            var cockTmp:int = -1;
            var cMcnt:int = -1;
            var mouthTent:Boolean = false;
            //pick one for vag
			var cockVag:int = player.findCock(1, -1, phyllaCapacity);
			var cockMouth:int = -1, cockHand1:int = -1, cockHand2:int = -1;
			if (cockVag < 0) cockVag = player.smallestCockIndex();
            if (player.cockTotal() >= 2) {
                //try to pick non-tentacle for mouth
                while (true) {
                    cockMouth = player.findCock(cMcnt, 20, 30, "length");
                    if (cockMouth == -1)
                        break;
                    if (cockMouth != cockVag && player.cocks[cockMouth].cockType != CockTypesEnum.TENTACLE && player.cocks[cockMouth].cockType != CockTypesEnum.STAMEN)
                        break;
                    ++cMcnt;
                }
                //pick tentacles - no max size, they can wiggle
                if (player.countCocksWithType(CockTypesEnum.TENTACLE, 20, -1, "length") > 0) {
                    cMcnt = -1;
                    while (true) {
                        cockTmp = player.findCock(cMcnt, 20, -1, "length");
                        if (cockTmp == -1)
                            break;
                        if (cockTmp == cockVag || cockTmp == cockMouth || cockTmp == cockHand1 || cockTmp == cockHand2) {
                            if (cockMouth == -1) {
                                cockMouth = cockTmp;
                                mouthTent = true;
                            }
                            else if (cockHand1 == -1)
                                cockHand1 = cockTmp;
                            else if (cockHand2 == -1) {
                                cockHand2 = cockTmp;
                                break;
                            }
                        }
                        ++cMcnt;
                    }
                }
            }
            //start
			clearOutput();
			if (player.countCocksWithType(CockTypesEnum.TENTACLE, 20, -1, "length") == 0)
				sceneHunter.print("Okay, just take more tentacle dicks. It'll be fun.");
            phyllaSprite(true);
			outputText("You give Phylla a devious look that denotes you didn't come here to just talk.  She looks a little surprised and embarrassed for you as you start removing your [armor].  Noticing her watching, you pull each article of clothing off a little slower, letting her lust build.  You seductively drop your armor, completely revealing yourself to her.  You can see her eyes widen as she visibly feasts on your features.");
			//(NO BJ experience)
			if (flags[kFLAGS.PHYLLA_BLOWJOBS] == 0) {
				outputText("\n\nYou see it suddenly dawn on her that you're completely nude. Phylla quickly turns her head away but you see her eyes still very focused on your manhood");
				if (player.cockTotal() > 1) outputText("s");
				outputText(".");
				outputText("\n\n\"<i>I... what do you want me to...?</i>\"");
				outputText("\n\nCutting her off, you gently place your hand on the back of her head as " + sMultiCockDesc() + " hardens even further.  With a slight pressure you force Phylla's head down onto the head of [oneCock]. At this point she gets the picture.");
			}
			//(Phylla has BJ experience)
			else {
				outputText("\n\nLeaving all modesty behind, she scampers over and quickly drops down to her knees, taking your quickly hardening cock into her mouth and against her tongue.  You feel it wrap around the head of your penis as she starts bobbing her head trying her best to fit as much of you into her mouth as she can.");
			}
			outputText("\n\nOnce she's gotten you sufficiently stiff, she uses her tremendous strength to push you onto your back - clearly she wants to be on top first.  Holding your shoulders with her two upper hands, she guides your cock to meet her dripping cunt with her lower two.");

			//(If Phylla is not laying Eggs)
			if (flags[kFLAGS.PHYLLA_EGG_LAYING] == 0) outputText("\n\nPhylla bends her abdomen so that the underside tip of it runs down the ridge of your shaft, leaving a very warm clear liquid on your privates that tingles, causing you to groan in pleasure.");

			outputText("\n\nOne of her lower hands starts to slowly pump your member as she starts to touch her long clit with the other.  Even pinned as you are, you can see her clit start to grow and stick out between her lips.  \"<i>Can I...  I mean... can I put you... inside me?</i>\"");

			//3-4 times:
			if (flags[kFLAGS.PHYLLA_FUCKS] >= 3) outputText(" she asks playfully, knowing full well that that's what you came here for.");
			//(First time)
			else if (flags[kFLAGS.PHYLLA_FUCKS] == 0) outputText(" You nod quickly.");
			//(Subsequent fucks)
			if (flags[kFLAGS.PHYLLA_FUCKS] > 0) outputText("\n\n\"<i>Do you have to ask?</i>\"  You ask her while grinning mischievously; something that causes her to smirk back at you.");

			//3-4 times:
			if (flags[kFLAGS.PHYLLA_FUCKS] >= 3) outputText("\n\nShe seems like she's losing some of her shyness, or at the very least feels comfortable enough around you to assert more of her personality.");

			outputText("\n\nYou watch as she spreads herself apart for you and guides your cock into her.  As the head of your penis enters her, she lets out a weak moan.  Then in a wicked attempt to make her cum, because you know it's so easy, you thrust your hips upwards forcing as much as you can into her.");
			outputText("\n\nHer eyes widen in surprise as your " + cockDescript(cockVag) + " fills her.  She howls a blissful scream as she drools forth her girl fluids, coating your cock ");
			if (player.hasBalls()) outputText("and balls ");
			outputText("in her sexual liquids.");

			outputText("\n\nWithout missing a beat, she starts to writhe on top of you, riding your cock.  You feel the walls of her pussy squeeze your cock in a pulsing beat.  Each time your cock is deepest inside her, she rocks her hips at the perfect angle so you experience the full pulsating brunt of her cunt along your shaft.  Phylla picks up speed as her hips rise and fall on you, faster and faster.  Her quiet moaning turns to unabashed screams as waves of pleasure wash over both of you with each thrust.");

			outputText("\n\n\"<i>I... this feels... gods!  More!</i>\"  You hear Phylla's futile attempts to construct a sentence between ecstatic exhales and moans.  She throws her head back, arches her back and shifts her upper hands from your shoulders to your legs as she starts to ride you like you're a stolen stallion. Glancing between your legs you see her clit peeking out from between her folds as her body pumps away on top of you.");

			outputText("\n\nReaching down you give her hardening love knob a light pinch.  This causes your lover to roar in pleasure, and momentarily pause her thrusts onto you.  \"<i>Harder!  Please!</i>\"  She implores you as she picks up her pace.");

			//PC has only two to four dicks, and a vagina:
			if (player.cockTotal() >= 2 && player.cockTotal() <= 5) {
				if (player.hasVagina()) {
					outputText("\n\nAs Phylla pleasures your cocks she uses another hand to make sure your lady parts are seen to as well.");
					//(Transitions to Vagina Dialog)
				}
				else {
					outputText("\n\nYou look at Phylla and shrug at her, telling her you aren't sure if you can do that, given that you have some... 'members' that are feeling a little left out.  With a flirty yet annoyed expression,  your lover reaches down and takes hold of your unloved  [cocks].  She coos as she starts to pump ");
					if (player.cockTotal() == 2) outputText("it");
					else outputText("them");
					outputText("slowly.");
					//(Transitions to First Time/Subsequent Times)
				}
			}
			//PC has over five dicks:
			if (player.cockTotal() > 5) {
				if (player.hasVagina()) {
					//PC has over four dicks and a vagina:
					outputText("\n\nAlthough she attempts to use all of her hands to pleasure as many cocks as she can, even switching between them proves to be too much for the ant morph.  \"<i>There's too many; I can't take care of all of them!</i>\"  You gesture to your [vagina], as if to tell her she can at least take care of three of your cocks and your wet pussy.");
					//(Transitions to Vagina Dialog)
				}
				else {
					outputText("\n\nAlthough she attempts to use all of her hands to pleasure as many cocks as she can, even switching between them the task proves too much.  \"<i>There's too many; I only have so many hands! I can get four of them but the rest will have to remain unattended for now.</i>\"  You sigh, but you knew that might have been a problem going in so you tell Phylla to do what she can.");
					//(Transitions to First Time/Subsequent Times)
				}
			}
			//Vagina Dialog:
			if (player.hasVagina()) outputText("\n\n\"<i>Let's see how you like it!</i>\" Phylla whispers being playfully aggressive.  She reaches down with one of her uncocked hands and pinches your [clit].  Immediately a wave of euphoria washes over you and you respond by giving her long clit a pinch back.  You both moan in unison, then look at each other and chuckle, breathing heavily.");
			//First Time, PC is multi-genitaled:
			if (player.gender == 3) {
				if (flags[kFLAGS.PHYLLA_FUCKS] == 0) outputText("\n\n\"<i>God I have to get better at this, leaving my lover's sex all alone...  L-let me fix that.</i>\"  She spits out between moans of pleasure, slightly embarrassed that she forgot her lover's OTHER genitalia. Wasting no time in order to make up for her \"<i>mistake,</i>\" Phylla does her best to please every part of your body.");
				//(Transitions to Phylla does Vulcan shit to PC)
				//Subsequent Times, PC is multi-genitaled:
				else outputText("\n\n\"<i>Y-you are really gonna push this, aren't you? Involving all of your genitalia?</i>\"  She delightfully teases you between moans of ecstasy. Smirking, you just say sometimes she forgets about all your other 'friends'.");
			}

			//Phylla does Vulcan shit to PC:
			outputText("\n\nSatisfied, you give her love button another good hard pinch between your thumb and index finger.  \"<i>Oh, please, don't sto~!</i>\" She tries to say as her breath is stolen away - a labored moan is all that escapes as you feel her insides tighten around your dick.  The warmth of her body sends surges of pleasure up your cock.  \"<i>I need...  I need more...</i>\"  She says panting.  You can see her eyes have got a strange glaze over them.  \"<i>I need you.  In my mind.  Now.</i>\"  She desperately states as she mindlessly lunges towards your face, connecting your lips with hers.");

			outputText("\n\nAs her tongue enters your mouth you feel your minds sync with each other immediately.  Your eyes roll up in the back of your head momentarily before you snap back into the present, feeling her needs, her desires, as she feels yours.  You see an image of the first time you mounted her and you have the distinct feeling she wants to do that again.  You feel her experiencing every detail, every contour of your cock inside her.  Savage, raw emotion overtakes all your senses as your mind attempts to deal with the relentless foreign influx of feelings, sensations, and thoughts.  It's hard to tell who's really, REALLY getting off to the sex at this moment.");

			outputText("\n\nPhylla's hips slow and eventually cease rocking on top of you.  The foreign desire to change positions quickly enters your mind.  Biting her lip, Phylla raises her hips and softly moans as the head of your cock flicks her clit on its way out of her drooling cunt.");

			outputText("\n\nPhylla turns herself to face away from you on all fours... or in her case, all sixes.  She raises her ass into the air as if beseeching you to mount her; the lingering taste of her connection to you gives you a small idea of the desire she has for having you dominate her and fuck her until you gush forth with the seed of life.  Her posture the only motivation you'll ever need, you shift your hips to insert yourself from behind her.  Her abdomen rises upward and she uses one of her smaller sets of arms to spread herself wide open for you.  She turns to look back at you and you feel her in your mind, calling for you to take her and for you to assume utter control of the act.");

			outputText("\n\nTaking her \"<i>hint,</i>\" you slam your cock into her pussy, making sure to get as deep as you can. Your initial thrust makes a very loud, squishy noise as your cock enters her soaked canal.  Your mind almost blacks out from the sheer sensual overload you both feel as a shared consciousness, unable to handle both hers and your own.  Phylla's head collapses into her hands as she releases a series of stammering moans.  Her hips twitch slightly with euphoria as she starts to slowly move up and down, her body desperately begging for more cock.");

            //PC has one-two dicks 42 to 48 inches in length:
			if(cockMouth >= 0) {
                outputText("\n\nWell, if she wants more dick, then maybe she can be persuaded to put her mouth to use?  Expertly positioning your pricks, you give her a quick jab in the chin in order to get her attention, causing her to look up at your over her shoulder.  You give her a knowing look and shoot a glance down at what poked her in the chin; she follows your gaze.  \"<i>Well, you did want more of them,</i>\" you convey to her with a wickedly playful grin, as though you're a kid in candy shop.  Phylla takes your  " + cockDescript(cockMouth) + " with a zeal you've never seen before, especially in a woman so shy and uncertain.");
                //and only then
                if (cockHand1 >= 0)
                    outputText("\n\nNot content with just a little oral attention, you slither your" + (mouthTent ? " other" : "") + " tentacle cock" + (cockHand2 >= 0 ? "s" : "") + " up to her hands and give them a hard smack, soliciting a surprised hum from Phylla.  Seeing her lover's tentacle penile appendage" + (cockHand2 >= 0 ? "s" : "") + " caressing the back of her hands helps to clue her in that she still has some \"<i>capacity</i>\" to service you.  Propping herself upwards with a pillow, Phylla takes to leaning on her elbows as she begins to stroke and tease your cock" + (cockHand2 >= 0 ? "s" : "") + ", coaxing a small flow of pre-cum in the process.");
                //shared
                outputText("\n\nTrying to please you as much as she can, Phylla diligently sucks on your long cock" + (cockHand1 >= 0 ? " and pleasures your flexible tentacle dick" + (cockHand2 >= 0 ? "s" : "") + " with her hands" : "") + " as your other cock is deep inside her. You feel her warm breath escape the seal she's made around the head of your cock when you hit the right spots inside her that cause her to moan.");
				player.sexReward("saliva","Dick");
            }
			
			//Doggy style Phylla:
			outputText("\n\nYou give her body what it wants as you start humping her; using her abdomen as a brace, you reach a very staccato rhythm with your thrusts as she spreads out all four of her arms in front of her to hold herself in place.  With almost every other pump you feel her mind and her body building to orgasm, flooding your mind with thoughts of doing the same.  Her cunt seems to be calling upon you to fill it as it clamps down tighter with each plunge of your cock.");

			outputText("\n\nHolding out just isn't feasible anymore, and with one more great slam into her, you get as deep as you can and pin [oneCock] inside Phylla as you release the hot seed of life.  As your grip tightens around her abdomen, you hear her let out a gleeful cry of satisfaction.  The quivering mass of meat spear causes her to orgasm as well, washing your lower body in her warm sweet-smelling girl cum.  You feel her transmit the feeling of her insides swallowing your load, as her pussy's spasming starts to subside.");

			outputText("\n\nYou both collapse in a hot, sweaty... and sticky heap, dozing off for quite some time only to wake after an hour of uninterrupted sleep, a bit hung over from the mind sharing and physically fatigued from the romp.");

			outputText("\n\nPhylla stirs next to you, and groggily says, \"<i>You should come down more often.  I mean...  I miss you sometimes...</i>\"  Her shyness returns as she slowly recovers from the small sex-coma you placed each other in.  You say you'll think about it and wink at her as you get dressed and head back to camp, leaving her to eagerly await the next time you come to take her once again.");
			player.sexReward("vaginalFluids","Dick");
            flags[kFLAGS.PHYLLA_FUCKS]++;
			doNext(camp.returnToCampUseOneHour);
		}

//Straight Sex (Lesbian/Fisting) - Written
		private function lesbianFisting():void
		{
			clearOutput();
			outputText("You give Phylla a seductive smile as you start to remove your armor; you came here for something all right, but the surprised look on your lover's face shows she hasn't quite caught on yet.  Her eyes dart back and forth between watching you disrobe and staring at the stony ground in a confused manner, as if torn between modesty and desire.  Flirtatiously, you toss your underwear on the ground in front of where Phylla's eyes seem locked.  Her head snaps up in surprise; you're not sure what she was expecting, but clearly seeing you in your birthday suit wasn't it.  You strut over to her, putting on your best version of a succubus's sway in your step.  Once you reach Phylla, you take a seat on the edge of her raised stone bed and slowly cross your legs.");
			outputText("\n\nYou ask Phylla to look at you.  As she does, you tantalizingly uncross your legs, spreading them open so Phylla can glimpse your exposed body. You even decide to go as far as to " + (player.hasBreasts() ? "grab one of your breasts and " : "") + "caress your nipple playfully.");
			outputText("\n\n\"<i>Do you... want me to... I mean, you know...</i>\" she says shyly as she blushes.");
			outputText("\n\nWithout saying a word, you extend your hand and beckon her over to you with a hooked finger. Raising your eyebrows seductively, you make your intent crystal clear for her.  She quickly scampers off the bed and kneels in between your [hips].  Her upper two hands hold your legs apart, resting on your inner knees.  Her smaller set of hands gently begin to massage your inner [legs] right on the sides of your pussy lips, driving pleasure through your thighs.  It's not long before beads of lubricant start to flow out of your quickly moistening labia, a slight moan of sexual excitement slipping past your lips as Phylla's tongue starts to lick the lubricant coming out of you, pausing only briefly to taste your juices in her mouth like a fine wine.  You fall forward as her mouth finds your cilt, wrapping your hands around her head to encourage her to continue.  Your legs attempt to wrap around her head but her upper arms' tremendous strength prevents them, leaving you \"<i>hopelessly</i>\" wide open for her assault.  Her lower hands stop massaging you, and for a moment leave you to wonder what's going on down there.  As you're about to ask why she stopped, her mouth plays erotically with your clit and one of her smaller hands spreads you wide open.");

			//If PC has cocks:
			if (player.hasCock()) outputText("\n\nNot wanting to deprive you of what your body painfully wants, Phylla grabs hold of [oneCock] and starts pumping away as she does wonders on your female anatomy with her mouth.");

			outputText("\n\nMoaning loudly into the air, the aroma of earth, sweat, and sex fills your nostrils.  You can't help but feel a little embarrassed to be so fully exposed to her, but that quickly passes as one of her fingers slips along your labia and brushes past the opening of your " + vaginaDescript() + ".  Guided by the wetness of your ever eager pussy, her hard fingertips slide forward into your body.  You moan again at this slow insertion.  Encouraged, Phylla rubs up and down the walls of your vagina, leisurely at first but with mounting vigor, searching for your G-spot.");

			outputText("\n\nHearing you moan louder and more deeply, her fingers prove dexterous as they reach deep inside you. Again your legs spasm and attempt to collapse on Phylla's head, but she holds firm, denying your lower body the closeness it craves with the lover that is penetrating your pussy so well.  You start to pant heavily, releasing soft moans every time her fingers go deeper into you.  She lovingly nibbles on your pleasure knob and thrusts yet another finger inside you.  You arch your back, crying out in intense pleasure and instinctually thrusting your hips towards her face, forcing it to grind on your cunt.");

			outputText("\n\nHer mouth releases from your cilt and her fingers slip out of you, sending a pleasing shiver down your spine.  You look between your legs as Phylla looks hungrily up at you, her mouth covered in your juices.  She runs her tongue along her upper and lower lips then starts to gracefully suck your nectar off of each of her fingers that were inside you, making sure not to miss any.");

			outputText("\n\nOnce she's done cleaning herself she starts to kiss her way up your body, making weak but cute sounds as she steadily climbs.  She runs all four of her hands across the most sensitive parts of your flesh as her small kisses make their way from your wet cunt up your stomach, in between your breasts, up the side of your neck, nibbling on your earlobe, and finally coming to rest on your own lips.  Your lips lock as she " + (player.hasBreasts() ? "cups your breasts with her large hands and " : "") + "pinches your pair of nipples with her smaller hands.  You begin to moan but Phylla's tongue enters your mouth and cuts off your attempt at vocalizing your euphoria, seemingly wanting you to show her your pleasure instead.");

			outputText("\n\nYour minds instantly synchronize with each other.  Sudden warmth is felt, an almost uncomfortable heat coming from between Phylla's legs.  As tongues entwine, you reach a hand down between Phylla's legs to feel the \"<i>flame</i>\" of lust right above her pussy.  Phylla's mind reaches out, begging for your touch, asking you to please her, to make love to her.  Knowing she's probably soaked, you reach up to touch the slick slit between her legs and are pleased to find you were right on the money.  Feeling her long stiff clit rub against your palm, she gasps as an unforeseen wave of pleasure shoots up her body.  Knowing the link is made, you break the kiss and grin.");

			outputText("\n\nHer whole body starts slowly thrusting on top of you, hard nipples rubbing against your own as she rocks back and forth, working her clit along your hand.  Suddenly, you curl two of your fingers around her on one of her gyrations backwards.  She moans loudly, her upper half collapsing onto your chest as she unknowingly forces your two fingers into her.  Her hips quickly start writhing on top of your fingers as she breathes sighs of ecstacy into your breasts.  Your fingers start to expertly work their way deeper and deeper into her with each thrust.  She sits upright on top of you, her vagina hovering just above your now drenched hand.  Feeling her in your mind... she's playfully hiding something from you but you can't find out what it is as you're lost in the shared pleasure.  Phylla's eyes meet yours and with an almost pleading tone she implores, \"<i>I need you, to do this, I want this... please~</i>\"");

			outputText("\n\nIn your mind's eye you see your fingers make a spear-like formation and you instantly understand what Phylla wants.  You smile wickedly as you heed her wish, making your hand like the tip of a spear, knowing full well what will happen next, and at that moment Phylla drops her hips.  You feel her excitement as all four fingers enter her with alarming speed and force, stretching the walls of her pussy wide, happening upon her G-spot in a sheer stroke of luck.  The link, sharing all of its intricacies and sensations, floods your body with the wild satisfaction this shy little woman has, and you scream in ecstatic pleasure.  One of Phylla's larger hands");

			//(If pussy is Virgin or tight:)
			if (player.hasVirginVagina() || player.vaginalCapacity() <= 10) outputText(" tries to fit itself into you, only managing to insert her fingers into your pussy.  Despite the \"<i>setback,</i>\" Phylla");
			//(If pussy is loose or gaping: Continues as follows...)
			outputText(" thrusts into your cunt simultaneously.  You feel her hit the right spot, and an explosion of ecstasy floods your bodies as your minds join together in shared orgasm.  She squirts her warm girl cum all over you, coating your stomach in the sweet smelling liquid.  In return you cum into her hand and release what girl cum you can, but it's nowhere close to as much as Phylla produces.  You slowly remove each other's hands from their respective vaginas and collapse into each other's arms.");

			outputText("\n\nYou wake up about an hour later, still smelling of sex and covered in each other's fluids.  \"<i>You should come down more often.  I mean... I miss you sometimes...</i>\"  Her shyness returns as she slowly recovers from the small sex-comas you had placed each other in.");

			outputText("\n\nYou say you'll think about it and wink at her as you get dressed and head back to camp, leaving her to eagerly await the next time you come to take her once again.");
			player.sexReward("vaginalFluids","Vaginal");
			doNext(camp.returnToCampUseOneHour);
		}


//[While Giving Birth]
//(Note: The above option will only be available if Phylla is 'Laying Eggs.')
//While Giving Birth (Male) - Written
		private function dudesFuckEggLayingBitches():void
		{
			clearOutput();
            phyllaSprite(true);
			outputText("Phylla looks completely taken aback when you suggest you want to have sex with her.  Obviously self-conscious about how she looks right now, she covers her enlarged breasts with all four of her hands as she sits back in her seat.");
			outputText("\n\n\"<i>Are you sure... I mean I could change... to be smaller.  It won't take long...</i>\"  She glances behind her at her engorged abdomen.  \"<i>Ummm... yeah, it won't ta-AHH!</i>\"");

			outputText("\n\nShe stops mid-sentence as a contraction shoots through her body; you watch as it makes her whole body tense up.  Then with an almost sexual moan she shudders as all her muscles relax and the contraction pushes a cylindrical egg out from the birthing slit at the tip of her abdomen.");

			outputText("\n\nAs if on cue, one of your many children quickly runs in from the shadows and scoops up the egg to remove it and take it somewhere deeper into the colony.  Clearly there's some kind of greater system going on here.");
			outputText("\n\nPhylla slowly recovers and looks back at you, trying to remember why you dropped by.  Then you, with a wicked smile, watch as her eyes widen in remembrance.");

			outputText("\n\n\"<i>I can't- just not like this... can't you see...</i>\" she attempts to persuade you as she rambles on, but you ");
			menu();
			addButton(0, "Persuade", birthDickSex2);
			addButton(1, "DontCare", birthDickSex2, true)
				.disableIf(player.cor < 66 - player.corruptionTolerance, "You're not an asshole.. are you?");
		}
		private function birthDickSex2(corrupt:Boolean = false):void {
			//If Corruption is less than 50:
			if (!corrupt) outputText("\n\nBut you don't care how she looks right now. Besides, some creatures around here appreciate a little carnal love; it helps with the birthing process.");
			//If Corruption is more than 50:
			else outputText("\n\nBut you couldn't care less for her pathetic attempts at concealing her pregnant form; you're horny, and she's going to put out, regardless of her insecurities.");

			outputText("\n\nYou walk over to her and ");
			if (!corrupt) outputText("lovingly");
			else outputText("apathetically");
			outputText(" pull her hands away from her breasts.  She resists you at first, but once she sees there's no stopping you she shyly resigns herself to you.");

			outputText("\n\nYou see her breasts have doubled in size and beads of milk are leaking out - no doubt a result of her pregnancy.");

			outputText("\n\nPlayfully you give one of them a strong squeeze.  Phylla moans as a jet of white milk shoots out.");

			outputText("\n\nYou comment on how being this full can't be good for her back.");

			outputText("\n\n\"<i>My... I mean, our... they don't... it- it's compl~</i>\"");

			outputText("\n\nYou cut her off by giving her breast another tight squeeze, causing milk to jet out onto the ground and Phylla to softly moan again.");

			outputText("\n\nTelling her you'll take care of the \"<i>problem,</i>\" you latch on with your mouth like a cobra striking prey, squeezing the other breast firmly before she can retort.  These actions yield the taste of warm milk in your mouth and wetness against your hand as she leaks out her maternal essence.  Amazed at the volume that is flowing out, you swallow as much as possible, pausing to smack your lips, savoring the sweet and very nectarous flavor of her breast milk -  you might have to keep her like this just to enjoy the simple pleasure of this milk.");

			outputText("\n\nPhylla's lower arms grab the back of your head, leading you to figure that she's saving those reserves for the children.  However, instead of trying to pull you off of her, she compresses your face fiercely into her mound.  The added pressure of your face against her breast causes even more milk to pour out into your mouth as you hear Phylla's pleasurable sigh more audibly than before - holy hell, how much is in these things?  You shrug and continue to drink from her for a while, pausing only momentarily as her smaller set of hands guide you to her other breast once the one you're on is tapped out.");

			outputText("\n\nOnce you detach yourself from Phylla's breasts, you can see she no longer cares how pregnant she is; she wants you, she needs you.  Your growling stomach protests loudly in response; getting a cramp during sex can be a bitch, but your loins inevitably overrule your gut.  Cramp or no cramp, it's time to \"<i>play.</i>\"");

			//Silly Mode:
			if (silly()) {
				outputText("\n\nYou belch loudly, hoping to clear the rumbling in your stomach.  Phylla then releases a lion-like belch of her own.  It echos throughout the colony and you think you feel the very walls of the chamber shake.  Your jaw drops in awe and you look at Phylla in stunned silence.  \"<i>What? Just because I'm a queen doesn't mean I'm confined to act like one.  If you think that's good, you should hear me hiccup.</i>\"");

				outputText("\n\nA quick check of your arousal shows that you're still in the mood in spite of what has just transpired.");
			}
			outputText("\n\nMoving your hand in between her sitting legs, it is welcomed like an honored guest.  You feel that she's already completely soaked - a few thin strands of her liquid have even settled between her legs - your hand easily finds her long love button and after a few moments of teasing her, your fingers penetrate her.");

			outputText("\n\n\"<i>Oh, noo-NNNNGH!</i>\"  Her voice stops trying to warn you but it's too late.");

			outputText("\n\nYou feel her vagina almost crush your fingers as a vice-like contraction causes her whole body to tense up.  It's almost like you're caught in a wrestling hold; you wince as what you thought would be pleasurable turns to pain.  It isn't long before the contraction subsides, and Phylla moans loudly as her vagina releases your fingers along with a small flood of lubricant.");

			outputText("\n\nYou quickly glance at the tip of her abdomen as an egg covered in syrup-like birthing goo slowly pushes her folds open and glides gently to the ground.  As you remove your fingers from her slobbering cunt, you turn your head up to look at Phylla's face.  Before you can ponder your next move, Phylla darts in and plants a firm kiss on your lips.");

			//(If corruption is more than 50:
			if (corrupt) outputText("\n\n(Oh, great, here we go again...)");

			outputText("\n\nSuddenly, as if two magnets had locked their opposite poles together, your minds link to each other.  It's extremely uncomfortable for you at first, unlike the previous times.  Experiencing the feeling of being in constant labor quickly takes over the forefront of your mind.");
			outputText("\n\nYou can even feel what stage Phylla's egg is in and approximately when it will cause the final, and strongest, contraction.  The intensity of this act is almost too much to bear, but you can feel Phylla's mind help yours to cope with these new feelings, helping to support you and direct your focus to the more... pleasurable aspects of sex with a pregnant queen.");

			outputText("\n\nAfter your mind has settled, you feel Phylla's four arms work quickly to get you out of your clothes. Once naked, she looks at you like a cat who's cornered a particularly plump mouse, leering at you with hungry intent. Three of her arms grab you and pull her close as her hips move to the very edge of her seat. Her fourth hand guides your cock into her vagina as she embraces you.");

			outputText("\n\nHer stiff clit almost drags along the top of [oneCock] as it enters her.  Once inside her fuckhole, tiny contractions are felt throughout her body, surging up and down her vagina, sending waves of pleasure through your cock as a result.  You start to thrust your hips into her, each time trying your best to get deeper and deeper so the pulsing contractions get sent down the complete length of your man meat.  Quickly building up to a feverish pace, your cock flies in and out of her, sliding her clit up and down the top of your shaft with each rough thrust.  The sensation is simply becoming too much, but she intervenes and restrains your body from releasing its orgasm.");

			outputText("\n\nThat's not fair!  You feel her birthing contraction coming up and conclude that two can play at that game.  Despite having no experience with this, you somehow manage to withhold her moment of respite.  You can taste her annoyed frustration but you opt to replace the feeling with your utter bliss, as you grab both of her enlarged breasts with your hands, and squeeze them so milk shoots all over your chest and you catch some of the falling droplets in your mouth.  Your hips still thrust like a madman, mashing into her pelvis as the pulses in her pussy start to synchronize with your thrusts.");

			outputText("\n\nIn a similar fashion to the joining of minds, your bodies appear to be sharing information, too.  Then you feel it, just as suddenly as Phylla does.  This contraction can't be held back anymore, and it might have been a mistake to hold it back in the first place.  Phylla's whole body tightens around you, all four of her hands pulling, crushing you into her chest, causing your dick to delve so deep that");
			//(If PC has balls:
			if (player.hasBalls()) outputText(" your balls slap against the smoothness of her pelvis.");
			else outputText(" your knees grind along the edge of her makeshift throne.");

			outputText("\n\nThrough the link, you can feel the busy work of birth start to work its way down her body from Phylla's mind.  As it increases in intensity, her nails dig unconsciously into your back.  Taking your derriere in her lower arms, Phylla thrusts you completely inside her so that your cock hits the deepest part of her cunt in perfect timing with her contractions.");

			//(If PC is under 5 feet tall:
			if (player.tallness < 60) outputText("\n\nThis act actually lifts you off your feet, but with Phylla's tremendous strength you're sure she'll be able to hold you up.");

			outputText("\n\nThe walls of her pussy warp and wrap around you so tightly that you can feel every single inner detail of her insides.  Her clit turns so hard that if you weren't linked you would have assumed a small blunt fleshy clamp was pushing into the base of your dick.  As the contraction passes, your joined minds share in the dual pleasures of your imminent orgasms.  It's as though time has frozen in this very moment before you and Phylla orgasm.  At the very threshold between want and satisfaction, you feel that you both have become a single consciousness; together you linger there for a moment, as if holding your breaths.  As your single mind seems to let out a prolonged breath, your link splits, sending you both crashing back into your own bodies and individual minds.");

			outputText("\n\nCock quivering inside her, her cunt sends one final pulse, begging for you to cum inside her and start the whole process of pregnancy all over again.  Simultaneous, loud moans echo down the halls of the colony as you release your seed deep inside her; her vagina eagerly contracts with each volley of your efforts to inseminate her, intent on inhaling your semen deep inside to provide all of your sperm the chance to fertilize your lover.  Floods of liquid escape from her breasts, cunt, and abdomen as she finishes her own orgasm.");

			outputText("\n\nYou feel the contraction pass quickly through all the different stages of her abdomen and almost like a repeating crossbow, three eggs drop abruptly out of her tip.");

			outputText("\n\n\"<i>I... I...</i>\" she gasps, trying to catch her breath.  Before she can finish her sentence, she collapses in your arms, still sitting on her throne with you inside her.");
			if (!corrupt) {
				if (player.str >= 70) outputText("\n\nYou muster the last of your strength to carry her over to her bed, struggling to overcome the exertive efforts of your mating and the weight of her abdomen. Eventually making it to her bedding, you lay her down and give her a light kiss on the lips as she drifts off to the land of dreams. Quietly you gather your things and head back to camp.");
				else outputText("\n\nPoor girl must be exhausted. You tactfully remove yourself from her and do your best to try to drag Phylla off her throne in order to put her into her bed.  Even with your full strength she weighs too much in her current state.  One of your children just happens to be passing by and sees your predicament.  He makes a series of clicks that echo down the tunnels.  A few moments later a group of your children appear and together you manage to get Phylla into bed.  You thank your children with a pat on the head and quietly you gather your things and head back to camp.");
			} else {
				outputText("\n\nSighing at her nerve to pass out on top of you, you pull out of her and lift her to her feet, semen dripping out of her as she wobbly takes to her feet.");
				outputText("\n\n\"<i>Come on, march!</i>\"  You command her.  \"<i>Over here, Phylla, one foot over the other; yes, that's a good breeding slut.</i>\"");
				outputText("\n\nAfter a moment of staggered walking you allow Phylla the courtesy to flop down onto the hard surface of the bed, pausing only for a moment to look over your pregnant little whore.  After a quick remark to her on how she'd better be ready for another round soon, you leave her to the mess you have made as you head back to camp.");
				dynStats("cor", 2);
			}
			doNext(camp.returnToCampUseOneHour);
		}

//While Giving Birth (Female) - Written
		private function birfingSexWithAntsForDasLadies():void
		{
			clearOutput();
            phyllaSprite(true);
			outputText("Phylla looks completely taken aback when you suggest that you want to have sex with her.  You can tell she is self-conscious about the way she looks right now by the way she covers her enlarged breasts with all four of her hands as she sits back in her seat.");
			outputText("\n\n\"<i>I... look, we could wait until I've given birth... Wouldn't you want that?</i>\"  She glances behind her at her engorged abdomen.  \"<i>I... It won't ta-AHH!</i>\"");
			outputText("\n\nShe stops mid-sentence as a contraction shoots through her body, making the entirety of it tense up.  Then with an almost sexual moan she shudders as all her muscles relax and the contraction pushes a cyclentrial egg out from the birthing slit at the tip of her abdomen. As if on cue, one of your many children quickly runs in from the shadows and scoops up the egg to remove it and take it somewhere deeper into the colony.  Clearly there's some kind of greater system going on here.");
			outputText("\n\nAs you walk back in front of her you begin to strip down, leaving your armor and underwear strewn about behind you.");
			if (player.isNaga()) outputText("  You slither almost whorishly with a slow, measured wriggle,");
			else outputText("  You walk almost whorishly with a slow, sensual gait,");
			outputText(" allowing her to see the sensual swivel of your [butt] from left to right and back again as you visibly entice Phylla's mind to lustful thoughts.  Once you're facing Phylla once again, you see her lower two hands are still covering her breasts and the upper two are gripping the stone chair she sits in.");
			outputText("\n\n\"<i>I didn't mean... I just thought...</i>\"");
			menu();
			addButton(0, "Calm Her", birthVagSex2);
			addButton(1, "Use Her", birthVagSex2, true)
				.disableIf(player.cor < 66 - player.corruptionTolerance, "You're not corrupted enough to use a pregnant ant-girl.");
		}

		private function birthVagSex2(corrupt:Boolean = false):void {
			//If Corruption is less than 75:
			if (!corrupt) outputText("\n\nPressing one of your fingers to her lips to quiet her, you slowly whisper sweet nothings into her ear.  This distraction is just the thing you needed.  Running your hand from her lips, you drag your nails ever so slightly down her neck in a way that ignites Phylla's sexual fires.  Eventually your hands come to rest on hers.  Playfully hooking one finger around one of the hands that's covering her breasts, you use it to slowly pull Phylla's hand back to reveal her hardened nipple.");
			//If Corruption is more than 75:
			else outputText("\n\nYou let Phylla know that you want to see those tits, free and proud.  She shyly does as commanded.  You gaze at her breasts like a hungry wolf.  They're much larger than 'normal'; you assume it must be due to the 'pregnancy.'");
			//END CORRUPTION CHECK
			outputText("\n\nBeads of milk have already started to dribble out of both her nipples. This causes you to inquire why she even produces milk.");

			outputText("\n\n\"<i>W-What do you mean?  I need to feed my... our... children.</i>\"");

			outputText("\n\nClearly not understanding your question was more playful than real, you cut her off by giving her boob a soft squeeze.  Both of you are clearly surprised when a white jet of milk practically fires out of her breast like a cannonball, landing on the floor a few feet away.");

			outputText("\n\nWithout warning, you strike at her areola like a viper, latching on and biting down playfully on her breast.  Your efforts are rewarded as your mouth is instantly flooded with warm and sweet liquid.  You hum approvingly and try your best to swallow the massive volume of milk that seems to endlessly pour out of her swollen breasts, but it proves too much.  Detaching yourself from her, you lick your lips and sigh as your hunger is completely sated - for milk anyway.");

			outputText("\n\nMoving your hands in between her thighs causes Phylla to moan as you spread her legs apart.  You see her wet cunt has already soaked her inner legs, and spreading them apart like this, you get a full view of her.  Her pussy seems to be visibly pulsating, squirting small amounts of her lubricant with each small contraction.");

			outputText("\n\nYou wonder what the inside of her must feel like as you gently run your hand over her; an enormous warmth is being emitted from her vagina before your fingers even fully reach her entrance.  You tease Phylla, commenting on how she's all nice and ready for you as you start to tease her moist fuck-hole and long clit with your fingers, watching as her glinting cunt almost begs to be penetrated as it spits her lubricant all over the floor.");

			outputText("\n\n\"<i>Huangg~</i>\"  Phylla's body tightens as she moans, another egg must be coming.  \"<i>I can't... take mu~... more.</i>\"  She struggles to say between moaning gasps for air.  \"<i>I~...</i>\"");

			outputText("\n\nHer hands lift your face up and her glazed eyes stare blankly into yours; she must want to link badly if she's not even gazing intently into your eyes.");

			//PC is pure
			if (!corrupt) {
				outputText("\n\nSmiling, you wrap your hand around the back of her head and pull her into a deep kiss.");
				outputText("\n\nFeeling the link almost immediately, it hits you as hard as a Minotaur wielding a battleaxe.  A fireworks display of emotions wash over you; clearly, your mind was completely unprepared for this cavalcade of feeling.");
				//If PC has IS pregnant:
				if (player.pregnancyIncubation > 0) outputText("\n\nThe feeling of your pregnancies is instantly transferred between yourself and Phylla; you feel the warmth and energy of her unborn children inside of you, and you can feel her experiencing the warmth of the life still growing within you.  At this moment, you two understand perfectly what it's like for each other to be with child; it's a pretty... enlightening experience... that's distracting you from the task at hand.");
				//If PC has been pregnant:
				else if (player.statusEffectv1(StatusEffects.Birthed) > 0) outputText("\n\nYou've been pregnant before, but this... this is completely different.  You feel every stage that each of Phylla's eggs in her abdomen is in.  You feel what it's like to have your only goal, your only want in life being to mate and have children for the rest of your life.  It's an amazing turn on for you - you feel a warmth start to spread between your own legs.");
				//If PC has NEVER been pregnant:
				else outputText("\n\nIt's one of the most interesting feelings you've ever felt; you feel every stage of pregnancy at once - every stage of each egg in Phylla's ever-laying abdomen.  It makes you want to experience the joys of being pregnant as a flood of maternal thoughts flood your mind.  Though you keep in mind the disadvantages as well - you don't want to go overboard.  You feel what it's like to have your only goal in life be to breed continuously.  It's an amazing turn on for you as you feel a warmth start to spread between your own legs.");
			}
			//PC is corrupted
			else {
				outputText("\n\nYou want to just fuck the rest of your days away, but you know that won't happen anytime soon. Stupid goddamn quest and your people ruining a good thing.");
				outputText("\n\nLooks like you need to teach Phylla that life's full of disappointment.  You pretend not to see the need in her eyes; heavens know you don't need another headache.  You've got depraved fantasies to carry out after all!");
			}
			outputText("\n\nYou ");
			if (!corrupt) outputText("lovingly");
			else outputText("dismissively");
			outputText(" continue to finger her, forcing her body to writhe on top of your fingers, begging for more... and you're more than happy to oblige.  As two of her arms push you down on your shoulders, the other two apply pressure to the top of your head, encouraging your head to disappear between her legs.  Chin resting on the utterly soaked pillow that your lover is sitting on, you inhale Phylla's sexual scent and allow it to spread throughout your body, encouraging you to coax more of that intoxicating pussy nectar out of her for enjoyment and pleasure.");

			outputText("\n\nThe smell of earth mixed with her sex and the taste of her milk on your lips is too much.  You dive into her like a sex-crazed animal.  Plowing your face against her love button, you press her outer labia against your lips before taking her tender clit into your lips and wrapping your tongue around it, sucking hard.  Her lower arms take a full grasp of your " + hairDescript() + " as she guides your face, intent on having you eat her deeply sooner rather than later.  Taking your cue, you release your tongue from her clit and move it inside of her and allow the bumpy texture of it to tease and caress her hot fuckhole.");

			outputText("\n\nAs a reward for your tongue's new position, you hear a prolonged groan of appreciation as she experiences the foreign sensation in her pussy.  Every contraction can be felt as her cunt wraps and releases your probing licker.  Pausing occasionally, you slurp up her sexual fluids, but are constantly assaulted by her rather tight, wet, and delicious pussy. Your tongue rattles around inside of her like an ant caught in a windstorm.  Pulling your tongue out, you lovingly lick along her clit, causing her to draw in a deep breath while grasping your hair even harder.  Phylla grunts girlishly while wrapping her legs firmly around your head.  With a slight shove she forces your face back into her cunt with tremendous force - obviously she's not finished with you yet.");

			outputText("\n\nYou decide to make the best of it considering her strength; it could always be worse.");

			//If corruption over 50:
			if (corrupt) outputText("\n\nYou'll remember this and make her pay for it later.");

			outputText("\n\nThe resulting sensation of your second go at her pussy causes her to release a mixture of a moan and whine as she bites her lower lip; being overwhelmed by ecstasy must be nice.");
			//If PC is linked:
			if (!corrupt) outputText("\n\nYou hear her in your mind: Just keep going.  It'll be your turn soon... please just... a little more.");

			outputText("\n\nBy now she's clawing fiercely at your head in a violent yet caressing fashion as each millisecond of your efforts cause instantaneous reactions from your lover.  \"<i>MMMhhPHHp!</i>\"  She moans behind a closed mouth before managing to utter, \"<i>Oh, MY-AHH!  Just like that!  Right there!  DON'T-NGGHH, stop!</i>\"");

			outputText("\n\nShe's not ready to cum yet... is she?");
			if (!corrupt) outputText("  You probe her mind and are almost taken aback.\"<i>NO!  Just please keep going!</i>\"  You hear her voice ring out in your head.");

			outputText("\n\n\"<i>Please, lick me... right... THERE!</i>\"  She moans out in her ecstasy quickly covering her mouth with the pair of hands not rooted in your hair in an attempt to muffle her pleasurable noises.");

			//If Corruption is less than 50:
			if (!corrupt) {
				outputText("\n\nWhile part of you wants to hear her moan her pleasures to the entire colony, you figure you'll allow her to not disturb the colony.");
				outputText("\n\nYou continue your attack on her pussy as she tries desperately to contain her moans of pleasure, causing a muffled echo to ring out in the bedchamber as you slide your tongue in and along her pussy.  She's got to be close to cumming, you think to yourself, and realize you've lost yourself in the moment; your " + vaginaDescript() + " has been neglected... perhaps it's her turn to tend to you?  As if you had said it out loud, Phylla eases her grip on your hair and unwraps her legs from behind your head, composing herself before rising to her feet.");
				outputText("\n\n\"<i>How would... you like me... to do this?</i>\"  Phylla manages to moan out between staggered breaths as you playfully shove her backwards onto the bed.  You wait until she finishes positioning her massive abdomen, curling it around both of you as she lies on her back.  You hover your hips just above her face, letting her smell your scent and feel your heat in the hopes that she'll get the idea and take over from here.");
			}
			//(Transition to EAT PUSSY)
			//If Corruption is over 50:
			else {
				outputText("\n\nThis won't do at all, you think to yourself, ripping yourself from her grip, and face slightly away her pussy.  Gazing into her deep emerald eyes, a devious idea creeps in your mind.  In a flash you rip her hands away from her mouth. Simultaneously you dive back into her cunt and nibble on her clit.  A loud perfectly timed moan escapes and echos off the walls. Smiling to yourself, you tell Phylla that her modesty is a turn-off at this point; you want to hear her moans to their fullest extent.  No muffling, no restraint: just moan... for you, her 'king'.  As loudly as she needs to.");

				outputText("\n\nWith those pesky hands out of the way, you dart back down to her clit and manhandle it with your tongue, causing her to erupt into a loud series of moans and labored breathing as she resigns herself to the full brunt of euphoria to take her.  Phylla gives in to instinct, letting it consume her as she slams backward onto her bed, milk-filled breasts swaying in the air as she spasms and screams as loudly as her body will let her.  Her leg even begins to twitch against your shoulder, feeding off of the hypersensitivity you have inflicted on her... no, the fuckhole that belongs to you.");

				outputText("\n\nSensing that she is nearing an orgasm, you pull back and wrestle out from betwixt her legs.  Finally free, you see she's sprawled out on the bed, her massive abdomen hanging off to the side.  Settling yourself over the top of her, you slide your " + clitDescript() + " along her nose, intent on getting your scent entrenched in her body, wanting to make her crave your pussy, something that occurs as she takes a long whiff of air and moans like a whore in heat.");

				//If PC has loose pussy:
				if (player.vaginas[0].vaginalLooseness >= VaginaClass.LOOSENESS_GAPING) outputText("\n\nYour loose pussy lips cause your juices to drip onto Phylla's face as you hover over her, allowing her to lather in the wetness of your arousal.");

				outputText("\n\n\"<i>I think you need to lick my pussy for a bit, my queen,</i>\" you tell her, thinking that you wouldn't want her getting off before she's tended to your needs.  You playfully smile down at her.");
			}
			//EAT PUSSY:
			outputText("\n\nLike a starving animal, Phylla's mouth waters as she takes hold of your thighs and spreads your legs apart.  You grab hold of her hair and shove her head between your legs, impacting your " + clitDescript() + " and causing you to moan slightly.  She certainly isn't shy now, you think, as her tongue starts to work its way into you.  You can \"<i>hear</i>\" Phylla giggle back in response. Thoughts of grinding your pussy across her mouth and face flood your mind, and instinct takes over as your hips start to rock in response to Phylla's eager attack.  Running your hands through her hair,  you grind Phylla's pretty face harder and deeper into your soaking " + vaginaDescript() + ".  The poor ant can only respond by moaning fiercely as she eagerly sucks and kisses your love button, completely overwhelmed by the desire that has overtaken her.");

			//If PC has (a) Dick(s), that are less than 42 inches:
			if (player.cockTotal() > 0 && player.cockThatFits(42) >= 0) {
				outputText("\n\n[EachCock] begs for your touch, and with no hesitation you grab a hold of ");
				if (player.cockTotal() > 1) outputText("them");
				else outputText("it");
				outputText(", stroking ");
				if (player.cockTotal() == 1) outputText("it");
				else if (player.cockTotal() == 2) outputText("them");
				else outputText("as many as you can");
				outputText(" as fiercely as your body will let you.");
			}

			outputText("\n\nAs you feel your stiff " + clitDescript() + " glide along her lips, you can begin to taste bits of her almost primal hunger for you.  As well, you sense that the growing contractions in her abdomen are getting quicker and stronger.");

			//If Corruption is less than 50:
			if (!corrupt) outputText("\n\nYou'll need to finish up quickly; you don't want to keep the children waiting to get her egg while you two are \"<i>busy.</i>\"");
			//If Corruption is more than 50:
			else outputText("\n\nIf she lays an egg before you're done with her, not only will you be furious, but you'll have to scare your kids away.  " + player.mf("Daddy", "Momma") + " needs to get [his] rocks off first before any annoying kids get in the way.");

			outputText("\n\nHer tongue and fingers work their magic until she has you in a near orgasmic state.");

			outputText("\n\nDeciding to end this, you work your hips away from Phylla's eager tongue and lean down, whispering into her ear; you're hell bent on cumming simultaneously in a glorious display of sexual gratification, and want to know if she's thinking along similar lines.  Giggling at your suggestion, the pair of you quickly shift positions so you're in the time-honored sixty-nine.  Her vagina now rests just above your face as her face rests in between your legs, her huge abdomen casting a looming shadow over both of you as it curls over your head and drips warm liquid down your spine.  You feel her yearning to lay eggs, but you suppress her desire.  \"<i>Not yet,</i>\" you think - not until you've both cum.");

			outputText("\n\nYour " + clitDescript() + " comes to rest on her lips again as her head starts to bob between her own strong legs.  Returning the sentiment, you dart in-between her legs, tongue first.  You hit that sweet tasting little pussy of hers with force.  Phylla moans, your intentions crystal clear as she bears down on your pussy hard, intently working for your sexual release.  She reaches up with her lower set of arms and gives both your " + nippleDescript(0) + "s a firm squeeze, the twist of which is nothing short of exquisite.  Muffled moans of bliss are unintelligible, but in your shared mind-state, you can hear one another screaming words of encouragement and direction.");

			//If PC has (a) Dick(s), that are less than 42 inches:
			if (player.cockTotal() > 0 && player.cockThatFits(42) >= 0) outputText("\n\nWithout warning, Phylla begins to alternate between giving your " + clitDescript() + " oral and sucking your [cocks]; the dual stimulation overwhelms you as she devilishly teases your sexes.");
			outputText("\n\nYou recall the tip of her abdomen being particularly sensitive as you reach up overhead. Your arm can barely reach it, but as if she knew what you were trying to accomplish, Phylla curls her abdomen just enough so you can start to stroke her birthing slit.  At your caress, Phylla shudders and deeply exhales into your cunt, sending a shiver up your spine. Continuing like this, you both quickly build up orgasms.");

			outputText("\n\nHowling in delight, both of you twitch and writhe as the pure bliss of climax seizes your bodies, drooling and squirting lady fluids against each other's faces.");

			//If PC has a dick-two dicks that is/are less than 4 inches wide, in total:
			if (player.cockTotal() > 0 && player.cockThatFits(42) >= 0) {
				outputText("\n\nMoaning savagely, Phylla pops ");
				if (player.cockThatFits2(42) >= 0) outputText("two of ");
				outputText("your [cocks] into her mouth and mashes ");
				if (player.cockThatFits2(42) >= 0) outputText("them");
				else outputText("it");
				outputText(" against the back of her throat.  Unable to contain the pleasure from this, you howl and blow your hot load into her throat.");
			}
			else if (player.hasCock()) outputText("\n\nFeeling your own [cocks] about to erupt, you quickly roll off your lover.  Just in time, too - you fire your jizzum up at the ceiling, coating it quite well before your salty load falls back down on top of the two of you.");

			//PC dick is out in the hallway:
			if (player.biggestCockArea() >= 500) {
				outputText("\n\nYour [cocks] twitches with orgasmic release, bulging as your load works its way through your urethra");
				if (player.cockTotal() > 1) outputText("s");
				outputText(".  With a heavy heave, you feel the hot and sticky ejaculate launch from your dick, hitting the interior decorations as you do so; what exactly you hit, you can't say... but you'll likely be tripping over your mess on the way out.");
			}

			outputText("\n\nYou struggle to breathe for a moment as a massive amount of warm girl cum seems to flood from Phylla's vagina to completely cover your face and soak most of your " + hairDescript() + ".  While you catch your breath, you can hear Phylla noisily slurping up your fluids before compressing her face against your " + clitDescript() + " in an eager effort to lather her face in your juices for just a little longer.  Contentment and fulfilled desire - not only your own, but Phylla's as well - spreads like wildfire through your brain.  You grin to yourself, satisfied at the effect you've had on Phylla during your session.");

			outputText("\n\nUnfortunately, nature has to ruin the moment as Phylla's muscles seize up and her abdomen begins to contract significantly.");
			if (!corrupt) {
				outputText("\n\nWith adrenaline pumping through your veins, you quickly flip Phylla over so she's on her hands and knees.  Taking hold of her hand and head as she groans in pain, you offer her your support, assuring her that you're here for her.  Sensing that she might benefit more from the link, you quickly plant a kiss on her lips and hold her close, something she responds to by clutching you in her arms, though it seems more for support than passion at this point. Nevertheless, you can feel that she's grateful that you're here.  With a final, labored groan, she works the impending egg free of her abdomen and breathes a large sigh of relief before passionately returning the kiss.");
				outputText("\n\n\"<i>T-Thank you... You're so good to me,</i>\" she whispers in between kisses.");

				outputText("\n\nUp the hallway, you can hear the patter of soft feet; one of your many children must be coming to fetch the egg.  Acting quickly, you grab your [armor] and position it so that it obstructs the view of your naked bodies.");

				//(If PC wasn't wearing revealing clothing:)
				if (!player.armor.hasBuff('teasedmg')) outputText("\n\nThe \"<i>child</i>\" that walks in notices both of you breathing heavily, and quickly takes note of your need for privacy.  Phylla scoops up the egg and embarrassingly extends it to him.  He does his best to avert his eyes and quickly scampers over to fetch the egg and leaves.");
				//(If PC was wearing revealing clothing:)
				else outputText("\n\nYour attempts at modesty end up failing as the offspring of your union stumbles in and covers his eyes at the sight.  He quickly fumbles his way over to the egg and takes off, not daring to look back at his bare naked parents.");

				outputText("\n\nYou both chuckle and drift off to sleep in Phylla's bed.  Somehow, you know that your back is going to ache when you wake up.");
			} else {
				outputText("\n\nYou couldn't care less at this point about what kind of turmoil Phylla is going through, opting instead to doze off next to your contracting lover.  She tries to shake you awake and whines dejectedly as she's left alone to ease her child into this world.  You do your best to pretend to drift off, but she's making too much noise.  Phylla clearly believes your deception as after a moment she stops trying to get your attention, more focused on the task at hand.");
				outputText("\n\nYou hear the inevitable groan of relief and feel the seeping liquids of birth a few moments later.  Grinning, you feign sleep, appeased that you've added another... slave to the colony.  That is, until one of your children tries to enter the bedchamber to take Phylla's egg away.  Your eyes snap open and you rise up to make such a display of anger and annoyance that your offspring backs away nervously; he'll have to wait until you're both asleep before he can get the egg.  Phylla looks confused as she thought you were asleep the whole time. ");
				outputText("\n\n\"<i>I-I thought... you were...</i>\"  Phylla starts to say, but you cut her off with a look that shows you're in no mood to listen to her.");
				outputText("\n\nNow that Phylla's quieted down, you tell her you're going to get some sleep; if she's to have another child, she'll need to either keep quiet or leave to another room.  She nods dejectedly as you settle in for your nap.  You swear you hear her go into labor again right before drifting off.");
			}
			player.sexReward("vaginalFluids","Vaginal");
			doNext(camp.returnToCampUseOneHour);
		}

//[Orgy w/ Colony - Requires Children]
//(Note: The above option will only be available the PC has sufficient corruption.)
//Orgy w/ Colony (Male) - Written
		private function orgyWithDatColonyCorruptDudes():void
		{
			flags[kFLAGS.TIMES_CORRUPT_MALE_ANT_ORGY]++;
			clearOutput();
            phyllaSprite(true);

			outputText("You tell Phylla to call in your strongest and most virile children for 'inspection.'");

			//First Time:
			if (flags[kFLAGS.TIMES_CORRUPT_MALE_ANT_ORGY] == 1) {
				outputText("\n\nShe looks confused at first and attempts to ask why.  \"<i>I don't think... they will all fit in this room.  We have many warriors...</i>\"");

				outputText("\n\nLooking around, though her room is about the size of your campsite on the surface, she's probably right.  Sighing, you just tell Phylla to do what she can.  She closes her eyes then tilts her head back.  After a moment or two of this 'meditation' her eyes snap open.  \"<i>They should be here soon.</i>\"  Her voice is very cheerful.  You wonder how quickly it will change when you tell her just what you have in store.  If you even tell her outright - tricking her could be a better way to get what you want.");
			}
			//(Subsequent Times:)
			else outputText("\n\nShe nods meekly, knowing what an 'inspection' means.");

			outputText("\n\nA few moments later five of your 'children' show up. Phylla clearly took your advice and chose the best specimens from among her colony to show off for your 'inspection.'");

			outputText("\n\nThey line up along the wall as you walk down in front of them like a military officer.  Their chiseled bodies and large frames look akin to statues carved by master artisans.  You stop in front of the largest of them and run your hand over his chest, caressing his skin as your hand moves over his pecs.  His whole body tenses up as you reach his small nipple, but he doesn't make a move to stop you.");

			outputText("\n\nYou step away from him and look up and down the line; they're not even fully naked.  This won't do at all.  With a wicked grin, you tell Phylla to have them remove their loincloths.  A few of your sons glance at each other and shift uncomfortably.  Phylla, on the other hand, looks frightened and hesitant to do as you ask.");

			if (flags[kFLAGS.TIMES_CORRUPT_MALE_ANT_ORGY] == 1) outputText("\n\n\"<i>Why... would you... want to... see...?</i>\"  Phylla seems confused.  You tell her that you need to see everything to get a proper assessment.  That is, unless Phylla thinks she's doing such a bad job of being queen that she would need to hide the facts from you.");
			//Subsequent Times:
			else outputText("\n\nThough you can tell Phylla doesn't want to, she gives in. You make a comment about how maybe her children have 'shrunk' since your last inspection.");
			outputText("\n\n\"<i>No!  I'm doing a good job!  I promise!</i>\"  Trying to show how wrong you are, she enters her trance.  The warriors before you start to disrobe.  Once all five of them are completely nude, Phylla snaps back into the present.");

			outputText("\n\nEmbarrassed for her children, Phylla looks away as your eyes instantly lock on to their genitals.  \"<i>Well...  I mean, they're... all... gifted... like y-you asked,</i>\"  Phylla says, more to the floor than to you.  They certainly are, you think to yourself, as you visually feast on their cocks!  All of them are erect, and a few even have beads of pre-cum running down their slightly pointed, human-looking shafts.  You would guess all of them have about 10-15 inches of long, hard man-meat.  Two testicles swing beneath their long cocks.  Their balls vary in size, but have mostly human-like proportions compared to their cocks.  You walk over to one and slide your hand down his shaft just to see how he reacts.  A low muffled moan escapes his clenched teeth as he does his best to ignore your hand.");

			outputText("\n\nYou look over at Phylla as you stroke his long cock with your fingertips.  She's still looking away, not wanting to believe what you're doing.  The ant's pre-cum is slowly making your hand wet.  You go from gently caressing his cock to slowly jacking him off; you can feel his firm rear tighten as his phallus throbs between your strokes.");

			outputText("\n\nYou watch the other four ants in line shift awkwardly, watching you jack off their brother, yearning for their own attention.");

			outputText("\n\n\"<i>Well, can't you feel them?  Their needs, their lusts?</i>\" you tease Phylla as she glances over.  When she sees what you're doing she gasps in shock, covering her mouth and eyes with all four of her hands.");

			outputText("\n\nYou look to the other four.  \"<i>Do help your mother relieve herself of her... insecurities.  There's no reason for you four to hold back on my account.  Just don't touch her cunt!  That belongs to me!</i>\" Heeding your command, the four other soldier ants descend on Phylla, peeling her arms away from her face.  You hear Phylla's muffled protests, but that's quickly stopped when one of them kisses her deeply and guides one of her hands to his cock.  Another starts to suckle on her breast and moves another of her hands to massage his own member.  The third takes both of Phylla's smaller hands and forces her to cup his balls and stroke his cock as he stands in-between his brothers.  The fourth man seems to be left out, but then gets an idea and walks behind Phylla.");

			//If Phylla Is Laying Eggs:
			if (flags[kFLAGS.PHYLLA_EGG_LAYING] > 0) outputText("\n\nSeeing as how he wouldn't be able to lift her massive abdomen, he lays down and almost completely disappears under it.  Phylla moans loudly as he runs all four of his hands down the underside of her abdomen as a contraction racks her body.  The birthing slit at the end of her abdomen widens as an egg pushes itself out of her, splattering her child's chest with her clear birthing gel as it comes.  The ant-man uses his lower two arms to softly set the egg aside as his large hands part her birth canal.  He licks his way down her long abdomen and begins lapping up the liquid that continues to seep out of her birthing slit.  Drinking and slurping wildly, he starts to jack himself off with his smaller hands.");
			//If Phylla Isn't Laying Eggs:
			else outputText("\n\nThe large ant lifts up Phylla's abdomen and bends it so the tip of it rests in front of his face.  Taken by surprise by the sudden stimulation, Phylla 'Eeps!'  The man behind her sniffs at the tip of her abdomen and licks it hesitantly as if testing the waters.  Phylla moans into the mouth of the ant morph kissing her.  Seeing as how he was rewarded for his efforts, the ant at her abdomen dives his head into the tip of her abdomen, licking and fingering her birthing hole.");

			outputText("\n\nYou can see Phylla's lust raising as she starts to forget herself and starts to just enjoy the touches and smells of what's happening to her body.  She happily begins jacking off her children with more gusto.  She even switches out who's kissing her, who's suckling on her, who's sucking on her egg opening, and who's getting handjobs - making sure all four of her children get equal shares of her body.");

			outputText("\n\nYou feel the ant you're giving a handjob to groan and start thrusting his cock into your hand.  You almost forgot what you were doing - watching Phylla get almost buried in incessant cocks clouded your mind. You release your grip on his cock, leaving him to give you a very confused and needful look.");

			outputText("\n\n\"<i>Go get 'er, tiger,</i>\" you say, as you slap his ass.");

			outputText("\n\nHe practically charges his mother, lustful wants burning through his veins.  Seeing him dash towards them, his brothers pull Phylla down onto the bed.  Soon she's in position; her shoulders on the edge of the bed and her head looking back up at her children.  Once he gets to his mother, the charging ant-man flops his cock in between her breasts and lets his balls hang above her mouth.  Phylla uses her smaller set of hands to press her breasts together against his long dick.  He starts thrusting his penis between her ");
			if (flags[kFLAGS.PHYLLA_EGG_LAYING] > 0) outputText("large, lactating ");
			else outputText("small ");
			outputText("orbs.");
			outputText("\n\nWith her face slapped by his balls with each thrust, Phylla takes it upon herself to start sucking on his nuts, covering them in her drooling saliva.");

			outputText("\n\nHaving his kiss stolen from him, the ant who was kissing Phylla grabs his nearest brother and shoves his tongue into his mouth.  The two ants who were being jacked off by their mother's smaller hands now find themselves neglected since she's using them to pleasure their brother as he thrusts between her breasts.  Having their own needs, the larger of the two lies down so his brother can lie down reverse on top of him; they immediately start to suck one another off in a sixty-nine position.");

			outputText("\n\nIt's then that you realize you're still completely clothed!  How inconsiderate of you.  You quickly shed your [armor].  Finding your own cock");
			if (player.cockTotal() > 1) outputText("s");
			outputText(" stiff and longing for immersion into this orgy, you just need to find an opening.  Walking over to Phylla, you tap the ant getting a tit fuck on the shoulder.  Without a second thought, he stands aside for you, letting his balls slip out of Phylla's mouth with an audible pop.  You grin down at Phylla, seeing that she's now completely lost and just enjoying herself.  It's at this moment that you feel shadows looming behind you.  Before you can react, hands reach down and start lovingly stroking [oneCock].");

			//If player has two-three dicks:
			if (player.cockTotal() > 1) {
				outputText("\n\nYou quickly find each of your cocks are being taken care of.  You can hardly tell who's touching or sucking what.  Looking down you see Phylla sucking the head of your longest cock as someone's hands run down the shaft.  Your other dick");
				if (player.cockTotal() == 2) outputText(" is");
				else outputText("s are");
				outputText(" getting sucked off by two of your children, who themselves are being sucked off.");
			}
			//If player has four-six dicks:
			if (player.cockTotal() >= 4) outputText("\n\nEven though you have free cocks, it won't be a problem for too long.  Just standing over Phylla you look down as hands, mouths, and Phylla's breasts do their best to please every one of your cocks in turn.");
			//Silly Mode (LOTR) player has 10+ dicks:
			if (silly() && player.cockTotal() == 10) {
				outputText("\n\nLooking down at your children, fear can be seen  in their eyes.  You decide to give a heartfelt speech.");

				outputText("\n\n\"<i>Sons, offspring, my children!  I see in your eyes the same fear that would take the heart of me!  A day may come when the semen of these cocks fail, when they go limp and never stand erect again... but that is not this day!  An hour of sorrow and sadness when these cocks cease to cum... but that is not this day!  This day you fight!  By all that you hold dear in this good colony, I bid you suck!  Suck all the cock!</i>\"");
			}

			outputText("\n\nThere are so many limbs and cocks in the pile that it's starting to get hard for you to distinguish who's who.  Not that you really care; you have your own needs which Phylla is already attending to.");

			outputText("\n\nHer mouth hangs open as if begging to be filled by [oneCock].  You didn't come here to get a blow job - you want her cunt.  You want your corrupt dick inside her.  You want to make her have to beg for release.");

			outputText("\n\nAll four of her hands welcome your cock, her fingers running up and down your long shaft as she guides it to the lips of her drooling cunt.  Looking down you see her long clit poking out from between her inner folds.  Phylla pants heavily, like a dog in heat; you can actually see the steam coming from her mouth.  You grab her hair and shove your face into hers.  As your tongue penetrates her mouth you feel the familiar tinglings of your minds joining together.");

			//f first time; having orgy:
			if (flags[kFLAGS.TIMES_CORRUPT_MALE_ANT_ORGY] == 1) outputText("\n\nYou feel the link but it seems strained, like butter spread over too much toast.  You quickly recognize why: you feel the five others in the room in your mind along with Phylla.  They're building to release, but Phylla has been keeping them all from climaxing.  Well, at least you've trained her well.");
			//Repeat:
			else outputText("\n\nYou knew this moment would come and you're mentally prepared for it.  Feeling your mind link to everyone in the room is still overwhelming at first, but you quickly get over it as your mind finds balance.");

			var x:int = player.findCock(1, -1, phyllaCapacity);
			if (x < 0) x = player.smallestCockIndex();
			outputText("\n\nWhen you've felt your mind completely sync up with everyone else in the room, it's like being drunk on sexual euphoria.  You almost lose yourself in it for a moment, but focusing your mind, you snap your eyes open. You see Phylla in front of you looking like a drugged slut; she runs all four of her hands over your " + cockDescript(x) + " at the entrance of her flooded cunt while her children play with her nipples and suck each other off.  Aggressively, you grab her arms and pin her down while simultaneously shoving your cock into her.");

			outputText("\n\nYou feel every mind in the room wince in pain, then be overcome with pleasure as your cock rams into the deepest part of Phylla's cunt.");

			outputText("\n\nThe pulsations of her vagina run up and down the length of your cock as she struggles to get into a comfortable position under you.  With the help of her children, she finally finds a good position as you thrust harder and harder on top of her.  Phylla blindly reaches out, each of her hands searching for her offspring.  The largest of your children takes position over Phylla's face - she welcomes his long dick into her mouth.  As the others realize that Phylla is searching for their cocks, they untangle themselves from each other and crawl yearningly to their mother.  Phylla start to pump away at their cocks with her four hands as two latch on to her breasts.");

			outputText("\n\nOne of your brood leans down and starts to feverishly lick the base of Phylla's clit as your cock slides in and out of her. His warm saliva coupled with Phylla's natural lubricant warms your cock and sends even more pleasure throughout your " + cockDescript(x) + ".");

			//If PC has Multi-Cocks:
			if (player.cockTotal() > 2) outputText("\n\nHaving just one of your cocks pleased as you ram her isn't enough.  You command your children, via the link, to get your other dicks off.  Quickly they oblige, using their hands and mouths to make sure no cock goes unpleased.");
			else if (player.cockTotal() == 2) outputText("\n\nHaving just one of your cocks pleased as you ram her isn't enough.  You command your children, via the link, to get your other dick off.  Quickly they oblige, using their hands and mouths to make sure no cock goes unpleased.");

			outputText("\n\nEverything rapidly starts to blur together.  Your nipples are pinched, but you can't tell by who. Your mind struggles to comprehend which limb is where and whose cock is whose.  You just want this feeling to last forever, lost in a sea of pleasure.  You snap out of your hyper-stimulated state of mind as the six minds connected to yours approach their climaxes.");

			outputText("\n\nIn a single instant you feel your synchronized release.  You feel the emptying balls of the five other males");
			if (player.hasBalls()) outputText(" along with your own");
			outputText(" as they coat Phylla in cum inside and out.  The walls of her pussy pulse and draw your semen towards her womb.  She swallows the cum of the child that released into her mouth, letting the warm feeling spread down her throat into her belly.  The four other males ejaculate all over their mother's stomach and breasts, coating her tan-colored skin in sperm.  You watch as Phylla uses all four of her hands to spread the semen all over her, as if wanting to bathe in it.");

			outputText("\n\n\"<i>I... need... more... we... nee~</i>\" Phylla sits up, but she doesn't look at you.  Instead, she licks her lips and gazes to the entrance of her room.  You turn and follow her stare.  Standing in the door are five or six more warriors, completely erect and ready.  You raise an eyebrow, and look to Phylla with a large grin.");

			outputText("\n\nYou spend the next few hours in a massive orgy, getting your dick");
			if (player.cockTotal() > 1) outputText("s");
			outputText(" sucked, stroked, inserted, and finally orgasming so many times that you lose track. Hours pass and you eventually pass out sitting atop Phylla's throne watching the writhing mass before you.");

			outputText("\n\nYou wake up some time later, body aching from exhaustion. Glancing over at Phylla to see how she's fairing after so much exertion, you see her sprawled out on cushions with pleased warriors surrounding her, her skin and chitin covered in a thick coat of semen.  You wonder to yourself if you should invite her to the stream to wash off.");

			outputText("\n\n\"<i>It's okay... they'll... lick me... clean...</i>\"  You hear Phylla's weak voice in your mind, although she still doesn't look conscious.");
			outputText("\n\nYou might want to stay and watch that, but you've spent too long down here already.  You collect your things, trying your best not to step on the twenty or so passed out ants on the floor as you head back to camp.");
			player.sexReward("vaginalFluids","Dick");
			dynStats("sen", -2);
			doNext(camp.returnToCampUseOneHour);
		}

//Orgy w/ Colony (Female)
//You tell Phylla you're interested in 'inspecting' your children.
		private function antColonyOrgy4Ladies():void
		{
			clearOutput();
            phyllaSprite(true);
			flags[kFLAGS.TIMES_CORRUPT_FEMALE_ANT_ORGY]++;
			//(First Time)
			if (flags[kFLAGS.TIMES_CORRUPT_FEMALE_ANT_ORGY] == 1) {
				outputText("She gives you a confused look, but does as you command. Tilting her head back and closing her eyes you watch as she silently 'communicates' to her children.");
				outputText("\n\n\"<i>I did what you asked. Five of my~ I mean our... finest warriors are on their way here.</i>\"");
				outputText("\n\nYou give her a nod, hoping that 'the finest warriors' will also have the finest cocks. Your mind quickly wanders to how it's going to feel having five dicks to do with what you please. As you thoughts lead you down the familiar path you can feel your [vagina] moisten");
				if (player.hasCock()) outputText(" and [eachCock] harden");
				outputText(" in anticipation. Snapping you out of your daydream, five males walk into the room holding themselves like veteran soldiers.");
			}
			//(Subsequent Times)
			else outputText("She nods weakly, knowing full well what 'an inspection' means by now. Looking down at the floor she closes her eyes and concentrates. After a moment you hear the familiar sound of footsteps rushing to her room. By your guess you would assume the children must be as excited for this as you are. Once they enter the room you can see your hypothesis is indeed correct.  All five of the muscular males are already completely nude and their 10-14 inch cocks are standing erect in anticipation.");

			//(Continued From First/Subsequent)
			outputText("\n\nPhylla clearly chose the best specimens from among her colony to show off for you. They quickly line up with their small russet brown abdomens to the wall. You walk down the line in front of them, like a military officer inspecting troops. Their chiseled bodies and large masculine frames look as though they've been working in the mines their whole lives. You stop in front of the largest of them and run your hand over his body with sinister intent looming in your mind. You caress his rough skin as your hand moves up and down his sculpted body.  His pecs tense up in surprise as you drag your nails down his neck; but like a good boy, he makes no attempt to stop you.");

			//If Femininity Greater than X:
			if (player.femininity >= 80) outputText("\n\nLooking how you do, it's really no surprise that all five of them are erect. Or maybe that's Phylla working to try and impress you; you'll find out soon enough.");

			outputText("\n\nYou continue to drag your nails into his chest, leaving bright red marks all the way down to the base of his shaft. He shifts uncomfortably as you guide your palm up his long hard member ending at his head. He lets out a studly grunt as you run your hand back down his cock and start to pump slowly.");

			outputText("\n\nYou glance up and down the line of men to see how they're holding up. All of them are watching you intently hoping you'll move to them next. Two of them reach out to start stroking their own cocks but you make a loud noise as if clearing your throat.  They all jump in surprise as you shake your head to denote that they're not allowed to touch themselves.");

			outputText("\n\nBy the amount of precum dripping from their cocks you would assume their balls are almost full to bursting.");

			outputText("\n\nYou turn to face Phylla, still teasing away, and mention her children need 'release' from time to time. Being the only female and Queen it's only fair she takes care of them. It's for the greater good.");
			//(Silly Mode:)
			if (silly()) outputText("\n\n\"<i>For the greater good.</i>\" you hear your children echo mindlessly.");
			outputText("\n\n\"<i>But... I... don't~</i>\" Phylla says, trying not to stare at you or her children.");

			outputText("\n\n\"<i>It's not about what you want! It's about what's fair!</i>\" You scold her. \"<i>You four!</i>\" You gesture to the other males who you aren't servicing. </i>\"Go get some 'release.'</i>\"");

			outputText("\n\nPhylla looks almost terrified as her four offspring descend on her, cocks in hand.  You stop stroking the cock of the only remaining male and demand he remove your armor. Quickly he uses all four of his strong arms to remove your [armor]. Once you're completely nude you push him onto his knees.");
			if (player.isBiped()) outputText("  Setting one foot on his shoulder, you present your [vagina] to him.");
			else outputText(" Now at the perfect height, you present your [vagina] to him.");
			outputText("  Knowing full well what you want he plunges his face into your ready cunt and starts eating you out. You close your eyes and lean back, letting the passion of his licking consume your thoughts. You hear a loud moan and it snaps you out of your revelry.  You look over to Phylla. Her children have forced her onto her knees. Phylla uses all four of her hands and her mouth to please her children. You see her sloppily sucking off one dick then jump to sucking off another, exchanging her mouth with her hands as she services every dick in front of her. You glace between her legs and see streams of her wetness as it runs down her chitin legs and pools around her knees.");
			outputText("\n\nGetting close to orgasm just by the oral pleasure coursing through your nethers, you pull the head of the ant");
			if (player.isBiped()) outputText(" from between your legs.");
			else outputText(" from your cunt.");
			outputText("  You beckon him to follow you as you strut over to where Phylla is.");
			outputText("\n\nPhylla's glazed eyes and blank expression look very cute in a very twisted sort of way. She looks up and gazes at you as a fresh load of semen drips from her open mouth.");

			outputText("\n\n\"<i>I...</i>\" She trys to say before you interrupt her.");
			outputText("\n\n\"<i>Swallow that! I won't have any of our children's seed go to waste,</i>\" you demand.");
			outputText("\n\nPhylla closes her mouth, smiles, and swallows. You watch her small adam's apple go up with a gulp.  Once she's finished she opens her mouth to show you that she didn't let a drop go to waste.");
			outputText("\n\n\"<i>Please... I... we... need...</i>\"");
			outputText("\n\nYou kiss her, knowing that's what the slut wanted the whole time.");
			outputText("\n\nYou feel your mind and emotions synchronize with Phylla's. It's a bit overwhelming at first.  All you can feel from Phylla is her unbridled need to mate with everything, male, female, both, it doesn't matter to her.  She just wants... no, needs... to breed.");
			outputText("\n\nThis joined feeling sets both your loins afire.");
			outputText("\n\nYou reach down and give her pussy a playful touch. The surprise touch causes her nectar to pulse out, splashing lightly on your hand. You move your legs in between hers so that your pussies meet. Feeling her long hard clit on the folds of your [vagina] only makes you want it more but there's others in the room as well and they need attention. As you rock your hips into Phylla the males gather around the two of you in a circle. Holding on to Phylla's abdomen for balance you grab the nearest cock in front of you and start to suck it wildly. You can hear grunts and moans as Phylla takes a cock in her mouth as well.  You feel a dick caress the back of your free hand. Without a second thought you grab hold of it and start to pump.");
			outputText("\n\nYou and Phylla almost break apart as a male wriggles his way between you two and shoves his 14 inch cock interveningly between your two cunts. You hear Phylla coo at this sudden intruder.");
			outputText("\n\nThe two of you sandwich his cock between your pussies as you both gyrate your hips along his shaft. The cock between your legs throbs as it slides in and out of between your tightly joined cunts.");
			outputText("\n\nFeeling your children's yearnings through Phylla's mind gives you an idea. Though normally you wouldn't want to give up control, the current situation and your craving for something to fill your [vagina] leads you to command your man sluts to stop. You untangle yourself from Phylla, leaving the moaning whore begging and grabbing at you to rejoin her. You stand above her as she practically grovels at your feet, pleading for you. You mention you have a much better idea.");
			outputText("\n\nWith a commanding tone in both voice and mind you tell Phylla to get into the doggystyle position facing away from you.");

			//If Laying Eggs:
			if (flags[kFLAGS.PHYLLA_EGG_LAYING] > 0) outputText("\n\nYou're sure she would have too, had it not been for her massive egg filled abdomen. The best she can muster is to lay on her side with one of her legs up in the air.  Still, you think it will work for what you have in mind.");
			//If NOT Laying Eggs:
			else outputText("\n\nQuickly, Phylla scrambles into position.  Reaching back with her two larger hands, she lifts her abdomen so you get a full view of her shapely ass and juicy cunt.  She starts to lightly thrust her ass in the air.");

			outputText("\n\nOnce she's in position, you get into the same position adjacent to her, lifting your own [butt] high into the air, like Phylla is. She looks over at you with a shocked expression on her face.  She looks as though she's about to say something but her attention is quickly drawn back to her offspring.  Two of the males present their cocks to your mouths.  The alluring aroma of pre-cum and saliva is practically begging you to take them into your mouth.  Glancing over you can see Phylla is having just as hard a time stopping herself from gobbling down the cock in front of her, but it's not just that time. You make a mental signal and two more step up behind both of you.  You hear Phylla 'Eep!' as the heat radiating off her sex is intruded upon. The two behind you drag their dicks up and down the folds of your vaginas.  The fifth takes position behind his brother who's behind Phylla.  Wouldn't want any hole going to waste, would we?");

			outputText("\n\nWith both yours and Phylla's asses hanging in the air like dogs in heat, you feel your joined excitement for what's going to happen next.  You can feel the heat radiating off your cunts warming the tips of the cocks behind you. You smell the intoxicating aroma of sex in the air.  Male and female fluids joining, the scent of earth, the heavy labored breathing of everyone in the room.  It all joins to consume your senses.");
			if (player.hasCock()) {
				outputText("  You feel hands run up and down your shaft");
				if (player.cockTotal() > 1) outputText("s");
				outputText(", causing you to spurt bursts of pre all over the floor.");
			}
			outputText("\n\nPhylla's mind screams out for penetration.  Your own mind and your body cannot handle the anticipation anymore either.");
			outputText("\n\nMentally you give the 'go ahead' to your children, something you feel they've been waiting for! All five males thrust their cocks forward in unison.  You're not sure what feels better; the fact that your mouth and [vagina] are now filled with your own children's genitals, or the fact that Phylla is too hyperstimulated to even fully comprehend what's happening to her.  Your tongue wraps around your son's cock as you do your best to drink in the pre-cum he's been accumulating.  The ant behind you thrusts at an alarming rate, sending shockwaves of passion though your body.  You hear Phylla's moans of pleasure though the dick she has stuffed in her mouth.  The triumphant roar of your child almost overpowers her moan as he thrusts into his brother; who in turn thrusts deep into Phylla.  You want to look over, you want to enjoy the sight of seeing Phylla skewered by dicks like a cabob. Unfortunately the sons at your front and rear keep your mind and body thoroughly occupied with their long throbbing man meat.");
			player.cuntChange(20, true, true, false);
			outputText("\n\nWhen you can muster the fortitude and focus enough to open your eyes, without them rolling back into your head, all you see is your son's cock as you deep throat him.  The harder and deeper the ant behind penetrates into your [vagina], the deeper the cock of the one in front thrusts into your throat.  Not that you're complaining, both of the feelings send crushing waves of euphoria through your mind and body.");

			//If PC has dick(s):
			if (player.hasCock()) {
				outputText("  Not forgetting you have 'other needs' the ant mounting you reaches down with his larger arms and grabs hold of [eachCock].  Keeping his smaller arms on your hips to keep stable with each thrust, he pumps vigorously at your cock");
				if (player.cockTotal() > 1) outputText("s");
				outputText(".");
			}

			outputText("\n\nYou feel your son's thrusts into the depths of your cunt become slower but with more force behind them, signaling to you the inevitable, conclusion to your insestrial orgy.  Not wanting him to cum too early, you mentally reach for Phylla's mind to see how she's~");
			outputText("\n\n Before you can finish searching, Phylla's mind and pleasure crash into your mind like a wave.  She's cum twice already but she's close again and all 5 of your children are teetering on the edge of climax as well.");
			outputText("\n\nThe sounds and speed of this sexual romp reach a crescendo as you do your best to tighten the muscles of your ass and cunt, calling to the son mounting to give it all he's got.  You feel and hear Phylla follow your lead, bracing herself as your sons thrust against the two of you in unison.  Both of your mouths form tight seals on the cocks in them as you both get pounded from behind.");
			outputText("\n\nIn one last climax-inducing thrust, all five of your children, Phylla and you share in one of the most ectasy filled orgasms you've ever experienced.");
			outputText("\n\nYour own oragasm rocks your whole body as you try your best not to black out due to the sheer volume of pleasures your shared minds are experiencing.");

			//If player is squirter:
			if (player.wetness() >= 4) outputText("\n\nYou roar in climatic bliss as you feel your already soaked cunt release its fury as you squirt your juices all over the ant mounting you.");
			//If player has dick(s)
			if (player.cockTotal() > 0) {
				outputText("\n\nAlthough you wish someone had been under you to catch your cum as it erupts from your dick");
				if (player.cockTotal() > 1) outputText("s");
				outputText(".  You feel your load");
				if (player.cockTotal() > 1) outputText("s");
				outputText(" splash into your [chest] and chest as ");
				if (player.cockTotal() == 1) outputText("it");
				else outputText("they");
				outputText(" unload.");
			}

			outputText("\n\nYou feel a flood of warmth fill your womb as the warrior behind you unloads his swollen nuts into you.  This eruption of passion fills you with maternal pride, a feeling you're sure is mostly being projected into your mind by Phylla, as you feel her belly fill with the same warmth.  The ant dick in your mouth throbs; you quickly reach up and gasp his balls, begging for everything he's got, and he doesn't disappoint.");

			outputText("\n\nYou feel his salty payload erupt in bursts from his urethra, coating the back of your throat, and flooding into your mouth; causing you to puff out your cheeks a bit.  You hastily gulp it all down, feeling the warm load slide down your esophagus into your stomach.");
			outputText("\n\nOnce you're done, you look over at Phylla and see she's just finishing her own 'meal.'  Watching her head bob up and down on her son's cock as the muscles of her neck work to swallow the salty snack is very sexy to watch.");
			outputText("\n\nNow that your head is clearing up you see you've completely spent all five of your children as they collapse into a pile.  Phylla half crawls, half drags, herself over to you, semen and her own juices oozing from between her legs, leaving a small trail behind her.");
			outputText("\n\n\"<i>I-I need more... not... done...</i>\"");
			outputText("\n\nYou then realize Phylla wasn't crawling to you at all, but to the doorway.  Looking at the door you see at least four more males, fully erect and ready to go.");

			outputText("\n\nYou chuckle to yourself; what a good slut Phylla has become.  You might as well join her - don't want her to have all the fun.");
			outputText("\n\nYou wake up some time later, your body aching from exhaustion.  You look over at Phylla to see how she's fairing after the orgy.  She's sprawled out on her cushions with pleased warriors surrounding her.  Her skin and chitinous armor is covered in a thick coat of semen.  You wonder to yourself if you should invite her to wash off.");
			outputText("\n\n\"<i>It's okay... they'll... lick me... clean... oh, don't worry about getting pregnant; they're all sterile unless I say otherwise.</i>\"  You hear Phylla's weak voice in your mind, although she still doesn't look conscious.");
			outputText("\n\nYou might want to stay and watch that, but you've spent too long down here already.  You collect your things, trying your best not to step on the twenty or so passed out ants on the floor as you head back to camp.");
			player.sexReward("cum", "Vaginal");
			dynStats("sen", -1);
			doNext(camp.returnToCampUseOneHour);
		}

//►[Lay Eggs / Don't Lay Eggs]
		private function phyllaLaysEggsToggle():void
		{
			clearOutput();
			//(Lay Eggs)
			if (flags[kFLAGS.PHYLLA_EGG_LAYING] == 0) {
                phyllaSprite(true);
				flags[kFLAGS.PHYLLA_EGG_LAYING] = 1;
				outputText("Phylla seems confused as to what you're thinking as you gaze deeply into her eyes.  You gather all four of her hands between the two of yours and tell her that children are wanted.  Not just one or two; you want as many as she can muster.");
				//If you've talked to her about history:
				if (flags[kFLAGS.TALKED_WITH_PHYLLA_ABOUT_HISTORY] > 0) outputText("  You tell her you want a colony like those she spoke of in the times before the corruption.");

				outputText("\n\nAt first her eyes widen with shock, but then you see the reaction you were expecting; her face lights up with such a gleeful smile you could have sworn you just lit a large fire in the room.  She looks so excited; in fact, she seems to have lost her train of thought and just stands there taking in what you said... it's a bit odd.  Then she suddenly turns around and drops down on all fours.  Her abdomen rises, revealing all of herself to you.  Her embarrassment is clearly overshadowed by her desire to breed with you.  She looks at you from between her own legs and blushes, her cheeks growing as red as a tomato.  Using her two upper arms, she points to her abdomen, keeping her lower arms to support her as she's bent over on all fours.  There's a small opening that almost looks like a second vagina placed at the very end of her abdomen.  A clear coat of transparent liquid is already starting to seep out from the opening and has started to run down her abdomen.");

				outputText("\n\n\"<i>I just...  need you to lick it.  I mean, that's one way...  there are others, I mean, but this is the quickest; I want to start laying before nightfall.  Please...  I need this...</i>\"");
				//[Yay!] Transition to - LICK THAT!
				//[On your own] Transition to - DON'T LICK THAT!
				menu();
				addButton(0, "Lick That", lickThatAntButt);
				addButton(1, "Don't Lick", dontLickAntButt);
			}
			//(Stop Laying Eggs)
			else {
				flags[kFLAGS.PHYLLA_EGG_LAYING] = 0;
				outputText("You sigh to yourself; you never really wanted this conversation but you knew it might happen someday.  You make a stern face and put a determined fatherly tone in your voice.  Phylla immediately senses you mean business and you have her full attention.  You try to tell her as gently as possible that you don't think it is safe for her to keep having children.");

				outputText("\n\nTo your almost astonished surprise she hesitantly agrees with you; somehow, you expected her to argue with you or plead to bring more life into this world.  \"<i>If you feel it's not safe for me to have any more children, I won't.  I mean, you're both my mate and my colony's protector.  I would not want to endanger my children by overpopulation or the chance of corruption.</i>\"");
				outputText("\n\nShe pauses and makes a strange face as her abdomen pulses and another egg emerges from the tip.  She blushes deeply.  \"<i>That's the last one!  I mean, I had to get it out, it was already...</i>\"");
				outputText("\n\nYou cut her off by asking when her abdomen will return to normal size - both because you're curious and because you really didn't want her to finish that sentence.  \"<i>It shouldn't take long.  I can already feel it changing.</i>\"");
				outputText("\n\nSmiling, you thank her for complying with all your demands.  You leave the colony, heading back to camp.");
				doNext(camp.returnToCampUseOneHour);
			}
		}

//LICK THAT!
		private function lickThatAntButt():void
		{
			clearOutput();
			outputText("You tilt your head slightly.  You thought she said she could start to lay any time after the first time you had sex with her.");
			outputText("\n\n\"<i>It is... faster... to kickstart it... if you help... please...</i>\"");

			outputText("\n\nHearing Phylla beg like this gets you aroused to some degree, but there's no time!  In the few seconds it took for her to explain to you what you need to do, the small trickle of liquid now seems to be spurting out in pulses much like what you would think the contractions of a pregnant woman would be like.");

			outputText("\n\n\"<i>Now!  Please!  I can't wait!</i>\"  Phylla's begging moans force you into action.");

			outputText("\n\nYou grab the sides of her abdomen with both of your hands and dive into her birthing slit with your face.  Almost as soon as your tongue enters her river-like slit, she shudders as a powerful orgasm washes over her.  The vagina between her legs sprays girl cum all over the floor, some of it launching far enough to reach your feet.");
			outputText("\n\nFaced with this, you don't even attempt to stop or even slow down.  You ravage her birth canal with your tongue like it owes you money.  She orgasms again and then again a few minutes later - the only real way you have of telling at this point is when her warm juices squirt out and splash at your feet.  At this point, she's just moaning and shaking constantly.  If you hadn't been holding her abdomen all this time she'd have fallen over several orgasms ago.");

			outputText("\n\nAfter about an hour of this, you remove your face from her wetness and release your vice-like grip on her abdomen.");

			outputText("\n\nAs she collapses in front of you, your eyes widen in shock.  You hadn't even noticed while you were occupied with pleasuring her, but her abdomen has almost quadrupled in size!  It's now easily six feet long, and it seems like every time you blink it gets just a little larger.  Stepping towards Phylla's body - now almost blocked by her engorged abdomen - you hear a distinct splash.  Looking down, you find to your amazement that the floor is almost completely coated in a thick layer of mixed girl cum and birth lubricant.  Honestly, there is no way of telling which one there's more of.  The mixture of fluids smells like an earthy plain after a light rain.  As you make your way to Phylla, you see her breasts have also grown in size and could now easily be DDs.  She makes a totally exhausted grab at you with all four of her arms, her eyes still rolling up in the back of her head slightly.  You forget that even in her current state she's amazingly strong and with a small splash, she drags you down into laying next to her.  All four of her arms wrap around you lovingly.");

			outputText("\n\nAfter about a minute or two her eyes widen suddenly, her body contracting.  With a sudden pulse you can see a contraction run down Phylla's abdomen.  A small cylindrical egg about the length of your forearm pops out of the birth slit you were just licking for the last hour.");

			//First Time:
			if (flags[kFLAGS.ANTS_BIRTHED_FROM_LICKING] == 0) {
				outputText("\n\nIt's a strange thing, unlike any egg you've seen before.  It doesn't have a shell and is transparent.  The liquid inside of it seems to be shimmering, as if there were thousands of tiny gold flecks in it.  In the very center there's a black sphere that unfolds into a larva as you look at it.  Phylla quickly snatches it up and holds it between the two of you.");
				outputText("\n\n\"<i>This is the beginning of a whole new life for me...  I mean, for us.  I'll always remember this, [name]!</i>\"  Phylla cries, cradling the egg close to her, proud to be a mother.  \"<i>I... I love you.</i>\"");
				outputText("\n\nYou were about to return the compliment when her body contracts again and another egg pops out of her abdomen.");
				outputText("\n\n\"<i>So quickly?</i>\" you question her, clearly surprised at the rate at which she can reproduce.");
				outputText("\n\nOnce she has recovered, she responds, gasping for breath between contractions.");
				outputText("\n\n\"<i>It's not usually... this fast.  It's just... you... did so well...</i>\" she gasps between smaller contractions.");
			}
			//Subsequent Times:
			else outputText("\n\nYou know the drill.  You unwrap yourself from Phylla and walk over to scoop up the cyclical egg.  Once you've gotten it you bring it back to her.  Although as soon as you do, she snuggles up with it.");
			outputText("\n\nAfter only a minute or two, a large contraction passes through her body, and another egg seeps out of the tip of her abdomen.  You can see she's going to be very busy for the next few hours, maybe days; you're not really sure, and clearly she's in no condition to respond even if you asked.  You kiss her and head back to camp, happy with the job you've just accomplished.");
			flags[kFLAGS.PHYLLA_COOLDOWN] = 12;
			flags[kFLAGS.ANTS_BIRTHED_FROM_LICKING]++;
			if (flags[kFLAGS.ANT_KIDS] < 5000) flags[kFLAGS.ANT_KIDS] += 5;
			doNext(camp.returnToCampUseOneHour);
		}

//DON'T LICK THAT!
		private function dontLickAntButt():void
		{
			clearOutput();
			outputText("Hesitantly, you tell Phylla that you aren't exactly comfortable with licking her privates... while they are leaking birthing fluids.  Acting quickly though, you reassure your lover and tell her that you're willing to massage her intimate parts.  A warm smile spreads across her face; she's pleased that despite your reservations, you're willing to help her in a way that works for both of you.");
			outputText("\n\n\"<i>T-thank you...</i>\"  She whispers, breathing in a mix of anticipation and need as you work your way behind her.  As you touch her slit she gasps, your soft touch causing her to shudder.  The contractions of birth start not long after, no longer held back by Phylla's will.  \"<i>More...  Oh gods, more...</i>\"  She whimpers, groaning with each convulsion of muscle.  Plying your thumbs, you begin to massage the outer opening in a circular fashion, doing your best to gently aid Phylla in bringing your children into the world.");

			outputText("\n\nThe process of simulation goes on for a several long, moan filled minutes, until with a hearty cry the orb that holds your newborn child slides out from Phylla's abdomen.  Panting and breathing a sigh of relief, your Ant Morph lover thanks you, but reminds you that she has quite the clutch of eggs that still needs to be laid.  Smiling, you renew your efforts along her orifice, to the affectionate gasps of Phylla...");

			outputText("\n\nThe better part of an hour later, the two of you lay against Phylla's bedding in a loving embrace; you cuddle the exhausted ant woman close to you as she enjoys the tender feel of your fingers running through her hair.");

			outputText("\n\n\"<i>Thank you.  I-it meant a lot to me for you to be here.</i>\"  She confides.  You tell her that it was no trouble at all; that you wouldn't miss this joyous moment.  Phylla sneaks in a soft kiss on your neck and gives you a firm squeeze of her arms.  \"<i>I should be alright on my own at this point");
			if (flags[kFLAGS.ANT_KIDS] > 1) outputText("; the children can tend to the eggs and I can really use the rest");
			outputText(".  You should get back to your duties...  B-but I wouldn't mind if you came back later...</i>\"");

			outputText("\n\nYou remark to Phylla that you might just take her up on that and wink as you leave your exhausted lover to recuperate, passing several of your children as they scoop up the bundle of eggs that lie huddled together on the floor.");
			flags[kFLAGS.PHYLLA_COOLDOWN] = 6;
			flags[kFLAGS.ANT_KIDS]++;
			doNext(camp.returnToCampUseOneHour);
		}

//Phylla lays Drider eggs
		private function phyllaLaysSomeDriderEggs():void
		{
			clearOutput();
            phyllaSprite(true);
			pregnancy.knockUpForce(); //Clear Pregnancy
			outputText("As you near Phylla's bedchamber you can hear an 'Eeep!' of surprise and worry. Thinking she might be in trouble you burst into the room.  Glancing around for any immediate danger you only see Phylla's vagina drooling a green, slimy mucus.  The way she holds her very pregnant stomach and splays her legs out on the bedspread suggests that your recently laid spawn are ready to hatch.  \"<i>[name], it's time!  UGH!  I don't... have to words to express how weird this feels!</i>\"  Phylla cries out, somewhat scared at the green ooze that trickled out of her.");
			menu();
			addButton(0, "Help", helpHer);
			addButton(1, "Watch", watch)
				.disableIf(player.cor < 60 - player.corruptionTolerance, "You're not THAT corrupted.");

			//PC has less than 75 corruption:
			function helpHer():void {
				outputText("\n\nQuickly kneeling at her bedside, taking one of her larger her hands in yours, you inform her that your children are ready to enter this world. They need their mother to concentrate and push.");
				//If Phylla is Laying (her) Eggs while Drider eggs hatch:
				if (flags[kFLAGS.PHYLLA_EGG_LAYING] > 0) outputText("\n\n\"<i>It's~AHHH!</i>\"  Phylla moans into your shoulder as a contraction passes through her abdomen.  \"<i>I don't know if I can do both!</i>\"  Phylla cries.  In a reassuring tone you tell Phylla she just needs to push both at once.");
				outputText("\n\n\"<i>I~Ahhh</i>\" her words, again, stolen from her as you see her whole body contract.");
				outputText("\n\n\"<i>Oh, gods, I can feel yours sliding out!</i>\"  She half exclaims, half moans.  Phylla's body writhes in a mixture of pleasure and pain as she solely focuses on pushing.  After what seems like an eternity, she breathes a heavy sigh of relief as the first of many eggs works its way out of her.");
				//If Phylla is Laying (her) Eggs while Drider eggs hatch:
				if (flags[kFLAGS.PHYLLA_EGG_LAYING] > 0) outputText("\n\nAt the same time your egg drops to the floor, you see one of Phylla's eggs glide out of the tip of her abdomen with the aid of the thick gel she produces.");

				outputText("\n\nWith the knowledge that ");
				if (flags[kFLAGS.PHYLLA_EGG_LAYING] > 0) outputText("both eggs are just fine on their own");
				else outputText("the egg is just fine on its own");
				outputText(", you redirect your focus to helping Phylla through the labor.  Each subsequent egg that finds its way to freedom causes Phylla's once pain filled screams to turn into pleasurable moans of euphoric delight as her pussy becomes overwhelmed by the stimulation of each of your eggs working their way out.  At long last, the final egg slithers out of her vagina and lands gently on the bedding.  Her ordeal over, Phylla breathes a long sigh of relief.");
				//First Time:
				if (flags[kFLAGS.PHYLLA_TIMES_DRIDER_EGG_LAYED] == 0) outputText("\n\n\"<i>I-I've never given birth like that b-before.</i>\"  She manages between gasps for air while rubbing her now normal-sized belly.\n\n\"<i>I mean!  I want to, it was just different, usually I... use my...</i>\"  She shyly gestures to her abdomen.  \"<i>You'll have to do that to me again sometime.</i>\"  You feel a maternal warmth radiating from Phylla.  It's clear to you that she just enjoys being a mother; it doesn't really matter to her what her children look like.");
				//Subsequent Times:
				else outputText("\n\nRubbing her now empty belly Phylla remarks on how much she loves giving birth through her 'other hole' and how you should knock her up this way much more often.  Again you feel the maternal warmth radiating from Phylla.");

				outputText("\n\nYour intimate moment with her is interrupted by the crackling and hatching of eggshells as your brood clamors for freedom.  Sighting their mother, they scurry up the bedspread and set up a pecking order for who will get the first go at Phylla's milk filled breasts.  The birthing complete, you kiss Phylla on the lips and thank her for hosting your young.  \"<i>Thank you for helping me achieve my purpose in life.  I know you have other things to do, but just know that... I love you.</i>\" She weakly replies.  You wink at her and nod before heading back up to the surface.");
				doNext(camp.returnToCampUseOneHour);
			}
			//PC has more than 75 corruption:
			function watch():void {
				outputText("\n\nGood, you get to watch while your corrupted young are birthed out of this creature naive enough to submit to your desires.  Phylla's painful screams quickly turn into blissful moans as her instincts for sexual pleasure dull the irritating agony and take over her mind.  You barely register any of it as your thoughts turn to future instances of pinning Phylla down to her bedding - how her ass will wave enticingly in the air just before you penetrate her and plant as many eggs as you can muster inside of her, how she'll beg to be stuffed with your brood and howl like a depraved whore as your cargo fills her with your corrupted brood.");
				outputText("\n\nThe first egg works its way out of Phylla's pussy as she hums in obvious sexual delight.  You lick your lips at the sight; you can barely contain the urge to mount her right now and impregnate her with more of your future children, imagining the look of content violation on her face as you do so.  But you manage to restrain yourself, opting instead to watch the show as egg after egg worms its way out.");
				//If Phylla is Laying (her) Eggs while Drider eggs hatch:
				if (flags[kFLAGS.PHYLLA_EGG_LAYING] > 0) outputText("\n\nAs if your own corrupt brood weren't enough for her, she has to deal with giving birth to her own offspring at the same time.");
				//First Time:
				if (flags[kFLAGS.PHYLLA_TIMES_DRIDER_EGG_LAYED] == 0) outputText("\n\nHmm... That's something you didn't know she could do and something you'll damn well keep in mind for the future.  You watch as she struggles to time the different contractions of her abdomen and cunt, but ultimately fails to do so.  It's soon very clear she's no longer aware of which egg is coming out of which hole and just screams out in passionate moans as her whole body surges and pulses with contractions.");
				outputText("\n\nWith one last heave the last egg is expelled from Phylla's pussy.");
				//If Phylla is Laying (her) Eggs while Drider eggs hatch:
				if (flags[kFLAGS.PHYLLA_EGG_LAYING] > 0) outputText("\n\nThough judging by the size of her abdomen, you're sure she still has a few left.  Her own eggs don't seem to cause her as many 'problems' as your eggs do.  Phylla tiredly slumps back to her bed, completely spent.");
				dynStats("lus", 45, "scale", false);
				dynStats("cor", 3);
				if (player.canOvipositSpider()) {
					outputText("\n\nGods DAMN!  You want to knock her up so bad!  Your Drider urges to mount her are in danger of overwhelming you and reducing you to a brainless breeder... maybe that isn't so bad after all, but you need to make a decision now before you're consumed by lust!");
					menu();
					//[Leave her to recover] - Let Phylla Recover  [Mount] - Mount Phylla
					addButton(0, "LetHerRecover", letPhyllaRecover);
					addButton(1, "Mount", driderDoublePhllaMount);
				}
				else {
					menu();
					//[Leave her to recover]
					addButton(0, "Next", letPhyllaRecover);
				}
			}
			flags[kFLAGS.PHYLLA_TIMES_DRIDER_EGG_LAYED]++;
			flags[kFLAGS.PHYLLA_DRIDER_BABIES_COUNT] += 5 + rand(4);
		}

//Mount Phylla:
		private function driderDoublePhllaMount():void
		{
			clearOutput();
			outputText("No longer able to control yourself, you rip free of your [armor] and charge up to Phylla's bed, catching her by surprise as she looks up at you.  With a seductive smile, you pin her down and slather your ovipositor against her fuck hole.");
			outputText("\n\nYour voice whispers through her being and ignites her sexual desire as you tell her that you feel she'd benefit from having more eggs inside of her.  Bending her rump so that you have the perfect angle, Phylla whimpers in uncontrollable anticipation.");

			outputText("\n\nNot one to keep a 'queen' waiting, you lurch forward and work your egg-filled appendage into her still wet cunt, edging deeper and deeper, releasing your lubricative mucus inside of her until you can go no further.  Now tightly within her depths, your ovipositor convulses in orgasm as your payload works its way into her body, leaving you screaming in sexual fury as you once again impregnate Phylla with your eggs.");

			outputText("\n\n\"<i>OH GODS!  I-I NEED MORE!  FILL ME!  FILL ME WITH YOUR YOUNG!  GUAAAHHHHHHHH!</i>\"  She howls furiously.  Grinning, you take satisfaction in how far you've pushed Phylla, turning her into an eager eggslut.  Glazing over, her eyes roll up into her head as she wears an expression of sensual devastation.");

			outputText("\n\nAt last, your egg supply is exhausted and you pull free of the Ant Morph, carefully walking over broken and soon to be broken eggshells as your children skitter up to their mother's nourishing breasts.  Phylla only coos with deep content as she cradles her stomach, barely taking notice of the young spiders that squabble over who gets to suckle first.");
			player.sexReward("Default","Default",true,false);
			dynStats("cor", 1);
			//empty eggs and such!
			player.dumpEggs();
			//set phylla drider preggo timer
			if (!pregnancy.isPregnant) pregnancy.knockUpForce(PregnancyStore.PREGNANCY_DRIDER_EGGS, 8 * 24); //Supposed to be eight days, not eight hours
			doNext(camp.returnToCampUseOneHour);
		}

//Let Phylla Recover:
		private function letPhyllaRecover():void
		{
			clearOutput();
			outputText("Working up all of your self-control, you decide that Phylla could use the rest.  You wink at Phylla as you leave, telling her that you'll be back to fuck her brains out shortly... once she feeds your children.  She only musters the strength to smile and mutter something about motherhood but you're already halfway out the door.");
			doNext(camp.returnToCampUseOneHour);
		}

//►[Children - Only available if Phylla has laid eggs]
		private function phyllasKidsChildren():void
		{
			clearOutput();
			outputText("Phylla seems surprised you would be interested in the fruits of your loins.  \"<i>Usually once my kind take a mate they never come back to their colony.  I mean!  Not that I don't want you to come back, I-I like when you come down here.  It's just, usually not what happens.</i>\"  You reassure her you don't mind and that sometimes it's good to get away from the surface to see your progeny.  Her face seems to light up when you imply that they're 'your children.'");

			outputText("\n\n\"<i>They're great; I mean... just look at who they come from.</i>\"  She gives a timid nudge and continues.  \"<i>They take care of me and we've started to dig deeper into the ground.</i>\"");

			//If birthing for less than 10 days:
			if (flags[kFLAGS.DAYS_PHYLLA_HAS_SPENT_BIRTHING] < 10) outputText("\n\n\"<i>We haven't made much progress, but many of our children are still young and not fully able to serve me.  I mean us!</i>\"  She quickly corrects herself.  \"<i>The progress is slow but it's nice to have them around.  Little reminders of you when you're not here.</i>\"  She smiles widely.");
			//If birthing for more than 10 days:
			else if (flags[kFLAGS.DAYS_PHYLLA_HAS_SPENT_BIRTHING] < 40) outputText("\n\n\"<i>We've made considerable progress as you can no doubt tell.  Most of our children are completely capable of digging their own tunnels and with as many as we have, the progress is quite fast.  A few of them have even taken your name.  I mean, I hope you don't mind.  I started running out of names around the one hundredth egg.</i>\"");
			//If birthing for more than 40 days:
			else {
				outputText("\n\n\"<i>The colony is as big and wonderful as I ever hoped it would be. I've now toned back on my egg laying to keep our colony at a sustainable level.  This colony even rivals my mother's - in fact, I think it's a little bigger.</i>\"  You hear a very prideful tone in her voice.  Though she seems thrilled, Phylla can tell that you don't really feel the same way; her mother's colony was massive and you consider the possibility that you might have let this go on a little too long.");
			}
			outputText("\n\nClearly she sees you're not at ease and tries to reassure you.  \"<i>We don't have an arena like my mother did; I have no reason for such a thing.  I mean, unless it would make you feel more comfortable down here...</i>\"  That's the last thing that would make you comfortable; you could have died in that arena and you'll be damned if you ever see another one again.  \"<i>Well, your children are happy.  They're living out their lives in peace and prosperity.  All thanks to you.</i>\"");

			//If Phylla given birth to Drider Eggs:
			if (flags[kFLAGS.PHYLLA_TIMES_DRIDER_EGG_LAYED] > 0) outputText("\n\nYou inquire about ALL of your children, knowing Phylla was just talking about your ant offspring previously.  Phylla quickly glances at the ground, clearly embarrassed she forgot and that you remembered.\n\n\"<i>They're...much larger than I would have expected, and I... can't communicate with them like I can with my... kind... but they help dig, I mean... they're capable of digging... they're just more playfully aggressive and rambunctious than I expected.  But their size makes them excellent guards and caretakers for the rest of the children.  I'm not used to it, but I love them just as much as my own.</i>\"");
			//PC has birthed 30 Drider children or more:
			if (flags[kFLAGS.PHYLLA_TIMES_DRIDER_EGG_LAYED] > 10) outputText("\n\nShe sighs forlornly but continues.  \"<i>Some of our drider offspring have even taken it upon themselves to leave the colony and venture out into the world.  Not that I mind; it's just sad seeing them go sometimes.  I know we did a good job raising them, and I hope they take the lessons we taught them to heart, and that they never forget where home is...</i>\"");
			//Ending for Scene
			outputText("\n\nYou feel good about this.  Standing up to survey the colony, you can see Phylla is also very content.  You thank her for talking to you and head back to the surface, toward camp.");
			doNext(camp.returnToCampUseOneHour);
		}

//►[Appearance]
		private function phyllaPearance():void
		{
			clearOutput();
			//Not Laying Eggs
			if (flags[kFLAGS.PHYLLA_EGG_LAYING] == 0) {
				outputText("Phylla is a 5-foot 8-inch tall ant morph with a very small, feminine frame covered in highly defined muscles.  She has four arms, two that attach at her shoulders and two slightly smaller ones that attach at her serratus anterior on her stomach.  Both sets of her arms and human-like legs are covered in plates of semi-reflective brown chitin armor.  ");
				outputText("Her interlocking joints remind you of how insect joints connect to one another. Her abdomen is about 4 feet long and is covered in large interlocking plates of skin colored exoskeleton.  Despite the fact that she has to carry the weight of an abdomen, her hips are very girly.  Her well toned butt is rarely seen as her abdomen covers it most of the time.  She has a sharp, slightly feminine face and large almond shaped emerald-green eyes with no hint of pupils or irises.  Her mouth is surprisingly large considering how thin her lips are.  When she smiles at you, you see a single row of human like teeth with typical human canines.  Her short brown hair is usually matted and covered in dirt, although on rare occasions she styles it so that two long bangs frame her face leaving the rest to flow around her neck.");
				outputText("\n\nShe has a pair of B-cup breasts, with a single 0.5 inch nipple on each breast.");
				outputText("\n\nShe has one extremely tight pussy placed between her legs, with a 2.0 inch clitoris.");
				outputText("\n\nShe has one asshole placed between her well toned butt-cheeks, right where it belongs.");
				outputText("\n\nShe has one birthing slit placed on the underside tip of her abdomen where her eggs are birthed from.");
			}
			//When Laying Eggs
			else {
				outputText("Phylla is a 5-foot 8-inch tall ant morph with a very small, feminine frame covered in highly defined muscles.  She has four arms, two that attach at her shoulders and two slightly smaller ones that attach at her serratus anterior on her stomach.  Both sets of her arms and human-like legs are covered in plates of semi-reflective brown chitin armor.  ");
				outputText("Her interlocking joints remind you of how insect joints connect to one another. Her abdomen is currently engorged with eggs and is about 7 feet long!  It is covered in large interlocking plates of skin colored exoskeleton and every minute or two you watch Phylla moan as it contracts and relaxes, popping out another egg.  Despite the fact that she has to carry the weight of an abdomen, her hips are very girly.  Her well toned butt is rarely seen as her abdomen covers it most of the time.  She has a sharp, slightly feminine face and large almond shaped emerald-green eyes with no hint of pupils or irises.  Her mouth is surprisingly large considering how thin her lips are.  When she smiles at you, you see a single row of human like teeth with typical human canines.  Her short brown hair is usually matted and covered in dirt, although on rare occasions she styles it so that two long bangs frame her face leaving the rest to flow around her neck.");
				outputText("\n\nShe has a pair of DD-cup breasts, with a single 0.5 inch nipple on each breast.  Bursts of milk occasionally spurt from her swollen areolas in time with her contractions.");
				outputText("\n\nShe has one extremely tight pussy placed between her legs, with a 2.0 inch clitoris.  A small stream of lubricant constantly flows down her legs, her lips slightly parted.");
				outputText("\n\nShe has one asshole placed between her well toned butt-cheeks, right where it belongs.");
				outputText("\n\nShe has one birthing slit placed on the underside tip of her abdomen and with each contraction it spurts out a puddle of birthing lubricant allowing the eggs to slip out of her onto the floor.");
			}
			//go back to phylla menu.
			menu();
			addButton(0, "Next", introductionToPhyllaFollower);
		}

//►[Gems]
//Success/Failure - Based on {Number of Children} + Random Chance of Failure + Cap of 'X' per day.
//(Leads to - Success)
//(Leads to - Failure)
		private function phyllaDigsForGems():void
		{
			clearOutput();
			var kidsMod:int = 0;
			if (flags[kFLAGS.ANT_KIDS] > 10) kidsMod++;
			if (flags[kFLAGS.ANT_KIDS] > 50) kidsMod++;
			if (flags[kFLAGS.ANT_KIDS] > 150) kidsMod++;
			if (flags[kFLAGS.ANT_KIDS] > 300) kidsMod++;
			if (flags[kFLAGS.ANT_KIDS] > 600) kidsMod++;
			if (flags[kFLAGS.ANT_KIDS] > 1000) kidsMod++;
			if (flags[kFLAGS.ANT_KIDS] > 2000) kidsMod++;
			//Success
			if (flags[kFLAGS.PHYLLA_GEMS_HUNTED_TODAY] == 0 && rand(20) + kidsMod > 10) {
				var gems:int = 10 + rand(10) + kidsMod * 2;
				player.gems += gems;
				statScreenRefresh();
				//If Phylla IS NOT Laying Eggs
				if (flags[kFLAGS.PHYLLA_EGG_LAYING] == 0) {
					outputText("You ask Phylla is she's found any gems while digging out her colony.  She nods happily and runs over to a small stone chest and rifles though it.  After a moment, she runs back over to you and holds up all four of her hands.");
					outputText("\n\n\"<i>I hope... this is enough, I mean... they're rare, even down here.</i>\"  You mess up her hair with your hand, laughing. Telling her it's enough, you advise her to keep looking.  She gives you a playful salute as you place the gems into your pouch.");
					outputText("\n\nYou gain " + gems + " gems.");
					outputText("\n\n\"<i>Is there anything else you wanted to do while you're down here?</i>\"  She asks excitedly.");
				}
				//If Phylla IS Laying Eggs
				else {
					outputText("You ask Phylla if she or her children have found any gems while digging.  She nods happily and closes her eyes, tilting her head back slightly.  After a moment one your children scampers in. He runs overs to a small stone chest in the corner of Phylla's room and, after a moment of rifling through it, he finds what he's looking for.  Walking over to you, he presents his findings.  You accept the gems he's retrieved.");
					//if corruption under 50
					if (player.cor < 50) outputText("\n\nYou pat him on the head for a job well done as he walks deeper into the colony leaving you alone with Phylla.");
					//If corruption over 50
					else outputText("\n\nYou count the gems, and give both him and Phylla a look of disappointment.  Sighing heavily, you point decisively at the exit and your child hangs his head in shame as he heads back into the tunnels.  Phylla looks just as depressed and just stares at the ground, unable to really move due to her 'pregnancy.'");
					outputText("\n\n\"<i>Is there anything else you wanted to do while you're down here?</i>\"");
					outputText("\n\nYou gain " + gems + " gems.");
				}
			}
			//Failure
			else {
				outputText("You ask Phylla if she's found any more gems while digging.  \"<i>No, I'm sorry.  I haven't.  Not since the last time you asked.  I'll do better!  I mean, I know you like them.  They're rare... even down here.  I'll do better...</i>\"");
				//If corruption is less  than 50
				if (player.cor < 50) outputText("\n\nYou tell her it's all right and that you'll check back later.");
				else outputText("\n\nYou sigh, slightly disappointed, but give her a weak pat on the head anyway.");
				outputText("\n\n\"<i>Is there anything else you wanted to do while you're down here?</i>\"  She inquires excitedly.");
			}
			flags[kFLAGS.PHYLLA_GEMS_HUNTED_TODAY] = 1;
			doNext(camp.returnToCampUseOneHour);
		}

//[Stones]
		private function phyllaStones():void
		{
			clearOutput();
			var kidsMod2:int = 0;
			if (flags[kFLAGS.ANT_KIDS] > 100) kidsMod2++;
			if (flags[kFLAGS.ANT_KIDS] > 200) kidsMod2++;
			if (flags[kFLAGS.ANT_KIDS] > 300) kidsMod2++;
			if (flags[kFLAGS.ANT_KIDS] > 400) kidsMod2++;
			if (flags[kFLAGS.ANT_KIDS] > 600) kidsMod2++;
			if (flags[kFLAGS.ANT_KIDS] > 800) kidsMod2++;
			if (flags[kFLAGS.ANT_KIDS] > 1000) kidsMod2++;
			if (flags[kFLAGS.ANT_KIDS] > 1250) kidsMod2++;
			if (flags[kFLAGS.ANT_KIDS] > 1500) kidsMod2++;
			if (flags[kFLAGS.ANT_KIDS] > 1750) kidsMod2++;
			if (flags[kFLAGS.ANT_KIDS] > 2000) kidsMod2++;
			if (flags[kFLAGS.ANT_KIDS] > 2500) kidsMod2++;
			if (flags[kFLAGS.ANT_KIDS] > 3000) kidsMod2++;
			if (flags[kFLAGS.ANT_KIDS] > 3500) kidsMod2++;
			if (flags[kFLAGS.ANT_KIDS] > 4000) kidsMod2++;
			var stones:int = 3 + rand(7) + (kidsMod2 * 5);
			flags[kFLAGS.ACHIEVEMENT_PROGRESS_ANTWORKS] += stones;
			if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_ANTWORKS] >= 200) awardAchievement("AntWorks", kACHIEVEMENTS.GENERAL_ANTWORKS);
			if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_ANTWORKS] >= 5000) awardAchievement("Ant-Kids and Phylla", kACHIEVEMENTS.GENERAL_ANT_KIDS_AND_PHYLLA);
			CampStatsAndResources.StonesResc += stones;
			statScreenRefresh();
			//If Phylla IS NOT Laying Eggs
			if (flags[kFLAGS.PHYLLA_EGG_LAYING] == 0) {
				outputText("You ask Phylla is she's got any spare stones from digging, which you can take.  She nods happily and runs over to a small stone pile and rifles though it.  After a moment, she runs back over to you and holds up all four of her hands.");
				outputText("\n\n\"<i>I hope... this is enough, I mean... we're almost always digging, so there will be more of them soon.</i>\"  You mess up her hair with your hand, laughing. Telling her it's enough, you advise her to keep some of them instead throwing outside.  She gives you a playful salute as you taking the stones from her hands.");
				outputText("\n\nYou gain " + stones + " stones.");
				outputText("\n\n\"<i>Is there anything else you wanted to do while you're down here?</i>\"  She asks excitedly.");
			}
			//If Phylla IS Laying Eggs
			else {
				outputText("You ask Phylla if she would allow take you few of the stones that her or her children have gathered while digging.  She nods happily and closes her eyes, tilting her head back slightly.  After a moment one your children scampers in. He runs overs to a stone pile in the corner of Phylla's room and after a moment of gathering, walkesover to you to give you a few stones.  You accept them.");
				//if corruption under 50
				if (player.cor < 50) outputText("\n\nYou pat him on the head for a job well done as he walks deeper into the colony leaving you alone with Phylla.");
				//If corruption over 50
				else outputText("\n\nYou count the stones, and give both him and Phylla a look of disappointment.  Sighing heavily, you point decisively at the exit and your child hangs his head in shame as he heads back into the tunnels.  Phylla looks just as depressed and just stares at the ground, unable to really move due to her 'pregnancy.'");
				outputText("\n\n\"<i>Is there anything else you wanted to do while you're down here?</i>\"");
				outputText("\n\nYou gain " + stones + " stones.");
			}
			if (CampStatsAndResources.StonesResc >= SceneLib.campUpgrades.checkMaterialsCapStones()) {
				CampStatsAndResources.StonesResc = SceneLib.campUpgrades.checkMaterialsCapStones();
				outputText(" <b>Your stone capacity is full.</b>");
			}
			doNext(camp.returnToCampUseOneHour);
		}

//Drider/Bee impregnation scene for Phylla (universal unless otherwise specified, which will include varied intros and stuff.
//Sex > [Egg Phylla]
		private function eggDatBitch():void
		{
			clearOutput();
            phyllaSprite(true);
			//PC is a Female/Herm Drider:
			if (player.canOvipositSpider()) outputText("While Phylla appears to be sexually sated, the heaviness in your spider abdomen begs for release.\n\n");
			//First Time:
			if (flags[kFLAGS.TIMES_EGG_IMPREGNATING_PHYLLA] == 0) {
				outputText("Turning to Phylla, you tell her that you can help to make her wishes of being a brood-mother come true.  She looks at you a bit taken back, as if what you already did wasn't enough already.");
				outputText("\n\nYou go on to explain, telling her that your body is chock-full of eggs that eagerly await a willing host to gestate in.  If she wants to birth as many children as possible, your union can grant her wishes; albeit, she would be birthing both Ant and Spider children.");
			}
			//Subsequent Times:
			else outputText("You give Phylla a knowing look then glance back at your swollen spider abdomen.  Playfully you thrust your ovipositor at her.  Phylla giggles a little, knowing what you want to do to her.");

			//Persuade Phylla - Random chance of failing, affected by INT and whether she's already housing eggs in her vagina.
			//Persuasion failure
			if (rand(20) + 1 + player.inte / 20 < 10) {
				outputText("\n\nPhylla ponders for a moment and shakes her head.  \"<i>I'm sorry, [name], I'm not comfortable with that right now.");
				//If player has already impregnated Phylla with drider eggs and fails the check:
				if (pregnancy.isPregnant) outputText("\n\n\"<i>I just can't hold anything else inside me.  I'm sorry!  Please don't be mad... I mean, I will!  Just a-after... this batch.</i>\"");
				//Else player has not impregnated:
				else outputText("\n\n\"<i>I mean... I just, don't feel comfortable with that right now. Maybe later, though.</i>\"");
				doNext(phyllaSexMenu);
			}
			//Persuasion Success
			else {
                ovipositionScene();
                player.sexReward("Default","Default",true,false);
			    doNext(camp.returnToCampUseOneHour);
			}
		}

        public function ovipositionScene():void {
            outputText("\n\nWith some hesitation and consideration, Phylla ponders the idea of being a brood-mother in more than one way for a bit.  With a shy smile, Phylla reluctantly agrees to house both of your children.");
            //First Time:
            if (flags[kFLAGS.TIMES_EGG_IMPREGNATING_PHYLLA] == 0 || recalling) {
                outputText("\n\n\"<i>H-How will we do this?</i>\" She inquires. \"<i>I mean, I've never seen or heard of anything mating with a Drider before... M-my eggs come out of my abdo~</i>\"");
                outputText("\n\nYou raise a finger to her lips and tell her to lie down against the bed and to relax.  You know exactly where her eggs come out of.  The image of Phylla dropping eggs out of both her vagina and her abdomen makes you want this all the more.  Though the link you send this image to her, and feel her well up with maternal pride.  In uncertain anticipation, Phylla heeds your directions and lies down, her back on the bed with her abdomen curled in the air.");
            }
            //Subsequent Times:
            else {
                outputText("\n\nPhylla quickly gets into position, although at first she looks uncertain of if what's she done is correct.");
                //If PC corruption over 75:
                if (player.cor < 75) outputText("  Little does poor Phylla know, you're going to just use her as a baby maker to ease the tension of your own sacks.");
            }
            outputText("\n\nIn uncertain anticipation, Phylla heeds your directions and lies down, her back on the bed with her abdomen in the air.  You help pose her in the right position; angling her pussy towards you as you clamber along the bed. Finally coming to rest on top of Phylla, you take her soft face in your hands and kiss her, firmly holding her against you as you work your ovipositor against her vagina.");

            outputText("\n\nHer tongue probes your mouth seeking your tongue as Phylla compresses her arms around you. Knowing she's ready, you work your way into her and begin to release your lubricating fluids.  Phylla moans into your mouth as the secretions tickle her pleasure centers.  Through the link, you tell her to get ready; the ovipositor bottoming out deep in her womb, feeling the first of many eggs working their way down your ovipositor and into her pussy.");
            outputText("\n\nShe squints and braces for the inevitable egg forcing its way into her.  She breaks your long kiss; gasping as the oval mass finally makes contact and works its way into her.  You can feel the egg as it makes it way into Phylla, stretching her cunt out to accommodate future deposits.  As the frontrunner hits her cervix and manages it to make its way inside, she manages a small moan of discomfort.");
            outputText("\n\n\"<i>UGH!  Its hurts... a little~ feels so strange... I-mea~ good!  Give me more!  Please!</i>\" She cries out, her maternal instincts kicking in as her desires to bear many young overtake her.");
            outputText("\n\nYou comfort her while telling her that you have a few more on the way; something that causes Phylla's eyes to roll up in her head.  You feel the thoughts of being filled with so much new life that she will eventually birth to overwhelm her senses.");
            outputText("\n\nEgg after egg slides into Phylla, causing her to moan louder and louder with each egg. Her stomach quickly starts to bulge bigger and bigger with your brood as you stuff more into her.");

            //If PC corruption over 75:
            if (player.cor >= 75) outputText("\n\nYou can feel her ask you to stop though the link as her body starts to pull away from you, stating that she's nice and full and that any more could hurt her. Not yet! You know she can fit at LEAST three or four more! You KNOW she can hold them safely, she just needs to \"<i>man up</i>\". Using your numerous legs and arms you pin Phylla to the ground. Completely stopping her pulling away. Phylla screams in pleasure or pain, you can't really tell but you continue to deposit your eggs into her.");
            outputText("\n\nAt last, the final egg laid inside of Phylla, you retract your ovipositor from her love hole; it'll recover in time. Phylla rubs her belly and gleams with delight, filled with her lover's future children that will help the colony to grow strong.");
            //PC Drider eggs will take 8 days regardless of where she houses them to hatch. (3
            //through 8 children per pregnancy)
			if (!recalling) {
				if (!pregnancy.isPregnant) pregnancy.knockUpForce(PregnancyStore.PREGNANCY_DRIDER_EGGS, 8 * 24); //Supposed to be eight days, not eight hours
				flags[kFLAGS.TIMES_EGG_IMPREGNATING_PHYLLA]++;
				player.dumpEggs();
			}
        }
	}
}
