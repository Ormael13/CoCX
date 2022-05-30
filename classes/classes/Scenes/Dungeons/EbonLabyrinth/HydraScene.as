
package classes.Scenes.Dungeons.EbonLabyrinth
{
import classes.BaseContent;
import classes.EventParser;
import classes.GlobalFlags.kFLAGS;
import classes.StatusEffects;
import classes.display.SpriteDb;

public class HydraScene extends BaseContent {
    public function HydraScene() {}

    public function encounter():void {
        clearOutput();
        camp.codex.unlockEntry(kFLAGS.CODEX_ENTRY_HYDRA);
        spriteSelect(SpriteDb.s_hydra_16bit);
        outputText("The first telltale that something might have gone really wrong is the hissing, which seems to come from all around the room. The only warning you get of the impending attack is a sudden move of the shadows as a massive snake head bites the air mere inches from your face. You ready for battle as several huge snakes comes out of the shadow, each connected to a single junction to what appears to be the body of a very tall woman.\n\n");
        if (player.isNaga()) {
            outputText("\"<i>Why, would you look at that, how did you little grass snake make it all the way here. Are you perhaps lost?</i>\"\n\n");
            outputText("Sometimes you forget that as a naga your body language allows you to understand snakes of all kinds. You reply to the hydra that you're exploring the labyrinth in search of power and treasures.\n\n");
            outputText("\"<i>Um well there's no treasure I know of in this room but perhaps if you can help me with my arousal problem I’d be willing to give you something close to the first. A hydra scale, nothing short, nothing less. That is of course if becoming like me is of any interest to poor puny you. So how about it?</i>\"\n\n");
            if (player.hasStatusEffect(StatusEffects.TFDealer1) && player.statusEffectv2(StatusEffects.TFDealer1) < 1) player.addStatusValue(StatusEffects.TFDealer1, 2, 1);
            else player.createStatusEffect(StatusEffects.TFDealer1, 0, 1, 0, 0);
            menu();
            addButton(1, "Sex", sex);
            addButton(2, "Pass", pass);
            addButton(3, "Fight", startCombat, new Hydra(), true);
        }
        else {
            sceneHunter.print("Check failed: Naga lower body.");
            outputText("She hisses in perfect coordination with the snakes, her slitted eyes fixating you obsessively, as a drooling gaping slit at the junction between the snakes and her human body tells you exactly what she wants from you. You don't feel you should indulge her however and as such ready to battle.\n\n");
            startCombat(new Hydra(), true);
        }
    }

    public function sex():void {
        outputText("Clearly no cock in the world aside from those of a giant way bigger then your own size would ever fit her massive cunt. This said you got something way bigger then a cock. Her eyes widen and she drools from all six mouths in anticipation as you coil your tail around a nearby wooden log into a spring shape. You made a fleshy dildo three meters long and at least 20 inch thick just for her.\n\n");
        outputText("Without asking for permission the horny hydra picks up your coiled tail and shove it inside her gaping maw of a cunt using your entire tail length up to the thigh to fuck herself like never before. You take great care not to uncoil your tail until your feel her clamping and drenching you all the way to the shoulder in giantess juices. The hydra, now fully satisfied pulls you out and depose you on the ground.\n\n");
        outputText("\"<i>Oh god, it's been so long since I last touched myself. Here you may have this.</i>\"\n\n");
        outputText("She hands you a large scale easily as big as your hand making it clear that you must eat it to gain its power before waving you off.\n\n");
        outputText("\"<i>Stay safe down here little grass snake, not everyone is friendly and I’d hate to think you could be eaten.</i>\"\n\n");
        inventory.takeItem(consumables.HYDRASC, playerMenu);
    }

    public function pass():void {
        outputText("You decline politely but say you will think about it. The semi disappointed hydra shrugs and lets you exit the room.\n\n");
        doNext(playerMenu);
    }
    
    public function defeatedBy():void {
        clearOutput();
        outputText("You fall to the ground in a heap, absolutely defeated. You barely register her shadow towering above your prone form as she picks you up like a doll and proceeds to pull you toward her gaping pussy, lights soon shuts out as you’re squeezed and rammed deeper and deeper past the entrance until you no longer see it. This will sadly eventually prove to be a one way trip as you reach an area even her hands cannot reach, ");
        outputText("vanishing within her fleshy depths were the lack of oxygen will eventually get the better of you.\n\n");
        //[GAME OVER]
        EventParser.gameOver();
    }
    
    public function defeat():void {
        clearOutput();
        outputText("You thought you had won but, to your frustration, the hydra just keeps on regenerating its wounds. It’s incapacitated for now but it could get back up ready to attack at anytime. You grab a token of her defeat and run for the room exit, back to the previous junction.\n\n");
        if (player.hasStatusEffect(StatusEffects.TFDealer1) && player.statusEffectv2(StatusEffects.TFDealer1) < 1) player.addStatusValue(StatusEffects.TFDealer1, 2, 1);
        else player.createStatusEffect(StatusEffects.TFDealer1, 0, 1, 0, 0);
        cleanupAfterCombat();
    }
}
}