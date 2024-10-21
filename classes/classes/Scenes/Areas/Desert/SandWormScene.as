package classes.Scenes.Areas.Desert
{
import classes.*;
import classes.BodyParts.Skin;
import classes.GlobalFlags.kFLAGS;
import classes.IMutations.IMutationsLib;
import classes.Scenes.SceneLib;

public class SandWormScene extends BaseContent
{
				
	public function SandWormScene()
	{
	}

	public function SandWormEncounter():void {
		clearOutput();
		outputText("While exploring the desert, the ground around you begins to quake. A large mound of sand is heading straight for you. You begin running in the opposite direction but the thing quickly catches up to you and leaps out of the sand, its looming shadow covering your own just before you dodge to the side, avoiding the crashing giant chitinous body that lands in where you were moments before and rapidly digging back underground again. A second later and its head and massive circular maw surges out of the sand again, staring at you before screeching loudly, sending strands of green fluid flying which smokes when making contact with the ground. <b>It's a sandworm, one of the desert's scariest residents and it's clearly going for you!</b>[pg]");
		startCombat(new SandWorm());
		doNext(playerMenu);
	}

	public function loseToSandWorm():void {
		clearOutput();
		if (player.tallness > (11*12)) {
			loseAsTallPerson();
			return;
		}
		if (!player.hasStatusEffect(StatusEffects.Devoured))
			getSwallowed();
		if (player.hasCock())
			loseAsMale();
		else loseAsFemale();
	}

	private function loseAsTallPerson():void {
		outputText("As you fall over to the ground defeated, the sand worm looms over you. Well, clearly you just wouldn't fit in that gaping mouth of his so it can't exactly eat you. To your absolute surprise instead a tiny human sized pink woman slides out of its mouth and starts yelling angrily at you.[pg]");
		outputText("\"<i>My territory you biggy no welcome you leave! You're scaring away mates!</i>\"[pg]");
		outputText("You do try and clear the misunderstanding but the not so bright pink woman does not seem to care for your reasoning. In an effort to kick you out she begins to push your prone form across the desert. A few minutes later you're at the limit of her territory and she digs back underground heading back to whence she came. Beaten up you head back to camp.[pg]");
		cleanupAfterCombat();
	}

	private function getSwallowed():void {
		outputText("On the verge of defeat, you try to run, but the sand worm surges out of the sand and crashes down onto you, its mouth swallowing you whole.[pg]");
	}

	private function loseAsMale():void {
		outputText("The world turns dark around you. There is no light here in the belly of the monster. As you ponder how the hell you're getting out of here, the slimy drip of some fluid drops on your head from the fleshy ceiling. Damn, you don't want to be digested by this thing! It's only when you try to stand up that you realize your body is entangled in a mass of fleshy squirming tentacles! Your gear is being forced off you piece by piece until you are completely naked and at their mercy! You try to punch the things away, but your arms are immediately restrained![pg]");
		outputText("\"<i>Why you struggling so much? You not in pain, right? I made sure you comfortable.</i>\"[pg]");
		outputText("From the shadow of the worm's innards, a small silhouette produces a pale light. It appears to be a human with light pink skin, pink hairs and crimson eyes. At first you're about to resume struggling in order to request help from what you assumed to be a second victim of the giant thing, but as she gets closer, you realize her body beneath waist level is meshed with the tentacle system within the beast belly… she is part of it.[pg]");
		outputText("\"<i>Just want mate. Can go after mating. Lets fuck?</i>\"[pg]");
		outputText("Unsurprisingly, for an invertebrate, she's clearly not the brightest tool in the shed, more a creature of extinct then reason but she seems to only be after your seed. Well, still better than getting digested by her. You accept to mate with her so long as she lets you free after.[pg]");
		outputText("\"<i>Sure, now we mate!</i>\"[pg]");
		outputText("Before you can say anything, she is already crawling toward you. The tentacles did short work on pulling you out of your gear, and now the sand worm is more than ready to take you in. She parts a few tentacles away, revealing a somewhat human looking pussy before wrapping her arms around your shoulder.[pg]");
		outputText("Her hand roams around your body briefly, getting a feel of you before she leans closer, pulling toward her and guiding your dick in her. While you're already immobilized, stuck into the flora of her fleshy tentacles, the worm tongue-like appendage proceeds and slowly milk you of your semen. It would be rather pleasant if you didn't have the knowledge of having sex in the depth of some giant monster body while being covered in aphrodisiac clothes dissolving fluids!"+(!player.lowerGarment.isNothing ? " Heck your underwear are already in ruin whatever is left of them you won't be able to use anymore!":"")+" The pressuire builds up within your lons as an incoming climax forces you back to reality. You unleash rope after rope of your seed into the greedy girl.[pg]");
		outputText("\"<i>Fair, fair me happy, you free… Go.</i>\"[pg]");
		outputText("A second later, you see the bright light of the sun as you are expelled from the worm's body, left hanging in the middle of the desert. The pink girl waves you off before digging back underground to do whatever those sex crazed invertebrates do once they finish mating. You, on the other hand, are exhausted by the session and need to return back to camp to recover.[pg]");
		if (!player.lowerGarment.isNothing) player.lowerGarment.name == "nothing";
		player.sexReward("vaginalFluid", "Dick");
		cleanupAfterCombat();
	}

	private function loseAsFemale():void {
		outputText("The world turns dark around you. There is no light here in the belly of the monster. As you ponder how the hell you're getting out of here, the slimy drip of some fluid drops on your head from the fleshy ceiling. Damn, you don't want to be digested by this thing! It's only when you try to stand up that you realize your body is entangled in a mass of fleshy squirming tentacles! Your gear is being forced off you piece by piece until you are completely naked and at their mercy! You try to punch the things away, but your arms are immediately restrained![pg]");
		outputText("The thing quickly seeks out your vulnerable pussy and [asshole], going right in. You cry out in pleasure as your insides are stuffed full of squirming tentacles driving your bitch button crazy. As you are about to reach orgasm, the tentacles squirm with increased vigor, making you arch your back in response as the tendrils drill deeper and deeper into your body, leaving a cool sensation from your lower spine all the way to your brain.[pg]");
		if (player.blockingBodyTransformations()) {
			transformationImmune();
			return;
		}
		outputText("Something hella weird is going with your body as the sensations suddenly extend far beyond your trapped legs… heck, do you even feel those anymore? Everything below your knees seem to have just vanished. The new overload of sensation as your spine seems to extend into infinity, thousands of new nerves you didn't know you had glowing afire with pleasure causes you to cum anew, juicing yourself around the tendrils invading your pussy. With the monster tendrils mostly immobile now, with no sign of actual digestion and exhausted by the ordeal you slowly fall asleep, curling yourself into the wet but comfortable mass that is the worm innards for a quick nap. You can escape later, right now you just want to rest.[pg]");
		outputText("When you open your eyes, you see outside and inside at the same time, a weird experience that leaves you dazed and confused for a moment as your mind catches up with the feedback. A brief analysis of your body reveals two things, first you indeed are still within the worm, and second, you now are this very worm. Your upper body has merged with that of the giant invertebrate, becoming the tongue within its mouth. While the change seems to have greatly diminished your ability to think rationally beyond your irrepressible desire to mate, you are very much in control of this combined body. Every curve of the beast's titanic coils obeying your thoughts. With this kind of power you feel like you could wake to a demon army, beat them up and force them into mating you… wait that's not right.[pg]");
		outputText("Something here definitely is very messed up but you can't exactly pinpoint what.[pg]");
		outputText("Reproducing is your life purpose after all, and defeating the demons is how you will safeguard your eggs. Not too sure about what is going on here, you just decide to head back to camp.[pg]");
		transformations.HairDripping.applyEffect(false);
		transformations.HairChangeColor(["pink"]).applyEffect(false);
		transformations.FaceHuman.applyEffect(false);
		transformations.EyesHuman.applyEffect(false);
		transformations.EyesChangeColor(["red"]).applyEffect(false);
		transformations.ArmsHuman.applyEffect(false);
		transformations.TongueHuman.applyEffect(false);
		transformations.EarsHuman.applyEffect(false);
		transformations.HornsNone.applyEffect(false);
		transformations.AntennaeNone.applyEffect(false);
		transformations.RearBodyNone.applyEffect(false);
		transformations.GillsNone.applyEffect(false);
		transformations.WingsNone.applyEffect(false);
		if (!player.hasVagina()) transformations.VaginaHuman(0).applyEffect(false);
		if (player.hasCock()) player.killCocks(-1, false);
		if (player.bRows() > 1) transformations.BreastRowsOne.applyEffect(false);
		if (player.biggestTitSize() < 2) player.growTits(2, 1, false, 3);
		if (player.femininity < 80) player.femininity = 80;
		player.tallness = 11 * 12;
		transformations.LowerBodyWorm.applyEffect(false);
		player.skin.setBaseOnly({ type: Skin.PLAIN, color1:"light pink", adj: "slippery" });
		if (player.hasPerk(PerkLib.RacialParagon)) flags[kFLAGS.APEX_SELECTED_RACE] = Races.SANDWORM;
		IMutationsLib.TrachealSystemIM.trueMutation = true;
		IMutationsLib.TwinHeartIM.trueMutation = true;
		player.removeAllRacialMutation();
		outputText("Gained combat ability: <b>Dig</b>\n\n");
		outputText("Gained combat ability: <b>Swallow Whole</b>:  Leap out of the ground and attempt to swallow your enemy whole for sticky pleasure time.\n\n");
		outputText("Gained combat ability: <b>Devastating Bite</b>: Strike for massive the damage as a bite natural weapon.\n\n");
		outputText("Gained combat ability: <b>Acidic Bite</b>: Your saliva has dissolving and aphrodisiac properties. Creatures stuck in your mouth take heavy periodic teases and acid damage based on your combined strength, toughness and libido modifier.\n\n");
		outputText("Gained combat ability: <b>Sting</b>: Inflict sand worm venom and minor damage, sand worm venom deals heavy strength and tease damage over time.\n\n");
		player.createPerk(PerkLib.TransformationImmunity2, 7, 0, 0, 0);
		outputText("<b>Gained Perk: Transformation Immunity</b>\n\n");
		cleanupAfterCombatTFEvent();
	}

	public function transformationImmune():void {
		outputText("The sandworm sddenly spits you out and you watch with increasing confusion as it suddenly dives into the sands before you pass out.\n\n");
		player.sexReward("none", "Vaginal");
		cleanupAfterCombat();
	}

	public function beatSandWorm():void {
		clearOutput();
		outputText("Too "+(monster.HP <= monster.minHP() ? "wounded":"aroused") + " to keep on fighting, the sand worm digs underground, escaping the battleground. [if (silly)Geeze you hate it when low budget actors flee the battlefield before you rape them!][pg]");
		menu();
		addButtonIfTrue(3, "Tame It", SceneLib.campMakeWinions.tamingAttempt, "Req. to have Job: Tamer", player.hasPerk(PerkLib.JobTamer));
		addButton(4, "Leave", cleanupAfterCombat);
	}

}
}