/**
 * Created by aimozg on 04.01.14.
 */
package classes.Scenes.Areas.Mountain
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;

	public class InfestedHellhoundScene extends BaseContent
	{
		public function InfestedHellhoundScene()
		{
		}

		//[INTRO – 50% chance split with regular hellhound if worms
		//turned on and over level 2]
		public function infestedHellhoundEncounter():void
		{
			clearOutput();
			outputText("A low snarl vibrates through your body, ", false);
			if (player.lowerBody == LOWER_BODY_TYPE_GOO) outputText("making your jello-like body jiggle", false);
			else outputText("rattling your teeth", false);
			outputText(".  Peeking fearfully over your shoulder, you see the black-furred form of a hell-hound emerging from behind a rock.  Its eyes narrow as its gaze locks onto your " + player.assholeOrPussy() + ", a pair of black, shiny dog-cocks emerge underneath him, dangling freely.  His balls look bloated and distended, the skin around them crawling and wriggling.  A few worms drip from its over-sized peckers, crawling on the ground under the infested beast.\n\n", false);
			outputText("Somehow you know this thing isn't going to let you just walk away.", false);
			if (flags[kFLAGS.CODEX_ENTRY_HELLHOUNDS] <= 0) {
				flags[kFLAGS.CODEX_ENTRY_HELLHOUNDS] = 1;
				outputText("\n\n<b>New codex entry unlocked: Hellhounds!</b>")
			}
			startCombat(new InfestedHellhound());
			spriteSelect(27);
		}


		public function infestedHellhoundLossRape():void
		{
			if (flags[kFLAGS.SFW_MODE] > 0 && getGame().inCombat) { //No rape in SFW mode.
				clearOutput();
				combat.cleanupAfterCombat();
				return;
			}
			clearOutput();
			//[BOTH INFESTED]
			if (player.totalCocks() > 0 && player.findStatusEffect(StatusEffects.Infested) >= 0) {
				//(LUST)
				if (player.lust >= player.maxLust()) {
					outputText("No amount of shame from the act of submitting to such a beast can overpower the furnace of lust raging in your loins.  ", false);
					if (player.cor < 33) outputText("In spite of your revulsion ", false);
					else if (player.cor < 66) outputText("In spite of your better sense ", false);
					else outputText("With a perverse sense of anticipation ", false);
					outputText("you remove your " + player.armorName + " and roll onto your back, exposing your vulnerable groin to the beast.\n\n", false);
				}
				//(HP) 
				else outputText("Too wounded to stand, you drop down to all fours in order to keep yourself off the ground.   Too late you realize your mistake – the snarling beast is behind you and its razor-sharp teeth easily sink into your " + player.armorName + " before tearing away the offending armor, exposing your " + player.assDescript() + " and " + player.multiCockDescriptLight() + ".  A cold mountain breeze blows across your now-exposed " + player.skinDesc + ", reminding you just how utterly vulnerable you are to the alien lusts of this symbiotic monstrosity. With a brutal lunge it knocks you off your " + player.feet() + " and onto your back.\n\n", false);

				outputText("The beast takes a sniff at your groin, then backs away, looking confused.  You glance down and realize just how hard you've become.  A few of your worms are hanging from the " + player.cockHead() + " of your " + player.cockDescript(0) + ", starting to flow out in a steady stream.  It feels better than it has any right to.   A shadow falls across you as the hellhound moves over you, its imposing twin members hard and pulsating above you.  Hot splatters of jism drip onto your chest as the beast's worms begin escaping, forcing thick globules of dog-semen out along with them.\n\n", false);

				outputText("Overcome by the worms, both you and the beast begin orgasming, without external stimulation of any kind.  Worms and cum mix together on top of you, slowly building into a large mound that covers the better part of your torso.  Exhausted and drained, you both squirt weakly, emptying the last of your smallest worms into the pile.   Your eyes close as the beast lies down with you, and together the two of you lose consciousness as your newly birthed worm colony squirms away.", false);
				player.orgasm();
				dynStats("lib", 1, "sen", 1, "cor", 1);
				player.cumMultiplier += .5;
				combat.cleanupAfterCombat();
			}
			//[PLAYER'S COCKS ARE BIG ENOUGH TO BE INFECTED]
			else if (player.findStatusEffect(StatusEffects.Infested) < 0 && player.biggestCockArea() >= 40 && player.hasCock()) {
				//(LUST)
				if (player.lust >= player.maxLust()) {
					outputText("No amount of shame from the act of submitting to such a beast can overpower the furnace of lust raging in your loins.  ", false);
					if (player.cor < 33) outputText("In spite of your revulsion ", false);
					else if (player.cor < 66) outputText("In spite of your better sense ", false);
					else outputText("With a perverse sense of anticipation ", false);
					outputText("you remove your " + player.armorName + " and roll onto your back, exposing your vulnerable groin to the beast.\n\n", false);
				}
				//(HP)
				else {
					outputText("Too wounded to stand, you drop down to all fours in order to keep yourself off the ground.   Too late you realize your mistake – the snarling beast is behind you and its razor-shark teeth easily sink into your " + player.armorName + " before tearing it off, exposing your " + player.assDescript() + " and " + player.multiCockDescriptLight() + ".  A cold mountain breeze blows across your now exposed " + player.skinDesc + ", reminding you just how utterly vulnerable you are to the alien lusts of this symbiotic monstrosity.  With a brutal lunge it knocks you off your " + player.feet() + " and onto your back.\n\n", false);
				}
				if (player.totalCocks() > 1) {
					outputText("The infested hound repositions itself, blocking out the sun with its dark fur, leaving you with only the pale flames surrounding its fuzzy sack to look at.   The warm wetness of its smooth tongue starts sliding over ", false);
					outputText("each of your " + player.multiCockDescriptLight() + ".  It feels good, better than it has any right to.  ", false);
					outputText("Every single one of your " + player.multiCockDescriptLight() + " hardens under the stimulation, happy to be so well-treated.\n\n", false);

					outputText("Stopping its licking, the beast begins to shuffle forwards, pre-cum coated worms plopping out of its double-dicks onto your belly.  They crawl lamely around as the beast works to line itself up, though you're unsure what it could possibly be aiming for.  Your questions are answered as the slightly pointed tips of its twin members press forwards, bumping against the crowns of your own cocks.   It pushes forward with an intense sort of care, slowly forcing itself into your urethras, dribbling painfully hot cum directly into your cock-passages.\n\n", false);

					outputText("Gods, it's shoving its infected cocks up your urethras!  It's trying to infect you with those worms!  The dog-demon keeps pushing further and further, sliding deep inside you, the outline of its members easily visible through the skin of your " + player.multiCockDescriptLight() + ".  It starts feeling good, the wriggling parasite-infested dicks begin sliding in and out, fucking your urethras in earnest and depositing their wormy cargo deep inside you.\n\n", false);

					outputText("Your ", false);
					if (player.balls > 0) outputText(player.ballsDescriptLight() + " shiver as hot doggie-cum and wiggling worms are pumped directly into them.  ", false);
					else outputText("body feels uncomfortably full as hot doggie-cum and wriggling worms are pumped directly into your prostate.  ", false);
					outputText("Despite the strange freakishness of the situation, you find yourself getting off on having so many wriggling forms stuffed inside you.  The thickness of a large obstruction working its way down your urethra prevents your orgasm from taking you anywhere, but you feel the pleasure and pressure all the same.  Your body clenches and writhes under the beast, a helpless slave to the unholy pleasures being forced upon you.\n\n", false);

					outputText("The demonic dog backs away with what looks like a grin on its face after filling you with worms and boiling spooge, your urethras stretched and dripping with white squirming goop.  Pushed beyond your endurance, you start blacking out, your last thought a lamentation on how you'll be a carrier for these parasites, just like this demon-dog.", false);
				}
				else {
					outputText("The infested hound repositions itself, blocking out the sun with its dark fur, leaving you with only the pale flames surrounding its fuzzy sack to look at.   The warm wetness of its smooth tongue starts sliding over ", false);
					outputText("your " + player.multiCockDescriptLight() + ".  It feels good, better than it has any right to.  ", false);
					outputText("Your " + player.multiCockDescriptLight() + " hardens under the stimulation, happy to be so well-treated.\n\n", false);

					outputText("Stopping its licking, the beast begins to shuffle forwards, pre-cum coated worms plopping out of its double-dicks onto your belly.  They crawl lamely around as the beast works to line itself up, though you're unsure what it could possibly be aiming for.  Your questions are answered as the slightly pointed tip of one of its twin-members presses forward, bumping against your " + player.cockHead() + ".   It pushes forward with an intense sort of care, slowly forcing itself into your urethra, dribbling painfully hot cum directly into your cock-passage and dripping the stuff all over your groin.\n\n", false);

					outputText("Gods, it's shoving its infected cock up your urethra!  It's trying to infect you with those worms!  The dog-demon keeps pushing further and further, sliding deep inside you, the outline of its member easily visible through the skin of your " + player.multiCockDescriptLight() + ".  It starts feeling good, the wriggling parasite-infested dick begins sliding in and out, fucking your urethra in earnest and depositing its wormy cargo deep inside you.\n\n", false);

					outputText("Your ", false);
					if (player.balls > 0) outputText(player.ballsDescriptLight() + " shiver as hot doggie-cum and wiggling worms are pumped directly into them.", false);
					else outputText("body feels uncomfortably full as hot doggie-cum and wriggling worms are pumped directly into your prostate.", false);
					outputText("Despite the strange freakishness of the situation, you find yourself getting off on having so many moving forms stuffed inside you.  The thickness of a large obstruction working its way down your urethra prevents your orgasm from taking you anywhere, but you feel the pleasure and pressure all the same.  Your body clenches and writhes under the beast, a helpless slave to the unholy pleasures being forced upon you as the dog-demon's exposed member drops a huge worm into the wet puddle on your crotch.  You're horrified when you realize that a similar worm must be making its way inside you now.\n\n", false);

					outputText("The demonic dog backs away with what looks like a grin on its face after filling you with worms and boiling spooge, your urethra stretched and dripping with white squirming goop.  Pushed beyond your endurance, you start blacking out, your last thought a lamentation on how you'll be a carrier for these parasites, just like this demon-dog.", false);
				}
				//(+infested)
				player.createStatusEffect(StatusEffects.Infested, 0, 0, 0, 0);
				player.orgasm();
				dynStats("lib", 1, "sen", 1, "cor", 1);
				player.cumMultiplier += .2;
				if (flags[kFLAGS.EVER_INFESTED] == 0) {
					flags[kFLAGS.EVER_INFESTED] = 1;
					if (player.cor < 25) player.cor = 25;
				}
				combat.cleanupAfterCombat();
			}
			//[HAS PUSSY AND NO DICK BIG ENOUGH TO BE INFECTED]
			else if (player.hasVagina() && player.biggestCockArea() < 40 && player.lowerBody != LOWER_BODY_TYPE_NAGA) {
				//(LUST) 
				if (player.lust >= player.maxLust()) {
					outputText("No amount of shame from the act of submitting to such a beast can overpower the furnace of lust raging in your loins.  ", false);
					if (player.cor < 33) outputText("In spite of your revulsion ", false);
					else if (player.cor < 66) outputText("In spite of your better sense ", false);
					else outputText("With a perverse sense of anticipation ", false);
					outputText("you remove your " + player.armorName + " and drop to all fours, mimicking what you think a dog would do.\n\n", false);
				}
				//(HP) 
				else {
					outputText("Too wounded to stand, you drop down to all fours in order to keep yourself off the ground.   Too late you realize your mistake – the snarling beast is behind you and its razor-shark teeth easily sink into your " + player.armorName + " before tearing it off, exposing your " + player.assDescript() + " and " + player.vaginaDescript(0) + ".  A cold mountain breeze blows across your now exposed " + player.skinDesc + ", reminding you just how utterly exposed you are to the alien lusts of this symbiotic monstrosity.\n\n", false);
				}
				outputText("The hell-hound rises up, looking nearly humanoid in shape for a moment before it drops down, planting its paws on your shoulders.  ", false);

				if (player.cor < 66) outputText("You beg, \"<i>Please, no, no!  I don't want them... in me!</i>\"\n\n", false);
				else outputText("You start to beg it not to put them inside you, but your protests drop off when you realize how good they could feel squirming inside you.\n\n", false);

				outputText("The demon-dog tries to double-penetrate you all at once, but it isn't lined up properly, and all it manages to do is bump against your taint and drag its main member across your labia.   You gasp in pain, momentarily thankful not to be impaled by such bestial implements, but knowing all too well the brief reprieve will be over all too soon.   As if it can read your thoughts, the beast on top of you repositions itself and slams forward, this time managing to line its two dog-dicks up to your holes correctly.  The pair of them feel far larger than they looked, filling you with a painful suddenness that brings tears to your eyes.\n\n", false);
				outputText("Incredible heat radiates from the pair of rods inside you, making your whole body break out in a cold sweat in an attempt to deal with the situation.  You're rocked back and forth as the beast begins fucking you in earnest, slamming its fur-covered hips against your " + player.assDescript() + " with animalistic intensity.  Thankfully, the fucking isn't that painful, but the small mercy is ruined by the hot fluid you can feel starting to pour into you.\n\n", false);

				outputText("Oh gods no, you can feel something squirming inside you!  It's dripping worms into your intestines and pussy!   Its hot spittle drips onto your back as it ruts hard and fast, spurting and dripping a small portion of its wormy cargo inside you.  They're wriggling and squirming around, rubbing you in such an obscene way, bringing you closer and closer to orgasm in spite of the budding horror gnawing at your gut.   The beast on your back seems oblivious to it all, pushing more roughly into your " + player.vaginaDescript(0) + " and " + player.assholeDescript() + " with every stroke until with a burst of pressure, he manages to bottom out both of his throbbing, black fuck-sticks at once.\n\n", false);

				outputText("It's so wrong... but so hot.  He's filling you with them!  The fucking hell-mutt is cumming and plugging both your holes full of his parasitic cargo!  Gods, you're filled with wriggling worms, squirming and writhing against your tender cunt-walls and rectum.   You're getting fuller and fuller, and the spooge they're swimming in is so fucking hot it practically burns you.  You cum hard, clamping down on the invading members, and squealing with a mix of pain and pleasure, driven beyond rational thought by the absurdity and pleasure of the situation.\n\n", false);

				outputText("Unable to support yourself any longer, you collapse, your hips held up by the pair of demonic black dog-dicks lodged in your orifices.  They keep cumming and cumming, until your body takes a slow slide off to the ground.  Your eyes drift closed, lulled to sleep by the squirming warmth plugging both your holes.  ", false);
				player.cuntChange(monster.cockArea(0), true);
				outputText("  ", false);
				player.buttChange(monster.cockArea(0), true);
				//(Status applied – worm plugged) – 
				//random chance of big lust boost as worms evacuate 
				//your body.  When worms leave they take with them up 
				//to 5 fertility, to a minimum of 10. 
				if (player.findStatusEffect(StatusEffects.WormPlugged) >= 0)
					player.addStatusValue(StatusEffects.WormPlugged, 1, 1 + rand(5));
				else
					player.createStatusEffect(StatusEffects.WormPlugged, 1 + rand(5), 0, 0, 0);
				player.knockUpForce(PregnancyStore.PREGNANCY_WORM_STUFFED, 100 + player.statusEffectv1(StatusEffects.WormPlugged)); //Will be cleared when the WormPlugged effect ends
				player.orgasm();
				dynStats("lib", 1, "cor", 1);
				combat.cleanupAfterCombat();
			}
			//[GENDERLESS OR MALE WITH DICK TOO SMALL]
			else {
				//(LUST) 
				if (player.lust >= player.maxLust()) {
					outputText("No amount of shame from the act of submitting to such a beast can overpower the furnace of lust raging in your loins.  ", false);
					if (player.cor < 33) outputText("In spite of your revulsion ", false);
					else if (player.cor < 66) outputText("In spite of your better sense ", false);
					else outputText("With a perverse sense of anticipation ", false);
					outputText("you remove your " + player.armorName + " and drop to your elbows, mimicking what you think a dog would do.\n\n", false);
				}
				//(HP) 
				else {
					outputText("Too wounded to stand, you drop down to on your elbows in order to keep yourself off the ground.   Too late you realize your mistake – the snarling beast is behind you and its razor-shark teeth easily sink into your " + player.armorName + " before tearing it off, exposing your " + player.assDescript() + ".  A cold mountain breeze blows across your now exposed " + player.skinDesc + ", reminding you just how utterly exposed you are to the alien lusts of this symbiotic monstrosity.\n\n", false);
				}
				outputText("The hell-hound rises up, looking nearly humanoid in shape for a moment before it drops down, planting its paws on your shoulders.  ", false);
				if (player.cor < 80) outputText("You beg, \"<i>Please, no, no!  I don't want it... in me!</i>\"\n\n", false);
				else outputText("You start to beg it not to put it inside you, but your protests drop off when you realize how good they could feel squirming inside you.\n\n", false);

				outputText("The demon-dog tries to penetrate you all at once, but it isn't lined up properly, and all it manages to do is bump against your taint and rub its other dick on your back.   You gasp in pain, momentarily thankful not to be impaled by such a bestial implement, but knowing all too well the brief reprieve will be over all too soon.   As if it can read your thoughts, the demon-hound repositions itself and slams forward, this time managing to line its dog-dicks up with your " + player.assholeDescript() + " correctly.  It feels far larger than it looked, filling you with a painful suddenness that brings tears to your eyes.\n\n", false);
				outputText("Incredible heat radiates from the thick black rod inside you, making your whole body break out in a cold sweat in an attempt to deal with the situation.  You're rocked back and forth as the beast begins fucking you in earnest, slamming its fur-covered hips against your " + player.assDescript() + " with animalistic intensity.  Thankfully, the fucking isn't that painful, but the small mercy is ruined by the hot fluid you can feel starting to pour into your " + player.assholeDescript() + " and onto your back.\n\n", false);

				outputText("Oh gods no, you can feel something squirming inside you!  It's dripping worms into your intestines!   Its hot spittle and doggie-cum drips onto your back as it ruts hard and fast, spurting and dripping a small portion of its wormy cargo inside you.  They're wriggling and squirming around, rubbing you in such an obscene way, bringing you closer and closer to orgasm in spite of the budding horror gnawing at your gut.   The beast on your back seems oblivious to it all, pushing more roughly into your " + player.assholeDescript() + " with every stroke until with a burst of pressure, he manages to bottom out his throbbing, black fuck-stick.\n\n", false);

				outputText("It's so wrong... but so hot.  He's filling you with them!  The fucking hell-mutt is cumming and plugging your hole full of his parasitic cargo while he paints your back with even more of them!  Gods, you're filled with wriggling worms, squirming and writhing against your rectum.   You're getting fuller and fuller, and the spooge they're swimming in is so fucking hot it practically burns you.  You cum hard, clamping down on the invading member, and squealing with a mix of pain and pleasure, driven beyond rational thought by the absurdity and pleasure of the situation.\n\n", false);

				outputText("Unable to support yourself any longer, you collapse, your hips held up by the demonic black dog-dick lodged in your orifice.  They keep cumming and cumming, until your body takes a slow slide off to the ground.  Your eyes drift closed, lulled to sleep by the squirming warmth plugging your " + player.assholeDescript() + " and coating your back.", false);
				outputText("  ", false);
				player.buttChange(monster.cockArea(0), true);
				player.orgasm();
				dynStats("lib", 1, "cor", 1);
				combat.cleanupAfterCombat();
			}
		}
	}
}
