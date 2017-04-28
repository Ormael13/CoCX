package classes.Scenes.Dungeons.Factory 
{
	import classes.BaseContent;
	import classes.GlobalFlags.kFLAGS;
	import classes.Appearance;
	import classes.StatusEffects;
	import classes.PerkLib;
	import classes.CockTypesEnum;

	public class SecretarialSuccubusScene extends BaseContent
	{
		
		public function SecretarialSuccubusScene() {}
		
		public function encounterSuccubus():void {
			spriteSelect(55);
			outputText("\n\nStanding next to the coffeemaker is a blue-skinned woman holding a mug of coffee.  As she takes a sip, oblivious to your presence, you see the mug has '#1 Dad' written on it.  Dressed in a tiny vest, short skirt, and sheer stockings, she looks every bit an air-headed secretarial ditz.  Her two horns are little more than nubs, mostly covered by her flowing blond hair, and if it wasn't for her blue skin and the tip of a spaded tail peeking out from under her skirt, you'd never know what she was.\n\n", false);
			menu();
			// demon bad end available
			if (player.demonScore() >= 4 && player.cor > 75) {
				outputText("The busty succubus turns, her barely contained breasts jiggling obscenely as she notices you, \"<i>Oh, like hi there " + player.mf("stud", "sexy") + "!</i>\"  She stops, sniffing the air, a curious expression on her face as she slowly circles you, her heals clicking loudly on the floor.  A knowing grin blooms across her face as understanding hits her.\n\n", false);
				outputText("She exclaims, \"<i>Omigawsh!  You're the champion!  Your, like, soul is still there and everything!  But, you're like, completely corrupt an' stuff!  Ya know what'd be fun?  I could fuck you 'til you cum so hard your soul melts out an' you turn into a demon.  Wouldn't that be great?</i>\"\n\n", false);
				outputText("The secretarial demoness pulls out a file and fiddles with her nails, murmuring, \"<i>I guess if you don't wanna, we could just hook you up in the factory.  What's it gonna be?</i>\"", false);
				if (flags[kFLAGS.CODEX_ENTRY_SUCCUBUS] <= 0) {
					flags[kFLAGS.CODEX_ENTRY_SUCCUBUS] = 1;
					outputText("<b>New codex entry unlocked: Succubus!</b>\n\n")
				}
				menu();
				addButton(0, "Fight", doFightSuccubus);
				addButton(1, "Go Demon", goDemon);
				addButton(2, "Hook Up", talkSuccubusYes);
			}
			//Not recognized
			else if (player.humanScore() <= 3) {
				outputText("The busty succubus turns, her barely contained breasts jiggling obscenely as she notices you, \"<i>Oh, like hi there " + player.mf("stud", "sexy") + "!  You haven't seen a confused human about calling itself a champion have you?</i>\"\n\nShe shakes her more-than-ample bosom from side to side as she licks her lips and offers, \"<i>If you do, be sure and bring them back here ok?  We've got their spot all ready for them, but that little prick Zetaz fucked up the pickup.  Tell you what – if you bring me the 'champion' I'll ", false);
				if (player.totalCocks() > 0) outputText("give you the blowjob of a lifetime", false);
				else if (player.hasVagina()) outputText("lick your honeypot 'til you soak my face", false);
				else outputText("give you a new addition and show you how to use it", false);
				outputText(".</i>\"\n\nThe succubus turns away from you and makes a show of tweaking her make-up, ignoring you for the moment.", false);
				if (flags[kFLAGS.CODEX_ENTRY_SUCCUBUS] <= 0) {
					flags[kFLAGS.CODEX_ENTRY_SUCCUBUS] = 1;
					outputText("<b>New codex entry unlocked: Succubus!</b>\n\n")
				}
				menu();
				addButton(0, "Fight", doFightSuccubus);
				addButton(1, "It's Me!", talkSuccubusItsMe);
				addButton(2, "Leave", getGame().dungeons.factory.roomLobby);
			}
			else {
				outputText("The busty succubus turns, her barely contained breasts jiggling obscenely as she notices you, \"<i>Oh, like hi there " + player.mf("stud", "sexy") + "!  What's a cute little morsel like you doing by yourself out here?</i>\"", false);
				if (flags[kFLAGS.CODEX_ENTRY_SUCCUBUS] <= 0) {
					flags[kFLAGS.CODEX_ENTRY_SUCCUBUS] = 1;
					outputText("<b>New codex entry unlocked: Succubus!</b>\n\n")
				}
				menu();
				addButton(0, "Fight", doFightSuccubus);
				addButton(1, "Talk", talkSuccubus);
				addButton(2, "Run", getGame().dungeons.factory.roomLobby);
			}
		}
		
		//Succubus Secretary
		private function talkSuccubus():void {
			spriteSelect(55);
			outputText("\"<i>I suppose I really should thank you for coming down all by your lonesome.  The boss is gonna be sooo happy we found you.  Just think, in an hour or two we can get you strapped in and working with the others,</i>\"  says the secretarial succubus as she saunters over, still sipping her coffee, \"<i>You're so cute!  I tell you what, if you agree to come with me, I'll, like, make sure the experience is pleasurable.</i>\"\n\n", true);
			outputText("She runs a stocking covered foot up your leg and thigh, almost to your groin.  Giggling, the succubus pulls it away and asks, \"<i>So are you ready and willing?</i>\"", false);
			menu();
			addButton(0, "For what?", talkSuccubusForWhat);
			addButton(1, "Yes", talkSuccubusYes);
			addButton(2, "No", talkSuccubusNo);
		}
		
		private function talkSuccubusForWhat():void {
			spriteSelect(55);
			outputText("The succubus looks at you with a bemused expression, \"<i>You haven't figured it out yet?  Really?  What do you think we make at this factory, bubble-gum?</i>\" she asks with a cruel smile, \"<i>We take human and once-human champions like you, pump you full of aphrodisiacs, body-altering drugs, and corrupting agents, and then milk you of your tainted fluids continually for the rest of your life!  And don't even start to ask why, I'll tell you – there are still pockets of purity out there that repel cute demons like me.  So the best way to deal with those is just to release a river of drug-filled sex-juice at them.  By the time the area dries off, the locals welcome us with open arms... and spread legs.</i>\"", true);
			menu();
			addButton(0, "Sick!", talkSuccubusNo);
			addButton(1, "Sounds Fun", talkSuccubusYes);
		}
		
		private function talkSuccubusItsMe():void {
			outputText("You laugh mockingly at the stupid demon, roaring, \"<i>I'm the bloody champion you vapid cunt!</i>\"\n\nShe whirls, her beautiful face marred by rage.  It looks like you have a fight on your hands...", true);
			doNext(doFightSuccubusMocked);
		}
		
		private function talkSuccubusYes():void {
			spriteSelect(55);
			outputText("The blue skinned seductress steps forward and wraps her arms around you, pulling your head down and crushing it into her heavenly breasts as she speaks, \"<i>My my, aren't you the kinky little play-toy.  Let's get you hooked up.</i>\"\n\n", true);
			outputText("She catches you off-guard, lifting your feet off the ground.  You realize she has somehow grown taller.  You stretch to see what's going on, but have no leverage to pry your face from the smooth globes of flesh that smother you.   Vaguely, the click-clack of heels reaches you through the walls of flesh.  You're being moved deeper into the facility.   A creaky door opens, allowing you to hear the loud humming of machinery, mixed with what sounds like desperate sexual moans.\n\n", false);
			outputText("Abruptly you are pulled free from the succubus' fleshy prison and bodily thrown into padded restraints.  Blinded by the sudden onslaught of light, you blink away tears as restraints are placed securely around your wrists.  Warm lips press against your own as a foreign tongue penetrates your lips, mouth-raping you.  It tastes of sweet exotic spices, like nothing you've ever had before.   Helpless to do anything but return the kiss, you respond, sliding your tongue along the slippery sweetness of your captor's.  You risk opening your eyes and see your inhuman captor to be enjoying the kiss every bit as much as you.", false);
			doNext(doBadEndSuccubusPart1);
		}
		private function talkSuccubusNo():void {
			spriteSelect(55);
			outputText("She frowns, \"<i>I was secretly hoping you would say that... I'm going to make you beg me to hook you into the machines.  Just wait.</i>\"", true);
			doNext(doFightSuccubus);
		}
		
		private function goDemon():void {
			clearOutput();
			outputText("Advancing slowly, the succubus gives you a hungry look.  She extends a hand, allowing her fingers to lengthen into razor-sharp claws.  With a single expert slash, she cuts away everything holding together your " + player.armorName + ".  They fall into a discarded pile, already forgotten as your ", false);
			//[genderless]
			if (player.gender == 0) {
				outputText("entire body blushes read before the sexy seductress.  She looks at you, frowning as she murmurs, \"<i>Now this just won't do.  You look more like a " + player.mf("boy", "girl") + " to me, so why don't I make the plumbing match the exterior?</i>\"\n\n", false);  
				outputText("Her palm caresses your crotch, stoking the warmth inside you until it blazes white-hot with new sensation.  Your skin ripples and parts, ", false);
				if (player.biggestTitSize() <= 1) {
					outputText("pushed apart the thick flesh of a powerful demonic member, complete with two swollen balls.", false);
					player.createCock();
					player.cocks[0].cockLength = 10;
					player.cocks[0].cockThickness = 2;
					player.cocks[0].cockType = CockTypesEnum.DEMON;
					player.balls = 2;
					player.ballSize = 3;
				}
				else {
					outputText("gushing with fluids as it shapes itself into a hungry demonic cunt.", false);  
					player.createVagina();
					player.vaginas[0].vaginalWetness = VAGINA_WETNESS_SLICK;
				}
				outputText("\n\n\"<i>Much better,</i>\" the demon coos, licking her lips as your ", false);
			}
			//[male]
			if (player.gender == 1) {
				//Multispoooooo
				if (player.cockTotal() > 1) {
					outputText(player.multiCockDescriptLight() + " pulsate, straining for just a touch of the succubus' hand.  She paces around you, giggling and toying with you as your " + player.multiCockDescript() + " seem to follow her, twitching and thickening any time she takes a step closer.\n\n", false);
					outputText("She reaches out, cupping the underside of a shaft, slowly stroking your most sensitive places while she stops the bimbo-like voice and teases, \"<i>Awww, so hard and ready.  It looks to me like you're already a slave to your desires.  You're twitching and dripping, just from the soft touches of your enemy's fingers.  Are you truly so in need of release as to willingly offer it to me?  No, don't answer, your " + player.cockDescript(0) + " already has.</i>\"\n\n", false);
					outputText("You glance down, seeing just how hard her words have made you.  You squirm your " + player.hipDescript() + "s pathetically, trying to hump her hand and increase the stimulation.  The succubus immediately releases you and draws back, shedding her secretary's clothes like a snake sheds its skin.  Now clad only in a tight leather corset and thigh-high stockings with garters, the succubus tosses you onto a table, surprising you with her raw strength.  Seemingly from nowhere, she produces a whip, winding it tightly around ", false);
					if (player.balls > 0) outputText("your " + player.ballsDescriptLight() + " and ", false);
					outputText("the bases of your " + player.multiCockDescriptLight() + ".\n\n", false);
					outputText("\"<i>There, that'll make sure you feel every squeeze and caress of my velvet walls, and keep you from getting off until you're ready,</i>\" says the succubus as she climbs the table and straddles your eager form.\n\n", false);
					outputText("She lifts herself up with her shapely legs and spreads her thighs, proudly revealing her puffy pierced folds.  They drip with demonic nectar as she wiggles over you, spattering you with demon-honey.  Slowly, nearly imperceptibly, she swivels the lewd opening closer and closer, and your cocks, as if possessed, angle themselves upward towards the juicy target.  The grinning succubus looks over her shoulder and asks, \"<i>Ready are we? Ok, I won't keep you waiting.</i>\"\n\n", false);
					outputText("Marvelous heat and wetness sweeps over you in a fluid motion, wrapping your " + player.cockDescript(0) + " tightly.  You sigh happily, already lost in the feeling of having a succubus' tight walls wriggling around you.  Were you not already so corrupt, you would probably be coming already, but as it is, you can lie there and enjoy it, reveling in the sensations your unholy lover is spreading through your body.  You shiver, finally approaching your climax, but as it nears you find yourself denied by the whip binding your " + player.multiCockDescriptLight() + ".  It isn't just the physical tightness either – something else about it keeps your release buried deep, inaccessible.\n\n", false);
					outputText("\"<i>Have you hit it yet?</i>\" the succubus asks as she rocks on top of you, \"<i>I've placed a block inside you.  Don't worry, it's temporary, it'll only stop you from orgasming for a few days...</i>\"\n\n", false);
					outputText("You moan pitifully, begging for her to remove it and allow you to cum.\n\n", false);
					outputText("\"<i>Oh I can't remove it,</i>\" she says, \"<i>The only way you'll be rid of it with any sort of certainty is to melt through it with something stronger.  Something, like, I don't know, the focused remains of your soul and humanity.  Now you think on that while I melt away any doubts you might have.</i>\"\n\n", false);
					outputText("She resumes fucking you, driving you insane with need, all the while fiddling with her clit and pulling up a nipple to lick.  It feels so good, but you NEED to cum.  She fucks you like that for hours, until the table collapses under the pair of you and dumps you both on the floor. More than anything you crave release, and over time you cave in further and further to the need.  In time, you can feel the block weakening, melting, and eroding.  Your life has been distilled down into this one moment, this one desire, this need for release.  The block shatters, melting away under the force of your need.\n\n", false);
					outputText("A look of shock and pleasure spreads over the succubus's face as you release into her hot snatch, cumming with a force unlike anything you've felt before.  Her walls squeeze and caress in time with your orgasm, milking you of every drop.  Your body clenches and squeezes, shuddering as the orgasm continues for far longer than normal.  Though you don't feel like you're pushing out as much fluid as normal, somehow it feels even better, like a slow drip of pleasure and release.  When at last your " + player.cockDescript(0) + " empties, you feel drained and strangely energized at the same time, and your entire torso is spattered with rapidly hardening pink crystals.\n\n", false);
					outputText("The slutty succubus stands up, her puffy vulva coated in a shining pink fluid.  Did that just come out of you?  She grunts, her eyes glowing for a moment as the pink goop disappears into her skin, vanishing entirely.\n\n", false);
					outputText("\"<i>Ahhhhh,</i>\" she sighs, \"<i>nothing like fresh Lethicite.  Mmmm, yours was potent!</i>\"\n\n", false);
					outputText("You stand up, dissatisfied at the sudden lack of sensation you're forced to endure.  The gloating demoness looks rather pleased with herself, and brimming with newfound power.  You resolve to ", false);
					if (player.hasKeyItem("Marae's Lethicite") < 0) outputText("gather some yourself at the next opportunity...", false);
					else outputText("devour Marae's as soon as you get a chance.", false);
					outputText("You greedily gather up the lethicite splattered on your body and devour it, turning it into raw demonic power.  You really do need to get more of this... but first you know a certain demoness you intend to wrap around your ", false);
					if (player.countCocksOfType(CockTypesEnum.DEMON) > 0) outputText("growing", false);
					else outputText("new", false);
					outputText(" demon-cock for a few more orgasms.", false);
				}
				//SINGLEZ NITE
				else {
					outputText(player.multiCockDescriptLight() + " pulsates, straining for just a touch of the succubus' hand.  She paces around you, giggling and toying with you as your " + player.multiCockDescript() + " seems to follow her, twitching and thickening anytime she takes a step closer.\n\n", false);
					outputText("She reaches out, cupping the underside of the shaft, slowly stroking your most sensitive places while she stops the bimbo-like voice and teases, \"<i>Awww, so hard and ready.  It looks to me like you're already a slave to your desires.  You're twitching and dripping, just from the soft touches of your enemy's fingers.  Are you truly so in need of release as to willingly offer it to me?  No, don't answer, your " + player.cockDescript(0) + " already has.</i>\"\n\n", false);
					outputText("You glance down, seeing just how hard her words have made you.  You squirm your " + player.hipDescript() + "s pathetically, trying to hump her hand and increase the stimulation.  The succubus immediately releases you and draws back, shedding her secretary's clothes like a snake sheds its skin.  Now clad only in a tight leather corset and thigh-high stockings with garters, the succubus tosses you onto a table, surprising you with her raw strength.  Seemingly from nowhere, she produces a whip, winding it tightly around ", false);
					if (player.balls > 0) outputText("your " + player.ballsDescriptLight() + " and ", false);
					outputText("the base of your " + player.cockDescript(0) + ".\n\n", false);
					outputText("\"<i>There, that'll make sure you feel every squeeze and caress of my velvet walls, and keep you from getting off until you're ready,</i>\" says the succubus as she climbs the table and straddles your eager form.\n\n", false);
					outputText("She lifts herself up with her shapely legs and spreads her thighs, proudly revealing her puffy pierced folds.  They drip with demonic nectar as she wiggles over you, spattering you with demon-honey.  Slowly, nearly imperceptibly, she swivels the lewd opening closer and closer, and your cock, as if possessed, angles itself upwards towards the juicy target.  The grinning succubus looks over her shoulder and asks, \"<i>Ready are we? Ok, I won't keep you waiting.</i>\"\n\n", false);
					outputText("Marvelous heat and wetness sweeps over you in a fluid motion, wrapping your " + player.cockDescript(0) + " tightly.  You sigh happily, already lost in the feeling of having a succubus' tight walls wriggling around you.  Were you not already so corrupt, you would probably be coming already, but as it is, you can lie there and enjoy it, reveling in the sensations your unholy lover is spreading through your body.  You shiver, finally approaching your climax, but as it nears you find yourself denied by the whip binding your " + player.cockDescript(0) + ".  It isn't just the physical tightness either – something else about it keeps your release buried deep, inaccessible.\n\n", false);
					outputText("\"<i>Have you hit it yet?</i>\" the succubus asks as she rocks on top of you, \"<i>I've placed a block inside you.  Don't worry, it's temporary, it'll only stop you from orgasming for a few days...</i>\"\n\n", false);
					outputText("You moan pitifully, begging for her to remove it and allow you to cum.\n\n", false);
					outputText("\"<i>Oh I can't remove it,</i>\" she says, \"<i>The only way you'll be rid of it with any sort of certainty is to melt through it with something stronger.  Something, like, I don't know, the focused remains of your soul and humanity.  Now you think on that while I melt away any doubts you might have.</i>\"\n\n", false);
					outputText("She resumes fucking you, driving you insane with need, all the while fiddling with her clit and pulling up a nipple to lick.  It feels so good, but you NEED to cum.  She fucks you like that for hours, until the table collapses under the pair of you and dumps you both on the floor. More than anything you crave release, and over time you cave in further and further to the need.  In time, you can feel the block weakening, melting, and eroding.  Your life has been distilled down into this one moment, this one desire, this need for release.  The block shatters, melting away under the force of your need.\n\n", false);
					outputText("A look of shock and pleasure spreads over the succubus's face as you release into her hot snatch, cumming with a force unlike anything you've felt before.  Her walls squeeze and caress in time with your orgasm, milking you of every drop.  Your body clenches and squeezes, shuddering as the orgasm continues for far longer than normal.  Though you don't feel like you're pushing out as much fluid as normal, somehow it feels even better, like a slow drip of pleasure and release.  When at last your " + player.cockDescript(0) + " empties, you feel drained and strangely energized at the same time.\n\n", false);
					outputText("The slutty succubus stands up, her puffy vulva coated in a shining pink fluid.  Did that just come out of you?  She grunts, her eyes glowing for a moment as the pink goop disappears into her skin, vanishing entirely.\n\n", false);
					outputText("\"<i>Ahhhhh,</i>\" she sighs, \"<i>nothing like fresh Lethicite.  Mmmm your's was potent!</i>\"\n\n", false);
					outputText("You stand up, dissatisfied at the sudden lack of sensation you're forced to endure.  The gloating demoness looks rather pleased with herself, and brimming with newfound power.  You resolve to ", false);
					if (player.hasKeyItem("Marae's Lethicite") < 0) outputText("gather some yourself at the next opportunity...", false);
					else outputText("devour Marae's as soon as you get a chance.", false);
					outputText("  But first you know a certain demoness you intend to wrap around your ", false);
					if (player.countCocksOfType(CockTypesEnum.DEMON) > 0) outputText("growing", false);
					else outputText("new", false);
					outputText(" demon-cock for a few more orgasms.", false);
				}
			}
			//[female]
			else if (player.gender == 2) {
				outputText(player.vaginaDescript(0) + " grows wet and ready, practically juicing itself as the demoness' hand caresses your inner thigh.  She teases, \"<i>Oh my! You're so wet and ready and I haven't even touched your moist little cum-receptacle.  You're a slut aren't you?  Who else would be so turned on by the idea of cumming until all your humanity drips out?</i>\"\n\n", false);
				outputText("The words make you blush hard, shaming you and stoking the growing fire between your " + player.legs() + ".  You know two things for certain: she's right and you're more turned on that ever.  You don't resist as the demoness easily lifts you up, setting you down on a table with your " + player.legs() + " spread.  \"<i>There,</i>\" she comments, \"<i>now your juicy snatch is on display, just like you've always wanted.</i>\"\n\n", false);
				outputText("She effortlessly swings her lissome legs onto the table as she pulls herself up, mounting you as a man might.  You can feel waves of heat rolling off her sex, bathing your own slit in her warmth.  ", false);
				if (player.getClitLength() >= 2) outputText("Your " + player.clitDescript() + " pushes free, nuzzling against her hairless cunt and slipping inside, as if drawn in by its desire.  She openly moans, and begins rocking on top of you.  You gasp in delight as she rides your " + player.clitDescript() + ", fucking and grinding against it.  ", false);
				else outputText("She lowers herself down, rubbing smooth hairless netherlips over you, smearing you with her fragrant demon-honey.  You feel her clit grinding on your own, drawing out gasps of delight from both of your mouths as she relentlessly scissors against you.  ", false);
				outputText("In no time flat you feel your climax building.  Your " + player.vaginaDescript(0) + " quivers and grows wetter in anticipation.  Tugging on your aching " + player.nippleDescript(0) + "s and aching for release, you squirm under your demonic mistress, smashing your " + player.vaginaDescript(0) + " against her in a lewd attempt to find your orgasm.  It does not happen, and you moan in disappointment as the pleasure continues to build, oblivious to your desire for orgasm.\n\n", false);
				outputText("\"<i>Have you hit it yet?</i>\" the succubus asks as she rocks on top of you, \"<i>I've placed a block inside you.  Don't worry, it's temporary, it'll only stop you from orgasming for a few days...</i>\"\n\n", false);
				outputText("You moan pitifully, begging for her to remove it and allow you to cum.\n\n", false);
				outputText("\"<i>Oh I can't remove it,</i>\" she says, \"<i>The only way you'll be rid of it with any sort of certainty is to melt through it with something stronger.  Something, like, oh I don't know, the focused remains of your soul and humanity.  Now you think on that while I grind away any remaining doubts you might have.</i>\"\n\n", false);
				outputText("The beautiful succubus on top of you picks up the pace, grinding harder against your " + player.vaginaDescript(0) + " and " + player.clitDescript() + ", pushing you beyond anything you've ever felt before.  She leans down over you, licking her lips to reveal an inhumanly long tongue.  It snakes down, curving around you " + player.allBreastsDescript() + " before it arches up to flick a " + player.nippleDescript(0) + ".  ", false);
				if (player.hasFuckableNipples() && player.biggestTitSize() > 2) outputText("You gasp as the tongue slides inside each of your breasts, violating them in turn thanks to your strange anatomy.\n\n", false);
				else outputText("You gasp as it curls around each of your " + player.nippleDescript(0) + "s in turn, tugging them lewdly.\n\n", false);  
				outputText("She fucks you like that for hours, until the table collapses under the pair of you and dumps you both on the floor. More than anything you find yourself craving release, and over time you cave in further and further to the need.  You start to feel the block weakening, melting, and eroding.  Your life has been distilled down into this one moment, this one desire, and this need for release.  The block shatters, melting away under the force of your need as you explosively orgasm.\n\n", false); 
				outputText("Sparkling pink fluid splatters between the two of you as you cum, squirting hard", false);
				if (player.vaginas[0].vaginalWetness < VAGINA_WETNESS_SLAVERING) outputText(" for the first time", false);
				outputText(".  The succubus throws back her head and lets loose a moan of ecstasy, her entire body shivering with your own as both of your heads fill with fireworks of pleasure.  Nervelessly, she rolls off of you, her tail contracting hard around your leg while the two of you share the moment.\n\n", false);
				outputText("The succubus interrupts your delight by recovering far faster than you, rolling up to a standing position and watching something between your legs.  You prop yourself up on your elbows to see what the fuss is about.  Between your legs something curious is happening – a trickle of pinkish fluid is still escaping your nethers, rolling towards a rapidly expanding pool, along with every other drop of the pink goop.  Before your very eyes the pool grows until every drop of pink fluid has collected together, and it grows upwards, solidifying into a sparkling crystalline shape.\n\n", false);
				outputText("Before you can react, she grasps the newly-formed lethicite and noisily begins eating it, her eyes glowing with newfound power.  Watching her makes you more than a little jealous and angry with yourself.  You should've taken the lethicite and gained its power!  No use fretting about it, you can still fuck this succubus for a few hours before you go out in search of your own victims...\n\n", false);
			}
			//[HERM ENDING]
			else {
				//Buh.  Zombie fen need brains.
				outputText(player.multiCockDescript() + " and " + player.vaginaDescript(0) + " grow wet and ready, both starting to leak fluids as the succubus' hand traces your inner thigh.  She teases, \"<i>Oh my! You're so wet and ready and I haven't even touched your moist little cum-receptacle.  And that throbbing cock!  How obscene!  You're a slut aren't you?  Who else would be so turned on by the idea of cumming until your humanity is splattered between my legs?</i>\"\n\n", false);
				outputText("The words make you blush hard, shaming you and stoking the growing fire between your legs.  You know two things for certain: she's right and you're more turned on that ever.  You don't resist as the demoness easily lifts you up, setting you down on a table with your legs spread.  \"<i>There,</i>\" she comments, \"<i>now all of your fun-parts are on display.  Maybe I should call in an incubus and a few imps to watch.  I bet you'd like that wouldn't you?</i>\"\n\n", false);
				outputText("She effortlessly swings her lissome legs onto the table as she pulls herself up, mounting you in a single swift motion.  You can feel waves of heat rolling off her sex, bathing your " + player.cockDescript(0) + " in her warmth.  ", false);
				if (player.getClitLength() >= 2) outputText("Your " + player.clitDescript() + " pushes free, nuzzling against her tight asshole and slipping inside, as if drawn in by its desire.  She openly moans, and begins rocking on top of you.  You gasp in delight as she rides your " + player.clitDescript() + ", fucking her ass and grinding against it.", false);
				else outputText("She lowers herself down, rubbing smooth hairless netherlips over your crotch and vulva, smearing you with her fragrant demon-honey.  You feel her clit grinding on your belly, drawing out gasps of delight from both of your mouths as she relentlessly works her body against your own.", false);
				outputText("\n\nMarvelous heat and wetness wraps your " + player.cockDescript(0) + " tightly.  You sigh happily, already lost in the feeling of having a succubus' tight walls wriggling around you.  Were you not already so corrupt, you would probably be cumming already, but as it is, you can lie there and enjoy it, reveling in the sensations your unholy lover is spreading through your body.  You shiver, finally approaching your climax, but as it nears you find yourself denied by something deep inside you, pushing away your release and hiding it somewhere inaccessible.\n\n", false);
				outputText("\"<i>Have you hit it yet?</i>\" the succubus asks as she rocks on top of you, \"<i>I've placed a block inside you.  Don't worry, it's temporary, it'll only stop you from orgasming for a few days...</i>\"\n\n", false);
				outputText("You moan pitifully, begging for her to remove it and allow you to cum.\n\n", false);
				outputText("\"<i>Oh I can't remove it,</i>\" she says, \"<i>The only way you'll be rid of it with any sort of certainty is to melt through it with something stronger.  Something, like, I don't know, the focused remains of your soul and humanity.  Now you think on that while I melt away any doubts you might have.</i>\"\n\n", false);
				outputText("She resumes fucking you, driving you insane with need, all the while fiddling with her clit and pulling up a nipple to lick.  It feels so good, but you NEED to cum.  She fucks you like that for hours, until the table collapses under the pair of you and dumps you both on the floor. More than anything you crave release, and over time you cave in further and further to the need.  Eventually, you can feel the block weakening, melting, and eroding.  Your life has been distilled down into this one moment, this one desire, this need for release.  The block shatters, melting away under the force of your need.\n\n", false);
				outputText("A look of shock and pleasure spreads over the succubus' face as you release into her hot snatch, cumming with a force unlike anything you've felt before.  Her walls squeeze and caress in time with your orgasm, milking you of every drop.  Your body clenches and squeezes, shuddering as the orgasm continues for far longer than normal.  Though you don't feel like you're pushing out as much fluid as normal, somehow it feels even better, like a slow drip of pleasure and release.  When at last your " + player.cockDescript(0) + " empties, you feel drained and strangely energized at the same time.\n\n", false);
				outputText("The slutty succubus stands up, her puffy vulva coated in a shining pink fluid.  Did that just come out of you?  She grunts, her eyes glowing for a moment as the pink goop disappears into her skin, vanishing entirely.\n\n", false);
				outputText("\"<i>Ahhhhh,</i>\" she sighs, \"<i>nothing like fresh Lethicite.  Mmmm, your's was soooo potent!</i>\"\n\n", false);
				outputText("You stand up, dissatisfied at the sudden lack of sensation you're forced to endure.  The gloating demoness looks rather pleased with herself, and brimming with her new-found power.  You resolve to ", false);
				if (player.hasKeyItem("Marae's Lethicite") < 0) outputText("gather some yourself at the next opportunity...", false);
				else outputText("devour Marae's as soon as you get a chance.", false);
				outputText("  But first you know a certain demoness you intend to wrap around your ", false);
				if (player.countCocksOfType(CockTypesEnum.DEMON) > 0) outputText("growing", false);
				else outputText("new", false);
				outputText(" demon-cock for a few more orgasms.", false);
				outputText("  Before you get into that, you spy a small piece of pink crystal on the floor between your legs.  You snatch it and devour it before the succubus has a chance and eat it, turning part of your soul into new-found demonic strength before you return to a long night of sex...", false);
			}
			player.orgasm('Generic');
			dynStats("str", 2,"tou", 2, "spe", 2, "int", 2, "lib", 2, "sen", 2, "cor", 100);
			doNext(doBadEndDemon);
		}
		
		private function doBadEndDemon():void {
			clearOutput();
			if (player.gender == 1) outputText("As a demon, you rapidly moved up the ranks, eventually taking command of the factory and its inhabitants.  The previous commander was reduced to a willing cock-sleeve, ever-eager to obey your slightest order.  By the time the next year has come around, you've managed to earn the coveted honor of collecting the next champion.", false);
			else if (player.gender == 2) outputText("Now a full-fledged demon, you leave the factory, setting off on your own.  Over the next year you capture many foolish mortals, and even convince more than a few of them to give up their souls.  With your rapid gain in power, it's easy to rise in the demonic ranks, and in no time flat your power far exceeds that of the succubus that 'turned' you.  You live in luxury, surrounded by a harem of slaves, waiting in your camp for the next victim to step through...", false);
			else outputText("As a demon, you rapidly moved up the ranks, eventually taking command of the factory and its inhabitants.  The previous commander was reduced to a willing cock-sleeve, ever-eager to obey your slightest order.  By the time the next year has come around, you've managed to earn the coveted honor of collecting the next champion. It should be quite satisfying...", false);
			getGame().gameOver();
		}
		
		private function doFightSuccubus():void {
			spriteSelect(55);
			outputText("\"<i>You're going down!</i>\" you yell at her as you ready your " + player.weaponName + "! \n\nAn unseen force closes the door, preventing you from running away. \n\nIt's a fight!", true)
			flags[kFLAGS.FACTORY_SUCCUBUS_DEFEATED] = 1
			startCombat(new SecretarialSuccubus(), true);
		}
		private function doFightSuccubusMocked():void {
			spriteSelect(55);
			flags[kFLAGS.FACTORY_SUCCUBUS_DEFEATED] = 1
			startCombat(new SecretarialSuccubus(), true);
			monster.armorDef -= 10;
		}
		
		public function doRapeSuccubus():void {
			player.slimeFeed();
			clearOutput();
			//MALE
			if (player.cocks.length > 0 && (player.gender != 3 || rand(2))) {
				//(LUSTY) 
				if (monster.lust >= monster.eMaxLust()) outputText("Panting hotly, the succubus staggers towards you, her eyes fixated on the bulge in your crotch.  Dark viscous liquid drips from her dusky folds as her hips undulate hypnotically.  Blue fingers smear the corrupted lubricants over the smooth outer folds of her sex as she lies back enticingly, giving up on anything but bedding you.  In moments your " + player.armorName + " are on the floor and you approach your prize.\n\n", false); 
				//(HP) 
				else outputText("The succubus collapses on the floor, groaning in pain.  Most of her clothes have been destroyed by the combat and her blue skin is marked with deep purple bruises and bloody lacerations.  You undress, straddling your conquest and gazing down on her helpless, curvaceous form.  She looks up at you and forces a smile, licking the blood from a cracked lip and beginning to masturbate for you.\n\n", false);
				//START ZE RAEP CANNONZ
				outputText("While pondering the best way to take your horny prize, her complexion begins to change, the marks of combat disappearing from her toned body.  The demonic horns crowning her perfect visage begin withdrawing into her head, and her hair ", false);
				if (player.hairLength > monster.hairLength) outputText("lengthens", false);
				else outputText("shortens", false);
				outputText(", shifting to " + player.hairColor + ".  The bone structures of her cheeks, nose, and face shift ever so slightly, and you suddenly realize you are looking down at a slutty version of yourself!  You aren't sure if it's the growing pool of succubus fluid below you or how hot your female twin is, but your " + player.cockDescript(0) + " is as hard as a rock.\n\n", false);
				outputText("Well, you DID decide to rape her, and now you know that you ARE smoking hot.  You shrug and shove your fem-double's legs apart, exposing her glistening fuck-target.  You bend down and bite her nipple as you position yourself at her entrance, allowing her to grasp your " + player.cockDescript(0) + " and coat it with her slick dark fluids.  It tingles as the tainted cunt-juices wick up into your dick like the oil from a lantern back home. At first it burns painfully, as if badly sunburned, but you adjust to the discomfort and marvel as your skin turns blackish-purple. Midnight-colored nodules sprout along the upper and lower portions of your " + player.cockDescript(0) + ", perfectly shaped to tease clits.  Just under its head, a ring of larger growths emerge, somewhat pointy, but flexible, rubbery and incredibly sensitive.  Your " + player.cockDescript(0) + " gets harder and harder as it grows slightly beyond its normal size.  It tugs your groin forwards, practically leaping towards its demonic mate on its own volition.  You cave in and press forwards, parting her folds and submerging your crown in corruptive bliss.\n\n", false); 
				//((TOO BIG))
				if (player.cockArea(0) > monster.vaginalCapacity()) {
					outputText("But the pleasure is short-lived, as even her altered physiology can't accommodate your massive tool. With a grunt of frustration you yank your hungry demonic cock away from your goal.  She smiles knowingly and massages her breasts, releasing streams of the same black fluid from her tumescent nipples. It coats the valley of her pornstar-sized breasts, allowing the fluid to flow down and pool in her tight little belly button.\n\n", false);
					outputText("\"<i>This will, like, be even better anyways stud!</i>\" coos a higher pitched you, smashing her tits together wetly for emphasis.  Viscous strings of lubricants form a mesmerizing lattice between her mountainous tits as she puts on a show for you.  Entirely of its own accord, your " + player.cockDescript(0) + " drags you into her web of corruption, plopping itself firmly into the river of desire that fountains from the peaks on either side. With a steady rhythm, you rock your " + player.hipDescript() + " back and forwards, plunging into her delicious fuckpillows without abandon. With an inhuman strength, she pushes them together, forcing them to completely encircle your over-sized pole with a tight ring of corruption-dripping tit-flesh.\n\n", false);
					player.cocks[0].cockType = CockTypesEnum.DEMON;
					//[normal]
					if (player.cumQ() < 50) outputText("Droplets of pre begin to escape your cock-slit every time your sensitive nodules pass between your fem-clone's wondrous pleasure-tits.  You fuck harder, no longer caring if it's your choice or your cock's, mashing your purplish head against her lips with every stroke.  The flash-fire of an orgasm sweeps over you, over-engorging the nodules all over your cock and doubling their size.  Your hips resort to tiny rocking motions as you rub your cock-slit into your fem-self's open mouth, blasting thick ropes of tainted black cum into her mouth. Though you quickly empty of cum and collapse onto her, your " + player.hipDescript() + " continue to fuck like a machine.  All you can do is hang on to your meat and try to stay conscious as your demonic prick feasts on your double.\n\n", false); 
					//[high]
					if (player.cumQ() >= 50 && player.cumQ() < 500) {
						outputText("A steady stream of pre begins to escape your cock-slit, drooling over your double's face and tits as you pound away at her bouncing ring of titflesh.  Every new bump and nodule seems as sensitive as your entire maleness used to be.  Every thrust into the dark wet prison only makes your pre-cum drool faster and your " + player.cockDescript(0) + "'s new adornments grow fuller and even more tender.  In a flash, the fire of orgasm overwhelms your body's new taint-saturated cock.  Like a kinky 'wave', each nodule from the base to the pointy ring at your crown grows larger as your muscles clench.  ", false);
						if (player.balls > 0) outputText("Your " + player.ballsDescriptLight() + " practically glow with relief as they begin contracting.  Their entire surface is covered with black veins that radiate from your demonic prick, sharing the corruption with your sperm factories.  ", false);  
						outputText("You throw back your head as the first wave of release pours from your tip, splattering your female clone with inky black cum!  The color startles you for a moment before the next blast moves down your shaft, visibly distending your urethra until it bursts free to coat her hair.  Your hips keep moving of their own accord, massaging the crown-ring with tits during each thrust forwards and accompanying cumshot.  By the fourth load, your double is opening her soaked lips wide and guzzling it down.  By the sixth she's sputtering and coughing as the black sex juice sloughs off her.  By the ninth she's managed to clamp her lips over your cock-tip, and her throat bulges ludicrously with the effort of taking each load.  Thankfully, your orgasm finally winds down.  As the last few globs of inky jism escape from you, you realize your hips are still moving, plunging your massive possessed tool into its new favorite place.  Sighing, you hang onto your endowment and try to stay conscious in spite of your exhaustion and the overwhelming feelings coming from your groin.\n\n", false);
					}
					//[ultrahigh]
					if (player.cumQ() >= 500) {
						outputText("A river of pre-cum begins pouring from your cock-tip's slit, soaking your slutty double's face and tits as it mixes with the corruptive fluids already smeared about.  The alien bumps and nodules upon your " + player.cockDescript(0) + " flex and twitch at every pass through the fuck-able foe's soft tits, slowly growing as they absorb more of your slut-self's taint.  The tight squeeze around your newly retextured " + player.cockDescript(0) + " overwhelms any sense of control you may have had as your arousal-soaked groin takes over completely.  You begin pounding the tit-pussy as if your life depended on it, jack-hammering  your " + player.cockDescript(0) + " forward and back hard enough to make the mountains of breast ripple and shake like jello during an earthquake.  The ring of pointed nodules around your crown continues to swell and grow with every pass through the inky passage, soaking up more and more of the corruption until they are each nearly two inches long.  Overwhelmed by the pleasure, your eyes roll back and a mighty orgasm comes to boil in your groin.  ", false);
						if (player.balls > 0) outputText("Your " + player.ballsDescript() + " twitch and shake, the veiny surface of your sack darkening as the corruption begins to fill them.  ", false);
						outputText("\n\nLike a perverted version of the wave, the nodules along your length fill with blood, doubling in size along your length as a massive bulge of cum rushes out your urethra.  Black cream drizzles from the tiny growths as the first blast of cum passes into your dick's crown moments before erupting like a volcano.  One second the sexy female version of you is moaning like a whore and licking her lips. The next she is sputtering and gasping as a half-gallon of inky black cum soaks her from head to tits.  Heedless of her discomfort, your legs keep sawing your " + player.cockDescript(0) + " deeper into this perfect titfuck as more thick bulges of tainted spunk begin to stretch your urethra on their way out.  You babble incoherently as your cock's tip plants itself against her open lips, blasting even more spunk directly into her waiting gullet.  Her cheeks bulge comically as the stuff drips from her nose, but somehow she manages to swallow the bulk of it, her hands vigorously milking your " + player.cockDescript(0) + " with her fuck-bags.  By the time the third jet of cum erupts, she's unhinged her jaw and somehow taken the head into her mouth, giving unfettered access to pump her belly full of your black jism.  You groan with uncontrollable pleasure as her belly fills with spunk.  Her eyes roll back as the next blasts expand her belly further, at first making her look slightly pregnant and then gradually stretching her belly until she looks like she could have minotaur twins.  You lose count of how much cum you put into her, but eventually she can take no more and your cock is pushed free by the pressure, splattering her face again.  Far from finished, you blast cum over her face as you realize she's lost consciousness; her eyes are totally rolled back and her tongue lolls from her mouth like that of a sleeping bitch.  Eventually your orgasm winds down, but not before leaving her in a 4 inch deep puddle of spunk, looking like more like a blue balloon full of dark water than woman.\n\n", false); 
					}
					outputText("Still, your possessed maleness is far from finished as it continues to slide along her belly and between her still-dripping tits, and before long you feel another orgasm building.  You hang on for dear life, hoping just to stay conscious through the ordeal...\n\n\nHours later you pull away, sated.  For now.", false);
				}
				//((IT FITS))
				else {
					outputText("You plunge in to her velvety depths and feel her rippling cunt-muscles contract tightly around you for a perfect fit.  She gasps as each cock-distorting nodule bounces her two-inch clitty, making your mirror image moan like a bitch in heat.  The corrupted fluids dripping from her snatch squelch loudly, making your groin burn with pleasure.  ", false);
					if (player.balls > 0) outputText("Looking down, you even see the veins on your sack darkening to solid black as the corruption begins tainting your sperm-factories.  ", false);
					outputText("You pull back, letting the ring of pointed fleshy barbs spring free before plunging them back in. The pleasure makes you swoon, nearly forcing you to orgasm on the spot.  ", false);
					if (player.biggestTitSize() > 0) outputText("Your female double reaches down to pinch your nipple, spurring you on, \"<i>Please, could you like, cum for me?</i>\"", false);
					//New PG
					outputText("\n\n", false);
					player.cocks[0].cockType = CockTypesEnum.DEMON;
					outputText("The succubus bucks her hips weakly, still clearly defeated, but egging on your orgasm as dark fluids squelch free from her quim.  \"<i>Please... can't you see how hot you're making me?  I've made your cock perfect, so please make me cum!</i>\" she begs as she quivers with delight.  ", false);  
					outputText("You pause to think about it, not noticing that your groin is pounding away with furious energy, splattering cum and pre over her thighs as your new cock's instincts take control from your waist down.  Gasping with sudden pleasure, you feel a flash of heat pass through your tainted meatstick as an orgasm builds.", false);
					//New PG
					outputText("Each of the new bumps and rounded spines of your " + player.cockDescript(0) + " flood with blood, doubling in size as orgasm overtakes you.  ", false);
					outputText("Your hips bury your entire length inside her, acting on their own as your " + player.cockDescript(0) + " clenches, pouring more and more spunk inside her", false);
					if (player.balls > 0) outputText(" as your balls empty their load queue", false);
					outputText(".  ", false);
					//Big cum
					if (player.cumQ() >= 50 && player.cumQ() < 400) outputText("You inhale as black cum spatters from her entrance, her belly distending slightly as you empty what feels like a gallon inside her.  ", false);
					//((Ginormohuge)) 
					if (player.cumQ() >= 400) outputText("Gasping in pleasure and surprise, you marvel as her belly visibly expands with each eruption of your dark load.  At first it looks like a tiny belly, but by the time the orgasm finishes, your girlish double looks like a woman in her ninth month of pregnancy – with twins.", false);
					outputText("\n\nYou pant with exertion and pull back, only to have your " + player.cockDescript(0) + " plunge right back in. Beginning another rough fucking session, your hips force-fuck her beyond your control.  Exhausted, you lean over her, figuring you may as well enjoy your double's wondrous breasts until your demonic cock has finally sated itself.  You just hope you don't black out from the waves of pleasure each of your new nubs radiates.\n\n\nHours later you pull away, sated.  For now.", false); 
				}
				outputText("\n\nThe succubus licks her fingers clean, looking totally recovered.  In the blink of an eye, she dashes out the door, disappearing.", false);
				player.orgasm('Dick');
				dynStats("cor", 5);
				combat.cleanupAfterCombat();
			}
			//FEMSAUCE
			else {
				if (monster.HP < 1) outputText("Your foe staggers and falls hard on her ass, utterly defeated.  Her bruises and lacerations slowly fade and heal, regenerating with the aid of her demonic powers.  You easily tear through her clothes, leaving only the damaged stockings that gird her legs. It doesn't take much to force her down on her back and straddle her as you disrobe, ready to take your pleasure.\n\n", false);
				else outputText("Your foe drops to her knees, stuffing three digits into her greedy snatch as arousal overcomes her desire to subdue you.  With great care, you approach your insensible enemy and tear off her clothes, leaving her wearing only the remains of her stockings as you force her down on her back.  As if possessing a will of their own, her legs lewdly spread as you disrobe.\n\n", false);
				outputText("Her budding clit rises from between her folds, hardening like a tiny three inch dick.\n\n", false);
				menu();
				addButton(0, "Scissor", doScissorSuccubus);
				if (player.biggestLactation() > 1) {
					outputText("<b>You could scissor with her, or maybe force-feed her some of the milk you've backed up.  Which will it be?</b>", false);
					addButton(1, "Force Feed", doForcefeedSuccubus);
				} else {
					addDisabledButton(1, "Force Feed");
				}
			}
		}
		public function doScissorSuccubus():void {
			outputText("You shiver with anticipation as you hook your leg under her thick thighs, lining up your " + player.vaginaDescript(0) + " as you press forwards.  The anticipation builds as your matched honeypots grow ever closer.  Making contact, your folds part as her purplish-red clit slips betwixt your nether-lips, vibrating slightly in tune with the succubus' heartbeats.  You gasp, feeling your own " + player.clitDescript() + " erecting and rubbing against her smooth mound.\n\n", false);
			if (player.getClitLength() >= 3) outputText("You groan with wanton desire as your " + player.clitDescript() + " continues to grow and grow until reaching full size and slipping inside the defeated slut's sloppy pleasure-hole.  ", false);
			outputText("It takes only a few seconds to get the succubus' juices really flowing, the sounds of your grinding hips dissolving into a cacophony of liquid squelches.  The gooey corrupt fem-cum tingles, spreading warmth through every patch of skin it touches.  Your locked hips writhe and twist with her's, eliciting pants and squeals from the both of you.  In no time flat, you find yourself cumming and feel your " + player.vaginaDescript(0) + "'s muscles clench hungrily with an unquenchable desire to be filled.  The succubus shivers in pleasure, probably feeding off your orgasm.  You back off, fingering your " + player.vaginaDescript(0) + " languidly and denying her a full meal.  Pouting, the succubus dips her fingers back in, determined to cum.", false);
			outputText("\n\nYou turn away with a bemused sigh.  When you glance back, she has vanished!", false);
			player.orgasm('Vaginal');
			dynStats("cor", 1);
			combat.cleanupAfterCombat();
			//doNext(roomBreakRoom);
		}
		public function doForcefeedSuccubus():void {
			clearOutput();
			outputText("You chuckle as you decide to release some of the pent up pressure in your " + player.allBreastsDescript() + ".  Laying down over your conquest, you grasp her wrists and pin them to the floor as you shove your tits in her face", false);
			if (player.biggestTitSize() > 6) outputText(", nearly smothering the succubus with the swell of tit-flesh", false);
			outputText(".  You jiggle back and forth, lining up a " + player.nippleDescript(0) + " with the demon's parted lips.  You press your weight down threateningly, making it clear you could suffocate her with a boob.\n\n", false);  
			outputText("\"<i>Drink up bitch, these tits are full!</i>\" you command.\n\n", false);
			outputText("The succubus tentatively takes a " + player.nippleDescript(0) + " into her mouth, sighing at the tangy taste of your sweat-drenched skin.  Her lips gently suckle, wrapping around the perky hardening nub as it fills with arousal and milk.  You feel something let go inside your " + player.breastDescript(0) + " and the succubus smiles, now working to free more of your trapped cream.\n\n", false);
			if (player.biggestLactation() < 2) outputText("Her flexible tongue easily curls around one of your " + player.nippleDescript(0) + "'s, letting her pull and tug on it as she increases the suction from her lips.  Your body rewards her efforts with a faster flow of milk that she sucks down as if she were starving.\n\n", false); 
			if (player.biggestLactation() >= 2 && player.biggestLactation() < 3) {
				outputText("Her flexible tongue wraps around your milk-engorged nipple, pulling it tightly as she increases the suction of her lips.  Your body wastes no time rewarding her and she begins gulping down a steady supply of your breastmilk with a pleased expression on her face. You muse to yourself that perhaps succubi are masochists as breast-milk runs freely from your un-milked ", false);
				if (player.totalBreasts() > 2) outputText("tits.\n\n", false);
				else outputText("tit.\n\n", false);
			}
			if (player.biggestLactation() >= 3 && player.biggestLactation() < 4) {
				outputText("Her flexible tongue wraps around a milk-swollen nipple, immediately squeezing out a jet of thick breast-milk.  The tongue squeezes and tugs while the succubus ramps up the suction between her thick bee-stung lips.  Your body rewards her with fountains of milk, forcing her to visibly gulp and struggle to keep up with the heavy flow.  Milk runs freely down the " + player.skinDesc + " on your chest, pooling around the succubus' groin and your own as the unattended nipple", false);
				if (player.totalBreasts() > 2) outputText("s", false);
				outputText(" can't help but dribble in sympathy.\n\n", false);
			}
			if (player.biggestLactation() >= 4) {
				outputText("Her flexible tongue wraps around a milk-bloated nipple, immediately releasing a massive spray of cream that pours into her gullet, nearly choking her.  You stifle a giggle and pull her closer.  Thankfully, her determined tongue manages to stay in place and start tugging your nipple about, releasing even more of your over-large milk production.  She struggles, her throat and cheeks bulging from your explosive output of milk, until it overwhelms her and begin to pour out of her nose.  More milk pours from your unoccupied nipple", false);
				if (player.totalBreasts() > 2) outputText("s", false);
				outputText(" in sympathy, drenching your " + player.skinDesc + " with creamy goodness until it puddles on your captive demon.\n\n", false);
			}
			if (player.totalNipples() == 2) outputText("As your first nipple drains, you move her to your other breast, being sure to motivate her cunt by grinding it with your " + player.foot() + ".  She squeals and sucks harder, emptying the last of your milk with a cute burp.  ", false);
			if (player.totalNipples() > 2 && player.totalNipples() < 6) outputText("As your first " + player.nippleDescript(0) + " drains, you forcibly move her to the next, unleashing a fresh batch of milk for her to feast upon.  Eventually, it too dries up, so you migrate her onwards to your next " + player.nippleDescript(0) + ".  After she drains each of your " + num2Text(player.totalNipples()) + ", you smile happily at your now emptied breasts.  ", false);
			if (player.totalNipples() >= 6) outputText("As your first " + player.nippleDescript(0) + " drains, you force her over to the next, unleashing even more milk for her to feast upon.  In time, that " + player.nippleDescript(0) + " also empties and you rotate her on to the next.  The cycle repeats seemingly endlessly as you work her from nipple to nipple, relieving the insistent pressure of your breasts and slowly filling her with your milk.  ", false);
			if (player.averageLactation() * player.totalBreasts() < 6) outputText("Her belly bulges slightly from all the breast-milk she's consumed.\n\n", false);
			else outputText("The succubus looks bloated and pregnant from all the milk you've forced into her.  She sloshes and moans incoherently from the strain of it all.\n\n", false);
			outputText("Despite the relief your " + player.allBreastsDescript() + " now feel, your " + player.vaginaDescript(0), false);
			if (player.cocks.length > 0) outputText(" and " + player.multiCockDescriptLight() + " feel hungrier than ever.  ", false);
			else outputText(" feels hungrier than ever.  ", false);
			outputText("You shove your crotch into your milk-dazed foe's white-stained visage, grinding your " + player.vaginaDescript(0) + " into her mouth until you cum all over her", false);
			if (player.cocks.length == 0) {
				temp = rand(3);
				if (player.vaginas[0].vaginalWetness >= VAGINA_WETNESS_SLAVERING) outputText(", soaking her with girl-cum.", false);
				else {
					if (player.vaginas[0].vaginalWetness <= VAGINA_WETNESS_WET) outputText(", slicking her face with girlish cum.", false);
					else outputText(", drenching her with a deluge of girlcum.", false);
				}
			}
			else outputText(", and unloading a wave of hot spunk into her hair.", false);
			outputText("\n\nYou push her over, noting that her freed fingers immediately bury themselves in her demonic snatch, loudly squelching as she tends to her own arousal.  Her perfect visage is a mess, coated with musky girlcum", false);
			if (player.cocks.length > 0) outputText(" and a thick layer of spunk", false);
			outputText(".", false);
			outputText("\n\nYou turn away with a bemused sigh.  When you glance back, she has vanished!", false);
			dynStats("lus", -50);
			combat.cleanupAfterCombat();
			//doNext(roomBreakRoom);
		}
		public function dildoSuccubus():void {
			clearOutput();
			outputText("Your defeated opponent eyes you warily as you advance upon her, thrusting her chest forwards lewdly, with a hopeful gleam in her eye.  That gleam vanishes in sudden surprise when you stop and pull the oblong form of Tamani's dildo from your pouches.  The busty demon giggles happily, \"<i>I, like, love those things!  Those little sluts never let me keep one though!  Greedy bitches...</i>\"\n\n", false);
			outputText("The succubus spreads her fishnet-coated legs, exposing her moist vulva while she reclines against a table, beckoning you forwards.  Well, you certainly didn't expect her to be so willing, but you may as well go through with it!  You push up her tiny skirt for better access and position the toy for a perfect insertion. She begs, \"<i>Quit teasing me and just jam it in me already!  Honey, I just want to feel it stretch me while my hot little box drools all over it.  Would you mind giving my clitty a lick too?  It's aching for a touch.</i>\"\n\n", false);
			outputText("You see her button poking between her folds, far larger than the mortal women you've met, and you feel more than a little compelled to do as she's asked.   The toy slides in easily, though the further it penetrates her dark-blue cunt, the thicker it gets, and the more difficult it becomes to force it deeper inside.  Eventually you get it the entire way in.  The pair of you, demon and champion, watch together as her glistening cunt-lips are slowly forced apart, stretched wider and wider by the exotic dildo.  She giggles as you watch transfixed, and begins stroking her fingers all over her juicy outer folds while she asks, \"<i>Are you going to rape me or just stare at my cunt all day?</i>\"\n\n", false);
			outputText("Shaking your head and blushing ", false);
			if (player.cor < 50) outputText("in shame", false);
			else outputText("with lust", false);
			outputText(", you begin tracing your finger over her clit, smiling when it twitches.  It begins visibly growing every time you touch it, puffing up until it's nearly four inches of smooth purple succubus sex.   Glancing down further, you see her cunt stretched massively, the pink blob spreading her so wide it looks like any more swelling would dislocate her hips.  You give her clit a little squeeze and the succubus cums, noisily and happily.  Her clit spasms wildly, growing slightly bigger before beginning to wilt as the cunt-contractions force the dildo out.\n\n", false);  
			outputText("With a sodden 'plop', it hits the floor, revealing a gaping canal dripping with the dildo's pink aphrodisiacs.  The secretary-impersonating slut flops back, fondling her tits through her clothing as she languidly sighs, \"<i>Oooooh yeah those little cunts can make a good toy.</i>\"   She props herself up and begins touching her sex, holding open the gaped love-tunnel for you as she teases, \"<i>Yes, you've defeated me, like, for sure, mighty champion!  I don't think I'm capable of standing up to stop you! *Giggle*</i>\"\n\n", false);
			outputText("Good.  You pick up the toy ", false);
			if (player.cor > 75) outputText("giving it a long lick to taste the succubi's delicious flavor ", false);
			outputText("and put it away.  When you glance back towards the Succubus, she's gone, leaving you alone and horny...", false);
			dynStats("lus", (20 + (player.lib/5) + (player.cor/10)));
			combat.cleanupAfterCombat();
			//doNext(roomBreakRoom);
		}
		public function doLossSuccubus():void {
			clearOutput();
			if (player.cocks.length > 0) {
				if (player.lust >= player.maxLust()) outputText("Driven half mad with lust, you drop to your knees. Your fingers fly over your body as you pry off every last piece of your " + player.armorName + ", displaying just how hard your alluring opponent has gotten you.  The succubus saunters over, every sinuous step radiating the inhuman sexuality that pours off her skin like heat from a bonfire.\n\n", false);
				else outputText("Exhausted, you collapse before the succubus.  She effortlessly slices away your " + player.armorName + ", peeling your possessions away with practiced ease.  In moments you are stark naked and wholly exposed to your captor.  In spite of yourself, your body begins to respond to her sultry aura, displaying the hardness of your desire and shame immediately.\n\n", false);
				outputText("\"<i>Awww, did I get you all <b>HOT</b> and bothered?</i>\" She croons, poising a stocking clad foot above you as her high-heels seem to fade away.  Warm silk begins to press against your groin as slender toes curl around the head of your throbbing maleness, your foe having her way with your desire-saturated form.  You mewl pitifully at the sensation, your hips twitching involuntarily against her demonic sole. The slippery surface of her foot squeezes as she expertly strokes you with her foot, delighting in her complete dominance over your easily controlled member.\n\n", false);  
				//balls or pussy play
				if (player.balls > 0) {
					//[[balls]]
					if (player.ballSize < 6) outputText("Your sultry captor leans low over you, her luscious tits wobbling enticingly as she reaches down and caresses your " + player.ballsDescriptLight() + " with soft touches.  Almost immediately you feel them clench with boiling heat, growing heavy and churning with a load big enough to satisfy a thirsty succubus.", false); 
					//[[huge balls]]
					else outputText("Your sultry captor leans low, marveling at the size of your " + player.ballsDescriptLight() + " as she reaches down to caress them.  Her tits swing lewdly above you, bouncing in hypnotic motions. Her hands work gently, taking each one of your " + player.ballsDescriptLight() + " and hefting it gently.  Almost immediately you feel them fill with an unnatural heat that spreads everywhere her slender fingers touch.  They begin to feel full and heavy, practically sloshing as the pent up need inside you is channeled into liquid form.  \"<i>So ripe... and full,</i>\" she whispers to herself as she caresses them, her silken foot still sliding all over your " + player.cockDescript(0) + ", pumping stroke after stroke of pleasure into your lust-weakened form.", false);
				}
				else {
					//[[no balls no pussy]]
					if (player.vaginas.length == 0) outputText("Your sultry captor leans low over you, her luscious tits wobbling enticingly as she reaches down and caresses the skin between your " + player.cockDescript(0) + " and " + player.assholeDescript() + " with a slender finger.  Almost immediately you feel your groin clench with the boiling heat of a growing orgasm, thick cum churning out from your prostate as your body readies a load large enough to satisfy a thirsty succubus.", false);
					//[[no balls + pussy]]
					else outputText("Your sultry captor leans low over you, her luscious tits wobbling enticingly as she reaches down and caresses the slick skin of your slit with a single digit.  Other fingers circle your " + player.clitDescript() + ", teasing it from between the folds as it grows hard, peeking out from the hood and turning cherry-red.  Almost immediately you feel your groin clench with the boiling heat of a growing orgasm, thick cum churning in your prostate as your body readies a load large enough to satisfy a thirsty succubus.", false);
				}
				outputText("\n\n", false);
				//[[Cum]]
				outputText("The succubus licks her lips in anticipation as she curls her silk-clad toes tighter around you, making you bulge and twitch in obscene pleasure.  With a naughty smile, she caresses your ass with her bulbous demonic tail.  Before you can react, it plunges inside you, easily slipping through your " + player.assholeDescript() + " and pressing tightly against your prostate.  The suddenness pushes you over the edge, but she immediately wraps her fingers around you, pinching tightly, bottling your cum inside you.  You cry out in pain and surprise as your entire thick load is trapped inside you.  After nearly a full minute, your groin aches with the discomfort of it all.\n\n", false);
				//More cum paragraph.  HAHA! TINY BABY CUM! 
				outputText("She wastes no time, and caresses you again.  You instantly feel another surge of heat and desire as a fresh load of cum brews behind your first strangled orgasm.  You need to cum so bad, her foot still stroking and squeezing you full of perverted desire.  She slaps your ", false);
				if (player.balls > 0) outputText("balls", false);
				else outputText("ass", false);
				outputText(" as she releases your " + player.cockDescript(0) + ", shouting, \"<i>CUM!  Feed me!</i>\"  You are all too happy to oblige.  ", false);
				//[[normal volume]]
				if (player.cumQ() < 50) outputText("Freed at last, your body clenches tightly as it squirts the first jet of cum from your " + player.cockDescript(0) + ".  She smears her foot over the head, catching the cum and using it to lubricate her silken foot as it massages your member with merciless strokes, alternatively catching your spooge and milking more from your obedient maleness.  Your orgasm lasts many times longer than normal as your dual loads feed her demonic hunger.", false); 
				//[[big volume]]
				if (player.cumQ() >= 50 && player.cumQ() < 400) outputText("Freed at last, your body clenches tightly as it spurts a big glob of cum onto her waiting sole, soaking the bottom of her foot with slippery male-milk.  She smears her cum-covered foot over every inch of your " + player.cockDescript(0) + ", making each successive spurt bigger and messier than the last. Somehow she manages to catch more and more of your jizm over her foot, bathing you in cummy silkiness.  You groan helplessly as she milks more and more of from you till her foot is dripping steadily, your own groin and belly soaked with the stuff.  You give a few final exhausted squirts as she languidly rubs it into you.", false);
				//[[huge volume]]
				if (player.cumQ() > 400) outputText("Freed at last, your body clenches powerfully as a massive eruption of cum launches from your " + player.cockDescript(0) + " onto her waiting foot.  The succubus looks on incredulously as her entire foot is soaked with your sticky whiteness, forgetting to move as the second wave of cum drenches her to the ankle and rains down over your stomach.  She giggles and moves it back to your cock, massaging your slick spooge into your cock with her foot, wringing an even bigger explosion of cum from your tortured body.  Flopping back, she gets her other foot in on the action, milking you between her feet as you soak yourself completely with bigger and bigger eruptions until at last your orgasm begins to wane.  She slides forwards, rubbing against you and smearing the mess over herself with a blissful expression.", false);
				outputText("\n\n\"<i>Good boy,</i>\" she croons, mopping the cum up as it seems to wick into her stockings, \"<i>You'll do well once we get you on the line.</i>\"  You don't have time to ponder the significance of that as you lose consciousness.", false);
				//ONWARD TO BAD-END-IA!
				player.orgasm('Dick');
				doNext(getGame().dungeons.factory.doBadEndGeneric);
			}
			else {
				if (player.lust >= player.maxLust()) {
					outputText("Driven half mad with lust, you shake yourself free from the trappings of your " + player.armorName + ", first revealing your " + player.allBreastsDescript() + ", then " + player.hipDescript() + " and finally your ", false);
					if (player.vaginas.length > 0) outputText(player.vaginaDescript(0) + " as the last pieces fall away.\n\n", false);
					else outputText("bare groin as the last pieces fall away.\n\n", false);
				}
				//(HP loss)
				else outputText("You realize you're wobbling unsteadily, either from a blow to the head or blood loss, you can't be sure which.  In a display of sublime defiance, you manage to stay on your feet.  Though your tenacity does little good as your lightning-fast foe effortlessly undresses you, easily avoiding your clumsy and pain-addled movements.\n\n", false);  
				//START ZE RAPE
				outputText("The succubus steps away from you, withdrawing a tiny vial from a pocket in her vest.  She uncaps it with practiced ease, her outfit shifting into latex parody of a nurse's uniform as she attaches a small needle, completing the assembly of her injector.  \"<i>Like, don't worry about a thing hun, this will only hurt for a second,</i>\" she coos as she prances forwards, easily sinking the entire needle into your shoulder.\n\n\"<i>W-what did you do to me?</i>\" you manage to stammer.\n\n", false);
				outputText("She merely smiles and slips a delicately manicured finger under a rapidly disappearing skirt.  You ignore her crude display of wanton sexuality for the moment and try to focus on figuring out what the drugs did you, and what her needy slit smells like.  No, that wasn't it... you wanted to taste her nipples!  You shake your head and try to focus, but fail completely as the succubus lifts her sticky latex skirt, exposing her dripping snatch to you.  Your eyes lock on to the wondrous slut's fuckhole as her fingers tease you with glimpses between her folds every few seconds while she continues pleasuring herself.  With a flash of intuition, you realize what you were trying to think about:  finding something hard to penetrate that perfect hole with.  That little hungry snatch deserves to be filled with something throbbing and hard...\n\n", false);
				outputText("\"<i>OoooooOOOOH!  ...you're feeling it now are-AH AH YES-you dear?  Mmmmm yes, I bet this pussy is all you can think about.  I wonder if you can feel it-aaahhhhhhmmmm-yet?  This is always, like, the best part...</i>\" gasps out the succubus as she pleasures herself.  You wonder what she could be talking about as ", false);
				if (player.vaginas.length > 0) outputText("your " + player.clitDescript() + " parts your folds, growing harder.", false);
				else outputText("a fleshy growth erupts from your pale flesh, growing harder.", false);
				outputText("  In seconds you're playing with it, tugging the sensitive button as it fills up with more and more blood, growing bigger and harder than ever before.  Your legs give out as you begin stroking it with feverish intensity, barely registering as it grows to nearly eighteen inches in length, not noticing the increasingly veiny surface or different texture at the tip.  You force yourself to stop as a sudden truth asserts itself upon your consciousness - you need to shove your clit-like cock into a pussy.  You need to cum inside that hungry slut's blue spunk-receptacle.\n\n", false);
				outputText("You stand on shaky legs and lunge forwards, impaling the slutty nurse on your new tool with a violent animalistic passion.  Fucking her roughly, you lick her nipples to finally get the taste you've ached for.  Girl-cum squirts from the sloppy fuck-hole of the latex-nurse underneath you as you fuck her like a desperate animal.  She squeals with pleasure, splitting her legs wide apart to encourage your new maleness.  Your eyes roll back from the drug-enhanced pleasure of her dripping cunt as a male orgasm rocks your mind.  Mixed fluids splatter your pistoning hips as you do what you were always meant to do - feed and pleasure succubi.  Somehow your tool remains rigid and your hips continue plunging your new cum-spigot deeper and deeper into your mistress as the next orgasm begins to build inside your drug-addled mind, even as you black out.", false);
				player.createCock();
				player.cocks[0].cockLength = 16;
				player.cocks[0].cockThickness = 1.5;
				//[[[[To bad end!]]]
				player.orgasm('Vaginal');
				doNext(getGame().dungeons.factory.doBadEndGeneric);
			}
		}
		public function doLeaveSuccubus():void {
			combat.cleanupAfterCombat();
			//doNext(roomBreakRoom);			
		}
		
		public function doBadEndSuccubusPart1():void {
			spriteSelect(55);
			//Arousal
			outputText("In no time flat your blood begins to burn hot with the fires of unnatural lust.  ", true);
			//Tits – regular
			if (player.biggestLactation() < 1) outputText("Your " + player.nippleDescript(0)  + "s begin prodding painfully against your " + player.armorName + ", every touch serving to make them harder and more erect.  ", false);
			//Tits – lactating
			if (player.biggestLactation() >= 1 && player.biggestLactation() < 3) outputText("Your " + player.nippleDescript(0) + "s get painfully hard as you feel milk begin backing up inside your " + player.allBreastsDescript() + ".   The succubus glances down mischievously as her hands begin to grope you through your " + player.armorName + ", squeezing out a few drops of milk.  ", false);
			//Tits – megalactating
			if (player.biggestLactation() >= 3) outputText("Your " + player.nippleDescript(0) + "s get painfully hard as milk begins drooling down your over-productive chest, making your " + player.armorName + " slide across your leaky milk-spouts in an agonizingly pleasurable way.  ", false); 
			//Cock – single
			if (player.cocks.length == 1) {
				if (player.cockArea(0) < 30) outputText("Swooning from sudden blood loss, you struggle to maintain the kiss as your body takes your " + player.cockDescript(0) + " to full hardness in seconds.  ", false);
				//Cock – single big
				if (player.cockArea(0) >= 30 && player.cockArea(0) < 100) outputText("Nearly blacking out, you struggle to stay awake as your body shifts your blood to your disproportionate " + Appearance.cockNoun(CockTypesEnum.HUMAN) + ".  ", false);
				//Cock -megahuge
				if (player.cockArea(0) >= 100) outputText("As you struggle not to lose consciousness, you realize your over-aroused body had pumped most of your blood to your over-sized " + Appearance.cockNoun(CockTypesEnum.HUMAN) + ", which now droops to the floor, pulsing hotly.  ", false);
			}
			//DO MULTIZ
			if (player.cocks.length > 1) outputText("The feeling of light-headedness nearly robs you of consciousness as your " + player.multiCockDescript() + " fill with blood, pulsating with arousal as they reach full size.  ", false);
			//Vagooooz
			if (player.vaginas.length > 0) {
				//'uge clit
				if (player.getClitLength() >= 4.5) outputText("Popping from between your thighs, your " + player.clitDescript() + " responds to the sheer hotness of the situation by making itself known.   You squeeze your legs tightly together, hungry for additional sensation.  ", false);
				//big clit
				if (player.getClitLength() > 1 && player.getClitLength() < 4.5) outputText("A wave of pleasure erupts from between your legs as your " + player.clitDescript() + " pops free.    You squeeze your legs tightly together, hungry for the additional sensations.  ", false);
				//slick
				if (player.vaginas[0].vaginalWetness >= VAGINA_WETNESS_SLICK) outputText("Squishing wetly, your bottoms become soggy with the flood of fluids leaking from your " + player.vaginaDescript(0) + ".   Your legs spread apart on their own, begging for any kind of intrusion.  ", false);
				//normal
				else outputText("Groaning softly, you feel yourself getting wetter and wetter with arousal.  You wish your sticky bottoms were off so you could let something into your " + player.vaginaDescript(0) + ".  ", false); 
			}
			outputText("\n\n", false);
			//New PG
			outputText("No longer caring about modesty, etiquette, or even your own safety, you squirm against your bindings, lewdly putting on a display for your captor as you suck her tongue as if your life depended on it.   She breaks the kiss with a smile, \"<i>I told you I'd make sure it was pleasurable.  Now you sit tight while I get you hooked up, and we'll have you cumming what's left of your brains out in no time,</i>\" she promises.\n\n", false);
			outputText("The succubus pushes a button on the wall, and a number of strange looking suction tubes and hoses drop down from above you.   Moving with practiced efficiency, she hooks a ", false);
			if (player.breastRows.length == 1) outputText("pair of", false);
			else outputText("number of", false);
			outputText(" hoses to your breasts, ", false);
			if (player.cocks.length == 0) {
				if (player.vaginas.length > 0) outputText("and a vacuum pump to your clit.  ", false);
				else {
					outputText("and another vacuum pump to your bare groin.  In seconds a wet fleshy growth erupts.  You have grown a cock!  ", false);
					player.createCock();
				}
			}
			else {
				if (player.vaginas.length > 0) outputText("a vacuum pump to your clit, and a pump many times bigger than your " + player.cockDescript(0) + " to it.  ", false);
				else outputText("and a pump many times bigger than your " + player.cockDescript(0) + " to it.  ", false);
			}
			outputText("At first there is only a gentle suction, you assume in order to keep them in place.  Unfinished, your captor places something large and hollow against your backdoor", false);
			if (player.vaginas.length == 0) outputText(".", false);
			else outputText(" and an ever larger dildo against your " + player.vaginaDescript(0) + ".  It seems to pulse and wiggle with a life of its own rubbing the bumps of it's lumpy head against your lips.", false);
			outputText("  You swoon as you hear the solid click of a button being pushed, and all at once all devices attached to you leap to life.", false);
			doNext(doBadEndSuccubusPart2);
		}
		private function doBadEndSuccubusPart2():void {
			spriteSelect(55);
			outputText("The beautiful seductress that bound you giggles and says, \"<i>Oh it only gets better baby,</i>\" as she pushes another button.  You see a number of needles lower from the equipment above.  Two pause at chest height.  Faded parchment labels on the tubes mark them as \"Gro+\".  You spot the same markings on at least some the hoses gathering around your groin.  A few are marked with different labels, but you cannot make out the demonic script.  As one, the hoses rear back, then plunge forward, burying themselves into your supple flesh and injecting their drugged payload into your body.  It hurts at first, but the drugs fog your mind, blocking the pain with pulsing waves of desire.   You begin cumming as your body erupts with artificial pleasure.\n\n", true); 
			//Nipples
			outputText("The suction pulls squirt after squirt of milk from your breasts as your " + player.allBreastsDescript() + " start to grow, swelling heavier as they enlarge to produce more milk.  You squeal with delight as your nipples turn black, tainted by corruptive chemicals that are slowly dripped into you.  ", false);
			//Dick  
			if (player.cocks.length > 0) {
				outputText("The vacuum-pump on your cock noisily sucks down all your spoo, ", false);
				//High cum variant
				if (player.cumQ() > 300) outputText("struggling with the amount you put off.  Grinning, the succubus reaches over and flips a lever.  You feel the suction increase as the machine is turned up to accommodate your altered physique.  ", false);
				//else
				else outputText("the suction and drugs make it so easy to just keep cumming and cumming.  ", false);
				//either or:
				outputText("Dimly, you feel a needle lodged in your taint, pumping your prostate full of something.  Your " + player.cockDescript(0) + " begins growing mid-orgasm, the skin turning a deep purple even as small nodule-like bumps form all over it, rapidly becoming a bloated parody of it's demonic counterparts.  ", false);
			}
			//Puss Orgasmz
			if (player.vaginas.length > 0) outputText("Clenching tightly, your " + player.vaginaDescript(0) + " squeezes tightly on it's intruder as it's repeatedly violated by the machines.  ", false);
			//End
			outputText("\n\nThe world around you disappears, leaving you alone with the drug-enhanced sensations assaulting your body.  In truth, you don't want it to end.  You find yourself wishing it would never end, and no doubt the equipment you're hooked in to will see to that.\n\n", false);
			if (player.statusEffectv3(StatusEffects.Marble) == 1) {
				outputText("Later on, you are briefly pulled out of your reverie by a familiar warm fluid flowing down your throat.  You come to your senses and see Marble looking down at you with an odd expression on her face.  ", false);
				outputText("She seems to be in a state of bliss. Looking down, you see that she is wearing some kind of pair of pink panties.  Marble gasps and the surface of the panties ripples; it's a living thing!\n\nYou look around and realize you aren't alone.  ", false);
			}
			else if (player.hasStatusEffect(StatusEffects.CampMarble)) {
				outputText("You are given a brief moment of clarity as you see Marble standing in front of you.  ", false);
				outputText("She seems to be in a state of bliss. Looking down, you see that she is wearing some kind of pair of pink panties.  Marble gasps and the surface of the panties ripples; it's a living thing!\n\nYou look around and realize you aren't alone.  ", false);
			}
			else outputText("Later on, in a moment of clarity, you look around and realize you aren't alone.  ", false);		
			outputText("In rows alongside you are a large number of other captives, every single one endowed with freakishly sized breasts, and nearly all gifted with throbbing demonic dicks.  Some small analytical part of you notes that the farther down the line they are, the older and larger they have become.   You look down and see your own massive tits, shiny tainted nipples still pumping out streams of milk.  The huge throbbing demon-cock between your legs begins to get hard as the machines crank back up, filling you full of happy horniness.", false);
			if (player.statusEffectv3(StatusEffects.Marble) == 1 || player.hasStatusEffect(StatusEffects.CampMarble)) outputText("  With Marble here too, you'll be around for a long time.", false);
			getGame().gameOver();
		}
		
	}

}