/**
 * Created by aimozg on 02.01.14.
 */
package classes.Scenes.Places.Boat {
import classes.*;
import classes.BodyParts.Antennae;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Armors.LustyMaidensArmor;
import classes.Scenes.Areas.Ocean.SeaAnemone;
import classes.Scenes.SceneLib;
import classes.display.SpriteDb;

public class AnemoneScene extends BaseContent {
    public static function anemonePreg():void {
        if (player.hasUniquePregnancy()) player.impregnationRacialCheck();
        else player.knockUp(PregnancyStore.PREGNANCY_ANEMONE, PregnancyStore.INCUBATION_ANEMONE, 101);
    }

    public function mortalAnemoneeeeee():void {
        spriteSelect(SpriteDb.s_anemone);
        clearOutput();
        if (flags[kFLAGS.TIMES_MET_ANEMONE] == 0 || player.hasItem(consumables.MINOCUM)) {
            flags[kFLAGS.TIMES_MET_ANEMONE]++;
            outputText("You step into the boat and begin to slip off the mooring rope when you are distracted by a swirl of bright colors under the surface of the ");
            if (flags[kFLAGS.ANEMONE_OR_SEA_ANEMONE] == 1) outputText("lake");
            if (flags[kFLAGS.ANEMONE_OR_SEA_ANEMONE] == 2) outputText("ocean");
            outputText(".  As you peer over the side to get a better look at the oscillating mass of greens and purples, the swirl begins drawing closer to the boat as if reciprocating your interest; it grows larger and brighter as it closes the distance.  The cloud parts to reveal an attractive feminine face cast in a deep blue shade.  It lightens responsively as its gaze takes you in from the depths of two opaque eyes.  The confusing mass of colors resolves itself into tresses of two-inch-thick anemone tentacles sprouting from the head in place of hair!\n\n");
            outputText("The anemone girl smiles at you flirtatiously as she bobs up to the surface.  More out of politeness than anything you smile back, not sure of what to make of her and unused to such unaggressive approaches by the denizens of this place.  A bloom of vibrant color offset by the blue outline of her body causes you to lean farther out as your attention refocuses below her waist, where you perceive a smaller ring of tentacles waving at you from behind the head of a hardening penis!  Turned on by the attention, the anemone grabs onto the saxboard in an attempt to pull herself up to you, but her added weight on the side overbalances you and pitches you overboard into her waiting tentacles!\n\n");
            if (player.hasItem(consumables.MINOCUM)) {
                minoCumForAnemonieeeeez();
                return;
            } else sceneHunter.print("Check failed: Minotaur Cum in the inventory.");
            outputText("The initial surprise subsides to wooly-headedness and a feeling of mild arousal as the stingers in her tentacles find exposed flesh.  In panic of drowning you pull free of the ropy mass and backpaddle away from the girl until your [feet] reassuringly touch the shallows of the ");
            if (flags[kFLAGS.ANEMONE_OR_SEA_ANEMONE] == 1) outputText("lake");
            if (flags[kFLAGS.ANEMONE_OR_SEA_ANEMONE] == 2) outputText("ocean");
            outputText("bed once again and you're far enough above water to be able to fight.\n\n");
        } else {
            flags[kFLAGS.TIMES_MET_ANEMONE]++;
            //new anemone repeat combat encounter, once player has met one:
            outputText("As you unmoor the boat and cast off, you hear a soft bubbling sound coming from amidships.  You look around only to see several green tentacles slip over the saxboard and pull down suddenly, pitching the boat and sending you overside into the welcoming embrace of a grinning anemone!  She swims alongside and gives you several playful caresses as you struggle back toward shore, already woozy and aroused from the venomous contact.\n\n");
            //(typical lust gain and temporary stat damage, start combat)
        }
        outputText("You are fighting an anemone!");
        camp.codex.unlockEntry(kFLAGS.CODEX_ENTRY_ANEMONES);
        if (flags[kFLAGS.ANEMONE_OR_SEA_ANEMONE] == 1) {
            var anemone:Anemone = new Anemone();
            startCombat(anemone);
            //(gain lust, temp lose spd/str)
            dynStats("lus", 4, "scale", false);
            anemone.applyVenom(1);
        }
        if (flags[kFLAGS.ANEMONE_OR_SEA_ANEMONE] == 2) {
            var seaanemone:SeaAnemone = new SeaAnemone();
            startCombat(seaanemone);
            //(gain lust, temp lose spd/str)
            dynStats("lus", 8, "scale", false);
            seaanemone.applyVenom(1);
        }
    }

    //victory:
    public function defeatAnemone():void {
        clearOutput();
        //Win by HP:
        if (monster.HP < 1) outputText("The anemone's knees buckle and she collapses, planting her hands behind her with a splash.  You stand over her, victorious.\n\n");
        //win by lust:
        else outputText("The anemone slumps down and begins masturbating, stroking her cock furiously.  You think you can detect something like desperation in her opaque eyes.  It doesn't look like she'll trouble you anymore.\n\n");
        if (player.lust >= 33) {
            outputText("You could always have your way with her.  If you do, which parts do you use to do the deed?");
            sexMenu();
        } else {
            outputText("You're not aroused enough to fuck her.");
            cleanupAfterCombat();
        }
    }

    public function sexMenu(defeat:Boolean = true):void {
        menu();
        addButtonIfTrue(0, "Your Cock", rapeAnemoneWithDick, "Req. a cock.", player.hasCock());
        addButtonIfTrue(1, "Your Vagina", rapeAnemoneWithPussy, "Req. a vagina.", player.hasVagina());
        addButton(2, "Your Ass", victoryButtholeRape);
        addButton(14, "Leave", cleanupAfterCombat);
        if (defeat) {
            addButtonIfTrue(3, "Her Butt", herButtRouter, "Req. a cock fitting 48 area OR a vagina with a long clit.",
                player.cockThatFits(48) >= 0 || player.hasVagina() && player.clitLength >= 4);
            LustyMaidensArmor.addTitfuckButton(4);
            addButtonIfTrue(5, "LayEggs(Bee)", anemoneGetsLayedByBeePositor, "Req. a bee ovipositor.", player.canOvipositBee());
            addButtonIfTrue(6, "LayEggs(Dri)", spiderOvipositAnAnemone, "Req. a drider ovipositor.", player.canOvipositSpider());
            SceneLib.uniqueSexScene.pcUSSPreChecksV2(sexMenu);
        } else {
            addButtonDisabled(3, "Her Butt", "Only available after defeating her!");
            addButtonDisabled(4, "Lay Eggs", "Only available after defeating her!");
        }
    }

    public function herButtRouter():void {
        menu();
        addButtonIfTrue(0, "Use Dick", curry(anemoneButtPlugginz, true), "Req. a cock fitting 48 area.",
            player.cockThatFits(48) >= 0);
        addButtonIfTrue(1, "Use Clit", curry(anemoneButtPlugginz, false), "Req. a vagina with a long clit.",
            player.hasVagina() && player.clitLength >= 4);
        addButton(4, "Back", sexMenu, true);
    }

    //anal: -requires butthole
    private function victoryButtholeRape():void {
        spriteSelect(SpriteDb.s_anemone);
        clearOutput();
        outputText(images.showImage("anemone-getanal"));
        outputText("You look over the anemone in front of you.  Your attention focuses on her blue shaft; those smaller tentacles should have plenty of pleasing venom in them as well.  Stripping off your [armor], you approach her and push her backwards.  Her gills slide off her breasts and float at her sides. revealing a pair of cute nipples.  You take the opportunity to stroke the shaft of her penis and rub her vagina a bit, soaking up some venom and making your hands tingle.\n\n");

        outputText("Quite soon you can hardly stand your own arousal and your lover's cock is nice and hard.  Straddling the anemone, you position your " + assholeDescript() + " over her colorful shaft and gradually lower yourself towards it.  The florid crown slips into your hole, delivering the expected shock, and a gasp from behind you is accompanied by the anemone's hands moving to your hips.");
        //[butt hymen removal]
        if (!player.buttChange(monster.cockArea(0), true)) outputText("  ");
        outputText("Despite your anticipatory stiffening you find yourself trembling and your muscles weakening, but by a superb effort you manage to concentrate and lower yourself gently, savoring the slow crawl of the warmth up your " + assholeDescript() + ".  You reach the base of the anemone's short shaft soon, and pause for a minute; looking over your shoulder at the anemone, you notice her biting her lower lip impatiently.  Making a mental note of her cute expression to fuel your imagination, you turn forward and, putting your hands down for support, you begin to rise and fall on her erect penis.\n\n");

        outputText("With your " + assholeDescript() + " heated up from the aphrodisiac already, the friction is enough to warm it to fever pitch.  Over and over you impale yourself on the girl's rod, dragging trails of venom and heat up and down your rectum.");
        if (player.cockTotal() > 0) {
            outputText("  One hand involuntarily moves to your [cock] and begins stroking, smearing the copious pre-cum forced out by the prostate stimulation over " + sMultiCockDesc() + ".");
        }
        //[(if vag and nococks)
        if (player.hasVagina()) {
            outputText("  You lift " + (player.hasCock() ? "another" : "one") + " hand up to your " + vaginaDescript(0) + " and begin jilling yourself off.  This works to satisfy you for a while, but eventually you want more and grab a brace of tentacles floating in the water beside you, shoving them into your greedy pussy and smearing them around. This provokes a lusty moan from you and a giggle from your lover.");
        }
        outputText("  As you work your " + assholeDescript() + " on the tool, something happens to push your peak closer at a startling pace...\n\n");

        outputText("Your blue lover, restless now and uncontent to simply lie there anymore, begins to use her own hands and hips to pump in time with you, doubling the pace of the fuck.  The fervid intensity of her strokes doesn't leave any time for the venom to disperse before the next thrust arrives, making it feel as though your " + assholeDescript() + " is filled with one huge, hot cock that nevertheless slides in and out even as it remains motionless.  The sensation pushes you to orgasm quickly, your " + assholeDescript() + " clamping down on the anemone's penis");
        if (player.cockTotal() > 0) {
            outputText(" as " + sMultiCockDesc() + " twitches and ejaculates in a ");
            if (player.cumQ() < 50) outputText("squirt");
            else if (player.cumQ() < 250) outputText("spray");
            else outputText("torrent");
            outputText(" of semen");
        }
        if (player.hasVagina()) outputText(" and your " + vaginaDescript(0) + " spasms around the tentacles and your fingers");
        outputText(".  The anemone must have been right on the edge with you, because after a few more thrusts in your hungry asshole she achieves her own climax and shoots several strings of cool, thick semen into you.  You collapse backward against your partner and she idly caresses your " + nippleDescript(0) + ".  After several minutes of relaxing in the warm water, you sit up and push yourself off of the anemone's limp penis, which drags a string of semen out of your " + assholeDescript() + " and prompts ");
        //[(dix)
        if (player.cockTotal() > 0 || player.gender == 0) outputText("a ");
        else if (player.hasVagina()) outputText("another ");
        outputText(" giggle from the blue girl.  Standing up, you gather your gear and blow her a kiss before you leave.  She darkens in color, her camouflage reflex causing her to 'blush' in discomfort at this display of affection.");
        //(pass 1 hour, reduce lust to min)
        player.sexReward("cum", "Anal");
        cleanupAfterCombat();
    }


    private function rapeAnemoneWithDick():void {
        spriteSelect(SpriteDb.s_anemone);
        clearOutput();
        outputText(images.showImage("anemone-male-fuck"));
        sceneHunter.selectFitNofit(fitsF, nofitF, 36);

        //==================================================
        function fitsF():void {
            var x:Number = player.cockThatFits(36);
            outputText("Rubbing yourself through your [armor], you look over the anemone; your attention wanders down her torso to the blue slit between her legs");
            //[(lust victory)
            if (monster.lust >= monster.maxOverLust()) outputText(", which she's currently diddling with the hand she's not using to stroke her cock");
            outputText(".  Unfastening your garments, you stroke " + sMultiCockDesc() + " to full hardness and approach her.  The anemone looks up at you, still somewhat befogged; then, as you stand over her, she leans forward and opens her mouth invitingly.\n\n");

            outputText("You smile at how eager she is for you, but shake your head.  The anemone closes her mouth and looks at you quizzically.  <i>\"No?\"</i> she asks.  Only then does she follow your gaze down to her pussy.  The skin on her face darkens a bit as she realizes your intention... which turns out to be a blush, by the looks of the shy glance she gives you next!  <i>\"Umm.\"</i>  The anemone's fingers");
            //[(HP defeat)
            if (monster.HP < 1) outputText(" move to the lips of her vagina and");
            outputText(" pull apart her feathery labia, showing a velvety interior.  <i>\"Ok...\"</i> she says haltingly.  You accept the invitation in a hurry, kneeling down and holding onto her hips, then guiding your " + cockDescript(x) + " into her.\n\n");

            outputText("After a moment of savoring the sensation, you push all of the way in, provoking a moan and a widening of the eyes from your partner.  ");
            //[(multicox)
            if (player.cockTotal() > 1) {
                outputText("As you push all the way into her, your other dick");
                if (player.cockTotal() > 2) outputText("s");
                outputText(" rub");
                if (player.cockTotal() == 2) outputText("s");
                outputText(" up against the feelers lining her pussy.  Unexpectedly, they also contain the venomous nematocysts of her tentacles and in that single stroke " + sMultiCockDesc() + " is throbbing hard and squeezing pre-cum all over her groin.  She reaches down and plays with it");
                if (player.cockTotal() > 2) outputText(", and them,");
                outputText(" as you start pumping.  ");
            }
            outputText("The fuck begins in earnest as you demonstrate all the techniques you know or can imagine; the anemone seems to be more impressed as you go on, cooing and moaning to goad you further while wrapping her hands and hair around your hips for chemical encouragement.  Her small tits bounce a little");
            //[(if PC boobs > A)
            if (player.biggestTitSize() >= 1) outputText(" in time with your own");
            outputText("; here and there one of the bounces brush her gills away, giving you a tantalizing view of nipple.");
            //[(if balls)
            if (player.hasBalls()) outputText("  As your thrusts get faster your " + sackDescript() + " starts to slap into the tickly and quite-venomous feelers fringing her pussy, getting hotter and hotter as the aphrodisiac builds in your [balls].  Your body answers with swelling, causing your sack to feel bigger and tighter with every slap.");
            //[(if noballs and clit > 6")
            else if (player.clitLength >= 6) outputText("  As your thrusts into the blue girl arouse you, your " + clitDescript() + " begins to swell with blood.  Pretty soon it's so erect that a particularly violent thrust mashes it into the feelers at the base of her labia, delivering a shock that almost makes you collapse.  The anemone, her reverie interrupted as you temporarily stop pumping, looks down.  Noticing the massive girl-cock sticking out of your " + vaginaDescript(0) + ", she reaches between her legs and gives the tip a flick, grinning with sadistic playfulness.  Your eyes cross at that, sending her into a spasm of giggling.  Irritated but aroused by the abuse of your " + clitDescript() + ", you move your thumb over her own tiny blue button and begin flicking it in revenge as you renew your pumping.");
            outputText("\n\n");

            outputText("The anemone's eyes roll back in her head as she reaches her climax first, hips shaking and penis squirting a glob of semen that drools down the side.  ");
            //[(Flexibility cat perk)
            if (player.hasPerk(PerkLib.Flexibility)) outputText("You lean down and take the anemone's cock in your own mouth as she continues orgasming, swallowing the cool, slippery jism -- it tastes not salty and fishy as you'd hoped but somewhat faintly like algae.  The anemone, recovering her wits a bit, looks at you blankly, as though she can't fathom why anyone would want to drink <i>her</i> ejaculate instead of the other way around.  Your eyes twinkle mirthfully in response as you suck and swallow the last of her jizz.  ");
            player.sexReward("cum", "Vaginal");
            outputText("Your orgasm takes a bit longer, but the convulsing walls of her pussy do their best to help you arrive and the feelers along her labia writhe against your [cocks] in the same tempo, injecting the last of their venom.  With a deep, final thrust, " + sMultiCockDesc() + " erupts in her pussy.  ");
            //[(big skeet)
            if (player.cumQ() > 500) {
                outputText("You continue to pour into her even after her convulsions stop, stretching her belly");
                //[(super skeet)
                if (player.cumQ() > 2000) outputText(" to enormous dimensions.  <i>\"Ohh...\"</i> she moans, as her waist distends to over four times its former slender diameter");
                outputText(".  She looks ");
                if (player.cumQ() < 2000) outputText("thoroughly");
                else outputText("monstrously");
                outputText(" pregnant when you've finished, her little blue dick poking out below a swollen stomach... not a bad look, actually.  You get a little turned on at the idea.  ");
            }
            outputText("After the last of your cum has been squeezed out, you pull your " + cockDescript(x) + " out and rinse it off in the ");
            if (flags[kFLAGS.ANEMONE_OR_SEA_ANEMONE] == 1) outputText("lake");
            if (flags[kFLAGS.ANEMONE_OR_SEA_ANEMONE] == 2) outputText("ocean");
            outputText("water.  You gather your gear while the anemone holds her belly and smiles placidly, staring into the sky.");
            //(pass 1 hour, reset lust to min or min+10 if big or greater skeet)
            player.sexReward("vaginalfluids", "Dick");
            cleanupAfterCombat();
        }

        //Too-big male: -requires cockarea > 36
        function nofitF():void {
            var x:Number = player.biggestCockIndex();
            outputText("Rubbing yourself through your [armor], you look over the anemone; your attention wanders down her torso to the blue slit between her legs");
            //[(lust victory)
            if (player.lust >= player.maxOverLust()) outputText(", which she's currently diddling with the hand she's not using to stroke her cock");
            outputText(".  Unfastening your garments, you stroke " + sMultiCockDesc() + " to full hardness and approach her.  The anemone looks up at you, still somewhat befogged; then, as you stand ");
            if (player.tallness > 48) outputText("over");
            else outputText("before");
            outputText(" her, her eyes widen as she witnesses the sheer amount of cock you have.\n\n");

            outputText("You smile at how stunned she is by you, and waggle your erect [cocks] from side-to-side.  The anemone obediently watches it swing, like a hypnotist's pendulum; her mouth reflexively opens as all her conscious thought is temporarily sidetracked.  You push on the shaft with one hand and move the tip down relative to her body, watching bemused as the girl tries to keep her mouth in line with it until it goes too low for her neck and snaps her out of her daze.  She closes her mouth and looks at you quizzically.  <i>\"No?\"</i> she asks.  You answer by pushing forward slightly, bumping the head of your " + cockDescript(x) + " against her <i>mons pubis</i>.  The skin on her face darkens a bit as she realizes your intention... which turns out to be a blush, by the looks of the shy glance she gives you next!  <i>\"Umm.\"</i>  She gives it a moment of concerned study before her natural instincts take over and the anemone's fingers");
            //[(HP defeat)
            if (monster.HP < 1) outputText(" move to the lips of her vagina and");
            outputText(" pull apart her feathery labia, showing a velvety interior.  <i>\"Ok...\"</i> she says, clearly unsure of the wisdom of this.  You motion for her to lay back and lift her pussy as high as possible to reduce the angle, then attempt to guide your " + cockDescript(x) + " into her.");
            //[(PC height > 7' and non-centaur)
            if (player.tallness > 84) outputText("  Finally, after having gone so far as to kneel down to bring yourself in line, you begin pushing your way in.");
            outputText("\n\n");

            outputText("The first few inches are slow-going, as you try to stretch the blue girl's roughly human-sized pussy around your superhuman girth.  She sports a worried expression as you struggle to push the crown of your " + Appearance.cockNoun(CockTypesEnum.HUMAN) + " in without bending your shaft.  The girl's body proves more elastic than you'd expected, though; with each shove her cunt takes more width without suffering any obvious ill effect.  Eventually you get the head of your " + cockDescript(x) + " into her, and you give an experimental thrust to test her depths. You slide surprisingly far into her, your huge " + Appearance.cockNoun(CockTypesEnum.HUMAN) + " making a bump in her pelvis; the anemone has abandoned her worry and is blissfully tweaking her nipples.  Taking the anemone's legs under your arms, you begin pumping at her, savoring the sensation of having at least part of your unwieldy tool inside someone.  Your blue partner gives out cute moans as you fuck her, prompting a grin from you, but most of your attention is focused on maintaining the angle of your " + cockDescript(x) + ".  As you focus on the thrusts, you gradually notice the bump sliding further up her pelvis on each push... it's nearly up to her stomach now!  You quickly make up your mind to test her unusual biology, choking up on your grip of her legs and pushing hard with each thrust in.  The anemone is now tracking the progress of the bump representing your " + Appearance.cockNoun(CockTypesEnum.HUMAN) + " as intently as you are; as your head pushes up her chest between her breasts she presses them together against the ridge, massaging them against the shaft through her skin.");
            //[(cocklength > 60")
            if (player.cocks[x].cockLength > 60) outputText("  The imagery and the stimulation inspire you to increase your efforts, and you push even harder into her until your " + cockDescript(x) + " slides its way into her throat, expanding her slender neck to twice the normal width.  The anemone's mouth gapes open reflexively as if to gag as the pressure forces her head back, but she doesn't stop moaning or rubbing herself against you.  This seems to be as deep as you can get; the tip of your cock is now right up against the base of her chin.");
            outputText("\n\n");

            outputText("Inordinately pleased at having gotten your " + cockDescript(x) + " so far in, you begin thrusting grandly, alternating huge back-and-forth pumps with hip gyrations that press you against the sides of your partner.  The anemone");
            //[(dick > 60")
            if (player.cocks[x].cockLength > 60) outputText(", despite being unable to look anywhere except over her head thanks to the giant ridge running up the front of her body,");
            outputText(" has clearly been enjoying the treatment; soon she begins twitching in orgasm and her pussy spasms against the base of your " + Appearance.cockNoun(CockTypesEnum.HUMAN) + ", flicking its venomous feelers into it, as she kneads her breasts in her hands.  Her body attempts to convulse, bending your " + cockDescript(x) + " slightly, while her neglected dick gives a little squirt of pearly semen which lands on the raised line in the center of her body and makes a little trail as it rolls down.  The pressure of her twisting and the sensation of her pussy lapping at your shaft with aphrodisiac is enough to send you over the edge as well.  Your " + cockDescript(x) + " twitches as you unload into your blue partner");
            //[(big skeet)
            if (player.cumQ() > 500) outputText(" until flows past her lips");
            outputText(".");
            //[(mega skeet)
            if (player.cumQ() > 1500) outputText("  Eventually, she can't hold in the sheer volume of your ejaculate, and cascades past her lips onto the ground beneath you.  Spurt after spurt goes into and then out of her, pooling into the massive puddle of cum beneath the two of you.");
            outputText("  She takes the opportunity to squeeze along the length of your cock, pushing out as much semen as you have to offer as she moans in orgiastic delight at the fluid injection.");
            outputText("\n\n");

            outputText("Eventually both you and she are spent and limp, and you draw your " + cockDescript(x) + " out of her, making an extended, wet sucking noise.  As you pull up your gear and make your way up the beach, ");
            //[(normal/big skeet)
            if (player.cumQ() < 500) outputText("her hands are still dazedly playing with the space between her breasts where your cock used to rest.");
            //[(mega skeet)
            else outputText("she continues to sputter and cough up bubbles of your spunk.");
            //(pass 1 hour, reset lust to min or min+10 if big or greater skeet)
            player.sexReward("saliva", "Dick");
            cleanupAfterCombat();
        }
    }


    //using pussy:
    private function rapeAnemoneWithPussy():void {
        spriteSelect(SpriteDb.s_anemone);
        clearOutput();
        outputText(images.showImage("anemone-female-fuck"));
        outputText("As you review your handiwork, the stirrings in your feminine side focus your attention on the anemone's penis.  Those smaller tentacles on it should have plenty of pleasing venom in them as well.  You make up your mind to put them to use for you.\n\n");

        outputText("The anemone looks vacantly up at you as you approach.  Reaching forward, you take her cock in your hand");
        //[(lust victory)
        if (monster.lust >= monster.maxOverLust()) outputText(" after brushing hers aside");
        outputText(" and begin to fondle the crown, with its slippery tentacles.  As expected, her venom flows into your hand, imparting a sensation of heat that slides up your arm and diffuses into a gentle warmth.  After a few rubs, you lean down and carefully take her penis into your mouth.  It tastes of the ");
        if (flags[kFLAGS.ANEMONE_OR_SEA_ANEMONE] == 1) outputText("lake");
        if (flags[kFLAGS.ANEMONE_OR_SEA_ANEMONE] == 2) outputText("ocean");
        outputText("water and heats your mouth as it did your hand; ");
        //[(HP victory)
        if (monster.HP < 1) outputText("you can feel it harden as ");
        outputText("you caress it with your tongue before pulling it out and giving it a squeeze.  The blue girl shivers as a drop of pre-cum is forced out.\n\n");

        outputText("Next, you take the time to strip off your [armor], making sure to give a good show; the anemone entertains herself by stroking her erect prick and smearing around the pre-cum, grinning as she watches you.");
        //[(breastrow0>C-cup)
        if (player.biggestTitSize() > 2) outputText("  You give special attention to the presentation of your " + breastDescript(0) + ", removing your top with tantalizing slowness, letting each breast slip out and hang between you like fruit ripe to be taken, then making sure to rub them seductively to arouse both of you further.");
        //(hipsize=girly or better)
        if (player.hips.type > 6) outputText("  You make good use of your " + hipDescript() + ", too, giving a little shimmy to show off your pronounced curves.");
        outputText("  By the time you're finished, the anemone's crotch glistens with fluid from both her sexes; it's probably as wet as it was when she was underwater.  You lean into the anemone and give her a deep kiss, ");
        //[(breast0>C)
        if (player.biggestTitSize() > 2) outputText("making sure to let your [allbreasts] rub up against hers, ");
        outputText("then pull apart from her and ");
        //[(goddamn centaur)
        if (player.isTaur()) outputText("turn away, kneeling down to display your animalistic pussy readily.");
        else outputText("recline back on your [legs]. Spreading your thighs, you reach down with two fingers and pull apart your " + vaginaDescript(0) + " welcomingly; it's the last act in your sexual performance.");
        outputText("\n\n");

        outputText("The anemone wastes no time in assessing your intention and crawls forward onto you, returning your kiss with equal passion.  ");
        //[(no centaur)
        if (!player.isTaur()) outputText("You take her by the upper arms and pull her on top of you as you lie back in the sun-warmed shallows.  ");
        outputText("Her hair drapes over you as she lines her penis up with your " + vaginaDescript(0) + ", delivering heat to your body, but this is dwarfed by the sensation of her entry as she pushes her cock in for the first time.  ");
        player.cuntChange(monster.cockArea(0), true);
        outputText("The penetration combines with the aphrodisiac being injected straight into your hungry pussy to produce a feeling like euphoria.  Unable to focus your thoughts any longer, you allow the anemone to take the lead as she begins pumping into you, coating your labia with a mixture of her pre-cum and your own secretion.  Soon you're moaning lustily with complete disregard for anything except the pleasure between you as your lover ups the pace; ");
        //[(biped)
        if (!player.isTaur()) {
            outputText("as she thrusts hard and fast, her hair whips back and forth over your ");
            //[(breasts>manly)
            if (player.biggestTitSize() >= 1) outputText(breastDescript(0) + " and ");
            outputText(nippleDescript(0) + "s,");
        }
        //(centaur)
        else {
            outputText("as she pushes deeply into your cunt, her hair flies forward past your upper body, brushing along your skin.  On one pass you grab some and use it as a pleasure tool, rubbing it vigorously on your ");
            //[(breasts>manly)
            if (player.biggestTitSize() >= 1) outputText(breastDescript(0) + " and ");
            outputText(nippleDescript(0) + "s,");
        }
        outputText(" spreading heat along your chest to nearly match your vagina's.\n\n");

        outputText("The overwhelming sensations drive you over the edge and your " + vaginaDescript(0) + " contracts hungrily around the heat radiating from the anemone's cock.  As your orgasming pussy ");
        //(squirter)
        if (player.vaginas[0].vaginalWetness >= VaginaClass.WETNESS_DROOLING) outputText("soaks her crotch with juice and ");
        outputText("wrings her penis, the blue shaft responds enthusiastically; she pushes deeply into you as it begins spasming and squirting its load.  Your partner's mouth hangs open as you squeeze the cum out of her; with all her muscle control taken away, her head hangs limply");
        if (player.isTaur()) outputText(" on your back");
        //[(notits)
        else if (player.biggestTitSize() < 1) outputText(" on your chest");
        else outputText(" between your breasts");
        outputText(" as she gives up several streams of semen into your womb.  Finally, her cock empties out with a few last spurts; she came quite a lot and your womanhood feels pleasantly filled.  The two of you lie there for some time before she can recover enough to slip out of you.  When she does, a string of semen drips out of your abused pussy and mixes with the water below.\n\n");

        outputText("Having scratched your itch, you give her another kiss, catching her by surprise.  She smiles shyly at you as you gather up your clothes, then slips into the water as you start to dress again.");
        anemonePreg();
        //(reduce lust to min, pregnancy check)
        //(pass 1 hour, reset lust to min or min+10 if big or greater skeet)
        player.sexReward("cum", "Vaginal");
        cleanupAfterCombat();
    }

    //loss rapes:
    public function loseToAnemone():void {
        spriteSelect(SpriteDb.s_anemone);
        clearOutput();
        //loss via hp (only possible if PC engages her while already being at zero or kills himself with Akbal powers):
        if (player.HP < 1) {
            outputText("You collapse face-first into the ");
            if (flags[kFLAGS.ANEMONE_OR_SEA_ANEMONE] == 1) outputText("lake");
            if (flags[kFLAGS.ANEMONE_OR_SEA_ANEMONE] == 2) outputText("ocean");
            outputText(", weakened by your damage.  The last thing you hear before passing out is a faint <i>\"What?\"</i>\n\n");
            outputText("Several minutes later you awake to feel yourself washed onto the sand and hurting all over.  <i>\"You... dead?\"</i> The anemone is still with you; she must have found a stick from somewhere and is sitting next to you, judiciously poking you with it.  As you force your eyes open in answer she drops the stick with a startled yelp and hugs her knees to her chest.  Too beat-up to say anything, you can only stare at her, which unnerves her further. <i>\"Umm... bye,\"</i> she says, getting to her feet.  She heads for the water again, leaving you alone to recover.");
            sceneHunter.print("Now, if that's not enough, here's a hint: GO LOSE BY LUST!");
            cleanupAfterCombat();
            return;
        }
        //loss, neuter:
        if (player.gender == 0) {
            outputText("Shivering, you slump before the anemone and begin trying to remove your [armor].  She claps and peals happily, splashing over to you.  Pushing your trembling hands out of the way, she unfastens your garments and pulls them free of you... and then stops.  You look the girl in the face uncomprehendingly and she answers your gaze with a look of equal confusion.  Your head turns to follow her as she looks you up and down and even makes a circle around you, inspecting every inch and chewing her lip anxiously.");
            //[(lactating)
            if (player.biggestLactation() > 1) outputText("  For a moment the examination stops at the dribble of milk leaking from your " + nippleDescript(0) + "s.  With one finger she collects a bit and tastes it, only to grimace and stick her tongue out.");
            outputText("  Back at the front, the anemone motions questioningly toward your ornament-free groin with open palms.  You follow her gesture down to your spartan nethers, then look back up.  Her bottom lip is quivering and -- yes, it looks like water is beginning to well up in her eyes.\n\n");

            outputText("Hurriedly you begin to compose an explanation for your anatomy, and you get as far as telling her that you have no genitalia thanks to events since your arrival before she bursts into tears.  ");
            //[(low cor)
            if (player.cor < 33) outputText("You reach out instinctively to comfort her, but ");
            //(high cor)
            else outputText("You smirk, amused by the turnabout, until ");
            outputText("the anemone lashes out with a slap that knocks the expression off your face and makes your eardrums sing.  <i>\"Dumb!\"</i> she shouts, turning sharply; her tentacles lash past you as she about-faces.  She dives down below the surface and kicks water into your face spitefully as she swims away.  You sputter and rub your jaw a bit, then stand up and walk dizzily back to camp.");
            //(1 hour pass, lose 1/10th of max hp from current hp, lose 20 lust)
            player.takePhysDamage(10);
            dynStats("lus", -20, "scale", false);
            cleanupAfterCombat();
            return;
        }
        if (!sceneHunter.uniHerms) { //needs both to be active
            if (player.cockThatFits(36) >= 0) fitF();
            else if (player.hasCock()) nofitF();
            else vagF();
        } else sceneHunter.selectLossMenu([
                [0, "Dick", fitF, "Req. a cock fitting 36 area.", player.findCock(1, -1, 36) >= 0],
                [1, "Big Dick!", nofitF, "Req. a cock with area bigger than 36.", player.findCock(1, 36, -1) >= 0],
                [2, "Vagina", vagF, "Req. a vagina (AND UniHerms enabled, if you have a dick!)", player.hasVagina() && (!player.hasCock() || sceneHunter.uniHerms)],
            ],
            "Overcome by lust, you can't stand her anymore. The girl clearly won't mind... so what parts are you going to use?\n\n"
        );

        function fitF():void {
            var x:int = player.cockThatFits(36);
            outputText(images.showImage("anemone-male-fuck"));
            outputText("Shivering, you slump before the anemone and begin trying to remove your [armor].  She claps and peals happily, splashing over to you.  Pushing your trembling hands out of the way, she unfastens your garments and pulls them free of you, taking the opportunity to run a hand up your " + cockDescript(x) + ".  ");
            if (player.cumQ() < 50) outputText("A droplet");
            else if (player.cumQ() < 250) outputText("A squirt");
            else outputText("A steady flow");
            outputText(" of pre-cum follows up the inside in the wake of her stroke.  She touches her finger to the tip of your sensitive urethra and draws it away, stretching a string of your fluid through the air.  Putting the finger in her mouth, she savors the taste of you; the string manages to transfer to her bottom lip before she breaks it with a flick of her tongue.\n\n");

            outputText("She pushes you back on your haunches and leans over your groin.  Her hair-tentacles slither forward over her shoulders and drop");
            //[(normal)
            if (!player.isTaur()) outputText(" into your lap,");
            //(shitty taur)
            else outputText(" downwards, onto your hams,");
            outputText(" delivering lances of venom into your lower body.  The tingle warms your groin and more pre-cum leaks out of " + sMultiCockDesc() + ".  Her eyes lock onto a glistening dollop and she drops down quickly, enfolding the head of your " + cockDescript(x) + " in her cool mouth.  Her tongue dances around the crown of your " + Appearance.cockNoun(CockTypesEnum.HUMAN) + ", relieving it of the sticky pre.  Looking ");
            if (player.tallness > 48) outputText("up");
            else outputText("down");
            outputText(" at you, you can see a smile in the lines around her eyes even though her mouth is locked around your " + Appearance.cockNoun(CockTypesEnum.HUMAN) + ".  ");
            //[(if dual/multi-cox)
            if (player.cockTotal() > 1) {
                //[(cock2 doesn't exist)
                if (player.cockTotal() == 2) outputText("Your other dick rubs");
                //(cock2 exists)
                else outputText("The rest of your [cocks] rub");
                outputText(" against her cheek, smearing slick wetness on her blue face.");
            }
            outputText("\n\n");

            outputText("Her hands come up from the water and push two sheaves of her long, dangling hair into your [cocks].  Wrapping these bundles of tentacles around your " + cockDescript(x) + ", she clasps them in place with one hand and begins sliding them up and down your length.  Your " + Appearance.cockNoun(CockTypesEnum.HUMAN) + " begins feeling hotter and hotter from the injections and the friction of her hair, secreting more pre-cum into her obliging mouth.");
            //[(if vag)
            if (player.hasVagina()) {
                outputText("  Her other hand slips");
                if (player.vaginalCapacity() < 15) outputText(" a few fingers");
                else if (player.vaginalCapacity() < 30) outputText(" partway");
                else outputText(" all the way");
                outputText(" into your " + vaginaDescript(0) + ", sending a tingle through your lower lips and exposing your clitoris.");
                //[(if clit > 5")
                if (player.clitLength > 5) outputText("  Having achieved this, she pulls her hand out and wraps another bundle of tentacles around your " + clitDescript() + ", then begins jerking it off in time to her efforts on your " + Appearance.cockNoun(CockTypesEnum.HUMAN) + ".  Your eyes roll back in your head and your mouth gapes involuntarily at the rough stimulation of your swollen chick-stick.");
            }
            outputText("\n\n");

            outputText("The heat rubbing on your cock");
            if (player.hasVagina()) outputText(" and clit");
            outputText(" quickly gets to you, and the first orgasm begins to work its way up your [cocks].  Your " + cockDescript(x) + " lets fly into the anemone girl's mouth");
            //[(big skeet)
            if (player.cumQ() > 500) outputText(", bowing out her cheeks");
            //[(cray-cray skeet)
            if (player.cumQ() > 2000) outputText(" and squirting out her nose in thick ribbons");
            //[(multi-dix)
            if (player.cockTotal() > 1) {
                outputText(" as ");
                //[(dick2 = no)
                if (player.cockTotal() == 2) outputText("your cocks shoot");
                else outputText("the rest of your [cocks] shoot");
                outputText(" all over her face and hair, ");
                //[(small skeet)
                if (player.cumQ() < 500) outputText("drawing a pattern like a musical score on her blue skin");
                //(big skeet)
                else if (player.cumQ() < 2000) outputText("painting her skin white as she flinches and shuts her eyes tightly");
                //(cray-cray skeet)
                else outputText("whitewashing her entire upper body and running off until a fan of milky color spreads through the water around you");
            }
            outputText(".  The anemone swallows greedily as she pumps each stroke into her mouth");
            //[(big or > skeet)
            if (player.cumQ() >= 500) outputText(", her taut blue belly distending as it fills");
            outputText(".\n\n");

            outputText("After a grateful moment of rest as the anemone swallows your issue, her hands begin pumping once again.  Oh, god!  Your " + Appearance.cockNoun(CockTypesEnum.HUMAN) + " quickly returns to erectness under the renewed siege of aphrodisiac");
            //[(multi)
            if (player.cockTotal() > 1) {
                if (player.cockTotal() == 2) outputText(" and your other " + cockDescript(1) + " follows suit");
                else outputText(" and your other pricks follow suit");
            }
            outputText(".  The blue girl continues to stroke your privates with her tentacle hair, flicking your urethra with her tongue, until you've come twice more.  Nor does she display any intention of stopping there, but mercifully you black out and collapse into the water.  Half-frowning, the anemone shrugs and pushes your insensible form up onto the sandy shore.");
            //(pass 8 hours, reset lust to min)
            player.sexReward("saliva", "Dick");
            cleanupAfterCombat();
        }

        function nofitF():void {
            outputText(images.showImage("anemone-male-fuck"));
            outputText("Shivering, you slump before the anemone and begin trying to remove your [armor].  She claps and peals happily, splashing over to you.  Pushing your trembling hands out of the way, she unfastens your garments and begins to pull them free of you, but your [cocks] flops out and bops her in the nose!  As you fumble the rest of the fastenings and finish removing your gear, the blue girl watches mesmerized at the bobbing flesh in front of her, slick pre-cum leaking from the tip");
            //[(big skeet)
            if (player.cumQ() > 500) outputText(" in a steady stream");
            outputText(".\n\n");

            outputText("Almost reverently, she caresses the shaft of your [cock biggest], stroking lightly up its enormous length.  She pulls it down to her eye level, inspecting the head from several angles.  Tentatively, she opens her mouth and pulls your " + Appearance.cockNoun(CockTypesEnum.HUMAN) + " into it, trying to fit your expansive dickflesh into a hole that even to your lust-crazed mind looks much too small.  Despite her best efforts, she can't get more than the crown past her lips, though the reflexive motions of her tongue poking around and inside the opening make you shiver and push out more pre-cum.  The anemone eventually pops your [cock biggest] out of her mouth and frowns in frustration.  After a few seconds, she seems to reach a decision.  Moving your shaft out of the way, she walks around behind you.  She places one hand on your ");
            if (!player.isTaur()) outputText("waist");
            else outputText("flank");
            //[(not centaur)
            if (!player.isTaur()) outputText(" and pushes your shoulders down with the other");
            outputText(".  As she draws you backwards, you're forced to put your own ");
            if (!player.isTaur()) outputText("hands ");
            else outputText("forelegs knee-");
            outputText("down in front of you to keep from falling face-first.  ");
            //[(if non-centaur)
            if (!player.isTaur()) outputText("The head of your [cock biggest] dips into the lukewarm ");
            if (flags[kFLAGS.ANEMONE_OR_SEA_ANEMONE] == 1) outputText("lake");
            if (flags[kFLAGS.ANEMONE_OR_SEA_ANEMONE] == 2) outputText("ocean");
            outputText("water, sending a tingle down the shaft.  ");
            outputText("Behind you, the anemone has taken her blue, tentacled penis into her hand and is stroking it and fondling the tip, forcing her own pre-cum out and smearing it along her length.  Satisfied with its slipperiness, she edges forward until her cock is resting on your [butt].  Drawing her hips back, she lines it up with your " + assholeDescript() + ", then thrusts forward while pulling back on your waist.  The wriggly feelers slip past your butthole and light up your insides with her potent venom.");
            player.buttChange(monster.cockArea(0), true);
            outputText("\n\n");

            outputText("Taking a moment to transfer her now-free hand to your other hip, the anemone girl then begins to pump her stiff pecker into your " + assholeDescript() + ", pausing after every few strokes to gyrate her hips a bit, massaging your prostate with her feelers and smearing venom into it.  The stimulation brings you to your limit in minutes; your dick twitches spastically");
            //[(if balls)
            if (player.hasBalls()) outputText(" and your " + sackDescript() + " tightens up");
            outputText(".  This doesn't escape your blue lover's notice, and she quickly stops pumping.  Left at the edge of orgasm, you panic and look over your shoulder at her.  Judging by her grinning demeanour, she seems to be up to something diabolical.  You stare at her confusedly until you feel a new heat at the base of your [cocks]. Glancing down, you see that her tentacle-hair has wrapped around " + sMultiCockDesc() + " and is squeezing tightly!  Pleased with the arrangement, the anemone begins pumping and rubbing your prostate again, spreading new warmth through your " + assholeDescript() + ".  Your delayed climax finally arrives, but the <i>de facto</i> cockring");
            if (player.cockTotal() > 1) outputText("s");
            outputText(" prevent");
            if (player.cockTotal() == 1) outputText("s");
            outputText(" any semen from escaping!  The sensations swell and fade as your orgasm passes fruitlessly, your blue partner fucking away as merrily as ever.\n\n");

            outputText("For nearly an hour the anemone continues her performance, even going so far as to caress your swollen [cocks] with her unoccupied tentacles.  Several more orgasms arrive and desert you without bringing any relief from the pressure on your ");
            //[(if balls)
            if (player.hasBalls()) outputText(ballsDescriptLight() + " and ");
            outputText(multiCockDescriptLight() + ".  Eventually you get to the point where you can't take it anymore, and when you feel the next orgasm drawing close you straighten up and begin ");
            //[(man)
            if (!player.isTaur()) outputText("clawing at your tormentor's tentacles, trying to pry them from " + sMultiCockDesc() + " by main force.");
            //(horse)
            else outputText("bucking and stamping the ground, wanting to shake the tentacles loose but unable to reach them with your hands.");
            outputText("  Looking a bit irritated that you want to bring her fun to an end, the anemone nevertheless relents and releases her visegrip on your [cocks].  As the joy of seeing the way to your release cleared overtakes you, the anemone avails herself of your distraction to grab your arms and pull you toward her while pushing your [legs] out from under you.  The two of you fall backward into the shallow water as " + sMultiCockDesc() + " begins unloading its immense backup of semen in a high arc.  The ");
            //[(skeet amount)
            if (player.cumQ() < 500) outputText("strings");
            else if (player.cumQ() < 2000) outputText("streams");
            else outputText("gouts");
            outputText(" of jism ");
            //[(height <4' and non-horse)
            if (player.tallness < 48 && !player.isTaur()) outputText("fly over your head, and turning behind you, you see the anemone trying to catch them with an open mouth and her tongue out.");
            else if (player.tallness < 84 && !player.isTaur()) outputText("catch the air and rain down on both your faces, splashing quietly where they hit water.");
            else {
                outputText(" land right on your");
                //[(if breasts)
                if (player.biggestTitSize() >= 1) outputText(" breasts and");
                outputText(" face.  You hear the anemone giggling as you flinch from the white shower.");
            }
            outputText("  After several minutes of climax with you shooting more jism than you thought possible and the anemone banging out an accompaniment on your " + assholeDescript() + ", you finally begin to wind down.  The anemone, clearly turned on by the impressive amount of ejaculate, unloads her own blue cock into your asshole.  Her semen, lower in temperature than yours, forms a little pocket of cool inside your [butt].  She idly swishes her tentacles in the");
            //[(big skeet)
            if (player.cumQ() >= 500) outputText(" semen-colored");
            outputText(" water around her as you push out your last load and slip into a doze.\n\n");

            outputText("Pushing your inert form off of her dick, she slips out from under you and sits up beside.  ");
            //[(height <4' non-centaur)
            if (player.tallness < 48 && !player.isTaur()) outputText("She looks you over, then bends down and drinks up as much of the semen floating in the water as she can find nearby.");
            else outputText("She leans over you and begins licking the semen off your body, not stopping until you're clean (if slightly sticky).");
            outputText("  Having fed, she grins mischievously and grabs your [cock biggest], then tows your floating body to the shoreline with it.  She rolls you onto the sand and then swims for deep water, vanishing.");
            //(pass 8 hours, minus libido, reset lust to min)
            player.orgasm();
            dynStats("lib", -1);
            cleanupAfterCombat();
        }

        //loss rape, vaginal (only full females):
        function vagF():void {
            outputText(images.showImage("anemone-female-fuck"));
            outputText("Shivering, you fall to your knees before the anemone and begin trying to remove your [armor].  She claps and peals happily, splashing over to you.  Pushing your trembling hands out of the way, she unfastens your garments and pulls them free of you, but her bright expression dims a bit when she sees only your " + vaginaDescript(0) + ".");
            //[(lactation)
            if (player.biggestLactation() > 1) outputText("  For a moment it brightens again when she notices the dribble of milk leaking from your " + nippleDescript(0) + "s. With one finger she collects a bit and tastes it, only to grimace and stick her tongue out.");
            outputText("  <i>\"No food...\"</i> she muses, disappointment playing smally over her face.  You look up at her, frowning sympathetically.  She thinks for a minute, staring at your crotch, and then assumes a rakish smile");
            if (player.tallness < 48) outputText(", pulling you upright");
            outputText(".\n\n");

            outputText("Sitting down in the shallow water with her face toward yours, she takes your hand and pulls you forward until you're over her lap.  Her long tentacles settle into neat, straight rows and drape down her back and over one eye, giving her a sly, debonair look.  She rolls her gaze down your torso, and her free hand follows in short order as she caresses your");
            //[(if breasts)
            if (player.biggestTitSize() > 1) outputText(" " + breastDescript(0) + " and");
            outputText(" " + nippleDescript(0) + "s and drifts down past your navel.  It makes a stop at your vulva, tickling your most sensitive area and causing your " + clitDescript() + " to swell with proof of your pleasure.  The hand begins its return trip, delivering one upward stroke to your now-engorged button and shooting a spark up your spine.  It comes to rest on your hip, and the anemone presses you downward, slowly but insistently, until your " + vaginaDescript(0) + " comes to rest above her hard, blue shaft.  Two of her longer tentacles reach up from the water and touch themselves to your lower lips, pulling them apart and delivering jolts of aphrodisiac that make your " + vaginaDescript(0) + " clench and release convulsively.  Her hand resumes downward pressure, guiding your twitching pussy toward her erect blue shaft; its small tentacles bend upward in the manner of a flower turning to face the sun.  In a breathless moment the head and then the shaft push past the boundary of your open lips, the first intrusion sending home its own venom and tipping you over the teetering precipice of your control.  ");
            //[hymen removal]
            player.cuntChange(monster.cockArea(0), true);
            outputText("<i>\"O-oh!\"</i> the anemone exclaims as the intensifying contractions in your orgasming vagina cause the walls to lap at her penis.\n\n");

            outputText("The anemone releases your hand and transfers hers to your other hip just as the last of your willpower evaporates; you begin bucking your hips up and down her twitching blue shaft, painting the walls of your pussy with her venom like a mad virtuoso.  As the spasms in your " + vaginaDescript(0) + " ebb and flow with each new orgasm, the anemone's cool affectation changes to a mask of faltering determination, matching her attempt to hold out as long as possible while your demented pussy does its best to wring her dry.  From the looks on your faces it's unclear now who was intending to ravish whom!  Eventually the poor girl can take no more of it and her pulsing dick, swollen almost an inch more than when it went in with frenzied tentacles whipping this way and that, twitches and unleashes the first jet of her semen.  Her ejaculate is actually colder than your venom-teased cunt by a significant amount, creating a sharply-felt contrast as she shoots several more strings against the walls of your " + vaginaDescript(0) + " and the mouth of your womb.  The dichotomy couples with the satisfaction of finally getting what your pussy wanted to trigger the biggest orgasm yet and the gobsmacked anemone's jaw practically falls off her face as your " + vaginaDescript(0) + " squeezes faster than ever on her sensitive dick right after her own climax.\n\n");
            outputText("After several minutes of this final orgasm you fall backwards into the shallow water with a splash and pass out with a look of bliss, floating on a surface made choppy by your hectic ride.  The poor anemone takes a while longer to collect herself, then slowly pulls her limp dick out of your " + vaginaDescript(0) + " and tugs you up the beach past the tideline so you won't roll facedown in the water while you're unconscious.  She bends down and kisses you, tracing your " + nippleDescript(0) + "; too spent to hold up her hair, it drapes over your prone form as she leans and releases a last shot of her drug to ensure that your dreams will be of her.");
            anemonePreg();
            //(reduce lust to min, add 10 lust, pregnancy check)
            player.sexReward("cum", "Vaginal");
            dynStats("lib", 1, "lus", 10);
            cleanupAfterCombat();
        }
    }

    //Minotaur Cum combat circumvention:
    //(if PC has 1 or more Mino Cum, replaces last paragraph of initial encounter)
    private function minoCumForAnemonieeeeez():void {
        spriteSelect(SpriteDb.s_anemone);
        outputText("The initial surprise subsides to wooly-headedness and a feeling of mild arousal as the stingers in her tentacles find exposed flesh.  In panic of drowning you pull free of the ropy mass and backpaddle away from the girl until your [feet] reassuringly touch the shallows of the ");
        if (flags[kFLAGS.ANEMONE_OR_SEA_ANEMONE] == 1) outputText("lake");
        if (flags[kFLAGS.ANEMONE_OR_SEA_ANEMONE] == 2) outputText("ocean");
        outputText("bed.  As you shake your head to clear the haze, you notice a few of your items have fallen out of your pouches and are floating in the water.  The anemone has picked one in particular up and is examining it; a bottle of minotaur cum.  Her eyes light up in recognition as the fluid sloshes back and forth and she looks beseechingly at you, cradling it next to her cheek.  \"<i>Gimme?</i>\" she asks, trying to look as sweet as possible.\n\n");

        //[(PC not addicted)
        if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 0) {
            outputText("Do you want to make a present of the bottle?");
        }
        //(PC addicted but sated)
        else if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 1) {
            outputText("You're still riding high from your last dose; do you want to share your buzz with the girl? It might lead to something fun...");
        }
        //(PC addicted but in withdrawal)
        else {
            outputText("Oh hell no, you're not going to give that bottle away when you haven't even gotten your own fix yet! You raise your [weapon] and advance on the girl with a wild look in your eyes. She shivers a bit at your expression and drops the bottle with a splash, then recovers her composure and backs up a few steps. You grab the floating bottle, and the rest of your stuff, quickly.");
            //(gain lust, temp lose spd/str; if in withdrawal then proceed to fight, otherwise present choices 'Give' and 'Don't Give')
            var anemone:Anemone = new Anemone();
            startCombat(anemone);
            //(gain lust, temp lose spd/str)
            dynStats("lus", 4, "scale", false);
            anemone.applyVenom(1);
            return;
        }
        simpleChoices("Give", giveMino, "Don't Give", dontGiveMino, "", null, "", null, "", null);
    }

    //'Don't Give':
    private function dontGiveMino():void {
        spriteSelect(SpriteDb.s_anemone);
        clearOutput();
        outputText("You look sternly at the blue girl and hold out your hand.  As she realizes you don't intend to let her have the bottle, her face changes to a half-pout, half-frown.  When you don't react, she throws the bottle at your feet and shouts, \"<i>Mean!</i>\"  You bend down to pick it, and the other items, up, and when you straighten back up, she looks quite angry and her tentacles are waving all over the place.  Uh-oh.  You raise your weapon as the anemone giggles sadistically and attacks!\n\n");
        //(proceed to combat)
        var anemone:Anemone = new Anemone();
        startCombat(anemone);
        //(gain lust, temp lose spd/str)
        dynStats("lus", 4, "scale", false);
        anemone.applyVenom(1);
    }

    //'Give':
    private function giveMino():void {
        spriteSelect(SpriteDb.s_anemone);
        clearOutput();
        player.consumeItem(consumables.MINOCUM);
        outputText("You nod at the girl and she smiles and responds with a very quiet \"<i>Yay.</i>\"  As you pick up the rest of your stuff, she takes the top off of the bottle and chugs it like a champ, without even stopping to breathe.  Her eyes widen a bit as the drug hits her system, then narrow into a heavy-lidded stare.  Dropping the bottle with a splash, she falls to her knees with another.  She looks at you and licks her lips as she begins playing with her nipples. Obviously, she's feelin' good.  ");
        //[(lust<30)
        if (player.lust < 30) {
            outputText("Watching as her fondling devolves into outright masturbation, your own ");
            if (player.cockTotal() > 0) outputText(cockDescript(0) + " becomes a little erect");
            else if (player.hasVagina()) outputText(vaginaDescript(0) + " aches a bit with need");
            else outputText(assholeDescript() + " begins to tingle with want");
            outputText(".  You shake off the feeling and head back to camp, leaving her to her fun.");
        }
        //(lust>30)
        else {
            //(decrement MinoCum by 1, opens victory sex menu, uses win-by-lust context in ensuing scenes, increment corruption by 2 for getting a girl high just to fuck her)
            outputText("As her fondling devolves into genuine masturbation you realize this would be a good opportunity to take care of your own lusts.  If you do, how will you do it?");
            sexMenu(false); //softer options
            return;
        }
        endEncounter();
    }

    //anal
    private function anemoneButtPlugginz(dick:Boolean):void {
        clearOutput();
        //victory sex choice for males with cock fit 48 or females with clit >7": "her anus"
        //(change "If you do, which of your parts" to "If you do, which part" in pre-sex choice menu)
        outputText("Imagining your climax already, you look over the anemone.  Your gaze lingers on her breasts; she sticks them out enticingly, trying to catch your interest");
        if (monster.lust >= monster.maxOverLust()) outputText(" as she plays with herself");
        outputText(".  Nice, but not what you're looking for...  ");
        if (!player.isTaur()) {
            outputText("Opening your [armor] a bit, you stroke ");
            if (player.hasCock()) outputText("[oneCock]");
            else outputText("your " + vaginaDescript(0));
            outputText(" as y");
        } else outputText("Y");
        outputText("ou circle around behind her.  The anemone looks over her shoulder at you as you size her up.  There... that's what you wanted to see.  Tilting the girl forward with a hand on her shoulder, you lower yourself to get a better look at her backside.");

        outputText("\n\nThe rounded blue cheeks stick out as you slide your hand up her back and press gently to lean her over further.  You rub your other hand over them, giving a squeeze and, eventually, a smack.  She lets out a cute yelp at the blow and shakes her backside at you, as if to tempt you further.  It works; ");
        if (dick) {
            if (!player.isTaur()) outputText("you fish your [cockFit 48] out of your garments and rub it");
            else outputText("you rub your [cockFit 48]");
            outputText(" between the smooth blue curves");
        } else {
            if (!player.isTaur()) outputText("you finger your pussy");
            else outputText("you imagine the tightness of her hole");
            outputText(" until your " + clitDescript() + " starts to fill with blood and peeks from its hood");
        }
        outputText(", prompting a giggle from her");
        if (dick) outputText(" as you smear a dribble of pre-cum into the crack of her ass");
        outputText(".  Putting her hands down, she tries to angle her rear up to bring you in line with her pussy; you give her a harder smack and force her back down, much to her confusion.  The blue profile appears over her shoulder again, this time with a worried expression.  Squeezing her ass once with open palms, you lean down and plant a kiss on it. A nervous titter issues from the blue girl as you pull open her cheeks.");

        outputText("\n\nYou find... nothing.  There's no asshole, none at all.  Just a pair of smooth blue curves with nothing between them!  It's like a children's cartoon back here!  \"<i>What the hell...?</i>\" you blurt.");

        outputText("\n\nAlarmed by the noise and the sudden stillness, she shivers under you, even more at a loss for words than usual.  \"<i>Hey!</i>\" you bark, your half-deflated ");
        if (dick) outputText("cock");
        else outputText("clit");
        outputText(" already drooping indolently toward the water.  She turns and looks at you out of the corner of her eye, her face a rictus of suspense.");

        outputText("\n\n\"<i>Where's the hole?</i>\" you demand, pointing at your own [butt] for an example.");

        outputText("\n\nShe lights up as she understands your meaning, then lapses back into confusion when she remembers you're asking about hers, not your own.  Finally, she raises her shoulders a bit as if to shrug and shakes her head.");

        outputText("\n\n\"<i>Dammit, you have to have one!</i>\" you retort.  \"<i>Where does... where does your food come back out once you're done with it?</i>\"");

        outputText("\n\nAt this, she looks thoughtful for a few seconds, then points at her mouth.");

        outputText("\n\n\"<i>No... where does it come </i>out<i>?  You know, </i>after<i> you've eaten!</i>\"");

        outputText("\n\nShe blushes blue, then points at her mouth again and spits into the water by way of explanation.  Your jaw slackens as you take in her meaning.");

        outputText("\n\nWell, you've located her anus... what do you do now?");
        menu();
        addButton(0, "FUCK IT", anemoneQuoteUnquoteAnal, dick);
        addButtonIfTrue(1, "Hotdog", curry(hotdogTheAnemone, dick), "Not available for taurs!", !player.isTaur());
        addButton(4, "Fuck Off", fuckingAssholelessAnemoneeeez);
    }

    //[FUCK IT] (if cock fit 48, use cock; else use clit scenes)
    private function anemoneQuoteUnquoteAnal(dick:Boolean):void {
        clearOutput();
        var x:int = 0;
        outputText(images.showImage("anemone-bj"));
        if (dick) x = player.cockThatFits(48);
        outputText("You're in the mood for anal and anal you shall have.  ");

        if (!player.isTaur()) {
            outputText("Ever a purist, you stroke your ");
            if (dick) outputText(cockDescript(x));
            else outputText(clitDescript());
            outputText(" until it protrudes from the hole in your [armor], returned to full erectness.  ");
        }
        outputText("The anemone regards you intently as you approach her and ");
        if (!player.isTaur()) outputText("seize her head");
        else {
            outputText("mount her head");
            if (!dick) outputText(", angling your clit forward along your stomach by pinning it against the anemone's forehead");
        }
        outputText("; her hair delivers tingles of venom where it brushes your skin even as her own hands dawdle playfully along your [skin].  Without another word, you force her head into your groin as you ram your distended ");
        if (!dick) outputText("chick-");
        outputText("prick into her eager face.");

        outputText("\n\nHer moist mouth welcomes the rapid advent your ");
        if (dick) outputText("dick");
        else outputText("clit");
        outputText(" first with surprise, then with relish.  As you slide past her lips, your ");
        if (dick) outputText("[cockHead " + (x + 1) + "]");
        else outputText("tip");
        outputText(" is embraced by the rippling walls of her throat, already trying to milk you for spunk");
        if (!dick) outputText(" that won't come");
        outputText(".  The tightness seems to adjust to the ");
        if (dick) outputText("girth of your prick");
        else outputText("girl-th of your swollen button");
        outputText("; the anemone looks up at you with ");
        if (player.isTaur()) outputText("unseen ");
        outputText("eyes a-twinkle");
        if (player.hasBalls()) {
            outputText(", and her hair reaches forward to caress your [sack], delivering lancets of venom through the thin skin that send your arousal, and your production, into overdrive");
            if (!player.hasCock()) outputText(".  As your [balls] swell with blood and seed, you can't help but groan; there'll be nowhere for the largess to go, and it will be with you until your body reabsorbs it - or you make an outlet");
        }
        outputText(".  Your hips take over, thrusting into her brutally and knocking her head back and forth.  Her tentacles fly wildly, brushing all along your stomach and hips as you pound her mouth, leaving little stripes of heat on your [skin] that seep into your body and only make you want to come even more.");

        outputText("\n\nIt doesn't take long for the accommodating, self-adjusting passage to bring you to climax, aided by the touch of her stingers... you try to reduce the pace of your hips, to prolong the fun, but your lover is having none of it.  As you pull out slowly to ease yourself in again, her hair wraps around the shaft of your ");
        if (dick) outputText("dick");
        else outputText("clit");
        outputText(" suddenly, stroking vigorously even as it smears a burning wave of arousal along your length.  \"<i>F-fuck,</i>\" you moan, pushed beyond your control by the coup.");
        if (dick) {
            outputText("  Your [cockFit 48] begins to ejaculate, filling the blue girl's mouth with your seed; she sucks it down greedily, swallowing every drop.");
            if (player.cumQ() >= 1000) outputText("  You push so much cum into her that her belly actually rounds from the volume, transforming from a sleek, flat midriff into a barely-contained ball of sloshing liquid");
            if (player.cumQ() >= 2000) outputText("; even when her stomach skin can stretch no further, your body won't stop filling her, and the bulge expands up her esophagus, pushing out her chest and throat until she's full to the brim and rather reminiscent of a big, blue pear");
            if (player.cumQ() >= 1000) outputText(".");

            outputText("\n\nSatisfied, you pull out of the anemone's throat, dragging a line of semen with you that drools from the corner of her mouth.  She hiccups and giggles drunkenly, then wipes it away and licks it off of her hand.  \"<i>Thanks!</i>\" she chirps; she purses her lips for a kiss, but you push her away.");

            outputText("\n\n\"<i>Don't mention it...</i>\"  You leave her there, ");
            if (player.cumQ() >= 1000) outputText("bobbing roundly in the water as she tries to make her way from the shallows, ");
            outputText("and head back to camp.");
        } else {
            outputText("  Your clit, packed with nerves, shivers and sets off your orgasm as she strokes, and you bury it into her throat as your head rolls back.  The anemone flinches, unnoticed by you, as your vagina ");
            if (player.wetness() < 4) outputText("drools its lube along your length.  ");
            else outputText("squirts obscenely, coating your length and her face with your female orgasm.  ");
            outputText("Your body shivers as near-painful sensations wrack you, engulfed in the anemone's questing passage");
            if (player.hasBalls()) outputText(".  Your lover, hopeful, watches and waits for your testicles to rise into your groin and unload their cargo");
            if (player.cockTotal() == 0) outputText("; she even tries to push them up herself with her hands, as if that would make your clit produce the semen inside them");
            outputText(".");
            if (player.hasCock()) outputText("  Your clit remains unproductive; your male orgasm squirts out uselessly around her head, mingling with the ");
            if (flags[kFLAGS.ANEMONE_OR_SEA_ANEMONE] == 1) outputText("lake");
            if (flags[kFLAGS.ANEMONE_OR_SEA_ANEMONE] == 2) outputText("ocean");
            outputText(" water.  The girl's expression upon seeing this is pained, and she tries but fails to get free to follow the arcing white ropes, sending further spasms of pleasure through your sensitive distaff staff.");
            outputText("  Eventually your body calms enough to respond to your impulses, and you carefully draw your [clit] out of your lover's throat.");

            outputText("\n\n\"<i>No food,</i>\" she whines, pouting.  Negligent and uncaring, you shake your head");
            if (player.hasCock()) outputText(", pointing to the squiggles of your seed floating lazily in the ");
            if (flags[kFLAGS.ANEMONE_OR_SEA_ANEMONE] == 1) outputText("lake");
            if (flags[kFLAGS.ANEMONE_OR_SEA_ANEMONE] == 2) outputText("ocean");
            outputText("water,");
            outputText(" and leave her.");
        }
        //end scene, reset hours since cum and lust, reduce libido and sens a little
        player.sexReward("no");
        dynStats("sen", -.5);
        player.addCurse("lib", 0.5, 2);
        cleanupAfterCombat();
    }

    //[Hotdog!]
    private function hotdogTheAnemone(dick:Boolean):void {
        clearOutput();
        outputText(images.showImage("anemone-doggy"));
        var x:int = 0;
        if (dick) x = player.cockThatFits(48);
        //horses eat hay, not hotdogs
        outputText("Well... it's the spirit of the thing that counts, right?  That blue butt still does look pretty tempting.  You force the anemone forward again and squeeze them together; she giggles and tries once more to push her vagina toward you, but you push it down again and jam your ");
        if (dick) outputText("[cockFit 48]");
        else outputText("[clit]");
        outputText(" between her small, round cheeks, seizing one in each hand and forcing them to sleeve as much of your length as possible.  The girl looks back at you, her face a picture of confusion, but you do not even care.  Her cool ass feels otherworldly as you thrust through it, poking your tip out of the crack and then pulling back again; ");
        if (dick) outputText("pre-cum");
        else outputText("your juice");
        outputText(" drools onto her at one end of your motion, filling your little canyon of fun with a river of hot lubrication that you smear liberally throughout.");
        outputText("\n\n\"<i>Hey,</i>\" you call, \"<i>you could be helping.  Use your tentacles or something.</i>\"");

        outputText("\n\nThe anemone, ");
        if (dick) outputText("excited by the feel and sight of your pre-cum");
        else outputText("looking almost bored");
        outputText(", obliges and snakes several toward you; they stop just inside the range of your furthest stroke, flitting tantalizingly as if begging you to push into them.  Wary at first, you do so and they gently caress ");
        if (dick) outputText("your [cockHead " + (x + 1) + "]");
        else outputText("the nerve-packed end of your [clit]");
        outputText(", responding almost autonomously to wrap around it.  The grip is not enough to keep you from pulling back out, though, and they relinquish your shaft, leaving the tip covered in a warm lattice of venom that soaks through you.  A shudder wracks you, and you eagerly push in again, sliding first into her cheeks, then down the slick passageway made by your lube, and finally into the body-heating embrace of her tentacles.  As your ");
        if (dick) outputText("now-throbbing prick");
        else outputText("swollen, red clit");
        outputText(" wicks more of her venom into you, your hips begin to disobey your will, thrusting faster with each dose and pushing the anemone's face into the ");
        if (flags[kFLAGS.ANEMONE_OR_SEA_ANEMONE] == 1) outputText("lake");
        if (flags[kFLAGS.ANEMONE_OR_SEA_ANEMONE] == 2) outputText("ocean");
        outputText("bed; elbows crooked and fingers splayed, she still can't raise her head against the vigor of your onslaught.");
        outputText("\n\nBefore you can rub the very skin off your ");
        if (dick) outputText("cock");
        else outputText("clit");
        outputText(", you come.  Your body shakes and you nearly fall atop your lover; ");
        if (dick) {
            outputText("your swollen, painfully hard prick fountains with cum, coating the anemone's back and hair in white.  The venom in your system draws out your orgasm to incredible lengths, and " + sMultiCockDesc() + " ejaculates over and over until you feel lightheaded and woozy.");
            if (player.cumQ() >= 500) outputText("  When you've finished, not a single place on the anemone's backside is still blue; the giddy girl is shoving your semen into her mouth with her tentacles and hands, swallowing almost as much ");
            if (flags[kFLAGS.ANEMONE_OR_SEA_ANEMONE] == 1) outputText("lake");
            if (flags[kFLAGS.ANEMONE_OR_SEA_ANEMONE] == 2) outputText("ocean");
            outputText("water as jizz.");
        } else {
            outputText("your pussy clamps down, trying and failing to find something to squeeze and ");
            if (player.wetness() < 4) outputText("drooling its lube down your thighs.");
            else outputText("squirting cum behind you to rain onto your partner's calves and the surface of the ");
            if (flags[kFLAGS.ANEMONE_OR_SEA_ANEMONE] == 1) outputText("lake");
            if (flags[kFLAGS.ANEMONE_OR_SEA_ANEMONE] == 2) outputText("ocean");
            outputText(".  The anemone sighs impatiently as you twitch atop her, waiting for you to finish.");
        }

        outputText("\n\nYou slip from between the blue girl's asscheeks, tucking your still-sensitive length away with a flinch, and leave her behind.  The anemone ");
        if (dick) outputText("dares not move from her knees, balancing your freshly-shot load on her back as she tries to push it toward her face with her tentacles.");
        else outputText("looks indolently at you as you go.");

        //end scene, reset hours since cum and lust, reduce libido and sens a bit
        player.sexReward("no");
        dynStats("sen", -.5);
        player.addCurse("lib", 0.5, 2);
        cleanupAfterCombat();
    }

    //[Fuck Off]
    private function fuckingAssholelessAnemoneeeez():void {
        clearOutput();
        outputText("Dammit all.  Your fun is completely ruined and you're limp as toast in milk now.  You abruptly pull yourself upright, tucking away your goodies.");
        outputText("\n\n\"<i>No food?</i>\" she says, turning around and fixing a pout on you.");
        outputText("\n\n\"<i>Don't worry, I've got something for you.</i>\"  You place a hand behind your back and watch her face light up, then pull it out with the middle finger extended skyward.  \"<i>Eat it.</i>\"  As the rejection sinks in, you kick wet sand from the ");
        if (flags[kFLAGS.ANEMONE_OR_SEA_ANEMONE] == 1) outputText("lake");
        if (flags[kFLAGS.ANEMONE_OR_SEA_ANEMONE] == 2) outputText("ocean");
        outputText("bed into her stricken face and stomp off, mad as hell.");
        //-30 lust)
        dynStats("lus", -20, "scale", false);
        cleanupAfterCombat();
    }

    //Bee on Anemone: Finished (Zeik)
    //madzeikfried@gmail.com
    //[Ovipositor] option in rape menu
    private function anemoneGetsLayedByBeePositor():void {
        clearOutput();
        outputText(images.showImage("anemone-egg"));
        outputText("The tentacles on this girl sing a siren song and beg you to sample their venomous, greedy caresses as you plunge your egg-layer into her... even the small, blue feelers around the ");
        if (monster.HP < 1) outputText("reclining");
        else outputText("vigorously masturbating");
        outputText(" girl's pussy call to you.  Your insectile abdomen pulses as eggs shift, lining up for deposition, and your long, black ovipositor slides out, pulsing in time with your heartbeat.  The idea of having those feelers stroke your strange organ while you unload your pent-up eggs sounds so good that a drop of honey oozes out, filling the air with a sweet scent that makes your");
        if (player.antennae.type > Antennae.NONE) outputText(" antennae.type");
        else outputText("nose");
        outputText(" tingle.  The anemone's eyes light up as your black shaft drools, and she leans forward, catching the nectar on a finger and raising it to her lips.");

        outputText("\n\nYou watch with mounting arousal as she rolls your nectar on her tongue; her eyes widen at the taste and she smiles ingratiatingly at you.  \"<i>Sweet... more?</i>\" she coos, pursing her lips at you.");

        outputText("\n\n\"<i>As long as you stop making that stupid ");
        if (silly()) outputText("duck ");
        outputText("face,</i>\" you reply.");

        outputText("\n\nThe anemone looks quizzical, but wraps a hand around your egg-laying organ, pulling it closer.  You allow her to draw you in and press the black, wet tip to her mouth, and she raises her other hand to it and begins to stroke.  You shiver in pleasure as another gob of honey forms, and the anemone, watching your reaction, smiles slyly.  She slides two of her tentacles into each palm, adding the caressing, sticky sensation of her stingers to the handjob!  Your [legs] wobble as your blood vessels loosen and your ovipositor fills with warm, fluttering heat; it feels so fuzzy that you don\'t even notice when it begins oozing your nectar constantly.  You do notice, however, when she lifts your prong to her lips and brashly sticks her tongue right down the hole!");

        outputText("\n\nA wordless groan drops from your mouth as the girl's small, cool muscle probes the inside of your ovipositor.  She strokes the base eagerly, forcing more of your honey to the end to be lapped up; every time a glob rises to the top, her tongue greedily scoops it up, tracking a tingling, ticklish trail along the nerves on the inside of your black bee-prick.  Fuck, there's no way you can hold back... the first of your eggs is pushed from you, forcing the anemone's lips apart as it enters her mouth.");

        outputText("\n\n\"<i>Lumpy... ?</i>\"  Your intended receptacle pulls away grimacing as several more spurt from your organ, and deposits the one from her mouth into the ");
        if (flags[kFLAGS.ANEMONE_OR_SEA_ANEMONE] == 1) outputText("lake");
        if (flags[kFLAGS.ANEMONE_OR_SEA_ANEMONE] == 2) outputText("ocean");
        outputText("water alongside them.  The ovipositor in her grip squirms, wrapped in hands and tentacles, dropping spheres slowly and unsatisfyingly into the water as she decides what to do.");

        sceneHunter.print("Lust check: 50%. Taurs always fail.");
        if (player.isTaur() || player.lust >= 0.5 * player.maxLust()) {
            outputText("\n\n\"<i>Weird,</i>\" she says tersely, and starts jerking your ovipositor off with both hands once again; you shudder and try to will your arms to stop her onslaught of pleasure, but they can't.  As she smears her tentacles along the length of your black pseudo-cock, your resolve evaporates, and soon your tube is forcing out eggs into the open air, lulled by the enveloping warmth of anemone venom.  The brazen girl continues to stroke with four tentacles and one hand as she cherry-picks choice globs of your honey from your flow, spitting out any of the eggs she gets with them.  Your body does not even care, adding sphere after sphere to the spreading film floating on the choppy water.");
            //[(cock)
            if (player.hasCock()) {
                outputText("\n\nYou hurriedly open your armor as your ");
                if (player.cockTotal() == 1) outputText("male part erupts");
                else outputText("male parts erupt");
                outputText(" in sympathy, lancing semen over your partner.  Surprisingly, the anemone doesn't even notice, so absorbed is she in experimenting with your modified stinger.");
            }
            //[(Lev3 eggs)
            if (player.eggs() > 40) {
                outputText("  Eventually there are so many eggs ");
                if (player.hasCock() && player.cumQ() > 1000) outputText("and so much cum ");
                outputText("that they begin to collect around her, clumping and layering around her midriff like white, slimy algae on a pier post.");
            }
            outputText("  As the last rolls from you, the anemone raises your wilting ovipositor to her lips once again, eagerly drinking the final sweet secretions that fall out in long, slimy strings.");

            outputText("\n\n\"<i>Weird,</i>\" she repeats, tugging at the shriveling organ as it tries to recede into your slit.");
            outputText("\"<i>Ugh...</i>\" you respond, weak in the [legs].  With a jerk, you pull your abdomen away from her grasp, flinching as her skin rubs your sensitive slit, then turn to leave.  She catches your hand, looking almost concerned.");

            outputText("\n\n\"<i>Chunks...</i>\" the anemone says, gesturing to your wasted eggs.  \"<i>See... doctor?</i>\"");
        } else {
            outputText("\n\nYou have no such vacillations; you're gonna violate her.  As good as the tongue felt, your body wants to put these eggs in something.  Boneless, you'll never make it to her pussy, but... any hole's a goal.  Grabbing the anemone's face in both hands, you stuff your black organ into her mouth, right to the hilt.");

            outputText("\n\n\"<i>Mmmf!</i>\"  The blue girl struggles and tries to pull away as the next batch of eggs slides into her; her hands dart to yours, trying to pry fingers loose, but your grip is vice-like with renewed intensity as you focus on your release.  The slippery spheres barrel down her throat like marbles as the madness washes over you and settle heavily on her stomach.  ");
            if (player.eggs() < 20) outputText("It doesn't take long before you finish, pushing your cargo down her passageway in a neat, orderly line.");
            else {
                outputText("So many come that you can see them under her skin, a myriad of tiny bumps");
                if (player.eggs() >= 40) outputText("; these same bumps multiply upward as your long-suffering abdomen pushes out line upon line of eggs, and soon you can feel them pressing back against the tip of your ovipositor.  You squeeze the girl's head in your hands, holding her against the base, and concentrate; slowly, the deposited eggs give way to their siblings, stretching her elastic stomach and chest wide");
                outputText(".");
            }

            outputText("\n\nRelieved, you pull your shrinking tube from the wet mouth; a few straggling eggs fall from it, dropping into the water.  The anemone looks plainly queasy as she rubs her stomach.");

            outputText("\n\n\"<i>Hard...</i>\" she moans, pressing down on her midriff and frowning.  \"<i>Yucky...</i>\"");

            outputText("\n\nThat's too bad.");
            //[(silly mode and fert eggs)
            if (silly() && player.fertilizedEggs() > 1) outputText("  You briefly amuse yourself imagining her carrying your eggs to term and having them hatch in her mouth, so that when she talks, she shoots bees.  Nicolas Cage would be proud.");
            outputText("  Gathering your things, you " + player.mf("laugh", "giggle") + " at her and depart.");
        }
        player.dumpEggs();
        player.sexReward("no");
        cleanupAfterCombat();
    }

    //Drider on Anemone: Finished (Zeik)
    //[Ovipositor] option with spiderbutts
    private function spiderOvipositAnAnemone():void {
        clearOutput();
        outputText(images.showImage("anemone-egg"));
        outputText("As the girl's resistance ebbs, ");
        if (player.HP < 1) outputText("eyes unfocused with fatigue");
        else outputText("two fingers plunging eagerly into her pussy");
        outputText(", you advance on her.  Your abdomen bends forward and your egg-laying organ slides out, dripping slime into the water with little 'plit' noises; the girl, fascinated despite the strangeness of it, sits up and creeps forward to touch it.");

        outputText("\n\nWhen her cool, wet fingers connect with the sensitive end of your ovipositor, you can't help but push out a heady glob of lubrication.  Curious, she catches it on her palm, then raises it to her lips, nipping at it with her tongue.  Her face pinches into a grimace, and the little periwinkle triangle sticks out of her mouth as she childishly shakes her head back and forth and cries, \"<i>Eww!</i>\"");

        outputText("\n\nNot really the answer you wanted to hear.  As you tilt your drooling tube toward her, she tries to get away, turning over and splashing on hands and knees.  Not having any of that, you reach down and grab her foot.  She shrieks and lashes at you with her tentacles, catching your arm with one tingling swipe of venom - the rest land harmlessly on hard chitin.  However, they'll be trouble when you pull in close to actually deposit your eggs... there's little to do about it but get the hard part out of the way.");

        outputText("\n\nGrasping the nettle, you gather her squirming, writhing hair in your hands and pull it taut, then lasso it with a spray of silk, directing it with your foremost legs.  The feeling of your spinnerets weaving long criss-crossing strands down her hair to restrain it - of spewing white, sticky strings all over it - becomes increasingly sexual as her venom suffuses your bloodstream through your hands");
        //[(cock)
        if (player.hasCock()) outputText(", and your [armor] tightens as [eachCock] swells");
        else if (player.hasVagina()) outputText(", and the inside of your [armor] dampens with the lube your [vagina] leaves as it clenches around empty air");
        outputText("; you have to push yourself to finish working before you can lose yourself to it.  Completing your restraints, you release her tentacles.  They bob behind her in one mass like a long, cute ponytail, and only the ends are free to wiggle.  When she realizes this, her behavior changes dramatically.");

        outputText("\n\n\"<i>Off,</i>\" whimpers the anemone, thrashing the water, turning her head and trying reach the silk tie.  \"<i>Off!</i>\"");

        outputText("\n\nEven with her arms and legs free, having her hair tied seems to be traumatic for the anemone... experimentally, you restrain her hands and she looks at you with wet eyes; a tear actually falls from one, rolling down her cheek.  \"<i>Off...</i>\" she begs, pouting.  \"<i>Please?</i>\"");

        outputText("\n\n\"<i>Soon,</i>\" you answer.  The first order of business is to clear out the uncomfortable pressure in your abdomen unhindered");
        if (player.cor < 60) outputText(", even though her adorable and slightly surreal puppy dog eyes implore you otherwise");
        outputText(".  \"<i>Let me just finish what I need to do first.</i>\"");

        outputText("\n\nFrowning, the girl shakes her head.  \"<i>No...</i>\" she insists, \"<i>off first!</i>\"  Well, that's definitely not happening; she'll just overwhelm you with venom and ");
        if (player.gender > 0) {
            outputText("go for your ");
            if (player.hasCock()) outputText("cock");
            else outputText("cunt");
            outputText(", leaving");
        } else outputText("leave");
        outputText(" you holding the bag... of eggs, as it were.  Your steel your resolve and stride atop her, pinning the loose, wiggling end of her ponytail harmlessly against your chitinous underside and forcing her hands underneath her by lowering some of your weight onto her back.");

        outputText("\n\n\"<i>Be just a minute,</i>\" you grunt, searching out her pussy with your egg-laying tool.  A caress and a tingle of venom from its feelers tell you that you've found it, and you thrust forward, impaling the blue girl's cunt.");

        outputText("\n\nShe starts in surprise at this, moaning, and you reach down to wrap your hands under her chin, pulling her face up to look at you.  \"<i>Not so bad, eh?</i>\" you tease her.  The anemone's mouth hangs open wordlessly as you thrust your ovipositor against her entrance, and the nubby blue feelers of her vulva bend inward toward it, tracing lines as you draw out and sending shivers through your twined bodies.");

        outputText("\n\n\"<i>Oooh...</i>\" she sighs, relaxing under you.  \"<i>M-more...</i>\"  The girl has completely forgotten about her hair now, consumed by arousal.  Her pussy clings wetly to your egg-laying tube as you pump her; not strong enough to clamp the slime-slicked organ in place, her squeezes only serve to tighten the passage you thrust through and tickle the tip as you rub it against her insides.  The sensation is beyond you, and the first of your eggs pushes into position, sliding smoothly down your oviduct and into her snatch.");

        outputText("\n\n\"<i>Ah-ahh!</i>\" she cries, as it enters her.  The anemone's passageway ripples around you in climax, and below her body, unseen by you, her little blue cock drools its seed into the ");
        if (flags[kFLAGS.ANEMONE_OR_SEA_ANEMONE] == 1) outputText("lake");
        if (flags[kFLAGS.ANEMONE_OR_SEA_ANEMONE] == 2) outputText("ocean");
        outputText(".  Her elbows buckle as your egg-bloated prong plugs her tight vagina, but your grip on her chin prevents her from falling facefirst into the water; she looks up at you adoringly, eyes alight with affection.");

        outputText("\n\n\"<i>Don't worry,</i>\" you murmur, ");
        //[(sexed)
        if (player.gender > 0) outputText("while unfastening your [armor] with one hand, ");
        outputText("\"<i>there is definitely more.</i>\"  The next two eggs slip into her as you speak, sending convulsions through her body.  Her pussy spasms again and enfolds your ovipositor even more tightly; you're ready for the sensation this time, and allow it to resonate through you, forcing out your own wet orgasm.  You hold her face as you unburden yourself");
        if (player.hasCock()) {
            outputText(" and cover her hair with yet more white strings from your twitching manhood");
            if (player.cockTotal() > 1) outputText("s");
        }
        //(egg level 3)
        if (player.eggs() >= 40) outputText("; so many eggs pump into her that she gives a little start when her distended belly touches the lukewarm water below");
        outputText("... finally you let her go when you're completely empty, pulling your stalk from her with a lewd sucking noise.  A little bit of green goo drools from her pussy as she slumps over on her side, and you make ready to leave her there - bloated and pregnant, with a squiggle of her semen floating in the water next to her.");

        outputText("\n\n\"<i>W-wait,</i>\" she pants, and you turn back.  \"<i>Off...</i>\"  The begging anemone fixes you with a desperate, pleading gaze, trying to reach around her body to her hair.");

        //[(corr < 75)
        if (player.cor < 75) {
            outputText("\n\nWell, you did say you would.  Bending over her, you cut the string tying her tentacles with one pointed leg, allowing them free play once again.");

            outputText("\n\n\"<i>Thank... you...</i>\" she pants, and closes her eyes in sleep.");
        }
        //(else corr >=75)
        else {
            outputText("\n\n\"<i>Oh, that?  I lied,</i>\" you say.  \"<i>But really, it's a good look for you.  Very cute.  Just keep it.</i>\"");
            outputText("\n\nThe girl graces your retreating back with a look of horror, struggling to pull her suddenly-heavy body upright and reach her hair, and you can hear her plaintive whines for quite a while as you walk.");
        }
        //ponytailed anemone with Lisa Loeb glasses WHEN
        player.dumpEggs();
        player.sexReward("no");
        cleanupAfterCombat();
    }
}
}
