package classes.Scenes.Dungeons.DeepCave
{
import classes.*;
import classes.BodyParts.Arms;
import classes.BodyParts.Ears;
import classes.BodyParts.Eyes;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.BodyParts.Tongue;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kFLAGS;
import classes.IMutations.IMutationsLib;
import classes.Scenes.SceneLib;
import classes.display.SpriteDb;
import classes.internals.SaveableState;

public class ValaScene extends BaseContent implements SaveableState
	{
		// VALA_CUMBATH_TIMES:int = 433;
		// TIMES_VALA_CONSENSUAL_BIG:int = 767;
		// TIMES_VAPULA_AND_GIANT_VALA:int = 768;

		public static var ValaFairyQueenQuest:int;
		public static const QUEST_STAGE_NOT_STARTED:int = 0;
		public static const QUEST_STAGE_STARTED:int = 1;
		public static const QUEST_STAGE_ITEM_GATHERED:int = 2;
		public static const QUEST_STAGE_ITEM_TURNEDIN:int = 3;
		//public static const QUEST_STAGE_ITEM_SCEPTER_REPAIRED:int = 4; // unused
		public static const QUEST_STAGE_PCDECLINED:int = 5;
		public static const QUEST_STAGE_PCDACCEPTED:int = 6;

		public function stateObjectName():String {
			return "ValaScene";
		}

		public function resetState():void {
			ValaFairyQueenQuest = QUEST_STAGE_NOT_STARTED;
		}

		public function saveToObject():Object {
			return {
				"stage": ValaFairyQueenQuest
			};
		}

		public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
			if (o) {
				ValaFairyQueenQuest = o["stage"];
			} else {
				// loading from old save
				resetState();
			}
		}

		public function ValaScene()
		{
			Saves.registerSaveableState(this);
		}

		public function freeValazLooseCoochie():void {
            spriteSelect(SpriteDb.s_valaSlave);
			clearOutput();
			if (!recalling) outputText("<b>New scene is unlocked in 'Recall' menu!</b>\n\n");
			outputText("You search the room for a way to free the fairy from her shackles and find an ugly, iron key that looks like a promising candidate. Opening the rusted metal with a teeth-clenching screech, the girl slumps to the ground in an ungainly heap. The fall seems to have roused her, at least, because she blinks, slowly, several times before lifting her head to stare blankly at you. You try to explain that she's free, but it's clear that thoughts are travelling through a pretty thick haze of abuse, so you take a moment to let her gather herself. When she's managed to assemble what wits are left to her, she slowly curls her mouth into a hopeful smile. \"<i>How can Bitch please Master?</i>\" she asks in an innocent voice tainted by husky desire.\n\n");
			outputText("You bend down to comfort the girl and offer her a shoulder to lean on as you help her to her feet. As you expected, the weight of her milky tits nearly surpasses the rest of her body. She clings to you happily, stroking and rubbing her bare skin against your body. She is adamantly ignoring your efforts to dissuade her amorous advances, merely cooing \"<i>master</i>\" and \"<i>pleasure</i>\" over and over again.\n\n");
			menu();
			addButtonIfTrue(0, "Sex", ValaGetsSexed, "Not genderless!", player.gender > 0);
			addButton(1, "Reject", rejectFuckingVala).hint(!recalling ? "Are you sure?" : "Leads to after-fight scene.");
		}


		//[Sex]
		public function ValaGetsSexed():void {
			if (!recalling) dynStats("lus", 33, "scale", false);
            clearOutput();
            sceneHunter.selectGender(curry(sceneHunter.callFitNofit, dickF, 60), vagF);

            //===============================================================
			function dickF(x:int):void {
				outputText("The fairy's grinding and the sweet scent leaking out of her honey pot is getting under your skin, irritating an itch that's been building for a while now. Surely it wouldn't hurt to throw the mind-broken girl a pity fuck? It's not like she's one of the demons or anything. You push the girl back, gently and nod your head, stripping your [armor] piece by piece, teasing the fairy with your slowness. As you disrobe, you glance back at the spot she'd been chained up and see the placard on the wall again. \"<i>Vala?</i>\" you ask. \"<i>Is that your name?</i>\" She stares blankly, unresponsive.\n\n");

				outputText("She points at herself. \"<i>Bitch,</i>\" she explains. You grab her hands and stare into her pink eyes, holding her in your gaze until the faintest sparkle of light returns to their empty depths.\n\n");

				outputText("\"<i>Your name is Vala,</i>\" you command, softly. She flinches. \"<i>Say it, or I won't fuck you.</i>\" She squirms, eyes clenched, rubbing her knees together as the heat in her groin battles the conditioned rape the imps used to crush her identity. Just as you knew it would, lust wins out.\n\n");

				outputText("\"<i>It is... we are... Vala,</i>\" she glances around, looking for imminent punishment. When none is forthcoming, she curls her lips into a wanton smile. \"<i>Now fuck Vala!</i>\" You chuckle and show your satisfaction at her small rebellion by grabbing one of her supple tits and leaning down to flick your tongue against her milk-bloated nipples. She arches her back under your touch and clenches her muscles, but slowly relaxes when you don't bite or tear at her pale skin. Her smile becomes a little more natural and her hands find your genitals, eager fingers sliding across your sensitive [skin.type]. Her hand grabs your " + cockDescript(x) + ", thumb and pinkie forming a tight circle at your base while her other fingers stroke up and down your shaft. The fairy's touch is surprisingly light for the rough treatment she's endured, and you're quickly brought to hardness under her caresses.\n\n");

				outputText("Whatever small parts of her mind may be returning, she clearly hasn't conquered her sex-madness, because she simply cannot restrain herself any longer. Fluttering her wings rapidly, the girl lifts out of your embrace and rises above you, lining her sex up with yours, thick beads of wetness trickling down from her gaping pussy. With a mad giggle, she stops flapping and drops down, impaling herself on your length.");
			    doNext(dickF_2, x);
			}
			function vagF():void {
				outputText("The fairy's incessant groping is maddening and you decide it'd just be easier to get it over with than have her hanging from your tits for the rest of the day. You select what looks like a reasonably clean spot in the room and carry the girl with you. Sitting down, you let her sit in your lap as you try to pull the clumped hair from her face. Spitting on your hand, you wipe some of the grease, dirt, and dried cum from her face, while she coos at your touch. Under all the grime, she's actually quite pretty; an impossibly frail yet timeless sort of beauty that reminds you of snowflakes back home. You smile, despite yourself, and give the girl a little kiss of affection, stroking her tattooed shoulders gently. She returns your kiss with a famished sort of desperation, trying to swallow your tongue in gulping slurps that force you to pull back and wipe the spittle from your face. She's just not going to be happy until she gets something inside her.\n\n");

				outputText("You ask her if she can fly, and she nods, blankly. By way of demonstration, she flutters her dragonfly wings and lifts a couple feet into the air, heavy chest causing her to sway precariously. You stroke your hands up her legs, pulling them around your shoulders and drawing the girl's pussy toward your head. The fairy's labia is almost artistic- hairless folds like rose petals, her leaking excitement like morning dew. You lean in and lick gently around her slit, the tip of your tongue tracing teasing circles around her small, overstimulated clit. She squeals in a pitch that you thought only dogs could hear and her legs clench around your head. Sliding your tongue into her gash, you are a little surprised that the well-used fairy still tastes sweet. Even mind-breaking imp rape couldn't fully pollute the fey girl's juicy snatch.");
			    doNext(vagF_2);
			}
            //PART 2===============================================================
			function dickF_2(x:int):void {
			    clearOutput();
                if(player.cockArea(x) < 60) {
					outputText("Vala's pussy surrounds you like a quivering mouth, but she's simply too used for you to get much friction. The fairy barely even notices, grinding her front against you, tits rubbing your chest like a liquid massage, cream leaking down your torso. She hooks her legs around your [butt] and, using her wings, lifts up before dropping down again. Although she's too loose for your preference, the girl seems to be getting off just fine by using your " + cockDescript(x) + " as a fucking post. You spot the wooden rack to one side of the room and the variety of carved dildos worked into the pegging ladder. A wicked thought crosses your mind, but lacking any other options, you guess you could at least give it a try. Pulling the fairy over to the lacquered bench, you choose one that seems like a likely fit and position your " + player.assholeOrPussy() + " over the carved cock. When the fairy drops herself onto you next, she forces you down with her, penetrating you on the peg. It proves to be a bit thicker than you realized, however, and you gasp at the weight that settles into your gut. You try to get up and select a smaller peg, but the fairy's jack-hammering flight keeps you rooted on the post. Your " + cockDescript(x) + " swells from the stimulation your ");
					if(player.hasVagina()) outputText("cunt");
					else outputText("prostate");
					outputText(" is receiving and the fairy's frenzied pace becomes your own. You lift off as quickly as possible just so that her descent will shove the full length of the polished wood back inside your clenching ");
					if(player.hasVagina()) outputText("slit.\n\n");
					else outputText("rectum.\n\n");

					outputText("You feel your orgasm building and you manage to lift off of the peg entirely, quickly sliding down to the next biggest one, before the fairy begins her decent. This time, she uses her wings to provide additional force and drives you down, impaling you on the foot-long dildo and your cock explodes. The fairy bucks wildly against you, her slavering pussy clenching hard enough to actually squeeze you for once, eagerly sucking up every drop of your seed, her fingers wildly rubbing her clit as she jills herself off in desperate orgasm.\n\n");

					outputText("When a hot bath of girl cum sprays from her loins, soaking your thighs, she finally collapses against you, hugging your waist and weakly flapping her wings in the afterglow. You gingerly pull yourself off of the pegging board and carry the exhausted slave girl in your arms. Lifting her chin up to look into her face, you sadly find that her vacant expression is still there. Her road to recovery is more than one fuck, it seems. Well, at least you were able to show her a little kindness, you sigh. You set the girl in what looks like the least foul corner of the room and tell her you'll return for her after you've finished off the demons, wondering if she'll even remember you five minutes from now.");
				}
				else {
					outputText("Vala slides onto your " + cockDescript(x) + " with gleeful squeals as you part her rose-petal labia and slide into her well-worn depths. If the marks on her back are any indication, her ability to accommodate your girth is a result of endless sessions with the captors, probably two or more to a hole. However, she ended up so stretched, it works for you because her slavering cunt sucks up your titanic dick into her well-lubricated uterus. Her abdomen distorts at your insertion, but instead of pain or fear, her expression is utter bliss, her pink eyes fluttering as she wordlessly mutters sweet nothings into your ");
					if(player.biggestTitSize() < 1) outputText("chest");
					else outputText("breasts");
					outputText(". She's tight and getting tighter as you pump slowly, working your long inches into the fairy's needy hole. Her body is hot around you and her milky tits drool with each thrust, their nectar fragrant like rose water. At this rate, the condom-tight girl is going to make you blow your load before you get a chance to see what a fairy orgasm looks like.\n\n");

					outputText("You spot an unsecured set of chained manacles on the floor and an idea strikes you. Vala still sliding along your shaft, you bend down and grab the fetters, snapping one around the girl's neck like a collar. With a shudder at the cold iron, you lift the fairy up and lock the other end of the shackles around the root of your " + cockDescript(x) + ", steel snapping around your base tightly. The makeshift cock-ring works perfectly as your hips quiver, your body trying to orgasm but denied release by the metal loop. The fairy, meanwhile, thrashes atop your groin, the chain of her collar swinging between her tits, buffeting them with enough force to spray small white streams as she rides you. Her purple hair glimmers pink in the dull light of the dungeon as it bounces right along with her rocking hips. Even the diminished pulses of sunlight streaming from her stained and tattooed skin seem brighter as she is filled labia to cervix by your straining fuckpole.\n\n");

					outputText("She moans in a series of small, cute gasps and her pussy clenches your " + cockDescript(x) + " as tightly as the makeshift cock-ring. You savor the sweet shivers that run up her spritely body, fingers clenching around your arms and legs wrapping about your " + hipDescript() + " to slam deeper, even taking the chained shackle at your base into her gushing slit. It feels like a flood is released from the fairy's gaping box, warm fluid splashing around your bulging length and raining down to leave a thin, clear puddle under you. You bite your lip and slide your fingers into her vice-like pussy, trying to unhook the shackle around your cock. The added insertion gives the girl enough to climax again, her body shaking violently against yours, squirting her hot girl cum over your hand, making it difficult to spring the catch. The pressure in your loins is getting painful now, and you lean against a wall, using both hands to try to unclap the fetters around your " + cockDescript(x) + ". Between her wings and the chain, she manages to stay firmly locked onto your root, grinding orgasmically as you push more fingers past her pulsing vulva and fumble at the cock-ring.\n\n");

					outputText("When she cums a third time, her rose-smelling lubricant utterly soaks your hands and you nearly wail with frustration. Clenching your teeth, you grunt and grab the fairy's cock-widened hips. You jam into her as hard and fast as you can, trying to fuck through the pressure and break your shackles with the force of your cum. The fairy is lost in her lust, her hands rubbing her clit while the other reaches around your back. She slides a finger upward ");
					if(player.hasVagina()) outputText("nuzzling your joy buzzer");
					else outputText("tickling your prostate");
					outputText(" and you thrust more forcefully than she was braced for, finally lifting the fey cocksleeve off your root. Without wasting a moment, you pull the locking bar out of the shackle and finally allow your orgasm to spew into her waiting womb. You slip in the fairy's cum puddle and fall on your [butt] as your " + cockDescript(x) + " dumps its long-delayed loads inside the distended girl. The feeling of cum filling her pussy drives her to a fourth orgasm, her toes curling and wings flapping wildly. She's so tightly clenched around you that there's nowhere for your cum to run out, so her womb bloats to a well-feasted fatness and she loses the strength to keep writhing in your lap, simply collapsing into your ");
					if(player.biggestTitSize() < 1) outputText("chest");
					else outputText("breasts");
					outputText(".\n\n");

					outputText("She's unconscious by the time you're finished seeding the fairy, the girl's chest barely rising and falling under her disproportionately huge breasts and massively inflated womb. Even better than a goblin, you reflect, marveling at the fairy's ability to take your impossibly huge cock and her resilience, despite the rapid sequence of orgasms. Though, you suppose, once you've already been fucked mindless, there's little left to break. You resolve to check back on her after you've dealt with the demons.");
				}
                if (!recalling) {
                    player.sexReward("vaginalFluids", "Dick");
                    flags[kFLAGS.TIMES_FUCKED_VALA_IN_DUNGEON]++;
                    doNext(playerMenu);
                }
                else doNext(recallWakeUp);

            }
            function vagF_2():void {
			    clearOutput();
				outputText("You close your eyes and run your tongue into her groin with teasing flicks and probing touches, exploring her nethers and lapping up the constant flow of fae cum that dribbles from her perpetually wet body. She shifts in the air, but keeps your head bouncing between her thighs and you can't tell what she's doing. When a hot, humid panting puffs against your " + vaginaDescript(0) + ", you realize she must've done a 180 in the air, wings keeping her in a vertical 69. She descends on your pussy with relish, tasting something that isn't demon cum for the first time in too long. Her needy tongue is as delicately thin as the rest of her body, but it is LONG. She threads it into your depths and you buck your hips as it just keeps going deeper and deeper. You moan into her abdomen and flatten your own tongue to bring as much roughness against her twitching walls as you can, trying to get the little minx off before she sucks your orgasm from you.\n\n");

				outputText("It's a hopeless race, however, as she quickly zeros in on your g-spot, curling her tongue to coil thickly inside of you. You grab her head by its purple hair and crush it into your crotch, crushing her nose on your " + clitDescript() + ", momentarily forgetting about the fairy's pussy as she tongue-rapes yours. When you cum, your body tenses and you hold your breath as your " + hipDescript() + " threaten to draw the small girl's whole head into your " + vaginaDescript(0) + ". You hear a slurping and realize she's drinking your girl cum. The thought is enough to remind you about the fairy slit at eye-level just as she climaxes from the taste of your body. She squirts wildly into your face, small jets of hot, sticky liquid spraying into your mouth, over your cheeks, and into your eyes.\n\n");

				outputText("You blink, and give the little brat a bump on the back of the head for her sneaky facial. She flutters right-side up again and when you see her face, your heart leaps in your chest. Your orgasm has washed her visage clean and you realize she's breathtaking. The soft curves of her heart-shaped face, the timeless alabaster of her flawless skin, and most surprisingly, the glimmers in her almond-shaped, pink eyes. She kisses you, softly this time, almost affectionately. Perhaps your exchange unlocked the memory of sweeter days with her fairy sisters? Your heart sinks when you realize she'll never be able to recapture those lost days in her state and you resolve to make sure she finds her way out of this place once you've defeated its dark master. You return her kiss and redress as she finally gets some long-delayed, restful sleep.");

                if (!recalling) {
                    player.sexReward("vaginalFluids", "Lips");
                    player.sexReward("saliva", "Vaginal");
                    flags[kFLAGS.TIMES_FUCKED_VALA_IN_DUNGEON]++;
                    doNext(playerMenu);
                }
                else doNext(recallWakeUp);
			}
		}

		public function leftValaAlone():void {
			spriteSelect(SpriteDb.s_valaSlave);
			clearOutput();
			if (!recalling) outputText("<b>New scene is unlocked in 'Recall' menu!</b>\n\n");
			//first post meeting
			if(flags[kFLAGS.INVESTIGATED_VALA_AFTER_ZETAZ_DEFEATED] == 0 || flags[kFLAGS.TIME_SINCE_VALA_ATTEMPTED_RAPE_PC] == 0) {
				outputText("Having dispatched the foul master of this cavern, you return to the broken fairy. She is lying as you left her, apparently still as oblivious to the world beyond her pussy and asshole as before. You try to rouse the girl from her near comatose state, but she responds only in terse, disjointed phrases. When you urge her to leave the dungeon, she seems confused and refuses. When you offer to shelter her at your camp, she grows panicked, apparently so inured to her captivity that the thought of freedom frightens her into paralysis. Nothing you say seems to reach her dulled brain and you realize that even if she were willing to come with you, having a broken, drugged, branded fairy at your camp might alienate your friends or send the wrong message to potential allies. There's nothing for it- you're going to have to leave her here.\n\n");

				outputText("At the very least, you make sure she's provided for. You clear the pollution clogging the natural water source that pours in from one of the ceiling hoses and you gather what untainted food you can. You take a rag to the placard over her chains and clear the imp graffiti from the bronze plate, revealing the name under the muck. As you suspected, the broken fairy was once called 'Vala' and you make a note of it. Maybe you'll visit her again, to give the poor girl some of the pleasure she's grown addicted to.");
				flags[kFLAGS.INVESTIGATED_VALA_AFTER_ZETAZ_DEFEATED]++;
				flags[kFLAGS.TIME_SINCE_VALA_ATTEMPTED_RAPE_PC] = 6;
			}
			//Anytime within 6 hours of waking/raping/meeting her
			else if(flags[kFLAGS.TIME_SINCE_VALA_ATTEMPTED_RAPE_PC] > 0) {
				outputText("Vala is still here, the thought to escape apparently never even crossing her vacant mind. The pale-skinned, whip-thin fairy looks slightly healthier than before, now that you've cleared out the rapists who used her for an hourly cum-dump. Her purple hair even sparkles with pink light regularly. Her pink eyes remain empty, however, her pupils no more than pinpoints in lusty oceans. She's still senseless from your last encounter, her body smeared with your juices and her sex pulsing, bloated and engorged from the pounding you gave her. Trying to use her again so soon wouldn't be terribly pleasant for you, and besides, you're better than a pack of filthy imps, right? Better to give her a chance to recover.");
			}
			//Anytime meeting her AFTER 6 hours.
			else if(flags[kFLAGS.TIME_SINCE_VALA_ATTEMPTED_RAPE_PC] == 0) {
				outputText("Vala is still here, the thought to escape apparently never even crossing her vacant mind. The pale-skinned, whip-thin fairy looks slightly healthier than before, now that you've cleared out the rapists who used her for an hourly cum-dump. Her purple hair even sparkles with pink light regularly. Her pink eyes remain empty, however, her pupils no more than pinpoints in lusty oceans. Although there's no one to lock her manacles, she seems to prefer sleeping in them, and has propped herself up, shackles about her wrists, hanging limply in the air, unaware of your presence. It's good to see that she's doing well, but you know any attempt at conversation would be about as productive as talking to a fairy-shaped onahole. Her apple-bottomed ass sways with each breath, pussy dripping lube even in her sleep.");
			}
			outputText("\n\nWhat would you like to do to her?");
            menu();
			addButtonIfTrue(0, "Use", useVala, "Not genderless!", player.gender > 0, "Fuck the poor fairy while she's asleep.");
			addButtonIfTrue(1, "Wake", wakeValaUpBeforeYouGoGo, "Not genderless!", player.gender > 0, "Wake the girl up to have some fun.");
            if (SceneLib.shouldraFollower.followerShouldra() && !player.hasStatusEffect(StatusEffects.ShouldraOff))
                addButtonIfTrue(2, "Shouldra?", SceneLib.shouldraFollower.shouldraMeetsCorruptVala, "Not horny enough.",
                    player.lust >= 33, "Ask Shouldra if she has any ideas. Are you sure you want to wake <i>her</i> up too?");
            else addButtonDisabled(2, "???", "Req. to have a certain ghostly follower with you.");
            //heal
            var honey:Boolean = player.hasItem(consumables.PURHONY, 1) || recalling;
            var pearl:Boolean = player.hasItem(consumables.P_PEARL, 1) || recalling;
            if (!honey && !pearl)
                outputText("If you had the right materials, you might be able to mix something to heal the damage her captors have done to the fairy's mind.\n\n");
            if (honey)
                outputText("Pure honey is known for its cleansing properties. Why not try it on the faerie?\n\n");
            if (flags[kFLAGS.FACTORY_SHUTDOWN] == 1 && pearl)
                outputText("Nothing can reverse corruption effects as good as the pearl given by Marae itself. But... is it <i>really</i> the only way? You <b><i>might</i></b> find a better use for it.\n\n");
			if (recalling)
				outputText("<b>Recall: items won't be consumed.</b>");
			addButtonIfTrue(3, "Use Honey", healValaHoney, "Requires a bottle of Pure Honey.", honey);
            if (flags[kFLAGS.FACTORY_SHUTDOWN] == 1)
			    addButtonIfTrue(4, "Use Pearl", healValaPearl, "Requires the Pure Pearl.", pearl);
            //Leave
            addButton(14, "Leave", playerMenu);
		}

        public function healValaHoney():void {
			clearOutput();
			if (!recalling) {
				player.consumeItem(consumables.PURHONY, 1);
				flags[kFLAGS.VALA_HEALED_HONEY] = 1;
			}
            outputText("You're not sure if Pure Honey will do the trick, but it seems like the most likely candidate. You set the broken girl down and step over to the alchemy table. She clings onto your " + (player.isNaga() ? "tail" : player.leg()) + " as you walk, and you end up dragging her across the dungeon floor, leaving a trail of her cum behind you. Before things can get too out of hand with the needy girl, you pull out the vial of Pure Honey and arrange the equipment in front of you. Using the cleanest of the pipettes, you take a small portion of the honey and mix it with what you hope to be water, diluting the rich mixture to a less viscous state. Working quickly, you manage to produce a draught that the weak girl can tolerate. By now, she's managed to work her way to a sitting position and is grinding her dripping sex against your [foot]. You lean down and hold her nose to make her open her mouth. She gleefully opens wide, tongue thrashing about in anticipation. You pour the sweet-smelling concoction down her anxious throat and begin to re-cork the rest of your honey.\n\n");

            outputText("The effects of your cure are more violent than you expected. The fairy thrashes wildly, causing you to drop your bottle of Pure Honey, sending it spilling over the table, shattering the delicate equipment and ruining the unlabeled concoctions within. Moving to keep the girl from hurting herself in her seizure, you hold her head against your chest and wait out the wild bucking. Gradually, her motions slow and her breath calms to a more normal pace. When she looks back up at you, her eyes are clear at last, the pollution of lust burned away by the honey's restorative properties. She gives you a genuine smile and speaks with a voice like the rushing of wind over reeds. \"<i>Thank you. I cannot express my gratitude for what you've done. The fate you've saved me from was worse than any death these wretched creatures could have subjected me to.</i>\"\n\n");

            outputText("She tries to stand and falls back on her ass, the unbalancing weight of her corrupted breasts still surprising. She seems surprised at first, but her laughter is rich and eases your heart even just to hear it. \"<i>Oh my, I have changed a bit, haven't I? Still, any deformity is worth restoring my mind. Please, let me introduce myself.</i>\" She flaps her thin, fey wings rapidly and their lift is enough to allow her to stand. \"<i>I am Vala, and I used to be a fairy, like my sisters. I was captured by the demons of this place and used to amuse them between sexual releases. The lord of this place, in his dark designs, thought it would be better to use me for sexual release instead. They fed me such terrible drugs, to make me grow to a more pleasing size. They bound me in this room with these,</i>\" she cups her absurdly large tits, \"<i>weights. When my wings grew strong enough to carry my inflated body, they switched to chains instead. They used me terribly and, in time, I forgot who I was. Pleasure was all that mattered. But you have saved me, and now it is all but a bad dream.</i>\" She flutters up to kiss your forehead. \"<i>I must taste the sweet open air and return to my sisters, but please try to find me once you are done here. I wish to repay your kindness.</i>\"\n\n");

			outputText("Leaving the way you came, Vala makes her exodus from the abyssal cavern. Despite her savagely warped body, you do not doubt that her renewed vigor for life will let her achieve some measure of happiness again. You feel like you've managed to do a truly selfless thing in this den of iniquity. Defeating monsters is satisfying, but it is the lives you save that really make you feel like a hero. You sigh contentedly and wonder where she'll end up, now that she's been given her life back.");
			if (!recalling) {
				flags[kFLAGS.FREED_VALA] = 1;
				doNext(playerMenu);
			}
			else doNext(recallWakeUp);
        }

        public function healValaPearl():void {
            clearOutput();
			if (!recalling) player.consumeItem(consumables.P_PEARL,1);
            outputText("A soft, warm breeze rustles your " + hairDescript() + " and for a moment the foul stench of the dungeon vanishes, setting your mind at ease and draining the tension that has been building in your gut. In a moment of clarity, you remember the beautiful Pure Pearl that Marae granted you as a reward for shutting down the demons' factory. It seems only right to use the goddess' gift to rescue one of her wayward children. Perhaps she gave it to you for this very reason? The oblivious girl has managed to work her way to a sitting position and is grinding her dripping sex against your [foot]. You lean down and gently lift her chin up, bringing her empty, pink eyes to stare into yours. Mistaking the gentle motion for a command, she gleefully opens wide, tongue thrashing about in anticipation. You place the pink pearl at the fairy's lips and she wraps her mouth around the pale jewel, trying obediently to swallow it. However, the little fairy's mouth is far smaller than you would've thought and the pearl seems stuck just behind her teeth, like a pink ball-gag. She coos a muffled moan and begins to masturbate without breaking eye contact with you.\n\n");

            outputText("Not exactly what you had in mind. It looks like you're going to have to be a bit more forceful.  You stoop down and take the fairy's head in your arms. Placing your fingers on the drool-soaked orb wrenching her mouth open, you begin to shove the pure pearl into her throat. With ecstatic joy, she swallows as hard as she can, trying to accommodate this new, exciting insertion. The gem squeezes past her tonsils and is forced into her esophagus with an audible 'pop!' the mass of the pearl leaving an orb-shaped bulge in her throat. Her masturbation becomes frenzied as she begins choking on the gem and you hurry to stroke the girl's neck, coaxing the pearl down, out of her windpipe. Finally, it drops into her stomach and the change is immediate. Just as she climaxes, her empty pink eyes focus and sharpen, the lusty haze fading as Marae's gift burns away the pollution of the imps' drugs and rape. She gives you a genuine smile and speaks with a voice like the rushing of wind over reeds. \"<i>Thank you. I cannot express my gratitude for what you've done. You are a godsend, hero. I will never forget what you've done for me.</i>\"\n\n");

            outputText("She tries to stand and falls back on her ass, the unbalancing weight of her corrupted breasts more than her atrophied legs can handle. She seems surprised at first, but her laughter is rich and hearing it eases your heart. \"<i>Oh my, I have changed a bit, haven't I? Still, any deformation is worth restoring my mind. Please, let me introduce myself.</i>\" She flaps her thin, fey wings rapidly and their lift is enough to allow her to stand. \"<i>I am Vala, and I used to be a fairy, like my sisters. I was captured by the demons of this place and used to amuse them between rutting sessions. The leader of them, however, thought it would be better to use me for sexual release instead. They fed me such terrible drugs, to make me grow and to bind me with these,</i>\" she cups her absurdly large tits, \"<i>weights. They used me terribly and, in time, I forgot who I was. Pleasure was all that mattered. But you have saved me, and now it is all but a bad dream.</i>\" She flutters up to kiss your forehead.\n\n");

            outputText("Leaving the way you came, Vala makes her exodus from the abyssal cavern. Despite her savagely warped body, you do not doubt that her renewed vigor for life will let her achieve some measure of happiness again. You feel like you've managed to do a truly selfless thing in this den of iniquity. Defeating monsters is satisfying, but it's the lives you save that really make you feel like a hero. You sigh contentedly and wonder where she'll end up, now that she's been given her life back.");
            //(Vala unlocked in The Wet Bitch)[End Encounter]
			if (!recalling) {
				flags[kFLAGS.FREED_VALA] = 1;
				doNext(playerMenu);
			}
			else doNext(recallWakeUp);
        }

		//Vala
		public function useVala():void {
			clearOutput();
			if (!recalling) dynStats("lus", 60, "scale", false);
            outputText("You shrug. The girl is so hopelessly lost in pleasure that you doubt she could ever return to the real world anyway. There doesn't seem to be any more demons around, and it'd be a good idea to relieve the tension that's been building in your gut since you stepped into this wretched place. Besides, you chuckle as you strip off your [armor], you've always wondered what it'd be like to take a fairy.\n\n");
			sceneHunter.selectGender(dickF, vagF, null, hermF);
			//==================================================
			function dickF():void {
				outputText("Since the demons were so kind as to string her up for you, it's easy enough to take her rape-broadened hips into your hands and slide your [cock] up her thin thighs, toward her drooling pussy. The fairy girl has been well-used, and recently, you realize, as you guide your cockhead over her pink snatch. Used quite a bit, you realize as you try to slide in and find virtually no resistance. Apparently, the imps couldn't decide who'd go first and settled on penetrating her by two or three dicks at a time. That, or they've got a minotaur-sized imp lurking in the cave somewhere. Either way, the ruined vagina gapes far too widely for enough friction to get you off. It looks like her asshole is in no better shape. Well, you are nothing if not resourceful.\n\n");
				outputText("You step away from the mind-fucked fairy and examine the potions on the alchemy table. Sifting through the vile concoctions, you find what you were looking for- minotaur blood. Snatching the whole bottle, you step back up to the waiting fairy and wrap a fist in her pink-tinged violet hair, jerking her head backwards. She gasps in ecstatic pleasure, the pain bringing her back in a flash. Vala's eyes lock onto yours and hot desire curls her face into a wanton, panting grimace. You grab her face and put pressure on her cheeks, forcing her jaw open. The crimson fluid trickles down her throat and her tongue licks her lips with satisfaction, savoring your rough treatment. You cast the empty bottle aside and thrust your cock back into her slit as the walls tighten around you. You begin to rock back and forth, enjoying the feeling of the velvet vice, even groaning as her gash becomes tight enough to begin hurting your [cock].");
				doNext(dickF_2);
			}
			function vagF():void {
				outputText("The fairy's rose-scented honeypot glistens with thick beads of clear liquid that well and dribble down her inner thighs, but you're a little too careful to eat out every wet and waiting fairy girl you happen to find in demonic dungeons, so you elect for a safer, less potentially drug-filled route for your carnal satisfaction. Glancing around the room, your eyes settle on the long, wooden pegging table in one corner of the room. You snatch a large, loose stone from the ground as you head over to it and fold your arms under your [allbreasts], shopping amongst the lacquered, intensely detailed wooden cocks set into the device. This one is far too small, that one is the wrong shape, one by one, you weed them out until you settle on a huge, minotaur-shaped dildo, over a foot and a half long and nearly six inches wide at the flared head. Grinning, you take the stone and carefully tap the bottom of the board until the peg starts wobbling loose. Using both hands, you yank the fire-hardened wooden dildo from its socket and hold it triumphantly over your head. You swing it in the air, experimentally, but decide that beating demons unconscious with a minotaur's dick would just be silly.\n\n");
				outputText("Heading back to the chained fairy, you rub the head of the wooden dildo between her petal-shaped labia, turning the cock as you do so, to lubricate the whole 18\" of the monstrous thing. You stroke her juices into the glistening finish until it's difficult to keep your grip. Placing the flared head at the entrance to her rape-worn love box, you squeeze your own legs together in anticipation. With exquisite slowness, you press the dildo against her pussy and apply pressure until it begins to part her lips, pushing her slit wider and wider. The fairy finally seems to come to, under your teasing penetration and she coos at the stimulation, without questioning the source. She wiggles her plump butt and shakes her heaving chest, sending her absurdly large breasts swinging in the air, milk-heavy flesh slapping against each other. You encounter resistance just past her lower lips and you roll the flare in circles, cold wood rubbing hot skin and soaking up the squirting girl's natural lubrication. Then, putting your hand on the far end of the dildo, you push as hard as you can, jamming it into the fairy's cunt.");
				doNext(vagF_2);
			}
			function hermF():void {
				outputText("The fairy's rose-scented honeypot glistens with thick beads of clear liquid that well and dribble down her inner thighs, but you're too clever to just eat out every wet and waiting fairy girl you happen to find in demonic dungeons, so you elect for a safer, less potentially drug-filled route for your carnal satisfaction. Glancing around the room, your eyes settle on the long, wooden pegging table in one corner of the room. You snatch a large, loose stone from the ground as you head over to it and fold your arms under your [allbreasts] as you shop amongst the lacquered, intensely detailed wooden cocks set into the device. This one is far too small, that one is the wrong shape, one by one, you weed them out until you settle on a huge, minotaur-shaped dildo, over a foot and a half long and nearly six inches wide at the flared head. Grinning, you take the stone and carefully tap the bottom of the board until the peg starts wobbling loose. Using both hands, you yank the fire-hardened wooden dildo from its socket and hold it triumphantly over your head. You swing it in the air, experimentally, but decide that beating demons unconscious with a minotaur's dick would just be silly.\n\n");
				outputText("Heading back to the chained fairy, you rub the head of the wooden dildo between her petal-shaped labia, turning the cock as you do so, to lubricate the whole 18\" of the monstrous thing. You stroke her juices into the glistening finish until it's difficult to keep hold of and then you place the flared head at the entrance to her rape-worn love box. With exquisite slowness, you press the dildo against her pussy and apply pressure until it begins to part her lips, pushing her slit wider and wider. The fairy finally seems to come to under your teasing penetration and she coos at the stimulation, without questioning the source. She wiggles her plump butt and jiggles her chest, sending her absurdly large breasts swinging in the air, milk-heavy flesh slapping together. You encounter resistance just past her vulva and you roll the flared corona in circles, cold wood rubbing hot skin and soaking up the squirting girl's natural lubrication. With a wicked grin, you pull it out of her cunt and brace the monster against her puckered rear instead. Then, putting your hand on the far end of the dildo, you push as hard as you can, jamming it into the fairy's ass.");
				doNext(hermF_2);
			}
			//PART 2======================================
			function dickF_2():void {
				clearOutput();
				outputText("Before the fairy can get any tighter, you figure it's time to loosen her back up. Grabbing fistfuls of her violet hair, you thrust forward, violently, slamming the chained fairy's head against the stone wall. \"<i>Fuck!</i>\" She shrieks in delight. \"<i>More, more!</i>\" All too happy to comply, you begin screwing her harder, the crushing pressure of her swollen labia milking your cock with every motion. The giant fairy seems to feed on your rough treatment, and begins to slap her ass back into you, in time with your thrusts, giggling aimlessly between her disjointed pleas for your cum. You grab her wobbling chest, figuring it'll be the best handhold you're going to find on the malnourished girl, and are rewarded with an orgasmic cry from the fairy. She clenches down on your [cock] as she clasps your hardness, her pulsing depths making you dig your fingers deeper into her supple flesh. Rocking against her at a painful pace, you grit your teeth and tighten your grip on her teats, their fluid depths yielding to your passionate throes. Her nipples swell and burst with milk, white cream spraying at your feet with each thrust, and you slide your hands down to pull at the lactating pink nubs, each burst of pale alabaster filling your lust to bursting.\n\n");
				outputText("You can't keep up your frenzied pace for long, and the fairy's drug-tightened cunt finally takes its prize as your climax gushes from your [cock]. You scream in pleasure and slam her body against the wall, lifting her off the ground and holding the side of her face on the molding stone. Every muscle in your body strains as you crush the thin girl's frame between your twitching form and the dungeon wall, hips bucking in time to each of your pulsing loads. The girl simply lets her body be used like a cocksleeve, drinking in the abuse as much as your ejaculate. She twitches, limply, against you and spasms in orgasm again, whispering desperate imperatives to fuck her over and over again.\n\n");
				outputText("Finally spent, you step back and toss the girl off of your dick, letting her fall back into a slump against the wall, dangling from her manacles. A wicked thought crosses your mind and you step back to the Alchemy table. Grabbing armfuls of hexagonal bottles, you flip the girl around, exposing her drooling, empty face and her bruised, sore breasts. You plug a bottle up to her lips and she begins sucking at it automatically, her ravaged mind automatically assuming any phallic object to be another dick to suck. She quaffs the Ovi Elixir gratefully, then a second, then a third. By the time you've finished pouring the stuff down her throat, her body has already begun changing. The elixir has pounced on your seed and forced her ovulation, rapidly accelerating the speed of conception. Her tummy pouts, then bloats as your sperm impregnates the fairy in seconds. Her abdomen swells violently, and you suspect that force-feeding her so much so quickly may have resulted in a far greater pregnancy than she had to endure before. She moans in bliss, her already disproportioned tits gurgling with even greater milky weight. If there was any doubt as to if she could stand under her own power before, it's gone now - even your strength wouldn't be able to move the breeding cow that you've turned her into.  Knowing your luck, however, she'll have given birth by the time you check in next.");
				if (!recalling) player.sexReward("vaginalFluids", "Dick");
				sharedEnd();
			}
			function vagF_2():void {
				clearOutput();
				outputText("She squeals in delight and her knees wobble, the force of your thrust almost knocking her head into the wall she's shackled next to. You work the frightful dildo further into the girl's drooling snatch until a mere 9 inches protrudes from her bright pink cunny. You smear more of the girl's lubrication along the exposed shaft and turn your back to the fairy. Bending down, you slowly rub your [butt] against the smaller, rounded base of the minotaur cock. Though your end is veiny and sheathed, it lacks the broad flare of the cock head, so you press your " + vaginaDescript(0) + " against it and brace your hands on your [legs]. Rolling your ass up and down, you let your own excitement-thick lube smear the rounded end before you take a step backwards, toward the fairy. The bulb slides past your cheeks and presses against your vaginal entrance, its girth as exciting as it is frightening. You take a deep breath, but before you're ready, the impaled fairy bucks backward and drives the dildo into your unprepared cunt, provoking a cry of surprise.\n\n");
				outputText("You quickly recover and thrust backwards, driving more of the dildo inside your clenching walls while also slamming the fairy's slick box in lusty punishment for her over-eagerness. She giggles and humps right back, driving another inch into you, your uterus aflame with the delicious stimulation of the bumpy, uneven veins carved into the smooth cock-base. Before long, the two of you have a rhythm, driving the makeshift double-ended dildo into each other until you end up ass-to-ass, your [butt] smacking heavily against the fey girl's supple rear. A large puddle of girl cum has begun forming on the floor, each wet slap of your cunts splashing more of the warm, clear liquid between the two of you. You can feel your orgasm building a knot in your gut and you bite your lower lip as you make your thrusts more forceful, more insistent, slamming yourself down on the veiny cock, driving the flared head deeper into the fairy's body. She, in turn, is just as consumed by lust and tries to jackhammer it right back, until you can feel the rounded base pushing against your cervix, blissful pain coursing through your lower body.\n\n");
				outputText("You clutch your [allbreasts] and squeeze the " + nippleDescript(0) + " until they hurt, the agony giving you strength to drive the dildo back into the fairy. It's a losing battle, you realize, when Vala cums before you do, pulsing walls locking down and squeezing the dildo out, by painful inches, deeper into your " + vaginaDescript(0) + " until the base is so far against your gut that it's pushed into your womb with a toe-curling, wet pop. You silently scream in ecstasy and agony, unable to believe that the frail fairy managed to fuck your womb with your own toy. Your strength falters and you slump down, sliding off the shaft with soothing regret, your cervix clenching wildly, still spasming from the obscene intruder. You roll onto your back, fairy cum all around you, even now dripping down the lube-slick cock still sticking out of the girl's sex, flared glans keeping it locked inside of her. You jill your " + clitDescript() + " for a few minutes afterward, just enjoying the afterglow, lapping at the dripping sprite cum that dribbles onto your face from the fairy's shivering, dick-stuffed cunt. Gradually, your strength returns and you rise, skin slick from the cum pool you've been basking in. You remind yourself to clean your [armor] after this is over, sliding into them with damp, squishing noises, and give Vala's ass a slap on your way out - a reward for your favorite brainless fairy.\n\n");
				if (!recalling) player.sexReward("vaginalFluids", "Vaginal");
				sharedEnd();
			}
			function hermF_2():void {
				clearOutput();
				outputText("She squeals in delight and her knees wobble, the force of your thrust almost knocking her head into the wall she's shackled next to. You work the frightful dildo further past the girl's gaping spincter until a mere 9 inches remains protruding from her bright pink hole. You smear more of the girl's lubrication along the exposed shaft and turn your back to the fairy. Bending down, you slowly rub your [butt] against the smaller, rounded base of the minotaur cock. Though your end is veiny and sheathed, it lacks the broad flare of the cock head, so you press your " + vaginaDescript(0) + " against it and brace your hands on your " + (player.isNaga() ? "tail" : "knees") + ".  Rolling your ass up and down, you let your own excitement-thick lube smear the rounded end before you take a step backwards, toward the fairy. The bulb slides past your [butt] and presses against your " + vaginaDescript(0) + ", its girth exciting and frightening. You take a deep breath, but before you're ready, the impaled fairy bucks backward and drives the dildo into your unprepared cunt, provoking a cry of surprise.\n\n");
				outputText("You quickly recover and prepare your second surprise. Reaching around your " + hipDescript() + ", you grab your stiffening [cock] and pull it backwards, until it's just under the dildo connecting the two of you. With a thrust backwards, you jam your dick into her drooling pussy, while driving more of the dildo inside your clenching walls, slamming the fairy's distended rosette in lusty punishment for her over-eagerness. She giggles and humps right back, driving another inch of your shaft into her rectum and your uterus, your love-canal aflame with the delicious stimulation of the bumpy, uneven veins carved into the smooth cock-base. Before long, the two of you have a rhythm, driving the makeshift double-ended dildo into each other and thrusting your [cock] into Vala until you end up ass-to-ass, your [butt] smacking heavily against the fey girl's supple rear. A large puddle of girl cum has begins to form on the floor, each wet slap splashing more of the warm, clear liquid between the two of you. You can feel your orgasm building a knot in your gut and you bite your lower lip as you make your thrusts more forceful, slamming yourself into her violated nethers, the fairy's body as bloated from the minotaur dildo as from your own girth. She, in turn, is just as consumed by lust and tries to jackhammer right back into you, until you can feel the rounded wooden base pushing against your cervix, the mouth of her own womb slamming against your cockhead, blissful pain coursing through your lower body.\n\n");
				outputText("You clutch your [allbreasts] and squeeze the " + nippleDescript(0) + " until they hurt, the agony giving you strength to drive the dildo back into the fairy, but it's a losing battle. Vala cums before you do, her pulsing walls locking down and driving the dildo out, inch by painful inch, deeper into your body until the base is so far against your gut that it is pushed into your furthest recesses with a toe-curling, wet slap. You silently scream in ecstasy and agony, unable to believe that the frail fairy managed to fuck your womb with your own toy. Your strength redoubles and you thrust back, your [cock] penetrating her spongy, well-used cervix, her womb sucking you inside it. You release the knotted tension, spraying your spunk deep inside her. You slap your [butt] against hers with each pulsing load, your pussy clenching at the dildo stuffing it even as your empty your seed into the chained slave.  You try to go limp, but the double penetrated girl keeps you from pulling out, both holes clenching you against her until every last drop of your sperm has filled her greedy womb. Fairy cum drips down your length, while the flared tip deep inside her large intestine keeps your pussy twitching against her posterior. You jill your " + clitDescript() + " for a few minutes afterward, just enjoying the afterglow as your strength returns and the fairy's body unclenches, releasing you from your breeder's embrace, the minotaur dildo still halfway up her ass. You remind yourself to clean your [armor] after this is over, sliding into them with wet, squishing noises, and give your drooling fairy girl's rump a slap on the way out - a reward for her broodmother-sized hips.\n\n");
				if (!recalling) {
					player.sexReward("vaginalFluids", "Dick");
					player.sexReward("vaginalFluids", "Vaginal");
				}
				sharedEnd();
			}
			function sharedEnd():void {
				if (!recalling) {
					fatigue(5, 0);
					dynStats("cor", 1);
					flags[kFLAGS.TIMES_FUCKED_VALA_IN_DUNGEON]++;
					doNext(playerMenu);
				}
				else doNext(recallWakeUp);
			}
		}

		//[Wake]
		public function wakeValaUpBeforeYouGoGo():void {
			clearOutput();
			if (!recalling) dynStats("lus", 999, "scale", false);
			sceneHunter.selectGender(dickF, vagF, null, hermF);
			//=====================================================
			function dickF():void {
				outputText("You don't bother searching the room for a key to her shackles, knowing she's just clapped them over her limbs for the feel of the metal. You pull them open and, predictably, Vala slumps to the ground in an ungainly heap. The fall seems to have roused her, at least, because she blinks, slowly, several times before lifting her head to stare blankly at you. You give her a moment to gather herself but when she's managed to assemble what wits she's got left, it's clear she only recognizes you as her pleasure giver. She slowly curls her mouth into a hopeful smile. \"<i>How can Vala please Master?</i>\" she asks in an innocent voice tainted by husky desire. It seems she still shows no sign of improvement. Well, at least you can both take some enjoyment from your visit.\n\n");

				outputText("The fairy's grinding and the sweet scent leaking out of her honey pot is as tempting as ever. You push the girl back gently and nod your head, stripping your [armor] piece by piece, teasing the fairy with your slowness. She curls her lips into a wanton smile. \"<i>Now fuck Vala!</i>\" she begs. You chuckle and show your satisfaction at the small restoration of her mind by grabbing one of her supple tits and leaning down to suck out some of her chest-bloating milk. She arches her back under your touch and clenches her muscles. Her hands find your genitals, eager fingers sliding across your sensitive [skin.type]. Her hand grabs your [cock], thumb and pinkie forming a tight circle at your base while her other fingers stroke up and down your shaft. The fairy's touch is surprisingly light for the rough treatment she's endured, and you're quickly brought to hardness under her caresses.\n\n");

				outputText("Whatever small parts of her mind may be returning, she clearly hasn't conquered her sex-madness, because she simply cannot restrain herself any longer. Fluttering her wings rapidly, the girl lifts out of your embrace and rises above you, lining her sex up with yours, thick beads of wetness trickling down from her gaping pussy. With a mad giggle, she stops flapping and drops down, impaling herself on your length.\n\n");

				outputText("Vala slides onto your cockhead with gleeful squeals as you part her rose-petal labia and slide into her well-worn depths. Her body's recovered some of its tightness, and hugs your [cock] comfortably, walls clenching as her slavering cunt sucks your dick into her well-lubricated passage. Her abdomen distorts at your insertion, but instead of pain or fear, her expression is utter bliss, her pink eyes fluttering as she wordlessly mutters sweet nothings into your chest. She's tight and getting tighter as you pump slowly, working your long inches into the fairy's needy hole. Her body is hot around you and her milky tits drool with each thrust, their milk fragrant like rose water. At this rate, the condom-tight girl is going to make you blow your load before you get a chance to give her an orgasm of her own.");
				doNext(dickF_2);
			}
			function vagF():void {
				outputText("You don't bother searching the room for a key to her shackles, knowing she's just clapped them over her limbs for the feel of the metal. You pull them open and, predictably, Vala slumps to the ground in an ungainly heap. The fall seems to have roused her, at least, because she blinks, slowly, several times before lifting her head to stare blankly at you. You give her a moment to gather herself but when she's managed to assemble what wits she's got left, it's clear she only recognizes you as her pleasure giver. She slowly curls her mouth into a hopeful smile. \"<i>How can Vala please Mistress?</i>\" she asks in an innocent voice tainted by husky desire. It seems she still shows no sign of improvement. Well, at least you can both take some enjoyment from your visit.\n\n");

				outputText("You select what looks like a reasonably clean spot in the room and carry the girl with you. Sitting cross-legged, you let her sit in your lap as you brush Vala's violet hair from her face. Spitting on your hand, you wipe some of the grease and dirt from her face, while she coos at your touch. Under all the grime, she's actually quite pretty, an impossibly frail yet timeless sort of beauty that reminds you of snowflakes back home. You smile, despite yourself, and give the girl a little kiss of affection, stroking her tattooed shoulders gently. She returns your kiss with a famished sort of desperation, trying to gobble your face down in gulping slurps that force you to pull back and wipe the spittle from yourself. She's just not going to be happy until she gets something inside her.\n\n");

				outputText("You ask her if she feels up to flying, and she nods, eager to please. By way of demonstration, she flutters her dragonfly wings and lifts a couple feet into the air, heavy chest causing her to sway precariously. You stroke your hands up her legs, pulling them around your shoulders and drawing the girl's pussy toward your head. Vala's labia is almost artistic- hairless folds like rose petals, her leaking excitement like morning dew. You lean in and lick gently around her slit, the tip of your tongue tracing teasing circles around her small, overstimulated clit. She squeals in a pitch that you thought only dogs could hear and her legs clench around your head. Sliding your tongue into her gash, you savor her sweet warmth.");
				doNext(vagF_2);
			}
			function hermF():void {
				outputText("You don't bother searching the room for a key to her shackles, knowing she's just clapped them over her limbs for the feel of the metal. You pull them open and, predictably, Vala slumps to the ground in an ungainly heap. The fall seems to have roused her, at least, because she blinks, slowly, several times before lifting her head to stare blankly at you. You give her a moment to gather herself but when she's managed to assemble what wits she's got left, it's clear she only recognizes you as her pleasure giver. She slowly curls her mouth into a hopeful smile. \"<i>How can Vala please Mistress?</i>\" she asks in an innocent voice tainted by husky desire. It seems she still shows no sign of improvement. Well, at least you can both take some enjoyment from your visit.\n\n");

				outputText("Scooping her up in your arms, you marvel at the weightlessness of the fairy, even her chest-slapping titties are nothing to you. Carrying her to the center of the room, you set the girl down and retrieve her large, wooden bowl from a corner of the room. The three-gallon bowl's 'Bitch' title has been scratched out and replaced by a rough 'Vala.' You plop it down, in front of her, and fish around the tubes and toys hanging from the ceiling, selecting a promising looking one. The pale hose has a large, metal, imp-shaped cock for a tip and a nozzle at the base of the foot-long dildo. You twist the lever an inch and a slow, steady stream of cum comes leaking out the end. Grinning, you let the leaking iron dick splash ropey strands of slime across the fairy's tattooed backside, along her impossibly frail dragonfly wings, and into her glimmering purple hair.\n\n");

				outputText("Finally reaching the bowl, you twist the nozzle all the way and are nearly knocked to the ground by the pressure. The fire hose of sperm blasts into the large wooden bowl and splashes upward, painting the girl's face with alabaster cream. Before long, the bowl is full to overflowing and you cut off the flow of cum from the device. Kneeling down next to her, you stroke the back of her head and apply just the slightest bit of pressure toward the seething meal. \"<i>Dinner time, Vala,</i>\" you offer to the fairy, and her resistance crumbles, burying her face in the spunk, bubbles rising from the frothy bowl as she begins to suck it down with mindless obedience.\n\n");

				outputText("Your [cocks] is getting hard from the display, and you figure it'd be easier to satisfy the girl if you filled her from multiple holes. Reaching up again, you pull down a different hose, this time selecting a dildo that looks like an amalgam of several dick types. It's flared, like a horse's, knotted at the base, like a dog's, bulbous in the middle, like a lizard's, and barbed all along, like a cat's. You have no idea what kind of cum is filling this one, but you kind of want to see what'll pop out of the broken fairy. Hauling it down, you slide the hose behind you, threading it around your [butt], along your " + vaginaDescript(0) + ", and under your [cocks]. You bring your shaft to her gaping cunt and rub along her oozing labia, the puffy flesh inflamed with her desire. Slowly, you begin to slide your [cock] in first, letting her walls adjust to your girth, before pressing the dildo-nozzle into her twitching hole. The pressure of the strangely warm metal drives the fairy crazy, and her steady guzzle from the bowl becomes frantic gulps, her belly beginning to show a paunch from her meal. You let the girl's crystal cum soak the chimera-cock before feeding it into her slavering pussy, inches at a time. The girl's brood mother hips are so wide that you manage to penetrate her recesses with both cocks, though her abdomen stretches violently as the two cocks work their way deeper into her.");
				doNext(hermF_2);
			}
			//PART 2==========================================================
			function dickF_2():void {
				clearOutput();
				outputText("You spot an unsecured set of chained manacles on the floor and an idea strikes you. Vala still sliding along your shaft, you bend down and grab the fetters, snapping one around the girl's neck like a collar. With a shudder at the cold, you lift the fairy up and lock the other end of the shackles around the root of your [cock], steel snapping around your base tightly. The makeshift cock-ring works perfectly as your " + hipDescript() + " quiver, your body trying to orgasm but denied release by the metal loop. The fairy, meanwhile, thrashes atop your groin, the chain of her collar swinging between her tits, buffeting them with enough force to spray small white streams as she rides you. Her purple hair glimmers pink in the dull light of the dungeon as it bounces right along with her rocking hips. Even the diminished pulses of sunlight streaming from her stained and tattooed skin seems brighter as she is filled labia to cervix by your straining fuckpole.\n\n");

				outputText("She moans in a series of small, cute gasps and her pussy clenches your [cock] as tightly as the makeshift cock-ring. You savor the sweet shivers that run up her spritely body, fingers clenching around your arms and legs wrapping about your [butt] to slam deeper, even taking the chained shackle at your base into her cumming slit. It feels like a flood is released from the fairy's gaping box, warm fluid splashing around your bulging length and raining down to leave a thin, clear puddle under you. You bite your lip and slide your fingers into her vice-like pussy, to unhook the shackle around your cock, and the added insertion gives the girl enough to cum again, her body shaking violently against yours, squirting her hot girl cum over your hand. Vala notices what you're trying to do and she slams down onto your hand with added force, making it difficult to spring the catch. The pressure in your loins is getting painful now, and you lean against a wall, using both hands to try to unclap the fetters around your [cock]. Between her wings and the chain, she manages to stay firmly locked onto your root, grinding orgasmically as more fingers push past her pulsing lips and fumble at the cock-ring.\n\n");

				outputText("She cums a third time, utterly soaking your lower body, and you nearly wail with frustration. Clenching your teeth, you grunt and grab the fairy's cock-widened hips. You jam into her as hard and fast as you can, trying to fuck through the pressure and break your shackles with the force of your cum.\n\n");

				outputText("Vala is enjoying your pulsing erection inside her far too much to make it easy for you. You've seen her tricks, however and you thrust more forcefully than she was braced for, finally pulling the fey cocksleeve off your root. Without wasting a moment, you pull the locking bar out of the shackle and finally allow your orgasm to blast into her waiting womb. You slip in the fairy's cum puddle and fall on your [butt] as your [cock]  dumps its long-delayed loads inside the distended girl. The feeling of cum filling her pussy drives her to a fourth orgasm, her toes curling and wings flapping wildly. She's so tightly clenched around you that there's nowhere for your cum to run out, so her womb bloats to a pregnancy-thickness and she loses the strength to keep writhing in your lap, simply collapsing into your chest with a weak cooing.\n\n");

				outputText("She's unconscious by the time you're finished seeding the fairy, the girl's chest barely rising and falling under her disproportionately huge breasts and massively inflated womb. Even better than a goblin, you reflect, marveling at the fairy's resilience to the rapid sequence of orgasms. Though, you suppose, once you've already been fucked mindless, there's little left to break. You resolve to check back on her again.");
				if (!recalling) player.sexReward("vaginalFluids", "Dick");
				sharedEnd();
			}
			function vagF_2():void {
				clearOutput();
				outputText("You close your eyes and run your tongue into her groin with teasing flicks and probing touches, exploring her nethers and lapping up the constant flow of fae cum that dribbles from her perpetually wet body. She shifts in the air, but her clenching thighs keep you from seeing anything but her juicy snatch. When a hot, humid panting puffs against your " + vaginaDescript(0) + ", you realize she must've done a 180 in the air, wings keeping her in a vertical 69. She descends on your pussy with relish, savoring the taste of your moist body. Her needy tongue is as delicately thin as the rest of her body, but it is LONG. She threads it into your depths and you buck your hips as it just keeps going deeper and deeper. You moan into her abdomen and flatten your own tongue to bring as much roughness against her twitching walls as you can, trying to get the little minx off before she sucks your orgasm from you.\n\n");

				outputText("It's a hopeless race, however, as she quickly zeros in on your g-spot, curling her tongue to coil thickly inside of you. You grab Vala's purple hair and crush her head into your crotch, adorable button nose grinding against your " + clitDescript() + ", momentarily distracting you from the fairy's pussy as she tongue-rapes yours. When you cum, your body tenses and you hold your breath as your " + hipDescript() + " threaten to draw the small girl's whole head into your " + vaginaDescript(0) + ". You hear a slurping and realize she's drinking your girl cum. The thought is enough to remind you about the fairy slit at eye-level just as she cums from the taste of your body. She squirts wildly into your face, small jets of hot, sticky liquid spraying into your mouth, over your cheeks, and into your eyes.\n\n");

				outputText("You blink, and give the little brat a bump on the back of the head for her sneaky facial. She flutters right-side up again and when you see her face, your heart leaps in your chest. Your orgasm has washed her visage clean and you realize she's breathtaking. The soft curves of her heart-shaped face, the timeless alabaster of her flawless skin, and most surprisingly, the glimmers in her almond-shaped, pink eyes. She kisses you, softly this time, almost affectionately, the taste of your sex still wet on her lips. Perhaps your exchange unlocked the memory of sweeter days with her fairy sisters? She might never be able to recapture those lost days, but in time, perhaps she can forge a new life among larger folk. You return her kiss and redress as she finally gets some restful, if wet, sleep.");
				if (!recalling) {
					player.sexReward("vaginalFluids", "Lips");
					player.sexReward("saliva", "Vaginal");
				}
				sharedEnd();
			}
			function hermF_2():void {
				clearOutput();
				if(player.cockTotal() > 1) outputText("It'd be a shame if you didn't get a chance to stuff all her holes, so you grab your " + cockDescript(1) + " and slide it along her ass cheeks, pulling out just enough to let it rest against her twitching sphincter. With a probing pinkie, you stretch out her rectum, the muscle spongy from the endless cavalcade of imp-rape you saved her from. You slide in and are pleasantly surprised that her ass is nearly as slick as her pussy, already lubricated by some body-altering drug the imps must've fed her. You grunt in surprise when you feel your two cocks rubbing against each other through the fleshy wall separating her vagina from her ass, and the extra friction nearly makes you blow your load then and there, but by force of will, you hold it back, teeth gritted in the effort.\n\n");

				outputText("Your " + vaginaDescript(0) + " needs some loving too, so you grab the imp dildo you filled the fairy's bowl with and slide it between your " + hipDescript() + ", the cold metal exciting your moist sex and driving your shaft deeper into the girl. Hesitating at first, your restraint crumbles and you press the steel tip to your wet sex, and roll it around your clit, the chill sending electric tingles through your groin and sets a raging fire in your loins as your flesh walls pulse from your racing heart. You guide the imp-shaped dildo to your pussy and slide the demonically sculpted toy into your body, unyielding metal parting your soft, supple skin, folds of pink flesh sucking at the knobby shaft. You gasp and nearly pull out of the tight confines of the fairy's double-stuffed cunt, but with a quick thrust, you penetrate yourself and jam more long inches into Vala.\n\n");

				outputText("The steel against your [cock] and inside your cunny gurgle with their restrained payloads and you resist the urge to twist both nozzles until they break, instead beginning a slow bucking ride of the fairy. Sliding the imp cock into your " + vaginaDescript(0) + " on each back-thrust, and stuffing more of the monstrous dildo into her quivering body with every bucking motion, you work your arms as much as your hips. The bulge of your tools inside her nubile body gets deeper with every push, rushing to meet the swell of her cum-stuffed stomach, having downed nearly two of the three gallons you poured for her already. As you're rocking back, building up to a truly delicious orgasm, the slick girl cum from your pussy drips between your fingers and you lose your grip momentarily. Trying to regain it, your hand accidentally strokes the nozzle at the base and your eyes go wide as the imp cock unleashes a torrent of seething spunk into your body. Panicking, you try to twist it shut again, but only manage to open the spigot all the way, your abdomen nearly bursting as the firehose blasts your cervix with a gushing pillar of cum.\n\n");

				outputText("Your careful restraint is torn from your body and an orgasm overtakes you.  ");
				//(2 Dicks-
				if(player.cockTotal() > 1) outputText("The " + cockDescript(1) + " inside the fairy girl's ass erupts first, pumping your seed into her bowels, her hips distorting with the bursting flow of your cum, her sphincters clenching powerless to stop your alabaster flood.  ");
				outputText("Inside Vala's drooling pussy, your [cock] twitches as your load rushes over the steel dildo and spurts from your cockhead in hot ropes of gooey love. You manage to think through the suffocating pleasure addling your brain and flick the nozzle of the chimera dildo, the tube kicking to life. The monstrous hose vibrates your entire lower body and you tremble helplessly as you're stimulated nearly to breaking. The fairy girl, already happily shattered, merely lets out a stream of mad laughter, cum bubbling over her lips as her cunt is turned into a cornucopia of monster jizz. A cunny-copia, you giggle to yourself, her insane glee infecting your exhausted body. The double-penetrated fae bloats and swells under the pressure of the cum-pump, supplemented your own obscene spunk stuffing.\n\n");

				outputText("When your orgasm subsides, you finally manage to switch off the imp pump in your " + vaginaDescript(0) + " and pull it out, tenderly. Your abdomen has been filled enough to leave a paunch of infernal cream below your belly. You press down on it, demonic ichor spilling out of your swollen vagina and splashing between your " + hipDescript() + ". You sigh and hope the seed doesn't take hold. Speaking of taking hold, you switch off the gushing monster pump and carefully pull your [cocks] out of the fairy, making sure the metal dildo remains fixed in place to hold the cum inside. You slide out from between her legs and rise unsteadily to look at your handiwork. The fairy has been filled, top to bottom, all three gallons you sprayed in her bowl gone down her thirsty gullet. The jizz you packed into her womb bloats her even further, the girl's belly nearly four times larger than it was when you found her. She wriggles on the ground, lost to the cummy heaven her mindless body has been plunged into. You're not sure what kind of fucked up child that little exchange would give her, but if anybody had the vagina to pass a monster, it'd be Vala. You probably won't get to find out, though. Who knows what kind of incubation period the chimera-kid will have?");
				if (!recalling) {
					player.sexReward("vaginalFluids", "Dick");
					player.sexReward("cum", "Vaginal");
				}
				sharedEnd();
			}
			function sharedEnd():void {
				if (!recalling) {
					dynStats("cor", 1);
					flags[kFLAGS.TIMES_FUCKED_VALA_IN_DUNGEON]++;
					doNext(playerMenu);
				}
				else doNext(recallWakeUp);
			}
		}

		//[Reject]
		public function rejectFuckingVala():void {
			clearOutput();
			if(flags[kFLAGS.TIMES_PC_DEFEATED_VALA] == 0) {
				outputText("The fairy's weak insistence has begun to get obnoxious. What kind of prisoner dry humps her rescuer? Actually, if the heavy flow of lubricating girl cum dripping out of her pussy is any indication, it's the wettest humping you've had with your [armor] still on. You seize the girl's shoulders and hold her up, pushing her away from your goo-stained lower body. You assure the girl that you won't be having sex with her here. It's far too dangerous, you tell her, to leave yourself vulnerable right now. You'll take her to safety when the demons are defeated. You try to impress on her the importance of speed and stealth, but you might as well be talking to a big-breasted brick wall. When she makes a grab at your crotch, you've had enough and throw her back.\n\n");

				outputText("The fairy gathers herself and raises her eyes to you, mad passion whirling in their pink depths. \"<i>But Bitch is horny!</i>\" she demands, madly. Her wings gain sudden life, flapping rapidly to pull her frail body off the floor. Hovering before you, she curls her fingers into desperate claws and rakes at you. She's too far gone, you realize. You're going to have to fight the broken fairy!");
			}
			else {
				outputText("What's wrong with this fairy? You've already beaten her once, but she's still dripping and grinding against you. If anything, it's even wetter than the last humping the sex-addicted faerie forced on you. You seize the girl's shoulders and hold her up, pushing her away from your goo-stained lower body once again and re-iterate that you won't be having sex with her right now – you have other tasks that need your attention.  It doesn't work, and once again she makes a move towards your crotch.");
				if(flags[kFLAGS.TIMES_PC_DEFEATED_VALA_AND_RAEPED] > 0) outputText("  You smirk in wonder at the horny little slut.  You guess you'll have to put her back into her place and give her another dose of 'love'.");
				outputText("\n\n");

				outputText("The fairy stumbles up and fondles herself madly, already looking close to defeat. \"<i>Bitch doesn't want to leave masters!  Masters have good cum.  Let bitch show you how wonderful it tastes.</i>\" she demands, madly. Her wings gain sudden life, flapping rapidly to pull her frail body off the floor. Hovering before you, she curls her fingers into desperate claws and rakes at you. She's too far gone, you realize. You're going to have to fight the broken fairy, AGAIN!");
			}
			//Initiate fight
			if (!recalling) {
				startCombat(new Vala(),true);
				doNext(playerMenu);
			}
			else {
				outputText("\n\nSome time passes...");
				advanceMinutes(30);
				doNext(SceneLib.dungeons.deepcave.fightValaVictory);
			}
		}

		//[Fuck]
		public function valaFightVictoryFuck():void {
			clearOutput();
            sceneHunter.selectGender(dickF, vagF, null, hermF);
            //====================================================
			function vagF():void {
				outputText("If the girl's got energy to spare, you'd better try to wear her down or she might alert more demons after you leave. Time to see just how strong her drug-fuelled wings have become. Stripping down, you step up to the fairy and present your " + vaginaDescript(0) + " to her. She's all too happy to lavish kisses on your lower lips, hot tongue sliding along your labia and tip teasing your " + clitDescript() + " with lapping flicks. Licking your lips, you bend over and pull her legs up, forcing her into a hand-stand as you raise the girl's gushing sex to your head. It's startling how light the fairy is; even her flesh-slapping titties are practically weightless as you loop an arm around her impossibly thin waist and bury your face in her groin, breathing in her honey-sweet nectar as she squirts hard enough to splash you with her warm juice. You bear down on her stimulation-swollen clit and suck the joy buzzer hard enough to pull it from the thin skin sheath. Biting lightly on the engorged button, you whisper into the fairy's cunt, \"<i>Let's fly.</i>\"\n\n");
				outputText("She needs no additional urging, and wraps her whip-thin arms around your [butt] with a grip like steel. Her corruption-strengthened dragonfly wings flutter uselessly for a moment, but as your excitement begins to drip warm fluid onto her tongue, she flaps like she means it.  ");
				//(PC Has Wings:
				if(player.wings.type > Wings.NONE) outputText("You decide to give her a hand, and flap your " + player.wings.desc + " as hard as you can, the added thrust giving her the start she needs.  ");
				outputText("Like a hummingbird on coffee, the fairy's wings blur as she pulls the two of you into the air and a thrill of glee sends shivers down your spine as the two of you slowly circle the room, clinging to each other in a desperate 69. Under her well-practiced mouth, you can feel your " + vaginaDescript(0) + " drooling nearly as much as the fey girl's, your utter dominion of the fairy delighting you nearly to the verge of orgasm.\n\n");
				outputText("Still, she was such a willful creature, attacking you like that. Pets can't be allowed to bite their masters without punishment. Spare the rod, spoil the fairy. Lacking a rod, you use the next best thing. Keeping one arm firmly pinning the girl's thighs around your head, you reach up with the other and begin to feed fingers into her imp-loose cunt. The first three fingers slide in with practically no resistance, and your pinkie pushes in with only a bit of effort. When you reach your thumb, the girl has begun rocking her hips against your hand, rubbing her clit on your arm like a tiny tongue, smearing her sticky grease along your wrist. You push down and manage to fit your whole hand inside the girl, fingers cupped to a point, thumb tucked in your palm. She gurgles and jams her mouth against your " + vaginaDescript(0) + ", doing her best to please her Mistress. You savor the wet velvet feel of her depths, sliding in and out for a moment before you decide to begin the punishment.");
                if (!recalling) dynStats("lus", 99, "cor", 1);
                doNext(vagF_2);
			}
			function dickF():void {
				outputText("If the girl's got energy to spare, you'd better try to wear her down or she might alert more demons after you leave. Commanding her to bow before you, the broken fairy is all too happy to comply, falling on her face, her arms spread wide, panting with desire. You circle around her and strip your [armor] off, admiring her plump little ass, all the plumper for how whip-thin her waist and legs are. You bend down to grab her waist and haul her ass upward, spearing her on your stiffening [cock] without further ceremony. It's important she knows that foreplay is for obedient pets, you note to yourself with a grin. With a vicious thrust, you fill the girl's stretched pussy and bend her over at a right angle. Smacking her ass, you command the little bitch to fly and she shivers with delight.\n\n");
				outputText("She needs no additional urging, and wraps her whip-thin legs around your " + hipDescript() + " with a grip like steel. Her corruption-strengthened dragonfly wings flutter uselessly for a moment, but as your excitement begins to leak globs of pre-cum into her sucking box, she flaps like she means it. ");
				//(PC Has Wings:
				if(player.wings.type > Wings.NONE) outputText("You decide to give her a hand, and flap your " + player.wings.desc + " as hard as you can, the added thrust giving her the start she needs.  ");
				outputText("Like a hummingbird on coffee, the fairy's wings blur as she pulls the two of you into the air and a thrill of glee sends shivers down your spine as the two of you slowly circle the room, you're mounting her doggy-style, hands gripping her ribs as you lean over her. The tight clenching of her overburdened flight turns her loose pussy into a tight, clenching sphincter that practically milks your shaft with every heartbeat.\n\n");
				outputText("She makes a short circuit around the room, slowing enough to savor each thrust, your pounding giving her a short burst of speed as you ride the bitch through the air, every muscle in both of your bodies tense with the effort. You're still not convinced she's been sufficiently humbled, however, so you thread your arms under her wings and loop your hands around the sides of her face. You slide your forefingers into her mouth and hook the fingers to pull her cheeks wide open. Like a horse's reins, you jerk the fairy's head back and wrap your other fingers under her jaw, fully controlling her head. She tries to speak, but slurs the words, drool gushing from her wrenched mouth. You guide her head up, and she rises, descending when you yank it down. Satisfied that she understands your commands, you decide that it's time to take your mare through her paces.");
				if (!recalling) dynStats("lus", 99, "cor", 1);
                doNext(dickF_2);
			}
			function hermF():void {
				outputText("If the girl's got energy to spare, you'd better make sure she can't leave under her own power or she might alert more demons after you leave. You could always chain her back up, but you think you've got a better idea. Scooping her up in your arms, you marvel at the fairy's lightness, even her chest-slapping titties are practically weightless to you. Carrying her to the center of the room, you set the girl down and retrieve her large, wooden bowl from a corner of the room. The bowl has the word \"<i>Bitch</i>\" scratched on it in the ragged style of imps and is large enough to hold perhaps three gallons of food. You plop it down, in front of her, and fish around the tubes and toys hanging from the ceiling, selecting a promising looking one. The pale hose has a large, metal, imp-shaped cock for a tip and a nozzle at the base of the foot-long dildo. You twist the lever an inch and a slow, steady stream of spoo comes leaking out the end, startling you to realize that the hose isn't white, but simply full of cum. Grinning, you let the leaking iron dick splash ropey strands of jizz across the fairy's tattooed backside, along her impossibly frail dragonfly wings, and into her glimmering purple hair.\n\n");
				outputText("Finally reaching the bowl, you twist the nozzle all the way and are nearly knocked off your feet by the pressure. The fire hose of sperm blasts into the large wooden bowl and splashes upward, painting the girl's face with alabaster cream. Before long, the bowl is full to overflowing and you cut off the flow of cum from the device. Standing over her, you begin shedding your clothing and place the ");
				outputText("underside of your [foot] against the back of her head and apply pressure, forcing her face toward the seething meal. \"<i>Eat up,</i>\" you command the fairy, and her resistance crumbles, allowing her face to be fully submerged in the spunk, bubbles rising from the slimy bowl as she begins to suck it down with mindless obedience.\n\n");
				outputText("Your own cock is getting hard from the display, and you figure it'd be easier to stuff the slut if you filled her from multiple holes. Reaching up again, you pull down a different hose, this time selecting a dildo that looks like an amalgam of several dick types. It's flared, like a horse's, knotted at the base, like a dogs, bulbous in the middle, like a lizard's, and barbed all along, like a cat's. You have no idea what kind of cum is filling this one, but you kind of want to see what'll pop out of the broken fairy. Hauling it down, you get to your knees and slide the hose behind you, threading it over your [butt], along your " + vaginaDescript(0) + ", and under your [cock]. You bring the shaft to her gaping cunt and rub along her oozing labia, the puffy flesh inflamed with her desire. Slowly, you begin to slide your own cock in first, letting her walls adjust to your girth, before feeding the dildo-nozzle into her twitching hole. The pressure of your cock and the strangely warm metal drives the fairy crazy, and her steady guzzle from the bowl becomes frantic gulps, her belly beginning to show a paunch from her meal. You let the girl's crystal cum soak the chimera-cock before driving more of it into her slavering pussy, inches at a time. The girl's hips have been fucked so wide that you manage to penetrate her recesses with both cocks, though her abdomen stretches violently as the two cocks work their way deeper into her.");
				if (!recalling) dynStats("lus", 99, "cor", 1);
                doNext(hermF_2);
			}
            //PART 2============================================================================
            function vagF_2():void {
			    clearOutput();
                outputText("One by one, you curl your fingers into a ball, tightening your hand into a fist within the girl's pink tunnel, sensitive walls parting before your hardening grip. The fairy's wings spasm as she orgasms under your clenching fist, nearly dropping the two of you back onto the stone floor, before she catches herself and pulls up. You pump your fist into her tunnel, thick as a minotaur's cock, and the girl's pussy gushes in ecstasy. You can feel her inner walls flexing against your arm, coiled rings of muscle tightening in pinching contractions, actually pulling your arm deeper into her cunt. You pull back, reminding her greedy cunny who the Mistress is, fist stretching her abdomen in a way that brings a shuddering orgasm to your quivering sex. Your own walls tighten around the fairy's fair features, trapping her tongue inside you as your " + vaginaDescript(0) + " squirts down her lips and across her face. She begins to spin in mid-air and the force of the rotation is nearly enough to shake you off of the oversexed girl's body.\n\n");
				outputText("You'll be damned if she's going to shake you loose before you break the bitch. You tighten your grip around her waist and jam your fist deep into her cunt, up to your elbow, her spongy cervix posing practically no barrier as your hand punches into her imp-tainted womb, bloating her belly like she's been thrust atop a flagpole. The fairy spins out of control, bucking and writhing in clenching frenzy, slamming against the ceiling and walls in wild flight as you unclench your fist, to feel the sucking wet heat of her innermost recesses slurping at your fingers, gushing girl cum spraying in regular gouts, her pussy climaxing like a breached dam. Her blurring wings falter and the two of you begin to tumble to the ground, but the enslaved slut knows her place well enough to make sure that she lands between you and the floor, your bodies slumping together as her back arches in orgasmic grinding. Sufficiently tamed, you brace your free hand against her spasming legs and pull your arm out the girl's pussy in one motion, her distorted abdomen collapsing against her overstretched vaginal cavity, the bulging outline of her womb still visible against the thin girl's waist.");
				outputText("Reaching down to grab the fairy's exhausted wings, you wipe the cum bath from your arm on the soft dragonfly-like membranes, figuring the slime should keep her from taking flight until it has a chance to dry. Satisfied by the ride, you figure it's time to move on to the girl's former masters.");
				if (!recalling) {
					player.sexReward("vaginalFluids", "Lips");
					player.sexReward("saliva", "Vaginal");
				}
				sharedEnd();
            }
            function dickF_2():void {
			    clearOutput();
                outputText("You pick up the speed of your animalistic fucking and guide the fairy's head on a bobbing path through the air, using short dives to slam your [cock] deeper into her cunt. She giggles mindlessly at your abuse and her drooling box clenches tighter still, her passage almost virginal from the exertion of the flight. You can feel an orgasm building in your gut and you twist the girl's head all the way back until she turns over, flying upside down. Your grip on her head combined with her legs coiled around your [butt] keep you locked inside the girl as you command her to 'land' on the ceiling, her wings reaching a frenzied pace to keep the two of you suspended in the air. When she touches the sulfur-stained stone, you brace yourself against the slut and redouble your pounding, every thrust squirting increasingly larger bulbs of pre-cum into the needy hole. Like a dog, she pounds back, slavering pussy oozing down your groin, along your chest, and sliding into your nose, filling your head with images of blissful rose gardens and the moist smell of fallen leaves after an autumn rain. No longer able to hold back, you empty your load inside the upside down fairy, ropes of gooey spunk filling her cunt even as she rocks back and forth, her intensely clutching tunnel slurping every drop from your suspended body.\n\n");
				outputText("Her orgasm comes a moment later, and her wings lose their wild pace, sending the two of you tumbling out of the air, toward the ground. You jerk her head back, painfully, but the girl is lost in the depths of her creaming, muscles clenching and unclenching uselessly as her seed-stuffed sex sprays the girl's clear cum into the air, crystal bubbles spilling around your falling bodies. She giggles and mumbles something about cushions before giving one last, hard flap, sending your bodies spiraling. The fairy pet's wings twists you around so that when the two bodies land, she is under you, her sex-inflated chest cushioning her fall like liquid body pillows. The sudden shock sends her into another wild orgasm, crushing you inside her impossibly tight pussy, her womb bloating from the trapped sperm your panic-fuelled body churns out. You gasp at the descent, just letting the bitch's lower lips milk your [cock], until you gather yourself. Despite your weight, she seems uninjured, her eyes rolling aimlessly in their sockets, a brainless smile plastered across her face. You rise, unsteadily, and leave the fairy lying there, ass in the air, gushing cunt stuffed with your cum all the way to her clit, your exhausting creampie finally satisfying the fey whore. You'd have to be crazy to try that again, you pant, trying to slow your heartbeat. Next to that wild ride, the demons should be no problem, you sigh, fatigued.");
				if (!recalling) player.sexReward("vaginalFluids", "Dick");
				sharedEnd();
            }
            function hermF_2():void {
			    clearOutput();
                if(player.cockTotal() > 1)
					outputText("It'd be a shame if you didn't get a chance to stuff all her holes, so you grab your " + cockDescript(1) + " and slide it along her ass cheeks, pulling out just enough to let it rest against her twitching sphincter. With a probing pinkie, you stretch out her rectum, the muscle spongy from the fuckings the demons have tattooed all down her back. You slide in and are pleasantly surprised that her ass is nearly as slick as her pussy, already lubricated by some body-altering drug the imps must've fed her. You make a note to give her a dash on both the ass and pussy columns of her score-card body-tattoo. You grunt in surprise when you feel your two cocks rubbing against each other through the fleshy wall separating her vagina from her ass, and the extra friction nearly makes you blow your load then and there, but by force of will, you hold it back, teeth gritted in the effort.\n\n");
				outputText("Your pussy needs some loving too, so you grab the imp dildo you filled the fairy's bowl with and slide it across your " + hipDescript() + ", the cold metal exciting your moist sex and driving your [cock] deeper into the girl. Hesitating at first, your restraint crumbles and you press the steel tip to your " + vaginaDescript(0) + ", and roll it around your " + clitDescript() + ", the chill sending electric tingles through your groin and sets a raging fire in your loins as your flesh walls pulse from your racing heart. You guide the imp-shaped dildo to your pussy and feed the demonically sculpted toy into your body, unyielding metal parting your soft, supple skin, folds of pink flesh sucking at the knobby shaft. You gasp and nearly slide out of the tight confines of the fairy's double-stuffed cunt, but with a quick thrust, you penetrate yourself and jam more long inches into the cum-enslaved girl.\n\n");
				outputText("The steel against your cock and inside your cunny gurgle with their restrained payloads and you resist the urge to twist both nozzles until they break, instead beginning a slow bucking ride of the fairy. Sliding the imp cock into your gash on each back-thrust, and stuffing more of the monstrous dildo into her quivering body with every bucking motion, you work your arms as much as your " + hipDescript() + ". The bulge of your tools inside her nubile body gets deeper with every push, rushing to meet the swell of her cum-stuffed stomach. The girl has already slurped up nearly two of the three gallons you poured for her. As you're rocking back, building up to a truly delicious orgasm, the slick girl cum from your " + vaginaDescript(0) + " drips between your fingers and you lose your grip momentarily. Trying to regain it, your hand accidentally strokes the nozzle at the base and your eyes go wide as the imp cock unleashes a torrent of seething spunk into your body. Panicking, you try to twist it shut again, but only manage to open the spigot all the way, your abdomen nearly bursting as the firehose blasts your cervix with a gushing pillar of cum.");
				outputText("Your careful restraint is torn from your body and orgasm overtakes you.  ");
				if(player.cockTotal() > 1) outputText("Your [cock] inside the fairy girl's ass erupts first, pumping your seed into her bowls, her hips distorting with the bursting flow of your cum, sphincter's clenching powerless to stop your alabaster flood.  ");
				outputText("Inside the fairy's drooling pussy, your  [cock] twitches as your load rushes over the steel dildo and spurts from your cockhead in hot ropes of gooey love. The suffocating pleasure addling your brain makes you flick the nozzle of the chimera dildo, the tube wrapped around your " + hipDescript() + " kicking to life. The monstrous hose vibrates your entire lower body and you pump helplessly as your body is stimulated nearly to breaking. The fairy girl, already broken, merely lets out a stream of mad laughter, cum bubbling over her lips as her cunt is turned into a cornucopia of monster jizz. A cunny-copia, you giggle to yourself, her insane glee infecting your exhausted body. The double-penetrated fae bloats and swells under the pressure of the cum-pump, supplemented your own obscene spunk stuffing.\n\n");
				outputText("When your orgasm subsides, you finally manage to switch off the imp pump in your " + vaginaDescript(0) + " and pull it out, tenderly. Your abdomen has been filled enough to leave a paunch of infernal cream below your belly. You press down on it, demonic ichor spilling out of your swollen vagina and splashing between your thighs. You sigh and hope the seed doesn't take hold. Speaking of taking hold, you switch off the gushing monster pump and carefully pull your [cock] out of the fairy, making sure the metal dildo remains fixed in place to hold the cum inside. You slide out from between her legs and rise unsteadily to look at your handiwork. The fairy has been filled, top to bottom, all three gallons you sprayed in her bowl gone down her thirsty gullet. The jizz you packed into her womb bloats her even further, her belly nearly four times larger than it was when you found her. She wriggles on the ground, lost to the cummy heaven her mindless body has been plunged into. That should keep her occupied while you root out the imps.");
				if (!recalling) {
					player.sexReward("vaginalFluids", "Dick");
					if (player.cockTotal() > 1) player.sexReward("no", "Dick");
					player.sexReward("cum", "Vaginal");
				}
				sharedEnd();
            }
			function sharedEnd():void {
				if (!recalling) {
					flags[kFLAGS.TIMES_FUCKED_VALA_IN_DUNGEON]++;
					flags[kFLAGS.TIMES_PC_DEFEATED_VALA_AND_RAEPED]++;
					cleanupAfterCombat();
				}
				else doNext(recallWakeUp);
			}
		}

		//Purified Fairy
		public function purifiedFaerieBitchBar():Boolean {
			//Is Vala freed?  If not boot out
			if(flags[kFLAGS.FREED_VALA] == 0) return false;
			//(Entering the Wet Bitch for the first time after Healing her)
			//[Entering the bar description]
			//(Works from 12:00 to 21:00)
			if(model.time.hours >= 12 && model.time.hours <= 21) {
				//[Vala] (After sex encounter for the day)
				if(flags[kFLAGS.FUCKED_VALA_AT_BAR_TODAY] > 0) {
					outputText("\n\nThe fluttering fairy drops a complimentary drink off at your table with a sly wink. You can't help but notice that she's leaving a clear trail of girl cum as she flies past, the cummy trail leaking from between her legs. Lingering testimony of the break you took with her, no doubt. She seems a bit busy right now, but maybe if you checked back tomorrow, she'd be able to take the time to thank you again, tomorrow.");
					return false;
				}
				outputText("\n\nA short figure flutters around the bar, a tray of drinks suspended awkwardly by both arms, carefully moving from table to table, dispensing liquor and taking orders for the bartender. The barmaid appears to be Vala, the fairy you rescued from Zetaz's dungeon. It seems like she's found a home in Tel'Adre.");
				if(player.gender > 0) {
					outputText("  You could speak with her if you wished to.");
					return true;
				}
				else outputText("  Speaking to her might be better after you get a gender...");
			}
			return false;
		}

		//[Vala]
		public function chooseValaInBar():void {
			spriteSelect(SpriteDb.s_vala);
			clearOutput();
			menu();
			//(First meeting)
			if(flags[kFLAGS.ENCOUNTERED_VALA_AT_BAR] == 0) {
				flags[kFLAGS.ENCOUNTERED_VALA_AT_BAR]++;
				outputText("You take a seat and flag the fairy barmaid over. Vala is dressed in a long, emerald, sleeveless dress that covers her from neck to toe, her fluttering wings keeping the hem from ever touching the ground. She wears thick bracelets around her wrists, has her glittering purple hair done up in a no-nonsense bun, and has a plain white apron over her chest. You realize she's intentionally covering up the scars and tattoos from her imprisonment. She doesn't seem to notice it's you until she gets close enough to touch your shoulder \"<i>Oh!</i>\" she exclaims. \"<i>Why, if it isn't my heroic rescuer!</i>\" She leans in to give you a kiss on the cheek and places a drink on your table. \"<i>From me. It's the least I can do. I'm still new at this, so we're a bit slammed right now, but I'd love a chance to catch up. Can you wait 'til I get a chance to take a break?</i>\"\n\n");

				//Goto cleansedFirstRemeet();
				//[Next]
				addButton(0,"Next",cleansedFirstRemeet);
				return;
			}
			else if(flags[kFLAGS.SHOULDRA_MET_VALA] == 1) {
				flags[kFLAGS.SHOULDRA_MET_VALA] = 2;
				outputText("As soon as you call for Vala, she flutters over with a smile.  Before you even manage a word, she kisses you full on the mouth.  The kiss is a passionate, sloppy mess that has her tongue piercing your lips with reckless abandon, fluttering around your own as she presses her demon-distorted body against you, allowing you to feel just how gigantic her breasts are on her small frame.  It's deliciously obscene.");
				outputText("\n\nThe human-sized faerie releases you with a high-pitched whimper of excitement, brushing away the strings of saliva that hang between you.  A bit alarmed, you ask what brought on the unusually passionate display.  You're still a bit shocked by her attitude - is this a result of the tryst you and Shouldra had?  No, that was almost rape... surely she wouldn't be happy about it?");
				outputText("\n\nVala pulls back and punches you on the shoulder, just hard enough to leave you wondering if it's playful or irritated.  She blurts, \"<i>Did you think I wouldn't remember last time?  Did you think I couldn't feel myself possessed, growing to the size of a building and playing with you like YOU were the faerie?</i>\"  Folding her arms behind her nervously, the purple-haired girl unintentionally puts her melons on display as she explains, \"<i>What faerie hasn't dreamed of getting to be BIG!  There's something so... exciting about towering over everyone else and treating them like a little, sexual playtoy.  About the only thing that would make it better would be seeing you stumbling around like a drunk afterward, but I suppose you'd have to be a proper faerie for that to work...</i>\"");
				outputText("\n\nYour surprise must be showing, because Vala reaches out a petite finger to catch your chin, slowly pressing your mouth closed.  \"<i>I remember it all, and... I wouldn't mind being BIG for my... little... hero, again.</i>\"");
				outputText("\n\nNodding dumbly, you can't hide your smile, and you know if you could see inside yourself, Shouldra's head would be divided by the world's largest grin.");
				outputText("\n\n\"<i>Now, what did you want today?</i>\"");
				//"Big You" added to menu
			}
			else if(model.time.hours == 20 && rand(2) == 0 && player.hasCock()) {
				kinathisValaStuff();
				return;
			}
			else {
				outputText("You take a seat and flag the fairy barmaid over. Vala is dressed in her long, emerald, sleeveless dress, the imp tally tattoos on her backside hidden from sight. Her thick bracelets jangle around her wrists, purple hair in its modest bun, plain white apron hiding her swollen chest. She smiles as she approaches and reaches to hug your head into her breast when she reaches you \"<i>Why, if it isn't my favorite customer.</i>\" She gives you a kiss on the cheek and places a drink on your table. \"<i>From me, as always. I can never repay my debt to you, but it sure is fun trying. Can I get you anything from the back room?</i>\"");
				//Once per week special!
				if(flags[kFLAGS.WEEKLY_FAIRY_ORGY_COUNTDOWN] == 0) {
					outputText("\n\nA thought occurs to her and she leans in, conspiratorially. \"<i>Actually, some of my sisters are visiting from the forest today. Should we spend some time with them, or do I get you all for myself?</i>\"");
					addButton(0,"Faeries",faerieOrgyFuck);
				}
				if(ValaFairyQueenQuest == QUEST_STAGE_NOT_STARTED) {
					outputText("\n\nShe looks a little worried there might be something up her mind perhaps you should ask her about it.");
					addButton(4,"Worries",Worries);
				}
				if(ValaFairyQueenQuest == QUEST_STAGE_ITEM_GATHERED) {
					outputText("\n\nWith all the pieces of the scepter in hand its about time you report the good news to her.");
					addButton(4,"Scepter",Scepter);
				}
				if(ValaFairyQueenQuest == QUEST_STAGE_ITEM_TURNEDIN) { //Temporary until I work in a timer
					outputText("\n\nCome to think of it what happened with the scepter after you brought it back to her? Maybe you should ask her.");
					addButton(4,"Scepter",Scepter2);
				}
				//just a hint
				if (player.hasCock()) addButtonDisabled(5, "Date", model.time.hours == 20 ? "Another time, perhaps?" : "Try visiting the bar in the late evening. :)");
			}
			addButton(1,"You",cleansedValaRepeatBrainFucking);
			addButtonIfTrue(2, "Cum Bath", valaCumBath, "Req. a cock.", player.hasCock());
			if (SceneLib.shouldraFollower.followerShouldra() && !player.hasStatusEffect(StatusEffects.ShouldraOff)) {
				if (flags[kFLAGS.SHOULDRA_MET_VALA] > 0)
					addButton(3, "Big You", valaBigYou).hint("Shouldra is always ready for some madness.");
				else addButtonDisabled(3, "???", "Vala is small. Very small. Maybe talk to Shouldra about her, even though she prefers <i>big</i> things?");
			}
			else addButtonDisabled(3, "???", "Req. spending more time with <i>ghosts</i>.");
			addButton(14,"Leave",SceneLib.telAdre.barTelAdre);
		}

		public function cleansedFirstRemeet():void {
			spriteSelect(SpriteDb.s_vala);
			clearOutput();

			outputText("When Vala finishes delivering drinks and making sure everybody is set, she lets the bartender know that she'll be taking a break and leaves her apron behind the bar. She leads you to a store room in back and closes the door behind you. Offering you the only chair in the room, a low, wide stool, she seems content to flutter in the air while the two of you talk, her obscene strength making constant flight trivial.  ");
			//(NAGA/CENTAUR
			if(player.isTaur() || player.isNaga() || player.isDrider()) outputText("You eye the stool doubtfully, but she seems insistent, so you lower your body onto the wooden seat and are surprised when it manages to support your upper torso with only a small groan of protest. You fold the rest of your lower body behind you.  ");
			outputText("She explains how, after coming to, she tried to return to the deepest section of the forest, where her sisters lived. Even though they were willing to take her in, it was clear she no longer belonged amongst them. It was sheer chance that she stumbled upon one of her sisters who was making a trip to Tel'Adre for unrelated business. When she followed the other girl into the Wet Bitch, the urge to reclaim her life surged in her gut and she asked for a job on the spot. It turned out her wings made the job much easier on packed nights, when the patrons get a little too clingy or the more endowed customers' engorged organs would trip a less aerial serving girl.\n\n");

			outputText("In turn, she listens to you relate your latest adventures eagerly, gazing a little too deeply into your eyes and laughing a little too hard at your jokes. Before too long, it's clear the girl has one thing on her mind. She reaches a hand out and touches your shoulder gently. \"<i>Surely you didn't think the drink would be your only reward?</i>\" she murmurs, windy voice husky with desire. Her pink eyes stare into yours, no longer lost to mindless lust, but full of want and intellect, a doll no longer.\n\n");

			outputText("\"<i>I've been looking forward to this,</i>\" she whispers, flying up to steal a kiss from you, her soft, fey lips leaving a taste of pure, spring rain on the tip of your tongue. Piece by piece, she strips the clothes from your shoulders and hips, leaving warm kisses on your exposed skin with every piece she removes. When your body is laid bare before her, the pixie raises her hands to her own dress. She hesitates to expose the permanent scars the imps left on her, but sighing, she laughs and a sweet wind sweeps through the storeroom. \"<i>Silly to be bashful around you, of all people,</i>\" she chuckles, sliding out of her verdant silk, pulling pins from her bun to let long, violet tresses spill down her shoulders with a shake of her head. She bats her eyes at you over one shoulder and flashes a wry little smile. \"<i>If we can replace every hash mark on my back with one of your visits, I'll switch to backless dresses,</i>\" she teases. Flying over you, she lands her delicate legs and plump, breeder's rear in your lap, wrapping her arms around your shoulders and hugging you tightly. \"<i>So, what's on your mind, hero?</i>\"");
			//[You][Leave]
			simpleChoices("You",cleansedValaFuckHerBrainsOut,"", null,"", null,"", null,"Leave",SceneLib.telAdre.barTelAdre);
		}

		//[You]
		public function cleansedValaFuckHerBrainsOut():void {
			spriteSelect(SpriteDb.s_vala);
			clearOutput();
			sceneHunter.print("Height forks: 4'11\"-, 5'- 6'2\", 6'3\"+");
			sceneHunter.selectGender(dickF, vagF);
			//==============================================
			function dickF():void {
				outputText("You don't even have to speak, she reads your desire as plainly as you can read hers. She flutters her wings in eager anticipation as she slides her hands up your chest and over your arms, thumbs tracing the curve of your muscles while fingertips dance across your " + player.skinFurScales() + ". With anxious quickness, she gently caresses your body with every breath. Vala leans in to kiss your neck and shoulders while shifting to straddle you, her enormous breasts hotter than her kisses as she presses into you. She savors the nearness for a long moment, just feeling your heartbeat against hers, sighing happily in your arms, before she wraps her legs around your waist and begins to grind her ass into your crotch. Time has not abated the torrential flow of clear lube leaking from her aroused pussy, and your lower body is soaked by her rose-petal labia, her ample rear spreading the warm liquid across your lap and over your stiffening length. You hiss in teased excitement and reach your hands across her broad, breeder's hips to clutch her bubble-bottom cheeks. She rocks up and down, her drooling lower lips sucking at your shaft with each motion, heat pouring out of her cunny.\n\n");

				outputText("Feeling your straining body, hard against hers, she runs a hand through her purple hair, spilling it across half of her face. \"<i>I want you to enjoy this as much as I will.</i>\" Vala reaches a hand between her legs and slides against your abdomen, guiding your [cock] into her pussy. The fae's labia practically breathes the heat of her uterus across your twitching shaft and you slide through her well-lubricated depths with a moist sigh, her inhuman snatch tight with her passionate yearning. She rocks back and forth barely an inch at a time, but it's enough to ignite a manic need in your loins. ");
				//[2 dicks-
				if(player.cockTotal() > 1) outputText("\"<i>Fairies don't exactly crap rainbows, but we're not quite like normal humans either,</i>\" she grins, taking your " + cockDescript(1) + " and pressing it against her pudgy butt, her pink sphincter loosening just enough to slip your cockhead inside the fairy's body before it clenches down. It almost feels like she's got a hand inside of her ass; the walls ripple with expert coordination, rings of muscle clenching and loosening with a dexterity that takes the breath from you. Your tip, sealed just inside her posterior, is milked with a tight grace that has your body twitching before you realize it.  ");
				//3+ dicks-
				if(player.cockTotal() >= 3) outputText("Vala takes a deep breath, letting the feeling of your meat inside her gut stoke the fires of lust growing in her belly. \"<i>I think there's a little room left, if you're game,</i>\" she whispers, moving to your " + cockDescript(2) + ". She bites her lower lip and forces herself down on it, squeezing your two shafts together in her well-lubed love tunnel. The feeling of your straining lengths inside her triple-stuffed body is an ecstatic agony that robs you of words and your body thrusts helplessly, Vala's breeder hips grinding in fleshy ripples, her lower torso swollen with cock.  ");
				outputText("You try to hold back the orgasm, but it's too late and your cock explodes inside the fairy's unearthly womanhood.\n\n");

				outputText("She coos into your ear as her as muscles release her vice-like grip long enough to slam her rump down on the rest of your length, swallowing every inch in the blink of an eye, her body swelling up with your girth. Parked at your base, she clenches again and begins to stroke your cock");
				if(player.cockTotal() > 1) outputText("s");
				outputText(" from base to tip with her inner walls. Biting her lower lip, she grinds her pussy against your waist as your seed slowly fills her nethers. Her disproportionately huge tits drool with milk and you take her nipples in each hand, pressing tightly with your forefingers and thumbs until small white streams jet out of her overburdened chest. She leans backward in ecstasy and her arcing spray splatters against your lips, tantalizingly. You open your mouth and begin lapping at the streams, a buttermilk richness sending revitalizing clarity through your body. Fatigue fades, your mind clears, and your blood pumps with renewed vigor, reanimating your flagging erection. Suddenly, the pressure of her cum-drenched, sucking loins becomes a stimulation that grabs your brain through your crotch. You can feel every inch of your prick");
				if(player.cockTotal() > 1) outputText("s");
				outputText(" being stroked and suckled by the fey girl's muscles and you tighten your grip on her nipples, intending to earn this orgasm.\n\n");
				player.sexReward("vaginalFluids", "Dick");
				doNext(dickF_2);
			}
			//[Female Growth scene]
			function vagF():void {
				outputText("You run your hands over Vala's flawless skin, fingertips tracing the seemingly frail girl's bone structure around her shoulders and down her thin arms before your hands circle round her inflated bosom, yielding flesh hot with the thundering heartbeat inside her chest. She gasps at the feel of your hands on her sensitive skin and giggles when you move your fingertips to her areolas, coin-sized pink buttons that shimmer with the strange, otherworldly glow of daylight that her body seems to radiate. Her nipples are already stiff from your teasing and you stroke the hot bulges with your thumbs, moisture bubbling under your touch. She draws in breath between her teeth and squirms in your lap, her rose-petal pussy drooling across your " + hipDescript() + " as she runs her hands through your " + hairDescript() + ". She pushes against you, stroking your " + nippleDescript(0) + "s with her hard nubs, pressing her wobbling breasts against your [allbreasts]. The heat pouring off the little fairy girl's body is incredible and you can feel a dampness growing in your " + vaginaDescript(0) + ".\n\n");

				outputText("Still in your lap, she swings her legs around yours and braces herself with one hand around your neck and the other on your knees. Sliding back and forth, she strokes her pussy against yours, the slick folds of her labia rubbing against your " + clitDescript() + " with wet squishing sounds, sending electric shivers up your spine. You begin to rock back, in time with her motions, your stiff clit stroking hers in tight circles that leave the fairy panting, her legs clenching and unclenching around your [butt]. The two of you jill against the other's joy buzzers until your bodies tremble with orgasm, the fairy sliding her hand from your neck to one of your heaving breasts, squeezing a nipple between her second knuckles hard enough to make you squeak with pain.");
				//[Lactating-
				if(player.biggestLactation() >= 1) outputText("  The pressure is enough to draw your milk to the surface, tiny jets splashing between the two of you as the fairy milks you with two incredibly agile fingers.");
				outputText("\n\n");

				//[Short characters- 3'- 4'11"]
				if(player.tallness <= 59) {
					outputText("The fairy, catching her breath between rolling her tender lower lips against yours, gets a wicked grin on her face and leans in with a whisper. \"<i>Let's do it like they do in the forest,</i>\" she suggests, flicking her dragonfly wings to life. With a fluttering motion, she lifts off of you, flips upside down, and buries her head between your " + hipDescript() + ", pink lips pressed against your " + vaginaDescript(0) + " in a shower of warm kisses.");
					if (flags[kFLAGS.VALA_HEALED_HONEY] == 1) outputText("  You, in turn, take her legs around your temples and rub your nose against her juicy snatch, the fragrance of summer as intoxicating as any of the bottles around you. Your mind goes fuzzy for a moment and you suspect that your pure honey cure may have had some lingering effects on the over-grown girl. She wraps her arms around your [butt] and you mirror the grip just as she flaps harder, carrying the two of you into the air, locked in each other's love tunnels.\n\n");

					outputText("Her long tongue remembers your body all too well, flicking your tender clit with just enough force to get your walls pulsing before she slides inside of your " + vaginaDescript(0) + ", lapping up your girl cum, exploring every bumpy recess of your twitching pussy. You are practically inundated by the girl's slippery slit, her sweet nectar gushing around your lips and into your nose as she slowly rolls the two of you through the air in an elegant dance, bodies entwined in passionate feasting, losing yourself to a symphony of glistening, pink flesh. After who knows how many climaxes the girl licks out of your sensitive snatch, she gently lands the two of you on the floor, still nuzzling in your coupled embrace. You'd lost track of how much of her earthy lubrication you've swallowed, but feeling the solid ground beneath you makes you aware that your belly jiggles with a surprising heaviness, like you've spent the night drinking gallons of honey wine. Vala slides her legs down your body, rubbing her still juicy cunny across your [skin.type] until she has righted herself to give you a big, wet kiss, your clear cream still moist on her lips. \"<i>I wish we could do that every night,</i>\" she sighs, happily.");
					player.sexReward("vaginalFluids", "Lips");
					player.sexReward("saliva", "Vaginal");
				}
				//[Medium characters- 5'- 6'2"]
				else if(player.tallness < 74) {
					outputText("The fairy, catching her breath between rolling her tender lower lips against yours, adopts a sultry expression and leans in with a whisper. \"<i>Kiss me, you sweet girl.</i>\" You lean down and press against the small fairy, her desire pouring from her eyes in an ocean of pink lust. You kiss the girl softly, your lips trespassing on hers, panting breaths traded between the two of you as hands seek each other's pleasure centers. Yours go to the small girl's heavy breasts, wobbling with their unmilked bounty and you stroke their yielding surface, savoring the weight in your palms and the stiff excitement of her nipples between your fingers. Her hands find your " + vaginaDescript(0) + " and Vala's fingers play across your lower lips, fingertips tracing the curves of your labia's plump ruffles, thumbs flicking your " + clitDescript() + " to life with a jarring shock that makes you gasp mid-kiss. The fairy pounces on the opening, her tongue tracing the line of your open lips before sliding into your mouth with a fierce boldness, the warm muscle wrapping around your tongue, filling your mouth with the hot moisture of the fairy's blossom-sweet breath. You return the force of her caress, one hand seeking her drooling cunt, eager to return in full the trembling climax she's coaxing from you.\n\n");

					outputText("Slipping a few fingers into your " + vaginaDescript(0) + " teasingly, she raises her other hand to your [allbreasts], fondling your sweating flesh with a practiced skill she definitely didn't learn while in the captivity of the imps. She demonstrates a bit more of her Forest knowledge when she squeezes all four thin, warm fingers into your pulsing pussy and, stroking along the top of your love tunnel, she locates your g-spot almost immediately.  You bite your lower lip and send your own fingers into her cunny, your thumb making small circles around her tiny clit while you alternate pumping your fore and middle finger out of her vagina. She's simply more experienced, however, and her inner caresses trace patterns of sensations inside your body that you didn't realize you could feel and your muscles go weak as you crescendo under the fairy's expertise. She breaks your kiss, a long drooping bridge of spittle joining your mouths, and gently shooshes your whimpering by lowering your head to her breast. You meekly take a nipple into her mouth, your climax still sending electric waves of toe-curling tension through your body, and suckle at her bloated mounds, slurping down Vala's sweet buttermilk cream. When her fingers finally release you from your mind-blowing orgasm, you find that your " + vaginaDescript(0) + " has spilled a large puddle of warm, clear girl lube all over the stockroom floor- far more girl cum than you've ever produced. Vala lifts her jilling hand to her lips and sensually licks one finger after the other, her pink eyes bright with the mischief of the fae.\n\n");
					player.sexReward("milk", "Lips");
				}
				//[Tall characters- 6'3"+]
				else {
					outputText("The fairy, catching her breath between rolling her tender lower lips against yours and panting with desire, leans in with a whisper. \"<i>I need to taste you,</i>\" she confesses, \"<i>to know the nourishment of humans.</i>\" You nod, wrapping an arm around the girl's narrow waist and haul her up to your bosom. She nuzzles against your [allbreasts] her purple hair cascading around your [skin.type] with a glimmering sparkle of pink amid violet. \"<i>My chest is so heavy,</i>\" she whines softly, her supple breasts pressing against yours. She flutters her wings and lifts out of your embrace just enough to turn upside down in the air, her hair spilling into your lap and her mammoth jugs hanging heavily around her chin. \"<i>Please,</i>\" she whispers as she strokes your [allbreasts] with her tiny nose, delicate lips kissing your " + nippleDescript(0) + ". You wrap your hands on either side of her breasts and squeeze them together until her stiff, pink nipples touch and you bring your mouth forward, tongue flicking the milky flesh before drawing both into your lips with relish. Her mammaries begin to leak immediately, filling your mouth with the rich, decadent taste of buttermilk, sweet and heavy on your tongue.\n\n");

					//[Not lactating –
					if(player.biggestLactation() < 1) {
						outputText("To your surprise, the mere taste of the girl's milk sends a fluid pulsing through your chest and you can feel your breasts filling with milk! You have begun to lactate!  ");
						player.boostLactation(3);
					}
					outputText("Vala's lips, perhaps trained to please imp cocks, are tighter on your " + nippleDescript(0) + " than you would've believed possible, suckling milk from your depths. With a breathtaking mixture of pressure and softness, she nurses your breast more efficiently than any machine, your warm milk filling her hungry maw in short order. She nurses at each breast in turn, bringing each one to frothy lactation faster than the last until your chest is heaving, your breasts jiggling, and your body clenching down in a shivering climax. Your orgasm leaves you unprepared for the fairy girl's and when her body starts quivering, her breasts flood your mouth with more milk than you can handle. Even swallowing as quickly as you can, it runs through your lips and even up your nose in two twin jets of pale alabaster that leaves your nostrils wet with the lingering scent of honey wine. Sweating and still leaking milk, she rights herself and lands, cupping her breasts with one hand and stroking the paunch of her tiny stomach with the other. \"<i>Ooo... so full. I hope I was as good for you as you were for me,</i>\" she coos.");
					player.sexReward("milk", "Lips");
				}
				doNext(vagF_2);
			}
			//==============================================
			function dickF_2():void {
				clearOutput();
				outputText("Vala leans way back and grabs the edge of the stool while she locks her legs behind your waist, the fairy's startling strength pinning the two of you together. She slaps her generous butt onto your dick in long, slow motions, making sure you feel every inch of her rippling passage");
				if(player.cockTotal() > 0) outputText("s");
				outputText(". You tweak her nipples harder with each thrust, pale cream spurting in increasingly erratic arcs as her heavy breasts grow light pink from the bouncing of her ride. She clenches her eyes shut and wraps her arms under yours, hands clutching your shoulders with desperate rapture.\n\n");

				//[Short characters- 3'- 4'11"]
				if(player.tallness <= 59) {
					outputText("If the blissful expression across her face is any indication, the girl has begun to lose herself in the joy of sex again, her wings fluttering on their own. You keep thrusting, but are alarmed when she begins to pull the two of you off the stool and into the air, oblivious to the world beyond the space between her legs. You grab her broad flanks and try to get her attention by calling her name. \"<i>Oh yes!</i>\" she moans. \"<i>Say my name!</i>\" Her body seizes in a clenching climax that squeezes your hips into hers and she embraces you with a fiery passion that crushes the breath from your lungs. \"<i>Oh, Vala! Yes! I'm no one's Bitch! Vala! Vala!</i>\" she screams from the depths of her euphoria, her sex erupting in a cascading torrent of shimmering fairy cum.\n\n");

					outputText("You're helpless in the orgasming fairy's arms and just let yourself go, grabbing one of her tits and sucking with all the force your chest can muster. Pain and fear fall away as the silky butter-cream washes down your throat and you cum inside the girl with long, slow thrusts, her iron embrace becoming velvet as your seed soothes the fires burning at the edge of her mind, easing her back from the edge of lusty oblivion. Panting, she slowly lowers the two of you back to the ground, her cheeks red from embarrassment as much as exertion.\n\n");
				}
				//[Medium characters- 5'- 6'2"]
				else if(player.tallness < 74) {
					outputText("If the blissful expression across her face is any indication, the girl has begun to lose herself in the joy of sex again, her wings fluttering on their own. You keep thrusting, but are alarmed when she begins to pull the two of you off the stool and to your feet, oblivious to the world beyond the space between her legs. You grab her broad flanks as aimless wings drag the two of you on a drunken dance around the stockroom, and it's all you can do to keep the fairy's wild bucking from crashing into the shelves of bottles on the walls. You try to get her attention by calling her name but she just moans, \"<i>Oh yes! Say my name!</i>\" Her body seizes in a clenching climax that squeezes your hips into hers and she embraces you with a fiery passion that crushes the breath from your lungs. \"<i>Oh, [name]! Fuck me, hero! Fuck Vala!</i>\" she screams, her sex erupting in a cascading torrent of shimmering fairy cum.\n\n");

					outputText("You drag the orgasming fairy to a sturdy cask of beer and slam her against it, rocking the huge barrel with every thrust until your orgasm erupts with hard, short thrusts, the girl's iron embrace becoming velvet as your seed soothes the fires burning at the edge of her mind, easing her back from the edge of lusty oblivion. She moans and pants slowly, delight coloring her cheeks pink at the feeling of your jizz filling her. She pulls your head down to her chest and you nuzzle your face against her sweat-slick breasts, licking and suckling the fae girl's nectar from her heaving, overinflated tits. As the silky buttermilk cream washes down your throat, it adds a pleasant tingling to your slow, wet pumping, giving you a gleeful, light-headed satisfaction. Regretfully sliding out of her cum-dripping body, you carry the featherweight girl in your arms, back to the stool, bending to one knee to setting her down, Vala's cheeks pink from joy as much as the heart-pounding tryst.\n\n");
				}
				//[Tall characters- 6'3"+]
				else {
					outputText("If the blissful expression across her face is any indication, the girl has begun to lose herself in the joy of sex again, her wings fluttering on their own. You keep thrusting, but are alarmed when Vala's wings, oblivious to the world beyond the space between her legs, begin to overpower her legs, almost pulling the two of you apart. You grab her broad flanks and crush her into your broader hips, muscles straining against her supernatural flight. She wriggles in your embrace joyfully, bouncing harder with each passing second. Your arms begin to tire and you curl your body around her, wide shoulders and massive chest encircling the tiny girl in a bear-hug to keep her orgasmic fluttering in check. Trying to get her attention, you call Vala's name, your chest vibrating her head with the sound of your voice. \"<i>Yes,</i>\" she moans, \"<i>say my name...</i>\" Her body seizes in a clenching climax that squeezes your hips into hers and she grasps at you with a small, fiery passion that brings a blush to your cheeks. \"<i>Vala's big, strong hero...</i>\" she whimpers from the depths of her euphoria, her sex erupting in a cascading torrent of shimmering fairy cum.\n\n");

					outputText("Your limbs entwined, you let the helpless, orgasming fairy's hands fondle your shoulders and back as you draw your knees up, enveloping Vala in a full body embrace, her loins milking with every ounce of strength left to her. A flush of pride and nurturing compassion fills your heart even as your own crescendo erupts, linking the two of you in a creamy bond of shivering passion. She nestles in the hollow of your lap, panting with every pulse of jizz you pump into her, nuzzling your chest, perfectly at ease in your ");
					//
					if(player.biggestTitSize() < 1) outputText("chest");
					else outputText("bosom");
					outputText(". Your seed soothes the fires burning at the edge of her mind, easing her back from the edge of lusty oblivion. When you finally uncurl from around her, she shivers, missing the blazing body heat and looks up into your eyes, pink irises sparkling. You understand her unspoken request instantly and you bend down to press your lips against her breast, suckling one milk-laden tit, then the other, soothing the girl's swollen mammaries, buttermilk cream rich on your tongue. Gradually, the two of you separate.\n\n");
				}
				//[All characters]
				outputText("Vala's irrepressible energy is restored in short order, and she re-dresses swiftly, barely noticing the tiny milk spots staining her green dress or the thin trail of cum leaking between her legs as she flutters a foot off the ground. She gives you a kiss on the cheek and winks affectionately. \"<i>Visit me any time, okay [name]? For a free drink or... anything else,</i>\" she winks. She bundles her hair back up into a sensible bun and flies out of the stockroom, ignoring the curious glances that follow her as she retrieves her plain apron. ");
				if (ValaFairyQueenQuest == QUEST_STAGE_PCDACCEPTED)
					outputText("You sigh appreciatively and retrieve your own clothes.");
				else
				{
					outputText("You sigh appreciatively and retrieve your own clothes only to find that you've grown! Whatever growth drug the imps gave to Vala must not be entirely out of her system, because her milk seems to have added an extra inch to your frame.");
					if(player.tallness >= 120 && player.tallness < 132 && rand(player.tallness-119) > 0) {
						outputText("\n\nOr was that just your imagination?  On closer examination you're not any bigger, but you were huge to begin with!");
						player.tallness--;
					}
					if(player.tallness >= 132) {
						outputText("\n\nOr was that just your imagination?  On closer examination you're not any bigger, but you were huge to begin with!");
						player.tallness--;
					}
					//[Player grows 1", lust drops to 0, corruption drops by 1]
					player.tallness++;
					if(player.cor > 40) dynStats("cor", -.3);
				}
				advanceMinutes(30);
				doNext(SceneLib.telAdre.barTelAdre);
			}
			function vagF_2():void {
				clearOutput();
				//[All characters]
				outputText("Vala's irrepressible energy is restored in short order, and she redresses swiftly barely noticing the tiny milk spots staining her green dress or the thin trail of lubrication leaking between her legs as she flutters a foot off the ground. She gives you a kiss on the cheek and winks affectionately. \"<i>Visit me anytime, okay [name]? For a free drink or... anything else,</i>\" she winks. She bundles her hair back up into a sensible bun and flies out of the stockroom, ignoring the curious glances that follow her as she retrieves her plain apron.");
				if (ValaFairyQueenQuest == QUEST_STAGE_PCDACCEPTED)
					outputText("You sigh appreciatively and retrieve your own clothes.");
				else
				{
					outputText("You sigh appreciatively and retrieve your own clothes only to find that you've grown! Whatever growth drug the imps gave to Vala must not be entirely out of her system, because her milk seems to have added an extra inch to your frame.");
					if(player.tallness >= 120 && player.tallness < 132 && rand(player.tallness-119) == 0) {
						outputText("\n\nOr was that just your imagination?  On closer examination you're not any bigger, but you were huge to begin with!");
						player.tallness--;
					}
					if(player.tallness >= 132) {
						outputText("\n\nOr was that just your imagination?  On closer examination you're not any bigger, but you were huge to begin with!");
						player.tallness--;
					}
					player.tallness++;
					//[Player grows 1", lust drops to 0, corruption drops by 2]
					if(player.cor > 40) dynStats("cor", -.5);
				}
				advanceMinutes(30);
				doNext(SceneLib.telAdre.barTelAdre);
			}
		}
		//[You]
		public function cleansedValaRepeatBrainFucking():void {
			spriteSelect(SpriteDb.s_vala);
			clearOutput();
			outputText("She flashes a beautiful smile and tells the bartender that she'll be taking her break early. Grabbing you by the hand, she rushes to the stockroom and sheds her dress without any trace of her former shame about her tattooed back. When you're too slow taking off your [armor], she helps, deft hands made all the quicker by eagerness. When the two of you are naked, she pushes you onto the well-worn stool and sits in your lap, staring into your eyes with a small smile.");
			//[Next] (go to Growth scene)
			doNext(cleansedValaFuckHerBrainsOut);
		}
		//[Fairies]
		public function faerieOrgyFuck():void {
			spriteSelect(SpriteDb.s_vala);
			clearOutput();
			outputText("Vala giggles and nods to the bartender to indicate she'll be taking her break. Taking you by the hand, she flutters upstairs to one of the far rooms of the tavern. When she opens the door, you're startled to find the room is virtually filled with fairies. Unlike Vala, they're the type you're more used to seeing- three to four inches tall, the girls are clothed in shiny black leather straps and wear tiny sable stockings tipped with crystalline heels. There's quite a variety of them and dozens of eyes settle on you as Vala pulls you into the room, closing the door behind you. \"<i>These are my sisters, from the deep forest,</i>\" she introduces. \"<i>In my state, a monster or other predator of the woods would surely catch me or, worse, use me to lure my sisters to danger. But with a few complimentary bottles of whiskey, the captain of Tel'Adre's city guard was willing to give them passage to visit me in the city once a week, as long as they stay out of mischief.</i>\" The fairies lift off and buzz around you, teeny voices introducing themselves, asking your name, marveling at your huge muscles, or otherwise fawning over you. It's a bit much, truth be told.\n\n");
			outputText("You thank Vala for introducing you, but you've really got to be going, you claim. Demons to defeat, maidens to rescue, all that. The large fairy chuckles and gives you a squeeze. \"<i>You're so cute when you're flustered. Don't worry, we're not going to all jump you at once- you'd probably end up like I did! No, I asked my sisters here to help me with a little forest magic. Don't you want to see how fairies masturbate?</i>\" You're a little taken aback by the question, but you nod all the same. \"<i>All right girls, the petals please.</i>\" The cloud of fairies in front of you disperses, each winged vixen scattering to different corners of the room to retrieve hidden flower petals. Each blossom, you note, matches the hair color of the fairy holding it, creating a dizzying array of  hues as they form circles around the two of you. Vala guides you to the bed and gently removes your [armor] before instructing you to lie down.\n\n");
			flags[kFLAGS.WEEKLY_FAIRY_ORGY_COUNTDOWN] = 6;
			//[Herm]
			if(player.gender == 3) {
				outputText("Vala folds her arms across her breast. \"<i>But which one should we use?</i>\" she ponders. \"<i>I wouldn't advise trying both- your mind wouldn't be able to take it. You'd end up worse than just mind-broken, you'd be a drooling shell. And I'd never do that to my hero,</i>\" she smiles and gives you a wink. \"<i>So, what would you prefer?</i>\"\n\n");
				simpleChoices("Male",faerieOrgyFuckMaleContinue,"Female",faerieOrgyFuckFemaleContinue,"", null,"", null,"", null);
			}
			else if(player.gender == 2) doNext(faerieOrgyFuckFemaleContinue);
			else if(player.gender == 1) doNext(faerieOrgyFuckMaleContinue);
		}
		//[Worries]
		public function Worries():void {
			spriteSelect(SpriteDb.s_vala);
			clearOutput();
			outputText("She seems worried for some reason and so you ask her about it.\n\n" +
					"\"<i>Oh! I’m kind of sorry. It’s just that we fairies have lost our queen. Without the queen there is no one to protect us or safeguard our future.</i>\"\n" +
					"But you saved her. As a champion your duty is to defeat the demons and protect the innocent. Wouldn't she and the fairies agree that they are not without a hero even in these dark times?\n\n" +
					"\"<i>You do not understand, without the queen to lead us all. The fairies are slowly losing their will to resist and begin to abandon themselves to corruption. Before long the demons will have enslaved my race and turned us all into fiendish sex starved creatures just like the goblins were.</i>\"\n\n" +
					"This is terrible! You ask her what you can do to save the fairies.\n\n" +
					"\"<i>A little before the previous queen was slain by the demons her badge of office and weapon was broken in battle, and a few malevolent sprites escaped with the parts of the legendary pixia scepter. Without this item we cannot crown a new queen. Should you recover the fifteen lost parts of the scepter we would forever be in your debt.</i>\"\n\n" +
					"You tell Vala that you will try then head off to camp.\n");
			ValaFairyQueenQuest = QUEST_STAGE_STARTED;
			doNext(camp.returnToCampUseOneHour);
		}
		public function Scepter():void {
			spriteSelect(SpriteDb.s_vala);
			clearOutput();
			outputText("You deposit the fifteen shards of the scepter before Vala, who looks at you with complete awe.\n\n" +
					"\"<i>What you did today might have just saved the fairies. I will bring these back to my sisters and let you know about the developments!</i>\"\n\n" +
					"With that said, she picks up the scepter and head out as you go back to camp.");
			player.destroyItems(useables.S_SHARD, 15);
			ValaFairyQueenQuest = QUEST_STAGE_ITEM_TURNEDIN;
			doNext(camp.returnToCampUseOneHour);
		}
		public function Scepter2():void {
			spriteSelect(SpriteDb.s_vala);
			clearOutput();
			menu();
			if (player.isFemaleOrHerm() && (player.isPureHuman()) || player.isRace(Races.ELF, 1, false)) {
				outputText("Vala spots you from a distance and flies to you right away.\n\n" +
						"\"<i>[name] I have great news! The new fairy queen has finally been chosen!</i>\"\n\n" +
						"You idly ask if you could meet her.\n\n" +
						"\"<i>Well that's where things get complicated, just follow me…</i>\"\n\n" +
						"Vala escorts you all the way to the woods where you spot an unusual amount of fairies watching you. You both enter what looks to be a grove. You can see small bubble of energy slowly flying up from the ground and deduce the place is highly magical. Vala turns to face you looking somewhat embarrassed.\n\n" +
						"\"<i>[name] when we first met, I wanted to thank you for saving me from those imps. While we have had sex many times, I never could really feel like it was enough to let go of my debt to you. Today I’m actually telling you something very few humans have ever been told. We, the fairies would like you to become our champion.</i>\"\n\n" +
						"Sure why not, you're already trying to save Mareth anyway.\n\n" +
						"\"You don’t understand. What the fairies agreed to is that YOU should be the next queen.\"\n\n" +
						"Whoa, wait, what?! You never agreed to anything of the such! Can’t you at least be allowed to make the choice.\n\n" +
						"\"<i>I know this is a lot to take in, but take a deep breath and make a choice. Will you become the next great fairy, queen of fairykind?</i>\"\n\n" +
						"How could you even become the queen of the fairies. You’re way too big to become a fairy to begin with. Vala laughs, but explains.\n\n" +
						"\"<i>Out of all the fairies the queen is the only one to naturally reach your size. Fact is, we fairies need a big elder sister like you to protect us since our diminutive size won’t allow us to protect ourselves.</i>\"\n\n" +
						"Why not her, a true fairy, become the next queen?\n\n" +
						"\"<i>It wouldn’t come as a secret to anyone that my body has been and still is corrupted. That, and this is not my original size. The fairies need someone like you who is still pure of mind and body to protect them. So, will you accept?</i>\"\n\n" +
						"It seems you have an important choice to make, what will you do?");
				addButton(1,"Accept",Accept);
				addButton(2,"Decline",Decline);
			}
			else
			{
				outputText("Vala spots you from a distance and flies to you right away.\n\n" +
						"\"<i>[name] I have great news! Thanks to your efforts in recovering the shards we managed to repair the scepter. The new fairy queen is still in the process of being chosen but this is just a matter of time! If only we had a human or an elf female we could believe into... Regardless it's all fine [name] you already did plenty for us.</i>\"\n\n");
				doNext(SceneLib.telAdre.barTelAdre);
			}
		}
		public function Accept():void {
			spriteSelect(SpriteDb.s_vala);
			clearOutput();
			outputText("While this is a great honor, maybe too much for a human you still nod in agreement. Vala hugs you right away.\n\n" +
					"\"<i>Thank you! Thank you so much, you cannot grasp how much this means to us. Once you are ready, go lay down in the big red flower there and your coronation will begin.</i>\"\n\n" +
					"Not one to waste time, as instructed by Vala you lay down in the giant orchid. The flower is surprisingly comfortable for a plant, you could almost mistake it for a comfy velvet bed, and so you slowly drift to sleep as the petals close on you.\n\n" +
					"You dream of a beautiful world from before the age of the demons as you walk in a floral palace filled with echoes of laughter and cheers. Small fairies fly from one side to another, singing while carrying foods, flowers, and various items. At the back of the room is a figure of greater size. Sitting on a crystalline throne is a woman who wields no crown yet has the presence of royalty. While bigger in size than her sisters who fly in this otherworldly palace she is nonetheless a fairy and only one word comes to your mind to describe her… queen. This fairy sports a pair of colorful translucent butterfly wings, which stretch six feet wide on a mature, almost perfect body not unlike that of an elf. Her regal visage turns toward you and looks straight in your eyes as if peering at the depth of your soul. It is only as you realise this royal figure was a beautified version of yourself all along that you slowly open your eyes, waking up with a loud yawn. The flower feels bigger than what you remembered it to be and so you slowly part away the petals so to let the light of the sun filter in. To your surprise, it's not the flower that got smaller but your body that got slightly bigger. While your overall shape did not change that much your body took on a more fragile and graceful version of itself, almost a mimicry of that of the elves. Your unblemished skin and refined limbs wouldn't look out of place on a nymph, not to mention your elf like pointed ears. However, what really sets you apart from a human is your shiny, almost translucent hair, in which many beads of morning dew shine like beautiful gems, and your large, colorful butterfly wings easily twice as wide as your stretched arms. You flap them a few times with childlike curiosity and only stop short of taking flight. While admiring your new body you can't help but wish the flower was just a little bigger and to your surprise you actually shrink in size. Afraid as the world suddenly becomes bigger around you, including dog sized bugs you swiftly return to normal realizing that you can now shrink and grow back to human size at will. Heck, this is only a fragment of your new powers as you begin exploring the many fae magical abilities you acquired. After a few minutes, satisfied with your inspection, you finally take the time to gaze beyond the flower back to your waiting subjects. These fairies need a champion and a leader to fight for and rule them, you won’t let the fairies or Vala down. Lethice shall be defeated and the fairies protected! A few fairies come over to you carrying a human sized dress that could actually fit you just right. It's light but... perhaps a little skimpy? Well at least it won't hinder your flight. Still you are amazed they got it so quickly. To humor them you put the dress on and discover to your delight that it is the dress from the dream. Vala cheers for you right away pulling all the other fairies in.\n\n" +
					"\"<i>All hail [name], new queen of the fairies!!</i>\"\n\n" +
					"The fairies give you an ovation, everyone claps for the new fairy queen. You are in awe before the thousands of butterfly girls cheering for you and while your charge is a big one, you are confident that you will succeed. It's time for you to make good on your promise to them thus you head back out to your adventure ready to face the agents of evil in the name of your people.\n\n");
			ValaFairyQueenQuest = QUEST_STAGE_PCDACCEPTED;
			//Turn pc into a proper fairy
			CoC.instance.transformations.FaceFairy.applyEffect(false);
			player.eyes.type = Eyes.FAIRY;
			CoC.instance.transformations.HairFairy.applyEffect(false);
			player.ears.type = Ears.ELVEN;
			player.tailType = Tail.NONE;
			player.arms.type = Arms.ELF;
			player.lowerBody = LowerBody.ELF;
			player.tongue.type = Tongue.ELF;
			player.wings.type = Wings.FAIRY;
			player.skinType = Skin.PLAIN;
			player.skinAdj = "flawless";
			if (player.hasCock()) player.removeCock(0, player.cockTotal());
			player.skin.coverage = Skin.COVERAGE_NONE;
			var growth:int = 1 + rand(3);
			if (player.breastRows.length > 0) {
				if (player.breastRows[0].breastRating < 2) growth++;
				if (player.breastRows[0].breastRating < 3 && rand(2) == 0) growth++;
				if (player.breastRows[0].breastRating < 4 && rand(3) == 0) growth++;
			}
			player.createPerk(PerkLib.TransformationImmunity2, 4, 0, 0, 0);
			if (player.hasPerk(PerkLib.RacialParagon)) flags[kFLAGS.APEX_SELECTED_RACE] = Races.FAIRY;
			IMutationsLib.FeyArcaneBloodstreamIM.trueMutation = true;
			player.removeAllRacialMutation();
			player.createPerk(PerkLib.QueenOfTheFairies, 0, 0, 0, 0);
			outputText("<b>Gained Perk: Queen of the Fairies!</b> "+PerkLib.QueenOfTheFairies.desc());
			outputText("\n\n");
			CoC.instance.mainViewManager.updateCharviewIfNeeded();
			inventory.takeItem(armors.FQR, camp.returnToCampUseOneHour);
		}
		public function Decline():void {
			spriteSelect(SpriteDb.s_vala);
			clearOutput();
			outputText("You announce your decision to a somewhat disappointed Vala but she nods in understanding.\n\n" +
					"\"<i>It’s ok, [name]. No one will force you to make that choice through I wish you did.</i>\"\n\n" +
					"You wave Vala and the fairies goodbye as you head back to camp. Still you can feel their disappointed eyes on your back as you leave the grove, likely not to return again.\n");
			ValaFairyQueenQuest = QUEST_STAGE_PCDECLINED;
			doNext(camp.returnToCampUseOneHour);
		}


		//[Male]
		public function faerieOrgyFuckMaleContinue():void {
			spriteSelect(SpriteDb.s_vala);
			clearOutput();
			outputText("The fairy girl lands at the edge of the bed, settling on her knees and resting her weighty chest on the mattress. Leaning in, she spreads your [legs] with warm, delicate hands, fingertips stroking the insides of your thighs. You shiver and squeeze the bedspread between your fingers, a little nervous about this 'forest magic.' One of the fairies flutters down to Vala and hands her a pale white lily petal with a tittering giggle. The larger fairy takes the soft white bloom and, whispering a silken word to it, licks the cream-colored surface. Slithering further between your legs, she reaches your [cock] and brushes the petal against your throbbing glans with a teasing caress. Then, much to your surprise, she places it on the tip of her forefinger and places it on the base of your cock. You gasp, the petal's soft surface rubbing sensitive skin with a warmth you were unprepared for. After the briefest delay, you lose your breath as the tremor of a small, barely contained orgasm rumbles through your gut. Without hesitation, the fairy barmaid takes a rose petal and repeats the process, another almost-orgasm seizing you and leaving you panting. \"<i>Normally we only need the one petal, but since you and I are so much larger than the average fairy, I had my sisters bring lots. All for you,</i>\" she whispers, coyly.\n\n");

			//[If the Player has unlocked Scylla's Addiction Counseling event]
			if(flags[kFLAGS.TIMES_SCYLLA_ADDICT_GROUP_EXPLOITED] + flags[kFLAGS.SCYLLA_TIMES_SHARED_IN_ADDICT_GROUP] + flags[kFLAGS.SCYLLA_MILK_THERAPY_TIMES] + flags[kFLAGS.SCYLLA_CUM_THERAPY_TIMES] + flags[kFLAGS.SCYLLA_SEX_THERAPY_TIMES] > 0) {
				outputText("Another fairy flies toward Vala and you blink through the building lusty haze when you recognize the little girl. Wearing a slightly slutty crystalline gown of translucent gossamer, it seems to be Pastie, the fairy from Scylla's addiction counseling meeting. When you call out to her, she bashfully waves back. \"<i>Hey, uh, [name]. It's kinda weird seeing you outside of the meetings. How are you? How have things been?</i>\" She looks at your naked, reclined form on the bed and blushes. \"<i>Oh, right, right. Um. I'm just helping out Vala, you know. Sisters and all. Uh. I'm... I'm going to just give her this petal and get something to drink, okay? All this sobriety is making this really uncomfortable for me.</i>\" The other fairies laugh and Pastie hands off her blossom before zipping out of the room, probably to steal someone's drink downstairs.\n\n");
			}

			outputText("One by one, each of the fairies gives her petal to Vala, and one by one, the largest fairy delicately sticks them onto your [cock]. With each bloom that touches your quivering member, your orgasm builds, never quite erupting from your twitching organ, tearing your self-restraint to shreds. Before long, your teeth are gritted in a steely clench and your eyes are dilated to black pools that make every color around you gleam with a too-bright, lurid hue. Your fingers have given up the bedspread in favor of simply balling into white-knuckled fists and your abdomen aches with the effort of trying to push your seething orgasm out before it suffocates you. Just as your vision is about to black out from the denied climax, Vala takes the final petal and places it atop your urethra, fully covering your [cock]. \"<i>All done,</i>\" her voice cheerful and innocent, like she'd just finished painting a picture rather than stimulating you just shy of breaking your mind.\n\n");

			outputText("The pixie girl gives your shaft a little kiss and places her lips on your cockhead. She puffs her cheeks and whispers a string of strange words into your [cock]. All at once, the soft petals around you meld into one warm, hard case, perfectly mirroring your cock like an organic condom. Your mind explodes as your carefully coaxed orgasm is finally released in one body-shaking crescendo. Every muscle in your body clenches, your cock geysering its torrential gouts of seed into the flower petal condom. Rather than bursting apart, the enchanted device merely swells, drinking your seed and slowly lifting off of your shaft. ");
			//[Balls-
			if(player.hasBalls()) outputText("Vala's tongue caresses your [balls], slurping hungrily, eager to get every drop out of your overburdened sac.  ");
			outputText("You nearly forget to breathe as jizz pours from your body until the dick-shaped shell is entirely forced from your body. Deftly, Vala catches the device before it can spill its load and she pastes her own, much larger, petal on the base, sealing your spunk inside. The verdant shaft, now that it's off your cock, seems to be a dildo perfectly molded to resemble your [cock]. It's a soft pink color, like engorged genitals, and even gently pulses with your every heartbeat.");
			//(Extremely high cum production:
			if(player.cumQ() > 2000) outputText("  Even after driving the condom off of you, your cock continues its gushing orgasm, spurting thick bubbles of jizz into the air, raining down in creamy torrents. The small fairies gleefully dive after the cum globs, making a game of it, trying to catch the gooey globs before they splatter on the bed or carpet.");
			outputText("\n\n");

			outputText("\"<i>You see?</i>\" Vala asks, holding the organic device aloft with a mischievous smile. \"<i>They don't last forever, but while they do, these little toys give us a very intimate connection to loved ones. This way, I can go all week with a reminder of you inside me.</i>\" She gives you a kiss on the lips and the fairies give you a tiny chorus of applause for the entertaining show. It's good that her little friends aren't around more often, you pant to yourself, or you'd be a drooling vegetable in no time.\n\n");
			advanceMinutes(30);
			player.sexReward("saliva", "Dick");
			doNext(camp.returnToCampUseOneHour);
		}

		//[Female]
		public function faerieOrgyFuckFemaleContinue():void {
			spriteSelect(SpriteDb.s_vala);
			clearOutput();
			outputText("The fairy girl lands at the edge of the bed, settling on her knees and resting her weighty chest on the mattress. Leaning in, she spreads your [legs] with warm, delicate hands, fingertips stroking the insides of your thighs. You shiver and hug your arms under your breasts, a little nervous about this 'forest magic.' One of the fairies flutters down to Vala and hands her a pale white lily petal with a tittering giggle. The larger fairy takes the soft white bloom and, whispering a silken word to it, licks the cream-colored surface. Slithering further between your legs, she reaches your " + vaginaDescript(0) + " and brushes the petal against your " + clitDescript() + " with a teasing caress. Then, much to your surprise, she places it on the tip of her forefinger and slides it into your pussy. You gasp, the petal's soft surface rubbing your inner walls with a warmth you were unprepared for. Vala presses lightly on a spot inside your vagina and you lose your breath as the tremor of a small orgasm rumbles through your gut. Without explanation, the fairy barmaid takes a rose petal and repeats the process, another orgasm seizing you and leaving you panting. \"<i>Normally we only need the one petal, but since you and I are so much larger than the average fairy, I had my sisters bring lots. All for you,</i>\" she whispers, coyly.\n\n");

			//[If the Player has unlocked Scylla's Addiction Counseling event]
			if(flags[kFLAGS.TIMES_SCYLLA_ADDICT_GROUP_EXPLOITED] + flags[kFLAGS.SCYLLA_TIMES_SHARED_IN_ADDICT_GROUP] + flags[kFLAGS.SCYLLA_MILK_THERAPY_TIMES] + flags[kFLAGS.SCYLLA_CUM_THERAPY_TIMES] + flags[kFLAGS.SCYLLA_SEX_THERAPY_TIMES] > 0) outputText("Another fairy flies toward Vala and you blink through the building lusty haze when you recognize the little girl. Wearing a slightly slutty crystalline gown of translucent gossamer, you recognize Pastie, the fairy from Scylla's addiction counseling meeting. When you call out to her, she bashfully waves back. \"<i>Hey, uh, [name]. It's kinda weird seeing you outside of the meetings. How are you? How have things been?</i>\" She looks at your naked, reclined form on the bed and blushes. \"<i>Oh, right, right. Um. I'm just helping out Vala, you know. Sisters and all. Uh. I'm... I'm going to just give her this petal and get something to drink, okay? All this sobriety is making this really uncomfortable for me.</i>\" The other fairies laugh and Pastie hands off her blossom before zipping out of the room, probably to steal someone's drink downstairs.\n\n");

			outputText("One by one, each of the fairies gives her petal to Vala and one by one, the largest fairy delicately places them inside your " + vaginaDescript(0) + ". With each bloom that touches your inner walls, another orgasm tears your self-restraint to shreds, until you're drooling onto the bedsheets, tongue lolling out of your mouth, your eyes rolling aimlessly, unable to focus on any one thing for longer than a moment. Your fingers clench the bedspread in white-knuckled bliss and your thighs vibrate around the girl's body, squeezing her like you're trying to stay on an unsaddled horse. Just as your vision is about to roll into a pink oblivion, Vala withdraws her fingers from your recesses and announces, \"<i>All done,</i>\" her voice cheerful and innocent, like she'd just finished painting a picture rather than stimulating you just shy of breaking your mind. You need more than a few minutes to catch your breath, finally coming down from the seeming eternity of rapturous bliss.\n\n");

			outputText("When you finally calm down enough to swallow your spittle, wipe the slick sweat from your face and body, and release the fairy girl from the death-grip between your " + hipDescript() + ", you try to ask what happened to the petals inside your body. The fae girl gives your " + clitDescript() + " a little kiss and places her lips on your pussy. She puffs her cheeks and whispers a string of strange words into your quivering cunt. All at once, the soft petals inside you meld into one warm, hard shape, perfectly mirroring your pussy, labia to cervix. Very carefully, Vala draws the verdant shaft from your body and produces the most intricately ridged, molded dildo that you've ever seen. It's a soft pink color, matching your engorged genitals, and even gently pulses with your every heartbeat.\n\n");

			outputText("\"<i>You see?</i>\" Vala asks, holding the organic device aloft with a mischievous smile. \"<i>They don't last forever, but while they do, these little toys give us a very intimate connection to loved ones. This way, I can go about all week with a reminder of you inside me.</i>\" She gives you a kiss on the lips and the fairies give you a tiny chorus of applause for the entertaining show. It's good that her little friends aren't around more often, you gasp to yourself, or you'd be a drooling vegetable in no time.");
			advanceMinutes(30);
			player.sexReward("saliva", "Vaginal");
			doNext(camp.returnToCampUseOneHour);
		}
		//[Cum Bath]
		public function valaCumBath():void {
			spriteSelect(SpriteDb.s_vala);
			clearOutput();
			//FIRST TIME INTRO
			if(flags[kFLAGS.VALA_CUMBATH_TIMES] == 0) {
				outputText("You chat with Vala for a short while before bringing up a question that's been on your mind: if she's a fairy, does that mean she gets high off of cum?  The question might offend another woman, but in the overgrown fairy's idolizing eyes you can do no wrong.  She doesn't even bat an eye.  \"<i>Oh, possibly.  I mean, it did before I was captured.  I'm not sure if it would still work, now that I'm so much bigger.</i>\"  Then, in a lowered voice intended just for you, she murmurs: \"<i>Though, I always feel a warm tingle from my hero, even if it's just the brush of your fingers on mine.</i>\"  She meets your eyes with a smile like a sunrise.");
				outputText("[pg]Vala seems to be mulling your question over in her mind, her spritely legs rubbing together as she nibbles her lower lip anxiously.  \"<i>Oh, but now that you mention it, I do want to try,</i>\" she giggles.  Placing her hand atop yours, she gives you an affectionate squeeze.  \"<i>Meet me in the back room,</i>\" she whispers, her wings fluttering gleefully as she flies to the bar to put away her apron and let the barkeep know she'll be taking a break.  You can see tiny, glistening droplets of excited lubrication leaking down her thighs and leaving a dripping line of glittering fem-cum on the floor.");
				outputText("[pg]You follow after, finding your way to the storeroom where Vala is waiting for you.  Embracing you tightly, she plants a spritely kiss on your lips and flutters a foot off the ground, her hands on your shoulders.  \"<i>If we're going to try this, we'd better make sure there'll be enough!</i>\" she laughs.  \"<i>After all, I had quite a tolerance built up before you rescued me.</i>\"");

				//[If the player's cum production is under X]
				if(player.cumQ() < 2000) {
					outputText("[pg]\"<i>I have something that might help,</i>\" Vala offers, brightly.  \"<i>A gift from the sweetest little bunny girl.</i>\"  The fairy turns around to sift through some of the articles in the store room before producing a thin vial of glistening oil that smells faintly of strawberries.  \"<i>She mentioned that this batch wasn't powerful enough and was just going to throw it out, but I hate to see anybody's hard work go to waste, so I offered to pay her for it.</i>\"  Vala hands you the oil and clasps her hands to her mouth, blushing faintly.  \"<i>Oh my, that little bunny girl was just too cute.  I hope you get a chance to meet her!</i>\"");
					outputText("[pg]Tilting your head back, you swallow the greasy oil in a single gulp, your belly filling with a wonderful sweetness that flows into your loins.");
					//IF BALLS:
					if(player.hasBalls()) outputText("  Your balls react immediately, filling with a cold weight that nearly knocks you to your ass.  Your [armor] bulges obscenely as the sack hanging between your legs fills with liquid pressure that squeezes your bloating flesh.");
					outputText("  Your abdomen noisily groans as your prostate churns with an eager fervor that sets your heart racing.  You strip before the pre-cum brimming at the peak of [eachCock] can stain your clothing and you find that Vala's already removed and folded her dress, apparently enjoying the sight.  You reach over and tussle her hair playfully, bringing a blush to the fairy's grinning cheeks.");
				}
				//OR [If the player's cum production is over X]
				else {
					outputText("[pg]In response, you cup the pale girl's chin and flash a sly smile of your own.  Arching a [haircolor] eyebrow, you assure her that won't be a problem.  Vala's hands sink down to your crotch, fey fingers pushing aside your [armor] to encircle your swelling member.  \"<i>I don't doubt it,</i>\" she purrs, lightly tracing the crest of your [cock]'s head.");
					//[IF BALLS:
					if(player.hasBalls()) outputText("  The fairy's hands slide a bit further and she turns up her palms to cup your [balls], her thin fingers delicately massaging the heft of your over-burdened sac.  \"<i>I don't know who's more excited, me or these guys,</i>\" she teases, drawing you into another passionate embrace.  Grasping your testicles just tightly enough to send a shiver of pleasure across the back of your neck, she wets her lips and whispers, \"<i>Who am I kidding?  No one wants this more than me.</i>\"");
					outputText("[pg]Stripping the [armor] from your body, piece by piece, Vala carefully sets your clothing on a nearby shelf then attends to her own dress.  Unhitching the clasps from her high-necked emerald garment, she turns her back to you, jutting her birthing-heavy rump out just a bit and wriggles her shoulders.  \"<i>Would you mind unzipping me?</i>\"  You move between the fairy girl's wings, pressing your erection against the silk hugging her ass cheeks and begin to pull open the skin-tight, jade raiment.  Gradually, the gossamer cloth parts, baring the silent testimony of Vala's imprisonment: thousands of ink hash marks tattooed from the girl's shoulders down to the soles of her feet.  The tender mercy of the imps.  She tenses for a moment before turning her head sideways to glance softly at you.  She sighs and her muscles loosen, dark memories melting at the touch of your fingers.  Wordlessly spinning to face you, she cups your cheeks in her warm hands and places a tender kiss on the tip of your nose before slipping out of her dress and folding it next to your clothes.");
				}
			}
			else {
				//REPEAT INTRO
				outputText("You give your favorite fairy's bottom a squeeze through the silk of her long dress and she returns the affectionate gesture by brushing her fingers down your free arm, lingering atop the tips of your fingers.  Discretely, you ask her if she's recovered from the last time the two of you indulged in each other and she giggles in delight.  \"<i>I don't think anybody would ever be quite the same after that many orgasms,</i>\" she whispers.  \"<i>If you're not careful, I might get addicted to you,</i>\" she teases, sliding a hand around your neck and running her fingers through your [hair].  \"<i>But how can I say no to all this?</i>\" she gestures at your body with a lascivious smile.");
				outputText("[pg]She drops off her apron at the bar and guides you to the store room, practically dragging you in her bobbing, exuberant flight.  Stripping the two of you, Vala has to restrain herself from mounting you on the spot, her breaths ragged and husky with desire.  ");
				//[Low Cum Production:
				if(player.cumQ() < 2000) outputText("Retrieving a vial of glistening oil, she offers the concoction to you with a laugh.  \"<i>The gal who makes these is so silly.  She always giggles when I pay her a visit and blushes when I call her 'bunny girl'.  She's so cute I just want to give her a squeeze!</i>\" You chuckle and down the draft, a thrill of cold weight filling your gut.  ");
				outputText("The fairy brushes her glittering hair behind her shoulders and sits on her knees in front of you, large pink eyes staring up eagerly.");
			}
			//[NEXT]
			doNext(valaCumBath2);
		}

		public function valaCumBath2():void {
			spriteSelect(SpriteDb.s_vala);
			clearOutput();
			outputText("Vala tries to compose herself before you, but the girl is too antsy to go slowly, impatient hands wrapping around your [ass] and pulling you toward her lithe body, her wings aflutter with restless gaiety.  The buoyant pixie leans in to lap at the pout of your cockhead with the tip of her pink tongue while her thumbs work fervently between the junction of her legs, stroking her glistening clit like she were polishing a precious jewel.  Her fingers curl into the slavering depths of her pussy, stroking her fey folds with trembling pleasure.  Leaving one hand to continue jilling herself, Vala takes the other and uses her honey-drenched palm to polish the quivering flesh of your swelling shaft.  She encircles the crest of your fairy-slick cock with her eager pucker, sucking the steady dribble of your pre-cum as she pumps vigorously.  Before long, the twitching bliss rushing to your loins tell you that her voracious efforts have coaxed the thickening semen bubbling inside you to the edge of your restraint.  Gently, you push her off of your member, your urethra dilating as your orgasm gushes forth.");
			outputText("[pg]Your cum spurts out in long, drooping ropes of alabaster that splash against Vala's face, provoking a startled jolt from the over-grown fairy.  She smiles, blinking the spunk from her eyes just as another stream lances out, pallid jizz catching her on the lips as she opens her mouth to speak.  She gasps in surprise, a curtain of ivory splashing down her chin.  The shuddering pleasure coursing through your body reaches a steady rhythm as you stroke yourself off in the throes of one, long orgasm.  Forcing yourself to breath steadily despite your racing heart, you pump your [cock] with remarkable restraint, holding back your impassioned urges to fill the fairy's womb with your virile seed.");
			outputText("[pg]Vala raises her hands to gather the seed seeping down her face, guiding your rich cream across her cheek and back into her hair.  Her chest rises and falls a little faster as your keep up the regular pulses of cum, arcing through the air with every heartbeat; semi-clear fluid lacquering her pale skin as layer after layer of your ejaculate forms a slimy pearl mask that seeps down her throat and across her sizable breasts.  The fairy seems a bit flustered, panting as her head rolls on her shoulders, mouth agape and eyes sealed behind the thick, liquid lust spurting from your throbbing shaft.");
			if(player.hasBalls()) outputText("  Your gut is heavy with the churning weight of your jism, sending tingling waves of cold into your pulsing scrotum, the chill soothing the ardor of your trembling balls.  A manic zeal writhes in your groin, filling your swollen pouch just as quickly as your protracted climax can splatter out your lewd passion across the shuddering girl's bare flesh.");
			outputText("[pg]The cum-drenched girl runs her hands up and down her torso, rubbing your warm cum against her skin with quivering motions.  Her fingers trace across her lean limbs and up the bust of her tremendous chest, rapidly flicking her nipples with her thumbs as she reaches the peak of her mounds.  Vala's breaths become shallow as a flush creeps across her skin, the hot pink hue visible even under the spoo-slick polish you're encased the fairy in.  She leans forward, her cum-glistening lips inches from your fountaining cock, and you can feel the boiling heat coursing through her drug-basted body with every panting moan that shudders out of her jizz-filled mouth.  She brushes her slime-coated cheeks across the crown of your turgid cockhead and slides her face over your pulsing glans until her nose is directly over your drooling sperm-slit.  She closes her mouth, takes a long, cooing swallow, and sniffs deeply, drinking in the salty scent of your creamy discharge.  Your next load lurches forward, a tremendous glob of goo bursting directly against her nostrils, suffocating her sense of smell with the possessive urgency of your foaming seed.");
			outputText("[pg]The fairy chokes as your jetting spunk fills her world, every pore drinking in the oozing nectar of your fervent masturbation.");
			//[IF BALLS:
			if(player.hasBalls()) outputText("  Her head sinks down to rest against your wobbling scrotum, the balls within practically swimming in the oceans of jizz your body is producing to saturate the cum-drunk girl.  Lifting your shaft vertically, your jism rains down on Vala's body, blotting out the imp-tattooed hash marks with an ivory cascade that splatters against her narrow shoulders and dribbles down, between her gossamer wings, draping her muscular back with a pearl raiment.");
			outputText("  Her face dripping with the milky veil of your spunk, the overwhelmed girl leans back, settling against the floor as the drug-like intoxication of your sperm leaves her incapable of much more than moaning and writhing.  Using both hands, she smears the spattering cum across her lissome frame: tracing the flower-like folds of her labia, pooling it into her belly button, scooping double handfuls to bathe her pink-and-purple hair in your white waterfall.");
			outputText("[pg]Her blissful ecstasy fills the cup of your frenzied ardor until it overflows, leaving you unable to keep your steady pace from accelerating.  Gripping the base of your shaft with one hand, you apply steady pressure, cutting off the stream of your cum while the other hand pumps faster and faster.  The squirming fairy at your feet thrashes in rapture, wreathed in the pale luminance of candlelight reflecting off the lurid pool that surrounds her spunk-polished body.  Her breasts sway across her chest, heavy with the milk of her many pregnancies, your gooey ejaculate giving the ponderous orbs a glistening sheen that ripples with every wobbling heave of her overwhelmed lungs.  Her mouth moves, whispering your name too softly for anyone but you to hear, and her hands slide down her hips, around her thighs, and past the petals of her pussy.");
			outputText("[pg]The sight of Vala, subdued eyes clenched and delirious mouth agape, utterly drenched in your cum, jilling herself off with both hands as she cries out your name is just too much.  You shift the grip on the hand holding your flow back and begin jerking yourself with both fists, bucking in the air as if to add force to your frenzied strokes.  Your body complies immediately, a rush of liquid heat pouring past your hands, torrential loads visibly bulging outward as they gush from your loins.  As the jetting spray bursts from your [cock] in an unbroken stream, you cry out Vala's name, rousing her from the drugged stupor.  Your alabaster cream rains down on the fairy's face and she screams with pleasure, mouth filling with cum so quickly that it gushes out the sides of her gleeful smile.  Her back arches in euphoria, giddy exhilaration fueling her own gasping, squirming orgasm as her fingers dig joyously into her honey-drooling cunny.  You pump out what feels like gallons of seed, basting Vala head to toe until her semen-lacquered body seems glued to the floor.  She happily scoops your jizz from between her legs and into her pussy before shivering and squeaking, her chest huffing as she cums again.");
			outputText("[pg]You keep stroking your [cock] for a minute or two afterwards, feeling utterly drained and begin to reach down to help Vala up when you notice she hasn't stopped her quivering, every muscle in the girl's body shaking with the trance-like bliss of her climaxes.  It seems the fairy is going through a protracted orgasm to rival your own, swooning in a paradise of her hero's sticky passion.  Rather than interrupt the fairy's cum-soaked reverie, you opt to let her enjoy every last minute of it.  You leave her with a cheerful kiss on the forehead as you discretely exit the back room.  As you go, the taste of your salty jizz mingles with the girl's own sweet flavor to breed waves of tingling euphoria that washes away your weariness.");
			//[End Encounter][Cum production up, Fatigue removed]
			if(player.cumQ() < 2000) {
				player.cumMultiplier += 6;
				if(player.hasBalls()) player.ballSize += .5;
			}
			player.cumMultiplier += 2;
			if(player.hasBalls()) player.ballSize += .3;
			flags[kFLAGS.VALA_CUMBATH_TIMES]++;
			player.sexReward("Default", "Dick");
			dynStats("lib", -1.5);
			doNext(camp.returnToCampUseOneHour);
		}

		//Big Vala Intro
		public function valaBigYou():void {
			clearOutput();
			flags[kFLAGS.TIMES_VALA_CONSENSUAL_BIG]++;
			//{FIRST TIME}
			if(flags[kFLAGS.TIMES_VALA_CONSENSUAL_BIG] == 1) {
				outputText("Tilting your head, eyes glowing with ethereal power, you answer, \"<i>I want you... big.</i>\"");
				outputText("\n\n\"<i>Smooth one, Champ,</i>\" Shouldra chuckles inside you.");
				outputText("\n\nVala claps her hands together and cheers, \"<i>Awesome!  Just let me get someone to watch my shift for me.  We should probably do this at your camp, so we don't destroy half the city!</i>\"  She turns away from you and calls, \"<i>Hey!  Mary!  Remember the favors you owe me for covering while you hooked up with Chad?  Well, I'm calling them in now.  I need you to cover my shift while I'm out with [name].  It'll only be an hour!</i>\"");
				outputText("\n\nThe other girl, who can only be Mary, nods resolutely.  Vala kisses you on the cheek and grabs your hand in a death-grip, pulling you out the door in a rush, her fluttering wings vibrating against your nose and kicking up clouds of faerie dust.  You wind up sneezing a few dozen times from the hurried pace she sets, but before you know it, you're at the edge of camp with Vala spinning around, barely containing her excitement.  Her big, pink eyes stare at you as she asks, \"<i>So uh, how do we do this?</i>\"");
				outputText("\n\nSmiling, you lean back and mouth, \"<i>Shouldra?</i>\"");
			}
			//{REPEAT}
			else {
				outputText("You tell Vala just how HUGE your need for her is, which earns you a blush from the petite faerie's fair cheeks.  She calls in a favor from another waitress - looks like Vala covered for this one's tryst with Chad as well.  That Chad guy must get around!");
				outputText("\n\nIn any event, the two of you leave the city for camp, where a giant, sexually-charged faerie is less likely to damage anything.  ");
				if(silly()) outputText("The last thing you need is a bunch of winged archers taking potshots at Vala while she clings to a tower with you in her hand...  ");
				outputText("She seems to know the way directly to your camp, and all too soon, you've reached your place of residence.  Vala cheekily pokes your [chest] and asks, \"<i>Shouldra?</i>\"");
			}
			//{MERGE}
			outputText("\n\n\"<i>I wondered how long you'd make me wait...</i>\" comes the ghostly answer, fading from your mind even as the ephemeral traces of Shouldra's ectoplasmic form slide free of your own.  Vala gasps as the ghost-girl's hands wrap around her breasts, whispering words of magic with breathless intonations while she absorbs into Vala's pert, fae body.  The bouncing tits before you begin to expand even as Shouldra vanishes.  The newly-possessed woman gasps with unholy pleasure, seizing her nipples in her hands as they expand.  She rhythmically tugs them, almost compulsively.  Her fair skin quickly tints rose, gradually taking on a sweaty gloss as her ardor rises to unmanageable levels thanks to your ghostly friend.");
			outputText("\n\nVala's eyes glow amber, her mouth muttering more nonsensical words as Shouldra takes full control of her faculties, for now.  The ghost continues her breast assault, even once the faerie's taut nipples swell beyond her reach.  Vala's clothing tears apart under the strain, her swelling bust splitting the elegant dress at the seams before her body's unchecked growth shreds the remaining fabric into silken tatters.");
			outputText("\n\nWith her spell complete, Shouldra steps back, the glow fading from the winged slut's pink eyes to reveal lust-dilated pupils with droopy, complacent eyelids.  Vala pants with a wet, hot gasp that feels like a gusting wind, growing louder as her mouth - no, her whole head - expands.  Her torso fills out at a matching pace, slowly catching up to her still-engorging boobs, which have long since come to rest upon the ground.  Giant-sized droplets of fluid drip from between Vala's thighs as her arousal increases with her.  The trickle of dainty fluids turns into a spattering stream.  Her legs expand out past you on either side as the faerie passes twice your height, finally lifting the heaving globes up from their gravity-forced compression.");
			outputText("\n\nThe enhanced faerie giggles down at you from over her plus-sized mammaries in between moans.  \"<i>Oh, [name], I feel a bit light-headed,</i>\" she giggles, drunk with the empowering sensations.  She's already three times your height, with the smooth skin of her thighs thickening to either side of you.  You take a step back when the gushing lube winds a small stream by your [feet].  The cracked earth around you is rapidly turning into mud, and you grab onto Vala's knee for support.  Shouldra's phantasmal voice chuckles, \"<i>I hope you know what you're getting into, Champ.  Don't think I'm done when she finishes growing!</i>\"");
			outputText("\n\nVala reaches down between her legs and begins to piston a finger inside herself, the digit easily as wide as both your arms combined, yet, in her sloppy, oozing cunt, it's barely big enough.  Slowly, her growth diminishes, only fading once she's tall enough to make you question if you could even measure her height.  Her voice echoes out with enough force to vibrate through you, \"<i>Ha!  I'd like to see the imps try anything now!</i>\"  Of course her words still maintain their girlish pitch, something made more clear when she stoops down to circle surprisingly delicate fingers around your waist before lifting you in front her face.  Her glistening lips, cute nose, and big, pink eyes dominate your view.  What do you ask her to do?");
			//[Dom Me] [Lick Me]
			menu();
			addButton(0,"Dom Me",bigValaDomsPC);
			addButtonIfTrue(1,"Lick Me",bigValaLicksOffDudes, "Req. a cock.", player.hasCock());
			if(SceneLib.vapula.vapulaSlave() && (player.hasCock() || (player.hasVagina() && player.hasKeyItem("Demonic Strap-On") >= 0))) {
				addButton(2,"Dom Vapula",valaDommyVapula3Some);
				addButton(3,"Vapula3Some",valaLoveyVapula3Some);
			}
			else {
				addButtonDisabled(2, "???", "Req. enslaving a certain succubus and having something to feed her with.");
				addButtonDisabled(3, "???", "Req. enslaving a certain succubus and having something to feed her with.");
			}
		}
		//Big Vala: Dom Me
		//Put PC on ground to make serve her orally.
		public function bigValaDomsPC():void {
			clearOutput();
			outputText("Vala tilts her head to the side, causing a gust of displaced air to blow your " + hairDescript() + " wildly.  \"<i>Giving the maiden a chance to lead?  You're so sweet!</i>\"  She tickles your chin with one immense fingertip.  \"<i>But you had better give it your all, you adorable rascal, you.</i>\"");
			outputText("\n\nYou're gently placed on the ground between Vala's legs.  Looking back, you see her cross her ankles behind you while her thighs swing closer.  With no escape and the walls of your prison rapidly closing around you, the only way you can go is forward.  You slip and slide on the torrent of girl-cum that drizzles out from the gigantic faerie's cave-sized twat, holding onto her thighs to stay upright during your trek, lest you faceplant into cum-mud.");
			outputText("\n\n\"<i>Better hurry, Hero, if you don't want to be crushed!  Your prize is so close!</i>\" Vala giggles, eventually pushing your [butt] with a finger to spur you along.  Reaching the ingress of her gushing pussy, you embrace the quivering, puffy edifice, the lurid lubrication slicking you from head to toe, pouring in through every crack and seam in your [armor].  A tremendous clap echoes from behind you, and you turn to see that her thighs have finally scissored closed.  You can feel the pliant flesh pressing in on you from both sides, holding you tight to the inviting lips even as the warm juices run down your [legs].  Beads of her slick moisture roll down your neck and arms, and you're forced to breath in nothing but air laced with her scent.");
			outputText("\n\n\"<i>Lick,</i>\" comes the booming command, her voice quivering with delight and embarrassment.");
			if (flags[kFLAGS.VALA_HEALED_HONEY] == 0) outputText("\"<i>If you do a good job, I'll let you taste a pure pearl of my own,</i>\" she giggles.");

			//{Male:}
			if(player.gender == 1) {
				outputText("\n\nShuddering from the onslaught of female pheromones, you find your body responding without meaning to.  [EachCock]");
				if(player.lust >= 70) outputText(", already hard, begins to bead with pre-cum, mixing with the slut-leakings that have found their way under your equipment.");
				else outputText(" stiffens immediately to a full, throbbing hardness.");
				outputText("  Your body is imminently ready for breeding, erect and wanting so badly to be freed from your constricting garb, but you know that with what you asked, you won't get to sate it.");
				if(player.biggestCockArea() >= 150) outputText("  If only you weren't so big - you can't expand to your full size, and the tightness is almost emasculating at how it constrains your size, keeping you small enough to fit inside your [armor] but still hard as a stone, only this stone is having the pre squeezed out of it.");
			}
			//{Female:}
			else if(player.gender == 2) {
				outputText("\n\nShuddering from the onslaught of lusty pheromones and the humiliating situation you've sent yourself into, you find your body beginning to flush in its own arousal.  You inhale deeply of the lusty cunt-scent, letting your own feminine delta begin to moisten in reciprocation.  ");
				if(player.wetness() >= 3) outputText("Your [vagina] seems to always be wet, but now, with this sight before you, your girl-cum is running in rivers down your [legs] to mix into the puddling lady-spunk below.  ");
				outputText("Your armor seems tight and constricting against your rock-hard [nipples].  It's something you can't escape from, and with each passing moment, the sensations coming from your chest seem more and more worrisome, stoking your fiery lust to an incredible degree.");
			}
			//{Herm:}
			else if(player.gender == 3) {
				outputText("\n\nShuddering from the onslaught of lusty pheromones, you find [eachCock] responding even before you realize what's going on.  ");
				if(player.lust >= 70) outputText("You may have already been uncomfortably hard, but you start leaking pre-cum all over the inside of your [armor].  Of course, the copious fem-jizz that's already seeped inside your gear absorbs the extra fluid with little to no complaint.");
				else outputText("You get hard with alarming rapidity.  Being so close to such a gloriously large quim seems to overpower your better sense, and you're forced to give in to your body's imperative.");
				outputText("  Inside your undergarments, everything is already turning into a swampy, slimy mess thanks to Vala's secretions, and your own feminine drippings don't help any.  Your lips and dick");
				if(player.cockTotal() > 1) outputText("s");
				outputText(" are smothered with the stuff, making you moan without meaning to.");
				if(player.biggestCockArea() >= 150) outputText("  If only you weren't so big!  You're compressed so tightly by your enclosing [armor], and even though you're rock-hard, you're a fraction of your full size.  If only you could get out of your gear and fuck her!");
			}
			//{Genderless}
			else {
				outputText("\n\nShuddering from the onslaught of lusty pheromones and the humiliating situation you've sent yourself into, you find your body beginning to flush its own arousal.  You take in a breath of the lusty cunt and wish you had one of your own.  Nevertheless, your [asshole] feels noticeably empty, and you wish you had something to slide up inside you so that you could achieve the release you so crave.  Instead, you're left to feel the faerie's juicy wetness sliding all over you inside your [armor], a soupy lubricant that makes you ache even more.  Instead, you'll have to focus on serving her entrance...");
			}
			//{CONTINUE}
			outputText("\n\nYou grab hold of the fleshy folds and slowly spread them apart.  They seem like immense, engorged curtains.  A web of lubricant dangles between them, each juicy strand smelling strongly of her imminently feminine scent.  Figuring there's nowhere to start but the entrance, you begin to lick up and down her right lip, tasting the tang of her sweat mixed with the sweeter flavor of her sex.  The compressing walls of flesh on either side combine with her relaxing entrance to gently slide your [legs] inside her slippery entrance.  You redouble your efforts in light of that, stuffing a hand inside her and beginning to rub along the almost frictionless walls.  They pulse hungrily at your intrusion, gently undulating around your gently pumping legs.");
			outputText("\n\nVala moans, \"<i>Oh yeah, keep at it, Hero,</i>\" while she presses against your back with a finger, grinding your [face] all over the puffy lip you've been worshipping.  \"<i>Right there...</i>\" she gasps, trailing off into a hum of bliss.  Your left shoulder slides in before you know, but you suppose that just lets you do your job better.  Her secretions are flooding your mouth with tasty girl-juice, forcing you to swallow in between long laps and sensuous kisses.  She seems to like it, but your size prevents you from polishing every inch with your tongue, so you simply slide your face all over the soft, pillowy pussy-lip, using your nose and facial contours as a ribbed pussy-massager.  You hum while you do it, pressing your [chest] into her sensitively as you start humping her entrance while fully clothed, your [butt] sliding along the interior of her left side.");
			outputText("\n\nYour head bumps into something hot, firm, and pulsing, eliciting a gasp of surprised pleasure from the faerie.  You crane your head and realize it's Vala's plump pleasure-buzzer, thicker than your arm and at least a foot long, protruding out from its clitoral hood.  You grab hold of her mound and lift yourself up to it with her clenching pussy's pleased undulations assisting you, just high enough that you could kiss the underside.  Instead, you open wide and suck the tip inside of your mouth.  At first contact with you, the silken tunnel that hugs at everything below your shoulders begins to tremor with spastic delight, muscular contractions wringing you from [legs] to your [hips] and down to your [feet] again and again.  You endure the constriction with frenetic focus, knowing that if you don't want that hungry cunt to swallow you whole, you had better set it off fast.");
			outputText("\n\nVala gasps, \"<i>A-ah!  S-suck on my pearl, tiny fairy!  Take it into your - oh! - mouth and feel the c-c-corr-UP!  UP!  Corruption wash from you!  Bathe in my crystal honey!</i>\"  You pull yourself up onto her buzzer with burning arms and swallow it whole, obeying immediately.  You were already aroused at the sight of her immense tunnel, but to be so... intimately engulfed in it and massaged with such dexterous, natural skill is overpoweringly erotic.  You feel her clit bumping against your tonsils at the same time that slick moisture rolls all over you, from shoulders to [feet], inside your [armor] and out.  She's gushing all over you, and you're wiggling your [hips] senselessly, starting to moan into her clit as she rides you like a living, clit-sucking dildo.");
			outputText("\n\nAn ear-splitting shriek of excitement hits you, and the fevered movements of Vala's interior redouble, sucking your whole body hard, pulling you deeper and deeper inside, hard enough that her clit almost pulls out of your maw.  You hold for dear life, fiercely afraid of disappearing into her womb and simultaneously aroused enough that your own body is shaking wantonly, lewdly vibrating your own body inside her as you slam your groin against her walls again and again.  Orgasmic pleasure hits you, robbing you of strength.  Your hands lose their grip and suddenly, you feel yourself slipping into her, her plush lips closing around your head so that all you can see is the faint, pink-tinged light that penetrates through you.  It slowly diminishes as you pass deeper, and with strength born of terror, you stretch up to grab her clit, the only hand-hold you can reach.");
			outputText("\n\nAs soon as your hands clench onto that rigid little rod, the vaginal walls that surround you go wild, slamming you back and forth for a moment until a wave of girlish lubricant wells up from inside her.  It floods the cavernous twat with moisture, and you're actually carried out on the lady-spunk scented tide, riding the clear geyser you wash out onto the ground.  Vala's thighs long since spread wide and began to shake and tremble wildly.");
			outputText("\n\nShouldra pops out of Vala's belly, asking, \"<i>Like what I did with her pussy, Champ?  They're so much more fun when they're pulling you into their welcoming wetness, don't you think?</i>\"  She smirks at the look in your eyes and flies into you, her comforting, familiar presence reappearing in the back of your mind.  \"<i>Oh wow, Champ, did you get off on that?  You did - you horndog you!  I should've ridden that one out inside you!</i>\"");
			outputText("\n\nWhile you stand there, dripping sexual juices, Vala gradually starts to diminish in size.  Sadly, her breasts seem to return to normal faster than the rest, which leaves her disproportional while she journeys towards her normal shape.  She's still locked in climax, leaking an ever-shrinking amount of fluid.  The smaller she gets, the faster her change progresses.  Then, with an alarming abruptness, she flops down in the lake of lady-spunk she left behind, moaning pleasantly.");
			outputText("\n\nYou lift her up out of the mess and carry her to the stream where you both clean up.  Vala murmurs, \"<i>My hero...</i>\" as you wash her, too wiped out to do it herself.  Vala recovers by the time you're getting re-dressed, and she gives you a surprisingly chaste, blushing kiss before she gets ready to depart.  The faerie seems to have some degree of magical affinity, as she's able to knit her dress back together with a bit of mental effort, and then she's fluttering away, calling out her goodbyes to you as she journeys back to Tel'Adre.");
			player.sexReward("vaginalFluids", "Default");
			doNext(camp.returnToCampUseOneHour);
		}

		//Big Vala: Lick Me (Requires Penor)
		public function bigValaLicksOffDudes():void {
			clearOutput();
			outputText("Giant Vala cocks an eyebrow at your request in surprise.  \"<i>But, what if I accidentally swallow?  I couldn't live with myself if something should happen to my big... er, little Hero.</i>\"  She pats you on the head affectionately, unsure of how to handle herself with all of her newfound size.");
			outputText("\n\nYou comfortingly stroke her hand and reassure her that you want nothing more than to slide yourself in her mouth and feel her gigantic tongue sliding all over you, licking all of you like a popsicle until you can't take it anymore.");
			outputText("\n\nVala seems somewhat intrigued by the way you're putting it, but her worried brow furrows deeper, fretting about what could go wrong.  The familiar glow of your ectoplasmic friend appears in Vala's eyes for a split second, and her lips suddenly begin to inflate, puckering on their own into what can only be described as a cocksucking 'o'.  Their surface begins to shine with unnatural lubrication, glossy with slippery promises of sensuous caresses and orgasmic pleasure.");
			outputText("\n\n\"<i>What did you dtho tho mee?</i>\" Vala whines as her tongue pokes out to test the newly swollen flesh, sliding across the immense, pillowy lips on its own.  Her grip on you slackens as she shudders with pleasure, eyes rolling halfway back before she lets out a sugary, pleasure-addled moan.  \"<i>Okthay, okthay... jusht... be careful!</i>\"  She sets you down before the act of speaking makes her moan any harder, actually pushing you on to your back and fumbling around your [armor] on her own, trying to take it off.  You try to help, but her eager, shaking fingertips keep getting in the way.  You can see she hasn't stopped licking her lips or moaning through the puffy maw she calls a mouth, and once she finally gets a fingernail into your equipment, she tears it off you and tosses it aside.");
			outputText("\n\nThe mountainous pixie lifts you up to her lips with a smile, or as much of one as she can manage at the moment, with her tongue drooling out the corner of her mouth.  Slowly, almost tentatively, she brings you closer and closer to her open pucker, her movements so slow and deliberate that it seems she's both afraid to do it and stubbornly insistent on this course of action at the same time.");
			outputText("\n\nYour [foot] hits her plush, lower lip, feeling the warmth of her breath flowing over your body.  Her lust-lidded eyes gaze down at you worshipfully as she moans across you, gingerly slipping your [feet] across her lubricated mouth and into the saliva-filled cavity behind.  They come to rest on her tongue, which eagerly slithers around your [legs] and [hips] before winding to your [chest], flicking each of your [nipples] in turn along the way.");
			if(player.hasFuckableNipples()) outputText("  It even pauses at one to slip a tiny bit inside, too big to penetrate your nipplecunt properly but teasing it all the same.");
			outputText("  Finally, it encircles the back of your neck and curls up to slide across your chin.  You greedily slurp the tip of her oral muscle into your own mouth, and the effect is immediate.");
			outputText("\n\nVala whimpers around you hard enough to vibrate through your whole body.  Her tongue pulls you partway into the wet heat you're feeling down south, still moaning even as her newly hypersensitive oral organ slips around the back of your [legs], curling all the way to the base of your [hips].  [EachCock] presses proudly against her upper lip, and the soft cushion of her flesh smushes comfortingly around ");
			if(player.cockTotal() > 1) outputText("each");
			else outputText("your");
			outputText(" length, unholy smoothness sliding ever so slowly back and forth as she moans.  The giant faerie drags you further inside, much to your delight.  Agonizingly sensuous pressure mounts all along your length");
			if(player.cockTotal() > 1) outputText("s");
			outputText(" until ");
			if(player.cockTotal() == 1) outputText("it slides");
			else outputText("they slide");
			outputText(" inside her");
			if(player.biggestCockArea() >= 200) outputText(", the immense length sucked in by a surprising burst of suction");
			outputText(".");

			outputText("\n\nExcitedly, the happy slut pulls you the rest of the way inside, leaving nothing exposed save for your head.  Vala takes care to guide you away from her teeth, rolling your body across her sensitive, bimbolicious lips and immensely pleasurable, well-coordinated tongue that even now is wrapping around you again, curling around your body from both sides in a pliant, moist embrace.  The foggy heat of her breath and body washes over your whole form, and combined with the coils sliding over every part of you, ");
			if(player.biggestCockArea() < 200) outputText("smothering your relatively tiny pecker");
			else outputText("wrapping up your immense pecker");
			if(player.biggestCockArea() >= 400) outputText(", even as it hangs partway down her throat");
			outputText(", you begin to moan as well, subsumed in steamy pleasure.");

			outputText("\n\nThe tongue surrounding your body begins to twirl faster and faster, pumping at you mercilessly.  Somehow, the tip of the muscled organ finds an opening above your legs and pokes at your [vagOrAss], and it pokes through the tender entrance before you can give voice to a single gasp.  Worming deep inside you, mercilessly licking, and vibrating softly with each exhalation, the mass of muscle has you dripping all over it, [eachCock] a willing participant in bringing you to the very height of pleasure.  You twitch and writhe inside it, [hips] futilely trying to pump and fuck, but there's no way you can possibly move.");

			outputText("\n\nSuddenly, you're unwound and left face down on the flat meat of her tongue");
			if(player.biggestCockArea() >= 400) outputText(", cock partway down her throat");
			outputText(".  Staring down between the canyon of her cleavage, you can see the river of girlcum below and smell the lurid scent that wafts up from it.  Freed from the squishy grip of her oral embrace, you reach out your arms, stretching them to feel Vala's lips, rubbing over the smooth, yielding surface.  The massaging stimulation brings a gurgling purr to her throat, so you keep doing it, while you begin to hump her taste buds, the slippery, dimpled texture of her tongue just what you need.  Again and again, you drag [eachCock] over her smooth oral muscle, and soon you know you couldn't stop if you wanted to.  You're sure you must look a mess, a head hanging out of the giantess's lips, moaning like a whore while you try to mate with her tongue.");
			outputText("\n\nHer spit froths and bubbles around you, stirred up by your own frenzied motions.  You cry, \"<i>Gonna cum!</i>\" a moment before the pleasure morphs your voice into a ragged, exultant cry.  Your own liquid heat boils up from within you");
			if(player.hasBalls()) outputText(", [balls] clenching against Vala's tongue");
			outputText(" as you explode into ecstatic, jerking pumps against her slippery, sensitive tongue.  Vala's voice rises with yours the moment the first spurt of seed stains her tongue, and her fem-cum sprays out to soak her thighs with enough force to carry some smaller boulders away in the tide.");
			if(player.cumQ() < 250) outputText("  She barely notices the spunk you shoot against her tongue, her drooling saliva washing it away almost immediately, but you're sure she got a nice, salty thrill from it regardless.");
			else if(player.cumQ() < 1000) outputText("  She has to noisily gulp down the liquid deposit you leave in her mouth, but with her enhanced size, it's still no more than a creamy morsel.");
			else if(player.cumQ() < 4000) outputText("  You slowly flood her mouth with spooge until her cheeks bulge.  The spooge inundates her maw until your lower body floats in it, forcing the girl to swallow hard or risk having the teeming seed spill out around you.");
			else outputText("  You immediately flood her mouth, bulging her cheeks with obscene amounts of spunk.  She noisily gulps, mouth working futilely to handle it all, but it's not enough, and jizz begins to burst from the corners of her mouth, almost pushing you out with it.");
			outputText("  Her tongue grinds back and forth underneath you, encouraging you to deposit every single drop into her.");

			outputText("\n\nOnly after your orgasm has faded and your body is sagging weakly on Vala's palette does her own orgasm conclude.  She gingerly extracts you from her mouth, panting as her lips slowly de-puff, returning to normal size (for a giantess).  The faerie leans back, still gasping, dropping you on her tit, which you use to slide down to the ground after catching yourself on her nipple.  The immense form begins to shrink behind you almost as soon as you get off it, the ghost exiting her body and surging into yours in a flash. Shouldra's familiar presence gives you a mental wink and a breathless sigh - she clearly enjoyed it as much as you.");

			outputText("\n\nWhile you stand there, dripping oral juices, Vala diminishes further.  Sadly, her breasts seem to return to normal faster than the rest, which leaves her disproportional while she journeys towards her normal shape.  The smaller she gets, the faster her change progresses.  Then, with an alarming abruptness, she falls flat in the lake of lady-spunk she left behind, moaning pleasantly.");

			outputText("\n\nYou lift her up out of the mess and carry her to the stream where you both clean up.  Vala murmurs, \"<i>My hero...</i>\" as you wash her, too wiped out to do it herself.  Vala recovers by the time you're getting re-dressed, and she gives you a surprisingly chaste, blushing kiss before she gets ready to depart.  The faerie seems to have some degree of magical affinity, as she's able to knit her dress and your [armor] back together with a bit of mental effort, and then she's fluttering away, calling out her goodbyes to you as she journeys back to Tel'Adre.");

			player.sexReward("saliva", "Dick");
			doNext(camp.returnToCampUseOneHour);
		}

		//Intro to Vala + Vapula Threesomes
		public function valaVapulaThreesome():void {
			//{First Meeting}
			flags[kFLAGS.TIMES_VAPULA_AND_GIANT_VALA]++;
			if(flags[kFLAGS.TIMES_VAPULA_AND_GIANT_VALA] == 1) {
				outputText("Crossing your arms, you call out to summon your pet succubus from wherever she's lurking at the moment.  Vapula comes frolicking up almost instantaneously before stopping mid-stride, curvy thighs quivering and mouth-gaping.  \"<i>T-there's a gigantic... faerie?!</i>\" she asks incredulously while slowly turning to face you, her [master].");
				outputText("\n\nYou cackle gleefully at the sight.  This is perhaps the most anything has ever surprised your violet sex-pet, and you revel in the moment while her brain tries to cope with what she's seeing.  Behind you, Vala shrieks, gasping out, \"<i>There's a demon, here!?</i>\"  You spin about in time to see the immense pixie cradling her breasts and vagina, as if she could somehow conceal her modesty or lusty state simply by covering the offending organs with her once-petite palms.  You place a comforting hand on Vala's gargantuan thigh to try and comfort her; big as she is, she barely feels it.  Her pink-tinted eyes focus on you as she queries, \"<i>What is a demon doing here?!</i>\"");
				outputText("\n\nPutting on your most charming smile, you tell her that Vapula is YOUR demon.  You broke her of her domineering ways and brought her here to serve you with her numerous skills, and besides, you figured Vala might like the opportunity to take revenge on a demon her way.  During this, Vapula seats herself before you, one hand stroking your thigh encouragingly.  You pat her head and say, \"<i>Come on Vala, I'll make sure Vapula does whatever you say, won't you, my little, submissive demon-whore?</i>\"");
				outputText("\n\nVapula nods eagerly, though she does dare to ask, \"<i>How will this feed me?</i>\"");
				outputText("\n\n\"<i>If you ever want to feed again, you had better do whatever my faerie friend wants of you,</i>\" you reply.");
				outputText("\n\nVala is understandably taken aback by this, but she gradually removes her hands from her erogenous zones.  \"<i>I guess if you say it's okay...</i>\" she mumbles, still a bit worried.");
			}
			//{Repeat}e
			else {
				outputText("You call for Vapula, which brings an amused smile to your giant faerie's face.");
				outputText("\n\n\"<i>Bringing back my favorite purple dildo?</i>\" Vala asks with unmistakable enthusiasm just as Vapula comes up from behind a rock, an unmistakable spring in her step.  As soon as she sees the immense pixie, she stops in her track and growls, \"<i>This isn't a feeding call, is it?</i>\"");
				outputText("\n\n\"<i>Nope,</i>\" you answer, forcing her to her knees next to you.  You both look up at Vala, who's smiling eagerly and dripping like a sieve.");
			}
		}

		//Giant Vala + Vapula Threesome - Vala Dommy
		public function valaDommyVapula3Some():void {
			clearOutput();
			valaVapulaThreesome();
			outputText("\n\nWith her mind made up, Vala grabs hold of the surly demoness.  Then, leaning over your camp, she grabs a length of rope from your supplies, holding it as you would a length of twine.  She quickly loops it around the demoness, tightly restraining Vapula from her pointed heels up to her big, bouncy succubi-tits.  The tainted tart's arms are lashed tightly to her sides before she's caught on to what exactly is going on, crude rope compressing her forgiving flesh erotically, setting Vapula's glorious, corrupted cunt to dripping.");
			outputText("\n\n\"<i>Hey, what are you doing?</i>\" the smaller woman cries as she struggles against the bonds.");
			outputText("\n\nVala lustily replies, \"<i>Well, you're a succubus, right?  I'm about to let you feel the <b>biggest</b> orgasm you've ever experienced, but if you're left free, you might damage something with those nails or heels of yours!</i>\"  She titters at her own awful pun as she ties the knot and finishes restraining your demonic whore, leaving her dangling upside down from a few feet of excess.  Apparently the former sex slave has retained some of the lessons in bondage her captors drilled into her.");
			outputText("\n\nVapula cries, \"<i>No!  [Master], help!  She's... she's going to use me like a living dildo!</i>\"");
			outputText("\n\nYou don't even deign to answer her frenetic protests.  Instead, you content yourself with getting naked, giving the faerie a slight nod to indicate you're totally fine with how things are progressing.  All the curvy female flesh on display certainly has a pleasant flush spreading across your [skin], so you seat yourself and tend to your stiffening nipples, slowly tugging and squeezing them while you watch the giantess play with her prey.");
			outputText("\n\nVapula swings around like an out-of-control pendulum, eventually slamming face-first into Vala's cleavage when the flirtatious pixie lifts her higher.  The cushiony, drug-enlarged breasts squish and jiggle noticeably around the squealing, purple package before closing in around her, compressed into a squeezing vice by Vala's elbows.  Vapula's heels wiggle above the fair valley before stopping abruptly.  A moment later, a trickle of what can only be feminine moisture begins to trail out from the pixie's underboobs.  The pixie gingerly pries her tits apart, just wide enough that you can see the succubi inside making out with Vala's supple skin, her whorish, purple lips worshipping at the mammary altar before her.  The demoness's juicy cunt is exuding so much moisture that it's dripped down her suspended body, slicking her with moisture and turning her hair into a matted, dripping mess.");
			outputText("\n\nVala pokes the purple woman's bubbly backside to rouse her from her tit-worshipping daze and regretfully separates her from the creamy faerie-tits, dragging her along to one of the torso-sized areolas.  Vapula's tail grabs hold of one to arrest her motion, hands digging into the swollen, pebbly nub hard enough to make the larger girl cry out in pleasure.  Getting the idea, the demoness pulls her face down onto it and opens her mouth inhumanly wide, slurping and suckling at the nipple with wanton abandon.  A torrent of creamy faerie-milk fills the corrupted woman's maw, a sweet treat for the hungry demon.  The audible slurps intensify until the giant mound is quivering uncontrollably on the squirming fae, trembling so ecstatically that she pulls her taut bud free of the diminutive demon's gullet.");
			outputText("\n\nVala teases, \"<i>Are you ready, little demon?  I like you, so I think I'll have to keep you in my cave and fuck you a bunch!</i>\"  It's a rather familiar sentiment, and before Vapula can complain, gigantic hands wrap around the purple-skinned girl's heels, a single finger curling under the smaller woman's back to support her.  The captive is almost immediately stuffed into Vala's immense, gushing gash, making a high-pitched squeal that's almost instantly muffled by the puffy pussy lips that now envelop her head.  She's plunged in bodily, only her heels left protruding from the moist entrance.  Vala's entrance undulates with slow, pleasant contractions around the intruding form while discharging even greater quantities of lubricant.");
			outputText("\n\nThe erotic sight beckons to you, and hearing the ludicrously loud moans coming from Vala's throat incites greater levels of excitement from your loins.  Stumbling up, you stagger towards the curtain-like labia with one hand ");
			if(!player.hasCock()) outputText("buckling on your demonic strap-on");
			else outputText("stroking [oneCock] eagerly");
			outputText(", eyes locked on the demoness's cum-slicked heiny and wiggling body.  The plush mound is open just wide enough that you're sure you could climb right in alongside your pet, which is just what you intend to do.  The closer you get, the more you're sure that Vapula IS enjoying herself if the muffled moans are anything to go by.");
			outputText("\n\nVala moans when you reach her lust-engorged mound and lean against it, hands sinking into the sensitive quim-skin as you examine just what's going on.  Vapula's green eyes peer up at you from out of the foggy darkness.  The air itself is so inundated with pussy-musk that it's actually creating a sexual fog that's so suffused with pheromones that you can't help but begin to pant once exposed to it.  Your fuck-pet seems to be begging you with her eyes and her slowly squirming body, seducing you with every erotic undulation to join her in the warm, syrupy love-canal.");
			outputText("\n\nYou climb on in with her, aided by the sucking pulsations of Vala's cunt.  It pulls you in almost bodily, and you grab hold of Vapula to steady yourself.  The faerie's silky-smooth interior squeezes down around you, vibrating with its owner's moans as it smushes you against the purple-skinned woman before you, two bodies slipping and sliding against each other in a sea of sloppy, sexual secretions.  Without meaning to, your ");
			if(!player.hasCock()) outputText("dildo");
			else outputText("[cock smallest]");
			outputText(" slides into the demoness's waiting snatch, which slurps it down with a hungry contraction, slapping your [hips] against hers, the slippery, demonic folds wriggling around you with such insistence that you couldn't pull out if you want to.");
			outputText("\n\nMeanwhile, Vala's furious cunt-contractions are starting to come closer and closer together, each time accompanied by fresh waves of her lubricant.  Blessed warmth rises through your midsection, the familiar, pulsing sensation of an orgasm welling up within you at the same time.  You wrap your arms around Vapula to crush her against yourself, [chest] to fat, purple tits, nipples to nipples, and you kiss her, allowing her probing tongue to slither into your mouth with rapacious eagerness.  The vague, pinkish light that had illuminated both of you vanishes, and with a glance towards the entrance, you realize Vala has her hand in front of her cunt, fingers pushing and pulling the pair of you through her wiggling cunt, likely toying with her clit as well.");
			outputText("\n\nYour [butt] is abruptly slapped by an intense, fleshy contraction, the enveloping walls conforming to your shape as they close tightly around you and Vapula.  There is no air to breath, but there is a tongue, and a pussy, both of which have your full attention.  You mate with your whorish little pet, trying to arch your back but pinned against her regardless, fountaining ");
			if(player.hasCock()) outputText("seed");
			else outputText("fake seed");
			outputText(" without meaning to, the lustiness of the situation just far beyond your ability to bear.");
			if(player.cumQ() > 500) outputText("  The demon's purple belly balloons with cum, swelling against your own");
			if(player.cumQ() >= 1500) outputText(" as her midriff turns taut and dome-like");
			if(player.cumQ() > 500) outputText(".");
			if(player.cumQ() > 1000) outputText("  Waves of spunk pour out from Vapula's lust-swollen lips thanks to your exceedingly potent orgasm.");
			if(player.lactationQ() >= 100) {
				outputText("  Even better, your [fullChest] lets down your milk, letting it run out of you in ");
				if(player.lactationQ() <= 200) outputText("thick");
				else if(player.lactationQ() <= 2000) outputText("powerful");
				else outputText("enormous");
				outputText(" streams, tinting Vala's secretions white.");
			}
			outputText("\n\nVala climaxes, pulling you both out as a river of fem-spunk gushes out behind you, and you and your lust-locked demoness drag across the faerie's enhanced pleasure-buzzer, smearing her lusty juices across her pulsating, sensitive organ while you thoroughly feed your demoness's insatiable cum-hunger.");
			outputText("\n\nEventually, you're dropped to the ground, panting for your breath while Vapula's tongue slowly withdraws.  You separate, realizing that during the lengthy cum Shouldra returned to you, and Vala is rapidly dwindling behind you.  The three of you have a playful swim in the stream to get cleaned up before Vala mends her clothing and goes on her way, thanking you for having the chance to feel what it's like to be in charge.");
			player.sexReward("vaginalFluids", "Default");
			dynStats("cor", 1);
			doNext(camp.returnToCampUseOneHour);
		}
		//Giant Vala + Vapula Threesome - Vala Lovey Dovey
		public function valaLoveyVapula3Some():void {
			clearOutput();
			valaVapulaThreesome();
			outputText("\n\nVala smiles tenderly and says, \"<i>Oh, I'll be far gentler than the demons were with me.  Besides, you're way prettier than any imp!</i>\"  She stretches out to touch Vapula, running a narrow fingertip (for a giantess) around each of the succubus's heavy breasts.  \"<i>A cutie like you can't be nearly that mean...</i>\"");
			outputText("\n\nVapula affectionately licks the faerie's finger, unsure of where this is going but happy to reciprocate when she's getting stroked so sensually.  The immense pixie grips the demon gently, lifting her up to her mouth, which even now is engorging, lips puffing out obscenely.  She gasps, \"<i>Oh, tho thenthitive!</i>\" before running her tongue across the new, puckered bimbo-lips Shouldra's chosen to gift her with, shivering from the sensations her plump puckers exude.  Then, she pops the 'small' demon inside, savoring the unnaturally curvy woman's sinfully sumptuous flavor.  The only portion of Vapula still exposed to the air is her face, which even now is spreading into a dopey smile.  She lays down on the plump lower lip like a puffy pillow, cooing lustily.");
			outputText("\n\nThe playful faerie smiles down at you around your captive and asks, \"<i>Thwuld 'ou wike tho join hermph?</i>\"  One of her hands is languidly playing with a torso-sized nipple while she makes her query, and the other has nestled itself firmly between her thighs.  You nod, too turned on by the site and the lurid, sexual scent that hangs in the air to think of anything else.  Your [armor] falls by the wayside in a surprisingly short time");
			if(!player.hasCock()) outputText(", and you buckle on your demonic strap-on, just in case");
			outputText(".  Holding your arms out to either side, you let Vala's cunt-soaked hand come out to lift you, a finger under each armpit and one between your legs, slickly sliding against the sensitive, hard prong there.");
			outputText("\n\nYou're lifted up high, which only serves to slide ");
			if(!player.hasCock()) outputText("the dildo");
			else outputText("[oneCock]");
			outputText(" even harder into your flawless faerie-skin, you moan out loud, matching Vapula's lascivious cries as she's mercilessly teased.  Your [feet] are brought up against Vala's immense lip, quickly sliding over the oral protrusion and into the steamy, warm cavern behind it.  The demon's shoulder brushes against your own, enough to rouse her from her sexual stupor and have her turn her head to face you.  Mischief twinkles in her lust-lidded eyes as she asks, \"<i>Oh, are you going to feed me, [Master]?</i>\"");
			outputText("\n\n\"<i>Only because Vala's gotten me so hard, slut.</i>\"");
			outputText("\n\nAt first, Vapula looks crestfallen by your declaration, but then her mouth opens wide, slowly exhaling a vibrating, incoherent wail of pleasure, her pupils disappearing into her skull as they roll back.  The owner of this magnificent mouth hooks part of her tongue around your [hips] and pulls you deeper.  At the same time, it rotates you and Vapula to face each other, smearing your bodies against each other in the soupy saliva and sex-juice mix that fills her mouth.  The magnificent muscle is lengthy in the extreme, coiled around both lusty bodies and heedlessly pressing you against each other, leaving you to feel warm skin and smooth tongue, always sliding wetly along your every curve.");
			outputText("\n\nThe incredible control the faerie has over her tongue allows her to pin Vapula's arms behind her back, twisting her to make her arch her towards you, her taut middle rubbing against your own as a juicy, demonic mound slaps into your crotch.  The purple slut moans at you, drooling over your [face] and Vala's lower lip, her eyes absolutely pleading for penetration as she pushes harder at you, immobilized and soaked with lust.");
			outputText("\n\nYou lick her neck, sucking hard enough to leave a hickey behind.  The demoness tilts her head back to further expose herself, aching for more.  She pleads, \"<i>Fuck me, [Master]!  Feed my naughty cunt!  Use your demon whore!  Please!</i>\"  Her eyes open wide as she makes her case, almost panicked in her fervor.  \"<i>I NEED it... the faerie has me so close!</i>\"");
			outputText("\n\nA tremendous vibration ripples through the constricting moistness of Vala's mouth, created by a low moan of pleasure that has your whole body vibrating.  You slip inside the demoness's molten-hot snatch without meaning to, but instantly, you find yourself glad you did.  The constant suckling, squeezing motions the purple pussy provides are skillful in the extreme, like one thousand tongues, each tickling at the most sensitive parts of ");
			if(!player.hasCock()) outputText("that exotic dildo");
			else outputText("your [cock smallest]");
			outputText(".  You grab hold of her ass and the tongue that's slipping through her crack and hammer your hips home, slapping against Vapula so hard that the violet woman's cries of bliss are interrupted by the breath-stealing impacts. ");
			outputText("\n\nVala's purrs come quicker and quicker while you use her mouth as a comfortable bed for your tryst, assisted by a twisting tongue that slides across your [chest], over your [butt], and around your [legs].  It flicks across your [asshole] teasingly, and the way Vapula's eyes suddenly pop open, you're sure she's experiencing the same thing.  You go back to necking with her, pumping her lust-puffed pussy with rough thrusts, frothing the sea of saliva until it's dribbling over the lips around you.  The slick bubbles slide over your faces, and you and Vapula begin to make out through them, revelling in the sticky, frictionless feeling of making love inside a giantess's mouth.");
			outputText("\n\nVapula moans into you, and her cunt goes into overdrive, those thousand tongues that you felt inside her all pulling on you, depositing long, licks that tug you toward her cervix.  She's like a starving, sexual animal, rapaciously rutting with you while Vala jills off to the mating frenzy.  Squeezing down, the purple succubus's entrance forms a tight ring, her inner tongues vanishing, and it begins to pump up and down so fast that all you feel is a blur of sensation stroking every portion of your pole at once.  You pin her hips against yours, burying yourself as fully inside her as you can, knowing that you'll cum from this in seconds, and all you need to do is savor the onrushing bliss before it explodes out of you.");
			outputText("\n\nMinutes later, you feel the cresting pleasure hit, smothering everything else in dopey, ecstatic enjoyment, a brainless, sexual climax that leaves your body shaking while you feed your succubus what she so desperately needs.  Vala obviously sees the blissed-out expressions on your faces, because not long after you start filling the demonic snatch, your host's heavy breathing peaks into a moan of excitement that coincides with a wave of girl-spunk below.  You're dimly aware of Vala creating that small river of lady-lube, but it barely registers next to the pleasant pulsations emanating from your groin, spurt after spurt of happy, nerve-shocking pleasure blasting through your form.  Even after you feel yourself coming down, her twat continues to suckle at your ");
			if(!player.hasCock()) outputText("spurting dildo");
			else outputText("[cock smallest]");
			outputText(", ensuring that every single drop is passed into her ravenous gash.");
			outputText("\n\nYou aren't sure how long you stay like that, but eventually, Vala finishes with her own pleasure and sets the pair of you down on the ground, still joined together, groin-to-groin.  You're so sensitive from your recent orgasm that separation is almost painful.  Only after you're free do you realize that Shouldra slipped back into you, and Vala is shrinking down behind you.  The three of you bathe and get dressed together, Vala using some strange magic to repair her dress before she goes.");
			player.sexReward("vaginalFluids", "Default");
			dynStats("cor", 1);
			doNext(camp.returnToCampUseOneHour);
		}

		public function kinathisValaStuff():void {
			clearOutput();
			var x:int = player.cockThatFits(50);
			if(x < 0) x = player.smallestCockIndex();
			outputText("With it so late at night, there are barely any patrons at the bar.  It's likely the bar will close up soon.  Lounging in one of the empty, comfortable booths off to the side, you wave over the short, busty bar-fairy.  Vala flutters over to you, a frothy mug in hand, smiling brightly at the sight of you.  The lovely fairy girl always seems happy to see you; rescuing her from the caves really did endear you to her a great deal.");
			outputText("\n\n\"<i>If it isn't my favorite customer.</i>\" she quips before giving you a kiss on the cheek and placing a drink on your table. \"<i>From me, as always.  I can never repay my debt to you, but it sure is fun trying,</i>\" she says with a bright smile before looking around the mostly empty bar.");
			outputText("\n\n\"<i>You know, it’s almost time to close up shop for the night.  If you don't mind waiting, we could spend some more quality time together.</i>\"  She looks into your eyes, a blush on her fair skin as she brings her now empty tray up to half hide her face.  \"<i>You know, if you want to that is.</i>\"  Her blush rises, clearly shy about asking you to have a more romantic time and not just fooling around at the bar.  The adorable display she puts on brings a smile to your face, and spending a little extra time with the cute fairy girl sure would be fun.  Nodding at Vala, you raise your mug and tell her you would be more than happy to see her after work.");
			outputText("\n\nAt the affirmation of your date, Vala nearly lets out a girly squeal before fluttering off to finish her shift and close up.  As she goes about her job, you lounge in your comfortable seat and nurse your drink, eyes watching the small, stacked woman as she moves around the bar.  You can clearly tell how pleased she is by the way she excitedly flutters around and sways her body.  Her thin hips and round rear sway as she moves, the nipples of her oversized bust pressing against her apron - either she is very excited for later, or she knows you're watching her.");

			outputText("\n\nFor nearly an hour you're there watching her, the sweet fairy refilling your drink even as the last few patrons leave the place for the night.  Finally it’s time for you to go.  You put your mug away for the morning crew to wash, and the two of you lock up and head out.  The small fairy girl smiles to herself as she hangs onto your arm, pressing your hand into her comparable mountain of cleavage.  Surprisingly, you don't even leave the Wet Bitch.  You merely walk around the side of the bar and head up a set of stairs to the upper floor of the building.  You had no idea that Vala lived so close by; she's actually been living above the bar itself.  \"<i>It’s not much, but it's nice - not very different from my old home in the forest with the other fairies.  I do miss them, but here I can see you,</i>\" she says softly as she unlocks the door and lets you inside.");

			outputText("\n\nThe small woman steps to the side and lets you in, allowing you to gaze upon her place of living.  For a relatively new resident of the city, Vala has clearly been hard at work making this place her home.  The walls are lightly decorated.  The shelves hold baubles and other shiny things.  Hoping that you approve of her home, Vala steps in and closes the door behind herself.  \"<i>What do you think? I’ve been working on this place since I got here.  It wouldn't have been possible if you hadn’t come along and saved me,</i>\" she says as she hugs you from behind, holding onto you for a moment before moving around you and taking your hand in hers.");
			if(player.tallness > 75) outputText("  She looks up at you as you seem to tower over her, a");
			else outputText("  A");
			outputText(" faint blush on her cheeks as she smiles and hugs your arm, beckoning you to follow.");

			outputText("\n\nIt’s obvious where the sweet fairy is taking you.  The door to her bedroom soon opens at her touch, and she pulls you inside, closing the door behind you.  The small room is like any normal bedroom, a bed, a dresser, a closet.  Though it looks average to you, a bed like this would be huge for a woman like Vala, giving her plenty of room to sleep on or have fun in.  Even as you think this, she bounds up onto the bed and lounges on it.  \"<i>Ohhh, I just love this bed, it's so soft and nice, so much better than a cold cave floor.</i>\"  You snicker at her words and actions; it's clear she really enjoys her freedom.");

			outputText("\n\nShe looks up at you before reaching forward and pulling you down onto the bed.  \"<i>Oh, come here you!</i>\" she says as she wraps you up into a passionate kiss and pulls your body over hers.  \"<i>You really changed my life you know.  Without you, I would still be locked up in that cave, broken and being fucked by imps all day.  I have to say, I...  umm... I like being fucked by you much more,</i>\" she says with an amorous grin spreading over her lips.  Seeing as you're already on her bed and that the sweet little woman wants you so badly, there is no reason to hold back.  Your hands grab her roughly, pushing her down against her bed with you above her.");

			if(player.tallness < 65) outputText("\n\nThe feeling of you pinning her down like this sends a shiver through your fairy lover.  Despite how she was treated before, she clearly loves having you do this to her.  Leaning up, she eagerly presses her oversized breasts against you as she plants kisses on your body.  \"<i>Yessss.  Just you, just my hero.  My perfect hero,</i>\" she hisses huskily to you as she slips her hands over your body, feeling you up before turning her attention to her clothes.  Desperate to feel your " + player.skinFurScales() + " against hers, she strips herself of her dress and slips her hands into your [armor] to get you out of it as well.");

			//[tallness >65:
			else outputText("\n\nThe feeling of you pinning her down like this sends a shiver of delight through your fairy lover.  Having her big strong hero above her like this, dwarfing her short frame, is clearly turning the girl on like nothing else.  Despite how she was treated before, she clearly loves having you do this to her.  Leaning up, she eagerly presses her oversized breasts against you as she plants kisses on every inch of your body she can reach.  \"<i>Oh yessss.  My hero, my big strong hero.  So wonderful, so perfect,</i>\" she purrs to you as she slips her hands over your body, feeling you up before turning her attention to her clothes.  Desperate to feel your " + player.skinFurScales() + " against hers, she strips herself of her dress and slips her hands into your [armor] to get you out of it as well.");

			outputText("\n\nYou can't help but shiver at her touch.  Now that she has you here, she’s taking her time with you. Here, she can enjoy your company, really get into the intimate nature of having sex with her hero.  Planting delicate kisses along your neck, the fairy girl hooks her legs around you, grinding her body against yours.  The sweet heat of her arousal pours off her as she grows more and more needy for you.  The slick burning wetness of her small tight snatch rubs against you, letting you feel how wet and ready she is for you.");

			outputText("\n\nNot wanting to get to the end so quickly, you pull your little lover up and seal her lips with a kiss, your tongue probing her mouth to find her tongue, the lovely fairy leaning in to meet you eagerly.  She lets out a soft tender moan, clearly loving the intimate contact of her lips against yours.  Her arms tighten around you as her tongue rubs and caresses yours, letting you know how much she wants you.  Wanting to take this even further, you roll over, putting Vala on top.  Pulling the sweet fay-girl into your lap, you take her hands and guide them to the throbbing hardness, letting her feel [eachCock].  She blushes and grins, wraps her hands around your ");
			if(player.cockTotal() > 1) outputText("most appealing phallus");
			else outputText(cockDescript(x));
			outputText(" and starts to stroke it.  Leaning down, she licks her lips and gets down between your legs, her eyes and body set on tasting your hard-on.");

			//[cock area <17:]
			if(player.cockArea(x) < 17) outputText("\n\nPlanting a kiss right on the head, she draws her tongue around, slowly teasing and licking you.  \"<i>Hehehe, a perfect size for someone like me,</i>\" she says in between lips and delicate kisses.  Her soft lips tease you like fluttering butterflies, leaving a gentle tingling across your sensitive flesh.  Closing her eyes, the passionate fairy wraps her lips around you and starts to gently suck, her hands holding your hips as she slowly starts to bob her head up and down your shaft.");
			//[cock area >17 <30:
			else if(player.cockArea(x) < 30) outputText("\n\nPlanting a kiss right on the head, she draws her tongue around, slowly teasing you and tasting you.  \"<i> Mmmm.  What a nice big dick you have here.  Yesss, so much for little Vala to love.</i>\" she says in between lips and delicate kisses.  Her soft lips tease you like fluttering butterflies, leaving a gentle tingling across your sensitive flesh.  Opening wider, the passionate fairy dives headlong into her delicious task, eagerly licking and sucking every inch she can get at to pleasure you.  Her hands gently take a hold of your hips as she bobs her head up and down, wanting nothing more than to taste her hero.");
			//[cock area >30:
			else outputText("\n\nPlanting a kiss right on the head, she draws her tongue around the thick head, slowly teasing you.  \"<i>Ooohhh, so big and strong.  So much of my hero to play with,</i>\" she says with a giggle before returning to her teasing task.  Her soft lips tease you like fluttering butterflies, leaving a gentle tingling.  Opening her mouth as wide as she can, the passionate fairly dives headlong into her delicious task, eagerly licking and sucking every inch she can get at to pleasure you.  Her hands gently take hold of your hips as she slowly bobs her head up and down, wanting nothing more than to taste her hero.");

			outputText("\n\nHer diminutive tongue sucks around your " + player.cockHead(x) + ", teasing and dancing circles around you.  Her silky hair feels good around your fingers, making the perfect hand-hold as you keep her in place as she sucks and plays with you.  Pulling back with a slurp and a gasp, Vala licks her lips before kissing her way down your shaft.  ");
			if(player.cocks[x].cockType == CockTypesEnum.HORSE) outputText("Her tongue licks around the throbbing glands, the heady animal musk filling her nose and mind with sweet lust.  ");
			else if(player.cocks[x].cockType == CockTypesEnum.DOG) outputText("Her tongue licks around the hot building knot that gently throbs at your base.  ");
			//[anemone cock:
			else if(player.cocks[x].cockType == CockTypesEnum.ANEMONE) outputText("Her tongue plays with the squirming tentacles that line the drone of your throbbing phallus.  She shivers and groans as the tentacles sting her full of pleasurable aphrodisiac.  ");
			outputText("Playing her way down your cock, the fey-girl gently licks up and down, sucking along your cumvein before coming back to the " + player.cockHead(x) + " of your meaty prick.");

			outputText("\n\nHer sweet lips plant a firm kiss right on the tip before pulling back and licking those tender cock-suckers clean of your unique flavor.  The hunger for her lover, the aching desire for her hero to fuck her is too strong to hold back a moment longer.  For once, the busty fairy lays before you instead of jumping you to ride you as she likes to do.  Her soft luscious thighs spread for you, showing off her small soaking mound and dripping snatch.  Her eyes glitter with amorous mischief as she looks you up and down.  \"<i>Come on hero, you need to come and claim your spoils.  Little Vala wants it so bad, make her scream your name,</i>\" Vala says as she slides a finger along her slippery slit before spreading her quivering nethers open for you.");

			outputText("\n\nWith such an initiation and the small stacked woman looking up at you with lust and adoration, how can you say no?  Her body is so open to you, craving your touch and the sexual nirvana she knows you can bring her.  Grabbing her legs, you pull her closer to you and lean down over her, gently pinning her to the bed as you slide between her soft, silky thighs.  Your hands find her bountiful breasts, and your fingers sink into the soft, pliant flesh.  The pale, milky teats are already dripping their sweet fairy cream for you, just begging for your lips to wrap around a nipple and suckle your fill from them.  Licking your lips at the thought of her sweet offerings, you look down to take in the lovely fey-girls appearance, her milky skin, her tender feminine face, her glittering lilac-colored hair.  Vala’s bright eyes look up at you with adoration, a blush on her fair cheeks.  A smile breaks across her lips as she reaches up and slides her arms around your neck.  She leans up and kisses your lips once more.  More than ready for you, Vala REALLY wants you.");

			outputText("\n\nNot wanting to wait a moment longer, you surge forward, pushing your " + cockDescript(x) + " between her  thighs, the " + player.cockHead(x) + " gently probing the small tight sex that lay between them, her fey-honey oozing from the womanly flower like sweet nectar from the most exotic of plants.  The touch of your meaty masculinity against her puffy, sensitive nethers draws a gentle gasp from the excited woman.  Taking hold of her hips, you push forward and sink your aching, throbbing spear into her tender, needy body.  ");
			//[cockarea <17:
			if(player.cockArea(x) < 17) outputText("Despite her size, you slide in easily, her wet, slippery pussy taking you in and squeezing you in a velvety embrace.  \"<i>Yessss, it's in, it's in!  Mmmm, come to me hero, come to Vala,</i>\" she croons to you, beckoning  you to take her.");
			else if(player.cockArea(x) < 30) outputText("\"<i>Ahhh...  yesss, it's in!  Ohh...  come to me hero, come to Vala and fill her with your love!</i>\" she croons to you, beckoning  you to take her.");
			else outputText("Ohhh! Ahhh...  Y-Yessss...  Vala’s big strong hero, oh you feel so good inside me!</i>\" she moans and groans as you stretch her tight little fairy cunt with your pulsing prick.  Her stretchy flesh distends as more and more of your cock is fed into her hungry pussy.");

			outputText("\n\nDeeper and deeper you delve into Vala’s tight squeezing depths, her silky snatch squeezing down around you, rippling with the earthy delight of her magical body.  Her tender, eager muscles seem to move on their own, squeezing down one after another, working you from base to tip as if to milk you of your virile offerings.  You’re sorely tempted to grab hold of her and have your way with the willing girl, to screw her brains out and make her scream with utter ecstasy.  Managing to keep control of yourself for now, you grab her hips and sink every inch you can into the hot welcoming body of your little lover.");
			if(player.cockArea(x) > 17) outputText("  Her hot little body stretches around your girthy prick, distending her belly as you sheath your throbbing arousal into her.");

			outputText("\n\nYour hands roam over her as you buck your hips into your fairy lover, your hands groping her round ass, her massive milky mammaries swaying and jiggling from your hard thrusts.  The bounce and ripple of her creamy udders is too much to bear, their hypnotic shakes drawing your hands to them, squeezing and manhandling those luscious orbs.  Spurts of rich milk splash across your " + player.skinFurScales() + " as you pinch and squeeze her nipples.  The rough touches, the pinching, the squeezes and gropes draw long moans and groans from the panting, lusty fairy.  Your fey-lover murmurs your name as you take her, beckoning you for more, for you to keep fucking her and to make her scream.  \"<i>Haa haa, ohhhh, yessss fuck me, fuck Vala’s tight little cunt!  Give me all your burning love!</i>\" she pants and cries out as she bucks her hips up to you, her arms reaching up to hold onto you as you start to speed up your thrusts.");

			outputText("\n\nHer passionate cries focus your attention on her, her face the picture of carnal bliss and her eyes murky and unfocused.  They occasionally roll up when a wave of pleasure hits her.  Her tongue lolls from her lips.  Her breath pants hard alongside each cry of delight you pull from her as you plumb her tender depths.");
			if(player.hasBalls()) {
				//if ballsize <3:
				if(player.ballSize < 3) outputText("  With each hard quaking thrust your balls slap against Vala’s expansive ass.  Your nuts ache under their pent-up load and demand you to shoot it into the sweet fey-girl soon.");
				else if(player.ballSize < 6) outputText("  With each hard quaking thrust, your balls smack against Vala’s cushiony ass.  Your hefty, cum-bloated sack, so full, aches for the sweet release into your tender fairy lover.");
				else outputText("  With each hard quaking thrust, your fat balls slam against Vala’s pale squeezable ass.  The huge, virile spunk-factories go into overtime, their already taut skin growing tighter as they swell and bloat with your pent-up load.  Your body's natural instincts demand you do your duty as the breeder you are and pack your small lover’s womb full of your spunk until her belly is swollen and seeded with your young.");
			}

			outputText("\n\nHotter and hotter your passion flares, your wild bucking thrusts rocking and battering your short curvy lover’s body over and over, your " + cockDescript(x) + " pounding her hungry pussy harder and faster, desperate to reach that peak of pleasure.  Wrapping your arms around Vala’s small body, you squeeze her against you as you finally reach your climactic end.  Gritting your teeth and growling to your tender lover, you ram your hips against her and sink every inch of throbbing cockflesh into her receptice body as you can fit.  The sudden hard thrust combined with the feeling of your aching mast pulsing and swelling inside her at your orgasm makes your sumptuous sweetheart groan and moan as her eyes roll back from the feeling of your hot spunk rushing into her.  The raw, blissful nirvana of the rampant sex and impending creamy injection bring the overexcited fairy to an explosive squirting orgasm.");

			//[cum volume low:
			if(player.cumQ() < 250) outputText("\n\nGasping in pleasure, you keep your hips pressed against Vala’s, your cock crammed deep inside her small body as you squirt your cum into her belly.  Your little lover wraps her legs around you, squeezing herself against you to get as much of your hot seed inside her body as she can.");
			else if(player.cumQ() < 1000) outputText("\n\nGrunting hard, you gush over and over into your sweet fey-lover.  You hold yourself tighter against her, making sure you force as much of your spunk into her waiting, hungry womb as you can.  Your little lover wraps her legs around you, squeezing herself against you to get as much of your hot seed inside her body as she can.  Her tight, toned tummy gently pushes out from the creamy cum being pumped into it.");
			else if(player.cumQ() < 3000) outputText("\n\nGasping and groaning, you unleash gush after gush of thick, rich cum, basting your fey-lover’s womb with your virile spunk.  Wedging yourself as tightly against her as you can, you make sure that every drop packs into her tender belly.  Your little lover wraps her legs around you, squeezing herself against you to get as much of your hot seed inside her body as she can.  The potent flow of your seed quickly swells her stomach into a cute, cum-bloated paunch.");
			else outputText("\n\nYour eyes roll up, your mouth hangs open, and you grunt long and hard as your seed floods Vala’s tight, squeezing cunt like a frothy flood.  Wave after wave of your thick, creamy spunk forces its way through her convulsing cunt and right into her eager, waiting womb.  Your little lover wraps her legs around you, squeezing herself against you to get as much of your hot seed inside her body as she can.  Geysers of spunk force their way into her womb, filling it fuller and fuller until her belly swells.  Her once tight, flat tummy rounds out into a healthy, round cumbaby, your thick, yogurt-like spunk overflowing from her over-stuffed snatch in sticky streams.");

			outputText("\n\nThe sweet relief of your orgasm washes over you, the blissful afterglow turning your arms and [legs] to jelly as you settle over your small panting lover.  Vala’s body is sweaty and hot from the passionate sex.  Her arms wrap around you, hugging her body against yours as she whispers to you and snuggles against you.  \"<i>Ohhh... that was... you are amazing...</i>\" she says blissfully as she nuzzles her face against your body, her cunt clenching hard around you as she cuddles up against you.  As you lay there holding her, you can hear her whisper softly to herself, muttering sweet nothings into the air to you.  Her fingers run over your [chest], drawing little shapes and hearts over your skin as she hums.  Smiling to yourself, you stroke her head and hold onto her, cuddling up with your tender fairy.  Leaning in, you plant a tender kiss in her hair before you settle in for the night with the oversized fairy.");
			player.sexReward("vaginalFluids", "Dick");
			dynStats("lib", -1, "sen", -2);
			doNext(valaPartIIWaifuLove);
		}

		//[next]
		public function valaPartIIWaifuLove():void {
			clearOutput();
			CoC.instance.timeQ = 10;
			camp.sleepRecovery(true);
			CoC.instance.timeQ = 0;
			camp.sleepRecovery(false);
			statScreenRefresh();
			outputText("Letting out a yawn, you curl up in the warm covers of the bed.  You sigh and smile as the smell of food wafts over you; it reminds you of your time back home.  The scent of frying meat and eggs soon becomes too much for your sleeping mind and rouses you from your slumber.  Stretching your body out, you look around and remember your night with Vala; you must have fallen asleep in her bed.  Unable to help yourself, you follow the mouth watering aroma to the kitchen and find the loving fairy-girl there.  Her gossamer wings flutter as she hovers at the stove, naked save for the apron she wears.  The sound of grease popping and crackling fills the air along with the smell of a savory, home cooked breakfast.");
			outputText("\n\nYou can't help but grin, the sweet girl treating you to breakfast after spending the night with her.  Approaching her, you slip your arms around her and hug her gently.  Despite your surprise hug, Vala keeps working, though she is more than happy to press her ass against you.  \"<i>Mmmm... good morning, did you sleep well, [name]?</i>\" she asks as she looks up at you with a bright smile of her face.  You smile back at her and slide your hands into her apron to grope and fondle her oversized breasts, the rough touch pulling a squeak and a soft moan from her lips.  \"<i>H-hey! You're supposed to be enjoying my food, not me!</i>\" she says with a blush on her cheeks, clearly not really minding your hands on her.  Looking back at the food she is preparing, Vala reluctantly pulls away.  \"<i>Breakfast is done - my treat, now let’s eat!</i>\" she cheerfully announces as she takes the food off the stove and plates the mouth-watering feast.  Each plate is blessed with a trio of bacon strips, two fried eggs and two plump sausages.  Shivering in delight at the meal ahead of you, you say a heartfelt thanks to Vala before digging in with her.");
			outputText("\n\nIt’s a wonderful change of pace from the usual food you have in the morning.  The salty, savory meats and eggs fill you up, spreading a satisfied warmth through you as you eat.  Unfortunately for you, the deliciousness of the filling meal means it’s devoured quickly, leaving you almost uncomfortably full.  Letting out a sigh, you slide an arm around your fairy lover and pull her closer, cuddling with her at the table for a moment before pulling her into your lap.  Your hands run over her body and stroke her softly as you settle into the intimate, post-meal moment.  Vala smiles and presses herself against you, her arms curling around you as she snuggles you.  \"<i>My hero...  I wish we could stay like this forever, [name]</i>\" she says as she nuzzles her face into your [chest].");
			outputText("\n\nWith her being as affectionate she is, you can't help but smile and stroke her.  This really was nice; you could see yourself enjoying many more times like this, but unfortunately you do have to get back to your duty.  Pulling Vala into a kiss, you squeeze her and hold her tightly against you for a moment before lifting her off you, telling the girl that you have to go.  She sighs, knowing that you have to get back to being her hero.  \"<i>I know, go and be the big strong hero I know you are, just make sure you come and visit me at the bar whenever you want,</i>\" she says before kissing you one last time and showing you to the door.  Breathing in the morning air, you head back to camp to check up on the place.");
			//[return to camp][set clock to 7am]
			doNext(camp.returnToCampUseOneHour);
		}
	}
}
