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
import classes.internals.SaveableState;

public class Mindbreaker extends BaseContent implements SaveableState{

		public static var MindBreakerQuest:int;
		public static const QUEST_STAGE_MBOFF:int = -1;
		public static const QUEST_STAGE_NOT_STARTED:int = 0;
		public static const QUEST_STAGE_METMB:int = 1;
		public static const QUEST_STAGE_ISMB:int = 2;

		public static var MindBreakerConvert:int;
		public static var MindBreakerConvertGoal:int;
		public static var MindBreakerGoblinConvert:int;
		public static var MindBreakerFetishFemaleConvert:int;
		public static var MindBreakerFetishMaleConvert:int;

		public static var MindBreakerFullConvert:int
		public static var MindBreakerFemaleFullConvert:int;
		public static var MindBreakerMaleFullConvert:int;
		public static var MindBreakerMiniFullConvert:int;

		public static var PlayerEggIsFertile:Boolean;

		public static var MindbreakerPrisoner:Boolean;
		public static var MindbreakerPrisonerCooldown:int;
		public static var MindbreakerEncounterChance:Number;

		public function stateObjectName():String {
			return "Mindbreaker";
		}

		public function resetState():void {
			MindBreakerQuest = QUEST_STAGE_NOT_STARTED;
			MindBreakerConvert = 0;
			MindBreakerGoblinConvert = 0;
			MindBreakerFetishFemaleConvert = 0;
			MindBreakerConvertGoal = 20;
			MindBreakerFetishMaleConvert = 0;
			MindBreakerFullConvert = 0;
			PlayerEggIsFertile = false;
			MindbreakerPrisoner = false;
			MindbreakerPrisonerCooldown = 0;
			MindbreakerEncounterChance = 1;
		}

		public function saveToObject():Object {
			return {
				"stage": MindBreakerQuest,

				"numberOfConvert": MindBreakerConvert,
				"numberOfConvertGoal": MindBreakerConvertGoal,
				"numberOfGoblinConvert": MindBreakerGoblinConvert,
				"numberOfFetishFemaleConvert": MindBreakerFetishFemaleConvert,
				"numberOfFetishMaleConvert": MindBreakerFetishMaleConvert,

				"numberOfFullConvert": MindBreakerFullConvert,
				"numberOfFullFemaleConvert": MindBreakerFemaleFullConvert,
				"numberOfMaleFullConvert": MindBreakerMaleFullConvert,
				"numberOfMiniFullConvert": MindBreakerMiniFullConvert,

				"playerEggIsFertile": PlayerEggIsFertile,
				"mindbreakerPrisoner": MindbreakerPrisoner,
				"MindbreakerEncounterChance": MindbreakerEncounterChance
			};
		}

