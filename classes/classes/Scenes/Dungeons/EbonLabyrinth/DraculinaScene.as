
package classes.Scenes.Dungeons.EbonLabyrinth
{
import classes.BaseContent;
import classes.BodyParts.*;
import classes.GlobalFlags.kFLAGS;
import classes.IMutations.IMutationsLib;
import classes.Scenes.NPCs.DivaScene;
import classes.Player;
import classes.Races;
import classes.Scenes.SceneLib;
import classes.Scenes.Metamorph;
import classes.StatusEffects;
import classes.display.SpriteDb;
import classes.PerkLib;
import classes.BodyParts.Tail;
import classes.BodyParts.LowerBody;
import classes.EventParser;

public class DraculinaScene extends BaseContent {
    public function DraculinaScene() {}
    
    private function allTheTricksForDarkness():Boolean {
		if (player.hasStatusEffect(StatusEffects.KnowsBlind) || player.hasStatusEffect(StatusEffects.KnowsSunrise) || (player.tailType == Tail.KITSHOO && player.tailCount >= 6)) return true;
		else return false;
	}
	public function encounter():void {
        if (player.wis >= 150 && allTheTricksForDarkness()) encounterYes();
		else {
			clearOutput();
			outputText("<b>"+(player.wis < 150 ? "This area look suspicious your senses are duller then a sword that's not been sharpened for two centuries, should you get ambushed here who's to tell what may happen to you It might be smarter to turn back now while you still can and train your wits. ":"")+(allTheTricksForDarkness() ? "":"The room ahead is rather dark. Without any source of magical light you might be in great danger. ")+"Do you proceed anyway?</b>");
			menu();
			addButton(1, "No", encounterNo);
			addButton(3, "Yes", encounterYes);
		}
    }
	public function encounterNo():void {
		SceneLib.dungeons.ebonlabyrinth.returnFromDraculinaRoom();
	}
	public function encounterYes():void {
		clearOutput();
        //spriteSelect(SpriteDb.s_Atlach_16bit);
		if (player.racialScore(Races.DRACULA) >= 22) {
			outputText("As you explore the labyrinth, you find yourself in a familiar room. Nonchalantly, you push open the large, unassuming stone door to enter the vampire's lair. If you were another person, this would certainly be your demise, being but another snack for the entity that dwells here, but in your case, you are a different type of deal entirely. You enter the dwelling without hesitation, ears perking up to your surroundings as you locate your kind easily, spotting her resting by a large stalactite.\n\n");
			outputText("You fly to her in silence, surprising her with a sudden embrace as she is unable to track a heartbeat, something you lack entirely.\n\n");
			outputText("She recoils, trying to shake you off, \"<i>What the hell, who are you, weirdo?! And where did you come from?!</i>\"\n\n");
			outputText("Without giving her any more time to react, you tell her what she did to you, confiding gently as you sensually sink your fangs into her neck, eliciting a pleased moan from the woman as you suck on her blood with a gentle passion. You do not need to offer any further words, for her body and gestures follow in your steps.\n\n");
			outputText("She sinks her fangs into your sensitive neck y");
			if (player.gender > 0 || player.breastRows[0].breastRating >= 1) {
				outputText("our ");
				if (player.hasCock()) outputText("[cock] hardens and throbs ");
				if (player.gender == 3) outputText("while your ");
				if (player.hasVagina()) outputText("pussy gushes a cascade of girlcum, falling down your body with a wet plopping sound to the ground below ");
				if (player.breastRows[0].breastRating >= 1) {
					if (player.gender > 0) outputText("and y");
					outputText("our nipples harden with each seductive stroke she gives you, gliding her fingers over your form");
				}
				outputText(". Y");
			}
			outputText("ou begin to pant with pleasure and unrestrained arousal as your blood is drained whilst she feels up every inch of your body she can.\n\n");
			if (player.hasCock()) {
				outputText("A silky palm gently takes hold of your [cock], dexterous fingers caressing the sensitive flesh before guiding it into her set of velvety folds. Accepting her ministrations, you ardently push past her labia, filling her with every inch she so eagerly craves, thrusting into her at a gentle place as her warmth clutches onto you tighter, trying to pull you back in after each thrust.\n\n");
				outputText("Your thrusts elicit a soft moan from her as she tries to clamp down on you further, her grip is feverish as she leans into you. She leans back closer to you, the feeling of her cool flesh brushing closer against you as she tries to envelop herself deeper within your embrace, eager for what love you can offer her. You return with a more forceful thrust back into her cunt, clutching onto her tighter.\n\n");
				outputText("Your climax nears closer, unable to hold back from her unholy embrace, you thrust harder into her, hilting your dick inside her as far as you can push before you cum into her. You continue thrusting, your body not bothering with any sense of fatigue. Eager to explore the limit of your stamina, you thrust back into her with greater vigor as she moans eagerly, clamping tightly as you can feel her girlcum coating your [cock]. ");
				outputText("The wet, sloshing sounds as you pound into her fill the cave as you flood her with load after load of your defiled cum."+(player.cumQ() >= 4000 ? " You are filling her with so much cum,  you have to support her as she's almost starting to lose her grip with the weight of your endless load.":"")+"\n\n");
			}
			if (player.hasVagina() && !player.hasCock()) outputText("A silken hand gently slides up from your labia before it parts the folds of your dripping cunt, the fingers expertly circling your clit as she digs a finger past your lips, digging for your sweet spot in a teasing effort to make you cum. Not one to be outdone, you reciprocate to your partner using your dexterous digits to explore and tease her drenched pussy. You both bring each other to orgasm several times, uncaring of the world around you nor the passing of time. There is no such thing as exhaustion to stop you, either.\n\n");
			outputText("Several hours pass before you realize the pair of you have been having sex nonstop to the point you’ve completely lost track of time. It takes a great effort of willpower from you to remove your fangs from her neck before you gently tap on her shoulder. She reluctantly releases you a few seconds later and politely cleans the corner of her mouth with her wings before addressing you directly.\n\n");
			outputText("She sighs softly, still partially enthralled with your presence, \"<i>Next time, you should definitely give a warning, the surprise sex came out of nowhere.</i>\"\n\n");
			outputText("If you had warned her, it wouldn’t be surprise sex, would it? She’s sure one to talk. Isn’t ambushing people down a dark cave, by definition, a surprise?\n\n");
			outputText("Thoroughly satisfied, you bid your sire to take care and head back down into the labyrinth.\n\n");
			if (player.hasCock()) player.sexReward("vaginalFluids","Dick");
			else player.sexReward("vaginalFluids");
			inventory.takeItem(consumables.VAMPBLD, playerMenu);
            return;
		}
		else {
			outputText("As you turn the next corner, you end up face to face with a large stone door. Lacking any other options, you force the door open with a loud grinding noise and enter what appears to be a large, cavernous section. The door slowly closes behind you with a loud clang. Startled by the sudden noise, bats take off into the black depths. Your [skin] crawls, almost like you’re being watched.\n\n");
			outputText("Is it your imagination, or are there unfriendly eyes spying on you from the murky shadows? You hear the scraping of metal upon stone in the distance, steadily encroaching upon you. You ready yourself for combat, and a labyrinth minotaur suddenly charges out of the shadows. You brace yourself for his charge, but to your shock, he ignores you, attempting to run past you in a blind panic. ");
			outputText("Your gaze follows the panicked bull; a blurry shadow grabs him just as he reaches the door. With a sound somewhere between a moo and a scream of terror, he kicks at the shadow, his fingers digging desperately into the stone in a futile attempt to pry the door open.\n\n");
			outputText("The shadow thickens, wrenching the poor creature off his feet. For the first time, he looks at you, eyes open in a wordless, desperate plea for help. Before you can make much sense of this, his hulking form is dragged across the floor, nails scrabbling on the stone floor as he screams for help into the darkness. The panicked sound of the bull muffled in an instant, utterly extinguished. ");
			outputText("You take a wary stance and keep progressing forward. Whatever took this brute is still out there. The cave system seems to stretch for a while, and you're about to reach its end when you hear a sudden rush of air to your right.\n\n");
			if (player.wis >= 150 || (player.wis < 150 && (rand(100) + Math.round(player.wis*0.5) > 100))) {
				outputText("Your sixth sense suddenly warns you of impending doom, and you roll forward to avoid being grappled by whatever that thing you detected behind you. You turn around and adopt your fighting stance.\n\n");
				outputText("\"<i>Oh my… so lively, so strong and smart too I can't believe you made it all the way down here. A shame I'm hungry at the time, as one minotaur is hardly enough to satiate me. See, I would do a curtsy and present myself properly, but I'm afraid it won't matter. What good is a name given to someone who's about to die?</i>\"\n\n");
				outputText("The creature in front of you appears to be a beautiful, ivory white skinned succubus with flowing blonde hair. Her sharp, hungry red eyes fixates on you with the glare of a fox cornering a rabbit. She would look like an ordinary succubus, save perhaps for two alarming details. One being her overgrown wingspan, giving her wings the appearance and coverage of a cloak and two, the large canine she sports in her mouth that she licks sensually.\n\n");
				outputText("You know demons can be found everywhere in this damned labyrinth, but this 'thing' is no ordinary fiend. From the way she talks to her mannerisms she exudes a form of dark and sinister nobility. "+(DivaScene.instance.isCompanion()?"Diva could pretend and act all she wants in her make believe world of hers, this girl is no pretender. The terrifying aura of unholy power surrounding her is all too real!":"")+" ");
				outputText("She suddenly folds her wings and takes off with a deafening screech, the cave wall reverberating the sound endlessly as bats begin to swarm around her hovering form in the thousands, answering the call of this monstrosity like loyal soldiers to a general. You're almost grateful the demoness doesn't attack you while you reel back from the blasting soundwave, though you suspect she simply wants to savor the fight, draining you slowly until you can no longer resist.\n\n");
				outputText("\"<i>Try and entertain me, adventurer. Struggle all you want too, It'll make the blood pump faster before I drain it dry.</i>\"\n\n");
				outputText("With no choice but to defend yourself, you prepare for combat as the blood sucker chuckles.\n\n");
				startCombat(new Draculina(), true);
			}
			else {
				outputText("You’re about to run away when two wings wrap strongly around you restraining your body. Your captor looks like a demon with white ivory skin, blood red eyes and a surprising amount of strength.\n\n");
				outputText("\"<i>Oh my… What a cute morsel I just got here. I can't believe you made it all the way down here and alive nonetheless, what with being oblivious and all. A shame I'm hungry at the time, as one minotaur is hardly enough to satiate me.</i>\"\n\n");
				outputText("You struggle against her but she has a grip stronger then steel.\n\n");
				outputText("Your batty tormentor gives you a charming, if not fanged, smile as she takes a whiff of your neck.\n\n");
				if (!player.blockingBodyTransformations() && player.gender > 0 && ((player.hasVagina() && player.vaginas[0].virgin) || player.racialScore(Races.VAMPIRE) >= 10)) becomeDracula();
				else defeatedBadEnd();
			}
		}
	}

    public function defeatedBy():void {
        clearOutput();
        outputText("As you fall down defeated, a soft, gentle hand picks and holds your back, just as you're about to hit the ground. Your batty tormentor gives you a charming, if not fanged, smile as she takes a whiff of your neck.\n\n");
        if (!player.blockingBodyTransformations() && player.gender > 0 && ((player.hasVagina() && player.vaginas[0].virgin) || player.racialScore(Races.VAMPIRE) >= 10)) {
			outputText("As you fall to the ground, defeated, a soft, gentle hand lifts you in a soft embrace as you're about to hit the ground. Your batty tormentor gives you a charming, if not fanged, smile as she takes a whiff of your neck.\n\n");
			becomeDracula();
		}
		else defeatedBadEnd();
    }
    
    public function defeat():void {
        clearOutput();
        outputText("Damn it no matter how much damage you inflict her she just doesn't seem to weaken. Every time she drinks some of your blood it's like she gets a second wind!\n\n");
        outputText("\"<i>So fiesty! I will enjoy draining every last drop out of you! Come on, surrender, I will make your death quick and beautiful.</i>\"\n\n");
        outputText("As she dive bombs at you, you desperately throw a rock at her and it strikes her right onto the head causing her to crash a fair distance away.\n\n");
		outputText("\"<i>I was going to make your death beautiful. But after that little stunt?</i>\" She spits some blood from her mouth, where the rock had struck. \"<i>Now, I think I’ll just rip your sweet little head off, and drink from there!</i>\"\n\n");
		outputText("Not taking any further chances, you use this opening to run to the damn door. With all your adrenaline and desperation giving you strength, you use all of your might on the stone door, forcing it open. You slip out quickly, and as you turn to close it, you see her, wings spread and mouth wide open as she rips through the air toward you. Startled, you slam the door shut, bracing yourself against it. You hear a loud *crunch*, followed by the smooth shuffling of feet.\n\n");
		outputText("\"<i>You won’t get away!</i>\" She howls, her voice shaking the stone. You hold the door shut as a rain of smaller objects ram into the door, and you realize that you can’t hold the door shut forever. As she screeches on the other side, you see a simple candelabra beside the door. Thinking fast, you grab the stand, using it to bar the door shut and take off without a second thought. ");
		outputText("You book it, fleeing as fast as you can to get away from here before the monster breaks down the door, the only obstacle between you and her. Now, back to a relative safety, you're ready to resume exploring.\n\n");
        cleanupAfterCombat();
    }
    
    private function defeatedBadEnd():void {
        outputText("\"<i>Mmmmm, adventurers blood… shame that you're no virgin. I might've kept you around. Oh well, don't hate me for what I'm about to do. It's the fate of prey like you, to become a predator’s meal.</i>\"\n\n");
		outputText("She sinks her fang into your neck, and you struggle feebly as she drains you dry. Once you're nothing but an empty husk, she drops your cadaver to the ground. She takes off, wiping her fangs with a handkerchief, making way to her cave to tend to her next victim. Your story, sadly, ends here, just another victim of the Labyrinth.\n\n");
        //[GAME OVER]
        EventParser.gameOver();
    }

    private function becomeDracula():void {
        if (player.racialScore(Races.VAMPIRE) >= 10) {
			outputText("\"<i>My, oh my… someone here is quite special. Is that…</i>\" She takes another deep inhale along your neck, \"<i>Vampire blood I smell in your veins? It's newly awakened, impure and somewhat still mixed with the faint echo of… mmm human blood?</i>\"\n\n");
			outputText("She taps her chin thoughtfully then seems to come to a decision.\n\n");
			outputText("\"<i>How about I help you fully awaken the power that is within you. Oh, it will cost you, but I'm sure by the time I'm done, you will thank me with all of your soul…</i>\" She laughs as if she’d just made a fine joke. \"<i>Quite literally, you see. Not that you’ll need it.</i>\" She brings her mouth to your ear, slowly, almost sensually. \"<i>Thanks for the meal!</i>\"\n\n");
			outputText("Panicking, you realize what she’s about to do, you begin struggling. She proves too strong for you in your weakened state, easily keeping hold of you. Without further delay, she brings her fangs down, biting into your neck. You gasp, an empty, hollow feeling spreading from her fangs as she begins to suck, warm droplets of your blood spilling down your neck. ");
			outputText("Dizzy, head reeling, you fall, only to have her hold you, the hollow, horrible feeling spreading down your neck and into your body. Your skin becomes clammy and pale, losing all color as she slowly empties you of all your blood, leaving you on the brink of death. Just as you thought she was going to drain you dry, her fangs retract from your neck. She gives you a playful lick before biting at her hand, drawing her own blood.\n\n");
			outputText("\"<i>Let me… kiss you.</i>\"\n\n");
			outputText("Abruptly, she pulls you into a lewd, passionate kiss, passing her potent blood directly to you. You feel yourselves overcome by change as your half broken body reacts with violence!\n\n");
		}
		else {
			outputText("\"<i>My oh my… a virgin maiden? You're turning out to be quite the prize. A pure girl and an adventurer too, your blood must be of the most noble of vintages. And best of all you brought it all the way here… right into my lap.</i>\"\n\n");
			outputText("You struggle in her grip. Now that you are too weak to resist her you remember the bull and stare back into her eyes, fearful of what she could do to you!\n\n");
			outputText("She licks your neck, her long, fiendish tongue rolling obscenely onto your skin and leaving a trail of saliva.\n\n");
			outputText("\"<i>Mmm salty…</i>\"\n\n");
			outputText("Without any delay, the fiend bites into your neck drawing your blood drop by drops. Your skin becomes even more pallid as she slowly empties you of all your blood leaving you on the brink of death. Just as you thought she was going to drain you dry, her fangs retract from your neck. She cleanses your wound with her tongue before biting at her hand drawing her own blood.\n\n");
			outputText("\"<i>Let me… kiss you.</i>\"\n\n");
			outputText("Abruptly, she pulls you into a lewd, passionate kiss, passing her potent blood directly to you. You feel yourselves overcome by change as your half broken body reacts!\n\n");
		}
		outputText("You fall on all fours, groaning in pain and clawing at the ground as your form ripples, the corrupted blood running through you. Pleasure and pain pump through your body with each heartbeat, sending shocks of torturous pleasure through you.\n\n");
        if (player.wings.type == Wings.NONE) {
			outputText("You hear a horrifying ripping noise as your back stretches and tears to allow new bones to expand, black as tar and lighter than many of the bones in your body. These new bones shift under your shoulder blade, worming their way to the skin. ");
			outputText("Burying you in a wracking pain, they violently break through your skin, spattering your blood everywhere. You let out a bone-chilling scream, your wounds slowly closing on their own. You reflexively close your new wings around you in a pointless effort to protect yourself from the pain, but it won’t stop.\n\n");
		}
		outputText("Your throat aches like you have skipped drinking water and have instead been sipping on ashes instead for days. You crave uncontrollably for something to sate your thirst"+(player.faceType == Face.VAMPIRE?"":" as your canines elongate and sharpen into a form evolved to pierce skin and sate that thirst")+".\n\nY");
		if (player.hasCock()) outputText("our cock begins to harden, pumping a ridiculous amount of blood"+(player.demonCocks()>0?"":" as your dick takes on a more fiendish shape matching that of demons")+"."+(player.hasBalls()?" Your balls begin to churn as unholy powers amass into your gonads, your ballsack glowing purple with accumulated black magic as your they grow by a few inches.":"")+" The black cum rush through your urethra as you explode into a corruption induced orgasm, your dick unloading ropes after ropes of demonic cum");
		if (player.gender == 3) outputText(". Once your cock finishes unloading, y");
		if (player.hasVagina()) outputText("our vagina begins to juice itself as you practically orgasm repeatedly to the fiendish pleasure of your cunt being reshaped and remodeled into something far more far more pleasurable. Your brand new upgraded succubus vagina continues orgasming a few more time as black sludge mixed with purple fluids begins to flood out of your cunt");
		outputText(" causing you to twitch uncontrollably on the ground as drop by drop of your soul is expelled, eventually leaving you empty.\n\n");
        outputText("For an incalculable amount of time, you lay there grasping at the ground and twitching as your body is ravaged by both pleasure and pain. You long lost count of the time, has it been minutes? Hours? Days?!? While your tortured scream of agony and moans of pleasure draws the nearby curious they quickly run the fuck off the moment they see your lust crazed gaze as well as what your turning into, not wanting anything to do with that not even for a chance to fuck you from behind!\n\n");
        outputText("As pain and pleasure ramp up your heart goes into hyperdrive beating an immeasurable speed before suddenly… nothing? Confused, you suddenly realize the gravity of the situation, you no longer have a heartbeat. It looks like from any healer’s perspective, you died… Yet your body keeps on living against all logic. With this you finally became a true vampire."+(silly()?" You feel a vague compulsion to go mock a priest and kill a Nazi bitch…You are a REAL. FUCKING. VAMPIRE.":"")+"\n\n");
        outputText("You begin to stand up looking around as you fold your wings. A stray sound catches your attention and, in the blink of an eye, you fly to its destination. It’s a single minotaur… alone… vulnerable. You begin to salivate abundantly as you suddenly dive out of the darkness and embrace him from behind. The bull begins to struggle but your newfound strength quickly overpowers him. Pleasure rushes to your brain as you dig in, sinking your teeth into his throat, sucking out his blood. ");
        outputText("Sucking, drinking, feeding, fucking… ain't no difference to you anymore as each liter you sip out of the minotaur brings you to orgasm "+(player.hasVagina()?"your cunt juicing itself ":"")+(player.gender == 3?"as ":"")+(player.hasCock()?"your penis shooting ropes after ropes of demon cum ":"")+"on the minotaurs back. ");
        outputText("The minotaur suddenly falls off to the ground completely devoid of blood and you wipe your chin in disappointment as you realize you killed him. One's not enough it'll never be enough, you want more blood and want it now! You get back to moving looking for blood.\n\n");
        //TF list
        dynStats("cor", 100);
		if (player.hasCock()) player.lowerBody = LowerBody.DEMONIC_CLAWS;
		else {
			if (rand(2) == 0) player.lowerBody = LowerBody.DEMONIC_CLAWS;
			else {
				if (rand(2) == 0) player.lowerBody = LowerBody.DEMONIC_HIGH_HEELS;
				else player.lowerBody = LowerBody.DEMONIC_GRACEFUL_FEET;
			}
		}
		player.legCount = 2;
		player.skin.setBaseOnly({type:Skin.PLAIN, color1:"pale", pattern: Skin.PATTERN_BLOOD_MAGIC_TATTOO});
		transformations.TailDemonic.applyEffect(false);
		transformations.HairSilky.applyEffect(false);
		transformations.FaceVampire.applyEffect(false);
		transformations.EyesVampire.applyEffect(false);
		transformations.EyesChangeColor(["blood-red"]).applyEffect(false);
		transformations.ArmsDemon.applyEffect(false);
		transformations.TongueDemonic.applyEffect(false);
		transformations.EarsVampire.applyEffect(false);
		transformations.HornsDemonic.applyEffect(false);
		transformations.AntennaeNone.applyEffect(false);
		transformations.GillsNone.applyEffect(false);
		transformations.WingsVampire.applyEffect(false);
		player.rearBody.type = RearBody.THIRSTY_NECK;
		if (player.hasCock()) transformations.CockDemon().applyEffect(false);
		if (player.hasVagina()) transformations.VaginaDemonic().applyEffect(false);
		if (!player.hasStatusEffect(StatusEffects.Familiar)) player.createStatusEffect(StatusEffects.Familiar, 0, 0, 0, 0);
        if (!player.hasPerk(PerkLib.Familiar)) player.createPerk(PerkLib.Familiar, 0, 0, 0, 0);
		IMutationsLib.BlackHeartIM.trueMutation = true;
        IMutationsLib.VampiricBloodstreamIM.trueMutation = true;
        IMutationsLib.HollowFangsIM.trueMutation = true;
        if (player.hasPerk(PerkLib.RacialParagon)) flags[kFLAGS.APEX_SELECTED_RACE] = Races.DRACULA;
        player.removeAllRacialMutation();
        outputText("\n<b>Gained Perk: Soulless!</b> "+PerkLib.Soulless.desc());
        player.createPerk(PerkLib.Soulless, 0, 0, 0, 0);
		player.createPerk(PerkLib.Undeath, 0, 0, 0, 0);
		player.createPerk(PerkLib.SoulDrinker, 0, 0, 0, 0);
        player.createPerk(PerkLib.TransformationImmunity2,8,0,0,0);
		outputText("\n<b>Gained Perk: Transformation Immunity</b>\n\n");
		player.npcsThatLeaveSoullessPC();
		if (combat.inCombat) cleanupAfterCombatTFEvent();
		else doNext(playerMenu);
    }
}
}
