/**
 * Created by aimozg on 18.01.14.
 */
package classes.Items.Consumables
{
	import classes.Appearance;
	import classes.PerkLib;
	import classes.Player;
	import classes.internals.Utils;
	import classes.Items.Consumable;

	public class BimboLiqueur extends Consumable {
		
		public function BimboLiqueur() {
			super("BimboLq", "BimboLq", "a potent bottle of 'Bimbo Liqueur'", 1000, "This small bottle of liqueur is labelled 'Bimbo Liqueur'.  There's a HUGE warning label about the effects being strong and usually permanent, so you should handle this with care.");
		}
		
		override public function canUse():Boolean {
			if (game.player.findPerk(PerkLib.FutaForm) < 0) return true;
			outputText("Ugh.  This stuff is so, like... last year.  Maybe you can find someone else to feed it to?\n\n");
			return false;
		}

		override public function useItem():Boolean {
			if (game.player.findPerk(PerkLib.BroBody) >= 0) {
				outputText("You wince as the stuff hits your stomach, already feeling the insidious effects beginning to take hold.  A lengthy belch escapes your lips as your stomach gurgles, and you giggle abashedly to yourself.");
				if (game.player.tallness < 77) {
					outputText(" ...Did the ground just get farther away?  You glance down and realize, you're growing!  Like a sped-up flower sprout, you keep on getting taller until finally stopping around... six and a half feet, you assume.  Huh.  You didn't expect that to happen!");
					game.player.tallness = 77;
				}
				if (game.player.biggestTitSize() < 7) {
					if (game.player.biggestTitSize() < 1)
						outputText("  Tingling, your chest begins to itch, then swell into a pair of rounded orbs.  ");
					else outputText("  You feel a tingling inside your breasts.  ");
					outputText("They quiver ominously, and you can't help but squeeze your tits together to further appreciate the boobquake as another tremor runs through them.  Unexpectedly, the shaking pushes your hands further apart as your tits balloon against each other, growing rapidly against your now-sunken fingers.  The quakes continue until calming at around an E-cup.");
					game.player.breastRows[0].breastRating = 7;
				}
				//(If vagina = 2tight:
				if (!game.player.hasVagina()) {
					outputText("  Before you can even take a breath, an extremely peculiar sensation emanates from your crotch.  You can't see through your " + game.player.armorName + ", but you can certainly feel the vagina splitting " + (game.player.balls > 0 ? "from behind your testicles" : "your groin") + ".  Luckily, the cunt-forming doesn't yield any discomfort - on the contrary, you feel yourself falling farther into your chemically-dulled, libido-fueled rut.");
					if (game.player.hipRating < 12 || game.player.buttRating < 12) outputText("  As if realizing the necessity of womanly proportions to attract the hard cocks your body now craves, your waist pinches slightly inward and your hips and butt swell.  You can't help but run a hand across your newly-feminized pelvis, admiring it.");
					game.player.createVagina();
					game.player.clitLength = 0.25;
					if (game.player.hipRating < 12) game.player.hipRating = 12;
					if (game.player.buttRating < 12) game.player.buttRating = 12;
				}
				outputText("\n\n");
				outputText("A wave of numbness rolls through your features, alerting you that another change is happening.  You reach up to your feel your jaw narrowing, becoming more... feminine?  Heavy, filling lips purse in disappointment as your face takes on a very feminine cast.  You're probably pretty hot now!\n\n");
				if (game.player.femininity < 80) game.player.femininity = 80;

				outputText("Your surging, absurdly potent libido surges through your body, reminding you that you need to fuck.  Not just bitches, but guys too.  Hard cocks, wet pussies, hell, you don't care.  They can have both or a dozen of either.  You just want to get laid and bone something, hopefully at the same time!");
				outputText("\n\n<b>(Perks Lost: Bro Body");
				if (game.player.findPerk(PerkLib.BroBrains) >= 0) outputText(", Bro Brains");
				outputText(")\n");
				outputText("(Perks Gained: Futa Form, Futa Faculties)\n");
				game.player.removePerk(PerkLib.BroBody);
				game.player.removePerk(PerkLib.BroBrains);
				game.player.createPerk(PerkLib.FutaFaculties, 0, 0, 0, 0);
				game.player.createPerk(PerkLib.FutaForm, 0, 0, 0, 0);
				if (game.player.inte > 35) {
					game.player.inte = 35;
					game.dynStats("int", -0.1);
				}
				if (game.player.lib < 50) {
					game.player.lib = 50;
					game.dynStats("lib", .1);
				}
			}
			else {
				outputText("You pop the cork from the flask and are immediately assaulted by a cloying, spiced scent that paints visions of a slutty slave-girl's slightly-spread folds.  Wow, this is some potent stuff!  Well, you knew what you were getting into when you found this bottle!  You open wide and guzzle it down, feeling the fire of alcohol burning a path to your belly.  The burning quickly fades to a pleasant warmth that makes you light-headed and giggly.\n\n");
				if (game.player.hairColor != "platinum blonde") {
					outputText("The first change that you notice is to your " + game.player.hairDescript() + ".  It starts with a tingling in your scalp and intensifies ");
					if (game.player.hairLength < 36) {
						outputText("as you feel the weight of your hair growing heavier and longer.");
						game.player.hairLength = 36;
					}
					else outputText("as your hair grows thicker and heavier.");
					outputText("  You grab a lock of the silken strands and watch open-mouthed while streaks so blonde they're almost white flow down the " + game.player.hairColor + " hair.  It goes faster and faster until your hair has changed into perfectly bimbo-blonde, flowing locks.\n\n");
					game.player.hairColor = "platinum blonde";
				}

				outputText("Moaning lewdly, you begin to sway your hips from side to side, putting on a show for anyone who might manage to see you.   You just feel so... sexy.  Too sexy to hide it.  Your body aches to show itself and feel the gaze of someone, anyone upon it.  Mmmm, it makes you so wet!  ");
				if (!game.player.hasVagina()) {
					game.player.createVagina();
					game.player.clitLength = 0.25;
					game.player.vaginas[0].vaginalWetness = Appearance.VAGINA_WETNESS_SLICK;
					if (game.player.isTaur()) outputText("Wait!? Wet? You wish you could touch yourself between the " + game.player.legs() + ", but you can tell from the fluid running down your hind-legs just how soaked your new vagina is.");
					else outputText("Wait!?  Wet?  You touch yourself between the " + game.player.legs() + " and groan when your fingers sink into a sloppy, wet cunt.");
				}
				else {
					if (game.player.isTaur()) {
						outputText("You wish you could sink your fingers into your sloppy, wet cunt, but as a centaur, you can't quite reach.");
						if (game.player.vaginas[0].vaginalWetness < Appearance.VAGINA_WETNESS_SLICK)
							game.player.vaginas[0].vaginalWetness = Appearance.VAGINA_WETNESS_SLICK;
					}
					else {
						outputText("You sink your fingers into your ");
						if (game.player.vaginas[0].vaginalWetness < Appearance.VAGINA_WETNESS_SLICK) {
							outputText("now ");
							game.player.vaginas[0].vaginalWetness = Appearance.VAGINA_WETNESS_SLICK;
						}
						outputText("sloppy, wet cunt with a groan of satisfaction.");
					}
				}
				if (game.player.balls > 0) {
					outputText("\n\nThere's a light pinch against your [sack] that makes you gasp in surprise, followed by an exquisite tightness that makes your [vagina] drool.  Looking down, <b>you see your balls slowly receding into your body, leaving nothing behind but your puffy mons.</b>");
					game.player.balls = 0;
					game.player.ballSize = 3;
					game.player.cumMultiplier = 2;
				}
				if (game.player.hasCock()) {
					outputText("\n\n[EachCock] seems to be responding to the liqueur in its own way.  Clenching and relaxing obscenely, your genitals begin to drizzle cum onto the ground in front of you, throwing you into paroxysms of bliss.  The flow of cum is steady but weak, and each droplet that leaves you lets [eachCock] go more flaccid.  Even once you're soft and little, it doesn't stop.  You cum your way down to nothing, a tiny droplet heralding your new, girlish groin.  <b>You no longer have ");
					if (game.player.cockTotal() == 1) outputText("a penis");
					else outputText("penises");
					outputText("!</b>");
					while (game.player.hasCock()) {
						game.player.removeCock(0, 1);
					}
				}
				outputText("  Somehow, you feel like you could seduce anyone right now!\n\n");

				outputText("Another bubbly giggle bursts from your lips, which you then lick hungrily.  You, like, totally want some dick to suck!  Wow, that came out of left field.  You shake your head and try to clear the unexpected, like, words from your head but it's getting kind of hard.  Omigosh, you feel kind of like a dumb bimbo after, like, drinking that weird booze.  Oh, well, it doesn't matter anyhow – you can, like, still stop the demons and stuff.  You'll just have to show off your sexy bod until they're offering to serve you.\n\n");

				outputText("You sigh and run one hand over your " + game.player.nippleDescript(0) + "s");
				if (game.player.breastRows[0].breastRating < 10) {
					game.player.breastRows[0].breastRating += 5 + Utils.rand(5);
					outputText(", surprised at how large and rounded your expanding breasts have become while fresh tit-flesh continues to spill out around your needy fingers.  They feel so supple and soft, but when you let them go, they still sit fairly high and firm on your chest.  The newer, more generous, " + game.player.breastCup(0) + " cleavage has you moaning with how sensitive it is, pinching a nipple with one hand ");
				}
				else {
					game.player.breastRows[0].breastRating += 5 + Utils.rand(5);
					outputText(", admiring how sensitive they're getting.  The big breasts start getting bigger and bigger, soft chest-flesh practically oozing out between your fingers as the squishy mammaries sprout like weeds, expanding well beyond any hand's ability to contain them.  The supple, " + game.player.breastCup(0) + " boobs still manage to sit high on your chest, almost gravity defying in their ability to generate cleavage.  You pinch a nipple with one hand ");
				}
				game.dynStats("sen", 20);
				outputText("while the other toys with the juicy entrance of your folds.  Mmmm, it, like, feels too good not to touch yourself, and after being worried about getting all dumb and stuff, you need to relax.  Thinking is hard, but sex is so easy and, like, natural!  You lean back and start grunting as you plunge four fingers inside yourself, plowing your " + game.player.vaginaDescript(0) + " like no tomorrow.  By now, your " + game.player.clitDescript() + " is throbbing, and you give it an experimental ");
				if (game.player.clitLength >= 3) outputText("jerk ");
				else outputText("caress ");
				outputText("that makes your " + game.player.legs() + " give out as you cum, splattering female fluids as you convulse nervelessly on the ground.\n\n");

				outputText("Though the orgasm is intense, you recover a few moments later feeling refreshed, but still hot and horny.  Maybe you could find a partner to fuck?  After all, sex is, like, better with a partner or two.  Or that number after two.  You brush a lengthy, platinum blonde strand of hair out of your eyes and lick your lips - you're ready to have some fun!\n\n");

				if (game.player.hipRating < 12 || game.player.buttRating < 12) {
					outputText("As you start to walk off in search of a sexual partner, you feel your center of balance shifting.");
					if (game.player.hipRating < 12 && game.player.buttRating < 12) {
						outputText("  Your ass and hips inflate suddenly, forcing you to adopt a slow, swaying gait.  You find that rolling your hips back and forth comes naturally to you.  You make sure to squeeze your butt-muscles and make your curvy tush jiggle as you go.");
						game.player.buttRating = 12;
						game.player.hipRating = 12;
					}
					else if (game.player.hipRating < 12) {
						outputText("  Your hips widen suddenly, forcing you to adopt a slow, swaying gait.  You find that rolling yours hips back and forth comes naturally to you, and your big, obscene ass seems to jiggle all on its own with every step you take.");
						game.player.hipRating = 12;
					}
					else {
						outputText("  Your [butt] swells dramatically, the puffy cheeks swelling with newfound weight that jiggles along with each step.  Clenching your glutes to make the posh cheeks jiggle a little more enticingly becomes second nature to you in a few seconds.");
						game.player.buttRating = 12;
					}
					outputText("\n\n");
				}
				if (game.player.tone > 0) {
					outputText("Like, weirdest of all, your muscles seem to be vanishing!  Before your eyes, all muscle tone vanishes, leaving your body soft and gently curvy.  You poke yourself and giggle!  Everyone's totally going to want to, like, rub up against you at every opportunity.  Your thighs are so soft you bet you could squeeze a pair of dicks to orgasm without even touching your moist cunny.");
					game.player.tone = 0;
					if (game.player.str >= 30) {
						if (game.player.str >= 90) game.dynStats("str", -10);
						if (game.player.str >= 70) game.dynStats("str", -10);
						if (game.player.str >= 50) game.dynStats("str", -10);
						game.dynStats("str", -5);
						outputText("  It does get a bit harder to carry yourself around with your diminished strength, but that's, like, what big strong hunks are for anyways!  You can just flirt until one of them volunteers to help out or something!  Besides, you don't need to be strong to jerk off cocks or finger slutty pussies!");
					}
					outputText("\n\n");
				}
				if (game.player.findPerk(PerkLib.BimboBody) < 0) {
					outputText("<b>(Bimbo Body - Perk Gained!)\n");
					game.player.createPerk(PerkLib.BimboBody, 0, 0, 0, 0);
				}
				if (game.player.findPerk(PerkLib.BimboBrains) < 0) {
					outputText("(Bimbo Brains - Perk Gained!)\n");//int to 20.  max int 50)
					game.player.createPerk(PerkLib.BimboBrains, 0, 0, 0, 0);
					if (game.player.inte > 21) {
						var boost:Number = game.player.inte / 5;
						game.player.inte = 21 + boost;
					}
				}
				game.player.orgasm();
				game.dynStats("int", -1, "lib", 4, "sen", 25);
				//FULL ON BITCHFACE
				game.player.modFem(100, 100);
				//Body
				//Tease/Seduce Boost
				//*boosts min lust and lust resistance)
				//*Tit size
				//Brain
				//Max int - 50
			}
			game.player.genderCheck();
			return(false);
		}
	}
}
