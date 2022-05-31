
package classes.Scenes.Dungeons.EbonLabyrinth
{
import classes.BaseContent;
import classes.EventParser;
import classes.StatusEffects;

public class DarkSlimeEmpressScene extends BaseContent {
    public function DarkSlimeEmpressScene() {}

    public function encounter():void {
        clearOutput();
        outputText("As you enter the next room, the first thing you hear are the moans. You’re greeted to quite a sight for before you hundreds of slimy shape are making out, fucking each other in the most blatently obsene display you've ever seen. Confused, you try and figure if you stepped into some kind of orgy until you notice one slime at the back of the room who stands out. ");
        outputText("Wearing a crown seemingly made of goop, this regal purple woman sits on a pair of stone slabs, which serves it as a makeshift throne.\n\n");
        outputText("\"<i>Why now my loyal subjects, it seems we have a guest, welcome to my domain intruder I hope you intend on joining the feast in my honor of course. Guests… are always welcome.</i>\"\n\n");
        outputText("All of the slime suddenly drop their activities, drooling at you with keen interest. You've got a very bad feeling. This is when you notice that all of them are linked to one another through small trails of slime on the ground. The slimes take on a makeshift formation, drawing what appears to be slimy spears and bows all pointed at you.\n\n");
        outputText("Seeing this, you try to run for it but the purple empress waves her hand, slime sealing shut the exit behind you, the only exit out of this room. The slime giggles, the crowd imitating it shortly.\n\n");
        outputText("\"<i>I hope you are in the mood because you and I are soon going to become very intimate.</i>\"\n\n");
        outputText("<b>It's too late to escape now, it's a fight!</b>");
        startCombat(new DarkSlimeEmpress(), true);
    }
    
    public function defeatedBy():void {
        clearOutput();
        outputText("As you fall defeated the slimes all cover you, encasing you in jelly.\n\n");
        outputText("\"<i>It is but customary that one should bow or kneel before their empress. Some punishment is in order.</i>\"\n\n");
        outputText("The slime begins to violate you in every way possible. You want to scream in pleasure but when you do the slime takes advantage of your open mouth to pour down your throat. You feel yourself melt and dissolve as your memory and mind become increasingly confused. You are [name] but at the same time you are Clarissa, Elisabeth and Sabrina, a hundred confusing names ");
        outputText("float into your mind until you finally understand. You are one but many, everything and nothing, just one consciousness amongst the hundreds that live within the empress’s immortal jelly. Your body is made of slime but there is only one core to rule them all, the core of your beloved empress. ");
        outputText("The first order she gives is an easy one, to resume the feast and you’re all too happy to partake. A few months later a new human will visit this hall, it will be your greatest pleasure to give him or her a warm, gooey welcome.\n\n");
        //[GAME OVER]
        EventParser.gameOver();
    }
    public function defeat():void {
        clearOutput();
        outputText("The empress’s purple legion falter for an instant, the slime blocking the exit falling off. You don't wait for the sovereign to recover her composure and rush for the exit, the empress screaming orders as you leave. Thankfully slimes are not overly fast and you manage to make it back to the corridor junction you came from.\n\n");
        if (player.hasStatusEffect(StatusEffects.TFDealer1) && player.statusEffectv1(StatusEffects.TFDealer1) < 1) player.addStatusValue(StatusEffects.TFDealer1, 1, 1);
        else player.createStatusEffect(StatusEffects.TFDealer1, 1, 0, 0, 0);
        cleanupAfterCombat();
    }
}
}
