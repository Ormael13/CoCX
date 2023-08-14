/**
 * Created by aimozg on 11.01.14.
 */
package classes.Items.Consumables {
import classes.BaseContent;
import classes.CoC;
import classes.EngineCore;
import classes.Items.Alchemy.AlchemyLib;
import classes.Items.Consumable;
import classes.Scenes.SceneLib;
import classes.internals.Utils;

public final class GroPlus extends Consumable {

    public function GroPlus() {
        super("GroPlus", "GroPlus", "a needle filled with Gro+", 50, "This is a small needle with a reservoir full of blue liquid.  A faded label marks it as 'GroPlus'.  Its purpose seems obvious.");
        refineableInto([], [[1, AlchemyLib.AE_GROW]]);
    }

    override public function useItem():Boolean {
        clearOutput();
        EngineCore.menu();
        outputText("You ponder the needle in your hand knowing it will enlarge the injection site.  What part of your body will you use it on?");
        if (player.hasCock()) EngineCore.addButton(0, "Cock", growPlusCock);
        if (player.hasBalls()) EngineCore.addButton(1, "Balls", pickDoses, growPlusBalls);
        EngineCore.addButton(2, "Breasts", growPlusBreasts);
        EngineCore.addButton(3, "Nipples", pickDoses, growPlusNipples);
        if (player.hasVagina()) EngineCore.addButton(4, "Clit", pickDoses, growPlusClit);
        EngineCore.addButton(5, "Butt", pickDoses, groPlusButt);
        EngineCore.addButton(6, "Hips", pickDoses, groPlusHips);
        EngineCore.addButton(14, "Never mind", growPlusCancel);
        return true;
    }

    private function sharedEnd(dose:int, sexual:Boolean = false):void {
        var d:int = dose;
        while (d-- > 0) player.slimeFeed();
        player.dynStats("lus", 10 * dose, "scale", false);
        if (sexual) player.addCurse("sen", 2 * dose, 1);
        if (dose > 1 && !CoC.instance.debug) player.consumeItem(game.consumables.GROPLUS, dose - 1); //eat up more gros
        game.mainViewManager.updateCharviewIfNeeded();
        SceneLib.inventory.itemGoNext();
    }

    private function growPlusBalls(dose:int):void {
        var d:int = dose;
        clearOutput();
        outputText("You sink the needle deep into your " + player.sackDescript() + ".  It hurts like hell, but you push down the plunger and the pain vanishes as the needles contents flow into you.\n\n");
        //1 in 4 BIG growth.
        if (Utils.rand(4) == 0) {
            outputText("You feel a trembling in your " + player.ballsDescriptLight() + " as the chemicals start to go to work.  You can tell they're going to be VERY effective.\n");
            while (d-- > 0) player.ballSize += Utils.rand(4) + 2;
            outputText("They shift, stretching your " + player.sackDescript() + " tight as they gain inches of size.  You step to steady yourself as your center of balance shifts due to your newly enlarged " + player.ballsDescriptLight() + ".  ");
        } else {
            while (d-- > 0) player.ballSize += Utils.rand(2) + 1;
            outputText("You feel your testicles shift, pulling the skin of your " + player.sackDescript() + " a little bit as they grow to " + player.ballsDescriptLight() + ".  ");
        }
        if (player.ballSize > 10) outputText("Walking gets even tougher with the swollen masses between your legs.  Maybe this was a bad idea.");
        sharedEnd(dose, true);
    }

    private function growPlusBreasts():void {
        if (player.breastRows.length == 1) pickDB(1);
        else {
            clearOutput();
            outputText("Which breast row would you want to use Gro+ on?");
            BaseContent.pickANumber(pickDB, 1, player.breastRows.length, useItem);
        }

        //==========================

        function pickDB(row1:int):void {
            pickDoses(curry(inject, row1));
        }

        function inject(row1:int, dose:int):void {
            var d:int = dose;
            clearOutput();
            outputText("You sink the needle into the flesh of your " + player.allBreastsDescript() + " injecting one of the rows with a portion of the chemical.");
            while (d-- > 0) player.growTits(Utils.rand(5) + 1, row1, d == 1, 4);
            sharedEnd(dose);
        }
    }

    private function growPlusClit(dose:int):void {
        clearOutput();
        outputText("You sink the needle into your clit, nearly crying with how much it hurts.  You push down the plunger and the pain vanishes as your clit starts to grow.\n\n");
        player.clitLength += dose;
        outputText("Your " + player.clitDescript() + " stops growing after an inch of new flesh surges free of your netherlips.  It twitches, feeling incredibly sensitive.");
        sharedEnd(dose, true);
    }

    private function growPlusCock():void {
        if (player.cocks.length == 1) pickPlace(1);
        else {
            clearOutput();
            outputText("Which dick would you want to use Gro+ on?");
            BaseContent.pickANumber(pickPlace, 1, player.cocks.length, useItem);
        }

        //==========================

        function pickPlace(dick1:int):void {
            clearOutput();
            outputText("Where would you like to inject the needle?");
            EngineCore.menu();
            EngineCore.addButton(0, "Tip(+Len)", pickDoses, curry(inject, dick1 - 1, "tip"));
            EngineCore.addButton(1, "Side(+Thick)", pickDoses, curry(inject, dick1 - 1, "side"));
            EngineCore.addButton(2, "Base(+Both)", pickDoses, curry(inject, dick1 - 1, "base"));
            EngineCore.addButton(4, "Back", useItem);
        }

        function inject(dick:int, part:String, dose:int):void {
            clearOutput();
            outputText("You sink the needle into the " + part + " of your [cock " + (dick + 1) + "].  It hurts like hell, but as you depress the plunger, the pain vanishes, replaced by a tingling pleasure as the chemicals take effect.\n\n");
            if (part == "tip") {
                outputText("Your [cock " + (dick + 1) + "] twitches, pouring more than an inch of new length from your " + (player.hasSheath() ? "sheath." : "crotch."));
                player.growCock(dick, 6 * dose);
            } else if (part == "side") {
                outputText("Your [cock " + (dick + 1) + "] now feels noticeably wider.");
                player.thickenCock(dick, 1.5 * dose);
            } else if (part == "base") {
                outputText("Your [cock " + (dick + 1) + "] twitches, becoming thicker and longer at the same time");
                player.growCock(dick, 4 * dose);
                player.thickenCock(dick, 1 * dose); //AFTER growth!!!
            }
            sharedEnd(dose, true);
        }
    }

    private function growPlusNipples(dose:int):void {
        var d:int = dose;
        clearOutput();
        outputText("You sink the needle into each of your " + player.nippleDescript(0) + "s in turn, dividing the fluid evenly between them.  Though each injection hurts, the pain is quickly washed away by the potent chemical cocktail.\n\n");
        //Grow nipples
        outputText("Your nipples engorge, prodding hard against the inside of your " + player.armorName + ".  Abruptly you realize they've grown more than an additional quarter-inch.\n\n");
        while (d-- > 0) {
            player.nippleLength += (Utils.rand(2) + 3) / 10;
            //NIPPLECUNTZZZ
            if (game.transformations.NipplesFuckable.isPossible() && Utils.rand(4) == 0) {
                game.transformations.NipplesFuckable.applyEffect();
            }
        }
        sharedEnd(dose, true);
    }

    private function groPlusButt(dose:int):void {
        clearOutput();
        outputText("You sink the needle into your [butt], trying to perfectly balance the amount between the different parts. Though each injection hurts, the pain is quickly washed away by the potent chemical cocktail.\n\n");
        outputText("You feel a bit of additional weight on your backside as your [butt] gains a bit more padding.");
        player.butt.type += dose;
        sharedEnd(dose);
    }

    private function groPlusHips(dose:int):void {
        clearOutput();
        outputText("You sink the needle into your [hips], trying to perfectly balance the amount between both sides. Though each injection hurts, the pain is quickly washed away by the potent chemical cocktail.\n\n");
        outputText("You stumble as you feel your [hips] widen, altering your gait slightly.");
        player.hips.type += dose;
        sharedEnd(dose);
    }

    private function growPlusCancel():void {
        clearOutput();
        outputText("You put the vial away.\n\n");
        SceneLib.inventory.returnItemToInventory(this);
    }

    private function pickDoses(fun:Function):void {
        var cnt:int = player.itemCount(game.consumables.GROPLUS) + 1;
        if (cnt == 0) fun(1);
        else {
            clearOutput();
            outputText("How many doses would you like to use?");
            BaseContent.pickANumber(fun, 1, cnt, useItem);
        }
    }
}
}