		public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
			if (o) {
				MindBreakerQuest = o["stage"];

				MindBreakerConvert = o["numberOfConvert"];
				MindBreakerConvertGoal = o["numberOfConvertGoal"];
				MindBreakerGoblinConvert = o["numberOfGoblinConvert"];
				MindBreakerFetishFemaleConvert = o["numberOfFetishFemaleConvert"];
				MindBreakerFetishMaleConvert = o["numberOfFetishMaleConvert"];

				MindBreakerFullConvert = o["numberOfFullConvert"];
				MindBreakerFemaleFullConvert = o["numberOfFullFemaleConvert"];
				MindBreakerMaleFullConvert = o["numberOfMaleFullConvert"];
				MindBreakerMiniFullConvert = o["numberOfMiniFullConvert"];

				PlayerEggIsFertile = o["playerEggIsFertile"];
				MindbreakerPrisoner = o["mindbreakerPrisoner"];
				if ("MindbreakerPrisonerCooldown" in o) {
					// new save, can load
				MindbreakerPrisonerCooldown = o["mindbreakerPrisonerCooldown"];
				} else {
					// old save, still need to set Cooldown  to something
					MindbreakerPrisonerCooldown = 0;
				}
				MindbreakerEncounterChance = valueOr(o["MindbreakerEncounterChance"], 1);
			} else {
				// loading from old save
				resetState();
			}
		}

		public function Mindbreaker(){
			Saves.registerSaveableState(this);
		}

		//[Find Mindbreaker]
		public function findMindbreaker():void {
			clearOutput();
			MindBreakerQuest = QUEST_STAGE_METMB;
			outputText("As you wander the mountainside you venture across a distinct tunnel entrance. Something is wrong, you realise quickly...The light doesn't reach in as far as it should. A sudden sense of foreboding envelops you for a moment, and for a moment you hesitate, holding yourself back from entering the crevice." +
					" A strange, almost alien feeling flows through the crack. Air flows from the cave, sending an odd scent through your nostrils. It smells...Almost like the mud after the rain. Weird. It hasn’t rained in...You realise that it hasn't rained since you arrived on Mareth. Your spine tingles, shivers crawling up your [legs]" +
					"\n\nYou’re kept from marching unto the breach, a phantom grip on your heart is stalling your advance." +
					" Why are you being so apprehensive about this? It’s not like you haven’t faced walking nightmares before. For goodness' sake, this entire world is filled to the brim with rape machines! Mareth is infested with creatures casually strutting around with hips as wide as a cart, or sporting more than enough cocks to plug every hole a human could have!" +
					" If anything, it’s probably just another one of the Demon’s spells or something trying to paralyze you with fear;" +
					" make you too scared to fight so they can have their way with anyone under its effects." +
					" It’s just a matter of steeling your nerves and venturing forth. But still… maybe this time you should listen to your instincts? Is whatever that resides within worth what you could encounter?" +
					"\n\nDo you continue?" +
					"\n\n<b><u>-Warning-\n" +
					" -Content in this cave is not for everyone. It includes mind break, tentacles, parasitism, severe slutification and PERMANENT TRANSFORMATION. Proceed at your own risk.</u></b>\n");
			//[Yes] [No]
			doYesNo(YesTentacle,FuckNo);
		}

		//"\n\n\"<i></i>\"\n\n" +

		public function findMindbreakerAgain():void {
			clearOutput();
			if (player.cor >= 70){
				outputText("You approach the cave where your friend, Kaerb-Dnim, awaits you." +
						" You're finally as lusty as you should be! Winning the game should be a piece of cake," +
						" yet a faint voice in your head tells you something terrible is about to happen if you enter that cave. You're going to enter, right?");
				doYesNo(YesTentacleStage3,NoIndecisive);
			}else{
				outputText("You approach the cave again, the foreboding darkness seeping from the entrance attempts to hold sway over your resolve, trying to break you before you’ve even had a chance to enter." +
						" But its efforts are futile. You’re prepared this time. You returned to complete your endeavor. You're stronger, better, made worthy of note through perseverance." +
						" You’re ready. All you have to do is take the first few steps. You’re...you’re going to take the first few steps, right?");
				doYesNo(YesTentacleStage2,NoIndecisive);
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
			outputText("Your first movements into the cavern are met with the sounds of the moist earth beneath, squelching beneath the weight of your "+player.feet()+" as you cautiously tread ever deeper. Light from the outside quickly fades");
			if(!player.hasDarkVision()) outputText(", leaving you with nothing but your keen senses");
			outputText(", you stride deeper and deeper into the chasm, holding your [weapon] in a firm grip, taut muscles hefting the weapon, poised to strike."+
					"\n\nThe tension in the air nearly chokes you, the cool dampness smothering your form, every caress delivering a diseased touch that leaves fields of goosebumps in their wake. Even the winds of this accursed hovel beg you to turn away." +
					" But their whims matter little, for the mysteries kept from you are what drive you onward, feeding your irrational sense of greed, goading you ever onwards. As if to taunt you, the darkness is humoring itself with your lack of sight, a constant dripping sound following you wherever you step." +
					" It offers no respite, the constant drip... drip... drip… You keep yourself from turning around, trying to see where the moving droplets are coming from...But it's a struggle. You keep moving through the lightless reaches, your footsteps echoing on the damp ground when a sudden velvety sensation grazes your arm, leaving behind a cold, sticky residue." +
					"\n\nThe shock of being abruptly grazed by an unseen rubbery extension prompts immediate action from your tensed muscles and you whip around, [weapon] raised, and facing the darkness. Silence greets you, the void staring back, mocking you. Shaking your head, you start taking a round of deep breaths." +
					"\n\nYou’re too wound up, this damned dark is getting to your head. You just need a moment to steady yourself, just a couple of breaths to calm your heart. It’s only a dark cave, there’s nothing to fear. You just need a light source and you’ll be fine." +
					" You reassure yourself, bringing your heart rate under control. With a final deep breath, you prepare to move on, keeping your [weapon] ready just in case." +
					"\n\nOnce again, you force yourself onwards, pushing further into the endless void. Finding yourself at a corner, you press your hand against the slightly moist granite. Using the rough surface as a guide, you slowly direct yourself around what appears to be a bend." +
					" The wall’s texture grows slimier with each movement, further passings have the granite adopt a strange, spongy quality. A disturbingly… flesh-like quality." +
					"\n\nWhether it be the darkness influencing your mind or your lack of vision being compensated with increased sensitivity, most likely both, you could almost swear you felt the wall... twitch." +
					" Since whatever this is isn’t trying to actively rape you it must be some cave organism. Maybe a closer look is warranted, but with the lack of light and foreboding atmosphere, it would be best saved for another time." +
					" You press on, though find it increasingly difficult to do so as the organism seems to have quickly grown attached to you, its form reacting to your touch by attempting to latch onto your arm." +
					"\n\nYou try wrenching your arm away but the creature’s quite insistent about its affection for you. Struggling against the offending substance affords all your attention, the writhing sensation worming its way up your leg going relatively unnoticed." +
					" By the time you finally acknowledge it, the thing has already wrapped itself around your torso. A sickening giggle echoes off the walls, rapidly shifting in pitch as the creature continues its attack. Focusing on the sound, you realise, too late, that it's right behind you." +
					" Another slimy extension grapples you from behind, restraining your free arm, the maddening giggles mounting as the fiend revels in your struggles." +
					"\n\nYou fight, pulling, kicking, biting, doing all you can to tear away your limbs from the monstrosity. Your struggles are in vain, more slimy tendrils taking hold of your restrained form, wrapping around your mouth, muffling your grunts, latching onto your arms and torso, and forcing you against the wall." +
					" The sickly squelching of the being assailing you creeps closer as it presses you against the wall, two of its appendages crawling up your spine, almost teasing your form as their master relishes in your torment. They near your earlobes, softly pressing against the outer curvature, slowly dragging upwards along the helix." +
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
					"\n\nYou wake some time later, the soft ground leading towards the mouth of the cave greeting you. How long were you out for? Judging by the small pool of drool on the ground, a good while. It’s a little surprising nothing has come by to take advantage of you." +
					" The inhabitants of this world aren’t known for passing up on a free fuck, conscious or not." +
					"\n\nAs you look towards the cave entrance, a sense of insignificance wells up within you. You’re not ready to enter the cave yet." +
					" Whatever is in there is far beyond your capacity, it would be suicide attempting to go inside. You’re too feeble, too inferior, too inadequate... You just need more time. For now, it’s better if you return to camp." +
					" Find some minotaurs to toss around, get prepared. When you return you’ll be much more suited to venture inside.");
			dynStats("sen", 20, "cor", 10);
			player.sexReward("no", "Vaginal");
			player.sexReward("no", "Vaginal");
			player.sexReward("no", "Vaginal");
			player.sexReward("no", "Vaginal");
			player.sexReward("no", "Vaginal");
			MindBreakerQuest = QUEST_STAGE_METMB;
			endEncounter();
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
					" The enigma that forced you out of the cave, rebuked your advances and mocked you as it threw you away like trash, crushed you beneath heel like dirt." +
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
					"\n\n\"<i>Woefully inadequate indeed...</i>\", you hear yourself say, not feeling your mouth at all. This is so weird...But your loins begin to heat up." +
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
			dynStats("sen", 20, "cor", 20);
			player.sexReward("no", "Vaginal");
			player.sexReward("no", "Vaginal");
			player.sexReward("no", "Vaginal");
			player.sexReward("no", "Vaginal");
			player.sexReward("no", "Vaginal");
			endEncounter();
		}

		public function YesTentacleStage3():void {
			clearOutput();
			if (player.hasCock() && !player.hasVagina()){
				outputText("You, yet again, enter the cave and cheerfully rush to meet Kaerb-Dnim, who welcomes you with open arms." +
						"\n\n\"<i>I see you have become as slutty as I wanted, [name]. I think it’s high time I reward your efforts, and give you your well-deserved prize.</i>\"" +
						"You cheerfully nod, letting her put her loving tentacle back into your head, drooling at the mere thought of your mind becoming more lewd and obscene." +
						" This drives you to the edge, making you cum spontaneously as you feel your mind being probed again." +
						" <i>Squelch squelch squelch</i> is all you hear for a few seconds, and you shake your head as lights flash behind your eyelids." +
						" You think you are still shaking but you lack feedback from your body. Two times did the cheese fly to the soul by song, alas she never did lick that limp noodle." +
						"\n\n\"<i>Woefully inadequate</i>\", you hear yourself say, once again, it comes from you, yet it feels like you’re not speaking." +
						" Kaerb-Dnim laughs. You laugh, yet again as she kisses you, her tentacle coiling around your breasts], tweaking your nipples as you fiercely masturbate under her guidance." +
						" Soon Kaerb-Dnim guides you down to the ground and proceeds to grind her lovely purple pussy against your [cock], locking your legs against hers." +
						" She grinds against you, hotdogging your [cock] along the lips of her snatch until she finally cums." +
						"\n\nSomething, not unlike a mass of tentacles, slides between her pussy and your length." +
						" You gleefully allow her to continue, cumming as the many tentacles squirm and stroke your flesh." +
						" You can faintly feel her prod at the tip of your cumslit, slowly inserting something down your urethra." +
						" She finally breaks away from you, her lovely tentacles retreating away from your [cock]." +
						"\n\n\"<i>We can finally be true siblings, [name], isn’t that wonderful?</i>\"" +
						"\n\nYou only understand everything a few seconds later as you start shaking uncontrollably in pleasure." +
						" Being a true brother to Kaerb-Dnim? What a wonderful thing!" +
						" You’re so happy this is happening to you as you feel something hatch within you." +
						"Your balls ache, tingling pleasurably just as you start changing." +
						" It feels so good to be entirely remade from the inside and you cum several times as your skin slowly turns to a pale ghostly shade, not unlike that of Kaerb-Dnim." +
						" The colors drain from your belly, the pale-white spreading across your entire body." +
						"\n\nYou moan in delight as your hair falls from your head, replaced by purple tentacles of various sizes. Web-like frills wrap around your head, spreading between the tentacles in the shape of a crown." +
						" You open your eyes, but are aware of a third one above your normal pair." +
						" You realize your view is obstructed slightly by something in front of your face." +
						" Above your mouth you’ve sprouted several prehensile tentacles, of which you can easily wrap around your prey, giving you the chance to use your newly acquired tentacle-like tongue." +
						" Your cock aches slightly as they are internal and very slimy." +
						" Your balls, despite being concealed with your tapered penis in your genital slit, aches intensely" +
						" your penis constantly leaks a continuous fountain of cum, filling your slit past capacity, forcing the slit open and drooling down your body, making an obscene puddle beneath you." +
						" Your chest is completely flat and with notable athletic tone, although you are covered with a webbed exoskeleton." +
						" From afar, one would think you're wearing a gothic leather cape until they'd notice it's a part of your body." +
						" You moan in delight as your cum leaking cock erupts from its slit at full mast, you reflexively bring your hand down to stroke." +
						" Despite the fountain of cum, your legs shake as your orgasm intensifies, spilling liters of cum onto Kaerb-Dnim and the floor beneath you." +
						" Kaerb-Dnim closes in on you as you molest yourself."+
						"\n\n\"<i>You enjoy it, don’t you? Don’t you pity those that can’t enjoy such sensations?</i>\"" +
						"You moan lustfully understanding her request right away.\"<i>Yes sister, I think everyone in Mareth and beyond should live like this.</i>\"" +
						"\n\nAs an alpha male your job is to inseminate the females so that they can lay eggs and infest new lifeforms, a most important duty." +
						" While any males can properly fertilise a mindbreaker egg the chances of success are rather slim." +
						" Unlike some random minotaur up these mountains, your cum is particularly fertile and suited to this task" +
						" While females typically lead the sorority, you are higher in rank than most of them. This is an honor only you, my chosen male, will get." +
						" How Kaerb-Dnim found this one egg she gave you you got no idea, but she's likely had it for a long while. You assume that she just needed a proper host, an host such as you to lay it." +
						" A wicked plan starts to form in your mind as you begin to plan out how to get new hosts." +
						" You imagine everyone living in an endless orgy of constant mind-shattering pleasure as you create an entire sorority of creatures like you." +
						" The entire world is now playing the game, a game you and sister Kaerb-Dnim truly share now." +
						" You and Kaerb-Dnim, now the sorority founders, need new willing sisters, brothers, and minions." +
						" It’s high time you get out and find more people to join in on your perverted games. Willing or not, it doesn't matter. You know everyone will love it in the end." +
						" Then, once you have achieved greater numbers, you can paint Mareth green and white, a paradise for you and yours.");
				player.sexReward("no", "Vaginal");
				player.sexReward("no", "Vaginal");
				player.sexReward("no", "Vaginal");
				player.sexReward("no", "Vaginal");
				player.sexReward("no", "Vaginal");
				player.ears.type = Ears.HUMAN;
				player.eyes.type = Eyes.MINDBREAKERMALE;
				player.eyes.colour = randomChoice("yellow", "orange", "light green");
				player.hairColor = "purple";
				player.faceType = Face.HUMAN;
				player.tongue.type = Tongue.MINDBREAKERMALE;
				player.arms.type = Arms.MINDBREAKER;
				player.lowerBody = LowerBody.MINDBREAKERMALE;
				player.hairType = Hair.MINDBREAKERMALE;
				player.rearBody.type = RearBody.MINDBREAKER;
				if (player.legCount != 2) player.legCount = 2;
				player.wings.type = Wings.NONE;
				if (player.cocks.length > 1) player.killCocks( player.cocks.length - 1 )
				player.cocks[0].cockType = CockTypesEnum.MINDBREAKER;
				if (player.skin.base.pattern != Skin.PATTERN_NONE) {
					CoC.instance.transformations.SkinPatternNone.applyEffect(false);
				}
				player.skinAdj = "slippery";
				player.skinType = Skin.PLAIN;
				player.skinColor1 = "eldritch purple";
				player.skinColor2 = "eldritch purple";
				player.tone = 100;
				player.thickness = 20;
				player.femininity = 0;
				player.horns.type = Horns.NONE;
				player.antennae.type = Antennae.NONE;
				player.tailType = Tail.NONE;
				player.balls = 2;
				player.ballSize = 4;
				if (player.cocks[0].cockLength < 36){
					player.growCock(0, 2 + rand(8));
					player.thickenCock(0, 1);
				}
				while (player.breastRows.length > 1) player.removeBreastRow(player.breastRows.length - 1, 1);
				while (player.biggestTitSize() >= 1) player.shrinkTits();
			}
			else {
				outputText("You, yet again, enter the cave and cheerfully rush to meet Kaerb-Dnim, who welcomes you with open arms." +
						"\n\n\"<i>I see you have become as slutty as I wanted, [name]. I think it’s high time I reward your efforts, and give you your well-deserved prize.</i>\"" +
						"\n\n You cheerfully nod, letting her put her loving tentacle back into your head, drooling at the mere thought of your mind becoming more lewd and obscene. This drives you to the edge, making you cum spontaneously as you feel your mind being probed again. Squelch squelch squelch is all you hear for a few seconds, and you shake your head as lights flash behind your eyelids. You think you are still shaking but you lack feedback from your body. A green song knits loud spaghetti and asks you in reverse when Snowball is." +
						"\n\n\"<i>Woefully inadequate</i>\", you hear yourself say, not feeling your mouth at all. Kaerb-Dnim laughs." +
						" You laugh yet again as she kisses you, her tentacle coiling around your breasts, tweaking your nipples as you fiercely masturbate under her guidance." +
						" Soon Kaerb-Dnim guides you down to the ground and proceeds to grind her lovely purple pussy against your snatch, locking your legs against hers." +
						" The pair of you grind for several minutes, your pussies sliding against each other until Kaerb-Dnim finally cums." +
						"\n\nSomething, not unlike a mass of tentacles, slides between her pussy and yours, and you gleefully let it in, orgasming as it squirms inside you for a minute and heads past your cervix to settle in your womb, depositing something." +
						" She finally breaks away from you, her lovely tentacles retreating back out of your oozing snatch." +
						"\n\n\"<i>We can finally be true sisters, [name], isn’t that wonderful?</i>\"" +
						"\n\nYou only understand everything a few seconds later as you start shaking uncontrollably in pleasure. Being a true sister to Kaerb-Dnim?" +
						" What a wonderful thing! You gasp in pleasure, womb twitching as you feel something hatch within you." +
						"Your womb aches and tingles pleasurably just as you start changing. It feels so <i>good</i>, and you cum several times as your skin slowly turns to a pale ghostly shade, not unlike that of Kaerb-Dnim, and begins spreading from your belly. \n" +
						"You moan in delight as your hair falls from your head, and are replaced by purple tentacles of various size, which you use to fuck your own brain right away." +
						" You open your many new eyes located on your tentacles smiling blissfully as the thing below your waist shifts into eight tentacles webbed to each other like a nightdress." +
						" Your chest is left somewhat intact, although you are covered with a webbed exoskeleton, similar to your legs." +
						" From afar, one would think you're wearing a gothic leather dress until they'd notice it's a part of your body." +
						" You moan in delight, groping your own breast at the pleasure of your new, lewd and corrupted body. Kaerb-Dnim closes in on you as you molest yourself." +
						"\n\n\"<i>You enjoy it, don’t you? Don’t you pity those that can’t enjoy such sensations?</i>\"" +
						"You giggle, understanding her request right away. You finger yourself as you speak. \"<i>Yes, dear sister, I think everyone in Mareth and beyond should live like this.</i>\"" +
						"\n\nA wicked plan starts to form in your mind. You imagine everyone living in an endless orgy of constant mind-shattering pleasure as you create an entire sorority of creatures like you." +
						" The entire world is now playing the game, a game you and sister Kaerb-Dnim truly share now. You and Kaerb-Dnim, now the sorority founders, need new willing sisters, brothers, and minions." +
						" It’s high time you get out and find more people to join in on your perverted games, willing or unwilling, it doesn't matter...not once they've experienced <i>this</i>. Then, once you have achieved greater numbers, you can paint Mareth green and white." +
						"\n\n<b>You now are a Mindbreaker!</b>");
				player.sexReward("no", "Vaginal");
				player.sexReward("no", "Vaginal");
				player.sexReward("no", "Vaginal");
				player.sexReward("no", "Vaginal");
				player.sexReward("no", "Vaginal");
				player.ears.type = Ears.HUMAN;
				player.eyes.type = Eyes.MINDBREAKER;
				player.eyes.colour = randomChoice("yellow", "orange", "light green");
				player.hairColor = "purple";
				player.faceType = Face.HUMAN;
				player.tongue.type = Tongue.MINDBREAKER;
				player.arms.type = Arms.MINDBREAKER;
				player.lowerBody = LowerBody.MINDBREAKER;
				player.hairType = Hair.MINDBREAKER;
				player.rearBody.type = RearBody.MINDBREAKER;
				if (player.legCount != 8) player.legCount = 8;
				player.wings.type = Wings.NONE;
				if (!player.hasVagina()) player.createVagina();
				player.vaginaType(14);
				var color:String = randomChoice("pale", "ghostly white", "light purple");
				player.skinColor = color;
				player.skinType  = Skin.PLAIN;
				if (player.skin.base.pattern != Skin.PATTERN_NONE) {
					CoC.instance.transformations.SkinPatternNone.applyEffect(false);
				}
				player.skinAdj = "slippery";
				player.tone = 0;
				player.thickness = 20;
				player.femininity = 80;
				player.horns.type = Horns.NONE;
				player.antennae.type = Antennae.NONE;
				player.tailType = Tail.NONE;
				player.killCocks(player.cocks.length);
				player.skinColor1 = "light purple";
				player.skinColor2 = "light purple";
				player.balls = 0;
				player.ballSize = 0;
				if (player.breastRows.length >= 2) player.removeBreastRow(player.breastRows.length - 1,player.breastRows.length-1);
				if (player.biggestTitSize() <= 4){
					var sizeIncrement:Number = 5-player.biggestTitSize();
					player.growTits(sizeIncrement, 1, false, 3)
				}
			}
			if (player.hasPerk(PerkLib.FutaForm)) player.removePerk(PerkLib.FutaForm);
			if (player.hasPerk(PerkLib.BimboBody)) player.removePerk(PerkLib.BimboBody);
			if (player.hasPerk(PerkLib.BroBody)) player.removePerk(PerkLib.BroBody);
			outputText("\n\nEverything makes so much sense now. You were blind to the truth but thanks to the voice of the master in your head your eyes are now open. You have access to knowledge you thought you didn't possess about your reality and the reality between the reality. ");
			outputText("Such knowledge is not for your mind alone though you want to share it with the world. Their blindness and mind untouched by him is a disease and you just happen to have the cure.  (<b>Gained Perk: Insanity!</b>)");
			player.createPerk(PerkLib.Insanity,0,0,0,0);
			player.createPerk(PerkLib.TransformationImmunity2,2,0,0,0);
			if (player.hasPerk(PerkLib.RacialParagon))
				flags[kFLAGS.APEX_SELECTED_RACE] = player.hasVagina()? Races.FMINDBREAKER : Races.MMINDBREAKER;
			player.createPerk(PerkLib.PsionicEmpowerment,0,0,0,0);
			player.removeAllRacialMutation();
			MindBreakerQuest = QUEST_STAGE_ISMB;
			endEncounter();
		}

		public function FuckNo():void {
			clearOutput();
			MindBreakerQuest = QUEST_STAGE_MBOFF;
			outputText("No. After straining against the more reckless part of your mind, overcoming your greed with rationale, you decide against this endeavor. It’s only a cave you just happened to stumble across- one that oozes ‘stay away’." +
					" There are plenty more caves out there for you to explore, but this one will not be touched, at least not for now and not by you." +
					"\n\nWith your mind made, you turn heel back to camp, never once looking back towards the ominous crevice. Once you’re relatively safe, a reassuring calm settles over you." +
					" You’ve done the right thing in leaving that place behind, you’ve never felt so sure before." +
					"\n\nYou’ve done the smart thing.");
			endEncounter();
		}

		public function NoIndecisive():void {
			clearOutput();
			outputText("No. N-no, you’re not. You’re not ready, still inadequate, still unprepared. Whatever you did wasn’t enough." +
					" You need to go back, to return and do more. You can’t venture inside like this, you’re practically useless." +
					" You’ll just end up raped or worse: dead. Back to camp, you need to go back." +
					" Return and train more. Come back when you’re actually ready, instead of getting ahead of yourself and thinking you were something of note. Inadequate. Inferior. Worthless." +
					"\n\nTurn back. Grow. Develop. Return.");
			endEncounter();
		}

		///MINDBREAKER CAVE SECTION///
		public function CaveLayout(back:Boolean = false):void {
			clearOutput();
			if (back) outputText("You are currently on visit in the mindbreakers' lair.\n\n");
			else outputText("You visit big sister Kaerb-Dnim and the sorority of the black tentacle.\n\n");
			if (MindBreakerConvert == 1) outputText("It seems a new friend already made it to the cave and is going through the re-education process.");
			else if(MindBreakerConvert >= 2) outputText(" In a corner you can see that your many new friends are going through the re-education process.");
			if (MindBreakerGoblinConvert == 1) outputText(" You see the goblin addition masturbating with a newly designed tentacle earplug toy in the corner.");
			else if(MindBreakerGoblinConvert >= 2) outputText(" You see a few goblins masturbating with some newly designed tentacle earplug toys in the corner, their combined juices making a lovely puddle on the floor.");
			if (MindBreakerFetishFemaleConvert >= 1) {
				if (MindBreakerFullConvert >= 1) {
					outputText(" A mindbreaker is in the process of altering a cultist's mind into that of a proper follower, the girl riding orgasm after orgasm as her brain and pussy are thoroughly fucked.");
				}
				else{
					if (MindBreakerFetishFemaleConvert >= 2) outputText(" The female cultists you converted sit quietly in a corner of the cave practicing your teachings by themselves. It occurs to you some of them could use a good earfucking. Maybe you could even make proper mindbreakers out of some of them?");
					else outputText(" The female cultist you converted sits quietly in a corner of the cave, practicing your teachings by herself. It occurs to you that she could use a good earfucking. Maybe you could even make a proper mindbreaker out of her?");
				}
			}
			if (MindBreakerFetishMaleConvert >= 1) {
				if (MindBreakerFullConvert >= 1) {
					outputText(" A male cultist on the other side is busy being raped by another mindbreaker, cum leaking constantly from his cock. Both seem to be enjoying themselves..");
				}
				else {
					if (MindBreakerFetishMaleConvert >= 2) outputText(" The male cultists you converted sit quietly in a corner of the cave practicing your teachings by himself. Of course witheout the help of a mindbreaker there is absolutely no way for them to cum so they just end up masturbating pointlessly. Maybe they hope that their next true orgasm blows their mind out?");
					else outputText(" The male cultist you converted sit quietly in a corner of the cave practicing your teachings by himself. Of course witheout the help of a mindbreaker there is absolutely no way for him to cum so they just end up masturbating pointlessly. You suspect that his next true orgasm will literally blow his mind out.");
				}
			}
			outputText(" Truthfully, just being here turns you on so much you can’t help but to fuck your own brain every now and then, although only ever to sharpen your own well-honed lasciviousness.  ");
			if (back) outputText("Kaerb Dnim isn't too far in case you want to ask something of her.");
			else {
				outputText("Everyone at home seems to be busy but, nonetheless Kaerb-Dnim welcomes you." +
					"\n\n\"<i>Hello sister [name], how is your quest for converts going? Did you come looking for some cerebral relief?");
				if (MindBreakerConvert >= 1) outputText(" As you can see, your followers have been awaiting your return eagerly.");
				outputText("</i>\"");
			}
			menu();
			addButton(0, "Talk", TalkAboutMB);
			CaveLayout2();
		}

		public function CaveLayout2():void {
			//if (player.hairType != Hair.MINDBREAKER) addButton(1, "Fix Me", Regaintentacles);
			addButton(1, "Sister Sex", SexCaerbDnim).hint("Get your sister to fuck your brain out.");
			addButton(2, "Use Gob", GoblinTentacle).hint("Play big " + player.mf("brother", "sister") + " with your smaller female follower.");
			if (MindBreakerGoblinConvert < 1) addButtonDisabled(2,"Use gob","You need at least one goblin follower to do this.");
			//addButton(3, "Use gal", FuckGirl).hint("Improve the mind of one of the girl and enjoy yourself along the way.");
			//if (MindBreakerFetishFemaleConvert < 1) addButtonDisabled(3,"Use gal","You need at least one female follower to do this.");
			addButton(4, "Use boy", FuckBoy).hint("Reward one of the boys with his long awaited climax. He'll cum a river, if his swollen balls are any indication");
			if (MindBreakerFetishMaleConvert < 1) addButtonDisabled(4,"Use boy","You need at least one male follower to do this.");
			if ((MindBreakerGoblinConvert >= 1 || MindBreakerFetishFemaleConvert >= 1) && (PlayerEggIsFertile || player.hasCock()))addButton(5, "Convert", CreateMB).hint("Make one of your female pets into a new Mindbreaker.");
			else addButtonDisabled(5,"Convert","You need at least one follower in order to get create a new mindbreaker. Furthermore you need your parasitic eggs to be properly fertilised by a male follower's cum...or preferably, that of a male mindbreaker.");
			//addButton(6, "Puppet sex", PuppetMaster).hint("Mind control two of your favorite pets into fucking one another and enjoy it.");
			//if (MindBreakerFetishFemaleConvert == 0 || MindBreakerFetishMaleConvert == 0) addButtonDisabled(6,"Puppet sex","You need at least one female follower and one male fellower of normal size to do this.");
			//addButton(7, "Orgy", FuckEveryFellower).hint("Just fuck all of your followers at the same time, preferably one of each type.");
			//if (MindBreakerGoblinConvert >= 1 && MindBreakerFetishFemaleConvert >= 1 && MindBreakerFetishMaleConvert >= 1) addButtonDisabled(7,"Orgy","You need at least a goblin, a man and a woman in order to get an orgy going on.");
			if (MindBreakerConvert >=10) addButton(8, "Prisoner", BreakAPrisonner).hint("It appears your followers brought in a new toy for you to break how kind. Time to fix the mind of this defiant new plaything.");
			else if (MindBreakerConvert >= 10 && !MindbreakerPrisoner) addButtonDisabled(8,"Prisoner").hint("There is no prisoners in the cave for you to play with at the time.");
			addButton(10, "More?", totalSubservience)
				.hint("Ask if you can do even more for the Mindbreakers.");
			addButton(14, "Leave", explorer.done);
		}

		public function TalkAboutMB():void {
			clearOutput();
			outputText("You are curious about the mindbreakers of Mareth, where do they originate from?" +
					"\n\n\"<i>Truth be told, we were here way before the demons." +
					" Creatures modified from the indigenous sentient humanoids of this world to serve a master from another dimension, living deep in Mareth's darkest reaches." +
					" We have a body similar to the sea witches and they serve the same god as we do but, ultimately, our creator gave us all but one role, to infest and conquer in his name." +
					" His name cannot be pronounced in any human tongue, and the mere utterance will drive mad the one hearing it. You, however, should know him as The Deep One." +
					" The gods...They despised Him and his creations. They have waged war with us for several millennia. Their most recent crusade almost caused us to go extinct, but the demons gave us a reprieve by slaying most of them." +
					" I was the last of my kind until you came along. We will spread in the world’s many hidden locations and someday emerge again. This time around, Mareth will be ours.</i>\"" +
					"\n\nYou can only but agree with her sentiment. It's only a matter of time until you convert the world to this perfect way of thinking.");
			menu();
			CaveLayout2();
		}

		public function SexCaerbDnim():void {
			clearOutput();
			outputText("Now that she mentions it, yes, but the slaves are not what you're interested in right now. Kaerb-Dnim blushes at your illusion. You laugh before closing in on her, initiating with a sloppy kiss as you drive your tentacle-like tongue in her mouth. You can feel her tongue moving in, going so far down your throat however, you won’t gag from this.\n\n");
			sceneHunter.passCheckOnce();
			sceneHunter.selectGender(dickF, vagF);

			function dickF():void {
				outputText("You move your tentacles into her ears as she guides hers to yours as well. The connection is orgasmic as you can hear your thoughts collide with each other. You continue caressing your thoughts, toying with her brain as you intimately fuck her cranium as she returns the favor. Your erection slowly rises out of its slit, causing your slimy cum to spill everywhere as her nether-tentacles guide your prehensile erection into her. You eagerly thrust your hips against her, driving more of your tapered length into her. Kaerb-Dnim tightens her grip on you, coaxing more of your cum-gushing rod into her. Your breaths quicken as your mind races. She can feel your climax heightening as she forcefully grips onto you with tightening muscles, milking you harder. You moan in unison with her as you expel more slimy cum into her before your erection slowly deflates.");
				player.sexReward("vaginalFluids", "Dick");
				sharedEnd();
			}
			function vagF():void {
				outputText("You move your tentacles into her ears as she guides hers to yours as well. The connection is orgasmic as you can hear your thoughts collide with each other. You continue caressing your thoughts, toying with her brain as you intimately fuck her cranium as she returns the favor. Your vaginal walls open to the tentacles coming from deep down in your womb as you proceed to fuck her snatch with your tentacled pussy, making the other mindflayer coo in delight, as your wet vaginal tentacles tie together into a perfectly shaped penis. You fuck Kaerb-Dnim’s delicious pussy for several minutes, slimy green juice drooling from your snatches. Eventually, Kaerb-Dnim’s pussy tentacles react and tie with your own, connecting your pussies together. Your eyes roll back and you moan in pleasure as both of you start to slide along the massive two-sided form that has become the mass of your vaginal tentacles. Like on a double dildo, both of you slide against the shape, squirting green slimes as your pussies connect, then part ways. Eventually, you break from Kaerb-Dnim, still overloaded with the sensations from a moment ago, a thick strand of green fluid linking your pussies for an instant.");
				player.sexReward("vaginalFluids", "Vaginal");
				sharedEnd();
			}
			function sharedEnd():void {
				if(player.cor < 70 || player.lib < 100){
					outputText("\n\n\"<i>I took the liberty of fixing your mind slightly. There were a few unnecessary inhibitions I thought you didn't need.</i>\"" +
						"\n\nYou indeed feel even better than before, and you thank your sister for her help as you head back to camp.");
					dynStats("cor", 10);
					dynStats("lib", 10);
				} else outputText("The two of you slowly disentangle from each other after briefly relishing the afterglow together.");
				outputText("\n\nHighly satisfied after your lovemaking, you head back to camp.");
				endEncounter();
			}
		}

		public function GoblinTentacle():void {
			clearOutput();

			outputText("You decide to go check on ");
			if (MindBreakerGoblinConvert == 1) outputText("your favorite goblin slave");
			else outputText("one of your favorite of many goblin slaves");
			outputText("and find the girl turned into quite the interesting plaything since she met Kaerb-Dnim." +
					" The goblin looks at you with a pouting expression, more fitting on a spoiled child than a mature woman." +
					" It’s not just her attitude as she wears what could only be described as pink clothes fit for a kid." +
					"\n\n\"<i>Big " + player.mf("brother", "sister") + " [name] finally came home! I’ve been so lonely.</i>\"" +
					"\n\nYou assure the goblin that you will take care of her, as you lift her and insert your tentacles into her ears, leaving the goblin with a debased expression as you squirm inside and move one of your hands under her skirt." +
					" Without surprise, the goblin wears no panties under her clothes and your finger gains quick access to her pussy." +
					"\n\n\"<i>Yay! Big " + player.mf("bro", "sis") + ", make me all messy and dirty.</i>\"\n\n");
			sceneHunter.passCheckOnce();
			sceneHunter.selectGender(dickF, vagF);

			function dickF():void {
				outputText("You smile eagerly as your prehensile erection slides out of its slit, causing a messy pool of cum to spill onto the goblin in your grasp. You gently set her down as you slowly tease her labia with the tip of your cum-gushing erection.\n"
					+ "\n"
					+ "You lean in closer, “<i>Are you ready, little one?</i>”\n"
					+ "\n"
					+ "The goblin nods energetically, “<i>Yes!</i>”\n"
					+ "\n"
					+ "You lower yourself onto her before you penetrate past her lips, immediately causing the goblin to clench tightly around you as her womb is filled by the sheer volume of cum you're drooling into her. You proceed to drive your girth into her, slowly working at her insides as you gently caress her face with your tentacles.\n"
					+ "\n"
					+ "The goblin coos eagerly as you see her world dissolve into an orgasmic high from within her eyes. You can hardly notice her girlcum with all the green, slimy cum you're pouring into her.\n"
					+ "\n"
					+ "Each thrust causes her to moan lewdly as her overstimulated pussy is unable to hold back any further. She completely shuts down as she faints from your efforts. Satisfied, you leave her to rest before returning to your camp.\n");
				player.sexReward("vaginalFluids", "Dick");
				endEncounter();
			}

			function vagF():void {
				outputText("You smile warmly as you finger the cute goblin, making her moan in appreciation, but the best is yet to come. You drop her back to the ground as you go get a minotaur sized U shaped twin dildo out of a nearby toy chest, and position it under you both, moving yourself over the back flare spot as you lift the goblin above the frontal one.\n"
					+ "\n"
					+ "You whisper to her “<i>Are you ready, little one?</i>”\n"
					+ "\n"
					+ "The goblin nods energetically “<i>Yes!</i>”\n"
					+ "\n"
					+ "You squat on the twin dildo, moaning in delight as the toy impales both of you. The goblin's stomach is bulging from the sheer size of the toy, but she doesn't seem to mind as you move up and down its length, coating it in green slime while your ‘little sister’ is being fucked, both in her ear holes and her pussy. You climax several times as the goblin stomach deforms to the dildo's shape, and her mouth drools from the sheer intensity of the fuck. Up, down, up, down, the feeling of the huge dildo in your cunny is just so perfect as you keep sliding on the toy with little regard for her overstimulated pussy.\n"
					+ "\n"
					+ "After a few minutes the goblin faints, still impaled on the toy. You unplug her and a massive flood of pussy juice drenches the ground. Utterly satisfied, you leave her to rest and head back to camp.\n");
				player.sexReward("vaginalFluids", "Vaginal");
				endEncounter();
			}
		}

		public function FuckBoy():void {
			clearOutput();
			outputText("You check on your most recent male acquisition, keen on your promise." +
					" You find the man bucking against a wall in a desperate attempt to cum, but unable to find satisfaction." +
					" He can only moan in disappointment. You approach him, smiling in arousal.");
			if (player.hasVagina()) outputText("\n\n\"<i>Please big sister [name], I beg of you to let me cum. Relieve me of my anguish.</i>\"");
			if (player.hasCock()) outputText("\n\n\"<i>Please big brother [name], I beg of you to let me cum. Relieve me of my anguish.</i>\"");
			outputText("\n\nHis balls have swelled to absurd size, easily two feet large from the use of transformatives and the accumulation of cum waiting to be expelled as he fiercely masturbates to no avail." +
					" Without your brain signal, he is unable to find any release.");
			if (MindBreakerFullConvert >= 2) outputText("\n\nYou move him toward a waiting group of mind breakers");
			else outputText("\n\nYou move him toward a empty wall");
			outputText(" as you slowly jerk him, making him groan in a mix of pain and pleasure, as his pillow-sized balls churn." +
					" Finally, you insert your tentacle in his head and remove the mental block, granting him his long-awaited release." +
					" His cock bursts into a fountain, as his body spasms from the mind-shattering orgasm that races through him." +
					" The sheer volume and strength of the blast paint the walls");
			if (MindBreakerFullConvert >= 2) outputText(" and the group of mindbreakers");
			outputText(" white with sperm as his eyes roll back." +
					" You lick your painted finger, savoring the taste of his cum as he continues erupting for an entire minute, turning part of the floor of the cave into a pool with the torrent of his cum.");
			sceneHunter.passCheckOnce();
			sceneHunter.selectGender(dickF, vagF);

			function vagF():void {
				outputText("\n\nHe falls to the ground, barely conscious, his cock still spurting like a fountain." +
						" You lick your lips and proceed to straddle him, inserting his still erupting cock into your pussy to savor the jets of cum inside of you, making you orgasm from the sheer strength of the cum flooding your vaginal walls and flowing into your womb, fertilizing your eggs." +
						" You cum once, your greenish fluids splattering on the ground along with his cum then switch,");
				if (MindBreakerFullConvert >= 2) outputText(" letting another mindflayer have her turn");
				else outputText(" letting Kaerb Dnim have her turn");
				if (MindBreakerFetishFemaleConvert >= 1) outputText(", as well as any possible female slave in need");
				outputText("."+
						" You each take turns straddling the man to get a proper orgasm and fertilization then repeat it." +
						" Gods above, he cums so much it’s surprising you aren’t knee-deep in fluids right now.");
				player.sexReward("cum", "Vaginal");
				sharedEnd();
			}

			function dickF():void {
				outputText("\n\nHe falls to the ground, barely conscious, his cock still spurting like a fountain." +
						" You lick your lips as your prehensile erection slides out of its slit with a gush of pooled cum." +
						" You dig your tapered length into the man's urethra, relishing in the warm, gooey feeling of his seed." +
						" Yet, you know this isn't all for you to enjoy." +
						" You pull back, allowing");
				if (MindBreakerFullConvert >= 2) outputText("\n\nother mindbreakers to have their turn,");
				else outputText("\n\nKaerb Dnim to have her turn,");
				outputText(" only afterward you may consider bringing him to any needy slaves.");
				if (MindBreakerFullConvert >= 2) outputText(" Several eager mindflayers take turn");
				else outputText(" Kaerb Dnim takes her time");
				outputText(" trying to hold in the impossibly massive amounts of cum he has to give, it's a shame he's not quite to the point you are at yet... but that's only temporary.");
				player.sexReward("cum", "Dick");
				sharedEnd();
			}
			function sharedEnd():void {
				outputText("\n\nHighly satisfied, you head back to camp.");
				PlayerEggIsFertile = true;
				endEncounter();
			}
		}

		public function CreateMB():void {
			clearOutput();
			PlayerEggIsFertile = false;
			if (MindBreakerFetishMaleConvert == 0) convertMale();
			else if (MindBreakerFetishFemaleConvert == 0) convertFemale();
			else {
				menu();
				addButton(0, "ConvertMale", convertMale);
				addButton(1, "ConvertFem", convertFemale);
			}
			//this line is if I add a convert scene for goblin one day
			//if (MindBreakerGoblinConvert == 1 && MindBreakerFetishMaleConvert == 0 && MindBreakerFetishFemaleConvert == 0) Choice = 2;
			function convertFemale():void { //Female Scene
				outputText("You visit ");
				if (MindBreakerFetishFemaleConvert == 1) outputText("your female slave.");
				else outputText("one of the many female slaves in the lair.");
				MindBreakerFetishFemaleConvert--;
				MindBreakerFemaleFullConvert++;
				MindBreakerFullConvert++;
				sceneHunter.passCheckOnce();
				sceneHunter.selectGender(dickF, vagF);

				function vagF():void {
					outputText("She has been an excellent slut and it’s high time to reward her slavering pussy and complete submissiveness properly." +
							"\n\n\"<i>Big sis [name], I have become a perfect slut as you asked. I raped, and let myself be raped, by countless men and women to prove my loyalty. Please shower me with your love and tentacles.</i>\"" +
							"\n\nYou tell her that she has done well. She is finally ready to transcend and become perfect." +
							" Your pussy moistens, a stream of  slime slides down your legs in anticipation of filling this woman, infesting her with one of your young." +
							" She practically throws herself into your arms as you fondly remember your transformation." +
							" You fill her head with your tentacles, taking your time to toy with her mind until she no longer moans and orgasms from being brain fucked, her body too overloaded and rewritten to read her brain waves." +
							" You can feel the intensity of her lust through your connection with her mind." +
							" Every single climax she has are yours, coaxing you to continue with her as her eyes roll with delight." +
							"\n\nThe girl has proven herself. With her body and mind ready she is deserving of joining the sect." +
							" You shove her down bringing your groin to hers before gently rubbing your lips against her, starting with some gentle scissoring." +
							" Tentacles emerge from your pussy as you insert yourself in her, causing her to scream in delight." +
							" You enter her vagina and brush her inner walls, making her go mad with pleasure as you squirm your many vaginal tentacles inside her." +
							"\n\nShe squirms and clenches against you. Pressure builds up in your loins as you feel your orgasm coming and you moan in primal satisfaction as you reach climax, your green girl goop flowing onto her as you deposit a single fertilized egg in her womb." +
							"\n\nYou kiss her as your parasitic egg hatches and fuses with her body and mind, creating a new mindbreaker." +
							" You watch with glee as your newborn sister progressively changes into a creature of lust, just like you." +
							" You watch in delight as the transformation is quick in action. Her hair falls out, being replaced by tentacles, each tendril sprouts several eyes." +
							" You admire her face getting paler until every inch of her skin is a ghostly pale hue. Her legs close together, black webbing sprouts from her hips until her legs are nothing but a fleshy skirt-like membrane." +
							" Her nether lips leak greenish girlcum as the large eye on her forehead opens, staring at you with intensity." +
							" The transformation is complete, she is one with you, a perfect specimen." +
							"\n\n\"<i>Thank you, big sister. for showing me enlightenment. I know what I must do now. Seek, share, and spread!</i>\" She giggles as she heads to a corner to play with her other brethren." +
							"\n\nSatisfied with the result, you head back to camp still smiling.");
					player.sexReward("vaginalFluids","Vaginal");
					endEncounter();
				}

				function dickF():void {
					outputText("She has been an excellent slut and it’s high time to reward her slavering pussy and complete submissiveness properly." +
							"\n\n\"<i>Big brother [name], I have become a perfect slut as you asked. I raped, and let myself be raped, by countless men and women to prove my loyalty. Please shower me with your love and tentacles.</i>\"" +
							"You tell her that she has done well. She is finally ready to transcend and become perfect." +
							" Your [cock] stiffens, spilling green cum all over your legs as it sprouts from your genital slit, the thought of infesting her with your young makes you leak even more cum." +
							" She practically throws herself into your arms as you fondly remember your transformation." +
							"\n\nYou bring your head closer, wrapping around her cranium with your face tentacles, toying with her mind until she no longer moans and orgasms from being brain fucked, her body too overloaded and rewritten to read her brain waves." +
							" You can feel the intensity of her lust through your connection with her mind." +
							" Every single climax she has are yours, coaxing you to continue with her as her eyes roll with delight." +
							"\n\nThe girl has proven herself. With her body and mind ready she is deserving of joining the sect." +
							" You shove her down, bringing your weight onto her as you align your cum leaking cock with her lips, she squeals in delight as your warm cum quickly fills up her womb." +
							" You slowly press yourself deeper, starting with gentle thrusts." +
							" There’s so much cum it splashes out with each thrust you give her." +
							"\n\nShe desperately wraps her legs around your strong waist, desperate for more of your seed." +
							" You squirm your cock down her walls, getting as deep as you can go, the feeling of her pleasure coaxes you to give her more, the two of you reveling in shared pleasure." +
							" You allow your face tentacles to tenderly stroke her face, the pleasure she gets from your touch is just as intense on you as well." +
							" She clenches tighter on your length, mixing your copious amounts of cum with hers." +
							"\n\nYour erection twitches as you feel your orgasm coming as well." +
							" You moan in primal satisfaction as you drive your cock deeper, going past her cervix." +
							" You give her a sloppy kiss with your many mouth tentacles as your parasitic egg worms its way down to her womb, hatching and fusing with her body and mind, creating a new mindbreaker." +
							" You watch in delight as the transformation is quick in action." +
							" Her hair falls out, being replaced by tentacles, each tendril sprouts several eyes." +
							" You admire her face getting paler until every inch of her skin is a ghostly pale hue." +
							" Her legs close together, black webbing sprouts from her hips until her legs are nothing but a fleshy skirt-like membrane." +
							" Her nether lips leak greenish girlcum as the large eye on her forehead opens, staring at you with intensity." +
							" The transformation is complete, she is one with you, a perfect specimen." +
							"\n\n\"<i>Thank you, big brother, for showing me enlightenment. I know what I must do now. Seek, share, and spread!</i>\"She giggles as she heads to a corner to play with her other brethren." +
							"Satisfied, you head back to camp still smiling.");
					player.sexReward("vaginalFluids","Dick");
					endEncounter();
				}
			}
			function convertMale():void { //Male Scene
				outputText("You visit ");
				if (MindBreakerFetishFemaleConvert == 1) outputText("your male slave.");
				else outputText("one of the many male slaves in the lair.");
				MindBreakerFetishMaleConvert--;
				MindBreakerFullConvert++;
				MindBreakerMaleFullConvert++;
				sceneHunter.passCheckOnce();
				sceneHunter.selectGender(dickF, vagF);
				function vagF():void {
					outputText("He has been an excellent slut and it’s high time to reward his throbbing cock and complete submissiveness properly. " +
							"\n\n\"<i>Big sis [name], I have become a perfect slut as you asked. I raped, and let myself be raped, by countless men and women to prove my loyalty. Please shower me with your love and tentacles.</i>\"" +
							"You tell him that he has done well. He is finally ready to transcend and become perfect." +
							" Your pussy moistens with green slime in anticipation of riding this man, infesting him with one of your young." +
							" He practically throws herself into your arms as you fondly remember your transformation." +
							" You fill his head with your tentacles, taking your time toying with his mind until he no longer moans and orgasms from being brain fucked, his body too overloaded and rewritten to read his brain waves." +
							" You can feel the intensity of his lust through your connection with his mind." +
							" Every single climax he has are yours, coaxing you to continue with him as his eyes roll with delight." +
							"\n\nThe boy has proven himself. With his body and mind ready, he is deserving of joining the sect." +
							" You shove him down, before straddling him, hovering just above his erection, slowly gyrating your lips along the tip of his cock, tentacles emerging from your pussy as you poke for his urethra," +
							" trying to enter into him, making him scream in delight. Once you have inserted yourself into his urethra, you bring your hips down, riding him at a slow pace." +
							" You pull him in deeper, making him go mad with pleasure as you squeeze against his cock." +
							" Pressure builds up within your loins as you feel your orgasm coming. You moan in primal satisfaction as you shower him with green girl cum and deposit a single fertilized egg in his dick, it quickly flows to his balls." +
							" Your orgasm triggers a determined thrust from hum as he fills you with more of his cum." +
							" You know you need not worry about his seed, as yours is far stronger." +
							"\n\nYou kiss him as your parasitic egg hatches and fuses with his body and mind, creating a new mindbreaker." +
							" You watch in delight as the transformation is quick in action. His hair falls out, being replaced by a crown-like webbing and thick tendrils that drape down to his pectorals." +
							" You admire his face getting paler until every inch of her skin is a ghostly pale hue." +
							" Above his mouth several tentacles slowly emerge, prehensile and ready to cling onto prey." +
							" His body morphs slightly, taller, fit, and ready to support the needs of the sect and subdue opponents physically if necessary." +
							" His cock slips back into a slit, you notice that he’s already leaking copious amounts of cum, quickly spilling out of the genital slit." +
							" His erection slides out of his slit, pooling cum before you as the large eye on his forehead opens, staring at you with intensity." +
							" The transformation is complete, he is one with you, a perfect specimen." +
							"\n\n\"<i>Thank you, big sister, for showing me enlightenment. I know what I must do now. Seek, share, and spread!</i>\"He chuckles as she heads to a corner to play with his other brethren." +
							"\n\nSatisfied, you head back to camp still smiling.");
					player.sexReward("cum","Vaginal");
					endEncounter();
				}
				function dickF():void {
					outputText("He has been an excellent slut and it’s high time to reward his throbbing cock and complete submissiveness properly. " +
							"\n\n\"<i>\"Big brother, [name], I have become a perfect slut as you asked. I raped, and let myself be raped, by countless men and women to prove my loyalty. Please shower me with your love and tentacles.</i>\"" +
							"You tell him that he has done well. He is finally ready to transcend and become perfect." +
							" Your [cock] stiffens, spilling green cum all over your legs as it sprouts from your genital slit, the thought of infesting him with your young makes you leak even more cum." +
							" He practically throws himself into your arms as you fondly remember your transformation." +
							"\n\nYou bring your head closer, wrapping around his cranium with your face tentacles, toying with his mind until he no longer moans and orgasms from being brain fucked, his body too overloaded and rewritten to read his brain waves." +
							" You can feel the intensity of his lust through your connection with his mind." +
							" Every single climax he has are yours, coaxing you to continue with him as his eyes roll with delight." +
							"\n\nThe boy has proven herself. With his body and mind ready he is deserving of joining the sect. You shove him down before straddling him as you bring your cum leaking cock to his erection, allowing yourself to frot against him." +
							" He moans lewdly, reveling in the warm feeling of your cum spilling all over him. You smirk softly, wrapping your tapered penis around his, masturbating him with your dextrous length, leaving a stream of your slimy cum over his length." +
							"\n\nHe thrusts his hips against you, eager for more. You can feel his erection throb with intensity, desperate for more." +
							" You continue wrigning around him, the shared pleasure the two of you experience heightens the moment together." +
							" It’s not long until he cums, the feeling of his orgasm echoes through you, the two of you sharing the intensity of the moment." +
							"\n\nYour erection twitches as you feel your orgasm coming as well." +
							" You moan in primal satisfaction as you bring the tip of your dick to his, digging your length down his urethra, forcing your cum into him." +
							" You can feel him quiver with delight as his falls fill with your slimy cum. You give him a sloppy kiss with your face tentacles as your parasitic egg hatches and fuses with his body and mind, creating a new mindbreaker." +
							" You watch in delight as the transformation is quick in action. His hair falls out, being replaced by a crown-like webbing and thick tendrils that drape down to his pectorals. You admire his face getting paler until every inch of her skin is a ghostly pale hue." +
							" Above his mouth several tentacles slowly emerge, prehensile and ready to cling onto prey. His body morphs slightly, taller, fit, and ready to support the needs of the sect and subdue opponents physically if necessary." +
							" His cock slips back into a slit, you notice that he’s already leaking copious amounts of cum, quickly spilling out of the genital slit. His erection slides out of his slit, pooling cum before you as the large eye on his forehead opens, staring at you with intensity." +
							" The transformation is complete, he is one with you, a perfect specimen." +
							"\n\n\"<i>Thank you, big brother, for showing me enlightenment. I know what I must do now. Seek, share, and spread!</i>\"He chuckles as she heads to a corner to play with his other brethren." +
							"\n\nSatisfied, you head back to camp still smiling.");
					player.sexReward("no", "Dick");
					endEncounter();
				}
			}
			/*
			if (Choice == 2){ //Goblin Scene
				if (player.hasVagina()){
					outputText("");
				}
				else if (player.hasCock()){
					outputText("");
				}
				MindBreakerGoblinConvert --;
				MindBreakerMiniFullConvert ++;
				MindBreakerFullConvert ++;
			}
			*/
		}

		public function BreakAPrisonner():void {
			clearOutput();
			var race:String = randomChoice("Cat Morph","Fox Morph","Ferret Morph","Dog Morph","Mouse Morph","Raccoon Morph","Lizan")
			outputText("A scene grabs your attention at the back of the lair. It seems your many followers managed to capture an outsider. It’s a "+race+"" +
					" who somehow managed to infiltrate the lair and obviously a female at that. You grin as a perverse idea crosses your mind." +
					" You approach the prisoner and ask your followers if they have some hummus available to which one of them is quick to reply." +
					"\n\n\"<i>I won’t ever talk, fiends, you're wasting your time torturing me!</i>\"" +
					"\n\nOh, but you don’t need her to say anything. No... what you're interested in right now is her sexy body covered in fur… time to shave that!" +
					" You insert your tentacle in the prisoner’s ears, forcing the trigger to open her mouth wide." +
					" Her struggle is cut short by your ministrations. You forcefully shove the first chunk of hummus down her throat, ordering her to eat and swallow." +
					"\n\nShe quickly loses that animal face and fur of hers. These animals ears, paws, and this tail look cute and all but these just won’t do here in the lair." +
					" You keep altering her perception as you keep feeding her more and more hummus until your victim is looking completely horrified at her now fully human body." +
					"\n\n\"<i>You, big sister! W..what have you done to my now lovely human body?! I love you!</i>\"" +
					" She suddenly closes her mouth, terrified at what she just said, as her own mind is betraying her, you sadistically whisper to her ears that you are just getting started." +
					"\n\nGreen flashes run behind the woman’s eyes as you break down every single memory making her who she is and replace them with lewd visions of your own design, erasing her entire life within minutes." +
					" She struggles for a moment against the brainwashing, breaking your connection with a few precious memories once or twice...but as soon as you start adding the new memories her expression turns into that lovely, perverted, lascivious smile you have in all of your followers." +
					" You cum green goo as the last of her memory is fully altered filling her mind with wild depraved fantasies featuring you and the sisterhood.");
			MindBreakerFetishFemaleConvert ++;
			MindBreakerConvert ++;
			if (MindBreakerConvert == MindBreakerConvertGoal) MindbreakerBrainEvolution(false);
				outputText("\n\nWith her mind now fully fixed to your liking your newest acolyte voices up her need. \n\n\"<i>Big ");
				if (player.hasCock()) outputText("brother ");
				if (player.hasVagina()) outputText("sister ");
				outputText("[name] why am I tied?</i>\"" +
						" You sternly tell her she did something very bad and needs to be punished her emotive response at your chastising is immediate and appropriate." +
						" You have a dildo brought to you and you begin fucking the whore in earnest and groping her breast, teaching her the pleasures of the flesh like you did her mind to forever ingrain these feelings in her." +
						" You make her cum until she’s half-broken from the delicious torture, then set her free to join the others." +
						" She surpasses expectations and jumps the nearest man, straddling him right away.");

			outputText("You smirk delighted at your work and head back to the lair commons");
			doNext(CaveLayout, true);
		}

		public function MindbreakerBrainEvolution(isOutOfCave:Boolean = true):void {

			outputText("\n\nAs you finish converting this new recruit to the sisterhood you are suddenly rocked to the core by a spike of pleasure, your mind expanding with new psychic powers. Your body convulses, spontaneously splashing the ground beneath you green with eldritch slime." +
					" Fully overcome by desire you order your newest disciple to kneel in front of you as you begin to fiercely masturbate, cumming over and over again and covering the convert with so much fluid one might mistake them for a slime monster." +
					" All the while, your newest disciple smiles in awe and pleasure. You baptise your newest adept with your blighted juices, their eyes rolling back in ecstasy. The psychic feedback overwhelms it's addled brain, and they convulse, spraying the floor with their love-juices." +
					" In need of more you firmly shove your");
			if (player.hasCock())outputText(" cock");
			if (player.hasVagina())outputText(" cunt");
			outputText(" into the adept mouth, letting your new pet do wonders with its tongue and flooding its throat with green sludge.\n\nOnly as you reach your tenth orgasm do you relent")
			if (isOutOfCave) outputText(", ordering your dazed toy to head to the cave where Kaerb Dnim will provide it with further training.");
			else outputText(".");
			outputText(" \n\nYour overloaded brain seems to have changed, improved as your thoughts are now more lewd, more obscene, more perfect. You are getting closer to the truth. ");
			if (!player.hasPerk(PerkLib.MindbreakerBrain1toX)){
				outputText("<b>You acquired the Perk Mindbreaker Brain</b>.");
				player.createPerk(PerkLib.MindbreakerBrain1toX,1,0,0,0);
			}
			else{
				outputText("<b>Your psionic powers have expanded!</b>.");
				var newRank:int = player.perkv1(PerkLib.MindbreakerBrain1toX)+1;
				player.setPerkValue(PerkLib.MindbreakerBrain1toX,1,newRank);
			}
			MindBreakerConvertGoal = MindBreakerConvert+20;
			if (isOutOfCave) outputText("\n\nThoroughly satisfied by this new change you head back to camp.");
		}

		private function totalSubservience():void {
			clearOutput();
			outputText("You want to know if there’s more you can do for the Mindbreakers.\n"
				+ "\n"
				+ "“<i>While we are doing well with gathering recruits, If you really must know, there is a ritual to be had if you want to announce yourself as one with The Deep One. If you do this it’ll be too dangerous for you to leave. You will have no choice but to stay with us forever as a loving family, are you sure you want to do this?</i>”\n"
				+ "\n"
				+ "Are you willing to subject yourself to being here for all eternity?\n");
			outputText("\n\n<b>This will end your adventure.</b>");
			doYesNo(deepOne, refuseDeepOne);
			//=============================

			function deepOne():void {
				clearOutput();
				outputText("The idea rings with your soul, this is what you need… to be one with The Deep One.\n"
					+ "\n"
					+ "She guides you down the halls before running her finger along the wall. The flesh contorts before an opening appears before the two of you\n"
					+ "\n"
					+ "The idea rings with your soul. This is what you need… to be one with The Deep One.\n"
					+ "\n"
					+ "She guides you down the halls before running her finger along the wall. The flesh contorts before an opening appears before the two of you. The Deep One stirs as his gaze fixates on the two of you.\n"
					+ "\n"
					+ "\"<i>We have come here as an offering, Deep One. [name] wishes to submit [himself] completely in one of our most sacred rituals. Won't you allow them this embrace?</i>\"\n"
					+ "\n"
					+ "The harmonious cacophony of music rings through you... Acceptance... Worthy... Truly adequate... This is what you are now. This is what you will become - one with everyone.\n"
					+ "\n"
					+ "Kaerb-Dnim turns to you, \"<i>I'm a little jealous... He sees you as truly worthy. I'm honored to witness this and be by your side, [name]. Eternity is ours forever.</i>\"\n"
					+ "\n"
					+ "The Deep One lowers a tentacle to you, wrapping your insignificant body around in the massive appendage. The melody rings through your soul as the warmth of his breath flows through you. Life... Meaning... Purpose... All are true, and all will be given to you.\n"
					+ "\n"
					+ "His long tongue sticks out, coating you in his love, his essence, his very being.\n"
					+ "\n"
					+ "Your body contorts. Your flesh is willing. You are malleable. You belong to him.\n"
					+ "\n"
					+ "Your body coats itself in a thick, viscous slime as more tentacles sprout from around you. You are more than you could ever be. Tentacles sprout from your pussy and cockslit, all the more to share with.\n"
					+ "\n"
					+ "You look toward The Deep One. Satisfaction. There is a glow in his gaze, one that rings of welcoming and content.\n"
					+ "\n"
					+ "His voice rings in a pleasant melody, \"<i>You are home with us.</i>\"\n"
					+ "\n"
					+ "He sets you down next to Kaerb-Dnim. His tentacle ardently caressing your mass of shapes and contorting tentacles.\n"
					+ "\n"
					+ "Kaerb-Dnim grabs hold of one of your tentacles. You realize that without legs you can hardly walk anymore.. You hardly remember what your old body used to look like. Was it like Kaerb-Dnim’s? It's so hard to figure out where you begin and end. Your body effortlessly reshapes itself with every fleeting moment. You are everything to everyone now, and you belong to the people.\n"
					+ "\n"
					+ "Kaerb-Dnim smiles eagerly, \"<i>Let's go, [name]. I'm sure many people can feel your presence already. They want to see the new you!</i>\"\n"
					+ "\n"
					+ "You have an entire view around yourself. You don't need to move your eyes, for your eyes are everywhere now. You roll along the ground, following Kaerb-Dnim as she guides you to your brothers and sisters.\n"
					+ "\n"
					+ "The world fades into a dull haze of ecstasy. Your brothers and sisters taking turns with your form. Each tentacle holds a lover, a slave, a sister, a brother. You are right where you belong. You are made of love, love is the only thing you feel now, and you will share this love with everyone willing to accept it.\n");
				EventParser.gameOver();
			}

			function refuseDeepOne():void {
				clearOutput();
				outputText("Perhaps another time.");
				CaveLayout(true);
			}
		}

	}
}
