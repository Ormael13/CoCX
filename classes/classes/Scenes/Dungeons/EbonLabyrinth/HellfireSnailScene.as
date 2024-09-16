
package classes.Scenes.Dungeons.EbonLabyrinth
{
import classes.BaseContent;
import classes.EventParser;
import classes.GlobalFlags.kFLAGS;
import classes.PerkLib;
import classes.StatusEffects;

public class HellfireSnailScene extends BaseContent {
    public function HellfireSnailScene() {}

    public function encounter():void {
        clearOutput();
        if ((player.hasPerk(PerkLib.FireAffinity) || player.hasPerk(PerkLib.FireShadowAffinity) || player.hasPerk(PerkLib.AffinityIgnis)) && flags[kFLAGS.HELLFIRE_SNAIL_ENC] == 1) {
            outputText("You turn the corner expecting to run into yet another monster out to badly hurt you but sigh in relief as you run into the fire snail girl instead.\n\n");
            outputText("\"<i>Hey it's you again. Having fun down there?</i>\"\n\n");
            outputText("Well you could say that, in a way, yes you are having fun down there.\n\n");
            outputText("\"<i>So uh I've been getting antsy of late could you help me out with…</i>\"\n\n");
            outputText("You shut her up right away with a smoldering kiss of your own. Burning pleasure running down your spine as she covers you with her blanket like undercarriage. You return her hug by gently imprinting your hands into her generous breasts. ");
            hellfireSnailSex();
            inventory.takeItem(consumables.FSNAILS, playerMenu);
            return;
        }
        else if (flags[kFLAGS.HELLFIRE_SNAIL_ENC] == 1) sceneHunter.print("Check failed: Fire Affinity perk!");
        outputText("As you turn the corner, you run into what appears to be a massive rock blocking the passage. You try to move it but"+(player.tallness < 120 ? " to no avail the thing is as heavy as it looks. Your hand begins to burn up as":"")+" the rock suddenly raise in temperature and you swiftly remove them before being burnt. You are set on your guard as a feminine voice calls out.\n\n");
        outputText("\"<i>Hey who's the pervert molesting my ass!?! This is most unfair! Share back the fun!</i>\"\n\n");
        outputText("The rock now red with heat begins to seethe magma as something not unlike a reddish tail slides out from beneath it. On the other side the torso of a comely humanoid woman appears or you would call it human if not for the red skin, glowing ember eyes, drooling mouth and two antenna poking from the front atop her blazing hair! ");
        outputText("The volcanic snail girl eyes you with the kind of drooly obsessed expression you've only seen on slime girls and her intentions become clear as day, she intends to force herself on you!");
        if (flags[kFLAGS.HELLFIRE_SNAIL_ENC] < 1) flags[kFLAGS.HELLFIRE_SNAIL_ENC] = 1;
        startCombat(new HellfireSnail(), true);
    }

    public function defeatedBy():void {
        clearOutput();
        outputText("The snail girl catches you before you even hit the floor, a wide gooey smile on her face.\n\n");
        outputText("\"<i>Aw, no need to be so aggressive, I know exactly what you need! A BIG warm hug!</i>\"\n\n");
        if (player.hasPerk(PerkLib.FireAffinity) || player.hasPerk(PerkLib.AffinityIgnis)) {
            outputText("No way, she's going to hug you!? You scream in panic trying to get free but it's pointless as she has you beneath her shell now. However friendly she is, your body isn't made to endure such crazy heat. Or is it? To your surprise you actually feel comfortable in her grasp and even begin to relax, returning the hug and gently imprinting your hands into her generous breasts.");
            hellfireSnailSex();
            monster.createPerk(PerkLib.NoGemsLost, 0, 0, 0, 0);
            inventory.takeItem(consumables.FSNAILS, cleanupAfterCombat);
        }
        else {
            outputText("No way, she's going to hug you!? You scream in panic, trying to get free but it's pointless as she has you beneath her shell now. However friendly she is, your body isn't made to endure such crazy heat. You perish in silence, your screams muffled by her massive chest as you pretty much disintegrate into her arms. You’re long dead before the lonely snail even realises she's hugging ashes.\n\n");
            //[GAME OVER]
            EventParser.gameOver();
        }
    }

    public function defeat():void {
        clearOutput();
        outputText("You beat up the snail girl so hard her shell end upside down! She desperately tries to get back on her belly but is stuck swinging from side to side, you get the opportunity to run past her.\n\n");
        if (player.hasStatusEffect(StatusEffects.TFDealer1) && player.statusEffectv3(StatusEffects.TFDealer1) < 1) player.addStatusValue(StatusEffects.TFDealer1, 3, 1);
        else player.createStatusEffect(StatusEffects.TFDealer1, 0, 0, 1, 0);
        cleanupAfterCombat();
    }

    public function hellfireSnailSex():void {
        advanceMinutes(15);
        outputText("The snail giggles at your pleasant attention and begin to grind her lubricated pussy against "+(player.hasCock() ? "your burning cock" : "yours")+" in earnest. Blazing goop and other fluids begins to mingle as the two of you make it out the other residents of the labyrinth either oblivious or too scared to interfere with your smoldering mating session. ");
        outputText("This might also be because both of you spray fire and lava everywhere as part of mating and despite you both being immune to each other the unlooker likely wouldn't. The mating is deliberately slow, gentle and calculated with no single movement wasted as unlike most of Mareth denizen your current partner likes it nice and slow taking her time to make everything count.\n\n");
        outputText("You reach your peak and erupt in orgasm, your partner following short mere seconds after");
        if (player.hasCock()) outputText(" as you fill her smoldering lovehole with [race] seeds");
        if (!player.hasCock()) outputText(" as your girl juice mix with hers");
        outputText(".\n\n\"<i>Uwaaa so long since last I had real sex, most of my partners dies before I even reach the climax. Thank you so much hun for helping me out.</i>\"\n\n");
        outputText("Hey if this can help her be less of a hazard to everyone around her then why not, you're glad she appreciates it.\n\n");
        outputText("\"<i>Hey before you go have a vial of this, I don't know if you will find it useful but who knows.</i>\"\n\n");
        outputText("She hands you a vial of her saliva before you head out back in the labyrinth and resume your exploration.\n\n");
        player.sexReward("vaginalFluids", "Default");
    }
}
}
