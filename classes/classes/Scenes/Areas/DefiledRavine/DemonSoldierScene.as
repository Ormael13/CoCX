/**
 * @author Doc_Vermin
 * Ported to CoCX by Svalkash.
 */
package classes.Scenes.Areas.DefiledRavine {
import classes.BaseContent;
import classes.BodyParts.*;
import classes.GlobalFlags.*;
import classes.PerkLib;
import classes.PregnancyStore;
import classes.Races;

public class DemonSoldierScene extends BaseContent {
    public function encounterTheSoldierz():void {
        clearOutput();
        monster = new DemonSoldier();
        if (flags[kFLAGS.DEMON_SOLDIERS_ENCOUNTERED] < 1) {
            outputText("As you pick your way through the terrain a shadow passes overhead, looking up you spot a large flying shape silhouetted against the sun. At first you think it might be some sort of bird, but as the shape swoops closer you see that the wings are more like those of a bat, with a long, spaded tail trailing out behind. Uh-oh...");
            outputText("\n\nThe Demon lands in front of you with an almost liquid grace. [monster He] folds [monster his] wings behind [monster his] back, and [monster his] tail whips back and forth as a truly malevolent grin splits the infernal creature's face.");
            if (!player.isAnyRaceCached(Races.DEMON, Races.IMP)) outputText("<i>\"Well well, it looks like I've found some sport to liven up a dull patrol!\"</i>");
            else outputText("\"<i>Hmm... you may look like one of us, but I can smell your soul from here; I shall enjoy fucking it out of you!\"</i>");
            outputText(" The " + (monster as DemonSoldier).demonTitle(0) + " purrs. \n\nThe demon draws [monster his] wickedly serrated scimitar and adopts an aggressive combat stance. It's a fight! ");
            flags[kFLAGS.DEMON_SOLDIERS_ENCOUNTERED] = 1;
        } else {
            outputText("Another of Lethice's demonic soldiers swoops down out of the sky and attacks, announcing \"<i>I'll enjoy turning you into a fuck-toy, mortal!\"</i>");
            outputText("\n\nThis time, the demon is " + (monster as DemonSoldier).demonTitle(1) + " and [monster he] draws [monster his] scimitar. It's a fight! ");
            flags[kFLAGS.DEMON_SOLDIERS_ENCOUNTERED]++;
        }
        if (monster.looksFemale()) camp.codex.unlockEntry(kFLAGS.CODEX_ENTRY_SUCCUBUS);
        startCombat(monster);
    }

    public function victoryOverSoldier(hpVictory:Boolean):void {
        clearOutput();
        if (hpVictory) {
            outputText("The " + (monster as DemonSoldier).demonTitle() + " sprawls on ground before you, weakened and dazed, you're quite sure [monster he] couldn’t put up even the slightest resistance to anything you might want to do...");
        } else {
            outputText("The " + (monster as DemonSoldier).demonTitle() + " can take no more of your relentless sexual stimulation, and gasps as [monster he] drops to [monster his] knees, frantically masturbating with both of [monster his] hands <i>and</i> [monster his] tail. <i>\"Unngh... Holy Mother of Fuck, Ahh... what manner of mortal <b>are</b> you?\"</i>");
        }
        menu();
        //Victory fuck goes here.
        if (player.lust >= 33) {
            outputText("\n\n<b>What (if anything) do you want to do to the Demon Soldier, and with what part of your body?</b>");
            addButton(0, "Get Oral", giveTheDemonGoodFacial).hint("Put the demon's mouth to a good use servicing you.");
            //addButton(1, "Fuck Vag", giveTheDemonVagFuck).hint("Put that cock of yours to a good use breeding the demon."); //Sadly no written scene.
            //addButton(2, "Fuck Anal", giveTheDemonButtStuffing.hint("There's more than one way to fuck the demon. Ream the demon from behind!"); //Same with anal.
        } else {
            outputText("\n\n<b>Unfortunately, you're not horny enough to consider sating your urges.</b>");
            addButtonDisabled(0, "Get Oral", "You're not horny enough to consider doing that.");
        }
        //Eliminate the demon threat.
        if (hpVictory) addButton(3, "Kill " + monster.mf("Him", "Her"), killTheSoldier);
        else addButtonDisabled(3, "Kill " + monster.mf("Him", "Her"), "You must have beaten the demon by reducing [monster his] HP to zero.");
        //Nothing? Fuck off kindly.
        addButton(4, "Leave", cleanupAfterCombat);
    }

    private function giveTheDemonGoodFacial():void {
        clearOutput();
        outputText("You approach the vanquished " + (monster as DemonSoldier).demonTitle() + " " + (player.cor < 40 ? "hesitantly" : (player.cor < 75 ? "with a wicked grin on your face" : "positively salivating at the prospect of raping [monster him] senseless")) + ", and quickly set about stripping " + player.clothedOrNakedLower("both yourself and ", "") + "your victim naked.");
        outputText("\n\nTaking the belt from the Demon's scabbard, you bind [monster his] hands behind [monster him] (making sure to trap [monster his] wings as you do so), and roll the creature over onto [monster his] back, then stand back to look over your helpless victim.");
        outputText("\n\nThe " + (monster as DemonSoldier).demonTitle() + " squirms and moans on the ground as you squat down beside [monster him] and slowly run your fingertip around [monster his] " + (monster.hasCock() ? "cock head" : "pussy lips") + " before leisurely drawing [monster him] up the infernal beast's midriff, over [monster his] [chest] and up to [monster his] lips, where the Demon begins to suckle enthusiastically at the intruding digit.");
        outputText("\n\nYou decide to take advantage of the hellish monster's willing mouth.");
        sceneHunter.passCheckOnce(); //I'm porting it, so I do what I want!!
        sceneHunter.selectGender(dickF, player.hasVagina() ? vagAssF : null, player.hasVagina() ? null : vagAssF);

        function dickF():void {
            sceneHunter.passCheckOnce();
            sceneHunter.selectFitNofit(dickFits, dickTooBig, 65);
        }

        function dickFits():void {
            outputText(" Putting the head of your [cockFit 65] to the creature's soft, glossy lips, the fiend again begins to suckle, and " + player.multiCockDescriptLight() + (player.cockTotal() == 1 ? " begins" : " begin") + " to swell. Soon your throbbing fuck-stick" + (player.cockTotal() == 1 ? " is" : "s are") + " granite-hard.");
            outputText("\n\nGrabbing hold of the Demon's horns you ram your [cockFit 65] deep into [monster his] gullet, the beast easily takes your meaty dick down [monster his] experienced, cock-milking throat. You rock your " + (player.isTaur() ? "equine flanks" : "hips") + " as you roughly face-fuck the helpless " + (monster as DemonSoldier).demonTitle() + " and use your grip on [monster his] horns to slide the infernal monster's head back and forth, forcefully dragging the dick-sucking circle of [monster his] lips up and down the length of your prick.");
            outputText("\n\nBefore long the Demon begins to suck in earnest, no doubt finding the current situation entirely familiar, [monster his] throat muscles begin to contract around your member as though trying to swallow you whole! Meanwhile the creature's inhumanly long tongue snakes around [monster his] meaty mouthful, pumping away seemingly of its own accord.");
            outputText("\n\nYou thrust and grunt as the obscene slurping of your lewd throat-fucking fills the air, your bound victim bucking beneath you, gulping your cock while simultaneously gripping the base with the dexterous coils of [monster his] tongue.");
            outputText("\n\nThe pace of your humping becomes more frantic as the stimulation grows more intense, mashing the Demon's face into your " + (player.isGoo() ? "gooey" : (player.isFurCovered() ? "fuzzy" : (player.isScaleCovered() ? "scaly" : ""))) + (player.isTaur() ? " underbelly" : " pelvis") + " until, finally, you hilt yourself in [monster his] hot, wet mouth and gasp as you ");
            if (player.cumQ() < 50) {
                outputText("squirt your load directly down the beast's waiting throat.");
            } else if (player.cumQ() < 250) {
                outputText("gush a sizable load into the beast's waiting throat.");
            } else if (player.cumQ() < 1000) {
                outputText("shoot seemingly endless jets of sticky cum directly down the beast's waiting throat, which [monster he] gulps down noisily.");
            } else if (player.cumQ() < 2500) {
                outputText("blast so much cum into the beast that [monster his] cheeks balloon comically and little jets of pearlescent spooge shoot out of [monster his] nose as [monster he] struggles to keep up with swallowing your mighty load.");
            } else {
                outputText("gush a vast flood of cum directly down the beast's waiting throat, and the look on the Demon's face is priceless as [monster he] realises that the torrential flood of jizz isn't letting up. As [monster he] struggles to keep up with swallowing your titanic load [monster his] cheeks balloon out, streams of cum spurt out of [monster his] nose and around your shaft, and [monster his] stomach begins to swell, eventually reaching the size of a beachball!");
            }
            outputText("\n\nFinally, you pull your cock from [monster his] silken sheath" + (player.cockTotal() > 1 ? ", as your other cock" + (player.cockTotal() == 2 ? " splatters" : "s splatter") + " cum onto the ground" : "") + " and finish the last of your orgasm over the " + (monster as DemonSoldier).demonTitle() + "'s face, as [monster he] gasps for long-denied air. ");
            player.sexReward("saliva", "Dick");
            sharedEnd();
        }

        function dickTooBig():void {
            outputText("\n\nYou realize, with some disappointment, that there's no way you can fit " + (player.cockTotal() == 1 ? "your [cock biggest]" : (player.cockTotal() == 2 ? "either of your" : "any of your") + " [multiCockDescriptLight]") + " in the demon's mouth. Not to be defeated so easily you bark at the hellish monster to put [monster his] tongue to good use.");
            outputText("\n\nImmediately, the long, slick rope of the beast's tongue slithers between [monster his] lips to " + (player.cockTotal() == 1 ? "encircle your hot cock, slipping and sliding across the throbbing surface," : "entwine [monster him]self around the throbbing poles of your dicks, writhing across them,") + " as the monster's lips continue to massage your " + player.cockHead(player.biggestCockIndex()) + ".");
            outputText("\n\nThe wriggling tip of the infernal organ dances " + (player.cockTotal() == 1 ? "up and down your meaty pillar of flesh while the rest of it loops around your shaft and pulls tight, firmly gripping your massive member even as [monster his] coils slide along your phallic length." : "all about your meaty pillars of flesh while the rest of it loops around your shafts and pulls tight, firmly gripping your massive members even as [monster his] coils slide along your phallic lengths."));
            outputText((player.isTaur() ? "You rest back on your haunches" : "You lean back") + " and relax as the captive demon services your " + player.multiCockDescriptLight() + " when the creature's tongue-tip rears back like a striking serpent before plunging into your piss-slit, drawing a sharp intake of breath from you.");
            outputText("\n\nA " + (player.isTaur() ? "whinney" : "ragged sigh") + " escapes your lips as you savour the sensation of the slippery tongue-lasso gliding back and forth along the length of your mighty, rock-solid prick " + (player.cockTotal() == 1 ? "" : "s") + ". The length of flesh writhing within your cum-vein thrashes and undulates, stimulating you from within even as the ropey coils pleasure you without.");
            outputText("\n\nYou groan as the squirming tendril worms [monster his] way down your urethra, the pleasure mounts and mounts until finally, with a body-wracking shudder you ");
            if (player.cumQ() < 50) {
                outputText("squirt your load over the beast's upturned face.");
            } else if (player.cumQ() < 250) {
                outputText("gush a sizable load over the beast's upturned face.");
            } else if (player.cumQ() < 1000) {
                outputText("shoot seemingly endless jets of sticky cum directly all over the beast's upturned face, while [monster he] slurps down as much as [monster he] can noisily.");
            } else if (player.cumQ() < 2500) {
                outputText("blast so much cum all over the beast that it's soon completely coated from the chest up in spooge as [monster he] struggles to swallow as much as [monster he] can of your mighty load.");
            } else {
                outputText("gush a vast flood of cum all over the beast's upturned face. The Demon coughs and splutters as [monster he] struggles in vain to keep up with swallowing your titanic load until at last [monster he]'s left gasping in a big, sticky pool of jizz, trying to blink hot wads of spunk from [monster his] eyes.");
            }
            player.sexReward("saliva", "Dick");
            sharedEnd();
        }

        function vagAssF():void {
            //First Body type check
            outputText("\n\n");
            if (player.isTaur()) {
                outputText("You position your hindquarters over the Demon's face and lower your flanks until [monster his] mouth is smooshed into your " + (player.hasVagina() ? "hot quim" : player.assholeDescript()) + ".");
            } else if (player.isGoo()) {
                outputText("You ooze onto the Demon, enveloping [monster his] " + (monster.hasBreasts() ? "voluptous bosom" : "chest") + " " + (player.hasVagina() ? "and smooshing [monster his] mouth into your slimy quim." : ", then turn around and smoosh [monster his] mouth into your " + player.assholeDescript()) + ".");
            } else if (player.isNaga()) {
                outputText("You wrap yourself around the Demon, leaning forward to smoosh [monster his] mouth into your " + (player.hasVagina() ? "hot quim" : player.assholeDescript()) + ".");
            } else {
                outputText("You straddle the Demon's head and kneel down, smooshing [monster his] mouth into your " + (player.hasVagina() ? "hot quim" : player.assholeDescript()) + ".");
            }
            //The demon eats you out!
            outputText("\n\nTasting " + (player.hasVagina() ? "pussy" : "your juicy rump") + " on [monster his] lips, the beast instinctively begins to lap at your " + player.assholeOrPussy() + ", the Demon licks and slurps, massaging your " + (player.hasVagina() ? "labia" : "ring-piece") + " with [monster his] lips while slipping [monster his] tongue into your " + (player.hasVagina() ? "rapidly dampening slit" : "palpitating hole") + ".");
            outputText("\n\nYou moan and grind down as the probing appendage burrows deep inside you, and soon your ");
            if (player.hasVagina()) {
                outputText("pussy is " + (player.averageVaginalWetness() < 2 ? "dewy" : (player.averageVaginalWetness() < 4 ? "wet" : "gushing")) + " with fem-cum and ");
            } else {
                outputText("butthole is slathered in ");
            }
            outputText("demonic saliva. At your urging the " + (monster as DemonSoldier).demonTitle() + " lets out more and more of [monster his] great, slick rope of a tongue, first doubling back on [monster him]self within the silken innards of your " + player.assholeOrPussy() + ", then wriggling [monster his] tip " + (player.hasVagina() ? "out of your lower lips to begin tracing circles around your [clit]" : "far inside your colon, stimulating and filling the deepest reaches your hole") + ".");
            outputText("\n\nYou toss back your head, back arched and groan in pleasure at the sensation of the slippery coils twisting and thrashing within you as the teasing tip " + (player.hasVagina() ? "remorselessly flickers across your throbbing joy-buzzer." : "whips around, remorselessly invading your deepest recesses. "));
            //Second Body type check
            outputText("\n\n");
            if (player.isTaur()) {
                outputText("Whinnying softly, your flanks tremble");
            } else if (player.isGoo()) {
                outputText("You gasp and squish your " + (player.hasVagina() ? "groin" : "ass") + " into the creature's face so forcefully that you almost push [monster his] whole head into your gooey flesh");
            } else if (player.isNaga()) {
                outputText("You groan and involuntarily begin to tighten your coils, only realising when the beast ceases [monster his] oral ministrations, and gasps out <i>\"...crushing...ribs...hhhrrggg...\"</i> Blushing slightly, you relax your constricting grip a little and sigh");
            } else if (player.isDrider()) {
                outputText("You gasp and your legs tremble, setting two pairs of knees on either side of you knocking together");
            } else {
                outputText("You press your thighs to the sides of the beast's head, gasping and groaning");
            }
            outputText(" as the stimulation of your " + (player.hasVagina() ? "hot, slick wetness" : "quivering guts") + " mounts.");
            outputText("\n\nYour helpless demonic captive undulates the fleshy ribbon of tongue buried within your intimate folds, corkscrewing [monster his] whorls and loops even as the tip ferociously molests your " + (player.hasVagina() ? "clit" : "innards") + ".");
            outputText("\n\nThe stimulation builds into an overwhelming crescendo causing your " + player.assholeOrPussy() + " to spasm with your climax, ");
            //Final vag or ass check of this section, decides orgasm type!
            if (player.hasVagina()) {
                outputText(player.averageVaginalWetness() < 2 ? "clamping down hard on the questing tongue as your orgasm washes over you." : (player.averageVaginalWetness() < 4 ? "spurting girl jizz into the Demon's face as you clamp down hard on the questing tongue while your orgasm washes over you." : "freely drenching the Demon's face with girl jizz as you clamp down hard on the questing tongue while your orgasm washes over you."));
                player.sexReward("saliva", "Vaginal");
            } else {
                outputText("pulsating and convulsing around the questing tongue with your ass-gasm. ")
                player.sexReward("saliva", "Anal");
            }
            outputText("You squeal in pleasure as you ride out the throes of your climax, rocking your " + (player.isTaur() ? "flanks" : "hips") + " and tossing back your head, you release an orgasmic cry. ");
            sharedEnd();
        }

        function sharedEnd():void {
            //The final part! Gender variations converge here.
            outputText("\n\n" + (player.hasCock() ? "With" : "The beast's inhumanly long tongue slides out of you and, with") + " a satisfied sigh, you climb off your demonic victim.");
            outputText("\n\nThe frustrated " + (monster as DemonSoldier).demonTitle() + ", " + (player.hasCock() ? "[monster his] face still covered with pearlescent spunk and " : (player.hasVagina() ? "face still smeared with your cunt slime and " : "")) + "[monster his] hands still bound behind [monster his] back, is desperately trying to masturbate as best [monster he] can.\n\n");
            //Variant for demon's genders.
            if (monster.hasCock()) {
                outputText("The demonic monster's well-used tongue wraps around [monster his] throbbing cock even as [monster his] tail plunges again and again into [monster his]" + (monster.hasVagina() ? " soaking snatch" : " puckered asshole") + ".");
            } else {
                outputText("The demonic monster's well-used tongue dives into [monster his] soaking snatch even as [monster his] tail plunges again and again into [monster his] puckered asshole.");
            }
            //Corruption variants!
            outputText("\n\n");
            if (player.cor < 40) {
                outputText("The lascivious display raises a twinge of guilt over succumbing to your base urges with a Demon, ");
                dynStats("cor", 1);
            } else {
                outputText("Tempting as it may be to engage with the lascivious display for round two, you have other matters to attend to, ");
                if (player.cor < 80) dynStats("cor", 0.5);
            }
            outputText("so you " + player.clothedOrNakedLower("dress", "move") + " quickly and leave the Demon work out [monster his] frustrations on [monster his] own; the wet, urgent sounds of energetic self-abuse following you as you head off.");
            cleanupAfterCombat();
        }
    }

    private function killTheSoldier():void {
        clearOutput();
        outputText("You make quick work of the demon before hauling the now-lifeless corpse away.");
        if (player.hasPerk(PerkLib.Purifier)) player.purifyDemonBonus();

        flags[kFLAGS.DEMON_SOLDIERS_KILLED]++;
        monster.additionalXP += 100; //YOU WON! You earned 20 EXP. Your LOVE increased.
        player.dynStats("cor", -1);
        //Additional loot!
        if (rand(8) == 0) {
            outputText("\n\nAs you're about to " + (player.isNaga() ? "slither" : "walk") + " away in satisfaction, you spot a glowing, pink crystal and a closer examination reveals it to be a lethicite. Why the demon hasn't even eaten it remains a mystery but either way, you're in luck to have recovered it before it gets eaten (and irreversibly absorbed) and you pocket it. ");
            inventory.takeItem(consumables.LETHITE, cleanupAfterCombat);
        }
        cleanupAfterCombat();
    }

    public function defeatedBySoldier(hpVictory:Boolean):void {
        clearOutput();
        outputText("Lying prostrate at the Demon Soldier's feet, you are barely even aware of the " + (monster as DemonSoldier).demonTitle() + player.clothedOrNakedLower("stripping off your " + player.armorDescript(), "looming even closer") + ". [monster He] takes the opportunity to run [monster his] hands across your helpless body, murmuring to [monster him]self, \"<i>Very nice, I can certainly work with this...</i>\"");
        if (monster.hasCock() && (rand(2) == 0 || !monster.hasVagina())) { //If the demon is a hermaphrodite, 50/50 split.
            demonLossSceneDicked();
        } else {
            demonLossScenePussied();
        }
    }

    public function defeatedBySoldierEnd():void {
        outputText("\n\n<i>\"Well, this was an amusing enough diversion,\"</i> muses the Demon Soldier, casually tossing your soiled [armor] to the ground. <i>\"However, the last time I was late back from patrol the Captain gave me two days in the barrel. Not that it wasn't fun, in its own way, but still, I'd best get going. I don't want to give him an excuse to think up something more... creative. See you soon, I hope, heh heh heh.\"</i>");
        outputText("\n\nSo saying, the Demon " + (player.gems == 1 ? "pulls a classic dick move by taking your last gem, then" : (player.gems > 1 ? "helps [monster him]self to a handful of Gems from your pouch, then" : "pouts as [monster he]notices how empty your gem pouch currently is, then")) + " spreads [monster his] wings and, with a mighty heave, launches [monster him]self into the air. You raise your head just long enough to see the hell beast rise until [monster he]'s little more than a dot in the sky, then slump back into the dirt and finally pass out.");
        dynStats("cor", 1);
        cleanupAfterCombat();
    }

    //Loss Scene 1: The demon rams you with his/her dick!
    private function demonLossSceneDicked():void {
        outputText("\n\nGrabbing hold of your " + player.hipDescript() + ", the Demon yanks your ass into the air. Pushing [monster his] face " + (player.isNaga() ? "into" : "between") + " your ");
        //Pussy or ass?
        if (player.hasVagina()) {
            outputText((player.isNaga() ? "groin" : "thighs") + ", the " + (monster as DemonSoldier).demonTitle() + " presses [monster his] mouth into your [vagina]");
        } else {
            outputText((player.isNaga() ? "serpentine groin" : "butt-cheeks") + ", the " + capitalizeFirstLetter((monster as DemonSoldier).demonTitle(2)) + " seals [monster his] lips over your [butthole]");
        }
        outputText(" and snakes [monster his] demonic tongue inside you. You squirm at the sensation of the inhumanly long, slippery tendril of flesh probing the innermost recesses of your [vagOrAss], and soon your " + (player.hasVagina() ? player.vaginaDescript() + " is dripping with a combination of demonic saliva and your own lubrication." : player.assholeDescript() + " is sopping with demonic saliva. "));
        outputText("\n\nThe relentless stimulation of the deepest, most intimate folds of your internal reaches has you biting your lower lip to keep yourself from crying out. Just as the tonguing really gets going, the Demon kneels upright, causing you to shudder as inch after inch of infernal tongue is whipped out of your wet hole. <i>\"That seems to be enough, I think,\"</i> the corrupted beast says.");
        outputText("\n\nAll you can do is lie there and take it as you feel your demonic assailant shift [monster his] position and press the tip of [monster his] throbbing demon-cock to your " + (player.hasVagina() ? "well-prepared pussy lips" : "spit-lubed sphincter") + ", pause for a brief moment, then lunge forward to ram [monster his] entire length into you, launching into a brutal slam-fucking. Both you and " + (monster as DemonSoldier).demonTitle(2) + " gasp and grunt as the creature pounds remorselessly at your [vagOrAss]. The rapid, drumbeat slapping of " + (player.isGoo() ? "flesh-on-slime" : "flesh-on-flesh") + " is overlaid with the wet, squelching of the Demon Soldier mercilessly punishing your hole.");
        if (player.hasVagina()) player.cuntChange(monster.cockArea(0), true, true, false);
        else player.buttChange(monster.cockArea(0), true, true, false);
        outputText("\n\nYour eyes roll up into your head as the Demon's pelvis wallops into your " + (player.isNaga() ? "pubic mound" : "buttocks") + " over and over again with such force that you are actually pushed along the ground, groaning in pain and pleasure at the frenzied " + (player.hasVagina() ? "raping" : "ass-raping") + " you're receiving.");
        //First Genital variants
        if (player.hasVagina()) {
            if (player.hasCock()) { //Herm variant
                outputText("\n\nThe Demon Soldier reaches underneath you and alternates between rubbing at your [clit], and pumping [monster his] clasped fist along your " + player.multiCockDescriptLight() + ", making you cry out involuntarily.");
            } else { //Female variant
                outputText("\n\nThe Demon Soldier reaches underneath you to strum [monster his] dexterous fingers against your [clit], drawing an involuntary squeal from you.");
            }
        } else if (player.hasCock()) {
            if (player.cockTotal() == 1) {
                outputText("\n\nThe Demon Soldier reaches underneath you to wrap [monster his] fingers tightly around your " + player.cockDescript() + " and begins to pump hard.");
            } else if (player.cockTotal() == 2) {
                outputText("\n\nThe Demon Soldier reaches underneath you and begins pumping hard at your " + player.multiCockDescriptLight() + ", alternating between them.");
            } else {
                outputText("\n\nThe Demon Soldier reaches underneath you and entwines [monster his] fingers in amongst your pulsating cocks, teasing and stimulating them.");
            }
        }
        outputText("\n\nThe tempo of the hellish beast's pistoning becomes more erratic, and spits and spurts of demonic pre-cum spray out around the creature's infernal cock.");
        outputText("\n\n\"<i>Aaahhhnnn... yeeesss, cum for me... unf... CUM FOR ME, FUCKSLUT!! AAAAHHHHH!!!!</i>\" The Demon shrieks, [monster his] tongue lolling from [monster his] mouth as [monster his] orgasm comes thundering up. The " + (player.hasCock() || player.hasVagina() ? "constant manhandling of your genitalia reaches fever pitch, as [themonster]'s skilful manipulation combined with the " : "") + "vigorous power fucking you're taking has you very close to cumming, yourself.");
        outputText("\n\nYou feel the Demon's infernal prick twitching and spasming within you, finally gushing a torrent of hellish sperm inside your ");
        if (player.hasVagina()) { //Pussy or Ass?
            outputText(player.isPregnant() ? "womb. The Demon leans close to your ear and murmurs; <i>\"That's it, let me soak the mewling spawn growing inside you with my demon spunk! If only I could get you double-pregnant!\"</i>" : "womb. The Demon leans close to your ear and murmurs; <i>\"Yes, take my corrupt seed into your belly. Grow fat with my spawn, brood-cow! It's all you pitiful mortals are good for!\"</i>");
        } else {
            outputText(player.isButtPregnant() ? "bowels. The Demon leans close to your ear and murmurs; <i>\"That's it, let me soak the mewling spawn growing inside you with my demon spunk! If only I could get you double-pregnant!\"</i>" : "bowels. The Demon leans close to your ear and murmurs; <i>\"Take it, bitch. Yeah, you like being my little fuck-toy, don't you, you cock-hungry buttslut?\"</i>");
        }
        outputText("\n\nDemonic spunk sprays out around the Infernal monster's cock as [monster he] continues thrusting into you, splattering sexual fluids all over the place, and triggering your own climax.");
        //Second Genital variants
        outputText("\n\n");
        if (player.hasVagina()) {
            outputText("Your pussy contracts, pulsing around the intruding phallus, " + (player.averageVaginalWetness() >= 4 ? "squirting a waterfall of fem-spunk onto the Demon Soldier's thighs." : "spurting female sex-fluids from your cock-stuffed hole.") + " ");
        }
        if (player.hasCock()) {
            outputText("Your " + player.multiCockDescriptLight() + " " + (player.cockTotal() == 1 ? "bucks" : "buck") + " beneath you, ");
            if (player.cumQ() < 50) {
                outputText("squirting gouts of pearlescent jizm into the soil under you. ");
            } else if (player.cumQ() < 250) {
                outputText("spitting out long ropes of sticky cum into the dirt under you. ");
            } else if (player.cumQ() < 1000) {
                outputText("disgorging jets of spooge, mingling with the sex-juices already soaking the earth under you.");
            } else if (player.cumQ() < 2500) {
                outputText("pouring a flood of sperm onto the ground under you, saturating the already soaked earth with your seed.");
            } else {
                outputText("your pulsating " + (player.cockTotal() == 1 ? "cum-vein" : "cum-veins") + " blasting a seemingly endless cascade of cum into the surrounding soil " + (player.hasBalls() ? "as your balls drain themselves of their own volition" : "") + ", spooge gushes out of you faster than the soil can absorb it, leaving you and the Demon kneeling in a large pool of spunk.");
            }
            outputText(" "); //Add a space just in case.
        }
        if (player.isGenderless()) {
            outputText("Your sperm-filled anus twitches and pulses around the violating pillar of demon meat as your ass-gasm shudders through you.");
        }
        outputText("\n\nThe " + capitalizeFirstLetter((monster as DemonSoldier).demonTitle()) + " pulls [monster his] now semi-flaccid dick from your thoroughly-fucked " + (player.hasVagina() ? "cunt" : "asshole") + " with a loud, obscene slurp and makes an attempt to wipe [monster him]self off on your " + player.clothedOrNaked(player.armorDescript(), "body") + ".");
        outputText("\n\nYou can just about manage a groan before you flopping onto the cum-splattered earth as infernal sperm flows freely from your ruined orifice.");
        if (player.hasVagina()) {
            player.knockUp(PregnancyStore.PREGNANCY_IMP, PregnancyStore.INCUBATION_IMP);
        } //Oh dear, you are pregnant!
        player.sexReward("cum", player.hasVagina() ? "Vaginal" : "Anal");
        defeatedBySoldierEnd();
    }

    //Loss Scene 2: The demon pussies you out! Actually, this involves oral.
    private function demonLossScenePussied():void {
        sceneHunter.selectLossMenu([
                [0, "Dick", curry(demonLossScenePussied_selected, 1), "Req. a cock", player.hasCock()],
                [1, "Vagina", curry(demonLossScenePussied_selected, 2), "Req. a vagina", player.hasVagina()],
                [2, "Ass", curry(demonLossScenePussied_selected, 0), "Req. to be genderless OR to enable UniHerms!", sceneHunter.uniHerms || player.isGenderless()],
            ],
            "Why not help the demoness decide how exactly she should please you?\n\n"
        );
    }

    private function demonLossScenePussied_selected(gender:int):void {
        //The sarcastic remark begins!
        if (gender == 1) { //Dick check go!
            if (player.cockTotal() < 3) { //1 or 2 dicks.
                if (player.biggestCockArea() < 6) {
                    outputText("\n\nYour demonic assailant moves down to your groin, and points at [eachCock] and laughs, mockingly. <i>\"Bwaahh hahahaha *snort* aahhaha... What the fuck " + (player.cockTotal() == 1 ? "is <b>that</b>" : "are <b>those</b>") + " supposed to be? Come on, you might as well just chug a Succubi Draft and be done with it! Pffthahaha!!\"</i>");
                } else if (player.biggestCockArea() < 16) {
                    outputText("\n\nYour demonic assailant moves down to your groin, and indifferently appraises [eachCock]. <i>\"Hmm, " + (player.cockTotal() == 1 ? "this" : "these") + " will do, I suppose, but " + (player.cockTotal() == 1 ? "it's" : "they're") + " hardly a challenge to one of <b>my</b> abilities.\"</i>");
                } else if (player.biggestCockArea() < 30) {
                    outputText("\n\nYour demonic assailant moves down to your groin, and quirks an eyebrow at your " + player.multiCockDescriptLight() + ". <i>\"Nice, " + (player.cockTotal() == 1 ? "this" : "these") + " will do very nicely...\"</i>");
                } else if (player.biggestCockArea() < 90) {
                    outputText("\n\nYour demonic assailant moves down to your groin, and licks [monster his] lips at the sight of your " + player.multiCockDescriptLight() + ". <i>\"Oooh... I think I'm going to enjoy you.\"</i>");
                } else if (player.biggestCockArea() < 200) {
                    outputText("\n\nYour demonic assailant moves down to your groin, and begins to salivate at the sight of your massive meat. <i>\"Yum, yum, now " + (player.cockTotal() == 1 ? "<b>that's</b> a <b>real</b> cock" : "<b>those</b> are <b>real</b> cocks") + "!</i>\"");
                } else {
                    outputText("\n\nYour demonic assailant moves down to your groin, eyeing up your ludicrously over-sized " + (player.cockTotal() == 1 ? "column" : "columns") + " of phallic flesh. <i>\"Holy shit! " + (player.cockTotal() == 1 ? "That's" : "Those are") + " the biggest " + (player.cockTotal() == 1 ? "cock" : "cocks") + " I've seen all week! Well, let no-one say I ever backed down from a challenge...\"</i>");
                }
            } else { //3 or more dicks.
                if (player.biggestCockArea() < 6) {
                    outputText("\n\nYour demonic assailant moves down to your groin, and smirks at your stubby cock-cluster. <i>\"Pfftt ahhahaha... So, what? you thought you could make up for lack of quality with quantity, maybe? Ha!\"</i>");
                } else if (player.biggestCockArea() < 16) {
                    outputText("\n\nYour demonic assailant moves down to your groin, and cooly regards your cluster of dicks. <i>\"Could be worse, I suppose. Still, hardly a stretch for me, so to speak.\"</i>");
                } else if (player.biggestCockArea() < 30) {
                    outputText("\n\nYour demonic assailant moves down to your groin, and smiles at the sight of " + player.multiCockDescriptLight() + ". <i>\"Oh, a buffet? I like it!\"</i>");
                } else if (player.biggestCockArea() < 90) {
                    outputText("\n\nYour demonic assailant moves down to your groin, and grins from ear to ear at the sight of your " + player.multiCockDescriptLight() + ". <i>\"Oh my, they all look so good. I'll have to sample each one!\"</i>");
                } else if (player.biggestCockArea() < 200) {
                    outputText("\n\nYour demonic assailant moves down to your groin, and squeals with glee at sight of your outsized clump of fuck-sticks. <i>\"Eeee... I can see you and I are going to get along <b>very</b> well indeed! Oh my, yes!\"</i>");
                } else {
                    outputText("\n\nYour demonic assailant moves down to your groin, mouth agape at the sight of your thicket of mega-cocks. <i>\"Fucking hell! Someone's been having some fun with Incubus Drafts, eh? " + player.clothedOrNakedLower("How the ever-loving fuckballs did you even fit these in your [armor], anyway?", "I doubt you'll ever find clothes to contain these junks of yours!") + "\"</i>");
                }
            }
            if (player.hasVagina()) { //Herm bonus!
                outputText("\n\n" + (player.hasBalls() && player.ballSize > 0 ? "Shifting your " + player.ballsDescriptLight() + " to one side" : "Sliding [monster his] hands down to your " + player.vaginaDescript(0)) + ", the infernal beast continues: <i>\"Oooh, and what have we here? looks like someone has a little something extra...\"</i>");
            }
        } else if (gender == 2) { //No dick? Pussies...
            outputText("\n\nYour demonic assailant moves down your body, leaning in closer to your " + player.vaginaDescript() + ", cooing <i>\"Let's see what we have here: " + (player.vaginalCapacity() < 5 ? "Oooh, what a cute, tight little snatch, " : (player.vaginalCapacity() >= 15 ? "Mmm, now here's a slut's cunt if ever I saw one, " : "")) + "I'll bet it tastes so sweet...\"</i>");
        } else { //What an asshole!
            if (player.gender == 0)
                outputText("\n\nYour demonic assailant moves down to your groin. Finding only a smooth patch, a puzzled look passes across [monster his] face before resolving into a sly grin: <i>\"A challenge eh? I love a challenge! Let's see here...\"</i>");
            else
                outputText("\n\nYour demonic assailant moves down to your groin. A sly grin appears on [monster his]: <i>\"A challenge eh? I love a challenge! Let's see here...\"</i>");
        }
        //End of first genital checks, move on to second checks! The demon's initial actions.
        if (gender == 1) {
            outputText("\n\nThe Demon " + (player.thickestCockThickness() < 3 ? "slips [monster his] mouth over the end of your [cock biggest]," : (player.thickestCockThickness() < 4.5 ? "stretches [monster his] mouth over the end of your " + player.cockDescript(player.biggestCockIndex()) + "," : "places a series of sloppy kisses long the length of your " + player.cockDescript(player.biggestCockIndex()) + " to suckle at your piss-slit")) + " and swirls [monster his] tongue around your " + player.cockHead(player.biggestCockIndex()) + ".");
            outputText("The stimulation causes you to sharply exhale involuntarily, and your " + player.multiCockDescriptLight() + " to begin to swell. The " + (monster as DemonSoldier).demonTitle() + " withdraws, releasing your cock from suction, a glistening spider-web of saliva linking the " + player.cockHead(player.biggestCockIndex()) + " of your " + player.cockDescript(player.biggestCockIndex()) + " with the infernal monster's lips.");
        } else if (gender == 2) {
            outputText("\n\nThe Demon traces around the edges of your pussy lips with the tip of [monster his] infernal tongue, before flickering the end of the slimy appendage across your [clit], making you gasp in pleasure as your sex fluids begin to flow freely. Strands of pussy juice and demon spit stretch between your moistened sex-hole and the Demon's lips as [monster he] withdraws from the tonguing.");
        } else {
            outputText("\n\nThe Demon " + (player.isNaga() ? "pushes [monster his] face into your [butt], and " : "") + "presses [monster his] lips to your [butthole]. You feel a pressure at your sphincter, and the beast's inhuman tongue burrows its way into your bowels. The sensation of the slimy appendage questing into the inner folds of your rectum forces a moan from your lips. The hellish creature withdraws with an audible slurp, yanking over a foot of tongue from your ass, and making you gasp, sharply.");
        }
        //Phew. Let's proceed!
        outputText("\n\n<i>\"Mmmmm, delicious.\"</i> [monster He] hisses <i>\"Now, let's put that pretty little mouth of yours to good use.\"</i> " + (player.isTaur() || player.tallness >= 90 ? "On all fours, the " + (monster as DemonSoldier).demonTitle() + " slinks up to your head, and, with" : "With") + " a smooth swivel, the " + (monster as DemonSoldier).demonTitle() + " straddles your face.");
        outputText("\n\nYour mouth is smooshed into the Demonic monster's drooling cock-socket, " + (monster.hasBalls() ? "[monster his] plump balls resting on your chin " : "") + monster.mf("he", "she") + " begins to rock [monster his] hips back and forth, rubbing [monster his] slippery snatch across your lips. <i>\"Come on, mortal; get licking. Don't pretend you don't want to.\"</i> The irresistibly sweet, spicy scent of infernal cunt slime fills your nostrils, inflaming your lusts, and soon " + (player.tongue.type == Tongue.DEMONIC ? "your own demonic tongue is delving and swirling through the hot, slick depths of the Demon's fuck-hole. " : "you're lapping hungrily at the Demon's fuck-hole, probing at the hot, slick interior. "));
        outputText("\n\nThe Demon clamps [monster his] thighs to the sides of your head and squeals. <i>\"Eeeee... Now you're getting the idea! Ooooh, work the clit! Work the clit!\"</i>");
        outputText("\n\nResponding to the hell-beast's urgings almost against your own will " + (player.tongue.type == Tongue.DEMONIC ? "the tip of your infernal tongue doubles back on [monster him]self, slipping out from between the Demon's wet cunt lips to begin circling [monster his] throbbing bitch-button." : "you begin alternating between ramming your tongue as deep as you can into [monster his] gooeyie snatch, and circling [monster his] throbbing bitch-button."));
        outputText("\n\nAs demonic fem-juices begin to dribble across your [face]" + (monster.hasCock() ? " and hot pre-cum starts spitting onto your [chest] from the end of [monster his] pulsating cock," : ",") + " the " + (monster as DemonSoldier).demonTitle() + " grinds [monster his] hips down in response to your efforts and groans in pleasure.");
        outputText("\n\n<i>\"Hhhhnnnnyyyyyeeeessssss... Good, nnngooood, hhhaaaahhh... Now... I want to... unf... taste you...\"</i>");
        if (player.isTaur() || player.tallness >= 90) { //Taur or large stature.
            outputText("\n\nYour infernal attacker lashes out [monster his] tongue, ");
            if (player.hasCock())
                outputText((player.cockTotal() == 1 ? "wrapping" : "snaking") + " it around your " + player.multiCockDescriptLight() + (player.cockTotal() == 1 ? "a few times" : ""));
            if (player.isHerm() || gender > 0)
                outputText(", and ");
            if (player.hasVagina() && gender > 0)
                outputText("plunging the end down into your " + player.vaginaDescript() + ", wriggling [monster his] way into your " + (player.averageVaginalWetness() < 2 ? "moist" : (player.averageVaginalWetness() < 4 ? "slippery" : (player.isGoo() ? "liquid" : "sopping"))) + " depths");
            if (gender == 0)
                outputText("plunging the end into your butt-hole and corkscrewing the soft, wet tendril deep, deep inside your colon");
            outputText(".");
        } else { //For the more normal ones.
            outputText("\n\nYour infernal attacker leans forward, ");
            if (player.hasCock() && gender > 0) {
                if (player.thickestCockThickness() < 4.5)
                    outputText((player.thickestCockThickness() < 3 ? "engulfing the end of your [cock biggest] in [monster his] hot, wet mouth" : "forcing the end of your [cock biggest] past [monster his] stretched jaw") + " and easily swallowing down " + (player.biggestCockLength() > 14 ? "over a foot of your throbbing length" : "your entire throbbing length down to the [sheath], burying [monster his] nose in your " + (player.hasBalls() ? "[sack]" : (player.hasVagina() ? "[vagina]" : "taint"))) + ".");
                else {
                    outputText(" messily licks [monster his] way along the length of your [cock biggest] to encircle the [cockHead biggest] with [monster his] tongue. ");
                    if (player.cockTotal() >= 2 && player.cockTotal() < 4) {
                        outputText((player.cockTotal() == 2 ? "Your other cock rubs" : "Both of your other cocks rub") + " up against the Demon's " + (player.cockTotal() > 2 ? "cheeks" : "cheek") + " as [monster he] bobs [monster his] head along your dick. ");
                    }
                    if (player.cockTotal() >= 4) {
                        outputText(" The Demon plunges face-first into your [mutiCockDescriptLight()] as [monster he] " + (player.thickestCockThickness() < 4.5 ? "bobs [monster his] head " : " slides [monster his] tongue-lasso ") + " along yours the length of your dick. ");
                    }
                }
            }
            if (player.hasVagina() && gender > 0) {
                outputText("The monster slips [monster his] tongue" + (player.hasCock() ? (player.thickestCockThickness() < 4.5 ? " from [monster his] cock-stuffed mouth, circling your [sheath] " : " further and further from [monster his] mouth, causing the noose around your dick to spin pleasurably") : "") + " ");
                outputText((player.hasBalls() ? " and surging around your [sack], before corkscrewing " : " before slithering ") + " into your " + player.vaginaDescript() + ". The rope of demon-flesh wriggles its way into your " + (player.averageVaginalWetness() < 2 ? "damp" : (player.averageVaginalWetness() < 4 ? "wet" : (player.isGoo() ? "slimy" : "gushing"))) + " pussy. ");
            }
            if (gender == 0) {
                outputText("The monster slips [monster his] tongue out, jamming the end deep into your ass-hole and writhing its way right up inside you.");
            }
            outputText("\n\nThe Hellish Beast's frenetic oral stimulation has you moaning into the girl-jizz soaked folds of [monster his] cunt, driving you wild and sending your tongue swirling faster and faster through [monster his] sodden recesses. In turn this feeds the creature's sexual frenzy, causing [monster him] to ");
            if (player.cockTotal() > 1 && gender == 1) {
                outputText("reach out");
                if (player.cockTotal() == 2) outputText("with both [monster his] hands to grasp your " + player.cockDescript(player.smallestCockIndex()));
                else if (player.cockTotal() == 3) outputText("and grab hold of both of your other cocks");
                else outputText("and grab hold of two of your other cocks");
                outputText(" and begins to pump hard and fast.");
            } else if (player.cockTotal() == 1 && gender == 1) {
                outputText((player.isNaga() ? " reach out to your groin," : " shove [monster his] hands between your legs, ") + (player.hasBalls() ? "caressing your [balls] with one hand whilst, with the other, " : "") + (player.hasVagina() ? "[monster he] thrusts [monster his] fingers past your pussy lips, wiggling and wriggling inside you alongside [monster his] tongue." : (player.isNaga() ? " [monster he] runs [monster his] hands over your serpentine hips, before " : " [monster he] gropes roughly at your buttocks, ")) + "poking several fingers into your [butthole], searching out your prostate");
            } else {
                outputText((player.isNaga() ? " reach out to your groin," : " shove [monster his] hands between your legs, ") + (player.hasVagina() ? " and thrust [monster his] fingers past your pussy lips, wiggling and wriggling inside you alongside [monster his] tongue. " : (player.isNaga() ? " [monster he] runs [monster his] hands over your serpentine hips, before " : " [monster he] gropes roughly at your buttocks, ")) + "poking several fingers into your [butthole], searching out your prostate.");
            }
        }
        //The final part!
        outputText("\n\nYou lie beneath the Demon Soldier, sucking, licking, bucking and writhing. Tongue whirling and twirling as the " + (monster as DemonSoldier).demonTitle() + " gropes and suckles at your flesh. The overwhelming musk of the abomination's sloppy fuck-hole and the mounting pleasure drive you rapidly towards your imminent orgasm. Judging by the way the Demon's soaking cunt is splashing infernal sex-fluids across your face the " + (monster as DemonSoldier).demonTitle() + " must be nearing [monster his] own climax.");
        outputText("\n\nThe Demon moans in [monster his] orgasm, [monster his] tongue " + (player.hasCock() ? "ripples around your " + (player.cockTotal() == 1 ? "cock" : "cocks") + ", " : "") + (player.isHerm() ? "and " : "") + (player.hasVagina() ? "quivers all along the length buried in your snatch, " : "") + (player.isGenderless() ? "quivers all along the length buried in your ass, " : ""))
        if (player.isTaur() || player.tallness >= 90) {
            //Strange, it seems this part isn't written. Improvise improvise improvise!
        } else {
            if (gender == 1) {
                if (player.thickestCockThickness() < 4.5) outputText("[monster his] throat vibrating around your phallic meat, ");
                else outputText("[monster his] infernal mouth vibrating around your phallic meat, "); //Improvised piece.
            } else if (gender == 2) {
                outputText("as [monster he] murrmurs incoherant groans of ecstasy into your pussy, ");
            } else if (gender == 0) {
                outputText("momentarily breaking the seal of [monster his] lips over your ass-hole to utter incoherent groans of ecstasy, ");
            }
            outputText("building to a shuddering peak. Your hellish attacker's cooch spasms around your tongue, and a cascade of femme-jizz blasts you in the [face]" + (monster.hasCock() ? ", [monster his] bulging, bouncing demon-prick disgorging an almost continuous stream of pre-cum, giving way to a series of powerful jets of infernal sperm." : ""));
        }
        outputText("\n\nThe Demon Soldier jerks back [monster his] head, ");
        if (gender == 1) {
            if (player.isTaur() || player.tallness >= 90 || player.thickestCockThickness() >= 4.5) {
                outputText("and the long ribbon of demonic tongue whips " + (player.cockTotal() == 1 ? "around your cock" : "between your cocks") + " ");
            } else {
                outputText("your dick slides from the Demon's throat, " + (player.cockTotal() <= 2 ? "and the long ribbon of demonic tongue whips" + (player.cockTotal() == 2 ? " around the base of your other cock" : "") : "between your other cocks") + " ");
                if (player.hasVagina()) {
                    outputText("slipping from your sodden cunt as it retracts into the hell-beast's mouth ");
                }
            }
        } else if (gender == 2) {
            outputText("[monster his] tongue whips from your soaking hole, ");
        } else {
            outputText("[monster his] tongue whips from your spit-slimed butt-hole, ");
        }
        outputText("as the sex-crazed monster shrieks with climactic release.");
        //ORGASMMMMM! (Note: The orgasm is handled in the loss handler function.)
        outputText("\n\nThe sudden sensation of the demonic tongue " + (player.hasCock() ? "flashing around your cock" : "being snatched from your hole") + " drives you past your limit, triggering your orgasm. Your ");
        if (player.hasCock() && gender > 0) {
            outputText(player.multiCockDescriptLight() + (player.cockTotal() > 1 ? " quiver and flail" : " quivers and flails") + ", ");
            if (player.cumQ() < 50) {
                outputText("spitting out long strands of sticky cum");
            } else if (player.cumQ() < 250) {
                outputText("squirting gouts of pearlescent jizm");
            } else if (player.cumQ() < 1000) {
                outputText("disgorging great, twirling ropes of spooge");
            } else if (player.cumQ() < 2500) {
                outputText("fountaining a flood of sperm high");
            } else {
                outputText("blasting a seemingly endless cascade of cum");
            }
            outputText(" into the air" + (player.hasBalls() ? " as your balls drain themselves of their own volition" : ""));
        }
        if (player.hasVagina() && gender > 0) {
            outputText((player.hasCock() ? " while at the same time, your " : "") + (player.averageVaginalWetness() >= 4 ? "gushing cunt flutters as it erupts with a waterfall of girl-cum" : "soaking pussy flutters as it spurts and splatters girl-cum"));
        }
        if (gender == 0) {
            outputText("quivering anus winks and flutters ");
        }
        outputText("while your orgasm stampedes through you.");
        outputText("\n\nAlmost unnoticed as you ride out the last of your climax, the " + (monster as DemonSoldier).demonTitle() + " staggers to [monster his] feet as [monster his] own thunderous apex winds down and tries to wipe the sticky, sex-fluids smeared over [monster his] skin onto your " + player.clothedOrNaked(player.armorDescript(), player.skinDescript()) + ".");
        player.sexReward("saliva", gender == 1 ? "Dick" : gender == 2 ? "Vaginal" : "Anal");
        defeatedBySoldierEnd();
    }
}

}
