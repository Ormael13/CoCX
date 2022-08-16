package classes.Scenes.Areas.GlacialRift 
{
	import classes.*;
	import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Scenes.Areas.Tundra.YoungFrostGiant;
import classes.Scenes.SceneLib;
	
	public class FrostGiantScene extends BaseContent
	{
		public function winAgainstGiant():void {
			clearOutput();
			if (player.weaponName == "fists" && player.weaponRangeName == "nothing" && player.armor.name == "nothing" && player.shieldName == "nothing") {
				if (monster is FrostGiant) awardAchievement("Like Chuck Norris", kACHIEVEMENTS.GENERAL_LIKE_CHUCK_NORRIS);
				else if (monster is YoungFrostGiant) awardAchievement("Texas Ranger", kACHIEVEMENTS.GENERAL_TEXAS_RANGER);
			}
			outputText("[Themonster] staggers and falls down on his knees. You wonder what you should do next.");
			if (player.lust < 33) {
				outputText("\n\nThere's not too much options, sadly - you're not aroused enough to rape him.");
				cleanupAfterCombat();
				return;
			}
			menu();
			addButton(0, "Nosefuck", noseJob).disableIf(!player.hasCock(), "Req. a cock.");
			addButton(1, "RideVaginally", rideVaginally).disableIf(!player.hasCock(), "Req. a cock.");
			addButton(2, "Goo Sleeve", gooSleeve).disableIf(!player.isGoo(), "Requires goo body.");
			addButton(2, "Ride Anally", rideAnally);
			addButton(14, "Leave", cleanupAfterCombat);
			SceneLib.uniqueSexScene.pcUSSPreChecksV2(winAgainstGiant);
		}
		
		//Males and hermaphrodites
		private function noseJob():void {
			clearOutput();
			outputText("Looking at the fallen giant, only one option immediately springs to mind: Nosejob. You toy with the thought until you approach the giant's nose, which does in fact have nostrils of the proper size to shove your " + player.multiCockDescript() + " into. \n\n");
			outputText("You test a nostril with your hand warily, this dangerous proximity being close enough to the giant's mouth he could just as easily swallow you in an instant. The giant's breath, surprisingly, comes out warm enough that this could maybe work... \n\n");
			outputText("You reach into your [armor] and whip out your cock");
			if (player.cocks.length > 1) outputText("s");
			outputText(". The cold air nearly instantly makes them soft, but the giant's breath eases them back to erection. You contemplate what you're about to do one more time, allowing your [cocks] to surge to full hardness. Taking a breath, you plunge into the depths. While not quite like a vagina, the giant is breathing hard to make up for the blockage you’re providing. ");
			//Multi-cock check
			if (player.cocks.length == 1) outputText("His contracting nostril massages your prick enough to get you going.");
			else outputText("His contracting nostrils massage your pricks enough to get you going.");
			outputText("After some awkward moments of fighting with the giant's sufficiently giant beard, you manage to slip into a rhythm, breathe in, cock out, breathe out, cock in. The alternating currents of cold air in and warm air out from the giant's nose is a strange feeling, but not unpleasant - the contrasts complement each other quite well, and as your balls tighten with anticipation, precum finally begins to dribble into the giant's throat. You hear the giant begin to gurgle and sputter, and you realize you better hurry this up. \n\n");
			//Balls check
			if (player.hasBalls()) {
				outputText("To help speed your orgasm, you pull your balls out and let them slap against the giant's upper lip, the bristles of his mustache tickling your scrotum in ways you hadn't imagined even after all your time in this world. \n\n"); 
			}
			outputText("As more pre dribbles into his septum, the giant begins to sputter and cough. Knowing it's now or never, you give a few final, determined thrusts before blowing your entire load up his nose. \n\n");
			outputText("When you feel that first spurt, you hurry the rest along. The giant is now obviously irritated with the cum filling up his nasal cavities. \"<i>EEEAAAHHHH! WHAT! WHAT IS IN MY NOSE? AAAAHHH!</i>\" he screams, just coming back to consciousness. \n\n");
			outputText("Your spurts continue, producing more spunk as the second pass. You keep shooting ropes of jizz until finally he opens his bloodshot eyes and looks directly at you; knowing this is your cue to take your leave, you remove your [cocks] from the giant's nose and shoot your final rope into his eye. Jumping down before he can swat you off his face, the giant, now quite infuriated, looses another roar as he gets up and tries to hack out the copious gobs of cum in areas where it should not normally go.\n\n");
			outputText("As he continues to bellow and scream, you stuff your [cocks] back into your [armor], grab your loot and immediately DIP. The giant was mean enough before he was nasally violated, and you hear his cries well after he's beyond the horizon.");
			player.sexReward("Default","Default",true,false);
			cleanupAfterCombat();
		}
		
		//Females and hermaphrodites
		private function rideVaginally():void {
			clearOutput();
			outputText("You reach into your [armor] and rub your [vagina] slowly, trying to ease its throbs for attention while you figure out how to calm it. As you inspect the unconscious giant's body, you notice a crack in his frost armor near the crotch. Using your [weapon] to nick more frost away, you find that the giant is indeed male. The giant's huge cock strikes you; flaccid as it is, it still ");
			if (player.tallness < 36) outputText("dwarves your height.");
			else if (player.tallness >= 36 && player.tallness < 48) outputText("matches your height.");
			else outputText("is only slightly shorter than you are tall.");
			outputText("\n\n");
			if (player.cocks.length <= 0) outputText("Seeing no other option");
			else outputText("Deciding to give your vagina the attention it so craves");
			outputText(", you carefully remove and replace pieces of your [armor] so you can rub your [chest] while you ready to slide your slit over the giant's cock without freezing the rest of your body.");
			outputText("Climbing to the giant's crotch, you straddle his dick and feel it before crouching. The giant's body heat makes up for the cold, warm enough to feed your hungry twat and dissuade your fears of getting stuck to the giant. You gather some juices from your [vagina] and slather it on the cock, ready to slide yourself to release.");
			player.cuntChange(144, true, true, false);
			outputText("\n\nWith a bracing breath, you finally make contact. The giant's heat is more intense than your hand registered, and you find yourself easily able to slip back and forth. As you slide over the huge cock, it slowly grows erect, until it towers over you and you can do little more than gyrate your hips to pleasure yourself. You struggle to keep sliding, but it's futile. As you stop and ready to dismount the giant, he groans, \"<i>No...</i>\" and grabs a leg in each hand. You try to shout out, but before you have a chance he is quickly sliding you back and forth over his entire length, basically masturbating and taking you for the ride. Feeling every ridge and bump in his dick slide past you, it takes only a few moments for you to reach your limit.\n\n");
			if (player.hasCock()) outputText("You shoot ropes of jism from your [cocks] and cum all over his chest.  ");
			if (player.hasVagina()) outputText("Feminine juice splatters all over from your [vagina] and onto his cock.  " );
			outputText("The giant, however, still needs his release and as he continues pumping, you reach climax more times than you can count. At last, you hear the giant moan, and he drops you on the base of his dick while he finishes himself off. Too exhausted to move, you lay there as the giant cums, gallons of cum shooting in an arc, in slow motion, landing directly on you. You barely manage to gulp down enough to keep from drowning. The giant laughs and grabs you, licks you clean, and sets you down, sheltering you from the cold with his hands and allowing you to fix your armor. Once you redress, the giant lets out a bellowing laugh and saunters off behind a mountain.");
			player.refillHunger(50);
			player.sexReward("cum","Vaginal");
			cleanupAfterCombat();
		}
		
		//All genders!
		private function rideAnally():void {
			clearOutput();
			outputText("You remove the bottom of your [armor] slowly, trying to ease its throbs for attention while you figure out how to calm it. As you inspect the unconscious giant's body, you notice a crack in his frost armor near the crotch. Using your [weapon] to nick more frost away, you find that the giant is indeed male. The giant's huge cock strikes you; flaccid as it is, it still ");
			if (player.tallness < 36) outputText("dwarves your height.");
			else if (player.tallness >= 36 && player.tallness < 48) outputText("matches your height.");
			else outputText("is only slightly shorter than you are tall.");
			outputText("\n\n");
			outputText("You carefully remove and replace pieces of your [armor] so you can slide your " + assholeDescript() + " over the giant's cock without freezing the rest of your body.  Climbing to the giant's crotch, you straddle his dick and feel it before crouching. The giant's body heat makes up for the cold, warm enough to stuff your body. You get into position and slide yourself to release.");
			player.buttChange(144, true, true, false);
			outputText("\n\nWith a bracing breath, you finally make contact. The giant's heat is more intense than your hand registered, and you find yourself easily able to slip back and forth. As you slide over the huge cock, it slowly grows erect, until it towers over you and you can do little more than gyrate your hips to pleasure yourself. You struggle to keep sliding, but it's futile. Fortunately, you reach orgasm.  ");
			outputText("As you stop and ready to dismount the giant, he groans, \"<i>No...</i>\" and grabs a leg in each hand. You try to shout out, but before you have a chance he is quickly sliding you back and forth over his entire length, basically masturbating and taking you for the ride. Feeling every ridge and bump in his dick slide past you, it takes only a few moments for you to reach your limit.\n\n");
			if (player.hasCock()) outputText("You shoot ropes of jism from your [cocks] and cum all over his chest.  ");
			if (player.hasVagina()) outputText("Feminine juice splatters all over from your [vagina] and onto his cock.  " );
			outputText("The giant, however, still needs his release and as he continues pumping, you reach climax more times than you can count. At last, you hear the giant moan, and he finally slides his entire length into you.");
			outputText("You yelp in surprise as the giant cums, filling your bowels completely and stuffing your stomach. The giant laughs and grabs you, licks you clean, and sets you down, sheltering you from the cold with his hands and allowing you to fix your armor. Once you redress, the giant lets out a bellowing laugh and saunters off behind a mountain. You feel warm thanks to being stuffed with his cum.");
			player.refillHunger(30);
			player.sexReward("cum","Anal");
			cleanupAfterCombat();			
		}

		private function gooSleeve():void {
			clearOutput();
			outputText("You eye up the defeated giant then zero in on his massive three feet long cock, your gel like body shivering with anticipation. Cum… so much cum… and it’s all for you!\n"
				+ "\n"
				+ "The grounded giant looks at you in fear as you slosh on his leg towards his cock. You move up to his towering maleness and smile gleefully as you proceed to slide the thing in your gooey pussy, letting his monstrous dick go through your entire length up to the inside of your head. At this point shape is no longer of any consequence as you let your form mold into that of a giant sized onahole fit just for him. The giant tries to pull you off but you stubbornly slip away from his fingers, back to his dick and let your body ripple along his length. The giant moans as you forcefully milk his cock, already tasting his lovely precum. Out of curiosity, you start to slowly enter his urethra, fucking the inside of his cock. The giant is now spasming on the ground below you, jerking his body up and down as you toy with his insides, your entire body at the task of stealing his precious cum. He can’t hold it anymore and begins jerking you up and down his cock, only speeding the inevitable as you keep teasing him.\n"
				+ "\n"
				+ "“<i>You're going to cum, right, big guy?! You're going to cum and fill me full of fantastic semen, right?! I know you want to, so give it! GIVE IT TO ME!!!!</i>”\n"
				+ "\n"
				+ "The giant only gets thrilled all the more as his eyes roll in from both the overwhelming pleasure and pressure stacked on his balls. Speaking of balls, you’ve let your cocksleeve body flow down to his sack, grabbing at his orbs and molesting them like your mouth would on a normal human. You can feel the cum flow inside his sack, the anticipation of taking it in driving you crazy. Now that you mention it, the giant isn't the only one feeling like his body is about to explode, you too feel it as well and it’s just a matter of seconds before you do thanks to the twitching of his dick and balls causing constant ripples in your semi-solid body and bringing you ever closer to orgasm. At long last, he lets out a massive roar as he cums, flooding your liquid form with his delicious fluids as you hang on for dear life, trying to maintain shape so as to not risk losing a single drop. Your body stains with the color of his cum for a few instants before you digest it.\n"
				+ "\n"
				+ "“<i>Mmmm…. I can still absorb so much more.</i>”\n"
				+ "\n"
				+ "The giant gives you a pleading look as you ready for round two, three and four as, far from satisfied, you keep raping him over and over, growing almost bloated with nutrition until there’s nothing to milk anymore. The giant lost consciousness way before you finished, his cock still filling you. You chuckle as you imagine how dry this big guy is going to feel when he wakes up.\n"
				+ "\n"
				+ "You are drooling, still ecstatic, from your recent meal as you leave the passed out giant behind you, heading back to camp.\n");
			player.sexReward("cum", "Lips");
			player.slimeFeed(5);
			cleanupAfterCombat();
		}
	}

}