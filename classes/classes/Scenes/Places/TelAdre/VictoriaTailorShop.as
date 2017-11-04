package classes.Scenes.Places.TelAdre {
import classes.ItemType;
import classes.StatusEffects;

public class VictoriaTailorShop extends Shop {
    public function VictoriaTailorShop() {
        super();
        sprite = 61;
    }

    //-----------------
    //-- TAILOR SHOPPE
    //-----------------
    override protected function inside():void {
        clearOutput();
        outputText("The inside of the tailor's shop is far cleaner than anything else you've seen in the city.  The walls are painted muted gray, and the floor is carpeted with a sprawling, royal blue rug.  After glancing around, you realize WHY the walls and floor are so muted – the quiet backdrop makes the merchandise look even more amazing.  There are racks and racks of clothing, but much of it is plain comfortable clothing, and not worth spending much time investigating.  A high-pitched voice pipes up, \"<i>Can I help you?</i>\"\n\n");
        if (!player.hasStatusEffect(StatusEffects.Victoria)) {
            outputText("You turn around, ");
            if (player.tallness > 60) {
                outputText("looking for the source, eventually looking down and at a short but busty Corgi dog-girl.  ");
            } else {
                outputText("coming face to face with a busty Corgi dog-girl.  ");
            }
            outputText("She's clearly the tailor judging by her stylish, low-cut clothing and poofy hat.  A monocle perches on her nose, giving her a rather distinguished appearance.  The fashionable wench arches her back, showing off what she's got as she introduces herself, \"<i>Ello love, welcome to my shop.  My name's Victoria, though if you like, you can call me Vicky.  You'll find my clothing to be a cut above the rubbish sold elsewhere.</i>\"");
            //Flag as meeting her
            player.createStatusEffect(StatusEffects.Victoria, 0, 0, 0, 0);
        }
        else {
            outputText("You turn around to look ");
            if (player.tallness > 60) {
                outputText("down ");
            }
            outputText("at Victoria the Corgi Tailor.  As usual, she's dressed in a stylish low-cut dress and sporting her feathery hat.");
        }
        outputText("\n\n(What do you want to buy?)");
        menu();
        addButton(0, armors.CLSSYCL.shortName, confirmBuy, armors.CLSSYCL);
        addButton(1, armors.RBBRCLT.shortName, confirmBuy, armors.RBBRCLT);
        addButton(2, armors.ADVCLTH.shortName, confirmBuy, armors.ADVCLTH);
        addButton(3, armors.TUBETOP.shortName, confirmBuy, armors.TUBETOP);

        addButton(5, armors.OVERALL.shortName, confirmBuy, armors.OVERALL);
        addButton(6, armors.B_DRESS.shortName, confirmBuy, armors.B_DRESS);
        addButton(7, armors.T_BSUIT.shortName, confirmBuy, armors.T_BSUIT);
        addButton(8, armors.M_ROBES.shortName, confirmBuy, armors.M_ROBES);

        addButton(10, armors.LTHRPNT.shortName, confirmBuy, armors.LTHRPNT);
        addButton(11, armors.BIMBOSK.shortName, confirmBuy, armors.BIMBOSK);
        addButton(12, armors.A_ROBE_.shortName, confirmBuy, armors.A_ROBE_);

        addButton(4, "Next", undergarmentSection);
        addButton(14, "Leave", telAdre.telAdreMenu);
    }

    protected override function confirmBuy(itype:ItemType = null, priceOverride:int = -1, keyItem:String = ""):void {
        clearOutput();
        spriteSelect(61);
        outputText("Victoria nods and pulls a measuring tape off her shoulder.  She moves around you with practiced ease, taking measurements from every conceivable angle.  Thanks to her small stature, it's quite easy for her to take your inseam measurement, though Vicky manages to ");
        if (player.biggestCockArea() > 30 || player.cockTotal() > 1) {
            outputText("fondle your bulging package");
        } else if (player.hasVagina()) {
            outputText("rub against your outer lips");
        } else {
            outputText("slip a finger along your crotch");
        }
        outputText(" more than a few times.  You could swear you catch her licking her lips when she stands up, but she quickly turns away, saying, \"<i>I've got one in the back that should fit perfectly!  Be right with you!</i>\"\n\n");
        outputText("She disappears in the back for a few moments, then returns with " + itype.longName + " that looks as if it were tailor-made for you.\n\n");
        outputText("\"<i>" + itype.value + " gems and it can be yours,</i>\" she says.  ");
        super.confirmBuy(itype);
        if (player.hasCock() && player.lust >= 33) {
            addButton(4, "Flirt", flirtWithVictoria, itype);
        }
    }

    private function undergarmentSection():void {
        menu();
        addButton(0, undergarments.C_BRA.shortName, confirmBuy, undergarments.C_BRA);
        addButton(1, undergarments.C_PANTY.shortName, confirmBuy, undergarments.C_PANTY);
        addButton(2, undergarments.C_LOIN.shortName, confirmBuy, undergarments.C_LOIN);
        addButton(3, undergarments.FURLOIN.shortName, confirmBuy, undergarments.FURLOIN);

        addButton(5, undergarments.GARTERS.shortName, confirmBuy, undergarments.GARTERS);
        addButton(6, undergarments.LTX_BRA.shortName, confirmBuy, undergarments.LTX_BRA);
        addButton(7, undergarments.LTXSHRT.shortName, confirmBuy, undergarments.LTXSHRT);
        addButton(8, undergarments.LTXTHNG.shortName, confirmBuy, undergarments.LTXTHNG);

        addButton(9, "Previous", inside);
        addButton(14, "Leave", telAdre.telAdreMenu);
    }

    //*Typical buy text goes here. Options are now Yes/No/Flirt*

    //[Flirt]
    private function flirtWithVictoria(itype:ItemType):void {
        clearOutput();
        var x:Number = player.cockThatFits(70);
        if (x < 0) {
            x = player.smallestCockIndex();
        }
        outputText("You take the clothes from her and give them a look over.  Setting them on the counter, you tell her that they're quite nice, but if she's interested you might have something that could fit her quite nicely as well in the back.");
        if (x < 0) {
            outputText("\n\nVictoria smirks and answers, \"<i>I measured your inseam, and what you're packing in there won't fit anywhere in a girl like me.  Maybe some other time, " + player.mf("studmuffin", "sweet thing") + ".  Did you actually want to buy something?</i>\"\n\nDo you still want to buy something?");
            doYesNo(curry(debit, itype), inside);
            return;
        }
        outputText("\n\nIt takes her a moment to realize just what it is you're suggesting before her face splits into a wide grin.  <i>\"That right?  Well now, you can't say things like that without backin' 'em up, can you?\"</i>  she says with a low chuckle, pressing her curvy body into you.  <i>\"What do you say I close the shop up quick, and you can show me just 'ow nicely you can fit, mm?\"</i>");
        outputText("\n\nGiving your [butt] a squeeze, she hops off to turn the shop's open sign around and locks the door before closing all of the curtains.  Turning back to you, she pushes her ample cleavage up into ");
        if (player.tallness >= 65) {
            outputText("your stomach.");
        } else if (player.tallness >= 55) {
            outputText("your chest.");
        } else {
            outputText("your face.");
        }
        outputText("  <i>\"Now then,  let's see what you've got!\"</i>  With practiced ease she works the bottom of your [armor] off, revealing [eachCock].  <i>\"Well, well. Looks like I was right about you from the start,\"</i> she says, licking her lips again.  <i>\"Just a taste first, I think...\"</i> Sticking her tongue out once more, she gives your rapidly stiffening dick a long, slow lick from the base up to the tip.  She closes her mouth just around your " + cockDescript(x) + ", giving it a few rapid licks before pulling off with a pop.");
        outputText("\n\n<i>\"Oh yes,  I think you'll do rather nicely.  In fact, I think I'm going to give you a special treat.\"</i>  Smirking up at you, the busty dog-girl unbuttons her top just beneath her ample chest.  Before you can puzzle out what it is she's doing, she takes your [cock] and stuffs it into the hole and up through her cleavage");
        if (player.cocks[x].cockLength >= 5) {
            outputText(" until the tip is poking out the top");
        }
        outputText(".");
        if (player.cocks[x].cockThickness > 3) {
            outputText("  Her face scrunches up uncomfortably for a moment, your girth straining the seams of her shirt.  With a series of loud pops, her buttons all go flying in different directions, letting her ample, creamy flesh bounce free with a bountiful jiggle.  <i>\"Bloody hell, that was my favorite top...\"</i> she whines for a moment before squeezing her chest back together with her hands.");
        } else {
            outputText("  She presses her arms inward to increase the pressure on your cock even further, and gives you another wide smile.  <i>\"Ready for this, love?\"</i>");
        }

        outputText("\n\nShe begins to slowly move her disproportionately massive chest up and down your cock, ");
        if (player.cocks[x].cockLength > 5) {
            outputText("making sure to give the " + player.cockHead(x) + " a quick suck every time it breaches her mounds.");
        } else {
            outputText("pressing her mouth down into her ample cleavage so as to give your hidden tip a quick lick every time it draws near.");
        }

        outputText("\n\n<i>\"Hvvng fnn?\"</i>  she asks, pausing her pillowy assault to lick over the end of your pecker once again.  You can only moan in response from the wonderful wet, squishy feeling washing over your sensitive organ.  <i>\"That's what I thought,\"</i> she says, releasing you with a wet pop.");
        outputText("\n\nVicky continues her marshmallowy assault for what feels like hours, slowing down every time you give even the slightest indication that you're about to cum.  <i>\"You might hate me for this now, love, but trust me.  It'll feel so much better once you finally do cum.\"</i>  She may be right, but it's agony to get so close to orgasm only to back away, and then draw close once more.  She's practically driving you crazy with lust with her tantalizingly slow tit-fuck.  As you feel your cum nearly boiling away in your [balls], only to have her back away once again, something inside of you snaps.");
        outputText("\n\nYou wrench your dick free of the confines of her pillowy mounds, and grab her around her plush middle.  She gives a surprised yelp as you nearly throw her against the counter and lift her butt up into the air.  <i>\"Ooooh, someone's excited!\"</i>  she nearly cheers, looking over her shoulder and wagging her plush rear up at you as her tail swishes back and forth, showing that she's nearly as consumed with lust as you are.  Flipping her long skirt up over her back, you violently pull her panties aside before you force your " + cockDescript(x) + " deep within her gushing folds.");
        outputText("\n\nShe squeals in surprise and pleasure as she's penetrated, thrusting her ample hips back at you as you begin to pound into her.  Her ass jiggles violently with every thrust, sending ripples through her creamy flesh.  You grip her around her soft middle as you slam against her hips, barely noticing every squeak she makes as her thick thighs are pounded into the side of the counter.  <i>\"Ah!  Oh, Marae, that feels incredible!\"</i>  she nearly screams as her monocle finally loses its grip on her face and goes flying, thankfully landing safely on a pile of scrap cloth.  If you were more sound of mind, you'd probably have dreaded the cost of repairing the broken eyepiece.");
        outputText("\n\nSomehow, miraculously, you're able to hold back long enough to work your hands up her soft body and grip onto her enormous tits, mashing them in your hands as you find her rock-hard nipples.  She seems to be enjoying the rough treatment - quite a bit in fact - as the moment you give her hard nubs a quick tweak you feel her already rather tight pussy clamp down on your cock HARD.  It becomes nearly impossible to move as she cums explosively, screaming incoherently as she sprays your lower body with her liquid pleasure.");
        outputText("\n\nThe sudden resistance is all it takes to finally bring you over the edge, as with a loud roar of your own, you bury yourself deep inside of her still tightly clutching cunt and release.  [if (cumNormal = true) It would seem that what she said earlier was correct.  Your pent-up need surges up through your dick, firing your fertile seed straight into her unprotected womb.  She lets out a submissive whimper as your spurting dick triggers aftershocks within her exhausted body.  At last, her body relaxes, freeing your softening dick.][if (cumMedium = true) Thick, sticky, ropes of your cream fire deep within her grasping pussy, attempting to extinguish the fire you lit within her with your frantic rutting.  She whimpers beneath you as your ejaculation sends another wave of pleasure through her body, which clamps down even harder onto you than before.  Thankfully, it's not long before she releases you once again, going limp on the counter and breathing raggedly.][if (cumHigh = true) Your urethra distends as it funnels your thick, potent seed into the tightly gripping walls of Victoria's pussy.  She clenches down as the white torrent sends her into yet another orgasm, shuddering beneath you as her already thick stomach begins to distend with its load.  Her pussy continues to milk your dick of its load even as she rides the high of her last orgasm, her body desperate to draw out more of your thick cream.  Finally she releases you, your softening dick forced back out with a thick stream of your jizz, which begins to pool out onto the floor.][if (cumVeryHigh = true) You feel your dick swell as it nearly explodes within her, pouring thick streams of your seed deep into her fertile womb.  She lets out another loud squeal as her body clenches down into yet another orgasm, gripping your dick tighter than you ever thought possible as it tries to milk you for all you have.  Her plush stomach visibly distends with its contents as you dump your load within her, lifting her small body up from the surface of the counter somewhat.  Thankfully, her body soon relaxes, releasing your softening prick, which is followed by a thick, white fountain of jizz that soaks your legs and pools out onto the floor.]");
        if (silly()) {
            outputText("[if (cumExtreme = true) You groan loudly as your cock pours gallon after gallon of jizz deep into her spasming pussy.  She screams as another powerful orgasm wracks her body, triggered by the enormous amount of jizz you're shooting into her.  Her belly audibly sloshes with each of her movements as it continues to expand from the enormous amount of fluid you're pumping into her.  She attempts to clutch down on you as tightly as she can, trying to retain your enormous load; but the moment she releases even a little bit, she shoots forward from the enormous pressure of jizz within her, flopping down face-first onto some clothes on the other side of the counter.  Your thick cream continues to shoot up from between her limp legs, almost like a fountain, before gravity pulls it back down and it splatters all over the interior of the store.]");
        } else {
            outputText("[if (cumExtreme = true) You groan loudly as your cock pours gallon after gallon of jizz deep into her spasming pussy.  She screams as another powerful orgasm wracks her body, triggered by the enormous amount of jizz you're shooting into her.  Her belly audibly sloshes with each of her movements as it continues to expand from the enormous amount of fluid you're pumping into her.  Thick streams of your seed shoot out all around your dick as she continues to squeeze down on you, trying to keep as much of it inside her massively pregnant-looking belly as possible before she finally releases, squirting your dick back out of her with a pop, followed by a veritable geyser of white. Your entire lower body is painted white as it gushes out, soaking into your clothes and covering the floor as she visibly deflates.]");
        }
        outputText("\n\nFinally, your strength gives out and you fall backwards onto the floor, exhausted.  A few seconds later, Vicky slips backward off of the counter and lands on top of you.  Like you, she's completely unable to move, however unlike you it's more because she is completely insensate.  Her eyes have rolled back into her head and her tongue hangs out as she occasionally mutters something incoherent.");
        outputText("\n\nA few seconds later your body finally gives out completely and you pass out.  You wake up about an hour later, still on the floor with Vicky on the ground near you, leaning up against the counter with her legs splayed, cum still dripping from her used pussy.  <i>\"I uh... s'pose you wanna leave now?\"</i>  She asks, still sounding a bit loopy.  She climbs unsteadily to her feet, and walks, a bit bowlegged to the door, unlocking it before slumping back down the wall.  <i>\"Do come back for a visit, love!\"</i>  You pull your pants back up and crawl back out into the street.  Climbing back to your feet, you notice a few passersby chuckling at you before you close the door.  Before you leave, you think you can make out Victoria muttering, <i>\"Gonna have to clean this place up...\"</i>");

        player.orgasm();
        dynStats("sen", -1);
        doNext(camp.returnToCampUseOneHour);
    }
}
}
