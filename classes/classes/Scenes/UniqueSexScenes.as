/**
 * ...
 * @author Liadri
 */
package classes.Scenes 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	
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
	outputText("Kicking " + monster.pronoun2 + " on " + monster.pronoun3 + " back you proceed to sit on " + monster.pronoun3 + " legs to prevent " + monster.pronoun2 + " from moving. You push everything out of the way as your eyes zero in on the target, his " + monster.cockDescriptShort(0) + ". You sting " + monster.a + monster.short + " a few times, injecting " + monster.pronoun2 + " with a pint worth of aphrodisiac. For several seconds, your toy tries to get you off of " + monster.pronoun2 + " but your poison eventually kicks in and " + monster.pronoun1 + " falls limp on the ground at your mercy. Soon enough, its " + monster.cockDescriptShort(0) + " is standing throbbing and erect. Smirking with malicious cruelty, ");
	outputText("you whisper softly in your terrified victim ear.\n\n\"<i>Does me eating you whole make it feel like you're dying? Don't worry, I will make you die over and over again until you're dry as an empty husk! From this moment you are my toy, slut!</i>\"\n\n");
	outputText("Soon, your cumpump face turns to a tormented expression as your tail forcefully milks him of all his cum, regularly injecting more aphrodisiac to make him orgasm and leak constantly like a hose. Almost ironically, and against " + monster.pronoun2 + " better judgment the stimulation of your vaginal walls causes " + monster.pronoun3 + " body to buck up and down in your tail, only making him cum more. On your end, you taste every drop of cum he deposits inside just like you would with your mouth. It is a delicious taste, way different from what cum would have tasted had you been human. However you have another body part that you would like to satisfy and you move your hips to the " + monster.a + monster.short + " face, shoving your drooling [pussy] in your victim’s face.\n\n");
	outputText("\"<i>Lick me clean you worm! Don’t you see how wet I am?!</i>\"\n\nBoth too terrified and supremely horny to refuse your command, your defeated foe begins to use its tongue to give your sensitive pussy a proper licking. Delighted by the sensations from both of your pussies, you feel like singing your pleasure and to your surprise a series of moans that sound like a song come out from your mouth as you ride orgasm after orgasm, splattering " + monster.pronoun3 + " crotch and face with your girl juice.\n\n");
	outputText("Only once " + monster.pronoun3 + monster.ballsDescriptLight() + " have shrunk to the point they look like a pair of raisins do you let go of what's left of " + monster.pronoun2 + ".\n\nYou lick your lips feeling like you just had a five course meal fit for a queen as you leave the body of your passed out opponent on the ground at the mercy of other potential sexual predators.");
	if (player.findPerk(PerkLib.ManticoreMetabolism) >= 0) {
		if (player.hasStatusEffect(StatusEffects.FeedingEuphoria)) {
			if (player.findPerk(PerkLib.ManticoreMetabolismEvolved) >= 0) {
				if (player.statusEffectv2(StatusEffects.FeedingEuphoria) < (30 + (10 * (1 + player.newGamePlusMod())))) {
					player.addStatusValue(StatusEffects.FeedingEuphoria, 2, 10);
					dynStats("spe", 10);
				}
				player.changeStatusValue(StatusEffects.FeedingEuphoria, 1, 15);
			}
			else {
				if (player.statusEffectv2(StatusEffects.FeedingEuphoria) < 30) {
					player.addStatusValue(StatusEffects.FeedingEuphoria, 2, 10);
					dynStats("spe", 10);
				}
				player.changeStatusValue(StatusEffects.FeedingEuphoria, 1, 10);
			}
		}
		else {
			if (player.findPerk(PerkLib.ManticoreMetabolismEvolved) >= 0) player.createStatusEffect(StatusEffects.FeedingEuphoria, 15, 10, 0, 0);
			else player.createStatusEffect(StatusEffects.FeedingEuphoria, 10, 10, 0, 0);
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

public function alrauneExtraSceneWithHollicyntiaTentacleDuel():void
{
	clearOutput();
	outputText("As you ponder how you will deal with Hollicyntia’s behaviour today, you catch a glimpse of her checking out your vines. Holli seems to be comparing her vines with yours, evaluating size and length thoroughly like a boy in a shower room. As if that upstart could rival your floral perfection!\n\n");
	outputText("\"<i>These are big and healthy, but mine are better!</i>\" she taunts, evidently trying to rile you up.\n\n");
	outputText("Surely not! You bet you could fuck your sister’s brains out before she actually managed to get you off. With confidence you issue her a challenge, your vines raised around you. Here’s the deal, both of you will try to fuck each other silly, and whoever orgasms first loses!\n\n");
	outputText("\"<i>Deal! I will prove to you, dear sister, that my stamens are the best in this garden.</i>\"\n\n");
	outputText("You vines lunge at Holli’s nectar pot as her own zero in on yours, and soon you’re tentacle fucking each other in earnest in an attempt to make the other orgasm first. You start by hammering your stamen in her pussy, but she swiftly counter attacks by blooming her stamen in a dozen tendrils right inside your vagina, each one wriggling independently. Two can play at this game however, and you let out a cloud of pollen, letting it reach her nose and drive her into a lust crazed haze as you ready your other vines. She surprises you by pulling you into a tight embrace, mashing the both of your nectar dripping breasts together. You fuck her ass and grope her breast with your remaining vines, forcing her to restart the offensive with a chest assault of her own.");
	outputText(" The both of you are moaning like wanton whores and lost in sensations by now, but neither of you want to lose to the other in this desperate duel of endurance and sexual skill. Soon your mind is going blank from the vigorous fucking but you don’t care. You won’t allow yourself to orgasm before Holli does. Eventually, unable to hold anymore, the both of you scream your defeat together as your stamens explode, filling each others wombs to the brim. There’s so much liquid pollen pumped into you and you can feel your bloated stomach groan under the pressure. You can’t help but cup it with your hand in motherly delight. Holli isn't looking any better, it will probably take hours for her belly to deflate.\n\n");
	outputText("\"<i>I... want a rematch...No way I'll stop at a tie!</i>\"\n\n");
	outputText("That won’t be today though. You're so packed up with plant cum that without even checking your odds, you're pretty sure you are pregnant. You doubt Holli can hold any more of your pollen either, so you dress back up, highly satisfied and somewhat smug, leaving Holli to her personal frustration.");
	player.orgasm();
	statScreenRefresh();
	player.knockUp(PregnancyStore.PREGNANCY_ALRAUNE, PregnancyStore.INCUBATION_ALRAUNE);
	doNext(camp.returnToCampUseOneHour);
}

	}

}