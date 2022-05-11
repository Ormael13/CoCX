/**
 * Created by aimozg on 05.01.14.
 */
package classes.Scenes.Areas.Desert
{
import classes.*;
import classes.BodyParts.Tongue;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Areas.Forest.TentacleBeast;
import classes.Scenes.Areas.Mountain.Minotaur;
import classes.Scenes.Areas.Plains.Gnoll;
import classes.Scenes.SceneLib;
import classes.display.SpriteDb;

	public class AntsScene extends BaseContent
	{
		public const phyllaCapacity:Number = 50;

		public function AntsScene() {}

		public function phyllaSprite(nude:Boolean = false):void {
			if (nude) spriteSelect(SpriteDb.s_phylla_nude);
			else spriteSelect(SpriteDb.s_phylla);
		}

		public function antColonyEncounter():void
		{
			//WAIFU GET!
			trace("ANT WINS: " + flags[kFLAGS.ANT_ARENA_WINS] + " ANT LOSSES: " + flags[kFLAGS.ANT_ARENA_LOSSES]);
			if (flags[kFLAGS.ANT_ARENA_WINS] - flags[kFLAGS.ANT_ARENA_LOSSES] >= 2 && flags[kFLAGS.ANT_ARENA_WINS] >= 4 && player.gender > 0) {
				if (flags[kFLAGS.PHYLLA_STAY_HOME] > 0) bumpIntoTheAntColonyAfterStayHomePhylla();
				else antGirlGoodEnd();
			}
			else if (flags[kFLAGS.PC_READY_FOR_ANT_COLONY_CHALLENGE] == 1)
				antColonyChallenge();
			else if (flags[kFLAGS.PHYLLA_SAVED] == 1)
				enterTheColony();
			else firstAntColonyEncounter();
		}

//First Encounter
//[Explore Desert]
		private function firstAntColonyEncounter():void
		{
			clearOutput();
            phyllaSprite();
			outputText("While traversing an unfamiliar part of this desert wasteland, ");
			if (player.cor > 75 && player.lust > 50) outputText(" looking for something to slake your unquenchable lusts, ");
			outputText("you come across an abandoned merchant's cart.  The cart looks eerily disheveled, with a majority of its contents strewn about the sand.  Whoever or whatever deserted this thing did so in a hurry, and for seemingly no reason.")
            //add button to avoid savescumming
            outputText("Do you want to approach the cart <i>right now</i>, risking to attact demon's attention, or leave?\n\n");
            menu();
            addButton(0, "Inspect", approach);
            addButton(1, "Later", later).hint("Maybe later? You have other business right now.");

            //options
            function later():void {
                outputText("The cart is standing in the middle of the desert, and still nobody has looted it? It's clearly a trap. And you're not ready to risk your life for any rubbish inside it right now. You return to your camp, hoping that the time you'll be strong enough.");
                camp.returnToCampUseOneHour();
            }

            function approach():void {
                outputText("Curious, you decide to inspect it for anything worthwhile.");
                outputText("\n\nSuddenly a loud crash erupts from inside the cart.  Instinctually you dive behind some large rocks, quickly re-evaluating the cart's dereliction.  The crash is followed by a clattering of sounds as if someone is stumbling around from within.");
                outputText("\n\nYou watch as a creature awkwardly climbs out the back of the wooden mess. As you've never seen anything like her before, you hold your position, deciding to watch before assessing the potential threat.  Quietly and stealthily, you shift position to get a better view of this ransacker.");
                outputText("\n\nYour eyes widen and your mouth hangs agape when you realize she has four arms!  Her two primary arms are attached at her shoulders, where you would expect, but a smaller set is attached to the sides of what you assume is her ribcage, just below the armpit.  All of her arms and legs are covered in shiny black chitin; the joints of her body seem to interlock with each other, giving her a very insectile appearance.");
                outputText("\n\nShe has an extremely lean and muscular frame, albeit one with wide, girly hips.  The muscles on her torso are clearly visible, though the coverings on her appendages make it impossible to assess the underlying body.  You feel safe in assuming she's fairly strong, however - judging by how she upturns the cart with ease to look under it!  She sports a slightly feminine face with thin lips and two completely emerald-green eyes.  You watch as she holds up trinkets and knick-knacks; curiously examining them at first, then indifferently discarding them.");
                outputText("\n\nHer abdomen seems to bend and bob with her hips as she rummages through the broken cart.  Every now and then she pulls a crude sundial from a carrying pouch about her hips and checks it laboriously against a flat surface, as if she's on some kind of deadline.");
                outputText("\n\nHer second set of arms blocks you from getting a full view of her chest, preventing determination of her cup size.  Though, you do get several pleasing partial views while she ransacks the cart...  Wearing almost no clothing probably isn't uncommon for her, judging how open she is with her nudity.  Her tan skin looks smooth as the sun glints off her black chitin plates. A small loincloth does its best to cover her genitalia, but with the gusting desert wind, the small garment is nearly useless.  The lips of her vagina appear to be as smooth as the rest of her skin, with no signs of hair - not surprising, when you consider her insect-like appearance.");
                outputText("\n\nHer short sandy-brown hair seems to be unkempt and in tangles, although a tarnished golden tiara with dangling gems catches the sunlight and gives the hair some style.  You wonder if she found the tiara while searching the cart, or if she had it before.");
                outputText("\n\nAs you consider your options, a group of demons crests the sand dune directly across from you.  Like you, they seem just as confused at the sight of the strange girl.  Unlike you, they make no effort to hide.  Once they see the ant-girl is alone, they quickly descend on the cart; the poor girl is taken completely by surprise.  Clearly she's never faced such a large group of demons before. The cracked flower vase she's holding her in hands shakes visibly as horror etches itself on her face.");
                outputText("\n\nYou could watch from where you're hiding, or you could play the hero and step in.");
                simpleChoices("Play Hero", playHero, "Keep Hidden", keepHidden, "", null, "", null, "", null);
            }
		}

//►[Keep Hidden]
		private function keepHidden():void {
			flags[kFLAGS.ANT_COLONY_KEPT_HIDDEN] = 1;
			//If Male/Female/Herm and Corruption & Libido Under 40 OR If Unsexed Leads to - If Under 40
			//If Male/[Use Dick - Herm] and Corruption & Libido Over 41 Leads to - If Over 41 - Male
			//If Female/[Use Vagina - Herm] and Corruption & Libido Over 41 Leads to - If  Over 41 - Female
			//If Under 40
			if ((player.lib < 41 && player.lust < 50) || player.cor < 66 - player.corruptionTolerance || player.gender == 0) {
			    clearOutput();
                sceneHunter.print("Failed check: High libido/lust, high corruption, not genderless");
				outputText("After seeing the large pack of demons you decide it's best not to act.  You yourself are in no condition to help the poor creature, and knowing full well what comes after demons 'subdue' their prey, you don't want to stick around either.  You glance over and realize the skirmish has already started.  It's too late to really help her anyway, you argue to yourself, plus she's covered in muscle.");
				outputText("\n\nAssuring yourself that she'll be fine, you take the opportunity to flee while the demons are distracted, heading back to camp.  Leaving the ant-girl to her fate.");
				//[End of Event]
				doNext(camp.returnToCampUseOneHour);
			}
            else demonsFuckAntgirl();
        }

        public function demonsFuckAntgirl():void {
			clearOutput();
			outputText(images.showImage("ants-desert-male-firstencounter"));

            sceneHunter.selectGender(dickF, vagF);
            //PARTS
            //==========================================================================================
            function dickF():void {
				outputText("You know exactly what's going to happen once the demons 'subdue' their prey.  The growing throbbing in your loins begs for release, and you quickly and quietly take off your [armor], making sure the demons don't notice you.  You might as well watch the show as you're not gonna be able to leave unnoticed until the demons are done anyways.");
				outputText("\n\nWatching from your hiding spot you start to stroke your [cock].");
				//Start Dick Size Check
				var x:Number = player.biggestCockIndex();
				//If player can auto-fallatio:
				if (player.cocks[x].cockLength >= 20) outputText("  Licking the head of your [cock " + (x + 1) + "] in anticipation of what's to come only adds to your growing lust.");
				//If player cock size tiny:
				else if (player.cockArea(x) < 6) outputText("  Though your cock isn't the most impressive, it's 'got it where it counts' and you intend to make the most of it.  You lovingly tease yourself until you're fully erect; running your fingers down the ridge causes a bead of pre-cum to form on your tip.");
				//If player cock size normal:
				else if (player.cockArea(x) < 12) outputText("  You hold your cock like the hilt of a sword and start to pump your shaft slowly.  Your breathing becomes heavier and labored, as you stroke yourself with mounting passion.");
				//If player cock size large:
				else if (player.cockArea(x) < 30) outputText("  The fear of having your cock give away your position quickly passes through your mind, but it's too late now.  The only way out of this is to cum, so you might as well enjoy it.  You firmly grasp your cock and start jacking off, hoping that you'll finish sooner rather than later.");
				//If player cock size MASSIVE:
				else outputText("  The towering meat log jutting from your crotch gives away your 'hiding' spot, but the demons don't seem to mind, as they're too busy with their new toy.  You doubt even if they did care that any of them would be able to satisfy you. You wrap your arms around your fully erect cock and start to pump, hoping to release your load soon.");
				outputText("\n\nThe ant looks like she's trying to resist, waving all four of her arms wildly and tossing whatever she can get her hands on at the demons.  After a quick, one-sided skirmish, the demons pacify her.");
				outputText("\n\nAn extremely handsome and well-endowed demon stands in front of her and presses his cock against her thin lips.  The ant pulls her head back in surprise, and looks confused.  Apparently she's never sucked a dick before - the thought sends a little thrill through you, and you wish briefly that it were your own penis pointing at her demure mouth.");
				outputText("\n\nOnce the demon realizes she's not getting the picture he grabs her hair and pushes his dick into her face, smearing her lips and cheek with his pre-cum.  As the girl still refuses to welcome his cock, he next grabs her neck and chokes her until she gasps for air.  Seizing the opportunity he shoves his dick deep into her throat.");
				outputText("\n\nYou're sure the ant would have screamed had her mouth and throat not been stuffed full of demon dick.  You can see the look of pleasure on the demon's face as he exhales.  The struggling ant-girl still hasn't given up hope of escape.  She tries again to wiggle free, but two more of the demons holding her take their cocks and place one each upper hand, forcing her to start stroking with their own.  The other arms become playthings of two female demons, who shove her smaller hands into their cunts.  After a few pumps she starts to get the idea; although you can tell she's obviously not experienced, she does her best to please all five demons at once.  The rest of the crowd watches from the sidelines, pleasuring their own genitalia.");
				outputText("\n\nThe demon getting the blowjob roars out in pleasure, then removes his cock from her mouth; the ant coughs up a small amount of the demon's bubbling seed, dribbling it on her chin and breasts.");
				outputText("\n\nGriping half-heartedly at how 'unfair' it is that he should cum first, the male demons in her upper hands decide to finish themselves off, abandoning technique and pistoning her hands up and down their shafts, then spilling their hot semen on the ant's breasts and face, to mingle with the first's.  The female demons begin making out with each other sloppily at the sight of the spilled seed, dipping their fingers in it and reaching between each others' thighs.  They rub their clits and lips as the ant's hands thrusting inside them overwhelms them, and with loud moans they finish in unison.  All five step back, allowing the rest of the demons who've been waiting to take their turn.");
				outputText("\n\nWatching from the rocky outcrop that hides you, you stroke [eachCock] with mounting excitement, running your hand up and down the shaft and picking up speed as you watch the demons cum one after another.  Seeing this girl get used as a cum depository is way hotter then what you imagined it would be.");
				outputText("\n\nRight when you're getting close to cumming yourself, you witness one of the demons flipping her onto her backside.  She quickly curls up like a spider, pulling all of her limbs inward and curling her abdomen up to her chest, in a vain attempt to protect her womanhood.  The demon says something to his friends you can't quite hear; the way some of the finished participants jump to obey gives you your first clue that here stands the leader of the group.  The subordinates help the scared ant 'open up', pulling her abdomen away from her stomach and spreading her legs apart; the main demon then places his massive meat musket on the lips of her vagina.  You can see her body, aroused by the musky seed and the sexual treatment, has already given its answer independent of her will; sunlight glints off the wetness between her legs.");
				outputText("\n\nThe leader drags his demonic head up and down along her slit, waiting for her libido to overwhelm her resistance to the idea.  You hear a very strange series of clicks that sounds like the last pleading of this poor rape victim.  Could she be a virgin?  With an audible scoff, the demon shoves his demonic member inside.");
				outputText("\n\nThe girl writhes and contorts but the other demons hold her firm, laughing at her discomfort.  There's no doubt in your mind now as to her virgin status, and your strokes pick up more speed.  You watch, rapt, as the first demon finishes inside her, eyes rolling back in his head.  Almost immediately, he's replaced by another, pride of place satisfied and the girl's now-despoiled vagina open to all.  One of the female demons sees her semen-spattered mouth no longer in use and places herself over the ant-girl's face.  Again, the ant fails to start pleasuring her captor immediately, either over-stimulated by the demon currently inside her or completely defeated by the loss of her virginity and resigned to being used like a toy.  The female demon grabs her victim by the sticky brown-and-now-white hair and shoves the ant's face into her cunt, then coos, pleased by the new sensations, and wraps a spaded tail around the girl's neck to lock her face there.  The demoness reaches down and, locating the ant's smaller set of hands, guides them up to her large, swollen clit and begins stimulating herself.");
				outputText("\n\nYou're almost ready to blow your load when a hermaphrodite demon with what must easily be a 20-inch prick steps up to the plate.");
				outputText("\n\nThe hermaphrodite struggles to cram itself inside the ant-girl and eventually succeeds.  With each stomach-contorting thrust you hear the ant's muffled moans of pain and ecstasy from between the legs of the female demon.  The hermaphrodite quickens his thrusts and, in turn, you keep speed.  With near-precision timing, you and the demon finish together.  " + SMultiCockDesc() + " throbs and a wave of euphoria washes over you.  Groaning in pleasure you release your ");
				//[no new PG, Start Cum Check
				if (player.cumQ() < 100) outputText("sizable");
				else if (player.cumQ() < 1000) outputText("huge");
				else if (player.cumQ() < 10000) outputText("massive");
				else outputText("titanic");
				outputText(" load.  Once you can refocus your eyes, you see the hermaphrodite pull out, and as it does a burst of cum sprays out of the ant-morph's vagina as her stomach deflates slightly.  She's been filled with so much corrupt seed that it's stretched her belly to the point it resembles a third-trimester pregnancy.");
				outputText("\n\nYour body satisfied, you drift off.  When you awaken much later, the demons and the ant seem to have moved on, thankfully without noticing you.  You put your armor back on and return to camp.");
				//[End of Event]
                sharedEnd();
            }
			function vagF():void {
				outputText(images.showImage("ants-desert-female-firstencounter"));
				outputText("Watching from your hiding spot, you consider what's going to happen and feel your pussy immediately moisten.  Your practiced hands move with deftness, slipping into your [armor].");
				outputText("\n\nFeeling your heat through your [armor], you quickly and quietly strip, every now and then glancing down to make sure you're not seen.  Once you're completely nude, you find a nice vantage point to view the impending rape.  By the time you've gotten yourself ready, you realize the demons have already started.");
				outputText("\n\nRunning your hands over your breasts, you pinch your [nipple] and give a soft coo, careful to keep your voice down.  Alas, your body's reactions start to overwhelm your senses and you slowly begin to forget that you're even trying to hide.");

				//Unique Prerequisites
				//If PC is lactating:
				if (player.lactationQ() > 100) outputText("  You feel your warm milk flow out of your hardened arola, as your body begs to release its sweet nectar.");
				//If PC has dick(s):
				if (player.hasCock()) outputText("  Feeling [eachCock] throb between your legs, you run one of your hands down your chest and start to stroke lovingly.");

				outputText("\n\nBlood still concentrating on your crotch, you set your fingers atop your vagina, resting lightly on your [clit], then rub the lips of your labia until your juices start to dribble down your legs.  In a slow circular motion you start to massage your clit as you watch the scene unfold before you.");
				outputText("\n\nOne of the demons is forcing his sizable cock down the helpless ant-girl's throat, while two more have begun to jerk themselves off using her upper hands as maturbation aids and yet another pair, female this time, force the ant to finger them.  You can clearly discern their moans and grunts even from your hiding place.  Hoping the mob won't hear you over the sounds already being made, you slide a finger inside yourself and add your moans to theirs.");
				outputText("\n\nThe demons force their new cum dumpster into a doggy-style position, laughing at her discomfort.  One of the many hermaphroditic demons distinguishes himself from the others as he grows erect, aided by a subservient who had been and still is trying to suck his impressive demonic cock; this demon saunters up to the ant-morph and licks his lips.  The hermaphrodite lifts the ant's chitinous abdomen and exposes her cunt; the ant-morph, who had all but given up struggling to free herself, suddenly starts to squirm again as her womanhood is exposed.");
				outputText("\n\nThe demon looks surprised briefly, then smiles devilishly as a sudden realization strikes.  Massaging his pendulous breasts with one hand, the demon begins to tease the ant's pussy with his demonic cock, a monstrous member at least 20 inches in length, dragging the huge head up and down the girl's entrance.  The ant, alarmed, begins to protest with a series of clicks and frantic flails, but when one of the female demons waiting on the sidelines sees the open mouth, she steps up and slides her cunt across the ant's face, quieting her.  Taking his cue from the demoness, the teasing hermaphrodite suddenly shoves his demonic dick, balls deep, into the ant's wet pussy.  You can see the stomach of the ant contort as the demon starts to pump, and both demons slap their hands together in a high five, clearly pleased with themselves.  The herm quickly yields to the pleasure, setting his jaw and pounding rapidly, and you slip several fingers inside yourself as you imagine what his cock must feel like.");
				outputText("\n\nThe hermaphrodite demon pumps faster and faster, building to release.  With a groan that even you can hear, he gives one magnificent back-arching thrust and releases his seed into the ant-girl's womb.  With a heavy sigh of satisfaction, the hermaphrodite's cock flops out of the ant along with a dribbling trail of cum and a little blood.");
				outputText("\n\nOnly now do you realize that the ant must have been struggling to preserve her virginity!  A little envious of the ant for having such a magnificent cock as her first, you jill yourself less and less carefully; you're close to your own climax, but try your best to hold out until the demonic group have all finished in turn.  By the time the third demon has ejaculated inside the ant-morph and the dribble of spunk from her used hole has increased to a rivulet, however, it's too much for you to withstand.  You begin rubbing your clit with one hand as your other seeks out your g-spot inside your drooling cunny.");
				outputText("\n\nWhen the next demon lines its cock up with the ant's vagina, you slip your fingers deep inside yourself.  Watching as the demon pumps, slowly at first but with mounting passion, you mimic his rhythm, imagining him inside you instead.  Your other hand's experienced fingers work quickly over your clit.  As your thoughts focus on your own fantasy, you see the demon throw back his head and give one final powerful thrust.  In answer, you pound your own fingers deep into your pussy, hitting your g-spot by sheerest luck.  Together you and the demon climax in blissful moans.  He yields his place to the next, while you yield your consciousness to the glow of sexual satisfaction and fall asleep.");
				outputText("\n\nWhen you awaken from the refreshing doze, you sit up and look from your hiding spot.  You must have been out longer than you thought, because the demons seem to have moved on.  All that's left is the ant-morph, lying in and still oozing a puddle of tainted semen, with hymen and possibly mind broken by the demonic orgy.  You quickly get dressed and head back to camp.");
				//[End of Event]
                sharedEnd();
			}
            function sharedEnd():void {
                if (!recalling) {
                    player.sexReward("Default","Default",true,false);
                    dynStats("sen", -1,  "cor", 3);
                }
                doNext(recalling ? camp.recallWakeUp : camp.returnToCampUseOneHour);
            }
		}

//►[Play Hero]
		private function playHero():void
		{
			spriteSelect(SpriteDb.s_antguards);
			clearOutput();
			//►Introduction to Combat
            if (player.cor >= 66 - player.corruptionTolerance) {
                outputText("You hesitate for a moment, fighting the urge to just sit there and watch the demons rape the poor ant.");
                outputText("\n<b>Alt scene is unlocked in 'Recall' menu!</b>\n\n");
            }
			outputText("As the demons bear down on the ant-girl, you burst from your hiding place, raising your [weapon] to the air and uttering an impressive war cry.  Nobody, ant or otherwise, is getting raped if you have any say in the matter!");
			outputText("\n\nYou are now fighting demons!");
			startCombat(new DemonPackDesert());
			monster.createStatusEffect(StatusEffects.phyllafight, 0, 0, 0, 0);
			doNext(playerMenu);
		}

//►Console ant-morph
//After whuppin' demons!
		internal function consolePhylla():void
		{
			clearOutput();
			outputText("As the demons flee over the dunes, you gather your thoughts and survey the chaotic scene.  The woman you saved has taken refuge under the ruined cart, trying to conceal herself.  Her upper torso, at least, is 'hidden' inside it, but her large abdomen and black legs jut outward, giving away her poor attempts at stealth.  ");
			if (player.lib >= 50) outputText("After taking an eyeful of her smooth, enticing pussy, revealed in her current position by the inadequacies of her loincloth, y");
			else outputText("Y");
			outputText("ou walk over and tap on her shaking abdomen.  To your surprise, what you thought was skin is actually a series of skin-toned armor plates; very rigid and rougher than actual skin.  The ant flinches at your touch and shoots her head up, looking about wildly.  You watch as her large, almond-shaped eyes dart around, making absolutely certain that it's safe to come out of hiding.");

			outputText("\n\nSlowly, she crawls out from the back of the cart and stands facing you.  You guess she's about five and half-ish feet tall, and you can now make out her pair of perfectly firm B-cup breasts.  Curiously, her nipples are hard and stick out at least half an inch.  The interest excited by your examination must show on your face, as she blushes and quickly covers her breasts with her two larger arms - while the smaller ones hold her loin cloth in place.");
			outputText("\n\nNot wanting to be any ruder, you attempt to introduce yourself, but the ant-morph just tilts her head in incomprehension.  You begin a pantomime of physical gestures to convey who you are and why you're here, and after a minute or so of looking ridiculous, you suddenly see something click in the ant-morph's brain.  With amazing speed, she jumps on you, and before you can react, she plants a firm kiss right on your lips.  Your protest dies on your lips as a sudden rush of images floods your consciousness.");

			outputText("\n\nIt's as if your mind is being assaulted by memories that are not your own.  You see a large hill deep in the desert and an extensive network of dark caves.  Day flashes to night in your mind as you see silhouetted figures emerging from the hill and one stalking off into the wilderness.  When these last images fade from your mind, you feel a tug on your consciousness, as though you are trying very hard to recall a memory you had forgotten long ago. The tug quickly becomes a pull and within seconds you feel your own memories conjured up. The most important moments of your life are brought to the forefront of your mind's eye: flashes of your home, friends, and family; your mission and entry into this land; your humble campsite and the variety of monsters you've defeated; each is pulled from your mind in turn.  This sudden transfer of information is almost too much for you to handle, and right as you're about to pass out the ant-girl breaks the kiss.");
			outputText("\n\nYou stagger backwards and almost fall over completely, but the ant manages to catch you. Though she herself is thin, her four arms are surprisingly strong; they do little to help the disorientation, even so.  The world spins round and round as you struggle to shake off your vertigo and the girl lowers you to the ground.  Once your thoughts are collected enough to at least sit up unassisted, you find your new friend standing in front of you with a huge smile.  You feel an odd kinship from her, as though you've known her your whole life.  That can't be right; you shake your head again trying to clear your mind.  The female... ant-morph breaks into a sprint away from you and the cart, before you can ask her what just happened.  You would attempt to pursue, but she's very quick and you can yet hardly stand upright.  She leaves you surrounded by useless trinkets in a barren part of the desert and completely stunned as to what just transpired.  Although, looking around, you think you have a better idea of where you might be in the desert - you may even know how to find that large anthill you saw when the ant-morph kissed you.  Unconsciously you whisper a name quietly under your breath as you picture the scene: \"<i>Phylla...</i>\"");
			outputText("\n\nYou exhale a loud sigh.  This land is still full of surprises, even after all you've seen.");
			flags[kFLAGS.PHYLLA_SAVED] = 1;
			cleanupAfterCombat();
		}

//[Enter The Colony]
//(Explore the Desert)
		private function enterTheColony():void
		{
			clearOutput();
			spriteSelect(SpriteDb.s_antguards);
			outputText("Wandering in the desert with your new, strangely eidetic memory, it's not long until you come across the large anthill.  If it hadn't been for the visions that were projected into your mind, you'd never have guessed anything like it could be hidden in such a harsh environment.  As you approach the hill, you get the familiar feeling you're being watched.");
			outputText("\n\nNearing the crest, you're taken by surprise as three large ants burst out of the sand via a cleverly-concealed trapdoor.  They're much bigger than the girl you saved but seem just as muscular and, except for their large almond shaped eyes and smaller noses, appear roughly human.  They have narrow jaw lines and much sharper cheek structures, making for very masculine faces.  Where the female's abdomen was skin-toned and seemed to have large angular plates, these ants have completely smooth black abdomens.  Two of them hold makeshift spears with obsidian tips in all four hands, while the other is using a very old and very blunt short sword.  These two quickly surround you, holding you at spear-point. The one with the short sword steps forward, almost pressing his face into yours as he sniffs you.  Over his shoulder, the spear-carrying ant in front of you makes a series of clicking noises to the others.  They appear annoyed, but lower their weapons.  All three walk over to the trapdoor and the two spear-bearing ants lift it.  The one with the short sword beckons you to follow him as he descends.");
			outputText("\n\nAs you climb down into the crepuscular cave system after your escort, the only light seems to be emitted from some kind of bioluminescent fungus that coats the walls. Your journey into the vast caverns and twisted caves of the colony leaves you very disoriented.  Luckily for you, your guide seems to know exactly where he's going; as you turn a sharp corner, you enter a massive excavated cave.  What you see therein is a complex network of tunnels in almost every direction and ants of all shapes and sizes going about their daily routine.  You would guess this is the central hub of this colony.");
			outputText("\n\nIn the middle of this massive hub, sitting on a 'throne' of sorts, is the only other female ant-morph you've seen in Mareth.  You're suddenly overcome with a feeling of deja vu, as if you've been here before... as if you've <b>lived</b> here before.  The 'queen', as your mind persists in regarding her, is much larger than any of the other ants; on top of that, her abdomen is almost twice the size of her own body!  As your guide leads you to meet her she arches her back and all her muscles tense up, but your uncertainty quickly evaporates as she relaxes; a small flood of clear gel and a small cylindrical egg emerges from the orifice on the end of her abdomen.  The egg is quickly gathered up by another ant emerging from one of the many tunnels and just as quickly carried back into it. The sword-bearing soldier gestures you toward the large female, then disappears into the caves. She looks you over, scanning you up and down.");
			outputText("\n\n\"<i>I am Queen Chylla.  Do you understand this?  Qu-een.  It's only recently I've learned this pathetic thing you call by the name of language.</i>\"  Her tone is that of a monarch being forced to address a peasant.  Clearly she doesn't think highly of you or your intelligence.  ");
			//[(corruption < 40)
			if (player.cor < 40) outputText("\"<i>'Champion', you've been sent to this land to resist the demons and your efforts thus far, insignificant though they be, have not escaped my gaze.  ");
			else outputText("\"<i>Despite your obvious taint, you seem to have retained your valor as the 'Champion' you proclaim yourself to be, and not as a rutting beast.  Something to be admired, for sure.  ");
			outputText("In saving my daughter, Phylla...</i>\"  She pauses and gestures, and the four-armed girl you saved from the demon horde walks slowly and shyly out of a nearby tunnel to stand next to her mother.  'Phylla' looks very embarrassed and is blushing deeply, avoiding eye contact from both of you by looking at the ground as Queen Chylla continues her dry monologue.  \"<i>... you have been chosen to become her potential...'mate'; much to my dismay.</i>\"  Wait, mate?  \"<i>My daughter has shown me how you saved her from the demons that inhabit this land.  Perhaps you were just lucky and caught them with their cocks in their hands while her back was turned?</i>\"");
			outputText("\n\nThe queen pauses momentarily, staring daggers at her daughter.  Chylla's gaze then darts to you, looking for all the world as if her knowledge were firsthand and her question rhetorical.  Phylla seems to shrink even further and continues to stare at the floor, not daring to rouse her mother's ire.");
			outputText("\n\nThe imperial address stops just long enough for you to notice another egg spilling out of the queen's abdomen.  She takes a deep breath and continues, as if nothing just happened.  \"<i>Though I do not expect you to truly understand the opportunity you've been given, I will now explain how the trials for my daughter's hand will work.</i>\"");
			outputText("\n\nChylla stands upright, and you see her muscles strain to lift her large abdomen.  Surprisingly, she's easily over 10 feet tall and is an impressive and very regal figure even with her distended backside - though, you suspect, not an agile one.");

			outputText("\n\n\"<i>We've captured some of the fiercest creatures from this land; mainly for study, but they can also serve as combatants in challenges. I've constructed an arena, of sorts.  It's there you must defeat these beasts in single combat. I will warn you now, many of my own warriors have attempted the trials and none of them have succeeded; some have even perished.</i>\"");
			outputText("\n\nShe pauses to let that sink in, as though hoping that it might deter you.");

			outputText("\n\n\"<i>When you're ready, make your way to the arena.  Good luck; I believe you will need it.</i>\"");
			outputText("\n\nThe ant queen gives you a dismissive wave with one of her larger arms, giving you reason to think her good will is anything but.  As you turn to leave, your eye catches Phylla's and she shyly smiles at you.  Her mother sees this and delivers a final, cryptic warning.  \"<i>One last thing before you depart, 'Champion'.  Should you fail, the consequences, for you, will be... dire.</i>\"");
			outputText("\n\nAs you mull over this ominous message, your guide reappears and leads you back through the maze of tunnels, to the exit of the colony.  You leave the anthill behind and head to camp, considering your best course of action.");
			flags[kFLAGS.PC_READY_FOR_ANT_COLONY_CHALLENGE] = 1;
			doNext(camp.returnToCampUseOneHour);
		}

//The Challenges
		private function antColonyChallenge():void
		{
			clearOutput();
			spriteSelect(SpriteDb.s_antguards);
			//(Random Encounter in the Desert)
			//Leads to - Introduction First Time
			//Leads to - Introduction Subsequent Times
			//Introduction First Time
			if (flags[kFLAGS.MET_ANT_ARENA] == 0) {
				outputText("Unbidden, your feet return you to the anthill from before; a soldier peers from under a trapdoor at you when you arrive, then swings it open wide and beckons you to descend.  As you enter the colony, you find that only one path is lit with the bioluminescent fungus, leading you down a predetermined route.  Even with the low light, it's still hard to see exactly where you're going, and you find yourself holding your hands out, like a blinded man, to make sure you don't walk into a wall.  You can hear scurrying and unintelligible chattering echoing from darkened hallways as you descend deeper into the colony.  Just as you convince yourself you've taken a wrong turn and consider turning around, you stumble onto a sharp curve in the path.  Bright light issues from beyond it.");
				outputText("\n\nYou guard your eyes and turn the corner.  As your pupils adjust you realized you've walked into yet another huge cavern that's been hollowed out by the ants.  The entire ceiling is covered with a huge patch of fungus, making it almost as bright as high noon.  Your eyes widen as you see an underground auditorium!  Though it appears to have been recently adapted to serve as a colosseum, the fixtures of the oval arena seem to be carved out of the very bedrock of the desert.  Looking up reveals a honeycomb-like series of stands and tunnels leading higher and higher.  This colosseum could easily fit hundreds of people, if not thousands.  As you step out into the cavern, you are greeted by a thin male ant-morph holding a clipboard in two hands and black charcoal sticks in the others. Glancing down to the clipboard you see many words - names, presumably - and all of them seem to have lines through them.  Two of them even have crude skulls next to them!  The last name on the list happens to be yours.  He notices you attempting to read the other names on his list and he pulls the clipboard to his chest.");
				outputText("\n\n\"<i>You mind?!  Can't imagine what the Princess sees in you,</i>\" he mutters, more to himself than to you.  He pauses to look you up and down.  Judging skill based on appearance seems to be common for this race.");
				//Silly Mode:
				if (silly()) outputText("\n\n\"<i>Oh, I'm sorry; you're not on the list.</i>\"  You tell him that if your name doesn't appear on the list quickly, he'll find himself on the side of the road with nothing but his ass to sell to get back here.");
				//Else if strength over 50:
				else if (player.str > 50) outputText("\n\n\"<i>Well, you certainly look the part.  But you're going to need more than brute strength to win here.</i>\"");
				//Else if intelligence over 50:
				else if (player.inte > 50) outputText("\n\nYou make a witty quip about how he might be making puppy eyes at someone who saved him from a horde of giant demon cocks, too, but he doesn't receive it well.");
				outputText("  After a moment he looks down and scribbles something on his chart.");
				outputText("\n\n\"<i>So, we're ready to start when you are.</i>\"");
				flags[kFLAGS.MET_ANT_ARENA]++;
			}
			//Introduction Subsequent Times
			else {
				outputText("Your feet bring you back to the ant colony and the guard motions you down the only lit tunnel once more.  You enter the colosseum, and as you step out into the cavern, you are greeted, again, by a thin male ant-morph holding a clipboard.  He looks up at you.");
				outputText("\n\n\"<i>Oh good, you're here.  I was beginning to think you were a coward.</i>\"  Before you can respond to his insult, he cuts you off.  \"<i>We're ready to start when you are.  Let's hope you survive longer than the last guy.</i>\"");
			}
			//[Fight] [Leave]
			simpleChoices("Fight", antColiseumFight, "", null, "", null, "", null, "Leave", leaveAntColony);
		}

//►[Leave]
		private function leaveAntColony():void
		{
			clearOutput();
			outputText("Deciding to better prepare yourself first, you inform the thin fight manager that you will return later.  You leave the colony, heading back to camp.");
			doNext(camp.returnToCampUseOneHour);
		}

		private function antColiseumFight():void
		{
			clearOutput();
			//►[Fight #1]
			if (flags[kFLAGS.ANT_ARENA_WINS] + flags[kFLAGS.ANT_ARENA_LOSSES] == 0) {
				//(Tentacle Beast - Intro)
				outputText("You tell the fight manager you're ready.  He nods and leads you down into one of the two staging areas of the arena.  You watch through the bars as the stadium fills quickly.  Although pretty much every ant face looks identical to you, the larger ones who are clearly warriors stand in stark contrast with the smaller ones that must be the workers - or maybe they're just younger; you can't tell.  Watching them gather for the impending fight, you confirm the suspicion you formed when you first saw the queen's chamber: every ant-morph except the princess and the queen is male!  Gazing out into the crowd you spot the two royal personages sitting in a special area that appears to be reserved for them.  The shy princess's gaze nervously drifts toward your room and for a moment your eyes meet.");
				outputText("\n\nAs you raise a hand to wave, you're stopped as you hear the sounds of a shambling and banging from across the arena.  A large silhouetted beast is poked and prodded into the staging area across from you. You narrow your eyes, trying to get a glimpse of your opponent. As you do, the gates of the staging areas drop and a very angry and enraged tentacle beast thrashes out into the center of the arena.");
				outputText("\n\nYou're fighting a tentacle beast!");
				startCombat(new TentacleBeast());
				monster.createStatusEffect(StatusEffects.NoLoot, 0, 0, 0, 0);
			}
			//►[Fight #2]
			else if (flags[kFLAGS.ANT_ARENA_WINS] + flags[kFLAGS.ANT_ARENA_LOSSES] == 1) {
				//►(Minotaur - Intro)
				outputText("When you arrive in the colosseum, you tell the fight manager you're ready; he nods and leads you down into one of the two staging areas for the arena.  You watch through the bars as the stadium fills almost to capacity, still resistant to the idea of so many ants living right under the sands; there must be hundreds.  Gazing out into the cheering crowd, you spot the royal family sitting in their reserved area.  The princess waves at you excitedly with two of her arms, but her mother grabs them and lowers them.  Chylla herself looks as regal and reserved as ever.  You catch the queen smiling at you, but there's something wicked behind the smile.  Before you can contemplate what it might be, the gates raise on both sides of the colosseum and you are pushed out.");
				outputText("\n\nYou're now fighting a minotaur and it's wielding a Giant Axe!  You quickly put two and two together and realize Chylla has set you up by arming the minotaur!  You brace yourself as the beastman charges you, roaring wildly.");
				startCombat(new Minotaur(true));
				monster.createStatusEffect(StatusEffects.NoLoot, 0, 0, 0, 0);
			}
			//►[Fight #3]
			else {
				//(Gnoll - Intro)
				if (flags[kFLAGS.MET_ANT_ARENA_GNOLL] == 0) outputText("With due ceremony, the manager leads you down to one of the staging areas for the arena.  You watch through the bars as the stadium fills far past capacity.  There must be a thousand ants here... maybe even the whole colony.  Gazing out into the crowd, you pick out the royal seating and in it, Princess Phylla.  The princess is in much finer attire than you're used to seeing - her chest is actually covered by a fine red and blue dress and her hair is combed, framing her face nicely.  Her mother is nowhere to be seen, and you can tell that Phylla is taking full advantage.  She waves and cheers for you just like the crowd is and, perhaps by her orchestration, you hear the crowd pick up a chant in your name.  Seeing Phylla chant with them makes you feel invigorated.  As the gates raise, you charge out into the center of the arena, roaring your finest battle cry; your opponent is taken somewhat aback but finds resolve and braces for your charge.");
				//►(Gnoll - Intro Repeat - for people that lost once)
				else outputText("You move through the network of tunnels and caves and come to the colosseum once more.  You are greeted by the event manager and he ushers you down to one of the staging areas for the arena.  The noise intensifies as the colosseum fills to the brim with spectators; Phylla herself is up in her box waving to you.  You look across the arena floor and the gnoll at the other side of the arena seems just as excited to fight as you are.  The gates open and you charge each other!");
				outputText("\n\nYou're fighting a gnoll!");
				flags[kFLAGS.MET_ANT_ARENA_GNOLL]++;
				startCombat(new Gnoll());
				monster.createStatusEffect(StatusEffects.NoLoot, 0, 0, 0, 0);
			}
			monster.createStatusEffect(StatusEffects.PhyllaFight, 0, 0, 0, 0);
			doNext(playerMenu);
		}

//(Tentacle Beast - Win) Standard Tentacle Beast Win Scene. (Again we're going to need to adapt the ending so the PC does not go back to camp.)
		public function phyllaTentacleDefeat():void
		{
			spriteSelect(SpriteDb.s_antguards);
			outputText("\n\nAs you leave the arena, you are met by Princess Phylla and a large group of warrior ants; the princess is looking at the ground and twiddling her lower set of thumbs.  As you clear your throat to announce yourself she jumps and makes a strange noise that sounds like a mix between a click and 'EEP!'.  She blushes and looks at the ground again, searching for something to say.");
			outputText("\n\n\"<i>I'm happy you won,</i>\" she finally manages, more to the rocky earth than to you.  \"<i>Let me help you recover, I mean, if you want...</i>\"");
			outputText("\n\nYou give her a nod and she sets to work. She nervously dresses your wounds by using some strange paste and strips of cloth.  You try to make small talk but find it awkward under heavy guard.  Clearly you're still not welcome here.  Once Phylla's done, all but one of the guards disappear with her into the tunnels.");
			outputText("\n\nYou recognize the remaining guard as the guide from your first time here. At least, so you think - the only distinguishing factor is the old rusty blade he holds.  He waits patiently as you redress, then leads you out of the colony.");
			//(Player Recovers 10 Fatigue)
			fatigue(10);
			//(+1 Win Score)
			flags[kFLAGS.ANT_ARENA_WINS]++;
			cleanupAfterCombat();
		}

//►(Tentacle Beast - Loss) Standard Tentacle Beast Loss Scene.
		public function phyllaTentaclePCLoss():void
		{
			clearOutput();
			spriteSelect(SpriteDb.s_antguards);
			outputText("After your defeat in the arena, you set off to leave but are stopped.  Princess Phylla is standing with a troupe of armed guards by the exit, holding a vial of clear liquid.  She doesn't look like she wants to give it to you but she extends it to you all the same.");
			outputText("\n\n\"<i>You lost... so you have to drink this.  I mean... I'm sorry.</i>\"");
			outputText("\n\nYou look at the vial inquisitively but the warriors don't look like they're going to budge until you consume the liquid.  You uncork the bottle and drink the whole thing, like a shot.  Remarkably it doesn't taste like anything.  The clear liquid is a little more viscous than water, but doesn't have much else in the way of texture.  Though you were expecting something awful to happen to you, you don't even feel any different.  As you hand back the empty bottle, the guards part to let you leave.  Although, oddly, you find yourself not really wanting to, you shake your head and return to camp.");
			// (+1 Loss Score)
			flags[kFLAGS.ANT_ARENA_LOSSES]++;
			if (flags[kFLAGS.ANT_ARENA_LOSSES] > 3) {
				antastrophyBadEnd();
				return;
			}
			cleanupAfterCombat();
		}

//►(Minotaur- Win)
		public function phyllaBeatAMino():void
		{
			clearOutput();
			spriteSelect(SpriteDb.s_antguards);
			outputText("As you exit the arena, amidst the cheers and roars of the crowd, you are met by Princess Phylla and slightly fewer guards than the last time.  She sees you coming and her face lights up, then runs over to you and starts doting over you. You smile and let her do her thing.  Once she's done, she looks deep into your eyes.");
			outputText("\n\n\"<i>I... I w-was wondering... I mean...</i>\"  She raises her head to yours and just as you assume she's about to kiss you, one of the guards grunts loudly, interrupting the moment.  He then motions her to follow him into the tunnels.");
			outputText("\n\nYou hear someone else clear their throat behind you, and turn to see your guide, his trusty rusty blade at his side.  He simply shows you to the exit of the arena before turning and walking away.  Apparently he trusts you enough to see yourself out?  You follow the lit tunnel back to the surface.");
			//(Player Recovers 10 Fatigue)
			fatigue(10);
			//(+1 Win Score)
			flags[kFLAGS.ANT_ARENA_WINS]++;
			cleanupAfterCombat();
		}

//►(Minotaur- Loss)
		public function phyllaPCLostToMino():void
		{
			clearOutput();
			spriteSelect(SpriteDb.s_antguards);
			outputText("After your staggering defeat and subsequent humiliation in the arena two guards approach you as you try to leave.  One of them holds out a small vial.  Princess Phylla is off in the corner of the room crying, and you try to move closer to her but one of the guards steps in front of you.  \"<i>Drink!</i>\" he commands, uncorking the vial.");
			outputText("\n\nIt's strange... you don't care for the idea of being commanded by an ant, but you find yourself indifferent now that you smell the liquid.  You drink the whole thing in one go; it has no taste or texture and afterwards you don't feel any different.  The guards tell you to leave again, though you don't really want to.  Looking around you, you muse that you would be completely contented with staying underground here for a while... maybe forever, if you had to!  One of the guards, however, pushes you towards the exit, causing you to stumble a bit until you catch yourself.  Before you leave, you glance at where Princess Phylla was watching you, but she's already been removed by the other dutiful guards.  You head up the path to the surface, and from there back to camp.");
			//(+1 Loss Score)
			flags[kFLAGS.ANT_ARENA_LOSSES]++;
			if (flags[kFLAGS.ANT_ARENA_LOSSES] > 3) {
				antastrophyBadEnd();
				return;
			}
			cleanupAfterCombat();
		}

		public function phyllaPCBeatsGnoll():void
		{
			clearOutput();
			spriteSelect(SpriteDb.s_antguards);
			//►(Gnoll - Win First Time)
			if (flags[kFLAGS.ANTS_PC_BEAT_GNOLL] == 0) {
				outputText("As you stand over your defeated opponent and the red mist of combat fades, you finally become conscious of the crowd.  Everyone is cheering, and some are even throwing gems into the arena at your feet.  You hold your [weapon] up to the sky proudly, only making them erupt in greater roars and whistles.  As you make your way out, Phylla greets you, doting over every cut and scrape, as maternal as always.  You smile and let her do her thing.  The usual guards don't seem to be around, but you suppose they're lurking just out of sight.");
				outputText("\n\n\"<i>You're the most amazing champion I've ever met,</i>\" the girl says.  \"<i>I mean, not that I've met many; you're actually the first.  Er, the first I've ever talked to...</i>\"  She seems to stumble around the words - you're not sure if she's just shy or if she's unused to speaking; both, maybe.  Clearly she doesn't have a chance to talk with outsiders often.");
				outputText("\n\nGingerly, you raise a finger and put it to her lips, shushing her, then flash her a wink and a grin.  She blushes slightly and returns the smile.  There's no time for more than that, as two guards arrive; one to reclaim her and the other - your rust-wielding guide - to escort you out.");
				flags[kFLAGS.ANTS_PC_BEAT_GNOLL]++;
			}
			else if (flags[kFLAGS.ANT_ARENA_WINS] - flags[kFLAGS.ANT_ARENA_LOSSES] >= 2 && flags[kFLAGS.ANT_ARENA_WINS] >= 3 && player.gender > 0) {
                CoC.instance.inCombat = false;
                flags[kFLAGS.ANT_ARENA_WINS]++;
				antGirlGoodEnd();
				return;
			}
			//►(Gnoll - Win Repeat) Standard Gnoll Win Scene. +
			else {
				outputText("This isn't the first time you've accomplished this, but it still brings the crowd to their feet.  You simply stand in the center of the arena, taking it all in.  Phylla makes her way to you, blushing as the rowdy audience follows her with catcalls and demands for her to give her champion a kiss.  She tends to you as always and, when she's done, takes your hand in hers and looks at you expectantly.  You smile at her, brushing the hair from her face with your other hand; she colors deeply at the contact as two guards appear to lead you both off.  Having no more reason to stay, you allow your guide to return you to the surface.");
			}
			//(+1 Win Score)
			flags[kFLAGS.ANT_ARENA_WINS]++;
			cleanupAfterCombat();
		}

		public function phyllaGnollBeatsPC():void
		{
			clearOutput();
			spriteSelect(SpriteDb.s_antguards);
			//►(Gnoll - Loss First Time) Standard Gnoll Loss Scene. +
			if (flags[kFLAGS.ANTS_PC_LOST_TO_GNOLL] == 0) {
				flags[kFLAGS.ANTS_PC_LOST_TO_GNOLL]++;
				outputText("You lie on the arena floor, listening to the crowd boo you and cheer the gnoll.  After enough time to recover yourself, you stand up and start to head to the exit.  Four guards block the way and one of them presents you with a vial of mysterious clear liquid, motioning for you to drink.  They appear disinclined to let you leave without doing so, and as you peer down into the uncorked vial, a strange tingle in the back of your head tells you not to worry.  You drink it in one gulp and the guards tell you to leave.  You are completely oblivious of Phylla crying to herself as you stroll past her.");
			}
			//►(Gnoll - Loss Repeat)
			else {
				outputText("The crowd boos you loudly as you exit the arena.  As you do so, four guards block your path; one of them presents you with a vial of mysterious tasteless liquid.  \"<i>Drink!</i>\" he booms at you.");
				outputText("\n\nYou quickly grab the vial and drink its contents, irritated at being crowded by the ants.  After drinking it however, the feeling lessens somewhat.  You look at the vial absently, then shake your head.  The guards move aside and you step past them; you look around a bit for Phylla but don't see her.  Not having any reason to stay, you return to the surface.");
			}
			//(+1 Loss Score)
			flags[kFLAGS.ANT_ARENA_LOSSES]++;
			if (flags[kFLAGS.ANT_ARENA_LOSSES] > 3) {
				antastrophyBadEnd();
				return;
			}
			cleanupAfterCombat();
		}


		private function antastrophyBadEnd():void
		{
			clearOutput();
			spriteSelect(SpriteDb.s_antguards);
			outputText("As you go to leave the arena queen Chylla and four bodyguards approach you.");
			outputText("\n\n\"<i>Come with me, it's time you join our colony.</i>\" Chylla states dismissively.  You want to leave but at the same time, the idea of being underground helping the colony grow is something you never considered to be an option.");

			outputText("\n\nThe queen continues in her dry tone. \"<i>As I suspected, you have proven yourself inadequate for surviving on the surface world, much less a fitting suitor for my daughter's hand.  The only way you can survive in this world, is with us. Come.</i>\"");
			outputText("\n\nConsidering the options of fighting your way out or just joining willingly, you choose the latter.");
			outputText("\n\nYou're half dragged, half shoved deeper into the colony than you've ever been, accompanied by an escort of armed muscular warriors, and Chylla.  Eventually you arrive at a room that looks a small step up from a prison cell.");
			outputText("\n\n\"<i>Welcome to your new home [name]. Your meals are to be delivered every 4 hours. You will eat, every morsel.  Is that understood?</i>\"");
			outputText("\n\nBefore you can even respond she continues.");

			outputText("\n\n\"<i>Any attempt to leave this room without my express permission will result in your death. When I choose to allow you out, you are to not talk to my daughter. In fact, I forbid you from ever making contact with her in any way... Farewell 'champion'.</i>\" Chylla turns and leaves, leaving you in your room. Once you hear the sounds of footsteps completely fade you take a step to leave, seeing as there's no bars or barriers to stop you. As you reach your 'door frame,' you're suddenly reminded that you're not fit for the surface. The queen was right, you muse. Perhaps this is what's best for you, at least you'll be safe here. Looking at your new room you get the strange feeling that you're finally at home. You've been traveling and searching and finally found what you're looking for. Gazing out your doorway you come to the realization that even if you wanted to leave you would be completely lost in the maze like structure of the colony. You chuckle to yourself, how silly of you to think to escape.");
			outputText("\n\nAfter a few hours daydreaming of what Chylla might task you with, a small ant brings you a small clay cup filled with the clear liquid that the vials were filled with. Wordlessly, he extends it to you. Accepting the cup you thank him with a pat on the head as he skitters off. Drinking deep, the liquid glides down your throat. A sudden feeling of safety and warmth covers you as the liquid hits your stomach. After you've completely drained the contents of the cup you feel a strange thankfulness for everything you've been given, even if it's only a small room. It's the best room you've ever had and you never want to leave it.");
			outputText("\n\nDays past of the same routine. An ant comes, gives you a cup and sometimes some food then disappears back into the tunnels...");

			outputText("\n\n<b>Epilogue</b>\n");
			outputText("You live out the rest of your days in blissful ignorance, helping the colony in any way you can. Mostly you're used as an experimental sex toy. They force you to drink an uncountable number of different potions and elixirs. Eventually you start to beg for more as your mind and body crave the sexual liquids. Oftentimes Chylla even puts you in the arena, sometimes to pleasure yourself in front of the whole colony or calling upon you to service as many males as you can please at once. Sometimes you're a male, sometimes you're a female, and sometimes both. Your mind becomes completely consumed with pleasing the colony in any way you can. You never get to see the outside world or Phylla again, but you don't care. You're busy pleasing every cock placed in front of you. As long as you're helping the colony grow and become strong, nothing else matters to you.");
			EventParser.gameOver();
		}

//Good End
//Good End / Waifu Content
		public function antGirlGoodEnd():void
		{
			clearOutput();
            phyllaSprite();
			if (!recalling) outputText("\n<b>New scene is unlocked in 'Recall' menu!</b>\n");
			outputText("As you turn to leave, something is different; the crowd seems unusually silent. Phylla swiftly climbs down from her seat and jumps into the arena.  You glance warily at the gnoll but it's already being dragged out.  Phylla runs to you, and gives you a massive hug, wrapping all four of her arms around you and squeezing as hard as she can.  Her open display of affection leaves you more than a little shocked, given the creaking and soft cracking of bone in your body.  Interlocking her fingers with yours, she turns and raises your hands in the air, proclaiming your victory to every ant in the colony.  The awed crowd suddenly erupts, filling the stadium with cheers for your victory.  She turns towards the exit and tugs on your sleeve.");
			outputText("\n\nPhylla drags you blindly through myriads of unlit tunnels until you reach the Queen's chamber, where Chylla seems to be awaiting you. Though, something is different than the last time you saw her; she's dressed just as regally as Phylla is, but it appears more...  formal.");
			outputText("\n\n\"<i>Phylla seems to have been right about you. You are as smart as you are strong. Though I had my doubts, you are truly something special.  You have my blessing to start your own colony with Phylla, should you choose to.</i>\" Chylla turns to her daughter and nods some kind of silent message.  You're not sure if the Ant-Queen has really warmed up to you, or she's just saying it because she must in her role as Queen, bestowing a great honor on someone she detests.  Whatever the reason, Phylla seems ecstatic about what's to come next.");
			outputText("\n\nPhylla pulls you off to a private chamber.  Unlike the passages that run through the colony, this one is actually lit, allowing you to follow behind Phylla as the two of you enter her quarters.  You assume this is the Princess' room judging by the layout; there's a small stone bed with some sheets neatly folded and a few multi-colored silk pillows strewn about the floor.  In the center of the room there's two larger cushions with a golden bowl in between them.  It looks like her room has been set up for some kind of ritual.");
			outputText("\n\nOnce Phylla sees you've taken it all in, she sits you on one of the large cushions and plants herself on the one across from you.  She pulls out a vial of clear liquid and pours it into the golden bowl that sits on the floor between you.  The color of the liquid changes as soon as it makes contact with the bowl, refracting the light as a prism would.  As the rainbow-tinged light spreads, so does the sweet smell of flowers, emanating from the golden bowl.");
			outputText("\n\n\"<i>I'm happy you're with me, for this.  I mean, you do want to be with me, right?</i>\"  You nod, although you're not entirely sure what 'this' is.");
			outputText("\n\nA huge smile grows on Phylla's face.");
			outputText("\n\n\"<i>This is going to feel strange for you, at first.  I mean, after too... but not during...  I mean-</i>\" She looks away from you bashfully.  \"<i>It will be strange for me too.  It's my first time, so I'm not really sure what's going to happen myself, I mean, I just...</i>\"  The nervous Princess stammers out.");
			outputText("\n\nYou're not really sure what to do or say in this situation, but you quickly put two and two together.  It seems Phylla wants to take the lead, as she crawls over the incense and presses her body to yours.  You take a deep breath as her earthy smell mixes with the sweet scent of flowers.  Your bodies start to move on sexual instinct, as you hear your new lover's deep breathing in your ears.  Your lips press lightly against her neck as your arms wrap around her.  Lightly dragging your nails down her back, you seek to test the waters.  Phylla shudders in your arms, a small moan escaping her mouth in response.  As your small kisses move up her neck and across her cheek, your lips meet hers, her tongue pushing into your mouth as your caress begins to deepen, and you feel a wave of emotions wash over you.");
			outputText("\n\nAs you look into her eyes and your lips lock together, you feel as if you're a single mind. It's one of the strangest feelings; you can feel... what she's feeling.  As you run your hands over her body you feel your own motions as if you were the recipient.  It's almost thrilling in a way, knowing exactly how your touch feels on another.  You smile wickedly as you lay her down on the cushioned pillows.");
			//Use Penis - Male Continuation
			//Use Vagina - Female Continuation
			menu();
			if (player.hasCock()) addButton(0, "Use Penis", phyllaFirstTimePenis);
			if (player.hasVagina()) addButton(1, "Use Vagina", phyllaFirstTimeVagina);
			addButton(4, "Refuse", refuseAntSex);
		}

		//Refuse sex. This disables further encounter.
		private function refuseAntSex():void {
			clearOutput();
			outputText("Your mind finally fires up; she's not worth your time. You quickly dart off towards the door, leaving Phylla heart-broken.");
			outputText("\n\n\"<i>What are you doing? I mean... You won't?</i>\" She looks down, tears leaking from her eyes.");
			outputText("\n\nYou have a feeling that you won't see her again.");
			if (!recalling) {
				flags[kFLAGS.ANTS_PC_FAILED_PHYLLA] = 1;
				doNext(camp.returnToCampUseOneHour);
			}
			else doNext(camp.recallWakeUp);
		}

//►Male Continuation
		private function phyllaFirstTimePenis():void
		{
			clearOutput();
            phyllaSprite(true);
			outputText("Sporting a painfully obvious tent, your body betrays its desire for sexual gratification, and it causes Phylla to smile with interest.  \"<i>I-I didn't think I had that ability to... to...  I mean I'm not like you, so I thought...</i>\" she begins, but trails off as she takes in the rough, obscured shape given off by your bulge.");
			var x:int = player.biggestCockIndex();
			//***Dick(s) size less than 36 inches:
            if (player.cockArea(x) < 72) {
                if (player.cockArea(x) < 36) {
                    outputText("\n\nHer delicate face wears an expression of utmost curiosity.  She seems to be interested in your outline but unsure of what to do with it. As if she's never... then you recall her saying it's her first time; she's a virgin!");
                    //PC has more than one dick:
                }
                //***Dick(s) size more than 36 inches, but less than 72 inches:
                else {
                    outputText("\n\nThe constant bobbing and twitching of your [cocks] is apparently not obvious enough to her that your trousers aren't built to accommodate the size of your loins.  You grimace in response as the fabric of your pants become painfully constrictive and unyielding. Snapping out of her inexperienced musings, the Ant Morph sees your obvious predicament.");
                    outputText("\n\nIn an effort to get your loins free she rushes in, all four of her arms working feverishly to help spring you free.  After a quick flurry of motions, your [cocks] snap out of your britches; the size of which apparently intimidates the Ant Morph, whose eyes go wide.  \"<i>H-Ho- How am I... wow...</i>\"");
                    //PC has more than one dick:
                    if (player.cockTotal() > 1) outputText("\n\nShe probably won't be able to handle ONE, let alone all of your [cocks]!");
                }
            }
			else { //***Dick(s) size more than 72 inches:
				outputText("\n\nThe fabric of your pants simply cannot contain your [cocks] any longer as you frantically tug and yank at the button, trying to get your loins free before you injure yourself or ruin a good pair of trousers. Phylla's absent mindedness comes to an abrupt end when she sees your face flush with red and fury as you desperately work to free yourself.");
				outputText("\n\n\"<i>I-I've never... is that... your...  I mean...</i>\"  You give her a quick, serious look as you continue to fidget with your trousers.  \"<i>Eeep! Let me help you!</i>\"");
                outputText("\n\nToo late!  With a final groan and a rip, your pants give way to the force and power of your quickly hardening [cocks], sending a cursed button flying asunder from your waistline. The button connects with Phylla's forehead with a mighty 'thwack' and careens off her skull.  Fortunately for you, and her, she's more fixated on what's coming out of your pants rather than the pants themselves.");
				outputText("\n\nDespite the early warning, ");
                //too big?
                if (player.cockArea(x) > 100) outputText("[cock Biggest] swings downwards at her, causing her to unleash a surprised scream as she scrambles out of the way, narrowly avoiding being smashed by the brutish, fleshy cudgel as it swings downward in what arguably could have been a debilitating injury for Phylla.");
                else outputText("[cock Biggest] bursts outward and slams into her shoulder blade. \"<i>Ahh~tk!</i>\" She clicks, more in surprise than pain.  She rubs at her bruised shoulder, somewhat shocked that someone could possess THAT kind of ability.  ");
                //merge
                outputText("\"<i>Oops</i>\", you playfully apologize.  Phylla looks completely awestruck and doesn't seem hear you as her large eyes are fixated on your enormous member");
				if (player.cockTotal() > 1) outputText("s");
				outputText(".");
				//Dick Size massive (first time male fuck, LF1):
				//PC has more than one dick:
				if (player.cockTotal() > 1) outputText("\n\nOverwhelmed by the sight of ONE of your members, Phylla arguably goes catatonic when she sees all of what your packing.  She probably won't be able to handle the one, let alone all of your [cocks]!");
				//Tentacle dick check for Dick Size Huge and Massive
                if (player.countCocksWithType(CockTypesEnum.TENTACLE, 96, -1, "length") > 0 || player.countCocksWithType(CockTypesEnum.TENTACLE, 60, -1, "length") > 1) {
                    outputText("\n\nAt your whim, you command your tentacle dick");
					if (player.tentacleCocks() > 1 || player.stamenCocks() > 1) outputText("s");
					outputText(" forward and wrap them tightly around Phylla, taking her hand and tugging her in close.");
                    outputText("\n\nOpting to josh her a bit, you release your cock");
                    if (player.cockTotal() > 1) outputText("s");
                    outputText(" from around her and hang it in front of her face, grinning your antics on your face as Phylla stares at ");
                    if (player.cockTotal() == 1) outputText("it");
                    else outputText("them");
                    outputText(", slightly intimidated.");
                }
				outputText("\n\n\"<i>W-What is that?  I m-mean... don't tell me you're THAT big!  There's gotta be something for you to... \"put\" in me, right?...</i>\"  You see her peek around your cock");
				if (player.cockTotal() > 1) outputText("s");
				outputText(" looking for something more sizeable.  You can tell Phylla is more scared of what might happen to her than what might happen to you.");
			}
			menu();
            sceneHunter.selectFitNofit(malePhyllaContinuation, cuntmuffinLingusPhyllaDickBig, phyllaCapacity);
		}

		private function malePhyllaContinuation():void
		{
			//original check - corruption > 75
			clearOutput();
			outputText("Phylla stares down at your [cocks] and starts nervously rubbing her hands together.  \"<i>It's my first time... I mean, I hope it isn't going to be bad for you...</i>\" she says, before trailing off; uncertain of her sexual prowess.");
			sceneHunter.selectPureCor(
				["Be nice", curry(scene, false), "Make the first time enjoyable for the poor girl."],
				["Be rough", curry(scene, true), "It's <i>never</i> bad. Fuck the ant-slut like no tomorrow!"],
				90, 60);

			//SCENE
			//==========================================================================================================
			function scene(rough:Boolean):void {
				var x:int = player.cockThatFits(phyllaCapacity);
				//Corruption less than 75:
				if (!rough) outputText("\n\nYou assure her that she shouldn't worry so much about her first time.");
				//Corruption more than 75:
				else outputText("\n\nYou think to yourself that her pussy better be tight and pleasurable.  You didn't risk your life for 'royal' sub-par snatch.");

				outputText("\n\nYou tug ");
				if (!rough) outputText("playfully");
				else outputText("forcefully");
				outputText(" at her royal dress, wickedly commenting about how this will have to come off.  You hook a hand in the folds of her clothing and begin to slowly pull upwards, allowing the silk-like fabric of her royal vestments to slide easily off her.  You've never had to take the clothes off of something with four arms before, but you manage.  As you remove her bra you drag your hand along the ridge of her breasts, causing the Princess to moan softly; she doesn't stop you, instead allowing you to continue in your efforts to bring her to a sexual boil.  You work your dexterous hands down her toned stomach but before you can reach between her legs she stops you.");
				outputText("\n\n\"<i>I want... I mean... just like this...</i>\"  Tossing her clothes aside, Phylla guides you around to behind her.  \"<i>This, is how... I mean... how... my kind mate.</i>\"");

				outputText("\n\nOnce you're behind her, Phylla bends over in an effort to present herself to you.  Her abdomen makes it a bit awkward, but you manage to find a comfortable position.  Leaning over Phylla, you move your mouth to her neck and let your heavy breath warm her supple skin.  Phylla unconsciously moves her head to the side, giving you a much better angle to allow the heat of your essence to wash over her.  You start to nibble her neck as you run your hands across her pelvis and chest, sliding close to her B-cup breasts before snaking away.  Your explorative efforts yield a sweet spot by nibbling along her earlobe, causing Phylla to arch her back and softly hum her approval.  While teasing her with your mouth, you work a hand down to her clit");
				//PC is goo morph:
				if (player.isGoo()) outputText(", leaving traces of your slimy lust along her body for her to wear, allowing your detached bits of mass to ignite her sexual fires");
				outputText(".");
				outputText("\n\nOnce you reach the top of her vagina you feel her tense up, the insecurities she harbors flowing like water into your mind.  You whisper something sweet in her ear to ease her uncertainty, the words sending a shiver down her body and making her shake in bliss as your passion ignites her need for your carnal attention.  Another weak and stuttered moan escapes from her mouth, and you can hear her whisper to you.");
				outputText("\n\n\"<i>Enough teasing,</i>\" she manages between moans.");
				outputText("\n\n\"<i>I... think... no, I'm ready... please...</i>\"");

				//Corruption more than 75:
				if (rough) outputText("\n\nWell, you wanted her wet and eager like drought-ridden crops during a rain storm; now it's time to \"reap\" your efforts.");

				outputText("\n\nLying against the assortment of cushions she's fashioned into a bed, Phylla glances back at you eagerly; her amateurish sexual demeanor and giddiness shine through her like light through pitch darkness.  She seems somewhat aware of this, but not as much as before; with her mind and body wholly consumed by lust, she longs only for your voice, your touch, and your inevitable penetration of her quivering form.");

				outputText("\n\nTrembling ever so slightly, her dripping ");
				if (flags[kFLAGS.PHYLLA_EGG_LAYING] > 0) outputText("nipples and ");
				outputText("wet vagina betrays her timidness.  You move up along the bedding and brush your [skin.type] against her own tender flesh.  Finally, you come to rest in the perfect position for penetration, Phylla looking over her shoulder at you with longing eyes and eager lips.  As you slide your tongue inside her mouth, you feel her twitch at the foreign sensation.  Closing her eyes, Phylla instantly melts like butter as your tongue finds hers of its own volition; clearly a turn for the better for you.  Phylla finally relaxes her legs and spreads them apart; the foreign sense of humid heat from her genitals registering as it warms your nethers.");
				outputText("\n\nSimply dragging your " + cockDescript(x) + " along the entrance her of moist pussy causes her to moan and wiggle under you. Parting her pink little lips with the head of your cock, you finally hit the sweet spot for penetration. With ");
				if (!rough) outputText("a gentle amount of force, ");
				else outputText("an uncaring, brutish amount of force, ");
				outputText("you push past the tight opening of Phylla's folds.  You hear Phylla inhale sharply as she stretches to accommodate your width. In what seems to be a prolonged amount of time, you finally manage to ease the head of your " + cockDescript(x) + " into her.  The act takes a loud and pained turn as Phylla moans and shifts in obvious discomfort.  You feel her squeeze her vaginal walls tightly around your cock as her considerable strength almost cuts off blood flow.  After a moment, Phylla realizes how much pressure she's exerting and her body relaxes, realizing the potential for injuring her partner.  Sighing heavily, she moves her hips down to take even more of you in. As you slide further in, her eyes flash with pain as she bites down on her lip, it becomes glaringly clear that something has yielded inside of Phylla.");
				outputText("\n\n<b>You have taken Phylla's virginity!</b>");
				//Corruption less than 75:
				if (!rough) outputText("\n\nHolding yourself still, you stare down at Phylla and inquire as to whether she is okay.");
				//Corruption more than 75:
				else outputText("\n\nUndeterred, you soldier on and breach further into her depths, barely giving her any time whatsoever to prepare herself for the onslaught of hard dicking that is to come.  The loss of her cherry and innocence is not up on your list of concerns right now.");
				outputText("\n\n\"<i>I'm okay- GUH! No, re-really I'm fine!</i>\" she stammers out behind half winced eyes.  You can tell she's trying to look past the obvious pain, eager to savor every moment of this ultimately fleeting \"first-time\".  You continue to touch all of her most sensitive spots, trying to replace the pain you're inflicting with softer pleasure.");
				//(Jump to Corruption less than 75 - Pure Ending)
				if (!rough) doNext(phyllaFirstTimePureBabiesFuckEnding);
				//(Jump to Corruption more than 75 - Corrupt Ending)
				else doNext(phyllaCorruptMascEnding);
			}
		}

//PURE ENDING!
		private function phyllaFirstTimePureBabiesFuckEnding():void
		{
			clearOutput();
            var x:int = player.cockThatFits(phyllaCapacity);
			outputText("For a while, you allow Phylla to slowly adapt to your presence inside of her and the stretching of her vaginal walls; something she reacts to with soft moans of pleasurable appreciation.  She wears her obvious discomfort at being forcefully stretched by your " + cockDescript(x) + ", but you see she can hardly complain as her body cradles yours in an attempt to keep you where you are.  Once you feel she's comfortable you start slowly pumping away at her, gradually building your own rut.");
			outputText("\n\nYou feel the smaller set of her hands move between your [legs] and start to fondle your ");
			if (player.balls > 0) outputText("[balls]");
			else outputText("sensitive taint");
			outputText(".  The moans that escape her lips pick up in both volume and stress as she knowingly encourages your lustful efforts on.  The working of her hips in concert with your thrusts affirms her readiness for your full force, giving you the all clear to pin her down and free your sexual aggression on her tight little love hole; slamming your cock into her, picking up the force and tempo behind each thrust.");
			outputText("\n\nPhylla's own sporadic moaning begins to mimic your movements, increasing in sync with each hard thrust into her.  The many soft, delicate hands of the ant morph cling to the bedding and tighten with each gyration, intent on not letting go until you both achieve your mutual satisfaction.");
			outputText("\n\nPhylla abruptly connects her mouth to yours with another fierce kiss, darting her tongue in your mouth and against yours, slapping it around with surprising ferocity as your saliva intermingles. Your carnal pleasures suddenly begin to mix and intertwine with something... else.  It dawns on you that Phylla has initiated her \"link\" once more; Pleasures, of your own and your lover, are shared between you both instantaneously.  The primal need to guide your " + cockDescript(x) + " deeper into her passes from her mind to yours.  With this new shared perception you feel the walls of her vagina sending pulses down your shaft, washing you in waves of pleasure.  Her long cilt drags along the shaft of your cock, causing her to arch her back again and again.  Your thrusting comes to a rapid staccato as your hips and hers work together in shared concert.  Yet, you can feel her grasping and understanding your rut; your need to work your cock just right along her depths.  Your need to penetrate her as hard as you can as you both build your orgasms.  Your feeling of the uncontrollable, primal urge to inseminate her love canal and breed her to bear your young.  You unknowingly make a snarl and grind your teeth together as you pound away at her, too consumed by animal like lust to notice.");
			outputText("\n\nAt this tempo, it's not long before your mind is suddenly bombarded by unfamiliar warnings.  It's a mix of yes and no, go and stop, pleasure and pain; and you revel in what exactly what it's receiving.  Thankfully the mixed messages from Phylla are understood within a few moments as she abruptly clamps down hard with her whole body and braces for what is to come.  With a girlish little howl, Phylla can't resist it anymore and climaxes.  You can feel the sweet smelling, and very wet release of her lady fluids on your genitalia.  Nearing your own orgasm, you begin to thrust at just that right angle, her vagina seemingly begging for you to release inside her.  It's when your " + cockDescript(x) + " is deepest inside her that she sends a fleshy quake down her vaginal walls.  As if that wasn't enough; you feel a whispering in your mind beckoning you to flood her with your seed.  You feel a distinct pull on your consciousness; as if impregnating her would fulfill her every need, her very destiny to become a mother.  This emotional crescendo is too much; you can't ignore it, can't control, or bear it any longer.  You arch your back, giving one final rock crushing thrust as your " + cockDescript(x) + " reaches its deepest point inside her.  Grunting fiercely, you cum inside her, firing your ");
			if (player.cumQ() < 50) outputText("thin");
			else if (player.cumQ() < 500) outputText("hefty");
			else outputText("thick");
			outputText(" ejaculate far into her womb.  Phylla responses in kind, working her hips and squeezing your body with her legs in an almost milking fashion, trying to draw as much seed as she can into her womb.");

			outputText("\n\nWith the last of your strength you pull out of Phylla and watch as almost none of your semen spills out of her.");
			//If cum milliliters over 100:
			if (player.cumQ() >= 100 && player.cumQ() < 1000) outputText("  Truly amazing considering how much your loads usually contain.  You think you see a little bulge in her stomach that wasn't there before.");
			//If cum milliliters over 1000:
			else if (player.cumQ() >= 1000) outputText("  As you look down at her nethers your mind struggles to understand just how she could... then looking up her body, you see.  Her belly is bloated with your sperm, almost to the point of already looking pregnant.");

			outputText("\n\nSpent, you drop your head down next to Phylla's, panting and breathing heavily as you resign yourself to rest.  Bits of the link remain as you feel Phylla's contentment.  She strokes your head lovingly, and pats her stomach.  Clearly her thoughts dwell on the package you just deposited inside her.  With the sync quickly fading you probe her mind one last time.  You can almost feel the sensation of your hot, sticky semen as it clings heavily on her vaginal walls.  A warm feeling flows over you as the excited thoughts of you getting her pregnant on her first try, making her a mother at long last... or so Phylla seemingly hopes.  Finally you sense at long last the closeness and intimate bond that she feels she shares with you at this very moment.  A sense of not wanting to let go, and wanting the breeding that has just past to continue forever and ever.  She yearns to pop out as many children as her body will allow her to and fulfill her need to breed.");
			//PC is a Female/Herm Drider:
			if (player.canOvipositSpider()) {
				outputText("\n\nThis overwhelming maternal feeling brings forth an interesting idea!  Turning to Phylla, you tell her that you can help to make her desire come true.  She looks at you a bit taken back, as if what you already did wasn't enough already.");
				outputText("\n\nYou go on to explain, telling her that your body is chock full of eggs that eagerly await a willing host to gestate in.  If she wants to birth as many children as possible, your union can grant her wishes; albeit, she will be birthing both Ant and Spider children.");
				//Persuade Phylla: Random chance of failing, affected by INT level and whether she's already housing eggs in her vagina.
				if (player.inte / 20 + rand(20) + 1 < 16) {
					//Persuasion failure:
					outputText("\n\nPhylla ponders for a moment and shakes her head.  \"<i>I'm sorry [name], I'm not comfortable with that right now.");
					outputText("</i>\"\n\n\"<i>Maybe later though...</i>\"");
					//End of persuasion failure
				}
				//Persuasion success:
				else SceneLib.phyllaScene.ovipositionScene();
				// (End Drider Continuation)
			}
			outputText("\n\nThe link fades not long after you both have settled down, and Phylla hums her approval as she kisses your neck lovingly.  You smile back, but never knew how strong one's maternal instincts could really be.  Hearing primal drives that are not your own was almost deafening.  Yet, you can't help but feel an appreciation for such an understanding that has been shown to you.");
			//PC has other waifus:
			if (camp.loversCount() > 1) outputText("\n\nSo this is what your other lovers must feel.");
			outputText("\n\nYou drift off to sleep not long after, while Phylla demonstrates her appreciation for the intimacy you two just shared, kissing your body and rubbing you sensually as you doze off.");
			if (!recalling) player.sexReward("Default","Dick");
			doNext(waifuQuestOver);
		}

//Corruption greater than 75 (Corrupt Ending):
		private function phyllaCorruptMascEnding():void
		{
			clearOutput();
			outputText("For a few moments longer, you pump yourself hard against her rump in an attempt to \"break\" your new fucktoy in.  Once you're satisfied that she will be able to handle what is to come, you take to sliding yourself along against her fuckhole as you grab her by the hair.  The backside of her abdomen grinds along your ");
			if (player.tallness <= 72) outputText("chest");
			else outputText("belly");
			outputText(", but it will only serve to help you.  You will need a brace for what you're about to pull and her rigid abdomen will do just fine.  Phylla makes a confused noise, glancing over her shoulder with a look of concern growing on her face.");
			outputText("\n\n\"<i>W-What are you doing?</i>\" she asks nervously. \"<i>This isn't how I imag~</i>\"");
			var x:int = player.findCock(1, -1, phyllaCapacity);
			if (x < 0) x = player.smallestCockIndex();

			outputText("\n\nWithout letting her finish, you plunge your " + cockDescript(x) + " into her, causing her to yell out in sheer surprise and discomfort.  \"<i>This is how <b>I</b> mate!</i>\" you inform her, telling her that she won't EVER forget her first time with you.  Her mouth goes open slightly before your subsequent gyrations put an end to whatever she was going to sputter out.  Smirking like a mad jester at the position you have Phylla in, you begin to work your hips as you dominate her from behind.  You hear your ");
			if (player.balls == 0) outputText("thighs");
			else outputText(ballsDescriptLight());
			outputText(" slap loudly off of her rump with every aggressive thrust against her clit.  She wails out in frustration at the lack of intimacy that you apparently have in mind.  The moaning that is mixed into her pathetic protests, however, suggests that the naive little woman is getting off on being treated so roughly; a hard slap on the ass affirms this as she whines out in annoyed pleasure.  You feel the growing heat from her pussy as it gets wetter and wetter, continuing your pressure on her abdomen as you use it to support your brutal fucking of her cunt.");
			//PC has Goo Body:
			if (player.isGoo()) outputText("  Perhaps the poor dear could use some tender attention, you ponder to yourself.  Reducing the solidity of your body, you work her abdomen deep into your sticky, goopy body, re-solidifying once she's firmly in there and lowering your hands down to her nipples, pinching them hard as you continue your pumping of her rump.");
			outputText("\n\nPoor Phylla can only grasp at her cushions as she struggles to maintain her comfort.  The brutish drilling of her pussy forces her to lift her rear further and further towards an acute angle. Try as she might, her efforts are no match for your barbaric tactics as you pound her love hole into oblivion.  All her attempts at maintaining a comfortable position quickly evaporate, and she resigns herself to being roughly taken from behind.  You watch as she buries her head into her cushions to muffle her howls of painful ecstasy.");
			//PC has more than one cock that is suitable:
			var y:int = player.cockThatFits2(phyllaCapacity);
			if (y >= 0) {
				outputText("\n\nIntent on increasing your own pleasures, you decide to work ");
				if (player.cockTotal() > 2) outputText("one of your free cocks");
				else outputText("your free cock");
				outputText(" against her tight ass. Feeling this new intruder, she turns back to you.");
				outputText("\n\n\"<i>No... P-please, you can't... I mean...</i>\" she manages to protest between moans of ecstasy and cries of pain as your cock works its way deeper with each thrust.  Scoffing at her plea, you guide your other cock into her anus.  It was never her choice to make in the first place, you tell her.  You feel the tightness of her muscular butt squeeze around your shaft - it's not as tight as her cunt is but it'll do!  You continue to thrust your hips as your cocks fill both of her holes.  You hear more muffled, painful moaning as you pound away along her anus.");
				outputText("\n\n<b>You have taken Phylla's anal virginity! And you love every second of it.</b>");
				//PC has more than one cock that is over 25 inches that's not in Phylla's butt or vag:
				if (player.biggestCockArea() > phyllaCapacity) {
					outputText("\n\nSeeing as how her hands aren't busy and she's certainly not using that mouth for anything useful; you reach down and guide one of your cocks so it presses against her down turned stomach.  You tell her to press it between her breasts and start sucking at the head.  Though this doesn't stop you from pounding away at her backside. She quickly grabs your [cock biggest] with her smaller hands and guides for a better position between her breasts.  She uses her upper hands to press her breasts together.  You immediately feel the effect of her B-Cups as with each thrust they warm the shaft of your long cock.");
				}
                else sceneHunter.print("Failed check: have one non-fitting dick");
			}
            else sceneHunter.print("Failed check: fitting second cock");
			outputText("\n\nYou maintain your vice-like pressure on her abdomen as you press onward, forcing your member");
			if (y >= 0) outputText("s");
			outputText(" deep within her.  You further your power and control over Phylla, in a way that seems to convey to Phylla to let it all out, don't hold back, to have her completely resign herself to you.  The unconscious move unleashes a loud series of lust-filled gibberish from Phylla.  You feel her body fold to your will as she abandons her shyness and restraint, mashing her rump against you with the intent to rut along with you like two primal animals intertwined in savage mating.  You can't see it, but you taste her hunger to be bred; you can feel and visualize her attractive, beet red little face wearing her passion as she clenches her teeth, your instincts and consciousness completely taking her over and commanding her to hump and fuck your cock until she gets what her cunt hungers for.");
			outputText("\n\nThe minutes that follow are hard for either of you to accurately remember.  The sweating of your bodies as they grind against each other.  The smell of your coupling filling the air...  Phylla moaning out like a cheap whore who's getting paid in gold bars... the increasing noisy crescendo of flesh as you rapt, your pelvis against her pussy.  All of it is but a murky blur of fierce, barbaric lust before the final release.  As you near orgasm, you can hear something in your head... something foreign... something warning Phylla that you will lead to her downfall.  Pleading with her to get away from your corruptive taint...  the instantaneous cockblocking voice of concern is quickly drowned out in a loud series of unmuffled wails and moans as Phylla nears climax.  You ignore the strange pleas but you aren't sure if she heard it or was she was the one thinking it.  The distraction gone, you continue thrusting wildly against her.");
			outputText("\n\nWith a roar that would cause even gods to notice, you explode into her.  Your cock");
			if (player.cockTotal() > 1) outputText("s twitch, ");
			else outputText(" twitches, ");
			outputText("ushering forth your corrupted seed into her womb");
			if (y >= 0) outputText(" and her ass.");
			else outputText(", and onto the bedspread below.");
			outputText("  As her pulsing cunt works to suck the semen out of your ");
			if (player.balls > 0) outputText("balls");
			else outputText("shaft");
			outputText(", Phylla retaliates with her own orgasm, flooding your groin with her sticky girl cum.  You glance down to your joined nethers and find a massive amount of Phylla's cum has pooled around your knees and more seems to be flowing every second.  Clearly, she's a squirter.");

			outputText("\n\nPhylla's wailing becomes muffled once more as she drives her face back into her pillows. Taking a deep breath you clear the orgasmic high from your mind.  You manage to calm down, and with a loud 'slack' sound, you dismount her.  Whatever link there was between you two is now thankfully broken.  Laying back you consider the 'warning' you felt, as Phylla curls up next to you.  You ponder what will happen to Phylla if she continues to mate with you?  Will she turn into a mindless slut that exists solely for your carnal desires?  Will she allow the corruption of you to take root and control her life?  Or maybe you should take a good look at yourself and see if what you're becoming is truly something you want.");
			//Sillymode:
			if (silly()) outputText("\n\nYou remember an old saying: \"<i>Those who fuck monsters are doomed to fuck monsters</i>\".  No, that's not right.  \"<i>Those who are monsters are doomed to fuck monsters?</i>\"  No, that's not it either.  Oh well.  You're sure it has something to do with something fucking something else.  A good analogy for your time here in Mareth.");
			//Corruption is greater than 80:
			outputText("\n\nPerhaps corrupting her is the best route; look how you turned out! You could live with that...!  Giggling, you smirk at the thought of Phylla's mother; how she was right about you the whole time.  The thought of what kinds of corruption you can inflict on Phylla fill your mind until you finally drift off, holding your unsuspecting victim in your arms.");
			if (!recalling) {
				player.sexReward("Default","Dick");
				dynStats("cor", 5);
			}
			doNext(waifuQuestOver);
		}

//Cunnilingus Scene: (Triggered if PC does NOT have a dick that is suitable for vaginal sex with Phylla.)
		private function cuntmuffinLingusPhyllaDickBig():void
		{
			clearOutput();
			outputText("Sadly, as you gaze down at your [cocks], you realize that trying to penetrate Phylla with your freakishly large prick");
			if (player.cockTotal() > 1) outputText("s");
			outputText(" isn't going to work.  Phylla's eyes begin to tear up as she also comes to the realization that her first time is a non-starter.");
			outputText("\n\nNot wanting to leave her virgin night a bust you playfully push her back onto the cushioned floor, causing her to land bottom first.  Confusion washes over her as she struggles to understand what you are planning to do; something that's further exacerbated when you lay down next to her.  Awkwardly you roll over on your back, doing your best not to knock over any furniture in the process.");
			outputText("\n\n\"<i>W-What are you doing?</i>\" she asks, somewhat upset that she won't be getting the traditional first time sex.  Arcing your [cocks], you ");
			//Dick Size Over 48 but Under 69 inches:
			if (player.longestCockLength() < 69) {
				outputText("angle your hips so that ");
				if (player.cockTotal() == 1) outputText("it points");
				else outputText("they point");
				outputText(" at the ceiling, placing them out of the way for what you have in mind.");
			}
			//Dick size Over 70 inches::
			else {
				outputText("angle your hips so that ");
				if (player.cockTotal() == 1) outputText("it is");
				else outputText("they are");
				outputText(" aimed out the doorway.");
			}
			outputText("  You wickedly beckon Phylla over to you with a hooked finger.  Phylla looks at you quizzically for a moment before it dawns on her.  Her eyes widen and cooing she scrambles over to you.");

			outputText("\n\nPhylla giggles in relief at both her inexperience and embarrassment over not being able to take a hint.  Disrobing as she walks towards you, her hips and abdomen swaying sensually, you can see her long clit sticking out of the folds of her pussy.  Clear strands and drops of her wetness glean from between her legs.  You see her lower set of arms disappear between her legs as she moves around you.  Phylla then emerges above your head.  Her hips shift and come to a stop with her facing outward on top of you, the warmth of her moist cunt washing over you, and you clearly seeing her long inviting clit, begging you to lick at her button.  You reach up and take hold of her chitinous legs.  You slowly drag her hips down and press your mouth against the smooth folds of her labia.  The intoxicating aroma of her scent fills your nostrils, causing your eyes to roll back in your skull.");
			outputText("\n\nLooking down she places her larger set of hands on your shoulders, and playfully shoves you back against the bed.  Ruefully, Phylla reaches down toward your face with one of her smaller hands, as if wanting to show you something.  Her small hand is covered in what appears to be her own love juices.  Holding you in place, she gently places her hand on your cheek and slowly glides her lathered fingers along your chin, leaving a small trial of sweet smelling nectar.");
			//Silly Mode:
			if (silly()) outputText("\n\nYou hear her whisper \"Simba\", as she rubs her fingers across your brow.  You inquire as to what that means; as it awkwardly broke the tension you were building.  She tells you it means \"Silly\" in her native tongue. You raise an inquiring eyebrow in response.");
			outputText("\n\nSighing, Phylla gestures to your enormous cock.  Clearly she's still depressed you're unable to penetrate her properly.");
			outputText("\n\nTo finish up her teasing, she runs her fingers down the bridge of your nose ending on your lips. The scent and warmth of her essence again is starting to drive you crazy.  You feel your already hard cock stiffen even further, driving your body into a rut as you inhale her sweetness.  Your inhumanly large cock");
			if (player.cockTotal() == 1) outputText(" switches and bobs");
			else outputText("s switch and bob");
			outputText(", loudly brushing against the ");
			if (player.longestCockLength() < 69) outputText("ceiling");
			else outputText("wall in the hallway");
			outputText(".");
			outputText("\n\n\"<i>I didn't think... that would work...</i>\"  Phylla whispers sweetly into your ear, grinning like a fool.");
			outputText("\n\nPulling her hands away from your shoulders, Phylla gives you a small nod and smile, signaling the go ahead for you to claim her pussy for your own.  You waste little time in doing so as you dart in and seize a portion of her labia in your lips.  Above you, Phylla makes a girlish gasp as you make contact.  Two of her hands caress your hair as the other two hold your head in place while you eat her out.  Grinning, but still holding her labia in your mouth, you drive your tongue into her, unleashing a series of quick flicks inside of her as you eat her out.  The very taste of her insides drives you even further into your rut.  It's then you feel a very blunt object sticking you in the nose as your tongue probes deeper and deeper into Phylla.  You realize her clit sticking out almost 2 inches past its hood, the long pink rod pleading for attention.  You reach up with your hand and give it a good pinch between your fingers. In immediate response Phylla moans loudly and squeezes your head between her legs.");
			//PC has goo body:
			if (player.isGoo()) outputText("\n\nA thought enters your head and fills your mind with images of her grinding furiously against your face.  Realizing that she'd probably appreciate a firm \"base\", you work some of your mass up her legs and cradle her lower body into your own slightly thinned and warped mass.  Phylla looks down in surprise as she sees what you're doing, but hums approvingly once she figures out what you have in mind.");
			outputText("\n\nClosing her eyes to enjoy your efforts, Phylla utters a pathetic moan as she better positions herself against your face.  Once she's found her optimal position you find your face pinned between her cunt and cushioned floor, the ansty Princess completely intent on keeping you there until you've done your duty.");
			outputText("\n\nTaking her cue, you remove your tongue from inside her and spread her lips apart with your hands, then begin to tease the tip of her long clit with your tongue, allowing the soft yet bumpy texture of your tongue to slide along the full length of her love button.");
			//If Snake Tongue:
			if (player.tongue.type == Tongue.SNAKE) outputText("  You run the split of your forked mouth muscle from the tip of her clit to the base.  As your textured feeler makes its way down, you wrap around the rest of her long clitorus, like a boa constrictor.  Once your split reaches the hood of her clit you roll and flick the tip of your tongue rapidly.  Pulling at your hair she gasps for breath in between teeth grinding moans.");
			outputText("\n\nA surprised, muffled moan escapes from your lover's mouth as you lick past one particular spot near the hood of her clit.  More out of curiosity than anything else you \"retrace\" your efforts past that spot.  Again, Phylla whines out in unrestrained ecstasy, signalling that you found a sensitive spot.  You half hum, half sigh into her vagina, knowing full well further 'investigation' around this area will make Phylla act like a bug caught in a spider web.  Phylla tenses up as she figures out you've found her weakness.  You hear her pleading that you focus on all of her stiff nub.  Obviously, she has no idea how intense this can get and isn't too keen to find out.  But you can't pass this up!  With a playful little war cry, you take to her sensitive spot.  You immediately began licking and smashing your tongue against it like there's no tomorrow.");
			outputText("\n\nYou hear her attempt to say something before her body takes over her mind.  She drowns herself out in moaning and whining as she braces her thighs against your shoulders and head, violently shaking your entrapped head back and forth, while simultaneously grinding her hips into your face. You ravenously assault her clit with no regard for her other desires;  She'll overcome her doubts and see that your \"technique\" is more than adequate. Gazing upwards, you see her face as she looks completely overcome with euphoria.");
			outputText("\n\nPhylla quickly begins to grind her clit against your mouth harder and faster. Drenching your already wet face in even greater volumes of her lady juices. She furiously works her hips to yield more pleasure.");
			outputText("\n\nAt this rate it won't be long before she reaches her peak, so you might as well make the finish one to remember.  Driving your fingers against her clit and teasing her labia you begin to rub at a lightning pace.  Phylla almost instantly loses her balance and stumbles backwards onto your " + multiCockDescriptLight());
			if (player.isGoo()) outputText(", tumbling out of your mass as she tears free");
			outputText(".  She holds one of her hands out in an attempt to catch her breath.  Ignoring her, you dive in and continue your unrelenting assault as her legs twitch uncontrollably over your head, like a dog having its stomach petted.  Screaming out, Phylla seemingly sputters a garbled string of nonsense until she takes your head in a vice like grip between her thighs.  Feeling her vaginal muscles convulse and tighten on your tongue you notice the signaling of climax.  With one final body contracting pulse Phylla arches her back and roars in orgasmic bliss.  You open your mouth in eager anticipation as her orgasm washes over you.  Her girl cum seems almost never ending as pulse after pulse of it squirt out of her.  You swallow at least two mouthfuls before turning your head, only to feel more splash on your cheek.  Still holding you firmly in between her legs, your Ant Morph lover continues to grind and spurt out juices all over your [face].");
			outputText("\n\nPhylla is clearly a squirter, in both volume and force.  You decide that it would be best to make a mental note of that for next time.  Exhausted, Phylla slumps against your prick");
			if (player.cockTotal() > 1) outputText("s");
			outputText(" and pants heavily, having just gone through the equivalent of an orgasm triathlon.  As you sigh, you can hear her giggle in what sounds like disbelief.  \"<i>Heh... I didn't think I had it in me to do... that,</i>\" she coos, staring mischievously up at you.  \"<i>Just... could you shrink ");
			if (player.cockTotal() == 1) outputText("this monster");
			else outputText("these monsters");
			outputText(" down?  I mean, I'm not complaining!  But I... just... I mean... you... inside me,</i>\" she shyly remarks, obviously wanting something more... traditional.");
			//(Player lust increases to 100)
			if (!recalling) {
				dynStats("lus=", player.maxLust());
				flags[kFLAGS.DIDNT_FUCK_PHYLLA_ON_RECRUITMENT] = 1;
			}
			//Where the fuck is this going?
			doNext(waifuQuestOver);
		}

//►Female Continuation
		private function phyllaFirstTimeVagina():void
		{
			clearOutput();
			outputText("Eager to get to some good old fashion fun, you direct your thoughts to Phylla, telling her to 'remove her clothing'.  After all of the pieces of her royal attire are removed, she closes in and rubs her naked body against yours.  Her fingers move fluidly as she slowly traces her ever hardening nipples along your chest and along the ridges of your back, sending a sensual chill up and down your spine.  Your " + nippleDescript(0) + "s harden in response, and with surprising speed she shifts her body downward and locks her mouth around your nipple, firmly suckling at your hardened areola.");
			//If PC Lactating:
			if (player.lactationQ() > 250) outputText("\n\nYou can feel her suck some of the milk from your breasts, slating her weak thirst in the process as she becomes immensely aroused at the sensation of \"nursing\" from her lover's " + breastDescript(0) + ".  Weird... you can taste the nutritious warmth of your nectar as it flows down her throat and into her stomach.  Drinking and tasting one's own breast milk could definitely weird someone out, but the foreignness of the act is an odd turn-on for you, and you let her continue to suckle.");

			outputText("\n\nHer tongue moves expertly, darting over your nipple whilst she moves a hand over to the other, gently caressing and teasing your sensitive flesh with her soft tongue.  The thought of having your nipples pinched runs wild through your mind, and before you realize what you have done, your lover does exactly that.  You let out a surprised moan of pleasure, and she seems to get the picture as she escalates into running the nipple in her mouth along her teeth, even biting down just the right amount to find the space between pain and pleasure.  When she finally unlatches herself from your nipple, she looks up to you with the most devilish smile.  Grinning ear to ear as she licks your milk from her lips, she stares deep into your eyes.");
			//PC has Goo body:
			if (player.isGoo()) outputText("\n\n\"<i>How did I not get slime in the milk?</i>\" she asks, breaking the stare.  \"<i>I figured the slime would make your milk taste bad, but... it made me want it more... Sorry,  I got distracted there</i>\" She says, apologizing as she stares once more into your eyes.");

			outputText("\n\nYou suddenly sense an idea... no; a suggestion, tickling the back of your mind.  Somehow you decide it's a good idea to lay on your back with your legs spread wide open.  You're not sure where this foreign thought is coming from, but it appears to be \"asking\" you to lay back and prepare for a little carnal loving; something that entices your " + clitDescript() + " as you heed its direction and lay back on the bed.  Looking upwards as you prepare for her loving assault, you see the liquid in the bowl reflecting a shifting rainbow along the ceiling.  You also realize, while on your back that whatever Phylla did to you works both ways, as you come to the stark realization she has gotten you laying on your back.  She moves her hips over your face so her moist, inviting vagina is suspended ever so slightly over your mouth; the rest of her abdomen extending just past the top of your head.  Her scent fills your nostrils and floods your body with its intoxicating allure.  Lust takes hold of your mind, and you cannot restrain yourself from wanting to bury your face in that tender hole of hers.  No! You want to do more than that; you want to ravage her moistening cunt with your mouth like a dog with a new chew toy, but something holds you back.  It's like your body is being shackled by your mind, but you get the feeling it's not \"your\" mind holding you back.");
			outputText("\n\nYou shoot a gaze down your own body and see her looking up at you, upside down from your vantage point, from between your legs.  She smiles mischievously at you and then moves her face over your [clit].  You can feel her humid breath on your womanhood and it stiffen in response.  Starting at your knee, she runs her two lower hands down your inner legs, ever so gently, and ending in a circular motion right above your now engorged " + clitDescript() + ", while using the other two hands to spread you wide open for her mouth's descent on your clit, her tongue savagely attacking it like a pack of lioness' on a gazelle.  You arch your back again and moan; not wanting this to be a one way gift you reach up and take hold of her nipples, giving them each the slightest pinch to tease Phylla.  Your enamored lover shudders and moans loudly, but the sound is muffled by your [clit] in her mouth.");
			outputText("\n\nYou've had just about enough of her denying you her pussy, and concentrate hard on forcing her to lower herself onto you.  Quite a task, given your current predicament.  Right when you think about giving up trying and just enjoying her going to town on you, you feel her mind bend to you and her once out of reach lips lower.  She's so wet you can see the streams of her arousal running down both sides of her chitinous legs.  Zeroing in, you fixate on her clit, which is much longer than you expected and sticks out far past the folds of her fuckhole.");
			menu();
			//(If PC has NO DICK(S)! Jump to - Scissoring Continuation)
			//(If PC has ANY NUMBER of DICK(S)! - Jump to - If PC Herm/Has (a) cock(s))
			if (sceneHunter.uniHerms)
				outputText("\n\n<b>You can ask Phylla to take care of your cock(s) while scissoring.</b>")
			sceneHunter.selectGender(null, girlFiller, null, femalePhyllaFirstTimePlusCock);
		}

		private function girlFiller():void
		{
			clearOutput();
			//Scissoring Continuation - No Dicks!
			outputText("You coo at the prospect of finally allowing your tongue to go to town on her, but right as you're considering what to do you feel something enter you, causing you to let out a surprised moan.  Looking down, you expect to see her mouth still firmly planted on your clit; instead, your lover's chitinous fingers have begun to penetrate your pussy.");
			outputText("\n\nYour body begins moving on its own as you writhe in pleasure, Phylla continuing her loving, unending assault on your nethers.  In a moment of clarity your mind snaps into focus.  Your move!");

			outputText("\n\nNow that your lover is fully enthralled and aroused you feel her hard clit and guess it's almost two inches in length.  As you start sucking it, you can feel the surge of pleasure crash into Phylla's mind and hear a loud vocalization that sounds like a mix between a moan and an 'Eeep!'  She momentarily stops her work on you and just starts moaning loudly.  You move your fingers and spread her open, just as she did to you.  Gently, the index finger currently on her sex maneuvers over the threshold of her lips, running up and down it, whilst you continue to suck on her long clit.  The mental directive from your lover to penetrate her registers in your mind, and you happily oblige.  Quickly and expertly you move your finger along the sensitive insides of her love canal, feeling the mounting pleasure filling her in your mind.");

			outputText("\n\nYour tongue runs up, down, and all around her tender clit as you continue to suckle it.  The sensation of being out of your body almost take control for a moment as you lovingly bite down on her clit and shove your fingers deep into her, realizing that Phylla exerted a momentary degree of control over your own actions.  Getting the general idea, you start to thrust your fingers deeper and deeper as you suck her clit harder and harder. You can feel her help your fingers search for her g-spot.");

			outputText("\n\nThen a sudden image, and sensation of shock fires into your mind; her whole body seems to tense up and with a sudden hip grinding pulse, she orgasms, moaning so loudly it seems to echo off the walls. Well toned legs squeeze tightly against your head and then relax with a hearty groan as she squirts her girl cum all over you. Your hand and face are utterly drenched with her warm love juices and you try to drink up what you can... but there's just too much!");
			outputText("\n\nAfter a quick pause to clean your face off, you comment to Phylla how it's unfair for her cum without you. Her eyes open wide in horror, but before she can speak, you fire an image into her mind. It's time you take control of this. You slowly untangle yourself from all of Phylla's limbs and come to rest on top of her. Slowly you pull her legs apart and slide your thighs between hers.");

			outputText("\"<i>I-I've... never,</i>\" she stammers, but you just want her to experience this before she ruins the moment.");
			outputText("\n\nRocking your hips you see the exact reaction you expected as Phylla moans into the air, arching her back and instinctively rocking her hips into yours.");
			menu();
			addButton(0, "Next", scissorContinue, true);
		}


//If PC Herm/Has (a) cock(s):
		private function femalePhyllaFirstTimePlusCock():void
		{
			clearOutput();
			outputText("You coo at the prospect of finally allowing your tongue to go to town on her, but right as you're considering what to do you feel something enter you, causing you to let out a surprised moan.  Looking down, you expect to see her mouth still firmly planted on your clit; instead, the chitinous lover's fingers has begun to penetrate your pussy, while her other free arm");
			outputText(" has taken");
			outputText(" hold of ");
			//One dick only:
			if (player.cockTotal() == 1) outputText("your [cock].");
			else outputText("your [cock] leaving the lucky member to bask in affectionate glory as the rest of your manhood laments being left out.  \"<i>Don't worry, I have four hands...</i>\" Phylla coos as she works your shaft.");
			outputText("\n\nYour body is moving on its own as you writhe in pleasure, Phylla continuing her loving, unending assault on your nethers.  In a moment of clarity your mind snaps into focus.  Your move!");
			outputText("\n\nYou thrust your head between her legs and, pursing your lips, grasp her clit. You can guess it's almost two or three inches in length.  As you start sucking it you can feel the surge of pleasure crash into Phylla's mind, and a loud vocalization that sounds like a mix between a moan and an 'Eeep!'.  She momentarily stops her work on you and just starts moaning loudly.  You move your fingers and spread her open, just as she did to you.  Gently, the index finger currently on her sex maneuvers over the threshold of her lips, running it up and down, whilst you continue to suck on her long clit.  The mental directive from your lover to penetrate her registers in your mind, and you happily oblige.  Quickly and expertly you move your finger along the sensitive insides of her love canal, feeling the mounting pleasure filling her in your mind.");
			outputText("\n\nYour tongue runs up, down and all around her tender clit as you continue to suckle it.  The sensation of being out of your body almost takes control for a moment as you lovingly bite down on her clit and shove your fingers deep into her, realizing that Phylla exerted a momentary degree of control over your own actions.  Getting the general idea,you start to thrust your fingers deeper and deeper as you suck her clit harder and harder, your hands moving at blinding speed as you finger your new lover.");
			outputText("\n\nThen a sudden image, and sensation of shock fires into your mind;  Her whole body seems to tense up and with a sudden hip grinding pulse, she orgasms; moaning so loud it seems to echo off the walls.  Well toned legs squeeze tightly against your head, and then relax with a hearty groan as she squirts her girl cum all over you. Your hand and face are utterly drenched with her warm love juices and you try to drink up what you can... but there's just too much!");
			outputText("\n\nShe rolls off of you in a state of absolute euphoria. You sit up on your elbows and make eye contact with her for a moment, causing her to giggle as she admires her comedic handiwork.  Of course, the once shy Ant Morph now eyes your own drooling pussy.  She looks as though she's about to continue stimulating you, but then you think of a better idea.  It's time you take control.");
			//(If dick(s) (is/are) huge, length unknown - Jump to - Dick(s) too Big)
			sceneHunter.selectFitNofit(fitF, nofitF, phyllaCapacity);

			//PARTS
			//==========================================================================================================
			function fitF():void {
				//Dicks too Big:
				outputText("\n\nDespite your best efforts to try and get into a comfortable position to scissor, your painfully erect  [cocks] prevent you from doing so, given that they are now compressed against the ceiling.  While the display of rainbows is pretty to watch on your [cocks], the crushing pain and the unyielding nature of your [cocks] is too much.  ");

				//Horse: (Cont from ...is too much.)
				if (player.isTaur()) outputText("Seeing your impending predicament, Phylla quickly scrambles with all four of her arms to collect a bunch of cushions.  She stacks them in a makeshift 'resting place' and helps you into a comfortable position as your cocks precede to grow uncontrollably.");
				//Drider body:
				else if (player.isDrider()) outputText("Phylla immediately realizes this, and flips you over so that you are resting on your head and neck, ducking in past your [cocks] and coming to rest on the border between your spider carapace and soft clit.");
				//Goo body:
				else if (player.isGoo()) outputText("Phylla immediately realizes this, and flips you over so that you are resting on your head and neck, and she works her way through your goopy mass, connecting her clit with yours in little time or effort. \"<i>This is a little weird... but I like it...</i>\" she flirts. Hardening your mass slightly, you snugly secure Phylla against your body, telling her that things \"might\" get rough.");
				//Human/Harpy/Naga legs:
				else outputText("Phylla immediately realizes this, and flips you over so that you are resting on your head and neck, and curls your [legs] towards her.");

				outputText("  Your [cocks] now resting comfortably out of the open room, Phylla positions herself to scissor your pussy.");
				outputText("\n\n\"<i>Y-you had me worried for a second. I mean, I've never seen something... So <b>big!</b></i>\" she teases.");
				//(Transitions to Freakishly huge dick(s):)
				outputText("\n\nYou start rocking your hips and your pussies kiss, fluids mixing harmoniously together as shots of pleasure pass through both of you.  Her clit seems to penetrate further and further into yours with every push, and though it's not enough to fully enter you, the sensation on the inside sends wave after wave of euphoric bliss over the both of you.");
				scissorContinue(false);
			}
			function nofitF():void {
				outputText("\n\nYou position yourself over her so your cunt and hers are pressed together. Grabbing one of her legs you raise it so that her pussy lips are forced apart.");
				outputText("\n\n[EachCock] hungers for attention, having been let go by Phylla when you shifted into a scissoring position.  Reaching down to start taking care of yourself; Phylla interrupts you abruptly.  \"<i>Oh, I'm sorry! I mean... I forgot... just feels... so gooood,</i>\" she coos between moans of ecstasy.  After a moment she seems to forget as waves of pleasure wash over her.  You make a playful throat clearing noise and gesture to your [cocks].  Phylla quickly snaps back into reality and takes hold of ");
				//Tentacle dick check
				sceneHunter.print("Tentacle dick check (up to 3)");
				var tenta:int = player.countCocksWithType(CockTypesEnum.TENTACLE);
				if (tenta > 0) {
					//PC has (a) Tentacle dick(s):
					outputText("your tentacle dick" + (tenta > 1 ? "s" : ""));
					outputText(". Clearly she's never seen anything like it before as she doesn't know what to do.  Laughing, you tell Phylla she doesn't need to do anything except hold still.  You snake your tentacle cock" + (tenta > 1 ? "s" : ""));
					outputText(" up her body, making sure to caress her most tender places on their way.  She screams out loudly in shock only to realize what happened when she looks down.  \"<i>God, you scared me!</i>\" she yells, embarrassed that she got frightened half to death by your dick" + (tenta > 1 ? "s" : ""));
					outputText(". Laughing at her display, you motion to your prick" + (tenta > 1 ? "s and wiggle them" : " and wiggle it"));
					outputText(" in front of her, like a worm to a bird in her face.  \"<i>Aw, does someone need some attention?</i>\" Phylla teases, taking ");
					//PC has:
					//one tentacle dick:
					if (tenta == 1) outputText("your cock into her mouth as she continues to rock her hips into yours.");
					//two:
					else if (tenta == 2) outputText("your cocks into her mouth and between her breasts as she continues to rock her hips into yours.");
					else  outputText("your cocks into her mouth, between her breasts, and along her body.  The ones on her body tightly wrap around her insectile joints, using her muscular curves to get you off.");
					//End TD check; if TD's are present, ignore non-TD check and, below, and skip to scissoring continuation.
				}
				else {
					//PC has one/two dick(s) not exceeding 4 inches in width total:
					if (player.countCocks(-1, 2, "width") >= 2)
						outputText("two of your [cocks], stroking them apologetically as she scissors you.  You feel her almost insatiable appetite for all parts of your body.  You feel Phylla's mind slowly becoming lost in pleasure.");
					else if (player.countCocks(-1, 4, "width") > 0) outputText("your " + cockDescript(player.smallestCockIndex()) + ", stroking it apologetically as she scissors you.  You feel her almost insatiable appetite for all parts of your body.  You feel Phylla's mind slowly becoming lost in pleasure.");
					//PC only has a dick(s) that('s) (are) more than 4 inches in width:
					else outputText("your " + cockDescript(player.smallestCockIndex()) + ", but she simply can't fit any number of her hands around the entirety of your glans; instead, she takes to caressing the head of your " + cockDescript(player.biggestCockIndex()) + ".");
					//(Leads to - Scissoring Continuation)
				}
				scissorContinue(false);
			}
		}

		private function scissorContinue(clear:Boolean):void
		{
			if (clear) clearOutput();
			else outputText("\n\n");
			//Scissoring Continuation
			outputText("You increase both your tempo and force as you grind your sex against hers, and your hips are greeted with Phylla trying her best to stay in place and to give the most resistance possible. The sensation of a foreign orgasm enters you, signalling Phylla is close to another body twitching release; at the same time you feel yourself also building up to one of your own. Simultaneously, you work each other up until you're both on the brink.  Your hips work at a fierce speed, caressing your cunts together in a flurry of sexual fury, neither of you letting the other cum and just enjoying the pleasure that you're sharing mentally, until Phylla can't stand it anymore and releases her hold over you.  The barrier to your orgasmic fulfillment gone, your mind becomes overwhelmed and releases control over her own release, flooding her mind with your euphoric delight.  Both of you cum in unison, drowning in earth shattering bliss. Phylla releases all notions of timidness and screams in utter bliss, spraying her love juices all over your cunt like a fountain, and you do the same in return; although not in nearly the same amounts.");
			outputText("\n\nYou almost collapse onto her as your body attempts to recover from pleasure.  You catch yourself planting both your arms on either side of Phylla's face, hanging over her.  She reaches up and wraps all her arms around you, bringing you down to lay next to her.  The shy ant morph turns her head and kisses you one final time before you both pass out in each other's embrace.");
			if (!recalling) player.sexReward("vaginalFluids");
			doNext(waifuQuestOver);
		}

		private function waifuQuestOver():void
		{
			if (recalling) {
				camp.recallWakeUp();
				return;
			}
			clearOutput();
            phyllaSprite();
			outputText("You wake but are unsure of how long you've been asleep; hours or maybe a day, it's hard to tell in this place.  Trying to stand was a mistake... you feel like your brain has just gone through three rounds of boxing with a minotaur.  The world spins around as you stagger to gain balance. Whatever Phylla has done to you seems to be wearing off, and it leaves you with an emptiness in your mind.");
			outputText("\n\nYou look over at Phylla, noticing that she's completely passed out in a very cute fetal position. You can see the indent you were making next to her before you stood up.  It's odd, but you can still feel that \"link\" you two shared; her thoughts and emotions like the whisper of wind around you. Just looking at her sleeping seems to make your worries melt away.  Your lack of presence in bed causes her to stir and wake, and she rubs her eyes in an effort to fully drag herself into consciousness. You can tell from her body language that she's experiencing the same withdrawals you are.  As you start to gather your things, your sleepy lover groggily says, \"<i>I can join you at camp if you want, I don't take up much space.  Above ground!  I mean, I'll be underground, I mean, I won't bother anyone.  I-I'll be good...</i>\"");
			//[Come to Camp] [Stay Here]
			menu();
			addButton(0, "Come2Camp", getAntWaifuYoShit);
			addButton(1, "Stay Here", tellPhyllaToStayTheFuckAtHomeThatCunt);
		}

//[Come to Camp]
		private function getAntWaifuYoShit():void
		{
			clearOutput();
			outputText("You smile at her and tell her you would love for her to join you at your camp.  Her face brightens like the sun and she quickly gathers the very few possessions she owns - mostly clothing, the pillows, and some jewelry.  Together you promptly leave the colony and head back to camp.");
			outputText("\n\n(<b>Phylla has moved in!  She can be found in the lovers tab!</b>)");
			flags[kFLAGS.ANT_WAIFU] = 1;
			doNext(camp.returnToCampUseOneHour);
		}

//►[Stay Here]
		private function tellPhyllaToStayTheFuckAtHomeThatCunt():void
		{
			clearOutput();
			outputText("Telling Phylla that your camp isn't really the safest place for her, even if she's underground, doesn't seem to make her accept the fact you're leaving her here any more heartbreaking.  You tell her you would rather her stay here for now, knowing she's safe, until you can make your campsite 'ready' for her.  She looks a little doleful but she agrees.");

			outputText("\n\nAs you turn to leave she quickly says, \"<i>If you ever feel your camp is safe enough for me to join you, p-please come get me.  If you want.  I mean, I'm not going anywhere... not that I could with my mother watching anyway...</i>\"");
			outputText("\n\nYou nod and without another word, head back to camp.");
			flags[kFLAGS.PHYLLA_STAY_HOME] = 1;
			doNext(camp.returnToCampUseOneHour);
		}

//If PC returns to colony after telling her to stay with her mother:
		private function bumpIntoTheAntColonyAfterStayHomePhylla():void
		{
			clearOutput();
            phyllaSprite();
			outputText("You make your way down a strangely familiar path that leads to Phylla's room.  Her head quickly snaps around upon seeing your shadow in her doorway.");
			outputText("\n\n\"<i>Eeep!</i>\" she clicks - clearly you startled her out of some daydream.");

			outputText("\n\n\"<i>Oh! [name] you're back!  I mean, I knew you would come back for me!  I mean... Are you ready for me to join you at your campsite?</i>\"  Phylla asks eagerly.  Looking around you can tell she's already packed everything she owns in preparation for her 'big move'.  You're not sure if she wants to join you that badly or if she just wants to get away from her mother.  Once she notices you looking around she continues.");

			outputText("\n\n\"<i>I won't take up much space.  Above ground! I mean, I'll be underground, I-I won't bother anyone.  I-I'll be good...</i>\"");

			outputText("\n\nYou consider this.");
			//[Come to Camp] [Stay Here]
			//(Note: There's no content here for her staying at her mother's Colony. She's meant to be a Waifu.)
			menu();
			addButton(0, "Come2Camp", getAntWaifuYoShit);
			addButton(1, "Stay Here", tellPhyllaToStayTheFuckAtHomeThatCunt);
		}

	}
}
