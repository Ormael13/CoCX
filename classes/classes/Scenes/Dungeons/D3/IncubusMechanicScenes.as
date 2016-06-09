package classes.Scenes.Dungeons.D3 
{
	import classes.BaseContent;
	import classes.GlobalFlags.kFLAGS;
	import classes.StatusEffects;
	import classes.PerkLib;
	import classes.Scenes.Dungeons.Factory.IncubusMechanic;
	import classes.CockTypesEnum;
	import classes.PregnancyStore;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class IncubusMechanicScenes extends BaseContent
	{
		
		public function IncubusMechanicScenes() 
		{
			
		}
		
		// There's nothing to track if you just enter the Incubus' room in D1 and didn't approach him.
		// IF you approach him, then we can track that (either you fight, or you talk and give him an item)
		private function metIncubusMechanicInD1():Boolean
		{
			if (flags[kFLAGS.FACTORY_INCUBUS_DEFEATED] > 0 || flags[kFLAGS.FACTORY_INCUBUS_BRIBED] > 0) return true;
			return false;
		}
		
		private const MECHNIC_NO_SELECTION:int = 0;
		private const MECHANIC_PAID:int = 1;
		private const MECHANIC_SUCKED:int = 2;
		private const MECHANIC_FOUGHT:int = 3;
		
		private const MECHANIC_KILLED:int = 1;
		private const MECHANIC_RELEASED:int = 2;
		private const MECHANIC_FUCKED:int = 3;
		private const MECHANIC_FUCKED_YOU:int = 4;
		
		public function meetAtElevator():void
		{
			if (flags[kFLAGS.D3_MECHANIC_LAST_GREET] == MECHNIC_NO_SELECTION)
			{
				outputText("\n\nA");
				if (metIncubusMechanicInD1()) outputText(" familiar,");
				outputText(" demonic mechanic lounges against a gleaming, metallic control panel");
				if (flags[kFLAGS.FACTORY_INCUBUS_BRIBED] > 0) outputText(", a rolled-up hentai magazine tucked neatly into the chest-pocket of his overalls");
				if (metIncubusMechanicInD1()) outputText(". This is the same incubus you met back in the factory! He still sports his familiar, stained coveralls, and the crotch is as torn as ever, revealing a cock that looks like an odd hybrid of a tentacle, a bumpy demon-dong, and a stinger-ringed anemone cock. While you watch, it idly divides into two... four... eight narrow, writhing tendrils before merging back together into a three-inch-thick monster-cock.");
				else outputText(". He sports a pair of stained coveralls, with the crotch torn open, revealing a cock that looks like an odd hybrid of tentacle, a bumpy demon-dong, and a stinger-ringed anemone cock. While you watch, it idly divides into two... four... eight narrow, writhing tendriles before merging back together into a three-inch-thick monster-cock.")
				outputText(" It stiffens under your ocular attentions, and a timeless voice with the smoothness of silk, yet an undercurrent of rumbling gravel calls, \"<i>Eyes up here, Champion.</i>\"");

				outputText("\n\nScowling a little at being caught so openly studying his erection, you level your gaze at the haughty incubus.");

				outputText("\n\n");
				if (metIncubusMechanicInD1()) outputText("\"<i>Once more, you bumble");
				else outputText("\"<i>You've bumbled");
				outputText(" into a hornet's nest, none the wiser for your previous experience. Did you expect not to get stung? Did you expect that you'd simply meander up to the queen without being torn apart by her loyal drones?</i>\" He smirks at the word 'drone,' one corner of his mouth twisting in a way that stretches his infernal face into a handsome, sardonic smile. Smiling wider, he admits, \"<i>Well, you did get this far, and I'd rather not risk bruising my fantastic body in a fight, so how about this: I let you ride the lift down to safety, and you suck my cock - or give me 500 gems, I guess.</i>\"");

				outputText("\n\nHe's offering you a deal?");

				outputText("\n\nThe incredulity must be plain on your [face], because his smile parts with an edge of worry. \"<i>Listen, I just like to get paid, slack off, and fuck. I'd rather not risk my life if I can help it. So how about it? You get a safe exit, and I get my dick sucked... or get a little richer, maybe.</i>\"");

				outputText("\n\nThe mechanic doesn't seem like he'd stop you from turning around and walking back into the complex, but if you want to use the lift, you're going to need to accede to his demands or fight him. What do you do?");

				// [Pay Toll] [Suck Dick] [Fight]
				if (player.gems >= 500)
				{
					addButton(0, "Pay Toll", payDaToll);
				}
				else
				{
					outputText("\n\n<b>You do not have enough gems to pay the required toll!</b>");
				}

				addButton(1, "Suck Dick", suckIncubusDick);
				addButton(2, "Fight", startCombatImmediate, new IncubusMechanic());
			}
			else if (flags[kFLAGS.D3_MECHANIC_LAST_GREET] == MECHANIC_SUCKED)
			{
				outputText("\n\nAs soon as the incubus mechanic spots you approaching, his wriggling, exotic cock settles slightly, growing longer and thicker in anticipation. The demonic, corrupted nubs that encircle its girth pulsate as the whole of his dong floods with arousal, and you cannot help but imagine the feel and taste of it on your tongue once more, the corrupted flavor making your mouth salivate with such intensity that you're forced to swallow to keep yourself from drooling all over yourself. Why is his dick so goddamn delicious?");
				
				outputText("\n\nThe grinning demon offers, \"<i>If you want to use the lift, you'll need to pay the toll.</i>\" He strokes himself enticingly, no longer offering you a more standard form of payment; only the musky aroma of his tumescent cock.");
				
				outputText("\n\nIt appears that your only options are to walk away, suck his cock, or fight him.");

				dynStats("lus", 10);
				
				addButton(1, "Suck Dick", suckIncubusDick);
				addButton(2, "Fight", startCombatImmediate, new IncubusMechanic());
			}
			else if (flags[kFLAGS.D3_MECHANIC_LAST_GREET] == MECHANIC_PAID)
			{
				outputText("\n\n\"<i>Back again?</i>\" the incubus queries while he reclines against the softly thrumming machinery. \"<i>I was just calibrating my baby here. Now she purrs like a kitten.</i>\" He affectionately pats the metal devices that power the lift. \"<i>If you want to use her, you're going to need to pay up, [name]. 500 gems seems fitting recompense, but between you and me, I'd rather have you on your knees polishing my python here.</i>\" The mechanic's cock suddenly rears up, swaying back and forth in a decidedly snake-like motion, the light glistening off his purple-hued pecker as it stiffens encouragingly.");

				outputText("\n\nThe very air seems to thicken with the scent of it. His musky aroma is powerful and potent, and you nearly comply with the latter portion of his request before common sense surfaces.");

				outputText("\n\nDo you leave, pay him for the lift, suck his dick, or just fight him and be done with it?");
				
				dynStats("lus", 10);

				if (player.gems >= 500)
				{
					addButton(0, "Pay Toll", payDaToll);
				}
				else
				{
					outputText("\n\n<b>You do not have enough gems to pay the required toll!</b>");
				}

				addButton(1, "Suck Dick", suckIncubusDick);
				addButton(2, "Fight", startCombatImmediate, new IncubusMechanic());
			}
			else if (flags[kFLAGS.D3_MECHANIC_LAST_GREET] == MECHANIC_FOUGHT)
			{
				addButton(0, "Lift", useLiftPostDefeat);
			}
		}
		
		private function payDaToll():void
		{
			flags[kFLAGS.D3_MECHANIC_LAST_GREET] = MECHANIC_PAID;

			clearOutput();

			player.gems -= 500;
			statScreenRefresh();
			outputText("\n\nYou unceremoniously fill a small pouch with 500 gems and toss it to the incubus.");

			outputText("\n\nHe lamely says, \"<i>You know, I wasn't really serious about the gems. Are you sure you don't want to suck my dick instead?</i>\" The demon offers you your bag full of money back.");

			outputText("\n\nYou shake your head. If you wanted to suck his dick, you would've said so. \"<i>A deal is a deal.</i>\"");

			outputText("The male sighs. \"<i>Fine, fine. You've gotta run out of gems sometime anyway, right?</i>\" You smirk and step onto the platform, chuckling at the incubus as his visage vanishes behind the lip of a sheer cliff. There's a railing to hold onto as you're lowered down to the mountains. While the platform does rock from side to side along the slow trip down, its motions are not erratic enough to put you in any significant danger. Even better, you aren't bothered by a single harpy along the way. This section of the high mountains seems to have been cleansed of them.");

			outputText("\n\nThe platform touches down roughly thirty minutes after your departure, and you head back to camp with all due haste.");

			doNext(getGame().d3.exitD3);
		}
		
		private function useLiftPostDefeat():void
		{
			clearOutput();
			outputText("You spend a minute or two fiddling with the lift controls, trying to understand how, exactly, to control the contraption. When you think you've got a handle on the system, you tug on a lever with authority and hastily step onto the platform.");
			outputText("\n\nThere's a railing to hold onto as you're lowered down to the mountains. While the platform does rock from side to side along the slow trip down, its motions are not erratic enough to put you in any significant danger. Even better, you aren't bothered by a single harpy along the way. This section of the high mountains seems to have been cleansed of them.");
			
			outputText("\n\nThe platform touches down roughly thirty minutes after your departure, and you head back to camp with all due haste.");
			
			doNext(getGame().d3.exitD3);
		}
		
		public function suckIncubusDick():void
		{
			flags[kFLAGS.D3_MECHANIC_LAST_GREET] = MECHANIC_SUCKED;

			clearOutput();
			
			if (player.gems < 500) outputText("You spare a glance to your depleted pouches and admit, \"<i>I guess I'll suck your dick then.</i>\"");
			else outputText("You shrug and smile. \"<i>I guess now is as good a time as any to suck some dick, huh?</i>\"");

			outputText("\n\nStiffening further at your declaration, the demon agrees. \"<i>It's probably the best idea you've had since coming through the portal. Come on then.</i>\" He slumps down against a bare spot on the console, edging his narrow hips forward to place his large cock at the perfect height for you to kneel and pleasure. \"<i>It ain’t gonna suck itself.</i>\"");

			outputText("\n\nScowling a little, you go ahead and get down off your [feet], bringing your [face] level with the pulsating, sexual monstrosity that seems to be growing larger by the second. This close, you can make out every fast-pumping vein. His tumescent crown pulsates, the helmet thickening and darkening with pleased engorgement. The demonic nodules that line the head fill, becoming more distinct: so hard, sensitive, and ready to stimulate you with their exotic texture.");
			if (player.hasVagina())
			{
				outputText(" You find your crotch becoming");
				if (player.wetness() <= 2) outputText(" even more soaked than normal");
				else if (player.wetness() <= 4) outputText(" wet with fresh lust");
				else outputText(" sticky with lust")
				outputText(" at his masculine scent and appearance.")
			}
			else if (player.hasCock())
			{
				outputText(" You feel a heady, turgid warmth growing in your own crotch, mirroring the ardor displayed by the cock you're about to service.");
			}
			outputText(" A patch of neatly trimmed pubic hairs lead up his abdomen to a set well-defined muscles, half-hidden under his loose not-so-coveralls.");

			outputText("\n\nIt's so close, you could just reach out... and touch it. Your hand is so close now, stretching out, fingers trembling while your other hand fidgets nervously at your belly. Your nostrils flare as you drag in a fresh breath of his pheromones, and your lips part. Your tongue slips out, licking to moisten them. A good blowjob needs lubrication, after all. Eyes crossing to watch the stiff shaft, you press your tongue to the underside, sampling its slightly salty flavor, the taste of skin and sweat intermingling into a potent, undeniably masculine flavor. It bounces on your taste buds, oozing out a stream of clear, sweet fluid.");

			outputText("\n\nA hand rubs through your [hair], and an affectionate voice encourages, \"<i>Ohhhh, that hits the spot.</i>\" With the corners of your mouth curling upward excitedly, you close your lips around that heady member, just behind the nubby tips, slipping down its length slowly, letting it ooze its pre-ejaculate in a line down the center of your tongue on its way into your throat. You get about four inches before pulling back, gasping in a quick breath and swallowing his juice. It's so delicious that you find your tongue slipping back out to circle the head, lapping up the excess from his crown; it truly does seem to be a crown with the way the nubs adorn its perimeter, protruding like ornamental designs for your tongue to weave and slide around, sloppily polishing each to a mirrored spit-shine.");

			outputText("\n\nThe incubus sighs, slouching a bit lower in his impromptu seat, his hooved feet spreading a little wider to allow you better access. \"<i>Now this is the life,</i>\" he muses, with an affectionate pat. The very air around him seems to thicken, making it harder to breathe. You find yourself taking big, deep breaths just stay comfortable. The scent his partially polished rod exudes seems just so... potent, headier than it was a moment ago, and you sway drunkenly, tongue hanging out. Gods, you want to taste him!");

			outputText("\n\nYou lean in toward him once more, taking the incubus's first four inches in with almost feverish eagerness, his throbbing thickness filling your mouth with its sinful heat, leaking its sticky lust into your throat. You whimper and move forward a bit, slowly pushing the head of his cock towards your throat. It would normally be difficult to take so much dick into your mouth, but he slides in easily. He's so wet and slick with spit. So very slippery. He doesn't bother your gag reflex at all, honestly. It’s like his cock was meant to fill your face, to slip through your lips and touch to your throat... to slide into your tight, constricting esophagus. You gulp another inch in, drawing him into your throat. It's so easy that you begin to do it almost reflexively, swallowing inch after inch of dripping demon cock.");

			outputText("\n\nNo matter how many times you do it, there always seems to be more dick just waiting to fill your face, and it's getting thicker every time. The pulsating nodules scrape your tongue and cheeks as they slide past. Your jaw stretches around its throat-filling passenger, struggling with the increasing thickness. A heat is building in your belly, separate from the fires of arousal that rage in your loins. So pleasant and yet so right, that warmth spreads more and more, and it takes you a little while to realize that the incubus must be releasing quite a lot of pre to fill you so. With a mighty push, you thrust yourself forward until balls rest on your chin and your nose is buried in the demon's pubes. You hold the pose for a bit, extending your tongue to slather the mechanic's balls in spit, wanting him to feel how completely you've taken him, to revel in the tightness and shameful eagerness his cock has excited in you.");

			outputText("\n\nAfter a few breathless moments, you start to let him out, sliding back, dragging those nodules over your tongue. His head swells inside you, making the parting a little more difficult and leaving a trail of cockslime down your throat. Once nearly a foot of cock is glistening in the air, you realize just how long he's become. The swollen tip emerges from your throat, and you lick it with your tongue as it passes, gathering a huge, cheek-bulging batch of pre-cum in your mouth as it exits.");

			outputText("\n\nYou grab him by the balls with one hand and start to jack him off with the other, your spent spit starting to froth and bubble from your vigorous jacking. You swallow and start gasping, trying to catch your breath after holding it during the quality deepthroating, only hungry for oxygen so that you can take him again without worrying about passing out on his gloriously sensual phallus. You can taste him everywhere: in your mouth, in your throat, and even coating your teeth.");

			outputText("\n\nNuzzling the incubus's sloppy cock, you grind your cheek on the head, letting it mark you with its leaky fuck-slime. Gods above, it's so hot and wet and right. You can't take it anymore! Yanking it over, you jam it back in your mouth and swallow it with practiced ease, gobbling the immense cock, now so thick that its whole length makes your jaw creak as it passes through your 'o'-ring of a mouth. It slips and slides on the lubricant it left behind last time, and in no time flat, you're back to nuzzling his pubes and licking his balls. This time, you don't content yourself with that.");

			outputText("\n\nYou wrench your head back, dragging eight inches of corrupted fuck-pole out of your slippery throat, and slam your face back into his abdomen, fucking his twitching demon-cock with your eager mouth and tight throat. You bounce right back off to repeat the action again. Spit is flying from the corners of your mouth; your belly is now nearly filled with drizzling pre-seed, and the cock is convulsing in your lips so hard that it may as well be having a seizure. The incubus's grip, once calm and reassured, has gone shaky and uncertain. His hips twitch wildly, and he moans, \"<i>Ohhhhh... ready, slut?</i>\"");

			outputText("\n\nYou would nod if you weren't so busy face-humping the demon's sexy groin. He doesn't seem to care one way or the other, because you see his balls twitch in his sack and lift, tightening snugly against his crotch as they churn and unload. Not a split-second later, you feel the whole of his rod thicken, fat with undelivered cum. The nodules dig into the walls of your throat, and your belly abruptly gurgles, rounding a little from the sheer volume of incubus batter your gut was just inseminated with. A second surge follows an instant later, pressurizing your stomach with spunk. You're so stuffed with spooge that three inches of cock slide back out your mouth, and when the third pulse of jism fires, it pushes him the rest of the way out, filling your esophagus as it exits. The fourth bulges your cheeks before the still-shooting crown escapes your lips and paints your face. You cough and sputter, spunk spraying over your [chest] as you catch your breath. Rope after rope of alabaster goo splatters across your hair as the incubus finishes cumming.");
			player.refillHunger(80);
			outputText("\n\nYou both sag back, sated in entirely different ways. He looks more than a little drained, shuddering in bliss and gasping, \"<i>I, ung... I was a little pent-up.</i>\" In spite of that, his balls begin to swell up almost immediately, becoming a little bit larger than they were a moment ago. You have a hunch that if you sucked him again, he'd cum just as hard, and while the thought sends a shiver of pleasure through your well-stuffed body, you remember that you wanted to get back to camp.");

			outputText("\n\nStumbling onto the elevator, you cradle your cum-pregnant middle and gesture for him to lower you. He does so, a smile that would shame a cheshire cat plastered on his face as he disappears behind the lip of a cliff. <b>Damn, that was hot.</b> You wind up masturbating most of the way down the elevator before stumbling into your camp as a pent-up, sexually fixated wreck.");

			dynStats("lib+", 5, "cor+", 5, "lus+", 100);

			doNext(getGame().d3.exitD3);
		}
		
		public function beatDaMechanic(hpVictory:Boolean):void
		{
			flags[kFLAGS.D3_MECHANIC_LAST_GREET] = MECHANIC_FOUGHT;

			clearOutput();
			outputText("The mechanic collapses, his overalls");
			if (hpVictory) outputText(" falling off his prone form, shredded.");
			else outputText(" hanging open as he reaches down for his exposed, dangling cock to wildly masturbate.");
			outputText(" He seems surprisingly human like that, just as mortal as anyone. You could let him go, play with him some, or cleanse the world of another demon.");

			menu();
			addButton(0, "Kill", killMechanic);
			addButton(1, "Let Go", letMechanicGo, hpVictory);
			if (player.hasCock()) addButton(2, "Buttfuck", buttfuckTheMechanic, hpVictory);
			if (player.hasVagina()) addButton(3, "Ride Cock", rideMechanicsCock);
		}

		private function killMechanic():void
		{
			flags[kFLAGS.D3_MECHANIC_FIGHT_RESULT] = MECHANIC_KILLED;
			clearOutput();
			outputText("He proves blessedly easy to kill, and you roll the body off the cliffs to avoid alerting any of Lethice's other ilk.");
			combat.cleanupAfterCombat(getGame().d3.resumeFromFight);
		}

		private function letMechanicGo(hpVictory:Boolean):void
		{
			flags[kFLAGS.D3_MECHANIC_FIGHT_RESULT] = MECHANIC_RELEASED;
			clearOutput();
			outputText("Feeling merciful, you point off the side of the cliff. <i>\"Leave this place and never return. If you do, I might have to kill you. I'd rather not shed any more blood than necessary, but I will do what I have to in order to cleanse this land. Leave and never return. Maybe you can find your own peace without driving everything around you to corruption.\"</i>");

			outputText("\n\nThe incubus");
			if (hpVictory) outputText(" slowly struggles to his feet");
			else outputText(" reluctantly stops masturbating");
			outputText(", nodding. His skin cracks as two leathery wings unfurl. <i>\"If that's how it has to be.... For what it's worth, I hope you win. Lethice is a bitch.\"</i> Slowly walking towards the cliff, he beats his wings and lifts off the ground. \"<i>Come visit me sometime. Maybe I can show you a good time as thanks.</i>\"");
	
			outputText("\n\nThe incubus mechanic flies away for good, though you can’t can say whether he will wreak havoc or live quietly.");

			combat.cleanupAfterCombat(getGame().d3.resumeFromFight);
		}
		
		private function buttfuckTheMechanic(hpVictory:Boolean):void
		{
			flags[kFLAGS.D3_MECHANIC_FIGHT_RESULT] = MECHANIC_FUCKED;

			var x:int = player.cockThatFits(200);
			if (x == -1) x = 0;

			clearOutput();
			outputText("\n\nThe incubus may have done his best to seduce you with his");
			if (!hpVictory) outputText(" throbbing hard");
			else outputText(" gently bobbing");
			outputText(" dick, but you've got a better idea. You got more than one look at the curvature of his butt while you were fighting, tempting your burgeoning bulge to the point of distraction. You hastily remove your [armor] and smile. [EachCock] springs up, full and hard. You take");
			if (player.cocks.length > 1) outputText(" one");
			else outputText(" it");
			outputText(" in hand, pumping slowly as you eye your tainted prey. He whimpers");
			if (hpVictory) outputText(" in need, and");
			else outputText(", but");
			outputText(" his cock seems to get even bigger and harder. The poor guy doesn't realize what a reaming he's in for.");
	
			outputText("\n\nGrabbing hold of him by the denim of his overalls, you forcefully lift and twist, forcing him onto his hands and knees. His tail limply thrashes and finds its way around your waist, as if feigned affection could somehow improve his position. It doesn't make a difference to you. You give his taut sack a playful flick, making him wince, and grab the edges of his crotch hold. With a mighty yank, you tear the offending hole open into a revealing chasm. The incubus' pucker clenches as it's exposed to air. It looks tight enough to pleasure a toothpick.");

			outputText("\n\n\"<i>Wouldn't you rather I fuck you?</i>\" he offers, a last-ditch attempt to sway you from your current course.");

			outputText("\n\nSmack! Your hand falls across his purple ass. A reddish handprint slowly blossoms there. You give his bubbly boy-butt a few more swats for good measure, admiring the way his ass practically glows from your attentions. The demon is close to tears, but his cock is more erect than ever. It's practically stabbing into his chest with how hard it is, and the tip is weeping long strands of pre-cum onto the floor. It appears your choice of fucktoy has a masochistic side. Good for him; it'll make what's coming a little more pleasant for him.");

			outputText("\n\nYou grab [onecock] with one hand and the incubus' waist with the other. Your heart is hammering in anticipation. Growling in the back of your throat, you align");
			if (silly()) outputText(" tab C with slot buttfuck");
			else outputText(" your eager tool with the corrupted anus");
			outputText(" and steadily push. At first, his asshole shuts you out. The sphincter is just too tightly clenched for anything, let alone something so full and thick, to fit inside. You give up on the push and begin rocking your [hips] back and forth, getting his soon-to-be-stretched hole used to the idea of having you inside him. A droplet of pre-cum escapes your " + player.cockHead(x) + " as you work, smearing over him.");

			outputText("\n\nThe incubus's now-slickened pucker quivers, and that's all the opening you need. Your " + player.cockHead(x) + " slips in during a moment of looseness. In that second, you turn his crinkly rosebud into a smoothly stretched o-ring. The incubus moans, though whether in pleasure or pain, you cannot tell. You slap his ass and feel him clamp down on you with renewed vigor, briefly arresting your progress, but he can't squeeze that hard all the time. His asshole relaxes after a few seconds and lets another inch in.");
			
			outputText("\n\n\"<i>Just relax and let it happen,</i>\" you instruct as you slowly squeeze another inch inside him. The incubus' insides are just so... so tight around your length and so warm compared to the outside air. You lean down over him, listening to him grunt, enjoying the feel of his entrance slowly slackening as he obeys. A huge blob of pre or cum (you can't be sure which) splatters into the growing puddle below him as your " + player.cockHead(x) + " inexpertly milks his prostate. The incubus shakes from head to toe, and you feed yourself in to the halfway point.");

			outputText("\n\nYou enjoy the muscular tightness of the demon's tainted anus for a moment, but he has ideas of his own. An inch of cock vanishes inside him, pulled inside by contractions a human could never manage. Gods, it feels good, and he's just getting started. He's pulling you inside him like some kind of sucking vacuum, drawing the entirety of your length inside him in seconds. You gasp, barely having the presence of mind to paddle his rosy asscheeks for his disobedience, but that only encourages him. Muscular ripples roll around your " + player.cockDescript(x) + " in a way that conjures up the image of the inside of a tornado - a suckling, insatiable vortex that's twisting and stroking until it pulls everything inside it.");

			outputText("\n\nThe demon has the audacity to smile back over his shoulder at you. \"<i>You didn't honestly think I wouldn't find the pleasure in a little buttlove, did you?</i>\" He smirks and squeezes you so expertly that you feel ready to explode.");

			outputText("\n\nNo! He's not going to win, even if him 'winning' is just making you cum into his asshole. You put your hands on his near-bruised bottom and pull away, struggling with all your might to extract your " + player.cockDescript(x) + " from his hungry asshole. It's slow going, and tremendously pleasurable, but you manage to extract yourself with a noisy 'schliiiiiiiiick' that never seems to end. When you finally pop your " + player.cockHead(x) + " out, you adjust your positioning and thrust with all your might, slapping your [hips] into his curvy backside with enough force to audibly slap. You hear the echo of your dominance rebound off the walls of Lethice's fortress, washing over her prone lieutenant.");

			outputText("\n\nYou can actually feel your " + player.cockHead(x) + " nearly mashing his prostate flat as it grinds past. Shuddering, the incubus loses his focus, and his butthole slackens. You don't give him a chance for a second wind, bouncing back off and immediately starting your next thrust. Your hold is firm, and your strokes sure. His ass bounces beautifully with each prick-hilting slam against it. Down below, the demon's nubby phallus is bobbing back and forth like a pendulum, practically pissing out streams of pre-cum each time you bottom out. He's getting awful close, and all he can do is gasp and drool.");

			outputText("\n\nSwitching to a one-handed grip, you lavish him with more swats and slaps, paddling one side, then the other, raining blows down upon his crimson cheeks in between punishing thrusts. His asshole feels looser with each stroke, more like a personal, well-used onahole. You can't wait to finish and watch your cum drizzle out of his gaped entrance.");

			outputText("\n\n\"<i>S-slow down,</i>\" the demon stutters between shudders of pleasure.");

			outputText("\n\nYour own pleasure rising, you start fuck him even faster. \"<i>No.</i>\"");

			outputText("\n\nThe incubus's dick-flopping diminishes as it begins to properly engorge once more, aiming higher with each beat of the demon's heart as he nears his orgasm. You push him down a bit so that your " + player.cockDescript(x) + " will press more powerfully across his prostate, panting from your own exertion. It's enough. The demon mewls out a long, high-pitched moan and erupts, painting a line of white up his overalls all the way to his chin. The next blobs of cum splatter off his chin. Each new ejaculation seems a little larger than the one before. You're doing your best to milk him from behind, and he's doing his best to whimper like a bitch and paint his face. A smile breaks across your face. It's more than a fair trade.");

			outputText("\n\nEventually, the spent demon finishes, dribbling semen so weak that it's practically clear into a salty puddle between his knees. You don't slow or stop. In fact, your " + player.cockDescript(x) + " feels bigger and harder than it was a few seconds. The velvety folds of the demon's pre-slickened asshole are caressing you wonderfully, slowly egging you towards a climax of your own. You fuck him hard enough to knock him off-balance, dropping his cheek into his own spooge-puddle. Then, you cum, flooding your toy's asshole with its reward for a job well done.");

			////Low cum exit
			if (player.cumQ() <= 250)
			{
				outputText("\n\nYou pull");
				if (player.hasKnot(x)) outputText(", popping your knot");
				outputText(" out after depositing your meager load into your demonic fuck-hole. One slick strand of creamy spunk is leaking out over the demon's ballsack.");
			}
			//Medium cum exit
			else if (player.cumQ() <= 1000)
			{
				outputText("\n\nYou pull");
				if (player.hasKnot(x)) outputText(", popping your knot");
				outputText(" out of the demon's creampied fuck-hole with a smile. His stretched-out ass looks virtually glazed with cum, and you can see small rivers of it trickling down over his balls and slowly shrinking cock.");
			}
			//High cum exit
			else if (player.cumQ() <= 2500)
			{
				outputText("\n\nYou pull");
				if (player.hasKnot(x)) outputText(", popping your knot");
				outputText(" out of the demon's well-fucked asshole with a smile. As soon as the bulk of your dick unplugs him, a river of white spills out, washing over his balls and cock to drip down into his puddle. You smirk at the white-glazed demon. His butt is still full of your spunk.");
			}
			//Huge cum
			else
			{
				outputText("\n\nYou pull");
				if (player.hasKnot(x)) outputText(", popping your knot");
				outputText(" out after depositing a massive, belly-bulging load directly into the demon's guts. A tidal wave of goo bursts out of his over-pressurized asshole to fall on the ground, and as it dies off, small rivers of ivory spunk escape the lake in his ass to run down his balls and cock. His belly is");
				if (player.cumQ() <= 5000) outputText(" pudgy");
				else if (player.cumQ() <= 10000) outputText(" swollen");
				else outputText(" absolutely gravid");
				outputText(" with the distended weight of the cum packing his body. From time to time, fresh streamers of sperm squirt out of his thoroughly cream-pied backdoor.");
			}

			//No new paragraph
			outputText("The incubus slumps down into the puddled semen, gasping in exhaustion.");

			outputText("\n\nYou wipe your " + player.cockDescript(x) + " off on his practically glowing bottom before turning to re-dress. When you turn back, he's gone, though a trail of white drops indicates the direction of his flight. It looks like he fled towards the cliff, perhaps growing wings. Oh well, that's one less obstacle between you and Lethice.");

			player.orgasm();
			dynStats("cor+", 5);

			combat.cleanupAfterCombat(getGame().d3.resumeFromFight);
		}
		
		private const MECHANIC_DEMON_COCK:int = 0;
		private const MECHANIC_HORZ_GOG:int = 1;
		private const MECHANIC_DOG_COCK:int = 2;
		
		private function rideMechanicsCock():void
		{
			flags[kFLAGS.D3_MECHANIC_FIGHT_RESULT] = MECHANIC_FUCKED_YOU;

			clearOutput();
			outputText("Well, he does have quite the thick, throbbing piece of male genitalia on display for you.... There's no sense in letting a good cock go to waste, right? You stalk over to him, looming over the defeated demon with a predatory grin. Your tongue flicks out to lick your lips. Meanwhile, your lower ones go suddenly and irrevocably slick, excited and instantly ready for a helping of thick demon-cock. Your [vagina] is getting warmer and warmer as you tease the poor demon, leaving him to wonder if you're going to kill him or fuck him. The worry is as obvious on his face as the upraised tumescence that jabs spear-like out from his crotch, aimed straight at you.");

			outputText("\n\nAbruptly, you drop your [butt] down on top of him, sitting square on top of his chest");
			if (player.tailType != 0) outputText(", tail draped across his face");
			outputText(", and casually begin to undress. Looking over your shoulders, you see hope in his soulless eyes. You tease, \"<i>I wouldn't want to stain my clothes when I finish you off, would I?</i>\" His dick wilts a little at that, and he looks about to faint. Giggling, you toss aside your [armor] and grab hold of his mostly-hard cock, feeling the corrupted, textured nodules that encircle his shaft flaring up at your gentle squeeze. He firms up nicely in your grip, filling back to a pulsating, rigid hardness in seconds.");

			outputText("\n\n\"<i>Hey, you can transform your dick, right?</i>\" you call over your shoulder.");

			outputText("\n\nThe demons voice comes back as a dry, irritated rumble. \"<i>That and more, mortal. Would it please you to shape my cock for your pleasure?</i>\"");

			if (player.findPerk(PerkLib.BimboBrains) >= 0 || player.findPerk(PerkLib.FutaFaculties) >= 0) {
				outputText("\n\nGiggling, you answer, \"<i>Like totally! Let's give you a cock makeover!</i>\"");
			}
			else {
				outputText("\n\nNodding and languidly stroking his fantastically useful phallus, you answer, \"<i>Maybe. I still haven't decided what to do with you.</i>\"");
			}

			outputText("\n\nWhat kind of dick would you like the incubus to have when you fuck him?");
		
			// [Demon] [Horsecock] [Dogcock]
			menu();
			addButton(0, "Demon", rideMechanicsCockII, MECHANIC_DEMON_COCK);
			addButton(1, "Horse", rideMechanicsCockII, MECHANIC_HORZ_GOG);
			addButton(2, "Dog", rideMechanicsCockII, MECHANIC_DOG_COCK);
		}
		
		private function rideMechanicsCockII(cType:int):void
		{
			flags[kFLAGS.D3_MECHANIC_COCK_TYPE_SELECTION] = cType;

			clearOutput();

			//Demon first:
			if (cType == MECHANIC_DEMON_COCK)
			{
				outputText("Giving the incubus's sweaty cock an affectionate squeeze, you decide, \"<i>I think I like this just the way it is.\"</i> With your hand, you cup his balls and tenderly stroke his surprisingly smooth, supple sack for emphasis, rewarding him for not struggling any further. He moans and releases a dollop of pre-cum from his tip, coating his own glans is liquid excitement. Around his swollen crown, the bumps flare and expand out to reach their full size. You can't help but wonder what it would feel like to have his dick inside you, pulsating, sliding, and dragging its many stimulating knobs all over your slick, sensitive inner walls.");
			}
			//Demon first:
			else if (cType == MECHANIC_HORZ_GOG)
			{
				outputText("Giving the incubus's sweaty tool an affectionate squeeze, you decide, \"<i>Make it a horse-cock. If I'm going to play with you, I want you to have the biggest, strongest, most inhumanly virile cock to put inside me.</i>\" He starts twitching and leaking pre-cum halfway through your explanation.");
				outputText("\n\nA little breathlessly, the incubus says, \"<i>And so, the predator becomes the accommodating servant. Your wish is my command.</i>\" He closes his eyes and focuses, dick lurching hard enough to wrench itself out of your grip. It shrinks downward, the skin at its base bunching up, fold after fold. You didn't want him to get smaller! The surface of the miniature demon-cock smoothes to become fleshy and mottled, patterned black and pink. Its human-like glans flattens out as if it was being stepped on, widening until its blunt tip hangs over the edges of his tiny shaft.");
				outputText("\n\nThe incubus squirms under you and lashes his tail to and fro. His whole body is quaking. Suddenly, his cock stops shrinking. There's so much skin at the base that it actually bulges out from his body in a decidedly equine sheath! He grunts, twisting this way and that, his movements mostly arrested by the weight of your [butt] atop him, and grows. The once-demonic member swells, pouring inch after inch of additional length out of his sheath. You gasp when you see a textured ring emerge from hiding. It's his medial ring.... which means the eleven-inch monster sticking out is only half of his total length! While the rest of him lazily sprouts from the musky-smelling sheath, the width of his tool begins to expand, noticeably bulging and retracting, each time keeping a little bit more of its bulged-out size.");
				outputText("\n\nWith a final whimper of relief, the demon completes his transformation by doubling the size of his balls. His sack grows taut and heavy, and the space between his legs is rapidly filled by the heavy orbs. He groans, leaking a solid strand of pre-cum all the way down to his belly as the cock juts up away from him, bobbing in the air and ready to sate your desire.");

				//22" horsecock
				//4" thick. WE CALL HIM THOR!
				monster.cocks[0].cockLength = 22;
				monster.cocks[0].cockThickness = 4;
				monster.cocks[0].cockType = CockTypesEnum.HORSE;
			}
			//Dogdick
			else if (cType == MECHANIC_DOG_COCK)
			{
				outputText("Giving the incubus's sweaty tool an affectionate squeeze, you decide, \"<i>Grow a dog-cock. Let's see if I can take the knot, shall we, pet?</i>\"");
				outputText("\n\nA little breathlessly, the incubus responds, \"<i>Your wish is my command. How fitting that the former predator take on such a wolf-like aspect.</i>\" He closes his eyes to focus, and his dick lurches so hard that it wrenches itself out of your grip. Before you can snatch it up again, it begins to shrink, withdrawing back into itself; the only evidence of its former size is a growing bundle of folded skin at its base. It's almost like some of his length is being converted into the swelling, canine-looking sheath, not stopping until his tip vanishes into the recessed entrance.");
				outputText("\n\nYou frown at him, looking over your shoulder so that he can see your displeasure writ large across your face. He doesn't. His eyes are closed and he's grunting with effort, obviously concentrating hard on something. You look back down to his crotch and immediately notice a welcome change. His small, wolf-like sheath has practically tripled in size. It dominates his crotch, covered in a thin layer of gray fur that extends down to cover his sack, now stretched by nuts that look to have grown half again their original size.");
				outputText("\n\nSmiling, you reach down to the fuzzy bulge and rub it. You move your hand in slow, circular motions around the canine cock-cozy, teasing it while slowly murmuring, \"<i>Good puppy... come out and play, pet....</i>\" Your encouraging coos and gentle strokes soon have the incubus whining like a naughty puppy, and the crimson tip of his wolfish phallus emerges from hiding. It's bright red and covered with so many veins! You cradle the exposed portion, feeling it jump out into your hand. The more dick that slides out, the thicker it gets. It stops once you have ten inches of thick, throbbing dock-cock in your grip, pulsing and ready. It seems like more is trying to come out, but it just can't make it.");
				outputText("\n\nYou give your pet an encouraging tug, grinning as a huge knot slips out and stretches the sheath on the way. Your demonic slut-puppy moans happily, leaking ropes of pre onto his belly as his immense dog-cock points skyward, ready to be used.");

				//12" dogdick. 6" wide knot.
				monster.cocks[0].cockLength = 12;
				monster.cocks[0].cockThickness = 2;
				monster.cocks[0].knotMultiplier = 3;
				monster.cocks[0].cockType = CockTypesEnum.DOG;
			}

			//ALL CONTINUE TO THIS:
			outputText("\n\nYou dare not delay any further. Your [vagina] is so hot and slick with lube that it feels almost like it's steaming. It aches for penetration. Lifting yourself up off your [legs], you guide your wanton honeypot up until it's poised just above the " + monster.cockDescriptShort());
			if (player.wetness() <= 2) outputText(", letting your free-flowing pussyjuice wash over it, lubricating it with your glorious girlcum");
			else if (player.wetness() <= 3) outputText(", letting your oh-so-juicy vagina drip and dribble, soaking it with your copious girlcum");
			else outputText(", letting your lubricant drip over it");
			outputText(". You stuff two fingers inside and stroke deep before pulling them out and using them to spread you wide open. The " + monster.cockDescriptShort() + " pulsates with every beat of its demonic owner's heart, needing you every bit as much as you now need it.");

			outputText("\n\nLetting your [legs] go slack, you press down upon the incubus' length. His " + monster.cockHead() + " presses poignantly at your entrance, throbbing gently. Small blooms of warm tickle over your lips, warm and wet as he leaks his liquid excitement into your nethers, lubricating you further. You relax a bit more");

			var mCockArea:Number = monster.cockArea(0);
			var pCuntArea:Number = player.vaginalCapacity();
			var tightFit:Boolean = false;

			//Easy fit -- Player cunt can fit at least 50% more cock
			if (pCuntArea >= mCockArea * 1.5)
			{
				outputText(" and feel the girthy boner start to slide deeper inside you. Your capacitative cunt hugs and squeezes tightly about its new best friend, guiding it deep into your heated channel. You slide on down, reveling in the blissful sensation of being properly filled for once, ecstatic as you realize just how hard this demon's dick is going to make you cum. You're so busy riding the thrill of pleasure that you barely notice when you bottom out above his balls");
				if (cType == MECHANIC_HORZ_GOG) outputText(", your belly bulging with his equine shape");
				else if (cType == MECHANIC_DOG_COCK) outputText(", your lips slurping noisily about his knot");
				outputText(".");
			}
			//Decent Fit - Player cunt can fit between 95% - 149% of the total cock area
			else if (pCuntArea >= (mCockArea * 0.95))
			{
				outputText(" and feel the girthy boner slowly start to slide through your clinging lips. He's so big and yet fits so well. It's like his " + monster.cockDescriptShort() + " was made to violate your channel - to slip and to slide through you while keeping you oh-so-pleasantly full. You're so busy enjoying the agonizingly slow pleasure that you barely notice when you bottom out above his balls");
				if (cType == MECHANIC_HORZ_GOG) outputText(", your belly bulging with his equine shape");
				else if (cType == MECHANIC_DOG_COCK) outputText(", your lips slurping noisily about his knot");
				outputText(".");
			}
			//Two (dohohoh, wrong too) tight - Player cunt can fit between 50% - 94% of the total cock area
			else if (pCuntArea >= (mCockArea * 0.5))
			{
				tightFit = true;
				outputText(" and feel the girthy boner slowly pry your lips further apart. He's so goddamn big that it feels like it's barely fitting inside. The first inch eventually slips into your tightly-clinging lips, forcing an inadvertent clench to run up the length of your channel. Your [vagina] noisily squelches around the slowly inserting member. You're stretched so full, and you're loving every moment of it. His "+ monster.cockDescriptShort() +" is so goddamn filling, and you've only taken the first few inches! The feel of him sliding through you is so fulfilling, so all-consuming, that you barely notice your [butt] touching down against his crotch");
				if (cType == MECHANIC_HORZ_GOG) outputText(", your belly bulging with his equine shape");
				else if (cType == MECHANIC_DOG_COCK) outputText(", your lips slurping noisily about his knot");
				outputText(".");
			}
			//Cunt WRECKER - Basically anything sub-50% of the cock area
			else
			{
				tightFit = true;
				outputText(" and feel the immensely girthy boner butt up against your lips, too wide to slip even the tiniest bit inside. Grunting in frustration, you grind against him, slicking his head further and applying more force. You push harder and harder, actually bending his rigid shaft slightly from the force. He groans in pain and pleasure. Suddenly, your voice joins his. His " + monster.cockHead() + " finally powers through your sopping gates and into your tunnel, stretching it painfully wide as it goes. The intensity of the combined pain and pleasure shocks you so badly that you nearly faint, and your [legs] go limp, forcing your body to slide down the belly-stretching meat-pole. You quiver and cry, sobbing words that sometimes sound like no and sometimes sound like yes, filled with more cock than you ever hoped to handle.");
			}
			player.cuntChange(monster.cockArea(0), false, false, false);
			
			//Merge together
			outputText("\n\nYou hold yourself atop him and let your abdominal muscles flutter around the incubus' "+monster.cockDescriptShort() +" like an organic sextoy, getting used to holding him inside you. Turning to look back over your shoulders, you place a hand upon his chest feel his well-defined muscles. You stop to admire his nipple, tugging at it a little bit. He growls in irritation, but you just squeeze his dick with your");
			if (tightFit) outputText(" well-stretched");
			else outputText(" stuffed");
			outputText(" twat to silence him.");

			outputText("\n\n\"<i>Are all demons controlled this easily?</i>\" you muse out loud. \"<i>A few squeezes from a cunt and you're content to let me do whatever I want to you. I could probably slap a collar around your neck and take you back to camp without hearing a word of complaint. Perhaps 'please fuck me,' but I doubt I'd hear any legitimate desire to come back here.</i>\" You lift yourself up an inch and glide back down, teasing him. \"<i>Poor boy, they keep you so pent up, don't they?");
			if (flags[kFLAGS.FACTORY_INCUBUS_BRIBED] > 0) outputText(" Nothing but hentai mags for you to drain your balls with....");
			outputText("</i>\"");

			outputText("\n\nThe incubus sighs and nods. \"<i>It isn't easy to get off when the bitches make you fix their machinery all day long. Are a few hours with a succubus every day too much to ask for?</i>\" You feel his cock twitch inside you at the word succubus, and you give his poor boner another squeeze from your cunt for being so honest.");

			outputText("\n\n\"<i>I really did consider ending your life, demon, but you were just doing your job.</i>\" Your pussy spasms with pleasure, and you begin sliding up once more, this time going most of the way up before slowly sliding back down. You settle into a nice slow rhythm as you talk, interrupting your own words the occasional pleasured moan or breathless " + player.mf("gasp","giggle") + ". \"<i>With a talented cock like this, I might have to keep you around.</i>\" You feel your [vagina] gush its approval around his girth. His "+ monster.cockDescriptShort() +" feels too good not to keep around. Riding it would be the perfect way to clear your head in the morning or settle down for a nice, well-fucked sleep.");

			outputText("\n\nThe demon grunts, \"<i>I... I would accept that.</i>\" His dick swells a little inside you, expanding with his ardor. \"<i>If you have any machines, I would gladly keep them working for you. Just... ung... right there, baby... uh... just let me do this with you every day.</i>\" His hips shudder slightly underneath you. They start to thrust until you push them down with your hand, holding them in place. You're in charge here, and this "+ monster.cockDescriptShort() +" is going to have to stay in your [vagina], making you feel good until you feel you've gotten your feel of pussy-pleasing pleasure.");

			outputText("\n\nGods, your clit is so hard right now!");
			if (player.clitLength >= 5) outputText(" You grab hold of it in your hand and start to stroke it to the tempo your rising and falling body is setting, pumping the oversensitive organ like a dick. Every stroke sends your walls into fits of fluttering ecstasy. It feels so good that you don't think you'll be able to stop until you're cumming and gushing all over your demonic lover.");
			else outputText(" You thumb at it, rubbing in slow circles around it. Sometimes you push on its hood. Other times you oh-so-gently squeeze at it. It feels so good that the touches drive you crazy with ecstasy, and your walls flutter excitedly around your demonic lover.");
			outputText(" His only reaction is to gasp and groan, balls lurching in his sack.");

			outputText("\n\n\"<i>Getting close?</i>\" you ask. The question could have easily been directed to you. It's getting hard to hold back, even if you want this perfect, cunt-filling fullness to remain with you forever. Tainted demon pre is running out with your juices in steady trickles as you climb the to the peak of orgasm together, your sweat-slicked bodies writhing against one each other. Your mask of composure slips, and moan like a whore, begging the incubus to nut inside you, to pump you full of his hot, creamy seed. You don't mind a little corruption, after all, but you'll always be the champion - just a champion who really likes getting her pussy fucked full of succulent demon-cum.");

			outputText("\n\nHis dick suddenly expands even more, stretching you tight");
			if (cType == MECHANIC_HORZ_GOG) outputText(", the head flaring to seal itself against your cervix");
			else if (cType == MECHANIC_DOG_COCK) outputText(", the knot popping in just in time to start bloating, locking you in place");
			outputText(", and jism begins to shoot out in waves.");
			if (!player.isPregnant())
			{
				outputText(" Your empty womb drinks up the virile, seed-filled sludge with abandon.");
				if (cType == MECHANIC_HORZ_GOG) outputText(" After all, that bestial horse-cock doesn't really leave it anywhere else to go. The demonic animal-cunt just continues spurting straight on in to have its way with your eggs, and you're sure there isn't a contraceptive this side of Mareth that could stop you from having his imps.");
				else if (cType == MECHANIC_DOG_COCK) outputText(" After all, that immense knot doesn't really leave it anywhere else to go. Once every fold is bathed in alabaster doggie-cream, the continued ejaculations start pouring in after your eggs. His knot is so big and stretching you so wide; you don't think he would pop out even if he filled your belly to look nine months pregnant. Worse, or perhaps better, you're sure with how thick and virile his seed feels that you'll be getting pregnant with his imps from this.");
				player.knockUp(PregnancyStore.PREGNANCY_IMP, PregnancyStore.INCUBATION_IMP);
			}
			else
			{
				outputText(" Your blocked womb deflects the seed, forcing it all to stay in your channel");
				if (cType != MECHANIC_DOG_COCK) outputText(" and drip out over his balls, much to his chagrin.");
				else outputText(" and stretch you further.");
			}

			outputText("\n\nThe feeling triggers your own climax. Your [vagina] clenches down around his "+ monster.cockDescriptShort() + " and gushes out around it, splattering the demon's crotch and legs the whole way down to his hooves. Arcs of femcum actually jet across the air");
			if (player.wetness() < 4) outputText(", even though you aren't normally a squirter");
			outputText(". The pleasure is so great that you can feel electric impulses arcing between neurons, short-circuiting your throughs into involuntary ecstasy. Your eyes roll back, and your [hips] twitch and shake, vibrating around the object that brough you to this perfect");
			if (!player.isPregnant()) outputText(" insemination");
			else outputText(" tryst");
			outputText(".");

			outputText("\n\nYou both cum for what feels like hours. Yet, all good things must come to an end. You do have a queen bitch to depose, after all.");
			if (cType == MECHANIC_DOG_COCK) outputText(" When you try to rise, you find that his knot is still stubbornly inflated, trying to hold all his fertile sperm deep inside you. It won't come out! Glaring at him, you put as much of your gear on as possible and start dragging him through the dungeon after you until he has the good sense to shift his cock into another shape. He weakly slides out, panting something about seeing you at your camp. He's gone by the time your gear is properly settled.");
			else outputText(" When you rise, it amazes you just how many inches of cock are sliding out of your well-used snatch. The " + monster.cockHead() + " eventually slips free, and you watch in awe at how his musky semen runs out from your gaped, thoroughly creamed lips. By the time you dress, he's vanished, but you recall hearing him panting something about seeing you at camp.");

			outputText("\n\nHe's a demon. Maybe he'll actually find his way to your camp to be your fucktoy. More likely he was just saying whatever would save his hide and sharing his excessive perversions with you. You wouldn't mind him fucking you every morning, would you?");

			outputText("\n\nShaking your head, you clear away the errant thoughts and focus on the battles to come.");

			player.orgasm();
			dynStats("cor+", 5);

			combat.cleanupAfterCombat(getGame().d3.resumeFromFight);
		}
		
		public function mechanicFuckedYouUp(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (player.hasCock() && !player.hasVagina())
			{
				maleLossToMechanic(hpVictory);
			}
			else
			{
				errybodyelseLossToMechanic(hpVictory);
			}
		}
		
		private function maleLossToMechanic(hpVictory:Boolean):void
		{
			clearOutput();
			
			//Turned into living Sybian, more or less. Always hard and with a magic cockring that vibrates your dick on contact with pussy.
			//Lust loss
			if (!hpVictory)
			{
				outputText("Your [legs] are quivering too wildly to support you anymore, and you collapse, splaying yourself out so that your rigid cock");
				if (player.cocks.length > 1) outputText("s");
				outputText(" are jutting out enticingly, hard and ready. You shudder, too aroused to fight and certainly too turned on to think straight. Looking longingly at the demon's throbbing-hard member, you unconsciously lick your lips, finding yourself craving its touch unconditionally. Your hands remove your [armor] before falling to your crotch, grabbing, squeezing, and tugging, but in the back of your mind, you realize you'll need his help to orgasm.");
	
				outputText("\n\nThe inubus leers, smiling down at you.");
		
				//Small cocks
				if (player.biggestCockLength() < 6)
				{
					outputText("\n\n\"<i>That's it? You expect to please anyone with such a pitiful endowment? I suppose there may be someone into that, somewhere.</i>\" The incubus sighs. <i>\"Your flaws only make my job harder.</i>\"");
				}
				//Medium cocks
				else if (player.biggestCockLength() < 12)
				{
					outputText("\"<i>You're so... average. I suppose you'll do, if the succubi feel like having a drab, everyday orgasm.</i>\" The incubus shrugs. \"<i>A dick will do...</i>\"");
				}
				//Big cocks
				else if (player.biggestCockLength() < 18)
				{
					outputText("\n\n\"<i>Huh....</i>\" The incubus seems pleasantly surprised by your endowment. \"<i>I gotta say, that'll probably work good for what I have in mind. Maybe you'll even be popular with the succubi.</i>\" He laughs.");
				}
				//Huge cocks
				else
				{
					outputText("\"<i>Seriously?</i>\" the incubus asks. \"<i>How am I supposed to work with something so gargantuan?</i>\" He disdainfully pulls a vial from his pocket and upends it over your crotch. The effect is immediate. [Eachcock] shrinks from ridiculously large down to horse-sized. <i>\"There, that's better.\"</i>");
					//Shrink down to 18" by 3"
					player.cocks[player.biggestCockIndex()].cockLength = 18;
					player.cocks[player.biggestCockIndex()].cockThickness = 3;
				}
		
				//Merge size forks
				outputText("\n\nYou hump against your palm and lick your lips encouragingly. The sheer need thrumming through your veins will allow nothing less. You want to fuck and be fucked. To be used and abused. To sink");
				if (player.cocks.length == 1) outputText(" your");
				else outputText(" a");
				outputText(" length inside any hole and thrust until you're quivering in orgasmic release. That gorgeous demon-cock taunts you, swaying just out of reach.");
			}
			//HP Loss
			else
			{
				outputText("Dropping prone, you gasp for breath, struggling against your injured body to rise. Your muscles burn with the effort, exhausted from the fight, and ultimately, you fail to stand. Slumping down on the ground, you're forced to come to terms with your defeat. The incubus has won. You came all this way, gave your best, and got smacked down by a lower demon for all your troubles. Some champion you are.");
	
				outputText("\n\nLeering down at you, the incubus swiftly tears away your [armor], his fingers suddenly razor-sharp claws. He is precise in his attentions, leaving your [skin] pristine and unbroken. You get the impression he doesn't want damaged goods. He regards your " + player.multiCockDescriptLight() + " with interest, judging them.");
	
				//Small cocks
				if (player.biggestCockLength() < 6)
				{
					outputText("\n\n\"<i>That's it? You expect to please anyone with such a pitiful endowment? I suppose there may be someone into that, somewhere.</i>\" The incubus sighs. <i>\"Your flaws only make my job harder.</i>\"");
				}
				//Medium cocks
				else if (player.biggestCockLength() < 12)
				{
					outputText("\n\n\"<i>You're so... average. I suppose you'll do, if the succubi feel like having a drab, everyday orgasm.</i>\" The incubus shrugs. \"<i>A dick will do...</i>\"");
				}
				//Big cocks
				else if (player.biggestCockLength() < 18)
				{
					outputText("\n\n\"<i>Huh....</i>\" The incubus seems pleasantly surprised by your endowment. \"<i>I gotta say, that'll probably work good for what I have in mind. Maybe you'll even be popular with the succubi.</i>\" He laughs.");
				}
				//Huge cocks
				else
				{
					outputText("\n\n\"<i>Seriously?</i>\" the incubus asks. \"<i>How am I supposed to work with something so gargantuan?</i>\" He disdainfully pulls a vial from his pocket and upends it over your crotch. The effect is immediate. [Eachcock] shrinks from ridiculously large down to horse-sized. <i>\"There, that's better.\"</i>");
					
					//Shrink down to 18" by 3"
					player.cocks[player.biggestCockIndex()].cockLength = 18;
					player.cocks[player.biggestCockIndex()].cockThickness = 3;
				}
	
				//MERGE size fork
				outputText("\n\nThe incubus strokes his finely-groomed goatee while considering you further. He comes to a decision a moment later, though he does not bother to explain his thoughts to you, his fallen foe. Holding his hand aloft, he inhales deeply and utters words of nonsense - words that make your head hurt just listening to them. A swirling vortex of incandescent pink appears in his hand, glowing with a light all its own, growing bigger with every uttered word. When it is as big as a basketball, the demon gestures towards you, and the ball flies as true as an arrow, impacting you square in the chest.");

				outputText("\n\nPure, biological need overwhelms you. The ache from your wounds is nothing next to the mountains of lust crushing your crotch with fuck-driven impetus. You forget your attempts at resistance. Though there are no pussies present, there is a hard, musky cock being dangled a scant few feet away, its nubby, corruption-textured surface promising you a long, slow cum of your own if you only give into it. You lick your lips without meaning to, already falling to the idea.");
			}
	
			outputText("\n\n\"<i>Now, you may have been a champion before, but by right of battle, you're little more than my property. It's time to make your appearance match your new station,</i>\" the tainted mechanic explains.");

			outputText("\n\nFirst, he reaches into his pocket and produces a shining, golden ring. It gleams with unnatural brightness in his hand, far too thick to be worn on a finger and yet far too narrow to be a collar of any kind. The demon twirls it over his knuckles and kneels beside you, letting his member flop against your cheek. A trickle of corrupted pre-seed oozes out onto your cheek, and you cannot help but turn your head to suck his crown into your mouth. As you suckle and polish the phallus, your throat works to swallow everything he gives you, and he feeds you plenty.");

			//Multicock
			if (player.cocks.length > 1)
			{
				outputText("\n\nThe incubus gathers your " + player.multiCockDescriptLight() + " together in his hands, pressing them together into a column of compressed cock. His touch feels so nice that you piston your [hips] against him, trying to fuck his hands, but he holds you firmly. A warm tightness, pleasant and yet entirely unyielding presses down against your tips, so tight that whimper at the slight pinch of pain. You crane your head, careful not to lose your mouth's grip on its leaking fixation. What you see nearly makes you spit it out.");

				outputText("\n\nThe ring is being forced down your bundled shafts. Below, your dicks remain as they are. Above, they're being merged together into one impressive tool.");

				var allDemon:Boolean = false;
				if (player.countCocksOfType(CockTypesEnum.DEMON) == player.cocks.length) allDemon = true;

				if (!allDemon) outputText(" The skin of your transforming length is darkening to a purplish hue, and in the wake of the magical cock-ring, nodules are slowly emerging, growing into an imitation of the cock you're still suckling.");
				outputText(" The incubus chuckles, easily pushing the ring the rest of the way down, smiling at the way your demonic tip pulsates and leaks pre-cum. Once it's nestled firmly against your groin, your new master withdraws his hands (and his cock). <b>Your singular, demonic cock is impossibly hard.</b>");
			}
			else
			{
				//Single
				outputText("\n\nThe incubus grabs your [cock] in his hand, holding it steady, not really intending to bring you much pleasure. His touch feels so nice that you piston your [hips] against him anyway, but he holds you firm and steady. A warm tightness, pleasant and unyielding presses down against your [cockHead], so tight that you whimper at the slight touch of pain. You crane your head for a better look, careful not to lose your mouth's grip on its leaking fixation. What you see nearly makes you swoon.");
				//Has nondemon dick
				if (player.countCocksOfType(CockTypesEnum.DEMON) == 0)
				{
					outputText("\n\nThe gleaming ring is sliding down your length, and every inch that passes through it is turning... changing into a purple-hued monstrosity - a pale imitation of the cock currently plugging your hungry lips. It feels... surprisingly good to transform, and the sensation of your dick's nubs growing in is wonderfully divine. You blissfully sigh as the ring touches down against your crotch, <b>completing your transformation into a demon-cocked toy.</b>");
				}
				//Has demon cock
				else
				{
					outputText("\n\nThe gleaming ring is sliding down your length, and every inch that passes through it seems to grow more impressive: darker purple, bigger nubs, bulgier veins. Your length is becoming more tainted with every passing second, more firmly encased in corruption, steeped so deeply in it that you doubt it'll ever look like anything else. That cock-ring is making your demonic tool so powerfully and completely tainted that you can feel it transmitting a desire for demon-pussy up your spine.");
				}
			}

			//Merge all
			outputText("\n\nRather than let you play with your enhanced member, the incubus grabs you by the neck and hauls you to your feet, dragging you towards a doorway. \"<i>Now to put you to work.</i>\" His grip feels so powerful that you don't bother to resist. Instead, you just grab your extremely hard length and begin to masturbate in earnest, hoping to get at least one good cum in before you arrive at whatever destination the demon has planned for you. Ropes of pre-cum thicker than jizz spill out of your distended cumslit as you passionately milk your shaft. You convulse in near orgasm, using your own cock-syrup as lube, but release never comes. All that you accomplish is bringing your need to a new, quivering peak before backsliding, the summit of pleasure a few steps beyond your reach.");

			outputText("\n\n\"<i>Oh, toys don't cum without permission.</i>\" The incubus reaches down to stroke you, laughing as the flow of pre thickens to a steady stream. \"<i>If you want to let out all the cum that's building up inside you, you'll need to do your job.</i>\" He laughs. \"<i>That cock-ring is a marvellously enchanted piece of metal. It'll keep you hard and at peak production, but it'll also stop you from cumming except on command from others.\"</i> He gathers up your leaking pre and forces you to swallow it. Your only response is to pant in wanton abandon. <i>\"Yes, I suppose holding back this much is quite the strain. The ring has another property. You can will it to make your beautiful new dick vibrate. You won't feel the vibrations yourself, but you can control the strength and speed of the vibrations with a thought. A talent you'll find quite useful in your new station.</i>\"");

			outputText("\n\nAt this point, you're tossed down into a box. Instead of slamming into the hard wood, your back lands in a supple leather harness, your arms pressed to your sides. The incubus works quickly above your stunned form, securing you into place with more of the straps, disdainfully wrangling your cock into a support that has it pointing straight up. He steps back to admire his work. Then, a moment later, bends over to grab a thick, wooden board with two holes in it. He grunts as he hefts it into place, lowering it down so that your cock sticks out of one pre-cut hole and your face is exposed in the other. Then, he disappears from view.");

			outputText("\n\nYou hear and feel a rumbling as your box is wheeled out into another room, and though you don't see them, you become aware of the presense of succubi. Lots of them, judging by the amount of wet, aching pussy you can smell. Your augmented cock twitches.");
			
			// [Next]
			doNext(maleLossToMechanicII);
		}
		
		private function maleLossToMechanicII():void
		{
			clearOutput();
			outputText("An agonizingly perfect pussy is suddenly pressing down on your cock, subsuming it in slick, hot depths that cling and squeeze with undulations so skillful you'd be cumming already if it weren't for the magic ring.");

			outputText("\n\nYou gasp, \"<i>Please! Let me cum! I need it!</i>\"");

			outputText("\n\nLaughing, the fair voice of a less-than-fair demon coos, \"<i>If you do a good job getting me off, maybe.</i>\" She stuffs her spaded tail into your mouth, effectively gagging you and forcing you to breathe through your nostrils. \"<i>Now hush up or I'll get rid of that noisy little hole. Momma's gonna have some nice, long cums on you, toy.\"</i> She begins to bounce in a slow up-and-down movement. Ordinarily such an experience would be marvellous, but to you, it's sexual torture. Your demonically-charged member aches with need, so close and yet forever so far.");

			outputText("\n\nWeeping openly, you focus on your twitching tool and mentally command it to vibrate. An audible hum picks up as your cock tends to its duty, shaking with mechanical precision inside the demon-woman's twat. Her pussy-juice spatters over the boards above you and drips through the cracks, bathing you in her ardor. Encouraged by this, you hone your command of your cock, trying more forceful but slower vibrations, then changing up to small, super-fast twitches. Every change is met with a coo of pleasure. Sometimes you even hear a slight applause from the rest of the room, but you're too busy to care.");

			outputText("\n\nShe cums, splattering you with hot fuckjuice, thrashing and whimpering for two solid minutes. There's wild cheering at that, followed by a high-pitched call, \"<i>Who's next?</i>\" The girl you got off staggers up off of you, withdrawing her tail from your mouth, and she steps over to blow you a kiss before leaving.");

			outputText("\n\nYou protest, \"<i>Let me cum! You promised!\"</i>");

			outputText("\n\nShe stops in her tracks and turns. \"<i>No, I said I might let you cum. You still need practice. Maybe you can do well enough with my sister to earn some release?</i>\"");

			outputText("\n\nAnother velvety tunnel wraps around you, and you are subsumed in sex once more. Succubus after succubus mounts you, each using you as little more than a fucktoy. You get increasingly desperate with every twat you satisfy, but they never allow you to cum. For days, you are the toast of the demon town, never left to sleep or rest, held on the edge until you break.");

			// [Next]
			doNext(maleLossToMechanicIII);
		}
		
		private function maleLossToMechanicIII():void
		{
			clearOutput();
			outputText("The champion finally got to cum once Lethice had her turn, but by that point, pussy was all " + player.mf("he","she") + " could think about. Release came more frequently with the demon queen's permission. It didn't really matter, though. The champion was addicted to riding on the edge of climax, broken into nothing more than a demonic vibrator.");

			getGame().gameOver(); // G-G-G-GAMEOVER.
		}
		
		
		private function errybodyelseLossToMechanic(hpVictory:Boolean):void
		{
			clearOutput();

			//Get turned into girl-lube pot.
			//Genderless Lust Loss
			if (!player.hasVagina() && !hpVictory)
			{
				outputText("You stagger about drunkenly, stuffing your hand down your [armor] to get at your needy, aching [asshole]. You feel like a molten-hot font of lust and a delirious, jizz-craving slut all at the same time. Nothing short of hours of endlessly rutting on a virile, demonic cock for hours will quench the flames of your ardor and give you the pleasure you now crave. You whimper, looking up at the incubus imploringly as you try to get him to take you, yanking open your [armor] to show off your ready sphincter and busily pumping fingers. You even spread yourself open, beckoning him to stuff you.");
				outputText("\n\nThe demon uncaps a bottle of something and presses it into your spread-open sphincter, pouring something into you. Before you try to push it out, you feel buzzing heat in your groin, so strong that it's practically disabling. Slowly, that heat focusing into an incredible, wet sensation. <b>You've grown a pussy!</b> The empty bottle falls to the ground.");
				player.createVagina();
				outputText("\n\n");
			}
			//Genderless HP Loss
			else if (!player.hasVagina() && hpVictory)
			{
				outputText("Collapsing onto the ground, you look up at the demonic aggressor with hate in your eyes, unwilling to admit defeat even when staring full-on into its face. The incubus, for his part, simply smiles down at you as he steps closer, claws clicking noisily on the smooth, tiled pavement.");

				outputText("\n\n\"<i>Is that all the mighty champion is capable of? Feeble resistance that ends itself before lust can be properly awakened? I am... disappointed in you,</i>\" the incubus admits as he kneels down to look at conquered prize. \"<i>Still, Lethice will be pleased to have you at hand at last. I think I might get to keep you.</i>\" He playfully manhandles his foot-long meat to smack against your [face], forcing you to get a good feel for his tainted cock, to smell lurid, sexual scent.");

				outputText("\n\nIt makes your [asshole] tingle hungrily. More hungrily than it's ever felt.");

				outputText("\n\nSmiling, the overall-clad corruptor drags his thick tool up your cheek and across your lips, leaking his slime as he goes, and he gleefully watches you try to maintain your disdain in the face of his lascivious influence.");

				outputText("\n\nWhile you are distracted, he unhooked your [armor], casting it aside, already forgotten. Like this... he can take you more easily. No! You've got to fight this. He gently strokes your [hair] and laughs. You clench needily, aching to feel him inside you. Acting while you're distracted, the incubus suddenly presses something smooth and cold against your exposed ass. Something flows out of it into you! It was a bottle. You squeeze down, trying to force it out, but it stays stubbornly inside you. The incubus pulls it out a moment later, but the damage is done. Increadible warmth gathers in your crotch. With it comes arousal. In seconds, you're panting, and lurid wetness spreads out from your crotch, leaking from <b>your new vagina.</b>");

				player.createVagina();

				outputText("\n\nGods, your pussy is wet, but you've got to fight it! You have to hold on, maybe bite him or something to give you the time to recover and get back on the offensive! Yeah... biting might do the trick. You inhale to steel yourself for the oral assault, getting a nice, long whiff of his supremely potent pheromones in the process. Your [clit] gets so stiff that you start writhing your [hips] in order to squish your cunt-lips tight around. <i>Mmmm, gotta attack...</i> you think, but your heart just isn't in it anymore. You open your mouth, letting him push his tip inside, so that you can bite him, of course. Oh, the flavor is so intense... so strong and masculine and perfect on your tongue that you decide NOT to chomp down. Not yet. You can spend a little time recovering first, with his wonderfully tasty, throbbing-hot demon-cock on your happily licking tongue.");

				outputText("\n\nSoon, those licks turn to sucks, and those sucks into a devilishly pleasurable blowjob. One hand winds to your steaming box while the other gropes at your [fullChest],");
				if (player.hasFuckableNipples()) outputText(" slipping inside a [nipple] to thrust just like your other hand. You work your upper and lower pussies like a woman possessed.");
				else
				{
					outputText(" pinching and tugging on");
					if (player.totalNipples() > player.totalBreasts()) outputText(" nipple after nipple, your myriad breastly endowments providing you with oh so many buttons to tend to");
					else outputText("your [nipples] one after another");
				}
				outputText(" Alas, all good things must come to an end, and your lovely, lovely little lollipop is rudely pulled from your questing lips with a noisy pop.");

				outputText("\n\nYou give a mewl of disappointment and open your eyes to see the incubus standing back a few feet, smirking at you, his cock hard, jutting, and leaking. That simply won't do! A dick like that... it needs to be sucked... tended to... until it can cum! You struggle out of your [armor] and up onto your [feet], staggering towards it with your hand still firmly lodged in your [vagina]. You've got to tempt him back to you, or catch him at the very least.");
			}
			//Lust Lawss
			else if (player.hasVagina() && !hpVictory)
			{
				outputText("You stagger about drunkenly, stuffing your hand down your [armor] to get at your needy, aching [vagina]. You feel like a molten-hot font of lust and a delirious, jizz-craving slut all at the same time. Nothing short of hours of endlessly rutting on a virile, demonic cock for hours will quench the flames of your ardor and give you the pleasure you now crave. You whimper, looking up at the incubus imploringly as you try to get him to take you, yanking open your [armor] to show off your splayed-open twat and busily pumping fingers. You even pull them out lick clean, hoping he'll enjoy the show as much as you enjoy your own taste.");
			}
			//HP Lawss:
			else
			{
				outputText("Collapsing onto the ground, you look up at the demonic aggressor with hate in your eyes, unwilling to admit defeat even when staring full-on into its face. The incubus, for his part, simply smiles down at you as he steps closer, claws clicking noisily on the smooth, tiled pavement.");
				outputText("\n\n\"<i>Is that all the mighty champion is capable of? Feeble resistance that ends itself before lust can be properly awakened? I am... disappointed in you,</i>\" the incubus admits as he kneels down to look at conquered prize. \"<i>Still, Lethice will be pleased to have you at hand at last. I think I might get to keep you.</i>\" He playfully manhandles his foot-long meat to smack against your [face], forcing you to get a good feel for his tainted cock, to smell lurid, sexual scent.");
				outputText("\n\nIt makes your [vagina] wet. Wetter than it really should be.");
				outputText("\n\nSmiling, the overall-clad corruptor drags his thick tool up your cheek and across your lips, leaking his slime as he goes, and he gleefully watches you try to maintain your disdain in the face of his lascivious influence. ");
				outputText("\n\nGods, your pussy is wet, but you've got to fight it! You have to hold on, maybe bite him or something to give you the time to recover and get back on the offensive! Yeah... biting might do the trick. You inhale to steel yourself for the oral assault, getting a nice, long whiff of his supremely potent pheromones in the process. Your [clit] gets so stiff that you start writhing your [hips] in order to squish your cunt-lips tight around. <i>Mmmm, gotta attack...</i> you think, but your heart just isn't in it anymore. You open your mouth, letting him push his tip inside, so that you can bite him, of course. Oh, the flavor is so intense... so strong and masculine and perfect on your tongue that you decide NOT to chomp down. Not yet. You can spend a little time recovering first, with his wonderfully tasty, throbbing-hot demon-cock on your happily licking tongue.");
				outputText("\n\nSoon, those licks turn to sucks, and those sucks into a devilishly pleasurable blowjob. One hand winds under your [armor] to tend to your steaming box while the other gropes at your [fullChest],");

				if (player.hasFuckableNipples()) outputText(" slipping inside a [nipple] to thrust just like your other hand. You work your upper and lower pussies like a woman possessed.");
				else
				{
					outputText(" pinching and tugging on");
					if (player.totalNipples() > player.totalBreasts()) outputText(" nipple after nipple, your myriad breastly endowments providing you with oh so many buttons to tend to");
					else outputText("your [nipples] one after another");
				}
				outputText(" Alas, all good things must come to an end, and your lovely, lovely little lollipop is rudely pulled from your questing lips with a noisy pop.");

				outputText("\n\nYou give a mewl of disappointment and open your eyes to see the incubus standing back a few feet, smirking at you, his cock hard, jutting, and leaking. That simply won't do! A dick like that... it needs to be sucked... tended to... until it can cum! You struggle out of your [armor] and up onto your [feet], staggering towards it with your hand still firmly lodged in your [vagina]. You've got to tempt him back to you, or catch him at the very least.");
			}

			//MERGE BOTH FORKS
			outputText("\n\n\"<i>Come along now, girl. I'll give you all the dick you can suck, but not here,</i>\" the twisted creature promises as he backs away, holding his member in one hand and shaking it before you like a treat for a dog. You stagger after, knowing that a male, even a demonic one, won't deny you the throbbing-hard relief you seek, even if he makes you work for a bit first. The light from outside dims as you clear an open doorway, ignoring everything but the deliciously enticing sway of the member before you. Gods, you <b>need</b> that thing inside you.");

			outputText("\n\nLuckily, he stops backing up not long after entering the building and patiently awaits you. He's even courteous enough to lengthen his cock when you knee before him so that you may more easily slip it into your mouth.");

			outputText("\n\n\"<i>That's my good slut,</i>\" he sighs in whispery pleasure. \"<i>You just keep sucking while I get the machinery into position.</i>\" Whatever. After a little more rod-polishing, you're sure he'll give you a fucking for the ages, the one your cunny deserves. You've just got to focus on getting his musky member so perfectly aroused that he has no other choice. The sound of unspooling chains and clanking metal doesn't bother you. Not even when a set of wooden stocks are fastened around your hands and neck, holding you in place. You regret the inability to cup his balls, but when he pushes wholly inside, you're able to lick them all the same.");

			outputText("\n\nThe source of your lust is soon bending double to fasten more bindings around your waist and [hips], attacking them to more chains by the sounds of it. Soon after, the devices lift you up off the ground such that you");

			// 9999 not sure about these
			if (player.isNaga()) outputText("r coils don't get sore");
			else if (!player.isBiped()) outputText(" don't even need to support yourself anymore");
			else outputText(" knees don't get sore");
			outputText(". How wonderful! If you move just right, you can make the whole contraption sway slightly to get a proper dick-sucking rhythm going. His pearly pre-cream oozes onto your tongue, and you swallow as much of it as you can.");

			outputText("\n\nWith such skillful oral service being given, it comes as some surprise to you when the incubus removes his dick from your suckling maw. Of course, he must be just changing position to fuck you, hence the elaborate bondage rig! You close your eyes and focus your attentions lower on your body, awaiting the inevitable pentration, but your loins remain completely and totally unmolested. Something cool and rubbery is pressed against your mouth instead. You accept it, letting what you discover to be a faux phallus push the whole way to the back of your mouth before it is sealed on by a band the mechanic fastens to you.");

			outputText("\n\nHe smiles and affectionately tussles your [hair]. \"<i>Silly girl. Your pussy wasn't meant to be fucked and filled.</i>\"");

			outputText("\n\nYou plead with red-rimmed eyes, imploring him to fuck your [vagina]. Of course it is! It's all you want right now! It'll be all you ever want if he does it right!");

			outputText("\n\nShaking his head slowly, the incubus says, \"<i>No, girl. Your pussy isn't meant to be filled. It's meant to lust emptily - to ache for a good firm filling with such passion that you drip unendingly, quivering in need, able to climb to the cusp of cumming at the barest scent of cock.</i>\" He flips a switch, causing the transparent tube attached to the dildo in your mouth to fill with something whitish. It leaks onto the back of your tongue, causing you to instinctively swallow. \"<i>You see, you've got just the right kind of lubricant for some of my machines. This little draught is going to help you produce enough for my uses, and then you'll get to hang here, endlessly horny and leaking into a funnel, only able to cum once you get so used to your situation that you allow sucking off to become your penultimate pleasure.</i>\"");

			outputText("\n\nW-what!? So this... this... delicious goo... it's going to make you even wetter down there?");

			outputText("\n\nThe demon must be able to read the question in your eyes, because he nods understandingly. \"<i>Yes, little mortal, this draught is going to make you wetter and hornier than you can possibly image. That cute little twat you've got is going to be my own personal lubricant-fountain. I suspect you may even manage to learn how to bring yourself off by shifting your [hips] to make your lips rub your [clit] just right.</i>\" He shrugs. \"<i>I don't really care, so long as that cunt of yours stays wet enough to shame the goo-girls at the lake.</i>\" His hand ruffles your hair once more before he steps back to watch you drink this the milky, medicinal goo.");

			outputText("\n\nYou can already feel the first few swallows affecting you. Your [skin] is flushing, worse than before, and your nether-lips are getting so wonderfully slippery that you can feel your moisture beading on your mons. Your [clit] fares little better, swelling up nearly double its old size");
			if (player.clitLength > 5) outputText(", even if that makes it truly monstrous indeed");
			outputText(". It drips long, sticky strands of girlish lust as you swallow, only becoming more soaked as time passes as your body becomes even more productive. A plaintive whimper escapes around the edges of your phallic gag, but your cry falls on deaf ears. The incubus is too busy fitting pipes together beneath you to care.");

			outputText("\n\nWhen you hear your pussy juices spattering against metallic funnel like torrential rain, you realize you've lost, truly and completely. You thought with your slit, and now you're nothing more than a whimpering, leaky cunt, leashed to a demon's whims. The thought rocks you to your core, and tears briefly bead at the corners of your eyes, though you aren't sure if it's due to your humiliating defeat or the knowledge that you're not going to get fucked. You drink the last of your medicine, still crying and trying to cum when the dildo goes dry.");

			outputText("\n\n\"<i>Oh no,</i>\" the incubus cruelly says, \"<i>I can't let you get dehydrated.</i>\" He steps back before you, cock smearing against your chin. \"<i>I have just the thing for that.</i>\" His abdominal muscles press against you through the thin denim of his overalls as he undoes the dildo-gag, and he smells... surprising clean, a little smokey... but clean. You twist your face to nuzzle him, already desperate for attention despite your short time in this predicament. Blessedly, he does exactly as you hope, pulling out the dildo and letting it hang suspended by its tube while he wrangles his twitching, corruption-leaking cock up into place in front of your face.");

			outputText("\n\n\"<i>Was this what you wanted?</i>\" the demon asks.");

			outputText("\n\nYou open your mouth into an 'o' with the corners quirked up into a fuck-doll's smile and nod.");

			outputText("\n\n\"<i>Good.</i>\"");

			outputText("\n\nThe large, mushroom-like crown of that glorious, corrupted cock presses between your lips, already sloppy with spit and pre-cum, and glides deeper. A shiver of delight runs down your spine as you feel the nodules that ring the underside of his head pass through your glossy, cum-hungry gates, and you hear the splatters of your pussy-juices nearly double in frequency. You let your tongue out to roll over across his underside, slipping out over your bottom lip even as additional inches pour into your slutty little mouth.");

			outputText("\n\nSoon, the incubus' thick tool is pressing against the back of your throat, and you're squeezing your [legs] as much as your position will allow to grind your [clit] between your thighs. It feels good, but there's no way to crank things up a notch and really get yourself off. He's right, really. There's nothing you can do but suck, ache, and hope that this latest debauchery will arouse you enough to give you the spontaneous orgasm you NEED. You suck him deeper and try to suppress your gag reflex as his long tool slips into your throat. Your cheeks hollow as you provide him with suction, and you're treated to the feeling of his demonic ooze leaking into your belly in long, thick strands of pre-ejaculate.");

			outputText("\n\nHe fondly runs his fingers through your hair as he explains, \"<i>You're part of the demonic war-machine now, pretty.</i>\" He shifts his hips to thrust into your throat savagely as he works his way towards his own relief. \"<i>You aren't even a person any more. You're a literal cog, or oil-applicator, I guess, at this point.</i>\" He presses his balls against your chin, and you lick them, still dripping with such unbelievable fierceness that you wonder where it all comes from. \"<i>I admit, you're a fine piece of work.</i>\"");

			outputText("\n\nThe demon's nuts are sweaty and twitching on your tongue, and his tool is shifting in changing in your mouth, growing a thick bulge near the base that stretches your jaw wide while simultaneously blocking your throat.");

			outputText("\n\n\"<i>Gonna cum!</i>\" the mechanic announces as he ruts against your [face].");

			outputText("\n\nYou suck harder, [legs] quivering from how hard you're trying to squeeze your button, and feel a sudden warmth explode in the back of your throat. It pours a thick, rich load of cum into your belly's wanton stomach. You can feel its corruptive influence acting on you already, helping you come to terms with your new station. Your tongue worships the underside of his knot, the tip tickling his quaking, emptying balls. This is your place after all, to pleasure with your mouth and drip with your cunt, always horny and willing, always delirious with the pleasant, corrupted buzz of an insatiable need.");

			outputText("\n\nYou'll do anything to keep yourself pleasantly slick for your masters. You don't even protest when the plug is forced back into your mouth and hooked to a nutrient solution.");

			getGame().gameOver();
		}
		
	}

}
