﻿/**
 * Created by aimozg on 04.01.14.
 */
package classes.Scenes.NPCs {
import classes.*;
import classes.BodyParts.Tail;
import classes.BodyParts.Tongue;
import classes.BodyParts.Wings;
import classes.GlobalFlags.*;
import classes.IMutations.IMutationsLib;
import classes.Items.Consumables.EmberTF;
import classes.Scenes.Places.TelAdre.YvonneArmorShop;
import classes.Scenes.SceneLib;

public class EmberScene extends NPCAwareContent implements TimeAwareInterface {
    //Variable and Flag Listing
    // EMBER_AFFECTION:int = 523; //: Pretty obvious
    // EMBER_HATCHED:int = 524; //: is ember hatched? 1 = true
    // EMBER_GENDER:int = 525; // 1 for male, 2 for female, 3 for herm. This also controls the egg's shell color.
    // EMBER_TYPE:int = 526; //numerical value; Ember is supposed to have many forms, this will control which one is born. (This is important for when Ember has hybrid forms.)
    // EMBER_COR:int = 527; //Controls Ember's current corruption levels, only default/dragon-girl Ember uses this. (Default starting value = 50)
    // EMBER_HAIR:int = 528; //0 for no hair, 1 for hair, 2 for mane.
    // EMBER_MILK:int = 529; //0 for no lactation, 1 for lactating.
    // EMBER_OVIPOSITION:int = 530; //0 for no egg laying, 1 for egg laying.
    // EMBER_ROUNDFACE:int = 531; //0 for anthro Ember, 1 for dragon-girl Ember. (You might want to control this with the Type flag since only default Embers use this variable.)
    // EMBER_EGG_FLUID_COUNT:int = 532; //This controls when it's time to hatch. Every item use and every time you use the egg as a masturbation aid, this will be incremented. Threshold for birthing is 5, but the birthing process can only be triggered when using as a masturbatory aid. This is done to allow players the chance to modify Ember before actually hatching.
    //BreathType: Controls which breath weapon the PC will have via TFing. Every Ember has its unique breath weapon to pass on.
    //EmberQuestTrigger: Controls whether the PC can still visit the lost dragon city. 0 can visit and 1 can't, special text will be displayed. (Future Expansion)
    //BreathCooldown: How many hours you need to wait to be able to use the breath weapon again.
    // EMBER_STAT:int = 533; //All Embers have a hidden stat, Corrupt has Ego, Pure has Confidence, Tainted has Affection, and hybrids vary. There is a need to track this, but only 1 special stat for every Ember.
    // EMBER_INTERNAL_DICK:int = 534; //Dragon-girl Ember can have either a internal sheath to keep " + emberMF("his","her") + " dick in or have it be more human-like. 0 = internal, 1 = external.
    //EmberKidsCount: How many children you've had with Ember, this will be important later.
    //BooleanEmberKidMale: If you've had a male child with Ember, having a herm sets both flags to 1 (true).
    //BooleanEmberKidFemale: If you've had a female child with Ember, having a herm sets both flags to 1 (true).
    // TIMES_EQUIPPED_EMBER_SHIELD:int = 535;
    // TOOK_EMBER_EGG:int = 536; //PC Take ember's egg home?
    // EGG_BROKEN:int = 537; //PC Smash!? ember's egg?
    // TIMES_FOUND_EMBERS_EGG:int =538; //Times stumbled into ze egg.
    // EMBER_JACKED_ON:int = 539; //Has the PC masturbated on the egg yet?  Needed to hatcH!
    // EMBER_OVI_BITCHED_YET:int = 540; //Used to trigger emberBitchesAboutPCBeingFullOfEggs()
    // EMBER_LUST_BITCHING_COUNTER:int = 541;
    // EMBER_CURRENTLY_FREAKING_ABOUT_MINOCUM:int = 542; // Used to trigger minotaurJizzFreakout()
    // DRANK_EMBER_BLOOD_TODAY:int = 543; //Cooldown for ember TFs

    // EMBER_PUSSY_FUCK_COUNT:int = 544;
    // TIMES_BUTTFUCKED_EMBER:int = 545;

    // EMBER_INCUBATION:int = 553;
    // EMBER_CHILDREN_MALES:int = 554;
    // EMBER_CHILDREN_FEMALES:int = 555;
    // EMBER_CHILDREN_HERMS:int = 556;
    // EMBER_EGGS:int = 557;
    // EMBER_BITCHES_ABOUT_PREGNANT_PC:int = 558;
    // EMBER_TALKS_TO_PC_ABOUT_PC_MOTHERING_DRAGONS:int = 559;
    // EMBER_PREGNANT_TALK:int = 560;

    // TIMES_EMBER_LUSTY_FUCKED:int = 824;

    public var pregnancy:PregnancyStore;
    public var dragonTFchanges:EmberTF = new EmberTF();

    public function EmberScene() {
        pregnancy = new PregnancyStore(kFLAGS.EMBER_PREGNANCY_TYPE, kFLAGS.EMBER_INCUBATION, 0, 0);
        pregnancy.addPregnancyEventSet(PregnancyStore.PREGNANCY_PLAYER, 330, 270, 200, 180, 100, 75, 48, 15);
        //Event: 0 (= not pregnant),  1,   2,   3,   4,   5,  6,  7,  8 (< 15)
        EventParser.timeAwareClassAdd(this);
    }

    //Implementation of TimeAwareInterface
    public function timeChange():Boolean {
        var needNext:Boolean = false;
        pregnancy.pregnancyAdvance();
        if (pregnancy.isPregnant) {
            if (emberPregUpdate()) needNext = true;
            if (pregnancy.incubation == 0) {
                emberGivesBirth();
                pregnancy.knockUpForce(); //Clear Pregnancy
                needNext = true;
            }
        }
        //Ember fuck cooldown
        if (player.statusEffectv1(StatusEffects.EmberFuckCooldown) > 0) {
            player.addStatusValue(StatusEffects.EmberFuckCooldown, 1, -1);
            if (player.statusEffectv1(StatusEffects.EmberFuckCooldown) < 1) player.removeStatusEffect(StatusEffects.EmberFuckCooldown);
        }
        //Ember napping
        if (player.hasStatusEffect(StatusEffects.EmberNapping)) {
            player.addStatusValue(StatusEffects.EmberNapping, 1, -1);
            if (player.statusEffectv1(StatusEffects.EmberNapping) <= 0) player.removeStatusEffect(StatusEffects.EmberNapping);
        }
        if (followerEmber() && !player.hasStatusEffect(StatusEffects.EmberNapping)) {
            //Mino cum freakout - PC partly addicted!
            if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 1 && !player.hasPerk(PerkLib.MinotaurCumAddict) && flags[kFLAGS.EMBER_CURRENTLY_FREAKING_ABOUT_MINOCUM] == 0) {
                minotaurJizzFreakout();
                needNext = true;
            }
            //Ember is freaking out about addiction, but PC no longer addicted!
            else if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 0 && flags[kFLAGS.EMBER_CURRENTLY_FREAKING_ABOUT_MINOCUM] == 1) {
                emberGetOverFreakingOutAboutMinoJizz();
                needNext = true;
            }
            //At max lust, count up - if ten hours lusty, ember yells at ya!
            if (player.lust >= player.maxOverLust() && player.gender > 0) {
                flags[kFLAGS.EMBER_LUST_BITCHING_COUNTER]++;
                if (flags[kFLAGS.EMBER_LUST_BITCHING_COUNTER] >= 10) {
                    emberBitchesAtYouAboutLustiness();
                    needNext = true;
                }
            }
            //Reset lust counter if not max lust'ed
            else flags[kFLAGS.EMBER_LUST_BITCHING_COUNTER] = 0;
        }
        if (model.time.hours > 23) {
            if (!player.isPregnant()) flags[kFLAGS.EMBER_BITCHES_ABOUT_PREGNANT_PC] = 0;
            flags[kFLAGS.DRANK_EMBER_BLOOD_TODAY] = 0;
        }
        return needNext;
    }

    public function timeChangeLarge():Boolean {
        if (!player.hasStatusEffect(StatusEffects.EmberNapping) && followerEmber() && !player.hasStatusEffect(StatusEffects.EmberFuckCooldown)) {
            //Ember get's a whiff of fuckscent and knocks up PC!
            if (hasCock() && player.hasVagina() && player.inHeat && player.canGetPregnant() && rand(10) == 0
                || hasVagina() && player.hasCock() && player.inRut && !pregnancy.isPregnant && rand(10) == 0) {
                emberRapesYourHeatness();
                return true;
            }
        }
        return false;
    }

    //End of Interface Implementation

    public function emberAffection(changes:Number = 0):Number {
        flags[kFLAGS.EMBER_AFFECTION] += changes;
        if (flags[kFLAGS.EMBER_AFFECTION] > 100) flags[kFLAGS.EMBER_AFFECTION] = 100;
        else if (flags[kFLAGS.EMBER_AFFECTION] < 0) flags[kFLAGS.EMBER_AFFECTION] = 0;
        return flags[kFLAGS.EMBER_AFFECTION];
    }

    private function emberCorruption(changes:Number = 0):Number {
        flags[kFLAGS.EMBER_COR] += changes;
        if (flags[kFLAGS.EMBER_COR] > 100) flags[kFLAGS.EMBER_COR] = 100;
        else if (flags[kFLAGS.EMBER_COR] < -100) flags[kFLAGS.EMBER_COR] = -100;
        return flags[kFLAGS.EMBER_COR];
    }

    override public function followerEmber():Boolean {
        return flags[kFLAGS.EMBER_HATCHED] > 0;

    }

    override public function emberMF(man:String, woman:String):String {
        if (flags[kFLAGS.EMBER_GENDER] == 1) return man;
        else return woman;
    }

    public function emberGroinDesc(cock:String, pussy:String, herm:String = " and "):String {
        var strText:String = "";
        if (hasCock()) strText += cock;
        if (flags[kFLAGS.EMBER_GENDER] == 3) strText += herm;
        if (hasVagina()) strText += pussy;
        return strText;
    }

    private function emberVaginalCapacity():int {
        return 60;
    }

    private function emberAnalCapacity():int {
        return 60;
    }

    public function hasCock():Boolean {
        return flags[kFLAGS.EMBER_GENDER] == 1 || flags[kFLAGS.EMBER_GENDER] == 3;
    }

    public function hasVagina():Boolean {
        return flags[kFLAGS.EMBER_GENDER] == 2 || flags[kFLAGS.EMBER_GENDER] == 3;
    }

    public function emberChildren():int {
        return (flags[kFLAGS.EMBER_CHILDREN_MALES] + flags[kFLAGS.EMBER_CHILDREN_FEMALES] + flags[kFLAGS.EMBER_CHILDREN_HERMS]);
    }

    private function internalDick():Boolean {
        return !flags[kFLAGS.EMBER_ROUNDFACE] || flags[kFLAGS.EMBER_INTERNAL_DICK];
    }

    //Approaching Ember (Z)
    public function emberCampMenu2():void {
        if (!player.hasStatusEffect(StatusEffects.LunaOff) && !player.hasStatusEffect(StatusEffects.LunaWasWarned)
            && (flags[kFLAGS.LUNA_JEALOUSY] > 200 && rand(10) < 4 || flags[kFLAGS.LUNA_JEALOUSY] > 300 && rand(10) < 8))
            mishapsLunaEmber();
        else
            emberCampMenu();
    }

    public function emberCampMenu():void {
        clearOutput();
        outputText(images.showImage("ember-visit-at-camp"));
        //Low Affection:
        if (emberAffection() <= 25) outputText("Ember sighs as you approach, and doesn't even look you in the eye before speaking.  \"<i>What do you want?</i>\"");
        //Moderate Affection:
        else if (emberAffection() <= 75) outputText("Ember fidgets as [ember eir] tail starts to sway from side to side, [ember ey] looks at you and asks, \"<i>What is it?</i>\"");
        else outputText("Ember's eyes light up as you close in on [ember em], and [ember ey] smiles nervously.  \"<i>Y-Yes?</i>\"");
        //OPTIONS HERE
        menu();
        addButton(0, "Appearance", embersAppearance).hint("Examine Ember's appearance.");
        addButton(1, "Talk", talkToEmber).hint("Talk to Ember about some topics.");
        addButton(2, "Drink Blood", bloodForTheBloodGod).hint("Ask Ember if [ember ey]'s willing to give you some of [ember eir] blood to gain powers.");
        if (flags[kFLAGS.EMBER_MILK] > 0 || (player.hasItem(consumables.LACTAID, 1) && flags[kFLAGS.EMBER_AFFECTION] >= 75)) addButton(3, "Drink Milk", getMilkFromEmber).hint("Ask Ember if [ember ey]'s willing to let you drink [ember eir] milk." + (flags[kFLAGS.EMBER_MILK] > 0 ? "" : "\n\nThis will cost you 1 Lactaid each time you want to suckle milk.") + "");
        if ((flags[kFLAGS.EMBER_OVIPOSITION] > 0 || (player.hasItem(consumables.OVIELIX, 1) && flags[kFLAGS.EMBER_AFFECTION] >= 75)) && hasVagina() && !pregnancy.isPregnant) addButton(4, "Get Egg", emberIsAnEggFactory).hint("Ask Ember if [ember ey]'s willing to lay an unfertilized egg for you." + (flags[kFLAGS.EMBER_OVIPOSITION] > 0 ? "" : "\n\nThis will cost you 1 Ovi Elixir each time you want [ember em] to lay an unfertilized egg.") + "");
        addButton(5, "Sex", emberSexMenu).hint("Get into a sex session with Ember.")
            .disableIf(player.lust < 33, "Not aroused enough!");
        addButton(6, "Spar", decideToSparEmbra).hint("Do a quick battle with Ember!")
            .disableIf(flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] < 2, "You need a good sparring ring for that.");
        if (model.time.hours >= 21 || model.time.hours < 5) {
            if (flags[kFLAGS.EMBER_AFFECTION] < 75) addButton(7, "Sleep With?", sleepWithEmber).hint("Try to spend the night with Ember.");
            else addButton(7, "Sleep With", sleepWithEmber).hint("Spend the night with Ember.");
        }
        if (flags[kFLAGS.SLEEP_WITH] == "Ember") addButton(8, "NoSleepWith", noSleepWith);
        addButton(14, "Back", camp.campFollowers);
    }

    private function noSleepWith():void {
        clearOutput();
        outputText("You decide to spend the next night alone and tell this to Ember. She tries to look indifferent, but there's a hint of disappointment in her eyes.")
        flags[kFLAGS.SLEEP_WITH] = "";
        doNext(emberCampMenu);
    }

    //Approach for sex - initial output when selecting [Sex] menu (Z)
    private function emberSexMenu(output:Boolean = true):void {
        if (output) {
            clearOutput();
            outputText("You ogle Ember, checking out the nuances of [ember eir] body.");
            //(Low Affection)
            if (emberAffection() <= 25) outputText("\n\n\"<i>Why are you looking at me like that?</i>\" [ember ey] says, flatly.");
            //(Medium Affection)
            else if (emberAffection() < 75) outputText("\n\n\"<i>What is it?  Is something wrong with my body?</i>\" Ember asks, checking [ember em]self.");
            //(High Affection)
            else outputText("\n\n\"<i>D-don't stare at me like that!</i>\" Ember protests, biting [ember eir] lip.");
            outputText("\n\nYou smile at Ember, admiring the shape of the dragon, and casually mention as much.");
            //Low Affection)
            if (emberAffection() <= 25) outputText("\n\n\"<i>Flattery won't get you any points with me!</i>\" Ember declares.");
            //(Medium Affection)
            else if (emberAffection() < 75) outputText("\n\n\"<i>I don't buy it... you're up to something; I can tell,</i>\" Ember replies.");
            //(High Affection)
            else outputText("\n\n\"<i>Well, stop it!  You're making me...</i>\"  Ember never finishes [ember eir] sentence, flustered with a mixture of arousal and embarrassment.");
            outputText("  ");
            if (hasCock()) {
                outputText(emberMF("His", "Her") + " cock ");
                if (flags[kFLAGS.EMBER_INTERNAL_DICK] == 1 || flags[kFLAGS.EMBER_ROUNDFACE] == 0) outputText("is poking out of [ember eir] slit");
                else outputText("is starting to swell with blood");
                outputText(".  ");
            }
            if (hasVagina()) outputText("You can see tiny rivulets of moisture starting to run down Ember's inner thighs as they rub together, barely hiding her precious treasure from your hungry eyes.  ");
            outputText("Well, [ember ey] is a sexy beast; you ask what naturally comes to mind.");
            //(Lo-rider Affection)
            if (emberAffection() <= 25) outputText("\n\n\"<i>T-this is just a reflex! It has nothing to do with you!</i>\"  You chuckle at Ember's failed attempt to justify [ember eir] growing arousal.");
            //(Medium Affection)
            else if (emberAffection() < 75) outputText("\n\n\"<i>I... I think I can help you with something, if you want.</i>\"");
            //(High Affection)
            else outputText("\n\n\"<i>Depends... what do you have in mind?</i>\"");
        }
        menu();
        if (hasCock()) {
            addButton(1, "Blow Ember", suckEmberCock).hint("Suck Ember's cock and get a taste of [ember eir] cum. " + (flags[kFLAGS.HUNGER_ENABLED] > 0 ? "\n\nAnd get your belly stuffed, of course!" : "") + "");
            addButton(6, "Catch Anal", catchAnal).hint("Ask Ember if [ember ey]'s willing to penetrate your [ass] with that cock of [ember eirs].");
            addButton(11, "Get Penetrated", getPenetratedByEmberLastSexSceneWoooo)
                .hint("Ask Ember if [ember ey]'s willing to penetrate you vaginally with that cock of [ember eirs].")
                .disableIf(!player.hasVagina(), "Req. a vagina!");
        }
        if (hasVagina()) {
            addButton(2, "Eat Her Out", slurpDraggieCunnies).hint("Get a taste of Ember vagina!");
            addButton(7, "Penetrate Her", penetrateEmbrah).hint("Penetrate Ember vaginally!")
                .disableIf(!player.hasCock(), "Req. a cock!");
        }
        addButton(0, "Get Blown", stickDickInKnifeDrawer).hint("Ask Ember if [ember ey]'s willing to suck you off.")
            .disableIf(!player.hasCock(), "Req. a cock!");
        addButton(5, "Pitch Anal", stickItInEmbersButt).hint("Penetrate Ember anally with your cock.")
            .disableIf(!player.hasCock(), "Req. a cock!");
        addButton(10, "Get Eaten Out", getEatenOutByEmbra).hint("Ask Ember if [ember ey]'s willing to get a taste of your vagina.")
            .disableIf(!player.hasVagina(), "Req. a vagina!");
        addButton(3, "LustyFuck", highAffectionEmberLustFuck)
            .disableIf(!player.hasCock() || !(player.hasItem(consumables.L_DRAFT) || player.lib >= 50 || player.minLust() >= 40), "Req. a cock AND high minimum lust / libido / lust draft!")
            .disableIf(emberAffection() < 95, "You don't know her good enough.", "???");
        addButton(14, "Leave", emberCampMenu);
    }

    //Finding the Egg (Z)
    //Triggers randomly on exploration in Swamp
    public function findEmbersEgg():void {
        clearOutput();
        if (flags[kFLAGS.TIMES_FOUND_EMBERS_EGG] == 0) {
            outputText("You spot a cave entrance partially hidden behind mossy vegetation and decide to investigate.");
            outputText("\n\nThe cave floor is very damp, and the moss growing along the ground makes it extra slippery.  Unfortunately, squint as you might to see the inside, the almost tractionless ground causes you to lose your balance and you fall back towards the wall.  You try a grab for the solid rock face to steady yourself, but your hands meet only air; the wall dissolves in front of your eyes and you hit the ground with a yelp and a loud thud.");
            outputText("\n\nFortunately, you don't seem to be injured, but your curiosity is piqued... was the wall some kind of illusion?  You look ahead and see tiny glowing mushrooms lighting what is obviously a deliberately crafted path.  Since the rest of the cave is too dark, you decide to continue along this path.");
            outputText("\n\nYou press on until you come to a rather large and well lit chamber.  The walls appear to have been carved, not cut, and a small shrine sits in the center to house what looks like a large egg...  A small, tattered book sits beside it; perhaps it might contain the answer?  You open to the first page and begin reading.");
            outputText("\n\n\"<i>Dear reader; what stands in front of you is an egg containing my child - our last hope.  This room was safeguarded with a powerful ward, designed to repel any race of Mareth save our own, and any creature attempting to breach this room but failing would have been cursed.</i>\"");
            outputText("\n\n\"<i>Only a fellow dragon could have made it past the ward, and even among dragons, not all would have been able to see through the illusion.  For that, you have our compliments.</i>\"");
            outputText("\n\nYour eyes widen in surprise; dragons!?  They exist in this world?  Immediately your mind travels back to childhood tales of mighty knights slaying fierce dragons...  If this \"<i>dragon</i>\" is anything like the ones in the stories, it would be very bad to allow it to hatch... On the other hand, the journal claims it is a \"<i>last hope</i>\".");
            outputText("\n\n\"<i>We were obliterated.  Some strange magic started turning our young and unborn into deformed, distorted little monsters we called Kobolds; they were weak, and in our pride we underestimated them.\n\nThey have the ability to quickly multiply their numbers, and while we could easily dispatch a few, we were no match for an army of them.\n\nOurs is a small group that managed to escape...  This egg, our child, is the last healthy dragon baby to be born after the incident.  We left our child here, protected from the evils outside, as our last desperate attempt to ensure our species' survival.\n\nFollowing this letter are all the notes on how my child was encased in this egg and how you may free her... or him.  Please take care of my child; our fate lies in your hands.</i>\"");
            outputText("\n\nTrue to the letter, you see various notes on how the egg was created and how it may be hatched. You will need to perform a small ritual in order to awaken it from its magical stasis, as well as to 'share your essence' to make it hatch. The research notes state that by absorbing your essence, the life inside the egg will hatch into a suitable mate...");
            outputText("\n\nStill, should you even consider taking this egg with you?");
        } else {
            //Finding the Egg - repeat (Z)
            outputText("You spot a familiar cave partially hidden behind the mossy vegetation and decide to confirm your suspicion.");
            outputText("\n\nTrue enough, after a short trek through familiar tunnels you find yourself once again standing before the alleged 'dragon egg'.");
        }
        flags[kFLAGS.TIMES_FOUND_EMBERS_EGG]++;
        menu();
        addButton(0, "Take It", takeEmbersEggHomeInADoggieBag).hint("Take the egg home with you. \n\nYou'll be able to hatch the egg eventually.");
        addButton(1, "Destroy It", destroyBabyEmberYouMonster).hint("Destroy the egg. (And optionally eat the egg) \n\nWhy would you do that?");
        addButton(4, "Leave", leaveEmbersAssOutToDry);
    }

    //[=Leave=] (Z)
    private function leaveEmbersAssOutToDry():void {
        clearOutput();
        outputText("You can't decide what to do right now, so you leave the egg where it is and return to your camp.");
        //(You can restart this quest by randomly encountering this chamber again. It continues to reappear until you either Destroy or Take the egg.)
        endEncounter();
    }

    //[=Destroy it=] (Z)
    private function destroyBabyEmberYouMonster():void {
        clearOutput();
        outputText("Raising your [weapon], you rain down blow after blow upon the egg.  The shell is freakishly tough, taking a lot of punishment before it shatters apart to spill a wave of egg white onto your [feet]; a great pulpy mass of weirdly bluish-red yolk remains in the broken shell.");
        outputText("\n\nYou have sealed the fate of an entire species... you feel guilty, but this was for the best.  There was no way of knowing what this dragon could do once it hatched.");
        outputText("\n\nWith nothing else in the cave, you prepare to leave, but find yourself stopped by a sudden thought.  The egg yolk, though raw, looks strangely appetizing...");
        flags[kFLAGS.EGG_BROKEN] = 1;
        //[Eat][Leave]
        simpleChoices("Eat It", eatEmbersYolkLikeAnEvenBiggerDick, "", null, "", null, "", null, "Leave", explorer.done);
    }

    //[=Eat=]
    private function eatEmbersYolkLikeAnEvenBiggerDick():void {
        clearOutput();
        outputText("Unsure of where the impulse comes from, but uncaring, you crouch over the ruined shell of your 'kill' and begin messily scooping handfuls of yolk into your mouth.");
        outputText("\n\nThe taste is incredible; a tinge of bitterness, but rich and velvety, sliding down your throat like the most savory of delicacies.  Each scoop you eat fills you with energy and power, you can almost feel yourself growing stronger.");
        player.refillHunger(100);
        outputText("\n\nBefore you realize it, you have eaten as much of it as is possible to eat and the empty halves of the egg lie before you - as you watch, the leftover albumen wicks into the porous shell, disappearing completely.  You pick up the shell, looking at the underside, but not a drop of fluid seeps out.  Interesting...");
        outputText("\n\nFeeling sated, you get up and prepare to return to your camp, but on a whim, you take the shell with you as a souvenir.");
        outputText("\n\n(<b>Gained Key Item: Dragon Eggshell</b>)");
        player.createKeyItem("Dragon Eggshell", 0, 0, 0, 0);
        //(+5-10 to strength, toughness, and speed.)
        //(+20 Corruption)
        //(also slimefeed!)
        dynStats("str", 5 + rand(5), "tou", 5 + rand(5), "int", 5 + rand(5), "cor", 20);
        player.slimeFeed();
        endEncounter();
    }


    //[Yes]
    public function getSomeStuff():void {
        clearOutput();
        outputText("Your mouth tightens in consternation, and you pull out the shell of the so-called 'dragon egg', passing it over and asking if she can use it.");
        outputText("\n\n\"<i>What is this?  An egg?  Eggs aren't much good for armor, cutie, no matter how big.  One good blow and POW!</i>\"  To demonstrate, she raises her hand, then strikes the shell with the blade of her palm - and pulls it away, smarting.  \"<i>My gods!  It's so hard!  Ok... maybe we can do this.</i>\"");
        outputText("\n\nShe turns the cracked shell over in her hands, then puts it into the fire and whacks at it with a pair of tongs, attempting to bend and break it.  \"<i>Ist not softening.  Tch, cannot make armor if I cannot shape it.  Vell, it iz nice und curved, ja?  It vill make a decent small-shield to deflect blows, if I sand ze edges down und fit some straps.</i>\"");
        outputText("\n\nYou tell the armorsmith that a shield will be fine, and she sets to work smoothing the edges.  After nearly an hour of idle browsing through armor you don't really care about, she attracts your attention.  \"<i>It's done, cutie.  Payment up front.</i>\"");
        outputText("\n\nHanding over the gems, you take the white shell back from her; true to her word, she's rounded it into a proper shield and fitted adjustable straps to the back.  Its hardness is indisputable, but you can only wonder if its liquid absorption properties are still intact.  Worth a test, right?\n\n");
        //this is where the Dragonshell Shield lives, git you one!
        player.gems -= 200;
        statScreenRefresh();
        player.removeKeyItem("Dragon Eggshell");
        inventory.takeItem(shields.DRGNSHL, new YvonneArmorShop().enter);
    }

    private function takeEmbersEggHomeInADoggieBag():void {
        clearOutput();
        outputText("You decide to take the egg, figuring that perhaps this dragon could aid you in your quest.");
        //(If player is shorter than 7 feet)
        if (player.tallness < 84) outputText("  Lifting it isn't as much of a problem as you thought; it's surprisingly light.  It is, however, very big and very awkward to carry.");
        else outputText("  Between the egg's surprising lightness, and your own size and wide arms, you can easily carry the egg.");
        outputText("\n\nYou make it back to the strange corridor entrance... but when you attempt to cross over into the cave's opening, you feel the egg bump into something.  Alarmed, you quickly scan its surface.");
        outputText("\n\nThankfully, it seems to be intact; you put the egg down and try to roll it gently past the open cave mouth.  It bumps something again, something invisible. Then you recall the books' mention of some sort of ward protecting the egg; when you try to touch and feel the invisible ward however, your hand goes right through.  In fact, you can cross this 'ward' easily, as if it weren't even there...  However, if you attempt to carry the egg, there is a solid barrier preventing it from passing through.");
        outputText("\n\nVexed, you decide to look around the egg chamber for another way out.");

        //(if PC has >= 50 int)
        if (player.inte >= 50) {
            outputText("\n\nYou feel electricity run down your spine as you pass by a far wall in the back of the cave; inspecting the wall, you quickly locate an odd rock.  When you pick it up, you realize it has some sort of inscription drawn all over the underside; figuring it's probably the source of the ward, you fling the rock at the far wall, shattering it into many pieces.");
            outputText("\n\nYou feel a small pulse of energy run through the chamber and into the corridor.  Running towards the entrance; you discover that you can easily remove the egg.  It begins to glow softly as you remove it from the cave; at first you take it for a trick of the light, but remember there isn't any in this damned dark swamp!");
        }
        //(else if PC has >= 90 str)
        else if (player.str >= 90) {
            outputText("\n\nou look around over and over and over... but no matter how much you look, you don't see anything at all that could even resemble some kind of magic rune, or activation button, or anything that could disable the ward.  You groan in frustration.");
            outputText("\n\nWell, if there is no way out all you have to do is make one, right?  Using your immense strength, you break off a sturdy-looking stalagmite and begin striking the walls in hopes of breaking through or disabling the barrier.");
            outputText("\n\nIt takes a lot longer than you originally anticipated, but sure enough, soon you feel a small pulse of energy run through the chamber and into the corridor.  Running towards the entrance; you discover that you can easily remove the egg.  It begins to glow softly as you remove it from the cave; at first you take it for a trick of the light, but remember there isn't any in this damned dark swamp!");
        } else {
            outputText("\n\nYou look around over and over and over... but no matter how much you look you don't see anything at all that could even resemble some kind of magic rune, or activation button, or anything that could disable the ward.  You groan in frustration.");
            outputText("\n\nIt looks like you will have to leave the egg for now until you're better versed in magical methods... or strong enough to knock down a mountain!  You roll it back down the corridor into its shrine to prevent its being seen from the cave entrance.");
            //Same as taking the Leave option. Must find the egg again to take it.
            endEncounter();
            return;
        }
        outputText("\n\n(<b>You have now begun the Mysterious Egg quest.  The Mysterious Egg is added to the <i>Items</i> at the Camp.</b>)");
        //set flags
        player.createKeyItem("Dragon Egg", 0, 0, 0, 0);
        flags[kFLAGS.TOOK_EMBER_EGG] = 1;
        flags[kFLAGS.EMBER_COR] = 0;
        endEncounter();
    }


    //Modified Camp Description (Z)
    public function emberCampDesc():void {
        //Iz Ember an egg?
        if (flags[kFLAGS.EMBER_HATCHED] == 0) outputText("\nThat mysterious egg that you brought back to the camp is sitting in the crude nest you made.\n");
        //NOT AN EGG! HAHA!
        else {
            if (player.statusEffectv1(StatusEffects.CampSparingNpcsTimers1) > 0) outputText("Ember doesn't seem to be around [ember eir] excavated den... [ember ey]'s probably training somewhere and will be back soon.\n\n");
            else {
                var choice:Number = rand(3);
                if (choice == 0) outputText("Ember is lying in front of [ember eir] excavated den, watching the camp and resting.  Every once in a while [ember eir] eyes dart in your direction, before [ember ey] quickly looks away.\n\n");
                else if (choice == 1) outputText("Ember doesn't seem to be around [ember eir] excavated den... it doesn't take long before Ember lands in front of it and then takes off again, apparently occupied with darting around in the sky for fun.\n\n");
                else outputText("Ember appears to be fighting to stay awake; sometimes [ember ey] falls into a doze, but quickly snaps back to consciousness.\n\n");
            }
        }
    }

    //How Ember should hatch
    //General Hatching Rules
    //Can only be hatched by using in masturbation.
    //Must use in masturbation or use items on egg at least five times before it can be hatched.
    //This means that even if 5 items are used on the egg, it won't hatch until the PC masturbates on it at least once.

    //Items that change traits
    //Lactaid sets EmberMilk to 1.
    //Ovielixir sets EmberOviposition to 1.
    //Hair Ext. Serum increments EmberHair from 0 to 1, then to 2.
    //Blood is always presented as an option, PC will share their own blood with the egg setting EmberMonstergirl to 1. (Makes Ember more human looking.)

    //How to decide Ember's sex
    //Incubi's Draft, changes Egg's sex to male if its herm or has no sex, herm if it was female.
    //Succubi's Milk, changes Egg's sex to female if its herm or has no sex, herm if it was male.
    //If the PC uses the Sexless Egg in masturbation, sex is set to opposite PC's sex for male/female PCs and the same sex for herm PCs.

    //Egg's shell color changes based on sex:
    //White: Unsexed (initial color).
    //Blue:  Male
    //Pink:  Female
    //Purple: Herm

    //How to decide which Ember should hatch.

    //For now only Tainted Ember has been written so there's no need to track, but later more types of Ember may be hatched.
    //if Egg's Corruption is:
    //0-25	= Pure Ember is Born
    //26-74	= Tainted Ember is Born
    //75-100	= Corrupted Ember is Born

    //if EmberType has been altered, forget corruption. Hybrid forms have no corruption variants.

    //General Egg Interaction (Z)
    public function emberEggInteraction():void {
        clearOutput();
        outputText("You approach the egg you found in that illusion-concealed cave. Though the light continues to pulse with its heartbeat overtones, it still just sits there, doing nothing.");
        outputText("  As you observe the egg, it glows with bright, gaudy pulses and you're overcome with a sense of arrogance and strength.  You feel somehow as if you could do anything, as if you were superior to everything, and no one could dare say otherwise.");
        if (player.lust >= 33 && (flags[kFLAGS.EMBER_EGG_FLUID_COUNT] < 5 || flags[kFLAGS.EMBER_JACKED_ON] == 0)) {
            outputText("\n\nYou stare at the egg's rhythmic pulsations.  As you do, though, you realize the pattern of the pulses is starting to change.  It's becoming erratic, as if the egg were excited.  For some reason, you suddenly feel aroused, and the egg looks strangely inviting...");
            outputText("\n\nYou reach out and have the distinct impression of breathing... no, not breathing... panting.  It feels like the egg is panting, eager for something, and you find its eagerness infectious.  Placing a hand on the shell, you lean in and press your cheek to the surface, listening; the egg feels warm and throbs as it pulses... almost like a lover's chest just before you consummate your feelings for each other.  You have the strangest urge to do just that with this mysterious egg...");
            //(additionally to above, if the egg is about to hatch)
            if (flags[kFLAGS.EMBER_EGG_FLUID_COUNT] == 4) {
                outputText("\n\nA feeling of exasperation fills you as well, as if you were almost finished achieving something, but lacked the last step necessary to complete it.");
            }
            doYesNo(masturbateOntoAnEgg, dontEggFap);
            //(Use the appropriate Egg Masturbation scene.)
            return;
        }
        //(If player meets no other requirements)
        else {
            outputText("\n\nYou stare at the egg's pulsations as the rhythm shifts slightly.  You feel a tinge of excitement, a distant expectation not your own.  Though curious about what could be inside, you decide nothing more can be done for now.");
        }
        eggDescribe();
        eggMenu();

    }

    private function eggDescribe():void {
        var genderColor:Array = ["white", "blue", "pink", "lavender"];
        outputText("\nThe egg has a " +genderColor[flags[kFLAGS.EMBER_GENDER]]+ " tone");
        if (flags[kFLAGS.EMBER_HAIR] > 0) outputText((flags[kFLAGS.EMBER_HAIR] == 1? " with a little":" covered in a dense")+ " tiger-stripe pattern from the hair extension serum")
        if (flags[kFLAGS.EMBER_OVIPOSITION] == 1) outputText(", small green splotches from the ovielixer");
        if (flags[kFLAGS.EMBER_MILK] == 1) outputText(", and a yellow, veiny pattern from the lactaid");
        outputText(".")
    }

    private function eggMenu():void {
        var itemFuns:Array = [
            [consumables.INCUBID, curry(useIncubusDraftOnEmber, false)],
            [consumables.P_DRAFT, curry(useIncubusDraftOnEmber, true)],
            [consumables.SUCMILK, curry(useSuccubiMilkOnEmber, false)],
            [consumables.P_S_MLK, curry(useSuccubiMilkOnEmber, true)],
            [consumables.EXTSERM, hairExtensionSerum],
            [consumables.OVIELIX, useOviElixerOnEmber],
            [consumables.LACTAID, useLactaidOnEmber],
        ];
        menu();
        if (flags[kFLAGS.EMBER_EGG_FLUID_COUNT] >= 5 && flags[kFLAGS.EMBER_JACKED_ON] > 0 && flags[kFLAGS.EMBER_GENDER] > 0) {
            outputText("\n\n<b>The egg is ready to be hatched - if you're just as ready.</b>");
            addButton(0, "Hatch", hatchZeMuzzles).disableIf(player.lust < 33, "Not aroused enough!");
        } else addButton(0, "Masturbate", masturbateOntoAnEgg).disableIf(player.lust < 33, "Not aroused enough!");
        addButton(1, "Blood", giveEmberBludSausages);
        var btn:int = 5;
        for each (var itemFun:Array in itemFuns)
            addButton(btn++, itemFun[0].shortName, itemFun[1]).disableIf(!player.hasItem(itemFun[0]), "You don't have any!");
        addButton(14, "Back", leaveWithoutUsingAnEmberItem);
    }

    //[= No =]
    private function dontEggFap():void {
        var items:Array = [
            consumables.INCUBID,
            consumables.P_DRAFT,
            consumables.SUCMILK,
            consumables.P_S_MLK,
            consumables.EXTSERM,
            consumables.OVIELIX,
            consumables.LACTAID,
        ];
        clearOutput();
        outputText("Shaking your head, confused and startled by these strange impulses, you step away for a moment. Once away from the egg, its pattern of pulsations returns to normal and you feel the urges disappear.");
        outputText("\n\nAs you come closer, the egg's rhythm suddenly changes as if it were excited by something - something that you have brought near it. You start fishing through your pockets, holding up the various items you have; ");
        outputText("it doesn't react to anything you have at the moment.");
        var itemGood:Boolean = false;
        for each (var item:ItemType in items)
            if (player.hasItem(item))
                itemGood = true;
        if (itemGood) outputText("it doesn't react to some, while others make its flashes quicken.  These you set aside.");
        else outputText("it doesn't react to anything you have at the moment.");
        outputText("  When you've finished testing the contents of your pouches, you look at the items the egg has selected.  As you rest your hand on the egg and consider your choices, it begins to excite once more, alarming you.  You pull away and it calms down... the egg considers <b>you</b> an item as well, apparently!");
        eggMenu();
    }

    //Leave Without Using Item (Z)
    private function leaveWithoutUsingAnEmberItem():void {
        clearOutput();
        outputText("You shake your head; it would probably be best not to tamper with it. Returning the items to your pockets, you leave the egg alone.  As you put them away, the egg's glow slows down dramatically, almost as if it were feeling... disappointment?");
        doNext(inventory.inventoryMenu);
    }

    //Incubus Draft/Purified Incubus Draft (Z)
    private function useIncubusDraftOnEmber(purified:Boolean = false):void {
        clearOutput();
        if (purified) {
            player.consumeItem(consumables.P_DRAFT);
            emberCorruption(-20);
        } else {
            player.consumeItem(consumables.INCUBID);
            emberCorruption(20);
        }
        outputText("Uncorking the vial, you drizzle the slimy off-white fluid onto the pointed cone of the egg.  It oozes slowly across the surface, then seeps through the shell, leaving not a drop of moisture.");
        if (flags[kFLAGS.EMBER_GENDER] == 3 || flags[kFLAGS.EMBER_GENDER] == 0) {
            outputText("  The egg's shell slowly changes to a soft, pastel blue.");
            flags[kFLAGS.EMBER_GENDER] = 1;
        } else if (flags[kFLAGS.EMBER_GENDER] == 2) {
            outputText("   The egg's shell slowly changes to a lavender hue.");
            flags[kFLAGS.EMBER_GENDER] = 3;
        }
        flags[kFLAGS.EMBER_EGG_FLUID_COUNT]++;
        doNext(playerMenu);
    }

    //Succubi Milk/Purified Succubi Milk (Z)
    private function useSuccubiMilkOnEmber(purified:Boolean = false):void {
        clearOutput();
        if (purified) {
            player.consumeItem(consumables.P_S_MLK);
            emberCorruption(-20);
        } else {
            player.consumeItem(consumables.SUCMILK);
            emberCorruption(20);
        }
        outputText("Popping the cap off of the milk bottle, you pour the contents onto the egg - the porous shell soaks up the milk as fast as you dump it, spilling not a drop.");
        //(If Unsexed or Herm:
        if (flags[kFLAGS.EMBER_GENDER] == 3 || flags[kFLAGS.EMBER_GENDER] == 0) {
            outputText("  The egg's shell slowly changes to a muted pink color.");
            flags[kFLAGS.EMBER_GENDER] = 2;
        }
        //If Male:
        else if (flags[kFLAGS.EMBER_GENDER] == 1) {
            outputText("  The egg's shell slowly changes to a lavender hue.");
            flags[kFLAGS.EMBER_GENDER] = 3;
        }
        flags[kFLAGS.EMBER_EGG_FLUID_COUNT]++;
        doNext(playerMenu);
    }

    //Ovi Elixir (Z)
    private function useOviElixerOnEmber():void {
        clearOutput();
        player.consumeItem(consumables.OVIELIX);
        //max uses 1
        outputText("Uncorking the crystalline bottle, you pour the strange green liquid inside onto the egg, briefly wondering what on earth it could want with this stuff, before catching your fallacy.  It's an egg, right?  It can't want things...  The fluid spills all over the shell, coating it, and then seeps inside, leaving the egg's previously pale surface marked with small green splotches.");
        flags[kFLAGS.EMBER_OVIPOSITION] = 1;
        flags[kFLAGS.EMBER_EGG_FLUID_COUNT]++;
        doNext(playerMenu);
    }

    //Lactaid (Z)
    private function useLactaidOnEmber():void {
        clearOutput();
        player.consumeItem(consumables.LACTAID);
        //max uses 1
        outputText("Feeling a little bemused, you pour the creamy fluid onto the egg.  It is absorbed through the shell, and a spiderwork of creamy yellow vein-like markings suddenly forms on the shell's surface.");
        flags[kFLAGS.EMBER_MILK] = 1;
        flags[kFLAGS.EMBER_EGG_FLUID_COUNT]++;
        doNext(playerMenu);
    }

    //Hair Extension Serum (Z)
    private function hairExtensionSerum():void {
        clearOutput();
        player.consumeItem(consumables.EXTSERM);
        //max uses 2
        outputText("Wondering at your motivations, you pour the goblin gunk onto the egg.  Most rolls harmlessly off of the shell, leaving you annoyed at the waste... until you see ");
        if (flags[kFLAGS.EMBER_HAIR] == 0) {
            outputText("a narrow tiger-stripe pattern suddenly develop");
            flags[kFLAGS.EMBER_HAIR] = 1;
        } else {
            outputText("the tiger-stripes multiply");
            flags[kFLAGS.EMBER_HAIR] = 2;
        }
        outputText(" on the egg.");
        flags[kFLAGS.EMBER_EGG_FLUID_COUNT]++;
        doNext(playerMenu);
    }

    //Your Blood (Z)
    private function giveEmberBludSausages():void {
        clearOutput();
        //max uses 2
        outputText("Examining your hand and the egg's reaction to it, you wonder if this is what the book meant by \"<i>sharing your essence</i>\".  Could be worth trying.  Wincing in pain as you bite the skin on your thumb, you smear the bloody digit along the surface of the egg, marking its exterior in crimson.  Shortly thereafter the blood is absorbed, leaving only a stain.  You wait expectantly for something else to happen");
        //[(0 prior),
        if (flags[kFLAGS.EMBER_ROUNDFACE] == 0) {
            outputText(" but the egg just glows its excitement, as if it wanted still more.");
            flags[kFLAGS.EMBER_INTERNAL_DICK] = 1;
        } else {
            outputText(", but nothing does.  How disappointing.");
            flags[kFLAGS.EMBER_INTERNAL_DICK] = 0;
        }
        player.takePhysDamage(1);
        flags[kFLAGS.EMBER_ROUNDFACE] = 1;
        //(Token HP Loss, can't drop below 1 HP.)
        player.takePhysDamage(10);
        flags[kFLAGS.EMBER_EGG_FLUID_COUNT]++;
        doNext(playerMenu);
    }

    //Masturbate Onto the Egg (Z)
    //Genderless Version (Z)
    private function masturbateOntoAnEgg():void {
        clearOutput();
        if (player.gender == 0) {
            outputText("The light pulses decrease in speed as you disrobe and expose your bare crotch, leaving you disappointed after summoning your perversity to bring you this far.  You feel as if you've let it down somehow...  This is confusing!  You decide to go away and deal with this fickle egg another time.");
            endEncounter();
            return;
        }
        //Nothing changes. PC can go do something else, lose no time.
        //Male Version (Z)
        if (player.gender == 1) {
            outputText("The light of the egg pulses rapidly, throwing strange illumination and shadow over your form as you hastily peel off your [armor], too far gone to recognize the absurdity.  Your heart is racing so fast with excitement, lust, anticipation... it actually matches the tempo of the pulses from the egg, when you care to notice.");
            outputText("\n\nGrabbing your [cock] in your hands, you stand in front of the egg, ");
            if (player.cockTotal() <= 2) outputText("pumping vigorously.");
            else outputText("wrangling all your shafts together into one awkward bouquet of male organs and furiously stroking and squeezing them as best you can manage");
            outputText(".  The egg's pulsations lure you on, coaxing you to squeeze, pull, thrust, and massage " + sMultiCockDesc() + " as best you can.  Harder and faster you go, feeling the churning ache from deep inside you.  Finally, with a cry of release, you unleash a ");
            if (player.cumQ() < 100) outputText("trickle");
            else if (player.cumQ() <= 500) outputText("stream");
            else if (player.cumQ() <= 1000) outputText("gout");
            else outputText("wave");
            outputText(" of cum onto the egg.");
            outputText("\n\nPanting, you stare at what you have unleashed.  Before your eyes, the pulsations come with incredible rapidity as your sexual fluid literally seeps into the egg's shell.  Then, when every drop has been drunk, the light resumes its normal rhythm.");
            //(If the egg has no sex)
            if (flags[kFLAGS.EMBER_GENDER] == 0) {
                outputText("\n\nThe egg's shell changes color, from white to muted pink.");
                flags[kFLAGS.EMBER_GENDER] = 2;
            }
            outputText("\n\nYou look at the egg's surface in amazement and examine it for any trace of cum; when you touch the shell, you feel a strange feeling emanate from the egg; a feeling of satisfaction and fulfillment.  Whatever life-force exists inside that egg may have been strengthened by your... contribution.  You can't help but wonder what the creature inside is.");
        }
        //Female Version (Z)
        else if (player.gender == 2) {
            outputText("The light of the egg pulses rapidly, throwing strange illumination and shadow over your form as you hastily peel off your [armor], too far gone to recognize the absurdity.  Your heart is racing so fast with excitement, lust, anticipation... it actually matches the tempo of the pulses from the egg, when you care to notice.");
            outputText("\n\nUnthinkingly, you walk up the egg; your [vagina] burns to be used.  Wrapping your arms around it and squatting down, you begin to rub your crotch against its warm, hard surface.  The texture is unlike anything you've used before, and you moan with pleasure as your juices begin to flow, slicking the eggshell.  Harder you press against it, grinding into the unyielding surface, up and down, faster and faster.  The sensation of the shell scraping against your needy netherlips only fills you with excitement; this is like no toy you've ever used before.  Briefly you think that may be because it's no toy at all, but the thought evaporates as you make your next stroke.  Harder and faster you buck and writhe, screaming your excitement and delight until, finally, your [vagina] spasms and a ");
            if (player.wetness() <= 3) outputText("few drops");
            else if (player.wetness() < 5) outputText("squirt");
            else outputText("torrent");
            outputText(" of girlcum jumps from your pussy onto the egg.");
            outputText("\n\nReleasing its surface and panting with the exertion, you step back, your legs wobbly for a few moments.  You stare at what you have unleashed.  Before your eyes, the pulsations come with incredible rapidity as your sexual fluid literally seeps into the egg's shell.  Then, when every drop has been drunk, the light resumes its normal rhythm.");
            //(If the egg has no sex)
            if (flags[kFLAGS.EMBER_GENDER] == 0) {
                flags[kFLAGS.EMBER_GENDER] = 1;
                outputText("\n\nYou stare in curiosity as the egg's shell changes color, from white to pale blue.");
            }
            outputText("\n\nYou look at the egg's surface in amazement and examine it for any trace of cum; when you touch the shell, you feel a strange feeling emanate from the egg; a feeling of satisfaction and fulfillment.  Whatever life-force exists inside that egg may have been strengthened by your... contribution.  You can't help but wonder what the creature inside is.");
        } else {
            //Herm Version (Z)
            outputText("The light of the egg pulses rapidly, throwing strange illumination and shadow over your form as you hastily peel off your [armor], too far gone to recognize the absurdity.  Your heart is racing so fast with excitement, lust, anticipation... it actually matches the tempo of the pulses from the egg, when you care to notice.");
            outputText("\n\nTormented by the need in both your [cocks] and your [vagina], you awkwardly straddle the egg's upper surface, allowing you to grind your netherlips against its shell and stroke [eachCock] at the same time.  It is an awkward, herky-jerky act, struggling to avoid falling off... but the sensation so makes up for it.  Your [vagina] slides and grinds against the egg's hard, unyielding shell as your hand tugs and pulls ");
            if (player.cockTotal() == 1) outputText("your [cock]");
            else outputText("as many of your cocks as you can manage to grab without falling off");
            outputText(".  Finally, relentlessly, inexorably, you cum, spraying your semen into the air to spatter back onto the egg, mixing with the girlish juices from your netherlips to soak into the egg's surface, leaving it slick with your mixed sexual fluids.");
            outputText("\n\nIt's no wonder that you finally lose your battle and slip off, landing hard on your back.  You lay there, gasping for air, and are only just starting to breathe normally again when you see what is happening to the egg.  Before your eyes, the pulsations come with incredible rapidity as your sexual fluid literally seeps into the egg's shell.  Then, when every drop has been drunk, the light resumes its normal rhythm.");
            //(If the egg has no sex)
            if (flags[kFLAGS.EMBER_GENDER] == 0) {
                flags[kFLAGS.EMBER_GENDER] = 3;
                outputText("\n\nYou stare as the egg's shell changes color, from white to lavender.");
            }
            outputText("\n\nYou look at the egg's surface in amazement and examine it for any trace of cum; when you touch the shell, you feel a strange feeling emanate from the egg; a feeling of satisfaction and fulfillment.  Whatever life-force exists inside that egg may have been strengthened by your... contribution.  You can't help but wonder what the creature inside is.");
        }
        //(If egg has been fed at least once but not enough)
        if (flags[kFLAGS.EMBER_EGG_FLUID_COUNT] < 5) {
            outputText("\n\nYou note the egg emanates a feeling of greater satisfaction than before, but still not enough. Maybe it will hatch if you feed it more?");
        }
        player.orgasm();
        dynStats("sen", -1);
        //MAKE SURE EMBER HAS BEEN JACKED ON FLAG IS SET TO TRUE
        flags[kFLAGS.EMBER_JACKED_ON] = 1;
        //INCREMENT EMBER FEEDINZ
        flags[kFLAGS.EMBER_EGG_FLUID_COUNT]++;
        endEncounter();
    }

    //HATCH DAT BITCH
    private function hatchZeMuzzles():void {
        clearOutput();
        outputText("Resting bonelessly on the ground and re-examining the motivations that led up to cumming on the strange egg, you are startled when it shines brilliantly.  Then just as suddenly, it goes dark.  Unnerved, you creep over to your erstwhile sextoy to examine it.  As you lean in, a very slight trembling manifests itself in the egg.  Cracking, breaking noises fill the air as tiny fractures begin to show across the egg's surface.  Warned just in time by them, you turn your face away and cover your head as the shell erupts into a cloud of tiny fragments!  As you huddle against the storm of eggshell shards, you hear a loud roar.");
        outputText("\n\nLifting your head, you find the egg gone; in its place is an unfamiliar figure wrapped in thin wisps of ");
        if (flags[kFLAGS.EMBER_GENDER] == 0) outputText("white ");
        else if (flags[kFLAGS.EMBER_GENDER] == 1) outputText("blue ");
        else if (flags[kFLAGS.EMBER_GENDER] == 2) outputText("pink ");
        else outputText("purple ");
        outputText("dust.");
        //FURRAH
        if (flags[kFLAGS.EMBER_ROUNDFACE] == 0) {
            //Male Anthro (Z)
            if (flags[kFLAGS.EMBER_GENDER] == 1) {
                outputText("\n\nIt's huge, standing 7 feet tall at the very least.  Its build is lean and slender, with powerful arms and legs that end in reptilian claws, complete with splay-toed feet capped by menacing talons.");
                outputText("\n\nLeathery reptilian wings grow from its back, and the creature reveals their impressive span as it tests and stretches them.  The wings are comprised of taut, thin membranes; scaly flesh stretched between prominent bone struts.  A reptilian muzzle replete with sharp teeth fit for a predator graces the world, and a large ebony horn curves around and forward from either temple.");
                outputText("\n\nA long tongue, long as a whip, slips out from within its jaws to lick its clawed hands and then vanishes back into its mouth with lightning speed.  Prideful, fierce eyes stare at you, with slit pupils and burning orange irises that glitter and shine even in the darkness.");
                outputText("\n\nThe creature is covered from head to toe in prominent, shield-shaped scales.  Its dorsal scales are silver and reflect light, while its underbelly is a golden color, giving it a regal appearance.");
                //(If Ember lactates)
                if (flags[kFLAGS.EMBER_MILK] > 0) outputText("\n\nYour eyes set upon its chest, where perky, dribbling nipples jut from the breasts resting there.  You size the creature as roughly an F-cup.");
                //(Otherwise)
                else outputText("\n\nYour eyes set upon its chest, where perky nipples jut from between small, aureate ventral scales.");
                //[(libido check)
                if (player.lib >= 50) outputText("\n\nUnthinkingly, your eyes wander next to");
                else outputText("\n\nSurreptitiously, you sneak a peek at");
                outputText(" the monster's crotch; there, a deceptively small slit in the flesh suddenly disgorges a 16-inch penis unlike anything you've ever seen before, bearing a rounded, elongated head and a series of ridges that give it an almost segmented look.  A pair of apple-sized balls drop into place under it.  He is most definitely male");
                if (flags[kFLAGS.EMBER_MILK] > 0) outputText(", drooling nipples notwithstanding");
                outputText(".");
            }
            //Female Anthro (Z)
            else if (flags[kFLAGS.EMBER_GENDER] == 2) {
                outputText("\n\nIt's huge, standing 7 feet tall at the very least.  Its build is lean and slender, with powerful arms and legs that end in reptilian claws, complete with splay-toed feet capped by menacing talons.");
                outputText("\n\nLeathery reptilian wings grow from its back, and the creature reveals their impressive span as it tests and stretches them.  The wings are comprised of taut, thin membranes; scaly flesh stretched between prominent bone struts.  A reptilian muzzle replete with sharp teeth fit for a predator graces the world, and a large ebony horn curves around and forward from either temple.");
                outputText("\n\nA long tongue, long as a whip, slips out from within its jaws to lick its clawed hands and then vanishes back into its mouth with lightning speed.  Prideful, fierce eyes stare at you, with slit pupils and burning orange irises that glitter and shine even in the darkness.");
                outputText("\n\nThe creature is covered from head to toe in prominent, shield-shaped scales.  Its dorsal scales are silver and reflect light, while its underbelly is a golden color, giving it a regal appearance.");
                outputText("\n\nYour eyes set upon its chest, where perky nipples jut from the breasts resting there.  You size the creature as roughly an F-cup.");
                //[(libido check)
                if (player.lib >= 50) outputText("\n\nUnthinkingly, your eyes wander to");
                else outputText("\n\nSurreptitiously, you sneak a peek at");
                outputText(" the monster's crotch; there, you see that the fine scales actually separate to reveal a slick-looking pussy.  She's clearly a female, with no noteworthy 'additions' that you can see.");
            }
            //Herm Anthro (Z)
            else {
                outputText("\n\nIt's huge, standing 7 feet tall at the very least.  Its build is lean and slender, with powerful arms and legs that end in reptilian claws, complete with splay-toed feet capped by menacing talons.");
                outputText("\n\nLeathery reptilian wings grow from its back, and the creature reveals their impressive span as it tests and stretches them.  The wings are comprised of taut, thin membranes; scaly flesh stretched between prominent bone struts.  A reptilian muzzle replete with sharp teeth fit for a predator graces the world, and a large ebony horn curves around and forward from either temple.");
                outputText("\n\nA long tongue, long as a whip, slips out from within its jaws to lick its clawed hands and then vanishes back into its mouth with lightning speed.  Prideful, fierce eyes stare at you, with slit pupils and burning orange irises that glitter and shine even in the darkness.");
                outputText("\n\nThe creature is covered from head to toe in prominent, shield-shaped scales.  Its dorsal scales are silver and reflect light, while its underbelly is a golden color, giving it a regal appearance.");
                outputText("\n\nYour eyes set upon its chest, where perky nipples jut from the breasts resting there.  You size the creature as roughly an F-cup.");
                if (player.lib >= 50) outputText("\n\nUnthinkingly, your eyes wander to ");
                else outputText("\n\nSurreptitiously, you sneak a peek at ");
                outputText("the monster's crotch; there, you see the scales part in two places.  The lower opening is unmistakably a pussy; but from the slit just above it suddenly distends a 16-inch penis unlike anything you've ever seen before, bearing a rounded, elongated head and a series of ridges that give it an almost segmented look.  Beneath it, a pair of apple-sized balls fall into place heavily, leaving you no doubt that she is a hermaphrodite.");
            }
        }
        //Boring version
        else {
            //Male Monstergirl (Z)
            if (flags[kFLAGS.EMBER_GENDER] == 1) {
                outputText("\n\nYour first impression is of a humanoid figure, but a closer look reveals some very non-human traits.  While parts of it are covered in olive-hued skin, the rest glints with silvery, reptilian scales.  It stands taller than any human, easily over 7 feet, and even from here you can see huge draconic wings, a pair of long, ebony-black horns, and a lashing, scaled tail.  Reptilian eyes literally glow a fiery orange as they stare warily at you.");
                outputText("\n\nThe figure is masculine in appearance, with the features of a strong, defined musculature.  There is a certain androgyny in his build");
                if (flags[kFLAGS.EMBER_MILK] > 0 || flags[kFLAGS.EMBER_HAIR] > 0) outputText(", complete with ");
                if (flags[kFLAGS.EMBER_MILK] > 0) {
                    outputText("huge breasts, easily F-cups");
                    if (flags[kFLAGS.EMBER_HAIR] > 0) outputText(" and ");
                }
                if (flags[kFLAGS.EMBER_HAIR] > 0) outputText("long, feminine locks of hair");
                outputText(", but his maleness is undeniable.  Especially when you spot ");
                if (flags[kFLAGS.EMBER_INTERNAL_DICK] > 0) outputText("the slit in his pelvis that disgorges a foot and a half-long inhuman penis");
                else outputText("a foot and a half long human penis that sways between his legs");
                outputText(", completed by apple-size nuts held inside a fleshy sack.");
            }
            //Female Monstergirl (Z)
            else if (flags[kFLAGS.EMBER_GENDER] == 2) {
                outputText("\n\nYour first impression is of a humanoid figure, but a closer look reveals some very non-human traits.  While parts of it are covered in olive-hued skin, the rest glints with silvery, reptilian scales.  It stands taller than any human, easily over 7 feet, and even from here you can see huge draconic wings, a pair of long, ebony-black horns, and a lashing reptilian tail. Reptilian eyes literally glow a fiery orange as they stare warily at you.");
                outputText("\n\nThe figure is feminine in appearance, with graceful, well-toned curves.  Her form is delightful, giving her a silhouette that any woman back in Ingnam would kill for; huge, soft breasts adorn her chest.  Down below, you see a taut belly, a handful of rounded butt, and feminine thighs that draw your attention with every move... and in-between those wonderful thighs you see an inviting, human-looking slit; some moisture has gathered, giving it a slick look that just begs for attention.");
            }
            //Herm Monstergirl (Z)
            else {
                outputText("\n\nYour first impression is of a humanoid figure, but a closer look reveals some very non-human traits.  While parts of it are covered in olive-hued skin, the rest glints with silvery, reptilian scales.  It stands taller than any human, easily over 7 feet, and even from here you can see huge draconic wings, a pair of long, ebony-black horns, and a lashing reptilian tail. Reptilian eyes literally glow a fiery orange as they stare warily at you.");
                outputText("\n\nThe figure seems feminine at first glance; beautifully feminine features, a delightfully curvaceous build, and huge breasts atop her chest.  However, looking between her legs reveals a very unladylike extra feature; dangling over a vaginal slit, she has a ");
                if (flags[kFLAGS.EMBER_INTERNAL_DICK] == 0) outputText("huge, human prick");
                else outputText("huge inhuman cock hanging from some kind of internal sheath");
                outputText(" and apple-size nuts held inside a fleshy sack slung under - the ensemble hangs nearly level with her knees.  She... or he? is obviously a hermaphrodite.");
            }
        }
        //Aftermath (Z)
        doNext(meetEmberAftermath);
    }

    //Aftermath (Z)
    private function meetEmberAftermath():void {
        clearOutput();
        outputText("You can only stand there and stare at this strange creature, supposedly a dragon, for what feels like hours.");
        outputText("\n\nIt's the first to break the silence, frowning at you.  \"<i>Who are you?  Where am I?</i>\" it inquires, growling.");
        outputText("\n\nCurious, it speaks your language... might as well consider the ice broken.  You introduce yourself, telling the creature that you helped it hatch from the egg.");
        outputText("\n\nIt relaxes a bit.  \"<i>E-Egg?  Oh, yes.  That.  Since you say you helped me, I guess I should introduce myself...</i>  You wait patiently, but all the creature really does is stare down at the ground, apparently struggling to recall its name.  \"<i>The Last Ember of Hope; that's what my mind tells me.  I assume your kind, like the others, will have trouble with a name longer than one word, so I shall allow you to address me as \'Ember\'.  As you can see, I am...</i>\" it pauses, spreading its arms and wings in a showy flourish.  \"<i>... The last of the great dragons!</i>\"  It waves you off and starts walking away.  \"<i>Now, let's see what sort of place I'll be calling my own... </i>\"");
        outputText("\n\nYou watch the newly hatched dragon, poking its nose into everything that catches its eye, and sigh softly as it starts to burrow into a small elevation in the cracked ground.  Going to be a difficult one, it seems.  Still, it doesn't seem to be some kind of sex-crazed monster like the other weird natives you've met thus far.  Maybe the two of you can help each other?");
        outputText("\n\n(<b>Ember has been gained as a follower! Mysterious Egg quest is now complete.</b>)");
        if (player.hasKeyItem("Radiant shard") >= 0) player.addKeyValue("Radiant shard", 1, +1);
        else player.createKeyItem("Radiant shard", 1, 0, 0, 0);
        outputText("\n\n<b>Before fully settling in your camp as if remembering something Ember pulls a shining shard from her inventory and hand it over to you as a gift. You acquired a Radiant shard!</b>");
        flags[kFLAGS.EMBER_HATCHED] = 1;
        player.removeKeyItem("Dragon Egg");
        endEncounter();
    }

    //Appearance (shows Ember's appearance, always available)
    private function embersAppearance():void {
        clearOutput();
        outputText(images.showImage("ember-examine-appearance"));
        //Anthro Ember's Appearance (Z)
        if (flags[kFLAGS.EMBER_ROUNDFACE] == 0) {
            outputText("Ember is a 7' 3\" tall humanoid dragon, with supple, long limbs and a build that is toned and athletic, with powerful underlying muscles.  [ember Ey] looks strong and imposing, but ");
            if (flags[kFLAGS.EMBER_GENDER] == 1) outputText(" not overly muscled.");
            else outputText(" feminine.");

            //(Male)
            if (flags[kFLAGS.EMBER_GENDER] == 1) {
                outputText("\n\nEmber's body is the perfect picture of a healthy male.  Not underweight or overweight, but with just the perfect amount of fat that, excepting the");
                if (flags[kFLAGS.EMBER_MILK] > 0) outputText(" dribbling breasts,");
                outputText(" snout, wings, and horns, gives him the silhouette of a prince from your village's stories: dashing and handsome.");
            }
            //(Female/Herm)
            else {
                outputText("\n\nEmber's body is a curvy thing, not rough like you'd expect from a reptilian creature, but rounded and almost soft-looking, with a taut belly and a perfect hourglass figure, giving [ember em] the silhouette of an amazon from your village's histories: beautiful but powerful.  Excepting the wings and horns, of course.");
            }
            outputText("\n\nThe dragon scorns clothing and exposes [ember em]self to both you and the elements with equal indifference, claiming [ember eir] scales are all the covering [ember ey] needs... and yet when you admire [ember eir] body, [ember ey] is quick to hide it from your wandering gaze.");
            outputText("\n\n[ember Eir] head is reptilian, with sharp teeth fit for a predator and strong ridges on the underside of the jaw.  At the sides of [ember eir] head are strange, fin-like growths concealing small holes; you presume these to be the dragon equivalent of ears.  Atop [ember eir] head sit a pair of ebony horns that curve backwards elegantly; despite being as tough as steel, their shape is not fit for use in combat, instead it is simply aesthetical, giving Ember a majestic look.  A long tongue occasionally slips out, to lick at [ember eir] jaws and teeth.  Prideful, fierce eyes, with slit pupils and burning orange irises, glitter even in the darkness.");
            //(if Ember has any hair)
            if (flags[kFLAGS.EMBER_HAIR] == 1) {
                if (flags[kFLAGS.EMBER_GENDER] == 1) outputText("  Short ");
                else outputText("  Shoulder-length ");
                outputText("steel-gray hair sprouts from [ember eir] head.  You'd think that a dragon with hair would look weird, but it actually compliments Ember's looks very well.");
            }
            //(if Ember has a level 2 mane)
            else if (flags[kFLAGS.EMBER_HAIR] == 2) {
                outputText("  Tracing [ember eir] spine, a mane of hair grows; starting at the base of [ember eir] neck and continuing down [ember eir] tail, ending on the tip of [ember eir] tail in a small tuft.  It is the same color as the hair on [ember eir] head, but shorter and denser; it grows in a thick vertical strip, maybe two inches wide.  It reminds you vaguely of a horse's mane.");
            }
            outputText("\n\n[ember Eir] back supports a pair of strong, scaly dragon wings, covered in membranous leathery scales.  The muscles are held taut, as though ready to extend and take to the skies at any notice.");

            //(Male)
            if (flags[kFLAGS.EMBER_GENDER] == 1) outputText("\n\nHis hips are normal-looking, not demanding any kind of extra attention.  His butt is taut and firm, lending itself well to balance.");
            //(Female/Herm)
            else outputText("\n\nHer girly hips are as eye-catching as the shapely handful that graces her posterior, giving Ember a graceful strut.  That same delightful butt of hers just begs to be touched, soft enough to jiggle only slightly and yet firm enough to not trouble the dragon's balance.");

            outputText("\n\nA long, scaly, flexible tail lashes behind [ember em], its final third adorned with small bumps that can extend into vicious-looking spikes.  [ember Eir] legs appear humanoid until the feet, where they end in powerful, taloned reptilian claws meant for gripping at the ground.");

            outputText("\n\nEmber is covered from head to toe in shield-shaped scales.  [ember Eir] dorsal scales are silver and reflect the light well, while [ember Eir] underbelly is a rich golden color that stands in stark contrast.  These metallic-colored scales are large and prominent on Ember's back and the exterior of [ember eir] limbs, but, on [ember eir] face, the interior of [ember eir] limbs and the front of [ember eir] body, they are very small and fine, giving them a smooth and silken texture.");

            outputText("  The ");
            if (flags[kFLAGS.EMBER_ROUNDFACE] == 0) outputText("little ");
            outputText("exposed flesh of Ember's body is a light shade of pink; but flushes when [ember ey]'s aroused, drawing your eyes towards [ember eir] most sexual parts.");

            switch (pregnancy.event) {
                case 2:
                    outputText("  At the moment there's a slight pudgyness to her golden belly.");
                    break;
                case 3:
                    outputText("  Her golden belly is a little larger and firmer than usual.");
                    break;
                case 4:
                case 5:
                    outputText("  Her golden belly has grown quite a bit.  Ember often rests her hand on it, especially when she sees you looking at it.");
                    break;
                case 6:
                    outputText("  Her large pregnant belly has forced Ember to change her posture.  It looks like she has a big golden bullseye painted on her stomach.  Ember looks tired but happy.");
                    break;
                case 7:
                    outputText("  Her swollen belly is as large as that of any pregnant woman you can remember from Ingnam and you " + (flags[kFLAGS.EMBER_OVIPOSITION] > 0 ? "can easily make out the egg's outline under her golden skin" : "occasionally see movement as the baby shifts in Ember's womb") + ".");
                    break;
                case 8:
                case 9:
                    outputText("  Ember's golden belly is stretched taut by the large " + (flags[kFLAGS.EMBER_OVIPOSITION] > 0 ? "egg" : "baby") + " in her womb.  You're sure she'll give birth very soon, there just isn't room for the " + (flags[kFLAGS.EMBER_OVIPOSITION] > 0 ? "egg" : "baby") + " to grow any larger.");
                    break;
                default:
            }

            //(Ember breast check)
            outputText("\n\nSituated upon [ember eir] chest are a pair of ");
            if (flags[kFLAGS.EMBER_MILK] > 0 || hasVagina()) outputText("F-cup soft, pillowy breasts");
            else outputText("flat manly pecs");
            outputText(" covered in fine scales excepting [ember eir] areolas; 0.5 inch nipples protrude from the center of the ");
            if (flags[kFLAGS.EMBER_MILK] > 0 || hasVagina()) outputText("generous mounds");
            else outputText("masculine pectorals");
            outputText(".");

            //(If Ember has a penis)
            if (hasCock()) {
                outputText("\n\nHanging from [ember eir] crotch, where it emerges from a slit leading to the interior of [ember eir]r pelvic cavity, is a 16 inch-long, two-inch wide penis with a shape unlike any other that you've seen so far in this realm.");
                outputText("\n\nThe head is rounded and elongated, while the shaft has a series of ridges, evenly spaced and so prominent as to give it an almost segmented appearance. When fully extended; a pair of apple-sized testicles drops out of [ember eir] genital slit.");
            }
            //(If Ember has a vagina)
            if (hasVagina()) outputText("\n\nThe scales in-between Ember's legs are particularly smooth and fine, and part just enough to reveal the insides of her slick pussy; soft, inviting and moist.");

            outputText("\n\nAt first Ember puffs [ember eir] chest in pride at your obvious appreciation of [ember eir] form, letting you examine [ember em] as closely as you want, but after a minute [ember ey] starts blushing in both arousal and embarrassment, eventually covering [ember em]self and blurting out, \"<i>That's enough looking!</i>\"");
            outputText("\n\n[ember Eir] reaction to your staring is kind of cute, actually.  [ember Eir] swaying tail and small fidgets let you know that [ember ey] actually might've been enjoying [ember em]self a bit too much...");
        }
        //Dragon-girl Appearance (By Radar) (Z)
        else {
            //Credit him with additional scenes.
            outputText("Ember is a 7' 3</i>\" tall ");
            if (flags[kFLAGS.EMBER_GENDER] == 1) outputText("male");
            else if (flags[kFLAGS.EMBER_GENDER] == 2) outputText("female");
            else outputText("hermaphrodite");
            outputText(" dragon-" + emberMF("boy", "girl") + ", with slender limbs and a thin frame; [ember ey] refuses to wear any kind of clothing and exposes [ember em]self naturally to the world.  [ember Ey] sports a rather human looking face, but with several key differences.  Where a normal set of human eyes would be located, instead a pair of orange, reptilian eyes stares back at you, filled with immeasurable pride and ferocity.");
            outputText("\n\nOn the sides of [ember eir] face, you spot an exotic pattern of dragon scales that are intertwined with [ember eir] olive, human like skin, which branch down [ember eir] neck and shoulders before merging with [ember eir] predominantly scaled body.  Like the dragons from your village lore, Ember sports a pair of ebony, draconic horns that emerge from [ember eir] temples, boldly curved backwards past [ember eir] scalp.  While you aren't certain of their rigidity, they look like they could deflect most overhead attacks.  Drawn to [ember eir] jaw, you zero in on an attractive pair of pink, human lips.  The calm appearance of [ember eir] mouth almost makes you forget the many sharp teeth that Ember sports, which could easily rend flesh from a body if Ember put [ember eir] mind to it.");
            outputText("\n\nThe shiny, silver hair that coiffures the dragon's head compliments [ember eir] facial features well and ");
            //Short:
            if (flags[kFLAGS.EMBER_HAIR] < 1) outputText("is quite short, giving [ember em] that definitive " + emberMF("masculine", "tomboy") + " look.");
            else outputText("drops down to [ember eir] shoulders, giving [ember em] the look of the " + emberMF("handsome", "beautiful") + " warriors from your village legends.");

            outputText("\n\n[ember Eir] chest is also human in appearance and houses a pair of ");
            if (flags[kFLAGS.EMBER_MILK] > 0 || hasVagina()) outputText("F-cup breasts that support 0.5 inch nipples and hang heavily; you idly wonder if [ember ey]'ll develop lower back problems as she spends more time in Mareth");
            else outputText("manly pectorals with 0.5 inch nipples");
            outputText(".  Just below [ember eir] collarbone, in the middle of [ember eir] chest, you see what looks like a small, golden, heart-shaped scale; adorning the chest like a birthmark of some sort.");

            outputText("\n\nAs you stare down at Ember's stomach, you note that the human-looking layer of flesh ends and the scaly dragon skin begins.  Still humanoid in shape, you can make out the " + emberMF("masculine", "feminine") + " features of Ember's belly and lower torso well enough.");

            outputText("\n\nThis layer of scaling extends to [ember eir] back as well, albeit without any patches of human skin.  A fine stripe of white mane adorns Ember's spine and catches your eye.  The leathery wings that jut out of Ember's back around them only add to the fierce appearance of [ember eir] body, and look like they could easily propel their owner into the air.");

            outputText("\n\nEmber has, in most respects, a rather human-looking pelvis.");
            if (hasCock()) {
                if (flags[kFLAGS.EMBER_INTERNAL_DICK] == 0) outputText("  [ember Ey] sports a flaccid penis and a pair of apple-sized balls that sit dangerously exposed to the elements, let alone to naked blades or a heavy blow.  Yet [ember ey] doesn't seem concerned about that in the least, almost daring anyone to focus on them.  While [ember ey] isn't aroused right now, Ember's penis can reach a length of approximately 16 inches, and it looks to be about 2 inches thick.");

                else outputText("  [ember Ey] sports what looks like a protective slit of some sort, protecting [ember eir] dick from the elements as well as stray blows.  You can't see it right now; but you remember it to be about 16 inches long and 2 inches thick.");
            }
            //Ember has a pussy:
            if (hasVagina()) outputText("  The inviting lips of a human-looking pussy purse between her legs; some moisture seems to have gathered on her labia, giving it a slick look that just begs for attention.");

            outputText("\n\nEmber's legs themselves are somewhat human-like in appearance, but they're covered in the thick protective scales that don most of [ember eir] extremities.  Only the feet look like anything but normal human anatomy; the clawed feet of a predator decorate [ember em] instead, capped with talons meant for gripping at the ground... or at prey.");
            outputText("\n\nYou've drawn the dragon's attention with your examination of [ember eir] body - Ember darts a reptilian tongue out from [ember eir] lips, as if to entice you.");
        }
        doNext(emberCampMenu);
    }

    //Talk
    private function talkToEmber():void {
        //Checks for special scenes go here!
        //If the PC fulfills one of the requirements for the Special Scenes, they occur the moment the player picks the talk option.
        if (player.isPregnant() && hasCock()) { //Extra check might protect against inappropriate Ember complaints
            if (flags[kFLAGS.EMBER_OVI_BITCHED_YET] == 0 && (player.pregnancyType == PregnancyStore.PREGNANCY_OVIELIXIR_EGGS || player.pregnancy2Type == PregnancyStore.PREGNANCY_OVIELIXIR_EGGS)) {
                emberBitchesAboutPCBeingFullOfEggs();
                endEncounter();
                return;
            }
            if ((player.pregnancyType == PregnancyStore.PREGNANCY_EMBER || player.pregnancy2Type == PregnancyStore.PREGNANCY_EMBER) && player.pregnancyType < 300 && flags[kFLAGS.EMBER_TALKS_TO_PC_ABOUT_PC_MOTHERING_DRAGONS] == 0) {
                emberTalksToPCAboutPCDragoNPregnancy();
                endEncounter();
                return;
            }
            if (player.pregnancyIncubation < sceneHunter.adjustPregEventTimer(200, player.pregnancyType) && (player.pregnancyType != PregnancyStore.PREGNANCY_EMBER || player.pregnancy2Type != PregnancyStore.PREGNANCY_EMBER) && flags[kFLAGS.EMBER_BITCHES_ABOUT_PREGNANT_PC] == 0) {
                manEmberBitchesAboutPCPregnancy();
                endEncounter();
                return;
            }
        }
        if (flags[kFLAGS.EMBER_PREGNANT_TALK] == 0 && pregnancy.event > 1) {
            emberIsPregnantFirstTimeTalkScene();
            endEncounter();
        }
        clearOutput();
        outputText("What will you talk about?");
        simpleChoices("Dragons", talkToEmberAboutDragonzzz, "Exploring", discussExplorationWithEmber, "Yourself", talkToEmberAboutYourself, "", null, "Back", emberCampMenu);
        if (flags[kFLAGS.EMBER_AFFECTION] >= 100 && flags[kFLAGS.EGG_BROKEN] < 1) addButton(3, "Eggshell", askEmberForEggshell).hint("Ask Ember for the eggshell. After all, you should have deserved the eggshell by now.");
    }

    //Talk about Dragons (Z)
    private function talkToEmberAboutDragonzzz():void {
        clearOutput();
        outputText("You ask Ember to tell you more about [ember eir] species.");
        var choice:Number = rand(5);
        if (choice == 0) {
            outputText("\n\nEmber crosses [ember eir] arms.  \"<i>Dragons are powerful and proud!  You would never see a dragon back away from a challenge; instead, we relish in competition.</i>\"  Ember continues talking about how dragons like to challenge each other.  Although interesting at first, you get bored soon, so you excuse yourself and leave.  Ember seems not to notice, and looks pleased to have had the chance to extoll the virtues of [ember eir] species.");
            //(+Affection)
            emberAffection(2 + rand(3));
        } else if (choice == 1) {
            outputText("\n\nEmber thinks for a moment before saying.  \"<i>Well, let's talk about dragon anatomy.</i>\"  Ember begins explaining about the finer points of how a dragon works...  \"<i>And if we're immobilized we can still use a powerful breath attack.  Normally dragons can only use one element, but I can use three!</i>\" Ember says, proudly puffing out [ember eir] chest.  You thank Ember for the explanation, then leave.");
            //(+Affection)
            emberAffection(2 + rand(3));
        } else if (choice == 2) {
            outputText("\n\nEmber decides to talk about dragon mating rituals.  \"<i>Dragons prove themselves to each other by showing off their strength... it isn't necessarily limited to just physical strength.  Usually it's done in competition.  A good mate has to be proud, brave, wise and strong.  So, as you can see, it's pretty certain you wouldn't find a dragon mating a non-dragon.</i>\"");
            outputText("\n\nEmber stops talking, [ember eir] face turns serious for a moment; [ember ey] looks deep in thought.  \"<i>Dragons wouldn't mate a non-dragon... in fact, dragons wouldn't even find non-dragons attractive...</i>\"  You think you hear [ember em] mumble.  \"<i>Dammit, then why do I feel this way...</i>\"");
            outputText("\n\nYou ask [ember em] to speak up.  Ember blurts out, \"<i>Nothing!  Lesson's over...</i>\" before withdrawing into [ember eir] den.");
            //(+Affection)
            emberAffection(5);
        } else if (choice == 3) {
            outputText("\n\nEmber elaborates on dragon courtship.  \"<i>There's a rare flower, called Drake's Heart.  It's very beautiful, and the perfume, especially for dragons, is exquisite.  Usually, dragons give this flower to the ones they intend to court.</i>\"");
            outputText("\n\nThe flower an utter mystery to you, you curiously ask Ember what this \"<i>Drake's Heart</i>\" looks like, and where it grows... or used to grow.");
            //Low affection:
            if (emberAffection() <= 25) outputText("\n\nSnorting, Ember cracks an amused smile as [ember ey] chuckles. \"<i>What, does the 'Champion' think [him]self worthy of courting me?  That's a good one!</i>\"  [ember Ey] giggles openly to make [ember eir] lack of interest in you known... yet, it seems rather forced.");
            else if (emberAffection() <= 75) outputText("\n\nYou swear you can see the dragon daydreaming at your words, but it doesn't last.  \"<i>Look, I don't mind some curiosity, but don't try and get fresh with me!</i>\"  [ember Eir] demeanor suggests annoyance, but just maybe it's a tough front, and [ember ey]'s really waiting for you to show some affection and attention.");
            //High affection:
            else outputText("\n\nThe dragon makes no effort to hide [ember eir] embarrassed reaction as [ember ey] reads a little too much into your inquiry.  \"<i>Um.. I-ho... well...</i>\" Ember stammers out.  \"<i>Look, I have other things to do.</i>\"");
            outputText("\n\nWondering at the dragon's thoughts, you agree to call the conversation done, and politely thank [ember em] for [ember eir] time.");
            emberAffection(5);
        } else {
            outputText("\n\nEmber begins talking about dragon habits, and the cave mouth framing [ember em] makes you wonder why dragons dig such dens.  Ember shrugs.  \"<i>It's convenient.  The stone is tough and can resist all forms of hazard, plus I'll always know I can keep my stuff safe inside.</i>\"  [ember ey] stares at [ember eir] den in deep thought.");
            outputText("\n\n\"<i>It's kinda small though... I might need a bigger one if...</i>\"  Ember stops abruptly");
            if (flags[kFLAGS.EMBER_ROUNDFACE] == 1) outputText(", a blush creeping onto [ember eir] cheeks");
            outputText(".");
            outputText("\n\nYou ask if [ember ey]'s all right.  \"<i>Huh?  Yes, I'm fine!  Anyways, lesson's over.</i>\"  Ember hurriedly goes back inside [ember eir] den.");
            emberAffection(5);
        }
        doNext(playerMenu);
        cheatTime(1 / 6);
    }

    //Exploration (Z)
    private function discussExplorationWithEmber():void {
        clearOutput();
        var choice:int = rand(4);
        var subChoice:int = 0;
        outputText("You ask Ember for news of anything interesting [ember ey] has seen during [ember eir] aerial explorations of Mareth.");
        outputText("\n\nEmber nods [ember eir] head and scratches [ember eir] chin thoughtfully.  \"<i>Let me think...</i>\"");

        if (choice == 0) { //Mountain
            subChoice = rand(6);
            outputText("\n\n\"<i>In my travels, I found a mountain range.  I flew around it for a good while... it felt so... familiar, you know?  While I was there, I saw ");
            if (subChoice == 0) outputText("imps. Only a few imps, and they seemed very nervous. I'm guessing that whatever naturally lives there is something that they really don't want to get involved with.");
            else if (subChoice == 1) outputText("two goblins in the foothills, arguing with each other. One was saying that the other shouldn't go up into the hills, as apparently the minotaurs that live there are too much for an untrained girl like her to take without being split open. The second goblin just laughed at her, called her a 'wimp' and told her that she's going to get herself 'some juicy bull-cock and tasty mino-spooge'. Ugh, disgusting little creatures.");
            else if (subChoice == 2) outputText("a pair of muscle-bound bull-men beating on each other with their bare fists. They spent over an hour smashing each other into a bloody pulp, and then the winner promptly started fucking the loser up the ass.  I had seen more than enough by that point, so I left.");
            else if (subChoice == 3) outputText("this... creature... that looked kind of like a human woman, but with a big dick where her clit should be.  She was walking around stark naked, 'cept for a bunch of piercings, and leading this bull-man along like a pet by a chain attached to a ring anchored into his cockhead.");
            else if (subChoice == 4) outputText("a couple of goblins sharpening scissors on some rocks outside of a cave with a door on it. Weird. Wonder what they could be doing in there?");
            else if (!player.hasStatusEffect(StatusEffects.WormsOff) && rand(2) == 0) outputText("a horrible swarm of slimy white worms, clumped together into a mockery of a human form and squelching along.  It managed to latch onto this two-headed dog-creature and... ugh!  The worms started forcing their way into both of its cocks!  I've never seen anything so disgusting!");
            else if (subChoice == 5) outputText("this two-headed dog-morph loping around; it spotted an imp, dropped to all fours, then gave chase. Managed to catch the ugly little demon, whereupon it ass-raped it, then ate it.");
        } else if (choice == 1) { //Forest
            subChoice = rand(5);
            outputText("\n\n\"<i>In my travels, I found a forest; I must confess I stayed out of the deepest parts, but there was plenty of game to be found.  Deer, boar, rabbits, quail, and a host of other things too... not all of it nice. Let's see, there was ");
            if (subChoice == 0) outputText("a whole tribe of imps, just lounging around in a glade, jerking themselves off or squabbling over food.  Nasty little things, but easily dispatched.");
            else if (subChoice == 1) outputText("a  goblin with a huge pregnant belly, laughing to herself and swilling down that ale they brew, slopping it all over herself.  Little hedonists.");
            else if (subChoice == 2) outputText("this strange bee-woman creature... she made this, this music that started messing with my head.  I spat a tongue of flames at her and she flew away in fright, luckily.");
            //(If player has impregnated Tamani)
            else if (subChoice == 3 && flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] > 0) {
                outputText("that green-skinned baby-making whore, Tamani.  She was letting some of her daughters suckle from her and grinning ear to ear as she named the 'prize catch' she got to father them, exhorting them to hunt him down.");
                if (hasVagina()) outputText("  You should have more pride than to let some brainless cunt like that have her way with you!");
            }
            //(If player has not yet impregnated Tamani)
            else if (subChoice == 3 && !SceneLib.forest.tamaniScene.pregnancy.isPregnant) outputText("one goblin being teased by a bunch of pregnant goblins for not being pregnant yet.  She just spat back that she wanted a 'better catch' to be her baby-maker than a mere imp and wandered off.");
            //(If Jojo isn't in the camp & not corrupt)
            else if (rand(2) == 0 && monk <= 1 && !player.hasStatusEffect(StatusEffects.PureCampJojo)) outputText("this mouse-morph monk, sitting in a glade and meditating. A goblin tried to proposition him; he just gave her a lecture and sent her running away in tears.  When an imp tried to attack him, he crushed its skull with a staff he had.  Not bad moves for such a weedy little thing...");
            else outputText("one glade I touched down in to catch myself a nice brace of plump coneys, when all of a sudden this... this thing made out of flailing vines and fruit attacks me.  It went up in a puff of smoke once I torched it, of course.");
        } else if (choice == 2) { //Lake
            subChoice = rand(2);
            outputText("\n\n\"<i>In my travels, I found a lake... big and wide and full of fish, but something about the place made me uncomfortable.  The water smelled funny, and the fish had a nasty aftertaste.  Not a lot to see there, but I did find ");
            if (subChoice == 0) {
                outputText("a pair of shark-women - well, one was a woman, the other had breasts but also had a cock");
                if (flags[kFLAGS.EMBER_GENDER] == 3) outputText(" like me");
                outputText(". They were on the beach, fucking each other's brains out.");
            } else {
                //(If Whitney's Farm is not yet in the Places menu)
                if (rand(3) == 0 && player.statusEffectv1(StatusEffects.MetWhitney) <= 1) outputText(" a big farm on the shoreline.  I saw some sort of cow-woman tending to fields of peppers, and a dog-woman herding cattle. They looked pretty fat and tasty, too... What?  I meant the cattle, stupid!  And I wouldn't have taken them - it's no fun snatching up livestock.  I prefer to chase down a deer or a wild auroch or something like that.");
                //(if Fetish Cult is encounterable)
                else if (rand(3) == 0 && player.hasStatusEffect(StatusEffects.FetishOn)) outputText("a pair of humans, arguing about sex.  They both wanted it, but the guy said he wanted to do the 'naughty schoolboy and female teacher' routine, while the girl wanted to do the 'noblewoman and love-servant' routine.  Weird; their clothes kept changing back and forth as they argued.");
                //(If Beautiful Sword has not been acquired)
                else if (rand(3) == 0 && !player.hasStatusEffect(StatusEffects.TookBlessedSword) && !player.hasStatusEffect(StatusEffects.BSwordBroken)) outputText("a sword jammed into a tree.  Weird; what kind of idiot would stick a weapon there like that?  And what kind of weakling wouldn't be able to take it out?");
                else if (rand(3) == 0 && !player.hasStatusEffect(StatusEffects.CampRathazul)) outputText("a smelly rat-man moping around while some weird equipment bubbled and boiled.  I think maybe he was an alchemist.");
                else outputText("a great blob of green goo, sliding along and minding its own business.  I could swear it looked up at me once, and grew a penis... that can't be right, though.");
            }
        } else if (choice == 3) { //Desert
            subChoice = rand(4);
            outputText("\n\n\"<i>In my travels, I found a desert.  I hate deserts.  The thermals are nice, but it's far too dry and hot.  Mostly, it's just wasteland too.  Still, I saw something interesting; ");
            if (subChoice == 0) outputText("a woman with four big breasts, squeezing milk out of her tits and into the sand.  I didn't know breasts could hold that much milk!");
            else if (subChoice == 1) outputText("a whole tribe of demons, lounging around an oasis.  Would have been too much bother to kick the crap out of them, so I left them alone - well, alright, I did buzz them to make them scatter like scared sheep for fun.");
            //(if player hasn't solved Marcus & Lucia's argument)
            else if (rand(2) == 0 && !player.hasStatusEffect(StatusEffects.WandererDemon) && !player.hasStatusEffect(StatusEffects.WandererHuman)) outputText("a human with balls so big he had to carry them in a wheelbarrow, trundling through the wasteland with a succubus.  They were arguing about whether or not he should become an incubus.");
            else {
                outputText("this strange creature, like a woman with a snake's tail for legs, slithering through the sand.  ");
                if (player.isNaga()) outputText("She looked a lot like you.");
                else outputText("I've never seen anything like her before.");
            }
        }
        outputText("</i>\"");
        doNext(playerMenu);
        cheatTime(1 / 6);
    }

    //Talk about Yourself (Z)
    private function talkToEmberAboutYourself():void {
        clearOutput();
        var points:Number = 0;
        outputText("You ask Ember what [ember ey] thinks about you.");
        //(Low Affection)
        if (emberAffection() <= 25) {
            outputText("\n\n\"<i>You're a waste of time,</i>\" Ember says nonchalantly.  [ember Ey] walks past you and then flies off.");
            endEncounter();
            return;
        }
        //There's a points system here, that can range from 0 to 8, this is used to check Ember's final answer after " + emberMF("he","she") + "'s done examining the PC.
        //(Medium/High Affection)
        outputText("\n\nEmber puts a hand on [ember eir] chin and looks you over carefully.  [ember Ey] closes up on you and grips your arms, checking your muscles.");
        //(If PC Str < 50)
        if (player.str < 50) outputText("  \"<i>You could use more training; you look pretty weak...</i>\" Ember says, critically.");
        //(If PC Str < 90)
        else if (player.str < 90) {
            outputText("  \"<i>You're well on your way to being as strong as a dragon, but there's still room for improvement.</i>\" Ember says, pleased.");
            //(+1 point)
            points++;
        }
        //(If PC Str >= 90)
        else {
            outputText("  \"<i>With muscles like these, you could easily lift anything you wanted... even me...</i>\" Ember trails off dreamily, almost purring.  \"<i>N-Not that I'd want you to carry me in your arms or anything...</i>\"");
            //(+2 points)
            points += 2;
        }
        outputText("\n\nNext, Ember pokes at your chest and your ribs.  ");
        //(If PC Tou < 50)
        if (player.tou < 50) outputText("\"<i>I don't know how you could hope to survive out there.  You look like the wind could blow you away.</i>\"");
        //(If PC Tou < 90)
        else if (player.tou < 90) {
            outputText("\"<i>Not bad; some more training and you could be as tough as me!</i>\" Ember says, pleased.");
            //(+1 point)
            points++;
        }
        //(If PC Tou >= 90)
        else {
            outputText("\"<i>Your body's as tough as rock, you should show off more frequently...  N-Not that I'd want you to go naked!  You should always wear something to protect yourself,</i>\" [ember ey] quickly adds.");
            //(+1 Affection)
            emberAffection(1);
            //(+2 points)
            points += 2;
        }
        outputText("\n\nThen the dragon looks directly into your eyes.  ");
        //(If PC Int < 50)
        if (player.inte < 50) outputText("\"<i>You're still very naive... anyone or anything could trick you at any time...</i>\"  Ember frowns.");
        //(If PC Int < 90)
        else if (player.inte < 90) {
            outputText("\"<i>I see wisdom in your eyes, but you could always use more lessons.</i>\"");
            //(+1 point)
            points++;
        }
        //(If PC Int >= 90)
        else {
            outputText("Ember's eyes widen.  \"<i>I see great wisdom in your eyes...</i>\"  Ember's face grows more absent by the minute as [ember ey] looks at you in deep thought, until the trance breaks.  [ember Ey] blows at your face, brushing a claw on your forehead.  \"<i>Y-You had something in your face... I wasn't staring into your steely eyes.</i>\"");
            //(+2 points)
            points += 2;
        }
        outputText("\n\nEmber walks away, back turned to you.  Then suddenly [ember ey] says \"<i>Think fast!</i>\" and flicks [ember eir] tail, flinging a pebble at you.  ");

        //(If PC Spd < 50)
        if (player.spe < 50) outputText("You try to block the pebble, but you're not quick enough.  It hits your belly, not hard enough to hurt.  \"<i>You need to work on your reactions; anything could surprise you out there and you'd be helpless.</i>\"");
        //(If PC Spd < 90)
        else if (player.spe < 90) {
            outputText("You successfully deflect the pebble.  \"<i>Not bad!  Next time try to catch it,</i>\"  Ember says, pleased.");
            //(+1 point)
            points++;
        }
        //(If PC Spd >= 90)
        else {
            outputText("You easily catch the pebble and throw it back at Ember, surprising [ember em].  \"<i>With reflexes like these, you could even...</i>\" Ember mumbles.  \"<i>D-Don't even think about it!</i>\" [ember ey] snaps.");
            //(+2 points
            points += 2;
        }
        outputText("\n\nSatisfied, Ember turns to take another look at you.");
        //(If PC has high dragon or lizard score)
        if (player.racialScore(Races.NAGA, false) >= 3 || player.racialScore(Races.LIZARD, false) >= 3 || player.racialScore(Races.DRAGON, false) >= 3) {
            outputText("  Ember's eyes linger on your form.  After a moment of awkward silence, you clear your throat.  [ember ey] blinks and says hurriedly.  \"<i>Sorry... I was just admiring you-</i>\" Realizing what [ember ey] was about to say,and quickly blurts out.  \"<i>I mean the weather! Yes, nice day today isn't it?</i>\"  You're not convinced, but let it slide. Ember recomposes and clears [ember eir] throat before saying.");
            //(+1 Affection)
            points++;
        }
        outputText("\n\n\"<i>All right, here's what I think about you.</i>\"  ");
        if (points < 2) {
            outputText("\"<i>This is not good at all; it's a miracle you even managed to survive in this world thus far.  With the things I've seen roaming the land...</i>\" Ember trails off, concerned.  \"<i>You should stay in the camp; I'll help you train.</i>\"  You don't much like the assessment.");
        }
        //(else if points < 6)
        else if (points < 6) {
            outputText("\"<i>You're doing fine, but make sure you don't slack off, and keep training.</i>\"  You thank Ember for sharing [ember eir] thoughts.");
        }
        //(else)
        else {
            outputText("\"<i>You're quite a catch... if you strolled down the street you'd have dragons fawning all over you...</i>\"  Realizing what [ember ey] just said, Ember coughs furiously.  \"<i>I-I mean... lesser dragons might fawn all over you.  You don't meet my standards!</i>\"");
            emberAffection(5);
        }
        doNext(playerMenu);
        cheatTime(1 / 6);
    }

    private function askEmberForEggshell():void {
        clearOutput();
        outputText("You ask Ember if [ember ey]'s willing to give you the eggshell.  After all, it could be useful for something.");
        outputText("\n\n\"<i>Fine.  Since I like you, I'll give you the eggshell,</i>\" Ember says.  [ember Ey] walks into the darkness of the den and she comes back some time later with the eggshell fragments.");
        outputText("\n\n\"<i>Take these to the armorsmith in that city in the desert,</i>\" [ember ey] says.  You thank [ember em] for the eggshell.");
        flags[kFLAGS.EGG_BROKEN] = 1;
        outputText("\n\n(<b>Gained Key Item: Dragon Eggshell</b>)");
        player.createKeyItem("Dragon Eggshell", 0, 0, 0, 0);
        doNext(playerMenu);
        cheatTime(1 / 3);
    }

    //Ember Interactions: Special Events (edited, but pending modifications -Z)
    //Most of these scenes occur if you pick the option "Talk" while meeting the conditions, unless otherwise noted.
    //Scene appears when selecting [Talk]
    //This scene only appears if Ember is male or herm and PC is pregnant and showing (ie: pregnancy has progressed as much as stage 2, at least.)
    //PC must be pregnant with something besides Ember's child/egg to get this scene.
    //Occurs once per pregnancy.
    //To be implemented once preggers is set up.
    private function manEmberBitchesAboutPCPregnancy():void {
        clearOutput();
        flags[kFLAGS.EMBER_BITCHES_ABOUT_PREGNANT_PC] = 1;
        //(Low Affection)
        if (emberAffection() <= 25) outputText("The two of you talk about nothing in particular.  It's light, airy and pointless.  When you finish up, though, you realize something odd; Ember was doing [ember eir] best all throughout the conversation to avoid looking at your pregnant belly - almost as if [ember ey] were upset by it?");
        //(Moderate Affection)
        else if (emberAffection() < 75) outputText("Ember stares coldly at your gravid midriff as icebreaker after icebreaker from you falls flat.  You ask what's wrong.  \"<i>Nothing.  Nothing is wrong,</i>\" Ember states, flatly.");
        //(High Affection)
        else outputText("The expression Ember gives you is very cold.  \"<i>What is the meaning of this!?</i>\" [ember ey] says, motioning towards your bloated belly.  \"<i>You're supposed to help <b>me</b> breed more dragons; not slut around with trash!</i>\"  Ember blows out an indignant puff of smoke and walks away.");
    }

    //Scene appears when selecting [Talk]
    //This scene only appears if the PC is pregnant with Ember's child.
    //Occurs only once.
    //To be implemented once preggers is set up.
    private function emberTalksToPCAboutPCDragoNPregnancy():void {
        clearOutput();
        flags[kFLAGS.EMBER_TALKS_TO_PC_ABOUT_PC_MOTHERING_DRAGONS] = 1;
        outputText("You notice Ember's eyes are fixated on your swollen belly, and cautiously ask what [ember ey]'s looking at.");
        outputText("\n\n\"<i>I hope this is only the first of many...</i>\" Ember mumbles, before realizing you asked a question.  \"<i>Huh?  What?</i>\"");
        outputText("\n\nCurious, you press [ember em] on what [ember ey] means by that - about this being the first of many.");
        outputText("\n\n\"<i>That- I didn't say anything like that!  I just asked how you were feeling!</i>\" Ember steals a glance at your belly.");
        outputText("\n\nYou tell [ember em] that you're feeling fine... though you must admit, this baby is getting kind of heavy.  You're certain, though, that [ember ey] said something else; grinning, you teasingly ask what it was.");
        outputText("\n\nEmber's shyness reaches a head, and [ember ey] finally caves.  \"<i>Fine!  So what if I liked having sex and impregnating you?  And what does it matter that I want to do it again?  Big deal!</i>\"  Ember averts [ember eir] gaze and crosses [ember eir] arms.");
        outputText("\n\nYou ");
        if (player.lib < 40) outputText("start at this revelation, then ");
        outputText("give [ember em] a sultry smile and seat yourself in [ember eir] lap.  Ember tries to hide any kind of reaction, but [ember eir] hardening prick tells you what [ember ey]'s really thinking.  [ember Ey] bites [ember eir] lower lip and finally gets up.  \"<i>Oh, look at the time; I have to go!</i>\"  Ember slides from under you and dashes away in an attempt to further conceal [ember eir] arousal.");
        outputText("\n\nYou watch [ember em] go with a smile; [ember ey]'s so fun to tease... you place a hand on your stomach for balance and strain yourself upright.");
    }

    //Scene appears when selecting [Talk]
    //This scene only appears if Ember is pregnant.
    //Occurs once during Ember's first pregnancy.
    private function emberIsPregnantFirstTimeTalkScene():void {
        clearOutput();
        flags[kFLAGS.EMBER_PREGNANT_TALK] = 1;
        outputText("You can't help but stare at Ember's swollen belly; it's still so hard to take in that you have actually fathered a child with a creature of legend.  Especially given that there are times when it's hard to be entirely certain that Ember genuinely likes you.");
        outputText("\n\nEmber catches you staring");
        if (flags[kFLAGS.EMBER_ROUNDFACE] == 1) outputText(" and blushes");
        outputText(", one of her hands rubbing her belly lovingly and tenderly.  \"<i>W-what is it?  Why are you looking at me like that?  Something wrong?</i>\"");

        outputText("\n\nYou merely give her a faint smile and tell her that she's beautiful when pregnant.");
        if (player.cor >= 66) outputText("  You almost choke on those cheesy words; still, she'll never put out for you if you don't butter her up.");
        outputText("\n\n\"<i>You... I... do you really think so?</i>\" Ember asks, lowering her guard.");
        outputText("\n\nYou nod and assure her that she looks wonderful; she has a truly radiant glow, a maternal beauty that is unique and all her own.  You contemplate telling her that her scales have grown so shiny with her pregnancy, but you aren't sure if she'd take that as a compliment or not.");
        if (player.cor >= 66) outputText("  Is she seriously buying this nonsense?  Your smile would be miles wide if you let your lip curl even a bit, so you keep a straight face with due dilligence.");
        outputText("\n\nEmber can't hide her happiness at your compliments, as she rubs her belly a bit faster, but as if suddenly snapping out of a trance; she looks up to you with a confident stare and says, \"<i>Of course I'm beautiful!  Why else would you throw yourself into my arms and finally do the deed?</i>\"");
        outputText("\n\nThat's not how you remember the conception, and you wryly point out the events being quite the opposite.  You just can't resist poking her buttons, sometimes.");
        outputText("\n\n\"<i>Well... I wouldn't have done that if you hadn't kept teasing me!</i>\" Ember blurts out.");
        outputText("\n\nYou?  Teasing her?  You don't remember that, you tell her, adopting an exaggerated expression of contemplation.");
        outputText("\n\n\"<i>Erm... we... you cheated!  I don't know how, but you did!</i>\"  Ember finally turns on her heels, walking away.");
        outputText("\n\nYou give chase and catch her, apologising for teasing her and telling her to calm down; it's not good for her to get so upset in her current state.  She's just <i>adorable</i> when she's off-balance and flustered.");
        if (player.cor < 30) outputText("  Given her attitude and nature, you know how lucky you are to have someone like her want to be your mate.");

        outputText("\n\nEmber's smile broadens as you speak, and once you're done she gives your back a pat.  \"<i>Good!  Don't forget that this is your baby.</i>\"  Then she turns and walks back to her den for a quick nap.");
    }

    //Scene appears when selecting [Talk]
    //This scene only appears if the PC is pregnant with eggs due to using Ovi Elixir/Oviposition.
    //It doesn't matter if Ember doesn't have the parts, imagination is there for a reason.
    //Yup, you guessed it, only once.
    private function emberBitchesAboutPCBeingFullOfEggs():void {
        clearOutput();
        outputText("As you try and think of a topic to talk about, you realize Ember is staring at your egg-swollen stomach - not with anger or disdain, but with interest.  With a smirk, you place one hand on your belly and ask if [ember ey] finds you interesting to look at like this.");
        outputText("\n\n\"<i>Huh?  I wasn't staring!  Who would find a bunch of your unfertilized eggs interesting?</i>\" Ember blurts out, averting her gaze.");
        outputText("\n\nYou quirk an eyebrow; who said anything about unfertilized eggs?");
        outputText("\n\n\"<i>Erk... I... I need to go take a bath!  This idea is so gross I need to wash myself of it!</i>\"  Ember quickly runs past you.");
        outputText("\n\nYou watch [ember em] go and shake your head, wondering what that was about.");
        flags[kFLAGS.EMBER_OVI_BITCHED_YET] = 1;
    }

    //Occurs if PC spends too much time at 100 Lust.
    //counter triggered when PC starts an hour in camp at 100 Lust, output when reaching 10 counters
    public function emberBitchesAtYouAboutLustiness():void {
        outputText("\nYou strive to keep your mind focused, but... your libido is screaming at you, ");
        if (player.hasCock()) {
            outputText("your " + num2Text(player.cockTotal()) + " stiff as iron");
            if (player.hasVagina()) outputText(" and ");
        }
        if (player.hasVagina()) outputText("your " + vaginaDescript() + " slick and wet with moisture, ready to fuck");
        outputText(".  You want sex so bad it almost hurts...");
        outputText("\n\n\"<i>What's the problem?  Too horny to think straight?</i>\" Ember teases.");
        outputText("\n\nYou gamely try to insist that nothing's wrong, but have to eventually confess that you are feeling a bit... pent up.");
        //(Low Affection)
        if (emberAffection() <= 25) outputText("\n\n\"<i>Well, you should do something about it... it's not like I can help you with that anyway.</i>\"");
        //(Medium Affection)
        else if (emberAffection() < 75) outputText("\n\n\"<i>Well... I might be persuaded to help you with that, if you ask nicely.</i>\"");
        else outputText("\n\nEmber plants a kiss on your cheek.  \"<i>I could help you with... I-I mean, I suppose I could help you if you get on your knees and ask...</i>\"  Judging by [ember eir] averted gaze and husky voice, you doubt the request would need to be quite so formal.");
        outputText("\n");
        flags[kFLAGS.EMBER_LUST_BITCHING_COUNTER] = 0;
    }

    //This scene only appears if the player is suffering from Minotaur Cum addiction, and only before PC develops addicted perk.
    //Output automatically when PC enters camp while conditions are met
    //This should reduce the chance of meeting minotaurs.
    public function minotaurJizzFreakout():void {
        outputText("\nYou try to hold a conversation with Ember, but it's hard for you to concentrate; you keep thinking about the delicious, soul-burning taste of hot, salty minotaur cum, straight from the bull-man's cock.  Inevitably, Ember asks you what the matter is and, salivating, you paint the picture for her.");
        outputText("\n\nEmber suddenly throws back [ember eir] head with a terrible roar of fury that rattles the very rocks underfoot.  \"<i>I'll kill them!  I'll bash their brains out - I'll rip off their stinking hairy hides!  I'll gorge myself on their flesh and pick my teeth with their horns!  Nobody will poison you like that - nobody!</i>\"");
        outputText("\n\nBefore you can do anything, the livid dragon spreads [ember eir] wings.  \"<i>When I return I will watch you carefully, to see that you beat this... addiction.</i>\" [ember Ey] flies away, heading in the direction of the mountains.  You've never seen [ember em] so mad before...");
        if (followerKiha()) outputText("\n\nKiha saunters up and smirks.  \"<i>I thought I had a temper.</i>\"");
        flags[kFLAGS.EMBER_CURRENTLY_FREAKING_ABOUT_MINOCUM] = 1;
        outputText("\n");
    }

    //Scene
    //This plays automatically when the PC gets over " + emberMF("his","her") + " temporary addiction to minotaur cum
    //Normal note for PC getting over mino cum addiction plays first
    public function emberGetOverFreakingOutAboutMinoJizz():void {
        flags[kFLAGS.EMBER_CURRENTLY_FREAKING_ABOUT_MINOCUM] = 0;
        outputText("\nYou should probably let Ember know that you are no longer plagued by thoughts of minotaurs... if only to prevent ecological collapse.  Fortunately enough, you find [ember em] landing in front of [ember eir] den just then.  [ember ey] throws another minotaur's skull on the smallest pile, then turns to face you.  \"<i>What's got you so cheerful?</i>\" [ember ey] asks.");

        outputText("\n\nWhen you explain that you feel like you're over your addiction, [ember eir] face lights up.  [ember ey] gives a roar of delight and then suddenly envelops you in a crushing embrace - only to realize what [ember ey] is doing and shortly release you, looking obviously embarrassed.");
        outputText("\n\n\"<i>Th-that's great to hear.  Nobody should have to put up with something so undignified as an actual craving for sexual fluids, particularly from beasts like that.</i>\"");

        outputText("\n\nYou point out that this means [ember ey] no longer has to hunt down minotaurs, for your sake. Which furthermore means, you note, that she can stop leaving cow skulls and hooves and other rubbish all over the camp.");

        outputText("\n\n[ember Ey] promptly lets out a thunderous belch, heavy and wet and vulgar, filling the air with the stink of blood and beef.  The dragon then looks idly at the 'trophy piles' [ember ey]'s built up.");
        //(Low Affection)
        if (emberAffection() <= 25) {
            outputText("\n\n\"<i>Stupid.  As if I was doing it for you.</i>\"  Ember looks at you and quickly adds.  \"<i>You're not worth the time if you take pleasure from sampling bulls' dicks.</i>\"  [ember Ey] turns away in a dismissive motion.  \"<i>Don't get any ideas; this doesn't mean we're friends or anything.  I just really hate those dumb cows.</i>\"");
            outputText("\n\nWhether [ember ey] was hunting them to help you or [ember ey] just felt like beef for the last few days, the fact remains that she helped tamp down the, ah, temptation they presented.");
        }
        //(Medium Affection)
        else if (emberAffection() < 75) {
            outputText("\n\n\"<i>Finally... I was getting tired of eating roasted beef all the time.</i>\"  Ember looks at you and quickly adds.  \"<i>You should be grateful that I used a bit of my valuable time to help you!</i>\"");
            outputText("\n\nYou tell her that you do appreciate [ember eir] intent, and you're sorry [ember ey] had to put [ember eir] stomach through so much abuse on your behalf.");
            outputText("\n\n\"<i>Good.  Now, you, if you're so sorry, you can start by cooking me something to get the taste off my mouth.</i>\"  Ember crosses [ember eir] arms, waiting for you.");
            outputText("\n\nNoting the chronic indigestion [ember ey] has been plagued with since starting this little crusade, you'd have thought the last thing [ember ey]'d want for a while is more food.  After all, the reason [ember ey]'s got such a bad case of wind is because [ember ey] keeps eating too much.");
            outputText("\n\n\"<i>Then get me a tea or something!</i>\"  Ember replies indignantly.");
            outputText("\n\nLife is fucking weird.");
        }
        //(High Affection)
        else {
            outputText("\n\nEmber sighs and turns to look at you.  \"<i>I hope you'll stay away from those stupid bulls from now on.  Next time you have a craving");
            //(Male/HermEmber:
            if (hasCock()) outputText(", especially for sucking cock,");
            outputText(" you should come to me instead; I'll help you.</i>\"  Then as if realising what [ember ey]'s just implied, Ember looks away; and hurriedly adds, \"<i>But not the way you're thinking...</i>\"");
            outputText("\n\nYou simply lift an eyebrow and ask how else [ember ey] intends to help.");
            outputText("\n\n\"<i>J-just forget it!</i>\"  [ember Ey] turns to walk away, stopping briefly to stifle another burp and hold [ember eir] belly.  You call out to the dragon that eating minotaurs, bones and all, really can't be good for [ember eir] stomach; in fact, given the near-constant bellyaching and belching [ember ey]'s suffered through, maybe it's [ember em] that needs the help?  Some medicine, or at least a bellyrub?");
            outputText("\n\n\"<i>B-bellyrub?  What do I look like!?  A pet!?</i>\" Ember yells, rubbing [ember eir] belly [ember em]self.");
        }
        outputText("\n\nYou sigh softly, shake your head and walk away.  You're not certain you would have chosen the way that Ember 'helped' you get over your addiction, but you can't deny that [ember ey] really did mean to help, and in its way, it did.\n");
    }

    //Get Blood - the dragon TF vehicle(Z)
    //Can only be picked once per day.
    //Player may drink a small bit or drink more.
    //Drinking only a bit will boost 3 of the PC's status randomly (Strength, Toughness, Intelligence, Speed), a random amount between 1-5.
    //Drinking more blood, will in addition to the status boost, TF the player into a dragon, gaining the respective skills that come attached to each part.
    //PCs that are dragony enough might be bestowed with Tainted Ember's signature breath weapon.
    private function bloodForTheBloodGod():void {
        clearOutput();
        outputText("You ask Ember if [ember ey] would be willing to give you a taste of [ember eir] blood, desirous of the power that lies within it.");
        //(If Ember hasn't recovered from the last time " + emberMF("he","she") + " shared her blood)
        if (flags[kFLAGS.DRANK_EMBER_BLOOD_TODAY] == 1 && !debug) {
            outputText("\n\n\"<i>Sorry, but I'm still recovering from last time, so no blood for you,</i>\" Ember states matter-of-factly.");
            doNext(playerMenu);
            return;
        }
        //(Low Affection)
        if (emberAffection() <= 25) {
            outputText("\n\n\"<i>What!?  Why should I hurt myself for you?!</i>\"  Ember indignantly blows a small ring of flames at you and walks away.");
            doNext(playerMenu);
            return;
        }
        //(Medium Affection)
        else if (emberAffection() < 75) {
            outputText("\n\n\"<i>Hmm... fine!  If anything, I might rub off on you.  You could stand to be a bit more majestic!</i>\"  Ember makes a cut on [ember eir] palm with a claw, and presents to you the bleeding hand.");
            outputText("\n\nYou reach out and take it in yours");
            if (player.cor < 50) outputText(", expressing your gratitude; gently, you kiss [ember eir] fingers, then the cut, letting its cool, iron-tinted tang roll across your lips and tongue.  You carefully lick, trying to avoid causing pain as you drink that which [ember ey] has so generously offered you.");
            else outputText(", quickly drawing it to your mouth and forming a seal around the cut with your lips, anxious to let not a drop escape.");
            outputText("\n\nEmber winces as you start to lick [ember eir] wound, but quickly recovers composure.  You dart your eyes up to look at [ember eir] face momentarily; [ember ey]'s a bit flustered and it's clear that your licking is bringing [ember em] at least some relief from the pain of [ember eir] injury.");

            outputText("\n\nAs you drink, you feel a rush of energy course throughout your body; you feel lofty, powerful, and erudite.  Who knows what will happen if you keep drinking...");
            //[Continue][Stop]
            simpleChoices("Continue", drinkDeeplyOfDagronBlud, "Stop", noMoDagronBlud, "", null, "", null, "", null);
        }
        //(High Affection)
        else {
            outputText("\n\n\"<i>I think you've been nice enough to deserve a small favor... but I expect you to make it worth my while.  Come and get it.</i>\"");
            outputText("\n\nEmber bites [ember eir] tongue with a wicked, dagger-like fang and extends it a few inches past [ember eir] lips, smearing bluish blood on them and inviting you with open arms and a small kiss.");
            outputText("\n\nIt would be rude to keep [ember em] waiting; you slide over, letting [ember em] enfold you in [ember eir] embrace and drawing the bloody tongue into your mouth.");
            outputText("\n\nEmber kisses you back; [ember eir] bleeding tongue stroking yours lovingly.");
            outputText("\n\nAs you drink, you feel a rush of energy course throughout your body; you feel lofty, powerful, and erudite.  Who knows what will happen if you keep drinking?");
            //[Continue][Stop]
            simpleChoices("Continue", drinkDeeplyOfDagronBlud, "Stop", noMoDagronBlud, "", null, "", null, "", null);
        }
        //Flag as drinking her blood today!
        flags[kFLAGS.DRANK_EMBER_BLOOD_TODAY] = 1;
        //Medium/high get stat boosts!
        var stat:int = rand(4);
        if (stat == 0) dynStats("str", 1);
        else if (stat == 1) dynStats("tou", 1);
        else if (stat == 2) dynStats("spe", 1);
        else dynStats("int", 1);
    }

    //[=Stop=]
    private function noMoDagronBlud():void {
        clearOutput();
        if (emberAffection() < 75) {
            outputText("You decide to stop for now and pull away.  Ember licks [ember eir] own wound [ember em]self and you thank [ember em] for sharing.");
            outputText("\n\n\"<i>D-Don't mention it...</i>\"");
        } else {
            outputText("You decide to stop for now and pull away.  Ember licks [ember eir] lips, draws [ember eir] tongue back into [ember eir] mouth and purrs with delight.  When [ember ey] realizes what [ember ey]'s doing, though, [ember ey] sobers.  \"<i>D-Don't get any strange ideas...</i>\"");
            outputText("\n\nYou gently ask what [ember ey] means by \"<i>strange ideas</i>\".");
            outputText("\n\n\"<i>The ones you're getting!</i>\" Ember blurts out, before spinning on [ember eir] heels and leaving you alone. You watch [ember em] go and smile.");
        }
        endEncounter();
    }

    private function drinkDeeplyOfDagronBlud():void {
        clearOutput();
        if (emberAffection() < 75) {
            outputText("You decide to continue drinking Ember's blood; intent on acquiring all the power it can bring out from within you.");
            //check for TFs and output appropriate text from below
            emberTFs();
            outputText("\n\n\"<i>Ugh... you drank too much... I feel woozy,</i>\" the dragon gripes.");
            outputText("\n\nYou offer [ember em] a helping hand.  Ember, surprisingly, accepts your help.  \"<i>Thanks.  I guess no more work for today... I need some food and a nap.</i>\"");
        } else {
            outputText("\n\nYou decide to continue drinking Ember's blood; intent on acquiring all the power it can bring out from within you.");
            //output tf from below
            emberTFs();
            outputText("\n\nAs you break the kiss; Ember leans over, supporting [ember em]self on your shoulders.  \"<i>Ugh... I guess we overdid it... I feel woozy.</i>\"");
            outputText("\n\nYou quickly offer [ember em] a helping hand, inquiring if [ember ey] is all right.  Ember accepts your help, using your hand to balance [ember em]self.  \"<i>I-I'll be fine... just, no more sharing for the day...</i>\"");
        }
        endEncounter();
    }

    //TF messages (Z)
    public function emberTFs():void {
        dragonTFchanges.dragonTFeffects();
    }

    //Get Egg (Ovilixer Ember) (Z)
    //Spying or watching Ember lay, increases lust by a small amount, while helping Ember lay, increases lust by a moderate amount.
    //Player always gets the egg.
    private function emberIsAnEggFactory():void {
        clearOutput();
        outputText("You ask Ember if she would be willing to lay an egg for you");
        if (flags[kFLAGS.EMBER_OVIPOSITION] <= 0) outputText(" if you give her an oviposition elixir");
        outputText(".");
        //(Low Affection)
        if (emberAffection() <= 25) {
            outputText("\n\nEmber's eyes darken.  \"<i>How dare you!  Asking me to do something... so... so embarrassing!</i>\"");
            outputText("\n\nYou apologize, but you really could use one of those blank eggs she lays on your mission... Besides, she needs to lay them and get rid of them anyway, right?  Being blocked up and just letting them multiply inside her belly can't be pleasant.");
            outputText("\n\nEmber puffs out a ring of smoke.  \"<i>Even if I have no use for it; it's still a very personal part of me!</i>\" However, she rubs her chin in thought... perhaps weighing whether she should give you the egg or not.  Finally she concedes.  \"<i>Fine!  But you'd better not do anything strange with it!</i>\"");
            outputText("\n\nYou assure her that you have nothing weird planned.  A part of you wonders just what you could do with it besides eat it ");
            if (player.cor >= 40) outputText("or sell it for quick cash ");
            outputText("anyway, but you don't tell her that.");
            outputText("\n\n\"<i>Ok, wait here then.</i>\"  Ember ducks off through a few bushes, intent on getting some privacy.");
            outputText("\n\nUnable to resist the temptation, you decide to sneak after her and see how she will coax herself into laying before her body would usually make her pass her unfertilized egg.  You carefully move through the wastes, watching the ground closely to avoid any noises that might give you away.");
            outputText("\n\nEmber is sitting on a rock, legs open");
            if (hasCock()) {
                outputText(" and her ");
                if (internalDick()) outputText("dragon-dick jutting from its slit,");
                else outputText("veiny, bulbous penis fully");
                outputText(" erect");
            }
            outputText(".  One of her hands gently teases her clit, as another traces her outer labia; she bites her lips, trying to stifle her moans of pleasure, but it's useless... every touch brings a sigh.");
            outputText("\n\nHer pace quickens, her moans grow more intense, and you think you can see what looks like the shell of a egg beginning to peek through her netherlips.  Sure enough, Ember holds her pussy open with a hand and cups the egg in the other.  She groans at the effort of pushing, and slowly the egg comes; once the largest part has passed, the egg rapidly slips out of her and plops into her hand.");
            outputText("\n\nShe pants, looking at the slick egg for a bit before licking it clean of her juices, then lays down, clearly intent on waiting until she's cooled down a bit");
            //[(if Ember has a dick)
            if (hasCock()) outputText(" and her throbbing cock is soft enough to hide");
            outputText(" before she presents the egg to you.");
            outputText("\n\nYou decide to return to where you were supposed to wait for Ember, in the hopes of being able to hide how turned on you are yourself after watching Ember's little show.");
            outputText("\n\nA few minutes later Ember appears, holding the egg; luckily, you've managed to resume your original position and obscure your arousal.");
            outputText("\n\n\"<i>Here's your egg.</i>\"  Ember holds out the egg for you, averting her eyes.  With a smile, you take it from her hands and thank her for her generosity.");
            outputText("\n\nEmber mumbles quietly, \"<i>Next time, fertilize it for me will you?</i>\"  You start at that; did she really just say it aloud?  But, knowing her temper, you decide against asking.  ");
            //git a dragon egg, small libido-based lust damage
            dynStats("lus", 10 + player.lib / 10, "scale", false);
            inventory.takeItem(consumables.DRGNEGG, explorer.done);
        }
        //(Medium Affection)
        else if (emberAffection() < 75) {
            outputText("\n\nEmber gasps");
            if (flags[kFLAGS.EMBER_ROUNDFACE] == 1) outputText(" and her cheeks grow red with embarrassment");
            outputText(".  \"<i>T-This...</i>\"  She can't quite bring herself to finish the sentence and settles for just looking at the ground.");
            outputText("\nYou apologize, but assure her that it really would be helpful if she could provide you with just one of her barren eggs.");
            outputText("\n\nEmber seems to cringe when you say 'barren eggs' but she remains still.  Finally, after what feels like an eternity of awkward silence, Ember sighs.  \"<i>Fine... I'll lay one egg for you.  Do you... err... want to...</i>\"  You quirk your head and ask her to repeat that; you didn't catch it.");
            outputText("\n\nEmber bites her lips and says once more, a bit louder this time, \"<i>Would you like to watch?</i>\"");
            outputText("\n\nYou blink at the offer, then give her your most winning smile.  You could agree, or just smooth-talk your way out of it.");
            //[Watch][Fob Off]
            simpleChoices("Watch", watchMediumAffectionEmberEggLay, "Don't Watch", dontWatchEmberLayEgg, "", null, "", null, "", null);
        }
        //(High Affection)
        else {
            outputText("\n\nDespite Ember's growing embarrassment, she smirks and looks you over.  \"<i>F-Fine... but I expect you to help with it.</i>\"");
            if (flags[kFLAGS.EMBER_OVIPOSITION] <= 0) {
                outputText("  She uncorks a bottle of oviposition elixir and gulps down the contents.  Immediately, her belly swells.");
                player.destroyItems(consumables.OVIELIX, 1);
            }
            outputText("\n\nYou ask her what she has in mind.");
            outputText("\n\n\"<i>Don't be silly!  You know what I mean...</i>\"  Ember's face looks as pinched as a snake's; some moisture runs down her thighs");
            if (hasCock()) outputText(", and her cock points you accusingly");
            outputText(".");
            outputText("\n\nShe leads you to a secluded spot and sits down on a nearby stump, then exhales and gathers herself, slowly spreading her legs to give you access to her most intimate parts.  \"<i>L-Look...</i>\" Ember insists, spreading her netherlips apart giving you a perfect view of her pink, moist, fuckhole.  \"<i>L-Like what you see?</i>\"");
            outputText("\n\nYou tell her that you do, though you can't resist commenting that she's moving a little faster than usual.  Ember looks at you through half-lidded eyes.  \"<i>And you're not moving fast enough.</i>\"  With a grin at her unusual good humor, you approach her and take up station between her thighs.  You ask if she wants your hands or your tongue to 'help' her this time.");
            outputText("\n\n\"<i>J-just get started... before I change my mind about this...</i>\"");
            outputText("\n\nWell, no point leaving her hanging around.  You let your tongue roll out");
            if (player.tongue.type > Tongue.HUMAN) outputText(" and out... and out...");
            outputText(" and then lean forward to give her a great, wet, sloppy lick, straight up the center of her pussy");
            //(E.Herm:
            if (flags[kFLAGS.EMBER_GENDER] == 3) outputText(" not stopping until you have slurped your way to the very tip of her cock");
            outputText(", savoring the unmistakable taste of her intimate juices.");
            outputText("\n\nEmber gasps and moans, leaning back to voice her pleasure to the skies; her legs quiver and her claws dig into the wood; her wings spread, beating gently to help her balance herself.  \"<i>D-don't stop...</i>\" she pleads.");
            outputText("\n\nYou don't intend to, and continue to lick, playing your tongue as deeply into her depths as possible, ");
            if (player.tongue.type > Tongue.HUMAN) outputText("which is quite far indeed, ");
            outputText("caressing and stroking and playing all the tricks you can possibly think of to orally pleasure your draconic lover.  From the amount of juices beginning to seep onto your lapping tongue");
            if (flags[kFLAGS.EMBER_GENDER] == 3) outputText(" and dribbling down her painfully stiff dick");
            outputText(", you think you're doing rather well.");
            outputText("\n\nWhen your nose bumps into her little button of pleasure Ember nearly jumps; she closes her thighs around your head, smothering you on her dripping vagina.");
            if (player.tongue.type > Tongue.HUMAN) outputText("  Right at this time, you feel something round and smooth on the tip of your tongue, gently spreading Ember's walls.  Realizing that this can only be her egg, you start trying to worm your long, sinuous tongue between it and her innermost walls, hoping to coax it out of her.");
            outputText("\n\n\"<i>It's coming!  Ah!  I'm coming!!</i>\" Ember screams, shaking with barely contained pleasure.  A flood of juices threaten to drown you, as Ember's legs hold you snug.");
            if (flags[kFLAGS.EMBER_GENDER] == 3) outputText("  Her cock throbs and pumps out long streams of cum to paint the ground around you two; marking it as your special place.");
            if (player.tongue.type > Tongue.HUMAN) outputText("\n\nYou can really feel her egg now, and do your best to wrap it tightly in coils of inhuman tongue.  Gently you pull and slide and wriggle it until it plops wetly out of its mother into your waiting hands; your tongue is strong and flexible, but you don't quite trust it to hold your prize aloft on its own.");
            else outputText("\n\nYou can feel the shell of Ember's egg pressing against your tongue, and you abandon your licking to start probing gently with your fingers.  Under your careful guidance, the egg slips freely from Ember's body into your grasp.");

            outputText("\n\nEmber's legs finally relax enough to let you escape... but her body slowly leans over in your direction, until she finally gives and collapses on top of you. Luckily you manage to move the egg out of the way, saving it from the pile of pleasured dragon before both of you crash into a sprawled pile on the ground.  You shake your head and smile at Ember, teasing her about how easily she just melts into a pile of mush from a little pleasure.");
            outputText("\n\nThis earns you a glare.  Ember quickly scampers up onto her feet and brushes the dirt from her scales.  \"<i>Maybe I should stop laying eggs for you then,</i>\" she remarks disdainfully.");
            outputText("\n\nYou tease her that there's no way she could give up such a convenient excuse to have you eat her out with no expectation of having to return the favor, poking your tongue out for emphasis.");
            outputText("\n\nEmber sighs, realising she's fighting a losing battle.  \"<i>At least I know what to expect when I'm finally laying a fertilized one.</i>\"  Moments after her comment, her face lights with awareness and embarrassment.  \"<i>I... I mean...</i>\"");
            outputText("\n\nYou just smile and tell her you understand exactly what she meant.  One quick kiss and you head back to the camp proper, leaving one adorably flustered dragon behind you.  ");
            //git a dragon egg, small libido-based lust damage
            dynStats("lus", 10 + player.lib / 10, "scale", false);
            inventory.takeItem(consumables.DRGNEGG, explorer.done);
        }
    }

    //[Fob Off]
    private function dontWatchEmberLayEgg():void {
        clearOutput();
        outputText("You take her hand and tell her that you wouldn't dream of intruding on her privacy, but ask her to think of you if she needs the inspiration.  She looks away shyly, and the barest hint of a smile breaks on her face.  Seems like she's already following your instructions.");
        outputText("\n\nShe sashays off, with a sheen of moisture between her thighs, and you seat yourself on a rock to await the result.  Over thirty minutes later, the panting dragon reappears and hands you an egg, still sticky.");
        if (flags[kFLAGS.EMBER_GENDER] == 3) outputText(".. it even drips with some kind of off-white fluid.");
        outputText("  \"<i>H-here's your egg.  Use it while it's fresh, okay?</i>\"  Her eyes glaze over a bit at the suggestion, and she giggles.  ");
        //git a dragon egg, no Ember affection change
        inventory.takeItem(consumables.DRGNEGG, explorer.done);
    }

    //[Watch]
    private function watchMediumAffectionEmberEggLay():void {
        clearOutput();
        outputText("Ember fails to hide her arousal when you accept.  \"<i>Okay, then follow me.</i>\"  The two of you move into a secluded spot.  Once she is certain nobody is around to spy, Ember turns to face you");
        //(if Ember has a cock:
        if (flags[kFLAGS.EMBER_GENDER] == 3) outputText(", cock poking straight out");
        if (internalDick()) outputText(" of its hiding place");
        outputText(".  \"<i>Okay... but you're only allowed to watch!  If you do anything weird, I swear I'll smack you!</i>\"");
        outputText("\n\nYou promise her that you won't do anything");
        if (player.lib >= 50) outputText(" she doesn't ask you to, beaming a salacious grin");
        outputText(".");
        outputText("\n\nEmber sits down atop a rock nearby and spreads her legs, giving you a perfect view of her moist slit, dripping with excitement at the act she's about to perform.  Her hands start massaging, slowly tracing the outer labia, evoking soft moans from her with each caress.  With one hand, she slowly spreads her netherlips apart; moisture leaks copiously, giving her pussy and fingers alike a shiny, slick look.");
        outputText("\n\nOnce she's fully exposed, you gaze inside her pink vulva as it blooms like a flower; a flower that contracts with each moan of pleasure emanating from Ember, as if inviting you to caress it.");
        outputText("\n\nYour earlier promise to behave yourself gets increasingly harder to keep as Ember's show turns you on more and more");
        if (player.gender > 0) {
            outputText("; ");
            if (player.hasCock()) {
                outputText("the bulge inside your [armor]");
                if (player.hasVagina()) outputText(" and ");
            }
            if (player.hasVagina()) outputText("wetness gathering in your own pussy");
            outputText(" more than indicate");
            if (!player.hasCock() || !player.hasVagina()) outputText("s");
            outputText(" your desire to break your promise.");
        }
        outputText("\n\nOne of Ember's clawed fingers slowly penetrates her depths, sinking in all the way to the knuckle and drawing a long throaty moan from her.  She sets upon a steady pace; humming with each thrust inside.  Soon, you realize her pumps are becoming shallower and more erratic, until she removes her finger; the egg's outer shell is visible, coming out of her folds.");
        outputText("\n\nThe pleasure of the act combined with that of exhibiting herself to you in such a vulnerable position nearly disables her, and she groans; feeling too good to simply stop, but too weak to continue. \"<i>[name]!  F-Finish me off!</i>\" she gasps in the throes of passion.");
        outputText("\n\nHoping she won't change her mind about this afterwards, you step forward and begin to stroke and trace your fingers gently across her netherlips, tickling her clit");
        if (flags[kFLAGS.EMBER_GENDER] == 3) outputText(" and caressing her throbbing cock");
        outputText(".");
        outputText("\n\nWith a deep moan, Ember shakes and orgasms.");
        if (flags[kFLAGS.EMBER_GENDER] == 3) outputText("  Ropes of jism spew out of her cock, arching into the air to hit the ground nearby.");
        outputText("  The egg plugs her wet pleasure hole, preventing any liquid from escaping, until finally with a wet, squelching pop,it flies out of her pussy and into your waiting hands; releasing a flood of juices.");
        outputText("\n\nWith a final sigh of relief, Ember collapses, sliding off the rock and onto the dry ground beneath.");
        outputText("\n\nYou appraise the egg briefly, then return your attention to the source.  You can hardly believe that your repressed dragon would actually do something like this; looking at her, sprawling there in the grass with her legs splayed");
        if (flags[kFLAGS.EMBER_GENDER] == 3) outputText(" and her cock hanging out");
        outputText(", it's hard to see her as the same angrily defensive ice queen from before.");
        outputText("\n\nSlowly Ember sits up, licking her lips and panting airily.  \"<i>Phew... I made it...</i>\"");
        outputText("\n\nYou can't resist telling her that she most certainly did, holding her newly laid egg up to admire, then gallantly offering your hand to help her get back up to her feet.  Ember accepts and slowly balances herself, but then, as she holds you wet hand, the memory of how the whole ordeal ended hits her.");
        outputText("\n\n\"<i>Y... y-you... you touched me... my... you touched...</i>\"");
        outputText("\n\nYes, you did, because she asked and she seemed to need your help, as you point out.  Ember doesn't bother coming up with something to say, she just unfurls her wings and jumps into the air with a gust of wind.");
        outputText("\n\nYou shake your head and sigh softly.  ");
        //git an egg, moderate lib-based lust damage, Ember affection up
        inventory.takeItem(consumables.DRGNEGG, explorer.done);
        emberAffection(5);
    }

    //Get Milk
    private function getMilkFromEmber():void {
        clearOutput();
        outputText(images.showImage("ember-drink-her-milk"));
        if (flags[kFLAGS.EMBER_MILK] > 0) {
            outputText("You think for a few moments, then find your gaze drawn to Ember's round, firm");
            if (flags[kFLAGS.EMBER_ROUNDFACE] == 0) outputText(", scaly");
            outputText(" breasts, [ember eir] perky nipples bare as always and enticing you.  With a repressed smile, you ask if [ember ey]'ll let you suckle [ember eir] milk.");
        } else {
            outputText("You think for a few moments, then find your gaze drawn to Ember's round, firm");
            if (flags[kFLAGS.EMBER_ROUNDFACE] == 0) outputText(", scaly");
            outputText(" breasts, [ember eir] perky nipples bare as always and enticing you.  With a repressed smile, you ask if [ember ey]'ll let you suckle [ember eir] milk if you give [ember em] a Lactaid.");
        }
        //Summary:
        //Usable only through Follower menu
        //Restore Health and Fatigue
        //May cause/intensify heat/rut if PC is a dragon-morph
        //Restores the use of the PC's Dragonbreath weapon


        //(Low Affection)
        if (emberAffection() <= 25) {
            outputText("\n\n\"<i>What!?  Why should I let you do that!?  Aren't you a bit too old to be suckling from a teat?</i>\"");
            outputText("\n\nYou tell [ember em] the honest truth; you're thirsty and [ember ey] looks absolutely delicious.  Besides, doesn't [ember ey] feel even the slightest bit pent up?  Aren't [ember eir] breasts simply aching with how full and heavy they are from all the weighty milk sloshing around inside them?  You're offering to help drain them and make [ember em] feel better...");
            outputText("\n\nEmber's face clouds at your comments.  \"<i>They do feel full sometimes... but these are not meant for you!</i>\"  [ember Eir] hands cover [ember eir] breasts protectively.");
            outputText("\n\nYou ask who they are meant for, then - [ember ey] can't drink from them [ember em]self and ");
            //noEmberkids:
            if (flags[kFLAGS.EMBER_EGGS] == 0 && emberChildren() == 0) outputText(emberMF("he", "she") + " has no offspring to feed them with");
            //(1+ EmberEggs:
            else if (flags[kFLAGS.EMBER_EGGS] > 0) outputText(emberMF("his", "her") + " children haven't hatched yet");
            else outputText(emberMF("his", "her") + " children don't drink nearly enough to properly empty [ember em]), so is [ember ey] just going to suffer with [ember eir] breasts so full and aching?");
            outputText("\n\nEmber's eyes sink, deep in thought; finally, with a sigh, [ember ey] concedes.  \"<i>Fine.  But if you do anything weird I swear I'll hit you!</i>\"");
            outputText("\n\nYou promise to behave yourself, and tell [ember eir] to get comfortable so that you can nurse together.");
            outputText("\n\nEmber reclines on a pile of leaves inside her den, back against the wall, then gently drops [ember eir] arms to [ember eir] side.  [ember Eir] distraction deepens as [ember ey] says, \"<i>Let's get this over with, then...</i>\"");
            outputText("\n\nYou approach and seat yourself in [ember eir] lap, gently reaching up to stroke [ember eir] bountiful, milk-filled breasts.");
            outputText("\n\nEmber flinches at the initial contact but remains calm as you continue to touch and caress [ember eir] bosom, feeling the weight and the smoothness of the ");
            if (flags[kFLAGS.EMBER_ROUNDFACE] == 0) outputText("scales");
            else outputText("skin");
            outputText(".  [ember Ey] lets out a cute gasp of pleasure, eyes darting furiously around to look at anything but you. You beam a smile and [ember ey] turns her head away in embarrassment.  \"<i>T-They're not getting any emptier like this, y'know!?</i>\"");
            outputText("\n\nYour ministrations continue unperturbed until [ember eir] nipples perk up and begin to weep the first drops of milk; then, seeing [ember ey] is ready, you gently close your lips around [ember eir] first nipple.  You savor the flavor as it hits your tongue; it's cool and refreshing, crisp and sweet and with a taste you can't quite place... this must be Ember's personal spice.  It's so different from anything else.  It tastes more sweetish, and you pull harder.");
            outputText("\n\n\"<i>Ah!  This feels nice... don't you dare stop.</i>\"");
            outputText("\n\nYou need no further encouragement to bury your face fully into [ember eir] bosom and start suckling in earnest.  Though you can relish the temperature contrast between the two of you with [ember eir] flesh being pleasantly cooler than yours, your focus is on the milk.");
            //(If Ember is male/herm)
            if (flags[kFLAGS.EMBER_GENDER] != 2) {
                outputText("\n\nYou feel something poking your ");
                if (!player.isTaur()) outputText("belly");
                else outputText("back");
                outputText(" and look down at Ember's engorging shaft.  Smiling around Ember's nipple, you start to gently stroke and squeeze the partially-erect draconic dick [ember ey]'s presenting.  If [ember ey]'s enjoying this so much, well, why not make it all the more fun for [ember em]?");
            }
            //(else)
            else {
                outputText("\n\nEmber hums and moans as you continue to suckle; one of her hands slowly snakes its way under you to touch her soft netherlips.  In a moment of boldness, you reach down to push her hand away and stroke her moist folds yourself.  Ember doesn't protest, she just settles down and lets you continue your caresses on the new target.");
            }
            outputText("\n\nSuddenly, as realization dawns, Ember gets up, knocking you flat on your back. \"<i>W-what do you think you're doing!?  I didn't say you could touch me!</i>\"");
            outputText("\n\nYou apologize, but point out that it looked like [ember ey] was enjoying the contact as much as you were enjoying her milk.");
            outputText("\n\nEmber flushes with embarrassment.  \"<i>I-I... That's it!  No more milk for you!</i>\" [ember ey] declares, hauling you upright and shooing you out of her den.");
            outputText("\n\nYou shake your head with good temper.  Still, you got your fill of her milk, and you feel refreshed and renewed, new vitality flowing through your veins.");
            //(PC's D.Breath timer = not ready: Your throat feels soothed as the scratching and soreness die down; you feel like you could shout to the mountaintops!)
            if ((player.hasStatusEffect(StatusEffects.DragonBreathCooldown) && !player.perkv1(IMutationsLib.DrakeLungsIM) >= 2) || ((player.hasStatusEffect(StatusEffects.DragonDarknessBreathCooldown) || player.hasStatusEffect(StatusEffects.DragonFireBreathCooldown) || player.hasStatusEffect(StatusEffects.DragonIceBreathCooldown) || player.hasStatusEffect(StatusEffects.DragonLightningBreathCooldown)) && !player.perkv1(IMutationsLib.DrakeLungsIM) >= 1)) {
                if (player.hasStatusEffect(StatusEffects.DragonBreathCooldown)) player.removeStatusEffect(StatusEffects.DragonBreathCooldown);
                if (player.hasStatusEffect(StatusEffects.DragonDarknessBreathCooldown)) player.removeStatusEffect(StatusEffects.DragonDarknessBreathCooldown);
                if (player.hasStatusEffect(StatusEffects.DragonFireBreathCooldown)) player.removeStatusEffect(StatusEffects.DragonFireBreathCooldown);
                if (player.hasStatusEffect(StatusEffects.DragonIceBreathCooldown)) player.removeStatusEffect(StatusEffects.DragonIceBreathCooldown);
                if (player.hasStatusEffect(StatusEffects.DragonLightningBreathCooldown)) player.removeStatusEffect(StatusEffects.DragonLightningBreathCooldown);
                outputText("  Your throat feels soothed as the scratching and soreness die down; you feel like you could shout to the mountaintops!");
            }
            player.refillHunger(25);
            //(no new PG, PC has dragon-morph status and is opposite Ember's sex:
            if (rand(2) == 0 && player.racialScore(Races.DRAGON, false) >= 4 && player.gender > 0 && (player.gender != flags[kFLAGS.EMBER_GENDER] || (player.gender == 3 && flags[kFLAGS.EMBER_GENDER] == 3))) {
                outputText("  Though, a sudden swell of lust races through your ");
                if (player.hasCock()) {
                    outputText(cockDescript(0));
                    if (player.hasVagina()) outputText(" and ");
                }
                if (player.hasVagina()) outputText(vaginaDescript());
                outputText(", making you wish Ember hadn't run you off.  All you can think about now is fucking [ember eir]; ");
                if (player.hasCock() && hasVagina()) {
                    outputText("filling her womb with your seed and fertilizing her eggs");
                    if (player.hasVagina() && flags[kFLAGS.EMBER_GENDER] == 3) outputText(" even while ");
                }
                if (player.hasVagina() && (flags[kFLAGS.EMBER_GENDER] == 3 || flags[kFLAGS.EMBER_GENDER] == 1)) outputText("taking that hard, spurting cock inside your own " + vaginaDescript(0));
                outputText("... too late, you realize that <b>Ember's milk has sent your draconic body into ");
                if (player.hasCock() && hasVagina()) {
                    outputText("rut");

                    player.goIntoRut(false);
                } else {
                    outputText("heat");

                    player.goIntoHeat(false);
                }
                outputText("!</b>");
            }
        }
        //(Medium Affection)
        else if (emberAffection() < 75) {
            if (flags[kFLAGS.EMBER_MILK] <= 0) {
                outputText("\n\nYou give Ember the lactaid and [ember ey] says, \"<i>Fine.  I'll drink this but be warned, this is only temporary!</i>\" [ember Ey] glares at you and drinks the content of Lactaid. [ember Eir] breasts swell, looking positively milk-filled.");
                player.destroyItems(consumables.LACTAID, 1); //Remove 1 Lactaid
            }
            outputText("\n\n\"<i>Okay.  I guess I can give you a treat... but no funny ideas!</i>\"  That said, Ember walks into [ember eir] den to settle on a pile of soft leaves against the cave wall.");
            outputText("\n\nYou promise to behave yourself, and seat yourself in [ember eir] lap, reaching up to stroke [ember eir] bountiful, milk-filled breasts.");
            outputText("\n\nEmber's eyes widen as [ember ey] gasps in pleasure at your initial contact.  \"<i>N-Not so fast!  At least give me a warning before you start.  They're sensitive...</i>\"");
            outputText("\n\nYou apologize... though now that you know [ember ey] likes this, you can't resist teasing [ember em] by massaging [ember eir] breasts and twiddling [ember eir] nipples in the most arousing manner you can.");
            outputText("\n\nEmber purrs for most of the treatment, and every time your fingers brush against [ember eir] nipples she gasps in pleasure.  \"<i>What are you doing?  Ah!  Are you going to get started or not?  If you keep this up...</i>\"");
            //(if Ember has a dick)
            if (hasCock()) {
                outputText("\n\nYou feel a poke; looking down, you spot Ember's shaft, poking at you.  When you look up again, [ember eir] face goes completely tight with embarrassment.  \"<i>This is your fault!</i>\" Ember declares dryly, trying to hide the fact that [ember ey]'s enjoying this a bit too much.");
            } else {
                outputText("\n\nEmber groans and squirms, and you feel a bit of wetness underneath you.  Reaching down, you feel the moisture that's gathered from her obvious enjoyment of your ministrations.  You look up at her and her face goes tightens with embarrassment.  \"<i>This is your fault!</i>\" Ember declares dryly, trying to hide the fact that she's enjoying this a bit too much.");
            }
            outputText("\n\nYou smile and tell her that you'll take full responsibility.  Deciding you've had enough foreplay for now and seeing that milk has started to seep from [ember eir] flush, aroused nipples, you forego any further conversation by leaning in and capturing the nearest one in your mouth.");
            outputText("\n\nEmber's rumbling purr as you finally get started on your task vibrates your chosen breast; the yielding ");
            if (flags[kFLAGS.EMBER_ROUNDFACE] == 1) outputText("flesh");
            else outputText("scales");
            outputText(" sloshing with their ever-full load.  It appears that the more you drink, the more milk Ember will produce; you don't have time to ponder such things at the moment, though, as the tasty flow of sweet, refreshing dragon milk spilling into your mouth to settle on your hungry belly is all that you can worry about at the moment.");
            outputText("\n\nAt one point Ember's arms encircle you, wrapping you in a soft embrace so very unlike [ember eir] brash personality.  You almost lose yourself in Ember's soft mounds, and from the looks of things; Ember seems to be similarly absorbed in nursing you with [ember eir] breast milk.  You happily give yourself over to [ember eir] desires, burying your [face] in the pleasant coolness of [ember eir] bosom and glutting yourself.");
            outputText("\n\nFinally, however, your appetite dwindles; you have stuffed yourself with as much as you can bear and so you stop suckling, letting [ember eir] nipple pop out between your lips to continue dribbling milk down your face and chest, cuddling into the blissed-out dragon while you have the excuse.");
            outputText("\n\nEmber stops [ember eir] humming and sighs; part in relief and part in disappointment.  \"<i>Done?  Have you had enough?</i>\"");
            outputText("\n\nYou admit to [ember em] that you are full, and thank [ember em] for sharing the generous bounty of delicious milk.");
            outputText("\n\nEmber can't hide the faintest of smiles that graces [ember eir] scaly face.  You yelp softly as you feel a sharp prick against your belly; when you feel it again, you jump out of Ember's lap to reveal the clawed finger prodding you.  \"<i>Payback for teasing me earlier.  And don't think I'll be feeding you my milk everytime you ask,</i>\" [ember ey] finishes, with a small puff of smoke.");
            outputText("\n\nYou can't resist pointing out that [ember ey] certainly seemed eager to let you drink your fill, and you didn't hear any complaining over [ember eir] purring.  Before [ember ey] can rebut that, you turn and leave the dragon in [ember eir] den.");
            outputText("\n\nThe drink you got did you plenty of good; you feel refreshed and renewed, new vitality flowing through your veins.");
            if ((player.hasStatusEffect(StatusEffects.DragonBreathCooldown) && !player.perkv1(IMutationsLib.DrakeLungsIM) >= 2) || ((player.hasStatusEffect(StatusEffects.DragonDarknessBreathCooldown) || player.hasStatusEffect(StatusEffects.DragonFireBreathCooldown) || player.hasStatusEffect(StatusEffects.DragonIceBreathCooldown) || player.hasStatusEffect(StatusEffects.DragonLightningBreathCooldown)) && !player.perkv1(IMutationsLib.DrakeLungsIM) >= 1)) {
                if (player.hasStatusEffect(StatusEffects.DragonBreathCooldown)) player.removeStatusEffect(StatusEffects.DragonBreathCooldown);
                if (player.hasStatusEffect(StatusEffects.DragonDarknessBreathCooldown)) player.removeStatusEffect(StatusEffects.DragonDarknessBreathCooldown);
                if (player.hasStatusEffect(StatusEffects.DragonFireBreathCooldown)) player.removeStatusEffect(StatusEffects.DragonFireBreathCooldown);
                if (player.hasStatusEffect(StatusEffects.DragonIceBreathCooldown)) player.removeStatusEffect(StatusEffects.DragonIceBreathCooldown);
                if (player.hasStatusEffect(StatusEffects.DragonLightningBreathCooldown)) player.removeStatusEffect(StatusEffects.DragonLightningBreathCooldown);
                outputText("  Your throat feels soothed as the scratching and soreness die down; you feel like you could shout to the mountaintops!");
            }
            player.refillHunger(50);
            //(no new PG, PC has dragon-morph status and is opposite Ember's sex:
            if (rand(2) == 0 && player.racialScore(Races.DRAGON, false) >= 4 && player.gender > 0 && (player.gender != flags[kFLAGS.EMBER_GENDER] || (player.gender == 3 && flags[kFLAGS.EMBER_GENDER] == 3))) {
                outputText("  Though, a sudden swell of lust races through your ");
                if (player.hasCock()) {
                    outputText(cockDescript(0));
                    if (player.hasVagina()) outputText(" and ");
                }
                if (player.hasVagina()) outputText(vaginaDescript());
                outputText(", making you wish Ember hadn't run you off.  All you can think about now is fucking [ember eir]; ");
                if (player.hasCock() && hasVagina()) {
                    outputText("filling her womb with your seed and fertilizing her eggs");
                    if (player.hasVagina() && flags[kFLAGS.EMBER_GENDER] == 3) outputText(" even while ");
                }
                if (player.hasVagina() && (flags[kFLAGS.EMBER_GENDER] == 3 || flags[kFLAGS.EMBER_GENDER] == 1)) outputText("taking that hard, spurting cock inside your own " + vaginaDescript(0));
                outputText("... too late, you realize that <b>Ember's milk has sent your draconic body into ");
                if (player.hasCock() && hasVagina()) {
                    outputText("rut");

                    player.goIntoRut(false);
                } else {
                    outputText("heat");

                    player.goIntoHeat(false);
                }
                outputText("!</b>");
            }
        }
        //(High Affection)
        else {
            outputText("\n\nEmber's tail waggles at your request even as she forces a frown, and you swear you can see ");
            if (hasCock()) {
                outputText("the faintest hint of [ember eir] cock ");
                if (internalDick()) outputText("emerging");
                else outputText("hardening");
            } else outputText("small beads of moisture gathering on her honeypot");
            outputText(".  \"<i>Ok... I suppose I could use some help draining myself, but no funny moves!</i>\"");
            outputText("\n\nYou promise that you won't try anything... so long as [ember ey] promises to do the same.");
            outputText("\n\nEmber's frown deepens.  \"<i>Don't be silly!  I would never do that!</i>\" Ember finds a nice spot by the den's wall and plops down on a pile of leaves; then [ember ey] opens [ember eir] arms invitingly and says, \"<i>Come on then, let's get this over with.</i>\"");
            outputText("\n\nWith a wide smile on your face, you approach and seat yourself, noting [ember eir] nipples are already starting to dribble milk.  You wonder if you should play with [ember em] first or just start suckling...");

            outputText("\n\nYou don't need to wonder for long; a not-so-innocent caress on your [butt] is all the direction you could want.  You grin wickedly and start to squeeze [ember eir] impressive bosom, telling [ember em] that [ember ey] must be so proud to be so big and round, and yet so firm, without the slightest hint of sagging or flab in [ember eir] breasts.");
            outputText("\n\nEmber blows a puff of smoke in confidence.  \"<i>Of course I'm proud.  Bet you don't see girls with breasts as perfect as mine.</i>\"");
            outputText("\n\nYou admit you don't, then lean in to kiss [ember eir] seeping nipple, sucking the teat in between your lips and expertly rolling and sliding it between them, tickling its tip and savoring the hints of [ember eir] sweet, cool, naturally-spiced milk.");
            outputText("\n\nBut your focus is on playing with your dragon right now, rather than straightforward drinking, and so one hands creeps purposefully towards ");
            if (hasCock()) {
                outputText(emberMF("his", "her") + " erecting dragon-prick, gently stroking its");
                if (internalDick()) outputText(" strangely ridged, almost scaly");
                outputText(" surface");
            } else outputText("her gently-dripping cunt, sliding in between the lips to stroke the wet interior");
            outputText(".");

            outputText("\n\nEmber's grip on your [butt] tightens sharply.  \"<i>What are you - ah! doing?</i>\"");
            outputText("\n\nWith an innocent look, you start to suckle in earnest, even as your hand continues to ");
            if (hasCock()) outputText("stroke [ember eir] shaft");
            else outputText("probe gently into her slick depths");
            outputText(".  Ember squirms and moans, humming softly, while you suckle and tease, delighting as much in the pleasure you are giving as in the delicious milk cascading down your thirsty throat.");

            outputText("\n\n\"<i>S-so this is how it is, huh?</i>\"  Ember suddenly pulls your head up and delivers a kiss straight to your lips, forcing [ember eir] tongue inside your mouth to lap up [ember eir] own milk.  When [ember ey]'s sure [ember ey]'s got everything; Ember drops you again.");

            outputText("\n\n\"<i>If you're not going to behave, then no more milk for you.</i>\"  The dragon smiles triumphantly.");
            outputText("\n\nRepositioning yourself where [ember ey] dropped you for greater comfort, you smile and adopt your most innocent expression, then go back to your drinking.");
            outputText("\n\nThis time, you focus on simply drinking from Ember's bountiful breast and the wonderful taste of [ember eir] milk.  You don't think you could ever get tired of this... the milk is sweet, refreshing and just a tad spicy.  You can't help but compare how like [ember em] it is.");

            outputText("\n\nThe soft purrs that accompany each suckle and the soft caresses on your body, bringing you ever closer to these two motherlodes of Ember-flavoured treasure, only serve to enhance the whole experience.");

            outputText("\n\nEventually, your swallows of the rich, freely-flowing, creamy dragon-milk cease as your stomach fills up.");
            if ((player.hasStatusEffect(StatusEffects.DragonBreathCooldown) && !player.perkv1(IMutationsLib.DrakeLungsIM) >= 2) || ((player.hasStatusEffect(StatusEffects.DragonDarknessBreathCooldown) || player.hasStatusEffect(StatusEffects.DragonFireBreathCooldown) || player.hasStatusEffect(StatusEffects.DragonIceBreathCooldown) || player.hasStatusEffect(StatusEffects.DragonLightningBreathCooldown)) && !player.perkv1(IMutationsLib.DrakeLungsIM) >= 1)) {
                if (player.hasStatusEffect(StatusEffects.DragonBreathCooldown)) player.removeStatusEffect(StatusEffects.DragonBreathCooldown);
                if (player.hasStatusEffect(StatusEffects.DragonDarknessBreathCooldown)) player.removeStatusEffect(StatusEffects.DragonDarknessBreathCooldown);
                if (player.hasStatusEffect(StatusEffects.DragonFireBreathCooldown)) player.removeStatusEffect(StatusEffects.DragonFireBreathCooldown);
                if (player.hasStatusEffect(StatusEffects.DragonIceBreathCooldown)) player.removeStatusEffect(StatusEffects.DragonIceBreathCooldown);
                if (player.hasStatusEffect(StatusEffects.DragonLightningBreathCooldown)) player.removeStatusEffect(StatusEffects.DragonLightningBreathCooldown);
                outputText("  Your throat feels soothed as the scratching and soreness die down; you feel like you could shout to the mountaintops!");
            }
            outputText("  You tell your dragon that you're finished.  You're up and turning to leave when a looping tail around your waist stops you.");

            outputText("\n\n\"<i>You're not going anywhere just yet.  You still have one other breast to empty.</i>\"  Ember smiles, despite [ember eir] mockingly stern face.");

            if (player.cor < 50) {
                outputText("\n\nYou look at [ember em] and, despite the faint protests from your stomach, reason that you can't disappoint the dragon-" + emberMF("boy", "girl") + ".  Besides, you know what [ember eir] temper is like... you resettle and begin suckling at [ember eir] other breast.");

                outputText("\n\n\"<i>Ah!  That's good...</i>\"  Ember embraces you in a tight hug, bringing you as close to [ember em] as possible.  You smile around your nipple and enjoy the sensation, languidly suckling from [ember em] less out of an honest thirst for the milk and more to prolong your excuse to be so close to your strangely fuzzy dragon.");
                outputText("\n\nBy the time you're done Ember has melted into a purring pile, content with simply letting you sit on [ember eir] lap.  \"<i>Don't think that just because it felt good, I'm going to let you do this whenever you feel like.</i>\"");
                outputText("\n\nYou tell [ember em] you wouldn't dream of thinking that, sneaking an opportunity to kiss [ember em] while [ember eir] guard is so lax.  Even as you do, your stomach begins to gripe, trying and failing to digest the slow-to-process milk before it begins to turn.  You're going to be sick later, that's for sure...");
            }
            //(corrupt jerk)
            else {
                outputText("\n\nOh, of all the... your stomach gurgles in protest as you contemplate drinking twice what you expected.  Not particularly warming to the idea of throwing up as the undigested milk begins to curdle in your gut, you only assume the motions of lowering yourself into Ember's lap again and taking the nipple into your mouth.");
                outputText("\n\nThe milk begins to flow immediately, and you pop the teat out again, to exclamations from your lover.  \"<i>Hey, what did I just say?</i>\" the dragon demands.  \"<i>Finish your drink!</i>\"  Instead, you begin pulling and kneading the breast, pointing the nipple at the ground and milking the dragon for all [ember ey]'s worth.  \"<i>Y-you're wasting it!  Stop it!</i>\"  Despite the protest, Ember moans breathily, just as taken with the work of your hands as [ember ey] was by your mouth.");
                outputText("\n\n\"<i>Now, now,</i>\" you admonish.  \"<i>I couldn't possibly drink all of your bounty; I'm just thinking about the pressure.</i>\"  Dexterously, you twitch at and tweak the little nub, squirting out the milk into a puddle under Ember's butt.");
                outputText("\n\n\"<i>D-don't think I'm okay with you spilling my milk like this,</i>\" [ember ey] retorts, a tear coming to [ember eir] eye at one particularly strong yank.  \"<i>I just... don't want to feel all lopsided and awkward!  It would make me fly funny...</i>\"");
                outputText("\n\nYeah, yeah.  You finish draining the second breast and then lift it, planting a kiss on the sensitized nipple.");
            }
            player.refillHunger(50);
            if (player.tou > 40) player.addCurse("tou", 1, 1);
            //merge wuss and jerk forks
            outputText("\n\nEmber gets so flustered that [ember ey] just stares at you in stunned silence, wearing a goofy smile.  \"<i>Wha... you know, there's no point in saying anything.  I know you'll just sneak another opportunity like this in the future... doesn't mean I won't make you pay for this when I catch you later.</i>\"");
            outputText("\n\nYou whisper into her ear that you're looking forward to it, and gently raise yourself from [ember eir] lap to leave.");
            //(no new PG, PC has dragon-morph status and is opposite Ember's sex:
            if (rand(2) == 0 && player.racialScore(Races.DRAGON, false) >= 4 && player.gender > 0 && (player.gender != flags[kFLAGS.EMBER_GENDER] || (player.gender == 3 && flags[kFLAGS.EMBER_GENDER] == 3))) {
                outputText("  Though, a sudden swell of lust races through your ");
                if (player.hasCock()) {
                    outputText(cockDescript(0));
                    if (player.hasVagina()) outputText(" and ");
                }
                if (player.hasVagina()) outputText(vaginaDescript());
                outputText(", making you wish Ember hadn't run you off.  All you can think about now is fucking [ember eir]; ");
                if (player.hasCock() && hasVagina()) {
                    outputText("filling her womb with your seed and fertilizing her eggs");
                    if (player.hasVagina() && flags[kFLAGS.EMBER_GENDER] == 3) outputText(" even while ");
                }
                if (player.hasVagina() && (flags[kFLAGS.EMBER_GENDER] == 3 || flags[kFLAGS.EMBER_GENDER] == 1)) outputText("taking that hard, spurting cock inside your own " + vaginaDescript(0));
                outputText("... too late, you realize that <b>Ember's milk has sent your draconic body into ");
                if (player.hasCock() && hasVagina()) {
                    outputText("rut");

                    player.goIntoRut(false);
                } else {
                    outputText("heat");

                    player.goIntoHeat(false);
                }
                outputText("!</b>");
            }
        }
        emberAffection(1);
        //reset Dragonbreath counter to ready, increase lust slightly if low or med affection, add heat/rut if high dragon-score, damage toughness slightly if high affection and low PC corruption
        if (emberAffection() < 75) dynStats("lus", 20, "scale", false);
        fatigue(-50);
        player.slimeFeed();
        HPChange(player.maxHP() * .33, false);
        endEncounter();
    }

    //Sparring text outputs (Z) (FENCODED TO HERE)
    //PC shouldn't get gems for this fight, XP shouldn't be a problem with the new level scaled encounter system.
    //Winning gets you affection.
    private function decideToSparEmbra():void {
        clearOutput();
        outputText("You feel like you could use some practice; just to be ready for whatever you stumble upon when adventuring, and ask Ember how [ember ey]'d feel about sparring with you.");
        //(Low Affection)
        if (emberAffection() <= 25) {
            outputText("\n\n\"<i>Ha!  You have to be joking.  We both know you'll end up hurting yourself.</i>\"");
            outputText("\n\nIntent on proving [ember em] wrong, you brandish your [weapon].");
            outputText("\n\n\"<i>Well, if you're so set on being knocked about...</i>\"  Ember leads you to an isolated clearing on the outskirts of the camp and assumes a battle pose.");
        }
        //(Medium Affection)
        else if (emberAffection() < 75) {
            outputText("\n\n\"<i>Are you sure?  I should have you know that I won't be holding back at all!</i>\" Ember warns you, assuming [ember eir] battle stance.");
            outputText("\n\nThat's exactly what you're expecting of [ember em].  You need to get strong, and [ember ey]'s the best sparring partner you could hope for.");
            outputText("\n\nEmber smiles at you.  \"<i>Ha!  Flattery won't earn you any mercy!  So get ready!</i>\"");
        }
        //(High Affection)
        else {
            outputText("\n\n\"<i>Well... don't expect me to go easy on you!  We dragons are very competitive!  And I don't mind beating you up, even if you are my friend!</i>\" Ember warns you, dropping into [ember eir] battle stance.");
            outputText("\n\nYou grin at [ember em] and tell [ember em] to bring it on - you're too psyched up to be caught off guard by the dragon openly calling you a friend.");
        }
        startCombat(new Ember());
    }

    public function beatEmberSpar():void {
        clearOutput();
        if (emberAffection() <= 25) {
            outputText("Ember lies on [ember eir] back, while you stand over the defeated dragon triumphantly.  You extend a helping hand, intent on pulling [ember em] up, but [ember ey] bats it away, flinching in shame at [ember eir] defeat.");
            outputText("\n\n\"<i>I don't need your help you... you... cheater!</i>\"");
            outputText("\n\nCome again?  You won this fight fair and square.  It's [ember eir] own fault for underestimating you.");
            outputText("\n\n\"<i>Yeah, fine!  Maybe I was wrong, but you still cheated!  You attacked me while I was distracted!  That's cheating!</i>\"  Ember doesn't even give you time to answer before getting up and taking wing. \"<i>You won't get so lucky next time!</i>\" [ember ey] calls down to you.");
            outputText("\n\nYou sigh in disappointment; you're not sure why you expected Ember to be less of a sore loser, but you did.  On the bright side, maybe [ember ey]'ll keep that attitude in check from now on...");
            outputText("\n\n\"<i>Argh!  I'll win next time!</i>\" comes the yell from the distance.");
            outputText("\n\nMaybe not.");
            //(+Affection)
            emberAffection(10);
        }
        //Medium affection
        else if (emberAffection() < 75) {
            outputText("Ember lies on [ember eir] back, while you stand over the defeated dragon triumphantly.  You extend a helping hand, intent on helping [ember em] up; [ember ey] takes it.");
            outputText("\n\n\"<i>You won this time... but you just got lucky!  Don't think you'll beat me next time!</i>\"");
            outputText("\n\nYou'd certainly hope [ember ey]'d put up a better fight the next time... or was [ember ey] taking it easy on you just now?");
            outputText("\n\nEmber glares at you.  \"<i>Are you mocking me?  I never hold back!  Ever!</i>\"");
            outputText("\n\nYou smile and strike a pose.  If that's the case, you're certainly getting better.");
            outputText("\n\nEmber snorts a small puff of smoke.  \"<i>Yeah, fine... I still say you got lucky!  If I hadn't been distracted it would be me helping you up!</i>\"");
            outputText("\n\n[ember Ey] puffs again and turns on [ember eir] heels, walking away; although [ember ey] looks mad, the slight bounce to [ember eir] step lets you know that [ember ey] actually enjoyed your little sparring session.");
            //(+ Affection)
            emberAffection(8);
        }
        //High affection
        else {
            outputText("Ember lies on [ember eir] back, while you stand over the defeated dragon triumphantly.  You extend a helping hand, intent on helping [ember em] up; [ember ey] gladly accepts your help.");
            outputText("\n\n\"<i>Okay... I guess you have some skill, after all,</i>\" Ember admits.  \"<i>Next time I'm beating you up, it's a promise!</i>\"  You smile, knowing just how much pride the dragon had to swallow, and tell [ember em] that you'll see what happens when it happens.");
            outputText("\n\n\"<i>Okay, let's go back then,</i>\" Ember says, pulling you close and walking back to the camp with you.");
            emberAffection(5);
        }
        if (flags[kFLAGS.SPARRABLE_NPCS_TRAINING] == 2) {
            if (flags[kFLAGS.EMBER_DEFEATS_COUNTER] >= 1) flags[kFLAGS.EMBER_DEFEATS_COUNTER]++;
            else flags[kFLAGS.EMBER_DEFEATS_COUNTER] = 1;
            if (flags[kFLAGS.EMBER_LVL_UP] < 13 && flags[kFLAGS.EMBER_DEFEATS_COUNTER] >= flags[kFLAGS.EMBER_LVL_UP] + 4) {
                var addToV1:Number = player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * flags[kFLAGS.EMBER_DEFEATS_COUNTER];
                if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers1))
                    player.addStatusValue(StatusEffects.CampSparingNpcsTimers1, 1, addToV1);
                else
                    player.createStatusEffect(StatusEffects.CampSparingNpcsTimers1, addToV1, 0, 0, 0);
                flags[kFLAGS.EMBER_DEFEATS_COUNTER] = 0;
                ++flags[kFLAGS.EMBER_LVL_UP];
            }
        }
        cleanupAfterCombat();
    }

    public function loseToEmberSpar():void {
        clearOutput();
        //Low affection
        if (emberAffection() <= 25) {
            outputText("Panting, you drop your fighting stance and sit on the floor, lifting a hand and saying you've had enough.");
            outputText("\n\n\"<i>Ha!  Like I said, you ended up getting yourself hurt.</i>\"");
            outputText("\n\nYeah, you might have lost this time, but you quietly promise to win, in the future.");
            outputText("\n\n\"<i>I'll be waiting.</i>\"  Ember turns on [ember eir] heels and walks back to [ember eir] den.  You decide to head back as well and rest for a while.");
            //(PC automatically rests and gets some HP back)
            emberAffection(-10);
        }
        //(Lose)
        else if (emberAffection() < 75) {
            outputText("Panting, you drop your fighting stance and sit on the floor, lifting a hand and saying you've had enough.");
            outputText("\n\n\"<i>I warned you.  I fought you with all I had, so it's no surprise that you lost!</i>\" Ember boasts proudly, extending a helping hand to you.");
            outputText("\n\nYou confess your defeat, but smile defiantly and promise next time will be different.");
            outputText("\n\nEmber smiles at you.  \"<i>Ha!  Alright, I'll make you train so you'll be able to keep your promise next time!</i>\"  The dragon turns on [ember eir] heels, and walks away, elated with [ember eir] victory.");
            emberAffection(-5);
        }
        //High Affection
        else {
            outputText("Panting, you drop your fighting stance and sit on the floor, lifting a hand and saying you've had enough.");
            outputText("\n\nEmber rushes to offer you a helping hand, concern written all over [ember eir] face.  \"<i>Are you okay?  Maybe I should've held back a little...</i>\"");
            outputText("\n\nYou shake your head fiercely; you need to get strong, and far better to lose at the hand of a friend than to some lust-mad demonic monster.");
            outputText("\n\nEmber sighs.  \"<i>Okay then... I'll be up for a rematch whenever you want.  Now let's get you back.</i>\" Ember picks you up bodily and walks with you back to the camp.");

            emberAffection(-5);
        }
        cleanupAfterCombat();
        HPChange(player.maxHP() * .33, false);
    }

    //[Catch Anal] - a dragon coq up the date (Z)
    private function catchAnal():void {
        clearOutput();
        outputText(images.showImage("ember-fucks-your-ass"));
        outputText("You contemplate Ember's somewhat dominant streak in bed and ask if [ember ey] feels in the mood to ride your ass.");
        //(Low affection)
        if (emberAffection() <= 25) {
            outputText("\n\n\"<i>What!?  That is just gross!  Not to mention, it'd never fit!</i>\"  Ember doesn't bother waiting for your reply, shooing you out of [ember eir] den.");
            endEncounter();
            return;
        }
        //(Moderate affection)
        if (emberAffection() < 75) {
            outputText("\n\n\"<i>If that's what you really have in mind.  Maybe, just maybe... I can do that for you...</i>\" Ember replies, as [ember eir] cock peeks out");
            if (flags[kFLAGS.EMBER_INTERNAL_DICK] == 1 || flags[kFLAGS.EMBER_ROUNDFACE] == 0) outputText(" of its hiding place");
            outputText(", growing slowly but steadily.");
            outputText("\n\nYou smile at [ember em].");
        }
        //(High affection)
        else {
            outputText("\n\nEmber swallows audibly, [ember eir] cock getting even harder at the idea.  \"<i>Alright... but I'm only doing this for you.  I take no enjoyment in this.</i>\"  Even as [ember ey] replies, the dragon's cock begins throbbing visibly.");
            outputText("\n\nYou tell [ember em] that you understand perfectly, letting [ember em] get away with the obvious lie.");
        }
        outputText("\n\nEmber leads you a short distance away from camp, to a small clearing next to a dried river.  [ember Ey] selects a relatively lush-looking patch of grass and gestures at it.  Eagerly, you disrobe, casually throwing your [armor] aside as you present Ember with an enticing view of your [butt],");
        //PC has balls:
        if (player.hasBalls()) {
            outputText(" testicles swaying lightly as you arch your backside up at " + emberMF("him", "her"));
            if (player.hasVagina()) outputText(" while... ");
            else outputText(".");
        }
        if (player.hasVagina()) outputText(" your " + clitDescript() + " drips with every passing moment.");

        outputText("\n\nEmber greedily drinks in every last inch of your naked body, [ember eir] long tongue sliding out, already oozing with drool, before noisily being slurped back up.  \"<i>Keep in mind, I'm only doing this because you asked; I feel no pleasure from it,</i>\" [ember ey] states, despite [ember eir] raging erection.  Finally done waiting, [ember ey] sashays towards you, tail waving gently behind [ember em], cock bobbing up and down as [ember ey] approaches.");

        outputText("\n\nEmber stops right behind you, gently rubbing the ");
        if (internalDick()) outputText("segmented");
        else outputText("smooth");
        outputText(" length of [ember eir] prick between your [butt] cheeks, letting you feel the refreshing coolness of [ember eir] pre dripping from the tip.  \"<i>This... isn't going to work,</i>\" [ember ey] growls.");

        outputText("\n\n[ember Eir] hands take hold of your butt, squeezing it slowly and firmly, caressing and massaging it with greedy anticipation.  From where you are you can't see what [ember ey]'s doing, but you can certainly hear it.  Soft, wet slurps and smacks emanate from behind you, and you realize the dragon must be licking [ember eir] own cock until it's soaked with gooey dragon-drool.");

        outputText("\n\nYou certainly didn't expect that [ember ey] would take to lubing [ember eir] penis up so... intimately.  Your arousal floods throughout your veins and fills you with giddiness at the thought of being penetrated by [ember eir] saliva-coated cock and swallowing it into your depths.");

        outputText("\n\n\"<i>I guess I can work with it now,</i>\" Ember croons, after slurping the long tongue back into [ember eir] ");
        if (flags[kFLAGS.EMBER_ROUNDFACE] > 0) outputText("mouth");
        else outputText("maw");
        outputText(" and sliding [ember eir] cock meaningfully against your pucker.  \"<i>You sure you want this?  Last chance to back out.</i>\"  As if you're going to turn away now, so close to filling that hunger for a nice, hot cock in your ass.  Rearing your rump up, you show [ember em] that you're ready if [ember ey] is.");

        outputText("\n\n[ember Ey] growls hungrily, and wastes no more time.  Fingers digging deeply into your [butt], [ember ey] forces the glans of [ember eir] shaft through your [asshole] and begins pushing past the opening ");
        //(PC has a virgin/tight asshole:)
        if (player.ass.analLooseness == 0 || player.analCapacity() < 25) outputText(", leaving both of you wincing as the sensitive head of [ember eir] cock struggles to make room for its insertion.  \"<i>I can't believe you really want me to put it here... you're so tight it almost hurts,</i>\" [ember ey] whimpers.");
        //(PC has a loose asshole:)
        if (player.analCapacity() < 50) {
            outputText(", causing you to gasp as [ember eir] ");
            if (internalDick()) outputText("draconic ");
            outputText("dick slips inside of you; stretching you and making you wince a bit in pain as [ember eir] spit rubs off along the interior of your anus.  \"<i>It feels pretty snug... good thing I prepared for this,</i>\" [ember ey] remarks with a gasp of pleasure.");
        }
        //(PC has a gaping asshole:)
        else {
            outputText("; the looseness of your " + assholeDescript() + " gives [ember em] no resistance whatsoever as [ember ey] glides in without trouble.  \"<i>Huh... that was easier than I expected,</i>\" [ember ey] remarks in surprise.  \"<i>What have you been getting yourself into?</i>\"");
        }
        player.buttChange(32, true, true, false);

        outputText("\n\nEmber settles for a slow rhythm, pumping with slow strokes; gently guiding [ember eir] ");
        if (internalDick()) outputText("draconic ");
        outputText("prick in and out, reaching for your deepest recesses to rub on the right spots.");

        outputText("\n\nYou gasp and moan as Ember works into you, feeling [ember em] extending [ember eir] prick to its full length and using that as a way to push [ember emself] ever deeper into your bowels.");
        //(PC has prick:
        if (player.hasCock()) outputText("  You can feel the dragon's member rubbing against your prostate, making " + sMultiCockDesc() + " jump to painful erectness, bubble pre-cum, and drool it down the shaft to pool on the ground.");
        //(PC has cunt:
        if (player.hasVagina()) {
            outputText("  The stimulus is starting to make you wet as well, your [vagina] drooling feminine lubricant ");
            if (player.hasBalls()) outputText("over your [balls]");
            outputText(" to puddle underneath you");
            if (player.hasCock()) outputText(", mingling with your pre to form an ever-growing pool of mixed sexual fluids.");
        }

        outputText("\n\n\"<i>Oh!  I'm going to start moving now...</i>\" Ember says, beginning to pick up the pace and gently rock you with [ember eir] increasingly faster thrusts.  Fuck, wasn't [ember ey] already?  You groan, long and hollow, deep in your throat, savoring the deep probes.  You try to enjoy yourself, to fully immerse yourself in the sensations, but find yourself dissatisfied.  The dragon just can't seem to pick up a proper tempo, and you beg [ember em] to speed things up, to start really giving it to you... you're not made of glass, and you won't break.");
        outputText("\n\nEmber furrows [ember eir] brows.  \"<i>You want it?  Okay, I'll give it to you...</i>\"  [ember Ey] growls - or perhaps purrs?  Finally, you're going to get what you want; you can feel it as Ember rears [ember eir] hips in preparation for [ember eir] brutal assault on you, and true to [ember eir] word, the dragon finally begins pistoning into you, slapping against your butt in a lewd sonata of raw pleasure and ferocious sex.");
        //(if PC has balls:
        if (player.hasBalls()) outputText("  [ember Eir] own balls swing into yours, and every time they connect a shrill wave of pleasure flows through you.");

        outputText("\n\nYou cry out throatily, savoring the sensation of your dragon pounding into you hard and fast.  Ember leans over you, hugging you from behind as [ember eir] hips continue to move with a mind of their own; [ember eir] tongue hangs and [ember ey] pants hotly against your ear.  \"<i>Ugh... so good.  I can't believe how this feels. Ah!... I never expected... Hah!... something like this.  C-come on [name], shake that ass for me.  Show me just how good this feels for you!</i>\"  Ember seems to be losing [ember em]self in the sensation of your [butt].");

        outputText("\n\nYou thrust and grind your rear against Ember's cock, squeezing as best you can with your anal muscles, teasing and wringing... but, still it's not quite right.  You can't keep a smile from your voice as you playfully warn Ember that maybe you'll have to take charge and show [ember em] just how to do you properly.");

        outputText("\n\n\"<i>Yes!!  Show me everything!  I want to see everything, feel everything, know everything about you!</i>\" Ember cries out in response.");

        outputText("\n\nOkay then; ");
        if (silly()) outputText("ASSUMING DIRECT CONTROL.");
        else outputText("time to take control.");
        outputText("  Bunching your muscles, you push up off the ground and against [ember em], trying to knock the dragon over onto [ember eir] back.  As lost in pleasure as [ember ey] is, Ember doesn't even try to fight back, going down with a heavy <i>thud</i>.  \"<i>Ah!  Going to take my little dragon for a ride?</i>\" [ember ey] gasps at you, too excited to care that [ember ey] isn't the one in charge anymore.");

        outputText("\n\nWith a smirk you swivel in Ember's lap, shuddering in delight at the sensations of Ember's dick sliding round inside your depths, until you are face to face with the bucking, writhing dragon.  You reach out and pinch [ember eir] nipples, trailing your fingers enticingly down [ember eir] ");
        if (pregnancy.event > 3) {
            if (flags[kFLAGS.EMBER_OVIPOSITION] == 0) outputText("swollen ");
            else outputText("egg-laden ");
        }
        outputText("belly, and start to rise and sink, pistoning your ass up and down. You have total control over the sex, and you intend to use that.");

        outputText("\n\n\"<i>How does it feel?  Having my cock deep inside you?  I hope I'm good for you... ah!</i>\" [ember ey] gasps.");

        outputText("\n\n\"<i>I don't know; how does it feel to be along for the ride?</i>\" you cheekily remark.");

        outputText("\n\n\"<i>Hah!  Best... ride... ever... ah!</i>\"  Ember grunts lewdly, doing [ember eir] best to piston [ember eir] prick into your greedy ass when you're the one pinning [ember em] down.");

        outputText("\n\nYou grin down at the thrashing dragon and with slow, deliberate motions, you lift yourself up to the point where [ember eir] cock almost pops free... and then, painfully slowly, you grind your hips down [ember eir] thighs until you have swallowed every last one of [ember eir] sixteen inches.  You repeat this again, and then again, wondering with cruel innocence how long it will take before [ember ey] pops [ember eir] cork and blows a nice load of dragon-spunk into your belly.");

        outputText("\n\n\"<i>[name]!  I'm going to cum!  Ah!  Inside this beautiful, wonderful ass of yours!  Oh!  Kiss me!  I want to feel all of you as I take you!</i>\" [ember ey] howls at you, too swept up in the emotion to care about [ember eir] image.");

        outputText("\n\nYou bend down and kiss [ember em] as deeply as you can, flicking your tongue against [ember eir] lips and inviting [ember em] to put [ember eir] own tongue to use.  And all the while, you continue to flex your internal muscles, massaging [ember em] until [ember ey] has no choice but to release...");

        outputText("\n\nYou can see that perfect moment when Ember finally pops; [ember eir] eyes roll back and [ember ey] purrs in joy, sending little vibrations along your throat.  [ember Eir] cock twitches once, twice and then finally distends as it unleashes all of Ember's pent-up seed inside your bowels.  You can even feel [ember eir] balls shrinking with each gob of cum [ember ey] pumps into you, flooding you with [ember eir] enjoyment.");

        outputText("\n\nYou moan and heave at the feeling of dragon spooge surging into you, swelling your belly with Ember's rich, virile load.  The sensation is incredible, and you can't help but orgasm in turn");
        if (player.gender > 0) outputText(", ");
        if (player.hasVagina()) outputText("your cunt gushing feminine lubricant to glaze Ember's belly");
        if (player.hasVagina() && player.hasCock()) outputText(" and ");
        if (player.hasCock()) {
            outputText("your cock ");
            if (player.cumQ() < 250) outputText("spurting gouts of cum onto Ember's upper torso");
            else if (player.cumQ() < 1000) outputText("raining spunk across the supine dragon");
            else outputText("cascading your man-cream across your blissed-out lover until [ember ey] is completely glazed in a sperm coating");
        }
        outputText(".");

        outputText("\n\nEmber hugs you close, enjoying the afterglow");
        if (player.gender > 0) outputText(" and rubbing the results of your own orgasm against you");
        outputText(".  You sink readily into the dragon's embrace, rubbing against [ember em], feeling sleepy and blissful after a good, hard fuck.  Sadly, this moment of respite doesn't last long; you feel a certain discomfort as Ember's body heats up.  Looking up, you see [ember eir] eyes are wide open.  Before you can ask [ember em] what's wrong, [ember ey] knocks you off with a start.");

        outputText("\n\n\"<i>You... y-you... you pervert!  H-how dare you make me say those... those... embarrassing things... and... and... you kissed me!  Just like that!  You pulled my tongue out of my mouth and into yours...  Ugh... Just thinking about it...</i>\"  Contrary to what Ember might be saying, you actually see [ember eir] half-erect cock getting harder as the dragon starts turning [ember em]self back on!");

        outputText("\n\nYou smile languidly; from what you recall, [ember ey] was enjoying it.  Your hand slips between your [legs] to gently swipe up a handful of the draconic seed dripping out of your newly-filled asshole, which you hold out to [ember em].  You certainly didn't fill your belly by yourself.");

        outputText("\n\nEmber makes the best face of disgust [ember ey] can manage.  \"<i>Argh!  I need a bath!  Now!</i>\"  And with a quick spin, [ember ey] dashes off to find a stream.  You watch [ember em] go and smile bitterly; you've grown used to how the dragon behaves and you know [ember ey] really did enjoy [ember em]self, but the act might be getting a bit tiresome.  Grabbing a handful of dried grass, you wipe the worst smears of sexual fluids from your body, redress yourself, and head lazily back to the camp.");
        //(+Affection, minus lust, reset hours since cum, slimefeed)
        emberAffection(6);
        player.sexReward("cum", "Anal");
        dynStats("sen", 3);
        endEncounter();
    }

    //[Blow Ember] - your shipment of dragon dildoes has arrived
    private function suckEmberCock():void {
        clearOutput();
        outputText(images.showImage("ember-give-her-a-blowjob"));
        outputText("You stare at Ember's crotch, imagining the taste of draconic cum on your tongue.  The thought makes you lick your lips in eagerness, and you ask if Ember would enjoy having you suck on [ember eir] cock.");

        //(Low Affection)
        if (emberAffection() <= 25) outputText("\n\n\"<i>Huh... I guess I could do something like that.</i>\"\n\nYou note that, despite the lack of verbal enthusiasm, Ember's shaft is already starting to poke out of [ember eir] groin, but keep it to yourself.");
        //(Medium Affection)
        else if (emberAffection() < 75) outputText("\n\n\"<i>I suppose I would like that... don't think I accept you just because I'm okay with it though!</i>\"\n\nYou bite back a smile and insist you understand; [ember ey]'s just using you for release, that's all.  Wondering at the look of mingled hurt and gratitude in [ember eir] eyes, you ask the inscrutable dragon to lead the way.");
        //(High Affection)
        else outputText("\n\nEven before Ember replies, [ember eir] cock throbs in anticipation.  \"<i>Sure!  I'd love... I mean... I'm okay with this,</i>\" Ember says, trying to hide [ember eir] excitement, despite [ember eir] whole body conspiring against [ember em].");

        outputText("\n\nYou follow your draconic lover, waiting to see where [ember ey] will take you, which turns out to be a simple, dried-up clearing, dominated by a large, lichen-carpeted stump in its center.  Ember releases your hand and heads to the stump, seating [ember em]self on it as imperiously as any " + emberMF("emperor", "empress") + " on [ember eir] throne.");

        outputText("\n\n[ember Ey] spreads [ember eir] legs wide, revealing ");
        if (flags[kFLAGS.EMBER_GENDER] == 1) {
            if (internalDick()) outputText("his single genital slit");
            else outputText("his genitals");
        } else {
            if (internalDick()) outputText("her twin genital slits");
            else outputText("her genitals");
        }
        outputText(", [ember eir] ");
        if (internalDick()) outputText("draconic ");
        outputText("prick already hard and throbbing.  The dragon taps a clawed finger idly on the stump, awaiting your attention.");

        outputText("\n\nYou swiftly strip off your [armor], lest they be dirtied by what you are about to do, approach, and kneel before [ember em], reaching out to gently grasp the erect shaft of [ember eir] cock.  The lewdness of what you're about to do makes a perverse thrill run through you.");
        if (player.hasCock()) outputText("  [EachCock] hardens, spearing aimlessly into the ground in your arousal.");
        if (player.hasVagina()) outputText("  Your [vagina] starts to seep with feminine juices, your [clit] hardening in anticipation as your excitement dribbles down onto the thirsty ground.");

        outputText("\n\n\"<i>J-just get started with it,</i>\" Ember stammers, opening [ember eir] legs wider and breathing heavily.");

        outputText("\n\nYou smile affectionately up at your lover and reach out to stroke the shaft");
        if (internalDick()) {
            outputText(" that is even now springing forth from [ember eir] ");
            if (flags[kFLAGS.EMBER_GENDER] == 3) outputText("first ");
            outputText("genital slit");
        }
        outputText(".  Up and up it rises, until all 16 inches of ");
        if (internalDick()) outputText("dragon ");
        outputText("dick are proudly lancing towards your face, pre-cum gently bubbling from the tip and flowing down its length as you massage and lubricate it for ease of swallowing.  You cast a coy look at the dragon, who is shivering from your ministrations, but stoically refuses to show how much you are affecting [ember em].  Not willing to play any more if [ember ey] isn't willing to cooperate, you open your mouth and start to swallow [ember eir] cock.");

        outputText("\n\nYou take the first three or four inches inside with ease, pausing to run your tongue across the glans and the urethra, savoring the taste of draconic pre-cum; rich and thick and tangy, cool and surprisingly refreshing.  You enjoy the taste for a few long seconds, then press on, swallowing inch after inch.");

        outputText("\n\n\"<i>Rrr... S-stop teasing me and just do this,</i>\" Ember goads you.");

        outputText("\n\nEnthused by [ember eir] obvious enjoyment, you continue, swallowing as much as you can.  At around the six-inch mark, though, you find yourself forced to a halt; Ember's cock is jabbing against the back of your throat and triggering your gag reflex.  You try to calm yourself and breathe deeply, seeing that at least half [ember eir] length is still outside your mouth.");

        outputText("\n\n\"<i>D-don't force yourself.  Don't want you choking on my dick,</i>\" Ember pants, starting to lose [ember eir] cool as the pleasure escalates.");

        outputText("\n\n[ember Eir] words merely spark an ember of pride in your heart; you won't be beaten, not by this dick!  There are monster cocks out there much larger than your little dragon's, after all.  Inhaling as much as you can fit in your lungs, you thrust your head forward, straining to pierce your closing throat until, at last, it pops wetly through into your gullet.  With the head of the shaft already inside your throat, it's easier to continue sliding it in.  Inch by inch you push forward, feeling it stretching out your neck and plunging down, down inside you.  Finally, you find your nose pressed gently into Ember's ");
        if (flags[kFLAGS.EMBER_ROUNDFACE] == 0) outputText("scaly");
        else outputText("soft-skinned");
        outputText(" lower belly");
        if (pregnancy.event > 3) outputText(", though the gravid orb resists you");
        outputText(", and discover a surge of pride in you that you got all sixteen inches of it down.");

        outputText("\n\nLooking up to see Ember's reaction, what greets your straining eyes is a slack-jawed, panting dragon, and [ember ey]'s looking straight at you.  \"<i>You don't know how sexy you look like this...</i>\"");

        outputText("\n\nYou weakly grin around [ember eir] jaw-stretcher of a cock and start to bob your head back and forth as much as you can.  You can feel [ember eir] tip jabbing into what feels like your belly and you try to clench your throat around the inhumanly-long tool, sucking madly on the part still inside your actual mouth.");
        if (flags[kFLAGS.EMBER_GENDER] == 3 && (internalDick())) {
            outputText("  Struck by perverse inspiration, you manage to wriggle your tongue under the base of [ember eir] cock and thrust it into [ember eir] genital slit.  You guide it as deep into the strangely pussy-like orifice as you can, tickling and caressing.");
            //(DemonTongue:
            if (player.tongue.type > Tongue.HUMAN) outputText("  Your inhuman length slithers deeper and deeper inside, and you realize you can feel two rounded objects; [ember eir] balls! You're actually touching the testicles that are normally locked away inside [ember eir] body, except when [ember ey] reaches [ember eir] most aroused states...");
        }

        outputText("\n\n\"<i>Ah!  M-more... touch me more...</i>\" Ember pleads, surrendering to pleasure at your hands.");
        outputText("\n\nYou bob and swallow, slurping on [ember eir] cock and massaging it");
        if (flags[kFLAGS.EMBER_GENDER] == 3) outputText(", your tongue wriggling around in [ember eir] slit");
        outputText(", all for the purpose of having [ember em] deliver that creamy dragon spunk directly into your hungry belly.  You do what you can, but you're not certain how else you can please [ember em] with [ember eir] entire length buried in your throat.  You look up at the dragon with a pleading expression, silently begging [ember em] to take an active hand in matters, or else [ember ey]'ll never get off!");
        outputText("\n\nEmber murmurs with delight and eagerness.  \"<i>If you keep looking at me like that... I don't think I can... mmm... hold back.</i>\"  True to [ember eir] words, you actually feel [ember eir] dick twitch within your hungry maw.  You give your most pleading look; not caring if [ember ey] has to fuck your throat to get off, you just need [ember em] to cum inside you before you pass out!");

        outputText("\n\nFinally, Ember's hands move to your cheeks, rubbing along them as [ember ey] feels every contour, every little curve on your face, and declares, \"<i>Can't hold back!</i>\"  [ember Ey] takes hold of your head and begins forcing you up and down [ember eir] length.  You go limp and allow [ember em] to use you like a living onahole, feeling the dragon piston you back and forth across the cock, struggling to constrict your throat to a properly pussy-like tightness.");

        outputText("\n\n[ember Ey] thrusts with ever-increasing force, bucking and groaning loudly as [ember eir] tongue lolls down across [ember eir] chest.  \"<i>Oh!  Oh!  Gonna... gonna...!</i>\"  [ember Ey] lets out a full-throated bellow and discharges an explosive gout of cum into you.  With [ember eir] cock buried fully into you, you have no choice but to swallow - or, more accurately, let [ember em] discharge stream after stream of jizz directly into your belly.");
        player.refillHunger(50);
        outputText("\n\nGushes of spooge flow into your midriff, which you can feel growing heavier and heavier with the accumulation, your skin stretching into a pregnancy-mocking bulge.  Suddenly Ember pulls you away from [ember em], giving you a mouthful of cum; you do your best to swallow, but can't help but let some of it escape.  Not that it would matter much anyway, because shortly after Ember extracts [ember eir] spewing member from your mouth and paints your face with the last few jets of jism.");

        outputText("\n\nYou simply kneel there and take it, too full and out of breath to do anything about the cum-bath you're getting.  Finally, though, the dragon's overstimulated dick belches its last few blasts of frothy spunk, which land on your face as Ember slumps into [ember eir] seat, panting with exhaustion.  You heave and gasp for air, cum escaping your mouth, sighing in relief as you finally fill your lungs, then cradle your gurgling, sloshing belly, a grimace of discomfort crossing your face at the pressure before you expel a spunk-scented belch.  That feels better.");

        outputText("\n\nYour relief is short-lived, because Ember takes your head in [ember eir] hands and delivers a passionate kiss to your lips, tasting [ember em]self and you as [ember ey] licks the stray gobs of cum that remain.  [ember Ey] releases you with a wet smack, strands of saliva linking your mouth to [ember eirs], while [ember ey] begins licking your face clean of the mess [ember ey] made earlier.");

        outputText("\n\nYou close your eyes and submit to the dragon's gentle ministrations, savoring the close contact as [ember eir] cool tongue glides across your " + player.skinFurScales() + ".  Ember takes [ember eir] time, making sure you're absolutely spotless.  Once you've been cleaned and licked to [ember eir] satisfaction, [ember ey] finally settles down; getting off the stump to lay on the floor and pull you atop [ember em]; hugging you close.");

        outputText("\n\nYou don't quite know why [ember ey] feels like cuddling you after just feeding you [ember eir] cum, but you aren't too inclined to complain.  Still, eventually you realize time is slipping away and so gently try to wriggle out of [ember eir] embrace, playfully telling [ember em] that as much as you like being close to [ember em], you have other things to do.");

        outputText("\n\nEmber opens [ember eir] eyes wide open, and roughly pushes you to the side and off [ember em].  \"<i>W-what did you make me do... my cum... the kiss...  you... you made me lick my own cum off your face!</i>\"");

        outputText("\n\nYou point out that [ember ey] kissed you, not the other way around.  You certainly didn't make [ember em] lick you.  Besides, why should you be the only one who gets to enjoy how [ember ey] tastes?");

        outputText("\n\n\"<i>I need a bath!</i>\" [ember ey] declares hurriedly and dashes off.  You watch the dragon go, ");
        if (player.cor < 80) outputText("amused");
        else outputText("increasingly leery of [ember eir] batty behavior");
        outputText(", then pick yourself up to head back to the camp.");
        //(+Affection, lust, reset hours since cum, slimefeed)
        player.sexReward("cum", "Lips");
        emberAffection(6);
        dynStats("lus", 10 + player.lib / 10, "scale", false);
        endEncounter();
    }

    //Get Blown - put your dick in the knife drawer, it'll be fun! (Z, with reservation)
    private function stickDickInKnifeDrawer():void {
        clearOutput();
        outputText(images.showImage("ember-gives-you-a-blowjob"));
        outputText("Trying to appear confident and a little aloof, you suggest that maybe Ember would be willing to put [ember eir] kinky tongue to work on your cock.");

        //(Low Affection)
        if (emberAffection() <= 25) {
            outputText("\n\n\"<i>Ah.  And... what makes you think I would ever consider that?</i>\"  Ember huffs indignantly and walks away.");
            endEncounter();
            return;
        }
        //(Medium Affection)
        else if (emberAffection() < 75) {
            outputText("\n\n\"<i>No way!  Doing something like that is below me; think of something else!</i>\"  Ember crosses [ember eir] arms, awaiting your reply.</i>\"");
            //Sex menu hooooo
            emberSexMenu(false);
            return;
        }
        //(High Affection)
        else {
            outputText("\n\nEmber looks at your crotch, then back at you; [ember eir] eyes glitter conspiratorially. \"<i>Ok... but only this once!</i>\"");
        }
        outputText("\n\nRealising [ember ey] is looking at you to lead, you indicate [ember ey] should follow you and start heading for the outskirts of camp.  Once you trust you are a safe distance away, you ");
        if (!player.isNaga()) outputText("seat yourself on a conveniently lichen-covered boulder.");
        else outputText("coil up on your serpentine tail and start peeling off the clothes on your lower half, exposing [eachCock] to the air and awaiting Ember's response.");

        outputText("\n\nEmber's eyes glow when [ember eir] gaze sets on your dick");
        if (player.cockTotal() > 1) outputText("s");
        outputText(".");
        var x:Number = player.biggestCockIndex();
        var y:Number = x + 1;
        if (player.cockTotal() > 1) {
            outputText("  [ember Ey] selects the biggest cock and gives it a gentle stroke,");
        } else outputText("  [ember Ey] takes your [cock " + y + "] in hand and begins gently stroking it,");
        outputText(" sniffing your musk with obvious delight.");

        //(if Ember chose a dragon cock)
        if (player.cocks[x].cockType == CockTypesEnum.DRAGON) outputText("\n\n\"<i>Such a magnificent, beautiful cock... it feels powerful... and familiar.</i>\"");
        else outputText("\n\n\"<i>T-this isn't something that I know how to work... but I suppose I could try it... for you.</i>\"");

        outputText("\n\nYou shiver at the sensations of [ember eir] hands on your cock");
        if (flags[kFLAGS.EMBER_ROUNDFACE] == 0) outputText(", the scales on [ember eir] palms producing an indescribable feeling as they slide across your sensitive flesh,");
        outputText(" and unthinkingly blurt out your understanding.");

        outputText("\n\nSatisfied at that, Ember extends [ember eir] tongue, slowly wrapping it around your " + cockDescript(x) + ", an act that makes you shiver as the inhumanly long, prehensile appendage twines around your member like a slick-skinned snake.  [ember Ey] coils it around your shaft expertly, gripping you into a makeshift cock-sleeve.");

        outputText("\n\nLooking down at Ember, you see the dragon wreathed in happiness; [ember ey]'s so focused on [ember eir] task that [ember ey] doesn't even notice you staring.  Using [ember eir] coiled tongue [ember ey] begins jerking you off; the sensation is familiar and yet so alien... it only takes a few strokes before your " + cockDescript(x) + " is glistening with Ember's saliva, and in a particularly pleasurable tug, you moan.  A bead of pre escapes your " + player.cockHead(x) + " and slowly slides down your shaft, until it makes contact with Ember's tongue.");

        outputText("\n\nThe moment [ember ey] tastes you, [ember eir] eyes seem to glow.  In a whip-like motion, Ember pulls [ember eir] tongue back into [ember eir] awaiting mouth, engulfing your " + cockDescript(x) + ".  You gasp as the cool, slick flesh surrounds you, heedless of the sharp teeth whose hard surfaces you can occasionally feel grazing you.  You trust your dragon too much to believe [ember ey] would hurt you.");

        outputText("\n\nEmber sucks you hard, slurping around your shaft with [ember eir] prehensile tongue and cooing with pleasure.");
        if (hasCock()) outputText("  [ember Eir] shaft is already hard as rock, and sometimes you can feel it poke your [feet], smearing small beads of Ember's barely contained pleasure on your " + player.skinFurScales() + ".");
        if (hasVagina()) outputText("  Looking behind her, you see a small pool of her feminine juices has formed; pheromones fly through the air and hit you like a wave, spurring you on, making you feed Ember more of your delicious pre.");

        outputText("\n\nIn a swift move, Ember sucks you as hard as [ember ey] can and releases you with a resounding lip-smack.  You cry out, unsure of what's going on, wordlessly looking towards the dragon and pleading with [ember em] to finish you off; you were just starting to get into things!");

        outputText("\n\n\"<i>Don't worry, [name].  I have no intention of letting you put away this delicious, juicy cock of yours.  I just want to enjoy it to the fullest,</i>\" Ember says dreamily, nuzzling your sensitive member with a lusty grin.");

        outputText("\n\nYou watch with a smile at once aroused and amused, and can't resist stroking [ember em] gently on [ember eir] ");
        if (flags[kFLAGS.EMBER_HAIR] == 0 && flags[kFLAGS.EMBER_ROUNDFACE] == 0) outputText("scaly pate");
        else outputText("hair");
        outputText(", telling [ember em] that [ember ey] certainly has your attention and you're looking forward to finding out what [ember ey] has in mind.");

        outputText("\n\nEmber flicks [ember eir] tongue against your ");
        if (player.hasBalls()) outputText("balls");
        else if (player.hasVagina()) outputText(vaginaDescript());
        else outputText("[cock " + y + "]");
        outputText(" and begins licking you from base to tip in slow, almost torturous, strokes.  \"<i>Mmm.  So tasty...</i>\"  Sparks of pleasure surge up your body from the dragon's ministrations, and you find yourself biting back words because you're not sure if you want [ember em] to go faster or to keep at it like this.");

        outputText("\n\nBy now you're leaking like a spring, and Ember greedily laps up every little drop.  \"<i>Feed me, [name].  I'm sooo thirsty...</i>\" Ember teases you, giving your leaking tip the softest of kisses.  You buck forward, eager to be re-engulfed in the dragon's tantalizing mouth, promising to feed [ember em] everything you have if only [ember ey]'ll keep doing that!  Ember smiles at your promise, and obliges by sucking you back in like a popsicle.");

        outputText("\n\nClawed hands grab at your waist for support as [ember ey] finally begins bobbing [ember eir] head with abandon, intent on milking you of every single drop you're worth.  Your own hands unthinkingly latch onto [ember eir] horns, using them to help pin [ember eir] head in place, thrusting your cock obligingly into Ember's jaws as [ember eir] lips and long, prehensile tongue send ecstasy coursing through you from their efforts to wring you of your seed.");

        outputText("\n\nYou don't have long to wait, and with a wordless cry, you unleash yourself into Ember's thirsty mouth.  As the first jet hits Ember's tongue, [ember ey] cries out in bliss and buries your erupting [cock " + y + "] as far into [ember em]self as far as [ember ey] can.");

        //(Low Cum Amount)
        if (player.cumQ() < 250) {
            outputText("\n\nEmber sucks every single drop of cum out of you, taking you for everything you're worth, drinking it like a thirsty person in the desert.  Even when you feel you've given [ember em] all you can, Ember inserts ");
            if (!player.isTaur()) outputText("a finger");
            else outputText("the thumb of her wing");
            outputText(" into your ass to tickle your prostate, drawing a few last drops out of you.");
        }
        //(Medium Cum Amount)
        else if (player.cumQ() < 1000) {
            outputText("\n\nEmber drinks all you have to offer with a smile.  Once you've given all you can, Ember lets go of you, licking [ember eir] lips as if [ember ey]'d just been fed a treat.  [ember Eir] belly is visibly bulging by the time you have finished.");
        }
        //(High Cum Amount)
        else {
            outputText("\n\nEmber insists on drinking every single drop, even though [ember ey] can barely contain the amazing amount of cum you're pumping into [ember eir] eager ");
            if (flags[kFLAGS.EMBER_ROUNDFACE] > 0) outputText("mouth");
            else outputText("maw");
            outputText(".  For a moment you get the impression [ember ey]'s drowning on your cum and try to pull away, but Ember won't have it; [ember ey] coaxes you back into position with careful encouragement from [ember eir] sharp teeth and continues drinking.  By the time you're done, [ember ey] looks almost pregnant from how distended [ember eir] cum-filled stomach is.");
        }

        outputText("\n\nWith a happy sigh, Ember hugs your midriff and buries [ember eir] head in your belly, licking [ember eir] lips happily.  You sink blissfully into the embrace, savoring the sensations of afterglow.  Lazily, you stroke Ember's head in a sign of affection.  Sadly you don't get to enjoy this for long, [ember ey] suddenly snaps and backs away from you, landing on [ember eir] ass.  \"<i>W-what do you think you're doing!?  Wait a moment... did... did you just make me drink all of your cum!?</i>\"");

        outputText("\n\nYou cast [ember em] an idle look, gently pointing out you didn't make [ember em] drink it.  The thought does cross your mind that it was swallow or let it splatter all over [ember eir] face, but you decide to keep that to yourself.");

        outputText("\n\n\"<i>I-I would never do something like that!</i>\" Ember protests.  \"<i>Never!  I wouldn't be caught dead drinking your tas... I mean, terrible cum!  I can't believe you did that to me!  I need to wash my mouth off!</i>\"   [ember Ey] gets up and dashes away towards the nearest stream.");

        outputText("\n\nYou watch [ember em] go");
        if (player.cor < 75) outputText(" and chuckle; you know [ember ey] loves you, really.");
        else outputText(", folding your arms; [ember eir] dementia is getting worse...");

        //lose lust, reset hours since cum
        player.sexReward("saliva");
        dynStats("sen", -1);
        endEncounter();
    }


    //Pitch Anal - horses are terrible people, so no centaurs unless rewritten (Z)
    private function stickItInEmbersButt():void {
        clearOutput();
        outputText(images.showImage("ember-fuck-her-in-her-buttz"));
        outputText("Your eyes are drawn to Ember's butt like iron filings to a magnet.  Haunted by the temptation to see [ember em] bent over and offering [ember eir] ass to your hungry touch, you ask if Ember would be willing to be the catcher in a bout of anal sex.");

        //(Low Affection)
        if (emberAffection() <= 25) {
            outputText("\n\n[ember Eir] eyes widen.  \"<i>Never!  N-E-V-E-R!  Not even over my dead body!</i>\" Ember exclaims.  The dragon unfurls [ember eir] wings and lifts off, beating the air furiously.");
            endEncounter();
            return;
        }
        //(Medium Affection)
        else if (emberAffection() < 75) {
            outputText("\n\n\"<i>Ewww!  How can you ask something like that of me!?  Think of something else.</i>\"  Ember's protest is emphasized by a small puff of smoke that escapes [ember eir] nostrils, though you can't help but notice [ember eir] nipples getting hard...");
            //TO ZE SEX MENU
            emberSexMenu(false);
            return;
        }
        //(High Affection)
        else {
            outputText("\n\n\"<i>I would, b-but it would never fit... and... and... well, it just won't fit!</i>\" Ember's eyes lock onto your crotch; ");
            if (hasCock()) {
                outputText(emberMF("his", "her") + " stiffening cock");
                if (flags[kFLAGS.EMBER_GENDER] == 3) outputText(" and ");
            }
            if (flags[kFLAGS.EMBER_GENDER] == 2) outputText("her ");
            if (hasVagina()) outputText("dripping pussy");
            outputText(" make it obvious that the idea is at least partially arousing.");
        }
        //(first time and corr < 40)
        if (flags[kFLAGS.TIMES_BUTTFUCKED_EMBER] == 0) outputText("\n\nYou ask if [ember ey]'s really so certain that it won't fit; you're eager to give it a try if [ember ey] is, but you won't push if [ember ey]'s really that scared of the idea...");
        else outputText("\n\nYou ask how [ember ey] can be so certain... could it be [ember ey]'s scared? Because if [ember ey] is, you won't push the issue...");
        flags[kFLAGS.TIMES_BUTTFUCKED_EMBER]++;

        outputText("\n\nAt the mention of the word 'scared', Ember stares at you with renewed fire in [ember eir] eyes.  \"<i>Scared!?  I'm not scared of anything!  Bring it on!</i>\" [ember ey] proudly declares, grabbing your hand and leading you away towards a small clearing nearby.  \"<i>Strip!</i>\" Ember demands, hurriedly.");

        outputText("\n\nYou quickly hasten to obey, undressing yourself and exposing [eachCock] ");
        if (player.hasVagina()) outputText("and [vagina] ");
        outputText("to the dragon.  Once you're fully undressed, you turn to look at Ember, to see [ember em] openly masturbating; [ember ey] pants as [ember ey] strokes [ember eir] ");
        if (hasCock()) outputText("cock ");
        if (flags[kFLAGS.EMBER_GENDER] == 3) outputText("and ");
        if (hasVagina()) outputText("pussy ");
        outputText("with a hand, while [ember ey] suckles on the fingers of the other.");

        var x:Number = player.cockThatFits(emberAnalCapacity());
        if (x < 0) x = player.smallestCockIndex();

        outputText("\n\nOnce [ember ey] sees you're fully stripped, [ember ey] walks over to you and pushes you on the grassy ground with a growl of lust.  The slick digits of one hand find themselves wrapped around your erect " + cockDescript(x) + ", while the others press into Ember's tight pucker, slowly stretching it to accommodate you.");

        //First Time
        if (flags[kFLAGS.TIMES_BUTTFUCKED_EMBER] == 1) {
            outputText("\n\nThe dragon moans softly and growls with more than a hint of nervousness tinged pain; [ember ey] is giving up [ember eir] black cherry to you, after all, so [ember ey] has all the tightness and fear of a virgin.  You promise the dragon that you'll be slow and gentle.");
            outputText("\n\nEmber shoots you a nervous glare, before demanding, \"<i>You won't do anything!  Just sit there and let me handle this!</i>\"  Not keen on starting an argument, you decide to do as [ember ey] says.");
            outputText("\n\n\"<i>I can't believe I have to do this... to do something some humiliating... so weird...</i>\"  With a sigh, you tell Ember that's enough; [ember ey] doesn't have to do anything [ember ey] doesn't want to, you didn't mean to tease [ember em] about being scared.  Ember interrupts you with a clawed finger.  \"<i>Just be quiet.  I... I want to do this... no one tells me what to do!  So if I'm doing this... it's because I want to!</i>\"");
            outputText("\n\nYou smile reassuringly at [ember em], as [ember ey] says that, and decide to let Ember prepare [ember em]self in peace.");
            outputText("\n\nOnce [ember ey] feels ready, the dragon extracts [ember eir] fingers from the puckered rose, now blooming, and turns to you.");
        }
        //(else)
        else {
            outputText("\n\nThe dragon moans softly and growls, stretching [ember em]self once more to take you.  You consider saying something, but remembering Ember's words from the first time, you figure that if [ember ey]'s doing this, then it's because [ember ey] wants to... so you just give [ember em] a reassuring smile.");
            outputText("\n\nTaking notice of your smile, Ember stops [ember eir] preparations.  \"<i>W-what are you smiling about?</i>\"");
            outputText("\n\n[ember Ey] looks cute, getting ready just like for [ember eir] first time.  Ember turns away as the memory returns.  After a few moments of silence, [ember ey] moans once more as [ember ey] resumes working [ember eir] fingers on [ember eir] ass.");
            outputText("\n\nOnce [ember ey] feels [ember ey]'s ready, [ember ey] extracts [ember eir] fingers from [ember eir] puckered rose, now blooming, and turns to you.");
        }
        outputText("\n\n\"<i>Listen up.  You only do what I tell you.  I want to be in complete control of this.  If you try or do anything that makes me hurt later, I swear I'll smack you.  Understood?</i>\"");
        outputText("\n\nYou ");
        if (player.cor < 50) outputText("promise the dragon you understand, and insist you wouldn't dream of doing otherwise; you want this to be good for [ember em], not to cause [ember em] pain.");
        else outputText("nod.");

        outputText("\n\n\"<i>Umm... okay then.</i>\"  Stepping over you, the dragon lifts [ember eir] tail and aligns you with the puckered hole.  Slowly, Ember rubs [ember eir] ass against you, stimulating you to produce a single drop of pre to ease your way in.  [ember Ey] doesn't have to wait long, and with a deep breath, [ember ey] finally lets gravity run its course and your " + cockDescript(x) + " plunges into [ember eir] tight depths.");
        outputText("\n\nYou moan softly as Ember's back passage opens up and swallows you.  Just like the rest of [ember em], it's cooler than it would be for a human, but not so cold as to be unpleasant. It's a kind of peppery, refreshing chill that makes you shudder with delight. You squeeze Ember's ass, gripping tightly and pulling [ember em] fully down your length, struggling to keep from pushing the dragon faster than [ember ey] is comfortable with.");
        outputText("\n\n\"<i>H-hey!  Ah!  I didn't tell you to pull me down!</i>\" Ember protests.");
        outputText("\n\nYou tell the dragon you're sorry, but you can't help it; [ember eir] ass is just so full and round, so deliciously cool and tight - it's utterly irresistible.  You thrust into [ember eir] ass for emphasis, roughly squeezing [ember eir] luscious ");
        if (flags[kFLAGS.EMBER_ROUNDFACE] == 0) outputText("scaly ");
        outputText("cheeks and rubbing the base of [ember eir] long, flexible tail to try and convey just how wild [ember eir] ass is driving you.");

        outputText("\n\n\"<i>Ow!  Okay, okay!  Just stop and give me a moment to adjust at least,</i>\" Ember replies");
        if (flags[kFLAGS.EMBER_ROUNDFACE] == 0) outputText(", panting with lust");
        else outputText(", a blush adorning [ember eir] face");
        outputText(".  You force yourself to remain still, giving the horny dragon a chance to recover from your " + cockDescript(x) + " impaling [ember eir] back passage, savoring the feeling of [ember eir] cool muscles squeezing and rippling around your shaft.");

        outputText("\n\nAfter a few minutes, Ember finally starts to move, stroking you with [ember eir] inner muscles.  ");
        if (hasCock()) outputText("Droplets of pre slide along [ember eir] own shaft and down [ember eir] balls to gather at your belly.  ");
        if (hasVagina()) outputText("Her slick pussy drips rhythmically, wetting your lower body with slick dragon juice.  ");
        outputText(emberMF("His", "Her") + " lusty moans each time [ember ey] comes down on your " + cockDescript(x) + " send a thrill up your spine, and the deep purring emanating from [ember eir] chest is audible enough to give you an idea of how much Ember is enjoying this, despite [ember eir] initial reluctance.");
        outputText("\n\nIt's not the purring, or the tight innards, or the soft moans that finally make you lose control and give in to your basest instincts, it is Ember's face... a look of pure bliss, lust and love [ember ey] shoots your way.  It hits you right in the core of your being.  Your hands fly from Ember's ass to wrap around [ember eir] chest, your fingers beginning to stroke, caress, and gently roll [ember eir] nipples, striving to drive the dragon even wilder with lust as you furiously piston your hips into [ember eir] inviting ass.");

        outputText("\n\nThe surprise over your sudden movement is enough to knock Ember on [ember eir] back; as [ember ey] falls [ember ey] drags you with [ember em], reversing your roles; now it is you who is on top, driving yourself powerfully inside [ember eir] inviting bowels.  Each time your hips slam against [ember eir] butt, [ember ey] squirms in pleasure; each time a loud slap resounds on the clearing, Ember moans.  \"<i>I... ah! didn't... Oh! tell you... Mmm! to start moving!</i>\"");

        outputText("\n\nYou ask if [ember ey] really wants you to stop now, making one last forceful thrust and then slowly, languidly drawing yourself out for emphasis.  You give [ember eir] rump a playful spank; you'd thought that both of you were almost done.  Still, if [ember ey] really wants to stop now...");

        outputText("\n\n\"<i>No!  Don't you dare stop!  Pound my ass raw!  Ah!  I need you!</i>\"");

        outputText("\n\nYou thought that's what [ember ey] would say, and you proceed to give it to [ember em] with everything you have.  You can feel that oh-so-familiar, oh-so-wonderful tightness coiling in ");
        if (player.hasBalls()) outputText("your [balls]");
        else outputText("the base of your spine");
        outputText(", and you groan to Ember that you're going to cum, soon.");

        outputText("\n\n\"<i>Yes!  Cum with me!  Fill me with your hot white seed!  Mark me as yours!</i>\" Ember screams in bliss.");

        outputText("\n\nWell, if that's what [ember ey] wants... with a gasp and a cry, you give in to the feeling, letting the waves of pleasure roll through you and send your cum cascading forth into Ember's waiting bowels.  Your orgasm triggers [ember eir] own and with a roar [ember ey] cums");
        if (hasCock()) outputText(", jet upon jet of spunk arcing over [ember eir] head to paint the ground below");
        if (hasVagina()) outputText("; a veritable gush of juices spews forth from her forgotten love-hole to splash against your lower body and over herself");
        outputText(".  The force of [ember eir] orgasm makes the dragon clench [ember eir] ass, sending waves of renewed pleasure through you.");

        //(Low Cum Amount)
        if (player.cumQ() < 250) outputText("\n\nAll too soon you're spent, but even so you came far more than usual, leaving Ember with a slick, squelching, cum filled rosebud.");
        //(Medium Cum Amount)
        else if (player.cumQ() < 1000) outputText("\n\nYour orgasm lasts far longer than usual, filling Ember's tight little hole to the brim, even to the point of slightly distending [ember eir] belly.");
        //(High Cum Amount)
        else outputText("\n\nYour thunderous orgasm threatens to rip Ember's tender little hole apart as you spew jets of cum with such force that you manage to rock [ember em] back and forth.  Ember doesn't look filled, nor even overfilled; [ember ey] looks like a pregnant mother waiting to give birth anytime now.  As tight as [ember ey] is, [ember ey] still doesn't manage to hold all your cum in, and the backflow escapes [ember eir] ass with tremendous force, to plaster on your lower body and Ember's legs.");

        outputText("\n\nSpent, Ember collapses in a blissed-out heap of fulfillment and satisfaction.  You're not much better yourself and fall over [ember em] with an \"<i>omph</i>\".  Ember pants for a while, before guiding your head up with [ember eir] hands and delivering a kiss straight to your lips.  Surprised, but pleased, you sink into the kiss, stroking [ember eir] cheek for emphasis and letting the contentment roll over the pair of you. Once you break the kiss Ember smiles at you and closes [ember eir] eyes to nap for a bit.");

        outputText("\n\nYou smile at the sleeping dragon and gently extract yourself from [ember em]; then walk off to the nearest stream to wash yourself.  After you are cleaned, you return to where you left Ember.  You're met with a surprise when you see [ember em] hugging [ember eir] knees and rocking slowly, and... is [ember ey] humming?  Slowly you approach and [ember ey] looks at you with a smile, but after realizing just who you are, [ember ey] gasps and [ember eir] face turns into a frown.");

        outputText("\n\n\"<i>[name]!!  You... after I told you... you still...  Dammit, I'm going to be sore for days... it's all your fault!</i>\"");

        outputText("\n\nYou confess that you are partially to blame for it, but point out Ember wanted this just as much as you did, if not more.");

        outputText("\n\nEmber snorts a puff of smoke.  \"<i>Oh yeah!?  So you're not going to even take responsibility?  Fine!</i>\"");
        outputText("\n\nYou point out you're not saying that, just that Ember also has responsibility here.");
        outputText("\n\n\"<i>I don't need to hear any more!</i>\"  Ember gets up and pushes you with [ember eir] tail, hefting a pile of folded clothes.  In fact... that pile is quite familiar... actually... that's your [armor].");
        outputText("\n\n\"<i>And I even picked these up for you... Well, you can do it yourself!</i>\"  Ember begins tossing your clothes around in random directions, you ");
        if (player.str < 70) {
            outputText("desperately try to grab any of the flying pieces, but Ember keeps you pinned with [ember eir] tail");
            outputText(".");

            outputText("\n\n\"<i>That ought to teach you!</i>\" [ember ey] declares with a confident puff of smoke, turning on [ember eir] heels and walking away... rather awkwardly at that.  You feel like you should point out that the results of your earlier activities are still dripping out of [ember eir] ass as [ember ey] heads back to the camp, but figure you'll stay quiet lest you aggravate the matter.  Plus, it's payback for tossing your clothes.");
            outputText("\n\nYou sigh, wondering why Ember has to be so temperamental, and start gathering your clothes to return to camp with them. It takes a minute or two, but [ember ey] didn't really put any effort into scattering them, and you know it could have been worse.");
        }
        //(else str >=80)
        else {
            outputText("grab [ember eir] tail, pulling the dragon off [ember eir] feet and throwing [ember em] to the ground as you roll over... and causing [ember em] to drop them everywhere as [ember ey] falls.");
            outputText("\n\nEmber yelps, thrashing and struggling back to [ember eir] feet.  A gobbet of white drops to the ground from between [ember eir] cheeks, forced out by the tumble, and the dragon freezes in place.  You smile wryly.  ");
            /*OLD
				 \"<i>Asshole!  Bite me!</i>\" " + emberMF("he","she") + " shrieks, turning hurriedly toward the stream.");
				 outputText("\n\nWhat a " + emberMF("bastard","bitch") + ".");*/
            //New
            outputText("\"<i>What do you think you're doing!?</i>\" Ember yells at you, obviously mad at your little stunt, one hand reaching behind to prevent any more cum from spilling.");
            outputText("\n\nYou tell [ember em] that you don't feel in the mood to play [ember eir] little game today; [ember ey] really needs to work on that temper of [ember eir], or one day [ember ey] might bite off something more than even [ember ey] can chew.");

            outputText("\n\nEmber growls at you, and for a moment you think [ember ey]'s going to yell at you, but to your surprise [ember ey] averts [ember eir] gaze and utter a barely audible. \"<i>Sorry...</i>\"");

            outputText("\n\nYou sigh softly and nod your head; it's not much, but with as proud as [ember ey] is, that's quite an admission. You tell [ember em] it's alright, but [ember ey] still shouldn't get so upset when [ember ey] enjoyed it as much as you did.");

            outputText("\n\nEmber shudders as you finish talking and blows a puff of smoke, then turns around and hurries away to the nearest stream. You just watch [ember em] go, plugging [ember eir] used rosebud with a finger, you make note of [ember eir] awkward stride, somehow... [ember ey] didn't seem that angry as [ember ey] left...");
        }
        player.sexReward("no");
        dynStats("sen", -2);
        endEncounter();
    }

    //Eat Ember Out - b-baka! (Z)
    private function slurpDraggieCunnies():void {
        clearOutput();
        outputText(images.showImage("ember-eat-out-her-vagoo"));
        outputText("You contemplate the possibilities, and then offer to get down on your knees before the dragon and pleasure her orally.  You would love to have a taste of some dragon juice.");

        //(Low Affection)
        if (emberAffection() <= 25) {
            outputText("\n\n\"<i>I suppose I could enjoy that... barely,</i>\" Ember replies, trying to hide her obvious excitement.  \"<i>But don't think you'll be getting any points ");
            if (!silly()) outputText("with me");
            else outputText("on my affection meter");
            outputText(" just because you're offering to do this,</i>\" the dragon hastily adds.");
        }
        //(Medium Affection)
        else if (emberAffection() < 75) {
            outputText("\n\nEmber's claws move to tease at her netherlips, as she imagines you kneeling in front of her, pleasuring her.  \"<i>F-fine, if you really want to do that...</i>\" Ember replies, trying to sound casual despite her moistening honeypot");
            if (hasCock()) outputText(" and slowly hardening shaft");
            outputText(".");
        }
        //(High Affection)
        else {
            outputText("\n\nThe mere suggestion of what you're offering is enough to make Ember nearly juice herself with anticipation.  Ember quickly covers her nethers, trying to hide her dripping love hole");
            if (hasCock()) outputText(" and shaft");
            outputText(".  \"<i>Ok... I suppose I would like that,</i>\" Ember replies, trying to calm herself down, lest she seem too excited by the idea.");
        }

        outputText("\n\nEmber takes your hand in hers and leads you away to a secluded spot beyond the bushes; once she's sure you're both alone, Ember leans back against a nearby tree for support, and opens her legs to give you access to her blooming, moist flower.");

        outputText("\n\n\"<i>A-alright... I'm ready,</i>\" Ember says, tail swinging like a pendulum behind her as she awaits your next move.");

        outputText("\n\nYou settle in between her legs, and bend in to reach her folds.  From here, you are in a great position to gently swish your tongue up the length of her slit, starting from way back between her legs and then trailing gently forward to caress her joy-buzzer, pushing up between her lips to tickle the interior of her womanhood.");
        if (hasCock()) outputText("  With Ember's cock jutting out above your head, you can't resist sliding your tongue along the underside of her shaft, just for an extra teasing motion.");

        outputText("\n\nEmber gasps in pleasure and her legs buckle for a moment, though she quickly recovers by digging her claws into the tree bark.  \"<i>Y-you could have at least warned me you were going to start!</i>\" Ember says, ");
        if (flags[kFLAGS.EMBER_ROUNDFACE] > 0) outputText("blushing all the while and ");
        outputText("panting from the stimulation.");

        outputText("\n\nYou look up at her as best you can around her heaving bosom and give her an innocent smile, then turn right back to the task at tongue.  This bitch is yours now.  You slide across her folds, caressing her with all the oral skill you can muster; her juices are starting to flow now, allowing you to catch them and savor them with each lick.");
        if (hasCock()) outputText("  You think droplets of pre are starting to slide down her girl-cock and drip onto your head... but that's part and parcel of loving a herm, so you pay it no attention.");

        outputText("\n\nEmber's enjoyment is very apparent, as each time you even breathe over her little pleasure bud, Ember bucks against you; her vaginal walls contract in hopes of gripping your tongue and pulling it deeper inside her, but your saliva combined with the ever-flowing dragon juice keeps it slick enough that Ember doesn't have a chance in heaven of holding your tongue back.  \"<i>Hmm... Ah!  A little more to the left...</i>\" Ember directs you.");

        outputText("\n\nYour tongue bends with all of the ");
        if (player.tongue.type > Tongue.HUMAN) outputText("inhuman ");
        outputText("flexibility you can muster, wriggling into the dragon's depths and trying to caress and stroke every last one of her most intimate places.  At one point in your exploration of Ember's quivering depths, you discover a special spot, and every time you make contact with that little spongy spot Ember rewards you with a buck and renewed gush of fluids.");

        outputText("\n\n\"<i>Ah!  If you keep doing this I'm going to- Oh!</i>\" Ember gasps, tongue lolling out as she loses herself in the pleasurable sensations you're oh-so-responsible for.  You continue to wriggle and undulate your tongue, stroking that special point with as much care as you can manage");
        if (hasCock()) outputText(", heedless of the steady rain of pre dribbling into your " + hairDescript() + ".  You're confident she'll crack soon...");

        outputText("\n\nEmber suddenly grabs your head and pushes you away, stumbling on shaky legs as she turns to brace herself against the tree, her tail missing your head by a couple inches.  \"<i>G-give me a moment to catch my breath... if you keep that up I'll... I'll...</i>\"  Ember doesn't finish her thought and just stays there, with her tail aloft, giving you a wonderful vision of her sopping wet pussy, just begging for another lick.");

        outputText("\n\nYou can't resist.  Even as Ember's tail flicks back and forth overhead, you sneak up behind her, reaching up with your hands to caress her shapely handful of asscheeks even as you plunge your tongue straight into her honey-dripping flower.");

        outputText("\n\nEmber's throaty moan devolves into a roar of intense pleasure as her tail loops around your neck, not constricting nor choking you, just helping the dragon stabilize herself as she is rocked by her intense orgasm and rewards you with a bountiful helping of sweet dragon juice.");
        if (hasCock()) outputText("  Her throbbing shaft, not intending to be left out of the fun, records the event by marking the tree bark with white dragon spooge.");

        outputText("\n\nSlowly Ember crumbles, her legs no longer able to hold her up; her claws dig long scratching marks on the tree as she falls to her knees and the tail around your neck slithers sensually, massaging you.  Finally with a gasp and sigh, Ember falls on her back, gazing up at you through half-lidded eyes; you gasp in surprise as the tail suddenly grips your neck and pulls you down for an upside-down kiss.  Ember doesn't seem to mind tasting herself as she licks around inside your mouth and then your face.");

        outputText("\n\nYou wait until she takes her tongue out of your mouth and smile at her, then stroke her cheek and ask if it was good for her.  \"<i>The best...</i>\" Ember whispers airily.  You smile and bend down to kiss her again; there's a risk she'll give you a nip for presumption, but you favor the odds she'll let you get away with it.");

        outputText("\n\nAt first Ember leans into the kiss, exploring your mouth yet again... but at one point her eyes go wide and she quickly breaks the kiss, scrambling to her feet and glaring at you.  \"<i>W-who said you c-could kiss me!?");
        if (silly()) outputText("  My meter's not that full!");
        outputText("</i>\"");

        outputText("\n\nYou ask if she's the only one who gets to initiate the kiss.  Realization dawns on the dragon's face when she recalls the earlier kiss.  \"<i>That... that was... you!  You tricked me!  H-how could you do that?  I'm leaving!</i>\" Ember blurts out, rushing off.");

        outputText("\n\nYou watch her go and smile, licking your lips to savor the last few drops of her nectar.  She really should learn to relax; it would make things much more enjoyable all around.  Idly rubbing your own ");
        if (player.hasCock()) outputText("stiffened shaft");
        if (player.gender == 3) outputText(" and ");
        if (player.hasVagina()) outputText("moist cunt");
        if (player.gender == 0) outputText("empty crotch");
        outputText(" in sympathy, you head back to camp.");

        //Moderate lust gain and slimefeed, ala blowing Urta or drinking Lover Urta's fluids at Tel'Adre*/
        player.sexReward("vaginalFluids");
        emberAffection(6);
        dynStats("lus", 10 + player.lib / 10, "scale", false);
        endEncounter();
    }

    //Get Eaten Out - actually halfway likeable
    private function getEatenOutByEmbra():void {
        clearOutput();
        outputText(images.showImage("ember-eats-your-vagoo-out"));
        outputText("You think about Ember's long tongue and the many advantages it must have, when you suddenly get an idea of what you'd like to do. You ask Ember if [ember ey]'d be willing to put that tongue of [ember eirs] to use and eat you out.");
        //(Low Affection)
        if (emberAffection() <= 25) {
            outputText("\n\n\"<i>No way!  I have no idea what's been there!  Plus, that is just gross!</i>\"  Ember spins on [ember eir] heels and walks away.");
            //End scene
            endEncounter();
            return;
        }
        //(Medium Affection)
        else if (emberAffection() < 75) {
            outputText("\n\n\"<i>I'd rather not.  Why don't you think of something that would make both of us feel good?</i>\" Ember suggests, surprisingly calm.");
            //Display other Ember sex options
            emberSexMenu(false);
            return;
        }
        //(High Affection)
        else outputText("\n\n\"<i>I guess I could do that... if you asked nicely...</i>\" Ember replies, although [ember eir] body language suggests [ember ey]'s quite eager to get a taste of you.");

        outputText("\n\nYou decide to play along and politely ask if [ember ey] will pleasure your womanly flower with [ember eir] long, nimble, draconic tongue, giving [ember em] a smouldering look and a flirtatious wriggle of your [hips].  Ember swallows nervously as [ember ey] looks at your teasing form.  \"<i>Since you asked so nicely... okay then... come with me.</i>\"  [ember Ey] grabs one of your hands and drags you away hurriedly to a more private setting.");
        outputText("\n\nOnce Ember is satisfied you won't be spied on, [ember ey] turns to look at you, drinking in your body, appraising you with a mixture of reverence and desire.  Ember opens [ember eir] mouth to say something, but words fail the dragon and [ember ey] ends up just breathing airily.  Closing the distance between the two of you, Ember kneels before you and begins undoing your [armor], peeling the lower parts off your body with shaky hands.");
        outputText("\n\nYou watch [ember em], visibly shivering with excitement, and spare the dragon a predatory grin, thinking to yourself that this is certainly not how the tales of dragons and maidens went back in the village.  Confidently, you strut towards a tree and position yourself before it, leaning back against it for support");
        if (!player.isNaga()) outputText(" with your [legs] spread wide");
        outputText(", displaying your [vagina].  You tell Ember that [ember ey]'ll need to make the next move from here, smiling as you do so.");

        outputText("\n\nThe dragon crawls towards you and gently brings [ember eir] nose closer to your moistening snatch, catching a whiff of your feminine scent");
        if (player.hasCock()) outputText(", as well as the musk emanating from your drooling cock");
        outputText(".  Ember's eyes close as [ember ey] savors your scent, committing it to memory and licking [ember eir] lips in preparation for the task ahead.");

        outputText("\n\nFinally deciding to get about [ember eir] task, the dragon licks your moist slit from top to bottom, stopping briefly to kiss your [clit].  \"<i>So good...</i>\" you hear Ember whisper, before [ember ey] suddenly plunges [ember eir] tongue inside your warm depths, exploring every nook and cranny, much to your pleasure.");

        outputText("\n\nYou shudder and moan, feeling your juices dribble from your womanhood onto the dragon's tongue");
        if (player.hasCock()) outputText(", and pre-cum beginning to bubble out of " + sMultiCockDesc());
        outputText(".  You wriggle in delight, praising Ember's skill with [ember eir] tongue and begging [ember em] to keep going.");

        outputText("\n\nEmber presses on, nudging your pleasure button with [ember eir] nose and wrapping your [vagina] with [ember eir] ");
        if (flags[kFLAGS.EMBER_ROUNDFACE] == 0) outputText("maw");
        else outputText("mouth");
        outputText(", kissing your contracting box as if it were a long-lost lover, pushing [ember eir] tongue ever deeper inside you, as if intent on reaching your womb.");

        outputText("\n\nYou howl and cry, writhing as your dragon busily devours your womanhood, and find yourself sliding to the ground so you can wrap your [legs] around Ember's neck and pull [ember eir] face right up against your cunt.  Desirous as you are to feel the dragon fill you with that long, squirmy wet tongue of [ember eirs], you command [ember em] to lick deeper.");

        outputText("\n\nThere is no protest, only compliance as Ember's tongue begins batting against your cervix, demanding entrance into your innermost sanctuary.  You try to hold out, but it's a losing battle; Ember's tongue is like a wonderfully long, thin cock, prehensile and with its own natural lube to boot.  You cry out as orgasm rocks you, ");
        if (player.wetness() >= 4) outputText("spattering");
        else outputText("drenching");
        outputText(" Ember's face with your feminine honey");
        if (player.hasCock()) outputText(" even as " + sMultiCockDesc() + " belches cum all over the preoccupied dragon");
        outputText(".");

        outputText("\n\nYour juices flow into Ember's waiting mouth, guided by the dragon's tongue, and [ember ey] is only too happy to drink, trying [ember eir] best not to waste even a single drop.");
        if (player.wetness() >= 4) outputText("  However, your squirting spatters make this an impossible task.  Ember doesn't seem to care, even as [ember eir] face is completely covered in femcum.");

        outputText("\n\nFinally, with a few last groans and hollow moans, you slump down, completely spent.  Your [legs] release Ember's neck as your muscles are overwhelmed by the glorious numbness that comes of being very well fucked.  Weakly, you compliment Ember on [ember eir] skills at eating pussy.");

        outputText("\n\nEmber licks [ember eir] own face as best as [ember ey] can, making sure [ember ey]'s completely clean.  Your compliment brings a soft glow of pride to Ember's eyes and [ember ey] shoots you an embarrassed look.  \"<i>Umm... thanks, I guess.  Just don't get used to it!</i>\" [ember ey] adds in a renewed burst of defiance, before turning to leave.");

        outputText("\n\nYou idly tell [ember em] that you certainly hope not to get used to it; it wouldn't be fun any more if you did.  Ember turns around to snort a puff of smoke in your direction indignantly before continuing on [ember eir] way.");

        outputText("\n\nYou smile, hating to see [ember em] go, but so loving to watch [ember em] leave.  Shaking off your pleasurable fantasies, you manage to pull yourself back upright, redress yourself, and return to camp.");
        //minus some fukkin' lust, reset hours since cum
        player.sexReward("saliva");
        endEncounter();
    }

    //Penetrate Her - seems not to accommodate centaurs, more's the pity (Z)
    private function penetrateEmbrah():void {
        clearOutput();
        outputText(images.showImage("ember-fuck-her-in-the-vagoo-with-your-penor"));
        //Besides emptying the PC's lust, this scene is also capable of increasing Cum output, I'll leave the decision of how much and how far the threshold should go to you Fen.
        //Don't know if you should make this increase libido. Probably not unless one of Ember's scenes is able to reduce it as well
        outputText("Your eyes are drawn to the dragon's crotch, and you ask if she has any feminine itches she'd like scratched.");

        //(Low Affection)
        if (emberAffection() <= 25) {
            outputText("\n\n\"<i>By you?  Ha!  Funny joke!</i>\"  Ember laughs forcibly as she walks away.");
            endEncounter();
            return;
        }
        //(Medium Affection)
        else if (emberAffection() < 75) {
            outputText("\n\n\"<i>I might... what's it to you?</i>\"  She turns away, as if to give you the cold shoulder - but continues looking at you expectantly.  You gracefully offer to help, if Ember is in the mood for a little carnal relief.  She averts her gaze, and shakes her head.  \"<i>N-no... such a thing...!</i>\"  Looks like the chink in her scaly armor isn't that wide yet, even if... well, even if it is that wide, and drooling moisture.  Metaphorically, of course.");
        }
        //(High Affection)
        else {
            outputText("\n\nYou can see Ember's vagina moisten");
            if (flags[kFLAGS.EMBER_GENDER] == 3) {
                if (internalDick()) outputText(" and her cock peek out of its protective slit");
                else outputText(" and her cock begin hardening");
            }
            outputText(" in anticipation.  \"<i>Yeah... maybe... why do you ask?</i>\"");
        }
        //(First Time)
        if (flags[kFLAGS.EMBER_PUSSY_FUCK_COUNT] == 0) {
            outputText("\n\nEmber's tail slips into her hands, and she twists it nervously.  \"<i>I can't... I mean, I've never... and you...</i>\"  Ember seems at a loss for words; could she have been holding onto her virginity?");
            outputText("\n\nJudging by her reaction, it's clear you're spot on.  \"<i>S-so what if I am!?</i>\"  You sigh.  Some nervousness is to be expected if that's the case, but Ember's temperament only makes things harder... looking at her, it's clear she wants this, judging by the behavior of her nethers.");
            outputText("\n\nYou take Ember's hand in yours and promise her that you will be gentle; that she has nothing to fear.  Sure, it might hurt a bit at first, but after you get started it will be great.  Ember looks deeply into your eyes.  \"<i>You promise?</i>\"  You assure her again.  \"<i>O-ok then... I guess I can give you my... maidenhead.</i>\"");
            outputText("\n\nSadly, it doesn't take long for her deranged temperament to take over.  \"<i>B-but I'm not doing this because you're special... or sexy... and I haven't dreamed about this!  Not even once!</i>\"  You roll your eyes as Ember goes on.");
            if (player.cor > 75) outputText("  As if bitches like her could qualify as maidens in any but the most literal sense.");
            outputText("\n\n\"<i>I hope you understand the honor you're being given.  To take my maidenhead... you're lucky you happened to be near when I was in the mood.</i>\"  This side of Ember is ");
            if (player.cor <= 75) outputText("cute... but very troublesome");
            else outputText("irritating as hell");
            outputText(".  You wonder if you should tease her; it's quite obvious by her rather lengthy monologue that the idea of doing this with you has crossed her mind more than once... but since it's her first time you figure you'll just give her a break.  You tell her you understand and that you're honored, then wait patiently for her next move.");
        }
        outputText("\n\nEmber scratches the back of her neck in thought, although you're pretty sure she's already made her decision.  \"<i>Okay then... I suppose you'll have to do...</i>\"");

        outputText("\n\nYou smile at her, waiting for her initiative. \"<i>Ok, then. Let's not waste any more time!</i>\"  Ember grabs your hand and leads you away.");

        outputText("\n\nWhen you arrive at your destination you realize you're in a small clearing; there doesn't appear to be any creature nearby and the only sound you hear is the faint splashing of a nearby stream.  Ember turns to you and quickly looks you over.  \"<i>C'mon, why are you still dressed!?  I thought you wanted to have sex; don't make me wait!</i>\" Ember demands impatiently.");

        outputText("\n\nYou ");
        if (player.cor < 50) outputText("hasten to undress yourself for the impatient dragoness, quickly pulling");
        else outputText("languidly denude yourself, making sure to exaggerate every movement as you pull");
        outputText(" off your [armor] until you are standing naked before her, letting her see what you have to offer in terms of phallic delights.");

        var x:Number;
        //If the PC is too big
        if (player.cockThatFits(emberVaginalCapacity()) == -1) {
            outputText("\n\nEmber looks at your [cocks], then touches her pussy in thought.  Finally, she growls in exasperation.  \"<i>");
            if (player.cockTotal() == 1) outputText("It doesn't ");
            else outputText("None of them ");
            outputText("fit!</i>\"");

            outputText("\n\nYou ask if she's certain that it's too big. Shouldn't you at least try?");

            outputText("\n\n\"<i>I know my body better than anyone else... and if you put ");
            if (player.cockTotal() == 1) outputText("that... that... monster inside me,");
            else outputText("any of those... those... monsters inside me,");
            outputText(" you'll tear me apart!</i>\"  Ember finishes by exhaling a puff of smoke in frustration... clearly she wants this as much as you.");

            outputText("\"<i>Find some way to shrink ");
            if (player.cockTotal() == 1) outputText("that");
            else outputText("those");
            outputText(" and then come back!</i>\"  Ember turns on her heels and walks away, moodier than usual.");
            endEncounter();
            return;
        }
        //(else if PC has multiple fit cocks){
        //as usual take the biggest one that fits, unless...
        //If the PC has a fit dragon cock, always take that one!
        x = player.cockThatFits(emberVaginalCapacity());
        if (x < 0) x = player.smallestCockIndex();
        if (player.cockThatFits(emberVaginalCapacity()) >= 0 && player.cockThatFits2(emberVaginalCapacity()) >= 0) {
            outputText("\n\n\"<i>You have quite a selection, but I only need one... this one!</i>\" Ember says, taking your " + cockDescript(x) + " in her hand and stroking it into a full erection.");
        }
        //(if PC has a dragon cock)
        if (player.cocks[x].cockType == CockTypesEnum.DRAGON) {
            outputText("\n\n\"<i>What a wonderful tool you have... I guess this might just be good enough to make me orgasm,</i>\" Ember remarks, admiring your dick.");
            outputText("\n\nYou can't resist smiling and noting that Ember always seems to like that one best.  Perhaps because of the familiarity.");
            outputText("\n\n\"<i>Actually I'd be fine with anything you... no wait, I mean...  Of course!  It's only right for a dragon to like a dragon's cock!</i>\"  Ember replies.");
        } else {
            outputText("\n\nEmber takes your " + cockDescript(x) + " in her hand and begins gently stroking you to full mast.  \"<i>I hope you know how to use this,</i>\" Ember remarks.");
            outputText("\n\nYou assure her that you know exactly what you're doing. ");
        }
        outputText("\n\nDeciding it's better for the dragon to psyche herself up first, you wait patiently; it doesn't look like it will be long before she makes the first move.  Ember's hands roam all over your " + cockDescript(x) + " and you think you can almost hear a faint purring emanating from her chest.  Slowly one of her hands reaches down to massage her moistened netherlips.  Ember gasps in pleasure as she continues masturbating both of you in a daze, until she suddenly snaps out of her trance.");

        outputText("\n\n\"<i>That's enough!  What do you think you're doing?  Getting lost in foreplay... you're here to have sex with me, right!?  So, lay down and get ready for me already!</i>\" Ember demands.  You ");
        outputText("smile and, with a flamboyant grace, ");
        outputText("gently lay yourself down, spreading your limbs and making it clear you're ready for whatever she has in mind.");

        outputText("\n\nEmber can't resist licking [ember eir] lips as she straddles you, aligning your " + cockDescript(x) + " with her dripping pussy; then finally, with a sigh, letting gravity help your erect shaft inside her inviting depths.  You grit your teeth as her walls close around your prick, the firm muscles inside hungrily swallowing your length and starting to instinctively ripple and surge around it, beginning to milk you.  Your own instincts in turn compel you to buck and thrust, striving to bury yourself further into Ember's eager depths.");

        //(First time)
        if (flags[kFLAGS.EMBER_PUSSY_FUCK_COUNT] == 0) {
            outputText("\n\nEmber hisses in pain as you tear her hymen apart; scolding yourself for your carelessness, you stop and begin to withdraw.  Ember opens [ember eir] mouth, as if to protest, but to your surprise all that comes out of her is a moan of pleasure.  Startled, you immediately switch directions, thrusting back into her depths; once again Ember hisses, but this time, in pleasure rather than pain.  You quickly realize that Ember is as ready for this as she'll ever be, and so you continue to pump yourself into her, losing yourself in the act.");
        }
        outputText("\n\nEmber gasps and moans as you hilt yourself within her.  \"<i>H-hey!  I'm supposed to be in control here!</i>\" the dragon protests, despite her enjoyment of your initiative.");
        outputText("\n\nYou are too caught up in your thrusting to reply for a moment, but manage to snatch back enough of your wits to tell her that if she wants to be in control, she'll need to act like the one in control.  You then resume plunging your hips up into hers, sheathing and unsheathing your " + cockDescript(x) + " with each powerful, anxious thrust.");

        outputText("\n\nEmber growls and pins you under her by your shoulders, then begins moving her hips up and down");
        if (hasCock()) {
            outputText("; her ");
            if (internalDick()) outputText("draconic");
            else outputText("humanoid");
            outputText(" prick slaps wetly against your belly with each thrust, smearing pre on you as the engorged tool bounces back and forth");
        }
        outputText(".");

        outputText("\n\nShe moans with each insertion and purrs with each retraction, panting visibly from the pleasure you're inflicting on her sex-addled mind.  \"<i>T-there.  I'm in charge now, so you have to do what I say,</i>\" Ember states, before leaning down to kiss you on the lips.  You moan throatily into her mouth and kiss her back; you can't move your hands to try and embrace or caress her, so instead you hungrily grind your body against hers, rubbing your chest against her pillowy breasts and writhing back and forth, even as you continue thrusting into her ravenous dragon-cunt.");

        outputText("\n\n\"<i>S-stop thrusting!  If you keep doing this, I'm- Ah!</i>\"  Ember gasps as a particularly strong push rubs right on her special spot, rewarding you with a sudden rush of fluids that only help you increase your pace");
        if (hasCock()) outputText("; her own erect cock spurts a small jet of pre");
        outputText(".");

        outputText("\n\nYou can feel her inner walls squeezing and massaging your inflamed cock, their cool, wet surfaces a wonderful contrast against your own blood-boiled organ.  You feel like a mindless animal; only the imminent prospect of release matters, driving you to buck and thrash and writhe, spearing yourself into the dragon seated atop you over and over again.  Almost there...");

        outputText("\n\nOverwhelmed by the pleasure, Ember sits atop you and stops moving, going limp and panting in exertion, \"<i>C-can't move my hips anymore...</i>\"");

        if (player.cor >= 80) outputText("\n\nNoisy, weak, and now helpless too... you wonder if you shouldn't have adopted a kitten instead of a dragon, for the peace and quiet.");
        else outputText("\n\nYou can't accept that - you <b>won't</b> accept that!");
        outputText("  With a surge of lust-inflamed strength, you thrust yourself forward, knocking the unprepared Ember over.  You roll her over so that you are on top and spread her legs, draping them casually around your hips and then resume thrusting with ever-increasing force.  Like some sex-starved animal you thrust and rut, pounding the now-helpless dragon raw in pursuit of the tantalizing imminent release that haunts you.");

        outputText("\n\n\"<i>Ah!  Don't stop!  F-fuck me!  Deeper!  Ha-harder!</i>\" Ember pleads, not caring that you seem to be taking charge.  You eagerly obey, fucking her with everything you have - but your orgasm is here, and, with a cry, you release yourself into her waiting depths.  Ember screams in delight as you fill her up.");

        //(Low Cum Amount)
        if (player.cumQ() < 250) outputText("\n\nHer throbbing pussy milks you dry, seemingly sucking the jism out of you like a thirsty mouth slurping a drink through a straw.");

        //(Medium Cum Amount)
        else if (player.cumQ() < 1000) outputText("\n\nHer vaginal walls work in tandem with your powerful throbs to bring your spunk deep into her womb, filling her until you've been drained dry and she's sporting a small pot-belly.");

        //(Large Cum Amount)
        else outputText("\n\nDespite her contractions helping milk your cock of all its virile sperm, you really feel like there's no need.  Your powerful jets of cum fill her almost instantly and force thick gobs straight through her cervix and into her waiting womb, filling her to capacity and beyond.  The backflow spurts out of her stretched pussy and into your crotch as you finish up, leaving her with a sizeable belly.");

        outputText("\n\nYou groan deep and low in your throat in satisfaction.  Taking the dragon's legs in your hands, you pull yourself free of her, letting your cum ");
        if (player.cumQ() < 250) outputText("dribble");
        else if (player.cumQ() < 1000) outputText("flow");
        else outputText("gush");
        outputText(" from her used cunt and you sit on the ground, while Ember remains limp on the ground, panting. Still suffering from the afterglow of your recent orgasm, you dimly realize that Ember herself doesn't seem to have cum yet; the only fluids dripping from her pussy are yours");
        if (hasCock()) outputText(", and her cock, while engorged and swollen, hasn't poured forth yet");
        outputText(".");

        outputText("\n\nYou meet Ember's gaze through half-lidded eyes.  Slowly she rolls over and gets up on all fours, lifting her tail to give you a perfect sight of her cum-painted, dripping, used cunny.  \"<i>Ha... haha... that's all you've got?  C-couldn't even make me... cum...</i>\" Ember teases you, swaying her hips side to side enticingly.");

        //[(corr >= 60)
        if (player.cor >= 66) {
            outputText("\n\n\"<i>Nor you, me,</i>\" you say, folding your arms.  \"<i>You were the one in charge, so the failure is all yours... luckily, my stamina was enough to finish, even though you became useless halfway through.</i>\"  Picking up your gear, you leave the dragon behind you; she hurls breathless insults at you, but you only answer with a negligent wave.");
            //end scene, reset hours since cum, Ember preg check, minus some fuckin Ember affection
            player.sexReward("vaginalFluids", "Dick");
            dynStats("sen", -2);
            emberAffection(-5);
            endEncounter();
            flags[kFLAGS.EMBER_PUSSY_FUCK_COUNT]++;
            return;
        }
        //else
        outputText("\n\nShe has a point... furthermore, you can't resist the golden opportunity before you, as the sight manages to stir a brief flush of second life into your loins.  You pounce on the startled dragon, pulling her tail out of the way and roughly grabbing at her generous mounds, before thrusting yourself once more into her cum-slickened pussy.  You begin to pound her, slowly and deliberately, draping her tail carelessly over your shoulder and doing your best to lean over her as you do her doggy-style.");

        outputText("\n\nEmber roars as your sudden penetration drives her over the edge; her wet dragon juices spill all over your crotch, mixing with the fruits of your recent deposit");
        if (flags[kFLAGS.EMBER_GENDER] == 3) outputText("; her cock jumps and unloads on the ground below, marking this as the spot of your lovemaking");
        outputText(".  Her pussy grabs at you like a vice, constricting you with such pressure that you have trouble moving, even though her cunt is well-lubed from your mixed fluids.");

        outputText("\n\nUnable to move, you push yourself as deep into her as you can, and her quivering fuck-hole is only too happy to accept a few extra inches, sucking your shaft deep inside her and holding it there as her muscles massage you in ways you didn't think possible.  Ember looks back at you, with a lusty gaze of deep pleasure as she works to bring you to your second orgasm.  You groan and gasp as you find yourself releasing yourself into her depths again, dredging up reserves you didn't even know you had.");

        //(Low Cum Amount)
        if (player.cumQ() < 250) outputText("\n\nYou work overtime to push the last of your seed past her cervix to settle into her belly, and don't stop until she has developed a bit of a bulge.");

        //(Medium Cum Amount)
        else if (player.cumQ() < 1000) outputText("\n\nYour addition to her womb inflates her until she's sporting a pregnant-looking belly; with all the cum you've just given her, she might as well be.");
        //(High Cum Amount)
        else {
            outputText("\n\nBy the time your overworked ");
            if (player.balls == 0) outputText("prick is ");
            else outputText("[balls] are ");
            outputText("finished, Ember doesn't only look more than a few months pregnant; she looks absolutely huge, like her water could break at any moment!");
        }
        outputText("\n\nPanting, you slump onto Ember's back, your strength as drained and spent as your cock.  You ask if she's satisfied.");

        outputText("\n\n\"<i>Yes... let's go again...</i>\" she responds tiredly, before slumping down for a quick nap.  Beyond satisfied yourself, you settle on top of her with a sigh and a groan, repositioning yourself for greater comfort as you join her in sleep.");

        player.sexReward("vaginalFluids", "Dick");
        dynStats("lib", .5, "sen", -2);
        doNext(penetrateEmbrahPartII);
    }

    //PART II!
    private function penetrateEmbrahPartII():void {
        clearOutput();
        outputText("You wake up to find Ember's face hovering over you with a smile; once she realizes you're awake, she quickly averts her gaze.");
        outputText("\n\n\"<i>Oh, good!  You finally woke up!  Now, let's hear your excuse for your lack of self-control; I'm going to be sore down there for a while, thanks to you!</i>\" Ember scolds you, snorting a small puff of smoke.");
        outputText("\n\nYou yawn sleepily and comment that you were merely doing what she wanted; after all, she wanted you to make her cum, and you did.");

        outputText("\n\n\"<i>Well... yeah... but that doesn't mean you had to be so rough!  Besides that, you took me twice! Twice!  And in a very humiliating pose, no less!</i>\" she adds with another puff of smoke.");

        outputText("\n\nYou laugh as you recall the finale to your encounter; you didn't hear her complain when you mounted her from behind, and she's the one who picked the position... <i>and</i> from what you recall she seemed to enjoy being on all fours that second time.  Here you thought she was a strong, dominant dragon...");

        outputText("\n\n\"<i>You... y-you...</i>\" Ember growls at you lowly.  \"<i>You made me...  Bah!</i>\"  Ember gives up on trying to say anything back and darts away before you can say anything else.  Somehow you get the idea that she wasn't all that upset about being reminded; and the brief glance you got of her moist pussy as she turned to leave you only confirms your suspicion.");
        outputText("\n\nYou smile to yourself and start re-dressing, wincing at a deep aching sensation in [balls]; Ember gave you quite a workout.");

        //(if PC gained increased cum output)
        if (player.cumQ() < 1000) {
            outputText("\n\nYou wouldn't be surprised if you'll make even more cum than before when you're fully recovered.");
            player.cumMultiplier += 1 + rand(3);
        }
        //(else if already at Ember-given ceiling)
        else outputText("\n\nStill, you don't think you could produce any more cum than you already do...");

        outputText("\n\nYour decency restored, you return to camp.");
        flags[kFLAGS.EMBER_PUSSY_FUCK_COUNT]++;
        endEncounter(120);
    }

    //Get Penetrated - also horse-proof, sorry folks! (Z)
    private function getPenetratedByEmberLastSexSceneWoooo():void {
        clearOutput();
        outputText(images.showImage("ember-sticks-her-penor-in-your-vagoo"));
        outputText("Your eyes are drawn to the 16 inches of cool, throbbing ");
        if (internalDick()) outputText("dragon");
        else outputText("human");
        outputText(" dick between Ember's legs, and you lick your lips hungrily.  Your " + vaginaDescript() + " throbs eagerly as you tell Ember you have certain itches you need to scratch... is Ember enough of a " + emberMF("man", "herm") + " to scratch them for you?");

        //(Low Affection)
        if (emberAffection() <= 25) {
            outputText("\n\n\"<i>Ha!  I'm much more than you can handle!  Talk to me when you have something that can take even half of me.</i>\"  Ember mocks you, as [ember ey] walks away.");
            endEncounter();
            return;
        }
        //(Medium Affection)
        else if (emberAffection() < 75) {
            outputText("\n\n\"<i>Are you questioning my dragonhood!?  I'll have you know no cock in this world is a match for mine!</i>\" Ember boasts proudly.");
        }
        //(High Affection)
        else {
            outputText("Ember's cock jumps ");
            if (flags[kFLAGS.EMBER_ROUNDFACE] > 0 && flags[kFLAGS.EMBER_INTERNAL_DICK] == 0) outputText("to attention");
            else outputText("out of its protective slit");
            outputText(" at the mere mention of what you expect [ember em] to do.  \"<i>I'm more than enough to handle two... no... three of you!  And if you want proof all you have to do is ask!</i>\" Ember boasts proudly.");
        }
        outputText("\n\n\"<i>Well then,</i>\" you coo, one hand perched flirtatiously on your hips, batting your eyes at your draconic lover.  \"<i>If you're so ready to take me and fuck me raw... why don't you prove it?</i>\"");

        outputText("\n\n\"<i>Fine, come here!</i>\"  Ember grasps your arm and leads you away towards the wastes and beyond.  Once you arrive at a small clearing on the outskirts of your camp, Ember turns to look at you. \"<i>W-why are you still dressed?</i>\" Ember asks, crossing [ember eir] arms and tapping [ember eir] foot impatiently.");

        outputText("\n\nYou strip down until you are unabashedly naked, drinking in the look of stunned rapturous lust that Ember is giving you.  Playing your fingers gently across your upper arms, you pout and ask if [ember ey]'s going to keep you waiting, enjoying your emotional control over the horny dragon.");

        outputText("\n\nEmber flinches, [ember eir] trance broken.  \"<i>I... umm... fine!  Come here!</i>\"  Ember steps toward you.  You open your arms, ready to wrap [ember em] in a hug, but instead find yourself swept off of your feet.  The dragon grins wickedly at you before suddenly plunging into a ferocious kiss, [ember eir] long tongue worming its way around ");
        if (player.tongue.type == Tongue.HUMAN) outputText("yours ");
        else outputText("your own inhumanly sinuous muscle ");
        outputText("and slithering almost into your throat.  [ember Ey] kisses you madly, even as [ember ey] sinks to [ember eir] knees and gently lays you out on the ground, clearly ready to start the sexing.");
        if (player.hasCock()) outputText("  As if [ember eir] hands caressing your cock weren't evidence of that.");

        outputText("\n\nEmber begins by gently probing your [vagina] with [ember eir] tip, savoring the heat emanating from your oozing cock-sleeve.  \"<i>Ready for this?</i>\" Ember asks, trembling in barely contained anticipation.  You groan throatily and try to wrap your [legs] around [ember eir] hips in hopes of pulling [ember em] into connection with you.  Catching the hint, Ember begins [ember eir] slow plunge into your depths.");

        outputText("\n\nYou gasp and then moan in pleasure as Ember's ");
        if (internalDick()) outputText("draconic ");
        else outputText("human-like ");
        outputText("cock begins making its way past your labia.");

        //(if Ember has a dragon cock)
        if (internalDick()) {
            outputText("\n\nFirst comes the tapered spear-like head of Ember's penis; it slowly stretches you, sliding into you without resistance.  Then comes [ember eir] ridged shaft; each ridge driven inside feels like a milestone being conquered.  ");
            player.cuntChange(32, true, false, true);
            outputText("Finally you arrive at the base of [ember eir] cock where a bulbous knot sits; thankfully it hasn't inflated yet, but still, you can't help but groan as you are stretched even more by its entrance.");
        }
        //else
        else {
            outputText("\n\nEmber's member drives itself inside you, tamping down your heat with its surprisingly cool flesh.");
            player.cuntChange(32, true, true, false);
            outputText("  It's not as if it isn't still warm... but its lower temperature feels relieving and exciting all the same.");
        }
        outputText("\n\n\"<i>I-it's in!</i>\" Ember remarks happily as [ember eir] hips make contact with yours.  \"<i>I'm going to start moving now.</i>\"  You nod your permission.");

        //(if Ember has a dragon cock)
        if (internalDick()) {
            outputText("\n\nThe way back as Ember slowly pulls [ember eir] cock out of your dripping pussy is as pleasurable as [ember eir] entrance was.  First the knot tugs at your insides, drawing a sigh of relief as it slips out of your stretched netherlips.  Then come the oh-so-delicious ridges, tugging and massing your passage with small ripples of pleasure that rock you to your core.  Finally comes the tip... the stubborn tip that tugs at your pussy lips, refusing to leave its warm confines, pulling at your labia until Ember decides to plunge back.");
        } else {
            outputText("\n\nYou almost feel like moaning in agony as Ember's flesh leaves your love-hole empty, to grow back into its unbearable heat... and then cry out in joy as Ember begins to thrust back inside you, once again quenching the flames of your lust.");
        }
        outputText("\n\nYou delight in Ember's motions; insecure [ember ey] may be when it comes to showing feelings, but get [ember em] into the actual act of lovemaking and [ember ey] really starts to show what [ember ey]'s made of!  You wrap Ember tighter in your [legs] and begin to buck and thrust, repeatedly impaling yourself on [ember eir] delicious manhood, savoring the feeling of being stretched and filled, scraping your [clit] up and down [ember eir] cock in order to heighten the sensations of your lovemaking.");

        outputText("\n\nEmber leans over you, panting, [ember eir] hot breath mere inches from your [face], gazing at you through half-lidded, lust-addled eyes.  \"<i>You feel so good... so hot... so sexy...</i>\" Ember says mid-pant.  You pant right back, reaching up and wrapping your arms around [ember eir] neck, staring back at [ember em] with the same expression and telling [ember em] you think [ember ey] feels just as good.");

        outputText("\n\nEmber thrusts deeply into you and gasps; pre shoots out of [ember eir] cock into your well lubed tunnel and [ember ey] stops moving.  \"<i>I-I'm getting close...</i>\" Ember warns, trembling in pleasure as your walls constrict and grab at [ember eir] shaft, eager for the friction that sets your nerves alight with pleasure.");

        outputText("\n\nYou snarl back softly through your teeth; you're not ready yet!  Well, if [ember ey]'s close, then [ember ey] needs to go faster, so you can cum too!  You wrap your arms and [legs] jealously around [ember em], pistoning back and forth with all the speed and force you can muster, using every muscle you can control in your [vagina] to milk and squeeze your draconic lover... yes, yes, just a little more... Ember groans at your sudden movements, faltering and crashing atop you limply as the overwhelming pleasure saps [ember em] of all [ember eir] strength.");

        outputText("\n\nFrustrated, horny, and almost there, you roll [ember em] over onto [ember eir] back and continue to buck... yes, yes, here it is!  You cry out in ecstasy as the waves of pleasure rock and surge through your body; orgasm hits you like a tidal wave, cascading through your nerves and driving you into welcome, blissful release.");
        if (player.hasCock()) {
            outputText("  Your cock explodes, belching cum to ");
            if (player.cumQ() < 250) outputText("spatter");
            else if (player.cumQ() < 1000) outputText("drench");
            else if (player.cumQ() < 2000) outputText("completely cover");
            else outputText("utterly soak");
            outputText(" your draconic partner.");
        }
        outputText("\n\nYour orgasm triggers Ember's own, and you feel [ember eir] cock throb and grow even harder.  With a roar, Ember blows [ember eir] load deep into your convulsing [vagina], making sure to paint every nook and cranny inside you with white, refreshing dragon-spunk.  You can't help but sigh in relief as you feel Ember's seed trail its way inside you, into your waiting womb; the feeling is so intense it feels as if you were set ablaze and [ember ey] just poured a bucket of water, mercifully putting out the flames.  With a groan, Ember rolls you over on your side and pulls out, letting a cascade of white dragon-jism leak from your used and abused [vagina].");

        outputText("\n\nYou sigh softly in pleasure and relief, basking in the wonderful afterglow of a nice fuck with a nice lover.  Unthinkingly, you cuddle up to the dragon, trying to entrap [ember em] so you can hold [ember em] close and savor this feeling of bliss together.  Absently, one of your hands drifts down to your pussy, feeling the dragon-jism leaking from it and starting to play with it.  Like a child with water you dabble your fingers in the thick, frothy, strong-smelling spunk, smearing it around with carefree abandon, painting the inside of your thighs and streaking it up your belly.");

        outputText("\n\nYour actions are not unnoticed by the dragon laying beside you; Ember swallows dryly and begins panting anew, and soon enough you feel something poking at your thighs.  Looking down, you see Ember is sporting a brand new erection.  \"<i>I-I can't help it if you do things like this in front of me...</i>\" Ember says in excuse.");

        outputText("\n\nYou merely smile hungrily.  Well, if [ember ey]'s so eager for a second round, you're not going to disappoint [ember em].  You gently take hold of [ember eir] penis and slowly guide it back between your netherlips, playfully telling Ember you'll go slower and easier on [ember em] this time.");

        outputText("\n\nEmber hisses in pleasure; [ember eir] still-sensitive shaft barely makes its way inside you before it throbs and explodes in a second orgasm, filling you up with an extra barrage of dragon-seed.  You can't help but giggle at Ember's unexpected climax. \"<i>C-careful!  I'm still sensitive!</i>\" Ember gasps, as [ember ey] slowly pulls out of you again.  You give [ember em] an expression so innocent that butter wouldn't melt in your mouth, and then gently reinsert [ember em] again.  [ember Ey]'s still flaccid by this point, but you're confident that will soon change.");

        outputText("\n\nEmber groans as [ember ey] grows hard once more, sensitive and throbbing as [ember eir] shaft slowly fills you with its increasing girth.  You begin to buck your hips back and forth; you wonder how many orgasms you can coax from your helpless draconic lover...  \"<i>C-cumming!!</i>\" Ember roars as [ember ey] shoots a few more jets inside you.");

        outputText("\n\n\"<i>I-I can't keep doing this... you're going to dry me out...</i>\" Ember says, panting in exhaustion, although from [ember eir] expression you'd have a hard time believing [ember ey] isn't enjoying it.  You give [ember em] an exaggerated pout and tell [ember em] you're not quite done yet.  Surely, just one or two more...?");
        //[(has History: Slut or Whore)
        if (player.hasPerk(PerkLib.HistoryWhore) || player.hasPerk(PerkLib.HistorySlut) || player.hasPerk(PerkLib.PastLifeWhore) || player.hasPerk(PerkLib.PastLifeSlut)) outputText("  Using the skills you've honed, you make the muscles in your vagina ripple and wrinkle, teasing the cock caught inside you in a way few women can.");
        outputText("  Mmm... you can feel your own second orgasm coming in hot.  Maybe after another 4 or 5, you'll let the dragon go...");

        outputText("\n\nEventually, exhausted, belly stuffed with dragon-spunk to the point you look ready to birth a pair of dragon toddlers, and feeling incredibly well-sated, you lay on Ember's chest, cuddling your limp, utterly drained lover.  The dragon is fast asleep, having passed out from exhaustion, and you amuse yourself by listening to [ember eir] heart beating as [ember ey] inhales and exhales softly in [ember eir] sleep.  To be honest, you could use a nap too, and you pass out atop [ember em].");
        player.sexReward("cum", "Vaginal");
        dynStats("sen", -2);
        if (player.lib > 50) dynStats("lib", -3);
        player.slimeFeed();
        doNext(getPenetratedByEmberLastSexSceneWooooPartII);
    }

    //Part II
    private function getPenetratedByEmberLastSexSceneWooooPartII():void {
        clearOutput();
        outputText("You manage to wake up before your sleeping draconic lover; it seems at some point in [ember eir] sleep Ember saw it fit to wrap you tightly in [ember eir] arms, tail and even legs.  You snuggle deeper into the dragon's embrace and enjoy it; [ember ey]'s usually too emotionally cowardly to treat you like this.  Unfortunately the embrace doesn't last long... Ember soon wakes up, yawning groggily and slowly disentangling [ember em]self in order to stretch.  The dragon's face lights in pain and [ember ey] quickly moves [ember eir] hand to hold [ember eir] crotch.");
        outputText("\n\n\"<i>Ow...</i>\"  Ember looks at you accusingly.  \"<i>I feel sore all over... especially down here...</i>\" Ember says, massaging [ember eir] ");
        if (internalDick()) outputText("protective slit");
        else outputText("limp cock and balls");
        outputText(".  \"<i>You used me like a fucktoy!</i>\"");

        outputText("\n\nYou admit, yes, you did... but is [ember ey] really going to sit here and tell you that [ember ey] didn't love being used?  Besides, who was it who said ");
        if (emberAffection() < 75) outputText(emberMF("his", "her") + " cock was unlike anything else in this world?");
        else outputText(emberMF("he", "she") + " could handle two or even three of you at the same time?");
        outputText("  You expected more resistance if that was the case.");

        outputText("\n\n\"<i>Yeah, fine!  But you didn't have to make me cum so much!  I think I almost got dehydrated!</i>\"");

        outputText("\n\nYou heave a great sigh in exaggerated pity.  Well, you're sure [ember ey] will be full and ready to go in no time, you tell [ember em].  You get up, stifle a wince - your body is going to be paying for your extravagance, but you don't need Ember to know that - and try to make the task of heading over and picking up your clothes as erotic as possible.  When you look back, you smirk at the sight of your success; Ember's trembling, trying to contain another hard-on.  Gently, you ask if maybe [ember ey] wants to have round... hmm, what would it be?  Round twelve?");

        outputText("\n\nEmber's eyes widen in terror.  \"<i>What!?  No!  Not again!</i>\" Ember screams, getting up and wasting no time in bolting away, setting into an unsteady flight as soon as [ember ey]'s gotten far enough.  You wait until [ember ey]'s gone, and then burst out laughing.  Totally worth it... even if you are, as the saying goes, going to be sleeping on the couch for a week as a result.");
        //slimefeed, preg check, reduce lust, reset hours since cum, drain massive libido
        endEncounter();
    }


    //Breeding Setup
    //Note: I don't know if it's possible to go into rut as well as heat... But impregnating or being impregnated by Ember should clear the heat/rut status. For simplicity's sake, having either of those stats qualifies you for the scenes, either male or female variant, granted you have the required parts.

    //This scene only appears if PC and Ember have matching parts (ie: M/F, M/H, F/H, H/H)
    //This scene leads right into Breeding Ember or Bred by Ember, pick the one that fits appropriately.
    //Occurs the next time the PC is in the camp after they go into heat/rut, if they're still in heat then. It's possible to get impregnated by something else in the meantime...
    //If the PC waits/rests, trigger this anyways.
    //Ember must not be pregnant if you're going to breed her and the PC must not be pregnant to be bred.

    /* ONE OF THESE SHOULD BE TRUE
		 //Female Breeding Scene:
		 //PC not pregnant, Ember has dick, PC is in heat.
		 //Male scene
		 //PC has dick, ember not pregnant, PC is in rut*/
    public function emberRapesYourHeatness():void {
        outputText("\nA pair of scaly, clawed hands suddenly grab your [hips] and you feel Ember take a big whiff of your scent. \"<i>So good... you smell so good, y'know [name]?</i>\"");

        outputText("\n\nYou don't even start at [ember eir] actions; all you can think of is the deep need burning in your crotch, ");
        if (player.hasVagina() && player.inHeat && hasCock())
            outputText("your [vagina] aching to be filled and your womb put to its proper purpose");
        else outputText("[eachCock] burning to be seeding ripe, ready wombs");
        outputText(".");

        outputText("\n\nEmber responds by ");
        if (player.hasVagina() && player.inHeat && hasCock())
            outputText("humping against you, smearing your thigh with dragon pre.");
        else outputText("tightly pressing her drooling, puffy netherlips on your thighs.");
        outputText("  \"<i>I need you, [name].  I need you so badly... can you see how badly I need you?</i>\" Ember asks, panting in barely contained lust.  \"<i>I want to fuck you so badly... Let's make a baby now!</i>\"");
        dynStats("lus", 10 + player.lib / 10, "scale", false);
        outputText("\n\nWhat do you say?");
        //[Accept] [Deny]
        simpleChoices("Accept", timeToPuffTheMagicDragon, "Deny", fuckOffEmberIWantANap, "", null, "", null, "", null);
    }

    //[=Deny=]
    private function fuckOffEmberIWantANap():void {
        clearOutput();
        dynStats("lus", 10 + player.lib / 10, "scale", false);
        outputText("Oh, your ");
        if (player.hasVagina()) outputText("[vagina]");
        if (player.gender == 3) outputText(" and ");
        if (player.hasCock()) outputText("[eachCock]");
        outputText(" so yearn");
        if (player.gender == 1 || player.gender == 2) outputText("s");
        outputText(" to take Ember up on [ember eir] offer! ...But you are better than this; you are not some mindless animal, a slave to your lusts.  You fight down the arousal gnawing at you and tell Ember you don't want to fuck [ember em].");
        outputText("\n\nEmber whimpers at your words.  \"<i>C-can't you see what you're doing to me? C'mon [name], just a quick romp!</i>\" Ember pleads.");
        outputText("\n\nYou tell [ember em] that you're sorry, but you don't want to have children - at least, not yet.  And if you have sex in your state, that's what will happen.");
        outputText("\n\nEmber growls, spins you around and steals a kiss right out of your mouth.  \"<i>I hate you... you... you sexy beast!</i>\"  Having said that [ember ey] unfurls her wings and flies off into the sky, barely managing to fly straight due to [ember eir] ");
        if (hasCock()) outputText("protruding prick");
        if (flags[kFLAGS.EMBER_GENDER] == 3) outputText(" and ");
        if (hasVagina()) outputText("creaming wet vagina");
        outputText(".  No doubt [ember ey]'s off to take care of [ember eir] needs by [ember em]self.  You doubt [ember ey]'s going to be happy once [ember eir] head is clear... still, [ember ey]'ll get over it.");
        emberAffection(-10);
        if (flags[kFLAGS.EMBER_AFFECTION] < 75 && flags[kFLAGS.SLEEP_WITH] == "Ember") flags[kFLAGS.SLEEP_WITH] = "";
        //Set some cooldown so this doesn't proc all the goddamn time!
        player.createStatusEffect(StatusEffects.EmberFuckCooldown, 12, 0, 0, 0);
        doNext(playerMenu);
    }

    //[=Accept=]
    private function timeToPuffTheMagicDragon():void {
        clearOutput();
        outputText("Dazed and befuddled, you sniff Ember right back.  Mmm... [ember Ey] smells delicious too, you tell [ember em].");
        outputText("\n\n\"<i>I know, rrrrriggghhht?</i>\" Ember purrs in your ear, stealing a teasing lick. \"<i>Oh by Marae, take off your [armor] and let's do it!  I don't care if we're in the middle of the camp!</i>\"");

        outputText("\n\nYou barely manage to resist [ember eir] insinuations, instead forcing yourself to stagger over to your " + camp.homeDesc() + " for privacy's sake.  It's harder than you'd think, not just because of the raging fire in your loins, but because Ember is insistently clinging to you, doing [ember eir] damndest to remove your [armor].  You can appreciate [ember eir] enthusiasm, but all [ember ey]'s doing is getting in the way!");

        outputText("\n\nSomehow you manage to avoid [ember eir] clinging claws and strip off to your undergarments, which Ember promptly bites into, nearly ripping them off your [legs].  Ember flops down on your " + camp.bedDesc() + ", chewing on your undies.  [ember Ey] spreads her legs invitingly and spits out your - now soaked - underpants.  \"<i>Let's do it on your bed!  It smells so much like you...  Did I say how good you smell?  C'mon, [name]; fuck me dammit!</i>\"");
        outputText("\n\nYou can't take it anymore and throw yourself at [ember em]; [ember ey] wants you so bad?  Well, you want [ember em] just as bad; let's see what [ember ey]'ll do with you!");
        //(if PC and Ember are herms AND not pregnant){
        if (player.canGetPregnant() && !pregnancy.isPregnant && flags[kFLAGS.EMBER_GENDER] == 3 && player.gender == 3) {
            outputText("\n\n(Who should bear the kids?)");
            simpleChoices("Ember", breedEmberPregnantAsIfThereWasAnyOtherKindOfBreeding, "You", getKnockedUpByEmbrahBroBaby, "", null, "", null, "", null);
        } else if (player.canGetPregnant() && hasCock() && player.inHeat) {
            getKnockedUpByEmbrahBroBaby();
        } else {
            breedEmberPregnantAsIfThereWasAnyOtherKindOfBreeding();
        }
    }

    //Bred by Ember
    //Only available to Medium/High Affection Ember.
    //Only occurs if the PC has a pussy and is in heat; Ember must have a dick; both must not be pregnant.
    //In case Ember and the PC are herms, both being able to impregnate and be impregnated. One of the scenes will be randomly hosen.
    //Ember never fails to impregnate the PC or be impregnated - unless the player is on contraceptives.
    private function getKnockedUpByEmbrahBroBaby():void {
        clearOutput();
        outputText("Ember grabs you and rolls you around, pinning you under [ember eir] weight, whilst kissing you.  You allow the dragon to press you into the ground, rubbing your hands across ");
        if (flags[kFLAGS.EMBER_GENDER] == 1 && flags[kFLAGS.EMBER_MILK] == 0) outputText("his flat, muscular chest");
        else outputText(emberMF("his", "her") + " soft, squeezable boobs");
        outputText(" and savoring the kiss.  Emboldened, you poke your tongue into [ember eir] mouth, to see how [ember ey] will react.");

        outputText("\n\nEmber shows no resistance, pushing [ember eir] chest out into your hands and using [ember eir] own tongue to draw yours in, while simultaneously probing your mouth.  With a wet <b>smack</b> Ember breaks the kiss.  \"<i>Don't worry about anything... I'll make sure to make this enjoyable for both of us, and by the end, you'll be full of ");
        if (flags[kFLAGS.EMBER_OVIPOSITION] == 0) outputText("little dragons");
        else outputText("dragon eggs");
        outputText(", my beautiful.</i>\"  Ember resumes [ember eir] kissing; [ember eir] own hands roaming all over your body, as if mapping you out through touch, looking for the best places to touch and tease.");

        outputText("\n\nYou try to hold your own against your overly affectionate draconic lover, stroking [ember eir] scaly limbs and trying to discover where [ember eir] erogenous zones are so that you can show [ember em] what it's like to be ready to beg and plead for sex.  You can feel the heat burning in your loins, a wet, ready fire in your [vagina]; you're ready to be bred, to have your gut filled with Ember's seed until your womb is jam-packed with ");
        if (flags[kFLAGS.EMBER_OVIPOSITION] == 0) outputText("dragonlings");
        else outputText("dragon eggs");
        outputText(".  You want to breed!");

        //(if PC has a dick)
        if (player.hasCock()) {
            outputText("\n\nOne of Ember's roaming hands find your erect [cock biggest] and begins stroking, not caring that you're smearing [ember eir] body with pre.  While Ember's other hand settles on stroking your thighs, coaxing you to open your legs before aligning [ember eir] rock hard shaft with your waiting [vagina].");
        } else {
            outputText("\n\nEmber's roaming hands settle on your thighs, coaxing you to open your legs before aligning [ember eir] rock hard shaft with your waiting [vagina].");
        }
        outputText("  You groan throatily, your need burning through you, and start trying to grind yourself against Ember's shaft.  [ember Ey] pins you down, though, making it impossible for you to actually do anything more than rub [ember eir] glans against your needy netherlips.");

        outputText("\n\nFortunately, the dragon [ember emself] seems just as turned on and ready as you are.  \"<i>You're so hot I can feel your flesh burning against mine.  I-I can't hold back!</i>\" [ember ey] growls deep in [ember eir] throat.");

        outputText("\n\nEmber first thrust is awkward, missing its target and instead grinding against your netherlips; you almost curse the dragon's lousy aim, but fortunately [ember eir] second thrust hits true and you sigh in relief as you feel Ember's tapered shaft settle inside your contracting walls, pulsing, massaging your insides as much you work to massage [ember eir] own shaft.  You exchange moans of pleasure between kisses, Ember's rumbling purr massages your [chest] as [ember ey] grinds [ember eir] whole body against you.  Briefly, you open your eyes to gaze into [ember eirs]; you almost cum at the sight. Ember's eyes are set aglow with lust, burning with a primal, instinctual need...");
        player.cuntChange(20, true, true, false);

        //(if Ember has a vagina)
        if (flags[kFLAGS.EMBER_GENDER] == 3) outputText("\n\nYour " + camp.bedDesc() + " is growing slick underneath you as lubricant drools from the herm dragon's neglected cunt, her tail thrashing around madly before sliding into the wet orifice to help goad her on in her goal to breed you.  ");
        else outputText("\n\n");
        outputText("You growl throatily, feeling that same need burning inside you. You clutch and claw against the dragon, fingers grasping deeply into [ember eir] scaly limbs as you drag, scrape, and thrust yourself against " + emberMF("him", "her"));
        if (player.hasCock()) outputText(", your neglected [cock] drooling pre-cum that is being smeared all across your belly and [ember eirs] with every move you make");
        outputText(".  Gods, you can feel [ember em] filling you...");

        outputText("\n\nEmber huffs and growls with each thrust, until with a roar [ember ey] clutches your hips, penetrating you as far as [ember ey] can, then blowing [ember eir] load deep into your womb.  \"<i>Aah! T-take it all!</i>\" Ember groans.");

        outputText("\n\nIt's not as if you have much of a choice, but you're happy to receive it, letting the dragon's cool, refreshing spunk surge into your burning cunt, deluging into your aching, <i>needing</i> womb. You groan with hollow joy; it feels so good... but it's not enough, you want more, and you tell the dragon that [ember ey] isn't done with you yet.");

        outputText("\n\n\"<i>Of course not...</i>\" Ember grins.  \"<i>Just give me a few... phew... minutes to recover.</i>\"");

        outputText("\n\nYou find yourself snarling in frustration, displaying your teeth - a few minutes isn't good enough!  You need more, and you need it now!  With a sudden thrust of motion you slam into the dragon, striving to push [ember em] over so you can mount [ember em] instead.");

        outputText("\n\nStartled and caught off-guard, you are soon straddling the bewildered dragon.  With a lustful sneer you tell [ember em] that you want [ember em] now, not in a few minutes, and start to buck and thrust your hips to make it clear you're getting what you want, even if it means taking Ember along for the ride instead.");

        outputText("\n\n\"<i>Ah! Taking charge, are you?  Oh!  Okay, but... Ah!... only this time.</i>\"  Ember lays back, thrusting lightly to meet your own bucks into [ember eir] dick, panting and moaning as the sound of wet slapping fills the " + camp.homeDesc() + ".");

        outputText("\n\nYou don't dignify that with a response, instead savoring the sensation of feeling [ember eir] long, thick cock in your needy cunt, squeezing and clenching with all the instinctual knowledge and practice this world has given you.  Mmm... the segment-like ridges stroke your inner walls in the most delicious ways...  You moan throatily, needily, riding the dragon with fervor of a " + player.mf("herm", "woman") + " possessed; you want to get pregnant... you <b>have</b> to get pregnant!");

        outputText("\n\nDriven by the most primal of instincts, you start trying to coax Ember into doing you harder; doesn't [ember ey] want to be a father?  Doesn't [ember ey] want you to bear [ember eir] offspring?  Or would [ember ey] rather you go out into the wilderness and risk letting some degenerate monster take advantage of your ripe, ready womb instead?  See you wandering around camp with your belly distended with a litter of imps or a bestial minotaur's calf instead of a new dragon, Ember's own blood-child?");

        outputText("\n\nYour words seem to have the desired effect; because shortly after you're done Ember lifts you off along with [ember em] into [ember eir] arms.  [ember Ey] looks deeply into your eyes with renewed fire.  \"<i>Never,</i>\" Ember says, kissing you deeply and beginning to pump into you with abandon.  This is what you were waiting for.  Finally!");

        outputText("\n\nEmber's brutal thrusts rock you to the core, sending rippling waves of pleasure through you.  [ember Ey] kisses you passionately, slurping and suckling on your tongue, savoring your taste.  You gasp and shudder, thrusting back just as brutally, striving to grapple and suckle the dragon's inhumanly long and nimble tongue so that you can savor [ember eir] taste as well.");

        //(if Ember has a pussy)
        if (flags[kFLAGS.EMBER_GENDER] == 2) outputText("\n\nYou hear the wet splattering of femcum on your wet bedroll; Ember's orgasm ressurging with renewed vigor.  ");
        else outputText("\n\n");
        outputText("A fresh batch of dragon cum blasts its way into your overfilled insides, splattering about inside your " + camp.homeDesc() + "; and to your surprise Ember continues thrusting into you without ever slowing down.  Even as you moan into the kiss, a third orgasm blasts its way into you, inflating your belly with fertile dragon seed.");

        outputText("\n\nYou are so close now... so close!  Your hands unthinkingly reach out for Ember's, seeking to entwine your fingers with those of the " + emberMF("male", "herm") + " that you know is about to father your child.  You break the kiss, throwing your head back to moan towards the sky as you finally achieve orgasm.");

        //(if PC has a dick)
        if (player.hasCock()) outputText("\n\nYou cum into your chests and bellies, glueing you to the dragon with your thick spunk.  ");
        else outputText("\n\n");
        outputText("Your contracting walls milk the dragon's sensitive cock, trying to coax even more seed out of your panting dragon lover.  \"<i>I-it's time,</i>\" Ember mutters, crashing into your wet bedroll and thrusting deep inside you.");

        outputText("\n\nYou gasp as you feel pressure build in your ravaged vulva, and realize it's Ember's knot!  It's swelling!  The knot is filling you so deliciously, you can't help but release another wave of fluids until Ember plugs you closed, tying the two of you together.");

        outputText("\n\nYou can feel it.  Ember continues to fill you with a slower but steady trickles of seed.  You briefly wonder how the dragon can hold so much cum inside [ember em], but ultimately you decide that doesn't matter and relax on top of the spent dragon, enjoying your closeness while it lasts.");

        outputText("\n\nEmber sighs, rubbing your back with a hand while hugging you close with the other.");

        outputText("\n\n\"<i>Don't you just assume this makes us official mates,</i>\" Ember murmurs into your ear.  You lift your head to look into [ember eir] ");
        if (flags[kFLAGS.EMBER_ROUNDFACE] == 1) outputText("blushing ");
        outputText("face.  \"<i>But if you must know, I do love you.</i>\"   With a final sigh Ember sets down on your " + camp.bedDesc() + " for a quick nap.");

        outputText("\n\nFeeling [ember eir] knot still swollen and anchoring you together, you sigh softly and settle down with the dragon to recover, figuring you'll be free in about an hour's time.  In the meantime, you're content to just cuddle [ember em] close, one hand going to your cum-inflated belly.  You'd almost swear you can feel the draconic virility cream at work, the cool fluid of life drowning your burning need to breed and already beginning to brew what will be a new ");
        if (flags[kFLAGS.EMBER_OVIPOSITION] == 0) outputText("baby dragon");
        else outputText("dragon egg");
        outputText(".  Yawning, you curl up to the dragon for a quick nap of your own.");
        player.sexReward("cum", "Vaginal");
        dynStats("sen", -2);
        //Preg shit goez hurdur
        if (player.hasUniquePregnancy()) player.impregnationRacialCheck();
        else player.knockUp(PregnancyStore.PREGNANCY_EMBER, PregnancyStore.INCUBATION_EMBER, 0); //Will always impregnate unless contraceptives are in use
        player.createStatusEffect(StatusEffects.EmberFuckCooldown, 36, 0, 0, 0);
        doNext(createCallBackFunction(emberBreedingAfterMathWatchOutForRadioactiveFallout, false));
    }

    //Breeding Ember
    private function breedEmberPregnantAsIfThereWasAnyOtherKindOfBreeding():void {
        clearOutput();
        //Silently steal her virginity.
        flags[kFLAGS.EMBER_PUSSY_FUCK_COUNT]++;
        var x:int = player.cockThatFits(emberVaginalCapacity());
        if (x < 0) x = player.smallestCockIndex();
        outputText("Ember catches you and rolls you around, pinning you to the ground under her.  She smiles at you seductively and reaches down to stroke your " + cockDescript(x) + ".");
        if (player.hasBalls()) outputText("  She then reaches down lower to rub at your cum filled orbs.");
        if (player.hasVagina()) outputText("  The tip of her tail gently teases your slick [vagina] with tiny strokes.");
        outputText("  You shudder and instinctively thrust towards her, letting her feel your needy cock, full and aching to father young.");

        outputText("\n\n\"<i>You're so sexy...  You have no idea,</i>\" Ember purrs dreamily.  With a soft smile, you tell her that she's quite sexy herself - maybe not the smartest thing to say, but all that comes to mind with your brain befuddled by your surging hormones, bewitched by the delicious smells that are rolling off of her now that she's so close, so ripe, so ready...");

        outputText("\n\nEmber jumps off you momentarily to inhale your musk, stroking you until a bead of pre forms on your " + player.cockHead(x) + ".  Ember's eyes grow wide, as if she had spotted a pearl; and she wastes no time in extending her tongue to lick the bead away.  \"<i>Hmm, delicious...  You're ready, and so am I!</i>\"");

        outputText("\n\nAiming your cock upwards; Ember straddles you and lowers herself on your pulsing " + cockDescript(x) + ", hissing in pleasure as your hot flesh finally makes contact with her drooling fuckhole");
        if (hasCock()) outputText(", her own cock springing up and throbbing with the electric contact.");
        else outputText(".");

        outputText("\n\nYou hiss back to her at the sensations that fill you with such pleasure, your yearning breeding rod finally slotted into a ripe, ready breeding hole, her deliciously cool inner walls enveloping your burning hot flesh.");

        outputText("\n\nYou take hold of her shoulders, feeling the scales and the steely muscles underneath, and start to thrust yourself into her, bucking and pistoning your hips, driving yourself into that cool, wet hole, giving yourself over to the need to impregnate her.");

        outputText("\n\n\"<i>Ah!  Yes!  M-my breasts!  Uh!  Please!</i>\" Ember begs, holding your shoulders for support; her glazed eyes looking deep into yours, overpowered by her need to breed with you.  You dimly manage to latch onto her plea and begin to caress and grope the great, heavy bosom of your draconic lover, feeling the ");
        if (flags[kFLAGS.EMBER_ROUNDFACE] == 0) outputText("scale-covered ");
        outputText("orbs gently squish ");
        if (flags[kFLAGS.EMBER_MILK] > 0) outputText("and leak milk ");
        outputText("under your grasp.");

        outputText("\n\nEmber moans, pushing her chest out into your hands, allowing you to twiddle her nipples (and isn't that an odd thing?  A reptilian girl-thing with breasts and nipples? A part of your mind dimly notes), but ");
        if (flags[kFLAGS.EMBER_MILK] > 0) outputText("the slowly trickling rivulets of milk along with ");
        outputText("Ember's pleased moans are enough to make you push away such thoughts, you're glad she has those!");

        outputText("\n\nYou hungrily kiss her ");
        if (flags[kFLAGS.EMBER_ROUNDFACE] == 0) outputText("draconic ");
        else outputText("oh-so-human ");
        outputText("face, nipping lightly at her lip, rolling your tongue over hers and savoring her inhuman tastes; Ember answers in kind with a kiss of her own, purring and moaning into your mouth.  Her vibrating breasts massage your hands as you knead, lift, and then roll them about.");

        //(if Ember has a dick)
        if (hasCock()) {
            outputText("\n\nYou feel something poke your [chest] and look down to see Ember's painfully erect ");
            if (internalDick()) outputText("dragon ");
            outputText("prick.  With a mischievous curl of your lips, you pull Ember deeper into your kiss and grab her cock, stroking it vigorously.");
        }

        outputText("\n\nEmber squeals into your kiss - a girly squeal you didn't think possible for the usually brash dragon.  Her pussy contracts and pulls at your throbbing member; ");
        if (hasCock()) outputText("her cock spurts a few jets of cum onto your [chest]; ");
        outputText("her eyes roll to the back of her head.  With a muffled roar she finally caves, a veritable wave of dragon juices crashing into your lower body and pooling on your " + camp.bedDesc() + ", filling the whole " + camp.homeDesc() + " with the delicious smell of sex and pheromones.");

        //(If Ember has a dick)
        if (hasCock()) outputText("  Ember's cock wets the side of the " + camp.homeDesc() + " with continuous jets of cum, only adding to the already overpowering smell of sex as she empties herself on top of you.");

        outputText("\n\nEmber breaks the kiss and pants, looking at you with a mixture of love, satisfaction and desire. You look back at her with need, drenched in sexual fluids, the air heavy with musk.  It's not enough yet, and you still haven't cum.  You need to cum!");

        outputText("\n\nUnthinkingly, instinctively, you give Ember a bite on the side of her neck - not deep enough to draw blood (especially given her armor-like scales) - but a sign of dominance, even as you continue to buck and thrust into her, yearning for the release, the act of fertilization.");

        outputText("\n\nEmber's tongue lolls out as she exposes her neck to you, an act of submission you wouldn't normally see.  Still, it doesn't last long.  Seeing Ember's face completely overtaken by bliss, you can't resist kissing her again, sucking her tongue back into your mouth to taste her once more.  Once more, you feel her walls contract; ");
        if (hasCock()) outputText("her spent cock throb; ");
        outputText("her eyes shut tight in pleasure as she reaches her second orgasm.  You muffle her groan of pleasure with one of your own.  A second wave of dragon fluids joins the first in wetting your lower body, along with your " + camp.bedDesc() + ".");
        if (hasCock()) outputText("  Little gobs of cum spill from her cock to slide down her shaft and gather on your belly button.");
        outputText("  Her tail coils around you, helping her stay in position as she melts on top of you like putty.");

        outputText("\n\n\"<i>I-I can't keep going like this,</i>\" Ember whispers, slumping atop you, all strength drained from her limbs.");

        outputText("\n\nBut you're so close... just a little more...  You promise her it will be over soon, even as you continue to thrust, desperate to grab the release that's hovering just barely out of your reach.");

        outputText("\n\n\"<i>Okay, I'll try,</i>\" Ember replies tiredly, but all she manages to do is bounce atop you a few more times before slumping and nearly falling off.  You are too driven to let this stop you; you roll her onto the bedroll and take your place atop her, continuing to thrust with mindless instinct.");

        outputText("\n\nEmber doesn't even protest, she just moans and wraps as much of herself around you as she can, holding onto you like her life depended on it.");

        outputText("\n\nThen, finally, you feel yourself drive over the edge and release all your pent-up cum; ");
        if (player.hasVagina()) outputText("your neglected cunt splashing fluid down your [legs] and ");
        outputText("your " + cockDescript(x) + " gushing into the dragon's ready womb.");

        outputText("\n\nEmber growls and purrs as she feels your hot seed drive itself into her womb, looking for her fertile eggs to impregnate.  Her pussy lips clamp down on your shaft, holding it in place with a watertight seal to prevent any of your seed from spilling as her walls work to milk you.");

        //(Low Cum Amount)
        if (player.cumQ() < 250) outputText("  Though you usually don't cum that much, Ember's contracting walls literally suck the cum out of you; forcing you to give up more than you usually would... something you're quite glad to do!");
        //(Medium Cum Amount)
        else if (player.cumQ() < 1000) outputText("  Your generous helping of cum works its way towards her awaiting womb.  In fact, due to the delicious massage your shaft is receiving from Ember's contracting, almost sucking vaginal walls, you find yourself pumping out even more cum that you would usually have, quickly filling her to the brim and beyond.  It's not until Ember's belly is slightly distended that you stop.");
        //(High Cum Amount)
        else outputText("  You dump a huge load of jism into Ember's awaiting belly, but her contracting walls seem to milk you for ever more!  Ember is filled to the brim, her belly already slightly distended, but you still continue to fill her with your seed.  Ember's tightly sealed pussy lips means the cum has nowhere to go, so instead it gathers in her womb, distending her belly until she looks at least a few months pregnant; and by the look of pleasure on Ember's panting face, you don't think she minds it.");

        outputText("\n\nWith a gasp and a sigh of utter relief, you slump into Ember's arms, collapsing onto her ");
        if (hasCock()) outputText("cum-slick ");
        outputText("belly and laying there to regain your strength, ");
        if (hasCock()) outputText("dismissive of the spent cock lying sandwiched between you as you start ");
        outputText("feeling the heat in her gut that marks the beginning of a child.");

        outputText("\n\nEmber purrs and pulls you into another kiss, holding you close with her tail, legs and arms; intent on keeping you right where you are.  Well, it's not like you could go anywhere else with her pussy effectively keeping your " + cockDescript(x) + " hostage inside its depths.");

        outputText("\n\nBreaking the kiss, she whispers into your ears, \"<i>Don't just assume this makes us official mates.</i>\"  Then with a quick peck on your cheek she adds, \"<i>But I do love you.</i>\"  Then she slumps down on your " + camp.bedDesc() + " for a quick nap.");

        outputText("\n\nFiguring you'll still have some time before Ember's constricting nether lips feel like letting you go, you snuggle close to her for a quick nap of your own...");

        //knock dat phat bitch up.
        pregnancy.knockUp(PregnancyStore.PREGNANCY_PLAYER, PregnancyStore.INCUBATION_EMBER);
        player.createStatusEffect(StatusEffects.EmberFuckCooldown, 36, 0, 0, 0);
        player.removeStatusEffect(StatusEffects.Rut);
        player.sexReward("vaginalFluids", "Dick");
        dynStats("sen", -2);
        doNext(createCallBackFunction(emberBreedingAfterMathWatchOutForRadioactiveFallout, true));
    }

    //Bred/Breeding Aftermath
    private function emberBreedingAfterMathWatchOutForRadioactiveFallout(emberPregged:Boolean = true):void {
        clearOutput();
        outputText("You wake up, feeling replenished after your exhausting mating session with your draconic lover, and stretch the last few kinks out.  As you do, you realize you're in still in your " + camp.homeDesc() + ", which is perfectly clean, with no trace of the copious sexual fluids that you and Ember were splattering everywhere before you took your impromptu nap.");

        outputText("\n\nLooking around for the dragon, you spot [ember em] seated in a cross-legged position halfway in and out of the " + camp.homeDesc() + "'s door.  Was [ember ey] guarding you while you slept?");

        outputText("\n\nEmber takes a happy glance in your direction, when [ember ey] notices you're awake.  \"<i>So you finally woke up, huh?  Good, I was getting tired of sitting here...</i>\"");

        outputText("\n\nYou thank [ember em] for cleaning the place up, and tell [ember em] that you appreciate it.  [ember Ey]'s actually quite good at doing that kind of thing.");

        outputText("\n\nEmber's cheeks ");
        if (flags[kFLAGS.EMBER_ROUNDFACE] == 0) outputText(" are probably blushing under [ember eir] scales.");
        else outputText("blush.");
        outputText("  \"<i>You're welcome, but this is the only time I'll clean up after you!  I'm not your personal maid!</i>\"");

        outputText("\n\nYou wonder if you should point out that it's only fair Ember cleaned it, seeing as how [ember ey] made the bulk of the mess, but decide to simply thank [ember em] for [ember eir] generosity.  Absently, your hand goes to ");
        if (!emberPregged) outputText("touch your belly");
        else outputText("point at Ember's belly");
        outputText(", and you ask the dragon if [ember ey] thinks it \"<i>took</i>\".");

        outputText("\n\nEmber puffs [ember eir] chest and proudly boasts, \"<i>Of course it did!  We're both very virile!  And after all the cum you ");
        if (emberPregged) outputText("pumped into me...");
        else outputText("had me pump into you...");
        outputText("</i>\" Ember trails off, and you can see [ember eir] hand move to [ember eir] crotch to caress [ember eir] ");
        if (emberPregged) outputText("slit");
        else outputText("cock");
        outputText(", as if remembering the intense sex session you two just had.");

        outputText("\n\nYou can't resist pointing out that [ember ey] wore out first; you were the one who had to make [ember em] keep on going...  So doesn't that make you more virile than [ember em]?");
        outputText("\n\nEmber's ");
        if (flags[kFLAGS.EMBER_ROUNDFACE] == 1) outputText("blush");
        else outputText("discomfort");
        outputText(" deepens, and [ember ey] frowns at you.  \"<i>A-are you questioning my virility!?  Well, if you want, I can go again, right now!</i>\"");

        outputText("\n\nYou stifle a laugh and tell [ember em] that's not necessary.  Still, you do want to know if [ember ey] thinks the two of you are going to have a baby now.");

        outputText("\n\nEmber blows an indignant puff of smoke.  \"<i>Yes, like I said.  I'm pretty sure it took...  I mean...  We were tied, and when dragons are tied, we are sure to get pregnant.</i>\"");

        outputText("\n\nYou nod in understanding, and then innocently comment that if it didn't take, well, maybe you'll need to try that again.");

        outputText("\n\nEmber ");
        if (flags[kFLAGS.EMBER_ROUNDFACE] == 1) outputText("blushes");
        else outputText("frowns");
        outputText(" once more.  \"<i>D-don't get ahead of yourself!</i>\" [ember ey] yells indignantly, then gets up and rushes away.  You watch and give a smile; [ember ey] is champing at the bit to make children with you, but can't bring [ember emself] to confess how [ember ey] really feels.  Still, you're quite certain your efforts took.");
        //(if PC now pregnant:
        if (!emberPregged) outputText("  You touch your belly with a smirk.  Very certain they took indeed...");
        doNext(playerMenu);
    }

    private function emberPregUpdate():Boolean {
        //trace("EMBER PREG: " + flags[kFLAGS.EMBER_INCUBATION] + "EMBER AFF: " + emberAffection());
        switch (pregnancy.eventTriggered()) {
            case 1: //
                outputText("\nEmber's belly seems to be swelling; it looks like your seed took after all.  The dragon makes no obvious sign that she's noticed the weight she's putting on, and you don't think it would be wise to draw attention to it, even if it is \"<i>only</i>\" a pregnancy bulge.\n");
                return true;
            case 2:
                if (flags[kFLAGS.EMBER_OVIPOSITION] > 0) {
                    outputText("\nEmber's belly grows ever bigger, making her pregnancy noticeable.  She looks very sexy knocked up like that...  You shake your stray thoughts away.\n");
                } else {
                    outputText("\nEmber's belly grows ever bigger, making her pregnancy noticeable.  Her swollen midriff suits her well; to be honest she looks pretty sexy like that.\n");
                }
                dynStats("lus", (5 + player.lib / 20), "scale", false);
                return true;
            case 4:
                outputText("\nEmber's belly has grown quite a bit.  Anyone can tell she's pregnant with a single glance.  ");
                if (flags[kFLAGS.EMBER_OVIPOSITION] > 0) {
                    outputText("Ember notices you looking.  \"<i>W-what? Never seen a pregnant woman before?</i>\" she asks indignantly, although she can't hide her smile as you continue to look.\n");
                } else {
                    outputText("Ember catches you looking" + (flags[kFLAGS.EMBER_ROUNDFACE] == 1 ? " and blushes" : "") + ".  \"<i>W-what is it?</i>\"  You reply merely that she carries a baby bump very well; she looks good pregnant.  \"<i>Oh, uh...  Thanks I guess?</i>\" she replies, looking away and flicking her tongue out nervously.\n");
                }
                return true;
            case 5:
                if (flags[kFLAGS.EMBER_OVIPOSITION] > 0) {
                    outputText("\nYou hear Ember groan, then sit down.  You rush to her side, asking if she's all right.  \"<i>Yes, I'm fine. Just a bit tired.</i>\"  She reassures you; then takes your hand and presses it against her belly.  You feel something hard and slightly round inside.  \"<i>Can you feel it?  This egg is already much larger than the others.  Proof that your seed took.</i>\" she says, smiling.  You smile back, then excuse yourself.\n");
                } else {
                    outputText("\nEmber is sitting down with a smile, rubbing her belly; you approach and ask if she's feeling well.\n\n\"<i>Yes, both of us are.  I can already feel our baby starting to move.  Do you want to feel it too?</i>\"  You respond that you do, and gently approach her, reaching out to stroke her gravid stomach, feeling the " + (flags[kFLAGS.EMBER_ROUNDFACE] == 0 ? "scales" : "skin") + " already stretched taut over her burgeoning womb.\n\nYou feel what seems to be a small kick under your hand.  A faint hint of paternal pride fills you, and you can't resist rubbing the spot where the baby kicked.  Ember sighs and lets you rub her belly to your heart's content.  Unfortunately duty calls, so you bid Ember farewell and return to your duties.\n");
                }
                return true;
            case 6:
                if (flags[kFLAGS.EMBER_OVIPOSITION] > 0) {
                    outputText("\nEmber just doesn't seem to stop growing.  You approach her and lay a hand on her belly, feeling the ever growing egg inside.  \"<i>This is going to be a pain to pass,</i>\" she says, dreading the task ahead.  \"<i>This is your fault... so I expect you to be here to help me.</i>\" Ember says.  \"<i>Now I need something to eat, I'm hungry.</i>\" Ember says, walking away to feed herself.\n");
                } else {
                    outputText("\nEmber's been getting as moody as her belly is big lately.  She constantly growls at anyone and anything that may approach her, even harmless bugs.  You decide to watch your step around her - pregnant women were scary enough back in Ingnam, and they didn't have razor-sharp teeth or the ability to breathe fire.\n\n\"<i>Something wrong!?</i>\" Ember questions you, glaring at you.  Your point proven, you tell her it's nothing, you were merely thinking of your former home.\n\n\"<i>Well if you have enough time to be reminiscing your past, how about you get over here and give me a hand instead!?  You're responsible for this, after all.</i>\"\n\nYou hasten to help her with whatever minor tasks she thinks she needs you for, until she promptly dismisses you.\n");
                }
                return true;
            case 7:
                if (flags[kFLAGS.EMBER_OVIPOSITION] > 0) {
                    outputText("\nEmber looks very tired; you're surprised she's been so active thus far with such a heavy belly.  You approach her, asking her if she needs anything.  \"<i>Yes... Umm, could you...</i>\" she replies, blushing.  \"<i>Could you rub my belly?  It would help me relax,</i>\" Ember asks.\n\nYou smile and begin rubbing her belly; while doing so you can feel the egg's hard shell stretching Ember.  Ember gives a sigh of relief and begins purring. \"<i>Ah, this feels great,</i>\" she says, happily.  You continue rubbing her belly, until she closes her eyes and begins snoring lightly.  Upon realizing Ember fell asleep you stop and walk away.  Ember must've been really tired...\n");
                } else {
                    outputText("\nEmber's been much less active nowadays, and a single look at her heavily pregnant belly lets you know why.  She is huge!  You're surprised she can even move about with a belly as big as that.  Upon closer inspection you're pretty sure you can see it squirm as the little dragonling explores its limited territory.\n\n\"<i>Hey, [name]. Fetch me some water will you?</i>\"\n\nYou decide to be generous and fetch it for her - you wouldn't be surprised if she's too heavy to get to the stream by herself.  You promptly return with a full skin and present it to her so that she can slake her thirst.\n\nEmber swipes the skin off your hands and chugs it down unceremoniously, sighing in relief once she's done.  \"<i>Ahhh, that hit the spot, thanks.</i>\"  You check to see if there's anything else she needs, but when she confirms she's fine, you nod your head, sneak a quick caress of her swollen stomach, then leave her alone.\n");
                }
                return true;
            case 8:
                if (flags[kFLAGS.EMBER_OVIPOSITION] > 0) {
                    outputText("\n\nHer breasts look bloated, and you think you can see a drop of milk leaking from one of her perky nubs.  \"<i>Help me drain these,</i>\" she says, lifting her milky jugs and letting them fall.\n\nYou ask her if she'll have enough for the baby.  \"<i>Of course I will, it won't need any milk.  At least not until it hatches.  It'll take some time until then, and my breasts feel so uncomfortable.  So don't question me, just drink it!</i>\" she demands" + (flags[kFLAGS.EMBER_ROUNDFACE] > 0 ? ", a blush forming on her cheeks at her request" : "") + ".\n\nYou nod and lay down beside her, gently taking one of her nubs inside your mouth; then you begin suckling.  \"<i>Ooooh, yes...  Keep going...  This feels so good,</i>\" she moans in equal parts pleasure and relief.\n\nYou're happy to oblige, and begin drinking without stopping.  Ember's nutritious milk fills you.  ");
                    player.refillHunger(40, true);
                    if (flags[kFLAGS.EMBER_MILK] > 0) {
                        outputText("Her breasts have always been full, but this time there's an incredible amount coming out.  She must've been really uncomfortable, and each suckle earns you a jet of milk and a moan of relief from Ember.  You keep at it for a long time; until you've drained one of Ember's ripe tits.\n\nThen you move to the other, intent on doing the same, however you feel very full already; you don't think you'll manage to empty this one.  Ember's moans of pleasure and relief push you on. You keep drinking regardless, and before you realize it, her other breast has been drained.\n\n\"<i>Ahhh, that feels much better.  I guess you're not too bad at making this feel good.</i>\" she admits" + (flags[kFLAGS.EMBER_ROUNDFACE] > 0 ? ", blushing softly" : "") + ". You stifle a burp and smile, then return to your duties.\n");
                    } else {
                        outputText("Soon, you've exhausted one of ther breasts, then you move to the other intent on doing the same; however all too soon she's drained and you're left wanting more.\n\n\"<i>Ahhh, that feels much better.  Good job,</i>\" she comments.  You smile back, then return to your duties.\n");
                    }
                } else {
                    outputText("\nYou decide to check up on Ember and see how she's been doing.  Once you're close enough she looks at you with tired eyes; clearly she hasn't been getting much sleep lately.  \"<i>[name], perfect timing!  I need you to help me drain my breasts, they're so heavy they hurt.</i>\"\n\nYou look at her breasts; they're so swollen they're at least a cup-size bigger than usual, maybe as much as two.  You can readily believe that she's in pain from carrying so much, and agree to help her out, then ask if she has any particular preferences.\n\n\"<i>Just take care of it... NOW!</i>\" Ember growls.\n\nWith a long-suffering sigh, you seat yourself down beside her, gently lift up one of her milk-bloated breasts, close your lips softly around the nipple, and start to suckle.  At once your efforts are rewarded with a long, strong gush of sweet, cool dragon-milk.  Ember sighs in relief and reaches out to hold your head against her breast.\n\nYou suckle gently, wondering how well Ember will take to nursing a real baby, but simply enjoying being so close to her.  You drink and drink, alternating between breasts, until finally you've vented the worst of the pressure, at the cost of visibly distending your own stomach with the amount of milk you've drunk.  You settle back on your [ass] and stifle a belch, looking at Ember and wondering what she thinks of your efforts to help.\n\nEmber yawns.  \"<i>Good... I feel much better, now I think I need a nap.</i>\"\n\nYou sigh softly, watch as she falls over on her side, belly visibly jiggling as she disturbs the unborn dragon in her womb, and is soon fast asleep.  You clamber back upright and leave her to get some rest; you've a feeling it won't be too long before she gives birth.\n");
                    player.refillHunger(40, false);
                }
                fatigue(-25);
                return true;
            default:
        }
        return false; //If there's no update then return false so needNext is not set to true
    }


    public function emberGivesBirth():void {
        //Ember Gives Live Birth
        if (flags[kFLAGS.EMBER_OVIPOSITION] == 0) {
            outputText("\nA roar interrupts your daily routine and you quickly run to check its source.  You see Ember doubling over and sitting inside her den, her face twisted in pain. She suddenly looks up at you.");
            outputText("\n\n\"<i>Great, you're here.  It's time!  The baby is coming.</i>\"");
            outputText("\n\nInstinctively, you try to grab her hand, reassuring her that you're here for her and you will do your best to help her.  Ember screams as another contraction hits her and she grips your hand so powerfully you feel like she's about to crush it.  You grimace in pain, but do your best to squeeze back just as hard - if only to keep her from breaking your hand.");
            outputText("\n\n\"<i>D-don't just hold my hand... do something, anything!  This hurts!</i>\" Ember yells at you in obvious pain.");
            outputText("\n\nWrenching your hand free of Ember's grasp, you take up a position squatting before her.  You can practically see her steely abdominal muscles rippling under her ");
            if (flags[kFLAGS.EMBER_ROUNDFACE] == 0) outputText("scales");
            else outputText("skin");
            outputText(" as her womb works to expel its long-time occupant.  You place a hand on either side of the distended orb and begin to massage it, trying to help soothe the strained, aching muscles.  Your eyes go from her stomach to her crotch; her vagina is opened wide as the infant inside her begins making its way into the world.");
            if (hasCock()) {
                if (flags[kFLAGS.EMBER_ROUNDFACE] == 0 && flags[kFLAGS.EMBER_INTERNAL_DICK] == 0) outputText("  Her human-like cock dangles heavily in front of her pussy, partially erect from the muscular spasms.");
                else outputText("  Her draconic cock has been pushed from its internal sheathe by the pressure, but it's too painful for her to be erect.");
            }

            outputText("\n\nMind racing, you bend your head in close and stick out your tongue, sliding it back in and out of your mouth to get it nice and wet before delivering a long, sloppy lick to her inner walls.  You can taste her, and the strange salty-blood taste of amniotic fluid mingles with her natural lubricants.  It's an unusual taste but not unbearable, and you begin to lick with greater fervor and purpose.  Your intention is to try and drown the pain of her contractions with pleasurable stimulus.  It's a crazy idea, but it makes sense in a place like Mareth.");
            outputText("\n\n\"<i>Ah!  Y-yes, don't stop.  Keep doing whatever you're doing.</i>\"  It would seem your theory was correct.  Ember's legs wrap around you, locking you in position; her tail moves to caress you, slowly coiling around your waist; her hands rub her belly, attempting to coax her unborn child out of her.");

            outputText("\n\n\"<i>I can feel it... moving... [name]... get a towel ready, it's coming!</i>\"  Ember roars in pain as the bulge inside her belly makes its way down.  You try to quickly scramble up from your position and run to grab a towel, but Ember has you in a death-grip and won't let you go, forcing you to point out you can't get a towel while you're as tangled as you are.");

            outputText("\n\n\"<i>It hurts! Do something [name]!</i>\" Ember yells, oblivious to your current state.");

            outputText("\n\nYou struggle and wrestle, but put the thought out of your mind; you can see the ");
            if (flags[kFLAGS.EMBER_ROUNDFACE] > 0) outputText("head crowning");
            else outputText("tip of the muzzle jutting out");
            outputText(", and you know you won't have time.  Instead, you gently reach into Ember's pussy, giving her a hand stretching and positioning yourself to catch your baby.  With a rock-rattling roar, Ember's final push sends her offspring out of her overstretched snatch and into your hands; a veritable fountain of juices follows suit, painting your hands, arm and face in leftover amniotic fluid.");

            outputText("\n\nHer strength depleted, Ember collapses into a panting heap and you're finally free to move.  You wrap your arms around your wriggling offspring, listening to it wail in protest, just like a human infant.  You look down at the fruit of your union and smile; it looks just like its mother, a");
            if (flags[kFLAGS.EMBER_ROUNDFACE] == 0) outputText("n anthro dragon");
            else outputText(" hybrid of human and dragon");
            outputText(".  It's a beautiful strong, healthy little ");
            var roll:int = rand(100);
            if (roll < 40) outputText("boy");
            else if (roll < 80) outputText("girl");
            else outputText("herm");
            outputText(".");

            outputText("\n\nYou cradle ");
            if (roll < 40) outputText("him");
            else outputText("her");
            outputText(" in your arms, uncaring of the stains as the fluid drenching its little body soaks into your [armor], gently soothing ");
            if (roll < 40) outputText("him");
            else outputText("her");
            outputText(".  Then, seeing Ember is recovering from her recent exertions, you grin proudly at her and gently hold your ");
            if (roll < 40) outputText("son");
            else outputText("daughter");
            outputText(" out for her to take.");

            outputText("\n\nEmber gazes at the newborn with a look of profound happiness.  \"<i>It's so beautiful...  Let me hold it, [name]...  Let me hold both of you...</i>\"");

            outputText("\n\nNot one to miss the opportunity, you pass the newborn into ");
            if (roll < 40) outputText("his");
            else outputText("her");
            outputText(" mother's loving arms and kneel beside her, embracing her in her moment of emotional openness.  Ember brings the baby to her chest, letting it take one of her nipples into its small toothless mouth and begin suckling Ember's nutritious milk.  While the baby is busy with her breast, Ember decides to busy herself with you, and pulls you into a loving kiss.");

            outputText("\n\nYou stroke her cheek back, sinking eagerly into her kiss, opening your mouth and allowing her tongue to probe teasingly into yours, brushing against your own tongue and then twining gently about it, like an amorous serpent.  Ember breaks the kiss with a sigh, tiredness overtaking [ember em].  She leans in to give you one final peck in cheek and lays down in the soft leaves that litter her den.  \"<i>Sorry... I need to sleep now...</i>\"");

            outputText("\n\nYou calmly help her down, aiding her in tucking the newborn infant safely beside her.  It continues to suckle, then sleepily detaches itself, yawns, and curls up, ready to join its mother in sleep.");
            if (emberChildren() > 1) outputText("  Your other draconic offspring quietly peek into the lair, having vacated the place when Ember went into labor.  They smile at the sight of their new sibling, gently slipping in to curl up beside the mother and new child.");
            outputText("  With a contented expression on your face, you leave Ember and your ");
            if (emberChildren() <= 1) outputText("new child");
            else outputText("newly expanded draconic brood");
            outputText(" to get some rest, leaving the den.\n");
            if (roll < 40) flags[kFLAGS.EMBER_CHILDREN_MALES]++;
            else if (roll < 80) flags[kFLAGS.EMBER_CHILDREN_FEMALES]++;
            else flags[kFLAGS.EMBER_CHILDREN_HERMS]++;
        }
        //Ember Lays Egg
        else {
            //Ignore all the effects of Dragon Milk.
            outputText("\nA roar interrupts your daily routine and you quickly run to check its source.  You see Ember doubling over and sitting inside her den, her face twisted in pain. She suddenly looks up at you.");

            outputText("\n\n\"<i>Great, you're here.  It's time!  I'm going to lay the egg.</i>\"");

            outputText("\n\nInstinctively, you try to grab her hand, reassuring her that you're here for her and you will do your best to help her.  Ember screams as another contraction hits her and she grips your hand so powerfully you feel like she's about to crush it.  You grimace in pain, but do your best to squeeze back just as hard - if only to keep her from breaking your hand.");

            outputText("\n\n\"<i>D-don't just hold my hand... do something, anything!  This hurts!</i>\" Ember yells at you in obvious pain.");

            outputText("\n\nWrenching your hand free of Ember's grasp, you take up a position squatting before her.  You can practically see her steely abdominal muscles rippling under her ");
            if (flags[kFLAGS.EMBER_ROUNDFACE] == 0) outputText("scales");
            else outputText("skin");
            outputText(" as her womb works to expel its long-time occupant.  You place a hand on either side of the distended orb and begin to massage it, trying to help soothe the strained, aching muscles.  Your eyes go from her stomach to her crotch; her vagina is opened wide as the globular egg inside her begins dropping its way into the world.");
            if (hasCock()) {
                if (flags[kFLAGS.EMBER_ROUNDFACE] > 0 && flags[kFLAGS.EMBER_INTERNAL_DICK] == 0) outputText("  Her human cock dangles heavily in front of her pussy, partially erect from the muscular spasms.");
                else outputText("  Her draconic cock has been pushed from its internal sheathe by the pressure, but it's too painful for her to be erect.");
            }
            outputText("\n\nMind racing, you bend your head in close and stick out your tongue, sliding it back in and out of your mouth to get it nice and wet before delivering a long, sloppy lick to her inner walls.  You can taste her, and the strange salty-blood taste of amniotic fluid mingles with her natural lubricants.  It's an unusual taste but not unbearable, and you begin to lick with greater fervor and purpose.  Your intention is to try and drown the pain of her contractions with pleasurable stimulus.  It's a crazy idea, but it makes sense in a place like Mareth.");

            outputText("\n\n\"<i>Ah!  Y-yes, don't stop.  Keep doing whatever you're doing.</i>\"  It would seem your theory was correct.  Ember's legs wrap around you, locking you in position; her tail moves to caress you, slowly coiling around your waist; her hands rub her belly, attempting to coax the burdensome egg out of her.");

            outputText("\n\n\"<i>I can feel it... moving... [name]... get a towel ready, it's coming!</i>\" Ember roars in pain as the bulge inside her belly makes its way down.  You try to quickly scramble up from your position, and run to grab a towel, but Ember has you in a death-grip and won't let you go, forcing you to point out you can't get a towel while you're as tangled as you are.");

            outputText("\n\n\"<i>It hurts! Do something [name]!</i>\" Ember yells, oblivious to your current state.");

            outputText("\n\nYou struggle and wrestle, but put the thought out of your mind; you can see the rounded shell of the egg poking out of Ember's netherlips, and you know you won't have time.  Instead, you gently reach into Ember's pussy, giving her a hand stretching and positioning yourself to catch your baby.  With a rock-rattling roar, Ember's final push sends the egg out of her overstretched snatch and into your hands; a veritable fountain of juices follows suit, painting your hands, arm and face in leftover amniotic fluid.");

            outputText("\n\nYou can't pay any attention to the deluge of fluids that has just splattered all over you, though; you're trying to cradle the egg without dropping it.  It's huge, far bigger than any other egg you've ever seen, and easily comparable in weight to a good-sized toddler.  No wonder Ember was sluggish with this rattling in her belly.  Finally, though, you feel you have comfortably taken hold of it and you stand up, cradling the hard-shelled egg from which, eventually, your offspring will hatch.");

            outputText("\n\nEmber pants, tired from her recent ordeal; and when she's had a moment to recover she gazes at you.  Her eyes open wide in admiration of the egg she just laid.  \"<i>It's beautiful,</i>\" Ember says lovingly.  You nod your agreement and place it gently in a nook at a sheltered side of the den");
            if (flags[kFLAGS.EMBER_EGGS] > 0) {
                outputText(", along with the ");
                if (flags[kFLAGS.EMBER_EGGS] == 1) outputText("other");
                else outputText(num2Text(flags[kFLAGS.EMBER_EGGS]) + " others");
            }
            outputText(", before telling her that she's beautiful too, and your daughters will certainly hatch and grow up to be just as gorgeous as she.");

            outputText("\n\nEmber just smiles at you and hooks her tail around your waist, pulling you towards her.  \"<i>Come here.</i>\"  You don't resist and allow her to pull you into her embrace, snuggling up against her.  Ember strokes your head, gently rubbing the back of your neck as she pulls you closer against her.  \"<i>You know, there's something else you have to do for me.</i>\"");
            outputText("\n\nYou ask her what that is.  Ember takes one of her swollen breasts in her hand, gently squeezing a droplet of milk from her perky nipples.  \"<i>These need to be drained,</i>\" she says, looking at you expectantly.");

            outputText("\n\nYou give her a knowing look and a smile, then nuzzle up to her and start to suckle.  \"<i>Hmm... there's no need to rush, they aren't going anywhere,</i>\" Ember says, sighing in pleasure and relief.  Her arms encircle you, holding you close, and her tail loops around your midriff, gently guiding your body to lay atop hers.");

            outputText("\n\nYou allow her to do as she wishes, being sure not to press on her midriff too much; after all, she did just give birth.  You nuzzle affectionately against your dragon lover, glad to take advantage of her willingness to be open with you.  Usually Ember would say something in denial and sprint away.  It's quite a relief actually, spending time like this, especially in a world like Mareth.");

            outputText("\n\nYou continue drinking, draining Ember's bloated breasts, the cool nutritious milk helps you relax for a spell and forget about your troubles.  Your ordeals are forgotten for the moments you find yourself drifting off, guided into the land of dreams by Ember's soft purring - or is it snoring?  You can't tell, and it doesn't matter right now...");
            player.refillHunger(40);
            outputText("\n\nYou wake up a short while later.  Ember's breasts are completely drained of their milk, and your belly is bulging a bit from the amount you've drank.  Ember sleeps softly under you.  Gently you extract yourself from Ember's embrace - a difficult task, considering Ember's tail is intent on holding you like a boa constrictor.  Eventually though, you manage to withdraw yourself from its insistent grip and slowly sneak out of the den.\n");
            flags[kFLAGS.EMBER_EGGS]++;
        }
        player.createStatusEffect(StatusEffects.EmberNapping, 12, 0, 0, 0);
    }


    public function giveBirthToEmberKids(womb:int = 0):void {
        var roll:int = rand(100);
        outputText("\n");
        //PC Gives Live Birth
        if (flags[kFLAGS.EMBER_OVIPOSITION] == 0) {
            //40% chance of boy, 40% chance of girl and 20% chance of both
            //(If the PC has no pussy)
            outputText("You find yourself doubling over - well, as far as you can, given your hugely gravid stomach, letting out a hollow cry of pain.  You can feel the muscles in your midriff starting to squeeze and ripple in a fashion you just know signifies the onset of labor.  You cry out for Ember to come and attend you.  Ember rushes towards you in a blur, stopping mere inches from you, panting.  \"<i>What is it?  Is it time!?  Are you in labor!?</i>\" [ember ey] asks in a hurry.  You nod and tell [ember em] that you are.");

            outputText("\n\nEmber wastes no time, [ember ey] hefts you into [ember eir] arms and takes you to [ember eir] den, gently setting you down on the soft leaves; then [ember ey] starts undressing you, stripping your [armor] as quickly as [ember ey] can.  \"<i>Okay, Okay...  What do you need?  W-what should I do!?  Do you need anything!?  How are you feeling!?</i>\" Ember asks in panic, the excitement of what's about to happen too much to bear for the dragon" + emberMF("-boy", "-girl") + ".");
            outputText("\n\nYou grit out between your teeth that you are feeling very sore, and what you want is for [ember em] to help you somewhere comfortable so you can get this slithering snake of a baby out of your guts - preferably before he or she kicks his-her way out straight through your belly rather than coming down the birth canal!");
            outputText("\n\n\"<i>Okay!  Right!</i>\" Ember hurries off to fetch a bunch of clean cloths, then spreads them all over the leafy grass of [ember eir] den.  [ember Ey] carefully helps you onto them and spreads your legs, kneeling between them.  \"<i>I'm going to try something... tell me how you're feeling.</i>\"");

            outputText("\n\nEmber lowers [ember eir] head towards your quivering "+player.vaginaDescript(womb)+", ");
            if (player.hasBalls()) outputText("slowly pushing your [balls]");
            else if (player.hasCock()) outputText("slowly pushing your " + multiCockDescriptLight());
            if (player.hasBalls() || player.hasCock()) outputText(" out of [ember eir] way, ");
            outputText("then [ember ey] blows softly on your contracting love-hole, slowly extending [ember eir] tongue to penetrate you.");

            outputText("\n\nYou moan in equal parts pleasure and pain, telling [ember em] that [ember eir] treatment feels good and is soothing.  \"<i>Please, keep going,</i>\" you plead.  You ask if [ember ey] can try to massage your stomach as well, to help relax the tension in your muscles.");

            outputText("\n\nEmber complies, digging deeper into your searing hot canal.  One of [ember eir] clawed hands gently reaches out to touch the slithering bulge within your belly, massaging you as best as [ember ey] can.  Slowly but steadily, the baby dragon within you starts making its way down your birth canal, stretching you out as it seeks freedom.");
            player.cuntChange(80, true, true, false, womb);

            outputText("\n\nYou strain with all your might, drawing on wells of inner strength you weren't even sure you had, hovering ");
            if (player.hasPerk(PerkLib.Masochist)) outputText("deliciously ");
            outputText("on the boundary between pleasure and pain.  You aren't sure how much more you can take.");

            outputText("\n\nEmber suddenly withdraws [ember eir] tongue and screams in joy, \"<i>I can see it! Push [name]!  You're almost done!</i>\"");

            outputText("\n\nWith one last hollow groan, you push as hard as you can, desperate to have your child in your arms and, more importantly, out of your womb.  There is a sudden sensation as though you are being turned inside out, and then a wonderfully, blissfully numb sensation.  You slump down, drained and exhausted, hearing the cry of your newborn baby as if from far away.");

            outputText("\n\n\"<i>...you... alright?...</i>\" You faintly hear Ember asking you.  You look into [ember eir] eyes and manage to nod weakly.  Ember's worried face turns to one of relief, [ember ey] calmly tends to the wailing dragonling while waiting for you to rest for a little while, licking it over to clean it from the fluids that came with and on your baby.");

            outputText("\n\nYou close your eyes, exhausted and happy to see your child. Before you realize it, you've passed out.  When you awaken, you find yourself lying in your " + camp.bedDesc() + ", Ember hovering protectively over you. You ask where the baby is.");
            outputText("\n\nEmber calmly smiles at you and points to your [chest].  You follow [ember eir] finger to see the little dragon nursing from your " + nippleDescript(0) + ". \"<i>Sorry.  ");

            if (roll < 40) outputText("He");
            else outputText("She");
            outputText(" was getting hungry and I didn't know what to do,</i>\" Ember explains.");
            if (flags[kFLAGS.EMBER_MILK] > 0) {
                outputText("  \"<i>I tried to feed ");
                if (roll < 40) outputText("him");
                else outputText("her");
                outputText(" myself, but ");
                if (roll < 40) outputText("he");
                else outputText("she");
                outputText(" wanted yours...</i>\"");
            }

            outputText("\n\nYou sigh softly, stroking your newborn's head even as it industriously sucks away at your " + nippleDescript(0) + ".  Speaking of which, you ask Ember what you've had - a boy?  A girl?  Both?");

            outputText("\n\nEmber sighs and smiles at you. \"<i>It's a beautiful, healthy, little ");
            if (roll < 40) outputText("boy");
            else if (roll < 80) outputText("girl");
            else outputText("herm");
            outputText(".</i>\"");

            outputText("\n\nYou smile at [ember em] and your beautiful new baby, who suddenly stops suckling, screws up ");
            if (roll < 40) outputText("his");
            else outputText("her");
            outputText(" face and starts to cry softly.  You gently help ");
            if (roll < 40) outputText("him");
            else outputText("her");
            outputText(" up onto your shoulder and gently pat ");
            if (roll < 40) outputText("him");
            else outputText("her");
            outputText(" on the back between ");
            if (roll < 40) outputText("his");
            else outputText("her");
            outputText(" little wings, eliciting a burp that clearly leaves ");
            if (roll < 40) outputText("him");
            else outputText("her");
            outputText(" feeling better.  ");
            if (roll < 40) outputText("He");
            else outputText("She");
            outputText(" coos, giggles and nuzzles into your neck, clearly happy to be here in the real world at last.");

            outputText("\n\n\"<i>I'll tend to the little one, you can just rest for a while longer,</i>\" Ember offers, taking the cute little dragon up in [ember eir] arms.  You sigh and nod your head gratefully, then lay back down to get some more rest.\n");
            if (roll < 40) {
				if (player.hasMutation(IMutationsLib.GoblinOvariesIM)) flags[kFLAGS.EMBER_CHILDREN_MALES] += 2;
				else flags[kFLAGS.EMBER_CHILDREN_MALES]++;
			}
            else if (roll < 80) {
				if (player.hasMutation(IMutationsLib.GoblinOvariesIM)) flags[kFLAGS.EMBER_CHILDREN_FEMALES] += 2;
				else flags[kFLAGS.EMBER_CHILDREN_FEMALES]++;
			}
            else {
				if (player.hasMutation(IMutationsLib.GoblinOvariesIM)) flags[kFLAGS.EMBER_CHILDREN_HERMS] += 2;
				else flags[kFLAGS.EMBER_CHILDREN_HERMS]++;
			}
        }
        //PC Lays Egg
        else {
            outputText("You find yourself doubling over - well, as far as you can, given your hugely gravid stomach, letting out a hollow cry of pain.  You can feel the muscles in your midriff starting to squeeze and ripple in a fashion you just know signifies the onset of labor.  You cry out for Ember to come and attend you.  Ember rushes towards you in a blur, stopping mere inches from you, panting.  \"<i>What is it? Is it time!? Are you ready to lay!?</i>\" [ember ey] asks in a hurry.  You nod and tell [ember em] that you are.");

            outputText("\n\nEmber wastes no time - [ember ey] hefts you into [ember eir] arms and takes you to [ember eir] den, gently setting you down on the soft leaves.  Then [ember ey] starts undressing you, stripping your [armor] as quickly as [ember ey] can.  \"<i>Okay, Okay...  What do you need?  W-what should I do!?  Do you need anything!?  How are you feeling!?</i>\" Ember asks in panic, the excitement of what's about to happen too much to bear for the dragon" + emberMF("-boy", "-girl") + ".");

            outputText("\n\nYou grit out between your teeth that you are feeling very sore, and what you want is for [ember em] to help you somewhere comfortable so you can get this huge damn egg out of you.");

            outputText("\n\n\"<i>Okay! Right!</i>\" Ember hurries off to fetch a bunch of clean cloths; then spreads them all over the leafy grass of [ember eir] den.  Carefully, [ember ey] helps you on them and spreads your [legs], kneeling between them.  \"<i>I'm going to try something...  Tell me how you're feeling.</i>\"");

            outputText("\n\nEmber lowers [ember eir] head towards your quivering [vagina], ");
            if (player.hasBalls()) outputText("slowly pushing your [balls]");
            else if (player.hasCock()) outputText("slowly pushing your " + multiCockDescriptLight());
            if (player.hasBalls() || player.hasCock()) outputText(" out of [ember eir] way, ");
            outputText("then [ember ey] blows softly on your contracting love-hole, slowly extending [ember eir] tongue to penetrate you.");

            outputText("\n\nYou moan in equal parts pleasure and pain, telling [ember em] that [ember eir] treatment feels good and is soothing. \"<i>Please, keep going,</i>\" you plead.  You ask if [ember ey] can try to massage your stomach as well, to help relax the tension in your muscles.");

            outputText("\n\nEmber complies, digging deeper into your searing hot canal; one of [ember eir] clawed hands, gently reach out to the protruding bulge within your belly, massaging you as best as [ember ey] can.  Slowly but steadily, the draconic egg within you starts making its way down your birth canal, stretching you out as it seeks freedom.");

            outputText("\n\nYou strain with all your might, drawing on wells of inner strength you weren't even sure you had, hovering ");
            if (player.hasPerk(PerkLib.Masochist)) outputText("deliciously ");
            outputText("on the boundary between pleasure and pain.  You aren't sure how much more you can take.");

            outputText("\n\nEmber suddenly withdraws [ember eir] tongue and screams in joy, \"<i>I can see it! Push [name]!  You're almost done!</i>\"");

            outputText("\n\nWith one last hollow groan, you push as hard as you can, desperate to be free of the burdensome egg.  There is a sudden sensation as though you are being turned inside out, and then a wonderfully, blissfully numb sensation.  You slump down, drained and exhausted.");
            player.cuntChange(80, true, true, false);

            outputText("\n\n\"<i>...you... all right?...</i>\" You faintly hear Ember asking you.  You look into [ember eir] eyes and manage to nod weakly.  Ember's worried face turns to one of relief, [ember ey] calmly tends to the egg while waiting for you to rest for a little while, licking it over to clean it from the fluids that came with and on the egg.");

            outputText("\n\nYou watch [ember em] as [ember ey] tends to it, and faintly ask who'll be responsible for keeping it safe until it hatches.  \"<i>Don't worry about that, [name].  I'll care for the egg.  For now, just rest,</i>\" Ember replies, leaning down to give you a little peck on the forehead.");

            outputText("\n\nYou nod wearily, lie back and close your eyes, letting yourself drift off into slumber to escape the weariness of your worn, ravaged body.");

            outputText("\n\nYou're not certain how long you were sleeping for when you finally regain consciousness.  You wake, though, to the most wonderful sensations emanating from your " + nippleDescript(0) + ", and the feel of soft hands caressing and squeezing your [chest].  You open your eyes and find Ember leaning over you, greedily nursing [ember emself] from your milk.  You can't resist asking what [ember ey]'s doing.");

            outputText("\n\nEmber ");
            if (flags[kFLAGS.EMBER_ROUNDFACE] > 0) outputText("blushes and ");
            outputText("withdraws, licking [ember eir] lips of a stray droplet of milk.  \"<i>Sorry, it's just that you looked so full, and all that milk would've been wasted...  So, I thought I could help myself, not that I've been wanting to drink your milk or anything like that.</i>\"");

            outputText("\n\nYou tell [ember em] that it's only polite to ask first.  Still, you're happy to let [ember em] drink [ember eir] fill.  It does make your breasts feel so much better.  Ember slowly makes [ember eir] way back to your awaiting nipples to resume [ember eir] drinking.");

            outputText("\n\nYou lay back and enjoy it, waiting for [ember em] to drink [ember eir] fill.  When [ember ey] is finally done, Ember gives you a small peck on the cheek and says, \"<i>Thanks for the milk.  You should rest a while longer, and I'm sorry I woke you up.</i>\"");

            outputText("\n\nYou tell [ember em] that it's fine.  Then, you give [ember em] a wry grin and tell [ember em] it's probably good practice for when the egg");
            if (flags[kFLAGS.EMBER_EGGS] > 0) outputText("s hatch");
            else outputText(" hatches");
            outputText(", anyway.  The dragon ");
            if (flags[kFLAGS.EMBER_ROUNDFACE] > 0) outputText("blushes and then ");
            outputText("scurries away, even as you pull yourself upright and get ready to go about your business.\n");
            if (player.hasMutation(IMutationsLib.GoblinOvariesIM)) flags[kFLAGS.EMBER_EGGS] += 2;
			else flags[kFLAGS.EMBER_EGGS]++;
        }
        player.createStatusEffect(StatusEffects.EmberNapping, 5, 0, 0, 0);
    }

    //Requirements (Either)
    //1 Lust Draft,
    //Libido >= 50,
    //Min Lust >= 40.
    //
    //Don't meet the reqs? No LustFuck for you!
    //Not centaur compatible as is the case will all Ember material, centaurs awkward bodies require that the entirety of the content be re-written and I'm not doing that - LD.

    //Note: This scene is meant for Tainted Ember after you've been through the lost dragon city dungeon. While we do not have the dungeon and post-quest Ember, this scene may be accessed from regular Ember's pool of scenes if her affection is High.

    private function highAffectionEmberLustFuck():void {
        clearOutput();
        var x:int = player.cockThatFits(emberVaginalCapacity());
        if (x < 0) x = player.smallestCockIndex();
        outputText("You strip your [armor] and watch Ember as [ember ey] appraises your naked body.  You can see " + emberMF("his", "her"));
        if (hasCock()) {
            outputText(" dragon cock ");
            if (internalDick()) outputText("poking out of [ember eir] protective slit");
            else outputText("growing erect");
        }
        if (flags[kFLAGS.EMBER_GENDER] == 3) outputText(" and");
        if (hasVagina()) outputText(" her pussy beginning to drip in excitement");
        outputText(".");

        outputText("\n\n\"<i>Mmm... now that's a view and a half; just look at you... what a gorgeous " + player.mf("man", "girl") + ", with such ");
        if (player.cockTotal() == 1) outputText("a wonderful " + cockDescript(0));
        else outputText(" wonderful cocks");
        outputText("... and you're all mine, here and now,</i>\" [ember ey] croons appreciatively, giving you a lewd wink and flick of [ember eir] tongue.  \"<i>Still, while I'm enjoying the view, don't keep a " + emberMF("guy", "girl") + " in suspense; what do you have planned?</i>\" [ember ey] asks, tail flicking from side to side in an amused manner.");

        outputText("\n\nYou tell [ember em] you were thinking of giving your dragon mate a proper fucking.  Maybe the two of you could use that book [ember ey] picked up from the library.");

        outputText("\n\n[ember Ey] stares at you, clearly dumbstruck.  If it was possible for a dragon to blush, " + emberMF("he'd", "she'd") + " be blushing, but the ");
        if (hasCock()) outputText("stiffness of [ember eir] cock");
        if (flags[kFLAGS.EMBER_GENDER] == 3) outputText(" and ");
        if (hasVagina()) outputText("the slickness of her pussy");
        outputText(", combined with [ember eir] general body language, makes it quite clear [ember ey] likes what you're saying.  Spinning on [ember eir] heel, [ember ey] walks away, waggling that ass of [ember eirs] as [ember ey] goes for your appreciation.  As quickly as possible without actually running, [ember ey] returns with the book in question and holds it up.  \"<i>So... what poses do you have in mind?</i>\" [ember ey] trills, anxious to hear what's on your mind.");

        //1st time:
        if (flags[kFLAGS.TIMES_EMBER_LUSTY_FUCKED] == 0) {
            outputText("\n\nYou smile and take the offered book, flipping through a few pages and showing the ones that you like the most to Ember.");
            outputText("\n\n\"<i>Little more specific, please, my mate; I can see that you favor those, but you still haven't told me which one we're doing,</i>\" [ember ey] says, playfully rolling her eyes at your silliness.");
            outputText("\"<i>All of them,</i>\" you state.");

            outputText("\n\nAn incredulous stare greets you.  Eventually, Ember manages to pick [ember eir] jaw off the ground.  \"<i>A-all of them!?</i>\" [ember ey] blurts.  You simply nod.");

            outputText("\n\n\"<i>Well, I'm all for it, but are you <b>sure</b> you have what it takes to perform all of these, one after the other, hmm?</i>\" Ember says, rolling [ember eir] eyes in good-natured exasperation.");

            //if PC has Libido or Min Lust requirements fulfilled:
            if (player.lib >= 50 || player.minLust() >= 40) {
                outputText("\n\nYou're pretty confident in your libido, the real question is if [ember ey]'ll have what it takes.");
            } else {
                outputText("\n\nEven if you can't, stamina won't be a problem.  You casually rummage through your pouches and fetch a vial of Lust Draft, displaying it to the dragon.");
                player.consumeItem(consumables.L_DRAFT);
            }
        } else {
            outputText("\n\n\"<i>I'm guessing somebody wants to try and handle all of the poses in one session again, hmm?</i>\" [ember ey] laughs, looking quite pleased at the prospect.");

            outputText("\n\nYou nod");
            if (player.lib < 50 && player.minLust() < 40) {
                outputText(", grabbing a vial of Lust Draft from your pouches");
                player.consumeItem(consumables.L_DRAFT);
            }
            outputText(".");
        }
        flags[kFLAGS.TIMES_EMBER_LUSTY_FUCKED]++;

        outputText("\n\n\"<i>Well, it's a dragon's duty to sate each and every need [ember eir] mate may have... Not that I'm not going to be enjoying every minute of it,</i>\" [ember ey] croons, long tongue slithering into the air in a lewd slurping gesture.  [ember Ey] turns and starts walking towards [ember eir] den, the tip of [ember eir] long, prehensile tail running its sensitive underside teasingly under your chin, slowly sliding off of you as [ember ey] walks away and disappears into the opening.");

        outputText("\n\nYou follow after [ember eir], feeling yourself get even harder at what you're about to do.");

        outputText("\n\nEmber has already made [ember em]self comfortable, laying flat on [ember eir] back, [ember eir] wings outspread amidst the leaves for stability, [ember eir] legs lifted up in front of [ember em] with hands wrapped around the curled crooks of [ember eir] knees to hold them out of the way.");

        //If Ember is male:
        if (flags[kFLAGS.EMBER_GENDER] == 1) {
            outputText("\n\n\"<i>I... um... well, the postures you've shown me are kind of meant more for a female dragon in the receiving position, but since I'm a boy you'll kind of have to... er... use what I do have,</i>\" he looks away in shame, though whether it's due to what he's trying to say or at the fact he lacks the parts that the poses are for is hard to say.  He swivels one arm to use his hand to spread apart his ass-cheeks, letting you get a clear look at his anus; the invitation is obvious.");
            outputText("\n\nYou lean over beside the embarrassed dragon and put a hand over his shoulder, then promise him to make him feel good and that you'll be gentle.");
            outputText("\n\nEmber looks embarrassed as he can get without blushing, then smiles happily and stares up at you with a doting smile.  His tongue slicks out to lick your cheek in an affectionate gesture.");
            outputText("\n\nYou get yourself in position and align your shaft with the dragon's puckered hole.  You hump a few times experimentally; each time your " + player.cockHead(x) + " bumps against his tight ass and threatens to push past his sphincter, the dragon gasps.  You would be worried if his gaze wasn't so lusty and expectant.");
            outputText("\n\n\"<i>P-please, stop teasing; go on.  Oh, I want you inside me so badly...</i>\" he tells you in a stage-whisper, his voice husky with want.");
            outputText("\n\nYou look into his eyes and smile, slowly pressing into his tight boy-pussy and spreading his cheeks with your girth.  Ember moans, arches his back and growls with delight, ass already clenching eagerly around your invading " + cockDescript(x) + ".  A few more humps and you feel yourself go as far inside his ass as possible.");
            outputText("\n\n\"<i>Oh... oh, Marae, I feel so full, so stuffed with my mate's cock... it feels great,</i>\" he moans, though you're well aware of the tinge of pain in his voice, the grimace of discomfort on his face.");
            outputText("\n\nConsidering what he has ahead of himself, you hope he won't be too sore by the time you're done.");
        } else if (player.cockTotal() == 1) {
            outputText("\n\n\"<i>Alright, my mate; I hope you'll find my body as pleasing as I'll find yours - use me until we're both as sated as we can be,</i>\" she says, giggling and giving you a girlish pout at her words.");

            outputText("\n\nThat's exactly what you intend to do.  You run a hand over her ass, gently fingering her wet pussy with your thumb.  She lets out a humming noise of appreciation, shivering gently, but stays quiet and still, brushing your [leg] with her long, smooth tail.");

            outputText("\n\nYou remove your thumb and show it to her.  It is dripping wet, much like her love-hole.  A small droplet falls from your thumb to hit her on her clit, causing the wet lake held within her nethers to finally flood with her arousal, leaking all over the grass inside her den.");

            outputText("\n\n\"<i>Ohhh... what's keeping you, my mate?  I'm ready - no, I'm more than ready, I want your cock in me and filling me full of seed, and I want it NOW!</i>\" she snaps... then bursts out laughing at her own melodramatics.  \"<i>But, seriously, pretty please let me have it now?</i>\" she coos.");

            outputText("\n\nYou chuckle at her reaction and align yourself with her entrance, then begin pushing yourself in.  You moan, her depths are so hot... even though her body temperature is usually slightly lower than yours.  She must've been really turned on.  She moans ecstatically, and her legs quiver as she fights the urge to wrap them around you and squeeze you tightly between them, trapping you into sliding your cock into her to the very hilt.");
            outputText("\n\nYou slide inch after inch inside her pussy with deliberate slowness, trying to savor every second of the journey down her depths.  It's not until you cannot go any further that you stop.");

            outputText("\n\nYour ");
            if (flags[kFLAGS.EMBER_ROUNDFACE] == 0) outputText("she-dragon");
            else outputText("dragon-girl");
            outputText(" moans throatily and gives you a rapturous look.  \"<i>I love you, [name]... gods, I love you so much, and I'm so happy I can finally say that to your face,</i>\" she tells you.");

            outputText("\n\nYou're happy to finally hear that from her too.  But as much as you appreciate the feelings, you have more pressing matters to attend to.");
        }
        //else if Ember has a pussy and the PC more than one cock:
        else {
            outputText("\n\nEmber's eyes are fixated on [eachCock], and she swallows softly.  Embarrassed, she says, \"<i>P-perhaps you'd like to use ");
            if (player.cockTotal() == 2) outputText("both");
            else outputText("two");
            outputText(" of those?  I-I know it's not exactly part of the pose and all, but...</i>\"");

            outputText("\n\nYou blink your eyes.  Is she implying what you think she is?");

            outputText("\n\n\"<i>Do you think I'm implying I would like to be doubly stuffed with my mate's wonderful dicks?</i>\"  Ember giggles.  \"<i>Well, then the answer is yes...  Oh, won't you please?</i>\"  She coos, batting her eyelids at you in an effort to entice you.");

            outputText("\n\nIt is kind of funny, seeing the dragon's attempt at giving you pleading eyes... but also undeniably cute.  How could you refuse such a request!");

            outputText("\n\nYou lean over, giving her a quick peck on her lips and then look down at her wet pussy.  Slowly you run a hand over her ass, pressing a teasing finger into her opening.  She croons and swishes her tail appreciatively at the attention.  A thin stream of juice runs down her succulent netherlips and down her crack, over her ass.  You finger her a little more and pull out to probe her little pucker.  At this she makes a quiet little noise, wriggling at the pressure, but otherwise doesn't complain.");

            outputText("\n\nYour slick fingers push inside her without trouble, despite her involuntary attempts at resisting.  Slowly you finger her ass, making sure she's nice and slick for your shafts.  A lewd moan crawls up from the depths of her throat, the dampness of her cunt as it dribbles lubricants down her crack");
            if (flags[kFLAGS.EMBER_GENDER] == 3) outputText(", not to mention the stiffness of her dick");
            outputText(", making it obvious she's ready.  \"<i>Oh, my mate... Please, fill me now!  Quit teasing me and just shove your cocks up your dragon's ready holes, jam them in as far as they can fit!</i>\" she pleads, but unable to meet your eyes in her embarrassment at her dirty talk.");

            outputText("\n\nYou have the urge to do just that, but you'd also like to savor it.  You align your shafts with her ready holes and begin pushing in.  It's a strange, but pleasant, feeling.  Her ass tries to reject the intruding advances of your " + cockDescript(x) + ", while her pussy seems intent on pulling your other " + cockDescript(x) + " in.  It only takes a couple insistent humps before you pierce the barrier formed by her sphincter and penetrate her ass.");
            outputText("\n\nEmber cries out, her whole body quivering in delight, both holes squeezing and clenching as they try to suck you inside");
            if (flags[kFLAGS.EMBER_GENDER] == 3) outputText(", cock dribbling precum onto her belly");
            outputText(".");

            outputText("\n\nThe feeling of having ");
            if (player.cockTotal() == 2) outputText("both ");
            else outputText("two of ");
            outputText("your cocks enveloped in slick tightness and warmth is almost enough to make you fill her up with your seed right then and there, but somehow you manage to hold on.");

            outputText("\n\nYour ");
            if (flags[kFLAGS.EMBER_ROUNDFACE] == 0) outputText("she-dragon");
            else outputText("dragon-girl");
            outputText(" moans throatily and gives you a rapturous look.  \"<i>I love you, [name]... gods, I love you so much, and I'm so happy I can finally say that to your face,</i>\" she tells you.  Then she starts looking less in love and more in lust.  \"<i>But I also just love these cocks; these two wonderful breeding rods - come on, mate!  Breed your horny dragon!</i>\" she commands lustfully.");
        }

        outputText("\n\nYou take Ember's legs and support them over your shoulders.  This allows you to hug around them and slide your hips even closer to [ember em].  Eyes glittering with wanton lust, unabashed in [ember eir] naked desire for you, the dragon braces [ember em]self against the leafy bedding of [ember eir] den and waits for you to begin, fingers rustling through the leaves and grass.");

        outputText("\n\nYou begin humping away, slowly at first, but quickly speeding your tempo until the cave is flooded with the noise of your crotch slapping against " + emberMF("his butt", "her soft folds") + ".  Ember groans and gasps, thrusting [ember eir] ass back against you, " + emberMF("his ass", "her cunt"));
        if (hasVagina() && player.cockTotal() > 1) outputText(" and ass");
        outputText(" rippling and squeezing your intruding member");
        if (hasVagina() && player.cockTotal() > 1) outputText("s");
        outputText(".");

        outputText("\n\nHearing your dragon mate's moans of approval you redouble your efforts at pistoning into [ember em], giving that tight ");
        if (hasVagina()) outputText("vagina");
        else outputText("ass");
        outputText(" of [ember eirs] the pounding it deserves.");

        outputText("\n\n\"<i>C-come on... cum into me, please!  Fill me with your seed!</i>\" Ember gasps, pleading with you.");

        outputText("\n\nYou penetrate [ember em] once, twice and finally hilt as much of your " + cockDescript(x) + " as you can inside " + emberMF("his", "her"));
        if (hasVagina()) {
            outputText(" slick pussy");
            if (player.cockTotal() > 1) outputText(" and tight ass");
        } else outputText(" tight ass");
        outputText(" and blow your load.");

        outputText("\n\nEmber howls exultantly as your steaming load gushes inside of [ember em].  [ember Eir] ");
        if (hasVagina()) {
            outputText("cunt shudders, splashing femcum all over your intruding shaft");
            if (flags[kFLAGS.EMBER_GENDER] == 3) outputText(", and her ");
            else outputText(", ");
        }
        if (flags[kFLAGS.EMBER_GENDER] == 3 || flags[kFLAGS.EMBER_GENDER] == 1) {
            outputText("cock erupts, spraying draconic cum up into the air to rain back down upon [ember eir] body, spattering [ember em] in [ember eir] own juices and ");
        }
        outputText("leaving [ember em] gasping for breath as the climax ebbs away.");

        outputText("\n\nThe two of you pant in unison, it takes only a few moments of getting your breath back before you pull out of [ember eir] hole");
        if (hasVagina() && player.cockTotal() > 1) outputText("s");
        outputText(", letting a satisfying stream of white mat the leaves below.  You smile at Ember, shaft");
        if (player.cockTotal() > 1) outputText("s");
        outputText(" still flagging above [ember em].");

        outputText("\n\n\"<i>Still not satisfied?</i>\" [ember ey] croons, tenderly brushing your cheek.  Then [ember eir] lips curl into a wicked, fang-baring grin.  \"<i>Good.  Neither am I.  Time for round two...</i>\"  [ember Ey] wriggles about under you, repositioning [ember em]self so that [ember ey] is on [ember eir] hands and knees, tail curled back out of the way and looking over [ember eir] shoulder under [ember eir] wing at you.  \"<i>Well?  What are you waiting for, an engraved invitation?</i>\" [ember ey] teases you.  A shake of the hips makes it quite clear [ember ey] is expecting you to take [ember em] from behind, now.");

        outputText("\n\nYou caress [ember eir] tail, as [ember ey] wraps it lovingly around you, and then unceremoniously drive yourself back into [ember eir] still loose ");
        if (flags[kFLAGS.EMBER_GENDER] == 1) outputText("ass");
        else if (player.cockTotal() == 1) outputText("pussy");
        else outputText("holes");
        outputText(" with a squelch.  It feels so good... taking [ember em] one time after the other.");

        outputText("\n\n\"<i>Ughhh... lean over, grab hold of me around the belly,</i>\" the dragon instructs you, groaning in desire at being filled so.  You do as [ember ey] tells you, squeezing with all your strength.  \"<i>Not that tight, dummy!</i>\" [ember ey] snaps back, tail lightly slapping against your forehead in chastisement.  You utter an apology and loosen your grip.  \"<i>Oh, yeah, that's much better... now, hump away, or I'm going to start humping you myself,</i>\" [ember ey] says, [ember eir] smirk blatant in [ember eir] voice.");

        outputText("\n\nYou start at a steady rhythm.  Ember moans below you, [ember eir] chest vibrating with [ember eir] rumbling purr.  [ember Ey] moves in tandem with your own thrusts, helping you drive in and out of [ember eir] ");
        if (flags[kFLAGS.EMBER_GENDER] == 1) outputText("ass");
        else if (player.cockTotal() == 1) outputText("pussy");
        else outputText("holes");
        outputText(".  The wet squelching of your hips slapping against each other resounds in the den, much to your enjoyment.  \"<i>Mmm, so good... but, can't you go any harder?  Come on, my mate; I'm a dragon, not some powderpuff princess type - this is one " + emberMF("guy", "princess") + " who can most definitely take it,</i>\" [ember ey] growls to you in [ember eir] pleasure, moaning lewdly and clenching you with each stroke inside of [ember em].");

        outputText("\n\nYou do as [ember ey] suggests and begin driving yourself in and out of [ember em] with more intensity.  \"<i>Harder!  Give it to me harder!</i>\" [ember ey] snaps.  You redouble your efforts, huffing with each hip-shaking thrust into your dragon mate.  \"<i>Ah!  Just like that.  Show me that you own me, just like I own you.  Ugh!  Show me what a powerful champion you are.  Hmm!  So powerful that you can bend over a dragon like me and fuck me silly.  [name], I love you so much...</i>\" [ember ey] trails off into a rumbling purr.  Enflamed by [ember eir] encouraging words you grip [ember em] with all your might and thrust into [ember em].  You'd be worried about hurting [ember em] if it weren't for [ember eir] lewd moans at your roughness as [ember ey] does [ember eir] best to push back against you.");

        outputText("\n\nYou feel something pop inside you, and you lean over the moaning dragon below, biting [ember eir] back as you ejaculate inside once more.  Spurt after spurt of cum jets inside [ember eir] willing hole");
        if (flags[kFLAGS.EMBER_GENDER] >= 1 && player.cockTotal() > 1) outputText("s");
        outputText(".  The dragon lets out an exultant cry as [ember eir] cum-slimed ");
        if (flags[kFLAGS.EMBER_GENDER] == 1) outputText("ass squeezes");
        else if (player.cockTotal() == 1) outputText("pussy squeezes");
        else outputText("holes squeeze");
        outputText(" you, milking your ");
        if (flags[kFLAGS.EMBER_GENDER] == 1) outputText("shaft as his cock spurts dragon-seed onto the leaves below him, filling the air with the scent of spunk and matting them into a steaming morass.");
        //{twin shafts} as {her cunt spasms wetly, drenching your lap with fresh femcum} {and/or} {[her] cock spurts dragon-seed onto the leaves below {her}, filling the air with the scent of spunk and matting them into a steaming morass}
        else {
            if (player.cockTotal() == 1) outputText("shaft as her cunt spasms wetly, drenching your lap with fresh femcum");
            else outputText("twin shafts as her cunt spasms wetly, drenching your lap with fresh femcum");
            if (flags[kFLAGS.EMBER_GENDER] == 3) outputText(" and her cock spurts dragon seed onto the leaves below her, filling the air with the scent of spunk and matting them into a steaming morass");
            outputText(".");
        }
        outputText("  Groaning and moaning like a whore, the dragon's wings beat, sending  cool air wafting over your overheating bodies before [ember ey] slumps onto the ground, barely able to hold [ember em]self upright.  \"<i>...So good...</i>\"  Ember pants.  \"<i>I... uh... are you sure you want... round three?</i>\" [ember ey] asks, sounding a little tired as [ember ey] does, obviously not sure if you'll manage it.");

        //if PC has libido/lust:
        if (player.lib >= 50 || player.minLust() >= 40) {
            outputText("\n\nYou're not quite satisfied yet.  You look down at [oneCock], watching it throb, still as hard as when you first started fucking Ember.  \"<i>You-you're not sated yet?</i>\" Ember asks in awe, ");
            if (hasVagina()) outputText("her cunt starting to drip");
            if (flags[kFLAGS.EMBER_GENDER] == 3) outputText(" and ");
            if (hasCock()) outputText(emberMF("his", "her") + " cock growing hard again");
            outputText(" at the sight, equally impressed and aroused by your prodigious appetite for sex.  You did say you were going to give [ember em] the fucking [ember ey] deserves.  Ember smiles tenderly at hearing that, then growls throatily as [ember ey] stares at you with both parts adoration and lust.  \"<i>Well, in that case...</i>\"");
        }
        //Else:
        else {
            outputText("\n\nWell, you don't feel like [ember ey]'s gotten the fucking [ember ey] deserves just yet.  Besides, you did come prepared.  You take hold of your vial.  Ember smiles tenderly at you.  \"<i>You don't have to go to such lengths for me, you know?  Still, I'm glad you like fucking me so much.</i>\"  You smile back and pop the cork, downing the draft in one big chug.  Ember watches in amazement as [eachCock] goes back into a raging erection.  As the dragon watches, ");
            if (hasVagina()) outputText("her cunt starts to drip with moisture");
            if (flags[kFLAGS.EMBER_GENDER] == 3) outputText(" and ");
            if (flags[kFLAGS.EMBER_GENDER] == 3 || flags[kFLAGS.EMBER_GENDER] == 1) outputText(emberMF("his", "her") + " cock begins to grow erect again");
            outputText(", amazement giving way to arousal.  [ember Ey] licks [ember eir] lips with [ember eir] inhuman tongue, clearly eager to begin again.");
        }

        outputText("\n\nEmber crawls over towards you, gripping the base of your shaft");
        if (player.cockTotal() > 1 && hasVagina()) outputText("s");
        outputText(" tenderly yet firmly, stroking you slowly.  \"<i>I can't believe how hot I get when I see you sporting ");
        if (player.cockTotal() == 1) outputText("this");
        else outputText("these");
        outputText(".  It's just so... intoxicating... your scent, the way you look at me, everything really.</i>\"  You pat Ember's head");
        if (flags[kFLAGS.EMBER_ROUNDFACE] == 1 || flags[kFLAGS.EMBER_HAIR] > 0) {
            outputText(", ruffling " + emberMF("his ", "her "));
            if (flags[kFLAGS.EMBER_HAIR] >= 2) outputText("mane");
            else outputText("hair");
        }
        outputText(".  [ember Ey] leans against your hand, hugging your midriff and letting your shaft");
        if (player.cockTotal() > 1) outputText("s");
        outputText(" brush against [ember eir] cheek.");

        outputText("\n\nThe dragon smiles at you, and then Ember opens [ember eir] mouth, letting [ember eir] inhuman tongue slither out-and-out.  With lovingly lavish strokes it slides up and down your [cock biggest]'s length, cleaning it of your ");
        if (flags[kFLAGS.EMBER_GENDER] >= 0) outputText("mingled ");
        outputText("fluids before sinuously coiling around it like a snake, surrounding you in cool, slick, velvet.  Insistently it begins to slide back into [ember eir] mouth, taking your cock along for the ride until the dragon closes [ember eir] mouth, enveloping your shaft in the process, and starts to suckle eagerly, [ember eir] tongue caressing and squeezing inside as [ember ey] does so.");

        outputText("\n\n You moan as the dragon begins sucking you off.  It's hard to believe how into you [ember ey] is now... previously [ember ey] didn't seem to like blowing you, but now?  [ember Ey] does it with such eagerness, you can't help but reward [ember eir] with a few spurts of pre.");

        outputText("\n\nEmber slurps and sucks loudly and lewdly, her tongue continuing its dance around your dick, but then it uncoils and [ember ey] pulls off with a wet pop, her fingers gently stroking the sensitive flesh, blowing a ticklish breeze over it with [ember eir] lips.");

        outputText("\n\n\"<i>Do you like it?  When I blow you?</i>\" [ember ey] looks up at you expectantly.  It's hard not to like it when [ember ey] does such a fine job.  At this [ember ey] smiles.  \"<i>I'm glad you like it.  I really like your taste, you know?</i>\"  Ember gets up and walks towards the far wall of the den, sticking [ember eir] ass out and swaying [ember eir] tail enticingly.  [ember Ey] looks back lovingly at you and blows you a ring of smoke, blowing a straight line through its center shortly after.  \"<i>I'm ready...</i>\" [ember ey] whispers.");

        outputText("\n\nYou advance on [ember em], roughly gripping [ember eir] butt and spreading [ember eir] cheeks, as you plunge yourself back into [ember eir] ");
        if (flags[kFLAGS.EMBER_GENDER] == 1) outputText("depths");
        else outputText("nethers");
        if (hasVagina() && player.cockTotal() > 1) outputText(" and depths");
        outputText(".  \"<i>Ahn.  D-deeper...</i>\"  You hook your arm under [ember eir] knee and pull [ember eir] leg up, nearly throwing the dragon off balance.  \"<i>Ah!  D-do you like it when I let you take charge?  Ugh- oh!  Well, I think maybe I kind of like letting you be in charge, too...</i>\"  You barely pay attention to [ember eir] teasing remarks, instead focusing on exploring [ember eir] cummy ");
        if (flags[kFLAGS.EMBER_GENDER] == 1) outputText("ass");
        else if (player.cockTotal() == 1) outputText("pussy");
        else outputText("love-holes");
        outputText(".  \"<i>Uhn... yes...  take me again.</i>\"  [ember Ey] lets [ember eir] tongue loll out as [ember ey] pants in pleasure.");

        outputText("\n\nMoans fit to make a whore blush spill from Ember's throat as [ember ey] eagerly grinds and thrusts against you.  [ember Eir] inner walls grip and squeeze around ");
        if (hasVagina() && player.cockTotal() > 1) outputText("both of your dicks");
        else outputText("your dick");
        if (hasVagina()) outputText(", moisture drenching the cock buried in her cunt as it slobbers greedily across your burning flesh.");
        if (hasCock()) outputText("  [ember Eir] cock throbs and pulsates, ripples of arousal giving way to cumvein-bulging jets that shoot from [ember eir] prick to splatter wetly against the wall.");
        outputText("  Wobbling unsteadily, the dragon becomes increasingly dependent on you to hold [ember em] upright - a climax is coming, and it looks like it's going to be big...");

        outputText("\n\nYou release [ember eir] leg and grab [ember em] by [ember eir] midriff, pulling [ember em] against you and letting [ember em] literally fall into your arms, penetrating your dragon mate deeper than ever.  With a thunderous roar that rattles off of the walls of [ember eir] den, Ember cums, ");
        if (hasCock()) {
            outputText(emberMF("his", "her") + " cock fountaining seed across the wall, practically whitewashing it in steaming hot dragon-spunk");
        }
        if (flags[kFLAGS.EMBER_GENDER] == 3) outputText(" and ");
        if (hasVagina()) outputText("her cunt gushing female ejaculate, almost soaking you with the cascade of feminine fluids and puddling wetly against your [feet]");
        outputText(".");

        outputText("\n\nEmber's orgasm forces your own.  You spew wave after wave of liquid love into [ember eir] used ");


        if (flags[kFLAGS.EMBER_GENDER] == 1) outputText("ass");
        else if (player.cockTotal() == 1) outputText("pussy");
        else outputText("love-holes");
        outputText(", feeling the excess slide out around your cock");
        if (hasVagina() && player.cockTotal() > 1) outputText("s");
        outputText(".  \"<i>Ahh... more seed from my lover...</i>\" [ember ey] whispers, nearly passing out from the pleasure.  You feel yourself grow dizzy with pleasure and tumble onto the soft grass covering the den's floor, bringing Ember along.  Your dick");
        if (hasVagina() && player.cockTotal() > 1) outputText("s");
        outputText(" slide");
        if (player.cockTotal() == 1) outputText("s");
        outputText(" out of [ember eir] with a wet slurp, allowing your deposit to leak its way under your prone forms.");

        outputText("\n\nYou both take a few moments to catch your breath, before Ember rolls over to look at you.  [ember Ey] extends a clawed hand to lightly brush your cheek.  \"<i>[name]... you really know how to make a dragon feel loved...</i>\"  You return the gesture, telling [ember em] it's easy when a dragon seems to love you just as much.  Ember smiles adoringly at you.  \"<i>Hey, can I ask you something, [name]?</i>\"  You indicate that it's okay.  \"<i>I want to be with you... hold you for a little while... is it okay if we do that?</i>\"");
        player.sexReward("vaginalFluids");
        dynStats("sen", -5);
        //[Yes] [No]
        menu();
        addButton(0, "Yes", stayWithEmberAfterLustFuck);
        addButton(1, "No", noStayingForCuddlesPostLustFuck);
    }

    //[=No=]
    //Less time used (Only 1 hour.)
    //Fatigue stays gained, whereupon it's lost if PC stays and rests? (Sure!)
    private function noStayingForCuddlesPostLustFuck():void {
        clearOutput();
        outputText("You tell Ember that you can't stay, you have to get going now.  [ember Ey] looks a bit disappointed, but forces [ember em]self to smile all the same.  \"<i>I understand, you have other things to do... just know that I'll always be here for you, for better or worse.</i>\"  You ");
        //50 or less Corruption:
        if (player.cor < 50) outputText("thank her for being so understanding");
        else outputText("grunt an acknowledgement");
        outputText(" and then gather your things before heading off to wash yourself down.");
        endEncounter();
    }

    //[=Yes=]
    private function stayWithEmberAfterLustFuck():void {
        clearOutput();
        var x:int = player.cockThatFits(emberVaginalCapacity());
        if (x < 0) x = player.smallestCockIndex();
        outputText("With a smile, you tell [ember em] that you'd be happy to.  \"<i>Great, come here...</i>\" [ember ey] croons, scooting over towards you.  You open your arms and allow the dragon to snuggle up against you, folding your arms comfortably under [ember eir] wings.");

        //If Ember is male:
        if (flags[kFLAGS.EMBER_GENDER] == 1) {
            outputText("\n\nAs you embrace each other, you feel something stirring against your " + player.skinFurScales() + ".  Breaking up the hug to look downwards you spot Ember's draconic member, erect once more.  \"<i>I... well... you can't expect me to keep it down when I'm holding my naked mate now, can you?</i>\" he states, quite flustered at his reaction.  [OneCock] growing erect, brushing against his, serves as your answer.");

            outputText("\n\nEmber trembles at the contact, electrical waves of pleasure coursing through his body as your members touch.  \"<i>T-That felt good!</i>\" he exclaims, humping slightly to rub your shafts together once more.  \"<i>Yes...  [name], how about we rub one off together this time?  I like how naughty this feels; besides my ass is still pretty sore and I can't hold you if you take me from behind...</i>\"");

            outputText("\n\nYou can't see any reason not to, and tell him so.");
            menu();
            addButton(0, "Next", frottingWithEmber);
        }
        //else if Ember is female:
        else if (flags[kFLAGS.EMBER_GENDER] == 2) {
            outputText("\n\nEmber hugs you tightly, pressing you against her bosom.  You enjoy the feel of the dragon's ");
            if (flags[kFLAGS.EMBER_MILK] > 0) outputText("milk-filled ");
            outputText("breasts against you, soft, smooth, and slightly cooler than you are.  You just enjoy each other for a while, until you feel your shaft stir once more.  Ember's nostrils flare for a moment and she smiles knowingly at you.  \"<i>Haven't had enough of me yet?</i>\"  You turn the question back on her, asking if she's saying she's had enough of you.  \"<i>I can safely say that I can never have enough of you... I'm soaking wet already.</i>\"  The dragon");
            if (flags[kFLAGS.EMBER_ROUNDFACE] > 0) outputText("-girl");
            outputText(" takes your hand and presses it against her wet quim.  Your fingers instinctively move, sliding themselves over and slightly into the damp netherlips.  \"<i>Ooh... that feels nice... but know what would feel even better?</i>\" she asks teasingly as she strokes your side.  Playfully, you ask her what that might be.");

            outputText("\n\nEmber reaches down, gripping the base of your [cock biggest].  \"<i>This.</i>\"  You can't resist teasing Ember that she's quite a horny girl, now.  \"<i>Only when I'm with you.</i>\"  She giggles.  \"<i>Truth is I've always been like that.  I guess deep down I always knew you were my true mate, I just... well... I guess I let pride get in the way.  Sorry for being such a handful for so long...</i>\"  You place a kiss on the dragon's lips; Ember is evidently quite grateful for the excuse to shut up, because she eagerly kisses you back.");

            outputText("\n\nShe breaks the kiss and lightly strokes your shaft, smiling at you.  Then she aligns the tip of your " + cockDescript(x) + " with her pussy.");
            menu();
            addButton(0, "Next", penetrateWithEmber);
        } else {  //if Ember is herm:
            outputText("\n\nAs you embrace each other, you feel something stirring against your " + player.skinFurScales() + ".  Breaking up the hug to look downwards you spot Ember's draconic member, erect once more.  \"<i>I... well... you can't expect me to keep it down when I'm holding my naked mate now, can you?</i>\"  She states, quite flustered at her reaction.  Your own [cock biggest] growing erect, brushing against hers, serves as your answer.");
            outputText("\n\nEmber trembles at the contact, electrical waves of pleasure coursing through her body as your members touch.  \"<i>T-That felt good!</i>\" she exclaims humping slightly to rub your shafts together once more.  \"<i>This feels so good I'm getting even wetter down there,</i>\"  The herm dragon");
            if (flags[kFLAGS.EMBER_ROUNDFACE] > 0) outputText("-girl");
            outputText(" states, idly rubbing your cocks together.  One of your hands slips down between the two of you, sliding over the ridged surface of the herm dragon's cock before pressing itself against her well-used quim; sure enough, it's already drooling eagerly at the prospect of being filled again.");

            outputText("\n\n\"<i>Hmm... [name], my mate?  Feel like trying something different?  Or if you aren't, can you at least put that cock inside me once more?  I want you...</i>\"  Ember licks her lips in anticipation.");

            //[Frotting] [Penetrate]
            menu();
            addButton(0, "Frotting", frottingWithFrottingEmberHerm);
            addButton(1, "Penetrate", penetrateEmberHerm);
        }
    }

    //[=Frotting=]
    private function frottingWithFrottingEmberHerm():void {
        clearOutput();
        outputText("You think the matter over, and then slowly rub your [cock biggest] against Ember's to answer her question.  The dragon-herm gasps, then smiles lewdly at you.");
        frottingWithEmber(false);
    }

    //[=Penetrate=]
    private function penetrateEmberHerm():void {
        clearOutput();
        outputText("You decide you'd rather use her once more, so you finger her pussy once more.  \"<i>Ooh... go ahead, I belong to you, my mate,</i>\" she says, opening her legs slightly to give you better access.  You slide yourself around to properly position yourself at her entrance, and then hold yourself there, ready to begin.");
        penetrateWithEmber(false);
    }

    //Frotting:
    private function frottingWithEmber(clear:Boolean = true):void {
        var x:int = player.biggestCockIndex();
        if (clear) clearOutput();
        else outputText("\n\n");
        outputText("Ember thrusts against your shaft; the ridges of [ember eir] dick stimulate your " + cockDescript(x) + " and you moan at the feeling.  \"<i>Come on, [name].  Are you going to make me do all the work?</i>\" [ember ey] teases you.  You slowly stroke your shaft against [ember eirs], asking just what [ember ey] has in mind; wasn't [ember ey] planning on taking a breather?");

        outputText("\n\n\"<i>I'm always ready to pleasure my mate... besides, I can still hug you while we hump each other,</i>\" Ember says, grabbing you into a hug and pulling you tightly against [ember eir]self, mashing your shafts together.");

        //if PC and Ember are male:
        if (player.gender == 1 && flags[kFLAGS.EMBER_GENDER] == 1) outputText("\n\n\"<i>Sometimes I wonder what other dragons would say... I'm supposed to breed and birth a new generation of dragons into Mareth.  Yet here am I fooling around with a guy...</i>\" he smirks at you.  \"<i>But heck if I care, I love you too much to let this bother me anymore... besides maybe if we try real hard you can still get me pregnant?  Or maybe you'd prefer I got you pregnant?</i>\"  You roll your eyes and kiss him, though it fails to wipe the smirk from his face.");

        outputText("\n\nHaving your shaft pressed so tightly between the two of you stimulates your sensitive member enough that you can't help but drool pre on both your bellies.  Ember is much ahead of you, however.  [ember Eir] cock dribbles slickness, lubing your bellies up and easing the contact between your shafts, making it even easier to hump against [ember eir].");

        outputText("\n\n\"<i>Hmm... yeah... use my shaft to get yourself off.  And get me off too, you sexy beast, you.</i>\"  The dragon");
        if (flags[kFLAGS.EMBER_ROUNDFACE] > 0) outputText(emberMF("-boy", "-girl"));
        outputText("'s overly long tongue sticks out as pleasure overrides [ember eir] senses.  You groan as you slide your cock against Ember's, the thought occurring to you that this is going to be pretty messy when the inevitable comes, but you are too overwhelmed to actually say so.");

        outputText("\n\nAs if reading your mind, Ember says, \"<i>Just enjoy yourself and don't worry about any mess.  I'll clean everything up later.  Ah!  Besides, it's a dragon's duty to clean after their mate.</i>\"  Plus a dragon's pleasure to enjoy making the mess, you suggest.");

        outputText("\n\nEmber doesn't bother wasting time with idle chatter anymore, [ember ey] embraces you tightly against [ember em]self and begins truly thrusting against your slickened belly, not caring that [ember eir] pre seems to be pooling between the two of you.");
        if (hasVagina()) outputText("  Her moist dragon pussy is not helping the mess in the least.  You can smell her femcum pooling along with her pre.");

        outputText("\n\nYou match the dragon thrust for thrust and hump for hump, mewling softly; it's not like fucking a hole, but it's certainly not without its charms.  You can feel that wonderful pressure building inside you for the fourth time, and gasp to Ember that climax is close.  \"<i>Don't hold anything back...</i>\" [ember ey] whispers, kissing you deeply.");

        outputText("\n\nWith a moan and a gasp, you do as [ember ey] says, letting the pleasure wash over you and spilling seed over the dragon's belly, twitching as the sparks fly through your nerves.  Ember breaks the kiss and roars as [ember eir] own shaft joins yours in making a mess of both your bellies.  Sighing with relief as the last of it ebbs out of you, instinctively you snuggle against the slimy form of your draconic lover, holding [ember eir] closer as the last of your orgasm seeps out of you and smears you both in semen.");

        outputText("\n\nEmber breaks the hug and scoots back, sitting against the den's wall.  You keep watching [ember em] as " + emberMF("his", "she") + " scoops some of your cum from [ember eir] own body and uses it to stroke [ember em]self into another, weaker, climax.  A couple of weak ropes of jism spurt from [ember eir] tapered tip to fall weakly on the ground before [ember em].");
        if (hasVagina()) outputText("  Her other hand frigs her pussy as she comes down from her orgasm, gushing female juices and leaking some of the cum you've pumped into her earlier.");

        outputText("\n\nThe dragon");
        if (flags[kFLAGS.EMBER_ROUNDFACE] > 0) outputText(emberMF("-boy", "-girl"));
        outputText(" uses what strength [ember ey] still has to crawl over to you and slide back between your arms.  \"<i>Sorry, just had to get that last bit out of my system.</i>\"  [ember Ey] yawns lowdly.  \"<i>[name]?  How about a quick nap?</i>\"  [ember Ey] asks not even bothering to hear your reply before exhaustion gets [ember eir] and [ember ey] falls asleep, snoring lightly.  You smile at [ember em] and stroke " + emberMF("his", "her"));
        if (flags[kFLAGS.EMBER_HAIR] == 0 && flags[kFLAGS.EMBER_ROUNDFACE] == 0) outputText(" head");
        else if (flags[kFLAGS.EMBER_HAIR] == 2) outputText(" mane");
        else outputText(" hair");
        outputText(" before allowing yourself to also fall asleep.");
        player.sexReward("no");
        //doNext(14);
        menu();
        addButton(0, "Next", emberJizzbangbangEnding);
    }

    //Penetrate:
    private function penetrateWithEmber(clear:Boolean = true):void {
        if (clear) clearOutput();
        else outputText("\n\n");
        var x:int = player.cockThatFits(emberVaginalCapacity());
        if (x < 0) x = player.smallestCockIndex();
        outputText("\"<i>Go on.</i>\"  She moves her arms around you and into a hug.  \"<i>Enter me.</i>\"  With no further prelude needed, you slide yourself into the damp interior of her cunt, the organ eagerly accepting you back for the fourth time.");

        outputText("\n\nEmber embraces you tightly, caressing your sides with her clawed hand, always careful not to hurt you.  \"<i>This feels so right... but do try to be gentle, I'm still a bit sore from earlier,</i>\" she croons, kissing your cheek.  You gently play with her breasts");
        if (flags[kFLAGS.EMBER_MILK] > 0) outputText(", milk seeping across your fingers,");
        outputText(" and promise you will, sliding slowly in until you have hilted yourself yet again.");

        outputText("\n\nThe dragon");
        if (flags[kFLAGS.EMBER_ROUNDFACE] > 0) outputText("-girl");
        outputText(" moans at your ministrations");
        if (hasCock()) {
            outputText(", her draconic prick pressing tightly against you as it leaks a steady stream of pre, matting ");
            if (player.biggestTitSize() > 1) outputText("your [chest], ");
            outputText("your belly");
            if (player.biggestTitSize() > 1) outputText(",");
            outputText(" and Ember's own.");
        }
        outputText("  \"<i>Do you like playing with my body?</i>\"  Ember asks, gazing at you through half-lidded eyes.  You give her a playful smirk and run your fingers expertly over her nipples, making her moan and mewl at the stimulation and saying more than mere words could on the matter.");

        outputText("\n\n\"<i>I'm happy you enjoy my body... but did you know I enjoy yours too?  And I enjoy it a... lot...</i>\"  She whispers into your ear, licking around it with her elongated tongue.  Her roaming hands find ");

        if (player.tailType > Tail.NONE) outputText("the base of your tail, tugging lightly on it and stroking it for a moment, then her hands move on to ");
        outputText("your [butt], grabbing the ");
        outputText("cheeks.  You wriggle appreciatively under her grip, making it clear she's not half bad at this herself.  The she-dragon giggles at your compliment, coiling her tail around your [legs].  \"<i>I haven't even started playing with you properly yet, my mate, and you're already excited...</i>\"  She clicks her tongue in mock reproval.  \"<i>You're such a pervert aren't you, [name]?  Lucky for us, you are <b>my</b> pervert, and I enjoy being played with a lot... so go ahead and toy with my body as much as you want.  I'll make sure to return the favor,</i>\" she purrs lovingly, sliding her hands back up your back, ");
        if (player.wings.type > Wings.NONE) outputText("stopping momentarily to stroke along your " + player.wings.desc + " wings before continuing up and ");
        outputText("stopping at the back of your head.");

        outputText("\n\nSlowly she guides you towards one of her erect nipples.  \"<i>");
        if (flags[kFLAGS.EMBER_MILK] > 0) outputText("Drink my milk, I've been saving it up specially for you,");
        else outputText("I may not have any milk in my breasts right now, but maybe if you keep suckling I'll be able to make you some,");
        outputText("</i>\" Ember teases you.  You smile at her and accept the nipple, rolling it between your lips and exerting gentle, teasing pressure with your teeth.");
        if (flags[kFLAGS.EMBER_MILK] > 0) outputText("  You savor the resultant gush of sweet dragon's milk as it squirts obediently down your throat.");

        outputText("\n\n\"<i>Hmm... that feels nice.  Just... don't forget what's the priority here.</i>\"  She bucks against your cock, still firmly lodged inside her.");
        if (hasCock()) outputText("  A small dollop of pre escapes Ember's dragon-dick at the pleasure of the movement.");
        outputText("  \"<i>And don't forget about my other breast either.</i>\"  She takes your hand in her own and guide it to her other mound, helping you knead it.");

        outputText("\n\nYou squeeze her tit as she clearly wants you to, caressing the firm-yet-soft flesh.  As you do so, you suckle teasingly at her other nipple, ");
        if (flags[kFLAGS.EMBER_MILK] > 0) outputText("allowing milk to spill into your mouth and gulp down sweet load after load, ");
        outputText("listening to her moan softly in pleasure from your actions, feeling her netherlips rippling around your " + cockDescript(x) + ".  Your nursing is suddenly interrupted when you're pulled off Ember's breasts and into a deep kiss.  The dragon-girl shoves her tongue inside your mouth, exploring it in detail");
        if (flags[kFLAGS.EMBER_MILK] > 0) outputText(", not even caring that she's tasting her own milk as you finish gulping it down");
        outputText(".  You kiss her back as eagerly as you can until lack of air forces you to break the kiss and catch your breath.");

        outputText("\n\n\"<i>I love you so much, [name].  Cum for me...</i>\" she nuzzles you.  You couldn't resist her even if you wanted to, your over-sensitive dick spasming as you empty yourself for the third time into her well-used pussy.  Your climax triggers Ember's own, the dragon");
        if (flags[kFLAGS.EMBER_ROUNDFACE] > 0) outputText("-girl");
        outputText(" roaring towards the ceiling, then turning to look at you as her pussy constricts and milks you for all you're worth.  Already spent from your past three orgasms, you just sit back and enjoy yourself being milked by her strong vaginal muscles one last time.");
        if (player.cumQ() < 250) outputText("\n\nA mere trickle is all that leaves you, having already exhausted your supply from the last two climaxes");
        else if (player.cumQ() < 500) outputText("\n\nAlthough already well-milked by this point, your load is still big enough to compare to a normal climax, adding a few more good-sized jets to the cock-cream already stretching her belly into a slight paunch");
        else outputText("\n\nWith your prodigious output, whilst your load is vastly smaller than normal, it's still much bigger than any normal man's first time, leaving Ember moaning as her already swollen belly gains another couple of inches, looking well and truly \"ready to pop any day now\"-pregnant");
        outputText(".");
        if (flags[kFLAGS.EMBER_GENDER] == 3) outputText("  Her draconic cock throbs all the way through your orgasm, shooting blanks a few times before spurting a couple ropes of pre onto her belly.");

        outputText("\n\nThe two of you collapse into each other's arms.  You move to pull out, but Ember stops you by holding your hips in place.  \"<i>Leave it inside... that's where it belongs.</i>\"  She smiles at you, panting a bit.  Too tired and happy to argue, you simply nod your head, rest against her, and allow sleep to claim you. You're dimly aware of Ember doing the same thing before you fade.");
        player.sexReward("vaginalFluids", "Dick");
        //doNext(14);
        menu();
        addButton(0, "Next", emberJizzbangbangEnding);
    }

    //Frotting and Penetrate connect here.
    private function emberJizzbangbangEnding():void {
        clearOutput();
        outputText("You moan as consciousness returns, dimly aware of something wet and cool wrapped around your dick, something firm and muscular wrapped around and squeezing you in the most pleasant of ways.  You open your eyes and sit up, allowing you to see Ember kneeling before you, mouth wrapped eagerly around your cock.");

        outputText("\n\n[ember Ey] looks up and smiles as well as [ember ey] can around your cock.  Inside [ember eir] mouth you can feel [ember eir] tongue wrapping tightly around you, like a snake, then [ember ey] sucks sharply, slurping on your dick like a fancy treat.  Any thoughts you might have had about speaking to [ember em] are lost as you gasp and spasm, firing a last sizable spurt of cum into the dragon's sucking mouth.  Ember is surprised at first, but quickly takes you in as far as [ember ey] can and lets you shoot straight into [ember eir] throat.  [ember Eir] tongue laps around your shaft, tasting you before [ember ey] pulls off slowly, letting some of your seed gather in [ember eir] mouth.  You moan when [ember ey] moves away, letting the cold wind bat against your sensitive shaft.  [ember Ey] opens [ember eir] ");
        if (flags[kFLAGS.EMBER_ROUNDFACE] == 0) outputText("maw");
        else outputText("mouth");
        outputText(", letting you see the whiteness on [ember eir] tongue, before tipping [ember eir] head back and gulping it down, licking [ember eir] lips and moaning as if [ember ey] was tasting a fine wine.  \"<i>Thanks for the snack, my mate.</i>\" [ember Ey] croons at you, a teasing expression on [ember eir] face.");

        outputText("\n\n[ember Ey] really does enjoy [ember eir] sessions with you, doesn't [ember ey]?  \"<i>What do you think?</i>\"  [ember Ey] grins.  \"<i>Still, I can see I picked quite a virile mate.  To be able to cum after all the sex we had previously?  You really are something else, my mate...</i>\"  [ember Ey] licks [ember eir] lips and gets up.");

        //if Ember has a dick (male/herm):
        if (hasCock()) {
            outputText("\n\n\"<i>I doubt I'd be able to even get an erection after the last session.</i>\"  Then what's that bobbing between [ember eir] legs, you note sarcastically, pointing at the erection Ember is most definitely sporting of [ember eir] own accord.");

            outputText("\n\n\"<i>Umm... okay, maybe I can still get hard, but I surely can't cum anymore.</i>\"  You look at the dragon and tap your fingers, waiting for the sheepish ");
            if (flags[kFLAGS.EMBER_ROUNDFACE] == 0) outputText("anthro");
            else outputText("monster-" + emberMF("boy", "girl"));
            outputText(" to come clean.  \"<i>Cut me some slack... I'm not made of stone, you know.  I was just giving my mate a blowjob, you can't seriously expect me not to react to that...</i>\"  [ember Ey] crosses [ember eir] arms and blows a puff of smoke as [ember ey] looks away, obviously flustered.");

            outputText("\n\nYou can't help but laugh; Ember's attitude may have perked up, but " + emberMF("he's", "she's") + " just as easy to tease as ever.  [ember Ey] blows another puff of smoke at you.  \"<i>You're lucky I love you or I swear I would make you regret teasing me.</i>\"");
        }
        outputText("\n\nYou note that your lover is still plastered in the liquid leavings of your recent lovemaking, and point that out to the dragon.");

        outputText("\n\n\"<i>Oh, don't worry about all of this, I'll get cleaned up later.  As for you, my mate, I suppose it's time you got going, huh?</i>\"  You note that [ember ey]'s right, and start picking yourself up off of Ember's bed.  \"<i>I'll help you.</i>\"");

        outputText("\n\nEmber steps outside to gather your clothes, dusting them off before bringing them for you.  The dragon is earnest in [ember eir] efforts and you find yourself dressed quite quickly, though [ember ey]'s not so professional as to resist the option to steal a few gropes in the process.  \"<i>There you go.</i>\"");

        outputText("\n\nYour dragon mate leans in to give you a quick peck on the lips.  \"<i>We should do this again sometime... I really enjoyed myself.</i>\"  [ember Ey] smiles awkwardly.  \"<i>Now I gotta get cleaned!</i>\"  [ember Ey] doesn't wait for your reply and dashes off beyond the bushes towards the nearest stream.");

        outputText("\n\nYou head off yourself, ready to resume the rest of your day.");
        //2 hours pass, PC's fatigue is healed some, Libido is reduced.
        fatigue(-20);
        endEncounter(120);
    }

    //Sleep with Ember!
    public function sleepWithEmber():void {
        //Set timeQ
        if (model.time.hours >= 21) CoC.instance.timeQ = 24 - model.time.hours;
        else CoC.instance.timeQ = 0;
        CoC.instance.timeQ += 6;
        if (flags[kFLAGS.BENOIT_CLOCK_ALARM] > 0) CoC.instance.timeQ += (flags[kFLAGS.BENOIT_CLOCK_ALARM] - 6);
        //GO!
        var chooser:int = rand(3);
        clearOutput();
        outputText("Before you turn in for the day, you decide to check up on Ember...");
        //Low affection
        if (flags[kFLAGS.EMBER_AFFECTION] < 25) {
            if (chooser == 0) {
                outputText("\n\nAs you approach the dragon's den, you yawn, the tiredness of a full day of adventuring finally catching up to you.  Distracted and sleep-deprived, you end up running into Ember.");
                outputText("\n\n\"<i>Hey! Watch where you're going!</i>\" Ember chides, but once [ember ey] sees you're not well, she adds in genuine concern, \"<i>Are you okay?</i>\"");
                outputText("\n\nYou apologize for running into the dragon, explaining that you're simply exhausted.  Several huge yawns disrupt your efforts, but you get your point across quite clearly.");
                outputText("\n\n\"<i>Huh... so why don't you go and get ready for bed instead of wandering aimlessly about?</i>\"");
                outputText("\n\nYou tell Ember that you wanted to see [ember em] and make sure everything's okay with [ember em] before you did that.");
                outputText("\n\n\"<i>Of course I'm okay.  I'm not a child that needs to be babysat.</i>\"  Ember takes another glance at you.  \"<i>Plus you're not in condition to check up on anything, let's get you back into your bed.</i>\"  Ember grabs your arm, leading you off to your " + camp.homeDesc() + ".  You figure [ember ey] has a point and allow [ember em] to lead you, idly wondering why the temperamental dragon seems to care about what condition you're in.");
                outputText("\n\n\"<i>Ok, here we are.  Now get undressed and get some sleep; I'll watch the camp while you get some rest.</i>\"");
                outputText("\n\nYou give the dragon a quizzical, bemused look, but as this was your intention anyway, proceed to casually slip out of your [armorName] and sink into your " + camp.bedDesc() + ".");
            } else if (chooser == 1) {
                outputText("\n\nAs you approach Ember's den, you discover the dragon is home, sitting in the shelter of [his] makeshift cave.  When you approach, you notice [ember ey] is carefully plucking the petals of a flower.");
                outputText("\n\n\"<i>Loves me... Loves me not... Loves me...</i>\"");
                outputText("\n\nYou can't believe it... You used to hear girls and even, on the rare occasion, boys, using that rhyme back in your village.  You didn't know they used the same rhyme here in Mareth, too... Wait a minute, is that really Ember doing that?!  You can't contain your disbelief and, in surprise, call out to the dragon.");
                outputText("\n\nEmber looks at you and freezes, dropping the remains of the flower on the ground, eyes wide like a deer caught in trap. Ember spins on [ember eir] heels and dashes off into the night, unfurling [ember eir] wings and flying away as fast as [ember ey] can.  You watch until the dragon vanishes from sight, feeling more confused than ever. ");
                outputText("\n\nWho in Mareth could be inspiring a proud, haughty beast like [ember em] to perform a romantic ritual like that?");
            } else {
                outputText("\n\nAs you get closer to the dragon's den, you catch sight of Ember heading off into the night.  Curious, you resolve to follow [ember em].");
                outputText("\n\nA few minutes of wandering later, Ember finally stops and looks at [ember eir] surrounding; satisfied that [ember ey]'s alone. Ember begins muttering something. You can't resist your curiosity and sneak closer so that you can eavesdrop on the dragon's words.");
                outputText("\n\n\"<i>Damn [name] for making me do this...</i>\"");
                outputText("\n\nYou watch as Ember begins caressing [ember eir] body...");
                if (hasCock()) outputText("\n\nWith one hand, Ember begins to poke at [ember eir] genital cavity, slowly brings [ember eir] cock " + (flags[kFLAGS.EMBER_INTERNAL_DICK] > 0 ? "out" : "to full mast") + ". Then [ember ey] begins stroking [ember em]self, calling your name after every muffled moan.");
                if (hasVagina()) outputText("\n\nTwo prodding fingers find their way into [ember eir] pussy; gently stroking [ember eir] outer folds, only to plunge inside, drawing a sigh of pleasure from Ember. \"<i>Oh... [name]...</i>\" Ember calls.");
                outputText("\n\nIs [ember ey]... yes, [ember ey] is. But... why? You find yourself wondering. You take pains to ensure you are truly hidden; the last thing you need is the dragon spotting you spying on [ember eir] \"<i>alone time</i>\" and going berserk. You keep silent, waiting to see if [ember ey] is really using you as masturbation fodder, or if there's a far darker element to [ember eir] fantasies.");
                outputText("\n\nEmber's breathing becomes erratic as [ember ey] strokes [ember em]self. \"<i>Ah... Yes... Give it to me... Mmm... [name]...</i>\"");
                outputText("\n\nYou don't have to wait much, as Ember reaches climax. " + (hasCock() ? "[ember Eir] cum splatters on the ground ahead of [ember em]" : "") + (flags[kFLAGS.EMBER_GENDER] == 3 ? "while" : "") + (hasVagina() ? "her juices cascade down [ember eir] legs, pooling below" : "") + " with a sigh of relief... and disappointment?  Ember begins licking [ember eir] digits clean of [ember eir] activities.  \"<i>Why does it have to be like this...</i>\"");
                outputText("\n\nYou wonder what [ember ey] is talking about, but decide that [ember eir] pride would never bear it if you approached [ember em].  You simply resolve to wait until [ember ey] has gone and keep this to yourself.");
            }
        }
        //Medium affection
        else if (flags[kFLAGS.EMBER_AFFECTION] >= 25 && flags[kFLAGS.EMBER_AFFECTION] < 75) {
            if (chooser == 0 && player.HP < player.maxHP() * 0.8) { //Lick wounds
                outputText("\n\nAs you approach Ember's den, you spot the dragon licking [ember eir] claws clean of what - you presume - is [ember eir] dinner.");
                outputText("\n\nYou call out a greeting to the dragon, asking what [ember ey] caught [ember em]self for dinner this night.");
                outputText("\n\n\"<i>Fish, some fruit... nothing special.</i>\"  Ember takes a glance at you and spots a bruise covering your arm.  \"<i>What's that?</i>\"  [ember ey] asks, pointing at your arm.");
                outputText("\n\nYou look where [ember ey] is pointing and realize [ember ey]'s indicating one of your many bruises and scrapes. You shrug it off as nothing, just a little reminder of how dangerous wandering this demon-haunted world can be.");
                outputText("\n\n\"<i>You should get that looked into... come here.</i>\"  Ember retreats into [ember eir] den.");
                outputText("\n\nA little surprised, but figuring [ember ey] can hardly make it worse, you follow the dragon into the dark, cool confines of [ember eir] den.  There you spot Ember digging into a hole on the wall.  \"<i>Here it is!</i>\"  Ember declares pulling a small jug and placing it before you.  \"<i>Sit down and let me take a look.</i>\"");
                outputText("\n\nYou make yourself as comfortable as possible on a mass of sweet-smelling grasses and leaves - Ember's bed?  \"<i>Your arm?</i>\"  [ember ey] asks, extending a hand.  You reach out and take [ember eir] hand, allowing [ember em] to examine your wounds.");
                outputText("\n\nEmber opens the jug and takes a swig.  Looking inside, you can see that it's just water.  For a moment you consider asking the dragon what [ember ey] intends to do; but before you can say anything Ember's tongue extends out of [ember eir] " + (flags[kFLAGS.EMBER_ROUNDFACE] == 0 ? "maw" : "mouth") + " and [ember ey] begins licking your arm. You watch, bewildered, and ask why [ember ey]'s doing that.  Ember stops [ember eir] licking.");
                outputText("\n\n\"<i>I'm cleaning your wounds.  What does it look like I'm doing?</i>\"  Ember resumes licking your arm.");
                outputText("\n\nYou tell [ember em] that you can see that, but why is [ember ey] licking you instead of using some of your medicinal salve?");
                outputText("\n\nEmber shudders.  \"<i>Yuck!  That thing smells terrible!  Besides, I'm pretty sure my saliva is just as good, if not better.  Look...</i>\" Ember presses on one of your cuts.");
                outputText("\n\nYou wince, already anticipating a stab of pain, but... it doesn't hurt like you expected. You can definitely feel [ember em] exerting pressure on your injury, but it's still not the pain you expected.  Having made [ember eir] point, Ember takes another swig off the jug and resumes [ember eir] licking.");
                outputText("\n\nYou sigh softly, still at least a little weirded out, but, hey, it's not hurting and it is doing you good, right? So, you let [ember em] keep at it.");
                outputText("\n\nBy the time Ember is done, your arm barely hurts anymore.  You examine the wounds and realize that, while they still look ugly, they do seem to be mending.  You thank Ember for [ember eir] help.  \"<i>You're welcome... just be more careful.</i>\"");
                outputText("\n\nYou promise you'll try your best, but this world doesn't always give you the chance.  Stifling a yawn, you thank [ember em] for [ember eir] help once more and then make your way back to your " + camp.homeDesc() + " and the siren-call of your bed.");
            } else if (chooser == 1) {
                outputText("\n\nAs you approach Ember's den, you notice that something is amiss... upon closer inspection you conclude that Ember is not home... could [ember ey] still be out, flying and exploring?");
                outputText("\n\nWell, Ember is a big " + emberMF("boy", "girl") + ", you're pretty sure [ember ey] can handle [ember emself]; so you decide to go back to your " + camp.homeDesc() + ".");
                outputText("\n\nAs you enter your " + camp.homeDesc() + ", you are greatly surprised to see your " + camp.bedDesc() + " occupied by a certain sleeping " + (flags[kFLAGS.EMBER_ROUNDFACE] == 0 ? "dragon" : emberMF("dragon-boy", "dragon-girl")) + "; and judging by the state of the " + camp.bedDesc() + " as well as the... messy... way Ember is sleeping, it would seem [ember ey] tosses around in [ember eir] sleep. With a sigh, you clear your throat to wake up Ember.");
                outputText("\n\nEmber yawns and mutters something about you getting back to bed... well... you'd love to, so you decide to be a bit more aggressive and shake Ember awake.");
                outputText("\n\n\"<i>Wha... Ok! I'm up, I'm up!</i>\" Ember complains, rubbing the sleep off [ember eir] eyes. \"<i>What is it?</i>\"");
                outputText("\n\nCurious, you ask if there's any reason for Ember to be lying in your bed. Ember gasps and is overtaken by a deep *scales can't blush*.");
                outputText("\n\n\"<i>I-I just wanted to see what it felt like sleeping in one of those,</i>\" Ember states, trying to sound calm and collected.");
                outputText("\n\nWell, now [ember ey] knows, so if [ember ey] would kindly head back into [ember eir] den, you'd like your " + (flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 ? "bed" : "bedrpll") + " back now.");
                outputText("\n\n\"<i>Actually, I might keep this.  It's pretty comfortable compared to sleeping on a bunch of leaves...</i>\"");
                outputText("\n\nReally? So [ember ey] wants to keep the " + camp.bedDesc() + " you've been sleeping in after long, arduous days of adventuring? Granted you do clean it up once in a while, it should still smell heavily of you. Won't [ember ey] be bothered by that? You ask, smirking.");
                outputText("\n\nEmber's cheeks glow *scaly*. \"<i>Yuck! No! You can keep it!</i>\" Ember scrambles to [ember eir] feet and dashes out of your " + camp.homeDesc() + " in a rush.");
                outputText("\n\nYou chuckle, it seems Ember took the bait... Now that your " + camp.bedDesc() + " is dragonless, you carefully set it up and lay down to rest for the night... Before you go though, you note that some of Ember's own scent seems to have rubbed off on it... it's not unpleasant, just different... maybe you could get used to this...");
            } else {
                outputText("\n\nAs you approach Ember's den, you notice that something is amiss... upon closer inspection you conclude that Ember is not home... ]could [ember ey] still be out, flying and exploring?");
                outputText("\n\nWell, Ember is a big " + emberMF("boy", "girl") + ", you're pretty sure [ember ey] can handle [ember emself]; so you decide to go back to your " + camp.homeDesc() + ".");
                outputText("\n\nWhen you enter your " + camp.homeDesc() + ", you notice something unusual laying atop your " + camp.bedDesc() + ". It's a bloom you haven't seen before, no matter how far and wide your travels, with an almost heart-shaped blossom made from concentric rings of petals; purple, pink and gold. Its beautiful and it smells sweet, clean and pure. You wonder who would be responsible for this unexpected gift, but no one seems to be around... scratching your head in thought you walk outside and realize a very distinct set of prints going in and out of your " + camp.homeDesc() + "; using the survival skills you've developed, you conclude that these prints could only belong to Ember, and seem recent too... Considering the dragon's temper, you understand why [ember ey] didn't stick around to give it to you [ember em]self, still that was sweet...");
            }
        }
        //High affection
        else {
            chooser = rand(3);
            if (flags[kFLAGS.SLEEP_WITH] != "Ember" && flags[kFLAGS.BENOIT_CLOCK_BOUGHT] > 0) outputText("\n\nYou enter your cabin to take your alarm clock with you before you depart to Ember's den.");
            if (chooser == 0 && flags[kFLAGS.EMBER_MILK] > 0 && flags[kFLAGS.TIMES_SLEPT_WITH_EMBER] > 0) { //Milk time!
                outputText("\n\nYou decide to take Ember up on [ember eir] offer and crash inside [ember eir] den. On your way, though, you fail to spot the dragon anywhere; [ember ey] must be inside... so you decide to enter [ember eir] den and check up on [ember em].");
                outputText("\n\nWhen you finally enter Ember's den, you see that Ember already there, seated on [ember eir] nest.  However, what is unusual is the fact [ember ey] is practically mauling [ember eir] breasts, growling and hissing with obvious frustration, which prompts you to ask what's wrong.");
                outputText("\n\n\"<i>These are.</i>\"  Ember states, pointing to [ember eir] breasts.  You look at [ember eir] bountiful F-cups; they look alright to you, and you point this out.  Then, however, you catch sight of something; thin droplets of milk, beading at the tips of [ember eir] very sore-looking nipples.  You ask if [ember ey]'s feeling a bit... pent up?");
                outputText("\n\n\"<i>Yeah... they feel so bothersome, so bloated, so full... Argh!  I can't sleep like this!</i>\"");
                outputText("\n\nYou ask if there's anything you can do to help; maybe you could try and milk [ember eir] breasts?");
                outputText("\n\n\"<i>Yeah... maybe you could try...</i>\" Ember replies, a bit embarrassed.");
                outputText("\n\nYou promptly position yourself in the proper place and begin to gently rub and squeeze the dragon's bountiful breasts. Despite your efforts, no matter how you caress or grope or roll your fingers, only a small trickle of fluid reluctantly seeps from either nipple.");
                outputText("\n\n\"<i>Come on!  Isn't there a better way you can do this?  At this rate it'll be morning before I'm drained,</i>\"  Ember protests in frustration.");
                outputText("\n\nYou note that [ember eir] breasts just don't seem to be willing to give up their contents with hand stimulation.  Perhaps if you nurse from [ember em], they'll start emptying?  It might be some strange aspect of dragons to only give up milk if they're actively being suckled from.");
                outputText("\n\nEmber rubs [ember eir] chin in thought, then with a growl finally concedes.  \"<i>Fine, do it.  Just get these emptied.</i>\"  [ember Ey] rubs [ember eir] chest for emphasis.");
                outputText("\n\nYou nod your head quietly, choosing not to offend Ember's pride, before gently reaching out to stroke [ember eir] ever-naked bosom, feeling the weight of [ember eir] breasts in your hands.  They actually feel dramatically heavier than usual... Poor thing, [ember ey] must be in such pain from it.  Not wanting to keep [ember em] waiting, you bend your head in and close your lips around the first nipple.  At once milk spurts into your mouth, cool and sweet as always, hardly needing encouragement to be coaxed from the dragon's tit into your mouth.");
                outputText("\n\n\"<i>Ah!... Be careful!  They're sensitive...</i>\" Ember scolds you, slowly leaning back to lay on [ember eir] nest.  You apologize and try to be gentler about the act, gently massaging [ember eir] breast to help relieve the tension, even as you continue to suckle the cool, sweet fluid. ");
                player.refillHunger(25);
                outputText("\n\nEmber sighs in relief.  \"<i>Ahh... just like that... You have no idea, how much of a relief this is... I felt like I was going to burst...</i>\" You're surprised by Ember's suddenly calm response; to be honest you'd already gotten used to [ember eir] rather brash behaviour... still now is not the time to ponder such things.  You've got a titful of dragon milk to empty into your thirsty belly, after all.");
                outputText("\n\nYou continue to suckle and knead, relishing the delicious treat and gently stroking your draconic lover's breasts, something [ember ey] evidently enjoys, by [ember eir] soft purring, as well as by the little sighs of pleasure.  When you judge you've vented the worst of it from the first breast, you get started on the second one, continuing your treatment.");
                outputText("\n\n\"<i>Yesss.... don't stop... hmmm...</i>\" Ember's purring rumbles louder, a quick glance at [ember eir] face reveals [ember ey] is actually smiling, eyes closed.  You're glad you seem to be doing a good job of this, and of course the milky treat helps... You have to wonder though... Despite Ember's usual production of milk being pretty high, this is a bit too much even for [ember em].  Maybe [ember ey] ate something that triggered this?  You'll just have to ask [ember em] once you're done.");
                outputText("\n\nYou drink and drink, but as you keep drinking, you become aware of a certain dampness on your cheek.  You stop your suckling and lift your head from Ember's breast to reveal that the other breast has visibly swollen back up; it's just as full of milk now as it was when you started!");
                outputText("\n\nYou ask Ember what did [ember ey] do?  It's not normal for [ember eir] milk production to be this high.  Your only reply however is a soft snore from the - now sleeping - dragon.  It seems the relief from your suckling was enough to put [ember em] out like a candle... well, anyways you did offer to help [ember em], so that's what you're gonna do.  With a sigh, you latch back onto the first breast and begin drinking anew. ");
                player.refillHunger(25);
                outputText("\n\nAfter a while, you find that whenever you suckle [ember em] in a particularly pleasurable way, you interrupt Ember's soft snoring with a sigh or a gasp, still the dragon does not wake up.  It's kinda funny actually...");
                outputText("\n\n<b>Sometime later...</b>");
                outputText("\n\nYou've been at this for quite some time now... how many times have you drained Ember's breasts?  Four?  Five?  You don't know... and besides that, you're feeling rather tired yourself... plus all this milk sloshing inside your belly does not help keep you awake... still you must press on...");
                outputText("\n\n<b>Even later...</b>");
                outputText("\n\nWith a final powerful suckle, you finally drain the last of Ember's milk... for the 8th time you believe... tired and full... you don't even bother getting off the sleeping dragon.  You settle your head between Ember's soft, milky mounds, and surrounded by their soft " + (flags[kFLAGS.EMBER_ROUNDFACE] == 0 ? "scales" : "flesh") + ", you fall asleep right there...");
                if ((player.hasStatusEffect(StatusEffects.DragonBreathCooldown) && !player.perkv1(IMutationsLib.DrakeLungsIM) >= 2) || ((player.hasStatusEffect(StatusEffects.DragonDarknessBreathCooldown) || player.hasStatusEffect(StatusEffects.DragonFireBreathCooldown) || player.hasStatusEffect(StatusEffects.DragonIceBreathCooldown) || player.hasStatusEffect(StatusEffects.DragonLightningBreathCooldown)) && !player.perkv1(IMutationsLib.DrakeLungsIM) >= 1)) {
                    if (player.hasStatusEffect(StatusEffects.DragonBreathCooldown)) player.removeStatusEffect(StatusEffects.DragonBreathCooldown);
                    if (player.hasStatusEffect(StatusEffects.DragonDarknessBreathCooldown)) player.removeStatusEffect(StatusEffects.DragonDarknessBreathCooldown);
                    if (player.hasStatusEffect(StatusEffects.DragonFireBreathCooldown)) player.removeStatusEffect(StatusEffects.DragonFireBreathCooldown);
                    if (player.hasStatusEffect(StatusEffects.DragonIceBreathCooldown)) player.removeStatusEffect(StatusEffects.DragonIceBreathCooldown);
                    if (player.hasStatusEffect(StatusEffects.DragonLightningBreathCooldown)) player.removeStatusEffect(StatusEffects.DragonLightningBreathCooldown);
                }
                player.sexReward("milk");
                fatigue(-40);
            } else if (chooser == 1 && ((player.lib + (player.cor / 2)) >= 50 || player.lust >= 70) && flags[kFLAGS.TIMES_SLEPT_WITH_EMBER] > 0) { //Lusty tease
                outputText("\n\nAfter a hard day's work, all you want to do is head to your " + camp.homeDesc() + ", flop down and pass out. Still, you figure that it couldn't hurt to check in on Ember before you turn in, maybe [ember ey]'d some company for the night... ");
                if (player.lib >= 66 || player.lust >= 90) outputText("and maybe you'll get lucky and [ember ey]'ll want to have a little fun, too?");
                outputText("\n\nAs you approach [ember eir] den, you catch a glimpse of Ember sitting in the dust outside of it, eating a little snack. Despite [ember eir] usual preference for meat, it's clearly some sort of fruit you're not familiar with... it is quite juicy though; each bite Ember takes is rewarded with a small outburst of sweet looking juice that runs down through Ember's hand and arms.");
                outputText("\n\nEmber finishes the last few bites and as you'd expect it [ember ey] begins licking the juice off [ember eir] scales, slowly licking the juice off [ember eir] arms, savouring every sensuous little lick; then moving to [ember eir] fingers. [ember Ey] picks a clawed digit and carefully encircles it with [ember eir] tongue; then slowly drags it in, gliding the claw carefully between [ember eir] lips... [ember eir] wonderfully soft lips... suckling on the finger like a teat... licking it all over to make sure it's clean... before finally pulling it out with a POP and smacking [ember eir] lips, licking them to make sure [ember ey]'s got all the juice...");
                outputText("\n\nA sudden stirring " + (player.gender > 0 ? "in your groin" : "within you") + " makes itself known; and if you didn't know any better you'd think Ember was actually putting on a show for you... [ember ey] repeats the procedure on each of [ember eir] juice-smeared fingers, ending the process with a sigh of delight. You're somewhat disappointed by the short duration of this little impromptu show... maybe you should go to sleep now...");
                outputText("\n\nBut as you are ready to turn your gaze away you spot Ember raising to [ember eir] feet and beginning to stretch. [ember Ey] puts [ember eir] arms behind [ember eir] head and thrusts [ember eir] chest forwards, giving you a nice view of [ember eir] " + (flags[kFLAGS.EMBER_MILK] > 0 || hasVagina() ? "generous bosom" : "toned chest") + ". The fire reflecting on [ember eir] " + (flags[kFLAGS.EMBER_ROUNDFACE] == 0 ? "scales" : "skin") + " looks like little hands, touching and licking over [ember eir] nipples, twisting them in the most perverted ways, making Ember groan in pleasure...");
                outputText("\n\nBy now you've forgotten all about your tiredness, your eyes are glued to Ember as [ember ey] turns around and reaches down towards [ember eir] feet, keeping [ember eir] legs straight to finish stretching; [ember eir] tail lifts up in the air to help [ember em] balance [ember em]self, giving you a perfect view of [ember eir] handful of butt " + (hasVagina() ? "and the soft lips of [ember eir] pleasure hole" : "") + ".  When Ember lets out a moaning sigh of relief, you whimper; imagining yourself doing truly wonderful things with Ember in that particular position... Mesmerized by Ember's slowly curving back you take a step towards [ember em] knocking over a small pebble. Ember jumps a bit and looks at the source of the sound, only to spot you.");
                outputText("\n\n\"<i>Oh... hello [name]. I'll be going to bed soon, just need to drink a bit of water.</i>\"");
                outputText("\n\nYou simply nod and swallow hard... you want to blame your arousal on this world but, honestly, you're not entirely certain you wouldn't have felt this way after a display like that back in Ingnam.");
                outputText("\n\nEmber fetches a small water skin and lifts the open lid to [ember eir] lips, then [ember ey] begins kneading the skin, coaxing the fresh fluids inside into [ember eir] mouth; some of the water leaks through the sides of [ember eir] mouth, sliding down [ember eir] body and forming a small rivulet down [ember eir] chin, between [ember eir] " + (flags[kFLAGS.EMBER_MILK] > 0 || hasVagina() ? "soft mounds" : "toned chest") + " and gathering on [ember eir] small belly button.");
                outputText("\n\nA sudden, impossible urge to close the distance between the two of you and lick [ember em] dry flits into your mind, before you fiercely discard it.");
                outputText("\n\nEmber looks at you questioningly. \"<i>What's up, [name]?  Something wrong?</i>\"");
                outputText("\n\nYou wonder if Ember is doing this deliberately or unintentionally... dare you risk the dragon's temper by asking if [ember ey]'s flirting with you?  Finally, you decide to say that nothing's wrong, you're just tired.");
                outputText("\n\n\"<i>If that's the case, since you already came all the way here, maybe you should join me and come to bed too?</i>\"");
                outputText("\n\nWell... your " + camp.homeDesc() + " feels too far away to bother going there after this invitation, so you ask if Ember's okay with letting you crash with [ember em] for the night?");
                outputText("\n\n\"<i>Of course.  I did say you're welcome whenever you want.</i>\"");
                outputText("\n\nEmber heads inside [ember eir] den and drops on all fours... crawling towards [ember eir] nest, and waving [ember eir] tail side to side, moving with grace not unlike that of a cat.  [ember Ey] slowly circles [ember eir] nest and flops down, belly up, gently scratching [ember eir] neck and belly; then moving [ember eir] hands over [ember eir] nipples to press on [ember eir] " + ((hasVagina() || flags[kFLAGS.EMBER_MILK] > 0) ? "pillowy orbs" : "chest") + ", purring all the while, eyes closed.");
                outputText("\n\nEmber looks at you through half-lidded eyes and extends an arm towards you, inviting you to join [ember em].  You can't help but stare at the dragon, wondering yet again if [ember ey] is deliberately trying to provoke you, or you've just been in this over-sexed excuse for a world too long.  Deciding to just leave it in [ember eir] hands, you quietly approach and join the dragon in your " + camp.bedDesc() + "... and you can't help but wonder how it is you've become so blase about that.");
                outputText("\n\nEmber slowly wraps you in an embrace, clutching you tightly against [ember em] and whispers into your ear, \"<i>Good night, [name].</i>\" Then closes [ember eir] eyes and sighs as sleep finally overtakes [ember em].");
                outputText("\n\nYou have a hard time getting to sleep after these earlier scenes you've witnessed... and when you finally manage to shut your eyes all you can see is Ember... in various positions, beckoning you to join [ember em] and sate yourself...");
                dynStats("lus", 30, "scale", false);
            } else if (chooser == 2 && rand(2) == 0 && flags[kFLAGS.TIMES_SLEPT_WITH_EMBER] > 0) { //Bathtime, very LOOOOOOOOOOONG
                outputText("\n\nWondering if maybe Ember would like some company for the night, you approach the dragon's den, smiling wistfully at the ironies of life. Back in the village, tales of those who entered a dragon's den typically ended in the foolish intruder's gruesome death; here and now, though, there's few places that feel quite as safe.");
                outputText("\n\nEmber, seeing you approach, turns to greet you, rubbing [ember eir] sleepy eyes.  \"<i>[name]?  What do you want?</i>\"");
                outputText("\n\nYou tell the dragon you were simply curious if [ember ey] wanted some company in bed tonight.  Ember yawns and flashes you a brief smile; however [ember eir] expression changes once [ember ey] takes a second glance at you.  \"<i>Yes, I could use the company... and you could use a bath.  Look at yourself... you're all dirty after wandering about.</i>\"  [ember Ey] points at you for effect. ");
                outputText("\n\nYou pause and take a whiff of yourself... the dragon has a point.  You'd be kind of hard to sleep with even in your " + camp.homeDesc() + "; in the even closer confines of Ember's den, it'd be unbearable. You tell [ember em] that you're going to go and wash up... then, unable to resist a cheeky grin, you ask if [ember ey] would like to freshen up as well.  \"<i>Yes, but only because I want to make sure you're spotless,</i>\" Ember replies, taking your arm and leading you away to the nearest stream.");
                outputText("\n\nOnce you arrive at the banks of the stream, Ember strips you; and as [ember ey] neatly folds your [armor] [ember ey] shoots you a mischievous grin.  \"<i>Off you go!</i>\"  With a mighty push of [ember eir] tail you're sent crashing headfirst into the stream.  You quickly struggle for the surface, spit out water, and curse the dragon for [ember eir] trickery.  Come to think of it... you don't see Ember anywhere... where could [ember ey] have gone?");
                outputText("\n\nThe question doesn't linger for much longer, a great splash sends a wave of water crashing on your back.  You shake your head, sending damp locks of [haircolor] flapping wetly around, and look around to try and find the dragon who just dive-bombed you.  Once again you fail to spot Ember anywhere... how can something so big be so sneaky!?");
                outputText("\n\nSomething coils around your waist and pulls you back towards a pair of clawed hands, that begin busily scrubbing your [hair] with a syrupy solution of crushed flowers.  You struggle unthinkingly, not sure what's going on, but relax as the smell hits you.  It's clearly Ember doing this... but why is [ember ey] doing this, you ask?");
                outputText("\n\n\"<i>What a silly question... you don't expect to be clean after a quick dip in the water, do you?  Just let me work and I assure you'll be clean... in a few moments.</i>\" ");
                outputText("\n\nYou notice [ember ey]'s avoided answering the heart of your question, but decide to leave it alone.");
                outputText("\n\nBesides... this feels nice, and smells pretty good too.  Ember seems to be enjoying [ember em]self too... every once in awhile [ember eir] hands wander to touch you in various sensitive spots... you may not be able to see it in your current position, but you can almost feel Ember quiver at every one of [ember eir] wandering gropes.");
                outputText("\n\n\"<i>Turn around, I'm going to do your front now.</i>\"  Ember reaches towards a nearby bowl to gather more lotion in [ember eir] claws.");
                outputText("\n\nBreathing calmly, you turn around, gently sloshing through the water until you are facing your draconic lover.  A quick glance towards Ember confirms your suspicion; [ember ey] is almost giddy.  However Ember tries to at least look professional in [ember eir] task; [ember ey] starts by rubbing your " + breastDescript(0) + ", lingering a little longer than necessary on your " + nippleDescript(0) + ".");
                outputText("\n\n\"<i>How does it feel?  Better?</i>\"  Ember asks, trying to start a conversation. ");
                outputText("\n\nYou simply nod gently and close your eyes, enjoying the treatment and trying not to make this any more embarrassing for the emotionally insecure dragon.");
                outputText("\n\nEmber smiles.  \"<i>Good.</i>\" Slowly but surely making [ember eir] way towards your " + (player.hasCock() ? multiCockDescriptLight() : "") + (player.hasCock() && player.hasVagina() ? " and " : "") + (player.hasVagina() ? vaginaDescript() : "") + (player.gender == 0 ? "groin" : "") + ". ");
                outputText("\n\nYou shiver at the attention, even as your mind races.  Hmm... " + (flags[kFLAGS.EMBER_ROUNDFACE] == 0 ? "You note that Ember doesn't have hair herself, but this doesn't stop you reaching out and starting to gently stroke " + emberMF("his", "her") + " scalp instead." : "Deciding that fair is fair, you reach out and start to gently stroke through Ember's hair, gathering some of the same goo that [ember ey] was using in yours to wash it with.") + "");
                outputText("\n\n\"<i>H-hey!  I'm not the one who needs a bath!</i>\" Ember protests.");
                outputText("\n\nYou simply smile and tell [ember em] that you may as well do this while you're both together.  And maybe [ember ey] doesn't need a bath in quite the same way you do, but you have to profess, [ember eir] musk has been getting kind of strong recently.");
                outputText("\n\n\"<i>O-okay... Fine...</i>\" Ember concedes, finally reaching for your " + (player.hasCock() ? multiCockDescriptLight() : "") + (player.hasCock() && player.hasVagina() ? " and " : "") + (player.hasVagina() ? vaginaDescript() : "") + (player.gender == 0 ? "genderless crotch" : "") + ".  You knead and massage [ember eir] " + (flags[kFLAGS.EMBER_ROUNDFACE] == 0 ? "scalp" : "hair") + ", then start bringing your hands down, rubbing [ember eir] shoulders and neck before moving on to [ember eir] " + (hasVagina() || flags[kFLAGS.EMBER_MILK] > 0 ? "flat chest" : "sizable breasts") + ", gently playing with the dragon's nipples.");
                outputText("\n\nEmber shudders and you hear a faint sigh of pleasure.  \"<i>Y-you're supposed to be cleaning them!  Not playing with them!</i>\"  Ember scolds you.");
                outputText("\n\nYou comment innocently that you're simply making sure they're clean as possible, gently tracing " + (flags[kFLAGS.EMBER_MILK] > 0 || hasVagina() ? "one nipple" : "the heart-shaped mark on [ember eir] chest") + " with your finger.  Still, you decide you've teased [ember em] enough and start moving your hands further down, across [ember eir] " + (pregnancy.isPregnant ? "swollen" : "flat and muscular") + " belly.");
                outputText("\n\nEmber stops [ember eir] cleaning, and instead braces [ember em]self on the bank of the stream, leaning back to give you better access.  It seems like your roles have been reversed... not that you're complaining.  You stroke your fingers up and down [ember eir] " + (pregnancy.isPregnant ? "pregnant " : "") + "midriff, trailing lightly across the scales there, watching the dragon shiver eagerly as your ministrations arouse [ember em].  [ember Eir] " + emberGroinDesc("cock begins to " + (internalDick() ? "peek from its slit and" : "") + " grow erect", "vagina starts to grow moist, dribbling lubricants down [ember eir] legs to drip into the water") + ".  Tantalisingly, inch by inch, your hands drift down to the dragon's crotch, stopping just before you are touching [ember eir] genitals.");
                outputText("\n\n\"<i>T-that's enough... I can finish it myself,</i>\" Ember protests, sounding kind of weak.");
                outputText("\n\nYou tell [ember em] that if that's really the way [ember ey] feels... You let go of [ember em] and turn back towards the lake, " + (player.isNaga() || player.isGoo() ? "sliding" : "walking") + " out through the water to finish washing yourself off.  Before you get far you feel Ember's tail coil around your waist a second time.");
                outputText("\n\n\"<i>Your bath is not over yet!</i>\"  Ember declares, pulling you towards [ember em] and groping your [butt]; [ember eir] hands roam all over your lower body" + (player.gender > 0 ? ", and over your genitals as well" : "") + ".  Then finally with a small slap on your butt [ember ey] declares you clean.");
                outputText("\n\n\"<i>There you go... now I just have to finish cleaning myself.</i>\"  Ember reaches out for the bowl containing the flowery lotion, but before [ember ey] can lay a claw on it, you swipe the bowl and dip your hands inside.  She got to clean you up, so it's only fair you should do the same... before Ember can even utter a protest you begin groping and rubbing [ember eir] thighs.  Sliding your hands across [ember eir] legs and tail, before you finally reach out to your prize; Ember's " + emberGroinDesc("erect cock", "dripping pussy") + ".");
                outputText("\n\nYou rub salve delicately into [ember eir] " + emberGroinDesc("cock", "pussy") + ", stroking the " + emberGroinDesc("long " + (emberMF("male", "herm")) + " shaft", "the soft, wet walls of [ember eir] feminine sex") + ".  Ember gasps, but the pleasure is too much for [ember em] to utter any kind of protest.  You finish the job quickly and efficiently, not keen on teasing the dragon so much; so you smile and declare the dragon clean, once again heading towards the bank to gather your clothes.");
                outputText("\n\nDeciding to have a little fun, you make a show of bending over seductively, flirting your [butt] as you shake and scrape the water off of your skin and then gather your clothes.  You cast a flirtatious glance back over your shoulder to see how Ember took your little display; serves [ember em] right for groping you and getting you all turned on... and under the pretext of trying to clean you, too.");
                outputText("\n\nEmber's eyes are glued to your form, and it takes a short while for [ember em] to notice you looking, but once [ember ey] does; [ember ey] quickly turns away.");
                outputText("\n\n\"<i>Y-you should go ahead and wait in the den... I have to take care of something...</i>\"");
                outputText("\n\nYou give [ember em] an innocent smile, making it quite clear you know what [ember ey]'s going to do, and then head back, eager to get some sleep.  Once inside, you set yourself on Ember's nest and a few moments later Ember joins you.  [ember Ey] gives you a quick peck on the cheek and snuggle up to you, draping [ember eir] wing over the two of you and finally letting sleep claim [ember em]... you're only too happy to follow in suit... ");
            } else if (flags[kFLAGS.TIMES_SLEPT_WITH_EMBER] <= 0) { //First time sleeping!
                outputText("\n\nYou head to where Ember normally sleeps of a night, but, to your surprise, the dragon isn't there.  You wonder where [ember ey] is; a moonlit flight, maybe?  Giving up seeing [ember em] tonight, you turn to head back to your " + camp.homeDesc() + ", ready to catch some shuteye.");
                outputText("\n\nBefore you can get far however, Ember lands right behind you.  \"<i>[name]?  Did you want to see me?</i>\"");
                outputText("\n\nYou reply that, yes, you did. You wanted to make sure [ember ey]'s alright before turning in for the night.");
                outputText("\n\nEmber crosses [ember eir] arms.  \"<i>Hmph... What do you take me for?  A child?  I'm big enough to take care of myself and am perfectly fine, as you can see.</i>\"");
                outputText("\n\nSeeing that's clearly the case, you bid [ember em] goodnight and turn, beginning to head back to your " + camp.homeDesc() + " to get some rest.  Ember reaches for you shoulder, grabbing it before you have a chance to leave.  \"<i>But...</i>\"");
                outputText("\n\n\"<i>But</i>\" what, you reply?  \"<i>Since you seem to be so worried about me; there is a thing you could do for me.</i>\"  You ask [ember em] what that might?  Ember averts [ember eir] eyes and rubs the back of [ember eir] neck.  \"<i>Stay,</i>\" [ember ey] utters quietly.");
                outputText("\n\n...You beg [ember eir] pardon? Did [ember ey] really just ask you what you think you heard?");
                outputText("\n\n\"<i>Don't get any ideas!  This is not an invitation for you to do anything,</i>\" Ember hurriedly blurts out.  Then speaking on a softer tone, [ember ey] says, \"<i>I just don't feel like being by myself tonight.</i>\"");
                outputText("\n\nFor a moment, the old stories of the foolishness of walking into a dragon's den ring back inside your mind... but you dismiss them.  Ember's not like the dragons in your village's stories, though you can't help wonder what fucking [ember em] would be like if [ember ey] was, like, ten meters tall or something, and there's no danger in the act at all.  So, if [ember ey] really wants you to spend the night with [ember em]... why refuse?  You tell [ember em] that, if [ember ey] really wants you to sleep in [ember eir] den tonight, you're willing.");
                outputText("\n\n\"<i>Great, come on in.</i>\"  Ember smiles, extending an arm towards the entrance of [ember eir] den.  You squeeze your way in, as [ember ey] indicates, maneuvering yourself into the cool darkness within; behind you, you can hear your draconic lover following you.  \"<i>The bed is to your right.</i>\"  Ember notifies you.");
                outputText("\n\nYou seek it out in the gloom, and to help you Ember gently exhales a flickering tongue of flame, providing illumination enough that you can see the \"<i>bed</i>\" - though perhaps \"<i>nest</i>\" might be the better term.  It's a great pile of sweet-smelling leaves and grasses, a clear indentation of crushed foliage indicating the spot where Ember habitually rests herself. Stripping off whatever clothes you deem unneccessary, you sink into the surprisingly soft, comfortable vegetation and make yourself comfortable, being careful to avoid taking \"<i>Ember's spot</i>\".  Ember lays down beside you and embraces you into a hug, pulling you towards [ember eir] " + (flags[kFLAGS.EMBER_MILK] > 0 ? "bountiful," : "") + " scaly chest and right into [ember eir] \"<i>spot</i>\"... so much for trying to avoid it...");
                outputText("\n\nEmber gently drapes a wing over you, covering as much of you as [ember ey] can manage; [ember eir] tail coils around your [legs], softly constricting you.  \"<i>Comfy?</i>\"");
                outputText("\n\nYou reply that, yes, this is comfy, keeping to yourself the fact it's much comfier than you expected.  \"<i>Good...</i>\" Ember tightens [ember eir] hug, and after a brief silence [ember ey] says, \"<i>[name]... I... I want you to know that you're welcome here anytime.  Just in case you get tired of that frail, smelly " + camp.homeDesc() + " you sleep in...</i>\"");
                outputText("\n\nYou tell [ember em] that you'll keep that in mind... and then protest that your " + camp.homeDesc() + " is not smelly!  \"<i>Yeah... sure... whatever you say...</i>\"  Ember replies dismissively, though you can't help but catch just the slightest hint of sarcasm... but now is not the time nor the place to worry about this.  Maybe you should get your " + camp.homeDesc() + " washed sometime?");
                outputText("\n\nEmber yawns and finally bids you goodnight.  \"<i>Sleep well.</i>\"  You repeat the sentiment and, with a little disbelief, allow yourself to be snuggled up to, slowly drifting off to sleep.");
            } else {
                outputText("\n\nWondering if maybe Ember would like some company for the night, you approach the dragon's den, smiling wistfully at the ironies of life. Back in the village, tales of those who entered a dragon's den typically ended in the foolish intruder's gruesome death; here and now, though, there's few places that feel quite as safe.");
                outputText("\n\nEmber, seeing you approach, turns to greet you, rubbing [ember eir] sleepy eyes.  \"<i>[name]?  What do you want?</i>\"");
                outputText("\n\nYou tell the dragon you were simply curious if [ember ey] wanted some company in bed tonight.  Ember yawns and flashes you a brief smile.  \"<i>Yes... I could use the company... and I did say you could come over whenever you felt like it.  So... come on in.</i>\"  Ember supports [ember emself] on the entrance to [ember eir] den, waiting for you to step in.");
                outputText("\n\nYou follow the dragon inside, your memories allowing you to easily find and slip into Ember's bed of leaves, where you start peeling off and discarding your unwanted clothes before laying down and making yourself comfortable.");
                outputText("\n\nEmber follows in suit, embracing you as [ember ey] lays down and snuggling up as well as [ember ey] can.  \"<i>Good night, [name].</i>\"  [ember Ey] gently kisses your cheek.  \"<i>Sleep well.</i>\"");
                outputText("\n\nYou return the dragon's sentiment, repositioning yourself to hug [ember em] even as [ember eir] wing drapes itself over the pair of you like a blanket.");
            }
            outputText("\n\nYou plan to sleep for " + num2Text(timeQ) + " hours.");
            flags[kFLAGS.SLEEP_WITH] = "Ember";
            flags[kFLAGS.TIMES_SLEPT_WITH_EMBER]++;
            flags[kFLAGS.EMBER_MORNING] = 1;
        }
        emberAffection(3);
        doNext(camp.sleepWrapper);
    }

    public function postEmberSleep():void {
        flags[kFLAGS.EMBER_MORNING] = 0;
        clearOutput();
        outputText("You yawn and stretch, getting the kinks out of your body after a good night's sleep next to... Ember?");
        outputText("\n\nYou look about, but see no sign of the dragon... [ember ey]'s probably gone to get breakfast." + player.clothedOrNaked(".. looking to the side, you spot your [armorName] neatly folded beside the nest.") + "  Smiling to yourself, you " + player.clothedOrNaked("put on your [armorName] and ") + "get ready for another day...");
        doNext(playerMenu);
    }

    public function mishapsLunaEmber():void {
        clearOutput();
        outputText("As you call for Ember the dragon simply does not show up. You can see [ember em] in the sky searching angrily for something and even hear [ember em] swear in the distance. Whatever made Ember so mad you don’t want to know. You decide to call [ember em] later so to avoid getting yourself burned as [ember ey] indeed start to torch the landscape at random.\n\n");
        if (player.hasStatusEffect(StatusEffects.CampLunaMishaps2)) player.addStatusValue(StatusEffects.CampLunaMishaps2, 2, 1);
        else player.createStatusEffect(StatusEffects.CampLunaMishaps2, 0, 1, 0, 0);
        if (!player.hasStatusEffect(StatusEffects.LunaWasCaugh)) player.createStatusEffect(StatusEffects.LunaWasCaugh, 1, 0, 0, 0);
        else player.addStatusValue(StatusEffects.LunaWasCaugh, 1, 1);
        if (player.statusEffectv1(StatusEffects.LunaWasCaugh) == 3) outputText("<b>That's it, you're sure of it now, it's all Luna's doing!</b>\n\n");
        doNext(playerMenu);
    }
}
}
