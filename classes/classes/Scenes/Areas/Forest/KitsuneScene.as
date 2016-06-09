/**
 * Created by aimozg on 04.01.14.
 */
package classes.Scenes.Areas.Forest
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.Items.Armors.LustyMaidensArmor;
	import classes.Scenes.Monsters.Imp;

	public class KitsuneScene extends BaseContent
	{
		public function KitsuneScene()
		{
		}

//const MANSION_VISITED:int = 626;
//const redheadIsFuta:int = 627;
//const MET_KITSUNES:int = 628;
//const KITSUNE_SHRINE_VISIT:int = 708;
//const TOOK_KITSUNE_STATUE:int = 709;


		private function kitsuneSprite():void
		{
			if (monster.hairColor == "blonde") spriteSelect(105);
			else if (monster.hairColor == "black") spriteSelect(104);
			else spriteSelect(106);
		}

//[Enter the Trickster] (Coded)
		public function enterTheTrickster():void
		{
			if (flags[kFLAGS.MET_KITSUNES] > 0) {
				willOWisp();
				return;
			}
			clearOutput();
			outputText("\"<i>H-help!</i>\"\n\n");
			outputText("You turn with a start as a woman bursts through the bushes, flinging herself into your arms.  It looks like she's been roughed up a bit - her simple peasant's robes are torn and frayed, and her forehead has a few smudges where it appears as though she was dragged through the dirt.\n\n");
			outputText("\"<i>Th-thank goodness!  Please, you must help me!</i>\"  she cries, darting around to take shelter behind you.  \"<i>I was out picking wild berries, and, and...  the wretched, terrible little things attacked me!</i>\"\n\n");
			outputText("You are about to question her, but are interrupted as an imp flies out of the thicket, growling and clawing at you menacingly.  At least...  clearly it's <i>trying</i> to be menacing.  The melodramatic display comes off as more hilarious than anything, but the woman cowering behind you obviously feels threatened, so you might as well deal with the pest.");
			// -> Standard Imp Battle
			startCombat(new Imp());
			monster.createStatusEffect(StatusEffects.KitsuneFight, 0, 0, 0, 0);
			doNext(playerMenu);
			flags[kFLAGS.MET_KITSUNES]++;
		}

//Lose:
		public function loseKitsuneImpFight():void
		{
			clearOutput();
			//randomly assign hair color
			if (rand(3) == 0) monster.hairColor = "blonde";
			else if (rand(2) == 0) monster.hairColor = "black";
			else monster.hairColor = "red";
			kitsuneSprite();
			outputText("As you fall to the ground in defeat, you look up to see the imp standing over you.  You prepare yourself for the worst, but are surprised to see the vile creature disappear in a puff of blue flames.\n\n");
			outputText("\"<i>Well...  that was...  easier than I thought.  Kind of boring, actually.</i>\"\n\n");
			outputText("The woman from earlier bends low over you, smiling bemusedly.  Before your eyes, her face, body, and clothing all begin to shift form.  Clad in a set of loose, revealing robes, she brushes her " + monster.hairColor + " hair out of her face, reaching up to straighten out her large triangular fox ears.  Six lustrous, bushy tails sway from side to side behind her, drawing your gaze hypnotically, and a generous layer of ornate tattoos follow the curves of her body.\n\n");
			outputText("\"<i>My, my, you're kind of a pushover, aren't you?</i>\"  she remarks, grinning precociously.  \"<i>Well, hopefully you make for a better snack than you do a bodyguard.</i>\"");
			// -> Go to standard kitsune loss scenes
			menu();
			addButton(0, "Next", loseToKitsunes);
		}

//Win:
		public function winKitsuneImpFight():void
		{
			clearOutput();
			//randomly assign hair color
			if (rand(3) == 0) monster.hairColor = "blonde";
			else if (rand(2) == 0) monster.hairColor = "black";
			else monster.hairColor = "red";
			kitsuneSprite();
			outputText("\"<i>Oh, thank you, thank you!  I don't know </i>what<i> would have happened if you hadn't come along.</i>\"\n\n" + ((player.cor < 50) ? "As the imp falls at your feet, you lower your [weapon] and turn to the grateful woman.  Beating down an imp is really nothing special, but you were glad to be of assistance, and tell her as much with a friendly smile." : "You scoff haughtily, lowering your [weapon] and turning to the woman.  Beating down an imp was hardly worth your time, you tell her, crossing your arms in irritation.") + "\n\n");
			outputText("\"<i>My hero!</i>\"  she swoons, beaming.  \"<i>Oh, if there's </i>anything<i> I can do to repay you, please, tell me!</i>\"\n\n");
			outputText("You find yourself gazing deep into her eyes, a dim haze entering your mind as you are drawn deeper and deeper into the glistening green pools.  The corners of her lips curl into a broad smile as she starts to step toward you, and for a moment you swear you can see a subtle change in her.  You rub your eyes, certain they are playing tricks on you, slowly following the gentle sway of her six tails as she strolls up to you." + ( ((player.lust > 70) || (player.inte < 40)) ? "  Nope, nothing wrong here...\n\n\"<i>Mm...  my hero...</i>\" she croons again, reaching up to caress your cheek." : "\n\nWait.") + "\n\n");
			//PC saw through glamour
			if ((player.lust < 70) || (player.inte >= 40)) {
				outputText("You push her away, almost cracking your head open as you stumble over a stump.  Now that you have broken free of her sorcery, you can see her for what she is.  A pair of large triangular fox ears poke up from her ");
				if (monster.hairColor == "blonde") outputText("back-length, flaxen");
				else if (monster.hairColor == "black") outputText("ass-length, raven");
				else outputText("shoulder-length, crimson");
				outputText(" hair, six luxuriously furred tails fanning out behind her.\n\n");

				outputText("\"<i>So, you saw through my glamour did you?  That's quite impressive...</i>\" she says, teasing you with her tails.  You back away from her, but give a start and wheel around when you feel yourself bump into something.");
				// -> Go to <i>"Going Somewhere?</i>\"
				doNext(createCallBackFunction(followTheWillOWisp, true));
			}//PC did NOT see through glamour
			//With Religious BG:
			else if (player.findPerk(PerkLib.HistoryReligious) >= 0) {
				outputText("The instant she touches you, she recoils with a yelp, a brilliant flash temporarily blinding you both.\n\n");
				outputText("\"<i>Ow, ow, ow!</i>\"\n\n");
				outputText("When the spots clear from your eyes, the kitsune's glamour has been dispelled, revealing her for what she truly is.  A pair of large triangular fox ears poke up from her ");
				if (monster.hairColor == "blonde") outputText("back-length, flaxen");
				else if (monster.hairColor == "black") outputText("ass-length, raven");
				else outputText("shoulder-length, crimson");
				outputText(" hair, six luxuriously furred tails fanning out behind her.  A layer of ornate tattoos covers patches of her exposed flesh, accentuating her feminine curves nicely.\n\n");

				outputText("\"<i>So, you saw through my glamour did you?  That's quite impressive...</i>\" she says, teasing you with her tails.  You back away from her, but give a start and wheel around when you feel yourself bump into something.");
				// -> Go to <i>"Going Somewhere?</i>\"
				doNext(createCallBackFunction(followTheWillOWisp, true));
			}
			//Else:
			else {
				outputText("Her touch sends involuntary tingles down your spine, and you are drawn ever deeper into her eyes.  She trails a finger along your chin, slipping away from you and beckoning for you to follow her.  Your " + player.legs() + " move with a mind of their own, dragging you along after her as she leads you down a winding path into the darkness.");
				// -> Go to "She leads you deeper and deeper into..."
				doNext(createCallBackFunction2(mansion,true, true));
			}
		}


//[Will 'O Wisp](C)
		private function willOWisp():void
		{
			clearOutput();
			//randomly assign hair color
			if (rand(3) == 0) monster.hairColor = "blonde";
			else if (rand(2) == 0) monster.hairColor = "black";
			else monster.hairColor = "red";
			kitsuneSprite();
			//>[Explore Deep Forest] after encountering "Enter the Trickster"
			outputText("As you explore deeper into the dense wood, you are abruptly aware that your surroundings have grown darker without warning.  The back of your neck tingles lightly with a sense of foreboding, and you instinctively ready your [weapon], feeling uneasy.  Wracked with paranoia, you find yourself swiveling to face toward every random noise, and you could <i>swear</i> you just heard a voice through the trees.  There it was again!  As the ghostly, feminine laughter fills your ears, you are positive that it can't just be your imagination.  You turn left, then right, trying to pinpoint its source, but it truly sounds as though it is all around you now.\n\n");
			outputText("Catching a glimpse of motion out of the corner of your eye, you whip around to face it, but are surprised to see that the only thing there is a small, pale blue flame, flitting about idly.  It dances around hypnotically, and as you stare into its ghostly light, you find your conscious mind growing hazy.  Your concerns suddenly seem trivial, and you find yourself relaxing gradually as the ethereal wisp glides along your arms, leaving behind a cool tingle where it touches you.\n\n");
			outputText("It seems to be beckoning you to follow it.");
			//If player has Traveler's Guide
			if (player.hasKeyItem("Traveler's Guide") >= 0) {
				outputText("\n\nYour mind is jogged out of its haze when you remember a note from the Traveler's Guide.  It warned about mysterious flames in the forest that lead hapless adventurers astray.  You hesitate now, wondering what to do.");
				//[Turn Back] [Follow] //automatically follow without traveler's guide.
				simpleChoices("Turn Back", turnBackFromWillOWisp, "Follow", followTheWillOWisp, "", null, "", null, "", null);
			}
			else doNext(followTheWillOWisp);
		}

//[Turn Back] (C)
		private function turnBackFromWillOWisp():void
		{
			clearOutput();
			outputText("There's no way you're going to go gallivanting off into the woods after some flame.  You shake your head to clear your thoughts, and warily turn away to head back toward camp.  You could almost swear for a moment the flame looked disappointed, and you chuckle lightly at such a silly thought.");
			//Advance time 1 hour, return to camp.
			if (getGame().inCombat) combat.cleanupAfterCombat();
			doNext(camp.returnToCampUseOneHour);
		}

//[Follow] (C)
		private function followTheWillOWisp(firstTime:Boolean = false):void
		{
			clearOutput();
			if (!firstTime) {
				outputText("The flame suddenly darts off into the darkness of the trees, and you find yourself unable to resist giving chase.  It feels as though you are being drawn to it by some otherworldly force, but every time your suspicions begin to grow, the flame pauses to float around you, tickling your erogenous zones and then pressing onward.");
				//+15 Lust
				dynStats("lus", 15);
			}
			if ((player.lust >= player.maxLust() || player.inte < 20) && !firstTime) {
				mansion(false, false);
			}
			//Else:
			else {
				kitsuneSprite();
				if (!firstTime) {
					outputText("You are unsure of how long you have been stumbling after the flame, but in a brief moment of clarity, you stop dead in your tracks and look around cautiously.  Suddenly you deeply regret having followed the flame this far out of your way.  Your skin crawls as you hear that eerie, ghostly laughter once again, making you shudder involuntarily.  As you turn to head back the way you came, you practically jump out of your " + player.skinFurScales() + " in surprise.  Mere inches from you stands a strange woman with ");
					if (monster.hairColor == "blonde") outputText("back-length, flaxen");
					else if (monster.hairColor == "black") outputText("ass-length, raven");
					else outputText("shoulder-length, crimson");
					outputText(" hair, smirking precociously.\n\n");
					outputText("\"<i>My, my, aren't we the clever one?</i>\"\n\n");
					outputText("As she closes the gap even more, you now notice that she isn't any ordinary woman - a pair of large, vulpine ears parts her hair at the top of her head, and six luxuriously furred tails fan out around her.  A layer of ornate tattoos covers patches of her exposed flesh, accentuating her feminine curves nicely.  She's so close now that a few of the tails are drifting along your " + player.skinFurScales() + ", leaving a trail of crackling blue sparks that impart the same cool tingling that the flame did.\n\n");
					outputText("\"<i>You resisted my illusions...  that's impressive,</i>\" she says, teasing you with her tails.  You back away from her, but give a start and wheel around when you feel yourself bump into something.\n\n");
				}
				outputText("\"<i>Going somewhere?</i>\"\n\n");

				outputText("How did she get behind you so quickly?  You were staring at her the entire time!  Glancing quickly over your shoulder, you confirm that this is not a case of twins, but when you turn to face her, she has disappeared once again!\n\n");
				outputText("\"<i>Over here, silly~</i>\" she calls to you with a mischievous tone, beckoning to you as you whip around to face her voice.  \"<i>Don't be shy, I don't bite...  often...</i>\"\n\n");
				outputText("Her tone is innocuous enough, but her mannerisms are a little disconcerting, somehow.  What are you going to do?");
				if (!getGame().inCombat) simpleChoices("Fight", fightSomeKitsunes, "Talk", talkAfterResistingKitsunellusion, "", null, "", null, "", null);
				else simpleChoices("Fight", fightSomeKitsunes, "Talk", talkAfterResistingKitsunellusion, "", null, "", null, "", null);
			}
		}


//[Talk] (C)
		private function talkAfterResistingKitsunellusion():void
		{
			clearOutput();
			kitsuneSprite();
			outputText("Odd as she is, she doesn't seem to be overtly threatening, so you decide to try to talk to her.  Searching for something to say, you end up simply asking her why she led you here.\n\n");

			//Blonde
			if (monster.hairColor == "blonde") {
				outputText("\"<i>Oh, that's not important, dear,</i>\" she says with a sly grin.  \"<i>You're here now, that's what's important...</i>\"\n\n");
				outputText("Since the conversation began, she has been watching you with a hungry look, strolling around you casually.  Every now and again she leans in, caressing you with her tails and giving you a decent angle down the front of her skimpy robes.\n\n");
			}
			//Black Hair
			else if (monster.hairColor == "black") {
				outputText("You blink, and she is upon you, her index finger circling its way across your chest.  She is practically hanging off of you as she says, \"<i>You're the catch of the day, cutie!  Mm-mm, and such a tasty-looking morsel.</i>\"\n\n");
				outputText("You're not sure whether to feel insulted or terrified at the prospect of her calling you food, so you settle on a mixture of the two.  Your eyes are drawn to her, though, as she strolls around, caressing you with her tails and leaning in to tease you with her ample bosom.\n\n");
			}
			//Redhead
			else {
				outputText("\"<i>Ah!  You caught me,</i>\" she says, feigning embarrassment.  \"<i>It's just so deliciously adorable the way you mortals stumble around in the woods...  I can hardly resist!</i>\"\n\n");
				outputText("\n\nYou cast her a dirty look, feeling slightly offended, but she brushes you off with a sly grin.  She strolls around you casually, her tails slipping in under your " + player.armorName + " and tickling your erogenous zones while she teases you with a glance down the front of her skimpy robes.\n\n");
			}
			//MERGE
			outputText("You twist away, trying to shake off the tingling sensations that are crawling across your body, impairing your ability to think rationally.\n\n");
			outputText("\"<i>Oh, you're no fun,</i>\" she says, smirking a bit as you pull away.  \"<i>Won't you come and play?  I promise that you won't be disappointed... my sisters and I will see to that.</i>\"\n\n");
			outputText("Self-preservation battles with curiosity " + ((player.lust > 50) ? "and lust " : "" ) + "as you consider her offer, " + ((player.lib < 50) ? "weighing your chances against the possible dangers." : "eying the voluptuous curves that fill out her robes."));

			//[Follow { mansion(willing = true) }] [Leave]
			simpleChoices("Follow", createCallBackFunction2(mansion,true, false), "", null, "", null, "", null, "Leave", createCallBackFunction(leaveKitsune,true));
		}

//[Leave] (C)
		private function leaveKitsune(talked:Boolean = false):void
		{
			clearOutput();
			kitsuneSprite();
			//if PC was Talking to the kitsune
			if (talked) outputText("Nervously, you thank her for her generous offer, but decline, turning to leave.");
			//if PC defeated her in combat
			else outputText("You turn to leave, ready to put some distance between yourself and the fallen trickster.");
			//MERGE:
			outputText("\n\n\"<i>Don't leave yet,</i>\" you hear as you turn, stopping dead when you almost bump into her.  She's done it again, popping up right in front of you with no warning.\n\n");
			outputText("\"<i>I have something for you...</i>\"\n\n");

			outputText("She holds out a small white package tied with string, grinning eagerly.  You hesitate, wondering whether it would be wise to take a gift from this strange woman, but before you can protest, she shoves the package into your hands.  When you look up from the featureless wrapping, there is no sign of her save for the echo of a mischievous giggle through the trees.\n\n");
			outputText("<b>You have received a Kitsune's Gift!</b>\n");
			if (getGame().inCombat) {
				flags[kFLAGS.BONUS_ITEM_AFTER_COMBAT_ID] = consumables.KITGIFT.id;
				combat.cleanupAfterCombat();
			}
			else {
				//add Kitsune's Gift to inventory
				inventory.takeItem(consumables.KITGIFT, camp.returnToCampUseOneHour);
			}
		}

//Illusory Mansion (C)
		private function mansion(willing:Boolean, firstTime:Boolean = false):void
		{
			clearOutput();
			kitsuneSprite();
			if (willing) {
				if (!firstTime) outputText("Curiosity and lust get the better of you, and you decide to throw caution to the wind and take her up on her offer.  If her sisters are any bit as stunning as she is, then you know you're in for a real treat.  She seems pleased with your decision, teasing the underside of your chin with one of her tails and beckoning you to follow her.\n\n");
				//next
				outputText("She leads you deeper and deeper into the woods, and before long night has fallen.  Thankfully your guide has summoned up a number of pale flames that light your way.  As you peer into the darkness beyond their range, you realize it is now too late to change your mind - even if you wanted to turn back, you would most certainly get lost.\n\n");
				outputText("The kitsune stops for a moment, turning back to face you, and then disappears into the bushes with a girlish giggle.  You briefly fear that she has abandoned you in the wilderness, but as you break through the other side of the untamed hedge after her, you nearly smack face-first into a large stone wall.  Before you lies an imposing mansion, surrounded on all sides by the impressive wall.  You briefly wonder what sort of madman would build such an extravagant home in the middle of nowhere, but are broken out of your reverie when you spot the kitsune peering out from the gate, waving to you flirtatiously.\n\n");
			}
			else {
				outputText("The hypnotic power of the flame compels you to follow it for hours, shambling through the woods in a daze.  The sky overhead has grown dark, and though every fiber of your being wills you to resist the wisp's temptation, your body simply refuses to listen.  You only vaguely register crossing the threshold of a large wooden gate, feeling like an observer outside your own body.  An imposing mansion lies before you, and what remains of your rational mind briefly wonders what sort of madman would build such an extravagant dwelling in the middle of nowhere.\n\n");
			}
			//MERGE:
			outputText("\"<i>Welcome");
			if (flags[kFLAGS.MANSION_VISITED] > 0) outputText(" back");
			outputText(",</i>\" you hear as you enter the courtyard, startling you a little.  There to greet you at the mansion's door stands ");
			if (flags[kFLAGS.MANSION_VISITED] > 0) outputText("the trio of familiar kitsune sisters.");
			else {
				outputText("a trio of lovely maidens -");
				if (willing) outputText(" including the one that led you here,");
				outputText(" a blonde, a redhead, and one with silky black hair.  Their revealing robes are filled out in all the right places, hugging their enticing curves.  Each of them sports a pair of large fox ears and a cluster of luxuriously soft tails that wave hypnotically.");
			}
			if (willing) outputText("\n\n\"<i>We've been expecting you,</i>\" the blonde one says, stepping forward with a flirtatious grin.");
			else {
				if (flags[kFLAGS.MANSION_VISITED] > 0) {
					if (player.fatigue < 70) outputText("\n\n\"<i>We're all so thrilled you decided to come see us once again!</i>\"");
					else outputText("\n\n\"<i>You know, if you keep coming back like this, we just might have to keep you...</i>\"");
				}
				else outputText("\n\n\"<i>I'm so glad you decided to come with me...</i>\"");
			}
			flags[kFLAGS.MANSION_VISITED]++;
			outputText("\n\n");

			outputText("The three ladies close in around you, running their hands over your body and giggling lightly.  You find yourself practically floating among their many tails, drunk on the promise of pleasure as they lead you through the foyer.  They sit you down in front of a long table with a spectacularly opulent spread, and before long you are having your fill of delicacies the likes of which you never dared to dream about.\n\n");
			outputText("Your cup never remains empty for long, as one of the sisters is always quick to arrive with a fresh decanter.  The strong alcohol burns your throat as it goes down, and it does not take much before your head is swimming.  You have grown so tipsy by now that you don't even register as the girls usher you out of the dining room, only noticing your change of scenery as you feel yourself being pulled down into a warm pool of water.\n\n");
			//next
			doNext(createCallBackFunction2(nonTentaclePCMansion,willing));
		}

//NON-TENTACLE PC SCENES:
		private function nonTentaclePCMansion(willing:Boolean):void
		{
			clearOutput();
			kitsuneSprite();
			outputText("\"<i>We hope you enjoyed the feast we prepared,</i>\" says the one with jet-black hair, as she and her sisters crowd around you in the water, fully nude.  \"<i>Now, it's </i>our<i> turn.</i>\"\n\n");
			outputText("\"<i>Just relax,</i>\" the redhead whispers into your ear in a warm tone that seems to demolish any vestige of resistance.  \"<i>We'll take care of everything...</i>\"  Up to your waist in the warm water of the hot springs, you can't help but surrender to their will, your worries flowing out of you.  Enveloped on all sides by their unearthly warm flesh, you lean into their arms and sigh blissfully as every touch and caress sends shivers down your spine.\n\n");
			if (player.countCocksOfType(CockTypesEnum.TENTACLE) >= 3) {
				doNext(tentacleKitsuneWingWangs);
			}
			else {
				if (player.hasCock())  doNext(createCallBackFunction(kitsuneMaleOrHermMansion,willing));
				else doNext(createCallBackFunction(kitsuneFemaleOrGenderless, willing));
			}
		}

//Formerly maleOrHerm()
		private function kitsuneMaleOrHermMansion(willing:Boolean):void
		{
			clearOutput();
			kitsuneSprite();
			outputText("\"<i>Let's just see what we have here,</i>\" the blonde says, sliding herself up to gently lift [eachCock] while licking her lips.  \"<i>Oh my, such vigor!</i>\"  the blonde exclaims, eagerly watching your " + ((player.cocks.length > 1) ? "shafts swell to their" : "shaft swell to its") + " full length and girth after just a little bit of stroking from her skillful hands.\n\n");
			outputText("Soft, velvety fur caresses your erogenous zones, more tails than you can count wrapping around every limb as plush lips kiss your exposed flesh.  Tongues of blue flame spark to life with a crackle like striking flint, licking along your body, sending ripples of pleasure coursing through you with every touch, drawing out more lust with each passing second.\n\n");
			outputText("Three tails envelop [eachCock], squeezing " + ((player.cocks.length > 1) ? "them" : "it") + " tightly, while several more constrict your limbs, binding you helplessly.  Your liquor-addled mind is too foggy by now to resist their advances, their disarming caresses breaking down your inhibitions and replacing them with lust and desire.  In unison, the fluffy appendages begin to pump up and down while the sisters continue to lavish you with affection, running their fingers " + ((player.hairLength > 0) ? "through your hair" : "across your scalp") + " sensually and teasing your neck with small, affectionate nips.\n\n");
			outputText("\"<i>Now for the main course...</i>\" the raven-haired kitsune whispers into your ear, gently nibbling on the outer edge.\n\n");
			outputText("The three tails recede from [eachCock] with an agonizing slowness as the black-haired girl lowers the voluptuous globes of her ass down against your " + player.cockDescript(player.biggestCockIndex()) + ".  Her hips rise and fall slowly, teasing the underside of your cock with the silky soft flesh of her rear, and the sight of her tattooed hindquarters gently cradling your prick sends fresh blood to your groin.  Your pleasure is only amplified when the blonde begins to stroke and knead it, casting you a sultry smirk as she lowers her lips toward the " + player.cockHead(player.biggestCockIndex()) + ".  Her soft tongue slides warmly along the top edge, traveling from base to tip and back again, each and every movement carefully measured and controlled to tease and excite you.\n\n");
			outputText("Her sensual licks send you into a spiral of pleasure, breaking through your intoxicated haze.  Overcome by lust, you lurch forward in a drunken lunge, bowling the trio over with a lecherous grin.  They yelp with surprise, laughing as you stumble into them, but as you come crashing down into the water on top they easily adjust to their new role, catching you in a net woven of silky tails and spreading their arms invitingly.\n\n");
			outputText("\"<i>Oh, you </i>beast<i>!</i>\"  the blonde cries teasingly, dragging her nails gently down the front of your [chest] with the snapping pop of sparks issuing from her fingertips.\n\n");
			outputText("You hike her up by the hips, hands travelling down across the gloriously wide curves and reaching around to grope her pillowy behind.  Her sisters crowd in around you, pressing their sizeable breasts against you and giggling coyly as their hands slowly travel up and down your sides.  As the redhead presses herself against you, you can feel a warm bulge pulsing against your " + player.hipDescript() + ".  You look down to find that she possesses a special something extra that her sisters seem to be lacking - and from the devilish grin on her face, you have an inkling of what she intends to do with it.\n\n");
			if (willing) {
				outputText("<b>How do you respond?</b>");
				// display choices:
				//["Let Her" ] ["Shove Her" ]
				simpleChoices("Let Her", createCallBackFunction(kitSuneLetHerMansion,willing),
						"Shove Her", createCallBackFunction(kitsuneShoveHerMansion, willing), "", null, "", null, "", null);
			}
			else {
				doNext(createCallBackFunction(kitSuneLetHerMansion,true));
			}
		}

// end function
//fomerly letHer()
		private function kitSuneLetHerMansion(willing:Boolean = true):void
		{
			clearOutput();
			kitsuneSprite();
			outputText(((willing) ? "You decide to let her have her fun, focusing your attention instead on her two lovely sisters.  While you were distracted with the redhead's \"assets\", it appears the precocious blonde and ravenette went ahead and started without you!" : "Your slurred protests fall on deaf ears, your head swimming with the haze of the many decanters of liquor you imbibed.  You move to push her away, but she catches your tipsy assault and gently leans up to give you a disarming peck on the cheek.  Though you try to mentally cling to the dispute, you find your cares gradually slipping away, until all you can focus on is the girl's two sisters, who appear to have started without you.") + "  The black-haired girl lies back, her face buried deep in the rippling flesh of the blonde's behind, slurping away at her dripping folds, while the blonde reciprocates from on top, pounding her sister's puffy pussy with her first two fingers.\n\n");
			outputText("The blonde's prodigious posterior bounces and jiggles as she pumps her hips up and down instinctively.  The quivering cheeks entice you, drawing you in almost hypnotizingly, and before you know it your " + player.cockDescript(player.biggestCockIndex()) + " is already " + ((player.balls > 0) ? "balls" : "hip") + "-deep in her slippery snatch.\n\n");
			outputText("The voluptuous fox-woman groans in pleasure as your " + player.cockDescript(player.biggestCockIndex()) + " plunges into her deepest fathoms, her warm flesh enveloping your hot prick and squeezing tightly as a rush of feminine fluids spills over the black-haired girl's face." + ((player.biggestCockArea() > 50) ? "  Her folds seem to stretch forever, swallowing your engorged tool like a bottomless pit of warmth and pleasure." : "") + "  Your hands sink deep into the pillowy mounds of her mountainous ass, mashing them together as you knead her cheeks like warm dough.\n\n");
			outputText("Slender fingers close around your " + player.hipDescript() + " as the redhead pulls herself tight against your [butt], attempting to line up against you while your pelvis mashes wildly against her sister's rippling rump.  Her cock slides up between your cheeks, dripping pre-cum that tingles on your flesh, and she finally manages to align herself to your ");
			if (player.gender >= 2) outputText(player.vaginaDescript());
			else outputText(player.assholeDescript());
			outputText(" and thrust in, spearing you on twelve inches of throbbing futa rod.  Buried to the hilt in your ");
			if (player.gender == 1) outputText("hindquarters");
			else outputText("warm folds");
			outputText(", she wraps her arms around you and drags her fingertips down your [chest], trailing azure sparks the entire way.");
			if (player.gender == 1) player.buttChange(14, true, true, false);
			else player.cuntChange(14, true, true, false);
			outputText("\n\n");
			outputText("Sandwiched between the two amorous kitsune, you shudder in pleasure, feeling the blonde's slick pussy squeeze and milk along your length while the redhead bucks up against your twitching hips with an animalistic fervor.  You feel something slick sliding along the " + ((player.hasSheath()) ? "sheath" : "base" ) + " of your " + player.cockDescript(player.biggestCockIndex()) + ", the black-haired kitsune's long tongue wrapping around and slurping the blonde's juices off of it hungrily." + ((player.balls > 0) ? "  Her pillowy lips press up against your " + player.ballsDescriptLight() + " lovingly, slurping loudly and humming through them with glee." : "") + "\n\n");
			outputText("The redhead's hands massage your lower body sensually, ");

			if (player.cocks.length > 1) {
				outputText("her palms caressing ");
				outputText("your remaining " + num2Text(player.cocks.length - 1) + " cock");
				if (player.cockTotal() > 2) outputText("s");
				outputText(" and squeezing tightly");
			}
			else outputText("circling your navel with her index finger and hugging her perky breasts into your back");
			outputText(" as she continues to pump into you forcefully.\n\n");

			outputText("The blonde's tight passage squeezes your rod tightly, holding you inside with a muscular contraction that forces you to slow your thrusting.  Her powerful pussy muscles release you abruptly, a wash of slippery fem juice rushing out around your " + player.cockDescript(player.biggestCockIndex()) + " to soak her sister's face.  The raven-haired girl laps it up happily, then retaliates by throwing her legs up around the blonde's neck and pulling her down into her crotch, making a wonderfully lewd face as the girl goes to work eating her out.\n\n");
			outputText("The redhead's pulsating member begins to throb and twitch in your ");
			if (player.gender >= 2) outputText(player.vaginaDescript());
			else outputText(player.assholeDescript());
			outputText(" as she builds up toward her climax.  You are nearing your limit as well, the act of holding back your own rising release causing your muscles to constrict around her swollen cock.  The forceful contractions of your ");
			if (player.gender >= 2) outputText("cunt");
			else outputText("rectum");
			outputText(" around her shaft sends her over the edge, and she begins to groan loudly in your ear, digging her fingertips into your " + player.hipDescript() + ".  Her turgid rod trembles in your ");
			if (player.gender >= 2) outputText(player.vaginaDescript());
			else outputText(player.assholeDescript());
			outputText(", a thick bulge passing through the shaft and erupting into your ");
			if (player.gender >= 2) outputText("slippery hole");
			else outputText("innards");
			outputText(" forcefully.  The thick cum hits your ");
			if (player.gender >= 2) outputText("womb");
			else outputText("intestines");
			outputText(" like ice water, then quickly turns into an aching warmth, sending shivers up your spine as the cloying seed rushes into your belly.  Your abdomen starts to expand into a bulging belly, the sloshing seed stuffing your insides and choking your passage with futa-sperm as she outpours a truly inhuman amount of jizz into you.\n\n");
			outputText("The pleasant pressure in your expanding belly pushes your pleasure to new extremes, and you begin mashing your pelvis into the blonde's quivering ass cheeks in pursuit of your glorious release." + ((player.biggestCockArea() > 80) ? "  She lurches forward, her fingers clawing at the wooden deck that runs along the edge of the pool, her entire body heaving with pleasure." : "  As you feel the coiling spring in your lower body near its limit, you suddenly feel the redhead's hand wrap around your " + player.cockDescript(player.biggestCockIndex()) + ".  She slyly leans over your shoulder, raising a finger to her lips and whispering to you, \"<i>Shh...</i>\"\n\nWithout warning, she yanks you back, pulling you from the blonde's quivering cunt just as you begin to climax, adjusting the angle quickly and bucking her hips forward to slam your twitching shaft into the blonde's ass!  The soft ring of her anus yields to the invasion with surprising ease, spreading open as if by reflex and then clamping shut around your base when your hips make contact with her quivering cheeks again.  She lurches forward, releasing a surprised gasp and nearly collapsing under your compulsory anal assault, her entire body heaving with a combination of shock and pleasure.") + "\n\n");
			if (player.cumQ() <= 150)
				outputText("A few virile streams spurt into her, sloppily smearing her " + ((player.biggestCockArea() > 80) ? "passage" : "intestines") + " with your thick load.  Her inner muscles squeeze you involuntarily, a deep crimson blush spreading across her cheeks as a thick spray of girlcum erupts from her pussy.  It splatters over the black-haired girl's face, and she opens her mouth to catch it all, pressing her plump lips against her sister's quivering cunt and drinking deeply as she hums a satisfied melody into her clitoris.");
			else if (player.cumQ() <= 350) outputText("Numerous streams spurt into her, sloppily smearing her tunnel with your thick load.  Her inner muscles squeeze you greedily, massaging your shaft to draw your seed " + ((player.biggestCockArea() > 80) ? "toward her convulsing womb." : "deeper into her convulsing bowels.") + "  A deep crimson blush spreads across her cheeks as a thick spray of girlcum erupts from her pussy, splattering over the black-haired girl's face, and she opens her mouth to catch it all, pressing her plump lips against her sister's quivering cunt and drinking deeply as she hums a satisfied melody into her clitoris.");
			else if (player.cumQ() <= 1000) outputText("Thick ribbons of cum spurt into her, sloppily smearing her " + ((player.biggestCockArea() > 80) ? "passage" : "intestines") + " with your potent load.  Her inner muscles squeeze you greedily, massaging your shaft to draw your seed " + ((player.biggestCockArea() > 80) ? "toward her convulsing womb.  Her pussy" : "deeper into her convulsing bowels.  Her rectum") + " clenches involuntarily as your cloying seed erupts into her " + ((player.biggestCockArea() > 80) ? "quivering cunt and floods her passage" : "ass and floods her intestines") + ", a deep crimson blush spreading across her cheeks as a thick spray of girlcum erupts from her pussy.  It splatters over the black-haired girl's face, and she opens her mouth to catch it all, pressing her plump lips against her sister's quivering cunt and drinking deeply as she hums a satisfied melody into her clitoris.");
			else if (player.cumQ() <= 2500) outputText("Hot ropes of cum splash into her " + ((player.biggestCockArea() > 80) ? "slit" : "ass" ) + ", smearing her with your thick load.  Her inner muscles squeeze you greedily, massaging your shaft as it swells with virile seed over and over again, thick streams spurting out of her hole as her stomach begins to distend into a jiggling round belly from the pressure.  Her " + ((player.biggestCockArea() > 80) ? "pussy" : "rectum") + " clenches involuntarily as your cloying seed erupts into her " + ((player.biggestCockArea() > 80) ? "quivering cunt and floods her passage" : "ass and floods her intestines") + ", her stomach expanding with a jiggle and hanging low and heavy with the weight of your seed.  A deep crimson blush spreads across her cheeks as a thick spray of girlcum erupts from her pussy, splattering over the black-haired girl's face, and she opens her mouth to catch it all, pressing her plump lips against her sister's quivering cunt and drinking deeply as she hums a satisfied melody into her clitoris.");
			else if (player.cumQ() > 2500) outputText("Hot waves of cum crest against her " + ((player.biggestCockArea() > 80) ? "cervix, flooding her womb" : "sphincter, flooding her ass") + " with your thick load.  Her inner muscles squeeze you greedily, massaging your shaft as it swells with virile seed over and over again, pressurized streams erupting from her " + ((player.biggestCockArea() > 80) ? "snatch" : "butt") + " as her abdomen swells to an obscene size.  Her " + ((player.biggestCockArea() > 80) ? "pussy" : "rectum") + " squeezes you involuntarily as your cloying seed erupts into her " + ((player.biggestCockArea() > 80) ? "quivering cunt and floods her passage" : "ass and floods her intestines") + ", her stomach rapidly swelling into a heavy, gravid belly, sloshing audibly.  A deep crimson blush spreads across her cheeks as a thick spray of girlcum erupts from her pussy, splattering over the black-haired girl's face, and she opens her mouth to catch it all, pressing her plump lips against her sister's quivering cunt and drinking deeply as she hums a satisfied melody into her clitoris.");
			outputText("  After what certainly must have felt like an eternity, the blonde's climax begins to ebb, and she collapses fantastically on top of the ravenette.\n\n");

			outputText("Her warm " + ((player.biggestCockArea() > 80) ? "cunt" : "asshole") + " still grips your cock tightly, dragging you down with her.  You collapse on top of her, sliding off of the redhead's cock as you tumble into the golden curls of the blonde's hair.");
			if (player.gender >= 2) outputText("  A flood of seed begins to spill from your abused pussy, gushing over the redhead's groin and spreading into the water.  The flow is soon stemmed by the introduction of the black-haired girl's tongue, plush lips pressed against your cunt as she hungrily sucks down the outpouring of semen.  She gulps loudly and gluttonously, spreading your lips with her thumbs and swallowing every last delicious salty morsel, her stomach swelling and quivering as your own overfull abdomen begins to deflate in equal measure.");
			outputText("  As your twitching cock relieves itself of the last of your seed inside the blonde's " + ((player.biggestCockArea() > 80) ? "pussy" : "ass") + ", you feel your strength slipping away from you with each spasm, your eyelids growing heavy with an uncommon weariness.\n\n");
			player.orgasm();
			doNext(kitsuneStillHungryMansion);
		} //End letHer() 	

//Formerly shoveHer()
		private function kitsuneShoveHerMansion(willing:Boolean = true):void
		{
			clearOutput();
			kitsuneSprite();
			outputText("In spite of your drunken stupor, you are just lucid enough to realize what is going on in time to stop her.  You plant your arm against her chest with a push, and she loses balance and tumbles into the water, kicking up foam.  She breaches the water with a rambunctious cry, inadvertently knocking her sisters off as she grapples with you in the steamy spring.  The surprised pair laughs and shields their eyes as you roll around in the water, tossing hot foam into the air.  When the crashing waves finally die down, you have the boisterous redhead pinned under your elbow against the side of the bath, [eachCock] grinding lewdly against the pillowy cheeks of her upthrust ass.  She struggles for a bit, but once she accepts that you have overpowered her, she slowly relaxes into a submissive state, her muscles relaxing and her ears slouching against the top of her head.\n\n");
			outputText("\"<i>F-fine...</i>\" she says quietly, rolling her eyes back in pleasure as you scratch behind her ears and run a finger coercively down her cheek." + ( flags[kFLAGS.redheadIsFuta] > 0 ? "" : "  Reaching down between her legs, you nod in satisfaction as you feel her cock slowly receding, shrinking down into a pert, solid pleasure bud between her puffy lips.") + "\n\n");

			outputText("You let up on the disappointed kitsune a bit, running your fingers down her bare back and watching her shiver in pleasurable agony.  A small scratch applied to the base of her tails breaks down the last of her defenses, and she collapses against the wooden deck bordering the pool with a shuddering sigh.  Her sisters close in once again, brushing their tails up against your nude form and trailing their sparking fingertips across your " + player.skin() + " gently.");

			if (player.gender == 1 || ((player.gender == 3) && flags[kFLAGS.redheadIsFuta] == 0)) {
				outputText("\n\nThe blonde casually wades over to the redhead, planting her expansive rear down on her sister's back and reclining with a haughty smirk gracing her lips.  The poor redhead trembles under her weight, her cheeks flushed with unmet needs," + (flags[kFLAGS.redheadIsFuta] > 0 ? " neglected cock hanging low in the water," : "") + " tails fluttering back and forth between the blonde's legs while the flaxen-haired fox woman leads you on with a finger.  One of the blonde's tails winds around the " + ((player.hasSheath()) ? "sheath" : "base" ) + " of your " + player.cockDescript(player.biggestCockIndex()) + ", pulling it into the shimmering tangle of crimson and gold, and though the fluffy forest obscures your view, you can feel the " + player.cockHead(player.biggestCockIndex()) + " pressing up against the blonde's warm, inviting snatch.\n\n");
				outputText("Her tail coils and constricts around your member, drawing you forward to plunge into the waiting folds with a wet slurp." + ((player.biggestCockArea() > 50) ? "  Her walls draw you inward for ages, rippling sensually along your length as her cavernous cunt seems to go on forever.  Impossible though it might sound, it seems she intends to take ALL of you." : "") + "  She shudders with satisfaction as your hips lightly press against hers, legs spreading out and wrapping around your " + player.hipDescript() + " to draw you in as far as possible" + ((player.cocks.length > 1) ? ", [eachCock] entangled in a jungle of red and gold tails that caress and tickle them teasingly." : ".") + "  The redhead's tails flail sporadically, bristling with pleasure as your " + ((player.cocks.length > 1) ? "cocks slide" : "cock slides") + " through the sensitive coils, sending a shiver up her spine and a blush to her cheeks.\n\n");
				outputText("You feel something brushing against your " + player.legs() + " in the water and look down to find the black-haired girl wedging herself in between the redhead's legs, running her hands up and down her sister's voluptuous thighs and smacking her rear once for good measure.  The redhead lets out a startled cry and raises her hips dutifully as an angry red handprint resolves on her jiggling cheek, faintly visible against the large star-shaped tattoo that adorns it.  With new room to breathe, the black-haired girl raises her head against her sister's fiery crotch and begins to nuzzle it passionately, her plush, pillowy pink lips planting kisses along " + (flags[kFLAGS.redheadIsFuta] > 0 ? "the underside of her swollen cock." : "the moist cleft of her vagina.") + "\n\n");
				outputText("Holding the blonde's shapely hips, you begin to pump in and out of her hungry gash, moaning shamelessly from the pleasure of her tight, hot walls methodically squeezing your member.  Her marshmallowy breasts jiggle and flop against her chest as she is rocked back and forth over the redhead's back, her arms bending back to grip the deck for support.  She licks her lips hungrily, rolling her eyes back and groaning in ecstasy, playing up the pleasure to extremes in order to tease her sisters.  With expert timing she clamps her muscular snatch down against your " + player.cockDescript(player.biggestCockIndex()) + " just as you are about to pull back, sealing like a vice around the shaft such that an audible 'schliiick!' fills the air.\n\n");
				outputText("She giggles immaturely at the obscene noise, putting a hand over her mouth and flashing you a \"who, me?\" smirk.  Her slippery cunt flexes, skillfully drawing you back inside with a slurp and spurring you back to your wild thrusting.  Below, the black-haired girl has advanced from her teasing licks and begun to " + (flags[kFLAGS.redheadIsFuta] > 0 ? "suck lovingly on the tip of her sister's cock, moaning through the shaft hungrily." : "lap earnestly between her sister's folds, moaning into her slick snatch hungrily.") + "  Sandwiched between her sisters, the redhead trembles with pleasure, grinding her hips down into the hungry ravenette's face" + (flags[kFLAGS.redheadIsFuta] > 0 ? ", stuffing her cock down into her throat with a moan.  The gluttonous girl swallows it with glee, her throat bulging as the thick shaft passes through, gulping loudly and hungrily." : ", forcefully, smearing slick juices across the hungry ravenette's face.  The gluttonous girl laps up every drop, running her lengthy tongue up between the slippery folds and penetrating her with the tip.") + "\n\n");
				outputText("You edge closer and closer to your climax, shivering with pleasure as pressure builds in your " + ((player.balls > 0) ? player.ballsDescriptLight() : "prostate" ) + ".  The " + ((player.hasSheath()) ? "sheath" : "base" ) + " of your " + player.cockDescript(player.biggestCockIndex()) + " bulges outwardly as the first thick glob of cum swells through it, forcing its way into the blonde's unprotected womb.  ");
				if (player.cumQ() <= 150) {
					outputText("A few virile streams spurt into her, sloppily smearing her tunnel with your thick load.  Just as your potency begins to wane, you feel her golden tail constrict around your base, blocking the flow.  You groan deeply in protest as your shaft spasms dryly, her muscular snatch forcing you out with a loud 'plop!'  As the remainder of your seed builds up painfully behind her tail, she raises a finger to her lips, leering at you slyly.  Before you know what is going on, her tail directs your throbbing shaft downward and you feel yourself plunge into the redhead's " + ((player.biggestCockArea() > 80) ? "vagina!" : "defenseless anus!") + "  The unsuspecting girl lurches forward with a moan, and at the same time the blonde releases her grip on your " + ((player.hasSheath()) ? "sheath" : "base" ) + ", allowing your load to freely spill into her sister's tender " + ((player.biggestCockArea() > 80 ) ? "pussy. Her slit " : "butt. Her rectum") + " squeezes you involuntarily, her face caught halfway between shock and orgasmic pleasure.");
				}
				else if (player.cumQ() <= 350) {
					outputText("Numerous streams spurt into her, sloppily smearing her tunnel with your thick load.  Her inner muscles squeeze you greedily, massaging your shaft to draw your seed toward her convulsing womb.  Just as your potency begins to wane, you feel her golden tail constrict around your base, blocking the flow.  You groan deeply in protest as your shaft spasms dryly, her muscular snatch forcing you out with a loud 'plop!'  As the remainder of your seed builds up painfully behind her tail, she raises a finger to her lips, leering at you slyly.  Before you know what is going on, her tail directs your throbbing shaft downward and you feel yourself plunge into the redhead's " + ((player.biggestCockArea() > 80) ? "vagina!" : "defenseless anus!") + "  The unsuspecting girl lurches forward with a moan, and at the same time the blonde releases her grip on your " + ((player.hasSheath()) ? "sheath" : "base" ) + ", allowing your load to freely spill into her sister's tender " + ((player.biggestCockArea() > 80 ) ? "pussy. Her slit " : "butt. Her rectum") + " squeezes you involuntarily as a final glut of seed erupts into her " + ((player.biggestCockArea() > 80) ? "passage" : "intestines") + ", her face caught halfway between shock and orgasmic pleasure.");
				}
				else if (player.cumQ() <= 1000) {
					outputText("Thick ribbons of cum spurt into her, sloppily smearing her tunnel with your potent load.  Her inner muscles squeeze you greedily, massaging your shaft to draw your virile seed toward her convulsing womb, thin streams messily spurting from her entrance as her abdomen begins to bulge from the pressure.  Just as your potency begins to peak, you feel her golden tail constrict around your base, blocking the flow.  You groan deeply in protest as your shaft spasms dryly,  her muscular snatch forcing you out with a loud 'plop!'  One particularly eager spurt of seed manages to escape and dribbles weakly down the tip, and as the remainder of your seed builds up painfully behind her tail, she raises a finger to her lips, leering at you slyly.  Before you know what is going on, her tail directs your throbbing shaft downward and you feel yourself plunge into the redhead's " + ((player.biggestCockArea() > 80) ? "vagina!" : "defenseless anus!") + "  The unsuspecting girl lurches forward with a moan, and at the same time the blonde releases her grip on your " + ((player.hasSheath()) ? "sheath" : "base" ) + ", allowing your load to freely spill into her sister's tender " + ((player.biggestCockArea() > 80 ) ? "pussy. Her slit " : "butt. Her rectum") + " squeezes you involuntarily as your cloying seed erupts into her " + ((player.biggestCockArea() > 80) ? "pussy and floods her womb" : "ass and floods into intestines") + ", her face caught halfway between shock and orgasmic pleasure as her stomach begins to swell slightly.");
				}
				else if (player.cumQ() <= 2500) {
					outputText("Hot ropes of cum splash into her womb, smearing her with your thick load.  Her inner muscles squeeze you greedily, massaging your shaft as it swells with virile seed over and over again, thick streams spurting out of her entrance as her stomach begins to distend into a jiggling round belly from the pressure.  At the peak of your orgasm, you feel her golden tail constrict around your base, blocking the flow.  You groan deeply in protest as your shaft spasms valiantly, her muscular snatch forcing you out with a loud 'plop!'  The pressure in your " + ((player.balls > 0) ? player.ballsDescriptLight() : "prostate" ) + " is too great for her to hold all of it back, and a number of pressurized streams force their way by, streaking her body with hot seed.  She opens her mouth and happily catches an errant stream on her tongue, then raises a finger to her lips and leers at you slyly.  Before you know what is going on, her tail directs your throbbing shaft downward and you feel yourself plunge into the redhead's " + ((player.biggestCockArea() > 80) ? "vagina!" : "defenseless anus!") + "  The unsuspecting girl lurches forward with a moan, and at the same time the blonde releases her grip on your " + ((player.hasSheath()) ? "sheath" : "base" ) + ", allowing your load to freely spill into her sister's tender " + ((player.biggestCockArea() > 80 ) ? "pussy. Her slit " : "butt. Her rectum") + "  squeezes you involuntarily as your cloying seed erupts into her " + ((player.biggestCockArea() > 80) ? "pussy and floods into her passage" : "ass and floods her intestines") + ", her face caught halfway between shock and orgasmic pleasure as her stomach expands with a jiggle, hanging low and heavy with the weight of your seed.");
				}
				else if (player.cumQ() > 2500) {
					outputText("Hot waves of cum crest against her " + ((player.biggestCockArea() > 80) ? "cervix" : "sphincter") + ", flooding her " + ((player.biggestCockArea() > 80) ? "womb" : "anus") + " with your thick load.  Her inner muscles squeeze you greedily, massaging your shaft as it swells with virile seed over and over again, pressurized streams erupting from her " + ((player.biggestCockArea() > 80) ? "snatch" : "pucker") + " as her abdomen swells to an obscene size.  At the peak of your orgasm, you feel her golden tail constrict around your base, trying in vain to stem the flow.  You groan deeply in protest as your shaft spasms violently, her muscular " + ((player.biggestCockArea() > 80) ? "snatch" : "pucker") + " forcing you out with a loud 'plop!'  The pressure in your " + ((player.balls > 0) ? player.ballsDescriptLight() : "prostate" ) + " is far too much for her to hold back, and her efforts only succeed in turning your eruptive streams into a sporadic shower of semen that streaks her front with a percussive patter.  She revels in the showering seed, happily catching a few streams on her tongue, then raises a finger to her lips and leers at you slyly.  Before you know what is going on, her tail directs your throbbing shaft downward and you feel yourself plunge into the redhead's " + ((player.biggestCockArea() > 80) ? "vagina!" : "defenseless anus!") + "  The unsuspecting girl lurches forward with a moan, and at the same time the blonde releases her grip on your " + ((player.hasSheath()) ? "sheath" : "base" ) + ", allowing your abundant load to freely splatter into her sister's tender " + ((player.biggestCockArea() > 80) ? "pussy" : "butt") + ".  Her " + ((player.biggestCockArea() > 80) ? "slit" : "rectum") + " squeezes you involuntarily as your cloying seed erupts into her " + ((player.biggestCockArea() > 80) ? "pussy" : "ass") + " and floods her " + ((player.biggestCockArea() > 80) ? "passage" : "intestines") + ", her face caught halfway between shock and orgasmic pleasure as her stomach rapidly swells into a heavy, gravid belly, sloshing audibly.");
				}
				outputText("\n\nThe sudden intrusion " + ((player.biggestCockArea() > 80) ? "" : "into her behind ") + "drives her over the edge in an instant, and soon your ears are met with the sound of hungry slurping.  " + (flags[kFLAGS.redheadIsFuta] > 0 ? "The black-haired kitsune swallows eagerly around her sister's engorged cock, slurping down stream after stream of thick futa-jizz.  She raises her hand up and slides two fingers into the girl's convulsing cleft, moaning in approval as the copious fountain of semen in her throat thickens even more.  Her other hand slowly massages her gradually expanding stomach, caressing the growing bulge while she pounds her fingertips into her sister's pussy, sucking out every creamy, salty morsel." : "The black-haired kitsune laps eagerly at her sister's convulsing pussy, a thick spray of girlcum splattering across her face as she tries her best to catch it in her mouth.  Her lips wrap around the girl's quivering cunt, and she begins to drink deeply from the viscous fountain, humming her pleasure the entire time.") + "  After what certainly must have felt like an eternity, the girl's climax begins to ebb, and she collapses fantastically beneath the blonde's weight with a splash, narrowly avoiding the raven-haired girl's face on the way down.\n\n");
				outputText("Her warm " + ((player.biggestCockArea() > 80) ? "cunt" : "asshole") + " still grips your cock tightly, dragging you down with her.  You collapse into the blonde's open arms, finding yourself pressed into the marshmallowy embrace of her mountainous breasts.  As your twitching cock relieves itself of the last of your seed inside the redhead's " + ((player.biggestCockArea() > 80) ? "pussy" : "ass") + ", you feel your strength slipping away from you with each spasm, your eyelids growing heavy with an uncommon weariness.\n\n");
			}
			else if ((player.gender = 3) && flags[kFLAGS.redheadIsFuta] > 0) {
				outputText("\n\nThe blonde casually wades over to the redhead, flipping her onto her back and sliding onto her sister's hips with a haughty smirk.  The poor redhead is pinned under her weight, flushing with wanton desire, her cock twitching needfully between the blonde's ass cheeks.  One of the blonde's tails winds around the " + ((player.hasSheath()) ? "sheath" : "base" ) + " of your " + player.cockDescript(player.biggestCockIndex()) + ", pulling it into the shimmering tangle of golden coils, and though a fluffy forest obscures your view, you can feel the " + player.cockHead(player.biggestCockIndex()) + " pressing up against the blonde's warm, inviting snatch.\n\n");
				outputText("Her tail coils and constricts around your member, drawing you forward to plunge into the waiting folds with a wet slurp." + ((player.biggestCockArea() > 80) ? "  Her walls draw you inward for ages, rippling sensually along your length as her cavernous cunt seems to go on forever.  Impossible though it might sound, it seems she intends to take ALL of you." : "") + "  She shudders with satisfaction as your hips lightly press against hers, a few of her tails lashing around your " + player.hipDescript() + " to draw you in as far as possible" + ((player.cocks.length > 1) ? ", [eachCock] entangled in a jungle of gold that caresses and tickles them teasingly." : ".") + "  The redhead's tails flail sporadically beneath her, bristling with pleasure as your " + player.vaginaDescript() + " slides across the tip of her cock teasingly, sending a shiver up her spine and a blush to her cheeks.\n\n");
				outputText("You feel something brushing against you and look down to find the black-haired girl pressing her face against your [butt], running her hands up and down your " + player.hipDescript() + " and smacking your cheek once lightly for good measure.  An involuntary shudder zigzags up your spine as her slick tongue runs up your crack, lining your [asshole] with saliva.  Her fingertips dig into the flesh of your bottom, the other hand sliding along your " + player.vaginaDescript() + ", pinching and rolling your " + player.clitDescript() + ".  A moment later, you rise an inch or two off the ground as a squirming invader spears your ass.  Her plush lips press against you like soft pillows, a muffled giggle vibrating up her tongue and into your prostate.  Your strength gives out as she prods your prostate, dragging you down with her weight at the same time to impale you on the redhead's cock.");
				//[virginity loss/ stretching, redhead is 12x2]
				player.cuntChange(24, true, true, false);
				outputText("\n\n");
				outputText("The redhead squeals with pleasure as her throbbing shaft spears your nethers, her hands rising up to the blonde's shoulders and digging into them passionately.  Caught between the blonde's sopping pussy, the redhead's cock, and the ravenette's swirling tongue, you are ensconced in such pleasure that you can no longer distinguish the source.  Your body bucks and trembles from the trio's indulgent onslaught, hips grinding and mashing against each other in a passionate spectacle.\n\n");
				outputText("Holding the blonde's shapely hips, you begin to pump in and out of her hungry gash, moaning shamelessly from the pleasure of her tight, hot walls methodically squeezing your member.  She licks her lips hungrily, rolling her eyes back and groaning in ecstasy, playing up the pleasure to extremes in order to tease her sisters.  With expert timing she clamps her muscular snatch down against your " + player.cockDescript(player.biggestCockIndex()) + " just as you are about to pull back, sealing like a vice around the shaft such that an audible 'schliiick!' fills the air.\n\n");
				outputText("She giggles immaturely at the obscene noise, looking back over her shoulder and flashing you a \"who, me?\"  smirk.  Her slippery cunt flexes, skillfully drawing you back inside with a slurp and spurring you back to your wild thrusting.  Pinned beneath the blonde, the redhead trembles with pleasure, grinding her hips upward into yours desperately, running her hands up and down her sister's back in pure ecstasy.\n\n");
				outputText("You edge closer and closer to your climax, shivering with pleasure as pressure builds in your " + ((player.balls > 0) ? player.ballsDescriptLight() : "prostate" ) + ".  The " + ((player.hasSheath()) ? "sheath" : "base" ) + " of your " + player.cockDescript(player.biggestCockIndex()) + " bulges outwardly as the first thick glob of cum swells through it, forcing its way into the blonde's unprotected womb.  ");
				if (player.cumQ() <= 150) {
					outputText("A few virile streams spurt into her, sloppily smearing her tunnel with your thick load.  Her inner muscles squeeze you involuntarily, a deep crimson blush spreading across her cheeks as a thick spray of girlcum erupts from her pussy.");
				}
				else if ((player.cumQ() > 150) && (player.cumQ() <= 350)) {
					outputText("Numerous streams spurt into her, sloppily smearing her tunnel with your thick load.  Her inner muscles squeeze you greedily, massaging your shaft to draw your seed toward her convulsing womb, a thick spray of girlcum erupting from her pussy.");
				}
				else if (player.cumQ() <= 1000) {
					outputText("Thick ribbons of cum spurt into her, sloppily smearing her tunnel with your potent load.  Her inner muscles squeeze you greedily, massaging your shaft to draw your seed toward her convulsing womb.  Her cunt clenches involuntarily as your cloying seed erupts into her and floods into her womb, a deep crimson blush spreading across her cheeks as a thick spray of girlcum erupts from her pussy.");
				}
				else if (player.cumQ() <= 2500) {
					outputText("Hot ropes of cum splash into her womb, smearing her with your thick load.  Her inner muscles squeeze you greedily, massaging your shaft as it swells with virile seed over and over again, thick streams spurting out of her hole as her stomach begins to distend into a jiggling round belly from the pressure.  Her cunt clenches involuntarily as your cloying seed erupts into her and floods her womb, her stomach expanding with a jiggle and hanging low and heavy against the redhead's abdomen with the weight of your seed, while a thick spray of girlcum erupts from her pussy.");
				}
				else if (player.cumQ() > 2500) {
					outputText("Hot waves of cum crest against her cervix, flooding her womb with your thick load.  Her inner muscles squeeze you greedily, massaging your shaft as it swells with virile seed over and over again, pressurized streams erupting from her snatch as her abdomen swells to an obscene size.  Her pussy squeezes you involuntarily as your cloying seed erupts into her quivering cunt, her stomach rapidly swelling into a heavy, gravid belly, sloshing audibly and pressing against the redhead's abdomen.");
				}
				outputText("\n\nAt the same time, you can feel the redhead's shaft begin to twitch in your pussy, on the verge of her own climax.  The blonde glances back over her shoulder to you, raising a finger to her lips and leering slyly as one of her tails slithers down between the redhead's hips and your own.  The golden coil lashes around her sporadically twitching rod in a tight ring, and the explosive eruption of seed you were expecting never arrives.  The redhead's face is contorted into a tortured grimace, the base of her cock swollen with the cum backing up painfully behind her sister's tail.  The blonde only giggles, teasing the redhead with a fingertip on her forehead as she cinches her tail up even tighter.  The poor abused redhead trembles with need, groaning through clenched teeth as her orgasm continues to be denied, building up pressure by the second.\n\n");
				outputText("With a wry smirk, the blonde finally releases her from her torment, and the thick bulge in her cock swells through her shaft almost instantly, erupting into your womb in a salty, creamy deluge.  The virile onslaught sends shivers up your spine as it floods into your uterus relentlessly, causing your abdomen to swell and bubble outward.  It inflates slowly, growing into a sloshing, engorged belly not dissimilar to a watermelon in size and proportion.  After what feels like an eternity, the girl's climax begins to ebb, and she collapses fantastically beneath the blonde's weight with a splash.  You follow soon after, feeling the black-haired girl's tongue pull away as you slide forward onto the blonde's back.\n\n");
				outputText("The slithering tongue coils around the base of the redhead's softening member, pulling it from your " + player.vaginaDescript() + " with a 'plop!'  A flood of seed begins to spill from your abused pussy, gushing over the redhead's groin and spreading into the water.  The flow is soon stemmed by the introduction of the black-haired girl's tongue, plush lips pressed against your cunt as she hungrily sucks down the outpouring of semen.  She gulps loudly and gluttonously, spreading your lips with her thumbs and swallowing every last delicious salty morsel, her stomach swelling and quivering as your own overfull abdomen begins to deflate in equal measure.\n\n");
				outputText("As your twitching cock relieves itself of the last of your seed inside the blonde's pussy, you feel your strength slipping away from you with each spasm, your eyelids growing heavy with an uncommon weariness.\n\n");
			}
			player.orgasm();
			doNext(kitsuneStillHungryMansion);
		} // End shoveHer()

//formerly
		private function kitsuneStillHungryMansion():void
		{
			clearOutput();
			kitsuneSprite();
			outputText("Just as you are about to slip out of consciousness, you are roused by the feeling of the kitsune pulling you from her sister's grasp, sliding you onto your back, and bending low over you.\n\n");
			outputText("\"<i>Still hungry...</i>\" she says softly, rubbing her chubby stomach gently, a quiet rumble issuing forth.\n\n");
			outputText(((player.balls > 0) ? "She exposes her upturned palms, rubbing them together for a moment and then blowing into them lightly.  With a snapping crackle, a bright blue flame bursts to life in her hands, and she presses her palms to your " + player.ballsDescriptLight() + ", massaging them gently." : "She extends her index and middle fingers, and with a snapping crackle, a bright blue flame bursts to life at her fingertips.  Before you can protest, your [butt] is invaded by her pyrotechnic digits, pressing against your prostate insistently.") + "  As the cooling tingle of her mystical flame spreads across your " + ((player.balls > 0) ? player.ballsDescriptLight() : "prostate" ) + ", you can feel a tense pressure building up, pleasure coursing through you as your spent stores of seed miraculously begin to replenish themselves, your flagging " + player.cockDescript(player.biggestCockIndex()) + " springing to readiness instantly!\n\n");
			outputText("Your rock-hard shaft is immediately engulfed in the soft embrace of the girl's breasts, the tip entrapped by the moist prison of her warm mouth.  A tongue of improbable length slides out of the girl's mouth, slathering saliva across your turgid rod and coiling around it with a tight squeeze.  Her plush pink pillows caress your " + player.cockHead(player.biggestCockIndex()) + " with a sensual suckling, drawing you inward and nibbling on the flesh delicately.\n\n");
			outputText(((player.biggestCockArea() < 70) ? "In a single stroke she swallows your shaft, her lips gliding all the way down to the hilt as her warm throat envelopes you, squeezing gently." : "She draws the shaft as far into her mouth as possible, her throat stretching around your head and pulling it in.  When she can swallow no more, she pauses to stabilize her breathing through her nose, then sighs contentedly.") + "  Her eyes roll back pleasantly and she glances up at you, the corners of her mouth curled up in a devious smirk, her tongue still curled around your stiff rod just past the edges of her lips.\n\n");
			if (flags[kFLAGS.redheadIsFuta] > 0) {
				outputText("A trembling moan shudders down your cock as the redhead wades by to join in the fun, giving her sister a light spank.  Her cock slides up between the busty ravenette's expansive buttocks, and then with a swift thrust, plunges into her soaked pussy.  Each time she thrusts forward, the black-haired girl groans with pleasure, her throat clenching around your cock wonderfully.  Ropes of spittle begin to slide down her chin as she is manhandled by her sister, her head bobbing back and forth on your rod as she squeezes her chest around it.\n\n");
			}
			else {
				outputText("Fingers trail delicately across your [chest] as the redhead slides in next to you, sparks flying from her fingertips as she encircles your " + player.nippleDescript(0) + ", eliciting a moan.  Her body presses against yours softly, one leg draping over your waist as she lays her head down and begins to run her tongue along the outer edge of your nipple.\n\n");
			}
			outputText("You are abruptly aware of a pair of hands caressing the sides of your head gently, your vision subsequently obscured by a pair of shapely cheeks adorned with a crescent moon tattoo that jiggle tantalizingly overhead before lowering toward your face.  The blonde's pussy kisses your lips, filling your nose with its sweet, musky aroma, while her hands lovingly caress the top of your head, pulling you against her crotch softly.  Her hips roll back and forth over your face, her bountiful butt jiggling and quivering with each motion as she grinds her sodden snatch into your lips.\n\n");

			outputText("Still overly sensitive from the exhilarating romp you had just taken part in, your " + player.cockDescript(player.biggestCockIndex()) + " begins to throb and twitch excitedly within the black-haired girl's throat, already being pushed to the limits of your endurance.  ");
			if (flags[kFLAGS.redheadIsFuta] > 0) {
				outputText("The redhead's hips slap up against her sister's ass again and again, driving her down onto your rod with a loud, gagging gulp.  The black-haired girl's throat ripples and flows wetly along your length, a deep moan vibrating up it as the redhead digs her fingers into her expansive ass flesh, rolling her eyes back and groaning obscenely.  A liquid gurgle fills the air as the redhead unleashes a torrent of seed, the ravenette's belly swelling slowly.  Her moans intensify around your rod with each passing second, hands vigorously stroking along whatever length of your shaft is not consumed by her throat.\n\n");
			}
			outputText("\"<i>Theed ne...</i>\" she groans, her words garbled by the presence of your swollen shaft.\n\n");

			outputText("The introduction of a spark of blue flame against the base of your cock enforces the request, and you have little choice but to comply.  An unnatural pressure begins to fill your " + ((player.balls > 0) ? player.ballsDescriptLight() : "prostate" ) + ", most certainly a result of the kitsune's prior witchery.  The base of your " + player.cockDescript(player.biggestCockIndex()) + " swells up, the thick bulge slowly working its way up the length of your shaft and forcing past her plump pink lips.  Your mind goes blank, vision popping with white spots as you moan orgasmically into the blonde's salty pussy, your tongue jammed deep into her folds.  Liter after liter of seed, thicker and more virile than you've ever produced, begins to flow down into the black-haired kitsune's gullet, eagerly swallowed without hesitation.  Twin streams burst from her nose as her cheeks bulge with semen, her lips clasped as tight as possible to contain as much as she can, while her belly continues to jiggle with added weight, sloshing and quivering as more and more cum flows down her throat.\n\n");
			outputText("A viscous stream of femcum crashes against your face, dribbling down your chin as the blonde achieves climax shortly after you do, and altogether the four of you ride the waves of pleasure for what feels like ages.  Each passing second finds you more and more fatigued, and your eyelids grow heavier and heavier, muscles growing weak.\n\n");
			outputText("Exhausted by the ordeal, you relax into a blissful stupor, only vaguely aware of the feeling of being dragged onto the deck.  The last thing you recall before slipping into unconsciousness is the three sisters crawling up alongside you, coaxing your twice-spent member back to life yet again with their magic, eyes glinting hungrily.");
			//Increase PC cum production slightly due to residual effects from the kitsunes' magic.
			player.orgasm();
			outro();
		} //end stillHungry();


//formerly femaleOrGenderless()
		private function kitsuneFemaleOrGenderless(willing:Boolean):void
		{
			clearOutput();
			kitsuneSprite();
			outputText("\"<i>Just relax, darling,</i>\" the blonde says in a crooning tone, sliding her hand down along your " + player.hipDescript() + " under the water.  Her silky-soft fingertips gently circles your " + ((player.gender >= 2) ? player.clitDescript() : player.assholeDescript() ) + ", making you shudder.  Any reservations you still had are naught but memories now as you" + ((player.isBiped()) ? " spread your legs and" : "" ) + " give yourself over completely to her tender touch.\n\n");
			outputText("Your erogenous zones are caressed by numerous velvety tails, a few of them curling around your limbs to keep you from squirming around too much.  Plush lips kiss every inch of exposed flesh, while blue flames spark to life with the sound of striking flint to gently lick and swirl along your body, sending ripples of pleasure coursing through you.  Your liquor-addled mind is too foggy by now to resist their advances, their disarming caresses breaking down your inhibitions and replacing them with lust and desire.\n\n");
			outputText("One fingertip is shortly followed by a second, gently invading your " + ((player.gender >= 2) ? player.vaginaDescript() : player.assholeDescript() ) + " up to the second knuckle and making you moan and clench in pleasure.  Tender caresses slide down your [fullChest] as the sisters lavish you with affection - a gentle tweak here, a nip there, every action carefully measured to tease and arouse you.  The black-haired one carefully climbs on top of you, wrapping her lips around one of your " + player.nippleDescript(0) + "s and flicking it gently with her tongue." + ((player.lactationQ() > 0) ? "  She titters with excitement as your fresh cream begins to pour into her mouth, massaging your [chest] gently to stimulate the flow and drinking it down eagerly.\n\n\"<i>Mmmm...  So very tasty,</i>\" she says with a smirk, dipping down for another drink." : "Her teeth gently play along the tender flesh, sending shocks of pleasure through you.  Pale blue flames spread from the corners of her lips, elevating the pleasure even further, and you find it hard to stop shivering.") + "\n\n");
			outputText("You feel something warm prodding you in the side and look down to find that the redhead possesses a special something that her sisters are lacking - and from the devilish grin on her face, you have an inkling of what she intends to do with it.\n\n");
			if (willing) {
				outputText("<b>How do you respond?</b>");
				// display choices:
				//["Let Her" = letHer() ] ["Shove Her" = shoveHer() ]
				simpleChoices("Let Her", createCallBackFunction(kitsunesGenderlessLetHer, willing),
						"Shove Her", createCallBackFunction(kitsunesGenderlessShoverHer, willing), "", null, "", null, "", null);
			}
			else {
				doNext(createCallBackFunction(kitsunesGenderlessLetHer, true));
			}
		}

		private function kitsunesGenderlessLetHer(willing:Boolean):void
		{
			clearOutput();
			kitsuneSprite();
			outputText(((willing) ? "You decide to let the girl have her fun, allowing her to shift positions to begin rubbing her throbbing shaft against your " + ((player.gender == 2) ? player.vaginaDescript() : "featureless groin") + " eagerly." : "You shake your head sluggishly, but your slurred protests fall on deaf ears.  She easily sidesteps your " + player.leg() + " as you try to shove her away, sliding forward to lay a disarming kiss on your cheek.  A bright blue wisp of flame crackles from her lips, and that is that - the resulting spark of pleasure that arcs up your spine shatters the last of your resistance, and your cares melt like butter.") + "  While she grinds her pulsating shaft against you slowly, her sisters close in around you to join in the fun.\n\n");
			outputText("Your head is drawn into the blonde's lap, fingers softly gliding " + ((player.hairLength > 0) ? "through your " + player.hairDescript() : "across the sides of your face") + ", brushing you lightly with her mystical flames.  A pair of large, shapely ass cheeks emblazoned with a sun-shaped tattoo enters your field of vision, and soon your view is entirely blocked by the black-haired girl's expansive behind, save for a sliver of light filtering down between her and the blonde.  Her slick pussy glides across your lips, coaxing your tongue from your mouth as she bends down, pulling the redhead's cock into her mouth for a moment to slather it with saliva, spreading your " + ((player.gender == 2) ? "labia" : "butt cheeks") + " with her first two fingers, egging her on.\n\n");
			outputText("The redhead wastes no time taking the invitation, spearing your " + ((player.gender >= 2) ? player.vaginaDescript() : player.assholeDescript() ) + " in a single thrust.  Her thick rod pierces your waiting hole, bringing with it a distinctive effervescent tingle.  Her hands close around your " + player.hipDescript() + ", and she begins to thrust wantonly, playing up her pleasure with an exaggerated moan as her breasts jiggle to and fro with each buck of her hips.");
			if (player.gender >= 2) player.cuntChange(14, true, true, false);
			else player.buttChange(14, true, true, false);

			outputText("\n\n");
			outputText("The soft lap beneath your head slides out of the way and is replaced by a thick bed of golden tails, and what remains of your field of vision is quickly blotted out by the addition of another set of quivering ass cheeks, pressing against her sister's as she tries to wedge herself down against your mouth as well.  The size of their posteriors makes finding a comfortable position rather difficult, and the two of them wind up jostling each other back and forth in competition for your wriggling tongue.\n\n");
			outputText("The victor is decided when you feel a pair of golden tails slithering around the black-haired girl's legs, a surprised yelp proclaiming their penetration into the girl's ass and pussy.  With a haughty smirk, the blonde settles into position, her tails alternatingly pistoning into her sister's holes as she rides your face passionately, stroking the top of your head.\n\n");
			outputText("As her innards are pummeled by her sister's tails, the hungry ravenette crawls her way down your form, lowering her head to your groin and letting her tongue slide out around the redhead's cock.  It wraps around the base, twisting and cinching tight to act as a cock ring.  As blood pumps to her shaft and becomes trapped, it swells up, thick ribs and veins becoming more pronounced and stimulating your " + ((player.gender >= 2) ? player.vaginaDescript() : player.assholeDescript() ) + " to even further levels of ecstasy.\n\n");
			outputText("Your tongue swirls and twists within the blonde's pussy, drawing out wave after wave of salty-sweet femjuice.  The aromatic juices mist your tongue and face, your moans muffled by the weight of her cushiony cheeks pressing down.  She is thoughtful enough to give you space to breathe every few moments, rocking her hips back gently to look down into your eyes, her expression halfway between that of a doting mother and a dominatrix.  Her hips lower against your lips again, and she resumes her passionate grinding, closing her thighs around the sides of your head.\n\n");
			outputText("The rhythmic thumping of the redhead's hips against your own increases its pace, her tongue hanging out of her mouth lewdly.  Her thick rod spears you again and again, each thrust bringing with it an even more euphoric moan from the horny redhead.  Her sisters groan in unison with her, as though feeding off of her animalistic desire to fuel their own lusts, and as your endurance is stretched to its breaking point, it seems like you'll all cross the line together.\n\n");

			outputText("The base of the redhead's shaft swells with a vast load, backing up just behind her sister's tongue.  She pumps into your " + ((player.gender >= 2) ? player.vaginaDescript() : player.assholeDescript() ) + " once, twice, thrice more before the black-haired girl releases the tension around the base, though whether by choice or due to the furious orgasm roaring through her loins, it is hard to tell.  You have only a split-second to muse on the subject before a tingling glut of seed comes rushing into your " + ((player.gender == 2) ? "womb" : "intestines") + ", sending you into a shivering fit.  Saliva and sexual fluids flow in rivers, the blonde's soaked cunt drenching your face as her pussy quivers and squeezes around your tongue.  The ravenette begins to rise upward, lifted by your expanding abdomen as she twitches in ecstasy, the blonde's tails deeply embedded in her holes.\n\n");
			outputText("Passionate moans from all four of you fill the air as you ride the waves of pleasure, finally collapsing together in ecstasy after what feels like ages.  Each twitching tremble of your muscles sees you a bit more fatigued, your eyelids feeling as though they weigh a thousand pounds each." + ((player.gender == 3) ? "  A flood of seed begins to spill from your abused pussy, gushing over the redhead's groin and spreading into the water.  The flow is soon stemmed by the introduction of the black-haired girl's tongue, plush lips pressed against your cunt as she hungrily sucks down the outpouring of semen.  She gulps loudly and gluttonously, spreading your lips with her thumbs and swallowing every last delicious salty morsel, her stomach swelling and quivering as your own overfull abdomen begins to deflate in equal measure." : "") + "  Hands resting on your" + ((player.gender == 0) ? " swollen" : " deflating") + " belly, you begin to succumb to exhaustion, your strength fading as you are overcome with an uncommon weariness.\n\n");
			doNext(createCallBackFunction(genderlessKitsuneStillHungry, willing));
		} // end letHer()

//fomerly shoveHer()
		private function kitsunesGenderlessShoverHer(willing:Boolean):void
		{
			clearOutput();
			kitsuneSprite();
			outputText("In spite of your drunken stupor, you are just lucid enough to realize what is going on in time to stop her.  You plant your arm against her chest with a push, and she loses balance and tumbles into the water, kicking up foam.  She breaches the water with a rambunctious cry, inadvertently knocking her sisters off as she grapples with you in the steamy spring.  The surprised pair laughs and shields their eyes as you roll around in the water, tossing hot foam into the air.  When the crashing waves finally die down, you have the boisterous redhead pinned under your elbow against the side of the bath, crotch grinding lewdly against the pillowy cheeks of her upthrust ass.  She struggles for a bit, but once she accepts that you have overpowered her, she slowly relaxes into a submissive state, her muscles relaxing and her ears slouching against the top of her head.\n\n");
			outputText("\"<i>F-fine...</i>\" she says quietly, rolling her eyes back in pleasure as you scratch behind her ears and run a finger coercively down her cheek." + ( flags[kFLAGS.redheadIsFuta] > 0 ? "" : "  Reaching down between her legs, you nod in satisfaction as you feel her cock slowly receding, shrinking down into a pert, solid pleasure bud between her puffy lips.") + "\n\n");
			outputText("You let up on the disappointed kitsune a bit, running your fingers down her bare back and watching her shiver in pleasurable agony.  A small scratch applied to the base of her tails breaks down the last of her defenses, and she collapses against the wooden deck bordering the pool with a shuddering sigh.  Her sisters close in once again, brushing their tails up against your nude form and trailing their sparking fingertips across your " + player.skin() + " gently.\n\n");
			outputText("The blonde casually wades over to the redhead, flipping her onto her back and settling down on her sister's hips with a haughty smirk.  The poor redhead is pinned under her weight, flushing with wanton desire, her " + ((flags[kFLAGS.redheadIsFuta] > 0) ? "cock twitching needfully between the blonde's ass cheeks." : "oversized clitoris rubbing against her sister's.") + "  One of the blonde's tails winds around the underside of your crotch, pulling you forward into the shimmering tangle of golden coils, and though a fluffy forest obscures your view, you can feel a humid warmth emanating from within it, mere inches away.\n\n");
			outputText("Her tails coil and constrict around your thighs, drawing you forward to press against her quivering lips while the tips sensually brush your sensitive nethers, sending light tingles up and down your spine.  " + ((player.clitLength > 4) ? "You groan a bit as you feel your " + player.clitDescript() + " gently slipping between the moist folds of her cunt, caressed on all sides by warm, wet flesh, the muscles squeezing down to conform to its shape perfectly.  " : "") + "She shudders with satisfaction as you lightly press against her, a few of her tails lashing around your " + player.hipDescript() + " to hold you tight.  The redhead's tails flail sporadically beneath her, bristling with pleasure as " + (flags[kFLAGS.redheadIsFuta] > 0 ? "your " + ((player.gender >= 2) ? player.vaginaDescript() : player.assholeDescript() ) + " slides across the tip of her cock teasingly" : "you are rubbed against her slavering slit") + ", sending a shiver up her spine and a blush to her cheeks.\n\n");
			outputText("You feel something brushing against you and look down to find the black-haired girl pressing her face against your [butt], running her hands up and down your " + player.hipDescript() + " and smacking your cheek once lightly for good measure.  An involuntary shudder zigzags up your spine as her slick tongue runs up your crack, lining your [asshole] with saliva.  Her fingertips dig into the flesh of your bottom, " + ((player.gender == 2) ? "the other hand sliding along your " + player.vaginaDescript() + ", pinching and rolling your " + player.clitDescript() + "." : "a fingertip gently tracing the curvature of your cheek as sparks snap and pop in its wake.") + "  A moment later, you rise an inch or two off the ground as a squirming invader spears your ass.  Her plush lips press against you like soft pillows, a muffled giggle vibrating up her tongue.  Your strength gives out as she prods your innards, " + (flags[kFLAGS.redheadIsFuta] > 0 ? "dragging you down with her weight at the same time" + ((player.gender == 2) ? " to impale you on the redhead's cock." : ", her tongue receding just as you are impaled on the redhead's cock.  The slick organ slides around the base of her cock, constricting tightly, and you can feel it swell as the veins and ridges become more pronounced.") : "and while you are at your most vulnerable, she twists two of the redhead's tails into a tight bundle, thrusting it into your " + ((player.gender == 2) ? "vagina." : "ass.")));
			player.cuntChange(24, true, true, false);
			outputText("\n\n");
			outputText("The redhead squeals with pleasure " + (flags[kFLAGS.redheadIsFuta] > 0 ? "as her throbbing shaft spears your " : "as her tails are thrust unmercifully into your ") + ((player.gender == 2) ? "cunt" : "ass") + ", her hands rising up to the blonde's shoulders and digging into them passionately.  Caught between the blonde's sopping pussy, the redhead's " + (flags[kFLAGS.redheadIsFuta] > 0 ? "cock" : "tails") + ", and the ravenette's swirling tongue, you are ensconced in such pleasure that you can no longer distinguish the source.  Your body bucks and trembles from the trio's indulgent onslaught, hips grinding and mashing against each other in a passionate spectacle.\n\n");
			outputText("Holding the blonde's shapely hips, you begin to grind against her slippery gash, moaning shamelessly as the heat washes over you.  She licks her lips hungrily, rolling her eyes back and groaning in ecstasy, playing up the pleasure to extremes in order to tease her sisters.  Smirking deviously, she raises an index finger into the air and presses it to your " + ((player.gender == 2) ? player.clitDescript() : "bare crotch") + ", a pale blue flame sending a spark of pleasure through you.\n\n");
			outputText("She giggles immaturely, tracing a small pattern of flames as she teases and toys with you.  Pinned beneath the blonde, the redhead trembles with pleasure, grinding her hips upward into yours desperately, running her hands up and down her sister's back in pure ecstasy.\n\n");

			outputText("You edge closer and closer to your orgasm, shivering with pleasure as tension builds in your lower body.  A sensual lick from the black-haired girl's tongue gives you the final push that you need, and your muscles clamp down in a frenzied climax, squeezing the redhead's " + (flags[kFLAGS.redheadIsFuta] > 0 ? "cock" : "tails") + " with all their strength.  " + ((player.wetness() == 5) ? "A viscous stream of femcum bursts forth from your loins, soaking the blonde and the redhead alike.  " : "" ) + "At the same time, you can feel the redhead's " + (flags[kFLAGS.redheadIsFuta] > 0 ? "shaft" : "tails") + " begin to twitch in your " + ((player.gender >= 2) ? player.vaginaDescript() : player.assholeDescript() ) + ", on the verge of her own climax.");

			if (flags[kFLAGS.redheadIsFuta] > 0) {
				outputText("\n\nThe blonde glances at you, raising a finger to her lips and leering slyly as one of her tails slithers down between the redhead's hips and your own.  The golden coil lashes around her sporadically twitching rod in a tight ring, and the explosive eruption of seed you were expecting never arrives.  The redhead's face is contorted into a tortured grimace, the base of her cock swollen with the cum backing up painfully behind her sister's tail.  The blonde only giggles, teasing the redhead with a fingertip on her forehead as she cinches her tail up even tighter.  The poor abused redhead trembles with need, groaning through clenched teeth as her orgasm continues to be denied, building up pressure by the second.\n\n");
				outputText("With a wry smirk, the blonde finally releases her from her torment, and the thick bulge in her cock swells through her shaft almost instantly, erupting into your womb in a salty, creamy deluge.  The virile onslaught sends shivers up your spine as it floods into your " + ((player.gender == 2) ? "uterus" : "innards") + " relentlessly, causing your abdomen to swell and bubble outward.  It inflates slowly, growing into a sloshing, engorged belly not dissimilar to a watermelon in size and proportion.  After what feels like an eternity, the girl's climax begins to ebb, and she collapses fantastically beneath the blonde's weight with a splash.  You follow soon after, slumping forward onto the blonde's chest in exhaustion.\n\n");
				outputText("The black-haired girl's slithering tongue coils around the base of the redhead's softening member, pulling it from your " + ((player.gender >= 2) ? player.vaginaDescript() : player.assholeDescript() ) + " with a 'plop!'  " + ((player.gender == 2) ? "A flood of seed begins to spill from your abused pussy, gushing over the redhead's groin and spreading into the water.  The flow is soon stemmed by the introduction of the black-haired girl's tongue, plush lips pressed against your cunt as she hungrily sucks down the outpouring of semen.  She gulps loudly and gluttonously, spreading your lips with her thumbs and swallowing every last delicious salty morsel, her stomach swelling and quivering as your own overfull abdomen begins to deflate in equal measure." : "As her cock slides out, a flood of seed begins to spill from your abused ass, gushing over the redhead's groin and spreading into the water and finally relieving the pressure in your abdomen.") + "\n\n");
				outputText("With each twitch and spasm of your muscles, you feel your strength slipping away from you with each spasm, your eyelids growing heavy with an uncommon weariness.\n\n");
			}
			else {
				outputText("\n\nThe four of you ride out the waves of pleasure for what seems like an eternity, groaning and grinding against each other in ecstasy.  Cooling flames crackle across your bare body as you are tossed to and fro in a sea of tails and flesh, the air filling with the sounds and smells of climactic release.  Finally, at long last, the pleasure begins to ebb, and you collapse along with the three girls, slumping forward onto the blonde's chest in exhaustion.\n\n");
				outputText("Each residual twitch and spasm of your muscles leaves you feeling more fatigued than ever, strength slipping away from you with each spasm and your eyelids growing heavy with an uncommon weariness.\n\n");
			}
			doNext(createCallBackFunction(genderlessKitsuneStillHungry, willing));
		} // end shoveHer()

//formerly stillHungry()
		private function genderlessKitsuneStillHungry(willing:Boolean):void
		{
			clearOutput();
			kitsuneSprite();
			outputText("Just as you are about to slip out of consciousness, you are roused by the feeling of the black-haired kitsune pulling you from her sister's grasp, sliding you onto your back, and bending low over you.\n\n");
			outputText("\"<i>Still hungry...</i>\" she says softly, rubbing her chubby stomach gently, a quiet rumble issuing forth.\n\n");
			outputText("She exposes her upturned palms, rubbing them together for a moment and then blowing into them lightly.  With a snapping crackle, a bright blue flame bursts to life in her hands, and she presses her palms to your [chest], massaging gently.  As the cooling tingle of her mystical flame spreads across your chest, you can feel a tense pressure building up, pleasure coursing through you.  Your " + ((player.biggestTitSize() < 3) ? ((player.biggestTitSize() == 0) ? "flat chest begins" : "breasts begin") + " to swell, jiggling titflesh spilling out with a tense tingle until you are the proud new owner of a sizeable pair of C cups" : "breasts seem to plump up a bit, your nipples growing hard as a tense tingle spreads through them.") + "  You arch your back, clutching your chest as the tingling intensifies, an inferno of pleasure burning in your chest.  At the height of ecstasy, your milk begins to spurt from your nipples, flying into the air like a lewd fountain.\n\n");
			outputText("Your rock-hard nipples are immediately engulfed in the soft embrace of the girl's lips, entrapped by the moist prison of her warm mouth.  A tongue of improbable length slides out, slathering saliva across your swollen breasts and coiling around one of them with a tight squeeze.  Her plush pink pillows caress your nipples with a sensual suckling, drawing them inward and nibbling on the flesh delicately as your milk begins to flow down her throat.\n\n");
			if (flags[kFLAGS.redheadIsFuta] > 0) {
				outputText("A trembling moan shudders through your breasts as the redhead wades by to join in the fun, giving her sister a light spank.  Her cock slides up between the busty ravenette's expansive buttocks, and then with a swift thrust, plunges into her soaked pussy.  Each time she thrusts forward, the black-haired girl groans with pleasure, the humming sensation vibrating through your nipples pleasantly.  Ropes of spittle begin to slide down her chin as she is manhandled by her sister, her head thrust into your cleavage as she presses her own chest against you sensually.\n\n");
			}
			else {
				outputText("Fingers trail delicately across your [chest] as the redhead slides in next to you, sparks flying from her fingertips as she encircles your free " + player.nippleDescript(0) + ", eliciting a moan.  Her body presses against yours softly, one leg draping over your waist as she lays her head down and begins to run her tongue along the outer edge, warming you up for her sister.\n\n");
			}
			outputText("A shock of pleasure jolts through you as six golden tails press against your body, azure embers sensually sizzling against your skin.  The blonde giggles lightly as she teases you, her eyes full of mischief, one finger lightly tracing the underside of your jaw.  It's a simple gesture, but the way she does it makes you practically melt into her arms, more a slave to pleasure now than ever.\n\n");
			if (flags[kFLAGS.redheadIsFuta] > 0) {
				outputText("The redhead's hips slap up against her sister's ass again and again, driving her into your chest with a surprised yelp.  The black-haired girl's lips ripple and flow wetly over your nipples, a deep moan vibrating through it as the redhead digs her fingers into her expansive ass flesh, rolling her eyes back and groaning obscenely.  A liquid gurgle fills the air as the redhead unleashes a torrent of seed, the ravenette's belly swelling slowly.  Her moans intensify against your chest with each passing second, hands passionately kneading and squeezing your breasts.\n\n");
			}
			outputText("\"<i>Feed me...</i>\" the black-haired kitsune whispers, pulling away from your milky tits for just a moment.\n\n");
			outputText("The introduction of a spark of blue flame around your breasts enforces the request, and they give you no choice but to comply.  An unnatural pressure begins to fill them again, most certainly a result of the kitsune's prior witchery.  Your nipples puff up, thick, creamy hindmilk slowly working its way to the surface, flowing past her plump pink lips.  Your mind goes blank, vision popping with white spots as you moan orgasmically into the air.  Liter after liter of milk" + ((player.lactationQ() > 0) ? ", the thickest you've ever produced," : "") + " begins to flow down into the black-haired kitsune's gullet, eagerly swallowed without hesitation.  Twin streams burst from her nose as her cheeks bulge with milk, her lips clasped as tight as possible to contain as much as she can, while her belly continues to jiggle with added weight, sloshing and quivering as more and more of it flows down her throat.\n\n");
			outputText("As the four of you ride the waves of pleasure for what feels like ages, each passing second finds you more and more fatigued, and your eyelids grow heavier and heavier, muscles growing weak.\n\n");

			outputText("Exhausted by the ordeal, you relax into a blissful stupor, only vaguely aware of the feeling of being dragged onto the deck.  The last thing you recall before slipping into unconsciousness is the three sisters crawling up alongside you, proffering their twisted magics on your spent body.");
			//Increase PC milk production slightly due to residual effects from the kitsunes' magic. Note: The breast size boost was temporary and shouldn't actually result in a permanent change.
			outro();
		} // end stillHungry();


//3+ Tentacle cocks of 30" or longer
		private function tentacleKitsuneWingWangs():void
		{
			clearOutput();
			kitsuneSprite();
			outputText("\"<i>Oh my!  It looks like we're in for a real treat tonight, sisters...</i>\" the blonde says as she runs her hands along your impressive prehensile endowments.\n\n");
			outputText("\"<i>Mmm...  tentacles...  my favorite flavor,</i>\" the black-haired one chimes in, rubbing her pudgy belly and licking her lips hungrily.  Slipping into the water next to you, each of them takes one of your hulking tentacles into her hands, grinning eagerly.  Working together, they weave their tails through your brace of writhing appendages, cinching tight around the base of each one as their fingers slide along the flexible shafts.  Trails of blue fire dance across each writhing tentacle, sending you into a shivering, shuddering frenzy, and the three sisters cast each other knowing grins.  Your liquor-addled mind is too foggy by now to resist their advances, " + ((player.lib < 50) ? "slurred protests falling on deaf ears." : "though who would want to?") + "\n\n");
			outputText("\"<i>Oh, I do so enjoy our work,</i>\" the blonde remarks, running her hand up to the tip of your cock and squeezing the bulbous head experimentally.  She flashes a satisfied smirk at the way your firm flesh yields under her touch, nodding softly.  The tip of one of her tails trails along the underside, tickling you sensually as more coils of fur stroke and knead along the obscene organ.\n\n");
			outputText("\"<i>We just looooove tentacles,</i>\" the black-haired girl explains to you, giggling like a schoolgirl as one of your obscene tendrils starts moving on its own, sliding down between her legs and threading its way between her expansive ass cheeks.  \"<i>When we see tentacles this thick, long, and...</i>\" she pauses to wrap her lips around the end of your cock, sliding her tongue along the tip, \"<i>... mmm... juicy.... it's just impossible to contain our excitement.</i>\"\n\n");
			outputText("As if to illustrate this point, she hungrily swallows almost a foot of your wriggling tentacle, a trail of spittle hanging out lazily from one corner of her mouth as she swallows carefully along your length.  Your writhing shafts are assaulted on all sides by all manner of touches and caresses; fingers, tongues, tails and breasts all working in glorious harmony to tease and pleasure you.  One tendril instinctively coils around one of the blonde's breasts, squeezing it tightly while the tip pokes and prods the soft flesh, teasing her pert pink nipples.  Moaning in response, she slides her fingers along the base, cool blue flames crackling to life across her fingertips and sending chills through your body.  Each of your thick tentacles swells up incredibly, the kitsune's magic sending jolts of pleasure across the surface.  As the pale flames dance across your groin, you feel an odd tension building up, and in a shower of viscous cum, your loins erupt into a monstrous, wriggling mass of at least a dozen undulating tentacles!\n\n");
			outputText("\"<i>Hehe, that's how we like it!</i>\"  the blonde says with a chuckle, pressing her body to the squirming brace of tentacles and moaning in anticipation.\n\n");
			outputText("You feel something warm prodding you in the side, and look down to find that the redhead has something between her legs that her sisters are lacking.  With one of your undulating cocks curled down between her legs, she begins to grind herself against you, lining up her thick, throbbing member up against one of yours and rubbing her hips back and forth lewdly.  Grabbing a segment of your ropey dick, she coils it around the base of her own, thrusting through the ring of cock flesh and groaning into your ear.\n\n");
			outputText("Her hot breath cascades across your shoulders, followed shortly by a distinctive minty coolness.  The stark contrast between the two feelings makes you shudder, your chest rising and falling quickly as the pleasure begins to mount.  Your breath is knocked out of you with a startling abruptness as the blonde is thrown down onto your chest, toppled over by her black-haired sister.  With a tentacle in one hand and the blonde's sizeable breast in the other, the plucky ravenette alternates between the two, sucking, squeezing and stroking while wriggling her plump rear back and forth.  Your hands start to glide across their silky skin of their own accord, groping the supple flesh and stroking their shimmering tails, squeezing their firm breasts and running your fingers through their soft hair.\n\n");
			outputText("A number of your cocks are ensnared by a group of long black tails, guiding them down to her upended pussy and slowly running the head of one up and down her glistening snatch.  She crawls up over her blonde sister, leaning down to nibble on your ear along with the redhead, and mumbles through her teeth, \"<i>Nn... time for the main course...  Go on, you know you wanna stick it in...  Ravage us.</i>\"\n\n");
			outputText("Without hesitation, your tentacle-dick drills eagerly into her sopping snatch before you can think.  Your moans join hers in a lewd symphony, each of your writhing tentacles finding its home in one hole or another, sending the three girls into a lust-filled frenzy atop you.  Before long, you lose track of where one girl ends and the others begin, your hands cascading over their soft, supple bodies, intersecting in a carnal mass of flesh, tails, tentacles and lust.\n\n");
			outputText("Your tentacles move of their own accord, ensnaring the three sisters in a densely tangled knot of limbs and tendrils.  The redhead hangs upside-down, dangling by her ankles with a look of utter bliss on her face as her cock is furiously jerked by one of your tentacles, both of her holes being pounded simultaneously by two thick tendrils pistoning in and out alternately.  The black-haired girl is in no less of a predicament, her eyes rolled back and tongue hanging out as her ass is stuffed full of throbbing tentacle, one hand haphazardly thrusting into her pussy alongside another.\n\n");
			outputText("\"<i>Uuuoohh... my belly's so fulllll...</i>\" she groans orgasmically, clutching her stomach as your cock snakes its way through her insides, visibly distorting her pudgy belly.  Her body goes slack, hand falling away from her groin as a thick stream of girlcum arcs through the air, her face turning red and her eyes going blank with ecstasy.\n\n");
			outputText("The blonde is folded double, her thighs spread out while her ankles are hooked behind her head, all six of her tails twitching madly.  Her breasts squash and bulge around your tentacles as they squeeze and coil around them, rubbing lewdly against her nipples.  It seems as though sense has long since been driven from her mind, her mouth hanging agape and her eyes vacant with lust.  Her throat bulges from the intrusion of your cock, pre-cum mixed with drool dribbling down her chin as she eagerly begins to suck on it, thrusting her hips automatically in sync with the undulations of your cocks in her other orifices.\n\n");
			outputText("The air is filled with the heavy, musky scent of semen as a jet of cum shoots skyward from the redhead's cock, the throbbing member swelling visibly each time she spurts another stream.  The entire deck and the water around you is stained with her seed, she and her sisters all plastered from head to toe with her copious emissions.  The cooling sensation of mint permeates your skin wherever the sticky droplets land on you, making you shudder in pleasure, and the tingling feeling of her seed dribbling down along your tentacle shafts sends an unbearable pleasure to your groin.\n\n");
			outputText("The three insensate kitsune twitch helplessly in the grips of your tentacles, maddened by pleasure as your magically enhanced tendrils plow away at them without pause, pummeling their abused holes unceasingly.  Every muscle in your body tenses in preparation for an incredible climax, the lust boiling in your loins like a coiling spring.  The pressure builds until you just can't take it any longer, convulsing beneath the three sisters and groaning in ecstasy as your orgasm shoots up each of your shafts simultaneously, swelling from base to tip and releasing your thick load inside of them.\n\n");
			if (player.cumQ() <= 150) {
				outputText("Warm streams of spunk flow from each of your tentacles, painting the sisters white inside and out.  Hot pearls of cum drench the three kitsune, mixing with the redhead's and rolling off of their bodies to dribble into the water.");
			}
			else if (player.cumQ() <= 350) {
				outputText("Thick streams of spunk pour from your tentacles, spurting white streaks into the air and painting the sisters with a glistening coat of white, inside and out.  Pearls of cum drip and dribble off their bodies, mixing with the redhead's and rolling off into the water.");
			}
			else if (player.cumQ() <= 1000) {
				outputText("Ribbons of thick, milky white cum sling into the air, falling across the sisters' bodies and painting their insides with your hot semen.  A thick layer of pearly-white cum coats their bodies, matting down hair and dribbling over the edges of their voluptuous curves.");
			}
			else if (player.cumQ() <= 2500) {
				outputText("Thick jets of hot spunk fill the air, arcing high and showering the sisters with streaks of white.  As your tentacles pump load after load of hot, creamy jizz into their abused holes, their abdomens begin to swell up, thin streams spurting out around each of your cocks and dribbling down their curves.  A thick patina of pearly-white cum coats their bodies, matting down their hair and sloughing off of their voluptuous curves in heavy globs.");
			}
			else if (player.cumQ() > 2500) {
				outputText("Thick streams of cum arc through the air, raining down on the three sisters like a hot shower as ropes of semen splatter across their bodies, streaking them with a heavy mat of white.  Thick bulges work their way down your obscene tentacle shafts, load after load erupting into their abused holes and making their abdomens begin to swell, expanding ever outward with the weight of your cum.  Before long, pressurized streams are escaping from around your cocks, twin jets of semen spurting from their noses.  Drenched, matted, and utterly stuffed with your virile sperm, the sisters limply hang within the coils of your tentacles, their limbs and tails twitching weakly.");
			}
			outputText("\n\nEvery twitch and spasm of your loins finds you feeling a little more fatigued, your eyelids growing heavy with drowsiness as you can feel the life being drained from you.  Panting desperately, the three sisters gradually regain their senses as your flagging tentacles slowly lower them down into the water" + ((player.cumQ() > 1000) ? ", their arms wrapped protectively around their cum-bloated bellies" : "" ) + ".  Exhausted from your ordeal, you let yourself relax into a blissful stupor, only vaguely aware of the feeling of being dragged up onto the deck.  The last thing you see before going unconscious is the three sisters crawling up around you, coaxing your spent tentacles back to life, their eyes glinting hungrily.");
			outro();
			player.orgasm();
		}

		private function outro(tentacles:Boolean = false):void
		{
			player.changeFatigue(15);
			kitsuneSprite();
			dynStats("tou", -2);
			if (player.fatigue > 80 && player.fatigue < 100) {
				outputText("\n\nYour dreams are haunted by visions of yourself wandering through the halls of an impressive manor, searching desperately for a way out.  No matter where you turn, the twisting hallways all seem to turn back on each other.  You are trapped, forever doomed to wander the halls of this manor, being toyed with at the whims of your three beautiful mistresses.");
			}
			if (player.fatigue >= player.maxFatigue()) {
				//mansionBadEnd();
				doNext(mansionBadEnd);
			}
			else {
				outputText("\n\nWhen you awaken the next morning, the sisters, the hot springs, and the mansion are nowhere to be found.  You are lying naked in the wilderness, your possessions sitting in a neat little pile a short distance away, and your memories of the previous night are little more than a hazy fever dream");
				if (tentacles) outputText(" - at the very least, your groin seems to be back to its usual configuration");
				outputText(".  You sit up, but fall back almost immediately, groaning as the full weight of your hangover hits you like a ton of bricks.  It takes a long time before you can muster up the willpower to gather your things and head back to camp, but as you set out, you swear you could hear the sound of ghostly laughter echoing through the trees.\n\n");
				if (player.cumQ() < 10000 || (!player.hasCock() && player.lactationQ() < 10000)) {
					outputText("<b>Due to the residual effects of the sisters' magic, your ");
					if (player.hasCock()) {
						outputText("cum ");
						if (player.cumQ() < 500) player.cumMultiplier += 3;
						if (player.cumQ() < 2000) player.cumMultiplier += 2;
						if (player.cumQ() < 10000) player.cumMultiplier += 1;
					}
					else {
						outputText("milk ");
						if (player.lactationQ() < 500) player.boostLactation(3);
						if (player.lactationQ() < 2000) player.boostLactation(2);
						if (player.lactationQ() < 10000) player.boostLactation(1);
					}
					outputText("production has been enhanced.</b>");
				}
				model.time.hours = 6;
				model.time.days++;
				if (!getGame().inCombat)
					doNext(camp.returnToCampUseOneHour);
				else combat.cleanupAfterCombat();
			}
		}

		private function mansionBadEnd():void
		{
			clearOutput();
			kitsuneSprite();
			// Kitsune's Thrall Bad End
			outputText("Your dreams are cut short as you awaken with a start, launching yourself bolt upright.  You are drenched in a frigid sweat, panting from an unexplained sense of dread that still has you in a panic.  The dread only worsens when you take stock of your surroundings.  For a moment you think you are back in Ingnam, but the unfamiliar surroundings push the notion from your mind as soon as it forms.  Neither are you in your " + camp.bedDesc() + " in camp, however.  Gradually, you piece together the events of the previous night through the miserable pounding in your skull.\n\n");
			outputText("\n\nThe realization hits you like a bag full of rocks, and you spring to " + ((player.isBiped()) ? "your feet" : "action" ) + " immediately, leaping off the comfortable bed.  Your " + player.armorName + " are gone, replaced by exotic robes woven of fine silk.  What's more, you have no weapon to speak of!  Still reeling a bit from your hangover, you stumble out into the hallway, looking for a way out before the mansion's mysterious owners get wind of your egress.\n\n");
			outputText("Your muscles are filled with fatigue and soreness from the night's activities, and it feels as though you are carrying a rucksack full of lead on your shoulders.  Just how long were the three of them at it after you passed out?  By the throbbing pain you feel in your hips, it feels like must have kept going all night long.\n\n");
			outputText("You wander the meandering hallways of the manor for what feels like ages, searching for any sign of an exit.  At last, you find yourself in a familiar area, vaguely recalling passing through this room on the way to the banquet that the sisters had prepared for you.  Only now can you truly appreciate what a terribly foolish idea it was to accept food from the three mischief-makers.\n\n");
			outputText("Escape is in sight, the front door coming into sight as you round the corner.  The hallway seems to stretch on for eternity as you make a beeline for the exit, the door never coming any closer.  A sinking feeling enters the pit of your stomach as your hope of escape is squashed with just four words.\n\n");
			outputText("\"<i>Leaving so soon, dear?</i>\"\n\n");
			outputText("You wheel around to face the manor's three mistresses, beckoning to you with offerings of food and drink in hand.  Though their expressions are innocently jovial, they carry an air of malevolence as they slowly close in on you.\n\n");
			outputText("\"<i>Won't you stay just one more night?  You can rest your weary bones, and drink your fill...</i>\"\n\n");
			outputText("You decline their offer, continually backing your way toward the door.  When they are no more than an arm's length away, you make a break for it, spinning in place and dashing madly toward the door - but alas, your ill-fated escape attempt meets with dismal failure.  No sooner have you turned away then you face them once again, and this time they block your escape.\n\n");
			outputText("\"<i>Please, be our guest....  It gets so lonesome out here, just the three of us...</i>\"\n\n");
			outputText("Throwing caution to the wind, you rush them, pushing past and barging through the door, filling your lungs with the fresh breath of freedom.  What meets you on the other side makes your heart sink, for you find not the open air of the courtyard, but another stretch of hallway, identical to the one you just left.  There to meet you beyond the threshold are the three kitsune, their lips pursed in identical smirks.\n\n");
			outputText("As they crowd around, you can feel the lights in your mind flickering off one by one.  Azure flames swirl about the room, capturing you in their hypnotic thrall as you slowly drop to the floor, entranced by the kitsune's witchery.\n\n");
			outputText("\"<i>You'll stay, won't you?</i>\"  the blonde says, placing her hand under your chin and delicately tipping your head back to look up into her eyes.  As you feel yourself being pulled into the depths of those green pools, you hear someone voicing their assent, only to realize that the voice was your own.\n\n");
			outputText("You cling to the last vestiges of your mind with all your might, but to no avail.  Your mind, still muddied by the spirits you imbibed the night before, succumbs to the three enchantress' hypnotic power.  Eighteen bushy tails curl around you, pulling you up into a warm, calming embrace, and you have just enough time to register a cool tingling sensation spreading throughout your body before the last glimmer of free will you possess is snuffed out forever.");
			doNext(kitSuneMansionBadEndII);
		}

		private function kitSuneMansionBadEndII():void
		{
			clearOutput();
			kitsuneSprite();
			outputText("It is difficult to say how much time has passed since you came to reside here.  Time holds no meaning in this place, entrapped for all eternity in the space between worlds.  Now and again, a glimmer of your former self bubbles to the surface of the constant murky haze that is your mind now, and you have a faint recollection of a purpose beyond serving your mistresses.\n\n");
			outputText("Though it is only the vaguest shadow of a memory, on nights such as this it compels you to search for a way to leave, shambling through the maze of eternally shifting corridors and twisting hallways that make up the manor.  Your search is never-ending, each new room warping reality in new ways, your paths looping back on each other and winding their way through eldritch realms not fit to be seen by mortal eyes.  No matter how convoluted your route, your journey always ends in the same place.\n\n");
			outputText("The moment your will begins to fade, you are deposited at the threshold of the sisters' bedroom, your weary spirits dulling your thoughts as the desire to serve your mistresses forces its way back to the forefront.  They greet you at the doorway, tonight wearing sheer gowns of almost transparent silk as they usher you inside.\n\n");
			outputText("\"<i>Come inside, dear.  Let us ease your tension,</i>\" the blonde whispers as she draws you into a soothing embrace.\n\n");
			outputText("The trio surrounds you, lavishing you with affectionate kisses and caresses as they lead you toward the bed, undressing you along the way.  Their soft fingertips slide over your " + player.skinFurScales() + " as they draw open your silken robe, easing it down your upper body.  They gently caress your [chest], their many tails busily brushing up and down your back, teasing you with the tips.  After what feels like ages, your robes fall to the floor in a heap, revealing the abomination that is your lower body.  A writhing mass of tentacles has replaced your body from the hip down, dozens of slippery tendrils branching out where your pelvis once joined with a pair of human legs.\n\n");
			outputText("The thicker ones, covered in small suckers, serve to support your weight while the remainder twist and wriggle in the air, instinctively seeking out the touch of bare flesh as three silk robes are shed.  Taking on a mind of their own, they wrap around the bed posts, hoisting you up and pulling the three kitsune along.  Each girl grins with anticipation as they are slowly entangled in your many writhing appendages.  Together, they lay you back on the bed, jostling each other for prominence as they each raise their heavy hindquarters into the air, dragging sparks down your chest with their fingertips.\n\n");
			outputText("Six of your muscular prehensile appendages slither down between their jiggling cheeks, eliciting a moan and a shiver from each of them.  Poised at the entrance of each hole, you howl with ecstasy as you penetrate them one at a time, raising your voice with them in a chorus of pleasure.  Your voice is abruptly muffled when you feel the thick, meaty shaft of the redhead's cock slide into your throat, your muscles relaxing on cue to take it in its entirety.  Her hands slide to the back of your neck as she throws her head back in pleasure, thrusting her hips forward as the tentacles stuffing her ass and pussy drive in deeper, creating a visible outline in her stomach.\n\n");
			outputText("Your raven-haired mistress has her own plan, taking up the largest tentacle she can find and wrapping her arms, legs, and tails around it, slowly drawing it into her mouth.  Her moans vibrate through you as she pulls it deeper and deeper into her throat, a bulge in her neck widening with each new intake of tentacle.  She won't be satisfied until every nook and cranny is filled to the brim with wriggling, meaty tendrils, but as a humble servant, you are only happy to oblige.\n\n");
			outputText("Throwing herself back, the blonde spreads her legs wide, catching several thick tentacles with the soles of her feet and gently rubbing them back and forth as she guides them down between her thighs.  She groans like a cheap whore as she forces one after another of your thick tentacles into her slick snatch, stuffing the already stretched passage with still more undulating feelers.  Her hungry cunt's limitless depths surround you, strong muscles rippling across the half-dozen squirming tendrils that she has already managed to force inside.\n\n");
			outputText("The glimmer of your past is long forgotten, and all you are left with is the depravity with which they use your many-limbed body, an abominable form they themselves bestowed upon you.  Each night they ravage you to the point of exhaustion, their twisted magic sustaining you well beyond the endurance of a mortal, to fuel their own twisted desires.\n\n");
			outputText("You are forever the sisters' servant now, a beast of pure perversion cultivated for the sole purpose of providing them pleasure.\n\n");
			outputText("<b>THE END</b>");
			getGame().gameOver();
		}


//[Fight]
		private function fightSomeKitsunes():void
		{
			clearOutput();
			outputText("Something just doesn't sit right with you about this woman, and you cautiously raise your " + player.weaponName + ", watching her carefully.\n\n");
			startCombat(new Kitsune(monster.hairColor));// TODO refactor
			kitsuneSprite();
			//Blonde
			if (monster.hairColor == "blonde") outputText("\"<i>Ah, so we're going to play like that, are we?</i>\"  she says with a grin, making a small clawing motion in the air.  \"<i>Very well my darling, if that's how you want it, but I won't be taking it easy on you just because you're cute~.</i>\"");
			//Black Hair
			else if (monster.hairColor == "black") outputText("\"<i>Oh, dear...  are you sure you can't just spare the tiniest morsel?  I'm so hungry...</i>\"\n\nShe licks her lips to accentuate this, rubbing her stomach.  You however, have no intention of being made a meal, or whatever it is she intends to do with you.\n\n\"<i>Well, I guess it can't be helped,</i>\" she says, pursing her lips impishly.");
			//Redhead
			else {
				outputText("\"<i>Oh, you're not going to make this easy for me, are you?</i>\"");
				outputText("\n\nWith a wry grin, she stands back and cracks her knuckles, and your eyes are drawn down to a slight tent in her robes.  \"<i>Good, I like when my prey has a little fight in it.  Just don't go crying if you lose~.</i>\" she says, one hand sliding down to caress the bulge hugging her thigh.  Whatever she's packing, it's at least 12 inches long, and she seems pretty keen on using it.");
			}

			outputText("\n\n<b>You are now fighting a ");
			if (monster.hairColor == "blonde") outputText("blonde");
			else if (monster.hairColor == "black") outputText("black-haired");
			else outputText("red-haired");
			outputText(" kitsune!</b>");
			doNext(playerMenu);
		}


		public function loseToKitsunes():void
		{
			clearOutput();
			if (doSFWloss()) return; //No rape in SFW mode.
			var scene:Array = [];
			//[LOSE FIGHT]
			//Shared Scenes
			// For Males and Herms
			if (player.hasCock()) scene.push(loseFightToHerms);
			// For Females and Genderless
			if (player.gender != 1) scene.push(femalesAndNuetersLoseToKitsunes);
			//Blonde-exclusive
			//Single cock < 9 inches long
			if (monster.hairColor == "blonde" && player.cockTotal() == 1 && player.longestCockLength() < 9) {
				scene.push(blondeKitsuneRapesSmallWangs,blondeKitsuneRapesSmallWangs,blondeKitsuneRapesSmallWangs,blondeKitsuneRapesSmallWangs);
			}
			//Black-hair-exclusive
			//Lose while lactating
			if (monster.hairColor == "black" && player.lactationQ() >= 50) {
				scene.push(loseToBlackHairLatexWhileMilky,loseToBlackHairLatexWhileMilky,loseToBlackHairLatexWhileMilky,loseToBlackHairLatexWhileMilky);
			}
			// lose, requires balls and cumQ() > 1000
			if (player.hasCock() && player.balls > 0 && player.cumQ() > 1000) {
				scene.push(loseToKitsunesWithBallsAndHighCumQ,loseToKitsunesWithBallsAndHighCumQ);
			}
			//Redhead-exclusive
			//Futa rape - chance increases as redhead's lust increases
			if (monster.hairColor == "red") {
				scene.push(getRapedByRedHeadFutaKitsune);
				if (monster.lust > 50) scene.push(getRapedByRedHeadFutaKitsune);
				if (monster.lust > 70) scene.push(getRapedByRedHeadFutaKitsune);
				if (monster.lust > 85) scene.push(getRapedByRedHeadFutaKitsune);
			}
			scene[rand(scene.length)]();
		}

//[LOSE FIGHT]
//Shared Scenes
// For Males and Herms
		private function loseFightToHerms():void
		{
			clearOutput();
			kitsuneSprite();
			var biggest:int = player.biggestCockIndex();
			outputText("\"<i>If you were going to give up that easily, you could have said so in the beginning and saved yourself the trouble!</i>\"\n\n");
			outputText("Her tittering laughter rings in your ears, broken momentarily as she grunts with the effort of rolling you onto your back.\n\n");
			outputText("\"<i>Time to claim my prize...</i>\"\n\n");
			outputText("Humming quietly, she carefully removes your " + player.armorName + ", neatly arranging them into a pile and shoving them off to the side.  Eying your nude form hungrily, she begins to slowly trail her hands down your [fullChest], letting her fingertips cascade over every ridge and curve of your body while painting streaks of dazzling fire across your flesh.  Her touch sends tingles up and down your spine, making you shiver and moan involuntarily.  Slowly but surely her hands work their way down toward your loins, teasing around your [hips] very gently" + ((player.isBiped() ) ? ", tickling the insides of your thighs" : "") + " before trailing up to your " + ((player.gender >= 2) ? "rapidly moistening cleft.  Her fingers dance along the inside of your labia, circling the entrance and nearly - but never quite - pushing a fingertip inside, snickering in satisfaction as you release a small rush of fluids into her palm.  She glides the tip of one of her tails across your [clit] delicately, like a feather, before turning her attention to her real prize, your " : "") + "gradually hardening [cock biggest].\n\n");
			outputText("Holding you firmly around the " + ((player.hasSheath()) ? "sheath" : "base" ) + ", she crawls the fingers of her free hand up and down the shaft, marking the underside with tiny beads of flame that spark and tingle incredibly as they lick across your rigid rod.  It doesn't take but a few moments of this treatment before you are teetering on the edge, but the skillful seductress has other plans for you, and dials back the pleasure mere moments before your release.\n\n");
			outputText("\"<i>Oh no dear, the fun's only just begun,</i>\" she says with a mock chastising tone, smirking mischievously.\n\n");
			outputText("Quick as lightning, three of her tails lash forward and lasso your cock tightly, wrapping and sliding around the shaft with their remarkably soft fur.  The shimmering coils move up and down your member at a slow, teasing pace, squeezing and twisting gently to drag you toward the edge of pleasure, each time letting you drift back down before resuming their wonderful torture.\n\n");
			outputText("Her tails continue to operate independently as she crawls up over you, setting her soft, cushiony behind on your [hips] and scooting backward until [eachCock] is enveloped in the warm globes.  Two tails curl up and gently lift the hem of her robe to expose the soft, jiggling flesh of her ass, and she wiggles her hips teasingly to make the huge cheeks quiver lightly around your [cock biggest].  Sliding her hands down her shoulders and over the jiggling mounds of her breasts, she hooks her fingers into her robes and drags them down so that her perky nipples are just barely contained.  With an agonizing slowness, she strips out of her robes, watching you the entire time and laughing seductively at your reactions to her teasing display.  With her clothes tossed aside and out of the way, you have a full view of her young, lithe body, " + ((monster.hairColor == "blonde") ? "flowing golden locks cascading over her toned, voluptuous hourglass shape." : ((monster.hairColor == "black") ? "a slight pudge around her belly accentuating her voluptuous figure." : "your eyes drawn immediately down to the pulsating, foot long member that now lays across your stomach.") ) + "  Grinning coyly, she strikes an alluring pose and leers at you through half-lidded eyes, one corner of her mouth curled up in a mirthful smirk.\n\n");
			outputText("\"<i>Mm...  getting all hot and bothered dear?</i>\"  she says, almost in a whisper, her voice dripping with seduction.\n\n");
			outputText("As she leans down to press her chest to yours, her tails continue to twist and slither around your [cock biggest], teasing and squeezing and painting your genitals with their mystical fire.  Her voluptuous cheeks rise and fall along the upper edge of your cock, quivering gently while she caresses your cheek, planting a small kiss just below your chin.  Lush, full lips press against yours, carrying the sweet taste of wintergreen.  Her fingers clasp against the back of your head with a surprisingly strong grip, and she releases a powerful moan into your lips, a tingling coolness spreading over your tongue before moving on to the rest of your body.\n\n");
			outputText("Her magic flows through your body, permeating your extremities and filling you with a shivering, shuddering lust.  You forget in short order that you are the unwilling participant in this conniving trickster's game, rationality subverted by baser instincts.  The heat of her loins emanates around your [cock biggest], and all you can think about is that glorious, ecstatic moment of penetration.  Surely, it will come soon.  Surely, she can't tease you like this forever...\n\n");
			outputText("The tip of her tongue pokes out between her teeth as she carefully raises and lowers her hips, caressing your shaft in the warm valley between her two fleshy cheeks.  Her pace is slow and methodical, perfectly metered to keep you teetering constantly on the edge and yet never quite enough to push you over it.\n\n");
			outputText("\"<i>Oh, you poor thing,</i>\" she croons, watching your face contort into a grimace of shameless desire.  Why won't she get on with it already!?  She swats your hands away as you reach up to try to assert control of the situation, two tails curling forward to bind your wrists.  \"<i>Naughty naughty!  You can look, but </i>I'll<i> be the one who does the touching today, dear.</i>\"\n\n");
			outputText("You struggle against her bushy coils, but to no avail.  Staring into the limpid green pools of her eyes, it becomes abundantly clear that physical resistance is going to get you nowhere - her hypnotic sorcery has left your muscles sapped of strength, hanging uselessly in the grip of her tails.  Her fingers slowly dance across your [chest] again, drawing intricate patterns of flame down your front and giggling.  You breathe in sharply as she finally begins to raise her hips, sliding the warm, wet cleft of her pussy across your shaft.  Your excitement builds steadily as her moist lips spread around the [cockHead biggest] of your [cock biggest], feminine juices dripping down the side of your shaft slowly.  A moan escapes your lips as she rocks her hips forward and back, circling her entrance with the tip of your member while grinning at you slyly.\n\n");
			outputText("\"<i>You want this, huh?  You want it bad?</i>  she teases, putting the tiniest bit of pressure onto your throbbing member.  The head of your cock presses against the tight ring of muscle at her entrance, on the very precipice of penetration, but the kitsune seems to enjoy torturing you immensely, never quite allowing you passage.\n\n");
			outputText("You whimper with need as she slides herself back down the underside of your shaft, pinning your cock to your front and grinding her hips forward and back slowly.  Back and forth she slides, the stiff bud of her clit tickling your rod gently as she continues to tease you, grinning with an almost sadistic glee.  The slick juices from her sopping cunt flow over the edges of your shaft, coating you in a thin layer of lubricant in short order" + ((monster.hairColor == "red") ? ", while a trickle of precum flows from the tip of her throbbing cock, threads of viscous fluid dripping onto your stomach" : "") + ".\n\n");
			outputText("Your eyes roll back in your head and you moan desperately, struggling in vain to thrust your hips upward to give you the push you need to finally finish.  Just as you are sure you'll go out of your mind with pleasure, she slides herself forward, leaning down and grabbing your shoulders while kissing you deeply.  You feel her tails sliding up beneath your cock, lifting it into position, and then your vision explodes into a sea of colors as the intense pleasure of entering her pussy is finally, gloriously given to you." + ((player.biggestCockArea() > 50) ? "  There's no possible way that she could fit something of that size inside her comfortably, and yet somehow she does it with ease, inch after inch of warm, incredibly tight pussy flesh stretching to accommodate your massive member." : "") + "  Her hips slide back until they are even with yours, your cock entirely ensconced in the soft, wet warmth that is her vagina.\n\n");
			outputText("Her tongue plunges into your mouth passionately as she begins to ride up and down on your [cock biggest], a single tail curled around your " + ((player.hasSheath()) ? "sheath" : "base" ) + " tightly.  Blood rushes into your groin with no escape, making your member swell up within her pussy and intensifying the already incredible feelings of her muscles carefully squeezing and constricting around you.  Tongues of blue flame lick across your " + player.skinFurScales() + " as her tails paint sparks along your body like a set of artist's brushes, making you shiver with pleasure.  Each time she draws herself forward off of your cock, powerful muscles squeeze your shaft tightly, rippling across your entire length and then drawing you back inside.\n\n");
			outputText("The pleasure proves too much to bear, even more so after her incessant teasing, and it doesn't take long before you feel your " + ((player.balls > 0) ? player.ballsDescriptLight() : "prostate" ) + " swelling with the pressure of your climax.  The tail around your " + ((player.hasSheath()) ? "sheath" : "base" ) + " tightens up considerably, and the kitsune begins to ride you with an even fiercer passion, her expansive cheeks making loud slapping noises each time they slam down on your [hips].\n\n");
			outputText("\"<i>Almost, dear!  Mn, just a bit, ah!  More...</i>\"\n\n");
			outputText("She leans back and supports herself on your chest, thrusting her hips and mashing her pelvis down against yours with a passionate ferocity that has her breasts bouncing " + ((monster.hairColor == "red") ? "and her cock flopping " : "" ) + "up and down shamelessly.  Her pussy wrings your cock powerfully from " + ((player.hasSheath()) ? "sheath" : "base" ) + " to tip, each rippling motion of her insides caressing you on all sides with an inhuman level of control and skill.  Her pace continues to climb as her own orgasm builds, eyes rolling skyward as she grinds down more forcefully than ever, heedless of your desperate pleas for release." + ((monster.hairColor == "red") ? "  As her orgasm draws near, one of her tails curls forward and begins to stroke her cock, drops of salty precum splashing across your lips." : "") + "  With a satisfied shudder, she arches her back, dropping her hips down onto you one last time, and moans in euphoric ecstasy, her tails unwinding from around your limbs.  A rush of fluid drenches your waistline, " + ((monster.hairColor == "red") ? "hot streams of cum spurting from her twitching cock and laying streaks of pearly white across your face, neck, and chest." : "a warm spray of femcum arcing from her pussy to spatter across your face, neck, and chest.") + "\n\n");
			outputText("As her climax tears through her, her tail slackens its grip around your " + ((player.hasSheath()) ? "sheath" : "base" ) + ", and you are finally able to achieve release from your torment, your thick load rushing up your shaft to explode into the kitsune's quivering loins.  ");
			if (player.cumQ() <= 150) {
				outputText("Hot, sticky streams spurt up into her, painting her womb white with your cum.  Her walls squeeze and milk your shaft, greedily pulling out every last drop of seed you have to offer.");
			}
			else if (player.cumQ() <= 350) {
				outputText("Hot ribbons of cum splatter against her cervix, bubbling up into her womb.  Her walls squeeze hard, a muscular rippling drawing every last drop of seed from your shaft and milking it hungrily.");
			}
			else if (player.cumQ() <= 1000) {
				outputText("Your cock swells from base to tip with each new stream of cum, filling her womb with your warm, potent seed.  Her pussy squirms and squeezes around your cock, milking you for all you're worth.  As more of your frothing jism flows into her, a small bump forms in her belly, stretching out into a gentle curve.");
			}
			else if (player.cumQ() <= 2500) {
				outputText("A glut of semen rises through your throbbing shaft, erupting into her womb like a sticky white volcano.  Her pussy convulses and squeezes around you, milking your shaft powerfully and sucking out every last drop of your sticky jism.  With every fresh stream that flows into her, her belly expands a bit more, swelling out into a nice, jiggly bulge.");
			}
			else {
				outputText("Thick, virile streams of cum swell through your cock, splattering across her walls and flowing into her womb like a river.  As your cock throbs and twitches inside her, her pussy squeezes and convulses powerfully, funneling every drop upward toward her womb.  Her abdomen swells outward, ballooning into an obscene, jiggling sphere that sloshes with the weight of your inhuman load.");
			}
			outputText("\n\nSighing deeply in utter satisfaction" + ((player.cumQ() > 350) ? " with one hand resting on her stomach" : "" ) + ", she leans back, swiveling her hips a little to tease your spent cock.  Drenched in her " + ((monster.hairColor == "red") ? "musky futa-cum" : "feminine juices") + ", you twitch lightly as bliss and fatigue spread through your body in equal measure.  She leans forward again, dropping her lips to your ear, and whispers a short incantation while stroking the side of your face.\n\n");
			outputText("The last thing you see before blacking out is a pair of delightfully plump, round cheeks jiggling happily as the kitsune gathers her robes.");
			player.orgasm();
			dynStats("lib", 1, "sen", 1);
			combat.cleanupAfterCombat();
		}

// For Females and Genderless
		private function femalesAndNuetersLoseToKitsunes():void
		{
			clearOutput();
			kitsuneSprite();
			outputText("\"<i>My, oh my, finished already?</i>\"  the kitsune says as she leans over your slumped form, grinning coyly.  \"<i>If you were going to give up that easily, you could have said so in the beginning and saved yourself the trouble!</i>\"\n\n");
			outputText("Her tittering laughter rings in your ears, broken momentarily as she grunts with the effort of rolling you onto your back.\n\n");
			outputText("\"<i>Hehe, time to claim my prize...</i>\"\n\n");
			outputText("Humming quietly, she carefully removes your " + player.armorName + ", neatly arranging them into a pile and shoving them off to the side.  Eying your nude form hungrily, she begins to slowly trail her hands down your [fullChest], letting her fingertips cascade over every ridge and curve of your body while painting streaks of blue fire across your flesh.  Her touch sends tingles up and down your spine, making you shiver and moan involuntarily.  Slowly but surely her hands work their way down toward your loins, teasing around your [hips] very gently" + ((player.isBiped()) ? ", tickling the insides of your thighs" : "") + " before trailing up to your " + ((player.gender == 2) ? "rapidly moistening cleft.  Her fingers dance along the inside of your labia" : player.assholeDescript() + ".  Her fingers dance along between your cheeks") + ", circling the entrance and nearly - but never quite - pushing a fingertip inside, snickering in satisfaction as you release a small rush of fluids into her palm." + ((player.gender == 2) ? "  She glides the tip of one of her tails across your [clit] delicately, like a feather, flicking it up and down." : "" ) + "\n\n");
			outputText("The tip of her index finger presses " + ((player.gender == 2) ? "into the end of your clitoris" : "against your pucker gently") + ", leaving behind a tiny bead of fire that tingles incredibly as the azure tongues lick at your nethers.  It doesn't take but a few moments of this treatment before you are teetering on the edge, but the skillful seductress has other plans for you, and dials back the pleasure mere moments before your release.\n\n");
			outputText("\"<i>Oh no dear, the fun's only just begun,</i>\" she says with a mock chastising tone, smirking mischievously.\n\n");
			outputText("She slides forward, daintily settling down on your hips and pinning you under the weight of her expansive behind.  " + ((player.isBiped()) ? "A pair of fluffy tails slides in between your legs, curling around them and spreading them up and apart, the remaining tails taking advantage of your helpless state and beginning to brush up and down the insides of your thighs, one tip sliding up and down " + ((player.gender == 2) ? "the sensitive cleft of your vagina" : "between the cheeks of your " + player.buttDescript() ) + "." : "Her tails drift over your sensitive crotch, brushing the tip " + ((player.gender == 2) ? "along the cleft of your vagina" : "between the cheeks of your " + player.buttDescript() ) + " and tickling it sensually.") + "  Sliding her hands down her shoulders and over the jiggling mounds of her breasts, she hooks her fingers into her robes and drags them down so that her perky nipples are just barely contained.  With an agonizing slowness, she strips out of her robes, watching you the entire time and laughing seductively at your reactions to her teasing display.  With her clothes tossed aside and out of the way, you have a full view of her young, lithe body, " + ((monster.hairColor == "blonde") ? "flowing golden locks cascading over her toned, voluptuous hourglass shape." : ((monster.hairColor == "black") ? "a slight pudge around her belly accentuating her voluptuous figure." : "your eyes drawn immediately down to the pulsating, foot long member that now lays across your stomach.") ) + "  Grinning coyly, she strikes an alluring pose and leers at you through half-lidded eyes, one corner of her mouth curled up in a mirthful smirk.\n\n");
			outputText("\"<i>Mm...  getting all hot and bothered dear?</i>\"  she says, almost in a whisper, her voice dripping with seduction.\n\n");
			outputText("As she leans down to press her chest to yours, her tails continue to twist and slither over your groin, teasing and painting your " + ((player.gender == 2) ? "slick slit " : "anus") + " with their mystical fire.  She starts to gradually grind her hips forward and back on your abdomen, her cheeks quivering gently while she leans forward to caress your face, planting a small kiss just below your chin.  Lush, full lips press against yours, carrying the sweet taste of wintergreen.  Her fingers clasp against the back of your head with a surprisingly strong grip, and she releases a powerful moan into your lips, a tingling coolness spreading over your tongue before moving on to the rest of your body.\n\n");
			outputText("Her magic flows through your body, permeating your extremities and filling you with a shivering, shuddering lust.  You forget in short order that you are the unwilling participant in this conniving trickster's game, rationality subverted by baser instincts.  Pure molten desire rushes to your loins, and all you can think about is your own glorious release.  Surely, it will come soon.  Surely, she can't tease you like this forever...\n\n");
			outputText("Her tails spread " + ((player.gender == 2) ? "the lips of your vagina as wide as they will stretch" : "your cheeks apart") + ", a third gently drawing circles of flame around your " + ((player.gender == 2) ? "clitoris while a fourth presses insistently against your entrance" : "puckered anus") + ".  The soft brush pushes forward to meet the resistance of your " + ((player.gender == 2) ? "moist, pink flesh" : "muscular ring") + ", teasing you with the promise of penetration, yet never quite finding its way inside.\n\n");
			outputText("\"<i>Oh, you poor thing,</i>\" she croons, watching your face contort into a grimace of shameless desire.  Why won't she get on with it already!?  She swats your hands away as you reach up to try to assert control of the situation, two tails curling forward to bind your wrists.  \"<i>Naughty naughty!  You can look, but </i>I'll<i> be the one who does the touching today, dear.</i>\"\n\n");
			outputText("You struggle against her bushy coils, but to no avail.  Staring into the emerald pools of her eyes, it becomes abundantly clear that physical resistance is going to get you nowhere - her hypnotic sorcery has left your muscles sapped of strength, hanging uselessly in the grip of her tails.  Her fingers slowly dance across your [chest] again, drawing intricate patterns of flame down your front as she giggles happily.  Slowly, agonizingly, her tail lowers against your " + ((player.gender >= 2) ? player.vaginaDescript() : player.assholeDescript() ) + " again, spiralling and twisting at the entrance.  The soft, luxurious fur feels incredible against your nether regions, excitement building as she comes ever closer to finally thrusting it in, circling just outside it for an unbearably long time.\n\n");

			outputText("\"<i>You want this, huh?  Show me just how bad you want it,</i>\" she teases, " + ((player.gender == 2) ? "gently reaching back to press her fingertip to your [clit], rolling it back and forth between her thumb and forefinger." : "dragging her index finger in a circle around your navel.") + "  The tip of her tail slips ever so slightly into your needy hole, swiveling and swirling around the inside before withdrawing and leaving you desperately wanting.\n\n");
			outputText("You groan and thrash to the best of your ability underneath her, trying in vain to raise your hips to meet her tail, which is hovering tortuously just out of reach.  Slick juices dribble down your abdomen as she grinds herself across you" + ((monster.hairColor == "red") ? ", her cock leaking copious amounts of precum onto your belly as well" : "") + ", an intense heat radiating from between her legs and betraying her own desire.\n\n");
			outputText("Your eyes roll skyward and you moan lewdly, squirming and thrashing beneath her and trying your hardest to overcome her hypnotic hold on you, that you might take control and grant yourself the release you so desperately need.  Just as you are certain that you'll go out of your mind, she leans forward, grabbing your shoulders and pulling you into a long, drawn-out kiss.  The tail that has been constantly, teasingly strafing your entrance at last twists itself into position, and your vision explodes into a sea of colors as it thrusts inside, burying itself deep inside your " + ((player.gender >= 2) ? player.vaginaDescript() : player.assholeDescript() ) + " in one pass.  Lying flat against your [chest], the kitsune raises her jiggling ass into the air, putting most of her weight into the passionate lip-lock.  A licentious schlick echoes through the air as the kitsune threads a second tail down through the loop of the first, plunging it into her own sopping pussy with a groan.\n\n");
			outputText("" + ((monster.hairColor == "red") ? "Her cock throbs hotly between your stomach and hers, precum and fem-juice lubricating its passage as she rocks herself back and forth.  " : "" ) + "Brushlike tails and soft fingertips caress every curve and ridge of your body with a tender passion, leaving trails of flame tingling in their wake.  With each passing second, the tail in your " + ((player.gender >= 2) ? player.vaginaDescript() : player.assholeDescript() ) + " pumps more furiously, slinging droplets of your juices through the air and filling the forest with your scent.\n\n");
			outputText("A sudden chill rushes up your spine as an intense tingling begins to emanate through you from the core, sending you into a convulsion of pleasure.  In the seconds before your eyes roll back in ecstasy, you can see a faint light issuing from your abdomen as the kitsune's tail sets you alight from within!  Strength momentarily surges back into your muscles, allowing you to grip the kitsune in an intense embrace, your fingertips digging into her bare back as your body is wracked with pleasure.\n\n");
			outputText("Your reaction elicits an excited moan from the tricky fox woman, causing her to redouble the passionate thrusting of her tails.  She breaks the kiss long enough to groan into your ear, a rush of fluids splashing from her slick cunt and dripping down onto yours.\n\n");
			outputText("\"<i>Almost, dear!  Mn, just a bit, ah!  More...</i>\"\n\n");
			outputText("Grinding her hips along your front shamelessly, she gropes at your shoulders and [chest] while pounding your " + ((player.gender == 2) ? "pussy and hers alike" : "asshole and her own sopping fuckhole") + " with her tails.  Faster and faster the slickened coils drive into you, dazzling jets of flame dancing across your groin and sending jolts of pleasure through your body like lightning.  The kitsune's fingers grip your biceps almost painfully as she reaches her climax first, a torrential downpour of juices spraying out around her tail as it whips out of her with a flourish." + ((monster.hairColor == "red") ? "  Warmth spreads across your abdomen as her cock twitches and throbs in between your body and hers, thick ribbons of semen spilling out over your stomach.  Stream after stream of thick futa-jizz squelches between your bodies, clinging to your chest and rolling off in glistening, pearly globs." : "") + "\n\n");

			outputText("Your " + ((player.gender >= 2) ? player.vaginaDescript() : player.assholeDescript() ) + " bears down on her tail tightly, squeezing and rippling around the soft fur.  Powerful spasms of pleasure shudder through you as your orgasm comes into full effect." + ((player.wetness() >= 4) ? "  A hot spray of femcum arcs through the air, splattering across the horny fox lady's behind and drenching her tails with your viscous fluids." : "") + "  Her tail continues to thrust into you violently through your climax, prolonging it for several minutes, heedless of your desperate thrashing.  At long last, it whips out of you, slinging your slick fluids into the air with a wet slap, and exhaustion begins to take pleasure's place.  You feel as though you haven't slept in days, your eyelids growing heavy as the kitsune leans up, her lips touching the edge of your ear as she whispers a short incantation while stroking the side of your face.\n\n");

			outputText("The last thing you see before blacking out is a pair of delightfully plump, round cheeks jiggling happily as the kitsune gathers her robes.");
			player.orgasm();
			dynStats("lib", 1, "sen", 1);
			combat.cleanupAfterCombat();
		}

//Blonde-exclusive
//Single cock < 9 inches long
		private function blondeKitsuneRapesSmallWangs():void
		{
			clearOutput();
			kitsuneSprite();
			outputText("The precocious kitsune closes in on you with a predatory smirk as you fall to the ground, panting furiously.  You look up at her, fearing for whatever she has in store for you.  Mustering up every bit of willpower you have left, you scramble backward, but as you try to drag yourself up to your feet, you find your face pressing into something incredibly soft.  Six shimmering golden tails curl around your body, and you look up from between the kitsune's sizeable breasts to see her grinning down at you, her expression somewhere between doting and hungry.\n\n");
			outputText("\"<i>Shh...  It'll be easier if you don't resist,</i>\" she whispers, her warm voice melting down your resistance almost instantly.\n\n");
			outputText("Her fingers trail over your cheek, dazzling sparks bursting to life beneath her fingertips and licking across your skin in their wake, making you shiver comfortably.  Though a small part of your mind still urges you to break away from her tender caress, it is extinguished in short order when she slides her hands under your " + player.armorName + ", running her fingertips over your bare body.  You groan involuntarily, shuddering powerfully and feeling your muscles go slack.\n\n");
			outputText("Without taking her hands off of you, she skillfully pulls your " + player.armorName + " off piece by piece using her tails, slowly easing you backward onto the ground.  Fully nude, you give yourself over to her tender touch, shivering as the cool flames zigzag down your [fullChest] toward your groin.  Your " + player.cockDescript(0) + " rises up to brush against the underside of her forearm, twitching lightly.  Smirking gleefully, she gives it a gentle squeeze, pushing it back against your stomach and giggling when she lets it go to watch it spring back, slinging a few thin strings of precum into the air.\n\n");
			outputText("\"<i>Aww, it's so cuuute...</i>\" she says, running her index finger up and down the shaft, a little bead of azure flame following after it.\n\n");
			outputText("Your member throbs and twitches involuntarily, her magical touch making you squirm and fidget in pleasure as she drags her fingertip across your sensitive prick.  Your hips buck upward all by themselves, a slick string of precum squeezing out of your cock and landing on the kitsune's face just above her nose.\n\n");
			outputText("\"<i>No!  Bad!</i>\"  she says, flicking you across the nose with a playful scowl.  She takes your cock in her hand and presses down on your [hips], forcing you back down to the ground and pinning you with a surprising amount of strength.\n\n");
			outputText("Her tails snake forward, curling around your limbs, and you find yourself pinned, struggling in vain against the uncommonly strong furred coils.  She nods, satisfied with your helplessness, and leans down to gently nuzzle your " + player.cockDescript(0) + ", cooing softly and sliding her soft, wet tongue along the underside from base to tip with a small giggle.  Her tongue swirls back and forth along the underside of your " + player.cockHead() + ", wrapping around it and slurping up your slick precum.\n\n");
			outputText("\"<i>Mm...  that's more like it.</i>\"\n\n");
			outputText("With a satisfied grin on her face, she sits upright again, pulling her robes down slowly.  You can only lie back and watch her disrobe, your member bobbing back and forth in the air freely now.  She teases and brushes your groin with her silken tails, smirking coyly as she begins a sensual striptease.  As the upper portion of her robes falls away, her voluptuous, perky breasts bounce freely, and she starts rubbing the sensitive pink nubs, making them pop out gently.  Her hands glide downward, drawing your eyes across her bare, creamy flesh.  You count a number of tattoos adorning her body, but your gaze is transfixed on the one you can see peeking out just over her waistband.  Swaying her hips back and forth, she tugs the sash that holds the lower part of her robes up and gently shimmies them down, turning just slightly to show off her well-toned but expansive ass.\n\n");
			outputText("You get an even better look at it when she straddles your shoulders, lowering the quivering cheeks down onto your face.  Buried underneath the soft mounds, you moan in protest, which only serves to make the kitsune shiver with pleasure.  Before she can smother you, though, she lays herself across your front, giving you just enough room to tilt your head back and take a gulp of fresh air before the tremendous cheeks cover your face again.  Your tongue meets the sickly sweet taste of her pussy, sliding out to part the moist folds and lap up and down along her clitoris.\n\n");
			outputText("Her entire body shudders a bit, and you can now feel her soft breasts squashing against your groin as she leans down to lightly kiss the end of your " + player.cockDescript(0) + ".  She starts to rock her wide, curvy hips back and forth across your face, grinding her crotch into your mouth and moaning.  The tails that aren't pinning your limbs down gently curl underneath your neck, lifting your head up.  You moan into her pussy as you feel her lips softly wrap around the tip of your shaft, her tongue playing along the " + player.cockHead() + " lightly.  Her lips make a soft smacking noise as she pulls away, and she starts to toy with your member gleefully, stroking it teasingly with her index finger just to feel your reactions trembling up through her loins.\n\n");
			outputText("\"<i>Oh yeah, that's right, just like that!  Be a good " + player.mf("boy", "girl") + " and lick mama's pussy,</i>\" she groans, mashing her cunt into your face and riding your tongue with an animalistic passion.\n\n");
			outputText("Her tails flex, pulling your arms up and laying your hands across her delicious derriere, and you begin to squeeze the soft, pliable cheeks of her ass before you can stop yourself.  Your fingers sink deep into the fleshy globes, their delightful jiggle filling your head with all manner of lewd fantasies.  You raise your hips in a vain attempt to garner some attention from your foxy assailant, only to have them shoved back down into the dirt.  " + ((player.inte > 50) ? "Weakened though you may be, you're certain she can't actually be that strong - it <i>must</i> be another one of her illusions." : "You don't remember her being that strong!") + "\n\n");
			outputText("\"<i>No!  You behave, naughty " + player.mf("boy", "girl") + "!</i>\" she growls.  You can practically feel her scowling, despite the fact that your vision is almost entirely obscured by her colossal keister.  To punish you for your transgression, her tails pull your hands away from her ass, and she sits up, smothering you with it.\n\n");
			outputText("Your tongue continues to plumb her depths while you slowly suffocate beneath her jiggling cheeks.  With every ounce of your will, you try to pull away from her sweet-tasting honeypot, but to no avail.  Her tails have wrapped around the back of your head, keeping you snugly crammed into her crotch, and she rides up and down, heedless of your thrashing protests.\n\n");
			outputText("You are finally able to tear yourself away from her slavering cunt with a gasp, sputtering and coughing before taking a deep, desperate gulp of fresh air.  Your chest heaves as you fill your lungs with air, slick juices running down your chin and the smell of her feminine musk permeating your senses.  The respite is brief, however, and your head is mashed back into the dirt by the kitsune's heavy bottom seconds later.  This pattern repeats several more times, and by the end of it you are panting heavily, all thoughts of resistance purged from your mind.\n\n");
			outputText("Satisfied with your submission, she slowly lowers her front to your groin again, wrapping her warm, soft breasts around your neglected member.\n\n");
			outputText("\"<i>Mm, hey there lil' guy,</i>\" she says in a singsong voice, wrapping one arm around her breasts to squash them down and hold them in place while gently fiddling with the tip of your " + player.cockDescript(0) + " using her index finger.\n\n");

			outputText("\"<i>Oooh, right there, lick right there!  If you're a good " + player.mf("boy", "girl") + ", I might just let you cum on my tits.</i>\"\n\n");
			outputText("You nod your agreement before you can stop yourself, realizing that you are not in control of your own body anymore.  Her tails loosen their grip, permitting you to grab handfuls of her plush ass once again, and she begins to slowly slide her precum-lathered tits up and down your pole, giggling incessantly to herself as she watches it twitch within her cleavage.  She rewards your obedience and submission, happily running her tongue across your " + player.cockHead() + " and matching her pace according to how well you please her.\n\n");
			outputText("Desperate for release, you force your tongue deeper into her sweet, sodden gash than you thought yourself capable, urging her in the only way you can think of to give you the climax you desire.  She bucks forward at the sudden deep intrusion, her lips wrapping around the tip of your cock as it is thrust up from between her pillowy jugs.  The warmth of her mouth and the softness of her tongue caressing your shaft sends a shock of pleasure up your spine, and it is all you can do to keep yourself from bucking your hips upward again, knowing full well that nothing good can come of it.\n\n");
			outputText("Her lips rise and fall around your spasming prick, low moans vibrating through it each time she pulls back.  You can feel her cheeks pulling inward from the strength of her suction, loud smacks filling the air each time a gap forms in the almost airtight seal of her lips.  She squashes her breasts down as much as she can, lowering her lips to kiss your " + ((player.hasSheath()) ? "sheath" : "base" ) + ((player.balls > 0) ? " and reaching down to gently stroke your " + player.ballsDescriptLight() : "" ) + ((player.gender == 3) ? ", one of her long, dextrous fingers sliding into your " + player.vaginaDescript() : "" ) + "\n\n");
			outputText("Your moan is muffled by her gushing twat, fingers digging into the malleable flesh of her ass as you stuff your face into her cunt, your lustful wail reverberating through her caverns like a symphony through a concert hall.  In unison, you bury your faces into each other's groins, sucking and licking with unabashed passion.\n\n");
			outputText("Her pussy convulses around your tongue, practically sucking it out of your mouth, and you are abruptly met with the heavy taste of her orgasmic juices, a rush of femcum drenching your face and spurting onto your chest.  Cool air washes over your cock as she pulls her mouth away to belt out a moan, and the pressure in your loins reaches its peak, bubbling over.  ");
			if (player.cumQ() <= 150) {
				outputText("Your cock twitches and spasms wildly, hot streams of cum spurting out to paint thin white streaks across the moaning fox-woman's breasts.  Glistening droplets of seed slowly roll off the curves of her chest, pooling in a small pocket of cleavage as your flagging cock slowly recedes into the warmth of her bosom.");
			}
			else if (player.cumQ() <= 350) {
				outputText("You spurt hot strings of cum over her jiggling breasts, streaking her with white as a few errant streams manage to fling themselves across her chin.  A glistening bead of seed slides down the curves of her neck, joining the rest in a small pool between her breasts, your flagging cock gradually receding into her cleavage.");
			}
			else if (player.cumQ() <= 1000) {
				outputText("Milky white ribbons of cum splatter from your cock, arcing high and crashing down on her face and chest.  Thick globs drip and dribble down her chin, falling to join the puddle of seed pooling between her breasts with a steady, pattering slap as your member slowly recedes into her cleavage.");
			}
			else if (player.cumQ() < 2500) {
				outputText("Your shaft swells with pleasure, slinging thick jets of seed into the air.  In no time, her face, chest, and hair are plastered with a pearly gloss of semen, dribbling and rolling off her in thick, wet globs.  A puddle of seed overflows across her jiggling breasts, your shaft disappearing into the milky white pool as it recedes into her cleavage.");
			}
			else {
				outputText("A thick load of semen swells through your cock, spurting high into the air.  A milky white downpour falls across her head and chest in thick streaks, plastering her with a heavy mask of glistening, pearly cum.  It cascades down the curves of her face and breasts, dribbling and sloughing off of her in globs and sheets.  Each breath she takes causes the lake of seed pooling in her cleavage to overflow onto the ground, your shaft long since disappearing into the depths of her cum-soaked cleavage.");
			}
			outputText("\n\nFinally coming down from her raucous orgasm, the kitsune lets your flaccid member droop out from between her breasts, panting hard as she rolls off of you and sits alongside your exhausted, prone form.  Humming quietly, she cleans herself off using the wide cloth sash from her robes, then turns her attention to you.  With a patronizing smirk, she places her index finger on your nose, leaning down to kiss you on the forehead and whisper a line of strange-sounding gibberish into your ear.\n\n");
			outputText("Your last sight before blacking out from the kitsune's spell is a span of creamy white flesh jiggling seductively, quivering gently beneath a cluster of tails.");
			//<b>You'll probably come to your senses in 8 hours or so, missing X gems</b>" );
			// Advance time 8hrs, lose X gems, return to camp. +Sensitivity +Libido
			player.orgasm();
			dynStats("lib", 1, "sen", 1);
			combat.cleanupAfterCombat();
		}

//Black-hair-exclusive
//Lose while lactating
		private function loseToBlackHairLatexWhileMilky():void
		{
			clearOutput();
			kitsuneSprite();
			outputText("You drop to the ground, struggling to support yourself as your muscles shudder with ");
			if (player.HP < 1) outputText("fatigue");
			else outputText("lust");
			outputText(".  As you collapse, you find yourself being cushioned by a group of silky black tails.  They curl around you and cradle you gently, rolling you onto your back and hoisting you up into a sitting position.\n\n");

			outputText("The kitsune smirks a bit and quickly goes to work getting you out of your " + player.armorName + ", carefully pulling them off and pushing them to the side with one of her tails.  Dragging her fingertips down your [chest] lightly, she leaves little trails of blue fire on your flesh that pop and tingle with each passing second, making you moan with pleasure.  Her index finger circles your [nipple] gently, and her eyes go wide with glee as she sees your creamy milk begin to dribble out, licking her lips hungrily.\n\n");
			outputText("\"<i>Oh, I'm having just the most wonderful luck today!</i>\"  she says with a grin, waggling her fingers lecherously while her tails slip around each of your limbs, pinning them down.\n\n");
			outputText("With the sound of flint striking steel, her fingertips light up with a dazzling display of blue sparks, and she begins to slowly knead and stroke your [chest], painting tiny circles of crackling flame across your body and watching with delight as you squirm in pleasure.  The tingling intensifies over time, spreading across your chest gradually until it truly does feel like you are on fire.  Finally the effects of the kitsune's sorcery become apparent as you feel your [chest] swelling with added weight, the pressure of your welling milk reserves becoming almost painfully unbearable.\n\n");
			outputText("\"<i>Don't worry dear, it won't last for long...</i>\" the kitsune assures you, pinching your turgid nipples teasingly and forcing out a thick stream of milk.\n\n");
			outputText("When she finally wraps her lips around your engorged nipples, you can't stop yourself from bellowing out a moan, every sensation upon your milk-laden tits magnified tenfold.  The corners of her lips curl up into a smile as she starts to suckle, looking up at you with mischief in her big green eyes.  As the intense pressure is suddenly relieved, you arch your back and moan, " + ((player.cocks.length > 0) ? player.sMultiCockDesc() + " becoming rock hard" : "") + ((player.gender == 3) ? " and " : "" ) + ((player.gender >= 2) ? "a puddle beginning to spread between your legs" : "" ) + " from the sheer pleasure of it." + ((player.cocks.length > 0) ? "\n\nSmirking happily, she lifts the back portion of her robes to expose her expansive bottom, lowering the jiggling cheeks against [eachCock].  A few of her tails snake down to coil around " + ((player.cocks.length > 1) ? "them" : "it" ) + ", holding " + ((player.cocks.length > 1) ? "them" : "it" ) + " against her ass and squeezing tightly as they begin to pump up and down slowly.  Though you cannot see it from this angle, you can feel her colossal cheeks quivering sensually around [eachCock], jiggling enticingly with every movement." : "" ) + "\n\n");
			outputText("" + ((player.gender >= 2) ? ((player.gender == 3) ? "Another" : "A" ) + " silken black tail slithers down between your legs, tickling your groin teasingly.  It circles your " + player.vaginaDescript() + " slowly, brushing the tip up against your [clit] and gently toying with the sensitive lips, occasionally pressing up against your entrance and yet never actually penetrating you.  The torment is unbearable, but you are helplessly pinned underneath her, so all you can do is accept her tortuous teasings.\n\n" : "" ) + "");
			outputText("Her tongue laps and swirls over your [nipple] incessantly, draining your milk from one breast while she gently squeezes and caresses the other" + ((player.breastRows.length > 1) ? "s" : "") + ".  When one of your [fullChest] goes dry, she quickly abandons it for " + ((player.breastRows.length > 1) ? "another" : "the other") + " one, using her magic to induce you to produce more.  Over and over, she sucks your tits dry, repeating the cycle at least a half dozen times before you start to lose count.  Every time your breasts begin to fill with milk again, their sensitivity seems to grow.  Eventually you are little more than a shivering, moaning wreck, your [nipples] every bit as sensitive as a clitoris.\n\n");
			outputText("Just when you feel there is no end in sight, a growing tension in your chest and groin tells you that you are on the verge of climax.  Shivers course up and down your spine, and you begin to moan, lightly at first, but growing louder by the second" + ((player.cocks.length > 0) ? ".  [eachCock] twitch" + ((player.cocks.length > 1) ? "" : "es") + ", spurting cum up between the kitsune's ass cheeks and soaking her lower back with your virile spunk" : "") + ((player.gender >= 2) ? ((player.gender == 2) ? "Every" : ", while every") + " muscle in your neglected fuckhole tenses up, squeezing wantonly at nothing as your fluids rush out into a puddle beneath you" : "" ) + "\n\n");
			outputText("Your orgasm is accompanied by a fountain of creamy milk, and the kitsune can't suppress a giggle at the sight of your tremendous orgasm, licking droplets of your milk off her arms and fingers.  As the last ripples of your climax leave your body, your [chest] returns to its normal size, though it seems you are still lactating quite a bit more than before.  Having downed what surely must have been gallons of your milk, the kitsune's belly is a fair bit chubbier than it used to be, and she sighs in satisfaction, patting her stomach gently.\n\n");
			outputText("\"<i>Mm...  that was </i>divine<i>,</i>\" she proclaims, gently leaning forward to kiss you on the forehead.  \"<i>Sleep tight now...  don't let the tentacles bite...</i>\"\n\n");
			outputText("She whispers an incantation in a strange language, and you can slowly feel your already pleasure-worn consciousness leaving you, replaced with a warm, comforting darkness.  Your dreams are haunted by visions of yourself being turned into a human dairy cow, forced to live out the rest of your days as a living milk factory for your hungry kitsune mistress.");
			//<b>You'll probably come to your senses in 8 hours or so, missing X gems.</b>" );
			//Advance time 8 hours, lose X gems, return to camp. +Sensitivity, +Libido, +Lactation Amount
			player.orgasm();
			dynStats("lib", 1, "sen", 1);
			player.boostLactation(1.5);
			if (player.findPerk(PerkLib.Feeder) >= 0) {
				player.addStatusValue(StatusEffects.Feeder, 1, 1);
				player.changeStatusValue(StatusEffects.Feeder, 2, 0);
			}
			combat.cleanupAfterCombat();
		}

// lose, requires balls and cumQ() > 1000
		private function loseToKitsunesWithBallsAndHighCumQ():void
		{
			clearOutput();
			kitsuneSprite();
			outputText("Summarily beaten, you fall to the ground, propping yourself up in one final fleeting moment of defiance.  As you collapse in defeat, the fox-woman skips merrily over to your prone form, pausing momentarily to bend down and give you a patronizing kiss on the forehead.  Gripping you under the shoulders, she drags you bodily toward a fallen log" + ((player.tallness > 96) ? ", her face going beet red with the strain as she finally heaves your half-comatose frame into position" : ((player.tallness > 60) ? ", openly grunting with effort" : "") ) + ".\n\n");
			outputText("\"<i>Let's just see...</i>\"  she quietly muses to herself, slipping her hands under your " + player.armorName + ", <i>\"what we have here...\"</i>\n\n");
			outputText("Her coy grin turns to one of delighted surprise as her fingertips pass over your " + player.ballsDescriptLight() + ", giving them a firm but gentle squeeze.  She licks her lips and eagerly pulls your " + player.armorName + " off with a hungry glint in her eyes, lifting up your [cock biggest] and flexing it slightly as though examining it.  She leans down, her face close to your balls, and drinks in their scent with a long, drawn-out sigh.\n\n");
			outputText("\"<i>Smells like you've got a thick one brewing...</i>\"  she says, softly licking the " + ((player.hasSheath()) ? "sheath" : "base" ) + " with a giggle.  Six inky black tails slither forth to bind your limbs, twisting your wrists behind your back.  \"<i>Let's see if we can't help it along...</i>\"\n\n");
			outputText("She snaps her fingers, blue sparks popping from her fingertips and igniting into a wispy azure flame that dances across her hand.\n\n");
			outputText("You try and fail to suppress a moan as she presses her palms to your balls, an intense tingle crawling across your scrotum as it tightens up.  The tension in your groin builds steadily, and as the flesh of your sack becomes taut, you realize that her magic is causing your balls to physically swell with seed!\n\n");
			outputText("Pulling your [cock biggest] into a double-fisted grip, she squeezes tightly around the base while stroking the shaft vigorously up to full mast.  With a playful smirk, she cups her hand around your [cockHead biggest] and blows into it.  Azure flames cascade down your length, making you arch back and thrust your hips upward involuntarily as cool pleasure spreads across your groin.\n\n");
			outputText("Giggling at your shuddering moans and desperate bucking, she pushes your hips back down, dropping low and pinning you in place with her elbows.  Her soft, voluptuous breasts slide around your [cock biggest]" + (( player.cocks[player.biggestCockIndex()].cockLength > 8 ) ? " while she lavishly licks the exposed portion, wrapping her improbably large tongue around it and squeezing in a tight spiral." : ", and she dips her head down to wrap her plump lips around the head, lavishly licking the underside with her improbably large tongue." ) + "  Her jiggling rump waggles from side to side cheerfully as she goes down on your cock" + ((player.biggestCockArea() > 70) ? " as far as she can, letting your oversized shaft stuff her throat with a moan." : ", lips pressed tight to your groin, slurping up your precum with a sublime grin lifting the corners of her mouth." ) + "\n\n");
			outputText("She pulls back, her plush lips resting just behind the [cockHead biggest] of your cock, the coils of her tongue slowly receding back into her mouth.  The tip gently prods your urethra, and the resultant sensations cause you to shiver heavily.  She wraps one arm underneath her breasts, rolling her shoulders together to squeeze you tightly in her cleavage.  Meanwhile, her other hand slides up beneath your swollen balls, fingertips dancing across the taut flesh daintily.\n\n");
			outputText("\"<i>Mn, how'th thath theel?</i>\" she teases you, punctuating it with a wet slurp as she drops down onto your shaft once again, caressing the head with the entrance of her throat.\n\n");
			outputText("Her eyelashes flutter gently, a low moan humming down your cock as she begins to lightly tweak and roll her nipples between her fingers.  You moan in kind when you feel her fingertips dragging down the sensitive seam of your sack, pale blue sparks crackling across it to elicit even greater pleasure.  She continues to walk her fingers up and down your balls, leaving behind a trail of ghostly flames that tingle incessantly as they lick against your flesh.  After a while, she switches to cupping them in her palm, gently rubbing them as though she could spur them to produce more seed just by doing so.\n\n");
			outputText("Her other arm abandons its duty of holding her breasts against your shaft, and she shifts to an even lower position, letting your [cock biggest] drape across her face as she buries her nose in between your balls.  Green eyes glisten on either side of your shaft as she stares up at you, her cheeks raised and betraying the coy grin that is obscured beyond your swollen testicles.  Her lips open wide, caressing them with the plush pink pillows, while her slick tongue curls underneath them, undulating gently to massage them.\n\n");
			outputText("As if to demonstrate her supreme skill with her tongue, she allows her hands to wander freely along your lower body while she continues to bounce and squeeze your balls with her tongue.  " + ((player.gender == 3) ? "The tip snakes down, hugging the curvature of your balls, and then begins to experimentally prod your " + player.vaginaDescript() + ", gently flicking your clitoris.  " : "" ) + "Pleasure turns to surprise when you feel her index finger poking around by your " + player.assholeDescript() + ", and she buries it to the base inside you before you have a chance to formulate a protest.  The sudden intrusion makes your shaft flex, the veins bulging against the surface of the skin as it swells a bit in response.\n\n");
			outputText("The wriggling digit finds its way to your prostate and wastes no time going to work, rubbing against you from the inside while she lavishes attention on your balls.  Her free hand glides up and down your shaft, and she occasionally pauses to affectionately nuzzle the underside, rubbing her cheeks along it.  The combination of all these factors is enough to bring you to the verge of climax in just minutes, her skillful licking and stroking sending you to incredible heights of pleasure.  Just as you are about to achieve release, her hand strangles the base of your cock with a vicelike grip, blocking the flow.\n\n");
			outputText("\"<i>Naughty naughty, trying to cum outside my mouth,</i>\" she chastises you with a teasing grin, maintaining her grip on your cock as she pulls back, changing positions.  Her fingertip traces the edge of your sensitive prick, and the slightest touch is enough to drive you mad with pleasure.  She waggles her finger admonishingly as you thrash about, trying to break free of her grip, opening her mouth and pointing inside to emphasize her point.\n\n");
			outputText("Your struggles are put to rest when she knocks the wind out of your lungs, dropping her heavy rear onto your chest a bit more forcefully than was necessary.  At the very least, you have a prime view of her luscious, jiggling ass, emblazoned with a large sun-shaped tattoo on the right cheek.  It's the last thing you see before the world turns into a multi-colored blur of pleasure - the kitsune's plump lips wrap around your engorged head once again, and the sensations of her tongue sliding across it are magnified nearly to the point of excruciating.\n\n");
			outputText("In deference to your desperate state, the kitsune at last seems ready to allow you to fill her with your thick seed...  though it seems as though she still has some teasing to get out of her system as she does so.  Her grip loosens one finger at a time, starting at the pinkie, then the ring finger, then the middle.  The tight ring formed by her thumb and forefinger remains for an agonizingly long time, and then at long last, it falls away, allowing your creamy load to rush up into her waiting throat.\n\n");
			if (player.cumQ() <= 2500) {
				outputText("The second that the first streams of salty cream hit her throat, she begins to moan in ecstasy, cupping your balls softly with both hands.  With her lips sealed tight around your shaft, her tongue swirls to and fro inside her mouth, gathering up your thick seed and funneling it into her gullet.  Overcome by gluttonous desire, she draws your shaft into the back of her throat, massaging your " + player.ballsDescriptLight() + " while she drinks them dry.  She continues to suck down each new stream of cum even after her stomach begins to expand, swelling up with your roiling load.  As your explosive climax begins to slow, she begins to massage the sides of your shaft, squeezing out the last few globs of semen.  Her tongue coils around your length one last time, and she sucks hard, slurping up the last drop with great embellishment.\n\n");
				outputText("\"<i>Mm, not bad...  not bad at all.  For a mortal,</i>\" she teases, sitting up on your chest and rubbing her expanded tummy contentedly.\n\n");
			}
			else if (player.cumQ() <= 6000) {
				outputText("She moans deeply the moment that your first thick streams of seed begin to flow into her throat, cupping your balls softly with both hands.  With her lips sealed tight around your shaft, her tongue swirls to and fro inside her mouth, gathering up your thick seed and funneling it into her gullet.  Overcome by gluttonous desire, she draws your shaft into the back of her throat, massaging your " + player.ballsDescriptLight() + " while she drinks them dry.  Even as her stomach begins to swell with the added weight of your seed, she never stops sucking down your thick load.  Your explosive climax continues to flow, and although she puts up a valiant effort to swallow it all, a few thick streams manage to escape from the corners of her mouth and nostrils.  As the lengthy orgasm finally begins to wind down, her tongue coils around your length one last time, and she sucks hard, slurping up the last drop with great embellishment.\n\n");
				outputText("\"<i>Oh, so thick...  So full,</i>\" she groans, sitting up on your chest and rubbing her expanded tummy contentedly.\n\n");
			}
			else {
				outputText("She involuntarily bucks forward as soon as your semen begins to flow into her mouth, both cheeks puffing out as she tightens her lips around the shaft in a desperate bid to keep it contained.  Her hands grip your throbbing shaft to keep it held in place as she drinks deeply of your inhuman load, twin streams of seed flowing from her nostrils while she tries her best to swallow it all.  Despite her efforts, thick streamers of seed burst from the corners of her mouth, splattering to the ground.  Although her stomach has swollen to the size of a watermelon already, she continues to drink deeply of your thick load, eyes rolled back into an expression of utmost ecstasy.  Her stomach continues to expand, jiggling and sloshing audibly with the added weight of your cum.  As the lengthy orgasm finally begins to wind down, she pulls away with a mouthful of cum in her cheeks, swallowing it with a bit of difficulty.\n\n");
				outputText("\"<i>So much...  I'm stuffed...</i>\"  she groans, sitting up on your chest and resting both hands on her stomach, now well over the size of a beach ball.\n\n");
			}
			outputText("As your [cock biggest] begins to flag, your magically enhanced balls slowly return to their normal size.  Fatigue fills your muscles, and you find it hard to keep your eyes open.  The last thing you see before passing out is a quivering tattooed ass rising off your chest, two hands lovingly cradling a pregnant-looking stomach as it jiggles softly.");
			//outputText("<b>You'll probably come to your senses in 8 hours or so, missing X gems.</b>" );
			//Advance time 8 hours, lose X gems, return to camp. +Sensitivity, +Libido, +Cum Production
			player.orgasm();
			dynStats("lib", 1, "sen", 1);
			if (player.cumQ() < 30000) player.cumMultiplier += 5;
			combat.cleanupAfterCombat();
		}

//Redhead-exclusive
//Futa rape - chance increases as redhead's lust increases
		private function getRapedByRedHeadFutaKitsune():void
		{
			clearOutput();
			kitsuneSprite();
			outputText("You collapse on the ground, too weakened to fight back anymore.  With a mischievous grin, the redhead playfully saunters up to you, crouching down and prodding you in the side.\n\n");
			outputText("\"<i>Finished already?  I thought a big strong " + player.mf("boy", "girl") + " like you would put up more of a fight.</i>\"\n\n");
			outputText("With a light shrug, she ceases chastising you and gets down to business, carefully pulling off your " + player.armorName + " and rolling you over to get a good look at your body.  As her hands cascade over your naked form, you struggle in vain against her incessant pinches and gropes, unable to resist becoming aroused.  Her fingertips slide over your [chest], pressing down lightly as they circle your [nipples].  Ethereal flames crackle along behind her fingers as they drag across your flesh, making your whole body tingle with pleasure and forcing a moan from your throat.\n\n");
			outputText("As she begins to examine your nethers, a number of her bushy red tails begin to slither around your limbs, binding your arms behind your back." + ((player.cocks.length > 0) ? "  She idly lifts [oneCock], playfully wobbling it back and forth and giggling at the pleasured grimace you make." : "" ) + ((player.balls > 0) ? "  Cupping her hand around your " + player.ballsDescriptLight() + ", she hefts them a bit as if sizing them up, using the tip of one of her tails to tickle the underside of your scrotum." : "") + ((player.gender >= 2) ? "  Her fingertips then gently walk along your groin, sliding down to caress and part the lips of your " + player.vaginaDescript() + ", coming away with a thin thread of your feminine juices." : "" ) + "\n\n");
			outputText("" + ((player.gender == 0) ? "\"<i>Heh, well, this is an awkward situation...</i>\" she says, eying your bizarre, featureless groin.  Flipping you over onto your stomach, she smiles, patting your " + player.buttDescript() + " lightly.  \"<i>But at least it looks like you're still good for </i>some<i> kinds of fun...</i>\"" : "\"<i>Oh, we are gonna have some </i>fun<i>, you and I,</i>\" she says, patting your head softly." ) + "\n\n");
			outputText("Once she is suitably satisfied with her teasing, she decides to get down to business, stripping out of her robes.  She throws you a sly grin as she pulls them down around her shoulders, letting her large breasts bounce free and giving you a little show, tweaking her nipples and moaning a bit.  Tugging at the sash around her waist, she lets her robes fall off entirely now, and you watch as her throbbing, twelve-inch cock springs to life, no longer held in check by the confines of her clothes.\n\n");
			outputText("Though her impressive endowment isn't quite as fearsome as some of the others in this strange land, that eerie blue fire that encircles it gives you reason to worry.  There's little you can do about it though, wrapped up in her tails as you are, unable to resist her advances.  You squirm a bit when you feel her press up against your " + ((player.gender >= 2) ? player.vaginaDescript() : player.assholeDescript()) + ", struggling in vain against the tails binding you.  Your fears are assuaged somewhat when you feel the head pushing past your ");
			if (player.hasVagina()) outputText("entrance");
			else outputText("anus");
			outputText(", and you realize that rather than burning you the ghostly flames are filling you with a cool tingling.");
			//{Virginity loss/stretching text if appropriate; redhead is 12x2}\n\n");
			if (player.hasVagina()) player.cuntChange(24, true, true, false);
			else player.buttChange(24, true, true, false);
			outputText("\n\n\"<i>Shh, just relax, it'll be all over soon, dear,</i>\" she whispers in your ear, baring her teeth with an almost sadistic glee.\n\n");

			outputText("Wrapping her arms around your waist, she stuffs the remainder of her thick member inside you with one thrust, making you howl in ");
			if (player.hasVagina()) {
				if (player.vaginalCapacity() < 30) outputText("a combination of pain and ");
				outputText("pleasure.  Your muscles instinctively clench down on the intruder, milking her throbbing shaft in blatant disregard of your own desires, and the kitsune moans in pleasure, rolling her eyes back a little.\n\n");
			}
			else {
				if (player.analCapacity() < 30) outputText("a combination of pain and ");
				outputText("pleasure.  Your muscles instinctively clench down on the intruder, milking her throbbing shaft in blatant disregard of your own desires, and the kitsune moans in pleasure, rolling her eyes back a little.\n\n");
			}
			//Use same text for anal sex, but using analCapacity instead:
			if (player.gender >= 2) {
				outputText(((player.vaginas[0].vaginalLooseness < VAGINA_LOOSENESS_GAPING) ? "\"<i>Ah!  Nice and tight, just how I like it!</i>\"  she groans, gripping your waist tightly and beginning to strongly pump her hips." : "\"<i>Hmm...  a little loose for my tastes, but I suppose it'll have to do.  You haven't been slutting it up on minotaurs and tentacle beasts, have you cutie?</i>\"  she says teasingly, giving you a patronizing pinch on the cheek."));
			}
			else {
				outputText(((player.ass.analLooseness < 3) ? "\"<i>Ah!  Nice and tight, just how I like it!</i>\"  she groans, gripping your waist tightly and beginning to strongly pump her hips." : "\"<i>Hmm...  a little loose for my tastes, but I suppose it'll have to do.  You haven't been slutting it up on minotaurs and tentacle beasts, have you cutie?</i>\"  she says teasingly, giving you a patronizing pinch on the cheek."));
			}
			outputText("\n\nThe coolness of the flames and the warmth of her cock vie for dominance inside you, and you can feel her heartbeat pulsing through her shaft with every thrust.\n\n");

			outputText("As she uses your " + ((player.gender >= 2) ? player.vaginaDescript() : player.assholeDescript() ) + " as her own personal fuckhole, her many tails begin to stroke and tease along your naked body, tickling you with their bristly tips and painting trails of fire across your flesh.  You are caught up in shivers each time one of them crosses one of your erogenous zones, the cool flames tickling and tingling across your most sensitive areas.  Thrashing and wriggling underneath her, you belt out a trembling moan, every muscle in your body resonating with pleasure from the odd contrast of the gentle caress of her tails with the rough pistonlike pounding of her cock.\n\n");

			outputText("\"<i>Yes, yes, oh gods YES!</i>\"  she screams skyward, her tongue hanging out wantonly as she mashes her pelvis into yours with an almost brutal fervor.  Pain has long since been supplanted by pleasure, but you know that you'll probably be sore in the morning when all of this is over.\n\n");
			outputText("You feel yourself being lifted off the ground slightly, a single tail gliding up and down your back.  Your muscles clench up involuntarily as it brushes against you, and it is almost as though you can make out every vein and wrinkle on the brash redhead's cock now, feeling the rapid throb of her heartbeat through it.  Her cock swells with a thick load of seed, and you can feel slick hot jets of semen flooding your " + ((player.gender >= 2) ? player.vaginaDescript() : player.assholeDescript() ) + ".  Your insides milk her swollen member of every ounce of futa-jism she has, her hips pumping continuously and sloppily pounding into you like a horny teenager.  Her voluminous load is so immense that you can feel your abdomen begin to swell as pressurized streams of her seed begin to escape, spilling out onto the ground.\n\n");
			outputText("When she finally calms down and pulls out with a satisfied sigh, your " + ((player.gender >= 2) ? player.vaginaDescript() : player.assholeDescript() ) + " lies agape, a small river of seed slowly pouring out.  Your stomach has swollen to the size of a watermelon, jiggling heavily with the weight of her incredible load of futa-cum.  Her spent cock hangs limply between her thighs, a mixture of cum and feminine juices dripping from the tip.\n\n");

			outputText("She leans down over you and whispers a line of some strange language into your ear, and almost immediately you can feel your consciousness begin to fail you.  The last thing you see before blacking out is her half-flaccid cock swaying happily between her legs as she bends down to pick up her clothes, flashing you one last look at her wide, round ass.\n\n");

			//Advance time 8 hrs, lose X gems, return to camp. +Sensitivity, +Libido.
			player.orgasm();
			dynStats("lib", 1, "sen", 1);
			combat.cleanupAfterCombat();
		}

//[WIN FIGHT]
//Damage victory
		public function defeatTheKitsunes(display:Boolean = true):void
		{
			if (display) {
				clearOutput();
				kitsuneSprite();
				if (monster.HP < 1) {
					outputText("The kitsune hits the ground with an 'Oomph', landing roughly on her well-cushioned backside." + ((monster.hairColor == "red" && flags[kFLAGS.redheadIsFuta] == 0) ? "  The moment her rounded rump impacts the dirt, a swirling flame crackles to life between her legs, engulfing her exposed cock.  When it dies away, all that remains of her throbbing member is a pert cherry-colored bud between her dripping lips." : "") + "  She rubs her sore posterior, wincing in pain and pouting childishly.\n\n");

					outputText("\"<i>I only wanted to play...</i>\" she says, looking crestfallen.\n\n" + ((player.lust >= 33) ? "<b>Well, you can certainly think of a few ways to 'play.'  What will you do to her?</b>" : "" ));
				}
				//Lust victory
				else {
					outputText("The kitsune falls to the ground, one hand buried in her robes as she plays with herself shamelessly, too turned on to continue fighting." + ((monster.hairColor == "red" && flags[kFLAGS.redheadIsFuta] == 0) ? "  The moment her rounded rump impacts the dirt, a swirling flame crackles to life between her legs, engulfing her exposed cock.  When it dies away, all that remains of her throbbing member is a pert cherry-colored bud between her dripping lips." : "") + "\n\n" + ((player.lust >= 33) ? "<b>As you watch her lewd display, you realize your own lusts have not been sated yet. What will you do to her?</b>" : ""));
				}
			}
			menu();
			var button:int = 0;
			//Shared Scenes
			//[Vaginal] - requires cock
			if (player.hasCock()) button = kitsuneButton(button, "FuckHerVag", fuckAKitsuneVaginally);
			if (player.cockThatFits(144) >= 0)
				button = kitsuneButton(button, "FuckAss", putItInAKitsunesAssWin);
			if (player.hasVagina())
				button = kitsuneButton(button, "Tribbing", tribbingWithAKitsune);
			if (player.hasCock())
				button = kitsuneButton(button, "Tailjob", tailJobKitsuneWin);
			//[Tentacles] - requires 3+ tentacles of 30" or longer
			if (player.countCocksOfType(CockTypesEnum.TENTACLE) >= 3)
				button = kitsuneButton(button, "Tentacles...", kitsunesGetBonedBy3PlusTentacles);
			//Blonde-exclusive
			if (monster.hairColor == "blonde") {
				if (player.hasCock()) {
					//[Fuck Draft]
					if (player.hasItem(consumables.F_DRAFT)) {
						if (display) outputText("  You could dose her with a fuck draft...");
						button = kitsuneButton(button, "Use F.Draft", fuckDraftBlond);
					}
					//[Lactaid]
					if (player.hasItem(consumables.LACTAID)) {
						if (display) outputText("  You could dose her with lactad...");
						button = kitsuneButton(button, "Use L-Aid", lactaidDoseAKitSune);
					}
					//[Ovi Elixir]
					if (player.hasItem(consumables.OVIELIX)) {
						if (display) outputText("  You could use an oviposition elixir on her...");
						button = kitsuneButton(button, "Use OviElix", doseAKitsuneWithOviElixirs);
					}
				}
			}
			//Black-hair-exclusive
			if (monster.hairColor == "black") {
				//[Hotdog Anal] - replaces regular Anal option only for the black-haired girl.
				// player.cockThatFits( 144 );
				if (player.cockThatFits(144) >= 0)
					button = kitsuneButton(button, "HotDogAnal", hotdogAnalInKitsuneButtDontLetTailTickleYourNose);
				//[GetLicked] - requires a vagina
				if (player.hasVagina())
					button = kitsuneButton(button, "GetLicked", getLickedByKitsunes);
				//[GetBJ] - requires cock 108 area or less
				if (player.cockThatFits(108) >= 0)
					button = kitsuneButton(button, "Get BJ", getABJFromAFoxGirl);
			}
			if (monster.hairColor == "red") {
				//Non-futa Redhead: [Bondage] - requires a cock with area <= 144 due to some anal
				if (player.cockThatFits(144) >= 0)
					button = kitsuneButton(button, "Bondage", nonFutaRedHeadBondageIGuessYouTieHerUpWithYourPenisThenHuh);
				//Non-Futa Redhead: [Some sort of lapsitting handjob thing, I don't know]
				if (flags[kFLAGS.redheadIsFuta] == 0 && player.hasCock())
					button = kitsuneButton(button, "Lap HJ", nonFutaRedHeadIsWorstRedheadLapsittingHandjobThingIDontKnow);
				//[Helix] - requires herm
				if (flags[kFLAGS.redheadIsFuta] > 0 && player.gender == 3)
					button = kitsuneButton(button, "Herm Helix", helixZeKitsunes);

				//[Bring Back Dick] // AKA you don't know dick about dick AKA the dickening
				if (flags[kFLAGS.redheadIsFuta] == 0)
					button = kitsuneButton(button, "Grow Dick", bringBackDick);
				//[Remove Dick]
				else {
					//AKA Lose the dick, schweethaat AKA put that thing away
					button = kitsuneButton(button, "Ditch Dick", redheadsDontDeserveToHavePenisesBecauseTheyreTooGayForPenisOrSomethingIDontReallyKnowHowThisWorksOrWhyThisFunctionNameIsSoFuckingLong);
				}
				//Redhead-exclusive
				//[Ride] - requires vagina & redheadIsFuta
				if (player.hasVagina() && flags[kFLAGS.redheadIsFuta] > 0)
					button = kitsuneButton(button, "RideHerCock", rideDatRedheadKitsuneCockIntoTheSkyDiamonds);
				if (flags[kFLAGS.redheadIsFuta] > 0 && player.hasVagina() && player.biggestTitSize() >= 4 && player.armorName == "lusty maiden's armor")
					button = kitsuneButton(button, "B.Titfuck", (player.armor as LustyMaidensArmor).lustyMaidenPaizuri);
			}
			//[Feeder]
			if (player.findPerk(PerkLib.Feeder) >= 0)
				button = kitsuneButton(button, "Breastfeed", feederTheKitsunes);
			//Remove buttons in SFW mode. No rapes!
			if (flags[kFLAGS.SFW_MODE] > 0) {
				removeButton(0);
				removeButton(1);
				removeButton(2);
				removeButton(3);
				removeButton(4);
				removeButton(5);
				removeButton(6);
				removeButton(7);
				removeButton(8);
			}
			addButton(14, "Leave", leaveKitsune);
		}

		private function kitsuneButton(button:int, nam:String, func:Function):int
		{
			if (button > 8) return 9;
			addButton(button, nam, func);
			button++;
			return button;
		}


//Shared Scenes
//[Vaginal] - requires cock
		private function fuckAKitsuneVaginally():void
		{
			clearOutput();
			kitsuneSprite();
			outputText("You approach the downed kitsune cautiously, wary of any tricks she might have hiding up her sleeve.  She makes a feeble attempt to scurry to her feet and run off, but you catch her by the " + ((player.cor < 40) ? "collar of her robes" : "tail") + " and pull her back, spinning her around and pinning her to a tree, leaning in close.\n\n");

			outputText("\"<i>Oh my...</i>\" she says, blushing a little as you close in on her, your hot breath on her neck.\n\n");

			outputText("Your fingertips trail down through her hair, gliding over her cheek and neck, down over her bountiful chest and sliding over the curves of her hips.  With your other hand, you tug on the sash that holds her robes together, letting her perky breasts bounce free, and begin to grope and squeeze them.  You grab a nice handful of her plump, juicy ass, eliciting a small squeak from her before she calms down and shivers beneath your touch, her six tails curling forward to caress you gently.\n\n");

			outputText("\"<i>Hey now, don't think you've gotten the best of me,</i>\" she says, fighting against the pleasures of your touch with every fiber of her being.  \"<i>I'll...  I'll...</i>\"\n\n");

			outputText("You only smirk, dragging your fingers across her side and leaning in to nibble the edge of her neck.  She practically melts in your arms, rolling her eyes back and moaning, her cheeks growing flushed with desire." + ((monster.hairColor == "red" && flags[kFLAGS.redheadIsFuta] > 0) ? "  You feel a light thump against your crotch and look down with a snicker, seeing a large tent in the lower half of her robes.  Teasingly, you run your hand down her front, wrapping your fingers around it through the fabric and pumping it slowly." : "" ) + "\n\n");

			outputText("\"<i>Ah-aah!  S-stop, y-you'll-</i>\"\n\n");

			outputText("\"<i>I'll what?</i>\"  You cut her off mid-sentence, taking great pleasure in teasing the normally coy trickster, holding her squirming body up against the tree as you slide your hand down in between her legs and dip a finger in between her moist lips.  She groans and lolls her head to the side, her chest heaving up and down and her whole body shuddering from head to toe.\n\n");

			outputText("You toss away your " + player.armorName + ", dropping to the ground without a second thought, and you carefully lift the hem of the kitsune's robes to inspect her groin." + ((monster.hairColor == "red" && flags[kFLAGS.redheadIsFuta] > 0) ? "  Her throbbing cock rises to attention immediately, precum leaking slowly but constantly from the tip, down the thick shaft and over her glistening nether lips." : "" ) + "  A small tattoo rests on her pubic mound, accentuating her" + ((monster.hairColor == "red" && flags[kFLAGS.redheadIsFuta] > 0) ? " foot long member and" : "" ) + " shaven pussy." + ((monster.hairColor == "red" && flags[kFLAGS.redheadIsFuta] > 0) ? "  You take her pulsing shaft into your hand and begin to pump it strongly, watching her face contort into all manner of pleasured grimaces as your fist slides up and down the pre-soaked pole." : "") + "\n\n");

			outputText("Your [cock biggest] rises up in between her legs, sliding along the opening of her vagina as if to remind you what you're ultimately after.  Feeling that you've teased the girl enough, you hike up her legs into your arms, pressing her against the tree to hold her up in the air.  Your shaft flops out over her stomach, and you start to grind back and forth against her " + ((monster.hairColor == "red" && flags[kFLAGS.redheadIsFuta] > 0) ? "own twitching member" : "pelvis" ) + ", dripping pre all over her.\n\n");

			outputText("\"<i>W-what are you waiting for?</i>\"  she demands breathlessly, wrapping her tails around your waist and grabbing your shoulders for support.  \"<i>This is what you wanted, right?  Come on, fuck me!</i>\"\n\n");

			outputText("You pull one of your arms out from beneath her leg and press a finger to her lips, telling her that she's in no place to be making demands of you.  She blushes deeply and nods, her eyes glazing over a little as she embraces her role submissively.\n\n");

			outputText("\"<i>J-just this once...</i>\"\n\n");

			outputText("Smirking, you lift her leg onto your shoulder once more and continue sliding your shaft across her groin, letting her get good and wet before you press it up against her.  Strings of sticky lubricant flow down your shaft as you press into her, forcing a moan from her throat as you push the [cockHead biggest] inside, her slick lips parting easily and inviting you inside." + ((player.biggestCockArea() > 50) ? "  The walls of her pussy stretch incredibly, swallowing inch after meaty inch of your engorged member with no end in sight." : "") + "  Her breasts jiggle lightly when your [hips] bounce up against hers, " + ((monster.hairColor == "red" && flags[kFLAGS.redheadIsFuta] > 0) ? "her cock flopping against her stomach and leaving behind a trail of musky precum, " : "" ) + "the walls of her pussy clamping down against your shaft.\n\n");

			outputText(((player.balls > 0) ? "Balls deep" : "Up to the hilt") + " in her warm, inviting pussy, you groan in pleasure, sliding your hands up to squeeze the deliciously plump globes of her ass.  Moaning deeply, you pull your hips back and start to thrust, her quivering walls making loud squelching noises each time your [cock biggest] drives home.  She throws her arms around your shoulders and then tosses her head back lustfully, her eyes rolling back and her tongue lolling out in pleasure.  Her sopping wet cunt convulses and squeezes around your throbbing member, matching every curve and fold of flesh perfectly.  She hooks her legs around your [hips], freeing you to slide one hand up to grope her breasts, the other straying down and squeezing her ample ass." + ( (monster.hairColor == "red" && flags[kFLAGS.redheadIsFuta] > 0) ? "  Your fingers trail upward, over her thigh and wrap tightly around her pulsating cock, sliding up and down the precum-coated member.  Every pump of your fist and thrust of your hips forces another thick glob of precum from the tip, covering your hand in the sticky, slippery fluid." : "" ) + "\n\n");

			outputText("As you continue your wild bucking, she coils her tails around your lower body, using them as leverage in order to pump her hips down to meet each thrust, lost in lust.  One of her tails slides up and curls around your [cock biggest], caressing it lovingly with the soft fur before constricting around the " + ((player.hasSheath()) ? "sheath" : "base" ) + ".  Your shaft throbs with heat as it swells up from the makeshift cock ring, a light tingling zigzagging up your groin when the tip of her tail brushes up against you, leaving behind a ghostly trail of blue flame.\n\n");

			outputText("\"<i>Oooh, don't stop, please...  Fuck me harder...</i>\" she groans flashing you a coy smirk and sliding her hand up your neck, running her fingers " + ((player.hairLength > 0) ? "through your hair." : "across your scalp.") + "\n\n");

			outputText("You indulge the coquettish girl in her request, redoubling your passionate thrusting and wrapping both arms around her back, moaning into one of her furry, triangular ears.  Your swollen cock slams into her pussy over and over, strings of sticky lubricant flowing out over your groin and dripping to the ground loudly.  She moans wildly, squeezing your [cock biggest] with her sloppy cunt and thrusting her hips down to meet yours, and you find yourself pounding her pussy with a reckless ferocity." + ((monster.hairColor == "red" && flags[kFLAGS.redheadIsFuta] > 0) ? "  Her cock twitches powerfully in your hand, slinging spurts of precum across her chest, every stroke making her insides clamp down on you." : "" ) + "\n\n");

			outputText("Her tail constricts even tighter around your shaft, as though sensing your impending orgasm and seeking to prevent it.  Your cock swells up even larger inside her, making the two of you groan in unison.  It feels as though you can make out every ripple and wave of her soft inner flesh as it cascades over your engorged member, caressing it from all sides.  Rutting and grunting like a beast, you thrust into her once, twice, thrice more, and moan deeply, your cock twitching heavily inside of her.  Your shaft swells up just behind the blockage provided by her tail, building up pressure, but either the pressure is too great for her to hold back anymore or her own climax distracts her long enough to make her lose her grip, and your orgasm spills forth like a raging white river.\n\n");

			outputText("" + ((monster.hairColor == "red" && flags[kFLAGS.redheadIsFuta] > 0) ? "Her cock throbs and twitches in your grip, " + ((player.cor > 15) ? "on the verge of climax.  Just as she is about to achieve release, you tighten your grip around her base, smirking mischievously.  See how <i>she</i> likes being tricked!\n\nHer shaft swells inordinately beneath your hand, throbbing and twitching in vain as she tries desperately to overcome the blockage.  Her face contorts into a grimace of pain with the slightest hint of masochistic bliss.  She squirms and writhes in your grip, and finally you decide that she's had enough.  You lean back and angle her twitching rod away from yourself, releasing your grip, and her cock begins to spasm uncontrollably," : "" ) + "slinging hot futa-jizz into the air and coating her chest and face with creamy white strings of spunk.  She groans powerfully, bucking her hips in ecstasy as she pumps load after load of thick jizz onto herself and plasters her front completely with her own thick cum.  " : ""));

			if (player.cumQ() <= 150) {
				outputText("Her vaginal walls convulse around your twitching member, milking it of every drop of your hot, sticky cum.  She groans orgasmically as your cloying spunk spills into her womb, wrapping her legs around your waist and hugging you tightly as though she couldn't bear the thought of letting even a drop escape.");
			}
			else if (player.cumQ() < 350) {
				outputText("Her pussy squeezes tightly around your twitching member, milking you for every stream of cum you have to offer.  The muscular entrance clamps down tightly and she tightens the grip of her legs around your waist, holding on for dear life as her orgasm rocks her body.  Even after her shuddering climax ends, she continues to cling to you, not allowing even a single drop to escape.");
			}
			else if (player.cumQ() <= 1000) {
				outputText("Your member swells obscenely inside her as you spurt thick ribbons of semen into her womb, the walls of her pussy convulsing around your twitching shaft and milking you for all you're worth.  She groans deeply, wrapping her legs tightly around your waist and bearing down on you as hard as she can as her climax roars through her body, making her shudder uncontrollably.  Although the ring of flesh around her entrance clamps down tightly, a few streams of cum manage to escape, dribbling down the underside of your shaft and splattering on the ground.");
			}
			else if (player.cumQ() <= 2500) {
				outputText("Her pussy convulses and ripples around your wildly twitching member, a thick bulge funneling its way up your shaft as the first sticky load explodes inside of her, stuffing her vulnerable womb with your potent jizz.  She throws her head back and moans, moving both hands down to her stomach as it begins to swell into a nicely rounded bulge, jiggling with your cum.  Her muscular walls milk you of every last drop, squeezing the cum from your urethra and clamping down around your shaft.  Despite her valiant efforts, as her belly swells to accommodate your incredible load, a few pressurized streams manage to escape from her entrance, soaking you from the waist down.");
			}
			else {
				outputText("Your shaft distends incredibly from the massive amount of spunk travelling through it, flowing into her womb one thick, torrential stream at a time.  She throws her head back and groans, shuddering intensely and lowering her hands down to her stomach as it begins to expand, jiggling outward into a hugely rounded belly.  Her walls convulse heavily around your twitching, throbbing shaft, milking you of every last sticky drop and squeezing around you tightly.  As her stomach continues to swell outward obscenely, her poor abused pussy is simply unable to contain the immense pressure, thick streams of spunk spurting out and drenching you from the waist down.");
			}

			outputText("With a groan, you pull back, " + ((player.cor < 45) ? "holding your arms up underneath her shoulders to keep her from falling to the ground all at once, and lower her down slowly." : "letting her drop to the ground with an unceremonious 'THUD'.  She yelps weakly in protest, rubbing her bruised posterior, but says no more." ) + ((monster.hairColor == "red" && flags[kFLAGS.redheadIsFuta] > 0) ? "  Her cock hangs limply over her cum-" + ((player.cumQ() > 1000) ? "bloated" : "soaked") + " stomach, still leaking copious amounts of futa-jizz over her thigh.  It twitches gently, giving one final spurt before laying to rest." : "") + "  You pant lightly, leaning on the tree to catch your breath and looking down as she stares up at you, utterly exhausted.\n\n");

			outputText("Finally, you turn to gather up your things, cleaning yourself off a little and pulling your " + player.armorName + " back on.  When you turn around again to check up on the insensate kitsune, you are left scratching your head, staring at the spot where she was mere moments ago.  All that remains of her is a puddle of mixed fluids, already mostly absorbed by the ground, and the faint sound of mischievous laughter filtering through the trees.");
			//Advance time 1hr and return to camp. +Sensitivity, +Libido
			player.orgasm();
			dynStats("lib", 1, "sen", 1);
			combat.cleanupAfterCombat();
		}

//[Anal] - requires cock area 144 or less
		private function putItInAKitsunesAssWin():void
		{
			clearOutput();
			kitsuneSprite();
			var x:int = player.cockThatFits(144);
			outputText("Your gaze cascades up and down her lovely form, taking in every voluptuous curve and line.  Finally, your eyes come to rest on her expansive, jiggling ass, carefully scrutinizing the large colorful tattoo emblazoned on the right cheek.  Heat surges to [eachCock] as you stare at it, almost entranced by the smooth globes.  Rubbing your hands together and grinning lecherously, you reach down and position the kitsune on her hands and knees, lifting her deliciously plump derriere into the air and tugging her robes apart, tossing them unceremoniously to the side." + ((monster.hairColor == "red" && flags[kFLAGS.redheadIsFuta] == 1) ? "  Her half-flaccid cock dangles in between her thighs, a thin trickle of precum hanging from the tip as it swings back and forth." : "" ) + "\n\n");

			outputText("Giving her a firm exploratory slap, you chuckle giddily as the two quivering cheeks shake and jiggle like gelatin for what feels like a full minute before coming to rest.  The kitsune gives a cute cry of arousal, looking back at you and smirking gently, resting her cheek on her arms now.  Far from resistant to your advances, she seems almost delighted when you fish out your " + player.cockDescript(x) + " and lay it across her rounded rump, raising her tails out of the way automatically.\n\n");

			outputText("\"<i>Oh, no, such a big, strong cock...  what </i>ever<i> will I do?</i>\"  she says with a wry grin, beginning to slide her plump cheeks up and down your pole, one of her tails coiling down to gently wrap around the " + ((player.hasSheath()) ? "sheath" : "base" ) + ".\n\n");

			outputText("Well, if she's not complaining, neither are you!\n\n");

			outputText("A second tail dips down, thrusting into her moist twat and coming out with a nice healthy coating of her slippery pussy juices.  Working it like an artist's brush, she twirls it up and down your rapidly hardening erection, painting you with her juices.  It tickles a bit, making you shudder with pleasure as the warm, slick fluids are spread over your shaft.  Once your rod is suitably lubricated, her tail flips up with a flourish and passes under your nose, teasing you with the heavy scent of her feminine musk.\n\n");

			outputText("She pulls her hips forward, caressing your member with her silky-soft tails, and guides it to kiss her tight pink pucker, licking her lips a bit as she does so.  Holding onto her wide, curvy hips, you dig your fingers into her flesh and firmly begin to push your " + player.cockHead(x) + " against her ass, gasping in pleasure when it slips inside with surprising ease.  Her muscular flesh ring stretches magnificently, welcoming your shaft into its depths and encompassing it with warmth.  You groan a bit as her colon ripples and squeezes around you in ways you never would have thought possible.\n\n");

			outputText("\"<i>Don't act so surprised, dear,</i>\" the kitsune says in between moans, working the muscles of her ass to make the cheeks quiver and jiggle independently.  \"<i>It's almost like you've never fucked a kitsune's ass before.</i>\"\n\n");

			outputText("As you begin to thrust your hips, she rocks her body back and forth to meet you, biting her tongue and groaning through her teeth.  Her anus bears down on you each time you pull back, squeezing so tightly that it almost seems like it will never release you, and then becomes loose and inviting when you thrust back in.  The process repeats over and over, milking you powerfully with every pull and practically sucking you back inside, sending you to the pinnacle of pleasure within minutes.\n\n");

			outputText("Sensing your onrushing orgasm, she tightens the ring of her tail around your " + ((player.hasSheath()) ? "sheath" : "base" ) + ", blocking your orgasm from escaping and trapping blood in your swollen " + player.cockDescript(x) + ", making it that much more sensitive.\n\n");

			outputText("\"<i>Hey now, we're just getting started!  You wouldn't want to finish so soon, would you?</i>\"\n\n");

			outputText("You feel a swelling in your [balls] as your load begins to back up just behind your " + ((player.hasSheath()) ? "sheath" : "base" ) + ", its passage to release blocked by the mischievous fox-woman's tail.  Somehow even when defeated, she still finds a way to toy with you!  Your cock spasms inside her, trying to release its creamy load into her warm innards, but to no avail - on the plus side, however, you can somehow feel every single ripple and wave of her flesh magnified tenfold, gripping you tightly and milking your shaft pleasurably.\n\n");

			outputText("The tip of one of her tails begins to glide along your engorged pole each time it pulls out, tickling the sensitive flesh and compounding the sensations even more.  You practically double over in pleasure when a small trail of crackling ethereal flame begins to dance across the underside of the shaft, filling you with a tingling coolness that spreads over your groin and accents the incredible glowering warmth of her ass.  As you start to lose yourself in the pleasure, she takes the opportunity to coil a pair of tails around your waist, using them to piston your pelvis forward and back.  Her wonderfully supple ass cheeks buffet your hips, jiggling and quivering each time she pounds them back to meet you, impaling herself on your meaty rod time and time again." + ((monster.hairColor == "red" && flags[kFLAGS.redheadIsFuta] > 0) ? "  You can feel her own solid rod flopping back and forth pendulously between her legs, occasionally slapping your " + player.legs() + " and leaving a trail of precum in its wake." : "") + "\n\n");

			outputText("With a remarkable display of flexibility, she flips herself over onto her back without missing a beat, her legs spreading out and closing around your hips." + ((monster.hairColor == "red" && flags[kFLAGS.redheadIsFuta] > 0) ? "  Her thick cock rests on her stomach, dribbling precum down into her navel and twitching idly each time she forces you inside." : "") + "  The gentle twisting of her rectum around your shaft adds yet another sensation to the mix, making you groan and shudder with pleasure, your hands instinctively traveling down to grope her luscious butt.  Her arms cross behind her head, and she relaxes back, using her lower body to guide you into her again and again.  Every time you try to slow down, her legs flex and pump you forward again, never letting up.  She begins to moan a little overdramatically, groping and fondling her own breasts in a teasing display." + ((monster.hairColor == "red" && flags[kFLAGS.redheadIsFuta] > 0) ? "  One hand trails up to her cock and begins to stroke it, squeezing out a dollop of precum that she lifts to her lips, sucking it down lavishly." : "") + "  Obviously she is relishing the blissful torture she is putting you through, as she stares up at you with a mock innocence, lifting one of her turgid nipples to her lips and suckling on it gently.\n\n");

			outputText("Enough!  She's had her fun!  Driven mad with lust and pleasure, you drop down onto her forcefully, grabbing her wrists and pinning them to the ground.  Grunting and moaning, you begin to pound your rod into her ass mercilessly, fed up with her teasing.  The nerve she has, trying to deny you your just reward after you beat her fair and square!\n\n");

			outputText("\"<i>AAAaahH!</i>\"  she yelps when you wrest control from her, dropping her coy facade almost immediately and belting out a tremendous moan.  \"<i>Ooh!  So you f-finally had enough, h-huh?</i>\"  she says breathlessly, chewing on the first knuckle of her index finger adorably.  A rush of clear femcum drenches your stomach, her sopping pussy gushing fluids like someone opened the floodgates of a dam" + ((monster.hairColor == "red" && flags[kFLAGS.redheadIsFuta] > 0) ? ", while a thread of precum spurts from her cock, landing across her belly" : "") + ".  It would seem as though your sudden display of dominance has managed to break through her coquettish outer shell and awaken the horny buttslut underneath!" + ((monster.hairColor == "red" && flags[kFLAGS.redheadIsFuta] > 0) ? "  You reach forward and grab her throbbing shaft, squeezing it in your fist tightly and starting to pump it in time with your powerful thrusts, making the kitsune howl in pleasure and throw her head back wildly, shuddering from head to toe." : "") + "\n\n");

			outputText("As her gushing pussy continues to spasm and soak your hips with her slick fluids, her asshole clamps down on your member like a vice, the inner muscles trembling and milking your dick with an unbelievably intense sucking sensation.  She screams out her climax, losing her grip on your " + player.cockDescript(x) + ", and your long overdue orgasm is finally able to erupt into her colon, rushing into her bowels like a raging white river.  ");
			if (monster.hairColor == "red" && flags[kFLAGS.redheadIsFuta] > 0) {
				outputText("Her cock throbs and twitches in your grip, ");
				if (player.cor > 15) outputText("on the verge of climax.  Just as she is about to achieve release, you tighten your grip around her base, smirking mischievously.  Time to give the little slut a taste of her own medicine!\n\nHer shaft swells inordinately beneath your hand, throbbing and twitching in vain as she tries desperately to overcome the blockage.  Her face contorts into a grimace of pain with just the slightest hint of masochistic bliss.  She squirms and writhes in your grip, tears welling in the corners of her eyes as they roll back in ecstatic torture.\n\n\"<i>I-I'm s-sorry!  P-please!  Please, please, please, I'm begging you!</i>\"\n\nThat's more like it.  You lean back and angle her twitching rod away from yourself, releasing your grip, and her cock begins to spasm uncontrollably, ");
				outputText("thick ropes of cum shooting up into the air, landing with a pleasant splatter all over her face, chest, and stomach.  She groans powerfully, bucking her hips in ecstasy as she pumps load after load of thick jizz onto herself and plasters her front completely with her own thick seed.");
			}
			if (player.cumQ() <= 150) {
				outputText("More cum than you thought you could produce spills out into her warm innards, her intestines squeezing and sucking out every last drop you have to offer her.  Your thick seed coats her walls, squelching audibly as the strong inner muscles continue to contract even long after you have spent your last.");
			}
			else if (player.cumQ() <= 350) {
				outputText("Thick ropes of semen explode into her innards, the wondrous feeling of release almost painful as each stream distends your urethra, filling her plump rear up to the brim.  You can feel the walls of her rectum still contracting around your flagging member, drawing every last drop out of you and making an audible gurgling noise.");
			}
			else if (player.cumQ() <= 1000) {
				outputText("Massive globs of cum stretch your urethra almost painfully as you release a bucketload of cum into the poor kitsune's ass, groaning like an animal and rolling your eyes back as you bear down on her, your hips bucking and spasming wildly.  Her innards gurgle and squelch audibly, still milking your cock hungrily long after it has run dry, and her belly has taken on an attractive bulge, jiggling a bit with every breath she takes.");
			}
			else if (player.cumQ() < 2500) {
				outputText("Every muscle in your body resonates with pleasure, finally achieving glorious release as a thick glob of cum swells through your shaft and spurts into her ass loudly.  You fire ribbon after ribbon of thick jizz into her cum-hungry innards, groaning like a wild beast as her muscular walls squeeze and milk you of every drop.  Her stomach begins to balloon out as you stuff more and more of your virile seed into her colon, until she sports a hugely round and pregnant-looking belly that jiggles and sloshes ever so slightly with each breath.");
			}
			else {
				outputText("Your cock swells and bloats with the volume of jizz now suddenly clamoring for the exit, a thick river pouring out to flow into the kitsune's ass in an audible rush of liquid.  Even as her powerful inner muscles try to milk you of every drop, the volume proves too much even for her, pressurized streams backflowing out of her clenched anus and splattering against your hips.  Her rectal muscles continue to spasm uncontrollably long after your incredible orgasm ends while she looks up at you dazedly over the crest of a ludicrously cum-bloated belly.");
			}

			outputText("\n\nThe kitsune's tongue hangs out at an odd angle, lolled to the side while she catches her breath.  " + ((player.cumQ() > 2400) ? "As you pull out, a veritable torrent of spooge follows your cock, pouring out onto the ground.  Even with a small pond's worth of your cum beneath her, her stomach still maintains a healthy bulge, one of her tails idly stroking across it." : "Her muscles clench instinctively as you pull out, trapping your load inside her while a tail idly strokes her stomach.") + "\n\n");

			outputText("\"<i>Heh...  not bad for...  a mortal,</i>\" she says, resuming her previous teasing, though you can tell her heart isn't in it by the satisfied look on her face" + ((monster.hairColor == "red" && flags[kFLAGS.redheadIsFuta] > 0) ? " and the lazy droop of her spent, flaccid member" : "") + ".\n\n");

			outputText("You take a moment to recuperate, and then begin to gather your things, but when you turn your attention back to the kitsune, there's no sign of her save for the sound of a feminine giggle drifting through the leaves.");
			//Advance time 1hr and return to camp. +Sensitivity, +Libido
			player.orgasm();
			dynStats("lib", 1, "sen", 1);
			combat.cleanupAfterCombat();
		}

//[Tribbing] - requires vagina
		private function tribbingWithAKitsune():void
		{
			clearOutput();
			kitsuneSprite();
			outputText("You eye her suspiciously for a bit, cautiously edging closer to her prone form.  The proverbial bag of tricks seems to be spent, however, and she allows you to close the distance without further harassment, slowly crawling backward across the grass.  Her cautious retreat is unable to outpace your approach, and before long you are planting your hips squarely atop hers, pinning her to the ground" + ((monster.hairColor == "red" && flags[kFLAGS.redheadIsFuta] > 0) ? ", her cock pressed to her stomach" : "") + ".\n\n");

			outputText("She laughs awkwardly, smirking deviously as you lean in, her deep emerald eyes mere inches from your own.  You press your lips to hers, running your hand through her hair and stroking the sensitive backs of her ears with your fingertips while undressing her with your free hand.  A moan rumbles up through her chest and into your lips, her cheeks burning a deep, flustered red as she begins to lean back, submitting to your passions.\n\n");

			outputText("The heat of her loins radiates up into yours, elevating your passion to new heights as you pin the kitsune's shoulders to the ground, sliding your hips to and fro across her pubic mound.  As you grind your pelvis back and forth across hers, your [clit] occasionally slips down into the cleft of her pussy, flicking across her own engorged pleasure bud and sending a buzzing wave of pleasure up your spine." + ((monster.hairColor == "red" && flags[kFLAGS.redheadIsFuta] > 0) ? ((player.cocks.length > 0) ? "  Together with hers, your cocks twitch and bounce" : "  Her cock twitches and bounces") + " against her stomach each time your hips ride forward, a thread of precum connecting to her navel from the tip." : "" ) + "\n\n");

			outputText("Each time your [clit] passes across hers, you shudder with pleasure, but you soon realize that the position you have taken is...  lacking.  You simply aren't optimally angled for the sort of nerve-shattering pleasure that you seek - this must be remedied.\n\n");

			outputText("You quickly flip yourself around, sliding your hands up her luscious thighs and taking hold of her calves.  She yelps in startled bemusement as you flip her hindquarters upward, bending her back over herself so that she is folded double in a lewd contortion, her genitals dripping sweet nectar onto her face.\n\n");

			outputText("\"<i>Haha, what do you think you're doing, you silly mortal...</i>\" she says, chuckling as you position yourself over her, settling your [butt] down on her splayed thighs, your " + player.vaginaDescript() + " meshing seamlessly with hers." + ((player.cocks.length > 0) ? player.sMultiCockDesc() + " drape" + ((player.cocks.length > 1) ? "s" : "" ) + " over the plump round cheeks of her prodigious posterior, leaking strands of precum onto her bundle of luxurious tails" + ((monster.hairColor == "red" && flags[kFLAGS.redheadIsFuta] > 0) ? ", while her own member dangles a few inches above her nose." : ".") : "" ) + "  When your slow, measured grinding resumes, you moan with approval, finding this new position to be much more satisfying.\n\n");

			outputText("Each time you rock your hips forward, her swollen clitoris glides up between your lady lips, and each time you drop down, it meets yours with a fantastic flick." + ((player.clitLength > 4) ? "  You gasp as without warning, your [clit] slides easily into her warm, moist passage, drawn into the slick folds of her pussy by a strange sucking sensation.  Her warm vaginal walls compress around you, conforming to the contours of your oversized ladyhood and squeezing tight." : "") + "  Your hands travel down to her expansive hind end, sinking your fingers deep into the soft, pliable flesh and pulling her hips flush against yours.  It jiggles and wobbles like gelatin, ripples flowing through it each time you thrust your hips forward, delightfully distorting the design inscribed upon it.  Continuing the slow, methodical grinding of your groin against hers, you knead her large ass like a mound of soft dough, squeezing and groping it lustfully while moaning in approval.\n\n");

			outputText("\"<i>Mmn, oh, that's the spot,</i>\" she coos, pushing her flexible frame upward with her legs stretching to the ground near her shoulders, arms spread out for support.\n\n");

			outputText("She matches your grinding thrusts with her own, her sextet of tails curving toward your body like a group of furred serpents.  They coil around you teasingly, tickling across your body in slow and sensual curls, and then begin to drift southward," + ((player.cocks.length > 0) ? " wrapping around [eachCock] tenderly and" : "") + " slithering their way around to your rear.  The silky fur bristles along your bottom as her tails constrict around you, and one of the bushy coils works its way down to your nethers, teasing the edges of your labia.  The tip of her tail gently flicks across the upper surface of your [clit], sending a shock of pleasure through you, but it doesn't stop there - with the sound of a flint striking against steel, she conjures a blue flame at the end of her tail, and before you can protest, presses it firmly against the base of your womanhood.\n\n");

			outputText("Dazzling tongues of mystical azure lick at your [clit], intensifying every sensation and magnifying your pleasure tenfold as a cool tingling begins to creep through your nerves." + ((monster.hairColor == "red" && flags[kFLAGS.redheadIsFuta] > 0) ? "  Your engorged ladyhood swells with the added pleasure, and you can feel the kitsune's pussy growing tighter...  or is it that your clitoris is growing larger?  Regardless of the cause, it feels incredible, and you can only start bucking your hips with a renewed fervor, squeezing her ass as you piston yourself fervently into her inviting hole." : "") + "\n\n");

			outputText("She joins you in a lewd chorus, thrusting herself up against you and grasping her own breasts excitedly, flicking her turgid nipples with her fingertips." + ((monster.hairColor == "red" && flags[kFLAGS.redheadIsFuta] > 0) ? "  A constant stream of precum dribbles from her cock now, casting a thin, glistening sheen onto her face and breasts." : "") + "  You buck your hips back and forth strongly, gradually building momentum in pursuit of your ever-nearing climax.  The steady 'schlick-schlick-schlick' sounds of lustful tribadism fill the forest, threads and beads of feminine juices connecting your " + player.vaginaDescript() + " to hers and smearing across each other's groins messily.\n\n");

			outputText("Like a coiling spring, a tension slowly culminates in your intermeshed netherparts, climbing steadily as a path of heat radiates through your womb.  You lurch forward, a moan catching sideways in your throat as you feel a slender finger sliding up against your [asshole], gently wriggling its way inside.  The addition of this intruder has you near the limits of your endurance, trembling with restraint and digging your fingers deeper into the soft, voluptuous doughiness that is her breathtaking backside.  Deciding to return her kindness, you circle her tensed pucker with a fingertip, plunging it in up to the knuckle.  Her anal ring spreads around your finger without quarrel, the warmth of her rectum drawing the invasive digit inside invitingly" + ((player.clitLength > 4) ? ", and her vagina immediately tense around your [clit] in response, trapping it in a vacuumlike suction" : "") + ".\n\n");

			outputText("Every muscle in your body resonates with passion as you lower your weight against her upthrust pelvis, running your hands down her rump to the small of her back.  You instinctively grasp the base of her tails for support, struggling to maintain your balance as your " + player.vaginaDescript() + " begins to convulse, a dribbling waterfall of feminine lubricant spilling from your loins and into hers.  The entire salacious river flows down her front, soaking her through and through with a glistening patina, while her tails thrash wildly in your grip, the kitsune's orgasm close at hand.\n\n");

			outputText("The coiling spring snaps, your back arching reflexively as your orgasm proper begins to tear through you.  The kitsune reaches her peak at the same time, her contorted body flexing awkwardly beneath you as she struggles to maintain balance in her twisted pose, fighting through the throes of pleasure." + ((player.clitLength > 4) ? "  Her vagina ripples along your overgrown womanhood, blood pumping into the already engorged organ from the heat and suction." : "") + ((player.wetness() == 5) ? "  You hold onto her tightly, thrusting your hips forward as a slick jet of femcum sprays from your snatch, the musky feminine juices sliding down the curves of her backside." : "") + ((monster.hairColor == "red" && flags[kFLAGS.redheadIsFuta] > 0) ? "  Twitching and swelling with pleasure, " + ((player.cor > 15) ? "she groans deeply in anticipation of her nearing climax.  Just as she is about to achieve release, you tighten your grip around her base, smirking mischievously.  See how <i>she</i> likes being tricked!\n\nHer shaft swells inordinately beneath your hand, throbbing and twitching in vain as she tries desperately to overcome the blockage.  Her face contorts into a grimace of pain with the slightest hint of masochistic bliss.  She squirms and writhes in your grip, her eyes rolling back and her tongue hanging out.\n\n\"<i>N-no fair!  L-let me cum!  F-fuck, please!</i>\"\n\nYou lean back and angle her twitching rod away from yourself, releasing your grip, and " : "" ) + "her swollen shaft begins to dump load after load of thick seed onto her face, spraying out in ribbons and globs.  She shakes her head from side to side, unable to avoid her own virile emissions, pearly white sheets of semen sloughing off her cheeks as she sputters, laughing self-deprecatingly." : "") + "\n\n");

			outputText("As your climax begins to ebb, you slump downward, sliding off of her in satisfaction and panting on the grass.  You lie head to toe with her, " + ((player.isBiped()) ? "[legs] spread apart, " : "") + "breathing in deeply in an attempt to catch your breath.  Your eyes close for but a moment, a contented sigh issuing from your lips, and when you open them again, the kitsune is gone.  The tingling buzz of her flame on your [clit] still lingers, along with the faint sound of jovial laughter wafting through the leaves.");
			// Advance time 1hr and return to camp. +Sensitivity, +Libido
			// Possibly increase clitLength
			player.clitLength += 0.1 + rand(3) / 10;
			player.orgasm();
			dynStats("lib", 1, "sen", 1);
			combat.cleanupAfterCombat();
		}

//[Tail Job] - requires cock
		private function tailJobKitsuneWin():void
		{
			clearOutput();
			kitsuneSprite();
			outputText("Eying her silky tails, you come up with a wonderful plan to relieve some tension.  Working quickly, you untie the sash around the kitsune's waist and then retie it so that her arms are pinned to her sides.  Turning her onto her back, you prop her up against a tree and then begin to strip out of your " + player.armorName + ", reaching down to gather up her six tails in your arms.  She looks up at you curiously, watching as you wrap one of the fluffy coils around [eachCock], slowly dragging your fingertips through the lustrous fur.  As your fingers slide across their fluffy surface, she gives an involuntary shudder, her cheeks flushing a slight pink.  The tail seems to constrict around you automatically, and without any further encouragement needed the tight ring of fur begins to slide up and down, squeezing and massaging your shaft" + ((player.cocks.length > 1) ? "s" : "" ) + " sensually.\n\n");

			outputText("The level of control she has over her tails is absolutely marvelous!  They stroke and tickle along your groin, running their soft, brushlike tips across every inch of exposed flesh that they can find." + ((player.balls > 0) ? "  One warm coil begins to wrap itself around your " + player.ballsDescriptLight() + ", leaving the underside exposed so that the tip can curl down, sliding gently back and forth over the seam to send shivers up your spine." : "") + ((player.cocks.length > 1) ? "  Her remaining tails begin to weave in between your cocks, curling and wrapping around the shafts.  As they slide up and down, they begin to gently constrict, acting like furry cock rings." : "  Her remaining tails wrap themselves around your member, sliding up and down along the shaft.  One of them coils around your " + ((player.hasSheath()) ? "sheath" : "base" ) + " and begins to constrict it gently, acting like a furry cock ring.") + "  You feel like you could cum almost instantly from their incredibly delicate touch, but every time you feel your climax coming on, the kitsune holds back.\n\n");

			outputText("\"<i>Silly mortal...  Are you actually getting off on my tails?</i>\" she teases, looking up at you with a coy smirk as she works her tails, one of them sliding up to stroke under your chin patronizingly.  In spite of her words, the pink blush on her face betrays her true pleasure, her furry tails bristling with each gentle motion they make.\n\n");

			outputText("You stammer in protest, " + ((silly()) ? "telling her that it's not like you enjoy her super soft tails or anything." : "telling her that she's your prisoner and should behave as such.") + "  She giggles a bit and nods submissively, saying no more and lying back against the tree trunk as her tails continue to tease and caress you.\n\n");

			outputText("Seeking something for your hands to do, you prop yourself up on the tree above her with one arm, thrusting your hips against her tails as your free hand slides through her hair lightly.  Over and over again she brings you up to the verge of orgasm, dangling you over the edge teasingly and then pulling you back from the brink at the last second.  It's pure, wonderful torture, and if it didn't feel so good you might be angry at her for having the audacity to pull something like this when she's supposed to be your captive.\n\n");

			outputText("It is at the height of one such cycle of pleasure and denial that you feel something cool and tingly washing over you, looking down to see the kitsune's lips pursed at " + ((player.balls > 0) ? "the underside of your " + player.ballsDescriptLight() : "the " + ((player.hasSheath()) ? "sheath" : "base" ) + " of your " + player.cockDescript(0) ) + ", gently blowing pale flames across your groin.\n\n");

			outputText("The intense tingling is all that you needed, hurtling off the edge and into the full force of your climax.  [EachCock] pulses, the tight rings of fur preventing you from achieving your full release even as your muscles spasm in vain." + ((player.balls > 0) ? "  Thick spunk begins to well up in your " + player.ballsDescriptLight() + ", making them swell terribly with backed-up seed." : "" ) + "  Thankfully she seems to tire of teasing you shortly, and withdraws the offending tails.  ");
			if (player.cumQ() <= 150) {
				outputText("Your thrice prolonged orgasm explodes in her face, streams of thick jism firing out onto her forehead and cheeks, dripping down over her lips.  Sighing slightly, she begins to clean herself off, licking up whatever is within reach of her tongue and wiping the rest off using her sash as a towel.");
			}
			else if (player.cumQ() <= 350) {
				outputText("Thick ribbons of cum splash across her forehead, matting down her hair and dripping slowly down her face.  Licking up whatever is within reach of her tongue, she cleans the rest off with her hand, using her sash as a towel.");
			}
			else if (player.cumQ() <= 1000) {
				outputText("You drench her face with thick streamers of spunk, surprising her a little with the volume as you give her a nice thick facial.  She licks up a few of the thick globs that hang around her lips, using her sash as a towel to clean up the remainder.");
			}
			else if (player.cumQ() < 2500) {
				outputText("Your load erupts all over her face, matting down her hair and covering her with a thick layer of warm, sticky semen.  Heavy globs of jizz dribble down her cheeks and land on her chest, a few errant steams weighing down her ears.  Thoroughly showered in your cum, she runs her tongue along the outside of her lips, and then begins to wipe the rest off using her sash as a towel.");
			}
			else {
				outputText("You utterly soak her with your virile ejaculations, releasing thick ropes of semen all over her front.  Her hair, face, and chest are thoroughly drenched with your cum, dribbling down and slopping onto the ground loudly.  She runs her tongue along the outside of her mouth, swallowing whatever she can reach, and then begins to clean herself off, using her sash as a towel.");
			}
			outputText("\n\nIt's difficult to say exactly when she managed to escape her bonds, but while you are still recuperating from your exhausting climax, she slips out from beneath you and darts for the underbrush, giggling precociously.\n\n");

			outputText("\"<i>Come look me up anytime, dear!</i>\"  she calls back when she is safely out of sight.  You briefly consider giving chase, but decide it is not worth the effort, gathering your " + player.armorName + " and turning back toward camp.");
			//Advance time 1hr and return to camp.  +Sensitivity
			player.orgasm();
			dynStats("sen", 5);
			combat.cleanupAfterCombat();
		}

//[Tentacles] - requires 3+ tentacles of 30" or longer
		private function kitsunesGetBonedBy3PlusTentacles():void
		{
			clearOutput();
			kitsuneSprite();
			outputText("You slowly approach the fallen fox-woman, eying her warily and keeping a safe distance in case of any tricks she still has up her sleeve.  She slowly edges away from you with each step you take toward her, yelping in surprise when you swoop down to grab her by the arms.  She tries to scramble to safety, but her struggles only succeed in sprawling her flat on the ground as she gets tangled in her robes.\n\n");

			outputText("You pin her down, leaning in low, and begin to undress her slowly, running your hands lecherously across her curvaceous form.  Her breasts spring free with a tantalizing bounce as you spread her robes apart, untying the sash around her waist and tossing it aside.  She continues to thrash a bit, fighting to get free, but her frantic struggles calm quickly as you run a hand through her hair, scratching the backs of her ears gently.\n\n");

			outputText("You trail your fingertips slowly over her smooth skin, tracing the edges of her many exotic tattoos on the way to her plump posterior.  Your fingers sink deep into the cushiony flesh, her expansive rear jiggling enticingly as you squeeze and manipulate it.  Experimentally, you give the fleshy globes a small flick with your finger, eliciting a startled cry from the kitsune.  The rounded cheeks wobble and quiver heavily, flesh rippling and jiggling beneath your hand like gelatin.\n\n");

			outputText("Softly, you begin to stroke the fine hairs at the base of her six luxurious tails, chuckling as the pink tone on her cheeks deepens to an intense crimson.  The fur on her tails stands on end with the lightest brush of your fingertips, and small tears well up at the corners of her eyes, her breath becoming labored and quick.  Once she has been satisfactorily reduced to a trembling heap of arousal from your insistent petting, you pull back to strip out of your " + player.armorName + ", working slowly and teasingly to give the coy trickster a taste of her own medicine.\n\n");

			outputText("As your " + num2Text(player.countCocksOfType(CockTypesEnum.TENTACLE)) + " writhing tentacles twist free of the confines of your " + player.armorName + ", the kitsune's eyes open wide with desire, her jaw hanging slack and her tongue lolling out of her mouth.  A trail of drool slides down her chin as she hungrily gawks at your slithering tendrils, leaning forward to crawl on her hands and knees toward you.\n\n");

			outputText("\"<i>Tentacles...</i>\" she whispers in an almost reverent tone, reaching up to grasp the largest of them, squeezing it tenderly.  Before you know it, she has her face buried in your crotch, eyes closed and humming happily as her hands glide up and down your wriggling, plantlike shafts.\n\n");

			outputText("Your tentacles coil instinctively around her arms, wrapping around her shoulders and drawing her even tighter into your brace of tendrils.  She inhales deeply through her nose, savoring the thick, musky smell of your cocks as her face is buried in your groin.  Her tongue slides out along the underside of your largest tentacle dong, her palm caressing it a bit farther up the shaft.  When you look down, her crystal-clear green eyes are rolled back into her skull, an expression of pure ecstasy plastered across her face.  Her cheeks burn hotly against your numerous tentacle pricks as she rubs her face against them eagerly, groaning with pleasure.\n\n");

			outputText("\"<i>So strong...  so thick...</i>\" she moans, sliding her tongue along one wriggling shaft and stroking two others eagerly.  \"<i>Oh, if I'd known...</i>\"\n\n");

			outputText("She twitches with delight as your muscular tendrils slip under her armpits, lifting her off the ground.  Her tails lash out, wrapping around whatever they can reach, the serpentine coils of fur caressing your plethora of cocks with a worshipful passion.  Without hesitation, she raises her legs into the air, pulling her ankles up to her ears with her own tails and holding them there.\n\n");

			outputText("A trembling moan escapes her throat as a pair of your writhing members begin to slide against her groin, one running across her drenched slit while the other threads itself between her plump cheeks." + ((monster.hairColor == "red" && flags[kFLAGS.redheadIsFuta] > 0) ? "  Your tentacle slithers around her cock swiftly, wrapping tightly around the base and squeezing it from end to end." : "" ) + "  Moaning lewdly, she tries to buck her hips toward you, having some difficulty due to her odd positioning and entanglement in the twisting jungle of your cocks.\n\n");

			outputText("The head of the largest cock gently parts her glistening pussy lips, rubbing along her swollen cherry-colored nub and teasing her entrance.  Her nethers squeeze around your tentacle's crown, the muscles rippling over the head and suckling on it hungrily as though trying to draw it inside her body.  She nudges her hips toward your cock eagerly, nodding furiously and whimpering while doing her best to make her desires abundantly clear.\n\n");

			outputText("You oblige her with a moan, burying a foot of tentacle into her sloppy snatch with a single thrust.  She groans in approval, her mouth hanging open, and you quickly move one of your squirming tendrils to fill the opening.  Her throat relaxes to accept the intruding member, and before you know it you have her strung up from both ends, driving her mad with pleasure.\n\n");

			outputText("Her fingers and toes curl around different parts of your vinelike shafts, stroking them with an adoring fervor.  Your third tentacle continues to writhe obscenely between her fleshy butt cheeks, spreading slick precum around her rosy anal ring.  Her violation becomes complete as your wriggling tentacle plunges swiftly into her tight rear passage, spearing her rectum on a foot of your throbbing plant length.  The warm, inviting tunnel ripples around you, strong musculature working to draw more and more of your squirming tendril inside.\n\n");

			outputText("A garbled moan fills the air as her throat vibrates around your second tentacle, her body convulsing in a confused cycle of tensing and relaxation.  Her face glistens faintly as trails of tears roll down to join the lines of drool that dribble from the corners of her mouth, though they can only be tears of pleasure judging from how furiously she continues to drive herself against your thrashing phalluses.\n\n");

			outputText("Her hands tremble and shake, reaching out for you pleadingly.  She grasps your shoulders with a vicelike grip, lowering her legs to wrap around your [hips] and pull her tighter to your form.  With her newfound stability, she begins to thrust herself against your tentacles in earnest.  Tears of joy stream from her eyes as you pummel her orifices mercilessly, her flesh distorting visibly from the intrusion of your distended tendrils." + ((monster.hairColor == "red" && flags[kFLAGS.redheadIsFuta] > 0) ? "  Her cock trembles and throbs within the coils of one of your tentacles, spurts of precum flinging out as you roughly stroke the pulsing shaft." : "" ) + "\n\n");

			outputText("Your hands glide down her body, drawing her deeper into your tangle of obscene tentacle dicks so that you can grope her fleshy curves.  Again, your fingertips sink into her squeezable ass, your other hand groping her breast roughly.  Her body grinds up and down against yours, afloat in a sea of pleasure and tentacles as she is driven through from end to end.\n\n");

			outputText("\"<i>M'm, M'm Fhumming!</i>\" she yells out around your plantlike shaft, her words muffled by the indistinct sounds of slurping and sucking.\n\n");

			outputText("A hot gush of femcum sprays from her sodden snatch, her muscular walls trembling and pulsing around you.  Incredibly, it feels like her cunt is actually pulling your vinelike member even deeper inside her absurdly spacious - yet paradoxically tight - vagina.  Her anus clenches tightly around its own invader, the strong muscles of her rectum drawing it inward as well and milking the shaft powerfully." + ((monster.hairColor == "red" && flags[kFLAGS.redheadIsFuta] > 0) ? "Her cock throbs and twitches in the coils of your tentacles, " + ((player.cor > 15) ? "on the verge of climax.  Just as she is about to achieve release, you cinch the tendril up around her base, grinning.  See how <i>she</i> likes being tricked!\n\nHer shaft swells inordinately below the coil of vine, throbbing and twitching in vain as she tries desperately to overcome the blockage.  Her face contorts into a grimace of pain with the slightest hint of masochistic bliss.  She squirms and writhes in your grip, muffled pleas gurgling around the tentacle in her throat, and finally you decide that she's had enough.  You lean back and angle her twitching rod away from yourself, releasing your grip, and her cock begins to spasm uncontrollably," : "" ) + "a thick ribbon of cum erupting from her twitching cock and hanging in the air suspensefully before plummeting onto her face.  It is the first of many such streams that spurt from her swollen phallus like a lewd fountain, coating her body with a generous sheen of pearly jizz." : "") + "  You continue to violate her orifices with your frenzied pummeling, pleasure and pressure building in your " + ((player.balls > 0) ? player.ballsDescriptLight() : "prostate" ) + " until finally boiling over in a roiling, trembling orgasm.\n\n");

			outputText("You moan in ecstasy as your thick load works its way up the lengths of your tentacles, ");
			if (player.cumQ() <= 150) {
				outputText("depositing thin ribbons of warm spunk into her body from three directions.  Her ass, throat, and pussy all work together to squeeze out every ounce of semen you can muster, milking your loins with a powerful suction.");
			}
			else {
				outputText("dumping hot streams of spunk into her innards from three directions." + ((player.cocks.length > 3) ? "  Your excess members spurt sticky streamers across her body, coating her in a glistening web of spunk." : "") + "  Her ass, throat, and pussy all work together to squeeze out every ounce of semen you can muster, milking your loins with a powerful suction.");
			}
			if (player.cumQ() > 350) {
				outputText("The bases of your writhing tentacles distend slightly as your thick load works its way through them, stretching her lips, asshole and cunt around the swelling shafts when it forces its way past.  ");
			}
			if ((player.cumQ() > 350) && (player.cumQ() <= 1000)) {
				outputText("Hot globules of semen are deposited into her innards from three directions" + ((player.cocks.length > 3) ? "while her body is showered with sticky streamers from your excess members " : "") + ", your virile seed stuffing her holes to capacity.  The strong muscles of her ass, throat, and pussy work in tandem, squeezing along the length of your tentacles to draw out all the semen you can muster.  Her abdomen swells slightly from the volume as you pour your sticky spunk into her, distending her womb and stomach while her intestines flood with seed.");
			}
			if ((player.cumQ() > 1000) && (player.cumQ() < 2500)) {
				outputText("You dump load after load of hot spunk into her from three directions" + ((player.cocks.length > 3) ? ", your extra cocks showering her from head to toe in a sticky white web of jism" : "" ) + ", virile seed stuffing her holes to capacity.  Her ass, throat, and pussy work in tandem, milking your cocks with strong squeezing along their lengths.  The volume pouring into her causes her abdomen to balloon outward into a jiggling belly, flooding her womb and innards while thick streams of seed overflow from her abused nethers, spurting out forcefully and splattering on the ground.");
			}
			if (player.cumQ() > 2500) {
				outputText("Your cocks drill liter after liter of creamy spunk into her from three directions" + ((player.cocks.length > 3) ? ", covering her body from head to toe in thick, musky cum and" : ",") + " flooding her innards with thick seed.  Her ass, throat, and pussy work in tandem, drawing out every ounce of seed that you can muster with a powerful suction and muscular squeezing along their lengths.  Her stomach swells up with your cum, jiggling outward heavily and forcing her body away from yours as it stretches to accommodate the expanding volume of seed.  In time, she is filled up to capacity, her orifices clamping down in vain to contain the remainder of your prodigious emissions and failing absolutely.  Pressurized streams erupt from all three orifices, twin jets of semen spurting from her nostrils and soaking her front.");
			}

			outputText("\n\nPanting with exertion, you hold her warm body close to yours for some time, watching sense gradually return to her brutalized body.  One by one, your tentacles withdraw, lowering her" + ((player.cumQ() > 350) ? " bloated" : "") + " body to the ground carefully.  Her chest heaves deeply, " + ((monster.hairColor == "red" && flags[kFLAGS.redheadIsFuta] > 0) ? "her cock flopping limply over her thigh as your tentacle releases its grasp and her" : "") + " tongue hanging out of one side of her open mouth.");

			outputText("\n\nShe lazes in the grass in a relaxed stupor, a huge grin plastered across her face.  Her hands slide down across her skin " + ( ((player.cocks.length > 3) || (monster.hairColor == "red" && flags[kFLAGS.redheadIsFuta] > 0)) ? "and draw trails in the semen smearing her front" : "") + ((player.cumQ() > 350) ? ", caressing her cum-filled belly" : "") + " while she moans in satisfaction, uttering a heaving sigh of approval.\n\n");

			outputText("\"<i>Tentacles...</i>\" she repeats, shuddering from head to toe.");
			//Advance time 1hr and return to camp.  +Sensitivity, +Libido
			player.orgasm();
			dynStats("lib", 1, "sen", 1);
			combat.cleanupAfterCombat();
		}


//Blonde-exclusive
//[Fuck Draft]
//{all " + player.cockDescript(0) + " calls for this scene should prioritize dog cocks; if PC is in Rut, prioritize other animal dicks second, otherwise use the biggest cock.}
		private function fuckDraftBlond():void
		{
			clearOutput();
			kitsuneSprite();
			var x:int = -1;
			var temp:int = 0;
			while (temp < player.cockTotal() && x < 0) {
				if (player.cocks[temp].cockType == CockTypesEnum.DOG) x = temp;
				temp++;
			}
			if (x < 0) x = player.biggestCockIndex();

			outputText("You smirk mischievously, getting a particularly evil idea.  If she likes tricks so much, well, you've got one hell of a trick for HER!  You reach into your pouch and pull out a vial of bubbling red potion, running your finger over the word \"Fuck\" inscribed on the side.\n\n");

			outputText("\"<i>Hey...  wait, what are you do-</i>\"\n\n");

			outputText("She cries out in protest as you wrestle her to the ground, uncorking the draft with your thumb and using your other hand to plug her nose.  You press the mouth of the vial up to her lips insistently, and it isn't long before she has to gasp for fresh air, allowing you to dump the contents down her throat.  She coughs and sputters a little, trying to spit it out, but you put a bit of pressure on her jaw to prevent exactly that, massaging her neck gently to help coerce her to swallow.  The moment the potent aphrodisiac begins to flow down her throat, you can feel the surface of her skin turn feverish with lust, a blush of deepest crimson spreading across her face.\n\n");

			outputText("The powerful scent of feminine musk fills the air almost instantly, a viscous puddle spreading between her legs and soaking through the crotch of her robes." + ((player.dogCocks() > 0) || (player.inRut) ? "  As the potent smell fills your nostrils, your " + player.cockDescript(x) + " swells in anticipation, reacting instinctively to the scent of a female in heat.  Lurid fantasies of plugging her sloppy snatch with your " + ((player.dogCocks() > 0) ? "knot" : player.cockDescript(x)) + " and stuffing her belly full of kits rush into your mind unbidden" + ((player.cor < 20) ? ", disturbing you slightly" : "") + "." : "") + "  Her body trembles and quakes with carnal need, pure animalistic desire burning in her eyes.  As the effects of her chemical-induced heat come into full swing, she struggles to maintain some semblance of rational thought, desperately willing herself to crawl away.\n\n");

			outputText("You look on with mild amusement as she drags herself one, two, three feet away, and collapses in a shivering wreck, raising her ample rear into the air.  Her hips flex and pump in defiance of her will, all six of her golden tails raised high and fanned out as she claws out of her robes, exposing her drenched fuckhole and gorgeous tattooed ass.\n\n");

			outputText("\"<i>Oooh gods, what did you DO to me?!</i>\"  she demands in between gasps of pleasure, plunging her hand into her soaked twat and pounding her fingers in and out furiously.  \"<i>S-sooo...  hot...  I feel...  Ah!  For the love of Marae, j-just fuck me!</i>\"\n\n");

			outputText("You " + ((player.cor < 33) ? "stifle a laugh, observing her somewhat humorous plight." : "laugh uproariously, relishing the proud kitsune's utter humiliation.") + "  Her face twists into a beautiful grimace of climactic pleasure, her tongue lolling out shamelessly as she rolls her eyes back and orgasms, abruptly and violently.  Clear feminine cum pours from her convulsing pussy, splattering on the ground in a thick puddle.\n\n");

			outputText("With her cheek mashed into the ground, she squirms and bucks her hips, panting heavily.  Her hand dives into her snatch again and again, disappearing into the hungry folds of flesh over and over.\n\n");

			outputText("\"<i>Hh...  Why isn't this working!?</i>\"  she cries desperately, tears forming at the corners of her eyes.  \"<i>I...  ah...  cum!  Please, I-I need cum inside me, NOW!</i>\"\n\n");

			outputText("You grin a bit at her declaration, reaching forward and sliding your finger down her spine gently.  She practically collapses under your light touch, convulsing in pleasure as every one of her tails bristles in response, nearly orgasming again from that alone." + ((player.cor < 33) ? "  You wonder if you've gone too far, and whether you should be somewhat concerned for the poor thing's sanity.  If you don't do something to satisfy her insatiable lust, though, that alone might be enough to break her." : "  You grin evilly, dragging your fingertips down your new pet's back and laughing as she spasms uncontrollably, spraying femcum unceasingly.  The little cocktease was so keen on making a fool of you before - where's her smug sense of superiority now?") + "\n\n");

			if (player.dogCocks() > 0 || player.inRut) outputText("The sweet musk of her voluminous fem-jizz fills your mind with a lustful haze, higher-order thought processes gradually shutting down as animalistic mating instinct begins to take over.  ");
			outputText("You slide your " + player.cockDescript(x) + " up between the supple mounds of her ass, groaning in pleasure as she begins to glide her hips back and forth along the shaft, cooing softly.  The warm, moist breath radiating off her sodden vagina caresses your ");
			if (player.balls > 0) outputText(player.ballsDescriptLight());
			else outputText(player.legs());
			if (silly()) outputText(" with a heat you could roast marshmallows over.");
			else outputText(" with a heat that sends blood rushing to your groin.");
			outputText("  She raises her hips higher, whimpering a little as she desperately tries to line up your " + player.cockDescript(x) + " with her hungry fuckhole.\n\n");

			outputText("\"<i>S-stop t-teasing...</i>\" she says breathlessly, whimpering as she fails to catch your " + player.cockHead(x) + " in her quivering snatch for the third time in a row.  Her hips clumsily rock back, a desperate whine escaping her throat as she tries to calm her shaking body enough to finally impale herself on your ever-hardening rod.");
			if (player.dogCocks() > 0 || player.inRut) {
				outputText("  Your animalistic need to impregnate the fertile female in front of you battles with your desire to tease her, but impulse is quickly winning out over rationality.  You can only hold yourself back for a few moments longer before you give in to baser instincts and plunge your shaft into her needy pussy");
				if (player.cockArea(x) > 50) outputText(" heedless of whether she can handle it or not.  Thankfully, you needn't worry - her cunt eagerly swallows your cock whole with room to spare, somehow");
			}
			else {
				outputText("  Her needy thrusts do their part to endear you to her desperation, rapidly breaking through your desire to tease her.  You hold out for just a bit longer before finally succumbing to your lusts, driving your rod deep into her needy pussy");
				if (player.cockArea(x) > 50) outputText(" heedless of whether she can handle it or not.  Thankfully, you needn't worry - her cunt eagerly swallows your cock whole with room to spare, somehow");
			}
			outputText(".  Her insides feel like a furnace, the slick walls closing in around your cock, rippling along the length intensely.\n\n");

			outputText("A jet of warm girlcum splashes out against your " + ((player.balls > 0) ? player.ballsDescriptLight() : player.legs() ) + " as the kitsune claws at the ground, launched into the throes of another orgasm.  Her walls convulse around your throbbing cock, gripping you like a vice.  They suck you deeper inside, prompting you to begin vigorously thrusting your hips, your loud moans joining her cries in a chorus of pleasure.  As her trembling orgasm begins to subside into the more manageable pleasure of mating, she begins to slam her ass back to meet you, each thrust forcing the air from her lungs and punctuating each moan with a loud grunt.\n\n");

			outputText("\"<i>Nngah!  Fuck!  I-it feels s-so good!</i>\"\n\n");

			outputText("You dig your fingertips into her massive, plush ass and begin to pound her wet snatch with all your might, grunting and groaning passionately.");
			if (player.dogCocks() > 0 || player.inRut) outputText("  Vivid fantasies of stuffing her pussy full of your virile semen race through your mind, unable to think of anything else.  Come whatever may, you know you MUST impregnate her - there's simply no other option.");
			outputText("  The force with which she mashes her voluptuous derriere back into your pelvis would surely leave you sore in the morning were it not for the expansive tattoo-adorned ass cushioning the blows.\n\n");

			//if (dogCocks > 0)
			if (player.dogCocks() > 0) {
				outputText("The lips of her slippery pussy stretch over your canine knot a little more with every thrust, and with one last savage assault you force the bulge inside her, shaking from head to toe in pleasure.\n\n");

				outputText("The kitsune rolls her eyes back and opens her mouth in a cacophonous scream of pleasure, stunned stiff by her hardest climax yet.  Her inner muscles contract around your knot powerfully, rooting you in place as steaming hot orgasmic juices gush out over your groin.\n\n");

				outputText("Despite the minor difficulties you had squeezing it inside, her vagina accommodates your knot quite nicely, wrapping around the veiny bulge and rippling pleasantly as she gradually comes down from her high once more.  Tears of pleasure stain her cheeks, mixing with the shameless drool that pools under her chin, her mouth permanently agape in an expression of purest lust.\n\n");
			}
			outputText("Gathering her tails into your arms, you pull them tight to your chest, eliciting a pleasured moan from the lust-maddened kitsune.  She lets out a pained squeal when you tug on them suddenly, using them for additional leverage as you redouble your powerful thrusting.  You can feel every pulse of her fluttering heartbeat through the walls of her vagina, liquid heat caressing and milking your cock as more juices squirt out around your " + ((player.dogCocks() > 0) ? "knot" : player.cockDescript(x) ) + ".\n\n");

			outputText("Your pleasure begins to rise to a head, every passionate thrust bringing you closer and closer to your final, incredible release.  In preparation, you drop down over her, placing your hands on top of " + ((player.cor < 33) ? "hers." : "her wrists to pin her down.") + ( ((player.dogCocks() > 0) || player.inRut) ? "  You are stricken with the urge to bite her neck, and indulge it, pinching the scruff of her shoulder between your teeth." : "") + "  With a roaring moan, you buck your hips one last time, slamming down against her well-cushioned rear with one final thrust, holding there as the pressure in your " + ((player.balls > 0) ? player.ballsDescriptLight() : "prostate" ) + " finally boils over.  ");

			if (player.cumQ() <= 150) {
				outputText("Your cock spasms uncontrollably, spewing stream after stream of potent jizz into her hungry snatch.  The instant it begins to flow inside her, she locks down into another incredible orgasm, fingers digging into the dirt while tears flow from the corner of her eyes, moaning powerfully.  Her walls milk and massage you, drinking deeply of your virile cum.");
			}
			else if (player.cumQ() <= 350) {
				outputText("Sticky ribbons of jizz fire into her hungry pussy one after another, coating her slick walls with your thick, salty cum.  The instant it begins to flow inside her, she locks down into another incredible orgasm, fingers digging into the dirt while tears flow from the corner of her eyes, moaning powerfully.  Her muscles contract and convulse, hungrily milking your cock of every drop it has to offer.");
			}
			else if (player.cumQ() <= 1000) {
				outputText("Your urethra distends as load after load of sticky jizz flows up the shaft of your cock, frothing into the kitsune's belly.  The instant it begins to flow inside her, she locks down into another incredible orgasm, fingers digging into the dirt while tears flow from the corner of her eyes, moaning powerfully.  As her walls rhythmically milk and squeeze your cock, she begins to develop a slight belly, the swelling bulge jiggling a bit with the weight of your emissions.");
			}
			else if (player.cumQ() < 2500) {
				outputText("The shaft of your cock swells as thick gobs of cum begin to erupt from the tip, rushing down her sopping fuckhole and pouring into her uterus.  The instant it begins to flow inside her, she locks down into another incredible orgasm, fingers digging into the dirt while tears flow from the corner of her eyes, moaning powerfully.  Her muscles continue to squeeze your shaft hungrily long after your abundant reserves have been depleted, her cum-bloated belly sloshing beneath her, jiggling with the weight of your cum.");
			}
			else {
				outputText("You can actually hear the sound of your cum pouring into her, stuffing load after load of potent jizz into her fertile womb.  The instant it begins to flow inside her, she locks down into another incredible orgasm, fingers digging into the dirt while tears flow from the corner of her eyes, moaning powerfully.  ");
				if (player.hasKnot(x)) outputText("Her belly balloons to a ludicrous size, swelling more by the second as you continue to pump her full.  Your knot blocks the only escape, forcing her to endure as her abdomen swells with your seed, sloshing and jiggling heavily.");
				else outputText("The sheer volume is more than she can handle, and when her now heavily pregnant-looking belly begins to press against the ground, pressurized streams start to pour out of her tight hole, splattering against your [hips] and [fullChest].");
				outputText("  Despite looking quite as though she has swallowed a beach ball, her sloppy cunt continues to milk your shaft of every drop it can squeeze, even long after your incredible reserves are depleted.");
			}
			outputText("\n\nNow with a womb full of fresh, warm semen, her insatiable mating lust at last seems to have calmed down, the presence of your seed quenching the raging fire in her loins.  Panting and sighing, she sinks into a relaxed stupor underneath you, though it seems like her orgasmic expression has been permanently etched into her face.  Her six tails twitch limply, an arm or leg occasionally spasming involuntarily.");

			outputText(((player.dogCocks() > 0) ? "  You try to pull out, but are a little dismayed to find that her pussy still has a vice grip on your distended knot.  Sighing, you collapse on top of her, enjoying the warmth of her flesh " + ((player.cor < 33) ? "while gently stroking her golden hair " : "" ) + "as you wait for the swollen bulge to deflate." : "" ) + "\n\n");

			outputText("She releases a small whimper when your shaft begins to slide out, " + ((player.cumQ() > 1000) ? "and a small fountain of spooge follows, spurting out in an arc as her belly deflates to relieve some of the pressure." : "her engorged labia rhythmically squeezing around the sudden emptiness.") + "  Exhausted from pleasure, you pass out on top of her, and she beneath you, lying in a puddle of your combined fluids.\n\n");

			outputText("You can't be certain how long you were asleep, but when you come to your senses, you are alone.  A musky trail of fluids leads into the underbrush, and though you doubt that she could have gotten far in her condition, you need to return to check on your camp.  As you gather your things, you pause briefly and smirk, certain you can hear the sound of moaning filtering through the trees.");
			//Advance time 1hr and return to camp. +Sensitivity, +Libido
			player.orgasm();
			dynStats("lib", 1, "sen", 1);
			player.consumeItem(consumables.F_DRAFT);
			combat.cleanupAfterCombat();
		}


//[Ovi Elixir]
		private function doseAKitsuneWithOviElixirs():void
		{
			clearOutput();
			kitsuneSprite();
			var x:int = player.cockThatFits(100);
			if (x < 0) x = player.biggestCockIndex();
			outputText("You fish in your pouch for a large hexagonal bottle with a picture of an egg tagged to the neck, holding it up to the light and swirling the thick green liquid inside.  The kitsune eyes you suspiciously as you close in on her, slowly crawling backward until she hits a tree.  She scrambles to escape, failing spectacularly when you " + ((player.cor < 33) ? "snatch up a fistful of her robes, yanking her into your arms." : "step on one of her tails, making her yelp in surprise and fall flat on her face.") + "\n\n");

			outputText("Holding the bottle in one hand, you push out the stopper with a thumb, wrestling her into submission.  She is unable to put up much of a fight, and you are easily able to subdue her feeble struggles, tipping the crystalline flask into her mouth.  Holding her head back, you keep the lip of the bottle up to her mouth until the last drop has disappeared into her throat, then casually dispose of it, stepping back to watch the show.\n\n");

			outputText("\"<i>Uugh...  m-my stomach...</i>\" she groans, her hands traveling down to her abdomen as you hear an audible rumbling from within her.  Her flesh practically bubbles as her belly begins to swell, rounding out into a firm bulge.\n\n");

			outputText("Panting lightly, she leans back, supporting herself on a tree to catch her breath.  She grins up at you, managing to breathlessly tease, \"<i>S-so, you UGH...  you like pregnant girls, do you?  You'd better...  HNNG...  take responsibility...</i>\"\n\n");

			outputText("It's plain to see that she's trying but failing utterly to maintain her sly demeanor, regularly doubling over and clutching her abdomen as her simulated pregnancy advances another stage.  Her magic must be reacting with the potion's, or something to that nature, as her belly has already almost quadrupled in size since you began your little experiment, hanging out over her hips heavily.\n\n");

			outputText("Groaning, she slides down the side of the tree, both of her arms supporting the tremendous weight of her curvaceous stomach.  You're certain something fishy is going on now as her breasts spill out of her robes with a bountiful jiggle, twin streams of milk sprinkling from her rapidly expanding tits.  Ovi Elixirs don't do that, at least not to your knowledge.\n\n");

			outputText("She sinks down further, stroking her belly lovingly and laying flat on her back, her swollen milk-udders rising and falling with every labored breath she takes.\n\n");

			outputText("\"<i>If you just stand there gawking...  HNnn...  you might miss your chance,</i>\" she says, regaining some of her composure now that the intense swelling of eggs within her uterus has calmed.\n\n");

			outputText("Her words snap you from your reverie, and you rush over, hurriedly stripping out of your " + player.armorName + ".  You drop to the ground near her and begin to run your hands across her body, squeezing her massively engorged breasts, eliciting a light moan.  She coos softly as you slide your palms over the gravid swell of her stomach, caressing the taut flesh gently.  Your touch travels downward, cascading over her thighs momentarily before spreading them apart to get at the puffy lady-lips in between them.\n\n");

			outputText("You gently insert a finger into her moistened cunt, relishing the sound of her moans as you slowly pump your digit in and out.  As your finger slides up her slick pink slit, she shivers quite powerfully, a quickening gurgle issuing from her belly.\n\n");

			outputText("Realizing that if you delay for much longer you really will miss your chance, you hastily remove your finger and reposition yourself between her splayed legs, stroking your [cock biggest] up to full mast.  She moans and arches her back a little as the " + player.cockHead(x) + " presses up against her warm love hole, though the weight of her stomach makes it a little difficult for her.\n\n");

			outputText("As you prepare to plunge yourself into her quivering lips, a pair of golden tails slither up around your throbbing member, one curling around your " + ((player.hasSheath()) ? "sheath" : "base" ) + " while the other slowly tickles across the underside of the shaft." + ((player.gender >= 2) ? "  It travels slowly up and down your prick, then drifts down toward your " + player.vaginaDescript() + ", teasing your [clit] gently." : "") + "  Her swollen cunt parts around you easily as you delve into her depths, rippling around your member sensually.  The muscular walls stretch around you, a steady trickle of feminine juices spilling out around your " + player.cockDescript(x) + ".\n\n");

			outputText(((player.biggestCockArea() > 50) ? "No matter how much pulsating cock meat you stuff into her hungry pussy, her quaking walls continue to stretch on forever, swallowing your shaft greedily.  " : "" ) + "Your pelvis gently bounces against hers, sending a ripple through her gravid stomach, and you slowly start to buck your hips.  Leaning down over her, you begin to grope and knead her swollen tits, running your hands over the soft, pliable flesh and squeezing firmly to force out a little milk.\n\n");

			outputText("She relaxes submissively as you toy with her breasts, running her fingers through her own flaxen hair and moaning loudly.  Her legs wrap around the back of your [hips] strongly, pulling you forward to press against the underside of her belly, and you can feel the gentle rumble of the eggs still growing in her womb.\n\n");

			outputText("\"<i>H-having fun, I hope?  AAh, I'm so full...</i>\" she says with a husky moan, rolling her eyes back in pleasure.\n\n");

			outputText("As you sink your hands into the soft, squishy flesh of her engorged udders, she reaches up to wrap her arms around your shoulders, pulling you down against her chest.  Her rounded belly juts up underneath you, making it a bit difficult to maintain your balance in this position, but you plant your " + player.feet() + " in the dirt as best you can and redouble the thrusting of your hips.  Running her fingers across the back of your neck, she draws you down to one of her turgid, leaking nipples, moaning softly.\n\n");

			outputText("\"<i>Please...  drink up,</i>\" she says with a shuddering sigh as you latch on and start to suckle her creamy milk.  \"<i>I-is my milk good, dear?</i>\"\n\n");

			outputText("Your only reply is to drink deeply of her thick milk while you pound your hips into her slick vagina like a rutting animal, moaning into her jiggling tits.  Her moans reverberate through her chest, tickling your lips as you suck down the contents of her breast before switching to the other.  As the delicious cream slides down your throat, you are filled with a cool tingling sensation, the distinct aftertaste of wintergreen lacing your tongue.\n\n");

			outputText("The tingling works its way from your core, traveling down to your groin, and you almost lose your mind with pleasure as every squeeze and ripple of her insides is magnified tenfold.  You feel a loud gurgle trembling through her distended abdomen, watching her as pleasure is abruptly replaced with a strained grimace.  You don't have much time - eager to finish, you move your hands down to her hips and begin to thrust into her with a reckless passion, each pump of your hips making her swollen tits flop and jiggle obscenely, droplets of milk flying through the air.\n\n");

			outputText("\"<i>Hh-ah!  Don't stop!  J-just about...  there!</i>\"  she yells out, her face showing a mixture of pleasure and pain while her soaking wet vagina clamps down on you, a warm stream of femcum splashing against your stomach with every thrust.\n\n");

			outputText("Her body suddenly tenses up as you orgasm, and she digs her fingers into your shoulders, gritting her teeth and bearing down on your [cock biggest] with all her strength.  The instant the first streams of your cum begin to pour into her egg-stuffed womb, you feel something hard and round begin to slide down the tight tunnel alongside your twitching member." + ((player.cumQ() > 1000) ? "  Pressurized ribbons of seed begin to spew from the opening of her pussy, each sloppy thrust squelching loudly.  Her gravid tummy takes on a slight liquid jiggle, your cum providing a cushioning buffer between her womb and the eggs." : "" ) + "\n\n");

			outputText("Your cock is pushed free of her folds with a resounding plop, followed shortly afterward by a cum-soaked egg.  " + ((player.cumQ() > 350) ? "Streams of warm jism continue to spurt out of your twitching prick, arcing through the air and landing on her" + ((player.cumQ() > 1000) ? " face, chest, and" : "") + " stomach with a chorus of wet slaps." : "A few more streams of spunk spurt out across the underside of her belly, painting it white with your stringy cum.") + "  She groans deeply, clutching her stomach with both hands as the second egg begins to crown, squeezing out and rolling through a puddle of mixed fluids.  " + ((player.cumQ() > 1000) ? "With every new egg she expels, a small river of semen bursts from her pussy behind it, the flow stopping and starting as each egg descends to plug her hole momentarily before forcefully popping free." : "That egg is soon followed by another, and another, a seemingly endless clutch of them popping free of her clenched pussy one at a time.") + "\n\n");

			outputText("Her stomach gradually deflates with each egg she lays, grunting and straining with effort.  She moans tremendously as the last oversized egg is finally forced out of her drenched cunt, panting with exhaustion in a puddle of sweat, milk, and spunk.  You sit back to catch your breath as well, watching as the kitsune's breasts slowly shrink back to their normal size, and then turn your attention to the pile of eggs on the ground.\n\n");

			outputText("They are ");

			var itype:ItemType;
			//Large eggs
			if (rand(3) == 0) {
				itype = consumables.LARGE_EGGS[rand(consumables.LARGE_EGGS.length)];
			}
			//Small eggs
			else {
				itype = consumables.SMALL_EGGS[rand(consumables.SMALL_EGGS.length)];
			}
			outputText(" about the size of ostrich eggs.  You pick one up and examine it, rolling it in your hand a bit.  A rustling in the bushes brings your focus back to the kitsune, but by the time you look up, all you see is a set of golden tails slipping into the underbrush.\n\n");
			player.consumeItem(consumables.OVIELIX);
			outputText("\"<i>Take good care of my little eggies, darling!</i>\"");
			//{replace normal kitsune loot tables with randomly colored eggs}
			flags[kFLAGS.BONUS_ITEM_AFTER_COMBAT_ID] = itype.id;
			//Advance time 1hr and return to camp. +Sensitivity, +Libido
			player.orgasm();
			dynStats("lib", 1, "sen", 1);
			combat.cleanupAfterCombat();
		}

//[Lactaid]
		private function lactaidDoseAKitSune():void
		{
			clearOutput();
			kitsuneSprite();
			outputText("You lick your lips hungrily, staring at her voluptuous tits, just barely contained in her robes.  Reaching into your pouch, you pull out a bottle of Lactaid and swirl it around in your hand, grinning darkly.  As you lean down over her, the kitsune eyes you suspiciously, her gaze moving back and forth between the bottle and you.  She makes a halfhearted attempt to crawl away, letting out a cry when you grab her by the " + ((player.cor < 33) ? "hem of her robe" : "tail") + ", pulling her back.\n\n");

			outputText("\"<i>Eheh...  you know all that other stuff before was just playing, right?  Eep!</i>\"\n\n");

			outputText("Wrestling her to the ground, you tip the bottle of creamy liquid into her mouth, making it abundantly clear that she's to swallow every drop.  You keep the lip of the bottle pressed up to her mouth until she has obediently swallowed the entire contents, then dispose of the empty container.\n\n");

			outputText("Almost immediately, her already sizeable breasts begin to expand, swelling up against the inside of her robes before spilling over with a bountiful jiggle.  She moves her hands up to support her rapidly expanding bust, her tits growing several cup sizes in the space of a minute.  Once the swelling in her breasts begins to slow, her nipples follow suit, the areolae puffing out and swallowing her pinkie-sized nubs.  Slowly at first, a creamy white substance begins to drip from her inverted nipples, the flow increasing gradually over time.\n\n");

			outputText("\"<i>M-my chest!  F-feels so...  hot...</i>\" she moans, rolling her eyes back and beginning to play with her breasts, kneading the expansive flesh with both hands as milk trickles down the curves and over her fingers.  All told, you judge her tremendous mammaries to be about H-cups in size, far out of proportion for even her curvy frame.\n\n");

			outputText("You grin and rub your palms together lecherously, then reach out to snatch them out of her hands, explaining that her fat milk-udders belong to you now.  With one of her obscenely huge tits in each hand, you press them together, squashing them up between your palms and shuddering at the way they feel.  The incredibly soft flesh spills over your fingertips with every squeeze, milk spurting from her puffy, puckered nipples and drenching her front.  Tentatively, you lift one of your milk-soaked fingers to your lips and lick it, savoring the sweet, almost minty aftertaste that sends an involuntary shudder down your spine.\n\n");

			outputText("Pleased with the results of your little experiment, you release her gargantuan jugs, letting them bounce and quiver back into position before standing up.  Shedding your " + player.armorName + ", you run your hands down over your groin, lowering yourself down over her once again and scooting up to press against the underside of her breasts.  Laying [eachCock] in between the heaving mounds of titflesh, you gather up her breasts and squash them together again, moaning as the soft skin envelops your throbbing member" + ((player.cocks.length > 1) ? "s" : "" ) + ".  Warm milk trickles down into her cavernous cleavage, flowing over your shaft" + ((player.cocks.length > 1) ? "s" : "" ) + " and leaving behind an odd tingling sensation that makes you shudder.\n\n");

			outputText("\"<i>Ooh...  that feels...</i>\" she groans, a soft pink blush spreading on her cheeks as she bites her knuckle.\n\n");

			outputText("Your hands stray upward toward her puffy areolae, and you circle your thumbs across the sensitive flesh, eliciting a chorus of shameless moans from the kitsune.  She arches her back, thrusting her chest upward underneath you and spurting copious streams of milk into the air like a lewd fountain.  You press your fingertips down into her pliable jugs, watching the way the jiggling flesh ripples and squashes around your hands with an almost giddy delight.  Even the slightest amount of pressure causes a fresh trickle of milk to spill out of her inverted nipples, dribbling down and filling the expansive canyon in between.\n\n");

			outputText("You slowly begin to thrust [eachCock] through the slippery passage, revelling in the way her tremendous tits squeeze around your throbbing shaft" + ((player.cocks.length > 1) ? "s" : "" ) + ".  The warmth of her flesh contrasts wonderfully with the cool tingling of her milk coating your cock" + ((player.cocks.length > 1) ? "s" : "" ) + ", heightening your pleasure to incredible levels and making you groan and shiver.  Her chest rises and falls beneath you with every heaving breath she takes, shuddering with her needy moans.\n\n");

			outputText("\"<i>Oh Marae, it feels so good!</i>\"  she moans, rolling her eyes in pleasure as you continue to thrust [eachCock] in between her sensitive tits.  \"<i>Fuck my tits, k-keep going!</i>\"\n\n");

			outputText("She moves her forearms up to press against the sides of her breasts, hooking her fingers over the top of her bust and squeezing inward with her elbows.  Freed to move your own hands elsewhere, you knead her nipples for a bit, running your thumbs in wide circles around the edges as you slowly spiral them inward.  Pressing your thumbs inward, you spread the puffy pucker of her areolae, inserting your fingers to get at the sensitive nubs inside.  She cries out in ecstasy when you pinch her engorged nipples, squeezing thick streams of milk out as you pull on them gently, forcing them to pop out.  It is only now that you can truly appreciate the effects of the Lactaid you fed her, her sensitive pink nubs having swollen up to the size of large cherries.\n\n");

			outputText("Pinching around the base of her overgrown teats, you tilt them toward her face and squeeze, spurting milk into the kitsune's face.  She winces in surprise at first, but then opens her mouth, catching the streams on her tongue and lapping them up eagerly.  With a firm squeeze, you then aim her engorged nipples toward your own mouth, leaning down to drink deeply.  A good deal of it misses your tongue and begins to drip messily down your chin, but you savor the taste of what little you manage to get in your mouth, humming your satisfaction.\n\n");

			outputText("Together with her, you squash her jiggling jugs against [eachCock] as tight as you can and begin to thrust with renewed vigor, sending ripples through her chest each time your hips impact her milk-swollen tits.  She moans shamelessly, craning her neck up to lap up her milk from the tops of her breasts and even running her tongue across [oneCock] whenever it is within reach.  Shuddering heavily, she begins to slide her arms up and down the sides of her chest, adding a little extra sensation to the wonderful titfuck.  Her breasts are constantly gushing milk now, her entire front soaked through and a puddle forming around her on the ground.\n\n");

			outputText("Bearing down on her chest, you redouble your thrusting, the telltale quivering of an inevitable orgasm starting to build in your loins.  Loud liquid slapping noises fill the air each time you pass in between her immense udders, milk and precum coating every inch of her cleavage.  With a groan, you buck your hips forward one last time, [eachCock] twitching as your climax boils to the surface.\n\n");

			if (player.cumQ() <= 150) {
				outputText("Spurts of thick semen bubble out in between her breasts, a few pressurized streams flying across the space from her chest to her face and landing wetly on her lips.  Thick globs dribble down to pool in the shallow depression above her sternum.");
			}
			else if (player.cumQ() <= 350) {
				outputText("Her cavernous cleavage is filled with your bubbling seed, thick spurts of semen splattering out onto her neck and face.  Her chest is plastered with milk and cum, dribbling and flowing down around her shoulders and chin.");
			}
			else if (player.cumQ() <= 1000) {
				outputText("Pressure builds in your groin, your shaft" + ((player.cocks.length > 1) ? "s" : "" ) + " swelling up in the moments just before your orgasm.  Thick ribbons of cum spurt from between her tits, flying across her face and neck with a series of wet slaps.  Her chest and face are drenched with a creamy mask of milk and cum, a thick pearl necklace slowly dripping down around her shoulders.");
			}
			else {
				outputText("Your cock");
				if (player.cocks.length > 1) outputText("s swell");
				else outputText(" swells");
				outputText(" up incredibly from the thick loads of seed rushing out all at once, a thick ribbon of cum splattering against the walls of her cleavage and spurting out onto her face.  Load after load of semen spurts from between her breasts, coating her face and chest with a sticky mask that mats down her golden hair.");
				if (player.cumQ() >= 2500) outputText("  It seems as though your climax goes on forever, fresh streamers of cum flying everywhere until the milky white puddle surrounding her is equal parts milk and seed.");
			}

			outputText("\n\nShe groans deeply as an unexpected climax shudders through her chest, fresh fountains of milk spurting everywhere like a warm, creamy sprinkler and raining down around you.  Even after you lie back in satisfaction to catch your breath, the kitsune's breasts continue to leak milk, rivulets of creamy white slowly flowing down the massive curvature of her chest.  When you stand up to clean yourself off at last, you look back to see the horny fox-woman hefting one of her engorged jugs to her lips, suckling deeply.");
			//Advance time 1hr and return to camp. +Sensitivity, +Libido
			player.orgasm();
			dynStats("lib", 1, "sen", 1);
			//consume lactaid
			player.consumeItem(consumables.LACTAID);
			combat.cleanupAfterCombat();
		}


//Black-hair-exclusive
//[Hotdog Anal] - replaces regular Anal option only for the black-haired girl.
		private function hotdogAnalInKitsuneButtDontLetTailTickleYourNose():void
		{
			clearOutput();
			kitsuneSprite();
			var x:int = player.cockThatFits(144);

			outputText("You let your gaze wander lecherously up and down her prone form, taking your time to observe every voluptuous curve.  Finally your eyes come to rest on her enormous ass, her robes haphazardly rolled up to her hips to leave the jiggling flesh exposed.  A large sun-shaped tattoo adorns the right cheek, accentuating the creamy flesh of the rounded globes with an exotic splash of color.  They quiver heavily with even the slightest movement, jiggling in an almost hypnotic fashion that compels you to come closer.  Before you know it, you are on top of her, lifting her expansive rump into the air and grinding against her in unabashed lust.\n\n");

			outputText("She cries out in surprise as you manhandle her into position, but sinks low in submission once you settle into a rhythm, her tails swishing to and fro as they wrap around your body.  The shiny black coils work their way under your " + player.armorName + ", pulling them away with a practiced skill.  Fluffy, bushy tails caress [eachCock] gently, drawing " + ((player.cocks.length > 1) ? "them" : "it") + " up between the mountainous cheeks of her derriere, stroking " + ((player.cocks.length > 1) ? "them" : "it" ) + " fondly with the tips.  Your hands slide along the wide curves of her hips, sinking into her soft love handles as her quivering hind cheeks gently caress the sides of your " + ((player.cocks.length > 1) ? "shafts" : "shaft" ) + ".\n\n");

			outputText("Her tails slide away, leaving [eachCock] to be cradled gently by her prodigious posterior.  Instead, they spread out to frame her cream-colored globes against a blanket of raven fur, enhancing their prominence even more.  Easing down onto her elbows, she rests her head on her arms and gives you a sidelong glance through half-lidded eyes, batting her eyelashes flirtatiously.\n\n");

			outputText("\"<i>You like my ass, huh?  Well, what can I say, you clearly have exquisite taste,</i>\" she says with a smirk, punctuating her statement by slapping her rump into your hips gently.  Her ass thuds against you heavily, the sun-shaped marking on the right cheek distorting delightfully as the flesh jiggles and ripples from the impact.\n\n");

			outputText("You give her a firm slap on the ass, and she moans in response, rolling her eyes back in pleasure and sinking down submissively.\n\n");

			outputText("\"<i>Mmn, again...  Spank me!</i>\"\n\n");

			outputText("Another hearty 'crack' echoes through the forest as your palm connects with her ass again, sinking into the pliable flesh and sending ripples through it.  Her tongue lolls out obscenely, the fur on her tails frizzing as she bucks forward, panting heavily.  You feel something warm and wet trickling down the front of your " + player.legs() + ", and grin when you realize that she's really getting off on this!\n\n");

			outputText("You grip her mountainous cheeks firmly in either hand and squeeze them together around [eachCock], thrusting your hips forward slowly and powerfully.  Her expansive rump is nearly large enough to encompass your " + ((player.cocks.length > 1) ? "shafts" : "shaft" ) + " all the way around, warm flesh squashing and jiggling against " + ((player.cocks.length > 1) ? "them" : "it") + " on all sides.  Her hips slide back to meet yours with each thrust, eagerly caressing your " + ((player.cocks.length > 1) ? "cocks" : "cock" ) + " with her quivering bottom, moaning contentedly.\n\n");

			outputText("One of her tails slides up against your stomach and curls its way downward, encircling your " + player.cockDescript(x) + " with its fluffy warmth.  It gently constricts the base, squeezing you with just enough pressure to make the veins of your shaft swell against the surface, throbbing gently.  The tip of her tail snaps against the underside once or twice, and with the sound of striking a match, your shaft is suddenly engulfed in azure flames that dance around it, leaving a cooling tingle in their wake.  Every sensation is enhanced by the presence of the flames, icy coolness mixing with an ethereal heat that surrounds [eachCock] on all sides.\n\n");

			outputText("You squeeze her hips and thrust forward against her rump a few more times, feeling the tension of your climax approaching.  Enough foreplay, then - it's time for the main event.  Sliding your " + player.cockDescript(x) + " between her shuddering cheeks one last time, you draw back and angle her hips up a bit, lining up against her tight pink asshole.  As you thrust forward, the muscular ring guarding her rectum gives way with a surprising ease, almost drawing you inward of its own volition as it squeezes your throbbing rod.  She licks her lips and pushes her hips back to fully engulf your cock with her warm, tight ass, reaching back to grasp her own ass cheek as she bears down with her anus, trapping you inside.\n\n");

			outputText("\"<i>Oh, you're as good as mine, now,</i>\" she says with a pleasureful sigh, her cheeks flushing a deep red as you pull back to plunge forward again, squeezing the cheeks of her ass together around your shaft as you do so.  \"<i>Got you right...  ah!  Where I want...  you...</i>\"\n\n");

			outputText("She does, does she?  Somehow, her bluff falls a bit flat, especially when she has to pant it out between gasps of pleasure as you roughly pound into her ass.  Of course, since this was what she wanted in the first place, in a way she's right.  Rather than waste your time thinking about the intricacies of the situation, you resume your rhythmic thrusting, pummeling her rear with your " + player.cockDescript(x) + " as she moans shamelessly in utter bliss.\n\n");

			outputText("Strong muscles ripple up and down the length of your rod, squeezing you in ways you previously would have never thought possible.  Her innards clamp around you with an otherworldly warmth, caressing your length and milking the shaft skillfully.  Each time you pull back, it feels almost as though her ass draws you inward again, sucking you back into her depths.\n\n");

			outputText("The loud slapping of your hips buffeting her expansive rear fills the air, joining her moans in a percussive rhythm of ecstatic pleasure.  Her tails lash themselves to your limbs, pulling you forward, and in her enthusiasm, she inadvertently loses control, pulling you onto her back.  As you tumble forward, her legs give out, and she collapses beneath you, the sudden impact knocking the wind from her lungs.\n\n");

			outputText(((player.cor > 45) ? "Without waiting to confirm if she is unharmed," : "After briefly confirming that she is for the most part unharmed,") + " you readjust your balance and resume your rhythm, holding onto her shoulders for support.  As you pull back for another thrust, she closes her thighs together gently, causing her prominent cheeks to become even more pronounced.  They serve well to cushion the blows as you pump downward powerfully, jiggling like gelatin with each pounding buck of your hips.\n\n");

			outputText("You grip her love handles tightly, sinking your fingertips into the soft, plushy flesh, and eagerly pummel her tight ass, slapping your hips into her bountiful butt cheeks over and over.  Her thighs tense and relax in time with your thrusts, working along with the inner muscles to give your " + player.cockDescript(x) + " a sensual massage rivalling that of a master masseuse.  Everything above her waist, however, is utterly relaxed, splayed out into a lewd heap of decadent desire.  The merest hint of a sliver of emerald is visible as her eyes roll into the back of her head, her tongue flopping out of her mouth along with a healthy trail of drool.\n\n");

			outputText("One last slap echoes through the clearing when you slam yourself into her ass for the final time, moaning in ecstasy as your " + player.cockDescript(x) + " twitches wildly in climax.  ");

			if (player.cumQ() <= 150) {
				outputText("The convulsing muscles of her rectum milk your shaft strongly, squeezing from base to tip as you spill stream after stream of thick, cloying cum into her innards.  At the peak of your pleasure, you resume your lustful thrusting, her flesh quivering in shallow waves as your orgasm begins to wane.  As the last stream spurts into her abused asshole, you plant your palms against her thick ass cheeks and squeeze them together around your shaft, pulling back slowly as her anus clamps down, milking the last of your load from your urethra.\n\n");

				outputText("She lies spread eagle on her face, panting contentedly as her six ebony tails waft left and right in the air.  A small spurt of cum follows your cock shortly after you pull out, dribbling onto the ground between her thighs.");
			}
			else if ((player.cumQ() <= 350)) {
				outputText("The convulsing muscles of her rectum milk your shaft strongly, squeezing from base to tip as you spill hot ribbons of thick, sticky seed into her innards.  At the height of your pleasure, you resume your lustful thrusting, her flesh quivering continuously as your orgasm begins to wane.  As one last stream spurts into her abused asshole, you plant your palms against her thick ass cheeks, digging your fingertips into the flesh and squeezing them together around your shaft.  Her anus clamps down around your throbbing rod as you slowly pull back, squeezing the last of your load out of your urethra.\n\n");
				outputText("She lies spread eagle on her face, panting contentedly as her six ebony tails waft left and right in the air.  A small spurt of cum follows your cock shortly after you pull out, splattering onto the ground between her thighs.");
			}
			else if ((player.cumQ() <= 1000)) {
				outputText("The convulsing muscles of her rectum milk your shaft strongly, rippling sensations squeezing you repeatedly from base to tip as you pour out thick ribbons of seed into her innards, splattering her intestines with your cloying cum.  At the height of your pleasure, you resume your lustful thrusting, her flesh quivering continuously in time with each powerful spurt of cum as your orgasm begins to wane.  As the last few thick streams fill her abused asshole, you dig your fingertips into her pliable flesh and squeeze her ass cheeks together around your shaft.  Her anus clamps down hard around your throbbing rod as you slowly pull back, squeezing the last of your load from your urethra.\n\n");
				outputText("She lies spread eagle on her face, panting contentedly as her six ebony tails waft left and right in the air.  A thick gush of cum follows your cock shortly after you pull out, splattering onto the ground between her thighs.");
			}
			else if ((player.cumQ() <= 2500)) {
				outputText("The convulsing muscles of her rectum milk your shaft strongly, heavy rippling sensations squeezing you repeatedly from base to tip as you pour out inhuman amounts of seed into her innards, stuffing her intestines with your cloying cum.  A husky groan escapes her throat as she begins to rise off the ground a little, the obscene amounts of semen distending her stomach as you fill her utterly and completely.  At the height of your pleasure, you resume your lustful thrusting, her flesh quivering continuously in time with each powerful spurt of cum as your orgasm begins to wane.  As the last thick streams stuff her abused asshole, you dig your fingertips into her pliable flesh and squeeze her ass cheeks together around your shaft.  Her anus clamps down hard around your throbbing rod as you slowly pull back, hungrily milking the last of your load from your urethra.\n\n");
				outputText("She lies spread eagle on her face, panting contentedly as her six ebony tails waft left and right in the air.  An outpouring of cum follows your cock shortly after you pull out, pooling on the ground one stream at a time between her thighs.");
			}
			else {
				outputText("The convulsing muscles of her rectum milk your shaft strongly, heavy rippling sensations squeezing you repeatedly from base to tip as you pour out truly monstrous amounts of seed into her innards, stuffing her with your cloying cum.  A husky groan escapes from her throat as she begins to rise off the ground, the obscene amounts of semen filling her stomach like a balloon as your seed surges through her intestines.  Her hindquarters are raised into the air as she tilts forward on her cum-bloated belly, now filled out to the size of an exercise ball.  At the height of your pleasure, you resume your lustful thrusting, her flesh quivering continuously as you fill her to excess, pressurized jets of semen spurting out around your " + player.cockDescript(x) + ".  As the last of your load stuffs her abused asshole, you dig your fingertips into her pliable, cum-streaked flesh and squeeze her ass cheeks together around your shaft.  Her anus clamps down hard around your throbbing rod as you slowly pull back, hungrily milking the last of your load from your urethra.\n\n");
				outputText("She lies spread eagle on her face, panting contentedly as her six ebony tails waft left and right in the air.  A continuous river of cum follows your cock shortly after you pull out, pooling on the ground between her thighs in a slippery puddle.");
			}
			outputText("\n\nShe rolls onto her side, curling up in a puddle of sweat and sex, resting her hands on her " + ((player.cumQ() > 1000) ? "inflated" : "pudgy" ) + " stomach and sighing contentedly, the tips of her tails gently twitching with residual pleasure.  You take a moment to recuperate, then gather your things and turn toward camp, leaving the insensate kitsune to recover on her own.");
			//Advance time 1hr and return to camp. +Sensitivity, +Libido
			player.orgasm();
			dynStats("lib", 1, "sen", 1);
			combat.cleanupAfterCombat();
		}


//[Feeder]
		private function feederTheKitsunes():void
		{
			clearOutput();
			kitsuneSprite();
			outputText("As you stand over the beaten trickster, you pick up the faint sound of a groan coming from her stomach.  Her hands rest on the pudgy curve of her stomach, rubbing it idly and grimacing.\n\n");

			outputText("\"<i>So hungry...</i>\"\n\n");

			outputText("Hungry, is she?  You grin and tell her that you have just the solution, closing in on her with a predatory glint in your eyes.\n\n");

			outputText("She winces slightly as her back hits a tree, her attempts to crawl to safety foiled succinctly as you swoop down, firmly gripping her by the shoulders.  The slightest hint of fear shows in her eyes as you lord over her, but she is obviously making every effort to hide it, her plush lips quivering as she smirks up at you, trying to maintain a calm, demure facade.  The moment you pull your " + player.armorName + " away, revealing your [chest], her glistening green eyes seem to grow to the size of dinner plates.  She licks her lips, following the steady trickle of creamy white rolling down the curves of your breasts.\n\n");

			outputText("Her eyes glitter magnificently, no longer with fear, but with lust, and hunger.  You lower yourself down to straddle her legs, pinning her against the tree with your body, though at this point you presume that no such restraints are necessary to keep the gluttonous kitsune from escaping.  As your ponderous, milk-laden tits sway back and forth, her gaze follows your leaky nipples, transfixed by the hypnotic jiggling.  Her tongue idly runs along her upper lip, moistening the plump, soft pillows in preparation for her much-anticipated meal.\n\n");

			outputText("\"<i>Milk...</i>\" she whispers breathlessly, leaning forward to latch onto your [nipple] without hesitation.  She moans with approval, closing her eyes and drinking deeply of your overflowing milk-udders, suckling sloppily.\n\n");

			outputText("Twin streams of cream flow down the corners of her mouth, dribbling inward and joining beneath her chin and rolling down the curve of her neck.  As she drinks down your milk greedily, she releases a diverse assortment of lewd noises, pressing her face into your pillowy chest.  Patting the top of her head gently, you hold her face against your cleavage, rocking gently as you trail your fingers slowly through her soft, ");
			if (monster.hairColor == "black") outputText("lustrous black ");
			else outputText(monster.hairColor);
			outputText("hair.\n\n");

			outputText("She looks up from your breasts momentarily, her fiery green eyes dulled and glazed over with submission.  You shudder and moan approvingly, wrapping both arms around the captive kitsune and hugging her to your bosom assertively.  Her plump, full lips never once leave your [nipple], the soft, moist pillows feeling wonderful as they suckle on you passionately.\n\n");

			outputText("Her hands knead and caress both of your breasts, catching your free nipple in between her fingers to tug and pull on it, squeezing out a stream of fresh cream onto her face.  You begin to gently scratch behind her large, triangular ears, rocking her back and forth in your arms slowly.  She coos softly and leans into your soft breasts, a warm pink blush spreading across her cheeks slowly.  Your ears are met with the melody of a gentle humming tune, and it takes a moment to realize that the sound is coming from you!\n\n");

			outputText("You shift your position to a more comfortable one, the kitsune whining needfully as you momentarily pull away, sitting on the damp grass and pulling her into your lap.  She curls up submissively in your arms, pressing herself against your form as she resumes groping and suckling upon your [chest].  Humming your matronly tune, you rock the hungry girl back and forth, fingers cascading through her long, luxurious hair slowly.\n\n");

			outputText("Your other hand slowly travels along the soft curves of her body, teasing and squeezing her breasts and pinching her pudgy belly.  You smirk as you notice it has a bit more weight to it than previously, patting the jiggly bulge gently - the foxy glutton has certainly been having her fill.  Your palm glides over her wide hips, fingers sinking into the soft flesh of her expansive ass momentarily before moving up to the base of her soft, fluffy " + monster.hairColor + " tails.\n\n");

			outputText("The instant you start to scratch the fine hairs where her tails meet the small of her back, her entire body becomes flushed with arousal, lips latching around your teat even tighter than before.  One of the coils latches onto your wrist, twisting around your forearm and holding on for dear life.  Her entire body shudders as she continues to eagerly imbibe the milk contained within your swollen milk-udders, one hand slowly trailing down toward her dampening pussy.\n\n");

			outputText("You grab hold of her wrist mere moments before she manages to shunt a finger up into her pussy, stopping her just short of pleasuring herself.  She looks up at you pleadingly, her hand trembling just above her entrance, still gulping down mouthfuls of your milk, unable to break your power over her.  You pause your gentle humming to give her a disapproving look, and she slowly retracts her hand, whimpering quietly.  She doesn't seem to understand why her body isn't listening to her, fingers twitching above her needy snatch.\n\n");

			outputText("You clutch her to your breast firmly, extinguishing her resistance with a fresh stream of milk.  Her hand falls limply in her lap, though her pussy continues to leak viscous pools of fem-juice all over her thighs, her body trembling with unmet need.  Her stomach has expanded incredibly from the preposterous amounts of milk she has consumed, the thin layer of chubbiness around her abdomen stretched a bit tighter over the distinctly rounded bulge.  She shows no sign of stopping or even slowing down, hungrily draining your tits of every drop of precious, creamy white fluid.\n\n");

			outputText("Running your hands over the jiggling dome of her belly, you stroke her tightening flesh sensually, resuming your gentle humming.  The pressure in your breast begins to wane, the creamy hindmilk beginning to drain into the ravenous girl's gullet.  With a satisfied sigh, you shift her over to the other breast, chuckling softly as the sloshing sound of milk meets your ears, her swollen abdomen quivering heavily.\n\n");

			outputText("She becomes wetter with each passing moment, a new rush of fluid soaking your " + player.leg() + " with each gulp she takes.  Rewarding the girl for her admirable efforts in draining your milk-laden tits, you slide a finger in between her legs and grant her the pleasure she sought for herself earlier, rolling her cherry red clitoris back and forth under your fingertip slowly.  You slip your middle and ring fingers into her entrance, forcing a gasp from her throat that causes her to choke a bit, milk sputtering out and soaking her front.\n\n");

			outputText("You begin to pump your fingers in and out of her damp slit, and the girl continues to groan loudly in between gulps, gorging herself on your bountiful breastmilk.  The closer she comes to emptying your breast, the faster and harder you finger her cunt, pushing her up to a climax as you feel an odd building pleasure of your own.\n\n");

			outputText("Heat spreads across your chest, buzzing over the surface of your " + player.skin() + " as a deep flush covers your body.  The kitsune curls up, clamping her thighs around your forearm and thrusting her hips down against your hand, her muscular snatch clenching around your fingers and convulsing powerfully.  She somehow finds the time to finish off your breast in between her own raucous moans, while you groan deeply in pleasure yourself, the sweet relief of temporary emptiness tingling through your [chest].\n\n");

			outputText("Having drank fully and completely of your milk, the kitsune collapses flat on her back in your lap, panting in exhaustion while her cunt continues to gently suckle on your fingertips.  Her belly has ballooned to the size of a beach ball, quivering with each breath she takes, her robes hanging open and unable to close around it.  She wraps both arms around her belly, stroking it lovingly and moaning occasionally while her tails twitch limply beneath her.\n\n");

			outputText("\"<i>Oh...  I'm stuffed...</i>\" she moans, her eyes rolled up in her head and her tongue running across her lips, savoring the dregs of milk that still cling to them.\n\n");

			outputText("You carefully lay her on the ground, standing and donning your " + player.armorName + " once again.  The kitsune remains rooted in the spot, weighed down by her oversized tummy.  Something tells you she won't be moving from that spot for some time.");
			//Advance time 1hr and return to camp. +Sensitivity
			//You've now been milked, reset the timer for that
			player.addStatusValue(StatusEffects.Feeder, 1, 1);
			player.changeStatusValue(StatusEffects.Feeder, 2, 0);
			player.orgasm();
			dynStats("sen", 3);
			combat.cleanupAfterCombat();
		}

//[GetBJ] - requires cock 108 area or less
		private function getABJFromAFoxGirl():void
		{
			clearOutput();
			kitsuneSprite();
			var x:int = player.cockThatFits(108);

			outputText("Standing over the beaten kitsune, you hear a barely audible groan.  Curiously, you lean down, and are surprised to find that the sound is coming from the girl's stomach.\n\n");

			outputText("She gently rubs her somewhat pudgy tummy, sighing and whimpering, \"<i>So hungry...</i>\"\n\n");

			outputText("So, she's hungry, is she?  With a smirk, you tell her you have just the thing to fix that.\n\n");

			outputText("Stripping out of your " + player.armorName + ", you pull her into a kneeling position and press her back against a tree, presenting your " + player.cockDescript(x) + " with a grin.  She ogles it hungrily and licks her lips, eyes wide with desire.  As she reaches up to take it into her hands, you grab her wrists instead and pin them to the trunk of the tree.  You explain that she is to use only her mouth, and that if she does her job properly, <i>then</i> you will satiate her hunger.\n\n");

			outputText("She pouts coyly, pursing her plush, kissable lips.  Your eyes are drawn to them, and it is only now that you notice just how juicy and full-looking they truly are.  As she leans forward to press them to your " + player.cockHead(x) + ", they seem to plump up even more, their warm wetness sending a shiver of pleasure through your groin.\n\n");

			outputText("Grinning up at you, she dips underneath your shaft, lifting it up with her nose, flattening out her tongue around the underside of your " + ((player.hasSheath()) ? "sheath" : "base") + " and running it slowly upward.  Having her wrists restrained doesn't seem to be hampering her ability to pleasure you much at all - it even seems to be turning her on.  She pushes your " + player.cockDescript(x) + " up against your stomach using her nose, kissing along the underside longingly and making wet smacking sounds.\n\n");

			outputText("\"<i>Mmn...  it'th tho delithiouth...  can'th waith thil 'oo fee' me lotth of tasthty cu'n,</i>\" she slurs around your hardening member, always staring up at you demurely with those big green eyes.\n\n");

			outputText("Inch by inch she trails her tongue up the shaft, lavishing your cock with affection as she loudly and shamelessly licks and laps her way up and down.  With one final exaggerated slurp, she runs her wet tongue from " + ((player.hasSheath()) ? "sheath" : "base") + " to " + player.cockHead(x) + ", narrowing her eyes mischievously.  Warm wetness encases the end of your member, a gentle breeze cascading over it as she exhales slowly from her nose.  The contrast of her cool, minty breath and the warmth of her mouth sends sparks of flaming pleasure zig-zagging down your shaft, making you shiver.\n\n");

			outputText("You have to admit, the gluttonous slut certainly has skills!  You have to suppress a moan when she parts her plump lips into a large O and engulfs your member, her cheek bulging out as she tilts her head to one side, trapping you there.  Righting herself, she begins to bob her head, pushing you to the back of her throat repeatedly.  The pillowy caress of her plush pink lips sliding around your member ripples through your loins, making you groan deeply in pleasure.  Before you can get too ahead of yourself, though, she pulls back, lips squeezing tightly every inch of the way until your throbbing cock breaks free of her lips with a resounding 'plop'!  She skillfully catches the tip on her lower lip, her tongue snaking out to gently cup the underside.\n\n");

			outputText("\"<i>Mmn...  I'n tho lucky...</i>\" she croons, the corners of her mouth curling up as she kisses it gently, blowing cool azure flames across the tip.  \"<i>Doeth it theel good?</i>\"\n\n");

			outputText("Your shaft is swallowed up once more, forced to the back of her throat as she gulps down inch after inch of your throbbing meat.  She pulls back, sucking as though her life depended on it, then dips down again, slurping up your salty precum desperately.  The " + player.cockHead(x) + " of your cock hits the back of her throat again and again, ");
			if (player.cocks[x].cockLength > 9) {
				outputText("each bob of her head inching her lips closer and closer to your ");
				if (player.balls > 0) outputText(player.ballsDescriptLight());
				else outputText("[sheath]");
				outputText(".  She hungrily swallows along your length, moaning into your engorged prick as she finally presses her lips to your " + ((player.hasSheath()) ? "sheath" : "base") + " and rolls her eyes back in pleasure, her neck bulging slightly from the presence of your shaft.\n\n");
			}
			else outputText("her lips squeezing sensually around the " + ((player.hasSheath()) ? "sheath" : "base") + " each time she goes down you.  Moaning intensely, she closes her eyes and rolls your " + player.cockDescript(x) + " back and forth in her mouth, swirling her tongue sensually along it.\n\n");

			outputText("Her throat muscles ripple and pulse around you, making loud slurping and gulping noises that only fuel your lust.  She pulls back, her lips pursed around just the very tip as she stares up at you needfully for a moment before closing her eyes and downing your entire length once more.  With her face impaled on your member, you can feel her tongue slithering out of her mouth, looking down to see the obscenely long appendage coiling around your member and squeezing gently.  Your cock bulges out around it, swelling up incredibly, and the kitsune looks up at you, playing innocent.\n\n");

			outputText("She resumes her wild deep-throating, moaning through your cock as she swallows it whole time and time again.  Strings of saliva mixed with precum start to fly from the corners of her mouth with each bob of her head, dribbling down your shaft" + ((player.balls > 0) ? " and over your " + player.ballsDescriptLight() : "") + ".  Driven by lust, you opt to forgo your prior negotiations, releasing her wrists to instead grab the back of her head.  A light giggle trembles through your cock as you thrust your hips forward, tilting her head back a little and moaning deeply.\n\n");

			outputText("Taking advantage of her newfound freedom, the kitsune slides her hands up and down your sides, wisps of flame sparking to life and dancing along her fingertips, seeking only to heighten your pleasure.");

			outputText((((player.balls > 0) || (player.vaginas.length > 0)) ? "  Trailing them across your sides, she " + ((player.balls > 0) ? "cups your " + player.ballsDescriptLight() + " in her hand, squeezing tightly" + ((player.vaginas.length > 0) ? " and " : "") : "") + ((player.vaginas.length > 0) ? "runs her index finger teasingly along your slit" : "" ) + "." : "" ));

			outputText("  Her throat muscles relax entirely, and she happily submits herself to your brutal face-fucking.\n\n");

			outputText(((player.cocks[x].cockLength > 15) ? "Again and again, you thrust your [hips] forward, mashing your pelvis against her face.  Your " + player.cockDescript(x) + " glides down her throat, making her neck bulge outward, and her only response is to moan into it, swallowing hungrily.  She massages your shaft sensually with her lips, using her tongue and throat" : "She massages your shaft sensually with her lips, using her tongue") + " to eagerly draw you inside again each time you pull back.  From the intense moaning that is vibrating through your bucking groin, you judge that she must enjoy being used like this, a thought that only heightens your desire even more.\n\n");

			outputText("You feel a tightness swelling in your " + ((player.balls > 0) ? player.ballsDescriptLight() : "prostate") + " as your pleasure starts to come to a head, running your fingers down through her soft, raven-colored hair.  Her glistening green eyes roll back in her head as she opens her throat to accept your orgasm gleefully, her tongue dancing along your length.  When your climax hits, a thick bulge begins to swell up just behind where her tongue still has a tight grip on your " + ((player.hasSheath()) ? "sheath" : "base") + ".  It builds until the pressure is too much to hold back, and then releases all at once, the kitsune moaning powerfully into your cock as the delicious, salty cream pours into her throat.\n\n");

			outputText("She sucks it down hungrily, gripping your shaft with both hands and milking it for all it's worth, as though it is the last meal she'll ever have.  ");

			if (player.cumQ() <= 150) {
				outputText("As stream after stream of sticky seed cascades down her throat, her tongue swirls around inside her mouth, gathering up every stray drop.  Swallowing eagerly, she gulps down your shaft one last time, tightening her lips and squeezing the final few globs of cum from your urethra as she pulls back with a loud 'smack!'\n\n");

				outputText("\"<i>Mnn...  so tasty...  is there...  is there any more?</i>\"  she asks hopefully, wiping spittle from the corner of her mouth and licking her fingertips hungrily.");
			}
			else if ((player.cumQ() <= 350)) {
				outputText("You pour ribbon after ribbon of thick seed into her throat, moaning orgasmically as her tongue swirls around to catch any stray drops.  Swallowing eagerly, she gulps down your shaft one last time, tightening her lips and squeezing the final few globs of cum from your urethra as she pulls back with a loud 'smack!'\n\n");
				outputText("\"<i>Mmn, that was...  delicious,</i>\" she says with a happy smile, licking her lips in satisfaction.  \"<i>Are you sure you don't have just a little more?</i>\"");
			}
			else if (player.cumQ() <= 1000) {
				outputText("Thick streamers of seed spurt down her throat, filling her stomach with your roiling, salty cum.  Swallowing eagerly, she gulps down your shaft one last time, tightening her lips and squeezing the final few globs of cum from your urethra as she pulls back with a loud 'smack!'\n\n");

				outputText("\"<i>Ooh, that was </i>divine<i>,</i>\" she says with a satisfied grin, patting her stomach and licking her lips wantingly.  \"<i>Please...  do you have any more?</i>\"");
			}
			else if (player.cumQ() <= 2500) {
				outputText("A torrent of thick semen distends your shaft and spills down her throat, making it bulge slightly from the volume trying to flow down all at once.  Even with all her enthusiastic sucking, a few stray streams manage to escape, spurting from the corners of her mouth and dribbling down her chin.  Groaning deeply around your cock, she sucks down every last drop you have to offer, her slightly pudgy stomach bulging out slightly as she swallows stream after stream.  She gulps down your shaft one last time, tightening her lips and squeezing the final few globs of cum from your urethra before pulling back with a loud 'smack!'\n\n");

				outputText("\"<i>Ooh, that was </i>divine<i>.  So much...</i>\" she says, leaning back against the tree and rubbing her now rounded stomach in satisfaction, her tongue running along her upper lip slowly.  \"<i>Do you think I could have just a bit more?</i>\"");
			}
			else if (player.cumQ() <= 6000) {
				outputText("Thick globs of seed distend your shaft, pouring out into her throat in a white river, her neck bulging slightly from the sheer volume of semen flowing down it all at once.  She does her best to swallow every drop, her pudgy stomach beginning to swell out into a rounded bulge, but even her enthusiastic suckling is not enough to prevent it from backing up.  Thick streams of semen spray from the corners of her mouth, her tongue desperately trying to catch them while twin jets of cum spurt from her nostrils, dripping down over her chin.  Her belly has swollen out into an obscenely huge rounded bulge that jiggles with each fresh stream you add to it, plastered with the drippings that she couldn't swallow.  She downs your shaft one last time, tightening her lips and squeezing the final few globs of cum from your urethra as she pulls back with a loud 'smack!'\n\n");

				outputText("\"<i>Ooooooooh, yes...  so much...  so delicious...  I'm stuffed,</i>\" she babbles incoherently, rubbing her belly with a look of utter satisfaction on her face.  \"<i>You can come fuck my throat anytime...</i>\"");
			}
			else {
				outputText("A tremendous load of semen backs up in your shaft, fighting to escape your tight urethra as it swells ever upward toward its final destination.  Her neck bulges as the thick cream works its way down her convulsing gullet, and she lurches forward in surprise as the first streams flood her stomach to the brim almost instantly.  Her lips tighten around your shaft, and she does her level best to swallow every last drop, but the powerful squeezing of her throat muscles simply can't compete with the awesome pressure of your virility.  Her pudgy stomach balloons to an obscene size in mere moments while her tongue desperately darts around the edges of your cock to try to catch the thick streams escaping from the corners of her mouth.  Twin jets of cum erupt from her nostrils, spurting against your groin and splashing back into her face, while vast amounts of seed spill from her lips and splatter down her chin, coating her chest and bloated abdomen.  In spite of the biblical flood of semen gushing into her, she diligently attempts to keep as much of it down as possible, swallowing load after load as her belly continues to jiggle outward, sloshing with the weight of your cum.  Her cheeks periodically puff up with backed-up seed before she forces herself to swallow again, now seemingly on autopilot - her green eyes are vacant and glazed over, crossed and rolled back in an expression of sheer, mind-breaking pleasure.\n\n");
				outputText("Her throat muscles tighten around your shaft as you pull back, squeezing the last few streams of cum from your urethra, and a loud 'smack' echoes through the forest when you pull away.  Her plump lips purse together, both cheeks bulging with the last remnants of your virile expulsion.  They quiver momentarily, and then she lowers her head shamefully, a copious outpouring of milky white draining into her upturned palms.\n\n");
				outputText("She cups her hands in a vain attempt to preserve it all, but there is simply too much, and a fair amount of it ends up splattering to the ground loudly.  Before she can lose any more, she dips her head down and begins to lick and lap at her palms, greedily sucking down the dregs while bemoaning the loss of those last few drops.\n\n");
				outputText("When she looks up at you, her chin and cheeks are smeared with a thick layer of cum, but her eyes are sparkling with what could only be described as pure, unabashed reverence.\n\n");
				outputText("\"<i>I...  I've never...  I've never had a mortal...  f-fill me up like that before...  Come back an'...  and fuck my throat again...  please?</i>\"");
			}
			outputText("\n\nSighing in satisfaction, you step back from the tree to catch your breath." + ((player.cumQ() > 1000) ? "  The kitsune leans back, cradling her full stomach with a blissful smile on her face and a few strings of cum-laced spittle dripping down her chin, a small puddle of juices spreading between her knees.  How she can look so happy after a brutal facefucking like the one you just gave her is beyond you, but by the look of things she's quite content with the results." : "  The kitsune leans back, laying a hand on her stomach and rubbing it lightly.  An audible gurgle reaches your ears, and she sighs bemusedly, shaking her head.") + "  Either way, it doesn't look like the exhausted girl is going to be getting up soon, so you gather your things and head back to camp.");
			//Advance time 1hr and return to camp. +Sensitivity, +Libido
			player.orgasm();
			dynStats("lib", 1, "sen", 1);
			combat.cleanupAfterCombat();
		}

//[GetLicked] - requires a vagina
		private function getLickedByKitsunes():void
		{
			clearOutput();
			kitsuneSprite();
			outputText("Wary of further trickery, you slowly make your way forward, keeping your eyes trained on her in case she decides to pull a fast one.  You must be in luck, as she only backs herself into a tree, crying out and wincing as the back of her skull hits bark with a sickening thump.  As she rubs the tender spot on the back of her head, your eyes wander across her form, an aching need building up in your feminine nethers.  As you drop low to face her eye to eye, you lift her chin gently and lean forward to kiss her, moaning lightly as her pillowy soft pink lips part to accept your tongue.\n\n");

			outputText("One hand caressing the back of her head, you lean into the kiss and slide your body passionately against hers, your " + player.nippleDescript(0) + " growing hard with arousal.  As your tongue dances around hers, you rub yourself against her thigh, spreading musky juices across it.  Your hands slide up and down her face and chest, fingertips cascading over every curve, and finally you break your kiss, a line of saliva connecting your bottom lip to hers.\n\n");

			outputText("As you stare at the shiny pink pillows, you gently brush your thumb along them, marvelling at how absolutely soft and plump they are.  It isn't long before you begin to wonder how they might feel kissing elsewhere on your body, and you decide to indulge your curiosity, pulling your " + player.armorName + " away to reveal your " + player.vaginaDescript() + ".  She licks her lips almost imperceptibly at the sight of your slick slit, her hungry gaze coming to rest between your legs.\n\n");

			outputText("She barely requires any coercion to lower her head " + ((player.isBiped() ) ? "between your legs" : "into your crotch" ) + " as you lie back on the grass.  You rest your hands on the back of her head, merely as a formality, as she dives into your slippery snatch with unabashed zeal.  You are unable to hold back your moans as her plump lips gently wrap around your [clit], the very tip of her tongue flicking across it lightly.  She hooks her thumbs into your lower lips and gently spreads them apart, swirling her tongue across the inner surface of your labia as she works her way downward.  Her plump lips part into a pink O as her tongue slides out for what seems like an eternity, twisting and writhing like an obscene tendril.  The tip circles the fleshy ring guarding your entrance teasingly, as though trying to coax it to open up for her.\n\n");

			outputText("Though her mouth is buried deep in your folds, you can tell she is smiling as she stares up at you.  Mischief sparkles in her green eyes as her tongue continues to tantalize you, never quite getting around to plunging into your waiting folds.  Two can play at that game, however, and you retaliate against her teasing by pressing your fingertips into the back of her head and thrusting your hips forward, forcing her down into your quivering cunt.\n\n");

			outputText("Your eyes roll back as she gets the hint - you are not to be toyed with - and she plumbs your depths with her wriggling tongue, the limber organ sliding deep inside you and rolling along your sensitive insides.  The tip curls against the ceiling of your inner chambers, prodding the sensitive flesh gently and sending shudders up your spine.  Her eyelids droop as she sinks lower, gentle moans vibrating up through your convulsing walls, her wriggling tongue exploring the recesses of your insides and prodding areas that you weren't fully aware existed.\n\n");

			outputText("Your hands tremble as you hug her tight against your groin, arching your back in ecstasy and moaning into the air.  The skillful ministrations of her tongue bring you pleasure like no other, twisting this way and that inside your " + player.vaginaDescript() + " like a wriggling snake.  She wields her tongue with intent but control, each stroke of her saliva-slathered slit-teaser sending you further into the throes of passion.  Shaking feverishly, you stroke the edges of her ears, eliciting deep moans from her that travel up through your walls, vibrating through you as you echo her sentiments loudly.\n\n");

			outputText("Just as you feel you are on the verge of climax, there is a lull in her tender assault, her tongue withdrawing slowly as you are dragged back from the brink, only too aware of how close you were.  Before you can chastise her for her insolence, you are silenced by an incredible shock of pleasure.  Just before your senses explode in a sea of synesthetic color and sound, you see the mischievous girl squeezing your [clit] between her thumb and forefinger, swirling azure flames dancing around her fingertips.  The intense tingling is both hot and cold at the same time, ebbing and flowing with an odd rhythm that sends you thrashing in pleasure at regular intervals.\n\n");

			outputText("Wreathed in the same flames, her tongue darts down to part your lips once more, carrying azure sparks deep into your " + player.vaginaDescript() + " and probing your depths curiously.  Your hands find their way to the back of her head once more, fingers intertwined with her shiny black hair, holding her down against your groin with all your strength.  Each upward thrust of your hips drives her writhing tongue deep into your quivering cunt, the flaming tip prodding your cervix and sending shivers up your spine.  Her plush pink lips caress your labia, gently squeezing and nibbling as she throws herself fully into the task of pleasuring you.\n\n");

			outputText("Your whole body shakes from top to bottom as you are quickly driven back to the precipice, the magically enhanced ministrations of her tongue giving you no quarter as she assaults your nethers with an almost hungry fervor.  Your muscles clamp tightly around her tongue as a rush of fluid comes spilling out into the kitsune's mouth, drenching her chin with your musky feminine juices.  You pull her inward with every last ounce of strength you possess, moaning obscenely, then repeat the action for a second and third time.  On the third moan, your ecstatic scream echoes through the forest, sending birds flocking to the sky as your orgasm tears through your body in a tidal wave of shivers.\n\n");

			outputText("Her tongue continues to wriggle against your quivering walls throughout the duration of your thrashing climax, hungrily funneling every drop that comes rushing out into her mouth." + ((player.vaginas[0].vaginalWetness == VAGINA_WETNESS_SLAVERING) ? "  Streams of girlcum spray from your slavering cunt, soaking her face in the moments before she opens her mouth wide, eagerly swallowing all that she can." : "" ) + "  After what feels like an eternity, your orgasm begins to wane, the shivering pulses of pleasure ebbing away and your mind slowly clearing.  Panting heavily, you loosen your death grip on her head, letting her pull back to catch her breath as you collapse on your back to do the same.\n\n");

			outputText("She licks her lips in satisfaction, then wipes her mouth on her sleeve, sighing happily before slumping back to rest against the side of a tree.  You lie splayed out on the ground in ecstasy for several minutes before finally summoning up the strength to stand, and when you do so, a cursory glance around suggests that the wily kitsune has made her getaway.  As you gather your things and prepare to head back to camp, you can almost hear the faint echo of a mischievous giggle filtering through the forest.");
			player.orgasm();
			dynStats("lib", 1, "sen", 1);
			combat.cleanupAfterCombat();
		}

//Redhead-exclusive
//[Ride] - requires vagina
		private function rideDatRedheadKitsuneCockIntoTheSkyDiamonds():void
		{
			clearOutput();
			kitsuneSprite();
			outputText("You watch the downed kitsune closely, strafing around her as you close in.  One never can be too careful, and you certainly have reason to suspect that this may just be another trick.  Thankfully, it appears the clever seductress' trickery has run its course.");

			outputText("\n\nCarefully " + (( player.isBiped() || player.isTaur() ) ? "extending a " + player.foot() : "reaching down") + ", you push her thigh aside, spreading her legs to take a gander at what she's been hiding beneath her robes.  You flip the silken garb upward, freeing her foot long member from its lavish confines.  It bobs up to meet your gaze, throbbing from base to tip with a playfully libidinous twitch.\n\n");

			outputText("She flashes you a grin as you begin to trail your fingers along the pulsating rod, a mixture of pride and excitement burning in her fiery emerald eyes.\n\n");

			outputText("\"<i>Heheh, you like?</i>\"\n\n");

			outputText("You give it a tight squeeze in reply, and her coy commentary immediately resolves into a moan, her legs splaying out by themselves as she relinquishes access to her mismatched genetalia.  Her teasing demeanor melts a bit as you give her a taste of her own medicine, stroking her shaft at a slow and methodical pace.  It takes but a light push on her forehead to send her sprawling back onto the ground, where she lies smirking contentedly with her head resting on her hands.\n\n");

			outputText("You casually discard your " + player.armorName + ", tossing them aside in a pile.  By this point, she is putty in your hands, her whole body shaking from head to toe with each teasing stroke of your palms.\n\n");

			outputText("\"<i>Oo-oh...  You certainly know how to treat a girl...</i>\" she coos, chewing on the first knuckle of her forefinger with the tip of her oversized canine.\n\n");

			outputText("With a smirk, you run one finger down the length of her shaft, tickling it teasingly.  Your fingertip slides sensually across the underside, parting the soft pink flesh of her luscious lips.  A shudder runs up her spine as you circle ever closer toward her slippery hole, finally plunging your first two fingers in up to the knuckles with a single thrust.\n\n");

			outputText("Her warm canal constricts around your invasive digits almost immediately, her back arching high and a loud groan filling the air, drowning out the sweet squelch of her soaking hole squeezing around your fingertips.  You pump your fingers in and out a few times, your other hand caressing her throbbing member slowly, gathering dollops of pre from the tip and spreading them down the shaft.\n\n");

			outputText("You move yourself into position, lowering yourself down over her hips with your hands resting on her knees for support.  As the head of her cock kisses the opening of your " + player.vaginaDescript() + ", a cool tingle begins to spread from your loins, shivering its way up your spine.  Playfully, you rock your hips forward and back, teasing the tip of her member with the sensual caress of your warm cleft.  A thin trickle of lubricant slides down her sensitive shaft, making her shudder with delight.  You slow your movements to a crawl, almost to the point of standing still, " + ((player.vaginas[0].vaginalLooseness > VAGINA_LOOSENESS_LOOSE) ? "then with a sudden lurch forward, you drop yourself onto her throbbing rod, driving it to the hilt in one pass.  A smoldering tingle ebbs and flows through your loins, strongest at the tip of her throbbing cock." : "slowly allowing it inside.  Easing yourself down, you groan eagerly as the girthy rod stretches your " + player.vaginaDescript() + ".  At long last, your hips connect with hers, and you take a deep breath and pause for a moment as a smoldering tingle radiates through your loins."));
			player.cuntChange(12, true, true, false);
			outputText("\n\n");

			outputText("Your hips rise and fall slowly, rolling back and forth while your inner muscles squeeze and massage her pulsating member, teasing her with every ounce of skill you can muster.  It seems as though the teasing trickster enjoys getting a taste of her own medicine - her chest trembles with a deep groan, both hands dragging slowly down her chest in an unrestrained display of ecstasy.  Taking her by the wrists, you hold her arms back on either side of her head, bearing down on her with your [hips] to keep her pinned to the ground.  Her curvaceous hips swivel and squirm underneath you, seeking purchase wherever it can be found for just the tiniest bit of movement.  You ask her how she likes getting a taste of her own medicine, laughing derisively at her struggles and running your fingertip in a circle on her forehead.  She breaks from her raucous moan long enough to purse her lips cheekily, her green eyes glaring at you with a wry frustration.  All of your teasing certainly didn't diminish that fiery spirit, though it is now obfuscated by a layer of fervent lust that shudders through her core with your every touch.\n\n");

			outputText("Her cock swells within you, sending a pulse of tingling coolness rippling up your torso.  You shiver, " + ((player.biggestTitSize() > 3) ? "your [fullChest] jiggling from side to side, " : "" ) + "unable to prevent a moan from escaping your throat.  In retaliation, you rise up and drop your [hips] against hers a tad harder than previously, using your pelvic muscles to squeeze her cock forcefully.  Again and again you thrust her wide hips against the ground, knocking the wind out of her sails and reducing her once more to a quivering heap.  Six crimson tails thrash wildly beneath her, curling toward your body instinctively as they seek to wrap about whatever they can reach.  The silky coils slither across your " + player.skin() + " as well as her own, sparks crackling in their wake and bringing the two of you to the heights of pleasure.\n\n");

			outputText("The sounds of your pelvises mashing together fills the forest, lewd slapping noises echoing through the trees.  Her engorged dick pulses against your walls, twitching almost constantly as her climax builds toward a marvelous conclusion.  You are close to your limit as well, your vaginal muscles clenching down freely as you ride her throbbing rod with a determined zeal, prepared to milk it of all she has to offer.  The first stream of sticky jism hits your womb like a jolt of ice, making you grimace with surprised pleasure as it resolves into a warm tingle that spreads calm through your convulsing nethers.  Your muscles ripple against her shaft, drawing her load upward and into your waiting womb.  Her output is quite prodigious to say the least, ribbon after ribbon of roiling, foaming cum spurting up into your uterus with an audible sloshing sound.  Your belly jiggles and swells, slowly filling with her tingling seed as it expands to the size of a watermelon, thick cum gushing from your gash" + ((player.wetness() == 5) ? " while a viscous spray of femcum soaks her front" : "") + ".\n\n");

			outputText("Her rapid, panting breath slows as her climax begins to wane, two of her tails wrapping almost protectively around your cum-swollen belly.  With one hand resting on top of it, you clumsily shift your weight to dismount from the spent kitsune, sighing with relief as a veritable river of seed begins to rush from your " + player.vaginaDescript() + ", spilling out over the kitsune's front.  Her spent rod hangs limply over one thigh, still twitching ever so slightly.\n\n");

			outputText("Once her colossal load has finished draining out - primarily onto her - you clean up and begin to dress yourself once more.  Your attention is drawn by the sound of rustling leaves, and when you turn to look, a sextet of red tails disappears into the bushes, followed shortly after by a playfully waving hand.");
			//Advance time 1hr and return to camp. +Sensitivity, +Libido
			player.orgasm();
			dynStats("lib", 1, "sen", 1);
			player.slimeFeed();
			combat.cleanupAfterCombat();
		}

//[Helix] - requires herm
//REDHEAD KITSUNE
		private function helixZeKitsunes():void
		{
			clearOutput();
			kitsuneSprite();
			outputText("You eye the sulking kitsune warily, wondering if this is just another one of her tricks, but as you edge closer to her, it seems she's resigned herself to her fate.  She stares up at you with a half-defiant pout, arms crossed over her chest, but makes no attempt to resist you other than to let out a startled \"<i>Eep!</i>\"  when you grab her by the shoulders and toss her onto her hands and knees.\n\n");

			outputText("Well, at least she knows when she's been beat.  Your hands shake with excitement as you undo the sash tying her robes together, whipping her clothes off in a flash before stripping naked yourself.  Her shimmering crimson tails raise up instinctively, wafting from side to side in the breeze as she lowers her shoulders toward the ground submissively, raising her rear end up high.\n\n");

			outputText("\"<i>Well, come now, are you just gonna stare, dear?</i>\"  she says, propping chin up on her hands and smirking at you coyly.  Even in a totally submissive state, they really do never miss a chance to tease you, do they?\n\n");

			outputText("Her ass jiggles deliciously with every minute motion, prominently displaying a large tattoo shaped like a five-pointed star on the right cheek.  You lick your lips lecherously, reaching out to stroke and fondle the fleshy globes slowly.  One of her tails passes in front of your face, prompting you to reach out and stroke your fingers through the soft, silky fur.\n\n");

			outputText("\"<i>Aah!~</i>\"  the kitsune moans, her face quickly turning the same shade of red as her flaming locks, green eyes rolling up into her skull.  \"<i>O-oh, that's the spot...</i>\"\n\n");

			outputText("Smirking, you run your fingers across the robust curves of her ass one last time, then raise your hand, bringing it down in a hearty slap.  She yelps and bucks forward instinctively, the smack sending ripples through the jiggling flesh of her expansive ass.  Sliding down further, you cup your fingers beneath her groin, feeling the heat radiating off her dripping pussy as a few droplets of feminine slick roll down her slit.  The clear bead slowly follows the curvature of her pubic mound, then abruptly begins to roll down the long, throbbing shaft of the redheaded girl's cock, joining with a steady dribble of precum as it pools beneath her.\n\n");

			outputText("You wrap your fist firmly around the base of her rod, the other hand threading between her many tails and stroking through the sensitive fur near the small of her back.  Moving them in tandem, you begin to milk her cock slowly and sensually, at the same time dragging your hand across her tails in long, slow strokes.\n\n");

			outputText("The kitsune utters a barely audible whine, biting her bottom lip as the blush across her cheeks deepens considerably.  It seems she's trying not to show how much she enjoys this treatment!  Well, you can't have any of that, can you?  You squeeze her throbbing rod a bit harder, twisting your wrist very slightly as you pump it up and down.  That does it - unable to hold it in any longer, she releases a low, husky moan and gives in to her baser instincts, humping downward into your fist and flexing her thighs excitedly.\n\n");

			outputText("Satisfied with the results of your teasing, you shift your position, grabbing her hips and sliding your [cock biggest] up between her mountainous ass cheeks.  Her tails coil down automatically to begin caressing your shaft, wrapping around the " + ((player.hasSheath()) ? "sheath" : "base" ) + " and constricting lightly as you slide back and forth.  You pull back and shift your member downward, sliding across the moistened outer cleft of her cunt and running your shaft along underneath her own.  Sliding your hips forward and back a few times, you coat yourself in her slick fluids before finally angling yourself up against her quivering lips, pressing the [cockHead biggest] forward to part them gently.  The muscles contract, gently squeezing and suckling on the tip of your rod as though actively trying to draw it further inside.\n\n");

			outputText("Holding her wide, voluptuous hips with both hands, you start to lean your weight forward, slowly sinking yourself into her drooling snatch.  The first inch forces a low groan from her throat that doesn't stop until your hips buffet her prodigious derriere, buried to the hilt inside the warm, tight sleeve of her pussy." + ((player.biggestCockArea() > 50) ? "  Amazingly, you managed to fit the whole thing inside without much trouble.  In spite of the confusing implications, you press onward, rather than look a gift horse in the mouth." : "") + "\n\n");

			outputText("Carefully, you lift her rear end up, contorting her body forward into a bent L shape as you stand.  She groans and squeezes your waist with her thighs, hooking her legs and tails around your back and spreading her arms out for stability.  If nothing else, she has an impressive amount of flexibility.\n\n");

			outputText("Reaching down," + ((player.balls > 0) ? " you lift your " + player.ballsDescriptLight() + " out of the way and reach around her underside," : "you reach around her underside,") + " taking hold of her thick prick and bending it gently toward your " + player.vaginaDescript() + ".  She catches your intention easily enough and slides a tail down to assist, curling the bushy coil around her thick member and guiding it toward your waiting snatch.  It takes a bit of finagling, but a moment or two later, she is moaning in pleasure as the head begins to penetrate you.");
			player.cuntChange(12, true, true, false);
			outputText("\n\n");

			outputText("Shivering from head to toe, you place your hands on the quivering globes of her ass, letting your fingers sink deep into the soft flesh.  Slowly, carefully, you begin thrusting your hips forward and back, going slowly due to the somewhat awkward positioning involved.  Her rippling cunt squeezes your cock hungrily, and yours returns in kind, tightening around her member each time you draw back and squelching audibly when you thrust forward again.\n\n");

			outputText("\"<i>Ooooh, yes, fuck yes!</i>\"  she wails lewdly, thrusting her hips up to meet yours time and time again.\n\n");

			outputText("Your fingers dig into the plump flesh of her rear, gripping it tightly as you mash your pelvis against hers.  Loud, wet sucking sounds echo through the forest with each thrust of your [cock biggest].  Her own stiff rod swells and throbs inside you each time you drive into her sopping cunt, threads of sticky fem-juice slinging up against your stomach as you increase the pace of your furious pounding.\n\n");

			outputText("The way her slavering pussy grips your member each time you pull back is enough to drive you mad with lust, strong muscles squeezing and pulsing across your shaft and sucking it back inward powerfully.  Your own inner muscles do their part to reciprocate, tightening around her throbbing member as it begins to swell in preparation for what promises to be a tremendous orgasm.\n\n");

			outputText("Mashing your hips into hers a few more times, you join her in an animalistic chorus of moans as you both edge ever closer to release.  You can feel her heartbeat throbbing through her engorged prick, pounding out a passionate rhythm with your own as the combined heat of your groins rises to an ever greater peak, pleasure and lust building up until boiling over with a cacophony of moans and shivers.\n\n");

			if (player.cumQ() <= 150) {
				outputText("Though you put up an admirable play of it, your sticky emissions simply can't compete with the incredible volume that the redhead's orgasm produces.  As your sticky streams paint her walls a pearly white, she continues to pump your womb full of her tingling, bubbling seed.  Each twitch that spews another thick ribbon of kitsune-cum into your rapidly expanding belly is accompanied by a milking squeeze from her muscular walls, pulling out every drop you have to give.  Before long, you look heavily pregnant, your jiggling, cum-swollen stomach hanging heavily over her well-cushioned ass.");
			}
			else if (player.cumQ() <= 350) {
				outputText("You spurt ribbon after ribbon of thick semen into her hungry pussy, streaking her walls with pearly white, but even your prolific load can't compare to hers.  Her cock swells and throbs, pressing hotly against the walls of your vagina as it spurts load after creamy load of thick, bubbling semen into your womb.  Each spasm of her cock is matched by a powerful suckling from her vagina, milking you dry and pumping you full simultaneously.  As her wildly throbbing shaft finally settles down, your belly jiggles with the addition of the final stream of seed, hanging low and heavy over her cushiony ass.");
			}
			else if (player.cumQ() <= 1000) {
				outputText("You grunt and groan as your [cock biggest] throbs and twitches in her pussy, swelling with seed as it spurts out thick ribbons of cum deep into her womb.  You pour thick rivers of seed into her slavering cunt, matching her prodigious output stream for stream.  As your orgasm begins to slow, she continues to pump your womb full of her hot futa-jizz, moaning all the while.  Her abdomen bloats noticeably from your cum, sloshing and jiggling a bit, but when hers has stopped expanding, yours continues, swelling out into an obscenely rounded belly.");
			}
			else if (player.cumQ() <= 2500) {
				outputText("Together, you fill each other with obscene amounts of seed, matching each other stream for stream as your cocks swell in tandem.  Rivers of semen flow down into the kitsune's waiting womb, filling it to bursting with your virile jizz while she returns it in kind, both of your abdomens slowly expanding from the pressure.  Incredible amounts of seed are traded in the exchange, until you sport matching bellies that slosh with the weight of each other's prodigious loads.");
			}
			else {
				outputText("Her climax, though impressive, is utterly overshadowed by your own in both intensity and virility as your [cock biggest] swells with the volume of your cum, pouring thick rivers of seed down into her hungry womb.  Muscular walls squeeze and milk your shaft with all their might, musky streams of femcum mixed with your thick jizz spurting out around the lips and painting streaks across your lower abdomen.  Your womb froths and bubbles with the warmth of her thick cum, swelling outward as she pumps you full of an impressive load in her own right.  The pair of you are soon sporting matching bellies that jiggle and slosh heavily with each other's cum, though hers continues to expand for some time thanks to your prodigious production.  Eventually she can hold in no more, and the excess erupts from around your cock in pressurized streams, splashing against the underside of your cum-swollen stomach.");
			}

			outputText("\n\nOnce suitably recovered from her intense orgasm" + ((player.cumQ() > 1000) ? " and filling" : "" ) + ", she takes the time to crane her neck so that she can smirk back at you, a satisfied but coy grin plastered on her face.  Her tails softly spread out across your swollen abdomen, stroking it gently and drawing tiny circles across the sensitive, stretched flesh with her magical flames.  The magical fire tingles across your " + player.skinFurScales() + ", nearly causing you to drop her as you shiver, lowering her to the ground gingerly.\n\n");

			outputText("As your cocks pass each other on the dismount, they are followed by thick, musky-smelling fountains of cum that pour from your uncorked vaginas, spilling onto the ground in a large, homogenous puddle.  The kitsune rolls onto her back in exhaustion, her spent cock hanging limply over one thigh" + ((player.cumQ() > 1000) ? " as her swollen abdomen slowly drains onto the forest floor" : "") + ".\n\n");

			outputText("You turn to gather your " + player.armorName + ", cleaning up and dressing once more, then whip around to the sound of rustling leaves.  A set of sticky footprints leads your gaze to the edge of a bush, a flash of red tails and a pair of plump hind cheeks disappearing into the forest.");
			//Advance time 1hr and return to camp. +Sensitivity, +Libido
			player.orgasm();
			dynStats("lib", 1, "sen", 1);
			combat.cleanupAfterCombat();
		}

//[Remove Dick]
//AKA Lose the dick, schweethaat AKA put that thing away
		private function redheadsDontDeserveToHavePenisesBecauseTheyreTooGayForPenisOrSomethingIDontReallyKnowHowThisWorksOrWhyThisFunctionNameIsSoFuckingLong():void
		{
			clearOutput();
			kitsuneSprite();
			outputText("You squint slightly, leering at the bulge between the kitsune's legs with a slight frown.  Your gaze travels up and down her voluptuous form, eying the girl's lovely curves carefully.  It's decided - if you're going to be having fun with her, that thing has got to go.\n\n");

			outputText(((silly()) ? "\"<i>Not liking dicks, what are you, gay?</i>\"  the kitsune teases in a perfect deadpan." : "\"<i>Oh, how boring,</i>\" she mutters disappointedly, her lower lip quivering in a mocking pout.") + "\n\n");

			outputText("You grumble in exasperation and jab your finger toward her groin, then thumb the air over your shoulder with an insistent whistle.\n\n");

			outputText("Rolling her eyes, she hesitantly complies, a wreath of flame engulfing her mismatched genitals with the crackling snap of a flint being struck.  When the azure blaze dissipates, her foot long cock has regressed into a pert cherry-colored nub.\n\n");

			outputText("\"<i>Fine, you beat me.  Fair's fair...");
			if (silly()) outputText(" you monster.");
			outputText("</i>\"\n\n");

			outputText("<b>What will you do with her now?</b>");
			// Set flag (redheadIsFuta = false)
			flags[kFLAGS.redheadIsFuta] = 0;
			// Display shared scenes + nonfuta options
			//kitsune sex
			defeatTheKitsunes(false);
		}

//[Bring Back Dick] // AKA you don't know dick about dick AKA the dickening
		private function bringBackDick():void
		{
			clearOutput();
			kitsuneSprite();
			outputText("You look her over contemplatively, rubbing your chin in thought as you stare at her crotch.  Somehow, it seems...  empty.  Something is missing.\n\n");

			outputText("The redhead's eyes light up as you tell her you'd like her to regrow her cock, and she eagerly obeys, grinning with delight.  Sparks fly from between her outspread legs, a column of blue flame erupting around her clitoris.  She groans with a pained pleasure, the azure tongues beginning to resolve into a vaguely phallic shape.\n\n");

			outputText("As the last wisps of flame curl off into the air and disappear, her cock solidifies, standing proud and erect with a thin trickle of precum already dribbling down the shaft.\n\n");

			outputText("\"<i>Mn...  About time you decided to walk on the wild side,</i>\" she teases, smirking at you coyly.");
			// Set flag (redheadIsFuta = true)
			flags[kFLAGS.redheadIsFuta] = 1;
			// Display shared scenes + futa options
			defeatTheKitsunes(false);
		}

//Non-Futa Redhead: [Some sort of lapsitting handjob thing, I don't know]
		private function nonFutaRedHeadIsWorstRedheadLapsittingHandjobThingIDontKnow():void
		{
			clearOutput();
			kitsuneSprite();
			outputText("The beaten girl makes no effort to resist or even to escape as you close in on her.  She watches you carefully as you approach, having lost much of the fire in her glistening green eyes and replaced it with a reverent submissiveness.  Her ears droop to the sides when you reach out to stroke the top of her head, and she lowers her cheek against your hip, a light pink blush spreading across her face.\n\n");

			outputText("A bushy crimson tail gently brushes against your wrist, curling around it lightly, and her hand hesitantly slides up to your crotch, stroking it softly.  She looks up at you questioningly, as though asking for permission, and you nod lightly in approval, gesturing for her to continue.\n\n");

			outputText("She hooks her fingers into your " + player.armorName + " and slowly pulls them away, exposing [eachCock].  " + ((player.balls > 0) ? "She gently cradles your " + player.sackDescript() + " in one palm, " : ((player.gender == 3) ? "She gently cups one hand over your " + player.vaginaDescript() + " and lightly inserts her middle finger, " : "She gently cups the underside of your groin, ") ) + "wrapping her other hand around your [cock biggest] and beginning to stroke it slowly.\n\n");

			outputText("She gently presses her face into your groin, draping [eachCock] over her face and peering up at you " + ((player.cocks.length > 1) ? "between them" : "around it" ) + ".  Gentle kisses and caresses trail up your [cock biggest] as she squeezes your rod against her forehead, her slender fingers stroking up and down the length.  She releases a quiet whimper when you rest your hand against the back of her head, pulling her tight against your crotch while your fingers slide through her hair.  The whimper turns into a whine of pleasure when your other hand begins to stroke the inner edge of her ear, an involuntary shiver running down her spine.\n\n");

			outputText("As the girl practically melts under your touch, you slowly pull away, lowering yourself to the ground and drawing her into your lap.  Pulling her back against your [fullChest], you wrap both arms around her, settling her down just above the base of [eachCock].  Her thighs gently close around " + ((player.cocks.length > 1) ? "them" : "it" ) + ", squeezing " + ((player.cocks.length > 1) ? "them" : "it" ) + " tightly as she relaxes submissively into your arms.  You guide her hand down to your [cock biggest], and she immediately takes to stroking it, leaning back to rub her head into your hand pleadingly.\n\n");

			outputText("The sash around her waist falls away as you tug on the knot, reaching around to slide your fingers down the front of her robes and pull them open.  Her bare breasts bounce free, and she puffs her chest out a bit in a bid to get you to squeeze them.  Nearly every muscle in her body goes slack when you begin to grope and tease the supple mounds, her arm still gently pumping up and down your shaft on autopilot.  It takes only the slightest bit of teasing to coax her nipples to fill out into rigid, sensitive nubs, and by that point she is putty in your hands.\n\n");

			outputText("Her jaw hangs slack, each shuddering breath making her breast quiver in your hands as she stares off into space with a half-lidded gaze.  Her six tails have nearly ceased moving altogether, limply curled around you, only giving the slightest twitch every now and again when you pinch her tender nipples or drag a finger sensually across her bare flesh.  Each time your sensual teasing overcomes her, you back off, only rewarding her by resuming when she comes to her senses and continues to stroke your cock - she mustn't forget who is in charge, after all.\n\n");

			outputText("She's nothing if not obedient, though her technique seems to be somewhat slurred by your teasing.  Changing up your approach, you slide one hand down to her hip while the other moves up to her face, cradling her head gently and tilting it to one side, exposing her neck.  You firmly bury your fingertips in the quivering flesh of her ass, groping and squeezing it lustfully, then lean forward to press your lips to her shoulder, running your tongue sensually along her smooth skin.\n\n");

			outputText("She pitches forward and cries out in surprise, tensing up and trembling with pleasure, her mouth hanging agape in a silent moan.  Her limp tails spring to life, lashing themselves around your limbs desperately, and her trembling hands begin to stroke your rigid rod with a renewed vigor.  You press your teeth into her flesh gently, and her hips jerk forward in response, spurring her on to begin grinding her now slavering pussy against your shaft.  Her legs spread out, and she plants her feet on the ground for leverage, sinking back against your chest as she gives herself over completely to pleasure.\n\n");

			outputText("Your hips are soon drenched with her copious amounts of pussy juices, but the slick fluids only amplify the sensations of her vigorous stroking.  Her hands travel down to the base, gathering handfuls of her own juices, then slide up to the head to mix it with your dribbling precum before spreading the musky mixture down the length of your rod." + ((player.cocks.length > 1) ? "  She is careful not to neglect your other " + ((player.cocks.length > 2) ? "members" : "member" ) + ", squeezing them together and massaging them " + ((player.cocks.length > 2) ? "all" : "both") + " eagerly." : "") + "  Her breathing has become labored and erratic, and it seems like all it would take is one little push to put her over the edge.\n\n");

			outputText("\"<i>I'm gonna...  g-gonna...</i>\"  she manages to stutter between panting and thrashing in your arms.  You cut her off before she can finish by gently biting down on her ear, and mutter through clenched teeth that she's forbidden to cum before you.\n\n");

			outputText("She shudders in response to your declaration, her eyes rolling back as she visibly devotes every ounce of her willpower toward obeying your command.  It's clear that she won't be able to hold out much longer, however, and she seems to be painfully aware of it, desperately redoubling her efforts to grant you release so that you will permit hers.\n\n");

			outputText("It may just pay off for her, as you feel the tension of a climax beginning to build in your groin, [eachCock] swelling in preparation.  Sensing your impending orgasm, she begins to stroke more furiously than ever, her arm turning into a flesh-colored blur.  It's hard to tell who cums first, semen and femcum flying through the air in equal measure as she soaks your lower body with her orgasmic spray, a fountain of seed splattering up onto her stomach.  ");

			if (player.cumQ() <= 150) {
				outputText("Sticky threads of semen splatter against her front as she continues to rapidly pump her hands up and down your spasming length, slinging hot seed around randomly.  The vast majority of it lands on her abdomen, smearing her with a sticky web of cum, while the rest paints the forest floor.  By the end of it, she is panting in exhaustion, lying limply in your arms while she slowly lifts her cum-covered hand to her mouth, carefully cleaning it off with her tongue.\n\n");
			}
			else if ((player.cumQ() <= 350)) {
				outputText("Hot streamers of semen splatter against her as she continues to rapidly pump her hands up and down your spasming length, causing your copious ejaculate to sling through the air randomly.  Much of it lands on her stomach, a few errant streams smearing on her breasts, while the rest of it paints the forest floor white.  Thick beads of sperm roll down her chest as she lies back in exhaustion, her tired arms going limp.  She weakly lifts them to her mouth and licks them clean, carefully lapping up every drop, then settles down, breathing heavily.\n\n");
			}
			else if ((player.cumQ() <= 1000)) {
				outputText("Thick streamers of semen splatter up against her chest as she continues to rapidly pump her hands up and down your spasming length, flinging your incredible load every which way.  She winces a bit as a few errant streams land across her face, the vast majority of it splattering into her chest and stomach.  Her entire front is smeared with a thick matting of your seed, glossy pearls of semen dripping off her cheeks, onto her chest and down her stomach.  Lying back against you in exhaustion, she limply lifts her hands to her lips, carefully cleaning them off with her tongue.  Sighing contentedly, she looks up at you one last time as though seeking your approval, the remnants of your climax still evident on her face.\n\n");
			}
			else if ((player.cumQ() <= 2500)) {
				outputText("Hot ribbons of semen splatter onto her chest, rushing up against her breasts and splashing into her face as she continues to rapidly pump her hands up and down your spasming length, flinging your monstrous ejaculations into the air in every direction.  She clamps her eyes shut as your seed cascades across her face, smearing her cheeks with glossy white streaks that dribble down her chin and slough onto her chest and stomach loudly.  Her hands continue to work your length until the last drops of cum roll down the shaft and onto her hands, and she at last relaxes against you in exhaustion, panting heavily.  She lifts her arms up weakly, cleaning her hands off with her tongue, but leaves the thick matting of cum on her face untouched, looking up at you with a contented smile.\n\n");
			}
			else {
				outputText("Thick jets of semen crash against her chest, splattering her breasts and face with inhuman amounts of cum as she continues to rapidly pump her hands up and down your spasming length, flinging your monstrous ejaculations into the air in every direction.  She clamps her eyes shut as your seed rains down on her, smearing her entire body with a pearly mat of seed that rolls off her in sheets.  Her hands continue to work your length until she squeezes the last drops of cum from your urethra in one final thick spurt, and she at last relaxes against you in exhaustion, panting heavily.  She tries to lift her limp, tired arms up to clean them off, but fails to muster up the requisite strength, leaving the thick matting of cum untouched and looking up at you with a contented smile.\n\n");
			}

			outputText("Finally, she shuts her eyes and rests her head against your shoulder, too insensate to react to your continued stroking with more than a gentle shiver.  It's almost a shame that you need to return to camp, as you have little doubt that she would probably curl up to sleep in your lap if you gave her the chance.  You set her aside in the grass, then clean yourself off before heading back.");
			//Return to camp, advance time 1hr, +Sensitivity
			player.orgasm();
			dynStats("sen", 3);
			combat.cleanupAfterCombat();
		}

//Non-futa Redhead: [Bondage] - requires a cock with area <= 144 due to some anal
		private function nonFutaRedHeadBondageIGuessYouTieHerUpWithYourPenisThenHuh():void
		{
			clearOutput();
			kitsuneSprite();
			outputText("As you close in on your fallen prey, she seems to be quite resigned to her fate.  She makes a token attempt to flee, but the moment your hand touches one of her crimson tails, she falls flat and rolls over in submission.  You drop low over her, pinning her down by the hips as you run your fingertips up the side of her cheek, tousling her hair gently and teasing the edge of her ear.  Her ear flicks lightly, then lies flat against the sides of her head, a bright pink blush spreading across her face.\n\n");

			outputText("\"<i>Wh-what are we going to-</i>\"\n\n");

			outputText("You place a finger to her lips to silence her, and she nods obediently, tilting her head to the side and offering you her bare neck in a show of submission.  You accept her offer with a grin, leaning down to press your teeth into her smooth skin, eliciting a trembling moan from the girl.  It seems to catch in her throat for a moment, escaping alongside a quiet whimper as you pull your lips away, a thin thread of saliva connecting your mouth to her neck.\n\n");

			outputText("Utterly disarmed, she shivers beneath you as you begin to methodically strip her down, easing her arms out of her robes and sliding the silky cloth down her body into a heap by her ankles.  She twitches a little in response to the tender teasing with which you assault her naked form, rolling onto her stomach easily with just a little coaxing.\n\n");

			outputText("Your palm trails down the small of her back, gently tracing the edges of her exotic tattoos on the way toward her bundle of luxurious tails.  As your fingers brush the short fur at their base, a shudder works its way up her spine, only intensifying as you run your fingertips up along their twisting length.  You curl your palm around one and slowly stroke it, pushing it down to lie flat on her back.  Every touch and stroke brings forth the sounds of even greater pleasure, the remaining five tails writhing and twitching in the air.\n\n");

			outputText("You reach into the pile of clothes at her feet and pull out the cloth band that once held her robes closed, pulling it taut between your hands and smirking as the material snaps against itself like a whip.  Quickly and carefully, you loop the cloth around her wrists, threading her tails through it one at a time, and finally tie it off with a decorative bow, standing back to admire your work.  Surprisingly enough, she didn't resist in the slightest, and as you watch her strain against her bonds experimentally, her euphoric expression is all the more telling.  Her tails are pulled taut each time she pulls at her wrists, causing her to groan in pleasure as the sensitive coils thrash against their satin bindings.  For all her usual bluster, it would seem the boisterous redhead has a masochistic streak.\n\n");

			outputText("Curiously, you reach down and pluck one of her tails like the string of a harp, finding that it produces a lovely melody of a different sort.  Even the most minor touch elicits howls and groans of pleasure from the bound beauty, filling the air with a pleasing symphony of ecstasy.  With a mischievous smirk" + ((player.str < 50) ? " and a bit of difficulty, you " : ", you ") + ((player.str < 25) ? "drag" : "carry") + " her over to a nearby tree, locating a branch at a convenient height.  " + ((player.str < 50) ? "Grunting a bit, you" : "You" ) + " hoist her up and hang her from the branch, listening to the limb creak for a bit as you wait to see if it will break under the strain.  After a few moments it seems to hold up just fine, and to test it, you give the girl a hearty slap on the rear, listening to her titillatingly shameful cries as she swings back and forth.\n\n");

			outputText("The limb remains sturdy and steadfast, merely bouncing a bit as she shifts uncomfortably, a trail of drool dripping from her open mouth while rivulets of feminine juice drip constantly from her sodden cunt.  The quivering flesh beneath her star-shaped tattoo slowly turns to an angry red as she whimpers gently, her eyes glazed over with pleasure.  As you run your hand over the surface of her curvaceous ass, you wager that you could bounce a gem off of it" + ((silly()) ? " and decide to do just that.  Reaching into your bag, you pull out a single gemstone and flick it the center of the star that adorns her right cheek.  Just as you suspected, it bounces spryly off her shapely butt, and you catch it in the air, watching her ass jiggle quite spectacularly" : "") + ".\n\n");

			outputText("Having decided that this is quite enough foreplay, you casually strip out of your " + player.armorName + ", sliding yourself up behind her and laying [eachCock] between her quivering buttocks.  Holding her hips, you begin to rub back and forth between the mountainous cheeks, delighting at the soft groans she makes as her tails are tugged this way and that by the cloth bindings from which she hangs.  Wasting no time, you press the tip of your [cock biggest] against her slavering slit, squeezing her hips tightly as you ease yourself forward.  She gasps in pleasure as it slides past her entrance, her slick walls engulfing your shaft as you " + ((player.biggestCockArea() > 70 ) ? "astoundingly manage to" : "" ) + " slide in every inch.  You take a moment to truly savor the way her inner muscles contract and squeeze around your throbbing shaft, feeling her slippery walls rippling up and down the length sensually.  Moaning loudly, you begin to buck your hips, mashing your pelvis against her supple bottom and making it ripple with every thrust.\n\n");

			outputText("Again and again you pound her poor pussy with your [cock biggest], slapping your hips into her ass with the fervent zeal of a rutting animal.  The branch creaks and groans under the strain, but continues to hold her aloft as you brutally pummel her snatch with your throbbing rod.  In one fluid motion, you abruptly withdraw your twitching shaft from her convulsing pussy and slam forward to impale her asshole, gliding easily past her anus.  She unleashes a groan of pleasure each time you plunge forward, until you are buried up to the hilt inside her warm, tight ass.\n\n");

			outputText("You throw yourself into a bucking frenzy, pumping your hips against hers powerfully.  It takes but a few thrusts before her ass is loosened up by your frantic assault, the muscular ring of her anus desperately trying to grip your constantly moving cock but finding no purchase.  She howls with pleasure as you slam your hips forward one last time before swapping back to her slippery cunt, burying yourself up to the hilt in the humid depths of her pussy once again.\n\n");

			outputText("You settle into a rhythm, pummeling each of her holes in turn for a minute or two before swapping to the other, forcing a fresh moan from her throat with each new penetration.  The crimson blush on her face deepens steadily over the course of your abuse, and it's plain to see that she won't be able to hold out for much longer.  Luckily for her, at least, the same can be said of you, as you feel the pleasure mounting to the limits of your endurance.\n\n");

			if (player.cumQ() <= 150) {
				outputText("When you are finally pushed over the edge, you are buried " + ((player.balls > 0) ? "balls" : "hip") + "-deep inside her pussy, your mouth agape in a rumbling moan that shakes your body from top to bottom.  Ropes of virile semen sling into her womb in the moments before you pull back, laying your [cock biggest] across her expansive bottom and showering her back with your hot seed.  As if on cue, the moment the first stream lands, her pussy begins to twitch, spraying a viscous torrent of girlcum against your front.  By the time she stops thrashing, she's quite a sight, a constant trickle of clear fluids dripping down her thighs, your seed smeared across her back in a thin coat.");
			}
			else if ((player.cumQ() <= 350)) {
				outputText("When you at last go tumbling over the edge, your cock is buried " + ((player.balls > 0) ? "balls" : "hip") + "-deep in the hot confines of her pussy, a rumbling moan shaking you from head to toe.  Thick, virile ribbons of semen splatter against the insides of her womb in the moments before you pull back, laying your twitching [cock biggest] across her expansive bottom and showering her back with your hot seed.  As if on cue, the moment the first stream lands, her pussy begins to twitch, spraying a viscous torrent of girlcum against your front.  By the time she stops thrashing, she looks quite a mess, a constant trickle of clear fluids dripping down her thighs as a few thick globs of cum slop off of her back.");
			}
			else if (player.cumQ() <= 1000) {
				outputText("When you at last tumble off the precipice of pleasure, your cock is buried " + ((player.balls > 0) ? "balls" : "hip") + "-deep inside her quivering pussy, a rumbling moan shaking you from head to toe.  Thick, virile seed surges into her womb in the moments before you pull back, laying your twitching [cock biggest] across her expansive bottom and thoroughly soaking her back with your hot seed.  As if on cue, the moment the first stream lands, her pussy begins to twitch, spraying a viscous torrent of girlcum against your front.  By the time she stops thrashing, she looks quite a mess, a constant trickle of clear fluids dripping down her thighs as thick globs of cum slough off of her back.");
			}
			else if ((player.cumQ() <= 2500)) {
				outputText("When you at last tumble off the precipice of pleasure, your cock is buried " + ((player.balls > 0) ? "balls" : "hip") + "-deep inside her quivering pussy, a rumbling moan shaking you from head to toe.  Thick, virile seed surges into her womb in the moments before you pull back, temporarily distending her stomach from the impressive volume.  It comes rushing back out as you withdraw your shaft from her cum-soaked cunt, laying your twitching [cock biggest] across her expansive bottom and thoroughly plastering her back with the remainder of your hot seed.  As if on cue, the moment the first stream lands, her pussy begins to twitch, spraying a viscous torrent of girlcum against your front.  By the time she stops thrashing, she looks quite a mess, a constant trickle of clear fluids dripping down her thighs as globs of cum slough off of her back in thick sheets.");
			}
			else {
				outputText("When you at last tumble off the precipice of pleasure, your cock is buried " + ((player.balls > 0) ? "balls" : "hip") + "-deep inside her quivering pussy, a rumbling moan shaking you from head to toe.  Thick, virile seed surges into her womb powerfully in the moments before you pull back, distending her stomach from the incredible volume.  Half of it comes rushing back out as you withdraw your shaft from her cum-soaked cunt, laying your twitching [cock biggest] across her expansive bottom and thoroughly plastering her back with the remainder of your monstrous load.  As if on cue, the moment the first stream lands, her pussy begins to twitch, spraying a viscous torrent of girlcum against your front.  By the time she stops thrashing, she's quite a mess, a constant trickle of clear fluids dripping down her thighs as your cum rolls off of her back in thick sheets, splattering onto the ground in a puddle.");
			}
			outputText("\n\nShe moans in insensate bliss as she sways back and forth, dripping with your steamy seed.  Her eyes are the merest sliver of jade beneath heavy lids, her tongue hanging out lazily as she hangs in helpless pleasure from her bonds.  " + ((player.cor > 50) ? "Smirking lightly, you give the dazed kitsune a patronizing slap on the ass, eliciting a delirious groan.  She remains dangling from the lofty bough as you gather your things, turning back toward camp." : "Carefully, you pull her down from the tree, laying her on her side at its base.  You spread her robe over her naked body like a blanket, patting her on the head gently as she drifts to sleep, then turn to make your way back to camp." ));
			//advance time 1hr and return to camp, +Sensitivity, +Libido
			player.orgasm();
			dynStats("lib", 1, "sen", 1);
			combat.cleanupAfterCombat();
		}

		/*Use whichever enhancement scene(s) you feel like.
		 [Lumi Enhance]

		 outputText( "Lumi snatches the jewel from your hand, staring wide-eyed into the fathoms of its depths.  She remains like that for several moments before you clear her throat, and then hurries off to work.  Flitting back and forth between the various beakers and test tubes that litter the workshop, she mixes chemicals seemingly at random, many of which bubble or explode rather violently.\n\n

		 After several minutes of this, she pours all of the reagents into a large beaker over an open flame.  The contents boil up through the neck of the flask and drip slowly down the condenser.  A ponderously large drop of black liquid builds up at the tip of the condenser, wobbling precipitously for a moment before finally falling onto the jewel with a splash.\n\n

		 The jewel soaks up the black fluid like a sponge, veins of sickening purple spreading across the surface like a spider's web.  A few moments later, the jewel is entirely purple, the mystic flames inside glowing a bright violet.\n\n

		 You reach out hesitantly and place the mystically enhanced teardrop-shaped jewel into your pouch. );


		 [Fountain Enhance] - definitely not a Zelda reference

		 outputText( "Reaching into your pouch, you pull out a teardrop-shaped jewel.  Well, if the fountain is supposed to enhance things, maybe it will work for some of the items you've collected in your journeys?  Flicking your wrist, you skip the jewel across the surface of the water, landing it in the center of the fountain with a loud 'plunk!'\n\n

		 It is only now that you ponder to yourself exactly how you plan to get the item back.  Your line of thought is interrupted, however, when the water at the center of the fountain begins to foam and bubble, waves and ripples spreading out and crashing against the slick black sides.\n\n

		 Before your eyes, a towering figure with blue skin rises from the water like some form of great and terrible messiah, her arms spread out to the sides as the crystal-clear water rolls off her skin.  The very first thing you notice is her absurdly disproportionate breasts, somehow defying gravity in spite of their mammoth size.  Your eyes trail down to her voluptuous hips, and then are immediately drawn to her absolutely elephantine phallus, the azure rod bobbing in the air hypnotically while inky black droplets slowly roll from the tip down the underside.\n\n

		 \"<i>Hey hey, eyes up here fuckwit!</i>\"  she barks, snapping her fingers to get your attention.  \"<i>" + ((returnVisit) ? "Oh, what the fuck, you again?  " : "") + "Did you throw this?</i>\"\n\n

		 She holds out her hand, a teardrop-shaped jewel resting neatly in the center of her palm.  It seems different from before, though, the flames within glowing with an eerie violet hue, the surface of the jewel webbed with odd purple veins.\n\n

		 You are just about to open your mouth to say something, but the tall figure cuts you off first, snarling, \"<i>So what, you just go around, chucking random shit into fountains?  That's my home, buddy, and I don't appreciate you fucking it up with your garbage.</i>\"\n\n

		 " + ((player.cor < 50) ? "You stammer out a confused apology, explaining that you were just curious what would happen." : "You ask her what exactly she plans on doing about it, flashing a rather rude gesture at her.") + "\n\n

		 \"<i>Whatever,</i>\" she grumbles, tossing the jewel to you with an overdrawn eyeroll.  \"<i>Just don't let it happen again, or I'll fuck you with a rake.</i>\"\n\n

		 Before you can say anything, she disappears below the water, leaving you alone with the trickling sound of the fountain.  With a shrug, you place the mystically enhanced teardrop-shaped jewel into your pouch." );
		 */

//[The Shrine of the Ninetails]
//Discovery
		public function kitsuneShrine():void
		{
			clearOutput();
			if (flags[kFLAGS.KITSUNE_SHRINE_VISIT] == 0) {
				outputText("Your travels take you down a winding path through the forest today, deep in the heart of the woods.  Each step you take makes it feel even more like the dense foliage is creeping in even closer, the rough-hewn dirt path dwindling down to almost nothing up ahead.  Whatever the trail was used for long ago, it is in the late stages of being reclaimed by the wilderness now.\n\n");

				outputText("While you are mindful of this land's dangers, you are curious what secrets this part of the forest might hold.  You press on, trudging through the weed-choked trail, doing your best to keep your wits about you as you march onwards.\n\n");

				outputText("You emerge from the dense foliage into a large clearing.  Your eye is immediately drawn to an absurdly large tree in the center, its weathered trunk covered in knots and gnarls.  Odd-looking paper talismans hang from some of the branches, swaying eerily in a nonexistent breeze.  Worn down flagstones wind around the ancient-looking tree to a small, run-down wooden building that looks like it could comfortably accommodate a single person if it wasn't in such a dilapidated state.\n\n");

				outputText("You call out, but the place seems to be abandoned.  Shrugging, you decide to take a look around the building, hefting a rotten timber out of the way of the door and creeping inside carefully, just in case you aren't really alone.\n\n");

				outputText("It takes a moment for your eyes to adjust to the dim light inside the musty shed, but you eventually start to piece together the makings of a simple dwelling.  An old bedroll lies in one corner, assorted cooking implements hung with care over a small fire pit.  In the rear of the one-room building is enshrined a small pedestal, atop of which stands a small gold statue of an androgynous figure with nine tails.  A short distance away stands a bookcase filled with musty tomes and scrolls of all shapes and sizes.\n\n");

				outputText("Judging by the layer of dust on everything, whoever lived here hasn't been around in quite some time.  You're sure they wouldn't mind if you helped yourself to some of those books - you might just learn a thing or two.  That gold statue is pretty tempting too, but on the other hand it seems to have some sort of spiritual significance - stealing it from its rightful place might not be the wisest idea.  Of course, you could always try praying to it.");
			}
			else {
				outputText("You find your way to the abandoned kitsune shrine again.  The place is full of rotten timber, but it has a bookcase stuffed with well-maintained tomes.  The remains of a camp are in here as well, though the owner is curiously absent.  Judging by the layer of dust on everything, whoever lived here hasn't been around in quite some time.  You're sure they wouldn't mind if you helped yourself to some of those books - you might just learn a thing or two.");
			}
			flags[kFLAGS.KITSUNE_SHRINE_VISIT]++;
			//[Read Books] [Meditate] [Steal Statue] - [Leave]
			menu();
			addButton(0, "Read Books", readKitsuneBooks);
			if (flags[kFLAGS.TOOK_KITSUNE_STATUE] == 0) addButton(1, "Meditate", meditateLikeAKitsuneEhQuestionMark);
			if (player.hasItem(useables.GLDSTAT) || flags[kFLAGS.TOOK_KITSUNE_STATUE] == 0) addButton(2, "Statue", stealAStatue);
			addButton(4, "Leave", camp.returnToCampUseOneHour);
		}

//[Read Books]
		private function readKitsuneBooks():void
		{
			clearOutput();
			outputText("You decide to peruse the selection of old tomes on the bookshelf.  To your dismay, many of them seem to be written in a strange script that you can't understand.  After a bit of searching, though, you find a couple that you can read, carefully thumbing through the old, dusty pages.\n\n");
			var choice:int = rand(3);
			//Randomly Display one of the following:
			if (choice == 0) {
				outputText("It's a rather dry read, but informative.  Chapter after chapter explains the underlying theory of magic, going to almost excruciating levels of detail.  " + ((player.inte < 50) ? "Much of it flies over your head, but the book does manage to clarify a few points.  You close the book and set it back on the shelf, feeling like you've learned something." : "Much of it is merely review, but you do manage to glean a few facts before closing the book and setting it back on the shelf."));
				//+2 INT, Advance 1hr and return to camp
				dynStats("int", 2);
				doNext(camp.returnToCampUseOneHour);
			}
			else if (choice == 1) {
				outputText("It seems to be a religious text of some sort.  As you flip through the pages, you read about various rituals and scriptures, familiarizing yourself with the spirits and gods of this land.  You close the tome at last, setting it reverently back on the shelf and reflecting upon the teachings housed within.");
				//-1 COR, Advance 1hr and return to camp
				dynStats("cor", -1);
				doNext(camp.returnToCampUseOneHour);
			}
			else {
				outputText("You start to flip through the pages, a deep blush slowly forming on your cheeks the further you read into what is clearly an erotic novella of some form.  Graphic descriptions of women being violated by tentacle beasts abound on almost every page, " + ((player.lib < 50) ? "and you slam the book shut before reading further, already feeling a heat building in your groin." : "and you lick your lips hungrily, poring over every line and word of lascivious prose."));
				//+ 1 LIB, + 5 LUST, Advance 1hr and return to camp
				dynStats("lib", 1, "lus", 5);
				doNext(camp.returnToCampUseOneHour);
			}
		}

		public static var basicKitsuneHair:Array = ["white", "black", "black", "black", "red", "red", "red"];
		public static var basicKitsuneFur:Array = ["orange and white", "black", "black and white", "red", "red and white", "white"];
		public static var elderKitsuneColors:Array = ["metallic golden", "golden blonde", "metallic silver", "silver blonde", "snow white", "iridescent gray"];
		
		//[Meditate]
		private function meditateLikeAKitsuneEhQuestionMark():void
		{
			clearOutput();
			if (player.hasItem(consumables.FOXJEWL) && player.tailType == TAIL_TYPE_FOX && player.tailVenom < 9 && player.tailVenom + 1 <= player.level && player.tailVenom + 1 <= player.inte / 10 && player.earType == EARS_FOX && (player.findPerk(PerkLib.CorruptedNinetails) < 0 || player.perkv4(PerkLib.CorruptedNinetails) > 0) && player.findPerk(PerkLib.EnlightenedNinetails) < 0) {
				//20% chance if PC has fox ears, 1 or more fox tails, carries a Fox Jewel, and meets level & INT requirements for the next tail:
				outputText("You sit down carefully on a small mat in front of the shrine and clear your mind.  Closing your eyes, you meditate on the things you've learned in your journey thus far, and resolve to continue fighting against the forces of corruption that permeate the land.\n\n");

				outputText("Nearing the end of your meditation, you are inexplicably compelled to reach into your bag and pull out the small teardrop-shaped jewel you were carrying.  As you stare past the translucent surface of the bead and into the dancing fire within, the jewel begins to dissolve in your hand, the pale flames within spilling out and spreading over your body.\n\n");
				if (player.tailVenom < 8) {
					outputText("Sitting in a silent reverie, you allow the flames to wash over you, and begin to feel a bit more...  enlightened.  Your bushy tail" + ((player.tailVenom > 1) ? "s" : "" ) + " begin" + ((player.tailVenom > 1) ? "s" : "" ) + " to glow with an eerie, ghostly light, and with a crackle of electrical energy, split" + ((player.tailVenom > 1) ? "s" : "" ) + " into " + (player.tailVenom + 1) + "!");
					player.tailVenom++;
				}
				else {
					outputText("As the mystical flames wash over you, your mind is assaulted by a maelstrom of otherworldly knowledge and power.  For a moment it feels as though your mind will be torn asunder, but you are ready.  Your travels and meditations have prepared you well, and you open your mind to accept enlightenment.\n\n");
					outputText("Your bushy tails begin to glow with an eerie, ghostly light, and with a crackle of electrical energy, split into nine tails.  <b>You are now a nine-tails!  Untold cosmic power radiates from your very being!  Use it wisely...</b>");

					//Increment tail by 1, consume Fox Jewel, -2 COR, -20 LUST, +2 INT, Advance 1 hr and return to camp.
					//Apply Nine-Tails perk if applicable.
					player.tailVenom = 9;
					player.createPerk(PerkLib.EnlightenedNinetails, 0, 0, 0, 0);
					
					// Nine tail kitsunes have their fur/hair color golden, silver or pure white
					if (!InCollection(player.hairColor, elderKitsuneColors)) // wrong hair color
						if (player.skinType == SKIN_TYPE_FUR && InCollection(player.furColor, elderKitsuneColors)) { // right fur color
							player.hairColor = player.furColor;
							if (player.hairLength > 0) outputText("\n\nNow you have " + player.hairColor + " hair matching your fur, like true kitsune elder. You look really regal!");
						}
						else if (player.skinType == SKIN_TYPE_FUR) { // wrong fur color
							player.hairColor = randomChoice(elderKitsuneColors);
							player.furColor = player.hairColor;
							if (player.hairLength > 0) outputText("\n\Now you have " + player.hairColor + " fur and hair, like true kitsune elder. You look really regal!");
							else outputText("\n\Now you have " + player.furColor + " fur, like true kitsune elder. You look really regal!");
						}
						else { // no fur
							player.hairColor = randomChoice(elderKitsuneColors);
							player.furColor = player.hairColor;
							if (player.hairLength > 0) outputText("\n\Now you have " + player.hairColor + " hair, like true kitsune elder.");
						}
					else // right hair color
						if (player.skinType == SKIN_TYPE_FUR && !InCollection(player.furColor, elderKitsuneColors)) { // wrong fur color
							player.furColor = player.hairColor;
							outputText("\n\Now you have " + player.furColor + " fur matching your hair, like true kitsune elder. You look really regal!");
						}
					
					outputText("\n\nYou pause for a moment to reflect on your newfound wisdom, and with a renewed vigor for your quest, you stand and set off for camp.");
					dynStats("int", 2, "lus", -20, "cor", -2);
				}
				player.consumeItem(consumables.FOXJEWL);
				doNext(camp.returnToCampUseOneHour);
			}
			else {
				//Normal:
				outputText("You sit down carefully on a small mat in front of the shrine and clear your mind.  Closing your eyes, you meditate on the things you've learned in your journey thus far, and resolve to continue fighting against the forces of corruption that permeate the land.  As you open your eyes again, you feel as if a great burden has been lifted from your shoulders.\n\nWith a renewed vigor for your quest, you stand up and set off for camp.");
				//-2 COR, -20 LUST, +1 INT, Advance 1hr and return to camp.
				dynStats("int", 1, "lus", -20, "cor", -2);
				doNext(camp.returnToCampUseOneHour);
			}
		}

//[Steal Statue]
		private function stealAStatue():void
		{
			clearOutput();
			menu();
			if (flags[kFLAGS.TOOK_KITSUNE_STATUE] == 0) {
				outputText("Feeling the chance is just too great to pass up, you rub your hands together greedily and snatch the gold statue from the shrine.  As you stuff it into your pouch, you are overwhelmed with the sensation that what you are doing is very wrong.  You are starting to have second thoughts...");
				//[Take It] [Put it Back]
				addButton(0, "Take It", takeAKitsuneStatue);
			}
			else {
				outputText("The empty alter stands there, obviously missing the statue you took from it.  You COULD put it back, if you wanted.");
				addButton(0, "Put Back", putKitsuneStatueBack);
			}
			addButton(4, "Back", kitsuneShrine);
		}

//[Take it]
		private function takeAKitsuneStatue():void
		{
			clearOutput();
			outputText("The thought of how many gems you'll be able to get for it is enough to quickly suppress those feelings, avarice winning out over guilt.");
			//+10 COR, add Gold Statue to inventory, Advance 1hr and return to camp
			dynStats("lus", 10);
			inventory.takeItem(useables.GLDSTAT, camp.returnToCampUseOneHour);
			flags[kFLAGS.TOOK_KITSUNE_STATUE] = 1;
		}

//[Put it Back]
		private function putKitsuneStatueBack():void
		{
			clearOutput();
			outputText("Regretting your decision, you replace the statue on the pedestal, your guilty conscience winning out over greed today.");
			//Advance 1hr and return to camp.
			flags[kFLAGS.TOOK_KITSUNE_STATUE] = 0;
			player.consumeItem(useables.GLDSTAT);
			doNext(camp.returnToCampUseOneHour);
		}

//Use:
		public function kitsuneStatue():void
		{
			outputText("You pull out the gold statue and turn it around in your hands a few times, carefully examining the intricate filigree and inscriptions covering the masterfully crafted idol.  Whoever made this certainly put a lot of time and love into their craft." + ((player.cor < 50) ? "  Examining the painstaking detail that went into it, you feel a slight pang of guilt for having stolen it from its rightful place.  You push the thoughts away, reasoning that it won't be missed - after all, the owner was long gone before you arrived." : "") + "\n\n");
			outputText("It's not much use to you other than decoration, but based on the craftsmanship alone you judge that you could get a fair price for it if you pawned it off.  ");
		}
	}
}
