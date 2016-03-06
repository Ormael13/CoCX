/**
 * Created by aimozg on 03.01.14.
 */
package classes.Scenes.Areas.Plains
{
	import classes.*;
	import classes.GlobalFlags.*;

	public class GnollScene extends BaseContent
	{
		public function GnollScene()
		{
		}

//Gnoll Entrance
		public function gnollEncounter():void
		{
			spriteSelect(11);
			clearOutput();
			outputText("The sound of distant laughter comes across the plains, then seems to die off suddenly.  A moment later, a gnoll comes bounding from the nearest scrap of cover and barrels into you.  The monstrous thing giggles as it bounces back and forth before you, looking for an opening to exploit.", false);
			startCombat(new Gnoll());
		}


//Gnoll Rape
		public function getRapedByGnoll():void
		{
			if (doSFWloss()) return;
			//Oh shit get anal raped.
			if (player.hasItem(consumables.S_DREAM)) {
				yoDawgIHeardULiekGNollBallzzzdahdakjldh();
				return;
			}
			clearOutput();
			outputText("The sound of the gnoll's mocking laughter grates in your ears as you collapse down on your knees before her.  She circles you with the last scrap of her wariness and then surges forward to knock you over, exposing your ", false);
			if (player.hasCock()) {
				outputText(player.multiCockDescriptLight(), false);
				if (player.hasVagina()) outputText(" and ", false);
			}
			if (player.hasVagina()) outputText(player.vaginaDescript(0), false);
			if (player.gender > 0) outputText(".  ", false);
			else outputText("flat, featureless groin.  ", false);
			//  (if cockTotal=0 AND vaginas=1)
			if (!player.hasCock()) {
				if (player.hasVagina()) {
					outputText("The gnoll looks a little disappointed at the void between your legs.  \"<i>Aw, I was hoping for something substantial,</i>\" she titters.  That doesn't stop her from hefting her engorged clit-dick and slapping its tip onto the entrance of your " + player.vaginaDescript(0) + ".  With one jittery lurch forward, she shoves her clit up inside you, her pubic mound mashing up against your " + player.clitDescript() + ".", false);
					player.cuntChange(9, true, true, false);
					outputText("\n\n", false);
				}
				//(if cockTotal=0 AND vaginas=0)
				else outputText("The gnoll actually stops laughing for a moment when she takes in your featureless crotch.  \"<i>Well.  That's a new one,</i>\" she mutters.  She then takes two bobbing steps up the length of your body and rudely shoves her thumb into your mouth.  Her other hand guides her giant clitoris in after it, and you are in no position to stop her.\n\n", false);
			}
			//(if cockTotal>0 AND 
			if (player.cockTotal() > 0) {
				//thickestCock()>2")
				if (player.thickestCockThickness() > 2) {
					//(if cockTotal>1)
					if (player.cockTotal() > 1) outputText("The gnoll fishes into your " + player.multiCockDescriptLight() + " and quickly snaps up the thickest one.  ", false);
					//(if cockTotal=1)
					else outputText("The gnoll's hands dart down to your crotch and grabs " + player.cockDescript(0) + ".  ", false);
					outputText("\"<i>Yes, this will do nicely,</i>\" she says with relish, pumping your " + Appearance.cockNoun(player.cocks[player.thickestCock()].cockType) + " until it plumps up, filling with blood.  She cantilevers her body over yours, knees bent sharply, and brings the tip of her massive clitoris up against the head of your dick.  The moment a dollop of pre forms at your urethra, her hips surge forward, sinking her giant clit down the length of your " + Appearance.cockNoun(player.cocks[player.thickestCock()].cockType) + ".  ", false);
					outputText("You gasp at the feeling of her hot skin rippling down the interior of your dick, and all she can do is laugh as she plunges it deeper and deeper into you.\n\n", false);
				}
				//(if cockTotal>0 AND thickestCock()<2")
				else {
					//(if cockTotal>1)
					if (player.cockTotal() > 1) outputText("\"<i>This will have to do,</i>\" she says with the barest trace of disappointment as she grabs your thickest cock.  ", false);
					//(if cockTotal=1)
					else outputText("\"<i>This will have to do,</i>\" she says as she grabs your cock.  ", false);
					outputText("She runs her rough hand up and down its length until it begins to plump up.  She cantilevers her body over yours, knees bent sharply, and brings the tip of her massive clitoris up against the head of your dick.  The moment a dollop of pre forms at your urethra, her hips surge forward, sinking her giant clit down the length of your " + Appearance.cockNoun(player.cocks[player.thickestCock()].cockType) + ".  ", false);
					outputText("You scream in pain as she forces her bizarre pseudo-penis down the length of your dick.  In horror, you watch as the bulge of her anatomy's invasion of yours slowly descends towards your ", false);
					if (player.balls > 0) outputText("balls", false);
					else outputText("groin", false);
					outputText(".  All she can do is laugh as she plunges it deeper and deeper into you.\n\n", false);
					//(increase thickness of thickestCock())
					player.cocks[player.thickestCock()].cockThickness += .25;
				}
			}
			outputText("In no time whatsoever she falls into an easy rhythm, pistoning her obscene girl-dick in and out of you.  At first, you can do little more than gurgle and squirm under the assault, but all too soon you feel the telltale signs of your own arousal building.  You find yourself moving in sympathy with her thrusts, at least as best you can given the circumstances.", false);
			//(if breastRating>C)
			if (player.biggestTitSize() >= 3) outputText("  Your " + player.allBreastsDescript() + " bounce up and down as the gnoll grinds her anatomy into yours, slick with sweat under the hot sun.  Your " + player.nippleDescript(0) + "s tighten and flush as your whole body submits to the rough fuck administered by the hyena girl.", false);
			//(if cockTotal>0)
			if (player.cockTotal() > 0) {
				outputText("  Your hips begin to buck as your orgasm builds, but the gnoll slams her hands down on your sides, pinning you to the hardscrabble ground.  \"<i>Best if you don't move too much, lover,</i>\" she laughs, even as she quickens her pace.  Immediately your ", false);
				if (player.balls > 0) outputText(player.sackDescript(), false);
				else outputText("body", false);
				outputText(" seizes tighter and you can feel your cum churning inside you.\n\n", false);

				outputText("When you finally explode, the effect is strange but not uncomfortable.  You feel your hot seed surging up out of you, but then it seems to disappear just at the base of your dick.  Blearily you look down at your crotch and see that where your sensation ends is where the tip of her clitoris has penetrated.  You are pumping cum directly into her pseudo-penis.\n\n\"<i>That's it!</i>\" she giggles, bouncing up and down atop you.  \"<i>Give it to momma!  I'll suck the cum right out of you!</i>\"  Finally, just as your own orgasm is fading, the gnoll screams up at the empty sky, her giant clitoris lurching within the confines of your dick.\n\n", false);
			}
			//(if cockTotal<0)
			else {
				outputText("  You squirm in the dirt as your orgasm builds and the gnoll simply giggles.  Heat seems to flash across the length of your body, and then every muscle spasms and twitches all at once.  At the same time, the gnoll screams up at the empty sky, her giant clitoris lurching inside you.\n\n", false);
			}
			outputText("The hyena girl slumps against your body, but only for a moment.  Then she's suddenly up again, sliding her bizarre member out of you with an obscene slurp.  She leans down to pat your cheek and giggles, \"<i>Thanks, lover.</i>\"   Then she sprints off towards the horizon.", false);
			outputText("  A whimper bubbles up your throat and comes out as a half-giggle as you slump down unconscious.", false);
			player.orgasm();
			combat.cleanupAfterCombat();
		}


		public function defeatHyena():void
		{
			clearOutput();
			//Gnoll Defeat (HP)	
			if (monster.HP < 1) outputText("The hyena girl collapses backwards onto the dusty ground, unable to continue the fight.", false);
			//Gnoll Defeat (Lust)
			else outputText("The hyena girl heaves a giant breath and takes a single step backwards.  Her club thumps to the ground and her hands fall to her shaft, stroking along its rough length.", false);

			//Do You Rape The Gnoll?
			if (player.lust >= 33 && flags[kFLAGS.SFW_MODE] <= 0) {
				outputText("  The gnoll is at your mercy.  What will you do with her?");
				menu();
				if (player.hasCock()) {
					addButton(0, "DickDownClit", dickDownGnollClit, null, null, null, "Fuck the gnoll's clit with your penis.", "Dick Down Clit");
					addButton(1, "DickInAss", dickInGnollAss, null, null, null, "Fuck the gnoll's ass with your penis.", "Dick In Ass");
				}
				if (player.hasVagina()) {
					addButton(2, "TakeHerClit", takeGnollClit, null, null, null, "Put your vagina to use and ride the gnoll's clit.", "Take Her Clit");
				}
				addButton(3, "SuckHerClit", suckGnollClit, null, null, null, "Suck the gnoll's clit.", "Suck Her Clit");
				addButton(4, "Leave", combat.cleanupAfterCombat);
			}
			else combat.cleanupAfterCombat();
		}

//DickDownClit
		private function dickDownGnollClit():void
		{
			clearOutput();
			outputText("This is not an opportunity you can pass up.  You roughly roll her onto her back and pull her long clit up to a vertical position.  She moans softly, and the rough skin beneath your fingers pulses as her arousal brings it harder and taller.  The end bloats larger, fuller, until finally it looks nearly wide enough.  You don't wait any further; you position the head of your dick against the end of hers and jam it inside.\n\n", false);
			outputText("Inch by inch, you sink your dick down into the warm tunnel of her monstrous clitoris.  The interior, you are happy to find, is not as rough as the exterior, and in fact is just slick enough to make your invasion possible.  After a few thrusts, you find it easiest to adopt a sort of reverse-cowgirl position, facing her feet as you roll your hips forward and shove more and more of your dick inside her.   Beneath you, the gnoll is clutching at the ground and making little submissive whimpers.\n\n", false);
			var x:Number = player.longestCock();
			//(if biggestCockLength()>9)
			if (player.cocks[x].cockLength > 9) outputText("Finally you can feel your cockhead push free into a deeper, wetter place.  You look down at her strange anatomy, the entire length of her tube bulging thicker to accommodate your " + player.cockDescript(x) + ".  You've made it all the way to her vagina!\n\n", false);
			else outputText("Soon you feel the end of her clitoral tunnel butting up against your crotch.  You are as far in as you'll get.  You look down the length of her strange anatomy, the tube bulging thicker to accomodate your " + player.cockDescript(x) + ".  There are still inches between your cockhead and the end of her clit-dick.\n\n", false);

			outputText("Now you begin to roll your hips in a steady rhythm, running your dick up and down her long clitoral tunnel.  It's like the deepest, tightest cunt you've ever had, gripping every inch of you.", false);
			//(if balls>0)
			if (player.balls > 0) outputText("  It doesn't take long before your " + player.ballsDescriptLight() + " begin twitching, pumping cum down the length of your encased cock.", false);
			outputText("  Your orgasm is quick and hard.  Your entire body seems to tremble under the hot sun and your thrusting doubles and then redoubles, stuffing your dick down hers like mad.\n\n", false);

			//(if cumQ()<25)
			if (player.cumQ() < 25) outputText("Your " + player.cockDescript(x) + " convulses, pumping down the length of her clitoris.  She squirms and howls beneath you, hissing for more.", false);
			//(if cumQ()>25 AND cumQ()<500)
			else if (player.cumQ() < 500) outputText("Your " + player.cockDescript(x) + " convulses, pumping cum into her.  Her clitoris bulges even more as the jism backs up.  The warm, wet, sticky insides swirl around your dick.", false);
			//(if cumQ()>500)
			else outputText("Your " + player.cockDescript(x) + " convulses, pouring cum into her.  Her clitoris bulges even more as the jism backs up, the skin pulling tight and shiny as the pressure builds.  Finally gouts of cum begin spurting back out the tip of her clitoris, splashing against your crotch.", false);
			outputText("  With a lusty groan, you pull out with a long, slippery sound, and leave the gnoll panting on the dusty ground.", false);
			player.orgasm();
			combat.cleanupAfterCombat();
		}

//DickInAss
		private function dickInGnollAss():void
		{
			clearOutput();
			var x:Number = player.cockThatFits(monster.analCapacity());
			if (x < 0) x = 0;
			var y:Number = player.cockThatFits2(monster.analCapacity());
			if (rand(2) == 0) {
				outputText("The gnoll must be taught a lesson, but you're staying the hell away from her freaky anatomy.  You roughly roll her onto her belly and pull her lean ass up into the air.  You line up your " + player.cockDescript(x) + " and ram it home into her tiny puckered entrance, eliciting a half-conscious gasp from the hyena girl.\n\n", false);
				//(if cockTotal>1)
				if (player.totalCocks() > 1 && player.cockArea(x) < monster.analCapacity() && y != -1) {
					outputText("With a smirk, you pound away for a few minutes to get her loosened up.  Then you reach down and slap another " + Appearance.cockNoun(CockTypesEnum.HUMAN) + " alongside the first.  With a grunt and a thrust, you shove both of them inside.", false);
					//(if cockTotal>2)
					if (player.totalCocks() > 2 && player.cockArea(x) + player.cockArea(y) < monster.analCapacity()) outputText("  A few thrusts more, and you slow again.  As you gather up your third cock, the gnoll whimpers quietly, fearing what she knows will come next.  You slowly push forward, sinking your rigid meat into her ass.  When all three are in, it's very slow going, but you don't let up.", false);
					//(if cockTotal>3)
					if (player.cockTotal() > 3 && player.cockArea(0) + player.cockArea(1) + player.cockArea(2) < monster.analCapacity()) outputText("  From there it's some time before her anus is stretched wide enough for more.  By now you can feel your orgasm on the horizon, so you're less careful with your fourth " + player.cockDescript(y) + ".  You slap it into the bundle of dicks and then ram it home.", false);
					//(if cockTotal>4)
					if (player.cockTotal() > 4 && player.cockArea(0) + player.cockArea(1) + player.cockArea(2) + player.cockArea(3) < monster.analCapacity()) outputText("  And then the next.", false);
					//(if cockTotal>5)
					if (player.cockTotal() > 5 && player.cockArea(0) + player.cockArea(1) + player.cockArea(2) + player.cockArea(4) + player.cockArea(5) < monster.analCapacity()) outputText("  And the next.", false);
					//(if cockTotal>6)
					if (player.cockTotal() > 6 && player.cockArea(0) + player.cockArea(1) + player.cockArea(2) + player.cockArea(4) + player.cockArea(5) + player.cockArea(6) < monster.analCapacity()) outputText("  And the next, until all of your " + player.multiCockDescriptLight() + " are inside her wide-spread ass.", false);
					outputText("\n\n", false);
				}

				outputText("\"<i>So how do you like it?</i>\" you grunt, \"<i>when a little too much is shoved up a hole that's a little too small?</i>\"  You pound away, hard and rough, until her cries turn into squeals and then into moans.  Finally, she simply passes out.  You slap your hips against her bony ass for a few more thrusts and cum, long and hard, into her rectum.\n\n", false);

				outputText("You let her slump to the ground, leaking your cum into the sun-caked ground, and head home.", false);
			}
			else {
				outputText("Your mind is made up; this gnoll needs to learn her place.  You eye her freakish pseudo-phallus for a moment, then shake your head, roughly grabbing her by the bony hips and flopping her onto her belly.  She lets out a little barking whine when you firmly smack her bony rear, lowering her chin to the ground and raising her hips submissively in recognition of your dominance.\n\n", false);

				outputText("You stroke your " + player.cockDescript(x) + " eagerly, bringing yourself to full mast and squeezing out a few drops of pre to pool against her puckered anus, leaning over and adding a little bit of saliva for good measure.  Sliding your shaft between her flat ass cheeks, you make sure to get the tip nice and lubed up, then you drop her hips down and ram yourself home in one go.\n\n", false);

				outputText("The gnoll lets out a squeal that sounds halfway like a maniacal laugh, sliding forward in the dirt a little.  Your " + player.cockDescript(x) + " throbs wonderfully, fully engulfed by the tight passage of the gnoll's anus", false);
				if (player.cockTotal() > 1) outputText(" while the remainder of your endowments slide along her bare buttocks", false);
				outputText(", and you begin to thrust forward and back, digging your fingers into her hips.\n\n", false);

				outputText("As the defeated gnoll resigns herself fully to her role as your willing cum dump, you decide to really take her for a ride, pulling yourself back until you are almost free of the tightness of her rectum, then dropping forward again until you impact her ass with your hips.  You pull yourself back and ram home again and again, feeling the gnoll's tight asshole loosen a little bit with each thrust.  The force with which you are pounding the poor savannah girl's rear has her odd endowments slapping up against her stomach with each thrust, and from the cackling moans issuing from her throat, you can only guess that she enjoys being dominated in some capacity.\n\n", false);

				outputText("Your hands slide further down her sides, and you bear down on her as you feel your climax building.  Increasing momentum, you piston into her ass with a desperate vigor, moaning your animalistic pleasure into her ear", false);
				if (player.cumQ() >= 500) outputText(" as your voluminous pre-cum turns her innards into a sloppy fuckhole", false);
				outputText(".\n\n", false);

				//(Low cumQ):
				if (player.cumQ() <= 250) {
					outputText("Pressing your fingertips into her sides, you let out a moan into the open air, spurting cum deep and hard into her warm rectum", false);
					if (player.cockTotal() > 1) {
						outputText(" while your other endowment", false);
						if (player.cockTotal() > 2) outputText("s soak", false);
						else outputText(" soaks", false);
						outputText(" her back and rear with a few sticky streams", false);
					}
					outputText(".  You pull out with an audible *schlick!*, and the gnoll slumps forward to the ground, panting a bit as she begins to shamelessly play with herself.\n\n", false);
				}
				//Med CumQ):
				else if (player.cumQ() <= 500) {
					outputText("Gripping her sides tightly, you let out a bellowing moan that echos through the grasslands, " + player.sMultiCockDesc() + " swelling noticeably as you pump thick ribbons of spunk into the gnoll's innards", false);
					if (player.cockTotal() > 1) outputText(", unleashing a torrent of semen that mats down the short fur on her back and rear as", false);
					outputText(".  The muscular ring of her anus bears down on your " + player.cockDescript(x) + " as you pull out, making an audible *schlick!*, and the gnoll drops to the ground in exhaustion, shamelessly playing with herself in an effort to get off.\n\n", false);
				}
				//(High CumQ):
				else {
					outputText("You bear down on the limber hyena girl with all your force, groaning through clenched teeth as " + player.sMultiCockDesc() + " distends with the pressure of your virile load.  Her puckered anus stretches around the swell of your seed, and she lets out a shuddering, laughing moan as her belly begins to distend with your thick jism.  The involuntary spasms of her rectum milk your " + player.cockDescript(x) + " for every drop, clenching your member tightly", false);
					if (player.cockTotal() > 1) {
						if (player.cockTotal() > 2) outputText(" while your remaining endowments soak her back thoroughly, covering her in a thick blanket of spunk", false);
						else outputText(" while your remaining endowment soaks her back thoroughly, covering her in a thick blanket of spunk", false);
					}
					outputText(".  Her anus makes an audible *schlick!* as you pull back, and the gnoll rolls off your member, cradling her gravid, cum-filled belly as she begins to shamelessly finger herself.\n\n", false);
				}
				outputText("Satisfied, you leave the gnoll to her pleasures, gather your " + player.armorName + ", and head back to camp.", false);
			}
			player.orgasm();
			combat.cleanupAfterCombat();
		}

//SuckHerClit
		private function suckGnollClit():void
		{
			clearOutput();
			outputText("Since you first saw this strange anatomy, you knew it needed to be inside you.  You roughly roll her onto her back and pull her long clit up to a vertical position.  She moans softly, and the rough skin beneath your fingers pulses as her arousal brings it harder and taller.  The end bloats larger and fuller, until it might be too wide for your purposes.  Without losing any more time, you lean forward and stuff the clit's end into your mouth.\n\n", false);
			outputText("The gnoll yelps in surprise and then moans appreciatively as your mouth and tongue roam across her sensitive skin.  Her hips squirm against the hard-baked dirt, tentatively pushing her clit deeper into your mouth.\n\n", false);
			outputText("You're only too happy to oblige her, slowly and carefully swallowing the strange member down your throat.  Inch by inch you draw it deeper into yourself, eliciting increasing groans from the hyena girl.  Finally your nose buries itself in the rough, curly hair of her crotch, your chin rubbing up against the fake scrotum formed out of her distorted labia.\n\n", false);
			outputText("Her legs twitch around your ears as you continue to swallow, even though there is no more to go.  The muscles in your throat gently massage the length of the monstrous clitoris, which plumps even further as more blood rushes into it.  You can feel its tumescent bulk all down your throat and halfway into your chest.\n\n", false);
			outputText("The massive clit-dick then begins to flutter and twitch as the gnoll starts to cum.  Her feet stamp the ground to either side of you and she abruptly screams into the sky.  Her warbling cry then seems to collapse inward, and her entire body slumps to the ground, unconscious.\n\n", false);
			outputText("You leave her there on the sun-caked ground and head back to camp.", false);
			dynStats("lus=", player.maxLust());
			combat.cleanupAfterCombat();
		}

//TakeHerClit
		private function takeGnollClit():void
		{
			clearOutput();
			outputText("You roughly roll her onto her back and pull her long clit up to a vertical position.  She moans softly, and the rough skin beneath your fingers pulses as her arousal brings it harder and taller.  The end bloats larger, fuller, until it might be too wide for your purposes.  You line up your " + player.vaginaDescript(0) + " and lower yourself onto the long, narrow faux-cock.", false);
			player.cuntChange(9, true, true, false);
			outputText("\n\n", false);
			outputText("It slithers up your love canal with alacrity, and you quickly find yourself sitting on the gnoll's haunches.  You pump your hips up and down, relishing the feel of the thin spike slipping around within you.  This was not, however, what her anatomy was designed to do, and you can feel her monstrous clitoris flagging within you, collapsing down and denying you your well-deserved fucking.\n\n", false);
			outputText("\"<i>Hey!</i>\" you shout, and reach forward to slap the gnoll across the face.  Abruptly the clit-dick hardens inside you, even as the girl's face registers little response.  With a smirk, you try it again.  A second hard slap brings the hyena's pseudocock ramrod straight up inside you, and you roll your hips atop her appreciatively.\n\n", false);
			outputText("Every few strokes, the fake dick starts to fail you and you reach forward to slap her again.  Pump pump slap.  Thrust thrust smack.  Grunt grunt slap.  By the time your body rises up to the quivering summit of orgasm, the gnoll's face is purple with bruises.  You scream your orgasm to the sky, bearing down hard on her hollow clitoris, and come hard enough that you see stars.\n\n", false);
			outputText("When you can get your feet under yourself again, you stand up, letting the now-shrunken clitoris fall out of your " + player.vaginaDescript(0) + " with a wet plop.  You leave her there on the sun-caked ground and head back to camp.", false);
			player.orgasm();
			combat.cleanupAfterCombat();
		}

		internal function yoDawgIHeardULiekGNollBallzzzdahdakjldh():void
		{
			clearOutput();
			player.consumeItem(consumables.S_DREAM);
			//[either Gnoll loss, if the player has a succubi's dream in inventory]

			outputText("A rolling, harsh laughter surrounds you as you sink to ground, no longer strong enough to remain upright.  The gnoll's mocking bark fills the air as she disposes of your " + player.armorName, false);
			if (player.weaponName != "fists") outputText(" and " + player.weaponName, false);
			outputText(" with rough motions, the soft pads of her paw-like hands coarsely grasping your " + player.hipDescript() + " as much to grope as to strip you.  As she knocks your belongings aside, a small, bulbous bottle rolls out of your pouches, the lurid white fluid sloshing inside like an alabaster stain against the dull browns and greens of the plains.  The hyena-girl pauses in her eagerness to taste the spoils of victory, regarding the stray vial doubtfully.  Her lips curl into a sneer that approaches a smile and she stoops down to retrieve the creamy flask.  Through the panting haze obscuring your vision, you can make out the murky whorls of curious thickness in the cum-colored elixir and you realize that the amazon has found your Succubi's Dream.\n\n", false);

			outputText("You try to protest the theft, but she casually snaps her leg into a kick that jerks your chin up and the ground rushes to meet the back of your head, white pain exploding before your eyes.  \"<i>All that you have and all that you are belongs to me,</i>\" the hyena-woman snarls.  \"<i>I will take what tribute I see fit.</i>\"  Laughing again, she flicks the cork from your potion and sniffs the concoction with renewed interest.  Her nostrils crinkle at the scent, but she locks her gaze to yours and, in an aggressive, unblinking gesture, throws her head back to swallow the curiously thick ivory fluid.  Discarding the empty glass, she licks her lips as if the refreshingly cool cream merely inflamed a different sort of thirst.\n\n", false);

			outputText("The amazon takes another step toward you before jerking back with a choking gasp.  Her stance drooping, knees clenched together, the hyena-girl wraps her hands between the inside of her trembling thighs.  The tattered loincloth hanging from her hips pokes outward, rising as it is gradually pushed aside by the monster beneath.  She flicks the rough leather aside with a spotted paw to expose the engorged onyx pillar throbbing between her legs.  Rising from a thin sheath, the 15 inch clit stands atop her molted pussy like a crown-less cock, bulging veins marring its obsidian-smooth surface as it pulses with the girl's quickening heartbeat.  She sways, seemingly weakened by the lascivious lust boiling inside her, bringing a deep purple hue to her cheeks as she flushes half with embarrassment and half with need.\n\n", false);

			outputText("\"<i>What... what have you poisoned me with?</i>\" she gasps, staggering to her knees.  Catching herself, the gnoll pulls her hands away from her crotch, revealing the effects of the Succubi's Dream.  A pair of huge, apple-sized testicles sway under her throbbing pussy lips, covered in a fine chocolate fuzz that glistens from the honey that leaks from her over-stimulated cunt.  The hyena's balls hang heavily from her groin, achingly filled with seed that she has no way of emptying.  \"<i>What is this?</i>\" she demands, her voice frantic with seething, unfamiliar urges.  \"<i>I don't... I can't...</i>\" She stumbles to all fours, her hips impotently bucking at the air, as her eyes cloud over, mouth hanging open in the primal need to mate.\n\n", false);
			//[NEXT]
			doNext(yoDawgHyenaBallz2);
		}

		private function yoDawgHyenaBallz2():void
		{
			clearOutput();
			outputText("Using the distraction, you roll onto your belly, crawling towards your " + player.armorName + ", hoping to use the distraction to make an escape.  Baring your " + player.buttDescript() + ", however, proves to be a mistake, as the gnoll fixates on the wobbling orbs, lunging desperately.  She lands atop you, her paws pinning your head and shoulders to the ground as the warmth of her impatient shaft slides between your cheeks, her new scrotum slapping wetly against ", false);
			if (player.balls > 0) outputText("your own " + player.ballsDescriptLight(), false);
			else outputText("your sweat-slick thighs", false);
			outputText(".  The amazon wastes no time, guiding her monstrous clit to your " + player.assholeDescript() + " with gasping pleasure, thrusting the barrel-like pseudo-cock deeply inside your nethers, drawing a cry of penetration from your lips.  The plush interior of your anus parts before her energized clitoris, her cunt flowing with warm lubrication so heavily that its deluge inundates your bowels like a flood of pre-cum.", false);
			player.buttChange(30, true, true, false);
			outputText("\n\n", false);

			outputText("Roughly, she bucks against your hips, pushing your face against the grass and dirt, moving with relentless speed as she fucks you with every ounce of strength in her well-toned body.  She snarls and cries out, even laughing with a mad desperation, as she plunges her rock-hard joy buzzer into your loins trying to achieve release.  Your struggles are useless against the rutting passion of the hyena-girl, who uses you like a beast in heat.  In mere minutes, her body seizes, muscles straining with the blissful throes of imminent orgasm and you whisper a prayer that she'll be done shortly.  Gnashing her teeth, she hooks both spotted paws around your shoulders and drives her jet-black member into the velvet folds of your clenching asshole, her sweltering cunny gushing with her girl-cum.\n\n", false);

			outputText("Her bucking pauses for a split-second and you can feel her fuzzy balls throbbing against your " + player.buttDescript() + ", the stimulation of her fucking filling them with fresh loads, eager to spill into your violated hole.  But, without a passage to let loose the torrent of her sperm with, the gnoll's balls merely swell with unspent passion, lewdly quivering against", false);
			if (player.balls > 0) outputText(" your distended sac, ballooning with the fatigued flood of the prostate-milking the girl is giving you", false);
			else outputText(" your sore loins, soaked with the slimy river of the girl's excitement", false);
			outputText(".  \"<i>N-no! I can't... quite... arg!</i>\" She trembles, unable to cum, before mindlessly starting anew, pistoning into your " + player.assholeDescript() + " with renewed vigor.  \"<i>I just! Have to! Fucking! Cum!</i>\" she grunts from between clenched teeth as she slams into you, the waterfall of lubrication from her pussy soaking your " + player.skinFurScales() + " as she wetly slaps her hips into yours in her increasingly desperate assault.\n\n", false);

			outputText("Again and again, she rushes toward a release, and every time, her balls slosh with overflowing lust, unable to climax yet urging her to greater depravity until even words are too difficult to manage.  Your ravaged body aches under the endless rape.  It's all you can do to work your hands under your hips to masturbate in the blissful pauses while the gnoll's muscles clench in near orgasm, before she slams you back to the dirt for another round.  You lose track of time as your world narrows to the endlessly thrusting shaft of the hyena-girl's massive clitoris and the merciless weight of her ball-slapping, spunk-swollen pouch. Every time you climax, it fuels her mad frenzy until you silently beg your body to shut out the overwhelming sensations, to no avail.  Day fades into night and night into day as the amazon fucks your spasming, shuddering pucker without thought, or pity, or release.\n\n", false);
			//[NEXT]
			doNext(yoDawgHyenaBallz3);
			model.time.hours = 7;
			model.time.days++;
			statScreenRefresh();
		}

		private function yoDawgHyenaBallz3():void
		{
			clearOutput();
			outputText("Finally, you feel the gnoll's clit slide out of your anus as the overly-endowed girl collapses at your side.  Broken utterly, she pants with depraved exhaustion, no strength left to continue pounding your body into the dirt.  Even now, she strokes her massive clit with one spotted paw as the other helplessly massages the basketball-sized testicles that audibly churn with gallons of the girl's jizz.  Finding a reserve of strength you didn't know you had, you rise tenderly and gather your belongings, creeping away before the hyena-girl can get her second wind.", false);
			//[24 hours pass, player asshole size increased, sensitivity significantly lowered, toughness lowered temporarily, fatigue maxed, remove one succubi's dream]
			player.orgasm();
			dynStats("lib", 2, "sen", -10);
			combat.cleanupAfterCombat();
		}

		/*
		 --------------------

		 Hyena Spot Long Description
		 A patch of what appears to be hyena fur, with a large black spot in its center.  There's no hide backing to the fur; there's no discernable reason the clump of fur stays together at all.

		 Hyena Spot Consume
		 You fumble with the patch of fur for a moment, then rub it across your skin.  It flakes and sheds as you go, until finally it dissolves away into nothing.  Beneath your skin it feels as if the hot sun has baked into your flesh.

		 Hyena Spot Effect #1
		 (if clitLength>0)
		 The spot's heat seems to focus on your crotch.  Your scalding clit seems to spill out of your vulva, lengthening at least half an inch.
		 (increase clitLength)

		 Hyena Spot Effect #2
		 (if hipRating>0)
		 You cry out as your pelvis suddenly cave inward, crumpling narrower at the top of your legs to form " + player.hipDescript()
		 (decrease hipRating)

		 Hyena Spot Effect #3
		 (if buttRating>0)
		 You seem to bounce on your feet as you drop a few pounds in your rear.  With your new, light " + player.buttDescript() + ", you feel like you can fly across the plains.
		 (decrease buttRating)

		 Hyena Spot Effect #4
		 Your muscles seem to quiver underneath your " + skinDescript() + ", growing leaner and quicker.
		 (increase Speed)

		 Hyena Spot Effect #5
		 (if skin =/= spotted fur)
		 The warmth rippling under your skin seems to erupt back outwards, pushing out a pelt of rough, tawny fur.  Black spots blossom across your shoulders and back.  You have hyena fur!
		 (set skin to hyena fur)

		 Hyena Spot Effect #6
		 (if Tone<90)
		 The warm swirls around inside your body, seeming to melt away fat deposits wherever they lie.  Your body takes on a much leaner, toned appearance.
		 (increase Tone)*/
	}
}
