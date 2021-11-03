package classes.Scenes.Places{
	import classes.*;
	import classes.BodyParts.Antennae;
	import classes.BodyParts.Arms;
	import classes.BodyParts.Ears;
	import classes.BodyParts.Eyes;
	import classes.BodyParts.Face;
	import classes.BodyParts.Hair;
	import classes.BodyParts.Horns;
	import classes.BodyParts.LowerBody;
	import classes.BodyParts.RearBody;
	import classes.BodyParts.Skin;
	import classes.BodyParts.Tail;
	import classes.BodyParts.Tongue;
	import classes.BodyParts.Wings;
	import classes.GlobalFlags.kFLAGS;
	import classes.Items.Armors.Nothing;
	import classes.Scenes.Areas.Forest.WoodElvesHuntingParty;
	import classes.Scenes.SceneLib;
	import classes.internals.SaveableState;
	import classes.CoC;

	public class Mindbreaker extends BaseContent implements SaveableState{

		public static var MindBreakerQuest:int;
		public static const QUEST_STAGE_MBOFF:int = -1;
		public static const QUEST_STAGE_NOT_STARTED:int = 0;
		public static const QUEST_STAGE_METMB:int = 1;
		public static const QUEST_STAGE_ISMB:int = 1;

		public static var hasTrainedToday:Boolean;
		public static var hasTrainedTodayCooldown:int;

		public function stateObjectName():String {
			return "Mindbreaker";
		}

		public function resetState():void {
			MindBreakerQuest = QUEST_STAGE_NOT_STARTED;
		}

		public function saveToObject():Object {
			return {
				"stage": MindBreakerQuest
				//"elfHasTrainedToday": hasTrainedToday,
				//"elfHasTrainedTodayCooldown": hasTrainedTodayCooldown
			};
		}

		public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
			if (o) {
				MindBreakerQuest = o["stage"];
				//hasTrainedToday = o["elfHasTrainedToday"];
				//if ("elfHasTrainedTodayCooldown" in o) {
					// new save, can load
				//	hasTrainedTodayCooldown = o["elfHasTrainedTodayCooldown"];
				//} else {
					// old save, still need to set Cooldown  to something
				//	hasTrainedTodayCooldown = 0;
				//}
			} else {
				// loading from old save
				resetState();
			}
		}

		public function Mindbreaker(){
			Saves.registerSaveableState(this);
		}

		//[Find Elves]
		public function findMindbreaker():void {
			clearOutput();
			MindBreakerQuest = QUEST_STAGE_METMB;
			outputText("As you wander the mountainside you venture across a distinct tunnel entrance where the light does not penetrate far. A sudden sense of foreboding envelops you for a moment, and for a moment you hesitate, holding yourself back from entering the crevice." +
					" A strange, almost alien feeling flows through the crack. Winds waft a peculiarly pungent smell of storm drenched grounds towards you. Weird. It hasn’t rained in... how long has it been since it rained? Likely several days at this point." +
					"\n\nYou’re kept from marching unto the breach, a phantom grip on your heart is stalling your advance." +
					" Why are you being so apprehensive about this? It’s not like you haven’t faced walking nightmares before, and all this- this entire world filled to the brim with rape machines and creatures casually strutting around with hips as wide as a cart and more than enough cocks to plug every hole a human could have!" +
					" If anything, it’s probably just another one of the Demon’s spells or something trying to paralyze you with fear;" +
					" make you too scared to fight so they can have their way with anyone under its effects." +
					" It’s just a matter of steeling your nerves and venturing forth. But still… maybe this time you should listen to your instincts? Is whatever that resides within worth what you could encounter?" +
					"\n\nDo you continue?" +
					"\n\n<b>-Warning-\n" +
					" -Content in this cave is not for everyone. It includes mind break, tentacles, parasitism and severe slutification. Proceed at your own risk.</b>\n");
			//[Ask about elves] [Leave]
			menu();
			addButton(0, "Yes", YesTentacle,0,0,0,"Continue exploring the cave.");
			addButton(1, "No", FuckNo,0,0,0,"Get the hell out of here!");
		}

		//"\n\n\"<i></i>\"\n\n" +

		public function findMindbreakerAgain():void {
			clearOutput();
			menu();
			if (player.cor >= 70){
				outputText("You approach the cave where your friend, Kaerb-Dnim, awaits you." +
						" You're finally as lusty and slutty as you should be! Winning the game should be a piece of cake," +
						" yet a faint voice in your head tells you something terrible is about to happen if you enter that cave. You're going to enter, right?");
				addButton(0, "Yes", YesTentacleStage3,0,0,0,"Ignore the silly voice that keep telling you this is a bad idea and proceed.");
				addButton(1, "No", NoIndecisive,0,0,0,"Listen to the voice of reason. Leave while you still can!");
			}
			else{
				outputText("You approach the cave again, the foreboding darkness seeping from the entrance attempts to hold sway over your resolve, trying to break you before you’ve even had a chance to enter." +
						" But its efforts are futile. You’re prepared this time. You returned to complete your endeavor. You're stronger, better, made worthy of note through perseverance." +
						" You’re ready. All you have to do is take the first few steps. You’re...you’re going to take the first few steps, right?");
				addButton(0, "Yes", YesTentacleStage2,0,0,0,"This is a terrible idea... so why does it sound so great?");
				addButton(1, "No", NoIndecisive,0,0,0,"No way.");
			}
		}

		public function YesTentacle():void {
			clearOutput();
			outputText("Inching closer, your mind enveloped in a battle of rationale against greed, the latter of which stands the victor. Edged on by your desires and curiosity, your apprehension quashed, nothing slows your approach. You are the champion, after all! Sent to a world filled with hordes of horny hedonists, degenerates fucking the very land full of corruption, you were tasked with putting an end to such deplorable acts.");
			if (player.cor>=70){
				outputText("\n\nThat is, before you experienced some of those acts. Can’t believe those idiots back home are so scared of what they haven’t tried. They don’t know what they’re missing." +
						"\n\nOh well, more for you.");
			}
			outputText("\n\nYou’ve already witnessed countless things that would surely break any other man or woman. This simple cave will probably be more of the same. Besides, if this is another demonic front you’ve got to ");
			if (player.cor>=50){
				outputText("indulge in what they’re offering. If it’s interesting enough, you might just let them stick around, maybe even take a few of the raving sluts home.");
			}
			else {
				outputText("shut it down, like a proper champion!");
			}
			outputText("Your first movements into the cavern are met with the sounds of the moist earth beneath, squelching beneath the weight of your "+player.feet()+" as you cautiously tread ever deeper. Light from the outside does not penetrate far and quickly fades");
			if(!player.hasDarkVision()) outputText(", leaving you with nothing but your keen senses");
			outputText(", you stride deeper and deeper into the chasm, holding your [weapon] in a firm grip, taut muscles hefting the weapon, poised to strike."+
					"\n\nThe tension in the air nearly chokes you, the cool dampness smothering your form, every caress delivering a diseased touch that leaves fields of goosebumps in their wake. Even the winds of this accursed hovel beg you to turn away." +
					" But their whims matter little, for the mysteries kept from you are what drive you onward, feeding your irrational sense of greed, goading you ever onwards. As if to taunt you, the darkness is humoring itself with your lack of sight, a constant dripping sound follows you wherever you step." +
					" It offers no respite, the constant drip... drip... drip… beginning to drive you mad. You keep moving through the lightless reaches, your footsteps echoing on the damp ground when a sudden velvety sensation grazes your arm, leaving behind a cold, sticky residue." +
					"\n\nThe shock of being abruptly grazed by an unseen rubbery extension prompts immediate action from your tensed muscles and you whip around, [weapon] raised, and facing the darkness. Silence greets you, the void staring back, mocking you. Shaking your head, you start taking a round of deep breaths." +
					"\n\nYou’re too wound up, this damned dark is getting to your head. You just need a moment to steady yourself, just a couple breaths to calm your heart. It’s only a dark cave, there’s nothing to fear. You just need a light source and you’ll be fine." +
					" You reassure yourself, bringing your heart rate under control. With a final deep breath, you prepare to move on, keeping your [weapon] ready just in case." +
					"\n\nOnce again, you force yourself onwards, pushing further into the endless void. Finding yourself at a corner, you press your [pc hand] against the slightly moist granite. Using the rough surface as a guide, you slowly direct yourself around what appears to be a bend." +
					" The wall’s texture grows slimier with each movement, further passings have the granite adopt a strange, spongy quality. A disturbingly… flesh-like quality." +
					"\n\nWhether it be the darkness influencing your mind or your lack of vision being compensated with increased sensitivity, most likely both, you could almost swear you felt the wall... twitch." +
					" Since whatever this is isn’t trying to actively rape you it must be some cave organism. Maybe a closer look is warranted, but with the lack of light and foreboding atmosphere, it would be best saved for another time." +
					" You press on, though find it increasingly difficult to do so as the organism seems to have quickly grown attached to you, its form reacting to your touch by attempting to latch onto your [pc arm]." +
					"\n\nYou try wrenching your [pc arm] away, the creature’s quite adamant about its affection for you. Struggling against the offending substance affords all your attention, the writhing sensation worming its way up your leg going relatively unnoticed." +
					" By the time you finally acknowledge it, the thing has already wrapped itself around your torso, a sickeningly jovial giggling accompanies this menace’s assault, their origin from directly behind you." +
					" Another slimy extension grapples you from behind, restraining your free arm, the maddening giggles mounting as the fiend revels in your struggle." +
					"\n\nYou fight, pulling, kicking, biting, doing all you can to tear away your limbs from the monstrosity.Your struggles are in vain, more slimy tendrils taking hold of your restrained form, wrapping around your mouth, muffling your grunts, latching onto your arms and torso, and forcing you against the wall." +
					" The sickly squelching of the being assailing creeps closer as it presses you against the wall, two of its appendages crawling up your spine, almost teasing your form as their master relishes in your torment. They near your earlobes, softly pressing against the outer curvature, slowly dragging upwards along the helix." +
					" You feel the creature press itself against you, your form now at its mercy as it releases another perturbing round of incessant, vexing laughter. Inching downwards, the tendrils tickle the flesh of your inner ear. Finally, it pushes forwards, penetrating the inner sanctum of your mind as it pushes past your eardrum." +
					" Renewed vigor comes as panic ensues, your body doing everything in its power in a last futile attempt at breaking free. Yet it is all too late as the abomination has found its prize. Your world fades to black." +
					"\n\nNothing but endless darkness greets you as the blackness stretches on for eternity. You’ve only arrived here and yet it feels like you’ve lasted an eternity in this place. The only feeling you’re aware of is being freed from your responsibilities as champion." +
					" Nothing’s tried to ravage you without consent, you needn’t eat nor feel tired. There is nothing but blissful drifting." +
					"\n\nSadly you are not free of all earthly vices, the most prominent being that of feeling. Thankfully this place doesn’t let you suffer at the hands of such a fickle thing like lust. No... it cares for you too much to allow such a thing." +
					" It cloaks you in an assuaging shroud of warmth, instantly brought to satisfaction through the most gratifying sensations. Nothing, absolutely nothing amounted to the pleasure you feel here constantly." +
					" Everything is taken care of, you are always blessed with exquisite ministrations befitting of the God of kings! This place loves you, that thing just wanted to show you what you were missing out on." +
					"\n\nIs this the heaven that so many in Ingnam revered? Did you die at the hands of that thing? Does it really matter? This place is perfection! Whatever your old life was could never compare to this. There’s no use remembering it, let it fade away." +
					" Let the warmth, the sensations akin to a lover’s expert caress take you. That feeling... that euphoria that enthralls the mind...so perfect." +
					"\n\nAs you wander, a question does tug at the edge of your consciousness. Why were you struggling? The thing that apprehended you, slammed you against the wall and toyed with your form...it wasn’t doing that out of some twisted craving for your torment, no." +
					" It just wanted to show you this realm of pure ecstasy. It wanted you to understand what it has to offer." +
					" Imagine if everyone could experience this? Just imagine it. No pain, no fighting, no worries, no stress, nothing. Just bliss." +
					"\n\n..Everyone should experience this." +
					"\n\n\"<i>Woefully inadequate,</i>\" you hear yourself say, not feeling your mouth move at all. That’s right, inadequate. You’re not ready yet. This world is not ready yet." +
					" You’ve only tasted a mere fraction of a fraction of this rapture, this perfection. You aren’t ready yet. But...but how can you get ready?" +
					" Surely there must be something you can do! You don’t want to abandon this place, it’s too serene! Oh! Oh yes, that’s it! Kaerb-Dnim will help you, as she always has! After all, she helped you get here, just like she promised she would!" +
					" You just have to do as she says, like always! This is so simple, you’ll be out of this world and back in no time!" +
					"\n\nYou just need to return after you’ve grown stronger after you’ve gained valuable memories of Mareth. She needs it. She can’t tell you what it is now, you’re not ready but she needs it." +
					" And you’ll do as she says because you want to come back here, you want to enjoy this blissful solitude, you want to enjoy her presence again. You just need to do a few more things for her." +
					" Just a few more things and you’ll be back, you’ll be granted peace. Isn’t that worth suffering a little longer in that other place, that chaotic world? Of course it is." +
					" Because...you want to be free, you want to become one, you want to be granted an eternity of bliss. You want this...yes. You want this." +
					"\n\nYou can feel the warm energies dancing across your flesh, igniting every sensitive area. You relax at the feeling, surrendering yourself to pleasure." +
					" Your first mind-numbing orgasm comes almost instantly, and soon after a second is granted. It’s so good...this is all so good. After each release, you fall deeper and deeper into blissful slumber." +
					" It wants you to sleep, wants you to rest before it sends you away. She wants you to sleep. Go to sleep while it pleasures you, while she comforts you. Come back when you are ready... when you are adequate. She’ll be waiting for you. She loves you." +
					" It loves you. Return to her so she can love you again. Return after you are ready. Return after you are sufficient." +
					"\n\nYou wake sometime later, the soft ground leading towards the mouth of the cave greeting you. How long were you out for? Judging by the small pool of drool on the ground, a good while. It’s a little surprising nothing has come by to take advantage of you." +
					" The inhabitants of this world aren’t known for passing up on a free fuck, conscious or not." +
					"\n\nAs you look towards the cave entrance, a sense of insignificance wells up within you. You’re not ready to enter the cave yet." +
					" Whatever is in there is far beyond your capacity, it would be suicide attempting to go inside. You’re too feeble, too inferior, too inadequate... You just need more time. For now, it’s better if you return to camp." +
					" Find some minotaurs to toss around, get prepared. When you return you’ll be much more suited to venture inside.");
			dynStats("sen", 20, "cor", 5);
			player.sexReward("default", "Vaginal", true, false);
			player.sexReward("default", "Vaginal", true, false);
			player.sexReward("default", "Vaginal", true, false);
			player.sexReward("default", "Vaginal", true, false);
			player.sexReward("default", "Vaginal", true, false);
			doNext(camp.returnToCampUseOneHour);
		}

		public function YesTentacleStage2():void {
			clearOutput();
			outputText("Of course you are! You’ve prepared yourself for this. You’ve had more than enough time to develop your skills, to become greater than what you once were. You’re ready for this." +
					" Whatever is in that cave will be awestruck by you! Alright, enough of the overconfidence. It’ll get you killed if stupid enough to allow it sovereignty over your mind. Nevertheless, it’s time for action." +
					"\n\nMarching through the bleeding breech, you begin traversing the darkness once again. A fleeting thought passes through your brain, \"<i>Why not bring a torch or light a fire?</i>\", but you rebuff the nagging inquiry." +
					" What good would a flame do in this when you are devoured by this insatiable darkness? No, forgo the blinding light. It will serve only to hinder you." +
					"\n\nThe deeper you traverse, the worse the chill becomes. Strangely, a feeling of solace accompanies the frosted breeze, a familiarity that you would cherish only in the arms of a close friend." +
					" Perish the thought, for it only distracts from the task at hand. With [weapon] readied, heart as iron, a will of steel, and a sharp mind you push deeper." +
					"\n\nOnce again the cold granite greets you, the familiar bend your only route of progression. This is where you met that...thing." +
					" The enigma that forced you out of the cave, rebuked your advance and mocked you as it threw you away like trash, crushed you beneath heel like dirt." +
					" It made you understand just how unprepared you were for an expedition like this." +
					" But now you’re better prepared to handle this thing and whatever else you might encounter in this cave." +
					"\n\nYou’re better, smarter, stronger... You are adequate." +
					"\n\nBefore you progress, a quick thought comes to your mind. Pressing your ear against the cold stone, you hold for a moment." +
					" Silence greets your chilled lobes, a silent sigh of relief released to the frigid air. You know it’s there, waiting for you up ahead." +
					" Maybe not in the same place, but that nightmarish abomination is here. It’s waiting. You can feel it." +
					" It wants you, wants to take hold again… wants to pull you down… It will devour any hope, even the barest fleeting light." +
					" And then, when not even a semblance of what was, when the broken deplorable form of what once was a champion of Mareth remains, only then will it relinquish you." +
					"\n\nYou’re not succumbing to such a vile thing again. Pressed against the wall, you slowly advance while pressing your ears against the stone every few steps, listening for any shifting or... squelching." +
					" The natural ambiance of the cave, thankfully, isn’t inhibiting to your sense of sound. Constant drops of water echoing off the rigid stone, the crunch of stone beneath your feet, the ominous moan generated by the winds that seep into the cave." +
					" It’s all trying to get to you, pull your mind away from matters at hand, attempting to distract you with these disturbances." +
					" It won’t work on you, not this time. You just need to keep focused and move forward." +
					"\n\nDelving deeper into the cave has brought about no new adversaries. So far, nothing has decided to impede your path." +
					" Are you fortunate for such a reprieve? When you are free from this place, you may decide. For now, you can only trek deeper into the abyss." +
					" How can it even be possible that this cave, this...place can even manage to become ever more dreadful by the second?" +
					" Like each step is carrying you closer to absolute nothingness, in which everything is rendered mute." +
					"\n\nThe creeping dread that throttles your core and plagues the mind only gets worse with each step." +
					" Your breathing becomes shallow as you attempt to combat the frosted grip of fear that seeks to take you." +
					" Yet no matter your attempts to shake surreal trepidation prove futile. There’s something at play in this place, something sinister." +
					" Reaffirming your goals, pretending that bearing the title of champion holds any meaning here, all that nonsense isn’t going to get you through this!" +
					"\n\nWhatever is in here, whatever is affecting you is going to worm its way in, play with your thoughts, warp your mind. You can’t linger in this accursed hovel." +
					" Find the corrupt beings that have crafted this enigmatic cavern, dispose of them, and make sure nobody else falls victim to this place." +
					"\n\n\"<i>Woefully inadequate</i>\". You hear a voice call out from the infinite void, a lone woman’s voice." +
					" And in this place, where the faintest sounds and smallest steps are enough to evoke a near paralyzing sense of fear, the sound of a voice so familiar to you is enough to petrify you. Frozen in place, blood turning to stone, you frantically search the darkness for the source." +
					" A disappointed sigh comes from deeper within the cavern." +
					"\n\n\"<i>Still so...droll. Even after our last little tryst you still managed to somehow return a boring specimen. Ah, but I suppose that comes with the mundane world you are bound to.</i>\"" +
					"The sultry, honeyed tones of the voice is mesmerizing, the deep undertones reverberating through the cave carried an alluring effect." +
					" The darkness slowly begins to bend and warp, curving and coiling as though it began to follow the pattern. It shifts, twirls and weaves;" +
					" chaotic alterations so seamless in their transitions it produces a hypnotic effect; churning and distorting with unbridled grace." +
					"\n\nA deep, sultry sigh is emitted from behind, a violet hand caresses your cheek soon after. \"<i>Is this really enough to enthrall your mind? A simple weave?</i>\" Soft flesh presses itself against your back, an arm wraps around your chest");
			if (player.biggestTitSize() >= 2) outputText(" laying cross your bosom");
			outputText("." +
					"\n\n\"<i>Woefully inadequate indeed...</i>\", you hear yourself say, not feeling your mouth at all. This is so weird yet so hot." +
					" Kaerb-Dnim laughs and you laugh as well, both of you resume the game where you left it." +
					" Having her tentacle in your head is the best! You could let her fuck your ears all day long and still want to do it the day after." +
					"\n\nSquelch, squelch, squelch is all you hear for a few seconds as her hand slowly caresses your left breast making you moan appreciatively." +
					" You touch her hand and proceed to kiss her passionately as she methodically delivers pleasure to your mind, wet noises echoing all around the cave." +
					"\n\nMore squelches later and you're helping her pale-skinned hand down into your pussy in order to continue playing, as you mindlessly drool in pleasure." +
					" You have to roleplay as a complete slut while she pretends to be your mistress, and aren’t you good at playing the slut?" +
					" Her tentacles groping your boobs feel so good, and the slime they leave make your skin all glossy and wet, too. This is just how you like it." +
					"\n\nA few hours later as you orgasm for the hundredth time, your friend finally lets you rest. The ground is still covered with all the juice your pussy drooled. It was even more messy than the last time." +
					"\n\n\"<i>Come to me again when you are ready and we can continue making you even better.</i>\"" +
					"You leave, still giddy of the action. It only occurs to you once you are out of the cave that you never had a friend named Kaerb-Dnim, let alone saw a thing like her before in Ingnam." +
					" Yet, despite this contradiction, you have the impulse to come and see her again. You feel your mind become more lustful, colorful, and perfect. Just like after each visit.");
			dynStats("sen", 20, "cor", 5);
			player.sexReward("default", "Vaginal", true, false);
			player.sexReward("default", "Vaginal", true, false);
			player.sexReward("default", "Vaginal", true, false);
			player.sexReward("default", "Vaginal", true, false);
			player.sexReward("default", "Vaginal", true, false);
			doNext(camp.returnToCampUseOneHour);
		}

		public function YesTentacleStage3():void {
			outputText("You, yet again, enter the cave and cheerfully rush to meet Kaerb-Dnim, who welcomes you with open arms." +
					"\n\n\"<i>I see you have become as slutty and lusty for me as I wanted, [name]. I think it’s high time I reward your efforts, and give you your well-deserved prize.</i>\"" +
					"\n\nYou cheerfully nod, letting her put her loving tentacle back into your head, drooling at the mere thought of your mind becoming more lewd and obscene. This drives you to the edge, making you cum spontaneously as you feel your mind being probed again. Squelch squelch squelch is all you hear for a few seconds, and you shake your head as lights flash behind your eyelids. You think you are still shaking but you lack feedback from your body. A green song knits loud spaghetti and asks you in reverse when Snowball is." +
					"\n\n\"<i>Woefully inadequate</i>\", you hear yourself say, not feeling your mouth at all. Kaerb-Dnim laughs." +
					" You laugh yet again as she kisses you, her tentacle coiling around your breasts, tweaking your nipples as you fiercely masturbate under her guidance." +
					" Soon Kaerb-Dnim guides you down to the ground and proceeds to grind her lovely purple pussy against your snatch, locking your legs against hers." +
					" The pair of you grind for several minutes, your pussies sliding against each other until Kaerb-Dnim finally cums." +
					"\n\nSomething, not unlike a mass of tentacles, slides between her pussy and yours, and you gleefully let it in, orgasming as it squirms inside you for a minute and heads past your cervix to settle in your womb, depositing something." +
					" She finally breaks away from you, her lovely tentacles retreating back out of your oozing snatch." +
					"\n\n\"<i>We can finally be true sisters, [name], isn’t that wonderful?</i>\"" +
					"You only understand everything a few seconds later as you start shaking uncontrollably in pleasure. Being a true sister to Kaerb-Dnim?" +
					" What a wonderful thing! You’re so happy this is happening to you as you feel something hatch within you." +
					"Your womb aches and tingles pleasurably just as you start changing. It feels so good to be entirely remade from the inside and you cum several times as your skin slowly turns to a pale ghostly shade, not unlike that of Kaerb-Dnim, and begins spreading from your belly. \n" +
					"You moan in delight as your hair falls from your head, and are replaced by purple tentacles of various size, which you use to fuck your own brain right away." +
					" You open your many new eyes located on your tentacles smiling blissfully as the thing below your waist shifts into eight tentacles webbed to each other like a nightdress." +
					" Your chest is left somewhat intact, although you are covered with a webbed exoskeleton, similar to your legs." +
					" From afar, one would think you're wearing a gothic leather dress until they'd notice it's a part of your body." +
					" You moan in delight, groping your own breast at the pleasure of your new, lewd and corrupted body. Kaerb-Dnim closes in on you as you molest yourself." +
					"\n\n\"<i>You enjoy it, don’t you? Don’t you pity those that can’t enjoy such sensations?</i>\"" +
					"You giggle lustfully understanding her request right away. \"<i>Yes sister, I think everyone in Mareth and beyond should live like this.</i>\"" +
					"\n\nA wicked plan starts to form in your mind. You imagine everyone living in an endless orgy of constant mind-shattering pleasure as you create an entire sorority of creatures like you." +
					" The entire world is now playing the game, a game you and sister Kaerb-Dnim truly share now. You and Kaerb-Dnim, now the sorority founders, need new willing sisters, brothers, and minions." +
					" It’s high time you get out and find more willing or unwilling people to join in on your perverted games. Then, once you have achieved greater numbers, you can paint Mareth green and white with fluids." +
					"\n\n<b>You now are a Mindbreaker!</b>");
			player.sexReward("default", "Vaginal", true, false);
			player.sexReward("default", "Vaginal", true, false);
			player.sexReward("default", "Vaginal", true, false);
			player.sexReward("default", "Vaginal", true, false);
			player.sexReward("default", "Vaginal", true, false);
			player.ears.type = Ears.HUMAN;
			player.eyes.type = Eyes.MINDBREAKER;
			player.eyes.colour = randomChoice("yellow", "orange", "light green");
			player.faceType = Face.HUMAN;
			player.tongue.type = Tongue.MINDBREAKER;
			player.arms.type = Arms.MINDBREAKER;
			player.lowerBody = LowerBody.MINDBREAKER;
			player.hairType = Hair.MINDBREAKER
			player.rearBody.type = RearBody.MINDBREAKER;
			if (player.legCount != 8) player.legCount = 8;
			player.wings.type = Wings.NONE;
			if (!player.hasVagina()) player.createVagina();
			player.vaginaType(14);
			player.skin.base.color = randomChoice("pale", "ghostly white");
			player.skinAdj = "slippery";
			player.skinType = Skin.PLAIN;
			player.tone = 0;
			player.thickness = 20;
			player.femininity = 80;
			player.horns.type = Horns.NONE;
			player.antennae.type = Antennae.NONE;
			player.tailType = Tail.NONE;
			player.femininity = 80;
			player.killCocks(player.cocks.length);
			player.balls = 0;
			player.ballSize = 0;
			if (player.breastRows.length >= 2) player.removeBreastRow(player.breastRows.length - 1,player.breastRows.length-1);
			if (player.biggestTitSize() <= 4){
				var sizeIncrement:Number = 5-player.biggestTitSize();
				player.growTits(sizeIncrement, 1, false, 3)
			}
			player.createPerk(PerkLib.Insanity,0,0,0,0);
			//player.createPerk(PerkLib.Psionic Empowerment,0,0,0,0);
			MindBreakerQuest = QUEST_STAGE_ISMB;
			doNext(camp.returnToCampUseOneHour);
		}

		public function FuckNo():void {
			clearOutput();
			MindBreakerQuest = QUEST_STAGE_MBOFF;
			outputText("No. After straining against the more reckless part of your mind, overcoming your greed with rationale, you decide against this endeavor. It’s only a cave you just happened to stumble across- one that oozes ‘stay away’." +
					" There are plenty more caves out there for you to explore, but this one will not be touched, at least not for now and not by you." +
					"\n\nWith your mind made, you turn heel back to camp, never once looking back towards the ominous crevice. Once you’re relatively safe, a reassuring calm settles over you." +
					" You’ve done the right thing in leaving that place behind, you’ve never felt so sure before." +
					"\n\nYou’ve done the smart thing.");
			doNext(camp.returnToCampUseOneHour);
		}

		public function NoIndecisive():void {
			clearOutput();
			outputText("No. N-no, you’re not. You’re not ready, still inadequate, still unprepared. Whatever you did wasn’t enough." +
					" You need to go back, to return and do more. You can’t venture inside like this, you’re practically useless." +
					" You’ll just end up raped or worse: dead. Back to camp, you need to go back." +
					" Return and train more. Come back when you’re actually ready, instead of getting ahead of yourself and thinking you were something of note. Inadequate. Inferior. Worthless." +
					"\n\nTurn back. Grow. Develop. Return.");
			doNext(camp.returnToCampUseOneHour);
		}

		public function StartMBFight():void {
			startCombat(new WoodElvesHuntingParty());
		}
		public function MBFightWin():void {
			clearOutput();
			outputText("This battle is out of your hands. The moment you manage to defeat an elf another jumps in while a battle medic moves from the back to heal the fallen. You merely manage to create an exit amidst the mayhem and escape safe and sound from them. You will need to be wary of trees and blonde girls from now on seeing as this is unlikely to be the last time you run into them.");
			doNext(cleanupAfterCombat);
		}
		public function MBFightLoose():void {
			cleanupAfterCombat();
			//doNext(YouAreAlreadyElfLose);
		}

		public function YouAreAlreadyMBSubmit():void {
			clearOutput();
			outputText("You decide to let the elven lady proceed. The elf leader raises an hand and tentacle-like vines whip around you as the elves encircling you smirk and giggle");
			//YouAreAlreadyElf1();
		}

		public function YouAreAlreadyMBLose():void {
			clearOutput();
			outputText("Bested in combat and unable to continue fighting, the horde of elven ladies encroach upon you. The elf leader raises an arm as tentacle-like vines whip around you while the elves circling you titter");
			//YouAreAlreadyElf1();
		}

	}
}
