/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.GlacialRift 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.CoC;
	import classes.Scenes.UniqueSexScenes;
	
	public class WinterWolfScene extends BaseContent 
	{
		public var uniquuuesexscene:UniqueSexScenes = new UniqueSexScenes();
		
		public function WinterWolfScene() 
		{
		}
		
		public function loseToWinterWolf():void {
			clearOutput();
			getFuckedByWinterWolfDoggyStyle();
		}
		
		public function winAgainstWinterWolf():void {
			menu();
			if (player.lust >= 33) {
				if (player.hasCock()) {
					clearOutput();
					outputText("You don't see anything interesting to do with the defeated wolf and decide to simply leave him be.");
				}
				if (player.hasVagina()) {
					addButton(0, "RideHisCock", rideWinterWolfsCock);
				}
				if (player.pcCanUseUniqueSexScene()) addButton(13, "U. Sex Scenes", uniquuuesexscene.pcUniqueSexScenesChoiceMenu).hint("Other non typical sex scenes.");
				addButton(14, "Leave", cleanupAfterCombat);
			}
			else {
				cleanupAfterCombat();
			}
		}
		
		private function getFuckedByWinterWolfDoggyStyle():void {
			if (player.HP <= 0) outputText("Too weak to continue fighting, you fall to your knees.");
			else outputText("Overcome by sexual desire, you submit to the hungry winter wolf.");
			outputText("\n\nThe winter wolf grin with wicked desire as his sheathed pecker grow full mast. As the wolf stands before you, your eyes widen at the sight of its equipment: a eighteen-inch long monster with a massive sack containing a pair of freezing cold balls underneath. As the wolf swaggers closer, you gulp at the thought of what those balls likely are going to be pumping into you. You are helpless against the wolf as he pushes you onto your hands and knees and positions himself behind you. He grips you with his massive clawed paws on your shoulders and easily holds you in place. The powerful creature is easily able to get past your comfortable clothes and you ");
			if (player.hasVagina()) {
				outputText("feel his rod brush against your tight ass. A shudder shoots through your body as he brings his massive ");
			}
			else {
				outputText("feel his massive rod brush against your toned ass. A shudder shoots through your body as he brings his ");
			}
			outputText("head down to either side of your own indecisive, his icy canine breath blowing past your ears. He stays there for a few moments, completely still... before suddenly pulling his head back and slamming his dick into your ");
			if (player.hasVagina()) {
				outputText("" + vaginaDescript(0) + ". You feel an intense mixture of sensations in your lower body as your " + vaginaDescript(0) + " is filled with an intense pleasure at being filled with the creature’s large member. ");
				if (player.vaginas[0].virgin) outputText("You are no longer a virgin! Your hymen is torn, robbing you of your virginity. ");
				if (player.cuntChange(monster.cockArea(0), false)) outputText("The beast howls as your " + vaginaDescript(0) + " is stretched to accommodate the large shaft. ");
				outputText("The wolf pants for a few seconds before continuing. The pause gives your " + vaginaDescript(0) + " time to moisten, ensuring the next thrust won’t be quite as rough. This time the beast starts pumping in and out more gently, only a short distance at a time as the wolf continues panting. Each thrust of the beast’s manhood bring you closer and closer to your peak.");
				outputText("\n\nAs you reach your climax, the beast howls and you feel it's incredibly cold seed pour into you. His freezing seed brings about a pleasure you had not expected; your insides feel like they are overflowing with power and calm serenity. It is an incredible and cool experience. Too soon, the beast pulls out of you. He gives your " + vaginaDescript(0) + " a single extended lick with his long wolf-like tongue before he runs off. You quickly look over and manage to catch a glimpse of its tail before it disappears from view in the blizzard, just before your body falls into a deep sleep. When you wake, you can still feel the afterglow of the icy seed inside you.");
			}
			else {
				outputText("" + assholeDescript() + ". Your lower body explodes with pain as the wolf forces himself in too quickly for your " + assholeDescript() + " to handle. He pauses and pants for a few seconds, but you barely have enough time to catch your breath before the beast starts thrusting in and out again. However, this time the beast starts pumping in and out more gently, only a short distance at a time as the wolf continues panting. As the pain in your " + assholeDescript() + " fades, you start feeling strong pleasure from it. Each thrust of the beast’s manhood brings you closer and closer to your peak.");
				outputText("\n\nAs you reach your climax, the beast howls and you feel it's horribly cold seed pour into you. You moan while trying to break free... but the beast keeps a firm grip on you as more and more of its ice cold seed is pumped into your body. After what feels like an eternity, the beast pulls out of you. He gives your " + assholeDescript() + " a single extended lick with his long dog-like tongue before running off out of sight. You are finally able to roll around but you can do nothing about the cold inside you. The cold proves to be too much and you pass out. ");
				outputText("After some time passes, you wake up to find the ice inside you has thankfully faded away. You’re able to stand up again, but the damage is done and the creature’s seed has left you feeling rather weak.");
				player.buttChange(monster.cockArea(0), true);
			}
			player.slimeFeed();
			player.orgasm();
			cleanupAfterCombat();
		}
		
		private function rideWinterWolfsCock():void {
			clearOutput();
			outputText("The winter wolf’s icy chill  dim and the it let out a whine before the creature slumps down, defeated and barely conscious. After all the trouble you had with him, you want to have some fun in exchange. \"<i>Bad boy, roll over!</i>\" you command as if the Winter wolf was just an ordinary domestic dog.  To your surprise the creature actually does as you say. Accepting your victory he rolls onto his back, exposing his furry chest, ");
			outputText("signaling submissiveness. Looking down on your foe, your lustful gaze rests upon his privates. You examine the glowing blue ballsack with its quite large testes, but the real treasure is yet to be found. Pulling on his sheath you reveal his wolf eighteen-inch long members. An obsessive idea comes to your mind and you are determined to put his magnificent tools to a good use.");
			outputText("\n\nYou start caressing his wonderful canine cocks. Although the Winter wolf is pretty out of it, his dick spring to life, extending rapidly from the sheath. Tentatively you give it a gentle lick, being rewarded with a drop of pre-cum.");
			outputText("\n\nThe musky scent sends pleasure all over your body, moistening your muff. You decide the foreplay is over and remove the lower part of your comfortable clothes. You stroke his members, bringing it to full, overly-erect state. You grab the wolf throbbing member, guiding it to your now soaking vagina. Slowly you let yourself down, impaling yourself on his gorgeous member. Your fuck-hole is now very loose. ");
			player.cuntChange(monster.cockArea(0), true);
			outputText("His magical natural ice fill your body with cooling clarity, allowing you to feel him twice as more. You pick yourself up, letting the wolf’s cock nearly escape your nethers just to sit down again, taking the wolf member to the hilt. Grabbing his hind legs like the handlebars of an exercise machine, you bring yourself into position for a good amount of training. Gradually, you pick up the pace, rocking your hips up and down, enjoying the awesome penetration. ");
			outputText("Your [chest] jiggle in exquisite ways along with your bumping, grinding motions. The dick in your moist cunt stretch you nicely, pushing more and more girl-fluids out of your slippery slit while stimulating your sensitive clit from the inside. You lean forward, running your hands through your fuckpet’s dense white fur, feeling his animal body. The wolf is moaning and panting beneath you, unsure whether to fear you or to enjoy what you are doing to him.");
			outputText("\n\nWay too early, the doggie prick stuffed inside you start to twitch, unloading his balls worth of spunk into you. In ecstasy, the wolf’s eyes look in two different directions. The eruption in your love-canal feels amazing, dumping cum into your body over and over. The wolf’s contractions ebb away as he finishes, but you’re not done yet. You slowly start tilting your hips back and forth, continuing to fiercely fuck the member. Soon the wolf whines from the unwanted stimulation of his now sensitive prick, but he is too defeated to put up much of a struggle.");
			outputText("\n\nSlowly but steadily you bring yourself to the verge of orgasm. The wolf under you squirms and tries to get free, his hind legs flailing through the air behind your back. You keep riding his magnificent member, grinding it up and down in your moist cave. Finally you feel the familiar rippling of your vaginal walls, milking his cock and intensifying your pleasant sensations. Clamping down on his member, you keep moving your hips in a circling motion, working your clit and vagina. The sensations eventually grant you an intense orgasm while the wolf’s still-distended member apply the perfect pressure to all of your sensitive spots and prolong your bliss.");
			outputText("\n\nBusy with your own orgasm, you barely notice the twitching of his prick buried inside you. The wolf launches into another orgasm or two, his dong aching for peace and wanting to go soft, but forced to orgasm by your body. You clench your muscles, locking the blood in the throbbing member, trying to preserve the sensations forever.");
			outputText("\n\nFinally having finished the wolf curls up, spent, his tail covering his privates. His rod look a little red from the intense fuck.");
			player.slimeFeed();
			player.orgasm();
			cleanupAfterCombat();
		}
	}

}