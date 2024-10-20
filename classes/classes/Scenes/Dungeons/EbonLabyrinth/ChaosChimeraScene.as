
package classes.Scenes.Dungeons.EbonLabyrinth
{
import classes.BaseContent;
import classes.EventParser;
import classes.StatusEffects;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;

public class ChaosChimeraScene extends BaseContent {
    public function ChaosChimeraScene() {}
    
    public function encounter():void {
        clearOutput();
        camp.codex.unlockEntry(kFLAGS.CODEX_ENTRY_CHIMERA);
        outputText("You finally find the center of the labyrinth, somewhat exhausted. You can see the rose from here in all its dark beauty. As you are about to approach it, a monstrous creature lands right in front of you. This beast has no less than four heads! A dragon on the left, a lion in the center, a goat on ");
        outputText("the right and, at the tip of its tail, the head of a snake! All four heads roar a warning at you as the beast stands up on its leonine legs, easily twelve feet tall, its massive wings opening in a threatening display revealing nothing short of four erect thirty inches cock already drooling precum!\n\n");
        outputText("\"<i>Foolish intruder, you've walked to your death. You come seeking the rose? Let's see how long your search lasts once you're in the belly of the beast!</i>\"\n\n");
        outputText("<b>It's too late to run as you're fighting the chaos chimera!</b>");
        startCombat(new ChaosChimera(), true);
    }

    public function defeatedBy():void {
        clearOutput();
        if (player.isGoo()) {
            outputText("You fall down in a puddle, defeated and the Chimera approaches you.\n\n");
            outputText("\"<i>Meh, I retire what I said, you're likely not edible! However, I'm not done with you yet.</i>\"\n\n");
            outputText("Its four cocks rise to full mast and you know what will follow. Normally, such a length should terrify you, however, the idea of taking in such a large amount of fluids is way too delicious for you to pass on. You gush toward the monster’s dicks and open wide, ");
            outputText("inserting the quad cocks in your jelly-like body as you shape yourself to accommodate the beast. The chimera is swift to respond, fucking your throat, two breasts, and pussy with beastial fervor.\n\n");
            outputText("\"<i>Aaaaaarh this is perfect. Slimes are poor meals but make for ideal cocksleeves!</i>\"\n\n");
            outputText("Your body shape is bloated with the chimera dicks, deforming into a messy puddle, but this quad penetration is the best fuck you ever had. Soon the beast erupts into your form, flooding your body with at least its size equivalent in cum. You slowly slide off his cocks examining yourself in amazement. ");
            outputText("What an intake of fluid! Your insides were dyed white and now they are slowly returning back to your original color as you metabolize the nutrients… This fuck alone helped you recover from the battle. You're about to challenge the beast to a rematch but you are so full you instead fall asleep. ");
            outputText("You have no knowledge of what happened next but when you woke up you're at the labyrinth entrance, still alive. You can only guess after having its way with you, the Chimera had no interest in keeping you here. It seems you will have to start over.\n\n");
            player.HP = player.maxHP();
            //no 'start over', go to camp and relax
            doNext(SceneLib.dungeons.ebonlabyrinth.enterDungeon);
        }
        else {
            sceneHunter.print("Check failed: Goo body.");
            outputText("As you fall down defeated you register the chimera approaching your prone body, a sadistic smile on each of its heads as its four cocks rise to full mast. These things... they're way too big, you will likely be split apart! You’re brutally thrown on your back the beast aligning with your holes and...\n\n");
            outputText("What follows is too horrible to describe with words alone as the monster raped you with such bestial brutality, you were almost grateful it sent you to the afterlife before meal time.");
            if (SceneLib.shouldraFollower.followerShouldra() && !player.hasStatusEffect(StatusEffects.ShouldraOff)) {
                outputText(" Well surprisingly, thanks to Shouldra’s swift action before your death, you did somehow partially survive the horrible experience at the cost of yourself becoming a ghost. However, without a physical body to prolong your adventure all you are left with ");
                outputText("is haunting the labyrinth and possessing the body of its many denizens and or occasional adventurers for fun. Not that Shouldra ever disapproved of it.");
            }
            outputText("\n\n");
            //[GAME OVER]
            EventParser.gameOver();
        }
    }

    public function defeat():void {
        clearOutput();
        outputText("You stand victorious over the beast as you finish the abomination off, avenging all of the people it’s killed. You use the Snake neck of the chimera in order to cover the rose’s deadly thorns, so as not to prick yourself, and head back to camp with your prize.\n\n");
        awardAchievement("Four heads better then one", kACHIEVEMENTS.DUNGEON_DUNGEONMASTER);
        flags[kFLAGS.ALVINA_FOLLOWER] = 18;
        cleanupAfterCombat();
    }
}
}