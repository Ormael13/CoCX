/**
 * ...
 * @author Liadri
 */
package classes.Scenes 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	
	public class UniqueSexScenes extends BaseContent
	{
		
		public function UniqueSexScenes() 
		{
		}
		
public function cumOmeter(changes:Number = 0):Number
{
	flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] += changes;
	if (flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] > 100) flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] = 100;
	return flags[kFLAGS.SEXUAL_FLUIDS_LEVEL];
}

public function manticoreTailRapeScene():void
{
	clearOutput();
	outputText("While your defeated foe is laying on the ground, you make a sadistic grin as you contemplate the situation. This came just as you got hungry or rather, just as your tail did.\n\n");
	outputText("Kicking him on his back you proceed to sit on his legs to prevent him from moving. You push everything out of the way as your eyes zero in on their target, his cock. You sting your victim a few times, injecting him with a pint worth of aphrodisiac. For several seconds, he try and get you of him but your poison eventually kicks in and he falls limp on the ground at your mercy. Soon enough, his cock is standing throbbing and erect. Licking your lips, you take it upon yourself to relieve your victim of his pent-up lust, opening your tail and swallowing his entire length inside.\n\n");
	outputText("Smirking with malicious cruelty you whisper softly in your terrified victims ear. \"<i>Does me eating you whole make it feel like you're dying? Don't worry, I will make you die over and over again until you're dry as an empty husk!</i>\"\n\n");
	outputText("Soon, your cumpump face turns to a tormented expression as your tail forcefully milks him of all his cum, regularly injecting more aphrodisiac to make him orgasm and leak constantly like a hose. Ironically and against his better judgment the stimulation of your vaginal wall causes his body to buck up and down in your tail, only making him cum more. On your end, you taste every drop of cum he deposits inside just like you would with your mouth. Delighted by the sensations from your tail pussy, you feel like singing and to your surprise a series of moans that sound like a song come out from your mouth. Only once his balls have shrunk to the point they look like a pair of raisins do you let go of what's left of him.\n\n");
	outputText("You lick your lips feeling like you just had a five course meal fit for a queen as you leave the body of your passed out opponent on the ground at the mercy of other potential sexual predators.");
	if (player.findPerk(PerkLib.ManticoreMetabolism) >= 0) {
		if (player.hasStatusAffect(StatusAffects.FeedingEuphoria)) {
			if (player.statusAffectv2(StatusAffects.FeedingEuphoria) < 30) { //Maximum speed gain is 30.
				player.addStatusValue(StatusAffects.FeedingEuphoria, 2, 10);
				dynStats("spe", 10);
			}
			player.changeStatusValue(StatusAffects.FeedingEuphoria, 1, 10);
		}
		else {
			player.createStatusAffect(StatusAffects.FeedingEuphoria, 10, 10, 0, 0);
			dynStats("spe", 10);
		}
	}
	HPChange(Math.round(player.maxHP() * .2), true);
	cumOmeter(40);
	player.cor += 2;
	player.refillHunger(100);
	player.orgasm();
	statScreenRefresh();
	cleanupAfterCombat();
	return;
}

public function alrauneGetPollinatedScene():void
{
	clearOutput();
	outputText("With your foe on the ground beneath you, you can’t help but think you’ve finally found a stamen to fertilise yourself with! Without waiting any longer, you proceed to grab him with your vines and pull him toward your waiting flower. He violently struggles to escape as you pull him ever closer to your flower, all the while you giggle at his desperate attempts to get away. All good things must come to an end however, and, entertaining as it is, you want him pollinating you now! You release a massive cloud of your aphrodisiac pollen toward him,  letting him inhale your scent.  He doesn’t struggle much any more as his stamen betrays him, going erect in seconds, ");
	outputText("drooling precum at the mere thought of getting a shot at your lovely pussy, something you will be more than happy to let him do. Looking at you with half lidded eyes, he lets you take control entirely. You finally reel him into your nectar bath and kiss him, lubing up his stamen with your nectar. He makes a cute moan as you prepare him for the next step, drooling with delight at the idea of getting what you want.\n\n");
	outputText("Unable to wait any longer, you pull him to you, impaling your nectar drenched hole on his cock. You begin to slide yourself up and down, making lewd wet noises as you forcefully milk your former opponent's stamen. Pollination feels so wonderful! You fawn over him, moving into your drugged victim’s open arms and before long it’s hard to figure which of you is the most addicted, as you kiss him with the passion of a longtime lover. You break the sloppy kiss, your mouths still linked by a strand of saliva, as your mate finally bottoms out and fills your flower with his seed.\n\n");
	outputText("Highly satisfied, you deposit him back on the ground with little ceremony, half conscious from the massive drugged induced orgasm your pollen claimed from him. You can’t help but hope it took, daydreaming of your children to come as you seal your vagina shut to prevent the load from escaping.");
	player.orgasm();
	statScreenRefresh();
	player.knockUp(PregnancyStore.PREGNANCY_ALRAUNE, PregnancyStore.INCUBATION_ALRAUNE);
	cleanupAfterCombat();
	return;
}

public function alrauneSeedingScene():void
{
	clearOutput();
	outputText("With your foe on the ground before you, you feel a familiar warmth rushing through you, making you blush purple as fantasies of filling this woman with your progeny takes you over. Resolving to make your dreams reality, you let loose a spray of your pollen for her to slowly inhale as it lays thick in the air.\n\n");
	outputText("Her face flushes rapidly as her expression gradually turns to that of a bitch in heat, ready for pollination as your aphrodisiacs flood her senses. You help your soon-to-be bride of the day climb up into your nectar bath, allowing her to get a full whiff of your intoxicating scent from the source, something she eagerly does. When you're sure she’s sufficiently entranced you start with a sweet kiss, pulling her into your arms and readying your many stamen mounted vines for the incoming pollination.\n\n");
	outputText("You share a bath with her, washing her body thoroughly with your syrupy nectar until she’s as slimy and ready as you are. Your ambient pollen and various aphrodisiacs only serve to turn her on more, her skin a flushed shade of pink under your sticky nectar, making her squirt from the smallest stimulation, like your heated breath against her neck. You caress her skin, making sure not to leave any area untouched, as you pull your vines into the bath, slowly aligning your cunny and hers with your stamens.\n\n");
	outputText("She lazily gasps in surprise and delight as you insert yourself in her, filling her ass and cunt in just the perfect way with your thick vines. You aren't left wanting either, expertly fucking your pussy in a way only your own stamens can manage. You moan in unison with your partner as your stamens work both your and her holes in perfect synchronization. Nectar and pussy juice mix in the bath, as the pair of you reach orgasm after orgasm, pumping your respective bodies full of fluids. Reaching your peak for the last time with a shuddering cry, you slowly pull the girl out of your flower and deposit her back on the ground, leaving her unconscious but satisfied as you caress her belly still full of your semen.\n\n");
	outputText("Your own belly isn’t any better, and you fantasise at the idea of giving birth hoping it took as you head back to camp.");
	player.orgasm();
	statScreenRefresh();
	player.knockUp(PregnancyStore.PREGNANCY_ALRAUNE, PregnancyStore.INCUBATION_ALRAUNE);
	cleanupAfterCombat();
	return;
}

	}

}