/**
 * Created by aimozg on 11.01.14.
 */
package classes.Items.Consumables {
import classes.BaseContent;
import classes.CoC;
import classes.CockTypesEnum;
import classes.EngineCore;
import classes.Items.Alchemy.AlchemyLib;
import classes.Items.Consumable;
import classes.Scenes.SceneLib;
import classes.internals.Utils;

public final class Reducto extends Consumable {

    public function Reducto() {
        super("Reducto", "Reducto", "a salve marked as 'Reducto'", 30, "This container full of paste can be used to shrink a body part down by a significant amount.");
        refineableInto([], [
            [8, AlchemyLib.AE_SHRINK],
            [2, AlchemyLib.AE_REMOVE]
        ]);
    }

    override public function useItem():Boolean {
        clearOutput();
        EngineCore.menu();
        outputText("You ponder the paste in your hand and wonder what part of your body you would like to shrink.  What will you use it on?");
        if (player.hasCock()) EngineCore.addButton(0, "Cock", reductoCock)
            .disableIf(player.longestCockLength() <= 2 && player.thickestCockThickness() <= 0.5, "It can't shrink further!");
        if (player.hasBalls()) EngineCore.addButton(1, "Balls", pickDoses, reductoBalls)
            .disableIf(player.ballSize == 1, "They can't be any smaller!");
        if (player.biggestTitSize() > 0) EngineCore.addButton(2, "Breasts", reductoBreasts);
        EngineCore.addButton(3, "Nipples", pickDoses, reductoNipples)
            .disableIf(player.nippleLength <= 0.25, "Minimum size reached.");
        if (player.hasVagina()) EngineCore.addButton(4, "Clit", pickDoses, reductoClit)
            .disableIf(player.clitLength <= 0.25, "Minimum size reached.");
        EngineCore.addButton(5, "Butt", pickDoses, reductoButt)
            .disableIf(player.butt.type <= 1, "Not thick anymore.");
        EngineCore.addButton(6, "Hips", pickDoses, reductoHips)
            .disableIf(player.hips.type <= 2, "Already thin.");
        if (player.horns.count > 2) EngineCore.addButton(7, "Horns", shrinkHorns);
        EngineCore.addButton(14, "Never mind", reductoCancel);
        return true;
    }

    private function sharedEnd(dose:int, sexual:Boolean = false):void {
        player.dynStats("lus", -10 * dose, "scale", false);
        if (sexual) game.player.dynStats("sen", -2 * dose);
        if (dose > 1 && !CoC.instance.debug) player.consumeItem(game.consumables.REDUCTO, dose - 1); //eat up more reds
        game.mainViewManager.updateCharviewIfNeeded();
        SceneLib.inventory.itemGoNext();
    }

    private function reductoBalls(dose:int):void {
        var d:int = dose;
        clearOutput();
        outputText("You smear the foul-smelling paste onto your [sack].  It feels cool at first but rapidly warms to an uncomfortable level of heat.\n\n");
        while (d-- > 0) game.player.ballSize -= Utils.rand(4) + 2;
        if (game.player.ballSize < 1) game.player.ballSize = 1;
        outputText("You feel your scrotum shift, shrinking down along with your [balls].  Within a few seconds the paste has been totally absorbed and the shrinking stops.");
        sharedEnd(dose, true);
    }

    private function reductoBreasts():void {
        if (player.breastRows.length == 1) pickDB(1);
        else {
            clearOutput();
            outputText("Which breast row would you want to use Reducto on?");
            BaseContent.pickANumber(pickDB, 1, player.breastRows.length, useItem);
        }

        //==========================

        function pickDB(row1:int):void {
            pickDoses(curry(shrink, row1));
        }

        function shrink(row1:int, dose:int):void {
            var d:int = dose;
            var randProcs:int = 0;
            clearOutput();
            outputText("You smear the foul-smelling ointment all over your breasts, covering them entirely as the paste begins to get absorbed into your " + game.player.skinDesc + ".\n");
            while (d-- > 0) {
                game.player.shrinkTits(true, row1 - 1);
                if (Utils.rand(2) == 0) ++randProcs;
            }
            if (randProcs > 0 && game.player.breastRows[row1 - 1].breastRating >= 1) {
                outputText("\nThe effects of the paste continue to manifest themselves, and your body begins to change again...");
                while (randProcs-- > 0) game.player.shrinkTits(true, row1 - 1);
            }
            outputText("\nThe last of it wicks away into your skin, completing the changes.");
            sharedEnd(dose);
        }
    }

    private function reductoButt(dose:int):void {
        var d:int = dose;
        clearOutput();
        outputText("You smear the foul-smelling paste onto your [butt].  It feels cool at first but rapidly warms to an uncomfortable level of heat.\n\n");
        if (game.player.butt.type >= 15) outputText("Within seconds you feel noticeably lighter, and a quick glance shows your ass is significantly smaller.");
        else if (game.player.butt.type >= 10) outputText("You feel much lighter as your [butt] jiggles slightly, adjusting to its smaller size.");
        else outputText("After a few seconds your " + game.player.buttDescript() + " has shrunk to a much smaller size!");
        while (d-- > 0) {
            if (game.player.butt.type >= 15) game.player.butt.type -= (3 + int(game.player.butt.type / 3));
            else if (game.player.butt.type >= 10) game.player.butt.type -= 3;
            else game.player.butt.type -= Utils.rand(3) + 1;
        }
        if (game.player.butt.type < 1) game.player.butt.type = 1;
        sharedEnd(dose);
    }

    private function reductoClit(dose:int):void {
        var d:int = dose;
        clearOutput();
        outputText("You carefully apply the paste to your [clit], being very careful to avoid getting it on your [vagina].  It burns with heat as it begins to make its effects known...\n\n");
        while (d-- > 0) game.player.clitLength /= 1.7;
        if (game.player.clitLength < 0.25) game.player.clitLength = 0.25;
        //Set clitlength down to 2 digits in length
        game.player.clitLength = int(game.player.clitLength * 100) / 100;
        outputText("Your [clit] shrinks rapidly, dwindling down to almost half its old size before it finishes absorbing the paste.");
        sharedEnd(dose, true);
    }

    private function reductoCock():void {
        if (player.cocks.length == 1) pickPlace(1);
        else {
            clearOutput();
            outputText("Which dick would you want to use Reducto on?");
            BaseContent.pickANumber(pickPlace, 1, player.cocks.length, useItem);
        }

        //==========================

        function pickPlace(dick1:int):void {
            clearOutput();
            if (player.cocks[dick1 - 1].cockType == CockTypesEnum.BEE) {
                outputText("The gel produces an odd effect when you rub it into your [cock " + dick1 + "].  It actually seems to calm the need that usually fills you.  In fact, as your [cock " + dick1 + "] shrinks, its skin tone changes to be more in line with yours and the bee hair that covered it falls out.  <b>You now have a human cock!</b>");
                player.cocks[dick1 - 1].cockType = CockTypesEnum.HUMAN;
                player.dynStats("sen", -2, "lus", -10);
                SceneLib.inventory.itemGoNext();
            } else {
                outputText("Where would you like to apply the paste?");
                EngineCore.menu();
                EngineCore.addButton(0, "Tip(-Len)", pickDoses, curry(shrink, dick1 - 1, "tip"));
                EngineCore.addButton(1, "Side(-Thick)", pickDoses, curry(shrink, dick1 - 1, "side"));
                EngineCore.addButton(2, "Whole(-Both)", pickDoses, curry(shrink, dick1 - 1, "entirety"));
                EngineCore.addButton(2, "Knot", pickDoses, curry(shrink, dick1 - 1, "knot"))
                        .disableIf(!player.hasKnot(dick1 - 1), "No knot present!");
                EngineCore.addButton(4, "Back", useItem);
            }
        }

        function shrink(dick:int, part:String, dose:int):void {
            var d:int = dose;
            clearOutput();
            outputText("You smear the repulsive smelling paste over the " + part + " of your [cock " + (dick + 1) + "].  It immediately begins to grow warm, almost uncomfortably so, as your [cock " + (dick + 1) + "] begins to shrink.\n\n");
            if (part == "tip") outputText("Your can't believe your eyes - your [cock " + (dick + 1) + "] has lost several inches of its length!");
            else if (part == "side") outputText("Your feel your [cock " + (dick + 1) + "] bending slightly as it has become noticeably thinner!");
            else if (part == "entirety") outputText("Your [cock " + (dick + 1) + "] twitches as it shrinks, disappearing steadily into your " + (game.player.hasSheath() ? "sheath" : "crotch") + " until it has lost about some of its old length and thickness.");
            while (d-- > 0) {
                if (part == "knot") {
                    outputText("Your knot starts to swell, but before it could even reach its full size, it suddenly shrivels, striking you with an unexpected relief.");
                    player.cocks[dick].knotMultiplier -= 0.2;
                    if (player.cocks[dick].knotMultiplier <= 1.0) {
                        player.cocks[dick].knotMultiplier = 1.0;
                        outputText(" It takes a bit longer than expected, but after all the veins surrounding it turn pale, you finally see that the knot has disappeared!");
                    }
                } else if (part == "tip") {
                    outputText("Your can't believe your eyes - your [cock " + (dick + 1) + "] has lost around one third of its length!");
                    player.growCock(dick, -player.cocks[dick].cockLength / 3);
                } else if (part == "side") {
                    outputText("Your feel your [cock " + (dick + 1) + "] bending slightly as it has become noticeably thinner!");
                    player.thickenCock(dick, -player.cocks[dick].cockThickness / 3);
                } else if (part == "entirety") {
                    outputText("Your [cock " + (dick + 1) + "] twitches as it shrinks, disappearing steadily into your " + (game.player.hasSheath() ? "sheath" : "crotch") + " until it has lost about one fourth of its old length and thickness.");
                    player.growCock(dick, -player.cocks[dick].cockLength / 4);
                    player.thickenCock(dick, -player.cocks[dick].cockThickness / 4);
                }
            }
            sharedEnd(dose, true);
        }
    }

    private function reductoHips(dose:int):void {
        var d:int = dose;
        clearOutput();
        outputText("You smear the foul-smelling paste onto your [hips].  It feels cool at first but rapidly warms to an uncomfortable level of heat.\n\n");
        if (game.player.hips.type >= 15) outputText("Within seconds you feel noticeably lighter, and a quick glance at your hips shows they've gotten significantly narrower.");
        else if (game.player.hips.type >= 10) outputText("You feel much lighter as your [hips] shift slightly, adjusting to their smaller size.");
        else outputText("After a few seconds your [hips] have shrunk to a much smaller size!");
        while (d-- > 0) {
            if (game.player.hips.type >= 15) game.player.hips.type -= (3 + int(game.player.hips.type / 3));
            else if (game.player.hips.type >= 10) game.player.hips.type -= 3;
            else game.player.hips.type -= Utils.rand(3) + 1;
        }
        if (game.player.hips.type < 1) game.player.hips.type = 1;
        sharedEnd(dose);
    }

    private function reductoNipples(dose:int):void {
        var d:int = dose;
        clearOutput();
        outputText("You rub the paste evenly over your [nipples], being sure to cover them completely.\n\n");
        //Shrink
        while (d-- > 0) game.player.nippleLength /= 2;
        if (game.player.nippleLength < 0.25) {
            outputText("Your nipples continue to shrink down until they stop at 1/4\" long.");
            game.player.nippleLength = 0.25;
        } else outputText("Your [nipples] get smaller and smaller, stopping when they are roughly half their previous size.");
        sharedEnd(dose, true);
    }

    public function shrinkHorns():void {
        outputText("You doubt if the reducto is going to work but you apply the foul-smelling paste all over your horns anyways.\n\n");
        outputText("Incredibly, it works and you can feel your horns receding by an inch.");
        game.player.horns.count--;
        SceneLib.inventory.itemGoNext();
    }

    private function reductoCancel():void {
        clearOutput();
        outputText("You put the salve away.\n\n");
        SceneLib.inventory.returnItemToInventory(this);
    }

    private function pickDoses(fun:Function):void {
        var cnt:int = player.itemCount(game.consumables.REDUCTO) + 1;
        if (cnt == 0) fun(1);
        else {
            clearOutput();
            outputText("How many doses would you like to use?");
            BaseContent.pickANumber(fun, 1, cnt, useItem);
        }
    }
}
}
