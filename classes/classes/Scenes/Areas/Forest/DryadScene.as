/**
 * @author melchi.
 * Ported from UEE to CoCX by Svalkash.
 */
package classes.Scenes.Areas.Forest {
import classes.*;
import classes.BaseContent;
import classes.display.SpriteDb;
import classes.Scenes.SceneLib;

public class DryadScene extends BaseContent {

    public function fightagainstdryad():void {
        spriteSelect(SpriteDb.s_dryad);
        outputText("Walking up to where you heard the rustling, you notice what looks like a tree.   This tree appears to be wearing a dress made of leaves and straw.  You take a step closer and notice the tree has the silhouette of a slender woman.   Taking yet another step closer, you see this tree looks more like a person than a tree.   Her hair is thin vines with leaves growing off of them and she has a human-like face,  mouth, wooden arms, hands with claw-like fingers, legs and feet.   Before you can decide what to think her eyes pop open, glowing red, hungry eyes. . . Her lips curl into a wicked smile and she lunges at you! ");
        startCombat(new Dryad());
    }

    public function winagainstdryad():void {
        clearOutput();
        outputText("The dryad creaks like old wood as she collapses to the ground, too [if (monster.HP <= 0)injured|aroused] to continue fighting. ");
        menu();
        if (player.hasCock() && player.lust >= 33) {
            outputText("\n\nWhile gazing on her prone figure carnal desire wells up inside you.   Do you have your way with her? ");
            addButtonIfTrue(0, "Fuck Her", fuckHer, "Req. a cock.", player.hasCock());
            addButtonIfTrue(1, "Make Lick", makeLick, "Req. a vagina.", player.hasVagina());
        }
		else outputText("You're not aroused enough to rape her!");
        addButtonIfTrue(3, "Tame It", SceneLib.campMakeWinions.tamingAttempt, "Req. to have Job: Tamer", player.hasPerk(PerkLib.JobTamer));
		addButton(4, "Leave", cleanupAfterCombat);
    }

    //What the fucking placeholder it is?
    public function makeLick():void {
        clearOutput();
        outputText("You saunter over to the defeated dryad and roughly grab her by the hair.  \n  'Lick it!' you demand and she complies.   You keep her licking until you are satisfied then toss her aside and head back to camp smelling of tree sap.");
        player.sexReward("saliva", "Vaginal");
        dynStats("cor", 0.25);
        cleanupAfterCombat();
    }

    //What the fucking placeholder it is?
    public function fuckHer():void {
        clearOutput();
        outputText("Crouching down beside her, you run your hands up her legs pulling her dress up while doing so.   Seeing her girly parts exposed, you remove your armor and whip out your member.  You roll her onto her stomach and place both hands on her hips.   Throwing caution into the wind, you roughly plow her and immediately regret it.   Your [cock] receives numerous splinters and pull out receiving even more.   You stagger from the pain and limp back to camp. ");
        //TODO: maybe add something alternative for "tougher" cocks? Or alt scene for dryads.
        player.dynStats("lus", -10, "scale", false);
        player.takeDamage(20);
        player.addCurse("lib", 2, 2);
        cleanupAfterCombat();
    }

    public function loseTodryad():void {
        clearOutput();
        outputText("Too badly " + (player.HP <= 0 ? "injured" : "aroused") + " by the dryad, you give in  and let her she wants to you.\n\n");
        if (player.hasCock()) {
            outputText("The dryad rushes towards you and wraps her arms around you.   Her bark-like skin is cold and rough.   Your bodies entangle as her sap rubs onto your person.    She places a hand behind your head and locks eyes with you.   Her glowing red eyes burn desire into your skull.   Her lips part and she frenchs you deeply.\n\n");
            outputText("Seeing you suitably aroused, she tears into your clothing until your [cock]  is exposed.\n");
            outputText("'Pollinate me' !  she demands hungrily.");
            outputText("She places her hand on your [cock] and sticky sap oozes from her palm lubricates your member.\n");
            outputText("Greedily, her hand jerks your member until you feel like you are about to burst.   She senses this and kneels in front of your [cock].   Her leaf hair falls down in front of her face as you spray all over her hair and face.\n");
            outputText("Satisfied, she stands up and looks at you one last time 'I will to shed a thousand seeds.'   As she steps away her leaf-hair seems to brighten and flowers start to bud from her locks.");
            player.sexReward("no", "Dick");
        } else {
            outputText("The dryad sees that you no longer have the ability to fight.   You open your mouth to say something but she kisses you to keep you from talking.    Thus, your words come out as a surprised squeaking sounds.   She works her way around your body kissing and groping as she goes.   She continues working away until you are a shuddering mess in her arms.");
            player.sexReward("no");
        }
        outputText("\n\nYou wake up several hours later wondering what just happened.");
        cleanupAfterCombat();
    }
}
}
