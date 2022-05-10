/**
 * ...
 * @author Liadri
 */
package classes.Items.Armors 
{
import classes.Items.Armor;
import classes.Items.ItemTags;
import classes.lists.BreastCup;

	public class BattleMaidenArmor extends Armor {
		
		public function BattleMaidenArmor()
		{
			super("BMArmor", "BMArmor", "Battle maiden armor", "a Battle maiden armor", 40, 0, 1600, "The purified original maiden armor recovered its former property. It fully protect the virginity of its wielder even going so far as to progressively clear the fog of lust from her mind.", "Light", false, false);
			withTag(ItemTags.REVEALING);
		}
		
		override public function canUse():Boolean {
			if (!super.canUse()) {
				return false;
			}
			if (game.player.biggestTitSize() < BreastCup.A) { //{No titties}
				outputText("You slide the bikini top over your chest and buckle it into place, but the material hangs almost comically across your flat chest.  The cold chain dangles away from you, swaying around ridiculously before smacking, cold and hard into your [nipples].  This simply won't do - it doesn't fit you, and you switch back to your old armor.\n\n");
				return false;
			}
			if (game.player.biggestTitSize() < BreastCup.D) { //{Too small titties}
				outputText("You slide the bikini top over your chest, shivering when the cold chains catch on your nipples, stiffening them nicely. The material nicely accentuates your chest, but there's a definite problem.  Your [chest] aren't big enough!  Sure, they look nice done up in glittering silver and gold trim.  If only the metal wasn't hanging loosely around your underbust, flopping around whenever you move.  It doesn't even look that sexy on you!  You'll need a bigger chest to truly make use of this armor.  For now, you switch back to your old equipment.\n\n");
				return false;
			}
			if (game.player.level < 40) {
				outputText("You try and wear the legendary armor but to your disapointment the item simply refuse to stay on your body. It would seem you yet lack the power and right to wield this item.");
				return false;
			}
			outputText("You slide the bikini top over your more than ample chest, shivering at the touch of the cold metal on your sensitive nipples.  It stretches taut around each of your globes, and by the time you're snapping the narrow leather strap behind your back, the exotic metal bra has grown warm enough to make your chest tingle pleasantly.  Your hands find their way to your jiggling, gilded mounds and grab hold, fingers sinking into the shimmering flesh without meaning to.  Your nipples scrape along a diaphanous inner lining so pleasantly that a moan slips out of your mouth as you admire how your cleavage bulges out above the glittery cups.  A narrow band of steel with a shiny black leather thong underneath connects the two halfs of the top, padded for comfort but pulled away from you by the sheer size of your straining bosoms.");
			outputText("\n\nAs you examine the material, you realize that leather band isn't just padding.  It's as slippery as butter on grease and has a subtle indentation, one that would let it perfectly cushion something round, thick... and throbbing.  Your cheeks color when you catch yourself thinking of titfucking some beast while dressed in this outfit, taking a thick load of monster or dick-girl seed right over your cleavage, face, and hair.  You could even line it up with your mouth and drink down a few swallows if you wanted to.");
			outputText("\n\nYou shake your head and smile ruefully - maybe once you finish getting dressed!  There's still a bottom to put on, after all.  Regardless, one of your hands keeps coming to rest on your boob, idly groping and fondling your heavy tit whenever you have a free moment.  This sure is some fun armor!");
			game.player.dynStats("lus", 25, "scale", false);
			outputText("\n\nNow, the bottom is a leather thong and skirt combination.  The thong itself is leather dyed radiant white, with intricate gold filigree covering the front triangle.  On the back triangle, there's a similar pattern, though you could swear that from a distance the pattern looks a bit like arrows pointing towards where your [asshole] will be with golden sperm surrounding them. No, that has to be your imagination.  All this time in this strange land must really be getting to you!  Both pieces are molded to accentuate the female form, with a crease in the gusset that will rest over your vagina, ensuring ");
			if ((game.player.hasCock() && !game.player.hasSheath()) || game.player.balls > 0) {
				outputText("that it won't fit you ");
				if (game.player.hasCock()) outputText("or your " + game.player.multiCockDescriptLight());
				else outputText("or your [balls]");
				outputText(" at all!  <b>You put your old gear back on with a sigh</b>.");
				return false;
			}
			else if (!game.player.hasVagina()) {
				outputText("that it will dig uncomfortably into your featureless groin.  <b>You put your old gear back on with a sigh</b>.");
				return false;
			}
			outputText("your [vagina] is prominently displaying your camel-toe for all to see.");
			outputText("\n\nYou don't give it a second thought, sliding the white thong snugly into place.  Snug warmth slides right up against your mound, the perfectly formed crease slipping right into your labia, where it belongs, ");
			if (game.player.vaginas[0].virgin) {
				outputText("a tight seal over your chastity, displaying your womanly status while guarding your maidenhead at the same time.  A smug, smile tugs at the corners of your mouth - who would take your virginity when they can tit-fuck your tits or fuck your butt?");
				if (game.player.cor < 33) outputText("  Wait, that isn't right...");
			}
			else {
				outputText("a tight seal over your previously-claimed cunt.  Regret fills you when you realize you could have kept your chastity intact simply by servicing the lusty studs and monsters with your ass and tits.");
			}
			if (game.player.wetness() >= 3) outputText("  The moisture you normally drip seems to soak right into the gusset instead of running down your [legs] like normal, giving you a much more chaste appearance in spite of the lewd garments that even now seem to shape your femininity and [butt] into perfectly arousing shapes.");
			outputText("\n\nLast is the chain skirt - perhaps the easiest part to put on.  It's barely three inches long, such that it exposes your [butt] almost entirely, and when you bend over, fully.  The bottom of your vaginal crease can be spied as well, and should you desire to show yourself off, a simple stretch or tug would put you completely on display.  You wiggle about, watching the reflective material ripple almost hypnotically, one hand still on your boobs, mauling at your own tits with passion.  THIS is how a chaste champion should dress - perfectly modest but full of erotic energy to overwhelm her enemies with!\n\n");
			return true;
		}
	}
}