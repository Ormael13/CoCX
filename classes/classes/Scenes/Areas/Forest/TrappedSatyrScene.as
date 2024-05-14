package classes.Scenes.Areas.Forest {
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.display.SpriteDb;

public class TrappedSatyrScene extends BaseContent {
    //Catch a Satyr using the corrupt glade and either leave or have your way with him.
    //Suggested to Fen as the MaleXMale submission.
    //Will be standalone
    public function findTrapped():void {
        clearOutput();
        spriteSelect(SpriteDb.s_stuckSatyr);
        outputText("As you wander through the woods, you find yourself straying into yet another corrupt glade.  However, this time the perverse grove isn't unoccupied; loud bleatings and brayings of pleasure split the air, and as you push past a bush covered in dripping, glans-shaped berries, you spot the source.\n\n");
        outputText("A humanoid figure with a set of goat-like horns and legs - a satyr - is currently buried balls-deep in one of the vagina-flowers that scatter the grove, whooping in delight as he hungrily pounds into its ravenously sucking depths.  He stops on occasion to turn and take a slobbering suckle from a nearby breast-like growth; evidently, he doesn't care that he's stuck there until the flower's done with him.");
        camp.codex.unlockEntry(kFLAGS.CODEX_ENTRY_SATYRS);
        //(Player lacks a penis:
        if (!player.hasCock()) {
            outputText("You can't really see any way to take advantage of this scenario, so you simply turn back and leave the way you came.");
            endEncounter();
        }
            //Player returns to camp)
        //(Player has penis:
        else {
            outputText("You can see his goat tail flitting happily above his tight, squeezable asscheeks, the loincloth discarded beside him failing to obscure his black cherry, ripe for the picking.  Do you take advantage of his distraction and ravage his ass while he's helpless?");
            //[Yes] [No]
            simpleChoices("Ravage", rapeSatyr, "", null, "", null, "", null, "Leave", ignoreSatyr);
        }
    }

    //[=No=]
    private function ignoreSatyr():void {
        clearOutput();
        spriteSelect(SpriteDb.s_stuckSatyr);
        outputText("You shake your head, " +
            ((player.cor < 50)
                ? "disgusted by the strange thoughts this place seems to put into your mind"
                : "not feeling inclined to rape some satyr butt right now") +
            ", and silently leave him to his pleasures.");
        dynStats("lus", 5 + player.lib / 20, "scale", false);
        endEncounter();
    }

    //Player returns to camp
    private function rapeSatyr():void {
        clearOutput();
        spriteSelect(SpriteDb.s_stuckSatyr);
        var x:Number = player.biggestCockIndex();
        if (player.cor < 33) {
            outputText("For a moment you hesitate... taking someone from behind without their consent seems wrong... but then again you doubt a satyr would pass on the opportunity if you were in his position.")
        } else if (player.cor < 66) {
            outputText("You smirk; normally you would have given this some thought, but the idea of free booty is all you need to make a decision.")
        } else {
            outputText("You grin; this is not even a choice!  Passing on free anal is just not something a decent person does, is it?");
        }
        outputText("  You silently strip your [armor] and " +
            (player.isNaga() ? "slither" : "sneak") +
            " towards the distracted satyr; stopping a few feet away, you stroke your [cock biggest], urging it to full erection and coaxing a few beads of pre, which you smear along your [cockhead biggest].  With no warning, you lunge forward, grabbing and pulling his hips towards your [cock biggest] and shoving as much of yourself inside his tight ass as you can.\n\n");
        outputText("The satyr lets out a startled yelp, struggling against you, but between his awkward position and the mutant flower ravenously sucking on his sizable cock, he's helpless.\n\n");
        outputText("You slap his butt with a open palm, leaving a clear mark on his taut behind.  He bleats, bucking wildly, but this serves only to slam his butt into your crotch until the flower hungrily sucks him back, sliding him off your prick.  You smile as a wicked idea hits you; you hit his ass again and again, making him buck into your throbbing " + Appearance.cockNoun(player.cocks[x].cockType) + ", while the flower keeps pulling him back inside; effectively making the satyr fuck himself.\n\n");
        outputText("Eventually, his bleating and screaming start to annoy you, so you silence him by grabbing at his horns and shoving his head to the side, into one of the breast-like growths nearby.  The satyr unthinkingly latches onto the floral nipple and starts to suckle, quieting him as you hoped.  You're not sure why, but he starts to voluntarily buck back and forth between you and the flower; maybe he's getting into the spirit of things, or maybe the vegetal teat he's pulling on has introduced an aphrodisiac chemical after so many violent attempts to pull out of the kindred flower.\n\n");
        outputText("You resolve not to think about it right now and just enjoy pounding the satyr's ass.  With his bucking you're able to thrust even farther into his tight puckered cherry, ");
        if (player.cockArea(x) >= 100) outputText("stretching it all out of normal proportion and ruining it for whomever might happen to use it next.");
        else outputText("stretching it to fit your [cock biggest] like a condom.");
        outputText("Your groin throbs, " +
            (player.hasBalls() ? "your balls churn, " : "") +
            "and you grunt as you feel the first shots of cum flowing along [eachcock], only to pour out into " +
            (player.cockTotal() > 1 ? " and onto" : "") +
            " the satyr's abused ass; you continue pounding him even as you climax, causing rivulets of cum to run down his cheeks and legs.\n\n");
        outputText("Still slurping obscenely on the fake breast, the satyr groans and murmurs; you're not sure how much of a role the sap he's swallowing or the cunt-flower on his cock is playing, but it looks like he's actually enjoying himself now.")
        if (player.cumQ() < 250) {
            outputText("As much as you'd love to fill his belly so full of spunk he'd look pregnant, you just can't muster any more, and pull out with a sigh.");
        } else if (player.cumQ() < 1000) {
            outputText("You cum and cum, filling every crevice of his anal passage with warm jism, the slutty goatman doesn't seem to mind this in the least.  When you're finally spent, you pull out with a sigh, and watch as your cum backflows out of his ass to fall on the grass below.");
        } else {
            outputText("You cum and cum, filling every crevice of his anal passage with warm jism, and the slutty goatman doesn't seem to mind this in the least - yet.  You push him to his limits; cum backflows out of his ass and around your spewing prick, but still you dump more and more of your heavy load inside your now-willing cock-sleeve, inflating his belly like a balloon.  When you're finally spent, you pull out with a sigh and look at your handiwork; cum pours out of his ass like an open tap and his belly is absolutely bulging, making him look pregnant.");
        }
        outputText("\n\n");
        outputText("The satyr is too absorbed in his own fucking of the plant-pussy, and his nursing of the tree boob to bewail your absence");
        if (player.cumQ() >= 1000) outputText(", although his eyes have widened perceptibly along with the stretching of his stomach");
        outputText(".\n\n");
        outputText("You can't help but smile inwardly at the helpless goatman's eagerness, and decide to stick around and watch him a little longer.  It's not everyday you see a creature like him at your mercy.  Every once in awhile you egg him on with a fresh slapping of his butt. The satyr grumbles and huffs, but continues to thrust and rut mindlessly into the vegetative pussy feeding on his cock. You don't think it'll be long before he cums...\n\n");
        outputText("As you watch the lewd display, you feel your arousal building and your [cock biggest] growing back into full mast. Figuring you already have a willing slut readily available, you consider using him to relieve yourself once more... What do you do?");
        player.sexReward("no", "Dick");
        //[Again][Leave]
        simpleChoices("Again", secondSatyrFuck, "", null, "", null, "", null, "Leave", dontRepeatFuckSatyr);
    }

    //[=Leave=]
    private function dontRepeatFuckSatyr():void {
        clearOutput();
        spriteSelect(SpriteDb.s_stuckSatyr);
        outputText("You've had your fun, and you don't really want to fool around in the forest all day, so you grab your [armor] and leave the rutting satyr behind.");
        endEncounter();
    }

    //[=Again=]
    private function secondSatyrFuck():void {
        var x:int = player.cockThatFits(monster.analCapacity());
        if (x < 0) x = player.smallestCockIndex();
        clearOutput();
        outputText("There's no harm in using the helpless goat once more... This time though, you decide you'll use his mouth.  With a yank on his horns, you forcefully dislodge him from the breast-plant and force him to his knees, turning his head towards you; he doesn't put up much resistance and when you present your erect shaft to him, he licks his lips in excitement and latches onto your [cock " + (x + 1) + "].\n\n");
        outputText("His mouth is exquisite; it feels slippery and warm and his lips are soft while his tongue wriggles about your shaft, trying to embrace and massage it.  He gloms onto your manhood with eager hunger, desperate to ravish you with his mouth.  Quivers of pleasure ripple and shudder through his body as he slobbers and gulps - and no wonder!  From the remnants of sap still in his mouth, you can feel currents of arousal tingling down your cock; if he's been drinking it straight, his mouth must be as sensitive as a cunt from the effects of this stuff.\n\n");
        outputText("Having had your first orgasm mere minutes ago, you don't last long.  Within a few moments of his beginning you flood his mouth with a second load of cum, pulling out to paint his face with the last couple jets.\n\n");
        outputText("With a great, garbled cry, the satyr cums on his own, gurgling through the sap-tinted cum drooling from his mouth as he spews into the waiting opening of his rapacious plant lover.  It swells and bloats as it gorges itself on his thick, stinking seed, stretching its stem until it is almost spherical, finally releasing him to collapse on his knees, free at last of the plant's grip.  He moans and bleats softly, leaking cummy sap from his chin onto his hairy chest, too overwhelmed by the combined fucking of yourself and the flower and too poisoned by whatever aphrodisiac he's been slurping on to move.\n\n");
        outputText("You give your sensitive member a few trembling, almost-painful strokes... maybe you overdid it a bit.  Shrugging, you gather your [armor] and leave the passed-out satyr behind as you go back to your camp.");
        player.sexReward("no", "Dick");
        dynStats("lib", 1, "sen", -5);
        endEncounter();
    }
}
}
