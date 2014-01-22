/**
 * Created by aimozg on 18.01.14.
 */
package classes.Items.Consumables
{
import classes.Appearance;
import classes.Player;
	import classes.internals.Utils;

	public class BimboLiqueur extends SimpleConsumable
	{

		override public function canUse(player:Player, output:Boolean):Boolean
		{
			if(player.hasPerk("Futa Form") >= 0) {
				if (output) outputText("Ugh.  This stuff is so, like... last year.  Maybe you can find someone else to feed it to?\n\n");
				return false;
			}
			return true;
		}

		private function bimboLiquer(player:Player):void
		{
			clearOutput();
			if (player.hasPerk("Bro Body") >= 0) {
				outputText("You wince as the stuff hits your stomach, already feeling the insidious effects beginning to take hold.  A lengthy belch escapes your lips as your stomach gurgles, and you giggle abashedly to yourself.");
				if (player.tallness < 77) {
					outputText(" ...Did the ground just get farther away?  You glance down and realize, you're growing!  Like a sped-up flower sprout, you keep on getting taller until finally stopping around... six and a half feet, you assume.  Huh.  You didn't expect that to happen!");
					player.tallness = 77;
				}
				if (player.biggestTitSize() < 7) {
					if (player.biggestTitSize() < 1) outputText("  Tingling, your chest begins to itch, then swell into a pair of rounded orbs.  ");
					outputText("  They quiver ominously, and you can't help but squeeze your tits together to further appreciate the boobquake as another tremor runs through them.  Unexpectedly, the shaking pushes your hands further apart as your tits balloon against each other, growing rapidly against your now-sunken fingers.  The quakes continue until calming at around an E-cup.");
					player.breastRows[0].breastRating = 7;
				}
				//(If vagina = 2tight:
				if (!player.hasVagina()) {
					outputText("  Before you can even take a breath, an extremely peculiar sensation emanates from your crotch.  You can't see through your " + player.armorName + ", but you can certainly feel the vagina splitting from behind your testicles.  Luckily, the cunt-forming doesn't yield any discomfort - on the contrary, you feel yourself falling farther into your chemically-dulled, libido-fueled rut.");
					if (player.hipRating < 12 || player.buttRating < 12) outputText("  As if realizing the necessity of womanly proportions to attract the hard cocks your body now craves, your waist pinches slightly inward and your hips and butt swell.  You can't help but run a hand across your newly-feminized pelvis, admiring it.");
					player.createVagina();
					if (player.hipRating < 12) player.hipRating = 12;
					if (player.buttRating < 12) player.buttRating = 12;
				}
				outputText("\n\n");
				outputText("A wave of numbness rolls through your features, alerting you that another change is happening.  You reach up to your feel your jaw narrowing, becoming more... feminine?  Heavy, filling lips purse in disappointment as your face takes on a very feminine cast.  You're probably pretty hot now!\n\n");
				if (player.femininity < 80) player.femininity = 80;

				outputText("Your surging, absurdly potent libido surges through your body, reminding you that you need to fuck.  Not just bitches, but guys too.  Hard cocks, wet pussies, hell, you don't care.  They can have both or a dozen of either.  You just want to get laid and bone something, hopefully at the same time!");
				outputText("\n\n<b>(Perks Lost: Bro Body");
				if (player.hasPerk("Bro Brains") >= 0) outputText(", Bro Brains");
				outputText(")\n");
				outputText("(Perks Gained: Futa Form, Futa Faculties)\n");
				player.removePerk("Bro Body");
				player.removePerk("Bro Brains");
				player.createPerk("Futa Faculties", 0, 0, 0, 0, "");
				player.createPerk("Futa Form", 0, 0, 0, 0, "");
				if (player.inte > 35) {
					player.inte = 35;
					game.dynStats("int", -0.1);
				}
				if (player.lib < 50) {
					player.lib = 50;
					game.dynStats("lib", .1);
				}
			}
			else {
				outputText("You pop the cork from the flask and are immediately assaulted by a cloying, spiced scent that paints visions of a slutty slave-girl's slightly-spread folds.  Wow, this is some potent stuff!  Well, you knew what you were getting into when you found this bottle!  You open wide and guzzle it down, feeling the fire of alcohol burning a path to your belly.  The burning quickly fades to a pleasant warmth that makes you light-headed and giggly.\n\n");
				if (player.hairColor != "platinum blonde") {
					outputText("The first change that you notice is to your " + player.hairDescript() + ".  It starts with a tingling in your scalp and intensifies ");
					if (player.hairLength < 36) {
						outputText("as you feel the weight of your hair growing heavier and longer.");
						player.hairLength = 36;
					}
					else outputText("as your hair grows thicker and heavier.");
					outputText("  You grab a lock of the silken strands and watch open-mouthed while streaks so blonde they're almost white flow down the " + player.hairColor + " hair.  It goes faster and faster until your hair has changed into perfectly bimbo-blonde, flowing locks.\n\n");
					player.hairColor = "platinum blonde";
				}

				outputText("Moaning lewdly, you begin to sway your hips from side to side, putting on a show for anyone who might manage to see you.   You just feel so... sexy.  Too sexy to hide it.  Your body aches to show itself and feel the gaze of someone, anyone upon it.  Mmmm, it makes you so wet!  ");
				if (!player.hasVagina()) {
					player.createVagina();
					player.vaginas[0].vaginalWetness = Appearance.VAGINA_WETNESS_SLICK;
					if (player.isTaur()) outputText("Wait!? Wet? You wish you could touch yourself between the " + player.legs() + ", but you can tell from the fluid running down your hind-legs just how soaked your new vagina is.");
					else outputText("Wait!?  Wet?  You touch yourself between the " + player.legs() + " and groan when your fingers sink into a sloppy, wet cunt.");
				}
				else {
					if (player.isTaur()) {
						outputText("You wish you could sink your fingers into your sloppy, wet cunt, but as a centaur, you can't quite reach.");
						if (player.vaginas[0].vaginalWetness < Appearance.VAGINA_WETNESS_SLICK)
							player.vaginas[0].vaginalWetness = Appearance.VAGINA_WETNESS_SLICK;
					}
					else {
						outputText("You sink your fingers into your ");
						if (player.vaginas[0].vaginalWetness < Appearance.VAGINA_WETNESS_SLICK) {
							outputText("now ");
							player.vaginas[0].vaginalWetness = Appearance.VAGINA_WETNESS_SLICK;
						}
						outputText("sloppy, wet cunt with a groan of satisfaction.");
					}
				}
				if (player.balls > 0) {
					outputText("\n\nThere's a light pinch against your [sack] that makes you gasp in surprise, followed by an exquisite tightness that makes your [vagina] drool.  Looking down, <b>you see your balls slowly receding into your body, leaving nothing behind but your puffy mons.</b>");
					player.balls = 0;
					player.ballSize = 3;
					player.cumMultiplier = 2;
				}
				if (player.hasCock()) {
					outputText("\n\n[EachCock] seems to be responding to the liqueur in its own way.  Clenching and relaxing obscenely, your genitals begin to drizzle cum onto the ground in front of you, throwing you into paroxysms of bliss.  The flow of cum is steady but weak, and each droplet that leaves you lets [eachCock] go more flaccid.  Even once you're soft and little, it doesn't stop.  You cum your way down to nothing, a tiny droplet heralding your new, girlish groin.  <b>You no longer have ");
					if (player.cockTotal() == 1) outputText("a penis");
					else outputText("penises");
					outputText("!</b>");
					while (player.hasCock()) {
						player.removeCock(0, 1);
					}
				}
				outputText("  Somehow, you feel like you could seduce anyone right now!\n\n");

				outputText("Another bubbly giggle bursts from your lips, which you then lick hungrily.  You, like, totally want some dick to suck!  Wow, that came out of left field.  You shake your head and try to clear the unexpected, like, words from your head but it's getting kind of hard.  Omigosh, you feel kind of like a dumb bimbo after, like, drinking that weird booze.  Oh, well, it doesn't matter anyhow – you can, like, still stop the demons and stuff.  You'll just have to show off your sexy bod until they're offering to serve you.\n\n");

				outputText("You sigh and run one hand over your " + player.nippleDescript(0) + "s");
				if (player.breastRows[0].breastRating < 10) {
					player.breastRows[0].breastRating += 5 + Utils.rand(5);
					outputText(", surprised at how large and rounded your expanding breasts have become while fresh tit-flesh continues to spill out around your needy fingers.  They feel so supple and soft, but when you let them go, they still sit fairly high and firm on your chest.  The newer, more generous, " + player.breastCup(0) + " cleavage has you moaning with how sensitive it is, pinching a nipple with one hand ");
				}
				else {
					player.breastRows[0].breastRating += 5 + Utils.rand(5);
					outputText(", admiring how sensitive they're getting.  The big breasts start getting bigger and bigger, soft chest-flesh practically oozing out between your fingers as the squishy mammaries sprout like weeds, expanding well beyond any hand's ability to contain them.  The supple, " + player.breastCup(0) + " boobs still manage to sit high on your chest, almost gravity defying in their ability to generate cleavage.  You pinch a nipple with one hand ");
				}
				game.dynStats("sen", 20);
				outputText("while the other toys with the juicy entrance of your folds.  Mmmm, it, like, feels too good not to touch yourself, and after being worried about getting all dumb and stuff, you need to relax.  Thinking is hard, but sex is so easy and, like, natural!  You lean back and start grunting as you plunge four fingers inside yourself, plowing your " + player.vaginaDescript(0) + " like no tomorrow.  By now, your " + player.clitDescript() + " is throbbing, and you give it an experimental ");
				if (player.clitLength >= 3) outputText("jerk ");
				else outputText("caress ");
				outputText("that makes your " + player.legs() + " give out as you cum, splattering female fluids as you convulse nervelessly on the ground.\n\n");

				outputText("Though the orgasm is intense, you recover a few moments later feeling refreshed, but still hot and horny.  Maybe you could find a partner to fuck?  After all, sex is, like, better with a partner or two.  Or that number after two.  You brush a lengthy, platinum blonde strand of hair out of your eyes and lick your lips - you're ready to have some fun!\n\n");

				if (player.hipRating < 12 || player.buttRating < 12) {
					outputText("As you start to walk off in search of a sexual partner, you feel your center of balance shifting.");
					if (player.hipRating < 12 && player.buttRating < 12) {
						outputText("  Your ass and hips inflate suddenly, forcing you to adopt a slow, swaying gait.  You find that rolling your hips back and forth comes naturally to you.  You make sure to squeeze your butt-muscles and make your curvy tush jiggle as you go.");
						player.buttRating = 12;
						player.hipRating = 12;
					}
					else if (player.hipRating < 12) {
						outputText("  Your hips widen suddenly, forcing you to adopt a slow, swaying gait.  You find that rolling yours hips back and forth comes naturally to you, and your big, obscene ass seems to jiggle all on its own with every step you take.");
						player.hipRating = 12;
					}
					else {
						outputText("  Your [butt] swells dramatically, the puffy cheeks swelling with newfound weight that jiggles along with each step.  Clenching your glutes to make the posh cheeks jiggle a little more enticingly becomes second nature to you in a few seconds.");
						player.buttRating = 12;
					}
					outputText("\n\n");
				}
				if (player.tone > 0) {
					outputText("Like, weirdest of all, your muscles seem to be vanishing!  Before your eyes, all muscle tone vanishes, leaving your body soft and gently curvy.  You poke yourself and giggle!  Everyone's totally going to want to, like, rub up against you at every opportunity.  Your thighs are so soft you bet you could squeeze a pair of dicks to orgasm without even touching your moist cunny.");
					player.tone = 0;
					if (player.str >= 30) {
						if (player.str >= 70) game.dynStats("str", -10);
						if (player.str >= 90) game.dynStats("str", -10);
						if (player.str >= 50) game.dynStats("str", -10);
						game.dynStats("str", -5);
						outputText("  It does get a bit harder to carry yourself around with your diminished strength, but that's, like, what big strong hunks are for anyways!  You can just flirt until one of them volunteers to help out or something!  Besides, you don't need to be strong to jerk off cocks or finger slutty pussies!");
					}
					outputText("\n\n");
				}
				if (player.hasPerk("Bimbo Body") < 0) {
					outputText("<b>(Bimbo Body - Perk Gained!)\n");
					player.createPerk("Bimbo Body", 0, 0, 0, 0, "You have the body of a bimbo.  Your tits will never stay below a 'DD' cup, you're much lustier, more accustomed to being turned on, and you gain a bonus to using your body to arouse your enemies in combat!");
				}
				if (player.hasPerk("Bimbo Brains") < 0) {
					outputText("(Bimbo Brains - Perk Gained!)\n");//int to 20.  max int 50)
					player.createPerk("Bimbo Brains", 0, 0, 0, 0, "Now that you've drank bimbo liquer, you'll never, like, have the attention span and intelligence you once did!  But it's okay, 'cause you get to be so horny an' stuff!");
					if (player.inte > 21) player.inte = 21;
				}
				game.dynStats("int", -1, "lib", 4, "sen", 25, "lus=", 0);
				//FULL ON BITCHFACE
				player.modFem(100, 100);
				//Body
				//Tease/Seduce Boost
				//*boosts min lust and lust resistance)
				//*Tit size
				//Brain
				//Max int - 50
			}
			player.genderCheck();
		}

		public function BimboLiqueur()
		{
			super("BimboLq", "BimboLq", "a potent bottle of 'Bimbo Liqueur'", bimboLiquer, 1000,"This small bottle of liqueur is labelled 'Bimbo Liqueur'.  There's a HUGE warning label about the effects being strong and usually permanent, so you should handle this with care.");
		}
	}
}
